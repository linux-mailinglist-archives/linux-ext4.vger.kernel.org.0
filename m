Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E54642251
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 05:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiLEEiH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 4 Dec 2022 23:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiLEEiF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 4 Dec 2022 23:38:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2224D5FE3
        for <linux-ext4@vger.kernel.org>; Sun,  4 Dec 2022 20:38:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D3BE60C88
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 04:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB80DC433C1
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 04:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670215082;
        bh=ZWCc6cnVXDP263awmzjRIjWIuTQd0ykW95PMzYx6zxc=;
        h=From:To:Subject:Date:From;
        b=SRRFqxnysdcbh0YvdSJZTROmaOE0Yld0oIoxedn2faTgFSaaAeZV7HtZ/RoYye3PC
         dG5nYBwEvFTSPJy5dOTbGcGBOIsfsqoX53vinY0sstoF7QbSd231yOfYB6tQeS1WxV
         5XGgFzSnG80hNQCU3PL1vMhWOOXgpUZzcsjdDt4fY9ayWHZ2lYW5mK7fm9qtTltYuN
         StVVGWme7WIJTnMH+w/+EPP2JvOkfa2KnS8NCLfA+7BPJL18156BJ7ESPw0O+HDcao
         XG3mR2itLeN4TR6tg/lwE54STAxpEH2uRfnw6UmwOZheO9OiEMGKX7nkNvrl2VEDgd
         x8YqUwFICkbAA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A42ADC433E7; Mon,  5 Dec 2022 04:38:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216775] New: fanotify reports parent PPID insted of PID for
 FAN_MODIFY events
Date:   Mon, 05 Dec 2022 04:38:02 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: saikiran.gummaraj@icloud.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216775-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216775

            Bug ID: 216775
           Summary: fanotify reports parent PPID insted of PID for
                    FAN_MODIFY events
           Product: File System
           Version: 2.5
    Kernel Version: 5.15.0
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: saikiran.gummaraj@icloud.com
        Regression: No

Hello,

While I've been developing a library around fanotify in Go, I noticed that
fanotify subsystem reports the parent process ID in fanotify_event_metadata=
.pid
instead of the Process ID when mask is set to FAN_MODIFY. I was able to con=
firm
the error through a test and also manually verifying the PIDs in the audit =
log.
I did not observe this behaviour for FAN_ACCESS bit.

I've been able to reproduce this on -

Ubuntu 20.04.5 - 5.15.0-53-generic
Ubuntu 22.10 - 5.19.0-23-generic

It can be reproduced by -

git clone git@github.com:opcoder0/fanotify.git
cd fanotify
sudo go test -v

The test "TestWithCapSysAdmFanotifyFileModified" fails reporting pid mismat=
ch.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
