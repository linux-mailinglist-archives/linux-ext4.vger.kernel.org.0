Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05D1523D80
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 21:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245340AbiEKTcL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 15:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344980AbiEKTcI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 15:32:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D0D15FDA
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 12:32:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 1FFD41F42948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652297525;
        bh=N2TEr8NxHgbj8Sr+8Qlr5ENUySAcCIDIqDanNFClWUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJ2ffZOFMe48NW3hrSF95QwZyDfunmlez0P/dkkzYduIP0KjTGlyextUP7rzt6Omr
         Fikxm7Qct3xT6serErXceEAFOy5897nwdq/1RK2IBwq1SgimDmHzWPHGxiGC54/gOE
         QAL1csK/MDHn+cHyp0hSHajTQJ6gu1ib8s5IFnw/PcuUcomFb4k4fBAlmD5mRhYUqs
         0kjx4zlyOMImmIFGu6N5g+zfBkp2A+QHOPh9VveaFqkN3WcgMYGRR9Q1uULzae0FDI
         3vGOdFFXfOLFlQKpOF0A975KSUMxaKZfBuWR4U6RiHv2kmIJVJsTx0pN8TlBPQ8g/n
         nzIvmayXtTYIg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 03/10] f2fs: Simplify the handling of cached insensitive names
Date:   Wed, 11 May 2022 15:31:39 -0400
Message-Id: <20220511193146.27526-4-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511193146.27526-1-krisman@collabora.com>
References: <20220511193146.27526-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Keeping it as qstr avoids the unnecessary conversion in f2fs_match

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/f2fs/dir.c      | 52 ++++++++++++++++++++++++++++------------------
 fs/f2fs/f2fs.h     |  3 ++-
 fs/f2fs/recovery.c |  5 +----
 3 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 166f08623362..c2a02003c5b9 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -81,28 +81,47 @@ int f2fs_init_casefolded_name(const struct inode *dir,
 {
 #if IS_ENABLED(CONFIG_UNICODE)
 	struct super_block *sb = dir->i_sb;
+	unsigned char *buf;
+	int len;
 
 	if (IS_CASEFOLDED(dir)) {
-		fname->cf_name.name = f2fs_kmem_cache_alloc(f2fs_cf_name_slab,
+		buf = f2fs_kmem_cache_alloc(f2fs_cf_name_slab,
 					GFP_NOFS, false, F2FS_SB(sb));
-		if (!fname->cf_name.name)
-			return -ENOMEM;
-		fname->cf_name.len = utf8_casefold(sb->s_encoding,
-						   fname->usr_fname,
-						   fname->cf_name.name,
-						   F2FS_NAME_LEN);
-		if ((int)fname->cf_name.len <= 0) {
-			kmem_cache_free(f2fs_cf_name_slab, fname->cf_name.name);
+		if (!buf) {
 			fname->cf_name.name = NULL;
+			return -ENOMEM;
+		}
+
+		len = utf8_casefold(sb->s_encoding, fname->usr_fname,
+				    buf, F2FS_NAME_LEN);
+
+		if (len <= 0) {
+			kmem_cache_free(f2fs_cf_name_slab, buf);
+			buf = NULL;
 			if (sb_has_strict_encoding(sb))
 				return -EINVAL;
 			/* fall back to treating name as opaque byte sequence */
 		}
+		fname->cf_name.name = buf;
+		fname->cf_name.len = (unsigned int) len;
 	}
 #endif
 	return 0;
 }
 
+void f2fs_free_casefolded_name(struct f2fs_filename *fname)
+{
+#if IS_ENABLED(CONFIG_UNICODE)
+	unsigned char *buf = (unsigned char *)fname->cf_name.name;
+
+	if (buf) {
+		kmem_cache_free(f2fs_cf_name_slab, buf);
+		fname->cf_name.name = NULL;
+	}
+
+#endif
+}
+
 static int __f2fs_setup_filename(const struct inode *dir,
 				 const struct fscrypt_name *crypt_name,
 				 struct f2fs_filename *fname)
@@ -174,12 +193,7 @@ void f2fs_free_filename(struct f2fs_filename *fname)
 	kfree(fname->crypto_buf.name);
 	fname->crypto_buf.name = NULL;
 #endif
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (fname->cf_name.name) {
-		kmem_cache_free(f2fs_cf_name_slab, fname->cf_name.name);
-		fname->cf_name.name = NULL;
-	}
-#endif
+	f2fs_free_casefolded_name(fname);
 }
 
 static unsigned long dir_block_index(unsigned int level,
@@ -267,11 +281,9 @@ static inline int f2fs_match_name(const struct inode *dir,
 	struct fscrypt_name f;
 
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (fname->cf_name.name) {
-		struct qstr cf = FSTR_TO_QSTR(&fname->cf_name);
-
-		return f2fs_match_ci_name(dir, &cf, de_name, de_name_len);
-	}
+	if (fname->cf_name.name)
+		return f2fs_match_ci_name(dir, &fname->cf_name,
+					  de_name, de_name_len);
 #endif
 	f.usr_fname = fname->usr_fname;
 	f.disk_name = fname->disk_name;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 68b44015514f..4b6df34fc8b0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -497,7 +497,7 @@ struct f2fs_filename {
 	 * NULL.  In all these cases we fall back to treating the name as an
 	 * opaque byte sequence.
 	 */
-	struct fscrypt_str cf_name;
+	struct qstr cf_name;
 #endif
 };
 
@@ -3345,6 +3345,7 @@ struct dentry *f2fs_get_parent(struct dentry *child);
 unsigned char f2fs_get_de_type(struct f2fs_dir_entry *de);
 int f2fs_init_casefolded_name(const struct inode *dir,
 			      struct f2fs_filename *fname);
+void f2fs_free_casefolded_name(struct f2fs_filename *fname);
 int f2fs_setup_filename(struct inode *dir, const struct qstr *iname,
 			int lookup, struct f2fs_filename *fname);
 int f2fs_prepare_lookup(struct inode *dir, struct dentry *dentry,
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 79773d322c47..3c3a8abf6953 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -149,11 +149,8 @@ static int init_recovered_filename(const struct inode *dir,
 		if (err)
 			return err;
 		f2fs_hash_filename(dir, fname);
-#if IS_ENABLED(CONFIG_UNICODE)
 		/* Case-sensitive match is fine for recovery */
-		kmem_cache_free(f2fs_cf_name_slab, fname->cf_name.name);
-		fname->cf_name.name = NULL;
-#endif
+		f2fs_free_casefolded_name(fname);
 	} else {
 		f2fs_hash_filename(dir, fname);
 	}
-- 
2.36.1

