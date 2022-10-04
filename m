Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B828D5F3F37
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Oct 2022 11:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJDJKk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Oct 2022 05:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJDJKj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Oct 2022 05:10:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1671B7A1
        for <linux-ext4@vger.kernel.org>; Tue,  4 Oct 2022 02:10:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC9CE219CD;
        Tue,  4 Oct 2022 09:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664874635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SWAE+oQ50CuLawXl//O5wWcJZ+czZjkyzP0QfekWqTk=;
        b=K7R5YBEyBfjBN92AR3VoVFjREdbaWkQtjEfXnstmn67yR+gt9cLSeMRxFLX8qQSeezUZ/8
        URLOIyhKWSSqSStgOFchwCRVdbNS9aBVeouoBYKC5hA3iaJSrOYCrSi/NUj1IEnQ4uPZdH
        orGxRfUGzk3ZNjdSoYHgZitabbu+E3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664874635;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SWAE+oQ50CuLawXl//O5wWcJZ+czZjkyzP0QfekWqTk=;
        b=eEq1cnFuDs0Gmf/+9lhGn8rVZT+duc12qRwNWEWucxH59V7NZWSu5D+m8rVoK8XZz0nM+T
        Ux3NZj/PCfyw/CDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD435139D2;
        Tue,  4 Oct 2022 09:10:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JfUoLov4O2MXZAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Oct 2022 09:10:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2F323A06E6; Tue,  4 Oct 2022 11:10:35 +0200 (CEST)
Date:   Tue, 4 Oct 2022 11:10:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Jan Kara <jack@suse.cz>, Thilo Fromm <t-lo@linux.microsoft.com>,
        jack@suse.com, tytso@mit.edu, Ye Bin <yebin10@huawei.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <20221004091035.idjgo2xyscf6ovnv@quack3>
References: <20220824100652.227m7eq4zqq7luir@quack3>
 <c77bf00f-4618-7149-56f1-b8d1664b9d07@linux.microsoft.com>
 <20220929082716.5urzcfk4hnapd3cr@quack3>
 <d8b18ba8-ea12-b617-6b5e-455a1d7b5e21@linux.microsoft.com>
 <20221004063807.GA30205@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004063807.GA30205@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

