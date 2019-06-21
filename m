Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9804EB2E
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2019 16:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfFUOwE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 21 Jun 2019 10:52:04 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:55966 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbfFUOwE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 21 Jun 2019 10:52:04 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 9493828ABC
        for <linux-ext4@vger.kernel.org>; Fri, 21 Jun 2019 14:52:03 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 8141628ACD; Fri, 21 Jun 2019 14:52:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203943] ext4 corruption after RAID6 degraded; e2fsck skips
 block checks and fails
Date:   Fri, 21 Jun 2019 14:52:01 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yann@ormanns.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-203943-13602-TNwOaykekc@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203943-13602@https.bugzilla.kernel.org/>
References: <bug-203943-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203943

--- Comment #3 from Yann Ormanns (yann@ormanns.net) ---
Andreas & Ted, thank you for your replies.

(In reply to Andreas Dilger from comment #1)
> This seems like a RAID problem and not an ext4 problem. The RAID array
> shouldn't be returning random garbage if one of the drives is unavailable.
> Maybe it is not doing data parity verification on reads, so that it is
> blindly returning bad blocks from the failed drive rather than
> reconstructing valid data from parity if the drive does not fail completely?

How can I check that? At least running "checkarray" did not find anything new
or helpful.

(In reply to Theodore Tso from comment #2)
> Did you resync the disks *before* you ran e2fsck?   Or only afterwards?

1. my RAID6 got degraded and ext4 errors showed up
2. I ran e2fsck, it consumed all  memory and showed only "Inode %$i block %$b
conflicts with critical metadata, skipping block checks."
3. I replaced the faulty disk and resynced the RAID6
4. e2fsck was able to clean the filesystem
5. I simulated a drive fault (so my RAID6 had n+1 working disks left)
6. the ext4 FS got corrupted again
7. although the RAID is clean again, e2fsck is not able to clean the FS (like
in step 2)

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
