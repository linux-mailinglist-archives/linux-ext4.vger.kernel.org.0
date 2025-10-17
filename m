Return-Path: <linux-ext4+bounces-10958-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 390FFBEBB9F
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 22:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFD75884BC
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 20:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCD3253956;
	Fri, 17 Oct 2025 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="AUUI1f/b";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="AUUI1f/b"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020093.outbound.protection.outlook.com [52.101.186.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B01643B
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734127; cv=fail; b=LhSGHQCT/oExPb35fjDWFJ9Cp9V1BZ8UcTTB31p0Sqvce3ppghD1fteoiC4EZeUjabzQWBsfzzvBCF7gQqIZwHR+WhX0Z/lSumLvkPvtNzdO7si6u70jqdnz8NhJQ9PYDq8Dm5qq/SIAwV4bxOxr80jYBofBXNkdvx4uAdKVqD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734127; c=relaxed/simple;
	bh=8P0dFIOBqMqgx3dWrSrEtT37jxGzQlFLGt8Ie4Nu5qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mv28ExOwke7i8EmARtSAUYqk24gVJBwzElMH3KWB1MZvawI43WRTaPv995Jk/a01mMXk6Z/cJ7WxU3dEP2VGCLec+AretI2ClXm5N6nycHPNTxAE9Cf4e+5en1op2s77nsI2i7/hMh4P0lrDXSxUH+IaTi4nKDNP6HUDmX30rpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=AUUI1f/b; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=AUUI1f/b; arc=fail smtp.client-ip=52.101.186.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rlb11cZeb5YZAD8DCbYo8bVjeoNF8oNEB65aNDHyGOokdt8WFv1QgEV0YONsmlz8nyG93MMPZvNnvoNLz/HPLxZEDUoWSSxkIFwSMsJTZKIDrjJ/0fahZkrzggMFRZ+EXTXftwQFiZNHMdaS6Evxjl7ZBXfagFVmVz4hh6pWj1/mDp41asIBQGe565Od4jtmxPdr4WY98YojrrOwVsRA7iJwA5pNhrTayBtF+xDGrhBxFt/2e25KEVaJAcBNXBqR4i2hOkaLga1SRCA1pZ9ES6/MrgpOS8o+uN9XNjZHcP0UIymJ9RoETWEfV8vnZuIcW63gwZymJtRqnfxISaingA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE9+aOtuS4f07jNa1IjDOEJLmToSfskYBUBV3CIsJlw=;
 b=fURHPIfSX0sQQYpHQqsGVwTY6qsR5iMH6Isfjfj5aKxhnF9j8SJKMya6FhkdZ/2BD5pt4hIXFguIdeF+bJvtA7ULdpYn/z3mvlob/x+jts2NNa4g5pzBh4zLng827zSGxG/48DXvYsg2M7lglcBLawUIZy3J/tPTQy1RyVX+USW5WcOUkspJbHYkyqnkWkMuu0YTRgFhU+ROa5DOGrZLT5REy7jRULhCsaN/wkqo/vDK/iRZgxuGSLtVG00URrn6iy+YaVOo98YsjPUkX29T7VwcqzRRvm1W2BIqOvO4btvloAIjyBVLNI/GtTceOjbpQQAfvKbMrOtQjbQfXJX/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE9+aOtuS4f07jNa1IjDOEJLmToSfskYBUBV3CIsJlw=;
 b=AUUI1f/b5ANE9tvX6pQI6DpLeqld0oDeOsssTRLNqQxMRPbzjmXQR/FsI/S4csq561wQlg5a7DNkNsHsSRcXdFc8az22LbL/7gvk5mKWu7KxqBS5zXM/UwA8Iw+IUB9yc8TgiOH58m862NYFhC7Iv8E4EJuHS5+SoLEho9gVtq4=
Received: from AS8PR04CA0032.eurprd04.prod.outlook.com (2603:10a6:20b:312::7)
 by ZR3P278MB1238.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:73::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 20:48:39 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:312:cafe::9c) by AS8PR04CA0032.outlook.office365.com
 (2603:10a6:20b:312::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 20:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 20:48:39 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=AUUI1f/b
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17012053.outbound.protection.outlook.com [40.93.85.53])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id 0CADF7F663;
	Fri, 17 Oct 2025 22:48:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE9+aOtuS4f07jNa1IjDOEJLmToSfskYBUBV3CIsJlw=;
 b=AUUI1f/b5ANE9tvX6pQI6DpLeqld0oDeOsssTRLNqQxMRPbzjmXQR/FsI/S4csq561wQlg5a7DNkNsHsSRcXdFc8az22LbL/7gvk5mKWu7KxqBS5zXM/UwA8Iw+IUB9yc8TgiOH58m862NYFhC7Iv8E4EJuHS5+SoLEho9gVtq4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::15)
 by ZR0P278MB1229.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:81::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 20:48:37 +0000
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4]) by ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4%3]) with mapi id 15.20.9228.014; Fri, 17 Oct 2025
 20:48:37 +0000
