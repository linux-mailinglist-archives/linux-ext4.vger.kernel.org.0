Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73BD6253FC
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Nov 2022 07:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbiKKGoD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Nov 2022 01:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiKKGoC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Nov 2022 01:44:02 -0500
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C99D64A24;
        Thu, 10 Nov 2022 22:43:58 -0800 (PST)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id FHC00055;
        Fri, 11 Nov 2022 14:43:55 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.12; Fri, 11 Nov 2022 14:43:55 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] ext2: Fix some kernel-doc warnings
Date:   Fri, 11 Nov 2022 01:43:52 -0500
Message-ID: <20221111064352.2866-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   202211111443556300c9a38e960479fdca0cb619270922
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The current code provokes some kernel-doc warnings:
	fs/ext2/dir.c:417: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 fs/ext2/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 8f597753ac12..27873733ed8c 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -413,7 +413,7 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
 	return de;
 }
 
-/**
+/*
  * Return the '..' directory entry and the page in which the entry was found
  * (as a parameter - p).
  *
-- 
2.27.0

