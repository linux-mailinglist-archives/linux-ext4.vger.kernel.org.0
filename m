Return-Path: <linux-ext4+bounces-9138-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0E3B0C574
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 15:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D096A3A4C4C
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 13:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EF32D9797;
	Mon, 21 Jul 2025 13:45:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876B52D97BD;
	Mon, 21 Jul 2025 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105540; cv=none; b=Wjz5S3bbCySD/LovDexULQc48FD8N16VWb8eVCAzMgavAevzZ7ciNKa9Nf4C50CjO092+H27zJqW2e+OBat3w77yvfNpD+DSwYLG1sV5C5lbF1nbKqUmZy+AJKPEkEUzQmjTDBzfKCvLKXfSVWlrboxNyzJ2KanaHa6gUy/nQQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105540; c=relaxed/simple;
	bh=1A9N82rpMrM4KRVgIj6NghfrE40sK6A4fFITF7n6YuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jo1YAIq9+QL5Y/G471yfacm6Sz990R0g2f2U4jjKlMnQBDGqxXv3Seev9SfhUiA5KGBLQSlnnS2dAbVsB/etey1nBZXMsXpO2aY88ynaI4gg3t2DTduTVOjQ54/mudP+ms+5RJ/nqV61RP0jEkp+ztnoC8DDBTCqfnmRVu0e/PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bm1kj19PMzSjfK;
	Mon, 21 Jul 2025 21:41:01 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D92F1800B1;
	Mon, 21 Jul 2025 21:45:32 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 21 Jul
 2025 21:45:31 +0800
Message-ID: <4b5a7a7a-a4db-4d4d-8931-c57ffd231006@huawei.com>
Date: Mon, 21 Jul 2025 21:45:30 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] ext4: convert free groups order lists to xarrays
To: <tytso@mit.edu>, Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun@huaweicloud.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-16-libaokun1@huawei.com>
 <iulwol5ygqv7fry543vuoawhn7fjzlz7hmai5stjxqkkvvz6pc@wukeepjempwn>
 <47e62021-fd2c-44ba-be34-e12b2a486efb@huawei.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <47e62021-fd2c-44ba-be34-e12b2a486efb@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

在 2025/7/21 20:33, Baokun Li 写道:
> On 2025/7/21 19:07, Jan Kara wrote:
>> On Mon 14-07-25 21:03:25, Baokun Li wrote:
>>> |CPU: Kunpeng 920   |          P80           |            P1           |
>>> |Memory: 512GB      |------------------------|-------------------------|
>>> |960GB SSD (0.5GB/s)| base  |    patched     | base   |    patched     |
>>> |-------------------|-------|----------------|--------|----------------|
>>> |mb_optimize_scan=0 | 20097 | 19555 (-2.6%)  | 316141 | 315636 (-0.2%) |
>>> |mb_optimize_scan=1 | 13318 | 15496 (+16.3%) | 325273 | 323569 (-0.5%) |
>>>
>>> |CPU: AMD 9654 * 2  |          P96           |             P1          |
>>> |Memory: 1536GB     |------------------------|-------------------------|
>>> |960GB SSD (1GB/s)  | base  |    patched     | base   |    patched     |
>>> |-------------------|-------|----------------|--------|----------------|
>>> |mb_optimize_scan=0 | 53603 | 53192 (-0.7%)  | 214243 | 212678 (-0.7%) |
>>> |mb_optimize_scan=1 | 20887 | 37636 (+80.1%) | 213632 | 214189 (+0.2%) |
>>>
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> The patch looks good and the results are nice. I've just noticed two 
>> typos:
>>
>>> +static inline void ext4_mb_avg_fragment_size_destory(struct 
>>> ext4_sb_info *sbi)
>>                         ^^^ destroy
>>
>>
>>> +static inline void ext4_mb_largest_free_orders_destory(struct 
>>> ext4_sb_info *sbi)
>>                           ^^^ destroy
> 
> Hi Jan, thanks for the review! While examining this patch, I also
> identified a comment formatting error that I regret overlooking previously.
> My apologies for this oversight.
> 
> Hey Ted, could you please help apply the following diff to correct the
> spelling errors and comment formatting issues? Or would you prefer I send
> out a new patch series or a separate cleanup patch?
> 
> 
Sorry, thunderbird is automatically converting tabs to spaces in the
code, try the diff below.


