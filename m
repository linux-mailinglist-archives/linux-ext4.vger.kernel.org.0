Return-Path: <linux-ext4+bounces-2404-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B798C0B5A
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 08:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216DE285A9F
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 06:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D081494D4;
	Thu,  9 May 2024 06:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwdGFmdI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1C1494D0
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715235297; cv=none; b=b8aNwFsvORo/K8NeYvlLAHOfOtp1A9gmDdB9SKuXw7UClirq72TEjyAFhZRhel1o6mgnFDzP39tZ+/giMGr+jbddySCuVXF64wkeeWWxriGqPVKoa5kJfKGRRFRxGIHrsNya4jtbIfu6/CrBHMo4Onl5nWNue8HJParThqaDfCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715235297; c=relaxed/simple;
	bh=qcLza/1B2ig/4Qch4ziaUJ4z5uedYZD2Xg0/hXFz5i8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Yy7aD4PJ5xPV8y0Tc8mIIXfiZy2H5gNRjhr2Ef955XK+sB4se/VtzDEdlojSx6TIzW2QpMxtVfFzTmafrOHbdSD5UtkxjIPLHBV4AFcqIjcT6BdxuWR1+ts4l/rlE4MtVluumVKgbFe4GC0Yl3rYx4zrVa1+BoNfYau0pEyH49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwdGFmdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27971C32783
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 06:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715235297;
	bh=qcLza/1B2ig/4Qch4ziaUJ4z5uedYZD2Xg0/hXFz5i8=;
	h=From:To:Subject:Date:From;
	b=cwdGFmdIwTHg2z6zMIKd8SrJ0GwKvKU1tOtZf2ImcEQJoBRSlWn5Mt3VTLYoHlYgd
	 cu7txMltHYSZDGtMxwKlAG53980z/4cJWn4ZVa7kjTJZvbwdIhudv3PEOWTormgQnq
	 3+rXgw/TBKIVyQAyoQTWQLZbHj+8YvfZR7ce4STjNMXS/vRUzHBQC0ioUAhADEffcU
	 VBd1xmTYMklbYmbDyKbG1zTV6tVrqSOGc2t6eiSWI9stGgsMbHJja23oXCl7f7S1fK
	 lw4sAyD5OZGa+bOFwQq/XwlRnFPDCe90LZootHYZDqIp3foghxCjrEtw7tPrL/9z5I
	 PyKivPARhYpaQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 17A3BC53B6D; Thu,  9 May 2024 06:14:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 218822] New: Delete the file from the upper layer directly, the
 file will become "Stale"
Date: Thu, 09 May 2024 06:14:56 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: Squall.Zhou@vecima.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218822-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218822

            Bug ID: 218822
           Summary: Delete the file from the upper layer directly, the
                    file will become "Stale"
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: Squall.Zhou@vecima.com
        Regression: No

The FS mount as following:
/dev/sda7 on / type ext4 (rw,relatime)
/dev/sda5 on /persistent type ext4 (rw,relatime)
overlay on /etc type overlay
(rw,relatime,lowerdir=3D/sysroot/etc,upperdir=3D/sysroot/persistent/platfor=
m/B/etc/upper,workdir=3D/sysroot/persistent/platform/B/etc/work)

1. I touched a file named "A" on /etc
2. I remove the file "A" from "/persistent/platform/B/etc/upper"
3. The file "A" in /etc will become "Stale"

root@exs1610ada83b:~ [B]# touch /etc/A
root@exs1610ada83b:~ [B]# rm /persistent/platform/B/etc/upper/A
root@exs1610ada83b:~ [B]# rm /etc/A
rm: can't remove '/etc/A': Stale file handle

Linux version:
root@exs1610ada83b:~ [B]# uname -a
Linux exs1610ada83b 5.10.184-intel-pk-standard #1 SMP PREEMPT Sun Jun 25
06:48:28 UTC 2023 x86_64 GNU/Linux

Thought, the /etc/A will be removed also.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

