Return-Path: <linux-ext4+bounces-9362-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F0AB24B56
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 15:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3053AD98D
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70372EB5B4;
	Wed, 13 Aug 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Faq3LAOv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UoNxcyis"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B780411CA0;
	Wed, 13 Aug 2025 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093260; cv=fail; b=HGNd9ps9y4Su2NFcLeaKq+uRRqfEloYnXwN1mKRSvuHBmGX3TaxwpLP6E0dOIIpew/qZSXOUBesnnE1f8D97VKY9N3IeFK9IQ/irURiFocdK3yDFnSjg+yDjD4gyy6id2dvqhsEWT+hKb/yWeVHIDlDUcGPi6CN4RWzM37M9zbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093260; c=relaxed/simple;
	bh=GCUgfhOsAqWr+WO3GwtsQ1m1rbHtvEn/c17SHoHHDWs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i1JgdpRW47YgKbxCWEbhM3eJymnBQWGw+UITk9PYHXo3/9zbktegYCwnDfZ7Xmxr3j28K81nMr2NJEhp9XOcVWDkgTag/5lTL1jk71A7LvsuRhvBwPaoETii0S//MLaleF3Mv5137vsqpkasq29Y/vhMbxXU6/s0lbSiyhnCGsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Faq3LAOv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UoNxcyis; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDNZdg028099;
	Wed, 13 Aug 2025 13:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=B2LaN29PPa9dOiyA7XaJb3BypXzrBuEfPnVERlF9OR8=; b=
	Faq3LAOvXLK+I0LGplOvA4pIgyClA0iLATdyXLmaHOQ78qbwovvtnYxLjArXsqEx
	A8whoPc6c3lYDIh+dYm2qGIyKPOuh9hSx/camkwNQh5kckk5e4riJBf+QgdfjmBi
	/uL3y0Hf/PQFWKkfzHOjXmmhYSw5DuflFSfPGjsiXRBWwnT6vMtstM7F3vtzC5++
	JCna0cO26YbBk1+u6D++qyONfX4O9LBuKp2IzW2UdWuCjTc73hM8ZLH6t/BpXX6b
	pYKnKxSQ45a4Kb9BclGRvmZ+G76oda8/JFJJkpx5hWhUbAcQ94z63sRth7FlbKPB
	B/7EJPvmRLmgnM/nToUlUg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf7pe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 13:54:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DCflnR006444;
	Wed, 13 Aug 2025 13:54:11 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsb88k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 13:54:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwXezkgKMiTilFqlSfTmsT9naU+uJvD+XhS2rQiedsUJ/06kI7rghxOu1r9iBFZPxGB0i5FJbYZpHvxaaf2wU+Doh0cjoX7OTj//tqiuM93ttnY6XrERWCHVOA8FBoJhyZSLAcQpaZWqe/eSOwlzInRVBqR6Mayin9zUMzEHb8UfEKiiqtVWgiu9WFstZUea/JGK9rJKfIjhS2mJ37PxIyFqRwYDQpQuUcd2FK8fyFzgBZWzCjC4h0qpPigdUsAqO/qB0SjKSv5IPCXrbshjCc7c0PILW1svl/8wwsBqnhT+gEcxbBUMRB0Rp/VoH/WucKVxbhfhHE5jogBtZc96Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2LaN29PPa9dOiyA7XaJb3BypXzrBuEfPnVERlF9OR8=;
 b=xcg4Os2q4ZwsGsaHu8cooVw8G6cvG0iveiJ3HwkH+2nqb+NSH9JzSds+5bch6hE3XbXbB3BeVmIocewKLdDqBaClJX5uY97BmMoDM4FQIEzF/ZVu2j7c4xHaC7bQv/mAadWcGWirwjnqGgzNuxC4aCiAp0iLKm1Wpa9Z20jrWcxrAq1EOwpZhO4BQvJy/8sQthFdepTZ8L1ucwO3OKBpJTiX7+qUeEVwQRWTm01f6RCVqEKX49RWgSuAH85evEbSXH7qeCsJi8RC/FeqwECgVprPTvVBlbz+kyKytojJ1iIvRqy63Vw8QJjYSkONMu3EeHM7VzdxsSI58xT5U77QIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2LaN29PPa9dOiyA7XaJb3BypXzrBuEfPnVERlF9OR8=;
 b=UoNxcyis5un//QYFntuvak5DEN+UAE8dghMtbax/21O9JAvi/eL7iMuIzx8i2M5GData/tNT+zAkr5Stn7so04dfi7PiCYTfryuCtxbDAIKk9cq/vptuzw9gBZLEaP7zvhnWkVcloUi4FyJvklOW1YuIBuSnXOUnJVnhPt7hAOM=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SA6PR10MB8037.namprd10.prod.outlook.com (2603:10b6:806:442::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 13:54:08 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 13:54:07 +0000
