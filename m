Return-Path: <linux-ext4+bounces-9790-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C67BB40885
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 17:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AC83ADB58
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F332F3C2C;
	Tue,  2 Sep 2025 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RSrCckvO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bGBqIT0m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2AC30FC33;
	Tue,  2 Sep 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825596; cv=fail; b=hdaAyQoYoYdT8qacAtUg+bpskYcD5ffoW1MWpzVn8llKqEJJPP03eThq3FpaRFDgq/VRAHG0nNL7FwoOL7sc2a7FYQ5myRHGIG10dVtDuXm05xiy/zvn/Yy6K9yD8lHZ+BNWYJ3HarLmK69UpCOGeQQ2b3A+O3WiVFR0dyv37js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825596; c=relaxed/simple;
	bh=gDw59PXZpH//+tx6q3zuyaB3SFKKvOxlKMWKfLmNbJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gn/uDYesTRmpB4PZzP6A707ThiNlSVxmMC7N1lC9VJCsQ5mH1kEb5EJ3YzqndEwWbuRCPYe+rVrLEzsIJ8l0+4+cG6b91ZcRgi7urfFJu1VO0vGZ0Tbj/hnv3XkpM4oHb7DO3arwnO8t+n2Sb1NNz4y4e1x58r582ludePYytU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RSrCckvO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bGBqIT0m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Dg21a013156;
	Tue, 2 Sep 2025 15:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1LtrNSb2afAr7JJUPnqn8kVVwlJdNDcJUw26P80Hcc4=; b=
	RSrCckvOj1sF01hdV7gNEgNhOldlihVwD0WmD+XLIpwN576HV/iGHl0lzbsZmBfT
	jD+5A1lPmuBQ6jVcv7MIrP6fxwdafU/DqxpN1Ynfayvm+YTN6EDZF5zRpv4mLmyc
	68OfFc5Eu96e91gutChFo/34kNFdB50NMKE9cM/NYtsWJOeknmdWG9Onj0vhnSQW
	38OyzsykozWRQpxZjHF7mh754W1p/w412aC4zOFlLSXK8PuKyedysaw/256WgVP5
	0RSvtWYjYSigd5akveC14e3ZvQ03GJtN73jbG14WwwyB6U0fmryVnTbQXoKKwpAm
	S6dJNWh41l1/G86rrTTb5g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmncahr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:06:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582F5aj3032616;
	Tue, 2 Sep 2025 15:06:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrfhfse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:06:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDJ40fWLVvdTD60yZEPbxcj3TcuvhOY8JUwoceDv6CYVIoJUiDgSHZXh3uyDhnSPsbl8iLbOgCVIkiTNicLZo+B9T9gxNZ9aYpfMC5GKPcOPeP3cfLZJOXNT2FyoEQjVCDvjXWPHNEjO7eXtIKyKqJN+JYMe8zzOAGlWRLedrzKxRrHqBuL8iTOQtxpOAUf8CY9iPIKIfZE0oGgNBHdCi0NwSX2GvhVrlshgAetpRl8gxpDbIDiuy5IzcqtNo7T1DzSjQCrnGo+sARsZoNJn2ARrLtG1eShfKtfsaTiSDtXzv6Nlzr2S3lmBf4gYPI/tfOQkh0YdVXSI7nnBME5dLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LtrNSb2afAr7JJUPnqn8kVVwlJdNDcJUw26P80Hcc4=;
 b=c24Z2uN1Q1Q6q0FcFUTUwYFF0Zp6lsDWjZ+dGufcbx6wjo5z3tKjEye0LfENJDH/URLkC2Nrovbj1ibiXfOxkC7i2YsoCPu/NzO0SzYwnE8/DeczpvE98fnP5FPjlGMYKMStQnGzRyHdMzgFpKlWl54WK9sMExsHsVdm134rfxt8dY/VsO5UBO5GWr5PL/UHJ5R0TXbXvn5ESiNiQTT7BLMOhwA9M0UlJHZi37GR2S7qdImrJg2g6URVFJ7ZeRAD0S9RPJL+tHsh7PGfm9JA0hlyDVXWWVbP/lIgmEy+cirkI9BijrUKpXSp6o8kMQecf7EHleEcOuo20BJFwwH16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LtrNSb2afAr7JJUPnqn8kVVwlJdNDcJUw26P80Hcc4=;
 b=bGBqIT0mN2eDNL0GSrkxHiaLbU61BeS4Lr5P/lWAe7cAml3EbBo/tqTb2almtt2VbsaCFr9nOTXuRUi6dXRMOJoo8D48Rw9/UbduRcYqw7G5NwLzRgcbAy3Oi+J43dZU0ChhAtNlR2FXCb5W92cF2ruurwGXd8mNIOQkZi5V8UE=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by IA3PR10MB8274.namprd10.prod.outlook.com (2603:10b6:208:570::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 2 Sep
 2025 15:06:17 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:06:14 +0000
Message-ID: <e2892851-5426-43d3-a25e-be9d9c7f860a@oracle.com>
Date: Tue, 2 Sep 2025 16:06:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] ltp/fsx.c: Add atomic writes support to fsx
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <8b7e007fd87918a0c3976ca7d06c089ed9b0070c.1755849134.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8b7e007fd87918a0c3976ca7d06c089ed9b0070c.1755849134.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::17) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|IA3PR10MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d979b3-9d55-4d93-8aad-08ddea324226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cU5uSTdyUXJIdWlZRHdzTWwvUUpBSXRsck1BL3hHUEtyYTBZQWEzMU10NzBN?=
 =?utf-8?B?QXF4THJGS3QrU0RqdlV0SHdBRFpYY3NGUXp3c3NLVE1teUJOZ0ZHM2l1c3NV?=
 =?utf-8?B?SDA2Zmg5ZG9nU21XY1RSeldvd0dEbDIxL2Y4U293aDYwQTNHdWRqRWZtVC9B?=
 =?utf-8?B?c3kzdmN2cVNpQmlZSmJidjZ2REt2VzVRSjRTQ0RKdzNOVW5pT0R6V1c1NmNh?=
 =?utf-8?B?Q3Q2U2E3ZzJvMjBDVjNadnYwZTU1TEQwWTV4ckc5MmFuZk55OFhmaVk3ZjI1?=
 =?utf-8?B?SzlTNFN6MFFxc0JmcHhLL1YwM2NVK1RXUkgwbmhkaGxwaGlNMjdOeFhCaXlq?=
 =?utf-8?B?cExYaEppbGttVzluMmN4VGRZVU16eERwT1p0U2N2NEsrekRhNUY2UHpVSUhs?=
 =?utf-8?B?ZlVla3JCUWRFYmhlWEIyOTVtT2lsdW1UelRDYndkUkRQbExic05tUTNzNlhL?=
 =?utf-8?B?aHpwNUZZaEZ3bXZvcC9mZHF1K3VaeTdXdDE2L21ROEhEYWtlL3EyRlBXYUU5?=
 =?utf-8?B?aTNGSTVZVDZtNDJpS0UzVEVJelpST2l0T2NjUFZGZG9tNXh2TXgvYXVOTjhW?=
 =?utf-8?B?Q2J0OTVLU1pqMHE2djRYdGdMUkNOL05ReTBDZGdVZFg2bTVybUxPYnJDOUM4?=
 =?utf-8?B?UGQxc1ZyVU0rREhORnFTNXpBTy9RaXZaU3V0bGJHMUljTzFPOWdnL2tEekhI?=
 =?utf-8?B?N2h6ZXdodFZzK0RBNmpIWjFEc0pxZDkzbGJ2WERYWXVBL1hUMm92dzNxRE95?=
 =?utf-8?B?RUgwQi9BbzdNcW5BSmNuWHJDazl0djFXMHAvUTViZVJuNUZkaVRDQzRRMjVJ?=
 =?utf-8?B?cDVBT2VBUUJmUTBPUlJ2akpjR2M0SlVIT2RqT1FYRlE4Kzg1UjZ0TndteEUw?=
 =?utf-8?B?N2RJc3N4SGk3QWxnQzU2RWN5Q3pvQ3hKRU9yekJKOExxMFBNbkIvY0VOK0dL?=
 =?utf-8?B?ZHlvR2dGeHNKY2F4VUNZUDk4V1MyMzJkeEVnbDFGRHVmWW5Jakt1bDgxVFFW?=
 =?utf-8?B?MExoN0tuNnppVWNLZGlDS0lvd1VxaWxTdGcxSnh6WUY1YkZ4UWpLMXBuOGU2?=
 =?utf-8?B?cHdSSTl6eURQM1VVd1kzLzNMY2p0Y2o5d2c0S3BVSjdNZ1JkYUEwQ3F6aWZo?=
 =?utf-8?B?eXpaR0VmY2N4dDlJckF4bmhNMnc2Y3ZPR0NCN2ZsNXpaemY5UXNFZndEK1Rr?=
 =?utf-8?B?QkxJVVY1WEpIWlhhVmVWdS9NM3BLcFZKd2tja2JYbWIrUzF2VGVTNjRRaVlt?=
 =?utf-8?B?c0hISndrNUI5MHI2aWhleW1LaXVIZ2FkZVl1RjlnRVZ4eDlTTlUyZ1VnT3g2?=
 =?utf-8?B?L3NEc2N5Ti9HcEhLQ3hBdXVLYVRraG94aTdyM25DYWFldkVmWUdQQUppQmZw?=
 =?utf-8?B?dHhmdVBVd29wQkNUYTluOExDaCtVaFRiYkxJeU9oZW1qTzQ5emg2ekMxd1dW?=
 =?utf-8?B?UW1QTSt0dDA1QmxpRTFFcjZBbVZuL29VTkN3bFVpSEVTcHdSa3V3OW5Jall3?=
 =?utf-8?B?KzJJRVNIR3lUdUY3Yi9UcEV5TWYvS25FOE9MOFVJQ3YwVU51bWhNUnhQTVNr?=
 =?utf-8?B?TmE1cVNkR011NnUwR1FwT3EvM090S29zNVYrcDdnRVFSOXlEZjMzNHh3S3Ju?=
 =?utf-8?B?azhZWDMwdTRRRHJZdVFtRVhEYzlTYWQwWHE4TGFPMko5ck4wYVVqT3JRQXJO?=
 =?utf-8?B?YWtuc1ZJOHl6WE42MWJRTmt3VkxrVHhYMXQwWmtwVHZxZmx5djZHc3BmcEpC?=
 =?utf-8?B?WmptYi92aGdLblg5TmJydWRDQ3hMVFNRWWIydklVck1YSTdNbzk3elNIUUVN?=
 =?utf-8?B?UXZteGVqT3hGa0dVREp4SnhHY1loSG9JT2JLSXpTamx5cU1PVVBoeDlUekRi?=
 =?utf-8?B?SCsxMDdUUW04L1dRd3VrdFk4bGVtWTlNRTZMSk9mZnNOT3Z0Tm9WejVzY1dL?=
 =?utf-8?Q?jmFJsdDHOC4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFc4aWJ3QWRrWE10TGc2d1h2cW9GcnhpUy9VdWR5b2U5SCt3T2t4YlFsVWlt?=
 =?utf-8?B?bThsSEpaMVRBN1cwaUo3SDBpQld5d0hoMFpKekV0Rkg1TWZ3TURLVmtMZ2dR?=
 =?utf-8?B?c1g5TUhvTHhjbzFyTUFHaDJYSGk3UHp1U2FyUmlEWnpocXpRWnEzSnZ3LzhJ?=
 =?utf-8?B?U2VENHFsWXdQZHI1THRxNHEySlVkdmFET014OEs5THJoNWlBcmtLa2srcDdQ?=
 =?utf-8?B?L2p5aTdEbGFlZzUxSGFOMUZMWnJ0V3FvMU1nTjZjLzk4MFR2SXBkU3E3Vzhv?=
 =?utf-8?B?M01PdmVMaDBTU1NDUUQrUllPMURZVWJOT0JUSW90KzlVdXFCbFhSKzhxZnJI?=
 =?utf-8?B?a3FuU1I4VkQyZFQ2bTkvWkdYL2JBMzBMVldIYUp2RlRBL1A1WmhQdHdGTzE2?=
 =?utf-8?B?U0RQZTF5Z1hCTkZEK1pxMjZuZTh3RHc0VHB4dDZCQVlBUnNBTVpYbWR4RVlu?=
 =?utf-8?B?emIrbGUvQVVKMmxMRDMvR1ROMDdBbklMb0lkcEt3MXRZWktmYldYSElCUzgw?=
 =?utf-8?B?TE1RVGNtL2RrYkxTdktsdUtsQkNhdWZFelNkRWg4UVFDcWN3cWQxNm1lWThO?=
 =?utf-8?B?NmxmbDZnWGJMMWRLcW5nVU15c0srMEhvU3IrVklTazN5bWlXYmN4VXVGc1ps?=
 =?utf-8?B?N2s3elhtNi95eFQzSTBGbkp4YUxjV011bzJpQXRnZnczWXluMDZHaUE2ZTZj?=
 =?utf-8?B?MUY4STM2Ykxad3FKMFVhOTZnL2RWSCt0WVpsdG1LM0NwRmZqb1ljREhyQzFB?=
 =?utf-8?B?U1IwRlhuZXFMM21hTTdrU0N2ZUdIQW8zZys1ZjV0b2hVUEo2bVZFQjNBUEJR?=
 =?utf-8?B?L0MzTUVpRk5manBHS0VaaCtvWGRMT1d4dS9ieUp6amwwMmFEMkdhankraE1E?=
 =?utf-8?B?ZStBemlESFFubWZxRFpKR3JwaUFEZXZva0tGaEtvSVlNbjVBNmFpU1M2Sy9I?=
 =?utf-8?B?RGVLME8wNnIxb3NxUHEranEzMTRkZXZyZ3ZQSHpXSFQ0dXptSDJSRUUzK1B3?=
 =?utf-8?B?RjlhT3oybFphaytWVXF0dXIxUHMzbkI5dGFQQkdOaUZpTnpXLzBZV2VZeEpQ?=
 =?utf-8?B?bTNEc2hTMi9zdHlRNjM5V1BEOERQWmh1bGRMNXdWcFRqYXNjOWpoSWF3OTNY?=
 =?utf-8?B?VCt6Rk9oMEEydE1mL3pqVCtDTkM2UzJ0TlJyVFdIMFVMVFRzVktYSGhxZ3RH?=
 =?utf-8?B?a0E3dHU1MzFGaG1CN1BNNy9VSTRRajFYMi9KY3dvQ09vQVlNYXlmQXVvbjF3?=
 =?utf-8?B?Z25lbWg3VzhkSDg2dGpDVFBlczhuUmJuYmIxY0RXWDNubUZiWkxlcGZjZWpN?=
 =?utf-8?B?Lzh5WXZhU3lPQWhTU3hLNTRDaVpBVklTL0wzVE1LVWw4S2g0WlUvTlFzM0Jh?=
 =?utf-8?B?SlQ3U1FBRW12S3JyOHRPbkRJcERLb2krYURJbDJVQkpnNDlyZ0crMGExaU5F?=
 =?utf-8?B?TXpIbGhCbk5RaDdnMEx1TE9DVDVwc2dqR2ZWTnVNampsem5FclJnVGZ5Y29X?=
 =?utf-8?B?NHdRMGlRdXRRL0I0d1pYSnRTR0lDSk85MHRtTEhrTm5Iay9yejJSVGtrTzd5?=
 =?utf-8?B?aHkveFpOSTZIUGdVaW9BOVZmRFU3UmRFUm1mWndSd1NWRjZjczYvU3NzR2or?=
 =?utf-8?B?RFJHb2NDb0kyelhDNHBQQTZ4blUwODVGWnBWdFlYTVBGRm0vS3BiWUJ2Y0E0?=
 =?utf-8?B?LzdSejhtYldIQnpKcTBha3FBSFlNQkJrMkVVSUJHOExQQ0QyeExwdlNFZ2x5?=
 =?utf-8?B?VENMYzdhRVU1cGtZUVVTUFU2YW9NQ3NYd0k4NS9mOTBzSTBrZldiR1g0VXlS?=
 =?utf-8?B?RE1tRDlKKzhId0N0RFRHOU9aK2JPanpFOFloRFdLbWxQeEk4Nkw5MHZ4TzVt?=
 =?utf-8?B?ZTN1a3hiTDJJVldXYmFyb2IrSkFwTGpydnZQQ1d5cGlXQ1ZTNlNEQmxyZ1h0?=
 =?utf-8?B?dlVBRHZVdlZZZ2MrS0Rsc3UzRzRpeXhCV2dHNkV6aHErWGJlSVBIT1RDZlJ2?=
 =?utf-8?B?UHlhZWRDVUJFNVVyU0RQRWhSZkdWWlRWcmtGQjIxeFNJbklMY0RXVVhLNXBL?=
 =?utf-8?B?cmpNZy9aWWIvMGVKb0k3NzNRbHZkZlFPeFptOWJuaHp1RFN0YkMyTm81ZHF2?=
 =?utf-8?B?TE1SNy8wL3hTM01DRm1sSzk0R1lpODhlVXJaUTB4b09na3I5R05iUlpXTTlr?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sW70P9w+JprhMNwcDKgeYn9IUAHZJvgmtLAdQwUnNryfhV9Q49euzCy9u/Ppl8WOILAEdryxQNYj+C3rgUHcfEqT8Y3/od/CnOIW+zHMul0XDxqSpcSNUUi5Hh2KmLhOa58+lrI4wKG98UAh84z4eP75BseegCM3jEUU8opSBjZLGcJtK0+u36Y3K+ZFBxqWkw2xymQSg0cMUqjVbW3+INaKBm/6z2FlAym1gW3KtXSzWmPV56qrmAWUp3ftToh6N7C0Qulhok9H7reoyXbMdHl0WlSJlnC5uSt518my0NozpQehtbMlZ1fFb5GZeu73vXCamF4FfINxs1QBmLNzmZe8oVo+wxlTgYzznqXP4QHE4aYooeDtfVw0FWUECgIxKVM4giSrP6LySTlUICfOt+mrMiE14j5GJQ9rgRpIgSXnFYGYs2aBatVswsjiSGXSofV01str7wGpWXCjz3cJd+ZIKHeaxJjJPdJ8U9dViuTo71F1cbG0gXo4fUOaWAFo+fjYmong0SmSJSNyaxJ61c5gtJOiyZHoGU7jxr218hr/PF7QYrgVTPq/w5lj0LQNYID7Kwp3ZQvubLnGPnk6sg5zG8vA/FCFrg8/6lACS5o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d979b3-9d55-4d93-8aad-08ddea324226
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:06:14.1803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QK2AJUSKCoWQcIqCpc50fpHaG7tSZtw+u+caP/qc4mORPTUbUuwByq8kElkMBXAAS6qiuQV1jKOyAQTTMj2Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020149
X-Proofpoint-GUID: BBEGRt-9iuOiDpMiElfH8LH6TwxHBWI_
X-Proofpoint-ORIG-GUID: BBEGRt-9iuOiDpMiElfH8LH6TwxHBWI_
X-Authority-Analysis: v=2.4 cv=Of2YDgTY c=1 sm=1 tr=0 ts=68b707ef b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=x80sg5X6LzuwJujQC_oA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXxPNUm0scknQu
 XmJNBHpt+chuO5xshOkGz74Zcjrgu0mnPpems1TgQ+805hnogwGJLP2bDHoryS1SCY/MEKp0d6A
 H6EAnFsyS175nhq1Vses6iuZHPPYdDCjPP88vAD9LPu6m+exwrKS9d5axPpzUKGf/H8pIxSFhBx
 7B9nBIYb102ObFh8hBnMN2qNUXMyKTizkpgwUSrTExOQOHqOHxYrZbfS2EcCIot6nxpXD/LOn53
 qJUxDKstStd0L0PthB1O3I9zFDDv98YBMOBAIIYdadu+NFBATljdsiKZ7RbXpkCFnB2+681leeQ
 cdbu1BB7fh9T6UWCyso67M6jyJ9PJYZzGMtzP8Nl1bBXJR5D9XofSTn70HE3Cdo1/srO+uCYvBP
 Qx3cAnI3B/W7lc1l0izlOwFuDH+9HQ==

