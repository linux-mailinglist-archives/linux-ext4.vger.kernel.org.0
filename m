Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213AC1B1C09
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Apr 2020 04:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgDUCkT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Apr 2020 22:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgDUCkS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Apr 2020 22:40:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B549C061A0F
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 19:40:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g6so6063955pgs.9
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 19:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85z9s/6ztS8xNDkpEPcc3XnkXHstzxFIOs0mrZ0FHCg=;
        b=DVabhKkRHNTjFbgl0pUQb2VKfOWE86A2pz3OIuPK7V3V9b7WghtZypAiEaRASE5i6m
         l2lDQNruhpVzketpX7STapPkT5q4kJI1E/fFEqDT9Cei8h8VsT2FEgiwOFmt0FUYxOZs
         S5+b9QFwDbuXyP0fJDRHovyAfeL8htf+D2qLZ5j0+nUv3P6vXh1OD2b1NWMwiZwb8kM2
         qUEvlMc8pttSJo+D1dcQXmlSH6vd3pnTqefbMZZyoJQ2xH5rkryCsjTVgaTjMPITSz6B
         DlDpC4JFMW6OcVy3DR++oHvYNhrWzQIP6JQIUJ4t21ZqDQv2qd4+b/7zPr7EZOdjAXJT
         evcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85z9s/6ztS8xNDkpEPcc3XnkXHstzxFIOs0mrZ0FHCg=;
        b=lLmGMWswX9Sa9YNvNoIRWKbJKnEFo4sWaXqtijqHHBgL+8DzmT07vOfZ97nwCi8F7d
         udRWlt/1oLvgQ7/V4635bcedBpKYUJrMAVgaycs4+TSBtbldyQ9vjL5ZDapoOPrO//4+
         xKh1c2k09o7CPzHNXPA2EXJgh6W/v1c7MsE4l/SbYRI7HJG/oLfhXGbnqerjJ4GS97F9
         bb7EPTFTogrhGN6qk2Flfkaqo61Iom/EvO2dYqXq/ASz0SuS2EsxFDoDwm+7gYY8xVBY
         tZjon1ra0TC5maIQibmUkEyhmBH2doPdLPFVQ5KBCbrS9MyQmxGV3W9/0NGSKmJJkl7F
         Z4EA==
X-Gm-Message-State: AGi0PubS3xzD6yyr1eme8Jhsh+E4ifC/Ara168e9cz35pgCI+Bf20Pj5
        5sbgmGYEgkUmNpGUWFXGmbHj6uLt
X-Google-Smtp-Source: APiQypJk1jbCOKraqeRNBW/7K0wLPjs1JI9T1GqP2+Zvpq9cqw2LlIKPLTSys6J5Ff8bVh9EzIL6nA==
X-Received: by 2002:aa7:81c3:: with SMTP id c3mr19099293pfn.12.1587436817534;
        Mon, 20 Apr 2020 19:40:17 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id x128sm879168pfd.109.2020.04.20.19.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 19:40:17 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] ext4: fix EXT_MAX_EXTENT/INDEX to check for zeroed eh_max
Date:   Mon, 20 Apr 2020 19:39:59 -0700
Message-Id: <20200421023959.20879-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421023959.20879-1-harshadshirwadkar@gmail.com>
References: <20200421023959.20879-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If eh->eh_max is 0, EXT_MAX_EXTENT/INDEX would evaluate to unsigned
(-1) resulting in illegal memory accesses. Although there is no
consistent repro, we see that generic/019 sometimes crashes because of
this bug.

Ran gce-xfstests smoke and verified that there were no regressions.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4_extents.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4_extents.h b/fs/ext4/ext4_extents.h
index 1c216fcc202a..44e59881a1f0 100644
--- a/fs/ext4/ext4_extents.h
+++ b/fs/ext4/ext4_extents.h
@@ -170,10 +170,13 @@ struct partial_cluster {
 	(EXT_FIRST_EXTENT((__hdr__)) + le16_to_cpu((__hdr__)->eh_entries) - 1)
 #define EXT_LAST_INDEX(__hdr__) \
 	(EXT_FIRST_INDEX((__hdr__)) + le16_to_cpu((__hdr__)->eh_entries) - 1)
-#define EXT_MAX_EXTENT(__hdr__) \
-	(EXT_FIRST_EXTENT((__hdr__)) + le16_to_cpu((__hdr__)->eh_max) - 1)
+#define EXT_MAX_EXTENT(__hdr__)	\
+	((le16_to_cpu((__hdr__)->eh_max)) ? \
+	((EXT_FIRST_EXTENT((__hdr__)) + le16_to_cpu((__hdr__)->eh_max) - 1)) \
+					: 0)
 #define EXT_MAX_INDEX(__hdr__) \
-	(EXT_FIRST_INDEX((__hdr__)) + le16_to_cpu((__hdr__)->eh_max) - 1)
+	((le16_to_cpu((__hdr__)->eh_max)) ? \
+	((EXT_FIRST_INDEX((__hdr__)) + le16_to_cpu((__hdr__)->eh_max) - 1)) : 0)
 
 static inline struct ext4_extent_header *ext_inode_hdr(struct inode *inode)
 {
-- 
2.26.1.301.g55bc3eb7cb9-goog