Date: Fri, 17 Oct 2025 15:48:32 -0500
From: Dave Dykstra <dwd@cern.ch>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org,
	Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
Subject: Re: [PATCH] fuse2fs: open read-only when ro option and image
 non-writable
Message-ID: <aPKroGbrXvuoBZUl@cern.ch>
References: <20251016200206.3035-1-dave.dykstra@cern.ch>
 <20251017192456.GG6170@frogsfrogsfrogs>
 <aPKjtQz5lmUcWf5O@cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPKjtQz5lmUcWf5O@cern.ch>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: CH0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::24) To GVAP278MB0087.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:24::7)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZRAP278MB0096:EE_|ZR0P278MB1229:EE_|AMS0EPF000001B7:EE_|ZR3P278MB1238:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfc9447-307f-4bc4-95dd-08de0dbe8d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|19092799006|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?v9drmcFY4W6wTWnIRxnsawpSzRIGIBuug/TXyYeU7sScfrucciyoE9RT350K?=
 =?us-ascii?Q?5EJu9FQZ2RDKL+t2hAOOZL3lMQR0aWJXV2twJSm7PeqZiejQioG3z8X7GGiT?=
 =?us-ascii?Q?SOIznM1wuG6u3Ar+C/qUx2EzeDQskVVv2z7NigrPOwKVw8CGUvMfWhoK/cSI?=
 =?us-ascii?Q?hRzC+3dzBmPWagnzBlLPtM8x9CB+uQh2sooW6oL+A8RIkx36+qfpl9ok+cQD?=
 =?us-ascii?Q?ycyOqgFmYyV+u1MVe98KhMCyyEn3qvcFOWflUkpWUMOdUkLyp8Mg9V9QJewX?=
 =?us-ascii?Q?GtPij1phMYo2Fs5K3vSHMNjipVw+zafAXSScoRlatCaD+CaxWDNOVOtkN+RG?=
 =?us-ascii?Q?eobMFX9q0tVRixEWdG29mW1pi3H/a6s1jWlHZDVH/PrkpwGSipRMnIE/G3ZL?=
 =?us-ascii?Q?SqFDI+zLnTgSrkNLDETTIHOJ4hy2uZZflKDBfdH4uYaUtVa3IhyCw57BpQcA?=
 =?us-ascii?Q?KnVyqk0w1XAzsSLyko7YLjGDWz5kbM3rfqZr1th5Uhqg5n8EYa/giObaigms?=
 =?us-ascii?Q?yd5vpMKfGg4jmdkY/J41ACukFOT3SYeSN33DUXdOsL29AHeY95cC3Ak5s4rl?=
 =?us-ascii?Q?B9GWAuvxKnt9JR0uOjt76mC7w+v+d/787kyF4oPGqW8l/8P6/RY3WhUQajUI?=
 =?us-ascii?Q?3NzuOmId9ccjrvC3BvffoihrjpbH/lp0cx/jbSc1/gL9j1N+JyD26yGuQkub?=
 =?us-ascii?Q?HaxoCTpja0DlZ7X0y1XNSX9di8k2YhAmTn+8zzcGo8EFsDgmgN+PKJAqkPEk?=
 =?us-ascii?Q?Jrrls6viAWYh1817YFoh1gzHuslKzDrVfKpraVAdn/8JqwX5xJegX620VYdD?=
 =?us-ascii?Q?MfmN1/XsPMQ5CmAmb/8lMzp1Oj/NyMW/et/S/ODqS2tjNwKq1uwjI0r26EUt?=
 =?us-ascii?Q?qctWEsjvFsGwRkLQ+EbRpmi1qB38D2MgQuvCMnB3SxTOiC6Do40QRs30oHVt?=
 =?us-ascii?Q?RX7RVX12OP71ubOxgfEfLalPZLRNnS6Gj49HBt3DEPTjJw4yg0u2bHjBz/Im?=
 =?us-ascii?Q?XNh0fPT9mlz4GRhlLT3UAQ9u9wyCm3lP6KiILpmdAGBFUAJ2OxUaCx2L8RxB?=
 =?us-ascii?Q?FxmHYRbk/+yMcyWI31wcTMdssE2kUNRdZ15Foz/bWTm4j9oM8nwIPazDAqfR?=
 =?us-ascii?Q?bfEn0UW+NKRXIe4ZjGvAHg+hyxoX2R6Fz59TjwgkcT4LEgKeVzLQAQ9y7Zif?=
 =?us-ascii?Q?q54cPizVIy7xe6OPnq4uJDeTSoq85c2b96ugszyb0GtyNPYGXm6kYnncT1KG?=
 =?us-ascii?Q?iTo78Zu1cpUkt54FyczDmhYGb0Ve/GPUMqqnJhQP1Rw8W3IpxYtXD0ifO+md?=
 =?us-ascii?Q?TvZRd+JrefCo/AfFk10MwllgQ0mNQXLZky1n9MrehRWFnGus6j9J7U/nSa4d?=
 =?us-ascii?Q?swzzY0e3r7WmRj0OJuhYujZOpJyEeup67fAoaNZdwe8rYorv8PXCTtydNV4b?=
 =?us-ascii?Q?w38GLmMYedGSRJPYmt4FxuXYJbEhBzcy?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1229
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f1be8a4c-b98c-41aa-9815-08de0dbe8b7a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|376014|82310400026|19092799006|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+u/SHZlWuw5jRNYVP99f2mAS0UCiYhS1XVeIoaqNp3IAQ0GFJzyshIQylun?=
 =?us-ascii?Q?ZDJ303ar5yoL+Sg7Ozdbn5yQxUJRVbP02SQ8nB8mjT2hdj7lC3gAsrk49f1k?=
 =?us-ascii?Q?T2VPdr5pjOe0Kn1oHyDhLdMOglQloZE411j3mVfYNhA3c+Ibz5NYrlHikyxe?=
 =?us-ascii?Q?rV8OJBZOpGd3myzPd+GXXRBbphY7oMQB0wy71+dxoJVJLGCz+nPiL/DSOSCI?=
 =?us-ascii?Q?mTkiSvoTR2spYJYw/kge8SN7tVXMO8EBUtGtL+blcJrLQVQh48Ebm9OdYs8X?=
 =?us-ascii?Q?3YR8Y7wp1B/43VvMsSA+FDfCBKEKUDzjkgBr1gvl9k7d6mSqpRhYRBGCe4hn?=
 =?us-ascii?Q?tiEUmcfwSAg3KECtf6o4wDtJ769d7SujvdQ7e2u4UpZSGSkdUmY8XXHiloFs?=
 =?us-ascii?Q?+pyt2z72fncA/E0IUIJKMSK2AEDEXFHoiWTtGzc2OJfpLOXGqzEZKrn37r9I?=
 =?us-ascii?Q?UzGmqvCrIlED0kNCuW7dqyuRgrWkHTKOnXbtobiBzJVGxscnoV2b4ZKBTTd3?=
 =?us-ascii?Q?Tati5YzLcsQp3WjcLaWNnXEAGYo27kU/itMMmLEkUItQyM9dM0Jl0ivDoAJb?=
 =?us-ascii?Q?Z/69nnjkZMTi9CHSW43d0c5Pn1nHkzZC7EW3zaVBj/k0sx5VCzv3c9X9t5sb?=
 =?us-ascii?Q?3dWJmZECwpwCupIi3n9u3fP34f+VscgjeBjUQh0l9PeLoSxzPNXlpSlTH0OP?=
 =?us-ascii?Q?QMavtoOmOJ38NYFRNmtFEhFQGT3AaUXMWsCKV81n0xZXKkGRbdUKL3pL4NzL?=
 =?us-ascii?Q?wCBcF/rDg7FM+VP00WPt3YkRda+l8IC6dthuOsErW5+GAGU+7TW29XQPWqbf?=
 =?us-ascii?Q?8ICy/+vWJs6G9FtpC7MYNixT5Y+PKP5xjXyY4y77yYq5rSUPz8pwvvzUSWPQ?=
 =?us-ascii?Q?x6TZYVeY9Nz15MM3h60cvJ7BEVtOYBeV35G8WOt45zG/m7CHs//Dg0buvgBv?=
 =?us-ascii?Q?TzyOc18hcovkXvLGlYFaKwhsqqmljWTx+Uvc7/oiZUIaxnNKYf83a/JReDHX?=
 =?us-ascii?Q?b4sh7Mq4L4HpoTraK4B7/AWnMfmYdit8eYQcTiD1V7DW1kqjJeqrXbyT/Mq8?=
 =?us-ascii?Q?MDTR/vNUiDc5Drz/1QpMk0B27kPUE8+aiC9WILZmD7edm22uqwZvXZjCifVW?=
 =?us-ascii?Q?yq3SZvrH/3ws0K5/aAce4LKYRg3fI4LzibEpq9Ibm/gJIxlRKHCPxrrP5r4A?=
 =?us-ascii?Q?lAxgwS1ndklZxMh/H30lviu6vVl7hOIDnVxnVke/odcCVWM+e/i2gKFPpQd4?=
 =?us-ascii?Q?F+l9m3o16Q8jcFkRKOSjP763metfdwK1YLQdIhzqBBx5rBmqBmA0qo7EMTql?=
 =?us-ascii?Q?QFc3dERxcwymVl58H18tVL7WIXP/6CuxsxmscWP+lJvBcwGyjo8K8dUS82wi?=
 =?us-ascii?Q?3cS/Z7OXCgjbuhkAy+eHiIpZNq84BnXyZdcTmvLJ/DLJYd0BxG10p1CuyXb2?=
 =?us-ascii?Q?wEINiqm2Mo3U0ihOVGzjya+g5d1x6HZTnC1IgHgvj/XisTTkol5/fz0ZAjQx?=
 =?us-ascii?Q?Ju4z+3IQKW2qYsMpXsb0pVZv6jXJFg08tylq11/G3Da/WEYol5LhHRzXs23O?=
 =?us-ascii?Q?3vvk6bGVhtDL07xkdbw=3D?=
X-Forefront-Antispam-Report:
	CIP:20.208.138.155;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx3.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(376014)(82310400026)(19092799006)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 20:48:39.5680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfc9447-307f-4bc4-95dd-08de0dbe8d2a
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[20.208.138.155];Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1238

On Fri, Oct 17, 2025 at 03:14:50PM -0500, Dave Dykstra wrote:
> On Fri, Oct 17, 2025 at 12:24:56PM -0700, Darrick J. Wong wrote:
...
> > > +	ret = 4;
> > 
> > Why 4?  Is this an internal mount bug?
> 
> I was just guessing; I didn't know what the bits meant.  Where are they
> documented?  All I knew was that it needed to not include the "& 1" bit
> which was included with "ret = 3" because that printed an erroneous
> error just after the "out" label.

Oh, it's supposed to follow the return codes from mount(8).  I think
ret = 2 is most appropriate then.

Dave


