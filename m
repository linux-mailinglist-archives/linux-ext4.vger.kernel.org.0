Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A72516A73
	for <lists+linux-ext4@lfdr.de>; Mon,  2 May 2022 07:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357895AbiEBF5f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 May 2022 01:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbiEBF5e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 May 2022 01:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95C83FBDB
        for <linux-ext4@vger.kernel.org>; Sun,  1 May 2022 22:54:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 269B4608D5
        for <linux-ext4@vger.kernel.org>; Mon,  2 May 2022 05:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C7A0C385AF
        for <linux-ext4@vger.kernel.org>; Mon,  2 May 2022 05:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651470844;
        bh=btIaydXkQ6xeQdhaEW812nn3zactsRRvpV5BOLCRIiU=;
        h=From:To:Subject:Date:From;
        b=hdjqcjcJ18MoXrAo9rGynE1P4+42SvJH0YHw/CVssRfQbPUHiaHcvs1YWso8J9sOj
         Ha14kxHBiyRcDrcVbHTLGrInQripJU1HJa0/wAFKP5cwKznzB0YUVGcWldYAF0q2D6
         /HQiu4RrfHiYRIU+qEwC9P3nMYiiTIhmj038rlun7FcTX+aR6PWuuSJg9T52EX96tc
         J2fUjN/hKAipbge+miAynQp6YV7HNllMtTGafJwJlHLY/rYZgZM0mRhPzMSsfUlQnA
         t8ytEE/19aU5FgTIzlMCYcXijaWGAfc0vJ0JgB6mBkr1Tctw5XkaX4nzKEqQVUUTu4
         0YkfP7w9053CA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 614EEC05FD0; Mon,  2 May 2022 05:54:04 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215931] New: kernel BUG at fs/ext4/ext4.h:3369!
Date:   Mon, 02 May 2022 05:54:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yanming@tju.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-215931-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215931

            Bug ID: 215931
           Summary: kernel BUG at fs/ext4/ext4.h:3369!
           Product: File System
           Version: 2.5
    Kernel Version: 5.17.5
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: yanming@tju.edu.cn
        Regression: No

Created attachment 300865
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300865&action=3Dedit
case.c, containing file operations to reproduce the bug

I have encountered an Ext4 bug in the kernel v5.17. When I was invoking sys=
tem
calls on a mounted directory, the kernel crashed!

I have uploaded the system call sequence as case.c, and the Ext4 image can =
be
found on google net disk
(https://drive.google.com/file/d/14-mKOKLx8Sb2Wcl388wan9e4IUV0MHL4/view?usp=
=3Dsharing).
You can reproduce the bug by running the following commands:

losetup /dev/loop0 case.img
mount -o
"data=3Dwriteback,commit=3D10,minixdf,jqfmt=3Dvfsv0,barrier=3D1,max_batch_t=
ime=3D1000,journal_ioprio=3D7,noauto_da_alloc,init_itable=3D1,discard,noblo=
ck_validity,errors=3Dremount-ro"
/dev/loop0 /root/mnt
gcc -o case case.c
./case

The kernel message is shown below:

4,889,5388370917,-;------------[ cut here ]------------
2,890,5388370920,-;kernel BUG at fs/ext4/ext4.h:3369!
4,891,5388370928,-;invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
4,892,5388370933,-;CPU: 3 PID: 2653 Comm: case Not tainted 5.17.5 #2
4,893,5388370938,-;Hardware name: Dell Inc. OptiPlex 9020/03CPWF, BIOS A14
09/14/2015
4,894,5388370940,-;RIP: 0010:ext4_free_blocks+0x1551/0x1b80
4,895,5388370948,-;Code: 7c 24 30 31 d2 41 0f b6 8f 8e 00 00 00 4c 89 ff 48=
 d3
