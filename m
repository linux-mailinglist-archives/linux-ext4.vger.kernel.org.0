Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D0C5A7CA6
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 13:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiHaL5O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 07:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiHaL5I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 07:57:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED51D2755
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 04:57:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6564522189;
        Wed, 31 Aug 2022 11:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661947025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rkM7PMO2uIZlpJhjZepxdcuL3zcXCYxFAraFCXW38f8=;
        b=PoV7FGPM4D5taTcnXT+HG2RURXAuyJiZv3oK1ckC47kfOeNQBaGt1Xxnuczp4FkYo+uZ0s
        ILj7ZlUeV0vcPL+LMFs8IVI72woK3W1hSPOR8i2EfTk7vPDuyMyG3EJAWg1wBcN+iVKsBz
        9DEQYfGuYaCrS/Xdxk6uhST3P5A9lvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661947025;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rkM7PMO2uIZlpJhjZepxdcuL3zcXCYxFAraFCXW38f8=;
        b=YzFT6z8BViIA/vRC+a17hTTmyqyj+f4PNBbxwH+kOBdoOfB+3PxWCtxRWjLBg9VCIZeQWv
        yYoU5PmgE0x3B/DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50B021332D;
        Wed, 31 Aug 2022 11:57:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cKajE5FMD2NtDAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:57:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C2F79A067B; Wed, 31 Aug 2022 13:57:04 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:57:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 10/13] ext4: factor out ext4_geometry_check()
Message-ID: <20220831115704.32gtwv3u3ihqijbk@quack3>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
 <20220830120411.2371968-11-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830120411.2371968-11-yanaijie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 30-08-22 20:04:08, Jason Yan wrote:
