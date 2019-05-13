Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 999A51BFB1
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2019 00:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEMW4N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 May 2019 18:56:13 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25783 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726510AbfEMW4N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 May 2019 18:56:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1557787264; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=HFTCvpJ1RfTlhTJmFTs6tu395/V395OLdf60qKINzO2D0EStfQqmriIQbs/ilv5xq1t3NVYXQO08vdsXLPsqr7tF+XiDzx/7b4COGPJcyvw84Ssfz6OA0O1CadQr3TtShBL1ox63GHs6pO1bedcGFMI0h6ESbZhEwOYA9BEXVec=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1557787264; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=VAC35oq+NQeQ9tup+ny2nFd8Ypk3E9yEnl4EucOlN8U=; 
        b=QrqNt6VK+x++J0sfAiy4YbizhKA9d5YScN55SOS8MtMW9C0r5dj4kxhJ81EwDY6iGnPT4se0lhSdpBJq9pjnd5olIQhvXHtkmtGSOG68z/NxMRDDUZPaAwGTySSJxRVpJHYm3uBQu39X3tY4XuEeWBPbRI1EqA5B7Ph1HYj7yak=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (113.116.158.181 [113.116.158.181]) by mx.zoho.com.cn
        with SMTPS id 1557787263126147.89426202165214; Tue, 14 May 2019 06:41:03 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Subject: [PATCH v2 2/2] ext2: introduce helper for xattr entry validation
Date:   Tue, 14 May 2019 06:40:42 +0800
Message-Id: <20190513224042.23377-2-cgxu519@zoho.com.cn>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190513224042.23377-1-cgxu519@zoho.com.cn>
References: <20190513224042.23377-1-cgxu519@zoho.com.cn>
X-ZohoCNMailClient: External
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Introduce helper function ext2_xattr_entry_valid()
for xattr entry validation and clean up the entry
check ralated code.

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
v1->v2:
- Pass end offset instead of inode to ext2_xattr_entry_valid()
- Change signed-off mail address.

 fs/ext2/xattr.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index db27260d6a5b..d11c83529514 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -144,6 +144,20 @@ ext2_xattr_header_valid(struct ext2_xattr_header *header)
 	return true;
 }
 
+static bool
+ext2_xattr_entry_valid(struct ext2_xattr_entry *entry, size_t size,
+		       size_t end_offs)
+{
+	if (entry->e_value_block != 0)
+		return false;
+
+	if (size > end_offs ||
+	    le16_to_cpu(entry->e_value_offs) + size > end_offs)
+		return false;
+
+	return true;
+}
+
 /*
  * ext2_xattr_get()
  *
@@ -217,8 +231,7 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
 	if (entry->e_value_block != 0)
 		goto bad_block;
 	size = le32_to_cpu(entry->e_value_size);
-	if (size > inode->i_sb->s_blocksize ||
-	    le16_to_cpu(entry->e_value_offs) + size > inode->i_sb->s_blocksize)
+	if (!ext2_xattr_entry_valid(entry, size, inode->i_sb->s_blocksize))
 		goto bad_block;
 
 	if (ext2_xattr_cache_insert(ea_block_cache, bh))
@@ -483,8 +496,8 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 		if (!here->e_value_block && here->e_value_size) {
 			size_t size = le32_to_cpu(here->e_value_size);
 
-			if (le16_to_cpu(here->e_value_offs) + size > 
-			    sb->s_blocksize || size > sb->s_blocksize)
+			if (!ext2_xattr_entry_valid(here, size,
+			    inode->i_sb->s_blocksize))
 				goto bad_block;
 			free += EXT2_XATTR_SIZE(size);
 		}
-- 
2.17.2


