Return-Path: <linux-ext4+bounces-11094-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3615C0D981
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 13:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 719E14F7F84
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF273115B8;
	Mon, 27 Oct 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d+7AHr3S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="txqeZw3T"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF013112D3;
	Mon, 27 Oct 2025 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568187; cv=fail; b=GopSBHsK4x7JWJw5s0KECUjEDPqI3BAQsR/XTR501Ih0FqqZtf1P53Kk6oEYTTKr3Z84hDG9BlkkbRYSHUFBYslsK2XDrUqFHGk6GplHlD6up2NyakJeapkn/Ksx/vYL+Zn0Bp0c9riPBFcrh6MMI+BYjyggl+9bFjk+IzB7kag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568187; c=relaxed/simple;
	bh=F/nU6nfOXNmcvV+/0237clLWHqAc3+iUQqTAg9xBMc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i9NOMDXa3VLc4v4Lr3ejySwKtV706NrXWeoSyq02QTLVqVjxm47EIKZyzcvSaL8BsJE9+HDGQnXhGwSkjiZvjBwt8RndxS8yzYFqSJF/uVq+P/DxEc3NWR8HGgckmWYS4WRzUFr035vudvOYQNzky7LdFMZm3Oa5VByol7wZ0N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d+7AHr3S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=txqeZw3T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RCCJgx014889;
	Mon, 27 Oct 2025 12:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/+GYVzpkWTncbwZTqYSKMk5iKtZQhjZZqJtz3v+YmQs=; b=
	d+7AHr3SIH7TJJmqVVh2hr15ZrGbY5zlk/IhgcoO6w7ye3SMzDLkVQBI2bV3Al6z
	BBKtqBE20YEgDU+RAv52czIemnHFNez+mQl2rMx+dZfslcFeMDbECJa8PpqE++QB
	jO/NafII9jQSplj/g/BWPstRoUMOgWEeFnL+ge80bs6yalWI0ZunezYR4cWd1K5I
	R8nIbL0aTz+hXoLFgVmfSHoTTwlk9l9v92RVPDRap04j44TPprZ7+7GaCMQ71D3m
	uYMeejNQJo5JyDMWvCgzQ4IEjbPSF+p1YhohnccjWlFXR4wfczglz19LRXdgYxhI
	mLsfUSyV3ADuXgXVBl5IrA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0q3s37rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:29:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RAowmv025109;
	Mon, 27 Oct 2025 12:29:22 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n06yhuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:29:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTgIOx5pTagWf7r4AZVvIpL85b4Rh9e+eBvKICr2VIcjyrLTS9pFFgri+n4Bvb0OwVxLTzshVCGp5aq4doISvXFzry+3bYBZYxiORzQfkkanKX1Er68iP7pxj6LTuRJTX8WvZkbVnhJRfjZsfqRb7WzisfgUcEU4gMSHbFP11+9K/xncCDSzOcTz3g0AJf/rmaqtg6F+l7N7HAn14cVoC00k/XvSvuqQltZiqu5xwbo+s89AvKRT8wHPHPULihmLEq8T+KzfGssy4xLqy2YaRvVkkqouf/Z7a6JadRlk0+o2hNTq5ll5JErZOyjM0IuvACyNc9a4bEmi5KqB7coqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+GYVzpkWTncbwZTqYSKMk5iKtZQhjZZqJtz3v+YmQs=;
 b=eQe10zH4xePBnD7Wwrg6St4Fy5fnI/JDy78OdOIP7z/y8Fua96t6oZeahhapvH7eGRF1+A3su7LIR7Il12tsUt9x1/Zj8d3AdaaUhx/EhBs4n7awAC5RrDygaVL1iOcf355PLZJuRlFPygDuOjTOpi+cfMdqvaQWCvQSTFTPKQNYaxVKswu1Aa9eB9wxxSaPJb2oEJHMDbMctMuFRTPpnVKZeHAKgsQy8VbFNz/GoFwlx+JODxJ/RUDQNsR4Q3Y9JeHYKsIzv8Cfoz3zvA9pYZIIY+jvWPDLi8L7QrEPKa0x05N5qSjCGwvmFgJLk95vg21BMMwsqlsrxJMgBi+CnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+GYVzpkWTncbwZTqYSKMk5iKtZQhjZZqJtz3v+YmQs=;
 b=txqeZw3TpyRVKCdhYdwZLWOq16oln6kPFdN7tDbxKU/7dFaD6wEOcsDixXH8w3vdik1F5DkXln+C8sMng1xEzOnFuREBRBVzLWToZVUnHncbAfcXcWrWcfa1Y0Qk8ISN4jO6aFHbRLj/vQj0KGSkjNkKz2e1Wpjel/4i7fjkW34=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB6371.namprd10.prod.outlook.com (2603:10b6:303:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 12:29:19 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 12:29:19 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@linux.com, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V3 5/7] mm/memcontrol,alloc_tag: handle slabobj_ext access under KASAN poison