On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> Implement atomic write support to help fuzz atomic writes
> with fsx.
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Generally this looks ok, but I do have some comments, so please check them:

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   ltp/fsx.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 110 insertions(+), 5 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 163b9453..1582f6d1 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -40,6 +40,7 @@
>   #include <liburing.h>
>   #endif
>   #include <sys/syscall.h>
> +#include "statx.h"
>   
>   #ifndef MAP_FILE
>   # define MAP_FILE 0
> @@ -49,6 +50,10 @@
>   #define RWF_DONTCACHE	0x80
>   #endif
>   
> +#ifndef RWF_ATOMIC
> +#define RWF_ATOMIC	0x40
> +#endif
> +
>   #define NUMPRINTCOLUMNS 32	/* # columns of data to print on each line */
>   
>   /* Operation flags (bitmask) */
> @@ -110,6 +115,7 @@ enum {
>   	OP_READ_DONTCACHE,
>   	OP_WRITE,
>   	OP_WRITE_DONTCACHE,
> +	OP_WRITE_ATOMIC,
>   	OP_MAPREAD,
>   	OP_MAPWRITE,
>   	OP_MAX_LITE,
> @@ -200,6 +206,11 @@ int	uring = 0;
>   int	mark_nr = 0;
>   int	dontcache_io = 1;
>   int	hugepages = 0;                  /* -h flag */
> +int	do_atomic_writes = 1;		/* -a flag disables */
> +
> +/* User for atomic writes */
> +int awu_min = 0;
> +int awu_max = 0;
>   
>   /* Stores info needed to periodically collapse hugepages */
>   struct hugepages_collapse_info {
> @@ -288,6 +299,7 @@ static const char *op_names[] = {
>   	[OP_READ_DONTCACHE] = "read_dontcache",
>   	[OP_WRITE] = "write",
>   	[OP_WRITE_DONTCACHE] = "write_dontcache",
> +	[OP_WRITE_ATOMIC] = "write_atomic",
>   	[OP_MAPREAD] = "mapread",
>   	[OP_MAPWRITE] = "mapwrite",
>   	[OP_TRUNCATE] = "truncate",
> @@ -422,6 +434,7 @@ logdump(void)
>   				prt("\t***RRRR***");
>   			break;
>   		case OP_WRITE_DONTCACHE:
> +		case OP_WRITE_ATOMIC:
>   		case OP_WRITE:
>   			prt("WRITE    0x%x thru 0x%x\t(0x%x bytes)",
>   			    lp->args[0], lp->args[0] + lp->args[1] - 1,
> @@ -1073,6 +1086,25 @@ update_file_size(unsigned offset, unsigned size)
>   	file_size = offset + size;
>   }
>   
> +static int is_power_of_2(unsigned n) {
> +	return ((n & (n - 1)) == 0);
> +}
> +
> +/*
> + * Round down n to nearest power of 2.
> + * If n is already a power of 2, return n;
> + */
> +static int rounddown_pow_of_2(int n) {
> +	int i = 0;
> +
> +	if (is_power_of_2(n))
> +		return n;
> +
> +	for (; (1 << i) < n; i++);
> +
> +	return 1 << (i - 1);

Is this the neatest way to do this?

> +}
> +
>   void
>   dowrite(unsigned offset, unsigned size, int flags)
>   {
> @@ -1081,6 +1113,27 @@ dowrite(unsigned offset, unsigned size, int flags)
>   	offset -= offset % writebdy;
>   	if (o_direct)
>   		size -= size % writebdy;
> +	if (flags & RWF_ATOMIC) {
> +		/* atomic write len must be inbetween awu_min and awu_max */

in between

> +		if (size < awu_min)
> +			size = awu_min;
> +		if (size > awu_max)
> +			size = awu_max;
> +
> +		/* atomic writes need power-of-2 sizes */
> +		size = rounddown_pow_of_2(size);

you could have:

if (size < awu_min)
	size = awu_min;
else if (size > awu_max)
	size = awu_max;
else
	size = rounddown_pow_of_2(size);

> +
> +		/* atomic writes need naturally aligned offsets */
> +		offset -= offset % size;
> +
> +		/* Skip the write if we are crossing max filesize */
> +		if ((offset + size) > maxfilelen) {
> +			if (!quiet && testcalls > simulatedopcount)
> +				prt("skipping atomic write past maxfilelen\n");
> +			log4(OP_WRITE_ATOMIC, offset, size, FL_SKIPPED);
> +			return;
> +		}
> +	}
>   	if (size == 0) {
>   		if (!quiet && testcalls > simulatedopcount && !o_direct)
>   			prt("skipping zero size write\n");
> @@ -1088,7 +1141,10 @@ dowrite(unsigned offset, unsigned size, int flags)
>   		return;
>   	}
>   
> -	log4(OP_WRITE, offset, size, FL_NONE);
> +	if (flags & RWF_ATOMIC)
> +		log4(OP_WRITE_ATOMIC, offset, size, FL_NONE);
> +	else
> +		log4(OP_WRITE, offset, size, FL_NONE);
>   
>   	gendata(original_buf, good_buf, offset, size);
>   	if (offset + size > file_size) {
> @@ -1108,8 +1164,9 @@ dowrite(unsigned offset, unsigned size, int flags)
>   		       (monitorstart == -1 ||
>   			(offset + size > monitorstart &&
>   			(monitorend == -1 || offset <= monitorend))))))
> -		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d\n", testcalls,
> -		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0);
> +		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d atomic_wr=%d\n", testcalls,
> +		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0,
> +		    (flags & RWF_ATOMIC) != 0);

