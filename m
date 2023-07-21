Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B975D20A
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGUSzh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 14:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjGUSzf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 14:55:35 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14323A9C
        for <linux-ext4@vger.kernel.org>; Fri, 21 Jul 2023 11:55:24 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7658430eb5dso226312685a.2
        for <linux-ext4@vger.kernel.org>; Fri, 21 Jul 2023 11:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689965723; x=1690570523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Y6KtmmjFqHmJrfTGwtLo5U3CvX7kiUQqxJ8NaF4Z1Q=;
        b=bbx2PP0EUBQ9VY6gX4TpbfewIYeawiHLiq4jPINrs/32ZcYUpmZaidLYIigJZFAs2g
         +/n0VRZd7DPbVwJDRkozs6lNvOdeEVwB3QkhYKKX6Lrpc2EvbB8I0DxqF2aUspXLJ7+1
         s8lCpYB36T79Shxo8VGJyBzL2mUNZHSSVxAsPoKW/QCr5HJ51eQp5AfCQ76SNEV/edsL
         G0Ir30Lmeg5jwUWGIvHi3EifVXCZodKO6ncCnuWeGCA2x58/bpaXjMgd4sT10gjjwFeB
         tVUZQLuYj2LTH49Yx3Rj1Xclj8m7uvo2zTwnUYk2isieHrloPx2Z6T88UItsUiKPH15M
         GsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689965723; x=1690570523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Y6KtmmjFqHmJrfTGwtLo5U3CvX7kiUQqxJ8NaF4Z1Q=;
        b=UudS6loLbpDdw9jEs7xFawds181XAMLoZ+7fjG6vNvmqbG2dUJ4t9CNhOWrDHR+2Bh
         ixyOpswpuY3C8D8doy7E5WsO/la2LxUaDtEigNyHdTqSG7UV42MBSrUpG4PF2VVj3zJ0
         byAPr/BXO+MsNdUFlDTkm8vsU0Zl2MuRWx/2e3WrbrUjEzuuTBgNPk4B6aM9yjf197Cs
         Hcc0fIjA42rr+SutnDeCaFq7W360fS+/zJlytpLY1LrhoU2w8RBU4kyUdbAeqIhTGlEP
         ZPbdSy6ePMWCsCnjHPuiv4L6E9XsApSbWRJ7+ENT3/GxwMzUl1Bm2cQXCp9ORyev2nJE
         oW3g==
X-Gm-Message-State: ABy/qLZzKGLDd1eoZG+6bw9Y90oj7a+yQytlBR3Jj32iYT+WnWFahdmw
        g/kHocnGQbqlT1v8wJl2MweCKRauhOA=
X-Google-Smtp-Source: APBJJlHN60PLrNIzZC9gB0IFcxs1ENnSLbBhdkfqj8p15Lye1Jw1LzXbvtA3m9KVEYSb0m9AP62JZw==
X-Received: by 2002:a05:620a:4546:b0:767:28ca:3f4 with SMTP id u6-20020a05620a454600b0076728ca03f4mr945855qkp.55.1689965723268;
        Fri, 21 Jul 2023 11:55:23 -0700 (PDT)
Received: from localhost.localdomain (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id p28-20020a05620a133c00b00768283dcb63sm1285745qkj.123.2023.07.21.11.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 11:55:23 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] e2fsprogs: modify dumpe2fs to report free block ranges for bigalloc
Date:   Fri, 21 Jul 2023 14:55:06 -0400
Message-Id: <20230721185506.1020225-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
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

dumpe2fs has never been modified to correctly report block ranges
corresponding to free clusters in block allocation bitmaps from bigalloc
file systems.  Rather than reporting block ranges covering all the
blocks in free clusters found in a block bitmap, it either reports just
the first block number in a cluster for a single free cluster, or a
range beginning with the first block number in the first cluster in a
series of free clusters, and ending with the first block number in the
last cluster in that series.

This behavior causes xfstest shared/298 to fail when run on a bigalloc
file system with a 1k block size.  The test uses dumpe2fs to collect
a list of the blocks freed when files are deleted from a file system.
When the test deletes a file containing blocks located after the first
block in the last cluster in a series of clusters, dumpe2fs does not
report those blocks as free per the test's expectations.

Modify dumpe2fs to report full block ranges for free clusters.  At the
same time, fix a small bug causing unnecessary !in_use() retests while
iterating over a block bitmap.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 misc/dumpe2fs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/misc/dumpe2fs.c b/misc/dumpe2fs.c
index 7c080ed9..d2d57fb0 100644
--- a/misc/dumpe2fs.c
+++ b/misc/dumpe2fs.c
@@ -84,8 +84,7 @@ static void print_free(unsigned long group, char * bitmap,
 		       unsigned long num, unsigned long offset, int ratio)
 {
 	int p = 0;
-	unsigned long i;
-	unsigned long j;
+	unsigned long i, j;
 
 	offset /= ratio;
 	offset += group * num;
@@ -95,13 +94,14 @@ static void print_free(unsigned long group, char * bitmap,
 			if (p)
 				printf (", ");
 			print_number((i + offset) * ratio);
-			for (j = i; j < num && !in_use (bitmap, j); j++)
+			for (j = i + 1; j < num && !in_use(bitmap, j); j++)
 				;
-			if (--j != i) {
+			if (j != i + 1 || ratio > 1) {
 				fputc('-', stdout);
-				print_number((j + offset) * ratio);
-				i = j;
+				print_number(((j - 1 + offset) * ratio) +
+					     ratio - 1);
 			}
+			i = j;
 			p = 1;
 		}
 }
-- 
2.30.2

