Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B21F47580B
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Dec 2021 12:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhLOLmu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Dec 2021 06:42:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33324 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbhLOLmr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Dec 2021 06:42:47 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFBSud8028543;
        Wed, 15 Dec 2021 11:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=QoZeu8RZHM1nRw9rzbK6x2HGdirUTq3sO3eE54v4IK0=;
 b=MZKtv6UISAlrvqsaGU7NZ8j93viEKQG7yHueme9nSjY26fm9QXEpj2yf6jukW2pn3K0f
 z3zH/5jw0+WfwmJfnOcTT0bgzWaP4tkQiPWNbC++nqvGpGkOUlWHEywX3AAA4tK8xMJf
 xEPn5yQVJPlH4dfj7hm1L/Fv5E2VfN+Sd3Yw6PkIHVWpjevzfU9F6bc5EgZ6nWbXsOLu
 XdtyqluLCC8sut0UP48/XbFmbqYIbsjK5JDzSxWyl0HoyizZt7DYIvdQ97O5Bn06lMMF
 xV1tT/Mpmd8XAq0SEAM0r/nmkS9UpxDd3W0xT25DcPcDq1st+JjfTz4ledQlS1KpCcs6 OQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3ukejmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 11:42:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFBg5lZ154803;
        Wed, 15 Dec 2021 11:42:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3030.oracle.com with ESMTP id 3cvj1fa1pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 11:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kq58VUnhVAHIZnfxMUviv5E41tlra3gXOXkZe94W9UHzno4aq5w6UYJ1ZL4tFn20buqjOuhhNxYMy9aRDHKbiq1FO5S9urS4qr9xqsbZO4zTMj32b9zpCr2r/Ix2sRV7gtV9EWjNetkBeCKgeyEUMoPJBNLWSHzBmVAu32VfUupngojwgaBGUQTKp0k7H8LfdNRWkhfo5cni5FI+OArxPOb25n/07lArexp+j4e+SmUXg8BYUfmcktPTbQBGfLTFl5ZvS3NJEyG2GCWcD9lGU1cGl5hOZOcEm3O0USW9zGj12maPyvOixHCHn8dpjSRKsLfiXwGFlwDFqidoCRntdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoZeu8RZHM1nRw9rzbK6x2HGdirUTq3sO3eE54v4IK0=;
 b=adBZQM1jWDLr9vq35KTKXoM1zr+B9caEvKQ2K1drgRF1dfXKtb9r8zoyo9JLxIlDARteWfuSCVO2j+23AjaZQm+OKhsxMtN3J1/c+fEbgIgxkpHlM1wwAZrJL8UwjkOe439lZXSE4qTcZOMPgsjVf0HPXN/nOP7qrkM6pMKYKRuU6DYM8lhZjZmBcRBjFMvC2hwSGfg5na8Uj6pXDamPQgM3L7c0rN11yb7cHAdfPYOsJnggJTG8+P3swoPhAEgG4P5yDlHIhoApTapl/OkQKzp98IA7PjkFaDvgy17wd/s3V/Z0LqFluGZHE46ydbDDm3mmNaNoqqobmDDpdK7ILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoZeu8RZHM1nRw9rzbK6x2HGdirUTq3sO3eE54v4IK0=;
 b=IriXH5UYqvYM3tlc695NrHae+Q2jxsxHlp1FuyqUg64k8uLgoOIhE0rDy7uWqK/XubZpJnAc+qASDL8y4YR2nQ3jJ4XqY1M0ANAV/SW03t7UOaYRVuucIuZjUgVHvZb5ZPT9xBDkQdixkpwGvCfVGdP6Nse6e8jQWtLL0TwYRx4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2366.namprd10.prod.outlook.com
 (2603:10b6:301:33::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Wed, 15 Dec
 2021 11:42:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 11:42:42 +0000
Date:   Wed, 15 Dec 2021 14:42:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     jack@suse.cz
Cc:     linux-ext4@vger.kernel.org
Subject: [bug report] ext4: Set flags on quota files directly
Message-ID: <20211215114231.GA12626@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0135.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31c41795-e534-47af-58d3-08d9bfc000f5
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2366:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23668E11A3545D0DAC5881638E769@MWHPR1001MB2366.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxB2EPOElqq8E/qTf6hXly2yJ5ie4lu5tDZsBPwigOn441vTvW3Ja9QLcs7PyzQ3SFIO4AhdmJnQMGC4foonHHsHAZgsZMvPaORZ59kHKExQH76lt6cByEBulX2Wtcjxu9JhZk+1W+IICxOyI0IzR+oJguJAth/ldyp66OXo6lbpI/MlHLHLfUpHzC1YQyukTPCjyAHDUWL/WIEK9MbypoPsQuQfAz9RwFSZMIerMvp7ilItx0xc0lA6NHOm812M6j9XEkNOghL5gxiuL+zgmsLEwF+lB4h4oRd/2d7pnyy70U3ZQd/UWjEkj9zsVGt36Y3HfPlUABMy23OpLdjsL1YBcsX/UEW5ZcuOdrWNN7RudDsu2rgWh9qeIHIRHM7Mkhnw/OINKC86ss0Rxe5JbvHWa0dIOX9+db3WUU1JeNr8GtMmmGNRspYCulsCl/W8UOHLD+4sHjrkSOjtdcViU0BK74iR7Agvds/oc+nDuXGl6HQO5n9J+GV1MWzUFu6PE9R/Vs2ofTAtAwnRwFO4Yj4+KSizlkDvlKDOo0HDRrzs3CeRFIjNYgry37onSW5zj7GXnbxTxcPO7bXDoe7jlqFVTo475Z4f7lLB3ntHEn/ECWA3PxZi8LKUoYTeeWd/MIaI4otwkmO3zOnCiNLGJKvcyRxocKVEJgHR5vA/adk94foJr6J2w4Zs6Uz1jgYyoou1XUyeZdRfeVAe2KAGsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66556008)(66476007)(15650500001)(66946007)(1076003)(8936002)(2906002)(6916009)(508600001)(5660300002)(33656002)(83380400001)(316002)(38350700002)(38100700002)(86362001)(6506007)(9686003)(33716001)(44832011)(8676002)(6512007)(6486002)(186003)(52116002)(6666004)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rC22l5Zqbz6m8rJTIZXeLWU1n/G5zPu4gWESnQYB0c/CD0JxCzDENVZkQcee?=
 =?us-ascii?Q?swVgkTf4d8xfinh10ZekZ1MSc3tQFMgj+wqkPhoHX4ChmLDfS4JQNqguZYAr?=
 =?us-ascii?Q?sc1ShWfIpp6l6XbsmwKm+VHehdiih/a7lptvbhnHLZwBpjvm82hIeDqICu+V?=
 =?us-ascii?Q?1+64OI4Km/bgWhVOGABskWxVtYt7I9UQ67feg5Ix18hB6FmOFShYDIrVSnWK?=
 =?us-ascii?Q?KyhouU+WmBa5UUr9VVYL7FmdM2vfXCHpih1ZRsrE3zR4/5dRUVnQW1M4e1Iy?=
 =?us-ascii?Q?IwkSe+158AZGEqxJxkLH0ON7wf6lsp1FcQngCFp/hlnrS6GM4CX/SJgDr3T+?=
 =?us-ascii?Q?5DIChzPxbeJnhns78GKDhR9DbYwMM+9H3BRSqX9byAiLDDgPvk3Z+87Bk54y?=
 =?us-ascii?Q?6OP9SzSc263CA++xXTs492GPBnMKe/ffoMIsxPc2+2A/uCMa7jnYLZRQpBQk?=
 =?us-ascii?Q?2d0hdYcsT0pUwFTbWUk7v2oJ0KosOpVPKbKMCmq4LjCWkddYw/r5cFiRyAPO?=
 =?us-ascii?Q?xQFZV6nwwyizBF4zhdDSzaC1zQ5w7P8c9PcX2GgV/b0S32QbuvvD6PnHO84s?=
 =?us-ascii?Q?dc/l1jHBDOR1zrnIuTpym+1d9TuQdTSk9uB2rbSQ+E9lth1Ykjh4WQVYB6OD?=
 =?us-ascii?Q?fFJkii/xqwFyeWhd6Ypou/kVI2Qs6kPQkTo/4Cr2sKlbbPP/Mig90iFXjGhz?=
 =?us-ascii?Q?09RUnrDk724rv5LfZwg2qtXuVAnG8+uGYtQzPZ6CqPLQRELZ5UdBnF2o+5ty?=
 =?us-ascii?Q?1F+bDtz4if30oZZqVsjqWvprW5L+UrRDjYsKCVO+HdO9rT903TYK39lknO7o?=
 =?us-ascii?Q?X3ty96G4MQ+KwBjY88GBo3/bFYsSYrhNS5QhtKPnL6/p8ASjSY/xqPbvzSUY?=
 =?us-ascii?Q?S6r574lw3MN23rtiu8JAIwzV9/h/4vQK8h1UPJpOEPbJLhdZOD/ejdZqyKlU?=
 =?us-ascii?Q?QcRlz030+HWBYrpPuRs2buohkEnj7QtCyoXxJ43yyzVqK6FsrLw8I+xkyaIm?=
 =?us-ascii?Q?e+7uYTao1n3LZkM91ppC9u0K0DwJbXTKlXfCcvfCY3XunOqQz1eh0/vXD5DO?=
 =?us-ascii?Q?Ky4vQ9xgEWYAbkCttDv9G4efRrQZjFl30SeC3t4b9A0Z9lwG12mV0OnF/8NY?=
 =?us-ascii?Q?QXA3mRmWWP5UP/Qy0D8Mzf5JDiXDGdWaPEYpMF5m6coUZpi1lMBNv/zbhQM0?=
 =?us-ascii?Q?RITiaqkd1DIZZ5c+K3oy81w1CLe/W361xUzh1xP9ZlqIZFipbgSg7S86pHWs?=
 =?us-ascii?Q?W7zOX34TayijPZiNTksTOg/uWCU8ST8nrSPlm06dlq1fhG3W/eJHp5fP/X1A?=
 =?us-ascii?Q?atDtrVEPegq/yNhskpvA7DdEiACDljazg0p5RBO+pnhiU7ZPlOCBoOF9hAF5?=
 =?us-ascii?Q?416ogbmvZPwbWNACxUCLGSu2aa2ve5VuqjjvhWxr1CYm4GZxo9eZOFZwXxzn?=
 =?us-ascii?Q?lnZdOGNmWxYH0BFerN3m182JdLlAaquNmvDztbxiiF8kfK70PsvpMcY/6wfz?=
 =?us-ascii?Q?SnM+Z10SMJhGQ92TP0WyZeU2NAI9OItlvJVvjZ2TSHUXaekWN4+wwHyc+hSk?=
 =?us-ascii?Q?LeCl7EDDWFVLAh5kmYFBcyEq/uIoK/k00wJzuFtl8urNZGwBqpeXrdBp4unU?=
 =?us-ascii?Q?zXf+gKfVWpOne5PggV1MdFaZVdENmS++/ye25tEoRoSls2SlYTrjpYxPPYbx?=
 =?us-ascii?Q?qjSMYgtAkX+Q1TbmAuICb0tLmR4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c41795-e534-47af-58d3-08d9bfc000f5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 11:42:42.1410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mw4i4kpmM2wIAiWnl26+DerL5Ip8UFkY6qOxUaTHbf0yUOg2JQwvaIi1V9NOcw2kKWZUTcEctP5ypMYsIz64XY4qtAWR16XMeOijR1GxXKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2366
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10198 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=616
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150065
X-Proofpoint-GUID: JUHUdhjJkq9cV1aftUi8ZRTur6r0Hu2p
X-Proofpoint-ORIG-GUID: JUHUdhjJkq9cV1aftUi8ZRTur6r0Hu2p
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Jan Kara,

