Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E1162FF3C
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 22:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiKRVOU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 16:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiKRVOS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 16:14:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91DD2F662;
        Fri, 18 Nov 2022 13:14:16 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AILDmlG020587;
        Fri, 18 Nov 2022 21:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=TUaZMtelyMM0tHgnn/sWWR3GETgKe9NhofHbsObu7HE=;
 b=ht+9MLSkh5aqxmnemnuUtzXcrOxjQ49wlbw/e5CkXK11VBB7k1Le35APEVKM1vzSfUgb
 mA5tQ4Lvx0j5OPNqX4oIbv+pLz1vSmMN/XKmrldlhvVWl/9D2BGeH5pTOyf0cCDPNk5j
 Te7fMhZh9xjWUXH8ZFqZjomBSU/1OsjIQLsiXb+UVStbW5EN62yuiswtMo8Pp3n3y9tR
 FOWpvooQit6jWuhqx+xIoYCFn4fjb9VKIL+VG2lz9M2lJw3S71e9zBcy9yHJxxmeIpKw
 HuZnymJYT6KKLqfSZyxKuz0JxbpOAxiqwbTUyOb6pE3qK1QkGWcZKSokg1M1pmKWmSiC xA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxbrdh786-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 21:14:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AIL2RdR002057;
        Fri, 18 Nov 2022 21:14:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3kbymgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 21:14:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkZSBO8p0NtiQHgAu/1VKmkZc3B5i4ptnGmV5wJXONWO1tR+LusosjgCGHa3GhQlgNo8wL3MMFOlL17JZVqbzzuhyDUZE6kME/inemqCcXfMa783yMtrodatEcVqlmKRiw/TXtqbMci8+I3ehEuEvcazjU5XCLTBNeTDvmY+Ioq4FDnrenbe8DRCNAykAFZZ41hgaZLGFdmXNjPl9AaC7oTbb90YGmtKRjblCGVX0qx/e60xCi+lgyjVB9DtOnp923Jnv6XybqeY+b96cte6wMfPBTu8XsG68d2+eWtOU0BPSYP0aEockIPDdrhy5aF3WQJDwGQw0HODQv+qfzXhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUaZMtelyMM0tHgnn/sWWR3GETgKe9NhofHbsObu7HE=;
 b=Yvt1gbCrYZIB5J6yCKcWAEjp9w1BT8lsLpY7J9UXidpetMDCbEAXa3FDcXFSKRJgPuvyP9Fn/lKLP714M0Q2XMJQQTy9CIwcnZx47QsXsazFLKEP+ZYxohx7UDox5zbzPzlLxkU4XaZAZ9qybySucBm55+Z4Qepib2y6OBKELXT9AlDeHGo5RDJwrrUKhJe3vCuaw2/ZKEkHcEbuTCSX568SeNsAVBan456LDrclHqiviJ36HkdhiySOJWjefcO8Pz78bBGH56nITXBQGy5+OTQnwcPEox69LBcsnYt94IuTd+iiMed39iNfvECRmq9AUK8z4GzX6n+geIO6xtiaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUaZMtelyMM0tHgnn/sWWR3GETgKe9NhofHbsObu7HE=;
 b=cFtd8E3ei22ntz0dTdLtsseAcsmGUvKKBjmZo+NpUC/t3ICE1M69VQK4zeMtMzRViBPp1g/8H4qJkIEIF8nV8pWqp66oPIi5kOFXlvGTxjD8hbQtGeH2fVDxaFvhu7CC9NDYGMOyjLDtDntowlVV6FDK4qYuwoSSxxKcVTUa47w=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by SA1PR10MB6520.namprd10.prod.outlook.com (2603:10b6:806:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 21:14:13 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::e1d1:c1c7:79d:4137]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::e1d1:c1c7:79d:4137%4]) with mapi id 15.20.5834.009; Fri, 18 Nov 2022
 21:14:12 +0000
