Return-Path: <linux-ext4+bounces-9038-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A2CB08DB6
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 15:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC13580B57
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFCF29ACCB;
	Thu, 17 Jul 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pUBe+0G3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XE87tL+4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8DA1448E0;
	Thu, 17 Jul 2025 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757234; cv=fail; b=a3f9enrSxHCxYQmTrSzGbLQCzfwkdP8+yzXiY093LgooIVdaCPAYe/gQ5LgU7SFuyy8RB/KwzJWg14YmjwWQ37waPL+O4M0HNfwR46ceELVnoziyp82Kf2bUncx3R0Hnur9au0xh9ffSTXns3d6+JCKXU9e+oiQBUwfP4v4Yvtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757234; c=relaxed/simple;
	bh=ho/cwwC9vQCJej0TYubmNmNXNeYtaooTe0QdwKMMwEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JgrX8ivffLcySZcW1VPmNf+Izvsiq3voiwZa3+Xej6aM7CyxRMnZXF9kmfzw/x8YHvoAjfhq0UZhmlq+LD/FvIFcrc7vbWOX89PJFz5/lfa1vlspDipovJnhmnOIi77Dwfr5xNYAnLG6N9r8IYoHz4WdsVbePl6+WsKLUm35Qx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pUBe+0G3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XE87tL+4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7fkFF000983;
	Thu, 17 Jul 2025 13:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pgSdJDakefftDxVbdVlUxzhM3eVuzTyMhDOf0kjy//Q=; b=
	pUBe+0G3KB1UdJ5d2gP9yWxR60/PnclgYTQ1AyEbBWrWI8SrxM33fI4M8Fc/Y5Hl
	FMEkJnZM6XCxsaa2BYxj8m3+4hgft+o3JFasbd4ZInMZ40NPdOn2tPWz1bLUANca
	KO3qf0bfzIFsIRPcNG/RdwuWkbgRV7ekJn1b/gUEsjagVVf+FXRXtixA9+9kXy+S
	PpbJUzGK0jPbzm79xtRE/8AT60p9CGp8rMLRPOiJHFz4L+x7/afV3MUqcN1XlGCy
	wQi2JNWD0eTPKfIQNfxWby25dfokVt0uIRAC/CpppccUzYazeOjYtfcqClC5DQEv
	XqJUMrvcsv/K4rWVpgjcfw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b2yn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 13:00:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBIuYR013061;
	Thu, 17 Jul 2025 13:00:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5c6g88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 13:00:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTyCBVllTa8TuzRLgnlwnRk60mvgt57xPA7WO5U/FpttgKmORAkOx83rLXwRm9rGUttb/0l22ZLki0HEBYNJ1KREYyHgbbT+BunMKKO59aAkarLeC5Dw0aPWAvOK/r0Fc/8D6z8d6lz5i6CluB3+XzA4nnCza8jKK+8ETZBwDJr4o7bT+zxMTpUAsXtvbXjheDDen2hVo1iVppbSDQtpwVyBEFisMuWvxY/XE86rCwGg0EDKMYt6xXE0uWv8hNWKYGldonU1CGfrsTrrkYYLsjWTTlDQYApq8WWXP/uHO76QK4qdVya60pEPrQI/QhUyXwKd3E312juAYSLxlHfk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgSdJDakefftDxVbdVlUxzhM3eVuzTyMhDOf0kjy//Q=;
 b=PIeU2B3lGb62AhRKaFTWb7id54Zo+/Fptbaa4UQFGW95Ci7DPQ2UsX6epetyL5TnKAFVxgbZF0tJHHgL2WB/80ReFjX1dpBwSvz3O/OYYjqE+agxSBvsuzq+701n4x/TBqy1CG1nzaJfszP7CL2MfmOrr6RqMp46b3PiInOSlpnClEmdOENsAVVlK8XuUuwN9FDfo6TgVJ74EvBgSTZkHlFt4m2CcEw801FdzKGMp7ULn8SD4qXKbUVW3kmtEgB9yX/rOGhomeoHrQhGJBLRGiN3Yb2xMAgoGn/H/E3lk6HVqahs09Q19qA+kOQv+hOfZ5eqdykwbj8qb2aM0LgC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgSdJDakefftDxVbdVlUxzhM3eVuzTyMhDOf0kjy//Q=;
 b=XE87tL+4yYwPKhGiLhA2eTOupI6pmGM2TbbIgFZdPelKMZkmfxRIRXg5u7t8gHrU6NETF6LeNwA9/3z05qs4MsidaGlkZTGi1lM7Zu0hU/Faz1r1lVNFnQmPfYY919URS2eb4TeYm4eBvvuoZGegzMO0KD7Vmlp//SVPt3bAi50=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by MW5PR10MB5852.namprd10.prod.outlook.com (2603:10b6:303:19c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Thu, 17 Jul
 2025 13:00:22 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 13:00:22 +0000
