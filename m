Return-Path: <linux-ext4+bounces-9725-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AAAB395B0
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 09:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4DD166E42
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 07:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADE72C3242;
	Thu, 28 Aug 2025 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMafXT/0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2457C2D3A69
	for <linux-ext4@vger.kernel.org>; Thu, 28 Aug 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366979; cv=none; b=K39wGGwJySiatkXnQTMwg9IBG7uCH05ZGDZdqaPQPk283bru9bsAZwti2jOBwZHO7sGD0dal/xBicZ7tNQKNeBKflznTb7Nrpgp4s9ohvxJ8nafp8LYH6VlAoSv8xtseCz++OzY7LwxOX1NsklyfHCuBRz7BqFuvNrYzfhHBrn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366979; c=relaxed/simple;
	bh=z/1Ct2FWOyrn7+XPQSqFnrWvGq0L6pqan/Cri2+xDEc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RhR5JiXgD9hI9FhQXsbGqwf352VlFqRKe+xtv+/+7Spgrn+jp1XHk3BEHlAouo+j3HkrCJWI9x3uiVKoaC601hfKvlEJHb/7nuWkdcV178LQYkCu/3OBwPDJsCaoAZFnYSOghfR27/HttVQ3dJcpOpNI0fRRDufR7XoHuU92Iy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMafXT/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F1CAC4CEF5
	for <linux-ext4@vger.kernel.org>; Thu, 28 Aug 2025 07:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756366978;
	bh=z/1Ct2FWOyrn7+XPQSqFnrWvGq0L6pqan/Cri2+xDEc=;
	h=From:To:Subject:Date:From;
	b=sMafXT/0j4MUbuF7vrbTUtd3brLFj1g3i5wT9b6bg3Bq7P2O/uJ/jnTxGJrnJqR7f
	 dumoGlm8w91yXGqnQQlltP4BqyhdfU/YWPYdWYKAl3Wb5o284/lgm5aOh13sblAyUJ
	 kPtT2AfMjUrXA2v2lN3wDsJbFljXcTYECR237N+hVTw+2vJ4AK+wAhirC28mkM0n1+
	 ZERRjJAEb7lqVC6s5QYe/LjsMMiUku2d2PCx0vp5sPs7A9bVJ4cDbrDyOwKmpwBq/j
	 pDy1ZVvpg1COa1jYYyZ95uylmcP85BK9AYK4W5388g1zPrCF9oQGxkwnTCO2XQgEIg
	 QWYV1nX2jtE+g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9881AC41612; Thu, 28 Aug 2025 07:42:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220506] New: INFO: task sync:4678 blocked for more than 248
 seconds.
Date: Thu, 28 Aug 2025 07:42:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext2
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220506-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220506

            Bug ID: 220506
           Summary: INFO: task sync:4678 blocked for more than 248
                    seconds.
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext2
          Assignee: fs_ext2@kernel-bugs.osdl.org
          Reporter: ionut_n2001@yahoo.com
        Regression: No

Hello Kernel Team,

I notice this today:

