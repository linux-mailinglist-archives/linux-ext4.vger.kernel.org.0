Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC445CABB
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Nov 2021 18:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhKXRS0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Nov 2021 12:18:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57682 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhKXRS0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Nov 2021 12:18:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D1A0D21941;
        Wed, 24 Nov 2021 17:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637774115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BCGtCJK5L+eb9vaFKEIUdp3BquJpa4mvy+SgrA9zVSg=;
        b=othiAs3Q0nnlWrofkMO6HESzKEwJ/ObCn3/cFPwXrvSY8N0G6Y/dBKN5zsHqLhssiqNRf/
        zzONo6m2cRwC6exwaWw1VCbxv9EOEjaHxoFAp673tdWWbN/uuDtvnDgGy5XK5G/03r7HEH
        Tf3NaNH+04SItLFe83W7YGp1InrRRJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637774115;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BCGtCJK5L+eb9vaFKEIUdp3BquJpa4mvy+SgrA9zVSg=;
        b=OPZre4kbSNbmXjxz8G6RbYVBoJ7/OzaOwltbyZA7EiKn/184tW0EFzLl9JRXEPAEh7ltUw
        iDK5WTrJOwBcGADQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 28B90A3B81;
        Wed, 24 Nov 2021 17:15:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CC6B01E0D1A; Wed, 24 Nov 2021 18:15:10 +0100 (CET)
Date:   Wed, 24 Nov 2021 18:15:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        yukuai3@huawei.com
Subject: Re: [PATCH] ext4: if zeroout fails fall back to splitting the extent
 node
Message-ID: <20211124171510.GA11240@quack2.suse.cz>
References: <YRaNKc2PvM+Eyzmp@mit.edu>
 <20210813212701.366447-1-tytso@mit.edu>
 <715f636e-ff1b-301f-38a9-602437fdd95a@huawei.com>
 <20211123092741.GA8583@quack2.suse.cz>
 <d5346e36-3331-0d0d-e36d-83f543986ccb@huawei.com>
 <20211124103737.GI8583@quack2.suse.cz>
 <9e47b349-0360-3426-dfa3-cc77f444fac3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47b349-0360-3426-dfa3-cc77f444fac3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 24-11-21 20:11:43, yangerkun wrote:
> 
> 
> On 2021/11/24 18:37, Jan Kara wrote:
> > On Wed 24-11-21 17:01:12, yangerkun wrote:
> > > On 2021/11/23 17:27, Jan Kara wrote:
> > > > Hello,
> > > > 
> > > > On Sun 26-09-21 19:35:01, yangerkun wrote:
> > > > > Rethink about this problem. Should we consider other place which call
> > > > > ext4_issue_zeroout? Maybe it can trigger the problem too(in theory, not
> > > > > really happened)...
> > > > > 
> > > > > How about include follow patch which not only transfer ENOSPC to EIO. But
> > > > > also stop to overwrite the error return by ext4_ext_insert_extent in
> > > > > ext4_split_extent_at.
> > > > > 
> > > > > Besides, 308c57ccf431 ("ext4: if zeroout fails fall back to splitting the
> > > > > extent node") can work together with this patch.
> > > > 
> > > > I've got back to this. The ext4_ext_zeroout() calls in
> > > > ext4_split_extent_at() seem to be there as fallback when insertion of a new
> > > > extent fails due to ENOSPC / EDQUOT. If even ext4_ext_zeroout(), then I
> > > > think returning an error as the code does now is correct and we don't have
> > > > much other option. Also we are really running out of disk space so I think
> > > > returning ENOSPC is fine. What exact scenario are you afraid of?
> > > 
> > > I am afraid about the EDQUOT from ext4_ext_insert_extent may be overwrite by
> > > ext4_ext_zeroout with ENOSPC. And this may lead to dead loop since
> > > ext4_writepages will retry once get ENOSPC? Maybe I am wrong...
> > 
> > OK, so passing back original error instead of the error from
> > ext4_ext_zeroout() makes sense. But I don't think doing much more is needed
> > - firstly, ENOSPC or EDQUOT should not happen in ext4_split_extent_at()
> > called from ext4_writepages() because we should have reserved enough
> > space for extent splits when writing data. So hitting that is already
> 
> ext4_da_write_begin
>   ext4_da_get_block_prep
>     ext4_insert_delayed_block
>       ext4_da_reserve_space
> 
> It seems we will only reserve space for data, no for metadata...
> 
> 
> > unexpected. Committing transaction holding blocks that are expected to be
> > free is the most likely reason for us seeing ENOSPC and returning EIO in
> > that case would be bug.
> 
> Agree. EIO from ext4_ext_zeroout that overwrite the ENOSPC from
> ext4_ext_insert_extent seems buggy too. Maybe we should ignore the error
> from ext4_ext_zeroout and return the error from ext4_ext_insert_extent
> once ext4_ext_zeroout in ext4_split_extent_at got a error. Something
> like this:

Yep, something like that looks good to me.

								Honza

> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0ecf819bf189..56cc00ee42a1 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3185,6 +3185,7 @@ static int ext4_split_extent_at(handle_t *handle,
>         struct ext4_extent *ex2 = NULL;
>         unsigned int ee_len, depth;
>         int err = 0;
> +       int err1;
> 
>         BUG_ON((split_flag & (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2))
> ==
>                (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2));
> @@ -3255,7 +3256,7 @@ static int ext4_split_extent_at(handle_t *handle,
>         if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
>                 if (split_flag &
> (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
>                         if (split_flag & EXT4_EXT_DATA_VALID1) {
> -                               err = ext4_ext_zeroout(inode, ex2);
> +                               err1 = ext4_ext_zeroout(inode, ex2);
>                                 zero_ex.ee_block = ex2->ee_block;
>                                 zero_ex.ee_len = cpu_to_le16(
> 
> ext4_ext_get_actual_len(ex2));
> @@ -3270,7 +3271,7 @@ static int ext4_split_extent_at(handle_t *handle,
>                                                       ext4_ext_pblock(ex));
>                         }
>                 } else {
> -                       err = ext4_ext_zeroout(inode, &orig_ex);
> +                       err1 = ext4_ext_zeroout(inode, &orig_ex);
>                         zero_ex.ee_block = orig_ex.ee_block;
>                         zero_ex.ee_len = cpu_to_le16(
> 
> ext4_ext_get_actual_len(&orig_ex));
> @@ -3278,7 +3279,7 @@ static int ext4_split_extent_at(handle_t *handle,
>                                               ext4_ext_pblock(&orig_ex));
>                 }
> 
> -               if (!err) {
> +               if (!err1) {
>                         /* update the extent length and mark as initialized
> */
>                         ex->ee_len = cpu_to_le16(ee_len);
>                         ext4_ext_try_to_merge(handle, inode, path, ex);
> 
> 
> 
> > Secondly, returning EIO instead of ENOSPC is IMO a
> > bit confusing for upper layers and makes it harder to analyze where the
> > real problem is...
> > 
> > 								Honza
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
