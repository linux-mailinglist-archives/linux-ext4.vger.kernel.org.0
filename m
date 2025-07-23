Return-Path: <linux-ext4+bounces-9161-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E23B0EC12
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 09:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5FE3AC3B5
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BD827605A;
	Wed, 23 Jul 2025 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UaRZ60/O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qpe3SHVh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24AA17BA6;
	Wed, 23 Jul 2025 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256211; cv=fail; b=YOCQ3F4sUOsaWw8cEHRDF9PJFYI3QtNcgP2HblenBNy73boClqP+EjEgT5Hg+M8qIwUg0blG8+FMOHQZPs3q8a2Y/B8YbFNZ+Z0BGJuHTATo7fp4blaWtRpsn6LmQNngmqpu/+7hPk80qt98h8QBS4o0X7wVLBOVpM9EvMmuAzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256211; c=relaxed/simple;
	bh=KjU4YuC9HzNjbSf+f5ELHHfPH+sxEijy4sqrAUC2aSU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c7mMk6HxObzujOVyrl/KxkhAHx31ORywuaWF90/esxH4TV795vdHseml4OCb+Fzkd+3eOuxEU95ZGFMYMxL90S6izFdj6W13+6sruQj+3suq+A5o5kAsqeG07+wQMMFKk2XtNsKFDHyslsoyFbtkI466Fl9r1Y8NNMXoo1AWKn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UaRZ60/O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qpe3SHVh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMQlxA023213;
	Wed, 23 Jul 2025 07:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gYN10cTj0BI4PYXRJbb/o+TdvzmJ8EioG6U2HsTTYPE=; b=
	UaRZ60/Ock28rlUu8ydIe+aMAnhEnLbRbzxV7qWmpniohCz9uIXuJJdcD9aYoT7B
	GnR/pgM4uGH9tMu9Zky9luUj9xU1atm/xPjohQgAO7HbNK+qTlYa5A0eDBMPzXID
	WkngAQRjsCSArDr9h+GNr9LeFvmWGcwIFqfw6Nw+vWz/baqyBEgCJ9uv+WGZEKCb
	9VRJ0gX0QYChzXZXwXvrmjM8wi6y76WCaTWyjcucCYtLIT8siZhZArNC5d16y6k4
	34SYkoSG4DJsDFAaKi2K+e9o0Xg56FIRn9xVOMiIRFVlhqR6WbS6mlTdhwcEA1Ki
	kUgcMNVoUI0MPmLz4AuYAg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9pyg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 07:36:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56N5qSOB010346;
	Wed, 23 Jul 2025 07:36:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801ta98g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 07:36:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQTu+e8rHB++EoJsmHMEr7jl5mTej89Pd7QjgMk785gVf4t7v7N72M7mO/cPSEoK68TZEes0C+j/abkia+l7le7D7aZcCwQSfphn5rl/4TvMSu+81/VjHAunXJVfET+0rQhruBDB+jGG/PPYjuZ8xxMPf1qVWa8qsCqVZZuAtqM2wGiuDG5EfgDaWcYFTLeh1Iqi4W50BVml1sze+QWwg2JCF+E8vUShQB76o7Y7cldnLFzLbXYgBCYoSmGGbDD52TzxdGH3zJNimPIo6ynmbXgzpyA5MqA66JnBO2iVP+yFUY7oMZuE32p/Xluml5pIgtm8Pn5wPnpZTUyX/lWg5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYN10cTj0BI4PYXRJbb/o+TdvzmJ8EioG6U2HsTTYPE=;
 b=hwHCv1DWPE7LZbt3hKl8qMoB4E5w2pV66m9VHkbb9swJk/ZfqW2vjaW3wnSK6vaMAsD5IpZ4t9oHEaOTyZeKwUxRLhtu56O5K7mwRZrcyo/+X5Pzq+YlGdc7pc1CevAdAs3gTEY3ZPutP1i+R3r66ArGspTTlcRIB1VzARqFa3Gm5jvqDmbMBtClZfT7Nn8jrV+FGRwv+GGfFRSXadYmqGvY4pKnEkFITZKIq2Dsqpv+S1pSPY87mgcWuQNg8G0EM4oPZqLrNPXv4RQR9XB6W/7Cu5bCxtpiMllHqtNqK5NDbQDapWxaO+2TKuEZR3DbZUsoa5yo3jA8fPFgSvltqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYN10cTj0BI4PYXRJbb/o+TdvzmJ8EioG6U2HsTTYPE=;
 b=qpe3SHVhSHj86pZUxvFZb4cvlyFMqsWlI9r/wKB3ixzBDVnm/E4GTmzGAFVdEEcOBY5U0J6BzdYuvWleiwsVU14HCrF5rhnNXLVBWQZ2iUNKMRNhJiC7lewhpmwAcxhIUq2mYxqpvCNvPQrfJ2vxdokXCKVo9JhgHkGIqCy1PKA=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by DM4PR10MB5966.namprd10.prod.outlook.com (2603:10b6:8:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 07:36:39 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 07:36:39 +0000
Message-ID: <0433b188-db22-4551-a0b3-c908a00a7239@oracle.com>
Date: Wed, 23 Jul 2025 08:36:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xfs: disallow atomic writes on DAX
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, cem@kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4 <linux-ext4@vger.kernel.org>
References: <20250722150016.3282435-1-john.g.garry@oracle.com>
 <20250722175820.GV2672070@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250722175820.GV2672070@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::6) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|DM4PR10MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e56e59-175c-49b3-81a7-08ddc9bba7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEJpc3U4M01jVWptRWM2eGdlWmNiZU5QbEJMQmoyd0o0U3pFb0svNTMvQU1M?=
 =?utf-8?B?bm4xS3d3cjZES01hM2lacHlPTG9OTHFXWnhkMmhEVFpNR2t1bFhnRTFmSis4?=
 =?utf-8?B?VjNOQ05YK0tUYjVDQUZsZytCK0dIc0w5TmpUUXRLOTBUck1nU01lcis4aFFV?=
 =?utf-8?B?U0JJOU1nZjhncDJKTWlud3BoL2ZkTDhoY3RVWEM2Q1kvM0FVZkVIWHdVaGxZ?=
 =?utf-8?B?TkZZdlZ1Y2RyaTZNejFJS3VyWXd4aFdGbmNpdVRwMmN2SGliSHZOV3N1VHVG?=
 =?utf-8?B?TDg3MkFjbE81ZnlKay93V3d3MmcrVHJaT2E2NWRaTG1zajNtVWlGSnlpMkMy?=
 =?utf-8?B?eUpheVF2SHVIaEJhbHhuclQ4VHZjaGZUTkI1MXlBUnVFWlJOS1NPYm5RenIr?=
 =?utf-8?B?S1JCbmN4ZnBEQ1M0blUzei9LQjUrNW5yMHdnVi85SkV0UFdrOXpXT3hzNm8w?=
 =?utf-8?B?UStIU1dyWThGbVJoT3lWWFVSM29KUU9iMnBDaUVKaHJkVnY0N0pSbEtMYyty?=
 =?utf-8?B?WDBVVjdpd2U1MER5WG5kVnNWNXQ4bHJDQ0dQV2lTcWZGdnk0aFNRVEUreGNQ?=
 =?utf-8?B?SDZTbUwxTGdEc0ZmTE53dWluSm0zYjJMRFc4MllTWnN6dS9yZnVpSVNkWDZO?=
 =?utf-8?B?a1BWMHN6RVVaaWg1RjlxdUs3SGY5UitIVUZyZ0E4S2tzd0U4MFhYU0dTbG1U?=
 =?utf-8?B?R3NWSTZYT2QzYXgvUXN0UFpEcUpDUnVEd3NBZUpsU0RKUkU1V29NbXEwOWwx?=
 =?utf-8?B?dlpLb3R3UFdCWEtsRmNJdkk4czUrVXpQNGtYUGc0VmIzcXFGbDVuTENHNXBq?=
 =?utf-8?B?bm5aUWkrd2FXZ0VlUk10MGd3VTJEOE8yOE9uUWZwS0Nqajh4cVFwS0k0bGF5?=
 =?utf-8?B?eEVXQ1VBanArRnJMaHRrM3ByU08veU5XbFlPWGJ1bENlNDBIcjlSRFY1Ym9u?=
 =?utf-8?B?TWVSM2NjVTk2azU5UDhrM2ZPaGpRekRKU3lJLzduR0tzZXpSOG51S2ljQjdi?=
 =?utf-8?B?TEdmK2YrTWRrTGowQU9TaDBNc3EvRFFUR3ovTTMreTVRWDlLRDlOZ0plUnkr?=
 =?utf-8?B?azJCN3hyNW5MR1NjV3MyOG5ST3M5NENhazBIV3R5RjFWVGxNYUxnbm92ckpJ?=
 =?utf-8?B?RlR1R2pKWDJPLzd1RXIxWnNrNEpVTHVFZHA1NG5MMFluOE9yRFA4b2VIcURj?=
 =?utf-8?B?MDNjb1B0UUhlT2M1WWl1RkFLaHYvdk1NeTlCUTdpaTlIYVZKNTBBM1YvaXVh?=
 =?utf-8?B?ZGtHdnRUVWo2ZkMwWmdDVytCQW5MOFpjV1lUZkVxdU9GTmViMjlsekZISE1Y?=
 =?utf-8?B?YzU1OHV4d3l2WEdyYTdUZ1JOMW9FWGxPMERNNDVYK3p6Uk82aWVJUEVYMlZX?=
 =?utf-8?B?OFJZQ3JWYmJEbUJxQWxmdnBueWlncXo2dTUyT0dUbGltMXhCZG03d2hyK2hT?=
 =?utf-8?B?QXRMMmpDNjhiRW9qRktWSTZHRFpNL1RRZmRLeHUxK01oalZ6aTByZlBGUFlL?=
 =?utf-8?B?RkVLK1NYTC9CMzFjZTF4ZmdaZjBVOGpPUnFjS2dkckJhMko3OEh2emJJUTFE?=
 =?utf-8?B?ODg2QzB6Z0lVcmFHdndwYlE5ZHcwdmx1WDcremV1TVZxZ3lLRERpUG16d1dP?=
 =?utf-8?B?aXRzOFR4czY4SWNjbHNJNXEwSm5KdHgyMEhiK1ZLaVZldEZ0TTF2UngxTzk4?=
 =?utf-8?B?NkE1UVJCVk5EcjM3ZTZFNDZpOG1OMnc3UDludW94YkZ0RlgyTlY4SVNiSmYy?=
 =?utf-8?B?N2VVcXFMczNScHh3cW9Sc0lka1lDSTBkSlRBNnZUSXdCVlczRTUrRmFPUnRj?=
 =?utf-8?B?TTd4akRGb2pldTBKdHl6TEpWWVVoT3VwV1Vnd0dCZU1EQ0ZCN2dxWkxsTTAy?=
 =?utf-8?B?emdvV1JrcERBcnl2S0pCYUVnVDJadFdTblNjODFuZSszUXo0aGRFb0VPaG9J?=
 =?utf-8?Q?Y+4AFaflLHM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azBHZER1R1hrcktEcWlTRGdKVFA2cXBWK0pGbksxTUhRL1RtV0pKWHBNYXBO?=
 =?utf-8?B?WjNZZlFsTjljajB5UEk0d3lMYWhFdXZGWHhwaElyeENMdGRSeUp6NXdIR3lD?=
 =?utf-8?B?Y2E0K1ZKNzVVUlZINUFraEhGWnRZWHdZL2ZFSFJyU1NYZW9JeU83Ykh4MEEv?=
 =?utf-8?B?L3pKOUxZV0N6MnJuaUR6SDRZREhqazgrd3ltdFJRSUNhaWZzWlN6cFozQVE5?=
 =?utf-8?B?M3JNd3ZMdkhzUytPT1gzSldXQjlKV2FTQmVRN3YyT1pBK0Iyc2g3L3l6S0pB?=
 =?utf-8?B?YWIxZmMwaUM0aVhFQlFzMnk5NTdhd3luVHNzRXN5QUdQeVBRTXRucDJHVHZo?=
 =?utf-8?B?Ymh3RkswN2FCQmZOTHcxekEwQVA1VU93dXZ1NVBLV2QzNXYvL3lrU21uK09i?=
 =?utf-8?B?SDBWQmdGb01FS2FuOURjd0RmL1FQdEtjWEtHQysrUTBMSElTUTlSbGhKSCtr?=
 =?utf-8?B?T2VkcmdGc0YxUWpUaEx5Q3NIclZlaHJCbVhXVDBNZzBTdEppbk5ydHZRVkU3?=
 =?utf-8?B?T3p0aHlFb3hhdlJRbUM5QUlOT1VzUXhSNGp6aXVjZEVaR3YrVzF5L21KUHVH?=
 =?utf-8?B?RHlmOEFqRVRNeFpxcVNlMUFHUmYzb0cwNnJjdUFDWW9WOTQ5azdEU01mM1BT?=
 =?utf-8?B?aHBLSUNrcFRPbC9oelZwZmM0aUYyZWtRNGxtODdOaVhaWGtpeHdXL25raUZW?=
 =?utf-8?B?cUZGTWNtbGUwWGVQUm92OFk4VUVwTk5uQnpPaHg4MnZEN0YwaXM0Q3NYNkFT?=
 =?utf-8?B?YWJSUXh1NjErZm1MMDB1ZXkvUmd0L0o5WDVoY3FneUpScXNNNEYrVDU2RGk0?=
 =?utf-8?B?VFdjQkF4Z0Qrbm1DelJ5T2EvS3N2MVJBT0hOT0xvakxHYnVtQ29YMDhCRUZo?=
 =?utf-8?B?eEROeFZLS0JoWm1FWEl4REJkbmZFbWltUTVnYThkakZSalNBeFZqbWdxbjBw?=
 =?utf-8?B?YjI2Sld5ZDg4SFVhSGkwUUN2eW1saVgrcnVmZ1kxdG1qa2tnUnF0QUN4bGRO?=
 =?utf-8?B?YzRwanFpZWFWaWpTQlVLMXNxcGZvUWVzYzRoMktKckFmSWtMV2xuak5YZDd1?=
 =?utf-8?B?LzcrbUFXWkdZb3I4MFA2TC9VS2ovVkprczN0TVNVb0tXQ0VkbnU3ZHR1T3NV?=
 =?utf-8?B?ODNmdVMwR21UODdLOGI1ejFEZmJ2cldWWW95K0FzdHljZ1NENkJ1SDVYZ2Zl?=
 =?utf-8?B?dlJ2ZnFYdnhvTGdHakx3ZDV1MzBSK3ZSQzR5SE4zM0NvWHRIL0JMdjVkcjh2?=
 =?utf-8?B?b1cvaXphcWJHczZHQTArb0ZsS2o0Ky80VHdwTVZIcyt6UHFYQmZhTEdYNDV2?=
 =?utf-8?B?bDIxVTB1RWlxbndvdCtlTjZmNElhdiswWkpUZjFVSkEyc1VvNmxpNWJrbTd2?=
 =?utf-8?B?Z1dVV2lTQ3JtdHhJYjFtOXhnNEJQSm05K3pEK2tHVml1N05nWjk0ZnVqZHFE?=
 =?utf-8?B?bVhZVGtFUy9MNDRvMnhJMkhkK2s1VW5oQTVIWWFuQkZCRVZkcWphQ1AvZ0RJ?=
 =?utf-8?B?OXl2MlF6T0FQa2VVYWovZXp0R2FyeGZlajNFbFlwNDU4Wm9yS2NpcytQeENT?=
 =?utf-8?B?cllLYitTNUNtMlNMNEZCcEdkNkxBZnRzNnM0M1lKalNHaEQ1WWtlcFVvblJv?=
 =?utf-8?B?eVY2VnA4bGxDUEVyaVZna3NVR1hJU2l3RWFQTUlLS1VXTWV1ZWIrTUMvUXFQ?=
 =?utf-8?B?TDF5YTFEelhtSFhaZnk0dFk0TkVtRnlGcUtmVnlMQnFRUGh1cEQrNDV2SWpR?=
 =?utf-8?B?dVduMDgxUjZON1JDUEJFb0lnTlIvS1JXeTRYMGszTTgxMkZyaGQ2Wkx3bFhz?=
 =?utf-8?B?OEQ0b1dGU2JEcTNSMHZac0JDNEdEUWx2YUpTNkVQNjl5ZHNLNFc0QWdTNXl2?=
 =?utf-8?B?UEdEUDJuN2hGR0N6NkovSHRTQ0NPWDJyb2ZYNzk2d2FUdHV0K0tCbUswQ3Vv?=
 =?utf-8?B?WmZQeEsxVEwwc1J3WDhjS3FMb2VoOG9adzZmUWdCR1d5OUJRdkF2Mk93S29k?=
 =?utf-8?B?d0ZUNk9EUTdXVDBHQWtQREhTYVk4enVhQmVqbVpXcDlDeGFPUENJaE1pMmtM?=
 =?utf-8?B?K3R6VldnUTRzL0ZIVTJmUllueSt2TXZLazJwRDFTaUxtY0dMdldHcDI2V1ZL?=
 =?utf-8?B?dzU5K2hXcmFsR0RSUU1wY3JkTjBoTmtLY3pmK0Vva3NValRqaWdjSS9SUlRx?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F4AwSZb4fEbqSTetKt/NKQ1ZHilYmaOKd8E8oXWqYBRq90cyLT+U8Hns1lIssZY9V6yAlJdR71JvrdTuTy6I6LO6VcH415I4SzU+Mt2czs9acbwTnS52pYJsl558guufxyzmkXeuJpWgg75gJ2GcosLCd7OKd+LQIlkuML5wVBlM/Zh83qvY2cdAtG4bqkGxQ6QdjrSJ8sycQZMOjhw099YXJaWC8sqR7HfjWN58BMr1P0EN3SH2ZQ9BVQrE6TBH6ftINbxgK7SYvmKEekLdjnLDEFeCKcKaJHjUmofwOeS37eZ/4vFeW6kIsNBS3U1UEraXOE1zi3zS40UXTBVYum+wKfN24c/XnMLZx2llvcfnFg1SwVabPnmidMwg749fKzyMM+fcuaZYCmcVYN1u8wWjVREUWUJx164HGxMJDW1Z8bggXshR3nZaUS35Y/vNQOYIEG15zlM9sEB6UVty5HRzEyoc1UahwrcLaULbyWGy6E93dMJw9ue3ugpKlsOFn7dwNVb7GfWyKPM2dEeLE2iPfPcOWARD357C2GPWdlDakpM+BB18s48J4LRqxUR5/vyb7uJaQ6jQMK8XudGYzAsKaQI10DkztPibGB6pRTM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e56e59-175c-49b3-81a7-08ddc9bba7b1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 07:36:39.3821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbUNSlZtfs25I99BZDwz9qJAk4dDbvpIvCnQTdq1xvTetscr+1K7TDVxJTR/ek/itW6OV5JLEh9HyO8F7xxlYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230063
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=6880910a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=t5nfGJQhTYP872foIWEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: x2CV6BVSRkCaWiU9qhf6Agt41xSg8uoB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA2MyBTYWx0ZWRfX0MZ2u3MCA1uh
 0GNEFDB2ULBG2e/OwceJBZWQudtxhWRJU6kWOYgfZhnRZyaMNjmzEEZxzzF7jQkeQY12sNpZsjE
 SP9iaG5RospQzJTr0CjdjUV2AkI0Hhd1Lfiu3W2vV0HAwcGxKajQiEuM+9XQyX7xWoJhSyqJkcY
 mJ9PvptLP3NhQHDhJl1MscJOFBcwbd8ZoDiX2pnUVkPjGZTGUf3FHJ5sBR7DFtEZ3ntHirQzBmC
 XlEzJb7KMMuhEEFhZjPxYU399rSMdqjLpgqpkwl3M08E8jbBe5Dfv9wechPUkswtpR3eG8W63v7
 bAPEXbfKJuRSmcMk2d9KuCGRcnWVFexcp0L4brXtNwu5gxGplAHtdUvJXQIKVPpwO3yHvHtRc3p
 YXO/VkpZt2vX+v32WdgsmsLnG/oMRXteloVIIMfR6gH8Wh06GNYns3HtnXLxZ/fE932mzDd6
