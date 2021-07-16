Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF83CB734
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jul 2021 14:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbhGPMPN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jul 2021 08:15:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:11433 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhGPMPM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jul 2021 08:15:12 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GR9530w7RzcdT2;
        Fri, 16 Jul 2021 20:08:55 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Jul 2021 20:12:12 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v3 0/4] ext4: improve delalloc buffer write performance
Date:   Fri, 16 Jul 2021 20:20:20 +0800
Message-ID: <20210716122024.1105856-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Changes since v2:
 - Patch 3: fix misleading comment about data truncate in the error path
            of ext4_write_inline_data_end().

Thanks,
Yi.

--------

Changes since v1:

 - Patch 1: add comments to explain why and how to update i_disksize in
            ext4_da_write_end().
 - Patch 3: update i_disksize only if copied is not zero and drop
            i_size_changed parameter, also drop unused EXT4_STATE_JDATA
            and i_datasync_tid update code hook.

Original description:

This patchset address to improve buffer write performance with delalloc.
The first patch reduce the unnecessary update i_disksize, the second two
patch refactor the inline data write procedure and also do some small
fix, the last patch do improve by remove all unnecessary journal handle
in the delalloc write procedure.

After this patch set, we could get a lot of performance improvement.
Below is the Unixbench comparison data test on my machine with 'Intel
Xeon Gold 5120' CPU and nvme SSD backend.

Test cmd:

  ./Run -c 56 -i 3 fstime fsbuffer fsdisk

Before this patch set:

  System Benchmarks Partial Index           BASELINE       RESULT   INDEX
  File Copy 1024 bufsize 2000 maxblocks       3960.0     422965.0   1068.1
  File Copy 256 bufsize 500 maxblocks         1655.0     105077.0   634.9
  File Copy 4096 bufsize 8000 maxblocks       5800.0    1429092.0   2464.0
                                                                    ========
  System Benchmarks Index Score (Partial Only)                      1186.6

After this patch set:

  System Benchmarks Partial Index           BASELINE       RESULT   INDEX
  File Copy 1024 bufsize 2000 maxblocks       3960.0     732716.0   1850.3
  File Copy 256 bufsize 500 maxblocks         1655.0     184940.0   1117.5
  File Copy 4096 bufsize 8000 maxblocks       5800.0    2427152.0   4184.7
                                                                    ========
  System Benchmarks Index Score (Partial Only)                      2053.0




Zhang Yi (4):
  ext4: check and update i_disksize properly
  ext4: correct the error path of ext4_write_inline_data_end()
  ext4: factor out write end code of inline file
  ext4: drop unnecessary journal handle in delalloc write

 fs/ext4/ext4.h   |   3 -
 fs/ext4/inline.c | 120 ++++++++++++++++++-------------------
 fs/ext4/inode.c  | 150 ++++++++++++-----------------------------------
 3 files changed, 99 insertions(+), 174 deletions(-)

-- 
2.31.1

