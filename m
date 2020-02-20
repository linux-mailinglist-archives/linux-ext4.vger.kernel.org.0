Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12F90165641
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2020 05:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgBTE0Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Wed, 19 Feb 2020 23:26:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbgBTE0Y (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Feb 2020 23:26:24 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 206443] general protection fault in ext4 during simultaneous
 online resize and write operations
Date:   Thu, 20 Feb 2020 04:26:23 +0000
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
Message-ID: <bug-206443-13602-WKCFLZTcQL@https.bugzilla.kernel.org/>
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

--- Comment #14 from Theodore Tso (tytso@mit.edu) ---
Patches to BZ don't have to be perfect, or mailing list ready.  But it would be
nice if they actually applied (e.g., not be white-space damaged) and if they
actually compiled (not be missing macro definitions).  :-)

In my experience, bugzilla is good for collecting data when we are trying to
root-cause a problem.    But it's a lot more work to look at a bug in BZ, since
we have to download it first.   Where as if it is sent to the mailing list,
it's a lot easier to review it and to send back comments.

For that matter, it's fine to send patches to the mailing list that aren't
ready to be applied.   Using a [PATCH RFC] subject prefix is a good way to make
that clear; Linus Torvalds has been known to post patches with "Warning!  I
haven't even tried to compile it yet"; this is just to show the approach I'm
thinking of.   What's important is to make sure expectations are set for why
the patch is being sent to the list or being uploaded to BZ.

Thanks for your work on this bug!

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
