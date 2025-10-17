Return-Path: <linux-ext4+bounces-10960-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9624BEBCAD
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 23:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C8F1AA748D
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 21:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8582E23EAA6;
	Fri, 17 Oct 2025 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="ee1B/6nq";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="ee1B/6nq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021082.outbound.protection.outlook.com [40.107.167.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25D354ADF
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760735802; cv=fail; b=JAT1dsiVTBw6BVx8BoUxpetO+bTya2uXVeRULTEmLfbbzkFzgiuAwvoOnABlZqpXaWBCmeRroM7nPq5c2ZEEfS8vqiBTOdeSi+2j2ruRDbbhLoM0mF2ygmEmSc+4lPoCh3PjdU9nFvvHRWYDQdjRyFVFT9CJw1B7DW7JiHsHJIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760735802; c=relaxed/simple;
	bh=hwNeW9LVlAJWaRBwJiYCEPnKTq0yH27cVcwQm2QvERo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j6a3WidJZiuHfB1aIyF4FlsS1y4ndbheuiAKodN5s2Y1Z/ZPLB5N/NIwtscv8EEisUzNk/ajfabb09fZeHs0KdUZraURB+zw0tyCfOzT1w/2ErcojqYo96CkcuqVHy4qGyXEhF+bHN0l/hT4M7WUQ7MpHI2jOYu4i+luGkjCKJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=ee1B/6nq; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=ee1B/6nq; arc=fail smtp.client-ip=40.107.167.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/lPcAZKBjRouRt43CU7dvCcbxgw/PRpKpIXsZRd1Qvx505uTmujeZykNNjvJ7s/fsEjpyCEPxaLkdP5+pFdqnxCGDTxDyBOY23Tns7I4UsVik3/7klz/KbCzuQZT6+QA2fnsMh3DHKnI+1vQjqxCYwKqHHGg5tCGrrkGjMspK/5sKGFrsgEcxWiENXx60TGuq66DfEIF+nfg3eaxgBnJrL+3ge2wJ2g8PJ6ev5fFdODj2dZxOmQbWXyJoFIcR4ujcUc+l+vwmih4C5EcGgAjqtO4Rz+H51H3SEROChTOLr76l7d9ckp3FGiU1nXrOT8gS9Jv3CMsuGXQFatmLzXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuGB1NT/UlK38MFkgUxsh85qwqn0LwLRb/AayMkmHgU=;
 b=hbXnB85Cq6/Oq/CmrF5gcD62YKjaWXA9iEsKs/9N2ZhV/hUY3/u8jl6Tt37s3hWnC/gz0fEKfT+rnhZpy/keN3NVdSGEDmwIjmWZAYpplHueYaV7fwIig5hA6Crt7LmbMr88afmUjoHFzhEog+cOu01qFKH/3hQPbxp8+dzj2q3Cn8OdO5WH6vjj65zcz0pG9037zh2x4Cane1Qety4KV4zT8j14M4AYJ+pfVnud6+M23okrMdF9Hniwqg22JI9pBw1v2ZUGpIoiaT6bHANyrHx98LryqFS0vsIx9Pb4zS0KkLXsh2dQOh6qUcmMirHqeb4/Pwgj3AlFza16ciQD2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuGB1NT/UlK38MFkgUxsh85qwqn0LwLRb/AayMkmHgU=;
 b=ee1B/6nqmrqdTlxhU6lCqB9Ss/Z9l7tmy1AQwk8rOORUpUnv/jJQieM2zjoEHynVeOaYAJIEedX8BhhAU2LKMZ1FaFG9AM/NlvTo9q4o6+/7bOPMAgjCNixfX6mxX8fZSClhrBUS+izjf+fsg3H+jysfJ68WQWjkyZu19JBY9sA=
