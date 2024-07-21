Return-Path: <linux-ext4+bounces-3347-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F82D938623
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Jul 2024 23:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404C81C202E2
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Jul 2024 21:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24FE16B385;
	Sun, 21 Jul 2024 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cugEpCWE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FFA167D97
	for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2024 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721595727; cv=none; b=L8pBRi522hHiBUgSxba/1tkpyabbUklNN0BmaAcobWk0LlPPZ1bmMC9TKnCCDjEOoJjVts7W78SSLbIXi3anc89sBUX0JdrzfYsrog7s29KNNS2tz7QSwQMzvRCNnyk8UICk5oq2H+FLzZIPEw64/fz9jJvdkwiKDWp90b33sjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721595727; c=relaxed/simple;
	bh=gXuAXug0IHzC8zuvi/rFzd0ol+osLJRgwqgZEcFZvS8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hj9h34QXes6jeCqthldNfWEvMJ4B7yPdjPVCn6dEYgQJGtBu64BZTtPi/67YfcVMnkcWl/f0lL5Aa0lvvoRgfjdhUZBvxNUPYpJ6D/VA92mMvkCfHyJmWSl5C8CuS7uAP6ZT7DNEdo/znmbN9UckIZS9qxIhjfumR4RAlbcwXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cugEpCWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C81E3C4AF13
	for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2024 21:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721595726;
	bh=gXuAXug0IHzC8zuvi/rFzd0ol+osLJRgwqgZEcFZvS8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cugEpCWEidU4yrcRJh/QfPkt6d4Vj5Kvuk1PgNTbCPYdL4Mg/0K3bnD5UdchyFcua
	 e9bOr/vVu/ifaXl4f26Fk9WC/45+j96RZ2L7AV9bcN74OR0T8bP5BAtXzxwEkYp6NF
	 OJvpp7CxQyfVFg9Uiqvf2/IUMnraeRCYWAUUwpQABauhi8SgAQ7YUg32BofoV4KB2C
	 YTfFtB0bwzDtoHm3DhpWtDxCHiHjChEC5pnAabOHnyddIGfl3heTD/dpYi4KXI1QNb
	 tgtXvvUQqfAnQSIheKK0lP3QgNfId8JJSV851Y511dWfqDjX+m0If5d74SyUs1DRs0
	 OmaPz+ZIU7J+w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C18DFC53BBF; Sun, 21 Jul 2024 21:02:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219072] After updating to kernel 6.10.0, one of my Western
 Digital HDD stopped working
Date: Sun, 21 Jul 2024 21:02:06 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219072-13602-j3iV8fbzgc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219072-13602@https.bugzilla.kernel.org/>
References: <bug-219072-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219072

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |madeisbaer@arcor.de

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
*** Bug 219078 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

