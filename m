Return-Path: <linux-ext4+bounces-9859-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E93B4A454
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 09:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211EF163577
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 07:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D616A236435;
	Tue,  9 Sep 2025 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W0NGMpTB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oCmI8UCx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099A1172A;
	Tue,  9 Sep 2025 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404570; cv=fail; b=RdeJ5rj0Ih9ngy7RcY9FK81ihbwKB+SzeQUehp4V+1jjwGA1PVPgRmQkcFrMjeqTsicNKA/M4ShKGd0xj5UHWG0Iim3QDAaUZaDbmHxJ16am0JeBGvWsRUiInBe5MdSFf55NKdQmqI94DUI/zsHW24/C7Jz2omni3HMopDNPeVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404570; c=relaxed/simple;
	bh=wUYqnu2V4B2FHDXcbiVQV5LIRaRP+zJQ748vnslvCpE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QTzNehscI4+vJUfhmGegqyAsvZzvDzBSPXJMhWjlu5UBDi+dbphoXVGBvjyfugCc9gQTpPXRK6ZkooSpusIStoU331vCaF8tffl3m+T986WOERIE0Y/H3qVH3hBu/d+e+pSoNtrxTn1DFbHiJOCKFqzEvf4LmPd6WYeXqB5dews=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W0NGMpTB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oCmI8UCx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897fo7E027361;
	Tue, 9 Sep 2025 07:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oTmwvwfEP7T7ZyT/DFKchqn3WibdeRq26fqJZbjcAj4=; b=
	W0NGMpTBr5YGUl2ztaFN94b0HNAS14FAQxzle+iypknlEqoKjp71BC6uiy0CH2U+
	t1gBN/Dy0R8jbQXJClIYprvGuAR1/4DWdafFSX/BTue5dcE4cv5SZ43cMIFdT0Kl
	eDN3n9jWWHdOZUGo/P/9vlYUiS1/KBxA8fEZ/tAy0yRFVf+Vc6UmHZ3nTP7e7AJW
	t1ov7dgBpI6NvDPwuxUV0OCQuA6LN08b9lDRi1+WONSb4gAF7e9jhb8mxxoUNqh/
	SoBLqogoci4YmiFN8FhaCwbIkifmEF9wpDUKN0aGKT8a1cyZa2zfJvyV2LburP6G
	lLKzz473EL7uye/RB9Svrw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226ss9ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 07:56:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5896xokX003088;
	Tue, 9 Sep 2025 07:56:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdfs9qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 07:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVO/zfo4M9Wsid7koWhY37LfuShqKTFUT+xcbZmR9V2Lv/rXpbD0b8KYSPDS+fjIZa08i80YVeAdgFryRJT8doQJ3Xj1lMc6T8NXIOSXD2r7BzeyLPjusddU75ff/9/jhOkcsxEE40tdBOFMNBypzxUQFWgH58icjYdqvT01uE3v/cOu2KOX/82CHJkxi0AlEZ1Glzda1C8t0THx4LX49L9UD0jI1RJDdhzbCvXlLnWy0IqbyYzcUIrL4KBZmwDA5zV3M1lxE5n9DNJe+Ix+zDLI4PWJteYEUSfXR52w7UnJeblOpsRBRyB14Wcv9ywQ7HBr44TyNI6yQx8bjTtVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTmwvwfEP7T7ZyT/DFKchqn3WibdeRq26fqJZbjcAj4=;
 b=lHun45r2+20h2JIfaq7/OKgO0BI6RdAG9mdWkE6toNN2IdEfJD5SH7HIuJ5OZYHZ8mXUH+94gh8+JKeNMPcKH5qke6OUvsg92TVsMqHIBFixpFCc1bqBnIdPqMSESZfq0U+5leK5bWFuhGirN7a5C8TUE/z92zJdfHT9MAFhXu4OaRpjjA/UsxdXWAB19IovEtHVOn7ehu4fX/4/ZU4UyqIfmPHyD3nOwvFsBmrFpJtkM3JP7TVhe92zEG54BBL9SrZtJ2oDCKyOzcHCF7XkREM6wlgnQC/FRNjBqcRQp5esngPy2DcyqLqTUCctsxHxnUftO29gh6cNamtCclmbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTmwvwfEP7T7ZyT/DFKchqn3WibdeRq26fqJZbjcAj4=;
 b=oCmI8UCxc4q+DFbvDzcSrSvGyrgWza828zWD95rJ86AhynOaVLjov+P2ebH8eL2E7idCwIuhwtBdXtfsOiNpdNRQNAKFc/lRg6vpomCF7TFf80drMcU4OZySV1WKF7fwYlNb4qCmyCIUeGWZx8rPwr6wyu0r3iTL6KbCayEC1w4=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ0PR10MB5804.namprd10.prod.outlook.com (2603:10b6:a03:428::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 07:55:57 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 07:55:57 +0000
Message-ID: <6dfce0c1-70f5-4f96-9d1a-e8cc680354ba@oracle.com>
Date: Tue, 9 Sep 2025 08:55:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] ltp/fsx.c: Add atomic writes support to fsx
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <8b7e007fd87918a0c3976ca7d06c089ed9b0070c.1755849134.git.ojaswin@linux.ibm.com>
 <e2892851-5426-43d3-a25e-be9d9c7f860a@oracle.com>
 <aLsP6ROqLqhdbLZz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <448079fd-ac31-4a6e-99f8-9021c0a92476@oracle.com>
 <aL_PxUApMCyL-6K5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aL_PxUApMCyL-6K5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0133.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::12) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ0PR10MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: af103162-1543-4002-638b-08ddef764f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU1MblgyTDRsSCtqVUtBSG1jVGpUREVCUDJjdXluRnBSSjR4aTZScmVubkNI?=
 =?utf-8?B?UHpHd0I0TWo3a2pvYU1JbEdRNWNpQk8vQVFnaEVRVW5tSTNQeUNzdjY3OTJo?=
 =?utf-8?B?bUdhTGhDZnYreU4zcWN2bzhwQXlJK0lyZlE0VEpFMkg2MjN6ejFEck1IdUg0?=
 =?utf-8?B?Z2xLa0RzUERTYXBURUxLR2UvOGlZdjdYNVBXcnM4dVhNWTM0d2VnVzdlMmor?=
 =?utf-8?B?UGVwZWVJTTIwaHlBU28wdUcydnZiOTR4RFp3M001c3l1Q0g1T1hXU0V2SThI?=
 =?utf-8?B?Ynp3NkY1aEx3T213VG1YUTI0ZEtaWUtwRk54Q0FpS21iR01KdE1WUkVnM0g1?=
 =?utf-8?B?bnR4SE1ONlIvaDhzbkgyL1Z3Y1AzdEpXR2FYZGROMDZrVzEveU1JVnN3NFd4?=
 =?utf-8?B?S0MybGRpdmZVTzUzSlpNWFJ1eGk2cnVRUE9USTJCWmhNaHFRM3l1MUtMNzJl?=
 =?utf-8?B?Z2hpNXA2ZThvL251eWsvT0FLbEJWNEExZ2VZTFNRczlSb2xXdWJvL1AveFA2?=
 =?utf-8?B?dURNdFJ5aVBENzlRUXNOZ0hUeFBmU1RaU1A1TFNmTnVJeE5GanZ2QXo5Sjlv?=
 =?utf-8?B?UFNyZFpOYlFYcm5HODN4M1Y5dU8wYmVqTlJHWW9CRjV2dmNwbm44Tkt0UGxN?=
 =?utf-8?B?Tk0rWEtRc0FUQnlCd09SaUpLY1VCSUdJSlBKNHNNR1Znc1NtTmJsdEJvaFM3?=
 =?utf-8?B?d1I5cUNpUWZTMGkzclRlUnE1aW5UMmR2WVBVamY1SmtGMWs5Wk1KbS9rRDMx?=
 =?utf-8?B?b2xpV1EvYmZvUG5DbjBBMUZpclNNV08wMElrVnh4MlM3aTdkY0NjcFhqQnN2?=
 =?utf-8?B?RWVUTzZ3VlVnR09lajVJY1dXR3cwcmNRa01WOWhLWEZhYXEwM2ZreW5LS3Nk?=
 =?utf-8?B?QzI0NU1zbnIrVS9UYjFTTzQwVGN0bGxZRUU0RGgwSk0xNTlCcGducGFBSDZB?=
 =?utf-8?B?b1RqNVlEVTJxY09mblhRbVV4MlBSTVV0MnE4WmlaSUNwWHY5TkMwNll0NFI5?=
 =?utf-8?B?bDh6SGhpZDFubzJBeFN2Q2FjREhqdVlNT3IzTmprR04zNVlkRU1pcXVvSFU2?=
 =?utf-8?B?YzU4a1pqUDBMQ0U1QXVvc1d4eG9iN3duUVdIdmhmalBReC9HVzV3Wm5ya01q?=
 =?utf-8?B?eG1aVjkzb05vT0VDeEpBczZQQ0V3WmJsdUtzUEtVU3RhYXB3NjVPQ1NkSzRx?=
 =?utf-8?B?dU15am5CRFVIQ2hScFFXM1hQbWF0VG16ZDdCWkJDYlVLS2VwMkxpVkpyNmlW?=
 =?utf-8?B?cjdvTnE2eEk1TWkwYURnOWNJcTBKUGVUWU01Q3JNaTdPNkJxbUVLdUV5MHlv?=
 =?utf-8?B?ZUk5UTRnNEdlQm9WN0xDWUJKaEV6OGdyN2YxVFRCenhJOWk4UkVYNE5XWGVR?=
 =?utf-8?B?UzQ2N3BrbzdpeWhVL3hyelNxNUdZY2tSTjVPL1d4eFdXZ002eTIzSHZrcUE0?=
 =?utf-8?B?L2RMQld5MW5wVXVxZXRGblVZQk4vaHNDaU9EWW5TTUxmWjdWOStjMmNsdVJy?=
 =?utf-8?B?YzlYTEhneWZDYmtIV203ZjRzcTg4WkxxNUlNalVleFBHeUtSRTVZNWtPSEdp?=
 =?utf-8?B?ZUFEQVVuYndRMU9kZjJEczBydG9aVGpRVDkrb0NQSDBydGF2Rm1peTBYbldT?=
 =?utf-8?B?WW1JZlFMaExnV3h6S3hqaWFYVmpCVDNaaE11VlBsTUNSRHlCR3k5SVYwK1pU?=
 =?utf-8?B?R0g3UjkwOUFkajF4N3RXeFpkakNXWHJ1NTJCZ0ZTUGNKVy9QZUNOS0VoMktw?=
 =?utf-8?B?R1g0VkIwOHpKRVQwMDJLVnQ5QTZlckhJU1FvZ044cHBVbHFUcE91eWlYY3l0?=
 =?utf-8?B?anZscEU1bjdUMmVkSGpoeERYc01sb0hZOUtGRVBNS1llQkMrYUZ3VTdMMUJ1?=
 =?utf-8?B?RFY0SFVvUjRtek5oTHpZZUE0WnlwY2hnbzdwY2hPYWUxUmZ4MWRmaWJKK3g1?=
 =?utf-8?Q?bEsyn3EpJhQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTBNa0d5a1d1U0pDZWxDL1J3MEVFSFBQc3lMeENyQ1dGM2p6TXpMbEh2U2wy?=
 =?utf-8?B?VUNLSEw1QmEwd0FCMlVNQ2UwUFFsMXN4RkFSUVNSZll0b0Q0aHg2a21Pa05v?=
 =?utf-8?B?RVVoNEJqQnBYaWYzQnZLK0NtSEZzQlB3bzlHR1EzRWpIRXBFZWNLUjAwL2wy?=
 =?utf-8?B?ZFJvVUkyaGcvSk9SbHg0bHlyUWR6U0dPVUljYWFpenVmNTIwNmh2cFBvdVc4?=
 =?utf-8?B?dDZkcVdEQ0RXUEx4ekdRa0RtMUkrMTBWZ1FITzJLd252ZmZtYXp4aXExVGhD?=
 =?utf-8?B?Ymx5NXVXRXRPTzFnSkFsM3diYTRNVFZVTldyekFqVU0rejRLbzJYMkhXVlBr?=
 =?utf-8?B?dVg5UmNLMzQ0UFdyWWo4OWpGbDlKSkpLazd0Wk16d1QxK0RkeHRub3Nld3lN?=
 =?utf-8?B?VEVIMzdJVUVaNWZqakhsMVpzY3dTRDNEQ1ZYZ29XV0dxOU92N2FpR1FtQ2dy?=
 =?utf-8?B?V1EyYmo1QzVSaTJ4ZTdGZEpIRTd2R2thelJOMFdvUWhjKy9WMm5pK2Z6dHZl?=
 =?utf-8?B?RlN5Rm92dDZ0YWpGTEphbXlxdFN3TXpEeGpiTk80a1pDSTNZcDEyeEhDdlM0?=
 =?utf-8?B?NDJxaHR2SVBvUmt6THlkSUlTekpaYzV4M3YySUtpOUw4NjdUOWhlSGsrZ0ph?=
 =?utf-8?B?TkV2NWJJVS8rUnBxaUJ4cXlYcCtXM0xqOGw0TTBIeFJhdEF1N2h5ZjhDNFBh?=
 =?utf-8?B?SGhCd3NlbU5IZmcxNEJWQlZiSmZFVUxGc2VVRlhyd2g4cE9pNWZjbDVCSXZS?=
 =?utf-8?B?TWxzZGVleG4rc0ZSNVpieFM3QmRUWXR6TjJCZWR2ZGs1K1VmZUt3OGdoUjZQ?=
 =?utf-8?B?cCt6eWlNWnBSalZlRWVBUlpuam1HTGh1bTkvZjBuSEFmYXhVTnlpRUFndlFX?=
 =?utf-8?B?UUY1akxCVXJNbHhRWkQ3cjByZmJveGJnMTIxOG13cU93WjVhKzliUEZWckh6?=
 =?utf-8?B?aG85TCt2cnJQQ0gwM2xWUTZYOVZSSWNWNi9WTnMwa2lqa0hOUU9oTkRBWXFl?=
 =?utf-8?B?bHVjaXNFOFRXQmhOZVV3VTFPMnVFVVExY0V2ME03YXBsSmFFTEFoem1va3hR?=
 =?utf-8?B?d0M4MVU5SmlpVnkrSGlJZ2tyckJCNDM2d1FJeDVXUTQ3aW9vT2ZUcUNjRTBo?=
 =?utf-8?B?KzFTWXJDcERNR2pXWXJFLzd1TGo1RnNnaUViQVpGcUQra0x3VWgwektOOFps?=
 =?utf-8?B?QS9ITSsvK1dMUDg4VVNWMTFWRTAwSU9MeHg0ckN0bFNWbEhzZS90c3A5WHhq?=
 =?utf-8?B?akg4elpVTVZsVldWNDE0ZmhBOXRsQ2YzSjQ5WjU1dlhwUWJCYzNraTlkZ1gy?=
 =?utf-8?B?b0NyUWRyZnEyOWtSL25aUFFGWmtRVnJDWjZRS3VRTmpCTWJ2TlZqTXNVNE15?=
 =?utf-8?B?NnlmeFZKa1h1SEtvTERsTWZpTkRVenJ3N1UxWm5sNUVIQlVWZ1VPaERkMkJB?=
 =?utf-8?B?SmszcVRTMXozVzczYUxwU0ZyM0NPQ0ZiNTA2WUNyVHF0Nnc3SmkycmYrbFJZ?=
 =?utf-8?B?NEhhWGVXS0VCMGZpRVZrbTJVOEFJZVV4Nko2Y2RFVm00RXdzMVJ3aFk2Y0tv?=
 =?utf-8?B?OWh1WEVvc1dkdEx2ZkRoTGRJM0loK04zeU9pVnlOR0lDb1pyMlQzTE1zMmxz?=
 =?utf-8?B?MWh2ZDhPQWFzOWE2KzVmK1hWSUdtL1Ftdms1SDBjc1FFZ09TOE1aVGdnK2p4?=
 =?utf-8?B?RUlDK2p0VmFYaUp4eFJvVDdJck9WMHA4YnNNbE1oQzhJRm1aWENzbHNiMWZn?=
 =?utf-8?B?Mm9wYTdxaWZnRnQwMElwZXRBR3kvbEZCeUtlUkIwMWZ5TkE2aGdCM1lUS3JN?=
 =?utf-8?B?S0s3WWdJZm1rMDlHc3QreXBPQThneFh3bmNKTUFzOG9yOVcydjE1cXlWd2lF?=
 =?utf-8?B?WTYwRG84U3FIRzNWcUZDTkpWSHBzdGljeEhGQVQ3eWlaUGI0NG4vdzlDWUFi?=
 =?utf-8?B?RFBIak9TUHhQQ0lSUHlreS8zUW9TMzdaeVdXNWZtVGxKTEFrRkZEN25lVTkr?=
 =?utf-8?B?RWRCN0lDL2JPVDA2N3VpZ1pTd1c5RzJMdlIrR1lnU252bVJ6RmdqTk9lZTg1?=
 =?utf-8?B?NHdIN2p2bEh0NkgxZWk4NWV1WjFVeGlQVVROelZNeFd5ZHhDWEt5RnlpQ21G?=
 =?utf-8?B?OFlUUmk5N3VJZUlCc21FbElQbE10a0JDMGZkMDEvd3g2NUtiVXBDVGR1L3Fx?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k+cQYGNhTQ7pWjELgXjCDV5cqqTdN0+94okvQiLj1vn+MUMS70z6m5FE6wkrdNrzfUmYGA6wSDZQYVcv+zPYzurKeBBxDc8vj8KX0ODzLb00jUV1OwQ6dT+YPxjUWaUcXP9n60wIIypXYdLkq53oK+qOxkWzB3p6ktNo8ZxYtrrCTugP/MuxGRb3Kz/jE2JEtd9TT0FGFrTS1Mq6uthYT9y67gORXAJEWb0+IZmE+jHlB8AcovVwGZQQkBufSxA3+nyXaT0ccRF3GbMNSk4NeR6zhFg4MqZPnt27geZGYCX+K02+x98rswkPaEfa3V13voRrRrrtW/iPnCgBFOeIgIwXhKq5i0dxwyNo5vBAUqieOe+GJVGukKzU9iJJuIlUNLh6efoa5d3dHtt3llVjpaC3GGQ8OFXC1dhtkG+JpiFGRRHhqbq/09kegyxRDUFzP+HzwWb9YElZMawWpVLMEbsMAZVYt30ObLguXcfUmaH5U7VF1s+GK2xShmvjD0UQyYLLCQPaSQodaQc6lBJRB2h/PdK/4giXXwV4aAWt2Iaenog8w8dUdahj2gd3T2xCQMJiA6eUhRksdL03go7qt2mTuWVBjCPiSl52wvtEY3o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af103162-1543-4002-638b-08ddef764f64
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 07:55:57.6324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vAfu0jgfEVIr4D9zYdwPtGxRebwDhx/HP9Zdz0xmxUzyi1q+IlprWNkRMZKpMako2WCHaAnLanX1AVmqeH5PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=994 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090077
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68bfdd90 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=NjqoviUAa51NLNlWRTsA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12084
X-Proofpoint-ORIG-GUID: z-Mdb-ukSXsc4tmDGyDT-b-P4op6m3sF
X-Proofpoint-GUID: z-Mdb-ukSXsc4tmDGyDT-b-P4op6m3sF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX61vJFf6b0zXK
 ls93JWFQWwvWjVmxeu8l62rL0H+CwO9VZE90GWKMnFT3m0cTpxIjHzf3hY1dhJRq5PQkHXO8E7j
 Vxf2Sz5koNM8FubS6xoP2zywMohpzKKZ9Zh161Yac7EsaPV69WlZUv1YvLZ13z+Zble2eNArui0
 /R8/cY1C2yMS7Uabw62+vgKA66DuMPekUk2poMSR95K1HFKUyeGElmevJ8C+PayQehkz3/FpXGd
 +1omcE8en3XGxlap+ztuok63x0WXFVzKRljvSeK+rI+IZ9A/iP9Kmc0awu7umM5X69/dFAhpq1q
 n1Q/etwoFuLwfjuGVsxdrL7ogqIR7gbaCGoihQX+guyvr0OCH34j05b2n7C6FU7/zgTOqAzaAmR
 R5mQManFbMLwYZQZ2p8BQ+x994gfeg==

