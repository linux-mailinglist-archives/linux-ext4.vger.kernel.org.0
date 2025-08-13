Return-Path: <linux-ext4+bounces-9360-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A465B24AE1
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 15:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F2068171C
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 13:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624E52EA72D;
	Wed, 13 Aug 2025 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TUcZBQwm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BSJ8p+gS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EC92E7F39;
	Wed, 13 Aug 2025 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092544; cv=fail; b=Rlv5To3RPlppEp0TkKshpepHolNEkQKwIt8y5plgYFvemsQPOUTiIeNP7BZnuDabBxhxUmIVDqfi5sPia1c5FBBUszPjHrZiTMJFbt5Saj4ZKlokyo1Uedc324VvbL7Ejb9fKrSb3VJmaeXGt0QCaGso3E3WkbFi5HflOM1/Foo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092544; c=relaxed/simple;
	bh=FNvx7qvn79lbd+9NFIplhnSyHzxBq9XlEAMTdD/N3MY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lnlydGFF3ZR6G3m6Q0T5V5Dn42zYln+JzFkvg914DrsMKI67rclW+ydG7DktnLpX+K0zap/IVUvxKYxW6QcALoNIiAptCgGVXN7S4TPxRgN3Q1KllZOnT8OOb05BKMY9dK6yQ7P5BNNhhlfXwo3jXnmcK3EnZqzjRJf0F1fj9p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TUcZBQwm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BSJ8p+gS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDN9N9027080;
	Wed, 13 Aug 2025 13:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Pq++vjdKhKPMIS0I/T3wLBVUMyUlBdDPv4aQIbEBhUk=; b=
	TUcZBQwmLBnhe3wPwLS1rcO0SaFF8sVBZ15PAuqERI7l7m0quxBnL0BYiznftwO1
	fi0xFVZ9cuhSjdjCAE3ZlVhS8H7ZMY0qjRQa4B8oH10eJJaqdu+YSs/HPpXlqGHJ
	TZBkUUb7uaN4T5mgYm18MqFZ/u+muttGIw89HYR9FRshFZ3rLEdXbqIVOJtWzH6X
	Bqk9IapOqqOJS4RZo9ujNPerabE/1NPcDWztRqF9btkwZdB1Ks6Z+Wet+dXN4WwB
	+P9CoKnZ52a48WOYcFve5ojtDl1DzLZjKFcehtnl04Z1AXiFE8IICZCxkpnpUv4t
	NV5FDezjpS1Pr6ETgfweIg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf7ngc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 13:42:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DD5gd2009843;
	Wed, 13 Aug 2025 13:42:14 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvshr09k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 13:42:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVxzDttBxqchSubxFC8JdiliPGZHE89lXGCcAKXfX0vA70dI2tQGzMMchV/lXVbvmX8KQAi0bu8lFGHZbhIMAjVGQvWbwIIUStw45DMw58/hYRjT2X1x1FPFPSSVYMzsaIXD9aen+ywn17w8TxTR5E9ht6zULrcjXBgjJ2B3d2x2aeyGe88CjTD1UVDPf1VUGSuqPT9bBm3KVMWeI9uelaVqLk+OTs+K/z8RPY8FO32SFGavriYMtDzrfFjsBc8UxfB0gu6hC0kZsx/guf98BK5X/RCwdypqFNpbQqN55dQV5ZsGhrN7zUR8+AzGU04JE7mfsP883/6bne2w/siNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pq++vjdKhKPMIS0I/T3wLBVUMyUlBdDPv4aQIbEBhUk=;
 b=wPu4CgW9MhwW8twtXq6JCTN0gNxlIjBTpuYJ+5sKXAjdpqmGGzyerXuYRUieQOua1/ddunvCiHEqXQGgkU6UrvV/9Jhh9JRN4DY6FNmeeLMeCD2yxSXSlHFDmeeAoYuwUXtXZCJ+JW86pjuOJeh9VGoVWcICEqGQyDCql266Mkn/lo0ykQ5atNlNtikov7XN+m2shd8INXwC7U40/bI91B2RWqIfCTEqioNuV+76ajFL/rlmBkvlDadlhAlc0rZiJK56A02CL+9Ubp69pCfrEt6HD+J1kbDdN+vWE2jr+tyR2X8O/1YV2GkxeyMUK35ezsmPjtfgnTXGdcfkXIekqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pq++vjdKhKPMIS0I/T3wLBVUMyUlBdDPv4aQIbEBhUk=;
 b=BSJ8p+gSKP9XfXlLlBnAnFTGNPPMaCOEnUseUEJ08R31TiqiZjm4pDvYijb9LLrXOYXEirSd1ysLBi6jR+SQ+/xSpsGBy0j+qo0vjmCt8IWbsAcaD4mcAtR2gJ6VljEq46PPY9aCByjSnX8iktIJoLmnTEJvGdVIqBjs3gb81/4=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 13:42:11 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 13:42:11 +0000
