Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A896D66B94F
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Jan 2023 09:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjAPIwY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Jan 2023 03:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjAPIwP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Jan 2023 03:52:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F213E3AC
        for <linux-ext4@vger.kernel.org>; Mon, 16 Jan 2023 00:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GONi9HDqtwEB/FQ8M9SACXjsHfWp7uZ5griWhPxLa8k=; b=r9pSCAW0VajGP7WeQOrNMdWmWB
        LeUPTUh6pBAgqx5sJvM3f2G1LcaToVxUCj+NfxcBmBETkZk7mwk+KJHxHRLgh5vaYM7+COmbJIRCU
        nCcRdwTor2f5P9YK37kzUKKENHrXETms0wCd54E165VAfMlxVLgD5PGeFnZfIl6y2ATr6EzRFwBLi
        NSOBDvWDTdXsG7xxV4saBmAhGVkxIswPcMTnKiw4gH9qLBZeDTOp/6SSAjiiXE07iHpm2Cm+xnbT3
        yHMCeiw4XcWGFctqDYzJLkGmWtN95nbV0kJRbLJzsR1CyJSP0Z3PpqJpa3eZ4yHaroFSYamPA4W7H
        /pucXmSw==;
Received: from [2001:4bb8:19a:2039:c63c:c37c:1cda:3fb2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHLDt-009E9A-I6; Mon, 16 Jan 2023 08:52:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext2: propagate errors from ext2_prepare_chunk
Date:   Mon, 16 Jan 2023 09:52:05 +0100
Message-Id: <20230116085205.2342975-1-hch@lst.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Propagate errors from ext2_prepare_chunk to the callers and handle them
there.  While touching the prototype also turn update_times into a bool
from the current int used as bool.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext2/dir.c   | 13 ++++++++-----
 fs/ext2/ext2.h  |  5 +++--
 fs/ext2/namei.c | 21 ++++++++++++---------
 3 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index e5cbc27ba4595b..947527929c2672 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -461,9 +461,9 @@ static int ext2_handle_dirsync(struct inode *dir)
 	return err;
 }
 
-void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
-		   struct page *page, void *page_addr, struct inode *inode,
-		   int update_times)
+int ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
+		struct page *page, void *page_addr, struct inode *inode,
+		bool update_times)
 {
 	loff_t pos = page_offset(page) +
 			(char *) de - (char *) page_addr;
@@ -472,7 +472,10 @@ void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
 
 	lock_page(page);
 	err = ext2_prepare_chunk(page, pos, len);
-	BUG_ON(err);
+	if (err) {
+		unlock_page(page);
+		return err;
+	}
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext2_set_de_type(de, inode);
 	ext2_commit_chunk(page, pos, len);
@@ -480,7 +483,7 @@ void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
 		dir->i_mtime = dir->i_ctime = current_time(dir);
 	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(dir);
-	ext2_handle_dirsync(dir);
+	return ext2_handle_dirsync(dir);
 }
 
 /*
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 28de11a22e5f6c..f7f590aac55a00 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -734,8 +734,9 @@ extern int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct page *page,
 			     char *kaddr);
 extern int ext2_empty_dir (struct inode *);
 extern struct ext2_dir_entry_2 *ext2_dotdot(struct inode *dir, struct page **p, void **pa);
-extern void ext2_set_link(struct inode *, struct ext2_dir_entry_2 *, struct page *, void *,
-			  struct inode *, int);
+int ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
+		struct page *page, void *page_addr, struct inode *inode,
+		bool update_times);
 static inline void ext2_put_page(struct page *page, void *page_addr)
 {
 	kunmap_local(page_addr);
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index c056957221a225..18b3d5af77240b 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -370,7 +370,10 @@ static int ext2_rename (struct user_namespace * mnt_userns,
 			err = PTR_ERR(new_de);
 			goto out_dir;
 		}
-		ext2_set_link(new_dir, new_de, new_page, page_addr, old_inode, 1);
+		err = ext2_set_link(new_dir, new_de, new_page, page_addr,
+				    old_inode, true);
+		if (err)
+			goto out_dir;
 		ext2_put_page(new_page, page_addr);
 		new_inode->i_ctime = current_time(new_inode);
 		if (dir_de)
@@ -394,24 +397,24 @@ static int ext2_rename (struct user_namespace * mnt_userns,
 	ext2_delete_entry(old_de, old_page, old_page_addr);
 
 	if (dir_de) {
-		if (old_dir != new_dir)
-			ext2_set_link(old_inode, dir_de, dir_page,
-				      dir_page_addr, new_dir, 0);
+		if (old_dir != new_dir) {
+			err = ext2_set_link(old_inode, dir_de, dir_page,
+					    dir_page_addr, new_dir, false);
 
+		}
 		ext2_put_page(dir_page, dir_page_addr);
 		inode_dec_link_count(old_dir);
 	}
 
+out_old:
 	ext2_put_page(old_page, old_page_addr);
-	return 0;
+out:
+	return err;
 
 out_dir:
 	if (dir_de)
 		ext2_put_page(dir_page, dir_page_addr);
-out_old:
-	ext2_put_page(old_page, old_page_addr);
-out:
-	return err;
+	goto out_old;
 }
 
 const struct inode_operations ext2_dir_inode_operations = {
-- 
2.39.0

