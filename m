Return-Path: <linux-ext4+bounces-3890-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9242B95FDE4
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 02:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F6B2834DD
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 00:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711EB2F44;
	Tue, 27 Aug 2024 00:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8jlcM7a"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E152CA9
	for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2024 00:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724717099; cv=none; b=QvVr5E6UAXCf/kNS/Qb50sBvxS7VpyRMUDlM7RwKR56d4gyLaoURFBDifg9B14ye2FOXVT0mWJ24g+Ky0mD8ePoTubng1Rz7WT20ToDCSt6feYHQfxFXfH8hE6VAtj7caNZ0Xq53aVb95WtTWhuQLMgqY20hVuLGf19QW1qn79M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724717099; c=relaxed/simple;
	bh=PVycRaSBwEucacJlkQ1VjWn514vtBW8wWkZptDHCH+E=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y0ZTxKr/a9BOUfl2wfp4PICGFp1/ZsPU9pnajl5FlG29diHX3fSE353Nye/tJEC4sCDPthURbFmfRNWgfmhj1CLJcxykqXT+2lVRBKJN79mEvJfkx0CJ/HlsCickl3fFLvH2CdKua1Hs6HlDdHRiy4VarD26tra/wH5ZK9uxXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8jlcM7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B034C4DDE3
	for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2024 00:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724717097;
	bh=PVycRaSBwEucacJlkQ1VjWn514vtBW8wWkZptDHCH+E=;
	h=From:To:Subject:Date:From;
	b=s8jlcM7aB8samZgIE2DcJnbXYbbnamFck2Ri07B4gfvotyFeEBTflGAMG1AvyLwIX
	 qZ1tRiW9tJt+HTQvtdflqi+NH8xvLLfJS/EqWb+xsUbL+S6m+45MBk9tKtec7BGrOF
	 XFzyCbrhaQTpwY5zsC1dtZgz1iFTjJeDWPxkZ/MC7+B9JyR/tSBm+m8jis9hLS3jw5
	 fXmhpw5YYOCbcxfg4IBTfVm1R6LHp63oeLXLNvDcZD/I4aGgb0QCLoC4v2MUtjy4Kt
	 6YrsnCq3BgkW8YTSFVC2HIYHjjarpCrgdab14pSuAyaUf3+U9iKeqWy4E8nK0n1T5B
	 U/PpXTVr8W2CA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 37D81C53BB7; Tue, 27 Aug 2024 00:04:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219200] New: update from 6.11.0-rc1 to 6.11.0-rc5 causes file
 system check every boot
Date: Tue, 27 Aug 2024 00:04:56 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext2
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: publiccontact2020@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219200-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219200

            Bug ID: 219200
           Summary: update from 6.11.0-rc1 to 6.11.0-rc5 causes file
                    system check every boot
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext2
          Assignee: fs_ext2@kernel-bugs.osdl.org
          Reporter: publiccontact2020@protonmail.com
        Regression: No

Reverting from 6.11.0-rc5 to 6.11.0-rc1 resolves the issue of file system c=
heck
at every boot.

This issue is observed accross Debian, Gentoo, Arch and Fedora Rawhide.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

