Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9E2776772
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Aug 2023 20:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjHISiE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Aug 2023 14:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjHISiD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Aug 2023 14:38:03 -0400
X-Greylist: delayed 577 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 11:38:02 PDT
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E43F1FCC;
        Wed,  9 Aug 2023 11:38:02 -0700 (PDT)
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 802375C41F4;
        Wed,  9 Aug 2023 18:28:25 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9300C900075;
        Wed,  9 Aug 2023 18:28:21 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 7C7E413C2B0;
        Wed,  9 Aug 2023 11:28:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7C7E413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1691605700;
        bh=qEOkoRA6BEQttVOC18SMvN4obQI0hwKc15ro+QeNNGs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d+9wn4DX2SOjo4i2dJ16VAI7PhuK63p6hUNvyjjGdnY0oAmg0rU8mJ7Au5Six8RNm
         PtsoClnLE1N0TSWnWdUPME+NnPK8isUSYN2ATur8OIlK6zB8fJ6UbvUTJerLv65LPA
         ROP3nP31Mimx3kR14Pa/6+vBpiMkHDEzaLkdPHJs=
Message-ID: <ed075ba8-b916-9a5e-8c11-c99f47cd9ce9@candelatech.com>
Date:   Wed, 9 Aug 2023 11:28:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [dm-devel] Processes hung in "D" state in ext4, mm, md and
 dmcrypt (lockdep output)
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        David Howells <dhowells@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <song@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, dm-devel@redhat.com,
        linux-ext4@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <4919.1690365747@warthog.procyon.org.uk>
 <454e24e1-9713-f267-6332-d95f1273f378@huaweicloud.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <454e24e1-9713-f267-6332-d95f1273f378@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1691605703-3k1fvtyU-1x2
X-MDID-O: us5;at1;1691605703;3k1fvtyU-1x2;<greearb@candelatech.com>;76d107b76ad4a1576853bec3df2909d9
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 7/26/23 19:38, Yu Kuai wrote:
> Hi,
> 
> 在 2023/07/26 18:02, David Howells 写道:
>> Hi,
>>
>> With 6.5-rc2 (6.5.0-0.rc2.20230721gitf7e3a1bafdea.20.fc39.x86_64), I'm seeing
>> a bunch of processes getting stuck in the D state on my desktop after a few
>> hours of reading email and compiling stuff.  It's happened every day this week
>> so far and I managed to grab stack traces of the stuck processes this morning
>> (see attached).
>>
>> There are two blockdevs involved below, /dev/md2 and /dev/md3.  md3 is a raid1
>> array with two partitions with an ext4 partition on it.  md2 is similar but
>> it's dm-crypted and ext4 is on top of that.

Hello,

I have been hitting deadlocks in 6.5 series, and I finally managed to catch one with
lockdep kernel and serial console active.

My kernels have a lot of wifi patches on top of mainline, but I do not see indication
in this backtrace that it is network related.  A quick search of the mailing list found
this thread, and it looks like it might be similar to what I see.  I am able to test
patches and try other debug options if someone has suggestions:

INFO: task mdX_raid1:488 blocked for more than 180 seconds.
       Tainted: G        W          6.5.0-rc4+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:mdX_raid1       state:D stack:0     pid:488   ppid:2      flags:0x00004000
Call Trace:
  <TASK>
  __schedule+0x7aa/0x16e0
  ? io_schedule_timeout+0xb0/0xb0
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  schedule+0x89/0x110
  md_super_wait+0x110/0x160
  ? md_super_write+0x1b0/0x1b0
  ? print_usage_bug.part.0+0x3d0/0x3d0
  ? __mutex_lock+0xd22/0x1200
  ? destroy_sched_domains_rcu+0x30/0x30
  ? lock_acquire+0x15a/0x3b0
  ? md_bitmap_daemon_work+0x2fc/0x6a0
  ? find_held_lock+0x83/0xa0
  md_bitmap_wait_writes+0x15f/0x170
  ? behind_writes_used_reset+0x40/0x40
  ? mark_held_locks+0x65/0x90
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irq+0x1f/0x40
  md_bitmap_daemon_work+0x483/0x6a0
  ? md_bitmap_write_all+0xe0/0xe0
  ? lock_acquire+0x15a/0x3b0
  ? lock_timer_base+0x93/0xd0
  md_check_recovery+0x7b/0xa50
  raid1d+0xdb/0x30b0 [raid1]
  ? lockdep_hardirqs_on_prepare+0x200/0x200
  ? lockdep_hardirqs_on_prepare+0x200/0x200
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  ? raid1_read_request+0x13b0/0x13b0 [raid1]
  ? finish_wait+0x4a/0xc0
  ? find_held_lock+0x83/0xa0
  ? lock_release+0x1d1/0x3b0
  ? md_thread+0x1fe/0x280
  ? reacquire_held_locks+0x270/0x270
  ? mark_held_locks+0x24/0x90
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  md_thread+0x175/0x280
  ? md_submit_discard_bio+0x210/0x210
  ? mark_held_locks+0x24/0x90
  ? destroy_sched_domains_rcu+0x30/0x30
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  ? md_submit_discard_bio+0x210/0x210
  kthread+0x173/0x1b0
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x28/0x50
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20
  </TASK>
