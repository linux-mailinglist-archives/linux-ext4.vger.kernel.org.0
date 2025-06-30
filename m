Return-Path: <linux-ext4+bounces-8715-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014D5AEE334
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 18:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C85C164FC1
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 16:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9AE27055E;
	Mon, 30 Jun 2025 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpUuUWi1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117C1E51D
	for <linux-ext4@vger.kernel.org>; Mon, 30 Jun 2025 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299448; cv=none; b=ga1IipzITixbwZi/XLFgEvFgevKHBDo54qVzYRf2mK3MGTHlQyC7RNbSG2CTOq17EBUJsbDwsNqEtAKiStVoqfPAknT1x3Umnd2d7Lz/xnXvCzC49ZzHDdkWJqZIm0MltKPoOL+06opEHbhIjfBOiurLSahd2zePpiEADk3uMYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299448; c=relaxed/simple;
	bh=clMNBEpNMLjUHB1H6M+VYRnYeb7QAnv00qwflmBxdDQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k6TcLwtg2nnyrkPEQk2tYNnSdjb4DkqvFRstOVgqGBqYMUUwMRdioFw0q0UZ6TSHnDMELn4TLJt57uY9QbUAahY2xmDViPh+fiRKndfM1dAkzNfvMY1pWXPdmnRispwVHRMiHnHrINZoFJR+IAiGyYwHHNgtgQMiUboHJ4tv0LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpUuUWi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9536C4CEEF
	for <linux-ext4@vger.kernel.org>; Mon, 30 Jun 2025 16:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751299447;
	bh=clMNBEpNMLjUHB1H6M+VYRnYeb7QAnv00qwflmBxdDQ=;
	h=From:To:Subject:Date:From;
	b=mpUuUWi18rtEUDl2dgfXfvKEilmhGw00uI3gnYvfsL83lASvjpdnPDeEU8A6PK7oZ
	 LOikyv0PPOy13jq8OKnSgJ9sw266oq/y0PfIq9rDQ4ulyM8TrO6CmbPpFYz9oMuOOW
	 XYJLsc90ht8xBVWa5GL81V51k5DTN6dpBmrGatvlwId4eSOraURl2LkjLuPSpByPG6
	 jJFRcciQAOmT0zPLOAU5spLdJ0kthVykMY6KXo1TFyUhcfiLLKvnNAoCplAvDB9BYH
	 Pwez5VKsstnQ74JPhWg/IR/Wfte13bB9pUmFlRI2xPs4DNtmqqgdRh9u1dpMyuaEXl
	 4ERx4Ed0tr4Qg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BB77EC3279F; Mon, 30 Jun 2025 16:04:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: =?UTF-8?B?W0J1ZyAyMjAyOTldIE5ldzogV2FybmluZyBUcmFjZSBzZWVuIGF0?=
 =?UTF-8?B?IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjYuNjkvc291?=
 =?UTF-8?B?cmNlL2ZzL2V4dDQvZXh0NF9qYmQyLmMjTDczIHBvc3QgcmVtb3VudC1ybw==?=
Date: Mon, 30 Jun 2025 16:04:07 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chakrashramana28@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220299-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220299

            Bug ID: 220299
           Summary: Warning Trace seen at
                    https://elixir.bootlin.com/linux/v6.6.69/source/fs/ext
                    4/ext4_jbd2.c#L73 post remount-ro
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: chakrashramana28@gmail.com
        Regression: No

Warning Trace seen at
https://elixir.bootlin.com/linux/v6.6.69/source/fs/ext4/ext4_jbd2.c#L73 is =
hit
by the writeback system even though there is nothing to write and the
filesystem has been mounted as readonly.

An ext4 fs is mounted with journal=3Ddata and a large file is written to it=
. Then
the fs is mounted as readonly-ro post a sync. At this point of time, data
consistency is preserved through the sync itself followed by a sync from the
remount-ro action. All the dirty pages should be marked as clean in the cac=
he.
Yet post the remount-ro, it hits
https://elixir.bootlin.com/linux/v6.6.69/source/fs/ext4/ext4_jbd2.c#L73 and
prints the trace as the fs is readonly now. Even though there is nothing to
writeback, the wb_writeback is scheduled every 5 secs or so and the same tr=
ace
can be seen if changed from WARN_ON_ONCE to WARN_ON.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

