Return-Path: <linux-ext4+bounces-4212-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D0097BD3A
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 15:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0874B215CF
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 13:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572DD18991E;
	Wed, 18 Sep 2024 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQqLeUP7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91E16FF45
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667033; cv=none; b=o5uTSp1cfcEnr/gqu/nUvhSVjtQCAiSFLm4gg5VdAUoLqDIsBdgiaZ7FnBSdQ65fjUinwf7NL6x6s7QHTDI5XPBGbNIjC1CG3bzoUAeQ9j9BYKXEGzNlANJjNWLztGHkb19Lr0/jC22VLFtpbfLaZNqHMEoS+FoNqWIdRbmtE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667033; c=relaxed/simple;
	bh=AwwXMGJO4hrcKfkortIsSbRJAuLiGmzY+uuekchir8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P+QQvr1qO9ErJVms1GKH1W/PFgePeJdLEpRPQp891M8NoP1sTJIwE5nqPiveCCWR9hbJ/zoqgAIqGcq6V3uUupmK0REQ+1nj+KeG9wSQST9oNwORtfiLxCpTMue1hN8Ha/iAgZAa1No34V8h0gkDgDLB3jbO1JU9lt7FH1OmKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQqLeUP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81A08C4CEC6
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726667032;
	bh=AwwXMGJO4hrcKfkortIsSbRJAuLiGmzY+uuekchir8Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CQqLeUP7x5dNSiaHZS/m+Yg/79AJtJ3GKxw651JmRilgfVpGODMwpFhzoyeTeS/zW
	 EjXKU7Pl4f1aMArN4X57J3vYze7vW5RkOSEwxhTJavnt09Y7YDJoNluShJwhyyUFPQ
	 WFQP4eGisq2kTFAp9PoNgY4050dhcpFZNldw9fiYk4weVvMsstZ5JuZtBond0DUJ2f
	 BnIsvRBrxl6XK2Jj9/pSG1P2aHPMzzutqOvcpAwrh6ghXNetCBgCvML/8dQlHp/wEs
	 J/OLGr9HKDS+UKT1GfFfgOIlj33pTY/EgYC06gyTWnrE0qACOqJf89/dq8sqMQwGJx
	 ZP0Px6dDh4iqA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 78A9EC53BC2; Wed, 18 Sep 2024 13:43:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219283] kernel regression with ext4 and ea_inode mount flags
 and exercising xattrs (between Linux 6.8 and 6.11)
Date: Wed, 18 Sep 2024 13:43:52 +0000
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
Message-ID: <bug-219283-13602-xYQ0B8IskO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219283-13602@https.bugzilla.kernel.org/>
References: <bug-219283-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219283

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jack@suse.cz

--- Comment #9 from Artem S. Tashkinov (aros@gmx.com) ---
Jan,

Please take a look.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