[  207.341680] usb 2-1: new SuperSpeed USB device number 2 using xhci_hcd
[  207.354355] usb 2-1: New USB device found, idVendor=3D0951, idProduct=3D=
1666,
bcdDevice=3D 1.10
[  207.354363] usb 2-1: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[  207.354368] usb 2-1: Product: DataTraveler 3.0
[  207.354372] usb 2-1: Manufacturer: Kingston
[  207.354376] usb 2-1: SerialNumber: E0D55E629079E410B886110E
[  207.383661] usb-storage 2-1:1.0: USB Mass Storage device detected
[  207.383881] scsi host0: usb-storage 2-1:1.0
[  207.384019] usbcore: registered new interface driver usb-storage
[  207.386872] usbcore: registered new interface driver uas
[  208.393343] scsi 0:0:0:0: Direct-Access     Kingston DataTraveler 3.0 PM=
AP
PQ: 0 ANSI: 6
[  208.393711] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  208.438871] sd 0:0:0:0: [sda] 60604416 512-byte logical blocks: (31.0
GB/28.9 GiB)
[  208.439102] sd 0:0:0:0: [sda] Write Protect is off
[  208.439109] sd 0:0:0:0: [sda] Mode Sense: 45 00 00 00
[  208.439324] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled,
doesn't support DPO or FUA
[  208.486094]  sda: sda1
[  208.486217] sd 0:0:0:0: [sda] Attached SCSI removable disk
[  208.511162] io scheduler bfq registered
[  224.197641] EXT4-fs (sda1): mounting ext2 file system using the ext4
subsystem
[  224.199581] EXT4-fs (sda1): warning: mounting unchecked fs, running e2fs=
ck
is recommended
[  224.214789] EXT4-fs (sda1): mounted filesystem
1353dba8-84bf-4bf1-b061-e67411835a8d r/w without journal. Quota mode: none.
[  496.238203] INFO: task sync:4678 blocked for more than 124 seconds.
[  496.238210]       Not tainted 6.16.3-lowlatency-sunlight1 #1
[  496.238214] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[  496.238216] task:sync            state:D stack:0     pid:4678  tgid:4678=
=20
ppid:4634   task_flags:0x400000 flags:0x00004002
[  496.238224] Call Trace:
[  496.238227]  <TASK>
[  496.238232]  ? __x64_sys_tee+0x61/0xf0
[  496.238241]  __schedule+0x410/0x1230
[  496.238249]  ? srso_alias_return_thunk+0x5/0xfbef5
[  496.238257]  ? __pfx_sync_inodes_one_sb+0x10/0x10
[  496.238262]  schedule+0x27/0xf0
[  496.238266]  wb_wait_for_completion+0x85/0xc0
[  496.238272]  ? __pfx_autoremove_wake_function+0x10/0x10
[  496.238279]  sync_inodes_sb+0xcc/0x2b0
[  496.238286]  ? srso_alias_return_thunk+0x5/0xfbef5
[  496.238293]  ? __pfx_sync_inodes_one_sb+0x10/0x10
[  496.238297]  sync_inodes_one_sb+0x1b/0x30
[  496.238302]  __iterate_supers+0xe7/0x140
[  496.238310]  iterate_supers+0x10/0x20
[  496.238315]  ksys_sync+0x41/0xb0
[  496.238320]  __do_sys_sync+0xe/0x20
[  496.238325]  x64_sys_call+0x1bbb/0x2320
[  496.238330]  do_syscall_64+0x82/0x560
[  496.238336]  ? srso_alias_return_thunk+0x5/0xfbef5
[  496.238340]  ? do_fault+0x363/0x5d0
[  496.238344]  ? ___pte_offset_map+0x1c/0x1b0
[  496.238351]  ? srso_alias_return_thunk+0x5/0xfbef5
[  496.238355]  ? __handle_mm_fault+0x851/0x1040
[  496.238365]  ? srso_alias_return_thunk+0x5/0xfbef5
[  496.238369]  ? count_memcg_events+0x19c/0x200
[  496.238375]  ? srso_alias_return_thunk+0x5/0xfbef5
[  496.238378]  ? handle_mm_fault+0x252/0x370
[  496.238384]  ? srso_alias_return_thunk+0x5/0xfbef5
[  496.238387]  ? __ct_user_enter+0x2c/0x100
[  496.238393]  ? srso_alias_return_thunk+0x5/0xfbef5
[  496.238397]  ? irqentry_exit_to_user_mode+0x167/0x270
[  496.238403]  ? srso_alias_return_thunk+0x5/0xfbef5
[  496.238406]  ? irqentry_exit+0x43/0x50
[  496.238411]  ? srso_alias_return_thunk+0x5/0xfbef5
[  496.238415]  ? exc_page_fault+0x90/0x1b0
[  496.238420]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  496.238424] RIP: 0033:0x70883651e77b
[  496.238429] RSP: 002b:00007fffd7142f98 EFLAGS: 00000246 ORIG_RAX:
00000000000000a2
[  496.238434] RAX: ffffffffffffffda RBX: 00007fffd7143178 RCX:
000070883651e77b
[  496.238437] RDX: 00007088365f7201 RSI: 00005e83c5f60050 RDI:
00007088365bc573
[  496.238439] RBP: 0000000000000001 R08: 0000000000000000 R09:
0000000000000000
[  496.238442] R10: 0000000000000004 R11: 0000000000000246 R12:
00007fffd7144ae4
[  496.238444] R13: 0000000000000000 R14: 0000000000000000 R15:
00005e83c5f5fb58
[  496.238453]  </TASK>
[  620.356703] INFO: task sync:4678 blocked for more than 248 seconds.
[  620.356709]       Not tainted 6.16.3-lowlatency-sunlight1 #1
[  620.356711] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[  620.356713] task:sync            state:D stack:0     pid:4678  tgid:4678=
=20
ppid:4634   task_flags:0x400000 flags:0x00004002
[  620.356719] Call Trace:
[  620.356721]  <TASK>
[  620.356725]  ? __x64_sys_tee+0x61/0xf0
[  620.356732]  __schedule+0x410/0x1230
[  620.356738]  ? srso_alias_return_thunk+0x5/0xfbef5
[  620.356744]  ? __pfx_sync_inodes_one_sb+0x10/0x10
[  620.356747]  schedule+0x27/0xf0
[  620.356750]  wb_wait_for_completion+0x85/0xc0
[  620.356754]  ? __pfx_autoremove_wake_function+0x10/0x10
[  620.356760]  sync_inodes_sb+0xcc/0x2b0
[  620.356764]  ? srso_alias_return_thunk+0x5/0xfbef5
[  620.356769]  ? __pfx_sync_inodes_one_sb+0x10/0x10
[  620.356772]  sync_inodes_one_sb+0x1b/0x30
[  620.356775]  __iterate_supers+0xe7/0x140
[  620.356781]  iterate_supers+0x10/0x20
[  620.356784]  ksys_sync+0x41/0xb0
[  620.356787]  __do_sys_sync+0xe/0x20
[  620.356791]  x64_sys_call+0x1bbb/0x2320
[  620.356795]  do_syscall_64+0x82/0x560
[  620.356799]  ? srso_alias_return_thunk+0x5/0xfbef5
[  620.356802]  ? do_fault+0x363/0x5d0
[  620.356806]  ? ___pte_offset_map+0x1c/0x1b0
[  620.356811]  ? srso_alias_return_thunk+0x5/0xfbef5
[  620.356814]  ? __handle_mm_fault+0x851/0x1040
[  620.356820]  ? srso_alias_return_thunk+0x5/0xfbef5
[  620.356823]  ? count_memcg_events+0x19c/0x200
[  620.356827]  ? srso_alias_return_thunk+0x5/0xfbef5
[  620.356829]  ? handle_mm_fault+0x252/0x370
[  620.356833]  ? srso_alias_return_thunk+0x5/0xfbef5
[  620.356835]  ? __ct_user_enter+0x2c/0x100
[  620.356839]  ? srso_alias_return_thunk+0x5/0xfbef5
[  620.356842]  ? irqentry_exit_to_user_mode+0x167/0x270
[  620.356846]  ? srso_alias_return_thunk+0x5/0xfbef5
[  620.356849]  ? irqentry_exit+0x43/0x50
[  620.356852]  ? srso_alias_return_thunk+0x5/0xfbef5
[  620.356854]  ? exc_page_fault+0x90/0x1b0
[  620.356858]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  620.356861] RIP: 0033:0x70883651e77b
[  620.356864] RSP: 002b:00007fffd7142f98 EFLAGS: 00000246 ORIG_RAX:
00000000000000a2
[  620.356868] RAX: ffffffffffffffda RBX: 00007fffd7143178 RCX:
000070883651e77b
[  620.356870] RDX: 00007088365f7201 RSI: 00005e83c5f60050 RDI:
00007088365bc573
[  620.356871] RBP: 0000000000000001 R08: 0000000000000000 R09:
0000000000000000
[  620.356873] R10: 0000000000000004 R11: 0000000000000246 R12:
00007fffd7144ae4
[  620.356875] R13: 0000000000000000 R14: 0000000000000000 R15:
00005e83c5f5fb58
[  620.356881]  </TASK>


/dev/sda1      ext2       29G  8.5G   19G  32%
/run/media/user1/1353dba8-84bf-4bf1-b061-e67411835a8d

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

