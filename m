Return-Path: <linux-ext4+bounces-11011-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E46ACBF90EE
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 00:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE6624EEC99
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 22:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE81826980F;
	Tue, 21 Oct 2025 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="kNBctkMU";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="kNBctkMU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021120.outbound.protection.outlook.com [40.107.167.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F66287507
	for <linux-ext4@vger.kernel.org>; Tue, 21 Oct 2025 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086029; cv=fail; b=BlYcflcbbM3Gzbd7TyPuFb11jkGel5afBw2wRtdIGoLXCYifQyaIhS4Ec3bgXcTrMinrumjy4Q+bxLaqxaEBrSj9TiV3gwDUszz/PiH2J45s1bmvC9EYXO4IBbAucfyqJCOG37KuE3giYNrhTyJ3/BX8ko/iGGntireAjMYv5q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086029; c=relaxed/simple;
	bh=ZZ8eaSK3AEixeKvGPEksKPWCqCVMVd0uZzEsDFitP4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PYWHLT6HWJNE6q5oXhD1pmxcUlqeDcHDLxuEXzp+51Z1+bFGGt76R8soN1e/fpF5hJvLkU2UmjkE6450GXwvjQcGes3wNrCtjRSG2geUABrRxDO2tl7HHu8PauhLVP//MMXcPod25GeN6GjupggqIHTqFKPNfdZkpjz4xVO9bEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=kNBctkMU; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=kNBctkMU; arc=fail smtp.client-ip=40.107.167.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+X5XNJx5TgAxGNXC/WsW4u+HgF1DwILL9AYVNNwTQCjReknYZvXHKBqkLzzC5e42uEOapHb7otBn6QqCHG6AcVbhhhu9GrW9fVyK1vNscvgb7vzgYuchsC3VTU4PLUWOTvY9/6YhIWWuiYfB13Qi17PsSsAfTBPbr/bsS5z7P/HGnTQiNIQF2AffouwsYlKGtZ75ePfH+kKuii/l0kvhF2Dum9C1jMkSNrMW55l5GB7EOYTv8krw7+RsF3hz3oBEjXLNmMm6L1wjsSZ8ozNDlLmggzdSKeYSwm4M+pgYSdy+QlaVk51F0CyCS3jy9A4r/Lr1lTpApBJ+oMO3bD5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuAED/ahgaGn7lr43IGMiaB+mhytsnPMkhHNVUcr+hQ=;
 b=HO2GInal6ysKIoNl9xsvF/o9cgy7Bl2sm+m+kjT603waVi+2f7mo8U4I3fQNqmucx998OP4rWA6d8B0esWPTW8/qRpQopLpSFFqrZDI1LzxoVbCwfkJfJIvDjVo/4SGo25DKblFzDV+kXgR9v4u5xJJR1IotkbzPtN6ZhhkGdVXQDmk84+5GDA+hHSk8hC1njkMbDWfSq39DRlQMylr0Pvue/3YQuL4mzVJ6fLhJmwteZjYdrMQfruLtEprjWsIcWHe2C5xgJYWTLMUof3jDs6lfHJfwFziww6IXz46r37GIhYkKTY8349GbYvMjf3oH3eN7DCnfx4tRqxktt5en8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuAED/ahgaGn7lr43IGMiaB+mhytsnPMkhHNVUcr+hQ=;
 b=kNBctkMUibUw+ooRrouqYO1txK8gdTYqwEtmwjC1pXMeWpapAulv/mxNcdMxlIzX10r3S6eXXqiGh36q+CCfZLGHZ+/1KKJ3dYOx4jRUl6qt9ZxkPz4kq3cdYYH3/McbYKnB4kJSdUSQbQHjr8+6MzUV5O6drOR6++WbFOhRJRk=
Received: from DUZPR01CA0146.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::9) by GV0P278MB0099.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:27::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 22:33:41 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::56) by DUZPR01CA0146.outlook.office365.com
 (2603:10a6:10:4bd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 22:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7 via
 Frontend Transport; Tue, 21 Oct 2025 22:33:41 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=kNBctkMU
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17012054.outbound.protection.outlook.com [40.93.85.54])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id 5BA0F7E03B;
	Wed, 22 Oct 2025 00:33:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuAED/ahgaGn7lr43IGMiaB+mhytsnPMkhHNVUcr+hQ=;
 b=kNBctkMUibUw+ooRrouqYO1txK8gdTYqwEtmwjC1pXMeWpapAulv/mxNcdMxlIzX10r3S6eXXqiGh36q+CCfZLGHZ+/1KKJ3dYOx4jRUl6qt9ZxkPz4kq3cdYYH3/McbYKnB4kJSdUSQbQHjr8+6MzUV5O6drOR6++WbFOhRJRk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::15)
 by ZR1P278MB1714.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 22:33:39 +0000
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4]) by ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4%3]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 22:33:38 +0000
Date: Tue, 21 Oct 2025 17:33:35 -0500
From: Dave Dykstra <dwd@cern.ch>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fuse2fs: updates for message reporting journal is not
 supported
