Return-Path: <linux-ext4+bounces-6979-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA16A70EA3
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 02:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C49179B50
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 01:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCB2433CB;
	Wed, 26 Mar 2025 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m9mbTO4X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m2J6wn0c"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBB82E403
	for <linux-ext4@vger.kernel.org>; Wed, 26 Mar 2025 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742953791; cv=fail; b=o54boDlUDeh3IeUGP4hpa3UzAYcxyVwxz/SYwTndvRWgjCvKduWhJT/bXvrDy5BJZwXZByAlpiDIvSb8yu8/Okz0CmRdZFOqygOd/o1F0uZ6JooIrISuN+GAmoRq8kwlu6lv7XTFMqDx/0kNwMbdTrT+9m7DxkTMM7yQv/8JDHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742953791; c=relaxed/simple;
	bh=SxNoYKPC7D+J/+kJ+hw+JRAPwCMWfUpCWo5FYG0OLCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H2v11ycJC616b8hu10mSPEsqPubdy9dblRPof+IQCMEh9uFdtL5Os8ZZb69XsaJOzXzNQYrev5SLqVZ3Hruu2a+yLrXGYjaxf+tg+PCIeCZ9IwCRpJb6T/RplqwU1tn+MzzD9yhuN6+IqsybNc2RYNHsx+rRtJZuop73z7doRoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m9mbTO4X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m2J6wn0c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PLu0dP024795;
	Wed, 26 Mar 2025 01:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fYzWh4d+H4Biuwxot5oy/BkwX5khpXx76i4370C6Mvg=; b=
	m9mbTO4XPjJil6/dHYyCsHiXf48bEvYM9rk+8+Ny9nziAO7dzxTkB7eK/h5GKpzE
	Xk7gVyCYp2pkS7B6lRhFYsbKKqoVeEHvKg23fs7UUKiQFmkB7ZGaOWOnY2bQOdSk
	okqPYpIf2Hu4aGtZ3LWKg3N4pdbiwqkxqfwFCbgNhvoieJgZCZ/FGzJeA3x0p6+k
	a0aAK2CCftw096DKrhrTNYewmvw4mva1oUFrHsGgdbRWFbOYu4h9Y5HN72dkSRQg
	WnqYAb5sXt3MPnK7VZuowBFm28Q4LtcdjE22HHg18PuNGBA25trk8piIG1frOH3q
	+qAef9vxx9q3FvaOP6WiWQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hncrreup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:49:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q10nYM023264;
	Wed, 26 Mar 2025 01:49:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jjcegf0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSvAIxbSLbjT123nOjgGscPs8CgO9DGXlLILUHuLngeQORPSifWpaF8HYXyvwJj+FYgf8uiTi2OGdqGKgaMCO0/RH5QNRb3Ku2/KgZDYRHfSAisaFe32quec58YF/b36Ozs6wh5UGd3NTX6WwtPuRFd02umSnrT3SfGNGhLGNImo1yPYyR5v0YeDxs2ZBmVIGp7Q/vecsA+qig8ZCwexP4J1V2ERvOu4MCEifIzzsd1lSIHRwf+DuJkUPT3ZaTwAFkugvFbe3LLVjlm0P6NxwA4QwBUg4xrsOEFAhR2zoTxzKYKUZeEsnuAV9PyVlUFFZfCud9UpuipCHb08dv5HPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYzWh4d+H4Biuwxot5oy/BkwX5khpXx76i4370C6Mvg=;
 b=KxnmrfoQb1k0gQ6/3sC/u4nNEAk24pVRwv3aRt92O+F0CA6HFlZK4xuDokCfQwMdT+vEfOq+pZ9ykWFz/7zmBVhtGKafkNXBiWn12ZtdkSC2FWbkqHCBFtwMHfcVnjXYxkaqkSNUmg6w/29J8r7FbXUGEjpVV6+w4qvyfdMjSH438AsH/YxEBpKTO8KMdfR36+rtCke6EHTnKKCBJrddG/gX2TBdY/j679y185yW3hIy2aomt0NtBAf5W1CfWI4eyYyKYxWzz6EEwavdLPFPDjp04NK1P/by3lVH0T//vZ+vuVE4U4TdgYbjQlJEYV6n8uT6ZiqPJ12lMSOshuFdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYzWh4d+H4Biuwxot5oy/BkwX5khpXx76i4370C6Mvg=;
 b=m2J6wn0cbnKmfmO0b35hEoAiCLpdodxqP8dK0sCEgkT1ORyLtmyy24AvhogT8yb/4aMeNGuxZDx8jELbKXBt2QUkn5CwotCs7/E0O8JMT6Xoeb94yR6LFI88jMu4PC5QvR+LSc3ld5z+tib2w5IyCpfVUvef4fE9dciV0JDeOr4=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by CH3PR10MB7744.namprd10.prod.outlook.com (2603:10b6:610:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 01:49:43 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 01:49:43 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: linux-ext4@vger.kernel.org
Cc: djwong@kernel.org
Subject: [RFC PATCH v2 4/4] ext2: remove buffer heads from block bitmaps
Date: Tue, 25 Mar 2025 18:49:28 -0700
Message-Id: <20250326014928.61507-5-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250326014928.61507-1-catherine.hoang@oracle.com>
References: <20250326014928.61507-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0124.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::27) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|CH3PR10MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 90eae62a-dc51-472d-11f2-08dd6c087a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yaE/5kk3u31szlHDykixUxXOwXkcf/vMLGvyNT1Y3L4GoUK7aBP/57P0PUCD?=
 =?us-ascii?Q?H+qmcccM/fwpBneRJHCz/M7pxpF2xVUr2h7cANd6nIfRhTL+6CcDVQmu/pPN?=
 =?us-ascii?Q?vD2STDXl75cQxye/OX+gAXr5zwHp43QF4OvBaR6m8exyLE/yWnLNBMqNQCXQ?=
 =?us-ascii?Q?ENjltpW+2Grye5MgJ1jVwb1PnnSco6GQJACGCgdIjK9OZIvvz8U0aJu+12Nv?=
 =?us-ascii?Q?2NoeUB1OBJ81Ou82uAOiEOWiL885bS8qA+Eoe+Tw2j2vkw+NBKrg6jhjQqq1?=
 =?us-ascii?Q?pLh35RcjxR/4zg6T8iQbtnuiYsRpHQ+KgamCtyZv3YPqDUz+baUof4rnTvZ5?=
 =?us-ascii?Q?AErmdiDWt+Jzh+MbSz/hfsAO1ok8Rr16Ghr4WQ6b25EE5EuzJ+v1cmYkVkDt?=
 =?us-ascii?Q?yOXLbwGEpBKxy0Q5qsB6jmejrn6utlPPz8PIMWF7WqNFU/dgxXrH1H9f7fgg?=
 =?us-ascii?Q?rzXpF6cD88T7PbwMilngTTwz8B5ZWAScdqL0HiT6e7RgQDQvD0GtZk720iig?=
 =?us-ascii?Q?sOdwWGglyDIS+ejGOwWl9jdDhKAhFG8J4n2LProbNac0yxrg/LMShKzUfm+7?=
 =?us-ascii?Q?Waa9Pr3xWN4L/NVv2QPssvEyk/9M11IzjzYPOzQdJfKLIwPZVkQuUSxJcAxI?=
 =?us-ascii?Q?0CE7pEs+E5CL/jlqbFiZejwgUp8QeFlxSIdw1NSMbmeLuiAhEIIhhQy5iq4h?=
 =?us-ascii?Q?jHPpi3dJo87qAVSsWLOR52jzzXqYqsunKfuLqaJjOVqud79B0/Es1XrsYJJC?=
 =?us-ascii?Q?Mo8K8TwjkLrn/V9YwLj073JZh0ChHzGCtS4GnmmLNElLru2e8nJxGQOtoqy9?=
 =?us-ascii?Q?Q/f1Bt1AVhtAcZ/TaYW6H/SpXBfrcn3TPjihRilYUi4ZNxG2GAWkH/Ld22C9?=
 =?us-ascii?Q?vu6EiEDI80ZcsfgGQJjFRceAimXOpibu8al8RfVRJcI8BN5aYRINagyFlA3R?=
 =?us-ascii?Q?X0QcjBmehN6kDq1Nmo8xLVkum5Zz/3wY0S20qfieWmX6QdUumaz89dmCVJZK?=
 =?us-ascii?Q?6MqS+1MOSFj1NFoj9jCIFbYKRy0ADFAGE1qnwlE1lsQsnT4atI4LSUjbFOZM?=
 =?us-ascii?Q?lBRCspiUkKbEy9NtEccdMNu75k57UIL7i/8vpz6KTKooeSlw0oa6u41mFj0y?=
 =?us-ascii?Q?H2Jri9HSrnWqI4NkBum5W24imYkIo/pRDhapnVte8R1rISf9gSeP6Fgx7YHE?=
 =?us-ascii?Q?WmFgDtxnDESLlxD2ZP0SOU7Ryn3I5jdE85b+v/X0/nmeLf/SviNr8u0Yjz6Y?=
 =?us-ascii?Q?pZkf9NG3HS4ftCDemGcZjAJWA1bl9bmS3cBThu2Mago8xh9FZiP4aghRSSSq?=
 =?us-ascii?Q?eBE37gU89Lo6AW/RDyYe/Mz/3wMr6GgY0Gniwg9R6L7EsTGizZA1sGjAY06a?=
 =?us-ascii?Q?76uSj+em078diSfTxb5GxVEVzPHL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lhtPGvwe5oJnXtrwaAFTrOrqYJg2mCj3TGgG9FbMr4MVh2i7bBzKNhmBItq5?=
 =?us-ascii?Q?LKt8uCZ+ikAShj1eaTuYxKWifGCD6wEgZyoMdRivkhA5PFW9dRJ4PWU6Sm3/?=
 =?us-ascii?Q?aAeWg0S602R3VhbBodycOR+Wmr7NKa3WiML1EP3Gb7NZvoRH3BwjI0KMz8nX?=
 =?us-ascii?Q?ULr5xBp631atIbyeKfpcA/hpdFQDqRxEki9s101r+naKwMpSsrWqNbqcP2yu?=
 =?us-ascii?Q?UQbjGMB8xlIEwA8NI7zI4gTHM/IPGEpcGGCArCocNdEQ/2JS1aI/qBEJQXcx?=
 =?us-ascii?Q?79jyBkajpVBRvYwSIA+OILQYwbMmUzg+WLjkv47YhuhBL0T4bz/jxL9tWFqf?=
 =?us-ascii?Q?yl53FKF1n7Y/LXkzgquwh9zXh1Y7qYTAJzLIusQvp8bkCnT1rCRV9Bg1yonQ?=
 =?us-ascii?Q?V9TKCWXGslw/jKzc/ys52AEJPw+juEvhIZPizVJOYo0/FsARWU+Aeb+maEJl?=
 =?us-ascii?Q?2rQlD86B1y98Rkm9jV3rZJHOuUufvA1VmirRH8c1hkhUWtW8WeOBC/M7Xu3o?=
 =?us-ascii?Q?tnxE4AWJsWKQUtFf+mnLLnvAiQcotDxQQxjJrQS6NBuEuthhkimCVgAWeKLK?=
 =?us-ascii?Q?aHVXQHIaXcfixXTFXKR21Xc0345fWrWsG19nZqOI9QwmA2o6ewcPSF+ODC6P?=
 =?us-ascii?Q?cxBL5RL4rKfWGjvozz4n5FxbLadLHeI7wZXAx18Q3quDfh1sI0Wx9xpaSvJJ?=
 =?us-ascii?Q?B5CEUSDoMsndCLxeg4ESOxm2y+WyGDqAmbbtBEibE2nmyW865ccPMnLQ30JW?=
 =?us-ascii?Q?0FIeLtI1iNM8ML0zR0CGQPPLmGJOdtaBs99+o1JJ4oGSqHgr5xrh0MhDhaFk?=
 =?us-ascii?Q?IpUpt2/MZRb5A2gXnWdzEJiUlUTBlgUQXfz5j49dD6xhpdo/5aC6TTINyg1m?=
 =?us-ascii?Q?7cCKIk0Tq4PwNZs27XlDLHInCHjxYZddpNmHjWvfJpC/ZBnalfjebY5IYVjy?=
 =?us-ascii?Q?gUD5k+G4wKM09FkNgKQjjARiSmwErwuO8+kv7WHdT29FkbGZkpMyWAPHBP9D?=
 =?us-ascii?Q?khbkvsmTcnUGpKD84XwLApm8A+cG78g7PygFl+8o50NFU6csBujoL/r8ivuH?=
 =?us-ascii?Q?mNfk5UmC4wSJyY/wXViMaowZda4i8jv19Y+O5vpAz1rW6Y/Ijo3qE1F9DyJX?=
 =?us-ascii?Q?CZ4htuzRiymloHoYsdWiHdw97KOUfvBWukWgiFQiV1IwY/7BS/RAi9XrkDne?=
 =?us-ascii?Q?euClw1MixlAcHykxXlS4E7uUKCDF15UVfoW8ZHvYZh2B8GuzH8R0R5QEGDCa?=
 =?us-ascii?Q?t/QMWTvd1DtESIjEWk+iSoWBN7Jp68FQjC02564rahLq7ve4ygWcCViQ5LJo?=
 =?us-ascii?Q?HKxnO4+gwvLfEgX8hwVYv4gTT60fcsEDVWjxLTwCc5cFQUAIrMwhhoHBJoM3?=
 =?us-ascii?Q?URD+3ZFa3g525pS+ZCUfc3IhqIlGe+Wyt8A9Z9kfG3YiI1QwkVEr6JI6LsJu?=
 =?us-ascii?Q?Un2pJ59HDOJMk6lFQDZ1YxAdjrtE2dO2bQqzMzNTve92PGWtCzUSPSJ6oA38?=
 =?us-ascii?Q?d+U74KvTt+oT7ERxmxcTphvNdPkvRHLRUMjqrEIIFINuY0hVqnztIXy3dwJ9?=
 =?us-ascii?Q?AYO3/1BvoB1pd/qMG/bIK8zkBzKDNpKPUr+GRNkwyPH3t1DD4rzAvVmu3uyX?=
 =?us-ascii?Q?MMBNRip0nLl8HwM9YkTfsmiYLbqRVCeI2KoSmaIgCGTucOoghQh54kG4LWt7?=
 =?us-ascii?Q?BDvr+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0XG5+WVjA8a5WaXBslYQegEq9UPwSoq+85aGEhoUALOoHjId6X2j2gU6cGxX6QxuvjvdMktygS1R5O97XLcaib4o7Oh1l663/0i42dCGQ2HBOfX1aXH+nXCGmyywcCPNvTaqD7kve5Yoy8MUzIVggOIMQe5IbFsrfruGGGKqShlu1lZCS5VY/fCS8EzuBgIlDxNlVgIG8ir6fahYmqxAjyOwglg+6z3W3gaj19NCNbsLQEndFi0zKZQ6KX/stJAYA67WNSdzqpHE9nzoUfV5cXyYtntuaCMkLG9sjPQH2GnMcwoLUe6Vfq8ZYbI3TbTT18qCARsRivat6twtfgvuFAA6Bgi2l461wa9CoCQSYIbmx8lChb6VvXuCjviOIbOVLBRD0PPL7puKOkZBzj5k0Kd2jMkEnkTB1UFHGCNZLJNpSjqv3iGSa434wfImo5gVVHIPLLuJflJtMKFSX5duwCeG7JOSbArK5i4pByHkT0f29EyJrwAp3fYOCnA8Pcx5/7Qii+A01lsg/BtrZXIwXoxRkP13lvOS6m8F2LZyGb2MdYXP8F6RC+95PsBwsoShDiZMwB4ejo2WHJzBbyM9Z0fsELq+x8I8P44s0DqXeQY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90eae62a-dc51-472d-11f2-08dd6c087a9d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 01:49:43.1249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmetZGu6ND+hBi9soqt75buJNqczZZZgEpTPJjc8+VasOs2kIMJbNRQSqEwLoT9IvHulKlwEgGciVquVYlS1/1r3UOXYspEEJSN4NAIhDvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260009
