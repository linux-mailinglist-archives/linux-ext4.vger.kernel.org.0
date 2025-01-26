Return-Path: <linux-ext4+bounces-6239-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C857A1C6FC
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2025 09:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A229A1885ECC
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2025 08:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4BC14D6ED;
	Sun, 26 Jan 2025 08:27:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1613B280
	for <linux-ext4@vger.kernel.org>; Sun, 26 Jan 2025 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737880063; cv=none; b=rNcwLztd1BEhP9mETH6uytxgeh3k+gFEuYJl4gR12nm3M95kKlhovqabfRYoJMUFsparNWquDn/cXCEv/ViL2/FHW8nCeKNcypV6uUsVGTGBDnrcTH5O2wAIByzQpScUe6JyHiA8zWSFHFWuqkt3Xw2NgHYJ38ogTvJOoZxUf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737880063; c=relaxed/simple;
	bh=JoodbP4hqsI2d2ZASxabgob+wXN11kZ1giXTyUjDErQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UfBavOVvThz0oXhckZG4oC+dEaI7gY8g5gE7UMH4F9QsWqbJ0KfFD+ZE3ONqqSAIUVmbV/xph7H/uArP/unpSB0b+N3l8eexv+LR4Zq4VIcw/VdW+StiIdED5c43ejKUBzAs3VWOrqlK5qAw2y1SvXCg/oFUHC+nWHiP343w+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ygl4L5dDYzrSbX;
	Sun, 26 Jan 2025 16:25:54 +0800 (CST)
Received: from kwepemd200022.china.huawei.com (unknown [7.221.188.232])
	by mail.maildlp.com (Postfix) with ESMTPS id D0CA4180087;
	Sun, 26 Jan 2025 16:27:32 +0800 (CST)
Received: from huawei.com (10.175.101.107) by kwepemd200022.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 26 Jan
 2025 16:27:32 +0800
From: Ye Bin <yebin10@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
CC: <jack@suse.cz>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH 0/2] ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()
Date: Sun, 26 Jan 2025 16:27:29 +0800
Message-ID: <20250126082731.2037385-1-yebin10@huawei.com>
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
 kwepemd200022.china.huawei.com (7.221.188.232)

Ye Bin (2):
  ext4: introduce ITAIL helper
  ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()

 fs/ext4/xattr.c | 24 ++++++++++++++++--------
 fs/ext4/xattr.h |  3 +++
 2 files changed, 19 insertions(+), 8 deletions(-)

-- 
2.34.1


