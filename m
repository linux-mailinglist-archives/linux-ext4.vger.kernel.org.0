Return-Path: <linux-ext4+bounces-10042-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5426AB57C92
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 15:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3CA1A2790C
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 13:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567DA3128BC;
	Mon, 15 Sep 2025 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dRP6+L7y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZSIQNIX/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8F83126CE;
	Mon, 15 Sep 2025 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941969; cv=fail; b=Dln+py/JFk3nyMlpdisb1PioChPKLeur3XTwWj+3PK1cFlFVeclqhpqw4EyR5MlbX90VQguDqZHMaXR54OJHY30c0ifBBLQm/Ommu0m6de3FFT+oLXISf47Tnxwb0NCqK65hm0eAlnQ4E8u6owEhGbc6Y8HSkKNjs5vCXXU8eH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941969; c=relaxed/simple;
	bh=5BF3dt0C5W3XpuMinzCKud9CKRt6BGrixvAjUowE4+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SSP2ZOClI8qlrlzZs9gTCqgZiQpJ++icWFHg0y0+nsseRqaMh0b1d+FsQUTlkxWFhTRpGRtD4z5vGa3LwFCUQIUSUIrbfAnTGt5cSnbk3RtkmSFf0R7xN1oR2IshVWFQxsRzGrzEyj/s3XPK4gFqzPf7LK0np4wS2ojvMYxrTrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dRP6+L7y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZSIQNIX/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FDBqUn021569;
	Mon, 15 Sep 2025 13:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wgShcYkKoySrIcG4jvU1ah8/PL/MoGaLcSXPfJJbJVU=; b=
	dRP6+L7yjMlWUNF5KluTwM+p4UVxFxHNtzvwTqNvWxbr+AY41V0km9ucM8XR44id
	kgNbf6AFuPduHOw03IMWj0dgRsvWuSnXyndXdgwx198W3KBbsdeesdQ+D/ldUHXC
	Z1/omrm13Q9auPATIZFQ/GifHm8UrIWrRhTZDwN6q4Dm6tJLKbnmtt2kA3pju62y
	B9XS+Xu+R85PzTRx4cDkOdM6Qa4LO+d0aI7TX4jAinmVFdDdXNC/uHQlbH4TcxHn
	mJqIPr+gnofbdiLF+jIwetH5wVJPOP1zfN1qdRu212EXtXhfm4EBFfQdPdOnIX0F
	88sHIr8Ea7n/nh7d/sLkSQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950nf2bj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 13:12:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FD8X4C021473;
	Mon, 15 Sep 2025 13:12:37 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b0w0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 13:12:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFsLfQopXI7IIZQTBteVyr6zA9Rj5AM5kw6Myi+Cr03aoMlIGTm3wt6LP3dzVusXJi2eLuM2ES9JZGAi5RYnEDj5xDLuTagCvf2tDPEdz1ZLxzAgRY9k1nvhYg/JCy8MP0xcdv8eN4RuUszUa1J0zm+JDHyb1f0kBSdf90uGjEBdWeVIAESmTBQzi4KdPpLal5//UKwzcgtNM3TqVhyBd81ntKAwQcIAtGAhkCBqllhED4YTbkiUu4kTeb+U9NKO28JKiXuQE8FG/irowpVhKBZ38xW8ikn4ZF5kYcKnpqUcbfZP1/VtAQABkr3bKZ4Pbhxrwp25nvTzBoYuLtbAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgShcYkKoySrIcG4jvU1ah8/PL/MoGaLcSXPfJJbJVU=;
 b=bYpiC4IPG9x7MhBZBfJ8vY/aSYiPzs4AWtjpTD2ER8VGa+1oDg8BNlGObVFGl8CIjGFV3geyWHgiQ/8hxCMAfseCS5d1sP9xDye/HXXngEPg0Bv07mG1+OeX+1+UDEZ24QJ5mBLcOW6uGyW4OlgYqVo6AJJ1iX3l1CpsztfFHCctWMSxtywA5bmaXeitP+p8N4GwsAd8vt2jgJIjOiMOvJXaJW9PZPQE//B7/foRhtJohjUQ84BM20QBzi5KcTXOnYcoHSYNK/tqOFKtIMMSFGmAkPHXJ3DErnHwzTVk3mhXZt57Ks+NJZsTcDGidBo2LDH1ITxNHw5bweMnvhwvTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgShcYkKoySrIcG4jvU1ah8/PL/MoGaLcSXPfJJbJVU=;
 b=ZSIQNIX/Y26jQdzoxexvRSnYaWyfezm4GRNk7NsgKsoIJF88HDbtGWL/m1t2Nx7pnaqM8MFsAwLF9N1+XGmzQ6pbir+3W7TNRpXKJ0+3W2qbFh7CwpRXN08AfccVSUk4ZZ7dtRzeLUC37SBc6oSDQ+RPkBZh+lDpshyZxfZ0efo=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ0PR10MB4624.namprd10.prod.outlook.com (2603:10b6:a03:2de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 13:12:33 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 13:12:33 +0000
Message-ID: <3a8d6404-d4ba-45c5-a4c0-4163278ff1c4@oracle.com>
Date: Mon, 15 Sep 2025 14:12:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/12] common/rc: Add a helper to run fsx on a given
 file
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1757610403.git.ojaswin@linux.ibm.com>
 <18c7546ebcb6dbf72d591f3c6f6b29101aa48b95.1757610403.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <18c7546ebcb6dbf72d591f3c6f6b29101aa48b95.1757610403.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::9) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ0PR10MB4624:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ef3472-3392-4f37-95c4-08ddf459882e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWNZNE93ZmZIWk8vR1ROeERid1ZDSnhVbFFWNFhmTXlxM0JWVG42b0lnSy85?=
 =?utf-8?B?bnJnQjVMT0JwQ3gwaHlKS3NIaXZPaXFYeEF6YlpBc0xseUQ0ZDBxVmtaanFB?=
 =?utf-8?B?NmJiYUc0L1BzVkFpczBpa1JJTUdyRlZhUXpSWDd0MXk5Z1ZHZU4wS29DNTE5?=
 =?utf-8?B?ampuTlRrVHVMVlYxSFRQOWVvYmdVUjM0MjJmL241NGdhV2NvNVU0YjJBeW9R?=
 =?utf-8?B?RTJ0aXpURnpBZzNDVmNMZkxkNEl6d1NtRkQ1KzkvYXZLRWtBelNyUUNhRE9N?=
 =?utf-8?B?S3JqZnYwM3J5a2hUWFAyQ1ZPb3RTQTFCdjZLbmQ3NjY0a1Q0WE53Q2M2dUlk?=
 =?utf-8?B?d3ZzamNPd2VYeUlIRk9vZFlGQnpYOXFXRDlYNGJNc0hCYjhwaFNNVHVTbWxG?=
 =?utf-8?B?UGtwSXlRVERmVnE5RU81b0Y4c1hoOVhid3RvNUhJbkxsa3JnZllGcDdJOGhY?=
 =?utf-8?B?NXJSZU4vQmZZS2toZ3E5RzBwR2tadzgzVStINzduWHhQWExlZUlVMGlrcVdQ?=
 =?utf-8?B?TFRZUDdLc2REM2l3U29NTDFtOU94dDEyZFNLRTFhRS80dFEwdHBMaXVaM2Rj?=
 =?utf-8?B?bVJCeGJQZHpXdWpNTXlJTzV2ZDVMckIwNW93WmRUVzhpMHBpbUlWWTVTYSsy?=
 =?utf-8?B?aEFmMUhtZ0VWTkVuUWxOZ2ZvSCtzdnc1NENlbWF2bHF6cHlDc1NkYldHMG1J?=
 =?utf-8?B?U0pncy85VEFNdXpVZGhNaEc5TXFwOFB3MENKcml2RUliYldxWVoxMlN3SWFv?=
 =?utf-8?B?QjZZbVVvdlMzT09zSDgvc3FWTjhzcXZRUDUzcmF3OUtpY0tKNy9WazRMYUdm?=
 =?utf-8?B?TU1vTlZzWWdVZ3JQeGl2TFJheVd1Ym9xY25UOHliS0ZpYXlKUjUxcG4wS09F?=
 =?utf-8?B?akhTVjhNM210bUdpVkwwUVd3Z0JoWHFXbk9DSitNblNVK3Z5UVkwRXF2bkM3?=
 =?utf-8?B?dXhVek80RUZNb1pZYjB2azJlM2JUREN3a3hqaGJpTmdTU2VoMy82TGg2OGlH?=
 =?utf-8?B?V3E2VjZxZ2ZrYm5hME9oV25GY1VrYitsTlBMVnpDa3lkcWRiaTBpbStxWll3?=
 =?utf-8?B?cHV1bjRDbHNtSmlNRWtLZkE4Y3ZvN0c2TFhiS1BYSVRKMmlQS21STDF1aDU5?=
 =?utf-8?B?VVdtMHJ2TWNHUkh4TEcvTjJua05IUDhMcW5Gc1BzNytuWHozSGFHWmEyTW5L?=
 =?utf-8?B?VDhsaG15WGlHSlVKcWppNGdBWHgyZjU4TnZ5cEhQSk5zTHE3RytVelErYmNE?=
 =?utf-8?B?dHJBQk92dngyUlZpanpISnVONWNZZXFreE1xbWJScG1hb2o4N0ZsMUowd0RQ?=
 =?utf-8?B?NllITGcxbGltWXRvVWNoZmZKR3Y5SVd3OUY0Ykd1QnRtQWNNRHhLemRUbEEy?=
 =?utf-8?B?N3VML0F5cytlOGcvY0JramZmTmVWazFhVHM3RVB3aVhSdG9TNHdPaVNKTnpR?=
 =?utf-8?B?dml2eGpoWENIYlliQzVIamVNUHh3UGpZSFpveE1HM1pFOG9qVmZJM1FHQ2pV?=
 =?utf-8?B?Q3NqOVZxYWN3U2hQMEM2Qk1VWW1zckEzT0VJN1ArNU1JQXhvVnVsTjRXdlVx?=
 =?utf-8?B?VlROZkdtbXBKSm5hMnAzVmsrRUtjdE9ZSzJyRFlxV1Jzc2xCWTI0aTZERkw1?=
 =?utf-8?B?KzB0Q1lPeG1zWHFMMUx4V2JmVFNtRzNBRWF6R2x1VWZhQ25GbmRMYTZIZkY2?=
 =?utf-8?B?ZDRGZ3dwNDZZWFZJVlZjZUJQVmxJU0hpV3FPOHZWWENVaEhmRm4vNXFKLy9q?=
 =?utf-8?B?TjVHVVFnWkZCbVBUZTN3Uk9RSGhFK2VvdzUzTXNTUW9ZNVo0TWFkUk14aDJy?=
 =?utf-8?B?L1JJb1Q2bnJWRkpmYnRvNi9EbCtrL3IwYWJrajk2a0tDTnJFREJIWGhJYmx4?=
 =?utf-8?B?MGpBSVRvZzQ1UWpUYlFZK0o0VTl0aTlDdGZKV2w4eUl0SXczUVZsOW9SVGpY?=
 =?utf-8?Q?ZzFdjfe/Z9A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk1jemhHNnV3OVdtWXRFT0xQQVNaRzNRY2VXVGptcW1tM2JiZjZmTnFzWHBQ?=
 =?utf-8?B?c3U5M1pGZjBDdGlBWkltS3ZCekVQODVRY01xOVFDSnN0RlgyWTVMUGlqN28r?=
 =?utf-8?B?aFhDZDdXVEpMWm5UVm5ReDZCUzJwNmpUMVlWUTFVK2QwaFAvQlhrbHFVdWZr?=
 =?utf-8?B?T0dhbFVQeWk4SnhPZlpWRzRvejA0ZTBRc3I0ZkU0b01KM0xEMm40ZWJYTm5M?=
 =?utf-8?B?L3Z5Y2VDZW14RHYwSUI2V2pyYlI2bXFFYTQydWRqUnc2ZnRZVlpSOWxaZExH?=
 =?utf-8?B?SndMcnErTnhPenZMSDNGV20rY1ltTG96c1htRjBRd0I3WGdrMDducCtWUnZr?=
 =?utf-8?B?M0xGbzZ5a05qbGNvcXBGQUkwSUp6ZmlWWVI5Rzk5ME5udlFNSmVIRDZacGZW?=
 =?utf-8?B?dkppMzg1Vzg5MkUyWlRJYzBoZisrKzVJQ3NLSnZiRjA0Y1BlODFOVVVMcHFm?=
 =?utf-8?B?M1V2WW5LY3NnbjhpY0FMVXN0VXluT0h1cXk4WldZQTFYWUxlaTdDRFlBSkRI?=
 =?utf-8?B?N0RMQlE1aFBiWEVzUm5pS1oycEo2ZElFQ3BLWi9SMkkxbEorWm1jS3k5V3ps?=
 =?utf-8?B?V3JhS2puL1NhcU9RUEhpNXF3cUNHdkhCb0gwNTVzcS9ndDBrb2JvbkFQUlNw?=
 =?utf-8?B?VlZzVyt2eWJQR1lLTGM2L010MTRZNWlNRStiNitOZ1pnam96bEpBcmg4UHFw?=
 =?utf-8?B?NHFwY3VQZm9RUWJwTW5vb3VKSzh5ZkRBT1NUOVJIZmlEYkYwYnRhamxUVEg5?=
 =?utf-8?B?VGp0cG5KM2lQUkJRMnpIVUIzQmoyR1RvUDRha3c1UnNHcFhESUZXSzhUNktI?=
 =?utf-8?B?cTI1S3l2cXBVL3I5Y1VPQ3RaQkhOZFVSLzZkY2J2bW1hRCtkR0xTOFRLWG03?=
 =?utf-8?B?Rk1PZ29tTlZMUFFsbGxwOU5KN0lKZ09rYkEzSjE4UVNtdnpkbERCbDRKSEZC?=
 =?utf-8?B?ODltMlpyMlJaTm1kZHMvVEtjem5PeDJIVlRxWnR2cGpHWXVMaGpISEFlQUdG?=
 =?utf-8?B?Z0duYmtLR1phUEJzazJXbVZzS2l1ZEIzbUVxLy9qd2t3RlVWc2N5cUdaRVJu?=
 =?utf-8?B?Vno5ZWsxTEd5ckNVOXJ2a0EyY2gxb0ZCNTg0bnVxR3B3c2ZjREs1eDZ4Smd4?=
 =?utf-8?B?Wm9rVWZqUitxejgzYnJjMUdoc1pXcjd4UEUyaFRhZWhLTVpSTitpZmFOY3F0?=
 =?utf-8?B?V01KR05XdlZnMUpaRmZVenlCOEloek9RdVNRWG94SnFXRWkxYWlCTkp1SHZZ?=
 =?utf-8?B?NWZxdmI0dEkzY1RYYXl2STcvQml6MitnWjJQS0RjZ1BvaktwdUJ5VEJDK2pw?=
 =?utf-8?B?MmROb3JaOFRHVzBvd08yb2hId01oOXdWaG5aRW5OYXh6dkozVnhCbjVkbWJu?=
 =?utf-8?B?dHZOTEpyOFZYUC9hbXZwZjl3U2hxT1lRbCtsVjBuV2dxZ0c3aU43NHdGQnRp?=
 =?utf-8?B?SHF1dU9SSGU4V205OFJUTTRteWpObkVlbzkrZEw4OFFzVmdmNU40YWdDVXUr?=
 =?utf-8?B?aWNpOGYra3U5UnZOYjZaMitHeVBOMzY0NjBOM1dIN2IrVmN2YWhpZktFMTJ6?=
 =?utf-8?B?WU9zU2VVbE1MLzVwNE1hSUxPNjhibU92S01wWnY5UHhNNFB4c2hVTXdyMWZx?=
 =?utf-8?B?cmhoWmJvTEdCNEk1ams4UXhSRTNWbUt3d3dCbDNySmRIcmNraktmTFc0ZjNW?=
 =?utf-8?B?MSs3bjNEZzZmR3MxMXdHNGgvZ1QrK3JUb2ZqNnZzYUYrd2dEVUJFKzZXWVVO?=
 =?utf-8?B?Q3ZIV21idVArZVIxbk5kL2thaktvNWRwU2V3b0JRcUpGSnJVTkJoU0g1dEZv?=
 =?utf-8?B?SzU3M1kva1RjWEZMaFZJbTVDZlVKRFJaZjRUdmFwdnJtMHdKa3FhL1NOVjdp?=
 =?utf-8?B?OWRUVVV6d0VhbDdYQTJBR2sxWUV3SVI1TDkvYWt0N1FLcUV6eFhsNDZSN2VU?=
 =?utf-8?B?WGU2WDhOamJlSVhGa240eEJvQk1ETlNrbk1hOER0MjBxY25mcFpxbVRQK1Iw?=
 =?utf-8?B?eDNMMFNVSGN0eERJOVVVWWRObjNsLzduSEdSQ1hyQ2tJUE1VeFdaUUxCQXdQ?=
 =?utf-8?B?UGtUcTZ2cXVjOGg4aWcyWVVZTElQeGRHUXRSeDRTd25NdGFFUmxvTy9mKzNU?=
 =?utf-8?B?YVJaVXJidzBGa1cyYTVLamp4UUUvVms0Yk5qVVVoTjVXcHJXYVh0VnBoUjVz?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k9QnK0iqdfv6QSeFxKbRBjadt9MO+gG8iGRLL2VGXLU09rxT1Cvm8YjHVgeYyJ+lib+0WJALR0PFekwvKDE2JUBwaCkzVQF93Fmof3CBDNCMOuebfCeecMIV2kVJCuIeINjdO3zt+ENkWKz0NqoSyYXyQKGuUh9RDiAcUi76JMNAOEX7LSer5wj+G4OmKKrb3R9yko2EeTO6oSv2LKDih2UIuZLJCuzFRBNYqkPZNrHxQGZYBhmn2FgHNTdmH58KklIk/3pNltJLaZEGFrVI4rDcQn63NurUHQvNQTfmUs54/5mfz0jjPzHf8eL0PnUK9qI8MzT4Ssxhr+08HqE5+NAuKKvWas6QJv8n2GGYorEnZD+IGmX7vHVwabBmUuPArd2O8vCUa080iIptLRcfSqmdEWks6uNeyCzJmLAg4laFtbett3bNNZyrjwF9ozODK0RMWb06Sc19P1sckaDTkxs32xl/BfwkxswwWEz7g/R+LooRrR9YfxSA+sD0+n5DeTlhqQLtOBTDfhsImF1v7tZU2PMcnO8ZusLhzyd1IbmrvI90Q8kCYLQQVFh85IhWB2a+5X4aZRt3x9Sk2eAgE4GRGFIRrKGVe1tNgX7lwAo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ef3472-3392-4f37-95c4-08ddf459882e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:12:33.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2FsyL0zvtAJIfDECkCq7m23Uh3Z4Hr0ZNp26y8ddjrtv37VvD0dQXDseLVoc0LW5ugyYqpVKOvc0x8qHESe7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4624
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150124
X-Authority-Analysis: v=2.4 cv=S7vZwJsP c=1 sm=1 tr=0 ts=68c810c6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=u_VYNAqGXo6OSSAA:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=-gssQiuzeufnnCCU0RoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfX/NeFIOloSbPs
 EP0cgZPc3DuuK+DbOganWW/TjdeKhT+xWn9SkMlPM0RtcrrQ5Zt2wZ9g28jpFGMDf2zqlhDwfci
 gkfc+xC651z7MSud2Y9IIdCcYiheUe/TJkpiKtOdmDbRKzTHOtzKG6hMNFQtCLe5OiIU5zs53mt
 INHrGIjwd10R4t9DEQQVmqiRhWuP6Dh17Xvom5ej+JE/yEHKTQ1PxpcEbuRuVkzWLD+0U5kQwfb
 +qrNNuheYpVKf2QS3zP//bg6MikooA3uW6SZK6puM6C80+wPNux2rMM+NXD50avEjZmvWGSWhBn
 vIvpYolTQLHSqP7ndBqISYV69bigKDCJX7Uhx80BV8IKooqFr9MSzaurSNv8VrT8pdcK8Q0Rzc0
 m9ecZpwH
