Return-Path: <linux-ext4+bounces-9863-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71012B4A6A1
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 11:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5731881671
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B73F277CA5;
	Tue,  9 Sep 2025 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hfpguPds";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nGxm0ht5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABDF24166D;
	Tue,  9 Sep 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408665; cv=fail; b=Qh1npoSmeQoroMy50ndAE8je2Q1WTEU/bqwvYTRmcqMFSIhaQHxCxtEXwONk1FMAexL2RmlvyES2+LxSZDOUPTQBbVTc3p0NgOnSEgc3Wo6z7d45D/0pxIZIlPZ3l0URxqMYoeMV5t+S4VW3HBU9nVmlG/Csj6WDbVZtZTgHx78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408665; c=relaxed/simple;
	bh=N6VPoRX8dlO+n1IAv/c1KL2CmJYaiXDfnOfFKPQFDYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lojoooQt9sBR0PlBev4quHVFtfRLOkI4Tz0BOx2Nt3N+vLAeDXzNYLQn1fUo6xH181ywQkD7N7yPioOE9Ul/ht5eYKWoltDonwIQlBAkmCBCCEJ8XVaTR2qrP233x1nB2K+xT/JJpqIYReV7SMxsiXSGuEfg+WdmU0tkdGWr22o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hfpguPds; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nGxm0ht5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897frpa031618;
	Tue, 9 Sep 2025 09:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6Rc9uEz6DRgAZC968bJRn32Ee/VdISmNBog73P9Iux4=; b=
	hfpguPds3pk78jG15stitZTNa+HC0OCp5Le3eWT9dJa1Dx9S+CRvz/VjvqrlO363
	2uCd9Sc3wcPXIAbn0SzXtbgqPdsMPsdubnn8c0TzkOU4MISdawTdqanfXhwXObIb
	bTuSIaF0tj4aV7NzcE77ujCjCEGIZoyprh51mS6Xf0Ia4nyYjLP1Fu7NIyWM1G1Z
	ts3cIraUvVdthYNUbKcG20L6jy2nErthwcc3lrS/Vb8miIrb6AAYAbY7qjXOzI2T
	YZTX/bRAIHG4dRXCy7bxLsavFHaNdm7ULqnh9rr2IvT59OVrCIU3RysiNp1UC0xv
	ih+ZhwNcRFLyDPS1JbvypA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2shp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 09:04:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58990BuB026041;
	Tue, 9 Sep 2025 09:04:15 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9bd9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 09:04:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzWvEkAxA2KhakgQiS5Vaju6TWxns+3dECM+bsg/hZW5yteXUSjBSIQiTTa2Rsp2ry9soIK6sm6cGJ1olG1GNB7g3voypkhp1Xnxvtrp3xMdDbuhxxH5RbWkL1PSg7HpAaMBVQUtyhm0SwgSPZSo/yG8ywndr2fAbxaNS2mJD4DWgSbbodQ1QuY1uk0hNa5j5fPVxmgTtebuZJtel/i6QoRi2132XCMAnuDAtRy5PDw+bdsnbC1sKjRYpx2JooSXx2sik0sTMapotWu5tbALycvqT09gy11lAUZokgEdltJepJ4i6GWYetKQScFvk5pOoUyXQFrotHHYNbCnxhjtbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Rc9uEz6DRgAZC968bJRn32Ee/VdISmNBog73P9Iux4=;
 b=Og31NhbkYsl3QgLIhqkum+q+vXvmxEQ0oUD5fVnNDm9DMP/zCwaOVBbbEeHIeZqFpPH3EBabrMayDgu0La/XVkY731IASy5vGBPHD+aARmligLRxWtUlHqdbIGmE9f3uQLhTJEbM/xdtgsX3rknUsO0Lf3C0VQGPZdN8g3idunad3q14HyLwFDUrXtEU6wJQKRtCJGz20/uvGpC57f4xViZcl8L6s1kgLgLn321bY/SokjGyhQ5SidFJ3jgxPKyyFYmXnxdPAfpuiOGrfcrcXBdBjj5VLnDEHPJCrjcwrhkn0ptiaHq8cJqfEqdVEFU+7Omz0TZpc5j7pxYBohTfHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Rc9uEz6DRgAZC968bJRn32Ee/VdISmNBog73P9Iux4=;
 b=nGxm0ht5cgOSBN/0fyO6cr8rv/Stf920h7eirDTJ71ncgdyqlikXrz3z9WQoiLnIUWPGycU6QPRjoWBRpvrbY35cFKBX1EjILlgSaO4d65rpp9W8cMC3eQooJP8vUyHwC6FVZrAyamti741T/3keT5ZSh/HrCJGduuGBwO2796Q=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH0PR10MB5194.namprd10.prod.outlook.com (2603:10b6:610:d9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 09:04:11 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 09:04:11 +0000
Message-ID: <d9ca22fb-f833-422d-8214-44117aecd68d@oracle.com>
Date: Tue, 9 Sep 2025 10:04:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] generic: Add sudden shutdown tests for multi
 block atomic writes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <2b523de842ada3ac7759cedae80485ae201d7e5d.1755849134.git.ojaswin@linux.ibm.com>
 <12281f45-c42f-4d1e-bcff-f14be46483a8@oracle.com>
 <aLsYj1tqEbH5RpAu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <674aa21b-4c47-4586-abdc-5198840fcea5@oracle.com>
 <aL_M0X9Ca8LgTIR1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <ab2ff75d-12b7-472b-897d-d929518e972a@oracle.com>
 <aL_s_noWRd3rw_6m@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aL_s_noWRd3rw_6m@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0209.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::16) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH0PR10MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: 339c2d5d-e171-4ae6-b50e-08ddef7fd7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXhSQVE3ejR5VkQ1MGRHTTdqOHM3aFBtR25CQ1JZRzJkdGF4MXZOMHVTRzhL?=
 =?utf-8?B?S3EzU3hrbzJ0eTZrU2J3MGFtU280Mmw0SG92VldKSWFlQzhwMkdTVWkxa1FY?=
 =?utf-8?B?K0VRaHlQWjFpaGtoZkdKc2tsaVRvNDZiY3BqNFdZUVlRbW5KZFlxYlNta0I2?=
 =?utf-8?B?SXRzS21DcDZtRWZPeUNvcCtDdWFFTzZEeTd0VjVmUk1kK1BTMGFhUzFOZm9X?=
 =?utf-8?B?YWdPeGlxT2RuMmtpQVVjOGR0V0xtWEhNakRLQTFFSzdQU1ZXM3oyZFpLdHVu?=
 =?utf-8?B?WEFiUnNxRkZ5TmE1TWFUdGhodnNvS3AxYTVESW5jeXNVU0FvUzlyTTN1cFVo?=
 =?utf-8?B?TkpaR0xGeHViNHFoQWJiTkVXTDh0TklDc1FQYmhHOVZ2ZGloeXI5N3RweURr?=
 =?utf-8?B?NDFBaE1PUW5VUjBwS2dybG4zNnVEakRzSzlqcE1DQzVkT1VIMTNNai9scnJ6?=
 =?utf-8?B?eFRGd21iTXpOeUVxajN0SlZvbUZ0WVBreStEVlphcUNsZHJzdjVMYm5tL2s5?=
 =?utf-8?B?UlhZWWZPSGdrL1VqZ3FJRWtMZE9ORVhOSXJlMTdGenVCZmJXSjdjQVFwL05D?=
 =?utf-8?B?dm9WbzdYS1NCa0psei82VGRPL1hzSjdPQ28rbjZIakE4cTYzaUQyWmw1d3ZN?=
 =?utf-8?B?Z0xsSEg5YUZzSDcwYzFWa3Q1VzFpVlBOVHJ1YUM4eEFWMGZBN0NOaFg2Vzh2?=
 =?utf-8?B?R05FWHJNU1hjWlhrS0hVRnRvZm11aHVNQUNrVnQvVEdWQzhMYi9EZVRQUDhY?=
 =?utf-8?B?d0RnL0hDdU1JVi9BMktFeksrMkJ5aXpDR3dmM2ErSWY1M3FSbktCRnE3bFRH?=
 =?utf-8?B?bm5yeHc0T3lLeE42eG92RHJ5dUJod2tjN2RmTU15ZWpLYmhSR3ZaZ2dvUmM4?=
 =?utf-8?B?SzE1NmJvN2d4QmF3UTVHUHc3WW1EOU0yZ3FqbFVpY05SQm9NKzBNSkJGTG5B?=
 =?utf-8?B?S0NJaFdvTkwweDJEalV0SHBEK1N0OEtKYXJVenh3aERvZkNSYnJHQUt1QU56?=
 =?utf-8?B?eHpObk8zbVRSQzVLV2R6b2MyWU4wbnhtM25PRHNrMFNBdXpWb3d0UnBnbjd4?=
 =?utf-8?B?bndjeGV1YnhUOEp2ZVJQSWRscEgxcWRsWXlwTlZwNGg0MDdDVFpQdTlZMWJw?=
 =?utf-8?B?Y2VNWmw1OWszc1J2bkZ5aEU3cERHMitJWjJPc2l2OWRSdlFXeGtLb1JJK0hF?=
 =?utf-8?B?SENSWWZSYlBrWkN6cG16NW5BUFE4Tk9WWjZndnFxRDZONzY5MDhOamM1MW5M?=
 =?utf-8?B?L1o2VmNNYTYycHErN3E4SVVkOUZyR0RlU3Nzd2xYaW5YMFpOeGNYbmgxTFo1?=
 =?utf-8?B?eW1MZjllSkNWUWtPV3cwWkIyYlYweTNONFo5VHR6S01hRjNZOURNZ05mL2kr?=
 =?utf-8?B?RHczL3VGeHRpdFZTNXRwSFY0ZXVDcHpNZXJCT2xyMi9KdUFkSGpVVkhZYXZx?=
 =?utf-8?B?SFExKzJyY0NLVC8xRWdxVUJWUUZPanZiajRLUDFyT2RkRGdvYUVUbGZFVS9m?=
 =?utf-8?B?VTd1TTdOQWJKWUpjelM1MDlxK1Y4dkJDVDA2UE5Zc3ZQMmpBRExDTWNmbTVl?=
 =?utf-8?B?SFA0bVJ5R0MyVzVsTzlhUGpPcFN1ZTJLaWZ0Wm5jR0pMZzV1bVBRa1I0Tmg3?=
 =?utf-8?B?ampvNHhwemlNMFRra0xjc3ZqdFRkcmQyUE53Zkl3NnhMSWlnMmJQYmlsTkhS?=
 =?utf-8?B?bkRheTYvT2ZuekR6WDlia3pOZGxCbnpVQW9tYnNIVXR4YmIvd1pRSFVPb2dX?=
 =?utf-8?B?alZIQVdUdmkzTWJXSml4U05NRE1BN0Q2TlFEK2VsWFVONVBxM2NZK0dxT0Nr?=
 =?utf-8?B?Ly9kOHFLTHM0MTdWZ0drWjFDUnJqWjFoWHhuU1RZUzRMa0FVNkxHQklXMWRP?=
 =?utf-8?B?WnJldGZzYmY4aVhvaTR5eGtuOHUwdjE1VGxkNFYzUnBGRlNPRGJMdEUwb1lw?=
 =?utf-8?Q?vFKT0OJ1Tz0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1diWUdFS2F0NlM4STI1dVZ4a08wMjBaRjZPV2Z3NWtNdjc5a0Q5bzlvcGYr?=
 =?utf-8?B?cThhZlh3NGkzbE83eWFKeUlBc1ZkYW5aNjhBUHgrYkdNVG1qOHVWWGZLZERE?=
 =?utf-8?B?Mk5uNGxYZmZFczEvNXhqZVZTZXZobnk0d1kwTUFKZURGNXYrTEJ2VEIva3Er?=
 =?utf-8?B?LzRLcDI1bnY3SmxYa0NzRCtNVkNFSjZOenEwM09HOXN0QU1hMmd6dUl2RHI1?=
 =?utf-8?B?ZXAvb05kSUV5MGVVa2dRYnd1OUZha1lLcU02TXB6bWxuSldYaDliV3pFdGpR?=
 =?utf-8?B?SDlKTm82bzJ3QjVISys1Y1QvekpIcVUvWEI2ZzVwTnExaHZ5NzBoRnZYZGxL?=
 =?utf-8?B?SjczYVJ2c0svNW9CZlVreGxiV1Y0bE16ejIvUUVCMklzYVhaSmVLK1hxdEQx?=
 =?utf-8?B?eDFSVXFNeStuWEg5amx2MDlxVW5OREh0Mmo1dWhyL0xMNUo3T1p2ZHZ2OW5N?=
 =?utf-8?B?UWRUVzVpQ3VzTjl6NkExRE95TENUSHgwOGIyUEhLQ21qV24xVnM2R1czNGhX?=
 =?utf-8?B?WWpXZWMxOHV4cy9GUERUT2UwTkhrdEMwbExaMFFZSGs5enZHbHllNHQvR2dQ?=
 =?utf-8?B?aFBHTTZURDJ6dW1PbmxIOU1ZTzVuUGRCUml0NWt2a29wcGY3cjlPY0doQ0VQ?=
 =?utf-8?B?cHpISmlqdjM2K05WKzV5WUNXNEcybFdsQjQxRmxTNEg1TVArVlRta1JqbjAw?=
 =?utf-8?B?QS9kd2tmZDY0SWRiNFRVdkxSSllPODltaUlDQk4zRm4wOGNLS1BISUFMSDR4?=
 =?utf-8?B?clNPZlRYay9UakV0Z0tBdTBDTVhQVHZpUllNMGFwcUIzQjg2L2pBQWxYbDE0?=
 =?utf-8?B?WURQbkY3eWdBUHBrZFBvT0tYTkR2Y2hBcEpaOXArdWl5R0NqSFNoQklwQTlh?=
 =?utf-8?B?NnpzRnRWcmZJdlY4NXdPeXNwVktPbU50Zlo2MWFQRnVWOHJmYVVHWVk5NHU1?=
 =?utf-8?B?Q3BWNHlMVWVKNWx6amt4N21aeEJLVU1hYUk4WjZPc0hmWjFVMTBIQkVLbG1C?=
 =?utf-8?B?QWdRTE1NMWt4Q1hreFpLSzdLcngzL0tlaVRoYk9tdWk2R1ZpaUpQdnJRd1Fu?=
 =?utf-8?B?MlRGRmorS2p3L0lWN0pUYlVIV3RCU1RXOWNzc0JpVlFIRXR1L1oxWmRsZUVy?=
 =?utf-8?B?S2VqTVVJdHdKU3N3bzFmV2w4a0RwVE5Vc2IyQ0hKV0lWTkk5eXU5N3hPTm1x?=
 =?utf-8?B?ZzV0dFdsZnJHS0ZJemdOQ0Z1bkZiSGI3UFZERXFMdDZSMGdxMFAwUnpEY1c1?=
 =?utf-8?B?T2s0T0EwQTRIM0U0b3dKK0RScXFwREYybTFDTzRicGd0WmIrbmNjU0sxVXo3?=
 =?utf-8?B?MkFYWlI2SGNCR1FRNUh5YS8yV3RBNzY4ZjZtUFg1WFBxc0lQaGs4dUt4RHNY?=
 =?utf-8?B?MjlGRnAxWCt2c3IzSzBFOXU3NmdzMEpqUmdGTHlLK28xMEUzNUhHbVFOeGZ5?=
 =?utf-8?B?Vm4rbjg0aUM0eThHelpZekN5ay8xVGNhdmVEQ1VaKzV4Vm5LbFF2Zk5taFov?=
 =?utf-8?B?MUI2NXRiSm9nd2d5RU1TMlF0UjFVQ0k2eEZVcTdVbGlDSEtLVGFEN3VIdTRI?=
 =?utf-8?B?Zm9TM0VheS9HT1dha2U3SGV1WS9ESWFxTW9ROWxYeHZLakNaUDBFTmYwWTBV?=
 =?utf-8?B?T0VkZityRGFHQkdUNURNNU5UZ2g3MXNCRnpjU3BrZ3FYVExVQytzamZraHky?=
 =?utf-8?B?QmxnZmMvbEFPdDVxRkx4d0hmTHFkdmZzT0QwME5mS1Fuekh3Q3pRVklKU3dl?=
 =?utf-8?B?RUNocmNqVmlWTHZKWmtlMjB1elVmR2hDZzBaUHBGRUdzNWNUbnMyWlAxSUVG?=
 =?utf-8?B?a3M1NllBQ04vb1pzMitQM2ZNajFzLzRUZGFoaXhUQUtQMlVEMVBrQkxaWGg4?=
 =?utf-8?B?bnovR3VLWGFBTGl5QnJ0OU0vME9IZUxKZFd3LzJhOXFVRjMvcGNabWZlN3ZI?=
 =?utf-8?B?a3krUlpCOForUTloV1l4TkNLUEVQSXR4K3h1cTFXRFh1WktQSzlXTDQ5MUdE?=
 =?utf-8?B?UVBmM1NqU2FDQmg5MjRwVllXK2hLcTZKUUxPNFBtWm1XQ2lJSFNBZVhCaFNn?=
 =?utf-8?B?a21PTkthN05XWGg0SEVyTng1VE01S2dYQ0d0RjdjcGJPRlZidjVlL2pZcWRW?=
 =?utf-8?B?NHhlNEtOYUs4Y0pNcExvaWc5ZTdtaDlsaUViUEZUdUtXMzBuTTNMSlBiMnlO?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3eTR5RRF0QT9SGm7lvZwCJ00deszNfmMjFYRyXMlO/eBOvQAKKhow0CsvLSf86vIyRammYBmPbyM/hwD5fx4WWWbd9i8G19e3oWwLV0Pm3OBs4B6JlmBbSza5mSYxtG1/KseRJ1UD7iS+6ilct/o0Y9aYz3fymOdtUnJbNBAm53WWPvSs1ETXu4P7dtJhLyqIQpD7R4N825sQ5vjFLJJUA9/1tT86c8vI16zPWh1fhfrtSa/nnetH2F0VE7MMvauke0c74+H55tsk38VhTfglSs/c8TYZNHDBZIYK6Q2MGhNjurxySgXpG5VSPa8yEXBFI2dneieUFjbI5fk9yEllMH1qlmu1USIrM1p6zr8rcEjumuYtCaNrLOHvJTyXIm+GAmVSUSfoUrCwpkRnDcGjh2Oh96TY/EfGqOakBN6SMR+Zw4dyNg3iugI5J6G7AnNdX+X1pYYNWb1yFo2IPqDknprdyGa29P3cOD10eAUeHz+HANnWTe9+tJcN4oorF5aRq7QZfuGKhfi7GVK8P1iFByZoIDfjAlsx9oth7LA96qPc1sHV988iznA03JKGMCoyfIC8yG2IYkH0WdQS/AUi/ResyfxwvLCp9DZtakDTL0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339c2d5d-e171-4ae6-b50e-08ddef7fd7bb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 09:04:11.7365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9d1rxtlEFtwv5aAIRJYB1ivby/wqvsp/l2o571LfyiXk7HdLiSJoLy/szRaR/lDtxVtSEGy3n1K0qBl1obNyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090089
