Return-Path: <linux-ext4+bounces-8781-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC45BAF62BB
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 21:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47C93A72A4
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 19:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9632DCF6B;
	Wed,  2 Jul 2025 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxZ4hC8A"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670812E499E
	for <linux-ext4@vger.kernel.org>; Wed,  2 Jul 2025 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751484993; cv=none; b=orDreF/p8Z/xnZovZDdvMjWgbZhY9DWKIzoEyd1y5Ac0bYeTsHSrV+WpQ8jaoPiX9HE3sziGdyEdbonW245I0phJoOqGyFdRmyk57SbDtb5Rk/7DfeYFwspyNdNWqn/9obIFRJ226MkGHutN4IPHIVs7KAcaFlLrE+ADsbS+t2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751484993; c=relaxed/simple;
	bh=CcVSZmHTCpjhffsopTHnafLllDOGhH//Xq8cDyIvHlA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N1QuwAvrHQo4O0WD1BJO/BLwBIp8MxtJmZRTBwdmxDx/0ExYafH0rhFeD66CAtxtBOhPsYS7V+QZh2mkTwBcgLhyMOwDuQn7cSphoQ15kAqPbVMkuw/WQzr9lVgOgKuYpO35jYCtmurAXEa37Mh3T863Gc9/lfNp8fu4fJ67lpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxZ4hC8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E75F3C4CEEF
	for <linux-ext4@vger.kernel.org>; Wed,  2 Jul 2025 19:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751484992;
	bh=CcVSZmHTCpjhffsopTHnafLllDOGhH//Xq8cDyIvHlA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rxZ4hC8AT3q4VfA1F/FbEnFCJZ+ykey+6Cuw3CzWJIGJ/noKEVz+aHROA5QFoh3AJ
	 fcscYghLdGupBVaq8EjzxK0OkgNi2wQii7a/w46Qrh9pZxWtmLgaLAZPeyOtTWg8v3
	 C5IC+0FVpT9dlHnhmx+NneCP2z7Mv5vmoO6n69ZcGuKjqiuqIVM1eVbX8dJ560Xa34
	 FiUTPSc4qARg6afhUvVsaya2lqtQxguwljANgCCBF8RJqzYYqGqUXyjmHpdtJkQkko
	 fWfURByZp4gIA+CdlHXVhZLQsFXuJgEADbGICA8CCNVakMdGoTzL+FxDKgXZUyJeMT
	 Kn2DhxhC3mj7g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D61FFC3279F; Wed,  2 Jul 2025 19:36:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220288] A typo Leads to loss of all data on disk
Date: Wed, 02 Jul 2025 19:36:32 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: martin.vahi@softf1.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220288-13602-vEJc5C9RSX@https.bugzilla.kernel.org/>
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

--- Comment #6 from Martin Vahi (martin.vahi@softf1.com) ---
Thank You for the answers. I guess the issue is then my expectation about h=
ow
the fsck.ext4 is supposed to be used. At the moment it seems to me that the
solution is that people with my use case should be using a use case specific
wrapper of fsck.ext4, not the very capable tool, fsck.ext4, directly. Thank=
 You
for reading my comment.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

