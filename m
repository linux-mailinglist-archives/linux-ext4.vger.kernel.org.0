Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB5612A3DB
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 19:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfLXSQi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 24 Dec 2019 13:16:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfLXSQi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 24 Dec 2019 13:16:38 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205957] Ext4 64 bit hash breaks 32 bit glibc 2.28+
Date:   Tue, 24 Dec 2019 18:16:37 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: adilger.kernelbugzilla@dilger.ca
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-205957-13602-H8nsmeKGIj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205957-13602@https.bugzilla.kernel.org/>
References: <bug-205957-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205957

Andreas Dilger (adilger.kernelbugzilla@dilger.ca) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |adilger.kernelbugzilla@dilg
                   |                            |er.ca

--- Comment #2 from Andreas Dilger (adilger.kernelbugzilla@dilger.ca) ---
IMHO, it is broken to be calling a 64-bit interface like getdents64() and then
be unhappy when it is returning 64-bit values.  As previously stated, it would
be possible to add a "32bitapi" mount option to force ext4 to always return
32-bit offset values, as is done with NFS. 

The alternative is for QEMU's telldir() to see that d_off is a 64-bit value,
but is exporting a 32-bit interface and downshift the offset to fit into a
32-bit field. It would store a '64BITOFFSET' flag in the file descriptor in
this case, and if seekdir() is called on that fd it will upshift the offset to
a 64-bit value again.  That will lose the low bits of the offset, but that is
unlikely to be noticeable until there are more than 65000 entries in a
directory.  Since the hash values are uniformly distributed, they will almost
immediately exceed 32 bits, and telldir() is uncommon for use after the first
entry is read, so this detection will work reliably.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
