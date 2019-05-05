Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA34613EFE
	for <lists+linux-ext4@lfdr.de>; Sun,  5 May 2019 13:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfEELBX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 May 2019 07:01:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41391 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEELBW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 May 2019 07:01:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id d9so4908322pls.8;
        Sun, 05 May 2019 04:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VfQI7xIW3w3qRRSUnC0LjIvWhwA6meHiO/eAZYRf+MI=;
        b=pnofy7D53QopPQ61b2Xm8tYQR5JAZx0GS+ogy33AoEw1CbI94Gw9o7o+QKmMi+4J3T
         z7RBsk3zgaepumCX9EBo2SzTupJYSKNi3jLiwJsEFN1etJDhFBS+kurgvSCtx6bG8xUm
         otp4gfjfEOphwcbudGVtN3+LOg62dLN6u7o+iFHVai1lB0Klbt5gRGXBx9PlkRCGyikI
         hWC9C8XmZ4C7dLY/lU0k2LWzNFElx+C7hN4276JHXO1SUA1elvWu0/jd6EDsRdNBqI8v
         T49YSWevDLb55vinEO/hqIRvwrlVmkTI691U3p/iTyDnTSBYzytJr7mAstbF/KFMM10E
         7TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VfQI7xIW3w3qRRSUnC0LjIvWhwA6meHiO/eAZYRf+MI=;
        b=WbnIv0O8arQAZod3sQCOFlr8pdAdHLSDHAvw/Q8FtAMv5pOs7e46490ydklCa/igPj
         dziAKgdInSrgsYyvGZXC1AQs1B/SfIAOLNrryriTRpSfE39bgM+gf2x/5/XD6z+PMAjJ
         5ZC2S8mNJE6aSBLJCF3i1Er+NLK8/08QGBOzaRe18D+3nM1O6aqrOB+AImW6hu8rKeQs
         e6NSQwosv0zxLljb3HPuNlNkmzI2xmN/RpwFz/sweJ8eBonJwRk/FP42AFAwNJgUuAK9
         ErW3WQqiEKNp2LZpBkZTOfGKHy6Cf65LBkb+/GRVVeaMZYF2MqsPn2X8CsL46bTYQy6s
         uBgA==
X-Gm-Message-State: APjAAAUi/t5aNaZVnyh2P5TkIZ7iJ92AMjNDrOD9ycKhNUL6drUR1VnG
        bO2elf6j6++FbTbQ89XLpxM=
X-Google-Smtp-Source: APXvYqxaGIdXGdTOWki7KIwrbx4egXOLDb5wVpCc2ggofGeN6m467wrjOTUGOrEiGhN7hVw2IoTXaw==
X-Received: by 2002:a17:902:b782:: with SMTP id e2mr1643440pls.228.1557054082241;
        Sun, 05 May 2019 04:01:22 -0700 (PDT)
Received: from izt4n3nohp3b5a1z8j8uuaz.localdomain ([149.129.49.136])
        by smtp.gmail.com with ESMTPSA id 10sm12962955pft.100.2019.05.05.04.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 04:01:21 -0700 (PDT)
From:   Chengguang Xu <cgxu519@gmail.com>
To:     jack@suse.com, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmail.com>
Subject: [PATCH 1/3] jbd2: fix potential double free
Date:   Sun,  5 May 2019 19:01:02 +0800
Message-Id: <1557054064-3504-1-git-send-email-cgxu519@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When fail from creating cache jbd2_inode_cache, we will
destroy previously created cache jbd2_handle_cache twice.
This patch fixes it by removing first destroy in error path.

Signed-off-by: Chengguang Xu <cgxu519@gmail.com>
---
 fs/jbd2/journal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 382c030cc78b..49797854ccb8 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2642,7 +2642,6 @@ static int __init jbd2_journal_init_handle_cache(void)
 	jbd2_inode_cache = KMEM_CACHE(jbd2_inode, 0);
 	if (jbd2_inode_cache == NULL) {
 		printk(KERN_EMERG "JBD2: failed to create inode cache\n");
-		kmem_cache_destroy(jbd2_handle_cache);
 		return -ENOMEM;
 	}
 	return 0;
-- 
2.20.1

