Return-Path: <linux-ext4+bounces-31-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F677EFC51
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Nov 2023 00:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389F91C2093E
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Nov 2023 23:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1EA47779;
	Fri, 17 Nov 2023 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7QOb2sO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE3747763
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 23:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E41B2C433CB
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 23:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700265438;
	bh=0AZ8B8wrCyZAvGIt8c5ZPLSzFsYZUeORr5TZ/gg+dtE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A7QOb2sOZZtDwKExZf7G3+L1rEv50cwDjuWounI8vXRpSzeqsd2Ovq+SWsQsDOVsr
	 XTxTWaKyWapZ0vBIVrAckf2mqcozpNuPiR3Ajg7wYVx2RQ+FwT6uHjZK7RbsG+vHIY
	 CMEyanvbM3DW9jPRGCjJW7mHOSXc2rEvQZPFCS8KZXB93ujBwLxCDtU1qZ3nKEmQ0d
	 66kxLyoNWmndMEaVbGdDDReqXzeRgz1HyE6XSUdsYxTTdc/w4j5SbQVw3TNqdlpuA8
	 fzLL5aLXWZ4U51gHCM80X/DF2lELAK8Nqmhs39nklEkKlOs9/rw0klnV9eBfgUuiSE
	 RaXu1lT8vJuOQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id CB287C53BC6; Fri, 17 Nov 2023 23:57:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 17 Nov 2023 23:57:18 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@eyal.emu.id.au
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-217965-13602-jgX09tBsSP@https.bugzilla.kernel.org/>
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

--- Comment #39 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
Created attachment 305418
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305418&action=3Dedit
more perf reports

for comment #37

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

