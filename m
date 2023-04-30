Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1F96F2B76
	for <lists+linux-ext4@lfdr.de>; Mon,  1 May 2023 00:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjD3Wz3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 18:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjD3Wz2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 18:55:28 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F71E44
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 15:55:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaf21bb427so3609795ad.1
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 15:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682895327; x=1685487327;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=FTeQMFZNuHYlYUUxNwsXVAMIwRhL+BegLWUet8ZwLDA=;
        b=yNvFmJliaB3az3prptc5S/KsvuiSnjFHW/uLnZaPh/KhVTNIA7v11bBlSk4F2zuLUp
         tPAYnIUo90DXC/MpTXrbM1uIKy7hTIqmqz+vMr+0mUHJaKsP07SVjUs5TAq+/htuKnBC
         /TlxqboLZpapVPUIvF+Z9zDh58n/QmTmR3WaHT+rkWPP7sRinUxl4AGFTwG5u9pTaXSg
         QcJHq0IhbqNfNiOY8hhTBTvniwR1B80JsjiS+5vbXGWe/Gleqa2j+kDGxAgtorOj0O9R
         bo2uNokVTaIw3ZSCjK0oInPXJpBaJ36V6no+Yeo62cz1b1dWR4Hrj3JmdhAqJZyB9TAH
         HVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682895327; x=1685487327;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTeQMFZNuHYlYUUxNwsXVAMIwRhL+BegLWUet8ZwLDA=;
        b=e5OakFAHHeDk3VzoQToxIcyu5hdPU5gESsHEc7hCPj+KKmeC15oYuDQS87giykXYuF
         oXa/ED2GIWvR84AMpkPkqR12LVVvVojRKq6UAyjJN42jE9x1c9Eu4lPd8Y1fbzATs3hu
         LSqQlme3a3JjDY7CR+FF8eqU5hqI4QVyf6gpgZQXipvjf36EPKnL6K3ZQxHVYj5JxU3f
         PFBC8AfH4BnvWkS014bpFijilYq2qiV3qP27Hkvyw54wnjDGjISYy5wLWB3egU7kgJK9
         x92J8NAh8W+vk4ybXfR2RTxUKDdL0y+A42aCcTUgGN2yhV5kzobfIbbnmPWOA1iDNA1a
         3o/g==
X-Gm-Message-State: AC+VfDwdedrG6f2zmQmezhfSqyrX+Kmm89xKUqYa0o22tz4UHfpNbOfL
        APLaaVEsSWjVWOz+Zq6/o54vAQrLmA9aokllYPQ=
X-Google-Smtp-Source: ACHHUZ4JgrtGlDr4E9YDi9Q8WEAgwskYEPQJbd0qrbUNJWIARzpNdTrFAfK3tnzkPdn8CmTcyGtNDA==
X-Received: by 2002:a17:902:da82:b0:1a6:68fe:2ea2 with SMTP id j2-20020a170902da8200b001a668fe2ea2mr16130744plx.2.1682895326902;
        Sun, 30 Apr 2023 15:55:26 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001aafde0cd8fsm62431plg.53.2023.04.30.15.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 15:55:26 -0700 (PDT)
Subject: [PATCH 1/2] ext4: Elide an unused variable warning in ext4_put_super()
Date:   Sun, 30 Apr 2023 15:54:55 -0700
Message-Id: <20230430225456.19790-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.40.0
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

i is only used under CONFIG_QUOTA, so mark it as __maybe_unused to avoid
a warning.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d03bf0ecf505..09f3e1d714d6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1259,7 +1259,7 @@ static void ext4_put_super(struct super_block *sb)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
 	int aborted = 0;
-	int i, err;
+	int __maybe_unused i, err;
 
 	/*
 	 * Unregister sysfs before destroying jbd2 journal.
-- 
2.40.0

