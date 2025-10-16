Return-Path: <linux-ext4+bounces-10911-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B1DBE54EB
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 22:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9AD2581CB4
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 20:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897E028C86C;
	Thu, 16 Oct 2025 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="K95056kL";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="K95056kL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020079.outbound.protection.outlook.com [52.101.188.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4251A9F83
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760644948; cv=fail; b=NkIUMb0iqn8fN+X7wd0ieQkZZukdCZnjFjPN6IvGwD3ZmtoXrsHbsJPrU9V78EbINYIVXz/WGkR4VPhKCZYKB7/wr5JSjX4lsvBVdvH/6APJImjrajMv79V7uvIJKbzUSFYRyS1Hu1K/GEsj+RxpSz2mW5kHBS5e+lNXdwopgVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760644948; c=relaxed/simple;
	bh=kOvNOurwdORPhZ5MASQCPgJEabVZwYVmwWAJnRRVHcM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=p6I9zLx442+eM2VoA/NHo54MZC1NNEs8rsgPGUzEtFGkYy2bLgHgdjQblFaEcM44p4ODLxp9QspHpz4Pk8gMQNQ6p39PVMSxNuRQLfGHPe8PVwpHMmwTUyzuVpM8fLSPD68l8iZeZys6FkmRdp8A6Gsf77zpKK5e3T/lmGDVujg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=K95056kL; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=K95056kL; arc=fail smtp.client-ip=52.101.188.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehJelX+hdqqW//Hw/0u38/NOyAoOXG+fd5Ce/a6qmIFcHrb56S8HLcSE0WGMlgfBRiqShSR0ZXAhuA4IHUc3pU4YCYvtH8miVa3e/+xw6tBPmfvj5/GJb8Nyo4VnQjek+L74QIrupCjHZYI1l8cskvDietdd8U3M/iZkw0fdAYy4YO+wenb/QOXHd+82q+Y1TeDH1jtIAHRd9YsXTxGYgtGO0pO5BwUwbeUZ/doDkUFRg9rkHwZxUU7bedWlpzj5T3oiRAwQGhzCF80tmR904O9gSN2OWd5ybs95U2kMoxODfmB7jfGtLZcHEikn6K6OnhukR6zvv7eov+69halTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWDyoCLyATou0EFHfxGjfWGybvrr3NhGJDP3LmTxpgY=;
 b=sGpWm7H8TmOxjW2IyirOBKW6lyvfWmi1vBMPZwdBWQR141syl4spCjnZbZCLtPJwamiWkX+b0JfMAYdAC2cq1otenAUO6/nf5DgPQWSSiZcp2LNKOtiTEu1JcpAmZb/rRiao0MiVwaoCv1g1B1NCd1uPF0lYhCVsU61N0wbeA8aqdgHHDbFcDuHmw5Tp8EFUo+Z0+skF8B+wBhh3jVl8ObtlvIcfnkxVVRq80b7IfO1krn0GLfYF9ymazwdKvf/w60wySJWTW+tJU76y7++krUuKFe5Lyv1cdpgApe6lvEJ5vUkM1JsaGizmuBV07MdWk16EHM1PQ7BHvcj9tFv01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=users.noreply.github.com
 smtp.mailfrom=cern.ch; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=cern.ch; dkim=pass (signature was verified) header.d=cern.ch;
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWDyoCLyATou0EFHfxGjfWGybvrr3NhGJDP3LmTxpgY=;
 b=K95056kLg/PUWPUBUMvjtfTXoD+zml+z+N0Dzrd1EsNmzudidUQ6G9pHUYVj5YlK9Rbx4rOfBXAENAYprh3qPwB0LPBmWwDpsJqOLD014wmG4Z/v8aUtq6DllrvD6PprFwD3BbifPdZnmscFcGgSekdibUBaJjT7oa8W4XcYsXQ=
Received: from DUZPR01CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::8) by GVAP278MB0021.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:23::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 20:02:20 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::ba) by DUZPR01CA0090.outlook.office365.com
 (2603:10a6:10:46a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 20:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 20:02:20 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=K95056kL
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010000.outbound.protection.outlook.com [40.93.85.0])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id 84D7EFC8FC;
	Thu, 16 Oct 2025 22:02:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWDyoCLyATou0EFHfxGjfWGybvrr3NhGJDP3LmTxpgY=;
 b=K95056kLg/PUWPUBUMvjtfTXoD+zml+z+N0Dzrd1EsNmzudidUQ6G9pHUYVj5YlK9Rbx4rOfBXAENAYprh3qPwB0LPBmWwDpsJqOLD014wmG4Z/v8aUtq6DllrvD6PprFwD3BbifPdZnmscFcGgSekdibUBaJjT7oa8W4XcYsXQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::15)
 by GV0P278MB0162.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 20:02:18 +0000
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4]) by ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4%3]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 20:02:17 +0000
From: Dave Dykstra <dave.dykstra@cern.ch>
To: linux-ext4@vger.kernel.org
Cc: Dave Dykstra <dave.dykstra@cern.ch>,
	Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
