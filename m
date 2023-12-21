Return-Path: <linux-ext4+bounces-535-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A8B81BA1C
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Dec 2023 16:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06861F23901
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Dec 2023 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89BA55E60;
	Thu, 21 Dec 2023 15:02:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A701955E4B;
	Thu, 21 Dec 2023 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SwttY6RLXzvSQw;
	Thu, 21 Dec 2023 23:01:41 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FFA118001D;
	Thu, 21 Dec 2023 23:02:37 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Dec
 2023 23:02:37 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<libaokun1@huawei.com>
Subject: [PATCH v2 0/8] ext4: fix divide error in mb_update_avg_fragment_size()
Date: Thu, 21 Dec 2023 23:05:50 +0800
Message-ID: <20231221150558.2740823-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)

V1->V2:
  Fixed some things pointed out by Jan Kara.
  Fixed more cases where blocks could be allocated from corrupted groups.

[V1]: https://lore.kernel.org/all/20231218141814.1477338-1-libaokun1@huawei.com/

Baokun Li (8):
  ext4: fix double-free of blocks due to wrong extents moved_len
  ext4: do not trim the group with corrupted block bitmap
  ext4: regenerate buddy after block freeing failed if under fc replay
  ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks()
  ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block
    bitmap corrupt
  ext4: avoid allocating blocks from corrupted group in
    ext4_mb_try_best_found()
  ext4: avoid allocating blocks from corrupted group in
    ext4_mb_find_by_goal()
  ext4: mark the group block bitmap as corrupted before reporting an
    error

 fs/ext4/mballoc.c     | 76 +++++++++++++++++++++++++++++--------------
 fs/ext4/move_extent.c |  6 ++--
 2 files changed, 53 insertions(+), 29 deletions(-)

-- 
2.31.1


