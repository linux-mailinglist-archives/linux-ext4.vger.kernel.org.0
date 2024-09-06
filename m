Return-Path: <linux-ext4+bounces-4081-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E17396FCAD
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Sep 2024 22:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598A61C229AE
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Sep 2024 20:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31061D79A1;
	Fri,  6 Sep 2024 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpip6UGk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCDA14883B
	for <linux-ext4@vger.kernel.org>; Fri,  6 Sep 2024 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654494; cv=none; b=uGtcDZZuR4H+AnXrvJmvDA9L9hO3U8Kmm5Xwmsju8sy60WsP4iO9iJ5NsQ0FfQqKq2H1kjaeYd0VqzPjXQggc3tqYBUjAjeiXu5vcQokhi603yXREaNWD8mGYlmdoMSlQ2/kVlN3iZfvfdmj6uK/dVn3iSBQvN93KOaNJGFHO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654494; c=relaxed/simple;
	bh=R7XtTmWDJQMoJfJhPL5FpF2ZpSR+rT4OZrPio/0y/r8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXMxB/d1RzhRUNLo6grKduWcNSxV+tfyDIR5jZ2HvYo8ceI7l1Mc3BP11nK7NsJeca8ddkgWtS84h+1+scIswRMg93IK+t3pNQFw2uUn0OgHfPtnHMPY4v81IkB+EmPPrZYeZNhmRD0x04h78gggqHc/AaV8eiYOEC/efn0S8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpip6UGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23D63C4CEC4
	for <linux-ext4@vger.kernel.org>; Fri,  6 Sep 2024 20:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725654494;
	bh=R7XtTmWDJQMoJfJhPL5FpF2ZpSR+rT4OZrPio/0y/r8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gpip6UGkieW1a4IvbMstmu1T0IbePmbxc/NgwR3ItPf3Q0wf/On6GqjQn+vM+bxH/
	 5cZ9CMklQ5IuejhVFwxjub8+jB+xMzySLzoeoz5+RG+1Tr8mwFhGuSafmpuoHi9/Ln
	 AtKsEV22A4lCGR62GBpSaRgT3N1n78IXPnjkTtHD85kGhSuUDScjYBcFBkKarJExAM
	 Cp4J/T4yvMfxcfIhpdinqW8FszoTVjTmgB8nir4+pul3S1/qoBYpxynqcYSgxexQc3
	 7diDsLVmMTR/XxseFcI0KwZC6DmI2MW7QXhAtwjMGgVPJ7Vbyaq8UX09fp7YNbtPex
	 M8ZjC7SrY7yXg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1995AC53BC4; Fri,  6 Sep 2024 20:28:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219166] occasional block layer hang when setting 'echo noop >
 /sys/block/sda/queue/scheduler'
Date: Fri, 06 Sep 2024 20:28:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rjones@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-219166-13602-KX4zZWeW9j@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219166-13602@https.bugzilla.kernel.org/>
References: <bug-219166-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219166

--- Comment #15 from Richard W.M. Jones (rjones@redhat.com) ---
Created attachment 306825
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306825&action=3Dedit
'foreach bt' in crash utility

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