Message-ID: <6cf3dc1e-919d-42b1-a8c0-cfd9bb158966@oracle.com>
Date: Wed, 13 Aug 2025 14:42:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] ltp/fsx.c: Add atomic writes support to fsx
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <8b3c42eb321b4a1a4850b7e76d53191cb20ffa41.1754833177.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8b3c42eb321b4a1a4850b7e76d53191cb20ffa41.1754833177.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0643.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::10) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH0PR10MB4876:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fc4ee0-3e2b-405d-a0d7-08ddda6f349e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2VUK016S1RtcGZrOVBKSWlYNW9SMHhtM1laa0s3b1NYcmZzYUQ2NnhSZStX?=
 =?utf-8?B?VnByaHVpNXpYaklTRTVzU0tNalhscXRxYmFTYStiUVQ1WjU4MWlSL0lpZWJ4?=
 =?utf-8?B?UmVHMC9zUmhVN1hzc0o5bm5RQUpMeGV4SnYvNndhRzgyc3I1cmR1N1o3MnRE?=
 =?utf-8?B?NmxpdnF2M1M2ODZvRUZCV2lnbWJrR3pmeWlNb050Qk1TS2MxQkdOWmo4OGQ1?=
 =?utf-8?B?WUZXL1VPVXRwcnJWNzFmNHlvQllvajh6T3dhVmJLa05tZGU2dlU4Y1lUc3hR?=
 =?utf-8?B?dEFwQTMvZjIzOXZsQklDeEJzMGRORlFuellmSGxjc0c1NHBhaDlFR0VHRmdJ?=
 =?utf-8?B?WEMrVlZUSFNqaVAzalRhcnR3RDc2WDJDUFBjd1dyZncwRS9SV09YTEU2R3F6?=
 =?utf-8?B?cFgzc1c1R3ZUby96eEw3VVEwUVBFWk4vY3RiYS9mRFN1YzF1bkk2akRCdXdm?=
 =?utf-8?B?WnZQKzVzNWNpZW5zZDBtR1pxWDJ3eUo2bDZGeVl6OVZ3UUtyMktIOVdEVmlW?=
 =?utf-8?B?azVFSGFJdWtWM0RKMmZ0QmVhbWV4Nzl2cEdNM1A1UVUyNEhhbE96M1NiT2pj?=
 =?utf-8?B?VEZuWjd1bFJLV090dXY1MFBQK0VTL0RvbXpWN0VXd2hhWSswMnNFLzJLN3Ex?=
 =?utf-8?B?QnlIWFZzQ0VJSGozKytKVkFoeENXaTJzWHpqT2hHa1ZkbFprZjhzYlF4OUk5?=
 =?utf-8?B?OHFuSG5MbUNzNk41ZjFibTZXZmlvYkg3eVFWVng1dXprRjhuZFVTdmMreDRu?=
 =?utf-8?B?MFBHOWFtc2p1b21NQm5oV1JTZFhJUkxDbjN5VGptbGtGVkdDQm1TRHM2T2NJ?=
 =?utf-8?B?emQrK3BFemFJajJabGgyd0Z4U2c0UnVpb0VIdGZpSVNXb0xveGhBNytaVzZ2?=
 =?utf-8?B?M0ZNbFZkcUlTei85YU1uNjh2cnhyNytvV3FjMWVRU1Z5MStjNDd0S2gvSE1y?=
 =?utf-8?B?RGF3c0p6a0svQXorUWtqK0VvU1cvS0FiTEZxanBSaXlTRCtIQjk0Z04vYThw?=
 =?utf-8?B?NEUzV0JIaXp6MXRuODMzbng0WGR2dFVNL3o5czAwTUovZkFtc3FGdHdDSk4v?=
 =?utf-8?B?NmxkWHEwVW13Y0wxQUV2SS8vbFN5b0pYL0VlaFZIcjJaSGNxVVRpMWtYWXAr?=
 =?utf-8?B?Ym5HbERabGdXOFVlT0JVUXdUbmxSeEdoZDFFVHk4bkRZOEZKOUNNM2xsTGVz?=
 =?utf-8?B?VnNYMFRYR2NZT1N4SXlFY25sQ0NRNjJBYmdSamtkeDMrays5S3V2OWdsUVo0?=
 =?utf-8?B?QXNTaTdWdlBXZ21DTWM5L0poWnpNWFVTbGRyVG4wK2pUSmNVajZzTFJ0U2JQ?=
 =?utf-8?B?OW1TTDEranRtSkRGNWQvREtNRFMxWUtrQTNMT1pLaUVPRHI1bXZIVU1hUGdB?=
 =?utf-8?B?eFo2WXRVZDlZSC9kSXpWS0VCejYyWHNJNUJ1YlMzVDFwKzR5QjhSdHI0eXVT?=
 =?utf-8?B?TDM3cDIyTE1OZVRPelR3SDVLR3ovSUtoUU93bks0WEQ2UVNuVlVycnNiejk4?=
 =?utf-8?B?cnVZRXE2SzUwdi9tMmdHOTY4OVZMRkNKVll1YWp3VExOcjN5c3VPaHpTT0NF?=
 =?utf-8?B?ZGRMRDZKOHlrd2hSelVlRzM1NHgzTW5zSnlkMWZxaVVaa05vdmxhRU83Y1Z6?=
 =?utf-8?B?SXppMU5qRGJrTWcva3RmQWp3U3ArZ0lNZTVhV2ZzSGpmcUc5enQ5cythRWlC?=
 =?utf-8?B?bGsraG4wN1E0dS9EcVpDVjVYc1U0bW5MckFvckhsMEJqQkVnYk1vVWVjekJ0?=
 =?utf-8?B?T2t4MVBNNm5ycGZURkJxRXpwOVdaMDZ0bGNQdjY1bkZ6UDhuV1ZnZTFPTlNC?=
 =?utf-8?B?MDc3Rk5RTWFOWGRQUmNON0I1Q2FJaWp1VXMrUHRuaFVRMFlZNHhrRGNVbUgw?=
 =?utf-8?B?L1FUZEEwMTZsYjY4T1VHNUkvWUZPaDBxdTk5VlY1UVU4eFFrN2E2R1lDcmVo?=
 =?utf-8?Q?vxrV7J/+OXo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGFTS2R6ZTJON0lUWVJabnVhOFRmRmdFV2FvVm1HWklaKzlzWXcvMnlvZTJj?=
 =?utf-8?B?UGtEbWU0OE41dEpkbHlQL3YxRzlPRzk2NkNwNThCdlRDTk1mUkxXcUhpakJK?=
 =?utf-8?B?dnlkZ24rUWpoQ1QrT2JVNTA2QXc2VUhKd1JNZHNRSnVvZDFkMkFQSHlvOEgw?=
 =?utf-8?B?MUYyenVtWVVuL3Z4ejB5YXl6UEVIOE55TmJrL1RlSGVRM0piNjZPV2ZFb2Zm?=
 =?utf-8?B?QnRCUnB5TXNlMDloZGRONVNXNnRvSyt0VEx5ekwzYko3LzBmR3BPakdBbmlz?=
 =?utf-8?B?OHJPK3Z1WUNlcmx5RkhBc005Q2g2dndDR1grdzQ0ajlCOEV2ME1HRDZRQTEv?=
 =?utf-8?B?RGF1TUZ6VDhkYUJ1Ly9SQk1NTm81NG9obWhWdVIwUnhPb0Q0NEI4cnRBdXZJ?=
 =?utf-8?B?ZmtnZmJrMVkyMnZPN1E5SmJtK3lPclZidzFROC94SlRFdDIxM2ZHTWR6WjU0?=
 =?utf-8?B?MXBHSHNjUDFrOGpQa2dJUFduZlJnU3ZJdERkK01JTWY5ZG5UQ24rMEJkcXd4?=
 =?utf-8?B?b3RMa1kxOU1iamxKb1lWZTdCMGNXL2V3NUs2RmluMTJ2dm5zTlZ2VVBPRjZF?=
 =?utf-8?B?YlI4bkN5NTQ3RVhoMnZvZUpHWkJhb0QxcCtYWkdFdG45Szk4QTM2NjdLWW1v?=
 =?utf-8?B?TVdDWVNUWU44bFRVMmYvOGhFSytObktkOUVWUFZlRWoxbG1IWVVTWXVOM29E?=
 =?utf-8?B?U3hlL244MFhOVHhkUEJPbWJFMmV3MGVuV1NXZXB2c3EvT1N5ZjM0OTloRzNJ?=
 =?utf-8?B?N1QzeElqbUNVaUJPZnNVdWJMa1YzSzRrTmxCMlRNcnY0SkhZSzdDcTlXTE5T?=
 =?utf-8?B?WUtpQUVlamRXOEd4eWZpc08waGxuckdncWZtMjU0SEtiZHl5V3FiU2RHUWdn?=
 =?utf-8?B?U3lyQmJZZmpBYkRpTVNTb1RmTTJLdFZIUHBacXVVMS9TYmZvUVhadUZHOHh5?=
 =?utf-8?B?MlVKdzNGcy91M3BlRVQwQ1IrWG1tRTE5ZnNrUGdTNlZaYUxKV2pTaVB2cE5F?=
 =?utf-8?B?UHM0L0ZZTWxjVEI5L1QwWno5L0NBNHBiajVMU29zSUo3dGk4T1orZElGTVNZ?=
 =?utf-8?B?RkF1THZVcTlBbllZNXRPTWpwTnBlWDlDNURNa0hwdy9jbWEyRHFSM2ZvR2JC?=
 =?utf-8?B?eFFZR3hJcWRKZlBZemZQRXNUbit3Q04wVnFvSjh6VjdnUzJFWlZyZjk2UGk5?=
 =?utf-8?B?RFNzNGxFUEs2VnhIcG9kV2ZtcEE1Rmk5R050aE1XV2lmTDRWcDc3aWFvd0Ew?=
 =?utf-8?B?VVB3YXVLOVN4ZXBXWnM5NHBDYzVFZE1GOC9mOGZ2bVVpY0UxOGtnKzAvRDVy?=
 =?utf-8?B?RlU2LzdxNmpLQXdSWXp4OERiSVpJTHFhVmpuTlRwckRTNVFkcVpKbXpEWnlM?=
 =?utf-8?B?b2dURm11K3owRUxiOHJwUVFFakFVOTQ3QzZXMjh4N05yWkVOL0h5bkptT3Zk?=
 =?utf-8?B?a3NxTGUwUkd5WTJVR0NRYU00aWNGUnU3TVhUdUx1Qm5MWTV5VDAwMmFUVDJK?=
 =?utf-8?B?dnBJQlZJYy9NdTA1N2FJOEU1NHdRMnYzbzlYckQ5SnpCZ3UvRkF2MGJoOS9z?=
 =?utf-8?B?Ry9GY3oxVndvMENWazJ0b3UrRldNUEdFeDlHcGZETjR1cmtGUU1PZ09hK3A3?=
 =?utf-8?B?bThkMDNmR1ZIN05IRnBWM0RKQStSdytxNUZmUlRmeUgyVVhsUitLMUR4bHFx?=
 =?utf-8?B?K3VkNHpjWjlEeWoxNEV2ZzRIcjJiNENVeld5dlRTMVRJNWxRb1U4YzJJWTk4?=
 =?utf-8?B?cDl2YkRpQTk0bi9rS2MrbzNRaU4wdGR1QWtpNHFmS2VwSHd4RkMrdjduOTJ3?=
 =?utf-8?B?NTB1bnBKZURYQW5yZDQxUXBRbklBaktDb29KN3VndFArSmlMRUVJSmlGVi96?=
 =?utf-8?B?aXphTjlJNVdQWVpwN2hIMUc4Q3YwOVpUNDYweTU0eFh2M1dWdlVoNmQvV2FJ?=
 =?utf-8?B?RzhCK0EycUpyVTY2cmpzbEx3eHhQcmoyVE9WR0l3dTFVNEtCVEVUd2RxVlh1?=
 =?utf-8?B?Y1RZQ2FlQ0pLWWhlNGNoZEcyb1lscGhNcUJKcThhSXNpRXhaMmkxSFNEVmlU?=
 =?utf-8?B?OVhwZzVsSGd0WVVMNnRuY0tCbHpCN0lkR2Rma2RkeTJpMU1GOGZUYnpIT1Iz?=
 =?utf-8?B?MGhTTVB5L3Y1SDM1V2RKaithcmNIeVYxMXVwWmtGZ2VpSWJGV2hlUzFHd01x?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6YPETNCHjZeIL3YdZJy3x862OKgLGb1hVLlQvtjlkrl71sQqTGmmyX5XXU7H4IAUT9VEuNj5r1keBDC7HXFkPIUrPXGTguN32VEouHUkiIkvRtzBYQ9ecvaYcOFoMPvyWdSdW0EVTTMUbNs+JGZkHJGA//kIex7+f/0PLnryeKnK+VM17aHMiXtoavw0HP9zPsVZD0JeZncV9CH5JP0yA32ZkFy9pzcnEaVaIgqC/wSseBskjPngypdn8VpTSW0fYpWUmAk394j9g+XU2wSMt9ZGEFfyAAwIGCUADjNVfRBPE+i90Uki3h+VXafHBKEcoNERXFoQ3rOyHZXzEi/xzTLCJO8voUoKQFeKj796n5s/C/coKc/1SnRynButaSgmz0gbu47Ux8k+ZpQcQz0aEI0aC6TQo6447srBUPsaxOGo6/8zixd9nP+LaiPWD6WxqYLvIEX3xGWweX9Y1G/G3Q18nnqUVPZFKBVAUxq03eB9mHz7EzQq0X5Z98NjO8PUP/4mPa9mLjbABoHx2oBeCC40vsxzNX601AxC4aF085AUJxrsy/ematbIf06eUZ6wcxWNUFDLUVUYtQ4NZzM3a9gJN03p9lLAt2IjmyGArBY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fc4ee0-3e2b-405d-a0d7-08ddda6f349e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 13:42:11.7232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXCd46W4rle0iQuNBpAoaDuSjI7B3+sZKDAq5lC7E+Yms1NAozd369TFNTzd70Z5/6LQzTrWa683vzggcUyKyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130128
