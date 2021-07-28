Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234883D85B6
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jul 2021 03:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhG1B40 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jul 2021 21:56:26 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7752 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbhG1B40 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jul 2021 21:56:26 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GZGnw15ndzYhJP;
        Wed, 28 Jul 2021 09:50:28 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 09:56:23 +0800
Received: from huawei.com (10.175.104.170) by dggpemm500014.china.huawei.com
 (7.185.36.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Jul
 2021 09:56:23 +0800
From:   wuguanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>
CC:     <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>,
        <wuguanghao3@huawei.com>
Subject: [PATCH v3 00/12] e2fsprogs: some bugfixs
Date:   Wed, 28 Jul 2021 09:56:44 +0800
Message-ID: <20210728015648.284588-1-wuguanghao3@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wu Guanghao <wuguanghao3@huawei.com>

v2->v3
[PATCH v3 04/12]ss_add_info_dir: don't zap the info->info_dirs and check whether NULL pointer
[PATCH v3 05/12]ss_create_invocation: fix memory leak and check whether NULL pointer
[PATCH v3 10/12]hashmap: change return value type of ext2fs_hashmap_add()
[PATCH v3 11/12]misc/lsattr: check whether path is NULL in lsattr_dir_proc() 
modify according to Ted's suggestion.
Other patches have been applied and not sent

v1->v2
error correction

Zhiqiang Liu (6):
  argv_parse: check return value of malloc in argv_parse()
  misc: fix potential segmentation fault problem in scandir()
  lib/ss/error.c: check return value malloc in ss_name()
  hashmap: change return value type of ext2fs_hashmap_add()
  misc/lsattr: check whether path is NULL in lsattr_dir_proc()
  ext2ed: fix potential NULL pointer dereference in dupstr()

Wu Guanghao (6):
  append_pathname: check the value returned by realloc
  profile_create_node: set magic before strdup(name) to avoid memory
    leak
  tdb_transaction_recover: fix memory leak
  zap_sector: fix memory leak
  ss_add_info_dir: don't zap the info->info_dirs and check whether NULL pointer
  ss_create_invocation: fix memory leak and check whether NULL pointer

 contrib/android/base_fs.c | 14 +++++++++----
 contrib/fsstress.c        | 10 ++++++++--
 ext2ed/main.c             |  2 ++
 lib/ext2fs/fileio.c       | 11 ++++++++--
 lib/ext2fs/hashmap.c      | 12 +++++++++--
 lib/ext2fs/hashmap.h      |  5 +++--
 lib/ext2fs/tdb.c          |  1 +
 lib/ss/error.c            |  2 ++
 lib/ss/help.c             |  5 ++++-
 lib/ss/invocation.c       | 42 ++++++++++++++++++++++++++++++---------
 lib/support/argv_parse.c  |  2 ++
 lib/support/profile.c     |  3 ++-
 misc/create_inode.c       |  3 +++
 misc/lsattr.c             |  5 +++++
 misc/mke2fs.c             |  4 +++-
 15 files changed, 97 insertions(+), 24 deletions(-)

-- 
2.27.0

