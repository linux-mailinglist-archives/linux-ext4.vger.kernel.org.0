Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C31475867
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Dec 2021 13:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbhLOMH3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Dec 2021 07:07:29 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5018 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236954AbhLOMH3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Dec 2021 07:07:29 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFBSteb005911;
        Wed, 15 Dec 2021 12:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=S5Aif4u2tdM/fWUOsS3xk6mKItYMOjkXABbXDKAf+v0=;
 b=0fp4cCDqyGl40cVpM+6hP8eJAAREW5ApvRGCwY+/7nhRmyP3fP9hUSMJ8bVNwq8y8NzH
 ezAERZeftgJo/iVZ2y8l78687sI+n/HW6D3oauKLrhIFVN4LSdnrDsOyfREfHAKXN0/+
 fI/R+zZhhkTUR2WeBb+F3kudrOCwyEFnR3POb+1pujoitErMoarsC3f4C+7Ip70Wb9f0
 IFPaO7eerIAWM87on8OrQtHYvCMo3SlPJKFYHBFZrm+GEOfCGaLYUtZs5usw37XsmnEo
 aq1ODBLjAdtsy259wlwrrm405U6whKGeN9HZeGMtzs/HAnG7nzmzgfR6Dqn+BjKe7wuY Qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx56u69at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 12:07:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFC6Wqh033757;
        Wed, 15 Dec 2021 12:07:25 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by aserp3020.oracle.com with ESMTP id 3cxmrbqytm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 12:07:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwtQ9pNm+qDuBRol0S4jgjUH/ZbwsQUyiYnmkA4Oj0Wt6j/vpj/2WlsPi4E+v5Lk50wRK4GKvah1dsM2Bi0ODoO28MRdX7omokR0fOfpe3nAs8WfBJTpzMOsusw2bUggr8FRA2bw+rHJzPSHPm/2yCCgN11x0+KMQTgA030lTk6j2/UN9vhhDJt5kcnRX4tNUlHvsTCovB87ZDwjCmSGI8R83YojlXPzQBGoTPl7O04+QEYvfyt2ZrTeZQa38aOOhD0O2VTBp6EGX7aPEFsAr0drjMs0XYRpBGeNt7UeXurP1RemuxXqojaQSHld5TObc1h/e04VYbz3X4wT2Chmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5Aif4u2tdM/fWUOsS3xk6mKItYMOjkXABbXDKAf+v0=;
 b=gr4sCyhdPikzdJ1lcjo0lC9lC5Dy4/HvYqd3Dq028joTZtXvo52HxD7531r7pJHZuqtAW88ZAH2MOSj9BROxVQxCPpysdyF8Cz/T0gCUmuYELWeAOQd7BgibMK8KdL0CJxpZNlqw4vjYfXOVLwQ/VoicCp+bEMkVazuNntbLCL3MsfowN2vuEnHwgJDM/3rNbwWDJSzCRmbQL/oFFprvvlOFbdPpB4RBJtlFvnwa8jQhYYTwcn+l52muG13g89QB2641ivZ4X9M6iYOJgPAohDql601vtzXYP6mt9Xya1cRlz7t6SV60U1RvgOE3gOseaLj3TMzObm8cuV+xu3s9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5Aif4u2tdM/fWUOsS3xk6mKItYMOjkXABbXDKAf+v0=;
 b=hU7CldMx8856+NiFM+WLHlWiAxmSqX1LxL/p7I0/hYLqDiUJymwvWc+zYGB5GpgB55D9/HP7sBkoXdaG/Yir/6gVwzDlyDBF5N+Qq6VNMvfp1YLub74Qb9asAUj5lhVRVAL+SjvzZ7Gn0On86WstidANsdcoZv6dqSuSx3kGfFc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5571.namprd10.prod.outlook.com
 (2603:10b6:303:146::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 12:05:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 12:05:53 +0000
Date:   Wed, 15 Dec 2021 15:05:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [bug report] ext4: Set flags on quota files directly
Message-ID: <20211215120535.GZ1978@kadam>
References: <20211215114231.GA12626@kili>
 <20211215115927.GN14044@quack2.suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215115927.GN14044@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57bb3971-824b-4656-8681-08d9bfc33e38
X-MS-TrafficTypeDiagnostic: CO6PR10MB5571:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB557155546A65155EBCF5770B8E769@CO6PR10MB5571.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EHiN2oMQ6lXnqTdEFEVogOctackg2MFbHyrZO8yY4Q08iu85kJAOdKtXrEud91Eq+Ah7Tqo0XFpxySn4QI7jqWny2y3eJIlTvkvMT+n/LQ7XPjazX1iZ1hyEKGNBMRTN4zNMZoCKeyeW9DY/nCixjCb4BXau135aCjF5csczZ0jS+EOk/L5BxRnbsy5Dvrqv+MkcfMexNc3F8zz+mUSB/nWddpdSYmLr/xD2j2NnmUY0wjUNmxRsE0h7ILyke0rv5l8PPu8KWyX3pCwZ5edIYZ5NcyCY60zjDZkLaJXhcP9feUrNJCSZ3xmsXDREaFZaSDzP2JGSUK2Y5P3BbkQFasZDrVXna9wJru4NuQ5o/9p+IEpAUXCU5tJ0GaqTc2ACuXzMhRoV3TXYvVXfxFE9698DKPODQFg7sS05kmliZjmV45Xn77c1s4JbEqe820pnz/9sWzoeiFTG9v43xM04SAiD7d8/h3EyBK84sHX1OGpA+JgYposM1DgIPZFhGQbRcFERACXNjBdktmoKgMWubiJyI0d+vMHB380teBgwk35nPEiPnQ09YgFAJXzyCQxQl3/ENZrMsACrMmLTJ3/mQWb2wdqO8xNQ28B9MLfCKcpkDGRV5xbTHgd9xNTXI9fp02ZM+Mof/24tWKey+v+63dDbyXbVzNyH0qYrHhQHT97n/xWS78qLxeLjJKhk94bb4+/Mk6diPKWfrUXiO6JIsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(83380400001)(33656002)(9686003)(6512007)(6486002)(86362001)(66476007)(508600001)(44832011)(33716001)(66556008)(66946007)(186003)(38100700002)(38350700002)(5660300002)(26005)(8676002)(1076003)(4326008)(2906002)(52116002)(15650500001)(8936002)(6666004)(6506007)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q4Yvd1cyCbM5P9R7ioNwbM/m/ZzBoOm80HSpglRh3BcJdjWw8wtkm57SXBem?=
 =?us-ascii?Q?0NcYv0K8Ns/Xnm1ef+Y5gEvGJlwbS2QurMGTS3CEZxSpvATMKU1qzdcpbw2e?=
 =?us-ascii?Q?5xrVH6zrSYUA5zUBtMspUEK6fptCUYlP1FG7hiItLVrdRs1MC7TNviwN2Lx1?=
 =?us-ascii?Q?srKGnDEJ2LiQ/GoYZ3T9O+fOheDV8z2XIyQjcTFyprPmwmFPFNQzMw+6N8ID?=
 =?us-ascii?Q?Uw/jixZf7pxeLs4KpMN6Qn2pMOzU555U6sWk8Q7076ZKU+UvwikpBFDl/3uH?=
 =?us-ascii?Q?cR38hbbILzdOCbROAEFtAl+pTPFdiGJwgo+kkoe1z9r9eNLG84RGiJ4EumbH?=
 =?us-ascii?Q?27fYzdGsEwzlekTQ6Otb+dWwVa8+8oUVY2lif/UwCDE/gynwcxtViMz47JVF?=
 =?us-ascii?Q?bwHc2iV/EUvaBC1FWnig2qf+rK+cshKUTWRNuUI+2I2Lnk6IMSkAAnTq0T+C?=
 =?us-ascii?Q?97a5jWvSb3Pa4/rMTXbDST8I3Jy7FFtzEoU/c2zuPfwIH0kkJ03N8HcBUQL/?=
 =?us-ascii?Q?G9v12WhTFTcVxCl0CyXxApBaXgewzakh/f/fIWHv5ZX7CTRnc0q7y5M2nxyf?=
 =?us-ascii?Q?jku2KBFubE7XwNB+o+/98yKoklegI4tRQtY3C9LbluRptPCCEfuU7HjywlET?=
 =?us-ascii?Q?Tn9mgphCxJzwoiqbQlA8h1K/z2bMCxworq3UlfkLwRGfRPi3RDpZxjqHnotd?=
 =?us-ascii?Q?/TWsoN1QxTglINcA3os5WbnlWM8vRc0OS6dJRvfYMiZRLU2Y1m5Dd82aGJsw?=
 =?us-ascii?Q?O9M2Z5D2oEuvz4zyTd5+dnrHlo3qSBE2z58uzTCp3HpyCRWKRHAjc0T1MOHy?=
 =?us-ascii?Q?SysmuG/GwYnCGvLpdP1/Phe32i4z0hjIln09YYNrpAAa1ytQY7pyQKBZD5mi?=
 =?us-ascii?Q?7xeGWeJIWO1JE30eF6JTUjHTvQK6WaUgBQkkDlx3gekdOCabwpNMAhJov/sB?=
 =?us-ascii?Q?+Ys1gO+y64bSQtt0qLbFqzbVXaZ/F7mXDsCj+mfBTh90na8WLU8IWmOoMM9F?=
 =?us-ascii?Q?XEXf/EPBAu256OKdiaI58HbGdr9nOXPzc5ZcPWCdUXH6QgwO7DJunycR1A8A?=
 =?us-ascii?Q?x3Rn4q537S1S5K7TyjfpqslvFUHWsYh+XUr/LRfY707OLn4DvwFHNH5CKkhA?=
 =?us-ascii?Q?GbV57x9EHAXy7BpbBLcAor60aCXnN7c9+uyobVoBbur7nN23O1SFbwguAaJP?=
 =?us-ascii?Q?FoZoYHMGyWkN8nLSeb2WbNvxb/WGIOalcIT2yDfmxwOUKaQTTEtekx40bTq+?=
 =?us-ascii?Q?0L0Wx1Ibph40TsqIiqJ1+Mw3HA57O05lMpwFeJEqiXuRN+OT0Ygr4vswkNz0?=
 =?us-ascii?Q?iY4iCcTbeDs6g9RxPd8nNffT7lsCOiATGIvkJ2hnTrwLNJroHvIL+4hgV3Nf?=
 =?us-ascii?Q?5+HACb5W0bMquH340PDtwWLoL19GTTpZ8a9PnY+PMM64rg7QdYgJ1rSAxyYA?=
 =?us-ascii?Q?c/6p5qF5kZSLyq+4g943aoqu6z8b+fAEWHYI4alluOoxO8ovMAeZd1vOe//u?=
 =?us-ascii?Q?K+aS6BF7lAM0Qd2I81z5JxgdjCqQ6hw+yv9aNKoIcJ7xyoO6V6DS0/j8RKyg?=
 =?us-ascii?Q?5a2XEDVEMeq9e+pFSIXArxvbl8+PRsw0l211nTHJ5b9bGIIhiQpJGSEIsjI0?=
 =?us-ascii?Q?tuYMqtcX6SoItfEWCA8tmtMARL1R2U3ZLc//XNn5o9hOhBa4GhCCVClPvpDB?=
 =?us-ascii?Q?Yxfzjmr7CgXrgUw06vl70qFWQjM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bb3971-824b-4656-8681-08d9bfc33e38
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 12:05:53.4544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITZSP5fnCiPiPgKILi73IfCs9gzUJm0rRTaLlxZuRcK92J+Bz/elCLm20U8scJO4Eg5/QToO6ybkdP4vk9IVuELKq6bN2N8HQuUJkE502HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5571
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10198 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=994 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112150068
X-Proofpoint-ORIG-GUID: Q7cV7ir8qPshRonS5BeWxhL8l0RTVm3d
X-Proofpoint-GUID: Q7cV7ir8qPshRonS5BeWxhL8l0RTVm3d
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 15, 2021 at 12:59:27PM +0100, Jan Kara wrote:
> Hello Dan!
> 
> On Wed 15-12-21 14:42:31, Dan Carpenter wrote:
> > The patch 957153fce8d2: "ext4: Set flags on quota files directly"
> > from Apr 6, 2017, leads to the following Smatch static checker
> > warning:
> > 
> > 	fs/ext4/super.c:6779 ext4_quota_on()
> > 	warn: missing error code here? 'IS_ERR()' failed. 'err' = '0'
> > 
> > fs/ext4/super.c
> >     6761 
> >     6762         lockdep_set_quota_inode(path->dentry->d_inode, I_DATA_SEM_QUOTA);
> >     6763         err = dquot_quota_on(sb, type, format_id, path);
> >     6764         if (err) {
> >     6765                 lockdep_set_quota_inode(path->dentry->d_inode,
> >     6766                                              I_DATA_SEM_NORMAL);
> >     6767         } else {
> >     6768                 struct inode *inode = d_inode(path->dentry);
> >     6769                 handle_t *handle;
> >     6770 
> >     6771                 /*
> >     6772                  * Set inode flags to prevent userspace from messing with quota
> >     6773                  * files. If this fails, we return success anyway since quotas
> >     6774                  * are already enabled and this is not a hard failure.
> >     6775                  */
> >     6776                 inode_lock(inode);
> >     6777                 handle = ext4_journal_start(inode, EXT4_HT_QUOTA, 1);
> >     6778                 if (IS_ERR(handle))
> > --> 6779                         goto unlock_inode;
> > 
> > This should set "err = PTR_ERR(handle)" right?
> 
> The comment above explains it I guess. We don't want to return error if
> ext4_journal_start() fails because it is a "soft" failure we can absorb.
> 
> 								Honza

Oh, yeah.  Sorry.

regards,
dan carpenter

