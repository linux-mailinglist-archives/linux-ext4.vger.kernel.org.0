Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3994177D7BE
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 03:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbjHPBcA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 21:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241157AbjHPBbw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 21:31:52 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BCA26A4;
        Tue, 15 Aug 2023 18:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=iAwW/qc4WG/oCikxqV/z13iVg375PbhJQzRlMsOOR04=; b=RAYEJolL+tn7RM6x7LaiZF/Te/
        xaoyVYyDWG8fp9ADX+vEUn7gQWjJ6OGLVRTDhf6yBYKyDZK736jnezJ4uDOglvhOpmcUCNHIXF692
        0Dc7oMG0Vr+0R75+gpXHpM1TDYufSgfDTHc8Y498pStM5JzIez/Ay/hNm9qvKfoYXL12MQVbUEpix
        +gs4W75uA+LtU9RBoTI4lxrxKhQvPMey+1VbEIcvl3Oh9WdY4o2Nz8JbX/iYTXsqzUlP7CBIeiCkY
        L2KyG9gS3jub/ZAz87uJj1HF0ucyn74qNrgz1QXbiicxojX+Yn9SUmIel8x2TOPjNv2DVoii06D9S
        4gEBAqgQ==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qW5Nc-0079ha-3Z; Wed, 16 Aug 2023 01:31:24 +0000
Date:   Wed, 16 Aug 2023 01:31:24 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Theodore Ts'o <tytso@mit.edu>, hch@lst.de, axboe@kernel.dk
Cc:     adilger.kernel@dilger.ca, song@kernel.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: 6.5.0rc5 fs hang - ext4? raid?
Message-ID: <ZNwm7Mo9yv7uIkno@gallifrey>
References: <ZNqWfQPTScJDkmpX@gallifrey>
 <20230815125146.GA1508930@mit.edu>
 <ZNt11WbPn7LCXPvB@gallifrey>
 <ZNu668KGiNcwCSVe@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZNu668KGiNcwCSVe@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 01:22:52 up 40 days, 10:54,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

(Copying in Christoph and Jens)

