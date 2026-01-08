Return-Path: <linux-ext4+bounces-12628-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AF7D01F11
	for <lists+linux-ext4@lfdr.de>; Thu, 08 Jan 2026 10:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4030A35B093D
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jan 2026 08:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8350D389464;
	Thu,  8 Jan 2026 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SdXojGeB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011049.outbound.protection.outlook.com [40.107.130.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A123816ED;
	Thu,  8 Jan 2026 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767860384; cv=fail; b=iNzN0tK+seAptVheC4uctUw9vz4CQMeeYF3xt4P2/8DWMIqMKg0QF5R4n/ETz/LB0OgXq1JlOKHNnI+9H2ZLE6aAcdz0a9ZnniheJPzPAhkSQb1roY9GN7XDMY6h9JvHPaM/PbvElK8aU0pYL2SLWqmWwtRpIwjZuSrW9M21jn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767860384; c=relaxed/simple;
	bh=/vJ4yf0W2Is3lm/rmSgSzLcJ4ZsI0jsbxrYtOzXrum0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IW35DT7w381xqH+Je4VcdDv2xDeHTnRPS0YFWAXMYDmW47osQiKvnEMm1M8sMCpYWGo/K33eVpXUZnvtxz1L68A+Yu6yfxUu01Zzd8rqdBjGlu5gFOdfacbA2qoYHHzwIwlYmvbtSXAxU05h9BFJ4ymAV5/ry2Uv+tFYX92hH54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SdXojGeB; arc=fail smtp.client-ip=40.107.130.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLu9M2AtZEk5h2t7L/zF9ExHJ+u6d28K6glj6EweeNS5EruN7Yz5q7hiXJIYtctCOWWyHy/KsWO2VUZjzo5IJLKzuksbm+HK5lEutJGY7tltc4MERi9j8ZIoppsRvZOKfTut9BUNRs+XVjQ1Nh10E+2JRzSoewDLZRR4hao+dJhc08jFQXYKiGSoy9oOSLPN+iLlBWVmloaHs215Wyr9EPQW9uJ6qfOMN9R0U8bUgvcnyej+POmsDta/clzVSchAoHAEhEm4Wa5Qd0t8l0hfPHo8MZIt/ZNv1XCQhM0bnnmM3Vpd2RNfB2ht3YbcHyMnBdFir7Dg+Kd2L5qOkpcCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6EZnjAbfBeqFAFdgN9yCoMwln6tkLytJikdNmaKJ2I=;
 b=Ht0BqCEx7g5bbQ03/CeIUSx+Fy7Y3EJQlyFvqg8mUli1xaTDuJMls83saUjYxRhJDOkjiqmu7PZ1qP2QHBtRglbCqFDFlNVw0Ye6ib/r8uJC8afivDW8QCbnt4tTKGux5PPGbpGgjcb6rr2r4RxqzmNmE1o/EFGXPsDuvADiUGfe8oZc4MUXckuqiUAcy7/IkbR+rztnP1ebhf+95xj9ZLa9sVtmT7sgahgyMj55H9bkVVcoUt5O0J8e0cbIqmh7WvvGRrZCKYnNMpKdTaiOBDotVTLnKua407PlulPzPUqUkyRDdO3MMfBb8FgrwNps9nK2yTFZ7jyljILQKgndJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6EZnjAbfBeqFAFdgN9yCoMwln6tkLytJikdNmaKJ2I=;
 b=SdXojGeBaWqnjMf1CNavB1QYv7JWVrPv6fFIHs/VVpSPcL9lv4m6/Y9fLtbupDZ1yAjcrdVxOGHLrcJn1ydiSNT5mo4JXhFtiFwH/t9U6ZBDv9lU4H66wvV0MNUXIFLehjic3z8oiT5E8n3EbuaHESuVqhhnFFhAfSXGn7EceepRAX0rw6TAKKXOSLnRVHhcSxkdKbgLPxjY0CiSsMVUaA6GH0gvuJc7JBH7uC5C3pPHuvqdNm3l6pfi3WY+kSKPI962/FNxbGYLfoEzgeEVrYitc15Bkzszi0osLSxAHz6Z+CUHbwOI3bYw56juX5JleVmsyMHrR595/4lyU0nRKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6978.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:416::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 08:19:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 08:19:24 +0000
Message-ID: <ebd61bd3-1160-459f-b3b3-f186719fa5f3@siemens.com>
Date: Thu, 8 Jan 2026 09:19:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 242/262] ext4: fix checks for orphan inodes
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>
Cc: patches@lists.linux.dev, stable@kernel.org, Zhang Yi
 <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <20251013144326.116493600@linuxfoundation.org>
 <20251013144334.953291810@linuxfoundation.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251013144334.953291810@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f341bad-139b-4d9c-43d5-08de4e8ea1c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MENRVTJldmNGc1lWQUNUR0N3ZjVjSWt5cjZORENwRUZRVEFpRXY3V0lvTWYz?=
 =?utf-8?B?UWZxZlNGaFZhZnlBMjF4SkZPMTF3VHh3SkJ2cTZrZnh5NVpIUS93TkIwcFNr?=
 =?utf-8?B?eDRCcFNOZFJueVhFMm9Dc1c5U1VoZ2tBaWJDa1R0ejZ6RmNNNlNNUTZ6WTl1?=
 =?utf-8?B?VTNKb2VBc0RNaUlDVHl3L095VXc0bGRtR3lUV2NORjFoejBvUDVsUlp3STZu?=
 =?utf-8?B?bDRuV0tIMW5qNUVudG1lSXlZd2JGZEVNeUxGbGt3Y1kwb2hkaVNkeThGWlgw?=
 =?utf-8?B?cXRIQk1QUkpxSS9PdzZOZlZCb1h3UCtObXFSOUtldnFoeGNtWkw0SzBjWXFw?=
 =?utf-8?B?YWs2K05hcFJqRFc5dW42UW1IVXVRbHRGbWdwVk5oMmxsV1AyRmM0eGtBYTlj?=
 =?utf-8?B?RXNkenk0U2xrRzczWWNXSDlFT3NvdzB0TjI2bUF1eGd2U01VZ1lUSzhBYzlZ?=
 =?utf-8?B?K0ljTjA4T0FBSGh6dm1URW5adkJ1VGt0ZzJlWGhwTUtqT296ZkFUVUNZQytj?=
 =?utf-8?B?Y2tURU5mUnArNnJpeFFCSlM0RTNKdy9yVGp5dytDYWRLZDVzM0lXb2E3b21u?=
 =?utf-8?B?L3dvQ3MyVTVFL3RKWDl2MzFNRGwvVmhHZnp4YTZyNXVlbXFGR0pSWVpQUG1M?=
 =?utf-8?B?djhRTkhLS3RFSWhJS2ROVjVwTTB4ZU5LSVV0N2g2eThZeEZ5Q1VsRkF0Nyt3?=
 =?utf-8?B?K0NqeVNqL1N0a2JEbDltN0dJYU1FWVdPb2FnV1gyVWcxMjd1VXZTQmhlOXlp?=
 =?utf-8?B?eUFJMjYxWGQ4aXlDZ1JjNGZsdkE2Mnd6TU9QbTluYWptRkZnODkvdHFUZHI5?=
 =?utf-8?B?c0x1eDByclR2bkRycnF6dk5MT01QcFV4YjZTdmxxck5rTzNCdzYweFcvcjU5?=
 =?utf-8?B?YXlodnBaWitqN3RiM0Zta3hrZUJablRZT3FVNCt6MHRIUEN6MThOaGgzYnVJ?=
 =?utf-8?B?dnNSZTNBU0VmdnMrdm5NbHN1NWlRWXk2UFJ0YUgrM2c4Z0s5SnpJS0JlV1dM?=
 =?utf-8?B?bGZwWTYzcGNKSHY5SDdnb3hqMGhJY2NpOWNTRHp4dVBjSjdJcEFWTjBSVXhP?=
 =?utf-8?B?SHh6eFpRZWJjUUdscTFlcGxSMDhZLzc0WTY1VTZOSXFUZ0RBTVVEQUZwZXJK?=
 =?utf-8?B?eFRWYjRyZUFraGlUV1g0NktPSGo4TWZiSXVlNm9YZWh1YW9aQ1RqNzZ2K3V6?=
 =?utf-8?B?dUtsYVVPbnNtQUhWOXRueHYzL3VSWnNZZHlRdmZPaU8wanFNTng3MzFaRmVX?=
 =?utf-8?B?b0VOc2FlTlJFWUdtcStmU3Y2RXlvOW5pKzhkei9KbTJaY2hKQUFCZnYvVjVu?=
 =?utf-8?B?K3F4alVRdXBncmtldWVHMGpkZWdRYXRGUjJhd01takViUStpRGdlN1hvQ0hk?=
 =?utf-8?B?TUNDZjR1TEw1UFNxZ2xCcEJtSDMvL2NFZlpYV2x1c1kyelNobVFPRk5WRmRs?=
 =?utf-8?B?d3hhU1YzNSt3TWRmY1VrVHI2WHZlWXFtZlVtS1NldDBHUnNmdHJZNjIyZDhG?=
 =?utf-8?B?VVJkVFB5ek84clFSS2hyUlhzcVd2b2lqOGpwUHg3WEovR2dXT1ArTWlTbkow?=
 =?utf-8?B?N2QzeisxSUc0L1lIbk5EeDMxa1FTTHJCSGJ3cFk1cndKTkUzM05vZTcyR1hp?=
 =?utf-8?B?SU9xTEJJUTIwKzF3RHh1UUcyY0REU2tnNFhZR2hyb0lnSTY4MStRSW9oYXBP?=
 =?utf-8?B?dTVEZGJNWG5GOVhZbGVMSG85YnY4QVJ3ZFg4WDNJTkRMODhobjQyMnhNUXVs?=
 =?utf-8?B?UHV6UmdxaEF4bHU0ZWNuTHM4U3k3U0JwNXZLbFdCZUNMWVpIVU1oWlRQTVA4?=
 =?utf-8?B?a0ZuNTdlUkFGSHZ3QW9NcnJWK0F1VkhPWjI3VkJ5eEE1UHlYWTViYTA1SVBv?=
 =?utf-8?B?TWt2dkdKVmxYUXArVmVoVW0wM0xXQ3RSeXdtYklJZi92OENjS1ErOXc0Rnht?=
 =?utf-8?B?d3JBMSs5N2grRXhzdnZNcmZVRi95UXZDK1VqTitIajV5Lzl0Q2FVbEhWc3hJ?=
 =?utf-8?B?MmVhWk5xajhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGhub3JjZ29FODFTOGR3SW1MNy82b0Z1UFhaditFN3l0TVB0cTd6Tjk3VTIy?=
 =?utf-8?B?Ry9VT3Y2by8vV3NQUlJ3Z01mRlNvV3oybEdZL2U0WnBWMUpHU3NYbEJPYWJn?=
 =?utf-8?B?Zk94T0JrZS9lQVJwdjM2Q3d3OFBaaDlVbnkwR0VITENtMWM3aEVEWHJzK0tH?=
 =?utf-8?B?UXRLdEZtN0pDNXd5RCtteWZlZURhaG94ZENZYXh6MlpocTh6WU1KMlVCeGFL?=
 =?utf-8?B?ZWU0Qzh5UTIvR1FXQlhUNlV5cGRtaCtqYVpkK3IzN01WYjFydFNNWnpWS2cy?=
 =?utf-8?B?NFA4OGg1aGFjVEZWL21lam81RDNuNzZYN3oxdW5WYkc3MS9IRjluTklWVzcv?=
 =?utf-8?B?SCszaUhDMUVZZWJGSWZEeXk5emtId2lqSEFLdHFQTUgyd3h1MEJ6RmFZMG82?=
 =?utf-8?B?VUkrd0VDcEV6eERudm1LQUM0cEpGMXMwNkttTm9oUy9sSUNkbTU2OTM4VEVP?=
 =?utf-8?B?U21TbFJxeVpOWDJ0bHpyazdVOFBOa0pZUjJ6M2FSSDhRMnFMa0pOUVZZaVA4?=
 =?utf-8?B?ajhYMlg4dXJYVVpyOElVTGs5OEUwTDltS2k3T3BkN1FzMEtyMkQzdEpNbjlP?=
 =?utf-8?B?T3NyUG9kK1JzN1Z2Y0xqcE9DMlhGOHZrRDRqME1PenJjNzdiajBlQVE4N0U5?=
 =?utf-8?B?R2t4ajRFV1ZVb2JreGNhTk9qL3VnSjVrUWpoY2xZNm9lRDlUTkFvUVp4dDVV?=
 =?utf-8?B?UUlCWTlXREJiK2hoNDJOeFpyM3FLRThDcFhQVFhhcWdxcEpNaXZwb3hnT3Zr?=
 =?utf-8?B?WFhNZmxEb2pJeFdkOHdFZlZReVlkREo3NkdDWjhvTHRUU013VzNzTkNmV0lO?=
 =?utf-8?B?OHRFN2VadXhOdnFGdTZEVnpJSk1IZXFrdkptZWw1enhXQTNDcUJUbkJvQ244?=
 =?utf-8?B?VnRJdFpPVk96RFdkeEZ5eHpRZVRpb2VMRDJvVTdhcHhyaWZ1dlgxeHYvbEI5?=
 =?utf-8?B?a0tBWXBFVmV4N2s4Wmd1U3FseS8weUZKd0h6Sjh1NEpBd3NYdS9KblZLdUU1?=
 =?utf-8?B?NlJIT2ZKd1Y5dTlsTURqVkZEcldxWEloWWtrTWNkSExxVDhDbmlvOTZaRlU4?=
 =?utf-8?B?R0VPVDNzNUMwT3VMV1N6c2t6cWxTWGZYQmRwS3BURCtnKzYxMHdKV3Z2OEcr?=
 =?utf-8?B?d1N2SVk4eTd6dVpUOWtuODFiOWxHMUR1UldWTCtTTnFYajhsUHpwSlhoOU9q?=
 =?utf-8?B?NjBvT0VLd3MvMjVnRFNWM0IwVjAwVUl4VzVTd3RxeSs3eWpjK3ZwSlhXNjFx?=
 =?utf-8?B?c0JGNVNqTm43dEJlODhsSUVZWkYwL1ArWHNtNzFQbWd1UmRTVEtCei9uWnBD?=
 =?utf-8?B?ekZxRmpqUTRRdTFTZUJFZ2dtaUY0Wk9JZ25kMG9qK2RDbUVybThCS3VGb2JF?=
 =?utf-8?B?MmRpWGVSU09yRzl5TTB3UjN2Y2VxU05tQkVGU2VJeGcrNGxPSldkS1RrQmk4?=
 =?utf-8?B?MWRvRjE3WmhLcUk2L2Z6T2tGTlphWUxMYWNvSUF5ZlN1VEF4QTFqaGFMNE9r?=
 =?utf-8?B?Y2lOK3JQbElnOFQ3SjVTVEMyR0RSYjB5cmdXUUJ6c3h1SFFQY011ajRSU0x6?=
 =?utf-8?B?aTlENGhRL3FiYlNqV0h5L1FyVm9mc2hsOFVNaXVtVzFhbVNIT1ZLc0tvbDd6?=
 =?utf-8?B?OHFkYUFod1dxQmljQjk1NDMwMEdwSmN2Vm40SytTd1QxYmU5QjB4QXNoVjdL?=
 =?utf-8?B?bkR4OStBTkpYZ1VSa1J6UDBZZkNQTWZzYVBPQ0RKekZUR2E3WXFTTGFyUkh0?=
 =?utf-8?B?YjdFVDhuamZZd05PL0tLTFlCV29uTzlqdy9VYitKNXljN3F6MUdMejNQMUNW?=
 =?utf-8?B?NzZ1RjhGZTlEb3BiTklacVpHUGxhMTZEVWJRclY4cnptMUFBeSs1UnZQbHVk?=
 =?utf-8?B?YkFtV2hMNWdqUENqaHFRVnhzRnNKeEJjWnRQakZkc0F2TWl0N3lJVGVTNFNw?=
 =?utf-8?B?QlNJMDZGNldYdEZ2RDFqMmpqMlFmVWdDajRzcWtvcWpSOXBuRFJFeTczQWhQ?=
 =?utf-8?B?dkdCcnJocy9QUWNITU1oemJlTngrQVVQQUdwdHV0cWhVSlFQZy8rUnM4b2pF?=
 =?utf-8?B?azVFZGt6Vm9vRkJobEI5TVBNTEJTejZDNXowNS9IVExiVk9NS1ZyRkV6WWQr?=
 =?utf-8?B?OTQ4TWpjbC82M21qbURqUnpVekFMdWdMN1Z5V3VEWWlnTnVPajlidWN3T3p1?=
 =?utf-8?B?U0l3UFpESnlVSWd3N1BjWDRPRzZod0YrbEkxR1pzaDVBQmdQejVsRU1Ybmx5?=
 =?utf-8?B?dDNUQ2VmSnlvNWxjSDhQbnVXWStoYU40ZmJ0TG9GNFUwY2lhZ0hYVlg2RUNK?=
 =?utf-8?B?bkVMU0NEUjZqZDR0SmNUSHUrMXpsa1JyK0lpWERQUTlidmdsaGlzZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f341bad-139b-4d9c-43d5-08de4e8ea1c2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 08:19:24.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fh7jGQjzxQnq/m+wJhCD3L1hhjAMX7gJBzS3irnKLucon769VxoH5z1kKKVrOs/Sy1EfyvIvfKgEvI3snnmCTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6978

