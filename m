Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A701B34C425
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Mar 2021 08:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhC2Gyi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Mar 2021 02:54:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:19489 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhC2GyZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Mar 2021 02:54:25 -0400
IronPort-SDR: htqgh4dP8VHbjSKuhF0lkUIK5ZIWaLbw+MHo9VZcXGG1TpBt7tQ2fEavVECfe6S2jn86LeGQqj
 QoOQRg99UG5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="190955302"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="190955302"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 23:54:21 -0700
IronPort-SDR: oRd8Aitym9GiIB05B24Et50CcEIktUmJy5MDwD1fkPImMJfmF/LlhzoiNdbxWLJfNkebr+DC99
 4gasEG7iDSjg==
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="437746618"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 23:54:21 -0700
From:   ira.weiny@intel.com
To:     Jan Kara <jack@suse.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fs/ext2: Replace kmap() with kmap_local_page()
Date:   Sun, 28 Mar 2021 23:54:02 -0700
Message-Id: <20210329065402.3297092-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210329065402.3297092-1-ira.weiny@intel.com>
References: <20210329065402.3297092-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The k[un]map() calls in ext2_[get|put]_page() are localized to a single
thread.  kmap_local_page() is more efficient.

Replace the kmap/kunmap calls with kmap_local_page()/kunmap_local().
kunmap_local() requires the mapping address so return that address from
ext2_get_page() to be used in ext2_put_page().  This works well because
many of the callers need the address anyway so it is not bad to return
it along with the page.

In addition, kmap_local_page()/kunmap_local() require strict nesting
rules to be followed.

Document the new nesting requirements of ext2_get_page() and
ext2_put_page() as well as the relationship between ext2_get_page(),
ext2_find_entry(), and ext2_dotdot().

Adjust one ext2_put_page() call site in ext2_rename() to ensure the new
nesting requirements are met.

Finally, adjust code style for checkpatch.

To: Jan Kara <jack@suse.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/ext2/dir.c   | 89 ++++++++++++++++++++++++++++++++-----------------
 fs/ext2/ext2.h  | 12 ++++---
 fs/ext2/namei.c | 35 +++++++++++--------
 3 files changed, 87 insertions(+), 49 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index f0b8311cdf5b..14292dba3a12 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -190,13 +190,20 @@ static bool ext2_check_page(struct page *page, int quiet)
 	return false;
 }
 