X-Proofpoint-GUID: -lUFH0gwbGleMw_xKwW3nt6uT5y0HOoN
X-Proofpoint-ORIG-GUID: -lUFH0gwbGleMw_xKwW3nt6uT5y0HOoN

The block allocation code uses buffer_heads to store block bitmaps.
Replace these buffer heads with the new ext2_buffer and update the
buffer functions accordingly.

Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
---
 fs/ext2/balloc.c | 108 +++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 60 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 21dafa9ae2ea..2195c6ddbc83 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -71,7 +71,7 @@ struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
 static int ext2_valid_block_bitmap(struct super_block *sb,
 					struct ext2_group_desc *desc,
 					unsigned int block_group,
-					struct buffer_head *bh)
+					struct ext2_buffer *buf)
 {
 	ext2_grpblk_t offset;
 	ext2_grpblk_t next_zero_bit;
@@ -86,7 +86,7 @@ static int ext2_valid_block_bitmap(struct super_block *sb,
 	bitmap_blk = le32_to_cpu(desc->bg_block_bitmap);
 	offset = bitmap_blk - group_first_block;
 	if (offset < 0 || offset > max_bit ||
-	    !ext2_test_bit(offset, bh->b_data))
+	    !ext2_test_bit(offset, buf->b_data))
 		/* bad block bitmap */
 		goto err_out;
 
@@ -94,7 +94,7 @@ static int ext2_valid_block_bitmap(struct super_block *sb,
 	bitmap_blk = le32_to_cpu(desc->bg_inode_bitmap);
 	offset = bitmap_blk - group_first_block;
 	if (offset < 0 || offset > max_bit ||
-	    !ext2_test_bit(offset, bh->b_data))
+	    !ext2_test_bit(offset, buf->b_data))
 		/* bad block bitmap */
 		goto err_out;
 
@@ -104,7 +104,7 @@ static int ext2_valid_block_bitmap(struct super_block *sb,
 	if (offset < 0 || offset > max_bit ||
 	    offset + EXT2_SB(sb)->s_itb_per_group - 1 > max_bit)
 		goto err_out;
-	next_zero_bit = ext2_find_next_zero_bit(bh->b_data,
+	next_zero_bit = ext2_find_next_zero_bit(buf->b_data,
 				offset + EXT2_SB(sb)->s_itb_per_group,
 				offset);
 	if (next_zero_bit >= offset + EXT2_SB(sb)->s_itb_per_group)
@@ -125,31 +125,19 @@ static int ext2_valid_block_bitmap(struct super_block *sb,
  *
  * Return buffer_head on success or NULL in case of failure.
  */
-static struct buffer_head *
+static struct ext2_buffer *
 read_block_bitmap(struct super_block *sb, unsigned int block_group)
 {
 	struct ext2_group_desc * desc;
-	struct buffer_head * bh = NULL;
+	struct ext2_buffer * buf = NULL;
 	ext2_fsblk_t bitmap_blk;
-	int ret;
 
 	desc = ext2_get_group_desc(sb, block_group, NULL);
 	if (!desc)
 		return NULL;
 	bitmap_blk = le32_to_cpu(desc->bg_block_bitmap);
-	bh = sb_getblk(sb, bitmap_blk);
-	if (unlikely(!bh)) {
-		ext2_error(sb, __func__,
-			    "Cannot read block bitmap - "
-			    "block_group = %d, block_bitmap = %u",
-			    block_group, le32_to_cpu(desc->bg_block_bitmap));
-		return NULL;
-	}
-	ret = bh_read(bh, 0);
-	if (ret > 0)
-		return bh;
-	if (ret < 0) {
-		brelse(bh);
+	buf = ext2_read_buffer(sb, bitmap_blk);
+	if (unlikely(IS_ERR(buf))) {
 		ext2_error(sb, __func__,
 			    "Cannot read block bitmap - "
 			    "block_group = %d, block_bitmap = %u",
@@ -157,12 +145,12 @@ read_block_bitmap(struct super_block *sb, unsigned int block_group)
 		return NULL;
 	}
 
-	ext2_valid_block_bitmap(sb, desc, block_group, bh);
+	ext2_valid_block_bitmap(sb, desc, block_group, buf);
 	/*
 	 * file system mounted not to panic on error, continue with corrupt
 	 * bitmap
 	 */
-	return bh;
+	return buf;
 }
 
 static void group_adjust_blocks(struct super_block *sb, int group_no,
@@ -482,7 +470,7 @@ void ext2_discard_reservation(struct inode *inode)
 void ext2_free_blocks(struct inode * inode, ext2_fsblk_t block,
 		      unsigned long count)
 {
-	struct buffer_head *bitmap_bh = NULL;
+	struct ext2_buffer *bitmap_buf = NULL;
 	struct ext2_buffer * buf2;
 	unsigned long block_group;
 	unsigned long bit;
@@ -517,9 +505,9 @@ void ext2_free_blocks(struct inode * inode, ext2_fsblk_t block,
 		overflow = bit + count - EXT2_BLOCKS_PER_GROUP(sb);
 		count -= overflow;
 	}
-	brelse(bitmap_bh);
-	bitmap_bh = read_block_bitmap(sb, block_group);
-	if (!bitmap_bh)
+	ext2_put_buffer(sb, bitmap_buf);
+	bitmap_buf = read_block_bitmap(sb, block_group);
+	if (IS_ERR(bitmap_buf))
 		goto error_return;
 
 	desc = ext2_get_group_desc (sb, block_group, &buf2);
@@ -541,7 +529,7 @@ void ext2_free_blocks(struct inode * inode, ext2_fsblk_t block,
 
 	for (i = 0, group_freed = 0; i < count; i++) {
 		if (!ext2_clear_bit_atomic(sb_bgl_lock(sbi, block_group),
-						bit + i, bitmap_bh->b_data)) {
+						bit + i, bitmap_buf->b_data)) {
 			ext2_error(sb, __func__,
 				"bit already cleared for block %lu", block + i);
 		} else {
@@ -549,9 +537,9 @@ void ext2_free_blocks(struct inode * inode, ext2_fsblk_t block,
 		}
 	}
 
-	mark_buffer_dirty(bitmap_bh);
+	ext2_buffer_set_dirty(bitmap_buf);
 	if (sb->s_flags & SB_SYNCHRONOUS)
-		sync_dirty_buffer(bitmap_bh);
+		ext2_sync_buffer_wait(sb, bitmap_buf);
 
 	group_adjust_blocks(sb, block_group, desc, buf2, group_freed);
 	freed += group_freed;
@@ -562,7 +550,7 @@ void ext2_free_blocks(struct inode * inode, ext2_fsblk_t block,
 		goto do_more;
 	}
 error_return:
-	brelse(bitmap_bh);
+	ext2_put_buffer(sb, bitmap_buf);
 	if (freed) {
 		percpu_counter_add(&sbi->s_freeblocks_counter, freed);
 		dquot_free_block_nodirty(inode, freed);
@@ -580,12 +568,12 @@ void ext2_free_blocks(struct inode * inode, ext2_fsblk_t block,
  * we find a bit free.
  */
 static ext2_grpblk_t
-bitmap_search_next_usable_block(ext2_grpblk_t start, struct buffer_head *bh,
+bitmap_search_next_usable_block(ext2_grpblk_t start, struct ext2_buffer *buf,
 					ext2_grpblk_t maxblocks)
 {
 	ext2_grpblk_t next;
 
-	next = ext2_find_next_zero_bit(bh->b_data, maxblocks, start);
+	next = ext2_find_next_zero_bit(buf->b_data, maxblocks, start);
 	if (next >= maxblocks)
 		return -1;
 	return next;
@@ -604,7 +592,7 @@ bitmap_search_next_usable_block(ext2_grpblk_t start, struct buffer_head *bh,
  * then for any free bit in the bitmap.
  */
 static ext2_grpblk_t
-find_next_usable_block(int start, struct buffer_head *bh, int maxblocks)
+find_next_usable_block(int start, struct ext2_buffer *buf, int maxblocks)
 {
 	ext2_grpblk_t here, next;
 	char *p, *r;
@@ -621,7 +609,7 @@ find_next_usable_block(int start, struct buffer_head *bh, int maxblocks)
 		ext2_grpblk_t end_goal = (start + 63) & ~63;
 		if (end_goal > maxblocks)
 			end_goal = maxblocks;
-		here = ext2_find_next_zero_bit(bh->b_data, end_goal, start);
+		here = ext2_find_next_zero_bit(buf->b_data, end_goal, start);
 		if (here < end_goal)
 			return here;
 		ext2_debug("Bit not found near goal\n");
@@ -631,14 +619,14 @@ find_next_usable_block(int start, struct buffer_head *bh, int maxblocks)
 	if (here < 0)
 		here = 0;
 
-	p = ((char *)bh->b_data) + (here >> 3);
+	p = ((char *)buf->b_data) + (here >> 3);
 	r = memscan(p, 0, ((maxblocks + 7) >> 3) - (here >> 3));
-	next = (r - ((char *)bh->b_data)) << 3;
+	next = (r - ((char *)buf->b_data)) << 3;
 
 	if (next < maxblocks && next >= here)
 		return next;
 
-	here = bitmap_search_next_usable_block(here, bh, maxblocks);
+	here = bitmap_search_next_usable_block(here, buf, maxblocks);
 	return here;
 }
 
@@ -666,7 +654,7 @@ find_next_usable_block(int start, struct buffer_head *bh, int maxblocks)
  */
 static int
 ext2_try_to_allocate(struct super_block *sb, int group,
-			struct buffer_head *bitmap_bh, ext2_grpblk_t grp_goal,
+			struct ext2_buffer *bitmap_buf, ext2_grpblk_t grp_goal,
 			unsigned long *count,
 			struct ext2_reserve_window *my_rsv)
 {
@@ -689,7 +677,7 @@ ext2_try_to_allocate(struct super_block *sb, int group,
 	BUG_ON(start > EXT2_BLOCKS_PER_GROUP(sb));
 
 	if (grp_goal < 0) {
-		grp_goal = find_next_usable_block(start, bitmap_bh, end);
+		grp_goal = find_next_usable_block(start, bitmap_buf, end);
 		if (grp_goal < 0)
 			goto fail_access;
 		if (!my_rsv) {
@@ -697,7 +685,7 @@ ext2_try_to_allocate(struct super_block *sb, int group,
 
 			for (i = 0; i < 7 && grp_goal > start &&
 					!ext2_test_bit(grp_goal - 1,
-					     		bitmap_bh->b_data);
+					     		bitmap_buf->b_data);
 			     		i++, grp_goal--)
 				;
 		}
@@ -705,7 +693,7 @@ ext2_try_to_allocate(struct super_block *sb, int group,
 
 	for (; num < *count && grp_goal < end; grp_goal++) {
 		if (ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group),
-					grp_goal, bitmap_bh->b_data)) {
+					grp_goal, bitmap_buf->b_data)) {
 			if (num == 0)
 				continue;
 			break;
@@ -869,7 +857,7 @@ static int find_next_reservable_window(
  */
 static int alloc_new_reservation(struct ext2_reserve_window_node *my_rsv,
 		ext2_grpblk_t grp_goal, struct super_block *sb,
-		unsigned int group, struct buffer_head *bitmap_bh)
+		unsigned int group, struct ext2_buffer *bitmap_buf)
 {
 	struct ext2_reserve_window_node *search_head;
 	ext2_fsblk_t group_first_block, group_end_block, start_block;
@@ -960,7 +948,7 @@ static int alloc_new_reservation(struct ext2_reserve_window_node *my_rsv,
 	spin_unlock(rsv_lock);
 	first_free_block = bitmap_search_next_usable_block(
 			my_rsv->rsv_start - group_first_block,
-			bitmap_bh, group_end_block - group_first_block + 1);
+			bitmap_buf, group_end_block - group_first_block + 1);
 
 	if (first_free_block < 0) {
 		/*
@@ -1062,7 +1050,7 @@ static void try_to_extend_reservation(struct ext2_reserve_window_node *my_rsv,
  */
 static ext2_grpblk_t
 ext2_try_to_allocate_with_rsv(struct super_block *sb, unsigned int group,
-			struct buffer_head *bitmap_bh, ext2_grpblk_t grp_goal,
+			struct ext2_buffer *bitmap_buf, ext2_grpblk_t grp_goal,
 			struct ext2_reserve_window_node * my_rsv,
 			unsigned long *count)
 {
@@ -1077,7 +1065,7 @@ ext2_try_to_allocate_with_rsv(struct super_block *sb, unsigned int group,
 	 * or last attempt to allocate a block with reservation turned on failed
 	 */
 	if (my_rsv == NULL) {
-		return ext2_try_to_allocate(sb, group, bitmap_bh,
+		return ext2_try_to_allocate(sb, group, bitmap_buf,
 						grp_goal, count, NULL);
 	}
 	/*
@@ -1111,7 +1099,7 @@ ext2_try_to_allocate_with_rsv(struct super_block *sb, unsigned int group,
 			if (my_rsv->rsv_goal_size < *count)
 				my_rsv->rsv_goal_size = *count;
 			ret = alloc_new_reservation(my_rsv, grp_goal, sb,
-							group, bitmap_bh);
+							group, bitmap_buf);
 			if (ret < 0)
 				break;			/* failed */
 
@@ -1137,7 +1125,7 @@ ext2_try_to_allocate_with_rsv(struct super_block *sb, unsigned int group,
 			rsv_window_dump(&EXT2_SB(sb)->s_rsv_window_root, 1);
 			return -1;
 		}
-		ret = ext2_try_to_allocate(sb, group, bitmap_bh, grp_goal,
+		ret = ext2_try_to_allocate(sb, group, bitmap_buf, grp_goal,
 					   &num, &my_rsv->rsv_window);
 		if (ret >= 0) {
 			my_rsv->rsv_alloc_hit += num;
@@ -1208,7 +1196,7 @@ int ext2_data_block_valid(struct ext2_sb_info *sbi, ext2_fsblk_t start_blk,
 ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
 		    unsigned long *count, int *errp, unsigned int flags)
 {
-	struct buffer_head *bitmap_bh = NULL;
+	struct ext2_buffer *bitmap_buf = NULL;
 	struct ext2_buffer *gdp_buf;
 	int group_no;
 	int goal_group;
@@ -1297,12 +1285,12 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
 		 * pointer and we have to release it before calling
 		 * read_block_bitmap().
 		 */
-		brelse(bitmap_bh);
-		bitmap_bh = read_block_bitmap(sb, group_no);
-		if (!bitmap_bh)
+		ext2_put_buffer(sb, bitmap_buf);
+		bitmap_buf = read_block_bitmap(sb, group_no);
+		if (IS_ERR(bitmap_buf))
 			goto io_error;
 		grp_alloc_blk = ext2_try_to_allocate_with_rsv(sb, group_no,
-					bitmap_bh, grp_target_blk,
+					bitmap_buf, grp_target_blk,
 					my_rsv, &num);
 		if (grp_alloc_blk >= 0)
 			goto allocated;
@@ -1338,15 +1326,15 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
 		if (my_rsv && (free_blocks <= (windowsz/2)))
 			continue;
 
-		brelse(bitmap_bh);
-		bitmap_bh = read_block_bitmap(sb, group_no);
-		if (!bitmap_bh)
+		ext2_put_buffer(sb, bitmap_buf);
+		bitmap_buf = read_block_bitmap(sb, group_no);
+		if (IS_ERR(bitmap_buf))
 			goto io_error;
 		/*
 		 * try to allocate block(s) from this group, without a goal(-1).
 		 */
 		grp_alloc_blk = ext2_try_to_allocate_with_rsv(sb, group_no,
-					bitmap_bh, -1, my_rsv, &num);
+					bitmap_buf, -1, my_rsv, &num);
 		if (grp_alloc_blk >= 0)
 			goto allocated;
 	}
@@ -1406,12 +1394,12 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
 	group_adjust_blocks(sb, group_no, gdp, gdp_buf, -num);
 	percpu_counter_sub(&sbi->s_freeblocks_counter, num);
 
-	mark_buffer_dirty(bitmap_bh);
+	ext2_buffer_set_dirty(bitmap_buf);
 	if (sb->s_flags & SB_SYNCHRONOUS)
-		sync_dirty_buffer(bitmap_bh);
+		ext2_sync_buffer_wait(sb, bitmap_buf);
 
 	*errp = 0;
-	brelse(bitmap_bh);
+	ext2_put_buffer(sb, bitmap_buf);
 	if (num < *count) {
 		dquot_free_block_nodirty(inode, *count-num);
 		mark_inode_dirty(inode);
@@ -1429,7 +1417,7 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
 		dquot_free_block_nodirty(inode, *count);
 		mark_inode_dirty(inode);
 	}
-	brelse(bitmap_bh);
+	ext2_put_buffer(sb, bitmap_buf);
 	return 0;
 }
 
-- 
2.43.0


