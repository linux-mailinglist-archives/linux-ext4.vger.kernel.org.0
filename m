Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17518BBBA1
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2019 20:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfIWSdG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 23 Sep 2019 14:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfIWSdG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Sep 2019 14:33:06 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 204779] Xubuntu 18.04 Sometimes freezes when turned off on the
 logo
Date:   Mon, 23 Sep 2019 18:33:05 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: ACPI
X-Bugzilla-Component: BIOS
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: 0963499018m@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204779-13602-QO6lTApkez@https.bugzilla.kernel.org/>
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

--- Comment #1 from Maxim (0963499018m@gmail.com) ---
Sometimes, when I turn off the computer, it hangs on the logo. I can not turn
off the computer using alt + SysRq + REISUO. The light on the system unit
continues to light, and the fan runs. This is a problem with kernel 5.0, 5.3

Here is the error:
info: task systemd shutdown:1 blocked for more than 120 seconds
Not tainted 5.0.0-20-generic #21-Ubuntu
«echo 0 /proc/sys kernel/hung_task_timeout_secs» disables this message

https://ibb.co/PcYvDLq
https://ibb.co/4JMGwvC

sudo dmesg|grep ACPI|less - https://pastebin.com/PZxRGNyJ

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
