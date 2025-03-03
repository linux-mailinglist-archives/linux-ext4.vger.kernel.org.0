Return-Path: <linux-ext4+bounces-6638-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DE9A4BAD2
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Mar 2025 10:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593B8170B7A
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Mar 2025 09:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18A81F0E3A;
	Mon,  3 Mar 2025 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KnGzRbNt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ruGOmBax"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042391D63C0;
	Mon,  3 Mar 2025 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994269; cv=fail; b=fMIDJGxzD2TRy9FJMGYeXFkdMWmS2Z2gRZ/TszjqMJbFs6wiGKUnndZ+EHsNfDVUkm7EXA4EtMDaIHYa0f4zrKtEwoYCoEAxi0k1NVQ3sADy8FnQBRgm9X+calVkr3x9wDR+56YW2n4rbz/EeZNnsUIWeXNA1Fw0NrvpSXCkT7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994269; c=relaxed/simple;
	bh=WRGECXftuqXppEr0/87LlhFZn9Oyz4C0dSXrGeMYyzw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rtC9dsoyNTZWsHkpT9C/5Fa+TNcdvUUTuFPxgzrFJ8ZP13YL1kARsD26+bX1+Fj5L+3rUYUV16itJ5kudxu5uMGoCR4bXs38s41fThdKPPiKC0558NZYwkzFYdJX3fiQiwsVa5F8a2EC8rMjIE0/nUvIFFUy2uialIvTl10AUDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KnGzRbNt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ruGOmBax; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tj1s031366;
	Mon, 3 Mar 2025 09:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=sQJ5yRTejVdpe8NDd5z6chCgHAk63FRhxazz4Lb4lh4=; b=
	KnGzRbNtzpu2QddyKU1As0MnPyiFRevdJjMtGRmBsW8X4AoG4/SMaG0VkH1ujKMD
	jpdIFxTCowuImZK4hIa39C9ow+1PKNJXlIP1J5T1Miq4F1wRGRc3Um2xu8y3rlKM
	H/iz0VWNZ6awZYTgnHnDc/MsGWDX4vBWadK9Lp0UZpznScS7K+4+t7tvo1jc+DsX
	6N40Jmu1mR/HG0j28TeIJyVtMgJDqgjGi8cI8ekNxvsQzYpkWjjkK1558A3YHzKv
	lZqYcfr+5UyvXGmY7ehvyDoS6t1ffrQ+NaTKJPiFJom16vR5KUng2DikrmsN7UlF
	PCvo8vv0lovEB3Z9QVnslg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u81t7ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 09:30:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5239ITdi003202;
	Mon, 3 Mar 2025 09:30:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp7873u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 09:30:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4mia61jJ4axwNSxKHfJfdmy8T+/ZoTsQBKyBeF/6nGPdnbGd9WdeZXoD43OIIjvxC6nymP+cZ46R3+UE12LXU4zrZZwNPtzne/7lX1oHcRfij2YqYn5Yp79Amo2rlPihEj/bQAbG40nrl3izAA4MDswndUQKbrPyindIB++3m4+gRH6GY8Zp1m6sgznD+SXKBFkzKOjFCGX0M1Zs3BRbVrbwOap+YYjUxMQ1/hCHLrXNf00+opUAYVXYzLxZ0ciyUFf6MLmpVuSfSIxtRHlqoVAqOjw8O5HoqqfXw1G/Ib/znk48Mfw3Lkg7F8pemYlkRmwpOOEPuOhabDC8iJv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQJ5yRTejVdpe8NDd5z6chCgHAk63FRhxazz4Lb4lh4=;
 b=Yw6Jvkx34/AfmTUsN6H4ZDu0VH9jGsUEMj/8UdYvh47bTN7uQkNhEN0jNz9izY7YeiSOkvJl44ln9vXYewH1DJxodUevm8q8sThsxeMgULgbPxGtb24MR3x8mHwQeuH/TirAF4yeUoSm7NVL52Vh/3GtznT+KPN//SVW5AhMFXjjXEBBPlT9mGg8EMyqQW+PuZDl6lHqWz7csULQBxlrQgP+T6LbMWu+ymJnDb5NbLeuC3ppmLqrXCb3vgdnsjwt9A15KEuB/jEcKfO3vkH/flTtidlEmvrk0nqTRU5XPf2RP+c3a6gujnq07K8VzCGPt5yU8LD+h6GY3UKtcYRGGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQJ5yRTejVdpe8NDd5z6chCgHAk63FRhxazz4Lb4lh4=;
 b=ruGOmBaxmqwBLs0DXHKAh+weQqPhBxbp7sdiQLKgRFt9dBeXNpSSpXIVyQETX0H8xKZ8wdKgPzPnjeYw1DmPidhnsioVqf9jYL5hIbpc667cYnY3j24svVGqTdA6hMDKxWSVXIFnLzgJiQwpE1IiD2lJhdvOkXcdeqdBL6PYlqM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5147.namprd10.prod.outlook.com (2603:10b6:610:c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Mon, 3 Mar
 2025 09:30:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:30:45 +0000
Message-ID: <859a6401-b06a-4b8c-aaa9-ea977f9c2674@oracle.com>
Date: Mon, 3 Mar 2025 17:30:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/5] check,common/config: Add support for central fsconfig
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
        fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
