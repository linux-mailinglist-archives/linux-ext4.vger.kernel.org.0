Return-Path: <linux-ext4+bounces-9184-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2F1B11668
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Jul 2025 04:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7684E48D1
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Jul 2025 02:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD88230BC3;
	Fri, 25 Jul 2025 02:28:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340102E36FA;
	Fri, 25 Jul 2025 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753410518; cv=none; b=VQJjvdn4CZImI9Rqltg6lcWY9wg0gUtau6mzfCnA99u82OcFzHnsFBYPjkaUJfh0fRuBtzLLXvH0X0h9OTvoX6KkLV69e+RfevEI2lisv763I872oUqZ/k6lzB2ZsBVN5bNVFqj89sUwqZpi3iQ+ys45f5cBBTO0ePS+L3RMBSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753410518; c=relaxed/simple;
	bh=mVH4Deu7lTBr6qoBv1axjy8mcSZfGuKrujSG0GLjZRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lj+Q8i+2Tx9aGrFJ2LxhLFuNLBfhNbxF2D45XolAgQxipZ93PNoRSzuJ9hu4XuIXZd26frc14E8zLNL05v7gKvzzi9gJGgV90Yjb0Qg5XqBKRb0vmoHd9s+FGhl7fFUzgMK8iY4lhqHWBQ4FdFSwSIODNel7c8qPR88lTHRFF14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bpBcx3xdCzKHMTd;
	Fri, 25 Jul 2025 10:28:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4DD391A0E9D;
	Fri, 25 Jul 2025 10:28:32 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDXUxTM64JoZQOZBQ--.15225S3;
	Fri, 25 Jul 2025 10:28:30 +0800 (CST)
Message-ID: <4b8b6482-f2f5-4fa5-949a-6d999c335319@huaweicloud.com>
Date: Fri, 25 Jul 2025 10:28:28 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] ext4: convert free groups order lists to xarrays
To: Theodore Ts'o <tytso@mit.edu>
Cc: Guenter Roeck <linux@roeck-us.net>, Baokun Li <libaokun1@huawei.com>,
 linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, julia.lawall@inria.fr,
 yangerkun@huawei.com, libaokun@huaweicloud.com
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-16-libaokun1@huawei.com>
 <b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net>
 <20250724045456.GA80823@mit.edu>
 <ef789a81-f326-4af6-8e9b-a13b5b20412b@huawei.com>
 <20250724145437.GD80823@mit.edu>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250724145437.GD80823@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXUxTM64JoZQOZBQ--.15225S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur1DAw4UZr1UWrWftryxXwb_yoWrWFWfpF
	Z8Kasagr40yryxXrW7A3WIgF1qvr47C3W7Xr1fG348XF18Cw1DXF1IyayUGr48Kw48Zr1I
	yF13Arn8tw1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2025/7/24 22:54, Theodore Ts'o wrote:
> On Thu, Jul 24, 2025 at 07:14:58PM +0800, Zhang Yi wrote:
>>
>> I'm sorry for this regression, we didn't run these tests.
> 
> No worries, I didn't run them either.
> 
>> Could you please try the following diff? I have tested it on my
>> machine, and the issue does not recur. If every thing looks fine, I
>> will send out the official patch.
> 
> This patch fixes the test bug which was causing the failure of
> test_new_blocks_simple.
> 

The official patch to fix test_new_blocks_simple for the next
branch:

https://lore.kernel.org/linux-ext4/20250725021550.3177573-1-yi.zhang@huaweicloud.com/

