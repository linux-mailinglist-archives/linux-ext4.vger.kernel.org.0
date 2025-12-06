Return-Path: <linux-ext4+bounces-12217-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E6CAAEAC
	for <lists+linux-ext4@lfdr.de>; Sat, 06 Dec 2025 23:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3323030074A9
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Dec 2025 22:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204301DFE26;
	Sat,  6 Dec 2025 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnjkWXO1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBC13790B
	for <linux-ext4@vger.kernel.org>; Sat,  6 Dec 2025 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765058473; cv=none; b=Sj62QdyjBIj9XIjr2Alj3bX7EKFshxmNXTV0i5Tw8gu6+BGS6OsUyitW/H2vLeRiWDRwIZKYDj9Gyqdk/ucaaHJ9O2i1amyOxa3T6aXfbrlCcziQ5V9+6ZnwjjJi50OrA5kJ+Swz9jZmTytGDi3e+yzce3FBJOOPiMAjmhObaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765058473; c=relaxed/simple;
	bh=a9A12qCz5aWsXK1Hsgf18DgDNaoVbmLW1ahjZ1oTLCQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UA6SgURdqjoytw8a4JOUxI6bm2U8LiYHLBIYWwrwHYKOFkq7wVnT2GN0XN6hNNPJAycuSi+taBRi9hSo/089NV8sAeTlN4Hpp6CVcaokvIIYGz9NmKABgrEeF9ok0rVH5LxtXGkeo8qf50g/9p0anhoNVQTREwkM72a639yq33g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnjkWXO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48116C116D0
	for <linux-ext4@vger.kernel.org>; Sat,  6 Dec 2025 22:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765058473;
	bh=a9A12qCz5aWsXK1Hsgf18DgDNaoVbmLW1ahjZ1oTLCQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TnjkWXO1ZrLBMFkP95ZwG+Iu5O33P+n+7wysXawI2B9yD5cBvGRMF2htugqOZZ0Bh
	 fJMItNjXEVQzTaJiumGMLpanJrF0N8EOZDJUHAAU72E8WqZUpV+ECjcWeCDuhcMPaw
	 YStp7HJnKW94e7QpxaUH36fFKT+pgPr/yzJmRpc0z4up2VDMsCCi4pYbFGeW0beu4G
	 x7yMAZdNdP9W6pOweHLUJz8omjg6Jhc23ZC+Qq9YdCjG68PWpjA6ZCoz9A9uZOHcOK
	 bWfM07VRkh53k5mNECIn7SRb1KKhXlWZioizMWu3PdUJ+ZI/b2VYxjx4620UXpkPaW
	 SLhxznv3gxioA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3934DC3279F; Sat,  6 Dec 2025 22:01:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220842] dmesg flooded with ext4 backtraces when underlying USB
 device chokes
Date: Sat, 06 Dec 2025 22:01:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220842-13602-sIgBngjars@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220842-13602@https.bugzilla.kernel.org/>
References: <bug-220842-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220842

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #2 from Theodore Tso (tytso@mit.edu) ---
If the USB block device disappears out from under the file system, there's =
not
much ext4 can do, in terms of "coping".   We can ratelimit some the debuggi=
ng
messages printed by ext4_destroy_inode(), but no magic that will allow us to
recover from a failed storage device.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

