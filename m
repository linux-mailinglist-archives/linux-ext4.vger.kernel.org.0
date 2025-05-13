Return-Path: <linux-ext4+bounces-7811-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E91FAB49D6
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 05:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D8B4A0C22
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 03:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0041A8419;
	Tue, 13 May 2025 03:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmNvaXrk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1077225771
	for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105381; cv=none; b=FlkyDnDo0LtI3K0i9zdaPqTFHdNDZu3jG0kUKf54/4x/7ekCdl9Z8ZvGKNhgOKZwT6J8E71im4xlSH3pVQhtifSa9k+PilS8tMhQz6toYscBH+8wG7DCXg7GBQNbsmj3SGv8rAKHonaEPjaRVnsG1/T2Zy+YurllzO9GfPNwB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105381; c=relaxed/simple;
	bh=6jexxCRaNTJiZWgye5jR9SYYVdX+2LaA4pgjYAw2FTo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HTsP5BM2gYjxJK/CrLKJtvdR+k5mskLDZ0L1VDrzO6wZqYUNyZEKk1x0O70CwgYtIpshP+qs9mPFIzmlDCZIl41rYKl8dRnEg5SGmBtN8v3c5TzsM7byyMhxDfIebxBkhydLkHbUgh24NNd8XiGA3QYqp/SQzYNitQI65B23osI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmNvaXrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79356C4CEF1
	for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 03:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747105380;
	bh=6jexxCRaNTJiZWgye5jR9SYYVdX+2LaA4pgjYAw2FTo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tmNvaXrk93kbyM52cewl1XTWu1p8xEusGYSqgVn/j3bVmUnSmKZV84UI4H2z65JEX
	 Tur5oULYN7AXo8QvMYbDUUuMuwb/txd9kwRFpx13CTiVVQKtSDYSTssG3GD2OOareY
	 hYrRXV49ROfrcdk4cGJZl9JoAyvjryCF4+6miVJave17USXjeme5E1WxKSEEGOiD6W
	 GfDSj9VFODpyLtAEknzsAkLyffG93q5CA8kS1+r9c7thZUl6Gz4lwhkXo3f2pGTaMb
	 ZpAn/LV0mWTo1y25U58gr3+DttlTjHmT30pj6P1ucdYAwOdv/YRVjWR6x0BgAQrX4c
	 Tuv1ZLWsUlZrA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 6C380C53BBF; Tue, 13 May 2025 03:03:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 205197] kernel BUG at fs/ext4/extents_status.c:884
Date: Tue, 13 May 2025 03:03:00 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lichuan1@hisense.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-205197-13602-pEubYZblf0@https.bugzilla.kernel.org/>
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

Andrew.C.Lee (lichuan1@hisense.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lichuan1@hisense.com

--- Comment #12 from Andrew.C.Lee (lichuan1@hisense.com) ---
(In reply to Antony Amburose from comment #9)
> Sorry for the very late reply. We have worked on this issue further and
> understand that, the issue happen when an ongoing encryption is interrupt=
ed.
> In the next boot, when the system tries to mount the partition which is in
> partially encrypted state hits a bug on. This is fixed in AOSP by
> implementing a logic to identify interrupted encrypted partition. This is
> not a ext4 bug. Thanks for all the hints.
> I will close this bug.

Hi Antony, could you please let us know which patch was used to resolve it?

Thank you for your assistance.

Best regards,

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

