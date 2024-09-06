Return-Path: <linux-ext4+bounces-4082-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9288396FCCC
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Sep 2024 22:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC2A1C20D8D
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Sep 2024 20:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E904F13C3F2;
	Fri,  6 Sep 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILLRSGh1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719941B85DA
	for <linux-ext4@vger.kernel.org>; Fri,  6 Sep 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654748; cv=none; b=h84u4UhHInZudFfz8kfxYBT8YzYHoPXa+CTVRa+dgG+oN/2xP9NV+cyxUnu7/rSdW1H8tgTszxcgD25thBa6DtaSzJ5lSrh2AxTCgCXv60uy2sreYdk7SyzbHKzmomeRb592XY+ns+3/N+vDdFnzcKveq4hgCBDgKt7QscDmjwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654748; c=relaxed/simple;
	bh=g6ErjVlTntOf0o6TReV+hH3VbCyRfb3HBaJXt+NCKhE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O1dwOjwBYE7XqOsBpxxcelty/8ixCOpo/8mRdfxbyRKrm55arzfrzPxciv2PGC5x1amkXlQyPy35PKp6OIA2jm2Zyk2l3t6xXPISufBq4Q066h4auk6ZyRiEhAuqQ99yryR1cTK2OB80G3jqpfwUbQnQq0q9voY3hKssmLGQirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILLRSGh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1070FC4CEC7
	for <linux-ext4@vger.kernel.org>; Fri,  6 Sep 2024 20:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725654748;
	bh=g6ErjVlTntOf0o6TReV+hH3VbCyRfb3HBaJXt+NCKhE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ILLRSGh1pE5SxypMgHS+6Xs4szGTDRAyeYKxIYewfzv9/9CY/G5jUSTca1gM++dtI
	 9q/j+u351nWZeR/aHQWUbvcPDHe37Yd/UMRQqIX5NBSyAZVo0lDPnG88Y9Eko9UOYI
	 QYcqU5IpXHs4vIj3vw5M2ReWYOc17ARTPzHUE8L5wEVaXf2a6d0G0d8Eik6w195Q+t
	 NNkY7FbTxxamqAslpAAQTvLO9gQMBknp6eWFaHacv6rRdGawyo8xuql2J6qVfi27lA
	 m7Nm8zqIJb8TvFy0zHRnqU9wr6D9msvzYHDNOh9uPfd+LHzGQ3KWB0pX9n6O+jXNHl
	 gYr6/v6JC64Gg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 05081C53BBF; Fri,  6 Sep 2024 20:32:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] occasional block layer hang when setting 'echo noop >
 /sys/block/sda/queue/scheduler'
Date: Fri, 06 Sep 2024 20:32:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjones@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219166-13602-KtbKtHaE0L@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219166-13602@https.bugzilla.kernel.org/>
References: <bug-219166-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219166

--- Comment #16 from Richard W.M. Jones (rjones@redhat.com) ---
Reverting commit af2814149883e2c1851866ea2afcd8eadc040f79 on top of current=
 git
head (788220eee30d6) either fixes or hides the problem enough to fix my
reproducer.

The revert is not clean, but only 2 hunks fail and they were trivial to fix=
 up.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

