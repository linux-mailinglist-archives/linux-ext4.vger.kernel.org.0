Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91591CE9CF
	for <lists+linux-ext4@lfdr.de>; Tue, 12 May 2020 02:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgELAzF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 11 May 2020 20:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgELAzF (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 11 May 2020 20:55:05 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207635] EXT4-fs error (device sda3): ext4_lookup:1701: inode
 #...: comm find: casefold flag without casefold feature; EXT4-fs (sda3):
 Remounting filesystem read-only
Date:   Tue, 12 May 2020 00:55:04 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207635-13602-0QcCO6VLsW@https.bugzilla.kernel.org/>
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

--- Comment #8 from Joerg M. Sigle (joerg.sigle@jsigle.com) ---
Thank you all for your explanations, again.

> Casefold is an 'incompat' feature, because it changes the directory format.
> So if someone enables it (on-disk [...]), old kernels can't use the
> filesystem at all.

Might this not warrant a warning in the ext4/ext5 manpage?
E.g. similar to what is there for the "ext64" feature:

"Note that some older kernels and older versions of e2fsprogs
 will not support file systems with this ext4 feature enabled."

The current text doesn't reveal this:

"[casefold] is name-preserving on the disk, but it
 allows applications to lookup for a file in the file system
 using an encoding equivalent version of the file name."

The required minimum versions of e2fsck, tune2fs etc. might also be mentioned.


> This issue is about how the kernel treats inodes that got corrupted
> to have the casefold flag set when the user didn't actually enable the
> casefold feature. The ext4 feature flags have clear behavior for how
> unexpected flags are handled, but the inode flags don't.

I use ext2 as least common denominator for multiple OS. I use conservative
settings. And still "got caught" by a new (!) disabled (!) opt-in (!) feature,
with hits apparently coming out-of-the-blue, and left without (much of) a clue
:-)

So IMHO a system not expected to use certain bits should rather not turn the fs
to r/o because of them. Or, at least, indicate the minimum e2fsck version
needed for fixing.

These bits could, however, still be checked very systematically: by letting
tune2fs  recommend (or even call?) ext2fs whenever a user is about to enable
casefold support on a preexisting fs. Only then, these bits become really
meaningful, the admin is ready, and ext2fs is guaranteed to be sufficiently
new.

Anytime afterwards, once that feature *is* enabled - any form of checking and
reaction by the kernel would be perfectly fine and no bad surprise anymore.

Equally ok: Revelation of the problem by regular scheduled e2fsck runs, once
e2fsck has been sufficiently updated over time to recognize and handle the
problem.

Thanks again for your consideration & regards! Joerg

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
