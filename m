Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95E211BFB0
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2019 00:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfEMW4J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 May 2019 18:56:09 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25909 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726265AbfEMW4J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 May 2019 18:56:09 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 May 2019 18:56:07 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1557787261; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=VnWEKtlyQM7qLz7O7d6S5bUXUFJ7gosgbPpg5gQZUsW4V0NHY3kpu7YyGDH3ewYOgsWTHyn43w+x5o2mpD/dYrWv4/L5zN6FAcSmVjFudcSx2bTrKiREJK5ZV8RYhvUdb5vOUQKcCmSyihV6FvVCSxrndjwZxfP5N/1jUaSXyFE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1557787261; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=vN62waYVjSvHo7g9VLoeQ8yjw8aOq+bOMf33BZLw4pc=; 
        b=cII3yBlfUFjyobp9B2UvwoQIc3y2TWLiVIm8cgkF1YQRVOtbMpef15ugzA4k5VoA0xjv2BvJoKMUgbvcUOMItVQtsdGUyMHv7yDKX6SbM+tRL+n0cK8Ztka3H69wcdCUd5lTqHLrM5hL7Otcyr9nNkD4A32IYVr8AS3PR+78Dqg=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (113.116.158.181 [113.116.158.181]) by mx.zoho.com.cn
        with SMTPS id 1557787258928688.4716896184108; Tue, 14 May 2019 06:40:58 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Subject: [PATCH v2 1/2] ext2: introduce helper for xattr header validation
Date:   Tue, 14 May 2019 06:40:41 +0800
Message-Id: <20190513224042.23377-1-cgxu519@zoho.com.cn>
X-Mailer: git-send-email 2.17.2
X-ZohoCNMailClient: External
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Introduce helper function ext2_xattr_header_valid()
for xattr header validation and clean up the header
check ralated code.

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
v1->v2:
- Pass xattr header to ext2_xattr_header_valid().
- Change signed-off mail address.

 fs/ext2/xattr.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 1e33e0ac8cf1..db27260d6a5b 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -134,6 +134,16 @@ ext2_xattr_handler(int name_index)
 	return handler;
 }
 
+static bool
+ext2_xattr_header_valid(struct ext2_xattr_header *header)
+{
+	if (header->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
+	    header->h_blocks != cpu_to_le32(1))
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
+	if (!ext2_xattr_header_valid(HDR(bh))) {
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
+	if (!ext2_xattr_header_valid(HDR(bh))) {
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
+		if (!ext2_xattr_header_valid(header)) {
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
+	if (!ext2_xattr_header_valid(HDR(bh))) {
 		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
 			"inode %ld: bad block %d", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
-- 
2.17.2