Thanks,
Baokun


diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a9eb997b8c9b..c61955cba370 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -863,10 +863,10 @@ mb_update_avg_fragment_size(struct super_block 
*sb, struct ext4_group_info *grp)
  	grp->bb_avg_fragment_size_order = new;
  	if (new >= 0) {
  		/*
-		* Cannot use __GFP_NOFAIL because we hold the group lock.
-		* Although allocation for insertion may fails, it's not fatal
-		* as we have linear traversal to fall back on.
-		*/
+		 * Cannot use __GFP_NOFAIL because we hold the group lock.
+		 * Although allocation for insertion may fails, it's not fatal
+		 * as we have linear traversal to fall back on.
+		 */
  		int err = xa_insert(&sbi->s_mb_avg_fragment_size[new],
  				    grp->bb_group, grp, GFP_ATOMIC);
  		if (err)
@@ -1201,10 +1201,10 @@ mb_set_largest_free_order(struct super_block 
*sb, struct ext4_group_info *grp)
  	grp->bb_largest_free_order = new;
  	if (test_opt2(sb, MB_OPTIMIZE_SCAN) && new >= 0 && grp->bb_free) {
  		/*
-		* Cannot use __GFP_NOFAIL because we hold the group lock.
-		* Although allocation for insertion may fails, it's not fatal
-		* as we have linear traversal to fall back on.
-		*/
+		 * Cannot use __GFP_NOFAIL because we hold the group lock.
+		 * Although allocation for insertion may fails, it's not fatal
+		 * as we have linear traversal to fall back on.
+		 */
  		int err = xa_insert(&sbi->s_mb_largest_free_orders[new],
  				    grp->bb_group, grp, GFP_ATOMIC);
  		if (err)
@@ -3657,14 +3657,14 @@ static void ext4_discard_work(struct work_struct 
*work)
  		ext4_mb_unload_buddy(&e4b);
  }

-static inline void ext4_mb_avg_fragment_size_destory(struct 
ext4_sb_info *sbi)
+static inline void ext4_mb_avg_fragment_size_destroy(struct 
ext4_sb_info *sbi)
  {
  	for (int i = 0; i < MB_NUM_ORDERS(sbi->s_sb); i++)
  		xa_destroy(&sbi->s_mb_avg_fragment_size[i]);
  	kfree(sbi->s_mb_avg_fragment_size);
  }

-static inline void ext4_mb_largest_free_orders_destory(struct 
ext4_sb_info *sbi)
+static inline void ext4_mb_largest_free_orders_destroy(struct 
ext4_sb_info *sbi)
  {
  	for (int i = 0; i < MB_NUM_ORDERS(sbi->s_sb); i++)
  		xa_destroy(&sbi->s_mb_largest_free_orders[i]);
@@ -3818,8 +3818,8 @@ int ext4_mb_init(struct super_block *sb)
  	kfree(sbi->s_mb_last_groups);
  	sbi->s_mb_last_groups = NULL;
  out:
-	ext4_mb_avg_fragment_size_destory(sbi);
-	ext4_mb_largest_free_orders_destory(sbi);
+	ext4_mb_avg_fragment_size_destroy(sbi);
+	ext4_mb_largest_free_orders_destroy(sbi);
  	kfree(sbi->s_mb_offsets);
  	sbi->s_mb_offsets = NULL;
  	kfree(sbi->s_mb_maxs);
@@ -3886,8 +3886,8 @@ void ext4_mb_release(struct super_block *sb)
  		kvfree(group_info);
  		rcu_read_unlock();
  	}
-	ext4_mb_avg_fragment_size_destory(sbi);
-	ext4_mb_largest_free_orders_destory(sbi);
+	ext4_mb_avg_fragment_size_destroy(sbi);
+	ext4_mb_largest_free_orders_destroy(sbi);
  	kfree(sbi->s_mb_offsets);
  	kfree(sbi->s_mb_maxs);
  	iput(sbi->s_buddy_cache);