Date: Mon, 27 Oct 2025 21:28:45 +0900
Message-ID: <20251027122847.320924-6-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027122847.320924-1-harry.yoo@oracle.com>
References: <20251027122847.320924-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0103.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: fb263cbf-b559-40e1-e641-08de1554736d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SLD3D1vH3FJ8EcbNa9epUf3QdomTVjbO/zrfO6Z3sN16whgxTzsxWEto/ld6?=
 =?us-ascii?Q?PMKy7+zLAVW1r2sJKGs9/Off0DSVvlLrhgalPLekQkcAWJSMRUJFrMWpPOvg?=
 =?us-ascii?Q?Q4t3jLos3/ARLOHx1GOUUrotxo6rXf4wtas1/d2CiMgZbHWDhclZ34HUVv5D?=
 =?us-ascii?Q?Cj90vqSHmiMPsiTKe72Nz9PdIHY8C16N2TgfdkUB3oj4ZIVKaqL+j6E8B20d?=
 =?us-ascii?Q?kc4xXiEiSM3Q/3NrD0BXCzXAxgBULdXtZO9l6mmgc+4lFp86BL8ije4XSVU2?=
 =?us-ascii?Q?jrhi6togKT/e75DzYKBtLHivTaAZz5uXGS71SIvq+UGhUb0A/TLqaHOq/71L?=
 =?us-ascii?Q?Va8sTcpuK01Ux5bFt4SO59KmqTEnsqrzcY8aV195voLnEeoAGISYUtuX+sqo?=
 =?us-ascii?Q?GeuTi7Sy8SHu5K4VcHJujh/gRWuM6ODq99LxhvDAT0eej54WjILWLYE5bFhg?=
 =?us-ascii?Q?dQRHGaCfCiZM/TEpO2rfo2f699pjV5IVNISCbantQ/slnrYqqyu1byovsGAX?=
 =?us-ascii?Q?cMdqIr9ZKmHSmEaLti4SQuZJ7ei0Yy7UrN+LKLL3uChTWOoE4HXpxNkw6Ifj?=
 =?us-ascii?Q?x7luVtZPvk/vsq8kVVR9PomMh7r84BhNThBm4vjOaMa4ZQA+C9OEPDfwsBWK?=
 =?us-ascii?Q?VEVz6vzh7KSRN9x+HOni2FEJRj67uHaoOuSUsfH9G+AhYdfSW/Do5gx1+nBJ?=
 =?us-ascii?Q?4KjM/bBnE9JivB9yn5HZ6KrKTXd7F7O/fr+JvcvvCvMlPFly4xOpycrMlUld?=
 =?us-ascii?Q?XNodhISPlpa4r4wXz5rf91wQUFFhQ9dpEGR1hiIpHwkaRiRHs5Eic0/4YR9N?=
 =?us-ascii?Q?RSiUBvaV8HJTj+oFJzFxhIt8Kq0QRO/zYdLFlEIXws+L1sWOhkjOTrAecOhY?=
 =?us-ascii?Q?9Vbx83CfO0xp6bonVMNtlzWlFP5uedfBknEDUdWMpMhbSCdlAikli5K2w8ft?=
 =?us-ascii?Q?JcMBbFDQMI+SKQ2EKaalF1OyLi17jcZB6JIZ0LLngZiweNwYPAx/grJrZUlO?=
 =?us-ascii?Q?3JyF1sL7ZV96dsGpwM9ss0HKAJlQNFbZOnRfR4vI/prq6QhDMv+GJgi8cT81?=
 =?us-ascii?Q?X0fz9AmmpKJlNkAXZ59bHawQJWHCvC8NhCz7e7tB/2g1KlWZjYdmMc5vip7M?=
 =?us-ascii?Q?9/2xDUxXPYith233CxiUljDv0IjGDsK90uiLT1gGNdyNjsB65gjLWWewCOUd?=
 =?us-ascii?Q?9V4k9x5+MJ1hj0cm+ABkaScQGWSdQfTMxqoK80VZBfppxX/XYZavTlUqLsBo?=
 =?us-ascii?Q?QZgC++NFacellGDFc0h625jCVT3hDfMceZy35OxCXQP+RcFgP9g+5Ws8vORj?=
 =?us-ascii?Q?Xg5jVkSlxgZZU1BePk9kO9G0lqRgmnRrVt4JzkHk6UaYMdQTAusLGW6pLliU?=
 =?us-ascii?Q?2KJzKMGpZb5j9KNh5tnkeB1VStxTGiHt6MwqflIm3dKE1B9KFgT8kLNhaWsD?=
 =?us-ascii?Q?muTkYf3Ey3QPp+GayTDM+kmb2bABhlY4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BIF2XEUek5R2/qoZLLQbYlVYSLZf4/UAnqgE5xXMZffV0qUq+nvDKX3U9Wz2?=
 =?us-ascii?Q?3A2MoWoEl+qCvibrL+LFTgyeEPNztIfnrNnVyaeEEj7ZM9ed4rCNp4irBd1u?=
 =?us-ascii?Q?L20v8Ejls0kGT4f1itD+Uvza1PqVYrDyKLG5v4M/e2lzPVjCY+zey78xafQj?=
 =?us-ascii?Q?sqzrqB9gjnGL4CmZwS1WIj5s2iBkimInCUr2U2w1PebBQHx7fW99u5HEIwEJ?=
 =?us-ascii?Q?WbzroVHqQAz5tPW82iTuFZMbBeY5v5Y786w6uHrbBBoS08Did/pSgknWk588?=
 =?us-ascii?Q?InFVSgazj1kEnEk12xg4C+qxgf5Mw08tVjNZmXdG7JJ3MytMk7r4ydNmuyZM?=
 =?us-ascii?Q?Gg78qbBytn+lnyHeOxiV2U+Y+kv+2dfVysvu+xuUSxU1JJmwIhBgeNCFEnbg?=
 =?us-ascii?Q?2C+0UVkKueuNuNr4qQuL7imKitMkd9i0+MkgFs2WTeUSKEPjHTUmlzsu6fAz?=
 =?us-ascii?Q?wr704WEUwvxt2wNn7A4C4K0nmBGlWjvtfMjIa75IWOtIsTfJswzBrFu1+oDn?=
 =?us-ascii?Q?FVWz+i314S3+z06twgAzCOIgWs5ArK7t4UlERJ8fOTDMKdsPtibkvq8As1qO?=
 =?us-ascii?Q?zLWrXNIuIphIXuX5v4P1x/TxAABILoyGFaiyl3wJqMJT8LcJIowgQe3UHlbY?=
 =?us-ascii?Q?8tZN2veiwFkS8aOlBUvWWud6MFctik55SKqDfdmYi36XkDUvGadEmeV8hxiv?=
 =?us-ascii?Q?LHA19nzhcEVZIUrMEt1D1w013S9dPo1yR/hxPCMut65lfqcvVq61LoRxfkEe?=
 =?us-ascii?Q?k6kvJjyKCYyk3ioJeYTsE+H+4GRfJLa5a02PynEsbxN0O9p1fTdah9mH9+ww?=
 =?us-ascii?Q?AL799iyQMmaaQLe5Ib7O3UBaCA1of9WpleMMDy2WRSIwYWAAt2lX72y5y3SK?=
 =?us-ascii?Q?LkV5SsRraAxGLbjTUGC/7N41vsYyIc+eZTAnnCarfYhPbvMbqI+SmQDftKcM?=
 =?us-ascii?Q?aWgdw7F/o1ITr302R4+rxGm7I3SZl3q9wOyDssmKHK9zzHZ1be70KQEedwUJ?=
 =?us-ascii?Q?Vw03OgM5lRXNef/Ik8gt1J96crZySnVT5PfIqDe9Sj9li3EeBGt+mShBaFIO?=
 =?us-ascii?Q?YQa7ikPUVz6bVE/jtPGWwNZ6oJkbZDiS8Xqb/1jp9XVlFokx0V3itlf+A7Rg?=
 =?us-ascii?Q?xnJmVLc1FazsPUvLVmXfgMwXZDbtqIrYanWwd2QfAL91jMVVvZOD53XoNrnO?=
 =?us-ascii?Q?6W2unXukfVaGOxcDKhNWobTncOiMMBKwawbBrr+Y6U1HSIhzXIel48IOQ21p?=
 =?us-ascii?Q?0iMERmtveMRW2ZeBUpRDxbhdyRQQuWbUeZrfD8lWKIpomlxlNDBPtRi28UIJ?=
 =?us-ascii?Q?buXBzre2u/ruR8JP7NlwjXYBFq26fLWpHFoOM5ZzBCIS8imgCJil9Sb6CFZg?=
 =?us-ascii?Q?GflYMoyugFkWtfF0G/T3nGdZnbdAySrViyaBA0HLFb2Zr+rZfI0n0AuKaIrn?=
 =?us-ascii?Q?Nlr9dIC/+AKPTfV8iIp2XDJ9kqSgeBmW34VYRI8bMkBff2s8ykkPMRTwLuGu?=
 =?us-ascii?Q?SKs3sewu7Kqnbyo2DdVwu7obUF3oTnz+QRHVi0M2yREtpEOgE0/YIA5SQiB1?=
 =?us-ascii?Q?Ocl+mQ2PLmeetErWJyx8yY4dFvxvqvpfKWKWukAJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XjMzPmZ8jv9D7XGHyk5z6SDwi2lK+TZiniUF8FF9CLIjvZG70rTInASPdzRYhV159EOy1v6Sw2HOheu46rxGG5OFjr9px5JhonWWu0ewIRl5/g7nKWrfrmDkXxFMlfRFEW6e2IaRaNPDS8yTYAHSLrhdFjM6auQUX2vYes6D3Jm3VQIFHLb2furirrxeCjgVfYKysmEYsZtXKg97FK+Y481V+M2+RyDPu6mR7SugLanEG3p/OThtD9RFoPikNDi7q/FzDBhW6GMJovODTgsBm6Qy63UAn0XDekQL4JokROoKv7/kShp6DphIuPXAvMLR4Ns3xj3IocrInrxXEr6QTP3DKLYkNhWvqLPNUisrjqLrVwwUim/r/Y2sNWtwiCCKeS2zZTas1TUegf61Z95g+kKH0hQ6PpW1MSR3flGYZiyoSEdqdCwAXef6W4yn3Wy4zGPVa9tbp2lW/InmaIXMKcv7WElTFjSQx0sNQ6H0YbQGI3IWxutcg9TxCO+vhp8rnWWCjumdohZVj1cJTTXS44C9/NPGi7Eybgk75ogOJo3RcIyrQyoPEIgYUQ4fSwJJkTnbKu5MTeq4ZUbPnAO3sG+UdfIdcSpWYZWnsdrVv8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb263cbf-b559-40e1-e641-08de1554736d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 12:29:19.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxecLH+iYjyh4x8DWlLIaw74l8N40suYdhVJ2d6loH9zqcQvzArJT2FeBEkGWeLetg1qv7Nn728PSb4IbW8gVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270116
