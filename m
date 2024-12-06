Return-Path: <linux-ext4+bounces-5506-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96C99E774A
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 18:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6A91887F36
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 17:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF919204579;
	Fri,  6 Dec 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Wug027aN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C41FFC73;
	Fri,  6 Dec 2024 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506139; cv=none; b=DdcMYNiDEQRjZYe+Mj/M22jFZSAkewhFDkCoSdPxMFxO2ejYGxLEcRKjhmM55y9ZoGNc5WwWCZj2ZMrAOrcOdkbH0yW4f23zZbGGkysrXP1QZPukQ88AZH9SXbHl4NkqFTHtphcDSQmvlUEtVmZru1iruhi+jjpgNtpzVnxuVJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506139; c=relaxed/simple;
	bh=D6bPQcNYukDItmgpy9dzRSBUjrFOdsEYvJIaD7mY9cM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=glxM3OBED8f+6C6bNM4hiq26kiSj+rNNltZ5QqTJTxOCDK6VpMJGTQWVGN7JGE+DU3a3Evx5VzFgWCDlKU8g0G+m1UMSpxX5kaQSecjcZEJ47iJEx9dyYKQDATjvXCzzBgJOPTJRyQ9T3Cqc68CBEhTSTZK90Lrm8ff16nlSINo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Wug027aN; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8oIpgUOrCw7wy276EldFAK/fTJ+Aor2rT3kshxjjKSg=; b=Wug027aNdqcQK1Pp7N1WitByvf
	JnjlqkbZHzpYJxIWpyWVfJtP5kho8c8AghRzg5VgHfVd935TGui7MsjOYdCJlIB2oOsYYELQcDqqh
	OR4eR7ilxn2aLtmsxYX/H1sSOEyYbkGAf6N3BChfvSkKl2tAkvx+RF6wP0ej0QYw6a2EGYNLxYLFY
	8fK4ub4u8i2f2xycTdar4DyDrkva29doRYucClwrX2SrIsmfGIFM/w1rvwxzhUKB0D708JRAdVyl4
	R61iXWyWK64tFUKsECa0/pIQQxWNrODR8N6qaU5n6ah99oRaXOzPIYyH9398fB5QMQYg/rrBxyO0K
	G7YnZ4Ig==;
Received: from 179-125-79-245-dinamico.pombonet.net.br ([179.125.79.245] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tJc8M-00HUmO-6y; Fri, 06 Dec 2024 18:28:54 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 3/5] ext4: introduce wrapper to read data from inode
Date: Fri,  6 Dec 2024 14:28:26 -0300
Message-Id: <20241206172828.3219989-4-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206172828.3219989-1-cascardo@igalia.com>
References: <20241206172828.3219989-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext4_read_inline_data callers will usually follow similar steps, fetching
inode block, parsing xattrs, allocating a buffer, and copying the data. Put
it all under the same wrapper and have most callers use it.

Some callers allocate their own buffers, so allow those to be used.

The exception here is ext4_convert_inline_data.

This avoids OOB when reading inline dir and other potential bugs.

When reading inline directory, if e_value_offs is changed underneath the
filesystem by some change in the block device, it will lead to an
out-of-bounds access that KASAN detects as an UAF.

The wrapper function takes care of checking xattrs are still valid.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/ext4/inline.c | 110 +++++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 51 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index b49cfcadbd36..c3d2fcae6191 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -212,6 +212,51 @@ static int ext4_read_inline_data(struct inode *inode, void *buffer,
 	return cp_len;
 }
 
