Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDF9366E8C
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Apr 2021 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243714AbhDUOzj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Apr 2021 10:55:39 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:55989 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236708AbhDUOzi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Apr 2021 10:55:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UWJtKHM_1619016901;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0UWJtKHM_1619016901)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Apr 2021 22:55:02 +0800
Subject: Re: [PATCH] fs/ext4: prevent the CPU from being 100% occupied in
 ext4_mb_discard_group_preallocations
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Baoyou Xie <baoyou.xie@alibaba-inc.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210418102834.29589-1-wenyang@linux.alibaba.com>
 <YHxY6e9l3T4rsCos@mit.edu>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <296029e3-79c3-f603-7c3b-3429aac0e0c3@linux.alibaba.com>
Date:   Wed, 21 Apr 2021 22:55:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <YHxY6e9l3T4rsCos@mit.edu>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



ÔÚ 2021/4/19 ÉÏÎç12:06, Theodore Ts'o Ð´µÀ:
> On Sun, Apr 18, 2021 at 06:28:34PM +0800, Wen Yang wrote:
>> The kworker has occupied 100% of the CPU for several days:
>> PID USER  PR  NI VIRT RES SHR S  %CPU  %MEM TIME+  COMMAND
>> 68086 root 20 0  0    0   0   R  100.0 0.0  9718:18 kworker/u64:11
>>
>> ....
>>
>> The thread that references this pa has been waiting for IO to return:
>> PID: 15140  TASK: ffff88004d6dc300  CPU: 16  COMMAND: "kworker/u64:1"
>> [ffffc900273e7518] __schedule at ffffffff8173ca3b
>> [ffffc900273e75a0] schedule at ffffffff8173cfb6
>> [ffffc900273e75b8] io_schedule at ffffffff810bb75a
>> [ffffc900273e75e0] bit_wait_io at ffffffff8173d8d1
>> [ffffc900273e75f8] __wait_on_bit_lock at ffffffff8173d4e9
>> [ffffc900273e7638] out_of_line_wait_on_bit_lock at ffffffff8173d742
>> [ffffc900273e76b0] __lock_buffer at ffffffff81288c32
>> [ffffc900273e76c8] do_get_write_access at ffffffffa00dd177 [jbd2]
>> [ffffc900273e7728] jbd2_journal_get_write_access at ffffffffa00dd3a3 [jbd2]
>> [ffffc900273e7750] __ext4_journal_get_write_access at ffffffffa023b37b [ext4]
>> [ffffc900273e7788] ext4_mb_mark_diskspace_used at ffffffffa0242a0b [ext4]
>> [ffffc900273e77f0] ext4_mb_new_blocks at ffffffffa0244100 [ext4]
>> [ffffc900273e7860] ext4_ext_map_blocks at ffffffffa02389ae [ext4]
>> [ffffc900273e7950] ext4_map_blocks at ffffffffa0204b52 [ext4]
>> [ffffc900273e79d0] ext4_writepages at ffffffffa0208675 [ext4]
>> [ffffc900273e7b30] do_writepages at ffffffff811c487e
>> [ffffc900273e7b40] __writeback_single_inode at ffffffff81280265
>> [ffffc900273e7b90] writeback_sb_inodes at ffffffff81280ab2
>> [ffffc900273e7c90] __writeback_inodes_wb at ffffffff81280ed2
>> [ffffc900273e7cd8] wb_writeback at ffffffff81281238
>> [ffffc900273e7d80] wb_workfn at ffffffff812819f4
>> [ffffc900273e7e18] process_one_work at ffffffff810a5dc9
>> [ffffc900273e7e60] worker_thread at ffffffff810a60ae
>> [ffffc900273e7ec0] kthread at ffffffff810ac696
>> [ffffc900273e7f50] ret_from_fork at ffffffff81741dd9
>>
>> On the bare metal server, we will use multiple hard disks, the Linux
>> kernel will run on the system disk, and business programs will run on
>> several hard disks virtualized by the BM hypervisor. The reason why IO
>> has not returned here is that the process handling IO in the BM hypervisor
>> has failed.
> 
> So if the I/O not returning for every days, such that this thread had
> been hanging for that long, it also follows that since it was calling
> do_get_write_access(), that a handle was open.  And if a handle is
> open, then the current jbd2 transaction would never close --- which
> means none of the file system operations executed over the past few
> days would never commit, and would be undone on the next reboot.
> Furthermore, sooner or later the journal would run out of space, at
> which point the *entire* system would be locked up waiting for the
> transaction to close.
> 
> I'm guessing that if the server hadn't come to a full livelock
> earlier, it's because there aren't that many metadata operations that
> are happening in the server's stable state operation.  But in any
> case, this particular server was/is(?) doomed, and all of the patches
> that you proposed are not going to help in the long run.  The correct
> fix is to fix the hypervisor, which is the root cause of the problem.
> 

