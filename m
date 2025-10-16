Return-Path: <linux-ext4+bounces-10910-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C975BE53FA
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 21:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCB2B4E145A
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 19:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794C72DA775;
	Thu, 16 Oct 2025 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="YfWoeJ7X";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="YfWoeJ7X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021124.outbound.protection.outlook.com [40.107.167.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F92DC780
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643274; cv=fail; b=RWXrVKR8DKLkcAvimf+tj3bqWU1p3NEn3kbiwfe6k7g66L954Yrt0XFDtDE3nvW44Wwlb202mT7pJ5EEPQmiGJqXvUw2xS/fuFvQucLQbtAdy0LbbKPo77QOCuAsxsNM6ZN25QZNLIeAqY+RMsKIw7iHD7/uyzrGlBsZ0kCq1B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643274; c=relaxed/simple;
	bh=AerpM9NC6scQS1Kc25wdWzG7K2/ToqBYRUFxWrmhMSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AcXVDpGfKwhF/OdZ2KOEZlieAvOiMGHy+e80mHmfV/NXcjl92Jo4cLzN0GgSBfZCfTB1zpZz8lZRebOvpfBH3E+LlDhTIpnCvAzUFwx4+WY9I4p0UZkw1LU9RvKWYWwbvdIg4/hcBCIsR8+2mmqYd1vBazRtGIK1D4XyzsqMPDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=YfWoeJ7X; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=YfWoeJ7X; arc=fail smtp.client-ip=40.107.167.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uA0EefKl9k28TZbBQ5Y+zI362GTD4u0hNfojE9YmISh43iESJWJNgEUrUSkS15Dw3louoK40DDW06SHQCdaLHNVCt/epaqArkqpRaBahYi6iFP1fbXGyNwcYkJKyFI/qNz5E7z854Smb6rVvVhnnMQFgHc2vMBXWojROyAX4nmbQjQJGvwdxYdwRfvAqT8Soo678ygFF5tO6HrlYUDToHydKUWpuYWZUc4ITUktHNzmYy44wpNhtSCWBMEKw8qq2RjjERAsbdGWAmR7Uq/zHPR4JXHHXK/pzJv/ZeecXO6onpuWEK0etFUFuyDcxcsJ94U2ok56vx9TIeZ4ZYThH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccDijpo9rCBpgBFyP5U6tM2EMaxPAMaGPynQnFygygc=;
 b=Tlv3tGK7Wdnyo5ajRmTLp+qC51DSBO30jDOMA8i875O3cTqWbVquuBilE+QJJCB0V1ngJroclYk1/DTAO2OqiMyt6rH+MqL3MzScyTiuQsHZniRF6zXS/8Ac9jbttMrSIvsIqgTCw8HdaqBBXTSKe3lvIxjQiPlBuFY287c2fWDoBubxHszpE/AgJlodo4Kg3r+86/iJSS0JdqrM1CPcbv6KJ2jz0+cXOpLeb2absMwSHRhDDLI0HXRvAkFuUFhIb+GYHe1o3JtJMeVMCMErNEP7kApVHghibQRMrgAAla0rs3Q5z+ttKqNQX7FknYfNdFV0W8BpuXXZR3anlpEIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccDijpo9rCBpgBFyP5U6tM2EMaxPAMaGPynQnFygygc=;
 b=YfWoeJ7X1PWYmm86/DsVZQ6LVtK8T/AycxSEFR1MSHrJ9AHQhUnm5mON32LG/AbnY/L5B67SfDZLAtbYt+Cff2TNqrjXBzkHh+nYJwdGRCJdV7Ta3b9lx+86qhlehPJC6f/yGEgq2+qGxxTLWI/HPErb0+Gdm50Faz8HlksrsOo=
