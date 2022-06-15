Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77B254C073
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jun 2022 05:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbiFODyv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jun 2022 23:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353935AbiFODyP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jun 2022 23:54:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DBD193FE;
        Tue, 14 Jun 2022 20:53:39 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LNBF80r8Jz1K9hC;
        Wed, 15 Jun 2022 11:51:40 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 15 Jun
 2022 11:53:37 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <enwlinux@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yebin10@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH v2 4/4] ext4: correct the misjudgment in ext4_iget_extra_inode
Date:   Wed, 15 Jun 2022 12:06:30 +0800
Message-ID: <20220615040630.808783-5-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220615040630.808783-1-libaokun1@huawei.com>
References: <20220615040630.808783-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use the EXT4_INODE_HAVE_XATTR_SPACE macro to more accurately
determine whether the inode have xattr space.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3dce7d058985..e7c6d7e1b531 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4685,8 +4685,7 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
 	__le32 *magic = (void *)raw_inode +
 			EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize;
 
-	if (EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize + sizeof(__le32) <=
-	    EXT4_INODE_SIZE(inode->i_sb) &&
+	if (EXT4_INODE_HAVE_XATTR_SPACE(inode)  &&
 	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
 		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
 		return ext4_find_inline_data_nolock(inode);
-- 
2.31.1

