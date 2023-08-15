Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C404577CC85
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 14:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjHOMXv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 08:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjHOMXg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 08:23:36 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E1BDF;
        Tue, 15 Aug 2023 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I8gFzORTfZosRkEG8t3uR+SnOhWKuAB6hm3/jsLt3uE=; b=ObSaxDcfF7sQ5gINjvFovuDY4w
        JOoqLydZuc3pW1G2mpKo0DOniQzKsiTKrPoL1b71phQ4Pn96KR4FsNnPAEVpgwkT/JH/mvZ56I2sA
        iLNRy8gyTie9FqOq6n87mUetxhl3QQayQ2GfH6t8UKxRBT8N/EBhIFw9NxeRXKrXlAbVrvd9eTlDP
        goC1UMZJIYlkgZvajMPm3U/PmVEFEX2NUgeJqBuvkpGif9OylkoibqSkc1mJsltfYed4aYktNMmOa
        IocBb/hhYiUzR8jUlcnhVaW+uVZK6jQCKyHbVRDenjjb1m9sHSfo0Y9kLJHCeTrGvrwQUrrUwncCX
        tvHrYNYw==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qVt4u-0072qv-I8; Tue, 15 Aug 2023 12:23:16 +0000
Date:   Tue, 15 Aug 2023 12:23:16 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, song@kernel.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: 6.5.0rc5 fs hang - ext4? raid?
Message-ID: <ZNtuNDhuuoAzEluG@gallifrey>
References: <ZNqWfQPTScJDkmpX@gallifrey>
 <92a1dd41-cafa-4a8c-1e16-d638393d7255@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92a1dd41-cafa-4a8c-1e16-d638393d7255@huaweicloud.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 12:17:49 up 39 days, 21:49,  1 user,  load average: 0.00, 0.02, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Yu Kuai (yukuai1@huaweicloud.com) wrote:
> Hi,
> 
> 在 2023/08/15 5:02, Dr. David Alan Gilbert 写道:
> > Hi,
> >    I'm seeing a few hangs on a fs after upgrading to fedora 39's bleeding
> > edge; which is running kernel 6.5.0-0.rc5.20230808git14f9643dc90a.37.fc39.x86_64
> > It was always solid prior to that.  It seems to trigger on heavy IO
> > on this fs.
> > 
> > The stack of this fs is:
> >    spinning rust on SATA
> >    LVM RAID 1
> >    ext4
> > 
> > The host is a Ryzen 3950X.
> > 
> > Below is a sysrq backtrace of blocked tasks; this happened with
> > rhythmbox playing audio off the fs, while a meson build ran.
> > There was no oops or anything, just all the tasks on the fs hung.
> > 
> > I've got another case now where the only interesting thing running
> > is an 'ag' (parallel grep) running over the kernel tree.
> > (Anything not on that fs still seems to be running OK)
> > 
> > So it seems easy to trigger for me.
> > 
> > NAME                         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
> > sda                            8:0    0   3.6T  0 disk
> > ├─sda1                         8:1    0     1G  0 part
> > └─sda2                         8:2    0   3.6T  0 part
> > ...
> >    ├─main-more_rmeta_0        253:16   0     4M  0 lvm
> >    │ └─main-more              253:20   0   900G  0 lvm  /discs/more
> >    ├─main-more_rimage_0       253:17   0   900G  0 lvm
> >    │ └─main-more              253:20   0   900G  0 lvm  /discs/more
> > 
> > sdb                            8:16   0   3.6T  0 disk
> > ├─sdb1                         8:17   0     1G  0 part
> > └─sdb2                         8:18   0   3.6T  0 part
> >    ├─main-more_rmeta_1        253:18   0     4M  0 lvm
> >    │ └─main-more              253:20   0   900G  0 lvm  /discs/more
> >    ├─main-more_rimage_1       253:19   0   900G  0 lvm
> >    │ └─main-more              253:20   0   900G  0 lvm  /discs/more
> > 
> 
> Can you stop all the test, and then collect the result of sda/sdb
> debugfs?

Sure, in this case I had rhythmbox running, and ran 'ag' across
a kernel tree; the ag hung after a few seconds.  I quit rhythmbox
and it allowed me to ctrl-c ag (which i don't think it let me last
time); then I gathered the following.

> You can use the following cmd to collect result:
> 
> find /sys/kernel/debug/block/sda/ -type f | xargs grep .


/sys/kernel/debug/block/sda/rqos/wbt/wb_background:4
/sys/kernel/debug/block/sda/rqos/wbt/wb_normal:8
/sys/kernel/debug/block/sda/rqos/wbt/unknown_cnt:0
/sys/kernel/debug/block/sda/rqos/wbt/min_lat_nsec:75000000
/sys/kernel/debug/block/sda/rqos/wbt/inflight:0: inflight 0
/sys/kernel/debug/block/sda/rqos/wbt/inflight:1: inflight 0
/sys/kernel/debug/block/sda/rqos/wbt/inflight:2: inflight 0
/sys/kernel/debug/block/sda/rqos/wbt/id:0
/sys/kernel/debug/block/sda/rqos/wbt/enabled:3
/sys/kernel/debug/block/sda/rqos/wbt/curr_win_nsec:0
/sys/kernel/debug/block/sda/hctx0/type:default
/sys/kernel/debug/block/sda/hctx0/dispatch_busy:0
/sys/kernel/debug/block/sda/hctx0/active:0
/sys/kernel/debug/block/sda/hctx0/run:20643
/sys/kernel/debug/block/sda/hctx0/sched_tags_bitmap:00000000: 0000 0000 0000 0000
/sys/kernel/debug/block/sda/hctx0/sched_tags:nr_tags=64
/sys/kernel/debug/block/sda/hctx0/sched_tags:nr_reserved_tags=0
/sys/kernel/debug/block/sda/hctx0/sched_tags:active_queues=0
/sys/kernel/debug/block/sda/hctx0/sched_tags:bitmap_tags:
/sys/kernel/debug/block/sda/hctx0/sched_tags:depth=64
/sys/kernel/debug/block/sda/hctx0/sched_tags:busy=0
/sys/kernel/debug/block/sda/hctx0/sched_tags:cleared=21
/sys/kernel/debug/block/sda/hctx0/sched_tags:bits_per_word=16
/sys/kernel/debug/block/sda/hctx0/sched_tags:map_nr=4
/sys/kernel/debug/block/sda/hctx0/sched_tags:alloc_hint={56, 36, 23, 58, 39, 16, 51, 39, 29, 19, 58, 30, 46, 12, 15, 44, 13, 5, 2, 19, 3, 21, 2, 7, 39, 58, 14, 17, 3, 42, 38, 5}
/sys/kernel/debug/block/sda/hctx0/sched_tags:wake_batch=1
/sys/kernel/debug/block/sda/hctx0/sched_tags:wake_index=6
/sys/kernel/debug/block/sda/hctx0/sched_tags:ws_active=0
/sys/kernel/debug/block/sda/hctx0/sched_tags:ws={
/sys/kernel/debug/block/sda/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/sched_tags:}
/sys/kernel/debug/block/sda/hctx0/sched_tags:round_robin=1
/sys/kernel/debug/block/sda/hctx0/sched_tags:min_shallow_depth=1
/sys/kernel/debug/block/sda/hctx0/tags_bitmap:00000000: 0000 0000
/sys/kernel/debug/block/sda/hctx0/tags:nr_tags=32
/sys/kernel/debug/block/sda/hctx0/tags:nr_reserved_tags=0
/sys/kernel/debug/block/sda/hctx0/tags:active_queues=0
/sys/kernel/debug/block/sda/hctx0/tags:bitmap_tags:
/sys/kernel/debug/block/sda/hctx0/tags:depth=32
/sys/kernel/debug/block/sda/hctx0/tags:busy=0
/sys/kernel/debug/block/sda/hctx0/tags:cleared=16
/sys/kernel/debug/block/sda/hctx0/tags:bits_per_word=8
/sys/kernel/debug/block/sda/hctx0/tags:map_nr=4
/sys/kernel/debug/block/sda/hctx0/tags:alloc_hint={23, 2, 21, 9, 27, 15, 9, 23, 16, 20, 10, 23, 14, 11, 3, 5, 25, 8, 8, 18, 18, 0, 3, 18, 28, 15, 16, 23, 1, 1, 16, 17}
/sys/kernel/debug/block/sda/hctx0/tags:wake_batch=4
/sys/kernel/debug/block/sda/hctx0/tags:wake_index=0
/sys/kernel/debug/block/sda/hctx0/tags:ws_active=0
/sys/kernel/debug/block/sda/hctx0/tags:ws={
/sys/kernel/debug/block/sda/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sda/hctx0/tags:}
/sys/kernel/debug/block/sda/hctx0/tags:round_robin=1
/sys/kernel/debug/block/sda/hctx0/tags:min_shallow_depth=4294967295
/sys/kernel/debug/block/sda/hctx0/ctx_map:00000000: 0000 0000
/sys/kernel/debug/block/sda/hctx0/flags:alloc_policy=RR SHOULD_MERGE
/sys/kernel/debug/block/sda/state:SAME_COMP|IO_STAT|ADD_RANDOM|INIT_DONE|WC|STATS|REGISTERED|NOWAIT|SQ_SCHED
/sys/kernel/debug/block/sda/pm_only:0


