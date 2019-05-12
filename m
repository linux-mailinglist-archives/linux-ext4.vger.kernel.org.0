Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B3E1AD7C
	for <lists+linux-ext4@lfdr.de>; Sun, 12 May 2019 19:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfELRV6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sun, 12 May 2019 13:21:58 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:33082 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726669AbfELRV6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 12 May 2019 13:21:58 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 5F4742675C
        for <linux-ext4@vger.kernel.org>; Sun, 12 May 2019 17:21:57 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 536A926AE3; Sun, 12 May 2019 17:21:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203585] New: Feature Request for filesystems that support
 noexec/exec mount options
Date:   Sun, 12 May 2019 17:21:56 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: Speeddymon@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-203585-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203585

            Bug ID: 203585
           Summary: Feature Request for filesystems that support
                    noexec/exec mount options
           Product: File System
           Version: 2.5
    Kernel Version: all
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: enhancement
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: Speeddymon@gmail.com
        Regression: No

Greetings,

I want to ask for a new mount flag to be considered which enhances the
noexec/exec flag for filesystems that support those flags.

What I would like to do is to designate in /etc/fstab that a filesystem with
either flag can be bypassed by certain users.

For example, there is a web app that insists on writing a file to the root of
/tmp, (a shared object library) in order to then load that file into memory to
perform some operation. Why it is done this way, I don't know, but we have /tmp
set to noexec for security reasons. The app is required to be able to execute
the file in order to load it into memory it seems, because the app fails when
we have noexec flag set on the /tmp filesystem, and it works fine without that
flag.

So, I was hoping that in the future, we might be able to work around this
dilemma by having a "exec_users=/noexec_users=" type mount option. Where, if a
filesystem has "noexec", you could do: "noexec,exec_user=john", and conversely
if a filesystem has "exec" and you want to lock down a certain user/set of
users, you could do "exec,noexec_user=paul"

If this is considered useful enough, and is able to be implemented without much
fuss -- BTW I'm HOPING that since the kernel does permissions checks for
file/directory access, it can also do those checks for noexec/exec access --
then could you please also extend the mount options to have
group_noexec/group_exec flags as well?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
