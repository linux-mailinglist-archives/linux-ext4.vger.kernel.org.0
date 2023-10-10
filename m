Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC957C0442
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Oct 2023 21:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjJJTQm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Oct 2023 15:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjJJTQl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Oct 2023 15:16:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BA693
        for <linux-ext4@vger.kernel.org>; Tue, 10 Oct 2023 12:16:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-279294d94acso151435a91.0
        for <linux-ext4@vger.kernel.org>; Tue, 10 Oct 2023 12:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696965400; x=1697570200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6DuA6Di48LsecCWb2Z6B9lzw4WLvU3f3Olx8PIYQfV0=;
        b=ljeSEHwP1WwZFv2DNj/oVzoYD5F2A2Frc4zuMaqzfNejyhhI1FNF7po1lrq47Rl8Uf
         221ZivkXOONXucbf8YafP2clSQW5ZFHLbAk/7fJYxKbmKMJNQPZ5fys8NWdt1d9Su5KL
         Dt3rurvotcjsuAFvsgmnlBvypke+f2mtHcP1rug8tFaSbq1OCrUw7cIbo+GpTeJiOlv5
         PajlFs7DJCzEf5RIYjNhXED4vXzQLYrSsf3Qr48iHpoyW09Xr/yMdd8RVErX++y7UUQt
         MCFEEXyxy6DywZhs860aENTc7StWODOtG1DlWAP4NyUou/AdsBTNtzKYM+47DShJ9D8o
         oqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696965400; x=1697570200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DuA6Di48LsecCWb2Z6B9lzw4WLvU3f3Olx8PIYQfV0=;
        b=N3XN+YqQFTIuSs1Flr/6PhWQ8XYkAiOEPXSexdneq/nD3euHFrmhxzdkiMNUfnlsIq
         Bd5ZnBUeUSOTKLgR3qBopuJdvvpXr/L5tId2Wq4f9crbvGLENIMTjNUQPtnFSvQdlCxC
         RWXdT0qrjHa6KTG3YVk3UNDlcDLuiVxM788owO9S1PjkpJhfU92SOmxmBJ40r2hdx3wq
         5iWYwsTCDKgmqs0OeuntAatvUx9vffvm/5e3uE4wqQqi2B1NzAysdfQy9kdMzzfFc2B5
         6+VYd0q+LCGK0hoo6sIw/BOpxRvCXvTE0QKMFoXTLC1KpGv7q99J+TqBA3pTM9M5kPjZ
         KYBA==
X-Gm-Message-State: AOJu0YyvexGQ4daP5g424SeroiWTC6hNUOEgB1LtFLjhNuTFz97v2TuZ
        40+0ZTDNHaTsgq7GSz/GPjo=
X-Google-Smtp-Source: AGHT+IGvGKXue9v0mHkgRomg1/LvGKfDCVrtVdbd6onJeISc3YbLwc58LUHRQzqYE0RqbL4oZoVULA==
X-Received: by 2002:a17:90b:1c0f:b0:261:2824:6b8c with SMTP id oc15-20020a17090b1c0f00b0026128246b8cmr23185436pjb.13.1696965399965;
        Tue, 10 Oct 2023 12:16:39 -0700 (PDT)
Received: from dw-tp.ihost.com ([2401:4900:1cc4:c403:d76d:9a77:e4fd:36be])
        by smtp.gmail.com with ESMTPSA id l19-20020a17090b079300b002791491f811sm10373001pjz.8.2023.10.10.12.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 12:16:39 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 1/2] kvm-xfstests: install-kconfig: Use $ARCH-config instead of $KERN_ARCH-config
Date:   Wed, 11 Oct 2023 00:46:30 +0530
Message-ID: <060d9fef332979fd5d53b1c28c13b2043a16ab25.1696965271.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

$KERN_ARCH is used for make arguments. For configs let's use
$ARCH-config. This should not break anything since as of now we only
have arm64-config for which $ARCH and $KERN_ARCH is same.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 kernel-build/install-kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel-build/install-kconfig b/kernel-build/install-kconfig
index fc2a49a..f5b2b8e 100755
--- a/kernel-build/install-kconfig
+++ b/kernel-build/install-kconfig
@@ -140,8 +140,8 @@ fi
 
 FILES=("$CONFIG_FN")
 
-if test -f "$KCONFIG_DIR/$KERN_ARCH-config" ; then
-    FILES+=("$KCONFIG_DIR/$KERN_ARCH-config")
+if test -f "$KCONFIG_DIR/$ARCH-config" ; then
+    FILES+=("$KCONFIG_DIR/$ARCH-config")
 fi
 
 if test -n "$DO_BLKTESTS" ; then
-- 
2.41.0

