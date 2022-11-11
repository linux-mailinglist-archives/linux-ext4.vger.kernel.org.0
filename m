Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128F2624F40
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Nov 2022 02:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiKKBNa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Nov 2022 20:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiKKBN2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Nov 2022 20:13:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F2E082
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 17:13:27 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AB0ucZc031672;
        Fri, 11 Nov 2022 01:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fyUM5LT9VzKCz7vTDOusluk++QRC0bkmokEUomPqEIs=;
 b=qymx7YIbzQPP16ERvHQQBAZt53Wds+Fduq3CFpokvKQo0UYZuWtGk8Q753O8+oBdTi+S
 aHc+Rb7i7Baw+OCb1UWzjkXE9s0TLs2Ovuvl5nbZMhYef8Y5RLUd63NzLhGjLMPZ6WnK
 EX+rrpC+jpsOIHj2tXkiQFYht2uOKDq+lDkSkfDInRXzJ7SCLrQkEwvr1w+bH4agUSjz
 MxNSw0uRifpIYQd1vJjKBSePRd7g0ASZvb2zI6wU2IFOs1yFYGR3MSbLaqn8nJIRY65R
 i0cC4G3nzWd6s+ofnhbhqZiRmT6qi385KTqfuvvX38/Aea8nSCD0yocBHx8TgpGMQLw/ yA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksc9bg1je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 01:13:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AB12uRd014878;
        Fri, 11 Nov 2022 01:13:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctg089p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 01:13:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grLeAZdzQaCV4k3aGRYxQXr+9vEX6iSuu8xidac/xyyyTMOtsK5ZcXceDQ235a9K7FEzQ4kmK2LUEake0PL/QEcD/Gv0TGdhTwlIs6tTLKo11nmFX6O6FOYgvonau9mHG9ELAwuknaZYgjAc3q3y7Jwhid0yQBB5nBnukFgIiSCHqFvBTi5p06IxMwZVq6Vktq2P35e5POxG0+PQkfsaulNfCfx8GopuqATV+PO5FdayC2/48isXH0QmaEB3wTFhyRv4Wr9EOdtK83r9nVUrrvycXn5Ge7f+UK8Uq6k6x5wrfosFvMT41p4P9h3m0ypjo/HbmBA1v6Dwt5URvXckOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyUM5LT9VzKCz7vTDOusluk++QRC0bkmokEUomPqEIs=;
 b=d/5CsoRlPNqjRCKYlBQEWA4ZUEUpknQOF0554muLrIUefZbBEYNE6cI4K5Irl65Lq5vMD4j3kcO8UtkGHaUo0Vc+5HlWFK00NhRWHfsm+boF5VHp+HIPJpB7sgKx5g/AKdqkV5peLtJfSPTzcRadeF476rgKiTwqh254igy/XNQz8DRkcaX7YkvrIpslVoEOlZ4aVQfS0+ib1F7vudaR35qJMAUUHP/IzelVDlsHyrMr94fEiKIW1m41UbY2DHJqILqjAF5ZxmnIByzTxqcexxwvPtUviZ1n4WKx9rJyfDzQ+cgBbeCn2mTMig18mtIH9Q8rLa+sMz7DewlnWW+6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyUM5LT9VzKCz7vTDOusluk++QRC0bkmokEUomPqEIs=;
 b=FsMmy56p+uXBpp5k6ctkRqJrNRrBO4r8OTTgiXZtGafWhLW0veLSxzMICcdzp7WSJD12teJQpUXxWosBsfU1GZl27JUQtE2Sm3AufdUwXJRSxTIULj8wDDcVR4IUduwSxRuIf2zzEO5eN3MoEq0cwfrr5jTeRAytoJhyxJwYzas=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by SA1PR10MB5709.namprd10.prod.outlook.com (2603:10b6:806:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Fri, 11 Nov
 2022 01:13:17 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::e1d1:c1c7:79d:4137]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::e1d1:c1c7:79d:4137%4]) with mapi id 15.20.5813.012; Fri, 11 Nov 2022
 01:13:17 +0000
From:   Catherine Hoang <catherine.hoang@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4: don't fail GETFSUUID when the caller provides a
 long buffer
Thread-Topic: [PATCH 2/2] ext4: don't fail GETFSUUID when the caller provides
 a long buffer
Thread-Index: AQHY9WrHChlRScWowEiw9BRQJ/ICWw==
Date:   Fri, 11 Nov 2022 01:13:17 +0000
Message-ID: <A4F1A09D-AD40-4572-AA33-FF0ED0A3AC73@oracle.com>
References: <166811138334.327006.2601737065307668866.stgit@magnolia>
 <166811139478.327006.13879198441587445544.stgit@magnolia>
