Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9973F871E
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2019 04:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfKLDh7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 11 Nov 2019 22:37:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKLDh6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 Nov 2019 22:37:58 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205433] BUG: KASAN: use-after-free in
 ext4_put_super+0xb1d/0xd80
Date:   Tue, 12 Nov 2019 03:37:57 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: tytso@mit.edu
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc assigned_to attachments.created
Message-ID: <bug-205433-13602-6GYQLVqmir@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205433-13602@https.bugzilla.kernel.org/>
References: <bug-205433-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205433

Theodore Tso (tytso@mit.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
                 CC|                            |tytso@mit.edu
           Assignee|fs_ext4@kernel-bugs.osdl.or |tytso@mit.edu
                   |g                           |

--- Comment #2 from Theodore Tso (tytso@mit.edu) ---
Created attachment 285869
  --> https://bugzilla.kernel.org/attachment.cgi?id=285869&action=edit
ext4: work around deleting a file with i_nlink == 0 safely

Here's the fix to the issue.  (BTW, in the future please feel free to send a
ping instead of messing with the severity.)

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
