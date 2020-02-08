Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDD0156254
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Feb 2020 02:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgBHBgC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Feb 2020 20:36:02 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41486 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbgBHBgC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Feb 2020 20:36:02 -0500
Received: by mail-pf1-f201.google.com with SMTP id b62so818244pfb.8
        for <linux-ext4@vger.kernel.org>; Fri, 07 Feb 2020 17:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lQld5kNve/mYGx33ywgb3C2T81loeCfqKmMUxoorgwo=;
        b=tHAHsO84KZodW1A5q0UcxWbVd34YpN8bKrI45/UzTyYqtOtMHxtv9z1eu2YWmF3rp8
         pto73M5v2Zi1uc8Gh+/xbMcBwhSTjTm8IvlR413WLCCivWmR4vzwovxq+mf62QH7nkDU
         L+sBiYtHaxliorz2p0bcAhGmb+0qSNw2i+sSoyisJuR7x4NDMDUxs2lKvSsnNDXOv2OB
         pvlmy1N5G5zntq59sgU//zZcJbkE56oM4NZDlKr/fkGPPx2IH6izyOp1oeN1wgvzST28
         GFooSK5uattgEpIcNWFN1UdaaBMabjTSJ18At+opMzvVwQ2y0sxHoesTw8521mkBX/MJ
         MF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lQld5kNve/mYGx33ywgb3C2T81loeCfqKmMUxoorgwo=;
        b=fpelZLWxGoUWL+JlvmgqyVdKfs7HI47PJT/kKGUaRCqG2t3DU4hOfDVEoZ+nZnhXSC
         xIUQDAVl4bextOI8k5TurYdCa2fXTyEwgHxigEOeUL5BQk7Jxmds/XtZTWW8sw1eeUSj
         kIFr3RWB8QlO17GgADI873L417gSxNPt770pbeE5pQe9NHMP9J7kNInQvtl40Wkwz2dK
         5Hi3wYDRD5gg7NwZgWMQ9cfHYPWxoE7gmxV5cCzsr+qQTaPuBodKmaTgBcL8oHqBArP5
         Hr/ZdrntZuVrd+t04/B3UXNR3FjREherim8Z0NI5PunJhgSvtQ/uI9gccOHYrC1CH1LX
         r/AQ==
X-Gm-Message-State: APjAAAVE0o5BHnhGl4milFvcHZ5te2JKpMZ6Ht/agYRsAkC1RrrHB/A4
        OqJ+kKvFrvsOQ750/V9Z5NHjffhls78=
X-Google-Smtp-Source: APXvYqxnNQ327ovtQHLo13uDQ5tgGKOObkOGRtYqXrH4MruUSC0Npomkwh/Lx38xaSz0tJRsjDFKBHOo3Nk=
X-Received: by 2002:a63:e30e:: with SMTP id f14mr2179384pgh.260.1581125761051;
 Fri, 07 Feb 2020 17:36:01 -0800 (PST)
Date:   Fri,  7 Feb 2020 17:35:46 -0800
In-Reply-To: <20200208013552.241832-1-drosen@google.com>
Message-Id: <20200208013552.241832-3-drosen@google.com>
Mime-Version: 1.0
References: <20200208013552.241832-1-drosen@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v7 2/8] fs: Add standard casefolding support
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This adds general supporting functions for filesystems that use
utf8 casefolding. It provides standard dentry_operations and adds the
necessary structures in struct super_block to allow this standardization.

Ext4 and F2fs are switch to these implementations.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/libfs.c         | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h | 22 +++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index c686bd9caac67..433c283df3099 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -20,6 +20,9 @@
 #include <linux/fs_context.h>
 #include <linux/pseudo_fs.h>
 #include <linux/fsnotify.h>
+#include <linux/unicode.h>
+#include <linux/fscrypt.h>
+#include <linux/stringhash.h>
 
 #include <linux/uaccess.h>
 
