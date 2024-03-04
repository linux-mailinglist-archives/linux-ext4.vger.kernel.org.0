Return-Path: <linux-ext4+bounces-1490-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDA086FA17
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 07:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C800B20C23
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 06:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D893111A0;
	Mon,  4 Mar 2024 06:33:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01B010A10;
	Mon,  4 Mar 2024 06:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709534032; cv=none; b=ZefgRtUAWkUtuPJ5kjBqrVNreDERY8YtEOHyMVMyvS2q0ud2gQgFB/WvZ3B/9oMoyrzHEaQ6CLeH6OIiAidczmFd0FIx4i/ixG9flyG/PSbqdKgon33hpZLGNh70wXDBN8PbOBFwBOfmxlSP7NSROjUiU5mFw6BgaHA8mgR4vbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709534032; c=relaxed/simple;
	bh=WRrLMBUeGs4Z+7mBNZqfHwhqMfVZ1MqNODPVECCY+Qg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=m0vHIMiUt+1IeRdcunhJ6bBbpWKkYh/U0jqKTqOxw7ofPc0s7uSFB9Xl1S1mxaNMaKi/QEF+muW7xyjD8/Kjk/NZlk7FQ0DnAINxvZ8GZdNvLhqeHzwaNdYhT0GHnQV2uPkCavDE756SyIqo4mylCe5AJqrQdZUPCjCS9pwnTBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tp86B6DdKz4f3l2R;
	Mon,  4 Mar 2024 14:33:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3E0291A017A;
	Mon,  4 Mar 2024 14:33:44 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgCH2GpFa+Vlc3zwFw--.11474S2;
	Mon, 04 Mar 2024 14:33:42 +0800 (CST)
Subject: Re: [PATCH v3 0/3] Fix crashes and warning in ext4 unit test
To: Guenter Roeck <linux@roeck-us.net>, tytso@mit.edu,
 adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 naresh.kamboju@linaro.org, daniel.diaz@linaro.org, brauner@kernel.org
References: <20240302181755.9192-1-shikemeng@huaweicloud.com>
 <77c5b612-83f1-40b6-95f2-f3962bb2de5c@roeck-us.net>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <c5f0f654-2eed-4900-c9ce-c668d77379bf@huaweicloud.com>
Date: Mon, 4 Mar 2024 14:33:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <77c5b612-83f1-40b6-95f2-f3962bb2de5c@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH2GpFa+Vlc3zwFw--.11474S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCryfCF4ftw4kCrWxuF48Zwb_yoWrZr1kpr
	18tFW5KrWrJrn7J3W3Jw1UJry3ta1Iy3WUGrn7GF15CF1UGr1jvr1jqrWjgryDtr48Xw1j
	q3srWw1j9w1UJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/3/2024 11:33 PM, Guenter Roeck wrote:
> On 3/2/24 10:17, Kemeng Shi wrote:
>> v2->v3:
>> -fix warning that sb->s_umount is still held when unit test finishs
>> -fix warning that sbi->s_freeclusters_counter is used before
>> initialization.
>>
>> v1->v2:
>> -properly handle error from sget()
>>
>> Previously, the new mballoc unit tests are only tested by running
>> "./tools/testing/kunit/kunit.py run ..." in which case only rare configs
>> are enabled.
>> This series fixes issues when more debug configs are enabled. Fixes are
>> tested with and without kunit_tool [1].
>>
>> [1] https://docs.kernel.org/dev-tools/kunit/run_manual.html
>>
>> Kemeng Shi (3):
>>    ext4: alloc test super block from sget
>>    ext4: hold group lock in ext4 kunit test
>>    ext4: initialize sbi->s_freeclusters_counter before use in kunit test
>>
>>   fs/ext4/mballoc-test.c | 77 ++++++++++++++++++++++++++++++++----------
>>   1 file changed, 60 insertions(+), 17 deletions(-)
>>
> 
> I still see crashes with this version. Some examples below.
> 
Thanks so much for the test and report. It's likely cuased by using
sbi->s_dirtyclusters_counter uninitialized. Will fix it in next
version.

