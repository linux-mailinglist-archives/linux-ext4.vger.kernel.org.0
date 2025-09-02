Return-Path: <linux-ext4+bounces-9796-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82900B409C5
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 17:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BA65E2929
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD62B334372;
	Tue,  2 Sep 2025 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nYzJJ4X/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cDVxoKJM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC12BEFEB;
	Tue,  2 Sep 2025 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828356; cv=fail; b=WyGys+j8FsxBNXTMNrwITRr5zzgADOUUmmOgDy/eUxQ9vHCdVQZY/TlRBWVta80S+xUeSBiBzmvsPeWyWIcA7sNlWUOOC4t/lXGuKntHePdI1yx1hplVNKyFQ4LRLvqR8NteaPHrfhJdQ6Z4ogELb/eWHQZNoZgiw4zqpRB4WSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828356; c=relaxed/simple;
	bh=RmcsrXsgyH27zQB3VqLXlxAdDUV6pp+4qoURpi4v8vU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gYYpCzKMPk0PeXwGL7htY4LuJkVH9WcotZgCo2HUWLxC3WR0CSKx7scUyafoUT8GrAw1lAuSpW8epTQGGQ5y+Mraxo9xzs3MyK5Qv1iAAV4C42DEraEodNXJYYqW+FupiDm/ygrkfF2QxNAmUvLd44P36L7dtRQZKL7Wgqdc9tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nYzJJ4X/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cDVxoKJM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Dfrnp028648;
	Tue, 2 Sep 2025 15:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=k5gw+QR9aX06Q2eQf/R8E6GY7ZdtgKeFW70FmXI3n70=; b=
	nYzJJ4X/pUqPk5NP9/AQG/3n5i7Cv9BTkP1b8s7r31Q6Myz/nK5lDixw7AXuLExw
	n+b35Sz16tnFuhi3pWRoBmgzuTcBfPntMr/GQA1CX09Qq2T1wcVDaoGl9wI2Lb7l
	3jTSrnM69ziv/MzYgg5rol5Zl6EUV8hEyKezcKZUrw2R9DBh+V5pu8ioMYuRSJbl
	BiJnBTQp6fMmgk1YcJMo+uoYV8dRio3AM8SSGvWlOT2ayDOqFxvh04XuYM72AYTR
	7TYyka6SXHR5/ZY6zImELzJJxG8IIh7OR787bx4+ySl4yBeI2ZQosLz+hjE9Z4PQ
	2IhYDJwrVGSV9C1kJNn1ug==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmncd3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:52:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582FAAB4031043;
	Tue, 2 Sep 2025 15:52:25 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr9bf4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:52:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dm/VUQdEb4rBuUtwqKra/enXMZZRuTnnMQ9TIV03VNfuVHAwopOgq7XSLWar/BxcYRFjbts6Uz7FUizuCkD+T/wK5h6QOpDGsi4sBwMxjFNQw2UWtXC3BMjoD3RCwiZUXD3lGzNEs+PqxJosnvCH4PdX90jnui2u2S8PKDrC+CqCtztef3YUoaiDQsa2+p6MBVt7HfAnPBlqp/ec4HPV1FG0k4HA5Kp3ks4NrJm6WSPORIafMDG5KLwo6u0ypgemuugSv9DBDuYsaQEGzdZ+7M208KNdHc9ki/yqxTKie2fNqjXdrZNlwGAlMI1H8Bvj9oDYhI9wAcy+Fzda3qooug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5gw+QR9aX06Q2eQf/R8E6GY7ZdtgKeFW70FmXI3n70=;
 b=LgMnTOPiK+nX8PJHC/+sytXRKqTiGdiTihApNlpLx8tMlXJ+NPDwj/LDjfJtO+6ylhhqX/GH92ORLV2/Y95+zLufHgn294e8zr9iHvJrVXAcFsftJlRQKOPPJfXwv896xh4f3FyiqVu71ZMJxtCwkWLL432hxl3OGjvYsTa6uTdf1JkUIAGKztNyX7kULj/7BRMtH+IGdOeYZQvwY4ZbVm4MOJF2Ax9S2WtipymeKmMSt6fMvLM+B+FpQkGpooSJxYKwogBE/l7xe1ekCzlJSfz7uYKDRGxlIknRMvhWFRQNgHylLNNhC3+EEFPz5BeMR1fUjQ+8aH+NqrLb+dMw5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5gw+QR9aX06Q2eQf/R8E6GY7ZdtgKeFW70FmXI3n70=;
 b=cDVxoKJMQYg0LAEdYueH27ba9rEqumIHqyhHAbrtYR1fOf0xUMKr5ukPWYx+6R5oNIOEd98UlDr7cNDnAMBDd6EAWdemL4hyy14AOATd8v9baTeW/0V5FGc6prTpXVHLa2/lPzHPwfWz0LAvznKeg4THaHs+00QpJDObL42yqQc=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DM6PR10MB4298.namprd10.prod.outlook.com (2603:10b6:5:21f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 15:52:22 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:52:22 +0000
Message-ID: <7507dace-b789-43a5-9a5e-5bb79fe76120@oracle.com>
Date: Tue, 2 Sep 2025 16:52:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/12] ext4: test atomic write and ioend codepaths with
 bigalloc
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <5a39bfbbd73f8598e9f85fb4420955c8a95c78a2.1755849134.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <5a39bfbbd73f8598e9f85fb4420955c8a95c78a2.1755849134.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::8) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DM6PR10MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e3c350-f20f-4811-739d-08ddea38b479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czdMVEFUNTlGRHNvU3k2SmMvVS9hR1Rlc1VaSUo0OHFGOFNMMEZ4a1hFOVpt?=
 =?utf-8?B?WmJEL0kwRVNuNnhtb1ZFM0lrNlRWWjJrdFJ6TjNnQnJ5KzEwNEVuQ3YveGh2?=
 =?utf-8?B?Yzl6T09FTUNlRmNtQVFCUE5PQ0FCNHhyaTBwZk5WZXIyYlB2OFlmc3YxTldE?=
 =?utf-8?B?ZG5wUHNJZDFuVEV4Skh6Z2NxR3crUCtmcnhPdTdNLzdlMVl1Ryt6aTZDUy9R?=
 =?utf-8?B?M2duNytKSkJZcURad1hwdkw1WnNCMkQ0MnJSNHdUSzJmTVArdHdNbGxPQnl5?=
 =?utf-8?B?TFdnWU8zWVhiWmJGM2pnRlhuVWwxMzcwUUVVWndyQ3FjM2l0ckQ0RzgyRnhz?=
 =?utf-8?B?SklUalJMYXh2L3Q1NXZtSmlYQ3dWc3o3U0lvbHZvQS9YRnlrOGN4emlOMC84?=
 =?utf-8?B?aHBmTkNUSjBVSFcwY2tuWXQ4Rno3UjlmK1c2K20xQy9qSUp2aDIwVENwTWRn?=
 =?utf-8?B?c1pqd2dvSlFMV3R0eFZSaXpQSEdESnVHY2pVbWpiZjBzODN0YTVDTHZYcG1q?=
 =?utf-8?B?aXArUFdpVTB3ZDRVWG1xT2Mwc3BoWHo3MytPL1VFSy82Q0FPNFgxUnRtOFVI?=
 =?utf-8?B?Ry9WU25BZTNISEpHQzZlMERYbHF0M0hOaXR5c0ZxTElobXhXcWc2TkdBNGt0?=
 =?utf-8?B?em1CbWxMSjNFTFFNVDFkVk1QWEgzL2xxek0zYllrNWpxL01FVGh0WmkyUFZP?=
 =?utf-8?B?clJvRjJCdEFubnJKbzNhbFFhc1F4cmRGYjN1TjhCbUJ1WDV5TlR3U3hzbVpG?=
 =?utf-8?B?akZlY3BIczg2MzlMMTBmNkZIU3Z4UUF5M2Z3djNrOXhvdVBJclRMeEhOR284?=
 =?utf-8?B?K0loMktNTWtCaEpENjBSTDFaWFNScE9pVU4vZVRjNnJsNFF6bXd4T0U4MVBI?=
 =?utf-8?B?OWowS05hU0g1THl6L0VGN2NheU4rbWl4MjBiWld5RVcvUTIyMFJEQlVWTFZH?=
 =?utf-8?B?RzU3QXRtZWM1M1NFVUZCTDZ3VytBdmMrTWRFK0FodTA1Z2NXRFJZeDY0ZjNX?=
 =?utf-8?B?NzBNSXI0MVZXTkN3aDBIcGVJYS9HNHgxK294OTZ6NnY2RG9kSTM1N1VMM21w?=
 =?utf-8?B?LytoR0JQM0dWdytNSjRJWWRldVdnWlczMXZpWUlnemZBNkdhdFJmSmhlaTNW?=
 =?utf-8?B?cDZld09HRFM2WlNGRE1wWlhqOXNZcTlQUVphbTI1YzJLckJQUmErZTZ2eEli?=
 =?utf-8?B?MDYwZnlSMzhzU0I4SjlnODQ3T1ZOdHdoaXYram1wN0w5MjhZY29mYUpEVUwz?=
 =?utf-8?B?MlF5ejhoK2VjRXZRN1dtR0lrNnRiZmY5RE9hZG1vQ1IxWWhaY0dRZWxCM2RM?=
 =?utf-8?B?S3NLZ1E1a2hSZWxGK0FhTE90d3g5aGdEQ3VVZTlZNlQwazdyZ284UHI2aVBB?=
 =?utf-8?B?KzFFS1NTYkd5cFdQeGVFTEVlRGw5L3JKMUxaTVUvSmtzdXNCS0cxVW4vdkxB?=
 =?utf-8?B?c2tNRzhXdUwwUFkxWFNVMGpJY21SVnNVbkNFelRyeUJubno2TENyTDBrOTlW?=
 =?utf-8?B?bXBsK2tVVnN3b05BOWJ1QkVpaWc2cllUMG84R3hpS2lBZGJTditWMmZvSXZW?=
 =?utf-8?B?cmJFWUlLTGtUcGtVTEdubDdzVmU1RnN3cDZWMG9oemVkZmpoNTV5OE90Njho?=
 =?utf-8?B?S1Q3a1hYNnM1Mk5GNlF1Q1dWN0NvTG9kLzRnbURuTlFEY2pxNWlCM090Zy9G?=
 =?utf-8?B?ZnNqNkhNRDNOL2JCYXNGQzRQRm4zSE9VWnJHbmhHYm0yRnA2N0JrRnNlQi9G?=
 =?utf-8?B?Ymk3blhUNGhNY3NJM3NTSjI0UXcxM3kvRXVmZUQvRGRCSjJoK3VoOU9CMXNC?=
 =?utf-8?B?bVQrYmtiVmNaSURXQ1FjYjh5UGZxWkdMOUhvdjJUejFmdXhVZFJSSjdCY1Y3?=
 =?utf-8?B?eTVqNjNqei8wdUZ0ckcxaWo4VVJFZ1hYVm05VHlIc2NtaG5GVlVRZ2VPSkxi?=
 =?utf-8?Q?APgqNoY9AbU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXVIRWhwTHFMS3ZrdHI0QmFXejhtcks3TXJacWk5ZVZuNmtrS1RQV1NzWmRY?=
 =?utf-8?B?QmtlSjNzeXNWNW1EUHlGZ2hZMGhSUS85NXkrTkVTenVuUkt2N0dLR3k2NjBh?=
 =?utf-8?B?azIxejFzcjBWdW1LTzRUTm0wd0trblFkc2ZyMkgyT2tkWXdXNjM0disyWUY3?=
 =?utf-8?B?WXMxa1NRSlZiaG5qMDc5VExUb2M2cG03ODZOWVFyaUZGWGJ1cm1JZkRMbDBM?=
 =?utf-8?B?QWh4T2JrUHUraWQvZmZqQ0t0NU8rdmN4Y0R5NmVVam1Oa1pUUnV4YjZWeS9O?=
 =?utf-8?B?NDZ1ekRsaWI2ekZPOHhVWW5zQkpnRm0ydHJxS2Zvek5GZkZpaTcxd2JsTytt?=
 =?utf-8?B?bHBJMjlUVGNuMU9iZFZScWVIRjhlNW1Jby9ZK2JJajY2TzN5U2tpTEZaU2Qw?=
 =?utf-8?B?eUxxZmt2M0x6ak9FVENrWnI5NzlrVm1seTRXdnVxVDJRMGdMOEQveVllNi9p?=
 =?utf-8?B?V0hjQU1rRDk1Zklac1VyM1ROV0NLbFFPS2NJUFRhNkJMbkxYaks3YTJ6eEVN?=
 =?utf-8?B?NWRFRUtqN0NMZmZNTW5XemtuRXBsNStUUlhVRVJMaWEybHdLdThOb05VR1Nw?=
 =?utf-8?B?MWpGRkd4aTFGNUNtb2tTQktmcFFzOGMrbHNoV29JeUp1SXd6aS93bEwvZGFK?=
 =?utf-8?B?c1JKWXhzdkVmQUdMQzBidFRFdjVWQ2txVUlUUmhNLzhjUGZTRWZGdThCbWdE?=
 =?utf-8?B?MHRIcXZydjE0bXRyL3huSTI2cWs2Um9OcGJSQTl1NWpKd0JkeklGMFRMZUd6?=
 =?utf-8?B?bDYxVUx0bmpYZWxsZTR3VEFOU2VFN0hpSEh1ZFd5aHUyYVN3enBWdjZxTDlR?=
 =?utf-8?B?WStMYngyeGUwVDIwbnZCRlpDK2o0RXhDK0VsaTlWNktkZ3Vnb2MrZWxhMFZY?=
 =?utf-8?B?cHdSV3YzQmg4ckZ4L25veXl5UGEvUTNPYVVWMFIwR250V3UzM1NtdTRvc3cx?=
 =?utf-8?B?WTQ5U1QyaEZXUW1jc291S2YwS1A0bWdVcE5EdEZEa0RIcVV3enVRSStZZ3JE?=
 =?utf-8?B?WEdEOTNweldPWlNEeTJuRVBpRk9Jc0twb0JrQ3JKWWxHUWRITkt5ZnNZK1V0?=
 =?utf-8?B?SWhubXNFelpMNFB1NlorV1BEalk5d09YL1FJaXUrOTRGSm1PRmd0N0RhK2xh?=
 =?utf-8?B?Vkl0anhRNlU0c2k1TE5oRmhVeUI1UktUSk1PQ0RLVklzN3NHZnIrOUMzSEdK?=
 =?utf-8?B?SFJYY2FIaUNHZjdua1d2TWJtU0F3SU5hc3U3bURUNFhjWXhkWCtaZHlHQlYx?=
 =?utf-8?B?QXludlhwcGd2YWFnYk9MWXI5Zk5jc0JoWVd1Q1Jsa3N3dzU5eXMxSXVURXVm?=
 =?utf-8?B?SUZxd2lGUHZla1NzaFQ5VkVySVlTaDdQUExybzhteGxST25qTTU5akdHN1FY?=
 =?utf-8?B?QUcxTE56d0FnZnc5Z3p6NWwxZGRYU2lERElrZUJ6L0huM01zR2txSlp1OVdy?=
 =?utf-8?B?T2NUS0hHWEpUM2ZlMmFsSUhzMVlMdk5oQjAyT2s4NzRmaUE3VytxSEVuSHBQ?=
 =?utf-8?B?REpkcXRSc0kwM09GSXNubU91OVpTV28rQS9vTFIybDRhNm5aQnIwRlowcmFI?=
 =?utf-8?B?NTRJRUlVbmp0Q3BRb3J1MWJhcVNteVM1SUVJUTRIZnFzdVRVRGh6RTZ2QnZW?=
 =?utf-8?B?d2gvcVE0bm1YYnJUMFgrU3pOVXZvNXZvVDV0ZWR0ajVxcTlCMEgwN202R1Nr?=
 =?utf-8?B?UUFjVmdSdndMeTI1Q0hSMHdnZHgwKzdZZndoa2pWa1ZHOUlNTlBGRjFmRkxa?=
 =?utf-8?B?USt6VTZnbWdtZm0yQ3h2R25ldVRJS0x1OENqNTl0bm53SUQyTXVOS3FKU3B2?=
 =?utf-8?B?UzRrcVJPL2xWeUIrd1g2cUVvRjBEOS8wVFB3RzFDK21JZXh4WFBacER6ZGpu?=
 =?utf-8?B?L1BIekZxMlh4bjJHQWJCZE9Oa1hQbjMzd2hqZHdJeXl1emRGUjZuSUo5dWMz?=
 =?utf-8?B?SVdybG5rck1GNmNyWm5yZUdZdDBKQ2I4eEVscjBpcmJyTkhrdUlEQUdOSGxy?=
 =?utf-8?B?TG92dXNPRDI3WHk1RUZJUGpWWGhwTHpRbW5qTFI2Mm9oelNLcCt6eEo4UGU5?=
 =?utf-8?B?aTl5VjJ4WFJWWG1waitCaEdjZTVaQnlXNHNISDJSdFdCZDg0dUJhaGNCNkdr?=
 =?utf-8?B?RHpPZ2ZZeGFQNStja1Fvd1JkQUxMZ2JEejVuNnk0SGFuSHRzTkVwOUVqU1JG?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1272vL3/r3UTBw9YoYIebno+jUmHXRjtfQFBvpLTxcKZ5CuT/07a7caTBx6V1CjM5+VFU3d3Yqe7UDxYc68rp+CZr0vh03iU5LLs90Qz5qrl47U22N5Z/pjUb6Ri8pE7YXyQSlbHALKpjKMUU/fqB5XPkRqGpStQ4Wfq7PT+5xAGeKk+Fw38MHoG+YcPaUzQk41eVnS2uSb+k6+yg3OLoyIixhqTVSsWJPznEj9We+TmK+7HiAQkREi3lguFVbbyYO1xUE2joXf1ZQWYI7x5OlwU04jjT/70wpPPW7C031C0pZyOGsebOxSVbanDd6y9GgUtBF3rfuWjaf1LE7KWArIgiU2NiZE3z5pB9UHVHUMcGyKD5udVtISEqwpMUw6EsXw3KS+UGufVD3fONA0lsi6CU5e3YyKFYW0V8IYte2j4RzQ0k+eAHMU1AHFisCs2pP1gEVPazfqpLmj7L+iTqDsur9+NcM5jQBCOKGDgezhiNNDHIMgqb4AfBWv/0KtL/2GhiOmyAW+TnOZCwlfLnIrjVg2K9VL9ZYIeUiB5OXWSrUbmExf8L9pgu2CL2cGjrrcP/FzUc+sqhXZa4POVbtB78LhTOlR5kK5bnt4iNpg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e3c350-f20f-4811-739d-08ddea38b479
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:52:22.6088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plWIkoxckJJjPNiMr/i3QPNihDYu+2gx2gGmHLMxITZjzF9y8T7itb6pTTQZcyASXvVm37KdGZQJLu0BdXJgEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4298
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020156
X-Authority-Analysis: v=2.4 cv=D8xHKuRj c=1 sm=1 tr=0 ts=68b712ba b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=yPCof4ZbAAAA:8 a=QUzb62DwziYYM7nfpUYA:9 a=QEXdDO2ut3YA:10 a=U1FKsahkfWQA:10
 cc=ntf awl=host:13602