> Factor out ext4_geometry_check(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 111 ++++++++++++++++++++++++++----------------------
>  1 file changed, 61 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 1e7d6eb6a3aa..4c6c4930e11b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4683,6 +4683,66 @@ static int ext4_compat_feature_check(struct super_block *sb,
>  	return 0;
>  }
>  
> +static int ext4_geometry_check(struct super_block *sb,
> +			       struct ext4_super_block *es)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	__u64 blocks_count;
> +
> +	/* check blocks count against device size */
> +	blocks_count = sb_bdev_nr_blocks(sb);
> +	if (blocks_count && ext4_blocks_count(es) > blocks_count) {
> +		ext4_msg(sb, KERN_WARNING, "bad geometry: block count %llu "
> +		       "exceeds size of device (%llu blocks)",
> +		       ext4_blocks_count(es), blocks_count);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * It makes no sense for the first data block to be beyond the end
> +	 * of the filesystem.
> +	 */
> +	if (le32_to_cpu(es->s_first_data_block) >= ext4_blocks_count(es)) {
> +		ext4_msg(sb, KERN_WARNING, "bad geometry: first data "
> +			 "block %u is beyond end of filesystem (%llu)",
> +			 le32_to_cpu(es->s_first_data_block),
> +			 ext4_blocks_count(es));
> +		return -EINVAL;
> +	}
> +	if ((es->s_first_data_block == 0) && (es->s_log_block_size == 0) &&
> +	    (sbi->s_cluster_ratio == 1)) {
> +		ext4_msg(sb, KERN_WARNING, "bad geometry: first data "
> +			 "block is 0 with a 1k block and cluster size");
> +		return -EINVAL;
> +	}
> +
> +	blocks_count = (ext4_blocks_count(es) -
> +			le32_to_cpu(es->s_first_data_block) +
> +			EXT4_BLOCKS_PER_GROUP(sb) - 1);
> +	do_div(blocks_count, EXT4_BLOCKS_PER_GROUP(sb));
> +	if (blocks_count > ((uint64_t)1<<32) - EXT4_DESC_PER_BLOCK(sb)) {
> +		ext4_msg(sb, KERN_WARNING, "groups count too large: %llu "
> +		       "(block count %llu, first data block %u, "
> +		       "blocks per group %lu)", blocks_count,
> +		       ext4_blocks_count(es),
> +		       le32_to_cpu(es->s_first_data_block),
> +		       EXT4_BLOCKS_PER_GROUP(sb));
> +		return -EINVAL;
> +	}
> +	sbi->s_groups_count = blocks_count;
> +	sbi->s_blockfile_groups = min_t(ext4_group_t, sbi->s_groups_count,
> +			(EXT4_MAX_BLOCK_FILE_PHYS / EXT4_BLOCKS_PER_GROUP(sb)));
> +	if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=
> +	    le32_to_cpu(es->s_inodes_count)) {
> +		ext4_msg(sb, KERN_ERR, "inodes count not valid: %u vs %llu",
> +			 le32_to_cpu(es->s_inodes_count),
> +			 ((u64)sbi->s_groups_count * sbi->s_inodes_per_group));
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  {
>  	struct buffer_head *bh, **group_desc;
> @@ -4698,7 +4758,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	unsigned int db_count;
>  	unsigned int i;
>  	int needs_recovery, has_huge_files;
> -	__u64 blocks_count;
>  	int err = 0;
>  	ext4_group_t first_not_zeroed;
>  	struct ext4_fs_context *ctx = fc->fs_private;
> @@ -4984,57 +5043,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		goto failed_mount;
>  	}
>  
> -	/* check blocks count against device size */
> -	blocks_count = sb_bdev_nr_blocks(sb);
> -	if (blocks_count && ext4_blocks_count(es) > blocks_count) {
> -		ext4_msg(sb, KERN_WARNING, "bad geometry: block count %llu "
> -		       "exceeds size of device (%llu blocks)",
> -		       ext4_blocks_count(es), blocks_count);
> +	if (ext4_geometry_check(sb, es))
>  		goto failed_mount;
> -	}
>  
> -	/*
> -	 * It makes no sense for the first data block to be beyond the end
> -	 * of the filesystem.
> -	 */
> -	if (le32_to_cpu(es->s_first_data_block) >= ext4_blocks_count(es)) {
> -		ext4_msg(sb, KERN_WARNING, "bad geometry: first data "
> -			 "block %u is beyond end of filesystem (%llu)",
> -			 le32_to_cpu(es->s_first_data_block),
> -			 ext4_blocks_count(es));
> -		goto failed_mount;
> -	}
> -	if ((es->s_first_data_block == 0) && (es->s_log_block_size == 0) &&
> -	    (sbi->s_cluster_ratio == 1)) {
> -		ext4_msg(sb, KERN_WARNING, "bad geometry: first data "
> -			 "block is 0 with a 1k block and cluster size");
> -		goto failed_mount;
> -	}
> -
> -	blocks_count = (ext4_blocks_count(es) -
> -			le32_to_cpu(es->s_first_data_block) +
> -			EXT4_BLOCKS_PER_GROUP(sb) - 1);
> -	do_div(blocks_count, EXT4_BLOCKS_PER_GROUP(sb));
> -	if (blocks_count > ((uint64_t)1<<32) - EXT4_DESC_PER_BLOCK(sb)) {
> -		ext4_msg(sb, KERN_WARNING, "groups count too large: %llu "
> -		       "(block count %llu, first data block %u, "
> -		       "blocks per group %lu)", blocks_count,
> -		       ext4_blocks_count(es),
> -		       le32_to_cpu(es->s_first_data_block),
> -		       EXT4_BLOCKS_PER_GROUP(sb));
> -		goto failed_mount;
> -	}
> -	sbi->s_groups_count = blocks_count;
> -	sbi->s_blockfile_groups = min_t(ext4_group_t, sbi->s_groups_count,
> -			(EXT4_MAX_BLOCK_FILE_PHYS / EXT4_BLOCKS_PER_GROUP(sb)));
> -	if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=
> -	    le32_to_cpu(es->s_inodes_count)) {
> -		ext4_msg(sb, KERN_ERR, "inodes count not valid: %u vs %llu",
> -			 le32_to_cpu(es->s_inodes_count),
> -			 ((u64)sbi->s_groups_count * sbi->s_inodes_per_group));
> -		ret = -EINVAL;
> -		goto failed_mount;
> -	}
>  	db_count = (sbi->s_groups_count + EXT4_DESC_PER_BLOCK(sb) - 1) /
>  		   EXT4_DESC_PER_BLOCK(sb);
>  	if (ext4_has_feature_meta_bg(sb)) {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
