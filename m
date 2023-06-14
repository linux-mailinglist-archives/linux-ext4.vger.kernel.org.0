Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A0B72F7E4
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jun 2023 10:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243614AbjFNIbl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jun 2023 04:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243625AbjFNIbi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jun 2023 04:31:38 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220551FDB;
        Wed, 14 Jun 2023 01:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+lvTJIGI+9TgcZFgyRfhlejMksp67TEvGOen4PF2hLlK9DoYtiO9OgE/ZcpMuzoRJUeKdMx+mLLJ/6PWfWoMulUrxRaVwjyrZ1PG67m7e/gMWEVhXk7WxWOtq1vJuFFnd5pRR+1U2jNf1f7lTlxR/stOvFCEbRasIMGXTB13VcVTJYTP8+hEWbdspmTAvPFjqka8aqFvoLS2eZ+zDzJT9nm8Nquem29LR81ayuIftppE+DdBJPAvNfDCkgre0+nLWrCF7dtgKPMdR1xI1QP5Nf+rsxCRAxXVNRwKIEtTl5qF/Z60N1/H4BHMJMY55dYBJT+aGneubyyh8H48N2XkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzHArnVQM3CH43LbvYyOP+jTpUFDWHjlQqzq/5SLtMw=;
 b=daFL9x2wp8ycheNDycldcD0ZboW4dG/sc95DOU8iqOoxd5Q/IWxOT11fBEdmNqEZk203tKpWdauHU3x+LhgsDL11L0eftxO9w1DqDd4NpPa8OYcntszE9rMs7LAl54EkArKk08xHKtCBFMJNL7k5HFPEgFkWAwQoSPryqxJVVeSkwXmd+sOx9+FCie+jFVqz0O3gejDMb7/ZGa8cF9hbShp9XqTdFcqX9TQsJVKGI99hOjwXAZ3Np+pDsq/SiFXAGogfrZ3VuvbSud3KS/WA4AQIFXLEAkhBLGGly7DLAQ3Gec+xIoCEWcLlLyNeBu3EO4iuOHCNUN54O7zgVXZKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzHArnVQM3CH43LbvYyOP+jTpUFDWHjlQqzq/5SLtMw=;
 b=FGBddTRqyzjFxIyKiBvshG4qlFdMD/g0iNMCHNMUDJd5Rim+4mdXDrXPCXBqqNTYlU6d8gTRaOl5hV4+1cIGeiDkPiO5nM1q04kGTMyfhdKLWcrkRLV0vSg8qkPYCpWHNi//5D4A/WIQz3/BI0u4HjGKR5OqF1LU2VRcbzpYuqllzgg7N69n1pqCuDyOSNxMHKqSmuzW48kAfcKtHkcfjhPM99I1BMvOUIgWFElzfiJ4SUcrlyRSB4PPndBp4mD79m42y1Yaswg0pKRG+7tLqtqEOJYOhygIltvovt6YxqT+Gwev3dF7R+3U4ewRv/pdesm4AuCwtNLfQb6r7af+gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYZPR06MB4255.apcprd06.prod.outlook.com (2603:1096:400:72::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 08:31:15 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 08:31:15 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org (open list:EXT4 FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] ext4: enable nowait async buffered writes
