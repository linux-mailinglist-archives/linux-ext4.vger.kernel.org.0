Return-Path: <linux-ext4+bounces-3747-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1548D954F89
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 19:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73E21B214AF
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 17:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DA41C0DD5;
	Fri, 16 Aug 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHV9MI4y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27396F2F8
	for <linux-ext4@vger.kernel.org>; Fri, 16 Aug 2024 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827994; cv=none; b=cf4zuAl22kJMiptmd1qPJYCIi1wQ6cz2ukzY58dOIln6fKu1Ym6ju65BJfC7bZZmXsG2gPqumW/P9PE3L/HPAXi8q8palcxeKvGxEbkAKMtKngRV1XaDUKjMcTytsIq4pCZTjGo6sx2hqvNCDiENVYRGYjmNc8ZJLu+2wsfByyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827994; c=relaxed/simple;
	bh=0oYa0RlLwMTVcRcImFMU//04pqEq9bygN+syLbHIhRE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kiCeAwaJceEBD27zf3KS24H8zH9+u0uq1o4Hj+OMJt9j/gbYesN+L5CJ1JohoPUOZS7g6lpwCE6Rz32yijFWGOpiBhRkkczAGgYxrNWgb85QXa/MLu7KIX4GTenYdigw+Dw/8Ch+6lbUVcHviA800Gsu9+BTXah+SQenxE5xF04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHV9MI4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69273C4AF0B
	for <linux-ext4@vger.kernel.org>; Fri, 16 Aug 2024 17:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723827993;
	bh=0oYa0RlLwMTVcRcImFMU//04pqEq9bygN+syLbHIhRE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lHV9MI4ysTLTyteSHdfv12LgKRCBpCjT/eQSS7G+05Xpk2aZh216xxwdiORY8KOid
	 G78DCqOauCJXzkY4TswQTQuRpKDPfVMcyzKw/DoEtGjivKhuwXfGSUfYxvKsXSqYXt
	 KPNWlFKNudbfHdFDdvI2OaiXFgPrrez9snFM3iFhofEPP03m1Yn4uMvSnufwe9PFtd
	 oIQPcezeLjGlbc0ZM41HdofQ4e1+h1eXwbqml+YXb0VVNl7pCGIim7daibaWHoXPCN
	 Wvp7Ni8dmPf+OsuL0HNLHxkFCN+IzJC5FGGxWrFCVtUyOzdDltneqZd2FmX1Gw+qBy
	 QfAjIKHb/ehSA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4E130C53B7F; Fri, 16 Aug 2024 17:06:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] ext4 hang when setting echo noop >
 /sys/block/sda/queue/scheduler
Date: Fri, 16 Aug 2024 17:06:33 +0000
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
Message-ID: <bug-219166-13602-GUDuevO7lS@https.bugzilla.kernel.org/>
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

--- Comment #2 from Richard W.M. Jones (rjones@redhat.com) ---
We did indeed work around it by not doing it:
https://github.com/libguestfs/libguestfs/commit/b2d682a4730ead8b4ae07e5aaf6=
fa230c5eec305
so my interest in this bug is now limited.  If you want to close it then th=
at's
fine.

It's unfortunately triggered very rarely.  The only test I have is:

$ while guestfish -a /dev/null run -vx >& /tmp/log ; do echo -n . ; done

but that hits the bug less than 1 in 200 iterations (although more often wh=
en
run in a qemu VM using software emulation, which is where we first hit this=
.)

I tried to write something that could trigger it more frequently by having a
loop in a guest writing to queue/scheduler, while another loop in the guest
would write to the disk, but I couldn't seem to hit the bug at all.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

