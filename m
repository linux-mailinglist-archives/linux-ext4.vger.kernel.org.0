Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD423B23EA
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jun 2021 01:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFWXXx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Jun 2021 19:23:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35054 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229688AbhFWXXw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Jun 2021 19:23:52 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15NNFifv032131;
        Wed, 23 Jun 2021 23:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=9A8DxVX1PzDZMcoIRrAtg5masHWf9hAJAzhGZt8EsSo=;
 b=t8kaNabxHl2BN/JptHrZQ/BhUkllGtjwh+dxv1s7yngOPbiL1E2PzfRgV4KGXZYziDs4
 10mljceC2HG8ZR2rr6/XV+e54rjbewIH29rM/203xj1XqI0oRkOcSZgfcgZsVkgJs7AJ
 vWwEPilmLlTdm8ZeV2WXHrJ87EwJxLvPuBdE1vs/x0ZXpCLu0z3+z/b/0JxByf9MWZXC
 YFyH0KlYNZWBW0eMvx8YlLld6Fw7Ys08TA5yQDIoEwo2vhMTc+vtzZeou43jcC1V3Gbo
 KHjNbV60f4/N9JbyR3Ver0i1tqTK4dc/dVhvlWWWKaqx1ugxkYmMKbgHh+T/pus+J8pZ Dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39c634s5x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 23:21:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15NNFhQN021821;
        Wed, 23 Jun 2021 23:21:30 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by aserp3030.oracle.com with ESMTP id 3996mfr92u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 23:21:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6JkZvl5qrSbVteUv0tTjEHVZx6KeqlwM5XDAdq3Jq0IvURCJayMOyw+czOjyQPHYeegJkpYwDKNvGnn/UuEHr2rWzP1Eg4ZR5ldiGG0lFlsWqg93d1FsymsmqmCmBQTNa4MQuxhmHLoQVdXQG3UNAhgYjIlqxtx5/QvSuRkAxy/wigHutu7jtjoMOWVUZIn2zeaMfT7iZ2zl/PH/ruZzf4Sm6jmz08AMW2e9MTPbpWNNgkITCe74XFpJaZH5dunvoQB35caf5B8qtbiGUQLADJaQDT+0qiyvTqgq1Q9q2Jud+ZXI5HRiJ0WhC5IQmObW39zf1X7yhPyJWVjmarflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9A8DxVX1PzDZMcoIRrAtg5masHWf9hAJAzhGZt8EsSo=;
 b=OpxZSPQcutRWebxJ+cDko02B68XFQDUF6EXQirQWdiIKOoZBTbuAec0C12ZWaB9uJZ17ZchcVIZsaUQBe5z0E3XQ+vOwbxMZMLFAZ8dKVzLp8/ZjiLsLyhQjyvhjRP/QHHmw2OXtqUs1+dHLF9JPMIixng2qrmd3Fnj2yukeaOqJMYPQX+q+5TIginwuYrj++mTco+QFYiuqUESX6xxsm1UEBZR6xke/7WczSszT7V+bM9rxudsrJjQ5/HbyO9GegOa8cpukdC/M/UwNXdzd9JjNGyOAOefo9twsH58vnQe+Mv9Nqq3dc1kiAlYmMGGd9EJDm0MNVK1hFs9TU18DgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9A8DxVX1PzDZMcoIRrAtg5masHWf9hAJAzhGZt8EsSo=;
 b=PaqSOBU+nT0o8piO3lDfhXsVuYmL1c8ia9Mb8AEG5Un+eConC0HehIY8ctEg7Nbwx6FMvoFjL33Wk8CnKfq2eBV2TpkxUANkHGJH82DJm/wjBCJq+XDcoFiYd0RK9wDsrDGh/hkifC8KxexmD8hLlX64ASpRarM87KeCtxlKeW4=
