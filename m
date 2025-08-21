Return-Path: <linux-ext4+bounces-9492-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162C9B2F3E5
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 11:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2242600F1A
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 09:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5158B2EF657;
	Thu, 21 Aug 2025 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mkTIOpo6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pzD+15kS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6702E7F2C;
	Thu, 21 Aug 2025 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768316; cv=fail; b=lrt1qHYX7BO9jTI4dHxg3nhfUp+tosVY0yeYuJ0bgXpH3ISa6wn/rKkFWehKSXhWWIzpadh+OVAGiwOkfj1x7xJEBrgXD3TPbp+KIUmCMeFd2z6T6WWhXBTD2yf6WpBiQBKDLGCMpatLDm5O48YE3pZjiYHbUiDCnxuI8MUWWNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768316; c=relaxed/simple;
	bh=7Cisn7R2VRKlVlVF6DLFqwZ0CSGX/rrE9aZbbTzZp/s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TM3D7J0WlXM7ZWYOJ9d61z/iQXki43ZWR9l2AIv7rCl3VKfCiVhDT8rOSPn3APzk6c97DTQK4wpMyRyZY41YZ4BbW2v2Yd5tl01ROGMm3ndbJnfObGCTa2wdg5CCye2nYwG6mXnI8GFC34tsOn02CcH9yUp2psbJS3SgOGY2jP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mkTIOpo6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pzD+15kS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L8ofBI017597;
	Thu, 21 Aug 2025 09:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KYFuUbF1AZ3fQKRLsqMHN2glDEl2OsJ9l4vng2M/FOQ=; b=
	mkTIOpo6/G76diJHh4g8XLtJ21IWQGmrdHX9E/ce6sSDTY45omrvTaS2i+TKFBh8
	+W6WfKALkjYe/sDL+cvWjSgXS2IwvVCT5b2aog/MmfehEbWlBiTmpwDN1Y9mO0eK
	HfSjyHC3AA7oVbGxEdTuLdidX90j6HZUKf557iG9WEj5GBv2E61G+7KxWUvlDygw
	rRS00YPVp3fEyqRpSqbnbyoRqnsUVPXxvVmUb+gli0uCkart5x6U35DHbnySHbZS
	E2CiIKuG6fmVW1/Rnujpfd+DibqBNb6VYasz/w2d5ZhHvmXAShPQrgiUJpC1KgdK
	zhlPiZUCdmNQxpgSkv2SgA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tsb3u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 09:25:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57L99sZA039670;
	Thu, 21 Aug 2025 09:25:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3ruy9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 09:25:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+pZ5Z0LuqhEN7tNSytxhY6cKJUtli92IqZPvlGyC0XPFhI/Eg/pnG5+nN2sMup5HTDgY0Lq49kTAyyRdYN98KB0ZmUTJRFEqZjBgjpLv9GEVCqm31gWkT93RMoLXrDTyGw6jodJUC1yZNhFvvCa6r/BNJfeBxM+6xauA3lC53GJFPx1uTLRebdO+ygl90bA8dIj5lcOzu1h5IxHVe2lAdzHAqGEb+zbJ86IM5xoQS7YwZgYxfxTcplQVGy40XIRHw8QjiYWT/QonMED7hfcJck1mB+gJcCXRB6Jzna5DmEmndB84fsCi8iQEDcU+KWl2gf68mqu8lOQK9dm1y46FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYFuUbF1AZ3fQKRLsqMHN2glDEl2OsJ9l4vng2M/FOQ=;
 b=xQuCvxAR+uXDff8SSpKJ/sP30PAEAf15oFVYQvP0EEh/APuMSdPOGd+QMN8mubI+ieU9jq9oQmOR4fu7wpauoa1/Oe0MHtQ5t6sdOsey8iUhy3rOCmobf8420lH4nCoGVKyv3WpJXwqoom4sao5IEx/081dOZUd0xoD63ot4xeK/jHPFgj8/GIc1/HSYIY33LIFNFFnvlXdYqgvOM8kVyPX3oRICdzr1Ee0s7QqWdMevcgU+GoX56kLfru7icwyZd/nt5WzfyJdvs49LEGrjaoGOKCCMl3XIOeq506l+XTJGptSkWxDgDDVYU0gl81S8H31aJBnUguvrUJSuS1hBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYFuUbF1AZ3fQKRLsqMHN2glDEl2OsJ9l4vng2M/FOQ=;
 b=pzD+15kSik1GlQKPHeBFCwLcjWjBzZz2gGvH1Ys9/7tVdh8f9v5w8Ymv5cmNs623l8rjn6L5bWgOR4+/gLtPHiCczXfJBC1lOcMzq8RccujEA/nCLgfFN8Gnhy3U2wDbndFrzjUM4OiCUNCxRGLXIfBOhCH/lfq46ZbDbkiX4Jo=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CO1PR10MB4737.namprd10.prod.outlook.com (2603:10b6:303:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 09:25:02 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 09:25:02 +0000
Message-ID: <4572fcd8-6364-4827-af9b-d11728c39c78@oracle.com>
Date: Thu, 21 Aug 2025 10:24:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] generic: Add atomic write test using fio crc
 check verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <783e950d8b5ad80672a359a19ede4faeb64e3dd7.1754833177.git.ojaswin@linux.ibm.com>
 <f9ae3870-f6c5-4ab0-924e-261f4ec3b5cc@oracle.com>
 <aKbb2XhcsMMhBlgb@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aKbb2XhcsMMhBlgb@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0067.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::31) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CO1PR10MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: 474c5bcc-ce5d-423b-08f8-08dde0949b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0dtUXBVd1lDZ2RoVit1N29kU0FlMjZrRnJuOWp4ZVZaeVRsNGc4dDNvbW5u?=
 =?utf-8?B?R3VBNDdCdGNlL2hYK2tGTHZEVVhocXVaZEtFckFMZllBYnV4S3BwdCtUMmhy?=
 =?utf-8?B?MUJteXduWkNXQnVGb256Njc5cjBFeTZkMWhrMEdPZml1b0tvTFJGU3U3OEVn?=
 =?utf-8?B?cTJOcGM3WWxCK3grZVhya1JqOTQ3TEQ1ZG43UnkyNXRJZ2p5a0FxQ3M5cHBS?=
 =?utf-8?B?Smt2bm1sdjRMamVMa1NkbjlGYm9FZTU3R1JQRzlPVUZCV2ZscUtoSU9sT2pq?=
 =?utf-8?B?TjdaSHVvWUV6bFFoQnE3MHpUWi9kdURxczVkNHBFb204OUNPNC9RTDlKaFFE?=
 =?utf-8?B?S0hjRzZyc0Y0WkNnQVVURjBObk5kUFdYUGxpL0NsYk13V1Rad2VjME1jbFhO?=
 =?utf-8?B?cWtxd3hGRSsyYlYrcmZ1Q3dtSVVDK2xXM3JBNVFWdlU1MGZnY0dmZVd1dGF4?=
 =?utf-8?B?bVV6WDVucUhNV0tKc0s3bGxMVHcxeDZ5YittUTNjd1RzRG5idERTZWFOdEFj?=
 =?utf-8?B?dDZhOUtzVm9JN1pUYURRV3JSWDl3QytLTmxuaHd4dExrMTZIOUwvK1Y4QXdD?=
 =?utf-8?B?UkRoRGtka2tRckpiOUd1Q3cycXIyckhxMWlOOVUvZlZhV0ZMRFptZm5Cd3cz?=
 =?utf-8?B?Lzh6QW5zMHNWQzNPMkpSYTViMnREeDFhTVVZN040TU1KS3QvOTRVZzBLRndj?=
 =?utf-8?B?SGc1Ym92MDJJcExPTlVmcUZpcVpaVFpWT2NtS3RLN0RpVnd4Wklwcnc3RGp4?=
 =?utf-8?B?Yy9MbmNvZGlMSm9XYUd0L20xMTgzQkhUYmtpV1JjMGtmekVvMnpPZ2RGRVNr?=
 =?utf-8?B?TnJwUm1Ja01QaVlJM1FwcHpvREJDQnV0Y2xlYWczbzNlcUZZaGhySEM0aFRx?=
 =?utf-8?B?Ui9YeTFBc25pcVhBa2t4RFV0VHZuT0RZYWp3d1g3ZlR4WmhjRHY0UzlSM0kv?=
 =?utf-8?B?QWtUUXpTb0pCc3hYZU1PWHV1UjNSM3o4dEdFOUJGS3F4QitrZXc2MUVHK0Fh?=
 =?utf-8?B?UDEwQ096Y3FZM2laYlAzaUNDMTh2d3lYWEQ1b3M5OEtka3lqN3BRY2NueXoz?=
 =?utf-8?B?R3BtS1QxOHltWXZyV3RFdVJBRGpyWTd5RGVWcllzYTduU3dvWUV1SXpzeFZS?=
 =?utf-8?B?SXEwb1JzcWdJRWx0VUgrbGV6WkNoOXAvWmRXVWFNbmFDL1ZjTlpLdjZITy9i?=
 =?utf-8?B?ZFZROU4xZ3cvYzdQMW9kcllBYnEwU2wyT0w0OHVSOTVrc2lrNUNJK2MzbjlZ?=
 =?utf-8?B?MWFDeWRLTzlTZWpEaXgzb2NHVkJHVWZEVjlPR0F4QU53TlVDM1Y3WHRsb1Qz?=
 =?utf-8?B?Zmc1VjFMNHF2dDg3K1lMLzVGNVFhcy9iZ1BKTmM2RHNydTZpVC94NDdFVjFD?=
 =?utf-8?B?empMK3RYM200Zk5HVGNweGVPUUFkbXBQVG5iVGZwODkvbXJvRWtpakdNNEkv?=
 =?utf-8?B?aHEyM0F6QWR2RG5mREsyNHJ5c2JiUkgxN1I4OWZRNUVEWEg3S1R6Q2l1cGVM?=
 =?utf-8?B?OGF6RStNYVZBck4wWWtreis5VzNOaFV6Q21NYVI1NHhoOG0zc3BHRllHODBy?=
 =?utf-8?B?eitmYkdXaGFSY0hIMWw2Nzc1bEp5cUt0cGlvaVhKRU9ld291bHFUQ0FCSXAw?=
 =?utf-8?B?K3gwcjJRTHBQNTk5NGxqZGYyTlVwZVZpa0JQKy83ZGRBVk9RTFB4MHNZMGxN?=
 =?utf-8?B?N3ZjQmlDaEdLM3Fwc3VhVWYyL1l2ZFQ5SU8wU1VKUmhYb1pSenVSaGlwc2xq?=
 =?utf-8?B?b3k3RjdMRVoxd2MwM21PT1hxV2JwdXpFL3pxak5YRWF5TjZWNW55NVlnZVBP?=
 =?utf-8?B?enhyOTZhT2VqSklYeXI3TWhvQzRsOEVFTHM0L3VZcG0vV1FsUndOMzZnVk9z?=
 =?utf-8?B?SVk0M25WYUNJYy9vZmZzK2VYQ3AyQVZ1RmZjdUg4RXIrdkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VExqQVl2WDBLUzNFbi83a1hERGVaOGtURmkzZmkxYnljYUxjUldNeFdZRVB0?=
 =?utf-8?B?bUl3Y3R0c0EyRzVVZ0xmdU5rdUZzSS83cVpNbDFTN2dnYzROaHNJY3NnK1Iv?=
 =?utf-8?B?SzM0dWZkc0dobHk0WUpLNEM5OGplMGpWQ3pGNE90N015VlZ4ZXRKTkZsNXAv?=
 =?utf-8?B?YyszSkJlMHhUREo2UmZERjJkbFhyTEcrMzhxQkFMeFQrTGxtL3ZtY1hEMXJs?=
 =?utf-8?B?VmV4aFh0d1YzaUttMFZjRWxtUm91dU1SQUUzQlFadm9UVDlWVFdyb1FWZDgz?=
 =?utf-8?B?R2krdVh2V2FOZUVPQ0o0UFJSZEMxcDdyaS82TEo0SEZya3FSanhHTkh2TGRa?=
 =?utf-8?B?NVZsRTY3cjNsOXVZU2xDRVhNcE9xZGdtMUk3SksyM2JqMll6TWl3a1Bac0FU?=
 =?utf-8?B?NEV2TDBoUnAva3EySXZ4a2JPMzV1WmJkYlRBYU14N3h3Nm1YNy8xNndkekUr?=
 =?utf-8?B?YURiRXhnNGp6WTlFSUZWTEMvajcwR05Fai8xWDM2ZVRTRW1SMkZNUUZMTFZM?=
 =?utf-8?B?N3ZkWjM3YTliMEx3MFB6OERPb1RLVnV6a1F4a0JXeFl3U1NxWTllTm1KNHlR?=
 =?utf-8?B?NDk5S21WaHhWclVHYUE3ZldEQ081M3RkTTF2eGRJYUJjaTZlTXpsaTF6eUR5?=
 =?utf-8?B?YkYxdkhNdzVDelJ1YklSYkJuSmZnbE5Dcit2N1FaRVpWdld6MXhuazhHd243?=
 =?utf-8?B?VzVHS0tVeENXUlVpejBVUHVsaEtzUUkrOVJPalgrZGV3aDJnUXB3M2V5ZWsw?=
 =?utf-8?B?MmlBR2d5elh4SVByeGtpVDQyUFlOanBPOUIvUUpTblBySmlmZUpVY3NMWTlF?=
 =?utf-8?B?UW9PcVBSNGhudnh4eld6ZDBCQTNxajVDNjRvOGljN2JjOWxGYkVPTk4wd1gx?=
 =?utf-8?B?QmJaN2wyRFBqOEg1aitPUTJxNlpBUTBTSnBrVVVXRXRSNHJBK1pXdFhOSis2?=
 =?utf-8?B?cVFya2YvaGI4UnBPSHZZZlJlQlBobmZUYzBDK3hVKzNtNkpuNDAybW5NcHdl?=
 =?utf-8?B?a0JtVHdYd2E1blRGRkxYNTZPMzltbit5ZksyL3ljV01RVHA1Z3RCc1dtT1FE?=
 =?utf-8?B?ZEJibzNTZEpBUkVHOUVkWVdxRWpPSG9vZjVNemM1K2t6WUdZbmE0b1FBWkhu?=
 =?utf-8?B?cUVydUFmTFNRVUZRcVJYYmtKUkpVWjNlZzJ1d0tqNDQ2b09RRG9HUzI5U1JP?=
 =?utf-8?B?YWZZdFBybS9uV0l5OVRNVnp6L245NFN5Q2tsODVBdmlsMW4weGFtUHRTOHAy?=
 =?utf-8?B?R1IyMUJ4OEd3YzQycGZwRUI4Zk90cDJTeTZBU1JNT2Ftd3MybTZuMkJVVkFZ?=
 =?utf-8?B?N25VZ3pQaERvOGlZVm1HUU9iK3BHbU9qdnNtUWpiUGwvUWFudGNNS1lWWDIw?=
 =?utf-8?B?NCtSTTZ3c2JzNzNORGpRYjhrZjQzcmdUREJ4SzRYemY2YUcxbjdFaUNvdlZG?=
 =?utf-8?B?SGY4UnhwVHArci9VbEZXNW1wNGF5U2Z6c1ZtNmMrNDdEaEl1aVlVa0VBci9u?=
 =?utf-8?B?c1Jvd0MweXdNUjE0ZngvbUZBeUdjbDJPRU9wRWZ3ZmhkUTg0NW9IcjRFVkVw?=
 =?utf-8?B?Q2J0OGFpbFdtajZhSS8wVVFsSEpCQVlVVVd1dndDTmVwdnVIVTJFNDZsYStv?=
 =?utf-8?B?ZG10MlBBcDRSR20rZ254STdiRWRZbmxwbSt6bklqak5UZlZEUDVBaVlxdnVK?=
 =?utf-8?B?azdiRTRRVFRlVXpTZTZaV0pKb1Y1WTljSktGdzJQMC9RYWJPUDk1bDFjZi9S?=
 =?utf-8?B?dytQY3NpZFE2VE5USE1td1Mxa3ExelcxWmtMMXoxUUJ3MWpsdyswSW8rVTRm?=
 =?utf-8?B?TVc4MC9XUkRwVURTVW5wNWZMcWdOdUIwWlZ6ZURTVWd0NVZzaEtrc2laL1Zz?=
 =?utf-8?B?ampIU0NKUzBSVTVHWHFzVXFHSjNvUFV3OUo1K2xXVStCVFBoNkI0WDZicTBw?=
 =?utf-8?B?UWdtOUJGNDZHazBLT2UzbnJpYTVRWm03WWQ0UEVhdDZzUmhYcFduZDBsUUln?=
 =?utf-8?B?azkySVNaOEJQa25zRldRMno5ODdtMldINW5DZTVTaHREcldUb3VlVTBPb2o0?=
 =?utf-8?B?ZnRFM2YwN2s1eUNXTVVrZDNkVjlJM3NXUlMwMVJ6MjRsanBYSVhEdFoxQzBi?=
 =?utf-8?B?cmlnOEVCWWZtZ1A0Q2V4MzF3SmhQamU5YldhQ1lpS0FWY1Yya25ERjhEMFJ2?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DgdQQjzcyB+Q3HpicPHxC4jdPPkSuJrkoRWxeZCtQ924T83KbAQuoxZT9StAcnEsavER0Vku60sfdpM8gKyPI8z13zlxKXyMmxe+TdEl3NJj2Qv7SUmGoyUdeHBq3D69ocbZvhFX5b3pYNzciwVJ/C+jDUFLxrprpHuuxVbEdIW9DqCpZ8KONX8IJnOPBre6KaaHJkgW0rCfvRxJ9yITXOO38fyH23psio0RLOGCGdCx2PsV4ESejQleFcHhcGwBL/+Z70F+KxFK0RcJsf5RUct35dP5ZNFY0M5RkvCoW+NSaIpjonxL6VcXhII7lso9AnH5zyIC3cCMS6gGjcU8JlAjrBghM/PscitS8wvt/BjqtQ9XTKC1djGd2cFpDCSp2g9AgteeM5DT4cIlLPMG4vy7KUb+FH3HUi+BKgz1ioPzq0ZfTRSRKBDYrGfJ8f016VT3NDZBqd5eEhEmjhhd0AhPmyAEnFE7UoJq6T8glQYRS1BH3hvKLyH8gY5DeyGK99UHKNojloODuip+yqvqTcuCNbY9JNOFVtimd+Dv5dJSBCEh7HBko5dbfY3QNDaXIJ31nsHt26IbwwIHQaJ9PU8qzqjapc+NstzwuAOEKvo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474c5bcc-ce5d-423b-08f8-08dde0949b7a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 09:25:02.6413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dl+hh5bpFH/52uVynCtXti2sBN/f1C142jm106mJHi8vY6mm1NyBjTgJMHSurbqU96UqoNIya3Whi9r5iYE1fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210073