/sys/kernel/debug/block/sdb/rqos/wbt/wb_background:4
/sys/kernel/debug/block/sdb/rqos/wbt/wb_normal:8
/sys/kernel/debug/block/sdb/rqos/wbt/unknown_cnt:0
/sys/kernel/debug/block/sdb/rqos/wbt/min_lat_nsec:75000000
/sys/kernel/debug/block/sdb/rqos/wbt/inflight:0: inflight 0
/sys/kernel/debug/block/sdb/rqos/wbt/inflight:1: inflight 0
/sys/kernel/debug/block/sdb/rqos/wbt/inflight:2: inflight 0
/sys/kernel/debug/block/sdb/rqos/wbt/id:0
/sys/kernel/debug/block/sdb/rqos/wbt/enabled:3
/sys/kernel/debug/block/sdb/rqos/wbt/curr_win_nsec:0
/sys/kernel/debug/block/sdb/hctx0/type:default
/sys/kernel/debug/block/sdb/hctx0/dispatch_busy:3
/sys/kernel/debug/block/sdb/hctx0/active:0
/sys/kernel/debug/block/sdb/hctx0/run:113904
/sys/kernel/debug/block/sdb/hctx0/sched_tags_bitmap:00000000: 8000 1500 0520 0000
/sys/kernel/debug/block/sdb/hctx0/sched_tags:nr_tags=64
/sys/kernel/debug/block/sdb/hctx0/sched_tags:nr_reserved_tags=0
/sys/kernel/debug/block/sdb/hctx0/sched_tags:active_queues=0
/sys/kernel/debug/block/sdb/hctx0/sched_tags:bitmap_tags:
/sys/kernel/debug/block/sdb/hctx0/sched_tags:depth=64
/sys/kernel/debug/block/sdb/hctx0/sched_tags:busy=7
/sys/kernel/debug/block/sdb/hctx0/sched_tags:cleared=19
/sys/kernel/debug/block/sdb/hctx0/sched_tags:bits_per_word=16
/sys/kernel/debug/block/sdb/hctx0/sched_tags:map_nr=4
/sys/kernel/debug/block/sdb/hctx0/sched_tags:alloc_hint={17, 46, 8, 56, 4, 33, 35, 44, 58, 42, 46, 38, 6, 10, 3, 2, 13, 6, 0, 54, 19, 21, 3, 21, 29, 61, 0, 19, 7, 25, 46, 0}
/sys/kernel/debug/block/sdb/hctx0/sched_tags:wake_batch=1
/sys/kernel/debug/block/sdb/hctx0/sched_tags:wake_index=4
/sys/kernel/debug/block/sdb/hctx0/sched_tags:ws_active=0
/sys/kernel/debug/block/sdb/hctx0/sched_tags:ws={
/sys/kernel/debug/block/sdb/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/sched_tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/sched_tags:}
/sys/kernel/debug/block/sdb/hctx0/sched_tags:round_robin=1
/sys/kernel/debug/block/sdb/hctx0/sched_tags:min_shallow_depth=1
/sys/kernel/debug/block/sdb/hctx0/tags_bitmap:00000000: 0000 0000
/sys/kernel/debug/block/sdb/hctx0/tags:nr_tags=32
/sys/kernel/debug/block/sdb/hctx0/tags:nr_reserved_tags=0
/sys/kernel/debug/block/sdb/hctx0/tags:active_queues=0
/sys/kernel/debug/block/sdb/hctx0/tags:bitmap_tags:
/sys/kernel/debug/block/sdb/hctx0/tags:depth=32
/sys/kernel/debug/block/sdb/hctx0/tags:busy=0
/sys/kernel/debug/block/sdb/hctx0/tags:cleared=19
/sys/kernel/debug/block/sdb/hctx0/tags:bits_per_word=8
/sys/kernel/debug/block/sdb/hctx0/tags:map_nr=4
/sys/kernel/debug/block/sdb/hctx0/tags:alloc_hint={14, 6, 22, 11, 0, 8, 20, 6, 18, 14, 26, 16, 9, 6, 16, 5, 7, 15, 27, 2, 2, 16, 3, 3, 2, 12, 23, 1, 7, 15, 20, 0}
/sys/kernel/debug/block/sdb/hctx0/tags:wake_batch=4
/sys/kernel/debug/block/sdb/hctx0/tags:wake_index=0
/sys/kernel/debug/block/sdb/hctx0/tags:ws_active=0
/sys/kernel/debug/block/sdb/hctx0/tags:ws={
/sys/kernel/debug/block/sdb/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/tags:	{.wait=inactive},
/sys/kernel/debug/block/sdb/hctx0/tags:}
/sys/kernel/debug/block/sdb/hctx0/tags:round_robin=1
/sys/kernel/debug/block/sdb/hctx0/tags:min_shallow_depth=4294967295
/sys/kernel/debug/block/sdb/hctx0/ctx_map:00000000: 0000 0000
/sys/kernel/debug/block/sdb/hctx0/flags:alloc_policy=RR SHOULD_MERGE
/sys/kernel/debug/block/sdb/state:SAME_COMP|IO_STAT|ADD_RANDOM|INIT_DONE|WC|STATS|REGISTERED|NOWAIT|SQ_SCHED
/sys/kernel/debug/block/sdb/pm_only:0
> 
> Thanks,
> Kuai
> 
> > Dave
> > 
> > dg         29594   29592  0 18:40 pts/0    00:00:00 /usr/bin/ar --plugin /usr/libexec/gcc/x86_64-redhat-linux/13/liblto_plugin.so -csrDT src/intel/perf/libintel_perf.a src/intel/perf/libintel_perf.a.p/meson-generated_.._intel_perf_metrics.c.o src/intel/perf/libintel_perf.a.p/intel_perf.c.o src/intel/perf/libintel_perf.a.p/intel_perf_query.c.o src/intel/perf/libintel_perf.a.p/intel_perf_mdapi.c.o
> > 
> > [root@dalek dg]# cat /proc/29594/stack
> > [<0>] md_super_wait+0xa2/0xe0
> > [<0>] md_bitmap_unplug+0xd2/0x120
> > [<0>] flush_bio_list+0xf3/0x100 [raid1]
> > [<0>] raid1_unplug+0x3b/0xb0 [raid1]
> > [<0>] __blk_flush_plug+0xd7/0x150
> > [<0>] blk_finish_plug+0x29/0x40
> > [<0>] ext4_do_writepages+0x401/0xc90
> > [<0>] ext4_writepages+0xad/0x180
> > [<0>] do_writepages+0xd2/0x1e0
> > [<0>] filemap_fdatawrite_wbc+0x63/0x90
> > [<0>] __filemap_fdatawrite_range+0x5c/0x80
> > [<0>] ext4_release_file+0x74/0xb0
> > [<0>] __fput+0xf5/0x2a0
> > [<0>] task_work_run+0x5d/0x90
> > [<0>] exit_to_user_mode_prepare+0x1e6/0x1f0
> > [<0>] syscall_exit_to_user_mode+0x1b/0x40
> > [<0>] do_syscall_64+0x6c/0x90
> > [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > lvs -a hanging
> > 
> > 6.5.0-0.rc5.20230808git14f9643dc90a.37.fc39.x86_64
> > root       29780   29658  0 18:44 pts/5    00:00:00 [lvs]
> > 
> > [root@dalek dg]# cat /proc/29780/stack
> > [<0>] exit_aio+0x10d/0x120
> > [<0>] __mmput+0x12/0x130
> > [<0>] do_exit+0x305/0xb10
> > [<0>] do_group_exit+0x31/0x80
> > [<0>] get_signal+0x9a5/0x9e0
> > [<0>] arch_do_signal_or_restart+0x3e/0x270
> > [<0>] exit_to_user_mode_prepare+0x195/0x1f0
> > [<0>] syscall_exit_to_user_mode+0x1b/0x40
> > [<0>] do_syscall_64+0x6c/0x90
> > [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > 
> > [15884.105052] sysrq: Show Blocked State
> > [15884.105917] task:mdX_raid1       state:D stack:0     pid:1492  ppid:2      flags:0x00004000
> > [15884.105924] Call Trace:
> > [15884.105927]  <TASK>
> > [15884.105932]  __schedule+0x3ee/0x14c0
> > [15884.105940]  ? ttwu_do_activate+0x64/0x220
> > [15884.105947]  ? sysvec_apic_timer_interrupt+0xe/0x90
> > [15884.105952]  schedule+0x5e/0xd0
> > [15884.105955]  md_super_wait+0xa2/0xe0
> > [15884.105960]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [15884.105966]  md_bitmap_daemon_work+0x183/0x3b0
> > [15884.105971]  ? __pfx_md_thread+0x10/0x10
> > [15884.105974]  md_check_recovery+0x42/0x5a0
> > [15884.105981]  raid1d+0x87/0x16f0 [raid1]
> > [15884.105990]  ? __pfx_md_thread+0x10/0x10
> > [15884.105993]  ? __schedule+0x3f6/0x14c0
> > [15884.105996]  ? psi_task_switch+0x84/0x230
> > [15884.106001]  ? lock_timer_base+0x61/0x80
> > [15884.106007]  ? prepare_to_wait_event+0x60/0x180
> > [15884.106011]  ? __pfx_md_thread+0x10/0x10
> > [15884.106014]  md_thread+0xae/0x190
> > [15884.106017]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [15884.106022]  kthread+0xe8/0x120
> > [15884.106027]  ? __pfx_kthread+0x10/0x10
> > [15884.106031]  ret_from_fork+0x34/0x50
> > [15884.106036]  ? __pfx_kthread+0x10/0x10
> > [15884.106041]  ret_from_fork_asm+0x1b/0x30
> > [15884.106049]  </TASK>
> > [15884.106057] task:jbd2/dm-20-8    state:D stack:0     pid:1536  ppid:2      flags:0x00004000
> > [15884.106063] Call Trace:
> > [15884.106064]  <TASK>
> > [15884.106066]  __schedule+0x3ee/0x14c0
> > [15884.106070]  ? dm_submit_bio+0x3aa/0x620
> > [15884.106077]  schedule+0x5e/0xd0
> > [15884.106080]  io_schedule+0x46/0x70
> > [15884.106083]  bit_wait_io+0x11/0x70
> > [15884.106087]  __wait_on_bit+0x46/0x140
> > [15884.106090]  ? __pfx_bit_wait_io+0x10/0x10
> > [15884.106095]  out_of_line_wait_on_bit+0x95/0xc0
> > [15884.106099]  ? __pfx_wake_bit_function+0x10/0x10
> > [15884.106103]  jbd2_journal_commit_transaction+0x162d/0x1a10
> > [15884.106117]  kjournald2+0xad/0x280
> > [15884.106121]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [15884.106126]  ? __pfx_kjournald2+0x10/0x10
> > [15884.106129]  kthread+0xe8/0x120
> > [15884.106133]  ? __pfx_kthread+0x10/0x10
> > [15884.106138]  ret_from_fork+0x34/0x50
> > [15884.106141]  ? __pfx_kthread+0x10/0x10
> > [15884.106145]  ret_from_fork_asm+0x1b/0x30
> > [15884.106152]  </TASK>
> > [15884.106478] task:oggdemux28:sink state:D stack:0     pid:3637  ppid:2477   flags:0x00000002
> > [15884.106484] Call Trace:
> > [15884.106486]  <TASK>
> > [15884.106488]  __schedule+0x3ee/0x14c0
> > [15884.106494]  schedule+0x5e/0xd0
> > [15884.106497]  io_schedule+0x46/0x70
> > [15884.106500]  folio_wait_bit_common+0x13d/0x350
> > [15884.106506]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.106513]  filemap_get_pages+0x5fb/0x630
> > [15884.106518]  ? psi_task_switch+0xd6/0x230
> > [15884.106522]  ? __switch_to_asm+0x3e/0x70
> > [15884.106528]  filemap_read+0xd9/0x350
> > [15884.106532]  ? dput+0x3a/0x310
> > [15884.106539]  vfs_read+0x201/0x350
> > [15884.106546]  ksys_read+0x6f/0xf0
> > [15884.106551]  do_syscall_64+0x60/0x90
> > [15884.106557]  ? exit_to_user_mode_prepare+0x142/0x1f0
> > [15884.106561]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.106566]  ? do_syscall_64+0x6c/0x90
> > [15884.106569]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.106573]  ? do_syscall_64+0x6c/0x90
> > [15884.106576]  ? do_syscall_64+0x6c/0x90
> > [15884.106579]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.106583]  ? do_syscall_64+0x6c/0x90
> > [15884.106585]  ? do_syscall_64+0x6c/0x90
> > [15884.106589]  ? do_syscall_64+0x6c/0x90
> > [15884.106592]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.106598] RIP: 0033:0x7ff0e5f083ba
> > [15884.106626] RSP: 002b:00007ff0c77fd180 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.106630] RAX: ffffffffffffffda RBX: 00007ff0940c4eb0 RCX: 00007ff0e5f083ba
> > [15884.106633] RDX: 0000000000002278 RSI: 00007ff0a805c880 RDI: 0000000000000015
> > [15884.106635] RBP: 00007ff0c77fd1a0 R08: 0000000000000000 R09: 00007ff0e57886a0
> > [15884.106638] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000002278
> > [15884.106640] R13: 0000000000000000 R14: 00007ff0c77fe648 R15: 0000000000002278
> > [15884.106646]  </TASK>
> > [15884.106865] task:kworker/u64:2   state:D stack:0     pid:11557 ppid:2      flags:0x00004000
> > [15884.106872] Workqueue: writeback wb_workfn (flush-253:20)
> > [15884.106878] Call Trace:
> > [15884.106880]  <TASK>
> > [15884.106882]  __schedule+0x3ee/0x14c0
> > [15884.106886]  ? enqueue_entity+0x184/0x530
> > [15884.106891]  ? default_send_IPI_single_phys+0x36/0x50
> > [15884.106898]  schedule+0x5e/0xd0
> > [15884.106901]  schedule_timeout+0x151/0x160
> > [15884.106907]  wait_for_completion+0x8a/0x160
> > [15884.106912]  md_bitmap_unplug_async+0x8c/0xb0
> > [15884.106917]  ? __pfx_md_bitmap_unplug_fn+0x10/0x10
> > [15884.106922]  flush_bio_list+0x35/0x100 [raid1]
> > [15884.106931]  raid1_unplug+0x3b/0xb0 [raid1]
> > [15884.106941]  raid1_make_request+0x82b/0x1700 [raid1]
> > [15884.106951]  ? mempool_alloc+0x89/0x1b0
> > [15884.106956]  md_handle_request+0x135/0x220
> > [15884.106962]  raid_map+0x29/0x40 [dm_raid]
> > [15884.106972]  __map_bio+0x44/0x1c0
> > [15884.106977]  dm_submit_bio+0x261/0x620
> > [15884.106984]  __submit_bio+0xb3/0x170
> > [15884.106990]  submit_bio_noacct_nocheck+0x159/0x370
> > [15884.106995]  ext4_io_submit+0x24/0x40
> > [15884.107001]  ext4_do_writepages+0x3bd/0xc90
> > [15884.107008]  ext4_writepages+0xad/0x180
> > [15884.107015]  do_writepages+0xd2/0x1e0
> > [15884.107021]  __writeback_single_inode+0x3d/0x360
> > [15884.107025]  ? wbc_detach_inode+0x101/0x220
> > [15884.107029]  writeback_sb_inodes+0x1ed/0x4b0
> > [15884.107035]  __writeback_inodes_wb+0x4c/0xf0
> > [15884.107040]  wb_writeback+0x298/0x310
> > [15884.107045]  wb_workfn+0x35b/0x510
> > [15884.107049]  ? check_preempt_curr+0x61/0x70
> > [15884.107052]  ? ttwu_do_activate+0x64/0x220
> > [15884.107058]  process_one_work+0x1e1/0x3f0
> > [15884.107063]  worker_thread+0x51/0x390
> > [15884.107068]  ? __pfx_worker_thread+0x10/0x10
> > [15884.107071]  kthread+0xe8/0x120
> > [15884.107075]  ? __pfx_kthread+0x10/0x10
> > [15884.107080]  ret_from_fork+0x34/0x50
> > [15884.107084]  ? __pfx_kthread+0x10/0x10
> > [15884.107088]  ret_from_fork_asm+0x1b/0x30
> > [15884.107095]  </TASK>
> > [15884.107123] task:kworker/u64:3   state:D stack:0     pid:13757 ppid:2      flags:0x00004000
> > [15884.107128] Workqueue: md_bitmap md_bitmap_unplug_fn
> > [15884.107132] Call Trace:
> > [15884.107134]  <TASK>
> > [15884.107136]  __schedule+0x3ee/0x14c0
> > [15884.107140]  ? __submit_bio+0x8b/0x170
> > [15884.107144]  ? submit_bio_noacct_nocheck+0x159/0x370
> > [15884.107150]  schedule+0x5e/0xd0
> > [15884.107153]  md_super_wait+0xa2/0xe0
> > [15884.107157]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [15884.107161]  md_bitmap_unplug+0xad/0x120
> > [15884.107165]  md_bitmap_unplug_fn+0x16/0x20
> > [15884.107168]  process_one_work+0x1e1/0x3f0
> > [15884.107172]  worker_thread+0x51/0x390
> > [15884.107176]  ? __pfx_worker_thread+0x10/0x10
> > [15884.107180]  kthread+0xe8/0x120
> > [15884.107184]  ? __pfx_kthread+0x10/0x10
> > [15884.107188]  ret_from_fork+0x34/0x50
> > [15884.107192]  ? __pfx_kthread+0x10/0x10
> > [15884.107196]  ret_from_fork_asm+0x1b/0x30
> > [15884.107203]  </TASK>
> > [15884.107287] task:ccache          state:D stack:0     pid:29431 ppid:23240  flags:0x00000002
> > [15884.107292] Call Trace:
> > [15884.107294]  <TASK>
> > [15884.107296]  __schedule+0x3ee/0x14c0
> > [15884.107302]  schedule+0x5e/0xd0
> > [15884.107305]  io_schedule+0x46/0x70
> > [15884.107308]  folio_wait_bit_common+0x13d/0x350
> > [15884.107313]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.107318]  filemap_get_pages+0x5fb/0x630
> > [15884.107325]  filemap_read+0xd9/0x350
> > [15884.107332]  vfs_read+0x201/0x350
> > [15884.107338]  ksys_read+0x6f/0xf0
> > [15884.107343]  do_syscall_64+0x60/0x90
> > [15884.107347]  ? exc_page_fault+0x7f/0x180
> > [15884.107351]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.107355] RIP: 0033:0x7fda92908381
> > [15884.107364] RSP: 002b:00007ffc1017e0a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.107367] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fda92908381
> > [15884.107370] RDX: 0000000000001000 RSI: 000055924b25f180 RDI: 0000000000000004
> > [15884.107373] RBP: 00007ffc101805d0 R08: 0000000000000000 R09: 0000000000000001
> > [15884.107375] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000001000
> > [15884.107377] R13: 00007ffc1017e5a0 R14: 00007ffc1017f5f0 R15: 00007ffc1017e6d0
> > [15884.107381]  </TASK>
> > [15884.107384] task:ccache          state:D stack:0     pid:29436 ppid:23240  flags:0x00000002
> > [15884.107387] Call Trace:
> > [15884.107389]  <TASK>
> > [15884.107391]  __schedule+0x3ee/0x14c0
> > [15884.107397]  schedule+0x5e/0xd0
> > [15884.107400]  io_schedule+0x46/0x70
> > [15884.107403]  folio_wait_bit_common+0x13d/0x350
> > [15884.107407]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.107413]  filemap_get_pages+0x5fb/0x630
> > [15884.107417]  ? terminate_walk+0x61/0x100
> > [15884.107423]  filemap_read+0xd9/0x350
> > [15884.107427]  ? do_filp_open+0xb3/0x160
> > [15884.107434]  vfs_read+0x201/0x350
> > [15884.107440]  ksys_read+0x6f/0xf0
> > [15884.107445]  do_syscall_64+0x60/0x90
> > [15884.107449]  ? exc_page_fault+0x7f/0x180
> > [15884.107453]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.107458] RIP: 0033:0x7f534d908381
> > [15884.107464] RSP: 002b:00007ffc829af3e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.107468] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f534d908381
> > [15884.107470] RDX: 0000000000001000 RSI: 000055f64fb75160 RDI: 0000000000000004
> > [15884.107472] RBP: 00007ffc829b1910 R08: 0000000000000000 R09: 0000000000000001
> > [15884.107474] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000001000
> > [15884.107476] R13: 00007ffc829af8e0 R14: 00007ffc829b0930 R15: 00007ffc829afa10
> > [15884.107481]  </TASK>
> > [15884.107484] task:cc1             state:D stack:0     pid:29440 ppid:29439  flags:0x00000002
> > [15884.107488] Call Trace:
> > [15884.107490]  <TASK>
> > [15884.107492]  __schedule+0x3ee/0x14c0
> > [15884.107495]  ? ext4_match+0x108/0x150
> > [15884.107501]  schedule+0x5e/0xd0
> > [15884.107504]  io_schedule+0x46/0x70
> > [15884.107507]  folio_wait_bit_common+0x13d/0x350
> > [15884.107511]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.107517]  filemap_get_pages+0x5fb/0x630
> > [15884.107521]  ? get_page_from_freelist+0x1630/0x1770
> > [15884.107527]  ? path_lookupat+0x96/0x1a0
> > [15884.107533]  filemap_read+0xd9/0x350
> > [15884.107537]  ? avc_has_perm+0x5f/0xe0
> > [15884.107544]  vfs_read+0x201/0x350
> > [15884.107551]  ksys_read+0x6f/0xf0
> > [15884.107556]  do_syscall_64+0x60/0x90
> > [15884.107560]  ? __count_memcg_events+0x42/0x90
> > [15884.107564]  ? count_memcg_events.constprop.0+0x1a/0x30
> > [15884.107570]  ? handle_mm_fault+0x9e/0x350
> > [15884.107575]  ? do_user_addr_fault+0x179/0x640
> > [15884.107581]  ? exc_page_fault+0x7f/0x180
> > [15884.107585]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.107590] RIP: 0033:0x7f0616708381
> > [15884.107596] RSP: 002b:00007ffea22d25e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.107599] RAX: ffffffffffffffda RBX: 0000000004243050 RCX: 00007f0616708381
> > [15884.107602] RDX: 000000000001fdc8 RSI: 00000000042d89b0 RDI: 0000000000000006
> > [15884.107604] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.107606] R10: 0000000000000004 R11: 0000000000000246 R12: 0000000004151ae0
> > [15884.107608] R13: 0000000000000000 R14: 00000000042d89b0 R15: 000000000001fdc8
> > [15884.107613]  </TASK>
> > [15884.107622] task:cc1             state:D stack:0     pid:29443 ppid:29441  flags:0x00000002
> > [15884.107625] Call Trace:
> > [15884.107626]  <TASK>
> > [15884.107629]  __schedule+0x3ee/0x14c0
> > [15884.107634]  schedule+0x5e/0xd0
> > [15884.107638]  io_schedule+0x46/0x70
> > [15884.107641]  folio_wait_bit_common+0x13d/0x350
> > [15884.107645]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.107651]  filemap_get_pages+0x5fb/0x630
> > [15884.107658]  filemap_read+0xd9/0x350
> > [15884.107661]  ? memcg_check_events+0x77/0x1c0
> > [15884.107669]  vfs_read+0x201/0x350
> > [15884.107676]  ksys_read+0x6f/0xf0
> > [15884.107680]  do_syscall_64+0x60/0x90
> > [15884.107684]  ? do_user_addr_fault+0x179/0x640
> > [15884.107689]  ? exc_page_fault+0x7f/0x180
> > [15884.107693]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.107697] RIP: 0033:0x7fe61fb08381
> > [15884.107704] RSP: 002b:00007fffb85c3588 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.107707] RAX: ffffffffffffffda RBX: 0000000003860770 RCX: 00007fe61fb08381
> > [15884.107709] RDX: 000000000001fdc8 RSI: 00000000038dfd60 RDI: 0000000000000006
> > [15884.107711] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.107713] R10: 00000000038dfd50 R11: 0000000000000246 R12: 000000000384bae0
> > [15884.107716] R13: 0000000000000000 R14: 00000000038dfd60 R15: 000000000001fdc8
> > [15884.107720]  </TASK>
> > [15884.107726] task:cc1             state:D stack:0     pid:29450 ppid:29448  flags:0x00000002
> > [15884.107729] Call Trace:
> > [15884.107731]  <TASK>
> > [15884.107732]  __schedule+0x3ee/0x14c0
> > [15884.107738]  schedule+0x5e/0xd0
> > [15884.107741]  io_schedule+0x46/0x70
> > [15884.107744]  folio_wait_bit_common+0x13d/0x350
> > [15884.107749]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.107755]  filemap_get_pages+0x5fb/0x630
> > [15884.107759]  ? get_page_from_freelist+0x1630/0x1770
> > [15884.107764]  ? filename_lookup+0xe8/0x1f0
> > [15884.107770]  filemap_read+0xd9/0x350
> > [15884.107777]  vfs_read+0x201/0x350
> > [15884.107783]  ksys_read+0x6f/0xf0
> > [15884.107788]  do_syscall_64+0x60/0x90
> > [15884.107792]  ? __count_memcg_events+0x42/0x90
> > [15884.107796]  ? count_memcg_events.constprop.0+0x1a/0x30
> > [15884.107801]  ? handle_mm_fault+0x9e/0x350
> > [15884.107805]  ? do_user_addr_fault+0x179/0x640
> > [15884.107810]  ? exc_page_fault+0x7f/0x180
> > [15884.107814]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.107819] RIP: 0033:0x7fc938908381
> > [15884.107831] RSP: 002b:00007ffee7467d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.107834] RAX: ffffffffffffffda RBX: 00000000031e7ff0 RCX: 00007fc938908381
> > [15884.107837] RDX: 0000000000001b8f RSI: 00000000032659c0 RDI: 0000000000000006
> > [15884.107839] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.107841] R10: 0000000000000004 R11: 0000000000000246 R12: 00000000031d3ae0
> > [15884.107842] R13: 0000000000000000 R14: 00000000032659c0 R15: 0000000000001b8f
> > [15884.107847]  </TASK>
> > [15884.107849] task:cc1             state:D stack:0     pid:29451 ppid:29449  flags:0x00000002
> > [15884.107853] Call Trace:
> > [15884.107854]  <TASK>
> > [15884.107856]  __schedule+0x3ee/0x14c0
> > [15884.107862]  schedule+0x5e/0xd0
> > [15884.107865]  io_schedule+0x46/0x70
> > [15884.107868]  folio_wait_bit_common+0x13d/0x350
> > [15884.107872]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.107878]  filemap_get_pages+0x5fb/0x630
> > [15884.107882]  ? terminate_walk+0x61/0x100
> > [15884.107888]  filemap_read+0xd9/0x350
> > [15884.107892]  ? __alloc_pages+0xe0/0x350
> > [15884.107898]  vfs_read+0x201/0x350
> > [15884.107904]  ksys_read+0x6f/0xf0
> > [15884.107909]  do_syscall_64+0x60/0x90
> > [15884.107912]  ? __count_memcg_events+0x42/0x90
> > [15884.107916]  ? count_memcg_events.constprop.0+0x1a/0x30
> > [15884.107921]  ? handle_mm_fault+0x9e/0x350
> > [15884.107925]  ? do_user_addr_fault+0x179/0x640
> > [15884.107930]  ? exc_page_fault+0x7f/0x180
> > [15884.107934]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.107939] RIP: 0033:0x7f8284f08381
> > [15884.107945] RSP: 002b:00007ffcb2d353d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.107949] RAX: ffffffffffffffda RBX: 000000000313b770 RCX: 00007f8284f08381
> > [15884.107951] RDX: 000000000001fdc8 RSI: 00000000031b5d40 RDI: 0000000000000006
> > [15884.107953] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.107955] R10: 00000000031b5d30 R11: 0000000000000246 R12: 0000000003126ae0
> > [15884.107957] R13: 0000000000000000 R14: 00000000031b5d40 R15: 000000000001fdc8
> > [15884.107962]  </TASK>
> > [15884.107964] task:ar              state:D stack:0     pid:29480 ppid:29475  flags:0x00004002
> > [15884.107968] Call Trace:
> > [15884.107970]  <TASK>
> > [15884.107972]  __schedule+0x3ee/0x14c0
> > [15884.107976]  ? md_handle_request+0x19a/0x220
> > [15884.107981]  schedule+0x5e/0xd0
> > [15884.107984]  md_super_wait+0xa2/0xe0
> > [15884.107988]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [15884.107992]  md_bitmap_unplug+0xd2/0x120
> > [15884.107996]  flush_bio_list+0xf3/0x100 [raid1]
> > [15884.108006]  raid1_unplug+0x3b/0xb0 [raid1]
> > [15884.108015]  __blk_flush_plug+0xd7/0x150
> > [15884.108020]  blk_finish_plug+0x29/0x40
> > [15884.108024]  ext4_do_writepages+0x401/0xc90
> > [15884.108031]  ext4_writepages+0xad/0x180
> > [15884.108037]  do_writepages+0xd2/0x1e0
> > [15884.108041]  ? vfs_read+0x201/0x350
> > [15884.108046]  filemap_fdatawrite_wbc+0x63/0x90
> > [15884.108052]  __filemap_fdatawrite_range+0x5c/0x80
> > [15884.108057]  ext4_release_file+0x74/0xb0
> > [15884.108062]  __fput+0xf5/0x2a0
> > [15884.108066]  task_work_run+0x5d/0x90
> > [15884.108072]  exit_to_user_mode_prepare+0x1e6/0x1f0
> > [15884.108076]  syscall_exit_to_user_mode+0x1b/0x40
> > [15884.108080]  do_syscall_64+0x6c/0x90
> > [15884.108083]  ? do_syscall_64+0x6c/0x90
> > [15884.108086]  ? do_syscall_64+0x6c/0x90
> > [15884.108090]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.108094] RIP: 0033:0x7fc5c81037b4
> > [15884.108101] RSP: 002b:00007ffc93a5d078 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> > [15884.108104] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fc5c81037b4
> > [15884.108106] RDX: 0000000000002000 RSI: 00007ffc93a5d090 RDI: 0000000000000003
> > [15884.108108] RBP: 00007ffc93a5f0d0 R08: 000055debdb6a780 R09: 0000000000000001
> > [15884.108111] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fc5c82efb08
> > [15884.108113] R13: 0000000000000022 R14: 0000000000000003 R15: 0000000000000000
> > [15884.108117]  </TASK>
> > [15884.108121] task:cc1             state:D stack:0     pid:29488 ppid:29487  flags:0x00000002
> > [15884.108125] Call Trace:
> > [15884.108126]  <TASK>
> > [15884.108128]  __schedule+0x3ee/0x14c0
> > [15884.108132]  ? __alloc_pages+0x1a3/0x350
> > [15884.108137]  schedule+0x5e/0xd0
> > [15884.108140]  io_schedule+0x46/0x70
> > [15884.108143]  folio_wait_bit_common+0x13d/0x350
> > [15884.108147]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.108153]  filemap_get_pages+0x5fb/0x630
> > [15884.108160]  filemap_read+0xd9/0x350
> > [15884.108164]  ? __alloc_pages+0xe0/0x350
> > [15884.108169]  vfs_read+0x201/0x350
> > [15884.108176]  ksys_read+0x6f/0xf0
> > [15884.108181]  do_syscall_64+0x60/0x90
> > [15884.108184]  ? count_memcg_events.constprop.0+0x1a/0x30
> > [15884.108189]  ? handle_mm_fault+0x9e/0x350
> > [15884.108193]  ? do_user_addr_fault+0x179/0x640
> > [15884.108198]  ? exc_page_fault+0x7f/0x180
> > [15884.108202]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.108207] RIP: 0033:0x7f8cf3308381
> > [15884.108213] RSP: 002b:00007ffcd7e94738 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.108216] RAX: ffffffffffffffda RBX: 00000000025af240 RCX: 00007f8cf3308381
> > [15884.108219] RDX: 000000000001fdc8 RSI: 0000000002690910 RDI: 0000000000000006
> > [15884.108221] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.108222] R10: 0000000002690900 R11: 0000000000000246 R12: 00000000024f4ae0
> > [15884.108224] R13: 0000000000000000 R14: 0000000002690910 R15: 000000000001fdc8
> > [15884.108229]  </TASK>
> > [15884.108234] task:cc1             state:D stack:0     pid:29493 ppid:29492  flags:0x00000002
> > [15884.108237] Call Trace:
> > [15884.108239]  <TASK>
> > [15884.108241]  __schedule+0x3ee/0x14c0
> > [15884.108246]  schedule+0x5e/0xd0
> > [15884.108249]  io_schedule+0x46/0x70
> > [15884.108252]  folio_wait_bit_common+0x13d/0x350
> > [15884.108257]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.108262]  filemap_get_pages+0x5fb/0x630
> > [15884.108267]  ? path_init+0x38f/0x3c0
> > [15884.108272]  filemap_read+0xd9/0x350
> > [15884.108276]  ? __alloc_pages+0xe0/0x350
> > [15884.108282]  vfs_read+0x201/0x350
> > [15884.108289]  ksys_read+0x6f/0xf0
> > [15884.108293]  do_syscall_64+0x60/0x90
> > [15884.108297]  ? count_memcg_events.constprop.0+0x1a/0x30
> > [15884.108302]  ? handle_mm_fault+0x9e/0x350
> > [15884.108306]  ? do_user_addr_fault+0x179/0x640
> > [15884.108311]  ? exc_page_fault+0x7f/0x180
> > [15884.108315]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.108320] RIP: 0033:0x7f12a9908381
> > [15884.108326] RSP: 002b:00007ffcc9100bb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.108330] RAX: ffffffffffffffda RBX: 0000000003831de0 RCX: 00007f12a9908381
> > [15884.108332] RDX: 000000000001fdc8 RSI: 00000000038caf60 RDI: 0000000000000006
> > [15884.108334] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.108336] R10: 00000000038caf50 R11: 0000000000000246 R12: 0000000003722ae0
> > [15884.108338] R13: 0000000000000000 R14: 00000000038caf60 R15: 000000000001fdc8
> > [15884.108342]  </TASK>
> > [15884.108345] task:cc1             state:D stack:0     pid:29495 ppid:29494  flags:0x00000002
> > [15884.108349] Call Trace:
> > [15884.108350]  <TASK>
> > [15884.108352]  __schedule+0x3ee/0x14c0
> > [15884.108356]  ? __rmqueue_pcplist+0xda/0xb80
> > [15884.108361]  ? avc_has_perm_noaudit+0x6b/0xf0
> > [15884.108366]  schedule+0x5e/0xd0
> > [15884.108369]  io_schedule+0x46/0x70
> > [15884.108373]  folio_wait_bit_common+0x13d/0x350
> > [15884.108377]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.108383]  filemap_get_pages+0x5fb/0x630
> > [15884.108388]  ? __alloc_pages+0xe0/0x350
> > [15884.108391]  filemap_read+0xd9/0x350
> > [15884.108395]  ? __mod_memcg_lruvec_state+0x4e/0xa0
> > [15884.108399]  ? __mod_lruvec_page_state+0x99/0x140
> > [15884.108405]  vfs_read+0x201/0x350
> > [15884.108411]  ksys_read+0x6f/0xf0
> > [15884.108416]  do_syscall_64+0x60/0x90
> > [15884.108420]  ? exc_page_fault+0x7f/0x180
> > [15884.108424]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.108429] RIP: 0033:0x7f61bdb08381
> > [15884.108435] RSP: 002b:00007ffd12a64ca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.108438] RAX: ffffffffffffffda RBX: 0000000003c67e10 RCX: 00007f61bdb08381
> > [15884.108440] RDX: 000000000001fdc8 RSI: 0000000003d43be0 RDI: 0000000000000006
> > [15884.108442] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.108444] R10: 0000000003d43bd0 R11: 0000000000000246 R12: 0000000003ba3ae0
> > [15884.108446] R13: 0000000000000000 R14: 0000000003d43be0 R15: 000000000001fdc8
> > [15884.108451]  </TASK>
> > [15884.108453] task:ccache          state:D stack:0     pid:29496 ppid:23240  flags:0x00000002
> > [15884.108457] Call Trace:
> > [15884.108458]  <TASK>
> > [15884.108460]  __schedule+0x3ee/0x14c0
> > [15884.108466]  schedule+0x5e/0xd0
> > [15884.108469]  io_schedule+0x46/0x70
> > [15884.108472]  folio_wait_bit_common+0x13d/0x350
> > [15884.108476]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.108482]  filemap_get_pages+0x5fb/0x630
> > [15884.108488]  filemap_read+0xd9/0x350
> > [15884.108495]  vfs_read+0x201/0x350
> > [15884.108502]  ksys_read+0x6f/0xf0
> > [15884.108506]  do_syscall_64+0x60/0x90
> > [15884.108510]  ? kmem_cache_free+0x22/0x3a0
> > [15884.108514]  ? do_sys_openat2+0x97/0xe0
> > [15884.108518]  ? alloc_fd+0xb5/0x170
> > [15884.108523]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.108527]  ? do_syscall_64+0x6c/0x90
> > [15884.108530]  ? exc_page_fault+0x7f/0x180
> > [15884.108534]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.108538] RIP: 0033:0x7f09eef08381
> > [15884.108545] RSP: 002b:00007ffcfb6b5148 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.108548] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f09eef08381
> > [15884.108550] RDX: 0000000000001000 RSI: 000055d7c7de6180 RDI: 0000000000000004
> > [15884.108552] RBP: 00007ffcfb6b7670 R08: 0000000000000000 R09: 0000000000000001
> > [15884.108554] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000001000
> > [15884.108556] R13: 00007ffcfb6b5640 R14: 00007ffcfb6b6690 R15: 00007ffcfb6b5770
> > [15884.108561]  </TASK>
> > [15884.108563] task:ccache          state:D stack:0     pid:29499 ppid:23240  flags:0x00000002
> > [15884.108567] Call Trace:
> > [15884.108568]  <TASK>
> > [15884.108570]  __schedule+0x3ee/0x14c0
> > [15884.108576]  schedule+0x5e/0xd0
> > [15884.108579]  io_schedule+0x46/0x70
> > [15884.108582]  folio_wait_bit_common+0x13d/0x350
> > [15884.108587]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.108592]  filemap_get_pages+0x5fb/0x630
> > [15884.108597]  ? terminate_walk+0x61/0x100
> > [15884.108602]  filemap_read+0xd9/0x350
> > [15884.108609]  vfs_read+0x201/0x350
> > [15884.108616]  ksys_read+0x6f/0xf0
> > [15884.108621]  do_syscall_64+0x60/0x90
> > [15884.108624]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.108628]  ? do_syscall_64+0x6c/0x90
> > [15884.108631]  ? exc_page_fault+0x7f/0x180
> > [15884.108635]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.108639] RIP: 0033:0x7fd2bb308381
> > [15884.108645] RSP: 002b:00007ffddec9b6f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.108649] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd2bb308381
> > [15884.108651] RDX: 0000000000001000 RSI: 000055baf27ca180 RDI: 0000000000000004
> > [15884.108653] RBP: 00007ffddec9dc20 R08: 0000000000000000 R09: 0000000000000001
> > [15884.108655] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000001000
> > [15884.108657] R13: 00007ffddec9bbf0 R14: 00007ffddec9cc40 R15: 00007ffddec9bd20
> > [15884.108662]  </TASK>
> > [15884.108665] task:cc1             state:D stack:0     pid:29502 ppid:29501  flags:0x00000002
> > [15884.108669] Call Trace:
> > [15884.108671]  <TASK>
> > [15884.108673]  __schedule+0x3ee/0x14c0
> > [15884.108676]  ? __rmqueue_pcplist+0xda/0xb80
> > [15884.108683]  schedule+0x5e/0xd0
> > [15884.108686]  io_schedule+0x46/0x70
> > [15884.108689]  folio_wait_bit_common+0x13d/0x350
> > [15884.108693]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.108699]  filemap_get_pages+0x5fb/0x630
> > [15884.108704]  ? __alloc_pages+0xe0/0x350
> > [15884.108708]  filemap_read+0xd9/0x350
> > [15884.108712]  ? folio_add_new_anon_rmap+0x48/0xe0
> > [15884.108719]  vfs_read+0x201/0x350
> > [15884.108726]  ksys_read+0x6f/0xf0
> > [15884.108731]  do_syscall_64+0x60/0x90
> > [15884.108734]  ? exc_page_fault+0x7f/0x180
> > [15884.108737]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.108742] RIP: 0033:0x7ff2fbd08381
> > [15884.108748] RSP: 002b:00007ffc28475c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.108751] RAX: ffffffffffffffda RBX: 0000000003452770 RCX: 00007ff2fbd08381
> > [15884.108754] RDX: 000000000001fdc8 RSI: 00000000034d5410 RDI: 0000000000000006
> > [15884.108755] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.108757] R10: 00000000034d5400 R11: 0000000000000246 R12: 000000000343dae0
> > [15884.108759] R13: 0000000000000000 R14: 00000000034d5410 R15: 000000000001fdc8
> > [15884.108764]  </TASK>
> > [15884.108768] task:cc1             state:D stack:0     pid:29510 ppid:29509  flags:0x00000002
> > [15884.108771] Call Trace:
> > [15884.108773]  <TASK>
> > [15884.108775]  __schedule+0x3ee/0x14c0
> > [15884.108781]  schedule+0x5e/0xd0
> > [15884.108784]  io_schedule+0x46/0x70
> > [15884.108787]  folio_wait_bit_common+0x13d/0x350
> > [15884.108791]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.108797]  filemap_get_pages+0x5fb/0x630
> > [15884.108802]  ? generic_fillattr+0x49/0x100
> > [15884.108805]  ? _copy_to_user+0x24/0x40
> > [15884.108811]  filemap_read+0xd9/0x350
> > [15884.108818]  vfs_read+0x201/0x350
> > [15884.108831]  ksys_read+0x6f/0xf0
> > [15884.108836]  do_syscall_64+0x60/0x90
> > [15884.108839]  ? exc_page_fault+0x7f/0x180
> > [15884.108843]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.108848] RIP: 0033:0x7f67cb108381
> > [15884.108854] RSP: 002b:00007ffc29bc22b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.108858] RAX: ffffffffffffffda RBX: 0000000003b58210 RCX: 00007f67cb108381
> > [15884.108860] RDX: 000000000001fdc8 RSI: 0000000003c1f070 RDI: 0000000000000006
> > [15884.108862] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.108864] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000003ab0ae0
> > [15884.108866] R13: 0000000000000000 R14: 0000000003c1f070 R15: 000000000001fdc8
> > [15884.108870]  </TASK>
> > [15884.108874] task:cc1             state:D stack:0     pid:29513 ppid:29512  flags:0x00000002
> > [15884.108878] Call Trace:
> > [15884.108879]  <TASK>
> > [15884.108881]  __schedule+0x3ee/0x14c0
> > [15884.108887]  schedule+0x5e/0xd0
> > [15884.108890]  io_schedule+0x46/0x70
> > [15884.108894]  folio_wait_bit_common+0x13d/0x350
> > [15884.108898]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.108904]  filemap_get_pages+0x5fb/0x630
> > [15884.108909]  ? avc_has_perm+0x5f/0xe0
> > [15884.108914]  filemap_read+0xd9/0x350
> > [15884.108918]  ? _copy_to_user+0x24/0x40
> > [15884.108922]  ? cp_new_stat+0x135/0x170
> > [15884.108928]  vfs_read+0x201/0x350
> > [15884.108934]  ksys_read+0x6f/0xf0
> > [15884.108939]  do_syscall_64+0x60/0x90
> > [15884.108942]  ? do_user_addr_fault+0x179/0x640
> > [15884.108947]  ? exc_page_fault+0x7f/0x180
> > [15884.108951]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.108956] RIP: 0033:0x7f0509508381
> > [15884.108962] RSP: 002b:00007ffd8d920fd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.108965] RAX: ffffffffffffffda RBX: 0000000003f59b10 RCX: 00007f0509508381
> > [15884.108968] RDX: 000000000001fdc8 RSI: 0000000004020970 RDI: 0000000000000006
> > [15884.108970] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.108971] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000003eb1ae0
> > [15884.108974] R13: 0000000000000000 R14: 0000000004020970 R15: 000000000001fdc8
> > [15884.108978]  </TASK>
> > [15884.108981] task:ar              state:D stack:0     pid:29516 ppid:29514  flags:0x00004002
> > [15884.108985] Call Trace:
> > [15884.108987]  <TASK>
> > [15884.108989]  __schedule+0x3ee/0x14c0
> > [15884.108993]  ? md_handle_request+0x19a/0x220
> > [15884.108998]  schedule+0x5e/0xd0
> > [15884.109001]  md_super_wait+0xa2/0xe0
> > [15884.109005]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [15884.109009]  md_bitmap_unplug+0xd2/0x120
> > [15884.109013]  flush_bio_list+0xf3/0x100 [raid1]
> > [15884.109022]  raid1_unplug+0x3b/0xb0 [raid1]
> > [15884.109031]  __blk_flush_plug+0xd7/0x150
> > [15884.109036]  blk_finish_plug+0x29/0x40
> > [15884.109040]  ext4_do_writepages+0x401/0xc90
> > [15884.109047]  ext4_writepages+0xad/0x180
> > [15884.109053]  do_writepages+0xd2/0x1e0
> > [15884.109059]  filemap_fdatawrite_wbc+0x63/0x90
> > [15884.109064]  __filemap_fdatawrite_range+0x5c/0x80
> > [15884.109069]  ext4_release_file+0x74/0xb0
> > [15884.109073]  __fput+0xf5/0x2a0
> > [15884.109077]  task_work_run+0x5d/0x90
> > [15884.109082]  exit_to_user_mode_prepare+0x1e6/0x1f0
> > [15884.109085]  syscall_exit_to_user_mode+0x1b/0x40
> > [15884.109089]  do_syscall_64+0x6c/0x90
> > [15884.109093]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.109097]  ? do_syscall_64+0x6c/0x90
> > [15884.109100]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.109105] RIP: 0033:0x7f43c9d037b4
> > [15884.109111] RSP: 002b:00007ffd4ead7c88 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> > [15884.109114] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f43c9d037b4
> > [15884.109116] RDX: 0000000000002000 RSI: 00007ffd4ead7ca0 RDI: 0000000000000003
> > [15884.109119] RBP: 00007ffd4ead9ce0 R08: 00005600127ef780 R09: 0000000000000001
> > [15884.109121] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f43c9f5bb08
> > [15884.109123] R13: 0000000000000009 R14: 0000000000000003 R15: 0000000000000000
> > [15884.109127]  </TASK>
> > [15884.109131] task:cc1             state:D stack:0     pid:29519 ppid:29518  flags:0x00000002
> > [15884.109135] Call Trace:
> > [15884.109136]  <TASK>
> > [15884.109138]  __schedule+0x3ee/0x14c0
> > [15884.109141]  ? __rmqueue_pcplist+0xda/0xb80
> > [15884.109148]  schedule+0x5e/0xd0
> > [15884.109151]  io_schedule+0x46/0x70
> > [15884.109154]  folio_wait_bit_common+0x13d/0x350
> > [15884.109159]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.109164]  filemap_get_pages+0x5fb/0x630
> > [15884.109169]  ? __alloc_pages+0xe0/0x350
> > [15884.109173]  filemap_read+0xd9/0x350
> > [15884.109180]  vfs_read+0x201/0x350
> > [15884.109186]  ksys_read+0x6f/0xf0
> > [15884.109191]  do_syscall_64+0x60/0x90
> > [15884.109195]  ? exc_page_fault+0x7f/0x180
> > [15884.109199]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.109203] RIP: 0033:0x7fa065d08381
> > [15884.109209] RSP: 002b:00007ffd4feb9188 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.109212] RAX: ffffffffffffffda RBX: 00000000038045e0 RCX: 00007fa065d08381
> > [15884.109215] RDX: 000000000001fdc8 RSI: 0000000003893310 RDI: 0000000000000006
> > [15884.109217] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.109219] R10: 0000000003893300 R11: 0000000000000246 R12: 00000000037f2ae0
> > [15884.109221] R13: 0000000000000000 R14: 0000000003893310 R15: 000000000001fdc8
> > [15884.109226]  </TASK>
> > [15884.109229] task:cc1             state:D stack:0     pid:29524 ppid:29523  flags:0x00000002
> > [15884.109233] Call Trace:
> > [15884.109234]  <TASK>
> > [15884.109236]  __schedule+0x3ee/0x14c0
> > [15884.109241]  ? __alloc_pages+0x1a3/0x350
> > [15884.109245]  schedule+0x5e/0xd0
> > [15884.109248]  io_schedule+0x46/0x70
> > [15884.109251]  folio_wait_bit_common+0x13d/0x350
> > [15884.109256]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.109261]  filemap_get_pages+0x5fb/0x630
> > [15884.109268]  filemap_read+0xd9/0x350
> > [15884.109275]  vfs_read+0x201/0x350
> > [15884.109281]  ksys_read+0x6f/0xf0
> > [15884.109286]  do_syscall_64+0x60/0x90
> > [15884.109289]  ? handle_mm_fault+0x9e/0x350
> > [15884.109294]  ? do_user_addr_fault+0x179/0x640
> > [15884.109299]  ? exc_page_fault+0x7f/0x180
> > [15884.109303]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.109307] RIP: 0033:0x7f20f8f08381
> > [15884.109313] RSP: 002b:00007ffd98dcab58 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.109317] RAX: ffffffffffffffda RBX: 00000000042c7950 RCX: 00007f20f8f08381
> > [15884.109319] RDX: 000000000001fdc8 RSI: 000000000433a250 RDI: 0000000000000006
> > [15884.109321] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.109323] R10: 000000000433a240 R11: 0000000000000246 R12: 000000000419cae0
> > [15884.109325] R13: 0000000000000000 R14: 000000000433a250 R15: 000000000001fdc8
> > [15884.109330]  </TASK>
> > [15884.109333] task:cc1             state:D stack:0     pid:29531 ppid:29530  flags:0x00000002
> > [15884.109337] Call Trace:
> > [15884.109339]  <TASK>
> > [15884.109341]  __schedule+0x3ee/0x14c0
> > [15884.109346]  schedule+0x5e/0xd0
> > [15884.109349]  io_schedule+0x46/0x70
> > [15884.109352]  folio_wait_bit_common+0x13d/0x350
> > [15884.109357]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.109362]  filemap_get_pages+0x5fb/0x630
> > [15884.109367]  ? __alloc_pages+0xe0/0x350
> > [15884.109371]  filemap_read+0xd9/0x350
> > [15884.109375]  ? folio_add_new_anon_rmap+0x48/0xe0
> > [15884.109382]  vfs_read+0x201/0x350
> > [15884.109388]  ksys_read+0x6f/0xf0
> > [15884.109393]  do_syscall_64+0x60/0x90
> > [15884.109397]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.109402] RIP: 0033:0x7ffa93308381
> > [15884.109408] RSP: 002b:00007ffcff8dcba8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.109411] RAX: ffffffffffffffda RBX: 000000000262c5e0 RCX: 00007ffa93308381
> > [15884.109413] RDX: 000000000001fdc8 RSI: 00000000026b5560 RDI: 0000000000000006
> > [15884.109415] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.109417] R10: 00000000026b5550 R11: 0000000000000246 R12: 000000000261aae0
> > [15884.109420] R13: 0000000000000000 R14: 00000000026b5560 R15: 000000000001fdc8
> > [15884.109424]  </TASK>
> > [15884.109427] task:ar              state:D stack:0     pid:29534 ppid:29532  flags:0x00004002
> > [15884.109431] Call Trace:
> > [15884.109432]  <TASK>
> > [15884.109434]  __schedule+0x3ee/0x14c0
> > [15884.109439]  ? md_handle_request+0x19a/0x220
> > [15884.109444]  schedule+0x5e/0xd0
> > [15884.109447]  md_super_wait+0xa2/0xe0
> > [15884.109451]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [15884.109455]  md_bitmap_unplug+0xd2/0x120
> > [15884.109459]  flush_bio_list+0xf3/0x100 [raid1]
> > [15884.109468]  raid1_unplug+0x3b/0xb0 [raid1]
> > [15884.109476]  __blk_flush_plug+0xd7/0x150
> > [15884.109482]  blk_finish_plug+0x29/0x40
> > [15884.109486]  ext4_do_writepages+0x401/0xc90
> > [15884.109493]  ext4_writepages+0xad/0x180
> > [15884.109499]  do_writepages+0xd2/0x1e0
> > [15884.109503]  ? xa_load+0x8c/0xe0
> > [15884.109507]  filemap_fdatawrite_wbc+0x63/0x90
> > [15884.109513]  __filemap_fdatawrite_range+0x5c/0x80
> > [15884.109518]  ext4_release_file+0x74/0xb0
> > [15884.109522]  __fput+0xf5/0x2a0
> > [15884.109525]  task_work_run+0x5d/0x90
> > [15884.109530]  exit_to_user_mode_prepare+0x1e6/0x1f0
> > [15884.109534]  syscall_exit_to_user_mode+0x1b/0x40
> > [15884.109538]  do_syscall_64+0x6c/0x90
> > [15884.109542]  ? ksys_write+0x6f/0xf0
> > [15884.109547]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.109550]  ? do_syscall_64+0x6c/0x90
> > [15884.109554]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.109557]  ? do_syscall_64+0x6c/0x90
> > [15884.109560]  ? do_syscall_64+0x6c/0x90
> > [15884.109563]  ? do_syscall_64+0x6c/0x90
> > [15884.109566]  ? do_syscall_64+0x6c/0x90
> > [15884.109569]  ? do_syscall_64+0x6c/0x90
> > [15884.109572]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.109577] RIP: 0033:0x7fa6f1f037b4
> > [15884.109583] RSP: 002b:00007ffe1f4178f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> > [15884.109586] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fa6f1f037b4
> > [15884.109588] RDX: 0000000000002000 RSI: 00007ffe1f417910 RDI: 0000000000000003
> > [15884.109590] RBP: 00007ffe1f419950 R08: 000055aac07c1780 R09: 0000000000000001
> > [15884.109593] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fa6f21c6b08
> > [15884.109594] R13: 000000000000000d R14: 0000000000000003 R15: 0000000000000000
> > [15884.109599]  </TASK>
> > [15884.109602] task:ar              state:D stack:0     pid:29538 ppid:29536  flags:0x00004002
> > [15884.109606] Call Trace:
> > [15884.109607]  <TASK>
> > [15884.109609]  __schedule+0x3ee/0x14c0
> > [15884.109613]  ? md_handle_request+0x19a/0x220
> > [15884.109618]  schedule+0x5e/0xd0
> > [15884.109621]  md_super_wait+0xa2/0xe0
> > [15884.109625]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [15884.109629]  md_bitmap_unplug+0xd2/0x120
> > [15884.109633]  flush_bio_list+0xf3/0x100 [raid1]
> > [15884.109642]  raid1_unplug+0x3b/0xb0 [raid1]
> > [15884.109651]  __blk_flush_plug+0xd7/0x150
> > [15884.109656]  blk_finish_plug+0x29/0x40
> > [15884.109660]  ext4_do_writepages+0x401/0xc90
> > [15884.109667]  ext4_writepages+0xad/0x180
> > [15884.109673]  do_writepages+0xd2/0x1e0
> > [15884.109678]  filemap_fdatawrite_wbc+0x63/0x90
> > [15884.109683]  __filemap_fdatawrite_range+0x5c/0x80
> > [15884.109688]  ext4_release_file+0x74/0xb0
> > [15884.109692]  __fput+0xf5/0x2a0
> > [15884.109696]  task_work_run+0x5d/0x90
> > [15884.109701]  exit_to_user_mode_prepare+0x1e6/0x1f0
> > [15884.109704]  syscall_exit_to_user_mode+0x1b/0x40
> > [15884.109708]  do_syscall_64+0x6c/0x90
> > [15884.109712]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.109716]  ? do_syscall_64+0x6c/0x90
> > [15884.109719]  ? do_syscall_64+0x6c/0x90
> > [15884.109721]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.109725]  ? do_syscall_64+0x6c/0x90
> > [15884.109728]  ? do_syscall_64+0x6c/0x90
> > [15884.109731]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.109736] RIP: 0033:0x7f41c05037b4
> > [15884.109742] RSP: 002b:00007ffc37ebd7f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> > [15884.109746] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f41c05037b4
> > [15884.109748] RDX: 0000000000002000 RSI: 00007ffc37ebd810 RDI: 0000000000000003
> > [15884.109750] RBP: 00007ffc37ebf850 R08: 00005620ae82e780 R09: 0000000000000001
> > [15884.109752] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f41c077ab08
> > [15884.109754] R13: 000000000000000d R14: 0000000000000003 R15: 0000000000000000
> > [15884.109758]  </TASK>
> > [15884.109761] task:ar              state:D stack:0     pid:29543 ppid:29541  flags:0x00004002
> > [15884.109765] Call Trace:
> > [15884.109766]  <TASK>
> > [15884.109768]  __schedule+0x3ee/0x14c0
> > [15884.109772]  ? md_handle_request+0x19a/0x220
> > [15884.109777]  schedule+0x5e/0xd0
> > [15884.109781]  md_super_wait+0xa2/0xe0
> > [15884.109784]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [15884.109789]  md_bitmap_unplug+0xd2/0x120
> > [15884.109792]  flush_bio_list+0xf3/0x100 [raid1]
> > [15884.109801]  raid1_unplug+0x3b/0xb0 [raid1]
> > [15884.109810]  __blk_flush_plug+0xd7/0x150
> > [15884.109816]  blk_finish_plug+0x29/0x40
> > [15884.109820]  ext4_do_writepages+0x401/0xc90
> > [15884.109831]  ext4_writepages+0xad/0x180
> > [15884.109837]  do_writepages+0xd2/0x1e0
> > [15884.109842]  ? touch_atime+0x48/0x1b0
> > [15884.109846]  ? xa_load+0x8c/0xe0
> > [15884.109850]  filemap_fdatawrite_wbc+0x63/0x90
> > [15884.109855]  __filemap_fdatawrite_range+0x5c/0x80
> > [15884.109860]  ext4_release_file+0x74/0xb0
> > [15884.109864]  __fput+0xf5/0x2a0
> > [15884.109868]  task_work_run+0x5d/0x90
> > [15884.109873]  exit_to_user_mode_prepare+0x1e6/0x1f0
> > [15884.109876]  syscall_exit_to_user_mode+0x1b/0x40
> > [15884.109880]  do_syscall_64+0x6c/0x90
> > [15884.109885]  ? ksys_read+0x6f/0xf0
> > [15884.109889]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.109893]  ? do_syscall_64+0x6c/0x90
> > [15884.109897]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.109901] RIP: 0033:0x7fbc449037b4
> > [15884.109908] RSP: 002b:00007fffc47456c8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> > [15884.109912] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fbc449037b4
> > [15884.109914] RDX: 0000000000002000 RSI: 00007fffc47456e0 RDI: 0000000000000003
> > [15884.109916] RBP: 00007fffc4747720 R08: 000055a64012a780 R09: 0000000000000001
> > [15884.109918] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fbc44ac8b08
> > [15884.109920] R13: 000000000000000c R14: 0000000000000003 R15: 0000000000000000
> > [15884.109924]  </TASK>
> > [15884.109928] task:cc1             state:D stack:0     pid:29546 ppid:29545  flags:0x00000002
> > [15884.109932] Call Trace:
> > [15884.109933]  <TASK>
> > [15884.109935]  __schedule+0x3ee/0x14c0
> > [15884.109941]  schedule+0x5e/0xd0
> > [15884.109944]  io_schedule+0x46/0x70
> > [15884.109947]  folio_wait_bit_common+0x13d/0x350
> > [15884.109952]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.109957]  filemap_get_pages+0x5fb/0x630
> > [15884.109962]  ? get_page_from_freelist+0x1630/0x1770
> > [15884.109969]  filemap_read+0xd9/0x350
> > [15884.109975]  vfs_read+0x201/0x350
> > [15884.109982]  ksys_read+0x6f/0xf0
> > [15884.109987]  do_syscall_64+0x60/0x90
> > [15884.109991]  ? __count_memcg_events+0x42/0x90
> > [15884.109995]  ? count_memcg_events.constprop.0+0x1a/0x30
> > [15884.110000]  ? handle_mm_fault+0x9e/0x350
> > [15884.110004]  ? do_user_addr_fault+0x179/0x640
> > [15884.110009]  ? exc_page_fault+0x7f/0x180
> > [15884.110013]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.110018] RIP: 0033:0x7fe2bf508381
> > [15884.110024] RSP: 002b:00007ffe4b99d9f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.110027] RAX: ffffffffffffffda RBX: 0000000003da05e0 RCX: 00007fe2bf508381
> > [15884.110030] RDX: 000000000001fdc8 RSI: 0000000003e39760 RDI: 0000000000000006
> > [15884.110032] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.110034] R10: 0000000003e39750 R11: 0000000000000246 R12: 0000000003ca0ae0
> > [15884.110036] R13: 0000000000000000 R14: 0000000003e39760 R15: 000000000001fdc8
> > [15884.110040]  </TASK>
> > [15884.110044] task:cc1             state:D stack:0     pid:29549 ppid:29548  flags:0x00000002
> > [15884.110048] Call Trace:
> > [15884.110050]  <TASK>
> > [15884.110051]  __schedule+0x3ee/0x14c0
> > [15884.110057]  schedule+0x5e/0xd0
> > [15884.110060]  io_schedule+0x46/0x70
> > [15884.110064]  folio_wait_bit_common+0x13d/0x350
> > [15884.110068]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.110074]  filemap_get_pages+0x5fb/0x630
> > [15884.110080]  filemap_read+0xd9/0x350
> > [15884.110087]  vfs_read+0x201/0x350
> > [15884.110094]  ksys_read+0x6f/0xf0
> > [15884.110099]  do_syscall_64+0x60/0x90
> > [15884.110102]  ? do_user_addr_fault+0x179/0x640
> > [15884.110108]  ? exc_page_fault+0x7f/0x180
> > [15884.110111]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.110116] RIP: 0033:0x7f9bac908381
> > [15884.110122] RSP: 002b:00007fff56f186e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.110125] RAX: ffffffffffffffda RBX: 0000000003c4b770 RCX: 00007f9bac908381
> > [15884.110128] RDX: 000000000001fdc8 RSI: 0000000003cc30d0 RDI: 0000000000000006
> > [15884.110130] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.110132] R10: 0000000003cc30c0 R11: 0000000000000246 R12: 0000000003c36ae0
> > [15884.110134] R13: 0000000000000000 R14: 0000000003cc30d0 R15: 000000000001fdc8
> > [15884.110138]  </TASK>
> > [15884.110142] task:cc1             state:D stack:0     pid:29555 ppid:29554  flags:0x00000002
> > [15884.110145] Call Trace:
> > [15884.110147]  <TASK>
> > [15884.110149]  __schedule+0x3ee/0x14c0
> > [15884.110154]  schedule+0x5e/0xd0
> > [15884.110157]  io_schedule+0x46/0x70
> > [15884.110160]  folio_wait_bit_common+0x13d/0x350
> > [15884.110165]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.110170]  filemap_get_pages+0x5fb/0x630
> > [15884.110176]  ? path_init+0x38f/0x3c0
> > [15884.110181]  filemap_read+0xd9/0x350
> > [15884.110187]  vfs_read+0x201/0x350
> > [15884.110194]  ksys_read+0x6f/0xf0
> > [15884.110199]  do_syscall_64+0x60/0x90
> > [15884.110202]  ? __count_memcg_events+0x42/0x90
> > [15884.110206]  ? count_memcg_events.constprop.0+0x1a/0x30
> > [15884.110211]  ? handle_mm_fault+0x9e/0x350
> > [15884.110215]  ? do_user_addr_fault+0x179/0x640
> > [15884.110220]  ? exc_page_fault+0x7f/0x180
> > [15884.110224]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.110229] RIP: 0033:0x7faab7708381
> > [15884.110235] RSP: 002b:00007ffd6e3df0b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.110238] RAX: ffffffffffffffda RBX: 0000000003648a50 RCX: 00007faab7708381
> > [15884.110240] RDX: 000000000001fdc8 RSI: 00000000036bb350 RDI: 0000000000000006
> > [15884.110242] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.110244] R10: 00000000036bb340 R11: 0000000000000246 R12: 000000000351cae0
> > [15884.110246] R13: 0000000000000000 R14: 00000000036bb350 R15: 000000000001fdc8
> > [15884.110251]  </TASK>
> > [15884.110255] task:cc1             state:D stack:0     pid:29558 ppid:29557  flags:0x00000002
> > [15884.110258] Call Trace:
> > [15884.110260]  <TASK>
> > [15884.110262]  __schedule+0x3ee/0x14c0
> > [15884.110267]  schedule+0x5e/0xd0
> > [15884.110270]  io_schedule+0x46/0x70
> > [15884.110273]  folio_wait_bit_common+0x13d/0x350
> > [15884.110278]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.110283]  filemap_get_pages+0x5fb/0x630
> > [15884.110289]  ? terminate_walk+0x61/0x100
> > [15884.110293]  filemap_read+0xd9/0x350
> > [15884.110300]  vfs_read+0x201/0x350
> > [15884.110307]  ksys_read+0x6f/0xf0
> > [15884.110312]  do_syscall_64+0x60/0x90
> > [15884.110316]  ? __count_memcg_events+0x42/0x90
> > [15884.110319]  ? count_memcg_events.constprop.0+0x1a/0x30
> > [15884.110324]  ? handle_mm_fault+0x9e/0x350
> > [15884.110328]  ? do_user_addr_fault+0x179/0x640
> > [15884.110333]  ? exc_page_fault+0x7f/0x180
> > [15884.110337]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.110342] RIP: 0033:0x7feed7b08381
> > [15884.110348] RSP: 002b:00007ffc2a730778 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.110351] RAX: ffffffffffffffda RBX: 00000000037cc0e0 RCX: 00007feed7b08381
> > [15884.110353] RDX: 000000000001fdc8 RSI: 0000000003855760 RDI: 0000000000000006
> > [15884.110355] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.110357] R10: 0000000003855750 R11: 0000000000000246 R12: 000000000369eae0
> > [15884.110359] R13: 0000000000000000 R14: 0000000003855760 R15: 000000000001fdc8
> > [15884.110364]  </TASK>
> > [15884.110367] task:ar              state:D stack:0     pid:29562 ppid:29560  flags:0x00004002
> > [15884.110371] Call Trace:
> > [15884.110372]  <TASK>
> > [15884.110374]  __schedule+0x3ee/0x14c0
> > [15884.110378]  ? md_handle_request+0x19a/0x220
> > [15884.110383]  schedule+0x5e/0xd0
> > [15884.110387]  md_super_wait+0xa2/0xe0
> > [15884.110390]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [15884.110395]  md_bitmap_unplug+0xd2/0x120
> > [15884.110399]  flush_bio_list+0xf3/0x100 [raid1]
> > [15884.110408]  raid1_unplug+0x3b/0xb0 [raid1]
> > [15884.110417]  __blk_flush_plug+0xd7/0x150
> > [15884.110422]  blk_finish_plug+0x29/0x40
> > [15884.110426]  ext4_do_writepages+0x401/0xc90
> > [15884.110432]  ext4_writepages+0xad/0x180
> > [15884.110438]  do_writepages+0xd2/0x1e0
> > [15884.110444]  filemap_fdatawrite_wbc+0x63/0x90
> > [15884.110448]  __filemap_fdatawrite_range+0x5c/0x80
> > [15884.110454]  ext4_release_file+0x74/0xb0
> > [15884.110457]  __fput+0xf5/0x2a0
> > [15884.110461]  task_work_run+0x5d/0x90
> > [15884.110466]  exit_to_user_mode_prepare+0x1e6/0x1f0
> > [15884.110470]  syscall_exit_to_user_mode+0x1b/0x40
> > [15884.110474]  do_syscall_64+0x6c/0x90
> > [15884.110479]  ? exit_to_user_mode_prepare+0x188/0x1f0
> > [15884.110482]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.110486]  ? do_syscall_64+0x6c/0x90
> > [15884.110489]  ? do_syscall_64+0x6c/0x90
> > [15884.110493]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.110497] RIP: 0033:0x7f74a3f037b4
> > [15884.110504] RSP: 002b:00007ffd3d9808f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> > [15884.110507] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f74a3f037b4
> > [15884.110509] RDX: 0000000000002000 RSI: 00007ffd3d980910 RDI: 0000000000000003
> > [15884.110511] RBP: 00007ffd3d982950 R08: 0000555cbacb2780 R09: 0000000000000001
> > [15884.110513] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f74a410bb08
> > [15884.110515] R13: 000000000000000c R14: 0000000000000003 R15: 0000000000000000
> > [15884.110520]  </TASK>
> > [15884.110523] task:cc1             state:D stack:0     pid:29567 ppid:29566  flags:0x00000002
> > [15884.110527] Call Trace:
> > [15884.110528]  <TASK>
> > [15884.110530]  __schedule+0x3ee/0x14c0
> > [15884.110534]  ? __rmqueue_pcplist+0xda/0xb80
> > [15884.110540]  schedule+0x5e/0xd0
> > [15884.110544]  io_schedule+0x46/0x70
> > [15884.110547]  folio_wait_bit_common+0x13d/0x350
> > [15884.110551]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.110557]  filemap_get_pages+0x5fb/0x630
> > [15884.110562]  ? release_pages+0x177/0x510
> > [15884.110566]  filemap_read+0xd9/0x350
> > [15884.110570]  ? __pfx_lru_add_fn+0x10/0x10
> > [15884.110573]  ? folio_batch_move_lru+0xd3/0x150
> > [15884.110579]  vfs_read+0x201/0x350
> > [15884.110586]  ksys_read+0x6f/0xf0
> > [15884.110591]  do_syscall_64+0x60/0x90
> > [15884.110594]  ? exc_page_fault+0x7f/0x180
> > [15884.110598]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.110603] RIP: 0033:0x7fe197b08381
> > [15884.110609] RSP: 002b:00007ffdf102d6e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.110612] RAX: ffffffffffffffda RBX: 0000000003f78f30 RCX: 00007fe197b08381
> > [15884.110615] RDX: 000000000001fdc8 RSI: 0000000003feb830 RDI: 0000000000000006
> > [15884.110617] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.110619] R10: 0000000003feb820 R11: 0000000000000246 R12: 0000000003e43ae0
> > [15884.110621] R13: 0000000000000000 R14: 0000000003feb830 R15: 000000000001fdc8
> > [15884.110626]  </TASK>
> > [15884.110629] task:cc1             state:D stack:0     pid:29570 ppid:29569  flags:0x00000002
> > [15884.110633] Call Trace:
> > [15884.110634]  <TASK>
> > [15884.110636]  __schedule+0x3ee/0x14c0
> > [15884.110642]  schedule+0x5e/0xd0
> > [15884.110645]  io_schedule+0x46/0x70
> > [15884.110648]  folio_wait_bit_common+0x13d/0x350
> > [15884.110653]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.110658]  filemap_get_pages+0x5fb/0x630
> > [15884.110664]  ? generic_fillattr+0x49/0x100
> > [15884.110668]  filemap_read+0xd9/0x350
> > [15884.110674]  vfs_read+0x201/0x350
> > [15884.110680]  ksys_read+0x6f/0xf0
> > [15884.110685]  do_syscall_64+0x60/0x90
> > [15884.110689]  ? exc_page_fault+0x7f/0x180
> > [15884.110693]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.110697] RIP: 0033:0x7fa657508381
> > [15884.110703] RSP: 002b:00007fff0faea488 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.110707] RAX: ffffffffffffffda RBX: 00000000036b6ba0 RCX: 00007fa657508381
> > [15884.110709] RDX: 000000000001fdc8 RSI: 0000000003764340 RDI: 0000000000000006
> > [15884.110711] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.110713] R10: 0000000000000004 R11: 0000000000000246 R12: 00000000035daae0
> > [15884.110715] R13: 0000000000000000 R14: 0000000003764340 R15: 000000000001fdc8
> > [15884.110720]  </TASK>
> > [15884.110722] task:ccache          state:D stack:0     pid:29572 ppid:23240  flags:0x00000002
> > [15884.110725] Call Trace:
> > [15884.110727]  <TASK>
> > [15884.110729]  __schedule+0x3ee/0x14c0
> > [15884.110734]  schedule+0x5e/0xd0
> > [15884.110737]  io_schedule+0x46/0x70
> > [15884.110740]  folio_wait_bit_common+0x13d/0x350
> > [15884.110745]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.110750]  filemap_get_pages+0x5fb/0x630
> > [15884.110757]  filemap_read+0xd9/0x350
> > [15884.110764]  vfs_read+0x201/0x350
> > [15884.110770]  ksys_read+0x6f/0xf0
> > [15884.110775]  do_syscall_64+0x60/0x90
> > [15884.110778]  ? do_syscall_64+0x6c/0x90
> > [15884.110781]  ? __count_memcg_events+0x42/0x90
> > [15884.110785]  ? count_memcg_events.constprop.0+0x1a/0x30
> > [15884.110790]  ? handle_mm_fault+0x9e/0x350
> > [15884.110794]  ? do_user_addr_fault+0x225/0x640
> > [15884.110799]  ? exc_page_fault+0x7f/0x180
> > [15884.110803]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.110808] RIP: 0033:0x7f1e49508381
> > [15884.110814] RSP: 002b:00007fff99d73ad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.110817] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1e49508381
> > [15884.110820] RDX: 0000000000001000 RSI: 000055b5678f9140 RDI: 0000000000000004
> > [15884.110828] RBP: 00007fff99d76000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.110830] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000001000
> > [15884.110832] R13: 00007fff99d73fd0 R14: 00007fff99d75020 R15: 00007fff99d74100
> > [15884.110837]  </TASK>
> > [15884.110841] task:ar              state:D stack:0     pid:29579 ppid:29577  flags:0x00004002
> > [15884.110845] Call Trace:
> > [15884.110846]  <TASK>
> > [15884.110848]  __schedule+0x3ee/0x14c0
> > [15884.110852]  ? md_handle_request+0x19a/0x220
> > [15884.110857]  schedule+0x5e/0xd0
> > [15884.110860]  md_super_wait+0xa2/0xe0
> > [15884.110864]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [15884.110868]  md_bitmap_unplug+0xd2/0x120
> > [15884.110872]  flush_bio_list+0xf3/0x100 [raid1]
> > [15884.110881]  raid1_unplug+0x3b/0xb0 [raid1]
> > [15884.110890]  __blk_flush_plug+0xd7/0x150
> > [15884.110896]  blk_finish_plug+0x29/0x40
> > [15884.110900]  ext4_do_writepages+0x401/0xc90
> > [15884.110906]  ext4_writepages+0xad/0x180
> > [15884.110912]  do_writepages+0xd2/0x1e0
> > [15884.110917]  ? atime_needs_update+0xa0/0x120
> > [15884.110922]  filemap_fdatawrite_wbc+0x63/0x90
> > [15884.110927]  __filemap_fdatawrite_range+0x5c/0x80
> > [15884.110932]  ext4_release_file+0x74/0xb0
> > [15884.110936]  __fput+0xf5/0x2a0
> > [15884.110940]  task_work_run+0x5d/0x90
> > [15884.110945]  exit_to_user_mode_prepare+0x1e6/0x1f0
> > [15884.110949]  syscall_exit_to_user_mode+0x1b/0x40
> > [15884.110953]  do_syscall_64+0x6c/0x90
> > [15884.110956]  ? __rseq_handle_notify_resume+0xa9/0x4f0
> > [15884.110960]  ? kmem_cache_free+0x22/0x3a0
> > [15884.110964]  ? __call_rcu_common.constprop.0+0xe5/0x6c0
> > [15884.110969]  ? exit_to_user_mode_prepare+0x188/0x1f0
> > [15884.110972]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.110976]  ? do_syscall_64+0x6c/0x90
> > [15884.110979]  ? do_syscall_64+0x6c/0x90
> > [15884.110983]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.110987] RIP: 0033:0x7ffa139037b4
> > [15884.110994] RSP: 002b:00007fff88e7d288 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> > [15884.110997] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007ffa139037b4
> > [15884.110999] RDX: 0000000000002000 RSI: 00007fff88e7d2a0 RDI: 0000000000000003
> > [15884.111001] RBP: 00007fff88e7f2e0 R08: 00005631d3292780 R09: 0000000000000001
> > [15884.111003] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffa13b5ab08
> > [15884.111005] R13: 000000000000000d R14: 0000000000000003 R15: 0000000000000000
> > [15884.111010]  </TASK>
> > [15884.111013] task:cc1             state:D stack:0     pid:29582 ppid:29581  flags:0x00000002
> > [15884.111017] Call Trace:
> > [15884.111019]  <TASK>
> > [15884.111021]  __schedule+0x3ee/0x14c0
> > [15884.111024]  ? __filemap_get_folio+0x166/0x230
> > [15884.111030]  schedule+0x5e/0xd0
> > [15884.111033]  io_schedule+0x46/0x70
> > [15884.111036]  folio_wait_bit_common+0x13d/0x350
> > [15884.111041]  ? __pfx_wake_page_function+0x10/0x10
> > [15884.111046]  filemap_get_pages+0x5fb/0x630
> > [15884.111051]  ? filename_lookup+0xe8/0x1f0
> > [15884.111055]  ? avc_has_perm_noaudit+0x6b/0xf0
> > [15884.111060]  filemap_read+0xd9/0x350
> > [15884.111067]  vfs_read+0x201/0x350
> > [15884.111074]  ksys_read+0x6f/0xf0
> > [15884.111079]  do_syscall_64+0x60/0x90
> > [15884.111082]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.111086]  ? do_syscall_64+0x6c/0x90
> > [15884.111089]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.111093]  ? do_syscall_64+0x6c/0x90
> > [15884.111096]  ? exc_page_fault+0x7f/0x180
> > [15884.111100]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.111105] RIP: 0033:0x7f1bee108381
> > [15884.111111] RSP: 002b:00007ffd89f20808 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [15884.111114] RAX: ffffffffffffffda RBX: 00000000034e18a0 RCX: 00007f1bee108381
> > [15884.111117] RDX: 000000000001fdc8 RSI: 0000000003584eb0 RDI: 0000000000000006
> > [15884.111119] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000001
> > [15884.111121] R10: 0000000000000004 R11: 0000000000000246 R12: 00000000033ecae0
> > [15884.111123] R13: 0000000000000000 R14: 0000000003584eb0 R15: 000000000001fdc8
> > [15884.111128]  </TASK>
> > [15884.111131] task:ar              state:D stack:0     pid:29591 ppid:29589  flags:0x00004002
> > [15884.111134] Call Trace:
> > [15884.111136]  <TASK>
> > [15884.111138]  __schedule+0x3ee/0x14c0
> > [15884.111142]  ? md_handle_request+0x19a/0x220
> > [15884.111147]  schedule+0x5e/0xd0
> > [15884.111150]  md_super_wait+0xa2/0xe0
> > [15884.111154]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [15884.111158]  md_bitmap_unplug+0xd2/0x120
> > [15884.111162]  flush_bio_list+0xf3/0x100 [raid1]
> > [15884.111171]  raid1_unplug+0x3b/0xb0 [raid1]
> > [15884.111180]  __blk_flush_plug+0xd7/0x150
> > [15884.111185]  blk_finish_plug+0x29/0x40
> > [15884.111189]  ext4_do_writepages+0x401/0xc90
> > [15884.111196]  ext4_writepages+0xad/0x180
> > [15884.111202]  do_writepages+0xd2/0x1e0
> > [15884.111207]  filemap_fdatawrite_wbc+0x63/0x90
> > [15884.111212]  __filemap_fdatawrite_range+0x5c/0x80
> > [15884.111217]  ext4_release_file+0x74/0xb0
> > [15884.111221]  __fput+0xf5/0x2a0
> > [15884.111225]  task_work_run+0x5d/0x90
> > [15884.111230]  exit_to_user_mode_prepare+0x1e6/0x1f0
> > [15884.111234]  syscall_exit_to_user_mode+0x1b/0x40
> > [15884.111238]  do_syscall_64+0x6c/0x90
> > [15884.111241]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.111245]  ? do_syscall_64+0x6c/0x90
> > [15884.111248]  ? do_syscall_64+0x6c/0x90
> > [15884.111251]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.111254]  ? do_syscall_64+0x6c/0x90
> > [15884.111258]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.111262] RIP: 0033:0x7f5c895037b4
> > [15884.111269] RSP: 002b:00007ffefde48ad8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> > [15884.111272] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f5c895037b4
> > [15884.111274] RDX: 0000000000002000 RSI: 00007ffefde48af0 RDI: 0000000000000003
> > [15884.111276] RBP: 00007ffefde4ab30 R08: 0000557aafa18780 R09: 0000000000000001
> > [15884.111278] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f5c89644b08
> > [15884.111281] R13: 0000000000000022 R14: 0000000000000003 R15: 0000000000000000
> > [15884.111285]  </TASK>
> > [15884.111288] task:ar              state:D stack:0     pid:29594 ppid:29592  flags:0x00004002
> > [15884.111292] Call Trace:
> > [15884.111293]  <TASK>
> > [15884.111295]  __schedule+0x3ee/0x14c0
> > [15884.111299]  ? md_handle_request+0x19a/0x220
> > [15884.111304]  schedule+0x5e/0xd0
> > [15884.111307]  md_super_wait+0xa2/0xe0
> > [15884.111311]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [15884.111315]  md_bitmap_unplug+0xd2/0x120
> > [15884.111319]  flush_bio_list+0xf3/0x100 [raid1]
> > [15884.111328]  raid1_unplug+0x3b/0xb0 [raid1]
> > [15884.111336]  __blk_flush_plug+0xd7/0x150
> > [15884.111342]  blk_finish_plug+0x29/0x40
> > [15884.111346]  ext4_do_writepages+0x401/0xc90
> > [15884.111352]  ext4_writepages+0xad/0x180
> > [15884.111358]  do_writepages+0xd2/0x1e0
> > [15884.111364]  filemap_fdatawrite_wbc+0x63/0x90
> > [15884.111369]  __filemap_fdatawrite_range+0x5c/0x80
> > [15884.111374]  ext4_release_file+0x74/0xb0
> > [15884.111378]  __fput+0xf5/0x2a0
> > [15884.111382]  task_work_run+0x5d/0x90
> > [15884.111386]  exit_to_user_mode_prepare+0x1e6/0x1f0
> > [15884.111390]  syscall_exit_to_user_mode+0x1b/0x40
> > [15884.111394]  do_syscall_64+0x6c/0x90
> > [15884.111397]  ? exit_to_user_mode_prepare+0x188/0x1f0
> > [15884.111401]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.111404]  ? do_syscall_64+0x6c/0x90
> > [15884.111407]  ? do_syscall_64+0x6c/0x90
> > [15884.111410]  ? do_syscall_64+0x6c/0x90
> > [15884.111413]  ? do_syscall_64+0x6c/0x90
> > [15884.111416]  ? do_syscall_64+0x6c/0x90
> > [15884.111419]  ? do_syscall_64+0x6c/0x90
> > [15884.111423]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.111427] RIP: 0033:0x7ff3905037b4
> > [15884.111433] RSP: 002b:00007fffc71b6e38 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> > [15884.111437] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007ff3905037b4
> > [15884.111439] RDX: 0000000000002000 RSI: 00007fffc71b6e50 RDI: 0000000000000003
> > [15884.111441] RBP: 00007fffc71b8e90 R08: 00005571b8726780 R09: 0000000000000001
> > [15884.111443] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ff39076ab08
> > [15884.111445] R13: 0000000000000009 R14: 0000000000000003 R15: 0000000000000000
> > [15884.111450]  </TASK>
> > [15884.111465] task:lvs             state:D stack:0     pid:29780 ppid:29658  flags:0x00004006
> > [15884.111469] Call Trace:
> > [15884.111470]  <TASK>
> > [15884.111472]  __schedule+0x3ee/0x14c0
> > [15884.111478]  schedule+0x5e/0xd0
> > [15884.111481]  schedule_timeout+0x151/0x160
> > [15884.111486]  wait_for_completion+0x8a/0x160
> > [15884.111491]  exit_aio+0x10d/0x120
> > [15884.111496]  __mmput+0x12/0x130
> > [15884.111500]  do_exit+0x305/0xb10
> > [15884.111504]  ? aio_read_events_ring+0x19b/0x220
> > [15884.111511]  do_group_exit+0x31/0x80
> > [15884.111515]  get_signal+0x9a5/0x9e0
> > [15884.111519]  ? read_events+0x199/0x1d0
> > [15884.111522]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [15884.111526]  arch_do_signal_or_restart+0x3e/0x270
> > [15884.111534]  exit_to_user_mode_prepare+0x195/0x1f0
> > [15884.111537]  syscall_exit_to_user_mode+0x1b/0x40
> > [15884.111541]  do_syscall_64+0x6c/0x90
> > [15884.111544]  ? exit_to_user_mode_prepare+0x142/0x1f0
> > [15884.111548]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.111552]  ? do_syscall_64+0x6c/0x90
> > [15884.111555]  ? syscall_exit_to_user_mode+0x1b/0x40
> > [15884.111558]  ? do_syscall_64+0x6c/0x90
> > [15884.111561]  ? exit_to_user_mode_prepare+0x142/0x1f0
> > [15884.111565]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [15884.111569] RIP: 0033:0x7f9f0fd1380d
> > [15884.111575] RSP: 002b:00007fff94bfb4c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d0
> > [15884.111579] RAX: fffffffffffffffc RBX: 00007f9f101f0000 RCX: 00007f9f0fd1380d
> > [15884.111581] RDX: 0000000000000040 RSI: 0000000000000001 RDI: 00007f9f101f0000
> > [15884.111583] RBP: 00007fff94bfb510 R08: 0000000000000000 R09: 0000000294bfba10
> > [15884.111586] R10: 00007fff94bfb520 R11: 0000000000000246 R12: 0000000000000001
> > [15884.111588] R13: 0000000000000040 R14: 00007f9f0fe4f090 R15: 00007fff94bfb520
> > [15884.111593]  </TASK>
> > 
> > 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
