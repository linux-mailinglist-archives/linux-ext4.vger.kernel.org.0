Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5913F4897
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 12:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhHWKYZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 06:24:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56714 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbhHWKYZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 06:24:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E84BF1FF9A;
        Mon, 23 Aug 2021 10:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629714221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1JFNuD5e/sPsO8GmkAVVe8zQ9FuIUiEbC4SJNnRKz8=;
        b=AmbIiCAe3hzDktJ4sIGCOLcSfylkynJFJymqV4wVhfuFPQ/69Y1dU+bf721EWNFKb9EofM
        IRT+xr441JvtgZkMR3eaX1hstIbn1QpZ5rjse1vwiy79fPyJQmjDbFXpZ18XwU/et+2oGD
        40kKO72iLSKxG3BDb3ZuniOKkiBzW6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629714221;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1JFNuD5e/sPsO8GmkAVVe8zQ9FuIUiEbC4SJNnRKz8=;
        b=LBVzXDsm3plXrdf7EzsLbmHWhmax9FpxMB9ndfqTP6ts4Udi/0G2V0s+Vj3sn1fmeyg9h5
        v9CmBo3hUcXxPpAA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 98A8EA3B85;
        Mon, 23 Aug 2021 10:23:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0EFDE1E14B9; Mon, 23 Aug 2021 12:23:41 +0200 (CEST)
Date:   Mon, 23 Aug 2021 12:23:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH v3 3/4] ext4: make the updating inode data procedure
 atomic
Message-ID: <20210823102341.GC21467@quack2.suse.cz>
References: <20210821065450.1397451-1-yi.zhang@huawei.com>
 <20210821065450.1397451-4-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210821065450.1397451-4-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 21-08-21 14:54:49, Zhang Yi wrote:
> Now that ext4_do_update_inode() return error before filling the whole
> inode data if we fail to set inode blocks in ext4_inode_blocks_set().
> This error should never happen in theory since sb->s_maxbytes should not
> have allowed this, we have already init sb->s_maxbytes according to this
> feature in ext4_fill_super(). So even through that could only happen due
> to the filesystem corruption, we'd better to return after we finish
> updating the inode because it may left an uninitialized buffer and we
> could read this buffer later in "errors=continue" mode.
> 
> This patch make the updating inode data procedure atomic, call
> EXT4_ERROR_INODE() after we dropping i_raw_lock after something bad
> happened, make sure that the inode is integrated, and also drop a BUG_ON
> and do some small cleanups.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 44 ++++++++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index eae1b2d0b550..8323d3e8f393 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4920,8 +4920,14 @@ static int ext4_inode_blocks_set(handle_t *handle,
>  		ext4_clear_inode_flag(inode, EXT4_INODE_HUGE_FILE);
>  		return 0;
>  	}
> +
> +	/*
> +	 * This should never happen since sb->s_maxbytes should not have
> +	 * allowed this, sb->s_maxbytes was set according to the huge_file
> +	 * feature in ext4_fill_super().
> +	 */
>  	if (!ext4_has_feature_huge_file(sb))
> -		return -EFBIG;
> +		return -EFSCORRUPTED;
>  
>  	if (i_blocks <= 0xffffffffffffULL) {
>  		/*
> @@ -5024,16 +5030,14 @@ static int ext4_do_update_inode(handle_t *handle,
>  
>  	spin_lock(&ei->i_raw_lock);
>  
> -	/* For fields not tracked in the in-memory inode,
> -	 * initialise them to zero for new inodes. */
> +	/*
> +	 * For fields not tracked in the in-memory inode, initialise them
> +	 * to zero for new inodes.
> +	 */
>  	if (ext4_test_inode_state(inode, EXT4_STATE_NEW))
>  		memset(raw_inode, 0, EXT4_SB(inode->i_sb)->s_inode_size);
>  
>  	err = ext4_inode_blocks_set(handle, raw_inode, ei);
> -	if (err) {
> -		spin_unlock(&ei->i_raw_lock);
> -		goto out_brelse;
> -	}
>  
>  	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
>  	i_uid = i_uid_read(inode);
> @@ -5042,10 +5046,11 @@ static int ext4_do_update_inode(handle_t *handle,
>  	if (!(test_opt(inode->i_sb, NO_UID32))) {
>  		raw_inode->i_uid_low = cpu_to_le16(low_16_bits(i_uid));
>  		raw_inode->i_gid_low = cpu_to_le16(low_16_bits(i_gid));
> -/*
> - * Fix up interoperability with old kernels. Otherwise, old inodes get
> - * re-used with the upper 16 bits of the uid/gid intact
> - */
> +		/*
> +		 * Fix up interoperability with old kernels. Otherwise,
> +		 * old inodes get re-used with the upper 16 bits of the
> +		 * uid/gid intact.
> +		 */
>  		if (ei->i_dtime && list_empty(&ei->i_orphan)) {
>  			raw_inode->i_uid_high = 0;
>  			raw_inode->i_gid_high = 0;
> @@ -5114,8 +5119,9 @@ static int ext4_do_update_inode(handle_t *handle,
>  		}
>  	}
>  
> -	BUG_ON(!ext4_has_feature_project(inode->i_sb) &&
> -	       i_projid != EXT4_DEF_PROJID);
> +	if (i_projid != EXT4_DEF_PROJID &&
> +	    !ext4_has_feature_project(inode->i_sb))
> +		err = err ?: -EFSCORRUPTED;
>  
>  	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE &&
>  	    EXT4_FITS_IN_INODE(raw_inode, ei, i_projid))
> @@ -5123,6 +5129,11 @@ static int ext4_do_update_inode(handle_t *handle,
>  
>  	ext4_inode_csum_set(inode, raw_inode, ei);
>  	spin_unlock(&ei->i_raw_lock);
> +	if (err) {
> +		EXT4_ERROR_INODE(inode, "corrupted inode contents");
> +		goto out_brelse;
> +	}
> +
>  	if (inode->i_sb->s_flags & SB_LAZYTIME)
>  		ext4_update_other_inodes_time(inode->i_sb, inode->i_ino,
>  					      bh->b_data);
> @@ -5130,13 +5141,13 @@ static int ext4_do_update_inode(handle_t *handle,
>  	BUFFER_TRACE(bh, "call ext4_handle_dirty_metadata");
>  	err = ext4_handle_dirty_metadata(handle, NULL, bh);
>  	if (err)
> -		goto out_brelse;
> +		goto out_error;
>  	ext4_clear_inode_state(inode, EXT4_STATE_NEW);
>  	if (set_large_file) {
>  		BUFFER_TRACE(EXT4_SB(sb)->s_sbh, "get write access");
>  		err = ext4_journal_get_write_access(handle, EXT4_SB(sb)->s_sbh);
>  		if (err)
> -			goto out_brelse;
> +			goto out_error;
>  		lock_buffer(EXT4_SB(sb)->s_sbh);
>  		ext4_set_feature_large_file(sb);
>  		ext4_superblock_csum_set(sb);
> @@ -5146,9 +5157,10 @@ static int ext4_do_update_inode(handle_t *handle,
>  						 EXT4_SB(sb)->s_sbh);
>  	}
>  	ext4_update_inode_fsync_trans(handle, inode, need_datasync);
> +out_error:
> +	ext4_std_error(inode->i_sb, err);
>  out_brelse:
>  	brelse(bh);
> -	ext4_std_error(inode->i_sb, err);
>  	return err;
>  }
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
