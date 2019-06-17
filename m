Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3355548D59
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Jun 2019 21:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFQTCt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Jun 2019 15:02:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55868 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQTCt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Jun 2019 15:02:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 448532614E9
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH] ext4: Optimize case-insensitive lookups
Date:   Mon, 17 Jun 2019 15:02:40 -0400
Message-Id: <20190617190240.30996-1-krisman@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Temporarily cache a casefolded version of the file name under lookup in
ext4_filename, to avoid repeatedly casefolding it.  I got up to 30%
speedup on lookups of large directories (>100k entries), depending on
the length of the string under lookup.

v2:
  - Dinamically allocate space for the casefolded version.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/ext4/dir.c           |  2 +-
 fs/ext4/ext4.h          | 39 ++++++++++++++++++++++++++++++++++---
 fs/ext4/namei.c         | 43 ++++++++++++++++++++++++++++++++++++-----
 fs/unicode/utf8-core.c  | 28 +++++++++++++++++++++++++++
 include/linux/unicode.h |  3 +++
 5 files changed, 106 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index c7843b149a1e..0a427e18584a 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -674,7 +674,7 @@ static int ext4_d_compare(const struct dentry *dentry, unsigned int len,
 		return memcmp(str, name->name, len);
 	}
 
-	return ext4_ci_compare(dentry->d_parent->d_inode, name, &qstr);
+	return ext4_ci_compare(dentry->d_parent->d_inode, name, &qstr, false);
 }
 
 static int ext4_d_hash(const struct dentry *dentry, struct qstr *str)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1cb67859e051..c0793d9e5d12 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2077,6 +2077,9 @@ struct ext4_filename {
 #ifdef CONFIG_FS_ENCRYPTION
 	struct fscrypt_str crypto_buf;
 #endif
+#ifdef CONFIG_UNICODE
+	struct fscrypt_str cf_name;
+#endif
 };
 
 #define fname_name(p) ((p)->disk_name.name)
@@ -2302,6 +2305,12 @@ extern unsigned ext4_free_clusters_after_init(struct super_block *sb,
 					      struct ext4_group_desc *gdp);
 ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
 
+#ifdef CONFIG_UNICODE
+extern void ext4_fname_setup_ci_filename(struct inode *dir,
+					 const struct qstr *iname,
+					 struct fscrypt_str *fname);
+#endif
+
 #ifdef CONFIG_FS_ENCRYPTION
 static inline void ext4_fname_from_fscrypt_name(struct ext4_filename *dst,
 						const struct fscrypt_name *src)
@@ -2328,6 +2337,10 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 		return err;
 
 	ext4_fname_from_fscrypt_name(fname, &name);
+
+#ifdef CONFIG_UNICODE
+	ext4_fname_setup_ci_filename(dir, iname, &fname->cf_name);
+#endif
 	return 0;
 }
 
@@ -2343,6 +2356,10 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
 		return err;
 
 	ext4_fname_from_fscrypt_name(fname, &name);
+
+#ifdef CONFIG_UNICODE
+	ext4_fname_setup_ci_filename(dir, &dentry->d_name, &fname->cf_name);
+#endif
 	return 0;
 }
 
@@ -2356,6 +2373,11 @@ static inline void ext4_fname_free_filename(struct ext4_filename *fname)
 	fname->crypto_buf.name = NULL;
 	fname->usr_fname = NULL;
 	fname->disk_name.name = NULL;
+
+#ifdef CONFIG_UNICODE
+	kfree(fname->cf_name.name);
+	fname->cf_name.name = NULL;
+#endif
 }
 #else /* !CONFIG_FS_ENCRYPTION */
 static inline int ext4_fname_setup_filename(struct inode *dir,
@@ -2366,6 +2388,11 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 	fname->usr_fname = iname;
 	fname->disk_name.name = (unsigned char *) iname->name;
 	fname->disk_name.len = iname->len;
+
+#ifdef CONFIG_UNICODE
+	ext4_fname_setup_ci_filename(dir, iname, &fname->cf_name);
+#endif
+
 	return 0;
 }
 
@@ -2376,7 +2403,13 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
 	return ext4_fname_setup_filename(dir, &dentry->d_name, 1, fname);
 }
 
-static inline void ext4_fname_free_filename(struct ext4_filename *fname) { }
+static inline void ext4_fname_free_filename(struct ext4_filename *fname)
+{
+#ifdef CONFIG_UNICODE
+	kfree(fname->cf_name.name);
+	fname->cf_name.name = NULL;
+#endif
+}
 #endif /* !CONFIG_FS_ENCRYPTION */
 
 /* dir.c */
