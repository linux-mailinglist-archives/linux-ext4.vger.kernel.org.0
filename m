Return-Path: <linux-ext4+bounces-4323-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FB8986935
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 00:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B53BF284384
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 22:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3C0158205;
	Wed, 25 Sep 2024 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhjgXDtq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134BE56A
	for <linux-ext4@vger.kernel.org>; Wed, 25 Sep 2024 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727303466; cv=none; b=GhmsbBvIfRKBxl8ljZVBBwwzZk9D+lchGbf1EvZqzk7cHDB/38cySyI0ccuLM3RTb+vll18W5SycgQfOQBWbT7Ba3kaNVCybvH2RNNUUz9NiAfwUczKZY4XtOHNu6XqLt+agIgOAbFyRXDilP+sEvwoZEl37qlpm6DLGb6gYEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727303466; c=relaxed/simple;
	bh=//8ppKl6TWeLCnWdKRn7chUzwQEjAqvpOuqUNb1DNTI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rXaOHy290uqbzTOgg4lncpRpSFsh9e/mgCSBGZdFycF3mLZdD4dnjf43UBbexaiL1b11/O0q5WjVObG1giNG8MsrSoLVTLjKmW/jYWuJ7YGLWrrbURwXwr9dLs+kW9gAYuTG5p6nMCHznYAqbliKHqj7aHpyMrZlA5s8O8tim3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhjgXDtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0952C4CECE
	for <linux-ext4@vger.kernel.org>; Wed, 25 Sep 2024 22:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727303465;
	bh=//8ppKl6TWeLCnWdKRn7chUzwQEjAqvpOuqUNb1DNTI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XhjgXDtqTBXVmMCyXmeHEWRDCvMNDaVqUuN5XmCxW0SL5IThD1QEkYNqduw6AIMNq
	 /COyvkyS/cwWH33GKBicopybNY7sgyG4qpMdiccp+waof4FTvFuKfGsWCYbULnXrSj
	 7dtFIHgFhNOGGJfXIVADvsjg8o4R/tX7K7syRxZm9G71SmKgtLuIOgb9R+txxiXNIK
	 ukDdJ/dULWfV4NHDC0jJBG95PZ8zCS3UQBXsbIgmjQts14l+6zJgXfh2FqwZmrIFcN
	 TeAYy0bGvBKDi3yHZLnYGfGqK/RJH56jegakKZi3r/k5YpYEHUAK4+wFNNwfCL79ko
	 dVVzumBRehchQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 92AE9C53BC3; Wed, 25 Sep 2024 22:31:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219306] ext4_truncate() is being called endlessly, all the time
Date: Wed, 25 Sep 2024 22:31:05 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219306-13602-I7DZxac5vn@https.bugzilla.kernel.org/>
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

--- Comment #4 from Theodore Tso (tytso@mit.edu) ---
"Won't be called most of the time" is rather understating the case.   The
WARN_ON should never, *EVER* fire.  If it does we have a kernel bug, and if=
 the
user has panic_on_warn set, the kernel will crash.

Also, please note that the WARN_ON would triggers when we have a inode-spec=
ific
inconsistency.   In the extremely unlikely case that the WARN_ON triggers, =
the
doom loop that you are worried about would only happen if (a) panic_on_warn=
 is
disabled, and (b) the inconsistent data state happens to be the journald's =
log
file.  If the file system has millions of inodes, we're talking about a
probability of one in millions, even if the kernel is buggy and triggers at
all.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

