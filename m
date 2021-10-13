Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7546942B390
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Oct 2021 05:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbhJMDbJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Oct 2021 23:31:09 -0400
Received: from mail-eopbgr1300092.outbound.protection.outlook.com ([40.107.130.92]:38720
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237640AbhJMDbC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 12 Oct 2021 23:31:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jURnHz1XU82+ByJTY772iUvxzDaEG+Llfgx0T5AMSWWA8UIWrvssDvmc0/RRtuC1dKnQl0c9IxLtB7IXzeQgTcBEK60YX5FzIFtSGFAg8aOcRJYX0u7mVg48zm9QtFT8uL5le5cFJpHtro8ts5GDbiukVj7kYdKdRIyv9urpPzq2RJR7W0Mfsuv2qF95WRTEplD63goI8fui/5oi40b5XyMOk3/w9pmx6sLOUi93Se7TLVYbmMc3E+kzI66TYmvUJBIiiQT/U5ao1Jq9b8VhrtiVKZApyjV8XsBMuTmf3HPC1ogEbKUOZ4NvXxrO71ZbtH0BcGTvltYkOE5V+19q9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZL2NhNS1E+BsCLaQ4i6Ql1gFAysxIMHF5fTTmSB1Lu8=;
 b=MqcuP6GMQGMUs1g755gQLateW+JMAOVPB40Lb0mt5fixvlFP5J9eKHXKpKFwjLyt/C3gwfZU7x4nXbWeMlwwewTQZCpAEzzwx5ImPCQDi7IDRVAlfj1DIll/vM8clWQz79+kYkrOYfLtxofHA4mparUnweWrOEi/bbZwxR47m62uX2FXwYEqwW3SewKyOWSgwWcz2bnr3t/1e8UgXDoPBJ/p+YtGHT43r6H8to1fN2KxGFrgiZKgxicIM2f68aBECrcqimzON7xcUiZnnzII3/YgSQOzzYcme3JMEc3+/X/VHXahFUg1AkMrqDzG/2AcIHqEKVkMfcF0D3U/P7Fi1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZL2NhNS1E+BsCLaQ4i6Ql1gFAysxIMHF5fTTmSB1Lu8=;
 b=LH3SNwmdHmIP3A3iHWkxfyHwGyF2c5cv6dHQVSmLKIxX+/49U2geKK916y7vNdZY5L9OGUSlAGbV48cnt8740syWUufy3ClLl6OJa+f1GP44xxCVPpz1AS3UFnjcOf1CPGifyO94Di+H0VU2gyjzCHYZI3jG7uXJrb7n7QU9+zo=
Authentication-Results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB2955.apcprd06.prod.outlook.com (2603:1096:100:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 03:28:58 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.024; Wed, 13 Oct 2021
 03:28:58 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] ext4: replace snprintf in show functions with sysfs_emit
Date:   Tue, 12 Oct 2021 20:28:51 -0700
Message-Id: <1634095731-4528-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0015.apcprd04.prod.outlook.com
 (2603:1096:202:2::25) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR0401CA0015.apcprd04.prod.outlook.com (2603:1096:202:2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 03:28:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 436aabe1-402f-446f-432e-08d98df997a8
X-MS-TrafficTypeDiagnostic: SL2PR06MB2955:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB295518A18EB2DAF7449A32F9BDB79@SL2PR06MB2955.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:178;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2KnVJOa+9nmGAGmZp07f1gnA0v5Q9A2IpXqO9rzm0txXLrAsJ2TkiY6hEcMTkI456p7iuK2DQdHF4n1jkiXZedVbvR3fTI8SIcPZDu8ItRqe1/CUZjlzIN8yteY3LY9cQisxS/GyJ3/Q7pbqCTOwMCbY4s42510mDbwSmzjjP5DJyrwwW1w2QbOk6uXM3BbTxBCXZPUcJpg5MBEku5f6VqLtf1N6PCcM7HjaD3ElJ0QpJFvalVXR96Pl6+Vx7FUJehdsdiUce4YTpbpANXW74un2QrHba45g2iC6XrWnAE+EaoZVY3Pr8PatM4CbT8ZegwrdIdvs5DRHyuZyJb540AiefuJga2wjtLO3cwf5qQUITVUDdJgb7NaQh3tQlqcuI0YBU0GSc0ZTr2uun0OYtTJvFrGQauqVUBtIiSRkxKWyi0AejfKZfunyaKUnreAIQ3BEdmCevMGNCCFgnURQdV/vRqAmJk4zOyYcrZLU0IHLXV2juZPJ8Hd7Yj1p3pe6zPQwrydDdz84rEc3QYMwK2cDHkFUb4m3dzMgkPhuHjbqtkikoYEOvLjHafje54CTAoPkywKb/Q3oQeoOZ456HGM82i+umGXKt8LwaBCPnrqkXz8d/vixiMLO3DCdWIhEcBMvuzHJY5vDVvEnQeRwzT7fmlxa57GAACOCBHoZJSEHscGAqtCTMFtjd49l1uCHroE2vkq44bYqVvfx4l5lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(508600001)(186003)(6666004)(107886003)(66476007)(66556008)(8936002)(66946007)(110136005)(26005)(2906002)(6486002)(2616005)(36756003)(83380400001)(4326008)(52116002)(6512007)(6506007)(86362001)(8676002)(316002)(38350700002)(5660300002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3n5lj139VYls+o6EVTyIgr0RaASrgwIm5yRpJfbK5ZMzvF95yqsK8Bjhfmfz?=
 =?us-ascii?Q?MAbY/fRtfwBP9g9UIies9fJAt5mBiEeH+2cL/5DL+DCEo+SF/QXqvjaN2bes?=
 =?us-ascii?Q?o3RbPA30+KGb9cRxwTOsuIlK7RKfAg9qXW5y78KQBr7lc0GJlZYF92yI12qO?=
 =?us-ascii?Q?JBOjPsVa4m0pcoJT5veLV2fH+lsdmqYxKzT8Doc9lfQ2FkVE9bcqq4AxEaE3?=
 =?us-ascii?Q?LmPiqVND56WIOhljs6aZ1a3ZZg6xI0JEO+REIfd4BUhLj3QQb77yaLF+jNvy?=
 =?us-ascii?Q?Uai4XeijbRVuvrQMgVFtyaVK9MAtp8lFaUxJGCWDq4rVF3Jc8slN9N9VZ/ES?=
 =?us-ascii?Q?TI2WQgPPX9yTcrogbQOnnU4Xgz1l066VnJEycUSWduwnBGdkxlrSc6hp7r9r?=
 =?us-ascii?Q?LkyTk0CbJW/qhCN7lu7vR2bsXk+lXrGYGCtoa/pivjFuWEwuXtKMu/mFt0Fk?=
 =?us-ascii?Q?HR7Q/ovvOTC5yAkLWTp+sillJxBLSMPB4g3989Z4FhnAdAuMBucV3rERDvVS?=
 =?us-ascii?Q?QpyGTHxsivJYyFEr17X1ECS+w0v8KMHHFa2LQd3+X0GE9ueNDlyDnYsUvzXw?=
 =?us-ascii?Q?PshTcKJDWJSq8QWyvx+cAoFVDV57grNnJKnfIF3DRx5oAbcTLs6Uj/OdgvgI?=
 =?us-ascii?Q?qQeoOKtcsm8INBcdtcJUApoCMi2rWmBgcVhhcvYx/yw2stXw2Get3p3ac8qM?=
 =?us-ascii?Q?LkMYO2OWwfYQ6VQ+fvIuJo7dzYEf3I0VFOBh8hmZTXOiSFfqONWar7kx5ELb?=
 =?us-ascii?Q?rgT8gNitR1evQI5nrAlkUqM3bDXJzqcZdP1yReCk6qoZdMavEtKTKE/eUtHT?=
 =?us-ascii?Q?PfCUqg7nn5yPZR4VDQGDSffIbD2d/fBJGUhtnR+3rg5ahEN4PyEAuMblKooP?=
 =?us-ascii?Q?d6iaBIL/XLAgkh+Fl6hf66DG/IFLMGa5FMIN2wt9ZU+AUF03DTCJCcq/wPeb?=
 =?us-ascii?Q?4+aGqP394lERWVRnRD3b9NwUkwcLDA0rHQlQhmERuagG8UN06kCkqqrh9a3B?=
 =?us-ascii?Q?Gd1uSZ/tBOXpS+3Lp3XeSyXrLBrqLppYFfFP95tmltW9evURC0t3kuRvMvPV?=
 =?us-ascii?Q?jkYTFSK/zYfurrZHhY9OwIRykSaWbnI2Iq2xE7wnGaZ67AZBIO7ZzdUwXRwR?=
 =?us-ascii?Q?jtdzmk1uSHk5qx/FhU/CaAFvM/4eUIihb/heBXRxvOR/LqV0ITw1P8qK1TeW?=
 =?us-ascii?Q?Hzv9xTnS2MiHeG4c0kgHsLgahnTJ/HOj2ZQhnbd+2TJ8bkrdPDiUGbCKqhPB?=
 =?us-ascii?Q?wpevz3jQiakugzd30CcfC+OTS/wkHYqGQ6pUZWs7jDy3TujQN7GwrgRea5lk?=
 =?us-ascii?Q?iSKzfGJsfyIiuLBVxo1fCz1F?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436aabe1-402f-446f-432e-08d98df997a8
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:28:58.1405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsMbJ9KxM/pyjYDrg8+YsEmrcHug8khG1rKFNwVF/k1Ev2S42u1VLr/ELB/v/ZanLA9FSzF0jllzkAVWD+dDwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB2955
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

coccicheck complains about the use of snprintf() in sysfs show functions.

Fix the coccicheck warning:
WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 fs/ext4/sysfs.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 2314f74..2a4ae3d 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -63,7 +63,7 @@ static ssize_t session_write_kbytes_show(struct ext4_sb_info *sbi, char *buf)
 {
 	struct super_block *sb = sbi->s_buddy_cache->i_sb;
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n",
+	return sysfs_emit(buf, "%lu\n",
 			(part_stat_read(sb->s_bdev, sectors[STAT_WRITE]) -
 			 sbi->s_sectors_written_start) >> 1);
 }
@@ -72,7 +72,7 @@ static ssize_t lifetime_write_kbytes_show(struct ext4_sb_info *sbi, char *buf)
 {
 	struct super_block *sb = sbi->s_buddy_cache->i_sb;
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)(sbi->s_kbytes_written +
 			((part_stat_read(sb->s_bdev, sectors[STAT_WRITE]) -
 			  EXT4_SB(sb)->s_sectors_written_start) >> 1)));
@@ -130,8 +130,8 @@ static ssize_t trigger_test_error(struct ext4_sb_info *sbi,
 static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
 {
 	if (!sbi->s_journal)
-		return snprintf(buf, PAGE_SIZE, "<none>\n");
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+		return sysfs_emit(buf, "<none>\n");
+	return sysfs_emit(buf, "%d\n",
 			task_pid_vnr(sbi->s_journal->j_task));
 }
 
@@ -357,7 +357,7 @@ static void *calc_ptr(struct ext4_attr *a, struct ext4_sb_info *sbi)
 
 static ssize_t __print_tstamp(char *buf, __le32 lo, __u8 hi)
 {
-	return snprintf(buf, PAGE_SIZE, "%lld\n",
+	return sysfs_emit(buf, "%lld\n",
 			((time64_t)hi << 32) + le32_to_cpu(lo));
 }
 
@@ -374,7 +374,7 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
 
 	switch (a->attr_id) {
 	case attr_delayed_allocation_blocks:
-		return snprintf(buf, PAGE_SIZE, "%llu\n",
+		return sysfs_emit(buf, "%llu\n",
 				(s64) EXT4_C2B(sbi,
 		       percpu_counter_sum(&sbi->s_dirtyclusters_counter)));
 	case attr_session_write_kbytes:
@@ -382,11 +382,11 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
 	case attr_lifetime_write_kbytes:
 		return lifetime_write_kbytes_show(sbi, buf);
 	case attr_reserved_clusters:
-		return snprintf(buf, PAGE_SIZE, "%llu\n",
+		return sysfs_emit(buf, "%llu\n",
 				(unsigned long long)
 				atomic64_read(&sbi->s_resv_clusters));
 	case attr_sra_exceeded_retry_limit:
-		return snprintf(buf, PAGE_SIZE, "%llu\n",
+		return sysfs_emit(buf, "%llu\n",
 				(unsigned long long)
 			percpu_counter_sum(&sbi->s_sra_exceeded_retry_limit));
 	case attr_inode_readahead:
@@ -394,42 +394,42 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
 		if (!ptr)
 			return 0;
 		if (a->attr_ptr == ptr_ext4_super_block_offset)
-			return snprintf(buf, PAGE_SIZE, "%u\n",
+			return sysfs_emit(buf, "%u\n",
 					le32_to_cpup(ptr));
 		else
-			return snprintf(buf, PAGE_SIZE, "%u\n",
+			return sysfs_emit(buf, "%u\n",
 					*((unsigned int *) ptr));
 	case attr_pointer_ul:
 		if (!ptr)
 			return 0;
-		return snprintf(buf, PAGE_SIZE, "%lu\n",
+		return sysfs_emit(buf, "%lu\n",
 				*((unsigned long *) ptr));
 	case attr_pointer_u8:
 		if (!ptr)
 			return 0;
-		return snprintf(buf, PAGE_SIZE, "%u\n",
+		return sysfs_emit(buf, "%u\n",
 				*((unsigned char *) ptr));
 	case attr_pointer_u64:
 		if (!ptr)
 			return 0;
 		if (a->attr_ptr == ptr_ext4_super_block_offset)
-			return snprintf(buf, PAGE_SIZE, "%llu\n",
+			return sysfs_emit(buf, "%llu\n",
 					le64_to_cpup(ptr));
 		else
-			return snprintf(buf, PAGE_SIZE, "%llu\n",
+			return sysfs_emit(buf, "%llu\n",
 					*((unsigned long long *) ptr));
 	case attr_pointer_string:
 		if (!ptr)
 			return 0;
-		return snprintf(buf, PAGE_SIZE, "%.*s\n", a->attr_size,
+		return sysfs_emit(buf, "%.*s\n", a->attr_size,
 				(char *) ptr);
 	case attr_pointer_atomic:
 		if (!ptr)
 			return 0;
-		return snprintf(buf, PAGE_SIZE, "%d\n",
+		return sysfs_emit(buf, "%d\n",
 				atomic_read((atomic_t *) ptr));
 	case attr_feature:
-		return snprintf(buf, PAGE_SIZE, "supported\n");
+		return sysfs_emit(buf, "supported\n");
 	case attr_first_error_time:
 		return print_tstamp(buf, sbi->s_es, s_first_error_time);
 	case attr_last_error_time:
-- 
2.7.4

