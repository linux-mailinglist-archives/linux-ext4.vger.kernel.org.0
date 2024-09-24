Return-Path: <linux-ext4+bounces-4289-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A695D98483E
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Sep 2024 17:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D782D1C20C68
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Sep 2024 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F206EEB3;
	Tue, 24 Sep 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F363n7Lf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E60155757
	for <linux-ext4@vger.kernel.org>; Tue, 24 Sep 2024 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190481; cv=none; b=dCl3JUzbB27ytQHDhO+MMs1JDcys2QhwQmAuKtnq44nzjcpDq+4x8CUk76fSnwx3mlARJfD4+bDFLo13VsBVZmOeIB7ftTf7ThZhoqNY8fOslX4rbETj2x7qMS03KsREbKjA73KI8cxPyUEy0HEgug8CV9SbbPb7uFoZf5oTAvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190481; c=relaxed/simple;
	bh=mwiuERKQ7FhSWsEGXILVnEeLqXSVv8mLCWupeFdTCrA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWEF8/2YZ6mEsI4bpjKjkWn3a4SMUbgZXCso7QDvT0faXNaSmmqEeeFLswGv8nS/okgpHWXRYA1ozw+sUjQFr+4fGtk5mC7ohlLO30IKiJmXMiPnv4Jg0exyKlSkP/YYqEG4Cc7HNX+LXYAlzuLXX5MQ6GQw33tF/Y/P13IAbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F363n7Lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86953C4CECD
	for <linux-ext4@vger.kernel.org>; Tue, 24 Sep 2024 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727190480;
	bh=mwiuERKQ7FhSWsEGXILVnEeLqXSVv8mLCWupeFdTCrA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=F363n7LfF2468cXxt9qlgEP1NItV3r5x2EJrJEvt18MiE515RAms+cdH5wilpOydW
	 j6+59mwGtpnYPMBM+dT1VH9lQUJ4znFvWJOE1rJSMIXSFIqQllYqeYEi+G6NtQZYCx
	 vWj/qVfQK/7B0u68sUiisHeYjfC+LVNxxvRshlAKn6ARGB5V6AQgB1+uWdSPunyqx6
	 vlUFx5M2wUCCdam0uuFfHwjbZ82VOhRsVTiKUwWaw7XBE/eEhNbtnUzt7H7fpp/QhG
	 5dTcrb0xhqNO2iXdMEGEUY3ejziLCLOcGbnQ/xhGJs64YGNR5OeE9CXpfoGCpPVCOE
	 UKl2SxW/8SZaA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 75738C53BC7; Tue, 24 Sep 2024 15:08:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219306] ext4_truncate() is being called endlessly, all the time
Date: Tue, 24 Sep 2024 15:08:00 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: linmaxi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219306-13602-CqwG6UoiGS@https.bugzilla.kernel.org/>
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

--- Comment #1 from Max (linmaxi@gmail.com) ---
Clarification: When I say the function is being "called all the time", I me=
an
it is being run at fast succession, and there is nothing that triggers it,
solely running in the background. The problem here is it consumes some of t=
he
CPU.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

