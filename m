Return-Path: <linux-ext4+bounces-9192-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9856B12842
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Jul 2025 02:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CDF91C26DAC
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Jul 2025 00:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93357288DB;
	Sat, 26 Jul 2025 00:50:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32662CA5A;
	Sat, 26 Jul 2025 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491024; cv=none; b=e5+IhLHuUxmYIIRDpnvJi42bEsOxrqvrggybx35IzcmUh+TP/irOSv/CaDB0b5SSQujpvU4Y5F5bZZF6JtMa7UvBaHW4yUUfe6DkCZ7Pxyd518mNAEyJoA5XqNOH8RtXHK5OhQQK5yVrHvZK9CEDf1nxrME69ule4CPMCC1H20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491024; c=relaxed/simple;
	bh=/3c2aKYG7udY7zbDAsNEvbHD1nJ+QqSgSs3hTuZRXbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YTdZNsPyUXqhwmqDqd0bnbBKtTdAWBHu9T7DyCkXaWCt2eI1W4lZvMjyyGMnWXqK3CGXvj0pe0/tFiX1IsWyUWlH+MtWfgoIl6O4dXk8hBO0HzeiMn20+dQL0aiX4Wo2PqJKswdwZhJnnulzLray33Vo6Q3RbJWlMBlfwnIP8ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bpmJ855GTzGpwD;
	Sat, 26 Jul 2025 08:46:00 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D000180468;
	Sat, 26 Jul 2025 08:50:12 +0800 (CST)
Received: from [10.174.177.71] (10.174.177.71) by
 dggpemf500013.china.huawei.com (7.185.36.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Jul 2025 08:50:11 +0800
Message-ID: <2d59bf3d-212c-418f-97ac-2157ab1c2628@huawei.com>
Date: Sat, 26 Jul 2025 08:50:10 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] ext4: convert free groups order lists to xarrays
Content-Language: en-GB
To: Zhang Yi <yi.zhang@huaweicloud.com>, Theodore Ts'o <tytso@mit.edu>
CC: Guenter Roeck <linux@roeck-us.net>, <linux-ext4@vger.kernel.org>,
	<adilger.kernel@dilger.ca>, <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
	<ojaswin@linux.ibm.com>, <julia.lawall@inria.fr>, <yangerkun@huawei.com>,
	<libaokun@huaweicloud.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-16-libaokun1@huawei.com>
 <b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net>
 <20250724045456.GA80823@mit.edu>
 <ef789a81-f326-4af6-8e9b-a13b5b20412b@huawei.com>
 <20250724145437.GD80823@mit.edu>
 <4b8b6482-f2f5-4fa5-949a-6d999c335319@huaweicloud.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <4b8b6482-f2f5-4fa5-949a-6d999c335319@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 7/25/2025 10:28 AM, Zhang Yi wrote:
