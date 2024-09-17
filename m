Return-Path: <linux-ext4+bounces-4196-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8140497B3FE
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2024 20:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDB01F247B2
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2024 18:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D59117D377;
	Tue, 17 Sep 2024 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZWaRTGg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA4166F23
	for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2024 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726596824; cv=none; b=UwcZ4tim9fn+3aXJZac+3tfyu2XYsQvZ0k2IdB5EKWVXxRZUJ/+y8jRkslpB/zEZCZacuaLbTMD5bbjCXQYcI8U9fFvEXPQSCVq3pVqttB4B5ZXTkK0GJ7QUiXX9OPA0VcrotE+YKVdhv1GVqGMU/ra3Wpbgo/ReKj8Zqg5oMl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726596824; c=relaxed/simple;
	bh=vXBnBPLbGaxWHmrRHvdfX+ohA9Ma8pBLO6LV5VoY2Cw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bS4YG2y9UFIXzTHCErLtaKQjrIlBmXRn3Dx6G4OOjMFN8f005kpgMYj1QfajtXzPsYszML2uxy6SevqsWQ48/JXBO9cAnifsxZo6laonEiIxg6s4GMRbZ/UVUBgohemgi8hnO5NJ1eaos0i6yvAII3A0cUcEjzywTwdLckPQh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZWaRTGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B67AC4CEC5
	for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2024 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726596824;
	bh=vXBnBPLbGaxWHmrRHvdfX+ohA9Ma8pBLO6LV5VoY2Cw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dZWaRTGg6AjhqLGDN2NinTa+BqDhA6htjQVAm8F8j3z4SVXb+OqtqtxwUZyUFA+V6
	 J6rhmjUP0vPuZdgwaElkD9FMsdkY3oJSctA4iB4XyV1TUzB61gKmhkQ/qYgfuaNjXT
	 lFDEpZuZS+eXzwJ0nKEmAH+Ui/rOffFAlRSayIF1uyN215v25WoaZCtwXynRgLmAVm
	 ay84tZK7kxrZqLrVT581jKERBG7oSbZn1Qg5NgeZEMHr3MdTAYt8m0iA6CCBWjd69t
	 9gooGvVKPvTO5lZQLehDzGzPezMqffEc58Q6uHV8sc/zUhgOffWI8bDBFvCxC4o76r
	 idVvjV8Pa7NtQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1C254C53BC2; Tue, 17 Sep 2024 18:13:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219283] kernel regression with ext4 and ea_inode mount flags
 and exercising xattrs (between Linux 6.8 and 6.11)
Date: Tue, 17 Sep 2024 18:13:43 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: colin.i.king@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219283-13602-GQCYQAetRh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219283-13602@https.bugzilla.kernel.org/>
References: <bug-219283-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219283

--- Comment #7 from Colin Ian King (colin.i.king@gmail.com) ---
$ git bisect bad
0a46ef234756dca04623b7591e8ebb3440622f0b is the first bad commit
commit 0a46ef234756dca04623b7591e8ebb3440622f0b (HEAD)
Author: Jan Kara <jack@suse.cz>
Date:   Thu Mar 21 17:26:50 2024 +0100

    ext4: do not create EA inode under buffer lock

    ext4_xattr_set_entry() creates new EA inodes while holding buffer lock
    on the external xattr block. This is problematic as it nests all the
    allocation locking (which acquires locks on other buffers) under the
    buffer lock. This can even deadlock when the filesystem is corrupted and
    e.g. quota file is setup to contain xattr block as data block. Move the
    allocation of EA inode out of ext4_xattr_set_entry() into the callers.

    Reported-by: syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com
    Signed-off-by: Jan Kara <jack@suse.cz>
    Link: https://lore.kernel.org/r/20240321162657.27420-2-jack@suse.cz
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

 fs/ext4/xattr.c | 113
++++++++++++++++++++++++++++++++++---------------------------------------
 1 file changed, 53 insertions(+), 60 deletions(-)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

