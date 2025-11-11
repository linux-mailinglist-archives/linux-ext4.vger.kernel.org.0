Return-Path: <linux-ext4+bounces-11750-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C991C4C81A
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 10:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0178134C63F
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B052586E8;
	Tue, 11 Nov 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CFu2az+B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kLlyNtGn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAAA21CC59;
	Tue, 11 Nov 2025 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851732; cv=fail; b=P1b6GFhL5KaMzZbECB667SHawtFd2EGEuOcLXlsAg9CIitqRgtb3GifGcoODM92Xw8HFOX0y+cE12e1XfFOzbtubOaBA1EEj6dgyjk+eUAdpb3ZIHXyLWwptqXRtfAR6tlRprHUNF/YqVIi4/Az9/B1AsF4ND8om+3IGZrrVR/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851732; c=relaxed/simple;
	bh=eOsxx8cDd+UVpyEuipejygpdGL+tmie52+TZ+vJkJf4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A7No9U9+6OzvFOm2P190gL9Bz3PtThwvR3oLq/eBTUT7acQB2PM4afjeS4x1mEPoUZpIvmAOcQc1kwvrzIAnxj75mZoieP+TQ9kVfm+oGlQhvcQleCNdIngPZKCda3/EcoSrbmIwfNm7mOJm3fG0At9HrR7Lp5u7qIe6YoLDZuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CFu2az+B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kLlyNtGn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB8N0Wv025551;
	Tue, 11 Nov 2025 09:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=a1NbTUtaVFjqxdAcW1XlTYJhwjIKWo1VaUnY73xIDGo=; b=
	CFu2az+BbBTyesMPTU+G/He9gg156yLpCEFQ5jWlmO2gD12A8D2vsRw8C08V+KKW
	XHnrmF64zGRsHDStLd8kyabjW4qQrd4+ipiWx2cc+xO5soCPXECU6AutSXhWobEP
	UWO3HUYM62Qq20OZUlfZL7WqyHYZ3Q0d9fY+VYVV9LDjNHQFux+TC9xgYDsqy1lO
	CGvkFB2JumAkWw+VomY5b4QOKZtkjSy/43GM5vbdsZGOi06QHbTxG2L2dimSLxJa
	AttJxVkm4JqR+/wBVthaZf5QRQwqDr9gucRmMa2GPLsGOy34QtVlPyGXCQyzWQcq
	NYonuG0mAGKzVJk1UrC2mQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ac1atr31b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 09:02:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB7xscm012603;
	Tue, 11 Nov 2025 09:02:03 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacs0h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 09:02:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lpr2MuBSvg0Zc2EI9vLnOrmr04GOkq7jWbIXxcXQn4IKMIrzQRdNFm1ZpTHeMv3PWXUtBlRUAZkDl1gGYLnW7N+Y85XyxVjriN5a6gcRpK35JaS/wcDmUis+Xht1p1Z8iWWNRwF7X1A6AF6I4KA1LgjT2ecvgqaI009UoYKaWOjVL4PVWnGkxcc705z/0w6u767lIMRDRqaeb8N9lHphqFZ/MRiyzFfMuTwQIK1bIPBw6e7r0uErzDh6l5XA/OI1Z3zqz2Yfd8Erm9QvF9eHlyy5eQpiosI0qs6ak+ewYUmY62XixhosdNpM8xhx7fUkdMouoHC9dYKRa3F0wXb4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1NbTUtaVFjqxdAcW1XlTYJhwjIKWo1VaUnY73xIDGo=;
 b=aGbiC4HY4Dq/ZB6/MMM8B7wH7/X5Sqp/6Zjla6v3ELMMb9n0UBkdYGwfX5r6nN+XHRu8dkF21lbawS4c1xxoy7A6rLYtMxEwHXapjibgmcEyLrwjjFAr+ppkQGL1zR+ebyBR3sTgT66qgV8ygsrV10lGktsquLbnqVLjof9ttPXAGL9d75HLSCRlFPlwBOxzXYXEo2w5ZXczD+k26FiFQSuZ01LlCcNa6Nm3HC7/7U5hK67rzQ5dXaRDw8oevUtAM7c+wyaxYDWQ/PWUn/6DdDjC3K12vhCeH9ighW8LPFvpfP00mQjIY6dv0SMMZ5pfMdzIJeqx7VZf0jjfltd1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1NbTUtaVFjqxdAcW1XlTYJhwjIKWo1VaUnY73xIDGo=;
 b=kLlyNtGnTpqbNAY82ZJIBxrYlloj9goZg312tkvXuhGg7r+qL0O0IsI4I1UndofI96wRmKHUzMBqWOgPmCUAv5ev77/vEgy4zoxL+jpbCeDnKKxgywi47k/Nhabv6xE99e1lKDKXA5jsDFVGpa/HIXcNVb8yc4Ud868HKN+ireg=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by IA0PR10MB6865.namprd10.prod.outlook.com (2603:10b6:208:435::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 09:02:01 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 09:02:01 +0000
Message-ID: <8d9dc58f-ba64-4abe-91b9-251636527a65@oracle.com>
Date: Tue, 11 Nov 2025 09:01:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] generic/774: turn off lfsr
To: "Darrick J. Wong" <djwong@kernel.org>, zlang@redhat.com
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909135.605950.17114455316765178991.stgit@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <176279909135.605950.17114455316765178991.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0405.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::11) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|IA0PR10MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: c74e8da4-9de0-49cb-7266-08de2100fa0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UW1XL09iR3ZxaytwZlhNSWQvaVpuV250eUxsWEJWNzlydDQvNEdrR1dGcmN5?=
 =?utf-8?B?WWZ1cjN1Vko4cC9nTXNrUUpHWlJub0c0Tjk4b2FwVkV6UEo3NDdHQzg2Y1VY?=
 =?utf-8?B?bThVdVN5M016YXJYcDBkWnJRV2VLZm9sRFdYNG5seGRPRDM0MytGZEtkWWE4?=
 =?utf-8?B?eExMRFVlamhPSldDTjFseTJwaVV1MSt0QytBWkJIcnNNNGkrWVdxV2FNa082?=
 =?utf-8?B?UTVDb0pOWWZVSXBNQVFoYkg3dVk1MG5QMDM4enUxeHJkb1I2Y0ZLV2YxQlpC?=
 =?utf-8?B?WXNrQVJRYXYzTGYza3FtWVYrZDltdW5OZGcxZlllb3YyWXF3eFFYdlV5aXpq?=
 =?utf-8?B?SkxNbDR3VmFRNllMTUlGOVJzWkkrek4wVEhCenV1UENvdVZZR2VRTU05RUlq?=
 =?utf-8?B?QzI1QjV5dCt1aFFOaXJFejZZK1ZyNldDQWwwZlMrNWpIbkZ0UTM1dzZudnVT?=
 =?utf-8?B?b0V3VndzZ1ZMWld1ZGY4YjZpOHB5WXpFL1YzcmRuZjU1MnY0bFpmNjNSYWdK?=
 =?utf-8?B?SGJLa1JQM01jK1pVTDV2WUxuaHYrNDBuY2ZaMVczMXhxdkRwek9NTVpib1k3?=
 =?utf-8?B?MzIyeDB2ZDhvSVVEc1FoemxJbjd3bGtTTnE0cXFBZC9kVmJHZHZONTc5bWpU?=
 =?utf-8?B?aHdzVytBT3lqL3E3L3hjbHAxUnNQbHNNWndoUWdwaEk3ZHUxTlUvbkROZlI5?=
 =?utf-8?B?YjJsUkk2UUdaa29Od2FjVzhaSkJJOGVDalpWeUlEYXBjWG9yN2x2d2tHQXRP?=
 =?utf-8?B?VGNDc0pYeEhKNWhXeVY4dk9paWtJWVFJTXJsTnpLdzFvQ24xenJLU2lWRHFr?=
 =?utf-8?B?TE1tTm04b3BtcjhNN3cxVTR5OExWWGswbHExWFB2SFN0SWMvMnBad2t6MVh3?=
 =?utf-8?B?cUQzZnU3SWtDYjJ1OHJNamhRK210OFFmdGYxM0lBT0laUkQ5c1p3ZnREY3Nv?=
 =?utf-8?B?SDhZaGk0WWZJc1N3bjJHbmFlU3FEdW8vYWhORUZmN1BIMDNLT281eENvWnA3?=
 =?utf-8?B?MjhhejFvMGs4cXJoQXp4VEJlWlBWZ1hpSVoyUnNHNTdSandLeVNOK2RTU254?=
 =?utf-8?B?MGRnNG9UOWNjRG82eEhXZ1NUQlRHcGNVY01yZWVleDZBWjgzUUcwQWxjUzQz?=
 =?utf-8?B?SStCKzE2azU0TFIxSURNa29YSjE4WHlMelhVbzVXcElXQ2VZV0FOdlArZWps?=
 =?utf-8?B?bUV6aWNBVjNWcFc4TThJRHhnVFFucjc2QjBVK0VaZnZ2cmp5NlhBbGNMVUNG?=
 =?utf-8?B?M3ZZYXl0Z3NkNm1ENUlXbUxRNmk5dmsyUGZIUkl3ZHMyZ016SW9vaHd4UXR1?=
 =?utf-8?B?Znh5WjZSbTEzTlB5RjhvZUNRVm01c0JLcXh4WVVGYUMrdnRSSFBpUmlDOXcy?=
 =?utf-8?B?L0dXVnpHMTJQNmowK0N5am11STNFMzNEUHpJdFY5MldlaFZTbkdhMitWUWc2?=
 =?utf-8?B?b1VEeHVES0V6Um85djUxaWZXWlhmY0ZodTFtU2YvdHRaUllXRUtGN1daNlFk?=
 =?utf-8?B?QWpLakZDZVluU0M2d0FUS2lIdFc4ck1OYmtIRUUzTG51MDdYNGozdVdHVnQy?=
 =?utf-8?B?Smh6a2lWa1MyWmlpUFE5MXE3U29kbkZ3UG1yaXN0UG5aVmd1QVBEWXozVG5I?=
 =?utf-8?B?RDl5Z2FxNjNBMkJKOXJiaUxqaVZhQml3M1BHRG9aQWY4MytjOExqVUNOUTJJ?=
 =?utf-8?B?ckVURUxocGJJRGFLcTFrQkpiV21qL3RkSjkzendycVp4QURJeEhmUjFWYVpR?=
 =?utf-8?B?d0RzTzAzMUhQR3pGVXQyRDNhbUFlQmFucStHcStpQzNSNG13WFNWa2pqT2p6?=
 =?utf-8?B?RGpGNWlMOVd5ekJ3SDJXcG1HaWVtejEwMHR0QlE1N2VKVWpHMmdmSk1Ob3NC?=
 =?utf-8?B?K0JGdlB5eEE2b0FrSFN5M04vQjJmeWhTUGxmd2JKUk5iL3ROeXMrNi8vWGFq?=
 =?utf-8?Q?FEbS2QDUSJenGfgE9pQjnoxixYkCyWbU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alJuU0preXlnSVA4S2phTkwyUUJpZm8wdU5wVXRtQnc1V3N5MkJOVXl3UWtN?=
 =?utf-8?B?bU5lR05MbDdKLzRDY1lvWEM5YmJIRkFkY0VHTnJoS0VoSXdvM3FMb0pTYVlT?=
 =?utf-8?B?N0dHL3U0ODJodXV4TUtJek1ObGFCbldQcGt6QjFmVUhaSGZaaFlJQXZBeERk?=
 =?utf-8?B?RjVLZXdvc29rN3pLQ09TeHlCMGdMN1ZmWlNkdG5INnBnbWFoS3V6elZXeXZq?=
 =?utf-8?B?Q2N4b3dCajBEeldENWZwSFZHbXplRmNPS04ybnljK3hLNXNacmI4Y28rQ093?=
 =?utf-8?B?ZGt6Q3puV0t0bTFydjVlR2xwbk1keGJJeTcvLzFaUXgrMVhvUndCZHB6TVh4?=
 =?utf-8?B?NHlNcit4Q1VtMDNDcjQzNGNDZDRDWmlBZm96V2FKUnBTSWdaNkpOb1hLRnpk?=
 =?utf-8?B?dXVHT0tyMFQ1Y0MvZTB0TTRPMmIvdWRVYVZIaERTSXZEUGJsZkJza2NRdVpv?=
 =?utf-8?B?Z1JGc21zY2t1U3dQeXpZTUJLRVlsV2h4Tm9jc3AyZFVpM0ZueTZpQmFXWk1N?=
 =?utf-8?B?ck5aU0ttVVZKcm9qSnU2N25EVndpMklKT2pOME1Pdk8rZWlUNFo3RWJoWGh1?=
 =?utf-8?B?SVBXY3FicWI2OHRmazhSVUxyUitTZkFmZHdjL1RDdGoxTzFoc1F4V2tzV1Jz?=
 =?utf-8?B?N3JGK1g1c1h2ZXkwaVBOalJpaDI5S2E3ZjNLTUJWWDNKek5FVzJ5Y2dqZ0Fm?=
 =?utf-8?B?STFmV2hVbTh0ZzZoS1l5VUhGaWthaVRyQ1R5MStaYVVXMHpRRUsyL2pkbkw1?=
 =?utf-8?B?K1crWFRWRlEzdjdhZUlzVjVCeU5lWnN3WlVROHF5VXZTQXIzUnlkTXZQVDFZ?=
 =?utf-8?B?ekFDSlNJcGFDQVJjWkJ5aElKWHFsL3JVbmZrQkhrOHdCaGdOa1J0TWNWbHZ1?=
 =?utf-8?B?Q0ZtTm5QMXBMNHZ0emZTSXRJOVcvMXFVSUtERHZRbjFpTUFvWlozSzdvYkhw?=
 =?utf-8?B?YXVObG5jMm9GZ1JNTVVlWWpicXpTUDhyNnF2YVJkbFZXTTR5NFVYSmMvVmVh?=
 =?utf-8?B?REtIY2FOcElSN0RXYzh2dysxaGRlekhMNnFUU1YrdXVZWDVDdS95MFVST1BW?=
 =?utf-8?B?eTdDVC9jRU1rSERQTEZreW00RlpldFRMMjhuejk5QmNzT1YvUGZ5d2VoQVll?=
 =?utf-8?B?Sk5WRVl0MS9MQUt2eEYyazVFNTREbmJMNW5TNnQzZ2NJMFN4U0NLSGpESXN0?=
 =?utf-8?B?ZEtXc2pDNzlodVJnNERMbGhyaEFROWN0MXcxS29ORmRrYVRDS29iVkRkaDlV?=
 =?utf-8?B?ZzFrRGVOR0JWQWRsSm1DdU01WllqazRUNFlSd3R4YzY3NnBNOThpKzVyL2NQ?=
 =?utf-8?B?aWdIRkQzZmI1WldaQlhmaStZQ2ZsQmdRdERabnU3WkZrS0pDSTU3UStoT2Jh?=
 =?utf-8?B?U2xScW9EWnloL3pUV3FtMm5yMTkvYUtYRlp3c1o5M2lkMzVvYzFsRVdsbFZK?=
 =?utf-8?B?OGwyNEJGMS9LY3dBMVlDWmxzTGc1K25vWlF3enJFblhyWHhaSEhlMUNieUtr?=
 =?utf-8?B?ZE03K0krTzBzU2xrZ1hQOG95TUlkWEZOc2pGanNoT3BUMW9XaEtiT2ltUytk?=
 =?utf-8?B?Tyt0QW4rTGduN2dneHZERDNQME9Nc1ZWcDdRWm43SVBNc0U2bnpvd0hENWsw?=
 =?utf-8?B?RStha2xKUHB5QXRhQWZWakw1WXlFaUpiK0Mwb09nbmY2VEJPaXFhdU41MXNa?=
 =?utf-8?B?NUhYZFVNTXdlR0FOVW1mVnRkdFQyZHZMQ3BLYmxxS0tWMituMkJNUDdYTzc2?=
 =?utf-8?B?UndZYjloSVFWR3VBek9GYUpEeGRPNTg4bDNxdUl4Mkl5YWZGaVp2a1hTMnZE?=
 =?utf-8?B?MVNTQmNZYlppMFpYdTVZVUJkREJES0xBSUh5U1UzUGFwTTNsMzZjNkhNRE4r?=
 =?utf-8?B?WW41MU9DUytKZTJKSGdXUDJ4RlFHNXFYVkJnMkNWMnc2cU5EaDFMTDRkamtE?=
 =?utf-8?B?SklFSEhqWlRPd3Qydjl1b1YxODlCYTNPS0MvM3l2VFQ1bUdTTm03VFZTdW13?=
 =?utf-8?B?SENXZXhSMUh1SGlCZlhTNGJ0MVJCSUJPZERDVnhnUzREWldlNlN1Q3BqQ005?=
 =?utf-8?B?aWFRcUo4b3JUUnhsMSszeGRjcURQSk5FNFJiSnMwQkpqWTloeGo1SXU2a2lw?=
 =?utf-8?B?bmk4MjhWbWNhLytzbDNwRG1QTGQ3WDVIZU9vc1dTYjUwNFZiRDNqMEZCMUxz?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8NLcFByVcBaajhyohjDE6475zifhOlSscdq4sqlLWQxozNteqfAybvcraAS1jPLGe49SzUTA5Qe+gE1ARVablyfiN0JnxIvvGY9oGmJWHSrZug+Ihl71n1bPx7G30L79zMf7cZPJGhQG70g8Z+QoKwrtCJ5aTnec4iIY59CjgcBo01yLSfgLewC3+dvJQE7yV1xrETxjcJx0xQJdTv52Vh5lv/jER19ao5sUQCIFtp5A37m8SboqEL+6pd0Jw+rP0olaIJFUB7Drajoz/GP4PcACbavJvPgM7c0RlZpJy7Cb9NW/eR9cBdb45Xb9EwGFu3AK4GiL1ZqM3xdBh8b2XBAzq5jb49b1zrE+O9VJLkeW3mKRQDcSTVqLnl5Y+OcnRjdH7YWx1m9kw3mrcakSO0+ygqFWDJ4HKAHlkiyEBhH6U2F8cLuhbK7ioSZTG/XYg1f19fq+D9nqwPHdz4W/YQx872XRIYPFNEPONJLQzXDmc7u/pIR1wEwU4rXl37NRZaRs2n/s4uPCmhSUYg6vBFsjZ3QJMJVrKOcQeRHV1gPiyXByll1Roxt9Lhy0zedisRoKvLQF9WqE36PWdIl2wPybCUj5HRxnf+wJQAKDbdI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74e8da4-9de0-49cb-7266-08de2100fa0a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 09:02:01.3946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peskwOa9KmeXK+C7CL1yzS3i19JvaCzyB1gQ2XFL6BBOLGEyoFaJziX0uPYRXzF7O1vV0SADXZSemK8qe8Nlpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110070
