Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5C26FB401
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 17:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjEHPmw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 11:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjEHPmm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 11:42:42 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4608A64
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 08:42:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2acb6571922so26525161fa.0
        for <linux-ext4@vger.kernel.org>; Mon, 08 May 2023 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683560559; x=1686152559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pU3MyVcxC4FE8IDtgLQ5EJoKHTuAszvsZF+J0+YFmc=;
        b=fmyVwJV0lEr0gOVyjK7Zs2yARkiugtEIIx+DYwUHmOOFSBDoPcMej6cUQyGzl7KLDZ
         yVI9Uma+a53XuOlTYYnz5PJwx+iMR2eYE0NaxjvsG4gU3/ft0QFxfmCC7mImKNr6c3Zk
         qCddFae2O/g0P6kz1m37dO7vwePj7a0RorxuJxXhhvV1JuBdIEfzlzvWMPtcIiyn6wUV
         0IoKg5z1KQfJYr03iHosJVOonWWN/otaOmg6zqJlDt5bj5hRHCXa/nM113+/3UnpRZQP
         I+7fPr47yTjvKIKXtPKIouvfpH4ePrF9J95Oh4iX6lh25MxWW6IHYFOv8qTWCpC6i3wp
         YYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683560559; x=1686152559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pU3MyVcxC4FE8IDtgLQ5EJoKHTuAszvsZF+J0+YFmc=;
        b=YXuFE/j5zpAFIAQ5ou0yFCd7MCeqjlT9cjYdOvXQJqHPyP5JLb4julDYK0wnyICFax
         lqYNcN1teAkRhx8fxUFxgasMQf++P6LAXNuwjpHLPmywN8xUpbMiFUXrwymr5kqCY6qq
         RdJMSXDDZ2BL4308jLDhOhMQyXxtWIcvedhWWmpDKOt3t5BzY91avigQ/jcSF4q+vVLO
         m5T4VvjCHVeRGezt6Gaozh5bXkVM6JOHmnEIa0kW0BRH9VJHlw9I5abcHu2go1c2/836
         3ijLDBnLUraYNo9Xo/rjYpjjLTbAzHqv0OxxKIsZ71N8vMkzWIVStbNonUHI38OEcNcu
         bzmg==
X-Gm-Message-State: AC+VfDxYa7obkZbrR9ZT4Py6ec02BQOs8lEngWVIOu/mtXOpZQib1Jji
        Zsimr1MVvRlX7iOm38SwmR4CMQ==
X-Google-Smtp-Source: ACHHUZ6h6kvu6HAI2NpYck49HN3F1+F+0o3+VKGFl6dAG8ccfxCIlDuj80J+MkzIA7jF5MgIUTxxaw==
X-Received: by 2002:a2e:9d14:0:b0:2a8:a6a5:e26e with SMTP id t20-20020a2e9d14000000b002a8a6a5e26emr2931590lji.20.1683560559390;
        Mon, 08 May 2023 08:42:39 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id a21-20020a2e9815000000b002ad9b741959sm17720ljj.76.2023.05.08.08.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:42:38 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, joneslee@google.com,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [RESEND PATCH v2 4/5] ext4: fsmap: Do the validation checks on constified fsmap data
Date:   Mon,  8 May 2023 15:42:29 +0000
Message-ID: <20230508154230.159654-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230508154230.159654-1-tudor.ambarus@linaro.org>
References: <20230508154230.159654-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now that we do the sanity checks directly on the data copied from user,
we can also constify the fsmap data while the checks are in progress.
Do the validation checks on constified data, it imposes that the fsmap
data is not updated during validation and assures readers that nothing
strange happens during the validation sequence of calls.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 fs/ext4/fsmap.c | 8 ++++----
 fs/ext4/fsmap.h | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 463e8165b1e9..655379c96fcf 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -572,7 +572,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 
 /* Do we recognize the device? */
 static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
-					  struct fsmap *fm)
+					  const struct fsmap *fm)
 {
 	if (fm->fmr_device == 0 || fm->fmr_device == UINT_MAX ||
 	    fm->fmr_device == new_encode_dev(sb->s_bdev->bd_dev))
@@ -584,8 +584,8 @@ static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
 }
 
 /* Ensure that the low key is less than the high key. */
-static bool ext4_getfsmap_check_keys(struct fsmap *low_key,
-				     struct fsmap *high_key)
+static bool ext4_getfsmap_check_keys(const struct fsmap *low_key,
+				     const struct fsmap *high_key)
 {
 	u64 l_fmr_phys = low_key->fmr_physical + low_key->fmr_length;
 
@@ -607,7 +607,7 @@ static bool ext4_getfsmap_check_keys(struct fsmap *low_key,
 	return false;
 }
 
-int ext4_fsmap_check_head(struct super_block *sb, struct fsmap_head *head)
+int ext4_fsmap_check_head(struct super_block *sb, const struct fsmap_head *head)
 {
 	const struct fsmap *l = &head->fmh_keys[0];
 	const struct fsmap *h = &head->fmh_keys[1];
diff --git a/fs/ext4/fsmap.h b/fs/ext4/fsmap.h
index e7c510afd672..8325258def7b 100644
--- a/fs/ext4/fsmap.h
+++ b/fs/ext4/fsmap.h
@@ -33,7 +33,8 @@ void ext4_fsmap_from_internal(struct super_block *sb, struct fsmap *dest,
 		struct ext4_fsmap *src);
 void ext4_fsmap_to_internal(struct super_block *sb, struct ext4_fsmap *dest,
 		struct fsmap *src);
-int ext4_fsmap_check_head(struct super_block *sb, struct fsmap_head *head);
+int ext4_fsmap_check_head(struct super_block *sb,
+			  const struct fsmap_head *head);
 
 /* fsmap to userspace formatter - copy to user & advance pointer */
 typedef int (*ext4_fsmap_format_t)(struct ext4_fsmap *, void *);
-- 
2.40.1.521.gf1e218fcd8-goog

