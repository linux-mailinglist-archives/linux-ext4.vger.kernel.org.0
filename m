Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 522A4AD5D9
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Sep 2019 11:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfIIJgs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 9 Sep 2019 05:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389977AbfIIJgr (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Sep 2019 05:36:47 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203317] WARNING: CPU: 2 PID: 925 at fs/ext4/inode.c:3897
 ext4_set_page_dirty+0x39/0x50
Date:   Mon, 09 Sep 2019 09:36:46 +0000
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
Message-ID: <bug-203317-13602-5jA3VonOWB@https.bugzilla.kernel.org/>
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

--- Comment #11 from howaboutsynergy (howaboutsynergy@pm.me) ---
(In reply to Jani Nikula from comment #10)
> Where?

To: intel-gfx@lists.freedesktop.org

> If you think this is about i915, and want i915 developers to look, please file bugs at [1], or send email to intel-gfx@lists.freedesktop.org where the likely first response is to ask you to file bugs at [1].

The only reason I think it's about i915 is because of:
1. "i915" in the stacktrace in Comment 1
2. it only happens on my Intel(i915) computer, not on Amd/Radeon laptop(I
simply cannot reproduce the freeze on the AMD one)

> Generally the only action the i915 developers do at bugzilla.kernel.org is to close, and ask bugs to be filed at [1]. You get the picture. ;)
> [1] https://bugs.freedesktop.org/enter_bug.cgi?product=DRI&component=DRM/Intel


Good info, thanks! I'll file a bug there then. Sorry for the noise.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