nit:

	!!(flags & RWF_ATOMIC)

I find that a bit neater, but I suppose you are following the example 
for RWF_DONTCACHE

>   	iret = fsxwrite(fd, good_buf + offset, size, offset, flags);
>   	if (iret != size) {
>   		if (iret == -1)
> @@ -1785,6 +1842,36 @@ do_dedupe_range(unsigned offset, unsigned length, unsigned dest)
>   }
>   #endif
>   
> +int test_atomic_writes(void) {
> +	int ret;
> +	struct statx stx;
> +
> +	if (o_direct != O_DIRECT) {
> +		fprintf(stderr, "main: atomic writes need O_DIRECT (-Z), "
> +				"disabling!\n");
> +		return 0;
> +	}
> +
> +	ret = xfstests_statx(AT_FDCWD, fname, 0, STATX_WRITE_ATOMIC, &stx);
> +	if (ret < 0) {
> +		fprintf(stderr, "main: Statx failed with %d."
> +			" Failed to determine atomic write limits, "
> +			" disabling!\n", ret);
> +		return 0;
> +	}
> +
> +	if (stx.stx_attributes & STATX_ATTR_WRITE_ATOMIC &&
> +	    stx.stx_atomic_write_unit_min > 0) {
> +		awu_min = stx.stx_atomic_write_unit_min;
> +		awu_max = stx.stx_atomic_write_unit_max;
> +		return 1;
> +	}
> +
> +	fprintf(stderr, "main: IO Stack does not support "
> +			"atomic writes, disabling!\n");

Do we really need to spread this over multiple lines?

Maybe that is the coding standard - I don't know.

> +	return 0;
> +}
> +
>   #ifdef HAVE_COPY_FILE_RANGE
>   int
>   test_copy_range(void)
> @@ -2356,6 +2443,12 @@ have_op:
>   			goto out;
>   		}
>   		break;
> +	case OP_WRITE_ATOMIC:
> +		if (!do_atomic_writes) {
> +			log4(OP_WRITE_ATOMIC, offset, size, FL_SKIPPED);
> +			goto out;
> +		}
> +		break;
>   	}
>   
>   	switch (op) {
> @@ -2385,6 +2478,11 @@ have_op:
>   			dowrite(offset, size, 0);
>   		break;
>   
> +	case OP_WRITE_ATOMIC:
> +		TRIM_OFF_LEN(offset, size, maxfilelen);
> +		dowrite(offset, size, RWF_ATOMIC);
> +		break;
> +
>   	case OP_MAPREAD:
>   		TRIM_OFF_LEN(offset, size, file_size);
>   		domapread(offset, size);
> @@ -2511,13 +2609,14 @@ void
>   usage(void)
>   {
>   	fprintf(stdout, "usage: %s",
> -		"fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> +		"fsx [-adfhknqxyzBEFHIJKLORWXZ0]\n\
>   	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
>   	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
>   	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
>   	   [-A|-U] [-D startingop] [-N numops] [-P dirpath] [-S seed]\n\
>   	   [--replay-ops=opsfile] [--record-ops[=opsfile]] [--duration=seconds]\n\
>   	   ... fname\n\
> +	-a: disable atomic writes\n\
>   	-b opnum: beginning operation number (default 1)\n\
>   	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
>   	-d: debug output for all operations\n\
> @@ -3059,9 +3158,13 @@ main(int argc, char **argv)
>   	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
>   
>   	while ((ch = getopt_long(argc, argv,
> -				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> +				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
>   				 longopts, NULL)) != EOF)
>   		switch (ch) {
> +		case 'a':
> +			prt("main(): Atomic writes disabled\n");
> +			do_atomic_writes = 0;

why an opt-out (and not opt-in)?

> +			break;
>   		case 'b':
>   			simulatedopcount = getnum(optarg, &endp);
>   			if (!quiet)
> @@ -3475,6 +3578,8 @@ main(int argc, char **argv)
>   		exchange_range_calls = test_exchange_range();
>   	if (dontcache_io)
>   		dontcache_io = test_dontcache_io();
> +	if (do_atomic_writes)
> +		do_atomic_writes = test_atomic_writes();
>   
>   	while (keep_running())
>   		if (!test())


