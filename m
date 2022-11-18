Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9F762FF4B
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 22:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiKRVTW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 16:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiKRVTV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 16:19:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D417EC8F;
        Fri, 18 Nov 2022 13:19:20 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AILFWL9026678;
        Fri, 18 Nov 2022 21:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=AGBzb0qoY2kPaj7vwIJjQAoapeX92QI7ozSgEvCM4eY=;
 b=N/JNASywes2cJsSrH6sGugnSw+0+TyK58WYI0Xji2+Nx40TgYvuce19x/OFCPbwg72Jj
 wTLGLpC4iddJuoj8LfuGfpVTFyOqLWYrCl23yLMg0LLE5dXnnTu3E+adUtacOHbf6PvW
 0ds12O38QMBAB3Uh7mYTJJhZotGeHTnV84j+dd+cmeR0K9HTeHjDJTPAZUWfNhQeitUB
 VwRqmw/NvP1RDbhb7h3EDv3OmO9lJQx+kv2bskxGb/qidScf22ARXFFWQzHPjkRSmLa7
 +8VpFHwhdFwUw9fqj2xWzwGdyIeZ8vAx/NSBV2ddpV4KcXb1GagX2PR5t6exlWSpJsBk 8Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxbub95g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 21:19:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AIL0Aoo039112;
        Fri, 18 Nov 2022 21:14:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kw2dfk255-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 21:14:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6B+XuysiP3y744oGoyMfKC3GvOinL4HUOZzNarBl7WV3I7vFDrk6fKeSiFK3wqMV8TCTZGl0Y5dbqsJWrwr0GazB+ZVxYeqt4xhbgvajNAA49pdZf96URUzXX+3GAK3onC0vFmHviDG4qh+czDovPjoAOzE0y89M1eoc6kV+i79QZdFZM/uJRSoFbwgbjd8OhU4DBl+ZXJQlF5lNEScoTJhHdI8/6KTd4rGRWODF3rOI83x+OACR/+Cv3Qr739g9BzBdia+EXx6wabHXQY6BH0ERQFE0WQLZSsyfSNdwzG+nxJRWbqzTpGfh5tp48zuhNBB4rd9zihDKZmj1ZXp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGBzb0qoY2kPaj7vwIJjQAoapeX92QI7ozSgEvCM4eY=;
 b=dWYdmYVIgEHCFqUXqHqseZjPl7ZlOe5FHhvTS0HlZ6hhgKO+QJ/EkJ+7j36m2AIG5+gzfG3OKXJsd85L8kxhtkVm3ot22C5rae/is0bysfnt8InP8ZIABUITZqZuD9gwnpVT8m8YwK0Ewe4lgkH4Ad3BYBtH4Nc+nJ/9151qaENoleGZ+/pEyTuMIr/SGTyKrchaG6BcB0pAxYrd8PA0DCdSEEIP4NJuUekPd5MuHbqkFuC6xTMLURg8bHz5BJlV0x4Vff3RHH1ZqXBXPy/4CZsj6KS0Oj4tcGiBTADSX8KspwUNWvORJc0aSZUR2xAqIll+nHiPu2YFo2NmPe9W5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGBzb0qoY2kPaj7vwIJjQAoapeX92QI7ozSgEvCM4eY=;
 b=pELFdlHnx7UKx4NecfWkwtDubnEsMHBo/w6h4XVm0a+CbRIWetbKstXOYAmhkQPGzy9hMwFcPY//bEUmmbdksJCO5n205MffReRrArjvPbE4zhHPJMtx0HdYHptnAd2PfTBKuW6eJF5sN4lxcLc0lmtycxGOxH8lTFFXEa2BXAE=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by SA1PR10MB6520.namprd10.prod.outlook.com (2603:10b6:806:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 21:14:15 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::e1d1:c1c7:79d:4137]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::e1d1:c1c7:79d:4137%4]) with mapi id 15.20.5834.009; Fri, 18 Nov 2022
 21:14:15 +0000
