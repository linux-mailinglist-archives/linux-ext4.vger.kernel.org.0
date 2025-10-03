Return-Path: <linux-ext4+bounces-10626-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5F6BB73F2
	for <lists+linux-ext4@lfdr.de>; Fri, 03 Oct 2025 16:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64FAB346615
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Oct 2025 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E62280337;
	Fri,  3 Oct 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1aXYj97"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C458F2F4A
	for <linux-ext4@vger.kernel.org>; Fri,  3 Oct 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503232; cv=none; b=SlAmccu5L5kjHGEODTGWhgcGdsJhvN4l0hHmC+LeM1g598MYD5c2w/bHKtFzKasrfLh1xZTxhpHhLCOZ4x6A8q9RbbPxXJ9VwLxECkda9OFy7S7EuhXIecu9FQkpFp7VESEa42enBDxSBwMrq4nKNVVyPMN0jukINm1dlap7QMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503232; c=relaxed/simple;
	bh=NVs6ojwtJETJ4vJABGcTddPC/a9PBaorqE+Bn965obk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Prk7ZDLPTJe9HJZb7WbY13XqmqRktCIwULQhxPXM23UFf2AazdTRKV0EAedN82pbWCWlY9ap0X9F96EWo/sDun/HRMaJdtigXdK3VhpojH57x2/PIZidyDuMuBm5DYbrNJgM5zbrx4irkVF2sa5SuFSDr4q+N1kwrhtY+xH3MQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1aXYj97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 461D3C4CEF7
	for <linux-ext4@vger.kernel.org>; Fri,  3 Oct 2025 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759503230;
	bh=NVs6ojwtJETJ4vJABGcTddPC/a9PBaorqE+Bn965obk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=N1aXYj970Fm6i95Dpq/pDd5Kfzq2NJjDZ56OEQNPKp9tUaOBSUnVPtVL2iA+iv4to
	 w1fzsYc2qhCDZXXyJf+9W3A8aYJYnl5xwX9S9XLjcmyaCysT2TDTpILk7saSd3Wdu4
	 M9yGkGCRkMWqy4XCi8AtFYbYZrQ1dgSbLgEppSAu9x7SHdQp2NlqZ5gCfwrlHYOcst
	 FWDy/5UUCpN7HK0C2TWMRXgmz+c+0drjZptEYH0DHECEzVhyisyqcq3SlqirfwpH8E
	 p5yIHGzIqf/YrLvkEVt9oWFO02YRB+sJsaSTxsPOQgbNvdXPsDk6v+zf++H5am+ArK
	 byNvZvKpDssQQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 316C9C41613; Fri,  3 Oct 2025 14:53:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220623] Possible deadlock, system hangs on suspend
Date: Fri, 03 Oct 2025 14:53:49 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220623-13602-U2ATN7LswK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220623-13602@https.bugzilla.kernel.org/>
References: <bug-220623-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220623

--- Comment #1 from Theodore Tso (tytso@mit.edu) ---
This is almost certainly not an ext4 bug, but probably some kind of interac=
tion
with the storage device driver and suspend.  By filing the bug with the ext4
component, it's not going to be looked at the by the right set of upstream
developers.   My suggestion would be that you raise the bug with your distro
(which appears to be arch)?

Usually when trying to debug these sorts of issues, it's useful to determin=
e if
older kernels work, and this is something that started failing with a
particular kernel version.   It also would be useful see if can be reproduc=
ed
on different hardware platforms (which I doubt it will), but it's always go=
od
to check.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