INFO: task jbd2/dm-4-8:526 blocked for more than 180 seconds.
       Tainted: G        W          6.5.0-rc4+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jbd2/dm-4-8     state:D stack:0     pid:526   ppid:2      flags:0x00004000
Call Trace:
  <TASK>
  __schedule+0x7aa/0x16e0
  ? io_schedule_timeout+0xb0/0xb0
  ? lock_sync+0xf0/0xf0
  ? find_held_lock+0x83/0xa0
  ? __wait_on_bit+0x95/0x100
  ? reacquire_held_locks+0x270/0x270
  ? submit_bio_noacct_nocheck+0x516/0x5a0
  schedule+0x89/0x110
  io_schedule+0x68/0xa0
  bit_wait_io+0x12/0x80
  __wait_on_bit+0x3a/0x100
  ? bit_wait+0x80/0x80
  out_of_line_wait_on_bit+0xd7/0x110
  ? __wait_on_bit+0x100/0x100
  ? cpuacct_css_alloc+0xd0/0xd0
  jbd2_journal_commit_transaction+0x2767/0x2ec0
  ? jbd2_journal_finish_inode_data_buffers+0x50/0x50
  ? find_held_lock+0x83/0xa0
  ? lock_release+0x1d1/0x3b0
  ? __timer_delete_sync+0x170/0x210
  ? reacquire_held_locks+0x270/0x270
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  ? timer_shutdown+0xe0/0xe0
  ? do_raw_read_unlock+0x80/0x80
  kjournald2+0x16c/0x560
  ? jbd2_write_superblock+0x450/0x450
  ? mark_held_locks+0x24/0x90
  ? destroy_sched_domains_rcu+0x30/0x30
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  ? jbd2_write_superblock+0x450/0x450
  kthread+0x173/0x1b0
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x28/0x50
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20
  </TASK>
INFO: task journal-offline:190685 blocked for more than 180 seconds.
       Tainted: G        W          6.5.0-rc4+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:journal-offline state:D stack:0     pid:190685 ppid:1      flags:0x00000002
Call Trace:
  <TASK>
  __schedule+0x7aa/0x16e0
  ? io_schedule_timeout+0xb0/0xb0
  ? folio_wait_bit_common+0x11e/0x470
  ? find_held_lock+0x83/0xa0
  ? lock_release+0x1d1/0x3b0
  ? reacquire_held_locks+0x270/0x270
  ? do_raw_spin_lock+0x114/0x1a0
  schedule+0x89/0x110
  io_schedule+0x68/0xa0
  folio_wait_bit_common+0x20b/0x470
  ? filemap_get_folios_contig+0x4e0/0x4e0
  ? filemap_invalidate_unlock_two+0x30/0x30
  ? lockdep_hardirqs_on_prepare+0x200/0x200
  folio_wait_writeback+0x16/0x100
  __filemap_fdatawait_range+0xc1/0x150
  ? filemap_get_folios_tag+0x5c0/0x5c0
  ? find_held_lock+0x83/0xa0
  ? __filemap_fdatawrite_range+0xc6/0x120
  ? delete_from_page_cache_batch+0x450/0x450
  ? strscpy+0xc5/0x190
  file_write_and_wait_range+0x9b/0xc0
  ext4_sync_file+0x134/0x640
  __x64_sys_fsync+0x3e/0x60
  do_syscall_64+0x34/0xb0
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f9088d0868a
RSP: 002b:00007f90869fd9f0 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
RAX: ffffffffffffffda RBX: 000055efd35f5940 RCX: 00007f9088d0868a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000002a
RBP: 000055efd361a510 R08: 0000000000000000 R09: 00007fff65ac277f
R10: 00007f9088c8cc1e R11: 0000000000000293 R12: 000055efd2c527a0
R13: 0000000000000002 R14: 00007fff65ac2680 R15: 00007f90861fe000
  </TASK>
