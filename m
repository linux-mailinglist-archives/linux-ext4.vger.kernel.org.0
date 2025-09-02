Return-Path: <linux-ext4+bounces-9795-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7844BB409B1
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 17:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A193AA604
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 15:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3143332779E;
	Tue,  2 Sep 2025 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JRj1LwGS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gm+SpSMA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940742D5C8B;
	Tue,  2 Sep 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828184; cv=fail; b=Lgsdyv1vS+9e+0xBU7D3kmH+CIcazkplaIbLz/SZTOGKjJ0focHdXumgZLAjQXO8tLqzrmUkzMRe7xIXGxWyJiayIqbgXSSbYZ6c8hXr5/xv/HT5OsHetzETy6ECdTe2lC63TfLD8Tfampo9sNK3GQD1Ws6PbOqkZx/uFt2zaFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828184; c=relaxed/simple;
	bh=GhqxJDahpMSjGB33SmpK4EK3VAZo5mU+HdliYPGwNQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cq/i+BwkrCJvafG8HV/eJeK1h2KVLI0Rg+pmsFdrxyNKEjzZUCS7C347++0WQUXv72exQpRbkGz4TKwvarFJ/NDyiKnrFX+7ZR5pAo3Tx9SSrDj+YewZvDVfl9DzVSzGDkoNXu0F2TtcTuc6vgnq1c3OqTJdTjvO/7LSoCV8XBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JRj1LwGS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gm+SpSMA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582DgDRl004300;
	Tue, 2 Sep 2025 15:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DBP+vXm/GkGptx0tYZ/woIue0ROUyM/zhQs0UYXrVjA=; b=
	JRj1LwGSuYfmbxM1QKx+pY8WGAfDGCBJZcm9YYKd4zXR5Fw3S/noLy+rSWfmGPDV
	197krsNUJJ50yXuKMGRpQsTQCwIbJLJG2Ze8Qv6t4giJcLEhjuOScJ/1TsEaHR9b
	TqOrQvAf/Y0M19XSohtj9Dug+P6Dgf4xDI5Dcf4SIqkC9+/wfnAFBU/lbM8CUEBP
	yQNVa54uwmooGOQgXDQVNGR6TouTY30I+5Ll2cCwXJGIvzyVXOxMU91MiuqLSi5R
	JN+B4FJDHNNm8/L7iKyXgA+jkFT1Y9ckdAPoNwZ4JYR0mqecSoOAj6TScoWK3gJj
	f3K4FxVkMqPjR04qoBs6Kg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usm9mffq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:49:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582F5SMp032695;
	Tue, 2 Sep 2025 15:49:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrfk318-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:49:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+NEYj6aM0+SYOIm4VwRRxAvXzv2gpT4zkjwUYfVsrqzBWfnWgIwUyl4MhhdU1eMTNP5zNBCh5ar6W2WBMnoRz4pzG/i0xZjEp6rwKsta8FiFKd/VjZxqSzYrO/vH0CVUcMc3/uH7NHYqzQxmPJ+8C34CxWnHa3QQu11UrDuHSnQA1AuGQBttjlMqBTj3niAKcCSImtsNJssTzEEkpa9aBRIm3GMw3+j2QIqGLRd6cmy1XP8KyOVNTU3aPufd9EaqY5PJHSI50NcEHWsRiVVp4tH94WZgwvi3W9oSc8VB+kevT+r86CnOxWH+1YcTG8EaL04yXZh6ADHdX8Q71zyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBP+vXm/GkGptx0tYZ/woIue0ROUyM/zhQs0UYXrVjA=;
 b=c8lT+wSjzJDmqwFcU3NXWCLkzgb8b1i2dkLKrDJSsE1UPWzYs5fFNZnWwskVOECdPks5y+d4dnams4aov++mQ9s79+xzAt2KQIdAtPNZ+u+vgTyVR53vENoWDmu1LJSN7oYqOYV8mQNGkm1Oc2mhavle3tXhFkUHIw8b6YhJVY1Sk0YvstMETRICVQRNhWbCbeJlxSo9+/BcmEiR0Qe2zgiC/+b5eEpRYVkx3kUPSfpeEw17aDEld5dMERTjGglGXMQZVX9JUhm+5ae3WDOEVW+zQtxxQsl3fbsLb8tBVQ6/ldv2Co6UxNwnC/vZMyoKz9yJd8YV43/F75VcXDptoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBP+vXm/GkGptx0tYZ/woIue0ROUyM/zhQs0UYXrVjA=;
 b=Gm+SpSMAp6pVgo2GAISyVNdOb70miONKWcYM8RcDo92E8+D7siZrXlosYIUPeAatzpsiEThLF6iImLaSxvh1PNY4tM6PvjcDMsb5YQYpf3niNfuZQ9AkOrpqXRKJnUWYr5Q/z13yRV9YxR8dhpahJS9zl9OTeWMlhj2ctu5OKJI=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SA1PR10MB5781.namprd10.prod.outlook.com (2603:10b6:806:23e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 15:49:30 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:49:30 +0000
Message-ID: <12281f45-c42f-4d1e-bcff-f14be46483a8@oracle.com>
Date: Tue, 2 Sep 2025 16:49:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] generic: Add sudden shutdown tests for multi
 block atomic writes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <2b523de842ada3ac7759cedae80485ae201d7e5d.1755849134.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <2b523de842ada3ac7759cedae80485ae201d7e5d.1755849134.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0503.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::10) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SA1PR10MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b268f66-3e1f-4a46-723e-08ddea384e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2VoVStOTFg2Vys0MkNJNDQ3N2RGK1RFdm9IbzJxVFMzZ3dnQkMxOVB1aUEx?=
 =?utf-8?B?aXkxV0JqRDJ4VHRCSGJueGFySW13SzdSR1pjZnR4TCtkQ1RJK3AzYWE2Q3JM?=
 =?utf-8?B?YUJWZFovU3dLQmdKYWQ0azBxY3Azb3dxTWFxbmtrVk5ycXNCa3ZvcVFkVXhY?=
 =?utf-8?B?aGlESEtKT2hyWEV2K094d0ZWN2JnelJ4V1cxbnhyd0ZjU20yZ1V1cEFzNyt0?=
 =?utf-8?B?RHhxaEFOajNyY1E5WEFTcm4yNEN0b3JUd3hMWWlwSFlIeitrS29Gck02SWtI?=
 =?utf-8?B?R25YbWluNy9UZDNhQ1Eyb0ZjYWMxM05HYWNHekJKb2hVWFBoT1U3NE1xWklo?=
 =?utf-8?B?WkphMjJiU2ZIQmw0L3gvcUVHM2psbmJ5d0pkTGJkYU1FbGNrSEs0cWVhQXEz?=
 =?utf-8?B?ZmFPY21WaVZvNmRRWTlvR0w3UkxhOGhLREVncERLcE5jS2N3K3hQWWVIUkxH?=
 =?utf-8?B?WDc5djMrQ2lrUjFOdWQ1K0E1eWVXVitaY1I2dHMrSGFUc20xd1NTYjcrQ0RS?=
 =?utf-8?B?TkZwZ1poZ1JKakkyelZWRndXSFllcG81VkpCV0NoQVVXQ2dCUzA1a1V6by9h?=
 =?utf-8?B?VFo3eUtlVFFFQ05QZUJGMVUvbXJMRjFkNFdpcm1OZ09XUDROazVsVW44a3pE?=
 =?utf-8?B?NWF3RndNR0lWWlJQTlpURFVHamVzWmJLdFdjM3ZNNDVnNzhGbWt1VG5OTTQy?=
 =?utf-8?B?clpGOHdLTHFLblp1R3FyZ2Zjd2E1RWY3SWRQOTlab3F4ZU1oeEkxanMwaUtU?=
 =?utf-8?B?MlpPcC9tUUlkOWF4UTNXM2dmc0M1b1lmdkdVdnBNQ0I4TUZSZmYwaHdBUll0?=
 =?utf-8?B?VHVSTHZqQjBnMHBWTG95enYxMUF6aXJYR1hpZEJvcDZZbUx6dkxBM1hocFZR?=
 =?utf-8?B?cHZHNmt1WmMydEsyRVAwYTJReUl6Q001UkN2R1RVbkFiT1EvRVdLZEFORlZD?=
 =?utf-8?B?L0d5ZzhYWnhrU3BlYk9GM0d4MXJFMnFvVlVzcFc3VGhSckRISmZNRlpGL1FT?=
 =?utf-8?B?eHFYRXhsaWlPK1JKT1psTEdsRkNtdFhTcy9pRkt5b0VybUVBOWM4VERJWlpS?=
 =?utf-8?B?UWtoLzV2T3RZUThmYjBnN0dZS0xsSFM4aUtIdU04cGc4VTNyc2Y3THpCb2RD?=
 =?utf-8?B?RGxrM2JvYXo5WURNY2lUamh0R3ZYS09LMlM0T1BvNzZkMnZIcG9UV2QvM0k3?=
 =?utf-8?B?ODFDdGtjYWJwOHY2Mmh6cW1zU3BodUZHZkU3RUdVdXZTN3BsTU1Tc0pGK1BP?=
 =?utf-8?B?bFhsNXpPcUhHMG05dktJKzdURG5aWmlaa1lWbnJMNGlCbTVUejVWVDEwbnMy?=
 =?utf-8?B?cWxDajY2aGltelFtVjc1SjhacmNuOFFOWTVhai9WZjh3VGRwemMzeEZFaWFu?=
 =?utf-8?B?a2JSUllVWTdveDgvVEJPVk1aVXpDUFR2anJVaDlVRzlISjFFYnVBL2UydkVZ?=
 =?utf-8?B?Z1NUKy9ReWtaUGdOOVpkQ3oxSnZpdXA1ZTBRcWxRNWludUdwRDJmbjkrVjJv?=
 =?utf-8?B?ZW9pL1d6RWRBdm03K0ZuQ2c1bFdBQ3R1VnhOME5VaUI4K0lNQktYMCtjbTNq?=
 =?utf-8?B?d1A0eGFHQTBtUlBEV1lNNGFFNUVBWVZsdzJ1akgxbStTMWZHNjVDL1ZlR3Rz?=
 =?utf-8?B?Vk5VaXlWUUErMnNYcExmRi9QdVpNVC9hQ1N3TkdkS051KzFmVm8zVXBiZGt4?=
 =?utf-8?B?RnhtNWQyMVhDL0F6NDNDMmNROE9GeFk1K1BjejMyYUZIZG5iby9RQ1l1Q2ZG?=
 =?utf-8?B?N3pEanZBZ0lZdkVxMC9nbUxxSlRkakJWQzRYeHdSZ3VLWkVaSWNuUXJjK2Ri?=
 =?utf-8?B?ZVZBdGE4WC9SNFNFblowNTR1OUZHTnltMDEwL0NPYmRQbXFhNnduWjR6K3Ux?=
 =?utf-8?B?ak1OcDFFWVF1WUI0Nkx0bm9jR2hxRTZuVEc2VUd3L05LcVROTDNEUENwamg4?=
 =?utf-8?Q?KbJ6A2hUvNw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0huOGxyMWFieW5QR25tbnZDNUtGVHcyd2pjSy8rbGlGRDdmNjN0OUhLcitI?=
 =?utf-8?B?RUlxNU9rYjN3ZXY1TWNnckJMNEN6QVBkTGVuSjB0a1FDdWYxcVpwVGkvKzlH?=
 =?utf-8?B?RE1Fby9nM29uVDJxcjJ4MTRET1VueUFjQ0N4MnhzS1IxUmpWdXowbWZ3dWNa?=
 =?utf-8?B?V2tQWVRpSVZScExVaVJ6bEU2cXZjZHk3enFqd205ZDQ3YUF5WDBzM2N3N1FU?=
 =?utf-8?B?MmI1d29QcUxOY3pmaWdXcDdhOU00alVnZG56VkxLYkNkT3RCbjBPWUI0RDNX?=
 =?utf-8?B?ZXRYcTdmcWx2WGNIaVpSZWpJbTNzdlJFcDFNZ2hiQTRwWGJHMVhadmNqQ1Q3?=
 =?utf-8?B?b2J3VU5udmk2bE54K1hFZzhLV2l6QWNpSFZoUVBpU1VPcWRHbjRmVGJhVUVI?=
 =?utf-8?B?bmg4d1p2amQ1bzVMZXZGK01DWnVaanE4L3lyNksrZ3VDYjN4MFJVRnF5eENt?=
 =?utf-8?B?RHExQVdkaHF6Mi9KQUlxQ0E0enN3OHFlOUxBWmNjVVFzeHlZRmdhYkpvem1O?=
 =?utf-8?B?S1g4b2xMTStGbmRMSEd5WGZpZ1BkMHo4UGtIVkJXdnFHTlNGMkJQSGlsb1da?=
 =?utf-8?B?SWFHRlZGdlBnSEk5Um1UM0tEWERwZ2YxWUpSVmg3eVVibjNadkR6dHI3U3Iz?=
 =?utf-8?B?TTlEcVJpK1Bmb2RIUTRNSWZmN0pMNWxrNjZnNEtURE0wV2x5Y0loUEpSR3FI?=
 =?utf-8?B?Y0QxeGZPdm9xM1FrQndEQkJTSU1LaFRCSWZCRHl2Ukk2OFpKYmdrdjhkMStR?=
 =?utf-8?B?TnJldlNSaHhvS0NjZWR3bTdSdjRIekExRzlBclJMU1lsWDNGK21EWGt5Yktz?=
 =?utf-8?B?aW50dEszNUliQVV5ZHNiSnFkYk5PNjdvNzgrMXBzNTI1RDJ1RzNYWDVFT1M5?=
 =?utf-8?B?anFrSk9sZDFmZHQ4dG5mcEdHa1diRklDclFiZndiSnRMUnBnOGxVdUhZNUQ4?=
 =?utf-8?B?ejlwMU1kVUlRR0NQa0wvV284Q1JDVTluMC9QWU1tUm1uOW5jTHRMNjRmRTU0?=
 =?utf-8?B?RmcwMGV4TVZvYzFjdzdJcjJzUXBOYkl2NzVDR2dhZUw4M0w4Q0R0OFVjWTdi?=
 =?utf-8?B?ZDVPQTRRdmNaR1p2Vk1BT2pPUTl3TGoyTHJCeEc4bkR1eVRqMllPVDkraGo3?=
 =?utf-8?B?cmMwbHBNdTJOMVhjRUIrVWRSOTArRDBPS1E4Zks0WnRNYWgvbTJneFBIa1ha?=
 =?utf-8?B?YnF5RlY1QjVicW0vMkdpVkt0SEkzMHZxNGw1UEY5SDNvQWhJR29tY1FFS1lW?=
 =?utf-8?B?ak54RnIxS0NMZVBvNkRZdmN1eTZvaUFKMDFxMUJFSnNqWmIrRGZYcmUrM0Jr?=
 =?utf-8?B?RGJkYzl0WWs2c0NrZ3lKdTV5TjN2VGJjN1JMVFN1dWdJMVlMMEpiTGx5K2tD?=
 =?utf-8?B?Z2I0Qk5aSXM1R1RJWWlhV3RickZuV2duajY3ZUJtOEwyTzY2Snl5OEtzdW1m?=
 =?utf-8?B?VFlPNTNLdW9xWlRCVEhIbG1wMGR1elI3YnJFanhrMWVBWFV5TXh2S1RnSnov?=
 =?utf-8?B?bDMzZDFGZUJSTytDRk5VaHlMWW1zNDhhUjZMTW9HRXBiLzg2TmdoN2g2QTc0?=
 =?utf-8?B?eUluMk1HcE5ZTmN2dWVVcloxTGlHdXNJY3hmWWY0cGpXY05IcHkrYmpaWVkv?=
 =?utf-8?B?cEpCbisxbzUreU9tUk84d0xuMkd4ZnlLblV4Nm45cmhZVlRqTXExWWpFTmF5?=
 =?utf-8?B?TFFMUUFzUWxoSXgvL2tweUZTR3ZGc2RWK1JHZks5TzUreFVLd0ZQOEFlOHdV?=
 =?utf-8?B?L09xcUFjQlp4bGgvMUlyRmx2ZXlYWUg3MlBxRXc4aGtFbU5nY2pVK3lzSjZE?=
 =?utf-8?B?QWJCSVFrNVBDWVRsLzAxWkF4R3NnOXlWckdmWEh5aU9NWER2bkV4cWdZcG1D?=
 =?utf-8?B?Rm9xWlArOWxXVWNKanRscVJPdkloUVkrSWQ4UlhSUTdUaEY4N3VqT3RxTThO?=
 =?utf-8?B?VVRvL1d4MUdnckcwOTUxWFhDS3d1YTRSbEVhcUE5VVVwcmcySDVZdWV5WG1W?=
 =?utf-8?B?blI0UXE0YklhRmowakt5eUtRWXF2M0VoWlUxRGdFN2t1V28yelV4QkNKWFpu?=
 =?utf-8?B?V1dkLzk3ZS9EMTNKdEpnelpWZ3VNU2h4d29pY2d0S1hsdHd2WHNVcmxyZ0Fo?=
 =?utf-8?B?NGVNWnc3L3IxZFJDYm5mYmdVdDVURStxeXVad1ZDYWdZZUhRYjhkT29mZjR3?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XQ/iFhaPrro2ExPkT9fRykO7BG6ZRwHe/fQKrG0C00uLaEEpYwq7Xly/jC2E1yhm3nV0oFEr6lCAFFKwhuIDloTlFzu9YFy+UEzdz52He3qI4awFE/b2mECq9S6tRtHBENtDGKeIR086HyrYVL6aoDar85UBVSxKLmxTMaO2KUDCJSHtqHpnqgxUbNOZcUMgRVuzGYIcG8kHq+o7DLzifSm/fk0dDhTu+l7Ub9OzvID5EImn43p3E4v4ScRRGsSiciydNmf+uz6hDoLEyaa7FytfJluDOPi34pRmUcTkBoOa46z50loybZ1ZDhcOy7iWUW76B6+GLPStLLYTELS1EuDnm4TGqHGXsX3DpBdRL3zYVDA5jeE/+7REyaCDpBrCuzUVOStDSWlqBTULLeQpD7abItTWaNiyWtnrODWPQi/CAD+DVLHg+XItIxteE9xldtC2b+RWF/MeJzH7IzCfzl+FC+zTaPo6O6gM+dBG3+loDm8RZ1uYkrONXogtZKve4PMWtkyaLckXzcTPLsmtXw3m7046uipZP9hoare30tcUEpMkHDAunEZwo9oEcZUrxuKUVSA5qK10IqERLpXKjjw/9kVyTpGTB6wOC7mvNYA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b268f66-3e1f-4a46-723e-08ddea384e11
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:49:30.6876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFO5tR2CkovFD2MN4quO37h5dwCWgWyXnuBfcEXFaM+Zmk1BPbWuS4nL9Exs+YXhvAH+VSjrpZA9AX0KhMG0VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020156
X-Proofpoint-GUID: qNbiwUJcP5QVBa5EWk3iLbBdZCSWju-R
X-Authority-Analysis: v=2.4 cv=I7xlRMgg c=1 sm=1 tr=0 ts=68b7120e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=r7tQGv_edBGYaOWREH8A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX+XWiWNwxHKsD
 Om+sL7oUexHey9Icl2HHDB+eHHxPJ51u57NYVK2wgTucQ+/k/HZZiKQPyP/ls1PqIPi6KdjqOnA
 pAwbGt76Ysw050bT5uhp4IVzShmTy7PulorowQWlg8/sUOf7FuCUOGi3lBa1oyRecnUkFRWChSJ
 PJThW/KUuv/a8HXZqnJm9dJ+d+KUUN5qEjC25LRx3UWMBpan6Gkk0i0aaeypZ2/F7reqH36oROk
 bw3cgiJA5utzs0sq91pMp2AV8W+v/WfhE0GNlNuBno4YtjpEstS9fvO4Ax0frD19BLTKBx1HSSq
 t6Q21RmEntjFSPyNuQ9+LdYdFevUinV5susAOnia652b2SWgcOgVlIM3pXmKO41rMOAOfiTBUgs
 LvNZMgQDD2cgYPQhez4mL+KMn2HkPw==
