Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CBB1B20FB
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Apr 2020 10:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgDUIEK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 21 Apr 2020 04:04:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgDUIEI (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 21 Apr 2020 04:04:08 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207367] Accraid / aptec / Microsemi / ext4 / larger then 16TB
Date:   Tue, 21 Apr 2020 08:04:08 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hch@infradead.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207367-13602-f5VbaZT9tm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207367-13602@https.bugzilla.kernel.org/>
References: <bug-207367-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207367

--- Comment #8 from hch@infradead.org ---
On Tue, Apr 21, 2020 at 03:08:50PM +1000, Dave Chinner wrote:
> > FYI - I do see that bmap() is also used by below APIs/subsystem.
> > Not sure if any of subsystems mentioned below may still fail later
> > if the underlying FS moved to iomap_bmap() interface or for
> > any existing callers of iomap_bmap() :-
> > 
> > 1. mm/page-io.c (generic_swapfile_activate() func)
> 
> Filesystems using iomap infrastructure should be providing
> aops->swap_activate() to map swapfile extents via
> iomap_swapfile_activate() (e.g. see xfs_iomap_swapfile_activate()),
> not using generic_swapfile_activate().

And we also need to eventually phase generic_swapfile_activate out,
maybe by having a version with a get_blocks callback for the non-iomap
case.

> > 4. fs/jbd2/journal.c
> 
> Broken on filesystems where the journal file might be placed beyond
> a 32 bit block number, iomap_bmap() just makes that obvious. Needs
> fixing.

I think this wants to use iomap, as that would solve all the problems.

> And you missed the MD bitmap code uses bmap() to map it's bitmap
> storage file, which means that is broken is the bitmap file is on a
> filesystem/block device > 16TB, too...

This probably needs to use the in-kernel direct I/O interface, just
as it is planned for cachefiles.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
