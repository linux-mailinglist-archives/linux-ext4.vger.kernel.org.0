Return-Path: <linux-ext4+bounces-9841-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60343B4861B
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Sep 2025 09:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E19917A4F3D
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Sep 2025 07:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34CC2E62A4;
	Mon,  8 Sep 2025 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aD8jEp6W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pb2urpGZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B569221FD4;
	Mon,  8 Sep 2025 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318058; cv=fail; b=HGI0PrWn4yJOQR/g09aEhdMVxNwxn46OAjI85PYFEU+/j0VN1LFARXrCJXtCchcQ/rC2VI0PFVqFB+2TPHUjQHej/KEv+KFmFuIC6mqXp2GF1qH8oHD1AnlASPrgUHgxnkl6HNdrXnlSvm7SjJhfqD4qV5ixc8sSbW6nOxWCU6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318058; c=relaxed/simple;
	bh=oq1NqTCRBU4NFEpU234ziIi6D2yv5Fiu/vVz4StV4S8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nDeuwpV0WABAvFeO4xJaZjmWqPlzj1VYeUGJREWf9T9eFLOfKez4k0cPUjiugOwv6Xj4U2Zpz6O3wQpBNJU7x710GS5hTMb/zVnVZ2JIzGnQB9QO6JVtxF9/Jb/ZIun+lBNp0gygfcm6w0D9lEuy6UC4HSyYa5AKfayAd/8K5r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aD8jEp6W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pb2urpGZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5887cPJW005848;
	Mon, 8 Sep 2025 07:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oY/bzDth1OqvPiqbKNualandQwL/fG1eBsCh9VbILxg=; b=
	aD8jEp6WWWh70LMsn6SH0iBqJxtOT2NIqGhjbeiQw32OKZJ6BgFO5yCAoGW81G00
	MbKfPWkFhv+OyHq4GqnHRi21/B3LVxqn3Vn/gZ0SRwMxNmGJ2vgBt6FGqpLPHtvc
	V4Js7GMWREj6br6Y7uyfRW05tJ1UxWoyBdOujLjIri/zYqXMp7Fo6tqbrg02S790
	goSRE5zY69EcyJWZ2uNwShiHD1HHBNEK4MB7O88xVwnv2drj/ee3ep0Fu8I7RZkx
	BJXagE4ABfQX1U/tQYpsDzLGYP0XwOzdXLhoGpL/4XUbagdK+r9j105MXs3OdATY
	Z4rUXrTMz7iqsjulvbRs0w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491txb8118-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 07:54:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58877FPv025959;
	Mon, 8 Sep 2025 07:54:04 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd7udnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 07:54:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HE+kxqUC7F0zCNOxqGFy5ZRvH6LtOwiaD/JDu5pal6f4lHyiXwzTpPJ59zh1FlJvVUOuaC16/0apoW8ntI/+HRIM51k7Mk4KGPMc+9pmr7AO/LeoWQbqX1hUjnj+iO5xa76rc0GyXyY6STMmPhelIbmcmfr2Z7RA8uygJs8Purp68xYkGwj4b7SXk/GzR7zLwgrNa9mLoIk4/D3PaJfDmoQWgqqdNIJ1MTpC3QwbYM3Kxddke3M0B8XL15mRpGzRthn28/F5uYoSgzpzKspv01ByVGz8UlORfCBZtnR6QvsGH37HFVU84rDBG7GQuYPncT+xVDINsnQP1FKmOUfNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY/bzDth1OqvPiqbKNualandQwL/fG1eBsCh9VbILxg=;
 b=AkpbDHw9dFdJdrShcu1Lii3rY8YufSJnCRsS76s6QqKrFtr8Fg5LLR1/30k4658UY8Grn4ND8QR5Wc5kqdcXQLSXgvQo1WgO9HB4rCzh3/2F2BQZ3b702vF1lZ/D314FBde1TluBNexz9PgcoMeroLvURhQg2uMaIe+o0UadE6mLTD5DNvKXdQkvU7W8POWEsqdCL2zH34T88IK0jP9Rj7aIzqs/T1mr+qIBB7gMckKdKJ2P6dcMYt5Aggomi+b410Qetn4ln3Qk6pIc4BMZ6Es9uX3VJ8q1WEqbWGkECIwOEXIJl6xl4aHVtBl6RsLO1wFIytlS1jL/p3I9QEl/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY/bzDth1OqvPiqbKNualandQwL/fG1eBsCh9VbILxg=;
 b=pb2urpGZiNsnVVbmZAwZ+Wpq1Jc8II8d8hFda1j8t1aEaCwwhP4oVsadOgMi65/M0n8beeb/8KnL3HQHLzCsf/FTUgL5xkLHpkHfblpwyaA+asAsmSBEvIlZ8092afc8xUAXNLipnTme5PY5JQxO8u3CHFP4C9jR39EoQ+dCC7M=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS7PR10MB5119.namprd10.prod.outlook.com (2603:10b6:5:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 07:54:02 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 07:54:02 +0000
Message-ID: <448079fd-ac31-4a6e-99f8-9021c0a92476@oracle.com>
Date: Mon, 8 Sep 2025 08:53:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] ltp/fsx.c: Add atomic writes support to fsx
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <8b7e007fd87918a0c3976ca7d06c089ed9b0070c.1755849134.git.ojaswin@linux.ibm.com>
 <e2892851-5426-43d3-a25e-be9d9c7f860a@oracle.com>
 <aLsP6ROqLqhdbLZz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aLsP6ROqLqhdbLZz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0032.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::13) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS7PR10MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: aec5f6be-5306-4c2d-a476-08ddeeace022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zis1TXJ2THFNb2QydndiRS9xdHhLaHovdWVhSGIzRW1INC9yNnV5cUo1b2R0?=
 =?utf-8?B?RWpwdmtmaGtqdXMvcER5dTNyVXFGL2xIa1V0RCtZQmdWdU9qUXpMVFJiNUNo?=
 =?utf-8?B?emhPeEhCcHpUZkNlOEdKMk52WjU0dTlXWTVONitJNm15NHNqR0Fuc0I0THk1?=
 =?utf-8?B?VFk0OWd2Sy9jTFRKSkMvK3hNbCtwTU55c3U1YzhGSHVkMU5EbmJ6NUxldlQx?=
 =?utf-8?B?RXQ0L2FzcER0cW1RUU1tQ1d4TURpUjMxM01UMmE1YXF3cU8ybTM5WVkrZ09U?=
 =?utf-8?B?Tyt5VUV4ODdFQXRIN0h1b0g2ZkQ5enZyTURlT0FOSUp5MTFzc0xoZTlDdVEw?=
 =?utf-8?B?VytLSXBjWERCSjkvZ2dLcS9RQ0R1SjNiYkdDUlFDa25td2FldnUwZWgzMG9r?=
 =?utf-8?B?a1ZJU2ZYcTQ4VFRCVWVwdnN4Z1kyK2JhQlF3NWk2QldPb2JvQXIyK3VkWEwv?=
 =?utf-8?B?andHNDhZL0ZiT2hjS25QKzVCTlJiOHAvQVhBSjE1bjhSa2tzV1BpeC9NeGVC?=
 =?utf-8?B?M0RHNENKeDZ4ekpDVUNud3YxODJFVm51KzJiYWFXVWh0NGVqMk5DSjZJRkZX?=
 =?utf-8?B?eTZSSzJSZ1YxZXBoUURodVkzZk9kTDFna2hsNkVwK3FFelRHVGR4WldKejlN?=
 =?utf-8?B?SXA4T1JFbTJaTDJvckY1K3Z3TDh3TFpjKzIrenIxank5b0lydEsvcmVCeUVn?=
 =?utf-8?B?c0lTTHE1ZlZpeWhQQnBnZzZrM3hrTGJiejYyTUExNVZWUjB2Nmt5TitLL0ZX?=
 =?utf-8?B?WURsdldNRUU0VHVMOGJYdHJVY251NHFNK1h0ODhzdHhHd2FsSWJQeU5oMTZu?=
 =?utf-8?B?cEkvbWEvdUxwUlFKZ3hvSzllc0x5MlJ3dllhMmhkNGdTa29DMmxMTGEyRXY1?=
 =?utf-8?B?VCs5dHVmWDh1VGRSOTFiZWdHWElsUzBiZXFzVVlweUdxdXdkNFBxZFJVWlY5?=
 =?utf-8?B?QVNUbnBVK3N0QjJ4UU9ybzk5NEJMQXJhWUgwZkRlZkIxQWNLSHZ3bm92eVBB?=
 =?utf-8?B?SFNVOFowVks1YS9nTTdHUzNsWFVyNUloTWVtNzliczZXWm5DdTJsOTNKT3FZ?=
 =?utf-8?B?WXRPSk9RaUExZlZEamF1Y0FKOFIzakYwNUNNNU81alI0bitGNDZtOEZ2RmZR?=
 =?utf-8?B?bEhKZk90YnVRZmpvRFlmYldrTHNaS2FSSUJzUWovMm91VlpoS1BqTmFGY1Z5?=
 =?utf-8?B?K3F3NmNvY2lSSk8wSWhJNkN6Nkx1SWV2UnorL3BaOEdLK2tuZHJnbzR6V1lP?=
 =?utf-8?B?KzVXOUtLcGxOdi8wM0VhblBHSzJpMDBYMGc3S0FnRnM2RTRDejVWcldoRjAw?=
 =?utf-8?B?N2RkNC9RSU5nRk1SamFvNzROR3NHeVNidnVYZ3FYMmdqaGUwcWZXMmhFNkp2?=
 =?utf-8?B?WTFjNHhLWGUya3R4NjBpU2Rvc2k5VlpSa0pvNnl0elZGZGdvUWlvMUtyRkI4?=
 =?utf-8?B?VCtSUHdLak9LU0tpUEs1ZGNpT0VxQ0hLU012VEZ4T0FzVWlDb0ttVDliWlZn?=
 =?utf-8?B?aTh0TnZOWVc1aDV4d0tSa0U3V08xSWFJNkI1eFJUb2xRLzZhZzJrN2I3MGJp?=
 =?utf-8?B?c2JFNVJWbGJkOC9EUUhlK3RCVWE2SXdPQ3hFdFJZdkhaeUJ6SDVJYms1b1JI?=
 =?utf-8?B?SWUzT0d1UE4xamhyTFRZWGgzVnFxQlo5enI2cEticktKSUNhTFh1dlBmaDA5?=
 =?utf-8?B?Smd2SFJmWlNzcktMNEp4eDduR212VDB1c29za2V6STFYREN0RTNrOWo1UFZ2?=
 =?utf-8?B?VTNoa3dGT3Q0WHpPbkVRWm1lREVRTzF4TDdhWHZvQ1NJT1hpMmV0NS9LdDIx?=
 =?utf-8?B?bFgySjBqazlWUm5ZNDVSL21rUHpIS0dZeUp0RFZHSkhyQW5aN0pkTjR6aEk4?=
 =?utf-8?B?SW5qejRCTEtFRTRRUSsveG9HOU83RzVFMlZySk5pZXRSdU5zOGJCTzlmN0Ni?=
 =?utf-8?Q?rxwPgfmdNrw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUdRVHpLaU93S1pmdDc3NVJuVEhhMS9RQU9KYnJOUlNNckcwdldPMEVmV2J5?=
 =?utf-8?B?WjV3bXY5b0ZIS21GcWZDVjNoOWZtNk9FSFNTbFpZZ2JUWXdZMGRkRzZHMGlt?=
 =?utf-8?B?amFjQWNBMmsvWlkreWhXZ2tlK2JiaWE2M1RFME5ucG4yaExmSXlwR3UvWDgw?=
 =?utf-8?B?ZWswUnl4LzQrekZRYm1UQzE1RVNwbWNFUG8wWGdtL2k2RVNob3ViMnAxTUNm?=
 =?utf-8?B?VHNzWmpTNlFtdnk0SlBtSnFuTjM0NTRUcno3aTl6eU1WQ1ozTjNDb1lTMHZy?=
 =?utf-8?B?NURHY0hmZUZiUEpjZW0vaUQ0dkdubGxMZjNCUXNsSlFJVXE5WjJEbDhFSXdT?=
 =?utf-8?B?RkNEeUI3M2Vic25sdksveTA3Y0lmSFdYbjM2T0lQSU1aYlJtbmx3dndkZkx0?=
 =?utf-8?B?citnT0FXRUxYMWh6NlZpTjJoWkd4QUd6RHo2cDZwWndhQ2t6MGdEeUdZL1Q4?=
 =?utf-8?B?SGtNNjdBYWJFSWVsZWsxN2hTM1ZwL3Y3eThIWkJLUmRGTlJ3c1BncGJ6eFBL?=
 =?utf-8?B?S05TRHR6am9JMFJtWnI1WWhROU1ybjFSckNKMG9SdGpCWVY0akRSMDN2OTgr?=
 =?utf-8?B?TWxDTUw3c25NeDJhTTNkaHc4VW5TNkU2TitRcHpJT3RFRGVOWGUyMFk2MU1B?=
 =?utf-8?B?S0hlNks1cHRpd2diSCtDRUg5MEVFVDErZ2ZLNjVMczRSUkU1SG12OTJIV2JX?=
 =?utf-8?B?VDB5MkFMb0dLOFFxZlN3aExCYlVMbEQ0dVpGeCthVFhUVUJrTjNPMzBPbGVr?=
 =?utf-8?B?WWEwTWV0QjhidisrMVFKK2g5T05tSTdIRjVQb2hRYURSbHJzdWNjRktJOXps?=
 =?utf-8?B?dnlQSnk3dm9PSktwczFYOHpkS1dmY05lK1dPSWN1NmNKOEJuZmdicEg1djNE?=
 =?utf-8?B?d0xEd2g3Mms3aDZpRTJDY3ZJSGEzSXJCdlQrTE9nMW8vdXJzVlE5MCtzLzNI?=
 =?utf-8?B?S1lNc29LblFnSS9RbFlOcVJVVGpmZ3VHVHgwc3lvYzJocDRPQVpWcmd0b0lv?=
 =?utf-8?B?cFFmNVJXRFJkVlJSdjdjREFzMUIwTUJwaDJSTDcxRkczakRDMFZJRzVmS0Y4?=
 =?utf-8?B?b1RKWnFqaFJmODV5cHZkL1JTK05saEh2MVVrYTBDaTdYd3lJZEZ6YVBNdGdG?=
 =?utf-8?B?TCtuOEVzeGgrTHhOREVVbmpEWStPa2JXeXkwdVFwTlZXbTZZWnYzS0FBK2tL?=
 =?utf-8?B?d2k5QVpUdTk4bHp2aVdSU0VieHNValBTR0loMHpwbDJpd3NBdGZDQ2ZhUjRF?=
 =?utf-8?B?V0ZubXF6M0dTN3FIY3ZOcklvZFZJNHpDRzh1N3JsRGNQUDBOZFgwSU9WTFJ6?=
 =?utf-8?B?THBpS3p1YUlZeHduODV0SGxwWVNpZGRrSFJKSnhPRlU2dFRZTGV0eS9RRlRw?=
 =?utf-8?B?LzZNMzV3b0lGQjVTeUt1eWtON2dQNmlIZmZ2NjZGRDlMWFJnbUJtWnl5NU84?=
 =?utf-8?B?ZHo2clFuL3M0MGRNUHFOWnFIL3hJYnQ3UlhkZkQ0UDM3STRnYVJ5Sjc0V2t6?=
 =?utf-8?B?cmIxcU9WM0pRWXFMS1o3WjZlS1RuTkE1NGh1WDRnOVBTTjdUcUFUSHRJdWlV?=
 =?utf-8?B?T0Q2cHpIUWJSZHdNRkU4Y2xHeGlHZmJOakZJei9PWnlQVHU4czBLQmlGRXRQ?=
 =?utf-8?B?azNGeWxEZUw5SnhDaXNjdTJBTWlKanlVZ3pSOGx3YkRvc1FOU1lrL0xoWmNq?=
 =?utf-8?B?NjNWTlphTGJiZk5hWFk3dWZRNWtIT2dEVUhVaVdqdVEvWmdJT1BMUkphT2hp?=
 =?utf-8?B?eFIxV01nT0cxbTF0RlhCUDhQZ1NGR29XemI2c2w1Qm1ZaTNqUXg0N293YUZm?=
 =?utf-8?B?bjJBb0V6a1M0YVBZdVRVdWViMko2S3BIempLVmwyU3crMHpZaCtaaWNmOWVG?=
 =?utf-8?B?RllDNUwrZkMxSTZBd3RxWE1jbmhBTlI3S2JRUUVDREV2Q21yUVoxRzFLaitr?=
 =?utf-8?B?dmRobzV4QTFVajd0eHBLVE9hbmZGdkVnWmtJbGhBdUdvR1Z2bEhWdU9adCtB?=
 =?utf-8?B?QkFCUVBlU052MDQxZXQ0emp4Y0U4RnQ0MjRyRG01d2RmUEN2SEdjMmUwM0dN?=
 =?utf-8?B?anVzSERMb0o4OUJPbEVhdG9sQ284cWtVTmxmbnF4NTZxUHVyU1ZjazVOV1pv?=
 =?utf-8?Q?WbQ8CZNWx7iD32EGsbEW4F+Nb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9/agFJcig0OhgJTx6/wxOitFTPwZZPll9vw0A6yMKk/FDr98qxX6F2t9YVhSUc9JWBi1i2fSRFe0bFet4QfOkL8q90X0gD9bIfckhRtRvauDrC4ur0YOtz3DvSiYnUskdNqArZkvxt7Ah7/cWSEcYZ/FUcAEbxERBZ4Rab/9X/uEf5LckrxQS7C32MB/qwcYT7qclNmcfjE5Eb2DcetpnPAEpKvQpTMLPKrsT2dfhTOVbSAcrZoBR5fHyKhFNuTxRKcsaID8uig2LlSzkBHa2QBKNWxb/5VJ3h0qGWFOsc1O/wxLkrZcbN4XqwCdgrEPw05Spiv1eS1gqrLr73DbYnLLfV24ZWLXbs01mTfX91+QNRFE6NkktG9ldNme07OxWsYbgcUkT4EPBk/3K7UOeznQBPlpcRN37mEspmo8L6SdrWtqeY1j6/GCO2dkqmJ+pyYWfqYLG/LqrvvT853rTPhDXzTZ/C0Pp4UxZyQ6lIxTUYzwQw8wKTTNSbl54eu0W9isqPVhQB7+3hjAW41ut3bsjvKahhfP/rZ4x+8yqhpOmtsKwweuTZXk1p8qEG1JeWHU27RlG2xbaj+KRt2p4jCIpGQAvm7c0Tsh5dLTq54=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec5f6be-5306-4c2d-a476-08ddeeace022
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 07:54:02.0562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USJfp6JOLU6TQ5Wj/aSyYqasbIJHSOkWyKhDqTXrVKSz0s6PpAXfBT2CMWGYJ+5q6U1tDX4uwqYfoBNTFvHJfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=937
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080079
X-Proofpoint-GUID: 1PGLlXJGRTiZrAjPLvgQQ299t35P7BuN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA3NCBTYWx0ZWRfXw2bcr1v5fP0n
 kmRJgHJCpipeK+iH4rPMN7mNXKVShri4GZx8ZKGbzjEiDG/juWVcBDvfw6lI4GRV/uRXRSN7+42
 7GATQyHaF/lK4arc9gdSoL8RECg50AvxskLDwXW4+cnnxE50esjxHQ4qmeCZmr/0NRGN644CmUx
 53OBY6cK8OV070SrIcIvS6a2mbjc2MnF6ClVc/j5nOnMzURtc9GxpzzS6cC9EXd9HI+iCu7DW1f
 2RZUpmX5vlOrBpWxNzKRb3P7jdj2VEu1cUq9dAbnjsGfF4IMZc+xZGwHM2+M5r1IoLlPRQRYNLw
 9/N3CSRbrLxoVpnbN5qnf8Jxv2RRm4cdFQmXZsDlOmXD5xVXIIwbzf6jHl2Wobuk0nEWJS6AnVd
 iWQQviNilan+h/MfP+R5vB1q5M4Dsw==
X-Authority-Analysis: v=2.4 cv=Z8HsHGRA c=1 sm=1 tr=0 ts=68be8ba0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=wS-98QlKGl-D8LSDywEA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13602
X-Proofpoint-ORIG-GUID: 1PGLlXJGRTiZrAjPLvgQQ299t35P7BuN

On 05/09/2025 17:29, Ojaswin Mujoo wrote:
>>> +
>>> +/*
>>> + * Round down n to nearest power of 2.
>>> + * If n is already a power of 2, return n;
>>> + */
>>> +static int rounddown_pow_of_2(int n) {
>>> +	int i = 0;
>>> +
>>> +	if (is_power_of_2(n))
>>> +		return n;
>>> +
>>> +	for (; (1 << i) < n; i++);
>>> +
>>> +	return 1 << (i - 1);
>> Is this the neatest way to do this?
> Well it is a straigforward o(logn) way. Do you have something else in
> mind?

check what the kernel does is always a good place to start...

Thanks

