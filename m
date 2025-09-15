Return-Path: <linux-ext4+bounces-10043-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB610B57CEF
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 15:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C532036D1
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 13:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822A831326C;
	Mon, 15 Sep 2025 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hLqdrH9U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DCxVw0f7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4197E2C027C;
	Mon, 15 Sep 2025 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942826; cv=fail; b=Gbaddeum5vsY8W9P9mJI+93T6ycQD9xBvpZqaTQjD+hlN5qbxdvffBoF2IMYY2iOWNCyJBM/1XYpW1ZzixE0JUrBfttx+lpjDlw43uF1SZPhiuMOTxbftv6jGV0lmE8pvWAmu6uw7sKENeIBlJ6LpBWI9xv0OFZtWoOSOMJmtsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942826; c=relaxed/simple;
	bh=cckhWnOdO0zzPOD/I7G45tIAf8Qg1W81iFv+AzS+Ee4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vo5kyGxZOTH+x/DU7S3c6Df6OpkAyFsEE8hpqrk5e8yWHryhk3MO5rnHuXM0Dlla67dvoiiZwdTkdampKk84UB/urA7mvYAjH/sK4Z61aT/DQSJmhdhFRkTYXA5WE+DGLI0Tm3lNDF9bLxvKc0HIASCdRvkmOtcw2ARxMHHSwm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hLqdrH9U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DCxVw0f7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FDBsnR005153;
	Mon, 15 Sep 2025 13:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dHmuXWe3JNMCwUWhVfUAE/7YAQNgahQhTWwuCr31tA8=; b=
	hLqdrH9UkSmPmZo+P6x0pKME3J+XPj3/dXiuRoY1RzEb4aftBfNU5V+fGpG4l87j
	bHyczw8ykMHgndUrFTO09vC1Cz4tW4vZZUrOjxapSm3ZJh9uatiKX+t6TQ4lP9y2
	HRVbTbfXu+TTjmUaajqnYP6D+WNnOtxihyMxlPChKR6ZjQzuIdw5Lm5b41VrPUM4
	leF+FSMaiaKrkaInnaJzC5Cr9KgWW1MypTA+B1aRCIsZhfzSW5daayEURPvZUAcb
	jNivyAL5vbXBRULmRkrfqvIKQVDawAgudA2WvjTYMy/cTgFES2kjYlmxlWJA54zF
	K8HsM+MiNgvAaKLxs/sZnQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494yhd2duq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 13:26:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FCdHCm015411;
	Mon, 15 Sep 2025 13:26:52 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b1ytr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 13:26:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1/lxEvDhiVs1jakcL3Dr+dh6NEly2Kn/lankK7p/96SXHSPyLAFNMesA0qNRS1o+Elx8yyU0Kr+s0cN4yqbgDkWFUUip7p+gkjB0gox8FUCwS3QWN9cJ4vcg8rboQJJSuWjWV0AzDUEb9sBCG/cZGyU0h6iLFCDyc+h8bjapQ6YLb/clQTkJK6K98CjJRqWybEQje/rtzGPsFFxL/gCFu1aWLTxgrdMV5i6za3iJQZmO/7xHExXsRUpyfQP0beA0T9qGpYh8Mp3xY5T7eQlLfQ0l5KiabnCVaFK61+bcVxf8cdpL9S+k7OtvV42wC41+jlQA9/aizRcmsRBbU+cNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHmuXWe3JNMCwUWhVfUAE/7YAQNgahQhTWwuCr31tA8=;
 b=xIkvLN1l+tl7Zd1w+fOWAwv7ZCTFwh3PFmqkayH1a/twMNN1kpMpRLhipYBtOdEeGTCMXlMZhIRBKejxOWp6iJYftA2pIqj6oFGuODkb+QfYCQRx5l2MoqVHh8zsJlH19cbQv9iLSO5aVm5Jz48uQAMXmFqYao3EjtvWthUQ78rZoJkRWUKs0n5YwPG84SGzzt0/ZpWVuDqUf5SrYhmi8SAvFEgWeG5SWbTkmpbDs83+Kfag5qjBrwLJ5v0R0zcKEATFSJoJfMqrrViOZFTJMsCDszqdQZdCStrD//QRYtuf7PyfsVupWFEXm+64KQ9dU1I64vBsrtv2uOJbE2uovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHmuXWe3JNMCwUWhVfUAE/7YAQNgahQhTWwuCr31tA8=;
 b=DCxVw0f7rmz/fQ8LpnJ20jaNR2ZHU1nohVo8g9sHiNzHRSmLJpUhjCy4yByhjodBLmj4RhCrEeY2B5GYQ6wymaRpTSOxXaZY7r/Nj7ymelR5OTnL48ofxMQS39gDvlI1gDQbehbE2rfMn40KhF5k/oUeqSC5iH7U2KbD4LIPVuo=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ5PPF7A7588508.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7aa) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 13:26:49 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 13:26:49 +0000
