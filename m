Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7012BD75
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2019 05:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfE1DAV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 27 May 2019 23:00:21 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25485 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727667AbfE1DAV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 May 2019 23:00:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559012417; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=bHXU6vdJwnbjz/gzeTwspduNB8K9NNy4KwRoz+RsykTrviTa038szzR0+PLHV7lqO65IDW/cfc+1wIpLeV5yVHbLwzzm2ySNWOJNlISI6QQK5coV6iYC4UWt9ISSwNyJ1mkNGdhxOXkPfgSNwaXgrStiVt0AKsih4jAxr03bC9I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1559012417; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=jXKRhCq294I48aW5BQ9sq87C6TgE8E9qjJv/gKKdWJg=; 
        b=JVhsIYQHqEi9sAAb7uW8GSN/N4NfzohkuF5QL9Imk9hBim+ZorJfV+T2NKERS//TFczJRQjPpRlTjFqcVVBhvduWBm5VLs/0JzVvl9ugtyp1dEhlWPWBwEB+YkRI7WKlo9X8KK55zQKltUF8Rxlbz8mZT3UUtRzFJQUeMYIaVxs=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 155901241624780.03007219054382; Tue, 28 May 2019 11:00:16 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190528025947.18373-3-cgxu519@zoho.com.cn>
Subject: [PATCH v2 3/3] ext2: optimize ext2_xattr_get()
Date:   Tue, 28 May 2019 10:59:47 +0800
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528025947.18373-1-cgxu519@zoho.com.cn>
References: <20190528025947.18373-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since xattr entry names are sorted, we don't have
to continue when current entry name is greater than
target.

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
v1->v2:
- Introduce new helper for xattr entry comparison

 fs/ext2/xattr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 59356cd2a842..839e71e78673 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -199,7 +199,7 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
 	struct ext2_xattr_entry *entry;
 	size_t name_len, size;
 	char *end;
-	int error;
+	int error, not_found;
 	struct mb_cache *ea_block_cache = EA_BLOCK_CACHE(inode);
 
 	ea_idebug(inode, "name=%d.%s, buffer=%p, buffer_size=%ld",
@@ -238,10 +238,14 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
 		if (!ext2_xattr_entry_valid(entry, end,
 		    inode->i_sb->s_blocksize))
 			goto bad_block;
-		if (name_index == entry->e_name_index &&
-		    name_len == entry->e_name_len &&
-		    memcmp(name, entry->e_name, name_len) == 0)
+
+		not_found = ext2_xattr_cmp_entry(name_index, name_len, name,
+						 entry);
+		if (!not_found)
 			goto found;
+		if (not_found < 0)
+			break;
+
 		entry = EXT2_XATTR_NEXT(entry);
 	}
 	if (ext2_xattr_cache_insert(ea_block_cache, bh))
-- 
2.20.1



