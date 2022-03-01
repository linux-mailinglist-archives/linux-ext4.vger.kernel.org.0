Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50EE4C8B53
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Mar 2022 13:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiCAMR2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Mar 2022 07:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiCAMR2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Mar 2022 07:17:28 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467982C137;
        Tue,  1 Mar 2022 04:16:47 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so1264082wms.4;
        Tue, 01 Mar 2022 04:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ntCFAlEG4RaBUbthb67COp2chYLeXJlzz0H3UgSJ+AM=;
        b=KcYzYyDqMO1QxjulQ3f7+DlAxeuh4ROCXjWrlw1dhlzpEsk2FlP+AQkW2NmZFH2I+B
         5Gg606bim3Z5sC2PnglpawRbDNvOQXcZjT9mCp59aNR+1HIQzE6iw/vm9ArjB4HhFvlt
         JPebVG09sopBNZvWG8fnRZqFSeMNaTFdV22XiyzeCTiVWDfuof03iQCdi32R69wzc61j
         ur0ApquHv84sLX9BkaLWCrm/5yZq/kEZJfpItx9NIOZIxO4+VyWkwASdLTmE3oZ0GJGe
         CnTvw3k0ZY0vMLM9TdjDplbKhn9LkJ+sZgzkKYgQ4/LxyybfWXaTdcyr7D1CAytYNKz0
         xQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ntCFAlEG4RaBUbthb67COp2chYLeXJlzz0H3UgSJ+AM=;
        b=PqobGM5WVHeo0iWrCMd5Oua9wrGr0MRItVpu3I7unBU6lVoJG9IS8P2zoH9UrZK6CQ
         gkm1aNecxPX2k13d2jCGj3xhU7mQdLi5HVjH10Mq/gs2GctOxghAYaV7wjVp1VXQBt/L
         zw+p8UT3CyCVoWSK8/WjSyBzyuJ0P58YxD7nEI4LJzq8EtkfgkO4ZrrPDHfBLY7anVJ+
         oYzMSVVc3o7cnWNrnNnvRz15QkJnI7Ct0szSJXDdKXANw2YYbUgT1ujV928+ln/X3LDs
         sXjpKYGkc9FIM0BG5nVb5pwRtXNvcEA6s+fjqn8Fp0Y6rmctZGuuCSVKyWtWZlsgF+7u
         wkAw==
X-Gm-Message-State: AOAM532/pbtBwmAKkX0BFCBTE0vRCn/T1SG3SlyYHP+1wsvfhaX6hv4X
        6HQVwUYwLh9wMdr83bsIonY=
X-Google-Smtp-Source: ABdhPJyB2mh3Tl8wcItdVynl95uixjQ5gSbloQJscKVVCDQHi1TWabcRSPzxJFa4VifIWuIbrMF/yw==
X-Received: by 2002:a05:600c:3d13:b0:37b:b8e5:ed80 with SMTP id bh19-20020a05600c3d1300b0037bb8e5ed80mr16672940wmb.183.1646137005817;
        Tue, 01 Mar 2022 04:16:45 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b0037bf934bca3sm2929921wmq.17.2022.03.01.04.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 04:16:45 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] ext4: remove redundant assignment to variable split_flag1
Date:   Tue,  1 Mar 2022 12:16:44 +0000
Message-Id: <20220301121644.997833-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Variable split_flag1 is being assigned a value that is never read,
it is being re-assigned a new value in the following code block.
The assignment is redundant and can be removed.

Cleans up clang scan build warning:
fs/ext4/extents.c:3371:2: warning: Value stored to 'split_flag1' is
never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ext4/extents.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c0f3f83e0c1b..0d98cf402282 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3368,7 +3368,6 @@ static int ext4_split_extent(handle_t *handle,
 		return -EFSCORRUPTED;
 	}
 	unwritten = ext4_ext_is_unwritten(ex);
-	split_flag1 = 0;
 
 	if (map->m_lblk >= ee_block) {
 		split_flag1 = split_flag & EXT4_EXT_DATA_VALID2;
-- 
2.34.1

