Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0701277D15C
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 19:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbjHORuz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 13:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbjHORuu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 13:50:50 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F621BFC;
        Tue, 15 Aug 2023 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=0uxZXt/3Zkui8A9kyK+TZyZRF0Naf2So+pMYW6yTbqA=; b=c5lrxrd62N4p5vr8AvYqmG8NnL
        FzvevgscZ+5EqM8/w2Y1RvgRLJeYE9t4cyPD/h6YkyQeMIINQOTnasGIQbiFWtISpPqosNd//F9jm
        4+MlxLVcR3N1Vk+5A0Z+5SjP+5V9GqypjJV+EEwk0Vb68FDlbryRRwyxOGe5TIyVnwHcuB8B6d+NA
        zhqrKH+UmeOUO7Nu8h0qrbJaf6bTQ0R0pC+L9hLIma1f9qtqbxMqzHyRqjadHS0x9Y6XNU+vU4C+M
        UuvKiJju8F9DqVo4y+dq1AGx0ZCvx24uy3IJGnJ/VYTLsrtyx55h+NKEVT2HEE5J8buKQEEIG4DgZ
        Y4VGjRyg==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qVyBf-00768e-4i; Tue, 15 Aug 2023 17:50:35 +0000
Date:   Tue, 15 Aug 2023 17:50:35 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, song@kernel.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: 6.5.0rc5 fs hang - ext4? raid?
Message-ID: <ZNu668KGiNcwCSVe@gallifrey>
References: <ZNqWfQPTScJDkmpX@gallifrey>
 <20230815125146.GA1508930@mit.edu>
 <ZNt11WbPn7LCXPvB@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZNt11WbPn7LCXPvB@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 17:46:28 up 40 days,  3:18,  1 user,  load average: 0.01, 0.00, 0.00
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

* Dr. David Alan Gilbert (dave@treblig.org) wrote:
> * Theodore Ts'o (tytso@mit.edu) wrote:
> > On Mon, Aug 14, 2023 at 09:02:53PM +0000, Dr. David Alan Gilbert wrote:
> > > dg         29594   29592  0 18:40 pts/0    00:00:00 /usr/bin/ar --plugin /usr/libexec/gcc/x86_64-redhat-linux/13/liblto_plugin.so -csrDT src/intel/perf/libintel_perf.a src/intel/perf/libintel_perf.a.p/meson-generated_.._intel_perf_metrics.c.o src/intel/perf/libintel_perf.a.p/intel_perf.c.o src/intel/perf/libintel_perf.a.p/intel_perf_query.c.o src/intel/perf/libintel_perf.a.p/intel_perf_mdapi.c.o
> > > 
> > > [root@dalek dg]# cat /proc/29594/stack 
> > > [<0>] md_super_wait+0xa2/0xe0
> > > [<0>] md_bitmap_unplug+0xd2/0x120
> > > [<0>] flush_bio_list+0xf3/0x100 [raid1]
> > > [<0>] raid1_unplug+0x3b/0xb0 [raid1]
> > > [<0>] __blk_flush_plug+0xd7/0x150
> > > [<0>] blk_finish_plug+0x29/0x40
> > > [<0>] ext4_do_writepages+0x401/0xc90
> > > [<0>] ext4_writepages+0xad/0x180
> > 
> > If you want a few seconds and try grabbing cat /proc/29594/stack
> > again, what does the stack trace stay consistent as above?
> 
> I'll get back to that and retry it.

Yeh, the stack is consistent; this time around it's an 'ar' in a kernel
build:

[root@dalek dg]# cat /proc/17970/stack
[<0>] md_super_wait+0xa2/0xe0
[<0>] md_bitmap_unplug+0xad/0x120
[<0>] flush_bio_list+0xf3/0x100 [raid1]
[<0>] raid1_unplug+0x3b/0xb0 [raid1]
[<0>] __blk_flush_plug+0xd7/0x150
[<0>] blk_finish_plug+0x29/0x40
[<0>] ext4_do_writepages+0x401/0xc90
[<0>] ext4_writepages+0xad/0x180
[<0>] do_writepages+0xd2/0x1e0
[<0>] filemap_fdatawrite_wbc+0x63/0x90
[<0>] __filemap_fdatawrite_range+0x5c/0x80
[<0>] ext4_release_file+0x74/0xb0
[<0>] __fput+0xf5/0x2a0
[<0>] task_work_run+0x5d/0x90
[<0>] exit_to_user_mode_prepare+0x1e6/0x1f0
[<0>] syscall_exit_to_user_mode+0x1b/0x40
[<0>] do_syscall_64+0x6c/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[root@dalek dg]# cat /proc/17970/stack
[<0>] md_super_wait+0xa2/0xe0
[<0>] md_bitmap_unplug+0xad/0x120
[<0>] flush_bio_list+0xf3/0x100 [raid1]
[<0>] raid1_unplug+0x3b/0xb0 [raid1]
[<0>] __blk_flush_plug+0xd7/0x150
[<0>] blk_finish_plug+0x29/0x40
[<0>] ext4_do_writepages+0x401/0xc90
[<0>] ext4_writepages+0xad/0x180
[<0>] do_writepages+0xd2/0x1e0
[<0>] filemap_fdatawrite_wbc+0x63/0x90
[<0>] __filemap_fdatawrite_range+0x5c/0x80
[<0>] ext4_release_file+0x74/0xb0
[<0>] __fput+0xf5/0x2a0
[<0>] task_work_run+0x5d/0x90
[<0>] exit_to_user_mode_prepare+0x1e6/0x1f0
[<0>] syscall_exit_to_user_mode+0x1b/0x40
[<0>] do_syscall_64+0x6c/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8

> > Also, if you have iostat installed (usually part of the sysstat
> > package), does "iostat 1" show any I/O activity on the md device?

iostat is showing something odd, most devices are at 0,
except for 3 of the dm's that are stuck at 100% utilisation with
apparently nothing going on:

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.06    0.00    0.03   53.06    0.00   46.84

Device            r/s     rkB/s   rrqm/s  %rrqm r_await rareq-sz     w/s     wkB/s   wrqm/s  %wrqm w_await wareq-sz     d/s     dkB/s   drqm/s  %drqm d_await dareq-sz     f/s f_await  aqu-sz  %util
...
dm-16            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00 100.00
dm-17            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00 100.00
dm-18            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
dm-19            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
dm-2             0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00   0.00
dm-20            0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00      0.00     0.00   0.00    0.00     0.00    0.00    0.00    0.00 100.00
....

dm-20 is the /dev/mapper/main-more which is the RAID on which the
fs runs, 16 and 17 are main-more_rmeta_0 and main-more_rimage_0
so something screwy is going on there.

Dave


> > What about the underying block dvices used by the md device?  If the
> > md device is attached to HDD's where you can see the activity light,
> > can you see (or hear) any disk activity?
> 
> It's spinning rust, and I hear them go quiet when the hang happens.
> 
> Dave
> 
> > This sure seems like either the I/O driver isn't processing requests,
> > or some kind of hang in the md layer....
> > 
> > 				- Ted
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
