Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A77C61F343
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiKGMau (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiKGM31 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:29:27 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B740C1B7B9
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:29:25 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q9so10457934pfg.5
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm7hA39O7IoRiEPnNzVpo9eYZrFR9MuwdVKpH1WkXyw=;
        b=Ulyyhmy61IqcJV0xQeuXsHBBbmB5rT0zFmpEj5neoUwo1QrP1JSfZSKScdyVdqX2rO
         MER6aSikvY8emKy+JgdvgbSVN5G1iiV1lpuByw2mGJT/HhyZ+hB/tu0VmM9qW2tnoBXp
         FZ/0qiqIvFq7vkALaq7o+NJqmLbPHECzPUun9KrLC0FgB6lYSskm8RmFhfOSqNfx5V25
         m0cpWReR3H+ISjSav9aeFXJPsfMc2dSsRw/jVuJ7YERM4HrIMh/GvUveGmzjNJWoOKrM
         TOKNeUIUZTUHHs+QGBUyTSkvvKti/kWtFRbDrfZrmS0RCSjwxlYuhcaJkvUvBf0Wo/zb
         Rm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vm7hA39O7IoRiEPnNzVpo9eYZrFR9MuwdVKpH1WkXyw=;
        b=iv21G46GL4ilwM1VrZgvRHwV1bfuq5xw1BEhP5hpsG+zZsugToMTuZ8BY2TSruQZ3d
         gVHnzsTJAwog+u8ZPC+uyVRFmSsZfq3dc0jLb9n9SAx2/cz4cZkW5KwXYMw5NB6J6Brj
         EZRuT9ANfAMpqF7+otuH7iYznD1KS/3BUyTcWJkJLetSciZNX4TwcwCk3EQBVWwJRH3m
         NnQNbIPT5wxAM2iHFL11/eZVRTXdPwHl9RURfE3A4zNf3QnT4XVR8LULq6iKdvj0w9X4
         kAxWoAm51rFqBOVebj+Rqup5SSlfeH5sXkuYkXE5+UvovTf3/oKlvLejcjthmvUN0jT2
         TSYA==
X-Gm-Message-State: ACrzQf1nLCjKXXTcRsGE2IZWI/z61bgO5IBu9WBnnBvPgTEa07wBsADr
        32Jr7CoNzdd30Y1oESApdP8=
X-Google-Smtp-Source: AMsMyM7kWCiHOcXqct8qiDs9SRPSdYiTmnELvWrpxl52VJnuYlIvZiD8tvZZqks03BFHEhilieWYKQ==
X-Received: by 2002:a63:581d:0:b0:42b:399:f15a with SMTP id m29-20020a63581d000000b0042b0399f15amr43135266pgb.337.1667824165272;
        Mon, 07 Nov 2022 04:29:25 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902768200b0017f72a430adsm4858722pll.71.2022.11.07.04.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:29:24 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 69/72] e2fsck: Fix double free of inodes_to_process
Date:   Mon,  7 Nov 2022 17:51:57 +0530
Message-Id: <0de5025b40eb8f462d2f01321432ac0535345e3d.1667822612.git.ritesh.list@gmail.com>
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

Found during code review, this fixes the double free of
inodes_to_process in e2fsck_pass1_run.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index c934b021..4168a45d 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2436,7 +2436,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	}
 
 	ctx->flags |= E2F_FLAG_ALLOC_OK;
-	ext2fs_free_mem(&inodes_to_process);
 endit:
 	e2fsck_use_inode_shortcuts(ctx, 0);
 	ext2fs_free_mem(&inodes_to_process);
-- 
2.37.3

