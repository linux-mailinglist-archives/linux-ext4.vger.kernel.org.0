Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B413FFCB2
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Sep 2021 11:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348578AbhICJHc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Sep 2021 05:07:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54752 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348513AbhICJHb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Sep 2021 05:07:31 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1838HX9o024356;
        Fri, 3 Sep 2021 09:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=rllpeofiPfINpfSvbOkujo0SpAizJC4txk2L6eDAHzc=;
 b=QHbTvfOXbWkYSzXUmtiBOr91NnVEkUGZKMrIOlQrMWGJ4ShPx8akXAG8kTrhemlTj1eP
 dXRRX6Ca+dNM0NqU3lMTDyjRuYdqCT5gyDBk9qR96VOJJBwFswW2KxG0F0l1IfIlwAFI
 wd4dOMuBkZXiYU0D+jc1NYgTaMkI+Ug5gcybfME128HCthSo5zroJzGYZCF+DQpo8Jgg
 kd9uRYpM2zNPMaoCiPHTsTp65Wcj4WKVUodgxHFZcR5eHN7nFCsnj9RC+fyvIpZ1wnKl
 R+AnjZoShqOT/PUq4X8hSU2ltS76cUyaoyDBjMy/vY9w1FpuojOk4zkNTi6L+RyQsfUr vA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=rllpeofiPfINpfSvbOkujo0SpAizJC4txk2L6eDAHzc=;
 b=x31WyVlRty4FCpOLyiPMOn4Kx8dhhVP2GV29aqNPTf8y9Qu8vu9bqJUhJuPfHdP9gpfy
 4xWZ8UHIyYVQuNLq5Sxsvy5D4iAeT1BEh002adeKsL1vjnWbiHIPVYxBvEHG+0NG3NFA
 +b+2FUofhOCG55Gr7yfFRDZKXp9/vd5NdlyuVzO0guF2aoWyhf6QLstv51oX/M8GVMlL
 1dZ6TOKD6zr0YOnL1mueSVA0NqRQgidQyOBzeuiRwyjjTWxYPbsUJDEM1leKb3nUMR/e
 KHLv8WhiB+Bx5FT6y9h3PqgHjTpvG/SSUhdc3enbrW+1OHK0hfTRy/3OMpwgP0OZKCIr MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aug2pr691-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 09:06:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18396Q9h119269;
        Fri, 3 Sep 2021 09:06:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3020.oracle.com with ESMTP id 3aufp32hqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 09:06:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcF180eVLwoKYX8fnv4CnA/HFHdFUAKVJ5RGCrIn4aPHoGwtqWTjDozbG9I6P2S0v6xNHDc+YMFFN6wIf52OK7o8pcPERdpcwgNOHUUxgsJDwiRmda1DkYgMJ9VUec9m2X71N1qTQg/Hv91z65JM7+u8wSC7dSfoBXRUG9QpUXElG+eXlZnYRQrQhoA+U0cRtXiDFCQrMs6/4kWNwUkRkTuGA+NN+iDEPtdPtz9ZMGcXYoqPRnAMydyiDbQcPLJl2l6YJvlvk5895cVNTHTwYXRRgNJrk6JlVVXUUSwx+JAmDnpacj3Kl5JG6G35OZGXTVpgDbK5bHUnvLjjRTikwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rllpeofiPfINpfSvbOkujo0SpAizJC4txk2L6eDAHzc=;
 b=mlU8RT+y4qt8x/WosVkluKunJJ7wvFbQCwR1O96kVAZCsFabWryyvSW1vlLmgkE0S+V4scDl1AJI/fwDnjHtn1wNdzpCCf4bqF9dHNPf7+ttpK3JiqmNDPex79+DCxdtJviYqQZxhEvLS0hin2b0SEne63ubsVAk0zKx4v6GxY2Y3ZkZOVnIRvFPnAMzCU9J0yzEJvFXUY1rJAU4SqwroTpJ/cADdLeqy8EP71XSvzllZkgyfAwDPVlWlmL4e9vL+rQh7q2wtq1iqPu6IF3sI0RyEe3vIiuvD8CNUeCH8C45SH2d8hohSEl5Ls7yt30gB5Kd6Hl5OC7EWNDPFj/j6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rllpeofiPfINpfSvbOkujo0SpAizJC4txk2L6eDAHzc=;
 b=KEBNag59udi/Xoj8wPpnOLhGC7MZvM1gn+/HhLdye2Dj2cwynpporto6x5+zWdQYmao1JWxE1aREJvW2Oh0oHritfLXH8pMBXJFnqG0EwePLXmkNfdEn/sko58Ro6iXBNBMu36cZD20NaRShq0R/n1wAb0LC21rW5ZWNjk5GYjQ=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1823.namprd10.prod.outlook.com
 (2603:10b6:300:110::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 3 Sep
 2021 09:06:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 09:06:21 +0000
Date:   Fri, 3 Sep 2021 12:05:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] ext2: do not sleep in ext2_error()
Message-ID: <20210903090538.GA7283@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0004.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 09:06:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d73d622b-a8c5-459a-d239-08d96eba18b9
X-MS-TrafficTypeDiagnostic: MWHPR10MB1823:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1823008D985C28D9FEEB72D28ECF9@MWHPR10MB1823.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:403;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/DeiCmITxj4lJrDyxJodmpD4bQivs6iwwaYhHhjIWQIetrrxfYWfkAb5UwHmHfYOaYBFlXVbbjdNGC3o9DCGydUyDK94MZQRHHuEWhD7/C3mDC0Ieq1DI6itx6jSo/1dVZrlIVHsPiDCc81zcF8+ZAQq0cO0L0WhZK2HkuAF1ZaSEqVBZhilRNiMsUYn+5HR7ySRSP3GWL2uXmlA6PJ4Ai/b84/K2FAA355KI6trZ0z4dnatC3QR4C3o1gCxL5njOOfGZg4aiYlMd5aN378Xr4H0jpNLSDMryNLfi0QNEpWFuk3lIk5td0fr8CZjZzNkL4SnfJ4KXL1jTym1fE01MvRxGvXGcDDMsxuWR34f+GiR2O30wDL6Skwoy8BDLJUNVDz7L+pvgIarNGAr/9GlbtakhNF6nta0o/nORVrIqAqSE5jR56HkCHtk9bi3V4zt3CL3a2XPpNKKkJXE5bKsJaB24BB2dztu7FMx7+Lj5xzgFf8bWf/2sG6F0vY1KpQqh2HWsYwP6uxULCmVFkRXr/CeoR587ZJDY8LkNNDiBcmu+/vb6Dpafvr5Moj71ZPa8DBsO3iRYbhF2Wwu9mwy3sumjc1c2n4o371xIR4IccB+chlPd8meQgP1AtOVUnaPGzqrqRjDgPa0x+gqw0gYFkrHKrHuGHKknfbp6zZ7mcpYK/GdGr440AYEivB8Xn/oS5v2KVHublWqYBbI3CrBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(376002)(39860400002)(136003)(66476007)(26005)(52116002)(9576002)(33716001)(316002)(66946007)(6496006)(66556008)(4744005)(478600001)(956004)(5660300002)(6916009)(44832011)(86362001)(38100700002)(83380400001)(33656002)(8936002)(4326008)(2906002)(55016002)(6666004)(8676002)(9686003)(38350700002)(186003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aPty/7N/1F+b41RNtjvKKfshs59+7BM9eHtjKzgO7B351WZby7YyfbuBI2ZY?=
 =?us-ascii?Q?hXXIkG0q3RYOUzvSX7B2tZcZsK3nx0JSImWr4PI0uV6btwHt8nS9mVIVk79P?=
 =?us-ascii?Q?hNK7jIzoE7w8jZxaC87vtj7BF8M07u4fDgtl2pHBTC+33PVvJjxhHL5RF866?=
 =?us-ascii?Q?LBAo6WJ/7czXJykqv1wq0BCyczzWigNb2biViQU0NochOnmp8U776fi97Xg9?=
 =?us-ascii?Q?94c9qqS4TtB42ob977Jv9vcW4ehrfeHTBObGhw9i3uKO3UHTd0Bdv67ESbUt?=
 =?us-ascii?Q?hAGpWGFmFJ2WPzm77b5/bjs1usJwtjMuHrtV3vaA06CpYlPtVjNEt7pn6jWV?=
 =?us-ascii?Q?b0Mt98clBaTyB1l47doDlQm51uuIDQML7qNIIITm+KE/eKLPCkdfqRK49vUx?=
 =?us-ascii?Q?6YTXMEcY3pOxj8LhGTaMV7kTvqCik22Ufmv4BronSuoeO2cDO8UJzhz4uw1G?=
 =?us-ascii?Q?oFScT0jSOR2Hr4PbGI1BiKPktJnYzUJhxJkBQe9Pqr4VZUY1Cz8VGr09fzot?=
 =?us-ascii?Q?ElrLv7mo24N9tVgce9MSJ53yP0VxwyuKVkkfQ72u7/chXI8FKOXYFs+P7YaF?=
 =?us-ascii?Q?QuaBzrndA9T5dkNCa355opDoqeFEUknpSOhjiWk3Z0gSyY0DkiNHNd/l1Yfo?=
 =?us-ascii?Q?t6XBoXlgNlCDff5KFve8UQmwyUpb7Sx9Es/3HqWK5ZYIiUv7HKaWpXrjSma/?=
 =?us-ascii?Q?d0p7gZreH0C18VumNNEhfrw0qH7LYPXnhyGQPDtWSi5hTuo6hhszXAvVNMni?=
 =?us-ascii?Q?QmtF6GT8uRMJemSVbeWhCeJlXHStqdQb17EDAFugd3pYRKWUyiYGjvVHVJ1k?=
 =?us-ascii?Q?Ah5IwPFEd4QStflO42DGyBqZudSX4uuy1ArzJCQNJ+J44Ywpf8RzE8o9lk6+?=
 =?us-ascii?Q?Kos6c6GQ/sipjQ1iCF6VnH4yn1+gx1j9mu82otznyMq7QH14Y+ruKll54mU2?=
 =?us-ascii?Q?S/z8D2v38cJohQdGUQHXbi3CU4k24AReA//TAJsTomKOpQ/N2fAThF6aTkqV?=
 =?us-ascii?Q?+sIklYptQSF7iBEKM0KdMt0HldAWpcAoT7BENuKJfc1dvVYwZ2Tq+Yqym2pY?=
 =?us-ascii?Q?EjXFbnjkRRmXFkH6KkQqdWXmOwjguqj/MKGGQVAbzXUXZMaUCR3fi0pl+FBh?=
 =?us-ascii?Q?Fzs0fLF5yToI9cOYPN+HJelcCL+tJRLDonuwFb4JHBeBvU14OYoL0dsrvupS?=
 =?us-ascii?Q?Xm3pGnjCGlCAjOFZeV/AY7fIcEvmNmccRCbHUk1Bmteez24AM+g3uvokfhkx?=
 =?us-ascii?Q?L1Z/ZywvwmBnscRpQtVMoJnCD1QluKtib4oqMPE+KbodSvA63NM7IoXGWsAh?=
 =?us-ascii?Q?rpvSXW0G5zzCkHRVf5+PS3kn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73d622b-a8c5-459a-d239-08d96eba18b9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 09:06:21.0367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aq0wwffk8ri6WxKqjhygT81yjJ/SX7jGaTJR5840pP6fcRMB0jiX2krIRpRk5OSDrf2ANwJf8zh3I7MYVZsOaUQCQywy54b6beLyGEmFgh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1823
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030055
X-Proofpoint-ORIG-GUID: -qk480mRuDXMF2a8rtl314cwHZyrJuKE
X-Proofpoint-GUID: -qk480mRuDXMF2a8rtl314cwHZyrJuKE
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

No one expects error logging functions to sleep so sometimes they are
called with spinlocks held.  In this case the problematic call tree is:

ext2_statfs() <- disables preempt
-> ext2_count_free_inodes()
   -> ext2_get_group_desc()
      -> ext2_error()

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is just from static analysis.  NOT TESTED!

Probably a safer fix would be to just call pr_err() instead of
ext2_error() in ext2_get_group_desc().  I can send that fix instead if
people want.

 fs/ext2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index d8d580b609ba..ba345ab860f0 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -59,7 +59,7 @@ void ext2_error(struct super_block *sb, const char *function,
 		sbi->s_mount_state |= EXT2_ERROR_FS;
 		es->s_state |= cpu_to_le16(EXT2_ERROR_FS);
 		spin_unlock(&sbi->s_lock);
-		ext2_sync_super(sb, es, 1);
+		ext2_sync_super(sb, es, 0);
 	}
 
 	va_start(args, fmt);
-- 
2.20.1

