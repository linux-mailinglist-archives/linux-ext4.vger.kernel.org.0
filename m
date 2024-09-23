Return-Path: <linux-ext4+bounces-4264-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EF897E4A5
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 03:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F394F281044
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 01:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A516D1FA5;
	Mon, 23 Sep 2024 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrzmdyyT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E101C2E
	for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2024 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727055353; cv=none; b=sLQuGmHXFXJBU59BY+cxt3ipC7lP+Cy9B6UiA7W7+3JNjFBmax3Z1OmwGMowJKYi6xPI53u5ikxaIyIMy3U1+FMWTxFcXoR+FzmVyM0gkVAVH+nrl9U8bLUf414JU+/qCiXlXGm1qTPBez89lARiXaWsSfeRWyAyBPoItqXit8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727055353; c=relaxed/simple;
	bh=gLk5lLqTXKLu5W4+Ba4+j9Ddv9dRgtUgUo26QJdljpY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c4y5Py4hfwRvMCSu2yNc1tqtR8fLTd4ftuQs2kiQWSDfHOOPNnsCEeF1qwrzLTTJJT7Jj2FshUXYOqW5ZuTT96c5bwCE7hH7u4tpy/a8ATgGhC2nE2jTbX4qlDZugwsk9Z34wkqqZ2NV296Q/PvHzmvn5L1tQl8+tYN4MOTEeLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrzmdyyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2259C4CEC3
	for <linux-ext4@vger.kernel.org>; Mon, 23 Sep 2024 01:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727055352;
	bh=gLk5lLqTXKLu5W4+Ba4+j9Ddv9dRgtUgUo26QJdljpY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RrzmdyyTZDtSO6MRCxKnH9+bt/i6MPtt5aRWC7Gd2kn/vDgxtlG85o9dcSu8EicMe
	 gyhJjmBNsiUv0sjKynF10Y2ca3qHLu08BVVyTlP9ltpXlDLoznnR0smjNkXzNq2XZD
	 b8RRACVafaI/hsEhBreaiRvxsOMwksVkUBof12a/SS1eKn0T6nCoSHRjxj1O9S4103
	 Sy+FCrmIesMartEnbOwbOWRG4Uc2cN8TIMWcvWj4jUs6qMRKhXUmRMGJolBPjJQAr2
	 INZWw/Kdrj2CE+yfUgx10BQiV1ws1m3cb+YVakCHv4sFKJ6sM+pZUwJ0nvMI7ZmRxn
	 ir0V3s5kuMBCg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BFC24C53BC4; Mon, 23 Sep 2024 01:35:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219300] ext4 corrupts data on a specific pendrive
Date: Mon, 23 Sep 2024 01:35:52 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: linuxnormaluser@proton.me
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219300-13602-NQrUsJtM7v@https.bugzilla.kernel.org/>
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

--- Comment #3 from nxe9 (linuxnormaluser@proton.me) ---
>Typically, such errors indicate a storage failure, not a filesystem proble=
m.

>I strongly suspect your media is broken or damaged and should not be used =
to
>store important information.

How can you explain the fact that I can copy tens of GB of data to the ntfs
file system on different operating systems and no errors occur and data is
always consistent? For me, this is a sign that something is wrong with ext4
since ntfs works without any problems on the same hardware.

I've tested badblock before and there were no errors.
badblocks -w -s -o error.log /dev/sdX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