INFO: task jbd2/dm-14-8:958 blocked for more than 180 seconds.
       Tainted: G        W          6.5.0-rc4+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jbd2/dm-14-8    state:D stack:0     pid:958   ppid:2      flags:0x00004000
Call Trace:
  <TASK>
  __schedule+0x7aa/0x16e0
  ? io_schedule_timeout+0xb0/0xb0
  ? blk_mq_flush_plug_list+0x10/0x30
  ? __blk_flush_plug+0x1be/0x210
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  schedule+0x89/0x110
  md_write_start+0x45e/0x590
  ? md_seq_show+0xc80/0xc80
  ? mark_lock+0x10b/0xd30
  ? destroy_sched_domains_rcu+0x30/0x30
  ? __lock_acquire+0x910/0x3240
  raid1_make_request+0x17c/0x18d0 [raid1]
  ? __lock_acquire+0x910/0x3240
  ? lockdep_hardirqs_on_prepare+0x200/0x200
  ? lock_acquire+0x15a/0x3b0
  ? md_handle_request+0x230/0x5e0
  ? find_held_lock+0x83/0xa0
  ? raid1_end_write_request+0x720/0x720 [raid1]
  ? lock_release+0x1d1/0x3b0
  ? md_handle_request+0x29b/0x5e0
  ? reacquire_held_locks+0x270/0x270
  ? lock_acquire+0x15a/0x3b0
  ? bio_associate_blkg_from_css+0x209/0x9d0
  ? find_held_lock+0x83/0xa0
  ? lock_is_held_type+0xa6/0x110
  md_handle_request+0x2dc/0x5e0
  ? mddev_init_writes_pending+0x60/0x60
  ? lock_release+0x1d1/0x3b0
  ? bio_associate_blkg+0x71/0x130
  ? reacquire_held_locks+0x270/0x270
  ? bio_associate_blkg_from_css+0x2e1/0x9d0
  raid_map+0x61/0x80 [dm_raid]
  __map_bio+0x85/0x290
  dm_submit_bio+0x4b9/0xca0
  ? dm_get_live_table+0xd0/0xd0
  ? reacquire_held_locks+0x270/0x270
  ? lock_release+0x1d1/0x3b0
  ? lock_is_held_type+0xa6/0x110
  __submit_bio+0x139/0x180
  ? __bio_queue_enter+0x350/0x350
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? seqcount_lockdep_reader_access.constprop.0+0x82/0x90
  ? seqcount_lockdep_reader_access.constprop.0+0x82/0x90
  ? ktime_get+0x1c/0xb0
  submit_bio_noacct_nocheck+0x2a1/0x5a0
  ? fscrypt_dio_supported+0xb0/0xb0
  ? blk_alloc_queue+0x310/0x310
  ? __probestub_jbd2_shrink_scan_enter+0x1/0x10
  ? submit_bio_noacct+0x310/0xa60
  jbd2_journal_commit_transaction+0x18ed/0x2ec0
  ? jbd2_journal_finish_inode_data_buffers+0x50/0x50
  ? find_held_lock+0x83/0xa0
  ? lock_release+0x1d1/0x3b0
  ? __timer_delete_sync+0x170/0x210
  ? reacquire_held_locks+0x270/0x270
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  ? timer_shutdown+0xe0/0xe0
  ? mark_held_locks+0x65/0x90
  kjournald2+0x16c/0x560
  ? jbd2_write_superblock+0x450/0x450
  ? mark_held_locks+0x24/0x90
  ? destroy_sched_domains_rcu+0x30/0x30
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  ? jbd2_write_superblock+0x450/0x450
  kthread+0x173/0x1b0
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x28/0x50
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20
  </TASK>
INFO: task kworker/u16:0:145831 blocked for more than 181 seconds.
       Tainted: G        W          6.5.0-rc4+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u16:0   state:D stack:0     pid:145831 ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-252:14)
