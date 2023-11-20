Return-Path: <linux-ext4+bounces-35-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E227F0BC6
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Nov 2023 07:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522091C20840
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Nov 2023 06:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627DB441D;
	Mon, 20 Nov 2023 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0UzYOg2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41B3D69
	for <linux-ext4@vger.kernel.org>; Mon, 20 Nov 2023 06:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 501E7C433CA
	for <linux-ext4@vger.kernel.org>; Mon, 20 Nov 2023 06:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700460665;
	bh=aHT+f3+o16KVgc6otWhFmixjzxi22FUbh5YwcwJbEuY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s0UzYOg2yu6N6EgJZriIEu0QavUeDG3rCHWwQGps1D8vMq7cIQoC5jDneYV6P/EYI
	 9yxZGP7flAZ9wbJXXSoIJznmi3r3pmZYm8W+EAZ2BE4G7v7xXQhnpOYWvxw2tYIiBL
	 sJsGoAt1sWCsGC4PgK2LqtDCUrNYij8t9MRXejNJNq08pj9a6mZgF4y3I2gFi3s+P9
	 zAqyHL65cTH0R5+RCdh9Pk/5GoVeGzH3u81dQb4A8D9L6Vfx50/PivVhrd2GkCifjn
	 0UiQBfHD5hF9JQyRBoB1b5oEuEth2HtSSCCP+9+xwXUOrAvnA510YVay1BHQ3OvQz9
	 rlbDomKYEPANg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 34780C53BCD; Mon, 20 Nov 2023 06:11:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Mon, 20 Nov 2023 06:11:04 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ojaswin.mujoo@ibm.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-YR3zIHv1Ji@https.bugzilla.kernel.org/>
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

--- Comment #42 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hey Eyal,

stripe size can be set to 0 by remounting the FS as follows:

mount -o remount,stripe=3D0 <dev>

This should should allow us to bypass aligned allocation.

Regarding building the kernel, sure I understand your concerns.

Regarding the util of RAID array, I don't think I have enough experience
dealing with RAID devices to comment if it is normal behavior or not. Still
I'll try to look a bit more into it to see if I can think of something.

Regards,
ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

