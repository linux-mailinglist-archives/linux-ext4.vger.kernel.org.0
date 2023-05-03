Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729D86F5A1E
	for <lists+linux-ext4@lfdr.de>; Wed,  3 May 2023 16:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjECOcz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 May 2023 10:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjECOct (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 May 2023 10:32:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3766A75;
        Wed,  3 May 2023 07:32:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DA9D4203FE;
        Wed,  3 May 2023 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683124349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IqcmqJwfQDQ2+s+vqKdljbr+J9teNv/XEr1/tMasJxE=;
        b=JQbf7o0NYSqYYYCl0r3UdEyX1lUeHr7/By2xjENsYexUsjzTsm+l5W09yI4oLgXb2N/0H+
        B5zxvRjV+yIHcBAAcR0oKV1flzITk9dzajlbfpBrqe5sIa8nZUukI7XWXNQ2WgLFXhM8JK
        nR9Q+jDM5iPBirvfqk7x12pnJbMhtZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683124349;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IqcmqJwfQDQ2+s+vqKdljbr+J9teNv/XEr1/tMasJxE=;
        b=94GQe9ybtthETM9nVVEQ6Ka7CNqYPpxAz6TB+df//AZPW+TljskicW7gcska5kVQDpS6kz
        AjhbCJCddJ5deXCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAA6C1331F;
        Wed,  3 May 2023 14:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eEd4MX1wUmSkRgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 14:32:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 67DE5A0744; Wed,  3 May 2023 16:32:29 +0200 (CEST)
Date:   Wed, 3 May 2023 16:32:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 09/12] ext4: make ext4_es_remove_extent() return void
Message-ID: <20230503143229.yj2hve2mjs5td3py@quack3>
References: <20230424033846.4732-1-libaokun1@huawei.com>
 <20230424033846.4732-10-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424033846.4732-10-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 24-04-23 11:38:43, Baokun Li wrote:
