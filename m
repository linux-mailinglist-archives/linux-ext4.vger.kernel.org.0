Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D38193278
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Mar 2020 22:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCYVSc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 17:18:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39566 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVSb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 17:18:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 42AEC28666B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH e2fsprogs 03/11] ext2fs: Add method to validate casefolded strings
Date:   Wed, 25 Mar 2020 17:18:03 -0400
Message-Id: <20200325211812.2971787-4-krisman@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200325211812.2971787-1-krisman@collabora.com>
References: <20200325211812.2971787-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is exported to be used by fsck.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 lib/ext2fs/ext2fs.h   |  2 ++
 lib/ext2fs/ext2fsP.h  |  2 ++
 lib/ext2fs/nls_utf8.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 93ecf29c568d..bf54130f4edb 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1611,6 +1611,8 @@ extern errcode_t ext2fs_new_dir_inline_data(ext2_filsys fs, ext2_ino_t dir_ino,
 
 /* nls_utf8.c */
 extern const struct ext2fs_nls_table *ext2fs_load_nls_table(int encoding);
+extern int ext2fs_check_encoded_name(const struct ext2fs_nls_table *table,
+				     char *s, size_t len, char **pos);
 
 /* mkdir.c */
 extern errcode_t ext2fs_mkdir(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t inum,
diff --git a/lib/ext2fs/ext2fsP.h b/lib/ext2fs/ext2fsP.h
index ad8b7d52d77c..30564ded1e2b 100644
--- a/lib/ext2fs/ext2fsP.h
+++ b/lib/ext2fs/ext2fsP.h
@@ -104,6 +104,8 @@ struct ext2fs_nls_ops {
 	int (*casefold)(const struct ext2fs_nls_table *charset,
 			const unsigned char *str, size_t len,
 			unsigned char *dest, size_t dlen);
+	int (*validate)(const struct ext2fs_nls_table *table,
+			char *s, size_t len, char **pos);
 };
 
 /* Function prototypes */
diff --git a/lib/ext2fs/nls_utf8.c b/lib/ext2fs/nls_utf8.c
index e4c4e7a30990..f59484142e19 100644
--- a/lib/ext2fs/nls_utf8.c
+++ b/lib/ext2fs/nls_utf8.c
@@ -920,8 +920,38 @@ invalid_seq:
 	return -EINVAL;
 }
 
+
+static int utf8_validate(const struct ext2fs_nls_table *table,
+			 char *s, size_t len, char **pos)
+{
+	const struct utf8data *data = utf8nfdicf(table->version);
+	utf8leaf_t	*leaf;
+	size_t		ret = 0;
+	unsigned char	hangul[UTF8HANGULLEAF];
+
+	if (!data)
+		return -1;
+	while (len && *s) {
+		leaf = utf8nlookup(data, hangul, s, len);
+		if (!leaf) {
+			*pos = s;
+			return 1;
+		}
+		if (utf8agetab[LEAF_GEN(leaf)] > data->maxage)
+			ret += utf8clen(s);
+		else if (LEAF_CCC(leaf) == DECOMPOSE)
+			ret += strlen(LEAF_STR(leaf));
+		else
+			ret += utf8clen(s);
+		len -= utf8clen(s);
+		s += utf8clen(s);
+	}
+	return 0;
+}
+
 static const struct ext2fs_nls_ops utf8_ops = {
 	.casefold = utf8_casefold,
+	.validate = utf8_validate,
 };
 
 static const struct ext2fs_nls_table nls_utf8 = {
@@ -936,3 +966,9 @@ const struct ext2fs_nls_table *ext2fs_load_nls_table(int encoding)
 
 	return NULL;
 }
+
+int ext2fs_check_encoded_name(const struct ext2fs_nls_table *table,
+			      char *name, size_t len, char **pos)
+{
+	return table->ops->validate(table, name, len, pos);
+}
-- 
2.25.0