Message-ID: <5211dff7-579b-48ea-8180-72d8c6083400@oracle.com>
Date: Thu, 17 Jul 2025 14:00:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <1e6dad5f4bdc8107e670cc0bd3ce0fccd0c9037a.1752329098.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1e6dad5f4bdc8107e670cc0bd3ce0fccd0c9037a.1752329098.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::17) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|MW5PR10MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 266f9e20-c111-4239-d9fc-08ddc531e393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXR0UlZwd1VQNEs3S0xFL2NNQkQ2dWRnek5BdXJUQnowTFlmRE9iM3NmYXBY?=
 =?utf-8?B?Y0p5QkEwbzJoS1d2c0hVUTBGR1lVMTA1YUEyVXMwWHUvRkZodTh4TnM4YXRa?=
 =?utf-8?B?U0Y4cjNiM255dEZpUDBjV1Jud1ZhaVJNMlZXTzZIemRmZ0U2bm5Qa1d4Z0Z3?=
 =?utf-8?B?Z0lTS3plTDNEUTVFWDA0RDNKeEtjc3hRb0cwS29PWFBpa1NWZlpvWlQvQ0FM?=
 =?utf-8?B?QW5VVHR2QmlBeFI4dDI4RlBVbEdycjNlU2JqY2pQZCt4b3dpV1A2VGkwczh5?=
 =?utf-8?B?SjFwSmxVZjV1UTR4dnprVjgvdWIwQW13SHNoc1QvbDVPQ08yNHVWNVhUTE1Y?=
 =?utf-8?B?Wm84RzROSHBxUENSWTdhYnFkTWdWWGhlb3h0YnhBZUxvUFh2MkZvbEhiTXY2?=
 =?utf-8?B?L3NsamFENERZZ0NOa0Y5SkMwMCsySHFoNG11ZFo0dFBmWnpKN1VlaEQ1Q28z?=
 =?utf-8?B?RktkWjJ6b3puVDd0QWVUS0JNSG5ZQUVVWit6RVIzMWl3VEIwMEhyNDRoL2JV?=
 =?utf-8?B?Tkxqb0NhNFRIWWladFNzcHZveVMxVmJZempLVi95djEzS2NIZndvRVhxNzlT?=
 =?utf-8?B?YjZEaFVUN0dTUENZd2ErT0Z0QWpPZWdkNDdjMDJjbFZ4YTdMUkRJMFlNOWkv?=
 =?utf-8?B?a1MvZVJFcUlqK2xGSUZpZVRFNlhXbDYveHQrTXZyK0VrTmdFMXRUVVA0K0Z6?=
 =?utf-8?B?aHZrclNSVzJPV0hIK1AweWRHd2IrQlZma0F1UGg4djV2SHhDSUYvRW0yOU8w?=
 =?utf-8?B?a3p5YnFGS0Y3VkxqbzZybWo3T213Q1BNUVlYZERWTThVKzlQZGVoMFV0eFdK?=
 =?utf-8?B?bVM0QWE0YXA1VzAxRWtDTDB1dDlBV3VIdE10a3dFMFhOdGpZYkpyeStJaGxr?=
 =?utf-8?B?NU1ZV3YzeFAxZXNLZ1NUQ0RaODVneHNqVmV1YWkzWUU3bXNpakorZUQybEw1?=
 =?utf-8?B?UkpBZGtJYkhZbGZ5elhvb2xRandrcVRzcnY2Q3ViVDVzQ3NBRzNaUVBXSzhj?=
 =?utf-8?B?TXpwK1VscEw1N3lDSTZZWXZxclN1SVJENWxiOXdERDBIUFZ5SnQ2RmV6ZnVi?=
 =?utf-8?B?ZHJGUE1JT1FtQkp3ZHRPTWxydnI4dllNL0NydGpOQ3Q3eDRwajNQV2I1K1hj?=
 =?utf-8?B?MHVheWVXMXVuM0VXSFRGUE03VWs2Si9SN1ZKMGM4TVkrZm5qRFVFVTNEU1Bs?=
 =?utf-8?B?dytKcGpEbE5qR3A5VXFqZzIrN29hYmNLMklSeUQ1cUNZR3BXZk12Yjg1R0or?=
 =?utf-8?B?NXRmVjdOYk9ldkhTOWZUdjVxVzk5UHgxVzhia29zU096WUZnWVJjL0QraVdB?=
 =?utf-8?B?S3lPQnVZZThTK2wwWENNZlhkVDRLS2lJVmp1TmswOFN0WU11UzBNYVRQVkhx?=
 =?utf-8?B?RE05T1FzWkFwa1FqK2tpMnlCMjNQYWh2bC9XRWlab2ZDZm80NVhzNi9tZEt3?=
 =?utf-8?B?OEZOVVdIUEFtSVVIN1pyNjFveGI1bjhrZXVpamRyY0xYem5Za2FmaTFIQmNs?=
 =?utf-8?B?Y2R4ZUZVa09raDZGWDFReWtoL21KTmxKZGU2OHh2WUlTRXQyK3E5R1dXY2ZD?=
 =?utf-8?B?TWJEbFN3alRhSHlCeHhueVRJR05PTHdXOFdmcE9pL1A4a1JQZmt2bWpyMVlv?=
 =?utf-8?B?akhDTWZ0ME9MWjZrYlhDOXJ3RXljMElaaGVjVUlPZTNhNjFmU0FiWEFGdm1r?=
 =?utf-8?B?dWxrdmZGWFQwMlZRbEhiRUppZ0QvSStaczJMdS9hVmlRQ3NGTklIVEk1YlFU?=
 =?utf-8?B?SEJqZTBqc2h2eEZ6WlVlK3VzTlZEcDFJY1dQWFBVbjZkVUxFMDNxQ3hYdWJT?=
 =?utf-8?B?czR3Z0piQVVBRTlxNVpxakh3WGh3eHF3M2hIOUFvbWRBNndTb3c2Z2VvdFV6?=
 =?utf-8?B?SndUL1VCY1pLYzUyaW1CZ3BwSXYwQmNzcGxzaDRReG9TVzRyWkFidlZGd1k1?=
 =?utf-8?Q?QPQZltYB7lw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1pXS0NNbmtWQTY5Vmcvak45WFBBZWZLTUtFVUVYYWptSVgrY3ViaE9DaEl3?=
 =?utf-8?B?Wkd4TGc4UHU5eHhWcEc0MHpEWURkeGc2R3MrS0YrRFFPZXY2RDJibWJESDhL?=
 =?utf-8?B?WThhc1ZLankrMmlmTXNPcFlNci9DcGF6Y1p3RGZuV29NbldYWStpMzdSV25h?=
 =?utf-8?B?RGxwL1crNGlEVlRZUEI4WGlBUlk0dEt1S0lEdGxiYnhUaENobEJyUEZQSndC?=
 =?utf-8?B?V1dPaWdUTXlFUENxZldDeGdCanF2eE5mRjFsYjhwVXcvdmsrVnpvNGtCaUdC?=
 =?utf-8?B?dlFnKzZUMFRXZHJmRk9uRTNyRUZOMFJJYU4xWWJ5eFFSMGFuK3MrckkrcldN?=
 =?utf-8?B?YzJSUjJzS2FLUE1ieFowWDJNUXlZWEF1UkQzK1lZUUhFRGU0enorenVqSHBu?=
 =?utf-8?B?Sy9UWFNQOHdCUGF6bGJleHhZZUxhK1VZSjAxSHBvUnRaeEs3ZVUxYkJVc0pI?=
 =?utf-8?B?cHFHVTR2dS9WbTdmcFhiZnE3ZDZoSmNkSDl2cXEyQ1NxZ1oxRjk3eURCSXEv?=
 =?utf-8?B?TnlabzQ0cFE5Y2p2ZG5UNmZGb0QyaEJsbGhtMXR2U2pFVmlnM1dIL2crQ0Jx?=
 =?utf-8?B?NGIzQUUvbHF0eVFDeVRqOHc3cnMyYXpkSTA3bk92azhPSDdvdXdQWEVMbGtw?=
 =?utf-8?B?MGRXQ2NoNStRTlZwWi9tNTlZRVlmYzZRaTlXNzJ4OCtueWN1R1l3cllSWXlO?=
 =?utf-8?B?bGlBeTRXTHJaZzhmejRianFZdnpMUjNubVJyMzhxMzluUmM2cnkyQ2puTzR0?=
 =?utf-8?B?eU80bVplMHE4UUVHQXhUSUwwZ0lQS2ZwbDR0SW1jMHJYYW1Xb3lvMFVDcU9w?=
 =?utf-8?B?R3IzNnh1QllVZlhhTWpRanpYQXVrUm9DNzkzOXRYWVdubnBHT3FITmliK29V?=
 =?utf-8?B?RktBbm9xZmpnSStGSVdWZTZyQ01NNE12cGZFa1R1czZxZnZCVTRNQllPbFd3?=
 =?utf-8?B?SlV4NkRUWTNtRGxRRGJaWlpqOHBQbEtsdk8xeld3dFJaQmJVMDBDTXh4ZTg3?=
 =?utf-8?B?c0xPUWdpYXVWOHpzNUp6amYyMkZ2cnQ5UmRjeXVyZ3AyV2tLaE8xeEpuMk4r?=
 =?utf-8?B?UVZxZ2JoUDV4ZDZmakhKOUFYQWdyWE1VemJ3d1JNTHV5VHdSMHBnUU56eEdR?=
 =?utf-8?B?ZlVrbDk4blNaK1dLREI4KzBxZ1EwNzhVYzhNMHJoZkxycFhxek9ldE1ySWl1?=
 =?utf-8?B?UmRjYWgrZU95REJYajdsWUt1U2p6YU02NER2V0ZpUzJxREM0S2hhL1d1R0Jn?=
 =?utf-8?B?Qk9jVTlES3kvNmx4ZUM3bzdRSHJJd1pyajA3a0U1ZmpqcnpCQjNOY0JjZTFJ?=
 =?utf-8?B?bHZoaXUyc0lTQ1RwRGxBNnVONklHYVp3OHlLb0s4Z25iVFBtaWFYMWpPYndh?=
 =?utf-8?B?RGdYZ3B1anFUMmlGU0FiY2ZiTUFFVzg4bnk0RExCcURNU2ZKVTRiM1V0c2lU?=
 =?utf-8?B?aC9hVFlEL1FIQjMwcUd0VS9tOGdNUk0zbktCME9jWDhjQkEyUFE1VzZzTnph?=
 =?utf-8?B?QVBnbkpKeGg2VS9iVDJxN0ExRENWcWJBMHN5OFgvVnJPdVc2OFBSVXZHYTZN?=
 =?utf-8?B?bnU1dkZkZnoralBINGRIbGRudWRveU9pL2FudEN0N2l2Z0RGbmcwSFB2Ky85?=
 =?utf-8?B?QkMzUGI4OEJ3M2kxeWViVlFyWUdRcUpicHdiZDNYWmRFRjZPcXFaV2IyRGtP?=
 =?utf-8?B?cFpZMktIRDJyb241WEdzbXJvQTVxTWlzOE85OEpCc0U1WGkzYWZEaDVmc1pB?=
 =?utf-8?B?ZklWakptdnNiVmphZ1IzNEozN0Y4bUU4TklPOTErTDB3ZDhxUzAzY2VRMmdP?=
 =?utf-8?B?eW5GSU1vTmZINGExUEZ4RFV2WDZ1S1lDZStPMHE5a0VWKzV6OW43M2s4aDlR?=
 =?utf-8?B?aFI2SS9PUkRuTFozMkpuNEJzQWQ5OS9yQmg5ZVR1QS80RW0rVUwwZDdBUmxI?=
 =?utf-8?B?R0ZMc1krUlhIMlBWSjc1Q3h2VEYvb3dicjBGeE9KbmdiRGF1OGZhRWgzQk5U?=
 =?utf-8?B?blFTVVlyNExwbzJHU0h4NDJTcVQvODhvRGlVYWQvcEFCMkFmTFNTQjZvTmdv?=
 =?utf-8?B?byt4WE5Ua0o1WkZpOCt1VUlEeTczNkUwNTMxdnZDQ2ZnSFo2ZXB1QlFTOUl4?=
 =?utf-8?B?b1IrYkljK1laS1M4akNoNjY1dmZEbnhPUHJwMjhuTWFQb1YxOE9hU3pISHc1?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b3xpgKZG1k0rWz+y2eHOQZYCW5hqAuhrwB3DEyZ73jJw7jNWsLxkygYSos6/gPK7YSjOxL+9C3qy76pIM7KlcPuc6OHdhMZeVvY+xEFQa2qPBkyOYssZN3YeZgElz/KcvCfNpsHUbibA5sWs+w6xXDrO9vQ7a6xRaDFfmtcCYwCqQwhcGEt48m0CO+jyw8tG/+5lCBASZ5Hwhh6LEK9l1VJTHpfEGW5yqJ6pkKmmgWD1nJ+5UpHSMpPb59oQFJout2XsnOTH9FwetQBms9+yqTHJZcd5PtzfMru61qdWaVKW5CmXXwLMDhlQInBYd/L0hh+va7eGS1vYfdLPkEBFWhdbYPCztOdZf+K9w4B3e7WQMSPbqvWMV64jG3chXLCybkCxxOaLJPZQgpm0IfwNxYwzKe1loduzts13X9iwDq4hP815BVSgT/fiyhUiw1dA8usz8vgWYDVyKpHiY+LLyTAxzanZPbcXcquKHXk3waeyJM5yI9PQ6awXtLsQFgSjSXUkgRHbvK6vOohwK0m7jB/8qC/tfu0ya+sTkVw1UqJfPOoGG4CGyW4idhXGk/xpGi0j7piSIVKrMDbKdnQ0BfsMYb93ZHpH8AYS3ffkm2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266f9e20-c111-4239-d9fc-08ddc531e393
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 13:00:22.0900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkZC9MWK15a2gQ4L8R3F9q/nvvx8zCs6U23o7fVTZj+ykU+qj1E9E3w31xom3/mmUggKPa7i3SV45asiv6Tozg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExNCBTYWx0ZWRfX4FzwaXuALs7F F4GuhNQ3U/AP5HkTSTESzoXRjYiSHI1Cw4UzBO0Y+ZUJk0khm7WHcwWQJ3eDxk1zSFfrkCLXSJC wQmhZAVudTb1bDPwv0nXDosUl/Lvbucu7RmGDbtNk9sL2NDp3+qXMEYrzUgMiOPzX7HOQlKQShO
 5cRauoV0Y57bQzMijzaAmkfSdWYr6OhX0oZrMATkWLyJeuI4taoy+T3heEqWvlIVQyy8u6c7q1X I8sq51VHklba26pIo6SYkc64V64FjHyGiYcyTnVWXXMsaIe+OOd2GAi8RkZkcrG+tjoXpaP/BCx 19wXf4FZEq2NQ4PwuFxLYgeocotRUlrm5e31w/JAIbzM0DcTlNgoVQGNE9h5kbn7t7S8pBrq9IZ
 kqyiKTHhNzjXMmySzoIc58bnj4mYc3f9pHt6nTzYJXRjljcxhb1nxCiu7J866E+/du1uqsnM
