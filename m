Return-Path: <linux-ext4+bounces-4211-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4F797BD39
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 15:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412DE1C2175A
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099A718991E;
	Wed, 18 Sep 2024 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqbuml4+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02CF16FF45
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667002; cv=none; b=W1BxczeyxJFNOeSz/1AG5brYvNOZmn/hby8RoOscTurQ8v/EZfgF5Saz+2jX/LRyF1+9My3ndDDtimRADrGGXpJLLrpn6jpDVzvZZ7KSjrClQzjhP5y59yR0CMWFaWSF9SgUAgELKyCf/ezV1g4zVcxm+UDpHPNpwmy/0rGaZ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667002; c=relaxed/simple;
	bh=w9WOkPJ9DHVghW2LhpEEtbEXcBfu67jc1fX1hBH/xt4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i3okZe/vRlTkxZKpEd1opxa//VFvoPZbV3I90eY925XbPYHuTrZdML/0nVdBlc1MhlE1ZEXFFzT76NXitJ6Dr+n4ISXxjKG+8nIG+reksPRvHSpvxiu06vezmmmXkLZQ8GWcN6GmmwWi0Zy3zi5gsw7lmIlPoOMBAb7Vigk8M/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqbuml4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34446C4CEC6
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726667002;
	bh=w9WOkPJ9DHVghW2LhpEEtbEXcBfu67jc1fX1hBH/xt4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aqbuml4+1UL2g2+uSJZyi+IyuiDnfvlazmQjo+LGs3JzeJlGnxBjN/44zmgaPIusN
	 3pF945uQe7HbRf8fvfjPV+1f/nNLspJYFWzKCGBpzDPi+6/rs69FdCY92WvB0VPXi6
	 sVoZi1ByFDv8WtjJqt/NLIoaqqLTipNoNk0I2hCG0NCHNNHgRHXPr2Ftvap37iMNxC
	 dHbx7sGUyKxWjGNKFbNhVwqfFiFsm2U4qkzhNSu/F73Vl00hYXE3RkcQk18bdXdpGl
	 BxRYl/NA9BNh7Ckt+JYH3NB+Tpzzdi2VydTHhTuPXDxr387xuHThDS+QVkbFKo8lTa
	 PMukNqlvdO7sA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2CAC9C53BB8; Wed, 18 Sep 2024 13:43:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219283] kernel regression with ext4 and ea_inode mount flags
 and exercising xattrs (between Linux 6.8 and 6.11)
Date: Wed, 18 Sep 2024 13:43:20 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit cf_regression
Message-ID: <bug-219283-13602-vFgfmvi3BY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219283-13602@https.bugzilla.kernel.org/>
References: <bug-219283-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219283

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |0a46ef234756dca04623b7591e8
                   |                            |ebb3440622f0b
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

