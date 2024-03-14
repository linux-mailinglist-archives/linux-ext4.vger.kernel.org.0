Return-Path: <linux-ext4+bounces-1654-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20B287C4C7
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 22:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F346C1C21759
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 21:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFE97641D;
	Thu, 14 Mar 2024 21:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDPZENDG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF276038
	for <linux-ext4@vger.kernel.org>; Thu, 14 Mar 2024 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710451908; cv=none; b=metZkrlbhZgoLQgAI6qIyTg6L23NVFSCzHpNWr8TDOXgUXDTbI0FyCgVxjQEjVDwYAXaEEyFDZHURTf81K0qtYJM56P2LUYUmj0dsQPpxb/4PLQOPGqmjVD2v9g3kmx+NC4DZOZFSF7CxtgKx9ycE8wicTi4ZF3hszvJzl7hdLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710451908; c=relaxed/simple;
	bh=0F47dTbiyuueDJP4eDDQg1fohSzWHHddPD+5OgpktOA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CR/QQ9MOrXif2vJtDyniMF/Cahiq3auqifdqztFSnrWLf0v0gnOkJJhJnErBJFxUKIHHWzCP4iLIfA74iAbSx0iAfWc0hd8qaIDYfhQswbA9ncU4PWMjZtn5Kf3PNf1NNjDXllU4Szjmz9GIRUWK7wXQsENp5yQVLu/HYvWl9Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDPZENDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05978C43394
	for <linux-ext4@vger.kernel.org>; Thu, 14 Mar 2024 21:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710451908;
	bh=0F47dTbiyuueDJP4eDDQg1fohSzWHHddPD+5OgpktOA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PDPZENDGMTwFPbTbGrPqdMFtsgvwaHFfJTR0dbDMmSFd5Yb1C3iZxO5sCGhgJxnEb
	 Fftr8h+mTmSgkQaZwItZlJjBLc8744LUtk2o1/SfIwx9nqUCxPyVIz1RlMZKe5bD91
	 7e0zirSxsGg7DkZ0x9qhMDMi9jSdYr4ZHyquPhGt0105c1G8iglUvP90pKpQzx9xWM
	 Oh5ZOJw8oE1N+2E/3Q/0m0HGvLFtDz+Rj8qGmqmKawLzirMwXX+R+b/GExG3ouGBkf
	 VqJEknQz4UvdDhF5wRB0ZW6yXzjjqTwzFDiG/UzVDAprUmtjpBpcSHNlLhMzUUx7Ks
	 Y9RuGCtQvWvNg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EC2BCC53BD3; Thu, 14 Mar 2024 21:31:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 205197] kernel BUG at fs/ext4/extents_status.c:884
Date: Thu, 14 Mar 2024 21:31:47 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205197-13602-0dwx5XEBQm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205197-13602@https.bugzilla.kernel.org/>
References: <bug-205197-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D205197

--- Comment #6 from Theodore Tso (tytso@mit.edu) ---
The reason why no one has paid much attention to it is because the bug is
reported against a very old kernel, and upstream developers generally only
worry about the upstream kernel.  Companies which insist on using old stable
kernels need to either engage paid support (e.g., contacting Red Hat if you=
 are
using RHEL, etc.) or have their own kernel developers on staff to debug the
problem.  Upstream developers are volunteers don't have the time to provide
free support to companies that are using old kernels.  In general, at the
minimum we ask kernel engineers working on these kernels to try to reproduce
the problem on the latest upstream kernel, and if they can't.... maybe they
should work on using a newer upstream kernel, or they should figure out how=
 to
backport fixes to old LTS kernels.

Also, it seems... weird.... that you can't look at the hex dump.  The kerne=
l is
able to mount the kernel, so you have access to the encryption key, or at
least, to a block device which has the encryption key set up by your user
space.   So you should be able to run e2fsck -fn /dev/hdXX.  This would help
provide a hint to the nature of the corruption, so that we could try to
reproduce the problem on an upstream kernel.   But what we really don't have
time to do is to hand-hold users who don't know how to run fsck or apply ke=
rnel
patches, and trying to run test kernels.

If you can let us know what you actually can do, perhaps we might bend the
rules and try to give you some debugging help.  But it will only be on a be=
st
efforts basis, and when we have time, since after all, we're volunteers....

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

