Return-Path: <linux-ext4+bounces-9338-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADACAB2205B
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 10:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B9D1890BA4
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 08:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8EE2E03F2;
	Tue, 12 Aug 2025 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bpIBcdDp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ae7jfAgL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998B182B4;
	Tue, 12 Aug 2025 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986156; cv=fail; b=caSAYQxZdWv/lpDIBLaz0+FKKYjQ+N65m5mPSRmHver4CYAVracz9XmhYvSXwImM6uj66YttvdHmD5smKXCJIUatet6ZL/CRGTimSQ8A+chXDDxwAPEJv89qACJklPEO30/Ne6BrEWQIPtVPvdAkiWYu+YSEGN0J35r7HikLZ1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986156; c=relaxed/simple;
	bh=j5OxNQ+4FhjuukTg4hmkT0oiUU9AH7Mhk2MOJiCHSAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hLRlB4HxoMEGzcOtywu1VJkzsl0cuT4q93y35BbpMdtaGPDuD8gT5GuWaE6tjxbyXxn4EJquxtcYF082EqrpHau30OUDTm8Tsi0v8ZKXTGDjMki/eagogPiwZKr7Gp9VR+J3OzYVGnvLxy5Fo1Tx4uiQAoECygGfYkG+Z1z0sWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bpIBcdDp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ae7jfAgL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C7c9kw007473;
	Tue, 12 Aug 2025 08:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+Ok+sr8MIkv3Qy1g8J4GzIXnoECDwaxnUsJaOlMweK8=; b=
	bpIBcdDpMzxz7eVT1RFB2jzf64dBnRKZNbyu4PI6CJX0Wo5fRND+9y95Bk7E5lMJ
	dfgC6AcmUYcFGJwdi9jqjIOYn9XThb8/gnrrixqFwLwiENF6KR8vXEjRxk9BAC5p
	fZYJSc1l0idsyljWMc8bfWtwdR6qU5Xx5E2QIizvfE9agVk9hcwtaT5dL8IUY8Po
	KEGFAnJjIRTkEs5qHPftQysYZ5/0wfHtQ1jQbjJTNRZ5ZyL2QrZabbf3TLTfpuI5
	zq4FTcwzfgkjAe7VvWit3w+tQwJQhWJFdNgZkHq+IrLaXj9zTk202WJC8LdwaxUz
	Byr0m/iikGDS5QZCLkg6MQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4c5tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 08:09:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57C65HoX010434;
	Tue, 12 Aug 2025 08:09:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsfy1r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 08:09:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rs4QlbeGLwwaEYlctiyLH69CwSnjNK5aCEoUUwR7jxxgAPix7eGWRM/I+2d4B0hFnIVkYlUV2J880cqUygbFYOSaDkJzMoqVFHWekhssuM7aqTI65+NoGSdCTg29bI8todGog99j8cA2eoNQW3h1DQC1gT8QhVT09v89RgHszfKlY1c50CvTYpTkhRw1mj2u2hSisiD+SespN6Q6gctY1Goj8i5dANHcFDL+HXiPIaJxDK+0+0+LiDkH/C4O87tCL/yNVLMwxC6oUoFX1UnkdG1DpL6YSGwljfUGv8i/hf3WLcLSlVZh8GZOXvGMoeOW9RZum+cWDOYnjQbhB2xTQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ok+sr8MIkv3Qy1g8J4GzIXnoECDwaxnUsJaOlMweK8=;
 b=cakEmHYim/NSLxSPEorFOYG/vJAQwJX2sH3OHVcY+UKVQFb+1z1FVdymKeTVrI0jVvBeCIejDXfbXBGZcet80dl5RlbB7bN3tSHQWe/AgUwwPXzecMT3ELcG8ZMjTI6+CV6t9qW8GlhUSKba5uwH9f588wVEPQ5I0vn18KAMOhfAqvIWtSvcRaWuoqBO8m0VNS6+rUFs8JsW7U7UURCcWh7OMIsQvNhVY5ParRNPlzkq/xhT4UBPdV5na4PjOsu7E6A8neeBSv7Hy3mzsoaW63NzGzJPPyMPcC69oKWqf+yupVePq+HOzzy8PwPHrSSHwVNKkFQeuhgjwAC+2V8fcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ok+sr8MIkv3Qy1g8J4GzIXnoECDwaxnUsJaOlMweK8=;
 b=ae7jfAgLchtxBgkoy5G2sp9eC/hkznHmlgV/lNRpWM6Rjo8TB8ao3GBTe+kncyBNEughZNsYFdtxCPcEaVyKKpjRybA3XQ1wuB1vaMCFIQBx8a3/5VyOaUd9c1oPQGdVCrannKWjVa4SLPk+M5oz0A6F2eA9pfDxWHtqHGcne8U=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by BN0PR10MB5095.namprd10.prod.outlook.com (2603:10b6:408:123::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 08:09:01 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 08:09:01 +0000
Message-ID: <62ae0bd7-51f2-454d-a005-9a3673059d1b@oracle.com>
Date: Tue, 12 Aug 2025 09:08:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] ext4: Atomic writes stress test for bigalloc
 using fio crc verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <210979d189d43165fa792101cf2f4eb8ef02bc98.1754833177.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <210979d189d43165fa792101cf2f4eb8ef02bc98.1754833177.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::23) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|BN0PR10MB5095:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6179cb-cb57-41e3-a73d-08ddd9777ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnZ6ei9KSEg5ZTlKN1llNktPMjk5ck1TUmY5eEJtQXhaV0xRQ3FiUG4xRDBi?=
 =?utf-8?B?MjhPOWtPY2UyaVJmOWpseWdLN2ZIZkQyRU5STjg1Ky9rRm9OQVhBSHNsRjZu?=
 =?utf-8?B?ZGhyUkpDdURUektNcWJaY1NtYmlNUjBTYVpRaC80SHpnU2Y1QW5ydGMwWnVm?=
 =?utf-8?B?bUdTWG5FcUpJMS9vUFo5bnpzNjRETjJTc3ZDZzBTRSswamp5M2UrOWxQTTJm?=
 =?utf-8?B?OHROdWN4Yk9aQUZXaUJnaHR4eVVKYnFsekFNdXdkc1ZqWUNrcWkwaTgzSGRh?=
 =?utf-8?B?cUpDVm1uaHg5Zk1SajR3bENrOU5uS0d6M3pFQTJrKzdZM1hmaEJ4ZHkzbjA4?=
 =?utf-8?B?WVl3S2Z6TTRLMmNTbnRPNGZwRFM1ZEExNHdpbnJnUjhiMDdPeXl4ek04amJv?=
 =?utf-8?B?czQxeDdvcFA1YzlBWFVkNHlVbkY4d3hMRkwzbDZxS2FuakdvZ29QL0tycjZy?=
 =?utf-8?B?aHVlRDIzOURwZVFUeHZQa0hmVzNUMWY4a1R6TXFiV3I1cFFVWXBpeWFncS92?=
 =?utf-8?B?QlVzWEdqMmxJUHZPTlUxVndDTUduUTkvWm9pMVBoaXI0UFN4TGRhSWw5cTF2?=
 =?utf-8?B?cHZlVndZMmVCOGJQa3lKZ2RZTkVnVDVBdExWZ2l6NXMwZWoyZ1RZeHg3RzBi?=
 =?utf-8?B?Sk5FQUJqbTZKYlF4a2NSR3BJQ2IzanJoenE2QVcvSG9FaFBJRjJjNEtNM3BW?=
 =?utf-8?B?V3JlUG9lNDlTN01FUDY4TVZ6ZjFrOGt6ZUpRZUd3cUZXUjFnMlU5Z253d0VT?=
 =?utf-8?B?SEpYaFQvN3hveTlTVHRBZFQ1Z2UrUjVyb29US2hoV0RuMXF3TS85ei9HaVZX?=
 =?utf-8?B?bTduTy9PcHd1V0lhb3VOZWR4UlFxRlNmWnI1Qk85Q29uUlhBOHNlbXQvSVdG?=
 =?utf-8?B?K3pJTDBpdXVQOTFmdHRkQmxIWDBnRzR1L2pCOUpSdlZrUVQ3aE1RUWNKNVYv?=
 =?utf-8?B?V1NHQXdVZXFYLzN4ZndvV2NNTnNWTG1RS3oyNGhTdlhRRkJndmFNUmpYb2FF?=
 =?utf-8?B?WEMyTmtOdGlON0N1d0pPN2c1bGllNUJycjJtUkk1c0xyQUFnaEJ0eG9ocE9q?=
 =?utf-8?B?QXNRSG1pVHFSZzRkb3J0eit1OTFTVk1vOUQ2blh6TVV0RExXckx5ZVpqMHNp?=
 =?utf-8?B?Y3NMbUNSbXBEbUgxQWdQcGcrZDUvU3c1em1iQktVTXJXS0RyY21sb1kxOU0y?=
 =?utf-8?B?MWZUSnF0M3YybFJzV3V4dFhtZEExYkIxcjcvUHBOS3pDdGc1WXAwSy9rQUY5?=
 =?utf-8?B?YzdzYnJvem5vdE1hNEJ0cG9NQU5GZjh6YW1mQlZCN3lBN3VaanQ0VmdJYU1k?=
 =?utf-8?B?UHFIdE16UEh1ekdrNCt0U0NwcEkxZXRmVzNlYXAyZEVxSnVTRjYzc2pjOXRa?=
 =?utf-8?B?cDFYUkx5cEpkcFlzelhpNjBoU1Zzd2Zwbmw2VVJMRlJRTU5YK2V1UmNWZW9H?=
 =?utf-8?B?WE1KcVBZWGk5M0E1cnZNdXBFbzRlUkxCZjFMY0hraXF3ZFFLMjlUcmFmNFV2?=
 =?utf-8?B?d1g2MFFKQlU2Z3VnaGc1VEdabW9sQStIcUEvZU5Pd0N4WHlRMjh6YW5MTk9J?=
 =?utf-8?B?c0xKdDJOL1RXWm9JaHNhaU02azFrcWc5bFpFMW1BbVByQTJiMFVPSlh4b3A1?=
 =?utf-8?B?R3VSL0FDMzJBMXJoSEJTSldDMnM1K3NBeTFZaVVvMkJzNFBuVDlYWDg0eEF3?=
 =?utf-8?B?cmZaZlQ2QnN6NVdQVUVaWjJjVzZZbWc1RkVvN0E1YU5UakhQRStsU044TitK?=
 =?utf-8?B?OEI2VnE0WWRpMW5pRHBqb2I2RTM4RFVQK0ZkWXQ4R1pRYTVBMHBmWU4rRWVO?=
 =?utf-8?B?TDhlc2Zza3MrWWN0L0c4V20rcFVvNGlzTHhhUVpmUHJ1aCtKU2hvVkpFNXRD?=
 =?utf-8?B?cFNUc0MzK0YrUGVzcTJ5aDBzV0k4SmJnZlU4cGd3YkUxY3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dE05Y3c3aTFlQlhmbGVNeTRwenhLTThoRzYyYXg4U2NFWVlqL29DNG9JUmt3?=
 =?utf-8?B?YmxCVGt6N3F0VHA3aXdSdG9rTWNDUHNLaHhmT1dka1JrUWk1bktVSHRoQXhX?=
 =?utf-8?B?aVdSenBtNzJXNERyRk0rNU4yeFdQbG4rM2tTbmZYUkxTbWp0dUg2M003LytK?=
 =?utf-8?B?V3UrenNqLzRSUkZDZi9ndzV3czkwaTR3bXg2QU53dUdRbU1kQ1VQMk1aNEs0?=
 =?utf-8?B?cFRMTm1XOGxZREpnaG9FcnZ2dzBNdThoNk9hR0pJMDZqcHJsVTNpL1JwOCto?=
 =?utf-8?B?N3d4YUFNWkVLSm1IOFduelRTV1JERHBLSlRTYnRJNjhYWk1PYko3T1poVndJ?=
 =?utf-8?B?TnphV0NybDZyM1lGZUxNK2RZaUpaZkk2NHF3NzB2dmlySjQ1NnhyajBTUFFR?=
 =?utf-8?B?WkJvZ3NZdzQydUV6Y1ltRmVCNk5rL3lFZmNWcTRCdE0xaGdYMm1iT040Tldh?=
 =?utf-8?B?Z3p5cjVSMUFtQXBaQjJreGh5dXlreUpNYzRlQ3Q5TVQxZmFZd3JMWmpwUG9P?=
 =?utf-8?B?ZEQyY1liVUhhL2RqaTZiaEJuMEQ0Nnp4VHVsdVJOV3ZrNWxEOEpKZnhuc084?=
 =?utf-8?B?VEluS3ZJOVpqd2NSUWJVVnZvc1ZaWEo0elNaZ1IxKy9VSU9YNWhHa1h6clFj?=
 =?utf-8?B?SnZNMDc5T2MxYnJYL201MXp0ajBIV2tHa3NndExQekUvdlhQSW96SHErZDI1?=
 =?utf-8?B?a2h2SnRRTTBkZWVmakNhZGpVakY3YkdWNTM4UEhCUndZOWNnUXVGemNmaU16?=
 =?utf-8?B?YXNvZU9YVlJBK3o0Q0x6dzhKWFZlUHZDUHBUUEFOVVhkOFQwZ28xM3ZkQm8r?=
 =?utf-8?B?SFF4YXpYdks0dytQZVMyL0UyMERlSEVqQkwrNmg1aG5ueFJkRGpwVjB4RHFa?=
 =?utf-8?B?UlB4YldETWhvdFdHZm5xM1ZHc1FsZEt4c0xFY3RHZ3BYNFRKMlZPUDJ5T3Vr?=
 =?utf-8?B?L0FJdXlrdmIzOWZ2TXBpNlJZYUdHN1Y2TGIreHU3bll6Mit3Tk1oVDI4V2o3?=
 =?utf-8?B?UisybC9wSEhqNGE1cnNnMTlXUmFMVnZhTkNIWExsV0dlZ2hSaDVaRXhFUTN5?=
 =?utf-8?B?Q2EwZnZKTDRaUkJUc2NYMXFFSkJiVXh2bHlaRHlTR0tSTS9XUjdRUGJVVGtp?=
 =?utf-8?B?aC9pQWVQU0RSeVBCeURKVHVHdDlZODV4bm85Q004SzdOejRxbHN2ZktFQ1FY?=
 =?utf-8?B?REdkdWY1dWhOeE5renpaVm5WYllrcDQvN3NlV3U4dEdHMUtaZTZOWjIxRTJV?=
 =?utf-8?B?U2NxWG9GSkI0ZXMrTUNMb0lwTXVjS2dqcDBtWHBoVllLMGhJWWtkNlFaS1Er?=
 =?utf-8?B?WDlLcU1RSWRCdGVobU1lNEZsb3Y5dDN5OXVvQXJEWGp4SnlEWldpMmFCM3dC?=
 =?utf-8?B?M0tvcVdMVkZBSFF2VVNCa3FxRUJKSmdPUGZnaDU2b0RiR3NTQ01WMjlZWit1?=
 =?utf-8?B?Q1hVR3E2TTVnajkxVnR1clFKd1orMGdNbkwweWZ6cXljR01EVzBwUHNwcWtU?=
 =?utf-8?B?NFJoTm5RamxJLzZiTmFCOW5CNkV1Q3lnR2tMNFdNcVVtOTB5R2dzSGZ3UlVX?=
 =?utf-8?B?T1hIclgzYkdSSkxUMkRiTkk4WlJ6YXhBOEhLZTNDRktiMnJZYTdpSU0vQnJh?=
 =?utf-8?B?eDFSVVVqYVMwMURkZEtuOEhUZys4NnpUckQxUTErWTZiVTA4QUtJQVlZcHgz?=
 =?utf-8?B?NTVJUHVUNFhkdjJiY3RtdTgrRnlXbExxcC9KSGt6WmNHb3ptbEt3azVSTmJv?=
 =?utf-8?B?elQ0UDBTSXlyTnJlck9HRi9VNkZadE10ZW9pTFNEWlEzeTgyZ3ZuY3pyYytz?=
 =?utf-8?B?dDlGUkw1K2VtMTlDRmZGZ2RMYjA0Qy9aaldsNkcrYXVTU3ZOSDJ4UXBmK255?=
 =?utf-8?B?M0ZKZG05L1VwMlllaml1VzE2Z1VySHp5ekVaTit6S0JSSlhmRG9ScjAwcVJm?=
 =?utf-8?B?dUNiV1dGVm50VGNpcERuelRHWTB1bFZ6dDQzUE5mV2VLTS9ndzMzekNRWFNx?=
 =?utf-8?B?cWRleFdoNXAvOEQxU1pOYlFGSXM5R1Fja2lCd1phajdUY3Z3OThkOUswbmEx?=
 =?utf-8?B?Y3FENmZLM2FxRVgvbHpSVHNPTllCbUJIN0lBY0RqQ1NCRVNDcHNBSDhtMEt6?=
 =?utf-8?B?eDVod3d6QktkdUUxSmdSb0pwT29xQWZsSUE4Z3NzSjNMU1dSWnlCOUNCVzFm?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2zRT48MaDUouSUUzQqlrGTPtuLbAeRNzV4HhH5/xC5BibuhDQ0LoONQBJdwzd2jvsBD0ErxTWYv7Ir2WX46bn6n+YrgtjpUyOe9HijGNzBFKugh72TnYBReZhaKZucuB0ZfwtAK5zKgoXkbZTsYCVdd9sCrBL3iOo+wFKs47+W2j98ILP+DT1E7UVtAnxjOO+SEljBe9aDtfjTbkP6sOwjb9pQUwBbfJvRrp/hwxcyWinSw/LyhLEA3P9kdmAzw0Qfo7mdjtvwwxTbDcif10HZOSb5ndhW5ziaiF3yQvvC2GRwpQuerUBz/I7qCuuuyqN2P5T0zvbTrbeoFSp032X29KEfVcwdBJ0bgkME1j4/7Kn6iq67JEPQT8QA5oRIQvS9hQ//WS0VAD6YIT2sNEMEFjPtcWOlJZJgJ8gEN6Xg64qhRSWtUvYylcimUHcXfpvIt7MReULhkfhMiX8LMO24kb3GmNyaKJn3ANSL+7f186Vg+Fd9XUDpNqPb3duKGcC0aa7dUznzMgFQcfofWrK5ubEQYpbt7aggXVEyq5i/jcTlSgnuXx58FCm58yGaQraKnkyMr+EQS7vCAm1GZfgTOdyVIOraqsuQ0IV0E7020=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6179cb-cb57-41e3-a73d-08ddd9777ef2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:09:01.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QV0TIzkYjVJrKqIfTLv3i9uNlrCEejFpYUfsfx9hFmZoihxD4Agkh4w4qrFYzEETz3dm23TozbaIjeMhNhxmaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDA3NSBTYWx0ZWRfX37fIc19lsF1v
 +j+0T9SecbAHZgEHGc6K4o26JG87VW/R5i6H5t6JW73lgSvhsqp9RAlGk3wrryvFLj8pQ3U1bni
 g5R6iyXt7cqZx8k/6CfqPA4ljMYJTADMKw3fx6MDqgbycnDL7W811sLRn9WjMYhze6Srqe3q3jP
 zTowlZqm/2B3uK7WasN8INFPA8NFdXTPhxl4EAqAX06dUKvw4vJRH6B2XIo1pj8kT0Og5iLOQl/
 DvMQvXwYzozMpwfU3V4BlXodY6huUtp6a0/H+y2fXVuATDUKEYz3gtHRGT9TPmnS9YsXyxtH5si
 70ChozrkqXrgjV4E8Ji4rP6A8HUQMFo72kJdF6kNRs5OGPOZ4+5Kr0pBd31zLfbGAT3OfrTC7h1
 o8hqPMX3epakN+Noag36w32K9v5ho62t0ckCHXDma1nJyLwH6FxHSjXbOzNFrVE2G80kyTUc
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689af6a2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=P8-WtZV4eohY0XPVVlYA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-GUID: 6t-tATfnpVbntfles9UmYNm8lPazJWLP
X-Proofpoint-ORIG-GUID: 6t-tATfnpVbntfles9UmYNm8lPazJWLP

