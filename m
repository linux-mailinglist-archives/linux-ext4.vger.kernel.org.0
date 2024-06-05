Return-Path: <linux-ext4+bounces-2787-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080328FD80D
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 23:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1331C23DF2
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Jun 2024 21:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B475715F41E;
	Wed,  5 Jun 2024 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGIWavau"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC3F15FA6E
	for <linux-ext4@vger.kernel.org>; Wed,  5 Jun 2024 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621300; cv=none; b=i017zZ4hPR0drF0ktoExa6BS1JwwhK+RbROtqyNJlbeX8PhIA9bVCW9YGr/fcdBc2ttnyZMoKnljr6S4cQ+UgX6N17LF4cWKT81Kfz9HUEUJG2mTL+WbCgfVjANVkhFER9CgViC+vcPboT26I0dOJa2Nb/rs3VVT37zwRq0v+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621300; c=relaxed/simple;
	bh=3lsXWKPvHpdFk3BDB/xEhbUH63xH+egi2KNRE+fwpq8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eniIuZwoBhzCT0A6Bi/CLqtgCsqZEbf0xMKvUcYBY2nEXxJdfvJO5APodiO4i4FJLLw50zAtLwGbcMBEHSXaDT9dRGAhJdSCt/hfo8trV/vp1GLtCTnM+PaU9cfs985YdktympFF4wGuJPgCpA9l47LfbGvfPB4zo+MmnoMj2kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGIWavau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA814C32786
	for <linux-ext4@vger.kernel.org>; Wed,  5 Jun 2024 21:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717621299;
	bh=3lsXWKPvHpdFk3BDB/xEhbUH63xH+egi2KNRE+fwpq8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BGIWavaunPx1488O/mKfnBJH1V/qGqHZC0Kyd8nx37KLKs9bp82+AZiQWqakwcqv4
	 R/WijBTeIxSvt1PWEpO8Eqw80kxl2Nk1mbWT3ATIWujLoDm/zDp1OKD6RUByx/AsgX
	 UzX4v2RUf51rxzHocyL6d5zT1Gs6lxKvn49bOWW2zATmUGhgvIlZ3qjocOvZy7zoWk
	 usR7Sn6cfKoz38BrF4QYbcCxtgiik2tYf2ONLTeupvIZc636gaziR/QQwrAOzPkFAN
	 tMAK5++U+GtdHnLojVRVSSIOEWe1tbtWpgLbSn7wBzDPXNZcfZ6iQi5x6Ez67+1uD5
	 u9DgQWVfGP7IQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9C70AC53BB0; Wed,  5 Jun 2024 21:01:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218932] Serious problem with ext4 with all kernels,
 auto-commits do not settle to block device
Date: Wed, 05 Jun 2024 21:01:39 +0000
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
Message-ID: <bug-218932-13602-Kw82dpSm6c@https.bugzilla.kernel.org/>
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

--- Comment #6 from Serious (sirius@mailhaven.com) ---
Short investigation showed, that this question has already been asked in 20=
19
and nobody has fixed the docs since then.
https://www.spinics.net/lists/linux-ext4/msg68987.html
This wrong information has been duplicated all over the internet (arch wiki,
superuser etc etc) confusing filesystem users.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

