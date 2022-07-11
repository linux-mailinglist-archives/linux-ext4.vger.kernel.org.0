Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5206156D6DC
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Jul 2022 09:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiGKHcT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Jul 2022 03:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGKHcT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Jul 2022 03:32:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FF9165B6;
        Mon, 11 Jul 2022 00:32:17 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LhFrl0V5KzhYr0;
        Mon, 11 Jul 2022 15:29:43 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 15:32:15 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 15:32:14 +0800
Subject: Re: [PATCH v2 1/2] ext4: resize fs after resize_inode without e2fsck
To:     Zorro Lang <zlang@kernel.org>
CC:     <fstests@vger.kernel.org>, <linux-ext4@vger.kernel.org>
References: <20220708112155.2639551-1-sunke32@huawei.com>
 <20220708112155.2639551-2-sunke32@huawei.com>
 <20220708161624.etkxdewnje4nhmhl@zlang-mailbox>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <4f01bc54-9ed0-49d7-f616-7a031009f6be@huawei.com>
Date:   Mon, 11 Jul 2022 15:32:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220708161624.etkxdewnje4nhmhl@zlang-mailbox>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



ÔÚ 2022/7/9 0:16, Zorro Lang Ð´µÀ:
> On Fri, Jul 08, 2022 at 07:21:54PM +0800, Sun Ke wrote:
>> Forget to run requested e2fsck after resize_inode, then resize fs, it
>> will trigger off null pointer.
>>
>> Regression test for commit b55c3cd102a6 ext4: add reserved GDT blocks
>> check.
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>>   tests/ext4/057     | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   tests/ext4/057.out |  2 ++
>>   2 files changed, 46 insertions(+)
>>   create mode 100755 tests/ext4/057
>>   create mode 100644 tests/ext4/057.out
>>
>> diff --git a/tests/ext4/057 b/tests/ext4/057
>> new file mode 100755
>> index 00000000..125f841a
>> --- /dev/null
>> +++ b/tests/ext4/057
>> @@ -0,0 +1,44 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
>> +#
>> +# FS QA Test 057
>> +#
>> +# Forget to run requested e2fsck after resize_inode, then resize fs,
>> +# it will trigger off null pointer.
>> +#
>> +# Regression test for commit
>> +# b55c3cd102a6 ext4: add reserved GDT blocks check
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto resize quick
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs ext4
>> +_fixed_by_kernel_commit b55c3cd102a6 \
>> +	"ext4: add reserved GDT blocks check"
>> +
>> +_require_scratch
>> +_require_command "$TUNE2FS_PROG" tune2fs
>> +_require_command "$RESIZE2FS_PROG" resize2fs
>> +_require_scratch_size $((1024 * 1024)) #kB
>> +
>> +# set fs size 512M
>> +dev_size=$((512 * 1024 * 1024))
>> +_scratch_mkfs_sized $dev_size >$seqres.full 2>&1
>> +
>> +# forget to run requested e2fsck after resize_inode
>> +$TUNE2FS_PROG -O ^resize_inode $SCRATCH_DEV >$seqres.full 2>&1
> 
> Please use appending write ">>$seqres.full", to avoid seqres.full be
> overwritten.
> 
> I think we don't need to filter out the error output, we don't expect
> there's an error, so if it fails, how about output errors to break
> golden image (remind the testers).
> 
>> +
>> +_scratch_mount
>> +
>> +# resize fs will trigger NULL pointer in ext4_flex_group_add
>> +$RESIZE2FS_PROG $SCRATCH_DEV 1G >$seqres.full 2>&1
> 
> Appending write too...
> 
> I'm not sure what's the necessary condition to reproduce the bug. Do you
> need to resize fs will trigger the bug, but after:
> 
>    # tune2fs -O ^resize_inode /dev/sda3
> 
> Then resize2fs always get:
> 
>    # resize2fs /dev/sda3 3g
>    resize2fs 1.45.6 (20-Mar-2020)
>    Please run 'e2fsck -f /dev/sda3' first.
> 
> Looks like the resizing isn't run actually, is it what you really want?
> I've tried to review this patch from fstests side, better to get some
> review points from ext4 devel, to help to make sure that.
> 
> Thanks,
> Zorro
If comment out the resizefs line, the test will pass.
But if not, it will panic, also takes about 1 second.
So I think resizefs is necessary.

