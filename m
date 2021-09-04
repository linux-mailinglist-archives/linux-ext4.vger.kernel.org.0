Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E792C4009CE
	for <lists+linux-ext4@lfdr.de>; Sat,  4 Sep 2021 06:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhIDEko (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 4 Sep 2021 00:40:44 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15238 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhIDEkn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 4 Sep 2021 00:40:43 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H1hkk6qczz1DD7Z;
        Sat,  4 Sep 2021 12:38:54 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 4 Sep 2021 12:39:40 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 4 Sep 2021 12:39:40 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 0/2] bugfix for read_extent_tree_block
Date:   Sat, 4 Sep 2021 12:49:44 +0800
Message-ID: <20210904044946.2102404-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Our stress testcase with io error can trigger later OOB:

    [59898.282466] BUG: KASAN: slab-out-of-bounds in ext4_find_extent+0x2e4/0x480
    ...
    [59898.287162] Call Trace:
    [59898.287575]  dump_stack+0x8b/0xb9
    [59898.288070]  print_address_description+0x73/0x280
    [59898.289903]  ext4_find_extent+0x2e4/0x480
    [59898.290553]  ext4_ext_map_blocks+0x125/0x1470
    [59898.295481]  ext4_map_blocks+0x5ee/0x940
    [59898.315984]  ext4_mpage_readpages+0x63c/0xdb0
    [59898.320231]  read_pages+0xe6/0x370
    [59898.321589]  __do_page_cache_readahead+0x233/0x2a0
    [59898.321594]  ondemand_readahead+0x157/0x450
    [59898.321598]  generic_file_read_iter+0xcb2/0x1550
    [59898.328828]  __vfs_read+0x233/0x360
    [59898.328840]  vfs_read+0xa5/0x190
    [59898.330126]  ksys_read+0xa5/0x150
    [59898.331405]  do_syscall_64+0x6d/0x1f0
    [59898.331418]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

It seem that a xattr block with verified confuse read_extent_tree_block.

The detail of the patch show us how to fix it.

yangerkun (2):
  ext4: avoid recheck extent for EXT4_EX_FORCE_CACHE
  ext4: check magic even the extent block bh is verified

 fs/ext4/extents.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

-- 
2.31.1

