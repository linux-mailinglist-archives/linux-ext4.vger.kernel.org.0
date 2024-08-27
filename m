Return-Path: <linux-ext4+bounces-3892-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A26CA9600FE
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 07:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A511C211B6
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 05:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5C077113;
	Tue, 27 Aug 2024 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0klwJA0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B07171AF
	for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2024 05:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735878; cv=none; b=GtVU6ibcgKrTcMLFtiGZjKdVsmY8AZUzJOLxR9q870hEx4GdUIwSBMAo6FMbszYJXc0wGlsH9VUwNFaa7nJsF0b/gAAgul8r3yo6dy6fluFFYfLOvaT7G5bHi6O1+1zAREEnhYragVaNwEzsw1u/aPzFvW7hj1eecMQ8APlEMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735878; c=relaxed/simple;
	bh=Ki3Gjw0krm9K6Xqe4VvFAyRuY2zwu0m3u1SFWQ3WuvE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JaT1i6olCo1zDwLISWg0dHtiX6faLQprOc1ZVJHsEOSSUDbS9CGGCw5PZk0K2FnGhMJ5ytk2rFf2tGh7LBfcmPR9JIs3/3IC05xWAhGFDMg3Z/qK0CYNvgvHfSKx3QMk5ZJ9LXwBPGJGZcXsPWYobBtPdPHgSt+QwVWctim/wOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0klwJA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 524C8C8B7A8
	for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2024 05:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724735878;
	bh=Ki3Gjw0krm9K6Xqe4VvFAyRuY2zwu0m3u1SFWQ3WuvE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=r0klwJA08QhgaWFGTStYVL8dsGbqmkno9Yaiu/3MerN7FaS/EvNNGTsYU1sZihOpc
	 cF55z8CT5y1t3SNavqDdGQxjuaQsxBTwD4pJIcrjtREQtph/KGL16T7+4KubuWUa1L
	 1epidvEpZ/3xfG8OQnSXqLto+iSqHQVL+jOmzo6XDlloP0fobQa8m8O5+qShvFF/Dq
	 X1wZQGa5kKjWcs0djIRWLaIC2hH0lrZUo4QAu8iBlv0/eFliAR8AqHgPaw6vY75f/+
	 C18xfB0C2MQY6MUzKbXiSYQRZqvBnTTWrll0EGTyKbrSxjuPg9d+cCGHEgolx1Ekjj
	 mtVM/R5SfdIMw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 43A9BC53BC0; Tue, 27 Aug 2024 05:17:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219200] update from 6.11.0-rc1 to 6.11.0-rc5 causes file system
 check every boot
Date: Tue, 27 Aug 2024 05:17:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext2
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ebiggers@kernel.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219200-13602-tdGr5LT7hK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219200-13602@https.bugzilla.kernel.org/>
References: <bug-219200-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219200

--- Comment #1 from ebiggers@kernel.org ---
On Tue, Aug 27, 2024 at 12:04:56AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219200
>=20
>             Bug ID: 219200
>            Summary: update from 6.11.0-rc1 to 6.11.0-rc5 causes file
>                     system check every boot
>            Product: File System
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: ext2
>           Assignee: fs_ext2@kernel-bugs.osdl.org
>           Reporter: publiccontact2020@protonmail.com
>         Regression: No
>=20
> Reverting from 6.11.0-rc5 to 6.11.0-rc1 resolves the issue of file system
> check
> at every boot.
>=20
> This issue is observed accross Debian, Gentoo, Arch and Fedora Rawhide.
>=20
> --=20
> You may reply to this email to add a comment.
>=20
> You are receiving this mail because:
> You are watching the assignee of the bug.

This was already fixed by the following commit:

    commit 232590ea7fc125986a526e03081b98e5783f70d2
    Author: Christian Brauner <brauner@kernel.org>
    Date:   Mon Aug 19 10:38:23 2024 +0200

        Revert "pidfd: prevent creation of pidfds for kthreads"

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

