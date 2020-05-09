Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650371CBFAC
	for <lists+linux-ext4@lfdr.de>; Sat,  9 May 2020 11:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgEIJN5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sat, 9 May 2020 05:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgEIJN5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 9 May 2020 05:13:57 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207635] EXT4-fs error (device sda3): ext4_lookup:1701: inode
 #...: comm find: casefold flag without casefold feature; EXT4-fs (sda3):
 Remounting filesystem read-only
Date:   Sat, 09 May 2020 09:13:57 +0000
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
Message-ID: <bug-207635-13602-Lv4OmhEIwS@https.bugzilla.kernel.org/>
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
     Kernel Version|5.5.11                      |5.5.11, 5.5.10

--- Comment #1 from Joerg M. Sigle (joerg.sigle@jsigle.com) ---
N.B.: Reviewing my kernel history, I found: The problem already happened with
5.5.10 and made me try 5.5.11 hoping it might have been fixed.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
