Return-Path: <linux-ext4+bounces-922-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 050CF83D637
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 10:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C652B284AB
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE60F200D2;
	Fri, 26 Jan 2024 08:54:51 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B020B14;
	Fri, 26 Jan 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259291; cv=none; b=oY3wRH+X76uazoxb3UpUfrCvd1zhghGd1d8DJP5WrImR/QKnXOxOI/GxEH4cJU72u4TRcdSD0JUkuHxIK5QOO/ru5DbXn1on3XXwjDubX9qlJYchRxE4YoIaylaVTkaM/lNbjSa3s+2jja03eqcSCSMb7Ui0k4VZ8BDRqu/b3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259291; c=relaxed/simple;
	bh=UaRre/FakXrgK4o/iIKNgZyz3bmMRWSu1KsXcDAgIaE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tzDInq0VQ3QtObFNMB57funLCEPIaL/rhLXtARaaWWYbdioeov2zdR2Er1wcKqrP4vj64ULbrlyVGgHlIxdNcZe5GZfLVFvt3jOcguiZninFXK4GJbiL0mxZmbiLnPczoQ5BhAEEZi83n6VV74r7t0vKA0A7cJq+RoZCrFZ11E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TLs0l2mzczvTs9;
	Fri, 26 Jan 2024 16:53:11 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id ABC541404FC;
	Fri, 26 Jan 2024 16:54:45 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 16:54:45 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
	<yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH 0/7] ext4: avoid sysfs variables overflow causing BUG_ON/SOOB
Date: Fri, 26 Jan 2024 16:57:09 +0800
Message-ID: <20240126085716.1363019-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

Hello everyone,

This patchset is intended to avoid variables that can be modified via sysfs
from overflowing when stored or used and thus causing various problems.

"kvm-xfstests -c ext4/all -g auto" has been executed with no new failures.

Baokun Li (7):
  ext4: avoid overflow when setting values via sysfs
  ext4: refactor out ext4_generic_attr_store()
  ext4: refactor out ext4_generic_attr_show()
  ext4: add positive int attr pointer to avoid sysfs variables overflow
  ext4: fix slab-out-of-bounds in
    ext4_mb_find_good_group_avg_frag_lists()
  ext4: set type of ac_groups_linear_remaining to __u32 to avoid
    overflow
  ext4: set the type of max_zeroout to unsigned int to avoid overflow

 fs/ext4/extents.c |   6 +-
 fs/ext4/mballoc.c |   2 +
 fs/ext4/mballoc.h |   2 +-
 fs/ext4/sysfs.c   | 159 +++++++++++++++++++++++++---------------------
 4 files changed, 92 insertions(+), 77 deletions(-)

-- 
2.31.1


