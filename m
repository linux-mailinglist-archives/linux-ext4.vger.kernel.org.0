Return-Path: <linux-ext4+bounces-3754-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59509557D0
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2024 14:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BCB283067
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2024 12:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD5214AD19;
	Sat, 17 Aug 2024 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu32GTwz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DFE335D3
	for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723898202; cv=none; b=g3nI/XLGEW6xHgDneCE4+O7DCabpxms1tw1LaSQnnfBL1xp1CedJVBzawxfYb8ZVxCWgGOdobwfTw5ZB23q+1S1bmW72n8EYbv5nICbQG5iUwkridJ0YCuZZJThMUswSLCi3LMzWQSYQsz+eCjRuIG6kgAmqE0IbkTUvDnXAC6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723898202; c=relaxed/simple;
	bh=j8A1oTkYfSISJuAk/p6LGTCod2eghHIvjrGDgTReTZE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O7vQnZ/x5I3ZYurHxDtpNGrAvISB12pAx4Q8mH9UzC716xN1FrVaH52BDcq1fHfTUr0zYSKBeLirf3WiCclTUTDq4LfXukPO9gdCbdeEik5cViTFIBf7omlvdBTvrt7UzwMB22WeSBrU1NU3fk6qTdtyYOfiLWO2BxElt9ohXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu32GTwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B21EC4AF09
	for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 12:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723898202;
	bh=j8A1oTkYfSISJuAk/p6LGTCod2eghHIvjrGDgTReTZE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Uu32GTwzmJ+8mhbSTniAZK+45dxNi3Gq/HMO5DnQXhQBLmmn9yxCj1CXWUTcvbJZD
	 Mi54gjc9ASa24x+8nOGUyc0Vr2jQ38hoQPPpZxex57YCXn8puqbYVzwqmiYNvAPaQ+
	 gYSbOK7rcihnmXiq8cgGlp2x8vNFhGdTg4ubmCt+EN74q9ZnkjtK/iwIK1uStBrm07
	 +TnH/1zDNUP2Ai63LuOq94n2X4DH/W1FjRjkd7xR5xTj7QgBoYXYknMmULFE4M/6cW
	 o5U/Y0fUBOfltzRiz2BzW83ealBemjgwbRRGC74HBHn5Qp2DAJSbV/Od5LEMKAc0gJ
	 jVw+aSLYTw8zw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1FDA0C433E5; Sat, 17 Aug 2024 12:36:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] ext4 hang when setting echo noop >
 /sys/block/sda/queue/scheduler
Date: Sat, 17 Aug 2024 12:36:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjones@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219166-13602-5utlJeiM8g@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219166-13602@https.bugzilla.kernel.org/>
References: <bug-219166-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219166

--- Comment #6 from Richard W.M. Jones (rjones@redhat.com) ---
Yes I can reproduce this inside a software emulated VM with another 6.11.0
Fedora kernel.  I will bisect this later, but for now reproduction instruct=
ions
are given below.

(1) Install a Fedora 40 virtual machine.  I used the command below but other
ways are available:

virt-builder fedora-40 --size=3D10G --root-password=3Dpassword:123456

(2) Run the VM in qemu with software emulation (TCG):

qemu-system-x86_64 -machine accel=3Dtcg -cpu qemu64 -m 4096 -drive
file=3D/var/tmp/fedora-40.qcow2,format=3Dqcow2,if=3Dvirtio

(3) Inside the VM, log in as root/123456, install fio, and update the kerne=
l:

dnf install fedora-repos-rawhide
dnf install fio
dnf update kernel
reboot

(should upgrade to 6.11.0 and boot into that kernel).

(4) Inside the VM, in one terminal run:

while true; do echo noop > /sys/block/sda/queue/scheduler 2>/dev/null ; done

(5) Inside the VM, in another terminal run fio with the following config or
similar:

[global]
name=3Dfio-rand-write
filename=3D/root/fio-rand-write
rw=3Drandwrite
bs=3D4K
numjobs=3D4
time_based
runtime=3D1h
group_reporting

[file1]
size=3D1G
ioengine=3Dlibaio
iodepth=3D64

(6) After a while the fio process ETA will start counting up (since one or =
more
threads have got stuck and are not making progress).  Also logging in is
problematic and many common commands like 'dmesg' or 'ps' hang.  I could on=
ly
recover by rebooting.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