X-Proofpoint-GUID: OwmQB1FMrR7FHkTMxXT-3K65pmAHz_pM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDEyOCBTYWx0ZWRfXwkB9mBch7vLJ
 mNqBJE8qrA6PNZWeepAH5jXzkAG80cmsoiYhUOzy8uRcQaokq3ZWzqkz7/me1rp/4N13NvyYb0V
 o7evDIOpe56OlUY0NzJJgBfyEgLd3w4Vqa0dyz00t2EylB2YR66r40CO8mBdavavxzFS22mlrC+
 b7cqyHQwYEk+h0C5wjLnTol2+O18lDqmws2epOJVxeylJC5+fvwpbXDuBd/ZiOe6be4AarMfDk7
 jzLAlvXQqxefBoIRHZsKYCzOFJPriQqgi/4o9t45IAz0fVJ4OcMVwe8TIm6JcxO8yp7Hn84eaex
 uZb8wxyFUSdQdmJs8szavZbJtPY5iZv02plB7EGQzyZfGjemPdufYgfPAx8CejDvkoV4MXp+6xd
 nEOLtpPv15uJnfMuEXzdQ1KrTpmfPCXsfOFcwxlGalWEWH33wyHARrQ6lEE2oHzry2GkZ9hB
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689c9636 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Hz_p6sQif8oXHBl3mh0A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12069
X-Proofpoint-ORIG-GUID: OwmQB1FMrR7FHkTMxXT-3K65pmAHz_pM

