Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700DC4671DA
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Dec 2021 07:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378577AbhLCG2J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Dec 2021 01:28:09 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29149 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378573AbhLCG2I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Dec 2021 01:28:08 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J52my6JZ6zXdVv;
        Fri,  3 Dec 2021 14:22:42 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:24:43 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:24:42 +0800
Message-ID: <37c58382-9714-7e99-6c4d-01b78cfdbd26@huawei.com>
Date:   Fri, 3 Dec 2021 14:24:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH 0/6] solve memory leak and check whether NULL pointer
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500001.china.huawei.com (7.185.36.227) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Solve the memory leak of the abnormal branch and the new null pointer check

zhanchengbin (6):
   e2fsck: set s->len=0 if malloc() fails in alloc_string()
   lib/ss: check whether argp is null before accessing it in
     ss_execute_command()
   lib/support: check whether inump is null before accessing it in
     quota_set_sb_inum()
   e2fsprogs: call ext2fs_badblocks_list_free() to free list in exception
     branch
   e2fsck: check whether ldesc is null before accessing it in
     end_problem_latch()
   lib/ext2fs: call ext2fs_free_mem() to free &io->name in exception
     branch

  e2fsck/logfile.c      | 2 ++
  e2fsck/problem.c      | 2 ++
  lib/ext2fs/test_io.c  | 2 ++
  lib/ext2fs/undo_io.c  | 2 ++
  lib/ss/execute_cmd.c  | 2 ++
  lib/support/mkquota.c | 3 ++-
  misc/dumpe2fs.c       | 1 +
  resize/resize2fs.c    | 4 ++--
  8 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.23.0
