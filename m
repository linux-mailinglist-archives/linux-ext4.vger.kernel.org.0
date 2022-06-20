Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FEC550FBF
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Jun 2022 07:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbiFTFpq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Jun 2022 01:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiFTFpp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Jun 2022 01:45:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5501CD113;
        Sun, 19 Jun 2022 22:45:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25JL6jLg026764;
        Mon, 20 Jun 2022 05:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=4348F12XwM1zYmcpNFrTFrtwnFFYFBElN3ox/g2Bf00=;
 b=MiOka5Nd8CM4tWa8MTcTTEL+LS+i8dAKcPDdUiXqwPUaXa9mI5fLao+LpwOXXhI1EfdA
 qRY9ZRltI9/KyJHiPR2J3YDm4mea2UJi57lK8jlxMRQu0i7/EbRxf1xAR+T2rwTYstzh
 5yzbzZ+A2tpKI47u5JauPpDy72vlPPDNyo9qHiHl1PeEdbPUk6sJQuQL4gp49RThZ9AT
 mLOmsY13f2nD+KGS7yahejgGSmlYDBrLqYLtUweq5b/FABpYVNsHboH8/kpDSXp81zJM
 32IegbcDvqkNNrdFtMK34FLCSP102EXQxPfcWga4J96l+Mo6SvJey4HlAgotNuGydXfG Ew== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf28dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 05:45:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K5UPPZ021655;
        Mon, 20 Jun 2022 05:45:36 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtd9sw07w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 05:45:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZnyZzRBPKqyGdzGjlv6tmr38HMFEi5pUeWPVb9+LH5zUv6SKdFabnAEy2BAfgQcIdgEBw3Nfe+L3Kle51Dstw3h43wLxCDaGYZ4VC8LWVJcD1SyUMeCs8ArfPN1bgYHUAMxXzneZZeYCRaFXL9LIT+22snOl/qzOuLG3GTNH67+ju4qgzjzR/98WKPNej1g7ONR3H2vNgEOWJ88mUHaur/QU6thJlQrJmVYsPR8zie+B62EEJ1Df8LboYlKBRXWCVYQZL7VgZuQUZCtJpw9V7WWKvMPwMto/RcFBeYvyuxD8tbBGxkGWap7FOD4NgDM04et1vqoeU/r9xQJFsqu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4348F12XwM1zYmcpNFrTFrtwnFFYFBElN3ox/g2Bf00=;
 b=nBkWXzQ+h/+d/roNodp+k+EUfVFZQSJsY5E+DdKyraEIbzNCjRmJ8KDHCpkScKvmLe6icbnuet9cbosq94JkaAl1CFpHbrKBT2Uy57ZjTdEEsM2uw1PY/J7zzEDozp2QaPRCeCW11fk9psU0aPP0M5dTONb6FY35BpemALcXwLpUfjGm1XoXfUP3JLiqbJOK/mZ6Vsbn4PjGLO+1v2lGRj8l+QyIzp9AvU8fugPmNCWY8xQPYNYxZjwN22Gh7rIdTCGDINGN+es7TFDZZRZQHrsJd0nqb12ND2w+LIjAT7HhQMJ8wFinGj7K+Kwas2AE90m4nn+SQMPT6UTVVOP9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4348F12XwM1zYmcpNFrTFrtwnFFYFBElN3ox/g2Bf00=;
 b=WPBCekHGT9y1fPC8ClivoxNbekU4UFNsStWCZL20b9IhRum1F5quQHZFgNCK/wKD2WN8qw+F2EA0ujDI3zQtTw46fF3TvXvXdUb8fbQyWRM8J1MCFrYFSvpboFn1l3rfn9kNnRzhjAonq1fWRNf82qqezBEq/RzTT07DqnXQFgw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN7PR10MB2515.namprd10.prod.outlook.com
 (2603:10b6:406:c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Mon, 20 Jun
 2022 05:45:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 05:45:35 +0000
Date:   Mon, 20 Jun 2022 08:45:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] ext4: change variable "count" to signed integer
Message-ID: <20220620054514.GF1999@kadam>
References: <20220530100047.537598-1-dingxiang@cmss.chinamobile.com>
 <165552108974.634564.2634497659089601268.b4-ty@mit.edu>
 <Yq2bzesQ5H+DrA47@kili>
 <Yq5QCJI7qC80AtxL@mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yq5QCJI7qC80AtxL@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c950e9e4-771a-4a77-ea8a-08da52801886
