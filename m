Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47BB413B6A
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Sep 2021 22:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhIUUeU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Sep 2021 16:34:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10212 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234860AbhIUUeU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 21 Sep 2021 16:34:20 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LJscC0022567;
        Tue, 21 Sep 2021 20:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=A9bhwrlpRNeKLNUwwI0pLq5hYEJQYqYp8zfp4AORmq8=;
 b=U6nN/8BDrWJQwiH+R0iC3Q4KL9rLT08GCYv3CTwyDIGPWKgMmejp6iSBNp6DN4mZHZoy
 AaGSROQLiKoqR1Y0lZI1ppjHy+o6UdIZlaVVMlIrjnDAl4MD+ihIaN78rcp1z+TkA+as
 HOLZqHd/UFlQXLdPxUeH300zckyLdfXvTZ+qhl0fRi9U5tPsXx1DR1xQRkZqXV29t63G
 nJ9ytw0Hr+uhUZ2lt7jKLiWEFjt/8Yu1M0VzRXqhrJ/3wAdXYdzhuHqTqita0Xd+QxZi
 AGtvDR5rwj7xQPZPgz4SUQLwbVONjfzXAWhXB3Yl5sfOML3gDBy6G7HL7lYAlkEwSRtc CA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7814mdv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 20:32:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LKVZ9h049745;
        Tue, 21 Sep 2021 20:32:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3030.oracle.com with ESMTP id 3b557xkyyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 20:32:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na7QflpL8/G83/V9EzZKRmRhN59QIbNPInvLK7o0NsEUBWVulhiMo0dnt+5/amb5tkjkvdNm+lEdbjtdt0rsBSsw4QxQTDE3hiV4XIFYkBVvH5dh/QVT9Q7fhYVieJB5/rvQQWXQiw6VUTnWak/MXSys2OLVBGMW0XOxu8MX7iE6VJlCVzM1FC7hO5nQGiQq+8cwjwnoSDWPYC9ZaVllN4WuOQlVl1vct42zIE09Kjk/S0iRlsCNBUnlNty0OxUPmyAhNKnOAJqoUZiwdltSpsaZGGxz42qqG8DCdO5+iKPnqgeCr9O7KkKLaFoJ53j0zggEpGEDoPLRyKweYawvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=A9bhwrlpRNeKLNUwwI0pLq5hYEJQYqYp8zfp4AORmq8=;
 b=XLWVVE9FT53kA2DR+Sb76dFCE4kn4ke9kfWPEi2cOQYG7CmgZh1x5ALPnuU1BESAqGmKWAkJvDSG5gudOSUXkZMp1Gb2mVue0H82c2faBC7ZSxnVgbRHqUMNMy7edJ9vzXo/Jzecy2TYVb9GtTkCabtfI5Zq3ggQeJ9iPTypgCv3W+Xlhu26A/3YnjwxOeUsxOew9J5DYKlZTmdsetWf9AdaKV/H7304FAX2thJNNzlgLlJNzCjbg1yyoS1N8Db1pcQfJst57+dE2VBDftPlCs+zLpG3tqYkqjxA8MFCZttJtm8BeaEwjX7EEnRZXP9YNf8sVGSYMPHWzhonAicHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9bhwrlpRNeKLNUwwI0pLq5hYEJQYqYp8zfp4AORmq8=;
 b=e1WFpbcP3/KWtr1ewydu2cc3mND+bJJ/WxwWP8rvma3vANEHx6489GHHMtmpQjrmEsAuy0fwNFNx/xnNglHC84uVoO3xG8MhUamSDAPyo1Zcvll8yBgRTeTIHuBVcMTORRGl+el7jTrNKjH0qaIcbUDdsof2TOyflwxQwf2msvM=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2255.namprd10.prod.outlook.com
 (2603:10b6:301:2f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Tue, 21 Sep
 2021 20:32:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 20:32:44 +0000
Date:   Tue, 21 Sep 2021 23:32:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] ext2: fix sleeping in atomic bugs on error
Message-ID: <20210921203233.GA16529@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0161.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0161.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:41::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16 via Frontend Transport; Tue, 21 Sep 2021 20:32:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8206c888-d731-483f-d1bf-08d97d3ef766
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2255247C6DFEF241A7DFB5118EA19@MWHPR1001MB2255.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGZTyGPK2qO+eugIKQ+7JkLh5QDXy/gNybhLGfkirOMY1UZZE2EhXvf0dfRjWidpnvXX8MhTjPbaUbOP1Ly4lSS+6m05YkZxD/i1UxuTu9E87sHrANAS504R0SCvzmsF6jv5fDviIDWG+Xz0VxgvAN6/ZYBe9+m0Wl8sj6ABRjQRixHymOKJxsll/fZpNNZaUghM2mRBRUgpLASKXrGSYB25liOy0gfQTfJDxIJX5EimHWhxClvqKRtcQVvY9b2agmN31ojiBrdp+rRXeYJlPaqsVB31U30BEx1XWkTpAZJHp2eWShPv1s9IkYIlD7cTYNc0RjMyjpiakIJLyMLSwiWokdlGBor28j69TbXs6wpX4/YUOmv0AoCONmucrQtbMfVk+U6aIdoRq67/eKpg7ZtwfL6lh6AenW57kUA0SgWeg0xsU4oE3sZiPsKm0S9h4V6iJywojHTY6pI3ESCoOfcqtbFXmRM8UfdyPOmuau8khNTOWg0awgEbdRyNme5hx58pQRpDPqUXTv2I4/O3Tl0eyviKYsKvtuQrTZQU4wasL4XldSF8tfcjx+5izmLlt8beb/t6MYh3TbC48ooC85403LAcHJvUBi322sjyee+5epR6t18szLDEr3LPQLXxtRGXzNE6skBCVkB/3by75e+xg3HrvA3CoySn/IO+fvmRjV+gJ6v+nuTTMF+FieSSEUzNX54BUHRBijeiZTQdtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(52116002)(38100700002)(956004)(316002)(38350700002)(6496006)(26005)(66556008)(66946007)(66476007)(9686003)(2906002)(33716001)(6916009)(83380400001)(86362001)(33656002)(8936002)(1076003)(9576002)(55016002)(5660300002)(186003)(6666004)(4326008)(44832011)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tN76Bj68RCxBaIlfxhKql0UBz/BGrfT6htOF5226kqOGK4YKppEQBBKF7p1z?=
 =?us-ascii?Q?qUZZTQHhC9D18/BkYUbJmNdFmfWovF7Pmz4429XZ+fitQCCB7lJ4OEGYtzSq?=
 =?us-ascii?Q?PjFgUTSGoGKx0tl1bWn200gaKxcSo9E1ajLxL/T3ibTlUZEAJrjCMVsaTmGd?=
 =?us-ascii?Q?+3LofPSymgCBBZZe9v21voKEEkEujJ+Dc4VcaMHx3rQksnO4+PkKcwLj0srX?=
 =?us-ascii?Q?jcElC/MDEOO9M4eeHyqt02T2glWEbunEoAOXLZ2TjkEp+R/El8g9Gpk4zVs/?=
 =?us-ascii?Q?hN8NH9mHsd9pjCKj0MORv2vdQYhkIc81rQUTOSySk5gFUtskeU/qsnRhOQLY?=
 =?us-ascii?Q?Pmx9zCNcFvR+v+j82RNp+37bjoaKD7nz1WtCkt958ZMKSoa9goSxf/5IgiTt?=
 =?us-ascii?Q?CDv8dzl/GelXUzBx6vPjXFEtGQsacXz5BGsA+lCfs81H/+wr+z8lkBD725L0?=
 =?us-ascii?Q?LRvP58DUA1XIIqM/gMH2Cd/B+8CC0kZ+UXL2BJMrfBQVPwmDScbU+HXsDmRJ?=
 =?us-ascii?Q?JbN616jQIgUsw1i+o+1lxNUbPI9ktmCLs04i9alEPGSHTmDcPHJXFBNn9q0A?=
 =?us-ascii?Q?QwsXqf3Pj30y4GefpP29T9GCNU1nQEwDLJ5LgINBf5Cg9cb9P24eXkzFMAdR?=
 =?us-ascii?Q?vbOxK/FqYvq0PRPAODRHuEDVoqlu52HrBeqGIXItd8a+7voIUg9F3seSfvwD?=
 =?us-ascii?Q?4BTfSEBXWvoiBobrYPzHI5aHIRl+GETIVscw4x6fiAnVK4WJcJdYz2OYjgQC?=
 =?us-ascii?Q?TRvYvmuGp+MMdHx7ZcqR36h/VUMTBkW8Z3CDvKrGOiVVJdD5pEK3495vllZM?=
 =?us-ascii?Q?KwKb4LzjFo3pmJUdHVQv1XjbQWK2BpPMbP6sthmFrDJUvo7mgu2yW3pOxNc4?=
 =?us-ascii?Q?Jj6Se6mc4cXU1vRN8YIWnSbIvRlS1I+jLLAe9fInM4aGsA/GJF/pqkI94Qyx?=
 =?us-ascii?Q?SWW5AIuGCcpixfgfmvcmkdMEoEcsju30KHLHOHLZ9P5GmEtaSUKZkjrVTGPC?=
 =?us-ascii?Q?SZ3fTucpzrMfj25YVWHDOhs04yH1pSI+Tj7jDkw6zh2PvTGo4ZvmEcNYMhma?=
 =?us-ascii?Q?hO3A59bepITiKLd6Pc+ASdazvYz0ghlc0Nu8Zk/b8pbqBdRSDqUujuKexB+1?=
 =?us-ascii?Q?Mmcj5wpDVDb2yyZMQ7ORRJ6g/9wkr7ZXw+JqNb7/TbxFKXMi/Qk4HPq23//D?=
 =?us-ascii?Q?YveVgTNIRAy2Ph7Q4Mi4UkXJft2s7sXukP2SE3XJhc5H2oS5aifpa338Xqx3?=
 =?us-ascii?Q?ez1+ZoOBAhFszgqTTwdgyUBTlpsJAe63BTg7+maerd8IYe5Ywh0QL7W04rgl?=
 =?us-ascii?Q?hMLQEmk1xXKFbwZUb+ZsRojN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8206c888-d731-483f-d1bf-08d97d3ef766
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 20:32:44.5448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQ6q3c6elVBU7HLe8A7vrQQq7rwUnXVc4ORpJF5xhBXApmhKLDS9ha0yQKpOlZrlm3nygELbFSo6Z7d5Le7qALe1+IvADhcR9G72aK56F2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2255
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210121
X-Proofpoint-GUID: aLmhW1BruN81y7c7le3bTmENzTx_LphD
X-Proofpoint-ORIG-GUID: aLmhW1BruN81y7c7le3bTmENzTx_LphD
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The ext2_error() function syncs the filesystem so it sleeps.  The caller
is holding a spinlock so it's not allowed to sleep.

   ext2_statfs() <- disables preempt
   -> ext2_count_free_blocks()
      -> ext2_get_group_desc()

