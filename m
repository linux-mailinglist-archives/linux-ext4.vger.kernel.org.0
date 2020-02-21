Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B823168945
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 22:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgBUV0L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 21 Feb 2020 16:26:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgBUV0K (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 21 Feb 2020 16:26:10 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 206613] On hitting tab key from terminal against a directory
 name ending with ':\' doesnot shows files/dir inside it
Date:   Fri, 21 Feb 2020 21:26:10 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: adilger.kernelbugzilla@dilger.ca
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-206613-13602-nMbPDvHnc7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-206613-13602@https.bugzilla.kernel.org/>
References: <bug-206613-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206613

Andreas Dilger (adilger.kernelbugzilla@dilger.ca) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |adilger.kernelbugzilla@dilg
                   |                            |er.ca

--- Comment #1 from Andreas Dilger (adilger.kernelbugzilla@dilger.ca) ---
This has nothing to do with ext4, but rather "bash-completion".

I suspect that including "\" into the directory name will make a lot of tools
unhappy, so it would be better to name these directories just "C:", "D:", "E:",
since you will need to use "/" as the pathname separator anyway, and
"C:\/dir/file" is going to get old quickly.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