The patch 957153fce8d2: "ext4: Set flags on quota files directly"
from Apr 6, 2017, leads to the following Smatch static checker
warning:

	fs/ext4/super.c:6779 ext4_quota_on()
	warn: missing error code here? 'IS_ERR()' failed. 'err' = '0'

fs/ext4/super.c
    6761 
    6762         lockdep_set_quota_inode(path->dentry->d_inode, I_DATA_SEM_QUOTA);
    6763         err = dquot_quota_on(sb, type, format_id, path);
    6764         if (err) {
    6765                 lockdep_set_quota_inode(path->dentry->d_inode,
    6766                                              I_DATA_SEM_NORMAL);
    6767         } else {
    6768                 struct inode *inode = d_inode(path->dentry);
    6769                 handle_t *handle;
    6770 
    6771                 /*
    6772                  * Set inode flags to prevent userspace from messing with quota
    6773                  * files. If this fails, we return success anyway since quotas
    6774                  * are already enabled and this is not a hard failure.
    6775                  */
    6776                 inode_lock(inode);
    6777                 handle = ext4_journal_start(inode, EXT4_HT_QUOTA, 1);
    6778                 if (IS_ERR(handle))
--> 6779                         goto unlock_inode;

This should set "err = PTR_ERR(handle)" right?

    6780                 EXT4_I(inode)->i_flags |= EXT4_NOATIME_FL | EXT4_IMMUTABLE_FL;
    6781                 inode_set_flags(inode, S_NOATIME | S_IMMUTABLE,
    6782                                 S_NOATIME | S_IMMUTABLE);
    6783                 err = ext4_mark_inode_dirty(handle, inode);
    6784                 ext4_journal_stop(handle);
    6785         unlock_inode:
    6786                 inode_unlock(inode);
    6787         }
    6788         return err;
    6789 }

regards,
dan carpenter