On 10/08/2025 14:42, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> We brute force all possible blocksize & clustersize combinations on
> a bigalloc filesystem for stressing atomic write using fio data crc
> verifier. 

you seem to run mkfs per block size. Why not just mkfs for largest 
blocksize once, which will support all block sizes?

> We run nproc * $LOAD_FACTOR threads in parallel writing to
> a single $SCRATCH_MNT/test-file. With atomic writes this test ensures
> that we never see the mix of data contents from different threads on
> a given bsrange.
> 
> This test might do overlapping atomic writes but that should be okay
> since overlapping parallel hardware atomic writes don't cause tearing as
> long as io size is the same for all writes.

Please mention that serializing racing writes is not guaranteed for 
RWF_ATOMIC, and that NVMe and SCSI provide this guarantee as an 
inseparable feature to power-fail atomicity.

Please also mention that the value is that we test that we split no bios 
or only generate a single bio per write syscall.

> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>   tests/ext4/061     | 130 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/ext4/061.out |   2 +
>   2 files changed, 132 insertions(+)
>   create mode 100755 tests/ext4/061
>   create mode 100644 tests/ext4/061.out
> 
> diff --git a/tests/ext4/061 b/tests/ext4/061
> new file mode 100755
> index 00000000..a0e49249
> --- /dev/null
> +++ b/tests/ext4/061
> @@ -0,0 +1,130 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 061
> +#
> +# Brute force all possible blocksize clustersize combination on a bigalloc
> +# filesystem for stressing atomic write using fio data crc verifier. We run
> +# nproc * 2 * $LOAD_FACTOR threads in parallel writing to a single
> +# $SCRATCH_MNT/test-file. With fio aio-dio atomic write this test ensures that
> +# we should never see the mix of data contents from different threads for any
> +# given fio blocksize.
> +#
> +
> +. ./common/preamble
> +. ./common/atomicwrites
> +
> +_begin_fstest auto rw stress atomicwrites
> +
> +_require_scratch_write_atomic
> +_require_aiodio

