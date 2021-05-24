Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FB238E547
	for <lists+linux-ext4@lfdr.de>; Mon, 24 May 2021 13:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhEXLXM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 May 2021 07:23:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5536 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhEXLXL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 May 2021 07:23:11 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpZTm2r5YzkYyP
        for <linux-ext4@vger.kernel.org>; Mon, 24 May 2021 19:18:52 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:21:42 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:21:42 +0800
Subject: [PATCH 05/12] ss_create_invocation: fix memory leak and check whether
 NULL pointer
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
Message-ID: <cbfe3b47-6409-b302-1ed5-f7c666f88092@huawei.com>
Date:   Mon, 24 May 2021 19:21:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.184]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In ss_create_invocation(), it is necessary to check whether
returned by malloc is a null pointer.

Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 lib/ss/invocation.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/lib/ss/invocation.c b/lib/ss/invocation.c
index 457e7a2c..cfc180a5 100644
--- a/lib/ss/invocation.c
+++ b/lib/ss/invocation.c
@@ -29,26 +29,31 @@ int ss_create_invocation(const char *subsystem_name, const char *version_string,
 	register int sci_idx;
 	register ss_data *new_table;
 	register ss_data **table;
+	register ss_data **realloc_table;

 	*code_ptr = 0;
 	table = _ss_table;
 	new_table = (ss_data *) malloc(sizeof(ss_data));
+	if (new_table == NULL)
+		goto out;

 	if (table == (ss_data **) NULL) {
 		table = (ss_data **) malloc(2 * size);
+		if (table == NULL)
+			goto free_new_table;
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
+		goto free_table;
+
+	table = realloc_table;
+
 	table[sci_idx+1] = (ss_data *) NULL;
 	table[sci_idx] = new_table;

@@ -57,9 +62,15 @@ int ss_create_invocation(const char *subsystem_name, const char *version_string,
 	new_table->argv = (char **)NULL;
 	new_table->current_request = (char *)NULL;
 	new_table->info_dirs = (char **)malloc(sizeof(char *));
+	if (new_table->info_dirs == NULL)
+		goto free_table;
+
 	*new_table->info_dirs = (char *)NULL;
 	new_table->info_ptr = info_ptr;
 	new_table->prompt = malloc((unsigned)strlen(subsystem_name)+4);
+	if (new_table->prompt == NULL)
+		goto free_info_dirs;
+
 	strcpy(new_table->prompt, subsystem_name);
 	strcat(new_table->prompt, ":  ");
 #ifdef silly
@@ -71,6 +82,9 @@ int ss_create_invocation(const char *subsystem_name, const char *version_string,
 	new_table->flags.abbrevs_disabled = 0;
 	new_table->rqt_tables =
 		(ss_request_table **) calloc(2, sizeof(ss_request_table *));
+	if (new_table->rqt_tables == NULL)
+		goto free_prompt;
+
 	*(new_table->rqt_tables) = request_table_ptr;
 	*(new_table->rqt_tables+1) = (ss_request_table *) NULL;

@@ -85,6 +99,18 @@ int ss_create_invocation(const char *subsystem_name, const char *version_string,
 	ss_get_readline(sci_idx);
 #endif
 	return(sci_idx);
+
+free_prompt:
+	free(new_table->prompt);
+free_info_dirs:
+	free(new_table->info_dirs);
+free_table:
+	free(table);
+free_new_table:
+	free(new_table);
+out:
+	*code_ptr = ENOMEM;
+	return 0;
 }

 void
-- 
