Return-Path: <linux-ext4+bounces-9812-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E37B43566
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 10:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1284216FD03
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 08:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4F12C08A1;
	Thu,  4 Sep 2025 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RV2B6yDp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF612C028A
	for <linux-ext4@vger.kernel.org>; Thu,  4 Sep 2025 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973904; cv=none; b=AzaQBpA/HWtzMYiBFdXUzNY3zKDcub1EZVs+n9a9sBr0R7W4pn1u0gbU6A5FrhNAAg3Y5Bjs9I8OU5DRyCkgIRgUF2s4Iwxy10ocBh624THt216BUXFXkOUlXD5ynZQKS1jfXQM2kqaerkQeh51NQ21gGQr5UAMZFt618J0z0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973904; c=relaxed/simple;
	bh=KePcbb82vGjhhlrjwvRzDIZ+eeTYBW98U9dGqKfvpzY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q0DKwBz3cXzm2KfTqt4vAzIgGEu8+h6cIAleUpOHcTkRHVwMdHRC11hcaTDkt1jPDzSOUhPWFT7J6YRKobvK/9i3uN0NMJUjtZrQ4U9zGH5f9qpPQFTaiUOnQfAzmMYY2Vxhc9YRGimm4YvxyBC8Sv5y4fpszral0/+sjlPuWlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RV2B6yDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA7E5C4CEF1
	for <linux-ext4@vger.kernel.org>; Thu,  4 Sep 2025 08:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756973903;
	bh=KePcbb82vGjhhlrjwvRzDIZ+eeTYBW98U9dGqKfvpzY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RV2B6yDp7i8IOIT/pDxSWHobCNj+C2ggulvQFlem7fqxKx6G5eoSYbN4SoQgXk6rV
	 XQTFiJZb7mTAbInO1vjwoKaZlEwjv9oCBcGeYwVZWDjUtgDJ2u4exAmCm3vLK0CpON
	 EkeZAol5+PXr866OznVrYzVwjCanmGWkYh4l136hLB3eYHclNJ/Y/rLtbS9j5MBNAR
	 bz4ZvUorQp0C9uGYIBqsRkvc4N/ozi4B2zkJvE3O/vODFE0j5S43HbR8UNAu/NYWb+
	 9EnF2Lhqqvo8mQq2pkMV/TTMoDmL6lL2N057bYpwTO27RrfqaZUJR2UCwBjaqcyJq2
	 E/k5cdrN78X6w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9C10AC41614; Thu,  4 Sep 2025 08:18:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220535] ext4 __jbd2_log_wait_for_space soft lockup and CPU
 stuck for 134s
Date: Thu, 04 Sep 2025 08:18:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: waxihus@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220535-13602-XIFvFDGzCU@https.bugzilla.kernel.org/>
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

--- Comment #1 from waxihus@gmail.com ---
ext4 format command:
/opt/tools/e2fsprogs/mkfs.ext4 -i 2048 -I 1024 -J size=3D4096
-Odir_index,casefold,large_dir,filetype -E encoding_flags=3Dstrict %(device=
)s -F

mount (fstab) parameters:
UUID=3D"11adf923-6482-46c1-b418-7df27f1755a1" /data/mds1 ext4
defaults,noatime,nodiratime,user_xattr,nofail,x-systemd.device-timeout=3D5 =
0 0

CPU: 2U Intel 6530
memory: DDR5 256GiB

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

