Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C215AAD4B1
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Sep 2019 10:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfIIITz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 9 Sep 2019 04:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbfIIITz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Sep 2019 04:19:55 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203317] WARNING: CPU: 2 PID: 925 at fs/ext4/inode.c:3897
 ext4_set_page_dirty+0x39/0x50
Date:   Mon, 09 Sep 2019 08:19:54 +0000
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
Message-ID: <bug-203317-13602-Wwee071Xam@https.bugzilla.kernel.org/>
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

--- Comment #8 from howaboutsynergy (howaboutsynergy@pm.me) ---
But, I 've already tested that reverting that commit gets rid of the freeze.
Even if the cause is somewhere else, it appears that the regression is
introduced by the very commit I mentioned:
aa56a292ce623734ddd30f52d73f527d1f3529b5 (and that commit mentions this issue -
which is why I'm posting here)

I mean, the only thing I could try to do is to somehow find a way to get a
stacktrace while the system is frozen, but for some reason even manually
causing kernel to crash(sysrq+c) fails to allow me to read the dump via 'crash'
afterwards ...

Also, I've encountered the freeze during chromium compilation (possibly because
it uses at least 15+GiB of 32G of RAM due to jumbo). Even though it's easier
for me to trigger the freeze via the 'memfreeze' script. So I expect users will
hit this soon. (assuming they use some kind of ext4, I use it on the /tmp and
/var/tmp zram)

Not sure how else to say it. I used bisect to find the commit(a while ago),
tested with and without it. 

Ahh forgot to mention that what I said in Comment 6 (that freeze/race) happens
when the commit is NOT reverted.

But this isn't the same freeze that happens during the memory pressure which
simply does a ton of disk reading. I know because I'm already patching against
it by keeping Active(file) above 300MiB. (see Comment 4)

I'm happy to try other things to help with this. Please let me know what I
could do.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
