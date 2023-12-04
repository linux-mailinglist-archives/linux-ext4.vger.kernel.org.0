Return-Path: <linux-ext4+bounces-278-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FDB8031EB
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Dec 2023 12:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8918C1C20A72
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Dec 2023 11:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D965C23741;
	Mon,  4 Dec 2023 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IL8LpZPx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y+quLkeV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D69526B0
	for <linux-ext4@vger.kernel.org>; Mon,  4 Dec 2023 03:58:19 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4Bveoj009002;
	Mon, 4 Dec 2023 11:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=qooj+vv8A2MBVF9W0uslk7ls5iRgyKawJrRcQGToj0A=;
 b=IL8LpZPx8/0O7ETXk1+sQjs6YaqdPWVw3oYkvtyy53pbjKGu3XnOFP0AeHGjOA0Vl8Ix
 hbYv1pKlklEpy/nTOgqim7ZSRRA8Cb7oTFYtEPYndnN5/yd0kvQZaz5wW0zG44gcTgDv
 fFAAOOtaiQNrDgbhtxF4/GSvpaKBMvLFOBW3lZSve6OY2VVyJqqV13uR1efsUbICGj3q
 1J6y3AwtCxrnWarYsGXmSjHwphmGO10/LFRP1xE4Tcc/kV9In2WyVJky6Uf9UQGqCSrm
 v/r8+NkKOS+DTjDQgVkCpHU+SR7ieHd+8BzhtoOoilWj0mFJn6lHFvzX70NaUeV7JebW 7Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usebjr00m-25
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 11:58:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4BSNnJ014388;
	Mon, 4 Dec 2023 11:55:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu15n7g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Dec 2023 11:55:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D47ZJK/YY/ibnjZk0PGVcsC4uGjEpHavnvv0hl4yIB6kvo5l0LmepRM0W2R7I3wVzU00Qdcj4ya4MvXCwKQ/SYdiFUx6b/hBpDfZsha3ehMGTfEUgCcD1IBm4RhNGRGYRiMBUxY1/eTvR7zOPcLBLqQD2xam9+kFwf7BP3du36Kn9xDSmyMRGnw8RRLxB6nRAS4CNjTEBCXcRS7hlbWWTIGomJyxtcWnKxF9Jwapfztg59eCssjVIcZwYIk0o+KZLhHRQrmSuJHNZYU/KUDYCdAp1ypQxtJJswRir13Pa1Tz6ok/JWbtBDUjiedsLZdgp1lmf0hIW5nHp9cS2YCzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qooj+vv8A2MBVF9W0uslk7ls5iRgyKawJrRcQGToj0A=;
 b=lslv4+P/8girRSoyk/ryg7/oJ2lQeiEz05lRmhtBqeeuI1fOT/KMwLBifqp+tZ5SYvddsVYHZ0W27JiZMLe4JvdWYVK/SWG4pDYNDbRqZ1acH0CTsf1dnb1SjNmRx2In/B2qwytL3sWqti89jbts7IQ4Nsg9cFWchRMrHmaU39Eq2ESBj122IdIQKzZc4W+pXcG76UaaX6JB4yc7XRdAnIyVlzcCGDsWVlAUFtkvNr6DQbj290ndY/Juc6irU2UbZemC4sC9fag092USlAijdIEDC/p7dv/sP4txoqjxHoY4bwvcr6Wo86AJMiF264PZBahrJ2IlB8qSlbesAnR4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qooj+vv8A2MBVF9W0uslk7ls5iRgyKawJrRcQGToj0A=;
 b=y+quLkeVibgE4HZhAJdcYGBDGPy9Of/cvFQIJNLB0es8R5on9ac2jkms+ks2JWRQxd2ECf9k+vFBtw3JVRGBdfh5PUwNhG5Hc5KpuKXcTpCRqX8p3b3aw+B4104zJQhilaHNAJoGuGfKzLmbrhu9vDCO54X0xTG6UV4nw03k9W8=
Received: from DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11)
 by CH0PR10MB4828.namprd10.prod.outlook.com (2603:10b6:610:c8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 11:55:02 +0000
Received: from DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::f68b:8982:e7bb:326a]) by DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::f68b:8982:e7bb:326a%7]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 11:55:02 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: Theodore Ts'o <tytso@mit.edu>
CC: "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Rajesh
 Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Junxiao Bi
	<junxiao.bi@oracle.com>
Subject: RE: [External] : Re: [RESEND PATCH] debugfs/htree.c: In do_dx_hash()
 read hash_seed, hash_version directly from superblock
