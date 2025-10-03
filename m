Return-Path: <linux-ext4+bounces-10627-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA195BB74AF
	for <lists+linux-ext4@lfdr.de>; Fri, 03 Oct 2025 17:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C3A04E9EA9
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Oct 2025 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4491523B62B;
	Fri,  3 Oct 2025 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibI4EPWd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD11E9B1C
	for <linux-ext4@vger.kernel.org>; Fri,  3 Oct 2025 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759504387; cv=none; b=iv9407JwoEmgUYtLR4cODF1GosFWY1+ZKgaSHaAstpOcUreeyVrvqVh0GQkI/X+sUUVa+ECLw/5fXTrzIoCrS3+6ecUyCngWQOYwgLue5GiA/VWJAr+q4bilEr6zAqfskIZCNMhmizlQ0GI6BZMCWc+Dk7FVu3vQGDcDfoFAkfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759504387; c=relaxed/simple;
	bh=2MT+BD5E+xNHAcLAnJDznlntqPwFq+XBDaoekqHnmB4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MEU15uOlFyVuJ1VznC+wQTiNEDneC6eBsCz/BNF/Jw7w4uGS1JVyBev9EXPO/4IQbYT3NkbPp27vjFN/xPNonSsNu7ACyeGb9mU4bEulKkrP/zEy0bz+UNgtX57YELeDCqCyHIfnMe+tzeoaywjWljZkjVe51d+TxAmqQplbVlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibI4EPWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 502A8C4CEF7
	for <linux-ext4@vger.kernel.org>; Fri,  3 Oct 2025 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759504386;
	bh=2MT+BD5E+xNHAcLAnJDznlntqPwFq+XBDaoekqHnmB4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ibI4EPWdvf8Ro2x1iN21H0V6zQTN6iZR63oTCA2cIMyFehQtab3NhYYDQSfddrNOL
	 ScWYEQsni+i395AEOHc/WMc7JbZaQT62r3kiSrgHJkulKeZkSALIc6SelKuRupHD4m
	 BnsmWYKAF8L91xEquWB8cxHDKLg17HqfKs49SHBmZjwVq/g7bDYkWAyXpHiKHdvDbl
	 987E8bK810KQzc9NlMkupyJ/Abym9wYdvCpjGW7MXYkop5EzUMrclFWZc/Y2AxI+hS
	 +HaNI3mV2Qu9gbyyKISBV/Arcexxankm4gSO02j+h522PzCca2x2KijdY68aLurxF9
	 QkDwj6AQKS5yQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 45880C41613; Fri,  3 Oct 2025 15:13:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220623] Possible deadlock, system hangs on suspend
Date: Fri, 03 Oct 2025 15:13:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: athul.krishna.kr@protonmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: UNREPRODUCIBLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220623-13602-TxidXJjEmc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220623-13602@https.bugzilla.kernel.org/>
References: <bug-220623-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220623

Athul Krishna K R (athul.krishna.kr@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |UNREPRODUCIBLE

--- Comment #2 from Athul Krishna K R (athul.krishna.kr@protonmail.com) ---
(In reply to Theodore Tso from comment #1)
> This is almost certainly not an ext4 bug, but probably some kind of
> interaction with the storage device driver and suspend.  By filing the bug
> with the ext4 component, it's not going to be looked at the by the right =
set
> of upstream developers.   My suggestion would be that you raise the bug w=
ith
> your distro (which appears to be arch)?
>=20
> Usually when trying to debug these sorts of issues, it's useful to determ=
ine
> if older kernels work, and this is something that started failing with a
> particular kernel version.   It also would be useful see if can be
> reproduced on different hardware platforms (which I doubt it will), but i=
t's
> always good to check.

Thanks for the reply. I'll upgrade to 6.17 and see if the issue happens aga=
in,
then file a report with the Arch Linux support.

I shall mark this as closed.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