Subject: [PATCH] fuse2fs: open read-only when ro option and image non-writable
Date: Thu, 16 Oct 2025 15:02:06 -0500
Message-Id: <20251016200206.3035-1-dave.dykstra@cern.ch>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:610:38::19) To ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:12::15)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZRAP278MB0096:EE_|GV0P278MB0162:EE_|DB5PEPF00014B8C:EE_|GVAP278MB0021:EE_
X-MS-Office365-Filtering-Correlation-Id: 56302f78-2ca4-4f6c-4ca8-08de0ceeea57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?mbfE6J+tjlhMUJGoDpJSwZE1KYIbTye6RFclfXCQykpqCFI91idWu3y8itMc?=
 =?us-ascii?Q?3j7D1yVYJcxal8Du6n7S9sGhjbHDPH9AN+ISkVlmBukrQ+HFPS7qlMiJ/VCj?=
 =?us-ascii?Q?N+D+hjWqXLJwxv5kSUVHBlbtqnLCaBOOUsnnBRgasUukOwbSy23DCZTeSSvf?=
 =?us-ascii?Q?v3rgvYwMyzOhnD343ZzNqZZQrEUp6p/Pb825gk7BbcvaVxQd3LEYkmvXtEP2?=
 =?us-ascii?Q?BHATpnGQCzUBefCjMgYwjAAHJ44aLIV2416ScRolbbLWLvyPn/4vWG1i/vTd?=
 =?us-ascii?Q?cWFUdfjl1sddDEER2Lgcd2NBXu0fPbDUJgxhTYuGNKsL1q8figT1tnKCoqzE?=
 =?us-ascii?Q?xA8XlmDSCgtc0lhk98KuRjOeVt9ySjZ45OV4MWzOPsZfhQof0+KLedDo41Ae?=
 =?us-ascii?Q?yxzh416pxKdRSmy3B+MGvK/EetrGpq0duzAC/np6IZbgHBinNNIhuk2befSL?=
 =?us-ascii?Q?tDZt+MAz6AceCGYPz9rg8XCycoeHaG+otyK+GdacI/zz4C+fEPFUj4amWqmh?=
 =?us-ascii?Q?xgVZQ9J95oWJJoCmCXeCUjjhHho21XDrWhTh2BGR1KWPb+BTky+6CQlJGtzU?=
 =?us-ascii?Q?Ft+IHfnvbL3hO+L0D3NDV9HxlY0Z4wYThQAhgitpc1D+9S65Y1MPi8gv+ZJP?=
 =?us-ascii?Q?Wo/DiSHafbk/kSsqJevlFi+ANG6wzaXzLmuNM/DgjJGJUaZ0QbZ5fsNDj8uR?=
 =?us-ascii?Q?+98wwN5EyrRSsBxN9/5X1DKsmMjZ/6q5pEjfNsPJBwzccDChe2fc44GJQH9z?=
 =?us-ascii?Q?1WFdzJnYJLeJDFmTUalx7qHoEnGPYFiBBmnl58ZQGWag73J7og2dDE56wdKz?=
 =?us-ascii?Q?vkEeHvdPFiGUY0TAsmvftFSSAeDuzY4of0ADaahDjnCgntLo0TREObg7K9HV?=
 =?us-ascii?Q?2XwWuh0JIbQ1ScT7NMIr0Ft2g52hLLr32kNSqeQHuzVhWVtzs54/a3eBeHXO?=
 =?us-ascii?Q?WEkyRAmyaZEnoQkdhhvRjgiqMwTDISo1I5s095gXuclYzTXMn1seUksXHDao?=
 =?us-ascii?Q?4iT01iRQt0LRP+d0KegGCA3OI3DZ3mYOIIdtLX35A8oSlvR9YIAuf1jdPDkd?=
 =?us-ascii?Q?w6vdvUEWcBcGXrjUzhLnj756RwZHxhmVqVw511BnYJ96V5tc1kheZwceezI8?=
 =?us-ascii?Q?UxaWnf8hclamNUEADDFko0DnPzEoNy6yc3fWXmOEbJt6LmXtZpJICjyMZip3?=
 =?us-ascii?Q?/3yJbtow/NnP9Ib0ginFbpjS8KlVqgdZQFlaoEhDTes/auMECZXQeBtqX/rP?=
 =?us-ascii?Q?XE+9uLD4Q8EZ4U3S16ld3VvcaAEkA1KxXp2OAwRa45ko5bCnwkgjvOMmWZq8?=
 =?us-ascii?Q?oOBLLOxAvdt4kB3v1sbjuqDFrwKsHiXF0sE42lg+elAfrg8cNYT3uNuYebFy?=
 =?us-ascii?Q?hWpHAuLAKfQRo86m6ebiEl2TfEFH4zEfEcnu9T377CrVSJzqnp8aWb3uHNEX?=
 =?us-ascii?Q?zkLswnJ1U+U=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0162
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2ab67c5a-0915-4c14-5af3-08de0ceee893
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|1800799024|82310400026|19092799006|376014|14060799003|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dZWCmIcOoXlqkkBxPvP5v8LMCbgQbMDWIfU3sXXOaUVXeOu9n1DO9lLq70e2?=
 =?us-ascii?Q?Yj6WeCoeRNw1CyUEvR3ttPTSNZca32omIvXh1DScGtuIQuWn/IrQYAsyXLCZ?=
 =?us-ascii?Q?RYv3gkMsCJcWzrQ0jTNl/bEogpFUJ7sPBKcZYlCFAwfQURx2sk6n1xd6eOVg?=
 =?us-ascii?Q?q1k4NqY6QYjaG0PTxyEE0BLspHRMOwrIxZkiWVv+hMhjNCkDKDN6uzyb02tF?=
 =?us-ascii?Q?Fz2RWQFpGSrAKEt41yxh3VU8/KhbVKtA5wR31Zmr/uWOlLBBGQ5EL/N52WFC?=
 =?us-ascii?Q?xNfvZhtsYMeN9GJbtx70vTNXSXn8Mdi3P2nSaOlLezAsag4QT/f7D+pzUayl?=
 =?us-ascii?Q?AgRI06KY8iOptiNblKJx/VOsY8YMLZFyS07QyQNeQo/gs3kwrrjYT7W6SA7Q?=
 =?us-ascii?Q?0eNEWsCdgQmPUItlT9eDQyt8Udc3gcAOkV0jvpxXN2WInkVwWPLLGe+uuCB3?=
 =?us-ascii?Q?/mSjFcJT3D/XStVdvTsEjX4mNeL8Rrs5PXreEh1Glp5eBLExgjKSE7jdYCow?=
 =?us-ascii?Q?H7uhBPYIkYkJzhW9xVCEl8si+VZV5qtW8bLCGNDLtsp72fxU51+HPtOZQuAA?=
 =?us-ascii?Q?VeEEeIOQbdpnljjZ0AYJEt4IwDK5q+xzyJHLVKaye/2uut4wjcZVCkczuKBS?=
 =?us-ascii?Q?v9QBVToBbXGwTnodVy0Jp0wQaPOtuZiIUZ5KSBCrqZuZ9c6F8OfxQGhIEX82?=
 =?us-ascii?Q?Ojsr1wFNWsSR7dBO9g/yRTmfBFJUDfKX5mzOfvdTrGPLFRSQGUMvTKF6MPia?=
 =?us-ascii?Q?AQV74yOwHmEw3Pdj9Qz3TmvV66HJ7laAxB9eS/CBmuQWbnwwzAzkVIOZd1ms?=
 =?us-ascii?Q?Wv38CX5yCH/vfhkd2O9n4RhSVJ1iog4bSEDe4IbwIhn2u7Wd65dzgApsKRH/?=
 =?us-ascii?Q?qGHRnj8AS/4hGBISxraVsHTaL91RVDyZSathJWd+sNjHzdjhs9eL3w3qsuj2?=
 =?us-ascii?Q?Src/CaKOH/AGSWBeLEU7aNghiN1hEY482eHQecIsVHnMi4qOTRCBk8p9uSqs?=
 =?us-ascii?Q?cdBGcHCMhomPqwpUqUzx2MOwFhj638POsAzsfdzor/K6x5JkRNh6wU5qfjkZ?=
 =?us-ascii?Q?o+d7rP1RQe/TtWChNv6HjhtcYBt7Q0c8nwfpx07ihvakzrtmLjdXL4tcwclv?=
 =?us-ascii?Q?qLU5iRauqaypgQrGwR4Ezdb6oaNNYiPKa8QxQ9AzWYB1YUr6CWoUYdtK11x+?=
 =?us-ascii?Q?AI36gu+HyDhH6scouDOWA4aNY2meN864rC24xaMD0/wga62gxn0/04TqaZYg?=
 =?us-ascii?Q?pp8TChuMShGoLxO+I+UCE1ZnQJ+dN8bsHWY43HshtgqQYGVIa60p6TnXiLQ1?=
 =?us-ascii?Q?vI2TkP/ru4McWvQYRZKSXzcR6BetvcwcPb3DvXJUz1uDYiBFQWBTlcXPN/68?=
 =?us-ascii?Q?E6gpWydh2u70lWN8LoUf5WQACs94/kIknmv2Zl6WtOX58DOzTgPmOJyEJHr7?=
 =?us-ascii?Q?forPu67V1mcauO8NW2feSzTK1TMSXZvWgEnvljhFZYIpYF5rpNPSdYM3KWiQ?=
 =?us-ascii?Q?JQd7DgxaGkoeDlLLE8/gBAxY9sL9AN8PW1Mj?=
