Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F57400042
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Sep 2021 15:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349305AbhICNLE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Sep 2021 09:11:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42000 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235200AbhICNLD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Sep 2021 09:11:03 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 183BJwrn016553;
        Fri, 3 Sep 2021 13:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=4IwgYaGrxSN3LgzfLBkPX72WhYZD8PYAjgM7O21UQM0=;
 b=NhygFYsFAkfUxo3uqVASsmUorHjiEbj/5ug4UvbIustBlFp8RQqG1Fit8SMcH7yJ9gsI
 Pp3n5R14EwnL86CGu+mpwsz0SLII3yj5iJUm5wQPLPlGjqcZqeV3627ZBC2VhmzFcgCK
 X4ow0hVPiSTvcsYh4owq6xe50ebismW6SUkJsXMis1bFNikJZiTfgprxz56sA1O5/2Cz
 MYZMHUt7ti5Pt289a2KjUVFwlc3ENO9DcGtglZCO6h4VPvPCipMATvP6dKzYuZi2QbKK
 GaF/qhKBJj7BsXWhSUkXcL7iwx5JCFdV9ldt3ESqpl9O/GEdCIXyKdFYiHVu6cO8lblC qQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=4IwgYaGrxSN3LgzfLBkPX72WhYZD8PYAjgM7O21UQM0=;
 b=hY9VK/kR4eTpNAquR1gObA5tk13k2d+xx5O2IkRatC7DlzFA/6qWlCUUArKNScyFVye3
 G+z5l0yysZ+DnG1y7QzxSLNoFirjQlZPaO+0RhhvyKTdww6GrZFVBfKpY9mDDn9kwMmA
 r7u2jQYDHoFKF2F1TKDBj+fDnH4QF6DQMkX0PdQJDS05udprAJfKnEsZlWEWhnNu6hnS
 rDTGgW6+S48KbNYbHZLFboNFSmmSeOq0yo3hyeT+dgyWuRFiD7e4gYnHzL5MQIAX+6R9
 xV3ibdRlpnG3IqKJb4P4eoKeTCusTflvz1e+uN9iVRgWeAGWJL8ma4uNPOehjQ5Fv/Hq iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aufj78uw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 13:09:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 183D9m1i100980;
        Fri, 3 Sep 2021 13:09:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3020.oracle.com with ESMTP id 3aufp39yr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 13:09:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+WbKuhtfymfgfz2x31he2KyXD3UMS2zT5TqQanuctBwmLueGemsw3tZfHQZSFPBB7GGgUV2EbjG9sLYVlNvuedS4QOS93lfm7pwglkeMzGf9AWLm/YPrzEm9bPQipJCRfaPRATag7DdnBtzTWOBtWkXpyPfMHDd0vtY2GNx5p3i1T6rLKyUEJN090bWCnosxGWbl7xmYUUAapDZJeQHCP82DEOw6RmZmpr/fwN2F2q/RKYenvAat54G0AZ2f/DigFJ+Fvq6Jff9OiOj1Ma5yjjRVJPwXy3vi4wZNKWskqeNK+oKdUDltb4Bzu4rqye0FA6QvhAOumhCmdK4Qw6T9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4IwgYaGrxSN3LgzfLBkPX72WhYZD8PYAjgM7O21UQM0=;
 b=XebFCSUVgi3DA9M6ywqLz4+voYqCYNflBa1lN7OtzzSlloDOlflIl2L/HCXASHRS1Mr9NYh0iH3BsBi9fqg0h1QBT+LBXmiLPSQBLJIrQLJltQqUfGfCfRrjuHhbGqe3XOW4LaLQxT82cD1O71u4mbjG45CMbeYQUMuWrBbJfIMM0vepOHYWNqSeGj3ucajA0g/UajseoletvD5NLw3rrUco/ztUo08H49RHgexs2PVTrAHR/nP0uN13Gm4nHEKeq4WDLkcQ12eQh5PSJVJ331v3qVR/jDTWEY0n50sIgCGzX0msBI339WjAOU0hSx4jTCKnxnbjP6Z+Axys4SNYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IwgYaGrxSN3LgzfLBkPX72WhYZD8PYAjgM7O21UQM0=;
 b=0PoLM6dsr/Ls9C78caZVgwiWfDpm0xe2A2WhOHMTKQVQod7rQNslqDiRmAqOnbE+1x+Es4qSPuXF/jQigB7DJhKrCHyJ4E7vALu+VylBas+VgeNQ2VBUoDoeYxs8TPY6M7fL0c4cE2bhXwrWRV//b/aLRJwimn/MT/ELiOdc+Wk=