Call Trace:
  <TASK>
  __schedule+0x7aa/0x16e0
  ? io_schedule_timeout+0xb0/0xb0
  ? blk_mq_flush_plug_list+0x10/0x30
  ? __blk_flush_plug+0x1be/0x210
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  schedule+0x89/0x110
  md_write_start+0x45e/0x590
  ? md_seq_show+0xc80/0xc80
  ? mark_lock+0x10b/0xd30
  ? __writeback_inodes_wb+0x6b/0x130
  ? destroy_sched_domains_rcu+0x30/0x30
  ? __lock_acquire+0x910/0x3240
  raid1_make_request+0x17c/0x18d0 [raid1]
  ? __lock_acquire+0x910/0x3240
  ? lockdep_hardirqs_on_prepare+0x200/0x200
  ? lock_acquire+0x15a/0x3b0
  ? md_handle_request+0x230/0x5e0
  ? find_held_lock+0x83/0xa0
  ? raid1_end_write_request+0x720/0x720 [raid1]
  ? lock_release+0x1d1/0x3b0
  ? md_handle_request+0x29b/0x5e0
  ? reacquire_held_locks+0x270/0x270
  ? lock_acquire+0x15a/0x3b0
  ? bio_associate_blkg_from_css+0x209/0x9d0
  ? find_held_lock+0x83/0xa0
  ? lock_is_held_type+0xa6/0x110
  md_handle_request+0x2dc/0x5e0
  ? mddev_init_writes_pending+0x60/0x60
  ? lock_release+0x1d1/0x3b0
  ? bio_associate_blkg+0x71/0x130
  ? reacquire_held_locks+0x270/0x270
  ? bio_associate_blkg_from_css+0x2e1/0x9d0
  raid_map+0x61/0x80 [dm_raid]
  __map_bio+0x85/0x290
  dm_submit_bio+0x4b9/0xca0
  ? dm_get_live_table+0xd0/0xd0
  ? reacquire_held_locks+0x270/0x270
  ? lock_release+0x1d1/0x3b0
  ? lock_is_held_type+0xa6/0x110
  __submit_bio+0x139/0x180
  ? __bio_queue_enter+0x350/0x350
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? seqcount_lockdep_reader_access.constprop.0+0x82/0x90
  ? seqcount_lockdep_reader_access.constprop.0+0x82/0x90
  ? ktime_get+0x1c/0xb0
  submit_bio_noacct_nocheck+0x2a1/0x5a0
  ? fscrypt_set_bio_crypt_ctx+0x6c/0x120
  ? fscrypt_dio_supported+0xb0/0xb0
  ? blk_alloc_queue+0x310/0x310
  ? guard_bio_eod+0x51/0x310
  ? submit_bio_noacct+0x310/0xa60
  __block_write_full_folio+0x3ae/0x6d0
  ? bdev_statx_dioalign+0xe0/0xe0
  ? block_invalidate_folio+0x2d0/0x2d0
  writepage_cb+0x34/0xb0
  write_cache_pages+0x257/0x650
  ? dirty_background_bytes_handler+0x20/0x20
  ? folio_clear_dirty_for_io+0x1b0/0x1b0
  ? do_writepages+0x25e/0x300
  ? find_held_lock+0x83/0xa0
  ? reacquire_held_locks+0x270/0x270
  ? do_raw_spin_lock+0x114/0x1a0
  ? spin_bug+0xe0/0xe0
  do_writepages+0x192/0x300
  ? dirty_ratio_handler+0x50/0x50
  ? lock_release+0x1d1/0x3b0
  ? writeback_sb_inodes+0x2b2/0x7c0
  ? reacquire_held_locks+0x270/0x270
  ? do_raw_spin_lock+0x114/0x1a0
  __writeback_single_inode+0x8f/0x620
  writeback_sb_inodes+0x36d/0x7c0
  ? sync_inode_metadata+0xc0/0xc0
  ? down_read_trylock+0x16d/0x290
  ? trylock_super+0x11/0x60
  __writeback_inodes_wb+0x6b/0x130
  wb_writeback+0x447/0x540
  ? __writeback_inodes_wb+0x130/0x130
  ? mark_held_locks+0x65/0x90
  ? get_nr_inodes+0x5f/0xa0
  wb_workfn+0x5b4/0x7c0
  ? inode_wait_for_writeback+0x30/0x30
  ? lock_acquire+0x15a/0x3b0
  ? process_one_work+0x53f/0xa30
  ? lock_sync+0xf0/0xf0
  ? mark_held_locks+0x24/0x90
  process_one_work+0x622/0xa30
  ? lock_sync+0xf0/0xf0
  ? pwq_dec_nr_in_flight+0x100/0x100
  ? spin_bug+0xe0/0xe0
  ? mark_held_locks+0x24/0x90
  worker_thread+0x8a/0x6f0
  ? process_one_work+0xa30/0xa30
  kthread+0x173/0x1b0
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x28/0x50
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20
  </TASK>
