Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465C76EC3F8
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 05:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjDXDjn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Apr 2023 23:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDXDjn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Apr 2023 23:39:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DD9212D;
        Sun, 23 Apr 2023 20:39:41 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q4W3y1MfSzSvPr;
        Mon, 24 Apr 2023 11:35:26 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 24 Apr
 2023 11:39:39 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v4 00/12] ext4: fix WARNING in ext4_da_update_reserve_space
Date:   Mon, 24 Apr 2023 11:38:34 +0800
Message-ID: <20230424033846.4732-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

V1->V2:
        Modify the patch 1 description and add the Fixes tag.
        Add the patch 2 as suggested by Jan Kara.
V2->V3:
        Remove the redundant judgment of count in Patch [1].
        Rename ext4_es_alloc_should_nofail to ext4_es_must_keep.
        Split Patch [2].
        Make some functions return void to simplify the code.
V3->V4:
        using nofail preallocation.

This patch set consists of three parts:
1. Patch [1] fix WARNING in ext4_da_update_reserve_space.
2. Patch [2]-[8] fix extent tree inconsistencies that may be caused
   by memory allocation failures.
3. Patch [9]-[12] is cleanup.

Baokun Li (12):
  ext4: only update i_reserved_data_blocks on successful block
    allocation
  ext4: add a new helper to check if es must be kept
  ext4: factor out __es_alloc_extent() and __es_free_extent()
  ext4: use pre-allocated es in __es_insert_extent()
  ext4: use pre-allocated es in __es_remove_extent()
  ext4: using nofail preallocation in ext4_es_remove_extent()
  ext4: using nofail preallocation in ext4_es_insert_delayed_block()
  ext4: using nofail preallocation in ext4_es_insert_extent()
  ext4: make ext4_es_remove_extent() return void
  ext4: make ext4_es_insert_delayed_block() return void
  ext4: make ext4_es_insert_extent() return void
  ext4: make ext4_zeroout_es() return void

 fs/ext4/extents.c        |  49 +++------
 fs/ext4/extents_status.c | 207 ++++++++++++++++++++++++---------------
 fs/ext4/extents_status.h |  14 +--
 fs/ext4/indirect.c       |   8 ++
 fs/ext4/inline.c         |  12 +--
 fs/ext4/inode.c          |  49 ++-------
 6 files changed, 169 insertions(+), 170 deletions(-)

-- 
2.31.1

