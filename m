Return-Path: <linux-ext4+bounces-980-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 370D183EB6B
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 07:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A849AB210FB
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 06:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A85241ED;
	Sat, 27 Jan 2024 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiOJ872I"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A923760
	for <linux-ext4@vger.kernel.org>; Sat, 27 Jan 2024 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706336364; cv=none; b=aAH+4kib/hYYdRf/MOTFNS5o2+dvsuQayxQzholvPpLDx/AKYpPvBSOCTxDeADxOAqS2DA8yi0HfDKrfK/QDTfXWgtF86ICc87gyCVop0HwFiLkkOMVNO/Jf2X+axc5SY+hQaHgyqKwwJB7gHJxuuqvyNCxpu6F3l+hEk8F89N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706336364; c=relaxed/simple;
	bh=U8/WQAzgQ7wTidfUvtcq/h4NegrDEOpv752jQsCvV6g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X7JEEmfzIS+cZiWPqmHsyhUt7VHA4fkyth8OMSN42PFn8hw2qa9OC1PVfrLiIM100HwWH8NY4Srdb9RoH+JNKyiwvKdjbfJYypB47W6UVAd1+CFSWpOaaQdWjZOK7cLxu7vuvyd10Ltzqj8BFQ1TUsDnzuLIT7WdxwHRcM7K33Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiOJ872I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FE8AC43390
	for <linux-ext4@vger.kernel.org>; Sat, 27 Jan 2024 06:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706336363;
	bh=U8/WQAzgQ7wTidfUvtcq/h4NegrDEOpv752jQsCvV6g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BiOJ872IRhRN8M7PfaJZzWol/m6Ge6wiv5BQ5o95QMvFYkX1awnAU3PXogctvWoZS
	 XDgUk0Dzykpk10S4JA8gSktPRMyVl5xbQzfdqaDwWt1jKn9xA3reI/OeJIpcxFly/f
	 Qx10QSJoB6hix//SKcBmU2CMW10nTW919gtHp92CIh+gpY0qg8+SF8GQi1GryPG2S7
	 4JwTyZuOuSVXE5CnHklRiYY6YfgoakinBOcpePuQ8wpJDL2pkUWCPPodicBnuVBjwO
	 uGtVzO+R78ZSrYwIv/NX6YIP3C5byeSYEld0xsJDhbKs+NenzFrJJ986J40f1ZRyPU
	 WluFZ9zB6ZClQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8CF49C53BC6; Sat, 27 Jan 2024 06:19:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218380] 4.19.304/305 (and 4.14.336) no message 'unable to mount
 rootfs' anymore
Date: Sat, 27 Jan 2024 06:19:23 +0000
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
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component version assigned_to product
Message-ID: <bug-218380-13602-rMVcjNLMEe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218380-13602@https.bugzilla.kernel.org/>
References: <bug-218380-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218380

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|Kernel                      |ext4
            Version|unspecified                 |2.5
           Assignee|linux-kernel@kernel-bugs.ke |fs_ext4@kernel-bugs.osdl.or
                   |rnel.org                    |g
            Product|Linux                       |File System

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

