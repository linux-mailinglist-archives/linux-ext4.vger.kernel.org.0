Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED975EF06B
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Sep 2022 10:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbiI2I2Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 04:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbiI2I1q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 04:27:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892B213EEAF
        for <linux-ext4@vger.kernel.org>; Thu, 29 Sep 2022 01:27:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A808821BA7;
        Thu, 29 Sep 2022 08:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664440036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vw7CjOJR7tDPs3DOAhgg4qFOe8lOdV9+NsdErEiPLWY=;
        b=yeXjMew7h86dpGOAcl9SLYhtGlS4+CvnlEfLHgwzKTmZApK6ASd4B24+lmIVPAhZjl76gZ
        7LLYn3/QX56DZffXbHStzEzXur5HSMlIuSp8VdDiYej7c7zPk5RcxkNJmAw56KW4cuLExy
        2A4JgNnHvznrrs7NVzTN7p3fp25WPig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664440036;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vw7CjOJR7tDPs3DOAhgg4qFOe8lOdV9+NsdErEiPLWY=;
        b=vpxvqSSsGZXKxz50schNIR5XOHiVlTavjJ1Jy7yNhk2yVDsHDFjJgf68w43AAn2aj/v67j
        y+luqC1VBwnztgBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90A4113A71;
        Thu, 29 Sep 2022 08:27:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2VFLI+RWNWOlGQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 29 Sep 2022 08:27:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0947DA0680; Thu, 29 Sep 2022 10:27:16 +0200 (CEST)
Date:   Thu, 29 Sep 2022 10:27:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Thilo Fromm <t-lo@linux.microsoft.com>
Cc:     jack@suse.com, tytso@mit.edu, Ye Bin <yebin10@huawei.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <20220929082716.5urzcfk4hnapd3cr@quack3>
References: <20220824100652.227m7eq4zqq7luir@quack3>
 <c77bf00f-4618-7149-56f1-b8d1664b9d07@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c77bf00f-4618-7149-56f1-b8d1664b9d07@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Wed 28-09-22 09:30:25, Thilo Fromm wrote:
> > So this seems like a real issue. Essentially, the problem is that
> > ext4_bmap() acquires inode->i_rwsem while its caller
> > jbd2_journal_flush() is holding journal->j_checkpoint_mutex. This
> > looks like a real deadlock possibility.
> 
> Flatcar Container Linux users have reported a kernel issue which might be
> caused by commit 51ae846cff5. The issue is triggered under I/O load in
> certain conditions and leads to a complete system hang. I've pasted a
> typical kernel log below; please refer to
> https://github.com/flatcar/Flatcar/issues/847 for more details.
> 
> The issue can be triggered on Flatcar release 3227.2.2 / kernel version
> 5.15.63 (we ship LTS kernels) but not on release 3227.2.1 / kernel 5.15.58.
> 51ae846cff5 was introduced to 5.15 in 5.15.61.

Well, so far your stacktraces do not really show anything pointing to that
particular commit. So we need to understand that hang some more.

