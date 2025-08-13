Return-Path: <linux-ext4+bounces-9358-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75680B24AD3
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 15:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9760D881A8F
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 13:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17A92ECE9E;
	Wed, 13 Aug 2025 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="obKfrnv7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AdBZH44t"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9D2E92A6;
	Wed, 13 Aug 2025 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092398; cv=fail; b=Z9NWJf0ukubLlDoFllknKmlYgxCCgKbR+F5Sjdc7vTLrEBUUlfSh3JFPnSn01PkvCUGrJy4qQ92SU7nyuwQDk/Zxsa7R8gExjD7TZQXmcZkZIVPglCVLLTtXQdvEd4XwUiUe9t7Yy6lPR9xeqKwbsDYBfGcRxy4RHpTm7Xoj9QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092398; c=relaxed/simple;
	bh=QcMSCYEsjV2A0c2Sl3EbJLE35sEQ0XeQirlD6Pw3xU4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IBlI2YeGKKTqDXlmpcCu3ugwg0LUljf+P7QHfrIIOg1XRqtnb36mCRzo+LC5jt9SJGmKL1A7wnd/J9quTbifSOumhMgLCeHkqosmUTWVpyw5IFYF99lw9R0QdO32LfpVK3Ky8da6/IJ9K8DcJ9AI6S9mKEPU2eLSXCMVLUj1Usw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=obKfrnv7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AdBZH44t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDNBk4022954;
	Wed, 13 Aug 2025 13:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YmK6dM6BDQ3vSjOZSEQAkOxqf0aVl7J/opE59cuo3JM=; b=
	obKfrnv7h7jcxN7PGIeRzAeJxSOLRnUofxspkjwAKL5r9xVhxC+E04Ye4l3S7diy
	OgV3wB1FLJhwroV+xpr4tCr+8tnHkHZsUOhPbKvOKFse7Pia6iTo8KD1/A2Emkqp
	coqADwyvfQV9U3aQBSCUbNIVqSd69IjYyb30uhzjvcqpM7bDQd83bscp9c4i2u4L
	rRPyG02bRI8rD2HPLoqp040qXteGuYEaK9vVb8WsRb/Uwc+fb1iHX48d932Q5TEj
	T3U505paxBVEbKpuoxCYDKa6PGaACLfU6mKZlmf3KZtj8Fm8blSGVWcfJvMbuyRe
	XAhIj+759BoHZhkWJEa8Eg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvrfygv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 13:39:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DC6B30038576;
	Wed, 13 Aug 2025 13:39:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvshycue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 13:39:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajtoDgUYDxlEKoo0Q6APOAfn29A2rYIY4p5N1vC+3u4UQ4pptfMpvZpvLynkZ51BV5ykVdywWpBTSw2p+jNGLng8WbnC9ndj25Aay+SZ37YrPB3UK2AjxylRtHlJdb8NCEazObzHj8SnucYPz6Y8FoMPlEyrwq5dFDlElrm1ziNdTeJhNOD6hyJN0pdX8MemBFhcORFwVFzmh18X70NQDHWOYYK3XyE5MDP4mRXN1LsP9+EhM9JqX/BDmJOC3t61of+7POBlOd5bvTo2wN/kg9taqMdYL0QKytMTt+Va3jWF2BeLf9ul+ajSXZ+zKGifzuQItITULDWpTI9uQenjuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmK6dM6BDQ3vSjOZSEQAkOxqf0aVl7J/opE59cuo3JM=;
 b=UMOk8456+ZTD7QuIzX0KWMdmgEye20HjJAv8VPXGi2F2eHTEpgkzB706xoZyeqzeSy6tZ+7R7tKLwA51YW9OvH+/tI9mqxi+wjmnhWLNnWgSOXQGtwJe+tLmUvQpV2B3ae3Eeh4t9btCWvqbuyLg+2ys5cSPxvpmVrZkRxBaZU3c052La1VEAJSVIb6fSqWk1zLasnrHIaTQ/p+iEB3ovEPKZEiAwSBqZcDRdAr3PXStK5S24kfhCsyToy1mfDPj0Q3eXT0a6buk9ejv8hk/ypZ9bIQCN0hAQ3/O1mG/lGXRim9IMopLQdjQcbAUF3tP31UK2RaJszOx1OEBbi2QBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmK6dM6BDQ3vSjOZSEQAkOxqf0aVl7J/opE59cuo3JM=;
 b=AdBZH44tWHsRMnSNNJfxm3Xm/xRrRX72+JIXH1zjt3iuECy2psy0/BM44EmQkQjAYNQS83LxKWxGPkf0r0Rozi005c2irsSkjzP48vJvVDt4Lwf6DuV+oLLDaUK1GEX0QIP2W/HeO5keX49v+WzG05YdPfzSX91aqBZbiLHpgFQ=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by MW4PR10MB6323.namprd10.prod.outlook.com (2603:10b6:303:1e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 13:39:42 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 13:39:42 +0000
Message-ID: <f9ae3870-f6c5-4ab0-924e-261f4ec3b5cc@oracle.com>
Date: Wed, 13 Aug 2025 14:39:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] generic: Add atomic write test using fio crc
 check verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <783e950d8b5ad80672a359a19ede4faeb64e3dd7.1754833177.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <783e950d8b5ad80672a359a19ede4faeb64e3dd7.1754833177.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0298.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::15) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|MW4PR10MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f9698a-fc99-4b51-819b-08ddda6edba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d29VY2crR1RmSWMxR1RzdzhzNTVrVWp6Rmtqc2RjVm81R2NoUmhDRDZlajVs?=
 =?utf-8?B?cGUwZXFWbGM4RmFab1pYdFhjQ3VEZGkySmttQ1RtUE5GYzVMNnl2Q2xEVlA2?=
 =?utf-8?B?d1ZUS2t6T2J3RHhoaGtmVnFnQlRQbUVJUGFITkdMWEl6cExQdmVXRTdpdVll?=
 =?utf-8?B?ZUVEQWN1UFdOVDRQdDZaRy81YjFTZzJPZzMxNndWZFJ6eFkwcEpNTUtwU3VT?=
 =?utf-8?B?aUt5dlh0TFgvTThxZ3U1bW5Lcnh4WXM5Q3RvcG9JU3RRZ2hXTTZYVWpXU1d1?=
 =?utf-8?B?K1ZuNG5NT3BGUUFQdVFhcjlzRzQ0WmtSd0Y4dTVFc3B3ZEtSVlJSS1MzWmV6?=
 =?utf-8?B?Wjk1YjNMd0dIZVV3cTRPOGkxb0VxVTB6Z3NMQktCRkx5Sm1ySS91SVpFaDRQ?=
 =?utf-8?B?MnBEVjN4WU9iV3duV0c5bFZrRzdzcXlUSy9YSDN3Y25jOE1XaVpISTcrTHdD?=
 =?utf-8?B?NHRsY01NR1VDMVF6bkNhaHo2c1BidGphTmVSTFRJUllmNnpPS1BBbDlLWjUx?=
 =?utf-8?B?em1rK0RmUW16QkRQbTBlQUN5QTA3Zm12YldNVDM0TmhaWVI5VHdTNUhoTVY2?=
 =?utf-8?B?OU5sRUZBUU5vRE9vNUJaWS9jZGw2d3VtMFFjSnpRU2s3T25wd2t1RnEyeFBj?=
 =?utf-8?B?dktMc0JJbytpZnZYMDZraytTbysvdDdvUG51cmdGR3RMdTRGWGxLWUV6cHdq?=
 =?utf-8?B?cHhNUFl0MEUvaVNMeTRUS25tU2k3bXI5bnBWcVllbzFTbjBnTGptelc2UXFt?=
 =?utf-8?B?V1I4akdJZU5qRDRDYnZRSnIyOW94S3NFbHMyNzRaTWJveHRDVGR0d1RpV2ts?=
 =?utf-8?B?Ukt3NUFZZmhPeFU5UnFJTXR2ZmRXckVvQlQvbFJZLytRMEtpeTczaEdFMU5i?=
 =?utf-8?B?ZGxBSFJpcHloQ1REL0JqTnlJUnNvLzhBaC91OVNzTFNmck81RHF6bHdjR1Iv?=
 =?utf-8?B?ZXVEcVIweUp6NUNnRTliN0dqZWpjL2kvbG55VDlLTUFHQkpRQ3M1NXpjSVJR?=
 =?utf-8?B?TTBQOU5Xbk0ra3BWblNVRlZ1ZDIrZ2V3bVpHeTl0SlVmTnVIdFhrOGpoNVdE?=
 =?utf-8?B?aHhHOURpU3l0bEtDWXBma3FxL2piNmtBV0ZmdmlPbjY2RGxiRG42NXJGSHg4?=
 =?utf-8?B?ZnRBNklNc3FNOVRDQm1ZbVFabmk4Ym9NMy9leDVWVXNoSCtscGxNU0l6eXdj?=
 =?utf-8?B?bFRlazU5NFU1YUdYVGZXd2NSL0wyNWRPNHJKT1Z1dzAyWWJwemZIQTAvRmxL?=
 =?utf-8?B?eTljNkhvdFZJMlNDcTlveEJOMGZmSUtRTW1zRE43MWhaMm1aYjJmV3plcm9U?=
 =?utf-8?B?UmVGcEVXZE9ZOCs3QkZSdHBNQWdvY2FabHZKWVJQTW5pb1JDNmREdHFMa1J2?=
 =?utf-8?B?NXhhM1FlK1BBMDVNb0UwS2lTNzM3RzJlaUVlNk4xdnBRcUFGVUlwK2svSE9P?=
 =?utf-8?B?MjlxNCt6dDN0aDQva0xicnhJUVZlcUlsTDY2a24xQXZKcXp5UFZnLzBRaFdV?=
 =?utf-8?B?ZkZHa2VlSVN1VHF0bWpiNGNXWmcvc2YyQndaU0VJWUNSVk8yWEl3SC9sYi9l?=
 =?utf-8?B?UDN4UzNVVmNlaGovTE5SNjhMZ1ZRTERPUlFRMzJpZGk0aWhrSEcrdmxGNUtM?=
 =?utf-8?B?eFA1aUtDVVQwRXJ6OENsVzlwMWpzS210NnZUNHord3NYdnlRdmlteitnaGxP?=
 =?utf-8?B?dXJVZ2JZZ2tHL0t6dTEvYkNuR0NSaGVrNG5aaDBzYm00Z1Y5N1B0Q1pFU0NM?=
 =?utf-8?B?eFQrK0E2c2ZJVHBTellrcFYvMnQyam5HcGFac2N3TXhSM1NERnQ5aWEweEpM?=
 =?utf-8?B?WEdLSHNHT3piUWcwcXhFSmRKeTU2QXJWUUEwRUMxRjRqWjBVUEJvR1A2OXU1?=
 =?utf-8?B?ZDBlY1A1aGtYQU1XWlNoVTFJRlRPbkhxbEJMcnh2ak9JLzZuVGcrRWhaZzdY?=
 =?utf-8?Q?LlpocLb7Q8M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1dzSE8rRGdVV05PMVJoQjJMTFVFZnFscGNma2VPaTRlY1pEQ0E1VmQxSEtQ?=
 =?utf-8?B?c0s5TCtKUjZKWjZia0xIdTNLOU9tckxQLzIwcG9KN2Y0YXpLSWFtNG5BOFlY?=
 =?utf-8?B?cUhQTEcwUEd4R1FBeTJSVWlyZXFQMjNpSFFqbmp0QnJ6MjdlVTBBQkc1SnQz?=
 =?utf-8?B?SW5VY2JSazhIRCtFVjRXZVJEeEN0Mk95Y3Z5dkNXUGIrUy9SWnpCSWJsV3BO?=
 =?utf-8?B?Tjc4ZzI5ckxUb010bEFKK0NwNXFkMmNxNnJ3ZmJMbDFrb1ZpYXF6alp6QS94?=
 =?utf-8?B?eUVVcXdvQmlEY0pqblV4Y2UzMkZjZVNVYzV4Tkl5V0h5S2FyZFpVUHdvSDJI?=
 =?utf-8?B?L2x4RGpFa0JLTHBkOHJzSkpqSDJOcVo4NkUyZlY5VFJjeXVKUjBCNGV6SHBn?=
 =?utf-8?B?ZTREaVVmdHB0L3ZybDk4YTJzY1IvMUxveEdmOE11U2tIenM2Ukc3V3VBTFVh?=
 =?utf-8?B?bzFxYXc4UEFEdkVFOWJ6b3QwVmVoTk9MNm14Qm5SSXN0MXhYZ3R2NC9MK2Fr?=
 =?utf-8?B?VWErR0RyK3Z6UGxqRDBvdTcxVUx3UDFzTEdPWlZ2QWdWeFhrZTRDTFJQSXZ6?=
 =?utf-8?B?K1pMSW9ZbnN4aSttS0dDUGwzbzBzOWFTR083bDBiY3A2OFNMN2ZZTEliQjBO?=
 =?utf-8?B?TTh0RFljOHZTYW1KNXhGc0Z4OXJZak5hK1hOM0xaMWhiS29KY2ExOFk2d1Ra?=
 =?utf-8?B?blFva3BJaW9BalVnbGVWSWpsdkZmMG4vTHErQlczakREdVpRNVRlNDQxL1p0?=
 =?utf-8?B?UEhDV05oK0owNkJKQjZEajltK0dtUFJBRFkrL1VjcEQxeTJWZ2JoTmh0RW82?=
 =?utf-8?B?WTZ5eHlsMmh0enZsK2NzRkUzVHhCdmUzV0lMam9JTkhZc2hlcjcwemZ4K2dV?=
 =?utf-8?B?MnBmYUhEOXRCQ015bGdUQ205MGhVOXhPV2hpS2x2cWd0eit2emJWYzkwZUNL?=
 =?utf-8?B?ZHorL3VyYXlpeXRHY0dLV25OOGNUZm40dDd1L2hxVC85MDlRMmtyN0lGSHpa?=
 =?utf-8?B?eWdKQXhTdnFXUVJTYlVLMndqbzZPWFEySkYyZ211YmU0c3BzZkJQMGNOYnZW?=
 =?utf-8?B?U05ueWNKakx6emVkcGVJcTVsZEd2Ylc0TG5UWjM0T2JhenhKM3hRa2F3YUQr?=
 =?utf-8?B?Y1preFljMUgvc0ZpTnU3OUt2SHZrNU9EMmZnSXY0cnhQSzIxaWE5Ty8rOHVE?=
 =?utf-8?B?YVZiS1AzRlppTWhQcGF5eGUxV1Q3czBSVERMQUNRSktTTWdVblYwd3o0MVJL?=
 =?utf-8?B?Vk9yMEJIM1liMjdsdVdoVURpSE40UGMrcjdqcy9RTDFYSy9IUkRSU0ZENXdH?=
 =?utf-8?B?N1k0NTdtcGREanpVMUppOXpIQnRlR0FhWDd5WlZ0V2FSZ2VPM1RkRHZURjlY?=
 =?utf-8?B?MGZTenBBOEhJZnpLK3NnMHZtdXZnTERDdTlMdE54eWtyaDEvWnVlUDFhZ2dW?=
 =?utf-8?B?TGYvNjl3dXNjUXdRaTM2ZzFMU1ljRkhLOFpkeDdkQndUckk5Snh1c3lab2Iy?=
 =?utf-8?B?djNWNGNlcUFTeVZxRUJhOUo3R21qZUJRRWFaWnVudW9GSWVjVmRYQVhQTUJw?=
 =?utf-8?B?QnNlTmc2RU41bHdIZzRSQzk0UTlUTnZQK2EwaUVaRjJPV21Id0FvbU8zeG5w?=
 =?utf-8?B?L3RsZlJoVTdTcXZFWWJnSTZDUzc4MVV5aW1FSU5ZaTFWVGlOLzBmRlZNZTZ4?=
 =?utf-8?B?RUl1S0VCQ0lYMFcyTEovUTZrUkFzNEZkZitCSStNNDdjMCs0U0E3bjVyNGl4?=
 =?utf-8?B?a1pJcndzRXdzbUhEMzJETkxDT1ZlUFVxNlZDRFh5Z3VQY0lXM3hIMW1EQ0M3?=
 =?utf-8?B?R1RlTEx0MlU3SlE0SmZoZDJReEozWm9hb0h3bGZxY0VGdEtYWG9rZGt2Ylpi?=
 =?utf-8?B?clBXdTFCRWJzOUlMK0Zkc2xsRHQ4YmlMRlVmY0VmbW1VYmlQM1hRMXdzZXo1?=
 =?utf-8?B?bHd3Y0ptTEw0ajRCeVk1TTUxc1FkaHB6S1pKcVp5VEZPY1k0SFVNWHk3MDlQ?=
 =?utf-8?B?THYzM3pmcUhsQnlSd1V6eUwxTHBWLzZrd0lxSlZQRVhvZzNxa2RONCt6QnBu?=
 =?utf-8?B?Z1RIYzJuZEltdHY0cklZeWN3TFRzREdhNzdYUmZ1cGU5UWUrQnAxbENPdFQy?=
 =?utf-8?B?WVI0WHROYTQ3aXgxV0QvSzZrdk92Wi80SWFRVnZWdDREaTI3ejJYa1pqdTRK?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vhm7n2iWNrg5ggkMUiCHf5mqmtHhkCYpLByDYUceIUDXl5Vic76VztxunkkYitM7lfZs+b9e14jmhcVC1IIPnmzxW9NYIpINo2P9YFntik2DVA44zZyx2dQv4zdqzEcGBmnaTTISYwJz+p1rf7TeZMHvu3HCC4HEvf84Aex6iOcflVYjc/HEH+a9ThpkQt2UVjam90JEXsIQ94s1bMF7kblr+0dUxNKKKk8jbxl7zJhPQ7DuFOTnr8rsCxbuEpSPTTbHZ+bYc2N7UcfvM118U/r4fLgqGc2KvLipufKJUgCdnYmFcWaJVDhCsfdeiQWC8Ucz8dNX9UV0NU8QxSlAQONnp4e/oM5s9uD1EyISwn1T9ub0O3YSxh25qTCocE46/IlZmCl9ZPEfBu0Hm5Ra8lX9Sb1JDAgItO4IPmtQ3/kKiFGcFTcDERIfxZNeKP40zs4vx+AnGwXgUoeG85RxNNf04Kda0XTjAdw5d7kEKvGQ3HYMEaqHG9mQjjZ6rXBuX0PbwuddGQBXFrD5MvG7SiMIaEx9hQ5VwIFhJOrs+zIFXc236Vfj+LvD2tTQQIlH2t0Af/LlSZdx//nit2D+JJdvtaWhU2NITc5Xhk3kiAY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f9698a-fc99-4b51-819b-08ddda6edba7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 13:39:42.5525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36jg1LaZP/L92f/oxiIyQ+FA5bQabYtjtYoa+eavtIzi+/b0E36C3fo4sWrf1UayVLDOzixeW7h4BXvaAlENSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130128
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=689c95a2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=UYu9vy9iKSHKRbyFLmkA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12070
X-Proofpoint-ORIG-GUID: VbFka8QUa4tbRQ_fD2PH-teAD8SFfXAh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDEyOCBTYWx0ZWRfXwdXxt6HTVDGl
 4xqRCwMxesFs8bPAiZyKu5Wb6d/wBAh8dvRf8bJq1cg6ABr4bMh4OvwMmSsxVprcqqdUOH+1PQp
 yGzcIEM3mBi41ithqyWC3sWFts7QHSOMh5us7RAyQ+MeLk3oOvrP6vLe9UPw0wzrmmDCm3PRgEf
 r41svQL/8s6v/tLHm4YWcIen1cq6LTNgxhL7bc7Itn2DDveoGuRPJFgfQwACHPkiI00todtkhyi
 AJdOiGLPBcqiI1fYFw8mkTgR4uxC+wS/KUMiN9ArWst3ZJDC9OCYK9G/eBeIWovbc9LGOFN1evB
 HhBIl2cY6K6HkpAHjvJA4PYN8w5t4+wsx37VtoVeJR0HrmLvg/5O4YMkiG7Fmu9UbwCnGTUzQbB
 E1sZTsrRH1oafvmpeU4mWRG+pkTQ1egAlWWFpG6UR8glYY7AN7pS4qFmb/I/A29dHQvW6YSn
