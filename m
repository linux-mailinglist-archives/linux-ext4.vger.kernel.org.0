Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142111CCDF8
	for <lists+linux-ext4@lfdr.de>; Sun, 10 May 2020 22:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgEJUhn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sun, 10 May 2020 16:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbgEJUhn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 10 May 2020 16:37:43 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207635] EXT4-fs error (device sda3): ext4_lookup:1701: inode
 #...: comm find: casefold flag without casefold feature; EXT4-fs (sda3):
 Remounting filesystem read-only
Date:   Sun, 10 May 2020 20:37:42 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: joerg.sigle@jsigle.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-207635-13602-WU0lBfkpI6@https.bugzilla.kernel.org/>
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

Joerg M. Sigle (joerg.sigle@jsigle.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|5.5.11, 5.5.10              |5.4.20, 5.5.10, 5.5.11,
                   |                            |5.6.11

--- Comment #2 from Joerg M. Sigle (joerg.sigle@jsigle.com) ---
After upgrade to 5.6.11, once again had the root filesystem become read only.

I'm now going back to 5.3.15 which may have been the last unproblematic version
I tried - just to verify once more that the problem doesn't occur with that
older version.

N.B.: Googling "casefold flag without casefold feature" returned a patch - and
most probably, the same problem for someone else in Kernel 5.4 vs. 5.3:

https://patchwork.ozlabs.org/project/linux-ext4/patch/20190903054324.20072-1-tytso@mit.edu/
> ext4: fix kernel oops caused by spurious casefold flag

https://forum.armbian.com/topic/13111-solved-5420-vs-539-arbian-bionic/
> 5.4.20: EXT4-fs error (device mmcblk0p1): ext4_lookup:1700: inode #4950: comm
> rsync: casefold flag without casefold feature
> 5.3.9: without error 


So the problem may have been adressed - but that was in 2019; I'm wondering how
it could still be there in May 2020 kernels?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
