Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA756BA4B1
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 02:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCOBcx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 21:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCOBcv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 21:32:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D359E1F5EB;
        Tue, 14 Mar 2023 18:32:17 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pbt9m5msqzHwwG;
        Wed, 15 Mar 2023 09:30:04 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 15 Mar
 2023 09:32:14 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <tudor.ambarus@linaro.org>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 0/6] ext4: Fix stale buffer loading from last failed
Date:   Wed, 15 Mar 2023 09:31:22 +0800
Message-ID: <20230315013128.3911115-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Patch 1 fixes reusing stale buffer heads from last failed mounting.
Patch 2~4 reconstructs 'j_format_version' initialization and checking
in loading process.

v1->v2:
  Adopt suggestions from Tudor, add fix tag and corrupt 'stable' field
  in patch 1.
  Reserve empty lines in patch 4.
v2->v3:
  Split block device checking cleanup into a new patch (2th).
  Add 'Reviewed-by' tag in patch 3-6.


Zhang Yi (4):
  jbd2: remove unused feature macros
  jbd2: switch to check format version in superblock directly
  jbd2: factor out journal initialization from journal_get_superblock()
  jbd2: remove j_format_version

Zhihao Cheng (2):
  ext4: Fix reusing stale buffer heads from last failed mounting
  ext4: ext4_put_super: Remove redundant checking for
    'sbi->s_journal_bdev'

 fs/ext4/super.c      | 15 +++++++------
 fs/jbd2/journal.c    | 53 +++++++++++++++++---------------------------
 include/linux/jbd2.h | 33 ++++++++++++---------------
 3 files changed, 42 insertions(+), 59 deletions(-)

-- 
2.31.1

