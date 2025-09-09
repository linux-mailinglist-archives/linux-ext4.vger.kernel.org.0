Return-Path: <linux-ext4+bounces-9858-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CD6B4A429
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 09:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E173A6BFA
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 07:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710323BD13;
	Tue,  9 Sep 2025 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FtUJMhr+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zKZYtD5P"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507C01D5CE8;
	Tue,  9 Sep 2025 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404179; cv=fail; b=VylIWjR6Gx7j4571Gd01Sy+B8e5IAfTOOlv8vZv5iR8dkcnLx7GIgKBqJZ3KaSbU5yI1cY5MV1Aynk4qjRjw2lpFjsSPUa0Y/G7SzIOXWuR8ngilXUcvi4/pPtfJBGJsiERz9yfBF070VG4ezK7QOIw7p8X1OqoYyBNWn/CqdkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404179; c=relaxed/simple;
	bh=wzJ0wWf87OmSoPzFnnhF2nXQZhBzSRdYWSlaoJWZJ/8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UDnJskLUSJsTupGyL1s7OR5io2DoUiLvQtvwAcwVadLOVZNamOwsS8YCzy10+ZM/C5zFKzc9QnKasbrUayczHzhnocmX4yTJGvGd+VIr9+8j/C7GaQ5dYKimYCqdwU10Ak4I71P+epKA+/934AbVMqzyMELG+hhx1uubKzXO7eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FtUJMhr+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zKZYtD5P; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897fprq022109;
	Tue, 9 Sep 2025 07:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zkYdBb8el6XF7aqXS6FDTRln7Winasm13lsj5YhkEFk=; b=
	FtUJMhr+PWodC9Eg8+SsUi3CRcRUcKrb0148MVlsOUfSjMABmXzoTlXtEQy3+7aL
	B42gQ1fZnACXdwgXAOMgW3eCwbbwsDt6cF9A2wDNT46oprwnNfI9L1VtEbm0EypD
	yM6XsNTVzqnr29IuU1HAl2Dx6QdSjRG6FL7bJPVjI8L2h9NcbsruqDKMTngWFVG9
	CAAV+ogSfkbXEnkHXb4b9ZVpVpl4UMwjw+cvKBI6RVoIQMintIBS6vZ4S29WWQZM
	HBcXBMt/jICYnUEBthkIBFIOgpgBvMf+4gZUIYijnbtgAGAj6aIgTkiIAOyM+Zm6
	ZU+EBm5fH4JVpc9sTL2pBQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 492296197y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 07:49:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58968fTv025922;
	Tue, 9 Sep 2025 07:49:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd98wbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 07:49:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPJHNdFt42AlK6iKWJ4UaeBCeoNlj28w79D2hUMYf5DWCrRJzVsVs77Rfm4dCzDiTVNDI8X/zHPjlHFzYCG4s7y0EtuNCP+ZX6Zad3kWTuVoHfUbqdFro+EFkQvSXGWGLHl0cPcLCnE3YV0kHeXizyR16s70iAFx1ZnId4K2FVxogWi5gTrv90RaSp9qRH48SJAitKiuYQcu//tyV3NxO1fOvtnWroFhIPOa6pJpwd3bTjiqFKYFY+AU/RUO1n3Zdliqcbi1lZwbatSDy61DHynlJ7NpoI7BuLEEyKG8V9duKbJBH/pf1T8jIw87Bq0gMWi9jx3vACyqlD8O/2eXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkYdBb8el6XF7aqXS6FDTRln7Winasm13lsj5YhkEFk=;
 b=B8e1X+hh/iXFmiy4VUHfQYS8dyPw0ZtUtcARbG8lRp/RlmAozRFAqVLlWdIkvOLrcVlXCs8EV/hQ4HKMn/21EmNCgFq7cCU31/HjcYs1sqyohzA8tDIs+tdP4+49kJetYOkIm4ULyWReXuixX85RUJnuJRT28n3/7Sr42iI2CYts0zumoIQhIdEHf6vFlDAWFTQOLa/S26qcdUg/FFcuMz90Ftua6MhCjvwGTW/bJtdEek0x3tzWESR09KhBoyPNGh7e73NyuW+S8fZ1wm6kb/R+x6zMYOEzdYwpDobWDflNbXeINnzpm9cL0X/Ye2wXG+7MEOA4Ul7UwIw8r8Ez0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkYdBb8el6XF7aqXS6FDTRln7Winasm13lsj5YhkEFk=;
 b=zKZYtD5P5nm3058NEJpK7pDQaqTNO1PfL/ltdjVNviJ44PsKwixa7VzRaK44QReWKyyWUOpxY2NEzGs4wj6+jh0g52JZisCCsQPdeyFOBgtkA9x2jMH4LgIl+3mfGbsTIgifxJTYPHkxnOH0ZQgbO+ZxFu5bns4wKEgqUNMxL4c=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by PH7PR10MB6601.namprd10.prod.outlook.com (2603:10b6:510:205::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 07:49:21 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 07:49:20 +0000
Message-ID: <ab2ff75d-12b7-472b-897d-d929518e972a@oracle.com>
Date: Tue, 9 Sep 2025 08:49:18 +0100
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
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aL_M0X9Ca8LgTIR1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0500.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::19) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|PH7PR10MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ecee20-bc3c-4398-b09b-08ddef756302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qi9pZXk3ZTNieUhXNlVsSENzMVJLL0JxOUpzY2FQZnFsRGlBdWZtR2pCT1Rq?=
 =?utf-8?B?eVJ5VEVNMDZhcEZIbnJaREFNc1d4UnJhc3B0cUYrcklRaVFhZGxZR2gxZnIx?=
 =?utf-8?B?V0FXY0RiYzNKNGllNWxRYWxmSkwwZFAxcUtaVThBZW5lWWZGK0lRZVhJaVRQ?=
 =?utf-8?B?ZGRMS0xEU1Y1SWk1dTdNanVwY3Q0Z1JicmVQOFN4NXZXaG41WjJSQ3I0eEg2?=
 =?utf-8?B?TjN5cStQTVViczE2NWU0eU5JRlkreFU5VWlNOE1WZ1dXSHJ0WEV6QWpvVXVY?=
 =?utf-8?B?QlJWQkNYNk8rQkJtL1hiVyt2NllsMHlORmhmbDZ4OFpDVGpnZ3doMER5OVJU?=
 =?utf-8?B?RStDNGR5YUNRQktYL0hMZlBlSmZ2b3FVQ21CUnU2dXEzVDhUYkpHSkIwdjZo?=
 =?utf-8?B?ek1qd09TcHRMbm1KL3FRMHljWGpKeDNYUWE3eW1FVE5NRVdoK2h0bFNqV1Ez?=
 =?utf-8?B?aTF1NEd2UnlOckFKWGNoTFN5dEVLUTgxSVEzdlhIZ3lUTDEvdk9EdGcxZDBB?=
 =?utf-8?B?bGo0cXQwVmlhRC9IcjVPbU5JcHRsMVFxeFBUMElTRzdhbnRnaGNnVGpkVzc1?=
 =?utf-8?B?RzJyY1VjUjFRT0Q1RVdyNDc2QzBYczh4RFRFM3Q1RGFZNUJ3REhsdU45SlRa?=
 =?utf-8?B?dVA4cGFTT0QxdHRCN29HVVYxWk9naGNsN08wTEl3YTBnZzBjV01LL3p0dDRx?=
 =?utf-8?B?cXFQUjAxRG5TU290K0phb0JGcDlJSHdXOHN0U0VZVGpFU3B6M212NVlFM01M?=
 =?utf-8?B?ZmxUNWM0a2lUZGl4QllIMXhyUjZqcDZVVGU0cnJjOUdTTU5NaHg5dUU1RWEw?=
 =?utf-8?B?MThTWWdKOENPeHZkTlNGQ0NoaE5pTEZtUnBCa3JrN000eTlUL0ZVa0h1Q2hw?=
 =?utf-8?B?VWlOVlVvRCtYam9iYzJZV2R6MXdXVktwME9aNlp5bmxxMVBlY3ExaENPV0Q3?=
 =?utf-8?B?bGZKUU1qdFBJZytkeHA3QzBKTUFjaFFnS1YxOEhRSG9MN3cvMGJZM0YrZVpZ?=
 =?utf-8?B?T3hXNlNwZnA5MzFUeXU3YUJNU2orVXorREVwZDJpUzB0eHBRNk1sUTVVWmJW?=
 =?utf-8?B?SlBvNlBOa3dCY3M5aFkyd3hTMXZhaE1XUVRvSVdNeTJ6QTJVSmk3eEhkSEV5?=
 =?utf-8?B?d1RmY1NrZHhDTjhDODYzVkJlcG5KekJUbGMxOElqZFdXbVAzcnVFZGVDMUlh?=
 =?utf-8?B?NUN3cDZYanVLTVdLYXBwK1BKUzErQ1U5bDRZeE5aZUhybFFGNnowK0NRZGtL?=
 =?utf-8?B?RTRPeEZoNkR2d1duZDJmSHV0NVdXbld0RzFZa0l2MlRLRGlEUWd1ZUkzUDJ1?=
 =?utf-8?B?WVowQ2drcUVCVWhYOHBTdXBBUEE2WVBCSG1tUDNDUHJtNlUwbHhHZVFpa3JY?=
 =?utf-8?B?OGVpTjRoZUJjR0Z1bU0wMVNocDRCNmtxTEw0WXNjT3NkTmR2REIvRm9LYm5Y?=
 =?utf-8?B?S2toSGRwNHNUbGpjVnN5SG8zRTdqYUhtalViaDZ6RW51RXVlaEtRaVp2czFP?=
 =?utf-8?B?Y2RTN1BiUkhOVHIreHVtSzNvbmcxS1p3QzdTazBJaWJCaXVkemJkQXFiN0Vm?=
 =?utf-8?B?cHdFSTRMeWVUNngvTTdIdFlJVE1jL2ZLK01QRW9weEdEUmF6NkEvK1VuNk40?=
 =?utf-8?B?RjZ5ZEdlcThiNk9yMW4va01rRkhUUGh5bnZoVUlGY3ptZUdZc2tPZmIwK1Vh?=
 =?utf-8?B?cVgxcjB2WlFiK2plV3BxUXVFY2hpQWlZbVhqV053K1h3NXJvd2FQT1hQTGJK?=
 =?utf-8?B?RDBhbklOUGMrVjJpZVYzOHBQeEdmL0twT1J2OHdTQzN0TVVkWUhrVWRaanMr?=
 =?utf-8?B?bkhrdE11T0dwMGQwVEZzeldUMnVrTmJqSm5ab0Q5VEl4ZWpWakNvV1Exc1lC?=
 =?utf-8?B?SlhuWXp3UjZmbk1pNGttQWVMcEd1TGVxUk1mYnlmdmJEV0hTUzhkOWhBWVUv?=
 =?utf-8?Q?gmiEhGkySOk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVFIU1drS2hqVUMxZFk0M2NJRnVjNWRSSDg2ZlFGZjlUV2xUbWFRZ3lwMXQy?=
 =?utf-8?B?SVJtQVlzUGFVQXpUOVo1MXdlQVlSb1AzVVVZMUxIbmdhSVJ2bE5nY0RDdkZ2?=
 =?utf-8?B?Z2JpK2d0NUtuOUtWczNnU3REMWRESmxzSUcxQVo0Lzk5VU8zOU1FMVpZMTJk?=
 =?utf-8?B?MkFqWW9pUkliNDQ5WmN2aFkzbStxL29OWnFvK1lkRFdFTFI4RkhHNmJTRWQ1?=
 =?utf-8?B?MXVudktRYThHNXFTV01EZC9zcVlHZFRWWWRoMWZlZWdnek5WNytPb2xxdngx?=
 =?utf-8?B?UXJsSkRIWlQvNExQY0hzQUxjbWNHU2FwWmtXU21kQkRGRTlRd0RxaDdDU3hj?=
 =?utf-8?B?cWJ6SXJ2cGJYYWVoMy9uaUtQaEU3ZlJhTGNnS3ZFRURRcExaUjlPMmdFbmlN?=
 =?utf-8?B?cDRDMS9lSjJLVFNLWE91NmhNck5wdXlZZGY0cjdCbHVJcTl1bmRFbW1pM3Ni?=
 =?utf-8?B?bFhya2FLdnhKWGkvVVk3USs3azNYejl0QjdUenBKaUNwVjBoWlpZZnJmcEhq?=
 =?utf-8?B?d2p3aVhydGtjQklkUGwveStiNmx3WERTL0ordU5jUUlIUmx3cE5rMGNDc2li?=
 =?utf-8?B?bVYxZTRFMzlPZHNnWjY1MnBMUzVhY2tjaEJ2NzVMaDU2c0p5UmQrcWlQYWFz?=
 =?utf-8?B?eWFETWtPWTdpMUJrdGVPa0JXUzZrQkNuUjZtdHlRZ1g1MVNLNkNzajFmaVJG?=
 =?utf-8?B?TVlxRDFMZTVBVDRiZ3JvbCtRbU1CWXlVYUFUM0IxQU0xOE0rVHNVT1h3T2to?=
 =?utf-8?B?NkJxSEVhSG10M25Ha01lMXJlUnMzUXpuRSt2YUhVTEJpVGo2elk1VlliUFJU?=
 =?utf-8?B?QVZrcDM0N1V0YzZBVHFZTVMra0ZQQVpLamxoSzRreEl6TGJCSmZZcGpabFkx?=
 =?utf-8?B?YXVBMHF3REFQZXJsbFNyR3ZSdnBMWnlJUVFVMENZeTVwdnpLVE93bmxDQUF3?=
 =?utf-8?B?QmRKSXNwT3pOZU5HTnU0a1BNbDNGbDRQdjBXSGl3cG9lYStwaUdGWTFxTFNK?=
 =?utf-8?B?cDBBWlJrOStXeGtGWjZnSmc3bUlYZ3g5Z1ZXWW9TWVlBemxYakpKenBaM2hO?=
 =?utf-8?B?M1hEWUdtc013ekNhcEhzQzhOMzErczNUZzNualV0SncrVVVFMUcrMmoycGZW?=
 =?utf-8?B?T1lCTDlDMVBHaGgwOFRvSFZxWThCNDh0Y2hPRkFvS3YwSk9ONjZnYnF1dnRZ?=
 =?utf-8?B?bWtmSU9vVGhVMkwzT3RiSkErak54NlFBNmUvU0JrMWN6M1BEaXZZbmM5aTNQ?=
 =?utf-8?B?RjFpYUltUUNTcndiNlFCSzVRQ3c2byswKzk0OHRZZTlJTjVIOTVFK29Qekx4?=
 =?utf-8?B?T2tDM3Y2anA3VE9ObXA1OXdVbTAwSHZZMzNaSnloTUVsWmNBc0tTNVBiYmd1?=
 =?utf-8?B?ZktRbnF2bElRNGdBU3NRSkNoRkpzZHBwMjVQS3J4cFk1b0hIZmE1cERWWDVP?=
 =?utf-8?B?bDhncW9McStLc3EvL0xmQ1k2VS9sSFZ2VzMzeGIzWUlldmt6SEdBQXhwUzk1?=
 =?utf-8?B?Z0ZKRWZnZHlvcmRObzZ6a3E3Y1g1cWN1ZHpTemhORXJGUzh4R09ja21GaEZ0?=
 =?utf-8?B?aGovYzZVS0NPTEVSUUhEb0tVdVdLa0xoc25GZ0tnOXlaSjlHTWFCWG9ZTlhr?=
 =?utf-8?B?UDg3a3ozS1hXaG9VRi9BYzV1akNtTTBpMzlrS2dwNjltMXNEditMQzN1QzN5?=
 =?utf-8?B?NUdtaXlqNXBtTC9VVGw1ZDZSZERNWFM4eWc5TVh2MThsVUdQdnNvM0FibG1q?=
 =?utf-8?B?RExhMjBXSytZSis2dUIxSnBWSW5ISUZRUGJzWU9tODczczFBM2ZOUGhNdGt5?=
 =?utf-8?B?UFlrV0FoSnJGcTNhclNqb2NPdExRR0E1QTZTREROcndDbUYyK1Z2NDJHTGlY?=
 =?utf-8?B?MEZCb0h2K25DczZCQWZIT3N3VWFPTVBrMzZoZXF3S001SXhLZlNVN2todVNU?=
 =?utf-8?B?Zk5xakloamc1M05TS3pkYTd2VUs1V1lUU2tJK1RWSTZpT3RiVmVBc015emQ4?=
 =?utf-8?B?TWp2VHFuaU9FQjRTdGxTejRUVk9jSjNZRDc4QkxTcGtnNlRkaGUrUWIwdE8z?=
 =?utf-8?B?SnVEL09wby91VHpXT2krYVV5QUZQSHNWaHVkdFE5bzhKMitkSnN3QmRGSkkv?=
 =?utf-8?B?MDFoMnFSKzlDemoyOEx2d2dFMCtsOWptWHJVN3FQeHc5cWNpMEZqNityQnVI?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NG/G09tFoHQp3mQFjG/XgJ8HTKqFVzZThJJ0TvmEn7OVZ6X86277+hLR+SlivlO2T7CfWAKhgyw7VU+UtFrF4cEui4Lc2BSZplrPJC4v7HDVg2sy//BjHHI83pUvMMOyED5h4UZKLL3oEqf+3j7UUSNEZvmZGQdyyIdkhGr51AUIBjOzWN180H4Z5XEwpRtZu1kH50/8jc7P+FaRmJo7QzrF9kPvNAGbA6qhmDdh9kdIJNDvBUwPiz+DmhOTBsQm3XqYoMuenEed69I9vWuDOx3f2YKFPqJupDy97dvAIeiARjZGlS9HECvN1nzVqU0byGUu6J3jjAHp0+pBdAnbrbu2tjAx1xubrN+ulgL7SEebH/OdzlmmwIjcGI7XPGoE3BuznTA0KpTKYd8ixjvWnqLfF7fIeS7gsV5qomKiycP5HLKOQ1+VruMFgymHx6/7G0K7d8x1mypyz1C4dEZvFKzHRQZS5CERpUF1jUykycyLY5ZSPNhpKVmXzIGpafk/3E8mWm6IjUW1cBzY1SkhX4RKzMHk+bJliaNmpfYzZTMuc8zH81iEUpKjfl9T8PM/76LukprLNuiWqSe2BvA+DbBrvDzWUMLk9cciiDz0QQU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ecee20-bc3c-4398-b09b-08ddef756302
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 07:49:20.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bcsb2EUs6tmWh639BrBa3TozexrOe1IM/zFPhk92vaqtUL9F5kJNvZOqBU5a6UFCcVbiJbv0G0VHO3Y09FhaXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090076
X-Proofpoint-GUID: 1xh8RFTSfzRmai6ZoF9Eha8RoGZCB78m
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68bfdc04 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=SDlvZK-mF7qAvao7DHAA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13614
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfX68V2atxDB1Hl
 I9vtOOTYgRsGN6OhW68OPqnFHrJAfGsgcmUuH6SMW9FNMOP+3XHc7fSNwTOobDY5SEIH+2znvm6
 lKvLj2YD0ROGi889NI7pOpBkdp4UbmhK4TDk09EtlZXGxonnvtBRGlW+1S/y8WxtLTunRyDhE8B
 3WWuk4x9rYST3jLvtmgOOwov2cYxqYhb/wjzHw3FZhwTSHAF3AMBS8oto+exOwimBf4JmxcheRe
 U8SKmOjxKfe6iBx6wzTVBmcZMBtoSULWAOo8nW5X7H20GgIDaGixW/NpsWlnFYPKwIRccJ43qo6
 EQCkoPvikaNf7ly3prXo77cY2beR/x23J1vcRQUHnfdh8bq8M3nx/iTC+HpxbCSJrN6BiRmQFKs
 UqnB3rVsDCqDVx6L01AHgiYyZfd7tg==
