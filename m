Return-Path: <linux-ext4+bounces-583-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5368202CE
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Dec 2023 00:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914521F22DBB
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Dec 2023 23:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834CC14AB9;
	Fri, 29 Dec 2023 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB3/M3hG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1373814AAD
	for <linux-ext4@vger.kernel.org>; Fri, 29 Dec 2023 23:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87439C433CC
	for <linux-ext4@vger.kernel.org>; Fri, 29 Dec 2023 23:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703892159;
	bh=PprMOEpR0eecDQdbdXO8/gHtQIMLxDONRm8mp+xQ4M0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HB3/M3hGp3AuZBzNUWxDpHSU6O2yDL3DztMxoOWrt8rYG6aUbcIL7oHm3BH4T2pc7
	 gSiy4A866V6nkEdOfbqnU3q09sbyFidC0fQp3gZhEea4v2GPgrc2DrHd3baTEZ5OFI
	 1VNkYEn8Rb6BqsD8Zn/03QO2Ked/OSSOEGmp91qAds9UpJyAsUZy+phgqFSMvdc99h
	 +eMD4L9G7GnY1OdLKXnERJ6oo+nF2IJcDPFORxGBui/VX+tcH87cXB++Bd1iJESw3X
	 Avhi0+3IkD8/ltMmj0Dy8ZCKXoAEtwUYOXHfukIaeFNSd48Fb9C934aCy8LrrbcCez
	 RK8m14soGnc+A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 64814C53BD2; Fri, 29 Dec 2023 23:22:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 29 Dec 2023 23:22:38 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matthew4196@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-Ba4oAH7fxi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #58 from Matthew Stapleton (matthew4196@gmail.com) ---
Maybe it's just because different code is being executed, but running tests=
 a
few more times, top does seems to be showing less kernel cpu usage while
extracting thunderbird-115.5.0.source.tar.xz
(https://archive.mozilla.org/pub/thunderbird/releases/115.5.0/source/thunde=
rbird-115.5.0.source.tar.xz)
with CR_BEST_AVAIL_LEN disabled even though the actual extract operation is
taking the same amount of time with both patch methods and all the cpu usage
goes away in both cases once tar is finished.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