+/*
+ * Calls to ext2_get_page()/ext2_put_page() must be nested according to the
+ * rules documented in kmap_local_page()/kunmap_local().
+ *
+ * NOTE: ext2_find_entry() and ext2_dotdot() act as a call to ext2_get_page()
+ * and should be treated as a call to ext2_get_page() for nesting purposes.
+ */
 static struct page * ext2_get_page(struct inode *dir, unsigned long n,
-				   int quiet)
+				   int quiet, void **page_addr)
 {
 	struct address_space *mapping = dir->i_mapping;
 	struct page *page = read_mapping_page(mapping, n, NULL);
 	if (!IS_ERR(page)) {
-		kmap(page);
+		*page_addr = kmap_local_page(page);
 		if (unlikely(!PageChecked(page))) {
 			if (PageError(page) || !ext2_check_page(page, quiet))
 				goto fail;
@@ -205,7 +212,7 @@ static struct page * ext2_get_page(struct inode *dir, unsigned long n,
 	return page;
 
 fail:
-	ext2_put_page(page);
+	ext2_put_page(page, *page_addr);
 	return ERR_PTR(-EIO);
 }
 
@@ -276,7 +283,7 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
 	for ( ; n < npages; n++, offset = 0) {
 		char *kaddr, *limit;
 		ext2_dirent *de;
-		struct page *page = ext2_get_page(inode, n, 0);
+		struct page *page = ext2_get_page(inode, n, 0, (void **)&kaddr);
 
 		if (IS_ERR(page)) {
 			ext2_error(sb, __func__,
@@ -285,7 +292,6 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
 			ctx->pos += PAGE_SIZE - offset;
 			return PTR_ERR(page);
 		}
-		kaddr = page_address(page);
 		if (unlikely(need_revalidate)) {
 			if (offset) {
 				offset = ext2_validate_entry(kaddr, offset, chunk_mask);
@@ -300,7 +306,7 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
 			if (de->rec_len == 0) {
 				ext2_error(sb, __func__,
 					"zero-length directory entry");
-				ext2_put_page(page);
+				ext2_put_page(page, kaddr);
 				return -EIO;
 			}
 			if (de->inode) {
@@ -312,13 +318,13 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
 				if (!dir_emit(ctx, de->name, de->name_len,
 						le32_to_cpu(de->inode),
 						d_type)) {
-					ext2_put_page(page);
+					ext2_put_page(page, kaddr);
 					return 0;
 				}
 			}
 			ctx->pos += ext2_rec_len_from_disk(de->rec_len);
 		}
-		ext2_put_page(page);
+		ext2_put_page(page, kaddr);
 	}
 	return 0;
 }
@@ -332,9 +338,16 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
  * Entry is guaranteed to be valid.
  *
  * On Success ext2_put_page() should be called on *res_page.
+ *
+ * NOTE: Calls to ext2_get_page()/ext2_put_page() must be nested according to
+ * the rules documented in kmap_local_page()/kunmap_local().
+ *
+ * ext2_find_entry() and ext2_dotdot() act as a call to ext2_get_page() and
+ * should be treated as a call to ext2_get_page() for nesting purposes.
  */
 struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
-			const struct qstr *child, struct page **res_page)
+			const struct qstr *child, struct page **res_page,
+			void **res_page_addr)
 {
 	const char *name = child->name;
 	int namelen = child->len;
@@ -344,12 +357,14 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
 	struct page *page = NULL;
 	struct ext2_inode_info *ei = EXT2_I(dir);
 	ext2_dirent * de;
+	void *page_addr;
 
 	if (npages == 0)
 		goto out;
 
 	/* OFFSET_CACHE */
 	*res_page = NULL;
+	*res_page_addr = NULL;
 
 	start = ei->i_dir_start_lookup;
 	if (start >= npages)
@@ -357,25 +372,25 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
 	n = start;
 	do {
 		char *kaddr;
-		page = ext2_get_page(dir, n, 0);
+		page = ext2_get_page(dir, n, 0, &page_addr);
 		if (IS_ERR(page))
 			return ERR_CAST(page);
 
-		kaddr = page_address(page);
+		kaddr = page_addr;
 		de = (ext2_dirent *) kaddr;
 		kaddr += ext2_last_byte(dir, n) - reclen;
 		while ((char *) de <= kaddr) {
 			if (de->rec_len == 0) {
 				ext2_error(dir->i_sb, __func__,
 					"zero-length directory entry");
-				ext2_put_page(page);
+				ext2_put_page(page, page_addr);
 				goto out;
 			}
 			if (ext2_match(namelen, name, de))
 				goto found;
 			de = ext2_next_entry(de);
 		}
-		ext2_put_page(page);
+		ext2_put_page(page, page_addr);
 
 		if (++n >= npages)
 			n = 0;
@@ -393,6 +408,7 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
 
 found:
 	*res_page = page;
+	*res_page_addr = page_addr;
 	ei->i_dir_start_lookup = n;
 	return de;
 }
@@ -402,15 +418,24 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
  * (as a parameter - p).
  *
  * On Success ext2_put_page() should be called on *p.
+ *
+ * NOTE: Calls to ext2_get_page()/ext2_put_page() must be nested according to
+ * the rules documented in kmap_local_page()/kunmap_local().
+ *
+ * ext2_find_entry() and ext2_dotdot() act as a call to ext2_get_page() and
+ * should be treated as a call to ext2_get_page() for nesting purposes.
  */
-struct ext2_dir_entry_2 * ext2_dotdot (struct inode *dir, struct page **p)
+struct ext2_dir_entry_2 *ext2_dotdot(struct inode *dir, struct page **p,
+				     void **pa)
 {
-	struct page *page = ext2_get_page(dir, 0, 0);
+	void *page_addr;
+	struct page *page = ext2_get_page(dir, 0, 0, &page_addr);
 	ext2_dirent *de = NULL;
 
 	if (!IS_ERR(page)) {
-		de = ext2_next_entry((ext2_dirent *) page_address(page));
+		de = ext2_next_entry((ext2_dirent *) page_addr);
 		*p = page;
+		*pa = page_addr;
 	}
 	return de;
 }
@@ -419,13 +444,14 @@ int ext2_inode_by_name(struct inode *dir, const struct qstr *child, ino_t *ino)
 {
 	struct ext2_dir_entry_2 *de;
 	struct page *page;
+	void *page_addr;
 	
-	de = ext2_find_entry(dir, child, &page);
+	de = ext2_find_entry(dir, child, &page, &page_addr);
 	if (IS_ERR(de))
 		return PTR_ERR(de);
 
 	*ino = le32_to_cpu(de->inode);
-	ext2_put_page(page);
+	ext2_put_page(page, page_addr);
 	return 0;
 }
 
@@ -435,10 +461,11 @@ static int ext2_prepare_chunk(struct page *page, loff_t pos, unsigned len)
 }
 
 void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
-		   struct page *page, struct inode *inode, int update_times)
+		   struct page *page, void *page_addr, struct inode *inode,
+		   int update_times)
 {
 	loff_t pos = page_offset(page) +
-			(char *) de - (char *) page_address(page);
+			(char *) de - (char *) page_addr;
 	unsigned len = ext2_rec_len_from_disk(de->rec_len);
 	int err;
 
@@ -466,10 +493,10 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
 	unsigned reclen = EXT2_DIR_REC_LEN(namelen);
 	unsigned short rec_len, name_len;
 	struct page *page = NULL;
+	void *page_addr = NULL;
 	ext2_dirent * de;
 	unsigned long npages = dir_pages(dir);
 	unsigned long n;
-	char *kaddr;
 	loff_t pos;
 	int err;
 
@@ -479,14 +506,15 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
 	 * to protect that region.
 	 */
 	for (n = 0; n <= npages; n++) {
+		char *kaddr;
 		char *dir_end;
 
-		page = ext2_get_page(dir, n, 0);
+		page = ext2_get_page(dir, n, 0, &page_addr);
 		err = PTR_ERR(page);
 		if (IS_ERR(page))
 			goto out;
 		lock_page(page);
-		kaddr = page_address(page);
+		kaddr = page_addr;
 		dir_end = kaddr + ext2_last_byte(dir, n);
 		de = (ext2_dirent *)kaddr;
 		kaddr += PAGE_SIZE - reclen;
@@ -517,14 +545,14 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
 			de = (ext2_dirent *) ((char *) de + rec_len);
 		}
 		unlock_page(page);
-		ext2_put_page(page);
+		ext2_put_page(page, page_addr);
 	}
 	BUG();
 	return -EINVAL;
 
 got_it:
 	pos = page_offset(page) +