Message-ID: <aPgKP-wUhhfwqKke@cern.ch>
References: <20251016200903.3508-1-dave.dykstra@cern.ch>
 <20251017191800.GF6170@frogsfrogsfrogs>
 <aPKilSNCQRW9c6rl@cern.ch>
 <20251017232521.GI6170@frogsfrogsfrogs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017232521.GI6170@frogsfrogsfrogs>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: CH0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::32) To ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:12::15)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZRAP278MB0096:EE_|ZR1P278MB1714:EE_|DU6PEPF00009525:EE_|GV0P278MB0099:EE_
X-MS-Office365-Filtering-Correlation-Id: c6395c36-e465-48fe-91f0-08de10f1e2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?J2Py+ptpuMCLTFk28/y23MdRj7Wa7I5Bv1+UKSQd/ubcbLuv6bv5cBrkWJpe?=
 =?us-ascii?Q?hQRq9lJ581/vWty0uywvjT5lymWAMTBhzcqfmi2T6lVIhDC68PRhHCQEUciN?=
 =?us-ascii?Q?ZMtZ5/bhjl/dKQc1Pm4AXhazMsCL3z2TJJO5ySCxRIXXVJXhCu/KWyqp/lNk?=
 =?us-ascii?Q?oxTAq41O5yoDy6RdsI9cwea6lU2FkJbT5tCXMS2yawUWWaz3+v2b5Fnh9rGJ?=
 =?us-ascii?Q?iytNaqauHWtGDRzNO3VDqSxWHHjda0GqKCb3ja95PXJ8dwDHzFHaJwgX/9MA?=
 =?us-ascii?Q?IjZrf+el5tcQMSst5J9vD/b44qVcusx2nVqoAdHYGXpUBxE2oJ5zu4kOy9nE?=
 =?us-ascii?Q?J3CXwdn7MedaUgbrzOVFN4YdoHQH6ktxXqcxuTE9WSOxGPZpnMpxtfLKZdqg?=
 =?us-ascii?Q?wvyxt4cpTYHd0XADRMibWNVbN988nsdkTNDCj2OQAer//PcDS+tHL3CpRKj3?=
 =?us-ascii?Q?zuB4opfWC9xYV9N63DTZLTTC7yVlaMU7gyQxOOUCmKbdIA3m6HPhz+p+yLDM?=
 =?us-ascii?Q?XLej958kgX3BfBzkSol1sLYyPiqTX5yWUplAQdoAX00JEoxJqBD2RQNCz4N0?=
 =?us-ascii?Q?lDA/aJfh189EPBZazUAFCSvfMsdJutuU3HfhOE11URS6EyqStF0TX6JN+ZM1?=
 =?us-ascii?Q?xIO2sAfpM12EU3O1j2odyQcKVasem93wuc5DeGg7dQ8ek8O2TNeJ897O0wUx?=
 =?us-ascii?Q?XYf9Dm0llJyDSBw34xdzIZ82EVWVi7bA8etrfR0NASE7E1gvtWZ+NRyR8S6B?=
 =?us-ascii?Q?s6ikv2nIzeoHa3qcnotB3+zcbfj9FftAK7G6CG7VpZBV+fv2czNxel0D6dYo?=
 =?us-ascii?Q?dgzwQ9R62qTTW2rIESepTrPGUc+Mp259E2OPH19BGeWkqixPs8bSwHiamoTv?=
 =?us-ascii?Q?lS3LNRumdkIc3FHM18dUmaCJdeVPN+wVxqZT0mSmc1ikvxbu17A+H8EKYexP?=
 =?us-ascii?Q?2bYtMfXiwh1ush1tcgDXDbTkF4+NyixWDi3RckVfCd+Rh0u77trRswmkCJU7?=
 =?us-ascii?Q?2GCx9RgO5lqSFSN/BNkHNO0FRUu+NqgPJrog+B9DDa0QK4jb61zt2KRDRqad?=
 =?us-ascii?Q?vS7qGxPhyOXHEAepvPc3dxmMSpUk89j01O8n8Dgp7agdGqp3YwbRzM+qVCF2?=
 =?us-ascii?Q?HAmO9oSDjzJ3cO7KlA6kxyEhTh0czG6HXL8tysPIoleFslLDGiJDeIR49dz2?=
 =?us-ascii?Q?19ZZLSNIqveROugkeGCsdBiwVf2faulDzwghmcGjx6H16hdHiHCTKCvcfsD3?=
 =?us-ascii?Q?lNkOf1qKAmBy7wwLmahtELAFPMUc3O8K+xLT0+dtj5I6ndYNPwM5jLKYQL+g?=
 =?us-ascii?Q?/AnjawTgwS8VeEOGWmTL4MlD9EeunvONvOaNpamyi9kLlhAWqbk6m4zg1vpL?=
 =?us-ascii?Q?CPgp0jM7NrLlIu2tmdnDlayxae0BC1Njd7Sk5AL0J4H4OvBu/Gv8MfVzgt6p?=
 =?us-ascii?Q?kczLXT5ERKGw9q3EOXXp577T5gJy2FKrXYu+nXZOVfn+sKQIStVIVQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1714
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c191446d-8dc2-441e-80c9-08de10f1e149
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|14060799003|1800799024|82310400026|36860700013|35042699022|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6y8r5HaDR4ju5BVrL4+2USR84dEASnou5tPcjQUHm7Syfu4sbXzxzr4JZpmE?=
 =?us-ascii?Q?jk7o3XtyrjwtTxIjUD3xCqgeC7hUZ40lt8HFTXsDCc3UPkTkJuvSMMEHqCU9?=
 =?us-ascii?Q?svXi1x3sexw9Jgq6NaR1AawEWRKafZsOb0U6RwXj21jTtdqnGTjvjTUf63pv?=
 =?us-ascii?Q?6rpn3ttBaFf5M6zBC6OtwFLkDCVXTcKA0tJl5oXps+qK+tKii5abp/JnLlu4?=
 =?us-ascii?Q?5i86knzzsyHPHNj4BH1JvZPxbPiJVXnlGhGjd5NvrtAd6j/0RI1zkkcZb/VY?=
 =?us-ascii?Q?ecFXefJwnOiQPcT9x4LKgFRXPUKVac9BDEkYws//K00mSRPbMQt60WHqE6eu?=
 =?us-ascii?Q?M4a3479VQSSAeh6ArG3ls8UZUVBygqFUx4bPrvw9X08fpMtT2tCglofUv8sJ?=
 =?us-ascii?Q?gF93VU/Ogb8KCntoeRfoyGNochRF4mYoItte4J5Fhm3xO/C5rBiQ4M76Om9Y?=
 =?us-ascii?Q?/zIZjqzTc5vGWhT2/j573YBr2+8ZE11B99L/ZzxVkBc7c1wkgNqj6hY9/1VE?=
 =?us-ascii?Q?HOlkBJd5Bj3VcVZOQll2+R2a9A048G5++ZK1JQz3P+pueqbBwqMGT+0u6RRf?=
 =?us-ascii?Q?Qa2hJT62YdLkA3gbHy+ihfYDHxe8jwBh/vnxlS6X29I+7OJbvSBBbbdQVzK2?=
 =?us-ascii?Q?DijCzDlIQF6OK47IHVdXq6wverFHkUxgtq6rNtWGcTCJzV+7KDKjEpFfEjWm?=
 =?us-ascii?Q?jkaA9Q7KQRbnVWYrnbHuyDJw0bYJN2CPF8zwT1uw9vQp4cPe/WJDggcwdYPw?=
 =?us-ascii?Q?INsCQY+Pl49ZxNaOrD9i5cNGJlnyPW14UVLbh+Fy7/XRXn4zb17BAAw5rcgQ?=
 =?us-ascii?Q?OlOYf8MUUBTCe3YPHrbodLVO1QwT6HgyS6lLoioCpOmsXRvDX1h6CM9NAaqh?=
 =?us-ascii?Q?7d4U2xfi2xJOkEFik6JY2Xyd8Ujs6jS8ERn1SnRjvol+YlDZAH+xv3CyD6g4?=
 =?us-ascii?Q?6o6lc8aSMBvsYyFMeHxmN7I17HCGOcQ+MJ6MirCMaVwgM/hQrLmKk2bMvikw?=
 =?us-ascii?Q?vdr2RRrb0Cq2T139xIGfmbnFGm/nICiqYHbBuTAx4684P+AbufpFvca4IHdE?=
 =?us-ascii?Q?+RD7WBe6P88+H+2xfRl50/cc1V9bQz/YUWY6lAuXP4mohMmFtLuIL7enysyS?=
 =?us-ascii?Q?LaFT/H9p8hfUbXlx+K+0MyVdh2ZUMNTCQixs+RgQ9Ru0D9cKTA+2bQaGYCDS?=
 =?us-ascii?Q?qYOh2WXaeKnwq/y6SphET4i1B7xjjBGV6G/AqOjDCTWQBX2jVVlc+tbc4OD6?=
 =?us-ascii?Q?Cmj4munvAiNoyiYMuXK+Qm4mGzkLJt9QlOZq8c+KvtQ4xALnjqyxgKdm8/G+?=
 =?us-ascii?Q?Tp3fN5L37aAqzzi4eSW8vRu9u0sb8xK6l61TsUx99QGGm0tW+1M8iy65wWd1?=
 =?us-ascii?Q?BOQeEsP/RbBnkkXtCJaS1muK+CpBGl6BxQbS2jsb8p+EeqziLcaSyujU3oNg?=
 =?us-ascii?Q?SUeRaFPLNADu7zAwHQe+aodbFSiCskWFX1iBzH8lYCRvKfwsYudE9HmFa8+6?=
 =?us-ascii?Q?bhAi4nfysdBrupmvuyDXWWlhvW5oKpzdHVYd/dgl2YORfbjy17vgAPwoxz0n?=
 =?us-ascii?Q?6g+zrGik08yFlR5+7WY=3D?=
