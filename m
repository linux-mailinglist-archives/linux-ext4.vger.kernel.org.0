Return-Path: <linux-ext4+bounces-1917-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FAC89BB3B
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Apr 2024 11:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BDD1F214D3
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Apr 2024 09:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EEB3BB50;
	Mon,  8 Apr 2024 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4aO2qE+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A82E84F
	for <linux-ext4@vger.kernel.org>; Mon,  8 Apr 2024 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567346; cv=none; b=L/5L3wB9lVeQf2+lM9Tz+4dymcudFI6Kr5oSRcb/nm6MtFBZSUuG2pLHyYfTdwFcJrXlNEJM65L9n2AE+tNlr4rN62ocEZ5LXJ8fAq+3mP9dKTWoKQUFQeqJt6qip5VwhbpNUjaVuxldBOpCBFjYD2ggRat7Q7qNbAQk/6ZxEAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567346; c=relaxed/simple;
	bh=kMgKKrIIXea8SPnHyLsL/sS7qz6u8dE20+TYvJGqnZ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=djVCtlR5X67J+S4t1CQvPcTEMsZO/r2ecVNNbD3tR+kFVo41JLGpnWvfBwkeJ3KDjIcHIMU63AayHow8LnFAkrWupZdCGcp8oBGlS3UVaouQCSYE4KdisyL/1fkJoyDWFSYfKFA9Sn69pHw4/DEbxbcymB414C8dec5RBHs8Wb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4aO2qE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE39AC43390
	for <linux-ext4@vger.kernel.org>; Mon,  8 Apr 2024 09:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712567345;
	bh=kMgKKrIIXea8SPnHyLsL/sS7qz6u8dE20+TYvJGqnZ0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=X4aO2qE+xmhvDa5dE5+1vTaLtxW7jPuwP4sV1lI872zK2XWzATYmcGl+M+h4c0XvI
	 W76+0IMp8qVPAscQq09QdVGSOEHLc6HV32IaPfJaUnqrx3pSuTXCP1YJdq+VwSWkUX
	 WJVsZOkVEbU7XkFXt/dxDiMpg3gr1HHcO/ygiRRurEuUoYNtqtkh115ndm3ck4eDew
	 Pq33ht3JsG/apc8rs1K77ne08wqotwn8CnMEzCgz1quEVM30ZB29cMOrnBwdUlcf0f
	 fk8nqfHLd/wgkCQJIVzNEBZuE3flT3wgNKPqqu/QvJnhODDYb/76tTmRuS+FudMUeB
	 SoPJpSXL7Bkxw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C17E0C53BDA; Mon,  8 Apr 2024 09:09:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218693] different UI shows different free disk space
Date: Mon, 08 Apr 2024 09:09:05 +0000
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
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218693-13602-Y0vSyxcgwz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218693-13602@https.bugzilla.kernel.org/>
References: <bug-218693-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218693

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Ask e.g. here: https://unix.stackexchange.com/questions

This is not a user support forum.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

