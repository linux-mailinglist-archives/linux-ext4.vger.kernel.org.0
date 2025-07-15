Return-Path: <linux-ext4+bounces-9015-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8BAB05E7E
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 15:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330CE3A530C
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D542E54CB;
	Tue, 15 Jul 2025 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsEw3rfB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E911A2E5410
	for <linux-ext4@vger.kernel.org>; Tue, 15 Jul 2025 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586886; cv=none; b=r0VftmfoYQoFIwuO/7Q5urBX/cJ2yWjddKED2oovieejJgEUd2BIQjN4VljPo2XiX0YfS+sL5ru1kcTGdf4cEUSNvIeA/RkPPdKrLQduNUDyWzyivlORqe/US+XgA3rcLBdfOPxY+3SjsOZQz54/2p48NANV/H+KagTafX+dcJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586886; c=relaxed/simple;
	bh=a8gflDQOZ//5EKK/AvLZnDhC1GwZmKEfuSrqWp8kJ1E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PaowhKz2JRfHrJ7QxaJwhxn+dtAS5FAP0D/qXqapYpo8oYY0ZW0FGgjvcXM8m8iwcxMNFmRSx/Yaz75F+MzyQVRGn7bHUeT7K1NmGyXYCRWV4/SpGh67dcbmcN24q2por0tA9eKA9V4NGRuT5ZxGIduhVlhg0R2YVon0wAghYII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsEw3rfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 701D8C4CEF1
	for <linux-ext4@vger.kernel.org>; Tue, 15 Jul 2025 13:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752586885;
	bh=a8gflDQOZ//5EKK/AvLZnDhC1GwZmKEfuSrqWp8kJ1E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UsEw3rfBi2w//ZR4Ox7vr5lEvldqSDwv0UUjFex0YSmZEFFOSkdA2D81fVFxAl3ax
	 65MZ7Df9jiqc7F3FH6eBgOQgHxr8FVX84Pfr5mHUoZ3ZtjKcyI52CKw8YAn0I325nA
	 ha7n37BRFTW/Xe8oV/8OQYVanarkrB4VVWKBSGd4Bo9yddKOg8Tc6ZNi2Vp2fy9oSg
	 mEEJ9gkyZDZpIxHLLz4Jd73/gxPxd+4nUG8IjGJPm5C8BpKx09pWhfP9XajCi57nGn
	 4Pabphdt59jxl9ODIWbu36YLBAinxDm/E626hmgZwuZHKhUuDSc4CpRe71n6UJ2ZN+
	 lHpGi5NN5L+Dw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 66F73C41613; Tue, 15 Jul 2025 13:41:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220342] After file delete, extent index structure remains
 unchanged
Date: Tue, 15 Jul 2025 13:41:25 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bretznic@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220342-13602-DclXUwDTN4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220342-13602@https.bugzilla.kernel.org/>
References: <bug-220342-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220342

--- Comment #2 from Nicolas Bretz (bretznic@gmail.com) ---
CORRECTION:=20

I kept making a mistake in my initial description of the issue.

When I said "non-extent", it should actually be "non-index extent".

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

