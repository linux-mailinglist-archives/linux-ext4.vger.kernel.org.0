Return-Path: <linux-ext4+bounces-9828-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3051B45DB9
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 18:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFED1C85204
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 16:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438B3306B23;
	Fri,  5 Sep 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TGo9nZiz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RQOT/txK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B9224F3;
	Fri,  5 Sep 2025 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088903; cv=fail; b=Vx9s6PsaGv0F1jp23UCHA6EkbSxV5mKCrFNmwbnUC6JLjVR5cTUKCs8SXpSKi2lDAn8TUoOL0NbgN8PvmEg1B4YWQUaAoHWf/u2b8Dw8OCC1A3uPp3h33f4evDyPAvMTRlI5cDrsENjAmlU3zz9INpb76dhWGdz3DbzlQJCghY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088903; c=relaxed/simple;
	bh=kcq7OXmGdHiJwik42hrL1RmlDMU/1PTfMKKHHkEN9oE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NeS/WUCBBWfOux0gTrsQibhls8OA8ds0/bomGShbhnFHJK8smbcGDZn8Nqm6HlhXRDTxp+sPLL9393+npKT9BdLyyMNQtWxiF31sXt1b+OpkIfx1Decd+lvnXRSaT2Wh6isvjOK+kR054/Al6KN4Bg1RfxxcthIceKz9DIYAyfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TGo9nZiz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RQOT/txK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585GB4Ek012297;
	Fri, 5 Sep 2025 16:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fHBg8Y8Yj6DdloH45eWxj0qRiPBiwu9qUxMBjgXACNo=; b=
	TGo9nZizikN5yaIOcw4jdK498S/EIvrcUg54sb5kDC2CDrwfhGr9xCx6PppqyDTP
	LOFIB84NvTPuYlAYTfXQlWqvUqD0KBW0mn/uhZmAm/gtoiHKhIZxwCk1mkVOnFWr
	IK99mexnzMvc9JSrWjTLb0Tu+gzsJ3Ytj30EpYMJUOd3b1oAPUV8NsBvvjzuAIpL
	v8kdBVMIEyjrJ9nxU3neWHjYF7GWJeeFQVLIAwJRkkKfevxnsruCEYvQnRiqmoQS
	465tpEgqH8AigB/2dTn4ozlPXq7Ru90s6wOMsVsp9jCb38jF5wbcVdbXHYAly+up
	aFb3vrCcsKckeRicVhMIpw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49034v808q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 16:14:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 585FaFbq019604;
	Fri, 5 Sep 2025 16:14:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrd2gxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 16:14:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6Ogs8K8FRFT3D4k3S/k41DSoScqwkETFKN1sUM4glJToUWXN1mgVpGc0XRuUIg90e98Ukrew/78Pa/klhsgRzKaUPidzT3nQXZec1cF0CyZCrtbvlvir0epGXIbirTXGpyjf6JJh2uUF5pwuof70h8VPTSaJkcLnx7/3LZGsY+yFe8PkDnz84xOs2UR6RWzumnLUZfzeip7F/9Dn/LLjag2ashiot2/uut2Xcgx9vVSzLlXISEXQ1IVsunA1/mMkYSB5a6QwfvG5MRGejsSZV+X3K55EJ2Jex/FaY2JsOn3In9UoZITMR8NHTLfze1QaLh+sJSTjS3ETR/S5gRVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHBg8Y8Yj6DdloH45eWxj0qRiPBiwu9qUxMBjgXACNo=;
 b=Bgxcnb4tjGHtRO4WUmIc5+F+Cn8ttPH2yG5iRdULVP7JRqfzUiTLjESQMblJh3LDWr9j9PlvgNFAWhqqPKokqxcVFaE9zfoh6ZFgZ/K1sUBask4hdpK/4h2qkNcS+hJpkMbYvC4fZlYmHzHAvMK2IsqM3aABcWfAkoAfNs88OIvTmNMxIq9Z7EKTd3/5fALUFpAnCE1udIBHunbGVnKxz+9KRMNZjnYWOuk8ni2mMxTjWeJ3oc+JtqDzyAzQVhMkk/PySkJW2upoJiiDGfr2B8xgoRdwqVQmFBsMNjtnFrHwHNY+ULYk7E9oqTodPaOlsDIVbN5vT+AUw600qVOHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHBg8Y8Yj6DdloH45eWxj0qRiPBiwu9qUxMBjgXACNo=;
 b=RQOT/txKbrSpCWDe62IXgotfy6IKW6uADaeDhnySMUCtlNhUo4kuEWUSVFVaxIdrlmOkzZxV5x18Oke2IAH3ysm0I8+I91L078K4oKPE3ifSGaP79gIhC76LBBDKP+kz4QXq8eyDH9Adffh9wzVLTJA+oJqS6Xx77HUag5vMX4o=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH0PR10MB5081.namprd10.prod.outlook.com (2603:10b6:610:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 16:14:50 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 16:14:49 +0000
Message-ID: <76ab5bdd-1d8b-4024-8eac-73ee247e9410@oracle.com>
Date: Fri, 5 Sep 2025 17:14:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>
 <aLsG7Y3jPk0DcVOU@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aLsG7Y3jPk0DcVOU@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0082.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::15) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH0PR10MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: af5d3b6a-024d-4cf9-5366-08ddec9756c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tzk4S0ZJU3kzTjZaRlFGTjJyQk1vV1liSlpNdDR0bzYva3NtYks5WWNyN1BJ?=
 =?utf-8?B?SEMweExOaUViMFZ4bENwcjdUY21HT2ZqSTY0RXNNa0tacFpGMWVyenZ5SzBZ?=
 =?utf-8?B?amN3c3NPeXhSM2FBZnRSSEZ6WDhWSEVjREFRTHNheXRMaWt5UjRHSTgydVha?=
 =?utf-8?B?eHZxek40UnhraTJuYVJPcWxKUDRsTWl1ZE9Wd09SZXI0OWVQOHA0MEI0NWt1?=
 =?utf-8?B?SEh5MmV2SWZ4SzNWSFF4MzErWWoxS0hMQUJpUlZkbjd3UytCTld3UEdkRkxZ?=
 =?utf-8?B?UEZTWUNvaHBuR0JuUUIwTGJQR2RYTTE5b05DWWtaNDlBdnlKaHlLSEZ1NUpT?=
 =?utf-8?B?NDYzK01kcXREbXdaZ3JnaWQrU0ZVRDR2Q0s1RGRGb2p4Tmg3akY3c2dWS3Nv?=
 =?utf-8?B?eXBXbVZscW55REdiQ0pCZEpBZk1kWVJzcE9XdlNRSDR0YVA4L25ibEllZ3lI?=
 =?utf-8?B?QW10amxESlJyNU8yY1FFQVlZdEhwTUpwZjJRZjVqUkdzRXlVZDQwK1BaV2F6?=
 =?utf-8?B?b0NUMHlSbktxVjNnTHpoS0kybEkyaXBGR0R3OWhkSWFiVWVGbUVQTmNVeWhX?=
 =?utf-8?B?VEtUTXNXUFd1NXFiSVd0VmFidHFhN3JIZW54eHc3RkdybHl6dVZZSGVBVWNl?=
 =?utf-8?B?VnExaDhtZ1haQnVFNUN2SXl0Nm51MlNoa1A0Rlp5QU5RUTF6V1NzRGlXdVhN?=
 =?utf-8?B?UFIrUVhEbjJ2cGhVeHBEOUl2bHY2bE5FNGNGaFBjbndiTCtBSG1Md25uUmd6?=
 =?utf-8?B?aWY1OGpIOHlrUFRlSUhtbGVTVkJYelRSaHFZWHV5MlY5akFwcG8vWlhKc09K?=
 =?utf-8?B?Qi9rN1E5TTlnN2NKNUM2YmhxajMwajc5dEw5b1Uzd3dUNW5zcjBlZE92TkRN?=
 =?utf-8?B?SDlXUTlxQjI5V2lLNDFmRmZZZXI0eGl2ZVVGWUJNbFdFTnpVQ0NQL0xabm90?=
 =?utf-8?B?bjlnVkNGQTd3NHBPeW5hekFqbVpERUFvTGpQWFVzQldxWXArS1Q4QnA2YTNH?=
 =?utf-8?B?L0QwQm5yTEFNTzNIVnBrYVBYaGxMSW1CY2NFSHdIWTc2MzBPUGFZZC9uaEts?=
 =?utf-8?B?NTFuM09McklNRGJhRFNaR1hjaXZjVXdnbExyYytNY3I5Y0dJM1BEOEx5VVdn?=
 =?utf-8?B?bUR6a3BOd1RGVVhodTJiaWlrbDBSdVhselFFMzRNTzAvMytjQXZwdERPazIw?=
 =?utf-8?B?WURTZlJWZU5YYXh6T0ZaNkZWRVo5cHpzMi9NMEFEUXdGN2VxbzROaG1wZGRG?=
 =?utf-8?B?L2Z5QkYyUHlaUXp3UWlhU1JYMFNZRkRQTk16dCtWTm1BNFVmK2JzUzRHd1pG?=
 =?utf-8?B?OHVXK1Y1WUZRK1d5WUlYYzBPVlRxNUlpWnRsSU1pTHBDZ1A1U1FRYlc5cnBL?=
 =?utf-8?B?eHZSNFNlWVU2YmViRkxHMjV5NndyWkpuanltWmtycFBOS2c2b1R4VUl2SitN?=
 =?utf-8?B?SnNyeFgweEpXRXI5dmpZYlBYMjZxbkVqN25ZZG5xa01jZ0UvVWxZVnBpZ0Vs?=
 =?utf-8?B?YTdGUjllTlZJYlVzYi9kOGtOSEM5OE9qckVRalBPWE1yZjhITXlsVklheU9s?=
 =?utf-8?B?MUt2UmQzQTVyajdTME9SN2RNR05JYWhiZ3kwcThDQ3M5bDZJOGM3NGhTK3M2?=
 =?utf-8?B?aVcreFQ1VXRrQ09YekYvMXdIKzNsZTQwZFRRZnVwdHlEbEJJbVVvT1NYOTI3?=
 =?utf-8?B?RmdnVEptMnM3TXAwdzhXeWR5UXNpVHc4UytxbXNVZUFMNml4SHpMQjlZclFO?=
 =?utf-8?B?VVdTOGJRYzFuelExUFJ3R2swQ0NzWDJHUEdnMUZ6b3hMV2hwYkd4SEszV0Jz?=
 =?utf-8?B?SlF1dUw2Z0xuOEpJeW1rTGJkTVFnUFNXaEVFTzVLNlZEek5HU3FURTQ5bHhK?=
 =?utf-8?B?eEc0Sm92VjZ4Q0FTQUxNWVRaTDFMUkkrclBDcXRVTXZJWXd1cnVGbW5jbVZR?=
 =?utf-8?Q?qYBpJBkRJMI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXhaZ2s5eHVoL01TMHFOWktEdURsUEZSY2NSR3MzQkgyOEJPbVUxSCtjY2F4?=
 =?utf-8?B?dE5lb2VIOVVtcGpvQTB0d3dxc3JOV1JCOXk5TDBwSEpYY29kaEJDUUs5d2p1?=
 =?utf-8?B?Ym9TTTVmTHI5eGluaW82UGRLZGZxc09SbWY2dG95emlWVWtURG1vamFBSHlO?=
 =?utf-8?B?RUJHNHErV0lLeldJZi9EWEdXam9NN2kvRXlReXcyWjJHWlhqeHV2bm5RYU1P?=
 =?utf-8?B?aXUwc1ZHbUNWaGp5U2pXL0dsQ1luQm1nWlJsVVBGUXlZcmMyQ3ZKdkJUTDdx?=
 =?utf-8?B?RjJqRmVUc2FZNnVidWgyL3g5RjNxV0lPekIvek8wUzEvcjBtTGRONHo1Tlli?=
 =?utf-8?B?Y09paDVpMnkrYkZPWWM0TG5ZakN6aTlYcGc5bVRIT0FOQ2FiK2FtK0w5ZG0v?=
 =?utf-8?B?S2NFckFSajRCcW9oNHFpSDFlTm8xd3JEeDRmOTJPOC9Db2hwdXUrcWZObG5T?=
 =?utf-8?B?MXJ1N0c4cTNTa0lIempBS280Z0NQL3JiY0YwVVNYSmowSEtDTlF1UlpMdEo4?=
 =?utf-8?B?YnhhbGxMeW9URFdHNnZiVXJJWjM1YWhXUVg1WUd4ZmJXSW1ZWjl0WXRSN1FR?=
 =?utf-8?B?NDhoeEVoQ3RoUkpYUlkvOERsY2puaUFSU1g1d1hUd1hBSzc3TGhVZ1ZGYVE3?=
 =?utf-8?B?ZE9GU29TZ2JUbm9IZHpNb3VPZFhWR3JBUVJuTFpSR3FEQm4yK3Fhbk5aNGNk?=
 =?utf-8?B?amtXanluUEc3YmZyeGIvRjJpU1ZWRE40SXpjZzdsamRQZHBvazJZNVR2VUxT?=
 =?utf-8?B?cU8xM0FrQUhUSGJ4VWdEZ29scGlpK21VUlgyT09rK3NNNGJvaXdPR1UrRFB6?=
 =?utf-8?B?bnpMdk1VbDRybHFlUkY0UlI5WUlPWXpvMlU1cnZzSU85Z1RKTGVhUUd2K0dO?=
 =?utf-8?B?TkdTU3ZIMUx4UlpLQjJFWTFmU2dZK3RGc1R6VHhoSDZTQkkrVXBEeGdqZ2dq?=
 =?utf-8?B?enFydThNVWVRYzE5OWJsZTVvTlJsTUwxNWxZa3RXa3E0MVlPSWdoV3k3Vjd5?=
 =?utf-8?B?TnRnclF6UDdrSEN2QVVKRjF0cmRYYmlNaFJEOVZaKy94aWVlVXR1Uk94TnpF?=
 =?utf-8?B?NlZ5b09Wc0p2VVN4L2htbEJCNEtadFdDem1JcG55VXJ5SG5HcU1MNVhCTFJL?=
 =?utf-8?B?T2NvSjNLQ0Y3czlxcjNneWJNUXR4MXducVFHS1U5WUxsTHRpejdPSlNVSDBz?=
 =?utf-8?B?bjBJaDI5L2plS0hPaGZKZngyeGVkTmlNTXVvV3VLYm1Xb2l1N2Jab2tUOU15?=
 =?utf-8?B?V1JUb0lOUTUySE8vQno3OWFWaElyNmNLT3JqMHRBaW9kRWQ4U1M3QlptQm9U?=
 =?utf-8?B?MFF6N2ZteHhRMFhldE1oK3NHSC9iSEl6L0hocW92UU9iWFJMdHBiSGdsTTYv?=
 =?utf-8?B?VWt6TGMzbGIvVGFXdFpmUWN2bXU5Q3ZkaHJCdkVmVzVwKzk1N2FZNHBlaWY3?=
 =?utf-8?B?QVErUVE4aHp0QjRqaTJMU29JMVFkM1ZKUEhlbFYrSVdnSktXdG9sbWd2K0tk?=
 =?utf-8?B?VE1Xakl6WUMyR3V6NTFDbUI5VXlhMmNrTDkvcCtYQSt2d3pkMTRqL3dkYkVO?=
 =?utf-8?B?UlpnOW82VXlITU94WkszeEswTGJOczI1SHlhaEFBMU16WHRkTUZYWTdOYmRC?=
 =?utf-8?B?SGhRTUxlUjJkamFhVjdURDdINnN1UndCanpDWkw1L2YvRGxScW53ZDZTY21W?=
 =?utf-8?B?UVl5Y1RWNFlZRm9SYlZLTDFEbGh2cDZEZW5XMHBSRWxQU0t6Y0VLTHQwaFZv?=
 =?utf-8?B?RTByQjB5dHNNYXQ5cWRLVS9YWnZBM2kzZDVnZXFnS1FXbWxKL3puaEZNcndT?=
 =?utf-8?B?dWhzYzJjZDBhUnA5TnZJc0lwTk1EOGdlcXBPUm5uNmM2dEFkUG9VTFU5VWx5?=
 =?utf-8?B?cmNLWE9zK2psYXJvR3pzMytuNFZrYS8zVklhTlVnd2dLbG83NjNWWVk5Tmt0?=
 =?utf-8?B?WmJRZ1FhbXZ4K3FYOVNuZEMzb0VlV0drTGtpa1AvWXpnUGc1WGdxNjhpWXJo?=
 =?utf-8?B?RDNwMlpEV2psUlhWRlZzZ1MyeUxMd2tRdzZuZzhUdnRtT2xyYWMvNFprZUJD?=
 =?utf-8?B?eFFjS3RWeTZiYnNyYVdKeDRqTGxhbXRiK212bEJqNHFEOWw3WHNtK0JiV3ox?=
 =?utf-8?B?UXc0WnZFRmg0dXlzS2sxSzl3VjZPS1JnNUdCdzFaL2dKS3ZTWFpkOCs1cFdZ?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HrQdgsAzabhwCv1hKXVaSO630MS12KoqmM03a7w3OHcc3HvU9n9s/E7q0WM1F7nyuwjysdlBRI+4hH4F7g0qCQW3bbID0/MRblxT1GXOTeT7y795aqyqtyIGRIc1+ue4+j+wwCK+A6fh4DC5ZXrOk/On1HUgqCrNHAAe0ldtyxyUHGCa8TjxYk2YBEWKw8z3gqqmu5KpTewE6PuqxaivnepcLcyBVdz19hVEXY0Im0v3Zk2xJGiRtZWN3vtAWRMbBnlx03X+TUxaPyml97Cd2WRExP8xNlvGnLfuklJsT+lKLGpma/mSRR2Gw9VBUytgapdwcr/5ydm+erbe/0PO3EPwUDQiXNykL++x6rIpxAA/qr7PG75Fg/sfdkHUlnzIMt1/fE8QnkNqaAPhzizFkFK7617MiN6JbWHDgDjFukJ7bURri3zBy943ZcKfqt8KXYe22Ew5LsmnsplfhR0PlN5VfklKLuFwNjbfPzUJhR+EGSqFJKI27CV1MCHLLgJrYLJ3wUmFU5IqESppQGQtXe5lw9Pes+37MmwH1XWDUlVX8w/PXwgMW5yaZLpPipocQZLyTjM010KdeQht67zocQR7AfN4+pFDm1dUsammOcM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5d3b6a-024d-4cf9-5366-08ddec9756c2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 16:14:49.8560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYuMyzbI6fdnzOiqovFxTECSb2HCcwWIMGp0JjhDO8IlBU9k4mYXlvCYRs8RzxjcFyeBvgkYwh1NorFmUWbfWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050159
