Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7F960DA19
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Oct 2022 06:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJZEBY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Oct 2022 00:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJZEBW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Oct 2022 00:01:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E998844EB;
        Tue, 25 Oct 2022 21:01:20 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mxw4w4gDCzpVmV;
        Wed, 26 Oct 2022 11:57:52 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 12:01:17 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 0/4] ext4: fix two bug_on in __es_tree_search
Date:   Wed, 26 Oct 2022 12:23:06 +0800
Message-ID: <20221026042310.3839669-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

V1->V2:
	In patch 2, when imode is not set to S_IFREG, the inode also needs
	to be initialized. Otherwise, the check can be bypassed, causing
	the BUG_ON. (found in the review by yangerkun)
V2->V3:
	a. add EXT4_IGET_BAD flag to prevent unexpected bad inode.
	b. check bad quota inode in vfs_setup_quota_inode() instead of in
	   ext4_quota_enable() for more generic approach to this problem.
	c. add helper to check quota inums.

Baokun Li (4):
  ext4: fix bug_on in __es_tree_search caused by bad quota inode
  ext4: add helper to check quota inums
  ext4: add EXT4_IGET_BAD flag to prevent unexpected bad inode
  ext4: fix bug_on in __es_tree_search caused by bad boot loader inode

 fs/ext4/ext4.h   |  3 ++-
 fs/ext4/inode.c  |  8 +++++++-
 fs/ext4/ioctl.c  |  5 +++--
 fs/ext4/super.c  | 28 +++++++++++++++++++++++++---
 fs/quota/dquot.c |  2 ++
 5 files changed, 39 insertions(+), 7 deletions(-)

-- 
2.31.1

