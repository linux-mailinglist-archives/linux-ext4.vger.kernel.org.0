Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0309676E00E
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 08:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjHCGJz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 02:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjHCGJy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 02:09:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6D8272C;
        Wed,  2 Aug 2023 23:09:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-317b31203c7so525384f8f.2;
        Wed, 02 Aug 2023 23:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691042992; x=1691647792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oP3zxtD+0slQxaWy/bQYAlXRzptkEvoefxyTvuaiCok=;
        b=HMNxIJCou7SwS+TtE4QnYWHt2S8KQSoYGd1YN/g9jxuYx3P6vtpdEdqfDh8WgE7p17
         iwEie3KCbhbNFHJwJV3HUnWzveUyyOXILWsHMpqcTYImxJtI//OLIh8Em7oxBquLij4X
         CYU5Limw4/qQH6R6rDdZxz72Nc/X9NrROAGqG+f7jEJvJnVdbHLo2A26AEJ5shBATWwj
         qCmomT/AtqaesLjX+Hlpyac2kdF80nwl3eNu6yYGsL3aY7/S7ucUOE7UUW6+1dRx8Alb
         FjBscD5qOMnLZ4PjWAkwZHCMxZ67B7QHkPEnU3YE2DRgz0c913VAYix2+aT7w624oObi
         40zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691042992; x=1691647792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oP3zxtD+0slQxaWy/bQYAlXRzptkEvoefxyTvuaiCok=;
        b=Ql7sqYHjGMbHeu4wYXUu34MaeONZMASD0WnIN2rou+1tttyMpv/J8zv46LSWOUQW/f
         9X5sOBjHssFBClbnrCorRHcqKu8Z5pF5tAONRrxYLRG9K8v6p+KyZ7jNNSmFfu2VafRp
         NHW/T+TvJSnv5nWgpjJhXqU+KoyJsUbyNmgsn1FPlMttEUv2TUTHiTSmUAonMQcb7eic
         x9wTQTJPAp2Yp6UD7c4Bo3gjlvAbGPa8wDV1V37w5x1jgC2EJO6msV4uVnWdr5BZ4cLh
         YZBCNPdBVpmQRu63OvsG7+uM6qZJ78zodGzVcP2G8G0Fqu48lllLyJDVukU8l598I1SI
         iLkA==
X-Gm-Message-State: ABy/qLYelCPKzeYXFn6GD+4MGoELr9k3P1seh+/FWYTMOFfiX7EPNmfK
        FxM1iU6CP8IKYrp9KAgTzyz2eDfDtEBJdY4O
X-Google-Smtp-Source: APBJJlHODVz+6Nlhm8leP1y2QQ0r/9vMz4ePXLV1d4C1w/r9evuqeLlIIxWmw82AmthN8vBia5FM4g==
X-Received: by 2002:adf:d08f:0:b0:317:6310:a616 with SMTP id y15-20020adfd08f000000b003176310a616mr6053018wrh.36.1691042991681;
        Wed, 02 Aug 2023 23:09:51 -0700 (PDT)
Received: from localhost.localdomain ([2a05:f480:1000:b09:5400:4ff:fe6f:7099])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d410a000000b00317495f88fasm20696122wrp.112.2023.08.02.23.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 23:09:51 -0700 (PDT)
From:   zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        djwong@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, starzhangzsd@gmail.com, stable@kernel.org,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v4] ext4: Fix rec_len verify error
Date:   Thu,  3 Aug 2023 14:09:38 +0800
Message-Id: <20230803060938.1929759-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Shida Zhang <zhangshida@kylinos.cn>

With the configuration PAGE_SIZE 64k and filesystem blocksize 64k,
a problem occurred when more than 13 million files were directly created
under a directory:

EXT4-fs error (device xx): ext4_dx_csum_set:492: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
EXT4-fs error (device xx): ext4_dx_csum_verify:463: inode #xxxx: comm xxxxx: dir seems corrupt?  Run e2fsck -D.
EXT4-fs error (device xx): dx_probe:856: inode #xxxx: block 8188: comm xxxxx: Directory index failed checksum

When enough files are created, the fake_dirent->reclen will be 0xffff.
it doesn't equal to the blocksize 65536, i.e. 0x10000.

But it is not the same condition when blocksize equals to 4k.
when enough files are created, the fake_dirent->reclen will be 0x1000.
it equals to the blocksize 4k, i.e. 0x1000.

