Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D68261F308
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiKGMZn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiKGMZb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:25:31 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6390E1B7AA
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:25:29 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id s196so10319033pgs.3
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geMLgKNDbiQNg64oeoK/gVcmbGzDD8oHWu7l5dRAT/E=;
        b=NNQILbdmsGX5BuTvxqmvMfvJCElYOCI9m3KEDIMg3F2+HRoy3hBn5LFew4knl3XL2x
         yv19H/vg8JWTvrFnTe83cKhA6PoQoX+SktaP/jANF+OU9tQe5BaPrn+8Sj9k1Dg9EOm9
         iKdsXG4zpxWIwHglWtQ8Qo6z30FqFXpMzq/4toDPoh67QnTxdDGz8o3vtUL+443ol7IN
         b+hnWBSBmNIwQuD0SC406/48xtmTHK9dRC3y5I9qv3URo21QLE/iQVpw4pL9oDWL81aC
         90KDpCh4+g2+prisSYoArVj5FATXxYuD0K6BzXouZgHh3/nxPmRe7DJ9S6ezBST7Tnoc
         GU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geMLgKNDbiQNg64oeoK/gVcmbGzDD8oHWu7l5dRAT/E=;
        b=x2a3v3GAVzRbJiWDGMwLuclrPsNJbUu49axAVLj8RaBrZBEgddKw+ucWBG8R/XuOl7
         alDAgPqmCCgztYCvoaMygFeiE8V22A52IoEj5Udt2Q5HwY+8m+6mwrSIjxVzSowqffH7
         xpxb9uaQfPWOK5RMveQASteHWLmQSv6nFhyMDmQzS4B96nz6hCtz81kCd6njHM+jBpup
         5GUMIEDlbY6dPKzqlM0Z8UYs8wFDKQbi14gkCrp0FkyUQbEBPWofqSUAQhIaQr/LoyIa
         QymPk+vChyecW3WAtGF6F39Tiuo4xX24ozqpYksNkB4jHCgfDDzbqprUvRQX/MSqFMS/
         7mGQ==
X-Gm-Message-State: ACrzQf3tw3Z3VI4gyhigncL63NDDBCzIWp4YC8DAaKVzkKjK7pOL/zl8
        AyK2Z9JTnhyDjyh0pnhPm2CUheuhRdI=
X-Google-Smtp-Source: AMsMyM5CpFl1sDXt1/cJF8XcZCw1D1nhkzPWKvADeGWWc8qdp4ROJDW+/2EcycIqsw/oVSvHy5n6/A==
X-Received: by 2002:a05:6a00:170d:b0:56e:55de:9858 with SMTP id h13-20020a056a00170d00b0056e55de9858mr22360715pfc.17.1667823928924;
        Mon, 07 Nov 2022 04:25:28 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b0056164b52bd8sm4391441pfk.32.2022.11.07.04.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:25:28 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 30/72] e2fsck: split groups to different threads
Date:   Mon,  7 Nov 2022 17:51:18 +0530
Message-Id: <42bd4ff9929e4166ad5e7b2e36204c995521c9e4.1667822611.git.ritesh.list@gmail.com>
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

From: Li Xi <lixi@ddn.com>

The start/end groups of a thread is calculated according to the
thread number. But still, only one thread is used to check.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 3bb87669..3b411b70 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2231,13 +2231,14 @@ static errcode_t e2fsck_open_channel_fs(ext2_filsys dest, e2fsck_t dest_context,
 }
 
 static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx,
-					     int thread_index)
+					     int thread_index, int num_threads)
 {
 	errcode_t retval;
 	e2fsck_t thread_context;
 	ext2_filsys thread_fs;
 	ext2_filsys global_fs = global_ctx->fs;
 	struct e2fsck_thread *tinfo;
+	dgrp_t average_group;
 
 	assert(global_ctx->inode_used_map == NULL);
 	assert(global_ctx->inode_dir_map == NULL);
@@ -2276,11 +2277,20 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	thread_context->thread_info.et_thread_index = thread_index;
 	set_up_logging(thread_context);
 
-	assert(thread_index == 0);
+	/*
+	 * Distribute work to multiple threads:
+	 * Each thread work on fs->group_desc_count / nthread groups.
+	 */
 	tinfo = &thread_context->thread_info;
-	tinfo->et_group_start = 0;
-	tinfo->et_group_next = 0;
-	tinfo->et_group_end = thread_fs->group_desc_count;
+	average_group = thread_fs->group_desc_count / num_threads;
+	if (average_group == 0)
+		average_group = 1;
+	tinfo->et_group_start = average_group * thread_index;
+	if (thread_index == num_threads - 1)
+		tinfo->et_group_end = thread_fs->group_desc_count;
+	else
+		tinfo->et_group_end = average_group * (thread_index + 1);
+	tinfo->et_group_next = tinfo->et_group_start;
 
 	*thread_ctx = thread_context;
 	return 0;
@@ -2523,7 +2533,8 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	for (i = 0; i < num_threads; i++) {
 		tmp_pinfo = &infos[i];
 		tmp_pinfo->eti_thread_index = i;
-		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx, i);
+		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx,
+						     i, num_threads);
 		if (retval) {
 			com_err(global_ctx->program_name, retval,
 				_("while preparing pass1 thread\n"));
-- 
2.37.3

