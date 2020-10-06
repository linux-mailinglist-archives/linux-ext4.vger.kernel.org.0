Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32F5284C7D
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Oct 2020 15:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgJFNX7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 6 Oct 2020 09:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFNX7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 6 Oct 2020 09:23:59 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 102621] Directory name or file name staring with '-' cannot be
 handled through command line,i.e.,terminal
Date:   Tue, 06 Oct 2020 13:23:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext2
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mfo@canonical.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext2@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-102621-13602-aJrXxmpQZz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-102621-13602@https.bugzilla.kernel.org/>
References: <bug-102621-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=102621

Mauricio Faria de Oliveira (mfo@canonical.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mfo@canonical.com

--- Comment #4 from Mauricio Faria de Oliveira (mfo@canonical.com) ---
(In reply to Eric Sandeen from comment #1)
> Not a bug, kernel or otherwise.  You're simply seeing mkdir & touch
> interpret "-t" as an option.  Preface with "./" to avoid this:

One can also use '--' to stop parsing for options, e.g.,

$ touch -- -test

$ mkdir -- -test-dir

$ ls -1d -- -test*
-test
-test-dir

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
