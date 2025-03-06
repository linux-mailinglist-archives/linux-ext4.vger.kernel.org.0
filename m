Return-Path: <linux-ext4+bounces-6678-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4169FA5414C
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 04:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C03D189293B
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 03:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C882A1991B6;
	Thu,  6 Mar 2025 03:43:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1DC2E40B;
	Thu,  6 Mar 2025 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741232585; cv=none; b=sP0y7mHddwXyd6i1H7rdY7YMTfCYjNdpv6Q+5ljwg7dboBiGjGsmflkhrAvancrrGKfbn7hHJlhcECUwaexVD7LGdCYEFc3T2nsyLX0HpKg0eTyFBJ8Inu+A0vhTBuhAF/Gxw33M6U43loG9IXE2LPJ2JZ7019wqu25/4NCn7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741232585; c=relaxed/simple;
	bh=ElPuR1VBpHVrD65cy+vRi9vkDd2fOLW0UkokVlU8EVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aO/Hz6Qtpypq2Ssg/iiXnK29MM6hRZuZqXsVQaGor4OusxBG0LUmH7Y0ZShThpyN/aUhaQ/9PI6PJC1UgzKiG2GiCX4JxZ1T69Ym5pJU09cB/t8OkIXGY6LAkOg8pJSyk/XNlrKvkXfD+AaGfMIyi00KSSxrm5+Q4pE9qBLIV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z7Zs16cZhz2Dkpv;
	Thu,  6 Mar 2025 11:38:45 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 79D4D14037C;
	Thu,  6 Mar 2025 11:42:59 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 6 Mar
 2025 11:42:58 +0800
Message-ID: <a4befb79-8fdd-4b30-a278-85c5ad549c6e@huawei.com>
Date: Thu, 6 Mar 2025 11:42:57 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential Linux Crash: KASAN slab-out-of-bounds Read in
 ext4_find_extent in Linux kernel v6.13-rc5
To: Luka <luka.2016.cs@gmail.com>
CC: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
	<linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yang Erkun
	<yangerkun@huawei.com>
