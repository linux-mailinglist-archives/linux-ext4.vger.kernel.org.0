Return-Path: <linux-ext4+bounces-14233-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELnJEkN1o2mwDgUAu9opvQ
	(envelope-from <linux-ext4+bounces-14233-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 00:07:47 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E39F31C9A05
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 00:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 693E83033FBA
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 23:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77413D6CD9;
	Sat, 28 Feb 2026 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VGXBbKPK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ezg/kazO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA7317156;
	Sat, 28 Feb 2026 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772320041; cv=fail; b=MdIAX6c4tkPaBboRcAMqVJaGRFSYUarc2+Vmj1B4NbJZXXnL3X3EkOyetCgPlCQ98yYvj/EqseoVF+uH3ZAZmsA7heKz9sfd8++eoYExadMHZNxsPvYH0T6voORIi4MVpAhG+jp8D1pMbFWzJXkEAwIr7jwXmeufwPAB1mGVzFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772320041; c=relaxed/simple;
	bh=xdJqHtqheS7vSGwY2BnuL97JRi2EmaUDFfzSwSwM+PY=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=TatdmpzaYLh1E7aLdgPN7qGHIumzeljhPzCxfyLTzpunbSa4HGLxvVmsbb+sVh5w2RBu57CTva0tnclxUJFk1iq16pavtx0qZF4G8CsxynHMwxrQ5R85QiYAMtU310f46IFPo2PMZuro3LQ8DldoTE4KOO+IUj8/hj51tXZp09I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VGXBbKPK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ezg/kazO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61SMp62T1623871;
	Sat, 28 Feb 2026 23:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=u7YaqEKUoaTNuSIdfU
	PGTpPEtauQ7HK2dA2vXYHcioo=; b=VGXBbKPKxr1sag8IX2iwaiG1sunWM6pNTM
	t31qo/gjcLnnjUilYgpJlrxZo10fl5XmYNcc0rlNrxsQjILMWvLmBAncLYRMU4Yy
	AcnusvTGrOveBcs4djuiOBvaYd7dc2WLJxsuVbwCbZKecb+o6vZ8cuy5o7TW+4+3
	gh9hF+NF6d7Vr5PncPTZXNEYdYnQwIqaEH1YlnjOGssqRdpHY0wFfj/JQN2NalYB
	LNzQS6Bj3TwlJ4CTQr9YjHu3kKJY0N4VyOAG/oVC4DEVDCSQOjVqDg9x6aahUZqp
	tFUqrDVM9mnuPd7Ffuv4Y+FVG1gbioc7tGKuoexTMzQj3A2MPx5A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cksg80mkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Feb 2026 23:06:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61SI4nXc034757;
	Sat, 28 Feb 2026 23:06:33 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptbm923-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Feb 2026 23:06:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bsy4Amhua3wRSQqQAOjiYfu3MuaOaMTpCxUUBlK30hZ7CiTjAGvzdEkCh4CUEMO3MyXKr+CaWh+9373C0hTjWR/pM+oYQRddk6APoASgYxLM6Pjw5BnU+znKv+48/8Aq23Xfya/bZmZXw1x28YoYxRURyZ4BWdooK0GIuT5DU5OUndlHbpGoVS0wHTBICYJzgstAiwr6d75iVnBQ1kXhpfsA69elc1GQnfmNtcPIVJlt9nYr7ZE4tQ8/vr4uKLjUtdy5TzoH2K9Ht7CDb0Rgv1kEUglQpWK0Xyv+ya4VZtEhqmKtgbG/X9oQSXdDlYlIsyaYiRAT6p22JN3dj6dnEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7YaqEKUoaTNuSIdfUPGTpPEtauQ7HK2dA2vXYHcioo=;
 b=E8+e6Koj5TUqDdW0oqe0a3IKAruvfQNZdtvCZN5L81Ya+8tkdpuj7FlbgHmATcEDZ5dpJzICyPKfMTGuDDgOWdl4umynnzUTenPqw1OZ6OH1lUjZLqp69X4eoN53XuFFURYvHGle0KrjCmjOyN92kE9IMHtq5ocncaduFbWaE0FsaB92X9miyQFjUb07S5BbByeetIEA5ZUGrneW5p6vh9boocjWoc6ggsh9twikQBrvXrx/BAbvM0teCfbbvY9n1yelLql8BXClonFr7tobBHjwlPh4m11t8RqaYR4BWf28CgfaxPbTCWymmmj1qO8M1xYu8yrwba4/3kayRPJYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7YaqEKUoaTNuSIdfUPGTpPEtauQ7HK2dA2vXYHcioo=;
 b=Ezg/kazOQhf11I/OTY48SzO/KzqGCvQyCWA5n41is7gR2FTNuWJAc/IdDGZZj3A7/eSHzNRgibSBDuwE5HK0tSoKrp4NCQ0cUAKQhjQzGp49h+nnCU5f2HKx+pEzUAE+YVsYL8/xnLcInaCu3PyLKZlVChOk1e/O07tx9leA+xQ=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MW6PR10MB7659.namprd10.prod.outlook.com (2603:10b6:303:246::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 23:06:29 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9654.015; Sat, 28 Feb 2026
 23:06:29 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Song Liu
 <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
        linux-raid@vger.kernel.org,
        "Martin K . Petersen"
 <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] block: remove bdev_nonrot()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260226075448.2229655-1-dlemoal@kernel.org> (Damien Le Moal's
	message of "Thu, 26 Feb 2026 16:54:48 +0900")
Organization: Oracle Corporation
Message-ID: <yq1ikbg31uk.fsf@ca-mkp.ca.oracle.com>
References: <20260226075448.2229655-1-dlemoal@kernel.org>
Date: Sat, 28 Feb 2026 18:06:26 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::44)
 To CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MW6PR10MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b1a183-2b01-45be-fe42-08de771e0129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	CjMsQKTL0VHrh1tYhxj9fmeIaR07K1f/36LbfoTsELnIEjR6tX9arQaCHS03k1Ic2metV+0+/2O/yg3Rvy3Z8YSWRuhzRRF9JB7rjoNl6ovym2xELhZghJovaF48osEn14elLVFIZh1RYUIGm0UxKxtczl48Tp5HWgnokVqSUczanZa3Hr6dO8jLgx+A+SGUlaNUwUKeqdlUtzkcY72lBs755gYw6tod/COq1z2Uutim6+JrMq/aGHMVIIMp/3Kgy0dynFgST/1gRWi9vcsCNgBuReuKgItv5Xixm3Wp7jYfkD0Df10vNo1++KGwXxPwhs9Jkz61znmU1Brgfn8dS7P0fXEhpFhTlYn1td4phduNdtuFPHjx6EBaJetJQIOzJAV5mKyLcjn8uhZEzoBU8rAu1uT3q3y47Qecq/GpiJKo0+r36KKzX3ar7z1o12/FKLxkTdCJqC85pdmVXfmU6uOQBpFgCIOE9lH9wJtncnohef8nw4IsqNgXeq2cqFO81TDrDAxw57z8AxRyD95emLX39ddsi6+rJUL2KV8Bk4nY9nYpKRUbAyo11krC/zl5KpnAVVkEq/2a99VtP5eLV11rXHld8nuykzwWPQH5tc5LM4i5k1UYLwLTbsdl9RPZ+BWpJDymRPqrodbQDXEpYaL4xXup0kzNt7/D5UjDdsBM4xMfI+0yYCi8ribYh1EKhnB4/Cb6hUj9feTJfZ52WZ0I1RDXKDCHyyYWTW1N7uA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?poINlQp0cwOhEdL/+bPXbT2IR93F7u++4lNzqul6ItHFBxmBlgVNxf3l+X8v?=
 =?us-ascii?Q?/zEsxm7iigQav+8YJrW29f+9kW8cZfX8UXJItzrGb6tbQQ7j+G3/NPk5lGTF?=
 =?us-ascii?Q?mbbGFcSThEynpOnHsETrVM0fB0S8eLOGBxjfFt6NGZ9VhPflFVmDNRE++T5y?=
 =?us-ascii?Q?uumMgBE5YH6B4wlcRleMITP/G26up2zZhiOy5CXAnW0OY//7wMPMfzwDFebc?=
 =?us-ascii?Q?n8CO+4Lne1VhABOGlsTYWSsqvHDuQ5YUI9lHLPezc9smcjzhz8wX4ZXspmTf?=
 =?us-ascii?Q?ahRlTHteQCWJxcmwx0zYm5O1XntLtmmPv/cq12WKmwOXMzf0JgwAEATthjig?=
 =?us-ascii?Q?4f/Ls87Eu8AVONtB6yWhZLhohIt8ntBmvWc8fM+qlrWvUPhb1PCgU1gGnt3l?=
 =?us-ascii?Q?kkehewYeytZjbUZ5csK7DAmoEsu7NomOcvxA+7h77jj3L2AjuD2hJ6u/VQwk?=
 =?us-ascii?Q?23QJVt1NyaNM3oud83j9jUwRURlbquzZF0t92d9dey+IY46HztjZdHhNHPtw?=
 =?us-ascii?Q?UBW6mruP0GV3LZDmpTcPrWFtbOVsMit/wfrxyzF4A/JzcZC3iq8FlQs1gYKd?=
 =?us-ascii?Q?4npZzFUGE3njGoWtZ4uyVUfuEdakWmUMc6E1AlzHIXA96PMWGlA648pQMHdS?=
 =?us-ascii?Q?wQWFY3FP3Q6SyFhER6o5Ozgndfr29goYlz+puMq8V5OxDmMYjtsoxK5hJBf3?=
 =?us-ascii?Q?wjdjJMhVVW1Qh68pN7tkA2X5H8SI08eU6PLozEonBkH9Dnvdqp6dkvL6dwPY?=
 =?us-ascii?Q?aucSjQh0++9WthklxcLMwv2Ijcpz8S+mwYrPTdtcK1apd07Dfw+BtupvekSW?=
 =?us-ascii?Q?3KFaPpjJRoXkO9p5cuzdQOI70n0XVgm6lYZVMubT58vy6PoxldpHX8GTukQ6?=
 =?us-ascii?Q?1aZrlMYF1n0/65Ga5Dc5ogN1WZPicQQOkeZZSvRaqz1NTgCkeG7szIeSKptT?=
 =?us-ascii?Q?V/C6EW2/cxCXrc02bsjKPaPgZeaP49r4+yjS0C6z/kklpSp8KxKnXfuje6SC?=
 =?us-ascii?Q?gvR1UaDplveTuadvHVzLwb0jWzoY01kaZy77eROkjmbcC492O2sx4od7sj36?=
 =?us-ascii?Q?PLcsMhQ8x42zwTErnqn4cQ9fIp8cghn3pqXzGfraERtueKfG4qi55OQricmi?=
 =?us-ascii?Q?cGoTF2LvAZG3BPQ40HPCAo7IEkth8UBAFJkjOt+/8wOoJQv4J4TuakLACJTg?=
 =?us-ascii?Q?i2F3SwkPGl1CuVk8JiOQowE1bcotWbf7BwvORUoeSFkIsRCMHxQJWZNYa3O8?=
 =?us-ascii?Q?e+QKSa3Yb8jPV42DpPkiN2bALJoRb0be5LUMBSNTkX7hwhZDbvZEEQdsWFB8?=
 =?us-ascii?Q?hzow4uQ2duT3/sqsr2hmK6BgqeUgQWrMdIenlS1GLMuJ9+3+FMpSR57b5jiH?=
 =?us-ascii?Q?DapcbmTe7ZBkjz5DHQfaStJSx38/p5DAZfCd7Rd8QIyQQUFVw1DgN4vVwQB4?=
 =?us-ascii?Q?zgiPokJmlKHClQmgTXeaZQtR0/Cz2EZOOuYMPRI93OULgPJoAggySj/wNUW4?=
 =?us-ascii?Q?LIcJFQpKbqAVsxviYExq6aevwAhzCWLniChgff0KCHIIeK85kmorp2Cia7m/?=
 =?us-ascii?Q?LnvSk5sRHoOUQ6ZtDQkLSWxYylntfUH3beQbBss31kG1qIxZO9GZJolNScrS?=
 =?us-ascii?Q?FJUqp5gboaB8a1vXSHZ/T5HEd07SrFB7PbZW9kWEvK6qvANI8Kbymn3gbrF/?=
 =?us-ascii?Q?AOBnhqZO0f/EO3wNnkaTf7FIjR78Rz4vxzPFrN3xiuOuWedqqERpnJtaN2Or?=
 =?us-ascii?Q?G8sC5YFcP/yn3d3Rao5T9bJYGLMktEA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Dal4dUQfnkRz4UynFrU13/mHqxX7t4KdW3Jjp0haqVamvTCE6YPZB2uv8Y9Ju85pGdbvITogXUweq4ybG1+GnAfpOercLmv3Z30OA8Y8AJ+5QStMj3lCib7BkVVIHVHQJZpAsHMS3X/F9UQ1P75L+LV8cTo+bmzSVPBmo8H4RcTlXai64m7fp+WD81WA+UEWt7xcsd/SegEf+SyrPiZByd1ygLov2kTTaGY+TNbQKoXHoncERm+eC2pIdU52259H64ldmVzoNr3G0K5GpAVHqicJVoh9eBIDX6d/xaSCyVWYiJ/lvwluG4eOTudvE0J2hDAz1hqfLL3vvc2Os14CA34DmsrVGEXzITGO5bqo6nQ/yFGl0rx7z2WPAsawjnJhOzFh2vCH80cdFqHmGXBuENkWzkJkQoajnDA9uZWT/S0HlV2HKNkckjbyqbjjy9JH7nq6hN+GM/Bfi5Nc3wHRBKcWAmR1TTHSOUGWEW3BuiGM/ziAw67ZBIq1WDtS/D05ZDdePgIvWtby8drtrdWzArUscyeZwaEaq7mfXa/5IfW67rFZcx4nQ3oTXiQJVev2RBL3wzx0ZizwSDCw1/3NXiyVU4hycA0YYYrgkP8+Zxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b1a183-2b01-45be-fe42-08de771e0129
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 23:06:28.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyT3j3vq4vN4u0bCSyxS8L2NA/aHB9b0pPI402HsfGL+nebFUgXl/tz4KhfpXJLYJvC0okUCrb7Nwx/FIyxYPlayUYvSMqyYyd5WcYCXgAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602280215
X-Authority-Analysis: v=2.4 cv=bbJmkePB c=1 sm=1 tr=0 ts=69a374fa b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=wrmydrnNtcTXJaWCz40A:9
 a=MTAcVbZMd_8A:10 cc=ntf awl=host:12261
