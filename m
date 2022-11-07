Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC2D61F344
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiKGMav (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiKGM3U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:29:20 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F9314D05
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:29:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso10125347pjc.5
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7sm+0ZjlPeHWK2QGLjZh2+Qy84xOiJKbExlK4PBZVE=;
        b=WMVM5cbrGLw1MAqYZ6qhcs4gxabPs1mpZzeqsupExnKZ+WxBeYt+LlpiEvebCijQTE
         QmOPcpF23UNE88IH943l06T/d+Rb9/XAKkewdABPEi4T2QOE5nNKlvqJx5aWclkcYRLO
         8vL3JR3j6c8HcD1P2YU8baXleuMxFgYsuAfVcRiyd+d+QNn98hjVZ7nADOkAPYb3P1h9
         m1SFnU62e4Qg4aP3OuiJqoMrUWdqxcqfdUi+9Zo4Jte4a3A89yQbVp956nFBPRlqmzMI
         t35Y54MQc0M3gBrewf27NCs/bXR42ogR3TKFHU+y50a8D8W3tM/qHQPO4MjS28M/gvW4
         PIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7sm+0ZjlPeHWK2QGLjZh2+Qy84xOiJKbExlK4PBZVE=;
        b=WiK9mcvFrzaUdwMbq2akeznQp6s1EBjmJHM+npijbNA8Tdm1bI+zDsjvUsFZOt1YMu
         YdJGIcVbc0QlnU3/+3gGWWJg/gYq5V4rnnSodQUdTO9FRoJ/9uyfIcZt4o7htznqZi71
         1DD3hus3yYa/b3vl8qKpiNGmdzTO5TqEyyNnze/rUCFJglnG9hK3HqMlUFPo09BTGCeB
         D41PZQkBkJSsBuBtHhs4LxEnXIdKGigA001WuAs61aIKXbDTDL6oPgbRkNom3kdPZciy
         sPxr08095cQfC1nM0z1YMImTbXtbQC+dqFmcG2aVZ6nMp0qhFAVrhionQmWGLn18YeCK
         BqxA==
X-Gm-Message-State: ACrzQf3EP2J2bGhfCOXI3SiNaoSGC1CsY+Xa6i1hCXrkMY102g940+Yg
        /ShHkBMR2C3Lw/nFeRfNURA=
X-Google-Smtp-Source: AMsMyM7pRlAP46P6LBusLV4ML6Usf71ylzCdVMFEWbJlfbJLacmnSOAKFJR04jtelaRTT2HUD2pX8g==
X-Received: by 2002:a17:902:e5cc:b0:187:2b02:969d with SMTP id u12-20020a170902e5cc00b001872b02969dmr37862751plf.9.1667824159419;
        Mon, 07 Nov 2022 04:29:19 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b00186a1b243basm1526027plh.226.2022.11.07.04.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:29:18 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 68/72] e2fsck: Fix io->align assert check
Date:   Mon,  7 Nov 2022 17:51:56 +0530
Message-Id: <3d088e682f655c3886e0c4c7f278a43b01a9b3f7.1667822612.git.ritesh.list@gmail.com>
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

dest->io->align might still get set later in case of non-aligned read done by
any thread in raw_read_blk(). Hence remove this assert check.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index e7dc017c..c934b021 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2514,7 +2514,6 @@ static errcode_t e2fsck_open_channel_fs(ext2_filsys dest, e2fsck_t dest_context,
 	assert(dest->io->flags == src->io->flags);
 	assert(dest->io->app_data == dest);
 	assert(src->io->app_data == src);
-	assert(dest->io->align == src->io->align);
 
 	dest->priv_data = dest_context;
 	dest_context->fs = dest;
-- 
2.37.3

