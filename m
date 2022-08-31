Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7E15A7CBA
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 14:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiHaMAK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 08:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiHaMAJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 08:00:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE773120BF
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 05:00:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B6CC221B4;
        Wed, 31 Aug 2022 12:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661947205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z1EmoefojPqyobGMao0tZpouN9cGdFQScH5F6wgtasM=;
        b=gfXnfxCstAu7z24qHlC/4jVjR3l1Gniy85bJTGToRPjb8sipC8Jhu1juWzIs5x3eetYUWN
        IWvJuWvmncrtqKJhazK8jTc+ptroQGu+dOb3ebo1rHsEIdwPS01j81JyekdemWbrrJnjbO
        S4MKWF6M0btRh4ZcRuTE2N6qSmtDQSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661947205;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z1EmoefojPqyobGMao0tZpouN9cGdFQScH5F6wgtasM=;
        b=JiWAq1SFkOs+qM4jrnTd2rbI1FCngzMv016ZSlJRTT3K0ppASSRFgVAzpu5djzsZ5aZHHS
        gz8FrjcPpdAHNTDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22C751332D;
        Wed, 31 Aug 2022 12:00:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A4l/CEVND2PKDQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 12:00:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 74C64A067B; Wed, 31 Aug 2022 14:00:04 +0200 (CEST)
Date:   Wed, 31 Aug 2022 14:00:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 11/13] ext4: factor out ext4_group_desc_init() and
 ext4_group_desc_free()
Message-ID: <20220831120004.45nj2r3ztfm5duk4@quack3>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
 <20220830120411.2371968-12-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830120411.2371968-12-yanaijie@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 30-08-22 20:04:09, Jason Yan wrote:
> Factor out ext4_group_desc_init() and ext4_group_desc_free(). No
> functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 143 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 84 insertions(+), 59 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 4c6c4930e11b..40f155543df0 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4743,9 +4743,89 @@ static int ext4_geometry_check(struct super_block *sb,
>  	return 0;
>  }
>  
> +static void ext4_group_desc_free(struct ext4_sb_info *sbi)
> +{
> +	struct buffer_head **group_desc;
> +	int i;
> +
> +	rcu_read_lock();
> +	group_desc = rcu_dereference(sbi->s_group_desc);
> +	for (i = 0; i < sbi->s_gdb_count; i++)
> +		brelse(group_desc[i]);
> +	kvfree(group_desc);
> +	rcu_read_unlock();
> +}
> +
> +static int ext4_group_desc_init(struct super_block *sb,
> +				struct ext4_super_block *es,
> +				ext4_fsblk_t logical_sb_block,
> +				ext4_group_t *first_not_zeroed)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	unsigned int db_count;
> +	ext4_fsblk_t block;
> +	int ret;
> +	int i;
> +
> +	db_count = (sbi->s_groups_count + EXT4_DESC_PER_BLOCK(sb) - 1) /
> +		   EXT4_DESC_PER_BLOCK(sb);
> +	if (ext4_has_feature_meta_bg(sb)) {
> +		if (le32_to_cpu(es->s_first_meta_bg) > db_count) {
> +			ext4_msg(sb, KERN_WARNING,
> +				 "first meta block group too large: %u "
> +				 "(group descriptor block count %u)",
> +				 le32_to_cpu(es->s_first_meta_bg), db_count);
> +			return -EINVAL;
> +		}
> +	}
> +	rcu_assign_pointer(sbi->s_group_desc,
> +			   kvmalloc_array(db_count,
> +					  sizeof(struct buffer_head *),
> +					  GFP_KERNEL));
> +	if (sbi->s_group_desc == NULL) {
> +		ext4_msg(sb, KERN_ERR, "not enough memory");
> +		return -ENOMEM;
> +	}
> +
> +	bgl_lock_init(sbi->s_blockgroup_lock);
> +
> +	/* Pre-read the descriptors into the buffer cache */
> +	for (i = 0; i < db_count; i++) {
> +		block = descriptor_loc(sb, logical_sb_block, i);
> +		ext4_sb_breadahead_unmovable(sb, block);
> +	}
> +
> +	for (i = 0; i < db_count; i++) {
> +		struct buffer_head *bh;
> +
> +		block = descriptor_loc(sb, logical_sb_block, i);
> +		bh = ext4_sb_bread_unmovable(sb, block);
> +		if (IS_ERR(bh)) {
> +			ext4_msg(sb, KERN_ERR,
> +			       "can't read group descriptor %d", i);
> +			sbi->s_gdb_count = i;
> +			ret = PTR_ERR(bh);
> +			goto out;
> +		}
> +		rcu_read_lock();
> +		rcu_dereference(sbi->s_group_desc)[i] = bh;
> +		rcu_read_unlock();
> +	}
> +	sbi->s_gdb_count = db_count;
> +	if (!ext4_check_descriptors(sb, logical_sb_block, first_not_zeroed)) {
> +		ext4_msg(sb, KERN_ERR, "group descriptors corrupted!");
> +		ret = -EFSCORRUPTED;
> +		goto out;
> +	}
> +	return 0;
> +out:
> +	ext4_group_desc_free(sbi);
> +	return ret;
> +}
> +
>  static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  {
> -	struct buffer_head *bh, **group_desc;
> +	struct buffer_head *bh;
>  	struct ext4_super_block *es = NULL;
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct flex_groups **flex_groups;
> @@ -4755,7 +4835,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	struct inode *root;
>  	int ret = -ENOMEM;
>  	int blocksize;
> -	unsigned int db_count;
>  	unsigned int i;
>  	int needs_recovery, has_huge_files;
>  	int err = 0;
> @@ -5046,57 +5125,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	if (ext4_geometry_check(sb, es))
>  		goto failed_mount;
>  
> -	db_count = (sbi->s_groups_count + EXT4_DESC_PER_BLOCK(sb) - 1) /
> -		   EXT4_DESC_PER_BLOCK(sb);
> -	if (ext4_has_feature_meta_bg(sb)) {
> -		if (le32_to_cpu(es->s_first_meta_bg) > db_count) {
> -			ext4_msg(sb, KERN_WARNING,
> -				 "first meta block group too large: %u "
> -				 "(group descriptor block count %u)",
> -				 le32_to_cpu(es->s_first_meta_bg), db_count);
> -			goto failed_mount;
> -		}
> -	}
> -	rcu_assign_pointer(sbi->s_group_desc,
> -			   kvmalloc_array(db_count,
> -					  sizeof(struct buffer_head *),
> -					  GFP_KERNEL));
> -	if (sbi->s_group_desc == NULL) {
> -		ext4_msg(sb, KERN_ERR, "not enough memory");
> -		ret = -ENOMEM;
> +	err = ext4_group_desc_init(sb, es, logical_sb_block, &first_not_zeroed);
> +	if (err)
>  		goto failed_mount;
> -	}
> -
> -	bgl_lock_init(sbi->s_blockgroup_lock);
> -
> -	/* Pre-read the descriptors into the buffer cache */
> -	for (i = 0; i < db_count; i++) {
> -		block = descriptor_loc(sb, logical_sb_block, i);
> -		ext4_sb_breadahead_unmovable(sb, block);
> -	}
> -
> -	for (i = 0; i < db_count; i++) {
> -		struct buffer_head *bh;
> -
> -		block = descriptor_loc(sb, logical_sb_block, i);
> -		bh = ext4_sb_bread_unmovable(sb, block);
> -		if (IS_ERR(bh)) {
> -			ext4_msg(sb, KERN_ERR,
> -			       "can't read group descriptor %d", i);
> -			db_count = i;
> -			ret = PTR_ERR(bh);
> -			goto failed_mount2;
> -		}
> -		rcu_read_lock();
> -		rcu_dereference(sbi->s_group_desc)[i] = bh;
> -		rcu_read_unlock();
> -	}
> -	sbi->s_gdb_count = db_count;
> -	if (!ext4_check_descriptors(sb, logical_sb_block, &first_not_zeroed)) {
> -		ext4_msg(sb, KERN_ERR, "group descriptors corrupted!");
> -		ret = -EFSCORRUPTED;
> -		goto failed_mount2;
> -	}
>  
>  	timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
>  	spin_lock_init(&sbi->s_error_lock);
> @@ -5540,13 +5571,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	flush_work(&sbi->s_error_work);
>  	del_timer_sync(&sbi->s_err_report);
>  	ext4_stop_mmpd(sbi);
> -failed_mount2:
> -	rcu_read_lock();
> -	group_desc = rcu_dereference(sbi->s_group_desc);
> -	for (i = 0; i < db_count; i++)
> -		brelse(group_desc[i]);
> -	kvfree(group_desc);
> -	rcu_read_unlock();
> +	ext4_group_desc_free(sbi);
>  failed_mount:
>  	if (sbi->s_chksum_driver)
>  		crypto_free_shash(sbi->s_chksum_driver);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