X-Proofpoint-ORIG-GUID: qNbiwUJcP5QVBa5EWk3iLbBdZCSWju-R

On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> This test is intended to ensure that multi blocks atomic writes
> maintain atomic guarantees across sudden FS shutdowns.
> 
> The way we work is that we lay out a file with random mix of written,
> unwritten and hole extents. Then we start performing atomic writes
> sequentially on the file while we parallely shutdown the FS. Then we
> note the last offset where the atomic write happened just before shut
> down and then make sure blocks around it either have completely old
> data or completely new data, ie the write was not torn during shutdown.
> 
> We repeat the same with completely written, completely unwritten and completely
> empty file to ensure these cases are not torn either.  Finally, we have a
> similar test for append atomic writes
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Please check comments, below, thanks!

> ---
>   tests/generic/1230     | 397 +++++++++++++++++++++++++++++++++++++++++
>   tests/generic/1230.out |   2 +
>   2 files changed, 399 insertions(+)
>   create mode 100755 tests/generic/1230
>   create mode 100644 tests/generic/1230.out
> 
> diff --git a/tests/generic/1230 b/tests/generic/1230
> new file mode 100755
> index 00000000..cff5adc0
> --- /dev/null
> +++ b/tests/generic/1230
> @@ -0,0 +1,397 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test No. 1230
> +#
> +# Test multi block atomic writes with sudden FS shutdowns to ensure
> +# the FS is not tearing the write operation
> +. ./common/preamble
> +. ./common/atomicwrites
> +_begin_fstest auto atomicwrites
> +
> +_require_scratch_write_atomic_multi_fsblock
> +_require_atomic_write_test_commands
> +_require_scratch_shutdown
> +_require_xfs_io_command "truncate"

