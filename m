Return-Path: <linux-ext4+bounces-9361-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE03AB24B03
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 15:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A6A177319
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35BE2EAB8D;
	Wed, 13 Aug 2025 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gTB/8HUp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oB5aQHNK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1EA2A8C1;
	Wed, 13 Aug 2025 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092744; cv=fail; b=Ca6vyVWqschDhwCitRboETqcVxHCMdPF8xSe5X2588mxoUbBVGjSeInTzC5UTJEW7jgHEBMUB3e3Zj62ODZjJ8oq7fvb19zxxgFBEDZarIxmcq8doI7aeumoJxRYXKONjIAKuFejdce/Ju5qECw9R/yiWzvzaVlkt8p2BH0QLeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092744; c=relaxed/simple;
	bh=xhibW54MbZ6XUrPEQJMvngHmsOZ/1nkAbrW9/zRacEI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uTfNEYPrL0OTVxLghdh9F+3k771vjM8GEoSQ+UkwQYXoy+0kS7bJ8MJlYIDSXX5hwSaoXgfmUu1RkDT66D3/f9NuotIBgpjbmn6W6Wnz+hDyvz9v9CFwvcdVqU6XOu9TvlbN3lIXVZQd8I31V+jQG0HeqAk+lb3ynZ1FYRb9e28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gTB/8HUp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oB5aQHNK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDNcIe002637;
	Wed, 13 Aug 2025 13:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bf1Rbysz3yknpxQmSBAVLDfvjaaJBeOs6k5ESDuJ6+0=; b=
	gTB/8HUpRhDIpejjimoRhupcaIGEckeGHLUim54B8a2kD339/8y+BlbU3GyqZ53r
	f3hSgFgo4Fwfu4zshc7UnLe1ndl/bqGcqUGnPbJaGgAXEy5b5Yf6/3/QuSi4gtPJ
	nvXpzR4lD8AhOYLFodv4mmY+aAnVqr/tq2X+k142h6JOEPfOWOKMArAUmNBTrL8O
	LnW2MCE5wuiKsMuFeH1u+iDOmIz+bn0QVkvHSYWsGEAuZNDvS2G8a2++aaMnIua4
	9e/ZX0KolDBNo2i+zGFx+eWmJwemSx025EJMZQqRUCG5VWP+KdkdbO3g1BHgOaZV
	PTHKcyCw3Faq33bjJ1wDIA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dqf7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 13:45:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDgWMZ006485;
	Wed, 13 Aug 2025 13:45:33 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010026.outbound.protection.outlook.com [40.93.198.26])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsb7xbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 13:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpK/16bFEIr43rpukfZzPzyqtX5XH0F/IF0KXlrp3H8gjH7uHLR1u0fPzxr271R950+0mi7V5om+TKwz2DWAAMBifhXjUXC1ahIfn7AGpY+6JVCUsKAVMkCA6jQSEZcaM+a/EGy//tyXUWkc5quZzkSENwbi6o88jNkFiyUGeHrJhQZKEzLPxfy8LXaMff+ZYsU06PbSxMHciybLcAh84g8U85SEu+CDwlShQw33mym93udwe8331bIARzfW1dHa4nI52Vmf34QkqoqcXgzN+Rs0nlEsiqOlyYyt5v9hCFjqdCHWv8HluOGGy6tCQTcEtDnE2Ck2OFNc2XU0X8Lxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf1Rbysz3yknpxQmSBAVLDfvjaaJBeOs6k5ESDuJ6+0=;
 b=kMAsiGrGqrCsUjN9CARygeCC2WupwWWsDHO3ECg5HLRJSb0Oc7XOn4mDGJmLexQCe5TeMCGWE5DgCqBF/2G/6K7tF7QEU2UNwKruKvtr/LwI/1G287E/jobJ9tyUpAf0jsHTgSsi3a+C7S5bbt4f3JQB60ez7FaczXERPgUHla5aDbi/dx8pZbUXaOJZryCGOU8pnfORoR4goqhWd1xJ0JeHT1PFIMeRVjtiX0cLN+WbtCzkvjetsdqOz7Uh/vIV4whRkWS0FsDLJn2AckDO8IKUqmwCcGYw7pzxrZxCjxYYHl/PU2DV7m5qOWSZnSLhrkffpcypOQGQ8HDvNuDAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf1Rbysz3yknpxQmSBAVLDfvjaaJBeOs6k5ESDuJ6+0=;
 b=oB5aQHNKY80TWHGh9M1170WrQB2NMj3+FW590A6Ww0nF9WR4jpOXRRiPTROxItJagtd0RaZbQnVQkO9alkrRL7IQj1VVdRS+G1FQFwoRMDSVhIZg00YccUBmjkgKJKrpc+XDagIksOAECTcMMUf8gXyBvf7lX/TtdR00paA8Qhk=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by PH7PR10MB7105.namprd10.prod.outlook.com (2603:10b6:510:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 13:45:31 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 13:45:31 +0000
Message-ID: <7c4824a6-8922-470d-915c-e783a4e0e9cc@oracle.com>
Date: Wed, 13 Aug 2025 14:45:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/11] ext4: Atomic writes test for bigalloc using fio
 crc verifier on multiple files
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <48873bdce79f491b8b8948680afe041831af08cd.1754833177.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <48873bdce79f491b8b8948680afe041831af08cd.1754833177.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0229.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::25) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|PH7PR10MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: f346f350-5a8b-40a9-b1ed-08ddda6fab6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0lrTHpOeW9pa21qdXNDKytyQ21Tc2lFbW9OOVRzYzF1Sm1CWEI1YTFIQVdV?=
 =?utf-8?B?UUZRcmtwRmh4OVBzckdsRVRNd3JpdzZtbFNpc1RMUGl2dkI4YWRrcjFUWXJn?=
 =?utf-8?B?YTJld3NVRmkvajd2OXd3SzZiQ1NpVndqdXFxMlkyU2dTSldWaDg0WUJkdHBr?=
 =?utf-8?B?VDhtbzFwNG04Zzd5bi9mZm5iTU5KZDJqS3NMMTJkYkQvaXdDVDZLcmxwR3B3?=
 =?utf-8?B?d0tqVEIrVTNvOUZ3RG8rUjZMUWI2ZWg3MU5zUUZLYXMrRGcyd004YXVKTDBu?=
 =?utf-8?B?dkUreHdBekVXWUc1YTZna1R2Uy9rYjY2TXZ0VS9XbHdDRk1ZY29CTXozd3dH?=
 =?utf-8?B?MURyNzVnYjdrTkxwZFNQSDMwSUJYTXZua3J5Syt6LzNQbnZUeVBsMjMrVHBQ?=
 =?utf-8?B?bzlFck52M1R2RWtUMWRyNko0c210STZ6d2lYM2kzYi9CWnFKZkRrSEd0bU03?=
 =?utf-8?B?NVlRRWdYcFd4dERiQ3pFdkNXckZyaDJoWU1McDlMY2NEczJqa2xudnc5UzFQ?=
 =?utf-8?B?TXRyWjA0L3NPMitKeklRUUFMNVp1WDZ2d1oyaWZ5TTBIMGVVUjdoVGNjQmRm?=
 =?utf-8?B?MWxmRmVBWDVWNGJBSS9zY3hJdlFSOXN5M203dkNLZCsrdVZqb1poMEZtSFVR?=
 =?utf-8?B?ZEV4L0JYbGRRbkdXRHU3UEFkN2JBQzlXb290N3NuSW5pb205Rld5SFZBaVVp?=
 =?utf-8?B?ckdId3R4UnNYOUUxbDNPTWgwN2VYUEVxM0hqNnEvMGtCYzJ3c0dNZENXclIr?=
 =?utf-8?B?NXNBWW9wQnkveWswM2k0TGdJRzY3RjBYd3pKQmR1RStCRFprT2lpbkR3TGpv?=
 =?utf-8?B?aFdjTlA1S0ttT212OU5NbFZ2anc4SGJObU9hckZxYm9McjNRems3K1VkMlZO?=
 =?utf-8?B?ME9peWRkNE94SGU1N1QxVlFCUzRhdkRiQWZwMThrc3lVMitRUCtBMmo5cEhX?=
 =?utf-8?B?SU05RHB0NHl4NDNtSFBKTFpOS3pZQnR1aFRka25IU0Z6TFA1WDV1MW5BRE93?=
 =?utf-8?B?VHQyRndBeFplTTVQK0lUanpjVEkwZUUyU2pkUVdtdk1VTEFNM2NVRWU2RU9M?=
 =?utf-8?B?SWxjUDUyam5zYkkrYVhtVUdocTR5NXhCdkZvOVVMVGwyWDNpUlMrTldvZ1Bl?=
 =?utf-8?B?bWpTTEt3RlBoWWhoU0h6YWF2MWJQbXBHTFo0anVWelVsSnk1aUI5dmp3cmNZ?=
 =?utf-8?B?bTlBdDFvRytVODhhMG9XSHZDWUc1QUdNK29DV2xBc1U1VWFhakhxSzFUWUo0?=
 =?utf-8?B?SU5HSkhNNEtNbUloRW43UVFlWFREZFlOSUQ1WmlCRUpqd2dLT21RbUpFeC9L?=
 =?utf-8?B?NEdIQkhZSFd0NGVIWmlBTHFPcUFMdEZuMmFEZlpmcGd4MDFhaitqWW5vbDVn?=
 =?utf-8?B?MklzTWZUL25ncS9NZFQzL0QyMW9nTi9rSExxZXJhTjBGNDZ2M3kvVDZIOHQx?=
 =?utf-8?B?dUdrRmQzZEU2WjBJSFEyUUpLdFZheThkWkdRQXB6Y2h2MnhTdGY0eTAvYjQ2?=
 =?utf-8?B?SldXdDJKUGpiaWFHblF5cHVwbkIrV3l6RCtpYStnTVJwRXcxb2l4eVdLT1JG?=
 =?utf-8?B?cGFZaExvKy9kd2ZmbTNaUmNhSy9JUGNrVU84WFNJKzZNRXNCQWc0ZlRPYWJo?=
 =?utf-8?B?MDkzaDBUMjNjOS9ueWNTcm5FdlJYelRlTEozMUlhaHlnYjJDK2dwOTNyeE5B?=
 =?utf-8?B?UzdycjBwWmJkSXJQY3BER3VDaXJla3VKV0YzdUkzU0tueDFDbW1WQTVDYWNU?=
 =?utf-8?B?dlh2VlowQ3V5cTBIUFAycElMTEJlVFhwU0UxR0J2VHVqbUdGZURhc1h5NFZj?=
 =?utf-8?B?ZWNzYTl3d2NSdWM3bDBoT2xKTHplMTllQzZ1NjdIMVNrVnZpUVlCdnI5RXhL?=
 =?utf-8?B?dnhSQmVCTGcyaXVoa3NXc2RORzVNT2N5RnBBZmZnc1JPWEZWcm56bVJWS2Na?=
 =?utf-8?Q?8Buk5TASzOo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXI3U01CUzd4cURWQmZzS1RmQVg1b2pyd3hmWFh2V0pmSVh5clljSlg4Qk5R?=
 =?utf-8?B?c0IzWnV3MzU4RkZPVksvLzJ5a2JEUUk0L1ZReFNLUlBoRXU2ay9BUXRFUHlw?=
 =?utf-8?B?REQwYm9BRHRZYVJrMDdWUGZJeFB2b1dvd1V0bEFyYmE5SGwrbnhQeFVFYURy?=
 =?utf-8?B?UmlLcjdBNmc3N2FjKytVOGpOdEJQWXIzM0dQQ3JYVFRTeTNYazR3WWkzTHlQ?=
 =?utf-8?B?K0ZYSnorMHFXakg5U0VucEw2VE9VYkZVdlNKUlIvOFExRWhNNDZhSmdnNW4x?=
 =?utf-8?B?YzBESW5JM1htS3R4QlNxZUI2Um54MFh3L2x3bndLR1NjWmg0ZW1NTmNrbDVV?=
 =?utf-8?B?N3RLN3UyVzhJN1Q4R0s5ZGhIR05JUFM5L1htUTFMWEE2SVVYMDcrUm0zQnZO?=
 =?utf-8?B?RXpQTDRSNXQyWjBycll1V280d0hXTkNCQlAzcDYzemJCSi8yZFlEL2NRVXY4?=
 =?utf-8?B?ZkRGN21KT2l0aGxXamJDbDZSWklqcU1KbHc3K25leXhPaWRuWEhWa210WGE4?=
 =?utf-8?B?QlozSG5nbW1VNVM2YWtBUks0ZkQwVWRGcWo2SmZJN3JLS0R1OWluYlF5Q3Bu?=
 =?utf-8?B?TjlGQ3hudk5nNDZaQW1VNUNFTnV5Y1FIK0M1S29zSFZvQnFFTlVYWFoxajZt?=
 =?utf-8?B?cjBUWFBBRjcyYzVoUW1mTDJiV0pLVGIvMTMyRTJpd2tBUHNKNWw0YUNTWWZq?=
 =?utf-8?B?WWEvWXM4ZHk5Mm5wYm5rTVBWMG90cmVYUDVMWnd3a3o1bDRzeGsyOXI4dXRx?=
 =?utf-8?B?KzB3MW5IQnRleXdNT2pySElpdTVGS0V0Q3FRWGIrbzVkYjlONEVDZW0yRnpL?=
 =?utf-8?B?YldrbDlNRkJEQlo5RVVlVC8zbE1CdGJoMDAwR3EydGtxeTBpOFJkK2haVkl3?=
 =?utf-8?B?NlFNWmx2dDZORkIzZXAyNHlUV0xuN0w5YnN5Q1FpZnlnTXFJZlFMUTlOMDB4?=
 =?utf-8?B?bXpyMWNtVmFBbEovNHlSdHZycmJub01DQzZ5dmhBTjR1NjhybURmZEk3cUNl?=
 =?utf-8?B?RGVzY0wvSGJvY0xBeVNKL2d1STZNZWRFemxuZjNUYVU4c1BXMDM2VExOOWR1?=
 =?utf-8?B?WFRpdm13N1VQM0FHK250bFJ1VXNnbzU2S2MySnVrUXZ2YW5PVHVOVS9NSWM2?=
 =?utf-8?B?RFBaZ1YxeEx4ME5KWjRtTGJZTVBTN3lSa1EyOE5WaTN1MTJqSkFmY1A2Ni9r?=
 =?utf-8?B?RHdlcmVZRG4yRWY0ZDJSSSs5VjVNaVF1d2xlYzlnd0E3ODR0OEJpNnA5VGlr?=
 =?utf-8?B?dFJHdSs0bEpTaEpZck5HOFNUQks5eXZ5UXRNRmRESStYSW10amIxUnNEVkhE?=
 =?utf-8?B?SG5Fb1VjZzJUVUhwYWJqNzZPVkdqOU1KMlZsdDIvZTZFNVc4NE1PaStONnVW?=
 =?utf-8?B?SUpVeGZSd0dHS0pFOU9lV2hJWTBWUTRUK2JDMGlHR3ZHUDBMY0R3Q0VVSnc2?=
 =?utf-8?B?eTJXcmFxYng2VGtjZytwSnRWc1lSOERRdEF2RWJFcWR1cHJlR2lxbWp3Q2ZJ?=
 =?utf-8?B?RVBJRDV1cVVIL3oxbVFhNEJzWUM0RnloM0Qrajk3SkpkZ295bytQT3pzc1Vp?=
 =?utf-8?B?VjQ0WE8ySVRmL1gyYzdCL21xUXp0SXQxNDdNWHh3UXIxK0xNWXdrczNVOXNN?=
 =?utf-8?B?bHdyZ21XRVRxQnkxYkFsTEN6enhBSWoyeDlQOExSUnZVYU1ZUGRnUkxINzlr?=
 =?utf-8?B?QXBCaDVobTRGZkR2RE5xVGhNYUxxcURlaXF5bUUxVnIrQklUZzluRG1ucFk3?=
 =?utf-8?B?bjJCRnJFa2JHWm1Rem16Y1hhazR0d0dlSko4d3NxemNVQkxhUW5WaVQwbVJy?=
 =?utf-8?B?SXZwNTFzSEdsTk5vdE5PV2dlTDhlaXlLVnhBY25waGJRakk3bWo4aVFSeHph?=
 =?utf-8?B?YXBnQjIxMzBnelBYeGpSUGxKSU1PMzd2T1VvRnFSVEo4YjZNZVdmTG1Wd01N?=
 =?utf-8?B?ZmpvdkpUUm5pRnVOS0RPcktDMWx1R3NYY3gwKzNxZGF1ZTJLRHZubmZNbllP?=
 =?utf-8?B?eW95RWxSZUFjYTgyUUJIK0Q4eUxva0NiUTJueHY0WUVxalhjYmxtR3R5bXZP?=
 =?utf-8?B?dnJxY21PREE4eHp0K3lGa1ZSWjJyc1VuUXZDSDkwU1hTUmJOeXZ1ekJiNURF?=
 =?utf-8?B?RyszSllBUytQNkhrQ3ZMeVB6QmtLalpmdmZJYUYrOFExL0QyaEl0enFYL09m?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kc4NJ7razItD7m6SWe3UYVSWerCPq6a6XI06l4KBWI0OdU2dSiIKSaQ0D2KZOzhO35J6T5ukDuDYafnhxj7ovpdnrI2zFgVLQh2D9MBUhhq50fhhlz4PcldTk5NrrZQdoXRiOnSShRkZTO9XRGMU8VefyhlisG6fcvaDDMOoqmvKBQ2tE+gq2UKyijaJrXctkQ+sXlNH29p3goNnpgks4HPWI/F2hsbMOct+X4IhsNIu92/VVRgXhUmMeoa2WCIUnuHwpKj0ll502RnG7/Oz8Gqz8yie6kVRpmIahkYKCO4Tuk1U79MLrh9QFxjhIJ0Vaho3baouaDU2th/WHofBCiLLPdzjvnUrjfQm//LRHPE6JHKnRvntFMLzpHdHDFIbCs3Nm+ZIODkoAVb8K0urpEwHIeR3lZsWlY2ciIyJchErqOqEHaCM/IJwmH89nhOnzWPlO/yrXxRnj9CxRk6X5ZYno5GpgqVBaFEobDu0LhXF1rsWAm87eDpX+7QaFOeDnSCaDOBm3mt9snTgoPvD1gu61QU2strmcgzcjGP4Bv0rZexLnScsgFJDSPJ99x7JyInobGesK9Yp5Lf+H61GV2gIiYnZDY0r25yw9nUcTYQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f346f350-5a8b-40a9-b1ed-08ddda6fab6d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 13:45:31.0852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9x7HmD5qpE3WDBX1EqPoJD0kUIoYLNeCdzlKFkrrtTLx/fxtimsgpDm8f2eQr3jsSqjPoSOWTIIMVCLLVqzjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130129
