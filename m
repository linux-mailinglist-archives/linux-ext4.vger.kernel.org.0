Return-Path: <linux-ext4+bounces-10956-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8E7BEBA1C
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 22:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410531A62524
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 20:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51659337B80;
	Fri, 17 Oct 2025 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="dndy7aIP";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="dndy7aIP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021139.outbound.protection.outlook.com [40.107.167.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A354354AFF
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732098; cv=fail; b=Iz+/h4bLmhBP6BRlZEOm+18rIXPCZENWzxQ+JvHiZRAENlNB6YrrxdSu9ASKBUlADd2hWiZoXzvqe9f2MND9FK0p6as5oFIOFNtHzfcdCYrzxr35afR9umPy0qY8ieLz6fVL+tK7wPqAHxUX7obmiO+IGwKqqYwLW49m3X3wB0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732098; c=relaxed/simple;
	bh=an/EAZGmmyhTPhDR3OXzAV/kpEeTylmZHZVIj2cwnsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SHqlBkm0frE6G+8PL/5al1ZDi+fRtwEuawUb7E8V6hy2ZHUVnc0qWWas9e7K4LxByGvLD05UfXTQZ/dIB7tr3Jeghuw5B0OFnVChd7qfpkfnkHFwJUyZqTuKYPFh5SYwTp8E/fPIlKydQvVYpR5hjiII+26pfQc0aXeWKr2RS8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=dndy7aIP; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=dndy7aIP; arc=fail smtp.client-ip=40.107.167.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYPr0U8IvByTr0p8HeYrUSCT1o2DTxonRRDBwQ5cm2mlbAtlEo1AwYM2QqjwiVoHRTzNAijHITnt2vadBBwlZRd3gjZgjB0sog46SjiCejo0TIIHwXkiYRNV4esCa1BzLBJqw//6k826cGKWalUtdPnGhC7Ca2uC28GDnSv/ayQKShuvZDMgWMcZqzDVfnXyqKLX9izhQxhoMj0mPgIzY95rqIbejVtenKIEsIhBFYQ8yLqBZcZWyiw/MhUAJycWv2HDA1PKT/Ry6RXfVUWJaBlLjr6tDJ9avfuoC80M6Q6MC+Mp4VlQ3uKcsuv5LyL7lEjIqvIeAPHE0r0ch5992A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dc3/BNQX0cRcfRkBPilJ5SU+nmZvUQD86NJMMtC5guA=;
 b=pzIitAdYIW5Qd9srQbgB7kGsbOreNWUbgO1fIhMau8Wr4kedBbiTYC9e5uD27AjSRi0sjffXgj/oZTysvjgBJs84zSsO3/JWLqFP7lKVQ7KmBaEFylcK0Ro+NY+iaXgy23WPQjL9yjStx643UFB35uK075BFLBUvdlVVYDFQaJ3qCPesamosExJO6CcS2istk4pBpczYhZdQRrJ6+ARfGZcPQ6DE2Qv9PWhS1R9LNOQNaX47Z9D6IXRF+Y7LPDunhoFgQJLdtJbERQnsZya9vPzqllv1EiCu4VPVJ9zW/NjolDpT72d+etWviEigAZjgCmQFkYEiKMq5P7qbOZMr7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc3/BNQX0cRcfRkBPilJ5SU+nmZvUQD86NJMMtC5guA=;
 b=dndy7aIPHSCIVf3X6mf67+Vosf1nwgcHSLVPvBGYNc5F4gedtCnZqBusWApt50DXtxIHaXhMHS9+OHoMmbX+4Q5ishUE5/oP59OrmAno99kAastKYaEydUqpfzOBw/jB9gp9OCyVqVcCUQXQl0+DcSI127bWCXUpTKQvh21v8G0=
Received: from DU2PR04CA0055.eurprd04.prod.outlook.com (2603:10a6:10:234::30)
 by GV0P278MB1900.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:6e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 20:14:52 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::6d) by DU2PR04CA0055.outlook.office365.com
 (2603:10a6:10:234::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 20:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 20:14:52 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=dndy7aIP
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010003.outbound.protection.outlook.com [40.93.85.3])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id 48453FC127;
	Fri, 17 Oct 2025 22:14:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc3/BNQX0cRcfRkBPilJ5SU+nmZvUQD86NJMMtC5guA=;
 b=dndy7aIPHSCIVf3X6mf67+Vosf1nwgcHSLVPvBGYNc5F4gedtCnZqBusWApt50DXtxIHaXhMHS9+OHoMmbX+4Q5ishUE5/oP59OrmAno99kAastKYaEydUqpfzOBw/jB9gp9OCyVqVcCUQXQl0+DcSI127bWCXUpTKQvh21v8G0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::15)
 by ZR1P278MB1755.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:9b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 20:14:50 +0000
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4]) by ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4%3]) with mapi id 15.20.9228.014; Fri, 17 Oct 2025
 20:14:50 +0000
