Return-Path: <linux-ext4+bounces-1911-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF1289AEED
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Apr 2024 08:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723091C211CF
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Apr 2024 06:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8539479D1;
	Sun,  7 Apr 2024 06:53:11 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4717F0;
	Sun,  7 Apr 2024 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712472791; cv=none; b=JbOaj4+SV1L+jCATAiF2wOvWtI1XdTr6WIqQgWuzcu3epm7f32V23g1MJZCl3YTWdmZAOP9CRGYoDfmCGqpUu6qTTDxYI5ZLrSEREUFrm3IjRiPZXyXJvfQs9z9UwE5seux1g0m/tYQ6ETsuARGJa4H6an+EZQNMv7+qNKqy9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712472791; c=relaxed/simple;
	bh=zAKlqvfCE8R3p00bPeYf8mqIoGTqjy1oUQQpuXc7KmM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZeG1lKzfy/xjj6mqwPefbvMM7DBM6kTxBjvf60IGoxlv3zpJPVEyIi1n4mGgtPlLVCv6O12sCLb5+z1sBM8E+/y5Cry81bptUQxdVxILCA1irba0nJtdlqRj11Y6xOchQlE8Ppvgv4e579W6CovhJxddhTy+TIjxnebc2iFxlwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VC2sh741Sz29dNd;
	Sun,  7 Apr 2024 14:50:16 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 1573514011F;
	Sun,  7 Apr 2024 14:53:06 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 7 Apr
 2024 14:53:05 +0800
From: Ye Bin <yebin10@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <jack@suse.cz>, Ye Bin
	<yebin10@huawei.com>
Subject: [PATCH v2 0/2] jbd2: use shrink_type type instead of bool type for __jbd2_journal_clean_checkpoint_list()
Date: Sun, 7 Apr 2024 14:53:53 +0800
Message-ID: <20240407065355.1528580-1-yebin10@huawei.com>
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
 canpemm500010.china.huawei.com (7.192.105.118)

Diff v2 vs v1:
1. Update/add comment for __jbd2_journal_clean_checkpoint_list();
2. Add 'jbd2' prefix for 'shrink_type';

Ye Bin (2):
  jbd2: use shrink_type type instead of bool type for
    __jbd2_journal_clean_checkpoint_list()
  jbd2: add prefix 'jbd2' for 'shrink_type'

 fs/jbd2/checkpoint.c | 24 +++++++++++++-----------
 fs/jbd2/commit.c     |  2 +-
 include/linux/jbd2.h |  4 +++-
 3 files changed, 17 insertions(+), 13 deletions(-)

-- 
2.31.1