Thread-Topic: [External] : Re: [RESEND PATCH] debugfs/htree.c: In do_dx_hash()
 read hash_seed, hash_version directly from superblock
Thread-Index: AQHZ1lhVKTt2yfxi/kuE3HFdK46bD7CXopsAgAIBcOA=
Date: Mon, 4 Dec 2023 11:55:02 +0000
Message-ID: 
 <DM6PR10MB4347AE8BFF7CBF9920379C0CA086A@DM6PR10MB4347.namprd10.prod.outlook.com>
References: <20230824065634.2662858-1-srivathsa.d.dara@oracle.com>
 <20231203051454.GE509422@mit.edu>
In-Reply-To: <20231203051454.GE509422@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB4347:EE_|CH0PR10MB4828:EE_
x-ms-office365-filtering-correlation-id: e7995a2b-1fe8-4769-9572-08dbf4bfd967
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 GIt45kr6Q5W6l5EgDaGEcsD2JduRtrEdPi5fuXz7nLjE9rCaZOxKN6BI8cC7Cm0ZJVMLaOxwtD01cHmHIXA8VeE6+VQbyG9ZdieKEI02icsKNqOzD6BYb9kkg77aCE+62SczPnbcdIZWl96Jk0ZBwO45bEocoRmBJp0FetSGPGoDHo2zUfKZXwm4J9lpmusO08MGZ6N91S7dCQ4kvJ4z9ubLFFbA8jX+On8y13qtuxY4px7HMMNbV7RzIyTzh+7Azt2X/gttRkLF9ANOjzhG+3tV1lsZ4O/LhGatv3Coj3CFFpg/nrnpK3/Q3iD17U5yaiRqRFEFurI8MesNzKJJCsdhOWyF5f/a+ieKkbGWING7ocxo25NDAAaCcgsPyCl19OhcrmnzaH1mzyylqRabvg1/ObXZxQJBVhgR0QDsEXfagkqjzfjTi0hn4y8M7IJsecfoXqih4K9yHcNfKK3h+uYKMclbWRzmKuqp2HaKCJgsJZWk5JJaf1GGMRF25qklmJZnQqhIKyONCHJo57Bt+gTfrDfphuOBxOk7fQpjBgRjaASF+shFzQD34YF74gDKiFMP1b59XTww5XTtSu0WWnbLRhnkZVAEMPZHE4jZJU7otux7oizji6djWglQKr3twL6BPRh9w8rU4bxnHGnBTA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4347.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(33656002)(38100700002)(55016003)(122000001)(38070700009)(52536014)(2906002)(83380400001)(5660300002)(26005)(107886003)(53546011)(6506007)(7696005)(9686003)(478600001)(966005)(71200400001)(86362001)(4326008)(54906003)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(316002)(6916009)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?tIWMG45BqNVnATBBHfZWW2fJKtjlzUNhco3LSlaIu1OjMryA2ClcMYO3Ly6Q?=
 =?us-ascii?Q?Xx9y35FI/V1cFgot9stT/1fPNqFIYFKmBjHHJz8jVzo1zk7v4myEDPly511v?=
 =?us-ascii?Q?v9WpEmtCAnay8evDCLfAxIl6tCz13QlXZvyyooBV/Y0pWN8ilCrSiK0ZAI+M?=
 =?us-ascii?Q?PN9K+npdYu48OizBGPZnY72esbxT3whOJ7Q87hNDUT3MrE3f2FC4ar6DcBVY?=
 =?us-ascii?Q?1FTRfNe0xoqDRH/h9IbY2JQ05qdYmCM1Lr8mb5thrGkmcrCeP41fSU0Fl+tG?=
 =?us-ascii?Q?A+lXGCB7RJuXc/bCn1HUPlSHbIvMiHG8obZ9EAvUmDifOz9eDIPcijve3148?=
 =?us-ascii?Q?2XUO/RDPxXqxRXWRyqGmjnidK2ndqgQfrkwXeNcUyI9pCS9CDPZIQYEHpjPU?=
 =?us-ascii?Q?REmiUhkANaX4S8iGGqsr8+MkKb9W8Ic66FB1yT67uKm3Yx6SWc+kwRfkJMIR?=
 =?us-ascii?Q?e5hBr3J7qYwQ8/CZA55cMevKcPr+7HeHmCgiaC5N4A93F+9imhHpphacAbpl?=
 =?us-ascii?Q?pEkgOd2rkjIpUQ+MbhojaCGOROmv8EdquFmjop4Dg9wcA/pN5Y+5bbDlWFLa?=
 =?us-ascii?Q?Oe/WmHtD6MAS+mGBg8HSTDDn0eWorZcuuih8Q2KIsIDnt5K6NONSJr6ZKzQi?=
 =?us-ascii?Q?DCEvrksPlG2s/uxi71krsm+uby2vFPUjF3MbEmkSr0fGyu1f/raWG7WHJGFL?=
 =?us-ascii?Q?8v7kJ7Fcr3j67huKY5cwu+/V7SJGX0LbCh4jKlRneuNTq6+g9vXojuHwjQAU?=
 =?us-ascii?Q?rJe7nxPdDLs1MIguuVgEv/wMc7GoRPmInyTVlwraL9CvM43rPYoYjDqsP/hh?=
 =?us-ascii?Q?ULQiLqEiBzyWd0uz2q5iYCs525+jQ+3Z4Kx+fZpF0ceBsLN5NlG6NNFMa9Nz?=
 =?us-ascii?Q?WOpKuIc3YI0NX0LArZxuPpzOO7dLvnqd3LXZ1NmONrDLXGQ+kvAD8WW5M0M9?=
 =?us-ascii?Q?ZTkvBzHFeK4toBLdJvDUIfv84r30o4XlKfY6UK5Lyyb/LDnw7XhK1ul2zc/v?=
 =?us-ascii?Q?xQFZBo3Divp2YD/gM4yDXj/pywkghy0k+bFvggFAUi3ojy2HrOHz7t4bTWGf?=
 =?us-ascii?Q?p6vABeQ4TdLRcp//yevtw2FPlIQRXzRRZv71VRkOvT5drxVUBPmRMSUDP9xM?=
 =?us-ascii?Q?pcTz3ScVYo+yFmRZ0UpbK7+8Y48hd+sEjcELKixgfT+NONMclRD27u3iVD+b?=
 =?us-ascii?Q?KM4n6QA+/lPRcVKp7galB7b2osOs5qbJL4V6i3h0kOPkVK4avAoz0PVpQFNe?=
 =?us-ascii?Q?Xc9tmQ7fOTlFHaJI4Htkpbf82iN5AW+yoJFEb6cQpvRCjVS3qCA8Q8zpArum?=
 =?us-ascii?Q?6hxbljgfvNpCK7faN10j9x9lXFvmP2LIebfLzsEU9gcne8Zy/DyPVKuYTN5Y?=
 =?us-ascii?Q?2M++tjJlH3kk6NQ1TyKzQynxgz6sbvT3QErMr1huKbfSLRCMSG6Zvw+p6KyM?=
 =?us-ascii?Q?c5rc0phe8sCTmr7WCj05D6g5YSr4VzYxFf8CjM4hYsSzUz3n+W/sdPJRzgfL?=
 =?us-ascii?Q?byhaUnWsKGamd8hIA5Sg7dR2XzN1PiL0JJtWssxgW56rqls3RMFqd/7vgTG7?=
 =?us-ascii?Q?500+jrC/h/PoN98Z7m8MPNVewQ0k2+LF8cmJCYz3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Fjk5fVXZiCAqMve0Dyh826DLuAUXps9z4OLJSfwACYZeDp2fBkfJU2QsNglN6l8P1T3xTSmK/XvgSK4KDoPqOkxWa2cfx4zkyJepoNAqiuPkjvEN5ivK4um9dBSKGxXZGcAw8b1C4+O2OZGe1e8C/6/7q9F0g4T5IRdkMNgVXANgpgQEOFsuiaol1f3wlzGA6Qx+qXF8gvKn/h4SHhIZqqW/adZjvB7nM2lNhAW+ki3zelFt2P2fVBJN55rCzgU5ButZcxjA85ueHGuGHErF+ncIeAIOKyf07XU75Tnq6+KFELSBCxjJ/y822XpItrgPUEWSYz/WYAKFLZcjy+NgpsDkp+7Wyn7vaU50TqmEAFAsbmsojommypJe4RBTdiWGbre9KHBOtjFOUwQAPc5LR0z+On2ZOxKwqsIfqfeDAUaOG1kZwmkYqu8l336QLO/oDpSYjkKehmWKQXpZpEkxRN+xvx5I5+Odr3waX0yghr2bf+y6twTvKN2miRFJow5biAHdEoHkDDts7ggtLYn0gq3azQBstBAQy0DjWvOfPuYYya4EIqSFIAdRh8tbSiMIugE1ozOwUtg57bQUqo/IPh60eojikIqPuJQ5N9wjDEkwNgdDGec5rMtDH62R0Jn0MDML7pV/s//1UOsMxWo+UbClOPjs0E+rWh4yIpRJdy1z9S8UWwgWlTYc0JF2LUn1I4z5acqQWTb8Mub7Pnbw2/53nVfG/eFSeGlrjckaCPJjqKZDF59JKEvRyN7tQ1HNnXxS5MGIg2OzbXtNyWApwL/mKCCM1DAp1VzJJwRv9aXOhKlKgyM2nhU+AGnFrdn0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4347.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7995a2b-1fe8-4769-9572-08dbf4bfd967
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 11:55:02.6001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MaFPlEkCw7Vpqz41xIxWxs6nY+Ol77BrOVl26jl21Y1Sa++ZWtxYKlSmnkOZus9ZVWXW1josM+dOTAzbePOxLkpR6ISurnQA0yBtrvrY9u0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_10,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040090
X-Proofpoint-ORIG-GUID: vnznqfkXPyKrUd7vhTP4mPCe7luGeHoN
X-Proofpoint-GUID: vnznqfkXPyKrUd7vhTP4mPCe7luGeHoN

