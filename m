Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4F61F325
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiKGM1q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiKGM1l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:27:41 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740911B7B0
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:27:41 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 130so10450790pfu.8
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxJyL+w+pfAfLkAJLcGqmfLql0/jYkk6WTRWqCNCjIA=;
        b=kwaVVbb6ud897u5c8jn9pnnK8rc+BYg2iRJGFuxESbXtK/jjXg6Ypf8ybJIUTZj3wO
         L99T3+ZVuY7DKGnZ7PZE5sAD3wL76cKBejn8YOLPbyR/c0lato4mrdy+X87S/s4Fdzcv
         cctTzn/U/oozTXzoRUxYS3u7Bhmvjc/VvyzYgSH3uNdq1II1TnaGI9c/qz6GbNxjo8+n
         wXBuD6he/68uMbQBCQKsU0+d2h0g1UWjPyRYOOXFNfZZQry1E7Qm69vIUdiGEPmGNtat
         FB1BkZzZ3rF9e9Vra3aAF6XIoTG1NGrOxV+O+YUTqLVIcpXyW0nGHbn0HdLKQY8RzJo9
         7stQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxJyL+w+pfAfLkAJLcGqmfLql0/jYkk6WTRWqCNCjIA=;
        b=XTuXkPY5LCzIpLebQOZ6J76fnnlzYlCb7wuhw+1KjsTAzFLvTMx+qwnsOg9f69NH6w
         882RcEAMkHWKrzc70hK+n4b3Y+moLs6fekWnkPmhLbrbQF9WlwwoNRpjUkPMqY73+ElC
         aPPDPMtr/no1WwqXTQYGAIRXv0BczFsL2wLufq+ffGgq+lgmCzbCLGcPA/TTewrBJ0ia
         Mz14vcRRrjw5jLM3KBKPGhM2zBJJ332x2Xl7MbJhZU7+Ejy/Ch/+wao0B0Ozj9ZnXU7h
         LHzNfMKTKKGpi79/aW+gW+rhw0qcmjOEuEV0I7dFe15ghf9O9VlblKt42a+uuh8/ezkT
         vUdg==
X-Gm-Message-State: ACrzQf2lwo93YK4ODZaLJr9ma+G3qu0erc18rOuLKzqxkyO2OykxZcJI
        RSQB0ftU/FCjCkod8IK/bP0=
X-Google-Smtp-Source: AMsMyM4x81BZuibCfsIAtkIlHmhcYrNRBJEknXCszdH3/lDZF1JoXH72W5Zie7bFpvoyHuLwenj79w==
X-Received: by 2002:a05:6a00:1884:b0:56c:636a:d554 with SMTP id x4-20020a056a00188400b0056c636ad554mr50133166pfh.18.1667824061003;
        Mon, 07 Nov 2022 04:27:41 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id k64-20020a17090a3ec600b00205f013f275sm6058993pjc.22.2022.11.07.04.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:27:40 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 52/72] e2fsck: reset lost_and_found after threads finish
Date:   Mon,  7 Nov 2022 17:51:40 +0530
Message-Id: <fd281eb3973e723d034de383dab83b229d25b9b0.1667822611.git.ritesh.list@gmail.com>
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

This should not be kept, the reaons is similar to what
e2fsck_pass1 has done before.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 59ff888f..1a5fcf66 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2925,6 +2925,11 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->logf = global_logf;
 	global_ctx->problem_logf = global_problem_logf;
 	global_ctx->global_ctx = NULL;
+	/*
+	 * The l+f inode may have been cleared, so zap it now and
+	 * later passes will recalculate it if necessary
+	 */
+	global_ctx->lost_and_found = 0;
 
 	global_fs->priv_data = global_ctx;
 	global_ctx->fs = global_fs;
-- 
2.37.3

