Return-Path: <linux-ext4+bounces-9785-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F0AB40817
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 16:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBAC5E582A
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F63346A04;
	Tue,  2 Sep 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H5908fCr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h0r29t0S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0087321455;
	Tue,  2 Sep 2025 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824630; cv=fail; b=S7/IHqHdCqvB0VSxUKzhZ+Cc0wxRcfyzja9r7s4UYpOq+rszXXrZUkRoRRof23YlyLx4NqUs00c0JDFUQqIoJ9Ncw5l4gSRP/GeqAtOmw6QmgDQeBjVvfkyplNM54J7xBQmjjkd6AkqDIi9BFtoDdt4rLFhkIVz/iqtYgRAuhy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824630; c=relaxed/simple;
	bh=kHwc74+zznpu3SbgNTLrNTKxhw7ILYMdmjOFGC7ao5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c3OqHqlUNly38LgWrFBXwQW+eYB8B9Z6zyBS6bhE74FzE+Xo9QcDKSLLtfca8NMyKsBB8EwRyK8PMqFSvzdxLCFNGWM/mG1RQp3/CyZ85VZAyUnZFpJqZMc01nsW2iQmmntdGBMqr9XLUbBK5zXh/9hWA/PVvM61ZiVOlaOebcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H5908fCr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h0r29t0S; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Dg90q023415;
	Tue, 2 Sep 2025 14:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CYPi35oweoKtYSDU8/2Ow1NU+MlG8+q6+OdvU3mFXbM=; b=
	H5908fCrFmP/Qfj9pr7ZabYX/QK5kIuvymx4gIwOfh9eR4ymKhKjZd2VghYmRiB0
	/u69CTUmVxNcDvrPbaSheqcoe6lMkQe0ZgY9zGVtoytxSbcQ2JdML9YP5wKIsJbx
	lRZFBp7GCmxNdfPofmkQvyB/2QYPx49WeXlfTBsA1x071eJYWbM9sB+IqQAF3tkF
	WZyzlNq29t4i3pGgxOX5yAOL4bMqe5BNQQORRo6EJmylPlbLBJJANalTUDWmtkJd
	CusUt8Pwxtqd/hKyShtJ+V1Vj2mJ3m8fSfH4OnH3XSkaigmtGWK5dH/VaGtEU3r4
	4fDoDKGzHNHHIHAy4Au0OA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmbc7ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 14:50:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582DF2VJ015802;
	Tue, 2 Sep 2025 14:50:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01nfn6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 14:50:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDWxNXYgX4AndRZBMpZqu7Kt1KFFKxDi+2x43FJiorsR8C45xj7ZA8jEU7Jg5UImWMj294v/A+WWQOk8WjdtIjFqVEUEEb5oanYDTrUIw7UIu8GuHv3uemLZImC2nDvGdB16T1rV4f3uo5qPGIQhq/p1AUuSAo7XNjXSRW3Jv4zkoYlKL/EWZ+2TMga8nDJqF2YAE4ugELEqtqtwz8Hu62xg8J+14h/I5JMDDMt9xF3+88BOU9COGNosH/KRjvF+jatoeVQyMUYHM/wXgVFl2DOVpu9JQEOZCbR4G48et6+uRie6baSNtKaqDqFVLrF6LnRhl7VwH44cUsW7sMQs1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYPi35oweoKtYSDU8/2Ow1NU+MlG8+q6+OdvU3mFXbM=;
 b=FBUGVMihBsjVDPlsRjzbbX2fsYs1AxbyKvYc3KmE+zp7EkLJvnrl+sN6d0Y/CRlyXRsu28+UWIjVxCwvaGQw/fxCL4kXra2mdq1NiCwzZwdRQlYWf4WZktFYWVyRhGGfqHDGn/zXlbrS6K8TBi8gV/vM63t2Jh7bOcsy/3weuHqVZlJgI0bz6Pzkzm8IKIvGauBVAIb5/DhEBVWIT7RQdHLVGFRZ3ocV8+rChVCxwPsLwCraVikxxvnTT5oqdxKmMSTwgvtd73D07ClqkuJWcFXT9058nDHfppzPvsHqpCExx8QQA6Nc7wQRGdvjhcF02UdWnbaSRwBSmu+QchaLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYPi35oweoKtYSDU8/2Ow1NU+MlG8+q6+OdvU3mFXbM=;
 b=h0r29t0Su0oA8jp3Hqnkh7zHaeAd1z+Rv5ceSv2iUrFFuyL8KexMznjuphhMAlfKkeO9XmemZyR3pLy3hThYyiOAPr36PBqLcpJdjlEvr2cIxmr8oyU0kZW4Picwr+t+4ErNPN79oDFOpcIMk5VnKkvxXqmXcKRnW1pa6WdwRMA=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS0PR10MB6222.namprd10.prod.outlook.com (2603:10b6:8:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 14:50:15 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 14:50:15 +0000
Message-ID: <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>
Date: Tue, 2 Sep 2025 15:50:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::11) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS0PR10MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df28762-7506-449c-940c-08ddea3006d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlRSY0JZRk82YXdDU2tUMHJJdFJHR1pOT3RJWU1waGkzYkVzbXZMbmhIY05H?=
 =?utf-8?B?MWgwbkZkYXJwbFhjYyt0bUUrSlNEWENQNWt5ckdZbm5SL0krb2hYMnJLK3Zo?=
 =?utf-8?B?c1UzOEhyMXBDYkRFd1BwYy8rSkEvcGErUWZYcWUzZks0N0h6SFcvVmczN1Zi?=
 =?utf-8?B?SWIrdG9UZVFCWG50ZEk4N1FiekRpejZXTDA2d0prR2VrcE16MlhnTFBvZzJY?=
 =?utf-8?B?UGdJMm9BajN1cmNKelhLd3lRbmhEVjBJbVk3U1BEcm1YK1ZLTXJLYWF4aDM5?=
 =?utf-8?B?V1lSU0srL2xmUm93R3hOMDNnd1piY25KUW5OM0daemp6ODduVXVmUEtsaEFJ?=
 =?utf-8?B?b3RwWHZWMnl0MWVWNWorVE5CY2l4OElYbDN2R1M5SjdZdks5L2NoZ1dyQXpE?=
 =?utf-8?B?MmVqVEgvdklHbXg0dHk3SExzVURpMDhqb0xDREhqUk5XRVlXZXp6QW5wSW1j?=
 =?utf-8?B?cStZWnlxbkRXUU5kYyt3dllYN0pqSVF5UzZvMVAxanZ4TVFIMDJabXpPdXVG?=
 =?utf-8?B?OHI5Sk0xb3FielFiQzBvS251Z0xISG9ybGFsUG0vQ0t4VFMveFZyaVJ4YytV?=
 =?utf-8?B?NityUkFxREc3RkpQY3BYcWRtOFFORzZGNkw0RHU3Y2hVOC8zUy9VMlpKZVJJ?=
 =?utf-8?B?aVRWL0xCNktrRlp4VTV0UmxpaXdwRWtlR3U3OFcrSkxldDY3TjBQaEQ5dGVy?=
 =?utf-8?B?d1RDQ0JleDNMWU5CWEtSTTErRGdYRkEwU0diNVdueXVsenp2aTFHS2phRkZx?=
 =?utf-8?B?NnRRdDlQazc5N29UZ1kxSm1Kd3hKK3FXTlZQekV1dzMyaHhIenBpdEJiVG1v?=
 =?utf-8?B?NSt0TUpHa1dtT2tVelVmL0Q2TGhIWHFyTVpReHovdXpvN0M3VzB3VVZOWnlQ?=
 =?utf-8?B?N1FuSHR0SzVrUnhpWUpydGVZUGd1QW8xL3NncDlLQ3psVUlrMS9MSUkrY1Ex?=
 =?utf-8?B?enJFSis5d1UySmR2VjhFL0l2c3Yra0IzUEVKUFBlTURCZFdDQ3JMT04rckhQ?=
 =?utf-8?B?WHVWdEMvczY5U2x2T25yMnl1R1BPTnNzZVZuc2NYSzZ3WS9EUzZ5di9qOWsx?=
 =?utf-8?B?ZGxBU3BHalU2U0JjME1BdWp2dDNKR3lPVWVudHNWTGJrMTI2U3ZaR3FZM2Q3?=
 =?utf-8?B?czFKTEEvcWkzL0FWUllMQm56dnNhRjdoTGtXUm9xME9MQjZYTUxLVkliYjJY?=
 =?utf-8?B?WTI1NFZueEk0blRRYjFFNmpueTBvUWpFcExhYjhEZWd1Y25XMmxac1lOWHpQ?=
 =?utf-8?B?U0xGc29TY0g1SUxRemdGVThCbHIweTdyaE94MGdxaThub1p5SGpQcTA1M0xP?=
 =?utf-8?B?QzQ5NXVZeWZvZUwwYWpMUnF0QWtOYW5NdnpsMUdiMStXZEFpK2JuLzBxZ1Ru?=
 =?utf-8?B?Yit4MlZtOHF5SEY2RjRRK0dZSWVBVEo2QzJGbllkQTBrLy81ZlloekZqSGFJ?=
 =?utf-8?B?QzNMNi85SFViaS9YQWpKbE51V3ppeDVhdWg0bzBhWXhKeWtQa0Y5b05Kd2NQ?=
 =?utf-8?B?dTR0RlRTUDhnQkJITngrNEp1azhWQytYdTZqcXpjUkxrbnF3TFhGdElHbm5h?=
 =?utf-8?B?WXllemZ3QmNWQm5vWXBETy9HczJVa3A1a0E0L0toZW9uMmk1MkZPMVRWWVly?=
 =?utf-8?B?OFRNb3hVT3B6dEs0OWJaMi96Y1dHTXp6b2V6R3hRYjlPZ2x2aDd3ekozeVNw?=
 =?utf-8?B?NTd2Zldaa29nVHNack02NGZ5T2tCUWtLc2dVMzk1dVpXZmN0WXowSFJGYlZW?=
 =?utf-8?B?YWhhcXJFNGdnWWlxQzZ2cFhhb0lHT3QwQkIzMmxYNmJ0WDZ3R05vMmFoTHk2?=
 =?utf-8?B?b29jbTBlSVU4dXVjbHVwU000M1E1aSszTVN0UExEYnpDU3h2ZHA5MzFORVJm?=
 =?utf-8?B?SnVhWFVOSVFzd29YSC9Wc3VzTFNBa00xN2VTdHdETzg3ZVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjF5SG13aEllRElheUwwQ3I5RTJIMTFyWCs1TkE0V0IzTjVZaFVBVVNvUnFZ?=
 =?utf-8?B?dlFIK2dmUitHUFpYcVVIc0twcG5OaEE3Q1dwRXowQU1IS3NmTFZxQ1pVUmFH?=
 =?utf-8?B?MmJIc1hpbkhLM3F4UmIwcXZOSEgva2NzSitRU1ZUcCt1RHpsbTI2Rnlvbi9i?=
 =?utf-8?B?bTAzUXByUmlDOGFMdWtGa044L3dEOVRPZ3E5Tll5RlFIbXFueDdIOFk4UnQ0?=
 =?utf-8?B?RGVqK2c1cnNkaHFaUWlrWkVUSHgyN0JGSURHTS9MK1lrQjFUL2JnQ0Q2VHZa?=
 =?utf-8?B?SUlNOGlSU0ljMkY1WHZDR2hMaUJ4SHp3blNLcGltb1RFcjUzUjlIMVNnMEN4?=
 =?utf-8?B?OCs1dWx5TFBhR1VDWFdIb25TM3kwdy9Ia2hkaUdzMFYzdXBVckpESHRBd2NP?=
 =?utf-8?B?TFRPaVo0cGd4bkMwRWMwdEsrOFNjc2Y5K1FqdnA4eHJSUy8yOWk5VjNGVXBT?=
 =?utf-8?B?dXV4N3FRdjN2SEdzV01IdTJzVmNTRXlLZmJyOGw2d0FZNy9aUlNvSmY3S3Vj?=
 =?utf-8?B?UjRVQ0FkK3NzVzgvRDVFWXZYYm9jdDFEYUNxVzJyMEM0cmV0SFdxbjNQb204?=
 =?utf-8?B?bmtJMnFrenpQUnhMVlNBSXdIbEhQeGdDbDUrSU56c2MwSW8rbzd1R0RUN0pu?=
 =?utf-8?B?U3VCZE5JSFJQTVlCWG5scDFjVGhoTlVmT0NpcTJmbjhDNXFFalpkUHp1N2Yz?=
 =?utf-8?B?UStTL3k3QjlicnEyVDZIOE1MakIvUWNoeWg5aDF1c1JoZVZiT1ExNjI2Y0Rr?=
 =?utf-8?B?cDUzN3NRT3lDdGdvam1VOXFtcXhBN0gzNUNzRC9oWTNBTExCZjRpNVZ2Q0VJ?=
 =?utf-8?B?Tmsxa1hXTXpqdVl5L2RDZFd6VkZUOEFibkRtd3ZBY1JZRDkzcXJ4VUZJd1Yw?=
 =?utf-8?B?NUpmN3FoZVNMVTdxbjBVRTljOVJkSUZxV1c4MW1vemdJSlp6YVpiVytKemZq?=
 =?utf-8?B?bUxCeFErQTBjZVRVOVJzV3I0TExGSGNPUVJDWWlBYmR4S3M4dkNHbTdyamxI?=
 =?utf-8?B?YkQvQjNvMXlZQzBsOUxRbGNkVjJjL3k4cFllQThGSGlmNWVQNWt6ZnRnRGI3?=
 =?utf-8?B?cUJnL2pFZ0J6a1dJNDMrVXdyZERqZXEwQ0RSZjE5WG9iTnVnaXhpaG5kVHk5?=
 =?utf-8?B?QW5nQUtDN2tuM0hNUkRtUi9Sd0JGUnRMVFNIZlN6MU9pdGkxWFZzMm80TE1Y?=
 =?utf-8?B?V3N4RThCSVlFTXptR3UvUWF6TlN1WlFnQnN6ZEtjWVhqTE5zOThZbVFvQlE4?=
 =?utf-8?B?WXJpUXNOcGpzZ0NMaTh4bXVNVVlsck1JTURyc3p0OE95U0QxRTdlck1zWWpx?=
 =?utf-8?B?eFF5T2t4Nmh0cGZKSHpCSS8wMllhNUE4SUUrOUZjdUg4ajhTRkg1VnExZ2ZL?=
 =?utf-8?B?N09zSjNZa0hKck1VNUZ3d29SK3FMNDhsQnloUndoN0kwNm56Rkd0Yk8yWUhJ?=
 =?utf-8?B?MkZMSUN1MVBmNEtMaE10UlBZb3MxU2xNeDg5S0FoVVlpMm44cGlUOWFNbUdC?=
 =?utf-8?B?VlJHeDdibWpCMDQ3WU81Z2tNU3QyQ3NOMXJGa3FSSEdMbzJjeEtxZTl3NXpG?=
 =?utf-8?B?OGxUdEY2N3BNeWI1OEFsRHNQTFpzWHZWOW84d01ZWVZkM2Q5NGhqZHBYOFdp?=
 =?utf-8?B?QXlPeHMvb0ViVVpYdVhtWnlPdWR0NUxSTTU0K0xVQXZzakR4K3NnVzdMZ3ph?=
 =?utf-8?B?VUxGY0R4YXo3MnQwc0FUQ1pmOFBnYlhFRkZCa3N4ejhhbm5nT21LZ05ZeVhU?=
 =?utf-8?B?Y2Iwdjl3bmE1VW1EbEFuTm54T1lIMG9weXI5U2hBSVJJZVRMcjBla2xPODVH?=
 =?utf-8?B?OUFBN3UzcHlUMXZnT1pRcW93Rmt5ajkzRExLRlBjZU1UOXBIeFhCcDZ4R1NW?=
 =?utf-8?B?MktOVTBHQml3a3dFRW1QTE0rMFpBeFBnZU5PeFozTGwyVjhPNTBIM2JHRkQx?=
 =?utf-8?B?bmRweVBiTGV5YTFtOTFqTWMzaHRVT0JPUXVVM09PZXM5K09MY3RyVDhCcU1l?=
 =?utf-8?B?Qmxqa3hnbThJQ3NyNnhhcnNyVW9tcGJOVFBvbytmS1ROV2YvWGRWT3pHL0k1?=
 =?utf-8?B?L2grNlVWT3ZEQkM1ZUtKV1B2YlFlUk53RE9KRjVrZFh4QTVXTllPanhVQm16?=
 =?utf-8?Q?jH+iFhI5QUdypqit4ON/tvcLy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A9RM2+PcqGJwMRNYnIzoz5GaDc7YhWVsEvU0OFo1pmRnwT6mlH3ryxhBkICKiNZmFGwfrCkkaWGoe78U+PS5IJgWplABUNxV8f3w2/g/hM94mURMrqYcH9edqFSA4sD1wO3l9o4Ov2J8MjwTAKlfdB8qCwP0w0KGE/dME5Ab0mFoOWU4zFr5WQUMY2TvnZAs0fIcXU8C+jhXcNqqGzaxnlRC/7pkuVGqolhuxgCSY5i93N1p12a6UoIdFPH3Jz4MREQpE8pdJ+xLlGsrEzbFrSyG3BU7+S4abn+JmGVAFlZgdMTurjX/WsOCNxnOjG8WRBFBJQ9UjwY6nNf0eEWhKo3eVDTojduhicHLrKtITAoBHCANy4queHReLc1YQHNVJs2tAJFMTUWucUGynjXPuibn2twPCcEMT1XFtXPzp5V1iNI+5x9Npj3xGveKA53ue8OaYqBac0Fvf3p58jOB/8PhncenqYCNCA7AGxqfNN4A5Ys43zXi9WrDk98NPRiSIOiINX6g/9KSBlYMyPOLeTZgMe5M7EZoV868RjkAwv+epp1Tahfge0HC/n9D+M35/HGaqicooZuqBI9ZlSMnBxMalQYTEntLHHqyfBa7r7U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df28762-7506-449c-940c-08ddea3006d3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:50:15.5043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtEzgVhxdB3jcgtKtvWJAWPMu8+nKPLw8MR//wrnBuVnk6Ts80CdbBIic4cbo8Rhf/gZtxCDq3TF1fYqpd6kIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020145
