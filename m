Return-Path: <linux-ext4+bounces-10959-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FCEBEBC95
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 23:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC69E4E59A8
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1C03112B0;
	Fri, 17 Oct 2025 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="xoFbmDkL";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="xoFbmDkL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021116.outbound.protection.outlook.com [40.107.167.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09A7293C42
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760735513; cv=fail; b=U5byayUvOzXI9KNUCgUTBSUsrqm4vwBa4h8aF4/gIlAhHn7CK6r8riOPSwttRxvxznGC5sjI5Xy3zJkkaCiMzFRUzyuG9SippgZ2lQ2siujVol1QyVJwJH/keMue9czz/05lWo3+QlnHbenFgHogkXeAiN7bZOgWTgGmWm+xzOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760735513; c=relaxed/simple;
	bh=Y2fg37kz+kQtWqhW85P59hoQ2j/IoSyWZXrVDTfgEEE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kDklG4cq90cOZGJ4F54+D2QdYc8NoqhiF4ppGdsOZSpmjzD+wZ0+ToN4OMU5E1R3/ulSoWjgUL5zqspw/pkU/bPTjXOSxsR8vPvdPOHnPpGcl+HTGnHvEH3cl9ZFiBAVpIlhYnoQo8vJP9bZW07HnuX2A4aV5i5wRXotBDg8T+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=xoFbmDkL; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=xoFbmDkL; arc=fail smtp.client-ip=40.107.167.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kU7c0UTPPH9kHD8lHY2Y+IggZVtoPTYqwPhkudwbrYYUnyrwk+QvzCj9KI6iMI90cZEXY5S0fhVh15cCvEaoTQKAyZYez7VDC19XZGTQhW6xjZZM065CYaBywSkI6glZwYcaPKMtLd2yfZBQ9kla3Mg9zh4D627p6wGC91sClQmM/10Lwmfy/WUGjfupVf5qw/4LOLih1qfoLzx2GZxDah7bcANv3A+Pf+XQ1Vc/5GutgfBhF08Iu3w7c4zOOTaFHSv35lSmX+FBn6pYlJNy7OSrhorTcCeyIJwUW83urAUIXx5isKIBIaYe6/ZhqCAAsGT6bhWFpYvPYbmvyx+eYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YH7pbCynJRw9BWaZe7Ww1lvhDryJn+XgGnLiOCTDMuU=;
 b=IS9A8lGXrV/g/x8tArCSnTht2NxR4bcRxMkMu6Y4WRNu6NT4HHPkMPmSqWQ/dITVOdnPsmRcsgSl4LLgOoBoWbq3pMhvzGblCmqWf6z4A+tSzqfSV6XvRLfAIPRP6kEtyc8nCzV7k6S7PoBlZ+tAQfl9d7q9Gei+J7Ei41/ppwvI/iOipOz9k6kHGcs9A2LARQjl1a8zTQmSzBfLsPQXNSvKxMzcns/KSCz5M0ZMQ8oipughWaP3q/KYzdYjYAekZUZqin02VLMkhCShqb/S0YaosHQIb/4+XIw0TXlLf1DWq6efmQSMUS2+3+CNEXIfrVu4ZiPtM3qy8NTHQUffWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=users.noreply.github.com
 smtp.mailfrom=cern.ch; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=cern.ch; dkim=pass (signature was verified) header.d=cern.ch;
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH7pbCynJRw9BWaZe7Ww1lvhDryJn+XgGnLiOCTDMuU=;
 b=xoFbmDkLiq/KWfuJCZpP4EZTVJoGSW+hjhceqndoYSsFpXW67z0mfcPVapJ9tnHZPZ8NRhLJ9/ZWC3+LGmThtYdWzYBiRr1ga7mGn2BKA2m2hmCYaUaZtwgasWGPKv/h4CPILjSB9wHE+sYU2i9KDnIFypQOHCzje1PqCuogXak=
