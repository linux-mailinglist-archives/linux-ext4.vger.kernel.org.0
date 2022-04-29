Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2575153A0
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Apr 2022 20:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380003AbiD2SbQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Apr 2022 14:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379997AbiD2SbQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Apr 2022 14:31:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C1188782
        for <linux-ext4@vger.kernel.org>; Fri, 29 Apr 2022 11:27:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 89A801F4690E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651256875;
        bh=N4xE+tP+/xJwSBLiGEgC0LQSqlTfjK6uguGhjdBx16g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gEoUJ/Jk8z8Z5h1gNcH3rwAmo/SEAAjZgpSzxoTOr7pi5cQMuv36mzv1sGBfA3DT3
         4thtfV1pPzffoedES70Yi9hdPHsIUVBENC6+M3IpONvUX+8BWW39Nk73sO2dJ93z+V
         moqqHdXHhygfkWfN5HR7GkkN2TgA4NnZHw+6EOSencP2w4b+Zw6nrYKUnctnLOqYkp
         5ZaO734rjVnLYr6nOB1Ltlg/D7ZkXJv3BS1YCDkjXfsrJi7AcAZdunmYPUFuM6Fhse
         6bHjvWBERHX+NoFi+rbHPx9zwOhwCN7TQQIuG3MvM70PRy/KdroSfvegGkLkg1fIkM
         md/k6edUMgEnw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 6/7] ext4: Move ext4_match_ci into libfs
Date:   Fri, 29 Apr 2022 14:27:27 -0400
Message-Id: <20220429182728.14008-7-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429182728.14008-1-krisman@collabora.com>
References: <20220429182728.14008-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Matching case-insensitive names is a generic operation and can be shared
with f2fs.  Move it next to the rest of the shared casefold fs code.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/ext4/namei.c    | 62 +---------------------------------------------
 fs/libfs.c         | 61 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  3 +++
 3 files changed, 65 insertions(+), 61 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d53c8d101099..df44ea626fad 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1318,66 +1318,6 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
 }
 
 #if IS_ENABLED(CONFIG_UNICODE)
-/**
- * ext4_match_ci() - Match (case-insensitive) a name with a dirent.
- * @parent: Inode of the parent of the dentry.
- * @uname: name under lookup.
- * @de_name: Dirent name.
- * @de_name_len: dirent name length.
- *
- * Test whether a case-insensitive directory entry matches the filename
- * being searched.
- *
- * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
- * < 0 on error.
- */
-static int ext4_match_ci(const struct inode *parent,
-			 const struct unicode_name *uname,
-			 u8 *de_name, size_t de_name_len)
-{
-	const struct super_block *sb = parent->i_sb;
-	const struct unicode_map *um = sb->s_encoding;
-	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
-	struct qstr entry = QSTR_INIT(de_name, de_name_len);
-	int ret, match = false;
-
-	if (IS_ENCRYPTED(parent)) {
-		const struct fscrypt_str encrypted_name =
-				FSTR_INIT(de_name, de_name_len);
-
-		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
-		if (!decrypted_name.name)
-			return -ENOMEM;
-		ret = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
-						&decrypted_name);
-		if (ret < 0)
-			goto out;
-		entry.name = decrypted_name.name;
-		entry.len = decrypted_name.len;
-	}
-
-	if (uname->folded_name->name)
-		ret = utf8_strncasecmp_folded(um, uname->folded_name, &entry);
-	else
-		ret = utf8_strncasecmp(um, uname->usr_name, &entry);
-
-	if (!ret)
-		match = true;
-	else if (ret < 0 && !sb_has_strict_encoding(sb)) {
-		/*
-		 * In non-strict mode, fallback to a byte comparison if
-		 * the names have invalid characters.
-		 */
-		ret = 0;
-		match = ((uname->usr_name->len == entry.len) &&
-			 !memcmp(uname->usr_name->name, entry.name, entry.len));
-	}
-
-out:
-	kfree(decrypted_name.name);
-	return (ret >= 0) ? match : ret;
-}
-
 int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 				  struct ext4_filename *name)
 {
@@ -1450,7 +1390,7 @@ static bool ext4_match(struct inode *parent,
 		u.folded_name = &fname->cf_name;
 		u.usr_name = fname->usr_fname;
 
-		ret = ext4_match_ci(parent, &u, de->name, de->name_len);
+		ret = generic_ci_match(parent, &u, de->name, de->name_len);
 		if (ret < 0) {
 			/*
 			 * Treat comparison errors as not a match.  The
diff --git a/fs/libfs.c b/fs/libfs.c
index 974125270a42..c14b3fa615f5 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1465,6 +1465,67 @@ static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
 };
+
+/**
+ * generic_ci_match() - Match (case-insensitive) a name with a dirent.
+ * @parent: Inode of the parent of the dentry.
+ * @uname: name under lookup.
+ * @de_name: Dirent name.
+ * @de_name_len: dirent name length.
+ *
+ * Test whether a case-insensitive directory entry matches the filename
+ * being searched.
+ *
+ * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
+ * < 0 on error.
+ */
+int generic_ci_match(const struct inode *parent,
+		     const struct unicode_name *uname,
+		     u8 *de_name, size_t de_name_len)
+{
+	const struct super_block *sb = parent->i_sb;
+	const struct unicode_map *um = sb->s_encoding;
+	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
+	struct qstr entry = QSTR_INIT(de_name, de_name_len);
+	int ret, match = false;
+
+	if (IS_ENCRYPTED(parent)) {
+		const struct fscrypt_str encrypted_name =
+			FSTR_INIT(de_name, de_name_len);
+
+		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
+		if (!decrypted_name.name)
+			return -ENOMEM;
+		ret = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
+						&decrypted_name);
+		if (ret < 0)
+			goto out;
+		entry.name = decrypted_name.name;
+		entry.len = decrypted_name.len;
+	}
+
+	if (uname->folded_name->name)
+		ret = utf8_strncasecmp_folded(um, uname->folded_name, &entry);
+	else
+		ret = utf8_strncasecmp(um, uname->usr_name, &entry);
+
+	if (!ret)
+		match = true;
+	else if (ret < 0 && !sb_has_strict_encoding(sb)) {
+		/*
+		 * In non-strict mode, fallback to a byte comparison if
+		 * the names have invalid characters.
+		 */
+		ret = 0;
+		match = ((uname->usr_name->len == entry.len) &&
+			 !memcmp(uname->usr_name->name, entry.name, entry.len));
+	}
+
+out:
+	kfree(decrypted_name.name);
+	return (ret >= 0) ? match : ret;
+}
+EXPORT_SYMBOL(generic_ci_match);
 #endif
 
 #ifdef CONFIG_FS_ENCRYPTION
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3f76a18a5f40..6a750b8704c9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3364,6 +3364,9 @@ struct unicode_name {
 };
 
 extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
+extern int generic_ci_match(const struct inode *parent,
+			    const struct unicode_name *uname, u8 *de_name,
+			    size_t de_name_len);
 
 #ifdef CONFIG_MIGRATION
 extern int buffer_migrate_page(struct address_space *,
-- 
2.35.1

