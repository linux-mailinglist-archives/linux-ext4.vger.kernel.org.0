Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5300624F3D
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Nov 2022 02:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiKKBL6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Nov 2022 20:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKKBL5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Nov 2022 20:11:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2159B45ED0
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 17:11:57 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AB0uZPs031623;
        Fri, 11 Nov 2022 01:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=djMJqjhfIiuTmDNd+8I1tTB4N99eHFMf4ozrrLpP/xg=;
 b=pcMtqmdnrSBlhsCZI0ax5xyOzhcTGbwMjhhiWZKhpbBWUBnX9l/XXLxrYeddhuMUyPJg
 qnCURsbfnndQ0aK9S5pJ307fwKAR2VBvjRVtXXXzgnhHOqf7O6Sm+MYXz0hdqbjgGO+R
 AAkcD+4+/Fg3ratPOTVkJAGCc+OaD14J0wbrj5Z/EamB0MZRp4XXOIeO2t2jpDGB+j+V
 yrxQOBje2DARSPXY6QL3EZhKVbRXC86aEz5aCUtz6n2P/9Uf5LIYp8TcyxqHtdkWSyYZ
 /e76xPDYk13n8LA3/gPHftTIhdT+cVw9f9uWjz3k3hqTFZr9ijXUSyFoo4F4tioo5Gt5 GQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksc9bg1ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 01:11:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AB0eD9m019786;
        Fri, 11 Nov 2022 01:11:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqkvs1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 01:11:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Befb1sTZGeWM5Rrh9HnSkoShRfUEnw37vJNyAIUipglYMNruf+Q8BXfuda9RojXh4WPlX5+jrUTHG0GQpxLUgY2DZDaur0565g67kaBlIphVzsDpbyh00pHsHOLm1cxHvjJ7wLYPaLJAHOoom0HRIQI5YiMTUmwA54z5EEzsNxRClleLW2nNhXwaybLOvffY97rDKZY0bYijnsq9FOnmrzmeM4ctVBmG5kIa8tyqbmQqwK+5PmCouoC182pS6pkVgtg3ux2Gon0PDt0tyNWO7awNzve50N+87Zs6tM52TJqpLj+gBFhcai4rval1InOroweuKRgITeGAd9sG8Qg82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djMJqjhfIiuTmDNd+8I1tTB4N99eHFMf4ozrrLpP/xg=;
 b=S3JUzbrIHv9aNIoHNY9Ia3m2UHoPK3HiC5hx6dFpsIwu4IN4mSEhfr9wF+n4Lu9OYM9njlTqxio/ok3IB3phXOKnM3XTddTtsPi1RadUt5+NHAQlU51U5+JQrBqq+fdr/vVrthOOSLzCRRFlfRK69DFpEiRwrzAmSCw4n4CIf+N8UiCc5v/Gb5vwsbzBlAGGG4XFPHaPgEUbDngo1+5nkGMubkT/hYeL+aFuZ7s3lV1o330An0cDwFbe/kMw0/8b9goCCmPeF1DgGdfFYaU/sl2jhYAQ/9KVRDenalWz9vTv6207aYQoPYoG6B/JhmpeoJ5SyEiqXxQP9dSPXyywjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djMJqjhfIiuTmDNd+8I1tTB4N99eHFMf4ozrrLpP/xg=;
 b=tfw0VZ65FAcZz9oBzl0t8V+eRk2JxksNprpfJ4EUhHw1mEs57PtIq5xCKoazgJzBxvjhGek/GwghKShZ5g9DJ1rYncPS3tEhK8GNDeeNeJ538vGifGReNIlR20K44q5i/OZQNnkZjlILaY36PwpQ05PYh8GPyH3haV8OIELjJo0=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by SA1PR10MB5709.namprd10.prod.outlook.com (2603:10b6:806:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Fri, 11 Nov
 2022 01:11:45 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::e1d1:c1c7:79d:4137]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::e1d1:c1c7:79d:4137%4]) with mapi id 15.20.5813.012; Fri, 11 Nov 2022
 01:11:45 +0000
From:   Catherine Hoang <catherine.hoang@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 1/2] ext4: dont return EINVAL from GETFSUUID when
 reporting UUID length
Thread-Topic: [PATCH 1/2] ext4: dont return EINVAL from GETFSUUID when
 reporting UUID length
Thread-Index: AQHY9WqQ/3hj9B0OhUi2bdrRMa4LKw==
Date:   Fri, 11 Nov 2022 01:11:45 +0000
Message-ID: <711235B4-EF8D-4081-B9F9-68F4E9E6D1D3@oracle.com>
References: <166811138334.327006.2601737065307668866.stgit@magnolia>
 <166811138914.327006.9241306894437166566.stgit@magnolia>
