Return-Path: <linux-ext4+bounces-9949-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29315B5551D
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Sep 2025 18:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBADB7BE269
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Sep 2025 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5959D322747;
	Fri, 12 Sep 2025 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MX6v0ApI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LE3q5m5w"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81E3218BF;
	Fri, 12 Sep 2025 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696052; cv=fail; b=FqOXoO9k4F5knBKyvubKhOPerQikwOcdJrz26p3HwY3pkRpPqEYPmf+eGdZsd+ZZ/dFBPMbmqz/4Xb2zeFLNdSUbTtv+IWcCMtN3GniqYQMogtR0tlKeyYGRt5jrgajkuYq7obdcqEHoXGmoVcumhL1W5Q9F6WjBEn1Z8O0Ko3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696052; c=relaxed/simple;
	bh=jpNTY9YuKmdzZtvc4+J1r29XQIlyRLvfnEJt+b44L7s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mrCJ12jYXno1gezP2d7q9uFMWFaTNFvjPalNqkmLHCx6Cx5CKToeAtLhL+4x5c350p3LUmduLH6atZFSlwg7lJal3oWTw3m0Hl5SbNipsoLnI9Z2qafywpB9kU4s+pvoKbeOxY30nZQU05RYCHfzJb0Kpl4NObos7spuVNiORJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MX6v0ApI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LE3q5m5w; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CGMtsH010945;
	Fri, 12 Sep 2025 16:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hcz6sYspxwkCvTCns2xfWxDhiqr6C05YKxmGRV7BJ8w=; b=
	MX6v0ApItW2h4SJie3hJ8UUZ4d3ZR+K3DUHBFvlsw5T0VXdGb1fLZL5Fa3U4O56H
	+PDNItLH1vD6MlXi63/kMkyugK0vLz89wqxskTyO7bX8MvyGs5JH4c7Y9i7Kt59h
	hjMHlvN9i9Skum/jIRKgNDZ8sau+Q4HgfODoWOfabH/XRf+oLwG5rFmIJkYkvgE8
	1zKR7slK6qG153QhYc+pdIM0u5L4txlKJKmnGl0pVfuH6T9KZOYmwQkV4LXK9e/g
	dbiO5tS6hTz8OhgqfSRZELYqsvPAWdze1+GKaS9nSKsuNCLpyGKRfuPifgxscyeA
	ykBafHBRh+v8RcMElu1/ug==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x98jt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 16:53:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CFZRL2032903;
	Fri, 12 Sep 2025 16:53:55 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013035.outbound.protection.outlook.com [40.107.201.35])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdf3uu7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 16:53:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TftPH+K/d9TA5nF2uQOQSbf33dp2UrZ8geGciEK42Ao9XpGRmzC2rB+1gFEyV7Wm7ECHSqVjJk5uNswMxhJxHUf0oR1ZPb8swlktL6mjil5Y5jf81K7Zg0t0bjdBq/MZa+eG7W/mF/nq3yBINnvCGH9ZQO3ZcoGA/LHw6GJuPhEOh4Cq0k35gvPQ5YsYlSTiQRuifPtLLmG9SpQIKc//7kKJBLpkyY5G/Ezk7suqWN+kyghNalQgc5lNbl9ZWAvGFwnTlHj98cWqymvFND/NvqgukpgF6+mBEprIlQN1FfGbR8of8+5eTJPvfts+lgl5diw70oYrMf/v7sKUIxoOvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcz6sYspxwkCvTCns2xfWxDhiqr6C05YKxmGRV7BJ8w=;
 b=KZYInnMjKtePJh53Kl2GTqsZkqtOjEcsAGTByLgzjHmPLfn7/ICa8tmPqxphxSTnOa+lrOH/6N7QitA5P+wbhUWFRxxheXC18WLRTL3o+uA/vOtE3PAjvnsZdNooK6zmz7O2BGEW6HZUR84imO/mQqSbJHYJmpnpCNRbXnwTP/pNZPbS1lOi/dhqmnQvnruIMRCtiIYn15P6TMapsVh/Tg90Q9+YXEDJANzVtP+LMKobPjt9y6HwOyC5MJh30fOKWGVAeLpPOvitmk4oBEOSas0HETb9nFWE/mOVRDTpW50z2lGFygI9nOywy+f0Z8vJQOtViV2ltstlBPTbE6wmAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcz6sYspxwkCvTCns2xfWxDhiqr6C05YKxmGRV7BJ8w=;
 b=LE3q5m5wP2UdTqg8DOH6F0n+hvPIQmo9A+ZWIyVk6/eR/7nN/dQuTKVBYy8FQIoAE+RwnJ/lh6VLm9FF6nkmHZV+xNcAtZZyBIvZm2A/gKxEZvlzXDNX/3aS2+HG5sKr8BSPSKIGlgpFl54qxeEbhQ6R8KDBjFW8hgEaRy8iQGk=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by BY5PR10MB4177.namprd10.prod.outlook.com (2603:10b6:a03:205::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 16:53:50 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 16:53:50 +0000
Message-ID: <5a22a799-a6b9-43d3-9226-d1d554d170e4@oracle.com>
Date: Fri, 12 Sep 2025 17:53:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/12] common/rc: Add _min() and _max() helpers
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1757610403.git.ojaswin@linux.ibm.com>
 <9475f8da726b894dd152b54b1416823181052c2a.1757610403.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <9475f8da726b894dd152b54b1416823181052c2a.1757610403.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0039.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::27) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|BY5PR10MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd97365-bd82-4414-75a8-08ddf21cf2b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2RvSEU1N2Jya2FBa1F0QTBUdEFQUkFJOUllMmNMeEY4Q0lVVm9IT1VoV3Bl?=
 =?utf-8?B?SUpwQUVyalVxUS9abUdRVHhpRUJYTTk1Y21ZRGd3VlJoMUFYelVNbTVMOUh1?=
 =?utf-8?B?SjVzcFY0REJzcUNVQjBoeGtMM0IyYjhZSk1Ea3JKNHdIU1BUL2liZzdEY0pm?=
 =?utf-8?B?c3haK2xoQWdmMFdMU2xOSWpLN0I2S2pzWjdzZ2F0ZE8xL0ZRQUNYTzZ0Tkls?=
 =?utf-8?B?alJLcFFvbml6QXhjVXhLek9iUGJteVF0Wm95K3VBMVZFU3RjeFlHWVcrV2Fl?=
 =?utf-8?B?MnU1OVRnU2MxZmk0RFBhTVVIZ1FKMUt0NXVxeFc4Nkg2dXpJWGFHVE1xaGwx?=
 =?utf-8?B?cHJqZ3FVcWF6SUUrbUgyblpYUEk1S21QTi9jWHFncUw1Uy8zZW9LY2pMdWRo?=
 =?utf-8?B?bm42RFp1a0FORHUybGQvd05wdzUwUk5XVWtLNmJod2FGT0dBY25aVE5Mdi9i?=
 =?utf-8?B?ZGVHamRPOFJ1T1F3cWxCaDZVNmJOMTJQVGY4ZU45ZERIWFNSM1RFMG9SMmNz?=
 =?utf-8?B?RSs3WUtVeGtxbFZVZXduOTBVUjhud2ZnUnZlZVpUdkVzemFxdkY1Z2JYOWxa?=
 =?utf-8?B?UDVVSmpFbWhvK1h3NUR4QnJqbjIvNE50Nm9oMkRGSVFkNy9MM25uWlBBdTVu?=
 =?utf-8?B?eTlqU1pJOWFSeE1hZy9XTmZyZnRtM01GaHVFMEpVejFHYUhJek9obkVFYlRs?=
 =?utf-8?B?OGEzUFdOV1hEMnVSZmhBY1BDK1hqOHdhNzVJNXhKaE9pTzQ2WitKbERMOVVB?=
 =?utf-8?B?eHpKM0RxU3FTSGI3QUdIQmc2Z1FQVXMzeG9RTkpGSk5zbzVmMGVsdy9jenZJ?=
 =?utf-8?B?aW5DeXR1L2dVblVLSVZnaHhpaCtEdzYxd042c1lRcnNFNlhERjFCK2FRQVlt?=
 =?utf-8?B?ZHdqbmdnbU01M3UyelFwaEFUWk43TmpvLzNQUEUzblJOeSt3cFVjaU1HOHNx?=
 =?utf-8?B?UVd6aHpyd1prbHYzM0N5VGdYNDY2TUtxMTV6MmVJYkdITENtbFBwTkwzL1Rm?=
 =?utf-8?B?Y003bW5EOHlLNVQ3K3FSRjQyTm9LUUo4cjFYWGFCejc0R1dlVjdMY3J3SS9C?=
 =?utf-8?B?NmRONGo5aHlFQU1jRHZ5Nkx3SHlvR2pIUzhlSVZCRm1PQ1BMNEhRdWRHRlov?=
 =?utf-8?B?VzJzb0xNRDc5NmZ3TlZkWmdsblVCMHVWakJtRnFMbFFERlBVcmVQb2lGeUJr?=
 =?utf-8?B?M1JHVW1WcTh2M0xnMWxCNHR0KzJXQ1llUGpremJXMmtzeTd6N2hnVlNFNHEx?=
 =?utf-8?B?d0lxV2NpZlY3MUtreDF6OW4vY0NXbkQ1NW43N3F1UVV0ZG1iRzdibmRqL0J1?=
 =?utf-8?B?M3VoSk81bVNna2djUmhkS0RmZGRTNjkzamloZ0lRL0hqZjNERUpqaDh2UEkx?=
 =?utf-8?B?WERTa0lka1VsWGlGc0VRNHNoK1orSXIySElJNWxQMDRHQVcvekNMTi8xMHBV?=
 =?utf-8?B?UWkyS2swek9nNFZDN0tta3NEbDNpak5XdGVRbVlNQUNybmlvR2xqYUFnTnZJ?=
 =?utf-8?B?YWtSYmkzNG5aK2lvZ3RBQ2R4Um1MYitqZVNUbzN5cytQeWJMQzdpTHlaME5p?=
 =?utf-8?B?dHpWQUR3M1ZEMWFMeTQ5a284TW0zdWNVMzFTV0xSNkVXNEJtVXdFOExPQWY2?=
 =?utf-8?B?cDJxVFl2eFpTNlhYd0V0WU9rVFI5dDBnZ1VnbUdGdTJpQ1Y5SDZDZ2JyU0Nw?=
 =?utf-8?B?Wklya0s4bnV3cjNxaXdPM3UydU5ka3VnTmRwblg4Tjd1ZkNzOGt4ZmJhbnJG?=
 =?utf-8?B?RkMwVnZUS0ZnSTRUSGFMeDlEK1VFNElieFpuZ0JOK1F1NUkwVDZCUXNIbER2?=
 =?utf-8?B?RlZMUjV1bWorU0ZNOFVhMlkwb1c2cFpyZnMwSWRFcG1lRVc1cWNkOXM3Y0NF?=
 =?utf-8?B?OFh0NkV4Sk4vRGhTWldhbi96TnRaN3VyWkVmZTlROENib21ENXhHckI3U2Mw?=
 =?utf-8?Q?AwtC2ZM9naU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHZoQ1hZU3JUakpydzE2Y1I1eHdTbmJLT09YMUJseUlaVy8wTjQ1SG5WWVQv?=
 =?utf-8?B?V29KL3ZnNzZxRno2QzVFaGFXaXIwMmRUd1hPcFJoQlRseno1dG1OdVRlYVMw?=
 =?utf-8?B?dnh3RUpYeDFEQVR3cnpxMVpvaXFUS3B3V2hSVjc2MHdQQzFrOVRyMHlWMXVv?=
 =?utf-8?B?am12U0ZCTy92R3NLZm5JUkVBWFRIcHFjMVpQU0krSDZOazVYeUJRZUFRNHNH?=
 =?utf-8?B?RHZRRk1MRDhrTWZlY1Fzd05jdUlZN3IzelJXWi9EdzNvZHlsMHVQdTVIMlZR?=
 =?utf-8?B?WmdzVkZ6V09tRkN1Sk02aDRMUG5OOHh3bC9NZ2xmZUpPVGFNc1BNS3VLNTBs?=
 =?utf-8?B?bUNxL3k2aDhLVWk3Q0JSM0hwY2NKODlkQ21iRk40dXRncWRUOVBNL3gxU3BB?=
 =?utf-8?B?REtUbWNwNUorTmJ4K3hpYkw2aWlDbVBLeXJvOWxRVnBRaVRjNHdncVVHQUc1?=
 =?utf-8?B?N2xLTHRqcjNHY2owK3NOaW9NcWVKSmVMY1d3RWZwb0lkcDEvU2xrNktyT1FI?=
 =?utf-8?B?dkRlcmo3UmpWN0dmN0JtQU9XTUY5cGJobjVrKzN3N2N0WFR4Ly8rdVhJdGV0?=
 =?utf-8?B?emREVWord0M4L3I2N01sRzdreFlvUzNtVUVVaGRjN3R5OHFjTkh2N3lQbGRS?=
 =?utf-8?B?QWZDb3cwYk00T3RmWEdaTnFiZlp1ZmxTUGV2R1ozcXdGemttK0hBVGoxREl4?=
 =?utf-8?B?MzBYMW0wbk1wNGdkMWtpYi9tWnIxV2luR1ZqYlE4bmRneGNRbGtmK1lnenpC?=
 =?utf-8?B?Vk9DZ2hhQmQxN0l1WVRKTDNjYXBQbzN5RDZnOEZySktQOTNYRmdWQXpUdkpK?=
 =?utf-8?B?ODlIMG53cEdGbHpIV0czcHQ2QVJTZ3hPMXlMVG1mYlU4RWZKTWdzTW53cnlT?=
 =?utf-8?B?TDBUdEZMcGRVMCtEcWlZOXl0UVloZkpVNkJOWmRDWVZxamJuQStOQVoxWG56?=
 =?utf-8?B?TEUxaUVWMW1DSUNSMkZ1ZjlKVHFPNXNOY0dlR01ONkxQZEsvWkhUbGc5Vmpj?=
 =?utf-8?B?K1MxbGM0YlBoSnhmOGVnNGVWTmZTVE1mQ1E0bDJyb1ZZdFQ3dDRLTHUzK2I2?=
 =?utf-8?B?NVN6QzlSRThhWUZscUdlTXVFbDVCYmFkRWRSZTI2Z2c1SkZCNEZtd0Z5Ukt2?=
 =?utf-8?B?elRmUWR2czJtSEZlczZlYnVhNzAvMi9PNXRFNFRVQ2JiS2xGWVlNR3U0dEpQ?=
 =?utf-8?B?MnBvMFVEMlB4KzQ4TEZESWswTVR6VC9SVVhFNlZGc0t0c0JjQ2tyQitPMW5Y?=
 =?utf-8?B?WlQ5bkZCeEhQaW9rcCtNWk8zTVluSm1TaEdQc1NBU3J1S29scXFHZGxhb2du?=
 =?utf-8?B?cUJ2ZVYreGxhZEx6WnI4dkh5eE9NbVJaQTBsMWNoVEFsUFFqdFNodlVXZWVq?=
 =?utf-8?B?Y2Fhdzc5aHUrZzRiL1FJbjNkdUVuWElTRGs0SEdCcWpBczdNcTg4RlVGeUVp?=
 =?utf-8?B?SUhVZmZucWhMaGN6MHVFOWxlenlQL1NZZEtjZFJTdEdIQUprbEZZRWdWUkxO?=
 =?utf-8?B?RVdXLzl4aWZ3RTRvOVFUdDlYUE1hbnlOaVh1WnJ1dFdMK005aXdCenMzZ0VG?=
 =?utf-8?B?VXNMb0NlZVJYQkRGWGh3R2N6dDBWT2t5dmpWK2FtZmh4ZUY1YzcvTHJNT2sx?=
 =?utf-8?B?WU9aZ21paGd5L1ZCMXg0bFgybEVwcE1oYlh4UTlpR2NTSzEwVUNSUURNODhs?=
 =?utf-8?B?UVdiOUUrOEVMVXhpR1B3K3doNHFETWZKWCtpOEZ5WFpNdjhQV3R0WEdWQk5D?=
 =?utf-8?B?SHdPbnA1eU42RklyZVVUT1NVWHlIakUwOUdzNXkrbFppbXN1WW1ybFhKSWVh?=
 =?utf-8?B?bExKcGtxbTh2d1ozaWlFam9CNWpMcjc1ZnA3Wm1aZ3pkaHU5K0tLUGZqc2hs?=
 =?utf-8?B?SzNnTzVKNnUzSkRRVmp0azBBRkRPWW80TkUrQ0hmSThNYTdIT25IOUpDd2Iw?=
 =?utf-8?B?MHV6T0tvWTZXT29vZDdrbnVicUxyWjZyL04ram9TZjdvNi9mT1Q3am5KK25o?=
 =?utf-8?B?N0RKM0NudUJwOWNyYzRXdGQrWllndndzNFFzbWdzVEJZc2hhSndnQy93ZkpC?=
 =?utf-8?B?dFo5a3ZadDkwS1J0dkh4cWFKRGxrV212TGlFVXpqTDI4YnpvcUhIbEFyT0xj?=
 =?utf-8?B?ZlhISnJIQkoySWFxb1EwalZpT2tleWd4NUMyN0NkRkdaUDhnWVJtd3pZWmhL?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uuje5VzdyqyUMwJn9HnqfJZn6KbfsNo6JbfSZJBH5KEeAnIReNzJ1vDduF/T6oOpv2rzV0cBdybIXo8d5ZMNX/0yt0ozxacSMhGnrllzBB8MOoZ2kZtC764X6+21jGGs1KoU6Y/n69nt3s1GpJopJVMFxVSUEugZrqRoLMjJsgJJUgI2cIvHAWotzajusB+AKlSALCAhXaSYu7BS4r+vY0jO4p48Te5JmLcr6+/+V+fhlfxfqV6CfmgVm/hBCoDa6YyRL+rMRj7scX4AsOaHJEA5lGihd481sIIPkR5n7LBFqqOHYUYTmYOa4J5F0UOKNTLQmKNeNE0gMeJF4LVCy39IIZQ+rDaGV3Oq+0tgqGc6IRuUj1LT10EvV4jHcMHj8rQsfMj2F6P6L6q3m14s8aQgrhs+JHFIOdlOPg2opI47Xl1PK7DUf+L7XPGqwS6qf9yRZT+jXsV6KMz5MK2KgYpOgd76jmY7yNAHaTYuELYws7/GDajlS3FWMTL5Va2FEAlS44Np3nCm63u290bWL0lcK6TNmR52fsSC5qVLQ96y8zV2v/ZcokBr6D6UHh0vs+Bd/9WiMM3uZoFE4x7Ll6a6mtiLMd5YJKZqqDmilwQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd97365-bd82-4414-75a8-08ddf21cf2b9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 16:53:50.3879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgKpYR7cWwPsN5FzKdvSDi5xesLsRnlSIkwgtbwCYuaw0zqVnH0lGs1PPjW2IWA6ST3ntcfGCQAuyvjOiRNRTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120154
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfXznHkziFvugUD
 fC8qnhvmqdpr8VLo714zI4IRZb00jI9lkfpXb7B2mofaHLjhS88LovhkVW81vmZd5Exr/Z7b8ZL
 cCEe++CERUmXoSE0GfE437/vJG8uGpMl0qvXNyZfJtZuXTr8ZPaNnRzbzK1dnN8qzy5w3F+dDkS
 vgoVu/Dmd9tZ+tfjVHUcepjsF851a0HuUOzEoW6vRE1bcKhLpW/k1JCITbwLMyEJ/dtiFezLHr/
 Vd1N9UpN9/W83lPsD1DrBiCr0MIngfCdJlZZTRWQLR27lwq/Fb2sWN3R6WI9IeIOax68S8CrDn7
 z4I0dVj/DHZEl3Z+94lN95pHU0efdOSPUKWgvJc9EspgE0B+lhIUhwaMoWKaysHIspsDO0mbYhK
 xWJPXH/4
X-Proofpoint-GUID: BJzkp5Ng-fI4c0qUOjFek-C7hps6LqK8
X-Proofpoint-ORIG-GUID: BJzkp5Ng-fI4c0qUOjFek-C7hps6LqK8
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c45023 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=yPCof4ZbAAAA:8 a=AwQf1PsFXX22w3lYYasA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10

On 11/09/2025 18:13, Ojaswin Mujoo wrote:
> Many programs open code these functionalities so add it as a generic helper
> in common/rc
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Reviewed-by: John Garry <john.g.gary@oracle.com>

I just sent a patch for something similar for blktests to linux-block. I 
wonder how much commonality there is for such helpers...

BTW, let me know if I should attribute some credit there. cheers

