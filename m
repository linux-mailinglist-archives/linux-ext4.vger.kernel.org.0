Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EECE4652D6
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Dec 2021 17:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbhLAQiD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Dec 2021 11:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351107AbhLAQiA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Dec 2021 11:38:00 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2850C061748
        for <linux-ext4@vger.kernel.org>; Wed,  1 Dec 2021 08:34:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z6so18132706plk.6
        for <linux-ext4@vger.kernel.org>; Wed, 01 Dec 2021 08:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBElkur6LZmhvoW3bpkBRdx7KWPV73Vhiu0rYHr4YMM=;
        b=q0LBMW064LM05W/yKb489eACmvMqpYTbpNwORh7Ki/utFTeYIQIDlBTZCyrkrqfgQo
         tUTRm5oRjof9WlL1f0jesBQe69bQu2cGooYSEEa3ugZSFgXV1v7mSchxBMnM4YtkNWmR
         82ZoBXpOi75GJX9DNihIZ9ZK3oU4sLpf8NGFp6kIgt44Zc9kP8CZTYSo25jbZN29wkGM
         H+8j3KaZCQt36E0HiUtIPyhj+FJHDRQoGHF00IqdpzempmNIpyYNyUTn1nqUIAejUH9u
         wZZHtioCkZ29raeaopAO75PHyP6hmtRFp6gfjlmHMDnCR2X3Nmm/Yv0jNOf1Ge44HW7W
         R70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBElkur6LZmhvoW3bpkBRdx7KWPV73Vhiu0rYHr4YMM=;
        b=LqK+31Joqfj3Gw3SMPBroMIH4nkvAssYczA1pku+vBh1vT3bl7Y1ayJakpMjL+znyp
         nXdjGzvOkKUuGz8T92bipTBeo3KSV7IxxoTEhrElNJupM9UO7Ty/9PZQvJWZXx1WNR4U
         qKlsXAkjWqX3YLlXi7cy7N0IqnZQh3ESwQ48X80baTVGP2Oe4Cux0VaejBmF9FeLK+Pz
         dF0x0MptWc8PtdsaQKNSISH6EKcMxGoD8y2oHdlsaWTheyQl+75D+30w0qQs72sYACbB
         ZPmX0Ym/DbplrsgdeY+gKSUa3vppyrPIcNkyZswNOHW7g+a3Q+XhsPULgtUtK9yiUFp4
         oh5Q==
X-Gm-Message-State: AOAM5332joWqBfitPAyTJVtkHOkLd6CiGnexzqeW88a9r02ku3n9ivcA
        r4zCFi84P47g8mkkY3Atn4hnnPXSyTw=
X-Google-Smtp-Source: ABdhPJyUu/VSGxC5/rhCARYcznW0EAHO84EUbGEcuDs1Jl0CVRLqJO7xVgp4kBr05k7mWjqyEGzZxw==
X-Received: by 2002:a17:90b:3a83:: with SMTP id om3mr9106164pjb.0.1638376478651;
        Wed, 01 Dec 2021 08:34:38 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:41a5:fd1:e459:52d9])
        by smtp.googlemail.com with ESMTPSA id il13sm2126374pjb.52.2021.12.01.08.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:34:37 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ext4: initialize err_blk before calling __ext4_get_inode_loc
Date:   Wed,  1 Dec 2021 08:34:21 -0800
Message-Id: <20211201163421.2631661-1-harshads@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

It is not guaranteed that __ext4_get_inode_loc will definitely set
err_blk pointer when it returns EIO. To avoid using uninitialized
variables, let's first set err_blk to 0.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bfd3545f1e5d..fbdd2dda57ae 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4523,7 +4523,7 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 static int __ext4_get_inode_loc_noinmem(struct inode *inode,
 					struct ext4_iloc *iloc)
 {
-	ext4_fsblk_t err_blk;
+	ext4_fsblk_t err_blk = 0;
 	int ret;
 
 	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, NULL, iloc,
@@ -4538,7 +4538,7 @@ static int __ext4_get_inode_loc_noinmem(struct inode *inode,
 
 int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
 {
-	ext4_fsblk_t err_blk;
+	ext4_fsblk_t err_blk = 0;
 	int ret;
 
 	ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, inode, iloc,
-- 
2.34.0.rc2.393.gf8c9666880-goog

