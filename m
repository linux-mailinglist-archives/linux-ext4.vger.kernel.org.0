Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F0C79DE21
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Sep 2023 04:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbjIMCNi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Sep 2023 22:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbjIMCNh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Sep 2023 22:13:37 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F422C170A
        for <linux-ext4@vger.kernel.org>; Tue, 12 Sep 2023 19:13:32 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-649edb3a3d6so2280006d6.0
        for <linux-ext4@vger.kernel.org>; Tue, 12 Sep 2023 19:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694571212; x=1695176012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWYPb6XbBYAt7JEtcPX2lW9Nze2hMGhfGEtPRe1JPqs=;
        b=lbuJgNMwfSOD8lPNmbFEvIjWAWeT4V6FFTqkXRHI3uXM+W2PcrtDlbmDjmm3vyU0L5
         JLnbYTS1bZXdYEOG218nltHvVEEFvaY7xat768LoT3xpZHC0Jqdsu5HCgH6FfuE2FiAn
         UgF/dsoMzaMTB3SgR8jF/ewyZMDbK51vM9KQM1eG7jGnIazm0DvGQgyOd5BKetuLR+FJ
         Vc0nmCqrvUVRKpSE4aaNSjN1waTYzrl0BORMF4COIQyWhWoGzTgRJ2dAswYcvqWGBXEK
         wNY4Krpib9/6lee8B9aqF1OSbnXZgDhwEdbfkfWK0FoTmYY9Z2h2bwBUtf1bWjet9TFs
         EB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694571212; x=1695176012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWYPb6XbBYAt7JEtcPX2lW9Nze2hMGhfGEtPRe1JPqs=;
        b=NwJjOyolqchOaL8qnqJkITvuDEpTw3C5oBklBPiAcl4tR71II2XWdpFNuDjaRy9rJe
         REyMDgBIvPHOlx+pd2WbyUc5wPuincMfkGQdXj0/9eJ4Yd1P5MMPAdosM2mpJTpuGTsb
         1Tx8t0Pq7IQNUIQJrtVcEg6CD0+pq4ypZJ3j4tSkaMKIsneofyxz04IvEiiFje7o1O+J
         dolvwTWpMMph2iInWE5APfkIddwjmJHGuE/HQSHNoEaYnWRwhznfSdeRbUV8hjGgglIp
         VjFFuM31/H/mf96J14t4iEgPTN0M7EVQNqKV87HAJZB907Dd5SBBlsrKjTYAeKk/1fjl
         DuTA==
X-Gm-Message-State: AOJu0YwRGPop5n5+xCtqOrSHDXi9/HM8Ba8TzhH8VwPpcfjZhzBcR+hm
        ZsrLKLZixi/62271EEG8VimvTv4J7iE=
X-Google-Smtp-Source: AGHT+IGTWKPfPFkxuKeiLCq0sTz5/jR0qwNGLFPhy8xvOdQIr+K4uyJIl38ZvWqrJtN9Vzk6n8vFCQ==
X-Received: by 2002:a05:6214:f23:b0:63f:9130:4e9c with SMTP id iw3-20020a0562140f2300b0063f91304e9cmr5582358qvb.26.1694571211883;
        Tue, 12 Sep 2023 19:13:31 -0700 (PDT)
Received: from localhost.localdomain (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id c8-20020a0cf2c8000000b0064f778c8165sm4016055qvm.64.2023.09.12.19.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 19:13:31 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 6/6] ext4: remove mballoc's NOFREE flags
Date:   Tue, 12 Sep 2023 22:11:48 -0400
Message-Id: <20230913021148.1181646-7-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913021148.1181646-1-enwlinux@gmail.com>
References: <20230913021148.1181646-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_remove_space() no longer relies on the NOFREE_FIRST_CLUSTER and
NOFREE_LAST_CLUSTER flags used to condition the behavior of
ext4_free_blocks() when applied to clusters.  Remove everything
related to those flags.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/ext4.h              |  4 +---
 fs/ext4/mballoc.c           | 25 ++++---------------------
 include/trace/events/ext4.h |  4 +---
 3 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9418359b1d9d..32c803f7dc56 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -736,9 +736,7 @@ enum {
 #define EXT4_FREE_BLOCKS_FORGET			0x0002
 #define EXT4_FREE_BLOCKS_VALIDATED		0x0004
 #define EXT4_FREE_BLOCKS_NO_QUOT_UPDATE		0x0008
-#define EXT4_FREE_BLOCKS_NOFREE_FIRST_CLUSTER	0x0010
-#define EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER	0x0020
-#define EXT4_FREE_BLOCKS_RERESERVE_CLUSTER      0x0040
+#define EXT4_FREE_BLOCKS_RERESERVE_CLUSTER      0x0010
 
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c91db9f57524..f9096ab49bfb 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6681,35 +6681,18 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 	/*
 	 * If the extent to be freed does not begin on a cluster
 	 * boundary, we need to deal with partial clusters at the
-	 * beginning and end of the extent.  Normally we will free
-	 * blocks at the beginning or the end unless we are explicitly
-	 * requested to avoid doing so.
+	 * beginning and end of the extent.
 	 */
 	overflow = EXT4_PBLK_COFF(sbi, block);
 	if (overflow) {
-		if (flags & EXT4_FREE_BLOCKS_NOFREE_FIRST_CLUSTER) {
-			overflow = sbi->s_cluster_ratio - overflow;
-			block += overflow;
-			if (count > overflow)
-				count -= overflow;
-			else
-				return;
-		} else {
-			block -= overflow;
-			count += overflow;
-		}
+		block -= overflow;
+		count += overflow;
 		/* The range changed so it's no longer validated */
 		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
 	}
 	overflow = EXT4_LBLK_COFF(sbi, count);
 	if (overflow) {
-		if (flags & EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER) {
-			if (count > overflow)
-				count -= overflow;
-			else
-				return;
-		} else
-			count += sbi->s_cluster_ratio - overflow;
+		count += sbi->s_cluster_ratio - overflow;
 		/* The range changed so it's no longer validated */
 		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
 	}
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index b474ded2623d..786987154893 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -71,9 +71,7 @@ TRACE_DEFINE_ENUM(BH_Boundary);
 	{ EXT4_FREE_BLOCKS_METADATA,		"METADATA" },	\
 	{ EXT4_FREE_BLOCKS_FORGET,		"FORGET" },	\
 	{ EXT4_FREE_BLOCKS_VALIDATED,		"VALIDATED" },	\
-	{ EXT4_FREE_BLOCKS_NO_QUOT_UPDATE,	"NO_QUOTA" },	\
-	{ EXT4_FREE_BLOCKS_NOFREE_FIRST_CLUSTER,"1ST_CLUSTER" },\
-	{ EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER,	"LAST_CLUSTER" })
+	{ EXT4_FREE_BLOCKS_NO_QUOT_UPDATE,	"NO_QUOTA" })
 
 TRACE_DEFINE_ENUM(ES_WRITTEN_B);
 TRACE_DEFINE_ENUM(ES_UNWRITTEN_B);
-- 
2.30.2

