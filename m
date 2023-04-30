Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E957B6F2B77
	for <lists+linux-ext4@lfdr.de>; Mon,  1 May 2023 00:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjD3Wza (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 18:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjD3Wz3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 18:55:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88559E45
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 15:55:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24dfc3c662eso262675a91.3
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 15:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682895328; x=1685487328;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJluIybvv9+4VROOfwa3fnVto2xWOyknEp0NMGOCLUI=;
        b=Eg+K6DAKuNhW3+GWXgkQfSni+v9+ZwjUG8Y4aODgbgX76uAH9TZk/WQEA/DwO7AKgn
         Rca9tiDdflX6lEkA96MLZPerhxqd4HPHchPKIZvJCiE0YPQcSfkU6d5bumzH+gEE3o2Q
         h6bXQY5+5LjTA+XrC3xR+Hj0DLX24dpn3qj00YvcR8ec2sZ3XKEevlVzAhoybHgUjUM7
         8iHlrpqRwdXqxL6YWSgYOMNEXTcLoZve/k7FLMcKZfaKKBsxw9vsACUaolUfhtoUhgyI
         2mUHE0W4prthZPwxxOxK6YBSEEXC9OnbSn85QwWrktY+69TxW9r7aWHLwJSshTO77CtE
         JVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682895328; x=1685487328;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJluIybvv9+4VROOfwa3fnVto2xWOyknEp0NMGOCLUI=;
        b=JVeKyS3jguH68eR4azCSsrgS031wFBaUshnvyKIn7RJdBukURZzoFw+YAX9WdpEbTK
         5HM1Vqo3l5FVG7E41MSRwJVzXOiuUhkC6ZhrEFLaTLpPEHRkDXR0tfbiJBeP93/nIZHS
         tg5CE4cE+DEDrsTeDHRJjq9u/W617X0bDEX3byMB1K6dxvesjw/LB9PYy/APxDgnccg/
         GhJB2YzvMhomtEgRgtOlRp70iw6tcDK+prOen0wC+o6aMLvh9S106pNp/pkE6HPktNti
         mcfoO1KmLi2W1K6HgKCG7wOacdg6ABytklQBYW1Mn035nWYXiQo6dx+EsYGo/jXa8TU1
         WzTw==
X-Gm-Message-State: AC+VfDzmtd3SQ5RI3jRYliw7xbYaFnpMK5+Tj3ulRkLzW5iFiCGGEth4
        OeSBwlvSY18JVbE6ztOKluYETw==
X-Google-Smtp-Source: ACHHUZ4Is1upx/2QNKfEAcbuQ8zwKxKcGj6UjDSGEY9Gd4DQQjYrOCwD71HDEkCj70YNvfmD7l4vKA==
X-Received: by 2002:a17:90b:190d:b0:24e:9e6:7067 with SMTP id mp13-20020a17090b190d00b0024e09e67067mr348687pjb.7.1682895327981;
        Sun, 30 Apr 2023 15:55:27 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090ad08500b0024e07ae2cfesm176082pju.38.2023.04.30.15.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 15:55:27 -0700 (PDT)
Subject: [PATCH 2/2] ext4: Elide an unused variable warning in __ext4_fill_super()
Date:   Sun, 30 Apr 2023 15:54:56 -0700
Message-Id: <20230430225456.19790-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230430225456.19790-1-palmer@rivosinc.com>
References: <20230430225456.19790-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

i is only used under CONFIG_QUOTA, so mark it as __maybe_unused to
avoid a warning.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 09f3e1d714d6..3bf2449befcc 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5197,7 +5197,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	ext4_fsblk_t logical_sb_block;
 	struct inode *root;
 	int ret = -ENOMEM;
-	unsigned int i;
+	unsigned int __maybe_unused i;
 	int needs_recovery;
 	int err = 0;
 	ext4_group_t first_not_zeroed;
-- 
2.40.0

