Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB10F56D695
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Jul 2022 09:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiGKHUN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Jul 2022 03:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiGKHUM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Jul 2022 03:20:12 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE8FDF03;
        Mon, 11 Jul 2022 00:20:08 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LhFZk2Gxbz1L8ym;
        Mon, 11 Jul 2022 15:17:34 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 15:20:06 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 15:20:05 +0800
Subject: Re: [PATCH v2 2/2] ext4: set 256 blocks in a block group then apply
 io pressure
To:     Zorro Lang <zlang@redhat.com>
CC:     <fstests@vger.kernel.org>, <linux-ext4@vger.kernel.org>
References: <20220708112155.2639551-1-sunke32@huawei.com>
 <20220708112155.2639551-3-sunke32@huawei.com>
 <20220708152014.bifm4u2wmdwj3mnf@zlang-mailbox>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <5b9d09c5-472c-f2cc-32db-6eb23dd54a80@huawei.com>
Date:   Mon, 11 Jul 2022 15:20:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220708152014.bifm4u2wmdwj3mnf@zlang-mailbox>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



ÔÚ 2022/7/8 23:20, Zorro Lang Ð´µÀ:
> On Fri, Jul 08, 2022 at 07:21:55PM +0800, Sun Ke wrote:
>> Set 256 blocks in a block group, then inject I/O pressure, it will
>> trigger off kernel BUG in ext4_mb_mark_diskspace_used.
>>
>> Regression test for commit a08f789d2ab5 ext4: fix bug_on
>> ext4_mb_use_inode_pa.
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>>   tests/ext4/058     | 33 +++++++++++++++++++++++++++++++++
>>   tests/ext4/058.out |  2 ++
>>   2 files changed, 35 insertions(+)
>>   create mode 100755 tests/ext4/058
>>   create mode 100644 tests/ext4/058.out
>>
>> diff --git a/tests/ext4/058 b/tests/ext4/058
>> new file mode 100755
>> index 00000000..b718c1ac
>> --- /dev/null
>> +++ b/tests/ext4/058
>> @@ -0,0 +1,33 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
>> +#
>> +# FS QA Test 058
>> +#
>> +# Set 256 blocks in a block group, then inject I/O pressure,
>> +# it will trigger off kernel BUG in ext4_mb_mark_diskspace_used
>> +#
>> +# Regression test for commit
>> +# a08f789d2ab5 ext4: fix bug_on ext4_mb_use_inode_pa
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto
> 
> quick ?
> 
>> +
>> +# real QA test starts here
>> +
>> +_supported_fs ext4
>> +_fixed_by_kernel_commit a08f789d2ab5 \
>> +	"ext4: fix bug_on ext4_mb_use_inode_pa"
>> +_require_scratch
>> +
>> +# set 256 blocks in a block group
>> +_scratch_mkfs -g 256 >>$seqres.full 2>&1 || _fail "mkfs failed"
>> +_scratch_mount
>> +
>> +$FSSTRESS_PROG -d $SCRATCH_MNT/stress -n 1000 >> $seqres.full
> 
> Use "2>&1", if you'd like to avoid some fsstress error output break golden image.
> 
> BTW, just for make, are you sure this can reproduce that bug? Due to that fix
> commit said:
> ...
>      we can easily reproduce this problem with the following commands:
>              `fallocate -l100M disk`
>              `mkfs.ext4 -b 1024 -g 256 disk`
>              `mount disk /mnt`
>              `fsstress -d /mnt -l 0 -n 1000 -p 1`
> ...
> 
> It uses "-l 0" to loop run fsstress until hit the bug. You removed the '-l 0',
> so are you sure one round `fsstress -n 1000` is enough to reproduce this bug
> stably?
> 
> Thanks,
> Zorro
It is enough ro reproduce this bug, it takes about 1 second:

[  120.723374] run fstests ext4/058 at 2022-07-11 11:42:51
[[0;32m  OK  [0m] Started /usr/bin/bash -c test -w /p¡­_score_adj; exec 
./tests/ext4/058.
[  121.841680] ------------[ cut here ]------------
[  121.847476] kernel BUG at fs/ext4/mballoc.c:3786!
[  121.848522] invalid opcode: 0000 [#1] PREEMPT SMP
[  121.849520] CPU: 1 PID: 995 Comm: fsstress Not tainted 
5.18.0-rc3-00087-g98d40e76652e #3
[  121.851182] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.10.2-1ubuntu1 04/01/2014
[  121.853023] RIP: 0010:ext4_mb_mark_diskspace_used+0x3d6/0x750
[  121.854222] Code: 05 3e b3 26 0c 01 b8 fb ff ff ff e9 e7 fc ff ff 48 
83 05 dc b2 26 0c 01 0f 0b 48 83 05 da b2 26 0c 01 48 83 05 da b2 26 0c 
01 <0f> 0b 48 83 05 e0 b2 26 0c 01 48 83 05 e8 b2 26 0c 01 e9 db fc ff
[  121.858035] RSP: 0018:ffffc90001857978 EFLAGS: 00010202
[  121.859119] RAX: 00000000ffffffcd RBX: ffff88810f247000 RCX: 
ffffc90001857abc
[  121.860584] RDX: 0000000000000016 RSI: ffff88810f2460a8 RDI: 
ffff88810f247000
[  121.862056] RBP: ffffc90001857ae0 R08: ffff88810f24daf8 R09: 
00000000ffffffcd
[  121.863522] R10: 0000000000000000 R11: 0000000000000001 R12: 
ffffc90001857be8
[  121.864994] R13: 0000000000000016 R14: ffff8881024a5800 R15: 
ffff88810f247000
[  121.866461] FS:  00007fdc292d4700(0000) GS:ffff88813bc80000(0000) 
knlGS:0000000000000000
[  121.868118] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  121.869309] CR2: 00007fdc292eb000 CR3: 000000010a161000 CR4: 
00000000000006e0
[  121.870776] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  121.872241] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  121.873711] Call Trace:
[  121.874247]  <TASK>
[  121.874707]  ext4_mb_new_blocks+0x74a/0x1f20
[  121.875599]  ? ext4_find_extent+0x61d/0x900
[  121.876472]  ext4_ext_map_blocks+0xbea/0x1d80
[  121.877386]  ext4_map_blocks+0x15d/0xa20
[  121.878204]  ext4_iomap_begin+0x18c/0x3d0
[  121.879041]  iomap_iter+0x1c7/0x5b0
[  121.879777]  __iomap_dio_rw+0x293/0xb40
[  121.880583]  iomap_dio_rw+0x12/0x70
[  121.881320]  ext4_file_write_iter+0x86b/0xcd0
[  121.882228]  new_sync_write+0x140/0x1e0
[  121.883034]  vfs_write+0x312/0x4c0
[  121.883751]  ksys_write+0x73/0x160
[  121.884465]  __x64_sys_write+0x1e/0x30
[  121.885257]  do_syscall_64+0x35/0x80
[  121.886014]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  121.887066] RIP: 0033:0x7fdc28811280

Thanks,
Sun Ke

> 
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/ext4/058.out b/tests/ext4/058.out
>> new file mode 100644
>> index 00000000..fb5ca60b
>> --- /dev/null
>> +++ b/tests/ext4/058.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 058
>> +Silence is golden
>> -- 
>> 2.13.6
>>
> 
> 
> .
> 