References: <CALm_T+3Tup+nmgA_CEw1RGGq=Ur-R0HyVdLX5xFzhF7nnK8g1g@mail.gmail.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <CALm_T+3Tup+nmgA_CEw1RGGq=Ur-R0HyVdLX5xFzhF7nnK8g1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/3/6 11:08, Luka wrote:
> Dear Linux Kernel Experts,
>
> Hello!
>
> I am a security researcher focused on testing Linux kernel
> vulnerabilities. Recently, while testing the v6.13-rc5 Linux kernel,
> we encountered a crash related to the fs/ext4 kernel module. We have
> successfully captured the call trace information for this crash.
>
> Unfortunately, we have not been able to reproduce the issue in our
> local environment, so we are unable to provide a PoC (Proof of
> Concept) at this time.
>
> We fully understand the complexity and importance of Linux kernel
> maintenance, and we would like to share this finding with you for
> further analysis and confirmation of the root cause. Below is a
> summary of the relevant information:
>
> Kernel Version: v6.13-rc5
>
> Kernel Module: fs/ext4/extents.c
>
> ————————————————CallTrace————————————————
>
> BUG: KASAN: slab-out-of-bounds in ext4_ext_binsearch
> fs/ext4/extents.c:840 [inline]
> BUG: KASAN: slab-out-of-bounds in ext4_find_extent+0x9b8/0xa00
> fs/ext4/extents.c:955
> Read of size 4 at addr ffff888107037aa0 by task kworker/u16:3/50
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: writeback wb_workfn (flush-7:6)
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x7b/0xa0 lib/dump_stack.c:120
>   print_address_description mm/kasan/report.c:378 [inline]
>   print_report+0xce/0x660 mm/kasan/report.c:489
>   kasan_report+0xc6/0x100 mm/kasan/report.c:602
>   ext4_ext_binsearch fs/ext4/extents.c:840 [inline]
>   ext4_find_extent+0x9b8/0xa00 fs/ext4/extents.c:955
>   ext4_ext_map_blocks+0x1bc/0x4e70 fs/ext4/extents.c:4205
>   ext4_map_create_blocks fs/ext4/inode.c:516 [inline]
>   ext4_map_blocks+0x3c8/0x11c0 fs/ext4/inode.c:702
>   mpage_map_one_extent fs/ext4/inode.c:2219 [inline]
>   mpage_map_and_submit_extent fs/ext4/inode.c:2272 [inline]
>   ext4_do_writepages+0x15b1/0x3040 fs/ext4/inode.c:2735
>   ext4_writepages+0x275/0x510 fs/ext4/inode.c:2824
>   do_writepages+0x197/0x7b0 mm/page-writeback.c:2702
>   __writeback_single_inode+0xe5/0x950 fs/fs-writeback.c:1680
>   writeback_sb_inodes+0x593/0xd00 fs/fs-writeback.c:1976
>   wb_writeback+0x188/0x790 fs/fs-writeback.c:2156
>   wb_do_writeback fs/fs-writeback.c:2303 [inline]
>   wb_workfn+0x1d2/0xa50 fs/fs-writeback.c:2343
>   process_one_work+0x61a/0x1050 kernel/workqueue.c:3229
>   process_scheduled_works kernel/workqueue.c:3310 [inline]
>   worker_thread+0x8cc/0x1160 kernel/workqueue.c:3391
>   kthread+0x25a/0x330 kernel/kthread.c:389
>   ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>
>
> Allocated by task 5054:
>   kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>   unpoison_slab_object mm/kasan/common.c:319 [inline]
>   __kasan_slab_alloc+0x6e/0x70 mm/kasan/common.c:345
>   kasan_slab_alloc include/linux/kasan.h:250 [inline]
>   slab_post_alloc_hook mm/slub.c:4119 [inline]
>   slab_alloc_node mm/slub.c:4168 [inline]
>   kmem_cache_alloc_noprof+0xf5/0x360 mm/slub.c:4175
>   getname_flags.part.0+0x48/0x4e0 fs/namei.c:139
>   getname_flags include/linux/audit.h:322 [inline]
>   getname+0x84/0xd0 fs/namei.c:223
>   getname_maybe_null include/linux/fs.h:2796 [inline]
>   vfs_fstatat fs/stat.c:361 [inline]
>   vfs_stat include/linux/fs.h:3392 [inline]
>   __do_sys_newstat+0x93/0x130 fs/stat.c:503
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 5054:
>   kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
>   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>   kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
>   poison_slab_object mm/kasan/common.c:247 [inline]
>   __kasan_slab_free+0x37/0x50 mm/kasan/common.c:264
>   kasan_slab_free include/linux/kasan.h:233 [inline]
>   slab_free_hook mm/slub.c:2353 [inline]
>   slab_free mm/slub.c:4613 [inline]
>   kmem_cache_free+0xec/0x380 mm/slub.c:4715
>   putname+0x111/0x150 fs/namei.c:296
>   vfs_fstatat fs/stat.c:367 [inline]
>   vfs_stat include/linux/fs.h:3392 [inline]
>   __do_sys_newstat+0xbc/0x130 fs/stat.c:503
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>
>
> ————————————————CallTrace————————————————
>
> If you need more details or additional test results, please feel free
> to let us know. Thank you so much for your attention! Please don't
> hesitate to reach out if you have any suggestions or need further
> communication.
>
> Best regards,
> Luka
>
Is there a reliable reproducer? Was CONFIG_BLK_DEV_WRITE_MOUNTED disabled
during testing? This appears to be a known issue caused by writing to a
bare disk.

The other two look like they might be the same thing:

https://lore.kernel.org/all/CALm_T+3qoQAChNSzULwKOvYDmvkxC8U5moKM5JEVRocR62s3yQ@mail.gmail.com
https://lore.kernel.org/all/CALm_T+1DnSQRHiyO3c1-H4rRnBJHKRMpfQYQMGN=yZROm7tYKQ@mail.gmail.com


