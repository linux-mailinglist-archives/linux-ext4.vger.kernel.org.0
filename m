Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC9B7126F3
	for <lists+linux-ext4@lfdr.de>; Fri, 26 May 2023 14:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbjEZMwk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 May 2023 08:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbjEZMwk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 May 2023 08:52:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFBC116
        for <linux-ext4@vger.kernel.org>; Fri, 26 May 2023 05:52:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D68A263CD9
        for <linux-ext4@vger.kernel.org>; Fri, 26 May 2023 12:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19FFDC433EF
        for <linux-ext4@vger.kernel.org>; Fri, 26 May 2023 12:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685105557;
        bh=eWEEIY429Gg3FRxVjwWLbOvyQyKpeFtrn2CI/MU3AG8=;
        h=From:To:Subject:Date:From;
        b=VZqznn5PnJNBD81FqdInokKxozxSPS+oFDys8JtpLui2HYNa0AtNviFClMrvcjaa6
         bhXVoq2O3yActuVFWI469lmaZS01O5RBctSuTywI+vUmCRB6ScqiWsc6pOjEtXX4Zl
         70mpUCjUcY0uEcgxVuUTD9ptLNRQSJWTrGBGL0TQmZVOlePUDCTb3L8MsKTeg0HLOs
         g2i+7xI/TcdUfDxUGQp9upwSq0yagY6zJrf7Pqnu9jXfqdrKLMP1D3NOC4tJqFRwFs
         4HCaeXl1Y6Di7o5TbaVezwevL8evKX/+ifhx+/O8EGzQC/nlL/WzPKvM+qFHbNl3vV
         +qMn4g5MVoRDw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 012ECC43143; Fri, 26 May 2023 12:52:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217490] New: Wrongly judgement for buffer head removing
Date:   Fri, 26 May 2023 12:52:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chengzhihao1@huawei.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217490-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217490

            Bug ID: 217490
           Summary: Wrongly judgement for buffer head removing
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: chengzhihao1@huawei.com
        Regression: No

Problem 1=EF=BC=9AIn checkpoint process, missed io_end check for non-dirty =
buffer head
may corrupt the filesystem.

jbd2_journal_commit_transaction
// there are several dirty buffer heads in transaction->t_checkpoint_list
          P1            wb_workfn
jbd2_log_do_checkpoint
                 __block_write_full_page
                  trylock_buffer(bh)
                  test_clear_buffer_dirty(bh)
 if (!buffer_dirty(bh))
  __jbd2_journal_remove_checkpoint(jh)
   if (buffer_write_io_error(bh)) // false
          >> bh IO error occurs <<
 jbd2_cleanup_journal_tail
  __jbd2_update_log_tail
   jbd2_write_superblock

The bh won't be replayed in next mount, image becomes corrupted.