X-Proofpoint-ORIG-GUID: 6-fjWbpOOfDUG_MxPjA0iU3HszQpV13b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX7fZYAWUDFAO7
 FrSQEjWpUY5AC9ihEPufQIm8joljm6v3XhCs/mDNT1XAk1kmq10ASpRh0GWJZsEAJ3XI4Q+amaK
 08VZS17g7Gf4YtC+YYFiCrnzd15TpkqlPJhsbwhl8r/cQYtRtpBLDfbHeo1JhLIvmIWCdvqFLgc
 mDJE4WttxkSAEkdq/wnMQJw0187ZeQ2tQGLO/C88TkQFmVdNnk+a0niEB1+ybJm+WxJoLVPOnr4
 jZ4s2ztzFXgeoOtkeuIe5AO4vdtRBYUlSjgBkZtQlgZezXR+LmUvHzo9OkzSuZ93EtPQX/MVSKV
 kF/xhES2qOZEL2chOHcguyAFYlsG9nn5FmA/v06/pnFC/oNdz9KFRbfApIaiTsHSOWeObd/0q8N
 m7UsP07U
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b7042b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VnNF1IyMAAAA:8 a=BzYJG1oMymonx8tboC8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6-fjWbpOOfDUG_MxPjA0iU3HszQpV13b

On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> The main motivation of adding this function on top of _require_fio is
> that there has been a case in fio where atomic= option was added but
> later it was changed to noop since kernel didn't yet have support for
> atomic writes. It was then again utilized to do atomic writes in a later
> version, once kernel got the support. Due to this there is a point in
> fio where _require_fio w/ atomic=1 will succeed even though it would
> not be doing atomic writes.
> 
> Hence, add an explicit helper to ensure tests to require specific
> versions of fio to work past such issues.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>   common/rc | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 35a1c835..f45b9a38 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5997,6 +5997,38 @@ _max() {
>   	echo $ret
>   }
>   
> +# Check the required fio version. Examples:
> +#   _require_fio_version 3.38 (matches 3.38 only)
> +#   _require_fio_version 3.38+ (matches 3.38 and above)
> +#   _require_fio_version 3.38- (matches 3.38 and below)

This requires the user to know the version which corresponds to the 
feature. Is that how things are done for other such utilities and their 
versions vs features?

I was going to suggest exporting something like 
_require_fio_atomic_writes(), and _require_fio_atomic_writes() calls 
_require_fio_version() to check the version.

Thanks,
John



