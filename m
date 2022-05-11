Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678A2523D85
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 21:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346464AbiEKTcQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346901AbiEKTcL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 15:32:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A7756FB3
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 12:32:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 8B01A1F42944
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652297528;
        bh=jXSApmwKt9A12GLlMcHNXsKbIVOb7Ib9KkOyAmhLVhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7I6UaRP59k2wRohMrSXqi4JaBIa0iRvfjVriIPJp2D/ZcHhH/QSMWUq+y0Nt6DeO
         bUNsV9WEzz6jhmdOI7oLJvCENJ2nsQm07OWcmI7yPHjbnNb7dlxdFRSpCZd05MHXYh
         IPCoWL4qqTVTJCnfAeLk/bGFxK0NM70s6tTNDMEZLtI34TCgCCLlWAythJTBFURLTb
         qHZLcQrshDWB7Euau/PVh1sGI/73EKokHwaMB9mcqPsXst1vlLVQqMFAByccKiYWjn
         VPy56mPHpA9RlOhDu8ga6Q9dmqI+AIOJEkn881JDF+tyj5KUWukkSaXrjdyskqFQEi
         3WRogz1GCCktg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 04/10] ext4: Implement ci comparison using unicode_name
Date:   Wed, 11 May 2022 15:31:40 -0400
Message-Id: <20220511193146.27526-5-krisman@collabora.com>
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

By using a new type here, we can hide most of the caching casefold logic
from ext4.  The condition in ext4_match is now quite redundant, but this
is addressed in the next patch.

This doesn't use ext4_filename to keep it generic, since the function
will be moved to libfs to be shared with f2fs.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

--
Changes since v1:
  - Instead of (ab)using fscrypt_name, create a new type (ebiggers).
---
 fs/ext4/namei.c    | 32 +++++++++++++++-----------------
 include/linux/fs.h |  5 +++++
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 84fdb23f09b8..5296ced2e43e 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1321,20 +1321,19 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
 /**
  * ext4_match_ci() - Match (case-insensitive) a name with a dirent.
  * @parent: Inode of the parent of the dentry.
- * @name: name under lookup.
+ * @uname: name under lookup.
  * @de_name: Dirent name.
  * @de_name_len: dirent name length.
- * @quick: whether @name is already casefolded.
  *
  * Test whether a case-insensitive directory entry matches the filename
- * being searched.  If quick is set, the @name being looked up is
- * already in the casefolded form.
+ * being searched.
  *
  * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
  * < 0 on error.
  */
-static int ext4_match_ci(const struct inode *parent, const struct qstr *name,
-			 u8 *de_name, size_t de_name_len, bool quick)
+static int ext4_match_ci(const struct inode *parent,
+			 const struct unicode_name *uname,
+			 u8 *de_name, size_t de_name_len)
 {
 	const struct super_block *sb = parent->i_sb;
 	const struct unicode_map *um = sb->s_encoding;
@@ -1357,10 +1356,10 @@ static int ext4_match_ci(const struct inode *parent, const struct qstr *name,
 		entry.len = decrypted_name.len;
 	}
 
-	if (quick)
-		ret = utf8_strncasecmp_folded(um, name, &entry);
+	if (uname->folded_name->name)
+		ret = utf8_strncasecmp_folded(um, uname->folded_name, &entry);
 	else
-		ret = utf8_strncasecmp(um, name, &entry);
+		ret = utf8_strncasecmp(um, uname->usr_name, &entry);
 
 	if (!ret)
 		match = true;
@@ -1370,8 +1369,8 @@ static int ext4_match_ci(const struct inode *parent, const struct qstr *name,
 		 * the names have invalid characters.
 		 */
 		ret = 0;
-		match = ((name->len == entry.len) &&
-			 !memcmp(name->name, entry.name, entry.len));
+		match = ((uname->usr_name->len == entry.len) &&
+			 !memcmp(uname->usr_name->name, entry.name, entry.len));
 	}
 
 out:
@@ -1441,6 +1440,10 @@ static bool ext4_match(struct inode *parent,
 #if IS_ENABLED(CONFIG_UNICODE)
 	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent) &&
 	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
+		struct unicode_name u = {
+			.folded_name = &fname->cf_name,
+			.usr_name = fname->usr_fname
+		};
 		int ret;
 
 		if (fname->cf_name.name) {
@@ -1452,14 +1455,9 @@ static bool ext4_match(struct inode *parent,
 					return false;
 				}
 			}
-
-			ret = ext4_match_ci(parent, &fname->cf_name, de->name,
-					    de->name_len, true);
-		} else {
-			ret = ext4_match_ci(parent, fname->usr_fname,
-					    de->name, de->name_len, false);
 		}
 
+		ret = ext4_match_ci(parent, &u, de->name, de->name_len);
 		if (ret < 0) {
 			/*
 			 * Treat comparison errors as not a match.  The
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b0..3f76a18a5f40 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3358,6 +3358,11 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 
 extern int generic_check_addressable(unsigned, u64);
 
+struct unicode_name {
+	const struct qstr *folded_name;
+	const struct qstr *usr_name;
+};
+
 extern void generic_set_encrypted_ci_d_ops(struct dentry *dentry);
 
 #ifdef CONFIG_MIGRATION
-- 
2.36.1