X-Proofpoint-GUID: VbFka8QUa4tbRQ_fD2PH-teAD8SFfXAh

On 10/08/2025 14:41, Ojaswin Mujoo wrote:
> This adds atomic write test using fio based on it's crc check verifier.
> fio adds a crc for each data block. If the underlying device supports
> atomic write then it is guaranteed that we will never have a mix data from
> two threads writing on the same physical block.
> 
> Avoid doing overlapping parallel atomic writes because it might give
> unexpected results. Use offset_increment=, size= fio options to achieve
> this behavior.
> 

You are not really describing what the test does.

In the first paragraph, you state what fio verify function does and then 
describe what RWF_ATOMIC means when we only use HW support, i.e. 
serialises. In the second you mention that we guarantee no inter-thread 
overlapping writes.

 From a glance at the code below, in this test each thread writes to a 
separate part of the file and then verifies no crc corruption. But even 
with atomic=0, I would expect no corruption here.

Thanks,
John

> Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>   tests/generic/1226     | 107 +++++++++++++++++++++++++++++++++++++++++
>   tests/generic/1226.out |   2 +
>   2 files changed, 109 insertions(+)
>   create mode 100755 tests/generic/1226
>   create mode 100644 tests/generic/1226.out
> 
> diff --git a/tests/generic/1226 b/tests/generic/1226
> new file mode 100755
> index 00000000..efc360e1
> --- /dev/null
> +++ b/tests/generic/1226
> @@ -0,0 +1,107 @@
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
> +_require_xfs_io_command "falloc"
> +
> +touch "$SCRATCH_MNT/f1"
> +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> +
> +blocksize=$(_max "$awu_min_write" "$((awu_max_write/2))")
> +threads=$(_min "$(($(nproc) * 2 * LOAD_FACTOR))" "100")
> +filesize=$((blocksize * threads * 100))
> +depth=$threads
> +io_size=$((filesize / threads))
> +io_inc=$io_size
> +testfile=$SCRATCH_MNT/test-file
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +
> +fio_aw_config=$tmp.aw.fio
> +fio_verify_config=$tmp.verify.fio
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
> +	[verify-job]
> +	direct=1
> +	ioengine=libaio
> +	rw=read
> +	bs=$blocksize
> +	filename=$testfile
> +	size=$filesize
> +	iodepth=$depth
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
> +	filename=$testfile
> +	size=$io_inc
> +	offset_increment=$io_inc
> +	iodepth=$depth
> +	numjobs=$threads
> +	group_reporting=1
> +	atomic=1
> +
> +	verify_state_save=0
> +	verify=crc32c
> +	do_verify=0
> +EOF
> +}
> +
> +create_fio_configs
> +_require_fio $fio_aw_config
> +
> +cat $fio_aw_config >> $seqres.full
> +cat $fio_verify_config >> $seqres.full
> +
> +$XFS_IO_PROG -fc "falloc 0 $filesize" $testfile >> $seqres.full
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


