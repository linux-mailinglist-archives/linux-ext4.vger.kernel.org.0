Return-Path: <linux-ext4+bounces-9747-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1C9B39E8C
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 15:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F557AFBB2
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 13:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8285311952;
	Thu, 28 Aug 2025 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuyCMoEv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D73115B2
	for <linux-ext4@vger.kernel.org>; Thu, 28 Aug 2025 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387124; cv=none; b=RCS8mm0P3rSVRchNa+c82aZMQKXWpIcYvYm6fu3+4cAb5mMl9MyEPsHJ5CiFKlu+v1bNL9vJQwKMNod7jZavgMuleHrP8m72tRJBbGuRTBpC880dUrinDRHn4qsjOYohb+wN/zNNvT8YBfhN8Vs+UAVRbvaBmbsX45yUW4VSeZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387124; c=relaxed/simple;
	bh=UWn2JpKSOMJIolhjI3oRy/Ynzb5mqDH4/kNDuAxQ2/0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GgpjEUbY4JYUXKGp/ndvqEMBm/Iq5urvos4O35DGSVxWqo8Wy24SsGB7HNh/D3vH/fyDPLx6QKbS9lNZ0SEivgCjimBd1FqnY1zEwf9RUQ+8gBiPdeYLvQc6SBVvCMmA31TCUYnJ5ylyIjIRCt6MUG5LxBNv9BihY/++AkDWIOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuyCMoEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 061A9C4CEF6
	for <linux-ext4@vger.kernel.org>; Thu, 28 Aug 2025 13:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756387124;
	bh=UWn2JpKSOMJIolhjI3oRy/Ynzb5mqDH4/kNDuAxQ2/0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NuyCMoEvg7iYJEnlcgyFLsHm5a7p3zRHCUYNg05pgquD3zzuP6/cDR2mUBrror1TE
	 JYuHUFDawuubh9aK90dzFNFNjmLRRlUltpfKIFnHcxfiADAJJrdx7IT2sYWX3FbVAF
	 BfwrYqbRnnrr3TXv9RIqe5NPb/VMuAsM3IEw2iab1nHSfsU3Oy4+B9G5x7q6uLlgGJ
	 cBTgIQ+JldXsXVRTbJTq0qn00FfonkUHyc3JUYWGC6SgXebrINrYklfvp3pDOVGHmw
	 YrVRzmtykt3POFZMAbcRCdN539KC4j3uWnwprxhthabSLSgk+9l8LmVJI2QamrmYJO
	 Bg3SCNy4HT2Lw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id ED4DAC433E1; Thu, 28 Aug 2025 13:18:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220506] INFO: task sync:4678 blocked for more than 248 seconds.
Date: Thu, 28 Aug 2025 13:18:43 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
 fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: component assigned_to
Message-ID: <bug-220506-13602-bqhVAjO6AL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220506-13602@https.bugzilla.kernel.org/>
References: <bug-220506-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220506

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
          Component|ext2                        |ext4
           Assignee|fs_ext2@kernel-bugs.osdl.or |fs_ext4@kernel-bugs.osdl.or
                   |g                           |g

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

