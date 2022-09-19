Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3F5BC9B2
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Sep 2022 12:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiISKps (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Sep 2022 06:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiISKpV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Sep 2022 06:45:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAA839BB1
        for <linux-ext4@vger.kernel.org>; Mon, 19 Sep 2022 03:28:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 65C3421F6B;
        Mon, 19 Sep 2022 10:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663583286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Vf9zP5u2c47Yy44f+8NHnZpiEAlHwL4Tkrswj37fIE=;
        b=vXsiU8DQE9tERIunkSyuu6pC0BXW/dw5YSg/CoixBdRWocvewVzexhCKPIFIzWvnpnY3Oh
        sNSehByTrwyuVdH67PNe51NZahGK+tj2iEW7L+DYVuv7U+115iIuQjRlLihGBdS+ooX9Kn
        M2755BGdyCso+uxz+KQAHK+fg7FKAjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663583286;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Vf9zP5u2c47Yy44f+8NHnZpiEAlHwL4Tkrswj37fIE=;
        b=bswS1gBO4jEXx6MyJmIUuLaHz6iNQL7LNRXuw+ycAvf1YbFsHWPYtuYKQG4z+aPhWsbt9O
        I3TITGdC4+CxPUBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5631813ABD;
        Mon, 19 Sep 2022 10:28:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4SP/FDZEKGPtcAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 19 Sep 2022 10:28:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DD3FDA0682; Mon, 19 Sep 2022 12:28:05 +0200 (CEST)
Date:   Mon, 19 Sep 2022 12:28:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 14/16] ext4: unify the ext4 super block loading
 operation
Message-ID: <20220919102805.efbzwnu7xuv5h5ki@quack3>
References: <20220916141527.1012715-1-yanaijie@huawei.com>
 <20220916141527.1012715-15-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916141527.1012715-15-yanaijie@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 16-09-22 22:15:25, Jason Yan wrote:
