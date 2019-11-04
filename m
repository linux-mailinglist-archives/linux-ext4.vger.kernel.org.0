Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF316EE470
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 17:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfKDQLw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 4 Nov 2019 11:11:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbfKDQLv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 4 Nov 2019 11:11:51 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205417] Files corruption ( fs/ext4/inode.c:3941
 ext4_set_page_dirty+0x3e/0x50 [ext4] )
Date:   Mon, 04 Nov 2019 16:11:51 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: the.dmol@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205417-13602-TOsKyWzmri@https.bugzilla.kernel.org/>
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

--- Comment #5 from Ivan Baidakou (the.dmol@gmail.com) ---
Yes, the original message is reproduced every time I boot with 5.3.8
approximately after a few mins boot. I just launch my DE(awesome), Firefox,
Telegram, Claws-mail, and terminal. Actually visually no buggy behavior can be
observed, except the message in /var/log/messages.

The buggy behavior was in Saturnday, when 
1. I launched a WarThunder game, which does heavy I/O (I assume it calculates 
checksums of files, and if they mismatch, then download new asseets) - it just
hanged.

2. Then I was sure that it is a bug in game, and removed it. A bit later I just
spawned "make -j9" several times simultaneously for the same project (debug,
release, and sanitizer-build) - and when it hanged, I finally payed attention
to the original kernel message.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
