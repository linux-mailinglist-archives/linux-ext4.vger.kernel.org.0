Return-Path: <linux-ext4+bounces-11950-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E338C7704B
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 03:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3486A4E4342
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 02:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85112155C97;
	Fri, 21 Nov 2025 02:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="HWbiFK99"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A31D63C2
	for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763692541; cv=none; b=Y7S1lNF/y0oL32JtxQCqVcsVEq9/O73gd0gvfeKzvyfIG/A+Y9c3/VDvP8tgXRTjlJb4dLKR+fxP1aplH2cHlv9aS8i+nKl7UkBmB430XPYRtRWt7NtR5HU8SaDB+Q8WHp57AmPvF/Dhfuoisbd3Hb/IKDVLMtexmtvOwhGgIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763692541; c=relaxed/simple;
	bh=fHF1aSymA9i3gyQ1XZVYrvWiKdxR35apQqz8rUTfmmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWLCnk1StWhBnM+qOo92lNh4dfVouJZZ7K5nfhr75uVR71TmdwesItr7vyrRB3KFKopg+s5sXANSg1OO5Kzew5o+MV7Aaxc7kSOIsgVMTIx0xFi6k4hrDFNmWKF5LICkbvu+RlIDGIRAyGK9+5NjUYYrY/CveRCFwUfORyq0RvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=HWbiFK99; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OQF3Yh2d2sK5ydWBdVb1d2Lsn2S4MFb12ZrmYKUMzmQ=;
	b=HWbiFK9910JBQP5hZFB5QBu4zZB7txtU9vXZVEZ6NbQPAPS4Ys7HA6+OeZacHjngOSj0puMQq
	fgdE6Ycqr1hVPWWeMXwLVCjqgaBZ07JAL5gcW48sKhn7quX0lWwmttj6AIGHQE1lmh6k92jPQTW
	I7oKGSikRGAdKPVyhSznhrM=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dCK664zxfzmV74;
	Fri, 21 Nov 2025 10:33:50 +0800 (CST)
Received: from kwepemj500016.china.huawei.com (unknown [7.202.194.46])
	by mail.maildlp.com (Postfix) with ESMTPS id A011B1A0188;
	Fri, 21 Nov 2025 10:35:35 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemj500016.china.huawei.com
 (7.202.194.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 21 Nov
 2025 10:35:35 +0800
From: Wu Guanghao <wuguanghao3@huawei.com>
To: <tytso@mit.edu>, <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>
CC: <djwong@kernel.org>, <yangyun50@huawei.com>, <wuguanghao3@huawei.com>
Subject: [PATCH v2 1/2] fsck: fix memory leak of inst->type
Date: Fri, 21 Nov 2025 11:36:11 +0800
Message-ID: <20251121033612.2423536-2-wuguanghao3@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20251121033612.2423536-1-wuguanghao3@huawei.com>
References: <20251121033612.2423536-1-wuguanghao3@huawei.com>
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

The function free_instance() does not release i->type, resulting in a
memory leak.

Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
---
 misc/fsck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc/fsck.c b/misc/fsck.c
index 64d0e7c0..a06f2668 100644
--- a/misc/fsck.c
+++ b/misc/fsck.c
@@ -235,6 +235,7 @@ static void parse_escape(char *word)
 static void free_instance(struct fsck_instance *i)
 {
 	free(i->prog);
+	free(i->type);
 	free(i->device);
 	free(i->base_device);
 	free(i);
-- 
2.27.0


