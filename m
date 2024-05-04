Return-Path: <linux-ext4+bounces-2294-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A888BB9F4
	for <lists+linux-ext4@lfdr.de>; Sat,  4 May 2024 10:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C87ACB21AC0
	for <lists+linux-ext4@lfdr.de>; Sat,  4 May 2024 08:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7FF14F78;
	Sat,  4 May 2024 08:05:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6199111AA;
	Sat,  4 May 2024 08:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714809929; cv=none; b=e81La9ZsdjKchRdPd6bkPtgRkLfVg0hQyDtIT6eP8S3JKR71qVZ/s+akHD60gMMO9pH9U4dFHm6ptzWAegSjyLi2zXedPfMEdr0G5jBKss6P7CBG/0XOu2r2vRRYW7sB6qZ9Q7US4TozU2e+wye50u1NzWntZZetW5afisMPci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714809929; c=relaxed/simple;
	bh=PqEHoe9X1I+B/sJzkfzuM0O55hXfopFksPoGm8W8qGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nFBxsIXI4xeCLfQOZAH5jelT4RdEkysMFiSP9twE1OKpICRnFNEApX1Ox8hmfHaS9fVx6ysem3qi2JrYF8xhnaOdrpG8VpIsHFg3ADFGWeQham4iWzFHO4zbEqlizxe1IJP7Lvy16S1m6BM5E/BONTysn/V8gahAoYC9zuI3S5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VWgFj05NJz4f3jZ7;
	Sat,  4 May 2024 16:05:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 328261A0179;
	Sat,  4 May 2024 16:05:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBE57DVmKbDhLg--.23467S6;
	Sat, 04 May 2024 16:05:18 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH 2/2] ext4: propagate errors from ext4_sb_bread() in ext4_xattr_block_cache_find()
Date: Sat,  4 May 2024 15:55:26 +0800
Message-Id: <20240504075526.2254349-3-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240504075526.2254349-1-libaokun@huaweicloud.com>
References: <20240504075526.2254349-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBE57DVmKbDhLg--.23467S6
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17Zw4UZr18JF18tF4DCFg_yoW8tw4xpr
	y3KryrtrW0gFy3uay3tF1UZw1fuan7GF4UKrW7K34rZa4UXw1SgFyIq3Z0vFyj9rZ7X3ZF
	qF4qk34Uu3W5C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
	pf9x0JUBmhrUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

In ext4_xattr_block_cache_find(), when ext4_sb_bread() returns an error,
we will either continue to find the next ea block or return NULL to try to
insert a new ea block. But whether ext4_sb_bread() returns -EIO or -ENOMEM,
the next operation is most likely to fail with the same error. So propagate
the error returned by ext4_sb_bread() to make ext4_xattr_block_set() fail
to reduce pointless operations.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/xattr.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 9fdd13422073..11742e1f16d7 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2059,8 +2059,13 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 
 inserted:
 	if (!IS_LAST_ENTRY(s->first)) {
-		new_bh = ext4_xattr_block_cache_find(inode, header(s->base),
-						     &ce);
+		new_bh = ext4_xattr_block_cache_find(inode, header(s->base), &ce);
+		if (IS_ERR(new_bh)) {
+			error = PTR_ERR(new_bh);
+			new_bh = NULL;
+			goto cleanup;
+		}
+
 		if (new_bh) {
 			/* We found an identical block in the cache. */
 			if (new_bh == bs->bh)
@@ -3090,8 +3095,8 @@ ext4_xattr_cmp(struct ext4_xattr_header *header1,
  *
  * Find an identical extended attribute block.
  *
- * Returns a pointer to the block found, or NULL if such a block was
- * not found or an error occurred.
+ * Returns a pointer to the block found, or NULL if such a block was not
+ * found, or an error pointer if an error occurred while reading ea block.
  */
 static struct buffer_head *
 ext4_xattr_block_cache_find(struct inode *inode,
@@ -3113,13 +3118,11 @@ ext4_xattr_block_cache_find(struct inode *inode,
 
 		bh = ext4_sb_bread(inode->i_sb, ce->e_value, REQ_PRIO);
 		if (IS_ERR(bh)) {
-			if (PTR_ERR(bh) == -ENOMEM) {
-				mb_cache_entry_put(ea_block_cache, ce);
-				return NULL;
-			}
-			bh = NULL;
-			EXT4_ERROR_INODE(inode, "block %lu read error",
-					 (unsigned long)ce->e_value);
+			if (PTR_ERR(bh) != -ENOMEM)
+				EXT4_ERROR_INODE(inode, "block %lu read error",
+						 (unsigned long)ce->e_value);
+			mb_cache_entry_put(ea_block_cache, ce);
+			return bh;
 		} else if (ext4_xattr_cmp(header, BHDR(bh)) == 0) {
 			*pce = ce;
 			return bh;
-- 
2.39.2


