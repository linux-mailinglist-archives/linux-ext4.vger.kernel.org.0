Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948D6536C60
	for <lists+linux-ext4@lfdr.de>; Sat, 28 May 2022 12:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344448AbiE1Kq5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 May 2022 06:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiE1Kq4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 May 2022 06:46:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D54413D66;
        Sat, 28 May 2022 03:46:54 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L9JGj65dQzgY97;
        Sat, 28 May 2022 18:45:17 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 28 May
 2022 18:46:52 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yebin10@huawei.com>, <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 0/3] ext4: fix two bugs in ext4_mb_normalize_request
Date:   Sat, 28 May 2022 19:00:14 +0800
Message-ID: <20220528110017.354175-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The logical block map reached before the problem stack was 1011.
The estimated location of the size logical block of the inde plus
the required allocation length 7, the size is 1018.

But the i_size of inode is 1299, so the size is 1299,
the aligned size is 2048, and the end is 2048.
Because of the restriction of ar -> pleft, start==648.

EXT4_BLOCKS_PER_GROUP (ac- > ac_sb) is 256,
so the size is 256 and the end is 904.

It is not normal to truncate here, the end is less than 1299 of the
target logical block, that is, the allocated range does not contain
the target logical block.

Then this new scope conflicts with the previous PA, as follows:

        pa_start-506        pa_end-759
 |____________P________V_________P__________V_____________l________|
 0                 start-648             end-904    logical-1299   2048

In this case, start is changed to pa_end, that is, 759.
In this case, a bug_ON is reported in ext4_mb_mark_diskspace_used.

The problem is caused by the truncation introduced in the
cd648b8a8fd5 ("ext4: trim allocation requests to group size").
The size must be smaller than or equal to EXT4_BLOCKS_PER_GROUP.
However, the truncation method is incorrect. The group where the
logical is located should be used for allocation. If the value of
EXT4_BLOCKS_PER_GROUP is 256, size 2048 can be divided into eight
groups. If the value of logical is 1299, the value of logical must be
in the sixth group, that is,
	start=1299/256*256=5*256=1280,
	end=size+1280=1536.

Then, the value range can be further narrowed down based on
other restrictions.
                              1024    1280     1536
|_______|_______|_______|_______|_______|__l_____|_______|_______|
0 group1  group2  group3  group4  group5  group6  group7  group8 2048 

At the same time, we fixed earlier assertions that we could find out when
the target logical block was not in the allocated range.

Ritesh Harjani found that flex_bg groups was not considered in
ext4_mb_normalize_request. So we add support for flex_bg to make
the physical blocks of large files contiguous.

I ran xfstests on ext3 and ext4 and found no problems in ext3/4.

V1: https://patchwork.ozlabs.org/project/linux-ext4/cover/20220521134217.312071-1-libaokun1@huawei.com/
V2: https://patchwork.ozlabs.org/project/linux-ext4/cover/20220523141658.2919003-1-libaokun1@huawei.com/

Baokun Li (3):
  ext4: fix bug_on ext4_mb_use_inode_pa
  ext4: correct the judgment of BUG in ext4_mb_normalize_request
  ext4: support flex_bg in ext4_mb_normalize_request

 fs/ext4/mballoc.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

-- 
2.31.1

