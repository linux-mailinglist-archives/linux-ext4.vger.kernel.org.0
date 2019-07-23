Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 261D9716E0
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2019 13:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389319AbfGWLWW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 23 Jul 2019 07:22:22 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25362 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389316AbfGWLWW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 23 Jul 2019 07:22:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1563880933; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=k7OU0aLQvZ6UJ+MMpH0AbPtmxoridAQAvt4CvMWsekvXIqQUojmje8wi3EaWH4ZgIVbOGQNIBbE7D5xy59mbOpjoe9GmNJSeGUZ0azzFGlOLmu4QXrH5Ffj6lIvxFkhVTNyMory/YaC4pj4P9PoI3Zzj7O6DvDYCGCE/CcyjPQs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1563880933; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=M4npbY+d2w04nMFZkSQ2izRqQY8IBhZ8sCa3+0xUQbU=; 
        b=KGQndfO1cCqT6VIMRGGmxaDOwD97bdiBkZhSLUwIPUlxXSoLddO7OwmiVzruNvSsyovxIDzc8uLQ5IHjayZxNLeu5gP6bznaEI5ldJoA8X67IICXFc2dbwC7vjft0H+j3JQze4PlWZXj7QW0lcbJKOjhNCqbmsG1ZlUVmCQQBzQ=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1563880932360333.2029146226279; Tue, 23 Jul 2019 19:22:12 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190723112155.20329-2-cgxu519@zoho.com.cn>
Subject: [PATCH 2/2] ext2: code cleanup for ext2_free_blocks()
Date:   Tue, 23 Jul 2019 19:21:55 +0800
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723112155.20329-1-cgxu519@zoho.com.cn>
References: <20190723112155.20329-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Call ext2_data_block_valid() for block range validity.

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/ext2/balloc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 92e9a7489174..e0cc55164505 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -490,9 +490,7 @@ void ext2_free_blocks (struct inode * inode, unsigned long block,
 	struct ext2_super_block * es = sbi->s_es;
 	unsigned freed = 0, group_freed;
 
-	if (block < le32_to_cpu(es->s_first_data_block) ||
-	    block + count < block ||
-	    block + count > le32_to_cpu(es->s_blocks_count)) {
+	if (!ext2_data_block_valid(sbi, block, count)) {
 		ext2_error (sb, "ext2_free_blocks",
 			    "Freeing blocks not in datazone - "
 			    "block = %lu, count = %lu", block, count);
-- 
2.20.1



