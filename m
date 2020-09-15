Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2A826A0C3
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Sep 2020 10:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgIOIZO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 15 Sep 2020 04:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgIOIPG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 15 Sep 2020 04:15:06 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 209275] Graphics freeze after WARNING: CPU: 2 PID: 156207 at
 fs/ext4/inode.c:3599 ext4_set_page_dirty+0x3e/0x50
Date:   Tue, 15 Sep 2020 08:15:05 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dwagelaar@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-209275-13602-VW9mTBmGXl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209275-13602@https.bugzilla.kernel.org/>
References: <bug-209275-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209275

--- Comment #1 from Dennis Wagelaar (dwagelaar@gmail.com) ---
Created attachment 292507
  --> https://bugzilla.kernel.org/attachment.cgi?id=292507&action=edit
/var/log/messages

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
