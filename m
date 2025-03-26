Return-Path: <linux-ext4+bounces-6978-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DF3A70EA2
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 02:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794F617916A
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 01:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2098136337;
	Wed, 26 Mar 2025 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h3qhPEJi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WGGujCNG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117362E403
	for <linux-ext4@vger.kernel.org>; Wed, 26 Mar 2025 01:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742953787; cv=fail; b=mwa6RvQFWCZFI7FrF+iDBSDm4UNiksQS5XmQTEPyboSfqB4Z49aFUS9GvT1THfssEL7sCUd4iMm+kU4w0gRX9xmEVKGncDt4Mcg1AhY4f38GQ8zrpa5+O8JACLekF7BSr4BAwlHvBzSp2Lu0Y0Zr5qsAIS8tjLtPLAuDT/lwRDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742953787; c=relaxed/simple;
	bh=lqspY67B9eX5kTo2BoiYBnuMkb7PgHno7lY0xl23MhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uzNrqvOUXO8pW3FkK/rKjtVMYoWHTXh3cZlmNMgxTkRRG1F9/56yCEo6IOBEFPSmgQcDXlGVlAa73YAz+/lbpujCcHa+BYxylpnr23NjCUyXmkJv2nbKDZZN9cJ7YNSrSRhGKzMrk4lRsJLrKq/kr8+x0A/4ixCoLjdkCamg+80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h3qhPEJi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WGGujCNG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PLu0US024768;
	Wed, 26 Mar 2025 01:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qaQSG2zHfCYxWDTr2QY0UjkK3o59WbiQcq+3e+Rgdi8=; b=
	h3qhPEJiWFmzoI31msm8lYsMCJdvZYInpdl0iRblV8K1LRj3oTLIw1GtFlsPxDb8
	T5nH/Nbc1MKjnIj8gPIMYtcgtnzYc+vOO3UusMOgdT72x9K+nSz4tdoq8R31sUVZ
	jOZottLYi0Az7JBdk9crd8IfoFLf0yA0AIaFSheIUA6NqzHqdXJLurekoSVH6RI0
	eMuBgekvLbs9UXR+GnPFhx1vOisQ53VOjAFNYQx87E+av/QkaRNoS6rvxj5c4NNm
	rSksglQOLn2FUoIWu06ah2ouz5lwPafa2PNume6Nz/sjQUI2pTwv6/vN109crP/D
	D5UR9ZnEAnMF8jJpk/zQEA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hncrreun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:49:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q0SUOH029886;
	Wed, 26 Mar 2025 01:49:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jjc1p9rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:49:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EylYw3o3bdvqA+9Y9jGc8OtDYnoejPIvvV2Or1dBp+gRlxvxiZvVd6W7QLKcpqlOBOl6gC7HFb1/7zwiWRuILNPCbY/1rNEOu07TwO05fpidAXntVnhqugZ8XCMyjtFjprXcZjbl2b+bxBZEATGb2JdBuepN+U+WBoY+6yxJwwn+R5a01sTaSuhrbAHAygLgPhldsJRueRAVz9POVNeulz2qjuEXZ8WlxFrGJ+QcN+AgrB9S4rSCL17pmeq/Iz+YAFqA8B2BTd5XRUFT8T/8iFngPeJ2wBc9iR6Mw+3+uae6M54/gw2vKRLWmSloJJGsdTi6v5r6nR53398ESbOPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaQSG2zHfCYxWDTr2QY0UjkK3o59WbiQcq+3e+Rgdi8=;
 b=i7V0TWW3mbTw9O733bc0JCLZVI8yLs0v8pqCg29YOL0O+WLpZDjFYaLMrJKSmQzUsf+4FigkQKpNgufDb20l72l8XlF46zS7UCi1XWpV9cs6MiCmGX3PzAqyFh6de45U5LgSK5HR73xUrBikAcSLBi5hoI1p9Utg9XW6ZyOYIoi1HgRSV/xmKk+lJRyizIU5hFhOxwCXk0t3RyM78QM909rkinXDwfLgPauCB2NwS2jVXu4jtjZMt0mMhZ8BWYVB7Ad8e0ShdLQioo1fXaiMMeq4CGTxSrn077h77Iys2y/KPoKZ+DATWLRnwvH4iyLwqKeMGg6O/ShSk7VKi4HaEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaQSG2zHfCYxWDTr2QY0UjkK3o59WbiQcq+3e+Rgdi8=;
 b=WGGujCNGdgKgW+69RTlo1C0jUP1MyYToLOlemfhPHaFDRepf6kp3VFCw7Pl2O+LseIN1RTau2YJ8K8nwh5v5KEwDSmLcOCCHVh9MLhoSGyJsu69pcaGzVewOQ/pHuueitLS/1LKQ3N3zg3ZTTFEg4EUsNvLy/pA62tuA++TIeTg=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by CH3PR10MB7744.namprd10.prod.outlook.com (2603:10b6:610:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 01:49:40 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 01:49:40 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: linux-ext4@vger.kernel.org
Cc: djwong@kernel.org
Subject: [RFC PATCH v2 3/4] ext2: remove buffer heads from quota handling
Date: Tue, 25 Mar 2025 18:49:27 -0700
Message-Id: <20250326014928.61507-4-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250326014928.61507-1-catherine.hoang@oracle.com>
References: <20250326014928.61507-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::24) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|CH3PR10MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 034e7b91-c5fb-4391-3a86-08dd6c087902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o+ffe4Q9ZyF5K4jOybm3gy7kXTk30Rc9yvrrlqaCU3dzfYYJ6IGppf5QTndC?=
 =?us-ascii?Q?VJXPG3R4sJY31SEXEjqfsJfIGXOW7q9RN8hwU7qW/cWinsq9m7jmr8nhCrNY?=
 =?us-ascii?Q?UtmpfXgzZoTWykOGPSAfWTa+EYPbp4ywGULuThHg/Wt/RCSxFAaE1kYgOPRB?=
 =?us-ascii?Q?TZArNFSy23saIiKoeIxKiV9Oa6917k8+H+bnIGpcpN8E1i3Lkj6EdVhW2ls6?=
 =?us-ascii?Q?GuzM/9LuZtw0u4KSjYPog1GG0IzBP6UO6RklbPNX9xgvoH7ihMTCGeq6bEt2?=
 =?us-ascii?Q?CAV49qC0sFN8kPzhSBeYuli1CC/3u2ngXvkF80aYTTK1oVhVsr+lJqWeV9vB?=
 =?us-ascii?Q?QHGdUQRSJj/jdK6W8X1pNuYZvOai3XCgylfzNQiwJ5JX+JPTNo0Dbb96tny/?=
 =?us-ascii?Q?hP1iiZTIKkzUKWRWcO1s1lOyWbC/9RO0bh/HREZXvncz1AoUbHB1LsKWQT+E?=
 =?us-ascii?Q?SwefVA1jALF5hElrf6B5tyJsgHCFuSjvRLpObg0ALtJU10fGH0TfwbTmfVcg?=
 =?us-ascii?Q?1FTHTLbjwrN0z7S51TEg2AbZfE5WvZF77d4uf+6v0DlaB85Jjn0TXDTjpUnR?=
 =?us-ascii?Q?MR+D23oCFP1qjZBXBxuq5H89vDa7MtjfYJiRhBtLL+8oJwo/RRCkeGgvEW+T?=
 =?us-ascii?Q?GHujdtgxVIpDKZvHZxrsYeQB7iga1xaHCnxItPAn7OlrE9uzzp5vvD7McA4s?=
 =?us-ascii?Q?ZK+me/+/mfxsD+GaZ2ShlkdU9dmgThXGb5JM0hRlQoPLiDIyg+ccft2/Xcxj?=
 =?us-ascii?Q?GhNuPblMTm2N+MF0PagfHHVd49YxTe7PZ2IowDb/dL0cxQXKefFEtk4g4Ik3?=
 =?us-ascii?Q?DiRInfhVBZFG9XraOqkRXXKHYtgIbSSJzmkJ5bpVY4KjN+DntR8qEZyWTDOB?=
 =?us-ascii?Q?XoIY9gslokoqqSQcKKJk5PSm309tBi8UwavboUTuiiJBakLKQqoEy4E43eb+?=
 =?us-ascii?Q?sIGY5IuiT9Gy9YIrOzuzTsr4KlQWDvrVEF4y+OYMm8WpOi9JKyiWfjHL1y3o?=
 =?us-ascii?Q?+e/NDtFMwXVGHnBiVsEBfwaWg/ouzYX9UBaawQpz1g2xFRCg9v4hFOeGo4WY?=
 =?us-ascii?Q?HzPJSfUBnjgpvKvf5uWb7dQbt8R8ZZOx0N/YkZGJW0pEaK05F0eRC0Iys5XV?=
 =?us-ascii?Q?Q2RX7ksVfydq35vH0kjzsz5q5j24d4bNSNUNXf2tYpzzcib4OPU8wiA3yYon?=
 =?us-ascii?Q?Xyj3PFfW5iE0J5b8YNtMJfazZ0TmDstD8WHYY5XSRI+DkBr2hVyL8q7WhmPt?=
 =?us-ascii?Q?ND7xMSph3hy0vaXlRGnvxzIlB8Pxfk8Ocet164t9NCAG32bJAxHhr2qm15tk?=
 =?us-ascii?Q?JlF6dlGp+QtT2RXUcGW5sTlKAG645wsXYwYTaTUovmOy6PNnO3gzQ6boHg34?=
 =?us-ascii?Q?6xG6aeFxNg6k2vKnPsXIVBTxzWOB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?om87ntexLi/rMYuUk23+mQP/NXAXNtPwqp0jrVgpPC2aTASIJQzB5nzTsBWM?=
 =?us-ascii?Q?lav16dLiPTW0mgvMXkRilw1NCqKk2b0a90z/1eJNdSb/vb1WpPafDG5r2Ray?=
 =?us-ascii?Q?7p7SO2L//n325oiHi5WSCR1UICCAccKDfFxMfJj42vNnPPgtpQz8xFtbhV0S?=
 =?us-ascii?Q?3f6OXQ7+XCsOO0PM8ijtp4JE9yuxSfTEEHsIAGM6cykL2IWTF/cNGwMMUsNI?=
 =?us-ascii?Q?aLBfmkZgR2aOO1Oroq+BewyzYrO5hYQeIB2a0Xruq2AG8euG+t7fm5bOkG8x?=
 =?us-ascii?Q?UOOH/ciO7eeoJ1IX1jcM2xqdAI2PImWts984pabyxE8XZPv7E3jyffQf/izp?=
 =?us-ascii?Q?V6lXZwGtyI/bxhOU6L79/IOBaqaX5RAf04iEeHHwPsnZ4Eud8AsB3nE1yaD7?=
 =?us-ascii?Q?vlWoy2z2yC+nQU2+O13m7WFFbMThz+gD40ng6Bow/bSzlgKYH7TUlaNSkURF?=
 =?us-ascii?Q?y0FsZgoYm/cSEY0+C9tuNACEz5PsKgIQfxYo8oesBg9/9oSSOOzlY0VdwvcV?=
 =?us-ascii?Q?rBavUh3avoRZs1t6y3HKKgtV0nMxMFTN+pn6p0NbvR1Z3fdR5yC/TdbJwim4?=
 =?us-ascii?Q?CudQquzuzmoTOO75XmovXorpSTdmtlrYQlU1zwvP14Uwei87y5LOsxtltL3d?=
 =?us-ascii?Q?tQYkXRY0xMxFFrBJm1dSUGrXEjDR81x+RsWp5eqV6S/bCsU8/2E3HZajLf7p?=
 =?us-ascii?Q?5r+de9Lg8M9yFeGtEoGoRHXnYIk9zziDMx5/sM/dQMC2+88AsnSeGnccIsKF?=
 =?us-ascii?Q?Soh2NFyCYYnq+jHRU8gTJLDWyvLRvYbEBvVEDwKQuF6F4NBK6q/mQOis+0cT?=
 =?us-ascii?Q?KZA5yZT3R95ZzqW9n7PucaH+t4u/IMhUMBY2voPjsqwjotituCcO9KkNcmxM?=
 =?us-ascii?Q?j99e0IHc5O8f8OXq0mI7nFXIEilc/ab8M3RfKmDZVTgjxhH2sKuGMshmMfln?=
 =?us-ascii?Q?qwcfOZUcNglgQIVtAf9FeKCdnOXtt4l0vsZTmoag2N8v9QZ4je/C0Pcy56eR?=
 =?us-ascii?Q?kNRyKphNR/3jDnCSI+FHOS9KaJSc6rfA53y7IEXSupNcAQZO2maIAmmVpdUe?=
 =?us-ascii?Q?2271Z8HKBCeaIAwrHNO3K2JEj59zAwCJlnMfuVJxCUo0GYZLHn0vJ4IRV8za?=
 =?us-ascii?Q?Ai3e716XUxPLF9p97ynTh7iF6U5oKROKURJ70LJ3LD0QQbxHnnRO1I7UKtrK?=
 =?us-ascii?Q?Nb4gGti8jLg95qWfxGcbJfU0VN58D8lxnPdC/uFv/T6bcCkzDyJwffwDoRm+?=
 =?us-ascii?Q?aoL0zUGo/J6AfFGrAfBohKCDI4O1kBqYSTxBI/h2rXayLwyNAn1a3A6kNdyt?=
 =?us-ascii?Q?KNwOInq/0lvY/XMea10MMMFPFaNkxsUY2KalVdld/MtDdWJLSvxpp97m8PLU?=
 =?us-ascii?Q?ZmqvcsX7uDGvXG+PI+gc1hQI+NHH/lUu+awzuf552f2krTdyYCG8cfRSrKpI?=
 =?us-ascii?Q?rCoP/ZYy3u4XC+JT/vL1mHgbMNiKO1Y1MNjRgf24FHRRqAB2yXch5g1JcGp4?=
 =?us-ascii?Q?BNw5U1jwD92I6QjydkNsDesHKvhRE4V/464sV1LvGPHrosjzBd/pPBU2SKg/?=
 =?us-ascii?Q?Gv+KRbeTFCCAbZl+NkJX3sb+9HYLcaDLWDPMRk/izKyFfx+Sct/8Zujf9Jy6?=
 =?us-ascii?Q?EqABpr2eu1UqHMv8oNiyiLS7cMPZdUUZ1NqM5z5QECOisV8mxLDMnKqYtmJl?=
 =?us-ascii?Q?Eewb4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RW8FcwTarNbLxbu/iSi5WP749BWQ5/FmkvfOmFR/fE/afJwubDuyCb2DzqdTV8yaBmE5mXfBhFOCboyFTh6wsrvz1Frnceo/n8Q3wFepdBcnRHDx2boMZypZ8vDpD2PeuTbMDINZts0bGbaRDdwQ4hFpE7BWnL1VdGOIBW4iS0LR5kHehDdWBMbrW31Tuk30vI8NZBRQqPMEqV3N3XPJAecC2htXUJNkO1IZTuz1L3ddj+OWHyvghSXvigSW5JJimhLVAnBIZmbLOcnkeSJ1ficYzL8llUaM0wR4XneCVNYdQx9rEws4WbJEx7Tpi837BKUVuEy392uK+EWOIuWA/iCeI/FRqxBXi9z4U+6k3bc/lXYsH3FfFFfdUzQ2c2R7swO/01NRiXvGyvGdLk3ng1N+wSnmK0J6CUATF4Nz+GIcGuOgBToxWbReLfbarroGapD07OPve4iM9HffXmqkMguvVKusequ1jb7xl4NsHMozaBtu39QWzDfGj4HIMlr5bh4bRaJrgmXWPxxyKE6EG74LC263Xpb2wMS+KO2DV8mrgEgVsIYe14U5iG7LDCqNhyo4/BraWzW3EVwQle0xbI7s98lIwAR31SDGwtAP4zs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034e7b91-c5fb-4391-3a86-08dd6c087902
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 01:49:40.5798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2suCdSgLfGus/S+i0uuUKxJz7SUxZTABr/O/4MWvI4TSukObdmT8MIeHLjrU0rIXgl5mBRnqFSG0rPrdE+Sf5W4B/11KOryRnP59HZbPf7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260009
X-Proofpoint-GUID: jHpNq9Z9OErCtNsp37UaorwL9hW5KiqZ
X-Proofpoint-ORIG-GUID: jHpNq9Z9OErCtNsp37UaorwL9hW5KiqZ

