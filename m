Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2582F170D1
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2019 08:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfEHGNp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 May 2019 02:13:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46736 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEHGNp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 May 2019 02:13:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3452760779; Wed,  8 May 2019 06:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557296024;
        bh=6JF1Wj9rmKFTxA+ck/bXWL6AFxtAP0AJGAAq9KaA1bU=;
        h=From:To:Cc:Subject:Date:From;
        b=GvRmc3UDU6h23XQcy1351x+WxIxy3U5tBLP6nWf13GDw25uvmuPi1n3XZRJl04KHa
         Ct0UxvJw4cPu/Xlx0btssTOcSyySeUZfzL2cvXRAeC1xWnJForTyJYNaPR5nbs2Q1q
         otAZWBrqptTg5YJYwAqtjiLg0c8t/nbd15eX59Iw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CBFBA60779;
        Wed,  8 May 2019 06:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557296023;
        bh=6JF1Wj9rmKFTxA+ck/bXWL6AFxtAP0AJGAAq9KaA1bU=;
        h=From:To:Cc:Subject:Date:From;
        b=jhZxQGupSaxx8wMvNJ4B9wqgIL/OosUUPGfEqgfS0x1LGwnb5m9HZj9QQix3Ec8jb
         Dbr/2oRXREm9BMbVfN77VPRq3NsNaAHSryU0jxcLolPaNIbHDt3L3JR0J88d0rOhB6
         pp2lIyKZon/h7AP4b3L6HphthxRWzCbKG3u9P28o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CBFBA60779
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] ext4: fix use-after-free in dx_release()
Date:   Wed,  8 May 2019 11:43:17 +0530
Message-Id: <1557295997-13377-1-git-send-email-stummala@codeaurora.org>
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
 fs/ext4/namei.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 4181c9c..7e6c298 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -871,12 +871,14 @@ static void dx_release(struct dx_frame *frames)
 {
 	struct dx_root_info *info;
 	int i;
+	unsigned int indirect_levels;
 
 	if (frames[0].bh == NULL)
 		return;
 
 	info = &((struct dx_root *)frames[0].bh->b_data)->info;
-	for (i = 0; i <= info->indirect_levels; i++) {
+	indirect_levels = info->indirect_levels;
+	for (i = 0; i <= indirect_levels; i++) {
 		if (frames[i].bh == NULL)
 			break;
 		brelse(frames[i].bh);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

