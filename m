Return-Path: <linux-ext4+bounces-21-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B7B7EDAB6
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Nov 2023 05:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF6AB20B7B
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Nov 2023 04:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6244D1856;
	Thu, 16 Nov 2023 04:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmDvJx7r"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D330215AA
	for <linux-ext4@vger.kernel.org>; Thu, 16 Nov 2023 04:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64BE1C433CC
	for <linux-ext4@vger.kernel.org>; Thu, 16 Nov 2023 04:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700109216;
	bh=b6lbLfrvTIJRrCszzU69lxGI+FzJ2fsPHkH+cwqTN2w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EmDvJx7rNtXX99xT53tlPA+dda9isSsVfrRwbdmSTqL6P2YjXrDUZA/UXeCH8Xtpx
	 lpau0YLivymvUPzPBf0F03g3SeainFKjzmLG94pVn1l27LKlyCh4dOfCVb1sfk9Qx7
	 1VyLmAo/TZh558d6KzfMGsXfkdQgwRL62/KRx0c1XqRuVwHxB2/e0Tn7I8yuNLIFjq
	 UhKXa1PJR4y21fjqa7jBfkIwhkKrcGDmecIXksRPFES72nMM/8fsuR4LrXa0k+YO3k
	 EeVOS9yVImuMQQu7jsBb33RSiNpxueM8XflqWSIfSAEjajDWXJZUu3m5agf4MeeqDy
	 KxucqE7W9BRfA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 53035C53BD5; Thu, 16 Nov 2023 04:33:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Thu, 16 Nov 2023 04:33:35 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@eyal.emu.id.au
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217965-13602-d0MRTFqeEE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #30 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
Created attachment 305411
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305411&action=3Dedit
perf lest logs

perf log for rsync, See comment #29

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

