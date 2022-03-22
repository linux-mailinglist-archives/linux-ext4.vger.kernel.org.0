Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95344E3716
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Mar 2022 04:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbiCVDB7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Mar 2022 23:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiCVDBw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Mar 2022 23:01:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AF62042BE
        for <linux-ext4@vger.kernel.org>; Mon, 21 Mar 2022 20:00:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 5A31F1F41054
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647918024;
        bh=Ne9gHo1W22hoN0fs0VlYikMKOzIWbakWkN+3Rnc2qZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ajAmRddIRpaT3hRRyoN/i4QKBs2ffsWPtOmaFq5o441NXaYeRZWstfV22b8lXqZhP
         HyJRV3f2AuMoHCYbBQzOHIWq9JefW2d5NbVDdZh0swSb6H79I70SBY0oclJUXjfhWy
         +IDf2KDgTzDgq0Mz0gMVjg3rlId8li+wPmcdg6oD+M6lKds1y7jjEbaK59PwD60p0d
         Z9kNun68XzRquy9b7EMdUuuHv8WCmU7nLBldSU29cKyaG/+kKxFWGlBTkkZIgdUxCF
         DpiBQWJ3yjfClipogNkTGU9NuWAesphaW5dz3jsAKg5r92CAzQEpfCwT962mG0H2Xb
         cBgzybZ0/oAAA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     ebiggers@kernel.org, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 3/5] ext4: Implement ci comparison using fscrypt_name
Date:   Mon, 21 Mar 2022 23:00:02 -0400
Message-Id: <20220322030004.148560-4-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322030004.148560-1-krisman@collabora.com>
References: <20220322030004.148560-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

By using fscrypt_name here, we can hide most of the caching casefold
logic from ext4.  The condition in ext4_match is now quite redundant,
but this is addressed in the next patch.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/ext4/namei.c         | 26 ++++++++++++--------------
 include/linux/fscrypt.h |  4 ++++
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 8976e5a28c73..71b4b05fae89 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1321,10 +1321,9 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
 /**
  * ext4_ci_compare() - Match (case-insensitive) a name with a dirent.
  * @parent: Inode of the parent of the dentry.
- * @name: name under lookup.
+ * @fname: name under lookup.
  * @de_name: Dirent name.
  * @de_name_len: dirent name length.
- * @quick: whether @name is already casefolded.
  *
  * Test whether a case-insensitive directory entry matches the filename
  * being searched.  If quick is set, the @name being looked up is
@@ -1333,8 +1332,9 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
  * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
  * < 0 on error.
  */
-static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
-			   u8 *de_name, size_t de_name_len, bool quick)
+static int ext4_ci_compare(const struct inode *parent,
+			   const struct fscrypt_name *fname,
+			   u8 *de_name, size_t de_name_len)
 {
 	const struct super_block *sb = parent->i_sb;
 	const struct unicode_map *um = sb->s_encoding;
@@ -1357,10 +1357,10 @@ static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 		entry.len = decrypted_name.len;
 	}
 
-	if (quick)
-		ret = utf8_strncasecmp_folded(um, name, &entry);
+	if (fname->cf_name.name)
+		ret = utf8_strncasecmp_folded(um, &fname->cf_name, &entry);
 	else
-		ret = utf8_strncasecmp(um, name, &entry);
+		ret = utf8_strncasecmp(um, fname->usr_fname, &entry);
 
 	if (!ret)
 		match = true;
@@ -1370,8 +1370,8 @@ static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 		 * the names have invalid characters.
 		 */
 		ret = 0;
-		match = ((name->len == entry.len) &&
-			 !memcmp(name->name, entry.name, entry.len));
+		match = ((fname->usr_fname->len == entry.len) &&
+			 !memcmp(fname->usr_fname->name, entry.name, entry.len));
 	}
 
 out:
@@ -1440,6 +1440,8 @@ static bool ext4_match(struct inode *parent,
 #endif
 
 #if IS_ENABLED(CONFIG_UNICODE)
+	f.cf_name = fname->cf_name;
+
 	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent) &&
 	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
 		if (fname->cf_name.name) {
@@ -1451,13 +1453,9 @@ static bool ext4_match(struct inode *parent,
 					return false;
 				}
 			}
-			ret = ext4_ci_compare(parent, &fname->cf_name, de->name,
-					      de->name_len, true);
-		} else {
-			ret = ext4_ci_compare(parent, fname->usr_fname,
-					      de->name, de->name_len, false);
 		}
 
+		ret = ext4_ci_compare(parent, &f, de->name, de->name_len);
 		if (ret < 0) {
 			/*
 			 * Treat comparison errors as not a match.  The
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 91ea9477e9bd..5dc4b3c805e4 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -36,6 +36,10 @@ struct fscrypt_name {
 	u32 minor_hash;
 	struct fscrypt_str crypto_buf;
 	bool is_nokey_name;
+
+#ifdef CONFIG_UNICODE
+	struct qstr cf_name;
+#endif
 };
 
 #define FSTR_INIT(n, l)		{ .name = n, .len = l }
-- 
2.35.1

