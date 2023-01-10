Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204A366414E
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jan 2023 14:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbjAJNJz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Jan 2023 08:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238626AbjAJNJs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Jan 2023 08:09:48 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ED06147E
        for <linux-ext4@vger.kernel.org>; Tue, 10 Jan 2023 05:09:47 -0800 (PST)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Nrrdp0K7VzJq88;
        Tue, 10 Jan 2023 21:05:34 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500016.china.huawei.com
 (7.185.36.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 21:09:40 +0800
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>,
        <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH 0/2] fix extents need to be restored in some cases
Date:   Tue, 10 Jan 2023 21:34:05 +0800
Message-ID: <20230110133407.994711-1-zhanchengbin1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

According to the return value of the ext4 split extent at
function, it is distinguished whether to restore the split
extent. If the file consistency is not affected or mount
for `errors=continue`, we need to restore the len of the
split extent. 

zhanchengbin (2):
  ext4: fix inode tree inconsistency caused by ENOMEM in
    ext4_split_extent_at
  ext4: call ext4_handle_error when read extent failed in
    ext4_ext_insert_extent

 fs/ext4/extents.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.31.1

