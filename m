Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A3238D510
	for <lists+linux-ext4@lfdr.de>; Sat, 22 May 2021 12:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhEVKWk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 May 2021 06:22:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3634 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhEVKWk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 22 May 2021 06:22:40 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FnKD52LSXzQqwS;
        Sat, 22 May 2021 18:17:41 +0800 (CST)
Received: from dggeme752-chm.china.huawei.com (10.3.19.98) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 18:21:14 +0800
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 22
 May 2021 18:21:13 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 0/2] ext4: fix two minor mistakes in ext4_es_scan()
Date:   Sat, 22 May 2021 18:30:43 +0800
Message-ID: <20210522103045.690103-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix two minor mistakes introduced by 1ab6c4997e04 ("fs: convert fs
shrinkers to new scan/count API") in  ext4_es_scan().

Zhang Yi (2):
  ext4: remove check for zero nr_to_scan in ext4_es_scan()
  ext4: correct the cache_nr in tracepoint ext4_es_shrink_exit

 fs/ext4/extents_status.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.25.4

