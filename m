Return-Path: <linux-ext4+bounces-1582-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263D8876EDB
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Mar 2024 03:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9387D1F21A77
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Mar 2024 02:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266F82D610;
	Sat,  9 Mar 2024 02:58:57 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0FC125CA
	for <linux-ext4@vger.kernel.org>; Sat,  9 Mar 2024 02:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709953136; cv=none; b=Ldr6DSfRDpMoDWF/QE4OxADev6R8z4tfEvxZzwdzFWntI8PmNN33N/EAyu0z62Fv+4jSf2eoxrsGj6MC+Iyo6LUPYcWWwKtLMMe0/GImPmgkeNm6zj7Fh03VTejNrStTfcRlyqth3rrKUfr+dn+a8aHvUbGzyCmX4zWMYCPaVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709953136; c=relaxed/simple;
	bh=fTOJz/7Qltq2II958YVp1HuudpVUlzahHp0kdbpfaug=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uIhfYGXnx7x55y4uYpB52NY0q8RgiPNBrmsxI9a97YFcnM28GepGN7656iNkvJqRlOob5UmmCVUVFpG/TXiWNI5DqZNI94CtOQhiAv3uDZaYkQ94QD9LDAswtMcUAtxs/5AP76R5M3UvF6Q/3CEkT6Y69MNFM5ccHODQJX8BaJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ts73Z2Pprz1Q9VC;
	Sat,  9 Mar 2024 10:56:42 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AD8D140121;
	Sat,  9 Mar 2024 10:58:43 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 9 Mar 2024 10:58:42 +0800
Subject: Re: [PATCH] ext4: remove unreachable discard code
To: Keith Busch <kbusch@meta.com>, <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>, Keith Busch
	<kbusch@kernel.org>
References: <20240309000943.1400879-1-kbusch@meta.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <77b00f09-63d4-6e32-df8e-e83487fbb8b8@huawei.com>
Date: Sat, 9 Mar 2024 10:58:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240309000943.1400879-1-kbusch@meta.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/3/9 8:09, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> There are no more ext4_issue_discard() users that track their own bio.
> Remove the unused parameter and the dead code that handles it.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Hello Keith!

Wenchao Hao has already submitted the same patch.

https://lore.kernel.org/linux-ext4/20240226081731.3224470-1-haowenchao2@huawei.com/

Thanks,
Yi.

> ---
>  fs/ext4/mballoc.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e4f7cf9d89c45..6314a2b000fd8 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3829,8 +3829,7 @@ void ext4_mb_release(struct super_block *sb)
>  }
>  
>  static inline int ext4_issue_discard(struct super_block *sb,
> -		ext4_group_t block_group, ext4_grpblk_t cluster, int count,
> -		struct bio **biop)
> +		ext4_group_t block_group, ext4_grpblk_t cluster, int count)
>  {
>  	ext4_fsblk_t discard_block;
>  
> @@ -3839,13 +3838,7 @@ static inline int ext4_issue_discard(struct super_block *sb,
>  	count = EXT4_C2B(EXT4_SB(sb), count);
>  	trace_ext4_discard_blocks(sb,
>  			(unsigned long long) discard_block, count);
> -	if (biop) {
> -		return __blkdev_issue_discard(sb->s_bdev,
> -			(sector_t)discard_block << (sb->s_blocksize_bits - 9),
> -			(sector_t)count << (sb->s_blocksize_bits - 9),
> -			GFP_NOFS, biop);
> -	} else
> -		return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
> +	return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
>  }
>  
>  static void ext4_free_data_in_buddy(struct super_block *sb,
> @@ -6487,7 +6480,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  	} else {
>  		if (test_opt(sb, DISCARD)) {
>  			err = ext4_issue_discard(sb, block_group, bit,
> -						 count_clusters, NULL);
> +						 count_clusters);
>  			if (err && err != -EOPNOTSUPP)
>  				ext4_msg(sb, KERN_WARNING, "discard request in"
>  					 " group:%u block:%d count:%lu failed"
> @@ -6738,7 +6731,7 @@ __acquires(bitlock)
>  	 */
>  	mb_mark_used(e4b, &ex);
>  	ext4_unlock_group(sb, group);
> -	ret = ext4_issue_discard(sb, group, start, count, NULL);
> +	ret = ext4_issue_discard(sb, group, start, count);
>  	ext4_lock_group(sb, group);
>  	mb_free_blocks(NULL, e4b, start, ex.fe_len);
>  	return ret;
> 