From:   Catherine Hoang <catherine.hoang@oracle.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH v2 2/2] xfs: add FS_IOC_GETFSUUID ioctl
Date:   Fri, 18 Nov 2022 13:14:08 -0800
Message-Id: <20221118211408.72796-3-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221118211408.72796-1-catherine.hoang@oracle.com>
References: <20221118211408.72796-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:a03:331::6) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|SA1PR10MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8e634b-a25f-4522-3d49-08dac9a9d8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQSKQb7ykLcVaMWGKj9J7wvl+2n7DuK35kOXMX9fm8wKd1TLa803/2wXv39SINKYg8UzlP/iyXd3wwBr+RDQA9eccRBMLRSXR1LGLyH8BFoFHawH24/tEz6uQFiNr87e9DlKcRij84pr51BcVs1685G9IwGphSgEkQV6pY3K3T/ripeCehBD6rqi6ffUSeQYFETqDgf0cu43k38Stnp0RcgXkfNVkAfmayDc09oPQFQ3sDAiwL96lXqwUbDemjsdGjE8peDht3vgtDFT8w2iQ/TEvanv03HLpsZDvpLhQuYQJqHfEoguP2bISamq5yl82Voh2HSfzFSic3nJNkbV3ifTB+MaphPpvOuz+xaFzZ6G/UaHu7IAzzhRgM6PUeUKk6Ly+O/VP19ccbQ1tICY4yDLt9NpqXFbp7bI0NUUMuB4aEVuKTXBp00ajxDZrrTF4Un1rpX2os9EzA9LIAVgwlNuDdhAHLeBTBReVbhYyOwp3pKn3vRIYG9trmIvRduqueYJcZWhvL9lVswiRxkX62bV4vVMRcaG+69pkxhmCdTzc+LK4rWMP6d55BGLaqyss8V5bK6v6Y1DU7CKSOBCwEFzsme/LyCC4bIQYpMwAbX4IBO2v1uHNMJNDNA4tZzVkQk72AVZgGC7UsvWkLWLvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(6486002)(6506007)(6666004)(478600001)(6916009)(2616005)(186003)(450100002)(86362001)(83380400001)(8936002)(316002)(6512007)(66556008)(66946007)(38100700002)(66476007)(41300700001)(2906002)(4326008)(44832011)(1076003)(36756003)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Ym6vtUCVCZhvzpcj89j6L4NGvGPQgmh9j3RNJgZmW1HDy/CRH4zRe/96F0i?=
 =?us-ascii?Q?6FBfp2k3frKrlveh6U5kuQjkHmBITFZjZhLE8KQxVjiFWCY55yNOQ37c+Uql?=
 =?us-ascii?Q?iCz0HUQpWaP0jzdqumI33T4NsumE6P+ebXuxoXzYzVgk37j6yNLX3mQ/bAg4?=
 =?us-ascii?Q?RtFu0OIkxmOTPSw0KoY4d6hg6IF37QNVWTnOJd+dR79Qlc3wP/gA18NbWar2?=
 =?us-ascii?Q?4qJNKFdJXJcaFmwkhDCOjeltVUw5xdpnovIkwm75uYxtnJnJULlUC1/BZt0w?=
 =?us-ascii?Q?0CJmxIPJ0N10/DRSTPAZtsUl9iUaA30uQO3ybYIy0IdDguYgzEhtqo3Y6JRc?=
 =?us-ascii?Q?G8BqmZND0p83vvaiXeElyTavpBD8AyuqS2KGAV6ZuiErn6wgOYK1nbISBB1z?=
 =?us-ascii?Q?uoOpTfQquSfu1x13tUd4kogBi7TTi4Lm/w8rND7nUAG7E8fSMthY6wtc3rYs?=
 =?us-ascii?Q?naKsgPiRL0fZl1so3vR12Unc6vFEp4OSLVJswjATQ8lHss+Ung6dAAzHkuPb?=
 =?us-ascii?Q?CvgsCV3hmTUgU7JuGWsVT/y+KydVfuvU6H/RB7yNOvQbZ+IeoifGUceSdoh/?=
 =?us-ascii?Q?VRzuDsR1ay9bxm+mIs7J7aM0JGV6GxBPnW8ERpG9NCs5ZNNPSbWelhQTxtvk?=
 =?us-ascii?Q?ujJ0l7xEl5JfOeB7os4YHLPFj1iBxdAexNxsef7pkNCUoJ8+12iFfbNpNJSB?=
 =?us-ascii?Q?vprDWrP0zzFplXXxAboQry/O+km4jTFkeEIZXu5uj8YwK8AhuCdKzf06ZuA+?=
 =?us-ascii?Q?/esn81804HCn7P4wkisY6LoEg2PrZj51RNq+4qdX6zgX4Kr9yzYXk9ve7Jqj?=
 =?us-ascii?Q?baWBGWM1xs22L2zDjwo1kKkP1mRtVxqk7yk++obQotT0LLofNETSjAkWGjgT?=
 =?us-ascii?Q?MxWZECPEU/LQVoFVyS33Y1H9IMr6KAtE7jmzBTEN4vjNMHQC2ySCCYpG/3BX?=
 =?us-ascii?Q?Y0BwyGv0thoUSlf3ecWcs4yXtQ0q0fgTQsXNz/obkmTIyGCEWOqw7/XmTGyo?=
 =?us-ascii?Q?zbLkNOrMK/cKiXiy8ezEYEdvs/s333Ldo+KtTjvtA2WPJz7wMurdyrF9l3MZ?=
 =?us-ascii?Q?GgQ2bmc26ECE2YPrhQ9jy8qC1kPw7bauEZ9SUk6Z7zL5ztQJszdtV4eSf2U6?=
 =?us-ascii?Q?lQPZqWpjvBheOaE7ce0fVDGCcE689/8eMQAPLn8keugjBtM4p1dicZcnZ9l0?=
 =?us-ascii?Q?R4AYDrqp2bEOMSXTLq7dtUgY92kB64WzOeUINB0LEG+xUsZy+V21wzmWshhX?=
 =?us-ascii?Q?9FULM/0oykzVjOWkhcXhsIGZDjJ2tuqRTqA4DaaGkAb/6901jNNFGw8ZRFv/?=
 =?us-ascii?Q?T1kwxGCxQWS+cMF4ktz/nAHq5/Cf1qw0hDhCoVGtomOYUP9hIWMfJf+/FhnH?=
 =?us-ascii?Q?KTvaxwmprOGKgPK/hT9Blig6lMqIk6Qjp61uYUCsTNv7wgxKBY5Enea4nC8z?=
 =?us-ascii?Q?B5D3jNWA+vEFHw3Ls9YknWpWkzqQSJHbqRX5X9IyryLH0cO6MJ5SO9bEPsZu?=
 =?us-ascii?Q?k0ZywDeoTXXeVV93PnrUUuGzG3e4Rn6+cvx+Jr/CZn8LYBkJb+n2MmRDgcFX?=
 =?us-ascii?Q?+HCMkuqrbZd3yewmpCZ+d+BGcKxBupNhihQ+ugDdOw4ahtO4seRfGFxUXN8+?=
 =?us-ascii?Q?vaStkg1W98BOEfi4YkbXU87tzDZiRnq5aPnul60ewMCeeUl7rXiZvOnhf0wH?=
 =?us-ascii?Q?HvXT4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i+K+3f1VQwb4b6OtM4IcilpID/kFSnNqeecDT4Ft69v8zD/LOyLV8mjnObME/l9y5gNf1nAprZo0ec1uP6FMumdD9WMlBrMO3NHnvZvp21lIkNK9eUb5xrcAhHUzdkM608S7Tvj8CdGmh9pwk4ZkGRS2n82q9qep8iZHu2soSEbvPaumOZHp8PBZnIRK/3sb0BZ2T3J+vtLx5luHJAQfyXlOMiz/ysdc74TOo2aNvRZbUFACp2Uz3DopnlZll6kjW4TOpddSwPAZmMVGZKUNwOZU32vjQU1NZUY9IY4Pka+bmhqHeHttzYTktH4GtViki4x6o8hbG//+wkU+aH6YF4bhV6DPYjpeNXUkRP3qqljL5nCqq+dFj525kXMfZy72xAURmRGGL3L7jL/2OaFj6aNb4H7mGF4h8uIiQP6RiGxbRWFzBWyK1qmIVJPxf9PWaHifSrfALN4q3IM3vYOw9P8IEk037sd8yejGzT76KXzJ4FppVQLXmv//NBimvd15A6aHjJ3kFV4bFtNmhhR+vW5ZfXTzGHR+ggSu9rSughTqdu1n69hTsXOgLEnVQt5P3uWRhAXPnqK1ydp0sKEXosVXirV2hBc1rL/JQb2BxrCtlBFHJZa1yeKo+SI6PgDPip3v/oCt01dksaPdyK7KaKV4KOwpIZSYb8jIO7lHvSNoHOwhZE7lSkk2Wa0t9bvYDvPL965rrmexhsbnk4F0tk3NqmyQ63MfyLIEq8+TKmKSrWiH1tiyA1jBb15bBtvQCu0hY6/ofN4GrIWbadfaBpV62bIhFIEkfqzr9JR8jDhAxBDW5YeQAzv3QNGs+y0g
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8e634b-a25f-4522-3d49-08dac9a9d8bb
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 21:14:15.0714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GMFVL9y6bdoL8hv9BcXdksY/HmI3toXin0FnpajpkC9zwaZCsPbuTnKTup5+TAZ3182XW8/9gMxYM+3uNmJJl5x5OOCSpxP10XKqWccyFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_07,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180126
X-Proofpoint-ORIG-GUID: 0RZd1o8KCFmHsvwvIYd0aryhCkC5bYvt
X-Proofpoint-GUID: 0RZd1o8KCFmHsvwvIYd0aryhCkC5bYvt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add a new ioctl to retrieve the UUID of a mounted xfs filesystem. This is a
precursor to adding the SETFSUUID ioctl.

Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
---
 fs/xfs/xfs_ioctl.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 1f783e979629..cf77715afe9e 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1865,6 +1865,39 @@ xfs_fs_eofblocks_from_user(
 	return 0;
 }
 