X-MS-TrafficTypeDiagnostic: BN7PR10MB2515:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2515D5672A486C4C0DF542418EB09@BN7PR10MB2515.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: woeIQqdGLarpSe1A0cec0SlrjkkVdjUP3mHol4wYK4ypWjVYNibZCsc9vKBi3OyBfM9oaQpd1aj4jI4FYkXZRiBkSB1E8cJ/WL+/hTtzfiPDe7F5JfLfA8RkVS73G5iP4KC+GnUdo1i7AZSupw3ESRD76MsUtHtyi8H42TZ8l8X1Je1LqL1GUnPqMYODQkq2bP/L2AU4HdX0v3KhaXAXFOcLlsfN9uNkO595X+3aKb/TDIGu0FPKSnQwY93yrU+n5J9d6tK+7CwYc8byeLXM8PMeNRDcixV5jIaEnY02hFAgiVa5gLh6n+OcQpQMEdMtzeCxjZGCygby6yEch0jLjuV8W5q3S9Jkk1VafqlsIYXVo9YGJpOqf5PS0H/LbKSmnQ63O5w8+bM7K5zr8ebdB94BG1SZjnD85Awo8rl4eju1YA+SyaTsjQa4qBRdVDGSAiGHMxMWIxRBmb5FS1rxKZPEKtyUotpLvrV+GIIulxmKTxNXRfENDHBKLewKKROPVGRV9z+U+pXMUqK+XYuaUiEyrxZJOBHR6rdgtlUnMdTHcpov3O5Jk56MxykVOCqLB+VKfdpEDOEr3RDrPpWH3dvyQ2fgqglJCUyf9uzaqokGWyY/F2Mj3UrUuiWzGIpmMdzwJA6A5/03Lc3cjoSAAmgpXZ8N7x9/jtCwVA+Y7OM9eqOP2Cqc6ywquPg4l6ibzMe5i8aTm30nky/YaT5e+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(66476007)(6666004)(66946007)(66556008)(1076003)(54906003)(8676002)(186003)(4326008)(9686003)(6512007)(26005)(107886003)(52116002)(6916009)(6506007)(33656002)(38100700002)(38350700002)(86362001)(33716001)(2906002)(6486002)(316002)(44832011)(498600001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Boxdula6V7HaQES8keBCYgBnDvQxXTyT0mGQqpzqo6ebis57WRcz754YwKj3?=
 =?us-ascii?Q?nZ8bqYKWjHwC5+kXFKkc/JjpMcRh2btgBV0glUgtGvQWebEjS7JIp16RUUvs?=
 =?us-ascii?Q?SAJzOXizePb65FvHmBv4pDTp5fWhlYqTqmSwCLV+yVPB16mMDehEx/NzztUY?=
 =?us-ascii?Q?JOCXeB+QdjLgwROqTRSHS0+sVODBwqg4yjqW3IUEaBJskqbNftjhyt3c3lYt?=
 =?us-ascii?Q?RopfT/3XWDVAt4gx5HfntFlfLoII66ewDMybb6dtSvQKR+RCTk7s6jaZvB5V?=
 =?us-ascii?Q?5WvTaV9uBqxcxI75QEQD/6EPnMkX/xIBgkExH0gv/AEFDneTNymlNVnf2Liy?=
 =?us-ascii?Q?gvLlRcQaQD1xo69ISrlhKYSm5715vt/jkVo8m+617zjavLGeJ3Wqj/VhKUqn?=
 =?us-ascii?Q?oNZGh3iOi3PxEuO3tCSe+i5ftifcKhuJSGy4MBqeMy6j/S3fU83BpFzkFYrm?=
 =?us-ascii?Q?lIPlASOi+luOfQ7lYadYMCepX8Fm9GaYQPNXrKKTrI7aupnH6fWx2sjOsRtD?=
 =?us-ascii?Q?mcEM/rU9ln3mXtAWnHjED6Vmc6Xny6SIgOHEPQG+u/pz2kD+8K/XE+T93ReW?=
 =?us-ascii?Q?WITQdQqHFqf70JlCNXJl+2cAednUcgHTSeERkKj/qvahThr2Y38IteKK4gWT?=
 =?us-ascii?Q?u/X5zm7kKKeqyNssO6vi+3KIzRqV9fzDDSSj+bvnmATc6ulzlic+zXCnzwEK?=
 =?us-ascii?Q?xlb2LBKR6WHw33mzxE4JaSdLeqZDQ9S5+SCt2A7jCS9ktS7a2kDlo6b8k4zs?=
 =?us-ascii?Q?HoqxGUieHXBRGScJFXxCumP8AAyO7nAQPxBSw+Fp7d/vC68dkAR7kWdrpKlu?=
 =?us-ascii?Q?O3vcd1mzLdB74lkUwsRJRczzFQ8fv5hsawLxdY2C314T08DMmNPNZNEiv7o6?=
 =?us-ascii?Q?HPRD3rh22j/TKUthQXp+FuuCbMerlQh+EPGwt8EFUP+Ul5FJ5fjbQQmvjyFI?=
 =?us-ascii?Q?Bp+OV9SwdkyFdBpkKXHK0Pn5Un5UlmkeY+YTDmJBD62OlhVJkm+1tH7vX7o+?=
 =?us-ascii?Q?w9LJnmoQeSCD8t3Wrz8PeNJE8bBw5yTYRyl+aSrKP/Te5+SVRXQZxlFA5lNt?=
 =?us-ascii?Q?riY6L9SDjD4DXQfSYGiF8zFLGWlgWrQ01F9vQtiQUxCuNx4SJB1jwc2Z109m?=
 =?us-ascii?Q?2bqpSfakLGyvFaI87POD26nyXk7YeaaSJ39oPXrMA88iXpE4kd6/66Tdmnvh?=
 =?us-ascii?Q?c1buoYF5eSVKH5j71SalaoMFmPtcSi7MtTXrGKnWFU7QX2+aptI65rtQmV8j?=
 =?us-ascii?Q?rSgpdzXm/Y3ATVKEnkUstlFD+WXOaiYRkV1GAZv3yvGX7hUUCHyYUxeP3Zyh?=
 =?us-ascii?Q?Y8jYJ1Mx/nkfNfBo6h3kAnJxioxGBljQ3hBLw9OHvu2tuKZTBvHDqfdrEGrj?=
 =?us-ascii?Q?g9jP5cro/K82JHUxQC+9LkzcN4l8qlftUFmw/SJ5J45aL2vVbJCAey9G/xPZ?=
 =?us-ascii?Q?tysGEKrwnjHMQ6nCqByq/GuwdvAprJODHWHC0e9mr6Xg/oB9wSUrf3VZv8Tu?=
 =?us-ascii?Q?cH31LGryhe5jUHBytdN4+m4m6Ct/Y458jXdqRpO3Y+DdIFryz7Ed704aLBxE?=
 =?us-ascii?Q?4InRBfcmP0njnUfq2C3kDHSMXO+HAsJ/q6ub0gYJp2aYRJp4vycw9MKxO3rz?=
 =?us-ascii?Q?1IdeBIE9A4BgZVSGsZossB8DdJqdKkyafJZ55bnm4qDWTXZB64SSakVkC8zB?=
 =?us-ascii?Q?vOJN3aAwXunRUIufaHNZ4r6tTyjY2A7c9wux7MIBad8X60EXFSa4W08JUXxW?=
 =?us-ascii?Q?yrob4OFiW2OKOMyxUOJT7RdGJU8PbF4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c950e9e4-771a-4a77-ea8a-08da52801886
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 05:45:35.2132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmzyGxzCWi2QeSU9Vl/FOYSev9tfjeeaODRsbm9P7tCCAdRZ1keST+SWottKwQELIOibEez2dCUCRmFokYZ/1RHZBf6TNFyEx97ku7xgo/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2515
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-20_02:2022-06-17,2022-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200026
X-Proofpoint-ORIG-GUID: pzvYTaUjGU-GwR6oK1k940bbnm-oGYkB
X-Proofpoint-GUID: pzvYTaUjGU-GwR6oK1k940bbnm-oGYkB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jun 18, 2022 at 06:22:00PM -0400, Theodore Ts'o wrote:
> On Sat, Jun 18, 2022 at 12:33:01PM +0300, Dan Carpenter wrote:
> > On Fri, Jun 17, 2022 at 10:59:01PM -0400, Theodore Ts'o wrote:
> > > On Mon, 30 May 2022 18:00:47 +0800, Ding Xiang wrote:
> > > > Since dx_make_map() may return -EFSCORRUPTED now,
> > > > so change "count" to signed integer.
> > > > 
> > > > 
> > > 
> > > Applied, thanks!
> > > 
> > > [1/1] ext4: change variable "count" to signed integer
> > >       commit: fefb759df063599ad483422eb07ef8e14c612cc2
> > > 
> > 
> > There was some kind of process error here...
> > 
> > 1) That commit somehow never made it to linux-next.
> 
> That's I only pushed it out Friday night (US/Eastern), and Stephen
> Rothwell creates new linux-next release based on snapshots taken
> Monday through Friday in the Morning (AU/Canberra time).
> 
> Things have been crazy busy, so a last set of ext4 backports only
> happened Friday starting around 10pm localtime.  (Yes, I have no
> life.)

Ah, sorry.  I didn't look at the dates carefully.  Thanks for taking
care of this.

It's so weird that kbuild and I didn't send this bug report.  I can't
figure that bit out at all.  It's not super common though and other
people are looking at static analysis so it worked out in the end.

regards,
dan carpenter
