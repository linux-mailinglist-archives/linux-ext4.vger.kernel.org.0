Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9448F147F76
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jan 2020 12:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388041AbgAXLC1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jan 2020 06:02:27 -0500
Received: from apollo.dupie.be ([51.15.19.225]:43362 "EHLO apollo.dupie.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388026AbgAXLC0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 24 Jan 2020 06:02:26 -0500
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jan 2020 06:02:25 EST
Received: from [10.10.1.145] (systeembeheer.combell.com [217.21.177.69])
        by apollo.dupie.be (Postfix) with ESMTPSA id 66CB780A2E6
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jan 2020 11:57:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
        t=1579863427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZxT+boYY/KBq7DltOwerspS5MEqfP1Fxk4ldqoSq2xY=;
        b=DByUYNT35AvY3A7VMLZkWUKmJOtJ9Z7newNOkMEwMyGchLdeAFdIbz0G5tchozQD1/RFXp
        xPI7Ec8+YW3mse0/EjKvQMAWJmdpJdI0of8li31GSQ5ELNo7k16tXo9cwOoXPCNu5ltgsE
        yPsDytCIHI/hemlGP18AegHfBaq4KFmftZTiiqIsBCIN1C3/zEHUWfy50s8dB05h2W3fpg
        djn+heGwQfdoBXeiRm6I5Fk6/H+Ilma1BcbSjfUztLyOHiIxYi7QlRZBK7Ff6BPObHFj2s
        GcPr4vtOsFk8KMfst2scoYLwV3KPZWy/OMGcqzumibQAAqL9xab5KMSSg3eltw==
To:     linux-ext4@vger.kernel.org
From:   Jean-Louis Dupond <jean-louis@dupond.be>
Subject: Filesystem corruption after unreachable storage
Message-ID: <c829a701-3e22-8931-e5ca-2508f87f4d78@dupond.be>
Date:   Fri, 24 Jan 2020 11:57:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi All,

I have a question about some timeout/error handling in ext4. And hoping 
for tips on how to improve the situation :)

The case:
Virtual Machine (different linux versions) with ext4 + LVM
All the VM's are running on ESXi and using NFS SAN.

There was a short disruption of the SAN, which caused it to be 
unavailable for 20-25 minutes for the ESXi.

What was observed in the VM was the following:
- Tasks Hangs
  [5877185.755481] RSP: 002b:00007fc1253bc9d0 EFLAGS: 00000293 ORIG_RAX: 
0000000000000001
  [5877185.755481] RAX: ffffffffffffffda RBX: 000000000000000a RCX: 
00007fc138f3f4a7
  [5877185.755482] RDX: 0000000000000102 RSI: 00007fc1253bcb80 RDI: 
000000000000000a
  [5877185.755482] RBP: 00007fc1253bcb80 R08: 0000000000000000 R09: 
0000000000000101
  [5877185.755483] R10: 0000560111be2660 R11: 0000000000000293 R12: 
0000000000000102
  [5877185.755483] R13: 00007fc1253bcb80 R14: 0000000000000000 R15: 
00007fc1253bcb80
  [5877185.755488] INFO: task kworker/u256:0:34652 blocked for more than 
120 seconds.
  [5877185.755505]       Not tainted 4.19.0-6-amd64 #1 Debian 
4.19.67-2+deb10u1
  [5877185.755520] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
  [5877185.755538] kworker/u256:0  D    0 34652      2 0x80000000
  [5877185.755541] Workqueue: writeback wb_workfn (flush-254:2)
  [5877185.755542] Call Trace:
  [5877185.755543]  ? __schedule+0x2a2/0x870
  [5877185.755544]  ? bit_wait_timeout+0x90/0x90
  [5877185.755545]  schedule+0x28/0x80
  [5877185.755546]  io_schedule+0x12/0x40
  [5877185.755547]  bit_wait_io+0xd/0x50
  [5877185.755548]  __wait_on_bit_lock+0x5d/0xa0
  [5877185.755549]  out_of_line_wait_on_bit_lock+0x91/0xb0
  [5877185.755550]  ? init_wait_var_entry+0x40/0x40
  [5877185.755552]  do_get_write_access+0x1d8/0x430 [jbd2]
  [5877185.755559]  ? ext4_dirty_inode+0x46/0x60 [ext4]
  [5877185.755561]  jbd2_journal_get_write_access+0x37/0x50 [jbd2]
  [5877185.755566]  __ext4_journal_get_write_access+0x36/0x70 [ext4]
  [5877185.755573]  ext4_reserve_inode_write+0x96/0xc0 [ext4]
  [5877185.755575]  ? jbd2_journal_dirty_metadata+0x117/0x230 [jbd2]
  [5877185.755581]  ext4_mark_inode_dirty+0x51/0x1d0 [ext4]
  [5877185.755587]  ? __ext4_journal_start_sb+0x34/0x120 [ext4]
  [5877185.755593]  ext4_dirty_inode+0x46/0x60 [ext4]
  [5877185.755594]  __mark_inode_dirty+0x1ba/0x380
  [5877185.755600]  ext4_da_update_reserve_space+0xcf/0x180 [ext4]
  [5877185.755610]  ext4_ext_map_blocks+0xb46/0xda0 [ext4]
  [5877185.755617]  ext4_map_blocks+0xed/0x5f0 [ext4]
  [5877185.755623]  ext4_writepages+0x9ba/0xf00 [ext4]
  [5877185.755626]  ? do_writepages+0x41/0xd0
  [5877185.755632]  ? ext4_mark_inode_dirty+0x1d0/0x1d0 [ext4]
  [5877185.755633]  do_writepages+0x41/0xd0
  [5877185.755639]  ? blk_mq_sched_dispatch_requests+0x11e/0x170
  [5877185.755641]  __writeback_single_inode+0x3d/0x350
  [5877185.755642]  writeback_sb_inodes+0x1e3/0x450
  [5877185.755644]  __writeback_inodes_wb+0x5d/0xb0
  [5877185.755645]  wb_writeback+0x25f/0x2f0
  [5877185.755646]  ? get_nr_inodes+0x35/0x50
  [5877185.755648]  ? cpumask_next+0x16/0x20


