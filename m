Return-Path: <linux-ext4+bounces-2784-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 271BC8FD762
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 22:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C801F27A8E
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC9A15A84C;
	Wed,  5 Jun 2024 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E448eog6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83515534E
	for <linux-ext4@vger.kernel.org>; Wed,  5 Jun 2024 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618583; cv=none; b=o3Q4ekN/QgJDUhUDMxHch5Rj7Y7yVgG6GpEwo9JqmSgfhkHxSvdhu9hU3R6+v7npEP/u3BdA+89R+TGNxRu9LXOzhg1JaqykFBsLZqHMJYt8Ftkgpy79DaFEOs0QF8KzkC5ogrznTRLN8sAGkXiG65VXRJ47dMW16K27yUya9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618583; c=relaxed/simple;
	bh=rY4DClMX2pv4AlhyjhxENNoOpHHfu8136HTGG+YFxNM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2ygqIfcvQyCBd6AG1L5GQoXwx/f2Bm1i2uuS15TEUPmg53Rcd+XOROFrsfYraXQeSP39V23toB5cezwFvRiCX8v5Papt53PwUyGjParpxfsEDYi7m+GkeWhriqrtSNdLsh5mx55rUGe+Ey19vY7tj8hjjW/D6G8ejviL8shAr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E448eog6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16EF3C2BD11
	for <linux-ext4@vger.kernel.org>; Wed,  5 Jun 2024 20:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717618583;
	bh=rY4DClMX2pv4AlhyjhxENNoOpHHfu8136HTGG+YFxNM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E448eog6EbLNaSamxF7GiQgDAKIGVQhmlbvHL11/jL6voRasod6nBoG5h8HMf4rbk
	 J4Y/IMiCLd4nOxEEKKFLpxnECr2b8acsNoUI7uAd2E+kE0W3Hd4mQJLnZ4W/9CY2C6
	 Cv0iAGkN+z3aFJc7W2GlF1KVbnvdo7AIafNPqihVH6wJi2y+nLlvLnyZMQUI2RJ4JP
	 RluW8JleAvLNs/3f+o8eRC4nKmnSCvLzN1G1BkSnnRLds2RGRLgY6dhjApN/Y1t7eJ
	 mvzXVs2s3MSjJWIyCNr6f0d+hfsNaSbvk/CCrRrtLNMwoaKAkyziEGAWTbuzpSJcL4
	 9g3GIKP8Y9z8Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0B445C53BB0; Wed,  5 Jun 2024 20:16:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218932] Serious problem with ext4 with all kernels,
 auto-commits do not settle to block device
Date: Wed, 05 Jun 2024 20:16:22 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sirius@mailhaven.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218932-13602-aKIVebkorF@https.bugzilla.kernel.org/>
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

--- Comment #3 from Serious (sirius@mailhaven.com) ---
I disagree. I'v checked value of /proc/sys/vm/dirty_writeback_centisecs on =
all
tested systems and all have 500 value, not 30000.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

