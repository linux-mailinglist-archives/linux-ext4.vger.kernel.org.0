Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05612BBBC2
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2019 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733108AbfIWSoH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 23 Sep 2019 14:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733103AbfIWSoG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Sep 2019 14:44:06 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 204779] Xubuntu 18.04 Sometimes freezes when turned off on the
 logo
Date:   Mon, 23 Sep 2019 18:44:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: ACPI
X-Bugzilla-Component: BIOS
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sandeen@sandeen.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INSUFFICIENT_DATA
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc resolution
Message-ID: <bug-204779-13602-Sajd2TOfj8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204779-13602@https.bugzilla.kernel.org/>
References: <bug-204779-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204779

Eric Sandeen (sandeen@sandeen.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |sandeen@sandeen.net
         Resolution|---                         |INSUFFICIENT_DATA

--- Comment #2 from Eric Sandeen (sandeen@sandeen.net) ---
I see that you've already filed an ubuntu bug.

Certainly, having it assigned to the upstream ext4 group is not going to yield
progress here, as there is no indication whatsoever that it's an ext4 bug.

If ubuntu is able to triage the bug to an actual upstream kernel bug, please
reopen a bug against the proper kernel component if/when the root cause is
identified.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