@@ -1361,3 +1364,77 @@ bool is_empty_dir_inode(struct inode *inode)
 	return (inode->i_fop == &empty_dir_operations) &&
 		(inode->i_op == &empty_dir_inode_operations);
 }
+
+#ifdef CONFIG_UNICODE
+bool needs_casefold(const struct inode *dir)
+{
+	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding &&
+			(!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir));
+}
+EXPORT_SYMBOL(needs_casefold);
+
+int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
+			  const char *str, const struct qstr *name)
+{
+	const struct dentry *parent = READ_ONCE(dentry->d_parent);
+	const struct inode *inode = READ_ONCE(parent->d_inode);
+	const struct super_block *sb = dentry->d_sb;
+	const struct unicode_map *um = sb->s_encoding;
+	struct qstr entry = QSTR_INIT(str, len);
+	int ret;
+
+	if (!inode || !needs_casefold(inode))
+		goto fallback;
+
+	ret = utf8_strncasecmp(um, name, &entry);
+	if (ret >= 0)
+		return ret;
+
+	if (sb_has_enc_strict_mode(sb))
+		return -EINVAL;
+fallback:
+	if (len != name->len)
+		return 1;
+	return !!memcmp(str, name->name, len);
+}
+EXPORT_SYMBOL(generic_ci_d_compare);
+
+struct hash_ctx {
+	struct utf8_itr_context ctx;
+	unsigned long hash;
+};
+
+static int do_generic_ci_hash(struct utf8_itr_context *ctx, int byte, int pos)
+{
+	struct hash_ctx *hctx = container_of(ctx, struct hash_ctx, ctx);
+
+	hctx->hash = partial_name_hash((unsigned char)byte, hctx->hash);
+	return 0;
+}
+
+int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
+{
+	const struct inode *inode = READ_ONCE(dentry->d_inode);
+	struct super_block *sb = dentry->d_sb;
+	const struct unicode_map *um = sb->s_encoding;
+	int ret = 0;
+	struct hash_ctx hctx;
+
+	if (!inode || !needs_casefold(inode))
+		return 0;
+
+	hctx.hash = init_name_hash(dentry);
+	hctx.ctx.actor = do_generic_ci_hash;
+	ret = utf8_casefold_iter(um, str, &hctx.ctx);
+	if (ret < 0)
+		goto err;
+	str->hash = end_name_hash(hctx.hash);
+
+	return 0;
+err:
+	if (sb_has_enc_strict_mode(sb))
+		ret = -EINVAL;
+	return ret;
+}
+EXPORT_SYMBOL(generic_ci_d_hash);
+#endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6eae91c0668f9..a260afbc06d22 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1382,6 +1382,12 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_ACTIVE	(1<<30)
 #define SB_NOUSER	(1<<31)
 
+/* These flags relate to encoding and casefolding */
+#define SB_ENC_STRICT_MODE_FL	(1 << 0)
+
+#define sb_has_enc_strict_mode(sb) \
+	(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
+
 /*
  *	Umount options
  */
@@ -1449,6 +1455,10 @@ struct super_block {
 #endif
 #ifdef CONFIG_FS_VERITY
 	const struct fsverity_operations *s_vop;
+#endif
+#ifdef CONFIG_UNICODE
+	struct unicode_map *s_encoding;
+	__u16 s_encoding_flags;
 #endif
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
 	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
@@ -3361,6 +3371,18 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 
 extern int generic_check_addressable(unsigned, u64);
 
+#ifdef CONFIG_UNICODE
+extern int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
+extern int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
+				const char *str, const struct qstr *name);
+extern bool needs_casefold(const struct inode *dir);
+#else
+static inline bool needs_casefold(const struct inode *dir)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_MIGRATION
 extern int buffer_migrate_page(struct address_space *,
 				struct page *, struct page *,
-- 
2.25.0.341.g760bfbb309-goog

