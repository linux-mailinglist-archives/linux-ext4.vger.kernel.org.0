Return-Path: <linux-ext4+bounces-3641-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62104948DB8
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Aug 2024 13:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4B028353F
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Aug 2024 11:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACBB1BE229;
	Tue,  6 Aug 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5EtfI7Q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85264A0F
	for <linux-ext4@vger.kernel.org>; Tue,  6 Aug 2024 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943883; cv=none; b=Qc5b5NfG99reTrYdmPNV2/hOVU567qYbngt1gWr1hGGYQlq0OgoRK8IxLI51uiQmH+pqtI9UblpyA7Jo9jFzB2eDuVe3qZlGBp4dJVj2MY2lhJLjsNYc6VXNLZ/i3+ZztKWaQ6WMeyI16EtsOXpTWb2RbWSJ9oZESbhklD13cpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943883; c=relaxed/simple;
	bh=1s5cO82LzAXJi83bJZXJfULilBG/WEF5wke2bEQqNz8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GIkrAEplA262Vt7hA3uDCNRDhzHkVfLQq7DeunuIAtmSS13jyuMIyHh6aAJPZqUe7VEeD3w3kwnZ3Vo7zXi8SAtc3pGaic/DlmweY2ekxdt+9BJmhpbHKgh0MxwytH0PnpphaYGVUS/h45bD4eQ5DloQ2HIL2bEQzxollQCeRsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5EtfI7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67AF4C4AF09
	for <linux-ext4@vger.kernel.org>; Tue,  6 Aug 2024 11:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722943883;
	bh=1s5cO82LzAXJi83bJZXJfULilBG/WEF5wke2bEQqNz8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=e5EtfI7QJS/rRD8dNc2Bcy78PsybmHktU3XWpNi8SrFBia1VQDUuaG7TlCNf1pDyF
	 lN6NZvw3nznLjxKTGvtrcYE4T1MJsRr4UtN8kBbpm9iRUbpTGA36LUM+y9NoDXei/t
	 yeW4n01MBW41E66OrQ9lVLTmtgxGLMiNr5huq6dQzq5LHAOFu/Wqj8z0K45Q+v5Gyl
	 HW8zAwAm6iryJiHTsSxL9OZMkuIPpj3kdZ/nRCzYIUjIkL0JqTNkGzsNzOVJSy0+OC
	 W/5kdjqFXoXu/01DJAqM5GgR5zMyC3BHQp/X/IMWjVMWwl7maYBL7NdBAhfnJbVS/E
	 mHi3UKFdBMY9w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5FB45C53B50; Tue,  6 Aug 2024 11:31:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218596] kernel BUG at fs/ext4/extents_status.c:884
Date: Tue, 06 Aug 2024 11:31:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: antony.ambrose@in.bosch.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution
Message-ID: <bug-218596-13602-W1i53C3KjS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218596-13602@https.bugzilla.kernel.org/>
References: <bug-218596-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218596

Antony Amburose (antony.ambrose@in.bosch.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|DUPLICATE                   |WILL_NOT_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