X-Forefront-Antispam-Report:
	CIP:20.208.138.155;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx3.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(376014)(14060799003)(1800799024)(82310400026)(36860700013)(35042699022)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 22:33:41.1256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6395c36-e465-48fe-91f0-08de10f1e2dd
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[20.208.138.155];Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0099

On Fri, Oct 17, 2025 at 04:25:21PM -0700, Darrick J. Wong wrote:
> On Fri, Oct 17, 2025 at 03:09:57PM -0500, Dave Dykstra wrote:
> > On Fri, Oct 17, 2025 at 12:18:00PM -0700, Darrick J. Wong wrote:
...
> > > > -	if (global_fs->flags & EXT2_FLAG_RW) {
> > > > +	if (!fctx.ro) {
> > > 
> > > Again, rw != EXT2_FLAG_RW.
> > > 
> > > The ro and rw mount options specify if the filesystem mount is writable.
> > > You can mount a filesystem in multiple places, and some of the mounts
> > > can be ro and some can be rw.
> > > 
> > > EXT2_FLAG_RW specifies that the filesystem driver can write to the block
> > > device.  fuse2fs should warn about incomplete journal support any time
> > > the **filesystem** is writable, independent of the write state of the
> > > mount.
> > 
> > Are you saying that is indeed possible for a read-only mount to cause
> > file corruption or data loss if there's not a graceful unmount?  If so,
> 
> No, I'm saying that filesystem drivers can *themselves* write metadata
> to a filesystem mounted ro.  ro means that user programs can't write to
> the files under a particular mountpoint.  This has long been the case
> for the kernel implementations of ext*, XFS, btrfs, etc.

I understood that, but does the filesystem actually write metadata after
the journal is recovered, such that if the fuse2fs process dies without
a clean unmount there might be file corruption or data loss?  That is,
in the case of ro when there is write access, does the warning message
really apply?

> I've said this three times now, and this is the last time I'm going to
> say it.

I understood what you said but I'm asking about the implications.

...
> Are you running fstests QA on these patches before you send them out?

I had not heard of them, and do not see them documented anywhere in
e2fsprogs, so I don't know how I was supposed to have known they were
needed.  Ideally there would be an automated CI test suite.  The patches
have passed the github CI checks (which don't show up in the standard
pull request place, but I found them in my own repo's Actions tab).

Are you talking about the tests at https://github.com/btrfs/fstests?
If so, it looks like there are a ton of options.  Is there a standard
way to run them with fuse2fs?

Dave


