Return-Path: <linux-ext4+bounces-1390-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 070028677D3
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Feb 2024 15:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BCE6B26D10
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Feb 2024 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EE012C556;
	Mon, 26 Feb 2024 14:06:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51C912BF3D;
	Mon, 26 Feb 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956382; cv=none; b=DgAB7Z+cXdFkVu/iOVxVWi3JlTCKHy3KbWMgYjgWAPqOH/H0u2IZuZ3V7Ka7v1QInMuAZrng8RDzz4YFf6ljIq8VUvMoexqTED/ecg2pq/vlQ1uWTJuHFCq7DhqnZhWLp19jNWpJE/1iRJu/bgLa9KhoWfT1mCUeSJcEGtYVFAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956382; c=relaxed/simple;
	bh=FYCrbv8lR+vqpkF25UfiF/snYND+v7+9Kz2QpvWdZ5A=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=C6ew6GWLfrN50FkS6CAgbEWpjIS4jkncmgGAahcyEa4tlR0/TiMkcDdPr6gjhRbHNKSW8ihWmQm27MwOQmAuTOswe7yg7hsmMHSih+s9V5EZa4QnYkHyoGRdUwrzKaEnYR5G2+TQmc58evQuP36Hs8Zp8i3754E8qJFN1WNLElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tk2R709B5z2BdgF;
	Mon, 26 Feb 2024 22:04:03 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 679D21A016C;
	Mon, 26 Feb 2024 22:06:16 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 22:06:15 +0800
Subject: Re: [PATCH] ext4: remove unused parameter biop in
 ext4_issue_discard()
To: Wenchao Hao <haowenchao2@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <louhongxiang@huawei.com>
References: <20240226081731.3224470-1-haowenchao2@huawei.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <71d17598-c39b-9e11-03f0-cb344a24d8a5@huawei.com>
Date: Mon, 26 Feb 2024 22:06:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240226081731.3224470-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/2/26 16:17, Wenchao Hao wrote:
> all caller of ext4_issue_discard() would set biop to NULL since
> 'commit 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread
> contex")', it's unnecessary to keep this parameter any more.
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>

Thanks for the patch, it looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/mballoc.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d72b5e3c92ec..1590ee3f4603 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3807,8 +3807,7 @@ int ext4_mb_release(struct super_block *sb)
>  }
>  
>  static inline int ext4_issue_discard(struct super_block *sb,
> -		ext4_group_t block_group, ext4_grpblk_t cluster, int count,
> -		struct bio **biop)
> +		ext4_group_t block_group, ext4_grpblk_t cluster, int count)
>  {
>  	ext4_fsblk_t discard_block;
>  
> @@ -3817,13 +3816,8 @@ static inline int ext4_issue_discard(struct super_block *sb,
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
> +
> +	return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
>  }
>  
>  static void ext4_free_data_in_buddy(struct super_block *sb,
> @@ -6475,7 +6469,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  	} else {
>  		if (test_opt(sb, DISCARD)) {
>  			err = ext4_issue_discard(sb, block_group, bit,
> -						 count_clusters, NULL);
> +						 count_clusters);
>  			if (err && err != -EOPNOTSUPP)
>  				ext4_msg(sb, KERN_WARNING, "discard request in"
>  					 " group:%u block:%d count:%lu failed"
> @@ -6726,7 +6720,7 @@ __acquires(bitlock)
>  	 */
>  	mb_mark_used(e4b, &ex);
>  	ext4_unlock_group(sb, group);
> -	ret = ext4_issue_discard(sb, group, start, count, NULL);
> +	ret = ext4_issue_discard(sb, group, start, count);
>  	ext4_lock_group(sb, group);
>  	mb_free_blocks(NULL, e4b, start, ex.fe_len);
>  	return ret;
> 