X-Proofpoint-ORIG-GUID: x2CV6BVSRkCaWiU9qhf6Agt41xSg8uoB

On 22/07/2025 18:58, Darrick J. Wong wrote:
> [cc linux-ext4 because ext4_file_write_iter has the same problem]
> 
> On Tue, Jul 22, 2025 at 03:00:16PM +0000, John Garry wrote:
>> Atomic writes are not currently supported for DAX, but two problems exist:
>> - we may go down DAX write path for IOCB_ATOMIC, which does not handle
>>    IOCB_ATOMIC properly
>> - we report non-zero atomic write limits in statx (for DAX inodes)
>>
>> We may want atomic writes support on DAX in future, but just disallow for
>> now.
>>
>> For this, ensure when IOCB_ATOMIC is set that we check the write size
>> versus the atomic write min and max before branching off to the DAX write
>> path. This is not strictly required for DAX, as we should not get this far
>> in the write path as FMODE_CAN_ATOMIC_WRITE should not be set.
>>
>> In addition, due to reflink being supported for DAX, we automatically get
>> CoW-based atomic writes support being advertised. Remedy this by
>> disallowing atomic writes for a DAX inode for both sw and hw modes.
> You might want to add a separate patch to insert:
> 
> 	if (WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC))
> 		return -EIO;
> 
> into dax_iomap_rw to make it clear that DAX doesn't support ATOMIC
> writes.

ok, I can do that.

> 
>> Reported-by: Darrick J. Wong<djwong@kernel.org>
>> Fixes: 9dffc58f2384 ("xfs: update atomic write limits")
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
> Otherwise seems reasonable to me...
> Reviewed-by: "Darrick J. Wong"<djwong@kernel.org>

cheers

