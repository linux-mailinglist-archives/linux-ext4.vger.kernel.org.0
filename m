Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05166BAF1A
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 12:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjCOLVS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Mar 2023 07:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjCOLUj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Mar 2023 07:20:39 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E876A4B
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 04:20:17 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b10so19070798ljr.0
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678879216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdbCGpzcwXFV3fnMO5Bmrr81xmSMDuWW3p9DWdnxYHE=;
        b=invwL+l/ceKSm9QLOoajkPlSvh2xoygCdaCZEWSJLhxgT7Ofd6fkQFA0o4iK5htY6P
         lWcb9GEU+o6XLCGmoF3BtJQZmZStIKeUoXuiWNC/x36Rh+O65g8FXI7qVMCQr8SU1e07
         FCB9DMD+RwuGKcbxCjiIucK+dIreZYY2ChyjbuBEDbUuQa17mkx3Nv1G6HGGunAIX7WH
         BHuMTIXpVJL0jxepJer2y24lo0GxwsvcmZhJy5xyk4rYbt3r5mIsxx0FfMFWniEG5m3r
         6X1stS2d2St8qqLcBIno+YfMqWZTxz7a1RQJYYiXSAqGj8JT3+0gLMYdq3QRVrqMCnnV
         8RCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678879216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdbCGpzcwXFV3fnMO5Bmrr81xmSMDuWW3p9DWdnxYHE=;
        b=uLyJ2TgIG56Cpg8nN/KEl57jrKrCiQz1LMrh65MW8YYeqdUUUYu3Tp0Fs6OpRNEM3D
         bQzEapZPsCPVp+OFoTdlrEeuWxuzZlfmG8Xo7LXihp0ZifivdQm+kKHJoO8Ltif1qqPr
         uOsAgqkrGw9qbJo8vJI5jVWRWPFUdKY76nR5icZh23sSaDRSgQJCNiZNXjTlJuGCanzZ
         v/LaWKkiPAtlQ6xZtjyfDz1ZXwBHlTEZVlGTTsR8WHACoGEpfAaO50A3mX8kazNRyGgi
         DwK9R/QI4Call2AwpYO6OrikjrB7iYAvpouVVgRXEADdyjQZ4Kx7cXKFPzIAwmpWEJ2N
         oyRA==
X-Gm-Message-State: AO0yUKVe0OyXwM+ZSqJn/Bw4CUFmkv+WAEOygNJ4D6t1yJPJjJmLO6Gv
        Nw0DxEET9/+6sdds0dTkUIH1LA==
X-Google-Smtp-Source: AK7set8gFNmM6XjQjWseytCpp8qBAUM8i1QLIEmEGYqkUZ9g5GZ/bfhdFrO5nitEJjJx/XMyj38qFg==
X-Received: by 2002:a2e:a58b:0:b0:295:9f20:bcdf with SMTP id m11-20020a2ea58b000000b002959f20bcdfmr1022793ljp.9.1678879216366;
        Wed, 15 Mar 2023 04:20:16 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id k2-20020a2e92c2000000b00295da33c42dsm817410ljh.15.2023.03.15.04.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:20:15 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        djwong@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        leejones@google.com, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 1/5] ext4: ioctl: Add missing linux/string.h header
Date:   Wed, 15 Mar 2023 11:20:07 +0000
Message-Id: <20230315112011.927091-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315112011.927091-1-tudor.ambarus@linaro.org>
References: <20230315112011.927091-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4/ioctl.c uses strnlen(), strncpy(), memchr_inv() that are defined
in linux/string.h, but those were being included by sheer luck, indirectly,
via <linux/uuid.h> which includes <linux/string.h>. Add missing header.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v2: new patch

 fs/ext4/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index cc17205f7f49..2b412f1cbc10 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/iversion.h>
 #include <linux/fileattr.h>
+#include <linux/string.h>
 #include <linux/uuid.h>
 #include "ext4_jbd2.h"
 #include "ext4.h"
-- 
2.40.0.rc1.284.g88254d51c5-goog

