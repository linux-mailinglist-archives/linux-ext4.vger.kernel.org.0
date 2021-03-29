Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE90334C423
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Mar 2021 08:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhC2Gyi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Mar 2021 02:54:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:2713 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhC2GyU (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Mar 2021 02:54:20 -0400
IronPort-SDR: 9u/zopRHeJu/GtHdc9WX+uya0+Ko3gPk4ZeoU/t8UqhO0z5a+853IgWGjGWdoyEE4RXwdLQtM1
 LaoR35T7VdJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="179033946"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="179033946"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 23:54:19 -0700
IronPort-SDR: 7WRvIhgLKrvM/u4Y7LxZ4uNcN9XgnUjJwurqIC1LscpVa0oCLBHArfAOIDg6V0aLOj/3fkxzTq
 pBK0YANscEMg==
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="378008701"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 23:54:19 -0700
From:   ira.weiny@intel.com
To:     Jan Kara <jack@suse.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ext2: Match up ext2_put_page() with ext2_dotdot() and ext2_find_entry()
Date:   Sun, 28 Mar 2021 23:54:01 -0700
Message-Id: <20210329065402.3297092-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210329065402.3297092-1-ira.weiny@intel.com>
References: <20210329065402.3297092-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

ext2_dotdot() and ext2_find_entry() both require ext2_put_page() to be
called after successful return.  For some of the calls this
corresponding put was hidden in ext2_set_link and ext2_delete_entry().

Match up ext2_put_page() with ext2_dotdot() and ext2_find_entry() in the
functions which call them.  This makes the code easier to follow
regarding the get/put of the page.

Clean up comments to match new behavior.

To: Jan Kara <jack@suse.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/ext2/dir.c   | 5 +----
 fs/ext2/namei.c | 7 +++++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 14aa45316ad2..f0b8311cdf5b 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -434,7 +434,6 @@ static int ext2_prepare_chunk(struct page *page, loff_t pos, unsigned len)
 	return __block_write_begin(page, pos, len, ext2_get_block);
 }
 
-/* Releases the page */
 void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
 		   struct page *page, struct inode *inode, int update_times)
 {
@@ -449,7 +448,6 @@ void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext2_set_de_type(de, inode);
 	err = ext2_commit_chunk(page, pos, len);
-	ext2_put_page(page);
 	if (update_times)
 		dir->i_mtime = dir->i_ctime = current_time(dir);
 	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
@@ -556,7 +554,7 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
 
 /*
  * ext2_delete_entry deletes a directory entry by merging it with the
- * previous entry. Page is up-to-date. Releases the page.
+ * previous entry. Page is up-to-date.
  */
 int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
 {
@@ -594,7 +592,6 @@ int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
 	EXT2_I(inode)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(inode);
 out:
-	ext2_put_page(page);
 	return err;
 }
 
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 3367384d344d..7af9ab3f975e 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -294,6 +294,7 @@ static int ext2_unlink(struct inode * dir, struct dentry *dentry)
 	}
 
 	err = ext2_delete_entry (de, page);
+	ext2_put_page(page);
 	if (err)
 		goto out;
 
@@ -371,6 +372,7 @@ static int ext2_rename (struct user_namespace * mnt_userns,
 			goto out_dir;
 		}
 		ext2_set_link(new_dir, new_de, new_page, old_inode, 1);
+		ext2_put_page(new_page);
 		new_inode->i_ctime = current_time(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
@@ -391,12 +393,13 @@ static int ext2_rename (struct user_namespace * mnt_userns,
 	mark_inode_dirty(old_inode);
 
 	ext2_delete_entry (old_de, old_page);
+	ext2_put_page(old_page);
 
 	if (dir_de) {
 		if (old_dir != new_dir)
 			ext2_set_link(old_inode, dir_de, dir_page, new_dir, 0);
-		else
-			ext2_put_page(dir_page);
+
+		ext2_put_page(dir_page);
 		inode_dec_link_count(old_dir);
 	}
 	return 0;
-- 
2.28.0.rc0.12.gb6a658bd00c9