@@ -3119,8 +3152,8 @@ extern int ext4_handle_dirty_dirent_node(handle_t *handle,
 					 struct inode *inode,
 					 struct buffer_head *bh);
 extern int ext4_ci_compare(const struct inode *parent,
-			   const struct qstr *name,
-			   const struct qstr *entry);
+			   const struct qstr *fname,
+			   const struct qstr *entry, bool quick);
 
 #define S_SHIFT 12
 static const unsigned char ext4_type_by_mode[(S_IFMT >> S_SHIFT) + 1] = {
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index cd01c4a67ffb..4909ced4e672 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1259,19 +1259,24 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
 #ifdef CONFIG_UNICODE
 /*
  * Test whether a case-insensitive directory entry matches the filename
- * being searched for.
+ * being searched for.  If quick is set, assume the name being looked up
+ * is already in the casefolded form.
  *
  * Returns: 0 if the directory entry matches, more than 0 if it
  * doesn't match or less than zero on error.
  */
 int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
-		    const struct qstr *entry)
+		    const struct qstr *entry, bool quick)
 {
 	const struct ext4_sb_info *sbi = EXT4_SB(parent->i_sb);
 	const struct unicode_map *um = sbi->s_encoding;
 	int ret;
 
-	ret = utf8_strncasecmp(um, name, entry);
+	if (quick)
+		ret = utf8_strncasecmp_folded(um, name, entry);
+	else
+		ret = utf8_strncasecmp(um, name, entry);
+
 	if (ret < 0) {
 		/* Handle invalid character sequence as either an error
 		 * or as an opaque byte sequence.
@@ -1287,6 +1292,27 @@ int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 
 	return ret;
 }
+
+void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
+				  struct fscrypt_str *cf_name)
+{
+	if (!IS_CASEFOLDED(dir)) {
+		cf_name->name = NULL;
+		return;
+	}
+
+	cf_name->name = kmalloc(EXT4_NAME_LEN, GFP_NOFS);
+	if (!cf_name->name)
+		return;
+
+	cf_name->len = utf8_casefold(EXT4_SB(dir->i_sb)->s_encoding,
+				     iname, cf_name->name,
+				     EXT4_NAME_LEN);
+	if (cf_name->len <= 0) {
+		kfree(cf_name->name);
+		cf_name->name = NULL;
+	}
+}
 #endif
 
 /*
@@ -1313,8 +1339,15 @@ static inline bool ext4_match(const struct inode *parent,
 #endif
 
 #ifdef CONFIG_UNICODE
-	if (EXT4_SB(parent->i_sb)->s_encoding && IS_CASEFOLDED(parent))
-		return (ext4_ci_compare(parent, fname->usr_fname, &entry) == 0);
+	if (EXT4_SB(parent->i_sb)->s_encoding && IS_CASEFOLDED(parent)) {
+		if (fname->cf_name.name) {
+			struct qstr cf = {.name = fname->cf_name.name,
+					  .len = fname->cf_name.len};
+			return !ext4_ci_compare(parent, &cf, &entry, true);
+		}
+		return !ext4_ci_compare(parent, fname->usr_fname, &entry,
+					false);
+	}
 #endif
 
 	return fscrypt_match_name(&f, de->name, de->name_len);
diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 6afab4fdce90..71ca4d047d65 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -73,6 +73,34 @@ int utf8_strncasecmp(const struct unicode_map *um,
 }
 EXPORT_SYMBOL(utf8_strncasecmp);
 
+/* String cf is expected to be a valid UTF-8 casefolded
+ * string.
+ */
+int utf8_strncasecmp_folded(const struct unicode_map *um,
+			    const struct qstr *cf,
+			    const struct qstr *s1)
+{
+	const struct utf8data *data = utf8nfdicf(um->version);
+	struct utf8cursor cur1;
+	int c1, c2;
+	int i = 0;
+
+	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
+		return -EINVAL;
+
+	do {
+		c1 = utf8byte(&cur1);
+		c2 = cf->name[i++];
+		if (c1 < 0)
+			return -EINVAL;
+		if (c1 != c2)
+			return 1;
+	} while (c1);
+
+	return 0;
+}
+EXPORT_SYMBOL(utf8_strncasecmp_folded);
+
 int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 		  unsigned char *dest, size_t dlen)
 {
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index aec2c6d800aa..990aa97d8049 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -17,6 +17,9 @@ int utf8_strncmp(const struct unicode_map *um,
 
 int utf8_strncasecmp(const struct unicode_map *um,
 		 const struct qstr *s1, const struct qstr *s2);
+int utf8_strncasecmp_folded(const struct unicode_map *um,
+			    const struct qstr *cf,
+			    const struct qstr *s1);
 
 int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 		   unsigned char *dest, size_t dlen);
-- 
2.20.1

