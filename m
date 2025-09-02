Return-Path: <linux-ext4+bounces-9791-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C44AB40895
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 17:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D37916549F
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 15:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B48C31AF1A;
	Tue,  2 Sep 2025 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V2ANlKKL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OaF24n+I"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFBE280025;
	Tue,  2 Sep 2025 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825782; cv=fail; b=pHIC7eooBBCkygfCVV+y8kOnAUBN/8V1UaEkRky/aTgiqbVN/qmgtX+qFOBM6gZEVAtQ5ZdSnShXncdXsu2cUbv8fW5UMyl7xsH7LQTjQIOi0L57V8zN8x/wsWI/6peMAAO2fEhbTe1lzNNr9N0gCuirSXClEK+lwzlkeueUq80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825782; c=relaxed/simple;
	bh=LUKueaP4csKTFUWaQ5IC9xswegblLDoh87/5nz8J+DU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eLbP7HHSn28mEal5YJc5S4p5gY838CanSBiLyWCky9S26LLvxvU0BJ2Wuf7flRRf5eRbat+a3Mofif5kSybQS01OPFZpndwx4QQXMtWvMjrxysVvPzk+9p4f0ld5lxY8YI34rJuPEdc92hoVyCidO1vQsvhqfiGYuBHJnq0E8aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V2ANlKKL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OaF24n+I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582DgH4p023531;
	Tue, 2 Sep 2025 15:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NUeUOBbCHOnHm76datBtY3s5qhb9KDakzDvV+E5pq7Q=; b=
	V2ANlKKLvdajzV1OmluMXr6lgbfJ9TlVOlPuk8wBqzzz/iJlqAgMrlUs9lfGDwLI
	6eqTReiGjhK45yl+DDlCnQWynsFA3S4H90ZYt/HNcQPB+AJkBeDH+KCfIbmH7z/v
	TeACvFKyA8E8UjYyLG7h3uhd1NLkMQzapqgk9kYYfxkPfYYHmE0PFW3IAU+U+lwG
	3voUfE/XwYmi5dVeE+t+IQyVJyHUE/RwBFCqx5cVfepPIbziHTRzqOr6hSnC8BgF
	i5v4V9CKShuST0rhrfyZitCwpd9BJZ6G1oMTZZCxRfdfjXLXWbk8g+IAW6op/rOS
	kJlDS5pevOXDMvGx2Gt9oA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmbc937-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:09:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582F231l040037;
	Tue, 2 Sep 2025 15:09:30 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrf9jma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:09:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzN9fNwWfVQsqIurSSXI59HRphawBiQ2FuzQum4Y/accQqjF7jHqLkcijDkGIKHkbP2tzxkuzmHOeT05lJsBQ+tPOQyQddATqOAOuRTC8HwHC0cMHSlXPJe5rQaIKkhUN6lC7cuRjpS5RZJmiCdXZ01nINupv3kTnV1nmECdXvfa9r+dJgqJVnDIHXuEaaVXavnC7xV5hnU9elmzBBi/FxfirgAp7lh08t2glrmuCxC7yEcshZIzDkwAVpWnjmSFtZEvUAlWGsqw+WZUoL9CbOzi6UU+KTyAFUTUGTeRt9KzI/u1jMaY1zYuKNVQ2N8gdlLEx1cW+aV3rbYZCA9VPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUeUOBbCHOnHm76datBtY3s5qhb9KDakzDvV+E5pq7Q=;
 b=S0ZXe+tU/kZbXC5TUdhr+IaTb8HHRiqt0gsElkTUFkRTOBMjyH77h3nTOllIQgnjYPBJA0OfbgEu4+FWt4kYrrtQbvKteuhF5Pmml9dXHoG/HfE2B5cV9UtcsRddcfihGNpvTT0y/a1du8A6yqCW96+DyX9SqrVI7m7uBNZ7QDsBWQTiOXXZZR1zq1EEdGEZ3P1GOywd5cXf2dahM3u0pbiwnqsAD+Cjr+AW5odEaj1B7EzWZ6iGeiISr1yAZDDW3IqKfGNRp/K0wqZia7JLgpcarM/JKa6ce+VYUb/e+1JsBRaD+T7uzPj7m4I8ASWGsvRuXpzcy3IiP0UGAk3Kdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUeUOBbCHOnHm76datBtY3s5qhb9KDakzDvV+E5pq7Q=;
 b=OaF24n+ITrvX/NPB/4O6vCsGDqrTND05/YwnbMneyq9mAPL+ouKOBaN1D5XSMQ7ZIFXpI26nVtJO0O/MMUNHEFYqFEkrlhz3qUHn/Ia2mvY3lBcJ3SyMBq2NG3R1C8XNANtxdiauxDK7DfeVRSFRFYDISYVuTIYPKF3G+9dtDZk=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by MN0PR10MB5960.namprd10.prod.outlook.com (2603:10b6:208:3cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 15:09:27 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:09:27 +0000
Message-ID: <184e4080-ff02-4d75-be35-ab49f61dbd3d@oracle.com>
Date: Tue, 2 Sep 2025 16:09:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] generic: Add atomic write test using fio crc
 check verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <90241ec96d84e6e87d8cf8bd0d0d75fcc296757c.1755849134.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <90241ec96d84e6e87d8cf8bd0d0d75fcc296757c.1755849134.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::33) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|MN0PR10MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 1339ee39-c8ab-455a-aa00-08ddea32b569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UThpSEVvUEEyUlJFSmdHb1NDZzFtV0EzNFcybExKQnlaRmNjb2tBVllFY2FX?=
 =?utf-8?B?MVBXb3BSWGpSNWp3eDB3ejcrUTk0aDhHaGtsOXFlR1dRdHo5OHJjYy94eStn?=
 =?utf-8?B?eHl5RDB4bUpUZjFuQmpTNmgzWjZtemRFLzk3ZS9QNlRTVHRiakRVSGJEUmFk?=
 =?utf-8?B?VWRHNCs5MVhkajJrekxpT2RldVdGMVc1M0R6RHAxZ2ZSditLQWtBUDZNQnpI?=
 =?utf-8?B?Z0dvLzZEV2VDZHM2YU9UOGR1STRGMnRSeGpNb0hSMGlHL3MxZ1V6d0lFZUli?=
 =?utf-8?B?UWhBK0p6V29CaGpoeXkrMUtUblo5dnF4azRTajcyRFgrbklqMkpSdTU2ZDJh?=
 =?utf-8?B?clFPQXo2VmtOd2J6Tk5kTjZHNExNSzNkUTA1Y1d1V2ZheG5XTFJQTGxWSVZr?=
 =?utf-8?B?UkJtUmcvNnFZMnlFTVdxL3RHcm1CN2Y3VUxHWjlrZFI2bkR5cmxxaVlJcENn?=
 =?utf-8?B?L282L0t5LzBIa25VanJ3QzNNaWUxdTBKRlRmaVJkVi9TeFdlWmJ2SFZTZnND?=
 =?utf-8?B?Y00wMWZvVkNsLzJmdW40WW0zZ2VZTXcveHVyV1AyZ2IyT1E4c1lJa0VEUUJC?=
 =?utf-8?B?V0lUZitMK3A5UmpTVlR3REZGMS9GRlZFN2RZOUphUTFQZlFCS0lOY202c1cz?=
 =?utf-8?B?U29Ra3JldzJkanFVaFRGZGF0NlRIN2ttU250UzVZYnowajJiMkM1RThXcXBx?=
 =?utf-8?B?VEE2SHhiZ2JtNjJiRlUzdnVIWmxNMWJkOGhzckZyTm5lRGdyUEdZMTNVUGV6?=
 =?utf-8?B?dEFGbzhtamwzRDRhNFF6MDkyeis1bTk3RzF2eTNpa0lEUmwxVmVvbll1TVR1?=
 =?utf-8?B?VW10Ykh5T3ZtOWxGdlRpczB0cURweXVWTGFOelY5N1NJcVRIRkllZVEvY091?=
 =?utf-8?B?WUcyNG55dGhwczcwY2xsb0xqQ2Z3WkFBc2FaUHIxck5CZVhZNko5UGVaaU5Y?=
 =?utf-8?B?NTBFNTVwNzNneWx3aHJiMDBUOWhndlRhMFBrdzM0ak9YRUxjNU1vT1I2Skdp?=
 =?utf-8?B?d3k0KzRnWExPWStlSzFuOVJMdjZiSUtDL2x6b0RJaVFQaFdkZ0M4b2Q5T0gz?=
 =?utf-8?B?N24rRFh6RytVYTJVT09RekEreXdCWlB0UEMrdGJKdkRvNWZJM1dKblFBMFZi?=
 =?utf-8?B?NWZyWXpERDNhNHhZWXE0dWJXL0JiRjBzUnF0UDBsZDhqNFc5by9yZHM0NW9l?=
 =?utf-8?B?K2t4VzRuSWVETWx4TWttU3NqVFA2MU1FVEpMQTNsSzBnMVorWk1qcWVGUEVh?=
 =?utf-8?B?cHhpNFV3bHkwYkRvNjBhS2lxNFNRRjJGNHA2SWdoOHlmNlVSREEyb1B0eFpG?=
 =?utf-8?B?NktIRjl6ZWY4b3JKbzM2THo5ZUkzUHIydlkrQ1NZUWdwVUFPRmVVS0pRMm5Z?=
 =?utf-8?B?aSt5QW1JTllQcHJwaTJDN05lSkh3aFlLRmpBbisydXA2aGdRaEFNRnVLbXV4?=
 =?utf-8?B?dVcwa2dFaFVxUEk1cTBaZ3lpUnFmdFhKUTJRck92TTBLM2FZcWh3U2pOd21a?=
 =?utf-8?B?T1ZFMmtHdkUxeWIyYllPOHJ4cWRQVTBXVHJuRSswa3BFRFQyOVQwZ3dEL3h0?=
 =?utf-8?B?SzE3RE5DOHlRWFM2OEhkWVNPZW4wbmVYUDZVMGU4WXdyeE40bENxM28rODRQ?=
 =?utf-8?B?K09tdFlldE02bS9kMVQvdmo4eGtuVGorMWRaMnpSUlNPcUZUY0lGenNYWkFZ?=
 =?utf-8?B?eXRNTy9VTkZucXZhdVBRVGx0RmhFdTNncFc0b25VMC8xeDBvcUdmRWRlMll0?=
 =?utf-8?B?dUIzUFlKMzRzT1llbWtFK3NrQ3BzV0o1cnMrb3VBMjByY2w1TFJNMUVpZnpE?=
 =?utf-8?B?QVlmSUJVK1JrdUdTVDIrRCtZRVhSVFVqdkRDZ255dHVLTFljK016N2VIQzM4?=
 =?utf-8?B?U2VoUEpoaEpxTW4vRFNoZFEwLzVqNzE4ZmQ3THpLMkhXZEl0T0xzZTk5Ylh4?=
 =?utf-8?Q?w/JMbWU+JoA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVh4WEY4clRoNy9kZGxiUFkrc3hWNHpkWVN2NnFJaHZzdk5hc2dOTmtnL3ht?=
 =?utf-8?B?SWdQMEU4OXJtQUx3ZmpMOGZDWEkvQTBtVXRsb0laN0JibmxUdTMzY0kwSDd4?=
 =?utf-8?B?MERacldWZUUxTXJLQi9sY2NqMldBelNBSXhJQ25LRXBJODdsY200T1JZSFJJ?=
 =?utf-8?B?bXpNM3c1T1pieVgrQWZlbVoxN0loMmpNUWUvR1JhNHR4OVVYVW1GVmc0STA3?=
 =?utf-8?B?TWlEWHdYdXo2ZlA2OHdWcmxiNndzK2FVVUQ5eDB2WE9BK2xEbTVVaXllN204?=
 =?utf-8?B?TGtOOTVzOWlPZGwxTnpnUC93M1NQNFNzbDhBQjFmcTBtTG9yMTlkNW9CU0RG?=
 =?utf-8?B?WVVJT1lxcko2R1dQb2o4ZmpadDNqTkh6Y2hBRjNUcWUzWWVsSjk2QVNkeFYw?=
 =?utf-8?B?YVRDY2RuaVJwN3NiRzdTbkxLcDZoVWlKaVhBWml1ajlUVmVlMkV0c0xxS3hH?=
 =?utf-8?B?N0RhVCtNaHkvYUJhQ2NuaFhoeXM4MWVRNFdRb3pvTmdFSHVEQk4zb3FSc3dJ?=
 =?utf-8?B?T3J4NE9VczBkblhnUlVORHZCSGxZTmtUbXBYODVEZ3gwQVNnZFZPN1orM0Rz?=
 =?utf-8?B?TzlyWjRkcnpOSytTQjAyQVdFMG41MndJSFpLUDdIalczek00bFN0YkY3SlpQ?=
 =?utf-8?B?NDBQMnJsbnZqYkJ6N1FYTE1HS0hCdWR4MHYxbHNPd1pYTUJGc29LbkhVTExG?=
 =?utf-8?B?cmFaQVhIYlhzWjBEdGl3V0NQWms4c1NqeitzSkQrVTN6alZtWUpVRzVIK0xS?=
 =?utf-8?B?S1hhNkFuaTNpV0xmRDE3R09waitMYk45VU0zNWRkVlhVMlZKYTBseFVXd0Yr?=
 =?utf-8?B?SHdneWZrRGFZR2pjNzN4a2NsMTZrME9vUWdCRFV2dHVCZkpEVkduVzhNOUt3?=
 =?utf-8?B?ZFk5Nzl6WkNzKzdDa3JCdWNha1VMM25WRTNqY3BLbVA5eUVHczRtbDkzZTU4?=
 =?utf-8?B?WXZDREJWL21OK212NFBZRHZnQ1NCdnpYRG9EN0xleXF6ZU9yTjVkdUN0L3JF?=
 =?utf-8?B?RnJYU2RSUFpxWUhDem1iM1l5Sllob3hFKzQvRzNodkdOL0hZY1FHUTZEa3ZZ?=
 =?utf-8?B?cUw5eldqOG9lcnQzVGgzcktEWjlSVkg4MGprbWZqWkE3YThNeFZXNkhLUDJz?=
 =?utf-8?B?a1ppTTc3Yjk5Y1pyeSt2K05YWEt4ZDRrb3ZUK0JNbzNyMFlEbVc5ZnYzb3pD?=
 =?utf-8?B?QmVJYUl2bEJkaHFuMFZZM2FiZGtuaDJ0aDF0WUhtSmw2NEhKWGd0aG9GUlVZ?=
 =?utf-8?B?bysrRjhRNWVzVkxCRUZCbUV4SlFCV3hxd0VWVTdjMFhwUGdzd2U0Tmpqd2ZC?=
 =?utf-8?B?Z3lvSW1OamVJMGozOGhiU1FKaWw2dGFITVVCQnY0Ny9sUHZMNXBZTDhoMkJp?=
 =?utf-8?B?SUdGb2ROR0t5U1VkeU9BVk03M3RMT1BlVXJKSTcxS1BrdGovbXB2cEhSTVZp?=
 =?utf-8?B?M0d2VlhJL0lsU0ZlMFY1TU5iNHhTa3dSb3M3S0EzeDk0RVRzb1lTR20vdUF5?=
 =?utf-8?B?S25xckRwdEg3QjZqWHdVTGJNeWpFQXE1S2taRzkwZ1E1bVdwN0pyTTFJVjE2?=
 =?utf-8?B?UTI5VExWdnMzWjFPRld6RzZTajdvR2xIeXY0b3R3dFJnMktaSStlWmZaUmpZ?=
 =?utf-8?B?dnFGR1V3UnhGeWluOS9yRjg2TWF4QmNud0wzdzlWSlJNWWl1ejA1cm9wUGxx?=
 =?utf-8?B?dkE1RWZzOHM1WTR0RzJRcVgwSlY1UUhsdWZjYlZBODBhM1lVYVRPdG9xaXlw?=
 =?utf-8?B?REltaG1kcUVranc2SHRoQWxIYmZyQzlrNlpHUjRDYW9YR0phdlFLajNtYzBS?=
 =?utf-8?B?RzROTzBhdVZXYXJ2NlBYc3Z3VzFSUUJSSDZqY3lEd042Y3Vsdk1BQ1Y0ZTMv?=
 =?utf-8?B?TkR3UWs2MENrekIyazcxOHFjclViSFdONGV0RGJqbkhGdUY5Yko2SHNHd3Rv?=
 =?utf-8?B?UkxjMCtJL1VoK2M5SkZ0WTRNZ0c0aTdBMnR4RkdsOHpKRzZENDd0bkxjZm1x?=
 =?utf-8?B?Yk1lWDJJTkNVMVg0QmZLSlZBd1RBRStpUU9BaitWT2Q4NU9HMGhBL00wZk1O?=
 =?utf-8?B?TVRlUFRrWVR2aUExcE5XWFJTbTFZQlN0TW8vMmljaDQrRW5kS2diMTBJZmFD?=
 =?utf-8?B?NnJxNm9TNzRDNDgyZ3BvR0ttbEhOaW5zaDlFM0ZYTWljNUZ3MkRySHVCeHN5?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ozu1zjIuA6ooeF+xiKHmLi3CLB3fcNtK9jl5jRieMKkEAuU8nAEmThtEPt4xKNc8ABsz1jsPFuLgfW45ofSHvHviB/veoYLZKHvBZL8k36pRJT7dYXA9jKM6P7QBvp5P6KNffaeGjjFmLl100MmkWcngwVDpDiwNwC1l/+55P0uJHOgXiQzISsjWfOavUVGxuOzJTYtGQUzyIHT4yLjvab2C60jcKQ2mL3D4jPPgL1pceAcg5TCkgbDMlnBttbqAXOHE9DvYXie4ik74PqyRX+Gh61CvWmtmMZjpE0XAVjDjJGD/Dwm+kgIImn70m1m7P7N2nRGSq8N63eoF/hOWFH01KcRNhrdDDWDB27IaW+Wgk2jdZJMHXnWhgIidgHztngTs7BBEcsP8jR12PJgaGSLg/Xeqbh/DKAh6RgM1BG1UMxEutRp/aFk+Ca5NhFBYF7f3TfjCEQm2NpOJR+Od0eSS9h3/xDFY6h9YEmWwNzSIkPdxXe1fikFN1Lm1BaDQyDeCFWtzepQgesT8gpbilWywt/GafyImTI2M+rrhKVMpuN78M5Zy0WA0jmzOJphalEdXMfOoE1xvUzcY4BlPCL/NOkgezBhiulE0ABU2yi0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1339ee39-c8ab-455a-aa00-08ddea32b569
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:09:27.3007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NckJENDWAHK/8TFAot7T7DVi/U8NVqZ8e9sL7sJk6xwyEF4UW50dfJhujdxGO+F6t3MikEIOYXlJpXBmCJd6VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5960
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020150
X-Proofpoint-ORIG-GUID: _zKLY91B8uuouaM8DNds3t0nuCPk7ahV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXz4GgGSPFZh6m
 knBI+4Mw95/rjLcC8Hxrswg8NQBNBbYl4NErn/RnzQlZOdH2l4ceqawp0cAtEwsb2z9rZRwcHzD
 jrXG3HPKJsEBVbvQOzdNN8GiN/RUpzBrYrYKywk5NVCKCnjhH5+9+8beOjZM/o1udNnhI5DQxGR
 4rX6lvRSVP/o9nGqJsrYSwRU50OxcuIVddDT9mXBSkANGEAMkyF5fju72HJwYnsK9naa4JDXhz/
 g3hTqvDBbTAXQFk+0KDMlT1Id+HjS8hjt5sZYpaeNNiMdpKPjPKOmf/rkl1+xcmgIeoCt+HO90b
 yQGgC8zhNTX5dJQ/Ij5XWPSoQO0A9O4ViOIGH5ogjXVqHPKLUZpjeuLNI2SMahHMxUJbqjMQxsP
 jUtzm9AmnXxIQ7v/pIFg4u0vZBcr1w==
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b708ab b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=NvF4lAQMHjoCzETZFZ0A:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12068
X-Proofpoint-GUID: _zKLY91B8uuouaM8DNds3t0nuCPk7ahV

On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> This adds atomic write test using fio based on it's crc check verifier.
> fio adds a crc header for each data block, which is verified later to
> ensure there is no data corruption or torn write.
> 
> This test essentially does a lot of parallel RWF_ATOMIC IO on a
> preallocated file to stress the write and end-io unwritten conversion
> code paths. The idea is to increase code coverage to ensure RWF_ATOMIC
> hasn't introduced any issues.
> 
> Avoid doing overlapping parallel atomic writes because it might give
> unexpected results. Use offset_increment=, size= fio options to achieve
> this behavior.
> 
> Co-developed-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
> Reviewed-by: Darrick J. Wong<djwong@kernel.org>
> Signed-off-by: Ojaswin Mujoo<ojaswin@linux.ibm.com>

I am still a bit skeptical of the value of this test, but here is my tag 
anyway:

Reviewed-by: John Garry <john.g.garry@oracle.com>

