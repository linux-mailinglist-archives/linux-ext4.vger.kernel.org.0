Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D497161F305
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiKGMZc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiKGMZR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:25:17 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E893314D05
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:25:16 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y13so10442838pfp.7
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfEeEEDfQCyUEF0iTzgW5irU43t9MpNBB/mcyhT3TkI=;
        b=Iz1aVJ1nXiNshUDdVU9mpVLufYdsHQhBslODYVRTTpwxupIhE5220aToKmjJecIqJF
         KaN+wuHRUttD9p0cVl/3f83J6Q8sF3WlxPVRmFqtshws/VzPDmVyMfIb/oGLVzcYR88h
         qwMbaqyxz7x49CgVZNVApPgsJsr9fpi6lS3nG2Kr9pjT7fmXIIxIZJNyIJdmHM8QSQ1P
         zSc9t31fadDT7cKEmwjAZHHbezu4W91yTEaWN3wXEvmPlq384r8ma29yeeRjWnm9cX7Q
         KBivDSykk2mXtDLxz66ddu+YNLUBFS/uli6yTrlCyW4LLYmEys7R/CEDqXBXLkhQEJoq
         vg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfEeEEDfQCyUEF0iTzgW5irU43t9MpNBB/mcyhT3TkI=;
        b=s7fFMxh+4ihw0dHT68WVcPu+fBC63k0lCCMDwaIlzFYOsdKuenma5o/nnVyDzknmQa
         4IZJryK6NmD6UFV/pt5AEqah5qRVQpiVCftN8VIClJ//0MQJA+rLxYEJ/obZaa9mUPvQ
         zrbluPo60u+CU37U41Bx8XlE6DGTwDLUukvt7EFQHnVXl1JOy4MtoHgVQEYy3yfUkf8Y
         kRAqqqc2cQwK1jDAO9IKFM4DsT8EzFfGzOjRMC/g8NOIeaiDLazqoxzpADKBfzG741dp
         SD/1f9MFaSn8mPvODofz2KSTQpGQsWq1HDqJHXVThf0P3W/SHs68QqBWbu+PHU86dqDK
         v7LA==
X-Gm-Message-State: ANoB5pmvM5LA2supm40fpHuFdoHZ6kBNfZGe6RaIi3YE4iu/ZfQSr+U8
        yPb/YBv+7wk1LhDIZGFMRd0=
X-Google-Smtp-Source: AA0mqf47GaxC3ZTW6XixEcicI/nVoTZl7n8X/5ulj5NDxLsxbK/8Wl+GvkqOO8AUPxgl7pTbE5yzOA==
X-Received: by 2002:a63:1607:0:b0:470:6934:e853 with SMTP id w7-20020a631607000000b004706934e853mr7151836pgl.237.1667823916334;
        Mon, 07 Nov 2022 04:25:16 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id y28-20020aa79afc000000b005627ddbc7a4sm4364810pfp.191.2022.11.07.04.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:25:15 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 28/72] e2fsck: Add asserts in open_channel_fs
Date:   Mon,  7 Nov 2022 17:51:16 +0530
Message-Id: <df1bd1ff181cf98b9bd5318632b7353b12174a1c.1667822611.git.ritesh.list@gmail.com>
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

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 9a273515..ea432ff2 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2190,6 +2190,18 @@ static errcode_t e2fsck_open_channel_fs(ext2_filsys dest, e2fsck_t dest_context,
 	io_channel_set_blksize(dest->io, src->io->block_size);
 	ehandler_init(dest->io);
 
+	assert(dest->io->magic == src->io->magic);
+	assert(dest->io->manager == src->io->manager);
+	assert(strcmp(dest->io->name, src->io->name) == 0);
+	assert(dest->io->block_size == src->io->block_size);
+	assert(dest->io->read_error == src->io->read_error);
+	assert(dest->io->write_error == src->io->write_error);
+	assert(dest->io->refcount == src->io->refcount);
+	assert(dest->io->flags == src->io->flags);
+	assert(dest->io->app_data == dest);
+	assert(src->io->app_data == src);
+	assert(dest->io->align == src->io->align);
+
 	dest->priv_data = dest_context;
 	dest_context->fs = dest;
 	/* The data should be written to disk immediately */
-- 
2.37.3

