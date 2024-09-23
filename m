Return-Path: <linux-ext4+bounces-4278-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF7897EF4A
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 18:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AD5282359
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 16:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B1019F422;
	Mon, 23 Sep 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4/oGQk2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C3019F407
	for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2024 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109005; cv=none; b=qhzt84jk//O5hrjzDaJfamRtiDOFXX32RO/bZAUL7O+Tcr0WAITsXNUHORzBKcCWLqWyqYFoqycKFuZagL96z3j2yzVqrKXcP4rGXvCPXCX1oTsvgtFedrhStUafY9lHBWb0jmvNugt1YZfZibbAPG0fJfbSKhbFEojAYKDo6Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109005; c=relaxed/simple;
	bh=BoFcgf4Uyi0BIDAU7jFoxF+YZAhhhRsum5pHmD4iXdE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2BQmbXWcJh2v60H9YUNwYS9AbfsvtirPjIr/5D4gdgBVEGBg11peectd7XmWaGH2lZf3PVwbqVS3LI6kp2KA2jSd6cvLEu2CLUClFCJ8/16xs8OZ9Dqrj5ebEB/tdGWLLVTC8RBBfIZmhinmStRI5lPcCxhPUZJDbv6D/Y1JWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4/oGQk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79A0EC4CECD
	for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2024 16:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727109004;
	bh=BoFcgf4Uyi0BIDAU7jFoxF+YZAhhhRsum5pHmD4iXdE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h4/oGQk2Wb/klOK1v1oDzORdJbkccoJSu8zBWbPKcLgxNnEMquYx8R4EmGWmFdrh+
	 HsPM1n6AYIcLeDQh0wAmLclah/PrPytiKeXNEPnEoTaLumLiwpIdQ5LIE4SaCywh6Q
	 7zREWqz+zmv/OTE/TVzVlsc0QDBXfTedCjMuzJi3hB3XkwKocfZNitCCSDEPJVuSlE
	 0hn6EBuutt5asEFEeToBUxlu2TKT0F7xS9GDGDG4HVaxijyveqZ9F5L31BAsIo+tIE
	 rxzpMFpcHBGF5mKWkGIZKM9VybIQDEOllTIuQQrbctsXccoUYPm2Au65+wCc7XMi51
	 p+9KyXDK0qGKQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 56AD2C53BC3; Mon, 23 Sep 2024 16:30:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219300] ext4 corrupts data on a specific pendrive
Date: Mon, 23 Sep 2024 16:30:03 +0000
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
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219300-13602-2hpY48ykF3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219300-13602@https.bugzilla.kernel.org/>
References: <bug-219300-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219300

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|aros@gmx.com                |

--- Comment #8 from Artem S. Tashkinov (aros@gmx.com) ---
2 billion Android users use ext4 daily with zero issues.

I/O errors must not appear EVER, I repeat a normally working mass storage
device should NEVER produce a single one of them.

In fact if I get a single IO error on any of my devices, it instantly gets
wiped and thrown in the trash.

You can tell a FS that certain blocks are bad but if you value your sanity =
you
should not be using such storage.

Please ask your question on either:

https://unix.stackexchange.com/questions or https://superuser.com/questions/

It does not belong here.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