> On 2025/7/24 22:54, Theodore Ts'o wrote:
>> On Thu, Jul 24, 2025 at 07:14:58PM +0800, Zhang Yi wrote:
>>> I'm sorry for this regression, we didn't run these tests.
>> No worries, I didn't run them either.
>>
>>> Could you please try the following diff? I have tested it on my
>>> machine, and the issue does not recur. If every thing looks fine, I
>>> will send out the official patch.
>> This patch fixes the test bug which was causing the failure of
>> test_new_blocks_simple.
>>
> The official patch to fix test_new_blocks_simple for the next
> branch:
>
> https://lore.kernel.org/linux-ext4/20250725021550.3177573-1-yi.zhang@huaweicloud.com/
>
>> However, there is still test failure of test_mb_mark_used in the patch
>> series starting with bbe11dd13a3f ("ext4: fix largest free orders
>> lists corruption on mb_optimize_scan switch").  The test failure is
>> fixed by 458bfb991155 ("ext4: convert free groups order lists to
>> xarrays").  The reason why this is especialy problematic is that
>> commit which introduced the problem is marked as "cc: stable", which
>> means it will get back ported to LTS kernels, thus introducing a
>> potential bug.
>>
> Indeed!
>
>> One of the advantages of unit tests is that they are light weight
>> enough that it is tractable to run them against every commit in the
>> patch series.  So we should strive to add more unit tests, since it
>> makes easier to detect regressions.
>>
>> Anyway, here's the stack trace staring with "ext4: fix largest free
>> orders lists corruption on mb_optimize_scan switch".  Could you
>> investigate this failure?  Many thanks!!
>>
> Sure! I've sent out the fix that applies to the kernel that has only
> merged bbe11dd13a3f ("ext4: fix largest free orders lists corruption
> on mb_optimize_scan switch"), but not merged 458bfb991155 ("ext4:
> convert free groups order lists to xarrays"). Please give it a try.
>
> https://lore.kernel.org/linux-ext4/20250725021654.3188798-1-yi.zhang@huaweicloud.com/
>
Sorry for the late reply, I haven't had time to look into this this week.
I really appreciate Yi for taking the time to help address these issues.
I'm also very sorry for introducing a regression in the ext4 kunit tests.


Thanks,
Baokun

>
>> [09:35:46] ==================== test_mb_mark_used  ====================
>> [09:35:46] [ERROR] Test: test_mb_mark_used: missing subtest result line!
>> [09:35:46]
>> [09:35:46] Pid: 35, comm: kunit_try_catch Tainted: G        W        N  6.16.0-rc4-00031-gbbe11dd13a3f-dirty
>> [09:35:46] RIP: 0033:mb_set_largest_free_order+0x5c/0xc0
>> [09:35:46] RSP: 00000000a0883d98  EFLAGS: 00010206
>> [09:35:46] RAX: 0000000060aeaa28 RBX: 0000000060a2d400 RCX: 0000000000000008
>> [09:35:46] RDX: 0000000060aea9c0 RSI: 0000000000000000 RDI: 0000000060864000
>> [09:35:46] RBP: 0000000060aea9c0 R08: 0000000000000000 R09: 0000000060a2d400
>> [09:35:46] R10: 0000000000000400 R11: 0000000060a9cc00 R12: 0000000000000006
>> [09:35:46] R13: 0000000000000400 R14: 0000000000000305 R15: 0000000000000000
>> [09:35:46] Kernel panic - not syncing: Segfault with no mm
>> [09:35:46] CPU: 0 UID: 0 PID: 35 Comm: kunit_try_catch Tainted: G        W        N  6.16.0-rc4-00031-gbbe11dd13a3f-dirty #36 NONE
>> [09:35:46] Tainted: [W]=WARN, [N]=TEST
>> [09:35:46] Stack:
>> [09:35:46]  60210c60 00000200 60a9e400 00000400
>> [09:35:46]  40060300280 60864000 60a9cc00 60a2d400
>> [09:35:46]  00000400 60aea9c0 60a9cc00 60aea9c0
>> [09:35:46] Call Trace:
>> [09:35:46]  [<60210c60>] ? ext4_mb_generate_buddy+0x1f0/0x230
>> [09:35:46]  [<60215c3b>] ? test_mb_mark_used+0x28b/0x4e0
>> [09:35:46]  [<601df5bc>] ? ext4_get_group_desc+0xbc/0x150
>> [09:35:46]  [<600bf1c0>] ? ktime_get_ts64+0x0/0x190
>> [09:35:46]  [<60086370>] ? to_kthread+0x0/0x40
>> [09:35:46]  [<602b559b>] ? kunit_try_run_case+0x7b/0x100
>> [09:35:46]  [<60086370>] ? to_kthread+0x0/0x40
>> [09:35:46]  [<602b7850>] ? kunit_generic_run_threadfn_adapter+0x0/0x30
>> [09:35:46]  [<602b7862>] ? kunit_generic_run_threadfn_adapter+0x12/0x30
>> [09:35:46]  [<60086a51>] ? kthread+0xf1/0x250
>> [09:35:46]  [<6004a541>] ? new_thread_handler+0x41/0x60
>> [09:35:46] [ERROR] Test: test_mb_mark_used: 0 tests run!
>> [09:35:46] ============= [NO TESTS RUN] test_mb_mark_used =============
>>


