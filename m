Return-Path: <linux-ext4+bounces-2781-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 423058FD5E2
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 20:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79687B26350
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29798482C3;
	Wed,  5 Jun 2024 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coumnRIX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5019D8B8
	for <linux-ext4@vger.kernel.org>; Wed,  5 Jun 2024 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612761; cv=none; b=DRr9OQLmmWIhb09ew/LYMMVzvQ0VUPV4vNJJ3vmQ8mXdykV3dcK6kL2SNlsUDXOHEpHe0cwlcwduCT6B2flz0rqXI3CDpSx86GBzUn9ZTOoZBYesHpfgF741nf2WWSycw1F97EiFMyM+Gk8BFfrLUQzJJ0plEpiTKvg6zVAB+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612761; c=relaxed/simple;
	bh=WicJDSXfwUbaRw1UxFhEJSX6Dk/wUIHTSB7KU+ik80Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YVt1uggvp0HdaCoSc9wR/kuVGCpdEquja0kjslZ8mpOYEYpDk11RVBL5Nu9+Ou+02k66jVjsOAjVEx2g239Eh7AT7vHrjpiMYDWfvEE5TlLQcwQc5Bg2MX3jJlHRduvOzjX3uQcujg13I7D0zUERVM9cLlB+twAKPorEuNSlEJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coumnRIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47DF1C32781
	for <linux-ext4@vger.kernel.org>; Wed,  5 Jun 2024 18:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717612761;
	bh=WicJDSXfwUbaRw1UxFhEJSX6Dk/wUIHTSB7KU+ik80Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=coumnRIX02k2xM8GFNqTgGKawtxxbkmvPQq+UNj4o7mJflS/oSl5O8xfe+0aPGTxi
	 shxqoYsy1weX4Uu8g5CrfcWG+fexvtbtEM7ddoqQNNVtnpyiB+rK0gbOMnXSadijRJ
	 tTXE2goCp8T7nvjDakSyp3TT6u332Wz3g1ZGCnqYK4Elh6te1r3/3sgL2qAvyh414e
	 LlwUJhF7GoFrzPey6HjE4pMGirjyw/QfRh7buPi0FfbIZxf3BZH/vniFerzFStDb5Z
	 n2K5R4Asv9KBZhnQrTa20kjtA0HV4PZG9dH0Xpm2TVa/LdxW1b2JEpZSNdtA8oQi4/
	 JB5jwg/oALfLg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 3AEE3C53BB0; Wed,  5 Jun 2024 18:39:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218932] Serious problem with ext4 with all kernels,
 auto-commits do not settle to block device
Date: Wed, 05 Jun 2024 18:39:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218932-13602-zRt8vHqtjh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218932-13602@https.bugzilla.kernel.org/>
References: <bug-218932-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218932

--- Comment #2 from Theodore Tso (tytso@mit.edu) ---
Oops, replace "cat 500 > /proc/sys/vm/dirty_expire_centisecs" with "echo 50=
0 >
/proc/sys/vm/dirty_expire_centisecs" in the previous message.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

