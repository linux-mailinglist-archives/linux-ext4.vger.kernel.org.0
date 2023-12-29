Return-Path: <linux-ext4+bounces-581-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE83820221
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Dec 2023 23:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A030F1C22419
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Dec 2023 22:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866E714A9C;
	Fri, 29 Dec 2023 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrfdmk4V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E014A90
	for <linux-ext4@vger.kernel.org>; Fri, 29 Dec 2023 22:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E921C433CC
	for <linux-ext4@vger.kernel.org>; Fri, 29 Dec 2023 22:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703887989;
	bh=UP6UdISscBOd3YqNagCLOig5evkTJXDBL/WgU3YTiLE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rrfdmk4V5kSzfUZFyXqbpZT8Yf4cXY6xNlzvmt1mIvIwOtXdBDgBngvNwBbyX392T
	 /BV+8WElhZr0DkVzj6cl2unmRIYrxSQrOcRmP3yCNSmwr3RS3XeVC51VnxCVmFOPvY
	 etk/G8Iw/H8sTdJ2rpA6BAYOpp8NUY4va4XrUx44WySXV3uZsJoi9qkAU6t2qtRTS3
	 6ckGU3W1kW7Kv4t6PnxsdItzaxWjOqGKnZaFUCJR4IhYLVZuMXe7dUJiJWvFlTn52m
	 S9AIzMgL2Eb7Bi+3m99FQ/4femxylctKj7d2beCQzqKFw3RtYL66YK/ejLgQPFtJJQ
	 vsaDHyBCOjMOw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7B773C53BD4; Fri, 29 Dec 2023 22:13:09 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Fri, 29 Dec 2023 22:13:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matthew4196@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-FNs5CS3ywC@https.bugzilla.kernel.org/>
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

--- Comment #56 from Matthew Stapleton (matthew4196@gmail.com) ---
Correction: It was new_cr =3D CR_BEST_AVAIL_LEN that I commented out

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

