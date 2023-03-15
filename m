Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B4A6BAF21
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 12:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjCOLV1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Mar 2023 07:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjCOLUo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Mar 2023 07:20:44 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A800E28EBD
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 04:20:21 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id l22so941240ljc.11
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678879219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD1TrUFsitp4Y2rIDkz8d+k4TLKMnp8ZdEcKQDmrU+A=;
        b=lRxITs9OiKl1Ysyh+/cM4h+R29EIH/VYT53jOTSvhWdSSbHqQrKxsmgdKVjD0eD0KH
         VrelXQehTqmK+63LekoeNIeonFqFwlorEgEoX+pfFs5aQOKVgQRFmeMlU6oyGyIX24Zj
         GN+H+tEyk7BNC7TbGKHX6cvYKS6hBnWOQkDQxHt/03OCsB/yT0nRkA92YN2h1SDSklmf
         WSBzJYOIrl3HAJY9aQ/taUVqK8MH2fgDm4Yz3IknVnL+QBJhJ4c2VRZk9aBh4lpJB66L
         8/nD6gJoTbaQhr9lPmnVD5gOWPSHiiCAanke4AqyE8/M81+qupJOgXczbLKSvTmFbtcw
         h6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678879219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD1TrUFsitp4Y2rIDkz8d+k4TLKMnp8ZdEcKQDmrU+A=;
        b=KsXJCNmSxq+MjU2XEWBa9x1JQgMxu1i/YkLdC6uch5UU2CFYmxtRMnvtZZOwEpgs7Z
         vN/SZ8WLQo2O7WwDRSW+km2SsNqFJeQnMlCgntUX5DiI6w5Y8j7mqT5WA2/AiBTk9dOj
         dKWykGV+65Qr0BIb0apQNmWIK+YcEvR7TFeY2z1aO5p1xcDRibIqdxqX9rw4zTN4nDSh
         AuxTM9p1bw3tKUDLMuzwpMcScEmZ2T/Sb3vIVLVrPwg9Qfi48G9VK7QSAcl6e5aml3U8
         F8ANbN4Hlvdh6vK8kY/QTxtiPvGp12pFdCaKI6Yqr6OLDkKTSYn3NzCxBXMBz6RQiwA4
         ATQA==
X-Gm-Message-State: AO0yUKXY0x+OzHmVNPAmdQq1YDu517DorWFbb9ZImDmuHIrp+PsmbbV9
        gc8byJ7Y32kpDmRqgeHu85hbbw==
X-Google-Smtp-Source: AK7set/dxpOdZZEzCrboesb2MjWDhhCWhkYufq+wCWXPN7sdwtZgkVykEfKSk498WuC7ZTbgmmx8QQ==
X-Received: by 2002:a05:651c:19a5:b0:294:7360:7966 with SMTP id bx37-20020a05651c19a500b0029473607966mr1035521ljb.30.1678879219323;
        Wed, 15 Mar 2023 04:20:19 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id k2-20020a2e92c2000000b00295da33c42dsm817410ljh.15.2023.03.15.04.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:20:18 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        djwong@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        leejones@google.com, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 5/5] ext4: fsmap: Remove duplicated initialization
Date:   Wed, 15 Mar 2023 11:20:11 +0000
Message-Id: <20230315112011.927091-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315112011.927091-1-tudor.ambarus@linaro.org>
References: <20230315112011.927091-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

All members of struct ext4_fsmap_head were already initialized with zero
in the caller, ext4_ioc_getfsmap(), remove duplicated initialization.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v2: no changes

 fs/ext4/fsmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 655379c96fcf..d19d85be3404 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -666,8 +666,6 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 	int i;
 	int error = 0;
 
-	head->fmh_entries = 0;
-
 	/* Set up our device handlers. */
 	memset(handlers, 0, sizeof(handlers));
 	handlers[0].gfd_dev = new_encode_dev(sb->s_bdev->bd_dev);
-- 
2.40.0.rc1.284.g88254d51c5-goog