Message-ID: <0eb2703b-a862-4a40-b271-6b8bb27b4ad4@oracle.com>
Date: Wed, 13 Aug 2025 14:54:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] ext4: Atomic write test for extent split across
 leaf nodes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <2c241ea2ede39914d29aa59cd06acfc951aed160.1754833177.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <2c241ea2ede39914d29aa59cd06acfc951aed160.1754833177.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0243.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::7) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SA6PR10MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: c70a84aa-9791-4d04-f04f-08ddda70df1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXBXcEV0UDZDd1dqaTlPWlVvVlFXYVRNNVRwWVl5dkRYdVIwMkdOUHo2R1Fz?=
 =?utf-8?B?ay96S1l2cjdvL3lrT3ZMYWR3MmJTb3pGbU1QRGp2SEkvcDRCcS8xV1Z6M0gv?=
 =?utf-8?B?K3BLVXVzL0pDeHZUdGJWQ2FUN2pxZ2txcTlBMXVvSmlNajJWWVY1THV3bEg3?=
 =?utf-8?B?eGJDM3U0VGs2djhTcS9UU0tOWVJIbDFBa2h4bDdRcUx5Q1BNbXRsLzVsUWQw?=
 =?utf-8?B?Q3kzK0t3Qm5zVHhWU2JlalNlWjJlN2g3end5V0p6TlNOMGF4a1A3bTJlNW5j?=
 =?utf-8?B?TWpsV3R6cDdMbjNYdkV2b0hISnZZRTJvM25ZUjU5SGUvZ1VSTS9NSWdySDlO?=
 =?utf-8?B?Wi82dWw4QVdFbHN6dlprelIxY2hseVRJbjFtMHQ1K3kwWlNGbTUrOWZEQkZx?=
 =?utf-8?B?dWtXUElESHJEY2d4clE1U0tvRUpYWGhrdVNDT0hqblZlQzdXN2F4NmpFb2xJ?=
 =?utf-8?B?QWE1aTY1TkxmTlFKL3VONHoxSWNxdG1lTTA1YjFrbU5jdlFNbVdHZzB6MWNJ?=
 =?utf-8?B?WXJsOExxYTN5eXpVV2xiMWtsY2RBN2dPaWwwODltWlpENS9mdlFDMUx4aGhK?=
 =?utf-8?B?cmJKQ0xnRjR5TDFBazlrQTYrKzY4UWQzaEVtUGFGaEw4VFVjM3llditJZnBY?=
 =?utf-8?B?TDBhcVVoK0RhQ0tBUFlaTTE1aVJYRE5ld21MWVFkZjNmYTNaQTJmVjA1eU1J?=
 =?utf-8?B?QzhrNmk0VGZpNFZSSmR0NnRkNkZLYjMzekhVRnNEZHhJWExSMzByc0RXaFho?=
 =?utf-8?B?YWlsVUlGRDRYT3ZNWFRFVWE4MkxmUVV6S2RpOG5xS1FWcGNzY1BQcjlnbFoz?=
 =?utf-8?B?S045N0gyK0RDOU5aaks1aHZJR3dVaGQ2bUp4ejFmcTh3dThKVUtuZkprR1VR?=
 =?utf-8?B?ZGFweHJmY1czR0swNXFIK2FKMm1COTJzRWxVdlZOdEFZTDI0KytUWmp1WE5D?=
 =?utf-8?B?VUNsMktWYUxGZ0RLZjliVU5nWmJjTnBmbmVoRG1XSmkwOWpZWU12aHRXanc0?=
 =?utf-8?B?a0wrRVR2VmJ3UmRkdkdaUlJsVm15SjhFSGJ0N0RReEhtNkc1aHUyTVhDVEFK?=
 =?utf-8?B?eEliOUY4RGZnN3VxYTZ4WGtXaEdQSGtzRE0yWjhVOEx2R1lycjNyR3Jta3Ra?=
 =?utf-8?B?b21TZU1hYTlmMkt1VDA4b3dObVZRc0tzVGNCZXVUUGhiSzBWcXY0aldpVy9H?=
 =?utf-8?B?bTZzZUV5NVIvMmVHY0Ivc3RBU3BEdGwvdWxNZEY2QTdkKzBQRVpZNDJ5U0h0?=
 =?utf-8?B?NEJMMTZ5U0ZOaURiaXVLTjlyVEphZVdBaDVOUHFqYlpTWVA3S0t3dXE1N0lS?=
 =?utf-8?B?STdDcExHbGw0azNHT1R5eHhzZ1ZKTWxTR0hnQWQrMzEzZ2laS0RWVEtwQTZN?=
 =?utf-8?B?NEtDb0NrcTlXQWFrQ3pKNUhFWW05S2RvRnVPb1p2Z09aSUpNQnlpTndrelFV?=
 =?utf-8?B?RS9HcHphcUFWdWl3cnhwY2U2NG5UaU84QVIwd0hlZGx5WnliMzBQQW45Mjk2?=
 =?utf-8?B?TkZyUzFOSWVKeHA3aWcwbzd5c1UrRWs2UDJMcFB5d3RTWUZXdW10cVNveTdC?=
 =?utf-8?B?eDI1YVZJN0ZMdHBtUW5hVk4wbkJyVlAvRU9JaEVyOTZhMUo2RDhtQjBLa2hB?=
 =?utf-8?B?TnFreDY5K00xbjNmSHZoWStSRTVjZ3BhVkRUZGVpVEhwbkd3MHhVOTVVMCtW?=
 =?utf-8?B?NGtlcVdDOUttKzRMOG1ZTytwUlhJZG5rNW53aGJHL1UybTdhNW5MeGpxRVVm?=
 =?utf-8?B?MEtYUS9hRXNnVTBwbS9kTUVjaUs5Ty95UEl5R0t1eVFWREcwcW04aGxsZEdu?=
 =?utf-8?B?eXVibDNKWlRiOEh5VmpYUlZRUmE4QTRLWTdwcmV1T29wcnVNNG1CMEltME40?=
 =?utf-8?B?am9GajE2ZG4wY2x3Z1R2RUJtOW9mSklJMGxhOWtyN0VQQko1WUNkbFI0dGhJ?=
 =?utf-8?Q?hr+tkT6p678=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE1PYjFVdElqK0JaRmgzTXd1K1o5TUE0em0yaVdNdHJJTkZwcmVYM05HVmlQ?=
 =?utf-8?B?Q1FyWEtpdDVkaDVkeUhqL0VGdUhsOXluUDJLdjYxRUFNK1htNzNKRGRJaTdZ?=
 =?utf-8?B?Vjk3cmd5cVFnNENNdWp5RXlmMVNETXh6RTIwYlZZRE8xOExSZUFIT0gwYmFa?=
 =?utf-8?B?eVV0WnJDSGxYVzFldXZNaU5YZzI0c0w2ZURKZmRGYWdSQ25ic3JRdllYOXdP?=
 =?utf-8?B?RGxpREhtajR2eGJuOWVMdFZDR0xOTzBQa1lkbWYzQTdLdUh1VTB0c1dUQjl5?=
 =?utf-8?B?am9BNHprdTVNVVo1VWFFdHNQbHpVK20xeCtHS1V0NkpxOHZaVHI2c3FtZjdl?=
 =?utf-8?B?Q2NtMWFwa1VjQ2g5a3FZb0dTaStweU9maHNXWmFCWUN2cXJxN25mUkRZOHNj?=
 =?utf-8?B?bmsyL2FwTmtQSVM1RnVoQitlR3FMbmo1bXlER3JwWGVyeXB6ZWxhOXJvSGMz?=
 =?utf-8?B?MmIwTERocThUVkQvMXVEU1hacDhWQXJMNlBHdEFvWnBBVVFsb2NiTzQ4bHI2?=
 =?utf-8?B?eUdJWG9FbmpxYTJhU2tIMmxScHZncVdtNlpNeDl1LzBWYVRFanE4dVNMMUZx?=
 =?utf-8?B?UFlHa0YvMjQ2MVcrbnlUL2VqdUZUampCdHpKWXJ4TEhiU3hROFl1V2VHOSsw?=
 =?utf-8?B?S3JiOVN1K05JZGVwTG5ubHJadjVoMnBkK0w5MThjaEJHemFxaUo4dFdpSWUv?=
 =?utf-8?B?V3FjVmtDWEI2Ri9JbUVDaks1Ny9pY0lUZDRDZnphbTR2NWc3ZWM0V3F0WTdC?=
 =?utf-8?B?Mi9VbCtSL1VRdlVEL2M3SmJ3ekxlM1JVaHZjMzBPRzBoVExiTFFuZUU0Wmp1?=
 =?utf-8?B?V1oyR3EwREJiVzJ2a3ZRVjk4cHNkZTlYUGN2V3Z1bmN2ZWJFdk9qc3lGZzEz?=
 =?utf-8?B?SXk4Uis3N1Uvc3QyK09VWDJRTkM0djNSMDlSdm9SdU05LzZNekwrNDZFeE51?=
 =?utf-8?B?M2E0QTREU0dZc2N4bWd2bVhoNUR4MEdnS3E5bUUzQzVmRkRMQmw2eVl2UUVi?=
 =?utf-8?B?ZnVQcFNVeVdZSzFiQk8yTHVXV1V2QTIxQlNJYkpZUGpuY2lKUGZRUGtKMnR2?=
 =?utf-8?B?SzMvWFZsclVHSGYyVERxMDh1NFJsYW1Hcm1zQVJ6YlVWT2JXZ2Z0M1JSd2lH?=
 =?utf-8?B?VENQNUZQOGF4OGJsaVYrUm9EL0xHdjg4RytFRk53dUtsODQ4QlhyaXdhbHov?=
 =?utf-8?B?RlhJL3B4dTJva1FDWjdNSlE1ZFJVS3RPdUlSbGNHcm51MDRGVk52MFZ5M1NJ?=
 =?utf-8?B?U0o2TjZPUXpaZ0VuQ1FMQnJZTGEvbzZ1OXh5T3EzWEdWT0VOS2VHWDdCNjBR?=
 =?utf-8?B?YlZpbVJQRE9Xb016RzM5QVJ6emNUcEt2RFN3SkVKQmRrQ28zUnNHRi81bEt3?=
 =?utf-8?B?RTIxbzBEODllTUNRdGVDT0hnanVBUlVEc2ZyYjZleTBzWjF4UkZ1NmJOM2dP?=
 =?utf-8?B?R0pvK1p5TFg2c0xSbmdVN2J3SGV5aGtsQzNDWit6RC8rM1QwNEpmSE9yNmwx?=
 =?utf-8?B?WDlrZUlySFFJNjQzSkR4RmxNWnFJeXFJUHFZTTM4RmdGeUQvYW5DMFlucUFC?=
 =?utf-8?B?dU0yRG5Lank1ZUR6emJ4dXdYb2p2Y1Frc3Vuakd0TEo0ZTBZdWhHVTcxMnls?=
 =?utf-8?B?WWowWjZqY3lyTzJVN0N5VGtIZFpLOEZmSHc2emV3Y0ErWVNhazZ3cnNSczlo?=
 =?utf-8?B?dnYrM08rMnVBZVgxallzbkFxWTJ0QVJIQTZsMlZ5bEpseXRvMG5rMG5QWFpi?=
 =?utf-8?B?UWhGRTM1aDdOQ3Vod2RUUEFwL25XS0I0ZkJ4dmNXSW9iN1dHcFlWY1dZU0FK?=
 =?utf-8?B?WkVleHJlQytNdUp5d1dHUXdjaXVqdmZtbFRwWUplRXBXVmZyaldrNnowbjlC?=
 =?utf-8?B?bGxzdWJZNjEzZitxUXMrYmJ2Z0RxMVczaFlRREptaEFjNDY4Z3lxNzJRVUtq?=
 =?utf-8?B?RnNWdDFiaVBvVEFnN2xaQVJBQzYwVFpDV2N2M3RKUElZRlBHRFpUOVRXYjNv?=
 =?utf-8?B?ekNVVU8renF4cTBtMmQrRUdNcHRkbXVkSExMQTRHNVdLYm5jWFpad3hzSWJJ?=
 =?utf-8?B?dzN4ZHZaaHY4eDV3V0xVc0NSVVljSU9tQW5hcEdhbkJBQ3VGaHRoQzJyT3lI?=
 =?utf-8?B?by9HcjFFc3o4U2NTM2RoMGtoV1QxZnFaVlRmNVdvalZSY0ZNWU1hWEZBeTdC?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Kunq6ZOdL3prdnnVyvh86a8BgnQtlsVg8KUQsx5d9gUPzQSS39TkRNafZsg71Z9IxDziuKia2sL32mDLT/pthiOch6Y87YafMmuNtWd6s5tIZFoc98phH4fd7TxnQFfoQoZ77KVJjH+R6uLpcbyWJGq9PGweL1mmnDTf+4O9Ldmpb46QkrwbpTpbfmvEYLombNhW9As8sJVcyn66LJEE4Pv865UOciJexxwXkOddUKkHONaPpJWVSFY0CPBQ1gZxGrCs002Qq6IvdHzw3mUVRD/Rwb6zLSfOeskFYFNNGgtlCSMaVv5YZngUi8mCZKDEKHE/7Ag5D2D/NHvPtGvcd9J3kHyHHTS+TsYb4Z+DDUXO6Ye9qqB8sz70PqZW5feZBKOBQy1SB4PvL+DJh/WVnz+caN9JprfDwKwa9Cx8Rzfba2Ma/A7mFKanNzw1sWy68KaKgB3upz/8Iye2xsZrPSiXlc6AD2ud/5IZaTTcgXbAUSaPzTkyPbO/BQwDWCbh70LYReuJZ+rVjhHamiXan5mDGEDGcizooIcULWEQPCjznfYBlrzI1IDvLgAvnYmVHjLKn2Jw//JMtS4HpEsHFIKeALK3W0yRrvgYumMIem8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70a84aa-9791-4d04-f04f-08ddda70df1e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 13:54:07.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hllGB9kGpVqBzuIdUywCSEKNpgSZndcscbuYxiQ05F9ynkqNiFfiVXX7joNnANH6A1Oth1+qoMBQ6Idhskacuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130131