Authentication-Results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2830.namprd10.prod.outlook.com (2603:10b6:805:cc::33)
 by SN6PR10MB2624.namprd10.prod.outlook.com (2603:10b6:805:4c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Wed, 23 Jun
 2021 23:21:28 +0000
Received: from SN6PR10MB2830.namprd10.prod.outlook.com
 ([fe80::7523:a95d:4ab8:7f29]) by SN6PR10MB2830.namprd10.prod.outlook.com
 ([fe80::7523:a95d:4ab8:7f29%3]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 23:21:28 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junxiao Bi <junxiao.bi@oracle.com>
Subject: [PATCH] ext4: use ext4_grp_locked_error in mb_find_extent
Date:   Wed, 23 Jun 2021 16:21:14 -0700
Message-Id: <20210623232114.34457-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2606:b400:8004:44::1d]
X-ClientProxiedBy: SN4PR0501CA0041.namprd05.prod.outlook.com
 (2603:10b6:803:41::18) To SN6PR10MB2830.namprd10.prod.outlook.com
 (2603:10b6:805:cc::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8004:44::1d) by SN4PR0501CA0041.namprd05.prod.outlook.com (2603:10b6:803:41::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.10 via Frontend Transport; Wed, 23 Jun 2021 23:21:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed083ca5-9f03-4b27-2b13-08d9369da0a4
X-MS-TrafficTypeDiagnostic: SN6PR10MB2624:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR10MB26242A8F29AD4BE9CD96AB67DB089@SN6PR10MB2624.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HInPo2ybV17RlO13boeXhUpZjYUZjrDj27lKJcgXbyNgPbuogZ9i9VKMfqxb?=
 =?us-ascii?Q?mACIVdC3WFbfOMDA9y3dApNIah5aDyTOxDAyWcycBN8mD+vsXl1XSx+k0t+g?=
 =?us-ascii?Q?D4OlmVkKauVB0jEUoIM+tx/Vrw9JcrNan3p2trcmBM2eyeseOfbXHr6eZs52?=
 =?us-ascii?Q?NuVZTpacepwP8B9zi+i/OBN/xOn838z0G6zPinDoYV2woytnOjWfj7/+i9KR?=
 =?us-ascii?Q?oRK7P1B6GRI2ztfO1Jo2EYX+qobWf7Id399o0kSmQxQQmKkpSCZFOBYB+Oyo?=
 =?us-ascii?Q?xsVV4Y7cSxrRQaRemw0z5CYEbVLG8gwMlCT3pzRy0GLFaTJx7VkopYSKj++G?=
 =?us-ascii?Q?+aeu7H9KaHTW3SGJBn6FsBgYQJMN/HsjgHv77FzxMbzInQVgux167wNzMr77?=
 =?us-ascii?Q?e1VYxh3X/2YQsb2vr2KC9Z+cV9kT9bSbmhdSYgB67DlEcYIGUjt7ZkZJOfuD?=
 =?us-ascii?Q?W8JpF4DAwrlSdWOqa25MSdJa8wNaK5X6YEQOzwOmgyt0GrZMIaetnlOnf0JP?=
 =?us-ascii?Q?mhTCtpGoWugIkm73qfccYlFb5bLsKIEcD74WEZpSN724D0rcURLW+cZUqqeS?=
 =?us-ascii?Q?pmjSL8g+A3pKqt6dEIzAq6EMMDVk7+EUVLB3QS0ctOQbzjbUI8kJwv2T09kL?=
 =?us-ascii?Q?LYMxDOjMvphf0ucOavA9/sa/vKpheDsrlyLwsJ1j3HExyzOwXQdFFIORRAji?=
 =?us-ascii?Q?xbf6Frcd8vwREgWF3ZTQfJ1ZzsoHNAVr+7ZsjwOzURVklIIiihDNQ4043gPM?=
 =?us-ascii?Q?KoXJ/A/2v/XFL8nBnpWQuPwxNdW1OALG27g1AvAGT8T1QkdB4NXp613wkqo0?=
 =?us-ascii?Q?f7Ss7lp3hnNgzNGLhQ5154xjPIukNm4EvN1PbtTOYXlJnRRdEYx8d8nPxiJX?=
 =?us-ascii?Q?mo8pd3YEsnGLKcZQl5B81BiqH0J5HiN+snqZPL4VqG+/T2tnzl+4A6YVNXZZ?=
 =?us-ascii?Q?9QzKMbCtUT2DeomnVlZS0A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:SN6PR10MB2830.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(39860400002)(346002)(376002)(396003)(136003)(366004)(6486002)(38100700002)(52116002)(1076003)(6496006)(2616005)(478600001)(2906002)(83380400001)(110136005)(36756003)(5660300002)(16526019)(186003)(6636002)(66556008)(66946007)(66476007)(316002)(6666004)(86362001)(8936002)(103116003)(8676002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QrvhpHBT1QR73N0MtvuFqX6oWRvd+RisIRPZOnwCL0ZzLOQ8QGHY6cWGIpZ4?=
 =?us-ascii?Q?VwD/Tpni/Fvj+Ii6RqyvefrSnN1rCPr+rOrkJWqGpI2Jj20/YyGyEk8a/pSZ?=
 =?us-ascii?Q?S44IehmgAklK5kui/MkZnSG4vdpWFeUy3CmLJwXL1oZUCEmmaCP+IRYeupl7?=
 =?us-ascii?Q?G/2ORRuYjFPZNBoOBYKJTfrVm6LbDiLh+HitjaTYGkrhHWAVXfCVTdfZIlMZ?=
 =?us-ascii?Q?cj6pqzI8lWjM+O+ZupjouOE1cS1GiTllxYH7FMujp9DN0GVMxS9wvjxd/i7/?=
 =?us-ascii?Q?rxslRjnIPysVGKnkFyjVR95A1H1MblXJ1mlq+g6MIaHR8Pn0apoqxhbhvWXF?=
 =?us-ascii?Q?/gmCrVLA869J1x0XCAZZrBDZEjShOV7yAdrtSav0JfCwahGT48bndFqtBJ43?=
 =?us-ascii?Q?pN5oDPwbMsH5uaEzVponTE/ce5Exjk5xdqLKUm2mIYEZCpUl9tJCbVODPJ2F?=
 =?us-ascii?Q?9AWNsZU1KEZTl1uxgI7btd/2mTuYzQXhVZ+uQ2S8OgfuijA8bPvd3ui5KOPd?=
 =?us-ascii?Q?zx5jvqfOMRuvC8qxkfmkBv5SQGe7d2ehVqN00uu/OmA5zutreBqviFPdcVTJ?=
 =?us-ascii?Q?tLgT1onkmY3CYtj8oQcQ3jup6P8yWS3W/RYlgo5J68AkY/oXkeXPy0VbROR2?=
 =?us-ascii?Q?pJq1TInN0/3CGLQdw1bAKWOyCgGlRKj4u0oRGBdnY2I4TMF2XOCUB9KMifpR?=
 =?us-ascii?Q?4p4W7Qht6KM/K/zQH7CDauoPG7t4sZQRnW23pf092ylHWayCoaV6HhjQ4fGq?=
 =?us-ascii?Q?+aTQ74p9O1fawTp9i+oiM4qi14Kgp5HRYpXJPB6u9QWDdhDEP87J2QLHOPfB?=
 =?us-ascii?Q?Uczb/pO9EN/LN/It0mrqLyEIYet5zdiHmQGDHAppTnxF5Q6vbuZaCfU+Gjvw?=
 =?us-ascii?Q?xMp1ecF+7GhTNE+J2GXuI8y5xZu8sXsqiQpm/I+UbsKKYQ3bXUHs90jkEGLa?=
 =?us-ascii?Q?KSdQxMloKOqzruQUytPVx/yz49gezFT8su8sbivUaOm+9rJ4rlS4t+Tg+U4S?=
 =?us-ascii?Q?UQWLZXtT5DQWlVitMx1n5la3GxAwtIe9vIkPaO5Pf9tpjdLB7ArSVVx3xwhF?=
 =?us-ascii?Q?N9l0wVKTrv3MfEMwa/KlJxfH/64wxXqEPbX4RSigrfGtOIDh7G6IqsuAeHLq?=
 =?us-ascii?Q?wQhcklfZ1dUIKvKXUCcA2MvWN5CkmidpUFJ1gj0dkEbIar02Vg49g+Qdwi7b?=
 =?us-ascii?Q?qqdwjpV3qTwrrH7yThWxQiU92LfxS9FiMt4W4V1CzI336lQbVOhcX54MnxUZ?=
 =?us-ascii?Q?ecFaPrYLEfJ7TsTs4Y0fqvp4iLK0x1CjhnixdtF3Upy8pFLIuZAqlXlRLc9e?=
 =?us-ascii?Q?6BK5TqJZTQ4MNc4hSDV9ne2kJB+N2iJhwDTF8U5K6rXoow=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed083ca5-9f03-4b27-2b13-08d9369da0a4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2830.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 23:21:28.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XztEWoUtQK6fCnwFgaAEddARlys6QafkxIQA084dS730amEAC1iiTYuqD4LKPBR+t8x8Wwyd61QVidu64VNaxv9GvzvtcYNSJ8kNTTssz8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2624
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10024 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106230136
X-Proofpoint-ORIG-GUID: 8xXOquu-EBzwJujWKOW0V8bG3teQFgxm
X-Proofpoint-GUID: 8xXOquu-EBzwJujWKOW0V8bG3teQFgxm
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit 5d1b1b3f492f ("ext4: fix BUG when calling ext4_error with locked
block group") introduces ext4_grp_locked_error to handle unlocking a
group in error cases. Otherwise, there is a possibility of a sleep while
atomic. However, since 43c73221b3b1 ("ext4: replace BUG_ON with WARN_ON
in mb_find_extent()"), mb_find_extent() has contained a ext4_error()
call while a group spinlock is held. Replace this with
ext4_grp_locked_error.

Fixes: 43c73221b3b1 ("ext4: replace BUG_ON with WARN_ON in mb_find_extent()")
Cc: <stable@vger.kernel.org> # 4.14+
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 fs/ext4/mballoc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c2c22c2baac0..089c958aa2c3 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1909,10 +1909,11 @@ static int mb_find_extent(struct ext4_buddy *e4b, int block,
 	if (ex->fe_start + ex->fe_len > EXT4_CLUSTERS_PER_GROUP(e4b->bd_sb)) {
 		/* Should never happen! (but apparently sometimes does?!?) */
 		WARN_ON(1);
-		ext4_error(e4b->bd_sb, "corruption or bug in mb_find_extent "
-			   "block=%d, order=%d needed=%d ex=%u/%d/%d@%u",
-			   block, order, needed, ex->fe_group, ex->fe_start,
-			   ex->fe_len, ex->fe_logical);
+		ext4_grp_locked_error(e4b->bd_sb, e4b->bd_group, 0, 0,
+			"corruption or bug in mb_find_extent "
+			"block=%d, order=%d needed=%d ex=%u/%d/%d@%u",
+			block, order, needed, ex->fe_group, ex->fe_start,
+			ex->fe_len, ex->fe_logical);
 		ex->fe_len = 0;
 		ex->fe_start = 0;
 		ex->fe_group = 0;
-- 
2.30.2

