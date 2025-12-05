Return-Path: <linux-ext4+bounces-12212-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0699FCA9774
	for <lists+linux-ext4@lfdr.de>; Fri, 05 Dec 2025 23:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 613FD3032E1E
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Dec 2025 22:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6010C29B78F;
	Fri,  5 Dec 2025 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8TZIJq3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AD526CE3B
	for <linux-ext4@vger.kernel.org>; Fri,  5 Dec 2025 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764972854; cv=none; b=Um4Nu7XkgDEZjAr4zirOwS8b3/vzlmOE/7PaaM2G7FaRFgLbw2t268OoUDue8f+zVipWnSWh6KGhwoBAbkkBM6VqvasV39/NOQQDf1H+qI4xUzQeJTPb3RWguWoGXV6tPm4q6xzNhdpu+W6DKZkQ2WSdebWsRc1glAANdp9d7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764972854; c=relaxed/simple;
	bh=+B46Dcb56p193dv3dO3my6WD+QXMQhHD5V81R6ATXzI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MZPLODQS7qY0AH0wPokUmW22HzAdV0HNiBB4Gm7kdjb2sjDXduiDuj37iuRN/rLFL6pOvkmHAswITU59vgt0XfYjgu1CYzHZgnkPU8W6TMM3erfRIygppnXiuBYdYnNEzJiwLULX3r0LNaLygIcr5rz5QC1KfJxiKbb70LW49B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8TZIJq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B300C4CEF1
	for <linux-ext4@vger.kernel.org>; Fri,  5 Dec 2025 22:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764972853;
	bh=+B46Dcb56p193dv3dO3my6WD+QXMQhHD5V81R6ATXzI=;
	h=From:To:Subject:Date:From;
	b=D8TZIJq37S2HQMelc2bQtS3yxkSm0KQqT45x2Gdc9WcOou0AN4h+lLQ6m55NYeoC7
	 yqqcZslag8GjKNw/6v72x+upFZbyGtuxXT/KYQHg8F7PGjQgO+zhChZi4h5dp5STIJ
	 mw5dwAFcKfhmq7ruqXMR4LJ7Vw1Dd/LrVlPYWXn0QEk0oHBsVgSIQ0Qd8ZVSyWWp02
	 jwP+AARVX5iT9N7Ib8Va/3Mb24FmTeZeRFoYwC8x5znrqRhEfQztsUCi4dE+JQvWkE
	 46UGYuT7Vyw1Dh2LxWLnRYAyGX/xSw7IZk9TG82idpWQ8H3V9TympUeLUn9Wge9HQw
	 AJLdEx0SyY9TA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 91C9DC41612; Fri,  5 Dec 2025 22:14:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220842] New: dmesg flooded with ext4 backtraces when underlying
 USB device chokes
Date: Fri, 05 Dec 2025 22:14:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: deweloper@wp.pl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-220842-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220842

            Bug ID: 220842
           Summary: dmesg flooded with ext4 backtraces when underlying USB
                    device chokes
           Product: File System
           Version: 2.5
          Hardware: i386
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: deweloper@wp.pl
        Regression: No

Created attachment 309006
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309006&action=3Dedit
dmesg

There's an ext4 filesystem on an =C2=B5SD card inside an USB modem's slot.
It looks like ext4 fs driver can't cope with some possibly USB-related prob=
lem
which stops the underlying device from working. Instead, it floods the kern=
el
log with various call traces like this one:

Call Trace:
 ? dump_stack_lvl+0x42/0x5c
 ? dump_stack+0xd/0x10
 ? __ext4_std_error+0x2ee/0xd38 [ext4]
 ? destroy_inode+0x4b/0x58
 ? evict+0x16a/0x174
 ? simple_inode_init_ts+0xe/0x30
 ? _raw_spin_lock+0x8/0xc
 ? simple_inode_init_ts+0xe/0x30
 ? _raw_spin_lock+0x8/0xc
 ? _atomic_dec_and_lock+0x27/0x38
 ? iput+0x10a/0x110
 ? iget_failed+0x19/0x1c
 ? __ext4_iget+0xbfd/0xc18 [ext4]
 ? ext4_search_dir+0x244/0x69c [ext4]
 ? kmem_cache_alloc_lru_noprof+0x5e/0xb4
 ? ext4_search_dir+0x602/0x69c [ext4]
 ? ext4_search_dir+0x602/0x69c [ext4]
 ? path_openat+0x443/0x81c
 ? do_filp_open+0x80/0xc0
 ? __set_open_fd+0x16/0x2c
 ? alloc_fd+0xf7/0x104
 ? do_sys_openat2+0x4e/0x7c
 ? do_sys_open+0x26/0x30
 ? __ia32_sys_open+0x17/0x1c
 ? ia32_sys_call+0x48/0x10fc
 ? do_int80_syscall_32+0x61/0xb0
 ? do_int80_syscall_32+0x9c/0xb0
 ? __schedule+0x3cf/0x3f8
 ? switch_fpu_return+0x8/0xc
 ? irqentry_exit_to_user_mode+0x65/0xec
 ? sysvec_call_function_single+0x2c/0x2c
 ? irqentry_exit+0x14/0x24
 ? sysvec_apic_timer_interrupt+0x28/0x2c
 ? entry_INT80_32+0xf0/0xf0

It happens when the filesystem is already remounted read-only. Unfortunatel=
y I
can't tell what happened before because of exhausted kernel log ring buffer.

$ mount
/dev/sdb1 on /media/sdb1 type ext4 (rw,noatime,nodiratime,resuid=3D82,commi=
t=3D60)

Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filet=
ype
needs_recovery extent 64bit flex_bg sparse_super large_file huge_file dir_n=
link
extra_isize bigalloc metadata_csum
Filesystem flags:         signed_directory_hash=20
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              975360
Block count:              15601664
Reserved block count:     0
Overhead clusters:        16124
Free blocks:              33400
Free inodes:              916292
First block:              0
Block size:               4096
Cluster size:             32768
Group descriptor size:    64
Reserved GDT blocks:      255
Blocks per group:         262144
Clusters per group:       32768
Inodes per group:         16256
Inode blocks per group:   1016
Flex block group size:    16
Filesystem created:       Thu Apr 28 11:12:46 2022
Mount count:              18
Maximum mount count:      -1
Last checked:             Sun Nov 30 00:28:18 2025
Check interval:           0 (<none>)
Lifetime writes:          4604 GB

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

