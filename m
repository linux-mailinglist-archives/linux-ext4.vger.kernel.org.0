Return-Path: <linux-ext4+bounces-1758-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3750D88DA49
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Mar 2024 10:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695501C25DB8
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Mar 2024 09:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2514236AEE;
	Wed, 27 Mar 2024 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9CmZ3ql"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C99376EE
	for <linux-ext4@vger.kernel.org>; Wed, 27 Mar 2024 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531918; cv=none; b=Rel+NystCEpR6TH8npckU4CENdp6yQGSOOVKIw50c8d/7NX/PK/5BQRISAIHWKIFX3luLKsV6tmUzZoM3SlVFiU9GqGesK3pO5fLwXukpa4BShRUaW3cp4rrbAAYuQzc0yjZ38GewsTRAW/bqM7MpX2nVH7P1yUkg4PHJr6YvVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531918; c=relaxed/simple;
	bh=eglPKeNvb1PLgs64//T0GeaqYy8YRe4qjQweHR9cOI4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HtnhBVM2q20ZaScWKcPq1v+ZbjLKHVZgADTzqrerUTehgQydZbP3kJgKidkOJutvTuFWg3p8iYum33iHv85vJby3r297TLEOiWhC8xG+i7i4oYXk2gnWhZDbkfuN11RkVdEUS9erQP6f0OcKNvgOrMsnCAL0Bddz+y+eABJyVKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9CmZ3ql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22DB5C433F1
	for <linux-ext4@vger.kernel.org>; Wed, 27 Mar 2024 09:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711531918;
	bh=eglPKeNvb1PLgs64//T0GeaqYy8YRe4qjQweHR9cOI4=;
	h=From:To:Subject:Date:From;
	b=H9CmZ3qlso4Zj9kU2H9FZvNqf69m5CJaDKPNHqowgxswjfl2pMXxKDymzskSydxm3
	 g9R4+OhbUHZ71Ta9CAW50lrb6W6KraIWLoUAP7xQWMM5xB90mDivPrRIQkePPQtiIN
	 bUNHFORHzijWgpM7PDPw3+Ddqawl6+Z1IUSqe6n2kZPVLB9ypFQ2ArgUizga/JXquf
	 kItrxJCV37oHV4JKunxPww3NNREp4lq7iVpB1Y7XoNdeKyvy093iucQ5lYyoh0rC2I
	 qRMr5Oj8/sCkUcg+IHj6tDhV18UO808D/5Wsf9vhBzDl7mw9XDOgAuurhl5YHYdrc5
	 DHYWMnYeK65bQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 13D51C53BD0; Wed, 27 Mar 2024 09:31:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218648] New: ext4: previously opened file remains writeable on
 readonly ext4 filesystem; Data loss.
Date: Wed, 27 Mar 2024 09:31:57 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zsolt@integrity.hu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression
Message-ID: <bug-218648-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218648

            Bug ID: 218648
           Summary: ext4: previously opened file remains writeable on
                    readonly ext4 filesystem; Data loss.
           Product: File System
           Version: 2.5
    Kernel Version: 6.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: zsolt@integrity.hu
        Regression: No

I have a VM on KVM. The KVM image is on GlusterFS and for the test I stopped
the gluster server. If this backend goes offline, the ext4 filesystem will =
be
readonly in the VM. It's OK.

But if I have a previously opened file (for writing) in this ext4 filesyste=
m. I
can continue to write. The "ls -l" command shows, the file is growing (but =
the
modification time isn't changes anymore).
Second test: previously mmap-ed file. I can rewrite the 4k blocks on readon=
ly
ext4. Of course, this changes will be lost on reboot.

So the readonly filesystem blocked the new open for writing, but the prevou=
sly
opened file can I write, but the data will be lost.

Are these cases normal on readonly filesystem or a bug?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

