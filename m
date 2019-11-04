Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15467EE450
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 16:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfKDPz7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 4 Nov 2019 10:55:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfKDPz7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 4 Nov 2019 10:55:59 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205417] Files corruption ( fs/ext4/inode.c:3941
 ext4_set_page_dirty+0x3e/0x50 [ext4] )
Date:   Mon, 04 Nov 2019 15:55:58 +0000
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
Message-ID: <bug-205417-13602-6FutaluIPv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205417-13602@https.bugzilla.kernel.org/>
References: <bug-205417-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205417

--- Comment #4 from Theodore Tso (tytso@mit.edu) ---
Hmm, so less than ten minutes after the system was booted, with no other
interesting messages in /var/log/messages.

Is this reproducible?  If you boot 5.3.8 again, can you reliably reproduce the
failure?   And what sort of workload are you running when the system goes
south?

Thanks!

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
