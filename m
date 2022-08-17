Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FF7596799
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Aug 2022 05:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbiHQDBT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Aug 2022 23:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbiHQDBT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 Aug 2022 23:01:19 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 551139A949;
        Tue, 16 Aug 2022 20:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sLR7L
        vrKYMgqFhsvENwXYBmFgc0bVIRbOis3wqnwhzw=; b=E9pFZYZXOu/FCV4FWOSRF
        3M97U4cXU3qNTIFq5DwXnqTCyN7uhmnzUpIgx7KURZtXf6DIPH1YPyf+TXac6Iut
        YbsQF6ZPwalkKkpTHdbtB8jTxnSz9FtB3vG6EexEN0zsCuyyOT2U1EqtkrADGV7u
        RuxIfpSCtONZTsdUm+BSYU=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp2 (Coremail) with SMTP id GtxpCgD3swajWfximOSZWA--.17366S2;
        Wed, 17 Aug 2022 10:59:49 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     lczerner@redhat.com, lkp@intel.com, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH v4] fs/ext4: replace ternary operator with min()/max() and min_t()
Date:   Wed, 17 Aug 2022 10:59:28 +0800
Message-Id: <20220817025928.612851-1-13667453960@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgD3swajWfximOSZWA--.17366S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFWxCw4UCw1rZw17CF17Jrb_yoW5Aw1UpF
        n3CF18GFWru348uayIgr4UZw15W3WkG3y7XryY9r1UWFWqqFyxtrn8Kr1jvF1FgrWkZ34j
        qFW0kr1UJwnIkrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jU_-PUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbiyAVg+1p7HaIJdgAAs3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix the following coccicheck warning:

fs/ext4/inline.c:183: WARNING opportunity for min().
fs/ext4/extents.c:2631: WARNING opportunity for max().
fs/ext4/extents.c:2632: WARNING opportunity for min().
fs/ext4/extents.c:5559: WARNING opportunity for max().
fs/ext4/super.c:6908: WARNING opportunity for min().

min()/max() and min_t() macro is defined in include/linux/minmax.h.
It avoids multiple evaluations of the arguments when non-constant and
performs strict type-checking.

Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/extents.c | 8 +++-----
 fs/ext4/inline.c  | 3 +--
 fs/ext4/super.c   | 3 +--
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c148bb97b527..37321aecd878 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2628,9 +2628,8 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 			  unwritten, ex_ee_len);
 		path[depth].p_ext = ex;
 
-		a = ex_ee_block > start ? ex_ee_block : start;
-		b = ex_ee_block+ex_ee_len - 1 < end ?
-			ex_ee_block+ex_ee_len - 1 : end;
+		a = max(ex_ee_block, start);
+		b = min(ex_ee_block + ex_ee_len - 1, end);
 
 		ext_debug(inode, "  border %u:%u\n", a, b);
 
@@ -5557,8 +5556,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	 * ee_start_lblk to shift extents
 	 */
 	ret = ext4_ext_shift_extents(inode, handle,
-		ee_start_lblk > offset_lblk ? ee_start_lblk : offset_lblk,
-		len_lblk, SHIFT_RIGHT);
+		max(ee_start_lblk, offset_lblk), len_lblk, SHIFT_RIGHT);
 
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (IS_SYNC(inode))
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index a4fbe825694b..2b42ececa46d 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -180,8 +180,7 @@ static int ext4_read_inline_data(struct inode *inode, void *buffer,
 
 	BUG_ON(len > EXT4_I(inode)->i_inline_size);
 
-	cp_len = len < EXT4_MIN_INLINE_DATA_SIZE ?
-			len : EXT4_MIN_INLINE_DATA_SIZE;
+	cp_len = min_t(unsigned int, len, EXT4_MIN_INLINE_DATA_SIZE);
 
 	raw_inode = ext4_raw_inode(iloc);
 	memcpy(buffer, (void *)(raw_inode->i_block), cp_len);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9a66abcca1a8..55649efc3eec 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6905,8 +6905,7 @@ static ssize_t ext4_quota_read(struct super_block *sb, int type, char *data,
 		len = i_size-off;
 	toread = len;
 	while (toread > 0) {
-		tocopy = sb->s_blocksize - offset < toread ?
-				sb->s_blocksize - offset : toread;
+		tocopy = min_t(unsigned long, sb->s_blocksize - offset, toread);
 		bh = ext4_bread(NULL, inode, blk, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
-- 
2.27.0


No virus found
		Checked by Hillstone Network AntiVirus

