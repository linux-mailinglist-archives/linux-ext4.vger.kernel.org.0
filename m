Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED855D73B
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jun 2022 15:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbiF1De5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jun 2022 23:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbiF1Dez (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jun 2022 23:34:55 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAB624BE0
        for <linux-ext4@vger.kernel.org>; Mon, 27 Jun 2022 20:34:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c65so15693171edf.4
        for <linux-ext4@vger.kernel.org>; Mon, 27 Jun 2022 20:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xb24r3nJqBSEZy5Ox7MTfh1+7sVIGK/NzO9s7+gURT4=;
        b=d1r/z5PgQtPaMX0P5+OKg4I/1y+dHq3GvWPHMnfkNkK4GlLHYGuuovSYr4oW4pz4kJ
         IF5fTPtg/AfVYd5u0vW9PQspNHVmFunu2FRTWLgGI4e2YjF8u5faYo2RFTVJFyDX4TrQ
         dDAoz0H6Y0HlcB+KqbF3VqMYd9GYN864RrbApHz6igLCi4gfNq6yoESEWF73tRTcgqCi
         E8iIAxFM6Pfvsxuc3awHW7MSysKR1j8NC/xEvHBM0XGUitlJR/62O5/O4rDnst/8cOCt
         p4VVDxtUNL9DhxxBC8Uaei7eTnXPU4f6M5KuRRRYhfjCVyaoB8fNZSwc1IsRIwcOcAWk
         FdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xb24r3nJqBSEZy5Ox7MTfh1+7sVIGK/NzO9s7+gURT4=;
        b=o+3x2JI6tIgH/DGIpTpabvBQMS21P8iI3b7anJbD8gb0eAiTevs541QhpRJtqqdCS4
         7dajtNyVukGRCZLHaH3KI8DywdRcSQ4jhuPM01evt+Rz1hVjKmuVoNpFMSES5ppkTL0J
         nFNp8RNfxVwghRXEzbCzyOwtdVzDhMFp/1CX3JLIRA6NxSCnwNN2jb3Zg2ftZFy7bcXm
         GlwcL0P68KWLAU6dCb8fWwG+zJY6C2BdBjTSnCyIbPqrbSR6u8wHb2Ln9zUDvBpK/6mK
         dkcWlSPeXnUjJCw6gWpCTVo5BTfVsxgiIMeEk9rQKBGA//Lp10KyHxKUQPl0jP5lvpUf
         NhQQ==
X-Gm-Message-State: AJIora9dRH/PCdF1u5UReJZtxsat8Ikm3KtDkxa+Un8LNEbiHg1AdI1j
        8A54OAD0huwg6LU2drvwpv8dJD18ygM=
X-Google-Smtp-Source: AGRyM1vh1TZnAGDPgrgeVFS4zxLAW6XGbUW/qOMW9XJer7CcrpHVqku5zgzjZdKwYsKVeJ6d9DclYQ==
X-Received: by 2002:aa7:dac2:0:b0:435:76a2:4ebe with SMTP id x2-20020aa7dac2000000b0043576a24ebemr20795724eds.196.1656387290754;
        Mon, 27 Jun 2022 20:34:50 -0700 (PDT)
Received: from ARKON.codeweavers.com (ip5f5bc493.dynamic.kabel-deutschland.de. [95.91.196.147])
        by smtp.gmail.com with ESMTPSA id h26-20020aa7c61a000000b00435cfa7c6f5sm8524090edq.46.2022.06.27.20.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 20:34:50 -0700 (PDT)
From:   Torge Matthies <openglfreak@googlemail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Torge Matthies <openglfreak@googlemail.com>
Subject: [PATCH] ext4: Read inlined symlink targets using ext4_readpage_inline.
Date:   Tue, 28 Jun 2022 05:34:46 +0200
Message-Id: <20220628033446.285207-1-openglfreak@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Instead of using ext4_bread/ext4_getblk.

When I was trying out Linux 5.19-rc3 some symlinks became inaccessible to
me, with the error "Structure needs cleaning" and the following printed in
the kernel message log:

EXT4-fs error (device nvme0n1p1): ext4_map_blocks:599: inode #7351350:
block 774843950: comm readlink: lblock 0 mapped to illegal pblock
774843950 (length 1)

It looks like the ext4_get_link function introduced in commit 6493792d3299
("ext4: convert symlink external data block mapping to bdev") does not
handle links with inline data correctly. I added explicit handling for this
case using ext4_readpage_inline. This fixes the bug and the affected
symlinks become accessible again.

Fixes: 6493792d3299 ("ext4: convert symlink external data block mapping to bdev")
Signed-off-by: Torge Matthies <openglfreak@googlemail.com>
---
 fs/ext4/symlink.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index d281f5bcc526..ec4fc2d23efc 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -19,7 +19,10 @@
  */
 
 #include <linux/fs.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
 #include <linux/namei.h>
+#include <linux/pagemap.h>
 #include "ext4.h"
 #include "xattr.h"
 
@@ -65,6 +68,37 @@ static int ext4_encrypted_symlink_getattr(struct user_namespace *mnt_userns,
 	return fscrypt_symlink_getattr(path, stat);
 }
 
+static void ext4_free_link_inline(void *folio)
+{
+	folio_unlock(folio);
+	folio_put(folio);
+}
+
+static const char *ext4_get_link_inline(struct inode *inode,
+					struct delayed_call *callback)
+{
+	struct folio *folio;
+	char *ret;
+	int err;
+
+	folio = folio_alloc(GFP_NOFS, 0);
+	if (!folio)
+		return ERR_PTR(-ENOMEM);
+	folio_lock(folio);
+	folio->index = 0;
+
+	err = ext4_readpage_inline(inode, &folio->page);
+	if (err) {
+		folio_put(folio);
+		return ERR_PTR(err);
+	}
+
+	set_delayed_call(callback, ext4_free_link_inline, folio);
+	ret = folio_address(folio);
+	nd_terminate_link(ret, inode->i_size, inode->i_sb->s_blocksize - 1);
+	return ret;
+}
+
 static void ext4_free_link(void *bh)
 {
 	brelse(bh);
@@ -75,6 +109,9 @@ static const char *ext4_get_link(struct dentry *dentry, struct inode *inode,
 {
 	struct buffer_head *bh;
 
+	if (ext4_has_inline_data(inode))
+		return ext4_get_link_inline(inode, callback);
+
 	if (!dentry) {
 		bh = ext4_getblk(NULL, inode, 0, EXT4_GET_BLOCKS_CACHED_NOWAIT);
 		if (IS_ERR(bh))
-- 
2.36.1