X-Proofpoint-ORIG-GUID: 1xh8RFTSfzRmai6ZoF9Eha8RoGZCB78m

On 09/09/2025 07:44, Ojaswin Mujoo wrote:
>>>>> +create_mixed_mappings() {
>>>> Is this same as patch 08/12?
>>> I believe you mean the [D]SYNC tests, yes it is the same.
>> then maybe factor out the test, if possible. I assume that this sort of
>> approach is taken for xfstests.
>>
> I'm not sure what you mean by factor out the*test*. We are testing
> different things there and the only thing common in the tests is
> creation of mixed mapping files and the check to ensure we didn't tear
> data.
> 
> In case you mean to factor out the create_mixed_mappings() helper into
> common/rc, sure I can do that but I'm unsure if at this point it would
> be very useful for other tests.

above it was mentioned that the code in create_mixed_mappings was 
common, so that is why I suggested to factor it out. If it does not make 
sense, then fine (and don't).

> 
>>>>> +	local file=$1
>>>>> +	local size_bytes=$2
>>>>> +
>>>>> +	echo "# Filling file $file with alternate mappings till size $size_bytes" >> $seqres.full
>>>>> +	#Fill the file with alternate written and unwritten blocks
>>>>> +	local off=0
>>>>> +	local operations=("W" "U")
>>>>> +
>>>>> +	for ((i=0; i<$((size_bytes / blksz )); i++)); do
>>>>> +		index=$(($i % ${#operations[@]}))
>>>>> +		map="${operations[$index]}"
>>>>> +
> <...>


>>>>> +	echo >> $seqres.full
>>>>> +	echo "# Starting filesize integrity test for atomic writes" >> $seqres.full
>>>> what does "Starting filesize integrity test" mean?
>>> Basically other tests already truncate the file to a higher value and
>>> then perform the shut down test. Here we actually do append atomic
>>> writes since we want to also stress the i_size update paths during
>>> shutdown to ensure that doesn't cause any tearing with atomic writes.
>>>
>>> I can maybe rename it to:
>>>
>>>
>>> echo "# Starting data integrity test for atomic append writes" >> $seqres.full
>>>
>>> Thanks for the review!
>>>
>> It's just the name "integrity" that throws me a bit..
> So I mean integrity as in writes are not tearing after the shutdown.
> That's how we have worded the other sub-tests above.

you could mention "shutdown" also in the print.

Thanks!


