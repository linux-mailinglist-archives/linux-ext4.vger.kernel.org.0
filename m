Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25FF61F2DB
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiKGMWa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiKGMW3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:22:29 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16A9D62
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:22:28 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p21so10895215plr.7
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhu5N1/WsdaDuDfEuZec2Dmbs5lsbYY8/HuylV78JBE=;
        b=f1kbEnXFkza1ZfjT//Sm6JsQuhulqyDqiViAeQiaP5NpQlIQwBF+f6/WeUMSziWs0T
         FozY01LRiRpUOGsoDoKZTADs2ijFoEX+6jyc/N+P+u5ZcrbJKBFHoNnVtYmf9uxjrRL0
         t6b5Dv1Td78V9k8dVgBn06xQGcE8d/IMOrZQn9kTf+ZZBzUsSkXb+R/lJcCTGCkFPeA2
         BJy2YFJONQAqovoXMhkMANi6bDOWhb26Juzpz3ijrHzIlZr95LqEPwmuo7P0agOe3fYk
         upcG+v0adxeX3ki7clYaCG1GkxkQFW+9clMpDIjFg8R+GwoRcZnVbKG2wT4ydqPecLge
         wQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhu5N1/WsdaDuDfEuZec2Dmbs5lsbYY8/HuylV78JBE=;
        b=vnaNy+TgVwUS6LCCLtaZ62OWBboK1obbeijRsh44ykYWFwOGyVyo/q3iEclOyDH3rx
         mvFRJoAmwpg9j2qmYu1pmAZzqPk5vYjTGXXblit88bwhd/oZdo4V6mnAj2V4k2g0xXtn
         pVJatgg0en8sgxP8yUK2mOoqUmOCpfqxD/6ccnifiUSjKRQQqpdsakq7zpD2Iin3jsek
         tv7taabB3FzPvUrtEVQyGZdLTnOb84gTN3ptIGEOQpsVT53cJ3PX3R8d8oZj4C7iRViY
         39x1OxsYU6QaCryAFqo7tTK30LBlnMcKoalO12epQyVTKu/GUa+pJ9CexCOoZrgcSIg0
         SXjw==
X-Gm-Message-State: ANoB5plieEiAIxvVVxGiXYefZr6muakzrcvX8d5/4Kffx2EP7Da4+NG1
        5gRnw1wRkCfI0wXPXj1MTMs=
X-Google-Smtp-Source: AA0mqf7reBytkkV3J7RmlEHMt7C4DFq90e8EXXpjmhQf1+xRHIF6PqGbBd7FYxREQWLIQnDXFi0dsA==
X-Received: by 2002:a17:902:9042:b0:188:6fc9:1da with SMTP id w2-20020a170902904200b001886fc901damr13818756plz.162.1667823748458;
        Mon, 07 Nov 2022 04:22:28 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id a10-20020a63cd4a000000b0043941566481sm4128203pgj.39.2022.11.07.04.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:22:27 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 01/72] e2fsck: Fix unbalanced mutex unlock for BOUNCE_MTX
Date:   Mon,  7 Nov 2022 17:50:49 +0530
Message-Id: <febbbd17b3cf4201aaae24e4adb61e4f8a80e9c9.1667822611.git.ritesh.list@gmail.com>
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

f_crashdisk test failed with UNIX_IO_FORCE_BOUNCE=yes due to unbalanced
mutex unlock in below path.

This patch fixes it.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/ext2fs/unix_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index e53db333..5b894826 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -305,7 +305,6 @@ bounce_read:
 	while (size > 0) {
 		actual = read(data->dev, data->bounce, align_size);
 		if (actual != align_size) {
-			mutex_unlock(data, BOUNCE_MTX);
 			actual = really_read;
 			buf -= really_read;
 			size += really_read;
-- 
2.37.3

