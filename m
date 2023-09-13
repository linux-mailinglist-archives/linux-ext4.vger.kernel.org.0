Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0446879DE1F
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Sep 2023 04:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbjIMCNa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Sep 2023 22:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbjIMCN3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Sep 2023 22:13:29 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970041710
        for <linux-ext4@vger.kernel.org>; Tue, 12 Sep 2023 19:13:25 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76ef653af2eso390798985a.0
        for <linux-ext4@vger.kernel.org>; Tue, 12 Sep 2023 19:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694571204; x=1695176004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2O0wUR99kIcLYDlgMOfLdyN5dqhwE9u0nGDy246A2Ds=;
        b=n6jLGtf9PGl1xOfUUDQg0l4SRPVMWhQ5tVpcmcwLaGoc1UYyPLeBg5V8SadPvGnCGX
         55pQLWtw6JzbLpUCEcBzVm163JI8G/VRm1//nHgi6SvjjhYVzG4wSslNj4yDD1NdQqgB
         ZlsL2px62U03nyql8nA9TPUayg/QgnSZ9TwdY0+a88Q5e8xEycud3ic81rPoXzvWnpzN
         na0Q1BrFIYrqipIYGBC9P2wxgY7zIyF4Xq/ULN6WQW3k0Ayg485xAX4tjTE2O+aYAIvs
         RXpKBRrmQj16n6gftvIq0NKpto/omoseuO40KUnaz0YRmUsSSp0juF4u8UWDLK1qpS5G
         +eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694571204; x=1695176004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2O0wUR99kIcLYDlgMOfLdyN5dqhwE9u0nGDy246A2Ds=;
        b=Us1+LBlmBJblWxKbfoAodcmgUTyzS7HBV8yalPqi+aIFSiEaihJUAUEppgdZJ61hUu
         oSv/n+HsrooFPvw/rm12I1B0SJYa32HuijYVtRnEp5ONXWdL+lXW5v8nvoT37WxhmseR
         w0g3JhoKulMytjHkcigcEGAyIZ9LQwIZ443C8li/Jcp1cM9bVtcZeLq89idwoV/eLC7G
         YpB5bunwEQu90jZP1Ir9067dtIEPN3Ja6KmvxZhxEZzgu9eFDhQzS/Q0g7hVgeqGqCuq
         gkqKuF+XUD+tZxHcVYAnbIvGccHNC2Dg/Aqpgi4ldSeqUQ0LHEkGZ/oclg1QVy/5mYyC
         u4Zw==
X-Gm-Message-State: AOJu0YzZr2/vlf3qSG6v8ZaQpqAtpU/n1XbU22y1iGJQX7RyoEMPdeQS
        fLHpY9bAESZB0+Nt6YynXAgvt3bsskc=
X-Google-Smtp-Source: AGHT+IFYuMRz2978/4/OCzZHO+BhNIBJjVlbdYXQlDzo7VtZiok9hGZdmhLkl4GPy0GDsLkFmGJrWA==
X-Received: by 2002:a05:622a:120c:b0:414:68a7:9d98 with SMTP id y12-20020a05622a120c00b0041468a79d98mr975266qtx.67.1694571204559;
        Tue, 12 Sep 2023 19:13:24 -0700 (PDT)