-		(char*)de - (char*)page_address(page);
+		(char *)de - (char *)page_addr;
 	err = ext2_prepare_chunk(page, pos, rec_len);
 	if (err)
 		goto out_unlock;
@@ -544,7 +572,7 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
 	mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
 out_put:
-	ext2_put_page(page);
+	ext2_put_page(page, page_addr);
 out:
 	return err;
 out_unlock:
@@ -641,6 +669,7 @@ int ext2_make_empty(struct inode *inode, struct inode *parent)
  */
 int ext2_empty_dir (struct inode * inode)
 {
+	void *page_addr = NULL;
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
 	int dir_has_error = 0;
@@ -648,14 +677,14 @@ int ext2_empty_dir (struct inode * inode)
 	for (i = 0; i < npages; i++) {
 		char *kaddr;
 		ext2_dirent * de;
-		page = ext2_get_page(inode, i, dir_has_error);
+		page = ext2_get_page(inode, i, dir_has_error, &page_addr);
 
 		if (IS_ERR(page)) {
 			dir_has_error = 1;
 			continue;
 		}
 
-		kaddr = page_address(page);
+		kaddr = page_addr;
 		de = (ext2_dirent *)kaddr;
 		kaddr += ext2_last_byte(inode, i) - EXT2_DIR_REC_LEN(1);
 
@@ -681,12 +710,12 @@ int ext2_empty_dir (struct inode * inode)
 			}
 			de = ext2_next_entry(de);
 		}
-		ext2_put_page(page);
+		ext2_put_page(page, page_addr);
 	}
 	return 1;
 
 not_empty:
-	ext2_put_page(page);
+	ext2_put_page(page, page_addr);
 	return 0;
 }
 
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 3309fb2d327a..ad01ef997926 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -742,14 +742,16 @@ extern int ext2_add_link (struct dentry *, struct inode *);
 extern int ext2_inode_by_name(struct inode *dir,
 			      const struct qstr *child, ino_t *ino);
 extern int ext2_make_empty(struct inode *, struct inode *);
-extern struct ext2_dir_entry_2 * ext2_find_entry (struct inode *,const struct qstr *, struct page **);
+extern struct ext2_dir_entry_2 *ext2_find_entry(struct inode *, const struct qstr *,
+						struct page **, void **res_page_addr);
 extern int ext2_delete_entry (struct ext2_dir_entry_2 *, struct page *);
 extern int ext2_empty_dir (struct inode *);