The problem seems to be related to the limitation of the 16-bit field
when the blocksize is set to 64k.
To address this, helpers like ext4_rec_len_{from,to}_disk has already
been introduced to complete the conversion between the encoded and the
plain form of rec_len.

So fix this one by using the helper, and all the other in this file too.

Cc: stable@kernel.org
Fixes: dbe89444042a ("ext4: Calculate and verify checksums for htree nodes")
Suggested-by: Andreas Dilger <adilger@dilger.ca>
Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
v3->v4:
 1,Convert all the other rec_len, litrerally.
 2,Lift a helper output to a local variable.
 --Suggested by Darrick.
v2->v3:
 1,Convert all the other rec_len if necessary, as suggested by Darrick.
 2,Rephrase the commit message.
v1->v2:
 Use the existing helper to covert the rec_len, as suggested by Andreas.

 fs/ext4/namei.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 0caf6c730ce3..34fb2d1e66aa 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -343,17 +343,17 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 						   struct buffer_head *bh)
 {
 	struct ext4_dir_entry_tail *t;
+	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
 
 #ifdef PARANOID
 	struct ext4_dir_entry *d, *top;
 
 	d = (struct ext4_dir_entry *)bh->b_data;
 	top = (struct ext4_dir_entry *)(bh->b_data +
-		(EXT4_BLOCK_SIZE(inode->i_sb) -
-		 sizeof(struct ext4_dir_entry_tail)));
-	while (d < top && d->rec_len)
+		(blocksize - sizeof(struct ext4_dir_entry_tail)));
+	while (d < top && ext4_rec_len_from_disk(d->rec_len, blocksize))
 		d = (struct ext4_dir_entry *)(((void *)d) +
-		    le16_to_cpu(d->rec_len));
+		    ext4_rec_len_from_disk(d->rec_len, blocksize));
 
 	if (d != top)
 		return NULL;
@@ -364,7 +364,8 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 #endif
 
 	if (t->det_reserved_zero1 ||
-	    le16_to_cpu(t->det_rec_len) != sizeof(struct ext4_dir_entry_tail) ||
+	    (ext4_rec_len_from_disk(t->det_rec_len, blocksize) !=
+	     sizeof(struct ext4_dir_entry_tail)) ||
 	    t->det_reserved_zero2 ||
 	    t->det_reserved_ft != EXT4_FT_DIR_CSUM)
 		return NULL;
@@ -445,13 +446,14 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
 	struct ext4_dir_entry *dp;
 	struct dx_root_info *root;
 	int count_offset;
+	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
+	unsigned int rlen = ext4_rec_len_from_disk(dirent->rec_len, blocksize);
 
-	if (le16_to_cpu(dirent->rec_len) == EXT4_BLOCK_SIZE(inode->i_sb))
+	if (rlen == blocksize)
 		count_offset = 8;
-	else if (le16_to_cpu(dirent->rec_len) == 12) {
+	else if (rlen == 12) {
 		dp = (struct ext4_dir_entry *)(((void *)dirent) + 12);
-		if (le16_to_cpu(dp->rec_len) !=
-		    EXT4_BLOCK_SIZE(inode->i_sb) - 12)
+		if (ext4_rec_len_from_disk(dp->rec_len, blocksize) != blocksize - 12)
 			return NULL;
 		root = (struct dx_root_info *)(((void *)dp + 12));
 		if (root->reserved_zero ||
@@ -1315,6 +1317,7 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 	unsigned int buflen = bh->b_size;
 	char *base = bh->b_data;
 	struct dx_hash_info h = *hinfo;
+	int blocksize = EXT4_BLOCK_SIZE(dir->i_sb);
 
 	if (ext4_has_metadata_csum(dir->i_sb))
 		buflen -= sizeof(struct ext4_dir_entry_tail);
@@ -1335,11 +1338,12 @@ static int dx_make_map(struct inode *dir, struct buffer_head *bh,
 			map_tail--;
 			map_tail->hash = h.hash;
 			map_tail->offs = ((char *) de - base)>>2;
-			map_tail->size = le16_to_cpu(de->rec_len);
+			map_tail->size = ext4_rec_len_from_disk(de->rec_len,
+								blocksize);
 			count++;
 			cond_resched();
 		}
-		de = ext4_next_entry(de, dir->i_sb->s_blocksize);
+		de = ext4_next_entry(de, blocksize);
 	}
 	return count;
 }
-- 
2.27.0

