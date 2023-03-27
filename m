Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388016CA756
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Mar 2023 16:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjC0OSp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Mar 2023 10:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjC0OSU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Mar 2023 10:18:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031E361B2;
        Mon, 27 Mar 2023 07:16:48 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PlZbb2SmWzrW8Q;
        Mon, 27 Mar 2023 22:15:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 27 Mar
 2023 22:16:45 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 0/2] ext4: fix quotas leak in __ext4_fill_super()
Date:   Mon, 27 Mar 2023 22:16:28 +0800
Message-ID: <20230327141630.156875-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
	Add judgment for CONFIG_QUOTA to avoid warning
	"label 'failed_mount9' defined but not used".
	(Reported-by: kernel test robot <lkp@intel.com>)
V2->V3:
	By adding __maybe_unused to silence possible compilation
	complain in patch one, instead of adding the judgment.
	(Suggested by Jan Kara).

Baokun Li (2):
  ext4: turning quotas off if mount failed after enable quotas
  ext4: refactoring to use the unified helper ext4_quotas_off()

 fs/ext4/super.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

-- 
2.31.1

