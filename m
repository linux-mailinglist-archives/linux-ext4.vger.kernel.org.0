Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AF640759C
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Sep 2021 10:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbhIKIwO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 Sep 2021 04:52:14 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9030 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhIKIwO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 11 Sep 2021 04:52:14 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H65zJ5kSFzVnw6;
        Sat, 11 Sep 2021 16:50:04 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Sat, 11
 Sep 2021 16:50:59 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v2 0/6] Fix some issues about mmp
Date:   Sat, 11 Sep 2021 17:00:53 +0800
Message-ID: <20210911090059.1876456-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I test mmp function as follow steps:
1. Inject delay 5s in ext4_multi_mount_protect function after
"skip:" label.
2. Share HostA block device(sda) with HostB(nbd0) by NBD.
3. Enable mmp feature when mkfs.ext4 sda.
4. Mount sda and nbd0 at the same time.

I found kmmpd never trigger detect multi-mount. Reason is as follow:
1. Kmmpd init seq with 0, if two host have same nodename, will lead to
detect confliction very slow, even never detect confliction.
2. When detect confliction in kmmpd, we get 'check_bh' is same with 'bh'.
so we compare data with itself.
3. We only trigger detect when ”diff > mmp_check_interval * HZ“,
'mmp_check_interval' is double of 'mmp_update_interval', 'diff' is
about 'mmp_update_interval'. So 'diff' is little than 'mmp_check_interval * HZ'
normaly.

And i also found that 'check_interval' value store in disk  is not sure
after umount.

v1->v2:
Fix 'last_check_time' not initialized before checking.

Ye Bin (6):
  ext4: init seq with random value in kmmpd
  ext4: introduce last_check_time record previous check time
  ext4: compare to local seq and nodename when check conflict
  ext4: avoid to re-read mmp check data get from page cache
  ext4: avoid to double free s_mmp_bh
  ext4: fix possible store wrong check interval value in disk when
    umount

 fs/ext4/mmp.c | 77 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 34 deletions(-)

-- 
2.31.1

