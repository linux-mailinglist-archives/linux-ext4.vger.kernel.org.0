Return-Path: <linux-ext4+bounces-3330-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C15937D26
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jul 2024 22:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C701C213A1
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jul 2024 20:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B514831C;
	Fri, 19 Jul 2024 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M78asPI4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC74174C
	for <linux-ext4@vger.kernel.org>; Fri, 19 Jul 2024 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721419654; cv=none; b=mZa5C7d5tIAiUB3RysIJSTap3oGeD5cV8Tc58He/rklRf4Q1KUopjkytAabxaCrZUKtMYNWG4IqxYazO6M5GbAHTp2OsI0cSUpEUO/S+7sMPlqX1B42JGakUKSzqOyglXMPnrcPwHjvMWWB62ZBWZrEIWFPhfFI4qMElnns4xjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721419654; c=relaxed/simple;
	bh=d4pEUozROn/JjV2CPxaK6cU1Kf3mMiPlWJpHg+rTezg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fRm8s/VkTpU9A6lkCtH64qthqwWRSxnbyiOUtADQ27hMD6vbEzLn1YDrac+uld4nDZcoDUI7vvWSX//dsqvrZY9GB8riNPBkCY2hA5QzHk0/yFjN2gr2Ij5/s8JXYazvhXsVjIwy0tup4tupIz0K9VL/V4uuE7cA2voCoBKSLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M78asPI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0DD5C4AF0C
	for <linux-ext4@vger.kernel.org>; Fri, 19 Jul 2024 20:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721419654;
	bh=d4pEUozROn/JjV2CPxaK6cU1Kf3mMiPlWJpHg+rTezg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=M78asPI4lH/cKTnNNXD1ccpojWWMd2f74idzwTg9kxdcGTm6HOYgQjGApC1v683rG
	 KT68jE1+Snv7E4rHbZTGmDh5auFuRYhI8VY8Uhs8FoHMXCERJU7T36l14AdpRtF6HO
	 6gForXoGq8Sa8U6+ZE3owkUcSQ6kUVT9wIKhYddDa++C5TfzMFWGWn5ataqzYemhG7
	 mqEAa4o1k6+Gxre5LxEmBeRgdK+0azFd16EMry4hd4K5vVs2wkk7QI4TgrHGT8qaVf
	 3dnFkLmuoYepULe2pMCNSGjAj91dDAqMRCTJ+J+QZfJ1bb7Rx+B1PU+hk2ZPc46rIJ
	 eWLxcyLEtIGkg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DBE60C53BB8; Fri, 19 Jul 2024 20:07:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218932] Serious problem with ext4 with all kernels,
 auto-commits do not settle to block device
Date: Fri, 19 Jul 2024 20:07:33 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sirius@mailhaven.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218932-13602-fYztrQjyZZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218932-13602@https.bugzilla.kernel.org/>
References: <bug-218932-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218932

--- Comment #8 from Serious (sirius@mailhaven.com) ---
(In reply to Jan Kara from comment #7)
new one is better

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