Message-ID: <58214139-2e42-4480-a7c3-443dd931fd09@oracle.com>
Date: Mon, 15 Sep 2025 14:26:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/12] generic: Add sudden shutdown tests for multi
 block atomic writes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1757610403.git.ojaswin@linux.ibm.com>
 <25f77aa7ac816e48b5921601e3cf10445db1f36b.1757610403.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <25f77aa7ac816e48b5921601e3cf10445db1f36b.1757610403.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::28) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ5PPF7A7588508:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f929c3-e91f-4cae-b48c-08ddf45b866c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0gxNWJRZWdFaXowcVlGVTJLbFJwTTdRNU1SUFpIWmxNaWhQTlJ3a2xKaGRQ?=
 =?utf-8?B?eXRGSFM5NCtVUE0rNVkyQUFkc21RaXUycnZQNC9FSFR3TURMVXhQRjIwUHQr?=
 =?utf-8?B?Rm9qa29VWnNRQWNhL3FmL2hTS0YySGd6bjVxaGFCSk5ybGl3NGhSbDNPY01p?=
 =?utf-8?B?dzJLNjN5QWRSOFJPTjd4UlpvTk5wOElqTkYzVEhIM2prNjl4RnRVV3RGYUFh?=
 =?utf-8?B?Y1VDanNGVTNZVlAwMzlyT3BnczNZRVNyeEw3OVBNc3BJaDRRT3h4Tnc2QmlQ?=
 =?utf-8?B?WkE3Q2hDRyt0eDFWYjVtS3JVQWIyc1NCWjQwbUFjbm9sVG00cVFEVUkyYnJm?=
 =?utf-8?B?VWdCc3hYdkk5bXF4RmNFSWwzVTFpWDZ0Mzd1VUF1RG9sanIvYTFrcDdHK0tZ?=
 =?utf-8?B?WmxQNTdwc0kvY0wxanJSSTZCWEJxSzhnMElkUVdPTWdhWFVqTTEyUmNmOFFS?=
 =?utf-8?B?M2Z1TDE2MmxCMzVkNmJUWmRaRCsrOS9uRW5IQThOR1Z5ZGIyQnVjcG52SHE0?=
 =?utf-8?B?VDlpMXgrMldObDdPcVVkVnEzWTZQcFArSGlINjFHWFRRU3ovUHZERXFQWE1B?=
 =?utf-8?B?bUZyaXo5bWZCODNhUzVVN2VPOXVJWmtDU0ZjK2RhRmVnWUNFamFNRGdJZ2FJ?=
 =?utf-8?B?QkVMSVhhS2tIUWo1MURhSDVJVnM5b3BMUE1VZ3JoaU9ZempVSzVJRG1vQUJM?=
 =?utf-8?B?SUxHczgwcEI2SzhaSjBML0NnU2hkeUpUV2plYkpjMGV0TFY5UHR2aWc0ZEZj?=
 =?utf-8?B?TmliajQ2U2g3b0hmenc3OGhPdi9BeWVLUk1tSDhVVWNKY1hlTmU5R0FIY0Ji?=
 =?utf-8?B?Q0d5YyttSXZYSksyc0o5OEpEVUVaQUtwbWtBZmppOENFY2s3UkI3YWIzemZl?=
 =?utf-8?B?WUNrYXhjd05DUXF2YXYwc1p1STFmVE5Ra0tlTFNkSG5lOGhGNTJCL2xWMnVV?=
 =?utf-8?B?UWFDRWVEVG1rdWhBNFlJdytINEt2N2t6a1lKT1Z4aHl0cGNHU1VpdVY2Tlph?=
 =?utf-8?B?NzhaTlJIWkExRm9lY3drcUpnNytwNlRJV1N2OXhxYVlZLzYwUTVBMW1uSDdh?=
 =?utf-8?B?VGtnWUh4OXI1S1B2L0VwK1hYdi96cXZTRUhJdnR2TTNIbGFEMkczZ1U4RXhP?=
 =?utf-8?B?WEJRd0N5c25iWVVoc2dBNTZRWFFtdzAyNDByWEhrYU1vcDNGSDBPeHIrVEow?=
 =?utf-8?B?b3JCcU44TE4zQW44WHZSTHpFUTRjRXQxa3Jic3JnSDZGOERsR3k2NXlzeE9S?=
 =?utf-8?B?RTFNZ3ZxWGdJUHkzbjRWN0NOZXlVTngxRDA1dlRQdW1aSmxrMU5lOUIxZ1Y3?=
 =?utf-8?B?MjVlN2kxeWZqdklYc24yWjVnNC9DN2o3aXlsdS9zR00vc2sxd29XcEVlZVho?=
 =?utf-8?B?ZnZNLzVwQWNrRlRyZSs5M1YyRFNILzBKcTg1UzhqMGVWY3Q0cDJEeTNXVmxH?=
 =?utf-8?B?SGZXNUtwRG9Qb2U3T3g4cEV3U0RlNVovVzdwSmQ3L2daZk80TlU5V29Hdyti?=
 =?utf-8?B?Zkl5ZjNvM0VxMlBYdlhFd1BWZDNRUGNVREs3cGhXczFLbDRKM2pBVHhwY1Ji?=
 =?utf-8?B?cGM3aTZrWkpVLzYzbEg4WXVXN1NLeFB4NDI0RjJTQTExRm5uSDl1c0RpYktZ?=
 =?utf-8?B?SlY4MXFwRXFMUGkrYmx6QkxSYlFnSVlwOU1udjlFMm8wKzkzbEMxcER4cGVn?=
 =?utf-8?B?Z0pkbkxpSnczemJTNFVFRmdNcmlTZVJmQTVKYlA4SCt0TWwxUm5WYnpBTDc4?=
 =?utf-8?B?dkRiZXB5K0tXdWt5d3l5cHNWdUo0UVlIWlNxQWVWQmdPNEQrUS9EZWNZWTRw?=
 =?utf-8?B?WmV1djhSU2JhOWY3dFd3d3ZCQzZyWUVCRDdIUkNaUU9wL24wNEJqQVpYQmpq?=
 =?utf-8?B?LytzR0ozTmFEWXdyZUZGUGM1UkJpQWpNaElLb2tNR2lNSlhodGUyNGhXT3ZJ?=
 =?utf-8?Q?Uo44oVj3+is=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2ZTendDVzgzNC95SDhXdmdjZnBPRnA0Y2NRcW5nZTZYTC9HNFFLelFWcno1?=
 =?utf-8?B?ejVQWkZkbG55T2JRdkUzbjNyZWcyUGNoUyt0UHZFWXNubFRYdXhSTDg5b1Ay?=
 =?utf-8?B?ZGEyQlFsNDErR1dzOXZlZWRqVnhWVnl3ODloZ3NFZFpqZ0wrT0QyRG1IeXBE?=
 =?utf-8?B?ck5TZExiQ05HMGJvdXcvOW5nL1Ywc2VqZ1g0NEUrVGJBMDNBcTZoZFVwZDRO?=
 =?utf-8?B?RGJlV0NiMWgzcHR0dUFkNnp4SHF1Zk8wRGoxSHhOS1lqNS9hNmNwSEpGd3F6?=
 =?utf-8?B?dmRmay9ERVdqQnVtSkhBeFVjZ2pPT0ZKMjJ5VFFuL3dYN043WTU2Ymg2WGVs?=
 =?utf-8?B?SzAxNHpRUzVYaDYvVDBReUZ0bklQWGRQbmgwUlQxYmtuN2xWcjhrNWUvbnFF?=
 =?utf-8?B?SXV1ZW9mV1RjRVlvZnA2cnJTWTVCNXRnM2hETWRnc0ZDSjdKTmltSGlqOXRw?=
 =?utf-8?B?QnJKV3Y2RlhaeEdIQ0pqL04wQm9lRytqQ05BdzlPYnVwQk9PYWtzRDhoUWlj?=
 =?utf-8?B?VHNCRkN5bEMxM3FsUHorcW9nYVh6SnM2Q2YzQXFMZU9jYjM3dXYzeSsrNEta?=
 =?utf-8?B?alRCWGdxZzFTU3o5TU9pbXFtQ3Y3N1FvUkxaZVJIOVVseEVqV0JkZUVCZWM0?=
 =?utf-8?B?MThOL2ZhNFlzbTlwZGlnV2ZpSnV3UFJ3RzVWTW9ycUhKa0ZqU2M0Vkx3Tlo1?=
 =?utf-8?B?ajI0TStJZTcvc2dHa095VGRwTER0bEVGN2ZYajFCZkxLcC91Yyswc2JpNXNs?=
 =?utf-8?B?bmYvZ2tZK2N0V0UxRWE4YnhtS2EvYXVZOXYyN1ZVcFY3eThMNm9xWEJhd3Iy?=
 =?utf-8?B?dnp3Ti9BUTBRMVlCNUZYcmhIbjRlT3BNZTVmd2NyU3BjR1FsTWRJdzYyRVBh?=
 =?utf-8?B?TnN6M1c4NUI4UkoxZVJEYkVEMkdFVUMyQm9PM1UyVDMvUTFDQzVuWjZZNFVv?=
 =?utf-8?B?ZzBkZ3ZKN1ZpZkxoOUlkMERBWFRxeVVodmF1ODV2SS9DcThzcTZpbStRUzZH?=
 =?utf-8?B?bWE3RkxEVWp6ZU42ZWRFcGNTQUNVSjRjWGgvRkZBSHdlMmZJaHdJZUgwWG5o?=
 =?utf-8?B?UTErMWxYNmdFcmVjZG5WcVUyR2xxZDd5RGIxQjBoblZaQmNHbjlMYVJBTlVq?=
 =?utf-8?B?SXlocHgrQllRRkZ0a1RTczMweFVrdXBCTW04SDllWFlLRXY2dFp1TngxVTgz?=
 =?utf-8?B?a3BGRDBaRCthMmxSWFR6Mk9DVHE5bDJVRkVSTUtsSWNqMTZjMys3QllDOEtV?=
 =?utf-8?B?K3dPVGxOc0lyc29hSWVoUnJnWWMySlZHeFVodUErNW9ObC81cnI1WmFpVm9i?=
 =?utf-8?B?SkUxaTBiTjd5WHluRFRjRWlMdEhlRnAzZlc2R1RvblhSSjQ1R0UxZFAxOVJz?=
 =?utf-8?B?NDdaRytUWnBBT3ZRbXRxMUo1TW44Mm9xRk1iaWdyQk45bG5hYSsvYjV1Tks1?=
 =?utf-8?B?eTU4SkcvcXNES0FrWXZUTVlGMjRydjFsbzNvT3FDY3I3dElGdkZCSUJQZmE2?=
 =?utf-8?B?UEptYWZheklNUDNFeDFyVjQ0WURsSnJJV3BKYlRIYzZvenVKbFM4cWR0eEtD?=
 =?utf-8?B?UUFvdUZtdDYxcFgwRUtEeGZaVldRcEplSTdONHZJUnZpVm9oTG12cEUwMHhH?=
 =?utf-8?B?eXZZVnRHMlBmYzVVL3hpSUxiL1hJY0ZhQ2RXamwzYXdjeDRVTm93Qng5OHor?=
 =?utf-8?B?OFB3L056cVh0TDk1MzlYS1pDMGxFdjdYU3JwREFzTTRYVHIybkhha3FSa1Vp?=
 =?utf-8?B?V3VOdHdoVUwzRmdJcHBha1Z3ekNjZVgwakd5dGVoaGUrbkF1ODF2M1BKNk5l?=
 =?utf-8?B?UWlFUE0yWGYvYWp2Y0ZwTUw5UGJCU083dEMvNGVMSjNNdG1PSzFLcDNsd05l?=
 =?utf-8?B?YkVJb2ZuYU9wQ0JkR0Noekg3Nko1aDlFYko2T2Y0U2srekJZMW9mNWVoWUph?=
 =?utf-8?B?aU5mZkNISytYT1owZ3poaTcremRHZ25jRHRMVXU4Y0tUUWY4MklrUzh1VkZM?=
 =?utf-8?B?YnZiYmFOTnRtM01STmtiU2g1UkNHOWFmalVnMzZ4UTNubnNqSXRuYVFKQ0w5?=
 =?utf-8?B?YytMZ0xqdm02L2FpZVVXSXFhUXc0L1BMZGJZT0ZNVEN3V09KYnY1OGc5Mm9h?=
 =?utf-8?B?WGF5NUtNbkFuWTU2ckJGZmN0MXo2VDh4bGYvNjd4M3dnVVRuV2oyU0J4S3Jk?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QUI6+CwXwQ7L8GdHcEKZ5g5VNc+ZG9Rj3XBTSt03Bj+pzmZG7eiiQO1ZYIJZjCSv4ilPbW3Odo1Hf5AjoB1hso1ZkYf/26/yn8J/g/jfZ3LAT+BeUnanqV1i6A7J4jiNOxSBzEDjyDAvz9kYK5FOMNXN49wgv3yskliQRMF9qpzssOevO2X6cuj1CGb/oIG2j3zGU4wTUDTDKW93xLqE0FjI67tE8InDbWPxMbrhSp5UZQMg9kW6MDPkZl/kst2IZxzbk3yn6fg1ZWaXqqLG6EYnZJmIoT1xePzq+bJPZqBTbOnmitESc1PmcEvh522XT97hlZy4if2dM5uQS5CleSQBCchddLXKPnLP8PkTunvhRnRjjHgZZ5+4MePrT/KEAdbH2vYXszaFZhf2QhjXqm1TbIjqzRgbjEt8lzXX+iZdqQds7nueWZDcJkzNv38G9l/yNGpM0ORedkNEUhF1anr9j6/LFHcCGbqb5hw5d1FtWOx7z6EyQ5yYXfGErjNa1llzqlboq2FS2p7iR1VjAbAbI9hnYVXbc610RxTarWj/YsvWqkbnDBEy4inILvCCSy6vf88wkj7RZV127DwNUqiRb2ekqP4BrovrzRZ0dvM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f929c3-e91f-4cae-b48c-08ddf45b866c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:26:49.2908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fmB5FhlmayYqYlAHxaI5cq8HWGl77DR+FMFkEKXZhBtDcOy1SQss1zP7JG/VpqZYTFyo4PKgsi5Qv49wLot6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7A7588508
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOCBTYWx0ZWRfX5cb25b3fNmib
 Ug09G+uPGK4HjHfrSYLklwzVzuUogeFpYxoqBi/o5cWUP3kLkbXCQ3sED07P0bvtcb+18j+ez1C
 Fp9QvrbWw3TX26Z3BGfgetADJc1Iau9xyS4zU0SnwxESl50wTo67xl1cH0LFG3qG91LXIHEfW37
 maXhfx1c5htWYxXxGktsfH+jm08PxpYU6YDTHQFsU7WmgwgHlhiiieFP4603uzX8RUavLyKu7AP
 hlQ/MEBeM6/bJVqXJCByldHEiNBYulWlrezoMqzJ0kEiUtszt3WBK1YYnq1MkhSG4O2q7owmtJ0
 tlXrq028bvyOPDJbo2xG0WWQHJi2Ufj1NtjEgQibklaLg1KxhQHP2VoSNq3ss0dvIJmvNUtfU7b
 0Te9Afum19ETKv9TN4M4ZmxtTWhAWg==
