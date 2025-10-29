Return-Path: <linux-ext4+bounces-11326-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2546C18D24
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 09:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE361C807C0
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 08:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112662EB868;
	Wed, 29 Oct 2025 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jdU/xSDW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AvsfKxcG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA246176ADE;
	Wed, 29 Oct 2025 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724842; cv=fail; b=lU3XuSTz7z243gXtUav2NYnQzdDb/eKggi04hW0TML4MiJShROoao2iFZdOtDFEkm2N/8+5OVpgZV0GtRXECQEmiyLntpurafpphmlAYaJQoLikCi94CAZOURSfNGe7YygvUB2SVzLp5iRudVv4Hi52W9IIB36Kkc5F7NCv4e7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724842; c=relaxed/simple;
	bh=9T6mMwRhqAT9umKsUlZJAX0dZQlwtR1Rt87N7ZOa+1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=phpdErOqoM5m8gl30gpLu8YLtNhjk3Q1L5i+VpI0YX8MNnXaaJJ5I48hydwvrmDNgAQK1e8G2VnaRrAMl9pXb4TAYUz3qFqA1KT02ABqOvF7olWxBADQbJWj1fwAPtQTBoyzTMa7m/a/udEhl+POZ0z4Zeyc2sCV1gk6pWzh66k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jdU/xSDW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AvsfKxcG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59T7g9VF016971;
	Wed, 29 Oct 2025 08:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4iNYAYehp6pLLf8OpWlsCK9fO7ouuyER46BDykjHP1E=; b=
	jdU/xSDWL+H7hjB+5bR5z3QR0htSnjeZ+/OqOkJSzGzxdzzMHLkOlgHibMGorqBT
	UaVn8aMIMH7fcDQDjXY833XyQmSxRVk+YyPXgwVujhS/gM2rIO+eE4x+/xPxF7uQ
	mAHS+bOuV7RTi0wrh6yELgo4CFy/bJbuenpzcuDRYWVBdBwl9joNQ6TZbC9YVFPB
	yUYfwBB7heGe31QlX5JhhxqsvsFSPBahE2vkfrf+bUtpB/Jxnjt87ku+8Hl6cijf
	HHyf8972jIcdQmo9BC1YQqia0cV+417KPGkgZQ5pxy4qkNNyyzsC9Qf65hqanM0Z
	oVFfh3X0p7KHWM8MnZsnVA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3c3b099h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 08:00:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59T6cgj8012349;
	Wed, 29 Oct 2025 08:00:13 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33vwvr0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 08:00:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJ4zV1Q3Bkx3csEnJ+qTiwUYLvmFLmRovKGp9DX9ArNOpem9Jk3OQ9qX2b9fScYLDzq8V3GH95KlDICbwaNk7YAnIJzx2fAGk653HGVYFCRAoAxQ/aYKepMEtUo+9V6AE7wL8APvgoNMVqLslAENLpQ2SkyS7Sz4NwTcKG/4M+0Ic2Bv9B1RYLZ9Fruqs4veO9CLrhOQjWqRXLz7/vo4YEDQh4Z3Kw4vFaCyzdQ5eAa/PwOg3K3QgLrvME7+Ki+jT8o41YOtv4XPYe+6anutn8AeyltgYD3FNnJqrIY+zThxN6RMQbeWhR4Ypz6hV/oK2tQKehXziyarBB1D1I0/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iNYAYehp6pLLf8OpWlsCK9fO7ouuyER46BDykjHP1E=;
 b=vBWnK7D0Q88A1b9GPwJBCIKc2TFka6T1h0pTgE3+2FzdQ9vIBmxAikq/nAmFvIMekhBwCeE23p4dVaj7Ci5cWBhbf/4QYL1PqtsHg7/KRklm8LPyXMT4Ifoixq9XTB2LYtuhZxf9mXR4SphmeuP2oRCBiV/a5+CSy+9eZGsN0bwNGM2C0QdsHkwW1d47KhIAIH454fZ5VMxpvGNsdainyfZ7pT5qAfOEQh4860A52StbGL4QE5E+6jUM/cp8Kv/NBUVLEtJFOM6aL++n/XW/9VVc6oeRmGd0BYvNU6bYR04N9DpQ2kjTAR0F7RCL4ZHNjEGTl31iUP0YzZGqsT5bdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iNYAYehp6pLLf8OpWlsCK9fO7ouuyER46BDykjHP1E=;
 b=AvsfKxcGrCDqqxGBw7FB3hDE/eT9QZNBjTtDfh/4qS7yFozKDqUMpsWaR0JBoE3OWcUYbtUb5yd/zpPDbfZ8I3iQGaNijQmrAoTdVn4zKeztlF/iV8FP87IH9gNJwM0BypL/vnkgokWA6rUqcKVX1gxfepKZ9Tx01MPNvA/m9SY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH3PPFF6F1F7CB1.namprd10.prod.outlook.com (2603:10b6:518:1::7d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:00:09 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 08:00:09 +0000
Date: Wed, 29 Oct 2025 16:59:59 +0900
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
Subject: Re: [RFC PATCH V3 6/7] mm/slab: save memory by allocating
 slabobj_ext array from leftover
Message-ID: <aQHJfyoUN-tbnVFr@hyeyoo>
References: <20251027122847.320924-1-harry.yoo@oracle.com>
 <20251027122847.320924-7-harry.yoo@oracle.com>
 <CAJuCfpGY0h2d6VEAEa4kjH2yUMGDdke_QTFt6d+gb+kH=rnXyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGY0h2d6VEAEa4kjH2yUMGDdke_QTFt6d+gb+kH=rnXyQ@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0039.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH3PPFF6F1F7CB1:EE_
X-MS-Office365-Filtering-Correlation-Id: 23eda781-a2d4-4cc7-d92f-08de16c12e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkFueUJEYXZXcGtNNDFXZ05ZSVZwaHpNTDdFSlZiTmpyMktKZzFRZVJOejYz?=
 =?utf-8?B?YmVEdlU4ZGhIV1YwektGZ2JpRXQwcnllQVNjZ3AvOVhOWTE5REcvaXdLVHJM?=
 =?utf-8?B?VjNZRGpEdHFseUFIY3FDM3l2cWhPNTRSdHFUV3h0c001ajdoTFRZRURNNjlu?=
 =?utf-8?B?QW1BM2hFR09ZODlxRkpiRDlFc2RIU2Vqa0JvTC9jaElvSWRYaXBLR2ZRWUR2?=
 =?utf-8?B?UE5mWnpWcjRPRUFQMGxYZ1AyODEwZFd6a3hxWHFBcFdMQnFqQlBHOFhZQ0tE?=
 =?utf-8?B?emtHZDRGVmVnR1pzYmFiYytIa2x0aEhwNnNMUWRXNktQTW0zL1Z4by9Bc3ll?=
 =?utf-8?B?TG52aENNaHF0TU0rVjhaMmYyRmhMQ0xUc29lZU14VUpPTlJFbHgrMkpxME4v?=
 =?utf-8?B?aWtrb3J5ZktRS3J4RUdjZUJEWXUzN3M4N1NKMm5rdk10TW1zT3F5WnpYeHlV?=
 =?utf-8?B?Q2xTcDN5bnQ2WGNNN00rVm1ZN0I0TWNUWU1jcWdHVGRIMTNXVUlWbTB1UFZQ?=
 =?utf-8?B?cUJBRTZCYXpiZktNY3l4SmgyYnlzRHZMdHhMVmg0cWlIMUJ0aEVMazhHS0U0?=
 =?utf-8?B?dDJHcHlNdENuZkY0ZDBKRUEzUVNEd0RwT1c3cG9EWDByRG5vU0lQalNYMFJT?=
 =?utf-8?B?bWdSMFk5RlFvT1o3aFhrOEdDV0NKZFBsZG9yNmV1UVBwZGlmL3FjRGZsaEk0?=
 =?utf-8?B?RkFtTWk0NE5MYnJoRUhjQ3NiK2VsUmVWYnBFdHFxQnlCZ2VMaXhkQUM2ZDVZ?=
 =?utf-8?B?RVh3cGdBZ3JuSk5tT1lvU3lYMFg0emdUWHk3T0U3RFloOXdNRE1WcTN6V0Jm?=
 =?utf-8?B?bEJaZ2RiVGVPUUE1T0pQNUhtR254ZjFEOHQrQ0QrcXk0aWZVak9SbWRlU3dL?=
 =?utf-8?B?eDkwSW1lNFREYlBtZ0NZM09BVWk0bzR6MXhnMjVWUjJlRDBuOUxpamNOemVR?=
 =?utf-8?B?eDBFYmh5TmhnOGpMakxDc3R4WnBQNTJ0bTA2MmwxSWh4VWhPTVN5QjhKZXFk?=
 =?utf-8?B?dENqZE1qTjgrZ1NhRWxmMU1PZVNFOGlXWlhPaTJXQ2NiU1JzdTFxcnFOOXJN?=
 =?utf-8?B?SlY5SlpkbW85V053MW5aOXlocXpTMlladUl5UnVaMy9vQ1d5UUlaS29DejN6?=
 =?utf-8?B?MDJpbEZnWXpJcno0N2ZicWVaQVY0OEpKRzUyR2ZjT1RaU0svWEx5VUY5SWJr?=
 =?utf-8?B?WmdRTDVyWGs4Z3doZDlOdDlOM3MrTWhnbU9RYWEwY0diVUJrMTdsbmE5VkZz?=
 =?utf-8?B?SWRZam5SZkhzUXJUbS83dFMvZURwbjBweVV1L3VjSDhNOFFMYlVmVTBqcjg0?=
 =?utf-8?B?VUg5OHMzQ255elZtQ1U3eDJTZXo1VXQvOUw5eUhuWmkwVUtuYzBIL1EyK3Ar?=
 =?utf-8?B?UitmR3NJSXNDV3JNNXJxcmNBZlRsdUZJZFQ3aDZ2SFRKSGEzWnRqNlJkYnk3?=
 =?utf-8?B?RFRJUnRaeVBUK2lVY3BzMlhoWUUzZll4MXFuR0xMSFp1WEhYNjBRM3R1Q1Qy?=
 =?utf-8?B?dXZvL3VLSE14eWFMRmJlelhDZGpwYlYwNjF5b2FsR1VUZ0VnRFRFd2VkSDVS?=
 =?utf-8?B?OFdDUjJOTE9WajNSdUtKeVdlRm1nck41NEdINFVSYytxc0hQQys1R05ySFNP?=
 =?utf-8?B?TklhV1BjNCsyd0llbDVnS2dNMmg1TWNzblA4OHBUdTY4NEhRQlYyRFVVVmVm?=
 =?utf-8?B?ZkJMaS9oUWlTUVpCVkpaKzN2WTNuMDZkK0xpby9qSWhjS0YvbDV4eVNVaWV0?=
 =?utf-8?B?bVhzSEwrVlZJMHI4YUszaE14VitRaUZDcHd0aVJkaEh2V3RZaDQ5cnBSeUJN?=
 =?utf-8?B?Zmk1VjZaOW1PSEkyaGRLc2l6bTh5cHRqbjhIL1RwS0tvdkJtK2dMa0RQTHJH?=
 =?utf-8?B?SmNDZ05PcThBK0FyckV5Zm52MlV1QVl2NVFUVXJNV0g2Qkx2YlYrVlF6cURB?=
 =?utf-8?Q?ysdHVE9kWZ3UHnpvkjlUhOXN56+DRHt5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVNKMmFpWjhZNzlGN1lFYzd0cUlQbEpmTCtGVHAwK2p1bldKb054ZmZpQkRi?=
 =?utf-8?B?aXNoU2JaWWFrOGRjbEFBUHNYU25TZEE4VGxNU29PdXRZSFNicVltU3ZBdkpC?=
 =?utf-8?B?YTNYWWdwSTlYNmVDV1J5Q3Y2WWtpcUQwZFltR1NSWVhhUzlLZXl2NG9VV0pU?=
 =?utf-8?B?bDdBaWN6NXd1RHNmenk1Tlp6YjFsUG00QnlGQ1ZxTDVqTmJrczd3Z1Y4UFh0?=
 =?utf-8?B?NDVWM0t5ZU5aWXFzU2MvV1lKcThMaDZ1K2EwTWhCT215WXpVOTI3bmVlUnVL?=
 =?utf-8?B?OWRLSjlzcVY2WElZbUNGcmRTMGpVMTlUNmU5UFhyQW1yY1hLSnJNSlFnVGlW?=
 =?utf-8?B?S2Uybi8ycUZFeVFPckptZ3VKQ3c0eWNXS3VOTVV1SHVZMnFFQXNTcFYwSEVZ?=
 =?utf-8?B?QXF6NmFpMU9lblA3MldTenNWRHZpMkphcFk5Y2doTU5sUzdwYXFybmU1bk1a?=
 =?utf-8?B?TmFza0N1d0ttQllicmRTYWI0RkUwNmIvUUlYT0Z3c2gxdzZjbW1mc2orYTRh?=
 =?utf-8?B?eHFqc3dtWC93WG01enhXV2pFTEcvOUJIaytnMXlib0hCUmQ1SDhUL2pQQ2Vi?=
 =?utf-8?B?RnlwN3JtRFE3RnVIVlhCaXR1cHVhbjdob09lamRPbzEwWkVEUkRsS3o4N3gr?=
 =?utf-8?B?Sm9KeU5QTkRrRjRpNnJCVkhNZ3RJMGJodmhjSWQxeWpGVWxydmRXTWR0WVV5?=
 =?utf-8?B?QjR1SG1iOTd0N2szNUdLNk1TWUo3UlVPajN3YXR3THU5cWhZVFVWWkl0TUpw?=
 =?utf-8?B?alpOMVdUa2NEWDZYWFJLdVhCcUZ2ajdLTzc0MFBESmVoZVc0NFhkVnEyTlBN?=
 =?utf-8?B?RzgrZ1dMTFNZWm1NcS9tY3lzNy8yM0FndEhqRno1L0RpK0tBQmZPUmxzK2Ft?=
 =?utf-8?B?RnlrNGxUeCtrckpPam15T1hFL01QOGh0MGtFUVNXVWpCRDZSRGJNNUpJYVpM?=
 =?utf-8?B?Q0FhU1o5THY5NFNXZDllTTJodHRmUDJFUG9UbHV1K1JmaEFyVGNaeml3OFpV?=
 =?utf-8?B?dE8yT0N0R053MHQrbXF0d3hqb203TGM5V2pOOEN2OGRCSjUxTlNSbjNhNHRC?=
 =?utf-8?B?dEg0bVNnUng1SlROUDNtZFplL3IxdFUvdENvTHkxY2xjWllzT0RUUEE2Q1l4?=
 =?utf-8?B?cElQeEpBKytBcFZuVVdNMC9lcE53ZlZwOFpaQmRXQUFyMUw2d3ZPSFllR0xi?=
 =?utf-8?B?Rm5BelhoR0cvVldYMGhvM0JQcDRaaWNQWEdpT1FtZjBiUHZOa21HUmtYbi9V?=
 =?utf-8?B?V1ErUHJ6MDhqL0VSKzNQNzFlUjBwaDdNQ25QSjEzNUxWd01XRkw2SThqbzZp?=
 =?utf-8?B?cVZ4bnpoSEJ2QmYrY1NtbVNUWnI4UHBvMFF6VjdQZTNEU3NWdFhmdEhQUHNI?=
 =?utf-8?B?djVJR0hXTG9rVkFUTVRTNXNJYkhJU3FtVFZ0V2cvMFR3aTZ1YWxkcXpoUjU5?=
 =?utf-8?B?K0xRdUFyU2V3VjJwUElyZC9NMFgrNG9QMU1GZUphK0ljQTNmZURHYUpOcy9y?=
 =?utf-8?B?MDhRR1JySklscnJuSmk3bmVyYjFKQVNMZ3lpeFAvRENpRUJ1WGhwYkUwOTRU?=
 =?utf-8?B?UFI3M2lhVS9WL3FWTGpIYk1HWkJnbUk2bUtlMEhEK3NHRWJzd2lkbUhpTTYz?=
 =?utf-8?B?TzIrSThCNG15Lzk0Mzg2TkRZTW1PRkwwQm5VbC9YUTlVNGhPbDUyZUFCSllD?=
 =?utf-8?B?Ukh2emhFc3VEMFFYRHRuYXRYQmxpQTk2S2tEclhSR3lwOWl4bXBNd3MxS3RZ?=
 =?utf-8?B?Q0h0U2NWcjVoTVJnK25sOWY5WlpnVVIrNlBSY3FoVWdBTldTODgycUFjZVhR?=
 =?utf-8?B?V3RidVBhdlp6Q1JlSWpuV3d6aUM4blExNWx0RXQ0bmJUT1FJbzNZZURMRldG?=
 =?utf-8?B?bnFNZmk2aGxoVEF1Nm8vNnJwS3NtK0xJQjJuYkVoWXdtd01FODdNZzR3eUtt?=
 =?utf-8?B?Q0UrT1lkQktCMG5Ybkd4MVo4NmpLUENUNXRGUkxsVHlGL0xmOEFGYXlsS2Z5?=
 =?utf-8?B?Ukt3L0pFNHdvK2tKMmNjdXNNendpSHlDQ3hBQUY0ZVZSenUyclp3S1E4RmFQ?=
 =?utf-8?B?NmpjemhSdVI1eUdkdjR4R1Q3SGdQS3FqMVFkbkk2aEdCQzhwNzBRY0ZTdGNy?=
 =?utf-8?Q?myPqR288ciIuHYMGiVcYvzNXt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	grAzEwJmnsWvlm085JX9nUqD93QFR9wSvqJNgbQN6KsK/7JuTEfLJuay+4QsL7c7lwmrlifIpUKyw+uXSpV3dIe/IwPG4SJFQ8+/e0N5gPn5L723ERzUjEh0wxe/XUqdssQ4HUtY9ePau1vELtw4iWmnXImgY3OkCHHJoEfH/w8ePas9jw3ToIeeTDkiwaxkqUTm6xlBpPGRqK4emIj1oyrrhST8XW8Hzy+f/BGKrwrB4LyVYDRDsZZvr5R0+TGIyt6J/10EDwjJzbUn4OLBqS5Dm7L8GXgwxScQfZ/5c5SlHq/OkZcag5PnzmZSRLleskYPqj4bgTz7OzVzs2hcNb9HodcuOYoNiqm8Qya2XjHiXiTeqQx/3GRAVn54PIt+xykswQuH6AzzlwZ5G33Wh4mpPPxQA0T+BHmf8buvc/ekuq2xx0Znrm9VaHz1RfWmIAP9JWuUeeZlTQ9ewvIj+OaY3SJzyjwUn7AfiOnvdmyxxNjAFAPIOO1G9WBPSlj5o+96XwPGjICU46/fHYucOuNI1iZNeGYyupfT1ergfuAy0wEyRgycOfHsk0E9YxZInAyVYGPYg95xxlopgDAQd6/l6KsGxMOdXGlQ1y9Hnpg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23eda781-a2d4-4cc7-d92f-08de16c12e2d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:00:09.5791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkhpfGlY+8wfqH6dmOE0eiPwQrrAuiC88Mpfpy5gqNxsNZuZDmxz9RnFuiZrbT2yWX/GJvbVAgukH0YT8TwgPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF6F1F7CB1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290057
X-Proofpoint-GUID: _s0Kjdw-LR0vEYz6XJL90Y3fEeB4GwM0
X-Proofpoint-ORIG-GUID: _s0Kjdw-LR0vEYz6XJL90Y3fEeB4GwM0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAzNCBTYWx0ZWRfX96L3H8IbfYXM
 jI681rXqWLrgqEiA7NYcTJrp/1xvgfdLXFcoeZsG+azNiQPp1JPMCkxDyWlmEIXDXaPeBV+Xkda
 4OT/037iL+YA5Q+XZCetdkPEAhZeZtw4NLmAqwgWmQntytPClqN31f36+5XtvLXfNYeVXpSCRk0
 rYnnmu+zuXd4t5ZCQh+EVF9NX7kZ0FWUx+9OaABLwfnbzRohMK7TBi9ETQw/epKWNCC7nXLKt4v
 QbkYemqv7NRPmVUYCpt7PzAgpM+HUpJW0bOVBFImVSJmjArzqof0XUKuQmXwCQWld9ML3RezPxj
 oXMU5YKkXZah6LtYAXN1crL5lvkOMfOdc62vPJ0C7m1pHJNzhp5oX1QGmhDM2LIsGYvkYg36vEB
 Aa+8mCYoYTEXGXR9e6VaXlypgovwQw==
X-Authority-Analysis: v=2.4 cv=S4LUAYsP c=1 sm=1 tr=0 ts=6901c98e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=unXpBJUAa9LqQTkRwEgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On Tue, Oct 28, 2025 at 08:07:42PM -0700, Suren Baghdasaryan wrote:
> On Mon, Oct 27, 2025 at 5:29 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > The leftover space in a slab is always smaller than s->size, and
> > kmem caches for large objects that are not power-of-two sizes tend to have
> > a greater amount of leftover space per slab. In some cases, the leftover
> > space is larger than the size of the slabobj_ext array for the slab.
> >
> > An excellent example of such a cache is ext4_inode_cache. On my system,
> > the object size is 1144, with a preferred order of 3, 28 objects per slab,
> > and 736 bytes of leftover space per slab.
> >
> > Since the size of the slabobj_ext array is only 224 bytes (w/o mem
> > profiling) or 448 bytes (w/ mem profiling) per slab, the entire array
> > fits within the leftover space.
> >
> > Allocate the slabobj_exts array from this unused space instead of using
> > kcalloc(), when it is large enough. The array is always allocated when
> > creating new slabs, because implementing lazy allocation correctly is
> > difficult without expensive synchronization.
> >
> > To avoid unnecessary overhead when MEMCG (with SLAB_ACCOUNT) and
> > MEM_ALLOC_PROFILING are not used for the cache, only allocate the
> > slabobj_ext array only when either of them are enabled when slabs are
> > created.
> >
> > [ MEMCG=y, MEM_ALLOC_PROFILING=n ]
> >
> > Before patch (creating 2M directories on ext4):
> >   Slab:            3575348 kB
> >   SReclaimable:    3137804 kB
> >   SUnreclaim:       437544 kB
> >
> > After patch (creating 2M directories on ext4):
> >   Slab:            3558236 kB
> >   SReclaimable:    3139268 kB
> >   SUnreclaim:       418968 kB (-18.14 MiB)
> >
> > Enjoy the memory savings!
> >
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  mm/slub.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 142 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 13acc9437ef5..8101df5fdccf 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > +static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
> > +{
> > +       unsigned long obj_exts;
> > +
> > +       if (!obj_exts_fit_within_slab_leftover(s, slab))
> > +               return false;
> > +
> > +       obj_exts = (unsigned long)slab_address(slab);
> > +       obj_exts += obj_exts_offset_in_slab(s, slab);
> > +       return obj_exts == slab_obj_exts(slab);
> 
> You can check that slab_obj_exts(slab) is not NULL before making the
> above calculations.

Did you mean this?

  if (!slab_obj_exts(slab))
      return false;

If so, yes that makes sense.

> > @@ -2185,6 +2311,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
> >  {
> >  }
> >
> > +static inline void alloc_slab_obj_exts_early(struct kmem_cache *s,
> > +                                                      struct slab *slab)
> > +{
> > +}
> > +
> >  #endif /* CONFIG_SLAB_OBJ_EXT */
> >
> >  #ifdef CONFIG_MEM_ALLOC_PROFILING
> > @@ -3155,7 +3286,9 @@ static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
> >  static __always_inline void account_slab(struct slab *slab, int order,
> >                                          struct kmem_cache *s, gfp_t gfp)
> >  {
> > -       if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> > +       if (memcg_kmem_online() &&
> > +                       (s->flags & SLAB_ACCOUNT) &&
> > +                       !slab_obj_exts(slab))
> >                 alloc_slab_obj_exts(slab, s, gfp, true);
> 
> Don't you need to add a check for !obj_exts_in_slab() inside
> alloc_slab_obj_exts() to avoid allocating slab->obj_exts?

slab_obj_exts() should have returned a nonzero value
and then we don't call alloc_slab_obj_exts()?

> >         mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
> > @@ -3219,9 +3352,6 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
> >         slab->objects = oo_objects(oo);slab_obj_exts
> >         slab->inuse = 0;
> >         slab->frozen = 0;
> > -       init_slab_obj_exts(slab);
> > -
> > -       account_slab(slab, oo_order(oo), s, flags);
> >
> >         slab->slab_cache = s;
> >
> > @@ -3230,6 +3360,13 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
> >         start = slab_address(slab);
> >
> >         setup_slab_debug(s, slab, start);
> > +       init_slab_obj_exts(slab);
> > +       /*
> > +        * Poison the slab before initializing the slabobj_ext array
> > +        * to prevent the array from being overwritten.
> > +        */
> > +       alloc_slab_obj_exts_early(s, slab);
> > +       account_slab(slab, oo_order(oo), s, flags);
> 
>  alloc_slab_obj_exts() is called in 2 other places:
> 1. __memcg_slab_post_alloc_hook()
> 2. prepare_slab_obj_exts_hook()
> 
> Don't you need alloc_slab_obj_exts_early() there as well?

That's good point, and I thought it's difficult to address
concurrency problem without using a per-slab lock.

Thread A                    Thread B
- sees slab->obj_exts == 0 
                            - sees slab->obj_exts == 0
			    - allocates the vector from unused space
			      and initializes it.
			    - try cmpxchg()
- allocates the vector
  from unused space and
  initializes it.
  (the vector is already
   in use and it's overwritten!)

- try cmpxchg()

But since this is slowpath, using slab_{lock,unlock}() here is probably
fine. What do you think?

-- 
Cheers,
Harry / Hyeonggon

