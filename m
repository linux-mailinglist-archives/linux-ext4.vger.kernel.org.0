Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E443F5BC1
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Aug 2021 12:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhHXKNB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Aug 2021 06:13:01 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18032 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbhHXKMx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Aug 2021 06:12:53 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gv4Yr4Yrwzbhh1;
        Tue, 24 Aug 2021 18:08:16 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 24 Aug 2021 18:11:59 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 24 Aug 2021 18:11:59 +0800
Subject: Re: [PATCH] ext4: flush s_error_work before journal destroy in
 ext4_fill_super
From:   yangerkun <yangerkun@huawei.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <jack@suse.cz>, <linux-ext4@vger.kernel.org>, <yukuai3@huawei.com>
References: <20210720062409.960734-1-yangerkun@huawei.com>
 <YPqx2hPUuTkJo/sj@mit.edu> <eb962c26-b013-957b-7931-feda7f8bf5b5@huawei.com>
Message-ID: <3296465e-8da2-99ac-32cf-9cde32f4de32@huawei.com>
Date:   Tue, 24 Aug 2021 18:11:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <eb962c26-b013-957b-7931-feda7f8bf5b5@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sorry for that this patch will lead a bug when mount failed on arm64(I 
have verify this patch on x86, and it seems ok...).

I will try to fix the problem with another way....

