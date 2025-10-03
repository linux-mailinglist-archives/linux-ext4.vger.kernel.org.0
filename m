Return-Path: <linux-ext4+bounces-10600-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12191BB629F
	for <lists+linux-ext4@lfdr.de>; Fri, 03 Oct 2025 09:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A20423F2B
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Oct 2025 07:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4765623D7D0;
	Fri,  3 Oct 2025 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXyXpIv0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC402045B5
	for <linux-ext4@vger.kernel.org>; Fri,  3 Oct 2025 07:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476411; cv=none; b=EcM7ZrSL5BXFAgxJ5H+2mhDfjG/L2uvd7DTucc6qWhFLHSszM20/+SiK2rFEn3tTiBnGryRuuEl8oIvMmDZHKSEaVT09GvWH562IBVUpggkBlCDO9jmaemPVMK0idqsFNWFL9g2bnbWY6KAzvfeaZihK+Wgt/IfbsLPAXToD5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476411; c=relaxed/simple;
	bh=ZwjY1cC/HN9EhtofWzeviKT3h75xUU4QWrSj/K1HYrQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HWfIYZ/1dgqCeumUL32OrgodR7HgdAxHNbvy+a6RUNeFk78a1lx7A7xKCSzORE9cy1HkB5vCAwiVxRaLThDfVit9rOeqDkHMn0QxOMVM85GIpmSlk3hhauvZGOTbZ6Nf7gmN54Ee3YzP0mUZMq7OelIt0/+0IInRuCJgcdBX2wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXyXpIv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78EE8C4CEF5
	for <linux-ext4@vger.kernel.org>; Fri,  3 Oct 2025 07:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759476410;
	bh=ZwjY1cC/HN9EhtofWzeviKT3h75xUU4QWrSj/K1HYrQ=;
	h=From:To:Subject:Date:From;
	b=gXyXpIv0afGOPp5f3Z3k6EWWGwJMYZ4QVhhsV8+RTS9rNNu89FbwXHlbVMMQAuMyh
	 lvVTCOjwJDhB5RlJUrp5uDDvaRBQV38yKAe03Tl4c8EBYoONA7RUTCjwnNVsN7sOuP
	 RYF3QcsODLWgtulc62riEYjh27JG2gqLt1ta09/eRfXHXv8QjvedoKX3WsNnWTaC6X
	 UP5yumY7K7vGG0eXjyaBAfxk2P9J6dD+Yvfb6k8v8ARXVJ3idTRo2K0kHX8eA4D4jC
	 bYn2VnMCIqfxrfY4vrj4tNK22c1nrmKYe0TWUE36A2D2y2OmIT1ZbmQXinC+uRRE64
	 Oloicp8dqj5FQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 72FA7C41614; Fri,  3 Oct 2025 07:26:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220623] New: Possible deadlock, system hangs on suspend
Date: Fri, 03 Oct 2025 07:26:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: athul.krishna.kr@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-220623-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D220623

            Bug ID: 220623
           Summary: Possible deadlock, system hangs on suspend
           Product: File System
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: athul.krishna.kr@protonmail.com
        Regression: No

Created attachment 308745
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308745&action=3Dedit
Systems hangs on lid close

Device: Asus GA402RJ
Kernel: 6.16.8-arch3-1

System hangs on lid close. Not reliably reproducible. Sometimes I have to u=
se
it for 30 mins before suspending, sometimes more than an hour to replicate =
the
issue