X-Proofpoint-ORIG-GUID: hkK62jZd72RCfJGRsuJQeDe8SmeanE-E
X-Proofpoint-GUID: hkK62jZd72RCfJGRsuJQeDe8SmeanE-E
X-Authority-Analysis: v=2.4 cv=Q57fIo2a c=1 sm=1 tr=0 ts=68ff65a3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=T5WUlLNADvwsp-5gFyEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAzMSBTYWx0ZWRfX0YPqUPwVbZ1S
 Lrbt21nssJaTKeX2BBHovRtq33L+086APuHcUbdCjzL1AFWY6ZYKTvhFCc/Wawq7WdRA2+57xmQ
 qt8fbxUMiDMomfW92s3b7BZ0WgbVXWiEoqeU/ZF8j0QYXCcMyRtE3e+5U6orRsjxQA7BjHEAqFL
 OdjW6XhtEE+vVrMSUJT5f7i1t4bul7c2ncS92+/aURYcsE9BwodJJ8C/5pL5men+sJDIVm20Wk1
 5hDd6bJuLy3Got6nKBda2rJuGrnzYEc+vIEVy+OthgwCPzCvmvrTWMtGCT6BCZfC6exngOjZpah
 sceK2onwd30LmVlYr0irtq8Ejk/k/EHkiHdO10gxAAGt6Bu0jJ7hkl+Y+VCNSKu5ylbehXLe3C6
 tmPZV1hWK0nGi3VfqRD/H0TH0wZ0Tw==

