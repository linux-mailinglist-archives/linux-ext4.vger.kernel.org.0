Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1FD660D42
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Jan 2023 10:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjAGJ0A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Jan 2023 04:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjAGJZ6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Jan 2023 04:25:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81313186
        for <linux-ext4@vger.kernel.org>; Sat,  7 Jan 2023 01:25:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE8360921
        for <linux-ext4@vger.kernel.org>; Sat,  7 Jan 2023 09:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8080AC433D2
        for <linux-ext4@vger.kernel.org>; Sat,  7 Jan 2023 09:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673083552;
        bh=29n59aLGnEdmf2xo5doXByrFQvDUyt60OFhHiFQPL7I=;
        h=From:To:Subject:Date:From;
        b=KuxXQDM3T4RaLSZqONq/VMhKYkDuMkVMM9sRUf+tAWmVDhHjmZQ+lMWGYw1KoaqaE
         iF863RhEb35Kfuq4wwq+Xt3H1hXAiXDIdvvwjpxJv4I97xDybizD6w3r6Z+iPgTD1c
         9EzLb+Vo5FkabFfkuJsMaX0hapL8qxUKm0YxZEGlKzOjLLU8MohF4EZPuBogPP4t63
         TjOO3lF+13wnJNgysPc/K8c4/UHhGC9UxIcVh2xinWbM7q/0vrTxNnm8JFCTvJuQxQ
         KzH6c5/C95Cfw29+9qZQ8pknbNOZofa+CUWbRm3YNPjPHWcDOYBM05J8TXS/8xSm/T
         aUONb60bhQU7w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 651CEC43142; Sat,  7 Jan 2023 09:25:52 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216898] New: jbd2: Data missing when reusing bh which is ready
 to be checkpointed
Date:   Sat, 07 Jan 2023 09:25:52 +0000
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
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216898-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216898

            Bug ID: 216898
           Summary: jbd2: Data missing when reusing bh which is ready to
                    be checkpointed
           Product: File System
           Version: 2.5
    Kernel Version: 6.2.0-rc1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: chengzhihao1@huawei.com
        Regression: No

CONFIG_EXT4_FS=3Dy
CONFIG_JBD2=3Dy

-smp 4

1. Apply diff and compile kernel
2. ./test.sh
[   95.923541] assign g_bh
[   95.961504] jbd2_journal_commit_transaction ---
[   95.962533] insert ffff88817a018680 into trans ffff888103167600
[   95.963762] mark buffer dirty
[   95.964430] jbd2_journal_commit_transaction =3D=3D=3D=3D
[   95.992262] commit ffff888103167600 chmod(1081)
[   95.993358] Do access to bh
[   96.965179] do_get_write_access: clear bh dirty
[   96.966057] do_get_write_access: wait checkpoint remove
[   98.005262] checkpoint: bh dirty bit should be cleared
[   98.006487] jbd2_log_do_checkpoint: remove from ck list
[   98.007666] commit ffff888103167600 done
[   98.008624] commit ffff888103167600 done
[   98.039452] Kernel panic - not syncing: DONE
[   98.040496] CPU: 3 PID: 1081 Comm: chmod Not tainted
6.2.0-rc1-00099-g841111e461ea-dirty #1075
[   98.042379] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc4
[   98.045305] Call Trace:
[   98.045886]  <TASK>
[   98.046368]  dump_stack_lvl+0x73/0x9f
[   98.047114]  dump_stack+0x13/0x1b
[   98.047514]  panic+0x177/0x3e9
[   98.047901]  jbd2_log_do_checkpoint.cold+0xa6/0x580
[   98.048491]  ? ext4_setattr+0x169/0x1400
[   98.048985]  __jbd2_log_wait_for_space+0x18b/0x350
[   98.049554]  add_transaction_credits+0x3fc/0x4d0
[   98.050092]  ? _raw_spin_unlock_irqrestore+0x4b/0x90
[   98.050706]  ? add_timer+0x1d2/0x380
[   98.051152]  start_this_handle+0x156/0x900
[   98.051635]  ? kmem_cache_alloc+0x4d7/0xac0
[   98.052140]  jbd2__journal_start+0x12c/0x300
[   98.052644]  __ext4_journal_start_sb+0x2a6/0x300
[   98.053191]  ext4_dirty_inode+0x3d/0xa0
[   98.053648]  __mark_inode_dirty+0x8f/0x6b0
[   98.054138]  ext4_setattr+0x169/0x1400
[   98.054590]  ? path_lookupat.isra.0+0xca/0x200
[   98.055138]  notify_change+0x672/0x9c0
[   98.055607]  ? __call_rcu_common.constprop.0+0x17f/0xa20
[   98.056212]  ? chmod_common+0x197/0x250
[   98.056648]  chmod_common+0x197/0x250
[   98.057075]  ? delete_object_full+0x2b/0x40
[   98.057578]  ? kmemleak_free+0x43/0xa0
[   98.058038]  do_fchmodat+0x6e/0xf0
[   98.058453]  __x64_sys_fchmodat+0x1e/0x30
[   98.058935]  do_syscall_64+0x35/0x80
[   98.059369]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   98.059973] RIP: 0033:0x7f344ecffdb9
[   98.060422] Code: ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f7 =
c1
ff fe ff ff 75 38 80 e5 01 75 4b 48 63 ff 89 d2 b8 0c 01 00 0
[   98.062533] RSP: 002b:00007ffd394ba888 EFLAGS: 00000246 ORIG_RAX:
000000000000010c
[   98.063422] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
00007f344ecffdb9
[   98.064275] RDX: 00000000000001ed RSI: 000055a2209ed0f0 RDI:
ffffffffffffff9c
[   98.065120] RBP: 000055a2209ed060 R08: 0000000000000000 R09:
0000000000000000
[   98.065949] R10: 0000000000000000 R11: 0000000000000246 R12:
000055a21f60a734
[   98.066765] R13: 000055a2209ed0f0 R14: 000055a2209ee320 R15:
0000000000008000
[   98.067592]  </TASK>
[   98.067942] Kernel Offset: disabled
[   98.068364] ---[ end Kernel panic - not syncing: DONE ]---

3. reboot
4. fsck.ext4 -fn /dev/sda
e2fsck 1.44.4 (18-Aug-2018)
Warning: skipping journal recovery because doing a read-only filesystem che=
ck.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Entry 'a' in / (2) has deleted/unused inode 12.  Clear? no

Entry 'a' in / (2) has an incorrect filetype (was 1, should be 0).
Fix? no

Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Inode bitmap differences:  -12
Fix? no

Free inodes count wrong (524277, counted=3D524276).
Fix? no


/dev/sda: ********** WARNING: Filesystem still has errors **********

/dev/sda: 11/524288 files (0.0% non-contiguous), 58511/2097152 blocks

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
