Return-Path: <linux-ext4+bounces-11327-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01324C18F95
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 09:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32D3560EC8
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 08:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38784313E21;
	Wed, 29 Oct 2025 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G7Xwjq48";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x8lQUFOt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466CB2F5469;
	Wed, 29 Oct 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725231; cv=fail; b=tw+A0ag29x6mR9/4LScUlfl38pH9RV/1m/x8YDmDW8QKBe5qc+U6cj7hoBDsz1G1X2cYlh+InRmxvjbZ6m+/2pI5Bxr9ErVajo7PaoR04uUQMMPaq9XHafr7xjc2LmxrMd+wshm3+LCdsARYoKH/y0Qrqls0tbUGp1vQtzq8zfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725231; c=relaxed/simple;
	bh=R300zxSNWFt/VeoFJxnuUUdP2e1gYXmwoEV1EmrBBPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ad06wh9GIRgUXIvAejruZVlkShbjnSNUsAjpxr5/WfREQJw8jty0E+1hLdxoqflYjJ5FEdXd+rRP51AUAODmWqCeRoLYAKdJVpz734SIYvbTot2bo5TXPGXIb+6glbljhJmoEd8k9jCERkoRppdxJVdF9gwcl82JDB38Iamqmr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G7Xwjq48; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x8lQUFOt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59T7gDjQ025222;
	Wed, 29 Oct 2025 08:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LSKkJS2Ut4xWhx54pWxyWxj63VOr0CHW9wUEScsKvLw=; b=
	G7Xwjq483GdRAe+ihaRk9eSIxqVNcvHZuZOtoIlc0MQpdhcS2IUThlLNifA6JImH
	Pi2uEXYCwGPHCWvkr6GZOA3Vw1duxiWTy9OgtYTWzexvDQsDpWWM0cVq6rKGzuq/
	UYsBRylhZJtpoTsy2vC12hJUQYTaT1brS/YszfqWlhgvVpcxQWtpEtLLiHahOxLR
	la/2yVgQ3DXIof6TlFY5peSWJqD/z3jXiDhxTGmc2YHmk+qyGiFp7v83LoLCeaJX
	5UK4gpIsrXBnZNP+9yA5o3shMYX34GE/lohGAqZ5x6EdjH2JmcieWG0fC6/zPjOd
	RIfzSd0NO39FURB//5Aunw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vw92cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 08:06:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59T6RPq7011315;
	Wed, 29 Oct 2025 08:06:48 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33vwvypg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 08:06:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAvqvNhQaJOG88PTZgcxGCKcbKiRMGPd1HjMFASj4RpKkB5EHoJ4rFMdr73ooMLe16eaBraBKYIw9sTqkXqqLLHlAsko4/DxZ8J5dj9MPC3/eRPsikuMKr8Y9nuaXIJrAcVwrgZdPEMSXjlI6p8AWn3Mej6zGhAVM0oWyDSr6fDFvVIZ77yXGET2n+7ZVVFD5F4NeUliSKS+LD9CPTZaU6gDkVBAIXx78ZaUCjK5mgOf6VTJH8biDpgWXofBOswqlXFvt/UWpvyWF2AhoY7sFDEx4dunTOZznCXC92vQ/eD4deTX0K5W0+edaGFcysLxc1WRQd6hYoR9DXLJbQAWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSKkJS2Ut4xWhx54pWxyWxj63VOr0CHW9wUEScsKvLw=;
 b=G1uc7iOypZJ+sRDV9KBBnfb9khy9vYW0NOEzgSpZrZJP2/rLofZhqS8kqU/mblHSX0TwQq8kZoU1GwS3jBtH7mxrcNbiqhkAdQO6z/a2M+hivd0O5KF70uJtP6iyJNB5rt2kVBevC9IG6AR/sIIt/XjJ7yQqXBkcUGROjuBrMiM6UF9reQ38w3rXLskBUTWrfL1pSFWFtvc2UiJoWGTFrZkVaardBHN64IWyULPifREGv87YSY8Gs8BS5zw7HbiM5VwbIagZoGyl5SarhZdubIJXTGsXR7MOl4RAXKyxR3oD4FK88J2MnjgIfSXsi9+sVI2W0CVVUCss7UjLwAL30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSKkJS2Ut4xWhx54pWxyWxj63VOr0CHW9wUEScsKvLw=;
 b=x8lQUFOtPTkLPWf8ZH6tgxx7ObNYR+XG7BOAr2b+vYp4MNoB1qmRPk/8dXNrYqW/aEJe6/t7CZYpb8WW0TNSkFs0OZRrap7ywp4VZoHDse37uv5g/nfkGpNRwJGhvSjFzXnuj6jRmUc98EI9OPDaXl8hGli0sBL9sARjC7yZoZs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB6309.namprd10.prod.outlook.com (2603:10b6:510:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 08:06:45 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 08:06:45 +0000
Date: Wed, 29 Oct 2025 17:06:37 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com,
        cl@linux.com, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V3 5/7] mm/memcontrol,alloc_tag: handle slabobj_ext
 access under KASAN poison