In the near future, slabobj_ext may reside outside the allocated slab
object range within a slab, which could be reported as an out-of-bounds
access by KASAN. To prevent false positives, explicitly disable KASAN
and KMSAN checks when accessing slabobj_ext.

While an alternative approach could be to unpoison slabobj_ext,
out-of-bounds accesses outside the slab allocator are generally more
common.

Move metadata_access_enable()/disable() helpers to mm/slab.h so that
it can be used outside mm/slub.c. Wrap accesses to slabobj_ext metadata
in memcg and alloc_tag code with these helpers.

Call kasan_reset_tag() in slab_obj_ext() before returning the address to
prevent SW or HW tag-based KASAN from reporting false positives.

Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/memcontrol.c | 15 ++++++++++++---
 mm/slab.h       | 24 +++++++++++++++++++++++-
 mm/slub.c       | 33 +++++++++++++--------------------
 3 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2a9dc246e802..38e6e9099ff5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2570,17 +2570,22 @@ struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
 		struct slabobj_ext *obj_ext;
 		struct slab *slab;
 		unsigned int off;
+		struct mem_cgroup *memcg;
 
 		slab = folio_slab(folio);
 		obj_exts = slab_obj_exts(slab);
 		if (!obj_exts)
 			return NULL;
 
+		metadata_access_enable();
 		off = obj_to_index(slab->slab_cache, slab, p);
 		obj_ext = slab_obj_ext(slab, obj_exts, off);
