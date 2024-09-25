Return-Path: <linux-ext4+bounces-4320-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1813998652F
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 18:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488631C25629
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 16:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E54644E;
	Wed, 25 Sep 2024 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1Bib3QF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B193717547
	for <linux-ext4@vger.kernel.org>; Wed, 25 Sep 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282947; cv=none; b=ELpjuBTdwjxTPD/vp9RQqN6xeE6XAUPFbJ6jJRxf2dwYUtY9XT+V345weME5OwxexkriBgh+1IfHO1Yp68PxPmt5wTDV6Qe1dKxNdb1kcYd8OwJSUGIWfdgS2ksCcXQdjIq0w8Z4FThu/YZGXunwP+3Ofuxf7UjwVbyZrEV0qkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282947; c=relaxed/simple;
	bh=DjC4EoGibgkqrDBmULG8gelulhriped2VZwLwIfgEFw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L886s9B5JT42WcvBe7c7pGwzdzvCY+/TY9SUmDGJfnJ+qIAlM4hM7BnPHnT/B1NfYfnMuAsqKWkMP1jTMD/u6Ue2WV/cyv841PqOxrNEhV+oYNei1Bl2zYJUu5oZIW1hbFXovSGZAclHWyrU0f7ii7djAglJ33i22e5ScUlBCSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1Bib3QF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D60EC4CEC3
	for <linux-ext4@vger.kernel.org>; Wed, 25 Sep 2024 16:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727282947;
	bh=DjC4EoGibgkqrDBmULG8gelulhriped2VZwLwIfgEFw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y1Bib3QFePZ/lHz7/1sw0Ae7H4Tel80HciA57gNE5oI1RPPUeFTulMJlvyJVB6sZ5
	 PuLY4rQqXXRAC+daQny9KklCIVQRmUM+TVRjE7GHoIWCLN9QB62OIwlgkMfUHSyJKK
	 T6LLVpgj0zoQn0OZU5wDZ6dvmd4usmk4pKRgbfK1J0Th2Nw3JkUnGYyzZLUqLpKHon
	 mXLdXzOBFgAwv0i9dmyScygaqUv9h2BrSTlY8PcEddrEMUtqyNHqLUB/M6dtbtMbo4
	 obGMOA8dtdDG1TkwiKX6BZZFYEnk/00Z23ldsZ+5yAAuGKzNUVAQr9mGDAg42s8hlu
	 iBKlXYV85XYnw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1D433C53BC7; Wed, 25 Sep 2024 16:49:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219300] ext4 corrupts data on a specific pendrive
Date: Wed, 25 Sep 2024 16:49:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219300-13602-61F719fUBr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219300-13602@https.bugzilla.kernel.org/>
References: <bug-219300-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219300

--- Comment #11 from Theodore Tso (tytso@mit.edu) ---
From the user's perspective, it means that you should stick to well-regarded
hardware manufacturers, and look for reviews on the web for people who comp=
lain
about lost data.   Then make sure you buy from a reputable vendor, to avoid
buying fakes where the vendors claims that it comes from a well-regarded
hardware manufacturer, and but it's really a fake where there is only 16GB =
of
flash to back a claimed 1TB drive, and the moment you write more than 16GB =
of
data, it start overwriting previously written blocks.

In general, even high quality storage from well-regarded companies (e.g.,
Samsung, WDC, etc.) are not all that expensive --- especially compared to t=
he
value of the user's time, and the value of the user's data.   So trying to =
save
money by purchasing the cheapest possible storage is just false economy.   =
In
general, if it's too good to be true.... it probably is.

Finally, if Intenso is a reputable manufacturer, you should be able to file=
 a
warrantee claim and they should be able to replace it with a new storage
device.  If they are not willing to do that.... they probably aren't a
reputable manufacturer.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

