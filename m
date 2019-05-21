Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D46C524A28
	for <lists+linux-ext4@lfdr.de>; Tue, 21 May 2019 10:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfEUIWF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 21 May 2019 04:22:05 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25329 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726006AbfEUIWF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 May 2019 04:22:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558426920; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=JJQYIKJRP23buI1v9tRq43Na8SWg2GaS5K5BzblUcIckdTemvMj/L7krMnRfxjVQHkgBfyXaKCt8JbhKOXUZv20PUEMCG4MC0sjOUmOU4my5TH+Lt+vLlEyE/41TBXorU5lb+E56kN1snpJg93nBVd0G8P/xqiS6TJeqkuEPO8M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1558426920; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=G2prlBlgR5vzLkKOrsuhSA7dLPSWrLTx6UuM5BNoZu4=; 
        b=RNePn5luhTzndN/2XUJk9puKEF+XOh7NT4mR6mafs+dzq7mFF1biMTyjPVjKv9iz4+JR8zZWIe40qgtu8uUhiZQHFdBzUwvqLiHgLpobfOwMAHez5s1YUHrU8b2LS1ACzYKhLdnRU9PFGvw3Ex/ud+5NZowuq/HJuCwruesoaYM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1558426916615867.6926716142767; Tue, 21 May 2019 16:21:56 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190521082140.19992-1-cgxu519@zoho.com.cn>
Subject: [PATCH] ext2: optimize ext2_xattr_get()
Date:   Tue, 21 May 2019 16:21:39 +0800
X-Mailer: git-send-email 2.20.1
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
 fs/ext2/xattr.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index d21dbf297b74..f1f857b83b45 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -178,7 +178,7 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
 	struct ext2_xattr_entry *entry;
 	size_t name_len, size;
 	char *end;
-	int error;
+	int error, not_found;
 	struct mb_cache *ea_block_cache = EA_BLOCK_CACHE(inode);
 
 	ea_idebug(inode, "name=%d.%s, buffer=%p, buffer_size=%ld",
@@ -220,10 +220,18 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
 			goto bad_block;
 		if (!ext2_xattr_entry_valid(entry, inode->i_sb->s_blocksize))
 			goto bad_block;
-		if (name_index == entry->e_name_index &&
-		    name_len == entry->e_name_len &&
-		    memcmp(name, entry->e_name, name_len) == 0)
+
+		not_found = name_index - entry->e_name_index;
+		if (!not_found)
+			not_found = name_len - entry->e_name_len;
+		if (!not_found)
+			not_found = memcmp(name, entry->e_name,
+						   name_len);
+		if (!not_found)
 			goto found;
+		if (not_found < 0)
+			break;
+
 		entry = next;
 	}
 	if (ext2_xattr_cache_insert(ea_block_cache, bh))
-- 
2.20.1