is a similar fallocate test needed?

> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount >> $seqres.full
> +
> +testfile=$SCRATCH_MNT/testfile
> +touch $testfile
> +
> +awu_max=$(_get_atomic_write_unit_max $testfile)
> +blksz=$(_get_block_size $SCRATCH_MNT)
> +echo "Awu max: $awu_max" >> $seqres.full
> +
> +num_blocks=$((awu_max / blksz))
> +# keep initial value high for dry run. This will be
> +# tweaked in dry_run() based on device write speed.
> +filesize=$(( 10 * 1024 * 1024 * 1024 ))

could this cause some out-of-space issue? That's 10GB, right?

> +
> +_cleanup() {
> +	[ -n "$awloop_pid" ] && kill $awloop_pid &> /dev/null
> +	wait
> +}
> +
> +atomic_write_loop() {
> +	local off=0
> +	local size=$awu_max
> +	for ((i=0; i<$((filesize / $size )); i++)); do
> +		# Due to sudden shutdown this can produce errors so just
> +		# redirect them to seqres.full
> +		$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $size $off $size" >> /dev/null 2>>$seqres.full
> +		echo "Written to offset: $off" >> $tmp.aw
> +		off=$((off + $size))
> +	done
> +}
> +
> +# This test has the following flow:
> +# 1. Start doing sequential atomic writes in bg, upto $filesize

