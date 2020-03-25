Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4207193279
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Mar 2020 22:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgCYVSf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 17:18:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39570 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVSf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 17:18:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D03F528666B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH e2fsprogs 04/11] ext2fs: Implement faster CI comparison of strings
Date:   Wed, 25 Mar 2020 17:18:04 -0400
Message-Id: <20200325211812.2971787-5-krisman@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200325211812.2971787-1-krisman@collabora.com>
References: <20200325211812.2971787-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Instead of calling casefold two times and memcmp the result, which
require allocating a temporary buffer for the casefolded version, add a
strcasecmp-like method to perform the comparison of each code-point
during the casefold itself.

This method is exposed because it needs to be used directly by fsck.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 lib/ext2fs/ext2fs.h   |  4 ++++
 lib/ext2fs/ext2fsP.h  |  4 ++++
 lib/ext2fs/nls_utf8.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index bf54130f4edb..c5815c37bbb6 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1613,6 +1613,10 @@ extern errcode_t ext2fs_new_dir_inline_data(ext2_filsys fs, ext2_ino_t dir_ino,
 extern const struct ext2fs_nls_table *ext2fs_load_nls_table(int encoding);
 extern int ext2fs_check_encoded_name(const struct ext2fs_nls_table *table,
 				     char *s, size_t len, char **pos);
+extern int ext2fs_casefold_cmp(const struct ext2fs_nls_table *table,
+			       const unsigned char *str1, size_t len1,
+			       const unsigned char *str2, size_t len2);
+
 
 /* mkdir.c */
 extern errcode_t ext2fs_mkdir(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t inum,
diff --git a/lib/ext2fs/ext2fsP.h b/lib/ext2fs/ext2fsP.h
index 30564ded1e2b..99239be007f2 100644
--- a/lib/ext2fs/ext2fsP.h
+++ b/lib/ext2fs/ext2fsP.h
@@ -106,6 +106,10 @@ struct ext2fs_nls_ops {
 			unsigned char *dest, size_t dlen);
 	int (*validate)(const struct ext2fs_nls_table *table,
 			char *s, size_t len, char **pos);
+	int (*casefold_cmp)(const struct ext2fs_nls_table *table,
+			    const unsigned char *str1, size_t len1,
+			    const unsigned char *str2, size_t len2);
+
 };
 
 /* Function prototypes */
diff --git a/lib/ext2fs/nls_utf8.c b/lib/ext2fs/nls_utf8.c
index f59484142e19..f85b8e77e47b 100644
--- a/lib/ext2fs/nls_utf8.c
+++ b/lib/ext2fs/nls_utf8.c
@@ -949,9 +949,36 @@ static int utf8_validate(const struct ext2fs_nls_table *table,
 	return 0;
 }
 
+static int utf8_casefold_cmp(const struct ext2fs_nls_table *table,
+			     const unsigned char *str1, size_t len1,
+			     const unsigned char *str2, size_t len2)
+{
+	const struct utf8data *data = utf8nfdicf(table->version);
+	int c1, c2;
+	struct utf8cursor cur1, cur2;
+
+	if (utf8ncursor(&cur1, data, (const char *) str1, len1) < 0)
+		return -1;
+	if (utf8ncursor(&cur2, data, (const char *) str2, len2) < 0)
+		return -1;
+
+	do {
+		c1 = utf8byte(&cur1);
+		c2 = utf8byte(&cur2);
+
+		if (c1 < 0 || c2 < 0)
+			return -1;
+		if (c1 != c2)
+			return c1 - c2;
+	} while (c1);
+
+	return 0;
+}
+
 static const struct ext2fs_nls_ops utf8_ops = {
 	.casefold = utf8_casefold,
 	.validate = utf8_validate,
+	.casefold_cmp = utf8_casefold_cmp,
 };
 
 static const struct ext2fs_nls_table nls_utf8 = {
@@ -972,3 +999,9 @@ int ext2fs_check_encoded_name(const struct ext2fs_nls_table *table,
 {
 	return table->ops->validate(table, name, len, pos);
 }
+int ext2fs_casefold_cmp(const struct ext2fs_nls_table *table,
+			const unsigned char *str1, size_t len1,
+			const unsigned char *str2, size_t len2)
+{
+	return table->ops->casefold_cmp(table, str1, len1, str2, len2);
+}
-- 
2.25.0