X-Proofpoint-ORIG-GUID: 9OGqIKzbdSJZQBsCua6F3P_1bXThGC8h
X-Proofpoint-GUID: 9OGqIKzbdSJZQBsCua6F3P_1bXThGC8h

On 11/09/2025 18:13, Ojaswin Mujoo wrote:
> Currently run_fsx is hardcoded to run on a file in $TEST_DIR.
> Add a helper _run_fsx_on_file so that we can run fsx on any
> given file including in $SCRATCH_MNT. Also, refactor _run_fsx
> to use this helper.
> 
> No functional change is intended in this patch.
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   common/rc | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 8a023b9d..ac77a650 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5203,13 +5203,24 @@ _require_hugepage_fsx()
>   		_notrun "fsx binary does not support MADV_COLLAPSE"
>   }
>   
> -_run_fsx()
> +_run_fsx_on_file()
>   {
> +	local testfile=$1
> +	shift
> +
> +	if ! [ -f $testfile ]
> +	then
> +		echo "_run_fsx_on_file: $testfile doesn't exist. Creating" >> $seqres.full
> +		touch $testfile
> +	fi
> +
>   	echo "fsx $*"
>   	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
> -	set -- $FSX_PROG $args $FSX_AVOID $TEST_DIR/junk
> +
> +	set -- $FSX_PROG $args $FSX_AVOID $testfile
> +
>   	echo "$@" >>$seqres.full
> -	rm -f $TEST_DIR/junk
> +	rm -f $testfile
>   	"$@" 2>&1 | tee -a $seqres.full >$tmp.fsx
>   	local res=${PIPESTATUS[0]}
>   	if [ $res -ne 0 ]; then
> @@ -5221,6 +5232,12 @@ _run_fsx()
>   	return 0
>   }
>   
> +_run_fsx()
> +{
> +	_run_fsx_on_file $TEST_DIR/junk $@
> +	return $?
> +}
> +
>   # Run fsx with -h(ugepage buffers).  If we can't set up a hugepage then skip
>   # the test, but if any other error occurs then exit the test.
>   _run_hugepage_fsx() {