References: <cover.1736496620.git.nirjhar.roy.lists@gmail.com>
 <9a6764237b900f40e563d8dee2853f1430245b74.1736496620.git.nirjhar.roy.lists@gmail.com>
 <4c951390-400a-48ce-824c-f075a37496a9@oracle.com> <87mse4hd5i.fsf@gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <87mse4hd5i.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5147:EE_
X-MS-Office365-Filtering-Correlation-Id: a55d1869-b0ec-49c1-f524-08dd5a361312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFE5d3QwTENTajVLcU9tbEZleEh1QTI1ODFwSWRZcTZFeCs4bjBiZjNNdHFv?=
 =?utf-8?B?OEFFekxuZHhQQW51cnU1cHRVcmRUeVZzY2lDTEZndXdnYkd0L0tKNURRNHJp?=
 =?utf-8?B?NEEzNTkrWWlJRlY4bFBmUlA1YWRFQUF6bVI4cm1hWnhUdEcrT1A4ZGpubE5G?=
 =?utf-8?B?WFBtWFJXT041MlhaUitzWHBOUUdmVjVKWU0rcTRqb3Z1aDlBYUtiSFZmWlVC?=
 =?utf-8?B?N3B3d2cxRW4ycW1hZ1ZSRmcrOTNtVUl0QVhUaVpWYXB2dFdUcTFwbXJnUkVl?=
 =?utf-8?B?TVN5bDFEYmFwM1JGakxlcnhNRHdvQTM1MnRqVzBtNHVlbmQyWmtJRDVsQ2Vh?=
 =?utf-8?B?OVQxNE91VHlDbHRWU0xtNHRrcC9QUUxKQ2FVbHdaK2JmcXQxWGtUeGE5M0lm?=
 =?utf-8?B?dFVZUmRFWFJsODB6V0l5RllBeDN3MkRMY0UzNUNXUTZ6WE40NGQzeHNkMEpU?=
 =?utf-8?B?SThsamRjWjNKem1jd1FrZ2QwTDZrSFIwRzR6VmNCRU1CQkFPT2dGNUZGaEsv?=
 =?utf-8?B?WnV3RDV6M2QrL0V1b0ZzV24rNFVnSWJUM3YyRTlwWDMrZ0xjMVVFMWlncURZ?=
 =?utf-8?B?ZUdra0g2dUg1MGtuSXJmaGpzcXBVMkdmL01BYXlHK0ZmODdmYlhtUDhJL0Mw?=
 =?utf-8?B?NTh0a1RRblhLS2VpNzFQVHZ1RUN0b0Vudjl4VXpJMFk4UFQ2N1BNN3dVNkY3?=
 =?utf-8?B?NWhaZmZQbGptN0t4NHpZcHhkWURvWGhibmJ0OUhDTHVPMVJnMVRXY090SjhQ?=
 =?utf-8?B?TzgzNmpUOXUzZzR2Mmc5MHBVMGFDUTFXZzFDZUZwUGhqMHdBejlmWFFlNng0?=
 =?utf-8?B?K3NHNUM0N2VoRG9JeWZlaXlobDl6UTB4U1h5Y1J3N1ZXdHpEYytvQ3h2eWdO?=
 =?utf-8?B?blk3UjZUMzZabTAvUExwWGR0cHpWSndXNDNoOGNEY2lrL0pxK1ZubkZsWlpN?=
 =?utf-8?B?NXdIdzVWbHhXd3NIYlRxOHVHeTFKdFBpcG9qRDc5aFhGSnJzbU15MldPcGth?=
 =?utf-8?B?cndQZHRMZzRuNFFSVzNiYXVKY0FNSGZlZklDdFlVaTBmZUZ3UGd5Uis1dWRq?=
 =?utf-8?B?SWVZQ1gydCtrai9ZdzJ3YWlyU2NJOU5CQXdXS3ZTN3lLNTNGaDVSTHliVUxn?=
 =?utf-8?B?L2FrQkoxYlExcG54eFlUeGhTdktaMStzd1UwZjhnRi9EZE92c1VQY0Y5R1Jj?=
 =?utf-8?B?NVRhL3NydHpKbm1aYUpFVCtlUmRmUytqb0E2NXlKY1dLZzNqaHhheDZxSUNa?=
 =?utf-8?B?YzRwczZQY2R6V2JBdHQrYlZYTldRZVFiNUJUWjJOekVsdzhXWVpWZ0tRaTAy?=
 =?utf-8?B?SlFmemdRYUVyR2JzRHZ3eCs2VVg3REdOUFBVYlk4cS8rUjl6cnorTG5ydjVR?=
 =?utf-8?B?L3ZRZ0lETEJMNVd0eURrUlNOMU5lTUFqN29IL2doT01mS2pqRW8xRW10STFu?=
 =?utf-8?B?MnRxdGM4SkVrakpkTThjbTU3SDZzbnQ0M1I3WjZ0eG1OYTlnUEVUTDlxZFYy?=
 =?utf-8?B?dHdpUmZSUVBKWElMeHJkV0tzSmt3aEp1T0VGUDNCV0ZrazR6QXgyZEtyMnYy?=
 =?utf-8?B?Q2JSdUJiSVRlSHlHSk5WVXkvdlN3SUwvdms4S3dTSkZhdmhudmVQa3U1M2VH?=
 =?utf-8?B?ZXdMTzlNbFJVK1FPSWxCNDFPd1FDam9MTzhJSk1rRHUyNDNVTXFqK1JCMlV6?=
 =?utf-8?B?ayt0YVZzSVR6dlFnZHNUSW4vV0ZnbTZOL28yQUkzRFdDTDhrREJyUTJyajE1?=
 =?utf-8?B?d1grd0s4elkzQXp0TEx6SVZKZEVINkFSOHl3YzZ0UEZxS0FjMFp4bklZSTlj?=
 =?utf-8?B?SU9yWUg1UUxhc0FEd0MwU1ZjbXR2U0RMRnFqYWE0ekg5MExwZW0wNWFPYytz?=
 =?utf-8?B?VFhtanB0cGxaSnQvRmphdWZIZzhrRGxveTlyci9CYll2aXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekFDV0hIWXRCeE1XNTdYdDVPTGp1RmNaNzJKeDNFaFBSYkphR0pLT0duWlVO?=
 =?utf-8?B?MkhKRkgxTWw2KzVSWlNqQzg0cGZDSXQycW14V2VEa05MYkNxL1JVMXgzYnpW?=
 =?utf-8?B?R09obVBJeE4yT1dZbXJuaFJsV0JuZXdrUFJvUStaYjRWTlJveXFUelhsUkNJ?=
 =?utf-8?B?MFFhSkFsd093Zk5zNUlyWDc2OGFCTzhIOGZ0N2s0a002RHNRb2llS0k5SXNn?=
 =?utf-8?B?emVlYysyU3hwYk9IZUZCZEh1MWtSNEtXdWlkcGlPMExkUDZydXFXbDVUS3BM?=
 =?utf-8?B?TytabjVUZ2VtR1I3NXhqd0doc3V1SmxWd1lDWFpjaHd6eTRELzVEdGdmNEl0?=
 =?utf-8?B?ai9YWG1kZ3l3UWhGR2RQVktYTVVXb1RhMjlhdC9nT1d2SktRWktrcUlQSGNK?=
 =?utf-8?B?SlpReEQzSGdwc1NmeVdyL1Vhc0hsRUZHSC9TVmxXMS91ZnJDNWsrZERMR2lX?=
 =?utf-8?B?QXI2d2RlR2pJSHAzYUtPLy9pZHB2ZlVkTWlrNE5ta2V0WjVYeGhKeUNmdGlt?=
 =?utf-8?B?WEFmTWFqTHBodFc2WnlIdkJkWXNtejlwNXM5Q1VWRUlRV0tURXVocmJBc044?=
 =?utf-8?B?aEZtRXRlYzN5YWxPWHEwWVhrdUQzeGlqUkNFb3o3eDZaMk1DdzdHOTFpWU16?=
 =?utf-8?B?c0NBOGlMT3p3TTdUNzlQZ2FzaGlUaXhMTGh4bUdvUjJMcUlsME9OcXFOYkM5?=
 =?utf-8?B?cDE5MW1qVWx5YzlxdkpTNmdkZnpwQStDc0pPWGxLSVNoa2o2a0U4TEExWlRk?=
 =?utf-8?B?dVVOZFIyUFVJZ0ZEQVlWcTZSRUpDY1YzWWsxV1craG1oWU9ZZHRVN1FtZDVB?=
 =?utf-8?B?c3laM0w0ZFlza0xrYXBFLzgyZ2NiMjR2c1ZpYXRCN1lVbVhIRVJXdGgvREoz?=
 =?utf-8?B?RHR3KzhZU2JNQlpCbFBvTUR5NjBVWGE5UkxkTlVhMEt2cUY0VmRScnVXSEw5?=
 =?utf-8?B?NkRZTUI1MGljem5LalVTU1pkQUJZVEp3UTVkVXdJekxPSnRVVHhEUENGaGE1?=
 =?utf-8?B?alEvVEJKaVFwRURFZlk2VVVOcHpRbS9KOVpzSDJ0RVc4UjVDNGdkdWwxS1NO?=
 =?utf-8?B?ZkluMnU0Nys3Z3ZnWXhqT1VCV2J6TEVDTXFKU1lpYm94M2lIbGxtMVRqNUdJ?=
 =?utf-8?B?a0E4ZDQ5MXlYUVREUjY2Q0VVdUlTamIvTkRMQnFTQWZZb092Tk1keDQxcGhx?=
 =?utf-8?B?VTcrQ1JCdk40Ym43UW1tYnV6SGVGN3psZDdKdTJFK29KNlNwZVdXdFBzbmNl?=
 =?utf-8?B?WVYrd0ZMS2NLWENyY01EQ3lMbnY1bVNDV3lSOHcrZkwwZm5lOGVweVJValRT?=
 =?utf-8?B?byt0UTlVQTdtUC9pZmN3WmtPRkg1SVBJR3ZyUXErSlVDbklYbTByRkZyUkp6?=
 =?utf-8?B?UXpha28weDlqbnRkK0VPOUdBczgxRHRHY1pQV2dqYlVEejRYNXVibE1GdDFt?=
 =?utf-8?B?VVZSU2djTVN1QTBOc1JsUHoyTHNsRDdTUGtod0ZvUm1DbjBhQWp1MDNmcmtq?=
 =?utf-8?B?Q2Q5djNIZVVveVdiZXZwNkpXRTdqQ0hJQ1NmeFJzUGdXczNjakxsM2ZGa283?=
 =?utf-8?B?RjZaTGhnV2JVOEYrbGJZVWI4M0R3cVNEOGJzY1NLWllXYUcrZlhDbzA3SldY?=
 =?utf-8?B?U21lMGQxZ0hweHFIRE9jTndXM2RWQWh3blo2Z3ZLaFZoRk1sbWZ1ZU12RmxO?=
 =?utf-8?B?VGJ3Z3ZETzJoMjNtV0tEbWhZNk5ZaUVkOHpYVG52cVVZU2k3RnBJNk1tckp1?=
 =?utf-8?B?MUNqbnZjby81cWc2VkRqZEwrYXZyNGFlVTFZUEhnQy9kVU4reGNvZStLMkRW?=
 =?utf-8?B?VC9hT0tJbFArMnhldnZKd3p6eGhuanBmdUN2VnYwVUxLMVpBYlg5cDh1aks5?=
 =?utf-8?B?UC9lSmMvK3AyTy9SYlg2Q0dBMUZObXR2b2lIS3YxdXFJb1Q4Q2ZDWnBXb2JQ?=
 =?utf-8?B?UGxQSDFWblRGTCtLRUk0QkNNUSt5QXpaUUtoNjZKUmJiSC94VjEwTEVaR3Nj?=
 =?utf-8?B?QWNmWEMvOW01dmRmUVhDamlDOUpIUGNaWlI4SE9hUWJLcUtTRGdkVEhEVytU?=
 =?utf-8?B?Ry9ULzVtQ29mRFRJRW5IbGFLNG5JZWdjUWU5aVg5ZkpuK2lHcGcvUUN0TlZn?=
 =?utf-8?Q?gf9WpE57cl7+t/ssc8DEjx3Rf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zWLMWK1BqQHBM0fmScQ0nEWVXzd/ag3Slh6XKEQMV95VqdSmp45orWlmVlTMOyPZ+IBFoR/DUaEZqdM+nR5meLbp4dpqr3ym12pP7F6JDUtp0+XlSWwucyjNxuteV61OiOx4yhnM+DguyOIwjIA+c4un2zMSfWDSzsPVfPHLjeDSC7GdPhm7VbcLz4hs1phV4Io0FEkp+0u12flpmBkgR7oqCH8gKF/C4LJH8dCTBrhgz+iBGXWmTVP+3P/BHuU7/eB+YHK1+Yw82WynnLR0UcYUi5CafBwPsgt2ub9N3M38QnkM6MgpUgAbdXexLhVIlPLN0q44jcP7JWrKbSpg4KHzP/ribNfEXsqquJTPQTb4ni6usK9nrIj1dOmPMnWvd5k6ebhJZsSGvlMMP3ewj99uWbvCCQzYB8b73ENuDofNwC+dOJS9lkj6vT54Qcb81f4o7zKWnfOFaC50axREVku13Uu+OxGqvWWW8YFFqH/pVbWugyhIkN+U1f/nqpZvjWpmn6QsgWnWXLVNosuSoOa8duAwmyW2FeAzHWkHLewq4Kx6xxmKHUnUHaGzoX/klWT53arok5wf0gCO8PUWAEM81Cny1aHBVg6Ah27jwfw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55d1869-b0ec-49c1-f524-08dd5a361312
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:30:45.4450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcM+2n2BGaf/zo6cTdoVYFX7TmESyyWioAkgaDfS56vwGBdgPVfRcKnXLpIj9L/peFMO4TNKQzsA/5RjDOiycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_03,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030072
X-Proofpoint-GUID: IIJxbUaR4lZ_vIS7YDOSTavCY3PZmfsF
X-Proofpoint-ORIG-GUID: IIJxbUaR4lZ_vIS7YDOSTavCY3PZmfsF



