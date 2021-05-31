Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1714D3953A6
	for <lists+linux-ext4@lfdr.de>; Mon, 31 May 2021 03:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhEaBZa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 May 2021 21:25:30 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2109 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhEaBZa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 May 2021 21:25:30 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FtcrZ4NmdzWqMN
        for <linux-ext4@vger.kernel.org>; Mon, 31 May 2021 09:19:10 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:23:50 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:23:49 +0800
From:   Wu Guanghao <wuguanghao3@huawei.com>
Subject: [PATCH V2 00/12] e2fsprogs: some bugfixs and some code cleanups
To:     <linux-ext4@vger.kernel.org>,
        =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
Message-ID: <00ad4a90-8a40-24c1-98d9-eb5f0da42436@huawei.com>
Date:   Mon, 31 May 2021 09:23:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.184]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

V1 -> V2:

[PATCH V2 03/12] zap_sector: fix memory leak
	free and return operators placed in {} block

[PATCH V2 04/12] ss_add_info_dir: fix memory leak and check whether,NULL pointer
	modified "=" to "=="

[PATCH V2 06/12] append_pathname: check the value returned by realloc to avoid segfault
[PATCH V2 07/12] argv_parse: check return value of malloc in argv_parse()
	Fix typos

[PATCH V2 10/12] hashmap: change return value type of, ext2fs_hashmap_add()
	remove "new_block = NULL;"

Zhiqiang Liu (6):
  misc: fix potential segmentation fault problem in scandir()
  lib/ss/error.c: check return value malloc in ss_name()
  hashmap: change return value type of ext2fs_hashmap_add()
  misc/lsattr: check whether path is NULL in lsattr_dir_proc()
  ext2ed: fix potential NULL pointer dereference in dupstr()
  argv_parse: check return value of malloc in argv_pars

Wu Guanghao (6):
  profile_create_node: set magic before strdup(name) to fix memory leak
  tdb_transaction_recover: fix memory leak
  zap_sector: fix memory leak
  ss_add_info_dir: fix memory leak and check whether NULL pointer
  ss_create_invocation: fix memory leak and check whether NULL pointer
  append_pathname: append_pathname: check the value returned by realloc
    to avoid segfault

 contrib/android/base_fs.c | 12 +++++++++---
 contrib/fsstress.c        | 10 ++++++++--
 ext2ed/main.c             |  2 ++
 lib/ext2fs/fileio.c       | 11 +++++++++--
 lib/ext2fs/hashmap.c      | 12 ++++++++++--
 lib/ext2fs/hashmap.h      |  4 ++--
 lib/ext2fs/tdb.c          |  1 +
 lib/ss/error.c            |  2 ++
 lib/ss/help.c             |  5 +++++
 lib/ss/invocation.c       | 38 ++++++++++++++++++++++++++++++++------
 lib/support/argv_parse.c  |  2 ++
 lib/support/profile.c     |  3 ++-
 misc/create_inode.c       |  3 +++
 misc/lsattr.c             |  6 ++++++
 misc/mke2fs.c             |  1 +
 15 files changed, 94 insertions(+), 18 deletions(-)

-- 
2.19.1

