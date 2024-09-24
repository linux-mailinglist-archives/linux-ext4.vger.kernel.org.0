Return-Path: <linux-ext4+bounces-4288-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B94BC9844F6
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Sep 2024 13:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63EC4B23DC1
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Sep 2024 11:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38E11A705A;
	Tue, 24 Sep 2024 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keTDrYxC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978371A704A
	for <linux-ext4@vger.kernel.org>; Tue, 24 Sep 2024 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177919; cv=none; b=T6kUP41amAxG23rnkqg9c+RZ7Yr3glxt17MK6rCqiIBb6b571dtbpu/apBC9UupZBOAhK26r18noWvNl8f8s8uHIEluBt8JN+LqEPiJ40esRBaEh16CYIY5AANK7mEBrL+f0b6vh6b+qdLIv1Or1yvlkkFbsqYbakzgLgjJO5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177919; c=relaxed/simple;
	bh=zeyehyqH9GWW9myxn6dvh+TR59U0273IGQQCFW/kdqQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pSK0kyKBd12JNX0tX36z9aBk0cKoCHHYBoT6j3oa0MXnFQX9EUAOqiK4gMsoTJnuSYYG8vOazlFv7c7SANMZs7zvaamPahYoZDNgu1x9mLAx0MLVwm9lYNAZvV+6K0kPoZiIbjBnAaoB0EhDQxe0tIwVVIpHahMUFpLJzjMJPAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keTDrYxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 136F6C4CEC7
	for <linux-ext4@vger.kernel.org>; Tue, 24 Sep 2024 11:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727177919;
	bh=zeyehyqH9GWW9myxn6dvh+TR59U0273IGQQCFW/kdqQ=;
	h=From:To:Subject:Date:From;
	b=keTDrYxCEzBOXAXcxxx26VKPnb4UvDbiHwKOb/JCTcSVNZPH7arOc9K0q2BN+wugr
	 hN7096tUN6VZp2DEcV32IqmoMPVBf19YBODrhcDV+RCyBRbrfRiYm2Fmu8xJjAqCKw
	 48fSSs/eoj6LQ4emx1Y3nn83M2dDwnYNIBHd+/zC8SS7Q0Xy5jjOL5O2w3T+ptWxww
	 GOlb7iZKCOq6cI8MPKVNauft6JED6J4pK0zcj6Bkf2TTH8D1D5JN7ZQsv2IJwASfyW
	 UiKDC/bI+NMe/MDjur0EtGpV6+rrgv6yA/gEjlZvthsjvkyFESt1AI5VyYHoUvqmAK
	 8bzWUIAql/xGQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 05A23C53BC3; Tue, 24 Sep 2024 11:38:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219306] New: ext4_truncate() is being called endlessly, all the
 time
Date: Tue, 24 Sep 2024 11:38:38 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: linmaxi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219306-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219306

            Bug ID: 219306
           Summary: ext4_truncate() is being called endlessly, all the
                    time
           Product: File System
           Version: 2.5
          Hardware: i386
                OS: Linux
            Status: NEW
          Severity: low
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: linmaxi@gmail.com
        Regression: No

At file ./linux/fs/ext4/extents.c there is this function:=20
int ext4_ext_truncate(handle_t *handle, struct inode *inode) {...}
Which is being called all the time, from the moment the machine is booted.

Steps to reproduce: To witness it, just inject a simple printk at the beggi=
ning
of the function and checkout dmesg.

After some lookup, it turns out the inode that is being passed to the funct=
ion
is
of the file: /var/log/journal/7c8e96117d45417e980f5fec3775d67f/system.journ=
al.
The calling function is ext4_setattr(...) in the file ./linux/fs/ext4/inode=
.c.
At that function we have the following code:

                /*
                 * Call ext4_truncate() even if i_size didn't change to
                 * truncate possible preallocated blocks.
                 */
                if (attr->ia_size <=3D oldsize) {
                        rc =3D ext4_truncate(inode);
                        if (rc)
                                error =3D rc;
                }
Looks like this function is being called on system.journal file but without
actually having it's size changed. Although the comment appears to justify
calling the function even when the size is unchanged, it is probably uninte=
nded
that the function will be ran at such a high frequency without doing anythi=
ng.

I'd like to ask for thoughts on this, and I'd be glad to fix it myself if
possible.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

