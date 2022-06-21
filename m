Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCBA553495
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jun 2022 16:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351781AbiFUOdx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jun 2022 10:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbiFUOdw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jun 2022 10:33:52 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F662ACE
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jun 2022 07:33:51 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id g18so13098472qvn.2
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jun 2022 07:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jmnYNLE6NFFYvrJvzomWniS3XYbuasULLaAypVkik50=;
        b=q4fMGrFq/NzkI/mrbiloOuUKYpkyxbztgYGu/RGhJTRsG/WoXoovnyD1vlbS9v+37L
         cahCU4NuxhUbWcDfQ6y3EMEUBfuX9uHbC/KQb/4IfKXldBCcFLSElfsjfJID7cDV3AHq
         pp+TSUm6WLJh66BYPsmKVqXEymvhKH5/qRyK8dLHd1a4dK1QtObqFH8mFCLXSm9aGLeZ
         JDB3WbJp0G/V/DCLArmj6XjI6dyRzNJTo1ySFoptZ1jTWi2ijspsorg9PuOQz/8VqzUi
         dVlpNAXdcW9Q9cizJQpI40mdvKP7+TrzDVPMbhZFDJU1zt6q8U7RbQxqwq3ttw5GhWPG
         cm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jmnYNLE6NFFYvrJvzomWniS3XYbuasULLaAypVkik50=;
        b=J2MMYL13VHj8gp9DG+APr3TVaatfwsfFVDb4HiGDmZ34Um6lWCGqUZ3E9CZ/dKL3sZ
         kErwLU+TnoxgBqP202Sah2O6pFfTjs4TPBLdBtVnDMT8D0Y2gh12pxCNR1tNNBuhOoL/
         ZTx4VkJnm6d8HcC3wjDW7/EYk5usPtkl22RqvlXahUAt01u468VRFhbuOgUJFpvYbXrP
         9siP6d0lbUv+9L+k0RzyXSKE/bsjMLCUV5YZrL5eKba7yqnq7CObgXmdmYCdMFw0Wnv3
         cL0+7hWT4YVQNRXUZLJ8oJ0LlJOa9iPdMHKH4Qdsc7llFbuhzsOSA9z2t99PqycSkzz7
         ltxA==
X-Gm-Message-State: AJIora9TLYs02OInU46AQ8YmzueXjs5n/D5kSJ3xegNfGN/sMMf/roPR
        kllfLsGsaDzvMVlxfZNcz9yGLc92lJfyjw==
X-Google-Smtp-Source: AGRyM1ubQbfd5EjnN1DI1ILYaWM1BtfgWJ9XtjoCkTWPWxwA037l+lpnmYgwDJWVDLJRm8M/7nzL0A==
X-Received: by 2002:ac8:570d:0:b0:305:2546:a668 with SMTP id 13-20020ac8570d000000b003052546a668mr24708556qtw.204.1655822030383;
        Tue, 21 Jun 2022 07:33:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id y9-20020a05620a25c900b006ab93e0e053sm10738797qko.30.2022.06.21.07.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 07:33:49 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: minor defrag code improvements
Date:   Tue, 21 Jun 2022 10:33:40 -0400
Message-Id: <20220621143340.2268087-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Modify two error paths returning EBUSY for bad argument file types to
return EOPNOTSUPP instead.  Move an extent tree search whose results are
only occasionally required to the site always requiring them for
improved efficiency.  Address a few typos.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/move_extent.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 701f1d6a217f..4e4b0452106e 100644
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
+		return -EOPNOTSUPP;
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

