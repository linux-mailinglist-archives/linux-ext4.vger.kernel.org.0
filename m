Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD3051539D
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Apr 2022 20:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379875AbiD2SbK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Apr 2022 14:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379997AbiD2SbE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Apr 2022 14:31:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED79288782
        for <linux-ext4@vger.kernel.org>; Fri, 29 Apr 2022 11:27:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 93F991F46915
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651256864;
        bh=PNCfTULIr3nrKnUhteldBCGbb9yM9LedJwSaGK5KYUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2VUxIzSMsVKyczIzkUF0vJjJdTgqq35QD30rygCksCp/WXOpfSVyQQPRfEhZJD01
         FO7+++wKTKKdE2uq7g8SNg9RC0qyU/Bhs9pe06Uii4RVCEebsMuHXb+oekfHqOXl0U
         zexPSyn/DUDQH2NuvH1FOm/CsiNfJBIzPs8yr7fxIwC7OjQROTeUiJRKxZrruhdKhY
         RBSA6cKdfWSHOVQqGTY4VHrxd5xYQKOQ9hglS7I4jBfJBG/YIl1i3eS4QbnKZLR2V9
         tvvwBxqk0VuGBrXN1bfsDQMceOkhF69IoobqToxvDvvAdN353Mcp6TcaTueeu2m1BX
         GY9ejRCMXBh/A==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 3/7] ext4: Implement ci comparison using unicode_name
Date:   Fri, 29 Apr 2022 14:27:24 -0400
Message-Id: <20220429182728.14008-4-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429182728.14008-1-krisman@collabora.com>
References: <20220429182728.14008-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
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
index c1a8a09369d1..5102652b5af4 100644
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
@@ -1427,6 +1426,7 @@ static bool ext4_match(struct inode *parent,
 			      const struct ext4_filename *fname,
 			      struct ext4_dir_entry_2 *de)
 {
+	struct unicode_name u;
 	struct fscrypt_name f;
 	int ret;
 
@@ -1451,14 +1451,12 @@ static bool ext4_match(struct inode *parent,
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
 
+		u.folded_name = &fname->cf_name;
+		u.usr_name = fname->usr_fname;
+
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
2.35.1

