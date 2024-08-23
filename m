Return-Path: <linux-ext4+bounces-3876-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0349E95C52A
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 08:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D0E28449F
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 06:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A2C6F30C;
	Fri, 23 Aug 2024 06:10:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345D8493
	for <linux-ext4@vger.kernel.org>; Fri, 23 Aug 2024 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724393449; cv=none; b=YlbO6QhUHfROk2MUeGwSbY9CErKktteQhABQiEtVwGEwtCM3Jr2r5QnStsOcY0DzRTdFb0mWLTGOzoQWM9PAySchQ1LwnKbYuaRU8d+UJf/soDUEqifPi7SiIq4hngKB4VeLLpUwN+JGeA6y1Y5jrvXC4apOYRR/quaSj05tnAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724393449; c=relaxed/simple;
	bh=gTXdK1SKoTUq7UrtoYjL/qVjAnTem6g25NZjwDQjVZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PuEO//gMeG7UjCo76L2rmsYAacWnN93EDHZ3oub8zcW33TL1hfX4Mi4PNzFXKoBQA40wB/VyXSgykWm+HcjwYNgyRUTc5pI6t5LVC1RHuiw44GTgYGB2muuDwTRQmFI2jkk/YG/iI/IdDXIHWxBKftzoy/QLFLkgrPeudH6/rTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WqqLv0kcxz20mNl;
	Fri, 23 Aug 2024 14:05:59 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id B63EE1A0188;
	Fri, 23 Aug 2024 14:10:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 23 Aug
 2024 14:10:42 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <lizetao1@huawei.com>, <linux-ext4@vger.kernel.org>
Subject: [PATCH -next 0/3] ext4: Using scope-based resource management function
Date: Fri, 23 Aug 2024 14:18:21 +0800
Message-ID: <20240823061824.3323522-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi all,

This patch set is dedicated to using scope-based resource management
functions to replace the direct use of lock/unlock methods, so that
developers can focus more on using resources in a certain scope and
avoid overly focusing on resource leakage issues.

At the same time, some functions can remove the controversial goto
label(eg: patch 3), which usually only releases resources and then
exits the function. After replacement, these functions can exit
directly without worrying about resources not being released.

This patch set has been tested by fsstress for a long time and no
problems were found.

Thanks,
Li Zetao.

Li Zetao (3):
  ext4: Use scoped()/scoped_guard() to drop read_lock()/unlock pair
  ext4: Use scoped()/scoped_guard() to drop write_lock()/unlock pair
  ext4: Use scoped()/scoped_guard() to drop rcu_read_lock()/unlock pair

 fs/ext4/block_validity.c |  27 +++--
 fs/ext4/ext4.h           |   3 +-
 fs/ext4/extents_status.c |  67 +++++--------
 fs/ext4/fast_commit.c    |   3 +-
 fs/ext4/inode.c          |  14 ++-
 fs/ext4/mballoc.c        | 208 +++++++++++++++++----------------------
 fs/ext4/resize.c         |  20 ++--
 fs/ext4/super.c          |  29 +++---
 8 files changed, 158 insertions(+), 213 deletions(-)

-- 
2.34.1


