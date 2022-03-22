Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6F34E3720
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Mar 2022 04:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiCVDBs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Mar 2022 23:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiCVDBo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Mar 2022 23:01:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347361FE564
        for <linux-ext4@vger.kernel.org>; Mon, 21 Mar 2022 20:00:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D50E21F41640
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647918017;
        bh=9Gvy4Q6vMFRJVdm/DEWf0uzjdE0FiEbo+TJFE9FDuYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VMV50pMKCOUEBV9F8w1natXIZcuNjlbcR3UM3GnBQmr+rctPJVftlmJ61y+Q/9o36
         qxDrzhwuGOvsOrwhXazSgmiotx6ItY7SwDOY+NrW1Lc+UbP6kiauvClDcAHSxKpkqC
         v03jRcqQe3/EU3mIzXaly2aiG7iyuPvwWH3p0v+yo6LhGC0Hx2MlMKtVpsRfTrr8ol
         Tj4IYT3NBE4diGFtWVxkQDNingJNyI9jq/lqMpIRcVB+4GSQ0njPj/XSWwEmHW7k4q
         B8tdhIsi74ylyJjx7kWqGZsj2po1CkrPtC/SWpc1ADWakFLm9WNX8aqyYAF26Z9oGm
         jxE7QVicwDqQA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     ebiggers@kernel.org, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 1/5] ext4: Match the f2fs ci_compare implementation
Date:   Mon, 21 Mar 2022 23:00:00 -0400
Message-Id: <20220322030004.148560-2-krisman@collabora.com>
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

ext4_ci_compare originally follows utf8_*_strcmp, which means return
zero on match.  This means that every usage of that in ext4 negates
the return.

Turn it into a predicate function, let it follow the kernel convention
and return true on match, which means it's now the same as its f2fs
counterpart and can be extracted into generic code.

This change also makes it more obvious that we are ignoring error
handling in ext4_match, which can occur since casefolding support (bad
utf8 name due to disk corruption on strict mode causes -EINVAL) and
casefold+encryption (-ENOMEM).  For now, keep the behavior.  It is
handled by the following patches.

While we are there, change the comment to the kernel-doc style.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/ext4/namei.c | 62 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 8cf0a924a49b..24ea3bb446d0 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1318,13 +1318,20 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
 }
 
 #if IS_ENABLED(CONFIG_UNICODE)
-/*
+/**
+ * ext4_ci_compare() - Match (case-insensitive) a name with a dirent.
+ * @parent: Inode of the parent of the dentry.
+ * @name: name under lookup.
+ * @de_name: Dirent name.
+ * @de_name_len: dirent name length.
+ * @quick: whether @name is already casefolded.
+ *
  * Test whether a case-insensitive directory entry matches the filename
- * being searched for.  If quick is set, assume the name being looked up
- * is already in the casefolded form.
+ * being searched.  If quick is set, the @name being looked up is
+ * already in the casefolded form.
  *
- * Returns: 0 if the directory entry matches, more than 0 if it
- * doesn't match or less than zero on error.
+ * Return: > 0 if the directory entry matches, 0 if it doesn't match, or
+ * < 0 on error.
  */
 static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 			   u8 *de_name, size_t de_name_len, bool quick)
@@ -1333,7 +1340,7 @@ static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 	const struct unicode_map *um = sb->s_encoding;
 	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
 	struct qstr entry = QSTR_INIT(de_name, de_name_len);
-	int ret;
+	int ret, match = false;
 
 	if (IS_ENCRYPTED(parent)) {
 		const struct fscrypt_str encrypted_name =
@@ -1354,20 +1361,22 @@ static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 		ret = utf8_strncasecmp_folded(um, name, &entry);
 	else
 		ret = utf8_strncasecmp(um, name, &entry);
-	if (ret < 0) {
-		/* Handle invalid character sequence as either an error
-		 * or as an opaque byte sequence.
+
+	if (!ret)
+		match = true;
+	else if (ret < 0 && !sb_has_strict_encoding(sb)) {
+		/*
+		 * In non-strict mode, fallback to a byte comparison if
+		 * the names have invalid characters.
 		 */
-		if (sb_has_strict_encoding(sb))
-			ret = -EINVAL;
-		else if (name->len != entry.len)
-			ret = 1;
-		else
-			ret = !!memcmp(name->name, entry.name, entry.len);
+		ret = 0;
+		match = ((name->len == entry.len) &&
+			 !memcmp(name->name, entry.name, entry.len));
 	}
+
 out:
 	kfree(decrypted_name.name);
-	return ret;
+	return (ret >= 0) ? match : ret;
 }
 
 int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
@@ -1418,6 +1427,7 @@ static bool ext4_match(struct inode *parent,
 			      struct ext4_dir_entry_2 *de)
 {
 	struct fscrypt_name f;
+	int ret;
 
 	if (!de->inode)
 		return false;
@@ -1442,11 +1452,23 @@ static bool ext4_match(struct inode *parent,
 					return false;
 				}
 			}
-			return !ext4_ci_compare(parent, &cf, de->name,
-							de->name_len, true);
+			ret = ext4_ci_compare(parent, &cf, de->name,
+					      de->name_len, true);
+		} else {
+			ret = ext4_ci_compare(parent, fname->usr_fname,
+					      de->name, de->name_len, false);
 		}
-		return !ext4_ci_compare(parent, fname->usr_fname, de->name,
-						de->name_len, false);
+
+		if (ret < 0) {
+			/*
+			 * Treat comparison errors as not a match.  The
+			 * only case where it happens is on a disk
+			 * corruption or ENOMEM.
+			 */
+			return false;
+		}
+		return ret;
+
 	}
 #endif
 
-- 
2.35.1

