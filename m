Return-Path: <linux-ext4+bounces-10955-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A51BEB72A
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 22:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4ED5F4EA094
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 20:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C64256C70;
	Fri, 17 Oct 2025 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="a5OYzspk";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="a5OYzspk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021109.outbound.protection.outlook.com [40.107.167.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54433F8DB
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731817; cv=fail; b=aEbEZfRaZ0Riu93G4mKx0HTNKfaKA17cwdZMPyPzgbq2t8oIMOPn9gPi1tfvT/f17Bk/QvxVx7jlikdkbCVQLCVqDiPPzt71aajtHhjvJs9r/lzzcguPN1pZioOMWO45fYWHd9n6Qida+aedQk9qJ8TlXjpizRjIEPcrcb+IQ0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731817; c=relaxed/simple;
	bh=hoa7a3J0agq/v0npuaLO4JT/aZfRe8P9WQJ2B4skDgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ufDV/OasCAWYwCub4IeIIWoSqCpMxII6Hzpm4oomqkItuU6Z9dpXQ6hmziFYoGbQlbR8K1DVF8FKsiAaNs7F/aU+GJ+Ioo3v3ZDJe4eYxvoRH4pbgqdNWfp5pHkYI16chga50j1cxbgJd0VfNrFY5wUo7pws5Mr8GOV4HHo7U9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=a5OYzspk; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=a5OYzspk; arc=fail smtp.client-ip=40.107.167.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTOz6tUnSh1HTnOr09Lq34snQ3XGCJhZyW3OtJSBnfVc9GLNzoyvv/2aP2cGCdabuZgLVPQmegKccs3OF8uHAG93Oj3ssLHOIbz7Aw6lenWPoFgjL3lmIBHibx6WE8MggKLzybFNNMHpfygiuMmdogqdquS2rln4PcQlhnFjdIgx3CjAUviD323ql0Q8ZFfjtV4nKh1FkcC0U55fOVDJWaO5IzzCU7wMGRlLLnuyloqJSZ1i+KiYwKrypf2d+NVEsCbOUBY08t9KVpXbhhb+1LLD/5FcDGYCIlYvrSs7dMimgKLDk70bx2+8a3dM/DrqVF2/BXeQe0NDK2Sbd3X0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsBP9irYfkpmORNv1tejbomOd7t59OOge1ntyzwVcAI=;
 b=VB7FcA7b9nAZKkTvlvzBCqSACZb4eJaHbgNGmt2j4KUWmFdLEmUvagUg1k8kml+R26i7antvoz/kipMB9XyOpeBrehdJI1jQ0/+ElWFAV6vOZEfYHQvTvRjz0SOeR7EzG91kbRliPmL9bBdhMo7MWOAu4nK08+8MnMxk2YOKcw9dEc2HqzExVnRp44gmmzTuS3qYVYbHKaTo1ZVabR9AM2ZeSKNDc2s+RAqpox1yDTqSANlq1LVXNOUNtc1k4r19mhEAqKOv4Io8ovB5b6A9cC6q19O1VuGKNlnQt2rlNcPnn5FmZMcrIqhwIGdPiCHXJqM5PHPAKtclOxRudMOsYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsBP9irYfkpmORNv1tejbomOd7t59OOge1ntyzwVcAI=;
 b=a5OYzspkcQuWW5asD+M591Dg4M7qsEEBw//HyJWsZbaN6h6LOvUvdum48iAxDxXBRwLUXY/pYJYsOI11MIzBFRndnsYOWg+k9pXWl0gYgAHnm2Oy8sLrHZfoaNcVB4sFu5Fv8SA+4Sn2nMs4YDJWCjg8/kWQ+BBWVcA1SNOqGlc=
Received: from AS4P251CA0003.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::9)
 by ZR1PPF689FDCEED.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::292) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 20:10:06 +0000
Received: from AMS1EPF00000047.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::a6) by AS4P251CA0003.outlook.office365.com
 (2603:10a6:20b:5d2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.14 via Frontend Transport; Fri,
 17 Oct 2025 20:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 AMS1EPF00000047.mail.protection.outlook.com (10.167.16.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 20:10:06 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=a5OYzspk
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011027.outbound.protection.outlook.com [40.93.85.27])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id 81597FC050;
	Fri, 17 Oct 2025 22:10:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsBP9irYfkpmORNv1tejbomOd7t59OOge1ntyzwVcAI=;
 b=a5OYzspkcQuWW5asD+M591Dg4M7qsEEBw//HyJWsZbaN6h6LOvUvdum48iAxDxXBRwLUXY/pYJYsOI11MIzBFRndnsYOWg+k9pXWl0gYgAHnm2Oy8sLrHZfoaNcVB4sFu5Fv8SA+4Sn2nMs4YDJWCjg8/kWQ+BBWVcA1SNOqGlc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::15)
 by ZR1P278MB1755.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:9b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 20:10:04 +0000
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4]) by ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4%3]) with mapi id 15.20.9228.014; Fri, 17 Oct 2025
 20:10:03 +0000
