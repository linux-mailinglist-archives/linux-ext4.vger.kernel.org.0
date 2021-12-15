Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3703547580D
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Dec 2021 12:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbhLOLnm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Dec 2021 06:43:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45860 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbhLOLnl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Dec 2021 06:43:41 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFBSmBh008075;
        Wed, 15 Dec 2021 11:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ZvWBrA+AI7oOb9RcV2WpqKgKv5GqV8ZI0BFKU8p+1Us=;
 b=Ms29xNEHM1S5/G8ULgBj8Lt2Di7a1hUxFY7m1oxkOv+jPZnyM0w9jVmI+N5EGZ5m3Er3
 nPer8sPUpiNqp+KGfKjf9U3dpVf6T2l2SffFjmW6wE0SKRtv3WR6xnPK8q6bl3MqaOlU
 I8N4dUkulT9DyVBCEUxh7Dx6xqTjQMZDTfs2ZtITn05utwzW00YNzEClZhyq6WxmIGRr
 rrM0QvHOVR+idFd3/Auw/3N9qPZuLUU6P5vyU4vrlf3LdzIsXNFoPdSZjeL7K4GDatQx
 03X7GT9AKvyRCeac695csRT10fBRBqZvZGNQMSIqi/oj/o4h+OwtUqxyfz5si373UKnv OA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx2nfekbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 11:43:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFBg64d154845;
        Wed, 15 Dec 2021 11:43:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3030.oracle.com with ESMTP id 3cvj1fa2e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 11:43:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH+xKY3EiCUhCgacX4BVOdvqmu1JqeRtojV+bg7WHhn5vbHjXzvi53bzwfflWndgdAQN3686kPM8doNaXbhPs0yyCuosnhMhJZfLqddZiPN6rEAcrpu4psNc/EIeyFXl6nHddgKICQ9p//C7c5Oa2V+F4utJ9ezzQ9ngvw/95KCqQu2N+KCF6QxIWqezVNWmcddROenQ6Do+mPSWkMfQzlYn+eGNjnwid1EcsLpk6UUK+JGRWhai49wYjNrM+/cYxgUDe1IZ0TkwcAXBcjMnjyTMXEY0kYqslQ/3FXztokFN5HZU5ernQXAwCP5+CvfnjkEuZqy7XLzvtBMPTcUlVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvWBrA+AI7oOb9RcV2WpqKgKv5GqV8ZI0BFKU8p+1Us=;
 b=LD09W2Wfr1pt2eL+lcLziMh9YelljyBtRJp4Fm4Uyzypz3pdbVwQ7f0ur5DVD1f+gouTTonwiHRYI/mHNkTBq04P8evppU6fk23SatCigoppx1f/smUEoh/eU3yCCWj22keMZhu37jCeKTdkUkNLu2pECcsgolWkA8prNXvDPnZba/6LehPVduWl/68+5RWZtB9fNZAweNTyleVIbWKSuIAzfDPzs0dlqHbJcldHH7O8Zd/nByPuIK282rOuzP46HR9jq09H2etngnqvHBP8El+yGNVrfFzI4ArXoFs+PVbXtZ8BXCqemszPXx6QExurOdTA8IL0fou/vVkTBqU+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvWBrA+AI7oOb9RcV2WpqKgKv5GqV8ZI0BFKU8p+1Us=;
 b=YU5p2cku4aW/j3bvAAQmkoDZAwrJljYvbH6b84WR/o1tiSs06mEXb8eoPWQdQ+c62Kt7BbZxdnek07cEOKfyoI8trwZZWNlqHKu9tzKLCvn9IxP8C+CxfTJzAKTdMHT1iURNvtkGlKZc6+XL27PkpHhGdyt9nWzTgV0BgGC1QbI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1664.namprd10.prod.outlook.com
 (2603:10b6:301:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Wed, 15 Dec
 2021 11:43:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 11:43:21 +0000
Date:   Wed, 15 Dec 2021 14:43:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Theodore Ts'o <tytso@mit.edu>, Lukas Czerner <lczerner@redhat.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ext4: fix a copy and paste typo
Message-ID: <20211215114309.GB14552@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0137.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 823a7556-ee94-474e-9323-08d9bfc01865
X-MS-TrafficTypeDiagnostic: MWHPR10MB1664:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB166491E04BFB3432962FC6598E769@MWHPR10MB1664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjiXtw0y+Jd9peX+B9OyJUaUy93r3lOyuD5+hHUcQWBPQOsOZpfKj9JIFzswGJq7/yobqGk5orOv1lL5x+dFg17mmoOcIQz1KcIYO4RRL8ayV3l4udjWn846Pbd937yY268dNpBYkkcGK+yuz351Un3UukgRFBZW0kyLfwFYY+KayMiG1cpDWywNz8tjhVV5HLrqHxzWVZQQYSP84cgBYCiLsZDrEal9ZOceiI7NMIn3knyIDnOGURnk/s9mgutxNxrUBu9HklnakY3Ml8/bzeINWAKvkeIwdZMgx7IpLtPSJB0DdRqY+zW+bt+CCuyImkKvySbopyHn1j/EyM45keBGK0bqqU5Y3mGuboTwHlOtHwab71qH1Jl75R7koDgQ/jgFjCV9fZspTBHvnc7Lwitf8hXvSj0R9i9yOBNDJGlaLtGhQ5Fym7azVB/rlI4HKfWshnWN+qL9qR56jmErpETymarPlnw9EkrJi/eX7mQAFUfLEGab7eHQ6qhlowWtH3nbn/0cxUJ4D0+YcQ3zTaPnzvjQSYfkaiJg0NYoEdmU0b1bSpaVq1JpHjr6y4a3dcqEXbn/pWe56cabmXmq2rHQPcVDmxny6D3e9ZRVNu27xW0JVRx5o/CZz1Y0mqkMVeYptQMFRWdmoo7gH6VFHwN1209lzi8XAvg9L07y3ZSzHUz8gEmlKK09crlzdWh9PNASmH4Qi1dh3ebdXDqO9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38100700002)(6512007)(9686003)(4326008)(38350700002)(26005)(66946007)(6666004)(33716001)(44832011)(8676002)(66476007)(66556008)(5660300002)(86362001)(54906003)(1076003)(2906002)(110136005)(4744005)(8936002)(52116002)(83380400001)(508600001)(6506007)(6486002)(186003)(33656002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?acA/7piDMe0RwzPy5Ozg8jf6FilbMY8FuuHCLnexs91vp/seWYDpen0a/h0V?=
 =?us-ascii?Q?HcC+WyJHMJAOslBKD6GhJpecHXq+QHNhGkApl3uCEywLkmWf0c9WNegpC9mf?=
 =?us-ascii?Q?QLfkgAp/JWs+iODyFyEABdf+56NpnF+aGjT0TGiaHOahlB73wDwX+IgzPt+W?=
 =?us-ascii?Q?cvlKuOScLr1oZGJ7LwH7mi5PJq2HuIFHSWAxQXLnyP3DG5jNBcpYvdmtdPtk?=
 =?us-ascii?Q?VXrRBiD8W6Htw9vG3YTiN0Q5KR6f9oSZJVREnze3+Upq8g5IqWB+0lraEKOe?=
 =?us-ascii?Q?BZPUO2aQs1/jic9MAslPrbDA45CDtmg3Ctcc+N49E5G5+x8uGRuEnigKac2y?=
 =?us-ascii?Q?QooiZn1Pavqcll5TXBaG/LzK/XhmZn/+ufcOrBn8IzY03pHtYaYPkMwGoov4?=
 =?us-ascii?Q?6qeLzcL7fbKWmoRPnhaLmD6H+vIpb/09v7rW6oe0FmzQxFO0qgZsBvzp3+2X?=
 =?us-ascii?Q?Mv9G2/NGhwR9V96ewBsso2sVK1/po5tv61ReQW9EJJ3jqkP6wPyE3mVziUc2?=
 =?us-ascii?Q?nDmu5dr4fLC0pgrGpMMjKInUEECvXfzh3fBT2pBuQ941Pq9SfKXemE6roYHu?=
 =?us-ascii?Q?zH2j0x1ZwT4IfVbOdw4VjT1g+HggkLqkMFzl+j7+HfMad5TuQoTnJ2/yi2Py?=
 =?us-ascii?Q?vOuXgD9z4DyNTWXiitB9OmTlfRmiNyv0YZXqQbTak5ZpH1Ro665k40fB/leh?=
 =?us-ascii?Q?1xOY64jUNGWIAYsAQRZEDTP4BNoau+egpth455CrnX0445J+dkjq//cUrUqA?=
 =?us-ascii?Q?N6fwZxhmADmt6AKR5bIo5ZCAwIPrMZKqSLlkI6W+qMWpU/Wg+b6Kr9K/N3RU?=
 =?us-ascii?Q?6gODJALRgXRgoIONq5d/pUwA3AM6iNBJA63pVsPpUlOHaBUwaeh3AO9vdbLx?=
 =?us-ascii?Q?aaMp7mYUENoV//64er4raMbqW9oBN9rnjKsd3+hy3H5Fko0RIdt9efDN4LYn?=
 =?us-ascii?Q?UjQ/W+DB67Z78T9NE+JaIAeucCObsKcPsxjCWqhnTNKJbNqy2AweGIr8rDzH?=
 =?us-ascii?Q?1j199NSrYoT5nVJELhEuI+b+cYlUIMD4C1NIYYD7XYgJ7thCr47LQq+7cVwd?=
 =?us-ascii?Q?dAPvQfmaH0sA33EIq+NJtTQKdCqYAGxCdjz1xN9SmEDJv3Z4aAGEzEH2WMmw?=
 =?us-ascii?Q?33rRNEAed4SbjG9pKXUA8sPEeQfOkw2xChg5CFgq86Pg9yNV2AluGICKOb3g?=
 =?us-ascii?Q?ZqLf9WfFzcxNfXmcAxCd33P/1dNBWUrThtn0vI8RN/pmJ3quBhHX7U+Nm3St?=
 =?us-ascii?Q?1HFxJp5Yoe0pP0cdJLiIDSYDTnczsm9scll6AsdyY6F5eZoP80b1Jk5ULpz4?=
 =?us-ascii?Q?ERLBhEoicCj76vtLwyBuDHmu2rNj8v8vOJziIQhCytVWPko2WwyAkAO1ibP3?=
 =?us-ascii?Q?19+xs4aviDcW0mozgEzWO5XYoqDuVMAqJR4hfXPz4j4+oaNOts2vBOwQCXLQ?=
 =?us-ascii?Q?XfZ7+Z2AUbazZmBqw4uurjTE2VLky6+xhY8WRg9i1ZrbbtC/bpHRBU+4OQ4Q?=
 =?us-ascii?Q?D4+AodbX2pKwDswEeG3FHoWeAC42myTgSG0QT5CGSfca2M2sZEsEcddH2oIi?=
 =?us-ascii?Q?exddHanAk2z4jnJ8ZTrP3N2vIAhaYVyjwFy3pMk4eFxXxq5sTYjmRSF57hhf?=
 =?us-ascii?Q?xkkXNw9c7kGLgTkJiFWK/QErgGg3TNsu5TaOT6jy9DrJzNE6GOVaIsQWnCCW?=
 =?us-ascii?Q?Jj3zZTYh8p2+uiOmMrXfSF6ZayM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823a7556-ee94-474e-9323-08d9bfc01865
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 11:43:21.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7YG/IigtiyoyVAFX/tYVHFAFya5G1mwoJx1cRgtwmSwYLf+6+cFhzBgmlfMUZUZzwdP2Hyne1Bbnum8SzoavuMb5gwMKvgpHV7JgvcKkMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1664
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10198 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150065
X-Proofpoint-ORIG-GUID: amQVz_A9di8p3BKjnlfbbqu1weMktd0n
X-Proofpoint-GUID: amQVz_A9di8p3BKjnlfbbqu1weMktd0n
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This was obviously supposed to be an ext4 struct, not xfs.  GCC
doesn't care either way so it doesn't affect the build or runtime.

Fixes: cebe85d570cf ("ext4: switch to the new mount api")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5ec5a1c3b364..da40fb468d7f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2077,7 +2077,7 @@ static void ext4_fc_free(struct fs_context *fc)
 
 int ext4_init_fs_context(struct fs_context *fc)
 {
-	struct xfs_fs_context	*ctx;
+	struct ext4_fs_context *ctx;
 
 	ctx = kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
 	if (!ctx)
-- 
2.20.1

