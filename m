Return-Path: <linux-ext4+bounces-11804-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D87C50C4E
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 07:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6759F1898D54
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 06:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4662326A1B6;
	Wed, 12 Nov 2025 06:53:10 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7421ABAA;
	Wed, 12 Nov 2025 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930390; cv=none; b=A0eBhIduwd82KChvIDFaIZf4wtzBYTBg2mZrM5iMIRx2bDaBnD5MMc306FA7dDQ2T2PLo/2sTVnMDQ9+Y/BjbzvXBmoxjRnmWMdXk53EbAZdOFnk/Fpi5U19tW25rqXbJE7YS0S1hMTadG5aE/mA0DEQd7z6V5PMbzeH/cBFdlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930390; c=relaxed/simple;
	bh=Nk5NuzsIX9ZX+PzytblDuYOmPvDFXRWzyh0yApWMWcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMALDpBpg0zru2vPdnaOgZcC0Mjz0DtozlVT0fZEsRNYKlx3cfss5YkXKg+n2o49JTU7xoY+xICuB/8muJKG/g6t9c/4116PDV6p9oJTtjgHGDvhqTanLwtX2FqUShi4mqhruepCzdGeobswYyA86gLmn+2byb/rQwbiZcPDZl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d5vGx33BmzKHMM9;
	Wed, 12 Nov 2025 14:52:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9C9531A01A6;
	Wed, 12 Nov 2025 14:52:58 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBHpXvILhRpaIHZAQ--.3258S3;
	Wed, 12 Nov 2025 14:52:58 +0800 (CST)
Message-ID: <b1b73115-4b4d-49ac-b773-0d17fc72e002@huaweicloud.com>
Date: Wed, 12 Nov 2025 14:52:56 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/24] ext4: make data=journal support large block size
To: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, kernel@pankajraghav.com, mcgrof@kernel.org,
 ebiggers@kernel.org, willy@infradead.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, libaokun1@huawei.com
References: <20251111142634.3301616-1-libaokun@huaweicloud.com>
 <20251111142634.3301616-22-libaokun@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251111142634.3301616-22-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHpXvILhRpaIHZAQ--.3258S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKw1kXry8Xr13ur18Gry5CFg_yoW7GFyDpF
	y3GryrJ3ykXFyq9r4xta1UZr1Yq3WxK3yUA3s3u3Z7Zw1DJ34xKF4jkFn7AFWUJrZ7Ww4S
	qF4IkryxG3ZIk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/11/2025 10:26 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Currently, ext4_set_inode_mapping_order() does not set max folio order
> for files with the data journalling flag. For files that already have
> large folios enabled, ext4_inode_journal_mode() ignores the data
> journalling flag once max folio order is set.
> 
> This is not because data journalling cannot work with large folios, but
> because credit estimates will go through the roof if there are too many
> blocks per folio.
> 
> Since the real constraint is blocks-per-folio, to support data=journal
> under LBS, we now set max folio order to be equal to min folio order for
> files with the journalling flag. When LBS is disabled, the max folio order
> remains unset as before.
> 
> Therefore, before ext4_change_inode_journal_flag() switches the journalling
> mode, we call truncate_pagecache() to drop all page cache for that inode,
> and filemap_write_and_wait() is called unconditionally.
> 
> After that, once the journalling mode has been switched, we can safely
> reset the inode mapping order, and the mapping_large_folio_support() check
> in ext4_inode_journal_mode() can be removed.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/ext4_jbd2.c |  3 +--
>  fs/ext4/inode.c     | 32 ++++++++++++++++++--------------
>  2 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index a0e66bc10093..05e5946ed9b3 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -16,8 +16,7 @@ int ext4_inode_journal_mode(struct inode *inode)
>  	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
>  	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
>  	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
> -	    !test_opt(inode->i_sb, DELALLOC) &&
> -	    !mapping_large_folio_support(inode->i_mapping))) {
> +	    !test_opt(inode->i_sb, DELALLOC))) {
>  		/* We do not support data journalling for encrypted data */
>  		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode))
>  			return EXT4_INODE_ORDERED_DATA_MODE;  /* ordered */
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 22d215f90c64..613a989bf750 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5152,9 +5152,6 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
>  
>  	if (!S_ISREG(inode->i_mode))
>  		return false;
> -	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
> -	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
> -		return false;
>  	if (ext4_has_feature_verity(sb))
>  		return false;
>  	if (ext4_has_feature_encrypt(sb))
> @@ -5172,12 +5169,20 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
>  		umin(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
>  void ext4_set_inode_mapping_order(struct inode *inode)
>  {
> +	u32 max_order;
> +
>  	if (!ext4_should_enable_large_folio(inode))
>  		return;
>  
> +	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
> +	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
> +		max_order = EXT4_SB(inode->i_sb)->s_min_folio_order;
> +	else
> +		max_order = EXT4_MAX_PAGECACHE_ORDER(inode);
> +
>  	mapping_set_folio_order_range(inode->i_mapping,
>  				      EXT4_SB(inode->i_sb)->s_min_folio_order,
> -				      EXT4_MAX_PAGECACHE_ORDER(inode));
> +				      max_order);
>  }
>  
>  struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
> @@ -6553,14 +6558,14 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
>  	 * dirty data which can be converted only after flushing the dirty
>  	 * data (and journalled aops don't know how to handle these cases).
>  	 */
> -	if (val) {
> -		filemap_invalidate_lock(inode->i_mapping);
> -		err = filemap_write_and_wait(inode->i_mapping);
> -		if (err < 0) {
> -			filemap_invalidate_unlock(inode->i_mapping);
> -			return err;
> -		}
> +	filemap_invalidate_lock(inode->i_mapping);
> +	err = filemap_write_and_wait(inode->i_mapping);
> +	if (err < 0) {
> +		filemap_invalidate_unlock(inode->i_mapping);
> +		return err;
>  	}
> +	/* Before switch the inode journalling mode evict all the page cache. */
> +	truncate_pagecache(inode, 0);
>  
>  	alloc_ctx = ext4_writepages_down_write(inode->i_sb);
>  	jbd2_journal_lock_updates(journal);
> @@ -6585,12 +6590,11 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
>  		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
>  	}
>  	ext4_set_aops(inode);
> +	ext4_set_inode_mapping_order(inode);
>  
>  	jbd2_journal_unlock_updates(journal);
>  	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
> -
> -	if (val)
> -		filemap_invalidate_unlock(inode->i_mapping);
> +	filemap_invalidate_unlock(inode->i_mapping);
>  
>  	/* Finally we can mark the inode as dirty. */
>  