+static int
+xfs_ioctl_getuuid(
+	struct xfs_mount	*mp,
+	struct fsuuid __user	*ufsuuid)
+{
+	struct fsuuid		fsuuid;
+	__u8			uuid[UUID_SIZE];
+
+	if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
+		return -EFAULT;
+
+	if (fsuuid.fsu_len == 0) {
+		fsuuid.fsu_len = UUID_SIZE;
+		if (copy_to_user(&ufsuuid->fsu_len, &fsuuid.fsu_len,
+					sizeof(fsuuid.fsu_len)))
+			return -EFAULT;
+		return 0;
+	}
+
+	if (fsuuid.fsu_len < UUID_SIZE || fsuuid.fsu_flags != 0)
+		return -EINVAL;
+
+	spin_lock(&mp->m_sb_lock);
+	memcpy(uuid, &mp->m_sb.sb_uuid, UUID_SIZE);
+	spin_unlock(&mp->m_sb_lock);
+
+	fsuuid.fsu_len = UUID_SIZE;
+	if (copy_to_user(ufsuuid, &fsuuid, sizeof(fsuuid)) ||
+	    copy_to_user(&ufsuuid->fsu_uuid[0], uuid, UUID_SIZE))
+		return -EFAULT;
+	return 0;
+}
+
 /*
  * These long-unused ioctls were removed from the official ioctl API in 5.17,
  * but retain these definitions so that we can log warnings about them.
@@ -2153,6 +2186,9 @@ xfs_file_ioctl(
 		return error;
 	}
 
+	case FS_IOC_GETFSUUID:
+		return xfs_ioctl_getuuid(mp, arg);
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.25.1

