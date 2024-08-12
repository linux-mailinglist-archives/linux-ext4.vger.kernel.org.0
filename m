Return-Path: <linux-ext4+bounces-3698-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC43394F244
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Aug 2024 18:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871891F215EF
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Aug 2024 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1252183CBF;
	Mon, 12 Aug 2024 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSRx8Ieo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724961EA8D
	for <linux-ext4@vger.kernel.org>; Mon, 12 Aug 2024 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478479; cv=none; b=EFGbMxXY7GrMTJ3uCHXBoCx/jaJWIGGrmG0o7x8beuPRbk+9QIvdNQZEX1qY1ehpGV4TFMaFPBilZ6ZUWaB4jILOHmSuj6vyBg1Y/uEF+yRMujyB4i3M7dbrds8vJg2b0T0qC0C6Fxo9ZDKC+GPTuuFhueC0hEqTU1rVsfWhoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478479; c=relaxed/simple;
	bh=1hhC02T/CWf0ttWmnrXWBRNAbV8thhtDxBDR11jLryE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=svslFwaF8jseAje729CGrzeec/yfm9Wl7JQyVJ7lpmGE0MHjFXZPx9ClQkISJccAUipN8TcveqB/zVk1RHOJn2WQuHhrXyDajsGMwrzr5ewwsnAQ2hwD9vBHX2NAy2hui07biP1RtyTsbL2z7wq6mNVNuSVhAu4H1U0Oq9OyYLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSRx8Ieo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 040C0C32782
	for <linux-ext4@vger.kernel.org>; Mon, 12 Aug 2024 16:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723478479;
	bh=1hhC02T/CWf0ttWmnrXWBRNAbV8thhtDxBDR11jLryE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LSRx8IeoBW2z8NRE3ebnwQcHTG1Z97HRQkSB7WxUQBjd/kVXtC4AfqY1tk8XEfh+k
	 ri+wDlpODvFp0SVlW+oi9TqeRb8YUBCc2FneAkOeIN1nuNmN7DbV0RnVbaw0Tn9ulp
	 e3qN65v8+bm80rIvYEBsOVurMEmURmWw0Tzz9M498+7vI0I66UQE9u8inuTElBl92T
	 vX6J5YClMY31oFZEndHQOipoeL3obiqQy1fvNy5AQzssmu4L/1drN5iNBZXM4KlI50
	 JuP79BMrIp5oYP4NtCNY0e0MVVNsk465EPA9NqEcT5rrngJq1+5/Gj6JPPA2VG4F/y
	 E9Zix4Z+rHIfA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F291AC53BB9; Mon, 12 Aug 2024 16:01:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 205197] kernel BUG at fs/ext4/extents_status.c:884
Date: Mon, 12 Aug 2024 16:01:18 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-205197-13602-0rd1y0bHaj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205197-13602@https.bugzilla.kernel.org/>
References: <bug-205197-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D205197

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

