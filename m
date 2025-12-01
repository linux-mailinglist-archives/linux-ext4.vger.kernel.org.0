Return-Path: <linux-ext4+bounces-12098-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D88A4C97003
	for <lists+linux-ext4@lfdr.de>; Mon, 01 Dec 2025 12:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C075A4E4332
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834F33081C1;
	Mon,  1 Dec 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVzBDW38"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167093074BA
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588614; cv=none; b=PW++YFBePTzm6ecW2BIaQQU8nplXC1HRK+evhta5euj/QbSlX6j2efRbWztzrViVSmzxPJ9N4mCsqw8q42RUTvc0h41PK706/AIaX1dvHs0JqoNxcze2CwalWXvfyGzM1I3x8UWnT1OvneO4Hz/wSctEG5vzlCOa6zlRWCaJCnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588614; c=relaxed/simple;
	bh=DIpTwOxBWwzfx8kLHagmqcFNr/CKc/nKLCQvOLgRfAg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=POmNWVgAgSA9KrA07R9HHp74foz84z3MynwLqyR9XYdqkTLuU1r8vo/oErXxQuaygFRv4JeyXeG8bSnNPFTk9uflJwz4aPdpAXwE1h5VBECdgeuODB98AJvo2mT6DsDtm2E2Fyfpl2z3d8cgARp2K6YLkZqii7GNQbJBCj5PKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVzBDW38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA014C4CEF1
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 11:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764588613;
	bh=DIpTwOxBWwzfx8kLHagmqcFNr/CKc/nKLCQvOLgRfAg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MVzBDW38Km0aTs6zraJqFVnacEC6WJxJS2jDWHWnU98Dr9qDNjaNUpsFbpjC2Cud2
	 /BMXVgb3V4WNtOOJmtTp+aBJ0lG6eth9Zc4H25Zrolf6SlpBjB8dVNIC7adGcGEfDw
	 ijaJpCJJkSCwXki8qqeKi++9OqSN8VMglUXAUyr2Vm/cQGYNtS4Rw0iMJP3UGmhIr7
	 Qw+TvWrDrhq5kxb7Sk24QNRGbB/nIursmX8aUuupOr8uErtXw0fkDQwqo91+coxfaF
	 kIVows8VUWQaUV3c4xWzMigp/23QpI0C2AHbqcYpmTOsa0eBqqYvy1J8V9efeCnDeB
	 YFD2twPj1gEDw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B879AC53BBF; Mon,  1 Dec 2025 11:30:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220818] kernel 6.8.0-88: General Protection Fault (GPF) in ext4
 while running 'umount': RIP: 0010:dentry_unlink_inode+0x52/0x150
Date: Mon, 01 Dec 2025 11:30:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DISTRO_KERNEL
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220818-13602-jfjfWfQtN8@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DISTRO_KERNEL

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Request support from your vendor.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

