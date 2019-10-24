Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C074FE2AAA
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Oct 2019 08:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437843AbfJXG6O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 24 Oct 2019 02:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfJXG6O (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Oct 2019 02:58:14 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205197] kernel BUG at fs/ext4/extents_status.c:884
Date:   Thu, 24 Oct 2019 06:58:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arnaud@btmx.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205197-13602-08R6bbMg3k@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205197-13602@https.bugzilla.kernel.org/>
References: <bug-205197-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205197

--- Comment #4 from Arnaud Bétrémieux (arnaud@btmx.fr) ---
I just tried it with the same kernel I used at the time of the bug report, and
no, I can't reproduce the failure anymore. I'm not sure what changed… sorry !

Strangely, I'm pretty sure I did test with and without the patch and it all
seemed to work at the time (BUG with no patch, no BUG with patch).

The partition is automounted, so maybe there was an auto-fsck at some point. I
should have thought of removing the automount to keep things testable.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