> Now we load the super block from the disk in two steps. First we load
> the super block with the default block size(EXT4_MIN_BLOCK_SIZE). Second
> we load the super block with the real block size. The second step is a
> little far from the first step. This patch move these two steps together
> in a new function.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 186 +++++++++++++++++++++++++++---------------------
>  1 file changed, 106 insertions(+), 80 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a9641709b777..2301de8bddcb 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4949,39 +4949,21 @@ static int ext4_journal_data_mode_check(struct super_block *sb)
>  	return 0;
>  }
>  
> -static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> +static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
> +			   int silent)
>  {
> -	struct buffer_head *bh;
> -	struct ext4_super_block *es = NULL;
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> -	struct flex_groups **flex_groups;
> -	ext4_fsblk_t block;
> +	struct ext4_super_block *es;
>  	ext4_fsblk_t logical_sb_block;
>  	unsigned long offset = 0;
> -	struct inode *root;
> -	int ret = -ENOMEM;
> +	struct buffer_head *bh;
> +	int ret = -EINVAL;
>  	int blocksize;
> -	unsigned int i;
> -	int needs_recovery, has_huge_files;
> -	int err = 0;
> -	ext4_group_t first_not_zeroed;
> -	struct ext4_fs_context *ctx = fc->fs_private;
> -	int silent = fc->sb_flags & SB_SILENT;
> -
> -	/* Set defaults for the variables that will be set during parsing */
> -	if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO))
> -		ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
>  
> -	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
> -	sbi->s_sectors_written_start =
> -		part_stat_read(sb->s_bdev, sectors[STAT_WRITE]);
> -
> -	/* -EINVAL is default */
> -	ret = -EINVAL;
>  	blocksize = sb_min_blocksize(sb, EXT4_MIN_BLOCK_SIZE);
>  	if (!blocksize) {
>  		ext4_msg(sb, KERN_ERR, "unable to set blocksize");
> -		goto out_fail;
> +		return -EINVAL;
>  	}
>  
>  	/*
> @@ -4998,8 +4980,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	bh = ext4_sb_bread_unmovable(sb, logical_sb_block);
>  	if (IS_ERR(bh)) {
>  		ext4_msg(sb, KERN_ERR, "unable to read superblock");
> -		ret = PTR_ERR(bh);
> -		goto out_fail;
> +		return PTR_ERR(bh);
>  	}
>  	/*
>  	 * Note: s_es must be initialized as soon as possible because
> @@ -5011,9 +4992,106 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	if (sb->s_magic != EXT4_SUPER_MAGIC) {
>  		if (!silent)
>  			ext4_msg(sb, KERN_ERR, "VFS: Can't find ext4 filesystem");
> -		goto failed_mount;
> +		goto out;
>  	}
>  
> +	if (le32_to_cpu(es->s_log_block_size) >
> +	    (EXT4_MAX_BLOCK_LOG_SIZE - EXT4_MIN_BLOCK_LOG_SIZE)) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "Invalid log block size: %u",
> +			 le32_to_cpu(es->s_log_block_size));
> +		goto out;
> +	}
> +	if (le32_to_cpu(es->s_log_cluster_size) >
> +	    (EXT4_MAX_CLUSTER_LOG_SIZE - EXT4_MIN_BLOCK_LOG_SIZE)) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "Invalid log cluster size: %u",
> +			 le32_to_cpu(es->s_log_cluster_size));
> +		goto out;
> +	}
> +
> +	blocksize = EXT4_MIN_BLOCK_SIZE << le32_to_cpu(es->s_log_block_size);
> +
> +	/*
> +	 * If the default block size is not the same as the real block size,
> +	 * we need to reload it.
> +	 */
> +	if (sb->s_blocksize == blocksize) {
> +		*lsb = logical_sb_block;
> +		sbi->s_sbh = bh;
> +		return 0;
> +	}
> +
> +	/*
> +	 * bh must be released before kill_bdev(), otherwise
> +	 * it won't be freed and its page also. kill_bdev()
> +	 * is called by sb_set_blocksize().
> +	 */
> +	brelse(bh);
> +	/* Validate the filesystem blocksize */
> +	if (!sb_set_blocksize(sb, blocksize)) {
> +		ext4_msg(sb, KERN_ERR, "bad block size %d",
> +				blocksize);
> +		bh = NULL;
> +		goto out;
> +	}
> +
> +	logical_sb_block = sbi->s_sb_block * EXT4_MIN_BLOCK_SIZE;
> +	offset = do_div(logical_sb_block, blocksize);
> +	bh = ext4_sb_bread_unmovable(sb, logical_sb_block);
> +	if (IS_ERR(bh)) {
> +		ext4_msg(sb, KERN_ERR, "Can't read superblock on 2nd try");
> +		ret = PTR_ERR(bh);
> +		bh = NULL;
> +		goto out;
> +	}
> +	es = (struct ext4_super_block *)(bh->b_data + offset);
> +	sbi->s_es = es;
> +	if (es->s_magic != cpu_to_le16(EXT4_SUPER_MAGIC)) {
> +		ext4_msg(sb, KERN_ERR, "Magic mismatch, very weird!");
> +		goto out;
> +	}
> +	*lsb = logical_sb_block;
> +	sbi->s_sbh = bh;
> +	return 0;
> +out:
> +	brelse(bh);
> +	return ret;
> +}
> +
> +static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> +{
> +	struct ext4_super_block *es = NULL;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct flex_groups **flex_groups;
> +	ext4_fsblk_t block;
> +	ext4_fsblk_t logical_sb_block;
> +	struct inode *root;
> +	int ret = -ENOMEM;
> +	int blocksize;
> +	unsigned int i;
> +	int needs_recovery, has_huge_files;
> +	int err = 0;
> +	ext4_group_t first_not_zeroed;
> +	struct ext4_fs_context *ctx = fc->fs_private;
> +	int silent = fc->sb_flags & SB_SILENT;
> +
> +	/* Set defaults for the variables that will be set during parsing */
> +	if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO))
> +		ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
> +
> +	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
> +	sbi->s_sectors_written_start =
> +		part_stat_read(sb->s_bdev, sectors[STAT_WRITE]);
> +
> +	/* -EINVAL is default */
> +	ret = -EINVAL;
> +	err = ext4_load_super(sb, &logical_sb_block, silent);
> +	if (err)
> +		goto out_fail;
> +
> +	es = sbi->s_es;
> +	blocksize = sb->s_blocksize;
>  	sbi->s_kbytes_written = le64_to_cpu(es->s_kbytes_written);
>  
>  	err = ext4_init_metadata_csum(sb, es);
> @@ -5034,23 +5112,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	 */
>  	sbi->s_li_wait_mult = EXT4_DEF_LI_WAIT_MULT;
>  
> -	if (le32_to_cpu(es->s_log_block_size) >
> -	    (EXT4_MAX_BLOCK_LOG_SIZE - EXT4_MIN_BLOCK_LOG_SIZE)) {
> -		ext4_msg(sb, KERN_ERR,
> -			 "Invalid log block size: %u",
> -			 le32_to_cpu(es->s_log_block_size));
> -		goto failed_mount;
> -	}
> -	if (le32_to_cpu(es->s_log_cluster_size) >
> -	    (EXT4_MAX_CLUSTER_LOG_SIZE - EXT4_MIN_BLOCK_LOG_SIZE)) {
> -		ext4_msg(sb, KERN_ERR,
> -			 "Invalid log cluster size: %u",
> -			 le32_to_cpu(es->s_log_cluster_size));
> -		goto failed_mount;
> -	}
> -
> -	blocksize = EXT4_MIN_BLOCK_SIZE << le32_to_cpu(es->s_log_block_size);
> -
>  	if (blocksize == PAGE_SIZE)
>  		set_opt(sb, DIOREAD_NOLOCK);
>  
> @@ -5114,40 +5175,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		goto failed_mount;
>  	}
>  
> -	if (sb->s_blocksize != blocksize) {
> -		/*
> -		 * bh must be released before kill_bdev(), otherwise
> -		 * it won't be freed and its page also. kill_bdev()
> -		 * is called by sb_set_blocksize().
> -		 */
> -		brelse(bh);
> -		/* Validate the filesystem blocksize */
> -		if (!sb_set_blocksize(sb, blocksize)) {
> -			ext4_msg(sb, KERN_ERR, "bad block size %d",
> -					blocksize);
> -			bh = NULL;
> -			goto failed_mount;
> -		}
> -
> -		logical_sb_block = sbi->s_sb_block * EXT4_MIN_BLOCK_SIZE;
> -		offset = do_div(logical_sb_block, blocksize);
> -		bh = ext4_sb_bread_unmovable(sb, logical_sb_block);
> -		if (IS_ERR(bh)) {
> -			ext4_msg(sb, KERN_ERR,
> -			       "Can't read superblock on 2nd try");
> -			ret = PTR_ERR(bh);
> -			bh = NULL;
> -			goto failed_mount;
> -		}
> -		es = (struct ext4_super_block *)(bh->b_data + offset);
> -		sbi->s_es = es;
> -		if (es->s_magic != cpu_to_le16(EXT4_SUPER_MAGIC)) {
> -			ext4_msg(sb, KERN_ERR,
> -			       "Magic mismatch, very weird!");
> -			goto failed_mount;
> -		}
> -	}
> -
>  	has_huge_files = ext4_has_feature_huge_file(sb);
>  	sbi->s_bitmap_maxbytes = ext4_max_bitmap_size(sb->s_blocksize_bits,
>  						      has_huge_files);
> @@ -5184,7 +5211,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	sbi->s_itb_per_group = sbi->s_inodes_per_group /
>  					sbi->s_inodes_per_block;
>  	sbi->s_desc_per_block = blocksize / EXT4_DESC_SIZE(sb);
> -	sbi->s_sbh = bh;
>  	sbi->s_mount_state = le16_to_cpu(es->s_state) & ~EXT4_FC_REPLAY;
>  	sbi->s_addr_per_block_bits = ilog2(EXT4_ADDR_PER_BLOCK(sb));
>  	sbi->s_desc_per_block_bits = ilog2(EXT4_DESC_PER_BLOCK(sb));
> @@ -5621,7 +5647,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  #endif
>  	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
>  	/* ext4_blkdev_remove() calls kill_bdev(), release bh before it. */
> -	brelse(bh);
> +	brelse(sbi->s_sbh);
>  	ext4_blkdev_remove(sbi);
>  out_fail:
>  	sb->s_fs_info = NULL;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