X-Authority-Analysis: v=2.4 cv=e9gLiKp/ c=1 sm=1 tr=0 ts=6912fb8c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=4ALUNsZVPbxUG-SwWeUA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12099
X-Proofpoint-GUID: 5FQMwnQdPi47qyzKRh1YeTWILpIxFZ5E
X-Proofpoint-ORIG-GUID: 5FQMwnQdPi47qyzKRh1YeTWILpIxFZ5E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA2MyBTYWx0ZWRfX+/T+lSJ8f29O
 KFgMnqkvBNjF1ILXlLyPkHloHoLFbBEo/BAOZa12Nm0XCr9jh924uM5p7S6xhiMopEUxa1lCFVO
 Eey1BEqAscudi6mZpNBE6AfpiDLh+al6oxUekce25VYow/eOicb2TnYDDyHC7OOqNSx8kXv+UKr
 uNkNClULefWpfO06PcKeZ8HzqpiQRYzjLkKhycjHx9NYJ9f8RY8wQN59n9xstAdBQgfblbj6bpC
 mBzz58S69PObtVMqUotbKE7gthYl37mLD3gSRA0gpC268xBpXZ7GBBY2ysPQJyZq5cozxtwb/Kr
 KuXnrbWlidzHTLqrqkTElFd+zlHE6O15ipiMIdIICnwk5wAkxbLs/pv5pOnexJHe7pQL2VqyyyK
 ofcTDe28BthukRZ4tZya7FBe3UQNA/wU9NyN3ePIylHyqiDXZic=

