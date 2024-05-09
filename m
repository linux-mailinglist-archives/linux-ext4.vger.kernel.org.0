Return-Path: <linux-ext4+bounces-2428-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9068C1513
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 20:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D6A283104
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9807EEF8;
	Thu,  9 May 2024 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fri+iXU9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A57E78E
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715281060; cv=none; b=ADG2UBsHDuPgyjWhPf+QAkcUe1MbvyT3UVJ8UWlQMPS3/LwoH92cQ7kBkLKCOwfK6Civ+x2HDSgub/JLVgKeWKOuhR8Um1svWG4U1Sq4YUL116igWnyu8pQW1PLIBa1eOlY1wvCNTZ+J4ufzfY+U+/UriF4V026m81FYCe7etz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715281060; c=relaxed/simple;
	bh=6utMwkuvjjMtXn+69/ecQOrhqaXm07aEZuTAJhy2ebc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qwIAUOVNswXHCCzyhJsZywGVaDwuhNAljvEYNqcf6NS1UvPun4W//wJtICWDcNl6iK3vl1RdMKXSN4J5O8on4jSYKzIRn53klIcVAOtHV+7XoOXUQwGi9aCHyiQxIcqz8f3xR4T0EhhbmS4iv8MIIv9HAl83WC9xxhZ/uZa0EF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fri+iXU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84AE2C32783
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 18:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715281059;
	bh=6utMwkuvjjMtXn+69/ecQOrhqaXm07aEZuTAJhy2ebc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Fri+iXU9xV9cmxBFC4PD6MkGfk2nMgkD7yIMRr5h/ufTExaCBhCfz0BqTNlcESm8e
	 wsnJULa+6NlaFFcUHtH3jKYI81KyacG5LbRwMlwuSNDGIG9po1eKqxe3WKZEiecXJV
	 Vgqt/j2bOKPFD1njd0V88iWTNfF2Aeswn43pkMZyKgY0QAHSA5anIP2Nsqf1rwtTao
	 FeaXqVtH/kjFqF1MGwHYjKE3WiOljGSbhc+KMgESUHz5/5HcCay0ak0MR8eXGbB4kV
	 ZovrOaMMikY1rRNlrqWzAvopt8GpWDZCSl/ZeGq35BIwjeZxyOvlXleOM05odIbiRE
	 U2QjH6AylO+1A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 70E69C53B6F; Thu,  9 May 2024 18:57:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218822] Delete the file from the upper layer directly, the file
 will become "Stale"
Date: Thu, 09 May 2024 18:57:39 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218822-13602-XIZoODBGym@https.bugzilla.kernel.org/>
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

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Is this reproducible on mainline 6.8.9?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

