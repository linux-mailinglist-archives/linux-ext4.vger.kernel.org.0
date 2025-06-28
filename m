Return-Path: <linux-ext4+bounces-8691-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695D3AEC668
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 11:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCFF6A3464
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 09:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC22523E334;
	Sat, 28 Jun 2025 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nse/qP9u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F57423E34C
	for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751103445; cv=none; b=IO+HAGvXRjRYj7DY9Kqn2De4asE5DweewUC8IDjpGkgJcltKTmOQwn9T+mjY/YwjVv49D+3OMawghtH46hAhlWfeTGd0fmlW/utVc6yOUHxPd0zY/LuZjHL3nyu1ifVsTqlb1q5n2oUPqYnEt7KmMLgRKoP9TJSqSmhpxlLHfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751103445; c=relaxed/simple;
	bh=88zCVSIZVnkVcqUB8xH15hB6SUBKlIpUCx1JGPz6NFs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RhxO+/hGdZi3Y1BxcPQHISBllnlc06Sv1O3FJzXocwz/XkB+j6JtC/WriEyquse9gtmE1LtUnMPWZEamEtO8dkfUdISv0D6YLjaxvyfvUSWYt4mqG+2dV6oL0vIeM7fESbNss3Z6DhwYCAOFJGRlj6wgKwUkuG0v4wW7vY0Ndn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nse/qP9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35982C4CEEA
	for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 09:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751103445;
	bh=88zCVSIZVnkVcqUB8xH15hB6SUBKlIpUCx1JGPz6NFs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nse/qP9uHLAva+dAXjazyOdy6P4vd2/BlVuY96LT1DWEB4YzrQkrUb11dyyem0inZ
	 ue+xWuXv5zubm6sojJhiUow/KArd9kf7znBanj+UAgShFbpac/SvHDsXYQfeHR2LJa
	 bMsG+xfCYDgNNa+TJpeLhekLfFcavRjABvpgF4ph5UKG/gOffXH9uIaPUrCunjzYsy
	 rdUgZR199U+uSZzkv+oKBFSOs+Gh4tSd5IXaque+MbUNdeoMzZPWVJpebFcfaHTXSt
	 F5MvWW9OQRQqA/Rp9Ha3vnjqh9zfrtf7Fj0tA5hAGyjh2c8yjKxq+RglCO0sUo0r1K
	 xJXau6RRBHEyw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 29A7AC3279F; Sat, 28 Jun 2025 09:37:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220288] A typo Leads to loss of all data on disk
Date: Sat, 28 Jun 2025 09:37:24 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: adilger.kernelbugzilla@dilger.ca
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220288-13602-m7QTl6ULRl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220288-13602@https.bugzilla.kernel.org/>
References: <bug-220288-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220288

Andreas Dilger (adilger.kernelbugzilla@dilger.ca) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |adilger.kernelbugzilla@dilg
                   |                            |er.ca

--- Comment #4 from Andreas Dilger (adilger.kernelbugzilla@dilger.ca) ---
It is very common in my experience that ext4 filesystems are created on who=
le
disk devices instead of partitions when run on servers, in order to ensure =
the
filesystem is aligned to the start on the disk and with RAID stripes.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

