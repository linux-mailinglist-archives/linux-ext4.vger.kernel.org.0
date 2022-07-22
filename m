Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF15957E491
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 18:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiGVQja (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 12:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiGVQj3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 12:39:29 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806B9B9C0
        for <linux-ext4@vger.kernel.org>; Fri, 22 Jul 2022 09:39:27 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id x11so3863847qts.13
        for <linux-ext4@vger.kernel.org>; Fri, 22 Jul 2022 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0xyH2Btcw09LVU+KQxZsQe+QaaDekFxbJ6vmO4/Ps7U=;
        b=MGv9XI/eSUpqpy2XFwP8TMsSTkpX30J3MkDD37TobMx2YbPmsJIwD4vRPi0QDMxmYw
         c5tnb48hmFZSC7mYi2ErwQ5PDXn27hovMVr+e5aQLAr6Cx7os3vEu+2OesTEXUycpRNG
         WQWo7JtFlpWVW+w9s/GUwMF6s3v/rxU8rizBR/eTB09kuVi30SVhgajzw2e3nl0XpFM0
         9CoN72F0La3uEZ1dcTDnKhOlji8Iqwk+U6GXiq2n2oyINtGp9LJ2uS+uOZZj4jAQy7/h
         Te4r6hXGfNIjqd2SLeXKwqqPR39MPhH3f1Cz/9UyUi6dnRvf4nVp9ljrYt3IfJfq/YEA
         75Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0xyH2Btcw09LVU+KQxZsQe+QaaDekFxbJ6vmO4/Ps7U=;
        b=wy9+EwqUpLXnqz1B9TLdFkxsByss0Fh0PqmME8Ze4Gdaa+/Lsx229ixRrj8zFCtL8T
         Zw7D7JHaU1IiRHEPzIgMlP71Qiq2CD2BZavnhPNRpWbkNgoowyogYWRl2ZF7mvB1vO2Y
         UtGA+kfIHKLDWe0VisbCbW8f6TJuf/grdA8zv2MX5/VKYmJaHZ84kEP7Qz6lgndvJFCt
         hlAuuq4e61rtecifS2Zry+zWPr+j9JE8S9B0p1EHn8jTduN5ZZHBM6k0r3JErG3WQ3dg
         vEJJPf4XAP8d0B/tHO75fN2CbMID0g9pFikdaM5Xsz2zb5fHV6c6yXfRMkKDWSpNlv93
         /vuA==
X-Gm-Message-State: AJIora+Fj2SnbzeDDRoPWMdHlQyQvbFJnhKzLDktQudEVo6KK663r+RY
        uHc6VYBumQ7WcM/aN+RT6qL2YW1hSNQ=
X-Google-Smtp-Source: AGRyM1t6Z8sVPT++rFuTeeN9E4Y13PD5wmZ/X05R/7XTL8M0d7y5BWxmnksjdev/atKyXuTBAribxQ==
X-Received: by 2002:ac8:7f51:0:b0:31e:9c04:6a0 with SMTP id g17-20020ac87f51000000b0031e9c0406a0mr844881qtk.514.1658507966858;
        Fri, 22 Jul 2022 09:39:26 -0700 (PDT)
Received: from localhost.localdomain (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id q20-20020a37f714000000b006b5e60c4de1sm3566361qkj.78.2022.07.22.09.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 09:39:26 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH v2] ext4: minor defrag code improvements
Date:   Fri, 22 Jul 2022 12:39:10 -0400
Message-Id: <20220722163910.268564-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Modify the error returns for two file types that can't be defragged to
more clearly communicate those restrictions to a caller.  When the
defrag code is applied to swap files, return -ETXTBSY, and when applied
to quota files, return -EOPNOTSUPP.  Move an extent tree search whose
results are only occasionally required to the site always requiring them
for improved efficiency.  Address a few typos.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/move_extent.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 701f1d6a217f..2b83621d16e2 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -472,19 +472,17 @@ mext_check_arguments(struct inode *orig_inode,
 	if (IS_IMMUTABLE(donor_inode) || IS_APPEND(donor_inode))
 		return -EPERM;
 
-	/* Ext4 move extent does not support swapfile */
+	/* Ext4 move extent does not support swap files */
 	if (IS_SWAPFILE(orig_inode) || IS_SWAPFILE(donor_inode)) {
-		ext4_debug("ext4 move extent: The argument files should "
-			"not be swapfile [ino:orig %lu, donor %lu]\n",
+		ext4_debug("ext4 move extent: The argument files should not be swap files [ino:orig %lu, donor %lu]\n",
 			orig_inode->i_ino, donor_inode->i_ino);
-		return -EBUSY;
+		return -ETXTBSY;
 	}
 
 	if (ext4_is_quota_file(orig_inode) && ext4_is_quota_file(donor_inode)) {
-		ext4_debug("ext4 move extent: The argument files should "
-			"not be quota files [ino:orig %lu, donor %lu]\n",
+		ext4_debug("ext4 move extent: The argument files should not be quota files [ino:orig %lu, donor %lu]\n",
 			orig_inode->i_ino, donor_inode->i_ino);
-		return -EBUSY;
+		return -EOPNOTSUPP;
 	}
 
 	/* Ext4 move extent supports only extent based file */
@@ -631,11 +629,11 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		if (ret)
 			goto out;
 		ex = path[path->p_depth].p_ext;
-		next_blk = ext4_ext_next_allocated_block(path);
 		cur_blk = le32_to_cpu(ex->ee_block);
 		cur_len = ext4_ext_get_actual_len(ex);
 		/* Check hole before the start pos */
 		if (cur_blk + cur_len - 1 < o_start) {
+			next_blk = ext4_ext_next_allocated_block(path);
 			if (next_blk == EXT_MAX_BLOCKS) {
 				ret = -ENODATA;
 				goto out;
@@ -663,7 +661,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		donor_page_index = d_start >> (PAGE_SHIFT -
 					       donor_inode->i_blkbits);
 		offset_in_page = o_start % blocks_per_page;
-		if (cur_len > blocks_per_page- offset_in_page)
+		if (cur_len > blocks_per_page - offset_in_page)
 			cur_len = blocks_per_page - offset_in_page;
 		/*
 		 * Up semaphore to avoid following problems:
-- 
2.30.2

