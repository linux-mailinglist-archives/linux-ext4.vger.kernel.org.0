Return-Path: <linux-ext4+bounces-3352-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4CB938D8D
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2024 12:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B54F1C20FAB
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2024 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C2A16A39E;
	Mon, 22 Jul 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acCbsdKF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F3B3234
	for <linux-ext4@vger.kernel.org>; Mon, 22 Jul 2024 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721644414; cv=none; b=QPSRQT1ymTRZBwzUkO4utfy3IgPtHveGG8UB/ISim98bGkorweBBNV32M4jnfMugNagyEUk/AVrN2IlO8jQqaEgmwgzOrJXgW+PsP7wqnVdKEt9RqCXHlrC57z6HZQjv/PZYIcqP10pk/3CyCF7lKVxSlYf2i12521E1rUdvyb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721644414; c=relaxed/simple;
	bh=YKfXV1rjYmy///zdVnKoZdSw+VT8k24/VypD9LI0U/U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s0FOiKWn4yLB9uba3th4LCPxIrxX1Z6MljFwBnCDFzhvVD6eahDCxWKh1i5a8shxwv2yMW2unwfX9+7N1CU19jiKzkDO0PtxbHTItsSHe/DlLInDd0kioyqz5qwxU0XA5JUjk0MBKVBXkuIxE7E0MEIrBxZXI3oG0eikExYmlgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acCbsdKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E186C4AF0A
	for <linux-ext4@vger.kernel.org>; Mon, 22 Jul 2024 10:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721644413;
	bh=YKfXV1rjYmy///zdVnKoZdSw+VT8k24/VypD9LI0U/U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=acCbsdKFmO94AcYFvwK2w4XSC4Y2t6R7uKQ5e9oNnoO9PM3O3psvYgzIJXYgZ0Cly
	 F/Namge9NezzgGjmtDetRec/DU8r0tDGAUEmQ7UGpZDTL4q70sMG8XuBfbWVEsbpHP
	 16E/epzkiYP1LsaAcvdOiglDo7AucCbttKRBUu+5IytgOhZzcHBaeSMG1tUYKpSl+X
	 F8I/QfVwLbxHX4elzWmv3zLyVPSLcfuUyiKYwth+A6vRz6RJlsuYt7JUzjmYXAMS1l
	 aXoLHs0qDMQejhkSfoPNMd5AQI9PgzTS3fICHY4AJDBGCENdCeeY8DQL1QzBLrVF+k
	 5hJY7Ib2Bm37g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8398FC53BBF; Mon, 22 Jul 2024 10:33:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219072] After updating to kernel 6.10.0, one of my Western
 Digital HDD stopped working
Date: Mon, 22 Jul 2024 10:33:32 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit
Message-ID: <bug-219072-13602-JDxTy0cN6a@https.bugzilla.kernel.org/>
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
 Bisected commit-id|                            |744a56389f7398f286231e062c2
                   |                            |e63f0de01bcc6

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
Please check if this patch fixes it for you:

https://github.com/torvalds/linux/commit/be27cd64461c45a6088a91a04eba5cd44e=
1767ef

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

