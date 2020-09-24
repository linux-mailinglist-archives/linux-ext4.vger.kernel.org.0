Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65F8276500
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 02:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIXAWz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Wed, 23 Sep 2020 20:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgIXAWy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Sep 2020 20:22:54 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 209275] Graphics freeze after WARNING: CPU: 2 PID: 156207 at
 fs/ext4/inode.c:3599 ext4_set_page_dirty+0x3e/0x50
Date:   Thu, 24 Sep 2020 00:22:54 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rhmcruiser@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-209275-13602-taaRqSpDGK@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209275-13602@https.bugzilla.kernel.org/>
References: <bug-209275-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209275

--- Comment #6 from Monthero Ronald (rhmcruiser@gmail.com) ---
(In reply to Dennis Wagelaar from comment #4)
> This bug no longer occurs under kernel 5.8.9-101.fc31.x86_64 - closing.
Ah good to know issue is resolved with upgrade to newer kernel. (Probbaly the
issue was within the gnome-shell where the above stack was indicating a use
after free sort of condition in the gnome userspace code causing core dumps.  


ep 15 08:23:46 styx gnome-shell[67420]: #9   55a8b19fc420 i  
resource:///org/gnome/gjs/modules/overrides/Gio.js:169 (7fba6c0d3e50 @ 39)
Sep 15 08:23:46 styx gnome-shell[67420]: == Stack trace for context
0x55a8ac63e3a0 ==
Sep 15 08:23:46 styx gnome-shell[67420]: #0   55a8b19fc6d8 i  
/usr/share/gnome-shell/extensions/gamemode@christian.kellner.me/extension.js:231
(7fba10824820 @ 287)
Sep 15 08:23:46 styx gnome-shell[67420]: #1   7ffe62146c90 b   self-hosted:977
(7fba45130a60 @ 413)
Sep 15 08:23:46 styx gnome-shell[67420]: #2   7ffe62146d70 b  
resource:///org/gnome/gjs/modules/signals.js:135 (7fba6c0c6040 @ 376)
Sep 15 08:23:46 styx journal[67420]: Object St.Icon (0x55a8ad298110), has been
already deallocated — impossible to access it. This might be caused by the
object having been destroyed from C code using something such as destroy(),
dispose(), or remove() vfuncs.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