Received: from DB8PR06CA0051.eurprd06.prod.outlook.com (2603:10a6:10:120::25)
 by ZRAP278MB0063.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 21:16:36 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::d5) by DB8PR06CA0051.outlook.office365.com
 (2603:10a6:10:120::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 21:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 21:16:35 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=ee1B/6nq
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010000.outbound.protection.outlook.com [40.93.85.0])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id 5767F7F640;
	Fri, 17 Oct 2025 23:16:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuGB1NT/UlK38MFkgUxsh85qwqn0LwLRb/AayMkmHgU=;
 b=ee1B/6nqmrqdTlxhU6lCqB9Ss/Z9l7tmy1AQwk8rOORUpUnv/jJQieM2zjoEHynVeOaYAJIEedX8BhhAU2LKMZ1FaFG9AM/NlvTo9q4o6+/7bOPMAgjCNixfX6mxX8fZSClhrBUS+izjf+fsg3H+jysfJ68WQWjkyZu19JBY9sA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::15)
 by ZR3P278MB1699.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:8d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Fri, 17 Oct
 2025 21:16:33 +0000
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4]) by ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4%3]) with mapi id 15.20.9228.014; Fri, 17 Oct 2025
 21:16:33 +0000
Date: Fri, 17 Oct 2025 16:16:30 -0500
From: Dave Dykstra <dwd@cern.ch>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fuse2fs: open read-only when ro option and image
 non-writable
Message-ID: <aPKyLgXqowdl6pPW@cern.ch>
References: <20251016200206.3035-1-dave.dykstra@cern.ch>
 <20251017192456.GG6170@frogsfrogsfrogs>
 <aPKjtQz5lmUcWf5O@cern.ch>
 <aPKroGbrXvuoBZUl@cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPKroGbrXvuoBZUl@cern.ch>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: CH2PR14CA0042.namprd14.prod.outlook.com
 (2603:10b6:610:56::22) To ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:12::15)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZRAP278MB0096:EE_|ZR3P278MB1699:EE_|DB5PEPF00014B9E:EE_|ZRAP278MB0063:EE_
