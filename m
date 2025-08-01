Return-Path: <linux-ext4+bounces-9251-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7489BB17E3E
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Aug 2025 10:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AD13BA117
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Aug 2025 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4333421ABAE;
	Fri,  1 Aug 2025 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NfeaeYkp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cfFjeUDi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC52AD0D;
	Fri,  1 Aug 2025 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754036645; cv=fail; b=abJahEftqCdYuSwx6GOKTuQ+rrBfOc450Noiy2HYtpRFrcKufEHfQ+t7iyhSOAog9OWGZKb5sovXXJm50yLdtslEVZGdjcPK4rJZmsXjoTC7Jek6cuaUCXB6Q/4ZPn/jsCfEEacr96EV3AMJGCHshFeuaSly1O88FbvzjkmolQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754036645; c=relaxed/simple;
	bh=a23LH6F3RVzeVqrBEBeEcG8m+6nypdgsjEeGn7I1SVU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rwh6vjp6sA7wDF2YyH0z5HjfshHGHc4OA2S76rgfcTkn0Kpj3ZgGnkCYPvwEr0SwvFxSBJLGPeFVnqRom/97Lb0GpQ9rBvBfAtx95nDA531lzouy3aaLwopQDJ0emlaflnNWKvsdwCYH8VBQZxa2wa/fvQJ3EreXiBhMI/xZpi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NfeaeYkp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cfFjeUDi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5717C1Ao003870;
	Fri, 1 Aug 2025 08:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Z9RJe7Qh+Gek05Jf5gLr2er/NWz5v3NIVjdR5vKqtcY=; b=
	NfeaeYkp5cCRrX951qRXkK5uLW3jZkKkKa0IATy4JS7sFM8Q5qWSskXOelPd1FEI
	yNVGnhYMrxPciAQ4AV9GEX7AnvxJMQ7c7w4XuApOXZvx2t3hJnTXsNtij6ovEoHU
	iCR04kLrkAuEncIpCJxq1e26JOUihLi/+10CIlYMoxpBkLG1o0DuDo02WrOwh3uT
	VvAJ197Zy9g7mDQdYewcueqtji41Nq8YlHNFH6n7GYrYQrHxvuElObOwcU3HXfgP
	g+otOZbex8fmDcpAis6YKI5L36Rt/sgVJZuvCWaY81ZV7LTcgOG7/6jGx0PToOsB
	CqadHXjTaB5WABA28T48YA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4ynspu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 08:23:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5717I11C010479;
	Fri, 1 Aug 2025 08:23:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfdcfs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 08:23:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqxyE/4zVwtfdtJr2pWTzEtj8kZ7rL6TL0DfnWCr9rkjCmqpYMxeZPj+f5vYpm6QdIVC/Zfu6eFxYLRYgK+8a80iopHvVETdxks/HNr+Q6EPhTutS6La4SSH5AwZINZoyrVaij6v08yD66QXFbhut8PkSeMYdrHlGFABez65fkbKjjtj55Pg9W63/Csbqe/4n9XIEGJ38C+mo/fZWfjSWXE97Nnjzwfu2ELB2qRA2ineQPRMcgq+hy+e1OcHnlmIeSq57PG/wmxZSelMn6UIvvHNrTEofEBRPpUnpdPRkkquZ1Uv2rXvTE3B1YQM2p4xypjL3IDF4M8mZ2fphx4ccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9RJe7Qh+Gek05Jf5gLr2er/NWz5v3NIVjdR5vKqtcY=;
 b=jztPVi+VLP1tQyVUYylorFovN9xWyPWZAOW4FiWM4hNup0uqa6UqCNghHescMqz5vxV0zBwPXmeLKaJkTMRpqQ4/prl6GEHHGhU5pIjmrS62YnyaHVWS4P1vboMBCAgYk12dsear9n/dgiqov02FHtl/h+7OIJXfc6nQvJQaLaUhQ1Q8TxAVK71TVRxBk0Yyc/7olldN4Sd3nxK7JSzhHH3KhHjDdLwuY9plDt92011dj2ZtqS/p0QKN9rxgZkyZ8il24rSv7Z2ByPM7IQF3Ow1NCMZSf2WrldGAYsPrEWj33p98AYH42ayAlNdj7zyRdGR3Abi/6Wdl+0aES5zi+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9RJe7Qh+Gek05Jf5gLr2er/NWz5v3NIVjdR5vKqtcY=;
 b=cfFjeUDig+/1P+PwlQiC5/bDyZaxRBNMMD7lGhEnec+2Lvhg1n3sUBB2Khl8jN7gyncidCRd43ddsn9d/BikD8Ka1HW39hOAsMnKdcUB6EYGOPKQBMevDBrbmdcoHmV5xTsK2yt5+WNeKCx2lx3E/UDFhMOb20D7I/FoXPn9hmQ=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by BLAPR10MB4947.namprd10.prod.outlook.com (2603:10b6:208:326::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 08:23:49 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 08:23:49 +0000
Message-ID: <76974111-88f6-4de8-96bc-9806c6317d19@oracle.com>
Date: Fri, 1 Aug 2025 09:23:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <aIMjrunlU04jI2lF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <0af205d9-6093-4931-abe9-f236acae8d44@oracle.com>
 <aIccCgrCuQ4Wf1OH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <2ae4bb04-fbf7-4a53-b498-ea6361cdab3e@oracle.com>
 <aId8oZGXSg5DW48X@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <3a4854ac-75ad-4783-acbd-048fe7c7fdb0@oracle.com>
 <aIhmG-l4nWOAzz2I@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250729144526.GB2672049@frogsfrogsfrogs>
 <aIrun9794W0eZA8d@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <22ccfefc-1be8-4942-ac27-c01706ef843e@oracle.com>
 <aIxhsV8heTrSH537@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aIxhsV8heTrSH537@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0300.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::24) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|BLAPR10MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c3d65b-dad8-4435-c6c8-08ddd0d4bd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzNXd21vU2N2ZEpIRnI1REUzaDF3K1RyNTZ5QThDVEptSzhJU00yK2Vycnh1?=
 =?utf-8?B?KzlrTGlvS0RjY0RsdStIMG8zWE8rY2xnQW1EVzZHYk1yUWZVMkkrVlo0T0xt?=
 =?utf-8?B?bldZQWdDZW5XMWZhOG1CalZ3R1ArTFJ6eFl3RVd0aHk2OTRBamgyS1o5bWVS?=
 =?utf-8?B?MUlkMWRjRXlNZkpHSm42Tk1FL3FndVp4SnBWNnJrTGpuSHhZcHQ4Ymo1RjAr?=
 =?utf-8?B?VWxkdlFSeEY1eXB6WGlhcm05WkhLQ2Y4SlJaM1ZXNkdQa0lSVWdTQWpBRDlM?=
 =?utf-8?B?MjZSZmpTY2loNHpUKzFLZzNLeXlOcGMwOWxVSm9vcTlMTkV0N0xGSTA0Ulpz?=
 =?utf-8?B?bUhyb3d5WW1wR1R2b2Zwc01iN3puY3FBTnVnd0JHeFQrNGFXeHNkc0RrMmQz?=
 =?utf-8?B?M3hvcWdUVFhyUXBVYXU3U1h3OWhWOGN5dUp2MGk1QXpEL2xjT0xoS1J0RVlQ?=
 =?utf-8?B?cjJHS3BIK3h4N0tvcnJsOWs2bE1PQVgzNU1lNWNtNVcxVlRHMHJKNS82b0tQ?=
 =?utf-8?B?NDZGdmJRZlNuUmlUU3J4V3M1aTV4SDVpYWdRK044RDVyb1IxOExsbWdVQlhE?=
 =?utf-8?B?aUYyMXo4cmtuZ21xYXptYmtnQlIvUmVhaTFVNURFL0NPbXpvemJzcVBqVks0?=
 =?utf-8?B?RXRtQ0xnZG14UW5nQmYrY0ZvK3p1YSs0eHRpYk1NZ0kzQUkxUnpVWkszd0gx?=
 =?utf-8?B?cWhrcmMvcXhEK05ucllxTGNDOW1SQ2hYTnFwN2dadXpadmhsM2FkeWZTYUhO?=
 =?utf-8?B?WTNDcmZFNXczTUZyeGg0N3FuTnI2VUszVUlWYkhXZnptZGtrVkVpMGI3NEU1?=
 =?utf-8?B?MFlMdHhFUHNORTRWSnBpMzZ5SUZTeXRtTFpIMFByVU5SUmhzTmtIQWVDckRJ?=
 =?utf-8?B?ZFhOVThFQW9IdmVERy93MVhIQ25aT1ZIb3FjbkwwTHNBcm5YTzN2d2pMbG5D?=
 =?utf-8?B?d2FmRnV0MmxSY1I5ZVZ5NTZGTFdMM1JCV0hGKy9Xd1JmdjJFZUw3YVpUNUo1?=
 =?utf-8?B?R2I0ZnRJWlBTRUlyRmoxSkxZcmRlZ0Y0a2Vkc2RadEpQN0dzaHBTS2wwNVRI?=
 =?utf-8?B?czBFeUFEU3pSdG5rMVlDL2I0NnYzeW9aRFpxS0EvcGNIUEY2cDlKZ3M3NVhv?=
 =?utf-8?B?RS9xdUdnUFJrT01Bak4xMUhiN05XZ3VkV3c3bWNoMERaV2M0M3BuN3FqYkRm?=
 =?utf-8?B?RFhQQmFvcFlzYnBGWFU2WXZ6MVE3R3ovR01rOXlkcFdNN2ZlOVNyY053aTdX?=
 =?utf-8?B?Zzl4SzY2dmpLMHFaYUxBazR0UFprVWRWdG9OT1hjU3dwalhyNWlJQnlkeTVI?=
 =?utf-8?B?NERaYWNnWXhpQ09pcHVLTjRMcmlWVzVTMzUrc2dTQ2dCWUR0cjY1TlJnQzNw?=
 =?utf-8?B?U2dXcGFiQTV0aDhXUXF1eTVjb0RKYTlueHJFeDc1RHhTeFZqOEcyMzg1dGlU?=
 =?utf-8?B?NUdzSWFPaEFYVVIzZy9USjVVaG5sWkpaL0RDTFRNMDZkL0MwOHo4a0g5N3lT?=
 =?utf-8?B?aG9FTXVZTUcyR2pPOTl0VTNXbWhiL2QzS1Jib1RCWXVGb0QxUlIwclEzamhp?=
 =?utf-8?B?aVBEY2R5ZDB4N3MyTm9keDRGTU1EdGo4b0dia241VWt3STNuQkVidFl1UURU?=
 =?utf-8?B?eFMxcTdIdUVmbkNyNlozTmhXc0M1ZjVhVmNrRmZ5T2NWMlFlbExHRTQzTmp2?=
 =?utf-8?B?SVduUDRVdGgwTHZYcEJvWVN2RnBGM0JKNFhBKzFFZTB3ZnE0cWZrbXh0YTBO?=
 =?utf-8?B?bG5sL1FhOGREN2ZyOTBKUEY0K1N6c3hHKyt0VjRJOUhaQmRud2dLUGV2SllI?=
 =?utf-8?B?YmhMeDJQK1dJaTRxVy9YazdQZ2ZZRFVYeWZCMGFPV1I5U00zTXdtV1pNS3NE?=
 =?utf-8?B?QkVQYkN4cGpBanVvckU5LzZLdXRTZitDd2tldUNzM2J0NzJneWh4ZjhzUDFG?=
 =?utf-8?Q?W+4H0KAHdP8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDBTZEsweVFPNDNyUWhZWE5UZS8xSnk2d2pVYnJpWU16dElDM0NOam5vanAy?=
 =?utf-8?B?anYwOFBxcGg1NkZ5eStOWjhnRXdhM3pkSEhYQ1dka09nM0htMXV5ZEtLZTZa?=
 =?utf-8?B?Um5zaEs2Nko3R3VpRmVoRVVTMmg0MmNNK080aUtjODdGQWRmbldTb1BsaEQ3?=
 =?utf-8?B?TlcwWTRKNkZpd1k5b2t6OFJjMlhJY0xxK3J1S1FFZXJQYSsxamNnajdCNW1X?=
 =?utf-8?B?bnFnanpzSUJEeXlSdytKUUlrVDlVaHZZVy9rcFJDb2FSL2tlWjViamQ2V29G?=
 =?utf-8?B?Sk9vWHJESVN0U3FmTm5WNDAvaHI3NWovVWRNS0lsZVpxTU1QQnNhZ1cxMzdn?=
 =?utf-8?B?SDIycFc3bGJ2dEliZ3h4OHozS05wNDhlVVdLRjMzTCtucXphSU4zZW93ZkZ5?=
 =?utf-8?B?YTJoQ0wzaHE0VWt2VVZrNXlJUU8rejFxT3RFWGdVVyt1OGpjNzgrdWFYd0xY?=
 =?utf-8?B?V25ocVhNSVVVNkt1dmk1cmVJemVNWjV0TnhpSWJ6WnpRby90bEJsVGhnNVFL?=
 =?utf-8?B?UEtSYUJ2N2s2KzUvaWQ0cHpTdjRac0NJakh0OTQxcU1xWkdDZkFlN3g1RlBO?=
 =?utf-8?B?bGd3bm01R3hnZVdtM0QxdU0xcXo4TDNyNmsxL3kzNjRjMW9iL25wOUsyZy9K?=
 =?utf-8?B?RlBOSjlHajQzdHk5Y3E0QVJoYW5UU2lZZ2RRY012aEpiVHg2eUk2SVVPcThO?=
 =?utf-8?B?L3dLTTZTYlZvQnVkc1pjeWRsZ1krK3RCa3FGOTVaNFpoV0g4dDhlTzIvenNO?=
 =?utf-8?B?Ykg4SWJ2ellqSkRBSE4ycHlYbVZrU3RVakMwZW9ucXBrbVFDclR0T3BKdXhS?=
 =?utf-8?B?OUFTU2JZekRPQzFPUVEra3A3Ymc4bDZPS0UrNzh4R2FvZEs1MklxSmZjbURn?=
 =?utf-8?B?OUgvb2N6ZHhwdFcxRytPRGpXV0kwSjZPVzVpMm1pWFd4UjljWDZMUm8vKzhv?=
 =?utf-8?B?V3BWdnYySVc3WmZHTXFRMytMYlpGRkI3MjNMaXpjd1BFSitCUStnQm5MZGtR?=
 =?utf-8?B?aDRDYStVTDg1RVVVQTNHME5nR3JvS3A1SFFuaUp6ajlUL0ZvYWx3WU1UNWZR?=
 =?utf-8?B?T2FRTEFBajdYazlzeXdtRlowUDNCZUI4aUdnRDhPMkRoVy82YTk0WG5xS2Vn?=
 =?utf-8?B?QmdoQ01tY2lPdHkvRjIzSFAyYkxDbEJPdXJMbnAvblBnUHJJajdCTlVGclNV?=
 =?utf-8?B?elQ1S1NGQVFyU0lNdE1pWmhCeDJvTk5VNzNrdlpKZHYxL0FSNkdUTTlqaEhC?=
 =?utf-8?B?Z3ZKbFBKYkNOZXBIQjN2SVk0R2VCejgycHBKVlhNMHh3cG9TRUs1M0gzY01z?=
 =?utf-8?B?ei9EUjNlN2NQckRjRDhOSncrZG9QY1hOTDlQR0JXRStWNkRNNDRJckdDQTF2?=
 =?utf-8?B?WnYvOGZWNkJpU2tTT2lpMklOTWk0dEl0aVVBakl0RWRVeWZSMEJMNWhHWFBB?=
 =?utf-8?B?UnpMQkJ6WXpGNk1pNEd0ZTBPOTJZUkZaZXFEdzN4UjFpcDVXR2xQdmhCS1FR?=
 =?utf-8?B?ZUFqWHEwK1VSMUhOZXFGMUxUQVlKeDdHSmVDcW5uVjFzWUUvclFkYWpZNkFs?=
 =?utf-8?B?anBJbDlDbmNwQUk1WGsvVjBEcnFVQ3h1dHQvNmFGempsTmE2TEdZTFN5cVcr?=
 =?utf-8?B?emZNa0c4K0svTFpJWm93WFRvL3hrQ1ozVjI1YWVnc1BUbmlycVNIbWNocXFQ?=
 =?utf-8?B?YmllU3BPcTJUV3lDR29qbmhJQ1Rscjh4R1Y1T3lmZ3ZseG9OVlBaUlFIL2pE?=
 =?utf-8?B?bExLVUFmOVlEekRubis3Wm84ek9rb0JtK3VyQ0tyZzNobHBmRXRadmhWYnpy?=
 =?utf-8?B?N1hNa0lpVGVhQ3pQWE5tdDFoTTNNN1IzYlVGUWdRZElXNmI5bUg3NlFpRHll?=
 =?utf-8?B?SDlLSmJVTnZCYlhFanptT29GVWlqeEU2WkNPSUo2NXBGYjJsUmFHMWxkQmxX?=
 =?utf-8?B?VDEraHgyUDVyMXBGVUl6UXdacEowMGJ0RmhpOUU5RHRxL0prZjVWY041dWlZ?=
 =?utf-8?B?SEY2UCtPYU1lUnZCTkRDdU9saDFQQllZUENnd3VEdEplZGNBWHpQSEh2blZ6?=
 =?utf-8?B?WUUybHpQU0N4RmJPSmIzWWFuaVpoeTRYTERMb2lZdnJHSzVTMi9xOVk0K1dK?=
 =?utf-8?Q?riFTuIq5BapwSD9QviEBktojr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w65i53t5lMk3ODhI2jtl/T47m2+cWBPxj5eH2CU0DRpYIVEa+ig7Bv4r3b3KhSgWoUc3ukrTu/p7LnmLFyMH2SHjFk5vjMGL24Rof/577R6ytnoTpo7144OM9QBkw8Gu9Bmkzz5sYaqpLvxLWiS5QyiHR3IE+VLwU4+5WwE554Zv/UhpksEMNNr+9dZwAyAH2+54WzLBtgif2l7jWlD3Fjxz6KVo5DzWYEdeHk/6IoqGBsK8BjxsgGDikHFPO+wEVGuPXFvP7oeqNh9Hv9kb6sEQDxEnd3WUVWqs65N/xrIPBm21ixHsjFGh/MkgARdWODDE/YYmvlztzDTQQgX7jShe+/vSmKm3Zb1cqsZe38Jr7L9EN+ArHnlu/HBwx/L4NeLe/NJsoi5HLNN38+sZFqs3rP8fuagNxyeKUjEDFoqpJJLITaL7P46ZFQCoYw97bAYK2e1evKQpM+GbBdlva5ZQupjom2wVmSi1ZG9i/4UAhKEg4iEoGnmGp8Oo8jEkIGj/ff00UMe3S3hV1Gw3QpskCG8rjJnOEA7hLuNSBeM3NbHQf0lERbUlV2m6TmIu8/iYonjq9n9wf1Q7AL4KZJEHxnGitbt2wjY4W1fxrco=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c3d65b-dad8-4435-c6c8-08ddd0d4bd95
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:23:49.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hqYmZqNGQVYR+3eIwRtSFyr/71uLF+YLY/zaZ4zAurlSYRXaYy+h/UfYk0fgxl6ujeGMDpmjKRSHsZ95WzJ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_02,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508010060
X-Proofpoint-GUID: IZPOIJOqw0hhuIe1PBqMZBdUTbQ2ZDl2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA2MCBTYWx0ZWRfX4Ue82mwUNGra
 pjT2K3pBzAs3nk3mgen92zIdk4RSE+vE3+cJVug9p4PtW/kZZtlGW3y+kXEn8mmmilrD5j1IJNF
 tKr3H4tyW4OELZpZyEx2fgmgZenOCuCckc1ozZfPqZWcsZuRgWGLHKFzZaBwCdydAAGsHXOS3bJ
 sPqNNnxaY0dtZeNjjXRj9NlymtmEmEdXOiCq3LriZubjxMJWoHJ8D7CdAe7f4GsEoNrleAmpHZs
 JEO31u6zLQr7koTRyrjQQfDzbzwjyjkfAhfycWFKsPhQXbAgkbjzRkDWVP4yF5RVYEraksytyPp
 CuQKcxK2fUEilLim+kEzmyq6OdBckpRVp7tkhuXgKTWchwba9I57Ylj+S54+oxHDa5gNLuPMphP
 Ju9FvExx4eSubllgp7OiIyb/x3/M5IQAUTdzaPom/ssYz74hkbU9JBBjqM6NAY6TdI2zps0V
