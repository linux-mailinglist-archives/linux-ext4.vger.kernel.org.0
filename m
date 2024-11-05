Return-Path: <linux-ext4+bounces-4955-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A449BC446
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 05:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E5C1C2139A
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 04:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF84C1ADFE4;
	Tue,  5 Nov 2024 04:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="DhyFJ4wB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A13919259E
	for <linux-ext4@vger.kernel.org>; Tue,  5 Nov 2024 04:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780295; cv=fail; b=rp3un9SalIc4LsP987BzxEVFvqULlclyHANINrn/F/jBXZzQILv6/L8XUK9EkwQfgQnpWDE52AUTZC9zF9ADUNMvxjIWyAaXunmqK04uT3yRZzMuiZ18vpbeQtbE0vChm6axwpPUDGs0xcfmHB8gHd8cd7xJFveHL33AdT3FAqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780295; c=relaxed/simple;
	bh=cWohdfVR+HGoX1Xgcu1OgL7megcUbYXGDo+JDVfiLwU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R+/M4g105msAAVF5N8jC7gKUzDGAyU0KlqpmHiLBs7Xf2dI1B30XC+0D1H5hxVhr4RG3E3T49Z2TJ/aRQloZ2N5DwZRPKSvgK+58zJmcGQE4DWdsMF8TSKmC73rtb74Z4OOpVFEi9NNDqKtApxuEDY+1NlaxntqCOf1FdhS1wII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=DhyFJ4wB; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43]) by mx-outbound13-162.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 05 Nov 2024 04:18:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpQ1bP7FQXctHjLmdzHwyQCa6rK20UBDN7nhbZT9nXCAifp4ETpaRIEbL9CNIUb12E73itOOLosZwrzeNC1HPZyt8IjvcMaWb5ECjveTdxQy/72FCl2gsT+ViXwg9by3U1PC421c/ZI9IKdb+HKbdZ46xx7AJO9mnACo8keFg1fdt/Ovu2u8NOo7O+LlHoUphySEunMjprWiYImivelZXbF5ZjFcWp1k3kXXhjuZ26xbHZ2ZHhrVDR6+3bnmWZP68x+UPdXekVrZYhcDyybNDkmx3hQZzS6GG3m4IBeB1DDgL/UN0gU3z6s+GB2P0DeJuyUzH2CvM5oMhC8G8WIv0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8RK3ap2Si9fWnzvzaRpeN8zIN9NTCQDWAkDct+26TY=;
 b=rLaawulOkwj7z4nQO+X5gtngOBCQHoTK9uOo4/PiysSzrR6jgVedcVUI4/G4SkCwnIQoUhxNspnM3lVllQ2NUI0L7VRCtaJiO5+XlwXS0PVVCqRaBh68ME+u34W5ZNLxbQHiUkoXVkt2lSeYeYcq18jo3ubzhKKr0lBSL57+zw1HHKhIoGPTwy0gXm6plS/dX3G7Pa97fM45CY2Pg/Va5ThCzU7n2z4Mtw1Om9UjK86+JxqLbaOaP98AQ2B4HNDJTxrGyDTuYOLMbDCxJN3NLYmziauSrcRpJpliSH3sAGLJlLpBtDDpnWx1zzkjUpWrkhWJjZ2g3oJAq/2t7SF9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8RK3ap2Si9fWnzvzaRpeN8zIN9NTCQDWAkDct+26TY=;
 b=DhyFJ4wBdtxI9Mh5/JGCig4ORHmvC1qvpoLu4Ug+ssayJmDCyID5EAf5dzWDrqUGjQ0ucGRf3yjZrFuTRQSzko+df8mkzeNwT/zteC6oxYI4UmNDmB2P97IYTSYnZnK8K717fTQ0GF7jRCwu78f09tpnhLiCnUYCkfoqEGAE4Ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 SA3PR19MB7746.namprd19.prod.outlook.com (2603:10b6:806:2fa::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Tue, 5 Nov 2024 03:44:33 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::5e92:ca89:62d3:f4ef]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::5e92:ca89:62d3:f4ef%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 03:44:33 +0000
From: Li Dongyang <dongyangli@ddn.com>
To: linux-ext4@vger.kernel.org
Cc: Andreas Dilger <adilger@dilger.ca>,
	Alex Zhuravlev <bzzz@whamcloud.com>