On 2/3/25 01:30, Ritesh Harjani (IBM) wrote:
> Anand Jain <anand.jain@oracle.com> writes:
> 
>> On 10/1/25 17:10, Nirjhar Roy (IBM) wrote:
>>> This adds support to pick and use any existing FS config from
>>> configs/<fstype>/<config>. e.g.
>>>
>>> configs/xfs/1k
>>> configs/xfs/4k
>>> configs/ext4/4k
>>> configs/ext4/64k
>>>
>>> This should help us maintain and test different fs test
>>> configurations from a central place. We also hope that
>>> this will be useful for both developers and testers to
>>> look into what is being actively maintained and tested
>>> by FS Maintainers.
>>>
>>> When we will have fsconfigs set, then will be another subdirectory created
>>> in results/<section>. For example let's look at the following:
>>>
>>> The directory tree structure on running
>>> sudo ./check -q 2 -R xunit-quiet -c xfs/4k,configs/xfs/1k selftest/001 selftest/007
>>>
>>
>>
>> The -c option check makes sense to me. Is it possible to get this
>> feature implemented first while the -q option is still under discussion?
> 
> Hi Anand,
> 
> Thanks for trying the patches. The design of -c option is still under
> discussion [1]. But it will be helpful if you could help us understand
> your reasons for finding -c option useful :)
> 

