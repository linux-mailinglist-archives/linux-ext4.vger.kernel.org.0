Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DB665CCB2
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 06:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjADF46 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 00:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjADF4k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 00:56:40 -0500
X-Greylist: delayed 244 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 21:56:40 PST
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE3A1759D;
        Tue,  3 Jan 2023 21:56:39 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 4810D1A00999;
        Wed,  4 Jan 2023 13:52:44 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nEbsOfS58wzc; Wed,  4 Jan 2023 13:52:43 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 71D9C1A00912;
        Wed,  4 Jan 2023 13:52:43 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH 1/1] fs/ext4/inode.c: Remove unnecessary variable initialization
Date:   Wed,  4 Jan 2023 13:52:29 +0800
Message-Id: <20230104055229.3663-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Variables are assigned first and then used. Initialization is not required.

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9d9f414f99fe..9df913bdb416 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5788,7 +5788,7 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 	ext4_group_t groups, ngroups = ext4_get_groups_count(inode->i_sb);
 	int gdpblocks;
 	int idxblocks;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * How many index blocks need to touch to map @lblocks logical blocks
-- 
2.18.2

