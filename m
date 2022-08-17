Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDBA596FA0
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Aug 2022 15:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbiHQNQS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Aug 2022 09:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239652AbiHQNPp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Aug 2022 09:15:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A4B62A99;
        Wed, 17 Aug 2022 06:15:28 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M77hh4ldBzkWRs;
        Wed, 17 Aug 2022 21:12:04 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 17 Aug
 2022 21:15:25 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <enwlinux@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yebin10@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH 0/2] ext4: fix a infinite loop in do_writepages after online resizing
Date:   Wed, 17 Aug 2022 21:26:59 +0800
Message-ID: <20220817132701.3015912-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

We got a issue: the ext4 writeback process was stuck in do_writepages and
do_writepages kept retrying. However, '-ENOMEM' is returned each time, even
if there is still free memory on the current machine.

We find that the direct cause of this issue is that the bg_inode_table_hi
in the group descriptor is written to an incorrect value, which causes the
inode block found through the inode table to exceed the end_ block。Then,
sb_getblk always returns null, __ext4_get_inode_loc returns `-ENOMEM`,
and do_writepages keeps retrying.

The root cause is that the GDT is overwritten when the backup superblock
is updated in the online resizing process of the disk. The prerequisite is
that the block size of the disk is 1024, bigalloc and meta_bg are enabled,
and sparse_super is disabled.

Therefore, the check on inode_table is added to __ext4_get_inode_loc by
referring to the check on inode_bitmap in ext4_read_inode_bitmap to avoid
infinite loops in similar cases. In addition, the offset of the backup
super block in the group in the above case is also corrected to avoid some
strange problems caused by the GDT being overwritten.

Baokun Li (2):
  ext4: fix GDT corruption after online resizing with bigalloc enable
    and blocksize is 1024
  ext4: add inode table check in __ext4_get_inode_loc to aovid possible
    infinite loop

 fs/ext4/inode.c  | 10 +++++++++-
 fs/ext4/resize.c |  6 +++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.31.1

