Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE123D85BA
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jul 2021 03:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhG1B4i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jul 2021 21:56:38 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12272 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhG1B4e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jul 2021 21:56:34 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GZGp56DS0z1CPbN;
        Wed, 28 Jul 2021 09:50:37 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 09:56:25 +0800
Received: from huawei.com (10.175.104.170) by dggpemm500014.china.huawei.com
 (7.185.36.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Jul
 2021 09:56:24 +0800
From:   wuguanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>
CC:     <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>,
        <wuguanghao3@huawei.com>
Subject: [PATCH v3 11/12] misc/lsattr: check whether path is NULL in lsattr_dir_proc()
Date:   Wed, 28 Jul 2021 09:56:48 +0800
Message-ID: <20210728015648.284588-5-wuguanghao3@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210728015648.284588-1-wuguanghao3@huawei.com>
References: <20210728015648.284588-1-wuguanghao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhiqiang Liu <liuzhiqiang26@huawei.com>

In lsattr_dir_proc(), if malloc() return NULL, it will cause
a segmentation fault problem.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
---
 misc/lsattr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/misc/lsattr.c b/misc/lsattr.c
index 0d954376..7958f0ad 100644
--- a/misc/lsattr.c
+++ b/misc/lsattr.c
@@ -144,6 +144,11 @@ static int lsattr_dir_proc (const char * dir_name, struct dirent * de,
 	int dir_len = strlen(dir_name);
 
 	path = malloc(dir_len + strlen (de->d_name) + 2);
+	if (!path) {
+		fputs(_("Couldn't allocate path variable in lsattr_dir_proc"),
+			stderr);
+		return -1;
+	}
 
 	if (dir_len && dir_name[dir_len-1] == '/')
 		sprintf (path, "%s%s", dir_name, de->d_name);
-- 
2.27.0