> ( Kernel log of a crash follows; more info here:
> https://github.com/flatcar/Flatcar/issues/847 )
> 
> [1282119.153912] INFO: task jbd2/sda9-8:544 blocked for more than 122
> seconds.
> [1282119.157088]       Not tainted 5.15.63-flatcar #1
> [1282119.159281] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> [1282119.162723] task:jbd2/sda9-8     state:D stack:    0 pid:  544 ppid:
> 2 flags:0x00004000
> [1282119.166441] Call Trace:
> [1282119.167640]  <TASK>
> [1282119.168675]  __schedule+0x2eb/0x8d0
> [1282119.170341]  schedule+0x5b/0xd0
> [1282119.171806]  jbd2_journal_commit_transaction+0x301/0x2850 [jbd2]
> [1282119.175448]  ? wait_woken+0x70/0x70
> [1282119.177174]  ? lock_timer_base+0x61/0x80
> [1282119.179015]  jbd2_journal_check_available_features+0x1ab/0x3f0 [jbd2]
> [1282119.181922]  ? wait_woken+0x70/0x70
> [1282119.183533]  ? jbd2_journal_check_available_features+0x100/0x3f0 [jbd2]
> [1282119.186566]  kthread+0x127/0x150
> [1282119.188087]  ? set_kthread_struct+0x50/0x50
> [1282119.190346]  ret_from_fork+0x22/0x30

Hrm, so your backtraces seem to be strange. For example in this stacktrace
we should have kjournald2() somewhere instead of
jbd2_journal_check_available_features() which can hardly be there. So
somehow stack unwinding or symbol resolution is strangely confused with
this kernel. Compiling with any unusual config or compiler?

> [1282119.193081] INFO: task systemd-journal:748 blocked for more than 122
> seconds.
> [1282119.196255]       Not tainted 5.15.63-flatcar #1
> [1282119.198321] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> [1282119.201776] task:systemd-journal state:D stack:    0 pid:  748 ppid:
> 1 flags:0x00000004
> [1282119.205604] Call Trace:
> [1282119.206773]  <TASK>
> [1282119.207794]  __schedule+0x2eb/0x8d0
> [1282119.209410]  schedule+0x5b/0xd0
> [1282119.210887]  jbd2_journal_free_reserved+0xca/0x9d0 [jbd2]
> [1282119.213342]  ? wait_woken+0x70/0x70
> [1282119.214946]  jbd2_journal_free_reserved+0x2d9/0x9d0 [jbd2]
> [1282119.217482]  ? call_rcu+0xa2/0x330
> [1282119.219070]  jbd2_journal_free_reserved+0x5ab/0x9d0 [jbd2]
> [1282119.221672]  ? step_into+0x47c/0x7b0
> [1282119.223372]  ? __cond_resched+0x16/0x50
> [1282119.225175]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
> [1282119.227342]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
> [1282119.229688]  ext4_dirty_inode+0x35/0x80 [ext4]
> [1282119.231735]  __mark_inode_dirty+0x147/0x320
> [1282119.233712]  touch_atime+0x13c/0x150
> [1282119.235429]  filemap_read+0x308/0x320
> [1282119.238370]  ? may_delete+0x2a0/0x2f0
> [1282119.240286]  ? do_filp_open+0xa9/0x150
> [1282119.242071]  new_sync_read+0x119/0x1b0
> [1282119.244052]  ? 0xffffffffad000000
> [1282119.245736]  vfs_read+0xf6/0x190
> [1282119.247362]  __x64_sys_pread64+0x91/0xc0
> [1282119.249365]  do_syscall_64+0x3b/0x90
> [1282119.251173]  entry_SYSCALL_64_after_hwframe+0x61/0xcb

Similarly here the stacktrace inside jbd2 looks confused.
jbd2__journal_start() looks correct but jbd2_journal_free_reserved()
entries are certainly wrong. Likely there should be start_this_handle()
somewhere on the stack and then maybe some other function before we get to
schedule(). It seems as if the symbol table for jbd2 got somehow messed up.

Looking into stacktraces below it seems to be the case there as well and
even some stacktraces inside ext4 look bogus. Like this one:

> [1282119.800485] task:kworker/u8:2    state:D stack:    0 pid:874634 ppid:
> 2 flags:0x00004000
> [1282119.804354] Workqueue: writeback wb_workfn (flush-8:0)
> [1282119.806726] Call Trace:
> [1282119.807936]  <TASK>
> [1282119.809026]  __schedule+0x2eb/0x8d0
> [1282119.810692]  schedule+0x5b/0xd0
> [1282119.812181]  jbd2_journal_free_reserved+0xca/0x9d0 [jbd2]
> [1282119.814641]  ? wait_woken+0x70/0x70
> [1282119.816909]  jbd2_journal_free_reserved+0x2d9/0x9d0 [jbd2]
> [1282119.819409]  ? find_get_pages_range+0x197/0x200
> [1282119.821507]  jbd2_journal_free_reserved+0x5ab/0x9d0 [jbd2]
> [1282119.823988]  ? ext4_convert_inline_data+0xb07/0x2020 [ext4]
> [1282119.826555]  ? __cond_resched+0x16/0x50
> [1282119.828352]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
> [1282119.830542]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
> [1282119.833049]  __ext4_mark_inode_dirty+0x502/0x1880 [ext4]
> [1282119.835474]  ? __cond_resched+0x16/0x50
> [1282119.837281]  ? __getblk_gfp+0x27/0x60
> [1282119.838986]  ? __ext4_handle_dirty_metadata+0x56/0x19b0 [ext4]
> [1282119.841629]  ? ext4_mark_iloc_dirty+0x56a/0xaf0 [ext4]

^^ We should have ext4_writepages() around here. Also notice how the
offsets within __ext4_mark_inode_dirty() are strange. That function almost
certainly does not have 0x1880 bytes when compiled.

> [1282119.843979]  do_writepages+0xd1/0x200
> [1282119.845682]  __writeback_single_inode+0x39/0x290
> [1282119.847884]  writeback_sb_inodes+0x20d/0x490
> [1282119.849861]  __writeback_inodes_wb+0x4c/0xe0
> [1282119.851844]  wb_writeback+0x1c0/0x280
> [1282119.853561]  wb_workfn+0x29f/0x4d0
> [1282119.855195]  ? psi_task_switch+0x1e0/0x200
> [1282119.857128]  process_one_work+0x226/0x3c0
> [1282119.859031]  worker_thread+0x50/0x410
> [1282119.860747]  ? process_one_work+0x3c0/0x3c0
> [1282119.862674]  kthread+0x127/0x150
> [1282119.864307]  ? set_kthread_struct+0x50/0x50
> [1282119.867863]  ret_from_fork+0x22/0x30
> [1282119.869538]  </TASK>

So far it seems that most tasks are waiting for transaction to commit, jbd2
thread committing the transaction waits for someone to drop its transaction
reference which never happens. It is unclear who holds the transaction
reference. But with stacktraces corrupted like this it is difficult to be
certain.

So probably first try find out why stacktraces are not working right on
your kernel and fix them. And then, if the hang happens, please trigger
sysrq-w (or do echo w >/proc/sysrq-trigger if you can still get to the
machine) and send here the output. It will dump all blocked tasks and from
that we should be able to better understand what is happening.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
