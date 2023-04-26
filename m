Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CD56EFC57
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Apr 2023 23:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjDZVU1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Apr 2023 17:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDZVU0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Apr 2023 17:20:26 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F90F3AA9
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 14:20:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3047ff3269aso2516232f8f.0
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 14:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682544020; x=1685136020;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4VKVpabQrboxLfV4iw1mZ9CD5+VWtknVFuZEmDTO00=;
        b=J8buaGHpK9UQEWDrb6jvWQKKQYPsN7MJolOCJ9FK/S+X260bRobYn8Prodeax3ajLQ
         dnXZ86crbh/RURZiY2NDRa6Z7uP9LroFAYhrBC8bJxvTLMzHsJR20b/DoUtiUQvAdHdw
         HrM+33rZbKToxbkFJNeDOP3ONINNIj7XsT1gl/+nEWQqmG+TuH4gxPfUQcnIIPefulBD
         lq3ovhfJOvZGyGmHjppz7B97R8ChKK3BTt3IMQyjIOBl0ZThLDRFQVwGqt1l9KidH9/9
         VCLzdQ3z9c71yu/U6z02W1oOwfRnx/XJbdhxYAIcE0BCsy+kPLExFFsQEqNilT/uG8QK
         sSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682544020; x=1685136020;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p4VKVpabQrboxLfV4iw1mZ9CD5+VWtknVFuZEmDTO00=;
        b=esi7kqifIAWa7gcTpoBuvSF//XoAa+p81Ua1U6wK1StCb+yBbAuIvSq/tQabU8nXCr
         Pzx4RH99oSzQHwQPBrCS/QtjGu1EhgeGYz1Moz1dTGYUqyF/xuFQ1VipCDjBtvy5bXbT
         f9pEbzW4kIJHhlYO6M2QPTGinav+UMPHGrqAQNoKMesMYpftfMrx5BcC+xJljffsvIQj
         05GWn4b2W3M12dJSYzSUgHWi9Ftr/3jbHGYSNB+YG8PP72H2jotZtY1rVD/qjIYSqWBz
         5CaIFDJtsU19FS9OpX5dcv5LpCFI6ctmDxSeO7c0khud7Qn//z91dfvHn2UOviWQZxxn
         vY2A==
X-Gm-Message-State: AAQBX9fJ8QsQjw/pSRIbpvItkQp/QsHjKKn8eKMxHgtu1CJZFhYZHtrP
        OeGaG9gimi5QczC4XzcMtr0=
X-Google-Smtp-Source: AKy350ZUabrMdP19iUQQSiXY58tL/bkfHBG5FMtRqsQXesR3sUyc4QS4QiOylKj6OFOwjl1wu987xg==
X-Received: by 2002:a5d:65cd:0:b0:2f0:2dfe:e916 with SMTP id e13-20020a5d65cd000000b002f02dfee916mr14899198wrw.9.1682544020353;
        Wed, 26 Apr 2023 14:20:20 -0700 (PDT)
Received: from [192.168.1.10] (95f1f744.skybroadband.com. [149.241.247.68])
        by smtp.googlemail.com with ESMTPSA id v21-20020a7bcb55000000b003f16f362ae7sm19153105wmj.21.2023.04.26.14.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 14:20:19 -0700 (PDT)
Message-ID: <7ca8f790-c14e-6449-f3b5-4214d3fb1e61@googlemail.com>
Date:   Wed, 26 Apr 2023 22:20:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-GB
To:     "tytso@mit.edu >> Theodore Y. Ts'o" <tytso@mit.edu>,
        yanaijie@huawei.com, linux-ext4@vger.kernel.org
From:   Chris Clayton <chris2553@googlemail.com>
Subject: [PATCH] fs/ext4/super.c : fix two compile errors
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

dcbf87589d90 results in 2 build errors in fs/ext4/super.c because, in both affected
functions, a variable is left unused if CONFIG_QUOTA is not defined. The patch
below fixes this. It is compile tested only.

...
  CC      fs/ext4/super.o
fs/ext4/super.c: In function 'ext4_put_super':
fs/ext4/super.c:1262:13: error: unused variable 'i' [-Werror=unused-variable]
 1262 |         int i, err;
      |             ^
fs/ext4/super.c: In function '__ext4_fill_super':
fs/ext4/super.c:5200:22: error: unused variable 'i' [-Werror=unused-variable]
 5200 |         unsigned int i;
      |                      ^
cc1: all warnings being treated as errors
...

Fixes:  dcbf87589d90 (ext4: factor out ext4_flex_groups_free())
Signed-off-by: Chris Clayton <chris2553@googlemail.com>

--- linux.git/fs/ext4/super.c.orig      2023-04-26 21:36:22.624283246 +0100
+++ linux.git/fs/ext4/super.c   2023-04-26 21:38:52.888289558 +0100
@@ -1259,7 +1259,10 @@ static void ext4_put_super(struct super_
        struct ext4_sb_info *sbi = EXT4_SB(sb);
        struct ext4_super_block *es = sbi->s_es;
        int aborted = 0;
-       int i, err;
+#ifdef CONFIG_QUOTA
+       int i;
+#endif
+       int err;

        /*
         * Unregister sysfs before destroying jbd2 journal.
@@ -5197,7 +5200,9 @@ static int __ext4_fill_super(struct fs_c
        ext4_fsblk_t logical_sb_block;
        struct inode *root;
        int ret = -ENOMEM;
+#ifdef CONFIG_QUOTA
        unsigned int i;
+#endif
        int needs_recovery;
        int err = 0;
        ext4_group_t first_not_zeroed;