Received: from localhost.localdomain (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id c8-20020a0cf2c8000000b0064f778c8165sm4016055qvm.64.2023.09.12.19.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 19:13:24 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 4/6] ext4: consolidate partial cluster initialization
Date:   Tue, 12 Sep 2023 22:11:46 -0400
Message-Id: <20230913021148.1181646-5-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913021148.1181646-1-enwlinux@gmail.com>
References: <20230913021148.1181646-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Pull the code used to initialize a partial cluster into a single
location to improve readability and to minimize the disturbance on
other code.  Take advantage of the change to track partial clusters
in the logical space to use a more efficient means to search for a
block adjacent to the block range to be removed.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 70 +++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 45 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 793a9437be9f..a0c9e37ef804 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2641,17 +2641,6 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 
 		/* If this extent is beyond the end of the hole, skip it */
 		if (end < ex_ee_block) {
-			/*
-			 * We're going to skip this extent and move to another,
-			 * so note that its first cluster is in use to avoid
-			 * freeing it when removing blocks.  Eventually, the
-			 * right edge of the truncated/punched region will
-			 * be just to the left.
-			 */
-			if (sbi->s_cluster_ratio > 1) {
-				partial->lblk = ex_ee_block;
-				partial->state = keep;
-			}
 			ex--;
 			ex_ee_block = le32_to_cpu(ex->ee_block);
 			ex_ee_len = ext4_ext_get_actual_len(ex);
@@ -2812,10 +2801,6 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	handle_t *handle;
 	int i = 0, err = 0;
 
-	partial.pclu = 0;
-	partial.lblk = 0;
-	partial.state = none;
-
 	ext_debug(inode, "truncate since %u to %u\n", start, end);
 
 	/* probably first extent we're gonna free will be last in block */
@@ -2825,6 +2810,13 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
+	/* state never changes for non-bigalloc file systems */
+	partial.state = none;
+	if (sbi->s_cluster_ratio > 1) {
+		partial.start_lclu = EXT4_B2C(sbi, start);
+		partial.end_lclu = EXT4_B2C(sbi, end);
+	}
+
 again:
 	trace_ext4_ext_remove_space(inode, start, end, depth);
 
@@ -2838,7 +2830,6 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	if (end < EXT_MAX_BLOCKS - 1) {
 		struct ext4_extent *ex;
 		ext4_lblk_t ee_block, ex_end, lblk;
-		ext4_fsblk_t pblk;
 
 		/* find extent for or closest extent to this block */
 		path = ext4_find_extent(inode, end, NULL,
@@ -2871,16 +2862,6 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		 */
 		if (end >= ee_block && end < ex_end) {
 
-			/*
-			 * If we're going to split the extent, note that
-			 * the cluster containing the block after 'end' is
-			 * in use to avoid freeing it when removing blocks.
-			 */
-			if (sbi->s_cluster_ratio > 1) {
-				partial.lblk = end + 1;
-				partial.state = keep;
-			}
-
 			/*
 			 * Split the extent in two so that 'end' is the last
 			 * block in the first new extent. Also we should not
@@ -2891,27 +2872,26 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 							 end + 1, 1);
 			if (err < 0)
 				goto out;
+		}
 
-		} else if (sbi->s_cluster_ratio > 1 && end >= ex_end &&
-			   partial.state == none) {
-			/*
-			 * If we're punching, there's an extent to the right.
-			 * If the partial cluster hasn't been set, set it to
-			 * that extent's first cluster and its state to keep
-			 * so it won't be freed should it contain blocks to be
-			 * removed. If it's already set (free/keep), we're
-			 * retrying and keep the original partial cluster info
-			 * so a cluster marked free as a result of earlier
-			 * extent removal is not lost.
-			 */
-			lblk = ex_end + 1;
-			err = ext4_ext_search_right(inode, path, &lblk, &pblk,
-						    NULL);
-			if (err < 0)
-				goto out;
-			if (pblk) {
-				partial.lblk = lblk;
+		/*
+		 * if there's a block following the space to be removed
+		 * in a bigalloc file system note that the cluster
+		 * containing it must not be freed
+		 */
+		if (sbi->s_cluster_ratio > 1 && partial.state == none) {
+			if (end < ee_block) {
+				partial.lblk = ee_block;
 				partial.state = keep;
+			} else if (end >= ee_block && end < ex_end) {
+				partial.lblk = end + 1;
+				partial.state = keep;
+			} else if (end >= ex_end) {
+				lblk = ext4_ext_next_allocated_block(path);
+				if (lblk != EXT_MAX_BLOCKS) {
+					partial.lblk = lblk;
+					partial.state = keep;
+				}
 			}
 		}
 	}
-- 
2.30.2

