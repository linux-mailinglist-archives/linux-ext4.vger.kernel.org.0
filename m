Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6D85B17E8
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 11:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIHJAf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 05:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiIHJAe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 05:00:34 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379EBFD22D
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 02:00:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v4so16068022pgi.10
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 02:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1586W6GOzj6ZRMCLQMnEiKZAkDjuIWgBgwI852OhQPY=;
        b=VSQcDC0N5V55squAm5OkGkDDQxfEdVFUGWrOr2W/MrsmBxW2V8WrkddCobN3aQTeRR
         x/xCRyp3nK1I0CcvESftv8reqtkNfjQoiKuqDF5+cqxO8zwAeGELaQAEih3ySDQ3JHG8
         jX2eMKDWk3bDpizOSs9gnpmS7iGceVw05QNTk1hFYdJe641NjKamfO0jrD921wQe9VYz
         humO7PJ1D54Pl2MF1YekIgbm2//SDrnSvr7SeNpxohQQiILFRAeKc+VCrTmsSzVgs3U/
         +7H6BW/MEhdo3c2FoXP7INjLrEzP61Vv/pDX7q06deXozbZ4aFDOH9uK0XWGgRJVpDsl
         udRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1586W6GOzj6ZRMCLQMnEiKZAkDjuIWgBgwI852OhQPY=;
        b=7hy8tNGj0Prov7e3DYWMUqq8zBAqZsmpvHQtG8MQAEVknWbRcGoLnnr2wpfNZsGBvT
         dhipAiBPCHQXTFLdBRHpiz6LikNoJFEsfFQtp2mgiPmQ3jpnysx/2lbKqLBSUKfPNlsX
         f8xY8cOSCkjA4ADEDT/Gdn5xdKwGuFxqVGN6Kmo4TI02LbqxNvxyExB3maQ3wnzvcZUq
         84GfB0BydQ6pHoPgmbU6APFuVP2TJN5u2+cK/oB4ZpR1acWoQ7tlxZvGuJfE1hEP7ECh
         BgqUxJTLVFm/xXuDQXWXlpJ2L9NIrQ3xZ92XvqyyXVRAvzWfq0OFRGraPoAK6XeIGlDd
         a1hA==
X-Gm-Message-State: ACgBeo10QoSWknm2NniTRFHaVh3o+vgS0Ig5n+/LfORuUKDdrpkgYQsS
        xN3Xl+EQaIUfIlaZ2FUGVFs=
X-Google-Smtp-Source: AA6agR6pSnEctV2Yo3KA1W3M+GVkoeGUC7ZTk3TtJhYN4Tnob0A0T6Q61bqyjl9YMx6M2GrHI7Az+g==
X-Received: by 2002:a62:6085:0:b0:53e:7874:5067 with SMTP id u127-20020a626085000000b0053e78745067mr6886476pfb.4.1662627630739;
        Thu, 08 Sep 2022 02:00:30 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id w23-20020a17090a8a1700b001fd7fe7d369sm1206581pjn.54.2022.09.08.02.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:00:30 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:30:25 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        lczerner@redhat.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 10/13] ext4: factor out ext4_geometry_check()
Message-ID: <20220908090025.7aw2nsfnp5mzgewn@riteshh-domain>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-11-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903030156.770313-11-yanaijie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/03 11:01AM, Jason Yan wrote:
> Factor out ext4_geometry_check(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 111 ++++++++++++++++++++++++++----------------------
>  1 file changed, 61 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 5f0e7c5188a3..69921a850644 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4683,6 +4683,66 @@ static int ext4_check_feature_compatibility(struct super_block *sb,
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

This had initially confused me. But then I saw we by default always have
ret = -EINVAL.

This patch looks good to me. 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> -		goto failed_mount;
> -	}
>  	db_count = (sbi->s_groups_count + EXT4_DESC_PER_BLOCK(sb) - 1) /
>  		   EXT4_DESC_PER_BLOCK(sb);
>  	if (ext4_has_feature_meta_bg(sb)) {
> -- 
> 2.31.1
> 
