Return-Path: <linux-ext4+bounces-23-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0806C7EEA1E
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Nov 2023 01:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC3028114C
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Nov 2023 00:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7423D7FD;
	Fri, 17 Nov 2023 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiFXPMl6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5320EB
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 00:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89AADC433CB
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 00:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700179288;
	bh=56Mkwn50PDNzQVzqmRF2Hd28xvG/ReUAnj72IyPu8y4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SiFXPMl6h28HF95O+GmyotyPd7DsjcAp1/nQL3rsCE99CDLWHMbcJ4Xal8bvsF2ds
	 CsCKD9SVNULHftzFQm+6ZLocDxCl9K44pxEbqPzKohS/rvpo2uTVuSuRblN8mUX6ZY
	 hIhOiiTfQjrEas9uO0RjVadjoC6iYxcMXOwWr7+uRchQO1j606aXWk8ZvaHIQpe0oA
	 AUfSK09ur15aDc2jTkCcoANqzDBhke1GpUxN5rmSCtYIcZdoqhDuJoQJCM1j7d2rXY
	 zz4GSK9oL6+yu1GfL5oa8zPKlgCTm0JhSl1AxXsS+TG8iAN51YshktYb0HoYICv9JN
	 PQBVS5kTqzS5g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 729E7C53BD0; Fri, 17 Nov 2023 00:01:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 17 Nov 2023 00:01:28 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@eyal.emu.id.au
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-15c2DJjrxL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #32 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
Looks like a basic misunderstanding on my side, or maybe more preparation is
needed? What am I missing?

$ sudo perf probe -a "ext4_mb_find_good_group_avg_frag_lists order"
Failed to find the path for the kernel: Invalid ELF file
  Error: Failed to add events.

$ uname -a
Linux e7.eyal.emu.id.au 6.5.10-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Thu N=
ov=20
2 19:59:55 UTC 2023 x86_64 GNU/Linux

$ ls -l /boot/*6.5.10*
-rw------- 1 root root  8727059 Nov  2 11:00
/boot/System.map-6.5.10-200.fc38.x86_64
-rw-r--r-- 1 root root   264245 Nov  2 11:00
/boot/config-6.5.10-200.fc38.x86_64
-rw------- 1 root root 39368262 Nov  9 10:55
/boot/initramfs-6.5.10-200.fc38.x86_64.img
lrwxrwxrwx 1 root root       46 Nov  9 10:55
/boot/symvers-6.5.10-200.fc38.x86_64.xz ->
/lib/modules/6.5.10-200.fc38.x86_64/symvers.xz
-rwxr-xr-x 1 root root 14551752 Nov  2 11:00
/boot/vmlinuz-6.5.10-200.fc38.x86_64

I strace'd the command, and toward the end I see this (I have vmlinuz, not
vmlinux - related?).
These are the first failed 'openat()' in the trace.

openat(AT_FDCWD, "vmlinux", O_RDONLY)   =3D -1 ENOENT (No such file or dire=
ctory)
openat(AT_FDCWD, "/boot/vmlinux", O_RDONLY) =3D -1 ENOENT (No such file or
directory)
openat(AT_FDCWD, "/boot/vmlinux-6.5.10-200.fc38.x86_64", O_RDONLY) =3D -1 E=
NOENT
(No such file or directory)
openat(AT_FDCWD, "/usr/lib/debug/boot/vmlinux-6.5.10-200.fc38.x86_64",
O_RDONLY) =3D -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/lib/modules/6.5.10-200.fc38.x86_64/build/vmlinux", O_RDO=
NLY)
=3D -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/usr/lib/debug/lib/modules/6.5.10-200.fc38.x86_64/vmlinux=
",
O_RDONLY) =3D -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/usr/lib/debug/boot/vmlinux-6.5.10-200.fc38.x86_64.debug",
O_RDONLY) =3D -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD,
"/root/.debug/.build-id/d3/6a8ae40f88e310401726e275aa1940b279babd",
{st_mode=3DS_IFDIR|0755, st_size=3D4096, ...}, 0) =3D 0
openat(AT_FDCWD,
"/root/.debug/.build-id/d3/6a8ae40f88e310401726e275aa1940b279babd/kallsyms",
O_RDONLY) =3D 3

Earlier I see this open success:

newfstatat(AT_FDCWD, "/lib/modules/6.5.10-200.fc38.x86_64/vmlinuz",
{st_mode=3DS_IFREG|0755, st_size=3D14551752, ...}, 0) =3D 0

which is identical to the one in /boot.

Should I boot a different kernel type?

Remember that I am not a dev...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

