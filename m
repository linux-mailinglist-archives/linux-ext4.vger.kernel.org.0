Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7160C2AA67B
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Nov 2020 16:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgKGP6p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Nov 2020 10:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgKGP6o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Nov 2020 10:58:44 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA609C0613CF
        for <linux-ext4@vger.kernel.org>; Sat,  7 Nov 2020 07:58:44 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id z1so2387212plo.12
        for <linux-ext4@vger.kernel.org>; Sat, 07 Nov 2020 07:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UK0TErdVmcOrSacHj6mFbyNWWpawXVpUQSnBIx3kPo4=;
        b=O9LP0Zxvy9QKTBEzIrqUggl5RFEnbnrfOcL/OSlRUFBKYYMf/dnruwuussqpo3XEaZ
         gY5FoBp1FMQsP8aa73bFEeb0n5yRkcJvQlKtm5XSew/iIE97QXKyHM4HTmXDxlkuUNIo
         eDHL8LCfIEoNPdUyhGfEi2SbedXWicu+GEms4a6QBzZMBpcTpbs8A7jvW5I5afkW5mUU
         AZQ1S74/sSwwnT/LmU70fIOdb7jbW3sZOSmzq5nP6upKjR19T2Yts45Y2DJRxGi0bsUF
         DmPjYfrCcO7P4YfLvABBHOyzRCDWLf5Ojk88gLpJ1d+706USHA7F4/6tkAwe9Dq9/isG
         w8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UK0TErdVmcOrSacHj6mFbyNWWpawXVpUQSnBIx3kPo4=;
        b=Avg11e2HEFKT1AZ/+DkrXDeg2/iPrLi5mFkKsqUb5yAE6Krwr5Zq6cdy3DN1CRGQaM
         upFQzTjhJTMEAdUqoCWcvP093cxIKj0NxOxNnTa95Ea1lXFaryQS3EvA3bXgRymQaOee
         xWDlf9qMM1L8PtxNsdPLO89Ejv3e3zpNOIG1DBHwx987/MU8z54ipyRDab1AdaBqNQmE
         6fa6mzuoxK7uD/hheUo0deuA65TSP/61GO14IRbZnVvXJo3aXnAsekpQ19J4RE1vX9Ii
         h1kL5eQLn7CIN/UdKvE4goPz1fYy/kKvfCoq0KKS/rytOhzwglCMEZ2OZtleZPYaQy7M
         SyGQ==
X-Gm-Message-State: AOAM531rCBsuglOh353BuEZDwS71RZBVr2xdXHKtMvuqJSEruJ90zUAI
        QPFnfM/reVU98Yp2onBc0M91q5pHNwk=
X-Google-Smtp-Source: ABdhPJz4whgFRWYkmkbQxRLDoMs0kadBsa1GmLHfyMGeLGRBq3o71fBF6vh9zW8qUnR5d7GM0hCWzw==
X-Received: by 2002:a17:90b:3d6:: with SMTP id go22mr3294649pjb.53.1604764724310;
        Sat, 07 Nov 2020 07:58:44 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id e81sm6049956pfh.104.2020.11.07.07.58.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 07:58:43 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH RESEND 3/8] ext4: simplify the code of mb_find_order_for_block
Date:   Sat,  7 Nov 2020 23:58:13 +0800
Message-Id: <1604764698-4269-3-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

The code of mb_find_order_for_block is a bit obscure, but we can
simplify it with mb_find_buddy(), make the code more concise.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/mballoc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5b74555..29dfeb04 100644
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

