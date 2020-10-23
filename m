Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63B329734F
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Oct 2020 18:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbgJWQNy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Oct 2020 12:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373717AbgJWQNx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Oct 2020 12:13:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA60C0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 09:13:52 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v22so1144384ply.12
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eKbzV3eW/q+iJwAdHzxPnvy/nmMxCVdTWVw5EB4VqCY=;
        b=PNAnG0H0HSixOUNcyrBhy75Lq1BhwYXsMfgqZxBCQEWomqUBoVRabeEFIaGr3h+BC/
         K2q9r6t/Bwoh5+8F3SrZE8smLlmaoWHknIn3VQkjD1VWD60r1229iIwGowepfTlKChvV
         3aPEWWkFTSq4pyzft6grW5s8zzKWMd8qWlymv+GIVovVsX77X5M1+9f/w1wuqETTdSIv
         P0Dzz5c9+XsQL0EnnLC2zp3zlkNd2iImLgDu/m2PTBBiHbaM7kkFwMIBri5ki+Hbyn0B
         UZXEEWRA9qJQeGUOQxma72tRTyK7F0gdpJpm6YH0f9BpfZqKsMf4oe3sBqikvXnhCgUH
         AJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eKbzV3eW/q+iJwAdHzxPnvy/nmMxCVdTWVw5EB4VqCY=;
        b=eVlvkuHY6CosLb8Qx8AeKZoQv+XO0aLk9RUl5U38CrTkSl/CTAQexIxxlk7nnOKhAM
         n/t6uzv286S03x4ou0L7uniiMRB1+gzsS8C/KC8qoMSX57lYnTiwLPygV/+gH+k+NnTe
         v5xtnLM8GDJcjpe8w5oJqHLGvY5SZbGENEFH9svZUdszT1prRUHd3PhNJkikpPAhnU3W
         tZ6x2T4AzO6V993/qwHAsWqvJLdyf7D2eIpqQIdx/p/H2PSwXbO3kmMh6OMmyd2tyYjw
         pV7oPsJnggWodimi3R6JI4z0YPmNi0U5KIBuUzS2mJrS1+XF110Sll3rPOmPnK1Osbaj
         tSaQ==
X-Gm-Message-State: AOAM531fpSj+RssnUbp5KZX+FDkbb5obZA8hAaznj3yqeRqNwd+sGeny
        VFyDeHTLgZINWCi1chbJrUar4Tb4O/Q=
X-Google-Smtp-Source: ABdhPJyh5Iv7bSoEeCHUefTphprE50o+7mG7kszL/w4PcaVK4k3bWejhDCzg4SSIpyuBlJmMQe+Xaw==
X-Received: by 2002:a17:902:864b:b029:d3:ce46:2829 with SMTP id y11-20020a170902864bb02900d3ce462829mr3240949plt.16.1603469631467;
        Fri, 23 Oct 2020 09:13:51 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id t15sm1536213pfq.201.2020.10.23.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:13:50 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] ext4: fix double locking in ext4_fc_commit_dentry_updates()
Date:   Fri, 23 Oct 2020 09:13:39 -0700
Message-Id: <20201023161339.1449437-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fixed double locking of sbi->s_fc_lock in the above function
as reported by kernel-test-robot.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 447c8d93f480..1d72f8f13a05 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -964,7 +964,6 @@ static int ext4_fc_commit_dentry_updates(journal_t *journal, u32 *crc)
 			fc_dentry->fcd_parent, fc_dentry->fcd_ino,
 			fc_dentry->fcd_name.len,
 			fc_dentry->fcd_name.name, crc)) {
-			spin_lock(&sbi->s_fc_lock);
 			ret = -ENOSPC;
 			goto lock_and_exit;
 		}
-- 
2.29.0.rc2.309.g374f81d7ae-goog

