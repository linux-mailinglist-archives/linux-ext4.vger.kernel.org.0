Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A572F97DD
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Jan 2021 03:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbhARCeF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sun, 17 Jan 2021 21:34:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730897AbhARCeF (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 17 Jan 2021 21:34:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7329A2253A
        for <linux-ext4@vger.kernel.org>; Mon, 18 Jan 2021 02:33:21 +0000 (UTC)
Received: by pdx-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 628EA866BE; Mon, 18 Jan 2021 02:33:21 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 202809] ext4: ext4_xattr_ibody_get:591: comm systemd-journal:
 corrupted in-inode xattr
Date:   Mon, 18 Jan 2021 02:33:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: 1158340263@qq.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-202809-13602-irBgDEeNbU@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202809-13602@https.bugzilla.kernel.org/>
References: <bug-202809-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=202809

Hushup (1158340263@qq.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |1158340263@qq.com

--- Comment #5 from Hushup (1158340263@qq.com) ---
Hi ,We meet the same problem too,Can you share us how to reproduce the problem?
Thanks.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.
