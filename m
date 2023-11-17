Return-Path: <linux-ext4+bounces-30-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB477EFC4A
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Nov 2023 00:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B7D281346
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Nov 2023 23:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8819D4776F;
	Fri, 17 Nov 2023 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUL2gKSc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E614655D
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 23:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81B9BC433CC
	for <linux-ext4@vger.kernel.org>; Fri, 17 Nov 2023 23:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700265228;
	bh=fek62fBaDGeufNCe/DrNF9vz8nZ7iY221VtPom4lSpc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kUL2gKSceDPO1g6h0SprtnPVBxdbWoRn1i12uVvdoamcwjXgBdcCs3GuzAhmdifmK
	 62R29WZwsAUA1qR46+PMIqmNoz1o7Rn4CLZieiiWJeWbnswI6hvOh2Y/c7Z4MN54Wr
	 PI1bYIo67oYtLUiEroyIaFDct10sOT+XIyNs5HGmsJbWAuptuEbshoj1SctxMFNRUn
	 GOPVrGgFfrpDzXC/gwq9IJzLLEa9yTP2DaJrugIzQ1PXAG1NMWqqjA7gncq8OU0pR6
	 3IdNWaQGjYHoneiKRzdjBAIR90dGc6BeBK7Oh0fPgy8eHn+7uEAcKdX4TmgIo3mqIO
	 6neSRk8gYNn1g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 72D9EC53BCD; Fri, 17 Nov 2023 23:53:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 17 Nov 2023 23:53:47 +0000
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
Message-ID: <bug-217965-13602-OXtitJyfyR@https.bugzilla.kernel.org/>
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

--- Comment #38 from Eyal Lebedinsky (bugzilla@eyal.emu.id.au) ---
Created attachment 305417
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305417&action=3Dedit
more perf reports

for comment #37

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