Subject: [PATCH V2] jbd2: use rhashtable for revoke records during replay
Date: Tue,  5 Nov 2024 14:44:28 +1100
Message-ID: <20241105034428.578701-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:10:31::28) To DS7PR19MB5711.namprd19.prod.outlook.com
 (2603:10b6:8:72::19)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|SA3PR19MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 08037c8d-7bc9-4b78-9e7e-08dcfd4c2902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pazjsMfzZqZ+uRLb1vELcgAjmMKGxWS/aJL0YGe+y66Skl/HRvY8pTQLoxOG?=
 =?us-ascii?Q?1X7Wv6RYNqPDVkoGDKx9kvmw5vyO1z3MX0kuO92yrmgbRKptDBZ+dqa5iYJO?=
 =?us-ascii?Q?dkzxnBd7Q7/sKN8TdRrTc9Yhkyc7KT6/KZ4ld8ik0STmr5GSKeCL4nvPZsyt?=
 =?us-ascii?Q?7+GB0lwKUqnu0ZqvZqC0Gnz5g5kqKANH88yrS+4258R8SUO03NXpfrIXjlWz?=
 =?us-ascii?Q?JT8UkKBJyTDJAEY7IHEoZCKb/txW7+f2qcyf/4vcfJIcbfQa/oJMFEUtn7Mf?=
 =?us-ascii?Q?9zp6UO5TExpisoaZz0Y7hsOU8uQXueEvTLrAgoH+3hHKhFTWTbMrKmkdTQvW?=
 =?us-ascii?Q?nbQWL+EWmTvUS2kKroF3m3ebU3YdkTZ6ifvVTKcau145meOQlANVNE7UudSv?=
 =?us-ascii?Q?U4VAXWVUApnskW5y10UyE07oxSqzDXaolhftnoqnu+WEl9m2ZIQjlPu3vsxn?=
 =?us-ascii?Q?KmbES45088D8Z76fdomEK2BbzgKb+qrjEqbbArwzmXoU/fNiVIVmZ43qGY9d?=
 =?us-ascii?Q?9RRRGZcG29vNDxrd1IIpldYbmmaIXOGmglfXAQ+U6UZjDSqIU4lLFrXvVpN6?=
 =?us-ascii?Q?zoYd1lBetxWHnHhLUFUVRpAtc6hXcFun3Pn6sIhuEqgaqJHrRZcryF3UOvHN?=
 =?us-ascii?Q?RGIKH9HU8DWVRCe1t6tRmX/tBqcKjYECMQiE6f47tDjBrwILNRY9vXQj/UDX?=
 =?us-ascii?Q?1gmLi//A1nY2GLIGnR2GfGpeNgHe7MICXVx570uBatmTz1fXqAQBYuBOZJ/7?=
 =?us-ascii?Q?93NV2/oG8zSHK8fPmfRknLrhGQgEMP/dFh2w+7bKSW4eGthD/u/AmCATUamx?=
 =?us-ascii?Q?aHNLKR4eJ+flpiuJYZtHBsCgmJTquR16wkxNtpZoXqWxYbAb9v/5ruoiw8g5?=
 =?us-ascii?Q?G5Yzv5OS0SI9TvcKBCFZO87R4pB8fbDpiGEzW4uEJoDXP48WCCYPOoqT33xL?=
 =?us-ascii?Q?A+4YaXnq99F80HHFhDLbrLH1W0Q8PsakGRaBPJutvOGSj6AgNJDkV+qxeHPj?=
 =?us-ascii?Q?eCe30fitdnsuRBayOkay7ot9OeftnBZqj1PUjd4aBQqr+vkOW9nJFkjK8RpJ?=
 =?us-ascii?Q?GrAbHLKobx3TPS2r7mfetJHSMeRyFe3OavQryL36M80i1I7b/eBlB38dxXha?=
 =?us-ascii?Q?507gOKiS+/ujk91kmUQeXKt67/ktycneRGtnlLwlLEtkXtVCMXA9oQFRWbKG?=
 =?us-ascii?Q?tW8ZzvALG4zpnL9VvLuk11ndEee2zvu81WWeSMX0+5u5ATVLQOmY1FIgyEEN?=
 =?us-ascii?Q?eNNmWKgxrYAdVcqTmt0JMD66Je6NoAZtB0mAyHaKF61H80tOs4T6+oLT2h18?=
 =?us-ascii?Q?Tqw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aIDQoLJ/M0DHxF3fJoADCKLEM+kjoa6xjCbQPPm7MyQ4MWfmkx38aXWPpc6x?=
 =?us-ascii?Q?K+vRWyOBA9D/BY42t3U72o2voqJHdbN0VJ1ccwBpiHBuX0u4lklFe/3M5XXA?=
 =?us-ascii?Q?S+lgVsrwat7PgNqEBrNxVW+BZ4byiweUwz6mRUwOQSKi/ZitqJ1MDg7ceNv/?=
 =?us-ascii?Q?j6urxn0nEXMKkc3oztds1S9s2meOCrJB6pBYvutpiSCEqTpuyPEh4e+Ijt6x?=
 =?us-ascii?Q?oLhcUcB9FFqR2fNGGXxzlDWrXLYBkeIxzqE1XuHVMAZ6xMsRS6fcIIzeX7eM?=
 =?us-ascii?Q?jGUUhXh7I2ykauM4Ucuqod3JeE/TeYOeS2Jh8kKcEmNa6xXpW3ZDQ8p7aIwn?=
 =?us-ascii?Q?m1fJeVjhG4PZbd3s6Max3m8LMk6572QAgZM3uMLIADbhIde6D2h0JjiogMAS?=
 =?us-ascii?Q?tsinkxSMdaVhTS86j8XBAXuHbB3jlCf3SybAH1C4j3iOsJXEdi91GBM3rRAF?=
 =?us-ascii?Q?8zDcapmWcYHQQGntBzgjTE23FPAMby2qoSrN3WjSlqQ3VKPKRExgnGVjE8bT?=
 =?us-ascii?Q?JjLjC/shpb8HnBl65e1tjrbCj6rqES8R9T7XMCiJ3A/IcyUx15DIRXGpVU2X?=
 =?us-ascii?Q?6KaXv+FTBEAPu1AnFlBmC9aX0N2NZLcHnB7FjdydZu3W51o4g+MLhoLGwX5d?=
 =?us-ascii?Q?79/kAUCCN2+3fYPgNqGK1LHtT0fnN54gg1cePspImWY9eTHBGCU5/VUWfyPy?=
 =?us-ascii?Q?sPcAoCNWaRIat8eJnPN3ZJAUpDvYXO3VdVnkLLWmrPYN+MxCNkm6rANkjiw4?=
 =?us-ascii?Q?+LLX7O/4qCC3xcHFn5choPFqCZeKbAJFguhOwJkkrcLkTO6D854/OlDhXyUm?=
 =?us-ascii?Q?1J9X2hBAFYHAY1SsfBRE4esGGGOltSzsvYfYJBHOL7AUL4uS2H8raR+ysEi8?=
 =?us-ascii?Q?+7ZumbaIzNH4mjnIT9FUiS6oiMJUGrTs7v+cXozKPeq+fq5nlhVtrzuQrDDg?=
 =?us-ascii?Q?DowIpytg+bgAsv0uij6HAVKNv9yXonQTriQvhY6Ny6EPBEaOs1F8yu+cZLbG?=
 =?us-ascii?Q?9Ktfilt555n98+zxXhz5wEMCx9IbBHpIcyTvhDadWzmgwV81YLKcATmUIwal?=
 =?us-ascii?Q?AnhEJA0g0EVW9IY5kv83Pg13JEBVh4Cy0mD2gRpbn0WOcZeza/k+BchKCR6F?=
 =?us-ascii?Q?/Mdvsz7JsqgCuaxHKtmvrGhO9Ph/kX2rSVIaNyEgQ3J6f72CZ0Lx3TeQaygr?=
 =?us-ascii?Q?fmGynmKHA+c+4oSNeHGHwwo9a+MvOZE3+5kc3SVGlxqCcQDLSnxxX/rWvTFI?=
 =?us-ascii?Q?3u6rkNo00pm9AElhI+wsbNErQQcnlBRMA8cAOVrMnk6qQvy1RrZs+oGZNRxQ?=
 =?us-ascii?Q?nppFhdnVsWPzhTwOqE7/11S6DZX4OBm4nIWukWQZNL4L4guHtTpW/7SAFsXs?=
 =?us-ascii?Q?deehZqVJVdlEPrZwa0ljaFgbTYGb8WEybyQGc/gED1NzRp6BAkYdE0xQNuaV?=
 =?us-ascii?Q?pgh6Ut+g6GLKy31/ulvB7cQcScHSjWgNmvG3H0lFRn51jKiHygGwXWmxjE9M?=
 =?us-ascii?Q?UFOO82aqAcw5VpP1aOmb3dlIDkgtvUTw1QQOlW7VNEodriiUpaWMeiazA4Dz?=
 =?us-ascii?Q?fDV1N1Kavj+PINENVzU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/xsG4FpV4WVtu0xsCDJtDL9q/jV0mWfd2cCzG4+OSrkFcx78f4Fx2OaUui3lLUehAQq85EO4Czt2DoJPz/Ug3skUL/J5LdAmZTSRpKkyK2SgPWWz4FZVhNcnjB+caRBaAgXXpO61rROLr6pUohEsL9BLtSRdAiAZlJ/RIfZHKtyan0Oq0bg6F4PDeTuctRQ2k+BwMartfgUUm6b9YoghhhDbvRncbhE90etJrLVnOf75xTXzvo2U/dOwm/H2+i+esBMVHqB6ujHH9WetBbpoykixQW2x3sNafvvX0fXJ1eN7tI5DlbMCypvOn/iozxUNtvMGKrL8W/znACRNkNISrVDW4BC2qj1qA2C/U8b3V3KYzlXZbvf2ufMPlmYddskdIEwMjYqdtzpD8qrHkhZb2sjWS74dRnCXWZCq5IC61YeZPmngtIT6slTxY2s5CfU0XzZ2IoYVrBGzCe1zc3n7NpeaGboS9KNlBj21g9OUWBRmEM0AM+M8cBCYNBiEM0B0gxTIjMEpC8lMV5/8eLa4LNELP+SgPH7Jr1SdAAgZCosgHUggF/8nhqWvAAxzwoSquYpoW/PW+yfRTCBUzC7rAoW8DnO5bK1IUPDRZVQC6rF0BYxX1dVv/KEE1HlCgdI2tgFRRIg2HP5w6F+4H7Jbcg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 08037c8d-7bc9-4b78-9e7e-08dcfd4c2902
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:44:32.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsYS92Zl49MkhB9vgC2Qb8vj25ze0C9YFqZhvo0zEcqQGRXmIxryNygITWXqNABr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7746
X-OriginatorOrg: ddn.com
X-BESS-ID: 1730780291-103490-12633-15014-1
X-BESS-VER: 2019.1_20241018.1852
X-BESS-Apparent-Source-IP: 104.47.66.43
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqaWhiZAVgZQ0CjR2CLVJC3N2M
	Qw1cTMxCDZyMzQ3DglNc0oKdHUxMJEqTYWAAIclIRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.260211 [from 
	cloudscan23-124.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Resizable hashtable should improve journal replay time when
we have million of revoke records.
Notice that rhashtable is used during replay only,
as removal with list_del() is less expensive and it's still used
during regular processing.

before:
1048576 records - 95 seconds
2097152 records - 580 seconds

after:
1048576 records - 2 seconds
2097152 records - 3 seconds
4194304 records - 7 seconds

Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
v1->v2:
include rhashtable header in jbd2.h
---
 fs/jbd2/recovery.c   |  4 +++
 fs/jbd2/revoke.c     | 65 +++++++++++++++++++++++++++++++-------------
 include/linux/jbd2.h |  7 +++++
 3 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 667f67342c52..d9287439171c 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -294,6 +294,10 @@ int jbd2_journal_recover(journal_t *journal)
 	memset(&info, 0, sizeof(info));
 	sb = journal->j_superblock;
 
+	err = jbd2_journal_init_recovery_revoke(journal);
+	if (err)
+		return err;
+
 	/*
 	 * The journal superblock's s_start field (the current log head)
 	 * is always zero if, and only if, the journal was cleanly
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 4556e4689024..d6e96099e9c9 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -90,6 +90,7 @@
 #include <linux/bio.h>
 #include <linux/log2.h>
 #include <linux/hash.h>
+#include <linux/rhashtable.h>
 #endif
 
 static struct kmem_cache *jbd2_revoke_record_cache;
@@ -101,7 +102,10 @@ static struct kmem_cache *jbd2_revoke_table_cache;
 
 struct jbd2_revoke_record_s
 {
-	struct list_head  hash;
+	union {
+		struct list_head  hash;
+		struct rhash_head linkage;
+	};
 	tid_t		  sequence;	/* Used for recovery only */
 	unsigned long long	  blocknr;
 };