bg?

> +# 2. Sleep for 0.2s and shutdown the FS
> +# 3. kill the atomic write process
> +# 4. verify the writes were not torn
> +#
> +# We ideally want the shutdown to happen while an atomic write is ongoing
> +# but this gets tricky since faster devices can actually finish the whole
> +# atomic write loop before sleep 0.2s completes, resulting in the shutdown
> +# happening after the write loop which is not what we want. A simple solution
> +# to this is to increase $filesize so step 1 takes long enough but a big
> +# $filesize leads to create_mixed_mappings() taking very long, which is not
> +# ideal.
> +#
> +# Hence, use the dry_run function to figure out the rough device speed and set
> +# $filesize accordingly.
> +dry_run() {
> +	echo >> $seqres.full
> +	echo "# Estimating ideal filesize..." >> $seqres.full
> +	atomic_write_loop &
> +	awloop_pid=$!
> +
> +	local i=0
> +	# Wait for atleast first write to be recorded or 10s
> +	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
> +
> +	if [[ $i -gt 50 ]]
> +	then
> +		_fail "atomic write process took too long to start"
> +	fi
> +
> +	echo >> $seqres.full
> +	echo "# Shutting down filesystem while write is running" >> $seqres.full
> +	_scratch_shutdown
> +
> +	kill $awloop_pid 2>/dev/null  # the process might have finished already
> +	wait $awloop_pid
> +	unset $awloop_pid
> +
> +	bytes_written=$(tail -n 1 $tmp.aw | cut -d" " -f4)
> +	echo "# Bytes written in 0.2s: $bytes_written" >> $seqres.full
> +
> +	filesize=$((bytes_written * 3))
> +	echo "# Setting \$filesize=$filesize" >> $seqres.full
> +
> +	rm $tmp.aw
> +	sleep 0.5
> +
> +	_scratch_cycle_mount
> +
> +}
> +
> +create_mixed_mappings() {

Is this same as patch 08/12?

> +	local file=$1
> +	local size_bytes=$2
> +
> +	echo "# Filling file $file with alternate mappings till size $size_bytes" >> $seqres.full
> +	#Fill the file with alternate written and unwritten blocks
> +	local off=0
> +	local operations=("W" "U")
> +
> +	for ((i=0; i<$((size_bytes / blksz )); i++)); do
> +		index=$(($i % ${#operations[@]}))
> +		map="${operations[$index]}"
> +
> +		case "$map" in
> +		    "W")
> +			$XFS_IO_PROG -fc "pwrite -b $blksz $off $blksz" $file  >> /dev/null

does this just write random data? I don't see any pattern being set.

> +			;;
> +		    "U")
> +			$XFS_IO_PROG -fc "falloc $off $blksz" $file >> /dev/null
> +			;;
> +		esac
> +		off=$((off + blksz))
> +	done
> +
> +	sync $file
> +}
> +
> +populate_expected_data() {
> +	# create a dummy file with expected old data for different cases
> +	create_mixed_mappings $testfile.exp_old_mixed $awu_max
> +	expected_data_old_mixed=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_mixed)
> +
> +	$XFS_IO_PROG -fc "falloc 0 $awu_max" $testfile.exp_old_zeroes >> $seqres.full
> +	expected_data_old_zeroes=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_zeroes)
> +
> +	$XFS_IO_PROG -fc "pwrite -b $awu_max 0 $awu_max" $testfile.exp_old_mapped >> $seqres.full
> +	expected_data_old_mapped=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_mapped)
> +
> +	# create a dummy file with expected new data
> +	$XFS_IO_PROG -fc "pwrite -S 0x61 -b $awu_max 0 $awu_max" $testfile.exp_new >> $seqres.full
> +	expected_data_new=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_new)
> +}
> +
> +verify_data_blocks() {
> +	local verify_start=$1
> +	local verify_end=$2
> +	local expected_data_old="$3"
> +	local expected_data_new="$4"
> +
> +	echo >> $seqres.full
> +	echo "# Checking data integrity from $verify_start to $verify_end" >> $seqres.full
> +
> +	# After an atomic write, for every chunk we ensure that the underlying
> +	# data is either the old data or new data as writes shouldn't get torn.
> +	local off=$verify_start
> +	while [[ "$off" -lt "$verify_end" ]]
> +	do
> +		#actual_data=$(xxd -s $off -l $awu_max -p $testfile)
> +		actual_data=$(od -An -t x1 -j $off -N $awu_max $testfile)
> +		if [[ "$actual_data" != "$expected_data_new" ]] && [[ "$actual_data" != "$expected_data_old" ]]
> +		then
> +			echo "Checksum match failed at off: $off size: $awu_max"
> +			echo "Expected contents: (Either of the 2 below):"
> +			echo
> +			echo "Expected old: "
> +			echo "$expected_data_old"


it would be nice if this was deterministic - see comment in 
create_mixed_mappings

> +			echo
> +			echo "Expected new: "
> +			echo "$expected_data_new"

nit: I am not sure what is meant by "expected". I would just have "new 
data". We don't know what to expect, as it could be old or new, right?

> +			echo
> +			echo "Actual contents: "
> +			echo "$actual_data"
> +
> +			_fail
> +		fi
> +		echo -n "Check at offset $off suceeded! " >> $seqres.full
> +		if [[ "$actual_data" == "$expected_data_new" ]]
> +		then
> +			echo "matched new" >> $seqres.full
> +		elif [[ "$actual_data" == "$expected_data_old" ]]
> +		then
> +			echo "matched old" >> $seqres.full
> +		fi
> +		off=$(( off + awu_max ))
> +	done
> +}
> +
> +# test data integrity for file by shutting down in between atomic writes
> +test_data_integrity() {
> +	echo >> $seqres.full
> +	echo "# Writing atomically to file in background" >> $seqres.full
> +	atomic_write_loop &
> +	awloop_pid=$!
> +

from here ...

> +	local i=0
> +	# Wait for atleast first write to be recorded or 10s
> +	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
> +
> +	if [[ $i -gt 50 ]]
> +	then
> +		_fail "atomic write process took too long to start"
> +	fi
> +
> +	echo >> $seqres.full
> +	echo "# Shutting down filesystem while write is running" >> $seqres.full
> +	_scratch_shutdown
> +
> +	kill $awloop_pid 2>/dev/null  # the process might have finished already
> +	wait $awloop_pid
> +	unset $awloop_pid

... to here looks similar in many functions. Can we factor it out?

> +
> +	last_offset=$(tail -n 1 $tmp.aw | cut -d" " -f4)
> +	if [[ -z $last_offset ]]
> +	then
> +		last_offset=0
> +	fi
> +
> +	echo >> $seqres.full
> +	echo "# Last offset of atomic write: $last_offset" >> $seqres.full
> +
> +	rm $tmp.aw
> +	sleep 0.5
> +
> +	_scratch_cycle_mount
> +
> +	# we want to verify all blocks around which the shutdown happended
> +	verify_start=$(( last_offset - (awu_max * 5)))
> +	if [[ $verify_start < 0 ]]
> +	then
> +		verify_start=0
> +	fi
> +
> +	verify_end=$(( last_offset + (awu_max * 5)))
> +	if [[ "$verify_end" -gt "$filesize" ]]
> +	then
> +		verify_end=$filesize
> +	fi
> +}
> +
> +# test data integrity for file wiht written and unwritten mappings