* Dr. David Alan Gilbert (dave@treblig.org) wrote:
> * Dr. David Alan Gilbert (dave@treblig.org) wrote:
> > * Theodore Ts'o (tytso@mit.edu) wrote:
> > > On Mon, Aug 14, 2023 at 09:02:53PM +0000, Dr. David Alan Gilbert wrote:
> > > > dg         29594   29592  0 18:40 pts/0    00:00:00 /usr/bin/ar --plugin /usr/libexec/gcc/x86_64-redhat-linux/13/liblto_plugin.so -csrDT src/intel/perf/libintel_perf.a src/intel/perf/libintel_perf.a.p/meson-generated_.._intel_perf_metrics.c.o src/intel/perf/libintel_perf.a.p/intel_perf.c.o src/intel/perf/libintel_perf.a.p/intel_perf_query.c.o src/intel/perf/libintel_perf.a.p/intel_perf_mdapi.c.o
> > > > 
> > > > [root@dalek dg]# cat /proc/29594/stack 
> > > > [<0>] md_super_wait+0xa2/0xe0
> > > > [<0>] md_bitmap_unplug+0xd2/0x120
> > > > [<0>] flush_bio_list+0xf3/0x100 [raid1]
> > > > [<0>] raid1_unplug+0x3b/0xb0 [raid1]
> > > > [<0>] __blk_flush_plug+0xd7/0x150
> > > > [<0>] blk_finish_plug+0x29/0x40
> > > > [<0>] ext4_do_writepages+0x401/0xc90
> > > > [<0>] ext4_writepages+0xad/0x180
> > > 
> > > If you want a few seconds and try grabbing cat /proc/29594/stack
> > > again, what does the stack trace stay consistent as above?
> > 
> > I'll get back to that and retry it.
> 
> Yeh, the stack is consistent; this time around it's an 'ar' in a kernel
> build:
> 
> [root@dalek dg]# cat /proc/17970/stack
> [<0>] md_super_wait+0xa2/0xe0
> [<0>] md_bitmap_unplug+0xad/0x120
> [<0>] flush_bio_list+0xf3/0x100 [raid1]
> [<0>] raid1_unplug+0x3b/0xb0 [raid1]
> [<0>] __blk_flush_plug+0xd7/0x150
> [<0>] blk_finish_plug+0x29/0x40
> [<0>] ext4_do_writepages+0x401/0xc90
> [<0>] ext4_writepages+0xad/0x180
> [<0>] do_writepages+0xd2/0x1e0
> [<0>] filemap_fdatawrite_wbc+0x63/0x90
> [<0>] __filemap_fdatawrite_range+0x5c/0x80
> [<0>] ext4_release_file+0x74/0xb0
> [<0>] __fput+0xf5/0x2a0
> [<0>] task_work_run+0x5d/0x90
> [<0>] exit_to_user_mode_prepare+0x1e6/0x1f0
> [<0>] syscall_exit_to_user_mode+0x1b/0x40
> [<0>] do_syscall_64+0x6c/0x90
> [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [root@dalek dg]# cat /proc/17970/stack
> [<0>] md_super_wait+0xa2/0xe0
> [<0>] md_bitmap_unplug+0xad/0x120
> [<0>] flush_bio_list+0xf3/0x100 [raid1]
> [<0>] raid1_unplug+0x3b/0xb0 [raid1]
> [<0>] __blk_flush_plug+0xd7/0x150
> [<0>] blk_finish_plug+0x29/0x40
> [<0>] ext4_do_writepages+0x401/0xc90
> [<0>] ext4_writepages+0xad/0x180
> [<0>] do_writepages+0xd2/0x1e0
> [<0>] filemap_fdatawrite_wbc+0x63/0x90
> [<0>] __filemap_fdatawrite_range+0x5c/0x80
> [<0>] ext4_release_file+0x74/0xb0
> [<0>] __fput+0xf5/0x2a0
> [<0>] task_work_run+0x5d/0x90
> [<0>] exit_to_user_mode_prepare+0x1e6/0x1f0
> [<0>] syscall_exit_to_user_mode+0x1b/0x40
> [<0>] do_syscall_64+0x6c/0x90
> [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> 
> > > Also, if you have iostat installed (usually part of the sysstat
> > > package), does "iostat 1" show any I/O activity on the md device?
> 
> iostat is showing something odd, most devices are at 0,
> except for 3 of the dm's that are stuck at 100% utilisation with
> apparently nothing going on:
> 
> avg-cpu:  %user   %nice %system %iowait  %steal   %idle
>            0.06    0.00    0.03   53.06    0.00   46.84
> 
> Device            r/s     rkB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wkB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dkB/s   drqm/s  %drqm d_await dareq-sz     f/s f_await  aqu-sz  %util
> ...
> dm-16            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00 100.00
> dm-17            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00 100.00
> dm-18            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
> dm-19            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
> dm-2             0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
> dm-20            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00 100.00
> ....
> 
> dm-20 is the /dev/mapper/main-more which is the RAID on which the
> fs runs, 16 and 17 are main-more_rmeta_0 and main-more_rimage_0
> so something screwy is going on there.

I've just finished a bisect of this hang, and got to:

615939a2ae734e3e68c816d6749d1f5f79c62ab7 is the first bad commit
commit 615939a2ae734e3e68c816d6749d1f5f79c62ab7
Author: Christoph Hellwig <hch@lst.de>
Date:   Fri May 19 06:40:48 2023 +0200

    blk-mq: defer to the normal submission path for post-flush requests

    Requests with the FUA bit on hardware without FUA support need a post
    flush before returning to the caller, but they can still be sent using
    the normal I/O path after initializing the flush-related fields and
    end I/O handler.

    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Bart Van Assche <bvanassche@acm.org>
    Link: https://lore.kernel.org/r/20230519044050.107790-6-hch@lst.de
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

the full set of runs is:
 2 good: 6995e2de6891c724bfeb2db33d7b87775f913ad1 v6.4
 7 good  0aa69d53ac7c30f6184f88f2e310d808b32b35a5 6.4.0dg-00428-g0aa69d53ac7c
12 good  c1075e548ce6e6b5c7b71f2b05d344164ebc52bb 6.4.0-rc2dg-00020-gc1075e548ce6
15 good  be4c427809b0a746aff54dbb8ef663f0184291d0 6.4.0-rc2dg-00022-gbe4c427809b0
17 bad   615939a2ae734e3e68c816d6749d1f5f79c62ab7 6.4.0-rc2dg-00023-g615939a2ae73
16 bad   1e82fadfc6b96ca79f69d0bcf938d31032bb43d2 6.4.0-rc2dg-00024-g1e82fadfc6b9
14 bad   9a67aa52a42b31ad44220cc218df3b75a5cd5d05 6.4.0-rc2dg-00025-g9a67aa52a42b
13 bad   38f2dd34410f9070b60969a07ff7d8743b4fd56c 6.4.0-rc2dg-00030-g38f2dd34410f
11 bad   a450f49708ea2ccabd1c5d2fe8a702ca5ef77941 6.4.0-rc2dg-00071-ga450f49708ea
10 bad   a4f75764d16bed317276b05a9fe2c179ef61680d 6.4.0-rc2dg-00112-ga4f75764d16b
 9 bad   658afed19ceed54a52b9e9e69c0791c8868ff55d 6.4.0-rc2dg-00193-g658afed19cee
 8 bad   7cffdbe3607a6cc2dc02d135e13732ec36bc4e28 6.4.0dg-00752-g7cffdbe3607a
 6 bad   2605e80d3438c77190f55b821c6575048c68268e 6.4.0dg-01094-g2605e80d3438
 5 bad   6e17c6de3ddf3073741d9c91a796ee696914d8a0 6.4.0dg-02143-g6e17c6de3ddf
 4 bad   3a8a670eeeaa40d87bd38a587438952741980c18 6.4.0dg-04247-g3a8a670eeeaa
 3 bad   1b722407a13b7f8658d2e26917791f32805980a2   6.4.0dg-07066-g1b722407a13b
 1 bad: 52a93d39b17dc v6.5-rc5

a sysrq-w from build 16 ( 1e82fadfc6b96ca79f69d0bcf938d31032bb43d2 )
s below.

This is very repeatable for me;
  a) boot into desktop
  b) Start rhythmbox playing
  c) Open 2 terminals
  d) In one start    make clean on kernel tree
  e) in other start  iostat -x 1
  f) Once the make clean is done,  make -j 32
  g) If that succeeds  try  ag  somejunk   in kernel tree (i.e. parallel
  grep)

