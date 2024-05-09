Return-Path: <linux-ext4+bounces-2405-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA8E8C0B8E
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 08:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E89282AA9
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 06:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD90F31A8F;
	Thu,  9 May 2024 06:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KePV/9Gm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC7624
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 06:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715236518; cv=none; b=ZsMrnsRxc2JMwY3YyCKX1z4v9TeeaeI+Yf/7111HUijdmpNRLnxAe1rDvVNzw+V73bz1ygtc10beEqlPPokYGMDCv7mEFrvcgI/p5X0mAi3wiZ/Ec61Cb7c8uAm/I1IYj59cDvkoByB0ujsk+rhTXxv6UPicixcnpHYoT8lzQ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715236518; c=relaxed/simple;
	bh=MXivLwVSZnQLJerOj8WHSd8RMkIqRMZ1Rrh/7QZUj4o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XxHTnnhrOWrj/24kN5PMHkalsr8A+0n6vtIeknyLj3lCwENTxSRJLUZcxlw16MCZOf0SAQSB7ntPPFl7flC/djtkd/ae9hWv68+tLPB5BYQI72HjqpUOhBe0638nxgE2uwAMDMNMoCk8jSnbRY1AA0wGS2tErY8nX9qZ2JTwcls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KePV/9Gm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4D6FC116B1
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 06:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715236517;
	bh=MXivLwVSZnQLJerOj8WHSd8RMkIqRMZ1Rrh/7QZUj4o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KePV/9GmBNhyRDzBROEfbcGfyJj+9lO8oYd5id9WMJTJR0Je5v9po3kF7HzYB2NRd
	 Taj0mh9rA70sEES/KCSadb3fQ8oxSVmUeReUAjOotUYc39RG7885Q1fTCsescoxGeI
	 fWQuXVfMJcyeeJSFuGGwcPB1/bFSXcpVhh9b5jJOsMQ0FuLWLnD0pSbH9RUxcPw94r
	 FGxQNbOXKGxkiqLVyP0pDTecNxP5fnXJoGXzA6Nv1yDzVKDOHlAqNUGM6Tr6x7JKzP
	 k2DvCPAMAkyVyPNngvO/6IJFWqxphc204+VHXoEK2uJ9r0eovqrrzdftCCg8sbSPhs
	 NepFjtSwIOojA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C8608C53B6D; Thu,  9 May 2024 06:35:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218820] The empty file occupies incorrect blocks
Date: Thu, 09 May 2024 06:35:17 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zhangchi_seg@smail.nju.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218820-13602-TI7bxD02SW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218820-13602@https.bugzilla.kernel.org/>
References: <bug-218820-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218820

--- Comment #2 from Chi (zhangchi_seg@smail.nju.edu.cn) ---
I got it! Thank you very much for your detailed explanation.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

