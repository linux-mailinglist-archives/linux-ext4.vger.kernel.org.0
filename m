Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C6361F2F7
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiKGMYX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiKGMYT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:24:19 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236DF63C2
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:24:19 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 64so10309340pgc.5
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZ3j7EdKBWVYJUuDDkl+rN6c4DTW2MiR6s2rRB1jtXM=;
        b=jegXKvA1zOPiYEuuHil8v1JcZvcIoj9uWWdoNHpCuybmAhyzrHMestZ8w/URCdCQdi
         YEj1RhFO9MDqvR73HLYMRMXQ5GrfTFPbhQojS1tHfCZYkMz6XSvfmhehJ1lmM1Noz1YV
         OsiqCuCg6sOrm7kWS0+Dd5L0TOwPRfGEdC1p9xhTqeruUl5w/9f2eGU27FpgZEXWK5h8
         VjWYoAJ+nZchesaPzImiBb7IcYxunFScMNVAY8hdY/jijsQxJZXVRR9Kxakcw5NK9Ut8
         Qhk/uRhdYxA33j3CR6WyvMqKy9si3NilUGLtQNyNB1kSbiuNhAWgSuKHqZw+44lXbqx7
         8gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZ3j7EdKBWVYJUuDDkl+rN6c4DTW2MiR6s2rRB1jtXM=;
        b=dwDlN63ArbDNP760TOsdchwAjow+4Y64kzOLryzhG9LyUFNRDFhxu9XtXfaOoBJW86
         7MmSqy7ORz+nJWP2T6pKRe2CPxNI0nTrfymqJ8XUR4QkQK2XxGz7/OHcP4OtE/cYUaUp
         bJMjl7GowyRoRIBXGc76UJ2NHEJi1VNS44wuBAta0HWiqqWuXesZdDaGdlBH2dMguGPI
         TNGaEsuOvR/HRXrvMR5Z0MJmDzVAh8QcLL1GaCTPYargyhXxNej7uaXlhAL1eyvSXmMH
         TR1G+0DilhwukImSuqFsH2jQYPE0ZeUVvhgSU3iPHrxO7Lue9mh+plC2CEDHGhG6LTyq
         vnIg==
X-Gm-Message-State: ACrzQf3d6so81KGFVqZu1rfzeCMF4uPtBLlDL4E8PQGw3RZ+FBn6LMrY
        qa6Lqtn6yTASChIv9PaOIs4=
X-Google-Smtp-Source: AMsMyM6sqRdScPwmvX7UxBes8LBeI0whAdz6owYLSSxdaVH+K4dE3EBwYNxJ/wjtRzO9koys38oLTw==
X-Received: by 2002:a65:4bc3:0:b0:439:103b:fc35 with SMTP id p3-20020a654bc3000000b00439103bfc35mr42555258pgr.248.1667823858666;
        Mon, 07 Nov 2022 04:24:18 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id t10-20020a63224a000000b00460d89df1f1sm4079017pgm.57.2022.11.07.04.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:24:18 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Andreas Dilger <adilger@whamcloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 19/72] libext2fs: Misc fixes for struct_ext2_filsys
Date:   Mon,  7 Nov 2022 17:51:07 +0530
Message-Id: <d9c1ee96a026bfa4652e1c57d7c7dc40bdf049df.1667822611.git.ritesh.list@gmail.com>
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

From: Andreas Dilger <adilger@whamcloud.com>

Move ext2_filsys fs_num_threads to fit into the __u16 "pad" field
to avoid consuming one of the few remaining __u32 reserved fields.

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/ext2fs/ext2fs.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 6b4926ce..950ab042 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -278,12 +278,11 @@ struct struct_ext2_filsys {
 	time_t				now;
 	int				cluster_ratio_bits;
 	__u16				default_bitmap_type;
-	__u16				pad;
-	__u32				fs_num_threads;
+	__u16				fs_num_threads;
 	/*
 	 * Reserved for future expansion
 	 */
-	__u32				reserved[4];
+	__u32				reserved[5];
 
 	/*
 	 * Reserved for the use of the calling application.
-- 
2.37.3