From:   Catherine Hoang <catherine.hoang@oracle.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH v2 1/2] fs: hoist get/set UUID ioctls
Date:   Fri, 18 Nov 2022 13:14:07 -0800
Message-Id: <20221118211408.72796-2-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221118211408.72796-1-catherine.hoang@oracle.com>
References: <20221118211408.72796-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:a03:331::28) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|SA1PR10MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 529680e7-e1ba-4511-125c-08dac9a9d74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M07tNut9b6ta1PLta/bl/WJeMPXZSoid82XGpdxKkblxVS1wMkBA8c2YePhBhHw77uMUBY+DaWymEtiaweP99IlICF+muNMdQVaqnOGJPnYjwHCGRC1Ptggom2CEzt907ZVBAih4i+k6BuU6QO+69SpD+iKfsjQ4+aN/AOXgG2hSwyekSdsBEO8tohNgIfOSW0AoX19xr/XzuEUA423+sM2I/H7IIJS7n3IiE3Oz8Od5As6NjfsuKJ3WQQ8mCAFQXgckkjRRQX/Zjd0kgoiKgKZXYNHOCWXit1kgtsqprJIVa0yfGDdKI+ct1BOKzo+gzyVXLPN2lRV9MF6fRRgm61JEUvrmEsNGuxHYbS5v+rIVi/+1U6mLJjQGotnHIJa04tj2QKQwRLNsvAV6WxZfb1GpKrb8D2mvWOICvDazEEzujILKztpObz1GEJQR4hUwfZR13fW9/AAb80GV6PZlV1ZTxcgUZ1sj0NesBk+4mXyj3H4ehKjjfPAX0ilpc1hwPsG0I4oIhNylWl0Whv9XZyOvEViIlasyA4NnmDwOHCH8xSZIBjemLMAACjVghIaTevxLSNepv7M5btO112pWA0IFyvDk+2qyMoURepBcJWClTu32ctX4YV/llfERpabcvHR715CFOP8Z2cfZxCM8gA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(6486002)(6506007)(6666004)(478600001)(6916009)(2616005)(186003)(450100002)(86362001)(83380400001)(8936002)(316002)(6512007)(66556008)(66946007)(38100700002)(66476007)(41300700001)(2906002)(4326008)(44832011)(1076003)(36756003)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2leakRz8ACP5zMqaIzSmDjiArVX9ql5FpRIdDVjiRWdacPoi5ZkWGSP3r+w3?=
 =?us-ascii?Q?XuioRN0zY03zmE1pSCIb465yq+4EZfL+xDpd9RswqXNjmWyGG2wtRFLNz9xX?=
 =?us-ascii?Q?aj/fxb3KuSS/+w6FHAQ2bbDFG0ba6MFlF5X6Wxip8bwlTRTRtKdo2IbGPmcu?=
 =?us-ascii?Q?xO5OGfC11KQNxKSzrK8cy0Qdzj/j3z4WhFO79UaK068PC+Qy1IGMGuTiIf23?=
 =?us-ascii?Q?GQToxC3S27uCN/yZAdl8My1uezoJucytwbMwOrL8sI1YqRGlYb+1b3yEJbPx?=
 =?us-ascii?Q?rdlUooOkoA7yqRqDp1cTJ1LbR2yNK0Wumrg8FHDXIu4iszWGh8z05O2T/UEo?=
 =?us-ascii?Q?7tLY9c3LcU4UtPL5rwWLyAhK5nvPsUbzkzoU6oapp29pB0+2FNFC6Wz1UX5f?=
 =?us-ascii?Q?6CkanY7IugRnWaQMGlWqLpCXHvCErOmBaDMZEnd22yGJYXZY1w728FTQvE0B?=
 =?us-ascii?Q?VDXcTKh9v2vliZfhOh4PSz9DG5Ff+9xEKozlDEi+0nxxcQBqEGvSHBOD6SBD?=
 =?us-ascii?Q?299rYyvmEkYshJigzjEaLKPnad/k5wB4Qo1RcjqSG2USSre66BO5Zu+YM1E6?=
 =?us-ascii?Q?l1iYKyAOY1LxKL4Wk2faMC5cNP0nB6FHNk1HpVS7nordyvDXObGsLmCYRS+l?=
 =?us-ascii?Q?HyT/9qogBq9lVuA91eS2tfaH1EmftpUysnoeL/SZxG26JRFXcoEAeuTe0Bjn?=
 =?us-ascii?Q?j2xiWYqERKk8hD5n3JJ4k6qB2sHNI6NZeumE9ZyyZS6dR82nekyT4KvlHYUV?=
 =?us-ascii?Q?qU18DkZusXkvXGwoBrlnytG/cvnfJiNEMKeRsEIlaGtXMiVMdNeyhckpIXU3?=
 =?us-ascii?Q?QTndX1OntENUX3tgxfcLon2QRRyzb+nwRdMkGF8Xs+ypJinvjX/NGiOm8ZV5?=
 =?us-ascii?Q?rWjnkB8/pAriRHFWraa42aNgHh7jJypssloSbzZcoFApThw1rAWG2ZHC53vj?=
 =?us-ascii?Q?6M1KhBoAD35LUocMzhufRpo5jNTxmsoMx94ByCSrNBB5sZ0k0eTTn+pxPUKz?=
 =?us-ascii?Q?mCbSqWzXAqJem2gRk5PfO1W2Ods9UAKAIr9sBSURyWkc6+Vj7gxhkTspAn2Q?=
 =?us-ascii?Q?ZE6l/37c6LrUPkZH8u+VIkHNX7cN8T/yDNuXxrnxVkH2G6pTddh2ZsOFdf8v?=
 =?us-ascii?Q?KYhal0PzZvE5CtF6rmfRcegzKxgVQlRi3E6g1TA0x45AU4R0Nc92Lkctpgce?=
 =?us-ascii?Q?lGUBY/NLLm9TCC6noPBOVzYXhWvIAV41xgQ8AKqifcVWBVxIDkTCteQaNIlD?=
 =?us-ascii?Q?SwSCq58gNLpvLQ9SNWuaUeMbteW0KGotYdFI5YBQ34xRkrxM4jzk5bfmSaAD?=
 =?us-ascii?Q?V2FLMXHItZAjQZpAqMA5D+7Ma9PbdF9sVwVNKwO5mxkdWX5pUIfkcLTwxvIQ?=
 =?us-ascii?Q?yCfV9SrK2REgnPvPC5pSozmFCdrLdfOO5Ik4PQ8jMXIeN5I8jqsXXTnuFS9Z?=
 =?us-ascii?Q?32p8K/1eomVsDtE+ndIWMUFMIRgEIaiis/9IwcJ5FNQtTv9o/Q1WkDEpnM17?=
 =?us-ascii?Q?2CKBjJjw+7+bb+Gi+s2mJlfE9PaIpmHomYAYWJh3ySKTdSQSymD9Su3k7eY6?=
 =?us-ascii?Q?fnkjbt4YoWQDZMpiY2KI6sXXoPSbe5KbGC/96UKCQZ3aXCBQTMLgkPd1C7h9?=
 =?us-ascii?Q?Kc80TsTXE1KNENY/YxflNkZ/9UQREGrsndJVEku+XPSlEAjVDHWBu1tFHVlm?=
 =?us-ascii?Q?HLeflw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jzQukJ1SKDXbaA5c4Zq2pdAIYzAd8PMTZf65BJzoi38q6yR83fVMvQp5vv96rwQkK8GrwgY3XSQwEw2dJDUmTtl8iYu4tm8k/HnqaYMfAf7+PrlEFwZGptt3YJ/4WFH9xIhQYeEzdTJmgfJlhAY2Qn5hKR+QQi+wv8Q92yAuN8DHZ+Q2dz0i4a81jDQ1y4tHfIAIhqJnFN3WwQA0IOiuFlktKRnRSqOJD/RsyTaCDvSImjEjgCnCmtVmiMpIFJNxlrx6zEOFLPF75KdWE4i6tSxqOxwNesu370HbkpUz6uMGwv8PIaPA6LoAQqmaDzj1K8LajH+cvx6EVQx8KCdAeJuLud3KBT5KlIEhCpJ81L8VevJk61649vP4haVWqp1ucKzZ4sfAHryf4PVxq1Z+wOPCn3ENVAVANtB+KlAg/QJNPWCLW0anC/VD98mer3V0/F6JUZmedVO24afs3VS9N1OjLwT9lMYt1tbGmw6V2DmdO5/zOtIVvsVoHwZiy0uYuUT//MjTETCadNAgRle/F7Z6G5CmfG9o80qlOjVICMP0xdSFn9pi2mfpu9zrBxFHmX3OwQ8KsxbDdoRM9b9eYYI0Dhg/G5LBefrICne6Gw2LqSaI/1jq5vw1rp7TOSRKgjUv44F/awblrQm03MD8AngXBYBuvHYTFxacbKI9P5+Fz3a4fmVEetezzFXySZCgwfDl/N+1yFd4m1tgiU/8C+KvvZO/6EMXoOrwivtc6slqrJC3erH6xZLt2Sio5kSOLS2TzTrCmU68iJOV8rKuFc0KStk1LHcWDMMRcY5b31HyqAiyZll8Yqge2pzNvU5D
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529680e7-e1ba-4511-125c-08dac9a9d74c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 21:14:12.7901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTUCQlfdQPL9NgHdhDoPL6/HQT+rUJB/ghig9rcOrBRJBMsWdBLV2FN9kohchiGNQTAADp1X8QTnnnELQUjRlolE4B4rZrAd5xkhVoJe4ZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_07,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211180126
X-Proofpoint-GUID: nUQJneKmfI_vQVbHC09J4M2tDrCkDzI_
X-Proofpoint-ORIG-GUID: nUQJneKmfI_vQVbHC09J4M2tDrCkDzI_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hoist the EXT4_IOC_[GS]ETFSUUID ioctls so that they can be used by all
filesystems. This allows us to have a common interface for tools such as
coreutils.

Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
---
 fs/ext4/ext4.h          | 13 ++-----------
 include/uapi/linux/fs.h | 11 +++++++++++
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8d5453852f98..b200302a3732 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -722,8 +722,8 @@ enum {
 #define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
 #define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
 #define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u32)
-#define EXT4_IOC_GETFSUUID		_IOR('f', 44, struct fsuuid)
-#define EXT4_IOC_SETFSUUID		_IOW('f', 44, struct fsuuid)
+#define EXT4_IOC_GETFSUUID		FS_IOC_GETFSUUID
+#define EXT4_IOC_SETFSUUID		FS_IOC_SETFSUUID
 
 #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
 
@@ -753,15 +753,6 @@ enum {
 						EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT | \
 						EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
 
-/*
- * Structure for EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID
- */
-struct fsuuid {
-	__u32       fsu_len;
-	__u32       fsu_flags;
-	__u8        fsu_uuid[];
-};
-
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
  * ioctl commands in 32 bit emulation
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index b7b56871029c..63b925444592 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -121,6 +121,15 @@ struct fsxattr {
 	unsigned char	fsx_pad[8];
 };
 
+/*
+ * Structure for FS_IOC_GETFSUUID/FS_IOC_SETFSUUID
+ */
+struct fsuuid {
+	__u32       fsu_len;
+	__u32       fsu_flags;
+	__u8        fsu_uuid[];
+};
+
 /*
  * Flags for the fsx_xflags field
  */
@@ -215,6 +224,8 @@ struct fsxattr {
 #define FS_IOC_FSSETXATTR		_IOW('X', 32, struct fsxattr)
 #define FS_IOC_GETFSLABEL		_IOR(0x94, 49, char[FSLABEL_MAX])
 #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
+#define FS_IOC_GETFSUUID		_IOR('f', 44, struct fsuuid)
+#define FS_IOC_SETFSUUID		_IOW('f', 44, struct fsuuid)
 
 /*
  * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
-- 
2.25.1