INFO: task kworker/u16:3:174452 blocked for more than 181 seconds.
       Tainted: G        W          6.5.0-rc4+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u16:3   state:D stack:0     pid:174452 ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-252:4)
Call Trace:
  <TASK>
  __schedule+0x7aa/0x16e0
  ? io_schedule_timeout+0xb0/0xb0
  ? blk_mq_flush_plug_list+0x10/0x30
  ? __blk_flush_plug+0x1be/0x210
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  schedule+0x89/0x110
  md_super_wait+0x110/0x160
  ? md_super_write+0x1b0/0x1b0
  ? destroy_sched_domains_rcu+0x30/0x30
  ? write_page+0x1a3/0x890
  md_bitmap_wait_writes+0x15f/0x170
  ? behind_writes_used_reset+0x40/0x40
  ? __percpu_counter_sum+0x16/0xe0
  ? find_held_lock+0x83/0xa0
  ? lock_release+0x1d1/0x3b0
  ? __percpu_counter_sum+0xca/0xe0
  md_bitmap_unplug+0x1c5/0x210
  flush_bio_list+0x19a/0x1a0 [raid1]
  raid1_unplug+0x63/0x130 [raid1]
  __blk_flush_plug+0x189/0x210
  ? blk_start_plug_nr_ios+0xd0/0xd0
  blk_finish_plug+0x37/0x50
  wb_writeback+0x48c/0x540
  ? __writeback_inodes_wb+0x130/0x130
  wb_workfn+0x51a/0x7c0
  ? inode_wait_for_writeback+0x30/0x30
  ? lock_acquire+0x15a/0x3b0
  ? process_one_work+0x53f/0xa30
  ? lock_sync+0xf0/0xf0
  ? mark_held_locks+0x24/0x90
  process_one_work+0x622/0xa30
  ? lock_sync+0xf0/0xf0
  ? pwq_dec_nr_in_flight+0x100/0x100
  ? spin_bug+0xe0/0xe0
  ? mark_held_locks+0x24/0x90
  worker_thread+0x8a/0x6f0
  ? process_one_work+0xa30/0xa30
  kthread+0x173/0x1b0
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x28/0x50
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20
  </TASK>
INFO: task btserver:188934 blocked for more than 181 seconds.
       Tainted: G        W          6.5.0-rc4+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:btserver        state:D stack:0     pid:188934 ppid:188373 flags:0x00000002
Call Trace:
  <TASK>
  __schedule+0x7aa/0x16e0
  ? io_schedule_timeout+0xb0/0xb0
  ? lock_release+0x1d1/0x3b0
  ? mark_held_locks+0x65/0x90
  schedule+0x89/0x110
  io_schedule+0x68/0xa0
  bit_wait_io+0x12/0x80
  __wait_on_bit_lock+0xcf/0x120
  ? bit_wait+0x80/0x80
  out_of_line_wait_on_bit_lock+0xd7/0x110
  ? __wait_on_bit_lock+0x120/0x120
  ? cpuacct_css_alloc+0xd0/0xd0
  do_get_write_access+0x458/0x830
  jbd2_journal_get_write_access+0x76/0xa0
  __ext4_journal_get_write_access+0xea/0x210
  ext4_orphan_add+0x432/0x8b0
  ? stop_this_handle+0x210/0x210
  ? kasan_set_track+0x21/0x30
  ? __kasan_slab_alloc+0x62/0x70
  ? ext4_fc_destroy_dentry_cache+0x10/0x10
  ? kmem_cache_alloc+0x22e/0x290
  ? rcu_is_watching+0x1f/0x40
  ? jbd2__journal_start+0x22d/0x340
  ext4_truncate+0x43c/0x930
  ? ext4_punch_hole+0x7a0/0x7a0
  ? __do_fault+0x290/0x290
  ext4_setattr+0xc43/0x1100
  ? make_vfsgid+0x76/0xf0
  notify_change+0x306/0x6c0
  do_truncate+0xdc/0x160
  ? file_open_root+0x200/0x200
  ? ext4_file_write_iter+0xcd0/0xcd0
  path_openat+0xf37/0x1120
  ? path_lookupat+0x2e0/0x2e0
  ? ___slab_alloc+0x995/0x1300
  do_filp_open+0x151/0x270
  ? may_open_dev+0x50/0x50
  ? lock_is_held_type+0xa6/0x110
  ? reacquire_held_locks+0x270/0x270
  ? do_raw_spin_lock+0x114/0x1a0
  ? spin_bug+0xe0/0xe0
  ? do_raw_spin_unlock+0x8e/0xe0
  ? _raw_spin_unlock+0x1a/0x30
  ? alloc_fd+0x19b/0x320
  do_sys_openat2+0x103/0x130
  ? build_open_flags+0x240/0x240
  __x64_sys_openat+0xe0/0x130
  ? __ia32_compat_sys_open+0x120/0x120
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? syscall_enter_from_user_mode+0x1c/0x50
  do_syscall_64+0x34/0xb0
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f63771018e8
RSP: 002b:00007fffd4942040 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000241 RCX: 00007f63771018e8
RDX: 0000000000000241 RSI: 0000000003c27440 RDI: 00000000ffffff9c
RBP: 0000000003c27440 R08: 0000000000000004 R09: 0000000000000001
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000003c27440
R13: 0000000000a316da R14: 0000000000000001 R15: 0000000000b0bbb0
  </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
  #0: ffffffff83840590 (rcu_tasks.tasks_gp_mutex){+.+.}-{4:4}, at: rcu_tasks_one_gp+0x32/0x690
