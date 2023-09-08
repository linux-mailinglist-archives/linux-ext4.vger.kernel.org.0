Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F4D7983CA
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Sep 2023 10:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjIHING (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Sep 2023 04:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240562AbjIHING (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Sep 2023 04:13:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755CD1BEE
        for <linux-ext4@vger.kernel.org>; Fri,  8 Sep 2023 01:12:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18078C433C9
        for <linux-ext4@vger.kernel.org>; Fri,  8 Sep 2023 08:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694160779;
        bh=WdNijaynGh4VVaNQB3hSQebpLOIANKOTeEq+Py9DocY=;
        h=From:To:Subject:Date:From;
        b=AkMBfGfsO0tSYme5Fg6bpA9fAoBSf7PPykf+nsOlfvj5NcJYfrC6KFECX1NgnCaBf
         v2nsRLQX9I2GtPyX+1lRIXTlW7W21BvB8mNHsYEl2ed1qO4xTfQIP5oTDv+q0zUSjD
         AT0VTtIFv+fBlO7OGj3T+bCa9uNtvn+ggaWFlHAZnC8m2M4CZPcniYZeznD9dccnCb
         dA4ZuyynRjbmPUFjjfTO88VOL17nBfZvx1I3+fiKG6aWrVW8C61qWdpMUKhpbgn0Vv
         oCaI3MoiNjEuq/wtaZw/LUI6MDLvtX2wh5nX4c1vhd+e7m1TwLNMJv4sQhR77INp+9
         JwDfIHNt17W8g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 08260C53BCD; Fri,  8 Sep 2023 08:12:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217888] New: jbd2: potential data lost in recovering journal
 raced with synchronizing fs bdev
Date:   Fri, 08 Sep 2023 08:12:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chengzhihao1@huawei.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217888-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217888

            Bug ID: 217888
           Summary: jbd2: potential data lost in recovering journal raced
                    with synchronizing fs bdev
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: chengzhihao1@huawei.com
        Regression: No

1. Apply diff and compile kernel
2. dd if=3Ddisk_1 of=3D/dev/sda bs=3D1M
   dd if=3Ddisk_1 of=3D/dev/sda bs=3D1M seek=3D43
3. mount /dev/sda temp # will stuck
4. sync /dev/sda # Type this command in another terminal, finish it in 5s w=
hen
you see "wait sync" from dmesg.
4. umount temp
5. fsck.ext4 -fn /dev/sda


Unattached inode 13
Connect to /lost+found? no

Pass 5: Checking group summary information

/dev/sda: ********** WARNING: Filesystem still has errors **********



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
'touch file' is recorded in journal of sda, and the journal is not replayed
yet.

journal in sda:

Journal starts at block 1, transaction 2
Found expected sequence 2, type 1 (descriptor block) at block 1
Dumping descriptor block, sequence 2, at block 1:
  FS block 266 logged at journal block 2 (flags 0x0)
  FS block 2 logged at journal block 3 (flags 0x2)
  FS block 276 logged at journal block 4 (flags 0x2)   # new inode
  FS block 273 logged at journal block 5 (flags 0x2)
  FS block 3479 logged at journal block 6 (flags 0x2)  # new dentry
  FS block 1 logged at journal block 7 (flags 0xa)
Found expected sequence 2, type 2 (commit block) at block 8

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