Message-ID: <aQHLDTwwEuswvNWv@hyeyoo>
References: <20251027122847.320924-1-harry.yoo@oracle.com>
 <20251027122847.320924-6-harry.yoo@oracle.com>
 <CAJuCfpG=Lb4WhYuPkSpdNO4Ehtjm1YcEEK0OM=3g9i=LxmpHSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpG=Lb4WhYuPkSpdNO4Ehtjm1YcEEK0OM=3g9i=LxmpHSQ@mail.gmail.com>
X-ClientProxiedBy: SEWP216CA0100.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bb::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa63364-ffde-4022-2c8a-08de16c21a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2lzbDRiaDlSNkdZRTFkUDVhMWZIMkRISWovc09vMjZMQ0lhNjVQblVua0Z0?=
 =?utf-8?B?eEUza1RsN3NGVnZ6ZzRrTWhXSVhkS1B1eXpieGxWQlRhMmxZTWRocnR5dzQ2?=
 =?utf-8?B?cG5WcmpUR1NwdHAvcWRjWGxPUzl3NFlIbFNKbno5bFk2QnhkbGhCS3c5TURU?=
 =?utf-8?B?eTBLcHUza1JISHJoVERQWUVVUTU3c0QrWlNiaG41MUxtNlZxUkRSTGliMTA4?=
 =?utf-8?B?SXBTNEFuYTJLRllGMjZrdDRkNzV4ZVIxNDFRTU9mWXN4L0l6Y3NwazVwUGNU?=
 =?utf-8?B?U05rNndnQnc5aFBTUFA5aTVEYnBVc25XVHY5SzZwODFmS0diN2Y4bDJqbmdM?=
 =?utf-8?B?TFV3NnY4ZDFKR2hKalhhem5sMHhJckUvbU9wc1BmanUzOUpGV28xUjQwSGI2?=
 =?utf-8?B?UmVjSFlGMDUvR2NqMGFaVGc2TWp5QXhFaE9USHFoMWNjKytIRUJqcFV2TEV6?=
 =?utf-8?B?QjJOZnFJL0p2bUNsRWJNdVN2aUJiQ0dBRXE4RjY1aFl6dWwvS3QrVlFMUkRa?=
 =?utf-8?B?N1l2SEtjdDdlWU1CL3VVYWJFSG5ydGJyTm82UFphRGNZSURiY0V2WlczSUpB?=
 =?utf-8?B?T1kydVVtaUhYWmd2aHFLYzVybFg3Z295dWFENE9hQjd2T0tKdE42bEVudHpG?=
 =?utf-8?B?bmUxOXA5ZnI5RHFyTmlDQS9IV3VyNW9tWm4zVGNaZUNIRUFJSGNJTVFORjZ2?=
 =?utf-8?B?Q3g3UGlmbi93Ri9MMTh1cmlRYnhhTzAxdFREWGdKYXlpSzMrQkoyVXRwcWlO?=
 =?utf-8?B?UXFxRDhLYVA5Y0wrR05td0hzeEh0dDUxZkRjNWFvSmxZL3oyM0JrZ29ZMXI2?=
 =?utf-8?B?RHhISGc4RnlrS1JTSjNucEV5RWdGSUh4ZEt0TzF2VzZBRkhCMEJRNnU3U2U4?=
 =?utf-8?B?VlJDM0RidFlUYXNWd2ZJMFF0NldRZVZoZnFrMVhnc1l0NWZGazBzMVBBVC9w?=
 =?utf-8?B?aDU1OENVNTdQemNRWGJvYUZZakh1OGJMOGY3SkpvbE1CZGpWU2o4TjVPOURU?=
 =?utf-8?B?bENyN0kxcnhid1VwRmtzek9tbERrZG9SNWtzcG9WSG9hL0N2T1ltb1V1bkdz?=
 =?utf-8?B?T0VaNC9vMER2cGdwblFib3pobGpDSFJaTFdIeVZDZkJxeE1KZlo3N3JYSFhJ?=
 =?utf-8?B?UXlWSUhpNTV0RWF2N0RJN0ZOK0ExM3REcTFnU09aeFd2VHl2Y2d2aGIrZFEw?=
 =?utf-8?B?NGFrUy94aUl4NXBMTlp3VCs3RGJmR1piS1pSN0JKdk12djZIRTBiVlZJM1gv?=
 =?utf-8?B?YlFwNW5lUk1xZVpmaG9ndUwwTUZQWStMSGhUSDcwU0tTN3Zlc0NtQVc5R3Bh?=
 =?utf-8?B?UnN4dGx6NDd0RVVsRjhRSVpLaTdKK3U3SDhHL2F3TStaZ041Y0c5K21tYUE4?=
 =?utf-8?B?bDRnTkloQVRRRFczN09qbnlqdVZKQTdhdVpWRmFDZ1BtUDlLbEREbTdPUEs2?=
 =?utf-8?B?QW5UOHhTTHF3MGxvRVNiSStLVlpBa0hjYU02b2RoQ1h5UnFjSWpXSlVscEd6?=
 =?utf-8?B?Z0wxNEcvVEtvczRVb25ZZ1E2RWZVenQraEN4c2xyb3RVQmlRd0oyanJzSldD?=
 =?utf-8?B?L0NwUUFXVDB2azJtSkpvQ2lXODhBUW1NZlU2bU5qaWhvNWg0dFFvVjhjNk9r?=
 =?utf-8?B?V2R5TUdNcTRjcFdod1JPdTg2RG53WTF2VXhxcUFvUUVjV2tyY2d6RG0vOXFr?=
 =?utf-8?B?TEVWWTJSWWs5TUFYZnluR0dBWmZOTXV4YlVYTmNyWGlzR1BMSExuY3JkU0JF?=
 =?utf-8?B?dUVuclRWQjhCcjRTME5PV2V4NFpLaEVReVRVbE5wN1hvM04vbmNZa21ZRWtP?=
 =?utf-8?B?dVEwWWcxeERUS25PS0dHMkpsRnV4cnhZTnhIdUhwem1HMDRuUkNMdHlMZ2g3?=
 =?utf-8?B?cEFRVDRrTDIyTG43OXNuaUxMeExmc1pZWGVFaXV0VHFhcGRkOWEvUnZvQkZK?=
 =?utf-8?Q?3ip5KKB78DI/2hTE9jcRgG1XPAgdIy2C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnBpQW11a1crajU5Q0t6NlJ3eEM2K1J5WS9TbFNmaUovdVo2U2t0YzVCSDk2?=
 =?utf-8?B?ZkM0bnNGaWpDZFNzeWNnb2RTUWtwN1ArekJBY3JiSFJINnE1K2pKZUxYM3RH?=
 =?utf-8?B?Um14QlA3dXovclZLZTdkMVNwV3I3MGRxTldwbW5kQlFtOVk1MkwvQ1RSR0FW?=
 =?utf-8?B?Uk5aR0hLdDlEcjZ1enVUM1JqQndldGhEeERQakYzQ0xrMkREcXdxMS9YRXRR?=
 =?utf-8?B?M1Y4TVB6VklIelJyUlJzN09tTVRSSVFrRjg3QnArSDU5NVZERTYveklFT1NK?=
 =?utf-8?B?RTJDcHV1aEluL2gwTUVIeXRGU04xSnNwanVzTFhDSXZrckVPMjZUL25Uam9l?=
 =?utf-8?B?S2tpVTlHRkdQd21TZFJrSlRNY3pqYithZzRqOXNYb01wTW91R0FIcFNuYVBz?=
 =?utf-8?B?UHl4Vkhib05TdWh5dU5ZakRwMXRCSmdndVpqMlpocDgyNVlaZTdYMDJxVzZV?=
 =?utf-8?B?Tmk5LzNOQVlLY3lKL3huNk0xR1VrQWVMbnJUQjdNanBkVEc0T2JvSVNnbFoy?=
 =?utf-8?B?WjJmUTdzMzhqRm9qRU1TSkpBRzNYQkErd0JwMFNyL24vdTZNc2FZRURaaW9s?=
 =?utf-8?B?ZWIyeEhtWEpUVUw2Ty9VUEt6YjJHM0RQanh2RUNRVmtKK2pJdVJvQmlRNjJi?=
 =?utf-8?B?eHBRUGtKY21RVndMNzRDUTh4NitXMU4zVE5wSEdGOGZiYlZiWjByNzRyQ1Ft?=
 =?utf-8?B?SWllcHFhNTdXRGJWVUhqdnozTHhLUmZadlFXYVhVSDZqZm1aQ2tQZERISUNr?=
 =?utf-8?B?MGtJY0dNNGlITHJOcUNtRkR6aGZBdURiRzlUV1FyMk1Td2dMMUlVcDBleTNm?=
 =?utf-8?B?ZnZ3dnMxcEJMa2IyL3p1ZWNKY2pFL1BJZXlHbk9sWEdma0NvbmExYTlhYWFl?=
 =?utf-8?B?a3Z0YmV5enZ5dDB1S2tKa2xoNC9BYlVPdDBsMThhNUVMY2Y2SmpuRWM0MUQy?=
 =?utf-8?B?bDQvVGV6VGtpZ1g1WGFheG9pd2s2Tk1jSUJ2dVlCTjlxWHFITDgzSDRXWkUw?=
 =?utf-8?B?REFJMnZNMkxZaXFBYitWN2VubzM2bThIc1JKZU1vaFFhKzYvdHFZenAwQTUv?=
 =?utf-8?B?RWZ5eEJEa1dldXRPZXc5RjRKU2dFeDRjNGdLVjBaTmhONzhZQm9BMVhUQXlr?=
 =?utf-8?B?UmdxR1lTUlhGa1hBMlh2aGs5NGNEbjFPdkVDbmRjWkFtVjdVaHY1QmJncUEw?=
 =?utf-8?B?aGR5KzBucEhlQUp6cm1TUmhiSXdTTEY4dW9XWkJqMlUrQnRLSkkyUndmRHVX?=
 =?utf-8?B?S3B1WEsvRHhMaTRUTXRYWWVtd2JpblE1M0FtbkJvcytWTG94d0FNREpNQ0x2?=
 =?utf-8?B?b3hOaTZvZWxhSlFQcnhQUWFvK3dsc2xwTXhOZ1Bxem5TSEQrN2RUUHpNeUJL?=
 =?utf-8?B?ajcyNC95NDJNemNDRUp5aG5LSGVscWVPNWtNWEVzNUxNWU95eDlGQTJRcnJ3?=
 =?utf-8?B?L2Q3cFcyT0RFSmNDUjdySG1kRWV6bTBXMG1BbkVnbU5EUGlKMVRmZVp3OXNM?=
 =?utf-8?B?OHROTHg3TlZXcE80U1dQbyt5OUQxNkRxdkpORHNJZW81TVZKTnBTZWZCKzds?=
 =?utf-8?B?cXU3SmxTVmlXdGpCaWVQY0Zka0RMSjF0WlBQVXVweUtoNXFwSTNDTTVxYUNG?=
 =?utf-8?B?OXloWTVhMFVPLzc4Vi8xbjJaTXRrYktPeTNCTUpaVjhOQVIzRkRrcDNpQnNu?=
 =?utf-8?B?U1FYY1kvcUxSQUJtbWJibEFaSzc0am12Ty9MTWk4R0ZUSFlYZ2pKMlRvRjRT?=
 =?utf-8?B?NjFtakVUSEsyZTlxUitUdWttVVc2eHJrSTNyeDcrSm5JcFRLWFZybUVXOFVI?=
 =?utf-8?B?bnBmVDhlZWVDQk5KbTI4RXI3c0hQbXNtbzVIdTN3QWYwRmxzSkl4QVJrc1Zr?=
 =?utf-8?B?SGYyNG0yalNTdlRNSndiUC96Uk03eUh5Q29TL2ErZXJCdTdCZElmMFp5ZEhK?=
 =?utf-8?B?RFJmdDhSUUVyQnBqQ3VsVlA0aVRhZlpraktPb3F3MG12WjdFRG1oVlVxc0E5?=
 =?utf-8?B?b0d3WGNETkRFa1dRcjd0OWtGb0R0Q3VsQzJveXFvb3B0aERaKzNPbS90TEd3?=
 =?utf-8?B?WGlvUXI2akNvTlAzWTBIOHNBeEY5NmhZbFlkTmhqM21qcExDdnJNR0ROdENi?=
 =?utf-8?Q?l7/8MU/b8GGnZn0bBeXm+LIVZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o74spH8dgKJJumQKSmh2faBlH69WfgN1Pu3eJySNf3HWW1TtyAeyq7nrsg1Ad8bHTj4/VlbYpHsOhQprOlVqJPX2vuvLkq3S/UPlM14oTciOAZqEnN4En7EZ5hfOSbSI5wSF2wJpTJNrKTRFSukX0pwPEuxMe/a5w/Jh99YWRHNHAhHNtWTmFW7FnBodio9Zwyqw5mKf1vH5d4TjM4G/kJZaQsjdxl/axNfYODWH+vWWt+E6hSxmioSDkiedhjar+94jqcfNFq1cI8CSNKXRLnh0nf3MsTJuBPmAHJszdGwgTB8dAR5DLAvcdGMfUxyz8E2k974Rj1ezYSmKBkCi8WhgbncZYZtgKshzg/khlREzhcRDSJQ69TseEppfG0jx4k37T4FsZK7bRgXiVOIY1Hc2cnDBwwhTPfCOXPFUEbq2CMgVRxKmHwtrpW8rAE7xUq1IczSbU8DFCWwZMKg49f9Tq0OZp79Dm0EI+kGi9ALddKAKfclxZUSJ4NN+1/rM5EmaW/50lyor2wJTLFhIf2qgiKIilcAeBR71CansUQWq/vF18M1MaoFdzGnz1X4MxLz6WewNkebvm7OAZx7SVATf9QQUHP32iiaWbdgXs9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa63364-ffde-4022-2c8a-08de16c21a1e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:45.2925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnemt8Hw05iEUWgqUrMykSEl+Up9M9ZQO7fL3dFI/nB7TKhVv3mivNKQepvygA4aWLN3sQsACClFM61aitazIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290058
