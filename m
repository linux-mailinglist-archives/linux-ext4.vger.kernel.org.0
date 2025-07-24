Return-Path: <linux-ext4+bounces-9175-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7476EB108D2
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 13:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9E25A2DB0
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 11:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A191426D4C2;
	Thu, 24 Jul 2025 11:15:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF426CE2E;
	Thu, 24 Jul 2025 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355707; cv=none; b=blVQ28n0T/DrOQMxQf3u3FzmhlgPT1awi5HfyXwlAcO7zjCU7lgYH5lkY1PVm40MUIJyAi1QX/r82jPTY9Kln4iYG60l+NltYB2BxuoyalK9tB0xoG75nRmhHz0/bf/47+WOOWv4Gjux+97vZjHA56aVQ1WhJBpxfF8kpNCMFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355707; c=relaxed/simple;
	bh=88d0iTKD7BU1lwMS7b8/Zwhd9iGZ1C4vT/jsn17AVk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oFCVBpPfjZRgEsTVRYOshk+b6MXXp6Gu8bniIWYIQsDKw/gPfZ58NxCVlqN4uFGs8DLqcObeHod0FImupdJoJF5TXuw4smCVCxQlt+IsJj976iNsDPXzW5rhRE60AtEonYpbLkXxNvt8qLXry/DA1V7MgKTu3id7AYwixN+ZeNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bnpN00vvCz27g6k;
	Thu, 24 Jul 2025 19:16:00 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id A663518001B;
	Thu, 24 Jul 2025 19:14:59 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 19:14:58 +0800
Message-ID: <ef789a81-f326-4af6-8e9b-a13b5b20412b@huawei.com>
Date: Thu, 24 Jul 2025 19:14:58 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] ext4: convert free groups order lists to xarrays
To: Theodore Ts'o <tytso@mit.edu>, Guenter Roeck <linux@roeck-us.net>
CC: Baokun Li <libaokun1@huawei.com>, <linux-ext4@vger.kernel.org>,
	<adilger.kernel@dilger.ca>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
	<ojaswin@linux.ibm.com>, <julia.lawall@inria.fr>, <yangerkun@huawei.com>,
	<libaokun@huaweicloud.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-16-libaokun1@huawei.com>
 <b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net>
 <20250724045456.GA80823@mit.edu>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <20250724045456.GA80823@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2025/7/24 12:54, Theodore Ts'o wrote:
> On Wed, Jul 23, 2025 at 08:55:14PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Mon, Jul 14, 2025 at 09:03:25PM +0800, Baokun Li wrote:
>>> While traversing the list, holding a spin_lock prevents load_buddy, making
>>> direct use of ext4_try_lock_group impossible. This can lead to a bouncing
>>> scenario where spin_is_locked(grp_A) succeeds, but ext4_try_lock_group()
>>> fails, forcing the list traversal to repeatedly restart from grp_A.
>>>
>>
>> This patch causes crashes for pretty much every architecture when
>> running unit tests as part of booting.
> 
> I'm assuming that you're using a randconfig that happened to enable
> CONFIG_EXT4_KUNIT_TESTS=y.
> 
> A simpler reprducer is to have a .kunitconfig containing:
> 
> CONFIG_KUNIT=y
> CONFIG_KUNIT_TEST=y
> CONFIG_KUNIT_EXAMPLE_TEST=y
> CONFIG_EXT4_KUNIT_TESTS=y
> 
> ... and then run :./tools/testing/kunit/kunit.py run".
> 
> The first failure is actually with [11/17] ext4: fix largest free
> orders lists corruption on mb_optimize_scan switch, which triggers a
> failure of test_mb_mark_used.
> 
> Baokun, can you take a look please?   Many thanks!
> 

Hi Ted and Guenter,

I'm sorry for this regression, we didn't run these tests. Baokun is
currently on a business trip, so I help to look into this issue. The
reason for the failure is that the variable initialization in the
mb unit tests are insufficient, but this series relies on them.

Could you please try the following diff? I have tested it on my
machine, and the issue does not recur. If every thing looks fine, I
will send out the official patch.

Thanks,
Yi.


diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index d634c12f1984..a9416b20ff64 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -155,6 +155,7 @@ static struct super_block *mbt_ext4_alloc_super_block(void)
 	bgl_lock_init(sbi->s_blockgroup_lock);

 	sbi->s_es = &fsb->es;
+	sbi->s_sb = sb;
 	sb->s_fs_info = sbi;

 	up_write(&sb->s_umount);
@@ -802,6 +803,8 @@ static void test_mb_mark_used(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, ret, 0);

 	grp->bb_free = EXT4_CLUSTERS_PER_GROUP(sb);
+	grp->bb_largest_free_order = -1;
+	grp->bb_avg_fragment_size_order = -1;
 	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
 	for (i = 0; i < TEST_RANGE_COUNT; i++)
 		test_mb_mark_used_range(test, &e4b, ranges[i].start,
@@ -875,6 +878,8 @@ static void test_mb_free_blocks(struct kunit *test)
 	ext4_unlock_group(sb, TEST_GOAL_GROUP);

 	grp->bb_free = 0;
+	grp->bb_largest_free_order = -1;
+	grp->bb_avg_fragment_size_order = -1;
 	memset(bitmap, 0xff, sb->s_blocksize);

 	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);




