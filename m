Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEBE2AFFED
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Nov 2020 07:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgKLG4t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Nov 2020 01:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgKLG4s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Nov 2020 01:56:48 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF22C0613D1
        for <linux-ext4@vger.kernel.org>; Wed, 11 Nov 2020 22:56:48 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so3654954pfu.1
        for <linux-ext4@vger.kernel.org>; Wed, 11 Nov 2020 22:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gSy0OYVnPAMZ6RH3UiQyKhuVY4luV4b7NCqz1g5jgDA=;
        b=FN3Im+Kj2Ez3j3ufUQicsrf6XIWZDJ8jvtpi8Q3UFvXQmVzXYFZ1Bv3RC/H78t7Tgy
         pSpVLHVxoKStI4VBjl2Tb9ceic5SaFuCbR3fzxsg23yZ8cRAd93Tdp6w6VEJuoaQFeeq
         17xKu2Kc1yBLrE8ZmuVsLwzeDfEpPE5ue4SgEwo/vWsBrzBQwz/ccznDgNDSDNZDmUqs
         ATEzWChZZK7OTk9Uoa0Oy8B/js1ptBOWFEcPY4deOCoVMBzCbFb1AJdfu+3eXVFvCFXY
         yzvbARum5jR+4JDVGq+MI0qDgftYRvb8O4x+/lR5H819jU6dCugYZfdjVw58CUyn3N3R
         UKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gSy0OYVnPAMZ6RH3UiQyKhuVY4luV4b7NCqz1g5jgDA=;
        b=IIMMn3kEEg4DIbTIJTmFSkEPQ+bmpta8Ua1Pa5VU/SUI4a6LYlOyA9qvwP5s65g5Xn
         RsjjHzwnYFT+jzOCQGk+clzABMuL9MsTSLCrUe1VsqdUZ7aH8Pf2HtLq33ikRLl+QBdK
         ObiLdI7dmz9CO16GQC0XDAv27pTbFeIFUs9DBaX2Yoq19GsHEsFlIdKJlxSCh9FgmUco
         8JasKGcwXeQjOkaQJNyRfEvYOqTPMF+Lemj3K+O85cMwC4pGcJIwUN1DNuchB2jV+W+Z
         mPo/8/qQCSHnIHam5iuaoqcHQJg6nXd1xkZ8gt5ZDL7SW7KA+i7ktqVEMCMpbuE/+PcN
         4b/Q==
X-Gm-Message-State: AOAM5321AydjO4hBAVa8FE/ZY/4AttlwDsyPI9cvZn8L8huVtTN0lHo2
        8840am/hlxkr6Khtek0jmNuPDhH6t16m
X-Google-Smtp-Source: ABdhPJztBALtsU2LWcMHQkAAph6Am78T9CiQrDhQG0Admo6irE024YzAzIFx1cdJs2wk7p7nARttfQ==
X-Received: by 2002:aa7:942c:0:b029:18c:5ac1:d729 with SMTP id y12-20020aa7942c0000b029018c5ac1d729mr9672883pfo.12.1605164207631;
        Wed, 11 Nov 2020 22:56:47 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id q18sm4768528pfs.150.2020.11.11.22.56.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2020 22:56:46 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] ext4: remove the unused EXT4_CURRENT_REV macro
Date:   Thu, 12 Nov 2020 14:56:42 +0800
Message-Id: <1605164202-31120-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

There are no callers of the EXT4_CURRENT_REV macro, so remove it.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 fs/ext4/ext4.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bf9429484462..cf1c01139f26 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1858,7 +1858,6 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
 #define EXT4_GOOD_OLD_REV	0	/* The good old (original) format */
 #define EXT4_DYNAMIC_REV	1	/* V2 format w/ dynamic inode sizes */
 
-#define EXT4_CURRENT_REV	EXT4_GOOD_OLD_REV
 #define EXT4_MAX_SUPP_REV	EXT4_DYNAMIC_REV
 
 #define EXT4_GOOD_OLD_INODE_SIZE 128
-- 
2.20.0