X-Forefront-Antispam-Report:
	CIP:51.103.219.121;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx1.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(1800799024)(82310400026)(19092799006)(376014)(14060799003)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 20:02:20.5273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56302f78-2ca4-4f6c-4ca8-08de0ceeea57
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.103.219.121];Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0021

This opens the image read-only when an ro option is given and the
image is not writable.  If it is then found that a journal recovery
is needed, an error is returned then.

The ret value is set to 4 after the option checks so that if there's
an error resulting in "goto out" it won't print an error about
unrecognized options.

Also submitted as PR https://github.com/tytso/e2fsprogs/pull/250
for the issue https://github.com/tytso/e2fsprogs/issues/244.

Replaces 
    https://lore.kernel.org/linux-ext4/20251010214735.22683-1-dave.dykstra@cern.ch/T/#u
    https://lore.kernel.org/linux-ext4/175798064776.350013.6744611652039454651.stgit@frogsfrogsfrogs/#t

Signed-off-by: Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
---
 misc/fuse2fs.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index cb5620c7..2ae2fc1a 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4696,9 +4696,19 @@ int main(int argc, char *argv[])
 	err = ext2fs_open2(fctx.device, options, flags, 0, 0, unix_io_manager,
 			   &global_fs);
 	if (err) {
-		err_printf(&fctx, "%s.\n", error_message(err));
-		err_printf(&fctx, "%s\n", _("Please run e2fsck -fy."));
-		goto out;
+		if (((err == EACCES) || (err == EPERM)) && fctx.ro) {
+			// read-only requested and don't have write access
+			dbg_printf(&fctx, "%s: %s\n", __func__,
+ _("Permission denied with writable, trying without.\n"));
+			flags &= ~EXT2_FLAG_RW;
+			err = ext2fs_open2(fctx.device, options, flags, 0, 0, 
+					   unix_io_manager, &global_fs);
+		}
+		if (err) {
+			err_printf(&fctx, "%s.\n", error_message(err));
+			err_printf(&fctx, "%s\n", _("Please run e2fsck -fy."));
+			goto out;
+		}
 	}
 	fctx.fs = global_fs;
 	global_fs->priv_data = &fctx;
