Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEA8104229
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2019 18:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfKTRdh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Wed, 20 Nov 2019 12:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbfKTRdh (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 20 Nov 2019 12:33:37 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205609] Multiple bugs in __ext4_expand_extra_isize (OOB write
 and UAF write)
Date:   Wed, 20 Nov 2019 17:33:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tristmd@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-205609-13602-1r9YO3iVDr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205609-13602@https.bugzilla.kernel.org/>
References: <bug-205609-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205609

Tristan (tristmd@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|5.x                         |4x / 5.x

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