X-Proofpoint-GUID: PMiGoaz-PkEdtqVfqVtxy2bz1vB2BprJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDEzMCBTYWx0ZWRfXx1hkBNz5ZOsb
 KRjhcY7ek6lBzZB21bk5mCcG91BQDsQ06Df+snJLa33kPek9xRawh2y5N2YDE5P81GfsH4GbnXN
 zi7a6Vr92aCpORhpfN5Viwt5tPlruiJZPmq83b1YEt8Anh0OTl4uPDnlfdotxhRwKHdHA2XRAtv
 9H2n5aXgtAgSTTRlp6pjyP5X6S+4E5tiLzektMKL/tmwNhM/i8FIdgZXR70exNTYlYPnjkgwkAw
 vz/qBsYL8yyZvZhIBusbu9QvPUMg31MaJavrhxTddmWGtmW+M7gJpa3cAZ1FF/wMUqaCJLlC26Q
 C6BPcxGq0KntnaOMlFay2dSGCaj4rWbARIBuWJN+MNI2yxUefUNQnw8/6J86IADGskjbEmqVqjJ
 0lp1Psbq24B7MyrHvYRRr5CgWuiJQQDLOKdr4Dl7QBOV1iJo85cFIqWKveeTBoIIfDymBgdA
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689c9903 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VnNF1IyMAAAA:8 a=6x4JHBQk2u1HZFSGlzQA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: PMiGoaz-PkEdtqVfqVtxy2bz1vB2BprJ