1 lock held by rcu_tasks_trace/13:
  #0: ffffffff83840290 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{4:4}, at: rcu_tasks_one_gp+0x32/0x690
1 lock held by khungtaskd/64:
  #0: ffffffff83841160 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x29/0x230
1 lock held by mdX_raid1/488:
  #0: ffff88810aeac5e8 (&mddev->bitmap_info.mutex){+.+.}-{4:4}, at: md_bitmap_daemon_work+0x83/0x6a0
1 lock held by mdX_raid1/913:
  #0: ffff888121ccc5e8 (&mddev->bitmap_info.mutex){+.+.}-{4:4}, at: md_bitmap_daemon_work+0x83/0x6a0
1 lock held by jbd2/dm-14-8/958:
  #0: ffff88810dffe680 (&md->io_barrier){.+.+}-{0:0}, at: dm_get_live_table+0x0/0xd0
1 lock held by fuse mainloop/2513:
  #0: ffff88811f35e468 (&pipe->mutex/1){+.+.}-{4:4}, at: splice_file_to_pipe+0x21/0xd0
1 lock held by fuse mainloop/2515:
  #0: ffff88811c744468 (&pipe->mutex/1){+.+.}-{4:4}, at: splice_file_to_pipe+0x21/0xd0
4 locks held by kworker/u16:0/145831:
  #0: ffff88810b797938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x53f/0xa30
  #1: ffff88814efc7dc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x53f/0xa30
  #2: ffff88810a3080e0 (&type->s_umount_key#53){.+.+}-{4:4}, at: trylock_super+0x11/0x60
  #3: ffff88810dffe680 (&md->io_barrier){.+.+}-{0:0}, at: dm_get_live_table+0x0/0xd0
2 locks held by kworker/u16:3/174452:
  #0: ffff88810b797938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x53f/0xa30
  #1: ffff88812bd77dc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x53f/0xa30
2 locks held by kworker/4:1/184807:
  #0: ffff88810dc6e138 ((wq_completion)md){+.+.}-{0:0}, at: process_one_work+0x53f/0xa30
  #1: ffff888145e5fdc0 ((work_completion)(&mddev->flush_work)){+.+.}-{0:0}, at: process_one_work+0x53f/0xa30
4 locks held by btserver/188934:
  #0: ffff88812f7ee400 (sb_writers#9){.+.+}-{0:0}, at: path_openat+0xd77/0x1120
  #1: ffff888147320400 (&sb->s_type->i_mutex_key#15){++++}-{4:4}, at: do_truncate+0xca/0x160
  #2: ffff888147320590 (mapping.invalidate_lock#2){++++}-{4:4}, at: ext4_setattr+0x671/0x1100
  #3: ffff88812f7ec980 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x91b/0xaf0

=============================================

INFO: task mdX_raid1:488 blocked for more than 364 seconds.
       Tainted: G        W          6.5.0-rc4+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:mdX_raid1       state:D stack:0     pid:488   ppid:2      flags:0x00004000
