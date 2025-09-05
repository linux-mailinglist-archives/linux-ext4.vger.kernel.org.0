Return-Path: <linux-ext4+bounces-9825-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6DBB4593D
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 15:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F4B3BED27
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 13:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93B9356917;
	Fri,  5 Sep 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9akS0ix"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB43570AA
	for <linux-ext4@vger.kernel.org>; Fri,  5 Sep 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079268; cv=none; b=huHqyYDVhQQQOarBsrlVPp1jfxRPez6ZKwQVscbuoS6IHbd2vi8YJYdtz2UR0JvVA4dmasp7AHxOTyCnZK/HiOvf6pUSMpD15w1dZOzdQurTl/nMZgzq6jVw07arPVSV3MTXhEQOQZhKRR+c50ht1R6rjetpZTtr3heC+/S+DNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079268; c=relaxed/simple;
	bh=F80bG8n3a5k+BPGLRbglT6TRVi5zk97aIp/EGVeqgXI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ad6DuA77Q9L99nRSfFfAqOa/DjRzwKq9XP98cGIo9FFUjhLOAJbb0hFeXkucUWYoEEGVkKHEIilA8Pa3PQaD5AKmoM3d25UxdbpX1vc8q8slP4MFZjgiFkYn08xQC9GT57sxx8oufEV+4NqUV6kPpyuWJDRX+lsN8vC/BjEwhv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9akS0ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E0EBC4CEF5
	for <linux-ext4@vger.kernel.org>; Fri,  5 Sep 2025 13:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757079268;
	bh=F80bG8n3a5k+BPGLRbglT6TRVi5zk97aIp/EGVeqgXI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f9akS0ixfN6nCu/kIED4qlirhvPenNmoxcuwC/ld/HqxJOLTCy1+IkbRuYiS3ybem
	 gfxDMjCkfgbbIasC3g79pEQ5agkbKFS90eXQ2vimTB4G9hL2a6RdcQoC0grnJICaDy
	 MKVGVWG37Cuu2+DzdoiS4rT/364JmmbJh3FIhr98DbThiNW/eL+ibpKTZocylMd3OP
	 vK3QjNT69GDNp/1dTkdt7mOXD0SbB8Vn2ebQVcR07oWsy2WxiHsyttRx0mQmZA/GMP
	 EAX9tzXsWh/1kW3Iicop2geNoLGzewJ2rkJHsWmT/jYUfW7Cia1bs7g+klEFRTacRr
	 DKOi6mToIe1nw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 302A0C53BC7; Fri,  5 Sep 2025 13:34:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220535] ext4 __jbd2_log_wait_for_space soft lockup and CPU
 stuck for 134s
Date: Fri, 05 Sep 2025 13:34:27 +0000
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
Message-ID: <bug-220535-13602-B659i5MetE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220535-13602@https.bugzilla.kernel.org/>
References: <bug-220535-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220535

Christian Kujau (kernel@nerdbynature.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kernel@nerdbynature.de

--- Comment #4 from Christian Kujau (kernel@nerdbynature.de) ---
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html ma=
y be
of help here. Please try to reproduce with the latest version and post this
backtrace here.

An untainted kernel would be helpful too I guess, see

 https://www.kernel.org/doc/html/latest/admin-guide/tainted-kernels.html

From the backtrace above:

 > Tainted: G S         OE  X  N 5.14.21-20250107.el7.x86_64

 - S if the kernel is running on a processor or system that is=20
     out of specification
 - O if an externally-built (=E2=80=9Cout-of-tree=E2=80=9D) module has been=
 loaded.
 - E if an unsigned module has been loaded in a kernel=20
     supporting module signature.
 - X Auxiliary taint, defined for and used by Linux distributors.
 - N if an in-kernel test, such as a KUnit test, has been run.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

