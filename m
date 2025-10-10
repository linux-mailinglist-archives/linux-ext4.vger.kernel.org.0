Return-Path: <linux-ext4+bounces-10780-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61613BCEA33
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 23:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C6F542CF5
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 21:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB16303C87;
	Fri, 10 Oct 2025 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="T1KTl7Ik";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="T1KTl7Ik"
X-Original-To: linux-ext4@vger.kernel.org
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020094.outbound.protection.outlook.com [52.101.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC7D2C2376
	for <linux-ext4@vger.kernel.org>; Fri, 10 Oct 2025 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760132871; cv=fail; b=bgYakxrflikuNHJngyl6Wmbz9Cjwabh3o6xIQOPBiFF0TkLme9jTADrYwNvjljDO2D7z2J7pw5jwtWLzo0gCLuZd7QQu3x8ARbVBG9Pb4f7jw1lzb4Tn5UfIv7xGWnZb0MqOCAf11K9jloRNu37CVpdA6IT9eoGb3l7VK/Z9QEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760132871; c=relaxed/simple;
	bh=IaJhlwm8vz3FqIOxlw7pEOktgkYYbVNhbLUxwzO6Z7U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UYt7R82amp0bmmHZQ6B4V4a3kk5f/0ek2FSHKg7nt6HHqHX3qo/jh8F9TodphIshtLHf6gKFA6jPd00Yt7OD5NK7AuHQDfC/GSzc0ylcni/OH25h7Cvzrj6z9mbyEcteg/G9Jv7UGXEFdNWFxmGt8yPwmn5NonzJlHPia9YfonI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=T1KTl7Ik; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=T1KTl7Ik; arc=fail smtp.client-ip=52.101.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqFG/rESKE3xkraRNL0n+9oj1/4V/QweMX9phLcmBRb6B8XeEOGLNlOtYPH8l5PbM63z68x+V4UbHCXRsckm2gB492CceVfKbTUcG7oCibID1yj8Tz2ca8zFWFz0VpEn2lUAHVQ9XMgNJqKBX+7oeZxaO80p3wPUWa7fMBvMsHyW69MjPForzBPXL6ahhGTYqBQ++c7BBa7N46kMsopKv1K/RbYl8Apggrzq/taLS7l7p4i/bBi2VyXVlacl8morHtdwJ+KWCupUPbt6D0hvPyL0GiTyqjBrhX9R1C4p+9otfbgjwGPpm15dqdMzMRf2/LqoJhYgi1UifgbXW/HNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEz1ZvVvCNRl0rpYwyZ2vk3GDTWaszckp1LjyCBWpAw=;
 b=kKftevlRa8dAycnTtRGHZJS5V33lOeCmjgM6f9BrTSfKFJK2QBJ6a5v/cCCsbem6aIwZ236Mm+hf6ZQaPQG9ABvn5i53GuKFQgrGarFxe7QF78Q5lxtU3j4XrM4i2bfFUeLsrJMfK8ddSzPej90AaIgHPSiDl/yZyZWYiM9dzQbTT0dw8XiLzqhzDEwRNNVNHWLiiIfhrR13TjZ77CfjtWmgxBLfSrZNf78n/hKneVmkKcxa7Eb30iVe++TwNn39nF4jvCvhouJkDDmzDeaqhsyqsp4Q3bBTml564h4apZnhjzAaGu9tPBImzTToX+GaZcv/YJ3gd32HsnlaTdDykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=users.noreply.github.com
 smtp.mailfrom=cern.ch; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=cern.ch; dkim=pass (signature was verified) header.d=cern.ch;
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEz1ZvVvCNRl0rpYwyZ2vk3GDTWaszckp1LjyCBWpAw=;
 b=T1KTl7Ik0RTQuUYOvUANFuWENEb7jW4w454jCdHnJAFj9NZFlQrc6wwsSRISLfVIeGPVfeLs8K92HRl+MQeniloc8J0RXKIa6GN1oXwMO2EEoKU2VltDjCtr5UVWQ3qE4bjru1mvGqbs5cFTaH9efVNWjZgD8uGd5l3Fr2WVSnY=
Received: from AM8P251CA0018.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::23)
 by GV0P278MB1777.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 21:47:43 +0000
