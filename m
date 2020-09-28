Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707AA27ACF8
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Sep 2020 13:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgI1Lgk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Sep 2020 07:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgI1Lgk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Sep 2020 07:36:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B19CC061755
        for <linux-ext4@vger.kernel.org>; Mon, 28 Sep 2020 04:36:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so741891pff.6
        for <linux-ext4@vger.kernel.org>; Mon, 28 Sep 2020 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=91/s40nu4oMjdMdexT+vnnp9Ln8sFDrbtWky6LwPjVw=;
        b=DbfNUFRI7bVfMdmZSduAnynN+i9U3pf9Upn1wQ2iaiLiHpHuN2p8IlbAd8lFURyBoY
         amIa4lgpLjzN5mCX2dQqC6zqAhvkECg4F1rp06VvKB32G3Wl0nt3bfDPm1iRNzxAU98w
         y1fBmWqSBMFiiL769jDMQ8Sqt84mItjlcd+DphhlppiROXukUy/TPfhHRC1AAuClXnZY
         MiIPbBLQmqMswqTFhPYjlbJk94ud0IN6dLZtRSQ4LrUmt18r6Yz+S4nA14Mx5mnvH4OS
         str3WcA7OccHKX8ft0OB+dGG3d7AT8LwIQQpYi/BhoHzR8Gx1UoVIzswVhPSNKuipZBw
         dZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=91/s40nu4oMjdMdexT+vnnp9Ln8sFDrbtWky6LwPjVw=;
        b=FAPi04WeMrS8LXTguDb5EWP6aLQxE6TvhFaRbVLs/Orx0syWEFkhSiRB2yO2GM7I1R
         7hLA8KUA/mxsAiImkpwi0fhgeulI9qwcQrby8MCAf010Um3BPyme+Zmll7Urc+rFEzWO
         YUkKR+TwU3cIuM+4Fb3eMxcD7DNRJm8mEHgjRYzQWf29ZdahJHHKss2sBnSENktIQsSN
         cfVv0QfFhQR8xucyrV4gUVn/W5l+bn+DY7ZkohYtzYN/S2EudPLCNiRJAUheAEaoYjFA
         KH+9/76KKzuSTcYNTqev8pTxx2XtVGutDA/TMV93XmNro1sWpPKJBTkxmE/qRE1CobiQ
         BUkg==
X-Gm-Message-State: AOAM531kc7lepgHMCZ0ynxOOhQrb+3mn24J8O9km1qcImyY/VJtb/qOU
        gOnV/Xae/T+u8Z7OHfyBLRQR+cVq7wc=
X-Google-Smtp-Source: ABdhPJz+wVnwqQh19unE3K0fDYRjPcvxZEmGK/49KTAheG3OJRF99XOmWM0UPNHQ6oammaWqJ0IVwg==
X-Received: by 2002:a63:d918:: with SMTP id r24mr825311pgg.158.1601292999991;
        Mon, 28 Sep 2020 04:36:39 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t12sm1122820pgk.32.2020.09.28.04.36.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 04:36:39 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     adilger.kernel@dilger.ca, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: make mb_check_counter per group
Date:   Mon, 28 Sep 2020 19:36:35 +0800
Message-Id: <1601292995-32205-2-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1601292995-32205-1-git-send-email-brookxu@tencent.com>
References: <1601292995-32205-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Make bb_check_counter per group, so each group has the same chance
to be checked, which can expose errors more easily.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/ext4.h    | 3 +++
 fs/ext4/mballoc.c | 7 ++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 523e00d..b883a78 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3153,6 +3153,9 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 
 struct ext4_group_info {
 	unsigned long   bb_state;
+#ifdef AGGRESSIVE_CHECK
+	unsigned long	bb_check_counter;
+#endif
 	struct rb_root  bb_free_root;
 	ext4_grpblk_t	bb_first_free;	/* first free block */
 	ext4_grpblk_t	bb_free;	/* total free blocks */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 6487d5c..2705a4c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -619,11 +619,8 @@ static int __mb_check_buddy(struct ext4_buddy *e4b, char *file,
 	void *buddy;
 	void *buddy2;
 
-	{
-		static int mb_check_counter;
-		if (mb_check_counter++ % 100 != 0)
-			return 0;
-	}
+	if (e4b->bd_info->bb_check_counter++ % 10)
+		return 0;
 
 	while (order > 1) {
 		buddy = mb_find_buddy(e4b, order, &max);
-- 
1.8.3.1