[2021-08-24 17:43:29 INFO] [   45.808127] Internal error: Oops: 96000004 
[#1] SMP
[2021-08-24 17:43:29 INFO] [   45.812986] Modules linked in: realtek 
hclge hns3 megaraid_sas hisi_sas_v3_hw hibmc_drm hisi_sas_main 
host_edma_drv hnae3
[2021-08-24 17:43:29 INFO] [   45.823896] Process mount (pid: 1187, 
stack limit = 0x00000000e0bd7181)
[2021-08-24 17:43:29 INFO] [   45.830481] CPU: 9 PID: 1187 Comm: mount 
Not tainted 4.19.90_4.19.90-2108.7.0+ #2
[2021-08-24 17:43:29 INFO] [   45.837929] Hardware name: Huawei TaiShan 
2280 V2/BC82AMDC, BIOS 2280-V2 CS V3.26.01 06/14/2019
[2021-08-24 17:43:29 INFO] [   45.846587] pstate: 10400009 (nzcV daif 
+PAN -UAO)
[2021-08-24 17:43:29 INFO] [   45.851359] pc : 
percpu_counter_add_batch+0x5c/0x358
[2021-08-24 17:43:29 INFO] [   45.856303] lr : 
ext4_es_free_extent+0xd4/0x4a8
[2021-08-24 17:43:29 INFO] [   45.860812] sp : ffff80262a60f170
[2021-08-24 17:43:29 INFO] [   45.864112] x29: ffff80262a60f170 x28: 
dfff200000000000
[2021-08-24 17:43:29 INFO] [   45.869399] x27: ffff8026403e65cc x26: 
0000000000000000
[2021-08-24 17:43:29 INFO] [   45.874686] x25: ffff80266c429e20 x24: 
0000000000000100
[2021-08-24 17:43:29 INFO] [   45.879973] x23: 1ffff004cd8853c4 x22: 
ffffffffffffffff
[2021-08-24 17:43:29 INFO] [   45.885260] x21: 0000000000000000 x20: 
00006026b7a31000
[2021-08-24 17:43:29 INFO] [   45.890547] x19: ffff80266c429e00 x18: 
0000000000000000
[2021-08-24 17:43:29 INFO] [   45.895833] x17: 0000000000000000 x16: 
0000000000000000
[2021-08-24 17:43:29 INFO] [   45.901120] x15: 1fffe4000504bd02 x14: 
ffff200023ba1adc
[2021-08-24 17:43:29 INFO] [   45.906406] x13: ffff200024332530 x12: 
ffff20002433240c
[2021-08-24 17:43:29 INFO] [   45.911693] x11: ffff2000243304f4 x10: 
ffff200024328f6c
[2021-08-24 17:43:29 INFO] [   45.916980] x9 : 1ffff004c807ccb9 x8 : 
ffff200023b75950
[2021-08-24 17:43:29 INFO] [   45.922266] x7 : ffff200023ba1fe0 x6 : 
0000000000000004
[2021-08-24 17:43:29 INFO] [   45.927553] x5 : 0000000000000000 x4 : 
0000000000000000
[2021-08-24 17:43:29 INFO] [   45.932839] x3 : 00000c04d6f46200 x2 : 
dfff200000000000
[2021-08-24 17:43:29 INFO] [   45.938126] x1 : 0000000000000003 x0 : 
00006026b7a31000
[2021-08-24 17:43:29 INFO] [   45.943413] Call trace:
[2021-08-24 17:43:29 INFO] [   45.945851] 
percpu_counter_add_batch+0x5c/0x358
[2021-08-24 17:43:29 INFO] [   45.950446]  ext4_es_free_extent+0xd4/0x4a8
[2021-08-24 17:43:29 INFO] [   45.954610]  __es_remove_extent+0x37c/0x598
[2021-08-24 17:43:29 INFO] [   45.958773]  ext4_es_remove_extent+0x6c/0x270
[2021-08-24 17:43:29 INFO] [   45.963110]  ext4_clear_inode+0x50/0x188
[2021-08-24 17:43:29 INFO] [   45.967016]  ext4_evict_inode+0x314/0x1450
[2021-08-24 17:43:29 INFO] [   45.971094]  evict+0x238/0x5a0
[2021-08-24 17:43:29 INFO] [   45.974136]  iput+0x2bc/0x6b8
[2021-08-24 17:43:29 INFO] [   45.977090]  jbd2_journal_destroy+0x408/0x800
[2021-08-24 17:43:29 INFO] [   45.981428]  ext4_fill_super+0x5a04/0x8cc0
[2021-08-24 17:43:29 INFO] [   45.985505]  mount_bdev+0x268/0x328
[2021-08-24 17:43:29 INFO] [   45.988978]  ext4_mount+0x44/0x58
[2021-08-24 17:43:29 INFO] [   45.992277]  mount_fs+0x68/0x390
[2021-08-24 17:43:29 INFO] [   45.995492]  vfs_kern_mount.part.2+0x54/0x388
[2021-08-24 17:43:29 INFO] [   45.999830]  do_mount+0xa5c/0x20d0
[2021-08-24 17:43:29 INFO] [   46.003216]  ksys_mount+0x9c/0x118
[2021-08-24 17:43:29 INFO] [   46.006603]  __arm64_sys_mount+0xa8/0x108
[2021-08-24 17:43:29 INFO] [   46.010595]  el0_svc_common+0x10c/0x4a0
[2021-08-24 17:43:29 INFO] [   46.014415]  el0_svc_handler+0x170/0x248
[2021-08-24 17:43:29 INFO] [   46.018320]  el0_svc+0x10/0x218
[2021-08-24 17:43:29 INFO] [   46.021448] Code: f2fbffe2 d343fc03 
92400801 11000c21 (38e26862)
[2021-08-24 17:43:29 INFO] [   46.027513] ---[ end trace 
316fdb8833588599 ]---
[2021-08-24 17:43:29 INFO] [   46.037646] Kernel panic - not syncing: 
Fatal exception
[2021-08-24 17:43:29 INFO] [   46.042848] SMP: stopping secondary CPUs
[2021-08-24 17:43:29 INFO] [   46.046779] Kernel Offset: 0x1baf0000 from 
0xffff200008000000
[2021-08-24 17:43:29 INFO] [   46.052500] CPU features: 0x12,a2a00a38
[2021-08-24 17:43:29 INFO] [   46.056318] Memory Limit: none
[2021-08-24 17:43:29 INFO] [   46.064887] Rebooting in 1 seconds..
[2021-08-24 17:43:30 INFO] [   47.068489] SMP: stopping secondary CPUs
[2021-08-24 17:43:32 INFO] [   48.158471] SMP: failed to stop secondary 
CPUs 0-127

在 2021/7/23 21:25, yangerkun 写道:
> 
> 
> 在 2021/7/23 20:11, Theodore Ts'o 写道:
>> On Tue, Jul 20, 2021 at 02:24:09PM +0800, yangerkun wrote:
>>> 'commit c92dc856848f ("ext4: defer saving error info from atomic
>>> context")' and '2d01ddc86606 ("ext4: save error info to sb through 
>>> journal
>>> if available")' add s_error_work to fix checksum error problem. But the
>>> error path in ext4_fill_super can lead the follow BUG_ON.
>>
>> Can you share with me your test case?  Your patch will result in the
>> shrinker potentially not getting released in some error paths (which
>> will cause other kernel panics), and in any case, once the journal is
> 
> Hi Ted,
> 
> The only logic we have changed is that we move the flush_work before we 
> call jbd2_journal_destory. I have not seen the problem you describe... 
> Can you help to explain more...
> 
> Thanks,
> Kun.
> 
>> destroyed here:
>>
>>> @@ -5173,15 +5173,15 @@ static int ext4_fill_super(struct super_block 
>>> *sb, void *data, int silent)
>>>       ext4_xattr_destroy_cache(sbi->s_ea_block_cache);
>>>       sbi->s_ea_block_cache = NULL;
>>> +failed_mount3a:
>>> +    ext4_es_unregister_shrinker(sbi);
>>> +failed_mount3:
>>> +    flush_work(&sbi->s_error_work);
>>>       if (sbi->s_journal) {
>>>           jbd2_journal_destroy(sbi->s_journal);
>>>           sbi->s_journal = NULL;
>>>       }
>>> -failed_mount3a:
>>> -    ext4_es_unregister_shrinker(sbi);
>>> -failed_mount3:
>>> -    flush_work(&sbi->s_error_work);
>>
>> sbi->s_journal is set to NULL, which means that in
>> flush_stashed_error_work(), journal will be NULL, which means we won't
>> call start_this_handle and so this change will not make a difference
>> given the kernel stack trace in the commit description.
>>
>> Thanks,
>>
>>                         - Ted
>> .
>>
> .
