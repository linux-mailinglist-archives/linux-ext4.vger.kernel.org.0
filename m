Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BADA27D1E
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2019 14:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfEWMtB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 May 2019 08:49:01 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25944 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728309AbfEWMtB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 May 2019 08:49:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558615730; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=gDkNE7En7ygRjvdGDuk4JotPSoh3i4o9xt1CMfi8WMnPR7MqlQNOBscMeI0M9RU0CraUcOODqn8hmDx+jWL46iynLet2ob6BTlcY8942mroeN7ImFhRRqdX9ZC3ZIlazGw9uCaFeJZ7NouJGawyk0/cxjGlgY2hCiFb4vIM5MIw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1558615730; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=dixwUUAF2ofRCmBvj9BOGWoAVnWGH7rJvFGD8sTiwxI=; 
        b=olPifxevUAozQ3r/mbV5hvsZbCn8jAnSuqTYpMU1/uogajzyRRspR/GECvPxaziBLF7db3WkVOmCEx/2uf0+k0bbMupRY74Jlrl3V622vBzMb3hf3Ypk8Q16NhavlJFC2Lr9yKuEwRhZpxSe4+aPXTYqb+d2FYkcz9mFvUGUxfw=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (113.116.48.87 [113.116.48.87]) by mx.zoho.com.cn
        with SMTPS id 1558615728335352.2663832142057; Thu, 23 May 2019 20:48:48 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Subject: [PATCH] ext4: remove some redundant corruption checks
Date:   Thu, 23 May 2019 20:48:43 +0800
Message-Id: <20190523124843.566-1-cgxu519@zoho.com.cn>
X-Mailer: git-send-email 2.17.2
X-ZohoCNMailClient: External
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove some redundant corruption checks in
ext4_xattr_block_get() and ext4_xattr_ibody_get()
because ext4_xattr_check_entries() has done those
checks.

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/ext4/xattr.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 491f9ee4040e..b74346f103a6 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -542,8 +542,6 @@ ext4_xattr_block_get(struct inode *inode, int name_index, const char *name,
 		goto cleanup;
 	size = le32_to_cpu(entry->e_value_size);
 	error = -ERANGE;
-	if (unlikely(size > EXT4_XATTR_SIZE_MAX))
-		goto cleanup;
 	if (buffer) {
 		if (size > buffer_size)
 			goto cleanup;
@@ -556,8 +554,6 @@ ext4_xattr_block_get(struct inode *inode, int name_index, const char *name,
 			u16 offset = le16_to_cpu(entry->e_value_offs);
 			void *p = bh->b_data + offset;
 
-			if (unlikely(p + size > end))
-				goto cleanup;
 			memcpy(buffer, p, size);
 		}
 	}
@@ -597,8 +593,6 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 		goto cleanup;
 	size = le32_to_cpu(entry->e_value_size);
 	error = -ERANGE;
-	if (unlikely(size > EXT4_XATTR_SIZE_MAX))
-		goto cleanup;
 	if (buffer) {
 		if (size > buffer_size)
 			goto cleanup;
@@ -611,8 +605,6 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 			u16 offset = le16_to_cpu(entry->e_value_offs);
 			void *p = (void *)IFIRST(header) + offset;
 
-			if (unlikely(p + size > end))
-				goto cleanup;
 			memcpy(buffer, p, size);
 		}
 	}
-- 
2.17.2


