Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C308E5B2F4A
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Sep 2022 08:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIIGxM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Sep 2022 02:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIIGxL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Sep 2022 02:53:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB49125B3E;
        Thu,  8 Sep 2022 23:53:10 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MP66f38TgzmVMd;
        Fri,  9 Sep 2022 14:49:30 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 14:53:07 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <riteshh@linux.ibm.com>, <cuigaosheng1@huawei.com>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ext4: remove ext4_inline_data_fiemap() declaration
Date:   Fri, 9 Sep 2022 14:53:07 +0800
Message-ID: <20220909065307.1155201-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_inline_data_fiemap() has been removed since
commit d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework"),
so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 fs/ext4/ext4.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9bca5565547b..ad4950b987dd 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3591,9 +3591,6 @@ extern bool empty_inline_dir(struct inode *dir, int *has_inline_data);
 extern struct buffer_head *ext4_get_first_inline_block(struct inode *inode,
 					struct ext4_dir_entry_2 **parent_de,
 					int *retval);
-extern int ext4_inline_data_fiemap(struct inode *inode,
-				   struct fiemap_extent_info *fieinfo,
-				   int *has_inline, __u64 start, __u64 len);
 extern void *ext4_read_inline_link(struct inode *inode);
 
 struct iomap;
-- 
2.25.1

