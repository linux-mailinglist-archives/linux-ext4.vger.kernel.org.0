Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08F2A1AD8E
	for <lists+linux-ext4@lfdr.de>; Sun, 12 May 2019 19:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfELRqD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sun, 12 May 2019 13:46:03 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:33454 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726529AbfELRqD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 12 May 2019 13:46:03 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 4721B262AE
        for <linux-ext4@vger.kernel.org>; Sun, 12 May 2019 17:46:02 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 322BF268AE; Sun, 12 May 2019 17:46:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203585] Feature Request for filesystems that support
 noexec/exec mount options
Date:   Sun, 12 May 2019 17:46:00 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc resolution
Message-ID: <bug-203585-13602-pdmBatM6g9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203585-13602@https.bugzilla.kernel.org/>
References: <bug-203585-13602@https.bugzilla.kernel.org/>
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

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |tytso@mit.edu
         Resolution|---                         |WILL_NOT_FIX

--- Comment #1 from Theodore Tso (tytso@mit.edu) ---
This is not at all trivial to implement, for a number of reasons:

*)  The kernel doesn't have access to the username to uid map.   It might be in
/etc/passwd; but you might also be using LDAP or Yellow Pages for the
username->uid map.   This could done by adding support for this to each file
system which implements this feature request's /sbin/mount.FSTYP, but...

*) This also begs the question of how to handle user namespaces.

The simplest way of solving this problem may be to change the web application
to write its temporary file in some other directory, and let that directory be
writable only by the web application's user id, and let that directory be
mounted without the noexec flag.  If you are using tmpfs, you can mount
multiple tmpfs instances, and create a special one which has mount options just
for that web application, with an fstab entry like this:

tmpfs /run/user/1042 tmpfs
rw,nosuid,nodev,relatime,size=2048k,mode=700,uid=1042,gid=1042 0 0

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
