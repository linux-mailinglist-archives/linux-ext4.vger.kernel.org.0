Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7562B0B76
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Nov 2020 18:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgKLRnH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Nov 2020 12:43:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:5392 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgKLRnG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 12 Nov 2020 12:43:06 -0500
IronPort-SDR: kjJpmFM9fSzq/rbARXA9GgdjZKRYu1K9ugl+I6Cg8Rm+GEzJaMwHoUcTM3qljdvmMYaD1jTv8a
 3S/0zYckEbTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="158127445"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="158127445"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 09:42:48 -0800
IronPort-SDR: pTP+0//zWAygGsYSUMfU2BlOtKrO1g1gFXdQg6CTfaSaM/bmK0dpZ1LAuIN4lAvIjCpqDC8GeO
 W08JnmRhNvFg==
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="542341826"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 09:42:47 -0800
From:   ira.weiny@intel.com
To:     Jan Kara <jack@suse.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] fs/ext2: Use ext2_put_page
Date:   Thu, 12 Nov 2020 09:42:44 -0800
Message-Id: <20201112174244.701325-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201111205530.436692-1-ira.weiny@intel.com>
References: <20201111205530.436692-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

There are 3 places in namei.c where the equivalent of ext2_put_page() is
open coded on a page which was returned from the ext2_get_page() call
[through the use of ext2_find_entry() and ext2_dotdot()].

Move ext2_put_page() to ext2.h and use it in namei.c

Also add a comment regarding the proper way to release the page returned
from ext2_find_entry() and ext2_dotdot().

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
	Reported-by: kernel test robot <lkp@intel.com>
	move ext2_get_page() back to dir.c; my testing must have had the
	wrong .config because I did not see the compile error
	yesterday...

This was originally part of the kmap_thread() series here:

https://lore.kernel.org/lkml/20201009195033.3208459-37-ira.weiny@intel.com/

But this is really a valid clean up regardless of the
kmap_thread[local]() changes.
---
 fs/ext2/dir.c   | 14 ++++++++------
 fs/ext2/ext2.h  |  7 +++++++
 fs/ext2/namei.c | 15 +++++----------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 70355ab6740e..14aa45316ad2 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -66,12 +66,6 @@ static inline unsigned ext2_chunk_size(struct inode *inode)
 	return inode->i_sb->s_blocksize;
 }
 
-static inline void ext2_put_page(struct page *page)
-{
-	kunmap(page);
-	put_page(page);
-}
-
 /*
  * Return the offset into page `page_nr' of the last valid
  * byte in that page, plus one.
@@ -336,6 +330,8 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
  * returns the page in which the entry was found (as a parameter - res_page),
  * and the entry itself. Page is returned mapped and unlocked.
  * Entry is guaranteed to be valid.
+ *
+ * On Success ext2_put_page() should be called on *res_page.
  */
 struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
 			const struct qstr *child, struct page **res_page)
@@ -401,6 +397,12 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
 	return de;
 }
 
+/**
+ * Return the '..' directory entry and the page in which the entry was found
+ * (as a parameter - p).
+ *
+ * On Success ext2_put_page() should be called on *p.
+ */
 struct ext2_dir_entry_2 * ext2_dotdot (struct inode *dir, struct page **p)
 {
 	struct page *page = ext2_get_page(dir, 0, 0);
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 5136b7289e8d..2a4175fbaf5e 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -16,6 +16,8 @@
 #include <linux/blockgroup_lock.h>
 #include <linux/percpu_counter.h>
 #include <linux/rbtree.h>
+#include <linux/mm.h>
+#include <linux/highmem.h>
 
 /* XXX Here for now... not interested in restructing headers JUST now */
 
@@ -745,6 +747,11 @@ extern int ext2_delete_entry (struct ext2_dir_entry_2 *, struct page *);
 extern int ext2_empty_dir (struct inode *);
 extern struct ext2_dir_entry_2 * ext2_dotdot (struct inode *, struct page **);
 extern void ext2_set_link(struct inode *, struct ext2_dir_entry_2 *, struct page *, struct inode *, int);
+static inline void ext2_put_page(struct page *page)
+{
+	kunmap(page);
+	put_page(page);
+}
 
 /* ialloc.c */
 extern struct inode * ext2_new_inode (struct inode *, umode_t, const struct qstr *);
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 5bf2c145643b..ea980f1e2e99 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -389,23 +389,18 @@ static int ext2_rename (struct inode * old_dir, struct dentry * old_dentry,
 	if (dir_de) {
 		if (old_dir != new_dir)
 			ext2_set_link(old_inode, dir_de, dir_page, new_dir, 0);
-		else {
-			kunmap(dir_page);
-			put_page(dir_page);
-		}
+		else
+			ext2_put_page(dir_page);
 		inode_dec_link_count(old_dir);
 	}
 	return 0;
 
 
 out_dir:
-	if (dir_de) {
-		kunmap(dir_page);
-		put_page(dir_page);
-	}
+	if (dir_de)
+		ext2_put_page(dir_page);
 out_old:
-	kunmap(old_page);
-	put_page(old_page);
+	ext2_put_page(old_page);
 out:
 	return err;
 }
-- 
2.28.0.rc0.12.gb6a658bd00c9

