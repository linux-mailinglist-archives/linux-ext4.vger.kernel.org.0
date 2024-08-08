Return-Path: <linux-ext4+bounces-3673-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4EB94BEC1
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Aug 2024 15:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F82B20CFD
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Aug 2024 13:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A30818CC05;
	Thu,  8 Aug 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbM41U7+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F0818E023
	for <linux-ext4@vger.kernel.org>; Thu,  8 Aug 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124875; cv=none; b=YLhX5+G42hDzgDb3tM4k4dlhm/eQ+TAcZuGT+G9AedcnqdMwQZt9W+HX1PRCcD3PwUwkDs8R1ntaZH6LbNdbQkysStbyE/p63iFFDo137eCJ2QAl0S/3Xy5xvyt1AJn+EG78b1Ao7pXSPbw3xl34iIcyB+08OzgAMsewAxxXDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124875; c=relaxed/simple;
	bh=QjOfkTxRzJjhRxuk3cd4g0aNxgOr96u/NJERBFLwa2w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jJcjLbnWSLfvcY3erM2cLw+6Gb7LGa7HstHW1Z0hzUc91cgPvAZ35lV2nYe3raUUlCtJ4/cxokp5u9vJmIFYOQtZgocGZLvpeMLVuWcp46jh83fZERxyyBapuBZvIiaLNJGKB+ldzpGLGP80T9jIe7Gh+y/Bn2I8CkFEYXmTs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbM41U7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 938D3C4AF0C
	for <linux-ext4@vger.kernel.org>; Thu,  8 Aug 2024 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723124874;
	bh=QjOfkTxRzJjhRxuk3cd4g0aNxgOr96u/NJERBFLwa2w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UbM41U7+AoSdNumbdQY3O/XxP1Cud8hhrtNU1hKGWQOYdfjc3ezu43M6SVOsVrxw+
	 R8X4qlo6ofKX9ETfT4GaquYOy2Dg3XCQgrTp0zVhSByWBVJfZcx/NORIs8b/nlT77G
	 BnBxkyyz1HjYhZMwHIXa1Myaf4Q/j3X5F/N7Z3Ir84jX5PQNUWlYFwi72UjUKEykuu
	 wXAzo8gENIksfT7n3jIgrRyjZpjdxNi7rraXRz6QYnssAZ0IN/oGe8J4Kv8JYyNoBv
	 zpQqAZIT8K1FiIhmJKHhsZq4O5Y6N/wJak88wH0g56L87QHV/AOC3BB+83Pr1n3gFL
	 e4z5rnJWuZKyw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 85A56C53BB9; Thu,  8 Aug 2024 13:47:54 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219141] nfs slow , rw error ffast write
Date: Thu, 08 Aug 2024 13:47:54 +0000
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
Message-ID: <bug-219141-13602-ONpjulKq4y@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219141-13602@https.bugzilla.kernel.org/>
References: <bug-219141-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219141

Christian Kujau (kernel@nerdbynature.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kernel@nerdbynature.de

--- Comment #1 from Christian Kujau (kernel@nerdbynature.de) ---
Analyzing performance issues can be tricky, or even impossible with so litt=
le
information to go by. Since you seem to test RC kernels, maybe try to bisect
the deadlocks and slow reads via Git bisect:
https://www.kernel.org/doc/html/latest/admin-guide/bug-bisect.html to help
debugging this one.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

