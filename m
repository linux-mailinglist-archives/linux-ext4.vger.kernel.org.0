Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508242DD654
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 18:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgLQRgg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 12:36:36 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54736 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgLQRgf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 12:36:35 -0500
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:779a:3a80:1322:d34a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 029381F45D0F;
        Thu, 17 Dec 2020 17:35:52 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     drosen@google.com, krisman@collabora.com, ebiggers@kernel.org,
        tytso@mit.edu, Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v3 04/12] ext2fs: Implement faster CI comparison of strings
Date:   Thu, 17 Dec 2020 18:35:36 +0100
Message-Id: <20201217173544.52953-5-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217173544.52953-1-arnaud.ferraris@collabora.com>
References: <20201217173544.52953-1-arnaud.ferraris@collabora.com>
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
Changes in v3:
  - removed extra lines

 lib/ext2fs/ext2fs.h   |  3 +++
 lib/ext2fs/ext2fsP.h  |  3 +++
 lib/ext2fs/nls_utf8.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 4065cb70..a21c43be 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1615,6 +1615,9 @@ extern errcode_t ext2fs_new_dir_inline_data(ext2_filsys fs, ext2_ino_t dir_ino,
 extern const struct ext2fs_nls_table *ext2fs_load_nls_table(int encoding);
 extern int ext2fs_check_encoded_name(const struct ext2fs_nls_table *table,
 				     char *s, size_t len, char **pos);
+extern int ext2fs_casefold_cmp(const struct ext2fs_nls_table *table,
+			       const unsigned char *str1, size_t len1,
+			       const unsigned char *str2, size_t len2);
 
 /* mkdir.c */
 extern errcode_t ext2fs_mkdir(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t inum,
diff --git a/lib/ext2fs/ext2fsP.h b/lib/ext2fs/ext2fsP.h
index 30564ded..a20a0502 100644
--- a/lib/ext2fs/ext2fsP.h
+++ b/lib/ext2fs/ext2fsP.h
@@ -106,6 +106,9 @@ struct ext2fs_nls_ops {
 			unsigned char *dest, size_t dlen);
 	int (*validate)(const struct ext2fs_nls_table *table,
 			char *s, size_t len, char **pos);
+	int (*casefold_cmp)(const struct ext2fs_nls_table *table,
+			    const unsigned char *str1, size_t len1,
+			    const unsigned char *str2, size_t len2);
 };
 
 /* Function prototypes */
diff --git a/lib/ext2fs/nls_utf8.c b/lib/ext2fs/nls_utf8.c
index 7d2cf421..43bab9a3 100644
--- a/lib/ext2fs/nls_utf8.c
+++ b/lib/ext2fs/nls_utf8.c
@@ -941,9 +941,36 @@ static int utf8_validate(const struct ext2fs_nls_table *table,
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
@@ -964,3 +991,10 @@ int ext2fs_check_encoded_name(const struct ext2fs_nls_table *table,
 {
 	return table->ops->validate(table, name, len, pos);
 }
+
+int ext2fs_casefold_cmp(const struct ext2fs_nls_table *table,
+			const unsigned char *str1, size_t len1,
+			const unsigned char *str2, size_t len2)
+{
+	return table->ops->casefold_cmp(table, str1, len1, str2, len2);
+}
-- 
2.29.2