Date: Fri, 17 Oct 2025 15:14:45 -0500
From: Dave Dykstra <dwd@cern.ch>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org,
	Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
Subject: Re: [PATCH] fuse2fs: open read-only when ro option and image
 non-writable
Message-ID: <aPKjtQz5lmUcWf5O@cern.ch>
References: <20251016200206.3035-1-dave.dykstra@cern.ch>
 <20251017192456.GG6170@frogsfrogsfrogs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017192456.GG6170@frogsfrogsfrogs>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: CH3P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::31) To ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:12::15)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZRAP278MB0096:EE_|ZR1P278MB1755:EE_|DB1PEPF000509F1:EE_|GV0P278MB1900:EE_
X-MS-Office365-Filtering-Correlation-Id: 42397de0-240d-4907-64e2-08de0db9d4b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|19092799006;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?TpTEHvQtm5VZM4PDl1wu2YaLrCXmAU/tsP2S2pt94/WWLDD7v5AG0vpHuVEG?=
 =?us-ascii?Q?RdPaHbxGvWP1FpARdfZzyCIz+iBTSE+tLO0EEz5oSyEQu4Q8629G3vTIrbT9?=
 =?us-ascii?Q?BzG5DKXR10p4FlugVJQyDI+/+xHWOelgLMsdqcPAvvTcWC5dG89Y2jyyp4hU?=
 =?us-ascii?Q?D6e8uDhAamWJMu/GU9A+Ei/SbG8oXPN9Y62J/l4TywxX2z0yZO1nVEQYe/tz?=
 =?us-ascii?Q?f23Feip6wItwDMVyOOovVm9WENwZ8KTBUnPRrJ5QH98Hvne4sIVPWS//inG1?=
 =?us-ascii?Q?eM+7py+LWXrtzuTaxFK/tAL9z/Sgy23qTU1sxC723qdeep2MX0ZfGjjwljOM?=
 =?us-ascii?Q?gHIhHU2Geq1l1YsClJJ+md1hPs3CSpPJkJhr3d9jgMk5l6wS7QKB55fGX+KX?=
 =?us-ascii?Q?KY9aiK/Pi39zVyl0EBjXj61aRM2HeyvIO+B9/3tKBCoFT3WZPbQikWaUtDlS?=
 =?us-ascii?Q?dSZO4Zak+/HE6N4JnOu4+i+G3iSraAwqVwnQYYL4x4ckZIqvresA581s/wYJ?=
 =?us-ascii?Q?0kp4gGT82ydfQRMxLPn/B9tw1l93eNPzMYaXOPKWLC4M/YPHKv9L7KhY2iCG?=
 =?us-ascii?Q?R/UCZ8V5rf8b9RR/k1AOV19o4tEwHi9cmqkgYwh8ViFANYIYaIBMCsw/gweH?=
 =?us-ascii?Q?EQpzKn/xwEUPLldjsb8gDk959eeKQ9z3XoOeG2maECpaMYvCs6QqC0QIDVlR?=
 =?us-ascii?Q?Dy4cdWrUcMSf4oZp99Y1JYRQfBjTOqMxOCaHmqLAYIHJqdFLhBsur8jfh6zF?=
 =?us-ascii?Q?t9r4QxzZ7pbmXDdBR7DjoJpFednOSYhnaPFaN6uPeQYlcI4h9vxE1p8uVIcG?=
 =?us-ascii?Q?xp+Ghw0uWv3jxGY0RjfnscjF6VXoQtUBjShVhr+znTi3D3xZO8RJoZASKt3h?=
 =?us-ascii?Q?ORt7IL+nJlZtEBNwtHmpF+H7j5XaqBJpfp/0a5hra4gjExX7HXI7faazx8F7?=
 =?us-ascii?Q?PSKCCEs7Bd4epg+jnq/MyQ6PjvFR0J6fVbIOwqfRv/lntac64lbC7+cbGE+p?=
 =?us-ascii?Q?3KM2Ni5p0GAp/l7lJW11bqlSIeKOAxWWPIZqmSAcoZQTV7o+OplxqLU8U8/G?=
 =?us-ascii?Q?wMKEdjysvbrwMjYPH6KyvIaklGLE8WJKxVrHViNONgO4CrYcOyVvZaC5BZtp?=
 =?us-ascii?Q?1U9l59/bGtJEN6aCxTlDKzfiJ8rStVfwlxiofzs45brpuWvbRbBraf7tymfJ?=
 =?us-ascii?Q?LjGzZPOjfJzesaJfuQL00rREE7KZXmQMZ9VfMRyRi78xsPgZvZCVEM54Y9NV?=
 =?us-ascii?Q?9m5JbEej4KCLBSiD2Bqo4HDJV7fwoXa7Sc/pfytvfZZRI/FKRZI8oB9Sk69L?=
 =?us-ascii?Q?K3+3iKdzH11XZv9hjSoJhtTsNTBv5vhHbj/LIb+YjlqeBR+FdTEYxLp+X5I4?=
 =?us-ascii?Q?GG5DXCqCHnI389kTU4RukYdBegrWYyB2rjRFy3lbFt2ZEGDfqsVYFqxyRHVs?=
 =?us-ascii?Q?dKTmU9rIb/bUIgnMpLE/qNAMYMzVUERt?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(19092799006);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1755
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	59a50c76-13c2-45b6-9054-08de0db9d2d2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|14060799003|376014|35042699022|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FWwh19bA/cwtHl1BwSVo6OPoL38bHNoykUp3tPVFbyQWD6NJDaECRnbQwPtJ?=
 =?us-ascii?Q?bNZ7RzxxM7wseC3HuFkoxqda1oYwYrQq3lXquIBWucsujNCwLimaawNQwypU?=
 =?us-ascii?Q?kwLqZx4gMKCEZIEBYfc9bL1B53NxyrR+GBozdNjocfvEhKlAxZ6FduS07YcE?=
 =?us-ascii?Q?6StQHbpAcbXFBz8Tv2NTH25GzJ/hk/BtciUVaBGNA0iLwZarXfcURAC8CIEY?=
 =?us-ascii?Q?hutZQFX2qT/G0k6hWfgCUmwjKMf80aSKI33CxhE2c/9xUYAj0vFxk2P8dcFC?=
 =?us-ascii?Q?3kuKm0MNEFYi66MsN1tdgz3KGK39Gzw6+c4PTNdCeIoXnkM4C2hicLFeXXgg?=
 =?us-ascii?Q?D1zWL9eY8sQg4J2gjfl+3qE2ZxFCSDObFBL/EjNkujfSb6L6I9lxv3YsnWvt?=
 =?us-ascii?Q?IFky8pOEnMchf+rb3MMCLL4SW+rNH67996AYeJK/cyI45yjJZehXm42asXRi?=
 =?us-ascii?Q?CIn1QHIYQguw577RPxoFIW7Hf73u0gNujgYAMsb88u0oBLvV2wm+KMYys0nU?=
 =?us-ascii?Q?ZSTws/mjbd89q9pXpJVZvxoXW5SLoLy65yAlnQD9YUzaA3UkzX/EqbM10IxB?=
 =?us-ascii?Q?+piAk637WDTDL+1WB2vxkjPoCNp/uoFRSp5z/+NXTrimk6DKTQBqDTSEUiQl?=
 =?us-ascii?Q?mViffY9tsr0hi9soACEj9RvEAsZGN42WbGV9Sa0kDSExVhrQilp+KfqOGI84?=
 =?us-ascii?Q?nwBJFtRi8x10ztspncYGhVUyjEWvFWe4DpUuFeFtyW4F/eEoOQrsU+T4xOFy?=
 =?us-ascii?Q?AiBOClFwprNvk10Cl8nf382SJh+SidOPbYg/uo3zjLO5jMYMig9SH92mCzlj?=
 =?us-ascii?Q?/gYqJ9sE2PwzMK8xBUNcSR2WCJCFbSjrwI2vI00ORq+3eQ70hWldBoshyNnC?=
 =?us-ascii?Q?uRtdbOA8JSKIZnzuD0VymLlU1u9QZ0+MFkMQwASOt1jd9dqA03rnNyEWRcwW?=
 =?us-ascii?Q?fIyC65tSLij2GqfHKUCMDbjzemmIc1wMQEIlVj5euwPCS0cqc2jQ96+I931t?=
 =?us-ascii?Q?tB6MFg8bwZOhsZ5ewvZe+l+MoL+Wm3LLXaYWaoY/JUchojbWDzZyywuWX9UA?=
 =?us-ascii?Q?zf2cupV4r9vZtf+qDhmyNF2irLTSKIU4QfdZJ7/3u7G2GEoTUUz8HqFjt+aU?=
 =?us-ascii?Q?Yy4VIyWWe1yErm2iDJa7e0revCeKEOvH1Me0tDbmbmLwAcQDeFvcdu+YV9iG?=
 =?us-ascii?Q?p3TLazrAHb23t4K/AgzqOsYW+ShSmowBiO2tNhf7QRaMEsQiuM2LaGPDlCI9?=
 =?us-ascii?Q?fs1dajMcWVKOCMPPvkBaK1+qA4in1rFVvMIvLLPouQdiSu01YmnvCztcBBw1?=
 =?us-ascii?Q?k8wT8RzWKrD4JnIHsiLNwUd7HMxRSx5UeGZZDl8UVsvkR0KGMzKoXfw7tEGp?=
 =?us-ascii?Q?FRoq4xl7NKZSoO+NAhpj/lV1HX8Y9bzzQmih25o6IhehZsyDEjiiFwebqexV?=
 =?us-ascii?Q?Tmuo25/QJ1PuOhhmzEwIFxDJ823iJSkiGhlnaYZp6O3uNwH/BHUROarYhb/N?=
 =?us-ascii?Q?HdXDt8mOvUeZ0cUYF8ZpVazkATv03w0HsGtQC2AZIDcoYs3oYaFFuPjTDKoK?=
 =?us-ascii?Q?480c3QOf4Mw+/ESB0cQ=3D?=
