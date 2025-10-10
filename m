Return-Path: <linux-ext4+bounces-10772-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C1FBCD9A3
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 16:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E419F3A9C75
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B202F1FC7;
	Fri, 10 Oct 2025 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="CWiwCm6F";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="CWiwCm6F"
X-Original-To: linux-ext4@vger.kernel.org
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020083.outbound.protection.outlook.com [52.101.188.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B034BA35
	for <linux-ext4@vger.kernel.org>; Fri, 10 Oct 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107693; cv=fail; b=JlPZqvG9vUPSmwk1DmRv5+QDeTwqrwuLxphej2Dvpf6D9Eer3SYExX94VCPdPe0t7t+1ec8oJvQcwAtOhVwgf0lqifHlc/5wjV3Ql/brarroANLjt989tw+bPYbrNEUz35E7D6Ul6VRqC06dOqY0E0jz4lW9OoUJInNPhcFTRzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107693; c=relaxed/simple;
	bh=eqm+r7mMPSP7610y93U32F3MKNNQDWXkyejLY3jdWu8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=h9IsaSWigCQenbI4ox8kOmwR9rK9rStmpo0IyqOs3NSaRkDP9eZq4MTzrdD5ojHYcg82CUKnxauQD4VqBSrKu9xo6g2lLjjR3ncErHhv4iDu/0TgxuLc1zZE6/8a0gll5XHSW6NAVlPyuZK8Mh1hwSlSl9HsmbksVoJLC2AcA9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=CWiwCm6F; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=CWiwCm6F; arc=fail smtp.client-ip=52.101.188.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmQrRMNWTAxi1UvxJIhfvbqVTJ5LYIfaLnp4IiR5wqNWS6ZKJyC4FCYRns62B0YLJYMq+QjsUX2r/95nIifSknSsdAy7G19RvpbDh1Wc2JGha2F1i14BPRMBy2VYQcq+NLBK53udB4UTXYzv7zwF0dUadynMmaMzw4GfT7hxSKs2veKSqpkqK4ZvDc4bq+QMryzXk3NMPe4Og+EpiwSPhty+y3fNXUNOveC65g8b4M7m1o0fzYsjQ1D16DAaWZ4+74UGueogP/H4nm52VK1VQi5BJH1AJG3cMlBpSkIRTNcB3p/yrugoOibQlKRXjd5RB366UfqDasCa8nR/VvMIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRGUwFoBQw1tUi22F9v0LNeDYUhnj+CjD/GVkjVs2+A=;
 b=vfRpvqqaTuhSuE2GdTdFr1NqzWIboQ+jGIiny4cSNPZUH6BDRZ6KQzWSQivcQNCJQbl3ZQQhVgLQb2t2ZPCugCtEWM6gvs51dvS4X79LnoxEgK4v7CDuFpyWOlCTV/D8lqaTRzBOqXVqyoHDtKp3YOhelEIvQresU1/4Z4qN5+ACaWojNwCtnslM68PGh6NJNiSe5U34pi8OzHY0M4hyraFBBZuIBbtLGP2Ok8pPnPRnMP/thKHVBULPyvcScutbeuTWs1oYXcSqAn48x9hs7H+Zbjo9vvDJfJ6Hw7r3k0mHmj9zjNmC/YU4z+MCLwLcH6MlAcbW4z3VGN0ROm3TTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=users.noreply.github.com
 smtp.mailfrom=cern.ch; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=cern.ch; dkim=pass (signature was verified) header.d=cern.ch;
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRGUwFoBQw1tUi22F9v0LNeDYUhnj+CjD/GVkjVs2+A=;
 b=CWiwCm6F+E/quiCZ9kjeMSU0t4E993R7M8wgCooAJe5cYycCrqqGRJwBe4wLDL3sA13BOwcbrWll23wyE1J+GHl4PoqbqMKQb/REfHlAY5E9L5u3vSD419X8KsVFyVoJ9EkKx5wckBGeg+2HfgW6vlYan+Zn5HTcNz7+HwsF4v8=
Received: from AM5PR04CA0024.eurprd04.prod.outlook.com (2603:10a6:206:1::37)
 by GV0P278MB1504.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:66::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 14:48:06 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:206:1:cafe::21) by AM5PR04CA0024.outlook.office365.com
 (2603:10a6:206:1::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Fri,
 10 Oct 2025 14:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Fri, 10 Oct 2025 14:48:06 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=CWiwCm6F
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010000.outbound.protection.outlook.com [40.93.85.0])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id 18E2EFC951;
	Fri, 10 Oct 2025 16:48:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRGUwFoBQw1tUi22F9v0LNeDYUhnj+CjD/GVkjVs2+A=;
 b=CWiwCm6F+E/quiCZ9kjeMSU0t4E993R7M8wgCooAJe5cYycCrqqGRJwBe4wLDL3sA13BOwcbrWll23wyE1J+GHl4PoqbqMKQb/REfHlAY5E9L5u3vSD419X8KsVFyVoJ9EkKx5wckBGeg+2HfgW6vlYan+Zn5HTcNz7+HwsF4v8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::15)
 by ZRAP278MB0160.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 14:48:05 +0000
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4]) by ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 14:48:05 +0000
From: Dave Dykstra <dave.dykstra@cern.ch>
To: linux-ext4@vger.kernel.org
Cc: Dave Dykstra <dave.dykstra@cern.ch>,
	Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
