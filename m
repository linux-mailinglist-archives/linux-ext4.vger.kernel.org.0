Return-Path: <linux-ext4+bounces-588-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F2E8216F1
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 05:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF901C210E4
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 04:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06B210E1;
	Tue,  2 Jan 2024 04:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McnuGcBH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857DEC8
	for <linux-ext4@vger.kernel.org>; Tue,  2 Jan 2024 04:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE9B6C433CA
	for <linux-ext4@vger.kernel.org>; Tue,  2 Jan 2024 04:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704170648;
	bh=0jnVLGsz//yvuGJVg7h4w/TMjeun92oVKX+CKLoBj3k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=McnuGcBHzzncxc3JUNL+iar9ZWb6QNZ+hRElIekt+8RXCexc5JrukXQY+T0V8kSHg
	 fva3TqoU+55s3XiserbLRGM205cOP4V/FPKvnvVAtuM+JO7O3nrUJxbitAWwzqrT6U
	 0AtrbOCL2DBsQVWP6U5lNILb5+83UwOd2XRMY+Zf9IO/6tIHCc9ntgYdq9F3nenzPX
	 BZAQJ9ysDJXDM/qpRCui0yDyDA6Q5YBcX1dako2q/oPR6Z1/H42BqwMdf+WtvQXX3q
	 VRPLBMwek+X89LOT47dfDTCM2U6t1doNRA3Cx5X7R5oNTJA8DCUv4bSdlFeoc6z+dT
	 svnrJ9V9TVGFw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A61CDC53BD3; Tue,  2 Jan 2024 04:44:08 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Tue, 02 Jan 2024 04:44:08 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ojaswin.mujoo@ibm.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-QP94tPPNpk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #59 from Ojaswin Mujoo (ojaswin.mujoo@ibm.com) ---
Hi Matthew,

Thanks for testing out the patch and for sharing the results with and witho=
ut
CR_BEST_AVAIL_LEN commented. Would it be possible for you to add perf probe=
s as
mentioned in comment 36 and share the result. That'd be helpful in
understanding why CR_BEST_AVAIL_LEN is getting stuck. Basically, I am
interested in seeing how the scan is happening in CR_GOAL_LEN_FAST vs
CR_BEST_AVAIL_LEN.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217965#c36

Also, another thing I'd request you to try is, instead of commenting out the
code can you run:

$ echo "0" > /sys/fs/ext4/<dev>/mb_best_avail_max_trim_order

and rerun the test. This disables most of the code but keeps some of the
initial logic. Might help zero down if the issue is in the initial logic or=
 the
disabled code.

Thanks again,
ojaswin

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