Authentication-Results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1245.namprd10.prod.outlook.com
 (2603:10b6:301:9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 13:09:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 13:09:41 +0000
Date:   Fri, 3 Sep 2021 16:09:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext2: do not sleep in ext2_error()
Message-ID: <20210903130924.GA1935@kadam>
References: <20210903090538.GA7283@kili>
 <YTIZpijSZc+ykNUY@mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTIZpijSZc+ykNUY@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0006.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0006.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 13:09:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01062755-b83d-4d46-36c8-08d96edc1757
X-MS-TrafficTypeDiagnostic: MWHPR10MB1245:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1245C4C828856FCF64373A848ECF9@MWHPR10MB1245.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2nvR/or1bDTqp5TLFqG86Nu3tXtZRPaHjCufBsRp5zdoslH37bzR3Uwz7TF8Z0m37K3aAWQzcALVAERCK/EITgUr19LgkzNZpOXzdM7HWn9fktNzDH0i9vfA3yNaFmlAdNflpFj59fUM4qcssfxrRWC9vLGt0UmnUE1vI4SptCj+v1wVdQSNvZunDSdLWqhaCscnfcrVAwDxhQzZbpgV1PFN9qjcZwWlH/uyOtsK08JDPunDiKq0V9PJVbw+wNW9lyTL+k7O30iborhRl1mPgqmd6tiWOKH+lHhVhftCHPjWyfFA+cnh3bEBM179rf6ROj4bkLuqAh4VBJ9M1cz5jFZB7VERz2RMcPRpCl6X7FOyDbiy3vEMep03cHZelTgCEPG+rhudI8RoqVBWfPhTT+EOdKwXPKfMO61n8ABPz1oSEuKWnd7VhJU6mD+Hwc90MeOEKPORCGOp5HWLEKYb23UGJ//Ch1EoMuRvkEgk7aIlwM0ydaRMRBmTg16Am0TVky+5SIGzjMEm84MECqcMI64DUe+DHObfMWcHcxwX+xMbRCLdZetGRXjfK36BlGBLXH+fzAZx9bWWh9cNDEaCgNhpb2CuJNbulpXyT/lGrQ+Zamc3utAVFKLfBlaZRInKPVMSEOwgmIpJpai8OpK64UGk4Q31/qVZvPLiFaCLpH+bNLQBb5K0R1K0BMItOeopO2/LkeLY2D1XqqWzAHoAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(396003)(366004)(39860400002)(38350700002)(38100700002)(8936002)(52116002)(66946007)(9576002)(2906002)(8676002)(186003)(55016002)(26005)(5660300002)(33716001)(9686003)(33656002)(6496006)(6916009)(4326008)(6666004)(956004)(83380400001)(44832011)(86362001)(478600001)(66476007)(1076003)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bJLsD/dIe7UdJMADMV5NKF1KFI3mpg/sdQmwPPJSKQCAXJI4BrPeBO72DEy9?=
 =?us-ascii?Q?/8BzrKTgo0bKxl2mRCmXe7v1DrTgvtaWUVgnWQC7/L42i6eDlABCntdAb97b?=
 =?us-ascii?Q?s0QuO+YiZUcLCSHU2ycZD8VNLnNnI/zfSYrhHhPcBoNlAX0/JNoC3RCXjMPg?=
 =?us-ascii?Q?PC60W1GBhx4aadsTSssb1pKASs+FFV15fSYl5Bgopp3ZBRku51JIvnMp/zYp?=
 =?us-ascii?Q?AUh0VxmGYOC/DhPWu683AXttIGmUOtyIy62e32wWF811+vHsQpYbx7811Dfq?=
 =?us-ascii?Q?gu7QUFj89Ab95WYtKi5/YfSZYUeKuyu0/ZN+xqelBkj6M/S70dP7zFJLoZVm?=
 =?us-ascii?Q?7nilG/AdPy3nCbGCw9ad677a76qZ37lfgtyy1SXaErdRyZeVH08eanoa3adR?=
 =?us-ascii?Q?mM/UkirGEIwAc7SiNh3Xg9d5jd5/XocbheeZrAiGX0DqGBFcjtZt6bH5wBun?=
 =?us-ascii?Q?pp/PVVOQ/aqNArV4Voc5DlUNxhXPIvu6kbc9s4U6M6D2RMB38fHzq+ngfTMU?=
 =?us-ascii?Q?iYG4LVcZij9HhnBuDqzfg3L35NvfSqpYhsDcgCXVZ715TRpKWPIuSf+uvMII?=
 =?us-ascii?Q?jjYi2pNf7hwTWORS9uY+m/zUAJS4aCTBdd4Pnan+7CAFc3spl0h8GYn2RFMD?=
 =?us-ascii?Q?uhxDVYsmVl30NhkimeQaYLIiPcR/TofUOMPbEG6yJv9ukIBNQtjZT+QyUdsO?=
 =?us-ascii?Q?1k3NhshsqeZh3XCuiacmDnpSsgBJVQndZz78RT9onPWBLnVWyJlyAU2hwwRT?=
 =?us-ascii?Q?UFwnMDk3WKNHDa5r8DK+on9wyz1E0ClANpX2yWJTjE+nhQVHQ4qQF2mJjeYz?=
 =?us-ascii?Q?hvFoJGQEF9QCOF3kceHWgOQJk3ahdLEF/6yDzemMuOgTOZN7RXcVAiVuKCRl?=
 =?us-ascii?Q?IeAKrgU7Tb9XGmvJJECFTl49JZwzvt45K1dWJoVWaJya3FcdJx3kXM1c/fWH?=
 =?us-ascii?Q?K1aLgpO2T5Cz4qhdTlxlUVJvHJvTaw5g9gx5ZCWWH3v0E6e1wRu+xBNzVDvH?=
 =?us-ascii?Q?ledatXPUIDuiantQaGouOIStGXYBdqCEE2tZoLKt53UU87WRj/AkJCbHK1ok?=
 =?us-ascii?Q?NgTyGG9publ6u5aMA4t/SIHyINV8nYRwP3mMtCK0QU3Ro64hAyV+3K4Ceyf+?=
 =?us-ascii?Q?BlOAf5MpFrmyipBvk+HJ2wzHS6xmzY8mSAO/HfPX5N4hfDfKE72wStXyjPi+?=
 =?us-ascii?Q?vrFSK1E6v7qGqLTsWcVvHm4pGEq2wS82xLlPkbgUngjHqhpRtBgw8GjUy5Ke?=
 =?us-ascii?Q?qRFzZ0GViWCfG5hxEBCqsUmKpDrJjlttkoqGSMMAlnSpkhuxsPesfx1SMojp?=
 =?us-ascii?Q?3v2pyWwZ19jQqrDxxvN4572i?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01062755-b83d-4d46-36c8-08d96edc1757
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 13:09:41.8125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stnrsbR7fITV8+rauiScJrjR1beNC+aT6LABPuue3GFJuC7j1VlNULqog4cLT3uj1NGDUEhuSS6DNTburPZsCRndfWfL5TQ1pbajkAe8mec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1245
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030082
X-Proofpoint-ORIG-GUID: Y14k7BIeCGeb5vTIMdkTr3ADUETS3CZc
X-Proofpoint-GUID: Y14k7BIeCGeb5vTIMdkTr3ADUETS3CZc
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 03, 2021 at 08:48:38AM -0400, Theodore Ts'o wrote:
> On Fri, Sep 03, 2021 at 12:05:38PM +0300, Dan Carpenter wrote:
> > No one expects error logging functions to sleep so sometimes they are
> > called with spinlocks held.  In this case the problematic call tree is:
> > 
> > ext2_statfs() <- disables preempt
> > -> ext2_count_free_inodes()
> >    -> ext2_get_group_desc()
> >       -> ext2_error()
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > This is just from static analysis.  NOT TESTED!
> > 
> > Probably a safer fix would be to just call pr_err() instead of
> > ext2_error() in ext2_get_group_desc().  I can send that fix instead if
> > people want.
> 
> Looking at both of the ext2_error() calls in ext2_get_group_desc(),
> those are really more in the way of assertions rather than warning of
> an on-disk corruption issue.  The second "group descriptor not loaded"
> should never happen, and the "block_group >= groups_count" should have
> been caught via an invalid block number or check by the caller (or an
> outright code bug in say ext2_statfs().
> 
> So I suspect both of those would be more usefule as a WARN() rather
> than a call to ext2_error(), since stack trace would actually provide
> more useful data to root causing the issue.  Jan, what do you think?
> 
>      	    	    	 	 - Ted

Thanks Ted,

I'll resend with the WARN() change.

regards,
dan carpenter

