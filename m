Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F8461F30D
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiKGM0L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbiKGM0A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:26:00 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C9763CE
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:25:58 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so10140470pjk.1
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Taw4sY5iZaNdt+izCsMrOPjsHwT7+10DDuDS9/mfrd0=;
        b=hMnHeAnLb/1T5k3HpFIdAeXr64Ygn9CogYZAJhkTaTxdDj3vOF7PZKbQLNmvbaOWaD
         WW/h4EAhowzxdZV/N/pT5CoEEf8yTikSGg/crvm7VqSUlbqlv36YedSIMInGGms1DuQy
         bjsPgRTF1tJ/Ky4sv6oz+jtIhaHbDok2ujHHlq97txgxj/6vuv72mvGKMz2ZJdsIOwlG
         GyM/oo/XAEL/vpI/CfP8KykjiCGzW6RyRUzMsNscZSb6Cz/QgWHCMxKXkY+bVDKd/ZoP
         b0TMWlX2SLM0nW2L1HO0h+RfS+AK5ANMeelfYfd89Q0mJabFi7Pj54rEQ3DpoFRlg08C
         se7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Taw4sY5iZaNdt+izCsMrOPjsHwT7+10DDuDS9/mfrd0=;
        b=OIxDqChjWeemYATzbsLFG2Y5IeTJ1z6uIaRozz0cYmOyWoFQ7MVulwLNcm9U2BSOLu
         8ss6lXZLXMxucb1jrEcUObwF78/ZU3oFbkDtluXu+WF1TdvI467TgR/r9nDP1RRgdVcE
         uqJ4ZYfaYZOmHukxru6Qv0Q5RKAYwqluZHCj9AVSkr0sF+oYirW/4PAJUSkvcGGxTQnO
         mF7dveCPZbIQKdLzLCpDjryBUhblanEM+o9JTDvHxccxEfUMUApUMOVe1qwKE91Z+G99
         8gheLxdZfoY4EE5DNGDYcykl2RUNSnNBZezIK+cm6BEE9eO8CgG1NpvgQeJRgU8StsUg
         RXCA==
X-Gm-Message-State: ACrzQf13vluevm9lvGDXwCMaSqudVaU9TPFKHK4xmB1MaZZBc8D/7ZHb
        EoCvDEh7p2x6MBXZ8JJNdFU=
X-Google-Smtp-Source: AMsMyM4PJPyVcgI5Pff0U4g6YJSKUyuZR3Tw77jN1PUexor/Erx8vCNri8b7A9eyr8NkcAwEEkzfrA==
X-Received: by 2002:a17:903:2445:b0:186:daeb:bc09 with SMTP id l5-20020a170903244500b00186daebbc09mr49875076pls.31.1667823958410;
        Mon, 07 Nov 2022 04:25:58 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b00174c1855cd9sm4841411pli.267.2022.11.07.04.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:25:57 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 35/72] e2fsck: rbtree bitmap for dir
Date:   Mon,  7 Nov 2022 17:51:23 +0530
Message-Id: <5b724259824b4f395e020389ab698796a1be07dc.1667822611.git.ritesh.list@gmail.com>
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

Only rbtree support merge operation now, use it for bitmaps.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 57003d8c..4d98c467 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1240,6 +1240,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	}
 	pctx.errcode = e2fsck_allocate_inode_bitmap(fs,
 			_("directory inode map"),
+			ctx->global_ctx ? EXT2FS_BMAP64_RBTREE :
 			EXT2FS_BMAP64_AUTODIR,
 			"inode_dir_map", &ctx->inode_dir_map);
 	if (pctx.errcode) {
-- 
2.37.3