Date:   Wed, 14 Jun 2023 16:31:04 +0800
Message-Id: <20230614083105.20663-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:404:56::31) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYZPR06MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f47bc3-00d6-423b-b7cd-08db6cb1b7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWS/ynSntAVMogT9HLhJFbzEfqJMvMKtSwMqxmOEei/6pjNaIzz4Kot0wIor/8tTGdxDg2sPWxzFWE/f2oOs2WvT7ur9qrAUhHleGDzqc1yREnMMDDT6YEkl1cLToXwq9SXWs3AfUZ8uHlG44fHzd8zxNiZtIw9RLlI2O1047b2gkrC4kbPRsIgNVRAwfZnb1ENyA74ecWQ+Jg1tlid8ElP1W2cRJncpN1t6rGbh6wd9f/K6tbMNueZ1gq3bV0Mcs4qkAapvXnqeDfXvzGFtoi4yndHhAP3RxubqUb1/tOXo4XP6K+sjU3xuEMmdJExAvyKTbFlkWmAkMVooaEBmEPgZDJxHOl60xF2tP4ZD9fXGja34WdhLYTQAUO358wXXJZZZdH5fusyDaKACq1zutwrM8izibRRRezP2Njrx8a6RvpLSSQu1D8YE2NiUPHt3NPOpPuGI2GQXVST0syw54IlgJYSUx63HWp3cDqhgW04orOj+BVDj2KC5QnUwGJi5yCZ+nB8g/Gtotlyc2oD+UIrP9caI4eaI7nKMXZQv0fdP1IE/Ntbmj/jOYSahyqN6wRFgUSpPoTr3W5WAChKDV8hvlEM0yq/XkUJTo11+7UI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(4326008)(316002)(66476007)(41300700001)(186003)(2906002)(110136005)(8676002)(66556008)(66946007)(8936002)(5660300002)(478600001)(6666004)(52116002)(6486002)(107886003)(26005)(1076003)(6512007)(83380400001)(36756003)(6506007)(2616005)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0sK3O/1VPecFEBG9APex0wLXjkOVhtqEK+dfuxoXDrECHyVIJD+Thqxq8crC?=
 =?us-ascii?Q?Kn6XKhIZru9eRJfU/tH2ezrjhwAR7HaSTFmBiOZl2r3FXr7JGnHWucYoqKyT?=
 =?us-ascii?Q?p670efw5zxvuuH7z62WK3BpIxCnkrpltfnE4uoljxgvkDIAvBel9FZ87wgIi?=
 =?us-ascii?Q?ItgDMmazkEVRFgg2RUv7eJ4UTJ4VxSNWq11UwYKJL1nOcK976O/yAm544ONi?=
 =?us-ascii?Q?9JoOu6Ryq9gW99CZVrOq1cnMsK7Ye8Bp4nTtHEQvlQRZBclbGgdGHSyUWPeh?=
 =?us-ascii?Q?HCKz0EA9EOiCJykYxpyp9wQ03oVU+MrFh07t2N4bxoDLTp5Te9hEqRbySWcB?=
 =?us-ascii?Q?N/JBNIl1XUwfiu0Ldc1C36iHS+it7Zde7f7nADuFTZswvc8zvOz8lY0XZyEd?=
 =?us-ascii?Q?fazd5doSmSkZon5uuqnSF64a/pLi/nC8fxqFQAK0Zza0asKrk2z3kn0XQjJy?=
 =?us-ascii?Q?Juy3iRyAoweJ5enErGMn88IQjtftLGGrrV1jfEi4aVswy08lyo5J7Mrb/EsJ?=
 =?us-ascii?Q?I/qYcSqhVm4hIpRZ5pFlF4YVQdB4FlSdeVT38HwELzUqfmFrKrLyLeAOyREs?=
 =?us-ascii?Q?kshG6nLoVrMRSXa6PukD+JrvNM2tj2HYoNeZIGeJn+OPLT6PCaPK/UzSHQnS?=
 =?us-ascii?Q?6cJuN5hkUDEez6y6GRIArRTDR2y++LlWL1XShFvMR/uiSef7242l5tQR3lRf?=
 =?us-ascii?Q?sogs6oHNcqs4m2ot/ZlB7Ff3dainGt/VT1zEwKREgS6APH2TZym4rIXE9n+h?=
 =?us-ascii?Q?G+M9PMFupnDsHZ05VxkzRH/XbqklJBRVjJchu2qX6XoB9pn2w1yGAXVZ82bS?=
 =?us-ascii?Q?OIIXHYR6ZUct/nuejXFa+yjPXwKBRhL2s2w01CFI5G6YpJIWgpq356wBp4t2?=
 =?us-ascii?Q?5XU/xi4y+fNjtnmwSuizm8l+1Ltg32UyebBMwWXrqlSLJu5ncyVuFcqVJvT4?=
 =?us-ascii?Q?R2ewuG03KzXW7yQzHvTPX/NTIldNI+wfAKZzJ345338w72WadwJBNameSBWn?=
 =?us-ascii?Q?wo6NXKIilbhv5MbEWaFW7yw109DKlCvy389MRbKUJgMhU7ai1U1RWuoN3UPW?=
 =?us-ascii?Q?+qeXbguW7g9Bef02mAU7oWuwVET5/jKAnMXwzWdiAW+tlg/bFEkxQh+X2DlN?=
 =?us-ascii?Q?bp6nyaCTcJ8RWrGYq3XPn6ulRd7KPIBo83os85YU1uYLhUc4XqXlBxtl3Txq?=
 =?us-ascii?Q?ivv8PsDNRFMwwePYcVr0W4zCc1iNyPK4ncE4VlphjjOsYPBaOEHT6jtPGvTE?=
 =?us-ascii?Q?/nGdso8bPA85LeoEGnVVVszqNHrgbvC4dHAoamNEL0jILI99pHYcghw2LRKk?=
 =?us-ascii?Q?4TJKeUOfAw9IUZOheZGtAlkwfmfNnAZrlUo155TA9ucdblyMuyzPmjbHB5YW?=
 =?us-ascii?Q?sYXOEtSsJBOwEtZI8OZmdqV9Zm63G8Ubf5u3xGbmUu22+gOdm0bW9koUk+7I?=
 =?us-ascii?Q?ShOsIKpNGBLTv5HTfIPYkyumIxG/BpwDD3vm/zswGg/5+OFbywRX8CBCAGcK?=
 =?us-ascii?Q?rlAMHeoWtCNkmWs1tGipWBTLreW39KdhzeyQ6KVZ3tixUl+9Hz9AlaSEPqDe?=
 =?us-ascii?Q?yIiJ934WAHXK2F4hPdQ1W3dmv6ce72uOG5KcVWNv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f47bc3-00d6-423b-b7cd-08db6cb1b7bd
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 08:31:15.2287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFQSw95+g509KBLEB58eHki1eeSbgao//JZ/Lj30Ots9KprfoacKHBu/IV0wvCnaqayUXX7aJJEjIgqOdcggYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4255
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This adds the async buffered write support to ext4,
the following is the relevant test data.

    iodepth      | 1    | 2    | 4    | 8    | 16   | 32   |
    before(M/s)  | 842  | 1047 | 1098 | 1167 | 1172 | 1247 |
    after(M/s)   | 1293 | 1674 | 1794 | 1862 | 1897 | 1833 |

The following is the fio configuration:

[global]
ioengine=io_uring
sqthread_poll=1
threads=1
iodepth=16
hipri=0
direct=0
fixedbufs=0
uncached=0
nowait=0
force_async=0
randrepeat=0
time_based=0
size=256M
filename=/data/test/local/io_uring_test
group_reporting
[read256B-rand]
bs=4096
rw=randwrite
numjobs=1

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/ext4/file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6a16d07965f9..5da7c5612324
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -288,9 +288,6 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 	ssize_t ret;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		return -EOPNOTSUPP;
-
 	inode_lock(inode);
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0)
@@ -905,7 +902,7 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
 			return ret;
 	}
 
-	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC |
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC |
 			FMODE_DIO_PARALLEL_WRITE;
 	return dquot_file_open(inode, filp);
 }
-- 
2.39.0