Currently, we read and write to quotafiles by storing blocks of data
in buffer_heads. Replace these buffer heads with the new ext2_buffer
and update the buffer functions accordingly.

Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
---
 fs/ext2/super.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 4323448bf64b..be6fff36bf23 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1506,7 +1506,7 @@ static ssize_t ext2_quota_read(struct super_block *sb, int type, char *data,
 	int tocopy;
 	size_t toread;
 	struct buffer_head tmp_bh;
-	struct buffer_head *bh;
+	struct ext2_buffer *buf;
 	loff_t i_size = i_size_read(inode);
 
 	if (off > i_size)
@@ -1525,11 +1525,11 @@ static ssize_t ext2_quota_read(struct super_block *sb, int type, char *data,
 		if (!buffer_mapped(&tmp_bh))	/* A hole? */
 			memset(data, 0, tocopy);
 		else {
-			bh = sb_bread(sb, tmp_bh.b_blocknr);
-			if (!bh)
-				return -EIO;
-			memcpy(data, bh->b_data+offset, tocopy);
-			brelse(bh);
+			buf = ext2_read_buffer(sb, tmp_bh.b_blocknr);
+			if (IS_ERR(buf))
+				return PTR_ERR(buf);
+			memcpy(data, buf->b_data+offset, tocopy);
+			ext2_put_buffer(sb, buf);
 		}
 		offset = 0;
 		toread -= tocopy;
@@ -1550,7 +1550,7 @@ static ssize_t ext2_quota_write(struct super_block *sb, int type,
 	int tocopy;
 	size_t towrite = len;
 	struct buffer_head tmp_bh;
-	struct buffer_head *bh;
+	struct ext2_buffer *buf;
 
 	while (towrite > 0) {
 		tocopy = min_t(size_t, sb->s_blocksize - offset, towrite);
@@ -1561,20 +1561,18 @@ static ssize_t ext2_quota_write(struct super_block *sb, int type,
 		if (err < 0)
 			goto out;
 		if (offset || tocopy != EXT2_BLOCK_SIZE(sb))
-			bh = sb_bread(sb, tmp_bh.b_blocknr);
+			buf = ext2_read_buffer(sb, tmp_bh.b_blocknr);
 		else
-			bh = sb_getblk(sb, tmp_bh.b_blocknr);
-		if (unlikely(!bh)) {
-			err = -EIO;
+			buf = ext2_get_buffer(sb, tmp_bh.b_blocknr);
+		if (unlikely(IS_ERR(buf))) {
+			err = PTR_ERR(buf);
 			goto out;
 		}
-		lock_buffer(bh);
-		memcpy(bh->b_data+offset, data, tocopy);
-		flush_dcache_page(bh->b_page);
-		set_buffer_uptodate(bh);
-		mark_buffer_dirty(bh);
-		unlock_buffer(bh);
-		brelse(bh);
+		ext2_buffer_lock(buf);
+		memcpy(buf->b_data+offset, data, tocopy);
+		ext2_buffer_set_dirty(buf);
+		ext2_buffer_unlock(buf);
+		ext2_put_buffer(sb, buf);
 		offset = 0;
 		towrite -= tocopy;
 		data += tocopy;
-- 
2.43.0


