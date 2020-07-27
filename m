Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083A222E950
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 11:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgG0Jlg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 27 Jul 2020 05:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:33074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG0Jlf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 05:41:35 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207729] Mounting EXT4 with data_err=abort does not abort
 journal on data block write failure
Date:   Mon, 27 Jul 2020 09:41:34 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jack@suse.cz
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc
Message-ID: <bug-207729-13602-xdNi2iWy9Q@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207729-13602@https.bugzilla.kernel.org/>
References: <bug-207729-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207729

Jan Kara (jack@suse.cz) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
                 CC|                            |jack@suse.cz

--- Comment #1 from Jan Kara (jack@suse.cz) ---
Thanks for the report! So it is actually a description of data_err=abort mount
option that is somewhat misleading. Let me explain a bit more: Ext4 in
data=ordered mode guarantees to write contents of newly allocated data blocks
during transaction commit, after which changes that make these blocks visible
will become durable. In practice, whenever a new blocks are allocated for a
file, we write out the range of a file that covers all the newly allocated
blocks but that's just an implementation detail. And data_err=abort controls
the behavior when this particular writeout of data blocks fail. In your test
there are no newly allocated blocks in the transaction so the data_err=abort
does not apply.

To explain some rationale, such data writeback errors are indeed more serious
because if we just committed the transaction despite these errors, the newly
allocated blocks could expose stale, potentially security sensitive, data from
other files. So that's why the option was introduced.

But I agree that the documentation is misleading and the semantics of the
option is somewhat peculiar. I'll talk to other ext4 developers how we could
possibly improve the situation.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
