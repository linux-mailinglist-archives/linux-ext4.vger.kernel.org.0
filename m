Return-Path: <linux-ext4+bounces-9136-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423C4B0C427
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 14:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6633C17EEFC
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 12:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B52D0C69;
	Mon, 21 Jul 2025 12:33:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE31288C80;
	Mon, 21 Jul 2025 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753101220; cv=none; b=qgbZjlLq8v3jP8gRk1aejy+ooAjC/dkdw4q6xlnO7a7GdefzyIxtyIjFhkCvM8ppfT+AZf9A+4B0nsnjffCi/mtm701VsdhSaq7d2Q7qbZMCtgurylQx7m3cm3zQJQ9INYH6wRLekzTM5SEh7Su3nwlXAwIuOK4W7JwlRkLq+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753101220; c=relaxed/simple;
	bh=jbi3gdLhgbY8y0sSVk3Du7QKtAy5NLs9pLsQiY1QMjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VFqaETAl1A6iBcQaVRyL/xgfKHMzrfG6uc8wmpaSFcAoouLd2DDNqYOb9aJZklmaYYvgio1lNtFxVDcyhAV8nv4LNRS8hHx+RkRhAUi8FEaVSNkZaz5nuTRtKxs67ueHIr0RcZ3H7edbISVsTsLkqJ0vjSSrA9LCJxAz5nvpwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bm0836yVzzdc2Q;
	Mon, 21 Jul 2025 20:29:23 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 854CC1402CD;
	Mon, 21 Jul 2025 20:33:33 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 21 Jul
 2025 20:33:32 +0800
Message-ID: <47e62021-fd2c-44ba-be34-e12b2a486efb@huawei.com>
Date: Mon, 21 Jul 2025 20:33:31 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] ext4: convert free groups order lists to xarrays
To: Jan Kara <jack@suse.cz>, <tytso@mit.edu>
CC: <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun@huaweicloud.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-16-libaokun1@huawei.com>
 <iulwol5ygqv7fry543vuoawhn7fjzlz7hmai5stjxqkkvvz6pc@wukeepjempwn>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <iulwol5ygqv7fry543vuoawhn7fjzlz7hmai5stjxqkkvvz6pc@wukeepjempwn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/7/21 19:07, Jan Kara wrote:
> On Mon 14-07-25 21:03:25, Baokun Li wrote:
>> |CPU: Kunpeng 920   |          P80           |            P1           |
>> |Memory: 512GB      |------------------------|-------------------------|
>> |960GB SSD (0.5GB/s)| base  |    patched     | base   |    patched     |
>> |-------------------|-------|----------------|--------|----------------|
>> |mb_optimize_scan=0 | 20097 | 19555 (-2.6%)  | 316141 | 315636 (-0.2%) |
>> |mb_optimize_scan=1 | 13318 | 15496 (+16.3%) | 325273 | 323569 (-0.5%) |
>>
>> |CPU: AMD 9654 * 2  |          P96           |             P1          |
>> |Memory: 1536GB     |------------------------|-------------------------|
>> |960GB SSD (1GB/s)  | base  |    patched     | base   |    patched     |
>> |-------------------|-------|----------------|--------|----------------|
>> |mb_optimize_scan=0 | 53603 | 53192 (-0.7%)  | 214243 | 212678 (-0.7%) |
>> |mb_optimize_scan=1 | 20887 | 37636 (+80.1%) | 213632 | 214189 (+0.2%) |
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> The patch looks good and the results are nice. I've just noticed two typos:
>
>> +static inline void ext4_mb_avg_fragment_size_destory(struct ext4_sb_info *sbi)
> 						^^^ destroy
>
>
>> +static inline void ext4_mb_largest_free_orders_destory(struct ext4_sb_info *sbi)
> 						  ^^^ destroy

Hi Jan, thanks for the review! While examining this patch, I also
identified a comment formatting error that I regret overlooking previously.
My apologies for this oversight.

Hey Ted, could you please help apply the following diff to correct the
spelling errors and comment formatting issues? Or would you prefer I send
out a new patch series or a separate cleanup patch?


Thanks,
Baokun

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a9eb997b8c9b..c61955cba370 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -863,10 +863,10 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
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
@@ -1201,10 +1201,10 @@ mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
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
@@ -3657,14 +3657,14 @@ static void ext4_discard_work(struct work_struct *work)
  		ext4_mb_unload_buddy(&e4b);
  }
  
-static inline void ext4_mb_avg_fragment_size_destory(struct ext4_sb_info *sbi)
+static inline void ext4_mb_avg_fragment_size_destroy(struct ext4_sb_info *sbi)
  {
  	for (int i = 0; i < MB_NUM_ORDERS(sbi->s_sb); i++)
  		xa_destroy(&sbi->s_mb_avg_fragment_size[i]);
  	kfree(sbi->s_mb_avg_fragment_size);
  }
  
-static inline void ext4_mb_largest_free_orders_destory(struct ext4_sb_info *sbi)
+static inline void ext4_mb_largest_free_orders_destroy(struct ext4_sb_info *sbi)
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



