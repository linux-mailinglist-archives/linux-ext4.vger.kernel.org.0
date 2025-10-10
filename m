Return-Path: <linux-ext4+bounces-10774-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1EFBCDCD7
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 17:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DADFD4E2813
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37FA21579F;
	Fri, 10 Oct 2025 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="Fb54V8hR";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="Fb54V8hR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020079.outbound.protection.outlook.com [52.101.188.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBE29405
	for <linux-ext4@vger.kernel.org>; Fri, 10 Oct 2025 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110221; cv=fail; b=l9zwrsu6b9Ytyq9XATFx5StZnycrPqmcmakLcT1x58282bziX+glg976vHCgwypfd0h63QvZ32GCpJ/Z96COrvUCU1vpYkUjfzFrQnfygkq1yu+zcHJtphLuhQ7RW9EoYC0qXbXLnh+r5xvXrXUMCX5gm+/mbJPaxdBt566mk1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110221; c=relaxed/simple;
	bh=AEbdz03Ur1THeqceiYSdxJ38RMtPsMJ2PJiQrJC9y+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MWzXHjsF+GiMf+oor6hopJvfJcwPj4gSZ9lZl5r8VWrm8RAVW1hndBLgG1irkflERyfMOQ5aEaAylDt474rnTwjytJmp5OF9LvzWBaPTfjp3zSzoURhGZ1VA6dAILZE912BobgGNCFm0SvYl3Mms6J1WummABCG1L80YxeLlqHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=Fb54V8hR; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=Fb54V8hR; arc=fail smtp.client-ip=52.101.188.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhY973c26/hWzmoHIlyAL8WtZNRd7OO5p8SwpMtpANgk6sbrplcAblqaKG1YHyDmDarMf+GZjEg3kKrJ0lnjXFUm/kb37tpcXnvO+vleOlrYbNDBx2D8Rha9OetSibdBgVlBKcfE+kafIsfMd+QeoNvwY0NYhlTcjICiD0tprDoMvwFAsttMItvxWnr3eSH0y8gFSSfsCI4jtnjkV2kNz6ceUFFJqeoXocjFkQm2NHxPZ1km2w/BzdU0V4+1rQb1QzV02p4QIVJ54rheFcQuufZJ95jeHNNkz0jJK6S/2DrKcC7jQpD54VEmrF9lStx9wkB/w602LWSzJ8RfrPOJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSYOV/zjaR6v1+grqHN8Do0kooS2G1tgPIbk/gSsRk0=;
 b=JoD3YlNiScRjEbKDirUikXbh3Q6b3mE6pU7JLNWHkussAvGBpVkDreMhHp508unPKXK1hh8kBq9kR6YQ1OQtikGZAHFwXQz7zxqjv0V4HVhOHKcoJOBou/bMAL8X3nBCSY1ZLhJ3OUHnZ9yRqKbgqUIFb+N7ar+mbppXOYp2Qvd6QE+FdsKbvWaG1ZeqEY+UDjyrU2wqNTlMJ73s2852NLuBjuzz9vSREogggiLDpEOrmKuuiAynaV2IYCI7wpF5P5It5omHgw1lpXnzxdW6PxCMjIeUpjGtvAQgUTXcTM5Xoy1JSenCVlP4lt7Sebf7tL0YBNOTxUmhTHgNn/ICiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSYOV/zjaR6v1+grqHN8Do0kooS2G1tgPIbk/gSsRk0=;
 b=Fb54V8hRjmhq1xUbSyUyKans7ZcwKKGVYuTAq25atnx4rqkZExTrKqds3oVGpIcemo5lM5U9VAMCc3kfEgIB1uDmAWd1LPtKSjb5Q3TPiJIOTB4uOO3mYY8PUvzAPEKl9aLZZ5VoZ6rpaFQcyN6qFdqo3ci4znVA+W8b5hs2yHQ=