On 10/11/2025 18:27, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test fails mostly-predictably across my testing fleet with:
> 
>   --- /run/fstests/bin/tests/generic/774.out	2025-10-20 10:03:43.432910446 -0700
>   +++ /var/tmp/fstests/generic/774.out.bad	2025-11-10 01:14:58.941775866 -0800
>   @@ -1,2 +1,11 @@
>   QA output created by 774
>   +fio: failed initializing LFSR
>   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 0, length 33554432 (requested block: offset=0, length=33554432)
>   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 33554432, length 33554432 (requested block: offset=33554432, length=33554432)
>   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 67108864, length 33554432 (requested block: offset=67108864, length=33554432)
>   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 100663296, length 33554432 (requested block: offset=100663296, length=33554432)
>   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 134217728, length 33554432 (requested block: offset=134217728, length=33554432)
>   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 167772160, length 33554432 (requested block: offset=167772160, length=33554432)
>   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 201326592, length 33554432 (requested block: offset=201326592, length=33554432)
>   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 234881024, length 33554432 (requested block: offset=234881024, length=33554432)
>   Silence is golden
> 
> I'm not sure why the linear feedback shift register algorithm is
> specifically needed for this test.
> 
> Cc: <fstests@vger.kernel.org> # v2025.10.20
> Fixes: 9117fb93b41c38 ("generic: Add atomic write test using fio verify on file mixed mappings")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: John Garry <john.g.garry@oracle.com>

