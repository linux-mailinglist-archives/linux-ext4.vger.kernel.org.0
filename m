Return-Path: <linux-ext4+bounces-4157-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328DA9789F2
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Sep 2024 22:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AE9282476
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Sep 2024 20:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A3E137905;
	Fri, 13 Sep 2024 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aczx4sMY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D405BB67D
	for <linux-ext4@vger.kernel.org>; Fri, 13 Sep 2024 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259541; cv=none; b=ONruhHaXcuY7efdBMdzyl5iOOnnFba1l2X82hlc4f5f/I0+CCM5aPuE/4bpyrNYAuDHK9ARkE+0pAOzNQlpGYGcciFARrV+S/YdAPwo+XVu2FBOoxZNdD8Hirj+peyzZVoBaregesz3JBotxXToIyB2d+4+oPY6BSmbSyPBDzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259541; c=relaxed/simple;
	bh=2DQVKO2lFdmugNtq1Tfbt32zQizrF9Q3NdwU5ij0A4o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BFIox3S2IU0mGZ373MYZh89jDO0naDANiElf30eaDLizFNgIR1oL3abPT45Txdz++iEzUca2Kds2nDRm0iKhLodLY3zME3xfI4BIxFT8usbWnqdhkDV/2hQ5EZ3qHIcoa9WUwhFxnjeWDNdLuB0pZ9TlGH73PTuQolIsb7BCuM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aczx4sMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BD89C4CEC7
	for <linux-ext4@vger.kernel.org>; Fri, 13 Sep 2024 20:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726259541;
	bh=2DQVKO2lFdmugNtq1Tfbt32zQizrF9Q3NdwU5ij0A4o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Aczx4sMYs6UBwXDeuytDHHYlVxyiGgM3yU7lgBnnLoYTeIBk6ksiin1wGvbn1vIv0
	 3S/xmT1VSmMhkuM3NnUhqeYxFx8inAI2t1qZiMTrllWk9RNWiW/iYtgxg+N5/e0aUs
	 LEyM+u5gS/HCePv2pbvEK18rx7r04aNQ6agXaWw6WzzGzEfxtPqDtrfa/eqjx5MVPp
	 mQEsrlzDotP0RSc/kk+4BiOJCYyOz83aZNLyt8sVhw37cHiTWEgVZHfoxmeon7qmO2
	 rnpJE6K6+ko6X0wcJxRRDwfUuSc6Ri1M0gOyFl9f/KB3uYQobzEHdxUT3DAlWUJF35
	 Z1pR2finW6q8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5D793C53BC4; Fri, 13 Sep 2024 20:32:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 202809] ext4: ext4_xattr_ibody_get:591: comm systemd-journal:
 corrupted in-inode xattr
Date: Fri, 13 Sep 2024 20:32:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-202809-13602-7nCHFnzF4M@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202809-13602@https.bugzilla.kernel.org/>
References: <bug-202809-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D202809

--- Comment #7 from Theodore Tso (tytso@mit.edu) ---
Comment #6 is SPAM, marking private.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