X-Proofpoint-ORIG-GUID: KAagsdv8cGKcfwIcKS-9ddjO4MGcUzlH
X-Proofpoint-GUID: KAagsdv8cGKcfwIcKS-9ddjO4MGcUzlH
X-Authority-Analysis: v=2.4 cv=IpMecK/g c=1 sm=1 tr=0 ts=68bb0c7f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=aryvXked18Cq8tDMByMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDE1OSBTYWx0ZWRfX4xOHCWiHQb2e
 2zB5/+AU+a7VhNx4rK1xRaklz1PKv1zRlpzilX1lfR2NJuxC4XzbGySELTJzrYDfW7svPyh7ON5
 zRk/hNA0GLyOVGvoqe5BOwxk4kO8KoXnXuNFEeR0lNEwVDe1kuIgUZnDFElooUPSqdqjKNSOvlw
 v3gEJVJdGfcIPksfaek2BLIs/av9OkrznFQmS9UI7wHvYysJRkHV9xwDvXSWgt7KPVXQxlke2r7
 2UrKeoLX/panTdzVm/2m9Yvvk/OtaUUpwBGbN4Lfs7sujN3PWSlB2iUR6zE/9gXajUTz5I1lfG4
 cuY6bkNbaoafD1LOGdjeaibcEq+sDwUp+QBtfE8k1aoHwgWoNZAPgmP2J2dKTNa/nVLwLBJyc59
 zJpMyowI

On 05/09/2025 16:51, Ojaswin Mujoo wrote:
>> This requires the user to know the version which corresponds to the feature.
>> Is that how things are done for other such utilities and their versions vs
>> features?
> Hi John,
> 
> So there are not many such helpers but the 2 I could see were used this
> way:
> 
> tests/btrfs/284:
>     _require_btrfs_send_version 2
> 
> tests/nfs/001:
>     _require_test_nfs_version 4
> 
> So I though of keeping it this way.

What about the example of _require_xfs_io_command param, which checks if 
$param is supported?

We could have _require_fio_option atomics, which checks if a specific 
version is available which supports atomic? Or a more straightforward 
would be _require_fio_with_atomics.

Cheers


