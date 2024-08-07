Return-Path: <linux-ext4+bounces-3661-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC4794A81B
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 14:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4AB2873FB
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Aug 2024 12:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53781E7A26;
	Wed,  7 Aug 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxjmDFG4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301931E675A
	for <linux-ext4@vger.kernel.org>; Wed,  7 Aug 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035205; cv=none; b=rIsfDB2xo1MMUJMWExFzlyq2B6rTWXoOdoBlisrMa5DIOKRdySJdvjBm/s8fLTefiI0L8sTceQI8U6iYxR3rQuruA4/jfCbrjqBDLBr+lsN9WjbwEAApxMAiS4CeJC908XJZxNyjX+CaGQk9vHsgYrRANdtZeQN1gxt1m5c+v/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035205; c=relaxed/simple;
	bh=IAEPqIqPyhRX2bzeWE7W/ZxjmS6hjkyhbco3336MF6I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jMwQCt4Ph1GEgfgz0qBkJIW95WPApRknxVXC9KCkjwD3vZqGOeOZ11mwjqOaATfhzZEzAetstcDyIRz4/p9IZLk78JQJVONCKRLwyMbI8SJ99+VUG/605jkFp73OSCPDTTGfrGom0J7eSkvUGdbriXtUMDCiYQ3XMzZ4sqxrWB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxjmDFG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05E7DC4AF0E
	for <linux-ext4@vger.kernel.org>; Wed,  7 Aug 2024 12:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723035205;
	bh=IAEPqIqPyhRX2bzeWE7W/ZxjmS6hjkyhbco3336MF6I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BxjmDFG4dKOGEKM5UqpkXMGuINBbnMmiTG44nRWdOCgkZmv67QJIelKK/jlnhwL9C
	 yRoHYQo3LmPJX/rK2oYA/Cek0zVnLgoMupHM9IORnSMuCIKGUph1h+3idgBIY2WdXW
	 VEWP6ZpTt40ErpHN9giNhvRoNoiYuZ6UCn9+6jmL+SBn236WhhwDoZDmd9n2ZQriWS
	 v/bT4xJBhkNOnUib8SBGr6/AkFa/MMgY8C3aZonsm05wk/7dy0IX2BBnq1qxmfChPq
	 tj6gKf/xqC0nB9SYNY/h0HkqpK0rsaEnpdI5TRc447HUgXs87SafYwfLyGl+ZcxrVQ
	 GPAYG5iaRhnnA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F3918C53BA7; Wed,  7 Aug 2024 12:53:24 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219136] ext4: dax: overflowing extents beyond inode size when
 partially writing
Date: Wed, 07 Aug 2024 12:53:24 +0000
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
Message-ID: <bug-219136-13602-UT7PlMldaL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219136-13602@https.bugzilla.kernel.org/>
References: <bug-219136-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219136

--- Comment #2 from Zhihao Cheng (chengzhihao1@huawei.com) ---
Created attachment 306684
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306684&action=3Dedit
test.sh

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

