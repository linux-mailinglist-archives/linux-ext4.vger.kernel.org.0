Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8687820314
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2019 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfEPKD0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 May 2019 06:03:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:48410 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727159AbfEPKDZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 16 May 2019 06:03:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6949CAF9F;
        Thu, 16 May 2019 10:03:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C34761E3ED6; Thu, 16 May 2019 12:03:23 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     cgxu519@zoho.com.cn, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] ext2: Merge loops in ext2_xattr_set()
Date:   Thu, 16 May 2019 12:03:21 +0200
Message-Id: <20190516100322.12632-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190516100322.12632-1-jack@suse.cz>
References: <20190516100322.12632-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There are two very similar loops when searching xattr to set. Just merge
them.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/xattr.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index fb2e008d4406..f9fda6d16d78 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -436,28 +436,12 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 			error = -EIO;
 			goto cleanup;
 		}
-		/* Find the named attribute. */
-		here = FIRST_ENTRY(bh);
-		while (!IS_LAST_ENTRY(here)) {
-			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(here);
-			if ((char *)next >= end)
-				goto bad_block;
-			if (!here->e_value_block && here->e_value_size) {
-				size_t offs = le16_to_cpu(here->e_value_offs);
-				if (offs < min_offs)
-					min_offs = offs;
-			}
-			not_found = name_index - here->e_name_index;
-			if (!not_found)
-				not_found = name_len - here->e_name_len;
-			if (!not_found)
-				not_found = memcmp(name, here->e_name,name_len);
-			if (not_found <= 0)
-				break;
-			here = next;
-		}
-		last = here;
-		/* We still need to compute min_offs and last. */
+		/*
+		 * Find the named attribute. If not found, 'here' will point
+		 * to entry where the new attribute should be inserted to
+		 * maintain sorting.
+		 */
+		last = FIRST_ENTRY(bh);
 		while (!IS_LAST_ENTRY(last)) {
 			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(last);
 			if ((char *)next >= end)
@@ -467,8 +451,21 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 				if (offs < min_offs)
 					min_offs = offs;
 			}
+			if (not_found > 0) {
+				not_found = name_index - last->e_name_index;
+				if (!not_found)
+					not_found = name_len - last->e_name_len;
+				if (!not_found) {
+					not_found = memcmp(name, last->e_name,
+							   name_len);
+				}
+				if (not_found <= 0)
+					here = last;
+			}
 			last = next;
 		}
+		if (not_found > 0)
+			here = last;
 
 		/* Check whether we have enough space left. */
 		free = min_offs - ((char*)last - (char*)header) - sizeof(__u32);
-- 
2.16.4