Call Trace:
  <TASK>
  __schedule+0x7aa/0x16e0
  ? io_schedule_timeout+0xb0/0xb0
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  schedule+0x89/0x110
  md_super_wait+0x110/0x160
  ? md_super_write+0x1b0/0x1b0
  ? print_usage_bug.part.0+0x3d0/0x3d0
  ? __mutex_lock+0xd22/0x1200
  ? destroy_sched_domains_rcu+0x30/0x30
  ? lock_acquire+0x15a/0x3b0
  ? md_bitmap_daemon_work+0x2fc/0x6a0
  ? find_held_lock+0x83/0xa0
  md_bitmap_wait_writes+0x15f/0x170
  ? behind_writes_used_reset+0x40/0x40
  ? mark_held_locks+0x65/0x90
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irq+0x1f/0x40
  md_bitmap_daemon_work+0x483/0x6a0
  ? md_bitmap_write_all+0xe0/0xe0
  ? lock_acquire+0x15a/0x3b0
  ? lock_timer_base+0x93/0xd0
  md_check_recovery+0x7b/0xa50
  raid1d+0xdb/0x30b0 [raid1]
  ? lockdep_hardirqs_on_prepare+0x200/0x200
  ? lockdep_hardirqs_on_prepare+0x200/0x200
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  ? raid1_read_request+0x13b0/0x13b0 [raid1]
  ? finish_wait+0x4a/0xc0
  ? find_held_lock+0x83/0xa0
  ? lock_release+0x1d1/0x3b0
  ? md_thread+0x1fe/0x280
  ? reacquire_held_locks+0x270/0x270
  ? mark_held_locks+0x24/0x90
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  md_thread+0x175/0x280
  ? md_submit_discard_bio+0x210/0x210
  ? mark_held_locks+0x24/0x90
  ? destroy_sched_domains_rcu+0x30/0x30
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  ? md_submit_discard_bio+0x210/0x210
  kthread+0x173/0x1b0
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x28/0x50
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20
  </TASK>
INFO: task jbd2/dm-4-8:526 blocked for more than 364 seconds.
       Tainted: G        W          6.5.0-rc4+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jbd2/dm-4-8     state:D stack:0     pid:526   ppid:2      flags:0x00004000
Call Trace:
  <TASK>
  __schedule+0x7aa/0x16e0
  ? io_schedule_timeout+0xb0/0xb0
  ? lock_sync+0xf0/0xf0
  ? find_held_lock+0x83/0xa0
  ? __wait_on_bit+0x95/0x100
  ? reacquire_held_locks+0x270/0x270
  ? submit_bio_noacct_nocheck+0x516/0x5a0
  schedule+0x89/0x110
  io_schedule+0x68/0xa0
  bit_wait_io+0x12/0x80
  __wait_on_bit+0x3a/0x100
  ? bit_wait+0x80/0x80
  out_of_line_wait_on_bit+0xd7/0x110
  ? __wait_on_bit+0x100/0x100
  ? cpuacct_css_alloc+0xd0/0xd0
  jbd2_journal_commit_transaction+0x2767/0x2ec0
  ? jbd2_journal_finish_inode_data_buffers+0x50/0x50
  ? find_held_lock+0x83/0xa0
  ? lock_release+0x1d1/0x3b0
  ? __timer_delete_sync+0x170/0x210
  ? reacquire_held_locks+0x270/0x270
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  ? timer_shutdown+0xe0/0xe0
  ? do_raw_read_unlock+0x80/0x80
  kjournald2+0x16c/0x560
  ? jbd2_write_superblock+0x450/0x450
  ? mark_held_locks+0x24/0x90
  ? destroy_sched_domains_rcu+0x30/0x30
  ? lockdep_hardirqs_on_prepare+0x132/0x200
  ? _raw_spin_unlock_irqrestore+0x2b/0x50
  ? jbd2_write_superblock+0x450/0x450
  kthread+0x173/0x1b0
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x28/0x50
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork_asm+0x11/0x20
  </TASK>
INFO: task journal-offline:190685 blocked for more than 365 seconds.
       Tainted: G        W          6.5.0-rc4+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:journal-offline state:D stack:0     pid:190685 ppid:1      flags:0x00000002
