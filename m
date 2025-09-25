Return-Path: <linux-ext4+bounces-10426-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2390B9FFBD
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 16:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E318188E127
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C2C2C08D9;
	Thu, 25 Sep 2025 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIrvfIvF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552132BFC85
	for <linux-ext4@vger.kernel.org>; Thu, 25 Sep 2025 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810272; cv=none; b=UZ6HYorJNIRzmlCib8SQ/rHgZ38O+Sg1gHJTy/EMtUUOYvzQPbFs/w+nYcl+RuaLLg5w+BOI3/+EVQqSqeCtKVzuJ0OztBNNvJArwt2C9TeN0um2aHZgaN9qP4UuWbjvBExzokFIrXlkHve0Mh6uSgURZ2h73/7zdqDAXsqcvig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810272; c=relaxed/simple;
	bh=niGOxx+cT5izqsQRpXbD5tzSp3JjL0DQ5JCcfvpVVao=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bw+UcgBlbEziTPEsMsWmco5mFOtj7qFrq75W8miXXwgSg17seiBDccvzDoABPEqIVBiKSNLwC5GaMYAerFMm/otNIAOQrsQagPcdwYexHb7MAiuL6v78PoN4bZshZCOhayCdx7pkkWgMb+YN/L9TFXKu38IZampICpDgQU2ZKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIrvfIvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DCA02C4CEF7
	for <linux-ext4@vger.kernel.org>; Thu, 25 Sep 2025 14:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758810271;
	bh=niGOxx+cT5izqsQRpXbD5tzSp3JjL0DQ5JCcfvpVVao=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=uIrvfIvFXuRJhLJjS0dAnGxZGFEwCuV+EN/cnHe8bS8jvNvGTgxokgw6MDzSCSmEk
	 MofhttOWw6wN6fCYkLO2yi6bQaQ5PwxWeMwlQqiVOhl6KsfHTeLxT6jdnFys3ij1Nh
	 13nGi9AjSNGDEh8rXJpXaH4kw86UlYkV8GSWN4EFgbKjixiQYDA0PgRwZHSKtZsShp
	 Mju5bmXj1qslEZvZCkcYpe8oqxmeYr2ms4IqlpfIxWWlHa7K2tXF9p0V5c33sTVn2I
	 bvyDxbNKJJYjwdTAQN/mY0M9iQXXSQ+uRUfRH+5XEMrvLG5XKEfAYxvxTeZwV/rg5G
	 ByIZoe0XWJjvw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C9D87C53BBF; Thu, 25 Sep 2025 14:24:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220594] Online defragmentation has broken in 6.16
Date: Thu, 25 Sep 2025 14:24:31 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: UNREPRODUCIBLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220594-13602-vAvN5puB8w@https.bugzilla.kernel.org/>
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

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |UNREPRODUCIBLE

--- Comment #3 from Theodore Tso (tytso@mit.edu) ---
I can't reproduce the bug, so it's not valid for me....

# uname -a
Linux kvm-xfstests 6.17.0-rc4-xfstests #245 SMP PREEMPT_DYNAMIC Thu Sep 25
10:02:23 EDT 2025 x86_64 GNU/Linux

root@kvm-xfstests:/vdc# seq 1 1024 | xargs -n 1 cp /etc/motd=20
root@kvm-xfstests:/vdc# seq 1 2 1024 | xargs rm=20
root@kvm-xfstests:/vdc# cp /bin/bash .
root@kvm-xfstests:/vdc# cp /bin/netstat .
root@kvm-xfstests:/vdc# cp /bin/uniq .
root@kvm-xfstests:/vdc# seq 2 2 1024 | xargs rm=20
root@kvm-xfstests:/vdc# filefrag  *
bash: 317 extents found
lost+found: 1 extent found
netstat: 39 extents found
uniq: 1 extent found

root@kvm-xfstests:/vdc# e4defrag  *
e4defrag 1.47.2 (1-Jan-2025)
ext4 defragmentation for bash
[1/1]bash:      100%    [ OK ]
 Success:                       [1/1]
ext4 defragmentation for directory(lost+found)
Can not process "lost+found"
 "lost+found"
ext4 defragmentation for netstat
[1/1]netstat:   100%    [ OK ]
 Success:                       [1/1]
ext4 defragmentation for uniq
[1/1]uniq:      100%    [ OK ]
 Success:                       [1/1]
root@kvm-xfstests:/vdc#

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

