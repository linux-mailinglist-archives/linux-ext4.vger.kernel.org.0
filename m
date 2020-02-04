Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5FB15230E
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2020 00:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgBDXk7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 4 Feb 2020 18:40:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbgBDXk7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 4 Feb 2020 18:40:59 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 206419] online resize + fstrim -> bad block checksum
Date:   Tue, 04 Feb 2020 23:40:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla.kernel.org@plan9.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-206419-13602-ArShzbabgi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206419-13602@https.bugzilla.kernel.org/>
References: <bug-206419-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206419

--- Comment #1 from bugzilla.kernel.org@plan9.de ---
I was able to umount the filesystem and ran e2fsck, which offered:

Inode 34852 extent tree (at level 2) could be narrower.  Optimize<y>? yes

And then went on to correct bitmpa differences - no sign of the bitmap block
checksum error. Afterwards, I mounted again and now fstrim works without
complaints.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