Yes, in the end, the whole system was affected, as follows

crash> ps | grep UN
     281      2  16  ffff881fb011c300  UN   0.0       0      0  [kswapd_0]
     398    358   9  ffff880084094300  UN   0.0   30892   2592 
systemd-journal
     ......
    2093    358  28  ffff880012d2c300  UN   0.0  241676  15108  syslog-ng
    2119    358   0  ffff88005a252180  UN   0.0  124340   3148  crond
......


PID: 281    TASK: ffff881fb011c300  CPU: 16  COMMAND: "kswapd_0"
  #0 [ffffc9000d7af7e0] __schedule at ffffffff8173ca3b
  #1 [ffffc9000d7af868] schedule at ffffffff8173cfb6
  #2 [ffffc9000d7af880] wait_transaction_locked at ffffffffa00db08a [jbd2]
  #3 [ffffc9000d7af8d8] add_transaction_credits at ffffffffa00db2c0 [jbd2]
  #4 [ffffc9000d7af938] start_this_handle at ffffffffa00db64f [jbd2]
  #5 [ffffc9000d7af9c8] jbd2__journal_start at ffffffffa00dbe3e [jbd2]
  #6 [ffffc9000d7afa18] __ext4_journal_start_sb at ffffffffa023b0dd [ext4]
  #7 [ffffc9000d7afa58] ext4_release_dquot at ffffffffa02202f2 [ext4]
  #8 [ffffc9000d7afa78] dqput at ffffffff812b9bef
  #9 [ffffc9000d7afaa0] __dquot_drop at ffffffff812b9eaf
#10 [ffffc9000d7afad8] dquot_drop at ffffffff812b9f22
#11 [ffffc9000d7afaf0] ext4_clear_inode at ffffffffa02291f2 [ext4]
#12 [ffffc9000d7afb08] ext4_evict_inode at ffffffffa020a939 [ext4]
#13 [ffffc9000d7afb28] evict at ffffffff8126d05a
#14 [ffffc9000d7afb50] dispose_list at ffffffff8126d16b
#15 [ffffc9000d7afb78] prune_icache_sb at ffffffff8126e2ba
#16 [ffffc9000d7afbb0] super_cache_scan at ffffffff8125320e
#17 [ffffc9000d7afc08] shrink_slab at ffffffff811cab55
#18 [ffffc9000d7afce8] shrink_node at ffffffff811d000e
#19 [ffffc9000d7afd88] balance_pgdat at ffffffff811d0f42
#20 [ffffc9000d7afe58] kswapd at ffffffff811d14f1
#21 [ffffc9000d7afec0] kthread at ffffffff810ac696
#22 [ffffc9000d7aff50] ret_from_fork at ffffffff81741dd9


> I could imagine some kind of retry counter, where we start sleeping
> after some number of retries, and give up after some larger number of
> retries (at which point the allocation would fail with ENOSPC).  We'd
> need to do some testing against our current tests which test how we
> handle running close to ENOSPC, and I'm not at all convinced it's
> worth the effort in the end.  We're trying to (slightly) improve the
> case where (a) the file system is running close to full, (b) the
> hypervisor is critically flawed and is the real problem, and (c) the
> VM is eventually doomed to fail anyway due to a transaction never
> closing due to an I/O never getting acknowledged for days(!).
> 

Great. If you have any progress, we'll be happy to test it in our 
production environment. We are also looking forward to working together 
to optimize it.

> If you really want to fix things in the guest OS, I perhaps the
> virtio_scsi driver (or whatever I/O driver you are using), should
> notice when an I/O request hasn't gotten acknowledged after minutes or
> hours, and do something such as force a SCSI reset (which will result
> in the file system needing to be unmounted and recovered, but due to
> the hypervisor bug, that was an inevitable end result anyway).
> 

Yes, but unfortunately, it may not be finished in a short time.

We may refer to the documentation of the qemo community as follows:

https://wiki.qemu.org/ToDo/Block

Add a cancel command to the virtio-blk device so that running requests 
can be aborted. This requires changing the VIRTIO spec, extending QEMU's 
device emulation, and implementing blk_mq_ops->timeout() in Linux 
virtio_blk.ko. This task depends on first implementing real request 
cancellation in QEMU.


--
Best wishes,
Wen

