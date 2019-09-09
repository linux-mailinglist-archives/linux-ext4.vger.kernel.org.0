Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE5FAD470
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Sep 2019 10:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfIIIJG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 9 Sep 2019 04:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfIIIJG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Sep 2019 04:09:06 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203317] WARNING: CPU: 2 PID: 925 at fs/ext4/inode.c:3897
 ext4_set_page_dirty+0x39/0x50
Date:   Mon, 09 Sep 2019 08:09:05 +0000
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
Message-ID: <bug-203317-13602-L2dpBZ4xob@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203317-13602@https.bugzilla.kernel.org/>
References: <bug-203317-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203317

--- Comment #7 from Theodore Tso (tytso@mit.edu) ---
Note that you filed this bug against the ext4 file system (because of the ext4
warning).   As a result, regressions about the i915 driver are not going to be
seen by the i915 driver developers (and ext4 developers will generally ignroe
them).

It looks like you are trying to stress test Linux kernels under very high
memory pressure, and this is no doubt going to cause multiple issues to pop
out.   Please don't conflate them into a single bug, and please note that not
all kernel subsystems (not even a majority) prefer to use bugzilla for people
to report bugs. 

If you can't find a component in the bugzilla (and perhaps even if you can),
you are better off sending a note to the mailing list entry (L:) in the
MAINTAINERS file.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
