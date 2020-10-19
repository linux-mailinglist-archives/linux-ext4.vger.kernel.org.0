Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835B1292431
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 11:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgJSJCq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 05:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgJSJCq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Oct 2020 05:02:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B7CC0613CE
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v12so4642500ply.12
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r3sZO1kwTuy79OCycDSs7UKZ99C2F8Th3DIIU2eTHdI=;
        b=FVn1TQ4CtngXb02CEjN5RDiC+gW/CfaqGUl059aeFxN/t+sm2DHHeWAMkQuawAe06x
         E6EH8sEWmqAaXHs48A0NFDYQGI0CbQJ7X9KdtEFc+/Ct5PBwIk/PvSqmy3Ttkox13X9S
         tu4/OZ2Jol+FxjjMHlnMEAbTPSVwOX1V6Weoea8x3dWra8ZToJIITa1fyZESPqDOxnGH
         G7nQ6IgHktjmiamQxSW8iixB+gnTH3vAYqezrwHWRl15UtR4FVBcLMM0Tt8RCP2NbOFd
         5pj1BeUvU6Uc9aYTme9UU6rp0dbjIIl82bCi4zxvLbmcLPJZPrulyALwsLMD0e/0AL+W
         EBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r3sZO1kwTuy79OCycDSs7UKZ99C2F8Th3DIIU2eTHdI=;
        b=PcNoQHDi03IZCx4fmcvKVNqXZLdH5ia058kjqmySzm6hxsJKwBvxKx6WCJMG7G5shc
         0YJFVTaojVMujDZabCRdvWL1A1NnVZFYUvCOm1mPRe6ErdQ9Qmr8CbujBko2W+HuwyjJ
         cNbopcdhPggS5IxZI2f1gqUtDpOQqRp/P5lnM6hIP3UBK7ptB19f6y9jIBKLntuyT85M
         uADzRwUQUF21nSeMc8ygE9fz+nxRbqaR/tbfpYvywYvlMoCHIMv9CY6raz6R9sYoWL5G
         pvEpdp2Lyk6/pll8D3jYuDJCuoDcakKpsGW1BVxwMXUPeeaaoi/1nNKVY+8QH4/sqErS
         yyFw==
X-Gm-Message-State: AOAM5309M4t9I+EcRz7AB0BKucH5nM3sfojL93I2Tm1Prm2MocsJxv1S
        QSepSph3sl6ogAFrF20p82I=
X-Google-Smtp-Source: ABdhPJwjX7GgwxrJTEEHJRBnRXaSFS9Hoy5sVlY/lpZcJCnvqNmvu5qYFrROWLX/neF62lpORu8e0A==
X-Received: by 2002:a17:902:8341:b029:d4:e3fa:e464 with SMTP id z1-20020a1709028341b02900d4e3fae464mr16238082pln.66.1603098164777;
        Mon, 19 Oct 2020 02:02:44 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id 14sm11422880pjn.48.2020.10.19.02.02.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 02:02:44 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH v2 3/8] ext4: simplify the code of mb_find_order_for_block
Date:   Mon, 19 Oct 2020 17:02:33 +0800
Message-Id: <1603098158-30406-3-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
References: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The code of mb_find_order_for_block is a bit obscure, but we can
simplify it with mb_find_buddy(), make the code more concise.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 03337c8..56075ce 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1289,22 +1289,18 @@ static void ext4_mb_unload_buddy(struct ext4_buddy *e4b)
 
 static int mb_find_order_for_block(struct ext4_buddy *e4b, int block)
 {
-	int order = 1;
-	int bb_incr = 1 << (e4b->bd_blkbits - 1);
+	int order = 1, max;
 	void *bb;
 
 	BUG_ON(e4b->bd_bitmap == e4b->bd_buddy);
 	BUG_ON(block >= (1 << (e4b->bd_blkbits + 3)));
 
-	bb = e4b->bd_buddy;
 	while (order <= e4b->bd_blkbits + 1) {
-		block = block >> 1;
-		if (!mb_test_bit(block, bb)) {
+		bb = mb_find_buddy(e4b, order, &max);
+		if (!mb_test_bit(block >> order, bb)) {
 			/* this block is part of buddy of order 'order' */
 			return order;
 		}
-		bb += bb_incr;
-		bb_incr >>= 1;
 		order++;
 	}
 	return 0;
-- 
1.8.3.1

