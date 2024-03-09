Return-Path: <linux-ext4+bounces-1581-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3321B876EDA
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Mar 2024 03:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97321F21C6B
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Mar 2024 02:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3FF2D60A;
	Sat,  9 Mar 2024 02:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgNjWdL5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362FB2CCA7
	for <linux-ext4@vger.kernel.org>; Sat,  9 Mar 2024 02:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709952723; cv=none; b=jpEO8vRO4KtFMP5q5MUAaA+xO/v2XNa9I30ya13J7XMUaALaCRqFJTAx0j0iPgYrof0EMACI4WHyxo6HT9P7PX+ahOs4svdHLKjvtYBictgLvFHbBPbiBAdskgUQJJi2IflS3+DPl7fX7in4tzV+KuFdqfY2vC6SnhYRNqZeDlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709952723; c=relaxed/simple;
	bh=1rS//sHGx0NkjY2PFoPRQ6613Y34IVuwpmLyCpN5Zo4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nEH0WSx46w9ypTpViIgJKzDM3xh1UloHvvOyYUPUkNUkWpMdgMx6k36ExIG2t4eT0H5dwrnhY/jMphNG4dF7Sow/jGhvJnfCMESGkBWlhIDS6uOCpYSgOVyQE20O8K2ulJQ/8vojgO5QEsGA3zGzMEbOcl4WLWqZ1koPZ10XY58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgNjWdL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6241C43394
	for <linux-ext4@vger.kernel.org>; Sat,  9 Mar 2024 02:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709952722;
	bh=1rS//sHGx0NkjY2PFoPRQ6613Y34IVuwpmLyCpN5Zo4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mgNjWdL5UbbZHd6i96Ey7fG3RJiXnw3ggYE4J8BOAJk6XHQKRXygU8t1fVKh3fOyJ
	 zl1q3yPCeRlFJQq8gdPnC2TASWEI/cdnr89rMO4mi9wdhe1jZMs9aGPfbE1CJiDPUY
	 O6UNTNdfddO2i2LM0Le091CbUn2ZiJv6p9XrALKysPawz7O0dScaWpRYPWaa+pOIJH
	 pMGLbSsFezFRMm+Ug2YSmojm1Vt6v0Ia0fdzHXWHnzENBEEhZB3w+coGT/zOEbbBTo
	 R98GSSJFX0OzPxmpUFCUQycTglU4ekmFZZ8m6afmKxOBsojeQIz9iYdeWLkm3jPDyf
	 zcg5Z0Y6dC6gw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id AE096C53BD0; Sat,  9 Mar 2024 02:52:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218576] ext4: ext4_mb_use_inode_pa: BUGON triggered by invalid
 pa
Date: Sat, 09 Mar 2024 02:52:02 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chengzhihao1@huawei.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-218576-13602-XdwNvN3iIm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218576-13602@https.bugzilla.kernel.org/>
References: <bug-218576-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218576

--- Comment #2 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 305968
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305968&action=3Dedit
a.c

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

