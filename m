Return-Path: <linux-ext4+bounces-2443-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F9F8C1CBF
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2024 05:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022F91C21416
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2024 03:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E045148FFF;
	Fri, 10 May 2024 03:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruYTHbvT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A14F148831
	for <linux-ext4@vger.kernel.org>; Fri, 10 May 2024 03:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310314; cv=none; b=MoGyW0q1SVYVS4dHIk/ryGKatx0GXohtpevYPbjnTSBO/Th1T3qoRaw7LgducK7YguFzIjqJ4MFjlJwNyA43oPKV9VgW/fnUT3BFiRnXbS+A0pLe6xzP+0U0O1sukD3ba5I4+N8aOVKRu1wbksEnoCFcuHJraFfAwiAwnTAtn0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310314; c=relaxed/simple;
	bh=awuQkE8FfmvRRVxuz9+PRs+geYTdsusPjF8h9LoA9Vw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rGh+cthj0S/i4GWFjH9MqAFoM4C1dmgy6oDP2SZES33so7RPLNTd22tL/U+Kt9TMl8EgEquWCZ4XsXLdMcFagGWkWmPLErLwdCp43n73V9XfK4AaWxWgSsFLmak0/PjmtqEX0dIu7vpwIDIS+aHlugPLeavUtyzlkGIiUQ/jyis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruYTHbvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 313A5C32781
	for <linux-ext4@vger.kernel.org>; Fri, 10 May 2024 03:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310314;
	bh=awuQkE8FfmvRRVxuz9+PRs+geYTdsusPjF8h9LoA9Vw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ruYTHbvT0AdvXDwqZqEob6nGUqQ2GNz/ACmLz0MHz6/EiJqLTkv/3uVj3TzIhbH9y
	 Yb1fYVGY+5YTG36G+Io9fspUcxdzKQ26gRuA4eA3oHcndVrLknKPUAh9jP6lVSxxIl
	 9AlMH/Ew0M20dej4+yCNJwRA5h/hnQA++J4Wtdf21RdcDBcsBKDtb5cWUMnaM1gJxe
	 Lt6jvUe+6qqjT2CG1rDZFiKrpd8meEDHkpO1QxiE+DXv7eRjJjR21U+pincJ2GKbVm
	 E7/ZOi/T3zdbXyqT90HgjSvLgcqIU8nKo1S7ohLEWtmnY+RUWEjRwq7fLbaSmMC8V3
	 3HzwiHAvTGD7w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2B5CDC53B6E; Fri, 10 May 2024 03:05:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218822] Delete the file from the upper layer directly, the file
 will become "Stale"
Date: Fri, 10 May 2024 03:05:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Squall.Zhou@vecima.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218822-13602-j2pL1d9xss@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218822-13602@https.bugzilla.kernel.org/>
References: <bug-218822-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218822

--- Comment #5 from Squall.Zhou@vecima.com ---
Comment on attachment 306279
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306279
Test result for 6.8.0

I have also reproduced it on 6.8.0

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

