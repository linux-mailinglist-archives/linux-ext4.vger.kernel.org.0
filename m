Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83476D2EF7
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Apr 2023 09:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjDAHxK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 1 Apr 2023 03:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjDAHxJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 1 Apr 2023 03:53:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9A9E042;
        Sat,  1 Apr 2023 00:53:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id r7-20020a17090b050700b002404be7920aso23878840pjz.5;
        Sat, 01 Apr 2023 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680335588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MvJ3b6Levpe3XaT1CiLfjcCIFyOXFlee6v0CyxBXTyw=;
        b=VYSCbPDXA6zq911VWx1Egu9LWOPU6qWuqAX74/cOCkcfBGRtjTY3EsbHACCWBKU5ok
         TmciVQlornTo0sWctWHoS1or7IDaWo+n2/av7YWHGuqb1HmcbXLYb2v7qVdBWICGgbZm
         uHOBESd5+abCXaXi3ZTvNqgVrCYR0Q/GNGqOZlA3G0hKokm18QL3eEwlcZRiq0W2x0ls
         3On0cyToAlHIg+vTRbRZQe1mXRvmngIi7sVMXP7AM3f9xnUzHxirmpjSR3hY379e6JT+
         g19RQ8PinbgOwOg/7AYd1xzfvFvJROrxYbKtH1QpLQQpwW1avYGq+dd+lnI4dLpKQYnT
         LlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680335588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvJ3b6Levpe3XaT1CiLfjcCIFyOXFlee6v0CyxBXTyw=;
        b=col58ZwnD9x8h27DCc0NeG+zeX6lNDOTf3eOwu7N7jwNBBxGYbqb7pfyai3fOzhqof
         qmGcGqU8YUthEhmjqM+9IrTBb/7aov0J1QLQQg09B/KFvFpoU+pPr9cYZBYT3Rri9Ojt
         5pjOtlCbSy0PCv/n2XbeZhXQg3gZGxvFAlilhvZ/P8UhGqcO3ArwCQPXUGUBR1gs7D+X
         gdPuAADlDzcNau+F+KhCCTqXsIIOq8Ouy2RMZfgN9dJRsuZsiECRRBzDyN1DLzFgsLwm
         6uPoMQKOhz59qESncWauDy+dZlVmkZrKAudVsqdxO6ieAT00KMtqvf68K/765l0Q9OpH
         lZUA==
X-Gm-Message-State: AAQBX9fWL79o7ELBgt6ymhKKtDum4Izm3Ts+0cK7HjQxBl2HEiFrFDGB
        m951kHV2C+WyT2fVQgzC1AM=
X-Google-Smtp-Source: AKy350YDzD+c5iAvo7tmXClY0LJAsYcJ+l/sNAG2J1hUHQcAk7lutg1MXWkFYKs+VI+JxoKtiGB4qw==
X-Received: by 2002:a17:902:e5d1:b0:19e:4bc3:b1ef with SMTP id u17-20020a170902e5d100b0019e4bc3b1efmr37151846plf.64.1680335588249;
        Sat, 01 Apr 2023 00:53:08 -0700 (PDT)
Received: from C02FG34WMD6R.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902eb4b00b001a0432ca99csm2752266pli.269.2023.04.01.00.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 00:53:07 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: remove useless conditional branch code
Date:   Sat,  1 Apr 2023 15:53:03 +0800
Message-Id: <20230401075303.45206-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It's ok because the code will be optimized by the compiler, just
try to simple the code.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 fs/ext4/bitmap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
index 87c1c8ae9298..cd725bebe69e 100644
--- a/fs/ext4/bitmap.c
+++ b/fs/ext4/bitmap.c
@@ -74,10 +74,7 @@ int ext4_block_bitmap_csum_verify(struct super_block *sb,
 	} else
 		calculated &= 0xFFFF;
 
-	if (provided == calculated)
-		return 1;
-
-	return 0;
+	return provided == calculated;
 }
 
 void ext4_block_bitmap_csum_set(struct super_block *sb,
-- 
2.20.1