On 09/09/2025 07:57, Ojaswin Mujoo wrote:
>>>>> +
>>>>> +/*
>>>>> + * Round down n to nearest power of 2.
>>>>> + * If n is already a power of 2, return n;
>>>>> + */
>>>>> +static int rounddown_pow_of_2(int n) {
>>>>> +	int i = 0;
>>>>> +
>>>>> +	if (is_power_of_2(n))
>>>>> +		return n;
>>>>> +
>>>>> +	for (; (1 << i) < n; i++);
>>>>> +
>>>>> +	return 1 << (i - 1);
>>>> Is this the neatest way to do this?
>>> Well it is a straigforward o(logn) way. Do you have something else in
>>> mind?
>> check what the kernel does is always a good place to start...
>>
>> Thanks
> So kernel pretty much does same thing:
> 
> unsigned long __rounddown_pow_of_two(unsigned long n)
> {
> 	return 1UL << (fls_long(n) - 1);
> }
> 
> where fls*() variants jump into asm for efficiency. asm is obviously not
> needed here so we use the for loop to calculate the fls (find last bit
> set):
> 
> 	for (; (1 << i) < n; i++);
> 
> Ideally the compiler should do the right thing and optimize it.

I think that some versions of fls use builtin clz also, but I am not 
sure if that (clz) is always available for supported toolchains here.

Thanks,
John