-extern struct ext2_dir_entry_2 * ext2_dotdot (struct inode *, struct page **);
-extern void ext2_set_link(struct inode *, struct ext2_dir_entry_2 *, struct page *, struct inode *, int);
-static inline void ext2_put_page(struct page *page)
+extern struct ext2_dir_entry_2 *ext2_dotdot(struct inode *dir, struct page **p, void **pa);
+extern void ext2_set_link(struct inode *, struct ext2_dir_entry_2 *, struct page *, void *,
+			  struct inode *, int);
+static inline void ext2_put_page(struct page *page, void *page_addr)
 {
-	kunmap(page);
+	kunmap_local(page_addr);
 	put_page(page);
 }
 
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 7af9ab3f975e..c45e175bea9c 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -281,20 +281,21 @@ static int ext2_unlink(struct inode * dir, struct dentry *dentry)
 	struct inode * inode = d_inode(dentry);
 	struct ext2_dir_entry_2 * de;
 	struct page * page;
+	void *page_addr;
 	int err;
 
 	err = dquot_initialize(dir);
 	if (err)
 		goto out;
 
-	de = ext2_find_entry(dir, &dentry->d_name, &page);
+	de = ext2_find_entry(dir, &dentry->d_name, &page, &page_addr);
 	if (IS_ERR(de)) {
 		err = PTR_ERR(de);
 		goto out;
 	}
 
 	err = ext2_delete_entry (de, page);
-	ext2_put_page(page);
+	ext2_put_page(page, page_addr);
 	if (err)
 		goto out;
 
@@ -329,8 +330,10 @@ static int ext2_rename (struct user_namespace * mnt_userns,
 	struct inode * old_inode = d_inode(old_dentry);
 	struct inode * new_inode = d_inode(new_dentry);
 	struct page * dir_page = NULL;
+	void *dir_page_addr;
 	struct ext2_dir_entry_2 * dir_de = NULL;
 	struct page * old_page;
+	void *old_page_addr;
 	struct ext2_dir_entry_2 * old_de;
 	int err;
 
@@ -345,7 +348,8 @@ static int ext2_rename (struct user_namespace * mnt_userns,
 	if (err)
 		goto out;
 
-	old_de = ext2_find_entry(old_dir, &old_dentry->d_name, &old_page);
+	old_de = ext2_find_entry(old_dir, &old_dentry->d_name, &old_page,
+				 &old_page_addr);
 	if (IS_ERR(old_de)) {
 		err = PTR_ERR(old_de);
 		goto out;
@@ -353,12 +357,13 @@ static int ext2_rename (struct user_namespace * mnt_userns,
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		err = -EIO;
-		dir_de = ext2_dotdot(old_inode, &dir_page);
+		dir_de = ext2_dotdot(old_inode, &dir_page, &dir_page_addr);
 		if (!dir_de)
 			goto out_old;
 	}
 
 	if (new_inode) {
+		void *page_addr;
 		struct page *new_page;
 		struct ext2_dir_entry_2 *new_de;
 
@@ -366,13 +371,14 @@ static int ext2_rename (struct user_namespace * mnt_userns,
 		if (dir_de && !ext2_empty_dir (new_inode))
 			goto out_dir;
 
-		new_de = ext2_find_entry(new_dir, &new_dentry->d_name, &new_page);
+		new_de = ext2_find_entry(new_dir, &new_dentry->d_name,
+					 &new_page, &page_addr);
 		if (IS_ERR(new_de)) {
 			err = PTR_ERR(new_de);
 			goto out_dir;
 		}
-		ext2_set_link(new_dir, new_de, new_page, old_inode, 1);
-		ext2_put_page(new_page);
+		ext2_set_link(new_dir, new_de, new_page, page_addr, old_inode, 1);
+		ext2_put_page(new_page, page_addr);
 		new_inode->i_ctime = current_time(new_inode);
 		if (dir_de)
 			drop_nlink(new_inode);
@@ -392,24 +398,25 @@ static int ext2_rename (struct user_namespace * mnt_userns,
 	old_inode->i_ctime = current_time(old_inode);
 	mark_inode_dirty(old_inode);
 
-	ext2_delete_entry (old_de, old_page);
-	ext2_put_page(old_page);
+	ext2_delete_entry(old_de, old_page);
 
 	if (dir_de) {
 		if (old_dir != new_dir)
-			ext2_set_link(old_inode, dir_de, dir_page, new_dir, 0);
+			ext2_set_link(old_inode, dir_de, dir_page,
+				      dir_page_addr, new_dir, 0);
 
-		ext2_put_page(dir_page);
+		ext2_put_page(dir_page, dir_page_addr);
 		inode_dec_link_count(old_dir);
 	}
-	return 0;
 
+	ext2_put_page(old_page, old_page_addr);
+	return 0;
 
 out_dir:
 	if (dir_de)
-		ext2_put_page(dir_page);
+		ext2_put_page(dir_page, dir_page_addr);
 out_old:
-	ext2_put_page(old_page);
+	ext2_put_page(old_page, old_page_addr);
 out:
 	return err;
 }
-- 
2.28.0.rc0.12.gb6a658bd00c9