In-Reply-To: <166811138914.327006.9241306894437166566.stgit@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR10MB5316:EE_|SA1PR10MB5709:EE_
x-ms-office365-filtering-correlation-id: 4e862091-f610-4299-888c-08dac381b356
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bp7vEyauOzEPP8pEQDvZLUuwrAV1gbiRAiVh/XSUbuFMPVkAgvIoNUOj/m07xp3A1T1VSpRBoJmQtp7AxCAfzN1JxC39aVbdyUPnU+jkTkomurzGWemoHwhkXqrWD8KrvFjcBx8mhCM4CwDiQOzTbBhPYfIegkmL4B/WUz02V1xZ8938pqX2B7wQ3n13PmmhtyujyRw4bHeM/0gyDeEi0Wg/WvjxsQKfWfxDVABXJnR2JL0lQPyIjIgJI4orGBVO5pubRN8Y/9mVcjI8hQ0jKPvWlHaocLku4am5kTyf0EfKx0ykNSlsRzDV+SP734jE7uikT2BTSU5PwATo8oJdoqGr+M8t3E7CMEb2k/6+xCJJVM6QumjBy7gupnWrJgMXbK8qs1h3P/CdkaJs99TirDxFgZVMZBFocBCOXTrrtZB0aF4kY5TSxO8MvKIov3/Dk2Csk9WuC7lziskykkj8XEdcMbSobIyQgGqcOgMzqgrOdFPuvkeNG8tIQ5ipyVNqNfBKRRhgr9S44J5R4jvELENfnJqZDqQNxAAyXJs7a9NC8HH2gyeCXGSiLs3DMRccky95EYCPxdWLD5RlOVFX/tvMgeoiKt35mtHvZlnTlhCyl0c5PbXZI+IXejaSaW9VaPwyKROViS1o+OcykKV8DQhAoXoexMo55gHAkJJRymKBSGtvj3CCkjuBRNADl5ShV7N2plr3EeCEwYkmU4UNuh8ZjZQ1+TfWtJIXu/6Bayzxb/n+x9cTtOPk2cKvRM39SkgvNqvohSut9/XIcwGV1QVgbxOCiec8Z0fnUwPoiiKoCJqCZXD0iAwsca7v/TSX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199015)(2906002)(478600001)(86362001)(38070700005)(66946007)(6512007)(66556008)(4326008)(8676002)(64756008)(76116006)(66476007)(44832011)(36756003)(66446008)(33656002)(38100700002)(186003)(83380400001)(41300700001)(8936002)(6916009)(6486002)(91956017)(316002)(122000001)(53546011)(6506007)(2616005)(71200400001)(54906003)(5660300002)(192303002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N3CzvZliihJ+TxumPuVadOtqRiAhOaiBwFEQoEzgGE12zRzDG2aVyzhLMEee?=
 =?us-ascii?Q?u528y8OSlBEW/TOcFd+Ctgr/0dbPqp2bSEpVS/sDOG6cgyFqPgnD6sCzQLgv?=
 =?us-ascii?Q?dFtk57LoKwELP4fy9A3e/p1MNtbpgHqYaa2P4VnuRqF0nedFnwM7lTWu2luv?=
 =?us-ascii?Q?BERc6IqmtmzfHA6FomJj0F5X/hki4kT/NniRIbkoMOR0VeQxyhTcIxkMT/Jy?=
 =?us-ascii?Q?XqiBGjB046BlcwEFUiLeBwjpOd//Bofp550QhkebIt4vwjgtV5ji84tSK/GY?=
 =?us-ascii?Q?zV+o2trjHJdjuK/rb/UmwUtwfDLK1Ie8OXV4cFrqbd0Ntw3fi4ZpDCIXo9EE?=
 =?us-ascii?Q?eDxw7VKssVIrT52NSy0S29rRTqLVQJVOEpryKHMZMcek6RUj/xeoIIKlAHAi?=
 =?us-ascii?Q?YFLNJ5bOIRA8juo6070hQ7mT+MbI8vFXD0h7mX81tFQcaWxommEKuDRfDup/?=
 =?us-ascii?Q?ORW6Q/Si6DM8kmYZXquNt2c6iHZim2FNeRPDu49Qezgb3wjOmliB2qkQBZOB?=
 =?us-ascii?Q?mlMnK3V4QGa4549quvqh9vmFc9jQ3ywGu6nFAb1ckv5AsMscgiS9xaiyvvba?=
 =?us-ascii?Q?xHJXs9WUM3x3s21rxpKEUyQFrkT3TSuJ78HzvZQoKcAHMIvn/od91Z8DlwMC?=
 =?us-ascii?Q?QbuhX/RSdqrlb460I+oXshbzv4XNGODeB52hCAIK7nWwfm6k4eVpa9NSeAAw?=
 =?us-ascii?Q?PTd7Pzvcf95hG1xXwk+PWFSHDrORM4+456bmhO2qicu4wCLroivjnQyL3TyO?=
 =?us-ascii?Q?ATSYcuZKJCxOgLXXu8hDy37HV1sXKWu6m7Bpsx/V6bWhy7dTEl803BMz/zyM?=
 =?us-ascii?Q?mlJWRvmrcQBVI2jNXh0hbpDDU+vbIN0LUIwZu687YtWQzgDLs4EGuWBLtegQ?=
 =?us-ascii?Q?4fAcED2FNlfXn+j3o+/RWa6dxzNV0LnSkWZEJbX+3zhcejKo9c3ZBck7U56L?=
 =?us-ascii?Q?DXvQ/V9a/Vfm5e1UfgyM2AwbpuntP+6fiB9VwNuGr7Mwo7JdNV8oeUWxoPlj?=
 =?us-ascii?Q?zlQ+fyWgSpAIOatzA4stmlZT93Et1ssFXWVm5tm1rKTci7881pgB0A1Apyyg?=
 =?us-ascii?Q?JSM33Rw8m3SWBHeS8I1bfrBpBzzCcDut89W9uy+IAS+Y2z6lbj1jIvCxiEsR?=
 =?us-ascii?Q?sojGQcISlAjY9RO8EorStgCwDjJrv34YlWXrSiTTJjoIvwyzFmQLEw7xO/bZ?=
 =?us-ascii?Q?O0rAi3QWwk8L9xiW25koniAoEwSxi1k4PH1qioxwyxyNijUoF9HLxZFue0g7?=
 =?us-ascii?Q?mKeq/xmj7pe+66GiXWr0VZs/nRPikIw8eWtBRpKYqlXgJhQSAfu3l7rSexEG?=
 =?us-ascii?Q?B+CTS8dDn/HuULPeaoLnOBAI2U9DBiXb5Ej0El6IjKFSYzs7JH5h9ENtaq72?=
 =?us-ascii?Q?nE4GbO5fDcHZrIIIbxb+STyX+CGS+FpjgsJxDFd6sJEU1yNSzbSF0SlRUGtw?=
 =?us-ascii?Q?puRIqHYlfvVgQ9B0+tUNF4WtS6BPKwvpD0ER6CnhB9WeA2fG2dJeNmGgg7wR?=
 =?us-ascii?Q?avf4umo534VK/2rW69lsNQ4DHo0FasnRLDkQq/DlJjJ/owsUx5i6yHYmFz3f?=
 =?us-ascii?Q?cvHY5FoB/oo98qkQ+CVFLi1L6flfmdr5si8+5R0AHP7D4RWXfbtwgvl0kPxR?=
 =?us-ascii?Q?Ue265rrFSkS9gr3syIuoounGWeCxa+70sr2a/2Ub9oJUVNIMwPCCQ9rNWD7s?=
 =?us-ascii?Q?MlsgbA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C52F762F57181949A4D08704ABF33BAB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e862091-f610-4299-888c-08dac381b356
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 01:11:45.2867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t3qpmphZHengRzpTsslKljLbgX2UD0ywPj5DZFaxz+D7RkkVX2iJQl8OGmon8+0yhzQ/OJ5fF3SB7J0XdFn9tbBXUuQ6Vt/p5sp6CbcuoQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110006
X-Proofpoint-ORIG-GUID: G8K6fqTJsX90M_QZcGFoFxWHHNDAxXNd
X-Proofpoint-GUID: G8K6fqTJsX90M_QZcGFoFxWHHNDAxXNd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> On Nov 10, 2022, at 12:16 PM, Darrick J. Wong <djwong@kernel.org> wrote:
>=20
> From: Darrick J. Wong <djwong@kernel.org>
>=20
> If userspace calls this ioctl with fsu_length (the length of the
> fsuuid.fsu_uuid array) set to zero, ext4 copies the desired uuid length
> out to userspace.  The kernel call returned a result from a valid input,
> so the return value here should be zero, not EINVAL.
>=20
> While we're at it, fix the copy_to_user call to make it clear that we're
> only copying out fsu_len.
>=20
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Looks good
Reviewed-by: Catherine Hoang <catherine.hoang@oracle.com>
> ---
> fs/ext4/ioctl.c |    5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
>=20
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 95dfea28bf4e..5f91f3ad3e50 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1153,9 +1153,10 @@ static int ext4_ioctl_getuuid(struct ext4_sb_info =
*sbi,
>=20
> 	if (fsuuid.fsu_len =3D=3D 0) {
> 		fsuuid.fsu_len =3D UUID_SIZE;
> -		if (copy_to_user(ufsuuid, &fsuuid, sizeof(fsuuid.fsu_len)))
> +		if (copy_to_user(&ufsuuid->fsu_len, &fsuuid.fsu_len,
> +					sizeof(fsuuid.fsu_len)))
> 			return -EFAULT;
> -		return -EINVAL;
> +		return 0;
> 	}
>=20
> 	if (fsuuid.fsu_len !=3D UUID_SIZE || fsuuid.fsu_flags !=3D 0)
>=20

