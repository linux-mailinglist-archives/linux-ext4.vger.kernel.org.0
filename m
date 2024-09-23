Return-Path: <linux-ext4+bounces-4279-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 609AF97F0DD
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 20:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE1A28254B
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 18:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B31E2556F;
	Mon, 23 Sep 2024 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOWtMqn0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C928119F105
	for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2024 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117582; cv=none; b=AbKAxB9BiDkj6JN+xRzyRv4bRMinadf00NPIXqHzjSEh+7qN3RdWE+eIbDH//fhSRftCKXy+5r6NiWS2UGOWp5cwz1FqOupne1fVF0vGD6h3QqNF/IFcPWorBTicLnVlN83uKOGYWUfOrc/kwhwmsXPZGao9vrpGqd+4Lu3YUgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117582; c=relaxed/simple;
	bh=UWo0KFXiNU5ATLWiqV8A/0tsDBXDk3W6mEVxZmY4v9c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O3i88csWaVtPJ5Z3Xpupgj+C1KY/8XvwkHtPaZHJQ4LbkhU+mZV87YFcgEzAttZOmyzxnxBdSwcIOyMG7EeOY7hFDjeJcwxMP2uSg/V8+Gs0O1jVdKqpgbVQoSjD4LulzIuKZYibnQGmh8UTTi/ykdyAoAuiPEb3YR302AUvQwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOWtMqn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C294C4CEC5
	for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2024 18:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727117582;
	bh=UWo0KFXiNU5ATLWiqV8A/0tsDBXDk3W6mEVxZmY4v9c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IOWtMqn0TckXHbqbHgV4/71pFEvlpkEBjMLMYsP82a+kXuOjIZ8OYQuvkPM57YGDL
	 M0oz6cWuUYo0gB7cbcA78HH92WM7ZtDjsGo1OsqPZwbEcuIw+oIm12EzQ6E+zj2JZ1
	 CIEJpKUVUC2ShVff4vOBRNQadRpywMhKYspBh166TdVatsMXIu+6zQE8SoWoVdUht3
	 lQ9CWiHXddLXaGh65MX+DGUMTkrUF4XAOReH/ZeQ87/4npd28Te5FVhZH5YIYxrxB+
	 40s43rvzKNs9fCZfZhu5dyT9ca48199SYWTmPOHq2q2ACHz5rWzahrPAL9AveMZxAe
	 qBJSzUQGOQNpw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 44C38C53BC5; Mon, 23 Sep 2024 18:53:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219300] ext4 corrupts data on a specific pendrive
Date: Mon, 23 Sep 2024 18:53:02 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219300-13602-criS1vGnzz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219300-13602@https.bugzilla.kernel.org/>
References: <bug-219300-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219300

--- Comment #9 from Theodore Tso (tytso@mit.edu) ---
It's not at all surprising that flaky hardware might have issues that are o=
nly
exposed on different surprising.   Different file systems might have very
different I/O patterns both in terms of spatially (what blocks get used) and
temporal (how many I/O requests are issued in parallel, and how quickly) and
from a I/O request type (e.g., how much if any CACHE FLUSH requests, how ma=
ny
if any FORCED UNIT ATTENTION -- FUA).

One quick thing I'd suggest that you try is to experiment with file systems
other than ext4 and ntfs.  For example, what happens if you use xfs or btrf=
s or
f2fs with your test programs?    If the hardware fails with xfs or btrfs, t=
hen
that would very likely put the finger of blame on the hardware being cr*p.

The other thing that you can try is to run tests on the raw hardware.   For
example, something like this [1]to write random data to the disk, and then
verify the output.   The block device must be able to handle having random =
data
written at high speeds, and when you read back the data, you must get the s=
ame
data written back.   Unreasonable, I know, but if the storage device fails =
with
random writes without a file system in the mix, it's going to be hopeless o=
nce
you add a file system.

[1] https://github.com/axboe/fio/blob/master/examples/basic-verify.fio

I will note that large companies that buy millions of dollars of hardware,
whether it's for data centers use at hyperscaler cloud companies like Amazo=
n or
Microsoft, or for Flash devices used in mobile devices such as Samsung,
Motorola, Google Pixel devices, etc., will spend an awful lot of time
qualifying the hardware to make sure it is high quality before they buy the=
m.=20
And they do this using raw tests to the block device, since this eliminates=
 the
excuse from the hardware company that "oh, this must be a file system bug".=
=20=20=20
If there are failures found when using storage tests against the raw block
device, there is no place for the hardware vendor to hide.....

But in general, as Artem said, if there are any I/O failures at all, that's=
 a
huge red flagh.   That essentially *proves* that the hardware is dodgy.   Y=
ou
can have dodgy hardware without I/O errors, but if there are I/O errors rea=
ding
or writing to a valid block/sector number, then by definition the hardware =
is
the problem.   And in your case, the errors are "USB disconnect" and "unit =
is
off-line".   That should never, ever happen, and if it does, then there is a
hardware problem.  It could be a cabling problem; it could be a problem with
the SCSI/SATA/NVME/USB controller, etc., but the file system folks will tell
you that if there are *any* such problems, resolve the hardware problem bef=
ore
you asking the file system people to debug the problem.    It's much like
asking a civil egnineer to ask why the building might be design issues when
it's built on top of quicksand.  Buildings assume that they are built on st=
able
ground.   If the ground is not stable, then chose a different building site=
 or
fix the ground first.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