X-Proofpoint-GUID: sUEKEGbvP7g7V54wQvJ_Gfs5LOhs5Zyf
X-Proofpoint-ORIG-GUID: sUEKEGbvP7g7V54wQvJ_Gfs5LOhs5Zyf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX7zPtZBSVUnBW
 PtEiF6+1bDlEvQR1DZmgMP+1KaU9YQZmG2gPRNmeJxNONRLhIN/nIQfveMh4jS2LEO8EffmV7ey
 1moxjvv3555Y2o8JVZWArjmtnqhPNOmy+/uu2gVRfojMDLl5oCWCfN9eBCpwMOVNe4FTinSXfv7
 IFq3C86MUMuHr5O8ww6zlAGlkQ24d/BY79mcXCduuzqSZprePQMBKo2Cpd11yq/KGu6gCWIp6Xa
 5kOIQ+y5wwsiIxuHbslMwIFdH50sJMvJjMRIlbBXQlGAjRnUF1XdEzfb1SbJKYn9lyOzR+Hhzp2
 8ejZzng4DGU5nWXLsMy1fGVzOxmOnEDd4+swx+YGXQlZT8yEB//xMt4km5Q4qTZctr6InWVhG3R
 jZkmZfOu48FnlS45Jc6g0aE+A6RYBw==