1. Apply diff_1 and compile kernel
2. sh test_1.sh
[   69.605320] assign g_bh, trace dir 12 buffer, add a(14)
[   69.617135] mark buffer dirty
[   69.632237] jbd2_log_do_checkpoint: wait clear dirty
[   70.646949] __block_write_full_page: clear buffer dirty, delay submit
[   70.733846] jbd2_log_do_checkpoint: wait dirty cleared
[   70.849564] __block_write_full_page: delay done
[   70.850340] Buffer I/O error on dev sda, logical block 3510, lost async =
page
write
[   70.856224] Kernel panic - not syncing: DONE
[   70.857436] CPU: 2 PID: 2593 Comm: chmod Not tainted
6.4.0-rc3-00028-g848673e8c63a-dirty #12
[   70.859879] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.1-2.fc37 04/01/2014
[   70.862424] Call Trace:
[   70.863141]  <TASK>
[   70.863755]  dump_stack_lvl+0x86/0xc0
[   70.864798]  dump_stack+0x18/0x30
[   70.865750]  panic+0x4f2/0x530
[   70.866619]  jbd2_log_do_checkpoint+0x76e/0x810
[   70.867898]  __jbd2_log_wait_for_space+0x162/0x3d0
[   70.869235]  add_transaction_credits+0x194/0x480
[   70.870512]  ? kmem_cache_alloc+0x2bd/0x5c0
[   70.871665]  start_this_handle+0x14b/0x950
[   70.872787]  ? kmem_cache_alloc+0x2bd/0x5c0
[   70.873949]  jbd2__journal_start+0x105/0x200
[   70.874899]  __ext4_journal_start_sb+0x2d2/0x320
[   70.875824]  ext4_dirty_inode+0x40/0xa0
[   70.876586]  __mark_inode_dirty+0x93/0x720
[   70.877397]  ext4_setattr+0x1a6/0xf30
[   70.878170]  ? path_lookupat+0xc4/0x1e0
[   70.878941]  notify_change+0x46d/0x770
[   70.879675]  ? chmod_common+0x11e/0x210
[   70.880431]  chmod_common+0x11e/0x210
[   70.881181]  ? putname+0x79/0xa0
[   70.881831]  do_fchmodat+0x6b/0xe0
[   70.882504]  __x64_sys_fchmodat+0x21/0x30
[   70.883315]  do_syscall_64+0x6c/0xf0
[   70.884045]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   70.884785] RIP: 0033:0x7fb087cffdb9
[   70.885307] Code: ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f7 =
c1
ff fe ff ff 75 38 80 e5 01 75 4b 48 63 ff 89 d2 b8 0c 01 00 0
[   70.887957] RSP: 002b:00007ffddfbb7e48 EFLAGS: 00000246 ORIG_RAX:
000000000000010c
[   70.889055] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
00007fb087cffdb9
[   70.890076] RDX: 00000000000001ed RSI: 000055850a71a0f0 RDI:
ffffffffffffff9c
[   70.891086] RBP: 000055850a71a060 R08: 0000000000000000 R09:
0000000000000000
[   70.892072] R10: 0000000000000000 R11: 0000000000000246 R12:
000055850900a734
[   70.893062] R13: 000055850a71a0f0 R14: 000055850a71b320 R15:
0000000000008000
3. reboot
4. fsck.ext4 -fa /dev/sda
/dev/sda: recovering journal
/dev/sda: Unattached inode 14


/dev/sda: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
        (i.e., without -a or -p options)

Problem 2: In forget process, missed io_end check for non-dirty buffer head=
 may
corrupt the filesystem.

jbd2_journal_commit_transaction
// there are several dirty buffer heads in transaction->t_checkpoint_list
       P1         wb_workfn      P2
jbd2_journal_forget
              __block_write_full_page
               trylock_buffer(bh)
               test_clear_buffer_dirty(bh)
 if (!buffer_dirty(bh))
  __jbd2_journal_remove_checkpoint(jh)
   if (buffer_write_io_error(bh)) // false
          >> bh IO error occurs <<
                                 jbd2_log_do_checkpoint
                          jbd2_cleanup_journal_tail
                           jbd2_write_superblock

The bh won't be replayed in next mount, image becomes corrupted.

