Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B638C4EEC7
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2019 20:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfFUS3J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 21 Jun 2019 14:29:09 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:38820 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbfFUS3J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 21 Jun 2019 14:29:09 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id BAF2F28B6A
        for <linux-ext4@vger.kernel.org>; Fri, 21 Jun 2019 18:29:08 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id AEB1E28B76; Fri, 21 Jun 2019 18:29:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203943] ext4 corruption after RAID6 degraded; e2fsck skips
 block checks and fails
Date:   Fri, 21 Jun 2019 18:29:07 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-203943-13602-hLCBXnHREX@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203943-13602@https.bugzilla.kernel.org/>
References: <bug-203943-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203943

--- Comment #4 from Theodore Tso (tytso@mit.edu) ---
That sounds *very* clearly as a RAID bug.   If RAID6 is returning garbage to
the file system in degraded mode, there is nothing the file system can do.

What worries me is if the RAID6 system was returning garbage when *reading* who
knows how it was trashing the file system image when the ext4 kernel code was
*writing* to it?

In any case, there's very little we as ext4 developers can do here to help,
except give you some advice for how to recover your file system.

What I'd suggest that you do is to use the debugfs tool to sanity check the
inode.  If the inode number reported by e2fsck was 123456, you can look at it
by using the debugfs command: "stat <123456>".    If the timestamps, user id
and group id numbers, etc, look insane, you can speed up the recovery time by
using the command "clri <123456>", which zeros out the inode.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