Subject: [PATCH] fuse2fs: revert change of storing boolean options in bytes instead of ints
Date: Fri, 10 Oct 2025 09:47:58 -0500
Message-Id: <20251010144758.11944-1-dave.dykstra@cern.ch>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:610:33::13) To ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:12::15)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZRAP278MB0096:EE_|ZRAP278MB0160:EE_|AMS0EPF00000195:EE_|GV0P278MB1504:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e96e19a-9219-48e7-150c-08de080c060c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|19092799006|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Wo8dPqTP58ml0S68g0sQ/XSdv88fwvPm3TE9wGUfb5BKA+KqVJMt75sLVc45?=
 =?us-ascii?Q?VcUioevwwGxcRSC4/YsZBPjhO5U4SMy88C61GLsAZ2+Bd6gAUOp/P9dHUSg4?=
 =?us-ascii?Q?x/fQaPUuDZw+NWceRXBZ6yS8wCHADjYUwNVs1U7xGj48U4TEcuFNLu20lvWR?=
 =?us-ascii?Q?+9zQdFDsdW4srVP2YSAKs9v1UKmLv6arqhBba49TNGgnzED8gfL5jXx3qXkh?=
 =?us-ascii?Q?n2zPtcCsxctWKuogxKQnPLhTcrpsDWWOQ76dUibqS+9Oy0vUiJc/FKWhF5BY?=
 =?us-ascii?Q?8XhKSS+OCAgwN41abWNXJQmv+kh+uUWCz8enM8Fy8FFlSaEoaV7Kasa9r3Is?=
 =?us-ascii?Q?qh7e6W+Fxo7VE0kfe+pGUwH3qkjo5wvQtqBYwcaJgNRnAx4i7iUDjvgQMshT?=
 =?us-ascii?Q?29oJSEZh9aWfAxmt0hhZv7RVWnY5KqeOYk/NBpuIQnZzYo2lbhtI9YI5G8SO?=
 =?us-ascii?Q?7/9p/VLVD8xxwqE5yF1IgZde6utMUAbhEqB/IgROyZ3JFDEJavgHA4HI7na9?=
 =?us-ascii?Q?pZxsl31d748p8KdfdWMzrBFdtW3bfpcfsljqTuvQ5eFLmTtCmgLq1qu7dLLF?=
 =?us-ascii?Q?lRmnOYGbz3xb+7ckTNEWlWXQ65lOiHwEJRiakxgrlmbgFrZK7ltxgqul34sP?=
 =?us-ascii?Q?mI3I8GBSOqexlqw2rYpKqbV/JrQyF0GCenxYNf3ed0mGgbEqz6BQtJ8He5gg?=
 =?us-ascii?Q?gmRw6+nrdsX3GAmDAWHMQJiktJUmXp2XSUz/7PkFb9UO3ZexsL1GlLXNrh6F?=
 =?us-ascii?Q?5R3NOh7fJgSqWl0HaDRhArv//ZruSOhaQ7e18Kc3bIbHQWiPzIV5VM0QqK4o?=
 =?us-ascii?Q?b0VghuGwYcws5E6awMuCBCH4cUCvlsgGs/q+RMDcIL/nkppnW4Or855EGPus?=
 =?us-ascii?Q?4dgoug2JdjKWPkinM6euLh0OD94k+ZLyoLJjRxvyBWID1cudQkOudrUVrm28?=
 =?us-ascii?Q?gT4O4okJ39rgGS769E8vG3ZjzWp736vxeXOoCAqxrqM/5C61d1plu+RbEKJ1?=
 =?us-ascii?Q?TXBLdnsOyMzKB9nEC4NBrDTuov/lUZd5GM8s+EqAx41lSu7gyfhr8LF4PdAh?=
 =?us-ascii?Q?1xyLS88yr4wYfdqD5S6JlCsHbDXqOzPyHPjfA77Yal9YSqpViXPyxbA+ijBU?=
 =?us-ascii?Q?lxyw/dfE2tQD8v4YpWizuVx911t5wRt0XCK904q0uHE2v1Za/7ypw4bbrP32?=
 =?us-ascii?Q?XuXGmAPAzOOxsp4ui+JmbamZ589r31o/ijcqwlaXYyaxp0uoMnTTuh03aqNy?=
 =?us-ascii?Q?OgRG2k3dZIIbTplLeGayyIaYVsBOXUOKLqR14vH/oLauq+ssJq4CGDLGnzZu?=
 =?us-ascii?Q?a0Fqb/bQ98VEeyx6CbuIwTNOiLIGzCLkb9hUNKmGnAWt0raZxp2RYJLv/h44?=
 =?us-ascii?Q?asi4815dOW4GCok0EbrMCCoJLQfbU4bVAXjfndpDsTUDq4wP9ozLx6sQyeSf?=
 =?us-ascii?Q?gOAKdcYlzLKtPCW3zwJ1TpvSWyahBTPkxp14EH8StkDv/fMWB8WtAA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0160
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d23bf97f-76d3-4531-fbfa-08de080c04f3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|82310400026|1800799024|14060799003|36860700013|35042699022|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Ed4IyhK1OAWFxR6ENdHaMLitXMwKFVsUGHdqcXbNgLi6+up4+fGA3uoh0uj?=
 =?us-ascii?Q?Bb/oJEtPyIArynPfac1AR3vIrL3xCMYsZGccDGXM9ual5SeDvtrAuHcJuA8j?=
 =?us-ascii?Q?nSkJX+XqlD6wRwFnbFbbCAS7uGeEalG75xyyMXlxNaGsUvnrKlCz2MVKvXoK?=
 =?us-ascii?Q?oqk6COBPnWPRkR/EqP/0KxRFihke3lamB5YovNhsD1Xpl9BUERYK8Q3ji+OS?=
 =?us-ascii?Q?2wGmuUlQ0o9n1CMm4auAKAIhl4Yr8Mum+4IPv4aCjT0DDOw8BRsDBRmOPTGT?=
 =?us-ascii?Q?CnuPmMT0PpFsg+Y4Hjh1FIgzEpIH/BD3UsFkEXhzCeo2fFWBdbro0bNLM5e8?=
 =?us-ascii?Q?BNzQrKykiops/WTChRGXM6QeEtuY+xheOH/XcNvs6WCM11jew1oJg1J17prz?=
 =?us-ascii?Q?bQEjG0kagEW/QLLz+oXDcB3P0CKBygmBPsP2eGezaJi4yKc5h1J0MQ/LFHiJ?=
 =?us-ascii?Q?IUktrj+gUiNECYUsdHDAVTjgEc1kb63gMvWP7au1bpqU8MmXO1hKevUVfkbM?=
 =?us-ascii?Q?Hjc2LXu0shDEBMbN4nnJzF+v9xxzbImzTba05qBIzp1Pd9SrOoYra2W65UyF?=
 =?us-ascii?Q?YtsVTdJuptEME2sE+DdUXAvGGE7/abos3y7ZQYhTJ4a7Pv5ZOwjYuG/ULalB?=
 =?us-ascii?Q?Ns83dtnN7bmq+XI4K03XmOo0PhWkjhfHD1BZczRlD/MhuF0NUlxtfRdEsD81?=
 =?us-ascii?Q?wq5Vc6HKS56Cn4FpsXUs/EARH1W0dODgqNIL8cZQgcjTo9FkAwzI6RC3RSd/?=
 =?us-ascii?Q?ZeBYDnDYVpguoMcWUDz/anf/is647jKtB+JAhOh9fCH8SeIL+XPmazJWyOHS?=
 =?us-ascii?Q?CjUyiyOUK8K4isP1Vt3TW0SHSGaNaiTRlE1LKwSY1OvMbG+RFk6u7WRPOl/N?=
 =?us-ascii?Q?3AvcB3NRfdmOvYgKaH+snL9WgS7edJ3UUCnyYiuZtq5gp2dlu9oykjdftHGD?=
 =?us-ascii?Q?eAk5vEGIcloKLj4Jb/k1SocfJi7IQ37ftYX0eiSEjUQoPxElz1CxYFyC7hwg?=
 =?us-ascii?Q?hUGf+tsh7Q/0UsiJrYH8pbD0CostHFX4YxF85ubY+OXt21aKT8J5cH2mTVV7?=
 =?us-ascii?Q?mpgUZ0rpvG2yAbh13KCCormEYigp9BWgk2vTqglszWpxlwERxnCp7DJAnpNB?=
 =?us-ascii?Q?sxjzS++qAkDEr1PYZGAUKhQJiXVXV8TYMLxRs2eh3mwPxzdTtIBcPGaQGoCY?=
 =?us-ascii?Q?RDSexJIDkUZZ6Gip/ztZoHL8sSD7DRqJzWLU7ZfK3fX7V0k5vehkHX/V0Kip?=
 =?us-ascii?Q?6Mhjw/XORXh2vUsxHzvmuUtato43Z+LFr+2pKc8BHwiVeXARIMCepaiVwJUA?=
 =?us-ascii?Q?cFdi1ZhuvT8jS5BguLtSLRR2/gIZ0MeCHwhd4FlrWwg/RslwoTCTze9P1Zuh?=
 =?us-ascii?Q?PmP/sIxmrpHURClSVE44aRX+q7dGvNxQQIdZAVkVhb3nXrbDBtdFiXeimK8B?=
 =?us-ascii?Q?v/YIIig6ob9IgyA1dTJciOf1BuKt4VWHPUUeGI0UJXpvN3tKa5OQ3lXQ/IJ3?=
 =?us-ascii?Q?d+twRefdWOMLxR6joWlRfgsTfv0wQ1e6oMLUwvgoWrTMlps4BEJcwOaTflo/?=
 =?us-ascii?Q?5yNXV6h+6k2dBpdkEro=3D?=
