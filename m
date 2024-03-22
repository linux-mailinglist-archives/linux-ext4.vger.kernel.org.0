Return-Path: <linux-ext4+bounces-1732-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 797DE886BA2
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 12:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343892867D0
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B50B3F9F9;
	Fri, 22 Mar 2024 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MClbKr6X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0743FE54
	for <linux-ext4@vger.kernel.org>; Fri, 22 Mar 2024 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108460; cv=none; b=RkINxpdMWEL2vpbRFr10+uWmsi78iXG8CEPYpNVy8eYH1ij5dFPtM3CqpyAPwKKqkSteTIFnGQR8WfgCGlRPxI8qLxf5z4mop72p99fvfFCTVUK60Jm35RkeOYasn6s+POBd6tNZ1otjRfDZX9o01wpxASREkZOf1Crl5NksrsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108460; c=relaxed/simple;
	bh=/oAuO7s9QO1rRJcl9TDjLuRRsx1u1NMhJH93oPIEH9s=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e+/MCH8QqWCKJWWVe9J8K84Qr9I9nIhck8i6WgTz8+M2uPBl7rkHG14GpLUdEb4UeDm4v7qFglyWsezmfNFnrodsOsm8TT7VQW7sbjYDF/3k+NNTl8MGzQK3A67SmicngMVL4is97ObMO9syvDpybpJW6HKVvWHh5eR4tzDGCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MClbKr6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A336C43390
	for <linux-ext4@vger.kernel.org>; Fri, 22 Mar 2024 11:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711108460;
	bh=/oAuO7s9QO1rRJcl9TDjLuRRsx1u1NMhJH93oPIEH9s=;
	h=From:To:Subject:Date:From;
	b=MClbKr6XwYdAPkcD2e9piQzou2UdPh4PKVYjkuz2CgRjtQ+2UTtr8sFnIWAjM6775
	 dlSjpAwU/+ZJPrfQwR3SIOfmyLQ6Hsp5W/ixBXdzfevKutikJyRvu12IeelpIAzyEA
	 25PgKgtVSrOyN15d+9lx7cvVDzKqPDK+0OtA3lDEzv+IHtDniAqz9PDJJXlM1zcoQW
	 qDYng+385s6waU4324rtKQM0h9SUsVBKSBOO8bNGH9U0Gmw6NXQXV4Z9xyZ2JIBV85
	 7tsKF2xklTRAMWkikechTNvkcrZqauAYJle4mUAB3Mk+8prJFaHkjXwwaT327M3FzF
	 KsFsy/skmJigQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 57FA7C53BD0; Fri, 22 Mar 2024 11:54:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218626] New: fstest ext4/014 fails when using filesystem quotas
Date: Fri, 22 Mar 2024 11:54:19 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luis.henriques@linux.dev
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-218626-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218626

            Bug ID: 218626
           Summary: fstest ext4/014 fails when using filesystem quotas
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: luis.henriques@linux.dev
        Regression: No

Created attachment 306024
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306024&action=3Dedit
full test log

I've started looking into a failure in fstest ext4/014.  It's very easy to
reproduce, it simply has to be executed with quotas (without enabling quotas
the test passes).

Here's the fstests options I'm using:

export MOUNT_OPTIONS=3D"-o quota"
export MKFS_OPTIONS=3D"-O quota"

And here's the output (the last line is where the test fails):

QA output created by 014
+ create scratch fs
+ mount fs image
+ make some files
+ check fs
+ corrupt image
+ mount image
+ modify files
broken: 1
+ repair fs
+ mount image (2)
+ chattr -R -i
+ modify files (2)
broken: 0
+ check fs (2)
fsck should not fail

Basically, the test corrupts the first block of the root directory by doing=
 the
following

- create and mount the filesystem
- create a few files
- unmount filesystem
- debugfs -w -R "zap -f / 0" <dev>
- mount, and attempt to modify some of the files created before, and unmount

After this last unmount, e2fsck attempts to fix the filesystem, including t=
he
quota info.  It exits with exit code '1' ('File system errors corrected'),
which is what the test expects.

However, after yet another filesystem mount/unmount cycle, another e2fsck r=
un
will still complain about quota info being inconsistent.

The test will pass if another e2fsck is run immediately after the first one,
which seems to indicate there's some fix missing in the first pass, but I
couldn't figure out what (the code isn't particularly easy to grasp...).

On the other end, I'd also expect that the kernel would notice that somethi=
ng
was wrong when the filesystem is mounted after e2fsck is run, but dmesg doe=
sn't
show anything.

For reference, I'm attaching the full test log that includes the output of
e2fsck.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

