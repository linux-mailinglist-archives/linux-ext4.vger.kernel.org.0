Return-Path: <linux-ext4+bounces-4291-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D30984F58
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 02:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4505928497E
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 00:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EBC647;
	Wed, 25 Sep 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9a80Waz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE679C4
	for <linux-ext4@vger.kernel.org>; Wed, 25 Sep 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727223028; cv=none; b=UaWRwrmsBNUuTKHB7do0zrutRCSNrdXfUs1C5EK8lE9s4ZSCnP7O1NvYAef3U8Q6JEN74VT5ieTUqgnFDRDjLoDQVnrUMXZOXfW/YneEXk/bnt0uiZUWsUKhWLt94Rgy0G9QdtQeHjQEe/Uh5ghdg8L/elp8A3XYjcAPldFyis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727223028; c=relaxed/simple;
	bh=Qe1wj4yK4scvbOvY7I49OBTNJqTzPfd8brPM+d0f88Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZT99PgJVdeziKe7dbwZ8rcvt0wO/CeMK0k9UXYtNIzbDe6c7QUE4iAZy6QgCbfmsQ3tMRhgedI8i9S9J1iJq0rADj/WMNPS6G8UVk8us8ykUgx+JnPnGfHhzlHjQdZWI6D0Y/dqjSggce1gXgI0P5q0zEkUHGoGcJ+6/GzOvdlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9a80Waz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED6FAC4CECD
	for <linux-ext4@vger.kernel.org>; Wed, 25 Sep 2024 00:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727223028;
	bh=Qe1wj4yK4scvbOvY7I49OBTNJqTzPfd8brPM+d0f88Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=l9a80WazMlaAXjEn0WiASqQRnFmiECy4ZbmJ5sMTMwdfy292ZUSa4hTZEfBii9SbS
	 vs5aePvcejGzlaMdlmicjaOq212IavUhZH2UL8X3yrrm1fMJ3IZ96w+ikufVH4D++Q
	 LCJtCjTC3qdm5fLAZQr21Q8uFwLf6K/vEi6IxmYVsX7uSLyfxNxiZ4UsZ81gVWlnIF
	 lPIW7iqx4OIJG7L7Fl7LDTk/EcSGoy52iK5MB/mXoJDwHfA1FKrv7O4oOEF9yuJgL7
	 QBT1gACbDkVEo5044/UKujBbdP/Wfla+YXQRFYXVteKIAfe6Z4gaxtOV7clVTO+QwQ
	 pOY/cF6gUzCjA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D9DFDC53BC7; Wed, 25 Sep 2024 00:10:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219306] ext4_truncate() is being called endlessly, all the time
Date: Wed, 25 Sep 2024 00:10:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219306-13602-AiaOgRBBQP@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219306-13602@https.bugzilla.kernel.org/>
References: <bug-219306-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219306

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #2 from Theodore Tso (tytso@mit.edu) ---
It/s not true that "nothing is triggering it".   What is triggering it
systemd-journald, which is apparently calling ftruncate(2) on its log file
every single time that writes to the binary log file.  I'm not sure why
journald is calling ftruncate(2) to the size of the file, but this is causi=
ng a
call to ext4_setattr(), which is what is calling ext4_truncate.

So when you added the printk in the codepath of ext4_truncate(), this cause=
s a
kernel log to be emitted, which triggered journald, which then would write =
into
the circular log file /var/log/journal/XXXXXXXXX/system.journal.    Why it =
is
repeatedly calling ftruncate(2) in what is apparently a no-op, is unclear to
me, but this triggeres another kernel log, which triggers a journald, in an
repeated loop.

So it is was the very act of adding the printk which caused it to be printed
"all the time".    Under normal circumstances, this shouldn't be that much =
of
an issue.

Now, it is true that we could optimize ftruncate(2) for workloads that are
calling truncate very often.   Calling ext4_truncate() does involve startin=
g a
journal handle, and adding and removing the inode from the orphan list.   We
just didn't think that there would be programs calling ftruncate(2) in a ti=
ght
loop with arguments that made it effectively a no-op.    It would be possib=
le
to add a flag to the in-memory inode if it has been truncated, so that we w=
ould
know that in the case where the ftruncate(2) is a no-op, we can skip calling
ext4_truncate.  If fallocate is called on the inode with the
FALLOC_FL_KEEP_SIZE, we would clear that in-memroy flag.=20

Other ways of address this, if you really want to track how often ext4_trun=
cate
gets called without triggering the journald doom loop would be to use ftrace
and/or tracepoints instead of using printk.    This is much more efficient,
since the log is written into an in-kernel circular buffer, and is then
expanded from binary form into human-readable task without having to invoke
systemd's journald.=20=20=20

And finally, someone could reach out to the systemd developers and ask why =
they
are calling ftruncate(2) in many cases where it appears to be completely
unnecessary.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