-		if (obj_ext->objcg)
-			return obj_cgroup_memcg(obj_ext->objcg);
-
+		if (obj_ext->objcg) {
+			memcg = obj_cgroup_memcg(obj_ext->objcg);
+			metadata_access_disable();
+			return memcg;
+		}
+		metadata_access_disable();
 		return NULL;
 	}
 
@@ -3197,9 +3202,11 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 
 		obj_exts = slab_obj_exts(slab);
 		off = obj_to_index(s, slab, p[i]);
+		metadata_access_enable();
 		obj_ext = slab_obj_ext(slab, obj_exts, off);
 		obj_cgroup_get(objcg);
 		obj_ext->objcg = objcg;
+		metadata_access_disable();
 	}
 
 	return true;
@@ -3210,6 +3217,7 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 {
 	size_t obj_size = obj_full_size(s);
 
+	metadata_access_enable();
 	for (int i = 0; i < objects; i++) {
 		struct obj_cgroup *objcg;
 		struct slabobj_ext *obj_ext;
@@ -3226,6 +3234,7 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 				 slab_pgdat(slab), cache_vmstat_idx(s));
 		obj_cgroup_put(objcg);
 	}
+	metadata_access_disable();
 }
 
 /*
diff --git a/mm/slab.h b/mm/slab.h
index 22ee28cb55e1..13f4ca65cb42 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -591,10 +591,14 @@ static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
 					       unsigned long obj_exts,
 					       unsigned int index)
 {
+	struct slabobj_ext *obj_ext;
+
 	VM_WARN_ON_ONCE(!slab_obj_exts(slab));
 	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
 
-	return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * index);
+	obj_ext = (struct slabobj_ext *)(obj_exts +
+					 slab_get_stride(slab) * index);
+	return kasan_reset_tag(obj_ext);
 }
 
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
@@ -625,6 +629,24 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 		NR_SLAB_RECLAIMABLE_B : NR_SLAB_UNRECLAIMABLE_B;
 }
 
+/*
+ * slub is about to manipulate internal object metadata.  This memory lies
+ * outside the range of the allocated object, so accessing it would normally
+ * be reported by kasan as a bounds error.  metadata_access_enable() is used
+ * to tell kasan that these accesses are OK.
+ */
+static inline void metadata_access_enable(void)
+{
+	kasan_disable_current();
+	kmsan_disable_current();
+}
+
+static inline void metadata_access_disable(void)
+{
+	kmsan_enable_current();
+	kasan_enable_current();
+}
+
 #ifdef CONFIG_MEMCG
 bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 				  gfp_t flags, size_t size, void **p);