do you require fio with a certain version somewhere?

> +
> +FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
> +SIZE=$((100*1024*1024))
> +fiobsize=4096
> +
> +# Calculate fsblocksize as per bdev atomic write units.
> +bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> +bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> +fsblocksize=$(_max 4096 "$bdev_awu_min")
> +
> +function create_fio_configs()
> +{
> +	create_fio_aw_config
> +	create_fio_verify_config
> +}
> +
> +function create_fio_verify_config()
> +{
> +cat >$fio_verify_config <<EOF
> +	[aio-dio-aw-verify]
> +	direct=1
> +	ioengine=libaio
> +	rw=randwrite

it prob makes sense to just have read, but I guess with verify_only=1 
that this makes no difference

> +	bs=$fiobsize
> +	fallocate=native
> +	filename=$SCRATCH_MNT/test-file
> +	size=$SIZE
> +	iodepth=$FIO_LOAD
> +	numjobs=$FIO_LOAD
> +	atomic=1
> +	group_reporting=1
> +
> +	verify_only=1
> +	verify_state_save=0
> +	verify=crc32c
> +	verify_fatal=1
> +	verify_write_sequence=0
> +EOF
> +}
> +
> +function create_fio_aw_config()
> +{
> +cat >$fio_aw_config <<EOF
> +	[aio-dio-aw]
> +	direct=1
> +	ioengine=libaio
> +	rw=randwrite
> +	bs=$fiobsize
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
> +
> +EOF
> +}
> +
> +# Let's create a sample fio config to check whether fio supports all options.
> +fio_aw_config=$tmp.aw.fio
> +fio_verify_config=$tmp.verify.fio
> +fio_out=$tmp.fio.out
> +
> +create_fio_configs
> +_require_fio $fio_aw_config
> +
> +for ((fsblocksize=$fsblocksize; fsblocksize <= $(_get_page_size); fsblocksize = $fsblocksize << 1)); do
> +	# cluster sizes above 16 x blocksize are experimental so avoid them
> +	# Also, cap cluster size at 128kb to keep it reasonable for large
> +	# blocks size
> +	fs_max_clustersize=$(_min $((16 * fsblocksize)) "$bdev_awu_max" $((128 * 1024)))
> +
> +	for ((fsclustersize=$fsblocksize; fsclustersize <= $fs_max_clustersize; fsclustersize = $fsclustersize << 1)); do
> +		for ((fiobsize = $fsblocksize; fiobsize <= $fsclustersize; fiobsize = $fiobsize << 1)); do
> +			MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"

