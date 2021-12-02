Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C302946624B
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Dec 2021 12:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbhLBL3u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Dec 2021 06:29:50 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29081 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357141AbhLBL3u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Dec 2021 06:29:50 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J4YVl6Bysz1DJn6;
        Thu,  2 Dec 2021 19:23:43 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 19:26:26 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 19:26:26 +0800
Message-ID: <c96e1895-1b89-cdac-0239-a84b8a3ffc3e@huawei.com>
Date:   Thu, 2 Dec 2021 19:26:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH 0/6] solve memory leak and check whether NULL pointer
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500005.china.huawei.com (7.185.36.59) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Solve the memory leak of the abnormal branch and the new null pointer check

zhanchengbin (6):
   alloc_string : String structure consistency
   ss_execute_command : Check whether the pointer is not null before it
     is referenced.
   quota_set_sb_inum : Check whether the pointer is not null  before it
     is referenced.
   badblock_list memory leak
   ldesc Non-empty judgment
   io->name memory leak

  e2fsck/logfile.c      |  2 ++
  e2fsck/problem.c      |  2 ++
  lib/ext2fs/test_io.c  |  2 ++
  lib/ext2fs/undo_io.c  |  2 ++
  lib/ss/execute_cmd.c  |  2 ++
  lib/support/mkquota.c |  3 ++-
  misc/dumpe2fs.c       |  1 +
  resize/resize2fs.c    | 10 ++++++----
  8 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.23.0

