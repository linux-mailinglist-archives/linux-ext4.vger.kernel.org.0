Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28AD1100F44
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Nov 2019 00:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfKRXIm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 18 Nov 2019 18:08:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfKRXIm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 18 Nov 2019 18:08:42 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205567] potential (possibly benign) data race on
 ext4_dir_entry_2->inode when getdents64 and rename happens on the same
 directory
Date:   Mon, 18 Nov 2019 23:08:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sandeen@sandeen.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-205567-13602-TFPhjNqHrV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205567-13602@https.bugzilla.kernel.org/>
References: <bug-205567-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205567

Eric Sandeen (sandeen@sandeen.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sandeen@sandeen.net

--- Comment #1 from Eric Sandeen (sandeen@sandeen.net) ---
As a suggestion - if you do not know for sure that these are bugs, it might be
better to ask these questions the list, as opposed to filing bugs.

Is this from code inspection, or are you using KCSAN or a similar tool?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
