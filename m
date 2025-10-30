Return-Path: <linux-ext4+bounces-11347-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6435DC1DF04
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 01:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90C7D4E55ED
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 00:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C6A1F63FF;
	Thu, 30 Oct 2025 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r721mgKq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ANp/fUMD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF581EDA1E;
	Thu, 30 Oct 2025 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784895; cv=fail; b=XTRMerNnd2hrLJ1L6LY2CQs9l8tzK1bhqQsrF19Efxz6hl6Mwn/9MT4GGnYqnUxzbm+sD+/JEegTHRC12FYG48fXu+7BQ8gNnEOfgG2o+atxErssCIJEVw6iQQmxQ+yP+VLv0M7amfS/klJxcpvuCDrdWlibcz3ejfPmJN7Cnk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784895; c=relaxed/simple;
	bh=rwjbNLz08J+jjbSZp/5iKQITM0jDi1O9ZzdrjWGKgbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GPFN7NU3ZRVzvA3SP6vV15ns0jPvtEvpgqcf5hJD2/esj2KjhG2zPkDniq3lcmK7ZFUexO2EjWlhoL78+lmeXG2tqjKhg6/2/DA/MBTtf97U/0Ptmr5EZmuc/iq0aN23P53KgcIxOAVyxPNBUrZKla/Zw7KSpcxkXSn+yQkUhmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r721mgKq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ANp/fUMD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TKKZOF002897;
	Thu, 30 Oct 2025 00:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=k58XTA6b3lVv4I9nETNiLIvMDnrZfzOSy5uankQH7Qc=; b=
	r721mgKq6KHcMsiwHG4WzB5YCqLo2OGfBw9RY3LaoI25kkZF4v1D93rsgeJCicxU
	JuA42wQbtGPUiowt8RbgEEc47CVSZ+2FIvewgyHWAjffas0WOq2qwf//0ePnWMq2
	E64YULt47VR5cTbW7BVfHuFvCpcxTdMuH9GnTCfPEVpGjHrn7REM8jfcPlfySj5o
	VRqzHBa1sxi7dGU+/3ENsLDRjyOX/+xBVNCl0k5vn8eBl7zR8z+Zhk73vj31sdh2
	oUsBt7mQ/oTrOUZaVXtAmVGEAc0Hd9C4olT8OtPrPmMbvHFq7THcSAzlMkOyMvEu
	UR728FCG3nrOA+6LPPoB3g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3bgktjf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 00:40:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59TLqnlE015955;
	Thu, 30 Oct 2025 00:40:52 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34q8cd1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 00:40:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAYFT3bacj3FPbb+uhXBzgi5Tc6Sj0lMDXRrDUmDuNt5T2VidQz9O6naYS+eS6GxFh8V91qHcdIP8BvpDU1ZchVfNVJSxdFmUNjzgShzhHtbsTwJ4sL+d3pJBE7vO8uJQame9oXy2JqeDh0p3XxlTHkUW3CrtRZogD7vL4exLUC5rPZAXEqZOnFu59BACadayOXlODATTcqjAXChwULU9gqwLWq93MrD97+PfQW5UUNsmC3tCXOWNIh5BhAnEIqUYD24rVgxZaHsTS8KLKJmgvvzeTzin2ps8ilHnOJxwssSrm9klyhKwAWXe6cC0SZVclP+1Fmr8/gUsgyOzwxPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k58XTA6b3lVv4I9nETNiLIvMDnrZfzOSy5uankQH7Qc=;
 b=e+lgVT3XPBkp09at6POWLNJEzkm5XCEv3wCS3VmEf5IRgyepns2tz/I1+TcbsWqfqQw/n8iU+XXh2aWYwdgO1PnUa2b5/ddYYBdEzdTFBslgjIvm8thRWm674t4GQIV6UpONGSWCPy7rgF2TMkZfOewgD8xhcjXok6vV6uKgKcYGAqpYEjIiQe/R8DlCVn1YOxo6HiCMWdSXTM4NMhIsFTN33kVZS3L3WvL+MCFElX0z+DN9/7prZtVSR7CYkzIFT1toPyft6BimjJ0II+MEIhixPZdr3/Ijany8wIFlkBjcdM+EpsC9SQT/57Fe5RuUq80HI8iToUAUa48Q5azMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k58XTA6b3lVv4I9nETNiLIvMDnrZfzOSy5uankQH7Qc=;
 b=ANp/fUMD+6PvlRSnLZLSXMyTctkuua24n0FKoiZNaw4tJ2lliHR4bG6CKqPKdTPWxFhB2lIUbAxT21OspCw2L8WlevY6RzvH3Tb3runENoMSdIfyewmOmVskFHMdEXvSDA6rZyEUqvPjJt4WXyroSHRvFaxLwTJs46dUrrfehuw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM3PR10MB7926.namprd10.prod.outlook.com (2603:10b6:0:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 00:40:49 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 00:40:49 +0000
Date: Thu, 30 Oct 2025 09:40:38 +0900
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
Message-ID: <aQK0Bj8DL21WJ0gq@hyeyoo>
References: <20251027122847.320924-1-harry.yoo@oracle.com>
 <20251027122847.320924-7-harry.yoo@oracle.com>
 <CAJuCfpGY0h2d6VEAEa4kjH2yUMGDdke_QTFt6d+gb+kH=rnXyQ@mail.gmail.com>
 <aQHJfyoUN-tbnVFr@hyeyoo>
 <CAJuCfpFhaPTqtKbjrigptPJ-9kKJB--mPnicBzN1=rfJxhN3PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFhaPTqtKbjrigptPJ-9kKJB--mPnicBzN1=rfJxhN3PQ@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0140.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM3PR10MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bc40c9-bfcf-484b-42ec-08de174cf859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEl1blAyOXZJeHRXOURHZVJhRkN0T3Z5dFZuVElia2R4TUpKN2dXbXpKZnU5?=
 =?utf-8?B?NVh5d0JrU0NSMmlBdk00UXhpVG50SmZZbXVRRElsKzNVckV0R2tTUDlxL29x?=
 =?utf-8?B?dEhIOEt6VWhhQ3ZSandlMGtKWm1xNU9vU1FzRFY0YmRPN0tBMGYyY25TamtQ?=
 =?utf-8?B?eE93cEFPeHAwZS9kNVp0cHNwRHpEbDVtVWVIMjc4SWxJSnJ4UFByT2pPUDM0?=
 =?utf-8?B?N1YxbU5wam9wZndvK3BoNWg1SDZnL0V2NmdPd21GZitWSnFRWVo3L3RpM0xD?=
 =?utf-8?B?MnVCaFY3dTdENHNCTlg0NTZXeDR3TWtFQlZUREdmbUZPRkludnNGVlI1Nnph?=
 =?utf-8?B?SGxjYjNSaVJ1Mi9CS0F4WW4rUXdSRGNxbWNDSDBtNVpVK3lDQ0hwbjFKZ3Bz?=
 =?utf-8?B?UDBnZjFsNm5wd0JYcjBSNWxJbFF4TEhwQVRVQWtmVmh6c2UrbWNscUlscEpM?=
 =?utf-8?B?Mk1sTk04WkhiL2l6MjJFS0Z2c3RFRHNOc3dyb09EZWFwdm5FQnorMnFIOXNJ?=
 =?utf-8?B?Z1VWZEZQaEVjZ2t0bDIwVkRwSDkrbnRUdUV1ZXM2VjFKM3V5VFdKaFdGS2E5?=
 =?utf-8?B?NGI1MEl6RFJOcE1QbklvNEIzWVFHSFZKRFRqeklSRmdjSThKQlRUM0lXZ1JF?=
 =?utf-8?B?M1MrKzh4dXJWcU9pQjhxNHRiRXR5VVB2Rk95NWQwQXhKYTdDc3o1RFF0elRH?=
 =?utf-8?B?MUJBeTFYS29DcENvYmhUbVl4WFJJaWw1MWtSTXBuMDJRU2VqT0dtYXNpZ3o2?=
 =?utf-8?B?Sk1YNndHU3NXOG0va3l1Yi9HUnRUbThUZllWakdtaWs3YklLU2Y3TmhaejRx?=
 =?utf-8?B?NVhlWFNXVGR3WXY1cVVCdWNaaHlJdk4yWXBSN3g4bUFXaHNGVGJjUTJ6RFRF?=
 =?utf-8?B?bENQZE9sK28xdlhuWjA2Y0xxVEQ5SXdVN283SXJ4UDVTeHZ4UWhxYitJMjNZ?=
 =?utf-8?B?K1dEYWNTbnhOUEVuOEZsK3lrNCtzdU1WVTFtQ2J3S2pjWDF1dWRoQytraGVq?=
 =?utf-8?B?Wm1KMzlNa0lpOTlxTW5SaVZ5aHpqVHh1amVxaWVrZnlqb1dHN2lTQjdFc0hk?=
 =?utf-8?B?Y1ZZbUZ2SFlWZ1R2S3ZsTnBubnFjLzBtYlpVc2NTbDJJdzFJNlg4RVJtcXJw?=
 =?utf-8?B?ZHVmSzcyVncvTEZ3WGJPb3RPbjhXaFJqSlhhbG13dFBlWTZBMXk0S3VwVGRX?=
 =?utf-8?B?TC9OcHZTeDN4dVMweHF4ZmQxdWNmQ3dWRm8yVC96OG1jS0w1ZDlveEVJZU4v?=
 =?utf-8?B?bE9yYXJBamNJVytQNm1FOWJiNjVrVEZIYjM2cHEzVzMvYkw5MG9ybHRxTmI5?=
 =?utf-8?B?TUM4eVovQk4vOUpwOUNlREwwc2x6WDFKRGxLdERXZU5WMEJGQXExNG9JTFUz?=
 =?utf-8?B?VlpMSzh1TnVNY1NsSWdzTm4zcmtSd0xPSDd3M2xCMHFjUE10OG1BTFVXN3c5?=
 =?utf-8?B?OEppcDFkZysxSmNRK0JRZjNVdno2djhRQkNPL3pPVjYyYjBwMXEwYnlzNnhv?=
 =?utf-8?B?WllwRjhsQk9pV1VuSzIrUGpvZVFYQVI3L2lwSFprcVErYTc5TUxRV1VEREg5?=
 =?utf-8?B?QVljRmNUSHl3QkRjai9pNGRIK2g2QUxUcFA1cTNMK284S3Q1RWc4bm5yM0kv?=
 =?utf-8?B?endLMGdXRy9IRnI4aUZ1TEI0b0JtYjB0elM4NjVhUENWbXJjZHhDWGVKRjVJ?=
 =?utf-8?B?VHdGOWp0OFdVd2F4N2JXUXdsMGVFTldrNEZYa0xWM3NGYXAxcEc5ZFhwSGo3?=
 =?utf-8?B?S1pJMlhnNFluY1E5YURqYUZBbkQwNnFkdElJcTZFMDk2eVJWQzZpelFnREEz?=
 =?utf-8?B?ejA5cjl2RzNqdFRRaUJzM3lzKzQvRkM5bUg1T3FTaEtkc2NNUkR0aExWYU93?=
 =?utf-8?B?UTNDcXB4MVVxRCtGS3N6bk9NOGtyNGgwaWNtRVl3dHlPckZaWVVoRG9XOHRL?=
 =?utf-8?Q?mKG2Lu4VjeTCkZjeuWfKDtMxX6zKGkFj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2tYN3lOWGR1YkR6bnQ0MDhweFlmTWlPVUhHTjBlU2J6VzNpK2U0QU4vbHYr?=
 =?utf-8?B?MHJ0T0NSQ2VsR0M0SSt0eWJMRXJjN2xVOGJOYUp5UFVQeDJpZVVJazNNNUFj?=
 =?utf-8?B?Q3p1VGoyeURXTUpJYWx0RzdaWURRbzRseTdKdGJIMFRLNTZqbEl0R2RnZ05S?=
 =?utf-8?B?R2l6TFUvN3B1dEkxNzM2alBqbnZ0V2VsUlo3UE1Rd3pkY09iZ1VxdnJZaG5s?=
 =?utf-8?B?bDNnVmM4djRTdWt5MWFCZDdpRWVkdVY3WWV1eWhiT3dZaHQzTDFuUTNScXFG?=
 =?utf-8?B?eGxIMUZ2blVRbHRuZTlDU004QktJeFBsbllhOTRoSzZKUGJXOTI2NkpqcFdC?=
 =?utf-8?B?aitFL2gyMXJ4ZWsxNFhsMjZLRDU2RUxvVEFXdm9FbXhUZG5uSURJU1RwTHdZ?=
 =?utf-8?B?OWh2VzRyUTUwNHFvdG10Vk80RDMvL1V1WURGKzI0WGJrTXFiNXJ5OXVITk5H?=
 =?utf-8?B?MG1rWit1UFZwUVlDdWxQSitrWVFTMFVRYjJmVWorSUgxWnhqZ1poaUVEaVNr?=
 =?utf-8?B?V1RmWHAxRkd6NllqZjNPZnp6MTU2UXY1Zll4UWl1SDFOb1FENDhaSVJGbklD?=
 =?utf-8?B?SlJaL1FNYjdxV3JXR2RZMWdnbkU5eHlweklWYUprdVBRa244RUFCSVplbVZM?=
 =?utf-8?B?Qi94VTFiVmluN0hYSW10aXVWby8yT2ZaLzVsVFhVZTZBV0paa2h0MFU1RFZu?=
 =?utf-8?B?TTlETUVTVmZ3aDdtamdib0NVZkFzWjNTdklHREFDOWc5UnNmdExJVmpRVW5O?=
 =?utf-8?B?QjBkVHJ3cDdMM2tXekZuaUdqT2pWdXU5QTBtejE3NlF6aUZNV05sdVJhVkkw?=
 =?utf-8?B?Z1BGRTUrUkhabytEQWlmQStWTTQxNmM4V3IzbWxaYzduVU9nSmZsRXdIUjBH?=
 =?utf-8?B?Y1dtQ0FUVmExZlZsR2RROTl6UWVLSXZ2MmRvU2EyZFREczdrY1JXRDgrdHEy?=
 =?utf-8?B?MnJVTnJNbnNMLzJubXFXeDdobmlQdkc2S2VqakJMNDZKaGl2ckI4eW50ZGNU?=
 =?utf-8?B?YXgvOUlkQVZvdUdUeE9ZdUpyWWZTTzd5UlQ5L2JSUGVNYStRZVJsQ0EwU3Zn?=
 =?utf-8?B?TDNNUGhVeFFFWTJmN3AzQmJSNjNSV2oxRXBlYnJZRzdoRVJLV2w5Q1BFY1VN?=
 =?utf-8?B?TWUwYUtWUVpDUVZZcDVMMTVrMGp6citoODJ3cmIzYUlROGU1aWdPelB2YVVt?=
 =?utf-8?B?V2U0OXh2ZGVRR0Q2UlRJUXFScHF1Zy9SRnFvcVdtN3JmbXBmQkFRNjdYNHk2?=
 =?utf-8?B?SjI4NGNkMXkyOVRXakg5U0p4TGdJWWhveW9HYi8xcnBxWnc1WGduZ2pUUUNw?=
 =?utf-8?B?bTdKekNFS2w2TEFrR3pZdUxWWEdDUXlrZ1c1S1FSOXMyTHNBRXlQME9XaFU0?=
 =?utf-8?B?Um15aVozcUlrRzFiRXVtUDFMRkVWczNGUnRJMEdOYXdObGNXRFZTbnhvRkZq?=
 =?utf-8?B?ZGNrVVpSZUlOMVF4SnZJRGhIaE0vaDM3K2lmeHpha0FYVkgvYWlodlE4Z2Vi?=
 =?utf-8?B?UWNwYzZrOW5tSXpsOU5TSmhRMVd4S3RQbkJsQy9XL0NhTVhFOUtVdWd1aDMx?=
 =?utf-8?B?UXZSa1UxTUJ0WU1RWmRoRHU5dzF4UzVCUmpweURXaTQwaExLTFduOU5XZnN4?=
 =?utf-8?B?RGZRSmdmWU9wdzR4a3UzdWlrUDJ1QjlydjBEdHZJNjRhWS9nWWlnOWhVOUND?=
 =?utf-8?B?d2s5SVpkSGRRRFFiQlRGajZLQ0pRSjRLNkxpaXJHdHNxU3doSHAyTmJWaEgz?=
 =?utf-8?B?OHJyd2JIR2JPU0w3T1RrMURCWng3WUNPSFlKL2FiT0h1bzB0Uk85eHdENGFo?=
 =?utf-8?B?NWROeXhxYTJWRlFPMi9Lang2cVlPc1RwQmlYbUdWVTdIRGpRK2Yrby85a3lz?=
 =?utf-8?B?cGg5SG40Nk5IZUM0V1JzeFVMRWpYYVRCUm1YL1BzQkttSXY1ME5JVTZWQlg2?=
 =?utf-8?B?cWRZWmRheXUzeDVPeHRza0R3eHVDOS9MdUx1d1dLQklESnZqVFZHbEkwNXR1?=
 =?utf-8?B?R3BsWDF4SitLYXcxVGNyS3RwMWV2ZWV4YkJ0Y0pLWUdNVWdPQS91MS8zNDlJ?=
 =?utf-8?B?OUlnYW9nTGNTTDVvaWJWUFloY0Q1Y25NakltZndDaThXTStMQlFvSFRzbTBq?=
 =?utf-8?Q?u7wwquGi1wgm51GEvgYkmQL62?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rDeB2s12x788m7e7RZbqT59rnVdogjN6JiPqJGZbEwbgw4FdGROItLkDVB3RkIXMVnP0+UFnNBR9r1RlrK9TVD/EmhYupMIwdN8AiY7WsWcKSYxePd8Mm7bnkt4N3BvSGz2e5jX5IGlaVg8nujc0KTlqdQ6oJKQwJCNA1NZBjtyhWm9lY3FdiztObBKxmwyy4Rry1OFEmRrIConrnqAwLnycG3I7+fXhxKgOVkEpLnLSJ5itHyuvaHFGMrVk6O3MlLuixM81CHGV9Gy6ES82KT/SMVZAqIXpk+nG06FncwTys+MUVqP9GG7HdInt84NuDac3fXi6gUFS5pIxqbbfZe87rwbfQQtlNF/QvQ6oxvbXyIJhRTT61cRKZl+GWi6Roqj3S8Ak9hdTzs23rgxKUiOXrQ1Z9+mLX1zxEIOHJLzw3koOpATlg6Ja0BnQioajDoTeeloGiDJoDrhS3CncqHTWUtrF7362dPr5KFnCnmYlW7DvZHHGgV9pj2+Gaa2zNtpDBFDGiA2uudxpEQwCztF3+4ATW++CotpN6I7gv6YrLi74TD1doTtERLgggTFXSJZ7KroWkFSjTqGw+KLMceXTWXTl91GfW+r0Ftop2Eo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bc40c9-bfcf-484b-42ec-08de174cf859
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 00:40:48.8425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taBwxRCjWIdU0UqrrYT7y54EG8ipkMfnOoYXcNUoNw4vtf8PRPirVQ4bsJJannBBx3T6FGvt9TQj1/MGq0tRDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7926
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300002
X-Authority-Analysis: v=2.4 cv=Y4b1cxeN c=1 sm=1 tr=0 ts=6902b415 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=GDHge_YK4OpwMnrSNv8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12124
X-Proofpoint-GUID: zG0zMdmIdnfui7U0-57CLHG-91sN1_q2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAyOCBTYWx0ZWRfX2eoN2Un+GrbV
 x3XgiqfTIv8mizgJGcnyNJDHYdDmKa30Q8oKl4U9fDpcJpGchXVk4pxcVsg6k1yxrNVzaQsD3/M
 mYNbMwCUTxHv9LuQb6LoZ8tTS/BV7WCkxakubrBwLb0n6tdw62R3c2KJsB3DJ9TkTnslsm+cOQw
 mNde1yxN9qFVobKXlWW+yHyxafQVcDOlPmr3ch4wWoZkoYjWErdWjOwOvGHCCTMZFu9ebGeh9g/
 vqug7lLI07mkan/vFf92fV6DfblbHd2tEW5OefJpq5qvwIu+5arEzfUSi2dZD/o6dZVLkWJA3d+
 hoXCjRHorfaz1NqDaUQJiFu0Z4P5aOLEheQ+W2l+QIhOfeJpv3t2V/qUlVG/6ZvmgCuHiKiHhvm
 Xl5xp78Y5WfezOYvZ/7lLwo1QmjCXymIAv27rAycb05HyPeURGw=
X-Proofpoint-ORIG-GUID: zG0zMdmIdnfui7U0-57CLHG-91sN1_q2

On Wed, Oct 29, 2025 at 11:37:27AM -0700, Suren Baghdasaryan wrote:
> On Wed, Oct 29, 2025 at 1:00 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > On Tue, Oct 28, 2025 at 08:07:42PM -0700, Suren Baghdasaryan wrote:
> > > On Mon, Oct 27, 2025 at 5:29 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> > > >
> > > > The leftover space in a slab is always smaller than s->size, and
> > > > kmem caches for large objects that are not power-of-two sizes tend to have
> > > > a greater amount of leftover space per slab. In some cases, the leftover
> > > > space is larger than the size of the slabobj_ext array for the slab.
> > > >
> > > > An excellent example of such a cache is ext4_inode_cache. On my system,
> > > > the object size is 1144, with a preferred order of 3, 28 objects per slab,
> > > > and 736 bytes of leftover space per slab.
> > > >
> > > > Since the size of the slabobj_ext array is only 224 bytes (w/o mem
> > > > profiling) or 448 bytes (w/ mem profiling) per slab, the entire array
> > > > fits within the leftover space.
> > > >
> > > > Allocate the slabobj_exts array from this unused space instead of using
> > > > kcalloc(), when it is large enough. The array is always allocated when
> > > > creating new slabs, because implementing lazy allocation correctly is
> > > > difficult without expensive synchronization.
> > > >
> > > > To avoid unnecessary overhead when MEMCG (with SLAB_ACCOUNT) and
> > > > MEM_ALLOC_PROFILING are not used for the cache, only allocate the
> > > > slabobj_ext array only when either of them are enabled when slabs are
> > > > created.
> > > >
> > > > [ MEMCG=y, MEM_ALLOC_PROFILING=n ]
> > > >
> > > > Before patch (creating 2M directories on ext4):
> > > >   Slab:            3575348 kB
> > > >   SReclaimable:    3137804 kB
> > > >   SUnreclaim:       437544 kB
> > > >
> > > > After patch (creating 2M directories on ext4):
> > > >   Slab:            3558236 kB
> > > >   SReclaimable:    3139268 kB
> > > >   SUnreclaim:       418968 kB (-18.14 MiB)
> > > >
> > > > Enjoy the memory savings!
> > > >
> > > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > > > ---
> > > >  mm/slub.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 142 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > index 13acc9437ef5..8101df5fdccf 100644
> > > > --- a/mm/slub.c
> > > > +++ b/mm/slub.c
> > > > +static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
> > > > +{
> > > > +       unsigned long obj_exts;
> > > > +
> > > > +       if (!obj_exts_fit_within_slab_leftover(s, slab))
> > > > +               return false;
> > > > +
> > > > +       obj_exts = (unsigned long)slab_address(slab);
> > > > +       obj_exts += obj_exts_offset_in_slab(s, slab);
> > > > +       return obj_exts == slab_obj_exts(slab);
> > >
> > > You can check that slab_obj_exts(slab) is not NULL before making the
> > > above calculations.
> >
> > Did you mean this?
> >
> >   if (!slab_obj_exts(slab))
> >       return false;
> 
> Yes but you can store the returned value to reuse later in the last
> "return obj_exts == slab_obj_exts(slab);" expression.

Okay, will do.

> > If so, yes that makes sense.
> >
> > > > @@ -2185,6 +2311,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
> > > >  {
> > > >  }
> > > >
> > > > +static inline void alloc_slab_obj_exts_early(struct kmem_cache *s,
> > > > +                                                      struct slab *slab)
> > > > +{
> > > > +}
> > > > +
> > > >  #endif /* CONFIG_SLAB_OBJ_EXT */
> > > >
> > > >  #ifdef CONFIG_MEM_ALLOC_PROFILING
> > > > @@ -3155,7 +3286,9 @@ static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
> > > >  static __always_inline void account_slab(struct slab *slab, int order,
> > > >                                          struct kmem_cache *s, gfp_t gfp)
> > > >  {
> > > > -       if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
> > > > +       if (memcg_kmem_online() &&
> > > > +                       (s->flags & SLAB_ACCOUNT) &&
> > > > +                       !slab_obj_exts(slab))
> > > >                 alloc_slab_obj_exts(slab, s, gfp, true);
> > >
> > > Don't you need to add a check for !obj_exts_in_slab() inside
> > > alloc_slab_obj_exts() to avoid allocating slab->obj_exts?
> >
> > slab_obj_exts() should have returned a nonzero value
> > and then we don't call alloc_slab_obj_exts()?
> 
> Sorry, I mean that you would need to check
> obj_exts_fit_within_slab_leftover() inside alloc_slab_obj_exts() to
> avoid allocating the vector when obj_exts can fit inside the slab
> itself. This is because alloc_slab_obj_exts() can be called from other
> places as well. However, from your next comment, I realize that your
> intention might have been to keep those other callers intact and
> allocate the vector separately even if the obj_exts could have been
> squeezed inside the slab. Is that correct?

Yes, that's correct!

> > > >         mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
> > > > @@ -3219,9 +3352,6 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
> > > >         slab->objects = oo_objects(oo);slab_obj_exts
> > > >         slab->inuse = 0;
> > > >         slab->frozen = 0;
> > > > -       init_slab_obj_exts(slab);
> > > > -
> > > > -       account_slab(slab, oo_order(oo), s, flags);
> > > >
> > > >         slab->slab_cache = s;
> > > >
> > > > @@ -3230,6 +3360,13 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
> > > >         start = slab_address(slab);
> > > >
> > > >         setup_slab_debug(s, slab, start);
> > > > +       init_slab_obj_exts(slab);
> > > > +       /*
> > > > +        * Poison the slab before initializing the slabobj_ext array
> > > > +        * to prevent the array from being overwritten.
> > > > +        */
> > > > +       alloc_slab_obj_exts_early(s, slab);
> > > > +       account_slab(slab, oo_order(oo), s, flags);
> > >
> > >  alloc_slab_obj_exts() is called in 2 other places:
> > > 1. __memcg_slab_post_alloc_hook()
> > > 2. prepare_slab_obj_exts_hook()
> > >
> > > Don't you need alloc_slab_obj_exts_early() there as well?
> >
> > That's good point, and I thought it's difficult to address
> > concurrency problem without using a per-slab lock.
> >
> > Thread A                    Thread B
> > - sees slab->obj_exts == 0
> >                             - sees slab->obj_exts == 0
> >                             - allocates the vector from unused space
> >                               and initializes it.
> >                             - try cmpxchg()
> > - allocates the vector
> >   from unused space and
> >   initializes it.
> >   (the vector is already
> >    in use and it's overwritten!)
> >
> > - try cmpxchg()
> >
> > But since this is slowpath, using slab_{lock,unlock}() here is probably
> > fine. What do you think?
> 
> Ok, was your original intent to leave these callers as is and allocate
> the vector like we do today even if obj_exts fit inside the slab?

Yes that's what I intended, and maybe later we could allocate the vector
from the unused space even after the slab is allocated, as long as
it doesn't hurt performance.

> >
> > --
> > Cheers,
> > Harry / Hyeonggon

-- 
Cheers,
Harry / Hyeonggon

