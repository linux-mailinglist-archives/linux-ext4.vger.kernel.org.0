Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F279454B61
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Nov 2021 17:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhKQQxa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Nov 2021 11:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbhKQQx2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Nov 2021 11:53:28 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89449C061570
        for <linux-ext4@vger.kernel.org>; Wed, 17 Nov 2021 08:50:29 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h24so2828528pjq.2
        for <linux-ext4@vger.kernel.org>; Wed, 17 Nov 2021 08:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JpzEKTgso3kSUAGpDLZZqBOFC40x6xhW0mHqcPWVtY=;
        b=cVGhHPe2ITn4NQW64P9BN3EUY0pxNN7cOoaF9hnZqp19FW3yziRTh0mAWDZNnXq6Gd
         W9lRqYFgbwfFARrQ6Bxu0bm0kqWWgPQKxLYLzz6xuBZ/ijK3eOg24kRBhtHZn+FPpjDh
         ne6m/eK483fL/QxM0635cMNQvu6zKC0mv7w6WeOUEb7kaJbIPo9qgjVt/biK62nuAPZd
         p1Jgh8VHZlxnTIkXYkliqw3mWNmRNjJa9Sq9owhLj7T9O6TTZzA3yHV0sSMbaZPz8gTa
         o47M+cxjybWRpHtqV2wELadfJGgANMhV8gr21D82zEp2GuN60dRpkXBhQKa9/w9/7Zg2
         qPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2JpzEKTgso3kSUAGpDLZZqBOFC40x6xhW0mHqcPWVtY=;
        b=vbtbJX7qFNC42FuQegvQmGhZCBSDJOma7HMLHm6aup9r5aClvJ7wUZoMIBh3E0m2Cm
         Cj1kkFLCMWaL4QpppSGcdUCn2ZHYcSjuIkLGbWybc88jrYfKHSAk0rshnmo+HbwdMMNV
         TkVJT6cHSOlpYjMUGSttKvx4FNheMkVlYwagxSIMME1ZjPdwl0wRzxfLvvcDphbE7d3r
         lTxBDnJkDL/D/xSELkm/hLbMVNLsG4D44e36/X9JJnQB4wE7fYE2+3AL0uL4J99urMWZ
         FD+la1R3SWnd9x6fG3Ejilg7CLKRAif1a+ZakePCipxNdaH3VNczpBYb960QgY+6irMx
         vwhQ==
X-Gm-Message-State: AOAM530R9zu19e7nfplEDwMBKrevCGeVj9eJuQecVDuL09yV46pXepPk
        z497AAEdNY9uPoaTT3iHJs7z1mlJDH4=
X-Google-Smtp-Source: ABdhPJxN5WdcJF/DcQqr+ckDW00oE4UTSOr23cGuq1uAh8Id11PzKThL4Kx3OVSLCy5fEsD8mx0wtQ==
X-Received: by 2002:a17:90a:e506:: with SMTP id t6mr1256172pjy.9.1637167828645;
        Wed, 17 Nov 2021 08:50:28 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:c531:15d1:73dd:4d1])
        by smtp.googlemail.com with ESMTPSA id i68sm177135pfc.158.2021.11.17.08.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 08:50:27 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] e2fsck: skip sorting extents if there are no valid extents
Date:   Wed, 17 Nov 2021 08:50:15 -0800
Message-Id: <20211117165015.1637593-1-harshads@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

At the end of a fast commit replay, e2fsck tries merging extents in a
inode. This patch fixes a bug in this logic where we were continuing
this action even if there were no extents to merge resulting in
accessing illegal memory.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/journal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index fe4e018d..2e867234 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -464,6 +464,9 @@ static void ex_sort_and_merge(struct extent_list *list)
 		}
 	}
 
+	if (list->count == 0)
+		return;
+
 	/* Now sort by logical offset */
 	qsort(list->extents, list->count, sizeof(list->extents[0]),
 		ex_compar);
-- 
2.34.0.rc1.387.gb447b232ab-goog

