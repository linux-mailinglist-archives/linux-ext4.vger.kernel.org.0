Return-Path: <linux-ext4+bounces-3636-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D565E948DA2
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Aug 2024 13:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132121C23507
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Aug 2024 11:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300EF1C2325;
	Tue,  6 Aug 2024 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EryDBx3d"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A802D13B2AC
	for <linux-ext4@vger.kernel.org>; Tue,  6 Aug 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943651; cv=none; b=OUchDlHnBDjQzV3mewf85v+npXRXAVuji3lNXFBo3XmnCKjNp5vnyvowVshjenkAdmkUFD7YzX0vwHLOmyFW35zw4xbzhLQ94c+tCIhn7pY8guqxXPC0BwbMA3e0vd2BPocSOYQg2gzjbpKX9WM6ideX9JELqBL6uQHFdplP94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943651; c=relaxed/simple;
	bh=lXo6ejxbYQOpX4uRDeH/BUtvYEIWFLKwPd7kdAwYli4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=msOZdHUPG6mvS4JMORA6l+tiBwPQCNidg3nksruvswjsppCJn6wXuOqMTXVnA6T89MiGHDFs02lSGtizpjQmh9vj1qiNb/V3sy5nziNVuP5LLrQv/hojijrj55nsRD2E6qrLJ1krUTvvsKqHuKfkUQDZ0DAVjCtdaln+uqqKjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EryDBx3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDCDAC32786
	for <linux-ext4@vger.kernel.org>; Tue,  6 Aug 2024 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722943649;
	bh=lXo6ejxbYQOpX4uRDeH/BUtvYEIWFLKwPd7kdAwYli4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EryDBx3dJ15MPXlHWmXfUNEzT6koI9GWEMj3kCEz8ms1a3ub9QXrhf/0zZDAePaxK
	 hcNtGuK7otQNgs0VTOX2PX9Q4nI2B+NohvF5kZaznB+QwckTsBNNurku9o6ES7wiv4
	 hWRxfwih6h/d2X0oh3/8iluCPtjLCrsFO8iT4VdMx1GLwDa5iCC1Yxd6fBRsj3Jhur
	 j2uY6a8DYrHilO8HOvnN5u/Ld/H/AeJCGtA8j4gWRSreDlqfFGIPbg22Pu/WnHCt2u
	 Yt7l9E78LubVuD/OfWhbCgfJjWAfkpmW1aJm5pxGhwyl+yS41ZJFeggCQ2LlKEIp5u
	 BheiuWkjkhzNw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B280CC53B7F; Tue,  6 Aug 2024 11:27:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 205197] kernel BUG at fs/ext4/extents_status.c:884
Date: Tue, 06 Aug 2024 11:27:29 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: antony.ambrose@in.bosch.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205197-13602-gM2j02qzLd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205197-13602@https.bugzilla.kernel.org/>
References: <bug-205197-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D205197

--- Comment #9 from Antony Amburose (antony.ambrose@in.bosch.com) ---
Sorry for the very late reply. We have worked on this issue further and
understand that, the issue happen when an ongoing encryption is interrupted=
.=20
In the next boot, when the system tries to mount the partition which is in
partially encrypted state hits a bug on. This is fixed in AOSP by implement=
ing
a logic to identify interrupted encrypted partition. This is not a ext4 bug.
Thanks for all the hints.
I will close this bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

