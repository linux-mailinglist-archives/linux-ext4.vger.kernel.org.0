Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6EB61F2FA
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiKGMYi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiKGMY0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:24:26 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E826405
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:24:25 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id m6so10485950pfb.0
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZkG8P7csv70+FWzJ0hhPsFK2Mt9vIPNTt8Dycvfo50=;
        b=qaICZGkGuVj5BkgAM3pzst4KYS/Dl+SCU+jpAseiLBv2P/c/0ne73badfeEF8JALBY
         77u79sBcJN0A+QSq6fBIpgUk4tTYNNp//Yjoq3iVDqIPU2pde+ba7g+6VwY0A8yDPHce
         GZs4eMUinXZV6Adn+I8oWM5XcF+QhtAYZkRTrArbjP287e3KiTWaQ8l0+udMk/E4/a+Z
         a1tRebCNSUs/7O7NuyClSogxV26N0Js2wESHdS05QQEtYPRpsYrmslzWndFJDxGDJOQe
         gR47zQmaeBB5NXXOSrGhAPZh5jhox5ECRnRneRMYFR5/0mjdTPvNNqXNqdaJaHaTihZM
         xm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZkG8P7csv70+FWzJ0hhPsFK2Mt9vIPNTt8Dycvfo50=;
        b=n2tgowRVVOQsNjYeq/gRrlDmuR7lxr/nfjzY2Wz3evKVAahjWe0JDpWqy+1b2MPZ7B
         dHQaF6beoShXfBV2YL5O6doUUgpigN+b6RGGEFhUcm4IrQGdDx1Pdx15M479bGxUCgAI
         G/9IhDkOLKTf3N1KWlU2xkPWFZQm8q7o3HwahZYU3joQindJP4731WW2xWxc/K7/JY1r
         jHfNi5WZ6phieXbVAZyqe2byGm64E5fLuuvtUwSTgd51Ro/DsXNkQQuvWAEH0mVK+SXl
         s3x3U6oveLn9c8udxuvoSu4eLU+3LlcsNxp9t7YeEn7Muz+4gY6nV2DJrFkLEYJBAhAv
         SoUA==
X-Gm-Message-State: ACrzQf0vZ+VRF81V02MFUW2Kd1kUyaQrcoWN2A7lKK+mZh9DVhSO7gtF
        5od0/BkgtSUBTpEgcKMVcxU5wW6pifM=
X-Google-Smtp-Source: AMsMyM6LP/Yynqsmv/IVMrdYDfqLHqcoIXJPUFF/sN2JoOHtOZymEZ7L2xeH4HzvDnplmRzzbgJn+g==
X-Received: by 2002:a05:6a00:a15:b0:56e:9b2b:60dd with SMTP id p21-20020a056a000a1500b0056e9b2b60ddmr15952814pfh.35.1667823864951;
        Mon, 07 Nov 2022 04:24:24 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id a72-20020a621a4b000000b0056bbeaa82b9sm4348525pfa.113.2022.11.07.04.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:24:24 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 20/72] libext2fs: avoid too much memory allocation in case fs_num_threads
Date:   Mon,  7 Nov 2022 17:51:08 +0530
Message-Id: <5ae4498b906ea4adffcca5546e2c9deba39dd05a.1667822611.git.ritesh.list@gmail.com>
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

e2fsck init memory according to filesystem inodes/dir numbers
recorded in the superblock, this should be aware of filesystem
number of threads, otherwise, oom can happen.

So in case of fs->fs_num_threads, this patch controls the amount of
memory consumed for running multiple threads in e2fsck.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/ext2fs/dblist.c | 2 ++
 lib/ext2fs/icount.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/lib/ext2fs/dblist.c b/lib/ext2fs/dblist.c
index 5568b8ec..c19e17bc 100644
--- a/lib/ext2fs/dblist.c
+++ b/lib/ext2fs/dblist.c
@@ -58,6 +58,8 @@ static errcode_t make_dblist(ext2_filsys fs, ext2_ino_t size,
 		if (retval)
 			goto cleanup;
 		dblist->size = (num_dirs * 2) + 12;
+		if (fs->fs_num_threads)
+			dblist->size /= fs->fs_num_threads;
 	}
 	len = (size_t) sizeof(struct ext2_db_entry2) * dblist->size;
 	dblist->count = count;
diff --git a/lib/ext2fs/icount.c b/lib/ext2fs/icount.c
index 766eccca..48665c7e 100644
--- a/lib/ext2fs/icount.c
+++ b/lib/ext2fs/icount.c
@@ -237,6 +237,8 @@ errcode_t ext2fs_create_icount_tdb(ext2_filsys fs EXT2FS_NO_TDB_UNUSED,
 	 * value.
 	 */
 	num_inodes = fs->super->s_inodes_count - fs->super->s_free_inodes_count;
+	if (fs->fs_num_threads)
+		num_inodes /= fs->fs_num_threads;
 
 	icount->tdb = tdb_open(fn, num_inodes, TDB_NOLOCK | TDB_NOSYNC,
 			       O_RDWR | O_CREAT | O_TRUNC, 0600);
@@ -288,6 +290,8 @@ errcode_t ext2fs_create_icount2(ext2_filsys fs, int flags, unsigned int size,
 		if (retval)
 			goto errout;
 		icount->size += fs->super->s_inodes_count / 50;
+		if (fs->fs_num_threads)
+			icount->size /= fs->fs_num_threads;
 	}
 
 	bytes = (size_t) (icount->size * sizeof(struct ext2_icount_el));
-- 
2.37.3