X-Proofpoint-GUID: yGiMhOYzXwRsmI0OOJhPHaeS6JMozDFl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfX3K4V/JPMVowS
 eDE5rKGMi02ez8jp+PwXgerCRDMMj0WL6tXAfMjCDvZKUYEmCDNOwu1z7UCDLc4y4RYZTnztHEV
 lun98bleVdkLewjhSR4qjhGv30EJntiNUWKOcNt2TKP1OI84z9kWMcG8CKDpKNgD8KMA7qwyIrD
 Hw1b9Pq5U0RYcX7oJrOfbm8YCxFNWGj5gUhRk92bJYs8wtrEVXX0Jg+LdrZwZY8A3aw/7QnCLJJ
 q8hHmSXnJXoeNGquhOyKyyOClLO5lJneUEnx3rJ2DmNvooqu1jVf94BL6D8FxsYAuDuNMkRISS2
 oKvOJixnBQ6+K31PJsA8UqiEazQYvuoUk7CaVbsw1N8ggYulbBLyojxhZgIur1t46YjOzNrySqo
 J8fnF1rbIEVOK2RAKGQDzvzGFYcsgw==
X-Authority-Analysis: v=2.4 cv=Uslu9uwB c=1 sm=1 tr=0 ts=6901cb19 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=xE4oD7gpLml0SneWzaoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yGiMhOYzXwRsmI0OOJhPHaeS6JMozDFl

