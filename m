Return-Path: <linux-ext4+bounces-4265-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5323A97E4A9
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 03:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097BF1F21139
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 01:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461B85256;
	Mon, 23 Sep 2024 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shnES7p+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8F74C76
	for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2024 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727055563; cv=none; b=S+fy4buyUtodvrHWCKJtHeF7Pb2Mk7vUiyMpfnUSQP/b4v7rAvJaVfLXu4K2A/QGC7OvtTiQrr747giCXeHOK5NHVKBn7fjIcUVRcOtA3QtC9HpSYLXKlq8t6Q9T2f6NnJADRvh+ZUTqz97CdONGRp/BQ3LgK6yeZR4IWK6OlJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727055563; c=relaxed/simple;
	bh=2PnIEjNepBnKFta7FBC3PG+U6/Bn5ZQwhMSrQ4mmDXY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MuUTyVlClKSZ86M2R4ukWqsNkvsFffQsQdsqLI/J4+5TXXS+JWRkTOqn0qa4hnxc3u5kHeCqV5kHeFs3Fu5pIIFjYDQMknORlVVbq38EePTRSI2ynP5azJbr9XipPASSCNyqWjYrW1tkkO46301FDh/sU3K9SLD149X7JHQJL2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shnES7p+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DB23C4CEC3
	for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2024 01:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727055563;
	bh=2PnIEjNepBnKFta7FBC3PG+U6/Bn5ZQwhMSrQ4mmDXY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=shnES7p+lLF3jGme1fseTT+w3VsvJ/D76vhrD33/Qe1jewxGC9RP4WhOHZnyBpG40
	 oouta5EjLwC6STaamc3Y8pGTJQIJuQM8Se1cxPHXcPkdwJnFRtOKproSxzTbI3P2mL
	 KIQxjducjljS34A1FSLLVmTB5PbpunkBv7wAIfW2sXviCfZc7nIsvfSCLALNSOsgPy
	 bKpax3CmuF8ZbP6JG4NeChe2gyUPHtpcgzPJ/goMTIjQCg/khhA/3tA8fIJPNFOnBw
	 uvuJguOZTfhuu5BBrHpqheEEg5CgUopUw7eyZ1C5TAJvC/eTw+F0pE8E5nSqst/1EL
	 x53waVFkL8rRQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4D536C53BC4; Mon, 23 Sep 2024 01:39:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219300] ext4 corrupts data on a specific pendrive
Date: Mon, 23 Sep 2024 01:39:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: linuxnormaluser@proton.me
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219300-13602-FwBgWQ13Yb@https.bugzilla.kernel.org/>
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

--- Comment #4 from nxe9 (linuxnormaluser@proton.me) ---
In short, in the case of ext4 I can generate an error very quickly. In the =
case
of ntfs, I was unable to generate it even once.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