On 13.10.25 16:46, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Jan Kara <jack@suse.cz>
> 
> commit acf943e9768ec9d9be80982ca0ebc4bfd6b7631e upstream.
> 
> When orphan file feature is enabled, inode can be tracked as orphan
> either in the standard orphan list or in the orphan file. The first can
> be tested by checking ei->i_orphan list head, the second is recorded by
> EXT4_STATE_ORPHAN_FILE inode state flag. There are several places where
> we want to check whether inode is tracked as orphan and only some of
> them properly check for both possibilities. Luckily the consequences are
> mostly minor, the worst that can happen is that we track an inode as
> orphan although we don't need to and e2fsck then complains (resulting in
> occasional ext4/307 xfstest failures). Fix the problem by introducing a
> helper for checking whether an inode is tracked as orphan and use it in
> appropriate places.
> 
> Fixes: 4a79a98c7b19 ("ext4: Improve scalability of ext4 orphan file handling")
> Cc: stable@kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Message-ID: <20250925123038.20264-2-jack@suse.cz>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/ext4/ext4.h   |   10 ++++++++++
>  fs/ext4/file.c   |    2 +-
>  fs/ext4/inode.c  |    2 +-
>  fs/ext4/orphan.c |    6 +-----
>  fs/ext4/super.c  |    4 ++--
>  5 files changed, 15 insertions(+), 9 deletions(-)
> 
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1970,6 +1970,16 @@ static inline bool ext4_verity_in_progre
>  #define NEXT_ORPHAN(inode) EXT4_I(inode)->i_dtime
>  
>  /*
> + * Check whether the inode is tracked as orphan (either in orphan file or
> + * orphan list).
> + */
> +static inline bool ext4_inode_orphan_tracked(struct inode *inode)
> +{
> +	return ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
> +		!list_empty(&EXT4_I(inode)->i_orphan);
> +}
> +
> +/*
>   * Codes for operating systems
>   */
>  #define EXT4_OS_LINUX		0
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -354,7 +354,7 @@ static void ext4_inode_extension_cleanup
>  	 * to cleanup the orphan list in ext4_handle_inode_extension(). Do it
>  	 * now.
>  	 */
> -	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
> +	if (ext4_inode_orphan_tracked(inode) && inode->i_nlink) {
>  		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
>  
>  		if (IS_ERR(handle)) {
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4330,7 +4330,7 @@ static int ext4_fill_raw_inode(struct in
>  		 * old inodes get re-used with the upper 16 bits of the
>  		 * uid/gid intact.
>  		 */
> -		if (ei->i_dtime && list_empty(&ei->i_orphan)) {
> +		if (ei->i_dtime && !ext4_inode_orphan_tracked(inode)) {
>  			raw_inode->i_uid_high = 0;
>  			raw_inode->i_gid_high = 0;
>  		} else {
> --- a/fs/ext4/orphan.c
> +++ b/fs/ext4/orphan.c
> @@ -109,11 +109,7 @@ int ext4_orphan_add(handle_t *handle, st
>  
>  	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
>  		     !inode_is_locked(inode));
> -	/*
> -	 * Inode orphaned in orphan file or in orphan list?
> -	 */
> -	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
> -	    !list_empty(&EXT4_I(inode)->i_orphan))
> +	if (ext4_inode_orphan_tracked(inode))
>  		return 0;
>  
>  	/*
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1461,9 +1461,9 @@ static void ext4_free_in_core_inode(stru
>  
>  static void ext4_destroy_inode(struct inode *inode)
>  {
> -	if (!list_empty(&(EXT4_I(inode)->i_orphan))) {
> +	if (ext4_inode_orphan_tracked(inode)) {
>  		ext4_msg(inode->i_sb, KERN_ERR,
> -			 "Inode %lu (%p): orphan list check failed!",
> +			 "Inode %lu (%p): inode tracked as orphan!",
>  			 inode->i_ino, EXT4_I(inode));
>  		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 16, 4,
>  				EXT4_I(inode), sizeof(struct ext4_inode_info),
> 
> 

Since this patch, I'm getting "inode tracked as orphan" warnings on ARM 
32-bit boards (not qemu, other archs not tested yet) when rebooting or 
shutting down. The affected partition is used as backing storage for an 
overlayfs (Debian image built from [1]). Still, systemd reports to have 
sucessfully unmounted the partition.

[  OK  ] Stopped systemd-journal-flush.serv…lush Journal to Persistent Storage.
[  OK  ] Unmounted run-lock.mount - Legacy Locks Directory /run/lock.
[  OK  ] Unmounted tmp.mount - Temporary Directory /tmp.
[  OK  ] Stopped target swap.target - Swaps.
         Unmounting var.mount - /var...
[  OK  ] Unmounted var.mount - /var.
[  OK  ] Stopped target local-fs-pre.target…Preparation for Local File Systems.
[  OK  ] Reached target umount.target - Unmount All Filesystems.
[  OK  ] Stopped systemd-remount-fs.service…mount Root and Kernel File Systems.
[  OK  ] Stopped systemd-tmpfiles-setup-dev…Create Static Device Nodes in /dev.
[  OK  ] Stopped systemd-tmpfiles-setup-dev…ic Device Nodes in /dev gracefully.
[  OK  ] Reached target shutdown.target - System Shutdown.
[  OK  ] Reached target final.target - Late Shutdown Services.
[  OK  ] Finished systemd-poweroff.service - System Power Off.
[  OK  ] Reached target poweroff.target - System Power Off.
[   52.948231] watchdog: watchdog0: watchdog did not stop!
[   53.440970] EXT4-fs (mmcblk0p6): Inode 1 (b6b2dba9): inode tracked as orphan!
[   53.449709] CPU: 0 UID: 0 PID: 412 Comm: (sd-umount) Not tainted 6.12.52-00240-gf50bece98c66 #12
[   53.449728] Hardware name: ti TI AM335x BeagleBone Black/TI AM335x BeagleBone Black, BIOS 2025.07 07/01/2025
[   53.449740] Call trace: 
[   53.449757]  unwind_backtrace from show_stack+0x18/0x1c
[   53.449807]  show_stack from dump_stack_lvl+0x68/0x74
[   53.449839]  dump_stack_lvl from ext4_destroy_inode+0x7c/0x10c
[   53.449870]  ext4_destroy_inode from destroy_inode+0x5c/0x70
[   53.449897]  destroy_inode from ext4_mb_release+0xc8/0x268
[   53.449936]  ext4_mb_release from ext4_put_super+0xe4/0x308
[   53.449962]  ext4_put_super from generic_shutdown_super+0x84/0x154
[   53.449996]  generic_shutdown_super from kill_block_super+0x18/0x34
[   53.450023]  kill_block_super from ext4_kill_sb+0x28/0x3c
[   53.450059]  ext4_kill_sb from deactivate_locked_super+0x58/0x90
[   53.450086]  deactivate_locked_super from cleanup_mnt+0x74/0xd0
[   53.450113]  cleanup_mnt from task_work_run+0x88/0xa0
[   53.450136]  task_work_run from do_work_pending+0x394/0x3cc
[   53.450156]  do_work_pending from slow_work_pending+0xc/0x24
[   53.450175] Exception stack(0xe093dfb0 to 0xe093dff8)
[   53.450190] dfa0:                                     00000000 00000009 00000000 00000000
[   53.450205] dfc0: be9e0b2c 004e2aa0 be9e0a20 00000034 be9e0a04 00000000 be9e0a20 00000000
[   53.450218] dfe0: 00000034 be9e095c b6ba609b b6b0f736 00030030 004e2ac0
[   53.730379] reboot: Power down

I'm not getting the warning with the same image but kernels 6.18+ or 
also 6.17.13 (the latter received this as backport as well). I do get 
the warning with 6.1.159 as well, and also when moving up to 6.12.63 
which received further ext4 backports. I didn't test 6.6 or 5.15 so far, 
but I suspect they are equally affected.

Before digging deep into this to me unfamiliar subsystem: Could we miss 
some backport(s) to 6.12 and below that 6.17+ have? Any suggestions to 
try out first?

Jan

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

