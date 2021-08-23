Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2493F4C0C
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 16:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhHWOCn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 10:02:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48756 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhHWOCm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 10:02:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4EC581FFF6;
        Mon, 23 Aug 2021 14:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629727319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A1VMd+3Qu2s1+qMjIPfKmFlBxNOQGTK2aXcMEwM8NUc=;
        b=aMSIfw5gGHG7G4z345Xu4VPgWlvC8yZW7d/X5JgBcdYFEr9TqRKNLueyC9Xk26mYFwlrzQ
        Isc7+ONsQCzfQYQhSPgk3Y7PyHzOUFZ9TB1mjjF1AJlEYYzgjEJoLWmrp0l1j6vfHeduv6
        +JgMjmukz3U08vf5/AYyiB+OqqOASiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629727319;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A1VMd+3Qu2s1+qMjIPfKmFlBxNOQGTK2aXcMEwM8NUc=;
        b=c//BQ1PRXeSRKmnI6Tt9aQQyH89lidoEVl/irG2yS5ZFENpxPw7gqFXy07UkEs0jNq/z9t
        1EXPNAu4QovkDrBw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 3EC61A3BB0;
        Mon, 23 Aug 2021 14:01:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9EF661E14B9; Mon, 23 Aug 2021 16:01:58 +0200 (CEST)
Date:   Mon, 23 Aug 2021 16:01:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] tune2fs: Fix conversion of quota files
Message-ID: <20210823140158.GG21467@quack2.suse.cz>
References: <20210820194656.27799-1-jack@suse.cz>
 <20210820194656.27799-3-jack@suse.cz>
 <YSAwaKONl7vptrX/@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSAwaKONl7vptrX/@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 20-08-21 18:44:56, Theodore Ts'o wrote:
> On Fri, Aug 20, 2021 at 09:46:56PM +0200, Jan Kara wrote:
> > 
> > diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
> > index fbc3833aee98..34ab632fb81c 100644
> > --- a/lib/support/mkquota.c
> > +++ b/lib/support/mkquota.c
> > @@ -569,14 +569,14 @@ static int scan_dquots_callback(struct dquot *dquot, void *cb_data)
> >   */
> >  static errcode_t quota_read_all_dquots(struct quota_handle *qh,
> >                                         quota_ctx_t qctx,
> > -				       int update_limits EXT2FS_ATTR((unused)))
> > +				       int update_limits)
> >  {
> >  	struct scan_dquots_data scan_data;
> >  
> >  	scan_data.quota_dict = qctx->quota_dict[qh->qh_type];
> >  	scan_data.check_consistency = 0;
> > -	scan_data.update_limits = 0;
> > -	scan_data.update_usage = 1;
> > +	scan_data.update_limits = update_limits;
> > +	scan_data.update_usage = 0;
> >  
> >  	return qh->qh_ops->scan_dquots(qh, scan_dquots_callback, &scan_data);
> >  }
> 
> This change, while it is correct for tune2fs, is breaking e2fsck's
> f_orphquot test.  The root cause is that e2fsck_read_all_quotas() in
> e2fsck/super.c is calling quota_update_limits(), where it had wanted
> to be reading the quota usage data, not the limits.
> 
> I think what we need to do is to take quota_read_all_dquots(), which
> is only used by quota_update_limits(), and then fodl it into
> quota_update_limits().  And then add a flags parameter to indicate
> whether we want to be reading the limits or the usage, and then rename
> quota_update_limits() to quota_read_all_dquots().
> 
> Does that make sense to you?  (One of the reasons why the quota
> functions are all in libsupport is precisely because I knew these
> functions still needed more polishing.)

Yes, makes sense. I'll send patches.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