X-Proofpoint-ORIG-GUID: keMcF1_GnMGuV9PFdA36gBDLMs998ZOX
X-Authority-Analysis: v=2.4 cv=YKafyQGx c=1 sm=1 tr=0 ts=68c8141d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=tvnvZeL4VaK0S_oPBncA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12084
X-Proofpoint-GUID: keMcF1_GnMGuV9PFdA36gBDLMs998ZOX

On 11/09/2025 18:13, Ojaswin Mujoo wrote:
> This test is intended to ensure that multi blocks atomic writes
> maintain atomic guarantees across sudden FS shutdowns.
> 
> The way we work is that we lay out a file with random mix of written,
> unwritten and hole extents. Then we start performing atomic writes
> sequentially on the file while we parallelly shutdown the FS. Then we
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

I still have some nits, which are close to being the same as last time. 
I don't want this series to be held up any longer over my nitpicking, so:

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   tests/generic/1230     | 368 +++++++++++++++++++++++++++++++++++++++++
>   tests/generic/1230.out |   2 +
>   2 files changed, 370 insertions(+)
>   create mode 100755 tests/generic/1230
>   create mode 100644 tests/generic/1230.out
> 
> diff --git a/tests/generic/1230 b/tests/generic/1230
> new file mode 100755
> index 00000000..28c2c4f5
> --- /dev/null
> +++ b/tests/generic/1230
> @@ -0,0 +1,368 @@
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
> +start_atomic_write_and_shutdown() {
> +	atomic_write_loop &
> +	awloop_pid=$!
> +
> +	local i=0
> +	# Wait for atleast first write to be recorded or 10s

at least

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
> +}

...

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

nit: I think that I mentioned this the last time - I would not use the 
word "expected". We have old data, new data, and actual data. The only 
thing which we expect is that actual data will be either all old or all new.

> +			echo "$expected_data_old"
> +			echo
> +			echo "Expected new: "
> +			echo "$expected_data_new"
> +			echo
> +			echo "Actual contents: "
> +			echo "$actual_data"
> +
> +			_fail
> +		fi
> +		echo -n "Check at offset $off succeeded! " >> $seqres.full
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
> +
> +	start_atomic_write_and_shutdown
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
> +	# we want to verify all blocks around which the shutdown happened
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
> +# test data integrity for file with written and unwritten mappings
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
> +test_data_integrity_written() {

nit: again, I am not so keen on using the word "integrity" at all. 
"integrity" in storage world relates to T10 PI support in Linux. I know 
that last time I mentioned it's ok to use "integrity" when close to 
words "atomic write", but I still fear some doubt on whether we are 
talking about T10 PI when we mention integrity.

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
> +test_data_integrity_unwritten() {
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

