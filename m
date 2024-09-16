Return-Path: <linux-ext4+bounces-4185-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F14F97A2F8
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 15:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9222B1C2242A
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 13:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A58156256;
	Mon, 16 Sep 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+dmQThD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A14314F9E2
	for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493434; cv=none; b=n8THQM6NHvy6DprfQURq6sKg00VO/9Ptbjuz0+jWcIG8on4E6vcisSG8owwFEqMiMqIH21B41seYk3XJ9N0L9TybGUogk1+TqhnbqlP/BrtwftN6o7TkhmkfNS/G3RJCyoCduWs1YMSgk0nLAKBkgdOloOhfGIlnPQzxd3r7TpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493434; c=relaxed/simple;
	bh=EESoMC3E/8uatUJ13uAO4KiOZLOYg5C+7BGNGKXNOWw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Oh42CL4LvJMCT+Qu/ICx2B9kN5PBS/YFOMHCUzeAhA2XUiAc4GIscF7EblDh1yQleck0cbyHgs/n+g98TLF73Wxhy2dUmWKvS5MFWBbdGDb146Ngs3V/jJ1YrlKVtzgYgFgqkxTseyGxdDOYlDjmmRUxAF0o/xZ76Q8BunzcV5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+dmQThD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79C19C4CEC7
	for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 13:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726493433;
	bh=EESoMC3E/8uatUJ13uAO4KiOZLOYg5C+7BGNGKXNOWw=;
	h=From:To:Subject:Date:From;
	b=r+dmQThDpaie8gQ7WQAgOFXRmDeFxgYBl+M3MaCUFwWcO3vsP1BuMvAl+qFTtalsc
	 2O/X/E6IiFcCkNRXOEy4QsYLoV6U7+2TBCHOcKZX0Xxz98sW5aq2RzV953Ao3I576u
	 bk70vcGleouXBd1JBp9YGmTzkSUseYlpo8TPK3055RnFmC5rzDX59FW9hCDmZRsCP/
	 lny8PpKaC8cfwsl6fC0AYr8X1dvdT3Bl0PYPGj2jugFzABGaW/l07DuzS8ji9JiBWp
	 sm7W3gQlbHqm8vlA3yYlhU8jd/bgBOOzWxF7NHfUuJ/OoTISy+ZLwjAc92ShJiGAoK
	 Q3NB0OR8D9zsw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 65360C53BC4; Mon, 16 Sep 2024 13:30:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219283] New: kernel regression with ext4 and ea_inode mount
 flags and exercising xattrs (between Linux 6.8 and 6.11)
Date: Mon, 16 Sep 2024 13:30:32 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: colin.i.king@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-219283-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219283

            Bug ID: 219283
           Summary: kernel regression with ext4 and ea_inode mount flags
                    and exercising xattrs (between Linux 6.8 and 6.11)
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: colin.i.king@gmail.com
        Regression: No

Created attachment 306882
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D306882&action=3Dedit
dmesg showing lockup

exercising xattr with stress-ng on ext4 when it's been created with ea_inode
option causes a kernel hang.

Kernel: 6.11.0-7, AMD64 virtual machine 8 thread virtual machine (important,
must be multiple CPU threads to trigger the regression)
20GB virtio drive on /dev/vdb, 1 partition /dev/vdb1

sudo mkfs.ext4 /dev/vdb1 -O ea_inode
sudo mount /dev/vdb1 /mnt

git clone https://github.com/ColinIanKing/stress-ng
cd stress-ng
make clean; make -j $(nproc)

sudo ./stress-ng --xattr 8 -t 120 --vmstat 1 --file-path /mnt

..wait a couple of minutes, you will see that the number of running process=
es
is not 8 as expected (from the --vmstat output of stress-ng)

cannot ^C stop stress-ng because of a kernel lockup, use another tty and ch=
eck
dmesg, I get the following:

[ 247.028846] INFO: task jbd2/vdb1-8:1548 blocked for more than 122 seconds.
[ 247.030830] Not tainted 6.11.0-7-generic #7-Ubuntu
[ 247.032667] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables t=
his
message.
[ 247.034170] task:jbd2/vdb1-8 state:D stack:0 pid:1548 tgid:1548 ppid:2
flags:0x00004000
[ 247.034176] Call Trace:
[ 247.034178] <TASK>
[ 247.034182] __schedule+0x277/0x6c0
[ 247.034199] schedule+0x29/0xd0
[ 247.034203] jbd2_journal_wait_updates+0x77/0xf0
[ 247.034207] ? __pfx_autoremove_wake_function+0x10/0x10
[ 247.034213] jbd2_journal_commit_transaction+0x290/0x1a10
[ 247.034223] kjournald2+0xa8/0x250
[ 247.034228] ? __pfx_autoremove_wake_function+0x10/0x10
[ 247.034233] ? __pfx_kjournald2+0x10/0x10
[ 247.034236] kthread+0xe1/0x110
[ 247.034241] ? __pfx_kthread+0x10/0x10
[ 247.034244] ret_from_fork+0x44/0x70
[ 247.034247] ? __pfx_kthread+0x10/0x10
[ 247.034251] ret_from_fork_asm+0x1a/0x30
[ 247.034257] </TASK>

NOTE: this works fine for Linux 6.8.0, so this looks like a regression for
6.11.0

Attached is the full kernel log.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

