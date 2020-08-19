Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA66249781
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 09:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgHSHbw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Aug 2020 03:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgHSHbV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Aug 2020 03:31:21 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2575C061342
        for <linux-ext4@vger.kernel.org>; Wed, 19 Aug 2020 00:31:21 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p37so10975616pgl.3
        for <linux-ext4@vger.kernel.org>; Wed, 19 Aug 2020 00:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6N4bqwfNNNZuZtRemXRTub25zoiixDBfSkDUqn/XADg=;
        b=HkLu+KZUHC0mxsHFcTvOI7gNdiVUJI5oxGafSvyOb7RwRXmkb5xt+cC/BGWNhnQvg/
         qhyUSWdQ3cQpyKkVSeW/c68l8tTLq5OZoa4BwVImxzLTPrXvTAvKc96UJCgtBi9TeMQy
         nW22U7zUf84d+l7UUalKO2a0S6OzRnESbvkHV3QYSTgKZcT0Ns1MR5AryevWB5MAGNRx
         c47mo6iRYiZLmqknniIX5t5OR6q3itWp9Fi8gyGUa+8Y1wZEBf40UDaD6wu5TeVcfzyl
         DQVBi/3ojpTJ66rHoUOKKq1tExEHtmYPuRFIoidC/gfVlDji6zEIQ2lh+MXwh3s4AXYg
         EFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6N4bqwfNNNZuZtRemXRTub25zoiixDBfSkDUqn/XADg=;
        b=NEFgQWmAAyEJZ+3FYSzOxdH3y+N7WmR62BzFwecz/PjqTh5Z8pL+290HKDcxd00ZnB
         63cM2LKIaf6pce8m11Ch92wSoweKZ1BUmuqL9SbiF1pODnGlOFlAKNr+1pQpv58wSSFD
         CZbpOtyO53fb63X6fTCduzFCYq8NN0c2iS94yADvbmTKDoLurFR6Y/joRXU9cDL2umsy
         SL4qkf7XXQJpZdH2gLP9jaIiwRXi2QRW9neipYMM528PHLENNKtRbifV2h0l24IhsfAv
         Citfr3VoVosKGdi9iwPhmalhQ3XnCdVfEh72lQSFYlSLbGVrXasz2tMpl8n1CwKp7H72
         CkZw==
X-Gm-Message-State: AOAM5331uSKLYwMOOIREKXIyfPMmISCRKGVZQPIqGe4y7oEXInacsKbU
        0HQiFArFWLC+zrbvO+Xa9kzBYoHm+nA=
X-Google-Smtp-Source: ABdhPJzea/igWT104K9Yk6FsaTlyhlrw5N3zPQTdibtymmcAQoUM2yIMYTQnznLZIXDX0qHyMzYbHg==
X-Received: by 2002:a63:711e:: with SMTP id m30mr16321796pgc.40.1597822281060;
        Wed, 19 Aug 2020 00:31:21 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id q6sm2040019pjr.20.2020.08.19.00.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:31:20 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, lyx1209@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 4/9] ext4: add prefetching support for freespace trees
Date:   Wed, 19 Aug 2020 00:30:59 -0700
Message-Id: <20200819073104.1141705-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200819073104.1141705-1-harshadshirwadkar@gmail.com>
References: <20200819073104.1141705-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch supports creation of freespace trees for prefetched block
bitmaps.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/mballoc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 74bdc2dcb49c..1f4e69c6f488 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3145,6 +3145,9 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
 void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 			   unsigned int nr)
 {
+	struct ext4_buddy e4b;
+	int ret;
+
 	while (nr-- > 0) {
 		struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group,
 								  NULL);
@@ -3159,8 +3162,15 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 		    ext4_free_group_clusters(sb, gdp) > 0 &&
 		    !(ext4_has_group_desc_csum(sb) &&
 		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
-			if (ext4_mb_init_group(sb, group, GFP_NOFS))
+			if (ext4_mb_frsp_on(sb)) {
+				ret = ext4_mb_load_allocator(sb, group, &e4b,
+							     0);
+				if (ret)
+					break;
+				ext4_mb_unload_allocator(&e4b);
+			} else if (ext4_mb_init_group(sb, group, GFP_NOFS)) {
 				break;
+			}
 		}
 	}
 }
-- 
2.28.0.220.ged08abb693-goog

