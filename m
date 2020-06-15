Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952051F8BF2
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jun 2020 02:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgFOAki convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sun, 14 Jun 2020 20:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgFOAki (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 14 Jun 2020 20:40:38 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 208173] BUG: using smp_processor_id() in preemptible, caller is
 ext4_mb_new_blocks
Date:   Mon, 15 Jun 2020 00:40:38 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tseewald@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-208173-13602-y0eoQep2Ar@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208173-13602@https.bugzilla.kernel.org/>
References: <bug-208173-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208173

--- Comment #3 from Tom Seewald (tseewald@gmail.com) ---
After looking around, syzkaller already found this bug [1], and a fix was
already posted [2] but Linus didn't pull it before tagging the rc1 release.

I manually applied commit 811985365378df01386c3cfb7ff716e74ca376d5 ("ext4:
mballoc: Use this_cpu_read instead of this_cpu_ptr") from
https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git, and I can
confirm that this fixes the problem. Hopefully this makes it in by rc2.

I'll close this report once Linus pulls the fix.

[1]
https://syzkaller.appspot.com/bug?id=b7f459091a40a67a13f27d2281281ffd0ed8e5e1
[2] https://lore.kernel.org/lkml/20200614200034.GA3294624@mit.edu/T/

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