On Tue, Oct 28, 2025 at 04:03:22PM -0700, Suren Baghdasaryan wrote:
> On Mon, Oct 27, 2025 at 5:29 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > In the near future, slabobj_ext may reside outside the allocated slab
> > object range within a slab, which could be reported as an out-of-bounds
> > access by KASAN. To prevent false positives, explicitly disable KASAN
> > and KMSAN checks when accessing slabobj_ext.
> 
> Hmm. This is fragile IMO. Every time someone accesses slabobj_ext they
> should remember to call
> metadata_access_enable/metadata_access_disable.

Good point!

> Have you considered replacing slab_obj_ext() function with
> get_slab_obj_ext()/put_slab_obj_ext()? get_slab_obj_ext() can call
> metadata_access_enable() and return slabobj_ext as it does today.
> put_slab_obj_ext() will simple call metadata_access_disable(). WDYT?

I did think about it, and I thought introducing get and put helpers
may be misunderstood as doing some kind of reference counting...

but yeah probably I'm being too paranoid and
I'll try this and document that

1) the user needs to use get and put pair to access slabobj_ext
   metadata, and

2) calling get and put pair multiple times has no effect.

> > While an alternative approach could be to unpoison slabobj_ext,
> > out-of-bounds accesses outside the slab allocator are generally more
> > common.
> >
> > Move metadata_access_enable()/disable() helpers to mm/slab.h so that
> > it can be used outside mm/slub.c. Wrap accesses to slabobj_ext metadata
> > in memcg and alloc_tag code with these helpers.
> >
> > Call kasan_reset_tag() in slab_obj_ext() before returning the address to
> > prevent SW or HW tag-based KASAN from reporting false positives.
> >
> > Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---

-- 
Cheers,
Harry / Hyeonggon