diff --git a/mm/slub.c b/mm/slub.c
index 4383740a4d34..13acc9437ef5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -973,24 +973,6 @@ static slab_flags_t slub_debug;
 static char *slub_debug_string;
 static int disable_higher_order_debug;
 
-/*
- * slub is about to manipulate internal object metadata.  This memory lies
- * outside the range of the allocated object, so accessing it would normally
- * be reported by kasan as a bounds error.  metadata_access_enable() is used
- * to tell kasan that these accesses are OK.
- */
-static inline void metadata_access_enable(void)
-{
-	kasan_disable_current();
-	kmsan_disable_current();
-}
-
-static inline void metadata_access_disable(void)
-{
-	kmsan_enable_current();
-	kasan_enable_current();
-}
-
 /*
  * Object debugging
  */
@@ -2042,9 +2024,11 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 		struct slabobj_ext *ext = slab_obj_ext(obj_exts_slab,
 						       slab_exts, offs);
 
+		metadata_access_enable();
 		/* codetag should be NULL */
 		WARN_ON(ext->ref.ct);
 		set_codetag_empty(&ext->ref);
+		metadata_access_disable();
 	}
 }
 
@@ -2245,8 +2229,11 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 	 * If other users appear then mem_alloc_profiling_enabled()
 	 * check should be added before alloc_tag_add().
 	 */
-	if (likely(obj_ext))
+	if (likely(obj_ext)) {
+		metadata_access_enable();
 		alloc_tag_add(&obj_ext->ref, current->alloc_tag, s->size);
+		metadata_access_disable();
+	}
 }
 
 static inline void
@@ -2272,11 +2259,13 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p
 	if (!obj_exts)
 		return;
 
+	metadata_access_enable();
 	for (i = 0; i < objects; i++) {
 		unsigned int off = obj_to_index(s, slab, p[i]);
 
 		alloc_tag_sub(&slab_obj_ext(slab, obj_exts, off)->ref, s->size);
 	}
+	metadata_access_disable();
 }
 
 static inline void
@@ -2394,8 +2383,12 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
 	if (obj_exts) {
 		off = obj_to_index(s, slab, p);
 		obj_ext = slab_obj_ext(slab, obj_exts, off);
-		if (unlikely(obj_ext->objcg))
+		metadata_access_enable();
+		if (unlikely(obj_ext->objcg)) {
+			metadata_access_disable();
 			return true;
+		}
+		metadata_access_disable();
 	}
 
 	return __memcg_slab_post_alloc_hook(s, NULL, flags, 1, &p);
-- 
2.43.0


