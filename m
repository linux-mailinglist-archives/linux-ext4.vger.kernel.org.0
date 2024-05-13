Return-Path: <linux-ext4+bounces-2475-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01258C41CD
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 15:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBB4B21114
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A1C152193;
	Mon, 13 May 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo7PkNFc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3C61514E5
	for <linux-ext4@vger.kernel.org>; Mon, 13 May 2024 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606648; cv=none; b=FGeYa4DxiCs22MYXSBG6oGnxanERiyzPRd/c6c7Di5pCRC0aFBqNX75bbvJ+oLDoIuQ3kC6HyAY90xSz9+QsgHZ9dYg4HNTlLbx+C/9ibxbVVBI7OPowBCKcKqnup//o+bUcCCz+edsL+OG+1izrUP39zTV/FioW8MxZxNagtSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606648; c=relaxed/simple;
	bh=fqhKo6HPqMYTm51VHzLCSvkESxES23nYzT450yLMdSs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mz3r3pgItlu+n8JODZj9goxsDXEejzBWwQff5QgG8azajrBOJgMNINKn/8fUOdxYxRgAejMGOY99PesP4Om9ogtYBB0MoPRtHYjJQOckiOEeLoONjm4/gdvfIwB5CK1G/8TUkv69rjOjVBIy/laViIh9BcNiFAytAtCd9DWnRXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo7PkNFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB2B4C32782
	for <linux-ext4@vger.kernel.org>; Mon, 13 May 2024 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715606647;
	bh=fqhKo6HPqMYTm51VHzLCSvkESxES23nYzT450yLMdSs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Jo7PkNFcY9nNdlyPcUuOUuSQIVFhlIDLyV8/7WsHUa7j6UejUMfe9ACtB6/FijMv1
	 7Jy4xuTwE/Q56O3svtMIwfI5AdDV6XWGsftOyQGrVGV8opsmcY00OsAcbtuDSPOqfj
	 lmAoATSjGC7aCKuMA+gsDhREDYEkt3enEW0mtIRjGeS2eWPPojoFjMfmz7L1PUg0q4
	 yzio/9FPDTeTZWmxa80P1cjB8u8h4nqqqnF29EKGsc4kpGuOMG/yaqgIf8ddG82Y2/
	 oIaAPxUhaG8HT94+t+g5jVMrfiY7+bPuXaxeVl6jByHmgQTQ+9S3WCChl2eZruXwAZ
	 MsV0oUey3VPOA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C147AC53B6C; Mon, 13 May 2024 13:24:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218830] lseek on closed file does not trigger an error and
 affect other files
Date: Mon, 13 May 2024 13:24:07 +0000
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
Message-ID: <bug-218830-13602-43d0TVLX5P@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218830-13602@https.bugzilla.kernel.org/>
References: <bug-218830-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218830

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |tytso@mit.edu
         Resolution|---                         |INVALID

--- Comment #1 from Theodore Tso (tytso@mit.edu) ---
This is a test/programming bug.   If you change reproduce.c so that it prin=
ts
fd_a  and fd_b, you'll see that they have the same value.   So the reason w=
hy
lseek didn't fail is because fd_a has the same integer value as fd_b --- an=
d so
lseek didn't fail and affected the current position of fd_b.

This is a documented feature of the Linux/Unix/Posix interface.   File
descriptors are small integers, and if you close a file descriptor, it rele=
ases
that integer ---- think of it as an index in an array, i.e., struct file
*fd_array[MAX_FDS].   When you call open, it will find the first NULL point=
er
in fd_array, and installs a pointer to the struct file, and returns that
integer as the file descriptor.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