> However, there is still test failure of test_mb_mark_used in the patch
> series starting with bbe11dd13a3f ("ext4: fix largest free orders
> lists corruption on mb_optimize_scan switch").  The test failure is
> fixed by 458bfb991155 ("ext4: convert free groups order lists to
> xarrays").  The reason why this is especialy problematic is that
> commit which introduced the problem is marked as "cc: stable", which
> means it will get back ported to LTS kernels, thus introducing a
> potential bug.
> 

Indeed!

> One of the advantages of unit tests is that they are light weight
> enough that it is tractable to run them against every commit in the
> patch series.  So we should strive to add more unit tests, since it
> makes easier to detect regressions.
> 
> Anyway, here's the stack trace staring with "ext4: fix largest free
> orders lists corruption on mb_optimize_scan switch".  Could you
> investigate this failure?  Many thanks!!
> 

Sure! I've sent out the fix that applies to the kernel that has only
merged bbe11dd13a3f ("ext4: fix largest free orders lists corruption
on mb_optimize_scan switch"), but not merged 458bfb991155 ("ext4:
convert free groups order lists to xarrays"). Please give it a try.

https://lore.kernel.org/linux-ext4/20250725021654.3188798-1-yi.zhang@huaweicloud.com/

Best Regards,
Yi.

> 
> [09:35:46] ==================== test_mb_mark_used  ====================
> [09:35:46] [ERROR] Test: test_mb_mark_used: missing subtest result line!
> [09:35:46] 
> [09:35:46] Pid: 35, comm: kunit_try_catch Tainted: G        W        N  6.16.0-rc4-00031-gbbe11dd13a3f-dirty
> [09:35:46] RIP: 0033:mb_set_largest_free_order+0x5c/0xc0
> [09:35:46] RSP: 00000000a0883d98  EFLAGS: 00010206
> [09:35:46] RAX: 0000000060aeaa28 RBX: 0000000060a2d400 RCX: 0000000000000008
> [09:35:46] RDX: 0000000060aea9c0 RSI: 0000000000000000 RDI: 0000000060864000
> [09:35:46] RBP: 0000000060aea9c0 R08: 0000000000000000 R09: 0000000060a2d400
> [09:35:46] R10: 0000000000000400 R11: 0000000060a9cc00 R12: 0000000000000006
> [09:35:46] R13: 0000000000000400 R14: 0000000000000305 R15: 0000000000000000
> [09:35:46] Kernel panic - not syncing: Segfault with no mm
> [09:35:46] CPU: 0 UID: 0 PID: 35 Comm: kunit_try_catch Tainted: G        W        N  6.16.0-rc4-00031-gbbe11dd13a3f-dirty #36 NONE
> [09:35:46] Tainted: [W]=WARN, [N]=TEST
> [09:35:46] Stack:
> [09:35:46]  60210c60 00000200 60a9e400 00000400
> [09:35:46]  40060300280 60864000 60a9cc00 60a2d400
> [09:35:46]  00000400 60aea9c0 60a9cc00 60aea9c0
> [09:35:46] Call Trace:
> [09:35:46]  [<60210c60>] ? ext4_mb_generate_buddy+0x1f0/0x230
> [09:35:46]  [<60215c3b>] ? test_mb_mark_used+0x28b/0x4e0
> [09:35:46]  [<601df5bc>] ? ext4_get_group_desc+0xbc/0x150
> [09:35:46]  [<600bf1c0>] ? ktime_get_ts64+0x0/0x190
> [09:35:46]  [<60086370>] ? to_kthread+0x0/0x40
> [09:35:46]  [<602b559b>] ? kunit_try_run_case+0x7b/0x100
> [09:35:46]  [<60086370>] ? to_kthread+0x0/0x40
> [09:35:46]  [<602b7850>] ? kunit_generic_run_threadfn_adapter+0x0/0x30
> [09:35:46]  [<602b7862>] ? kunit_generic_run_threadfn_adapter+0x12/0x30
> [09:35:46]  [<60086a51>] ? kthread+0xf1/0x250
> [09:35:46]  [<6004a541>] ? new_thread_handler+0x41/0x60
> [09:35:46] [ERROR] Test: test_mb_mark_used: 0 tests run!
> [09:35:46] ============= [NO TESTS RUN] test_mb_mark_used =============
> 