Received: from DU2PR04CA0266.eurprd04.prod.outlook.com (2603:10a6:10:28e::31)
 by ZRAP278MB0144.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:14::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 19:34:26 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::38) by DU2PR04CA0266.outlook.office365.com
 (2603:10a6:10:28e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 19:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7 via
 Frontend Transport; Thu, 16 Oct 2025 19:34:25 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=YfWoeJ7X
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17012050.outbound.protection.outlook.com [40.93.85.50])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id 61CF67F636;
	Thu, 16 Oct 2025 21:34:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccDijpo9rCBpgBFyP5U6tM2EMaxPAMaGPynQnFygygc=;
 b=YfWoeJ7X1PWYmm86/DsVZQ6LVtK8T/AycxSEFR1MSHrJ9AHQhUnm5mON32LG/AbnY/L5B67SfDZLAtbYt+Cff2TNqrjXBzkHh+nYJwdGRCJdV7Ta3b9lx+86qhlehPJC6f/yGEgq2+qGxxTLWI/HPErb0+Gdm50Faz8HlksrsOo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from GVAP278MB0087.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:24::7) by
 ZRAP278MB0921.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:49::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Thu, 16 Oct 2025 19:34:22 +0000
Received: from GVAP278MB0087.CHEP278.PROD.OUTLOOK.COM
 ([fe80::168:ce42:f024:c592]) by GVAP278MB0087.CHEP278.PROD.OUTLOOK.COM
 ([fe80::168:ce42:f024:c592%6]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 19:34:22 +0000
Date: Thu, 16 Oct 2025 14:34:18 -0500
From: Dave Dykstra <dwd@cern.ch>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] fuse2fs: mount norecovery if main block device is
 readonly
Message-ID: <aPFIultQzQd6fk-o@cern.ch>
References: <175798064753.350013.16579522589765092470.stgit@frogsfrogsfrogs>
 <175798064776.350013.6744611652039454651.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175798064776.350013.6744611652039454651.stgit@frogsfrogsfrogs>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: CH2PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:610:54::24) To GVAP278MB0087.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:24::7)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVAP278MB0087:EE_|ZRAP278MB0921:EE_|DU6PEPF0000A7E3:EE_|ZRAP278MB0144:EE_