Received: from AMS0EPF000001AB.eurprd05.prod.outlook.com
 (2603:10a6:20b:21b:cafe::cd) by AM8P251CA0018.outlook.office365.com
 (2603:10a6:20b:21b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 21:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 AMS0EPF000001AB.mail.protection.outlook.com (10.167.16.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Fri, 10 Oct 2025 21:47:43 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=T1KTl7Ik
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010002.outbound.protection.outlook.com [40.93.85.2])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id A5725FC068;
	Fri, 10 Oct 2025 23:47:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEz1ZvVvCNRl0rpYwyZ2vk3GDTWaszckp1LjyCBWpAw=;
 b=T1KTl7Ik0RTQuUYOvUANFuWENEb7jW4w454jCdHnJAFj9NZFlQrc6wwsSRISLfVIeGPVfeLs8K92HRl+MQeniloc8J0RXKIa6GN1oXwMO2EEoKU2VltDjCtr5UVWQ3qE4bjru1mvGqbs5cFTaH9efVNWjZgD8uGd5l3Fr2WVSnY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::15)
 by ZR0P278MB1669.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 21:47:41 +0000
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4]) by ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 21:47:41 +0000
From: Dave Dykstra <dave.dykstra@cern.ch>
To: linux-ext4@vger.kernel.org
Cc: Dave Dykstra <dave.dykstra@cern.ch>,
	Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
