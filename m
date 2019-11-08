Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78233F4811
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2019 12:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390237AbfKHLyZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Nov 2019 06:54:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:47290 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387515AbfKHLyY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 8 Nov 2019 06:54:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27467ABE9;
        Fri,  8 Nov 2019 11:54:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E52B31E155F; Fri,  8 Nov 2019 12:54:20 +0100 (CET)
Date:   Fri, 8 Nov 2019 12:54:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-kernel@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] ext4: deaccount delayed allocations at freeing inode in
 ext4_evict_inode()
Message-ID: <20191108115420.GI20863@quack2.suse.cz>
References: <157233344808.4027.17162642259754563372.stgit@buzz>
 <20191108020827.15D1EAE056@d06av26.portsmouth.uk.ibm.com>
 <d00c572b-66ae-42dc-746a-e2c365c9895a@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <d00c572b-66ae-42dc-746a-e2c365c9895a@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri 08-11-19 11:30:56, Konstantin Khlebnikov wrote:
> On 08/11/2019 05.08, Ritesh Harjani wrote:
> > 
> > 
> > On 10/29/19 12:47 PM, Konstantin Khlebnikov wrote:
> > > If inode->i_blocks is zero then ext4_evict_inode() skips ext4_truncate().
> > > Delayed allocation extents are freed later in ext4_clear_inode() but this
> > > happens when quota reference is already dropped. This leads to leak of
> > > reserved space in quota block, which disappears after umount-mount.
> > > 
> > > This seems broken for a long time but worked somehow until recent changes
> > > in delayed allocation.
> > 
> > Sorry, I may have missed it, but could you please help understand
> > what recent changes in delayed allocation make this break or worse?
> 
> I don't see problem for 4.19. Haven't bisected yet.
> Most likely this is around 'reserved cluster accounting'.
> 
> I suspect before these changes something always triggered da before
> unlink and space usage committed and then truncated at eviction.

Yes, I think it's commit 8fcc3a580651 "ext4: rework reserved cluster
accounting when invalidating pages". Because that commit moved releasing of
reserved space from page invalidation time to extent status tree eviction
time. Does attached patch fix the problem for you?

> > A silly query, since I couldn't figure it out. Maybe the code has been
> > there ever since like this:-
> 
> > So why can't we just move drop_dquot later after the ext4_es_remove_extent() (in function ext4_clear_inode)? Any known
> > problems around that?
> 
> Clear_inode is called also when inode evicts from cache while it has nlinks
> and stays at disk. I'm not sure how this must interact with reserves.

In that case all data should be written out for such inode and thus there
should be no reserves...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--u3/rZRmxL6MmkK24
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-ext4-Fix-leak-of-quota-reservations.patch"

From ee27836b579d3bf750d45cd7081d3433ea6fedd5 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Fri, 8 Nov 2019 12:45:11 +0100
Subject: [PATCH] ext4: Fix leak of quota reservations

Commit 8fcc3a580651 ("ext4: rework reserved cluster accounting when
invalidating pages") moved freeing of delayed allocation reservations
from dirty page invalidation time to time when we evict corresponding
status extent from extent status tree. For inodes which don't have any
blocks allocated this may actually happen only in ext4_clear_blocks()
which is after we've dropped references to quota structures from the
inode. Thus reservation of quota leaked. Fix the problem by clearing
quota information from the inode only after evicting extent status tree
in ext4_clear_inode().

Reported-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: 8fcc3a580651 ("ext4: rework reserved cluster accounting when invalidating pages")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ialloc.c | 5 -----
 fs/ext4/super.c  | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 764ff4c56233..564e2ceb8417 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -265,13 +265,8 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
 	ext4_debug("freeing inode %lu\n", ino);
 	trace_ext4_free_inode(inode);
 
-	/*
-	 * Note: we must free any quota before locking the superblock,
-	 * as writing the quota to disk may need the lock as well.
-	 */
 	dquot_initialize(inode);
 	dquot_free_inode(inode);
-	dquot_drop(inode);
 
 	is_directory = S_ISDIR(inode->i_mode);
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dd654e53ba3d..9589f09a40f6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1172,9 +1172,9 @@ void ext4_clear_inode(struct inode *inode)
 {
 	invalidate_inode_buffers(inode);
 	clear_inode(inode);
-	dquot_drop(inode);
 	ext4_discard_preallocations(inode);
 	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
+	dquot_drop(inode);
 	if (EXT4_I(inode)->jinode) {
 		jbd2_journal_release_jbd_inode(EXT4_JOURNAL(inode),
 					       EXT4_I(inode)->jinode);
-- 
2.16.4


--u3/rZRmxL6MmkK24--