X-MS-Office365-Filtering-Correlation-Id: 0475c337-386b-4748-ce04-08de0ceb03b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?rbxtIy6PrxlmcszyyeLNrtZtUxtDEXuxGVM6b67P2dJqasdKDnP7d9pJfIqO?=
 =?us-ascii?Q?o/0cHKTlWwtX2XYCBmi+bxgQmKIpAPlUn4NjIHsCzisxuzQTN6fxEhgNcrtm?=
 =?us-ascii?Q?VwDJvWqpbyiF2kQtjNmS2pHjKgOoDI4yN5EjhAJTjbsVW03dByLTIFcWe25A?=
 =?us-ascii?Q?ybbLtCZ97VMberXM84j19rVR/Wkxbxlkp9upL4g+Ywa3TrqnGGA5nTDGplzc?=
 =?us-ascii?Q?d93j7+dS2S9sJ/DDD2cuZF5LYXyzspHSnVf7VwcepiqqHJHZTEXAS4srD/fj?=
 =?us-ascii?Q?JUw+vnwi4ud5f2nJ7390jvTFN+deXSjFLcuvx+Sh3VdW8quJcJiehpECkPe4?=
 =?us-ascii?Q?nH2cqtbRJzNzH88fLYt3dy2M3tYsvwiXlVYUVVxkSTJBPVgoop19x6+sWR05?=
 =?us-ascii?Q?6h023jLY9q+lN6uzs7RD0QsrNEvTelns3CnLtvcIaMrj7YweLBbDUGXLegFd?=
 =?us-ascii?Q?Is4gBOnG2oYdZtaS77bnm3pcrIv69gxJ7M7R63nVicKrCdlTEaw8GGI07Uk+?=
 =?us-ascii?Q?mEDQNXYQVmsQhw/pME1MRm/43YbWHBXFp0knsh/DtnlnDAgot4kcNjXq30GE?=
 =?us-ascii?Q?Sbk7CLz38KV17pmMbfbo072Ssxl99BmjAKo0FB4SuVFTbNi+1B1wrvnPqnpo?=
 =?us-ascii?Q?somaJUY+fuiow8ICjAn9tevv9lFK7lb1Pwa6EHDGOWfmS0zfgUzRZp+6aSPf?=
 =?us-ascii?Q?Flgxi5eCM7Gfe1QKhI6ybYR/hW9K3f7JhbI/XYZgdIRyOD2+n8zOFIOP8KvU?=
 =?us-ascii?Q?Ivd5r0v8xvLLLlXdODskcA2SpI6Nx8FT1vTzV8KPSmGyNhiGNqm5xTxPoCsF?=
 =?us-ascii?Q?kUepwsKXiy0WKA8u2OIC2X47O9VQ3niyzseDQ1YL+5qNB0d8m1RcHf9PVhQB?=
 =?us-ascii?Q?07zNT9CYafwWx171Swm6MGk/HUx+/86Ft9EXQT7aTjbuce7QXdpwBaX/4e0m?=
 =?us-ascii?Q?ZTPtYPvIwNGXRFxtiUCmy7pd0FfqF7jUlA2MSOCX+OBkBKZZlZ9Y6yIQwwrY?=
 =?us-ascii?Q?4hwJZCqfpq5dpGaE828PaZpuT6ix48xnAStr7/ooZeQJ8AMxTSdu7J/1Ystk?=
 =?us-ascii?Q?U9kqNKuFNopLkVGv/SoO8/ZcETQcXEa8KA8WhcAv2rsD9BCxVl9PKtMrY/iw?=
 =?us-ascii?Q?71uEgtpm0yllnOsCt0VtKgmGXrURyOKpWoLVGtR9SgK7QFLkGoUwkiVv1xHE?=
 =?us-ascii?Q?nOtYKf+pa5j7NMfdfZV4yoT/gPLMRcTO+QwFmiUTtBDKb4H6cULk/OPmvd4u?=
 =?us-ascii?Q?nB54SpxsAekQPDIxAUHxurmLSdZ9jS8xarg4TYybnVOz/bDMPuOF2Q0s+Dl7?=
 =?us-ascii?Q?QEOeALi7IehSl4MtcXnfmm9n4ENmWnC+Ag44AViHLK2NcemUKxfzXCGPVxNg?=
 =?us-ascii?Q?T8FDXPr+D9gZJjqxmvyNu2IqtL/Q3Xs1h4lTIeGMBPx27AOSh7sm0HZdTNMN?=
 =?us-ascii?Q?OjOc7vyVCIdR+hNrFc02FIrJIKd+uA2r/cymCwinRZUYa0hcWYkqFg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0087.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0921
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	eb2f5dcd-4257-4ea3-d0c0-08de0ceb01b5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|36860700013|376014|82310400026|14060799003|19092799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P+2iPS16qdk5jxswauIhYQARyfIyVe3yfhgIOXUS+HM9D0PNpDM6gXCp4Dv6?=
 =?us-ascii?Q?UlNnZImyudhi8ZMFioBJ4OApaykg17NzCgcV9/LBTgfwfyvOEBg9xHgTc3IL?=
 =?us-ascii?Q?n/F4h5zcXk4/yUqnIhAiV+FH6ypw6e0+WVSlB10doulLotlc4zmGmcTXKBLv?=
 =?us-ascii?Q?CDGEa6RguDcQq+Mpy3cxjY7m5orurrR4s0f9prG4gHhSV3xmG9Fup9CbozbK?=
 =?us-ascii?Q?P6Nt1J3prh3Mp5peIKLBGpuMMJYkQ31VzqUGaw06L1SVT3eiT1pcSmynOpVl?=
 =?us-ascii?Q?vYbFItL5sY8kgKWeed8rUYJ0GjEWG1HGZ0N5Uk8Ovftq4AOjfGjsYbi1UDV9?=
 =?us-ascii?Q?RZgdDf1DrRn5uf0nEP2SHDS9xxvMY4rFM6vJjiNDguJ+7cwwrPiS6x5ES0p9?=
 =?us-ascii?Q?RAPlKrWcWp+ztkRnZ5Rc+b6dEyzENSOqUlafqQ5C9nSkktGapDM6kixSIHFN?=
 =?us-ascii?Q?TYQZQNSPZEy7mbUnDj8g4pLKojR3nNE/yCHSxh0A97Tpuq9ukVAIcSFA4mFb?=
 =?us-ascii?Q?OX9wnFRZH3uk8JaqYwxLUs4ZGWJiU01SRb0pLeFiRwcAYGfXaSBpDLJsqKB4?=
 =?us-ascii?Q?+xfXtnV8KnziMuD94nxxGI0kbnZ63W2RtbvLAkx6REQlPVexA8CTPapCVXTG?=
 =?us-ascii?Q?ft01rmSh9TiEUTs14/g9cPHag41QElZqLAtMYdrtEb319NW0NMyeAAHVjISI?=
 =?us-ascii?Q?sblAzOSIFshTYAN8ftwWjCSLn8DaHwp0lzerVy0QQj7rXyDebMkTS6NGnLED?=
 =?us-ascii?Q?K6vgY3T7kMmVR25IFYjbTIophEDTOoye40XmxzMc0idYnhAeu+0P5dYqZT7L?=
 =?us-ascii?Q?V9t4P3szcx08NALYDULj7xeqBoIigVBx2aNuhom+1YRS67hrOVO8e73G5ju8?=
 =?us-ascii?Q?e+ilfRW4tojA49BcEgtO1A9vEbIgyTWygiftcWtfvs/SbnAg+lYgHuxmtNCW?=
 =?us-ascii?Q?5RPm9R5cVW8vh30sGw6y7vJcqdYcRzzR9zBJQY3EgxS9V0hsmXsY41NG1n6S?=
 =?us-ascii?Q?RjHJMk3LuqJLFupXEy0YLrdROhvlVewqEGl1HXxMJkVqog/j6mNfp5xhlh+B?=
 =?us-ascii?Q?eSHAvjtngzT6myZ8MwubwL85dPS5WNVikumbiTneX1sJ6rVrcbPUceMV5Cuo?=
 =?us-ascii?Q?tS01jJtUfmh3sK2MCPqIyuuZy2S8GYqklYzpfwyw2bukFntHTrjLy8AXrOrO?=
 =?us-ascii?Q?8YeWjYaMXyJLSUTsZKhIciwPjdTPVB0CWHndyYLoCjxYl8E3stnD4sf5eZub?=
 =?us-ascii?Q?XXN3ZAEN98wDsEsvLQ5hCobKkAlCriHwmzbfhQz9WcYfU9Q3zkihrLLCqQ2h?=
 =?us-ascii?Q?N/eIsDgav1eJ/BHvA3tUgK+aDVkPaNS9aE0ljma2P6HSodxz0kwItwARNtJo?=
 =?us-ascii?Q?O1oBmbpLTOkAn1cQKj8ktxGMNPSMn/8VOMz3o/wbax3z8lQRtxlAQcmKjTAt?=
 =?us-ascii?Q?KM3mrSq1doVYu1EHo5zFiYKFh9/OVeRz2u5Gmb36rwaHL8I7Azc/lcWpVchU?=
 =?us-ascii?Q?Exp1/8mNmxtp6SGxug4fiWGkram/sn1xQDAgWUEeJdmgL8EKrbLpMJnfaoho?=
 =?us-ascii?Q?W10O1r28gpUJ7IOw1TM=3D?=
