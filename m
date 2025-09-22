Return-Path: <linux-ext4+bounces-10345-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A89B927E1
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 19:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05592A57D5
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3EE316908;
	Mon, 22 Sep 2025 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdtWj+MS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C62E9EB2
	for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563848; cv=none; b=HAnt7QDRwK4CdK7i/OKb+uIao5f+1J5WbmF/4db9JhOpmHRm+4h3JGnlJdaMdILOnVeTZN7+ci+tjsuWFtsLUfuiqsR8waPqdGEHJiL3QDbfEAQFj6EdOSdONagl42LTIAlIURI1YYXKyq5F+zgF2k4Dt7B7lGunDUZgIuvarc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563848; c=relaxed/simple;
	bh=w6jUL7TxgPVphx7adTEhihk7721ZdXQBuyJkDhPRhv0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KXsWNfoh4JbPauNcKpvFhuRFIU6tOE9hpg8PxDSYKWy1mk/IL3P8BjTkv9/eBzCCdz2vSCllTNj3PawRvGOxkOvEWkFO5iIPug33AeGMMi83z3T8Gq5+ZuPD4e0X3jvb/H2Cc+ao5M3qMkgWIGKiJ5fzh0D9md9LG7oHmVPRWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdtWj+MS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC1CDC4CEF7
	for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 17:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758563846;
	bh=w6jUL7TxgPVphx7adTEhihk7721ZdXQBuyJkDhPRhv0=;
	h=From:To:Subject:Date:From;
	b=qdtWj+MStEpws20xbSf30pRQFpXmnRzCdS74We3PWl7actGlaIM3/Is5yMDR+6Qyw
	 W9RDb0HjT7uPHD8FuF0GLbiWpxDPJMaUF00dVl8O54nJpIcYP1PFlfjlijZ5bRVBmQ
	 od/DLZCLIbnjnkpwEwSwrXB8RX2W2Sx0B0DVeZwQvzrbO+aw8NJHn9Ni+rJeVH4no2
	 SfK1XT1s/4kBUuYioU0//6mMiHD9doWxdHBUfGwx6XyYfIB6zTRTX1bZgreFwrK7zk
	 9xLqZwHZYjPfTvlyp36pJtAZrjyTRY5I5uQ9x3tUMREvoTKYV68gwafmp1hiL9sT86
	 IcCER5I55lsMA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 99439C3279F; Mon, 22 Sep 2025 17:57:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220594] New: Online defragmentation has broken in 6.16
Date: Mon, 22 Sep 2025 17:57:26 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220594-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220594

            Bug ID: 220594
           Summary: Online defragmentation has broken in 6.16
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: low
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: aros@gmx.com
        Regression: No

I cannot defragment multiple files on ext4 in 6.16 with this error:

        Failed to defrag with EXT4_IOC_MOVE_EXT ioctl:Success   [ NG ]

This wasn't the case with 6.15.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

