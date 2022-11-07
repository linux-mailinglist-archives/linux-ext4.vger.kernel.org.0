Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5787D61F327
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiKGM1t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiKGM1r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:27:47 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B2B1AD9C
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:27:47 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b11so10421483pjp.2
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRf7GG49fBpc8qWJATB6Z8IF0kB25ctC/s18amrBQPo=;
        b=k5L+/hzob9boPoutckNo9yYIyy5p/VzyWQ0QyRYbRxmp1GMvqlpOeUREwBTFGYQYb3
         60Rn0ijW/HTLYTPTFxGYBmb0DeLY3pFO6aFfqkedCZotXxp8PTtUa1N4y49Jd4u9unu8
         Qtiy/zEM7kj8zdWE+Kwkjf9hG1w7usJzEVcSSnrJ6tqV2KoH7KNLISh0w1zWAPs7IQqB
         7dVHRptcKSbci91yTvba0fnr/n7bAR91wSHi7nrLvRNwm7ilcdu3uuTp7iQsVTEAxjV0
         Opx1sbFiv2siRw8jQu16scqZ9PC4eOxiS1PnAQRt9WZjadXPYIQBCfAgw1v7it2qTT6O
         aMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRf7GG49fBpc8qWJATB6Z8IF0kB25ctC/s18amrBQPo=;
        b=e6v+uOD67jJq3HzVfKk38RlTTRb2J+pD50KXgCzGVxSVKq6krxIoij+k/shEz6I46B
         YU9BMMVf19yLEsyFhIZXjoq+REyUMHsgvH7+6MbT337uB7Z94gRNQYZEI5C2cB1Q/AL3
         boMm6tSmdR6INTv15JYYndR02tBeNsKkcXToNGxLDAKNqtomljjgF21o0A3Bj1umFoab
         rX2tKDWWkwnvjEGKn9D1L2iKQ5WByz1gHllU2VGpItG5qRiMTRwQCEIzvMntIOXNGbd9
         hw+35I8tZx6DmKNzjmFHYhgeUef+9fWzQsjq2KmXDUNMDSPsoz2Cej8Icv4rFZ9LeJiC
         TtPw==
X-Gm-Message-State: ACrzQf2EDuabGBUTtAmAKt+ZBhOF6bHbyhVvcHLSqQ5WU+J9C0/+Cs3E
        6jhLgR7h5b5IQcUA2JCEZBo=
X-Google-Smtp-Source: AMsMyM5XmP2rjf9Ysg8zWeBwdd32hp4Ojv7a5Rb4x/5WT5jYWr64luk7YZRKCtkqAG32af9JYPWFBA==
X-Received: by 2002:a17:90b:1c8c:b0:203:89fb:ba79 with SMTP id oo12-20020a17090b1c8c00b0020389fbba79mr68670812pjb.92.1667824066759;
        Mon, 07 Nov 2022 04:27:46 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b0017f73dc1549sm4859348plf.263.2022.11.07.04.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:27:46 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 53/72] e2fsck: merge extent depth count after threads finish
Date:   Mon,  7 Nov 2022 17:51:41 +0530
Message-Id: <6a4a5461ba2ca87b7bf1ac6923663d41e3d11677.1667822611.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
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

From: Wang Shilong <wshilong@ddn.com>

tests covered by f_extent_htree.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 1a5fcf66..c89c424d 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2866,8 +2866,11 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_refcount_t ea_inode_refs = global_ctx->ea_inode_refs;
 	ext2fs_block_bitmap  block_found_map = global_ctx->block_found_map;
 	ext2fs_block_bitmap  block_dup_map = global_ctx->block_dup_map;
-	int options = global_ctx->options;
+	int options = global_ctx->options, i;
+	__u32 extent_depth_count[MAX_EXTENT_DEPTH_COUNT];
 
+	memcpy(extent_depth_count, global_ctx->extent_depth_count,
+	       sizeof(extent_depth_count));
 #ifdef HAVE_SETJMP_H
 	jmp_buf old_jmp;
 
@@ -2930,6 +2933,12 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	 * later passes will recalculate it if necessary
 	 */
 	global_ctx->lost_and_found = 0;
+	memcpy(global_ctx->extent_depth_count, extent_depth_count,
+	       sizeof(extent_depth_count));
+	/* merge extent depth count */
+	for (i = 0; i < MAX_EXTENT_DEPTH_COUNT; i++)
+		global_ctx->extent_depth_count[i] +=
+			thread_ctx->extent_depth_count[i];
 
 	global_fs->priv_data = global_ctx;
 	global_ctx->fs = global_fs;
-- 
2.37.3