X-Proofpoint-ORIG-GUID: cMb1GFIVjEajgT1vKi81EhVmKDH-GtHJ
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689c96ff b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2-jUFT37NeypqTdga1kA:9 a=QEXdDO2ut3YA:10 a=U1FKsahkfWQA:10
 cc=ntf awl=host:13600
X-Proofpoint-GUID: cMb1GFIVjEajgT1vKi81EhVmKDH-GtHJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDEyOSBTYWx0ZWRfX/Or+WPiJV0pY
 SNIhjuwC0RP0kt/C5NAlyGdxvlPFnICXTzWELPnCW/wdV/y23vd9GgzCHNQN06GUdEPMqMz0yKv
 BR3fK3HXzpLGbfLINcTmqlTCuAAFdm9XTJ+necReGZ07iUs6f/vGWVpCzab1VVT7iaI5VALDkFc
 T5SnAfV/4Muk0WzNMm1M5eQuoGvtLbJg6Yj8RuCVBiFFV+9UkUJet7GIs2m0hFKBHvbA955rubJ
 uSPCgNrNyzcIwEu3J1GGGIWLfPn0XCoH0igP3YAQmyArhNMychPWOOnFzUMmULrSeF+faJCLVyf
 xTFi4MyrqxFBHFCrirm77sp4FgDZDdmAvFpmJ4oyYvCEGswaAvAIOEd0cTzMjgz4okMTiokKl7e
 8iCr8O7ju/UaBS3p2Mbh+HNUvpLFxN1ZFHuomnfS87KNi5uwtEi1NJznemwDwLXbYompOFZ9

On 10/08/2025 14:42, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)"<ritesh.list@gmail.com>
> 
> Brute force all possible blocksize clustersize combination on a bigalloc
> filesystem for stressing atomic write using fio data crc verifier. We run
> multiple threads in parallel with each job writing to its own file. The
> parallel jobs running on a constrained filesystem size ensure that we
> stress the ext4 allocator to allocate contiguous extents.
> 
> This test might do overlapping atomic writes but that should be okay
> since overlapping parallel hardware atomic writes don't cause tearing as
> long as io size is the same for all writes.
> 
> Signed-off-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
> Reviewed-by: Darrick J. Wong<djwong@kernel.org>
> Signed-off-by: Ojaswin Mujoo<ojaswin@linux.ibm.com>
> ---
>   tests/ext4/062     | 176 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/ext4/062.out |   2 +
>   2 files changed, 178 insertions(+)
>   create mode 100755 tests/ext4/062
>   create mode 100644 tests/ext4/062.out

Is the only difference to 061 that we have multiple files (and not a 
single file)?

Thanks,
John