Received: from DU7P191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::19)
 by GV0P278MB0856.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Fri, 17 Oct
 2025 21:11:42 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::a4) by DU7P191CA0028.outlook.office365.com
 (2603:10a6:10:54e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 21:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 21:11:41 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=xoFbmDkL
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010002.outbound.protection.outlook.com [40.93.85.2])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id B0CAD7F533;
	Fri, 17 Oct 2025 23:11:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH7pbCynJRw9BWaZe7Ww1lvhDryJn+XgGnLiOCTDMuU=;
 b=xoFbmDkLiq/KWfuJCZpP4EZTVJoGSW+hjhceqndoYSsFpXW67z0mfcPVapJ9tnHZPZ8NRhLJ9/ZWC3+LGmThtYdWzYBiRr1ga7mGn2BKA2m2hmCYaUaZtwgasWGPKv/h4CPILjSB9wHE+sYU2i9KDnIFypQOHCzje1PqCuogXak=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::15)
 by ZR1PPF65DB24303.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::290) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Fri, 17 Oct
 2025 21:11:39 +0000
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4]) by ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4%3]) with mapi id 15.20.9228.014; Fri, 17 Oct 2025
 21:11:38 +0000
From: Dave Dykstra <dave.dykstra@cern.ch>
To: linux-ext4@vger.kernel.org
Cc: Dave Dykstra <dave.dykstra@cern.ch>,
	Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
