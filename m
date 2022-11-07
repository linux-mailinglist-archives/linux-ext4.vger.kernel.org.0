Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77BB61F332
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiKGM23 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiKGM2Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:28:16 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5742140F6
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:28:15 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so9572266pjs.4
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtXmD/lEl778OTe8VYWxOkNds5J1K1V5LHDiok1FnYM=;
        b=Kxz3xD7WwfSPZlUxKcITjoSiSeITQJR1+THK00JSuyp8C0PDmoUtY8lmQZ1UBTKMAP
         cXk0Zh6wiExpaQRCbtQV5Sr0WPeyQTAvR3D9GZAdJ6wUBBDs73CQvNADbKWMB2r/QlGR
         e0JzDPuLS5LaCUa1vE8f35HrysYflm/m73DSttJYRSZY1ZVDBf3W4ILlbySGSUlkY50e
         enebH91FAdIb8XR+UALwXoasbN+BFFDImvecZePXruNO3DI2pc6xgI/cKs2b8FDUHcJY
         G2sEyDLimbDdO49ClfyWGGIy+Fyyo9GeDCMSzFDWZUAtXAjryHHBE/kAvkEqd9njRHv6
         tOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtXmD/lEl778OTe8VYWxOkNds5J1K1V5LHDiok1FnYM=;
        b=i+AsLz2+IWiRRgoJ2kH+DAhBNFs/npUwG4UydxnIHAeA08WtrXPd5VNzw8XVsYOFgG
         dEmJfOD/j54EVSbSOWnl4up93bL0l9skMRKs8dZcW/9mOqXg1iNK+Abqhb/RWx49dO5U
         qDiwSirChIUiBhQDveTMTZLa6y8UjRybWvrATevCtGxbtOFJ2W39R2hmS5wb49Ftn5fn
         kN5ItM3zY9b1TYQThmA8TYuBRqkYbhcNf0WBICZhp2R0YAmOfoL0VRxERhZ5C/H2Lrnk
         a0kkrBgOg3YccCiQcmFs2a5JXnvjp8AmVGPiOyw588opeBEh59gzI0xlDViaqVZ8aAOE
         frcQ==
X-Gm-Message-State: ACrzQf1OOvbJkvJ6jAbMz6HYrPZTuUuPyPrlyrCK7U7oTCgLQUek79+e
        Z1ya9zOEEqojFgLG+hhOuX0=
X-Google-Smtp-Source: AMsMyM5DqbpwtzYuU40o4T7Y+UmmzJID0dWzNkQz5edvjaAY2XAvxVt/rzzYE8Mgg0HZ3a7lCWuocA==
X-Received: by 2002:a17:90b:264e:b0:212:d06f:35ad with SMTP id pa14-20020a17090b264e00b00212d06f35admr52612000pjb.2.1667824095649;
        Mon, 07 Nov 2022 04:28:15 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id s23-20020a632157000000b0046ec0ef4a7esm4113356pgm.78.2022.11.07.04.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:28:15 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 58/72] e2fsck: make default smallest RA size to 1M
Date:   Mon,  7 Nov 2022 17:51:46 +0530
Message-Id: <c71995ce6233b88ed838d64ed894624cd7ee2687.1667822611.git.ritesh.list@gmail.com>
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

From: Wang Shilong <wshilong@ddn.com>

If we have a smaller inodes per group, default ra size could
be very small(etc 128KiB), this hurts performances.

Tune above 128K to 1M, i see pass1 time drop down from
677.12 seconds to 246 secons with 32 threads.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/readahead.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/e2fsck/readahead.c b/e2fsck/readahead.c
index 38d4ec42..40b73664 100644
--- a/e2fsck/readahead.c
+++ b/e2fsck/readahead.c
@@ -234,6 +234,8 @@ int e2fsck_can_readahead(ext2_filsys fs)
 	return err != EXT2_ET_OP_NOT_SUPPORTED;
 }
 
+#define MIN_DEFAULT_RA	(1024 * 1024)
+
 unsigned long long e2fsck_guess_readahead(ext2_filsys fs)
 {
 	unsigned long long guess;
@@ -245,6 +247,8 @@ unsigned long long e2fsck_guess_readahead(ext2_filsys fs)
 	 * in e2fsck runtime.
 	 */
 	guess = 2ULL * fs->blocksize * fs->inode_blocks_per_group;
+	if (guess < MIN_DEFAULT_RA)
+		guess = MIN_DEFAULT_RA;
 
 	/* Disable RA if it'd use more 1/50th of RAM. */
 	if (get_memory_size() > (guess * 50))
-- 
2.37.3

