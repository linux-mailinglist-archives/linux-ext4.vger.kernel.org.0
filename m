Return-Path: <linux-ext4+bounces-2780-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 638FC8FD5CD
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 20:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01B21F247DF
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 18:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8CC73460;
	Wed,  5 Jun 2024 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOprgawY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F013C806
	for <linux-ext4@vger.kernel.org>; Wed,  5 Jun 2024 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612333; cv=none; b=cyMLyaLaw70/MF6gNkrVLZYNChW+YNy2ERrN0GJiS65pJqwrQSubjSjkFDU8YyYha5uHXu+vm+yECV/vnsHaSqiFc1mRPZKvS/It8hj7D0P0EQL8S02BtXxiRrIdd6TXyqp6KrTCso6PTT1jKE3gE1mUK3OAjfA7U2730HE3bOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612333; c=relaxed/simple;
	bh=mUIZlsQWEOZlNWqo3EVgJWR6vuxybi/QatGiuDhOYDU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tcMVPM+7+xTSyAixWINPSMX4h+2jdeTobdFl92AqyFbPGhWdR4TJO9ne6aCC7+67iM6qQMfQBYQ4cLemw/c0kERtp8wvER4yZueW04D51KKIQfQH9FJwKoDq29jUPnYOlotYEA/CKQIg+wXY+vD+z9ig49ZpqoPex3jWgA+rnVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOprgawY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39592C32781
	for <linux-ext4@vger.kernel.org>; Wed,  5 Jun 2024 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717612333;
	bh=mUIZlsQWEOZlNWqo3EVgJWR6vuxybi/QatGiuDhOYDU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vOprgawYZ1quTWN79uaorMMbZ+siF6J0vSJJMDXaK3RZ8Wiy8Pp8xTr+atx4SKTi4
	 PjFT+dKsCd327DCE5Ye9NcMlymcADv1QNb8y5XyAd8fVzwN5YdZRlR/sFcPzmrAWyP
	 C1G040oLlL2USpbrZluu+NEtN2L2sDrq54jjdANKMn00B5bn4lTVo7zVIRSm2FTojD
	 j51+bARkmUmf7So7FQWCkT1MecWtOSkCyaG0Mb/jIqjYMzR9aUyKPbEGK6D+jb58Bq
	 x1fRkAQIsplGU6IqLmgNbaZnkJ1FaNQn6zNvYW4JJSORu2ng1bbCBxU3KOJ6yYkFWr
	 6CJmko6DJSeTA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2B873C53BB0; Wed,  5 Jun 2024 18:32:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218932] Serious problem with ext4 with all kernels,
 auto-commits do not settle to block device
Date: Wed, 05 Jun 2024 18:32:12 +0000
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
Message-ID: <bug-218932-13602-O6Zx2TSx8t@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218932-13602@https.bugzilla.kernel.org/>
References: <bug-218932-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218932

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |tytso@mit.edu
         Resolution|---                         |INVALID

--- Comment #1 from Theodore Tso (tytso@mit.edu) ---
This is not a bug.   What you are observing is the dirty writeback for buff=
ered
I/O.   This is configurable; see [1], and in particular the documentation f=
or
dirty_expire_centisecs, which you can query by looking at the contents of
/proc/sys/vm/dirty_expire_centisecs, and which you can configure by writing=
 to
that file (e.g., "cat 500 > /proc/sys/vm/dirty_expire_centisecs").   Note t=
hat
changing dirty_expire_centisecs from 3000 (30 seconds) to 500 (5 seconds) w=
ill
have performance implications; there are Very Good Reasons why the default =
is
set to 30 seconds (as well it being the historic default used by Unix syste=
ms
for decades).

[1] https://docs.kernel.org/admin-guide/sysctl/vm.html

Note that if you want to make sure something is written to disk, it's best =
to
explicit about it, using the fsync(2) system call.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