X-Authority-Analysis: v=2.4 cv=HKOa1otv c=1 sm=1 tr=0 ts=68a6e5f2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=ddgVzCI8ugmv371CbO8A:9
 a=QEXdDO2ut3YA:10

On 21/08/2025 09:42, Ojaswin Mujoo wrote:
> On Wed, Aug 13, 2025 at 02:39:40PM +0100, John Garry wrote:
>> On 10/08/2025 14:41, Ojaswin Mujoo wrote:
>>> This adds atomic write test using fio based on it's crc check verifier.
>>> fio adds a crc for each data block. If the underlying device supports
>>> atomic write then it is guaranteed that we will never have a mix data from
>>> two threads writing on the same physical block.
>>>
>>> Avoid doing overlapping parallel atomic writes because it might give
>>> unexpected results. Use offset_increment=, size= fio options to achieve
>>> this behavior.
>>>
>> You are not really describing what the test does.
>>
>> In the first paragraph, you state what fio verify function does and then
>> describe what RWF_ATOMIC means when we only use HW support, i.e. serialises.
>> In the second you mention that we guarantee no inter-thread overlapping
>> writes.
> Got it John, I will add better commit messages for the fio tests.
>>  From a glance at the code below, in this test each thread writes to a
>> separate part of the file and then verifies no crc corruption. But even with
>> atomic=0, I would expect no corruption here.
> Right, this is mostly a stress test that is ensuring that all the new
> atomic write code paths are not causing anything to break or
> introducing any regressions. This should pass with both atomic or non
> atomic writes but by using RWF_ATOMIC we excercise the atomic specific
> code paths, improving the code coverage.

I am not sure really how much value this has. At least it should be 
documented what we are doing here and what value there is in this test.

Thanks,
John

