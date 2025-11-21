Return-Path: <linux-ext4+bounces-11951-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0915C7704E
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 03:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9957A4E5EC6
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 02:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C01D272E45;
	Fri, 21 Nov 2025 02:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="b/eN8AKR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689E1EB193
	for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763692541; cv=none; b=o3l5z2SHeoXprbAzc7fUgUfD/CsA524D5orTi5NEORWCWFIkwA4LeP/EdtApJIbBflZJrUYiCI2XDP3J6IPno5xeuUcSDSe3g0G7LkEPPqO9eB1j7ixulwSJEg0TcVh7Ych4P21qyvi2APGuf2RFlPQtwSFyrB9ypodOsiemRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763692541; c=relaxed/simple;
	bh=iuqwo3kdi3emCu+Wrx+Im/LOkcAPRQXp1Pphk0DGxCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxG43CRCQHF2RyZxJli9VOtykmWK8csH8cbIC7iNuhBCt3D5wQ1dEqBV9MeXjpRirXPrzNzJLyA0RuN6xsqOgOtcCt0turIs8BtaZR551H5AdPrUiGdXS+Yfe3wd7NJIRGXe1lmJnDtbL6l2+A7oqh/mXttxIhm9+5dWzpxHtbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=b/eN8AKR; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=j19vx44/yFeETey3N3uI40Udov5VtmhISZc2l43CWVI=;
	b=b/eN8AKR/AHRBwnxLxq+b5Yo0JN1Zr7ChsGeLLl0M0kFgXrvRqNJmUuIqobBz2Nrc2ncUyYsW
	Fiadmj/93bs3gluoeaOXMifUKbtA588p99zFaisQG3j3CjHoUBjQOHVtyw4XESIDSA8YYU0t93w
	9qbl57SFOxKyI7uiHtZEytA=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dCK5l16YHzcb0p;
	Fri, 21 Nov 2025 10:33:31 +0800 (CST)
Received: from kwepemj500016.china.huawei.com (unknown [7.202.194.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A370180480;
	Fri, 21 Nov 2025 10:35:36 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemj500016.china.huawei.com
 (7.202.194.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 21 Nov
 2025 10:35:35 +0800
From: Wu Guanghao <wuguanghao3@huawei.com>
To: <tytso@mit.edu>, <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>
CC: <djwong@kernel.org>, <yangyun50@huawei.com>, <wuguanghao3@huawei.com>
Subject: [PATCH v2 2/2] resize: fix memory leak when exiting normally
Date: Fri, 21 Nov 2025 11:36:12 +0800
Message-ID: <20251121033612.2423536-3-wuguanghao3@huawei.com>
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

The main() function only releases fs when it exits through the errout or
success_exit labels. When completes normally, it does not release fs.

Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
---
 resize/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/resize/main.c b/resize/main.c
index 08a4bbaf..e7940307 100644
--- a/resize/main.c
+++ b/resize/main.c
@@ -702,6 +702,14 @@ int main (int argc, char ** argv)
 	}
 	if (fd > 0)
 		close(fd);
+
+	retval = ext2fs_close_free(&fs);
+	if (retval) {
+		com_err(program_name, retval,
+			_("ext2fs_close"));
+		exit(1);
+	}
+
 	remove_error_table(&et_ext2_error_table);
 	return 0;
 errout:
-- 
2.27.0


