Return-Path: <linux-ext4+bounces-10430-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68896BA1672
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 22:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5383A624533
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 20:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C15F31C57B;
	Thu, 25 Sep 2025 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGttf9Nf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935D2D027F
	for <linux-ext4@vger.kernel.org>; Thu, 25 Sep 2025 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833050; cv=none; b=ALyopu1tsVhAgF/nS4RKGKWg2Uy0BApWPmFmSTlci2nnjdVfcDfeCLUisPvBUjyeFUjRyvxAYR+Tfjp+i/EYW2L4tvgg3JPrJpV92ObRG5xPoihvxHcBnWX11tjU8yWk/U/FHfqTK3DbmE8LIj7llh7JSlaMK5S7ODhPS8JKras=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833050; c=relaxed/simple;
	bh=Ym01FFY9F7gCULkZQHtEat+n4KNDV1nYnx9MTTleZ1w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WUf/dX5GS/YyjPbIYSJ/3SRbOODxXZFEUwHkfbgt/vpVFfMe/rdiX01H4XvveK7Hqvo0Xj/AzydFlQ4LYW8Vt3OLxs5P7YDBnfnpTdTfp3sjhGWtQTtP0j4q039EcHVLJFupn/cGdF1mf3gARA+3qDyQ9SeOjgBYNpav9aOplYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGttf9Nf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E71EC113D0
	for <linux-ext4@vger.kernel.org>; Thu, 25 Sep 2025 20:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758833049;
	bh=Ym01FFY9F7gCULkZQHtEat+n4KNDV1nYnx9MTTleZ1w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tGttf9NfoAfEYomquFxevp9UmmNuS6agftQQqS/3djcJ30EgAIIpaOQ85QUcpU4LG
	 jWYFpWPnWh7hX6shZ8t0QQConTITrRVte+nIHbdL3OnJUmiTVzvtF7KZLxN99ZlGkq
	 iskwcLnNc/9cfAV0xP4ajiziQBvsk0JWYSFf71opbtdNI0/zxAbY05iMLJ+F1smxM6
	 b2ct6C+ib+BxqjyyP97M4Sf2Z/B7Fa/2dPdzXD3/SKUaQryoNajo/qA0W/LjiIiELj
	 54lmDSMx9HORfSy4OrhDxyx6D4LUR89XqWqrAqPh6VYVY1Nq5S9h/kdwWHkvkqHHoU
	 kxB9IbwTMcXFA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9329CC53BBF; Thu, 25 Sep 2025 20:44:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220594] Online defragmentation has broken in 6.16
Date: Thu, 25 Sep 2025 20:44:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220594-13602-nX1S3k2tBe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220594-13602@https.bugzilla.kernel.org/>
References: <bug-220594-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220594

--- Comment #5 from Artem S. Tashkinov (aros@gmx.com) ---
I've emailed you privately/offlist.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

