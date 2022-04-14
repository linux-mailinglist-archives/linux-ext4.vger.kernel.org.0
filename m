Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B275016CA
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Apr 2022 17:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239482AbiDNPLo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Apr 2022 11:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352195AbiDNOcD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Apr 2022 10:32:03 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A37DC6B63;
        Thu, 14 Apr 2022 07:23:08 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id b17so4095134qvp.6;
        Thu, 14 Apr 2022 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZIfbqCkK8itsIT7Q5d8AIuSayGB/OVavfsWoJDbnUc=;
        b=JRc273q6YNzANWqENnCB9nu3M8D/PtUAt0xRoK0CYW9MA5uK3MQTEEYe1nZMKKGfSx
         J0LM9zHUi5DUlALK6hX2pdIZRM1YkGwvYzPyMvXbctxmslT7TsqjRD/P3LkWyPL9ovhS
         J3Ivakt62Rpi83/p0/I/3SFjGtlG7Lajbip4ip6ijGtg0gvXdeaLS0VtEdM8jO48ZIcv
         6B1JcOUbXatZ/n7SmErWpDx/lBYdisay/GBmKUjUCpwpx4nZBdOKZwvlgYZmOwcH4hGt
         4mTjVR+ii0thQBZoBlyf/44YbLysXxzSPl3ECYfzufzcdjryq8ak1bULHaBhAuIrBGq9
         OSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZIfbqCkK8itsIT7Q5d8AIuSayGB/OVavfsWoJDbnUc=;
        b=YseM0DgCDfLq9TFo6MbYhVnREgxlJ3I59/az3Ywbus4HNSf79F1HfiU3CBu5vNyrjj
         Yxo9F1pKSXz2ei/VgMekHuhOSPsBynetjZnxpIWL2uQ7iuUUcTAyRRyC7xevqBVFUvM4
         kRyWlSqcWZ6jbjnOHdkba+c4EPSNoxaXpiUD+Ta2cvdSJUHw/hsWPsGogz1xcYwV7w2E
         V9kPaqQxU4jV5LRqgcXvLAVd7gRYNV8YjSYyc0cH9JmpOA07D1EYWrTBfreKa4wQvtRa
         YSiLod75qloWmlLcdEGmW4khpo8SWUTxJt1V1LuLtoXwbZiWmFfPOmVz5SYhVo4UFL2E
         6pvQ==
X-Gm-Message-State: AOAM532CkTSIbuwf34GcPHl2BLWkxkBUdVd+bGd9+EKKknwinB6D2Rkz
        W4zZl8mIlMvKVcLdQk4eA2WFyRn6eAM=
X-Google-Smtp-Source: ABdhPJwAEtTIDIA3/OgkKAO+/qhk9NaL1Fys6vW4ZSqf6AniejHm0OMJKRpGOTy4M/j3WauRt6O7AA==
X-Received: by 2002:a05:6214:1d22:b0:440:cccc:8212 with SMTP id f2-20020a0562141d2200b00440cccc8212mr3458698qvd.78.1649946187418;
        Thu, 14 Apr 2022 07:23:07 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id m4-20020ac85b04000000b002e1dcaed228sm1207413qtw.7.2022.04.14.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 07:23:07 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] common/filter: extend _filter_xfs_io to match -nan
Date:   Thu, 14 Apr 2022 10:22:58 -0400
Message-Id: <20220414142258.761835-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
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

When run on ext4 with sufficiently fast x86_64 hardware, generic/130
sometimes fails because xfs_io can report rate values as -nan:
0.000000 bytes, 0 ops; 0.0000 sec (-nan bytes/sec and -nan ops/sec)

_filter_xfs_io matches the strings 'inf' or 'nan', but not '-nan'.  In
that case it fails to convert the actual output to a normalized form
matching generic/130's golden output.  Extend the regular expression
used to match xfs_io's output to fix this.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 common/filter | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/filter b/common/filter
index 5fe86756..5b20e848 100644
--- a/common/filter
+++ b/common/filter
@@ -168,9 +168,9 @@ common_line_filter()
 
 _filter_xfs_io()
 {
-    # Apart from standard numeric values, we also filter out 'inf' and 'nan'
-    # which can result from division in some cases
-    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([infa0-9/.]* [EPGMKiBbytes]*\/sec and [infa0-9/.]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
+    # Apart from standard numeric values, we also filter out 'inf', 'nan', and
+    # '-nan' which can result from division in some cases
+    sed -e "s/[0-9/.]* [GMKiBbytes]*, [0-9]* ops\; [0-9/:. sec]* ([infa0-9/.-]* [EPGMKiBbytes]*\/sec and [infa0-9/.-]* ops\/sec)/XXX Bytes, X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/"
 }
 
 # Also filter out the offset part of xfs_io output
-- 
2.30.2

