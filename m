Return-Path: <linux-ext4+bounces-4133-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C54C977AF0
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Sep 2024 10:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2AB1F233C5
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Sep 2024 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948F31D67B4;
	Fri, 13 Sep 2024 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNW1lA0A"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DEF2E419
	for <linux-ext4@vger.kernel.org>; Fri, 13 Sep 2024 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216076; cv=none; b=c6wTXDfDvjOQbV4yLZ6TQhEqxnjskhv4MDVewRfQBOB1v1L44yV3V683B1vCrR98T3sR0oJhBUvIGvL8DqFFBKTLVegupefFCu5yZ0fMFpmmSLVu1CxuXBJ5u/aB8mgwIDnqSzzuwr8+CL1APunEAP0JVIe++LBzx2YMQrwCJpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216076; c=relaxed/simple;
	bh=tlHgUkiNRT3o1ceW+HJAaquS8UYmoJ60BYLd9ZRjwVk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VZDt4M15zZsVgR3fd4kNIOGz6to4RlhmHeCxtDXC2bmfD4zxzivMq5S0CRrkEO3r6RyRjHzIhBA8lNlhfrWb7/24Y9YGuQLODnbEK5mvN7XT5JvC7XelJtsZauniw6W2q0NJBKUn+JNmm8NbSiQTgyVICYVNR5wUlyvQCqsmp24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNW1lA0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9759EC4CECC
	for <linux-ext4@vger.kernel.org>; Fri, 13 Sep 2024 08:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726216075;
	bh=tlHgUkiNRT3o1ceW+HJAaquS8UYmoJ60BYLd9ZRjwVk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vNW1lA0AYIyEPxaFdUTFFTcRNfsmtdqg2l9EXy1p1UF1XpByn48rbXUVXeg8MxLZu
	 UUYMa3QnKs314oYBWmEg+bvhgRPIfrISMr6COAmg+f5WGf7oxv23ItZwPJoLVdleNA
	 nzI7nCm8RmF03bdDEVTiuvRshqk9wGkeFgyRsdsHR6tRH417p47bb0pzjgsdRIpXHu
	 mSXhq2JMz/92+Q3rO2cBB9ZXof/mGfwlKpEYpN1ta6rhov55+AHqVbCAr/5gWYdA3M
	 ygQUSZ5vyd2TMLE7pLpDkhuo5nUm2vHe/40vjY8DB+426fC/9wSf0QwkuEB0YuXRck
	 zSxzOoAC2TqsA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 88DCAC53BC3; Fri, 13 Sep 2024 08:27:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 202809] ext4: ext4_xattr_ibody_get:591: comm systemd-journal:
 corrupted in-inode xattr
Date: Fri, 13 Sep 2024 08:27:55 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: peanutsunless@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-202809-13602-oscyagpMLH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202809-13602@https.bugzilla.kernel.org/>
References: <bug-202809-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D202809

Gerald Boyle (peanutsunless@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |peanutsunless@gmail.com

--- Comment #6 from Gerald Boyle (peanutsunless@gmail.com) ---
The error messages you're encountering indicate that there is filesystem
corruption on your EXT4 filesystem, particularly related to extended attrib=
utes
(xattrs). To run fsck safely, unmount the filesystem. If it's your root
filesystem, you may need to use a live CD/USB or boot into single-user=20
mode.umount /dev/mmcblk1p1
fsck.ext4 -f -y /dev/mmcblk1p1
smartctl -a /dev/mmcblk1
Check system logs for additional context around the time the errors occur. =
Logs
like /var/log/syslog or /var/log/messages might provide more insights. I
noticed that a new driver is available at
http://www.ralinktech.com/ralink/Home/Support/Linux.html
https://geometrydashworld.net
Identify if there is a pattern or specific actions that correlate with the
corruption, which might help isolate the cause.  Persistent filesystem
corruption could indicate failing storage hardware. While eMMC storage is
generally reliable, it can still fail or degrade over time.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

