Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E562FF3B
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 22:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiKRVOS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 16:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiKRVOR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 16:14:17 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7903227CDB;
        Fri, 18 Nov 2022 13:14:14 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AILDlIa020577;
        Fri, 18 Nov 2022 21:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=xVlRLKqWEc7YfLZJBVoi+wsOYdIU1BC1hDFJmF3gTc0=;
 b=w/BQTiNto8UDnrmgagYiq2fxQZjqmdQUlQ5SvoP6xa1Frza8iQWuxoA0QMdfLQkbuG3b
 uRsunEnIyNX5dTH1WHfj8s7Hyqumb+d3IPhI/E/jlb6yqaVljrcjq8FKCKfmDzVCGJjC
 7NHw3dOEfctYi8UdNBgLyq1GHDoCVfIT31zOZV5BzV4Ynppr9xwHOJKsAb3SkRZrdtxW
 FYr4vPmWiz1lhuCOm+hLl2BSaMiZHeP+xW9VBtPEDRKIg2kiJa4/nDGky6WIlw7JowNZ
 WAWPiY1RDubZHEOE3HLrpEI3FIbVlt1dxEYRTsPeBTGOlqc27mqp7TxB5ii5/QtWa//R +A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kxbrdh77y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 21:14:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AIL1HVt039202;
        Fri, 18 Nov 2022 21:14:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kw2dfk23j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 21:14:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iq35CKHJrLI7517Iki87eOvW5sKrsvcYA7P4c7uP1CjX+LTVnt8QvLRpoe+xizXkmegbzRi6kFA45PZKezOuhzzqH1v01sGPenFjEeIYwHllgOHVKcNlbJJr2ier+Iw0srV0i4wQ3bck9ox8v53y+CDhT+h3RNAR9ojfj7aKcBCP0/k0AnOHla6j2mxJqAm17pXwA8sXCibVfotapBBJMwZStSwG5PDIWBB5f17IakXSxMRsN8L6scui4P1R/GPbhgrND7w3684qSGlbOYxGS3r208Zuh0IbighdnzwYqVsAI/hUgkKZGBbnbES4sSqrmGCWO4s2hKiWy7Y7dqhVgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVlRLKqWEc7YfLZJBVoi+wsOYdIU1BC1hDFJmF3gTc0=;
 b=IF4WBAserfUFCi/2Z6FrXRPpyCp4tzRiYpX4MkpOQLcFj+UMh0W90PtqYDz3Gr6lfQ/4++eYI7liJQGqkf2HOnZfvVbfa4O3hSqSR2gyKwnr6E0+c+6D8VUAXRGtBaZZN7oBfDzKcLEuFgGSGkl4efazFRRbea3kf70tov+EDONUopUr8PgCLOixUEWqlq5VUOIJpvY/nWF1HAjYE/dHwJoSxnn9cuhkYTHLKWQKxptgm/bS2UM3o6w1Jk2TU6P08JA2LA/PMiG/UXvEABeRXB4JL10mO+rij1gB3L8PRe0vdSq6zI9EAfyH0NDYgomrBqUiGEsWijNpSZRZGDmqaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVlRLKqWEc7YfLZJBVoi+wsOYdIU1BC1hDFJmF3gTc0=;
 b=hyYjLWmrYj6yZQAsOKJk6y8A3E5LbrBkILJ4cczSK8YkJyUdu5ti/Y6nJvlqa4RGHfaS7OS43zLFNgYh8g3r4sQ9QkN3Z8AVEHBlM50lWDDE/L4SbSyOvaGZt3F0yH0poGXgCzZgCa1YT/SYm7bmolYaud4ImcGb+hk8MX/5qH4=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by SA1PR10MB6293.namprd10.prod.outlook.com (2603:10b6:806:250::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 21:14:10 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::e1d1:c1c7:79d:4137]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::e1d1:c1c7:79d:4137%4]) with mapi id 15.20.5834.009; Fri, 18 Nov 2022
 21:14:10 +0000