Date: Fri, 17 Oct 2025 15:09:57 -0500
From: Dave Dykstra <dwd@cern.ch>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org,
	Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
Subject: Re: [PATCH] fuse2fs: updates for message reporting journal is not
 supported
Message-ID: <aPKilSNCQRW9c6rl@cern.ch>
References: <20251016200903.3508-1-dave.dykstra@cern.ch>
 <20251017191800.GF6170@frogsfrogsfrogs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017191800.GF6170@frogsfrogsfrogs>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: CH2PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:610:54::19) To ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:12::15)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZRAP278MB0096:EE_|ZR1P278MB1755:EE_|AMS1EPF00000047:EE_|ZR1PPF689FDCEED:EE_
X-MS-Office365-Filtering-Correlation-Id: a1596664-cb91-44b6-a40c-08de0db92a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|19092799006;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?+J3nzd78sWYezVOgKXySLXwW8dxxCwzBFEI+8eBU6M4tsX2HTEgoMJ3SKxTx?=
 =?us-ascii?Q?dU2rS19uXNeDhgCoDbHme94CnZvU8/AwalVvG+foIO71qxbelvgvw+mtTBt0?=
 =?us-ascii?Q?EhPO3oBG7ahuf2pGl7bTk+8e2Tx480ROrJDrcAAy19+rRHm3uQZDTcThD29C?=
 =?us-ascii?Q?s7GxYyaaFUFkBInHhMVChbqDZZlxYwH2111/zzfwlBnKvSFi9Momn1G/7aif?=
 =?us-ascii?Q?drbzavxlKMtYlwkutmSdjQ9xkHOKt2OpMYGEs2491YsxbSgcdmTUJAbmKyD1?=
 =?us-ascii?Q?ME7vdsAFKNzlr6bqi9PURUdsz3bPLGgIj2hckIeQngdQEXHEY6NCupuHHlph?=
 =?us-ascii?Q?VGcFaahsekbGc04PnOTs7J/eNq0/p7NR3PYp87GOIpPnJRceuuG9eOP3wQcs?=
 =?us-ascii?Q?1pNX+7VLhnXJz2BMHjpKR2bGVr3mQhDrFWNmUTgZt+wrRnaY0B5P9ZlkoJMC?=
 =?us-ascii?Q?EgxGUw67+4DRXcfe26kphS9PC5Q4Y9UFd2EmgWgTyX1clcmaBm3zLz5z9J+1?=
 =?us-ascii?Q?9sxg2L59SGgRBAkU5yPaODjeNtKIDK0BNZ1/DTv6COioYtrsUAA6bJjoZteK?=
 =?us-ascii?Q?1fNgKfoYt2pOl7UZdiwgPiZzpXZUTQQFNrLNoEJJD7psZg4k2FaHqWmrsnYB?=
 =?us-ascii?Q?64mN6gvzPq9PNXuWjkQ0BC9+a7VfCB0b6VTqfvOgHMrN+ziaCAXRKc3eNPcf?=
 =?us-ascii?Q?QS/OwL468V+TXZLHXuqSpFYTVGpZk9NL4gmNzOyr9VygE6jHrCdcF4CrUvu7?=
 =?us-ascii?Q?6BWGp7TNvmhnteBoJ+GnVqdRcB6OA+Dy+EaN2DuaVOKqTXaq4ziAyz5UkEnS?=
 =?us-ascii?Q?JGtqKkdD0iKxvb6Dr2YhMkTa4n0AEyKXTVFlCUDnkU97876RCjwJXBIU+jF7?=
 =?us-ascii?Q?s+pxjuYbBRr3LMTnALDBVKAp+8BSpUV5+oxkvAle1wEdPfXBpOPVXku4H9gj?=
 =?us-ascii?Q?6LOjaZgCakxY4jOPB1ZmVTCvX6XyuY09L2zkB+95BYEZrMd6HHXm/M18iPge?=
 =?us-ascii?Q?PpV2W+tAo19prHFvGz2wHaJCpevYxuhdbOyumvELlqe/pNgmqHQ3YAEXyQcg?=
 =?us-ascii?Q?wQAMcB8MCc+EPLTLZkihG8/x77qWgYdZTOT15lyW+V70OvvX5bIDfNrs8dMe?=
 =?us-ascii?Q?4WSqIyPjcPaXzrzgGEoVUetvfswF/JNFGPImGu3r5qLt0acUySygNpZNRmNk?=
 =?us-ascii?Q?18BBCheIfHS8ARX9KD/yO3xgeEJNYgJeAZEe/eJjKJgkKv+p5T0QG4PDpi3B?=
 =?us-ascii?Q?FwVYER7LrIsYHYoA2HmjTiCQbU5PAdJJbz+qitP2+Hmd7/q5YlIkZ6iUI6r9?=
 =?us-ascii?Q?T7wmNQ5HJrU+B08FeNZm0xI1sicvrf5RC8ugGLXwvfrAIVRQO58bGjShflSQ?=
 =?us-ascii?Q?DpHYPrjXEaZ/jx3myqu0ZVW/1f1bXkbk+WB09L//CC6Y77ymZbbhpnd1Nlij?=
 =?us-ascii?Q?A58BkeZ1+ya+UYiczEj5CF9V/OWmZ+5TWyR0Ku25GKUVhbyVvdRZdA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(19092799006);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1755
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	659f11bb-567b-4325-155a-08de0db928a0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|19092799006|376014|1800799024|35042699022|82310400026|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HA4jEdL3XiIHPjlctxpOkBAOKuUDgb79gqb/njhIXqg5vQaRNg0r0PizLTC7?=
 =?us-ascii?Q?ZXMTwiu/TmZMhXa18A468rQX5ZnOZ+UqU5ryPZtEaJwOEjQ2o21cDKxpJ/7/?=
 =?us-ascii?Q?0ti2W+Yzhrh6OFH+RiKEtDOTbzKNyd+fmfSA9mTjzY7hjNS/6jIUtL0PPFZo?=
 =?us-ascii?Q?r7Z87sEcBTNIiL1T+7LK7MuQ9W9UY/X8I6YP/q8in5+hK9vT1ChwVINX9Fto?=
 =?us-ascii?Q?cS9WijsjF53hic6N6uNIXRmQ9A7FX+MXSMvqLE+FSQah0N/tG6J7uDSbFdYo?=
 =?us-ascii?Q?zt3K3tJLIto5+sK85KLQu/pCyFNPv9Yxy+t+yY0S+gU1NV/hVfxLyFc+fZxq?=
 =?us-ascii?Q?pzO+y76Ae+gicNjphP7nFILFjE1fw+me/FJBo5HkaeflX1xHMNtAYmoacsP/?=
 =?us-ascii?Q?FHli5oQgMpqFWjQyMp/Wncf5dKb84PfYt/kdfCZJFRX0+HDvdIsSGb9bQLzR?=
 =?us-ascii?Q?iRWdfJcVR3nT1NFWnSAz3ZVPqP+2D6oW45WWJAMthafu/s7iz2tujIifWWrC?=
 =?us-ascii?Q?59rhpZZjvwScPRD2H7F1LEn4td9+NepecKlNjQXefyRmliSIRHA9IE61hE7N?=
 =?us-ascii?Q?lZTjmtSX7Uh4mnZ4QlMaH9sUOM27SF+t0ELLrp1fY7cbA0Yo0NINJOqlvVNb?=
 =?us-ascii?Q?35Kd37sZoZATz7K9JmE9TB+65xLgFivlSjjXJFx2hxC2gEg95Kx1imqBhmNm?=
 =?us-ascii?Q?a7WI6mymhre7OptKnXGXGfreXBOg5b61JLoTsfvfotJiwZ8DaGik1pkdGnAW?=
 =?us-ascii?Q?P/8c2XEX0Z5ntVuhyLHwx5sUaCI3pka+wwhcSSswWKiZJd458wXBq01A5fb3?=
 =?us-ascii?Q?2XLJA1YA2bsgve+tSmn9Z3v8uB/cdxORNcnXQQo+sZYZNachwSkrLaXpCaM4?=
 =?us-ascii?Q?kcw7+iJzbw0hKlOpPuOBF7WWFWxpAoImGHFFpgg54byj+nD0/LpdPmYCsgEz?=
 =?us-ascii?Q?IUzLf84sZ0S920JLLI1cKXgUtDrT7Pmi/ZduWMe2i1QIM9Zx7b+KpaXQESJu?=
 =?us-ascii?Q?g2kmR1zFfS308JA2lIhdeDsAHQ1UiR+xmo6+lSyU18IVhWukGBDXNFyRBbhm?=
 =?us-ascii?Q?ryz7c21dG5mTt1OYtz7RdRtaKprnP90XKoq83sNd0DsnKgNvkf87ufcb0cb1?=
 =?us-ascii?Q?fSTeAobA/F2/jst8jnV2B0peK4OIUjtBGElwqO5cHExUepRuozGByPnaBUxY?=
 =?us-ascii?Q?r/FJAvlt54/bXldt6UjqZUVoRcjaE/VE0Hi2YZL00SNBBWKobw8o99sLUxED?=
 =?us-ascii?Q?84OKJWn7hcbIC5FdpA0/5g5H9pO9i4OnjQHNo4BalFhDh1cfYeRkLnTMXTFt?=
 =?us-ascii?Q?dv2HG7xqUWX8C8qjvafdE79o91bbKi1xjIZk12DgHBeMSVfotMiwjEM65muM?=
 =?us-ascii?Q?7SXEn0+3z9MtyUQJkcTzjNbTCd74fJY3v5J/UaddWZeL8+ugd0N7XNjfYbHP?=
 =?us-ascii?Q?V4YPQGzRt3ba5dF72O2cAFqe+OyvJ4r76xRDU6Btf9mNJJ74tl/hJqWYXR4V?=
 =?us-ascii?Q?U0seVJvaAS/c/0gmkQkj85jIvRMekB4Nd61xS1miYCb6g+/JNxSpeZ/nmG6e?=
 =?us-ascii?Q?m0BGaJhJz9GhICYO3DI=3D?=
