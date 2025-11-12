Return-Path: <linux-ext4+bounces-11806-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9537FC50D42
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 08:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C71C188C196
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 07:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0112E719C;
	Wed, 12 Nov 2025 06:56:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF32B212F98;
	Wed, 12 Nov 2025 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930603; cv=none; b=K/lggWry1TNgJy0XG+bm1dHRZ41zJtK8B3e6P79VFinh5CCS9PXn4aBfIx1UH4k3UzPsymeR4+wTYnG0vbzlZRVeFzbBmsoo7RXxedIe0qa5G4QydCn3q8ljjc5NpXVMu68yGP6ozMbgxRWGlUwNrmzulZ3G1o3Od3E3yl/TrtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930603; c=relaxed/simple;
	bh=PpprAHAsPdz3yIbk6xTNfUr18VSWAtQ7Udns6Fw/W4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgxZV16xCovX5y8/wsA3JLONNV4UCx+Ylhbi+RTN3JG7SyhnS/NsPCW4QgJM5JLlOiMlN9y9W2EAUx06Ar66uDSRL/1EiU1iE6siMv2oJBXFXxgnrW7j2+9bmhpx0FghYC54LqDW7iQblN7W5TWLflkDxUFVClAef+nxgjrHnsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5vLy6JtmzYQtwq;
	Wed, 12 Nov 2025 14:56:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id DF0D01A1D65;
	Wed, 12 Nov 2025 14:56:38 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgAnhXulLxRp4c3ZAQ--.3517S3;
	Wed, 12 Nov 2025 14:56:38 +0800 (CST)
Message-ID: <ba84c018-916c-4e26-889b-368d3610225d@huaweicloud.com>
Date: Wed, 12 Nov 2025 14:56:37 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/24] ext4: add checks for large folio
 incompatibilities when BS > PS
To: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, kernel@pankajraghav.com, mcgrof@kernel.org,
 ebiggers@kernel.org, willy@infradead.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, libaokun1@huawei.com
References: <20251111142634.3301616-1-libaokun@huaweicloud.com>
 <20251111142634.3301616-24-libaokun@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251111142634.3301616-24-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnhXulLxRp4c3ZAQ--.3517S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKw1fuw43Jry3GFy8KF1xZrb_yoW7AF48pF
	W3CF1furW8ZF9rurs7tanrXr1Yvay8tayUJ34xua4UJr9xt34IkFW09F1FyFyUtrWUXryx
	Xa18try29wsrKFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	0PfPUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/11/2025 10:26 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Supporting a block size greater than the page size (BS > PS) requires
> support for large folios. However, several features (e.g., encrypt)
> do not yet support large folios.
> 
> To prevent conflicts, this patch adds checks at mount time to prohibit
> these features from being used when BS > PS. Since these features cannot
> be changed on remount, there is no need to check on remount.
> 
> This patch adds s_max_folio_order, initialized during mount according to
> filesystem features and mount options. If s_max_folio_order is 0, large
> folios are disabled.
> 
> With this in place, ext4_set_inode_mapping_order() can be simplified by
> checking s_max_folio_order, avoiding redundant checks.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/ext4.h  |  4 +++-
>  fs/ext4/inode.c | 38 ++++++++++----------------------------
>  fs/ext4/super.c | 39 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 4bc0b2b7288a..79dc231d6e22 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1696,7 +1696,9 @@ struct ext4_sb_info {
>  	unsigned long s_last_trim_minblks;
>  
>  	/* minimum folio order of a page cache allocation */
> -	unsigned int s_min_folio_order;
> +	u16 s_min_folio_order;
> +	/* supported maximum folio order, 0 means not supported */
> +	u16 s_max_folio_order;
>  
>  	/* Precomputed FS UUID checksum for seeding other checksums */
>  	__u32 s_csum_seed;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 7b979e64f481..c38cb811f2ae 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5146,41 +5146,23 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
>  	return -EFSCORRUPTED;
>  }
>  
> -static bool ext4_should_enable_large_folio(struct inode *inode)
> +void ext4_set_inode_mapping_order(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
> +	u16 min_order, max_order;
>  
> -	if (!S_ISREG(inode->i_mode))
> -		return false;
> -	if (ext4_has_feature_encrypt(sb))
> -		return false;
> -
> -	return true;
> -}
> -
> -/*
> - * Limit the maximum folio order to 2048 blocks to prevent overestimation
> - * of reserve handle credits during the folio writeback in environments
> - * where the PAGE_SIZE exceeds 4KB.
> - */
> -#define EXT4_MAX_PAGECACHE_ORDER(i)		\
> -		umin(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
> -void ext4_set_inode_mapping_order(struct inode *inode)
> -{
> -	u32 max_order;
> +	max_order = EXT4_SB(sb)->s_max_folio_order;
> +	if (!max_order)
> +		return;
>  
> -	if (!ext4_should_enable_large_folio(inode))
> +	min_order = EXT4_SB(sb)->s_min_folio_order;
> +	if (!min_order && !S_ISREG(inode->i_mode))
>  		return;
>  
> -	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
> -	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
> -		max_order = EXT4_SB(inode->i_sb)->s_min_folio_order;
> -	else
> -		max_order = EXT4_MAX_PAGECACHE_ORDER(inode);
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
> +		max_order = min_order;
>  
> -	mapping_set_folio_order_range(inode->i_mapping,
> -				      EXT4_SB(inode->i_sb)->s_min_folio_order,
> -				      max_order);
> +	mapping_set_folio_order_range(inode->i_mapping, min_order, max_order);
>  }
>  
>  struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0d32370a459a..f1aeba47b0e3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5040,6 +5040,41 @@ static const char *ext4_has_journal_option(struct super_block *sb)
>  	return NULL;
>  }
>  
> +/*
> + * Limit the maximum folio order to 2048 blocks to prevent overestimation
> + * of reserve handle credits during the folio writeback in environments
> + * where the PAGE_SIZE exceeds 4KB.
> + */
> +#define EXT4_MAX_PAGECACHE_ORDER(sb)		\
> +		umin(MAX_PAGECACHE_ORDER, (11 + (sb)->s_blocksize_bits - PAGE_SHIFT))
> +static void ext4_set_max_mapping_order(struct super_block *sb)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +
> +	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
> +		sbi->s_max_folio_order = sbi->s_min_folio_order;
> +	else
> +		sbi->s_max_folio_order = EXT4_MAX_PAGECACHE_ORDER(sb);
> +}
> +
> +static int ext4_check_large_folio(struct super_block *sb)
> +{
> +	const char *err_str = NULL;
> +
> +	if (ext4_has_feature_encrypt(sb))
> +		err_str = "encrypt";
> +
> +	if (!err_str) {
> +		ext4_set_max_mapping_order(sb);
> +	} else if (sb->s_blocksize > PAGE_SIZE) {
> +		ext4_msg(sb, KERN_ERR, "bs(%lu) > ps(%lu) unsupported for %s",
> +			 sb->s_blocksize, PAGE_SIZE, err_str);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
>  			   int silent)
>  {
> @@ -5316,6 +5351,10 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  
>  	ext4_apply_options(fc, sb);
>  
> +	err = ext4_check_large_folio(sb);
> +	if (err < 0)
> +		goto failed_mount;
> +
>  	err = ext4_encoding_init(sb, es);
>  	if (err)
>  		goto failed_mount;