this is quite heavy indentation. Maybe the below steps can be put into a 
separate routine (to make the code more readable).


> +			_scratch_mkfs_ext4  >> $seqres.full 2>&1 || continue
> +			if _try_scratch_mount >> $seqres.full 2>&1; then
> +				echo "== FIO test for fsblocksize=$fsblocksize fsclustersize=$fsclustersize fiobsize=$fiobsize ==" >> $seqres.full
> +
> +				touch $SCRATCH_MNT/f1
> +				create_fio_configs
> +
> +				cat $fio_aw_config >> $seqres.full
> +				echo >> $seqres.full
> +				cat $fio_verify_config >> $seqres.full
> +
> +				$FIO_PROG $fio_aw_config >> $seqres.full
> +				ret1=$?
> +
> +				$FIO_PROG $fio_verify_config >> $seqres.full
> +				ret2=$?
> +
> +				_scratch_unmount
> +
> +				[[ $ret1 -eq 0 && $ret2 -eq 0 ]] || _fail "fio with atomic write failed"
> +			fi
> +		done
> +	done
> +done
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/ext4/061.out b/tests/ext4/061.out
> new file mode 100644
> index 00000000..273be9e0
> --- /dev/null
> +++ b/tests/ext4/061.out
> @@ -0,0 +1,2 @@
> +QA output created by 061
> +Silence is golden


