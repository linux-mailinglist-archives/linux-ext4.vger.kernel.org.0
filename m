Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922DD61F33D
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiKGMai (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiKGM25 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:28:57 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FBC232
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:28:56 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id j12so10912295plj.5
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mdcb4BTkVS1l8ipTC8GIkWGgMANpQ3W9U+W9dp2alyU=;
        b=ApQufOvnqFbcLAPqh6CBr8vpZKFwfA4Ohjc54JH24j5vA/hvmPurDM+acY6x1pPAEv
         Ok829Ap0iQSSCCzsCgd8gofewa6XTCzNPCZsNxHcziSng0SbNbYMdKcN1y+a4/oEXz4b
         gXu7173oPwPI8e0uqJo8IOfeImxULnI2BgNisOCARaiX7mbzGVx90J7oid0RXedH3Iep
         E8q3nLBnXCPSLD4kiX2LuXEJE2ODGymFBJ+tNjljVn6Di5Igx4EiZ2cu17olSP4lBoBk
         qOA8n/RD0OkjPE/JZLfTkCQVFoOD4csl+Y8DDeS6u0A/i63G4rHe+b0+yo/WiGuTnXqc
         KW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mdcb4BTkVS1l8ipTC8GIkWGgMANpQ3W9U+W9dp2alyU=;
        b=pD5a2YLpPpJQ0nD24HbuxmDGq4PM3mk7t1BU34OretT1LN6Rkx4emvFCDFmQirJaWv
         OS8OLrEWyMw9DIdRagt93F+PpEyWdYPqIhNilpqi8GyikCgS+myuA0GVxuoTazWKND6N
         wIuXNKRI6L5XIHU8qP45eGtJrbT6vXfSksqv7hva1d1P9WWPkaHBO6s6zLHNj98l6wOZ
         xZ6oceh7BOp9yIePvwQQyVwBdV5zyZ+hrKgbAmyDFl2Bi5VYK625yL95GVbW4Fndtqje
         EKa47Oct1IKKXEMXSjgpP0cZDBXGrpOEJwuprxXecOn/tkU5ZjE7dRTQ0C++dhXVK754
         eW5A==
X-Gm-Message-State: ACrzQf3fUzKDuajeAzhiY8ulw6OdTztDtrxbzxX9Uef3SCLYpPP2hbu8
        H2WNod9xUv52GrZEHskPFEY=
X-Google-Smtp-Source: AMsMyM5AL8qEdPleK8TQeL6wPdLDTmqwK6hdbEKsoXUj8Kb8iYaN/soHtAtX5l1/ts4IhuKTWQ7hYg==
X-Received: by 2002:a17:90b:1095:b0:213:ee6a:f268 with SMTP id gj21-20020a17090b109500b00213ee6af268mr39138430pjb.213.1667824136085;
        Mon, 07 Nov 2022 04:28:56 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id f2-20020a623802000000b0056232682a7esm4386947pfa.2.2022.11.07.04.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:28:55 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 64/72] e2fsck: propagate number of threads
Date:   Mon,  7 Nov 2022 17:51:52 +0530
Message-Id: <538c698d8259613f69d46ae29847ac256778e135.1667822612.git.ritesh.list@gmail.com>
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

From: Saranya Muruganandam <saranyamohan@google.com>

Sometimes, such as in orphan_inode case, e2fsck_pass1
is called after reading the block bitmaps. This results in
reading the block bitmap sequentially and multithreading
only gets kicked in later. Fix the thread count earlier
while setting up the file system.

Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/unix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index 461ab8cb..fb0df85a 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -1745,6 +1745,9 @@ failure:
 
 	ctx->fs = fs;
 	fs->now = ctx->now;
+#ifdef HAVE_PTHREAD
+	fs->fs_num_threads = ctx->pfs_num_threads;
+#endif
 	sb = fs->super;
 
 	if (sb->s_rev_level > E2FSCK_CURRENT_REV) {
-- 
2.37.3

