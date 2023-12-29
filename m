Return-Path: <linux-ext4+bounces-577-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A91282016D
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Dec 2023 21:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BE71F22EC6
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Dec 2023 20:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CC012B8C;
	Fri, 29 Dec 2023 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJ5lmOkK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52081426F
	for <linux-ext4@vger.kernel.org>; Fri, 29 Dec 2023 20:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B467C433CC
	for <linux-ext4@vger.kernel.org>; Fri, 29 Dec 2023 20:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703882120;
	bh=p22tY2zatVL1BQfxBa+iJJqmCA753ns5cor5KFjzSBo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KJ5lmOkKSzEC6E85vlW4FhCpAw09mfOZLkQUyQlIzu8tsLfULOZfOYO4lTg34+osd
	 Lpy5prv+R5N1iKpbLEqOyt9CMIbajUVejowKITr2YdWdaRQHyyD5c4MnF/ThcqhC8V
	 tosiX4N7yAYaMhGQmB5j55tl3/0bLkufRLQEto3g7KKfJod4WzyD2FBf44Qxw8Apsv
	 WA8Pvn4qm40T4WbpOfroKFHIUicq2V/qUkdHzrvpjcwsThxRKAIsPZgMowuGvpBVf0
	 RAMYyI1jGby3Ekd1K//vLvuuKCnU1AenH1T+QLJtFGXYpQnzNTbvwTOXd2oezDZtRa
	 swlXiv0FeJXRQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F3CDDC53BD0; Fri, 29 Dec 2023 20:35:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 29 Dec 2023 20:35:19 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217965-13602-Wz4LIANCIe@https.bugzilla.kernel.org/>
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

Matthew Stapleton (matthew4196@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |matthew4196@gmail.com

--- Comment #52 from Matthew Stapleton (matthew4196@gmail.com) ---
I'm a bit late to reporting this, but it might be related to this bug repor=
t.

Since noticing this 100% cpu flush problem on my computer with a non-raid
Samsung SSD 990 PRO NMVe and kernel 6.6.3 (and now 6.6.8) I decided to do a=
 git
bisect and seemed to track down the problem to commit:
7e170922f06bf46effa7c57f6035fc463d6edc7e if that helps, although I haven't
tested if disabling CR1_5 also resolves the problem.  Running "tar xf
linux-6.6.8.tar.xz" is enough to trigger 100% cpu for a few seconds after t=
ar
is finished on my system, although it doesn't noticeably trigger the proble=
m on
my server with raid 6 and hard drives.  It also looks like my ext4 filesyst=
em
is mounting with stripe=3D32733 according to /proc/mounts, although dumpe2f=
s -h
doesn't show any stripe settings on the filesystem.

I'll try the patch and see if it fixes the problem.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

