Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE8379DE1E
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Sep 2023 04:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjIMCN0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Sep 2023 22:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238133AbjIMCNZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Sep 2023 22:13:25 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F0B1717
        for <linux-ext4@vger.kernel.org>; Tue, 12 Sep 2023 19:13:21 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-649edb3a3d6so2279616d6.0
        for <linux-ext4@vger.kernel.org>; Tue, 12 Sep 2023 19:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694571200; x=1695176000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Oyb6Mn6tAyzQQME3t/nnUmCfV5ouVQNGzBM23Djs2I=;
        b=S5oEirafj+jZxprCKXWgsHMup/tvAUbblkGIbWFk/fdB3D6ja3nRCs294Ryw7ZPbYB
         eBYzPKE5L3X2QrszX9v1ljlxHIZMvr7QoGixhV4hSXn73rar3Fo8Ew3ddHUxFRKvXtF+
         fXZG5HP4xPrBbDBjOSpOVsDsdNoQZO4wCpaEw5+Gg0/bh3XX6Atc1BuysUQnfmKsNyQg
         eihU9sUDQwgfl/Z9TsX6pJ1/yoTRnItKfQBZGs+4jviaa8zyoF7uB6hZ6Lwwb4Stln/2
         Cdxd5FjcmMg+dhzhNnSSZOkZCApl3cDp39lo5BzBajvfdAiHQXfYdCPFwliIT2mrO8Pp
         j5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694571200; x=1695176000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Oyb6Mn6tAyzQQME3t/nnUmCfV5ouVQNGzBM23Djs2I=;
        b=giaurYGlQVilU7EXuQFCOdvFi0MDTCkoEg5U60BvIQia5Vk3wuODwB34jfPCsy2VmU
         F03r+11wg+zzjof4+ZVmaMjLb2je5+sWHqukmJ1elU6J7dP5dz2RBoF43Nulx8Khv4sc
         1rkBZBIqFEqV5SoyM+bLdWmaOPAbqnllzcZp6bIvQKDZ577F4wO0lLhbr8rsNz4nBhHF
         jbLmTf1ExuLDCa5mFTbz+02ZvHIHSlOhWnfq29cYqsfm3UZHKfuAsaYMgxHyg57si6OW
         lP3kH8Njd25s4bxjEZ7c5aw6Uo04q+waC+Q+lrx1shTr0stvY00HaRxoQE930JCOrNo5
         nfvQ==
X-Gm-Message-State: AOJu0Yy1AA1uaHYijhBBHwhKSeZ9PS/0Yis9DWsKlrralfONiR1FuZpl
        B98OyOPKi7Ts3Wb1FrAA8o09qQ/POqk=
X-Google-Smtp-Source: AGHT+IGD+QNYeN5M8QQhfqBgoRYnA26oXBp6vdkbtVs8vrvn+9Af835Oa5p7Jrnzukearvws6eMBXQ==
X-Received: by 2002:ad4:5dca:0:b0:62d:ddeb:3770 with SMTP id m10-20020ad45dca000000b0062dddeb3770mr3902749qvh.0.1694571200161;
        Tue, 12 Sep 2023 19:13:20 -0700 (PDT)
Received: from localhost.localdomain (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id c8-20020a0cf2c8000000b0064f778c8165sm4016055qvm.64.2023.09.12.19.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 19:13:19 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 3/6] ext4: rework partial cluster handling to use lblk more consistently
Date:   Tue, 12 Sep 2023 22:11:45 -0400
Message-Id: <20230913021148.1181646-4-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913021148.1181646-1-enwlinux@gmail.com>
References: <20230913021148.1181646-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Working in the logical block space where possible when manipulating
partial clusters makes the code easier to understand.  It also offers
the opportunity for efficiency improvements, both in this patch and
those that follow.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0c52218fb171..793a9437be9f 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2505,7 +2505,7 @@ static int ext4_remove_blocks(handle_t *handle, struct inode *inode,
 	 */
 	last_pblk = ext4_ext_pblock(ex) + ee_len - 1;
 	if (partial->state != none &&
-	    partial->pclu != EXT4_B2C(sbi, last_pblk)) {
+		EXT4_B2C(sbi, partial->lblk) != EXT4_B2C(sbi, to)) {
 		if (partial->state == free)
 			free_partial_cluster(handle, inode, partial);
 		partial->state = none;
@@ -2547,7 +2547,8 @@ static int ext4_remove_blocks(handle_t *handle, struct inode *inode,
 	ext4_free_blocks(handle, inode, NULL, pblk, num, flags);
 
 	/* reset the partial cluster if we've freed past it */
-	if (partial->state != none && partial->pclu != EXT4_B2C(sbi, pblk))
+	if (partial->state != none &&
+	    EXT4_B2C(sbi, partial->lblk) != EXT4_B2C(sbi, from))
 		partial->state = none;
 
 	/*
@@ -2597,11 +2598,10 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 	struct ext4_extent_header *eh;
 	ext4_lblk_t a, b;
 	unsigned num;
-	ext4_lblk_t ex_ee_block;
+	ext4_lblk_t ex_ee_block, lblk;
 	unsigned short ex_ee_len;
 	unsigned unwritten = 0;
 	struct ext4_extent *ex;
-	ext4_fsblk_t pblk;
 
 	/* the header must be checked already in ext4_ext_remove_space() */
 	ext_debug(inode, "truncate since %u in leaf to %u\n", start, end);
@@ -2649,8 +2649,7 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 			 * be just to the left.
 			 */
 			if (sbi->s_cluster_ratio > 1) {
-				pblk = ext4_ext_pblock(ex);
-				partial->pclu = EXT4_B2C(sbi, pblk);
+				partial->lblk = ex_ee_block;
 				partial->state = keep;
 			}
 			ex--;
@@ -2767,8 +2766,8 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 	 * to be removed but might be shared with the partial cluster.
 	 */
 	if (partial->state == free && ex >= EXT_FIRST_EXTENT(eh)) {
-		pblk = ext4_ext_pblock(ex) + ex_ee_len - 1;
-		if (partial->pclu != EXT4_B2C(sbi, pblk))
+		lblk = ex_ee_block + ex_ee_len - 1;
+		if (EXT4_B2C(sbi, partial->lblk) != EXT4_B2C(sbi, lblk))
 			free_partial_cluster(handle, inode, partial);
 		partial->state = none;
 	}
@@ -2878,8 +2877,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			 * in use to avoid freeing it when removing blocks.
 			 */
 			if (sbi->s_cluster_ratio > 1) {
-				pblk = ext4_ext_pblock(ex) + end - ee_block + 1;
-				partial.pclu = EXT4_B2C(sbi, pblk);
+				partial.lblk = end + 1;
 				partial.state = keep;
 			}
 
@@ -2912,7 +2910,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			if (err < 0)
 				goto out;
 			if (pblk) {
-				partial.pclu = EXT4_B2C(sbi, pblk);
+				partial.lblk = lblk;
 				partial.state = keep;
 			}
 		}
-- 
2.30.2