It's not clear to me if starting rhythmbox is actually necessary;
but with that recipe it often fails in a few seconds.

Let me know if there's anything you'd like me to try.

Dave

[   90.614548] sysrq: Show Blocked State
[   90.615300] task:kworker/u64:3   state:D stack:0     pid:232   ppid:2      flags:0x00004000
[   90.615307] Workqueue: writeback wb_workfn (flush-253:20)
[   90.615315] Call Trace:
[   90.615317]  <TASK>
[   90.615321]  __schedule+0x3eb/0x14c0
[   90.615327]  ? update_sd_lb_stats.constprop.0+0x135/0x8d0
[   90.615334]  schedule+0x5e/0xd0
[   90.615336]  io_schedule+0x46/0x70
[   90.615338]  bit_wait_io+0x11/0x70
[   90.615341]  __wait_on_bit+0x46/0x140
[   90.615343]  ? __pfx_bit_wait_io+0x10/0x10
[   90.615346]  out_of_line_wait_on_bit+0x95/0xc0
[   90.615349]  ? __pfx_wake_bit_function+0x10/0x10
[   90.615353]  do_get_write_access+0x266/0x410
[   90.615358]  jbd2_journal_get_write_access+0x5f/0x80
[   90.615362]  __ext4_journal_get_write_access+0x85/0x180
[   90.615366]  ? ext4_get_group_desc+0x5c/0xe0
[   90.615369]  ext4_mb_mark_diskspace_used+0x10d/0x460
[   90.615374]  ext4_mb_new_blocks+0x18b/0x1000
[   90.615377]  ? __kmalloc+0x4d/0x150
[   90.615381]  ? ext4_find_extent+0x3c6/0x420
[   90.615385]  ext4_ext_map_blocks+0x60d/0x1980
[   90.615389]  ? allocate_slab+0x251/0x4c0
[   90.615393]  ? ext4_alloc_io_end_vec+0x23/0x80
[   90.615397]  ? mpage_prepare_extent_to_map+0x454/0x490
[   90.615401]  ext4_map_blocks+0x251/0x620
[   90.615404]  ext4_do_writepages+0x76a/0xc90
[   90.615408]  ext4_writepages+0xad/0x180
[   90.615414]  do_writepages+0xd2/0x1e0
[   90.615418]  ? __wb_calc_thresh+0x4b/0x130
[   90.615421]  __writeback_single_inode+0x3d/0x360
[   90.615424]  ? wbc_detach_inode+0x101/0x220
[   90.615427]  writeback_sb_inodes+0x1ed/0x4b0
[   90.615432]  __writeback_inodes_wb+0x4c/0xf0
[   90.615435]  wb_writeback+0x172/0x2f0
[   90.615439]  wb_workfn+0x2b5/0x510
[   90.615442]  ? __schedule+0x3f3/0x14c0
[   90.615444]  ? __mod_timer+0x11f/0x370
[   90.615449]  process_one_work+0x1c7/0x3d0
[   90.615453]  worker_thread+0x51/0x390
[   90.615456]  ? __pfx_worker_thread+0x10/0x10
[   90.615458]  kthread+0xe8/0x120
[   90.615462]  ? __pfx_kthread+0x10/0x10
[   90.615466]  ret_from_fork+0x2c/0x50
[   90.615472]  </TASK>
[   90.615613] task:kworker/u64:4   state:D stack:0     pid:290   ppid:2      flags:0x00004000
[   90.615617] Workqueue: writeback wb_workfn (flush-253:20)
[   90.615621] Call Trace:
[   90.615622]  <TASK>
[   90.615623]  __schedule+0x3eb/0x14c0
[   90.615626]  ? __submit_bio+0x88/0x170
[   90.615629]  ? submit_bio_noacct_nocheck+0x159/0x370
[   90.615632]  schedule+0x5e/0xd0
[   90.615635]  md_super_wait+0xa2/0xe0
[   90.615640]  ? __pfx_autoremove_wake_function+0x10/0x10
[   90.615644]  md_bitmap_unplug+0xf3/0x120
[   90.615650]  flush_bio_list+0x1e/0xe0 [raid1]
[   90.615659]  raid1_unplug+0xaf/0xd0 [raid1]
[   90.615665]  __blk_flush_plug+0xdb/0x160
[   90.615669]  blk_finish_plug+0x29/0x40
[   90.615671]  wb_writeback+0x2bc/0x2f0
[   90.615674]  wb_workfn+0x2b5/0x510
[   90.615677]  ? ttwu_queue_wakelist+0xef/0x110
[   90.615681]  process_one_work+0x1c7/0x3d0
[   90.615684]  worker_thread+0x51/0x390
[   90.615687]  ? __pfx_worker_thread+0x10/0x10
[   90.615689]  kthread+0xe8/0x120
[   90.615692]  ? __pfx_kthread+0x10/0x10
[   90.615696]  ret_from_fork+0x2c/0x50
[   90.615701]  </TASK>
[   90.616150] task:mdX_raid1       state:D stack:0     pid:1425  ppid:2      flags:0x00004000
[   90.616153] Call Trace:
[   90.616154]  <TASK>
[   90.616155]  __schedule+0x3eb/0x14c0
[   90.616157]  ? __schedule+0x3f3/0x14c0
[   90.616161]  schedule+0x5e/0xd0
[   90.616163]  md_super_wait+0xa2/0xe0
[   90.616167]  ? __pfx_autoremove_wake_function+0x10/0x10
[   90.616171]  md_bitmap_daemon_work+0x211/0x3a0
[   90.616175]  ? __pfx_md_thread+0x10/0x10
[   90.616179]  md_check_recovery+0x42/0x5a0
[   90.616182]  raid1d+0x87/0x16d0 [raid1]
[   90.616188]  ? __pfx_md_thread+0x10/0x10
[   90.616191]  ? __schedule+0x3f3/0x14c0
[   90.616193]  ? psi_task_switch+0x84/0x230
[   90.616198]  ? lock_timer_base+0x61/0x80
[   90.616202]  ? prepare_to_wait_event+0x60/0x180
[   90.616206]  ? __pfx_md_thread+0x10/0x10
[   90.616209]  md_thread+0xae/0x190
[   90.616212]  ? __pfx_autoremove_wake_function+0x10/0x10
[   90.616217]  kthread+0xe8/0x120
[   90.616220]  ? __pfx_kthread+0x10/0x10
[   90.616223]  ret_from_fork+0x2c/0x50
[   90.616228]  </TASK>
[   90.616310] task:jbd2/dm-20-8    state:D stack:0     pid:1501  ppid:2      flags:0x00004000
[   90.616313] Call Trace:
[   90.616314]  <TASK>
[   90.616315]  __schedule+0x3eb/0x14c0
[   90.616317]  ? mempool_alloc+0x89/0x1b0
[   90.616322]  schedule+0x5e/0xd0
[   90.616324]  md_super_wait+0xa2/0xe0
[   90.616328]  ? __pfx_autoremove_wake_function+0x10/0x10
[   90.616332]  md_bitmap_unplug+0xba/0x120
[   90.616336]  flush_bio_list+0x1e/0xe0 [raid1]
[   90.616342]  raid1_unplug+0xaf/0xd0 [raid1]
[   90.616349]  __blk_flush_plug+0xdb/0x160
[   90.616352]  blk_finish_plug+0x29/0x40
[   90.616354]  jbd2_journal_commit_transaction+0xfdb/0x1a00
[   90.616362]  kjournald2+0xad/0x280
[   90.616367]  ? __pfx_autoremove_wake_function+0x10/0x10
[   90.616372]  ? __pfx_kjournald2+0x10/0x10
[   90.616375]  kthread+0xe8/0x120
[   90.616378]  ? __pfx_kthread+0x10/0x10
[   90.616382]  ret_from_fork+0x2c/0x50
[   90.616387]  </TASK>
[   90.618244] task:oggdemux0:sink  state:D stack:0     pid:3216  ppid:2103   flags:0x00000002
[   90.618248] Call Trace:
[   90.618249]  <TASK>
[   90.618251]  __schedule+0x3eb/0x14c0
[   90.618254]  schedule+0x5e/0xd0
[   90.618256]  io_schedule+0x46/0x70
[   90.618259]  folio_wait_bit_common+0x13d/0x350
[   90.618262]  ? __pfx_wake_page_function+0x10/0x10
[   90.618265]  filemap_get_pages+0x5fe/0x630
[   90.618268]  ? psi_task_switch+0xd6/0x230
[   90.618272]  ? finish_task_switch.isra.0+0x94/0x2f0
[   90.618276]  filemap_read+0xdf/0x350
[   90.618279]  ? dput+0x3a/0x310
[   90.618284]  vfs_read+0x1f6/0x320
[   90.618289]  ksys_read+0x6f/0xf0
[   90.618291]  do_syscall_64+0x60/0x90
[   90.618295]  ? exit_to_user_mode_prepare+0x142/0x1f0
[   90.618298]  ? syscall_exit_to_user_mode+0x1b/0x40
[   90.618302]  ? do_syscall_64+0x6c/0x90
[   90.618305]  ? exit_to_user_mode_prepare+0x142/0x1f0
[   90.618307]  ? syscall_exit_to_user_mode+0x1b/0x40
[   90.618310]  ? do_syscall_64+0x6c/0x90
[   90.618312]  ? do_syscall_64+0x6c/0x90
[   90.618314]  ? do_syscall_64+0x6c/0x90
[   90.618316]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   90.618321] RIP: 0033:0x7f2b3f9083ba
[   90.618346] RSP: 002b:00007f2b179fe180 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   90.618349] RAX: ffffffffffffffda RBX: 0000559e098dfd20 RCX: 00007f2b3f9083ba
[   90.618351] RDX: 00000000000025ae RSI: 00007f2b04038190 RDI: 0000000000000015
[   90.618352] RBP: 00007f2b179fe1a0 R08: 0000000000000000 R09: 00007f2b3f1e16a0
[   90.618354] R10: 0000000000000001 R11: 0000000000000246 R12: 00000000000025ae
[   90.618355] R13: 0000000000000000 R14: 00007f2b179ff648 R15: 00000000000025ae
[   90.618358]  </TASK>
[   90.618426] task:gcc             state:D stack:0     pid:6486  ppid:6485   flags:0x00000006
[   90.618429] Call Trace:
[   90.618430]  <TASK>
[   90.618431]  __schedule+0x3eb/0x14c0
[   90.618435]  schedule+0x5e/0xd0
[   90.618437]  io_schedule+0x46/0x70
[   90.618440]  folio_wait_bit_common+0x13d/0x350
[   90.618443]  ? __pfx_wake_page_function+0x10/0x10
[   90.618445]  filemap_get_pages+0x5fe/0x630
[   90.618449]  ? path_openat+0xa2c/0x1140
[   90.618454]  filemap_read+0xdf/0x350
[   90.618457]  ? do_filp_open+0xb3/0x160
[   90.618461]  vfs_read+0x1f6/0x320
[   90.618465]  ksys_read+0x6f/0xf0
[   90.618467]  do_syscall_64+0x60/0x90
[   90.618469]  ? exc_page_fault+0x7f/0x180
[   90.618472]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   90.618476] RIP: 0033:0x7efee8b08381
[   90.618480] RSP: 002b:00007ffc7e238648 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   90.618482] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efee8b08381
[   90.618483] RDX: 0000000000000400 RSI: 000055b8799377e0 RDI: 0000000000000005
[   90.618484] RBP: 00007ffc7e238770 R08: 0000000000000400 R09: 00007efee88442c0
[   90.618486] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000400
[   90.618487] R13: 00007ffc7e238810 R14: 00007ffc7e238690 R15: 00007ffc7e238680
[   90.618490]  </TASK>

> Dave
> 
> 
> > > What about the underying block dvices used by the md device?  If the
> > > md device is attached to HDD's where you can see the activity light,
> > > can you see (or hear) any disk activity?
> > 
> > It's spinning rust, and I hear them go quiet when the hang happens.
> > 
> > Dave
> > 
> > > This sure seems like either the I/O driver isn't processing requests,
> > > or some kind of hang in the md layer....
> > > 
> > > 				- Ted
> > -- 
> >  -----Open up your eyes, open up your mind, open up your code -------   
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> > \        dave @ treblig.org |                               | In Hex /
> >  \ _________________________|_____ http://www.treblig.org   |_______/
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
