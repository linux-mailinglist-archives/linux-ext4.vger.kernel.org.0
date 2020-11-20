Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E68F2BA3CF
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 08:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKTHtL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 20 Nov 2020 02:49:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgKTHtL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Nov 2020 02:49:11 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 210185] kernel BUG at fs/ext4/page-io.c:126!
Date:   Fri, 20 Nov 2020 07:49:10 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: emchroma@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-210185-13602-Si42MaBc2x@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210185-13602@https.bugzilla.kernel.org/>
References: <bug-210185-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210185

--- Comment #10 from emchroma@gmail.com ---
I've made some more tests with different kernels and it looks like the the bug
was introduced with kernel 5.9.0. Kernel 5.8.18 and below (5.8.0 and 5.8.16)
runs
fine, kernel 5.9.0 shows the bug. Today I've tried kernel 5.9.9, which also
crashes.

I've also made the test on a different machine with different hardware and
different setup - there, all kernels seems to run fine. At least program ran
for a few hours before I stopped it.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