X-Forefront-Antispam-Report:
	CIP:51.103.219.121;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx1.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(19092799006)(376014)(1800799024)(35042699022)(82310400026)(14060799003)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 20:10:06.3449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1596664-cb91-44b6-a40c-08de0db92a60
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.103.219.121];Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1PPF689FDCEED

On Fri, Oct 17, 2025 at 12:18:00PM -0700, Darrick J. Wong wrote:
> On Thu, Oct 16, 2025 at 03:09:03PM -0500, Dave Dykstra wrote:
> > This makes two changes to the message that is shown saying that fuse2fs
> > does not support the journal.  First is that it reverts the check to
> > what it was before 3875380 to look at the ro option not being set
> > instead of checking the RW flag.  That's because I don't think this
> > message needs to be shown when the ro option is set even when it was
> > opened RW; there should be nothing to corrupt when it is ro.
> > 
> > Second, it changes the message to say that writing is not supported
> > rather than using the journal is not supported.  The current message is
> > confusing because in fact the journal is used for recovery when needed
> > and possible.
> > 
> > Also submitted as PR https://github.com/tytso/e2fsprogs/pull/251
> > 
> > Signed-off-by: Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
> > ---
> >  misc/fuse2fs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> > index cb5620c7..c46cc03b 100644
> > --- a/misc/fuse2fs.c
> > +++ b/misc/fuse2fs.c
> > @@ -4774,10 +4774,10 @@ int main(int argc, char *argv[])
> >  		}
> >  	}
> >  
> > -	if (global_fs->flags & EXT2_FLAG_RW) {
> > +	if (!fctx.ro) {
> 
> Again, rw != EXT2_FLAG_RW.
> 
> The ro and rw mount options specify if the filesystem mount is writable.
> You can mount a filesystem in multiple places, and some of the mounts
> can be ro and some can be rw.
> 
> EXT2_FLAG_RW specifies that the filesystem driver can write to the block
> device.  fuse2fs should warn about incomplete journal support any time
> the **filesystem** is writable, independent of the write state of the
> mount.

Are you saying that is indeed possible for a read-only mount to cause
file corruption or data loss if there's not a graceful unmount?  If so,
it sure seems like that should be avoided if possible!  Since fuse2fs
does not support writing the journal, perhaps its behavior should be
different than the kernel's behavior for this too.  Perhaps once the
journal is recovered it should be remounted without EXT2_FLAG_RW.

In any case, during further testing I did find a serious problem with
this change in that it changes more than just the message; it also skips
reading in the inode bitmap, which causes a problem later.  So at
minimum this patch should only affect the message, not the rest of the
stuff in that if statement.

> Filesystems are allowed to write to the block device even if the mount
> itself is readonly, e.g. kernel ext4 recovering the journal on an ro
> mount.
> 
> NAK.
> 
> --D
> 
> >  		if (ext2fs_has_feature_journal(global_fs->super))
> >  			log_printf(&fctx, "%s",
> > - _("Warning: fuse2fs does not support using the journal.\n"
> > + _("Warning: fuse2fs does not support writing the journal.\n"

What do you think about this message change?

Dave

> >     "There may be file system corruption or data loss if\n"
> >     "the file system is not gracefully unmounted.\n"));
> >  		err = ext2fs_read_inode_bitmap(global_fs);
> > -- 
> > 2.43.5
> > 
> > 
> 

