Return-Path: <linux-ext4+bounces-9797-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C5AB409DA
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 17:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148513A4DBA
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A9432A825;
	Tue,  2 Sep 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CDEdZ2p3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zd4DLkNB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C89304BD5;
	Tue,  2 Sep 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828511; cv=fail; b=Nmytl6Bgj4csoy8hHsytNkzKYCgq70vnoFoSUmza4PHI9XRERfIOWOf3KHa1GTelzC9r27qeaELCQn/V7282uJ5JBZGZQHyJqmjWuuc1A9vEr9JyLUk3KhxuT2yvjl1EDM8Xf/kY81vRfsmkmp4Sp3PvOt24e6mnzoJSxK7+Z08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828511; c=relaxed/simple;
	bh=IM0LVKhhG6bj+hBpF2ncM3Cl/6GjEioC/qJfkhdD1hs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SGAOrBLLzWrsvsDOF8iaBqBGWqKgDjeUNh100AvkVC7S70Qpy6eQcB/VEbjQjee6TiOqeRPin2rm22nodAi/AOxZQfY0lDIKF7Z36Itoq4CiiUzfWW4pK3yyat2L2M/y/lPf74ejffpjVb6birvMAUM54+mzkAAMjY51BVMwIXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CDEdZ2p3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zd4DLkNB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582DgHC4023531;
	Tue, 2 Sep 2025 15:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=H8FWg5vlnruPx/9XKElJap1QKTFG6ktvZwwODqQOyug=; b=
	CDEdZ2p3OHIKrWCfk6tJl0Wzdt2UfA/t4976sS6+vKILwguaroK6+5y69EK4RuoU
	iEOnzZWrHhAJLOFSBPmRD5ggeCXjPyLSruQKa655ALwdXCmcAlt6cWR8IxhiaK3h
	LVb2IFuI1luOlG5F4bKz4o7cn40g3Qeyw6aSpde5Q4SED7W4idN1B/znNrOmUY/D
	Kw9mMhQmACBpIAqWDKSkdICE7rlThKl/ZHgzdJnWgcs5ipgDJOKy12Hlvc7KWbci
	/MAOCHHgQb4akmzEaO2JCa4dDgNFPFKvh1b/CVGSY7IFbH3VEt6sO3qr2+GuLpkj
	pvGPyl39Om+IMZuTjYrV0g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmbccks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:55:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582F8S4L030922;
	Tue, 2 Sep 2025 15:55:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr9bhjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:55:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVGCiwHDyv7/coDZt/D1jButTFeowPG/NfLBenV/fePWX0XjDPdK5fa29EpC9MripwQ2/hPvz1HNkEwybG2DZQM9SreZheV/x6JAPdOVMIOzYFE5bB2apyV4t2reVFdv8CYFSr4NmqiuCR4KnK4xba0EUTR/g3h9jy8T7dW0cVizI3pmBy2Ore5fQexWCGAZaiETaluTupYBw7pfnTgVlnz+Cz9TcFSK80hY2648fOW5kJhb98BUZMNeJyj1SoBJ5VcfEzq3gXmobpuJXIddP+LdEcItWvMKN/jBw6uZ4vmKcgKuvXA4HL6HWRnlAJua2trln55X0iHffZN25aIS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8FWg5vlnruPx/9XKElJap1QKTFG6ktvZwwODqQOyug=;
 b=yls9GfKXczEByYTqL3Soapderu8RicGgeIFxUY+9zx7vko4ANB9dZmYIimE4hR3GvPH2CQOv5DhR1g0uhdBcGp+5aSc4K0XYktm8wuD7uWRssJ97C4GPtRwO0j1rFK8PmdaoKtTpXWyCIgkoGuUqjLlqFAbUf55QbXxIKdrTyRYkk6DCh2zOLDGMS9RStITE6tZ3VJURxvySvN5q343HIwr+gdMEjfwqj4NjVZe0BvqujW4PQwr4b9siScNjjEPoYoqgxAARyCd41W6a3YgmtilMRqRp47SzjwBHLaE2Es7O6OGSbVl02/pIqPIw/GXWjXbxRfWsue+fxB/dxH8bqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8FWg5vlnruPx/9XKElJap1QKTFG6ktvZwwODqQOyug=;
 b=zd4DLkNBHSpYSAuJ3W31se1tKOoSbjTb3QPZgUDjKHBGmZQ041czV6yy4YOx7M5+QwoMgcm7R5n4JvjGIWkbmkh6pAh/Q5BDU8+N+qZsBnu04Gh9RrxNV+1aX8MbMWEP63f/jpUpEY6sS5TavkmdlYiZaihMd1D0cs7nVdzrZKs=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SA1PR10MB7737.namprd10.prod.outlook.com (2603:10b6:806:3a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 15:54:57 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:54:54 +0000
Message-ID: <001c5111-84c8-4bb0-951a-cc51587479be@oracle.com>
Date: Tue, 2 Sep 2025 16:54:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/12] ext4: Test atomic writes allocation and write
 codepaths with bigalloc
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <a223c31b43ce3a2c7a3534efbc0477651f1fc2bb.1755849134.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <a223c31b43ce3a2c7a3534efbc0477651f1fc2bb.1755849134.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::8) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SA1PR10MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbb1cf8-9c0c-4e20-536d-08ddea390e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkFjOUNJNWF3eVlBZGVmL1QveG1CZnBiUEtEVFIxeWdpM3h3Tk5ESVh0KzA5?=
 =?utf-8?B?WXBjRlRQMUxZMmRDR3BlUStxNzlUZkVmTFlsUmMxMURPL3ZZaDhkTDZQQlhJ?=
 =?utf-8?B?VU1mUU8wd0RRL0Q0RzkxSFdOUUNlcnpWNXBMTTYxT0tMZFo1N1p0TUpEYkR2?=
 =?utf-8?B?bzhYTGxlazhnTlh5a1JlZDd0WDRiaS84a2RIZm9uakhXRGRzNUlkZGsrT3Fr?=
 =?utf-8?B?RG9OSE9LRE9QeUdqSWp0NzVENStiV1NKSy9oTnp3TkFDaWdnanoxZTUzaDJI?=
 =?utf-8?B?d0pXYkFEZUhjS2pHbzNVaE83bVQ5dG5SNkpzeTZKMGVyamFtRm1UUG1ZcE9j?=
 =?utf-8?B?U2l6VkpHVW1lTXlLWmh1TVFFbHdEV0NvbnR5QkRYWEU0TGhPazZEbEIrUVY1?=
 =?utf-8?B?Mmp2MWxpUEsrNlVjRUpGL3hKMUoxc3JTeWhCQU1VT2tuSHZFdmRFTVBYdkJp?=
 =?utf-8?B?ZGNHZ2NFeWJLNTJxaitmc3JJRnN5dVJESHhtTG1GbFF0aEdoa0JZSVZXTStJ?=
 =?utf-8?B?UWFncFdubEFCRFZ6dWFoNzhYcU5IbTRWRFhydUZzTkFkV0dUSkRWL0MxRFN4?=
 =?utf-8?B?aTlpYjFES0Z3cnZzZy9UYWxkbmZQOUQ1cEFHNTRCb3B1Mm1UaGphNGFJT2N2?=
 =?utf-8?B?Zkx4YXFHNkE2NTZ2YURYeDRRbnpSOXluN2JWdFVaWUFGeEFxckxBWnQ5VVBr?=
 =?utf-8?B?eFI4T2tKQjFjVDQ5Q29MUXNJWTVsbjdjdkxWU2g1UnlMS2dxVjgyanhBbGsw?=
 =?utf-8?B?WktBVlRLVEx4WEtUcmY5ZFIyN1NMaGpCUUx6ZHNYeHcwOXprSmk4RVFhRlRw?=
 =?utf-8?B?UGFaNVkvaVJkK0kvajdkbGRyUGlGUzBIVE02VUsvRTY0M1M1akJLdXgrTksy?=
 =?utf-8?B?QjBHUzlWQmZiVDVOUGJvUjlhS0dFQ1FoWmRjNTJ1bXRsV201L1JsbFJtT2Nm?=
 =?utf-8?B?UVI5aHk3YkVSc0dqaXN3QkViRzZmRzRzb0ZXRzZKRlgvVm83THhLa0hOLzBx?=
 =?utf-8?B?Z05vcm1IbG5UOENzeVBQaUpJT2JJQ1V0NFFpc240Q0pqNUlFWW90dFMwSEYw?=
 =?utf-8?B?ODFGUUs2S0daQlpYSHpBdFJwNVYxRDlwUGZLdEhWdnVjdTFTaUpzaG1QM1d2?=
 =?utf-8?B?dCtaSG5FTkFOdVNGVFdaZXdYTkNtZjV5TkkyRDdjOEJRL2FEa0dIL3IyV0JT?=
 =?utf-8?B?SXR6ci9obmxwTmNPSHN1NHN2MVZBQjFvTzFEVkttSEV2NVNlK0dWRUt2ajNi?=
 =?utf-8?B?RHpFVGhLcmVtSVVPYlR3SFBFZkxVTXZFUmRzb3hHbVNxRW11M0dJWFNzTmUv?=
 =?utf-8?B?dEFTTEtYWVN4aGFCVVozK0NsUDVuVU9GSUNJZG5JWUdwckNTU1VPM1FYNmZ0?=
 =?utf-8?B?ZWlRbVVKUWYwN1h1SHl3b1JZWFRtTFdtQUxvV0cvMHVhVjhGTnRuc2hiMFZX?=
 =?utf-8?B?YWRFT25NWE96bGQwZG1Ncll4RkNwK2JXaitTeVVGd1VYRUVldG9hR1c1VnpZ?=
 =?utf-8?B?WUJzeFJrT2NiVjNLcmptZ1d1eEtMQjg2UU9tMGhzT0lOZG1mSUxMeDZsMUR4?=
 =?utf-8?B?bVg5WkNlWHBEblFyTTJKWC9ZQXM1YzNQZ2RxM1J1cWYyU3gyTkRZRy9sRGo4?=
 =?utf-8?B?V0w5dXpYVDd5UjdrbHBYTFlrQnlmV2I2ckFMNVZGc25tSUhyOFZkY2lJcElN?=
 =?utf-8?B?ZVJZYUJiWGZxUko5cHRNcm9wTDd3d3ZEeGxKTWJ3Um1QdmVZRWxLUy91Zm9K?=
 =?utf-8?B?c3c1V1MyMVhQSkRxTFVVaWltaEZuZmdaRDUzRTRjbjFBVjhoOFNJZE13OHdY?=
 =?utf-8?B?aEoyS1ZicDhkeXRYcFAyNUFFS25wemUwSFhUMEhscWFkS0x5REhVVElXUmRj?=
 =?utf-8?B?ZTJ5amhGak9rTU5XQVArVjQ4NmlnanVabndIZURiSnV1RFQxN3JFZDRoeXI4?=
 =?utf-8?Q?Wd5nV92ETVk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rm1xZlFpOUdydUpoZVkzVURoejJTdFliTGQ4WHMrZzRsaFdVME9zekZqYmVG?=
 =?utf-8?B?eC9hV0w0elEva21YRW9hMk5abUZuVE16R1M2ZmZZNnhhMEw2bzRSWU1ESWpx?=
 =?utf-8?B?ejlzbHM3bXNRL3h2VGxacUF0V1p6MUdzTU9xdDdkaDVaK3N2WGRMNzN6blpK?=
 =?utf-8?B?dEF6aTR0aE8rcm13UU15MUl6ZlQwOHRXdVpUWFJqeTFaaHpnaTc2UnFwdzRi?=
 =?utf-8?B?TTB3SFFwcUQvS0JKNEMzME56dnpuRE5RbzFhbXJIdVlvTkxrOHljMFRPQzRW?=
 =?utf-8?B?UmxKLzBIOElMMkVEV0Rsbys2NlFmYWE3U0lVdEtUV3ljVzhoN0hRTDM5UUZy?=
 =?utf-8?B?ckZPYkYvaWovTW9DdXdQeFZKenFOOUtjL0NTN21qRUo3Y1BJOVc1TkM3NWE0?=
 =?utf-8?B?T3ByZ282VUNZNGlnTWpnQk1HdGZ2NzZ3M25uRm1ocVlkSUthYk5BMzg0K1Qx?=
 =?utf-8?B?cFhQajd6ZzdYMDJOQ3lBdTVXMjdUL2NNWU5BTnd5L3IxSFcrT1k3MStxNXVE?=
 =?utf-8?B?cWFhQ1o5TTZTU09acmg5K1FOVjdTbEJGR2hQREUzQWhocFlJL3NEL1dhR2NW?=
 =?utf-8?B?NERGcWFTQUdGeTdRLzhYbkFkaDZqQ0xPSGZSNW1DOEhUZjczckppajdyRWs2?=
 =?utf-8?B?R1F5ZVIyOW1NRldMclNxMGxnZExPTDg2aGFvZWhvZUpTa29UVHVaZWk2Wm1B?=
 =?utf-8?B?ZGh2bWUrLzZLano0cHVwRy94NjBVaytUYjhiT3Z4UXBjTkgvc1FMMEVPemVy?=
 =?utf-8?B?UE5oK0E3eHQ0ZWcwVW5GU002Z2xwU0g4YmRwOHlKaXFUTXVJVWlTbUhmUGNq?=
 =?utf-8?B?RmdGNUYvdmp5QVQwY1JVOEdQbnBEUXNVYkZ3K0laUHY1SFd1NHBSVDM1VDNM?=
 =?utf-8?B?TXdRZ0lSV0pYWXR5Q083QStuQXpEbUs3bEozOUdiUE5xYmVGUXZKVWhuTjBD?=
 =?utf-8?B?UUVKRmJteXJWd2RCNVhMVllOZHpMZWFMYmJSTkl0dDRDa0x5RHRLNkVjUVpY?=
 =?utf-8?B?c1lhd1JBT3F5REt5OFlWaUJIc0Q0VFlsS0Y1Y1hXU2k4Z1pJNGNNNzAreUtn?=
 =?utf-8?B?ZmlwSWpvUWZvVEt1WDdhVG83cGdNV2szRm0xcUUxRkVuWmRvSnZUT3M1Mzg3?=
 =?utf-8?B?SlVQSDliQm5vS1RPb0xRZmNxTVhmNUNpWWV5OGJhRktXVmJValNrcVMyZWRh?=
 =?utf-8?B?QkFzYXJnTHh1cWMxQnpnZ2VjTGx0R0hpR1hGWk5aSm9UeU9EaHlDVDFQUEF4?=
 =?utf-8?B?MXh2ZFZKbkFrT1NMWW9LVUJBMXByM0RINlY4Vk9KTXlLRGo3R21PUWx3SmVh?=
 =?utf-8?B?ODVncVVQakpXeWdCMW4xcTcraEE1WmgyTHo3eTFBOXc2UzlRTW5sS25tb3VP?=
 =?utf-8?B?RTQ2SzJMWVh4a05aV2tRSDZFVG5GQmMyZ1ZBdVhrS291MlVFZGdiZ1MxREhz?=
 =?utf-8?B?bXdYRnhQOFVWQVhrRzRXK09yaVFiSFpidU1kN0krTU5LTnRLZkpGVnZaZjQx?=
 =?utf-8?B?QUdjY3ZoNjJkWmVXUERYWjFka29tNnNOUGg4UlJwanFDYWtPNVpxU1M3L3Jk?=
 =?utf-8?B?NUI2RVkyek0wV0RGSk53clpVRTBMOEozdW5kRWUzMEV5WU5aNmJ3OTJjNzdS?=
 =?utf-8?B?K1crRC90dHI0emU1YU0xYkNTSHZJUFR2ZmZNeitOdUd3L2p5K0xTZmc3bVJK?=
 =?utf-8?B?WC9WUktkdk5XcEZERGZEY1YrNHAvYnZQdkhtRW81T2tIZ3pCaXVMZHRmektK?=
 =?utf-8?B?a0RCN0RhMmlqZHF2TGMwUlJqRS8wM2c5WVhVbXBlNGFCSzhHcmh6ZUVpNDhx?=
 =?utf-8?B?ZVNBRGt5MmRvN0x2cGhHWmNRVTU1WVQreUlvTC92L3dQR0cyUzhheVdsZE9o?=
 =?utf-8?B?bGkrcTdKaUczVWc1cHdLWmp6a1V2djVYVEp4THgwOGtxMkp6WDZYcmdZY3p3?=
 =?utf-8?B?TkRpT2tVeCswTHovZ0E0c1dvQ2ptcmkwTmtDYXcwZHdzcGxDWXNxcUplK3lI?=
 =?utf-8?B?Y2hLRkhXMjRodm1TY0E1ZWlqT2srNVJ4QzlkbW9FYS94azdNSzVJcXZwZWVF?=
 =?utf-8?B?RWlDaTc3cTd5bGZtMktnR2tXMXk1VDRneEVCWElFTVY1N0o3Ly9EbjNucVdj?=
 =?utf-8?B?SlBLbWhXdnduekI0Y0krd1k1eWNqM3dobXMreFc1RzVtUllCSTdoZVFpenpr?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4RecXh7OXOfHcNtBymQj0RtYeG3V2YyOz3W2w6LLAb4rt/roMAZNB4MTPZzCDUbWTQO3wxPLHKNmqsjRUieQMv2ftp0w4MG3X0CbnClTCE7rClxQFhF040YXi4tmqSd8GlDeegdk1/taYwe4eKW+EoR+7CvZR8AmIYzfdnqsq3DLLqaqAnB2MvfKI1tiUppFpCexlQMN0rpig/UfWQOJkYuOjp0U9NNpzHt/ezFDYox1EZIRTQ/sFnuY3BGYni3ztqNEuFffZMx/0vvOebvc9LL5roM5O2i7bU2ovbjmynxqdvLaRUSK2N2rwM7VKVj9bXj9OpxwMqVeBu7sg7C9DDiP5cXucvlRwcD32H0HcUcmgTbCux4vRfr5bWM2r8t6c3s05ed+XiNLgh/AosLmjkxJt3S2OT7T41qHUQnxC4rl21KBd28N3Eh2PK+K+/PNBfK2dUho1YhmY8gqVkDlmopy6N9/UBLjrtwmd7YCMGYA+NGk0PiQkDymlFUwL/J4nh/wusokHtleVH+YZH5CZqelWoy/sJblKIVGFbz1BEM6h43ZJn3eT9LtckMWSpyGEjHmqMssb0VOcw6IiF2mpJ/DMZMVM6uwKZv+EuyX7sE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbb1cf8-9c0c-4e20-536d-08ddea390e8e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:54:53.9858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNZNVlNC5998Vpqb32UGGzE5wGpTtlUJtx791NgokI9s65p0LuEYDcOASaQVbEmSGfDPw2E4yXCRnZy/S+PDWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=912 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020157