X-Proofpoint-GUID: RCtAhHi8dso2TsurLMlOfxgsb1nHGR86
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIxNiBTYWx0ZWRfX1k/VdyluxSab
 57XNVqV8uRE4OpW/j1NgqUpsJZ4TjYOKBmQFO2ktC9HanFZJiZg/ExmTYWmpCVzZd9wM7I50HkG
 emRRFHIYq9bjDh4m+DWtI1xT23GXpHrDtLCK+UorgSDbWh4tC4W1d/YKIR+QIFIHp/pYTiAkB49
 4OOpGEV+3UO+fyoeCMMW/aIeP2VHCt9If1wTMCKmwqVqH58EvD6d4l/5H5hXxlAT+a7J5H2pnmB
 FgfZIxi1aV9r/OFBdNv2r3j1B2f4SWWB9A25vM3vy4MPYXc689MG81kYl+WjxiQHy+x9co+WXFm
 xZPDKSH3qzehf07hbvQkEluJc2f0yW2jmZ8xbfr9VHYd2xuJhe5R9lDsSIUU0hTdXJ8qJvW/JNi
 M6oyUE6vPtgjArNMBtvW6tLS9dRoUGIBgmzOhu1UpJAx6wUbJMXZmUFDqWdinBvnHZFk0pCKq2O
 HRo5xb2Kc9w7h72Iyw3LdC0NtkxJI/BOCDbSajts=
X-Proofpoint-ORIG-GUID: RCtAhHi8dso2TsurLMlOfxgsb1nHGR86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14233-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E39F31C9A05
X-Rspamd-Action: no action


Damien,

> bdev_nonrot() is simply the negative return value of bdev_rot(). So
> replace all call sites of bdev_nonrot() with calls to bdev_rot() and
> remove bdev_nonrot().

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

