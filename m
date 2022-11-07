Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF98C61F349
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiKGMbN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiKGMah (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:30:37 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8311B9E0
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:29:43 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 130so10455260pfu.8
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MjcZCvN/lfLd6qf7J9BhPaXmm8DKAs/HisJf7aYy1o=;
        b=YLXVudDBSoBEPWhTG+NXiPJs7QotfnYm3TMmhav3GiTIerEbwDAKpG/YLMa6Zfvvsr
         oMirVA4IcmMgHp0PRlEPgxSdiQwlI+H7L/9kvDIBX8VV5A4sMFCzAGPJHpygfh2uMGy3
         EenN49UzDOD0ZHu+foVAXm61YpDQKuqMKQPHlS+i9oyvQ/Kn8AHPjeu1tQgezY+WNrk6
         SHcUQPf6c0G+CFN8HcvwWC9lAnaSNLVOJweyXR+8F7blSzgcF705zU84vDHcn/x6pwPz
         S8YexEkePZiBGBS4Qx7QI/deqYsF4D4GCfXJkmOF1XwW4HRQZKtpj0m9hbcaQx0U4upr
         7iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MjcZCvN/lfLd6qf7J9BhPaXmm8DKAs/HisJf7aYy1o=;
        b=khLt7CEkVaYQo09MogPoMcudcAn7MQhpqteaaIMh38rh72/AOWyukZxK6ro+UZh4wS
         /ivlDIL6LWY47VcgXjNrm/b4kuH3ASUUJmH580F3pAY2odcsfhtaL+j5AknNSWTgaL7S
         znVotDK/rqyzec65R2X/fn73zhqxoatJv+cSasKazmnTih5jkHTU0vVli2Tkb7Iuc6XH
         eDka60UQY/n549Ls4LbdwgHmSVewNGYyJje52Bq6jC6iDpQroY36oIp5jSBFkT6eAy83
         RnSZUxPuF0sDBV3thN4WUV/zBrCbzXHYS7DXXszx9YxrIzdJ+VOijMU4sljFAhDxKprF
         jCXA==
X-Gm-Message-State: ACrzQf0eFS9E/Z2vDChp+I00wp0PanSH5QAUFyv+yEvpL8tF9Tz/HVQV
        t/VVPQohaTcow3bjxouHz10=
X-Google-Smtp-Source: AMsMyM5rckrwUV2UL3jhtaAchM2AD/H5Zj7Tl92BOVw4QWNP4IqqmrsRZYV6nux4NJzkt4mGBmbLWg==
X-Received: by 2002:a63:e045:0:b0:46f:e244:3136 with SMTP id n5-20020a63e045000000b0046fe2443136mr31109160pgj.95.1667824183080;
        Mon, 07 Nov 2022 04:29:43 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902710300b0017534ffd491sm4925875pll.163.2022.11.07.04.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:29:42 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 72/72] tests/f_multithread: Fix f_multithread related tests
Date:   Mon,  7 Nov 2022 17:52:00 +0530
Message-Id: <9757f60b44fa61367923b7094d91abfad40dbd4d.1667822612.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
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

With log_out() function now changed to print the message after the
pthread join operation, it is safe to also add "Scan group range"
related messages in expect files to compare against the pfsck output.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tests/f_multithread_ok/expect.1 |  8 ++++++++
 tests/f_multithread_ok/script   | 17 -----------------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/tests/f_multithread_ok/expect.1 b/tests/f_multithread_ok/expect.1
index 4742f408..cecc11db 100644
--- a/tests/f_multithread_ok/expect.1
+++ b/tests/f_multithread_ok/expect.1
@@ -1,4 +1,12 @@
 Pass 1: Checking inodes, blocks, and sizes
+[Thread 0] Scan group range [0, 1)
+[Thread 1] Scan group range [1, 2)
+[Thread 2] Scan group range [2, 3)
+[Thread 3] Scan group range [3, 4)
+[Thread 0] Scanned group range [0, 1), inodes 8192
+[Thread 1] Scanned group range [1, 2), inodes 8192
+[Thread 2] Scanned group range [2, 3), inodes 8192
+[Thread 3] Scanned group range [3, 4), inodes 8192
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
 Pass 4: Checking reference counts
diff --git a/tests/f_multithread_ok/script b/tests/f_multithread_ok/script
index 7334cde6..f14034cf 100644
--- a/tests/f_multithread_ok/script
+++ b/tests/f_multithread_ok/script
@@ -1,21 +1,4 @@
 FSCK_OPT="-fym4"
-SKIP_VERIFY="true"
 ONE_PASS_ONLY="true"
-SKIP_CLEANUP="true"
 
 . $cmd_dir/run_e2fsck
-
-grep -v Thread $OUT1 > $OUT1.tmp
-cmp -s $EXP1 $OUT1.tmp
-status1=$?
-if [ "$status1" -eq 0 ]; then
-	echo "$test_name: $test_description: ok"
-	touch $test_name.ok
-else
-	echo "$test_name: $test_description: failed"
-	diff $DIFF_OPTS $EXP1 $OUT1.tmp > $test_name.failed
-fi
-
-unset IMAGE FSCK_OPT SECOND_FSCK_OPT OUT1 OUT2 EXP1 EXP2
-unset SKIP_VERIFY SKIP_CLEANUP SKIP_GUNZIP ONE_PASS_ONLY PREP_CMD
-unset DESCRIPTION SKIP_UNLINK AFTER_CMD PASS_ZERO
-- 
2.37.3

