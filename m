Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A697D3C1933
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jul 2021 20:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhGHSdG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jul 2021 14:33:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38508 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhGHSdF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jul 2021 14:33:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0542D22368;
        Thu,  8 Jul 2021 18:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625769023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5JxCvSrqYE4z8VN2lAV8aA9TJcgvNR/6b6LHXfBomro=;
        b=wyoyYZojg5uTH4zL577sgs8T1uC/qi2pT5F6ANFKjAlcDaHXqxTcOHVwPPm25+ni26qaE4
        Ng1RWTYpbYL7UfQku94e1QaPolKrhkvgZuiRJh0k7M4wP0Kseer63laWgYBXrZ9JXog9Aj
        0buzTsMPztBM9kE5gKFRv/Ou9VO5s8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625769023;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5JxCvSrqYE4z8VN2lAV8aA9TJcgvNR/6b6LHXfBomro=;
        b=dSgvzu6ewQDoXwOPJAcV4FlrLFgkcp0CPEUde//kuu5vmOOY/vFRQdxwKZduqgyiDnWsyu
        2wYmXPt6cZy1MyDg==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id ECB022C1FE;
        Thu,  8 Jul 2021 18:30:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C49BF1E62E4; Thu,  8 Jul 2021 20:30:22 +0200 (CEST)
Date:   Thu, 8 Jul 2021 20:30:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/4] ext4: Improve scalability of ext4 orphan file
 handling
Message-ID: <20210708183022.GB11179@quack2.suse.cz>
References: <20210616105655.5129-1-jack@suse.cz>
 <20210616105655.5129-5-jack@suse.cz>
 <20210630134635.fcdlsase45iotavs@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630134635.fcdlsase45iotavs@work>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 30-06-21 15:46:35, Lukas Czerner wrote:
> On Wed, Jun 16, 2021 at 12:56:55PM +0200, Jan Kara wrote:
> > @@ -28,28 +42,24 @@ static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
> >  		 */
> >  		return -ENOSPC;
> >  	}
> > -	oi->of_binfo[i].ob_free_entries--;
> > -	spin_unlock(&oi->of_lock);
> >  
> > -	/*
> > -	 * Get access to orphan block. We have dropped of_lock but since we
> > -	 * have decremented number of free entries we are guaranteed free entry
> > -	 * in our block.
> > -	 */
> >  	ret = ext4_journal_get_write_access(handle, inode->i_sb,
> >  				oi->of_binfo[i].ob_bh, EXT4_JTR_ORPHAN_FILE);
> >  	if (ret)
> >  		return ret;
> >  
> >  	bdata = (__le32 *)(oi->of_binfo[i].ob_bh->b_data);
> > -	spin_lock(&oi->of_lock);
> >  	/* Find empty slot in a block */
> > -	for (j = 0; j < inodes_per_ob && bdata[j]; j++);
> > -	BUG_ON(j == inodes_per_ob);
> > -	bdata[j] = cpu_to_le32(inode->i_ino);
> > +	j = 0;
> > +	do {
> > +		while (bdata[j]) {
> > +			if (++j >= inodes_per_ob)
> > +				j = 0;
> > +		}
> > +	} while (cmpxchg(&bdata[j], 0, cpu_to_le32(inode->i_ino)) != 0);
> 
> In case there is any sort of corruption on disk or in memory we can
> potentially get stuck here forever right ? Not sure if that matters
> all that much.
> 
> Other than that it looks good and negates some of my comments on the
> previous patch, sorry about that ;)
> 
> You can add
> 
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Good point. I've added some limitations (and cond_resched()) to the loop so
that we cannot loop indefinitely. Thanks for review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
