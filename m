Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3762C6A56
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 18:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbgK0RBj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 12:01:39 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57102 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731882AbgK0RBi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Nov 2020 12:01:38 -0500
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:5a64:74b8:f3be:d972])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 460BC1F464FF;
        Fri, 27 Nov 2020 17:01:37 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v2 04/12] ext2fs: Implement faster CI comparison of strings
Date:   Fri, 27 Nov 2020 18:01:08 +0100
Message-Id: <20201127170116.197901-5-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201127170116.197901-1-arnaud.ferraris@collabora.com>
References: <20201127170116.197901-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Instead of calling casefold two times and memcmp the result, which
require allocating a temporary buffer for the casefolded version, add a
strcasecmp-like method to perform the comparison of each code-point
during the casefold itself.

This method is exposed because it needs to be used directly by fsck.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 lib/ext2fs/ext2fs.h   |  4 ++++
 lib/ext2fs/ext2fsP.h  |  4 ++++
 lib/ext2fs/nls_utf8.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 4065cb70..9e96ca5c 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1615,6 +1615,10 @@ extern errcode_t ext2fs_new_dir_inline_data(ext2_filsys fs, ext2_ino_t dir_ino,
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
index 30564ded..99239be0 100644
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
index 903c65ba..1c444ca2 100644
--- a/lib/ext2fs/nls_utf8.c
+++ b/lib/ext2fs/nls_utf8.c
@@ -942,9 +942,36 @@ static int utf8_validate(const struct ext2fs_nls_table *table,
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
@@ -965,3 +992,9 @@ int ext2fs_check_encoded_name(const struct ext2fs_nls_table *table,
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
2.28.0

