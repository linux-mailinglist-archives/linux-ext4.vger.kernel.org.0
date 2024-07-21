Return-Path: <linux-ext4+bounces-3344-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6809385DC
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Jul 2024 21:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5030E1F21141
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Jul 2024 19:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34A513D53A;
	Sun, 21 Jul 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1u2m2/n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275375228
	for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2024 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721589033; cv=none; b=TrUZ1H6JYiX5yRnooV7CcnOVjCuafiLzB5BnSqaVmEpSHLYeDSuDjFFlHXY/XyvldhXwUB16aIbuw9yURFGaxOreU5/almjlllzZl8FqvJx7QXGpmJRpaOcNQ/E8u/Dqhi/akDhl7A9vFg6pIIEMbxhVPAmJtsmzsBQeSKt0C2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721589033; c=relaxed/simple;
	bh=6IiPG5dq8StkdhS7Jjl9qEFtFR0QcmPl0+ah2QM8Bk4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BdVEQBR8AIScl1q8yVfT9tnSpsvz/GxQuTDjJZOoeyA69IpzBn0RkLNl0y6umV0DcMcB3nseV9U+V4gZAahjq3DpRXmanuvPEDGBimM5XgOCdKFPCcWV3OmGayF1wRRLX4gfez49iGVZRI4QHiae3HZNAzmYPO8aHK9xDotzm/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1u2m2/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9290AC4AF0B
	for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2024 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721589032;
	bh=6IiPG5dq8StkdhS7Jjl9qEFtFR0QcmPl0+ah2QM8Bk4=;
	h=From:To:Subject:Date:From;
	b=s1u2m2/nGP5WTwQx2XQZ2p5k+RFQRjQyDoCC3Fkn4APYD95SlsBRnSY/RYyARboic
	 baKRDMFksFFuiLZ/oBTMCUJR0ehXAYDiT/X6BB02smeoBSTcvorGSQRrTZrUj25swW
	 gOAyIrZZml2torWM1L0Fl8SaUSgE+SwMT+UAjcUATG91ah7gotRlUvtCqXJEVKks6t
	 gPKPSGJN3qGVwFEpRY1xYgG/pRtEAAWmE1TI6bxdZkVayrbxAf3bGSbKW048KOIx0N
	 Q3XZ2XucgYUVppiNJSzuqzu0xcysz526Ns9Oclc8WepuARKdZcbeTncr6zAgC/p7e7
	 pUjlLz/CDJCoA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 83F6FC433E5; Sun, 21 Jul 2024 19:10:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219078] New: Filesystem is not responding; file manager
 crashes; detected buffer overflow; steam won't start
Date: Sun, 21 Jul 2024 19:10:32 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: madeisbaer@arcor.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219078-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219078

            Bug ID: 219078
           Summary: Filesystem is not responding; file manager crashes;
                    detected buffer overflow; steam won't start
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: madeisbaer@arcor.de
        Regression: No

Created attachment 306601
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306601&action=3Dedit
Filesystem is not responding; file manager crashes; detected buffer
overflowFilesystem is not responding; file manager crashes; detected buffer
overflow; steam won't start

The problem occurs with kernel 6.10.0-3-cachyos and 6.10.0-arch1-1. The file
manager crashes on launch. Steam no longer starts. With 6.9.9-1-cachyos-echo
everything works fine.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