Reason is exactly same as you mentioned and I copied it here:

---
1. Testers and other FS developers can know what is being actively
tested and maintained by FS Maintainers.
---

> [1]: https://lore.kernel.org/linux-fsdevel/Z55RXUKB5O5l8QjM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com/
> 
>>
>> That said, I have a suggestion for the -c option—
>>    Global config variables should be overridden by file system-specific
>> config files.
>>
>> For example, if configs/localhost.config contains:
>>
>> MKFS_OPTIONS="--sectorsize 64K"
>>
>> but configs/<fstype>/some_config sets:
>>
>> MKFS_OPTIONS=""
>>
>> then the value from configs/<fstype>/some_config should take priority.
>>
>> I ran some tests with btrfs, and I don’t see this behavior happening yet.
> 
> I think that was intentional. I guess the reasoning was, we don't want to
> break use cases for folks who still wanted to use local.config file
> option.
>

Ok.

> However, in the new proposed design [2] we are thinking of having 1
> large config per filesystem. e.g. configs/btrfs/config.btrfs which will
> define all of the relevant sections e.g. btrfs_4k, btrfs_64k, ...  Then
> on invokking "make", it will generate a single large fs config file i.e.
> configs/.all-sections-configs which will club all filesystems section
> configs together.
>
> Now when someone invokes check script with different -s options, it will
> first look into local.config file, if local.config not found, then it
> will look into configs/.all-sections-configs to get the relevant section
> defines.
> 
> This hopefully should address all the other concerns which were raised
> on the current central fs config design.
> 
> [2]: https://lore.kernel.org/linux-fsdevel/87plj0hp7e.fsf@gmail.com/
> 


I think it’s making things a bit more complicated than needed.

True. We’d probably be better off with one big config file.
No need for <fstype> directories under configs.
configs/<fstype>.config should work just fine.
I’m not fond of the need to run make; it seems excessive.

The way to run it is simple and works well:

  $ ./check -c configs/btrfs.config
  $ ./check -c configs/btrfs.config -s <section1> ...
  $ ./check -c configs/btrfs.config -S <exclude-section1> ...

These steps already work fine:

  $ cp configs/btrfs.config configs/$(hostname).config
  $ ./check -s <section> ..

(Patch containing configs/btrfs.config is already in the ML).

Also, a --dry-run option to check the config before running would
be super helpful.

Thanks, Anand

> -ritesh
> 
>>
>> Thanks, Anand


