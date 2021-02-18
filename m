Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8F531E6AD
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Feb 2021 08:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhBRHF0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Feb 2021 02:05:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhBRHBu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 18 Feb 2021 02:01:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3514A61493
        for <linux-ext4@vger.kernel.org>; Thu, 18 Feb 2021 06:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613631092;
        bh=jjQQKhabfnl5vcIUFdSUb2WMd75O+QJXuVLOqzogYmg=;
        h=From:To:Subject:Date:From;
        b=MTKAp5cMVRjkOPO6XI0wLsEuRy3n1GLvaASDYTTOzoOZv9FrDnAQ7/KF25rTUVtb2
         vBHfP7sHHGIkoYMz72tTXa2bdatoTPAaZq1LDCQQOS9py6N3GgEk7sThsGJfdraBvJ
         zDnepMn0s/6daTnA0hcW48Cic6sYihWrR6/zdBbeSb/c2wuIuSXsXiyBaj7RBuRhcA
         EZ74gsWhg7NzJVaq+uf9CRTv5H6gc0d23T5GXHOHTrqeJkYu5EG55VTDhMGXdj8lWq
         myjC9qM998e2knuKIIi/OLRRzf91aNSO9THV/8F7S01gmMGAk4Rg4nVD313ZtlDlpD
         ZWuYKMP2mUaow==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 2158B65304; Thu, 18 Feb 2021 06:51:32 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 211819] New: Processes stuck in D-state after accessing
 ext4+fast_commit+fscrypt
Date:   Thu, 18 Feb 2021 06:51:31 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: alxchk@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-211819-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211819

            Bug ID: 211819
           Summary: Processes stuck in D-state after accessing
                    ext4+fast_commit+fscrypt
           Product: File System
           Version: 2.5
    Kernel Version: 5.11.0 (5.10?)
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: alxchk@gmail.com
        Regression: No

I have several ext4, / and /home among them. /home fs do have user folder(s)
and mine is encrypted with fscrypt (v2 keying).

Recently I enabled fast_commit for all my ext4 fs with tune2fs -O fast_comm=
it.
That time I used 5.10.x kernel. Once 5.11 was released, I tried it immediat=
ely.

Seconds after decrypting and using encrypted home folder, I was no longer a=
ble
to start new processes, which were not in FS cache -- all of them were in
D-state. I.e. encrypted folder was at /home/user at fs /home, executalbes a=
re
in /bin/ at / fs. For example, if I run dmesg before decrypting and using
/home/user folder, it was (likely) cached, once I'm using /home/user folder
dmesg works, but other tools which were not previously used - doesn't.=20

There were no any messages in dmesg, logs etc. I used SysRq to reboot the
system. Such situation happend every time. After reset FS had corruptions,
which were fixed by fsck. After several attempts I rollback to 5.10. It wor=
ked,
but hanged in same manner somewhere in 12 hours of usage. After that, I made
assumption, that this may be because of fast_commit (or my NVMe dying). I
checked smart status, it was fine. I disabled fast_commit just for /home fs,
rebooted to 5.11, and it works for 24h already (previously it hanged
immediately). So, maybe, this was because of fast_commit.=20

Maybe it's worth to test this combination somehow..

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
