Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED514F439
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Jun 2019 09:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfFVHst convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sat, 22 Jun 2019 03:48:49 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:45374 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbfFVHst (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 22 Jun 2019 03:48:49 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 8E7D328BAA
        for <linux-ext4@vger.kernel.org>; Sat, 22 Jun 2019 07:48:48 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 8063928BC1; Sat, 22 Jun 2019 07:48:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203943] ext4 corruption after RAID6 degraded; e2fsck skips
 block checks and fails
Date:   Sat, 22 Jun 2019 07:48:47 +0000
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
Message-ID: <bug-203943-13602-W8IXdDUfWA@https.bugzilla.kernel.org/>
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

--- Comment #7 from Yann Ormanns (yann@ormanns.net) ---
I changed the locale to en_GB and got now the actual 5 or 6 inodes, which
caused the extremely slow procedure of e2fsck. I zeroed them with debugfs and
afterwards, e2fsck was able to fix many, many errors.
lost+found contains 934G of data (53190 entries). During the next days, I will
try to examine them.

While copying files out of my backup, I re-tested a failure of a disk an
removed it from the array. After a while I re-added it and now the array is
rsyncing. I will watch the logs for possible FS errors - for now, all seems
clean.

Thanks a lot for your support!

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
