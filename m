Return-Path: <linux-ext4+bounces-11949-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E9C77048
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 03:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 08B8B24077
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 02:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA72A229B18;
	Fri, 21 Nov 2025 02:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="rGpv6LuY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B67155C97
	for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763692540; cv=none; b=AlQLdfgSKtMnM9oaz5/G/XEsZXTaOUZEYMq7K4QS1cPYONIteFsRwJFX8d7W7lpfx+ezGFUGuR+c8gRa3rmPs88ce22P4QXkHaVm6ajapCBGKQ/V3DEV2YQQhSoUGoMxQ6QPXDg3BN/fvRc/RciZuVPTKZASQp6009x/8qDGQ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763692540; c=relaxed/simple;
	bh=AaIfULk/PS0hv0JNSwGQ4kO6oh+UwxTPTt0qdu28yx0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tj9Equ6w0RPtAbExLztA8U5qUNTiQyx654JKkQU+U+NO7VATtBMU0rl1DDKyrM9F3aZd3ul7+hjQ0+my2dzWxxkWwkPaSxsoPvznOeFHioLD3wBbfm3oQQYPxomSea51G8wBXn5GtfdeIFKIAmXKOCvK4sRBGas3FfVk+nZ/BTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=rGpv6LuY; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iPt+lRDwC6MkJQekuUfl+v3MehRrTah6ld4wo4sKJg0=;
	b=rGpv6LuY41hY8dZ32nis1FfjzWH1C3D5PlU9ufYWxomL+gbhc4MmlIsDXcCm4mkTIYT/XZF9Y
	YYHWy4vqKRx/P+4YVx3srU1ifZOmC8U9AlFNq5VsQw4GN4zcVKWj5BX38anpEU4UkR9pDVcG0PI
	Mj0kUfSBUFsD07xkQA1AHk4=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dCK654p3pz1cyQG;
	Fri, 21 Nov 2025 10:33:49 +0800 (CST)
Received: from kwepemj500016.china.huawei.com (unknown [7.202.194.46])
	by mail.maildlp.com (Postfix) with ESMTPS id B8A6E1A016C;
	Fri, 21 Nov 2025 10:35:34 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemj500016.china.huawei.com
 (7.202.194.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 21 Nov
 2025 10:35:34 +0800
From: Wu Guanghao <wuguanghao3@huawei.com>
To: <tytso@mit.edu>, <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>
CC: <djwong@kernel.org>, <yangyun50@huawei.com>, <wuguanghao3@huawei.com>
Subject: [PATCH v2 0/2] e2fsprogs: fix memory leaks detected by ASAN
Date: Fri, 21 Nov 2025 11:36:10 +0800
Message-ID: <20251121033612.2423536-1-wuguanghao3@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj500016.china.huawei.com (7.202.194.46)

v1 -> v2:
 - Check the return value of ext2fs_close_free()

Wu Guanghao (2):
  fsck: fix memory leak of inst->type
  resize: fix memory leak when exiting normally

 misc/fsck.c   | 1 +
 resize/main.c | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.27.0


