Return-Path: <linux-ext4+bounces-4315-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42E9860D5
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 16:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC2E287C4D
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 14:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA6618CBFB;
	Wed, 25 Sep 2024 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8nmEjHp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D618CBF7
	for <linux-ext4@vger.kernel.org>; Wed, 25 Sep 2024 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271406; cv=none; b=Kh7DXpHyk/A0IinN9lAwaD2TPLO1Bg9ydjpz81KFf9t2pTXNfUu7rh+5wgzS5mlRHrqE7YTrv8gy4+wB0tOvgYttNB4/D7LSpW1kYE00igHR+E24roknA6a+o3pTZ7Xku64ZDgaYmThnQTDW4OB9Vw9qWdMf43f0Ux4Qyd5RY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271406; c=relaxed/simple;
	bh=qPx6HlnoAnDpwCBcAu31C1DXztXhsVY46wPU1/gsizA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hvS68do6+uo/cZh86GprorvqKv/CFgv3OIdKPUfU09CSSlWKbB4c4HGEt5yQfkJZl5cCJUSPE98E1fJw4Eibf7KXMfqlYCEnV24WF3gyCG5LXy3Mir1kHcuUFFx+gjgrPQHiwLSgCsdXeLAYspgo8fWQDpfojyn1k2RhqQu45EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8nmEjHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB4E3C4CEC3
	for <linux-ext4@vger.kernel.org>; Wed, 25 Sep 2024 13:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727271405;
	bh=qPx6HlnoAnDpwCBcAu31C1DXztXhsVY46wPU1/gsizA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=q8nmEjHppn3hLNEsj/ejovvA7sul9g1N4/+lY6i5okfugzTtLoHJFek5DyKr854hW
	 lDnMD8vONvcmw8mj4M681tQEX8uBtdaoQ6CHB4v1UYz/vhNvvBoyfkvAFKqHpqTzuS
	 T+Bp6n7VDBKkRECa/WnPDQ8v/1dNZjmjLeffbD6i5YYfa2/Et/IdEDfBeeKrNzoXta
	 bLuLkRfBX5BuTuNy8AWQw+lXeQxKk8KXO9cs4DkfX5ukV5nQ2dc71ybX+LQybG1486
	 J588/LPpgKR9CC3NXjVZiuaMJQt8cF1Y20P/aX+WHCCTcP68T3+Cp6fl9AA+n0KElZ
	 gdvzFLT0sTkQg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BBB85C53BC5; Wed, 25 Sep 2024 13:36:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219306] ext4_truncate() is being called endlessly, all the time
Date: Wed, 25 Sep 2024 13:36:45 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: linmaxi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219306-13602-C1RujOPSxt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219306-13602@https.bugzilla.kernel.org/>
References: <bug-219306-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219306

--- Comment #3 from Max (linmaxi@gmail.com) ---
You are right, the printk was causing the problem. I figured it using ftrac=
e.
However, I can still see how this problem can arise once there is some
(necessary) printk called along the call stack of ftruncate(2). Just for
example, in the function ext4_truncate() there is this code:=20

if(!(inode->i_state & (I_NEW|I_FREEING)))
   WARN_ON(!inode_is_locked(inode));

WARN_ON is essentially a printk. While it won't be called most of the times,
once it is, the discussed problem will appear again (until the assertion wo=
nt
be true atleast).

I will try to fix this.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

