Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483CF2C6A55
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 18:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbgK0RBi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 12:01:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57098 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731725AbgK0RBi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Nov 2020 12:01:38 -0500
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:5a64:74b8:f3be:d972])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1C7341F464FE;
        Fri, 27 Nov 2020 17:01:37 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v2 03/12] ext2fs: Add method to validate casefolded strings
Date:   Fri, 27 Nov 2020 18:01:07 +0100
Message-Id: <20201127170116.197901-4-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201127170116.197901-1-arnaud.ferraris@collabora.com>
References: <20201127170116.197901-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

This is exported to be used by fsck.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 lib/ext2fs/ext2fs.h   |  2 ++
 lib/ext2fs/ext2fsP.h  |  2 ++
 lib/ext2fs/nls_utf8.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 69c8a3ff..4065cb70 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1613,6 +1613,8 @@ extern errcode_t ext2fs_new_dir_inline_data(ext2_filsys fs, ext2_ino_t dir_ino,
 
 /* nls_utf8.c */
 extern const struct ext2fs_nls_table *ext2fs_load_nls_table(int encoding);
+extern int ext2fs_check_encoded_name(const struct ext2fs_nls_table *table,
+				     char *s, size_t len, char **pos);
 
 /* mkdir.c */
 extern errcode_t ext2fs_mkdir(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t inum,
diff --git a/lib/ext2fs/ext2fsP.h b/lib/ext2fs/ext2fsP.h
index ad8b7d52..30564ded 100644
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
index e4c4e7a3..903c65ba 100644
--- a/lib/ext2fs/nls_utf8.c
+++ b/lib/ext2fs/nls_utf8.c
@@ -920,8 +920,31 @@ invalid_seq:
 	return -EINVAL;
 }
 
+
+static int utf8_validate(const struct ext2fs_nls_table *table,
+			 char *s, size_t len, char **pos)
+{
+	const struct utf8data *data = utf8nfdicf(table->version);
+	utf8leaf_t	*leaf;
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
@@ -936,3 +959,9 @@ const struct ext2fs_nls_table *ext2fs_load_nls_table(int encoding)
 
 	return NULL;
 }
+
+int ext2fs_check_encoded_name(const struct ext2fs_nls_table *table,
+			      char *name, size_t len, char **pos)
+{
+	return table->ops->validate(table, name, len, pos);
+}
-- 
2.28.0

