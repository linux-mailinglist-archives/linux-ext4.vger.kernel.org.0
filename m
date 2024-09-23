Return-Path: <linux-ext4+bounces-4267-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F6D97E65B
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 09:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308E42814FD
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 07:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0016E34CDE;
	Mon, 23 Sep 2024 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEVfMfqP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E910F9
	for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2024 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727075229; cv=none; b=RhmsAKvpOfV+zm+b7ijucDrdlVQZbqPEs35rcI//E8ed2cTyZzYq3+lShRisDCd3ManD/85qMC1ZJOf2YZ2D/WyDjZmaZUhVw1YS6nQ3C74JcbEbe4Y3DIlxCR70wGhaVmCe2vOlY0okUaYaXT/WVCl8iVP0RVh9mtPjkosYsm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727075229; c=relaxed/simple;
	bh=Jvg6Pnwcb9ZVigM1Qey7Q+UI5uU6S36ovaE7qLGtWCo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AVJLX/q9mDWKMQ7xW19OBO4vLCZo3ZFTc3BQqyNaLtOIF97vIYqpUltwa5zXTL9bihIf3+jqcmBr17AWxPRjfcRNUtP6Uo4TJPXjGUVNqHm3o9u7Xv+NIyV7Ort4/4SeY9FYJzpyuhQWnQ58BcBiO/ytmJ3fzAtK/jGeII8VB34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEVfMfqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33B7CC4CECE
	for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2024 07:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727075229;
	bh=Jvg6Pnwcb9ZVigM1Qey7Q+UI5uU6S36ovaE7qLGtWCo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dEVfMfqP+I28cVChej9cXlPLbIHfI4xOJz3QdJEld9VufGEKvjPhH0eI+FfiuNY0c
	 b4vmz1qUo/NuhB7Ujd8QtAec+RDryTQYgqBHtf4aRCY63r4jqEZNWW30t+Shro/fqA
	 iHnE4xoKhblUma1kDf6FJUKb00rsGgzHpC6xFxqH/AogCdlOj819JRuRkeySYF4irI
	 3O5bmxt6aggeS5GJLO32uvHlRv8WXeJBt8+Eun0mWBFExoiDK5JQB2LEVhKiH39RvS
	 +q6Nn+K349RQLj0BG+4zt+oRPGTazp4i1RQHjSgKyzQ0r54tzmfozaAqh5W9Z+kGM0
	 opkqy78JrK1YA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1CB4BC53BC3; Mon, 23 Sep 2024 07:07:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219300] ext4 corrupts data on a specific pendrive
Date: Mon, 23 Sep 2024 07:07:08 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219300-13602-mvlZrYKIqV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219300-13602@https.bugzilla.kernel.org/>
References: <bug-219300-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219300

--- Comment #6 from Artem S. Tashkinov (aros@gmx.com) ---
> and so if there is a fake/scammy USB thumb drive

AliExpress has hundreds of them.

Some are even sold as "2TB" drives when in reality you'll be lucky if they
contain 16GB of disk space. Tons of reviews on YouTube as well.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

