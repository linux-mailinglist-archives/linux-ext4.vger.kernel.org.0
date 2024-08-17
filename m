Return-Path: <linux-ext4+bounces-3757-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 736F195583E
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2024 15:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290361F21DD8
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2024 13:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD756154BFB;
	Sat, 17 Aug 2024 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvr1KGJJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50807153801
	for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723903102; cv=none; b=fqPgtlL2cLj2dekmvO4YBtE0fyRxnySoKnAq5penVQHuwJT4dEKEqs4RyKo1CzdfllhtVvKjW0NCk+Aws3cPHs+QWXabJy3pOIUMhWmZD+6iK7pT2AH3V5MsbRj/UGwYfnY1mVa+twgsawb7BZm9B8bd37MtVgGV5S+ekKKvvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723903102; c=relaxed/simple;
	bh=HnuSTLMas6H/W0DyQ5aJlgzq8qhuCW94xxgeUA9Z63A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vnz+trJNBrKhPs0FselJ5vGCRie7G0Fo1SxEzjraVnqYv+ykhuDP9asknZYsJLTo0h0wQnYBGj8CBIepJaaO+jpM9pOQcctUkZbeNoh6e/G4waeK/TVOd1hrV19JczQzVKwG5x3FBIXQpxga3A257A9lCFaYdMVpG1R1/wvw/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvr1KGJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFF01C4AF12
	for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 13:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723903101;
	bh=HnuSTLMas6H/W0DyQ5aJlgzq8qhuCW94xxgeUA9Z63A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Tvr1KGJJ3Z6ydMs2SKOEj2U6lueWlX3LsRaXIYB1+XM2XDJjS3aZAyCdGIK6NNGAK
	 xCyTbYkrgEOaMWpE1EUwOXIoXwR5rn00yNuWmasnLfhz8scSYyz4l1ltjXQ9aGHtzj
	 IJ+01RYceaXORitt0eTZXTEmPefKceQeuzZRO0+AogvNyFZ/t4JOHTdkGdqlCzqCkq
	 KEJQh4pzqNA6EIWIuAdQBnAS1wXINBHLh4hwD24rt1CktP9ZGFcUPjURakwdzht8sq
	 Xfi1sTPjPx7dLvDgXpwKUINNcQk8WybBNIZIkYmo+0qHh+XvVFQopL4EQ8jFeaKg3c
	 JvV94ThEsFS6g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C7887C433E5; Sat, 17 Aug 2024 13:58:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] ext4 hang when setting echo noop >
 /sys/block/sda/queue/scheduler
Date: Sat, 17 Aug 2024 13:58:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjones@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219166-13602-xaZbJzUrt1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219166-13602@https.bugzilla.kernel.org/>
References: <bug-219166-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219166

--- Comment #9 from Richard W.M. Jones (rjones@redhat.com) ---
Also this does *not* reproduce with a 6.8.5 kernel on the same VM, so I rea=
lly
do think this is a regression.

This looks like a very tedious bisect but I'll have a go if I have time lat=
er.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

