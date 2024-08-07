Return-Path: <linux-ext4+bounces-3650-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B309949E49
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 05:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D33A7B21812
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 03:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF5E82863;
	Wed,  7 Aug 2024 03:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny0ZOfbK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8681B23D7
	for <linux-ext4@vger.kernel.org>; Wed,  7 Aug 2024 03:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723001597; cv=none; b=QxDijN48NdDib9/w4ozbScNdbTWpemY0L3OYYdMXUpMxtpitRyzfne8+012P+JiC9Wt+2bW4QvwqH3OmZLYA16b1iGR7ZBypx2HAjXMQqhBSG+wHQ4a6FKMftueZ+CBu8qs2mIh1TqZc8k/BQSk5JwcHaMP1gX9B5D32SsOh6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723001597; c=relaxed/simple;
	bh=+90upCNcJMJKNR1/fKs6hhoX2F2OP3sXaNgZKtFBfAM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RpZJ0luYMX0CqtUef4gk/GISuY6UTe06ou/yd/aA8kT/e3BlZNFgEbq3kz0QFA84Hb6/ApYp4yIG+dEpycNsj6bZjDUx9+VI36dV58DIQk+qHiwWj09tkjjpwW5nZM76hlISRVyBPrQpATf73z0pHN9/kCXSV8ILf7gry9DP/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny0ZOfbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DE34C4AF0D
	for <linux-ext4@vger.kernel.org>; Wed,  7 Aug 2024 03:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723001597;
	bh=+90upCNcJMJKNR1/fKs6hhoX2F2OP3sXaNgZKtFBfAM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ny0ZOfbKvQBvNrNkP0BJcjHuhhz+a8PM4+GEfTY49k0+02ATTWw7pmQK+/0ITDNeq
	 I2QeGyFyHcxzT7c7xCv4WK/TxWeZdSUxnTH+oKWTcDeVKbNMFC1xB2cxFvmyj3Z1k2
	 iWp2sAy3WcyuUswbX4QYbDolVAcBhqldQuH8YK/4zY3LG1z87pAipp8Gwpp3Kn+081
	 71gn0eohZl1Pp2qJmXbSRj2YYTxgCFbi/gxkWNHxEJ0VcNSFdhZXFy72BnRqxl9Z79
	 P9+nwWiQUuEe2UhMdnbnlFjNkYQgbTwL4qr4WjO8FplarwxQnEt5tTxrrl/Kw5zFPj
	 aQ8TP2tu/eb1Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0C2A3C433E5; Wed,  7 Aug 2024 03:33:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219132] Redundant "re-mounted ro" message
Date: Wed, 07 Aug 2024 03:33:16 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219132-13602-iWIiqR0MYh@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219132-13602@https.bugzilla.kernel.org/>
References: <bug-219132-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219132

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #2 from Theodore Tso (tytso@mit.edu) ---
The suggestion in #1 isn't necessarily correct, though, because we could be
remounting to change some other superblock options.  For example:

mount -o remount,errors=3Dcontinue /dev/vdc

Fundamentally, whenever runs "mount -o remount ...", we issue the "EXT4-fs
(DEVICE): re-mounted ..." message.   The fact that we print the ro/rw and q=
uota
mode is completely arbitrary and more due to historical reasons than anythi=
ng
else.   For example, the fact that we print the quota mode is pretty much
useless in this day and era and there are plenty of other mount option/state
that would probably be much more useful.

So the fact that we print the ro/rw state doesn't imply that it has changed=
.=20
For example, if the file system is mounted read/write and we change the err=
ors=3D
mode from continue to remount-ro, etc., we will print:

EXT4-fs (nvme0n1p3): re-mounted UUID rw. Quota mode: none.

... and it doesn't mean that we changed the rw/ro mode from ro to r/w.=20=
=20=20

Should we change the behavior to something else?   Perhaps, although to be
honest it's not the highest priority thing for me.   I could see dropping t=
he
quota mode and only printing the message when the r/o state changes.  Or ma=
ybe
we display any mount option that changes (which would be a lot more work). =
 Is
it worth the effort?  Meh.....
.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