Subject: [PATCH] fuse2fs: open read-only when image is not writable
Date: Fri, 17 Oct 2025 16:11:30 -0500
Message-Id: <20251017211130.8507-1-dave.dykstra@cern.ch>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:610:59::22) To ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:12::15)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZRAP278MB0096:EE_|ZR1PPF65DB24303:EE_|DB1PEPF000509F0:EE_|GV0P278MB0856:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a05d817-90f7-4fe2-0405-08de0dc1c4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|19092799006|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?3LZ7dXpNxrFvOT5ffNJpehQgQhgH0kLLcv5+IFJnT9XcR3jwRlrGAmetW7AJ?=
 =?us-ascii?Q?N5ffI6/qEgxtboO6HDw3vxNsLlNRcVDszbs/GHxXvkJO8YshiVEiQoF3oFtD?=
 =?us-ascii?Q?7Bn/TrAB1zsmV/c063kDVqWH5RLIkBL4NGHRjPeadOK+FhOTxEhudn6jAgpU?=
 =?us-ascii?Q?VuUVMU7xlV7fBlQaLzZKhvUyn6HPBuzv/MfcwPTrvmGj4OrucydsrTXPkDyk?=
 =?us-ascii?Q?sBvQK/iC6Uch4Y+GlYPSBUkCWDvEVKdCg3D1rj6pAxVLqp1IMg1q11jmOh8b?=
 =?us-ascii?Q?10WJi8g/ybxWMODd/QZSlKtN3ExVE5BUzNPT51hO+03qg9JD1mVliF+t0wu1?=
 =?us-ascii?Q?mixxRJZwV8OgNRzwijzuthCw43DUgMyeOf608hFOtqlcgrmrYlLLVZGux9mJ?=
 =?us-ascii?Q?dLiWvnj0H59xqpTkgr2pHPWH9EfwdCcO9onBVjXwFQ6Aawk+JLsAOGvlQR4J?=
 =?us-ascii?Q?UryB+3pwzvLkkaVqSjKLg+iierPKD5DpmTBCVFyFKIRaEy9LEyx0eiTf04JR?=
 =?us-ascii?Q?VV/Cykeef5HRtYMQ8voQq2+CrTgKYUZyL81y9402UEM0rKJmfxwxrFpYQTXI?=
 =?us-ascii?Q?RD0WFWZfY7bOGvcqDfQSRju93KZHjelpF1/b+Hx3kvZjP52KmeRS9OzgaAAF?=
 =?us-ascii?Q?ZTLC0/Y0Jy6W5PAq1zkNbqoLkS1Pm/2kZSBH2h3253OSWdgh77/ByKb1vQRo?=
 =?us-ascii?Q?4lMwAqaIo+sh4HgKrunSWA2xJya2mBst3+LzUlyEJePwd64tghyQfzN1Alu5?=
 =?us-ascii?Q?c91lPcI0faJ3r/5825Gld6I84uD3mDQGbMx4T9hKN9uWIxJAC8h/zOljnmNQ?=
 =?us-ascii?Q?/7SZm9ak3oU724dFggZTbcTt7RAd6SmkTeDtvLak6uotzqKsWVFgbpl6y8c9?=
 =?us-ascii?Q?Ex/woNEgG9zWNgMUqnuM6eZqYcdNG8mX3k3fxWjuAJDPXklgyyFpLttXPg5V?=
 =?us-ascii?Q?lvWixu1hah31rSfc0gJSL9UVEZT091mHKVVLsMag/6OgC+iSDzVOMXEaDPNg?=
 =?us-ascii?Q?UuzUTr+yWHv33YxSNEAs7MictH/671bEMS2PU5sDIpCwH6tYk98HD0PtEtyq?=
 =?us-ascii?Q?bVG8OpNx3Fx4vDze+AKCjR9fS3Zzsor43QwpL5NbJNJijUflALorNX5GrID8?=
 =?us-ascii?Q?56Tlp/ggOGiusKqzvdiyXNoxXcLeD9knMKIDJMMJIpHz9oMz78GQPEwmJs2D?=
 =?us-ascii?Q?xS0tM4MDOk3O3EzCYzReaMswzuFgTORO17vUQkzqgJPjbdUcQerHr58l6OW7?=
 =?us-ascii?Q?HYA+CgmI05986C4E37iN9CEAv/pf+yLZlaNaTmzlViVL9t9kX35wX2tXT657?=
 =?us-ascii?Q?eULtuA9HvElVDy4wAjKU7glS9l4NNyXGzlNvO+Izx+jh01nh0ggrIGLlLl/H?=
 =?us-ascii?Q?XN3Oqx0E1L8RZbxMe6DiCdp4X53zEjqUNISlsNqDRpgDLNTyR/dvoYiN0/Xx?=
 =?us-ascii?Q?OnWpJD2njN8akkiPc64r+Gvvr2Ej9CcmUtqOvn9/gVjM9F03S0AWbQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1PPF65DB24303
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a9fceccc-a088-48f9-c4f0-08de0dc1c31e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|376014|36860700013|82310400026|14060799003|19092799006|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u7gdJLr876GXTucVdqFtOVrMlrpUpkPEawYhuYbJPfmiqyaR1HtHqxaOFEsB?=
 =?us-ascii?Q?ezxsh09xOA29607TQ4p1ondy16JHMlCBN8HYN5amLnHIv8MrkstkSejiwHIZ?=
 =?us-ascii?Q?9GP67FP8Mt8ulBbRaImP/b0zYPTV44z7bA+s3BnKDGa7ALgyKsc+vX3ivM9/?=
 =?us-ascii?Q?DHKkO5iudN8mspkJ+40pabD7/x/EsiNbXLrKGFT6uHdK9TCn40E86dmMxsjq?=
 =?us-ascii?Q?VMsRPCBN2M/eno+ZAdr2gbWZ0ENBWREtQX4C9l/T1U6BE0tOckW22449VByu?=
 =?us-ascii?Q?c+iohDIRk2jlB1M4yustEULuu4gAysJp4V8GZI7esOTHyTXAr+PHcLuJxgna?=
 =?us-ascii?Q?zkrRVQmN4zroYUu2iMZqDcnK0vADq8gF0JIJgCmbWc5gnv7zvtuYYy0Htw1I?=
 =?us-ascii?Q?o21b3IYY7djcK0nqpcLJiUPPd30Ye2gZZajSRBgQSBH7kHfVHan70yb/VrLQ?=
 =?us-ascii?Q?IZR09bo1iLBkqR2VZIfmEfErruCFPELrG7+YJMfkfTHp9a0fX+POjALaPNN0?=
 =?us-ascii?Q?YEQcRSKb4/DL+MFPrrpbpeqadPFe6lGUy2QHHdkULtpf9AZOyyxkoXAwTGps?=
 =?us-ascii?Q?fndGA/mS403+XW6j2mO+249tKJyMfmr+pcEPXw6zsxcbqaWdWD40sTb8or/d?=
 =?us-ascii?Q?3z7sdzP8AJcb0lhF0yFRqtWq/V88451zKB9tgrP55/llw7gCAfn7myQpbCjA?=
 =?us-ascii?Q?DNN4tmfsEm9aiKXe/1ywUETV6WM/FVHiFIRj5BQSPPjkv3Rb4dNgBViBy4Ae?=
 =?us-ascii?Q?lDTWZq6S61veO58NXTHEZY/gFanXDzu4H+7DgvFgZkSoaSIUx2sF2BXwDLrj?=
 =?us-ascii?Q?oI4Hg36aX6Jwo6gatx4MbaOcXkqS6MjkIA2wo8v0MAo1foDtdwxpDdc/KtLP?=
 =?us-ascii?Q?kH44vMHe9UAB9lccj9Av3exccw6QpiPzlhc3/kXZHksOxCFuQUCLZoZ9dSAv?=
 =?us-ascii?Q?NUGVL0Z8I4ZkmwSIVsQZtSMLUg/rM5sn/r4xeKTl/o23LGKhPaKpjbcfeV4x?=
 =?us-ascii?Q?kLV04i1GRDhTJvG4mVsB12RCKt/CV+qoskiA9iw9UUoJSNllKlwAfsb5dFfB?=
 =?us-ascii?Q?844P3Nc9x0HhNC/fiSdTAyUZnSrNTueaLjloVvcyL25Xv0Y6RZ6e/PcwEUmX?=
 =?us-ascii?Q?F0kWzoRxwzyzn6PMLP0Rqw/dLaxGr+uHO7NbCidHJxaAZyF8xU4nN9QBmzgQ?=
 =?us-ascii?Q?F5zE85+EOxLNEJPUOyXIfgduVwqNZlbFJs/dFV+BD/ztPcBp1sg7ANM1NM13?=
 =?us-ascii?Q?3MxuDDWvfzeun5cejgApN8dCv8HRSU3MD2JWEV66AStxZwkXTWEEJzieD3x8?=
 =?us-ascii?Q?Tv2pBvvdu/uOIn46U79Fxv55MFlwgAywOqkSWA68Kff0+eOEcRufnU4mg5vt?=
 =?us-ascii?Q?jhy/C2BDAHx+4IebO5Yc6NGxFAgiajeufd3KPRWFQXGr/SeyAQ3ldTRKfi9H?=
 =?us-ascii?Q?hiPPzQnIv8rm4gOhWILLX/CGZaW3y+vuF64Ssq9ndeVszlui33N7Yj2hcK8p?=
 =?us-ascii?Q?/fredL+YHCh86pHq3P9wPX5WkiSHnrBZCWKxeH+7Yb0sghObH2sQhS5kH9Ny?=
 =?us-ascii?Q?3+6Oqc4rlueqxMvjSY0Y6P94G8jFrtwyga8HvEpP?=
