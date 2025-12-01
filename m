Return-Path: <linux-ext4+bounces-12094-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FEDC95763
	for <lists+linux-ext4@lfdr.de>; Mon, 01 Dec 2025 01:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57C03A1CE1
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 00:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E702A1AA;
	Mon,  1 Dec 2025 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXwNNuo4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6C9219E8
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764549563; cv=none; b=Zp6KKv9j0W9Ti/26RIp9zBdRXy/vX39rYW7TJZn5xkVJDZkxTgd0XaPW+z5jzutsuPZIEMlCE8y0K7WvTaGSNnHdUgOLNFtNFrwrve+LNY2o+yUs3F+WQpOvpVqzjee8xNV74miGkcxeWcGDjftNd+v2Rf1+GWOBNUbhNH0kwlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764549563; c=relaxed/simple;
	bh=vjHtUzRwV91Q6UwhvOaA3X28T10v2iDYB9ilfiV645g=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VieVkW2mU3A+5S4AATIkbNtzPDh293/fEvGuhySN5HLrKfnsLvHSbJEjW++pNX0GUtv7KvGay8WzXmGw6Ez+9Ub1zvBVNBwfdW2hY9w9ueZFN9BksIQpBe8ZGbXn3owa80SUYk/t4IX8BRNsltwZIP+m109Lhd1I/H2RIvrsvu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXwNNuo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25134C4CEFB
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 00:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764549563;
	bh=vjHtUzRwV91Q6UwhvOaA3X28T10v2iDYB9ilfiV645g=;
	h=From:To:Subject:Date:From;
	b=bXwNNuo4gsY0jCEnHyxSwVxz8otiIfEgVE2Z0vz8eJWZ2Hbd55Ni7HfyGOx7dvldj
	 TMN4OC2vaCH4EmlaF/04fDnsRs2OS63NPVvOiW5a88ttZiCSy9HYimeYh8pU+yM5nr
	 Yf8mBeCerqP7HNyV0guZVMSXtctXt7l5qOC6Tbo7XtYvpn+i0sOYeU1h3A2hOZKTQX
	 bYrkxJrLN84m8x/w7nY1ZjrrDeg/zxxYP9HTF46UzfV+QQ/qhMQwosoHXDS/OCo2Iu
	 jhcO5e71Nxl4+5Mlyo57UrAzMhpM22c6YaWh6pM7l5iJEluAGt+tdd5wicD/4iVNGP
	 QcccTIN+CsrKg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1D7E3C41613; Mon,  1 Dec 2025 00:39:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220818] New: kernel 6.8.0-88: General Protection Fault (GPF) in
 ext4 while running 'umount': RIP: 0010:dentry_unlink_inode+0x52/0x150
Date: Mon, 01 Dec 2025 00:39:22 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ubuntu@yendor.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-220818-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220818

            Bug ID: 220818
           Summary: kernel 6.8.0-88: General Protection Fault (GPF) in
                    ext4 while running 'umount': RIP:
                    0010:dentry_unlink_inode+0x52/0x150
           Product: File System
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: ubuntu@yendor.com
        Regression: No

Created attachment 308991
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308991&action=3Dedit
Relevant lines from syslog of crash

Getting a reproducible GPF in ext4 filesystem dentry_unlink_inode while run=
ning
userland 'sudo umount /media/some-mountpoint' after a large backup where ma=
ny
modifications are waiting to be flushed to disk.


System is amdgpu multicore if that is relevant.

Kernel is: 6.8.0-88-generic.


Full kernel GPF report in the attachment.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

