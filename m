Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA562523D94
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 21:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346984AbiEKTcl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 15:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347007AbiEKTcf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 15:32:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEE112463B
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 12:32:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 5DAEB1F42944
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652297549;
        bh=lWwjGPQZNKQyZU9L/pR9B/2LEb9B0zvK7S61tCd+dv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5u22+4IgucVqcfLjfcc8LdflwZG7JbI6mA2jIW+suVrl2Ggrnphft/0OZRtazk+W
         /+r/HhuptTJiwRfI3t83Urs6+FTsuX3lIwAkPXq2d8QzMKG23yVtGr10cr0n1X1Xr1
         InlazdsxP2/pwlmejtxaJFb5rP59/Ckgs85JOdyeLX47wr6P/RlOmr7BtqgGbdtS/j
         KDeVrPE6i7fnCITjBIJ/0loNZs5EixeB9CZfzwqqY/D4LfjEvDNAbFDBYsunn2J0IS
         8aH0b45fUDOti5xUN0lKzmvm9UtoNCF3GdHdXQLgmNpoS5vhaY1fqdX7Fz0nfP3JnU
         mljC93fN1sqPA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 10/10] f2fs: Move CONFIG_UNICODE defguards into the code flow
Date:   Wed, 11 May 2022 15:31:46 -0400
Message-Id: <20220511193146.27526-11-krisman@collabora.com>
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

Instead of a bunch of ifdefs, make the unicode built checks part of the
code flow where possible, as requested by Torvalds.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/f2fs/namei.c | 12 ++++++------
 fs/f2fs/super.c | 22 ++++++++++++----------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 5f213f05556d..843e4102347d 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -561,8 +561,8 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out_iput;
 	}
 out_splice:
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (!inode && IS_CASEFOLDED(dir)) {
+
+	if (IS_ENABLED(CONFIG_UNICODE) && !inode && IS_CASEFOLDED(dir)) {
 		/* Eventually we want to call d_add_ci(dentry, NULL)
 		 * for negative dentries in the encoding case as
 		 * well.  For now, prevent the negative dentry
@@ -571,7 +571,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		trace_f2fs_lookup_end(dir, dentry, ino, err);
 		return NULL;
 	}
-#endif
+
 	new = d_splice_alias(inode, dentry);
 	err = PTR_ERR_OR_ZERO(new);
 	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
@@ -622,16 +622,16 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 		goto fail;
 	}
 	f2fs_delete_entry(de, page, dir, inode);
-#if IS_ENABLED(CONFIG_UNICODE)
+
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
 	 * invalidating the dentries here, alongside with returning the
 	 * negative dentries at f2fs_lookup(), when it is better
 	 * supported by the VFS for the CI case.
 	 */
-	if (IS_CASEFOLDED(dir))
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
-#endif
+
 	f2fs_unlock_op(sbi);
 
 	if (IS_DIRSYNC(dir))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index baefd398ec1a..c336760ff743 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -278,12 +278,13 @@ f2fs_sb_read_encoding(const struct f2fs_super_block *sb)
 
 	return NULL;
 }
+#endif
 
 struct kmem_cache *f2fs_cf_name_slab;
 static int __init f2fs_create_casefold_cache(void)
 {
 	f2fs_cf_name_slab = f2fs_kmem_cache_create("f2fs_casefolded_name",
-							F2FS_NAME_LEN);
+						   F2FS_NAME_LEN);
 	if (!f2fs_cf_name_slab)
 		return -ENOMEM;
 	return 0;
@@ -293,10 +294,6 @@ static void f2fs_destroy_casefold_cache(void)
 {
 	kmem_cache_destroy(f2fs_cf_name_slab);
 }
-#else
-static int __init f2fs_create_casefold_cache(void) { return 0; }
-static void f2fs_destroy_casefold_cache(void) { }
-#endif
 
 static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
 {
@@ -1259,13 +1256,13 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 #endif
-#if !IS_ENABLED(CONFIG_UNICODE)
-	if (f2fs_sb_has_casefold(sbi)) {
+
+	if (!IS_ENABLED(CONFIG_UNICODE) && f2fs_sb_has_casefold(sbi)) {
 		f2fs_err(sbi,
 			"Filesystem with casefold feature cannot be mounted without CONFIG_UNICODE");
 		return -EINVAL;
 	}
-#endif
+
 	/*
 	 * The BLKZONED feature indicates that the drive was formatted with
 	 * zone alignment optimization. This is optional for host-aware
@@ -4611,7 +4608,10 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_init_compress_cache();
 	if (err)
 		goto free_compress_mempool;
-	err = f2fs_create_casefold_cache();
+
+	if (IS_ENABLED(CONFIG_UNICODE))
+		err = f2fs_create_casefold_cache();
+
 	if (err)
 		goto free_compress_cache;
 	return 0;
@@ -4654,7 +4654,9 @@ static int __init init_f2fs_fs(void)
 
 static void __exit exit_f2fs_fs(void)
 {
-	f2fs_destroy_casefold_cache();
+	if (IS_ENABLED(CONFIG_UNICODE))
+		f2fs_destroy_casefold_cache();
+
 	f2fs_destroy_compress_cache();
 	f2fs_destroy_compress_mempool();
 	f2fs_destroy_bioset();
-- 
2.36.1

