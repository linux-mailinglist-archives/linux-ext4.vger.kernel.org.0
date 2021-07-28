Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E574F3D85B8
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jul 2021 03:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhG1B41 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jul 2021 21:56:27 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12320 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhG1B41 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jul 2021 21:56:27 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GZGqK1szHz7yvL;
        Wed, 28 Jul 2021 09:51:41 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 09:56:24 +0800
Received: from huawei.com (10.175.104.170) by dggpemm500014.china.huawei.com
 (7.185.36.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Jul
 2021 09:56:23 +0800
From:   wuguanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>
CC:     <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>,
        <wuguanghao3@huawei.com>
Subject: [PATCH v3 05/12] ss_create_invocation: fix memory leak and check whether NULL pointer
Date:   Wed, 28 Jul 2021 09:56:46 +0800
Message-ID: <20210728015648.284588-3-wuguanghao3@huawei.com>
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

From: Wu Guanghao <wuguanghao3@huawei.com>

In ss_create_invocation(), it is necessary to check whether
returned by malloc is a null pointer.

Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 lib/ss/invocation.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/lib/ss/invocation.c b/lib/ss/invocation.c
index 457e7a2c..e458b785 100644
--- a/lib/ss/invocation.c
+++ b/lib/ss/invocation.c
@@ -26,29 +26,33 @@ int ss_create_invocation(const char *subsystem_name, const char *version_string,
 			 void *info_ptr, ss_request_table *request_table_ptr,
 			 int *code_ptr)
 {
-	register int sci_idx;
-	register ss_data *new_table;
-	register ss_data **table;
+	int sci_idx;
+	ss_data *new_table = NULL;
+	ss_data **table = NULL;
+	ss_data **realloc_table = NULL;
 
 	*code_ptr = 0;
 	table = _ss_table;
 	new_table = (ss_data *) malloc(sizeof(ss_data));
+	if (!new_table)
+		goto out;
 
 	if (table == (ss_data **) NULL) {
 		table = (ss_data **) malloc(2 * size);
+		if (!table)
+			goto out;
 		table[0] = table[1] = (ss_data *)NULL;
 	}
 	initialize_ss_error_table ();
 
 	for (sci_idx = 1; table[sci_idx] != (ss_data *)NULL; sci_idx++)
 		;
-	table = (ss_data **) realloc((char *)table,
+	realloc_table = (ss_data **) realloc((char *)table,
 				     ((unsigned)sci_idx+2)*size);
-	if (table == NULL) {
-		*code_ptr = ENOMEM;
-		free(new_table);
-		return 0;
-	}
+	if (realloc_table == NULL)
+		goto out;
+
+	table = realloc_table;
 	table[sci_idx+1] = (ss_data *) NULL;
 	table[sci_idx] = new_table;
 
@@ -57,9 +61,15 @@ int ss_create_invocation(const char *subsystem_name, const char *version_string,
 	new_table->argv = (char **)NULL;
 	new_table->current_request = (char *)NULL;
 	new_table->info_dirs = (char **)malloc(sizeof(char *));
+	if (!new_table->info_dirs)
+		goto out;
+
 	*new_table->info_dirs = (char *)NULL;
 	new_table->info_ptr = info_ptr;
 	new_table->prompt = malloc((unsigned)strlen(subsystem_name)+4);
+	if (!new_table->prompt)
+		goto out;
+
 	strcpy(new_table->prompt, subsystem_name);
 	strcat(new_table->prompt, ":  ");
 #ifdef silly
@@ -71,6 +81,9 @@ int ss_create_invocation(const char *subsystem_name, const char *version_string,
 	new_table->flags.abbrevs_disabled = 0;
 	new_table->rqt_tables =
 		(ss_request_table **) calloc(2, sizeof(ss_request_table *));
+	if (!new_table->rqt_tables)
+		goto out;
+
 	*(new_table->rqt_tables) = request_table_ptr;
 	*(new_table->rqt_tables+1) = (ss_request_table *) NULL;
 
@@ -85,6 +98,17 @@ int ss_create_invocation(const char *subsystem_name, const char *version_string,
 	ss_get_readline(sci_idx);
 #endif
 	return(sci_idx);
+
+out:
+	if (new_table) {
+		free(new_table->prompt);
+		free(new_table->info_dirs);
+	}
+	free(new_table);
+	free(table);
+	*code_ptr = ENOMEM;
+	return 0;
+
 }
 
 void
-- 
2.27.0

