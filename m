Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244266259C2
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Nov 2022 12:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiKKLtM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Nov 2022 06:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiKKLtG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Nov 2022 06:49:06 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A63C27910
        for <linux-ext4@vger.kernel.org>; Fri, 11 Nov 2022 03:49:05 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7xmv4nKQzmV6p;
        Fri, 11 Nov 2022 19:48:47 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 19:49:03 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 19:49:02 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <snitzer@kernel.org>, <Martin.Wilck@suse.com>, <ejt@redhat.com>,
        <jack@suse.cz>, <tytso@mit.edu>, <yi.zhang@huawei.com>,
        <chengzhihao1@huawei.com>
CC:     <dm-devel@redhat.com>, <linux-ext4@vger.kernel.org>
Subject: [dm-devel] [PATCH 0/3] dm thin: Fix ABBA deadlock between shrink_slab and dm_pool_abort_metadata
Date:   Fri, 11 Nov 2022 20:10:26 +0800
Message-ID: <20221111121029.3985561-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Zhihao Cheng (3):
  dm bufio: Fix missing decrement of no_sleep_enabled if
    dm_bufio_client_create failed
  dm bufio: Split main logic out of dm_bufio_client creation/destroy
  dm thin: Fix ABBA deadlock between shrink_slab and
    dm_pool_abort_metadata

 drivers/md/dm-bufio.c                         | 189 +++++++++++++-----
 drivers/md/dm-thin-metadata.c                 |  36 +++-
 drivers/md/persistent-data/dm-block-manager.c |  21 ++
 drivers/md/persistent-data/dm-block-manager.h |   4 +
 include/linux/dm-bufio.h                      |  14 +-
 5 files changed, 214 insertions(+), 50 deletions(-)

-- 
2.31.1