X-Forefront-Antispam-Report:
	CIP:51.103.219.121;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx1.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(19092799006)(82310400026)(1800799024)(14060799003)(36860700013)(35042699022)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 14:48:06.6450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e96e19a-9219-48e7-150c-08de080c060c
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.103.219.121];Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1504

This reverts commit c7f2688540d95e7f2cbcd178f8ff62ebe079faf7
which turned the ints into uint8_t but didn't realize that
fuse_opt_parse() assumes they are ints.

Fixes https://github.com/tytso/e2fsprogs/issues/245

Signed-off-by: Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
---
 misc/fuse2fs.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index cb5620c7..f565dbe7 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -217,17 +217,17 @@ struct fuse2fs {
 	pthread_mutex_t bfl;
 	char *device;
 	char *shortdev;
-	uint8_t ro;
-	uint8_t debug;
-	uint8_t no_default_opts;
-	uint8_t panic_on_error;
-	uint8_t minixdf;
-	uint8_t fakeroot;
-	uint8_t alloc_all_blocks;
-	uint8_t norecovery;
-	uint8_t kernel;
-	uint8_t directio;
-	uint8_t acl;
+	int ro;
+	int debug;
+	int no_default_opts;
+	int panic_on_error;
+	int minixdf;
+	int fakeroot;
+	int alloc_all_blocks;
+	int norecovery;
+	int kernel;
+	int directio;
+	int acl;
 
 	int logfd;
 	int blocklog;
-- 
2.43.5


