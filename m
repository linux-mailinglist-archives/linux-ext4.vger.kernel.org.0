Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9B02BD74
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2019 05:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfE1DAU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 27 May 2019 23:00:20 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25484 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727695AbfE1DAU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 May 2019 23:00:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559012416; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=DrYWUFa8mV6XlByg6rFcdq2it/GfuS9jihYHDC7NbG32MnCDYugUL1y4yxo6NrZbMliapxbF7cSET/lbJcXAgGXwaiX20f615kMgffAovStbB5oBgid24XiYb4irolEISiy0A4gM2cN14QY2Yqiy58pSWuB7jdG5BgZrZYyxqgc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1559012416; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=SC4MH8OuPePI4iJrH7heGRro4WoZfIrk214BgQcb2Ew=; 
        b=GGtwYRkqI5HttNWHrn1/Oe2KiNbq/GGev1rUvVnqeMUsVmOhViEjE92u6P6SjDMrS3iOydiGdqpbyuoEcI6B7XPUojdoJd5CnHxcqSkyccwqN1sBC7O8eLy/5jgP1BQrqG4XAXrts0bz0GCdWzu8+6WuQWgSCqs7RGIs1g5YuAo=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1559012414627555.1813037992562; Tue, 28 May 2019 11:00:14 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190528025947.18373-2-cgxu519@zoho.com.cn>
Subject: [PATCH v2 2/3] ext2: introduce new helper for xattr entry comparison
Date:   Tue, 28 May 2019 10:59:46 +0800
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

Introduce new helper ext2_xattr_cmp_entry() for xattr
entry comparison.

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/ext2/xattr.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 28503979696d..59356cd2a842 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -166,6 +166,21 @@ ext2_xattr_entry_valid(struct ext2_xattr_entry *entry,
 	return true;
 }
 
+static int
+ext2_xattr_cmp_entry(int name_index, size_t name_len, const char *name,
+		     struct ext2_xattr_entry *entry)
+{
+	int cmp;
+
+	cmp = name_index - entry->e_name_index;
+	if (!cmp)
+		cmp = name_len - entry->e_name_len;
+	if (!cmp)
+		cmp = memcmp(name, entry->e_name, name_len);
+
+	return cmp;
+}
+
 /*
  * ext2_xattr_get()
  *
@@ -452,13 +467,9 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 					min_offs = offs;
 			}
 			if (not_found > 0) {
-				not_found = name_index - last->e_name_index;
-				if (!not_found)
-					not_found = name_len - last->e_name_len;
-				if (!not_found) {
-					not_found = memcmp(name, last->e_name,
-							   name_len);
-				}
+				not_found = ext2_xattr_cmp_entry(name_index,
+								 name_len,
+								 name, last);
 				if (not_found <= 0)
 					here = last;
 			}
-- 
2.20.1



