Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989A75E8735
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Sep 2022 04:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiIXCBi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Sep 2022 22:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiIXCBa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Sep 2022 22:01:30 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855A59F18A;
        Fri, 23 Sep 2022 19:01:29 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MZByq2P2rzHpW8;
        Sat, 24 Sep 2022 09:59:15 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 24 Sep
 2022 10:01:27 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v2 0/2] ext4: factor out ext4_free_ext_path()
Date:   Sat, 24 Sep 2022 10:12:09 +0800
Message-ID: <20220924021211.3831551-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Diff v2 vs v1:
1. Add one patch to remove unnecessary drop path references in
mext_check_coverage().
2. Make 'ext4_ext_drop_refs()' static in fs/ext4/extents.c.
3. Export non-inline 'ext4_free_ext_path()' API.

Ye Bin (2):
  ext4: remove unnecessary drop path references in mext_check_coverage()
  ext4: factor out ext4_free_ext_path()

 fs/ext4/ext4.h           |   2 +-
 fs/ext4/extents.c        | 107 ++++++++++++++++-----------------------
 fs/ext4/extents_status.c |   3 +-
 fs/ext4/fast_commit.c    |   6 +--
 fs/ext4/migrate.c        |   3 +-
 fs/ext4/move_extent.c    |  10 ++--
 fs/ext4/verity.c         |   6 +--
 7 files changed, 54 insertions(+), 83 deletions(-)

-- 
2.31.1

