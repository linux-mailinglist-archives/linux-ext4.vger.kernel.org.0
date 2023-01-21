Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9567695E
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjAUUhL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjAUUgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C5A29170
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA55CB80185
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CDBC4339C
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333402;
        bh=Za1y6KOTR72/moNo6qJUUNZ6vY4nnIf8oortRhSYW7Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ocdmFbJBnzfzYh+6YwWQtcfmWvSiU+SxaS1vSAN+SiinWXzQbc5eQSHyYm7b2f4W2
         nNEwFt6Ud0E0Dtn0Xa3PkN46oE4aO/wbo8TDPg1X4+3VexlVkqvuDdVDK05IkscbBH
         rZkQ8lVrUg9dx4bEon7C9f33KJy1yr82vus20+j9e4zjHJ3rL8oF/2Xqe08Y2ubgoo
         XipmwpFGzsde/Q+qjIJ4qt/myQewiQhYkiBgCUmMZmKLe490R579V2dt9+VyIXtqMY
         PXAIb6D/sytdWF7w3RPX/vcSTOGEh7ZJTjb2j6rv3Q5d2zz613k+r915589y642llj
         VcvayxV+33lvQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 20/38] lib/ext2fs: fix a -Wpointer-sign warning in ext2fs_mmp_start()
Date:   Sat, 21 Jan 2023 12:32:12 -0800
Message-Id: <20230121203230.27624-21-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

This showed up when building for Windows.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/ext2fs/mmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
index 7970aac27..9491fbd5c 100644
--- a/lib/ext2fs/mmp.c
+++ b/lib/ext2fs/mmp.c
@@ -356,7 +356,7 @@ clean_seq:
 #ifdef HAVE_GETHOSTNAME
 	gethostname((char *) mmp_s->mmp_nodename, sizeof(mmp_s->mmp_nodename));
 #else
-	strcpy(mmp_s->mmp_nodename, "unknown host");
+	strcpy((char *) mmp_s->mmp_nodename, "unknown host");
 #endif
 	strncpy((char *) mmp_s->mmp_bdevname, fs->device_name,
 		sizeof(mmp_s->mmp_bdevname));
-- 
2.39.0