X-MS-Office365-Filtering-Correlation-Id: b6251e73-654e-44f8-1f06-08de0dc27462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|19092799006|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?crmTB4YnceYv+Xvs9YobU4B7fGdWEFpseC40VyaY1U0jRecMNAbH+kzItaBf?=
 =?us-ascii?Q?t05nDvlFDjHZJF1XmnI5ji0BrCX3911TukuFNupCs51tYIRn48+ZwpNiPB4d?=
 =?us-ascii?Q?ipqFejWxn2yamymzwP3PBIIW9P/IcJyxXXph9xykh+VZhZHqb7qNDlm7D/W2?=
 =?us-ascii?Q?yxDLNG2K4sOpobzBVDMqshZgZ+pUtUQQIN+fjVbZPnXhmIS7cVSXkZViOVMQ?=
 =?us-ascii?Q?Z/F1uHPN2x7URUCQelWr1DGFF2cwXcGcxe1Xjnsc1HS6tYUW2l89mPSZm4oD?=
 =?us-ascii?Q?FBjSDzphfYBLkXNTPk8SQBtF/CqmBVWD7JaTXdd53/UfIMZSPHWD4fySE44s?=
 =?us-ascii?Q?64jT3Jx85y9O+RWvwvGhMUDcFK8xhTNtBzjJLIhbiAMxYyDBSVkIq9YLmUxU?=
 =?us-ascii?Q?zLrb1QXCLyyrql9FR3cA3+kV1FYtBAgwOn2fBA1XJiWw3H799Z4CgxLTaBx7?=
 =?us-ascii?Q?xvEA62HTxSitjQKE2JX0HvVCtorPHqms/cR9SlIXGHweDPVHbRbOtSAjjR9E?=
 =?us-ascii?Q?UKr/JqvGB2PbKRQ6xgIMGDFQaVF9mL7z71porqgwWaBz2w1SLYOSLy/gBfax?=
 =?us-ascii?Q?cwJpBvLKSHKx7/jRgqa7leEhmvWeKHPbxbdYWsLZ4U7alwOw1ZG9ks+eLbAN?=
 =?us-ascii?Q?a1ZIylrXX2h5QSJwJN7nRBTnzoQm0HAVteyRKLSvvG6LHQ8q8ZUU58IXRR4z?=
 =?us-ascii?Q?/eOIeCgs39nYDBwdu+WYElaKupyeanlBOteXTlpHUQJuiRJBP4cLsqjCDqtE?=
 =?us-ascii?Q?3XAqaMJVtbZPMhOgWSCv1X3QdvGrexjBiMHNQ3MMcZJs/D3wuoUXE9WwQcKA?=
 =?us-ascii?Q?mMWVlx67ZekJY0e+OV5y0JEaXirNdCaP8Jy9ojkxL+40LLeE4ou6lytuoV0D?=
 =?us-ascii?Q?9Mqmg3wkyUh5gCPgnlSWgiQ/zeaBNCKc+sj/zurbd5OpfBkxgfLRAJgHQ35M?=
 =?us-ascii?Q?4629RmgjVLodk7gBmO9CfcoJSoQkjbuGC4oFZoHmKmjl63XRYAa4uzCmGPIE?=
 =?us-ascii?Q?fkLc+/C+SDx+yGcS1Xb9D55MK5ZN/+3fVtSIVS110pUj2Q+zSD022SDvWl3o?=
 =?us-ascii?Q?Xvrhvsti8jSf2KDgmM1STR3zT78Jg7PuobBMq7qcHUJmh67/lVhybttCAW7K?=
 =?us-ascii?Q?OxqTS/AW4pm7oc4tcsGDHpLqRFMH+7BnJ/qFaThYhY3/ewoxsg3bpaJkLabV?=
 =?us-ascii?Q?RUFlh7Bj7m27UD2kUgrKVGZkCw97tSYm5eCj7Uc644vXzCMT+XoTsLU6BFR4?=
 =?us-ascii?Q?gGW34MDBSIaoN3ZAJChOmGiILt33nlAQcnxFjdoBr9cHp4zP1aWtzbL03U4s?=
 =?us-ascii?Q?iv2XobmHjCG1yWxcBpCVrTlbz/Kbl+k93QPMXfkxK/87nYe0dctsATAN5w7t?=
 =?us-ascii?Q?Jzps85lFnUfysFrhsHGW+DUZ6GRDgJJYW5DsFBpAuIfLsapfuatCnyo4M1xF?=
 =?us-ascii?Q?fBqNkj/Y56mAokk/Hjkw5lIEerDJK7d2?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(19092799006)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1699
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f9e5d6bc-61c9-48d6-3cbd-08de0dc272dd
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|36860700013|35042699022|82310400026|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Ymeh4kGbnJ1J0eywRstDJ+ZtWB1alo+/ydvgz6IUpLzTuJxL8mMy6jJ9oHv?=
 =?us-ascii?Q?pTpBpJwkrMxxt9QznyjayaL7T6MOQWX2l0YJ3y1AF+kdXt21ACe54d6d8xuV?=
 =?us-ascii?Q?wU3rZa+y6fAbly+gwognSlibUJkywsAg1L0xOREqKGXbha/FuzgJZPLFQf1Z?=
 =?us-ascii?Q?TLZ5iPhX7gXau/TiQgVfhacj89x1A3Y8RZeR+I43c0IyrPkwNxuCKZTdlPiV?=
 =?us-ascii?Q?A7zfrPgxmcKWevoZNhcKEJ7nPgNqeBvFJGtMeij1Xq1EWziuMS9XmufRXJlX?=
 =?us-ascii?Q?ApfOckOQ30HF/86AzG7EflK1NN919Cl4j5aFshLk9TnSmnSdAhzSX0GwxTlj?=
 =?us-ascii?Q?3P8V3RtHaIrsuUw1ucQOIHuOmaN7nosH78NAYU6LEufMn28O6d+LN1OxCa92?=
 =?us-ascii?Q?al4RKI2qsBNQc1rjxcMt9J1gTX78DXLk+Tzj6N6nc6zsl05EzrcipEeJqRZh?=
 =?us-ascii?Q?sCJBd0uISs+H2YPTKOHrdeog5h/szAGikUMC8IZDfIrjPUlLRFHajtMbXDSS?=
 =?us-ascii?Q?Ddm/XLZgfFEq4iqGgtc+NAc3xe8qtILBKuMyusUvW6+euBmYBnozxNTcTv8+?=
 =?us-ascii?Q?IZq09V864t+6C7LhsPEtNQuJF0ld7E8kpk+dC9vZ/Cskc6qiyuRH6N4uz8WT?=
 =?us-ascii?Q?Rsh+tc5b0xwCLlQsLOEDaMmbr8qVe4HZ1J/cWUFKGmFzv1umd2seg2vitBll?=
 =?us-ascii?Q?XtXGLpUAWoZd3R/vIx26wtkc0y08+bKwWF2DAqNBu723ePS2eMwZFBoWescq?=
 =?us-ascii?Q?kYxC7uZNH6gEiJ7fR4t+WFjzFNOsVrpU16KPc4QcKk7TQ4XZbQPQRNipoar6?=
 =?us-ascii?Q?SV/Qe4RvuBXm3SxDcOv4/8TRGELDzVZoW7CoyoHWwpH0mSaHEP3yG46EUkO2?=
 =?us-ascii?Q?QNpCJt7ABUd731po52HOeBWSnvRuq2+8LbTuTNxf3GrIm4BwgcvrNu0mJVuT?=
 =?us-ascii?Q?AkUmDAI2e4Umz8cT686p6RYK2ggAe3NNop42p6uxM9AIKCJiBAy/Dh7ROKNE?=
 =?us-ascii?Q?JJah84f6tP2hk6qrxqM5hw/VXPXzESSvMZFT3XDp1iB7rMQLhfEI3PWf6azG?=
 =?us-ascii?Q?soICq6+xiBvu4D3T9Uo+23kTqm45lL0Zt5JlTFYvtXv2+3SgwbOTxXcNYsdM?=
 =?us-ascii?Q?wK7N8461rcVPn156/0U6cOj0csJxQDP/LvM20F2QosuCT1MSlddimr2W31w7?=
 =?us-ascii?Q?/kUTu6nj5jFiPRldz6cCz9aMNuyNsetV2a8lycD62P4vmvRVTR6/dtbdtXPx?=
 =?us-ascii?Q?8cpMpnWT6ltRKs46VxSUsLTMhFG84GMOAviWI/pvq1/QfIDr+cJ9F7R2m5Ra?=
 =?us-ascii?Q?pRZn5Md/CQiINs5PZqEraCN0qjqzmCpCikhb5pm6/SPSweOZxq+Vx6uQ2GVD?=
 =?us-ascii?Q?p0WB4//WTPIG2psl1SpE28hz4A6WnxRNrG6OgJTKXelPArscsrTDs31uQRv3?=
 =?us-ascii?Q?H+7F31soaNvhMaD2XY41dcVneQyaZbX+16b0ITgulGm6pxekJ5e+1AlPfofv?=
 =?us-ascii?Q?45IxT0CUrt958QfbA/gX8/XGMwmIFxOGlPL3cdKiU5N7hjkG8dlhZwnzBbSV?=
 =?us-ascii?Q?uTdK0FePaGZNTgqbM8w=3D?=
X-Forefront-Antispam-Report:
	CIP:20.208.138.155;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx3.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(36860700013)(35042699022)(82310400026)(14060799003)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 21:16:35.9320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6251e73-654e-44f8-1f06-08de0dc27462
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[20.208.138.155];Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0063

This patch is replaced by
  https://lore.kernel.org/linux-ext4/20251017211130.8507-1-dave.dykstra@cern.ch/

Dave

