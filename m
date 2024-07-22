Return-Path: <linux-ext4+bounces-3357-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601CC939598
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2024 23:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0DC1C21882
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2024 21:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F573BBE3;
	Mon, 22 Jul 2024 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXNsmuDm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB681CAB5
	for <linux-ext4@vger.kernel.org>; Mon, 22 Jul 2024 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721684352; cv=none; b=GCECFdhecXAYGCpjFe5YR2FEa6Bzxvc4Kgp2B9+CDvD/0X2C2eLM6IMLXp98SKMzRCzWz3Hth2+OZS4hg1BWa8AVOHUkz4CYWjDjqKT1x7mXi6yAtrL036vBb7vKjLvMVZgW4B1jsMQXZSWYXd5Zxg9oYXbvKDDEhI8xqelz9yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721684352; c=relaxed/simple;
	bh=j4T2M50TQTlpoovfOX7m7QrvjtUwCGGBizep8hwel6g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E1/3IcMyX/HbFz0WFzHB+lrMz7rdLHjrgyVnmdD7ghshpr9qPnQIcWsx8ktHKl4Shws26nfpysFAUowt3Lkp4g92ET6bEeNTEbINjNVOA97DPygKJDw+NDgzRNni9rPTxY5JjebWb8HvH0PMYmMoYEU97p8s/kw6F4Bw13I5vX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXNsmuDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E364C4AF0B
	for <linux-ext4@vger.kernel.org>; Mon, 22 Jul 2024 21:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721684349;
	bh=j4T2M50TQTlpoovfOX7m7QrvjtUwCGGBizep8hwel6g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qXNsmuDm5ehNjrP07sRzGWCayQzHVvP5t2zArJpPsHPuJQ/7KLhZbq3tvQ1giJn7t
	 QjEjFI+jRVDvvvPs0fdqzZpm8GVR1Fw88F3GYGXWTTmek7KDiK3kE8hBbI4DnrHiO8
	 YJ9Ot5YletqsjvPt0AWKorAt3t6vmP0/CBj/PP3IlE6M74wNsszjstrPNYh3tm1InO
	 sRGa5+/ZGExSxvbuRTZq2JMDwqZIAzEwUQGzg8f6gj1nXsMjfi2P/kiSbmDrtH7wqa
	 MY7v2Y1u+mwo5MKoHjdZyUIQAHDpgJSlX3M/FdumPCBFgKzuHL/z4paNvMBzeDW8fI
	 3jsQGyXtYf05A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7D60DC53BBF; Mon, 22 Jul 2024 21:39:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219072] After updating to kernel 6.10.0, one of my Western
 Digital HDD stopped working
Date: Mon, 22 Jul 2024 21:39:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-219072-13602-fNLeImeIQY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219072-13602@https.bugzilla.kernel.org/>
References: <bug-219072-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219072

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