- After 1080 seconds (SCSi Timeout of 180 * 5 Retries + 1):
[5878128.028672] sd 0:0:1:0: timing out command, waited 1080s
[5878128.028701] sd 0:0:1:0: [sdb] tag#592 FAILED Result: 
hostbyte=DID_OK driverbyte=DRIVER_OK
[5878128.028703] sd 0:0:1:0: [sdb] tag#592 CDB: Write(10) 2a 00 06 0c b4 
c8 00 00 08 00
[5878128.028704] print_req_error: I/O error, dev sdb, sector 101496008
[5878128.028736] EXT4-fs warning (device dm-2): ext4_end_bio:323: I/O 
error 10 writing to inode 3145791 (offset 0 size 0 starting block 12686745)

So you see the I/O is getting aborted.

- When the SAN came back, then the filesystem went Read-Only:
[5878601.212415] EXT4-fs error (device dm-2): 
ext4_journal_check_start:61: Detected aborted journal
[5878601.212491] JBD2: Detected IO errors while flushing file data on dm-2-8
[5878601.212571] EXT4-fs error (device dm-0): 
ext4_journal_check_start:61: Detected aborted journal
[5878601.212879] EXT4-fs (dm-2): Remounting filesystem read-only
[5878601.213483] EXT4-fs error (device dm-0): 
ext4_journal_check_start:61: Detected aborted journal
[5878601.213512] EXT4-fs error (device dm-2): 
ext4_journal_check_start:61: Detected aborted journal
[5878601.213513] EXT4-fs (dm-2): Remounting filesystem read-only
[5878601.215667] EXT4-fs error (device dm-0): 
ext4_journal_check_start:61: Detected aborted journal
[5878601.216347] EXT4-fs error (device dm-2): 
ext4_journal_check_start:61: Detected aborted journal
[5878601.217089] EXT4-fs (dm-2): ext4_writepages: jbd2_start: 12288 
pages, ino 786630; err -30
[5878601.217963] EXT4-fs error (device dm-0): 
ext4_journal_check_start:61: Detected aborted journal
[5878601.218253] EXT4-fs error (device dm-0): 
ext4_journal_check_start:61: Detected aborted journal
[5878601.219040] EXT4-fs error (device dm-2): 
ext4_journal_check_start:61: Detected aborted journal
[5878601.219049] EXT4-fs error (device dm-2): 
ext4_journal_check_start:61: Detected aborted journal


Now I did a hard reset of the machine, and a manual fsck was needed to 
get it booting again.
Fsck was showing the following:
"Inodes that were part of a corrupted orphan linked list found."

Manual fsck started with the following:
Inodes that were part of a corrupted orphan linked list found. Fix<y>?
Inode 165708 was part of the orphaned inode list. FIXED

Block bitmap differences: -(863328--863355)
Fix<y>?


What worries me is that almost all of the VM's (out of 500) were showing 
the same error. And even some (+-10) were completely corrupt.
If you would do a hard reset of the VM's as a test (without storage 
outage), the ratio of VMs that are corrupt and need manual fsck is WAY 
lower.

Is there for example a chance that the filesystem gets corrupted the 
moment the SAN storage was back accessible?
I also have some snapshot available of a corrupted disk if some 
additional debugging info is required.

It would be great to gather some feedback on how to improve the 
situation (next to of course have no SAN outage :)).
On KVM for example there is a unlimited timeout (afaik) until the 
storage is back, and the VM just continues running after storage recovery.

I tried to reproduce the issue in our lab (by cutting the network to the 
SAN from the ESXi), but we were unable to simulate the exact same 
filesystem error.

Thanks
Jean-Louis


