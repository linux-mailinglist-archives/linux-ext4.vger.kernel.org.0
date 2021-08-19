Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561F73F1754
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Aug 2021 12:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbhHSKfm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Aug 2021 06:35:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40604 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbhHSKfl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Aug 2021 06:35:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6708D2209B;
        Thu, 19 Aug 2021 10:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629369304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p1/YjMtunmntj17IgarF8r82HsoYyHTF0J/qAPFpnFw=;
        b=tboh7SBNbEvFQy8ofVvQ/LHbFcEb2QdNW/t4oH7mU6XjQDcGU0Qxz39jCQr9UgFGeQwwlt
        kFJOZgZrYc0v3JtXz9FzhpBKI+rcje2ZS4gZj7LwFwUGt1zC+Zv7zltuxi5eaFB6fe6dwE
        /hgODNN/k9EQHMCcUn0ur/ir3XT7J38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629369304;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p1/YjMtunmntj17IgarF8r82HsoYyHTF0J/qAPFpnFw=;
        b=icC8cjY07IHHsIct7uGGvl8SvNr/rociHdyu5uhEk8y0GEliX57wi0LK69XD9A/gOSNGHC
        X9q9hoELCZgyqpDA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id C3628A3BC7;
        Thu, 19 Aug 2021 10:34:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 30E6E1E0679; Thu, 19 Aug 2021 12:35:04 +0200 (CEST)
Date:   Thu, 19 Aug 2021 12:35:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH v2 4/4] ext4: prevent getting empty inode buffer
Message-ID: <20210819103504.GB32435@quack2.suse.cz>
References: <20210819065704.1248402-1-yi.zhang@huawei.com>
 <20210819065704.1248402-5-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819065704.1248402-5-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 19-08-21 14:57:04, Zhang Yi wrote:
> In ext4_get_inode_loc(), we may skip IO and get an zero && uptodate
> inode buffer when the inode monopolize an inode block for performance
> reason. For most cases, ext4_mark_iloc_dirty() will fill the inode
> buffer to make it fine, but we could miss this call if something bad
> happened. Finally, __ext4_get_inode_loc_noinmem() may probably get an
> empty inode buffer and trigger ext4 error.
> 
> For example, if we remove a nonexistent xattr on inode A,
> ext4_xattr_set_handle() will return ENODATA before invoking
> ext4_mark_iloc_dirty(), it will left an uptodate but zero buffer. We
> will get checksum error message in ext4_iget() when getting inode again.
> 
>   EXT4-fs error (device sda): ext4_lookup:1784: inode #131074: comm cat: iget: checksum invalid
> 
> Even worse, if we allocate another inode B at the same inode block, it
> will corrupt the inode A on disk when write back inode B.
> 
> So this patch postpone the init and mark buffer uptodate logic until
> before filling correct inode data in ext4_do_update_inode() if skip read
> I/O, ensure the buffer is real uptodate.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Just some language fixes below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> ---
>  fs/ext4/inode.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d0d7a5295bf9..02d910c9d8f1 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4367,9 +4367,11 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
>  		}
>  		brelse(bitmap_bh);
>  		if (i == start + inodes_per_block) {
> -			/* all other inodes are free, so skip I/O */
> -			memset(bh->b_data, 0, bh->b_size);
> -			set_buffer_uptodate(bh);
> +			/*
> +			 * All other inodes are free, skip I/O. Return
> +			 * un-inited buffer (which is postponed until

I'd repharse this sentence as: Return uninitialized buffer immediately,
initialization is postponed until shortly before we fill inode contents.

> +			 * before filling inode data) immediately.
> +			 */
>  			unlock_buffer(bh);
>  			goto has_buffer;
>  		}
> @@ -5026,6 +5028,24 @@ static int ext4_do_update_inode(handle_t *handle,
>  	gid_t i_gid;
>  	projid_t i_projid;
>  
> +	/*
> +	 * If the buffer is not uptodate, it means all information of inode
								   ^^^^^^^^
of the inode is

> +	 * in memory and we got this buffer without reading the block. We
> +	 * must be cautious that once we mark the buffer as uptodate, we
> +	 * rely on filling in the correct inode data later in this function.
> +	 * Otherwise if we getting the left falsepositive buffer when

I'd rephrase this sentence as: Otherwise if we left uptodate buffer without
copying proper inode contents, we could corrupt the inode on disk after
allocating another inode in the same block.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