X-Proofpoint-GUID: flhuv8QyNcqFe-L37FlmgzQeAfMoGI0G
X-Proofpoint-ORIG-GUID: flhuv8QyNcqFe-L37FlmgzQeAfMoGI0G
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=6878f3e9 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=ZUDF21rbWH8NFmiPev4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061

On 12/07/2025 15:12, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> This adds atomic write test using fio based on it's crc check verifier.
> fio adds a crc for each data block. If the underlying device supports atomic
> write then it is guaranteed that we will never have a mix data from two
> threads writing on the same physical block.

I think that you should mention that 2-phase approach.

Is there something which ensures that we have fio which supports 
RWF_ATOMIC? fio for some time supported the "atomic" cmdline param, but 
did not do anything until recently

> 
> Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>   tests/generic/1226     | 101 +++++++++++++++++++++++++++++++++++++++++
>   tests/generic/1226.out |   2 +

Was this tested with xfs?

>   2 files changed, 103 insertions(+)
>   create mode 100755 tests/generic/1226
>   create mode 100644 tests/generic/1226.out
> 
> diff --git a/tests/generic/1226 b/tests/generic/1226
> new file mode 100755
> index 00000000..455fc55f
> --- /dev/null
> +++ b/tests/generic/1226
> @@ -0,0 +1,101 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 1226
> +#
> +# Validate FS atomic write using fio crc check verifier.
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +
> +_begin_fstest auto aio rw atomicwrites
> +
> +_require_scratch_write_atomic
> +_require_odirect
> +_require_aio
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +touch "$SCRATCH_MNT/f1"
> +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> +blocksize=$(_max "$awu_min_write" "$((awu_max_write/2))")
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +
> +FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
> +SIZE=$((100 * 1024 * 1024))
> +
> +function create_fio_configs()
> +{
> +	create_fio_aw_config

it's strange ordering in this file, since create_fio_aw_config is 
declared below here

> +	create_fio_verify_config

same

> +}
> +
> +function create_fio_verify_config()
> +{
> +cat >$fio_verify_config <<EOF
> +	[verify-job]
> +	direct=1
> +	ioengine=libaio
> +	rw=randwrite

is this really required? Maybe it is. I would use read if something was 
required for this param

> +	bs=$blocksize
> +	fallocate=native
> +	filename=$SCRATCH_MNT/test-file
> +	size=$SIZE
> +	iodepth=$FIO_LOAD
> +	group_reporting=1
> +
> +	verify_only=1
> +	verify=crc32c
> +	verify_fatal=1
> +	verify_state_save=0
> +	verify_write_sequence=0
> +EOF
> +}
> +
> +function create_fio_aw_config()
> +{
> +cat >$fio_aw_config <<EOF
> +	[atomicwrite-job]
> +	direct=1
> +	ioengine=libaio
> +	rw=randwrite
> +	bs=$blocksize
> +	fallocate=native
> +	filename=$SCRATCH_MNT/test-file
> +	size=$SIZE
> +	iodepth=$FIO_LOAD
> +	numjobs=$FIO_LOAD
> +	group_reporting=1
> +	atomic=1
> +
> +	verify_state_save=0
> +	verify=crc32c
> +	do_verify=0
> +EOF
> +}
> +
> +fio_aw_config=$tmp.aw.fio
> +fio_verify_config=$tmp.verify.fio
> +
> +create_fio_configs
> +_require_fio $fio_aw_config
> +
> +cat $fio_aw_config >> $seqres.full
> +cat $fio_verify_config >> $seqres.full
> +
> +$FIO_PROG $fio_aw_config >> $seqres.full
> +ret1=$?
> +$FIO_PROG $fio_verify_config >> $seqres.full
> +ret2=$?
> +
> +[[ $ret1 -eq 0 && $ret2 -eq 0 ]] || _fail "fio with atomic write failed"
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/generic/1226.out b/tests/generic/1226.out
> new file mode 100644
> index 00000000..6dce0ea5
> --- /dev/null
> +++ b/tests/generic/1226.out
> @@ -0,0 +1,2 @@
> +QA output created by 1226
> +Silence is golden


