Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4326D9834
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 15:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbjDFN3U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Apr 2023 09:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbjDFN3N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Apr 2023 09:29:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C651C659A;
        Thu,  6 Apr 2023 06:29:10 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Psj2K4PPhzKw8m;
        Thu,  6 Apr 2023 21:26:33 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Apr
 2023 21:29:03 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 0/2] ext4: fix WARNING in ext4_da_update_reserve_space
Date:   Thu, 6 Apr 2023 21:28:32 +0800
Message-ID: <20230406132834.1669710-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

V1->V2:
	Modify the patch 1 description and add the Fixes tag.
	Add the patch 2 as suggested by Jan Kara.

Baokun Li (2):
  ext4: only update i_reserved_data_blocks on successful block
    allocation
  ext4: use __GFP_NOFAIL if allocating extents_status cannot fail

 fs/ext4/extents_status.c | 36 +++++++++++++++++++++++++++++-------
 fs/ext4/indirect.c       |  8 ++++++++
 fs/ext4/inode.c          | 10 ----------
 3 files changed, 37 insertions(+), 17 deletions(-)

-- 
2.31.1

