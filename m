Return-Path: <linux-ext4+bounces-10460-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09A5BA5F90
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 15:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EA917DE14
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 13:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510BF2BE020;
	Sat, 27 Sep 2025 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljnMb7ao"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A891C7012
	for <linux-ext4@vger.kernel.org>; Sat, 27 Sep 2025 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758979194; cv=none; b=IiQ6pAUgdwsmzUeSMj73SIqGXxShWSEiTq0/So7kFHgbM1fsavhXPnIxTrhI982yHmc1nKkIeyJRMhMiSKmd+8lqW8i4iy8Q9MfczVh2eX1TZ3v15wgzO/x2s09gx9ZgDRGEIn4nxmIq6vH+5f3c17pxbqoAJuU5HQfzXBS8YRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758979194; c=relaxed/simple;
	bh=WngEzAI3ZqKIsNZnCY592YzoKPJASeK8xPEG1Bo7eO4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n9VWcZb39d8wITxEFK5ioq97npchbOKvie6DfjA5WdrzQkoi/WfFBjs81cpjy69eJUMxGYXeduTbZkIpfh2TMYGDiirdjShUqUzSImqNW8uS5tMm0ZoLOqLfQhIXzTuq+l8axZKs0J4C4gC43cIJlkVaxB4G+9iHqglSgLlP5Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljnMb7ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49FE5C113D0
	for <linux-ext4@vger.kernel.org>; Sat, 27 Sep 2025 13:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758979193;
	bh=WngEzAI3ZqKIsNZnCY592YzoKPJASeK8xPEG1Bo7eO4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ljnMb7aorwsYZRXaYNCofUfNm1gZSgkWcLZTLOraocLNAR3gKyMflPyjAcZRshMd8
	 l5XY4IrpO/e8ShMiroijed4ZqW9i85s3+QdIgpcT3rrCwj5wA9owiLhbaQ26nULFzQ
	 5XJ+79PWyyi3/QeS9fGLyGu4KEr9r51RuB+6IbKrMjXGUZ+YXDZsJm2OmYGD1Cmvhl
	 kccB+R48PYcZiuGhufGl5IqxasVib60cR+/ivVlMbJFFxrCnrK2XqwXNr8YRo3nC0n
	 f7gSDoK1IgI5isSRyULzr89UzsrsXYC6K6Hp57Q5HhnhOLJkbIafQTg11u9RQhgmFO
	 3k1a6vR3HM6Xw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 39B81C53BBF; Sat, 27 Sep 2025 13:19:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220594] Online defragmentation has broken in 6.16
Date: Sat, 27 Sep 2025 13:19:52 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-220594-13602-uaLNLSEc7a@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220594-13602@https.bugzilla.kernel.org/>
References: <bug-220594-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220594

--- Comment #7 from Artem S. Tashkinov (aros@gmx.com) ---
Created attachment 308721
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308721&action=3Dedit
My 6.16 configuration

I remember from the log that you sent, there were quite a lot of failures, =
over
9000 of them.

Are you sure your scripts handles this?

e4defrag -v uBlock0\@raymondhill.net.xpi; echo $?
e4defrag 1.47.2 (1-Jan-2025)
ext4 defragmentation for uBlock0@raymondhill.net.xpi
[1/1]uBlock0@raymondhill.net.xpi:         0%
        Failed to defrag with EXT4_IOC_MOVE_EXT ioctl:Success   [ NG ]
 Success:                       [0/1]
1

So, it's "successful" except it's not.

> is specific to Artem's kernel or hardware configuration.

I thought ext4 code is quite independent from the rest of the kernel and no
other kernel options can possibly affect it.

gzip -d < /proc/config.gz | grep -i ext4
CONFIG_EXT4_FS=3Dy
CONFIG_EXT4_USE_FOR_EXT2=3Dy
CONFIG_EXT4_FS_POSIX_ACL=3Dy
CONFIG_EXT4_FS_SECURITY=3Dy
# CONFIG_EXT4_DEBUG is not set

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