Received: from DU7PR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::11) by ZR3P278MB1282.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:72::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 15:30:15 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::b6) by DU7PR01CA0016.outlook.office365.com
 (2603:10a6:10:50f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 15:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Fri, 10 Oct 2025 15:30:15 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=Fb54V8hR
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazlp17010003.outbound.protection.outlook.com [40.93.86.3])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id 7CED6FC95B;
	Fri, 10 Oct 2025 17:30:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSYOV/zjaR6v1+grqHN8Do0kooS2G1tgPIbk/gSsRk0=;
 b=Fb54V8hRjmhq1xUbSyUyKans7ZcwKKGVYuTAq25atnx4rqkZExTrKqds3oVGpIcemo5lM5U9VAMCc3kfEgIB1uDmAWd1LPtKSjb5Q3TPiJIOTB4uOO3mYY8PUvzAPEKl9aLZZ5VoZ6rpaFQcyN6qFdqo3ci4znVA+W8b5hs2yHQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::15)
 by ZR0P278MB1601.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 15:30:13 +0000
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4]) by ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 15:30:13 +0000
Date: Fri, 10 Oct 2025 10:30:09 -0500
From: Dave Dykstra <dwd@cern.ch>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 06/12] fuse2fs: fix memory corruption when parsing mount
 options
Message-ID: <aOkmgQey0t2AKSZM@cern.ch>
References: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
 <175797569727.245695.9292992844444922508.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175797569727.245695.9292992844444922508.stgit@frogsfrogsfrogs>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: CH5PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::11) To ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:12::15)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZRAP278MB0096:EE_|ZR0P278MB1601:EE_|DB5PEPF00014B89:EE_|ZR3P278MB1282:EE_
