Return-Path: <linux-ext4+bounces-11900-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DCFC695D3
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Nov 2025 13:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DBCD35968E
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Nov 2025 12:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4434EF1F;
	Tue, 18 Nov 2025 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="HWbiFK99"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0123546E7
	for <linux-ext4@vger.kernel.org>; Tue, 18 Nov 2025 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763468744; cv=none; b=PWwOPjerOMuB0odpNcPiVqGtG5SI0VJIjH65eS7HQqk78xikNAE4BZxVX6CyxVJe4nQRvB0ILtx/WZyWcAKtOaD0rgyMee8sXqgzHIFn/pkBQKpAvzt60Y6BPOJyQERUJvwqiiZRruklAl/BYbl1JEUxK4WyhVhV9+0P7/MlbrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763468744; c=relaxed/simple;
	bh=fHF1aSymA9i3gyQ1XZVYrvWiKdxR35apQqz8rUTfmmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEQNP/kp8KZIicNMYm1nEnKgNhptUQiOw1BRaeSAYGBBsz4SVpqPeHpw5zLzI4bcK/cUQq3GIYpqZ84AVYdm5ldxjAqePE5xDMCCX1TMVi4O9U1ZpldNsYL7vZxWexy7TYwqf84ITggkDceqsbwpmUqaKFe/MgccRBnl5IHhX80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=HWbiFK99; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OQF3Yh2d2sK5ydWBdVb1d2Lsn2S4MFb12ZrmYKUMzmQ=;
	b=HWbiFK9910JBQP5hZFB5QBu4zZB7txtU9vXZVEZ6NbQPAPS4Ys7HA6+OeZacHjngOSj0puMQq
	fgdE6Ycqr1hVPWWeMXwLVCjqgaBZ07JAL5gcW48sKhn7quX0lWwmttj6AIGHQE1lmh6k92jPQTW
	I7oKGSikRGAdKPVyhSznhrM=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4d9kLN12YVz1K96c;
	Tue, 18 Nov 2025 20:23:56 +0800 (CST)
Received: from kwepemj500016.china.huawei.com (unknown [7.202.194.46])
	by mail.maildlp.com (Postfix) with ESMTPS id B612F180042;
	Tue, 18 Nov 2025 20:25:37 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemj500016.china.huawei.com
 (7.202.194.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 18 Nov
 2025 20:25:37 +0800
From: Wu Guanghao <wuguanghao3@huawei.com>
To: <tytso@mit.edu>
CC: <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<yangyun50@huawei.com>, <wuguanghao3@huawei.com>
Subject: [PATCH 1/2] fsck: fix memory leak of inst->type
Date: Tue, 18 Nov 2025 21:26:00 +0800
Message-ID: <20251118132601.2756185-2-wuguanghao3@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20251118132601.2756185-1-wuguanghao3@huawei.com>
References: <20251118132601.2756185-1-wuguanghao3@huawei.com>
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


