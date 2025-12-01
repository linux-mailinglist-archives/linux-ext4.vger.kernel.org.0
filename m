Return-Path: <linux-ext4+bounces-12095-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DCFC95769
	for <lists+linux-ext4@lfdr.de>; Mon, 01 Dec 2025 01:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A310B4E025C
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 00:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F17C249E5;
	Mon,  1 Dec 2025 00:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpBYXW+d"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D19D2032D
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764549609; cv=none; b=iLTrT9WrfMP4AOLv7CSUoXcST4q/HXX7/3D75QTYt/TbMvjh6XutEbK998UGzPyVgXEUOBq5q3oIoP3aWu0oVCcul+vHdQzL7NKAwHObJkrSsXElL76AOLpOPMagU88+xqgkazjwSJvTXypb/55mGh/7xdff5+jepuciJhlg/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764549609; c=relaxed/simple;
	bh=ErzjdPH/CPLULqJt3GXYipg+BT1ll0lgGoTRPKXF1mc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L1lTRsFoDMMeLoGJifJyLi5kVGaqiAlIF2M9QLLrtokK44EXHON21YjuTpeq5KtnYokbOZpqjtLnLsqGcdiUSzuRfAxDHXXr8Ve88Vs07Rq6HrgLTtTOLinrew/+OD613o94lqRXDE6M8GlRgFwE2Zu4x371fxp1aiH60tBxQvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpBYXW+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5646C113D0
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 00:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764549608;
	bh=ErzjdPH/CPLULqJt3GXYipg+BT1ll0lgGoTRPKXF1mc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WpBYXW+dGYxcpYkrco+hNxmeciTilXjGvdoo8y5jgnLkQQ93OxjL3AXI5gqfBuiF6
	 p2bqu/3t95v6vSsfgw0c2D0okah62CEkz3OB4pGkgSyCKEYK/+5zSGPf7X/NKkX7oH
	 p5cOs9aYoKn5CKxMObgu0Y40NNq4PHNJL+lqcb+vpNhUdLScbHLqz0DV5KUxMWSv4Q
	 zIX/uD2RdedJqrTdvxx4bUHDCblmrnNfxhM2dnG0LPB80NutIiOftUvzId/egC0zKW
	 om4nw/w5l22+WOPtmdyZKdAFU+YHmrZCud+n3r2V5WmdeTx1fJmkuXLmWMQ0xZQYnD
	 J2eKuZbPGJAKg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B0F10C41613; Mon,  1 Dec 2025 00:40:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220818] kernel 6.8.0-88: General Protection Fault (GPF) in ext4
 while running 'umount': RIP: 0010:dentry_unlink_inode+0x52/0x150
Date: Mon, 01 Dec 2025 00:40:08 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ubuntu@yendor.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc cf_kernel_version
Message-ID: <bug-220818-13602-lL3L9nHq8p@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220818-13602@https.bugzilla.kernel.org/>
References: <bug-220818-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220818

ubuntu@yendor.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ubuntu@yendor.com
     Kernel Version|                            |6.8.0-88-generic

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