X-MS-Office365-Filtering-Correlation-Id: f69335a1-17f7-4482-de0d-08de0811e92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|19092799006|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Y7v9RkGJEFIC8fXiqki2F5NiEE/IaYXxHHdZ3k+xwoFZmRC+OqRGg7xHWwCC?=
 =?us-ascii?Q?nwRTHmvJdYqpmwvF4sABPR33vI+KGYCSgReDxIZKZVtoiD4JQ8LoNVWHTut1?=
 =?us-ascii?Q?sp844jBC25vAwmR2DsLwmqwxiMaCAuTznKVU292QfpLfHBlyWX+6ombbzF3Z?=
 =?us-ascii?Q?a2BiJZS9CEGgWBar794PlycJOLnn4CAdwmsjzKAHCkfIBKS80GI/Wd312HhE?=
 =?us-ascii?Q?a0F4SnltD1993Zm/pMiw/LqQP/WceQV7O+NXrqsIsP1kNaMCU//gmRhOTqM3?=
 =?us-ascii?Q?i0gEOnaK4U/RZ7OO1fIDRJ196rJXHE7u7ZYWQcEBAief93iTtB9siCt9eSLR?=
 =?us-ascii?Q?VTvGP341OaheB8Lx8ZfPEBcSECjxeq3Gas3/YERlN2+/HnvscXT/Yi4Pg7es?=
 =?us-ascii?Q?9VlHTOtt0R2wOBJzuUwTFIHiUpS8x3cRIxrutVkAxJbMImdhheOlhd4UJGgK?=
 =?us-ascii?Q?noK/e2taHoP6WQN+pOs4HQWHyYZEobgCYHukySObNnpuBjsvG5IWIuF7Yop3?=
 =?us-ascii?Q?OtXlnn2Kg0cpT3S4L0YR/SunyCVmQOBfjei2oIGnGxRmadM4CdQg/L6fMX0+?=
 =?us-ascii?Q?Kl6r2QNMen7lETk9edeRigH0OnGUkf3WRi2NZG3x6Qj8ZSJAik1NpdeNll6F?=
 =?us-ascii?Q?TLiY0zV0orauKhFonpfq1b32S5rC67dxsv8luQT+MMJd+ET6t2gR2FNDlQhq?=
 =?us-ascii?Q?KSU6IQ5P/Mmfasen5mrgWRz3kB1RaCYjMtWXtDY3l0qrFjSbrEy5+XiTw0G5?=
 =?us-ascii?Q?GodGpU6Ff3c3+ChCLYnpl1fE0OyWKPLaUS6aTK1dqKgoVUh1yd4GkMlNMv9/?=
 =?us-ascii?Q?rwYY+zYCPEAd1yt8FNTS4TDI70opkGCS3vocKGcIcmdCF8asKsLcC+PHDKz6?=
 =?us-ascii?Q?RqkdJ0VEGaX47I8BKX4kyYDPYZ9qCo9tm+IL4LHkk3ttxIzzq7M/0g1EZSmb?=
 =?us-ascii?Q?zZFl0vrZGtzhkQNfjb1fCovg8YbYK0bntkPG10HzLBZijhiQZk7e8cxGDOI2?=
 =?us-ascii?Q?Lr4/4rtKWqybd4lyvQ57KnlIlgJd+az2dTPahMsjsK4rBGd7/QmQ5R8lNica?=
 =?us-ascii?Q?sjgjR1SQUvfLPmLHPl7zKws1NADP6bt4NThwB8c5Bqb5Nw/7jtiPFn3/4ECg?=
 =?us-ascii?Q?JcZB2A1CtPaLbSbHXGDS23AhJyMcpxmrP6PHw1Mi2Qct93AQF2JHpVBnT9hj?=
 =?us-ascii?Q?4AfN6D5tEyEKdlI3XRyJPbBPyHf+yQ6VojMtAyEVLTjUCiewpChO5a53IBNC?=
 =?us-ascii?Q?vu1Pv0JZUv6R4N8x2tNpSHorx2CNeaGuMHP+sYptkAcfF3S2baRS8A1wqleL?=
 =?us-ascii?Q?YJMXDwyf2fp0L8NmY68bYCOp8CBDHerQmzjkr6HI/wS87EGzbmVne5EYpIqV?=
 =?us-ascii?Q?GKgLMhUpgm66qHAHghqtB6EqbwI7OIwRBLAWckwWMNdtk0OA9S6/tvBMqV2g?=
 =?us-ascii?Q?701TOuilyjBbwMoMHOKkAuelRMT/QuoSaIvlNFcBuP851D5XYK9gzw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(19092799006)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1601
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c937e589-a620-4a42-0d2d-08de0811e7f6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|19092799006|376014|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OsPhSxqjvq+pnZNuoDQHaeWNJ1R4//dsGGr9Vqc7z1a+/EX59C3OwRkbFPLt?=
 =?us-ascii?Q?ZZb7YvDpj2J4y8pSBStmxIsxeTlzhkdimUL0OQVUyEYF/M0+mHlkixNq2dZD?=
 =?us-ascii?Q?oH/lR0HSo1kf/iCCL5yO0wEL/AC9Mfwig+ccTmiO+IM9eFppN46dtDyMf1d6?=
 =?us-ascii?Q?lAiT8O/19eI3FDFbPawCZ1wWfRV6CDsJYLX1eqRvi5l0P9R73/3txhDhBeV+?=
 =?us-ascii?Q?7FZRdkWotYERFbe1vqG4fqFcEIhvdI7I5sUjQFFNSZRvdwH0oPcS/CkXV3Ls?=
 =?us-ascii?Q?L1jjcc25S3Cb6YJMCOAg5LyOyvwD6S6StUhzrivjRXJzpz6CKmxThNxNUUPJ?=
 =?us-ascii?Q?+cZfJncjBqR82TS36WzHjfKteJ7Wo68tAI2VLm70419zu+ONH01rEpyiQWr0?=
 =?us-ascii?Q?fXoVJZ81kvDlwRJvzmVyBRU0M534eEhZ/1L8jiVw77BwBCMOE6jXhmu9mkB/?=
 =?us-ascii?Q?n3SFsoLQnl5O8hjC8wKWTc/3O1GBrk1JSuVnl2+2SCeOV3o/Esh+gQLtRNQX?=
 =?us-ascii?Q?latwp9c79m6FrJgz06tjCVIPNSpaZA4KT115WYRiTYBlq01WrZ2R+vfMM3yf?=
 =?us-ascii?Q?Anws2HtHT16RurYJXlqN49FQNmn2lcBSBWGEA7ooposxmsisSlKjjWE3ljxD?=
 =?us-ascii?Q?lXFdRTbmZnEFeaGNSb5ukAsNJeFZmS4r/F6irzOCdgyhNGqMgblleDlR1ir1?=
 =?us-ascii?Q?/0AJoc/lOkdBxkMYUsecu7pG053D2JEra0MxgGdCd5B5x7Lgkf25vQrhQlGk?=
 =?us-ascii?Q?dWulaFL35HZh/VWR9gsQoKjMejeg+YC5FSdHYkq/ftCvq+0/VnRVSA1vz5Rb?=
 =?us-ascii?Q?DDz6nq5LBp1NoIfLZoZkFTCxubIsP1ZAYntrB7EuF3nfFLfoD0UGBJ7BtMle?=
 =?us-ascii?Q?NG36rK0Fqk+eUlqX6k8EuiSySc760jVtRrqTtiysqFm4M/ACgvd3GovTt7cg?=
 =?us-ascii?Q?824Qd/gNCSbnsaHo70g3z9jtPZIYbnbq4/m6wx6urbCzZ/hbLwcLEh1LysG7?=
 =?us-ascii?Q?1Xc7yOS8I7feQUsq22a2bMiUQSKJcP00qI+W5UuCM9ixgcaoMun2rruo8WHb?=
 =?us-ascii?Q?tzePOM9QgRmo5SIhZhOs4Mh0fjDw992S7I9H0gXUOxuEBabv0Nje3C+i+qFa?=
 =?us-ascii?Q?AcVFG7IokdwWzDV+LdGCt64MOJmPz+typ7DC/9XI86VRadfkioC6zWSnKu3z?=
 =?us-ascii?Q?IobMlNk/leVDMnjukjp8Yxjx/4PftaoN6+/ZQg1f01CttaJAsLaOp5pLJHzi?=
 =?us-ascii?Q?8z4qiW8+65M5T64yhl5xTqW40SnmgFZ5427wiR/rwjHRN+3du87Kg9UeWwm1?=
 =?us-ascii?Q?N9km72GbG9ub83/448X4O+cwjdmGmUpHKn7q+1u8q6Nx3AgyBIShVWSNwaje?=
 =?us-ascii?Q?0gNt7c7lIERUo0bssymYl6xwo+vlRLLss2ORdPUtKGPOZNWPnbaj92kubmI/?=
 =?us-ascii?Q?yu9ajY3ejRQlhXjMegWlo9R3CEzdBs3GzsI50F3nj89nrfSeJA+sbeQQoqyb?=
 =?us-ascii?Q?tk5Q46cCfHYzERa8pbZjGPx54UY4LgtIbwdmZt8q+/ATrtYdbQEeJvt/Y/2I?=
 =?us-ascii?Q?RoiescAFJHtJnto0PbONb62a9mPjqaD27y4kHQn4?=
X-Forefront-Antispam-Report:
	CIP:51.103.219.121;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx1.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(19092799006)(376014)(35042699022)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 15:30:15.1293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f69335a1-17f7-4482-de0d-08de0811e92a
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.103.219.121];Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1282

Yes, I have tested this and agree it is very important and urgent to fix.
I hope it can get into a new release of e2fsprogs soon.

I submitted an issue about this at
    https://github.com/tytso/e2fsprogs/issues/245
and an identical pull request at
    https://github.com/tytso/e2fsprogs/pull/246

Dave