with

> +test_data_integrity_mixed() {
> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Creating testfile with mixed mappings" >> $seqres.full
> +	create_mixed_mappings $testfile $filesize
> +
> +	test_data_integrity
> +
> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_mixed" "$expected_data_new"
> +}
> +
> +# test data integrity for file with completely written mappings
> +test_data_integrity_writ() {

please spell "writ" out fully, which I think should be "written"

> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Creating testfile with fully written mapping" >> $seqres.full
> +	$XFS_IO_PROG -c "pwrite -b $filesize 0 $filesize" $testfile >> $seqres.full
> +	sync $testfile
> +
> +	test_data_integrity
> +
> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_mapped" "$expected_data_new"
> +}
> +
> +# test data integrity for file with completely unwritten mappings
> +test_data_integrity_unwrit() {

same as above

> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Creating testfile with fully unwritten mappings" >> $seqres.full
> +	$XFS_IO_PROG -c "falloc 0 $filesize" $testfile >> $seqres.full
> +	sync $testfile
> +
> +	test_data_integrity
> +
> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
> +}
> +
> +# test data integrity for file with no mappings
> +test_data_integrity_hole() {
> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Creating testfile with no mappings" >> $seqres.full
> +	$XFS_IO_PROG -c "truncate $filesize" $testfile >> $seqres.full
> +	sync $testfile
> +
> +	test_data_integrity
> +
> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
> +}
> +
> +test_filesize_integrity() {
> +	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Performing extending atomic writes over file in background" >> $seqres.full
> +	atomic_write_loop &
> +	awloop_pid=$!
> +
> +	local i=0
> +	# Wait for atleast first write to be recorded or 10s
> +	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
> +
> +	if [[ $i -gt 50 ]]
> +	then
> +		_fail "atomic write process took too long to start"
> +	fi
> +
> +	echo >> $seqres.full
> +	echo "# Shutting down filesystem while write is running" >> $seqres.full
> +	_scratch_shutdown
> +
> +	kill $awloop_pid 2>/dev/null  # the process might have finished already
> +	wait $awloop_pid
> +	unset $awloop_pid
> +
> +	local last_offset=$(tail -n 1 $tmp.aw | cut -d" " -f4)
> +	if [[ -z $last_offset ]]
> +	then
> +		last_offset=0
> +	fi
> +
> +	echo >> $seqres.full
> +	echo "# Last offset of atomic write: $last_offset" >> $seqres.full
> +	rm $tmp.aw
> +	sleep 0.5
> +
> +	_scratch_cycle_mount
> +	local filesize=$(_get_filesize $testfile)
> +	echo >> $seqres.full
> +	echo "# Filesize after shutdown: $filesize" >> $seqres.full
> +
> +	# To confirm that the write went atomically, we check:
> +	# 1. The last block should be a multiple of awu_max
> +	# 2. The last block should be the completely new data
> +
> +	if (( $filesize % $awu_max ))
> +	then
> +		echo "Filesize after shutdown ($filesize) not a multiple of atomic write unit ($awu_max)"
> +	fi
> +
> +	verify_start=$(( filesize - (awu_max * 5)))
> +	if [[ $verify_start < 0 ]]
> +	then
> +		verify_start=0
> +	fi
> +
> +	local verify_end=$filesize
> +
> +	# Here the blocks should always match new data hence, for simplicity of
> +	# code, just corrupt the $expected_data_old buffer so it never matches
> +	local expected_data_old="POISON"
> +	verify_data_blocks $verify_start $verify_end "$expected_data_old" "$expected_data_new"
> +}
> +
> +$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> +
> +dry_run
> +
> +echo >> $seqres.full
> +echo "# Populating expected data buffers" >> $seqres.full
> +populate_expected_data
> +
> +# Loop 20 times to shake out any races due to shutdown
> +for ((iter=0; iter<20; iter++))
> +do
> +	echo >> $seqres.full
> +	echo "------ Iteration $iter ------" >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Starting data integrity test for atomic writes over mixed mapping" >> $seqres.full
> +	test_data_integrity_mixed
> +
> +	echo >> $seqres.full
> +	echo "# Starting data integrity test for atomic writes over fully written mapping" >> $seqres.full
> +	test_data_integrity_writ
> +
> +	echo >> $seqres.full
> +	echo "# Starting data integrity test for atomic writes over fully unwritten mapping" >> $seqres.full
> +	test_data_integrity_unwrit
> +
> +	echo >> $seqres.full
> +	echo "# Starting data integrity test for atomic writes over holes" >> $seqres.full
> +	test_data_integrity_hole
> +
> +	echo >> $seqres.full
> +	echo "# Starting filesize integrity test for atomic writes" >> $seqres.full

what does "Starting filesize integrity test" mean?

> +	test_filesize_integrity
> +done
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/1230.out b/tests/generic/1230.out
> new file mode 100644
> index 00000000..d01f54ea
> --- /dev/null
> +++ b/tests/generic/1230.out
> @@ -0,0 +1,2 @@
> +QA output created by 1230
> +Silence is golden