[  113.378201] run fstests ext4/057 at 2022-07-11 11:39:19
[^[[0;32m  OK  ^[[0m] Started /usr/bin/bash -c test -w /p¡­_score_adj; 
exec ./tests/ext4/057.^M
[  113.747013] EXT4-fs (sdb): warning: mounting unchecked fs, running 
e2fsck is recommended
[  113.779534] BUG: kernel NULL pointer dereference, address: 
0000000000000028
[  113.781657] #PF: supervisor read access in kernel mode
[  113.783250] #PF: error_code(0x0000) - not-present page
[  113.784747] PGD 10d22b067 P4D 10d22b067 PUD 10c2e8067 PMD 0
[  113.786360] Oops: 0000 [#1] PREEMPT SMP
[  113.787514] CPU: 2 PID: 3359 Comm: resize2fs Not tainted 
5.18.0-rc3-00087-g98d40e76652e #3
[  113.789980] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.10.2-1ubuntu1 04/01/2014
[  113.792566] RIP: 0010:ext4_flex_group_add+0xe06/0x2530
[  113.794106] Code: 83 05 e5 2d 25 0c 01 48 85 c0 0f 84 16 fd ff ff 48 
8b 44 24 28 be 40 0c 00 00 48 83 05 d2 2d 25 0c 01 48 83 05 6a 2b 25 0c 
01 <48> 8b 68 28 48 83 05 0e 20 25 0c 01 48 8b 95 78 03 00 00 48 8b 42
[  113.799408] RSP: 0018:ffffc900047a7c48 EFLAGS: 00010202
[  113.800857] RAX: 0000000000000000 RBX: ffff88810633e3a8 RCX: 
0000000055555557
[  113.802753] RDX: ffff88810b144400 RSI: 0000000000000c40 RDI: 
00000000aaaaaaab
[  113.804627] RBP: 000000000000003f R08: 0000000000000001 R09: 
0000000000000001
[  113.806518] R10: 0000000000000000 R11: 00000000fffd2755 R12: 
0000000000000005
[  113.808071] R13: ffff88810d279800 R14: 0000000000000000 R15: 
0000000000000005
[  113.809540] FS:  00007f6aca9d2bc0(0000) GS:ffff88813bd00000(0000) 
knlGS:0000000000000000
[  113.811216] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  113.812404] CR2: 0000000000000028 CR3: 0000000106afc000 CR4: 
00000000000006e0
[  113.814078] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  113.815707] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  113.817212] Call Trace:
[  113.817744]  <TASK>
[  113.818221]  ? __kmalloc+0x21e/0x5c0[  113.818955] 
ext4_resize_fs+0xbe4/0x1640
[  113.819778]  __ext4_ioctl+0x1e75/0x26a0
[  113.820597]  ? putname+0x75/0xa0
[  113.821284]  ? kmem_cache_free+0x1a7/0x690
[  113.822139]  ? putname+0x75/0xa0
[  113.822801]  ? do_sys_openat2+0x2a8/0x4f0
[  113.823644]  ext4_ioctl+0x12/0x20
[  113.824352]  __x64_sys_ioctl+0xa3/0x110
[  113.825171]  do_syscall_64+0x35/0x80
[  113.825919]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  113.826969] RIP: 0033:0x7f6ac9b06577

I will continue to improve based on your suggestions on v3.

Thanks,
Sun Ke
> 
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/ext4/057.out b/tests/ext4/057.out
>> new file mode 100644
>> index 00000000..185023c7
>> --- /dev/null
>> +++ b/tests/ext4/057.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 057
>> +Silence is golden
>> -- 
>> 2.13.6
>>
> .
> 