Subject: [PATCH] fuse2fs: reopen filesystem read-write for read-only journal recovery
Date: Fri, 10 Oct 2025 16:47:35 -0500
Message-Id: <20251010214735.22683-1-dave.dykstra@cern.ch>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:610:cc::21) To ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:12::15)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZRAP278MB0096:EE_|ZR0P278MB1669:EE_|AMS0EPF000001AB:EE_|GV0P278MB1777:EE_
X-MS-Office365-Filtering-Correlation-Id: 38084051-cd2c-45ec-b5dd-08de0846a4a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|19092799006|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?rRwjPq96Di3+jB0NqJZHFvfsEnKc1RdZfIEYonjH0jQF4c3LJrba/8oUa1t2?=
 =?us-ascii?Q?zYD2uT6QbVCfmGyjtDe232M6ulH3Q7f1pCOHCXVEMW1aFs8gXyfej/KrlKtS?=
 =?us-ascii?Q?BBj3sgZNQZR+pkFlSBGRliCoiPBSDk8Kxw79rMkkx3dUb191OeVLTvqIw72E?=
 =?us-ascii?Q?yTJwqjhw2K3PUhHBjTkvJSB400ipowboqrYU4AUMg7VaMLS1oSZIOiIe45Fb?=
 =?us-ascii?Q?lWLUsabtz0IltYGTPN7U5MvAXTc9reWx69Hn2+bwlDe7fcR7nRyJf56MAo/E?=
 =?us-ascii?Q?iBnkMeME6t63b38CxeEJA+6a0+FqbEAl+cgPkccGJOO2x7YPoL8XUi4pRBBG?=
 =?us-ascii?Q?eU5H6TzutUUqIKT+VVIUuNxqGWKtTVDx+TXkk9+WvEBFPRP20HLJjGa6HIb5?=
 =?us-ascii?Q?UMFR8N83PwRdmwkxw0gRXgS047ODYH9CseHW6Xkl/q5ut/IoUoDsAjrs+FEg?=
 =?us-ascii?Q?ER02/Oy41Teg1hxwlnoFLxu+dfKgv9C6dFFUfiTCCkzxwrd5bH4TFmyck5K5?=
 =?us-ascii?Q?8TfY6zDJT0Xq2wXjCNXkybk1ojtH8iU1YfJZj4yzrzdSTcgtJGZMgVp1+FzO?=
 =?us-ascii?Q?bI6NoKOfnlrp5LVR2lZ3/l2YfDbsPv5YhsXqyuqXPItvL85GXG0oIYaXF04E?=
 =?us-ascii?Q?3YwStoO210yLiUrJletLOV1EKiw5GH4Upgue6DTsLVhzeu+T1tl0XC6m3CMO?=
 =?us-ascii?Q?XqU8pUaKxPS+awMI6mAdfi8dNuEfq02QAYYwEPYD6Ij6k9FoZv2xMFg9BabH?=
 =?us-ascii?Q?ucxCgSE6ZLazUTUIqe2SwzPXtGNon0MdRC9EIqUW1A4d/wcZAPllbeFTPv2E?=
 =?us-ascii?Q?A8cL8BdeTCL0xEM9bVgwh23FaYl2CYIGos5LUldU1lG5ZZ70YqXkq+8Zf+SA?=
 =?us-ascii?Q?Ss/YJUlNaUhncheXHToxG5z3nn+9xU0W7K/WX8961L5XdwcGQvmOMP+TCfQQ?=
 =?us-ascii?Q?UhO8n+DctvhBawaFWAkoMlX5GMkaPGV3e26u6iz/H1fveB1ddGag6z0HPw8p?=
 =?us-ascii?Q?9/okHmrMCk2v6NsOU9zMBHsF05Qy/Gu1e5FpvA6We3VnMXHESv4Bxn+mD1/4?=
 =?us-ascii?Q?buJ6St9oRGHuKM2R3ekrdq6rrN6LlJd2/MQpYEq5uMMvICs99BXJhWYmn4zb?=
 =?us-ascii?Q?eHJ/W3X9FNSoREcu2Y1a8zcLJiUmJwjzSx5KteYeEpzfGaRj04MtNhRzhap+?=
 =?us-ascii?Q?Xm/VdAaE1X64raPnHdOTdSKgElwNAR7/9teK9MrlX6cRa/ZcQ/6Vfh9W8kjX?=
 =?us-ascii?Q?NAhfOlNRfrdLpacC82+jnZAC8Vrz1FI/Fm91YQ6wdssYSBTda7NRQVO/6tjg?=
 =?us-ascii?Q?+KmHtByBVqgpt4VfqWyqPHaO1JEcrsDYqtGz3TEphAUjSKHZyBJKNmSQTWml?=
 =?us-ascii?Q?Qs11XfE+TpwMXbASpgroHNcvsPdZ7BcTZIVAqkTe1xcPyl9fajlQHzBaitdg?=
 =?us-ascii?Q?P3iDiMMewssQ9NaGUFRVKSgXS6wwnBohKQLDzQWdiogXEzVdnQfMPA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1669
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AB.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6fe3437a-c65f-425d-e673-08de0846a313
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|14060799003|1800799024|82310400026|36860700013|35042699022|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9YG07dCvz5QlCgnoeXbIGWHaKO6xUKT1hhzRUUg/8qHLYp+ZQaQKDhpNhWjg?=
 =?us-ascii?Q?YPL7Q8OcbT+cixs9UF//wPNeF7dFbUdcsP7fxXWuT5qyMpaOTwVhd2jQ7xrc?=
 =?us-ascii?Q?LNpd+bvhphTy77+/jyrmbNf4JqasZVnAXY+0CN0h6Y7rvEn1HvuBIw/wvS0I?=
 =?us-ascii?Q?P1adINO72+x92C0WvOeWjz9urUU2NWesMmjOw23wGoxq2/CsSPzA8tE7k0X2?=
 =?us-ascii?Q?t0B/DNOrYemf0x9PrMBQEb15FjuxbvooC2J+/R+31MyvgWdj69AM4QEjq6iw?=
 =?us-ascii?Q?rYhz7/nHR90+92/mqIXWW3BU/2zFcvOyus8BolcN5Sj5+LTAVu8v1JM/Dhqn?=
 =?us-ascii?Q?aiy1kbsZ03lzRxh9m/f9OJ9ZgpnITRpAY3J2s82lj3tXbrpKPR/goY/dhj3y?=
 =?us-ascii?Q?typ2eKfATdAeG8TIh38eejoRUGRn6mwXBoO9lG4NN8e0ryXmtIriu+paXiYv?=
 =?us-ascii?Q?dpaf5vwkMQAqKyDO1KqpkuJ1j9codQzG5VzPYrDZft6wstEFmvM//I7Xrcq2?=
 =?us-ascii?Q?/BWLceLsiSPvhNTHfbe7DTX85msEBJzI21UmVm0r0n0wE9WtLidufO6WXGhZ?=
 =?us-ascii?Q?w9Hpgq8caunt6XaQhxAT7H+KcM0FqHnfpM3WKytPTEw4b7Fe0fvPpv2iaemi?=
 =?us-ascii?Q?My2f5x/evF5Nkb75AcFEECHdHtP/E6glrQmaXn1PYJMPcfajcw2wJM40PSFw?=
 =?us-ascii?Q?hh4mMpLz/LnTPBW9h7x5YaUDDmJMwtFF1W5dwYgs8UiiToIYVv6FYS9MOOZ4?=
 =?us-ascii?Q?ncr1kFxmx6RX9PR0ASeZd3FBSKMAvnbapUVWmKOfK4s/cwR8Wme8FbuYc69O?=
 =?us-ascii?Q?1tybMBX9AxF3UcwjBD6LOuAVqnoDKQuT856krOf91o3H8Lr5HGJhpQJ5GyNF?=
 =?us-ascii?Q?U+wJOCClcpIirJePXP5bcgwD6i4cHk9MBECo5vSviM1kqL1YaIxJeIOFLTrW?=
 =?us-ascii?Q?iO1UapkT8hBnX0LbI0HI5sRYtTk32M+b+LimjYpPrRpxCd+LnAsGu79q0hJJ?=
 =?us-ascii?Q?R6B0vUZ05ib9ASHevuK+wW1QtxPfV6o2q0PTrnbeYyrl3/Y2dwSXX6fMLjPv?=
 =?us-ascii?Q?lgY/moBXaR6+cg3/NTqfVew+WXRycmzBJkMxcKLNzjZ2PA0INEYdxtNRC9vq?=
 =?us-ascii?Q?E13tg79Bn5oeaM6c5PpBZffFkoUfRNAk0c2hE7ce/LiblqgBwqQi5GTK5cZt?=
 =?us-ascii?Q?NGFE0B1v+VFDPsUQy+1paDK3gar5noBXpC3IwQ+j2OjipphjAy97MI6L/CxM?=
 =?us-ascii?Q?c2P1xBefsMjI1O+qNyuqjt8FQ9BFbwLA0mfpbE4WsmolWpxKamyM4ubbpLAI?=
 =?us-ascii?Q?OBMML0I2ljOy6/uFdrXQW9pGU0ASluYNz3sgd0Jw1g8ZZ6YVrgbmPfev/Jbu?=
 =?us-ascii?Q?1GN1gAmAmSQgwwVtZ1uW7RGSoHuJUQvC2NH2TAK2hbbg/5lZ5uBXsztceMtX?=
 =?us-ascii?Q?/AVocMcPD0jM3U6qjzRUqk5dwJP00amfSrZU9V74lNEq8ASDkZcIscWVdiIW?=
 =?us-ascii?Q?JvwYfdRZ7ksmd8Tj2vvI+HD7wpeQ95AeS2u3mB6YKEmpe74Mr7IAcO3FgsjO?=
 =?us-ascii?Q?TzYgJ3BMBWeOIGGKnIc=3D?=
