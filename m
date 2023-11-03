Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F877E0093
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Nov 2023 11:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjKCG6F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Nov 2023 02:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjKCG6F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Nov 2023 02:58:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698CEE3
        for <linux-ext4@vger.kernel.org>; Thu,  2 Nov 2023 23:58:02 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SMBM35HmFzrTjT;
        Fri,  3 Nov 2023 14:54:55 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 14:57:59 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <chengzhihao1@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 0/5] jbd2: Add errseq to detect writeback
Date:   Fri, 3 Nov 2023 22:52:45 +0800
Message-ID: <20231103145250.2995746-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

According to discussions in [1], this patchset adds errseq in journal to
enable JDB2 detecting meatadata writeback error of fs dev. Then, orginal
checking mechanism could be removed.

[1] https://lore.kernel.org/all/20230908124317.2955345-1-chengzhihao1@huawei.com/T/

Zhihao Cheng (5):
  jbd2: Add errseq to detect client fs's bdev writeback error
  jbd2: Replace journal state flag by checking errseq
  jbd2: Remove unused 'JBD2_CHECKPOINT_IO_ERROR' and 'j_atomic_flags'
  jbd2: Abort journal when detecting metadata writeback error of fs dev
  ext4: Move ext4_check_bdev_write_error() into nojournal mode

 fs/ext4/ext4_jbd2.c   |  5 ++---
 fs/jbd2/checkpoint.c  | 11 -----------
 fs/jbd2/journal.c     | 11 ++++++-----
 fs/jbd2/recovery.c    |  7 +------
 fs/jbd2/transaction.c | 14 ++++++++++++++
 include/linux/jbd2.h  | 37 ++++++++++++++++++++++++++-----------
 6 files changed, 49 insertions(+), 36 deletions(-)

-- 
2.39.2