X-Proofpoint-ORIG-GUID: H6U9BRG1tvJWTMtOtWTvNjXbuuj4cYiU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX7e39RnHpnQ7E
 VSJo0sGgrLBEI/OHx4zkL5JNu6enRlvEAtS8hrgI7XrE3YDjHuUZ5JEPO2f5BtM64QExt6eujVj
 oYbjKoL/bxaIozRkq/+4qT3BUzxN41MyUXASdiPgX1DALkZ+dkhxI4AJwCeyQbug+9J2CauZ0sT
 5z+m3FnyJHTGD+Qj/WJzYZchpjjWTHttwc77dui/BMQHWS8wgV6fkejLMXLMq9JtaDZ36lqfeHO
 nyitjGNrnWINzMTjoU0x+rzIs8OWRmT2Ts7HCqEwWrCAcqcKQ+xhm99Lv5GQdlmYr3Xln+dWCDE
 nK7QIc44q/S8O50J2Qf4WQ/u8KXx4lWvjwrZwYW0h2+l6aYQh+6HOhbhUp7Ohc4R4kINzP3E6UK
 YerU+VohORNubEx+3JkilxREs+r2pQ==
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b71355 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yh40tH4GH79cOMUpBhEA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13602
X-Proofpoint-GUID: H6U9BRG1tvJWTMtOtWTvNjXbuuj4cYiU

