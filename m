Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D184D77BC
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Oct 2019 15:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732183AbfJONxJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 15 Oct 2019 09:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbfJONxJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 15 Oct 2019 09:53:09 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205197] kernel BUG at fs/ext4/extents_status.c:884
Date:   Tue, 15 Oct 2019 13:53:08 +0000
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-205197-13602-htPXuojSgi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205197-13602@https.bugzilla.kernel.org/>
References: <bug-205197-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205197

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tytso@mit.edu

--- Comment #1 from Theodore Tso (tytso@mit.edu) ---
It looks like the journal inode is corrupted but it shouldn't have BUG'ed on
you.

Can you reproduce this crash?  If so, does this fairly simple patch cause it
not to BUG?  (It will still fail to mount, but it shouldn't crash.)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f203bf989a4c..d83b325fb54b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -375,7 +375,7 @@ static int ext4_valid_extent(struct inode *inode, struct
ext4_extent *ext)
         *  - zero length
         *  - overflow/wrap-around
         */
-       if (lblock + len <= lblock)
+       if (lblock + (ext4_lblk_t) len <= lblock)
                return 0;
        return ext4_data_block_valid(EXT4_SB(inode->i_sb), block, len);
 }

Apologies if this is whitespace damaged, but t's a fairly simple edit to apply,
and I'm currently on a chromebook so I can't easily get a patch uploaded into
bugzilla.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
