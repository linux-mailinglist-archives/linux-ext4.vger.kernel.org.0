Return-Path: <linux-ext4+bounces-704-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D901824AD3
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 23:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0256C1F21C3B
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 22:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F38B2C85A;
	Thu,  4 Jan 2024 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY/aTctN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149462D602
	for <linux-ext4@vger.kernel.org>; Thu,  4 Jan 2024 22:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83E83C433CC
	for <linux-ext4@vger.kernel.org>; Thu,  4 Jan 2024 22:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704406841;
	bh=iP9LN9huIKomdZGzLm8ktSYoKinpIKFfW1tvgBUWXek=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZY/aTctNUGwf90n8//kp9H5TL6RCLpF7+scvNlz8iqdTdk3JH9/TMwpT0GJdw8vBT
	 /lSa0QjC9Ge55SAmKHH5rT94cePs/TCJ6Rp+uv8RO+h0TDDqw1TGxC0pyG2efrzS5b
	 rTCkqEfPFbESIBG4sLQP/ZjFW0xbsjpf0/08xtbmK8afMzmV8u/vmgA4HXUIwSLdsM
	 r2oJ+mVdxIvjHAP/sAQvWRLOhBSzBxs8iNdUXHSi9txNpYUdVsSNuyNYFcRIzpxTsc
	 t5nB4YNs+EQoMzj6TMUfFpeb6DYtDbE71uyE1QxxHr9ciHga9ebWXH2rkN+8t4TQBb
	 OXayNKshj8r3g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 70CB1C53BD4; Thu,  4 Jan 2024 22:20:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date: Thu, 04 Jan 2024 22:20:41 +0000
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
Message-ID: <bug-217965-13602-w3R39jsVJs@https.bugzilla.kernel.org/>
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

--- Comment #62 from Matthew Stapleton (matthew4196@gmail.com) ---
With top at 1 second intervals , with thunderbird source extract, I can see=
 the
flush process with around 70% to 100% for 2 1 second intervals during the t=
ar
extract.  I don't this this much cpu usage was present with CR_BEST_AVAIL_L=
EN
commented out.  Hopefully the perf probes will show where the real usage is=
.  I
still haven't tried out the perf probes, but I'm still planning on doing th=
at
hopefully sometime in the next few days.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