X-Proofpoint-GUID: JQesaz_ZwKaF8m9osOTNZaOXe3J4oQyb
X-Proofpoint-ORIG-GUID: JQesaz_ZwKaF8m9osOTNZaOXe3J4oQyb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX6CjyjFcD23+P
 LpITm62RdBnWhOl8eHzgeeR9bm1wfkVvlme/TdStzqROuMdA0OQwmHf5e6AmtsykWJTp3WsjHX1
 wGfF3gLCXjPgViUCfBLEWI9WqfvAdcra3zagX7pXM5b1vuh4vAVRS+x8IkJn2q3HGKBcMURYiJI
 AUL+0CAdsNzc6M8hM//tvP+vBXxbC5xTCx1ygkcAhEEo75spNnCdnPnQ40ZQ+DPpGIotTDYVxUf
 Y7JfL/K5392ip/RAOfkGDhjdXKdhPJJ0oJN9y4cmg2+nPdxS++bYbnoZfk/eOIExOaF2oZozuTM
 8dVWk7x52PGGXpt0fC4XpfG1x3+fY4WjEex1zX9C98zYuwHNdPiOA9fHx4r6nI53KBhwcolsRXd
 cZktQeWH/XCprcuDe1Amq2vnqyl0mA==

On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> This test does a lot of parallel RWF_ATOMIC IO on a preallocated file to
> stress the write and end-io unwritten conversion code paths. We brute
> force this for different blocksize and clustersizes and after each
> iteration we ensure the data was not torn or corrupted using fio crc
> verification.
> 
> Note that in this test we use overlapping atomic writes of same io size.
> Although serializing racing writes is not guaranteed for RWF_ATOMIC,
> NVMe and SCSI provide this guarantee as an inseparable feature to
> power-fail atomicity. Keeping the iosize as same also ensures that ext4
> doesn't tear the write due to racing ioend unwritten conversion.
> 
> The value of this test is that we make sure the RWF_ATOMIC is handled
> correctly by ext4 as well as test that the block layer doesn't split or
> only generate multiple bios for an atomic write.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>



