Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95164685ED9
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Feb 2023 06:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBAFY1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Feb 2023 00:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjBAFY0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Feb 2023 00:24:26 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3DC53B1D
        for <linux-ext4@vger.kernel.org>; Tue, 31 Jan 2023 21:24:25 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3115OHNX032460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 00:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675229059; bh=uRZvWgTD6g2517ODKetGywm7jGbm1NgDt/saz0vpXWU=;
        h=From:To:Cc:Subject:Date;
        b=buB2FW+ab335nq7J7exuiB0R5ucY8zMfWrvagJFrCbkDbifYobEb9KnRAjSFrSk99
         G2o7izAxXqndWOgTfgmj1s+QdWu2SCnHmK0op8XxnHA7cxgvjyYgSSHEDk1thCCUpq
         eGwyIJBGlK4/M9UAsL8Xeie4EZZ5vfpDzFBx0Qq8e7b+57oUVpDev4YINzCR0KtT+T
         wQKM0agJOrKReaZ62U4AGQoLDDhf5Tf0N0KAx6FcrHu63WRFVXdMq1MSBbxwkbLZGV
         Fut1rhxrxb0ZD/puMPKNPoeO8GRvGNlII3LcTUKaNm15hG0zmAj9EJxsTYQHlBl9C/
         vc258mKgV4AqA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 65AEF15C359D; Wed,  1 Feb 2023 00:24:17 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] e4defrag: avoid potential buffer overflow caused by very long file names
Date:   Wed,  1 Feb 2023 00:24:10 -0500
Message-Id: <20230201052410.440207-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Addresses-Coverity-Bug: 1520603
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 misc/e4defrag.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/misc/e4defrag.c b/misc/e4defrag.c
index 33bd05d2..99bc2cd7 100644
--- a/misc/e4defrag.c
+++ b/misc/e4defrag.c
@@ -1041,7 +1041,7 @@ static int file_statistic(const char *file, const struct stat64 *buf,
 	__u64	size_per_ext = 0;
 	float	ratio = 0.0;
 	ext4_fsblk_t	blk_count = 0;
-	char	msg_buffer[PATH_MAX + 24];
+	char	msg_buffer[PATH_MAX + 48];
 	struct fiemap_extent_list *physical_list_head = NULL;
 	struct fiemap_extent_list *logical_list_head = NULL;
 
@@ -1210,8 +1210,9 @@ static int file_statistic(const char *file, const struct stat64 *buf,
 
 	if (mode_flag & DETAIL) {
 		/* Print statistic info */
-		sprintf(msg_buffer, "[%u/%u]%s",
-				defraged_file_count, total_count, file);
+		sprintf(msg_buffer, "[%u/%u]%.*s",
+				defraged_file_count, total_count,
+			PATH_MAX, file);
 		if (current_uid == ROOT_UID) {
 			if (strlen(msg_buffer) > 40)
 				printf("\033[79;0H\033[K%s\n"
-- 
2.31.0

