Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E9619BC1
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2019 12:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfEJKh4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 May 2019 06:37:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43361 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfEJKh4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 May 2019 06:37:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so2650563plp.10
        for <linux-ext4@vger.kernel.org>; Fri, 10 May 2019 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Io6PtKAjb8ZKOByBnRFOujbHX2qBuDTazQ9tzdAaKfM=;
        b=m/qIZdT/n7hMyk378YTEnsOCl0zCtPs/ySqooWtiqPFC0hXPws0iVUdnZA6v1rK5Xd
         fQ+4rXo7280N/HJcPI9oVc38imgMpIHXF12fdFoHiOZl9v6lVuA30jtWs1m2hNykm661
         b5cn9u+W/e5KPWDiDVwRFaWc6Nbekb6KO1jwkO7cCgE4lZx37UuzTlM/kS81aWHelVIw
         hIf0u+Kl5lv4VExdFdqM4C1rHfnxeJKVf3aLbYI6msMEYK/xLkPYYHJCr0DFKvFTUFgq
         uBZFGbZ4ohoY6fBclreB4ZjVjC1hLovG9ezzFDdVWbZZZZSU8XQRbKvcoa5kzraengLo
         0NDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Io6PtKAjb8ZKOByBnRFOujbHX2qBuDTazQ9tzdAaKfM=;
        b=hjc7PqbsSXl3IM/IeTKlsyK2tQ9Kysn1OFa0vQOtTHA7JrN2HsYuMYZvQSHP+COscr
         B2myOb4ZYyYHYjrhy5oNxcGAUDuiLA3mDsnQaLysFWF0UkONLF9pBAPuxi2bIZCQexFf
         C+iOIB025snoGsS8G1NQWStD0dG++Ld4dg1fMrIAmkf06b1P0l9ENnu0CGLEtFrbbLse
         nlU3mYRyAB/9M23jScx5He022WF0NhdXaEK/ugyA3f+P21+rgJTEkekTF041eLAGquKZ
         kySc2xR38iXrupeZHBkHTjnTSy0ZcJxwGE2wmje6Z/8PFAdFCcyzfddw7pk/koeWkVyw
         assQ==
X-Gm-Message-State: APjAAAUPc+yujegrXSr6kXNN7mLzmj3PxYR8tV9PjewRRRhY3p3h3ZJQ
        T2z5ds9+gHUEnSNFBMpBuNaVWLi0
X-Google-Smtp-Source: APXvYqy7bCqf3ST+hxtzzaIbnjW/ttwyfBdsYdvmz5gzQ9N8jiwaGCEUCHTHVBHQDE+ayvHUe7t2NA==
X-Received: by 2002:a17:902:8f8d:: with SMTP id z13mr5726997plo.166.1557484676020;
        Fri, 10 May 2019 03:37:56 -0700 (PDT)
Received: from izt4n3nohp3b5a1z8j8uuaz.localdomain ([149.129.49.136])
        by smtp.gmail.com with ESMTPSA id o73sm12396964pfi.137.2019.05.10.03.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 03:37:55 -0700 (PDT)
From:   Chengguang Xu <cgxu519@gmail.com>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@gmail.com>
Subject: [PATCH 1/2] ext2: introduce helper for xattr header validation
Date:   Fri, 10 May 2019 18:37:45 +0800
Message-Id: <1557484666-23562-1-git-send-email-cgxu519@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Introduce helper function ext2_xattr_header_valid()
for xattr header validation and clean up the header
check ralated code.

Signed-off-by: Chengguang Xu <cgxu519@gmail.com>
---
 fs/ext2/xattr.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 1e33e0ac8cf1..6e0b2b0f333f 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -134,6 +134,16 @@ ext2_xattr_handler(int name_index)
 	return handler;
 }
 
+static bool
+ext2_xattr_header_valid(struct buffer_head *bh)
+{
+	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
+	    HDR(bh)->h_blocks != cpu_to_le32(1))
+		return false;
+
+	return true;
+}
+
 /*
  * ext2_xattr_get()
  *
@@ -176,9 +186,9 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
 	ea_bdebug(bh, "b_count=%d, refcount=%d",
 		atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
 	end = bh->b_data + bh->b_size;
-	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
-	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
-bad_block:	ext2_error(inode->i_sb, "ext2_xattr_get",
+	if (!ext2_xattr_header_valid(bh)) {
+bad_block:
+		ext2_error(inode->i_sb, "ext2_xattr_get",
 			"inode %ld: bad block %d", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		error = -EIO;
@@ -266,9 +276,9 @@ ext2_xattr_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 	ea_bdebug(bh, "b_count=%d, refcount=%d",
 		atomic_read(&(bh->b_count)), le32_to_cpu(HDR(bh)->h_refcount));
 	end = bh->b_data + bh->b_size;
-	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
-	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
-bad_block:	ext2_error(inode->i_sb, "ext2_xattr_list",
+	if (!ext2_xattr_header_valid(bh)) {
+bad_block:
+		ext2_error(inode->i_sb, "ext2_xattr_list",
 			"inode %ld: bad block %d", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		error = -EIO;
@@ -406,9 +416,9 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 			le32_to_cpu(HDR(bh)->h_refcount));
 		header = HDR(bh);
 		end = bh->b_data + bh->b_size;
-		if (header->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
-		    header->h_blocks != cpu_to_le32(1)) {
-bad_block:		ext2_error(sb, "ext2_xattr_set",
+		if (!ext2_xattr_header_valid(bh)) {
+bad_block:
+			ext2_error(sb, "ext2_xattr_set",
 				"inode %ld: bad block %d", inode->i_ino, 
 				   EXT2_I(inode)->i_file_acl);
 			error = -EIO;
@@ -784,8 +794,7 @@ ext2_xattr_delete_inode(struct inode *inode)
 		goto cleanup;
 	}
 	ea_bdebug(bh, "b_count=%d", atomic_read(&(bh->b_count)));
-	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
-	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
+	if (!ext2_xattr_header_valid(bh)) {
 		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
 			"inode %ld: bad block %d", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
-- 
2.20.1

