Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEEF50D224
	for <lists+linux-ext4@lfdr.de>; Sun, 24 Apr 2022 15:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbiDXN6i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 24 Apr 2022 09:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiDXN6i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 24 Apr 2022 09:58:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8DE140A5
        for <linux-ext4@vger.kernel.org>; Sun, 24 Apr 2022 06:55:37 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KmV311QBtzGp4J;
        Sun, 24 Apr 2022 21:53:01 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Apr
 2022 21:55:22 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>, <yebin10@huawei.com>
Subject: [RFC PATCH v4 0/2] ext4: standardize the journal mode of symlink external block
Date:   Sun, 24 Apr 2022 22:09:34 +0800
Message-ID: <20220424140936.1898920-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Standardize the journal mode of symlink external block, from the
essentially data=journal mode to 'standard mode' like other metadata
blocks. (e.g. directory blocks and directory blocks...)

Thanks,
Yi.

v4->v3:
  - Add a query cache 'no-wait' mode of ext4_getblk() and
    ext4_map_blocks() to fix potential sleep problem in RCU context.
v3->v2:
 - Retry if it fail in close-to-ENOSPC conditions.
 - Use ext4_add_nondir() to add dir entry for no-fast symlink.
 - Fix RCU walking for symlinks.
 - Ensure nul-terminate when in ext4_get_link().
v2->v1:
 - Add comment to explain the credits of creating symlink.

[v3]: https://lore.kernel.org/linux-ext4/20220418063735.2067766-1-yi.zhang@huawei.com/
[v2]: https://lore.kernel.org/linux-ext4/20220412083941.2242143-1-yi.zhang@huawei.com/
[v1]: https://lore.kernel.org/linux-ext4/20220406084503.1961686-1-yi.zhang@huawei.com/


Zhang Yi (2):
  ext4: add nowait mode for ext4_getblk()
  ext4: convert symlink external data block mapping to bdev

 fs/ext4/ext4.h    |   2 +
 fs/ext4/inode.c   |  23 ++++++---
 fs/ext4/namei.c   | 123 +++++++++++++++++++++-------------------------
 fs/ext4/symlink.c |  51 ++++++++++++++++---
 4 files changed, 116 insertions(+), 83 deletions(-)

-- 
2.31.1

