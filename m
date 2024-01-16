Return-Path: <linux-ext4+bounces-791-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ECA82E669
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 02:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EC41F2206A
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 01:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C936510971;
	Tue, 16 Jan 2024 01:03:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7E101E8
	for <linux-ext4@vger.kernel.org>; Tue, 16 Jan 2024 01:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TDW1773jXzvTrQ;
	Tue, 16 Jan 2024 09:01:31 +0800 (CST)
Received: from kwepemd200008.china.huawei.com (unknown [7.221.188.40])
	by mail.maildlp.com (Postfix) with ESMTPS id 2088C180071;
	Tue, 16 Jan 2024 09:02:55 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemd200008.china.huawei.com (7.221.188.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 16 Jan 2024 09:02:54 +0800
Message-ID: <4284c67d-eefd-d4eb-2df3-d863ca4651b4@huawei.com>
Date: Tue, 16 Jan 2024 09:02:53 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount
 with discard
To: yangerkun <yangerkun@huaweicloud.com>, <tytso@mit.edu>,
	<adilger.kernel@dilger.ca>
CC: <boyu.mt@taobao.com>, <linux-ext4@vger.kernel.org>
References: <20231230070654.178638-1-yangerkun@huaweicloud.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <20231230070654.178638-1-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200008.china.huawei.com (7.221.188.40)

Ping...

在 2023/12/30 15:06, yangerkun 写道:
> Commit 3d56b8d2c74c ("ext4: Speed up FITRIM by recording flags in
> ext4_group_info") speed up fstrim by skipping trim trimmed group. We
> also has the chance to clear trimmed once there exists some block free
> for this group(mount without discard), and the next trim for this group
> will work well too.
> 
> For mount with discard, we will issue dicard when we free blocks, so
> leave trimmed flag keep alive to skip useless trim trigger from
> userspace seems reasonable. But for some case like ext4 build on
> dm-thinpool(ext4 blocksize 4K, pool blocksize 128K), discard from ext4
> maybe unaligned for dm thinpool, and thinpool will just finish this
> discard(see process_discard_bio when begein equals to end) without
> actually process discard. For this case, trim from userspace can really
> help us to free some thinpool block.
> 
> So convert to clear trimmed flag for all case no matter mounted with
> discard or not.
> 
> Fixes: 3d56b8d2c74c ("ext4: Speed up FITRIM by recording flags in ext4_group_info")
> Signed-off-by: yangerkun <yangerkun@huaweicloud.com>
> ---
>   fs/ext4/mballoc.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d72b5e3c92ec..69240ae775f1 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3855,11 +3855,8 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
>   	/*
>   	 * Clear the trimmed flag for the group so that the next
>   	 * ext4_trim_fs can trim it.
> -	 * If the volume is mounted with -o discard, online discard
> -	 * is supported and the free blocks will be trimmed online.
>   	 */
> -	if (!test_opt(sb, DISCARD))
> -		EXT4_MB_GRP_CLEAR_TRIMMED(db);
> +	EXT4_MB_GRP_CLEAR_TRIMMED(db);
>   
>   	if (!db->bb_free_root.rb_node) {
>   		/* No more items in the per group rb tree
> @@ -6481,8 +6478,9 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>   					 " group:%u block:%d count:%lu failed"
>   					 " with %d", block_group, bit, count,
>   					 err);
> -		} else
> -			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
> +		}
> +
> +		EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
>   
>   		ext4_lock_group(sb, block_group);
>   		mb_free_blocks(inode, &e4b, bit, count_clusters);