e6 e8 71 d8 ef ff be 01 00 00 00 4c 89 ff e8 44 d5 df ff e9 3b f4 ff ff <0f=
> 0b
41 89 c1 45 85 c9 0f 84 b0 f6 ff ff e9 4c ff ff ff ff 34 24
4,896,5388370951,-;RSP: 0018:ffff88814a9ef7c0 EFLAGS: 00010206
4,897,5388370956,-;RAX: 0000000000000000 RBX: 0000000000075f89 RCX:
0000000000000004
4,898,5388370959,-;RDX: 0000000000000003 RSI: 00000000ebf12128 RDI:
ffff888170f9e040
4,899,5388370961,-;RBP: ffff888123b8a000 R08: 0000000000000001 R09:
0000000000000004
4,900,5388370964,-;R10: ffff8881d3e9c087 R11: ffffed103a7d3810 R12:
ffff8881d3e9c170
4,901,5388370967,-;R13: ffff888170f9e000 R14: dffffc0000000000 R15:
00000000ebf12129
4,902,5388370970,-;FS:  00007f5f2a5c2540(0000) GS:ffff8881d56c0000(0000)
knlGS:0000000000000000
4,903,5388370973,-;CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
4,904,5388370976,-;CR2: 000055f7bf8bb618 CR3: 000000014ae20005 CR4:
00000000001706e0
4,905,5388370978,-;Call Trace:
4,906,5388370980,-; <TASK>
4,907,5388370983,-; ? __es_shrink+0x740/0x740
4,908,5388370989,-; ? ext4_mb_new_blocks+0x3d20/0x3d20
4,909,5388370994,-; ? ext4_ind_truncate_ensure_credits+0x1bb/0x780
4,910,5388370998,-; ext4_clear_blocks+0x25e/0x3a0
4,911,5388371003,-; ext4_free_data+0x226/0x2e0
4,912,5388371007,-; ext4_ind_truncate+0x36c/0x820
4,913,5388371011,-; ? ext4_discard_preallocations+0x744/0xd60
4,914,5388371015,-; ? ext4_ind_trans_blocks+0x80/0x80
4,915,5388371019,-; ? ext4_mb_mark_bb+0x8c0/0x8c0
4,916,5388371023,-; ? down_write_killable+0x120/0x120
4,917,5388371028,-; ext4_truncate+0x542/0xee0
4,918,5388371032,-; ? unmap_mapping_pages+0xc9/0x230
4,919,5388371037,-; ? ext4_punch_hole+0xfc0/0xfc0
4,920,5388371040,-; ? down_write_killable+0x120/0x120
4,921,5388371044,-; ext4_setattr+0x1188/0x1b30
4,922,5388371048,-; ? current_time+0x93/0xf0
4,923,5388371053,-; notify_change+0x5a5/0xcc0
4,924,5388371057,-; ? down_write_killable+0x120/0x120
4,925,5388371061,-; ? do_truncate+0xeb/0x190
4,926,5388371065,-; do_truncate+0xeb/0x190
4,927,5388371068,-; ? __x64_sys_openat2+0x2a0/0x2a0
4,928,5388371072,-; ? selinux_inode_follow_link+0x210/0x210
4,929,5388371077,-; ? preempt_count_add+0x74/0x140
4,930,5388371082,-; vfs_truncate+0x2a7/0x3f0
4,931,5388371086,-; do_sys_truncate.part.0+0xda/0xf0
4,932,5388371089,-; ? vfs_truncate+0x3f0/0x3f0
4,933,5388371093,-; ? switch_fpu_return+0xec/0x1f0
4,934,5388371097,-; ? exit_to_user_mode_prepare+0x12a/0x150
4,935,5388371103,-; do_syscall_64+0x3b/0x90
4,936,5388371107,-; entry_SYSCALL_64_after_hwframe+0x44/0xae
4,937,5388371112,-;RIP: 0033:0x7f5f2a4e776d
4,938,5388371115,-;Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa=
 48
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d
01 f0 ff ff 73 01 c3 48 8b 0d f3 36 0d 00 f7 d8 64 89 01 48
4,939,5388371119,-;RSP: 002b:00007ffd0fb26fe8 EFLAGS: 00000286 ORIG_RAX:
000000000000004c
4,940,5388371123,-;RAX: ffffffffffffffda RBX: 00005616c132eb20 RCX:
00007f5f2a4e776d
4,941,5388371125,-;RDX: ffffffffffffff80 RSI: 0000000000190eb5 RDI:
00007ffd0fb2707d
4,942,5388371128,-;RBP: 00007ffd0ff272a0 R08: 00007ffd0ff27398 R09:
00007ffd0ff27398
4,943,5388371130,-;R10: 00007ffd0ff27398 R11: 0000000000000286 R12:
00005616c132e0a0
4,944,5388371133,-;R13: 00007ffd0ff27390 R14: 0000000000000000 R15:
0000000000000000
4,945,5388371136,-; </TASK>
4,946,5388371138,-;Modules linked in: x86_pkg_temp_thermal efivarfs
4,947,5388371146,-;---[ end trace 0000000000000000 ]---

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
