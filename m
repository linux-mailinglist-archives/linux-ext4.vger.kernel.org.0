Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2262E321DED
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Feb 2021 18:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhBVRRN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Feb 2021 12:17:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:45940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhBVRRM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 22 Feb 2021 12:17:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29A8FAFD7;
        Mon, 22 Feb 2021 17:16:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D68121E14ED; Mon, 22 Feb 2021 18:16:29 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Add checks to xattr code that we have appropriate reclaim context
Date:   Mon, 22 Feb 2021 18:16:26 +0100
Message-Id: <20210222171626.21884-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Syzbot is reporting that ext4 can enter fs reclaim from kvmalloc() while
the transaction is started like:

  fs_reclaim_acquire+0x117/0x150 mm/page_alloc.c:4340
  might_alloc include/linux/sched/mm.h:193 [inline]
  slab_pre_alloc_hook mm/slab.h:493 [inline]
  slab_alloc_node mm/slub.c:2817 [inline]
  __kmalloc_node+0x5f/0x430 mm/slub.c:4015
  kmalloc_node include/linux/slab.h:575 [inline]
  kvmalloc_node+0x61/0xf0 mm/util.c:587
  kvmalloc include/linux/mm.h:781 [inline]
  ext4_xattr_inode_cache_find fs/ext4/xattr.c:1465 [inline]
  ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1508 [inline]
  ext4_xattr_set_entry+0x1ce6/0x3780 fs/ext4/xattr.c:1649
  ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2224
  ext4_xattr_set_handle+0x8f4/0x13e0 fs/ext4/xattr.c:2380
  ext4_xattr_set+0x13a/0x340 fs/ext4/xattr.c:2493

This should be impossible since transaction start sets PF_MEMALLOC_NOFS.
Add some assertions to the code to catch if something isn't working as
expected early.

Link: https://lore.kernel.org/linux-ext4/000000000000563a0205bafb7970@google.com/
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/xattr.c | 4 ++++
 1 file changed, 4 insertions(+)

Hi Ted!

This is the debug patch we talked about on our last ext4 call. I hope we can
carry it for some time and see if syzbot hits any of the warnings.

Honza

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 372208500f4e..083c95126781 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1462,6 +1462,9 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
 	if (!ce)
 		return NULL;
 
+	WARN_ON_ONCE(ext4_handle_valid(journal_current_handle()) &&
+		     !(current->flags & PF_MEMALLOC_NOFS));
+
 	ea_data = kvmalloc(value_len, GFP_KERNEL);
 	if (!ea_data) {
 		mb_cache_entry_put(ea_inode_cache, ce);
@@ -2327,6 +2330,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 			error = -ENOSPC;
 			goto cleanup;
 		}
+		WARN_ON_ONCE(!(current->flags & PF_MEMALLOC_NOFS));
 	}
 
 	error = ext4_reserve_inode_write(handle, inode, &is.iloc);
-- 
2.26.2

