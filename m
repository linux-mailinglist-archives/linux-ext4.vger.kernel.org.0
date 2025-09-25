Return-Path: <linux-ext4+bounces-10423-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D59B9F2F0
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 14:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A8B32216A
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471262FFDD4;
	Thu, 25 Sep 2025 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5bYzROn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5F72FD1A1
	for <linux-ext4@vger.kernel.org>; Thu, 25 Sep 2025 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802490; cv=none; b=lzB6TbNJUkqdTmB0x5A7k+RR/qqEUtJf4pHUdJIlVkLgKrK+wvrnrrGePwh/Qq6pUeR8k7kT9N6/RjqzWz9bbhZKEwpEBmsJnkyyMFVsTcKX3Kktoiq7+LD1okL1w6KFAvkm8T6vxqVfExRithem3hZP65YsR9tBGNjBIcQeXnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802490; c=relaxed/simple;
	bh=4RmcpJi/BU7PFj/t37wxsXfJkXWf/ytyKGomB870sMw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SE2kex42WjFp49vLs4WEVI5Cwb3FxZKml2Cy1k6rJtPWhB6WgKSTA7MTXPJ+dS/iAHdXsbCe2OcCiMkA4FRzbU99xMwu9sfBfJUJYZzsBYWEIb2bp4+DXkePBZLx1k60zd85Iysgspm3zMqDlZAM6veFQwKbI6GfneoDR4iv3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5bYzROn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CEF9C113CF
	for <linux-ext4@vger.kernel.org>; Thu, 25 Sep 2025 12:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758802490;
	bh=4RmcpJi/BU7PFj/t37wxsXfJkXWf/ytyKGomB870sMw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k5bYzROnhLZAVO2cAUb8/R5/p5LM3eMcaUDf6cFFZcif4OzhMZTJ41APYg5T1zUe7
	 gQngy2zBXjGvn+ABGbtZRNm5jrN7rrsiCN9feYlcmeAcRo3vy8nbmeD5AD62CllaYz
	 2wU8m4ywTNUJnrMMXrZJTMjzQ/Ri8SEc154/CHhhffvWEO+DKxUNYvaXU2UWPS+CuS
	 nZwuaADVIPa8g24e9ZbtgptCE8k1Vm/G6zKtzimAixYWlKZYQbzqTui7jG9EAG8JWG
	 JA3+YK2wUyyKKmL4Zn2osHZ5qRkCZnNip+yJ0E4oDMDCRbryOE8mvXib9WSJkI1+tC
	 EyHL/1w7Z9Bjw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6285DC53BBF; Thu, 25 Sep 2025 12:14:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220594] Online defragmentation has broken in 6.16
Date: Thu, 25 Sep 2025 12:14:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220594-13602-PArvHkmMiI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220594-13602@https.bugzilla.kernel.org/>
References: <bug-220594-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220594

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
I see no patches in 6.16.9 or a discussion on LKML.

The bug is still valid.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

