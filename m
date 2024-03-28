Return-Path: <linux-ext4+bounces-1765-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0822A89025A
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Mar 2024 15:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE051F2321E
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Mar 2024 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ABC7E56E;
	Thu, 28 Mar 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii/vC0jb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFA2D044
	for <linux-ext4@vger.kernel.org>; Thu, 28 Mar 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637723; cv=none; b=RVBshxg4K6Al3Iu5k6oIrBZkTCGCKlqUhrViR/D/71sDajOnpRulN9w8Y9E87GBCKJH3Aye9mFAUJQsBh5COwrxvWHDSWgNLwB2yjI3zm50yGoAxcMSnAmFrFF9Y4oguqeuqCxaM/nFQ5m+BB29YH1CFn1JdL09fw644yTJFOYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637723; c=relaxed/simple;
	bh=VfbFI4lp11UJ8RvqxHSEWWnVhW4KQ5jTlFh3Wjq1z1s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=saG8zNasaA/iSe+g4DetKQbKXhfe/9oHfQ98a0SO7DQORyyzlOz8d90sHDBNfbyvsJGx3IPLGzk84Bfs75uyW3fN2mohaL19raQlKuPkVqBibrZH3sA1amDANZF/CeQltG2x67UWJ6at4+Set7pwsY+SwOZbojYVEznN4evYVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii/vC0jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD080C433C7
	for <linux-ext4@vger.kernel.org>; Thu, 28 Mar 2024 14:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711637722;
	bh=VfbFI4lp11UJ8RvqxHSEWWnVhW4KQ5jTlFh3Wjq1z1s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ii/vC0jbT6qRUGM3fGR9dajEN56JvrpaPcnKbA3+hZ0e+zsDKngKrWqSZlfaOngqg
	 +dZzpiQua2QCl/Rx5ejtBRTrB6p+1iAPuCxgSmP9JQ6t2K3CHDaGrGjzKiwqMyssgP
	 05euw4VmTz0rqjjkbTKS/P3P4pVSmzEIP8QGVTFtN2Lidm2YFqTuVOx1KMMAssg7ds
	 Kw1RhLRRB/NNgTjY+vDSZnSx0Wu9LbsycjPGLZuhGKC9y3UXUqUa0qEM40ZzS+lEKX
	 oewNt+JwxkeK0sS9F6Sqz9/XBtr6cjNTt30CGdXk6Xll5RR+HD+kwSdPaiOZ9sPNnk
	 RNqhaGodnVubg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B5123C53BD0; Thu, 28 Mar 2024 14:55:22 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218648] ext4: previously opened file remains writeable on
 readonly ext4 filesystem; Data loss.
Date: Thu, 28 Mar 2024 14:55:22 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218648-13602-n7LY5ZJJYn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218648-13602@https.bugzilla.kernel.org/>
References: <bug-218648-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218648

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #1 from Theodore Tso (tytso@mit.edu) ---
Normally, if there is a file opened for writing when there is an attempt to
remount a file system read-only via a command, e.g., "mount -o remount,ro
/dev/sdc", the remount with fail with EBUSY.

The problem is what should we do if the block device has failed or otherwise
disappeared.   In that situation, we can either do absolutely nothing
("errors=3Dcontinue"), panic and halt the system ("errors=3Dpanic"), or rem=
ount the
file-system ("errors=3Dremount-ro").  However, what should be done if there=
 is a
file descriptor open for writing?

1) We could fail the remount, which would mean that the file system would
continue to be mounted read/write, which would cause the behavior to devolv=
e to
"errors=3Dcontinue".

2) We could force the file system to be read-only, but any file descriptors
that are still would be still open --- but attempts to write to the file wi=
ll
fail with EIO.

We've chosen because it's the best we can do.  We can refuse a remount
read-only if it is initiated by the system administrator, if a user yanks t=
he
USB thumb drive out of the laptop, or a terrorist slams a plain into the
machine room at the Pentagon, it's not like the kernel can stop something l=
ike
that from happening.   ("I'm sorry Hal, I'm afraid I can't allow you to do =
that
ala the movie "2001: A Spacey Odessey" is not yet a thing; although maybe
sometime soon our AI Overlords will have that power.  :-)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

