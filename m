Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F3468CFB3
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Feb 2023 07:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjBGGqL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Feb 2023 01:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjBGGqJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Feb 2023 01:46:09 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD551BE7
        for <linux-ext4@vger.kernel.org>; Mon,  6 Feb 2023 22:46:08 -0800 (PST)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P9trV6vGcz16NRD;
        Tue,  7 Feb 2023 14:43:54 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500016.china.huawei.com
 (7.185.36.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Feb
 2023 14:46:04 +0800
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>,
        <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH v3 0/2] fix extents need to be restored when ext4_ext_insert_extent failed
Date:   Tue, 7 Feb 2023 15:09:29 +0800
Message-ID: <20230207070931.2189663-1-zhanchengbin1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Inside the ext4_ext_insert_extent function, every error returned will
not destroy the consistency of the tree. Even if it fails after changing
half of the tree, can also ensure that the tree is self-consistent, like
function ext4_ext_create_new_leaf.
After ext4_ext_insert_extent fails, update extent status tree depends on
the incoming split_flag. So restore the len of extent to be split when
ext4_ext_insert_extent return failed in ext4_split_extent_at.

Diff v2 Vs v1:
1) return directly after inserting successfully
2) restore the length of extent in memory after inserting unsuccessfully

Diff v3 Vs v2:
Sorry for not taking into account the successful extent insertion. and I
reanalyzed the ext4_ext_insert_extent function and modified the conditions
for restoring the length.

zhanchengbin (2):
  ext4: fix inode tree inconsistency caused by ENOMEM in
    ext4_split_extent_at
  ext4: restore len when ext4_ext_insert_extent failed

 fs/ext4/extents.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.31.1

