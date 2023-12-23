Return-Path: <linux-ext4+bounces-557-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3F881D409
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Dec 2023 13:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A548D1C211FE
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Dec 2023 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5693D28E;
	Sat, 23 Dec 2023 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYgvoTiH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63199D264
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 12:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63625C433CB
	for <linux-ext4@vger.kernel.org>; Sat, 23 Dec 2023 12:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703335591;
	bh=++RFY0u6+TyRRTNlZ35PsbJVKHxefQKuIX9TMWEFvi4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kYgvoTiH0sNDMG4QMjAAbVoZJGRecRmyKjQNQBIcnQ/+Rxp9dGxJMV9EZr4w5DRF9
	 iFwwZ1cikPZpijzC0H7OodX3tmVlg7G3nX41c3lRHswdrRDFMd/jltt7XsJyjrO4we
	 3vc2UXVaHh4CKz0j8GVHbTzDs3gHCtkzLPJqOCsoAVo6NaENhXgvUTM0IRTnocjvW9
	 AoUioMwRk5aKGqogwn5KoST7Npq9Imn2Dj4emJodlyaTbmugi7Uo/agr3tt8tTpdU+
	 k25aVehracATNoseb52g5QlfboBmh+NuQohZEQesyhg8moR41d/U219L8pDjROcLN+
	 XkIlYJeetyVqQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 52751C53BCD; Sat, 23 Dec 2023 12:46:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Sat, 23 Dec 2023 12:46:30 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: glandvador@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-ImEeeNkric@https.bugzilla.kernel.org/>
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

--- Comment #49 from Eduard Kohler (glandvador@yahoo.com) ---
Hi Ojaswin,

I gave a try to your patch and indeed it fixes the issue.
I started to compile a 'vanilla' 6.5.13 fedora kernel (latest available on =
F37)
and tested it, just to have a base. As expected the issue kicked in.
I added your patch, recompile it and the issue gone.

Andreas, I am positively sure that I never set/change any stride value on my
own. Mostly because I have no idea what it is and how it interacts with the=
 FS
or Raid. I don't know if it can be changed or it is one time set. So it was
chose by the tool I used to create the partition or raid or ext4 FS.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

