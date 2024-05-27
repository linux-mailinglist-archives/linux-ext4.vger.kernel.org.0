Return-Path: <linux-ext4+bounces-2657-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00EA8D0F3F
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 23:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCAF283474
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 21:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1077161319;
	Mon, 27 May 2024 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="symgDLHb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C58155C88
	for <linux-ext4@vger.kernel.org>; Mon, 27 May 2024 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716844447; cv=none; b=Wprly/Jw0V2I0YO3AlClIYzIRetUjTRs34Fz/zMKhk+ix1VL1zs2ewEVc/69HJUvqEsuw2vIY+kpg+UTGL3wNc8jqvI6kaVq+TU8a0Nj6heMANbBaB848wxhw42wy4LFAHv9zWB+0Xwq1wckakjl9GgYWtg4pKfn6+TjsDjiWT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716844447; c=relaxed/simple;
	bh=An38tODcosEUdEWlfvyErFr4EgGg6iuCQT0fMb6GROQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bQzYHv1w3AO3LLPXUibZ+2NPwxXeAEOvXT28nNnYmwexfi8+s/KQzapAdMSbpAU0GuLIFiRJ1TeLXmntyMfHsN0u3744xFc7t7rQr4HNq4jaJvrw9pSNm2JqkX0LKcJP1KCbJBv1uodfH1ntdKFiMv4M8Y/WZst81QJy8gljUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=symgDLHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D98CEC32781
	for <linux-ext4@vger.kernel.org>; Mon, 27 May 2024 21:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716844446;
	bh=An38tODcosEUdEWlfvyErFr4EgGg6iuCQT0fMb6GROQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=symgDLHbGZbhC+NO8qC3FSZ9h+t1YX7RniNTVRJeBKGfikX3mwyp9E/Xz/XAVYSnH
	 XCL/orXDXzjsL67BkVtOTZLgyOmiCegP+pojDgR/tU3v7yL+ibJRpk3yFiauWdSTWZ
	 SyPeVVrfGbnZkRqBmX5/fPJMO1R/hxXbyO0JSlFdgQ7ZlpukKkS9PX31+rxRUFDPve
	 1njDd3WWrMG+g9T9HI//imIHC+Cehwtc/VW11OsA2dgDVWJCQwZI7aYpwOHlPmHSFd
	 EAfi0kj+rBjUheNb2U2vAisTyj606jM7R6U/uuKx2VIAUOql7NAYqKEFvOjQevNcT4
	 QTFlCJ6MR1iiA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D088BC53BB0; Mon, 27 May 2024 21:14:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218850] Unexpected failure when write to a file with two file
 descriptor
Date: Mon, 27 May 2024 21:14:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc resolution
Message-ID: <bug-218850-13602-KiBqziwoL2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218850-13602@https.bugzilla.kernel.org/>
References: <bug-218850-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218850

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |tytso@mit.edu
         Resolution|---                         |INVALID

--- Comment #3 from Theodore Tso (tytso@mit.edu) ---
Hint:   check the return value of all system calls.   In particular, check =
to
see what the read(fd_b, buf_4, 73728) returns.    Check to see what the siz=
e of
the file is after write(fd_a, buf_15, 9900), and then reflect on what happe=
ns
if the read ends up hitting the end of file marker, and what the offset of =
fd_b
is after the short read when hitting EOF.

Finally, read the documentation for the O_DIRECT flag in the NOTES section =
of
the open man page[1], and understand what the requirements are for O_DIRECT
writes, in particular about the alignment requirements are of the starting
offset when performing an O_DIRECT write (or O_DIRECT) read.   Then also ch=
eck
on the errno return (for example replace the printf("write failure\n") with
perror("write").

[1] https://man7.org/linux/man-pages/man2/open.2.html

In any case, this is not a bug, and this is not a good place for you to be
asking for instruction in basic Unix system call programming.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

