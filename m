Return-Path: <linux-ext4+bounces-10462-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385AABA6649
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Sep 2025 04:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E486E1736AF
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Sep 2025 02:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C414202F65;
	Sun, 28 Sep 2025 02:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBs1KSPB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF85734BA2D
	for <linux-ext4@vger.kernel.org>; Sun, 28 Sep 2025 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759025821; cv=none; b=ky2l+ORTYITwM3wN2j0lsb7TIgG9m1XPxTsQHLmcCXGvCC9FpCSe91RGnkvKGfPn+srDmGeln2qABFmpsfxc4N145qE+EdEbxYy9BZnZ34f1MaBPMmCOPwCh+WA2Wf7Qe4tEtkHLA12zKn8L701xHx2bFq1lzQkX3GfsATOgSnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759025821; c=relaxed/simple;
	bh=ifOUcd3iomaOwOhrSxW5KDMkQ9pAj4UKdllns+Tfrrs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WvlM7uOZrPCS1jMkGuGHo0jVk7h8Iurps32xdKdfl9YUgsNJhcaXhmD2pUCuANg8HS1T+RZ/GmhjFjyDzoREC0vIs2l2tGl/zX5FSF/NuHueC0HOrk+2IF6tU97lIQy0qfgbW17UNZ3/kmQeUT16gc0LByJYSdkJNP0rNCI+rkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBs1KSPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 555D2C113D0
	for <linux-ext4@vger.kernel.org>; Sun, 28 Sep 2025 02:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759025821;
	bh=ifOUcd3iomaOwOhrSxW5KDMkQ9pAj4UKdllns+Tfrrs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mBs1KSPB0zoCDtzVSZlGn9zY5C/d7UYuEO5rwtcGZ4PodvUG3yXPiyJ1g5b91ZlIb
	 dt12XUKVG+4JojtFNzMBNBg2ht9aSPaF81EwtuxTBmU2FCQ2JrpUQNTlJMfY68ByXq
	 nNrcJmrKbHoZpiUU75hkiiw0geQTFLYTyTCdtuYPTKbZe63kINZ/hh221BUo9FPFQ1
	 HUqWo7/BGJTWEL2Y5PzmDbnsk78bh9CEp2RpiGSw5y/pAoVy3B6RQdgY6YH3ZgS2zc
	 10SPLIVTaKnhcNhekk+lq7TN90SFGvSxtj97Ezks3bdCa+dLleCRedBciG9JMrHypd
	 LeWoHVeClvGAQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4928BC53BBF; Sun, 28 Sep 2025 02:17:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220594] Online defragmentation has broken in 6.16
Date: Sun, 28 Sep 2025 02:17:01 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220594-13602-5YqMTbBhzH@https.bugzilla.kernel.org/>
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

--- Comment #8 from Theodore Tso (tytso@mit.edu) ---
e4defrag reports directories as failures.   We should probably change it to
just skip directories so it doesn't confuse people:

root@kvm-xfstests:~# mke2fs -Fq -t ext4 /dev/vdc
/dev/vdc contains a ext4 file system
        last mounted on Sat Sep 27 22:14:06 2025
root@kvm-xfstests:~# mount /dev/vdc /vdc
[  118.187747] EXT4-fs (vdc): mounted filesystem
c6ef56ee-8512-4408-8a58-2c83e3a36f91 r/w with ordered data mode. Quota mode:
none.
root@kvm-xfstests:~# e4defrag /vdc
e4defrag 1.47.2 (1-Jan-2025)
ext4 defragmentation for directory(/vdc)

        Success:                        [ 0/2 ]
        Failure:                        [ 2/2 ]
root@kvm-xfstests:~# find /vdc -type d
/vdc
/vdc/lost+found
root@kvm-xfstests:~#=20

I am not seeing the "Failure to defrag with EXT4_IOC_MOVE_EXT ioctl" message
which you cited.   So I don't believe I'm able to reproduce whatever you're
seeing.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

