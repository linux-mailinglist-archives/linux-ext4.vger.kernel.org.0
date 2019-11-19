Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEC81010B9
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Nov 2019 02:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKSB17 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 18 Nov 2019 20:27:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfKSB16 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 18 Nov 2019 20:27:58 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205569] potential data race (likely benign) on inode->i_state
 (reading and writing to different bits)
Date:   Tue, 19 Nov 2019 01:27:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mengxu.gatech@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205569-13602-04P9j2SH2I@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205569-13602@https.bugzilla.kernel.org/>
References: <bug-205569-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205569

--- Comment #4 from Meng Xu (mengxu.gatech@gmail.com) ---
(In reply to Theodore Tso from comment #3)
> Yes, it's benign.   An inode which is I_NEW or I_FREEING will never be in
> the writeback.

Many thanks for the confirmation Ted, in the future, I'll post these unsure
cases to the mailing list instead of filing a bug report.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