On Mon 03-10-22 23:38:07, Jeremi Piotrowski wrote:
> On Thu, Sep 29, 2022 at 03:18:21PM +0200, Thilo Fromm wrote:
> > Thank you very much for your thorough feedback. We were unaware of
> > the backtrace issue and will have a look at once.
> > 
> > >>>So this seems like a real issue. Essentially, the problem is that
> > >>>ext4_bmap() acquires inode->i_rwsem while its caller
> > >>>jbd2_journal_flush() is holding journal->j_checkpoint_mutex. This
> > >>>looks like a real deadlock possibility.
> > >>
> > >>Flatcar Container Linux users have reported a kernel issue which might be
> > >>caused by commit 51ae846cff5. The issue is triggered under I/O load in
> > >>certain conditions and leads to a complete system hang. I've pasted a
> > >>typical kernel log below; please refer to
> > >>https://github.com/flatcar/Flatcar/issues/847 for more details.
> > >>
> > >>The issue can be triggered on Flatcar release 3227.2.2 / kernel version
> > >>5.15.63 (we ship LTS kernels) but not on release 3227.2.1 / kernel 5.15.58.
> > >>51ae846cff5 was introduced to 5.15 in 5.15.61.
> > >
> > >Well, so far your stacktraces do not really show anything pointing to that
> > >particular commit. So we need to understand that hang some more.
> > 
> > This makes sense and I agree. Sorry for the garbled stack traces.
> > 
> > In other news, one of our users - who can reliably trigger the issue
> > in their set-up - ran tests with kernel 5.15.63 with and without
> > commit 51ae846cff5. Without the commit, the kernel hang did not
> > occur (see https://github.com/flatcar/Flatcar/issues/847#issuecomment-1261967920).
> > 
> > We'll now focus on un-garbling our traces to get to the bottom of this.
> > 
> > >>( Kernel log of a crash follows; more info here:
> > >>https://github.com/flatcar/Flatcar/issues/847 )
> > >>
> > [...]
> > >>[1282119.190346]  ret_from_fork+0x22/0x30
> > >
> > >Hrm, so your backtraces seem to be strange. For example in this stacktrace
> > >we should have kjournald2() somewhere instead of
> > >jbd2_journal_check_available_features() which can hardly be there. So
> > >somehow stack unwinding or symbol resolution is strangely confused with
> > >this kernel. Compiling with any unusual config or compiler?
> > 
> > We're on GCC 10.3.0 and will review our build process to get to the
> > bottom of this. Will get back to this thread as soon as we have
> > news. Thanks again for pointing this out!
> > 
> 
> So our stacktraces were mangled because historically our kernel build used
> INSTALL_MOD_STRIP=--strip-unneeded, we've now switched it back to --strip-debug
> which is the default. We're still using CONFIG_UNWINDER_ORC=y.
> 
> Here's the hung task output after the change to stripping:

Yeah, the stacktraces now look as what I'd expect. Thanks for fixing that!
Sadly they don't point to the culprit of the problem. They show jbd2/sda9-8
is waiting for someone to drop its transaction handle. Other processes are
waiting for jbd2/sda9-8 to commit a transaction. And then a few processes
are waiting for locks held by these waiting processes. But I don't see
anywhere the process holding the transaction handle. Can you please
reproduce the problem once more and when the system hangs run:

echo w >/proc/sysrq-trigger

Unlike softlockup detector, this will dump all blocked task so hopefully
we'll see the offending task there. Thanks!

								Honza


> 
> [ 1599.005306] INFO: task jbd2/sda9-8:702 blocked for more than 122 seconds.
> [ 1599.012290]       Not tainted 5.15.63-flatcar #1
> [ 1599.017128] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1599.025100] task:jbd2/sda9-8     state:D stack:    0 pid:  702 ppid:     2 flags:0x00004000
> [ 1599.033579] Call Trace:
> [ 1599.036144]  <TASK>
> [ 1599.038354]  __schedule+0x2eb/0x8d0
> [ 1599.042109]  schedule+0x5b/0xd0
> [ 1599.045372]  jbd2_journal_commit_transaction+0x301/0x18e0 [jbd2]
> [ 1599.051518]  ? wait_woken+0x70/0x70
> [ 1599.055127]  ? lock_timer_base+0x61/0x80
> [ 1599.059181]  kjournald2+0xab/0x270 [jbd2]
> [ 1599.063317]  ? wait_woken+0x70/0x70
> [ 1599.066923]  ? load_superblock.part.0+0xb0/0xb0 [jbd2]
> [ 1599.072200]  kthread+0x124/0x150
> [ 1599.075543]  ? set_kthread_struct+0x50/0x50
> [ 1599.079849]  ret_from_fork+0x1f/0x30
> [ 1599.083538]  </TASK>
> [ 1599.085835] INFO: task kworker/u32:13:732 blocked for more than 122 seconds.
> [ 1599.093010]       Not tainted 5.15.63-flatcar #1
> [ 1599.097739] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1599.105688] task:kworker/u32:13  state:D stack:    0 pid:  732 ppid:     2 flags:0x00004000
> [ 1599.114160] Workqueue: writeback wb_workfn (flush-8:0)
> [ 1599.119418] Call Trace:
> [ 1599.121976]  <TASK>
> [ 1599.124192]  __schedule+0x2eb/0x8d0
> [ 1599.127797]  schedule+0x5b/0xd0
> [ 1599.131051]  wait_transaction_locked+0x8a/0xd0 [jbd2]
> [ 1599.136227]  ? wait_woken+0x70/0x70
> [ 1599.139829]  add_transaction_credits+0xd9/0x2b0 [jbd2]
> [ 1599.145091]  ? find_get_pages_range+0x197/0x200
> [ 1599.149832]  start_this_handle+0xfb/0x520 [jbd2]
> [ 1599.154591]  ? mpage_release_unused_pages+0x1c7/0x1e0 [ext4]
> [ 1599.160524]  ? __cond_resched+0x16/0x50
> [ 1599.164478]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
> [ 1599.169393]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
> [ 1599.174669]  ext4_writepages+0x302/0xfd0 [ext4]
> [ 1599.179328]  ? __find_get_block+0xb3/0x2c0
> [ 1599.183539]  ? __cond_resched+0x16/0x50
> [ 1599.187518]  ? __getblk_gfp+0x27/0x60
> [ 1599.191307]  ? cpumask_next_and+0x1f/0x30
> [ 1599.195433]  ? update_sd_lb_stats.constprop.0+0xff/0x8a0
> [ 1599.200888]  do_writepages+0xce/0x200
> [ 1599.204788]  ? _raw_spin_unlock_irqrestore+0xa/0x30
> [ 1599.209796]  ? percpu_counter_add_batch+0x5b/0x70
> [ 1599.214627]  ? fprop_reflect_period_percpu.isra.0+0x7b/0xc0
> [ 1599.220439]  __writeback_single_inode+0x39/0x290
> [ 1599.225183]  writeback_sb_inodes+0x20d/0x490
> [ 1599.229569]  __writeback_inodes_wb+0x4c/0xe0
> [ 1599.233951]  wb_writeback+0x1c0/0x280
> [ 1599.237727]  wb_workfn+0x29f/0x4d0
> [ 1599.241244]  process_one_work+0x223/0x3c0
> [ 1599.245371]  worker_thread+0x50/0x410
> [ 1599.249146]  ? process_one_work+0x3c0/0x3c0
> [ 1599.253460]  kthread+0x124/0x150
> [ 1599.256811]  ? set_kthread_struct+0x50/0x50
> [ 1599.261110]  ret_from_fork+0x1f/0x30
> [ 1599.264820]  </TASK>
> [ 1599.267171] INFO: task systemd-journal:1098 blocked for more than 123 seconds.
> [ 1599.274538]       Not tainted 5.15.63-flatcar #1
> [ 1599.279282] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1599.287256] task:systemd-journal state:D stack:    0 pid: 1098 ppid:     1 flags:0x00000224
> [ 1599.295753] Call Trace:
> [ 1599.298343]  <TASK>
> [ 1599.300570]  __schedule+0x2eb/0x8d0
> [ 1599.304178]  schedule+0x5b/0xd0
> [ 1599.307434]  wait_transaction_locked+0x8a/0xd0 [jbd2]
> [ 1599.312814]  ? wait_woken+0x70/0x70
> [ 1599.316431]  add_transaction_credits+0xd9/0x2b0 [jbd2]
> [ 1599.321722]  start_this_handle+0xfb/0x520 [jbd2]
> [ 1599.326460]  ? __cond_resched+0x16/0x50
> [ 1599.330414]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
> [ 1599.335331]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
> [ 1599.340615]  ext4_truncate+0x167/0x480 [ext4]
> [ 1599.345134]  ext4_setattr+0x59a/0x9a0 [ext4]
> [ 1599.349567]  ? virtnet_poll+0x31b/0x45b [virtio_net]
> [ 1599.354663]  ? common_interrupt+0xf/0xa0
> [ 1599.358705]  notify_change+0x3c1/0x540
> [ 1599.362591]  ? do_truncate+0x7d/0xd0
> [ 1599.366292]  do_truncate+0x7d/0xd0
> [ 1599.369836]  do_sys_ftruncate+0xc9/0x150
> [ 1599.373882]  do_syscall_64+0x38/0x90
> [ 1599.377581]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> [ 1599.382757] RIP: 0033:0x7fc405986757
> [ 1599.386449] RSP: 002b:00007ffdf6776af8 EFLAGS: 00000202 ORIG_RAX: 000000000000004d
> [ 1599.394126] RAX: ffffffffffffffda RBX: 00007ffdf6776b40 RCX: 00007fc405986757
> [ 1599.401371] RDX: 0000557b78aa8f40 RSI: 0000000001000000 RDI: 0000000000000015
> [ 1599.408615] RBP: 0000557b78aac520 R08: 0000000000000001 R09: 0000557b78aac5ac
> [ 1599.415860] R10: 0000000000000000 R11: 0000000000000202 R12: 0000557b78a9c600
> [ 1599.423119] R13: 00007ffdf6776b38 R14: 0000000000000003 R15: 0000000000000000
> [ 1599.430406]  </TASK>
> [ 1599.432754] INFO: task systemd-timesyn:1277 blocked for more than 123 seconds.
> [ 1599.440097]       Not tainted 5.15.63-flatcar #1
> [ 1599.444842] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1599.452799] task:systemd-timesyn state:D stack:    0 pid: 1277 ppid:     1 flags:0x00000224
> [ 1599.461268] Call Trace:
> [ 1599.463836]  <TASK>
> [ 1599.466046]  __schedule+0x2eb/0x8d0
> [ 1599.469684]  schedule+0x5b/0xd0
> [ 1599.472946]  wait_transaction_locked+0x8a/0xd0 [jbd2]
> [ 1599.478133]  ? wait_woken+0x70/0x70
> [ 1599.481839]  add_transaction_credits+0xd9/0x2b0 [jbd2]
> [ 1599.487387]  ? __fget_files+0x79/0xb0
> [ 1599.491185]  start_this_handle+0xfb/0x520 [jbd2]
> [ 1599.495963]  ? nd_jump_link+0x4d/0xc0
> [ 1599.499752]  ? __cond_resched+0x16/0x50
> [ 1599.503708]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
> [ 1599.508620]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
> [ 1599.513897]  ext4_dirty_inode+0x35/0x80 [ext4]
> [ 1599.518477]  __mark_inode_dirty+0x144/0x320
> [ 1599.522795]  ext4_setattr+0x1fb/0x9a0 [ext4]
> [ 1599.527200]  notify_change+0x3c1/0x540
> [ 1599.531071]  ? vfs_utimes+0x139/0x220
> [ 1599.534845]  vfs_utimes+0x139/0x220
> [ 1599.538446]  do_utimes+0xb4/0x120
> [ 1599.541874]  __x64_sys_utimensat+0x70/0xb0
> [ 1599.546132]  ? syscall_trace_enter.constprop.0+0x143/0x1c0
> [ 1599.551751]  do_syscall_64+0x38/0x90
> [ 1599.555443]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> [ 1599.560628] RIP: 0033:0x7fce21af901f
> [ 1599.564858] RSP: 002b:00007ffedd36c8c8 EFLAGS: 00000202 ORIG_RAX: 0000000000000118
> [ 1599.572559] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fce21af901f
> [ 1599.579806] RDX: 0000000000000000 RSI: 00007ffedd36c8d0 RDI: 00000000ffffff9c
> [ 1599.587062] RBP: 00007ffedd36c8d0 R08: 0000000000000000 R09: 00007ffedd36c760
> [ 1599.594313] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
> [ 1599.601558] R13: 00000000ffffffff R14: ffffffffffffffff R15: 00000000ffffffff
> [ 1599.608806]  </TASK>
> [ 1599.611124] INFO: task bash:1925 blocked for more than 123 seconds.
> [ 1599.617618]       Not tainted 5.15.63-flatcar #1
> [ 1599.622347] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1599.630283] task:bash            state:D stack:    0 pid: 1925 ppid:  1924 flags:0x00000004
> [ 1599.638750] Call Trace:
> [ 1599.641309]  <TASK>
> [ 1599.643528]  __schedule+0x2eb/0x8d0
> [ 1599.647140]  schedule+0x5b/0xd0
> [ 1599.650399]  wait_transaction_locked+0x8a/0xd0 [jbd2]
> [ 1599.655571]  ? wait_woken+0x70/0x70
> [ 1599.659188]  add_transaction_credits+0xd9/0x2b0 [jbd2]
> [ 1599.664444]  ? pagecache_get_page+0x28b/0x470
> [ 1599.668914]  start_this_handle+0xfb/0x520 [jbd2]
> [ 1599.673664]  ? __cond_resched+0x16/0x50
> [ 1599.677615]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
> [ 1599.682525]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
> [ 1599.687801]  __ext4_new_inode+0x73f/0x1710 [ext4]
> [ 1599.692639]  ext4_create+0x115/0x1d0 [ext4]
> [ 1599.696968]  path_openat+0xf48/0x1280
> [ 1599.700751]  ? _raw_spin_unlock_irqrestore+0xa/0x30
> [ 1599.705742]  ? __wake_up_common_lock+0x8a/0xc0
> [ 1599.710299]  do_filp_open+0xa9/0x150
> [ 1599.713990]  ? vfs_statx+0x74/0x130
> [ 1599.717615]  ? __check_object_size+0x146/0x160
> [ 1599.722179]  do_sys_openat2+0x9b/0x160
> [ 1599.726057]  __x64_sys_openat+0x54/0xa0
> [ 1599.730003]  do_syscall_64+0x38/0x90
> [ 1599.733691]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> [ 1599.738870] RIP: 0033:0x7f138fdb5337
> [ 1599.742558] RSP: 002b:00007ffdc49dcaa0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> [ 1599.750249] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f138fdb5337
> [ 1599.757497] RDX: 0000000000000241 RSI: 00005583f2829d70 RDI: 00000000ffffff9c
> [ 1599.764747] RBP: 00005583f2829d70 R08: 0000000000000000 R09: 0000000000000000
> [ 1599.771998] R10: 0000000000000180 R11: 0000000000000246 R12: 0000000000000241
> [ 1599.779258] R13: 0000000000000000 R14: 00005583f1f45534 R15: 0000000000000000
> [ 1599.786510]  </TASK>
> [ 1599.788906] INFO: task MVStore backgro:8970 blocked for more than 123 seconds.
> [ 1599.796262]       Not tainted 5.15.63-flatcar #1
> [ 1599.800992] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1599.808931] task:MVStore backgro state:D stack:    0 pid: 8970 ppid:  8062 flags:0x00000000
> [ 1599.817398] Call Trace:
> [ 1599.819968]  <TASK>
> [ 1599.822205]  __schedule+0x2eb/0x8d0
> [ 1599.825816]  schedule+0x5b/0xd0
> [ 1599.829073]  wait_transaction_locked+0x8a/0xd0 [jbd2]
> [ 1599.834250]  ? wait_woken+0x70/0x70
> [ 1599.837852]  add_transaction_credits+0xd9/0x2b0 [jbd2]
> [ 1599.843108]  start_this_handle+0xfb/0x520 [jbd2]
> [ 1599.847859]  ? __cond_resched+0x16/0x50
> [ 1599.851810]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
> [ 1599.856715]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
> [ 1599.861992]  ext4_dirty_inode+0x35/0x80 [ext4]
> [ 1599.866585]  __mark_inode_dirty+0x144/0x320
> [ 1599.870892]  generic_update_time+0x6c/0xd0
> [ 1599.875118]  file_update_time+0x127/0x140
> [ 1599.879242]  ? generic_write_checks+0x61/0xc0
> [ 1599.883721]  ext4_buffered_write_iter+0x5a/0x180 [ext4]
> [ 1599.889103]  do_iter_readv_writev+0x14f/0x1b0
> [ 1599.893582]  do_iter_write+0x80/0x1c0
> [ 1599.897370]  ovl_write_iter+0x2d3/0x450 [overlay]
> [ 1599.902195]  new_sync_write+0x119/0x1b0
> [ 1599.906151]  ? intel_get_event_constraints+0x300/0x390
> [ 1599.911403]  vfs_write+0x1de/0x270
> [ 1599.914917]  __x64_sys_pwrite64+0x91/0xc0
> [ 1599.919039]  do_syscall_64+0x38/0x90
> [ 1599.922727]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> [ 1599.927968] RIP: 0033:0x7f2f532424a3
> [ 1599.931659] RSP: 002b:00007f2f2cc8aa78 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
> [ 1599.939352] RAX: ffffffffffffffda RBX: 00007f2f2cc8bb38 RCX: 00007f2f532424a3
> [ 1599.946606] RDX: 0000000000001000 RSI: 00007f2f2c769d90 RDI: 0000000000000014
> [ 1599.953875] RBP: 00007f2f2cc8aaf0 R08: 0000000000000000 R09: 0000000000000000
> [ 1599.961127] R10: 00000000000a3000 R11: 0000000000000246 R12: 0000000000000012
> [ 1599.968527] R13: 00007f2f2c769d90 R14: 00000000000a3000 R15: 00007f2f2f94b800
> [ 1599.975775]  </TASK>
> [ 1599.978135] INFO: task k3s-server:12051 blocked for more than 123 seconds.
> [ 1599.985142]       Not tainted 5.15.63-flatcar #1
> [ 1599.989873] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1599.997816] task:k3s-server      state:D stack:    0 pid:12051 ppid:     1 flags:0x00000000
> [ 1600.006283] Call Trace:
> [ 1600.008862]  <TASK>
> [ 1600.011083]  __schedule+0x2eb/0x8d0
> [ 1600.014779]  schedule+0x5b/0xd0
> [ 1600.018034]  rwsem_down_write_slowpath+0x220/0x4f0
> [ 1600.022947]  chown_common+0x152/0x250
> [ 1600.026740]  ? __do_sys_newfstat+0x57/0x60
> [ 1600.030950]  ? __fget_files+0x79/0xb0
> [ 1600.034749]  ksys_fchown+0x74/0xb0
> [ 1600.038283]  __x64_sys_fchown+0x16/0x20
> [ 1600.042230]  do_syscall_64+0x38/0x90
> [ 1600.045922]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> [ 1600.051091] RIP: 0033:0x3f8045f
> [ 1600.054346] RSP: 002b:00007f749fe0a670 EFLAGS: 00000202 ORIG_RAX: 000000000000005d
> [ 1600.062050] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000003f8045f
> [ 1600.069297] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000188
> [ 1600.076557] RBP: 00007f749dfd2498 R08: 0000000000000188 R09: 000000000572a6fb
> [ 1600.083808] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000188
> [ 1600.091051] R13: 00007f749f5416cd R14: 0000000000080006 R15: 00000000000001a4
> [ 1600.098312]  </TASK>
> [ 1600.100611] INFO: task k3s-server:12052 blocked for more than 123 seconds.
> [ 1600.107601]       Not tainted 5.15.63-flatcar #1
> [ 1600.112344] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1600.120281] task:k3s-server      state:D stack:    0 pid:12052 ppid:     1 flags:0x00000000
> [ 1600.128758] Call Trace:
> [ 1600.131315]  <TASK>
> [ 1600.133536]  __schedule+0x2eb/0x8d0
> [ 1600.137136]  schedule+0x5b/0xd0
> [ 1600.140408]  wait_transaction_locked+0x8a/0xd0 [jbd2]
> [ 1600.145574]  ? wait_woken+0x70/0x70
> [ 1600.149190]  add_transaction_credits+0xd9/0x2b0 [jbd2]
> [ 1600.154442]  ? __cond_resched+0x16/0x50
> [ 1600.158395]  ? dput+0x32/0x310
> [ 1600.161559]  start_this_handle+0xfb/0x520 [jbd2]
> [ 1600.166290]  ? asm_sysvec_apic_timer_interrupt+0x15/0x20
> [ 1600.171713]  ? __cond_resched+0x16/0x50
> [ 1600.175660]  jbd2__journal_start+0xfb/0x1e0 [jbd2]
> [ 1600.180568]  __ext4_journal_start_sb+0xf8/0x110 [ext4]
> [ 1600.185846]  ext4_dirty_inode+0x35/0x80 [ext4]
> [ 1600.190441]  __mark_inode_dirty+0x144/0x320
> [ 1600.194737]  ext4_setattr+0x1fb/0x9a0 [ext4]
> [ 1600.199134]  notify_change+0x3c1/0x540
> [ 1600.203002]  ? chown_common+0x168/0x250
> [ 1600.206957]  chown_common+0x168/0x250
> [ 1600.210731]  ? __fget_files+0x79/0xb0
> [ 1600.214502]  ksys_fchown+0x74/0xb0
> [ 1600.218017]  __x64_sys_fchown+0x16/0x20
> [ 1600.221965]  do_syscall_64+0x38/0x90
> [ 1600.225674]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> [ 1600.230851] RIP: 0033:0x3f8045f
> [ 1600.234114] RSP: 002b:00007f749fde7670 EFLAGS: 00000202 ORIG_RAX: 000000000000005d
> [ 1600.241794] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000003f8045f
> [ 1600.249050] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000145
> [ 1600.256388] RBP: 00007f749e2213c8 R08: 0000000000000145 R09: 000000000572a6fb
> [ 1600.263636] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000145
> [ 1600.270890] R13: 00007f749dfbef0d R14: 0000000000080006 R15: 00000000000001a4
> [ 1600.278138]  </TASK>
> [ 1600.280436] INFO: task k3s-server:12055 blocked for more than 124 seconds.
> [ 1600.287449]       Not tainted 5.15.63-flatcar #1
> [ 1600.292184] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1600.300127] task:k3s-server      state:D stack:    0 pid:12055 ppid:     1 flags:0x00000000
> [ 1600.308590] Call Trace:
> [ 1600.311151]  <TASK>
> [ 1600.313358]  __schedule+0x2eb/0x8d0
> [ 1600.316957]  schedule+0x5b/0xd0
> [ 1600.320208]  rwsem_down_write_slowpath+0x220/0x4f0
> [ 1600.325113]  chown_common+0x152/0x250
> [ 1600.328890]  ? __do_sys_newfstat+0x57/0x60
> [ 1600.333107]  ? __fget_files+0x79/0xb0
> [ 1600.336885]  ksys_fchown+0x74/0xb0
> [ 1600.340400]  __x64_sys_fchown+0x16/0x20
> [ 1600.344346]  do_syscall_64+0x38/0x90
> [ 1600.348035]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> [ 1600.353218] RIP: 0033:0x3f8045f
> [ 1600.356471] RSP: 002b:00007f749fcae670 EFLAGS: 00000202 ORIG_RAX: 000000000000005d
> [ 1600.364149] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000003f8045f
> [ 1600.371397] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000019c
> [ 1600.378648] RBP: 00007f749f539888 R08: 000000000000019c R09: 000000000572a6fb
> [ 1600.385895] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000019c
> [ 1600.393155] R13: 00007f749e2e5a3d R14: 0000000000080006 R15: 00000000000001a4
> [ 1600.400407]  </TASK>
> [ 1600.402761] INFO: task k3s-server:12057 blocked for more than 124 seconds.
> [ 1600.409779]       Not tainted 5.15.63-flatcar #1
> [ 1600.414512] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1600.422470] task:k3s-server      state:D stack:    0 pid:12057 ppid:     1 flags:0x00000000
> [ 1600.430934] Call Trace:
> [ 1600.433510]  <TASK>
> [ 1600.435722]  __schedule+0x2eb/0x8d0
> [ 1600.439328]  schedule+0x5b/0xd0
> [ 1600.442583]  rwsem_down_write_slowpath+0x220/0x4f0
> [ 1600.447495]  chown_common+0x152/0x250
> [ 1600.451274]  ? __do_sys_newfstat+0x57/0x60
> [ 1600.455483]  ? __fget_files+0x79/0xb0
> [ 1600.459258]  ksys_fchown+0x74/0xb0
> [ 1600.462773]  __x64_sys_fchown+0x16/0x20
> [ 1600.466724]  do_syscall_64+0x38/0x90
> [ 1600.470416]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> [ 1600.475604] RIP: 0033:0x3f8045f
> [ 1600.478857] RSP: 002b:00007f749fc28670 EFLAGS: 00000202 ORIG_RAX: 000000000000005d
> [ 1600.486539] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000003f8045f
> [ 1600.493788] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000196
> [ 1600.501050] RBP: 00007f749f64dac8 R08: 0000000000000196 R09: 000000000572a6fb
> [ 1600.508318] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000196
> [ 1600.515569] R13: 00007f749eadef0d R14: 0000000000080006 R15: 00000000000001a4
> [ 1600.522817]  </TASK>
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
