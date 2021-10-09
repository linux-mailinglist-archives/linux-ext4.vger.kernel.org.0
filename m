Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63581427905
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Oct 2021 12:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhJIKZm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 9 Oct 2021 06:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229760AbhJIKZm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 9 Oct 2021 06:25:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7EB3960F6B
        for <linux-ext4@vger.kernel.org>; Sat,  9 Oct 2021 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633775025;
        bh=1MRK+LR2V3QOisa+W5K4tzODskvnbFTY5Ym5JABMBCA=;
        h=From:To:Subject:Date:From;
        b=uu/LVcIkREwlwSNUawjaa0y2CkSrnL3tq+BWspZ2qTf1wphEsrSj2RSJDGEfZyfYG
         G54TnraMs2PFhFo3/SPTSESG9KmcQ3L2/y3TotwHQh/V/L7SsHpOGEllnu1Sl959lV
         wtGtgp1iDSacbEvW/pwcLpAxj8uY4EXmMTWI/f2zh0NtxTt01hl19DB53KsvfcYN4L
         vibHJ3wWK6cSwi02kfe4axRcHap4b1GQBb/HGj5jja2iDdkIEKZBxgqH9kYDBOYS30
         /BAYycEHHZKgEyGjVXH3SG4azc5htYtTdo0BABjf5sMu4pee8zbiS4kFNXOwDHpwPv
         ItnDhOdxTF6oQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 6E40460EE0; Sat,  9 Oct 2021 10:23:45 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214665] New: security bug:using "truncate" bypass disk quotas
 limit
Date:   Sat, 09 Oct 2021 10:23:45 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: 1157599735@qq.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-214665-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214665

            Bug ID: 214665
           Summary: security bug:using "truncate" bypass disk quotas limit
           Product: File System
           Version: 2.5
    Kernel Version: 3.10.0-1160.36.2.el7.x86_64
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: 1157599735@qq.com
        Regression: No

* Overview

  system user can bypass "disk quota limit" using "truncate -s 10T id" comm=
and
(that can create a file whose size is 10T).

* Steps to Reproduce

  1. create a user and setup a disk quota for this user

    create user "test"
    ```
    useradd test
    ```

    create filesystem
    ```
    [root@vm10-50-0-18 ~]# dd if=3D/dev/zero of=3Dext4 bs=3D1G count=3D1
    [root@vm10-50-0-18 ~]# mkfs.ext4 ext4
    [root@vm10-50-0-18 ~]# mkdir -p /tmp/test && chmod -R 777 /tmp/test &&
mount -o usrquota,grpquota ext4 /tmp/test
    ```

    setup disk quota
    ```
    [root@vm10-50-0-18 ~]# quotacheck -u /tmp/test/       # create
"aquota.user" file
    [root@vm10-50-0-18 ~]# edquota -u test
    [root@vm10-50-0-18 ~]# quotaon /tmp/test/ -u    # open quota service
    ```

    the quota setting is like below: user "test" can not use disk space whi=
ch
size exceed 10K.
    ```
    Disk quotas for user test (uid 1000):
    Filesystem                   blocks       soft       hard     inodes=20=
=20=20=20
soft     hard
    /dev/loop0                        0          10          10          0=
=20=20=20=20=20
  0        0
    ```

  2. verify the quota limit using "dd"

    ```
    [root@vm10-50-0-18 ~]# su - test
    =E4=B8=8A=E4=B8=80=E6=AC=A1=E7=99=BB=E5=BD=95=EF=BC=9A=E5=85=AD 10=E6=
=9C=88  9 18:14:31 CST 2021pts/1 =E4=B8=8A
    [test@vm10-50-0-18 ~]$ dd if=3D/dev/zero of=3D/tmp/test/id bs=3D20K cou=
nt=3D1
    loop0: write failed, user block limit reached.            # yes,this li=
mit
is as expected
    dd: error writing =E2=80=98/tmp/test/id=E2=80=99: Disk quota exceeded
    1+0 records in
    0+0 records out
    8192 bytes (8.2 kB) copied, 0.000221445 s, 37.0 MB/s
    ```

    this result is as expected: "test" user can not write file whose size is
more than 10K.

  3. verify the quota limit using "truncate"

    ```
    [test@vm10-50-0-18 test]$ truncate -s 10T id
    [test@vm10-50-0-18 test]$ ll -h id
    -rw-rw-r-- 1 test test 10T Oct  9 17:16 id
    ```

    actual results is: "test" user can create file whose size is 10T, larger
more than 10K

    expected result is: like "dd result" above,  "test" user can not write =
file
whose size is more than 10K.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