On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> This test does a parallel RWF_ATOMIC IO on a multiple truncated files in
> a small FS. The idea is to stress ext4 allocator to ensure we are able
> to handle low space scenarios correctly with atomic writes. We brute
> force this for different blocksize and clustersizes and after each
> iteration we ensure the data was not torn or corrupted using fio crc
> verification.
> 
> Note that in this test we use overlapping atomic writes of same io size.
> Although serializing racing writes is not guaranteed for RWF_ATOMIC,
> NVMe and SCSI provide this guarantee as an inseparable feature to
> power-fail atomicity. Keeping the iosize as same also ensures that ext4
> doesn't tear the write due to racing ioend unwritten conversion.
> 
> The value of this test is that we make sure the RWF_ATOMIC is handled
> correctly by ext4 as well as test that the block layer doesn't split or
> only generate multiple bios for an atomic write.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>   tests/ext4/062     | 203 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/ext4/062.out |   2 +
>   2 files changed, 205 insertions(+)
>   create mode 100755 tests/ext4/062
>   create mode 100644 tests/ext4/062.out
> 
> diff --git a/tests/ext4/062 b/tests/ext4/062
> new file mode 100755
> index 00000000..d48f69d3
> --- /dev/null
> +++ b/tests/ext4/062
> @@ -0,0 +1,203 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 062
> +#
> +# This test does a parallel RWF_ATOMIC IO on a multiple truncated files in a
> +# small FS. The idea is to stress ext4 allocator to ensure we are able to
> +# handle low space scenarios correctly with atomic writes.. We brute force this
> +# for all possible blocksize and clustersizes and after each iteration we
> +# ensure the data was not torn or corrupted using fio crc verification.
> +#
> +# Note that in this test we use overlapping atomic writes of same io size.
> +# Although serializing racing writes is not guaranteed for RWF_ATOMIC, NVMe and
> +# SCSI provide this guarantee as an inseparable feature to power-fail
> +# atomicity. Keeping the iosize as same also ensures that ext4 doesn't tear the
> +# write due to racing ioend unwritten conversion.
> +#
> +# The value of this test is that we make sure the RWF_ATOMIC is handled
> +# correctly by ext4 as well as test that the block layer doesn't split or only
> +# generate multiple bios for an atomic write.
> +#
> +
> +. ./common/preamble
> +. ./common/atomicwrites
> +
> +_begin_fstest auto rw stress atomicwrites
> +
> +_require_scratch_write_atomic
> +_require_aiodio
> +_require_fio_version "3.38+"
> +
> +FSSIZE=$((360*1024*1024))
> +FIO_LOAD=$(($(nproc) * LOAD_FACTOR))
> +
> +# Calculate bs as per bdev atomic write units.
> +bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> +bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> +bs=$(_max 4096 "$bdev_awu_min")
> +
> +function create_fio_configs()
> +{
> +	local bsize=$1
> +	create_fio_aw_config $bsize
> +	create_fio_verify_config $bsize
> +}
> +
> +function create_fio_verify_config()
> +{
> +	local bsize=$1
> +cat >$fio_verify_config <<EOF
> +	[global]
> +	direct=1
> +	ioengine=libaio
> +	rw=read
> +	bs=$bsize
> +	fallocate=truncate
> +	size=$((FSSIZE / 12))
> +	iodepth=$FIO_LOAD
> +	numjobs=$FIO_LOAD
> +	group_reporting=1
> +	atomic=1
> +
> +	verify_only=1
> +	verify_state_save=0
> +	verify=crc32c
> +	verify_fatal=1
> +	verify_write_sequence=0
> +
> +	[verify-job1]
> +	filename=$SCRATCH_MNT/testfile-job1
> +
> +	[verify-job2]
> +	filename=$SCRATCH_MNT/testfile-job2
> +
> +	[verify-job3]
> +	filename=$SCRATCH_MNT/testfile-job3
> +
> +	[verify-job4]
> +	filename=$SCRATCH_MNT/testfile-job4
> +
> +	[verify-job5]
> +	filename=$SCRATCH_MNT/testfile-job5
> +
> +	[verify-job6]
> +	filename=$SCRATCH_MNT/testfile-job6
> +
> +	[verify-job7]
> +	filename=$SCRATCH_MNT/testfile-job7
> +
> +	[verify-job8]
> +	filename=$SCRATCH_MNT/testfile-job8

do you really need multiple jobs for verify?



