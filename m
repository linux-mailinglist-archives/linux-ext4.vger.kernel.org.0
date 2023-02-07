Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2EC68B609
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Feb 2023 08:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBFHFV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Feb 2023 02:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBFHFU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Feb 2023 02:05:20 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBFB6582;
        Sun,  5 Feb 2023 23:05:18 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 64DD81A00A26;
        Mon,  6 Feb 2023 15:05:46 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KhHkGqyEvT8U; Mon,  6 Feb 2023 15:05:44 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 6F59C1A00A0A;
        Mon,  6 Feb 2023 15:05:44 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] ext4: ialloc: Remove variables defined more than once in a function
Date:   Wed,  8 Feb 2023 07:36:32 +0800
Message-Id: <20230207233632.4723-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The grp pointer variable has been defined at the beginning of the
function. It is not necessary to define it here, so remove the variable
definition here.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 fs/ext4/ialloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 63f9bb6e8851..be9f742f9415 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1181,7 +1181,6 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 	/* Update the relevant bg descriptor fields */
 	if (ext4_has_group_desc_csum(sb)) {
 		int free;
-		struct ext4_group_info *grp = NULL;
 
 		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
 			grp = ext4_get_group_info(sb, group);
-- 
2.18.2

