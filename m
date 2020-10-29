Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54BF29F05E
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Oct 2020 16:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgJ2Pqu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Oct 2020 11:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgJ2Pqt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Oct 2020 11:46:49 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97929C0613D2
        for <linux-ext4@vger.kernel.org>; Thu, 29 Oct 2020 08:46:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w21so2656395pfc.7
        for <linux-ext4@vger.kernel.org>; Thu, 29 Oct 2020 08:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LohrQs+fMH2TTdXe4c3ZlHwf/300cvGi4j2+s8iPUu0=;
        b=BJecUS5ye6SLM0Lo8/6FpsDhScrirci9py3Pbvzf+P7SAkfYlj7Vc2OdrWf3jJQgRf
         lZ5mfOc1vrS0Ic2A5lgL6mf050G7Cvivt5xwHc665vhrdq8x9uLQ8DoZBd34nAW2AXGR
         ZGBueKTRkwtOYX+KKBunqew9ba9f8m3sv5RaoznpjD8DwajaitZUN4bBbiUnA2HeFnAV
         wXGUVniWR0A4qZX2YeeS0VY9umKa2tQ1U8dRWqweIXAhMii+Gr5Fm2fUr8OYWgWZHDQo
         I02/mzw2O6S8+QxutihkDQwIIs5Zqx7/fzNXBlICza3CnG6j1pvbKjaD824DUUsDApFR
         yuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LohrQs+fMH2TTdXe4c3ZlHwf/300cvGi4j2+s8iPUu0=;
        b=XSBMLMjNcwU7cifJJgXdMzu6Ey7hQjnVJY5Zdv+o4zTG3HQkh86jm4NlLCXI46pwez
         ef1OiY6A8uZ+1NPISu3GAbTPIV0h437FHIOQZVImEPWWXkOgjdH1I1/kQvu6KlmTGbeF
         DJBg/gBltKbTfYu67vsbH03ucwp1NVT74CvJj45po4SuXCjWwjkK8ahVsiCqjD/ytIBt
         JPutvZxHIycHIGEIyucvdFsfTAeie6XmLUdxE0m4Mpx01re1wCSyDAJaO0SRSNvTOKBc
         V7O+5/NVnG9ahwQi3FixCnD9HebuiV7eMA6fHRzACiyJn83/6s2MUudFhStK+MVcerFV
         Pgyg==
X-Gm-Message-State: AOAM530yilCqOmaSczkKI5Xp79RJx/USK4ngMAWPtByrl+AGTF7Njyyf
        RpdVhdTqqZXjP6o0cmwj88uqN+GOTQ==
X-Google-Smtp-Source: ABdhPJxbp6psyynZbNsu5vkHywpQd0eC63g0IY2fRr5d1EKfuY89kthpqhRuwYluJcyFCHqii19rAA==
X-Received: by 2002:a17:90a:1903:: with SMTP id 3mr435103pjg.74.1603986408770;
        Thu, 29 Oct 2020 08:46:48 -0700 (PDT)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id q84sm3445802pfq.144.2020.10.29.08.46.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 08:46:48 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] ext4: report error message when setting usrjquota or grpjquota options failed
Date:   Thu, 29 Oct 2020 23:46:36 +0800
Message-Id: <1603986396-28917-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The macro MOPT_Q is used to indicates the mount option is quota stuff and
would be the same as MOPT_NOSUPPORT when CONFIG_QUOTA is disabled. We want
to report NOSUPPORT error message when setting usrjquota or grpjquota
options with the CONFIG_QUOTA is disabled, but now it report nothing. So
fix it by adding the MOPT_STRING flag.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 fs/ext4/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 83fdde498414..a26ba4cf5626 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2025,8 +2025,8 @@ static const struct mount_opts {
 	{Opt_noquota, (EXT4_MOUNT_QUOTA | EXT4_MOUNT_USRQUOTA |
 		       EXT4_MOUNT_GRPQUOTA | EXT4_MOUNT_PRJQUOTA),
 							MOPT_CLEAR | MOPT_Q},
-	{Opt_usrjquota, 0, MOPT_Q},
-	{Opt_grpjquota, 0, MOPT_Q},
+	{Opt_usrjquota, 0, MOPT_Q | MOPT_STRING},
+	{Opt_grpjquota, 0, MOPT_Q | MOPT_STRING},
 	{Opt_offusrjquota, 0, MOPT_Q},
 	{Opt_offgrpjquota, 0, MOPT_Q},
 	{Opt_jqfmt_vfsold, QFMT_VFS_OLD, MOPT_QFMT},
-- 
2.20.0

