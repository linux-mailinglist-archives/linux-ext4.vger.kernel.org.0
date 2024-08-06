Return-Path: <linux-ext4+bounces-3638-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A59948DB2
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Aug 2024 13:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101DF1C2135B
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Aug 2024 11:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490CF1C2303;
	Tue,  6 Aug 2024 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3LkPrv7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63F21BD4E7
	for <linux-ext4@vger.kernel.org>; Tue,  6 Aug 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943834; cv=none; b=p2fUrC0diN/oWUFt2TaY5wewyUio4NOL/pq1JAIvFJ35NTr1/icbMlWpWxeiCPmf9pi4ze6YK/Svn8tBoK3ktQ5BOI5WAOXEzqGTSAtq/cAoTDUrRwkfp15efzmU5Sm1FKqSSMvz1LMtQzHNYLSZwT6WpRf2hDa0svNG92krX9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943834; c=relaxed/simple;
	bh=CRk4A6L2Jv4EP4i+JTIKFL7k11TRafRvtSG/bNreN10=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZY2uaCUbKU8wSN4muSFjYzxS4irjFUUM+zM0joGMo9I3yO9sqX8jkCD0lY7gIQopyqRHn6qUZFwC4H0b20AvjCs6HdLvDY/Svomh0cVpXebB0my+2KJ3QVK4IimENvRxDm4f6DcUvFC2OkzN6rvgGJyDTBtwqM2Q+/n/t7b8AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3LkPrv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C74FC4AF09
	for <linux-ext4@vger.kernel.org>; Tue,  6 Aug 2024 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722943834;
	bh=CRk4A6L2Jv4EP4i+JTIKFL7k11TRafRvtSG/bNreN10=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k3LkPrv76ti/02hTObsWrb0IlTTqj3BKGH0fcgsc6wZ07wZYVV7RNXuacAE2I25lx
	 09sEK5kY8FJmPpvpmSBsH2J+0PDq92sgyzM6onZcyOihlLJvR3tjcztjQliNy3Aqly
	 d+jcs13pgMw7W+BTch26oFJZK/UgwREro8b9nAyEYhu8RQB7stIAACHlEn7b8ORz6k
	 ctR5m84YRnkaKHo462qwBXC4CPotZcEThT3JKFFNBrPbVgIxEVsw/vocX5dzUXLVGt
	 6jvimE4j18Ijlf9xBxESjR63VyuBfm3zISiyEl3p6/+h9wvO3jtB9/YmSpufa8lXq9
	 scErDvDuSmJnQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 349F1C53B7F; Tue,  6 Aug 2024 11:30:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218596] kernel BUG at fs/ext4/extents_status.c:884
Date: Tue, 06 Aug 2024 11:30:33 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: antony.ambrose@in.bosch.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218596-13602-Oya6fgoQbn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218596-13602@https.bugzilla.kernel.org/>
References: <bug-218596-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218596

--- Comment #1 from Antony Amburose (antony.ambrose@in.bosch.com) ---
details of the issue is discussed in
https://bugzilla.kernel.org/show_bug.cgi?id=3D205197 . This is not a ext4 b=
ug. I
will close this. Thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

