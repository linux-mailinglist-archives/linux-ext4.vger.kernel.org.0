Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 322CF6C430
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jul 2019 03:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbfGRBXI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Wed, 17 Jul 2019 21:23:08 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25476 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727487AbfGRBXI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Jul 2019 21:23:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1563412983; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=hm85qyD8eQ+QrnFE+CDx5xw5G10D8CCTKS8CTSq7kek86f1m7Duqh9KGxJFqLDIKUSom5iiFcL1+ribow0Y4WpRIa6IpixnlwPdLGdaK3ZvG1L8D6tx0gdsUTjBaeYSZpENx4Agylikt0Q9vBFmMZJili7Qppz31gw7BYYk7KdQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1563412983; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=xbOwGZLzk5QLJHukkgmyyRhLxcbfYDvJkO0mgt0fypI=; 
        b=VZhzgjzgbEUpczYSE92/giPbdcwvyflV68uojZHv/HhpM2tfI95izTq0UZENMo5EPlLckfH9gTMq+qieAdotBUmG6gDHORYaVPBXEsW17xqfI6AJXfL7vBL7YPgq0Na2C4HIszLzav5WdYKT3oCpvjMIXyvX1ZrCYCVPuVrIRDU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1563412981987700.861440856228; Thu, 18 Jul 2019 09:23:01 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190718012236.22618-1-cgxu519@zoho.com.cn>
Subject: [PATCH] ext2: show more accurate free block count in debug message
Date:   Thu, 18 Jul 2019 09:22:36 +0800
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Show more accurate free block count in debug message by replacing
es->s_free_blocks_count to sbi->s_freeblocks_counter in
ext2_count_free_blocks().

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/ext2/balloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 547c165299c0..8c587533cead 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -1495,7 +1495,8 @@ unsigned long ext2_count_free_blocks (struct super_block * sb)
 		brelse(bitmap_bh);
 	}
 	printk("ext2_count_free_blocks: stored = %lu, computed = %lu, %lu\n",
-		(long)le32_to_cpu(es->s_free_blocks_count),
+		(unsigned long)
+		percpu_counter_read(&EXT2_SB(sb)->s_freeblocks_counter),
 		desc_count, bitmap_count);
 	return bitmap_count;
 #else
-- 
2.21.0



