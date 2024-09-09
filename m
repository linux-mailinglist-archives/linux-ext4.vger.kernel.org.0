Return-Path: <linux-ext4+bounces-4089-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7996972183
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Sep 2024 20:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01CC1F23863
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Sep 2024 18:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCE717B4E1;
	Mon,  9 Sep 2024 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuCO/pQU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5DC224F6
	for <linux-ext4@vger.kernel.org>; Mon,  9 Sep 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725905121; cv=none; b=W3YnD3lC1Q0Lq23JEQCrBjNmYdFNc8AXVIVVj8+XCW2K2/7iTkuWstiW+YyGf7RFPslhZZUMF7rfAccVmjUN83JglRLGx+I70M4+BIIoz6OL4Lhsu2WtBQCkWXYst67lz5VP3R0i3MBS9qAwFZsF8sXGVvut1cNpiSGKlvK1jLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725905121; c=relaxed/simple;
	bh=MOAJvMLezseHyqCRrPKOA/199MGll5SlCyH/lk6aesY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C3hdLx5V/5jDsDIDhIkJ8PWH5Wq84QN4LgExfMrZ0T70R7mIuiFa6fmtUdGmWlioD+VD/IuHZi3EQb2ISiyHzbBI+k6t8YMkw/ywFqcZwVR46Yju+yUVXIJnJ+Z1uxid5YchNabuueZ0kIOvPiXEVtx7RNAe27dukMi7vuIoE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuCO/pQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 602DFC4CEC8
	for <linux-ext4@vger.kernel.org>; Mon,  9 Sep 2024 18:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725905121;
	bh=MOAJvMLezseHyqCRrPKOA/199MGll5SlCyH/lk6aesY=;
	h=From:To:Subject:Date:From;
	b=kuCO/pQU0ceuVqfCi71NVubS7+KqGlMXsr9/j7+RppHv9YNYZLh6bfYCt4TRfnZIt
	 1D+gYyYr18iKpGXS1/sdnd9rH+hlONxUj39xJNKHR16vUEZf8IvbwFB/A6x7+i3f9b
	 SZPDF456nSrr8ljz78suNNc/3CHl8Q067BI38a8l8ZtCfdYNOyEISJFJK96u4OfnA9
	 yBn2lutbjexgUY/pj6vFLhFIhX6BNVymg5IsBPyVDmpc6BtckFCoCS+9AWX61iPH1G
	 ENkiBpI4FyzVGiPWti5wzji2gw3SrOzALkr3MrT4JcLCfPhAbzLWs9bdvhA0LWP2u3
	 7WAquqRpixOZg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 50022C53BB8; Mon,  9 Sep 2024 18:05:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 219254] New: Missing memory barrier in __ext4_remount for
 checking ext4_forced_shutdown
Date: Mon, 09 Sep 2024 18:05:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: fanqi.yu@columbia.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-219254-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219254

            Bug ID: 219254
           Summary: Missing memory barrier in __ext4_remount for checking
                    ext4_forced_shutdown
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: fanqi.yu@columbia.edu
        Regression: No

Hi,

In other places of the kernel, accesses to SB_RDONLY and EXT4_FLAGS_SHUTDOWN
are ordered by smp_wmb() for writes and smp_rmb() for reads:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D4418e14112e3ca85e8492a4489a3552b0cc526a8

There seems to be a missing smp_rmb() here between sb_rdonly(sb) and
ext4_forced_shutdown(sb):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/=
ext4/super.c?h=3Dv6.11-rc7#n6506

The affected scenario:
Normally a remount-ro-after-error file system would not be able to be remou=
nted
as rw again because the ext4_forced_shutdown(sb) check will return -EROFS. =
On a
relaxed memory architecture, it is possible to see ext4_forced_shutdown(sb)=
 as
false despite sb_rdonly(sb) being true (i.e. the write to EXT4_FLAGS_SHUTDO=
WN
not being propagated in time to the reader). __ext4_remount therefore misses
the shutdown check and can remount the fs as rw without giving any errors.

I am not sure about the severity of this but it is probably something hard =
to
find otherwise so I thought it might be useful to share it here and see what
you guys think.

Thank you very much for your time!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

