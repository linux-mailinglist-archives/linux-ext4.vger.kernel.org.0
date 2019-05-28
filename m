Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0FF2BD73
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2019 05:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfE1DAP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 27 May 2019 23:00:15 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25482 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727386AbfE1DAP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 May 2019 23:00:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559012410; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=FvjGbuQ7jlUj5SgU8eUBR4FnjKgbdS5VaBFURnjWDvxQzJxyJX015eOutJ7eVPRxeas2TOvQW/9MZqNSvhbeinOvFaH9S2YeEo5z+noFZVZlvRfMhcQ2E7lNXVbwoFTnktf2XvlboP3u+GJckC3dkpf56h5iAgQL4WVt89/xcPk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1559012410; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=Bwb/sqO92H8TEneXJVpV16I7bXgl61UjMYndxQxkEZo=; 
        b=GDUvSpBcsix5Fk2X1xyLihacRftj1NKdV9HB4JTWjn4CZvEjhKb0TmmqLntBhkaeiEQf2NP5b0ezrQVOsRHHsd7+5Vz89KA5CyUskqUwIeilhtexfxApFPHogAmWWQlr0ojaEskHdRwgEqWtzDbqRClhQ+hID0saMJeyUhv6ObY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1559012408505542.5916969402231; Tue, 28 May 2019 11:00:08 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190528025947.18373-1-cgxu519@zoho.com.cn>
Subject: [PATCH v2 1/3] ext2: merge xattr next entry check to ext2_xattr_entry_valid()
Date:   Tue, 28 May 2019 10:59:45 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We have introduced ext2_xattr_entry_valid() for xattr
entry sanity check, so it's better to do relevant things
in one place.

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/ext2/xattr.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index d21dbf297b74..28503979696d 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -145,10 +145,16 @@ ext2_xattr_header_valid(struct ext2_xattr_header *header)
 }
 
 static bool
-ext2_xattr_entry_valid(struct ext2_xattr_entry *entry, size_t end_offs)
+ext2_xattr_entry_valid(struct ext2_xattr_entry *entry,
+		       char *end, size_t end_offs)
 {
+	struct ext2_xattr_entry *next;
 	size_t size;
 
+	next = EXT2_XATTR_NEXT(entry);
+	if ((char *)next >= end)
+		return false;
+
 	if (entry->e_value_block != 0)
 		return false;
 
@@ -214,17 +220,14 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
 	/* find named attribute */
 	entry = FIRST_ENTRY(bh);
 	while (!IS_LAST_ENTRY(entry)) {
-		struct ext2_xattr_entry *next =
-			EXT2_XATTR_NEXT(entry);
-		if ((char *)next >= end)
-			goto bad_block;
-		if (!ext2_xattr_entry_valid(entry, inode->i_sb->s_blocksize))
+		if (!ext2_xattr_entry_valid(entry, end,
+		    inode->i_sb->s_blocksize))
 			goto bad_block;
 		if (name_index == entry->e_name_index &&
 		    name_len == entry->e_name_len &&
 		    memcmp(name, entry->e_name, name_len) == 0)
 			goto found;
-		entry = next;
+		entry = EXT2_XATTR_NEXT(entry);
 	}
 	if (ext2_xattr_cache_insert(ea_block_cache, bh))
 		ea_idebug(inode, "cache insert failed");
@@ -299,13 +302,10 @@ ext2_xattr_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 	/* check the on-disk data structure */
 	entry = FIRST_ENTRY(bh);
 	while (!IS_LAST_ENTRY(entry)) {
-		struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(entry);
-
-		if ((char *)next >= end)
-			goto bad_block;
-		if (!ext2_xattr_entry_valid(entry, inode->i_sb->s_blocksize))
+		if (!ext2_xattr_entry_valid(entry, end,
+		    inode->i_sb->s_blocksize))
 			goto bad_block;
-		entry = next;
+		entry = EXT2_XATTR_NEXT(entry);
 	}
 	if (ext2_xattr_cache_insert(ea_block_cache, bh))
 		ea_idebug(inode, "cache insert failed");
@@ -390,7 +390,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh = NULL;
 	struct ext2_xattr_header *header = NULL;
-	struct ext2_xattr_entry *here, *last;
+	struct ext2_xattr_entry *here = NULL, *last = NULL;
 	size_t name_len, free, min_offs = sb->s_blocksize;
 	int not_found = 1, error;
 	char *end;
@@ -444,10 +444,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 		 */
 		last = FIRST_ENTRY(bh);
 		while (!IS_LAST_ENTRY(last)) {
-			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(last);
-			if ((char *)next >= end)
-				goto bad_block;
-			if (!ext2_xattr_entry_valid(last, sb->s_blocksize))
+			if (!ext2_xattr_entry_valid(last, end, sb->s_blocksize))
 				goto bad_block;
 			if (last->e_value_size) {
 				size_t offs = le16_to_cpu(last->e_value_offs);
@@ -465,7 +462,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 				if (not_found <= 0)
 					here = last;
 			}
-			last = next;
+			last = EXT2_XATTR_NEXT(last);
 		}
 		if (not_found > 0)
 			here = last;
@@ -476,7 +473,6 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 		/* We will use a new extended attribute block. */
 		free = sb->s_blocksize -
 			sizeof(struct ext2_xattr_header) - sizeof(__u32);
-		here = last = NULL;  /* avoid gcc uninitialized warning. */
 	}
 
 	if (not_found) {
-- 
2.20.1



