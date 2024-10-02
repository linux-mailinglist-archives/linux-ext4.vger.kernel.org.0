Return-Path: <linux-ext4+bounces-4437-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4EE98D02E
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Oct 2024 11:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFAB71C21B8E
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Oct 2024 09:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B245194A4C;
	Wed,  2 Oct 2024 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7aNDuoq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014FB84A52
	for <linux-ext4@vger.kernel.org>; Wed,  2 Oct 2024 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861571; cv=none; b=GPfWcqOJDGFPahtpGVcRSohdblCqOw3xKfhierFw4w4xM46NdE/7pYCYm4Yz7QFtmKKIgtYWLEH14oacy2m1goXzwQ4IbQWeE88QJfHsGSYS/RO5FuAsmDqNiXd6GG878SwYoyqTUPr2NXB+xfkCF0SXJoMIudkl6k36gTWAjHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861571; c=relaxed/simple;
	bh=RJCS9/S4Ayw3wBeCyX7zMts1nTLJCVdYq66h2LW4jUw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EaI+3G21l7dmojOzSInEAa+bf2tdqGjPgNekhfzBepbNIzK9GNWOhLFxw1PGehoDhSEOpajLJuvl37fbEEhc4pyhjtOFU4a3RqYHeOxNmPZ4GdoLvBb3zrgAGVjlJmtS0epSqwUbQry2A5/z5rRBJRwu0kFc/8V61fDkYg39Bwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7aNDuoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 926B7C4CECD
	for <linux-ext4@vger.kernel.org>; Wed,  2 Oct 2024 09:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727861570;
	bh=RJCS9/S4Ayw3wBeCyX7zMts1nTLJCVdYq66h2LW4jUw=;
	h=From:To:Subject:Date:From;
	b=X7aNDuoqhD9j+nQJ/3IXkdsv8TXZmx8iQ3J9Pjgu1QWQ3t9bA2NBJ6a6hOIThjSxZ
	 rHYz/EUFs+Wa/ICbDQq/eEImbmBswGmOqKB4TZ60U0J5pu1doWh3nU6k5qi1C6VfJ0
	 +5y8MvLSzZG4fn8VfpgaizTzdngv3uk3eREd63Q/3uNRIQXN0NwGRs9Qzxullbpv3b
	 vRk7t4Fi04Yhc/DFg7CBQNt4WkqH0QzJ1kQUHL8DXavS+B1C7GXwGNCvXMDzczuoxQ
	 9vxHZ1K9IwJA4/34w/PDhxS52+yILYHmKUqVbGzzDClM8/IYv3UiayWcJ6/cugi6GF
	 AcJ95aDgVxUyQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 85F81C53BC7; Wed,  2 Oct 2024 09:32:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219341] New: implement reflinks
Date: Wed, 02 Oct 2024 09:32:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rootkit85@yahoo.it
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219341-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219341

            Bug ID: 219341
           Summary: implement reflinks
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: rootkit85@yahoo.it
        Regression: No

Reflinks are now supported by XFS and BtrFS.

Please implement reflinks in EXT4, to enable use of the FICLONE and
FICLONERANGE ioctls

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

