Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41D533CED
	for <lists+linux-ext4@lfdr.de>; Wed, 25 May 2022 14:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiEYMs1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 May 2022 08:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiEYMs0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 May 2022 08:48:26 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C6547B9FF;
        Wed, 25 May 2022 05:48:22 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id C04011E80D32;
        Wed, 25 May 2022 20:40:51 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t5WVp0BhOMH9; Wed, 25 May 2022 20:40:48 +0800 (CST)
Received: from ubuntu.localdomain (unknown [101.228.248.89])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 9CD571E80CE5;
        Wed, 25 May 2022 20:40:48 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] ext4: add KERN_<LEVEL> for printk()
Date:   Wed, 25 May 2022 05:48:16 -0700
Message-Id: <20220525124816.86915-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

printk() should include KERN_<LEVEL> facility level, add them.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 fs/ext4/inode.c |  2 +-
 fs/ext4/namei.c | 14 +++++++-------
 fs/ext4/super.c |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3dce7d058985..6d6899191779 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -462,7 +462,7 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 	if (es_map->m_lblk != map->m_lblk ||
 	    es_map->m_flags != map->m_flags ||
 	    es_map->m_pblk != map->m_pblk) {
-		printk("ES cache assertion failed for inode: %lu "
+		printk(KERN_WARNING "ES cache assertion failed for inode: %lu "
 		       "es_cached ex [%d/%d/%llu/%x] != "
 		       "found ex [%d/%d/%llu/%x] retval %d flags %x\n",
 		       inode->i_ino, es_map->m_lblk, es_map->m_len,
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 47d0ca4c795b..89445661f71d 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -628,7 +628,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 	char *base = (char *) de;
 	struct dx_hash_info h = *hinfo;
 
-	printk("names: ");
+	printk(KERN_WARNING "names: ");
 	while ((char *) de < base + size)
 	{
 		if (de->inode)
@@ -648,7 +648,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 					/* Directory is not encrypted */
 					ext4fs_dirhash(dir, de->name,
 						de->name_len, &h);
-					printk("%*.s:(U)%x.%u ", len,
+					printk(KERN_WARNING "%*.s:(U)%x.%u ", len,
 					       name, h.hash,
 					       (unsigned) ((char *) de
 							   - base));
@@ -683,7 +683,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 					else
 						ext4fs_dirhash(dir, de->name,
 						       de->name_len, &h);
-					printk("%*.s:(E)%x.%u ", len, name,
+					printk(KERN_WARNING "%*.s:(E)%x.%u ", len, name,
 					       h.hash, (unsigned) ((char *) de
 								   - base));
 					fscrypt_fname_free_buffer(
@@ -693,7 +693,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 				int len = de->name_len;
 				char *name = de->name;
 				ext4fs_dirhash(dir, de->name, de->name_len, &h);
-				printk("%*.s:%x.%u ", len, name, h.hash,
+				printk(KERN_WARNING "%*.s:%x.%u ", len, name, h.hash,
 				       (unsigned) ((char *) de - base));
 #endif
 			}
@@ -713,14 +713,14 @@ struct stats dx_show_entries(struct dx_hash_info *hinfo, struct inode *dir,
 	unsigned count = dx_get_count(entries), names = 0, space = 0, i;
 	unsigned bcount = 0;
 	struct buffer_head *bh;
-	printk("%i indexed blocks...\n", count);
+	printk(KERN_WARNING "%i indexed blocks...\n", count);
 	for (i = 0; i < count; i++, entries++)
 	{
 		ext4_lblk_t block = dx_get_block(entries);
 		ext4_lblk_t hash  = i ? dx_get_hash(entries): 0;
 		u32 range = i < count - 1? (dx_get_hash(entries + 1) - hash): ~hash;
 		struct stats stats;
-		printk("%s%3u:%03u hash %8x/%8x ",levels?"":"   ", i, block, hash, range);
+		printk(KERN_WARNING "%s%3u:%03u hash %8x/%8x ",levels?"":"   ", i, block, hash, range);
 		bh = ext4_bread(NULL,dir, block, 0);
 		if (!bh || IS_ERR(bh))
 			continue;
@@ -855,7 +855,7 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 		goto fail;
 	}
 
-	dxtrace(printk("Look up %x", hash));
+	dxtrace(printk(KERN_WARNING "Look up %x", hash));
 	level = 0;
 	blocks[0] = 0;
 	while (1) {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 450c918d68fc..f1f0427b55a6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -941,9 +941,9 @@ void __ext4_msg(struct super_block *sb,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 	if (sb)
-		printk("%sEXT4-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
+		printk(KERN_WARNING "%sEXT4-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
 	else
-		printk("%sEXT4-fs: %pV\n", prefix, &vaf);
+		printk(KERN_WARNING "%sEXT4-fs: %pV\n", prefix, &vaf);
 	va_end(args);
 }
 
-- 
2.25.1