1. Apply diff_2 and compile kernel
2. sh test_2.sh
[ 3435.871701] ext4_delete_entry: assign g_bh
[ 3435.878143] mark buffer dirty
[ 3435.892735] ck wait buffer remove
[ 3436.897053] jbd2_journal_forget: wait clear dirty
[ 3437.910558] __block_write_full_page: clear buffer dirty, delay submit
[ 3437.998090] jbd2_journal_forget: wait dirty cleared
[ 3437.998628] wait checkpoint finish
[ 3438.003545] ck wait done
[ 3438.111919] __block_write_full_page: delay done
[ 3438.112992] Buffer I/O error on dev sda, logical block 3511, lost async =
page
write
[ 3438.115152] Kernel panic - not syncing: DONE
[ 3438.115513] CPU: 3 PID: 2676 Comm: chown Not tainted
6.4.0-rc3-00028-g848673e8c63a-dirty #51
[ 3438.116211] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.1-2.fc37 04/01/2014
[ 3438.116896] Call Trace:
[ 3438.117103]  <TASK>
[ 3438.117294]  dump_stack_lvl+0x86/0xc0
[ 3438.117622]  dump_stack+0x18/0x30
[ 3438.117900]  panic+0x4f2/0x530
[ 3438.118151]  jbd2_log_do_checkpoint+0x84f/0x870
[ 3438.118522]  ? do_syscall_64+0x6c/0xf0
[ 3438.118824]  __jbd2_log_wait_for_space+0x162/0x3d0
[ 3438.119222]  add_transaction_credits+0x194/0x480
[ 3438.119595]  ? kmem_cache_alloc+0x2bd/0x5c0
[ 3438.119941]  start_this_handle+0x14b/0x950
[ 3438.120272]  ? kmem_cache_alloc+0x2bd/0x5c0
[ 3438.120613]  jbd2__journal_start+0x105/0x200
[ 3438.120967]  __ext4_journal_start_sb+0x2d2/0x320
[ 3438.121341]  ext4_setattr+0x37a/0xf30
[ 3438.121649]  notify_change+0x46d/0x770
[ 3438.121955]  ? chown_common+0x1a8/0x310
[ 3438.122271]  chown_common+0x1a8/0x310
[ 3438.122566]  do_fchownat+0xfe/0x170
[ 3438.122858]  __x64_sys_fchownat+0x27/0x40
[ 3438.123190]  do_syscall_64+0x6c/0xf0
[ 3438.123488]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 3438.123920] RIP: 0033:0x7f8d29d013ca
[ 3438.124224] Code: 48 8b 0d c1 da 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 =
2e
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 04 01 00 8
[ 3438.125709] RSP: 002b:00007ffd1f18b5a8 EFLAGS: 00000246 ORIG_RAX:
0000000000000104
[ 3438.126314] RAX: ffffffffffffffda RBX: 00007ffd1f18b7f0 RCX:
00007f8d29d013ca
[ 3438.126861] RDX: 000000000000004a RSI: 000055c2a2fa5070 RDI:
00000000ffffff9c
[ 3438.127421] RBP: 000055c2a2fa3d10 R08: 0000000000000000 R09:
00000000ffffffff
[ 3438.127989] R10: 00000000ffffffff R11: 0000000000000246 R12:
000055c2a2fa3d88
[ 3438.128562] R13: 00000000ffffffff R14: 00000000ffffff9c R15:
0000000000000001
[ 3438.129145]  </TASK>
[ 3438.129406] Kernel Offset: disabled
[ 3438.129697] ---[ end Kernel panic - not syncing: DONE ]---
3. reboot
4. fsck.ext4 -fn /dev/sda
e2fsck 1.43.4 (31-Jan-2017)
Warning: skipping journal recovery because doing a read-only filesystem che=
ck.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Inode 44 ref count is 1, should be 2.  Fix? no

Pass 5: Checking group summary information

/dev/sda: ********** WARNING: Filesystem still has errors **********

/dev/sda: 45/25688 files (0.0% non-contiguous), 8899/102400 blocks

Problem 3: __cp_buffer_busy checks buffer dirty after checking buffer locki=
ng
state, buffer dirty cleaning could happen between them, which leads bh remo=
ved
from checkpoint list.

jbd2_journal_commit_transaction
// there are several dirty buffer heads in transaction->t_checkpoint_list
     drop_cache     wb_workfn   P2
journal_shrink_one_cp_list
 __cp_buffer_busy
  jh->b_transaction || buffer_locked(bh)
  // returns false
             __block_write_full_page
              trylock_buffer(bh)
              test_clear_buffer_dirty(bh)
  buffer_dirty(bh) // returns false
 __jbd2_journal_remove_checkpoint
  if (buffer_write_io_error(bh)) // false
          >> bh IO error occurs <<
                                  jbd2_log_do_checkpoint
                           jbd2_cleanup_journal_tail
                            __jbd2_update_log_tail
                             jbd2_write_superblock