X-Forefront-Antispam-Report:
	CIP:51.103.219.121;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx1.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(14060799003)(376014)(35042699022)(19092799006)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 20:14:52.0698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42397de0-240d-4907-64e2-08de0db9d4b5
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.103.219.121];Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1900

On Fri, Oct 17, 2025 at 12:24:56PM -0700, Darrick J. Wong wrote:
> On Thu, Oct 16, 2025 at 03:02:06PM -0500, Dave Dykstra wrote:
...
> > diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> > index cb5620c7..2ae2fc1a 100644
> > --- a/misc/fuse2fs.c
> > +++ b/misc/fuse2fs.c
> > @@ -4696,9 +4696,19 @@ int main(int argc, char *argv[])
> >  	err = ext2fs_open2(fctx.device, options, flags, 0, 0, unix_io_manager,
> >  			   &global_fs);
> >  	if (err) {
> > -		err_printf(&fctx, "%s.\n", error_message(err));
> > -		err_printf(&fctx, "%s\n", _("Please run e2fsck -fy."));
> > -		goto out;
> > +		if (((err == EACCES) || (err == EPERM)) && fctx.ro) {
> 
> This is not correct.  mount(8) for the kernel ext4 driver responds to
> the block device being readonly by retrying with an ro mount.  The user
> is not required to specify 'ro':
> 
> # blockdev --setro/ dev/sda
> # strace -e mount mount /dev/sda /mnt
> 40677<mount> 12:19:36 (+     0.000102) mount("/dev/sda", "/mnt", "ext4", 0, NULL) = -1 EACCES (Permission denied)
> 40677<mount> 12:19:36 (+     0.000285) mount("/dev/sda", "/mnt", "ext4", MS_RDONLY, NULL) = 0

Ok then, I'll change that.

...
> >  	fctx.fs = global_fs;
> >  	global_fs->priv_data = &fctx;
> > @@ -4741,6 +4751,8 @@ int main(int argc, char *argv[])
> >  		goto out;
> >  	}
> >  
> > +	ret = 4;
> 
> Why 4?  Is this an internal mount bug?

I was just guessing; I didn't know what the bits meant.  Where are they
documented?  All I knew was that it needed to not include the "& 1" bit
which was included with "ret = 3" because that printed an erroneous
error just after the "out" label.

Dave