> Now ext4_es_remove_extent() never fails, so make it return void.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c        | 34 ++++++----------------------------
>  fs/ext4/extents_status.c | 12 ++++++------
>  fs/ext4/extents_status.h |  4 ++--
>  fs/ext4/inline.c         | 12 ++----------
>  fs/ext4/inode.c          |  8 ++------
>  5 files changed, 18 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 3559ea6b0781..e6695fec59af 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4403,15 +4403,8 @@ int ext4_ext_truncate(handle_t *handle, struct inode *inode)
>  
>  	last_block = (inode->i_size + sb->s_blocksize - 1)
>  			>> EXT4_BLOCK_SIZE_BITS(sb);
> -retry:
> -	err = ext4_es_remove_extent(inode, last_block,
> -				    EXT_MAX_BLOCKS - last_block);
> -	if (err == -ENOMEM) {
> -		memalloc_retry_wait(GFP_ATOMIC);
> -		goto retry;
> -	}
> -	if (err)
> -		return err;
> +	ext4_es_remove_extent(inode, last_block, EXT_MAX_BLOCKS - last_block);
> +
>  retry_remove_space:
>  	err = ext4_ext_remove_space(inode, last_block, EXT_MAX_BLOCKS - 1);
>  	if (err == -ENOMEM) {
> @@ -5363,13 +5356,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  
>  	down_write(&EXT4_I(inode)->i_data_sem);
>  	ext4_discard_preallocations(inode, 0);
> -
> -	ret = ext4_es_remove_extent(inode, punch_start,
> -				    EXT_MAX_BLOCKS - punch_start);
> -	if (ret) {
> -		up_write(&EXT4_I(inode)->i_data_sem);
> -		goto out_stop;
> -	}
> +	ext4_es_remove_extent(inode, punch_start, EXT_MAX_BLOCKS - punch_start);
>  
>  	ret = ext4_ext_remove_space(inode, punch_start, punch_stop - 1);
>  	if (ret) {
> @@ -5554,12 +5541,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  		ext4_free_ext_path(path);
>  	}
>  
> -	ret = ext4_es_remove_extent(inode, offset_lblk,
> -			EXT_MAX_BLOCKS - offset_lblk);
> -	if (ret) {
> -		up_write(&EXT4_I(inode)->i_data_sem);
> -		goto out_stop;
> -	}
> +	ext4_es_remove_extent(inode, offset_lblk, EXT_MAX_BLOCKS - offset_lblk);
>  
>  	/*
>  	 * if offset_lblk lies in a hole which is at start of file, use
> @@ -5617,12 +5599,8 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
>  	BUG_ON(!inode_is_locked(inode1));
>  	BUG_ON(!inode_is_locked(inode2));
>  
> -	*erp = ext4_es_remove_extent(inode1, lblk1, count);
> -	if (unlikely(*erp))
> -		return 0;
> -	*erp = ext4_es_remove_extent(inode2, lblk2, count);
> -	if (unlikely(*erp))
> -		return 0;
> +	ext4_es_remove_extent(inode1, lblk1, count);
> +	ext4_es_remove_extent(inode2, lblk2, count);
>  
>  	while (count) {
>  		struct ext4_extent *ex1, *ex2, tmp_ex;
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 91828cf7395b..2a394c40f4b7 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1464,10 +1464,10 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>   * @len - number of blocks to remove
>   *
>   * Reduces block/cluster reservation count and for bigalloc cancels pending
> - * reservations as needed. Returns 0 on success, error code on failure.
> + * reservations as needed.
>   */
> -int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
> -			  ext4_lblk_t len)
> +void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
> +			   ext4_lblk_t len)
>  {
>  	ext4_lblk_t end;
>  	int err = 0;
> @@ -1475,14 +1475,14 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  	struct extent_status *es = NULL;
>  
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> -		return 0;
> +		return;
>  
>  	trace_ext4_es_remove_extent(inode, lblk, len);
>  	es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
>  		 lblk, len, inode->i_ino);
>  
>  	if (!len)
> -		return err;
> +		return;
>  
>  	end = lblk + len - 1;
>  	BUG_ON(end < lblk);
> @@ -1505,7 +1505,7 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  
>  	ext4_es_print_tree(inode);
>  	ext4_da_release_space(inode, reserved);
> -	return 0;
> +	return;
>  }
>  
>  static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
> index 4ec30a798260..526a68890aa6 100644
> --- a/fs/ext4/extents_status.h
> +++ b/fs/ext4/extents_status.h
> @@ -133,8 +133,8 @@ extern int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  extern void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
>  				 ext4_lblk_t len, ext4_fsblk_t pblk,
>  				 unsigned int status);
> -extern int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
> -				 ext4_lblk_t len);
> +extern void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
> +				  ext4_lblk_t len);
>  extern void ext4_es_find_extent_range(struct inode *inode,
>  				      int (*match_fn)(struct extent_status *es),
>  				      ext4_lblk_t lblk, ext4_lblk_t end,
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index b9fb1177fff6..d58cd0331474 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -1952,16 +1952,8 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
>  		 * the extent status cache must be cleared to avoid leaving
>  		 * behind stale delayed allocated extent entries
>  		 */
> -		if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
> -retry:
> -			err = ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
> -			if (err == -ENOMEM) {
> -				memalloc_retry_wait(GFP_ATOMIC);
> -				goto retry;
> -			}
> -			if (err)
> -				goto out_error;
> -		}
> +		if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
> +			ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
>  
>  		/* Clear the content in the xattr space. */
>  		if (inline_size > EXT4_MIN_INLINE_DATA_SIZE) {
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 20de04399c8b..a0bfe77d5537 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4034,12 +4034,8 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  		down_write(&EXT4_I(inode)->i_data_sem);
>  		ext4_discard_preallocations(inode, 0);
>  
> -		ret = ext4_es_remove_extent(inode, first_block,
> -					    stop_block - first_block);
> -		if (ret) {
> -			up_write(&EXT4_I(inode)->i_data_sem);
> -			goto out_stop;
> -		}
> +		ext4_es_remove_extent(inode, first_block,
> +				      stop_block - first_block);
>  
>  		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>  			ret = ext4_ext_remove_space(inode, first_block,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
