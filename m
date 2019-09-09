Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5D3AD156
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Sep 2019 02:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbfIIABn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sun, 8 Sep 2019 20:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731484AbfIIABn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 8 Sep 2019 20:01:43 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203317] WARNING: CPU: 2 PID: 925 at fs/ext4/inode.c:3897
 ext4_set_page_dirty+0x39/0x50
Date:   Mon, 09 Sep 2019 00:01:42 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: howaboutsynergy@pm.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-203317-13602-fHML2vIanp@https.bugzilla.kernel.org/>
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

--- Comment #6 from howaboutsynergy (howaboutsynergy@pm.me) ---
Freeze still present on 5.3.0-rc8 kernel, but only on Intel/i915, not on
AMD/Radeon.

I've gotten this freeze during compilation(s).

I've attempted to get a kdump by triggering the freeze via `memfreeze`(script)
then sysrq+c to crash kernel, however, I'm unable to (for some reason) read the
kdump, but here's what it says anyway:
https://gist.github.com/howaboutsynergy/d9818dcf462c071251a236787d8fbea6#file-gistfile1-txt-L1

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
