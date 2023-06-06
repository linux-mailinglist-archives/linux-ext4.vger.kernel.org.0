Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81678723910
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 09:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbjFFHcP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 03:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbjFFHcN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 03:32:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D446E11A;
        Tue,  6 Jun 2023 00:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68DEC62CB9;
        Tue,  6 Jun 2023 07:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2644FC433EF;
        Tue,  6 Jun 2023 07:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686036731;
        bh=Ak0j0Hr5s4dVlzG32KaXySxXdetfo8cIUB4kqJq07T4=;
        h=From:To:Cc:Subject:Date:From;
        b=L1KDGLqVhGh+sVvUI3ToDKAxdVULNnFXTvV3964C9ha3o5I1TeW1XCjyfgMd8J3ws
         pxhfQRkKWRdwUnAR+kC2KXathXAHPKwvuX/WwwLQPHv9eqNloTqKJVQABzITZSIUFN
         MGGa1LK4qUzA9RDzUVpGr8W9YIgF33mOgLtxwfT4y68r/YryJ6d3v8u2Xk9qag/1up
         8Boecj0X0M4nZXMxMqF+jYcXOcFsUFAHs1zW67Yxhg3pBFmA4tEgbg/D4SdhwAJO8c
         3JuH0kEblnlLPo5mQ30719Xryv0/vqp/UEynYcnttSDDCY7jPRy6t//Q6wp+sjqg/i
         qZGutlyXFpO9w==
From:   Chao Yu <chao@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chao Yu <chao@kernel.org>
Subject: [PATCH] ext4: fix to check return value of freeze_bdev() in ext4_shutdown()
Date:   Tue,  6 Jun 2023 15:32:03 +0800
Message-Id: <20230606073203.1310389-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

freeze_bdev() can fail due to a lot of reasons, it needs to check its
reason before later process.

Fixes: 783d94854499 ("ext4: add EXT4_IOC_GOINGDOWN ioctl")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/ext4/ioctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f9a430152063..55be1b8a6360 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -797,6 +797,7 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	__u32 flags;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -815,7 +816,9 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 
 	switch (flags) {
 	case EXT4_GOING_FLAGS_DEFAULT:
-		freeze_bdev(sb->s_bdev);
+		ret = freeze_bdev(sb->s_bdev);
+		if (ret)
+			return ret;
 		set_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
 		thaw_bdev(sb->s_bdev);
 		break;
-- 
2.40.1

