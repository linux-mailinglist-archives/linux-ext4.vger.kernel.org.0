Return-Path: <linux-ext4+bounces-6976-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E414CA70E9F
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 02:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4F21897D88
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 01:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92DC82D98;
	Wed, 26 Mar 2025 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S+FbbYLU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zLocp/W9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D82578F43
	for <linux-ext4@vger.kernel.org>; Wed, 26 Mar 2025 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742953786; cv=fail; b=ojMehmgFBfgUw1xrZ1Bbv9oAvgucTdquS6LGN7MFp/cyfsjMHD6iwsiwjZkZucAU6i8DZJu/iYFmM8KC/dCq+3VzH1bWDGBTwdExtijlfg+eKjd4S/ZGKQ321RdLl/hIXRNfyRVm21J7oZbZnSe6yWfTj+RUzP2frgNh40Jr4vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742953786; c=relaxed/simple;
	bh=bXkYyWF1Gpxhujm//H0ns/HNhO+tqoXmOXuv5VQKx2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SpPCqJUg8HCtif/komLelxv0or+5ONu1I3XulWvIKDhPwj9dt0DKHi6nPtOKDEW2ESVF37/FCYZXbeXf0dRpOOMJg+RJsZFZGFaapC+MmhiMowvvxXh6Bg0+QZTA+vihhWwbyz2nw/XCwcwb+UOPiDDGIc71xANozv0LHtTW1DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S+FbbYLU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zLocp/W9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PLtw17025382;
	Wed, 26 Mar 2025 01:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wtvQahwYdLyECpZQGL0CuWjQdQxkVK4S0tvm8fSdbmM=; b=
	S+FbbYLUx7W3/GTv4ikDXSLaJzi+b5AtO0+hZjZ5z3pSSMP5EF1Z3RXWquLogiTI
	eil5+UdrFqrq5Al6n4eMbSpbhcWwJGDmxdcJiIJ1TvyjnAkt5BsIg5ftEx4HbIS0
	VUoaUSeRNvjiUQu6WQjjNPXYucaYoTwHGfYL3+vQghqum/ujxKI+wPWfUNEU1TO+
	QRKkAsMxMojS8DeKxExWA9lHG2IyuxMjKUspBYufW8V428sCVX/odoceUK/UYXvU
	VctwjpmHNwZx0WNd+bYP2CCoMTdaDyu4Xw0TFcBtiQiB1Ts21sZp+JSOE6DgCw15
	4C28GI05wVrrKaPx/0AMIg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn870c02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:49:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q0RfLZ036457;
	Wed, 26 Mar 2025 01:49:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj5d6hph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:49:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TL8hPgGYPvYljWpcf9ejf5aExrktCaKPvMlVXJd6L9QtzDaf3/YNLBNwRWlm/B7pbMpkU14P8Bd++/1qRhvGHgEhJSoBybqwbMrIfj4TntaYilCTbGAb+e94GtXb9g5mAr5YrO5RDiwihkAcbQYJcobFzr02uIHJSwuWGweeB4ONKNmfmrYIy3rlTpxLM/7OdxkioSmfOA8uUaG0n60solcXGRDiK/Pmfs0nH1EfUJvaKUEQwhXGdQ0e5eiFjxlMrRfcvWgQN2641NGE17gKNIRKUdfgy5ast5tvMLYN9lFCm575NEsaTL3frKy+7lFA1+xIAHK+DMn4UCqeZvQU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtvQahwYdLyECpZQGL0CuWjQdQxkVK4S0tvm8fSdbmM=;
 b=NUh9NlVSLeDsaz68x1SzfV1Ol1RnFvGz07ca5yFYZ59UYwzqhIPKL24h4Zq/hA0VjEUy42NT2jNGRcCrtq/uoPfbFLUX9FZe1vHJ+xj3x3adGP16A/ImKdhpEqJBQ3vh+J+Z4HT0Aw+qE4Zt91sp70KpA9Wuih5yqnwhfWaZZCXG/lYY8acNMjNRUn8/OSiwSQIK/wRhD6io7BI/3/BzRwqdXqS7n1WXrFcqUP8UgCt4eV7OjlxNZk++3hNiBjlYGx51Dzol8RncDk2HO0NOQpVeNSxR4dMJwdHJ+dE5YtSoQsYa04f7sFghOMUMWArGcV3TvrScaBgWQIeFyA1VbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtvQahwYdLyECpZQGL0CuWjQdQxkVK4S0tvm8fSdbmM=;
 b=zLocp/W9hCejxLSZGRnQacdUVbS1hzYMofXFkvVsy/RxS8NqO70st6tT6dolm/eQjIriYTLEX5sZ4R7SHXmiArtZFWpXeyUd43C8Fg2EK+OKaAr0UlAPpZfeqeGz+Gv8ZMK6ejf7eIB4sQW+L8okalEf8jrjRnLeYe/wFuniyt8=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by CH3PR10MB7744.namprd10.prod.outlook.com (2603:10b6:610:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 01:49:38 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 01:49:38 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: linux-ext4@vger.kernel.org
Cc: djwong@kernel.org
Subject: [RFC PATCH v2 2/4] ext2: remove buffer heads from group descriptors
Date: Tue, 25 Mar 2025 18:49:26 -0700
Message-Id: <20250326014928.61507-3-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250326014928.61507-1-catherine.hoang@oracle.com>
References: <20250326014928.61507-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0065.namprd17.prod.outlook.com
 (2603:10b6:510:325::9) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|CH3PR10MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c378d23-0868-4662-b27b-08dd6c0877a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0YgTfDo5sxRoT6LSM0W9ncJmejJO27ciIedHvONjnGHqzSujkzzarBEfeJsQ?=
 =?us-ascii?Q?YdQTuaXtGciNMHqvWgIF2inXIyWEhLfYu5Zb8aqSctAm+RQxKUhrYxqHZNn/?=
 =?us-ascii?Q?33DjQ7g/znTBJr0RTfqoEnz/F5Y3QXetdNIRIWktQHFPyPUV8AApidw669+M?=
 =?us-ascii?Q?M0gScgbo1jEjpQ445ykIsqY1/WPp3jQkeXUDRfF0av3IfltLvcBK0ED0wPYq?=
 =?us-ascii?Q?D65uMwvVKVwoVa0EEZrc/7hpHL/lkcgl7HjwChKA4aWNlPHTd7ncIvWpXtrl?=
 =?us-ascii?Q?E7wM2c1YF0XpI4FDc+d6onBWSSSWwbg6VwUCC5ciySrmDqXkvsl1+4jCC834?=
 =?us-ascii?Q?6T8AVqc7si1oRFyK31/YR3afbgR5P0r70ca8QfLi2dwilK+fcSh73yL9eMVj?=
 =?us-ascii?Q?z/oMtsgTPaQvegxtLPKMaL0/YR8UBHi8iAcYgPQAeyfl+s80hMQVQnyoyLf2?=
 =?us-ascii?Q?3w81WDrLZtAJD8kgiVmwg+0bvRyoAcf919cHiij1zK32oAINYiBwo4z+O/WL?=
 =?us-ascii?Q?uzqNHuOnhw3eAcbDFLoBhmH9MmCMaCEgDDGeC2WER60yeyXf3WtMa+2a+b2b?=
 =?us-ascii?Q?3JvrRKn8bPGHysPDVbAamshiFGIoDoiFZZH2hbGgrSuKHFOELdxM6gaHSNN5?=
 =?us-ascii?Q?buefMMwKFHrX0xhcMi+eAH593AmWO1S46WJBxQNdOU72ocQ2DfhxLdEHnErf?=
 =?us-ascii?Q?pN2uZoFovDLXrSMdkvKKwFOYAF0bV2gUWU4mXostfdFUeEDz6ebwKsDboghp?=
 =?us-ascii?Q?wb6VD6XjwaTy6V/dZYAptiB0MMi8GNd80TkPg6Mu/8Aam90v5Fd/Q0i9Y3EM?=
 =?us-ascii?Q?kri9GaluxxeS8u7xILz5Dp5asoRexhP1WHbrp9rt6XRIj8CChVQSNRdFpwA5?=
 =?us-ascii?Q?HXf5u5fTtOFlzHYv6Ss7njFQrIzBT0NXsfntWIPYOoDZm2/hTJarIclMOKZr?=
 =?us-ascii?Q?JNG/GmC545HO556PJ2SDyCAT3pQc+4gojd4ORH1EsJ19WpO9vpoyFhUkzkgy?=
 =?us-ascii?Q?mYcImJ+lrZ5i8EiZIQn53BOHV8IVPxq1rOvFxvRxIvl3Z3PY17BOau+qQrRm?=
 =?us-ascii?Q?QICQIqzbyADSw8AgEK6lDgJXY8Cqw0mWF3Ds9y/53WTq+tO6b2zBlt1xGOYB?=
 =?us-ascii?Q?O4wh9+YNgKBRQm9DOq1JG/CBv77j+0RxcxG5IpzRHp6B5nK63R8pq8/U5VSa?=
 =?us-ascii?Q?imULhn+OhAMW9NybzD95GGaCSDXMMA5Y3r5a8zyHVl0MR3+Ui8trQwYG9SpH?=
 =?us-ascii?Q?dEoZKqvh50ih3OVfwr0KZ8JOXPdcPuI5kvOuC33C0odL2qNLC6+1g9fL1/jb?=
 =?us-ascii?Q?LDyq4J6IC2YugHY3sLOB2iTDFJlhJfnDdZlchjPo8ZA/InvNzLU3S2VIwdIu?=
 =?us-ascii?Q?SrB3qaQNDqCTz8St7vbKBG+YJVrC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z9CmuzTViW88Br1WtSY+WZMe6gtTyyE71Dx8egEBtSXO69R2zG5XSLAHHDlt?=
 =?us-ascii?Q?Z1bNtDqL1UtFhzKfAkY91t3ChsBOzXfcZF6SE2NaqGInDBWrJNteEVDgq3gS?=
 =?us-ascii?Q?aaoGsfoNpkxGv1AAYfP7R06xHY9m8bORW5utqYcPtkI9omHLI+pWFumSumez?=
 =?us-ascii?Q?8gPHgAh0XuUNu3guafHNHD32u4rPONRUjVe4btmZX575jgvAzZRoB/MgFoC9?=
 =?us-ascii?Q?s+ofPaYipjFyC8+ZZUbE6bsghGp1VvLGQGo9YIkDgqKt98yUZ3LHnLw5/fvD?=
 =?us-ascii?Q?lFL+2SDsoYoXlLArn7ExVEavW1J9Eh2MzdEkJG50vHD54Bi0A5RzNNffcWuM?=
 =?us-ascii?Q?AEf5gQ8YcSTz2oX/g9lDFJnSAVwLS1XlLJQFd5YEL+K2F/gaY+TblLGln0Xj?=
 =?us-ascii?Q?DkEHJRJNzQidU2Zw/1ca89dhKV34RaTCsWya2jlMKocOAX1FH59n+jnFILeT?=
 =?us-ascii?Q?rXe/cLlpBwU2n91rJdsiIj9f14Zr7dTMoJp5u2UmOnSN72ZwlF28664NiGjR?=
 =?us-ascii?Q?jxsvhFxJ11rIYWrvc2s990PHNQ5phG+kFus/0kJQCi8HkUl1zVNUQ5+Wrwgd?=
 =?us-ascii?Q?W7TA7ESYMLS8i0xo78wlO4nfbgakBg+s5mcHH+maXYHzGdCiqaWPUKUziB9B?=
 =?us-ascii?Q?/OHOgWnj6JoDH+bKlBti/T78GBFsmI2rAvjfDUJgfsVcjBBqPQTLveQMAk0H?=
 =?us-ascii?Q?zQEBiL/NvDJ1Wa1P69JKXO2hu2PhjgrTh1sYnUUodSoB4TL7D2pdV8AjO2mq?=
 =?us-ascii?Q?YHWJ6u8s7MUlQqmPfmpmUdcswUpF1ZFscQR9lfAGhze8FBv3b/Sbq50oZyyA?=
 =?us-ascii?Q?nPhdaByRVGXU4AgfO1xfp2ssaAd+l4csNhf0nUKrHyRLEV+2woqUoZFyi3b4?=
 =?us-ascii?Q?QXufsPfO13zkO10s3fnJC0BkVJMwTQHmiAAidalg/9SB9VZIw7G+rGTbEmRH?=
 =?us-ascii?Q?WEDK0SW149dfnwY029mfv9M+dKGPfCR9KpvWyTW6+J/PBpt2mtdUccYZCR3G?=
 =?us-ascii?Q?yxOSx3hCg0Lk1YOwdj1Gt4zoEPR25w9EeqXhape/C0SvorLoLmeD8cfVBeVq?=
 =?us-ascii?Q?Ex0PFI7HnHDapanaATvFCDTuI103tiQErIXXc0D8tlFKZomd+QBDf2EB3eIo?=
 =?us-ascii?Q?NozU5Nan9KgUAWpCv1Qs9h+vgEe3fKITfuWGeV4LvBJH4AwlJn5fk1isOvwk?=
 =?us-ascii?Q?YV1Ca897dLtmrwmPoqTrckn11SzxqrYHXG2pQ2D4rjwOPyV3RU8Y4GmlPnmP?=
 =?us-ascii?Q?T5sgfiAzUZALLqFTFEXktCKR4/HMThL2NqWMcYKex/7lXGJ67H1LTYRvCyza?=
 =?us-ascii?Q?3KacgLtmCQR+ZP78Rmg5tr84bTwPDBNzy0AGeqsa4XRer3p/2256w4ecOg1M?=
 =?us-ascii?Q?XWd2Ir1WhmBdvSI+h7dSErff6evytOjgmULYXZmMiHb2YSQyQ+2iL/MFZa9d?=
 =?us-ascii?Q?YiMAj6b2UEKkKsFvM41cQTCCekXY/vOKQqLTUjthqGUY9iWjNgiS9bDfP9wM?=
 =?us-ascii?Q?XW6bccA8+rumjIlKZG2SpHAFmhDE8xTYWfsWo0dfI6cF1GILX/YKFE07RIH+?=
 =?us-ascii?Q?X+YrNJ7eHiLaWMCeazWrHnAk3k1Zns9JSLA/DQHyq7iEjk+M1VhNXYeCJXqq?=
 =?us-ascii?Q?xCHjlUJ682TRmSSyoRZL6I+7M7+0sZU8rAZFJPNPqGOXJk9pNb04wV2cZp/Z?=
 =?us-ascii?Q?KuQ3LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MuBx5CDdrql/sScPxS/YmvXQEjsDnOA4oLdo6mkNNS0lEpqgLnTcZmzuNfCyB5i6bcHXN7laxmeY9PvVR2nG56wEytH90YfuKbLTGFdQsVLhOt6XYgRp1NOqOG19BNUcPHdQMHnohqNkK+5AZ/zPyFwmeNAyZJFg3gcv9Wpa7MiJsiE5WldqyRr/mDWiTUeAIo8OTo2bsu11nXpMgRvKv1Re1MtLI6b7vjjDM6U6T/IQnVy+cSgXtVAJkw1hVFmysEPbsCTlNMGP0Soc2Tlcsv+oVY7MR0Pt+vWjSTzwXGIfg0WP2pxzEKXT644o30tHHrW/JabaVvOuHSSyMO6AzhxuNNZ2BwVpyykWs9nmUreFt0qLIKKSCc0coZJailroWv7Xfv/sfzyMP24A26aHPYcFD/s2Q66HX+Pfq9z9pCVly4oxlDLh994e6slLKkqbWs229MK8OXWDE6yjAWcDfwHb/6eMv3IfQmW+fzozrlHUnL87n8WPDZfiQJU2MKntqL8c8Wir9o2BhBlCpnInSmlwYDiHCVEg7lgeMnCpIYeqbDAVec9H2zWwM/ogDS1G/WtPwN9a/KD5BfGsGi4irWgga5sVfIGM+99VC0IMJB8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c378d23-0868-4662-b27b-08dd6c0877a4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 01:49:38.4745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyooYc3XwvqTagpOy8Uw27XJP2HWGFkKNvoLod33MNgb7+YKQjh/bAdb/4R2VIg+ifZaDSHMGbtbYySIXJAAHrAznBczRVZN+efChe6xb4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260009
X-Proofpoint-GUID: e_W98WXoDGPgU_3imX3t7U8xJRuetltR
X-Proofpoint-ORIG-GUID: e_W98WXoDGPgU_3imX3t7U8xJRuetltR

The group descriptors are stored as an array of buffer_heads
s_group_desc in struct ext2_sb_info. Replace these buffer heads with the
new ext2_buffer and update the buffer functions accordingly.

Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
---
 fs/ext2/balloc.c | 24 ++++++++++++------------
 fs/ext2/ext2.h   |  4 ++--
 fs/ext2/ialloc.c | 12 ++++++------
 fs/ext2/super.c  | 10 +++++-----
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index b8cfab8f98b9..21dafa9ae2ea 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -38,7 +38,7 @@
 
 struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
 					     unsigned int block_group,
-					     struct buffer_head ** bh)
+					     struct ext2_buffer ** buf)
 {
 	unsigned long group_desc;
 	unsigned long offset;
@@ -63,8 +63,8 @@ struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
 	}
 
 	desc = (struct ext2_group_desc *) sbi->s_group_desc[group_desc]->b_data;
