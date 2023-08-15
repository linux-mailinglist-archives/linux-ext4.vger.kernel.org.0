Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B6B77D2CA
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 21:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbjHOTCr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 15:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbjHOTCl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 15:02:41 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C14E7C;
        Tue, 15 Aug 2023 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1692126142; x=1723662142;
  h=message-id:date:mime-version:from:to:cc:subject:
   content-transfer-encoding;
  bh=NbNNWHkyvi+BPJPr71YVXIy5nuwb4OlpUdWEhB36RKw=;
  b=SWSpe/zzNpCfds75OIZlOiuAGf1LGfHK6x9bl8qiasZEN+aQ7Q9yxKWb
   iT+LILmPKany2GBhPmp+rmpVv7YNymn22s0tA1COUyBEZOFTQFIS3luOH
   0IlQFBBx0TPMtjfyEPpV5ww3uKvrllNk6fm68VwPZo6KjapCRHlXNhEZs
   4=;
X-IronPort-AV: E=Sophos;i="6.01,175,1684800000"; 
   d="scan'208";a="22684993"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 19:01:56 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com (Postfix) with ESMTPS id A91E980723;
        Tue, 15 Aug 2023 19:01:56 +0000 (UTC)
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 15 Aug 2023 19:01:49 +0000
Received: from [192.168.196.32] (10.106.101.51) by
 EX19D002UWC004.ant.amazon.com (10.13.138.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 15 Aug 2023 19:01:48 +0000
Message-ID: <153d081d-e738-b916-4f72-364b2c1cc36a@amazon.com>
Date:   Tue, 15 Aug 2023 12:01:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Content-Language: en-US
From:   "Bhatnagar, Rishabh" <risbhat@amazon.com>
To:     <jack@suse.com>, <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Park, SeongJae" <sjpark@amazon.com>
Subject: Tasks stuck jbd2 for a long time
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.106.101.51]
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D002UWC004.ant.amazon.com (10.13.138.186)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan/Ted

We are seeing lockups in journaling EXT4 code (5.10 - 6.1) under heavy 
load. The stack traces seem to suggest that kjournald thread is blocked 
for a long time.
Kjournald thread seem to be waiting on writeback thread to decrement 
t_updates and other writeback threads seem to be waiting on kjournald to 
flush the current transaction.
The system completely hangs in this case and the system IO drops to zero 
after sometime.

This is a RAID0 setup with 4 nvme (7TB each) disks. There is 390GB RAM 
available. The issue occurs when user starts downloading a big enough 
data set (60-70% disk capacity).
This is observed on 5.10 kernels (5.10.184). We tried moving to 6.1 
kernels and saw similar issue. The system completely freezes and we see 
these stack traces in serial console.

We have tried experimenting with dirty_ratio, dirty_background_ratio, 
noatime/lazytime updates but don't see much improvement.
One thing that helps is disabling journaling completely. Testing is 
ongoing after increasing the journal size. (current size 128MB).
We are trying to understand why journal threads are stuck for such a 
long time. This causes the entire IO stall in the system. Let us know if 
you have seen something similar before and if there are any suggestions 
that we can try.

INFO: task kworker/u145:1:376 blocked for more than 120 seconds.
       Not tainted 5.10.184-175.731.amzn2.x86_64
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u145:1  state:D stack :    0 pid:  376 ppid:     2 
flags:0x00004000
Workqueue : writeback wb_workfn (flush-9:0)
Call Trace:
  __schedule+0x1f9/0x660
  schedule+0x46/0xb0
  wait_transaction_locked+0x8a/0xd0 [jbd2]
  ? add_wait_queue_exclusive+0x70/0x70
  add_transaction_credits+0xd6/0x2a0 [jbd2]
  ? blk_mq_flush_plug_list+0x100/0x1a0
  start_this_handle+0x12d/0x4d0 [jbd2]
  ? jbd2__journal_start+0xc3/0x1e0 [jbd2]
  ? kmem_cache_alloc+0x132/0x270
  jbd2__journal_start+0xfb/0x1e0 [jbd2]
  __ext4_journal_start_sb+0xfb/0x110 [ext4]
  ext4_writepages+0x32c/0x790 [ext4]
  do_writepages+0x34/0xc0
  ? write_inode+0x54/0xd0
  __writeback_single_inode+0x39/0x200
  writeback_sb_inodes+0x20d/0x4a0
  __writeback_inodes_wb+0x4c/0xe0
  wb_writeback+0x1d8/0x2a0
  wb_do_writeback+0x166/0x180
  wb_workfn+0x6e/0x250
  ? __switch_to_asm+0x3a/0x60
  ? __schedule+0x201/0x660
  process_one_work+0x1b0/0x350
  worker_thread+0x49/0x310
  ? process_one_work+0x350/0x350
  kthread+0x11b/0x140
  ? __kthread_bind_mask+0x60/0x60
  ret_from_fork+0x22/0x30

INFO: task jbd2/md0-8:8068 blocked for more than 120 seconds.

       Not tainted 5.10.184-175.731.amzn2.x86_64 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jbd2/md0-8      state:D stack:    0 pid: 8068 ppid:     2 
flags:0x00004080
Call Trace:
__schedule+0x1f9/0x660
  schedule+0x46/0xb0
  jbd2_journal_commit_transaction+0x35d/0x1880 [jbd2]
  ? update_load_avg+0x7a/0x5d0
  ? add_wait_queue_exclusive+0x70/0x70
  ? lock_timer_base+0x61/0x80
  ? kjournald2+0xcf/0x360 [jbd2]
  kjournald2+0xcf/0x360 [jbd2]
  ? add_wait_queue_exclusive+0x70/0x70
  ? load_superblock.part.0+0xb0/0xb0 [jbd2]
  kthread+0x11b/0x140
  ? __kthread_bind_mask+0x60/0x60
  ret_from_fork+0x22/0x30

INFO: task kvstore-leaf:39161 blocked for more than 121 seconds.
       Not tainted 5.10.184-175.731.amzn2.x86_64 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kvstore-leaf    state:D stack:    0 pid:39161 ppid: 39046 
flags:0x00000080
Call Trace:
  __schedule+0x1f9/0x660
  schedule+0x46/0xb0
  wait_transaction_locked+0x8a/0xd0 [jbd2]
  ? add_wait_queue_exclusive+0x70/0x70
  add_transaction_credits+0xd6/0x2a0 [jbd2]
  start_this_handle+0x12d/0x4d0 [jbd2]
  ? jbd2__journal_start+0x91/0x1e0 [jbd2]
  ? kmem_cache_alloc+0x132/0x270
  jbd2__journal_start+0xfb/0x1e0 [jbd2]
  __ext4_journal_start_sb+0xfb/0x110 [ext4]
  ext4_dirty_inode+0x3d/0x90 [ext4]
  __mark_inode_dirty+0x196/0x300
  generic_update_time+0x68/0xd0
  file_update_time+0x127/0x140
  ? generic_write_checks+0x61/0xd0
  ext4_buffered_write_iter+0x52/0x160 [ext4]
  new_sync_write+0x11c/0x1b0
  vfs_write+0x1c9/0x260
  ksys_write+0x5f/0xe0
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x61/0xc6


Thanks
Rishabh