+static int ext4_read_inline_data_from_inode(struct inode *inode, void **buffer,
+					    size_t *len,
+					    struct ext4_iloc *iloc,
+					    int *has_inline_data)
+{
+	struct ext4_xattr_ibody_find is = {
+		.s = { .not_found = -ENODATA, },
+	};
+	struct ext4_xattr_info i = {
+		.name_index = EXT4_XATTR_INDEX_SYSTEM,
+		.name = EXT4_XATTR_SYSTEM_DATA,
+	};
+	int ret;
+
+	ret = ext4_get_inode_loc(inode, &is.iloc);
+	if (ret)
+		goto out;
+
+	ret = ext4_xattr_ibody_find(inode, &i, &is);
+	if (ret)
+		goto out;
+
+	if (!ext4_has_inline_data(inode)) {
+		if (has_inline_data)
+			*has_inline_data = 0;
+		goto out;
+	}
+
+	if (!*len)
+		*len = ext4_get_inline_size(inode);
+	if (!*buffer) {
+		*buffer = kmalloc(*len, GFP_NOFS);
+		if (!*buffer) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	ret = ext4_read_inline_data(inode, *buffer, *len, &is.iloc);
+
+out:
+	*iloc = is.iloc;
+	return ret;
+}
+
 /*
  * write the buffer to the inline inode.
  * If 'create' is set, we don't need to do the extra copy in the xattr
@@ -492,14 +537,10 @@ static int ext4_read_inline_folio(struct inode *inode, struct folio *folio)
 		goto out;
 	}
 
-	ret = ext4_get_inode_loc(inode, &iloc);
-	if (ret)
-		goto out;
-
 	len = min_t(size_t, ext4_get_inline_size(inode), i_size_read(inode));
 	BUG_ON(len > PAGE_SIZE);
 	kaddr = kmap_local_folio(folio, 0);
-	ret = ext4_read_inline_data(inode, kaddr, len, &iloc);
+	ret = ext4_read_inline_data_from_inode(inode, &kaddr, &len, &iloc, NULL);
 	kaddr = folio_zero_tail(folio, len, kaddr + len);
 	kunmap_local(kaddr);
 	folio_mark_uptodate(folio);
@@ -1333,32 +1374,16 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
 	int pos;
 	struct ext4_dir_entry_2 *de;
 	struct inode *inode = file_inode(dir_file);
-	int ret, inline_size = 0;
+	int ret;
+	size_t inline_size = 0;
 	struct ext4_iloc iloc;
 	void *dir_buf = NULL;
 	struct ext4_dir_entry_2 fake;
 	struct fscrypt_str tmp_str;
 
-	ret = ext4_get_inode_loc(inode, &iloc);
-	if (ret)
-		return ret;
-
 	down_read(&EXT4_I(inode)->xattr_sem);
-	if (!ext4_has_inline_data(inode)) {
-		up_read(&EXT4_I(inode)->xattr_sem);
-		*has_inline_data = 0;
-		goto out;
-	}
-
-	inline_size = ext4_get_inline_size(inode);
-	dir_buf = kmalloc(inline_size, GFP_NOFS);
-	if (!dir_buf) {
-		ret = -ENOMEM;
-		up_read(&EXT4_I(inode)->xattr_sem);
-		goto out;
-	}
-
-	ret = ext4_read_inline_data(inode, dir_buf, inline_size, &iloc);
+	ret = ext4_read_inline_data_from_inode(inode, &dir_buf, &inline_size,
+					       &iloc, has_inline_data);
 	up_read(&EXT4_I(inode)->xattr_sem);
 	if (ret < 0)
 		goto out;
@@ -1452,32 +1477,16 @@ int ext4_read_inline_dir(struct file *file,
 	struct ext4_dir_entry_2 *de;
 	struct super_block *sb;
 	struct inode *inode = file_inode(file);
-	int ret, inline_size = 0;
+	int ret;
+	size_t inline_size = 0;
 	struct ext4_iloc iloc;
 	void *dir_buf = NULL;
 	int dotdot_offset, dotdot_size, extra_offset, extra_size;
 	struct dir_private_info *info = file->private_data;
 
-	ret = ext4_get_inode_loc(inode, &iloc);
-	if (ret)
-		return ret;
-
 	down_read(&EXT4_I(inode)->xattr_sem);
-	if (!ext4_has_inline_data(inode)) {
-		up_read(&EXT4_I(inode)->xattr_sem);
-		*has_inline_data = 0;
-		goto out;
-	}
-
-	inline_size = ext4_get_inline_size(inode);
-	dir_buf = kmalloc(inline_size, GFP_NOFS);
-	if (!dir_buf) {
-		ret = -ENOMEM;
-		up_read(&EXT4_I(inode)->xattr_sem);
-		goto out;
-	}
-
-	ret = ext4_read_inline_data(inode, dir_buf, inline_size, &iloc);
+	ret = ext4_read_inline_data_from_inode(inode, &dir_buf, &inline_size,
+					       &iloc, has_inline_data);
 	up_read(&EXT4_I(inode)->xattr_sem);
 	if (ret < 0)
 		goto out;
@@ -1577,26 +1586,25 @@ int ext4_read_inline_dir(struct file *file,
 void *ext4_read_inline_link(struct inode *inode)
 {
 	struct ext4_iloc iloc;
-	int ret, inline_size;
+	int ret;
+	size_t inline_size;
 	void *link;
 
-	ret = ext4_get_inode_loc(inode, &iloc);
-	if (ret)
-		return ERR_PTR(ret);
-
 	ret = -ENOMEM;
 	inline_size = ext4_get_inline_size(inode);
 	link = kmalloc(inline_size + 1, GFP_NOFS);
 	if (!link)
 		goto out;
 
-	ret = ext4_read_inline_data(inode, link, inline_size, &iloc);
+	down_read(&EXT4_I(inode)->xattr_sem);
+	ret = ext4_read_inline_data_from_inode(inode, &link, &inline_size, &iloc, NULL);
 	if (ret < 0) {
 		kfree(link);
 		goto out;
 	}
 	nd_terminate_link(link, inode->i_size, ret);
 out:
+	up_read(&EXT4_I(inode)->xattr_sem);
 	if (ret < 0)
 		link = ERR_PTR(ret);
 	brelse(iloc.bh);
-- 
2.34.1