In-Reply-To: <166811139478.327006.13879198441587445544.stgit@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR10MB5316:EE_|SA1PR10MB5709:EE_
x-ms-office365-filtering-correlation-id: ab767280-7540-4e03-52b5-08dac381ea44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xPXUxaT6EZw940QQVwWrER2aIxN0gdDHx3qMoe3cQwG6Bd3gBw7q0bLOszQZpylFGBO2zYvnZ7mVth9p0bMhFc2ezd1cY4mLdYpCvMi1mmHZfonumhTZPIYb/xLpwYweBJT/BHFOEpoXfRhvkWtD+FuQDcD+VafouPBPvUwqXOw2N4/k4ftd/IUbwPfVCRjBn5yOH1IoMnCvDrggnbfMeStdwzXeh9J9NYXe+uCGxU77bUSbB0pdYDeL2ZKv+rLXVQU81XtaBQBNo4umWnCQefvNk12GtKEuMRw3ZeK2uw1D0/b/C4x5FTeYVC8DMPRYB8d3/YLcJq7AI2ImND0U5QYi69gdeYh+F0tQPK/jxfR8fzRmLixsrYOHvSY5wA/b76MbQ8uJ5xQlYQpzF+u/1FLnuw0Y4a2nahOQZIwFcf39gbm1PuVTzsysnxbQG7WaYXHTKcstqi+ykctbbt9JD/NePskP4nG6IO5pw07EsDA6D1+rgZ6zOdsxP8WRGGBBKQ/1NdfBOUppJSmqnAEzHRrp/Ie6NJ44VvUxxHIyLf8ClZ/8emVu4XXFW/kT4GgPgwgCoROX3ANtAbBOI8MjCRUrStUfWZOuSQsGHCmcE/bF45BXSE3wpMbXDzHmdjbOhytXzlfHrzDoPkyvvPT4Dac8HlX4D41MleP9vQAp8kE8smKFSKVhizF5K5uYxwWg+sXDOlnKHMib5CQ/o/eGByFfe8X3CwMm7YFf4qGBOrZ60Lq705Ebx4EdTMMY04Z7bjgdqBCHBd6xA0n0WfSKE5Hr2ASIQjDFowUN2pCFH2o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199015)(2906002)(478600001)(86362001)(38070700005)(66946007)(6512007)(66556008)(4326008)(8676002)(64756008)(76116006)(66476007)(44832011)(36756003)(66446008)(33656002)(38100700002)(186003)(83380400001)(41300700001)(8936002)(6916009)(6486002)(91956017)(316002)(122000001)(53546011)(6506007)(2616005)(71200400001)(54906003)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AVRlYLg6BSQ2jWyeRhN8qHgOzrSTuLKuwKWji+nCXl7gZyZQb0gI2hkOiV8Q?=
 =?us-ascii?Q?C/DxBGrj/n7vQMftSAj+vUUmR/yB17wQqxxfP86pdnUAy/Ds05kp/+O/tARv?=
 =?us-ascii?Q?UCGB8xozrmOn78jdGyDBgbWKH5yQR70f8op/v2nYELulgpjVPN75Rl3vnzBO?=
 =?us-ascii?Q?YYYTG8cUyFVXouCHzW9SlugzRApVIu3aMCjeXUq1J0Ez0nehhDduvGPWeLfB?=
 =?us-ascii?Q?vLk8mdEgfWiPSAzGEy5MN306QVabSFo4TAbmgX/DRjiOvFTZCsYwpVFfFTDh?=
 =?us-ascii?Q?Pi/34dCf8NPfWvNRmNUbSQFgesW0anQDNiQkAnX/fcB4ZLZNjWoh8sg+brDv?=
 =?us-ascii?Q?FzCoNidL/uFm4OI7La/tGdbeqQ6h8A3LvH61z2e3JtoFb+2NdVEiSfLNddMS?=
 =?us-ascii?Q?PlqN1eWaLwkYpRidqfb+z2uSWwXTxBAjMsrdMi+ZbnXH5ag14ysKyp5y4ez7?=
 =?us-ascii?Q?UjFx926Zz86kUZMyMAlLGfOEkfJJWeuEnP+k6P11gNvoeVyb80y6TpWLQuHE?=
 =?us-ascii?Q?KOMG6ESzSfWWeufM2A/0cTdQXhQ3oCGzRI+VGAPTdAgDGVN+zNMsVOpjQgEj?=
 =?us-ascii?Q?FV9d10vdPWdjYZVf74wDA+zbUlxi13YEKcJtAzL2s29LfJ8spCNZUZWepgMe?=
 =?us-ascii?Q?qVfd0y1O0bZvHMFZ2IPr0ky3fWhfa0DDckUVFygfMZY3exZZqbqfUUisf1x2?=
 =?us-ascii?Q?xxwRPohN52TqNpNNku4HaNOsuOmUy5ayknJ7g01/oOQv50V9e1Mnn3zhK7qO?=
 =?us-ascii?Q?W6/SUKi1xHaJ8KOl/Z2lXzt3oFPEJbZ2ieEam8e1pnvyrcAyhECyPbAqvSjn?=
 =?us-ascii?Q?3PcDQVN1SI7Gfp7d76IAqbHdYFkn078Us/o8YGVTGqhxytvBNjOawoWnuNKA?=
 =?us-ascii?Q?Vqn2rUHk5uTh/4SkDeITLVN92EscthjhHBbAcRgHUERxLzpkiYcnY5VTkq0S?=
 =?us-ascii?Q?4Oi4cqdPn8OKnEsfU8+NBfR3Yn3l4Pi4m2sf3MkwLLOqzdtFEymjtVZGiwas?=
 =?us-ascii?Q?xlXyG5HMIhekx8mHPfm8TlV7GT6o9gPraBcaxxG3J/7nJeHMSb/a55XckDcM?=
 =?us-ascii?Q?QQffj69/7pUYmSEvvRa/+FUu2X0TZ6sqLvNzdFFMfCQM/yifK0RVDyN87+FT?=
 =?us-ascii?Q?wNbcZOsQYLCBYRqGP3r33kptTTNVlzayprgZ65kWUMYQ0CmrxZ6kqEQNdiWg?=
 =?us-ascii?Q?k6zYEAswXZSZxsAskKyu4WT0klhEp2mfeeOEFcwuxEDameAFTpYyJKhgSsll?=
 =?us-ascii?Q?/zNh5VfBPEy2f7kU5vfj9BdyyH6ZS0A/KrrcjnIipgFlX39OQcxKMgn7hkaO?=
 =?us-ascii?Q?k9h3ZytVblEhSxaqz6NXSe2Tj54rOuO7DxqXtD5FHDLY/Rtrfj4I185jU/L4?=
 =?us-ascii?Q?4LJnE+y6w+Zd2dPSvYsHc150sWSLu4VSJJOvDoGEWQCHR9/uZnU/TTcrGlw+?=
 =?us-ascii?Q?Snv77tairEcsz1pFIqk9bOnwcGMuI2eC04twoXliXTdvOmaWVesTNd7O0UI6?=
 =?us-ascii?Q?lljMpAVHF/oxJgsv88bG58B+Sp+Ia1CzspzvaOMQwv6icSogvCFwCEc/UGVP?=
 =?us-ascii?Q?+dkG4Ecfhh0GA40fKQJ9aHkFb6EBXa5chJTlPPQw1AmvPA6NBUE+0GPotLno?=
 =?us-ascii?Q?XP5SVeIWSHDQUQMpXMGECK4mr4CTu+k47Sq6qjeur8tMyKaP/6cd/tm5gkaM?=
 =?us-ascii?Q?Fh7dRCr1iGbHUB6QGr7Gxx8O9JQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14A2531C157B4042BE8347E816692E2F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab767280-7540-4e03-52b5-08dac381ea44
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 01:13:17.4409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4dZbtWgu7CW63YVM9LJ6t8RXhRIrxJE6oneNPV1yNvuzcQ3R9JE8/fibwnfSLm/m0UPFCFHAlDb5qQJWh7I7MmwJA0krbdRz0siz1CvIrEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110007
X-Proofpoint-ORIG-GUID: YIRoaFE0vGHfASBEEIbxRIa1HRcgmLx2
X-Proofpoint-GUID: YIRoaFE0vGHfASBEEIbxRIa1HRcgmLx2
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
> If userspace provides a longer UUID buffer than is required, we
> shouldn't fail the call with EINVAL -- rather, we can fill the caller's
> buffer with the bytes we /can/ fill, and update the length field to
> reflect what we copied.  This doesn't break the UAPI since we're
> enabling a case that currently fails, and so far Ted hasn't released a
> version of e2fsprogs that uses the new ext4 ioctl.
>=20
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Looks good
Reviewed-by: Catherine Hoang <catherine.hoang@oracle.com>
> ---
> fs/ext4/ioctl.c |    6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
>=20
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 5f91f3ad3e50..31e643795016 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1159,14 +1159,16 @@ static int ext4_ioctl_getuuid(struct ext4_sb_info=
 *sbi,
> 		return 0;
> 	}
>=20
> -	if (fsuuid.fsu_len !=3D UUID_SIZE || fsuuid.fsu_flags !=3D 0)
> +	if (fsuuid.fsu_len < UUID_SIZE || fsuuid.fsu_flags !=3D 0)
> 		return -EINVAL;
>=20
> 	lock_buffer(sbi->s_sbh);
> 	memcpy(uuid, sbi->s_es->s_uuid, UUID_SIZE);
> 	unlock_buffer(sbi->s_sbh);
>=20
> -	if (copy_to_user(&ufsuuid->fsu_uuid[0], uuid, UUID_SIZE))
> +	fsuuid.fsu_len =3D UUID_SIZE;
> +	if (copy_to_user(ufsuuid, &fsuuid, sizeof(fsuuid)) ||
> +	    copy_to_user(&ufsuuid->fsu_uuid[0], uuid, UUID_SIZE))
> 		return -EFAULT;
> 	return 0;
> }
>=20

