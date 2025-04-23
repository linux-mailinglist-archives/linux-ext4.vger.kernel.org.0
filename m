Return-Path: <linux-ext4+bounces-7449-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5015A99B9B
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 00:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33BC1B813F3
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 22:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEAD20F070;
	Wed, 23 Apr 2025 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlYq9gu9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600872701B1
	for <linux-ext4@vger.kernel.org>; Wed, 23 Apr 2025 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745448189; cv=none; b=TrTmrvvpvMZb+sIh34Sw05nPNYnlqAIJ0lnRlVoNQMsHB5P86q+F7rK4zA6qbE747OdlVmFImrdqTC7VrjGEzVNkYpLPJJCgobVzJs+LSLVtuQJdi77Bno9vUl0+oOz2n8fNwrguAwVVqRE9c5+73Pb89Ns98eRzeLLvoJLp3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745448189; c=relaxed/simple;
	bh=dstpqzQJkGq4q808h1QUhUr7G6TuIzk6jXnitrCn73g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OKBifOxUnxroZPlydFd4jH1LvcLFghSm5YqRzWAAiIZXq7LHcBVtpJRXj/DTIqAqWirinrplq5edIstnHyzSY2l/3BWhdo0OXBH6H4oeNVwVaMeOHkBCvpcSqB//xHQvTTbIsf1lUbH4Pqw7sk2WQYVkRRM4eOhlTV12QMNEtWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlYq9gu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7926C4CEEC
	for <linux-ext4@vger.kernel.org>; Wed, 23 Apr 2025 22:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745448188;
	bh=dstpqzQJkGq4q808h1QUhUr7G6TuIzk6jXnitrCn73g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AlYq9gu9xODX4Vb+KFZJoGGzNL3aeMsifwkkIdP/j2iq3o/nJ1QLnAU1BMwocQJb4
	 ikv8c1KHACr05M1KT8w1WyIetiLZo+nacU1slxWQoLOp/xBXFd5Zoe197Mrup2gPT7
	 ZOV4LAoEcM05CR1Arzo6iNwf/NloNQ6DpR7brhnwJL2gyRRYbBFXRAY99qtDUZq9c4
	 ajLsOs6cCgKKqoXcadQfy/NPDqIlFnflJuLJK5o97oXm9zJM48QQcMKF363FH5YZ/s
	 Eqjcdz6Ws96KP685CDP/0MLcuJJmQKBXByKDqsqORUAIq4EG425WPFF8E3o5T39jCW
	 rTZZ7v0CELu5w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BA502C41614; Wed, 23 Apr 2025 22:43:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218822] Delete the file from the upper layer directly, the file
 will become "Stale"
Date: Wed, 23 Apr 2025 22:43:08 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bretznic@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218822-13602-DtkAErO2yy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218822-13602@https.bugzilla.kernel.org/>
References: <bug-218822-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218822

Nicolas Bretz (bretznic@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bretznic@gmail.com

--- Comment #6 from Nicolas Bretz (bretznic@gmail.com) ---
Looking at this I was thinking it might not be strictly related to ext4. Sa=
me
issue happens on btrfs.

I was able to replicate it on a few machines running 6.11.0 by simply follo=
wing
the commands in the .png attachment.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