Kemeng
> Guenter
> 
> ---
> mips:
> 
>         KTAP version 1
>         # Subtest: test_mark_diskspace_used
> CPU 0 Unable to handle kernel paging request at virtual address 00780000, epc == 807a4b28, ra == 807a4c20
> Oops[#1]:
> CPU: 0 PID: 112 Comm: kunit_try_catch Tainted: G                 N 6.8.0-rc6-next-20240301-11397-g2cd922b7255b #1
> Hardware name: mti,malta
> $ 0   : 00000000 00000001 00780000 00000000
> $ 4   : 811c6de0 00000000 00000001 00000000
> $ 8   : 00000005 00000000 82f0cc00 00000001
> $12   : ffffffff 00000002 00000000 fff80000
> $16   : 82d99558 811c6de0 00000000 00000020
> $20   : 811c0000 00000000 00000001 00000000
> $24   : 00000000 80415884
> $28   : 82f1c000 82f1f9f8 00000000 807a4c20
> Hi    : 00000000
> Lo    : 00002128
> epc   : 807a4b28 percpu_counter_add_batch+0x7c/0x224
> ra    : 807a4c20 percpu_counter_add_batch+0x174/0x224
> Status: 1000a402    KERNEL EXL
> Cause : 00800008 (ExcCode 02)
> BadVA : 00780000
> PrId  : 00019300 (MIPS 24Kc)
> Modules linked in:
> Process kunit_try_catch (pid: 112, threadinfo=82f1c000, task=82c2cec0, tls=00000000)
> Stack : 82d99400 b332f3f3 00000000 b332f3f3 82f1fb20 811c0000 00000000 00000000
>         811c0000 82d99400 82d63800 00000008 00000000 80414ac4 00000000 801a4aa4
>         00000001 00000000 00000020 00000001 00000000 82f1fa70 00000000 00000023
>         00000080 82f1fb20 82f1fb20 00000380 82c2cec0 00000000 00000000 b332f3f3
>         82f1fae0 00000025 82d63800 821bbc08 00000001 00000001 821f12a8 82f0cc00
>         ...
> Call Trace:
> [<807a4b28>] percpu_counter_add_batch+0x7c/0x224
> [<80414ac4>] ext4_mb_mark_diskspace_used+0x25c/0x26c
> [<80414ba4>] test_mark_diskspace_used+0xd0/0x308
> [<806e8fe0>] kunit_try_run_case+0x70/0x204
> [<806eb1dc>] kunit_generic_run_threadfn_adapter+0x1c/0x28
> [<80162be0>] kthread+0x128/0x150
> [<80103038>] ret_from_kernel_thread+0x14/0x1c
> Code: 02242021  8c820000  00431021 <8c5e0000> 001e17c3  03d5a021  00523021  029e902b  02469021
> ---[ end trace 0000000000000000 ]---
> 
> Various arm emulations:
> [    6.617298]         # Subtest: test_mark_diskspace_used
> [    6.620243]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> [    6.622190] 8<--- cut here ---
> [    6.622374] Unable to handle kernel paging request at virtual address 0a3f6000 when read
> [    6.622549] [0a3f6000] *pgd=00000000
> [    6.622960] Internal error: Oops: 5 [#1] SMP ARM
> [    6.623138] Modules linked in:
> [    6.623342] CPU: 0 PID: 187 Comm: kunit_try_catch Tainted: G                 N 6.8.0-rc6-next-20240301-11397-g2cd922b7255b #1
> [    6.623573] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
> [    6.623738] PC is at percpu_counter_add_batch+0x2c/0x110
> [    6.624171] LR is at percpu_counter_add_batch+0xa8/0x110
> 
> 


