Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C201B1F628
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2019 16:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfEOOBy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 May 2019 10:01:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:43248 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726834AbfEOOBy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 May 2019 10:01:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34C89AFBC;
        Wed, 15 May 2019 14:01:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 422381E3CBC; Wed, 15 May 2019 16:01:51 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Chengguang Xu <cgxu519@zoho.com.cn>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] ext2: Strengthen xattr block checks
Date:   Wed, 15 May 2019 16:01:44 +0200
Message-Id: <20190515140144.1183-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190515140144.1183-1-jack@suse.cz>
References: <20190515140144.1183-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Check every entry in xattr block for validity in ext2_xattr_set() to
detect on disk corruption early. Also since e_value_block field in xattr
entry is never != 0 in a valid filesystem, just remove checks for it
once we have established entries are valid.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/xattr.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 26a049ca89fb..04a4148d04b3 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -442,7 +442,9 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(last);
 			if ((char *)next >= end)
 				goto bad_block;
-			if (!last->e_value_block && last->e_value_size) {
+			if (!ext2_xattr_entry_valid(last, sb->s_blocksize))
+				goto bad_block;
+			if (last->e_value_size) {
 				size_t offs = le16_to_cpu(last->e_value_offs);
 				if (offs < min_offs)
 					min_offs = offs;
@@ -482,12 +484,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 		error = -EEXIST;
 		if (flags & XATTR_CREATE)
 			goto cleanup;
-		if (!here->e_value_block && here->e_value_size) {
-			if (!ext2_xattr_entry_valid(here, sb->s_blocksize))
-				goto bad_block;
-			free += EXT2_XATTR_SIZE(
-					le32_to_cpu(here->e_value_size));
-		}
+		free += EXT2_XATTR_SIZE(le32_to_cpu(here->e_value_size));
 		free += EXT2_XATTR_LEN(name_len);
 	}
 	error = -ENOSPC;
@@ -552,7 +549,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 		here->e_name_len = name_len;
 		memcpy(here->e_name, name, name_len);
 	} else {
-		if (!here->e_value_block && here->e_value_size) {
+		if (here->e_value_size) {
 			char *first_val = (char *)header + min_offs;
 			size_t offs = le16_to_cpu(here->e_value_offs);
 			char *val = (char *)header + offs;
@@ -579,7 +576,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 			last = ENTRY(header+1);
 			while (!IS_LAST_ENTRY(last)) {
 				size_t o = le16_to_cpu(last->e_value_offs);
-				if (!last->e_value_block && o < offs)
+				if (o < offs)
 					last->e_value_offs =
 						cpu_to_le16(o + size);
 				last = EXT2_XATTR_NEXT(last);
-- 
2.16.4

