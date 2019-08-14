Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB538D82E
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2019 18:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfHNQgb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Wed, 14 Aug 2019 12:36:31 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:60332 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbfHNQgb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 14 Aug 2019 12:36:31 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 3F58928847
        for <linux-ext4@vger.kernel.org>; Wed, 14 Aug 2019 16:36:30 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 3198628867; Wed, 14 Aug 2019 16:36:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203317] WARNING: CPU: 2 PID: 925 at fs/ext4/inode.c:3897
 ext4_set_page_dirty+0x39/0x50
Date:   Wed, 14 Aug 2019 16:36:28 +0000
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
Message-ID: <bug-203317-13602-VsdkJSxwmO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203317-13602@https.bugzilla.kernel.org/>
References: <bug-203317-13602@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203317

--- Comment #5 from howaboutsynergy is abandoned account everywhere (howaboutsynergy@pm.me) ---
Just to be clear, this is a regression that commit
aa56a292ce623734ddd30f52d73f527d1f3529b5 introduces, which is manifested by a
deadlock-like system freeze which is different than the one that le9g.patch is
addressing. (all of this is mentioned in prev. comment)

I don't know what the fix is, but temporarily reverting that commit gets rid of
the regression.

Please let me know whether I should stick around if you want me to test any new
patch about this or not. (because otherwise I won't even check my
email/notifications for this account, anymore)

Cheers.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