X-Forefront-Antispam-Report:
	CIP:51.103.219.121;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx1.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(19092799006)(14060799003)(1800799024)(82310400026)(36860700013)(35042699022)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 21:47:43.5552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38084051-cd2c-45ec-b5dd-08de0846a4a5
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.103.219.121];Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AB.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1777

This changes the strategy added in c7f2688540d95e7f2cbcd178f8ff62ebe079faf7
for recovery of journals when read-only is requested.  That strategy always
opened the filesystem file read-write first, in case there was a journal to
recover.  A big problem with that strategy was that the user might not have
write access to the file.  The new strategy with read-only mounts is to
open the filesystem read-only first, then if there is a journal that needs
recovery, attempt to reopen it read-write.  If that works and the journal
is recovered, reopen it again read-only.

- Fixes https://github.com/tytso/e2fsprogs/issues/244

Signed-off-by: Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
---
 misc/fuse2fs.c | 62 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index cb5620c7..30a46976 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4607,8 +4607,7 @@ int main(int argc, char *argv[])
 	FILE *orig_stderr = stderr;
 	char extra_args[BUFSIZ];
 	int ret;
-	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_EXCLUSIVE |
-		    EXT2_FLAG_RW;
+	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_EXCLUSIVE;
 
 	memset(&fctx, 0, sizeof(fctx));
 	fctx.magic = FUSE2FS_MAGIC;
@@ -4689,6 +4688,8 @@ int main(int argc, char *argv[])
 
 	/* Start up the fs (while we still can use stdout) */
 	ret = 2;
+	if (!fctx.ro)
+		flags |= EXT2_FLAG_RW;
 	char options[50];
 	sprintf(options, "offset=%lu", fctx.offset);
 	if (fctx.directio)
@@ -4751,8 +4752,12 @@ int main(int argc, char *argv[])
 	 * ext4 can't do COW of shared blocks, so if the feature is enabled,
 	 * we must force ro mode.
 	 */