-	if (bh)
-		*bh = sbi->s_group_desc[group_desc];
+	if (buf)
+		*buf = sbi->s_group_desc[group_desc];
 	return desc + offset;
 }
 
@@ -166,7 +166,7 @@ read_block_bitmap(struct super_block *sb, unsigned int block_group)
 }
 
 static void group_adjust_blocks(struct super_block *sb, int group_no,
-	struct ext2_group_desc *desc, struct buffer_head *bh, int count)
+	struct ext2_group_desc *desc, struct ext2_buffer *buf, int count)
 {
 	if (count) {
 		struct ext2_sb_info *sbi = EXT2_SB(sb);
@@ -176,7 +176,7 @@ static void group_adjust_blocks(struct super_block *sb, int group_no,
 		free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
 		desc->bg_free_blocks_count = cpu_to_le16(free_blocks + count);
 		spin_unlock(sb_bgl_lock(sbi, group_no));
-		mark_buffer_dirty(bh);
+		ext2_buffer_set_dirty(buf);
 	}
 }
 
@@ -483,7 +483,7 @@ void ext2_free_blocks(struct inode * inode, ext2_fsblk_t block,
 		      unsigned long count)
 {
 	struct buffer_head *bitmap_bh = NULL;
-	struct buffer_head * bh2;
+	struct ext2_buffer * buf2;
 	unsigned long block_group;
 	unsigned long bit;
 	unsigned long i;
@@ -522,7 +522,7 @@ void ext2_free_blocks(struct inode * inode, ext2_fsblk_t block,
 	if (!bitmap_bh)
 		goto error_return;
 
-	desc = ext2_get_group_desc (sb, block_group, &bh2);
+	desc = ext2_get_group_desc (sb, block_group, &buf2);
 	if (!desc)
 		goto error_return;
 
@@ -553,7 +553,7 @@ void ext2_free_blocks(struct inode * inode, ext2_fsblk_t block,
 	if (sb->s_flags & SB_SYNCHRONOUS)
 		sync_dirty_buffer(bitmap_bh);
 
-	group_adjust_blocks(sb, block_group, desc, bh2, group_freed);
+	group_adjust_blocks(sb, block_group, desc, buf2, group_freed);
 	freed += group_freed;
 
 	if (overflow) {
@@ -1209,7 +1209,7 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
 		    unsigned long *count, int *errp, unsigned int flags)
 {
 	struct buffer_head *bitmap_bh = NULL;
-	struct buffer_head *gdp_bh;
+	struct ext2_buffer *gdp_buf;
 	int group_no;
 	int goal_group;
 	ext2_grpblk_t grp_target_blk;	/* blockgroup relative goal block */
@@ -1274,7 +1274,7 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
 			EXT2_BLOCKS_PER_GROUP(sb);
 	goal_group = group_no;
 retry_alloc:
-	gdp = ext2_get_group_desc(sb, group_no, &gdp_bh);
+	gdp = ext2_get_group_desc(sb, group_no, &gdp_buf);
 	if (!gdp)
 		goto io_error;
 
@@ -1319,7 +1319,7 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
 		group_no++;
 		if (group_no >= ngroups)
 			group_no = 0;
-		gdp = ext2_get_group_desc(sb, group_no, &gdp_bh);
+		gdp = ext2_get_group_desc(sb, group_no, &gdp_buf);
 		if (!gdp)
 			goto io_error;
 
@@ -1403,7 +1403,7 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
 		goto out;
 	}
 
-	group_adjust_blocks(sb, group_no, gdp, gdp_bh, -num);
+	group_adjust_blocks(sb, group_no, gdp, gdp_buf, -num);
 	percpu_counter_sub(&sbi->s_freeblocks_counter, num);
 
 	mark_buffer_dirty(bitmap_bh);
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index bfed70fd6430..5857d5ce7641 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -105,7 +105,7 @@ struct ext2_sb_info {
 	unsigned long s_blocks_last;    /* Last seen block count */
 	struct ext2_buffer * s_sbuf;	/* Buffer containing the super block */
 	struct ext2_super_block * s_es;	/* Pointer to the super block in the buffer */
-	struct buffer_head ** s_group_desc;
+	struct ext2_buffer ** s_group_desc;
 	unsigned long  s_mount_opt;
 	unsigned long s_sb_block;
 	kuid_t s_resuid;
@@ -735,7 +735,7 @@ extern unsigned long ext2_count_free_blocks (struct super_block *);
 extern unsigned long ext2_count_dirs (struct super_block *);
 extern struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
 						    unsigned int block_group,
-						    struct buffer_head ** bh);
+						    struct ext2_buffer ** buf);
 extern void ext2_discard_reservation (struct inode *);
 extern int ext2_should_retry_alloc(struct super_block *sb, int *retries);
 extern void ext2_init_block_alloc_info(struct inode *);
diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index fdf63e9c6e7c..36fe7975b2d6 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -66,9 +66,9 @@ read_inode_bitmap(struct super_block * sb, unsigned long block_group)
 static void ext2_release_inode(struct super_block *sb, int group, int dir)
 {
 	struct ext2_group_desc * desc;
-	struct buffer_head *bh;
+	struct ext2_buffer *buf;
 
-	desc = ext2_get_group_desc(sb, group, &bh);
+	desc = ext2_get_group_desc(sb, group, &buf);
 	if (!desc) {
 		ext2_error(sb, "ext2_release_inode",
 			"can't get descriptor for group %d", group);
@@ -83,7 +83,7 @@ static void ext2_release_inode(struct super_block *sb, int group, int dir)
 	percpu_counter_inc(&EXT2_SB(sb)->s_freeinodes_counter);
 	if (dir)
 		percpu_counter_dec(&EXT2_SB(sb)->s_dirs_counter);
-	mark_buffer_dirty(bh);
+	ext2_buffer_set_dirty(buf);
 }
 
 /*
@@ -421,7 +421,7 @@ struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
 {
 	struct super_block *sb;
 	struct buffer_head *bitmap_bh = NULL;
-	struct buffer_head *bh2;
+	struct ext2_buffer *buf2;
 	int group, i;
 	ino_t ino = 0;
 	struct inode * inode;
@@ -453,7 +453,7 @@ struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
 	}
 
 	for (i = 0; i < sbi->s_groups_count; i++) {
-		gdp = ext2_get_group_desc(sb, group, &bh2);
+		gdp = ext2_get_group_desc(sb, group, &buf2);
 		if (!gdp) {
 			if (++group == sbi->s_groups_count)
 				group = 0;
@@ -536,7 +536,7 @@ struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
 	}
 	spin_unlock(sb_bgl_lock(sbi, group));
 
-	mark_buffer_dirty(bh2);
+	ext2_buffer_set_dirty(buf2);
 	if (test_opt(sb, GRPID)) {
 		inode->i_mode = mode;
 		inode->i_uid = current_fsuid();
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index ac53f587d140..4323448bf64b 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -162,7 +162,7 @@ static void ext2_put_super (struct super_block * sb)
 	}
 	db_count = sbi->s_gdb_count;
 	for (i = 0; i < db_count; i++)
-		brelse(sbi->s_group_desc[i]);
+		ext2_put_buffer(sb, sbi->s_group_desc[i]);
 	kvfree(sbi->s_group_desc);
 	kfree(sbi->s_debts);
 	percpu_counter_destroy(&sbi->s_freeblocks_counter);
@@ -1093,7 +1093,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	db_count = (sbi->s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
 		   EXT2_DESC_PER_BLOCK(sb);
 	sbi->s_group_desc = kvmalloc_array(db_count,
-					   sizeof(struct buffer_head *),
+					   sizeof(struct ext2_buffer *),
 					   GFP_KERNEL);
 	if (sbi->s_group_desc == NULL) {
 		ret = -ENOMEM;
@@ -1109,10 +1109,10 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	}
 	for (i = 0; i < db_count; i++) {
 		block = descriptor_loc(sb, logic_sb_block, i);
-		sbi->s_group_desc[i] = sb_bread(sb, block);
+		sbi->s_group_desc[i] = ext2_read_buffer(sb, block);
 		if (!sbi->s_group_desc[i]) {
 			for (j = 0; j < i; j++)
-				brelse (sbi->s_group_desc[j]);
+				ext2_put_buffer (sb, sbi->s_group_desc[j]);
 			ext2_msg(sb, KERN_ERR,
 				"error: unable to read group descriptors");
 			goto failed_mount_group_desc;
@@ -1216,7 +1216,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	percpu_counter_destroy(&sbi->s_dirs_counter);
 failed_mount2:
 	for (i = 0; i < db_count; i++)
-		brelse(sbi->s_group_desc[i]);
+		ext2_put_buffer(sb, sbi->s_group_desc[i]);
 failed_mount_group_desc:
 	kvfree(sbi->s_group_desc);
 	kfree(sbi->s_debts);
-- 
2.43.0


