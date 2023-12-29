Return-Path: <linux-ext4+bounces-582-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1746A8202C3
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Dec 2023 00:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F361F21411
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Dec 2023 23:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD3314AA5;
	Fri, 29 Dec 2023 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyQNsDHz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389214F63
	for <linux-ext4@vger.kernel.org>; Fri, 29 Dec 2023 23:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 385F5C433CB
	for <linux-ext4@vger.kernel.org>; Fri, 29 Dec 2023 23:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703891250;
	bh=2duVuvoPrvCn98KQjlLDGM05P82l5/YUTuhjIaxVhM0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eyQNsDHzTmXx7cbGl/Fm7EaiEW4FH4LwSU/yMdUzGGdAXo3u/xgXzxsa1QvmdS0Nd
	 0VQ2hHSBv6IZEaoLFZ4V3bQQR+WlUPQXKxq8y+bofuStnEQD8mMAU4eVzSkb51HtLw
	 Lwxa4u77QNgLeU65SUIel9S8J7vkVhyAv7kRcgGtyAXOOrymk1XDJ6gG1G0BIPGwOi
	 fcH/zcK58W46GzrvzjDpVu+Nuq1VAl1M0GFBpfOzJhSn4Dov5MyJBAtuL6oo6OTcBB
	 DbkU/Ze4I530t50XwSJ0RLu2A0G3JIzYVt/3G2fvkVFB28wMX5CdLD9LQ4IY/CijS4
	 92egJKhj7yPHw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1AB61C53BC6; Fri, 29 Dec 2023 23:07:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 29 Dec 2023 23:07:29 +0000
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
Message-ID: <bug-217965-13602-SzQjGhGAga@https.bugzilla.kernel.org/>
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

--- Comment #57 from Matthew Stapleton (matthew4196@gmail.com) ---
Also, it's a bit hard to tell, but even with the patch from
https://lore.kernel.org/linux-ext4/cover.1702455010.git.ojaswin@linux.ibm.c=
om/T/#t
, I think flush might still be using more cpu compared to when I disable
ext4_mb_choose_next_group_best_avail even though it isn't stalling anymore.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

