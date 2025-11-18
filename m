Return-Path: <linux-ext4+bounces-11898-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B46C695CD
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Nov 2025 13:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0CC3E34F67A
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Nov 2025 12:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464BD354AD5;
	Tue, 18 Nov 2025 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="XGHNfAeQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC5A351FA9
	for <linux-ext4@vger.kernel.org>; Tue, 18 Nov 2025 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763468743; cv=none; b=spcrPALsk2S3S1KWbztJSqHPCfe78kr3YRA6nBotvFDqNj/a1dRx5L1jPHlLKDk4ppfmsAd8xNR3dGwhjz3BnSt28MB3jcxzamUPsDxHPzgIBX3iIc1Qk7O58WytFpiP/5msAgRG7giT9rE3KOWH1hrMk7WPrX7TMS+wnaaOnLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763468743; c=relaxed/simple;
	bh=ZaNLiTh/GqsdJCFK6eu3efrblz4AY3DcPgu0ep22LVM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HhZVc6iqfmaoEQj4zFBRYFLHbwSLj/U+5MUC0NdF2UB8nY6AVojsDjQ3umo+s0J0l0+AcIHVPtEs+DLFHApR9gB7qKfZZKzKiG3OOH3LxHY8GfpviO7fpFskR8SAVbFQ38kakPcdNgMc43rsce7Wqm1CZB6TjfzWY27mGeN5o3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=XGHNfAeQ; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+r50mf+UUNhdQKSspCg5wup43q6API+ISZhPTaskJNc=;
	b=XGHNfAeQ63FJFKoTVHjFjkWgdXw6da4jtG/En1AKYRXjN19sxZrqdVnUddycG+k92bcsbg3ly
	GbSlKNWZi2aVcpVTgVDUlkqSe711EHGRhIQRFtqx/hiu9egMWAoLltgPINU9917er3cgP6pdpID
	cbEChM+5zr1/mYx9sWjdTr4=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d9kKz72CLzcZyZ;
	Tue, 18 Nov 2025 20:23:35 +0800 (CST)
Received: from kwepemj500016.china.huawei.com (unknown [7.202.194.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 9347F14027A;
	Tue, 18 Nov 2025 20:25:36 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemj500016.china.huawei.com
 (7.202.194.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 18 Nov
 2025 20:25:35 +0800
From: Wu Guanghao <wuguanghao3@huawei.com>
To: <tytso@mit.edu>
CC: <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<yangyun50@huawei.com>, <wuguanghao3@huawei.com>
Subject: [PATCH 0/2] e2fsprogs: fix memory leaks detected by ASAN
Date: Tue, 18 Nov 2025 21:25:59 +0800
Message-ID: <20251118132601.2756185-1-wuguanghao3@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj500016.china.huawei.com (7.202.194.46)

Wu Guanghao (2):
  fsck: fix memory leak of inst->type
  resize: fix memory leak when exiting normally

 misc/fsck.c   | 1 +
 resize/main.c | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.27.0