On 10/08/2025 14:41, Ojaswin Mujoo wrote:
> Implement atomic write support to help fuzz atomic writes
> with fsx.
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

this looks ok, but I am not familiar with fsx.

BTW, you guarantee O_DIRECT with RWF_ATOMIC only, right?

Thanks,
John

> ---
>   ltp/fsx.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 104 insertions(+), 5 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 163b9453..ea39ca29 100644
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
> +		if (size < awu_min)
> +			size = awu_min;
> +		if (size > awu_max)
> +			size = awu_max;
> +
> +		/* atomic writes need power-of-2 sizes */
> +		size = rounddown_pow_of_2(size);
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
>   	iret = fsxwrite(fd, good_buf + offset, size, offset, flags);
>   	if (iret != size) {
>   		if (iret == -1)
> @@ -1785,6 +1842,30 @@ do_dedupe_range(unsigned offset, unsigned length, unsigned dest)
>   }
>   #endif
>   
> +int test_atomic_writes(void) {
> +	int ret;
> +	struct statx stx;
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
> +	return 0;
> +}
> +
>   #ifdef HAVE_COPY_FILE_RANGE
>   int
>   test_copy_range(void)
> @@ -2356,6 +2437,12 @@ have_op:
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
> @@ -2385,6 +2472,11 @@ have_op:
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
> @@ -2511,13 +2603,14 @@ void
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
> @@ -3059,9 +3152,13 @@ main(int argc, char **argv)
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
> +			break;
>   		case 'b':
>   			simulatedopcount = getnum(optarg, &endp);
>   			if (!quiet)
> @@ -3475,6 +3572,8 @@ main(int argc, char **argv)
>   		exchange_range_calls = test_exchange_range();
>   	if (dontcache_io)
>   		dontcache_io = test_dontcache_io();
> +	if (do_atomic_writes)
> +		do_atomic_writes = test_atomic_writes();
>   
>   	while (keep_running())
>   		if (!test())