-	if (ext2fs_has_feature_shared_blocks(global_fs->super))
+	if (ext2fs_has_feature_shared_blocks(global_fs->super) && !fctx.ro) {
+		log_printf(&fctx, "%s\n",
+ _("Mounting read-only because shared blocks feature is enabled."));
 		fctx.ro = 1;
+		/* Note that EXT2_FLAG_RW is left set */
+	}
 
 	if (ext2fs_has_feature_journal_needs_recovery(global_fs->super)) {
 		if (fctx.norecovery) {
@@ -4761,6 +4766,27 @@ int main(int argc, char *argv[])
 			fctx.ro = 1;
 			global_fs->flags &= ~EXT2_FLAG_RW;
 		} else {
+			if (!(flags & EXT2_FLAG_RW)) {
+				/* Attempt to re-open read-write */
+				err = ext2fs_close(global_fs);
+				if (err)
+					com_err(argv[0], err,
+						"while closing filesystem");
+				global_fs = NULL;
+				flags |= EXT2_FLAG_RW;
+				err = ext2fs_open2(fctx.device, options, flags,
+						   0, 0, unix_io_manager,
+						   &global_fs);
+				if (err) {
+					err_printf(&fctx, "%s.\n",
+						   error_message(err));
+					err_printf(&fctx, "%s\n",
+ _("Journal needs recovery but filesystem cannot be reopened read-write."));
+					err_printf(&fctx, "%s\n",
+ _("Please run e2fsck -fy."));
+					goto out;
+				}
+			}
 			log_printf(&fctx, "%s\n", _("Recovering journal."));
 			err = ext2fs_run_ext3_journal(&global_fs);
 			if (err) {
@@ -4772,12 +4798,32 @@ int main(int argc, char *argv[])
 			ext2fs_clear_feature_journal_needs_recovery(global_fs->super);
 			ext2fs_mark_super_dirty(global_fs);
 		}
+	} else if (fctx.ro && !(flags & EXT2_FLAG_RW)) {
+		log_printf(&fctx, "%s\n", _("Mounting read-only."));
 	}
 
-	if (global_fs->flags & EXT2_FLAG_RW) {
+	if (fctx.ro && (flags & EXT2_FLAG_RW)) {
+		/* Re-open read-only */
+		err = ext2fs_close(global_fs);
+		if (err)
+			com_err(argv[0], err, "while closing filesystem");
+		global_fs = NULL;
+		flags &= ~EXT2_FLAG_RW;
+		err = ext2fs_open2(fctx.device, options, flags, 0, 0,
+				   unix_io_manager, &global_fs);
+		if (err) {
+			err_printf(&fctx, "%s.\n", error_message(err));
+			err_printf(&fctx, "%s\n",
+ _("Failed to remount read-only."));
+			goto out;
+		}
+		log_printf(&fctx, "%s\n", _("Remounted read-only."));
+	}
+
+	if (!fctx.ro) {
 		if (ext2fs_has_feature_journal(global_fs->super))
 			log_printf(&fctx, "%s",
- _("Warning: fuse2fs does not support using the journal.\n"
+ _("Warning: fuse2fs does not support writing the journal.\n"
    "There may be file system corruption or data loss if\n"
    "the file system is not gracefully unmounted.\n"));
 		err = ext2fs_read_inode_bitmap(global_fs);
@@ -4833,8 +4879,10 @@ int main(int argc, char *argv[])
 	if (fctx.no_default_opts == 0)
 		fuse_opt_add_arg(&args, extra_args);
 
-	if (fctx.ro)
+	if (fctx.ro) {
+		/* This is in case ro was implied above and not passed in */
 		fuse_opt_add_arg(&args, "-oro");
+	}
 
 	if (fctx.fakeroot) {
 #ifdef HAVE_MOUNT_NODEV
@@ -4892,7 +4940,6 @@ int main(int argc, char *argv[])
 		ret = 0;
 		break;
 	}
-out:
 	if (ret & 1) {
 		fprintf(orig_stderr, "%s\n",
  _("Mount failed due to unrecognized options.  Check dmesg(1) for details."));
@@ -4903,6 +4950,7 @@ out:
  _("Mount failed while opening filesystem.  Check dmesg(1) for details."));
 		fflush(orig_stderr);
 	}
+out:
 	if (global_fs) {
 		err = ext2fs_close(global_fs);
 		if (err)
-- 
2.43.5


