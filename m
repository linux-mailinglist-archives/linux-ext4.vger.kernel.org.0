Return-Path: <linux-ext4+bounces-580-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 026D182021E
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Dec 2023 23:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36098B2232F
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Dec 2023 22:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7FB14A98;
	Fri, 29 Dec 2023 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBV2s6Nj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3589B1428E
	for <linux-ext4@vger.kernel.org>; Fri, 29 Dec 2023 22:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B59E8C433CC
	for <linux-ext4@vger.kernel.org>; Fri, 29 Dec 2023 22:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703887861;
	bh=A74AHSOBgMwAvqXEJUGegPQKddwWDBDRNrfhqBJXliM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JBV2s6NjSOVcOPZyrXBxdEn5Qk69ZyHP3TVJxKkwaZEbMDI3AI99RKllZu/0Gocar
	 eR9pSS9ryGikL5VTrEl0NrG7Sl4EQKUPjPw3gWoSBGpBr7AjiH8zcas44Zt/R4/76U
	 /enHX0gES1RMFQxbdPkTv/8tr3FoKeZFNxr0W9ThkMb1kaNMi+B3bdA7hYISslEm1a
	 gp+ilB41GGELaevUZdl32WNigzdb7Sxp7oeMSzTh1fKD2fxWWTzuRcuLP79oQaVRQu
	 lwNI3ka9/bXFqsGrxsO5IEad4PQ1cnvAjroeLBKy5Frq/9ch1MS3MihYS6KRZEPJOY
	 CvqxyLxKEZDTg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A3E84C53BD4; Fri, 29 Dec 2023 22:11:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 29 Dec 2023 22:11:01 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matthew4196@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-iHwkOx12yp@https.bugzilla.kernel.org/>
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

--- Comment #55 from Matthew Stapleton (matthew4196@gmail.com) ---
It looks like reversing the changes made in
7e170922f06bf46effa7c57f6035fc463d6edc7e also fixed the problem (I didn't
notice before that the names were changed in the very next commit as well).=
=20=20

in fs/ext4/mballoc.c:
Commenting out new_cr =3D CR_GOAL_LEN_SLOW in function:
ext4_mb_choose_next_group_goal_fast wasn't enough to fix it so then I did t=
he
following as well which fixed the problem:
commented out the call to ext4_mb_choose_next_group_best_avail in function:
ext4_mb_choose_next_group
commented out the code to "Reset goal length to original goal length before
falling into CR_GOAL_LEN_SLOW"

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