Fix this by using WARN() to print an error message and a stack trace
instead of using ext2_error().

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: The first version disabled the sync in ext2_error()

 fs/ext2/balloc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 1f3f4326bf3c..c17ccc19b938 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -48,10 +48,9 @@ struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 
 	if (block_group >= sbi->s_groups_count) {
-		ext2_error (sb, "ext2_get_group_desc",
-			    "block_group >= groups_count - "
-			    "block_group = %d, groups_count = %lu",
-			    block_group, sbi->s_groups_count);
+		WARN(1, "block_group >= groups_count - "
+		     "block_group = %d, groups_count = %lu",
+		     block_group, sbi->s_groups_count);
 
 		return NULL;
 	}
@@ -59,10 +58,9 @@ struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
 	group_desc = block_group >> EXT2_DESC_PER_BLOCK_BITS(sb);
 	offset = block_group & (EXT2_DESC_PER_BLOCK(sb) - 1);
 	if (!sbi->s_group_desc[group_desc]) {
-		ext2_error (sb, "ext2_get_group_desc",
-			    "Group descriptor not loaded - "
-			    "block_group = %d, group_desc = %lu, desc = %lu",
-			     block_group, group_desc, offset);
+		WARN(1, "Group descriptor not loaded - "
+		     "block_group = %d, group_desc = %lu, desc = %lu",
+		      block_group, group_desc, offset);
 		return NULL;
 	}
 
-- 
2.20.1

