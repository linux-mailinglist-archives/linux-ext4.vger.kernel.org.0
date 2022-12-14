Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32BA64C3A0
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Dec 2022 06:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLNFyW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Dec 2022 00:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLNFyV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Dec 2022 00:54:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45C22253F
        for <linux-ext4@vger.kernel.org>; Tue, 13 Dec 2022 21:54:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 648D3B815F3
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 05:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28E8CC433D2
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 05:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670997257;
        bh=oV+q/O4gpfHlWFY2oULlZ7LPT8qY40F9911D7va8eK4=;
        h=From:To:Subject:Date:From;
        b=SiTT2VITMQXc128hJZMi4NUZnpsQ+BKguwjlb03JCoMUuOxVHz4DuT6rXVWqtTZiD
         MbfIAkRQ9JviMhFiFSb3RAWLFDFjQu4KhVcLcwXQE9RXNz3F2Nmv0elRbOTv7cTbsE
         vgr54mbHtlb+eUqo9xwrdbesIpnlXgw+J5xK6dDyNjgMYo5VAFjlyuXwLMgB7zjc8O
         wChB8Ik3+NS4I6Y00cLuijm5Jf/L21Ishj5Uiyh6J4YL/7mnnNLHgEzcguKUFPJpKJ
         kVZQaug4OYYnGWA8FrL2/2VD6jHZhYvHYEfB8tq/IcVMLGIsAQItX17ieQn+76tADR
         GQTtef1aRF+jw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DD9CDC43143; Wed, 14 Dec 2022 05:54:16 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216807] New: [Syzkaller & bisect] There is "possible deadlock
 in ext4_bmap" issue in v6.1 kernel
Date:   Wed, 14 Dec 2022 05:54:15 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pengfei.xu@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216807-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216807

            Bug ID: 216807
           Summary: [Syzkaller & bisect] There is "possible deadlock in
                    ext4_bmap" issue in v6.1 kernel
           Product: File System
           Version: 2.5
    Kernel Version: v6.1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: pengfei.xu@intel.com
        Regression: No

There is "possible deadlock in ext4_bmap" issue in v6.1 kernel:
"
[   28.421104]=20
[   28.421671] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   28.422016] WARNING: possible circular locking dependency detected
[   28.422358] 6.1.0-830b3c68c1fb #1 Not tainted
[   28.422607] ------------------------------------------------------
[   28.422956] repro/588 is trying to acquire lock:
[   28.423217] ff110000060e5980 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, a=
t:
ext4_bmap+0x39/0x1c0
[   28.423729]=20
[   28.423729] but task is already holding lock:
[   28.424055] ff110000093323f8 (&journal->j_checkpoint_mutex){+.+.}-{3:3},=
 at:
