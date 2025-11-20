Return-Path: <linux-ext4+bounces-11934-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F58C72631
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 07:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45E894E5B24
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 06:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DD52F1FC9;
	Thu, 20 Nov 2025 06:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9juYdY4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15992E92B3
	for <linux-ext4@vger.kernel.org>; Thu, 20 Nov 2025 06:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621329; cv=none; b=IbWeCok6bEutgKbjx7edznHz5vaZAlv98RCrB7WnhhhKf7bSWHZ7U9keOvOXsTuZ+xCbKWIxFvVlN0Hw4aqAX7vUD9WDpP8YyHSdrgodXXozRBg1jXAjFnxyNUFqj1xew/0UoBagsWKYSeHItcw4L5Od5FhmNjAKU6tF6nKezW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621329; c=relaxed/simple;
	bh=yUjR4YUgHfPFLJVJYilYBm/T/k6WOAMCTzbhrsTIyLE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ur1K4etYdE0e3OWhIKKoWgPvYVGD1XjPHozk5hRQBrSCRZZK2zAhEcioAkieA9gEhET3Z2IISzhpOkR8OqXRStkhEZkdhk/8FhmsLT2ThJvuMU3l5oZA8z1T8XJmD1LQQ+sj3m1qBesV1GzXvzPuH3ooFOpkh30iGu4ud9cafjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9juYdY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2635EC16AAE
	for <linux-ext4@vger.kernel.org>; Thu, 20 Nov 2025 06:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763621328;
	bh=yUjR4YUgHfPFLJVJYilYBm/T/k6WOAMCTzbhrsTIyLE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f9juYdY4dZY/HnbwEvOLv9w+oqzotNVn/oS2rzZyVf4F8ZvCyprZqRPbV4Ri52ZWm
	 Tyz9V9NZayjcEG26rj4OV+bI33CUYHn4dALwC6l+f5PMqFs6JFAnWiINkER9mnz+0j
	 BgNU/Pjqkns3sD2d1SQWVnaVmXqqexNDpzkynXOJ/sCNi/4k3M9XfmDvJduyMdCHAD
	 P01TtBm1nZKnI7Xi8+n54WtWuukOFpafJyb+SbvwQ57MAAfGPH6blKWOp9jNIqaBMv
	 W4CRXiaIKym6FUb1C9o7Ll77WWVoG9EpoidEmddvwKgzWiKjD57pJgxxIBw2l/2Kr7
	 uSpg+CzC3s7fw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1A16AC4160E; Thu, 20 Nov 2025 06:48:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220594] Online defragmentation has broken in 6.16
Date: Thu, 20 Nov 2025 06:48:47 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220594-13602-T0C29jzqNj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220594-13602@https.bugzilla.kernel.org/>
References: <bug-220594-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220594

--- Comment #9 from Artem S. Tashkinov (aros@gmx.com) ---
Sadly it's still broken in 6.17:

ext4 defragmentation for ./birdie/.config/google-chrome/Default/Sync
Data/LevelDB/000435.log
        Failed to defrag with EXT4_IOC_MOVE_EXT ioctl:Success   [ NG ]

ls -la /home/birdie/.config/google/Default/Sync Data/LevelDB/000435.log

-rw-------. 1 birdie birdie 139150 Nov 19 10:22
'/home/birdie/.config/google-chrome/Default/Sync Data/LevelDB/000435.log'

A small file that is not getting defragmented and I have literally five doz=
ens
of them.

And I have plenty of free space.

Filesystem volume name:=20=20=20
Last mounted on:          /
Filesystem UUID:=20=20=20=20=20=20=20=20=20=20
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      ext_attr resize_inode dir_index filetype extent
flex_bg sparse_super large_file huge_file uninit_bg dir_nlink extra_isize
Filesystem flags:         signed_directory_hash=20
Default mount options:    user_xattr acl
Filesystem state:         not clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              1572864
Block count:              6287360
Reserved block count:     314367
Overhead clusters:        109963
Free blocks:              4126491
Free inodes:              1428171
First block:              0
Block size:               4096
Fragment size:            4096
Reserved GDT blocks:      1022
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   512
Flex block group size:    16
Filesystem created:=20=20=20=20=20=20=20
Last mount time:=20=20=20=20=20=20=20=20=20=20
Last write time:=20=20=20=20=20=20=20=20=20=20
Mount count:=20=20=20=20=20=20=20=20=20=20=20=20=20=20
Maximum mount count:      -1
Last checked:=20=20=20=20=20=20=20=20=20=20=20=20=20
Check interval:           0 (<none>)
Lifetime writes:=20=20=20=20=20=20=20=20=20=20
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     28
Desired extra isize:      28
Default directory hash:   half_md4
Directory Hash Seed:=20=20=20=20=20=20
Journal backup:           inode blocks

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

