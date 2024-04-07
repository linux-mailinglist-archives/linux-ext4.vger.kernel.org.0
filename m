Return-Path: <linux-ext4+bounces-1915-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464D789B40F
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Apr 2024 23:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638321C20A76
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Apr 2024 21:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4160F43172;
	Sun,  7 Apr 2024 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtua8AHA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F552E416
	for <linux-ext4@vger.kernel.org>; Sun,  7 Apr 2024 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712524500; cv=none; b=peywOx9iI89lOSyb+Wgr/oIZOiozyMwDzlT83sarVU5FgCDpEDq1x+XOqPkNjhETTYVlb54DhEqahz3HZJMOdvJXc35tpt4W+7jVAWcZ2niu2lRY+0a4N8wmnYRmdEvSMYpIhrweXAElYiHf2kxbq+7VanvPssOSM6+XEgg0e7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712524500; c=relaxed/simple;
	bh=pa/8SlGcgwPMbJcppdwEJEdqi5tEVSGCt1FJTzyl3U0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RQvR/PnxG0HyQUBr3LxugAc9KJCReIpmLBK9HESTwhntf1l2g8qg8lMC5ypmP94xX28nRCog/BNBicg0HxMtw4Ardqc4d3Hsq7P5O42p9ctSSu+45Z0hHwH8ceQiK8s2hwiKfuB40EJq7dr10xC5Uq0Wi77hQMfQscB2YVOgSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtua8AHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43A9EC43390
	for <linux-ext4@vger.kernel.org>; Sun,  7 Apr 2024 21:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712524500;
	bh=pa/8SlGcgwPMbJcppdwEJEdqi5tEVSGCt1FJTzyl3U0=;
	h=From:To:Subject:Date:From;
	b=gtua8AHAh2vrhz421+5QpFHnQopK3iZOsO/b/zp63Uapq7koRhiVs1pRRh266Lq1R
	 9lvdWLr8UlIVlssrKy+qJq+JI32+nJKlJOdDY098zVsYpchUQlA0hvkEPdHNwZ/70c
	 fHgNhahXp+ImL8YA9QGpITNv5LZhnUM2gVhJszDJda8dny45EOMbqMJWWaHYcldCpl
	 433MsK9ynVH9T2wexhTaPnEiYGaC0q3Av/Kz4rqAQa/D/HgaBGvXH1JaJqrX6roVW4
	 FJcM9BGIXMJS61ZsOm77uRqawqkSBp8nzQP6t5QTVh7L9SY/0COsOXn+K0d0vaSEA+
	 nvfCOVxzOBznw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 272FBC53BD6; Sun,  7 Apr 2024 21:15:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218693] New: different UI shows different free disk space
Date: Sun, 07 Apr 2024 21:14:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kepasi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218693-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218693

            Bug ID: 218693
           Summary: different UI shows different free disk space
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: kepasi@gmail.com
        Regression: No

This happens with kubuntu 23.10 and debian 12
When you look for the free space from diferent UI (dolphin, kde partition,
gparter) all shows different data.
See video

https://drive.google.com/file/d/1FSBt6CCFnd0mJQhaEEhZrCNhj6DRuHJD/view?usp=
=3Dsharing

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