The bh won't be replayed in next mount, image becomes corrupted.

1. Apply diff_3 and compile kernel
2. sh test_3.sh
[   34.007674] add_dirent_to_buf: assign g_bh
[   34.019950] mark buffer dirty
[   34.071456] __cp_buffer_busy: wait clear dirty
[   35.094103] __block_write_full_page: clear buffer dirty, delay submit
[   35.174522] __cp_buffer_busy: wait dirty cleared
[   35.296479] __block_write_full_page: delay done
[   35.298304] Buffer I/O error on dev sda, logical block 3510, lost async =
page
write
[   36.145015] Kernel panic - not syncing: DONE
[   36.146237] CPU: 3 PID: 2814 Comm: chmod Not tainted
6.4.0-rc3-00028-g848673e8c63a-dirty #72
[   36.148486] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.1-2.fc37 04/01/2014
[   36.150848] Call Trace:
[   36.151529]  <TASK>
[   36.152112]  dump_stack_lvl+0x86/0xc0
[   36.153177]  dump_stack+0x18/0x30
[   36.154136]  panic+0x4f2/0x530
[   36.154990]  jbd2_log_do_checkpoint+0x73a/0x760
[   36.156251]  ? do_fchmodat+0x6b/0xe0
[   36.157245]  __jbd2_log_wait_for_space+0x162/0x3d0
[   36.158481]  add_transaction_credits+0x194/0x480
[   36.159376]  ? kmem_cache_alloc+0x2bd/0x5c0
[   36.160192]  start_this_handle+0x14b/0x950
[   36.160995]  ? kmem_cache_alloc+0x2bd/0x5c0
[   36.161814]  jbd2__journal_start+0x105/0x200
[   36.162654]  __ext4_journal_start_sb+0x2d2/0x320
[   36.163560]  ext4_dirty_inode+0x40/0xa0
[   36.164322]  __mark_inode_dirty+0x93/0x720
[   36.165126]  ext4_setattr+0x1a6/0xf30
[   36.165850]  ? path_lookupat+0xc4/0x1e0
[   36.166621]  notify_change+0x46d/0x770
[   36.167354]  ? chmod_common+0x11e/0x210
[   36.168069]  chmod_common+0x11e/0x210
[   36.168797]  ? putname+0x79/0xa0
[   36.169444]  do_fchmodat+0x6b/0xe0
[   36.170132]  __x64_sys_fchmodat+0x21/0x30
[   36.170924]  do_syscall_64+0x6c/0xf0
[   36.171630]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   36.172613] RIP: 0033:0x7f2dbdeffdb9
[   36.173172] Code: ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f7 =
c1
ff fe ff ff 75 38 80 e5 01 75 4b 48 63 ff 89 d2 b8 0c 01 00 0
[   36.175777] RSP: 002b:00007ffe6917fa18 EFLAGS: 00000246 ORIG_RAX:
000000000000010c
[   36.176853] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
00007f2dbdeffdb9
[   36.177854] RDX: 00000000000001ed RSI: 000055e20d17a0f0 RDI:
ffffffffffffff9c
[   36.178862] RBP: 000055e20d17a060 R08: 0000000000000000 R09:
0000000000000000
[   36.179857] R10: 0000000000000000 R11: 0000000000000246 R12:
000055e20b40a734
[   36.180867] R13: 000055e20d17a0f0 R14: 000055e20d17b320 R15:
0000000000008000
[   36.181889]  </TASK>
[   36.183237] Kernel Offset: disabled
[   36.183645] ---[ end Kernel panic - not syncing: DONE ]---
3. reboot
4. fsck.ext4 -fa /dev/sda
/dev/sda: recovering journal
/dev/sda: Unattached inode 213


/dev/sda: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
        (i.e., without -a or -p options)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
