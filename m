Return-Path: <linux-ext4+bounces-11377-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43700C22E17
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Oct 2025 02:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D654C4E228B
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Oct 2025 01:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D9F245010;
	Fri, 31 Oct 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipC4AhF7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE823BD1B
	for <linux-ext4@vger.kernel.org>; Fri, 31 Oct 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874393; cv=none; b=Zxi2F5yEyQC78H40YNMwcQbssXPHZYkSoEXbCnMXwpcUkkmp5IzuFaftOO2zE9yaICpjU57ukUFIv4Tzq4CUrDhsxqw18Td43E/T5wW1NP43W6ZXUcNMmKdtA23XsRn0XNHIKpKrWTvjA00PK2aBc8Aqbnw8Xq7njHUuzgmysno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874393; c=relaxed/simple;
	bh=tC2ieDuhmVL9P+c4ta0VFAlC5N1lvbPjR4c8wyWx0wY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=url4g84meFXKkXiywO9Jnk7ZAl+PeSgLqh35mZFxmq5/QSkewQY5WLGY9N8iBIiR418xCBXWQ8VpJzLO/3dJDDuEUoSchRp4kZ4y3fEvrxTEtG6c5P8DEERDJX7NTWxYOO8MfMhajg/AwoRkAadRGlfLDCyE8mxdv7krrfneCLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipC4AhF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0930BC4CEFD
	for <linux-ext4@vger.kernel.org>; Fri, 31 Oct 2025 01:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761874393;
	bh=tC2ieDuhmVL9P+c4ta0VFAlC5N1lvbPjR4c8wyWx0wY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ipC4AhF71SZuO1EwcdtrirVcPb86OKAkwgC3/Q78E/JyBej/29O9l0+fYlv0L6vd3
	 WSM9o5PXKJbN1AQuR55CjBh2nUNohAk+Ct37gScCrOS0RZPGQ0P6vvP7gmCI9aBm4g
	 JtS0itgJpnq3qjlytb1U/+916gPv2vQr/FhufqHbIm1RPTMfY7mkAUN6EmBkHgzjAU
	 Pikqvz/6cJjsFxlFiK1X3r+agtwsccl8Lky/2ugDpB0ABemuXYYpZy9tWwbGRW6VqB
	 8PFPvG7bp8jNQDWAiqqvtJuexhH0uixoGufzChqWVPc3kLHVtXxJZ58MGOxi2w6Vf3
	 sRjqLPn4DFV8w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id EFB5FC3279F; Fri, 31 Oct 2025 01:33:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 203943] ext4 corruption after RAID6 degraded; e2fsck skips
 block checks and fails
Date: Fri, 31 Oct 2025 01:33:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bluesskymoney@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203943-13602-l1oiljyu0u@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203943-13602@https.bugzilla.kernel.org/>
References: <bug-203943-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D203943

Arnold Henry (bluesskymoney@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bluesskymoney@gmail.com

--- Comment #9 from Arnold Henry (bluesskymoney@gmail.com) ---
I have got the C-Media CMI9880 codec chip and added the line 'snd-hda-intel
model=3Dfull_dig' to /etc/modules, but that doesn't work for me (kernel 2.6=
.24).
rmmod before shutting down is working.
https://blood-money.io

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

