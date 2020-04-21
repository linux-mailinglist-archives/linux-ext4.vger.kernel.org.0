Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351641B32FA
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Apr 2020 01:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgDUXP7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 21 Apr 2020 19:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgDUXP7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 21 Apr 2020 19:15:59 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207367] Accraid / aptec / Microsemi / ext4 / larger then 16TB
Date:   Tue, 21 Apr 2020 23:15:58 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tytso@mit.edu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207367-13602-i41BjjiyCC@https.bugzilla.kernel.org/>
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

--- Comment #13 from Theodore Tso (tytso@mit.edu) ---
On Tue, Apr 21, 2020 at 09:45:54AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 21, 2020 at 06:29:10PM +0200, Jan Kara wrote:
> > Well, there are two problems with this - firstly, ocfs2 is also using jbd2
> > and it knows nothing about iomap. So that would have to be implemented.
> > Secondly, you have to somehow pass iomap ops to jbd2 so it all boils down
> > to passing some callback to jbd2 during journal init to map blocks anyway
> > as Dave said. And then it is upto filesystem to do the mapping - usually
> > directly using its internal block mapping function - so no need for iomap
> > AFAICT.
> 
> You'll need to describe the mapping some how.  So why not reuse an
> existing mechanism instead of creating a new ad-hoc one?

Well, we could argue that bmap() is an "existing mechanism" --- again,
bmap() returns a u64, so it's perfectly fine.  It's FIBMAP which is
"fundamentally broken", not bmap().  If the goal is to eventually
eliminate bmap() and aops->bmap(), sure, then we should force march
all file systems to use iomap_bmap(), including ocfs2.

Otherwise, if the goal alert users of FIBMAP when it's returning an
corrutped block number, why not move the check if the block is larger
than INT_MAX to ioctl_fibmap() in fs/ioctl.c, instead of in
iomap_bmap()?

If we can't fix this, I'm beginning to think that switching to iomap
for fiemap and bmap is actually a lose for ext4.  It's causing
performance regressions, and now we see it's causing functionality
regressions.  Sure, it's saving a bit of code size, but is it really
worth it to use iomap for fiemap/bmap?

                                                - Ted

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
