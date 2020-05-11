Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B531CE10B
	for <lists+linux-ext4@lfdr.de>; Mon, 11 May 2020 18:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgEKQ7B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 11 May 2020 12:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730756AbgEKQ7B (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 May 2020 12:59:01 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207635] EXT4-fs error (device sda3): ext4_lookup:1701: inode
 #...: comm find: casefold flag without casefold feature; EXT4-fs (sda3):
 Remounting filesystem read-only
Date:   Mon, 11 May 2020 16:59:00 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: lists@nerdbynature.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-207635-13602-P7O80y9a2W@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207635-13602@https.bugzilla.kernel.org/>
References: <bug-207635-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207635

Christian Kujau (lists@nerdbynature.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lists@nerdbynature.de

--- Comment #6 from Christian Kujau (lists@nerdbynature.de) ---
(In reply to Joerg M. Sigle from comment #5)
> The same person might run a kernel with casefold and/or encryption disabled
> on Tuesday. So, would it really be necessary to set their filesystem to ro -

I don't know about the inner workings of this particular issue here, but
turning the filesystem to RO when errors are encountered - isn't this what the
"error-behavior" flag controls?

$ tune2fs -l /dev/sda1 | grep ^Err
Errors behavior:          Remount read-only

Setting this to "continue" or "panic" should have avoided that whole "RO"
situation, I guess.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