From:   Catherine Hoang <catherine.hoang@oracle.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH v2 0/2] porting the GETFSUUID ioctl to xfs
Date:   Fri, 18 Nov 2022 13:14:06 -0800
Message-Id: <20221118211408.72796-1-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|SA1PR10MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: da640470-2b35-4c9f-9572-08dac9a9d5f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiN4jOjcqOWq5puNxwQRQYvIeOjNkqbeIGdup9Hg+Cr9dquhRXkBnfaF3ZGAGsWcCrSSoztGeYtRmhznJ3WFb7NSXSVrtp/WxxkQL1lhKC3QVuBY1s4kThfv1hDCe8VExfH5PBAmHRuZuX/EZPSVXpDIn+PHSU5Uhq2AAiLwyMVFt6kWm3f7eaQSkSvZvF1bRCrCKIyv6Aw7ZqMilZOy8LsyQN4vYUjjo949Lgm5ykMGlPs5MLH/1wnxkCjCYj6vwddhcm5M7YQ8uWClNQqSRojEi1v/wEni9irtRmjmYF4Xs9mpBaBoxNqIxZF+CYJQZnQh3SiOBcQ/NvgIcjWoEcMEmE8NeAc2JHTQbTQd+e1BxeSLwq+j+3GyW6IL8CRkm8+bYNuT28dhP5mnVqZfjFQQex0JLrZ8tHIysZoT430laKB9UXHC/UKIJCippWcz+r5zbSdTDkQbiW6QbunFIgOxfN8dCs1vLksybfK0DHU/QCAudS3/OlP3obBuQeauwiu+kCfIMesmec0GP/MbMPHEpSDY+9mYNob5CMinTemBx064P6KM61K2Dd7sDPfVyBE2B3xtjNmthW9pYkSm1zjgC22YM3Ny4tXnJaVhchf7P7Z1eQphj59qGdZ8KPcBz2bonYBGiq2RJm1S5/RDAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199015)(2906002)(36756003)(316002)(6916009)(478600001)(6486002)(83380400001)(38100700002)(6506007)(6666004)(6512007)(86362001)(2616005)(1076003)(186003)(8676002)(66946007)(66476007)(66556008)(4744005)(5660300002)(450100002)(44832011)(8936002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qhU3hikNgobu3gNTddIynP4Plh1eC2VJNo7xpG/gBwSF/3zkikNCtRTDbysz?=
 =?us-ascii?Q?s1+KQgPO8SC0+Aol99m4iT5mDLRrcb+1g7QRkgxn7RckVRQGyMZz3Q1BeJOL?=
 =?us-ascii?Q?tzZIVHsNaeM5ZG1Wlk/eTw0CavUPCRGI1vSkYu5w+mVARNeEk7/L5L+J57e5?=
 =?us-ascii?Q?0S4QhG0E+Z65k2AOIrpYgFqFkkI+MN7kSQ1CDRsmnA3Igz3YmlWcbBLsj9qR?=
 =?us-ascii?Q?HpdnBOcuZ7/448VIgoxweG5tCVONmLWn2Xl+9uV9sqcu2UnavEGSE/thsqLy?=
 =?us-ascii?Q?3ffR7vvjvcvOruw1WxPMh3OLYMcNiccl7LRDYPIyFCqEMQSZh5XTXL1FrE4a?=
 =?us-ascii?Q?UAagiwFdasUvAeknYK9kbXAZRmslxJidMOKs4dg+3IqSHBmmtM2pBHTYRoQK?=
 =?us-ascii?Q?PiAV8HQOrsPpa8fOfwTn0r9TcV/uU49yigPY9ElzUSi6cdnLYSjjGdQfxuFa?=
 =?us-ascii?Q?PYdCDdS/Y50u6fZmNG4zwIM3LzlU38lTLdPemcoXZhdO7bl11cqdDwOsM4Ka?=
 =?us-ascii?Q?rUigEv1UAjx77U0M4dw1g0svDgJgePNzPZ6WAVnfWxalMpQwByinFY0OSjXU?=
 =?us-ascii?Q?VY7zFmcUIxI0rdc3M16vp6Iw8JAjgT0m7sYYyVSxBuIVo9aBJJ+OmNNuZwTV?=
 =?us-ascii?Q?hFqzHdzlgDfn+AxVcuwnyKfr3KHoslUhxLIQVIZOoNH/N9Dth5wmbGY4CsFB?=
 =?us-ascii?Q?NM3hYpd3X7k8kYr1xpG6KLKFCdfeVo6h25Hx7ZPhCTAJZ1X5IrD1oZFrybkK?=
 =?us-ascii?Q?Z5VwVvRXkhfij9Nq2geSB8pvWXxZyaXy7PXCQ9qi/DmsivJBcFxNZ+L+OPRb?=
 =?us-ascii?Q?ssBsCyqTg5D7jHE8X+DV8VnskVrcCzCPdcHkXrmvGx1VMyfOgQXlTwElmxBK?=
 =?us-ascii?Q?WNgEyyD8kTsdD3Ksq+Z1FYWrEXSKooTn0S1Vujfvc38YFfeq8bN2C1+AV7W+?=
 =?us-ascii?Q?h+6+mkhDVmANilL/uThVZf8dfhhHUxqkA0bwzN236CA5cDELckL6NdunIWdB?=
 =?us-ascii?Q?qrqURC8tdvVblhUzpNHgz45d0bpu6Cco6577HVzrFzfzIqgnizvDNjrd47xa?=
 =?us-ascii?Q?lIY7z4HQ+ZV88NZVoxif17gRQ89fcUtWsNN0SS+WakaYlcCIdEG+mHSPNazW?=
 =?us-ascii?Q?34KkHcWin0j4dEbUwxlH+kwi+67fsWfQ+9C+NCWq1znbRkVUPDRjeA8qsVAW?=
 =?us-ascii?Q?NU2gmAG/Et/tMUmD7Prw43/WE/q6P0Jf92GgHdv7G1zawLs23e+o29+Rjduv?=
 =?us-ascii?Q?dIvc9XLvHVHoL0Ib7AzYSiHdzRUlwfTG1aGhA5gGBWvJ+Nj6dB9XfES4GtAc?=
 =?us-ascii?Q?k8YXkI+0QRdcswPA2nPkfGuyWjmeheiNUFXR5zxTTLagf+J6/a4VrNrH7S2V?=
 =?us-ascii?Q?IcZCT+GA1nPXUd+ifupRloTYc+TuVtMFor4+J0PYTa6m+sue579+gRZNdBpI?=
 =?us-ascii?Q?YekPl2aCRtMY9uUOSMVbBC8z1nff3chmE4N9xSw8Sao3HATAjuNhJnkViqGr?=
 =?us-ascii?Q?H/oUYZHXe3exTptT7i4qVxkQ+DZtGvpvvQcShmxvN6c/FTa5app6owZuSHT0?=
 =?us-ascii?Q?xXSde94GfuLw9k+ONPJeKIl/oqMGUS2g4INU+Y9FeWbYrzVmESPOMVB90Llm?=
 =?us-ascii?Q?a0M3dVQjoNjgz+F8zY2boG0JzyAdEULXKyvyrdU5vOL4Zmp7utwQ2IJi7G67?=
 =?us-ascii?Q?+h54PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9iFZjaDy/xDnbRAcNpgSwLpBtEvVQr2w2nQSLdpS/iy/XW+k9ItPWO6q3VtmEN74ETFznrbSJLmso/ejxtjgYkaT0TsAAzW3ltJLR3XaNEAIuuz9ih8ArmHFJotaiI7NRXXBcmUx4J4Cc8KSXidGE1PRLnp59tGyNQV4wieaiY4pnnP/3RDvRH8WbmMYoN9rchvjFoNwejnzX7GoUC8C0ZMmct9vSDe/qI7fgCFyOgL/KEe59onN5FBp0BIoXF4uZLe3PSJ4sPjkPMqFdYbyclFNHmcGKeY53TvNtpCvOLDC9MPYFwIb1orjpjBjC8H8RwtSk/9hHs9Wh5tVTN67EV2liHvrP/DIOU+YF4LpgCjHOakklItY4iyl6r03IXJE1wxexUSB9ewokkJaeTsc3fA/06r2x4aBSHxLVcA5P/7RRFlYHDZbIjLMsuitaBA0BRuYYW/UdtQVSOwUmF+qxZl30zJRRzybHd1m2vk3yByFNMoNEQO+xr9vVQJZmUSzzyfP3UTAjzX0HEoSaRVPQ8eA2vTuKoIS2nV8owLMhmYM+PM/63uvJX6yywI/rWrTsvCjytLp08Oe6Zoz6MPenDETSD549bi7o0kkSe4L+DOFeUtUP/ZQTsSWo1+C3LDa1HOYmNLOT8PYCYt027iUIC7uy0Tjy6A9AYnB6EJHC+rw9a8YYu5DFuO653nDtU2u4OZlC1Kt53m4xhRByV9+R6giXHve1S/zzEG6/azI5cYc8jZeF/0ixzKpBO/u0ed4r82Ovl4EjIOfsF139EqRutsa0izq8Wd0uwSJn5W5Ad71isLK5O5nsM9S4F3P10mH
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da640470-2b35-4c9f-9572-08dac9a9d5f4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 21:14:10.3203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yX1BGFbox4LRXpmlN8TF6kKJNXdNlo3MBrzRKhawXCjHN2592cWbaqBSRgifmraAkT0QoceAKwalAo1xZygE4Oq62aaQDA5nEeYrNXNUng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_07,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=734
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180126
X-Proofpoint-GUID: _2WQzP6vRPDkdunZj4HtX-f45RajxxfJ
X-Proofpoint-ORIG-GUID: _2WQzP6vRPDkdunZj4HtX-f45RajxxfJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

This patch aims to hoist the ext4 get/set ioctls to the VFS so we have a
common interface for tools such as coreutils. The second patch adds support
for FS_IOC_GETFSUUID in xfs (with FS_IOC_SETFSUUID planned for future patches).

Comments and feedback appreciated!

Catherine

Catherine Hoang (2):
  fs: hoist get/set UUID ioctls
  xfs: add FS_IOC_GETFSUUID ioctl

 fs/ext4/ext4.h          | 13 ++-----------
 fs/xfs/xfs_ioctl.c      | 36 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h | 11 +++++++++++
 3 files changed, 49 insertions(+), 11 deletions(-)

-- 
2.25.1

