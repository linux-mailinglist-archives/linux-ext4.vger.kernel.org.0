Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A8A777700
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 13:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjHJLaf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 07:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjHJLaf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 07:30:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466FD9C;
        Thu, 10 Aug 2023 04:30:31 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RM4Sq2jh7zkX8h;
        Thu, 10 Aug 2023 19:29:15 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 19:30:28 +0800
Message-ID: <ef8850fe-545d-7729-92f4-0e1d726b2827@huawei.com>
Date:   Thu, 10 Aug 2023 19:30:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [v6.1] kernel BUG in ext4_writepages
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        syzbot <syzbot+a8068dd81edde0186829@syzkaller.appspotmail.com>,
        <syzkaller-lts-bugs@googlegroups.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Baokun Li <libaokun1@huawei.com>
References: <00000000000081f8c905f6c24e0d@google.com>
 <87dcdf62-8a74-1fbf-5f10-f4f3231f774f@collabora.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <87dcdf62-8a74-1fbf-5f10-f4f3231f774f@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On 2023/8/10 18:49, Muhammad Usama Anjum wrote:
> Hi,
>
> Syzbot has reporting hitting this bug on 6.1.18 and 5.15.101 LTS kernels
> and provided reproducer as well.
>
> 	BUG_ON(ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA));
>
> I've copied the same config and reproduced the bug on 6.1.18, 6.1.44 and
> next-20230809.
>
> This part of code hasn't been changed from the time it was introduced
> 4e7ea81db53465 ("ext4: restructure writeback path"). I'm not sure why the
> inlined data is being destroyed before copying it somewhere else.
>
> Please consider this a report.
>
> Regards,
> Muhammad Usama Anjum

We've already noticed this problem, which is caused by the fact that

ext4_convert_inline_data() in ext4_page_mkwrite() is not protected by

an inode_lock, so it can modify the state of the inode while someone

else is holding the lock.

Unfortunately we don't have a good solution for this at the moment,

as adding inode_lock here could easily form an ABBA deadlock with

mmap_lock. For a more detailed discussion see:

      https://lkml.org/lkml/2023/5/30/894


>
> On 3/13/23 11:34 AM, syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>>
>> HEAD commit: 1cc3fcf63192 Linux 6.1.18
>> git tree: linux-6.1.y
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10d4b342c80000
>> kernel config: https://syzkaller.appspot.com/x/.config?x=157296d36f92ea19
> ^ Kernel config
>
>> dashboard link: https://syzkaller.appspot.com/bug?extid=a8068dd81edde0186829
>> compiler: Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>> userspace arch: arm64
>> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=13512ec6c80000
>> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=15ca0ff4c80000
> ^ reproducers. C reproducer reproduces the bug easily.
>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/0e4c0d43698b/disk-1cc3fcf6.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/a4de39d735de/vmlinux-1cc3fcf6.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/82bab928f6e3/Image-1cc3fcf6.gz.xz
>> mounted in repro: https://storage.googleapis.com/syzbot-assets/bf2e21b96210/mount_0.gz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+a8068dd81edde0186829@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> kernel BUG at fs/ext4/inode.c:2746!
>> Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>> Modules linked in:
>> CPU: 0 PID: 11 Comm: kworker/u4:1 Not tainted 6.1.18-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
>> Workqueue: writeback wb_workfn (flush-7:0)
>> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> pc : ext4_writepages+0x35f4/0x35f8 fs/ext4/inode.c:2745
>> lr : ext4_writepages+0x35f4/0x35f8 fs/ext4/inode.c:2745
>> sp : ffff800019d16d40
>> x29: ffff800019d17120 x28: ffff800008e691e4 x27: dfff800000000000
>> x26: ffff0000de1f3ee0 x25: ffff800019d17590 x24: ffff800019d17020
>> x23: ffff0000dd616000 x22: ffff800019d16f40 x21: ffff0000de1f4108
>> x20: 0000008410000000 x19: 0000000000000001 x18: ffff800019d16a20
>> x17: ffff80001572d000 x16: ffff8000083099b4 x15: 000000000000ba31
>> x14: 00000000ffffffff x13: dfff800000000000 x12: 0000000000000001
>> x11: ff80800008e6c7d8 x10: 0000000000000000 x9 : ffff800008e6c7d8
>> x8 : ffff0000c099b680 x7 : 0000000000000000 x6 : 0000000000000000
>> x5 : 0000000000000080 x4 : 0000000000000000 x3 : 0000000000000001
>> x2 : 0000000000000000 x1 : 0000008000000000 x0 : 0000000000000000
>> Call trace:
>> ext4_writepages+0x35f4/0x35f8 fs/ext4/inode.c:2745
>> do_writepages+0x2e8/0x56c mm/page-writeback.c:2469
>> __writeback_single_inode+0x228/0x1ec8 fs/fs-writeback.c:1587
>> writeback_sb_inodes+0x9c0/0x1844 fs/fs-writeback.c:1878
>> wb_writeback+0x4f8/0x1580 fs/fs-writeback.c:2052
>> wb_do_writeback fs/fs-writeback.c:2195 [inline]
>> wb_workfn+0x460/0x11b8 fs/fs-writeback.c:2235
>> process_one_work+0x868/0x16f4 kernel/workqueue.c:2289
>> worker_thread+0x8e4/0xfec kernel/workqueue.c:2436
>> kthread+0x24c/0x2d4 kernel/kthread.c:376
>> ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
>> Code: d4210000 97da5cfa d4210000 97da5cf8 (d4210000)
>> ---[ end trace 0000000000000000 ]---
>>
>>
-- 
With Best Regards,
Baokun Li
.
