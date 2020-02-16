Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84645160163
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Feb 2020 02:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgBPBqt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sat, 15 Feb 2020 20:46:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgBPBqt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 15 Feb 2020 20:46:49 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 206443] general protection fault in ext4 during simultaneous
 online resize and write operations
Date:   Sun, 16 Feb 2020 01:46:49 +0000
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
Message-ID: <bug-206443-13602-rJFNsvrcfu@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206443-13602@https.bugzilla.kernel.org/>
References: <bug-206443-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206443

--- Comment #12 from Theodore Tso (tytso@mit.edu) ---
I've posted a proposed improvement[1] to the first proposed patch[2] on LKML.

[1] https://lore.kernel.org/r/20200215233817.GA670792@mit.edu
[2] https://bugzilla.kernel.org/attachment.cgi?id=287189

Suraj, please note that your patches are whitespace damaged, and are lacking
the Developer's Certification of Origin.   In the future, it would save me a
lot of time you take a look at the Submitting Patches[3] instructions from the
kernel documentation.

[3] https://www.kernel.org/doc/html/latest/process/submitting-patches.html

You can either use e-mail to linux-ext4@vger.kernel.org or attach patches to a
Bugzilla entry. although the former is certainly preferred.  It's better to
send a proposal to the linux-ext4@vger.kernel.org, since that way the patch can
also get tracked via patchwork[4], and on lore.kernel.org, as in [1] above.

[4] http://patchwork.ozlabs.org/project/linux-ext4/list/

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
