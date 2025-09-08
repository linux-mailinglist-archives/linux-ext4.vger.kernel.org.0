Return-Path: <linux-ext4+bounces-9840-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3D3B485D1
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Sep 2025 09:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1197E7A874A
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Sep 2025 07:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D4D2E92D2;
	Mon,  8 Sep 2025 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IWRRxjBV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H0JvEuMq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B832E8DEB;
	Mon,  8 Sep 2025 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317207; cv=fail; b=P71LHxKlv1oAeQrNGc+e0TBA2nZkypfLmoy8ACeOI+IZP4OpwuM1pJIOXJI/7yo1remrIPEgqLuYwU1CubzLf2uJxTUmr4yUEtsRzDQR6P8zqu1iXL2W0c6YF6lz/aWCdrCqBj2FW0zqrWhTgZwhg5ENZSmTN0WKVqQl3PH6AhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317207; c=relaxed/simple;
	bh=7UCswfk0yfK6duX/qzsi426N+stl2wXYe/aIhqHAkIc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jDUA7Vr6z3aMQiaw/xqkwccvTjl9kWqOF7H202aBPXwg6b8XGsBfHZxOvq0+Z3hbgsf8n+ZICyIGxUotncp0/47VvgeluGtav74khoZUOQDtYt4F+GlOK8GW2qKVV7mZD7Mb2bi9QjxPZis066xe4/ga0EElz8eJleqx4VPYMWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IWRRxjBV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H0JvEuMq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5887cTCG005938;
	Mon, 8 Sep 2025 07:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3q5UNyH7zUYNoiRmOkPJ5ezcoV/f2fMxos85nH3zoHI=; b=
	IWRRxjBVG1tnDfMPc2KXzeWqcVK28h5gd82YqVHPlk/ch1oL/X9kxuWZ+DkrRDGu
	KDKmOcN/UinS+MKYCKXoyE+fKva+mBsMJ5FdM37UtUxtIjzd8nxJVPn9S+SLapfi
	7uTpnqkNRc84L1ZU/0oAzaetNFZeDfll4iG4frRKS7cqXs8qqO44eAn5qpjGzz6m
	Bwj5RxAtUmBB58oMymgiCBB2fEtTMUFL22xVp5QtwI2InOinB/DHme0ediWekw1M
	RTxT7wfhLnprxggI9kcvHmSppu/WEjLyuw0e3Z8SXuJo/HQiQp0zd77h0X8lEaHN
	VWmMb82gBVvkkuHTrmfKuw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491txb802d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 07:39:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5885BAQV032867;
	Mon, 8 Sep 2025 07:39:50 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd8u4rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 07:39:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T451c4cFhUjXjVbQit907p4mNYlV/gAMMX6avdmm9SID6axu1GheV3+/kYXfoTDYLUjjvJ+j/voy7zg4y2uX7tv6Ql40DLbmIz4qFK2Z7fNgI/EVqAKWyXu619lc6ZefjL4E0zNotCeMPjczj6bBd2zXYr+EqKbqdOmzwq4ZOGa+o67Wy4dq9mU4f1sOZ7eFXymr3sNnMDBrpiOPIDDrtiPFI/hDDYQX1gsGN/w5Ia/RNFOjTDhQDk6rQWwJfGDr5U/ZYcHp/fAEmrUg2BE3afvUrDjiNPPr+sdPaW927sWjiuMWpUhI0rJ9GDkfJ6UWmrRBs7CwtmuDq91LEEgz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3q5UNyH7zUYNoiRmOkPJ5ezcoV/f2fMxos85nH3zoHI=;
 b=Tfx6WFtbQoNtcr/iNyX2gO4HTIdnHCFwbhsD5V7wWLs3z5GEqcL864GloL4U8l5c6Kt19McGtAtb0XbxLAb0IUdwVPxBEjIRAZQD2pnuCj41zsNg2Z12U0c8zx2/oSK+AOs9GHcgg9t/uqZk1P89VQ6h5r215uG3JsccYgVqJZX3miYDNlF+Abs8XxfAnvzFmrDAGC69pF7ymXGvgwf5YPQOjmTqO2OGCha4PEXm8MTftW7Fd8wCnlRj/2c0+iQu+ndAWhGbWydfPmuIxO7ALEDy5sn5Okx5PdSaRHeL82suclvzdG2E5kdOpDW6sN9kji8kbfpnQ7PMhAXYAvgB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q5UNyH7zUYNoiRmOkPJ5ezcoV/f2fMxos85nH3zoHI=;
 b=H0JvEuMqjljsbEs7ZaaaJ6Vo/gi0qMIY9yIbefJYxvjLphb9kTp21SzD7htPHc1E7QfKW0lv80uJlkr7zYGXioxYZnQw8rCWM9RgtDX6O6+YKNY9CRRie+YGSbMvT47unR8Uz8C6MmYAXlWc5q3tviBUq6XcuZdZv6ReDjztzS8=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH4PR10MB8098.namprd10.prod.outlook.com (2603:10b6:610:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 07:39:48 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 07:39:48 +0000
Message-ID: <3c5fb15d-2eb5-430b-ab8a-e4d94162dc88@oracle.com>
Date: Mon, 8 Sep 2025 08:39:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/12] ext4: Test atomic writes allocation and write
 codepaths with bigalloc
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <a223c31b43ce3a2c7a3534efbc0477651f1fc2bb.1755849134.git.ojaswin@linux.ibm.com>
 <001c5111-84c8-4bb0-951a-cc51587479be@oracle.com>
 <aLsZe0czym9X9Lo4@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aLsZe0czym9X9Lo4@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0597.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::14) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH4PR10MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 74de741a-0124-4a64-efda-08ddeeaae308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzF4T21KWG9nejBQaFF6anRUMWFnYkM4cW1ZWVVmY2QvbmpBYWhxVktHNVpq?=
 =?utf-8?B?T3VDZmtRWWxSSjk1dGFsK0NUdVBwY2NMUGJ2Yk0wZlIwM3hqdkpxcTY1aWRG?=
 =?utf-8?B?WFJ4MFFkcm1OK3N4YlpUS2VpNVVJanhVSjJhRDlaWjV6K2FpR2dtb3NZL09q?=
 =?utf-8?B?Q2p4SmxKVlRyYkJ1ckxOT1JzZnd1MUxSdnVDdjhLSUs0TmJiU3FZd3ZBSHlU?=
 =?utf-8?B?YXYzWHlqYzdkNk40S2ZONVNscVVHbjVtYXh6ZERreFNmQjRKSXpadXRONHMx?=
 =?utf-8?B?bHVyZzdnQ3Z1QWN0L0M3UGlDSVhwVFJ0dzh6K0pwZ3VXZWJuM3VCZktJK0ls?=
 =?utf-8?B?bnMzTXBIZlhCMkk0Sk9zUS9xaHdKTWxnbHRrSmwyNFFVVy9HU0FmN28yQW9Y?=
 =?utf-8?B?cUZyRU9SUGlHdmRRUmdia04ycHhMdEU5Qkhud1d6TERhNzU1d0YrOFJnRHlV?=
 =?utf-8?B?Rk8rTG5TYSt5cUJqV2swSlRacDMwamxrb2dCWGlJNG9hZjhvUzYxM3cycFVn?=
 =?utf-8?B?QkRybTVKd3pXQkVyMjFYUmpCdGpLSmEzMHRXY3JoVUd4ZzZta3JjcDR1NG81?=
 =?utf-8?B?ZENGVzN3aU16ZTVZT3hOUUx5MmNaQU9KWk5sTS9VYkQ2UHFnWldoTWRXRXli?=
 =?utf-8?B?YlpBR3M4UmhxZUFLeFczQ2xpdmpYVjhmVFhIditjMVB1QzJtSGJMRWVqdlB4?=
 =?utf-8?B?R3U4c3pmeE05VzZMdUNubGxLNU4yTSthOW80NTdISEo3SGpvRDVIb213ZmZI?=
 =?utf-8?B?QlZGSllQVWJYNFpvQnQ2VEpjeWVOaURqQVZvQW1XZUpTQ0J5Q042WGExUFJD?=
 =?utf-8?B?eHhPTjBLL2FPaDd5R2tDSFk0SUlKM3RHUEhuN2hxUGVEMDJiMVJHRjEzR0l4?=
 =?utf-8?B?VlNhdDU3OXhKaVFsQkNzbWlzTFBpRktZQmQ5WjFoTkxVb3VTaFNEUnVhYzFK?=
 =?utf-8?B?Z2RtMnY5M09EZUNSc1NQQTNDRmhBNTBXK0Q3M2tWcG1ndDhOSlprN3ViMWlD?=
 =?utf-8?B?eUdoUG1wNkg0anRXeW1KcHBZS1dVMHJ2ZkMrN01yYTlNT1duY2tZWFcrNlZF?=
 =?utf-8?B?TXg0MEIyWGZGcVppckM2dlI2dW5YSWR6VHZNTlVKcTZ4dDkrTmpvNTRJUDlw?=
 =?utf-8?B?UHJnQ0RBZlRvSVh4VVdWZ0NLbnlPQnI4VGNVc3Bncm1KWWZxS2ltcXAzZTlF?=
 =?utf-8?B?c2p6U1JMMWlqemJCN0JLd3psK21HejhRVldzODl3a09oWDU5QmJablB0VWEx?=
 =?utf-8?B?T0p6Ky9MZ2U1RmlwL3ljbzJqcDA3d2JMMmRkRFM0am5XUnVWV0ExMWZzaStl?=
 =?utf-8?B?amxEc2FZR3lOSlkzVzArdkYxbHg0YTRuaVpzb3ZsTWJPWGNBbDJjaEFLeXA5?=
 =?utf-8?B?dzBmU2Nob2hHRkswTlMzTXp4bW02OGtBaTVkNUhybmtZRXpiU292NEl5R2Iy?=
 =?utf-8?B?SHpRUkxheFRGSEx2QjlKRkZiYUVTZ0tUSzI3alJ2cGJ6dVdTQmtpaFFCSXVW?=
 =?utf-8?B?SVp0VXVUYm5UNytnU084a2xZKzlQOFVQbGdJSXhJdDRBamhBcU9VcFRyWTZB?=
 =?utf-8?B?WGNLNGRLRjdqUkFFQU1TbnlLbUo5VGdySDNSOHVva0d6KzUvOHQrSm9oUG1U?=
 =?utf-8?B?UUh3Z1ZmcC9GRHUzcC9uVkQrRVU0RW1QVDF5Z2lVdEFWS1JReUZ3UDdUMmx0?=
 =?utf-8?B?ZG5pcWtQeFBNZHduejRybzJlcGh6WU5WRmZPUTF4cTdRTFNkWU92eTl0MXZY?=
 =?utf-8?B?SUNkMmQ3M1o2cmtYdjlCWTlXc0FCWSsxNDlIeDdLQ3BBSW5CSENoVHA4bE9u?=
 =?utf-8?B?L1RHQnF5OEdRUFV4alNIMFRSaXpTZmZlaWJES3I4VnYzWFNHeHl6MHkxRG1M?=
 =?utf-8?B?dnJ4cmwxdEp6KzRQNWdkOFZlSXVDMFd4anBsaXdIbFk5V1h2Z2NkRHY1b1Nm?=
 =?utf-8?Q?hRJVCwtBfA0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVB6aEpVcnpQamd6Tk5KZDdsY2hHQVRTTWtxNnJ6SldXUGtBWlJDOXB0bjEr?=
 =?utf-8?B?aWlBRmpoS1JKdGhjem9hcEkwN09Hdm5lUSsrejJWNVhNNFVPWVAyL05JbVBs?=
 =?utf-8?B?eFo1WE9OOEEwRUtObXZSZ0hYRXA1MCt2WDBRWFB6WkF3aXJmOHV3V0NkOEp4?=
 =?utf-8?B?T0c5QkdqMU9HQWs1YitoMmhYandLR3FoTURhdGRPWStLSGsyMk01bDZoanh0?=
 =?utf-8?B?NnhUY1ZpTTExL1ViczJWMjh6UWdwazQrWFBYbUhrZjBrTTE0ejJURGZpUU9N?=
 =?utf-8?B?eEJrTzIyVTh2M1RiMVNHVzZLaWZIRkNLampEanJOOUlZMzh4K2VrTmN0RXFV?=
 =?utf-8?B?enRuMzc5NUprOVZaS25WQTNpTkJvSER0THFJN0RiUWMxaFBQdWVIK1YzOVVn?=
 =?utf-8?B?ZHNVQzQ2aExTL2ZIMVU4VExCUGhEbTZsMG1zWmZJTDhFUmtaLzM3Umx6NXNB?=
 =?utf-8?B?NlIvTzI3Ylp0WHdkRFVVay9SbzhKWHhuQUxVOEF6TWpZQVZqNjlDd2Y4NXp6?=
 =?utf-8?B?NjIwVnJuWEw4N2F6blhONUtnTG9aakFkbG0xRHpJdjJ4TGRSQjZzQlVIVy9Z?=
 =?utf-8?B?UmgwS3ZWbEdRM0RUd3ppMlI2R2RQcDJLTTRQcXZXSG9FWHVielRLaDRraEdl?=
 =?utf-8?B?a1J0aVQxNXVtOTdxZlA0Q1VGMW0xN2lSM3VSNG14akdwcWVyQ2R6bk1NMXBH?=
 =?utf-8?B?MHdWZmM4NFFKU1luRDh4d0RJcWg1aUx6aTR5KzkyS2ZibUdWWU9WWGpHQXo0?=
 =?utf-8?B?UFhFV0tRYlkwS2N1ZW1Qd1RZSndiZzRCdFhCRVJ4Zm9pSm9FV3FPbHU0R0Nw?=
 =?utf-8?B?Z0R5ZmhNUlVJMHNKWjZzdE5vOGxZYXdCbVhYTFhoVDRCZFVBV0hxY0FzeHc3?=
 =?utf-8?B?dy9BdkNkSkQrUXE1UGFYV2sra3YyUm9qWHp1dnMvUDNXTk9wb1hscytuN3NR?=
 =?utf-8?B?L1dOQnJRRjFuaVBFREMycmY4V3k1dFM3QjBJSTZndnVoS29pNkJIZ0Z1dXJY?=
 =?utf-8?B?czAvaDFFUnNINldqVzRBcFJBM0ZsMEI1dnZndXR3VDVHakEyT3c3ZFNueTE1?=
 =?utf-8?B?UDRXTlhKenN1L2FkQjQzQjBmUk9BTDY4M1k2REMwRFJJbU50MEkrWnRJNDBM?=
 =?utf-8?B?Z1c0M3BBTUhxSlFDM1Z0MWZha0xGeDJYTGlXclZFYVdldUkxS0xYeVBFNzFT?=
 =?utf-8?B?aVVyUUFMZDFEOW8zNVVjVU5kMldYTExnMEtqMXNsWkhEVDdxdDY3Vko0eFoy?=
 =?utf-8?B?ZmdwL0g1cFpSRHRMckRmV1AvclNNQXNCU09vbE41RUFsUTNQbVFvUzhodDJH?=
 =?utf-8?B?Y2Z4Y2p1TnkvRVFNaHlYamZWWUFlMjFWaHdObGRHZU5ZS2djdkNKcE9KY05E?=
 =?utf-8?B?QnVxbUZIT2RpYWVqdDFSODRRajZseU1LQ0lONWVrK3dwNzNmOFBLV1UrOHF3?=
 =?utf-8?B?d053U3ZTT3J1ZDFiOENLcjNZNnVLYlVqYVI5QUlXREhjOEdGYlkzSEo1V3Z5?=
 =?utf-8?B?MHlWYU4xSjNuMU5FYjdvSFFNWlpSRzlUM09mZFpySHlhdzhWSkg2eDJjTC9M?=
 =?utf-8?B?QjNnN0tNc1crdnlPKzZFYks0SkJHZm9uYjlKZVFib2xLMlAzQUxaSFJ4bmdG?=
 =?utf-8?B?SWI0VTc2NzE5MUxrSHFOY3ZKNGtwZW5pQms2YlNBZk9iQWhrU2FYK3FFMnJ6?=
 =?utf-8?B?V201R2ZZYnEzOHRmWEFDUVY4RUFzUTJRSWJaTFdnMTZvbkRrSjIvc09LNkhm?=
 =?utf-8?B?dnZPMWhTeVBUaHNxZ1V4eFV4OWczOTdyaFZtM2NFUjdzM1pGY240RU9sU0xM?=
 =?utf-8?B?ZXlsd01Vb24rSEJHSC9Sckt0K1E4REgyeUhoc2dXdkRFcWd2ZmR0emlzek1k?=
 =?utf-8?B?M1RiQXFMQTA3empxWG5Edm1pZTNtWUh4dlVXRWc3S2dlejVidW1XTHFPWmo3?=
 =?utf-8?B?ZTBiYkwzcEU4Tmdab28yVkU0SGwweG9Ucll6V1V3ektnRENUNlovWU44UEQ0?=
 =?utf-8?B?dUJ6OXMrWlBhblFGVnpzdXVnVTZyckFWQzJiYTFnYjdQbE5OalhKdjlGeTFp?=
 =?utf-8?B?THlVM2xXcVI1clRYelp5cUdjSnVWVERzaU14Z2k3QnZnVmhocHEvMm5QWmtv?=
 =?utf-8?Q?/BFM8ZLP+h+4IvfcU6ceGkhI+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vxccsUGucU/wn/tGtf8nRHYm/1Va43+B7OKCxyQ3LpfiRLuU5QLsETd+Zox/eqipuEPnz1PVcG83HbM7KvhK2mkcVCK7PK2pjk5UmY7DcRpbdLeGGsuHKcEiRt2oKb97wHXTsYgIkrTf0dJu87TGQr0Ki8A2UJhRZzQ69Vp80KrSLPXhe/DOQKHuAPrOEtu9tM8KaVwbnajllBFerYgWxKjWpAMLv1UxZDHN9MEwKeVfKUvh0/KeXuhSfR5PNN3VAgTQIgW4yxgn6HTcGVwGiikMD7fGpFfivi8JHdW5lO65M0i/p+kk+SCejlFT5X1ok7i+1QuIhEGecwtPGcWv1ASvkZDVUvb+VaLxZOA2FD0LoLRONQP8sL+T85IbKdIuCW6rMs/VtU8UGPQ2EUmj+gKYIsbLVNlZ7FE2RgcwWRHypeH2fScPPrJDYR/nK5a7uTSnJOY7X7cEIq71NJiZY438C6dAbUI94QpA/EJZCP4roDY4TRsoH663KW850Emc9N9WgDNOJs6S/2qK9V0/NtICW79eIzKQHdlb63z7PRsuRzoPXsbfL0WHp/YnSEI755+2vu3hTnWucJcDu1kaaq4EE/pJip3vnDTVGCA8RVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74de741a-0124-4a64-efda-08ddeeaae308
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 07:39:47.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcwb5jaB11V9K3o5BLlzA0UPZp5bmLE97pSHKBekL5LPlFak5PoXwvjBuuiY075eU4hK30SmnNeOdj6tdCBbug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8098
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080076
X-Proofpoint-GUID: 1cFq0LTxJlpVi-8VDJjBvltSjSIVX0zi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA3NCBTYWx0ZWRfX6TKwiqidv273
 KBw9ucQK5x1HbFY5umc4oCBjZp6HJrQriNWNpyfjp47S1DYvT3D9+FVCTUwtDrizSiFrkqOviRT
 IWbNIA8w+aSw/FeQ3YXlsm3+hUkUZoeDEA70DhP5TPgi/oecm5pobXK1MD4Jlmft1SrRROazW48
 IxE81lxUjrqGo6Z7WxYZ5otxDU02TlqYE7K/0a/lwi4k2WPhlQQGVveKgE3NvsSjIznU+3yblsl
 eTxAddfHdld69NvCWL3H2sIIUELQamvQ75ldRHxayBFsjJkqnG3RWbGr9FFSA/RoLNg8OUbqAdd
 +PITK9n8c3cJs8H28hkZ4Ql7W5MV3ZWaVGE3VnBELM8rrujQY28/4zKPSM8JPu1aMRolGvZDJFE
 cSDr6u+W
X-Authority-Analysis: v=2.4 cv=Z8HsHGRA c=1 sm=1 tr=0 ts=68be8847 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=mlYqDT4aotFhyTvDpV4A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 1cFq0LTxJlpVi-8VDJjBvltSjSIVX0zi

On 05/09/2025 18:10, Ojaswin Mujoo wrote:
>>> +	[verify-job7]
>>> +	filename=$SCRATCH_MNT/testfile-job7
>>> +
>>> +	[verify-job8]
>>> +	filename=$SCRATCH_MNT/testfile-job8
>> do you really need multiple jobs for verify?
> Yes since we want each job to verify it's own file.

ok, I suppose so:

Reviewed-by: John Garry <john.g.garry@oracle.com>