X-Forefront-Antispam-Report:
	CIP:20.208.138.155;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx3.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(36860700013)(376014)(82310400026)(14060799003)(19092799006)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 19:34:25.0832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0475c337-386b-4748-ce04-08de0ceb03b2
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[20.208.138.155];Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0144

I have a few problems with this patch, details below.

I have proposed an alternative at
    https://github.com/tytso/e2fsprogs/pull/250
and I'll email that here next.

On Mon, Sep 15, 2025 at 05:03:14PM -0700, Darrick J. Wong wrote:
...
> diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> index 48473321f469dc..fb44b0a79b53e6 100644
> --- a/misc/fuse2fs.c
> +++ b/misc/fuse2fs.c
> @@ -946,6 +946,15 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
>  
>  	err = ext2fs_open2(ff->device, options, flags, 0, 0, unix_io_manager,
>  			   &ff->fs);
> +	if (err == EPERM) {

In my case the error here is EACCES (Permission denied) rather than EPERM
so I in my patch I included both.

> +		err_printf(ff, "%s.\n",
> +			   _("read-only device, trying to mount norecovery"));
> +		flags &= ~EXT2_FLAG_RW;
> +		ff->ro = 1;
> +		ff->norecovery = 1;

I don't think it's good to switch to read-only+norecovery even when a
read-write mode was requested.  That goes too far.  It also doesn't
catch when recovery is needed.  My proposed patch only reopens read-only
when ro was requested and then later checks to see if recovery is needed
and if so, errors out.

Dave

