Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 553CB1F627
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2019 16:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfEOOBy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 May 2019 10:01:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:43244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbfEOOBy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 May 2019 10:01:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29054AF93;
        Wed, 15 May 2019 14:01:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3F01B1E3C87; Wed, 15 May 2019 16:01:51 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Chengguang Xu <cgxu519@zoho.com.cn>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] ext2: Merge loops in ext2_xattr_set()
Date:   Wed, 15 May 2019 16:01:43 +0200
Message-Id: <20190515140144.1183-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190515140144.1183-1-jack@suse.cz>
References: <20190515140144.1183-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There are two very similar loops when searching xattr to set. Just merge
them.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/xattr.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index fb2e008d4406..26a049ca89fb 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -437,27 +437,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 			goto cleanup;
 		}
 		/* Find the named attribute. */
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
+		last = FIRST_ENTRY(bh);
 		while (!IS_LAST_ENTRY(last)) {
 			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(last);
 			if ((char *)next >= end)
@@ -467,8 +447,18 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 				if (offs < min_offs)
 					min_offs = offs;
 			}
+			if (not_found) {
+				if (name_index == last->e_name_index &&
+				    name_len == last->e_name_len &&
+				    !memcmp(name, last->e_name,name_len)) {
+					not_found = 0;
+					here = last;
+				}
+			}
 			last = next;
 		}
+		if (not_found)
+			here = last;
 
 		/* Check whether we have enough space left. */
 		free = min_offs - ((char*)last - (char*)header) - sizeof(__u32);
-- 
2.16.4