Call Trace:
  <TASK>
  __schedule+0x7aa/0x16e0
  ? io_schedule_timeout+0xb0/0xb0
  ? folio_wait_bit_common+0x11e/0x470
  ? find_held_lock+0x83/0xa0
  ? lock_release+0x1d1/0x3b0
  ? reacquire_held_locks+0x270/0x270
  ? do_raw_spin_lock+0x114/0x1a0
  schedule+0x89/0x110
  io_schedule+0x68/0xa0
  folio_wait_bit_common+0x20b/0x470
  ? filemap_get_folios_contig+0x4e0/0x4e0
  ? filemap_invalidate_unlock_two+0x30/0x30
  ? lockdep_hardirqs_on_prepare+0x200/0x200
  folio_wait_writeback+0x16/0x100
  __filemap_fdatawait_range+0xc1/0x150
  ? filemap_get_folios_tag+0x5c0/0x5c0
  ? find_held_lock+0x83/0xa0
  ? __filemap_fdatawrite_range+0xc6/0x120
  ? delete_from_page_cache_batch+0x450/0x450
  ? strscpy+0xc5/0x190
  file_write_and_wait_range+0x9b/0xc0
  ext4_sync_file+0x134/0x640
  __x64_sys_fsync+0x3e/0x60
  do_syscall_64+0x34/0xb0
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f9088d0868a
RSP: 002b:00007f90869fd9f0 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
RAX: ffffffffffffffda RBX: 000055efd35f5940 RCX: 00007f9088d0868a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000002a
RBP: 000055efd361a510 R08: 0000000000000000 R09: 00007fff65ac277f
R10: 00007f9088c8cc1e R11: 0000000000000293 R12: 000055efd2c527a0
R13: 0000000000000002 R14: 00007fff65ac2680 R15: 00007f90861fe000
  </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
  #0: ffffffff83840590 (rcu_tasks.tasks_gp_mutex){+.+.}-{4:4}, at: rcu_tasks_one_gp+0x32/0x690
1 lock held by rcu_tasks_trace/13:
  #0: ffffffff83840290 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{4:4}, at: rcu_tasks_one_gp+0x32/0x690
1 lock held by khungtaskd/64:
  #0: ffffffff83841160 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x29/0x230
1 lock held by mdX_raid1/488:
  #0: ffff88810aeac5e8 (&mddev->bitmap_info.mutex){+.+.}-{4:4}, at: md_bitmap_daemon_work+0x83/0x6a0
1 lock held by mdX_raid1/913:
  #0: ffff888121ccc5e8 (&mddev->bitmap_info.mutex){+.+.}-{4:4}, at: md_bitmap_daemon_work+0x83/0x6a0
1 lock held by jbd2/dm-14-8/958:
  #0: ffff88810dffe680 (&md->io_barrier){.+.+}-{0:0}, at: dm_get_live_table+0x0/0xd0
1 lock held by fuse mainloop/2513:
  #0: ffff88811f35e468 (&pipe->mutex/1){+.+.}-{4:4}, at: splice_file_to_pipe+0x21/0xd0
1 lock held by fuse mainloop/2515:
  #0: ffff88811c744468 (&pipe->mutex/1){+.+.}-{4:4}, at: splice_file_to_pipe+0x21/0xd0
4 locks held by kworker/u16:0/145831:
  #0: ffff88810b797938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x53f/0xa30
  #1: ffff88814efc7dc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x53f/0xa30
  #2: ffff88810a3080e0 (&type->s_umount_key#53){.+.+}-{4:4}, at: trylock_super+0x11/0x60
  #3: ffff88810dffe680 (&md->io_barrier){.+.+}-{0:0}, at: dm_get_live_table+0x0/0xd0
2 locks held by kworker/u16:3/174452:
  #0: ffff88810b797938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x53f/0xa30
  #1: ffff88812bd77dc0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x53f/0xa30
2 locks held by kworker/4:1/184807:
  #0: ffff88810dc6e138 ((wq_completion)md){+.+.}-{0:0}, at: process_one_work+0x53f/0xa30
  #1: ffff888145e5fdc0 ((work_completion)(&mddev->flush_work)){+.+.}-{0:0}, at: process_one_work+0x53f/0xa30
4 locks held by btserver/188934:
  #0: ffff88812f7ee400 (sb_writers#9){.+.+}-{0:0}, at: path_openat+0xd77/0x1120
  #1: ffff888147320400 (&sb->s_type->i_mutex_key#15){++++}-{4:4}, at: do_truncate+0xca/0x160
  #2: ffff888147320590 (mapping.invalidate_lock#2){++++}-{4:4}, at: ext4_setattr+0x671/0x1100
  #3: ffff88812f7ec980 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x91b/0xaf0
3 locks held by grep/190700:
  #0: ffff888124a38848 (&f->f_pos_lock){+.+.}-{4:4}, at: __fdget_pos+0x40/0x50
  #1: ffff88812f7ee400 (sb_writers#9){.+.+}-{0:0}, at: filemap_read+0x5ab/0x5c0
  #2: ffff88812f7ec980 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x91b/0xaf0

=============================================

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