On 10/08/2025 14:42, Ojaswin Mujoo wrote:
> In ext4, even if an allocated range is physically and logically
> contiguous, it can still be split into 2 extents. This is because ext4
> does not merge extents across leaf nodes. This is an issue for atomic
> writes since even for a continuous extent the map block could (in rare
> cases) return a shorter map, hence tearning the write. This test creates
> such a file and ensures that the atomic write handles this case
> correctly
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>   tests/ext4/063     | 129 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/ext4/063.out |   2 +
>   2 files changed, 131 insertions(+)
>   create mode 100755 tests/ext4/063
>   create mode 100644 tests/ext4/063.out
> 
> diff --git a/tests/ext4/063 b/tests/ext4/063
> new file mode 100755
> index 00000000..40867acb
> --- /dev/null
> +++ b/tests/ext4/063
> @@ -0,0 +1,129 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# In ext4, even if an allocated range is physically and logically contiguous,
> +# it can still be split into 2 extents. 

Nit: I assume that you mean "2 or more extents"

> +# This is because ext4 does not merge
> +# extents across leaf nodes. This is an issue for atomic writes since even for
> +# a continuous extent the map block could (in rare cases) return a shorter map,
> +# hence tearning the write. This test creates such a file and ensures that the

tearing

> +# atomic write handles this case correctly
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +_begin_fstest auto atomicwrites
> +
> +_require_scratch_write_atomic_multi_fsblock
> +_require_atomic_write_test_commands
> +_require_command "$DEBUGFS_PROG" debugfs
> +
> +prep() {
> +	local bs=`_get_block_size $SCRATCH_MNT`
> +	local ex_hdr_bytes=12
> +	local ex_entry_bytes=12
> +	local entries_per_blk=$(( (bs - ex_hdr_bytes) / ex_entry_bytes ))
> +
> +	# fill the extent tree leaf with bs len extents at alternate offsets.
> +	# The tree should look as follows
> +	#
> +	#                    +---------+---------+
> +	#                    | index 1 | index 2 |
> +	#                    +-----+---+-----+---+
> +	#                   +------+         +-----------+
> +	#                   |                            |
> +	#      +-------+-------+---+---------+     +-----+----+
> +	#      | ex 1  | ex 2  |   |  ex n   |     |  ex n+1  |
> +	#      | off:0 | off:2 |...| off:678 |     |  off:680 |
> +	#      | len:1 | len:1 |   |  len:1  |     |   len:1  |
> +	#      +-------+-------+---+---------+     +----------+
> +	#
> +	for i in $(seq 0 $entries_per_blk)
> +	do
> +		$XFS_IO_PROG -fc "pwrite -b $bs $((i * 2 * bs)) $bs" $testfile > /dev/null
> +	done
> +	sync $testfile
> +
> +	echo >> $seqres.full
> +	echo "Create file with extents spanning 2 leaves. Extents:">> $seqres.full
> +	echo "...">> $seqres.full
> +	$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full
> +
> +	# Now try to insert a new extent ex(new) between ex(n) and ex(n+1).
> +	# Since this is a new FS the allocator would find continuous blocks
> +	# such that ex(n) ex(new) ex(n+1) are physically(and logically)
> +	# contiguous. However, since we dont merge extents across leaf we will

don't

> +	# end up with a tree as:
> +	#
> +	#                    +---------+---------+
> +	#                    | index 1 | index 2 |
> +	#                    +-----+---+-----+---+
> +	#                   +------+         +------------+
> +	#                   |                             |
> +	#      +-------+-------+---+---------+     +------+-----------+
> +	#      | ex 1  | ex 2  |   |  ex n   |     |  ex n+1 (merged) |
> +	#      | off:0 | off:2 |...| off:678 |     |      off:679     |
> +	#      | len:1 | len:1 |   |  len:1  |     |      len:2       |
> +	#      +-------+-------+---+---------+     +------------------+
> +	#
> +	echo >> $seqres.full
> +	torn_ex_offset=$((((entries_per_blk * 2) - 1) * bs))
> +	$XFS_IO_PROG -c "pwrite $torn_ex_offset $bs" $testfile >> /dev/null
> +	sync $testfile
> +
> +	echo >> $seqres.full
> +	echo "Perform 1 block write at $torn_ex_offset to create torn extent. Extents:">> $seqres.full
> +	echo "...">> $seqres.full
> +	$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full
> +
> +	_scratch_cycle_mount
> +}
> +

Out of curiosity, for such a file with split extents, what would 
filefrag output look like? An example would be nice.

Thanks,
John