X-Forefront-Antispam-Report:
	CIP:20.208.138.155;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx3.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(376014)(36860700013)(82310400026)(14060799003)(19092799006)(7053199007)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 21:11:41.5593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a05d817-90f7-4fe2-0405-08de0dc1c4ee
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[20.208.138.155];Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0856

This opens the image read-only when the image is not writable. If it is then found that a journal recovery is needed, an error is returned then.

The ret value is set to 2 after the option checks so that if there's an error resulting in "goto out" it won't print an error about unrecognized options.

Also submitted as PR https://github.com/tytso/e2fsprogs/pull/250
for the issue https://github.com/tytso/e2fsprogs/issues/244.

Replaces 
  https://lore.kernel.org/linux-ext4/20251016200206.3035-1-dave.dykstra@cern.ch/
  https://lore.kernel.org/linux-ext4/175798064776.350013.6744611652039454651.stgit@frogsfrogsfrogs/

Signed-off-by: Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
---
 misc/fuse2fs.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index cb5620c7..6a107d2b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4696,9 +4696,24 @@ int main(int argc, char *argv[])
 	err = ext2fs_open2(fctx.device, options, flags, 0, 0, unix_io_manager,
 			   &global_fs);
 	if (err) {
-		err_printf(&fctx, "%s.\n", error_message(err));
-		err_printf(&fctx, "%s\n", _("Please run e2fsck -fy."));
-		goto out;
+		if ((err == EACCES) || (err == EPERM)) {
+			if (fctx.ro) {
+				dbg_printf(&fctx, "%s: %s\n", __func__,
+ _("Permission denied with writable, trying without.\n"));
+			} else {
+				dbg_printf(&fctx, "%s: %s\n", __func__,
+ _("No write access, opening read-only.\n"));
+				fctx.ro = 1;
+			}
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
@@ -4741,6 +4756,8 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	ret = 2;
+
 	if (global_fs->super->s_state & EXT2_ERROR_FS) {
 		err_printf(&fctx, "%s\n",
  _("Errors detected; running e2fsck is required."));
@@ -4760,6 +4777,11 @@ int main(int argc, char *argv[])
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
@@ -4833,8 +4855,10 @@ int main(int argc, char *argv[])
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