@@ -4741,6 +4751,8 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	ret = 4;
+
 	if (global_fs->super->s_state & EXT2_ERROR_FS) {
 		err_printf(&fctx, "%s\n",
  _("Errors detected; running e2fsck is required."));
@@ -4760,6 +4772,11 @@ int main(int argc, char *argv[])
  _("Mounting read-only without recovering journal."));
 			fctx.ro = 1;
 			global_fs->flags &= ~EXT2_FLAG_RW;
+		} else if (fctx.ro && !(flags & EXT2_FLAG_RW)) {
+			err_printf(&fctx, "%s\n",
+ _("Journal needs recovery but filesystem could not be opened read-write."));
+			err_printf(&fctx, "%s\n", _("Please run e2fsck -fy."));
+			goto out;
 		} else {
 			log_printf(&fctx, "%s\n", _("Recovering journal."));
 			err = ext2fs_run_ext3_journal(&global_fs);
@@ -4833,8 +4850,10 @@ int main(int argc, char *argv[])
 	if (fctx.no_default_opts == 0)
 		fuse_opt_add_arg(&args, extra_args);
 
-	if (fctx.ro)
+	if (fctx.ro) {
+		/* This is in case ro was implied above and not passed in */
 		fuse_opt_add_arg(&args, "-oro");
+	}
 
 	if (fctx.fakeroot) {
 #ifdef HAVE_MOUNT_NODEV
-- 
2.43.5


