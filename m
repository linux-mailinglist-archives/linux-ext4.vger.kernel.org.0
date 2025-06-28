Return-Path: <linux-ext4+bounces-8692-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658F2AECA62
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 23:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDA7176128
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 21:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE8D20B80B;
	Sat, 28 Jun 2025 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwGkHqAe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C0B1A5B85
	for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751146327; cv=none; b=dnvYJFQuNHkhBz1Do/YBQi4dp3nh/xCxPtJN3HFgdbWsfOYTlPKabsIkcn/rUa4v5GQokoT426kRLc5zyDjPCBZfQrkmy0A6VPZkrIB2N/k84GlEv3KkRJvzfAm5dFpFoFh8Ig0DXbU6t0N8eC1FD6utEClRYMfDKevrJQYrbtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751146327; c=relaxed/simple;
	bh=aX1TGXlenjN+lWHLSoWlMATguq58u3qsVeyGG56JdWc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rTGF5ln8jTEpg4fhNctBz8A3ElkYk9RpQBWbjVgywbtlYyDefws0JyLUJgMZW2YD95IpaGy7EsuNUEZbe/61gIfgUmMGlxBHhHlIgekiqxJ2wsM2SyNc4urUUq7ZNm3/hPbZ+EJVunUOWjCF0HKbL90EW2uTdROpOL56FBJ9NFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwGkHqAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA1A4C4CEEF
	for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 21:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751146326;
	bh=aX1TGXlenjN+lWHLSoWlMATguq58u3qsVeyGG56JdWc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rwGkHqAendyRsD2BN6REF88CyzPC6oTM7JWm5e1Azcni+O13WojEnjkWJhjjZmOEX
	 U3QaLGb8IJ9DO82xnwVRiVMjU8EIccz9kOkgjpqbL+lxhPwSzqEmvbbHsCwKVto9xs
	 yvPf41md9lO0tR/STVkUO8fJ+i4C8RsQtv81/XDCQoN9USyvB9597T6XlGczqdXqNH
	 7lRop0jMNmuzK3ggqyVGwoy4q9O+rr5H6Q9qH8rgYLiHge66sZdlpmRBSCJZQ9peuY
	 ZjnXgkOS1SCZ9IWQVEIDxSqeV9K+2vATxVpbfRB3voZzR1Vf2by16NujgLAwSghHi1
	 7vob7b1P2bn0Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9B2EAC3279F; Sat, 28 Jun 2025 21:32:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220288] A typo Leads to loss of all data on disk
Date: Sat, 28 Jun 2025 21:32:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220288-13602-oHDroj5Kqy@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |WILL_NOT_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

