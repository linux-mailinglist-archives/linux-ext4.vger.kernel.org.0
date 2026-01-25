Return-Path: <linux-ext4+bounces-13298-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF82OFZJdmlqOwEAu9opvQ
	(envelope-from <linux-ext4+bounces-13298-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Jan 2026 17:48:22 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E53B0817F1
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Jan 2026 17:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A27B300577A
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Jan 2026 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6FA19C566;
	Sun, 25 Jan 2026 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZ8OiiEh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427A10E3
	for <linux-ext4@vger.kernel.org>; Sun, 25 Jan 2026 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769359699; cv=none; b=X2TsG+FLTFUf7miP7LOstJv0/1af3io6Cs/chbKgrBI2La0JF5MKv8IqHskSQt09c37cbgPLjqT2A3FsT38ocV12/uEiXHNP0mkCNXtf/5x3/vKiwM/0X4ucx7iYe/x8YHlrmLd+FGB4HLx1SW0l3ClhaMwsgLLn4cb2IwGcrQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769359699; c=relaxed/simple;
	bh=9PS3a6dXkSuf3kb5qRXS58H6R4vj+QSZtypGxoUWdOI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KPgq1rvOpxTY/oGsfhzrKhCsMQaGkMsLlYat8Fy/s6DZRpyO2R9vIQcB8q0B9CLOulIE0cN7BGjmJDkaXIZARTGWiT0a+UTs1mL5lKfpT+0Y1YIJteJ+/gQm3Y4W78w8WvgUsUHAtRnVwPEK3qOI/o7fxOFKmhyCiJrjpuVGfRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZ8OiiEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 027A7C19425
	for <linux-ext4@vger.kernel.org>; Sun, 25 Jan 2026 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769359699;
	bh=9PS3a6dXkSuf3kb5qRXS58H6R4vj+QSZtypGxoUWdOI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NZ8OiiEhRB/OBVkGUXWGPF97YPZoakNXWdPNBo8zg4gFgb/LWInDrydi5G85K5WQR
	 rz0apm4yOw3cED/ImJdHw4taeGBOer8RJFdjUMcSISzZJnPE8R/94srz41RTOfISG/
	 JHcqXspqJ2Qd0FXipDISWK7+3KsFJPy4IChTbvg25FKOyUmQZqx0vzb+86cXmdkSr0
	 kMkITllAgBAT1aAEog8DCG4zd7UigT0rVONdaGnBrl6khqQ+tacycTJQM8Bj/HqCH/
	 Jvx+cU30ESbj3UHZBpZul9r48tzhJyeXgc3kShHR1coGNedv9lMuEFufFuz09hqZFf
	 o0g+bwcCCVuPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EC622C53BBF; Sun, 25 Jan 2026 16:48:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 221007] Online ext4 defragmentation fails on 'inline' files
 (feature inline_data_
Date: Sun, 25 Jan 2026 16:48:18 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel@nerdbynature.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221007-13602-cGrypAZfVd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221007-13602@https.bugzilla.kernel.org/>
References: <bug-221007-13602@https.bugzilla.kernel.org/>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[bugzilla-daemon@kernel.org,linux-ext4@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,entry:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	TAGGED_FROM(0.00)[bounces-13298-lists,linux-ext4=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: E53B0817F1
X-Rspamd-Action: no action

https://bugzilla.kernel.org/show_bug.cgi?id=3D221007

Christian Kujau (kernel@nerdbynature.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kernel@nerdbynature.de

--- Comment #1 from Christian Kujau (kernel@nerdbynature.de) ---
While not necessarily a kernel issue, it's reproducible here once the
inline_data flag is set:

-----------------------------------
$ uname -rm
6.19.0-rc6-snafu aarch64

$ pv -Ss 512m /dev/zero > test.img
$ losetup -f test.img
$ mkfs.ext4 -O inline_data -F /dev/loop0
$ mount -t ext4 /dev/loop0 /mnt/disk/
$ date > /mnt/disk/file.txt
$ ulimit -c unlimited
$ e4defrag /mnt/disk/
e4defrag 1.47.2 (1-Jan-2025)
ext4 defragmentation for directory(/mnt/disk/)
Segmentation fault (core dumped)
-----------------------------------

Some debugging output:

-----------------------------------
$ gdb -c core /usr/sbin/e4defrag
(gdb) bt
#0  0x0000aaaaca774390 in file_defrag (file=3D0xaaaadca9b7e0
"/mnt/disk/file.txt", buf=3D0xffffea194a90, flag=3D<optimized out>,
ftwbuf=3D<optimized out>) at ../../../misc/e4defrag.c:1559
#1  0x0000ffff8d041760 [PAC] in process_entry (data=3Ddata@entry=3D0xffffea=
194c08,
dir=3Ddir@entry=3D0xffffea194b80, name=3Dname@entry=3D0xaaaadca9c883 "file.=
txt",
namlen=3D<optimized out>, d_type=3D<optimized out>)
    at ../sysdeps/wordsize-64/../../io/ftw.c:472
#2  0x0000ffff8d041bc0 [PAC] in ftw_dir (data=3Ddata@entry=3D0xffffea194c08,
st=3Dst@entry=3D0xffffea194c60, old_dir=3Dold_dir@entry=3D0x0) at
../sysdeps/wordsize-64/../../io/ftw.c:551
#3  0x0000ffff8d042350 [PAC] in ftw_startup (dir=3Ddir@entry=3D0xffffea194f=
40
"/mnt/disk", is_nftw=3Dis_nftw@entry=3D1, func=3Dfunc@entry=3D0xaaaaca7736e0
<file_defrag>, descriptors=3Ddescriptors@entry=3D2000,
    flags=3Dflags@entry=3D3) at ../sysdeps/wordsize-64/../../io/ftw.c:771
#4  0x0000ffff8d042460 [PAC] in __new_nftw (path=3Dpath@entry=3D0xffffea194=
f40
"/mnt/disk", func=3Dfunc@entry=3D0xaaaaca7736e0 <file_defrag>,
descriptors=3Ddescriptors@entry=3D2000, flags=3Dflags@entry=3D3)
    at ../sysdeps/wordsize-64/../../io/ftw.c:844
#5  0x0000aaaaca7722c4 in main (argc=3D<optimized out>, argv=3D0xffffea1981=
48) at
../../../misc/e4defrag.c:1913
-----------------------------------

Recompiling the userspace tools with -g should help (and I did that on anot=
her
machine), but I can't make sense of the details shown :-\

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

