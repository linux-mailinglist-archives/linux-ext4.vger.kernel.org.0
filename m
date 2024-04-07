Return-Path: <linux-ext4+bounces-1916-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0820089B4B7
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Apr 2024 01:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B4D1F20F65
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Apr 2024 23:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF6446B7;
	Sun,  7 Apr 2024 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKaArJ+S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE01E893
	for <linux-ext4@vger.kernel.org>; Sun,  7 Apr 2024 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712533999; cv=none; b=REVSziypeTl/43ki7CpYG4smL5xQynD9vv8vzkpt77feQFm7JVNKkxcq6lTq83ZjsRGxYMlsn8k0nbhQCvN3z2VkBepDY6vBod/l4slye71fBLOYARMn5EsMD8UMR1w0015P5T+nCzVS+un1GsYH8y8YDVL8amfXumnHRLiWLPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712533999; c=relaxed/simple;
	bh=buD+G6dtXWxPznrIbdJKG4Pghr0FZv5HAGuPSAQb/rw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aik1PK/d7gh0EcEN3xoW/zCu/aktAcPxCqZBfOmnccpZX73OGmwEDVBVnjO0r9XZHDibNGGJR+siWxBUjQdhAf13VkgBIdk1DejqSKLgMPCbP8drTWKI7p2hvfQfRDNHW59nzqXS9/o4kkbGks4WB1BxRBQ7JnqUkdNDxiNAirs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKaArJ+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 418C1C433C7
	for <linux-ext4@vger.kernel.org>; Sun,  7 Apr 2024 23:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712533998;
	bh=buD+G6dtXWxPznrIbdJKG4Pghr0FZv5HAGuPSAQb/rw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aKaArJ+S97TUDnpGuY354CzCniDzHwGje9Ciaojj7Haz5ZJDLiRpU8FD9/hyhorx0
	 kCULGugNB5wNbcg3pobzv1LAniMPE8PAjeeQUGWBktBQ/GCrii79SwhTiMjbWbFGGe
	 Q+rKrJ/OTpL7ofbbqc95i+016Ox9U4eO63cYZWHcqj0jcy4J5yacCKtGJQPodX85Zl
	 dMKl1HzCcUUHO23kOYazmcI/vEg+lkKgfu5zZk15sTM8Q7TDm46HLQEGBkraDYAbv6
	 pwRrqSGkIPLJ0ltvutJZ4TGL4efG9fAT73krahF0y65SXTuwigGFw3S/8GgxAKLdCF
	 gmsrmBG8vXtFw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 340A4C53BDA; Sun,  7 Apr 2024 23:53:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218693] different UI shows different free disk space
Date: Sun, 07 Apr 2024 23:53:18 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kernel@nerdbynature.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-218693-13602-ZsmguYXLWp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218693-13602@https.bugzilla.kernel.org/>
References: <bug-218693-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218693

Christian Kujau (kernel@nerdbynature.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kernel@nerdbynature.de

--- Comment #1 from Christian Kujau (kernel@nerdbynature.de) ---
Please report this to your distributions or even to the upstream bug tracke=
rs
of the applications used, and follow their bug reporting rules. Before doing
that, please consult the documentation of each of these tools how they might
report free space.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

