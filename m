Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0720A6080B5
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Oct 2022 23:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiJUVVN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Oct 2022 17:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiJUVU4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Oct 2022 17:20:56 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810041E046D;
        Fri, 21 Oct 2022 14:19:57 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a5so2878749qkl.6;
        Fri, 21 Oct 2022 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eoQ+HJKGIVrGgHy1uVnvkX42FIqL3myHCwc3psZGWlA=;
        b=L1BEnasvpTJu0ibTw1K1z3JregWmtUWc5SO5eX0FgG6qlQG3JbAHGeyg3qRrjyEWR2
         JJN4TE78DtSbfvptoWNMUPzDUjWG9ZPZVm7EuJUC6LyodAKdT9EUWZPyDZs9lgl3z/EH
         r0AbAkuolqPHL/ENI0BPu+ElwFxAJdTCeNvwuxLV8n7Pv9pykbomcUmyVXSHvuH27V32
         PnUDBQBe3nrmJ0W1wUL4LIm2IARNYRpBC6GvTracTILIHDfKZGyHoD+B8SJePMtwmb+c
         Gpo3oF5d3VjVJj97SfNw8WuHzUyq4lDQ22IXpNTGhXNf/veFdE8YPSB/DJGz4r0AwBbQ
         Tepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoQ+HJKGIVrGgHy1uVnvkX42FIqL3myHCwc3psZGWlA=;
        b=RgkDEtoQ2mYNAcxdrB0RSji5ogy3YktN8uw0sHc5V4CIXLyDrGQzIRcj/ipf4ILM35
         NkRDqMD+6yG4rOAuDNtSWLvgpjs4Ir4AwPWpkvX1Fe1SIUQfMuocvuRTl6fDZb+OUq0c
         Rx57Fw8yo6z2Qr/+8UgLteWds1UEt+/a/zc2Nqu0SWI2TSRcwlujy5v5wc1h4sbrgEsM
         ymbXX/vgeDQKpZkKxkW+p26zy9VWh7NQck1Fa8lT0LXo3PBBtXQKjixDPjxOPrg0CcrA
         Sdy7OTLidiTkaF6e5LZ7R4DgIDT6MGXFBT0Qmjh9HUjSCc8yjWpvO0Mkd6yecNz//qLf
         cNZg==
X-Gm-Message-State: ACrzQf2YL0aL7ozrKgy1CTdfUvHExcAsW0kzyKqYAR8s5O/L35xf2Gq3
        sSf2XpuDnd8/wOU8KxoOA2xtf0sTfLs=
X-Google-Smtp-Source: AMsMyM5zlvvv/FvODfWJi7qiFo2IZRNt7x2oWyGShBzelbwqUXM/J4YgNCPMKHbYbBuXctXMYFOGZg==
X-Received: by 2002:a05:620a:284a:b0:6ab:9cc5:cb4c with SMTP id h10-20020a05620a284a00b006ab9cc5cb4cmr15901390qkp.609.1666387194961;
        Fri, 21 Oct 2022 14:19:54 -0700 (PDT)
Received: from localhost.localdomain (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id de38-20020a05620a372600b006ce30a5f892sm10556329qkb.102.2022.10.21.14.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 14:19:54 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] generic/455: add $FSX_AVOID
Date:   Fri, 21 Oct 2022 17:19:50 -0400
Message-Id: <20221021211950.510006-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

generic/455 fails when run on an ext4 bigalloc file system.  Its
fsx invocations can make insert range and collapse range calls whose
arguments are not cluster aligned, and ext4 will fail those calls for
bigalloc.  They can be suppressed by adding the FSX_AVOID environment
variable to the fsx invocation and setting its value appropriately in
the test environment, as is done for other fsx-based tests.  This
avoids the need to exclude the test to avoid failures and makes it
possible to take advantage of the remainder of its coverage.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 tests/generic/455 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/455 b/tests/generic/455
index 649b5410..c13d872c 100755
--- a/tests/generic/455
+++ b/tests/generic/455
@@ -77,7 +77,7 @@ FSX_OPTS="-N $NUM_OPS -d -P $SANITY_DIR -i $LOGWRITES_DMDEV"
 seeds=(0 0 0 0)
 # Run fsx for a while
 for j in `seq 0 $((NUM_FILES-1))`; do
-	run_check $here/ltp/fsx $FSX_OPTS -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &
+	run_check $here/ltp/fsx $FSX_OPTS $FSX_AVOID -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &
 done
 wait
 
-- 
2.30.2