X-Proofpoint-GUID: s4O4qSvPFCyiJcd-Xj281ijUjgd4qa2x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX6pAsGT9/OlXf
 mkYFFYs9y+OtOeryYzeoOjNbAYJnmx6AQm5bI61/AAcYfPKiLsnHGy1QPf09QbGlIPenOTf5KM1
 vODbnxWo/o/XFNdCGhjluPtyyqM2Dn3JvwNyRTBdn6aT1hs39YA4nl1bcNVXrIwB90LCpE1nOdt
 IxwEq0Or5hx1t+fyZtbRcVyGTu2S1/CVh3Fl8UyC301/+VV936sXbnM/WYQa9aJTWXiKKnV6E96
 YnRjiukLMTsnqBVtfOMbV/5cTJPR4ml0mT+nkYEvRqT8dxAokQG+vP6oMULwD8UY+wXVto0Nzee
 QHnJ/t2LTaJRLm1uI2V0sp+l8jXt/E3piVttlMmwinVyORcrMneHLDwLdMt1+uMpX+sXKZrfeJ4
 dQCBQUsoLmlmVjRMUSEmaE84y9nmhw==
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68bfed8f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=1YhPVNteCXYCGvVM6noA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13614
X-Proofpoint-ORIG-GUID: s4O4qSvPFCyiJcd-Xj281ijUjgd4qa2x

On 09/09/2025 10:01, Ojaswin Mujoo wrote:
>> you could mention "shutdown" also in the print.
> Umm, do you mean something like:
> 
>   "Starting shutdown data integrity tests ..."

yes :)

