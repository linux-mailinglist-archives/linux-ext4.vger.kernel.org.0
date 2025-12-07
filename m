Return-Path: <linux-ext4+bounces-12219-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D0DCAB514
	for <lists+linux-ext4@lfdr.de>; Sun, 07 Dec 2025 14:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98C043055BA2
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Dec 2025 13:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A07B299A96;
	Sun,  7 Dec 2025 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKF9smBa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AA22701B6
	for <linux-ext4@vger.kernel.org>; Sun,  7 Dec 2025 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765112683; cv=none; b=hqNvZIb97k6JWOjCzuNgvyepbbWqPovhwvFHkrLQnPKQFsag34R0UuQtk0M05b3O8hhPLi3Tqi7HUlceFegeI/dYaBv+u9c6/oW3STT6hP5hk2Kjrc5kVP8g7AZvNvejSoJc2R+bphGqXhaSJtlPdT4SEaXB6Gjgj8q6RLvYo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765112683; c=relaxed/simple;
	bh=suZ5RP7nk4iFu1RkIe8IPKnlQIupdZBccdvK43dhMo0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JBqarx9hKEsK85Urp+4RsfE7f7dcC/r0Fzebb3DerBOzV5Kqatpr+9LpmexMlbxmTQ5JRXJ5J/LnH6OvGbEM/kBn4MCU0ksvA24+HLiK5nyRYYEnicnD3DImadslqlBAR8NwgTNCfqgVHP0TPJBaDH7Y7SHhnAnmyTvWaEm5LFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKF9smBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F25CC4CEFB
	for <linux-ext4@vger.kernel.org>; Sun,  7 Dec 2025 13:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765112683;
	bh=suZ5RP7nk4iFu1RkIe8IPKnlQIupdZBccdvK43dhMo0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EKF9smBaFzvGVdrUtkfi6h/Jrl2Hrxwokj8Xn7pIlZPjmGzyPDtUyn/1BAB+JWuvU
	 WctDktaGcimajW+njxDxOpWqMSvMOJxc7BwMHS5QrxI14frzHzyJWpjYg5G0JiazUu
	 KsmEAZVxQDCHab60mlC5REh5Xsjb/XzHFFfmj1gI0P2ZmJGjuoUjMO5mc8ZQ19waUi
	 BvVBhgaHM5esgN+fwkmiAehQ719OaDsGGS1lB9JW70hlQtLuhsLRUEwLnQXwBd1ImR
	 6xfk1sTvaOHz5ub9AhZ1+OEizbjDX+hhdAId1IVsK8wl/XmFShP+4C+c+5eS2YqaGM
	 fG4s09Iu00xHA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2904CC41614; Sun,  7 Dec 2025 13:04:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220842] dmesg flooded with ext4 backtraces when underlying USB
 device chokes
Date: Sun, 07 Dec 2025 13:04:42 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220842-13602-aALAuJW0vv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220842-13602@https.bugzilla.kernel.org/>
References: <bug-220842-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220842

--- Comment #4 from Theodore Tso (tytso@mit.edu) ---
Linux doesn't have a way for the block layer to let the system know that
something terrible has happened to a storage device.   So whether the cause=
 is
an explosion in the data center, or hard drive head crashing into the spinn=
ing
magnetic platter at 10,000 RPM, or the user just simply carelessly pulling =
out
a USB drive, all any file system will see is a whole set of I/O errors.    =
It's
not always this noisy, but in this particular case, you got unlock and it
resulted in a whole series of messages to the log.

We can try to reduce the noise, but in general, if there are problems with =
the
underlying storage device --- fix that first.   It should be self-evident t=
hat
if there is a problem with the underlying device, (a) it shouldn't happen, =
and
(b) data will be lost.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

