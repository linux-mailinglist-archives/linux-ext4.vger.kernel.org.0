Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9689F1ADB9
	for <lists+linux-ext4@lfdr.de>; Sun, 12 May 2019 20:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfELSMP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sun, 12 May 2019 14:12:15 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:34186 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726529AbfELSMP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 12 May 2019 14:12:15 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 9AC50262AE
        for <linux-ext4@vger.kernel.org>; Sun, 12 May 2019 18:12:14 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 89B9026CFF; Sun, 12 May 2019 18:12:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=ham version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203585] Feature Request for filesystems that support
 noexec/exec mount options
Date:   Sun, 12 May 2019 18:12:14 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: Speeddymon@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-203585-13602-cSpE0mTG0w@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203585-13602@https.bugzilla.kernel.org/>
References: <bug-203585-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203585

--- Comment #2 from Thomas Spear (Speeddymon@gmail.com) ---
Thanks for updating so quickly.

An acceptable workaround for the uid mapping would be to just list the uids in
the fstab.

I appreciate the suggestion to modify the web app, and yes it would be great if
we could. Unfortunately its a 3rd party app with vendor support, and its hard
coded to write to the root of /tmp -- we can't even get it to write to a
folder, though I am considering suggesting a chrooted environment for the app
so that we can virtualize the access to /tmp that way.

I saw mention of getting around it by using bind mounts over on stack overflow,
but that would also require the ability to make it write somewhere other than
/tmp.

The app team is trying to push for acceptance of the risk of removing noexec
from /tmp (RHEL7 defaults to noexec for /tmp so its a change to the current
policy), but everything I've ever understood about /tmp being world writable
tells me that noexec on /tmp is a sane default and should be left that way.

Anyways, I could see having noexec_user= for exec filesystems being useful in a
variety of circumstances, but the rest of the request is a bit niche, so I
don't guess it would get much support from the community.

Thanks again for the help.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