@@ -680,13 +684,22 @@ static void flush_descriptor(journal_t *journal,
  * single block.
  */
 
+static const struct rhashtable_params revoke_rhashtable_params = {
+	.key_len     = sizeof(unsigned long long),
+	.key_offset  = offsetof(struct jbd2_revoke_record_s, blocknr),
+	.head_offset = offsetof(struct jbd2_revoke_record_s, linkage),
+};
+
 int jbd2_journal_set_revoke(journal_t *journal,
 		       unsigned long long blocknr,
 		       tid_t sequence)
 {
 	struct jbd2_revoke_record_s *record;
+	gfp_t gfp_mask = GFP_NOFS;
+	int err;
 
-	record = find_revoke_record(journal, blocknr);
+	record = rhashtable_lookup(&journal->j_revoke_rhtable, &blocknr,
+				   revoke_rhashtable_params);
 	if (record) {
 		/* If we have multiple occurrences, only record the
 		 * latest sequence number in the hashed record */
@@ -694,7 +707,22 @@ int jbd2_journal_set_revoke(journal_t *journal,
 			record->sequence = sequence;
 		return 0;
 	}
-	return insert_revoke_hash(journal, blocknr, sequence);
+
+	if (journal_oom_retry)
+		gfp_mask |= __GFP_NOFAIL;
+	record = kmem_cache_alloc(jbd2_revoke_record_cache, gfp_mask);
+	if (!record)
+		return -ENOMEM;
+
+	record->sequence = sequence;
+	record->blocknr = blocknr;
+	err = rhashtable_lookup_insert_fast(&journal->j_revoke_rhtable,
+					    &record->linkage,
+					    revoke_rhashtable_params);
+	if (err)
+		kmem_cache_free(jbd2_revoke_record_cache, record);
+
+	return err;
 }
 
 /*
@@ -710,7 +738,8 @@ int jbd2_journal_test_revoke(journal_t *journal,
 {
 	struct jbd2_revoke_record_s *record;
 
-	record = find_revoke_record(journal, blocknr);
+	record = rhashtable_lookup(&journal->j_revoke_rhtable, &blocknr,
+				   revoke_rhashtable_params);
 	if (!record)
 		return 0;
 	if (tid_gt(sequence, record->sequence))
@@ -718,6 +747,17 @@ int jbd2_journal_test_revoke(journal_t *journal,
 	return 1;
 }
 
+int jbd2_journal_init_recovery_revoke(journal_t *journal)
+{
+	return rhashtable_init(&journal->j_revoke_rhtable,
+			       &revoke_rhashtable_params);
+}
+
+static void jbd2_revoke_record_free(void *ptr, void *arg)
+{
+	kmem_cache_free(jbd2_revoke_record_cache, ptr);
+}
+
 /*
  * Finally, once recovery is over, we need to clear the revoke table so
  * that it can be reused by the running filesystem.
@@ -725,19 +765,6 @@ int jbd2_journal_test_revoke(journal_t *journal,
 
 void jbd2_journal_clear_revoke(journal_t *journal)
 {
-	int i;
-	struct list_head *hash_list;
-	struct jbd2_revoke_record_s *record;
-	struct jbd2_revoke_table_s *revoke;
-
-	revoke = journal->j_revoke;
-
-	for (i = 0; i < revoke->hash_size; i++) {
-		hash_list = &revoke->hash_table[i];
-		while (!list_empty(hash_list)) {
-			record = (struct jbd2_revoke_record_s*) hash_list->next;
-			list_del(&record->hash);
-			kmem_cache_free(jbd2_revoke_record_cache, record);
-		}
-	}
+	rhashtable_free_and_destroy(&journal->j_revoke_rhtable,
+				    jbd2_revoke_record_free, NULL);
 }
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 8aef9bb6ad57..2b0aa1e159b8 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/bit_spinlock.h>
 #include <linux/blkdev.h>
+#include <linux/rhashtable-types.h>
 #include <crypto/hash.h>
 #endif
 
@@ -1122,6 +1123,11 @@ struct journal_s
 	 */
 	struct jbd2_revoke_table_s *j_revoke_table[2];
 
+	/**
+	 * @j_revoke_rhtable:	rhashtable for revoke records during recovery
+	 */
+	struct rhashtable	j_revoke_rhtable;
+
 	/**
 	 * @j_wbuf: Array of bhs for jbd2_journal_commit_transaction.
 	 */
@@ -1644,6 +1650,7 @@ extern void	   jbd2_journal_write_revoke_records(transaction_t *transaction,
 /* Recovery revoke support */
 extern int	jbd2_journal_set_revoke(journal_t *, unsigned long long, tid_t);
 extern int	jbd2_journal_test_revoke(journal_t *, unsigned long long, tid_t);
+extern int	jbd2_journal_init_recovery_revoke(journal_t *);
 extern void	jbd2_journal_clear_revoke(journal_t *);
 extern void	jbd2_journal_switch_revoke_table(journal_t *journal);
 extern void	jbd2_clear_buffer_revoked_flags(journal_t *journal);
-- 
2.47.0