X-Authority-Analysis: v=2.4 cv=ZMjXmW7b c=1 sm=1 tr=0 ts=688c7999 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=dBNoLWSzsDVfyMiOC5kA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13604
X-Proofpoint-ORIG-GUID: IZPOIJOqw0hhuIe1PBqMZBdUTbQ2ZDl2

On 01/08/2025 07:41, Ojaswin Mujoo wrote:
> Got it, I think I can make this test work for ext4 only but then it might
> be more appropriate to run the fio tests directly on atomic blkdev and
> skip the FS, since we anyways want to focus on the storage stack.
> 

testing on ext4 will prove also that the FS and iomap behave correctly 
in that they generate a single bio per atomic write (as well as testing 
the block stack and below).

>>> I'll try to check if we can modify the tests to write on non-overlapping
>>> ranges in a file.
>> JFYI, for testing SW-based atomic writes on XFS, I do something like this. I
>> have multiple threads each writing to separate regions of a file or writing
>> to separate files. I use this for power-fail testing with my RPI. Indeed, I
>> have also being using this sort of test in qemu for shutting down the VM
>> when fio is running - I would like to automate this, but I am not sure how
>> yet.
>>
>> Please let me know if you want further info on the fio script.
> Got it, thanks for the insights. I was thinking of something similar now
> where I can modify the fio files of this test to write on non
> overlapping ranges in the same file. The only doubt i have right now is
> that when I have eg, numjobs=10 filesize=1G, how do i ensure each job
> writes to its own separate range and not overlap with each other.
> 
> I saw the offset_increment= fio options which might help, yet to try it
> out though. If you know any better way please do share.

Yeah, so I use something like:
--numjobs=2 --offset_align=0 --offset_increment=1M --size=1M

Thanks,
John


