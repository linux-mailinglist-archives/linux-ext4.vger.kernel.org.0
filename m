Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EFD4F1836
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Apr 2022 17:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378248AbiDDPYz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Apr 2022 11:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378524AbiDDPYx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Apr 2022 11:24:53 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC2B3E5DC
        for <linux-ext4@vger.kernel.org>; Mon,  4 Apr 2022 08:22:53 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id w21so8588650pgm.7
        for <linux-ext4@vger.kernel.org>; Mon, 04 Apr 2022 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wyDte6u49XuZOEDhbioS92IXz+R+MU1mBAkIHexEyo8=;
        b=FI5XYFXXfXWe79T9qLsB6oiy2Bkf+dsXAJ1igK83khhqqLP2t3ELJRa06GFl0sDWKi
         VfcyzNTleGdnCa+/S2thk88pRmxjYBqC/ERN9xUKYMHzZq6jA+4hGdCEAfS5cC/NZ9pU
         LfRkGXbMG8YodiJzxbPPPidNkjKCU5j3IldHeadEOboyGo4/mJ1sSQsRsFUAseGOKwpJ
         cNoAVwtsd1VdYFaKnb7QjGvD7qAOmlFOqk8nwniOrLKqM4HhDIiwCGME/jRLXP4niJFs
         V4Q4+JFO81ladTPCvBbGPIzI9HYaDhdvi+8f0UbO9+dk8E/rY7SGSlWgHD3txVZATu7B
         twqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wyDte6u49XuZOEDhbioS92IXz+R+MU1mBAkIHexEyo8=;
        b=k9lUiksEpCjKaiueY29YTb8qMWlO+IV21j5Wyliz2vaRBYRcm0mqBBn3pI1AjTAIdD
         mb6IYPpTQV4/RA7QzrAuRZSqexnVxEd/Kxqc0Li1g6Z4SDU5aTwRkSlPkOcmKX8R3BqK
         RYuVsgUiPmNLqjFHiEj5WguTS/zTGlAnpNFe+fkScIK0+wU6VblOduP+f0/acHIgwDIM
         6uHZNklM1c/O8FvyWsyS9ndW/dKANinaPI6i2KzdtcpcZ0/LlakGhwvM/ZmC6GXQdtZQ
         8G53YPk3MnbPcS4DXO0M0OXJj6Xn0hgmRbtvcE2MljRwtlMk9NFxT+EovIzvILSgSWG0
         6qHA==
X-Gm-Message-State: AOAM53137IXZB9SJCczgnnmQLn1yD6zpdBfTiLcoA2sbh/hUspROlCi2
        4FI/bex8FPI3Ryg+fVJkUt0n3g==
X-Google-Smtp-Source: ABdhPJyuEOrM3uDz7VUMJ+shlo4iDFFBC7PYOBsACm3opqHftv1Rgh5WDiCiU4V6mAm84QapvgrW9g==
X-Received: by 2002:a05:6a00:1581:b0:4fa:e6d4:c3e6 with SMTP id u1-20020a056a00158100b004fae6d4c3e6mr94158pfk.84.1649085773408;
        Mon, 04 Apr 2022 08:22:53 -0700 (PDT)
Received: from C02GD5ZHMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090a394e00b001c670d67b8esm11079971pjf.32.2022.04.04.08.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 08:22:53 -0700 (PDT)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH] ext4: remove unnecessary code in __mb_check_buddy
Date:   Mon,  4 Apr 2022 23:22:43 +0800
Message-Id: <20220404152243.13556-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jinke Han <hanjinke.666@bytedance.com>

When enter elseif branch, the the MB_CHECK_ASSERT will never fail.
In addtion, the only illegal combination is 0/0, which can be caught
by the first if branch.

Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
---
 fs/ext4/mballoc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e5d43d2ee474..eba650b31870 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -576,13 +576,10 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 		for (i = 0; i < max; i++) {
 
 			if (mb_test_bit(i, buddy)) {
-				/* only single bit in buddy2 may be 1 */
+				/* only single bit in buddy2 may be 0 */
 				if (!mb_test_bit(i << 1, buddy2)) {
 					MB_CHECK_ASSERT(
 						mb_test_bit((i<<1)+1, buddy2));
-				} else if (!mb_test_bit((i << 1) + 1, buddy2)) {
-					MB_CHECK_ASSERT(
-						mb_test_bit(i << 1, buddy2));
 				}
 				continue;
 			}
-- 
2.20.1

