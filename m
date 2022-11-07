Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E460361F334
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiKGM2n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiKGM2g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:28:36 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3551C12D1B
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:28:29 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j12so10911395plj.5
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFIewdpm8KInBVBgrg0PGTjUi+OYV8V6Z0qzY/EFJPg=;
        b=JKu3DYpz7MaA651zSPW2aryhNcbW0+bOB4HrOWsqHRaTIoj6R9dZ8bLAZ9gF9toBjj
         aemJreuoeR632vtT6O7Y23f26EXQMhQ9+Fdl9Nukr0ZUNwUsuPw48+8uYgVrLtfEOalg
         cU97O6MwN3zdn2beb/5gjETBabwFTrsp6ElVtgvdYofJjc6gHFukAn/JFDaQhnKfWNqS
         b2TXN2YBDVuAeTadUwSPSnG4MZn/ICHN3TtNzd3ltOd9eSGrtWSpI9Mg6jd6dg+pnyto
         jRx3/WcFxM/BNFu+ZwrN8HHcSHVHzzMgWFagl09MYFVSGOOm96SDfPfeBLx1T74R+eDC
         ZvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFIewdpm8KInBVBgrg0PGTjUi+OYV8V6Z0qzY/EFJPg=;
        b=TFcsK2iqtCc2GS5Ii/bnxUeoVN0O9XyMR04M9M0CKdQjoSJsYBBP6lWVqOrYKQ7CYS
         nzM9TOF7xhy+f4J3IEX085SoUNIdKOSJRls623n0Z9rQGB4zjghf0Z25Umam0bHwd7JV
         Fwwn0PUxjPTSUtosZzQzCf8wjtjrwZe9Bm264CDzmGYXls4ef0SDh2mCsoX/+1Tqm7bI
         emweB+BGq5xzitisElNkTvK6t9CHQCEjude45s7KyJRrycIxAGw1FAVWUxJ252NdO2gn
         Xmef3XXW9Lb2ZoP4Dm5SqztwDDYd2suJnFw0E9b9ZOgaTED6Z+9UaEm1lusqn+Y371pF
         koSw==
X-Gm-Message-State: ACrzQf1VBKOoCpeeJHbVCr3zakWQvb85n4fd8An2Bi5YMU5iwyzUgLyi
        /XhSZdwlbsRuzeIqEFHB0Rs=
X-Google-Smtp-Source: AMsMyM7gc1wNho74ImwF+ZPwBfiqyWsVc9sHBGvveqEuY/bHNQCuf3BH31y3mVdc4Qkq5uuWvf1Ojw==
X-Received: by 2002:a17:902:ec01:b0:186:748f:e8b6 with SMTP id l1-20020a170902ec0100b00186748fe8b6mr49858814pld.131.1667824108741;
        Mon, 07 Nov 2022 04:28:28 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id w3-20020a628203000000b00562784609fbsm4332436pfd.209.2022.11.07.04.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:28:28 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 60/72] e2fsck: reset @inodes_to_rebuild if restart
Date:   Mon,  7 Nov 2022 17:51:48 +0530
Message-Id: <89bc200265e9aaa5a4d610f0fd18fc7acd934dec.1667822612.git.ritesh.list@gmail.com>
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

Verify multiple thread on a corrupted images hit following bug:

pass1.c:2902: e2fsck_pass1_thread_prepare:
Assertion `global_ctx->inodes_to_rebuild == NULL' failed.
Signal (6) SIGABRT si_code=SI_TKILL
./e2fsck/e2fsck[0x43829e]
/lib64/libpthread.so.0(+0x14b20)[0x7f3b45135b20]
/lib64/libc.so.6(gsignal+0x145)[0x7f3b44f2c625]
/lib64/libc.so.6(abort+0x12b)[0x7f3b44f158d9]
/lib64/libc.so.6(+0x257a9)[0x7f3b44f157a9]
/lib64/libc.so.6(+0x34a66)[0x7f3b44f24a66]
./e2fsck/e2fsck(e2fsck_pass1+0x1662)[0x423572]
./e2fsck/e2fsck(e2fsck_run+0x5a)[0x41611a]
./e2fsck/e2fsck(main+0x1608)[0x4121b8]
/lib64/libc.so.6(__libc_start_main+0xf3)[0x7f3b44f171a3]
./e2fsck/e2fsck(_start+0x2e)[0x413dde]

@inodes_to_rebuild could be not NULL after we restart pass1

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/e2fsck/e2fsck.c b/e2fsck/e2fsck.c
index a5150dab..53af8905 100644
--- a/e2fsck/e2fsck.c
+++ b/e2fsck/e2fsck.c
@@ -79,6 +79,10 @@ errcode_t e2fsck_reset_context(e2fsck_t ctx)
 		ext2fs_free_block_bitmap(ctx->inode_casefold_map);
 		ctx->inode_casefold_map = 0;
 	}
+	if (ctx->inodes_to_rebuild) {
+		ext2fs_free_inode_bitmap(ctx->inodes_to_rebuild);
+		ctx->inodes_to_rebuild = 0;
+	}
 	if (ctx->inode_link_info) {
 		ext2fs_free_icount(ctx->inode_link_info);
 		ctx->inode_link_info = 0;
-- 
2.37.3

