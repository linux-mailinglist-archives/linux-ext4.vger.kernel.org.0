Return-Path: <linux-ext4+bounces-9819-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C21AEB45108
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 10:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903C91BC7DFB
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 08:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E5A2FD7D0;
	Fri,  5 Sep 2025 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjT0WeEn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B252FD7A4
	for <linux-ext4@vger.kernel.org>; Fri,  5 Sep 2025 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060038; cv=none; b=WOGvX+Cyp/7Q9om9HNGCddgMGUfJHntop+CM44ZHN7R/v4zn2ekvDxiYacUstZWrSMx6TJpKM+SVIdt92hNOkNhiMWWz/PQuT/IBZpmAVbsylIK2UUGJ6jXmMgyNfERleESS2sdad4DYp84WqV8N9t76L8RZJjmBW1gvt0m9xcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060038; c=relaxed/simple;
	bh=J5T8KbYMZ5OsLf81v9MV7NnVCCI47eR7NPFSmuh/mFA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NfUxYEkF3A3GRhHs9Y2315UWWj1DW8kuUSEAlKY8JA7GPiZcpsooqrcwGYqnilcUN+303+BI0Zi9GAD64wICEAKRskgH+aScsW19O1SR/IUDEkokBX+voLYBFrcRlDjgyW46mWkT6IDoi057RpMjuu3SViRLoEfQ65Gk3zuXdIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjT0WeEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 925CDC4CEF9
	for <linux-ext4@vger.kernel.org>; Fri,  5 Sep 2025 08:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757060037;
	bh=J5T8KbYMZ5OsLf81v9MV7NnVCCI47eR7NPFSmuh/mFA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XjT0WeEnjDMQb+4ol1CH1f4xK4pXfWTlwY3h9dVTS0I77OGttwBeodtHoR6k4kuVX
	 oItZekcpzg1ZlmziglKpciT21mL5eef/y6UA5SmFoyBWpPnq5bE+qwg696ySbaFt2R
	 mKAayDLC/jQNC8NKR7+p6cLopKy/wLeMq5Jb2VDL9Z6/KuH8dErUTbe+mBXHp8VSBb
	 ypqRTidFkslaJ17jUr3dyqpfXVRG5Gcmn6uuzyjIfhgMATT5q2kz1v46LiRAMGr16r
	 UBaJZvtGuF4B24nS/sMZfURCS4T3HZ18rGPVb/towMUM1J1W5J6sYW+myYFM9ZG58P
	 fpWk84JKdVHIw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 82A3EC41612; Fri,  5 Sep 2025 08:13:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220535] ext4 __jbd2_log_wait_for_space soft lockup and CPU
 stuck for 134s
Date: Fri, 05 Sep 2025 08:13:57 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220535-13602-4xhFpvdBzE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220535-13602@https.bugzilla.kernel.org/>
References: <bug-220535-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220535

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Unless this is reproducible under a vanilla support kernel, no one will do
anything about that.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

