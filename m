Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B271173EA
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2019 10:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEHIeS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 May 2019 04:34:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48558 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfEHIeS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 May 2019 04:34:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0582C60D35; Wed,  8 May 2019 08:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557304457;
        bh=mDhuWudJppV+tmXjscDKqdwNpRqZ0VH+uYhZq8ihmDo=;
        h=From:To:Cc:Subject:Date:From;
        b=IBeZgb+5WCYEaQG9Gm5AujgPNZ8sqb1PsDyN3WPBvSp5VAosXWuzOt4zKoDqF0CiF
         dkEsICItQb9JjMmpZPj9/ZfbV2q7ing/3leaTrdRaAqEsq7Y9E8y4BODfqTWI8GITW
         W7XoRp6CfJKgGrOpPMMkojYSFy6Og8XyyGo8Opdg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87E2B60850;
        Wed,  8 May 2019 08:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557304456;
        bh=mDhuWudJppV+tmXjscDKqdwNpRqZ0VH+uYhZq8ihmDo=;
        h=From:To:Cc:Subject:Date:From;
        b=OLIvWECNUQ1mm8tprveMc+0l/bj3J6y5R5U2EhfVH3PR6wfbZTuG+mu32Z31RyYC6
         iWyQJJbny2xy11JtRbqhVazxy3BiYz/+tcymHbCPJbtaXmwpToeSmBfZWeykTzXJLs
         6iPisyyQAAUi2ma7STpMt9zel+FJJ+P6A7I6VQpM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87E2B60850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH v2] ext4: fix use-after-free in dx_release()
Date:   Wed,  8 May 2019 14:04:03 +0530
Message-Id: <1557304443-18653-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The buffer_head (frames[0].bh) and it's corresping page can be
potentially free'd once brelse() is done inside the for loop
but before the for loop exits in dx_release(). It can be free'd
in another context, when the page cache is flushed via
drop_caches_sysctl_handler(). This results into below data abort
when accessing info->indirect_levels in dx_release().

Unable to handle kernel paging request at virtual address ffffffc17ac3e01e
Call trace:
 dx_release+0x70/0x90
 ext4_htree_fill_tree+0x2d4/0x300
 ext4_readdir+0x244/0x6f8
 iterate_dir+0xbc/0x160
 SyS_getdents64+0x94/0x174

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v2:
add a comment in dx_release()

 fs/ext4/namei.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 980166a..5d9ffa8 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -871,12 +871,15 @@ static void dx_release(struct dx_frame *frames)
 {
 	struct dx_root_info *info;
 	int i;
+	unsigned int indirect_levels;
 
 	if (frames[0].bh == NULL)
 		return;
 
 	info = &((struct dx_root *)frames[0].bh->b_data)->info;
-	for (i = 0; i <= info->indirect_levels; i++) {
+	/* save local copy, "info" may be freed after brelse() */
+	indirect_levels = info->indirect_levels;
+	for (i = 0; i <= indirect_levels; i++) {
 		if (frames[i].bh == NULL)
 			break;
 		brelse(frames[i].bh);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