Oct 03 00:44:17 ZephyrusG14 kernel: INFO: task systemd-sleep:58322 blocked =
for
more than 122 seconds.
Oct 03 00:44:17 ZephyrusG14 kernel:       Not tainted 6.16.8-arch3-1 #1
Oct 03 00:44:17 ZephyrusG14 kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 03 00:44:17 ZephyrusG14 kernel: task:systemd-sleep   state:D stack:0=20=
=20=20=20
pid:58322 tgid:58322 ppid:1      task_flags:0x400100 flags:0x00004002
Oct 03 00:44:17 ZephyrusG14 kernel: Call Trace:
Oct 03 00:44:17 ZephyrusG14 kernel:  <TASK>
Oct 03 00:44:17 ZephyrusG14 kernel:  __schedule+0x409/0x1330
Oct 03 00:44:17 ZephyrusG14 kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Oct 03 00:44:17 ZephyrusG14 kernel:  ? select_task_rq_fair+0x8b9/0x2190
Oct 03 00:44:17 ZephyrusG14 kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Oct 03 00:44:17 ZephyrusG14 kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Oct 03 00:44:17 ZephyrusG14 kernel:  ? mod_memcg_lruvec_state+0x1a4/0x200
Oct 03 00:44:17 ZephyrusG14 kernel:  schedule+0x27/0xd0
Oct 03 00:44:17 ZephyrusG14 kernel:  io_schedule+0x46/0x70
Oct 03 00:44:17 ZephyrusG14 kernel:  folio_wait_bit_common+0x133/0x330
Oct 03 00:44:17 ZephyrusG14 kernel:  ? __pfx_wake_page_function+0x10/0x10
Oct 03 00:44:17 ZephyrusG14 kernel:  folio_wait_writeback+0x2e/0x80
Oct 03 00:44:17 ZephyrusG14 kernel:  __filemap_fdatawait_range+0x7d/0xd0
Oct 03 00:44:17 ZephyrusG14 kernel:  filemap_fdatawait_keep_errors+0x1e/0x50
Oct 03 00:44:17 ZephyrusG14 kernel:  sync_inodes_sb+0x229/0x2b0
Oct 03 00:44:17 ZephyrusG14 kernel:  ? __pfx_sync_inodes_one_sb+0x10/0x10
Oct 03 00:44:17 ZephyrusG14 kernel:  __iterate_supers+0xdc/0x140
Oct 03 00:44:17 ZephyrusG14 kernel:  ksys_sync+0x43/0xb0
Oct 03 00:44:17 ZephyrusG14 kernel:  ksys_sync_helper+0x17/0x80
Oct 03 00:44:17 ZephyrusG14 kernel:  pm_suspend.cold+0x128/0x36b
Oct 03 00:44:17 ZephyrusG14 kernel:  state_store+0x6c/0xd0
Oct 03 00:44:17 ZephyrusG14 kernel:  kernfs_fop_write_iter+0x14d/0x200
Oct 03 00:44:17 ZephyrusG14 kernel:  vfs_write+0x25d/0x480
Oct 03 00:44:17 ZephyrusG14 kernel:  ksys_write+0x73/0xf0
Oct 03 00:44:17 ZephyrusG14 kernel:  do_syscall_64+0x81/0x970
Oct 03 00:44:17 ZephyrusG14 kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Oct 03 00:44:17 ZephyrusG14 kernel:  ? do_user_addr_fault+0x21a/0x690
Oct 03 00:44:17 ZephyrusG14 kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Oct 03 00:44:17 ZephyrusG14 kernel:  ? exc_page_fault+0x7e/0x1a0
Oct 03 00:44:17 ZephyrusG14 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x=
7e
Oct 03 00:44:17 ZephyrusG14 kernel: RIP: 0033:0x7fde89c931ce
Oct 03 00:44:17 ZephyrusG14 kernel: RSP: 002b:00007ffc481f5570 EFLAGS: 0000=
0202
ORIG_RAX: 0000000000000001
Oct 03 00:44:17 ZephyrusG14 kernel: RAX: ffffffffffffffda RBX: 000055d77271=
4310
RCX: 00007fde89c931ce
Oct 03 00:44:17 ZephyrusG14 kernel: RDX: 0000000000000004 RSI: 000055d77271=
c770
RDI: 0000000000000007
Oct 03 00:44:17 ZephyrusG14 kernel: RBP: 00007ffc481f5580 R08: 000000000000=
0000
R09: 0000000000000000
Oct 03 00:44:17 ZephyrusG14 kernel: R10: 0000000000000000 R11: 000000000000=
0202
R12: 0000000000000004
Oct 03 00:44:17 ZephyrusG14 kernel: R13: 0000000000000004 R14: 000055d77271=
c770
R15: 00007ffc481f5710
Oct 03 00:44:17 ZephyrusG14 kernel:  </TASK>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

