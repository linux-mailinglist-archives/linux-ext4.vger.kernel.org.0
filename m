Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4836E99EC
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Apr 2023 18:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjDTQvj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Apr 2023 12:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDTQvj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Apr 2023 12:51:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2831B269E;
        Thu, 20 Apr 2023 09:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA02E64AB8;
        Thu, 20 Apr 2023 16:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1979C433EF;
        Thu, 20 Apr 2023 16:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682009497;
        bh=gHK+hdAcuU5ofvzwMj41uJvVD9wpUSxv26wdE+c3IuU=;
        h=From:Date:Subject:To:Cc:From;
        b=GO5P+rmHlfogAbiSBl3cKO8jDfIt5axbZnaMRRSO4ab0xkSfhyRNhPp9tEnbHuz/O
         mnLadyGrasIuaUbVUEIbmroW4i36UP3sA5VmDs29X4WDhwBo2gi4oqKmgyS5xHmFlE
         oyrRQcwlcFs9MWJ5kAhNC/MixlG+wsqW9m+GRg1DP7rBsuTl/LDYLCaBDl+LSJzVdh
         8nn/B5U/nfDjhukSTZ5Ze05NBuK2ufeTCK/DZxcdR/Qdn0UkDkxwCrv/UV/4Izpi2Y
         GOB9N0+2WyngOimR0of44o2Fi0z6QuBEOrAjih982Oy+tA/BfTmuvUOMgo79q+qp97
         ZRPtpZjlz4TNg==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Thu, 20 Apr 2023 09:51:24 -0700
Subject: [PATCH] ext4: Fix unused iterator variable warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230420-ext4-unused-variables-super-c-v1-1-138b6db6c21c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIttQWQC/x2N0QqDMAwAf0XyvECtCtt+ZewhbbMZ2DpJrAjiv
 1v3eBzcbWCswgb3ZgPlRUx+uUJ7aSCOlN+MkiqDd75zvXfI69xjycU44UIqFD5saGVixYiRQqJ
 huKZb10JtBDLGoJTjeFa+ZDPrKSbll6z/8eO57wezizuTiAAAAA==
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     yanaijie@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2345; i=nathan@kernel.org;
 h=from:subject:message-id; bh=gHK+hdAcuU5ofvzwMj41uJvVD9wpUSxv26wdE+c3IuU=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDCmOuTOCVX+4fv8vFsNXdagsOFJug8aEY98i1sns/7XXY
 UHzsUvHO0pZGMQ4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEpK8y/OG/evHBis/HeMKk
 FwvZbdpTe/niX/OIRbUJknmly3QkmV8z/C/58COjZZKdSuVzUTXFpZESu65xJQQ2MUufMeb+JdZ
 5mRsA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When CONFIG_QUOTA is disabled, there are warnings around unused iterator
variables:

  fs/ext4/super.c: In function 'ext4_put_super':
  fs/ext4/super.c:1262:13: error: unused variable 'i' [-Werror=unused-variable]
   1262 |         int i, err;
        |             ^
  fs/ext4/super.c: In function '__ext4_fill_super':
  fs/ext4/super.c:5200:22: error: unused variable 'i' [-Werror=unused-variable]
   5200 |         unsigned int i;
        |                      ^
  cc1: all warnings being treated as errors

The kernel has updated to gnu11, allowing the variables to be declared
within the for loop. Do so to clear up the warnings.

Fixes: dcbf87589d90 ("ext4: factor out ext4_flex_groups_free()")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/ext4/super.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 403cc0e6cd65..f16492b8c98d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1259,7 +1259,7 @@ static void ext4_put_super(struct super_block *sb)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
 	int aborted = 0;
-	int i, err;
+	int err;
 
 	/*
 	 * Unregister sysfs before destroying jbd2 journal.
@@ -1311,7 +1311,7 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_flex_groups_free(sbi);
 	ext4_percpu_param_destroy(sbi);
 #ifdef CONFIG_QUOTA
-	for (i = 0; i < EXT4_MAXQUOTAS; i++)
+	for (int i = 0; i < EXT4_MAXQUOTAS; i++)
 		kfree(get_qf_name(sb, sbi, i));
 #endif
 
@@ -5197,7 +5197,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	ext4_fsblk_t logical_sb_block;
 	struct inode *root;
 	int ret = -ENOMEM;
-	unsigned int i;
 	int needs_recovery;
 	int err = 0;
 	ext4_group_t first_not_zeroed;
@@ -5628,7 +5627,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 #endif
 
 #ifdef CONFIG_QUOTA
-	for (i = 0; i < EXT4_MAXQUOTAS; i++)
+	for (unsigned int i = 0; i < EXT4_MAXQUOTAS; i++)
 		kfree(get_qf_name(sb, sbi, i));
 #endif
 	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);

---
base-commit: 519fe1bae7e20fc4e7f179d50b6102b49980e85d
change-id: 20230420-ext4-unused-variables-super-c-cabda558d931

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