Hi Ted,
Thank you for considering the patch and improving it.=20
I'll make sure that I follow the proper patch formatting for
my future patches.

Thanks,
Srivathsa Dara

-----Original Message-----
From: Theodore Ts'o <tytso@mit.edu>=20
Sent: Sunday, December 3, 2023 10:45 AM
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: adilger.kernel@dilger.ca; linux-ext4@vger.kernel.org; Rajesh Sivaramasu=
bramaniom <rajesh.sivaramasubramaniom@oracle.com>; Junxiao Bi <junxiao.bi@o=
racle.com>
Subject: [External] : Re: [RESEND PATCH] debugfs/htree.c: In do_dx_hash() r=
ead hash_seed, hash_version directly from superblock

On Thu, Aug 24, 2023 at 06:56:34AM +0000, Srivathsa Dara wrote:
> diff --git a/debugfs/htree.c b/debugfs/htree.c index=20
> 7fae7f11..2d881c74 100644
> --- a/debugfs/htree.c
> +++ b/debugfs/htree.c
> @@ -316,7 +316,12 @@ void do_dx_hash(int argc, char *argv[], int sci_idx =
EXT2FS_ATTR((unused)),
>  	int		hash_flags =3D 0;
>  	const struct ext2fs_nls_table *encoding =3D NULL;
> =20
> -	hash_seed[0] =3D hash_seed[1] =3D hash_seed[2] =3D hash_seed[3] =3D 0;
> +	hash_seed[0] =3D current_fs->super->s_hash_seed[0];
> +	hash_seed[1] =3D current_fs->super->s_hash_seed[1];
> +	hash_seed[2] =3D current_fs->super->s_hash_seed[2];
> +	hash_seed[3] =3D current_fs->super->s_hash_seed[3];
> +
> +	hash_version =3D current_fs->super->s_def_hash_version;
> =20
>  	reset_getopt();
>  	while ((c =3D getopt(argc, argv, "h:s:ce:")) !=3D EOF) {

The problem with this patch is that if a file system is not opened, then cu=
rrent_fs is NULL.  As a result:

% gdb -q debugfs
Reading symbols from debugfs...
(gdb) run
Starting program: /build/e2fsprogs/debugfs/debugfs [Thread debugging using =
libthread_db enabled] Using host libthread_db library "/lib/x86_64-linux-gn=
u/libthread_db.so.1".
debugfs 1.47.0 (5-Feb-2023)
debugfs:  dx_hash test1

Program received signal SIGSEGV, Segmentation fault.
0x000055555556f73d in do_dx_hash (argc=3D2, argv=3D0x5555555d38d0, sci_idx=
=3D1, infop=3D0x0)
    at /usr/projects/e2fsprogs/e2fsprogs/debugfs/htree.c:343
343             hash_seed[0] =3D current_fs->super->s_hash_seed[0];


To address this, I've fixed up your patch slightly.  (See below for the fix=
 up, as well as the final patch.)

Also, in the future, please make sure that the first line of the commit is =
a summary of the patch, no longer than 75 characters, and that the text is =
wrapped to no more than 75 characters.  (I personally use 72 characters, bu=
t 75 is what suggested in the Linux Kernel's submitting patches documentati=
on[1] in the "The Canonical Patch Format" section.)

[1] https://urldefense.com/v3/__https://docs.kernel.org/process/submitting-=
patches.html__;!!ACWV5N9M2RV99hQ!Pfb7MqoeE6NAhDDwRgjeGOuOZJ5NozX9970IvoER0R=
4oDpPXfKVMC3Mmq_TzfqTesrPbvRy6gI5sxFlEQo4$=20

					- Ted