BTW, if you would like to make further tidy ups, then I don't think that 
verify_write_sequence=0 is required (for verify config). That is only 
relevant when we have multiple threads writing to the same region, which 
I don't think is the case here.

cheers

> ---
>   tests/generic/774 |    4 ----
>   1 file changed, 4 deletions(-)
> 
> 
> diff --git a/tests/generic/774 b/tests/generic/774
> index 28886ed5b09ff7..86ab01fbd35874 100755
> --- a/tests/generic/774
> +++ b/tests/generic/774
> @@ -56,14 +56,12 @@ group_reporting=1
>   ioengine=libaio
>   rw=randwrite
>   io_size=$((filesize/3))
> -random_generator=lfsr
>   
>   # Create unwritten extents
>   [prep_unwritten_blocks]
>   ioengine=falloc
>   rw=randwrite
>   io_size=$((filesize/3))
> -random_generator=lfsr
>   EOF
>   
>   cat >$fio_aw_config <<EOF
> @@ -73,7 +71,6 @@ ioengine=libaio
>   rw=randwrite
>   direct=1
>   atomic=1
> -random_generator=lfsr
>   group_reporting=1
>   
>   filename=$testfile
> @@ -93,7 +90,6 @@ cat >$fio_verify_config <<EOF
>   [verify_job]
>   ioengine=libaio
>   rw=read
> -random_generator=lfsr
>   group_reporting=1
>   
>   filename=$testfile
> 


