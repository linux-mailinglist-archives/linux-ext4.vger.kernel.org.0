Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E22176B328
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Aug 2023 13:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjHALYu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Aug 2023 07:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjHALYf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Aug 2023 07:24:35 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9C030C3;
        Tue,  1 Aug 2023 04:23:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so5645703f8f.2;
        Tue, 01 Aug 2023 04:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690889027; x=1691493827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JzuvX8nrDgu3p59eH/CPjuD13fIyIhDExg7YHy1dySc=;
        b=d88ck4a7LpwLdgRs0IzlvumxIxxohvXskExbsLC032RsWPH12wSmfwbhXI7VKBj8Vv
         gzTa/HUicdQmyNVwMHUx60rI2t3kcJH5jInceXk9rch/cyxVlwdyy7dW9YdUG1JmchzM
         IDGiKB+mHAFLirNotkpFTkwHpL2hKN4Yw9mPimaatKAd6B69r82G+tHyvDwstEgZCjBk
         cCXmE6+U15kHRXwaszggJtOk+ag8pQ4kIypr2xIdPX9+JCL+njPduFpVMsPZdJTYDuF0
         UQLpCUszNj54CgBtZlq45xALyDHeRLoDh7fF0la5IFbPEIr48mCjnMfNLghhlSYAw6b0
         uDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889027; x=1691493827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzuvX8nrDgu3p59eH/CPjuD13fIyIhDExg7YHy1dySc=;
        b=Jc7ewVjBvgzYB/t4kBtt0JAkgUlJ+qHarENrKuld1iRnh4Rl5u7f/0BTCuslR9fXYn
         4X757U0kQ1s0yBgTRP3RhSxvQJDMHguylHjPBfRzChvkc7o1O0kMz4uh3DlPLL7bzlID
         8kr9Uvb+QqKoip5xTKCnoLHoFTAr6hsyp91/2ulxpojYJlR+hx0ebQXs6ZBFtGz5qM2B
         j4aavJ0CMMqYpx7sqt0dH4u5Yrl/RayHn2B+xXTWsSWc75QqXudzq51WRx3LrofxJgxX
         0j5GkrCDrR9MEYctE3B+ECecvF5tb+K2RECaT419MYzU62qDAMAPXW/1CEh35vyT7/e7
         ix5g==
X-Gm-Message-State: ABy/qLa5InsaWjnFGj+cJ9TFjuTHn5eqHppPjz3is2tBdkFKt00ZFyQ+
        prq65YhwqM8lDR1fhs7Hems=
X-Google-Smtp-Source: APBJJlE/gU+VcaIACvW5XBv61cODLtzPMg8nSfWaHRLura/zERpjtLo6eGJo9iOFgtqrxXlCMmhYqw==
X-Received: by 2002:a5d:6a82:0:b0:317:5ba8:ac6 with SMTP id s2-20020a5d6a82000000b003175ba80ac6mr2090898wru.8.1690889026495;
        Tue, 01 Aug 2023 04:23:46 -0700 (PDT)
Received: from localhost.localdomain ([2a05:f480:1000:b09:5400:4ff:fe6f:7099])
        by smtp.gmail.com with ESMTPSA id s7-20020adff807000000b00313e2abfb8dsm15785015wrp.92.2023.08.01.04.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:23:46 -0700 (PDT)
From:   zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        djwong@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, starzhangzsd@gmail.com, stable@kernel.org,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v3] ext4: Fix rec_len verify error
Date:   Tue,  1 Aug 2023 19:23:37 +0800
Message-Id: <20230801112337.1856215-1-zhangshida@kylinos.cn>
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
been introduce to complete the conversion between the encoded and the
plain form of rec_len.

So fix this one by using the helper, and all the other
le16_to_cpu(ext4_dir_entry{,_2}.rec_len) accesses in this file too.

Cc: stable@kernel.org
Fixes: dbe89444042a ("ext4: Calculate and verify checksums for htree nodes")
Suggested-by: Andreas Dilger <adilger@dilger.ca>
Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
v1->v2:
 Use the existing helper to covert the rec_len, as suggested by Andreas.
v2->v3:
 1,Covert all the other rec_len if necessary, as suggested by Darrick.
 2,Rephrase the commit message.

 fs/ext4/namei.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 0caf6c730ce3..8cb377b8ad86 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -346,14 +346,14 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 
 #ifdef PARANOID
 	struct ext4_dir_entry *d, *top;
+	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
 
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
@@ -445,13 +445,13 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
 	struct ext4_dir_entry *dp;
 	struct dx_root_info *root;
 	int count_offset;
+	int blocksize = EXT4_BLOCK_SIZE(inode->i_sb);
 
-	if (le16_to_cpu(dirent->rec_len) == EXT4_BLOCK_SIZE(inode->i_sb))
+	if (ext4_rec_len_from_disk(dirent->rec_len, blocksize) == blocksize)
 		count_offset = 8;
-	else if (le16_to_cpu(dirent->rec_len) == 12) {
+	else if (ext4_rec_len_from_disk(dirent->rec_len, blocksize) == 12) {
 		dp = (struct ext4_dir_entry *)(((void *)dirent) + 12);
-		if (le16_to_cpu(dp->rec_len) !=
-		    EXT4_BLOCK_SIZE(inode->i_sb) - 12)
+		if (ext4_rec_len_from_disk(dp->rec_len, blocksize) != blocksize - 12)
 			return NULL;
 		root = (struct dx_root_info *)(((void *)dp + 12));
 		if (root->reserved_zero ||
-- 
2.27.0

