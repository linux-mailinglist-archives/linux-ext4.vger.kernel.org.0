Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA413ED197
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Aug 2021 12:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhHPKGU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Aug 2021 06:06:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49366 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhHPKGR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Aug 2021 06:06:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C734321E3D;
        Mon, 16 Aug 2021 10:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629108345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fTkeG6bJXMshF/esefDOyz4MmK4jqeIJN3ZmUuKvdN0=;
        b=cy4+aRzF2Fo5vhx02UatpYM3C5k3gpUtrZkI+R7wAkmnEsZ1m06rXVmxNQgrpB4Jt4xhOc
        t4abY+NolW0Mq4+fh87GP1CbsbbP3wPHVClkBbS38k6mr0gyn1HQ3d4yMg+PDB8zqoWLlN
        fg/Foams+Z9090VMZUOSIsm699pT1+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629108345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fTkeG6bJXMshF/esefDOyz4MmK4jqeIJN3ZmUuKvdN0=;
        b=mA/+HCKEXnaje/dL5p8iitqIiBQPgqBMtKF8L9uNApiG70M9NOcAT/cj5RmEhz7AuGPnMK
        O+2m7f/guXaORPCQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id B985AA3B8C;
        Mon, 16 Aug 2021 10:05:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 952E81E0426; Mon, 16 Aug 2021 12:05:45 +0200 (CEST)
Date:   Mon, 16 Aug 2021 12:05:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, yangerkun <yangerkun@huawei.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH] ext4: stop return ENOSPC from ext4_issue_zeroout
Message-ID: <20210816100545.GF24793@quack2.suse.cz>
References: <20210804125044.2480435-1-yangerkun@huawei.com>
 <20210804133529.GE4578@quack2.suse.cz>
 <YRaNKc2PvM+Eyzmp@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRaNKc2PvM+Eyzmp@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 13-08-21 11:18:01, Theodore Ts'o wrote:
> On Wed, Aug 04, 2021 at 03:35:29PM +0200, Jan Kara wrote:
> > On Wed 04-08-21 20:50:44, yangerkun wrote:
> > > Our testcase(briefly described as fsstress on dm thin-provisioning which
> > > ext4 see volume size with 100G but actual size 10G) trigger a hungtask
> > > bug since ext4_writepages fall into a infinite loop:
> > > 
> > > Got ENOSPC with follow stack:
> > > ...
> > > ext4_ext_map_blocks
> > >   ext4_ext_convert_to_initialized
> > >     ext4_ext_zeroout
> > >       ext4_issue_zeroout
> > >         ...
> > >         submit_bio_wait <-- bio to thinpool will return ENOSPC
> > > 
> > 
> > Thanks for the patch. As a quick fix for the problem this is probably fine.
> > But longer term we might need to implement a configurable behavior for this
> > because just dropping data on the floor (which is what would happen here)
> > need not be what sysadmin wants and blocking until space is provisioned may be
> > actually a preferable behavior. Anyway for now feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Hmm, I wonder if this would be a better fix.  (Not yet tested, may fry
> your file system, etc....)   What do folks think?

Yes, that looks indeed better. I'd note that even splitting extent may fail
due to ENOSPC on thin-provisioned storage but the chances are *much* lower.

								Honza

> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 92ad64b89d9b..501516cadc1b 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3569,7 +3569,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  				split_map.m_len - ee_block);
>  			err = ext4_ext_zeroout(inode, &zero_ex1);
>  			if (err)
> -				goto out;
> +				goto fallback;
>  			split_map.m_len = allocated;
>  		}
>  		if (split_map.m_lblk - ee_block + split_map.m_len <
> @@ -3583,7 +3583,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  						      ext4_ext_pblock(ex));
>  				err = ext4_ext_zeroout(inode, &zero_ex2);
>  				if (err)
> -					goto out;
> +					goto fallback;
>  			}
>  
>  			split_map.m_len += split_map.m_lblk - ee_block;
> @@ -3592,6 +3592,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  		}
>  	}
>  
> +fallback:
>  	err = ext4_split_extent(handle, inode, ppath, &split_map, split_flag,
>  				flags);
>  	if (err > 0)
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