jbd2_journal_flush+0x267/0x5f0
[   28.424610]=20
[   28.424610] which lock already depends on the new lock.
[   28.424610]=20
[   28.425057]=20
[   28.425057] the existing dependency chain (in reverse order) is:
[   28.425467]=20
[   28.425467] -> #3 (&journal->j_checkpoint_mutex){+.+.}-{3:3}:
[   28.425877]        mutex_lock_io_nested+0xad/0xd60
[   28.426156]        jbd2_journal_flush+0xcf/0x5f0
[   28.426429]        __ext4_ioctl+0x225/0x25c0
[   28.426680]        ext4_ioctl+0x2e/0x40
[   28.426908]        __x64_sys_ioctl+0x10e/0x160
[   28.427171]        do_syscall_64+0x3b/0x90
[   28.427417]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   28.427739]=20
[   28.427739] -> #2 (&journal->j_barrier){+.+.}-{3:3}:
[   28.428105]        __mutex_lock+0x9c/0xf30
[   28.428342]        mutex_lock_nested+0x1f/0x30
[   28.428600]        jbd2_journal_lock_updates+0xbe/0x1a0
[   28.428909]        ext4_change_inode_journal_flag+0xd4/0x2c0
[   28.429234]        ext4_fileattr_set+0x86d/0xe60
[   28.429501]        vfs_fileattr_set+0x365/0x4e0
[   28.429765]        do_vfs_ioctl+0x378/0xcc0
[   28.430010]        __x64_sys_ioctl+0xca/0x160
[   28.430265]        do_syscall_64+0x3b/0x90
[   28.430508]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   28.430832]=20
[   28.430832] -> #1 (&sbi->s_writepages_rwsem){++++}-{0:0}:
[   28.431224]        percpu_down_write+0x4d/0x2d0
[   28.431487]        ext4_ind_migrate+0xcc/0x390
[   28.431748]        ext4_fileattr_set+0xbba/0xe60
[   28.432018]        vfs_fileattr_set+0x365/0x4e0
[   28.432280]        do_vfs_ioctl+0x378/0xcc0
[   28.432525]        __x64_sys_ioctl+0xca/0x160
[   28.432780]        do_syscall_64+0x3b/0x90
[   28.433027]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   28.433349]=20
[   28.433349] -> #0 (&sb->s_type->i_mutex_key#8){++++}-{3:3}:
[   28.433751]        __lock_acquire+0x1023/0x1d20
[   28.434022]        lock_acquire+0xd6/0x2f0
[   28.434259]        down_read+0x45/0x160
[   28.434483]        ext4_bmap+0x39/0x1c0
[   28.434718]        bmap+0x40/0x70
[   28.434925]        jbd2_journal_bmap+0x61/0xe0
[   28.435186]        jbd2_journal_flush+0x461/0x5f0
[   28.435459]        __ext4_ioctl+0x225/0x25c0
[   28.435708]        ext4_ioctl+0x2e/0x40
[   28.435935]        __x64_sys_ioctl+0x10e/0x160
[   28.436193]        do_syscall_64+0x3b/0x90
[   28.436436]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   28.436757]=20
[   28.436757] other info that might help us debug this:
[   28.436757]=20
[   28.437194] Chain exists of:
[   28.437194]   &sb->s_type->i_mutex_key#8 --> &journal->j_barrier -->
&journal->j_checkpoint_mutex
[   28.437194]=20
[   28.437924]  Possible unsafe locking scenario:
[   28.437924]=20
[   28.438251]        CPU0                    CPU1
[   28.438505]        ----                    ----
[   28.438759]   lock(&journal->j_checkpoint_mutex);
[   28.439030]                                lock(&journal->j_barrier);
[   28.439388]=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
lock(&journal->j_checkpoint_mutex);
[   28.439788]   lock(&sb->s_type->i_mutex_key#8);
[   28.440052]=20
[   28.440052]  *** DEADLOCK ***
[   28.440052]=20
[   28.440378] 2 locks held by repro/588:
[   28.440595]  #0: ff11000009332170 (&journal->j_barrier){+.+.}-{3:3}, at:
jbd2_journal_lock_updates+0xbe/0x1a0
[   28.441168]  #1: ff110000093323f8
(&journal->j_checkpoint_mutex){+.+.}-{3:3}, at: jbd2_journal_flush+0x267/0x=
5f0
[   28.441746]=20
[   28.441746] stack backtrace:
[   28.441994] CPU: 1 PID: 588 Comm: repro Not tainted 6.1.0-830b3c68c1fb #1
[   28.442375] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   28.443004] Call Trace:
[   28.443148]  <TASK>
[   28.443275]  dump_stack_lvl+0xa7/0xdb
[   28.443497]  dump_stack+0x19/0x1f
[   28.443699]  print_circular_bug.isra.46.cold.67+0x13e/0x143
[   28.444031]  check_noncircular+0x102/0x120
[   28.444277]  ? write_comp_data+0x2f/0x90
[   28.444508]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   28.444783]  __lock_acquire+0x1023/0x1d20
[   28.445025]  lock_acquire+0xd6/0x2f0
[   28.445236]  ? ext4_bmap+0x39/0x1c0
[   28.445453]  down_read+0x45/0x160
[   28.445652]  ? ext4_bmap+0x39/0x1c0
[   28.445865]  ? ext4_invalidate_folio+0x1e0/0x1e0
[   28.446143]  ext4_bmap+0x39/0x1c0
[   28.446347]  ? ext4_invalidate_folio+0x1e0/0x1e0
[   28.446622]  bmap+0x40/0x70
[   28.446800]  jbd2_journal_bmap+0x61/0xe0
[   28.447038]  jbd2_journal_flush+0x461/0x5f0
[   28.447287]  __ext4_ioctl+0x225/0x25c0
[   28.447510]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   28.447782]  ? do_vfs_ioctl+0xb8/0xcc0
[   28.448006]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   28.448281]  ext4_ioctl+0x2e/0x40
[   28.448480]  __x64_sys_ioctl+0x10e/0x160
[   28.448712]  ? ext4_fileattr_set+0xe60/0xe60
[   28.448964]  do_syscall_64+0x3b/0x90
[   28.449183]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   28.449479] RIP: 0033:0x7f839e4b959d
[   28.449689] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d 01
f0 8
[   28.450702] RSP: 002b:00007ffd48343808 EFLAGS: 00000217 ORIG_RAX:
0000000000000010
[   28.451127] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f839e4b959d
[   28.451523] RDX: 0000000020000080 RSI: 000000004004662b RDI:
0000000000000004
[   28.451922] RBP: 00007ffd48343820 R08: 00007ffd48343900 R09:
00007ffd48343900
[   28.452317] R10: 00007ffd48343900 R11: 0000000000000217 R12:
0000000000401060
[   28.452712] R13: 00007ffd48343900 R14: 0000000000000000 R15:
0000000000000000
[   28.453116]  </TASK>
[   28.675120] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   28.898857] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   29.121957] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   29.343926] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   29.563709] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   29.783732] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   30.002988] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   30.222407] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   30.442175] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   33.495841] ext4_ioctl_checkpoint: 13 callbacks suppressed
[   33.495853] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   33.714325] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   33.932831] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   34.151299] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   34.370576] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   34.589091] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   34.808403] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   35.028663] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
[   35.247587] warning: checkpointing journal with
EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
"
Bisect and found that, the first bad commit is:
51ae846cff568c8c29921b1b28eb2dfbcd4ac12d
ext4: fix warning in ext4_iomap_begin as race between bmap and write

After reverted the bad commit on top of v6.1, this issue was gone.

All above bisect info, kconfig, reproduced code from syzkaller is in link:
https://github.com/xupengfe/syzkaller_logs/tree/main/221212_234319_ext4_bmap

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D


There was one more similar "possible deadlock in jbd2_journal_lock_updates"
issue found by syzkaller, and bisected and found that the first bad commit =
is
also 51ae846cff568c8c29921b1b28eb2dfbcd4ac12d

Reverted above commit on top of v6.1, the jbd2_journal_lock_updates issue w=
as
gone also.

Related issue bisect info, reproduced code is in link:
https://github.com/xupengfe/syzkaller_logs/tree/main/221213_160256_jbd2_jou=
rnal_lock_updates

Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
