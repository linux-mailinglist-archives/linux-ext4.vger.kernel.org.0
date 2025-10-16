Return-Path: <linux-ext4+bounces-10912-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4FBBE5533
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 22:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6DB1A62188
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 20:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90462DAFAA;
	Thu, 16 Oct 2025 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="xlUeJoWg";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="xlUeJoWg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022123.outbound.protection.outlook.com [40.107.168.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592BF2D46B2
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645361; cv=fail; b=DUpjbK73AoEBFJ4w0evd5RKz+FkjLvf/CxZ9ivgEro7wUA0U1XrB+cM3gS4Xf2+S9nMny90brS2ALA7m42MejWWQW+AVvvH7bbxiDqEYvtI+dTXQjGL4ca+CbA0G+G7nNlggZ02vtn8VMn3oofgnxQdqT+Ry5UR6jqn09foClfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645361; c=relaxed/simple;
	bh=Muk/8z9d1rwsKxx5o6j9Y6kVbragYuXaBiBOk0fqQVA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=k1X6KJr+T4WhFP7lUXMRrwuhDcYSzpb442JxUH3/rNMVBoIV1WapgmxAnX6QN3oZNWNIfNRwd0VOqsdyklOQ3rNAlie2gk2+oJPD6cP92q1icMMcxSsxIpQyq9JHtrjQEcBdG5cR8NAiVp/hoDaoejElKKbPeg72YSt/ZKnyZwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=xlUeJoWg; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=xlUeJoWg; arc=fail smtp.client-ip=40.107.168.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVmXAwFL2xP/sf1x7M29qGsWavcuzI3MvmJg2QBlKB05rRRJw+WiCDKtkrLAOh9XscAUHfBBViUsWSZZHkARp6EDAyPSxRi/JoOFt6cw+Y8le5Ce9zAl/Ekb+qt5gk/QRud4lF/kljJI5KQRBPNWaZfDjZKqm/U6GuuygCkKbsJE5eLUUPXubLUfUtneWGXRPQAyXVQTUM2SimED8gMb0MB2ZWNqbMabwS5ePJvVIml2d+YkQ3gBLxjK2p8C8ParWfRbd1s7MahtfivFj9aN57ut9pLjP2gpaxjYIkw/2IfngGm0LCng0c9QzD5tMYtrR1UorJaoDURbftChTqmCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xr1fNuvj0qpj5Lpd5kkMLOFtR1byutVY5xaqCLGBq8=;
 b=GWsqMhec2YUK4xttkEUofcuG0f47JLWMzp0K4VUQW1N7zHZnrTKOTI8d8HrSzIdLEpnvP4K/cD7FL9jMN6x313tnJTuXLU9knDX2Za4Fxq+tKLYc9eXrzNpTzs/fsuNbq+HeK9XXv+vwyf+CtMBmrDyGoDDqtgg8es5lQnuYCoLbKhPSoaC99oQlwg87E7iTKf3Hk6Lb619/F00z5WNqPbf8TbDKkdEuoe6xQpnxZ3IB/zj8Mt7sYFRu3OKVxOj0eJifld7HQqu0x9iYmjvQzRwZLcQWhOfQ3URoRnU5EhYfroVru4ZziOA1yl09AizTAVX7VM9LakWkQyqyEfnxsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=users.noreply.github.com
 smtp.mailfrom=cern.ch; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=cern.ch; dkim=pass (signature was verified) header.d=cern.ch;
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xr1fNuvj0qpj5Lpd5kkMLOFtR1byutVY5xaqCLGBq8=;
 b=xlUeJoWgQAkwhDx3dG0e5RId69+IgGnmD1CqORJdoVu/O1cEQCJkW3ayyybDwa6700jmWw4H824TsB4ywI5h4dsyGljkRAZbvPHzZ7QasKTs/L+UzEYlA0wX92GnyeWaTWm2ODHPh7vp/PiIAhSJvhsuyWYRQocfwM/0Deh/6YM=
Received: from DB8PR06CA0060.eurprd06.prod.outlook.com (2603:10a6:10:120::34)
 by ZRZP278MB1895.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 20:09:14 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:120:cafe::fd) by DB8PR06CA0060.outlook.office365.com
 (2603:10a6:10:120::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 20:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 20:09:13 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=xlUeJoWg
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17012053.outbound.protection.outlook.com [40.93.85.53])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id 9674C7F642;
	Thu, 16 Oct 2025 22:09:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xr1fNuvj0qpj5Lpd5kkMLOFtR1byutVY5xaqCLGBq8=;
 b=xlUeJoWgQAkwhDx3dG0e5RId69+IgGnmD1CqORJdoVu/O1cEQCJkW3ayyybDwa6700jmWw4H824TsB4ywI5h4dsyGljkRAZbvPHzZ7QasKTs/L+UzEYlA0wX92GnyeWaTWm2ODHPh7vp/PiIAhSJvhsuyWYRQocfwM/0Deh/6YM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::15)
 by ZR1PPF79EBF2ADF.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::296) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Thu, 16 Oct
 2025 20:09:10 +0000
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4]) by ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4%3]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 20:09:08 +0000
From: Dave Dykstra <dave.dykstra@cern.ch>
To: linux-ext4@vger.kernel.org
Cc: Dave Dykstra <dave.dykstra@cern.ch>,
	Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
Subject: [PATCH] fuse2fs: updates for message reporting journal is not supported
Date: Thu, 16 Oct 2025 15:09:03 -0500
Message-Id: <20251016200903.3508-1-dave.dykstra@cern.ch>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::14) To ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:12::15)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZRAP278MB0096:EE_|ZR1PPF79EBF2ADF:EE_|DB1PEPF000509FC:EE_|ZRZP278MB1895:EE_
X-MS-Office365-Filtering-Correlation-Id: 91469476-31dc-4405-21c5-08de0cefe058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?KVVXRFfW6PeMZTO9BMjZXWK5/1eD1UkUwexqAB1MGIiOWy6c/lY7F4pPAwcr?=
 =?us-ascii?Q?1DYZyNbQA/YN4tJPl+cXgcKHXFhqDxemqzl+nk1aDNuqDbidCj8rt5E5Ekf1?=
 =?us-ascii?Q?Vk+Gb2FUZN1WYYgAiLLjLuZ+b3qd7zhqu6uNnxK3lqW11gJcNC2GlVUAwZcy?=
 =?us-ascii?Q?+ahuh3PJGHBN2ZJ3vaRvWpITZjztlQUZ0kKgizAOfT+HjMdNkq7oyI+CfMVf?=
 =?us-ascii?Q?iVe7tILA/jl4r8qBQYJ2IgmSPGZ8e4d1bD31W3oMpGanVmi5vGUO73RvwPV7?=
 =?us-ascii?Q?LcNyNky97pTDik0hVFIaJjLyZjaITALCbol7wq5KipDFpE6Bt7I+i6gqeL8E?=
 =?us-ascii?Q?OeGmiLJdfZQlioG228eMcRknwxGbDTZ8mw2gyMc37yfTHaAlavl2FvvcYrIp?=
 =?us-ascii?Q?tzlTY5Vw8j4DiMJ7Py5DxwhHqznuKq25nBiaOhInpNknHdT8UTRwloBLWojj?=
 =?us-ascii?Q?k2PZp5kyaz05ltdjbfJdg40Rw+215CQTXiAUz3+w8/HJdEw1rsfvbcQAZbkx?=
 =?us-ascii?Q?vvE7kO6g5pMjgxn2Ybv45xInUKbZEiwdT8fWZEaaSDBxXTNr5XwkvnOGEXIE?=
 =?us-ascii?Q?YuoLyxVoOhm30UMbawNOmjSP2D1TyTTJ40OxDHQJlmgorVy2kdkpmwhDq+lD?=
 =?us-ascii?Q?3LQqQLMiCJCDz8kMK/bf0/YrsJkxnSxHAwCQyNLz4HcLyYc5xN2ApEiEIbbY?=
 =?us-ascii?Q?Oc5MhU1dPNN8YgFyU+LNi8KM1gp6QZk8QKFLr+OG1osWhb2ji7jZ6RNLdM5H?=
 =?us-ascii?Q?nkrAR2/iKybiwJ1ORiqz2T7b6u/gChsG3kSNW0n1bx1Ru9xGFCSrc4S3rawp?=
 =?us-ascii?Q?/km0v9l3kMcD9HW1zXqttBJR4Qot4Zl0IdKOJAXSxIF+Sb488o31Dgv0DBoJ?=
 =?us-ascii?Q?BpqrHUWH9GzvqV+HT3NfoQPGKMyygTnTsRaTUeuZNQapoBtV9afoAxrkm4Bh?=
 =?us-ascii?Q?uhGgdmYBL6qFYK6ojE8xhx1CB5BbdIWUB/LWAelLLO5QJiUciZZF1jgEcuWr?=
 =?us-ascii?Q?W4r6hhKIog5gy9WT6nt/FwskOorcyb/usV2/6mjCJP3T8pASWh9tLZAhqXHb?=
 =?us-ascii?Q?A/VaICvonvy1fL9CVW9FQhDUNQZcwE3yGC+K6TUGcGBSku+Q9X7yN6w2+mmi?=
 =?us-ascii?Q?MbUGkNsyqc8OlPo9vDe5yh56zVATSUAd9610JvT8kuVxIZybndk4XkvuHRE9?=
 =?us-ascii?Q?hn84H+loIDwxxj/5YMY+/dNy0tECYfAbsaQxkjNjUb9h48dc/iVtO8elSB5I?=
 =?us-ascii?Q?rDElU2HuiisHDGvfPul+j/QI/zZBN2cx4OVpn5vuPKNePgUxXZ81+prz5z5h?=
 =?us-ascii?Q?layMRCZb2SmXFtVUqOiIEFV4wqBmDJOHqsbqntKl4OjbWCChXbYIp0dB/cC6?=
 =?us-ascii?Q?Dkrq5DZ6/AlERehnejQjqdWuYWsbswYB2RBP+oDgOm2+dD3xeiAyqCrzUd+K?=
 =?us-ascii?Q?/7c8WTA/TDxr2gh/Y6EY6797hEDhg6BWfku8tkAOS6/kIg32qmu+8A=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1PPF79EBF2ADF
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ed331182-2b01-4b21-a046-08de0cefdd66
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|35042699022|36860700013|1800799024|19092799006|14060799003|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KRZB3hZsXXsolqDVjugwcVMNa3Fr0HAMNc5KfR5ignYuyx/EkkDtgLcbjQIp?=
 =?us-ascii?Q?l5hI1Pk16zXL/z776BpXwwVfyRQv7h4qc3iwmbWBA9I3pjYN014j6pgI9OK2?=
 =?us-ascii?Q?fIsR8KDhrEmiYN8/FOKj55Q2miIqrU40v6WX7Czdv+zSaz1gW2xx2yfxddNT?=
 =?us-ascii?Q?fYNh4eqIQ1D+2IEG9s6o1mcfCvXdan37L8/FWBippHqYOL9ll9iLbltj7uNB?=
 =?us-ascii?Q?2Sg2cL87O8Ljb00PeAo/Ks3+GGczq9PAVTgOfIontxiSHRb4DMqjYm4n03YZ?=
 =?us-ascii?Q?CqkE8e+dkgydHk7htsmY71NfYAnlczteqXIFeHNM9uRCuYHmVNp4K8mqiy7c?=
 =?us-ascii?Q?daQh1FOad713b34lV+cK3jgaB7b0pa2c7ZL9MZLAQCvHX9glqQcx8x+9+wLb?=
 =?us-ascii?Q?TAQPwLiErEzo/rARxoph1NKDvrrG1nQgJlbXMHKrk62LX6Uc2UkqxoIf2EHr?=
 =?us-ascii?Q?lufGcqDuiZxFyy2SVfE96hxD+QcgIrlyg8EjZ4DEhu5AdBmT3VnJmkAYlvdY?=
 =?us-ascii?Q?mTlCIrH7olfwWX9pkWUq3J6nnE+YDvMPq6sSSb/mTzLnITr6PMF9aBj4hrnM?=
 =?us-ascii?Q?EzoNksDNN6SEzoqDKPEQUoiO8RHWL6U9eIsGxHflXW3zzZeQxEudDkMRnVhZ?=
 =?us-ascii?Q?fsX0shYxubtcKR5+d347Cne24QjmH5OiGT1YgzJS3oVn/YZ+fO8u3jlbOxG7?=
 =?us-ascii?Q?LlWrJ74axTmOIFKzbyQNnJ6yYvQztu39Fu8jBLu2SibeYdUiMtLqyMNNzbOF?=
 =?us-ascii?Q?aHztlzbkpDG+vOmbR1lh1DxyEnnPMkxdTeZZWJUUs4eS5raQPky32CYv0SFU?=
 =?us-ascii?Q?DkCY4BqlAsF8i98FlBCUVo7WUKRsRxksYU1ggySVBp55UQdWxrD5hEj02FUn?=
 =?us-ascii?Q?Hfs7usR4n+zmxTwgXecQnn0vKmkQACnc0Iq2+NNTB9dZ9q5GU9L2ZxsQb265?=
 =?us-ascii?Q?xMO1ggFmODcIOW2YDZD7IlQgZDYC4R46YMghOr8lTWOY0XJh6QwVMMi+T9r6?=
 =?us-ascii?Q?ZR32nm4PFy6dkCcySt5wmB8mnlWbK6hMaKVIhn15oGDWPNAUp5QxVqQrHnyE?=
 =?us-ascii?Q?Rb5DIEmxV9uL6jXz7a+11Yk1dt1fhK4n0/QiLKe8ErQV6/VeDAnNBomrxFUA?=
 =?us-ascii?Q?vmlDGwIIzpvOueK7YEnUuR01MBxeE22shKfNPU/Gwlnf2oT4vIAVChPWbLCp?=
 =?us-ascii?Q?7vkm9n+0JwELrM2mcNMjaX9cv8U+u9+KF6zzgfzid55eLrV/7O7UICD4ANDl?=
 =?us-ascii?Q?vtzBzkbMkz4YI7jVTzSCuCWPLGsAREn7H4mFyWbJE8+bSKE9b/ef2cVwiMGQ?=
 =?us-ascii?Q?h89Cn1Um/I5NHZH0wEAlJyToINYbTsf558VeO4zE8ViXhQ4mTZoyX4z2Deyw?=
 =?us-ascii?Q?+s4ODaZFYDU3wsASX/PJCp14xXWWpvzY5OpJOY2dQpyfo/UVW9b7aMog7Wlq?=
 =?us-ascii?Q?PvPumKKZzNGVw0KUQ4vLEhQTVaE0TYKY14McADXvSLvmiR9zOA+NDe6uSEre?=
 =?us-ascii?Q?0IWBl/SL+PspJQt8vyogOLcUSdnAC3ZANFqHECFUvf4WvxNE8wZRZEJ/1SBg?=
 =?us-ascii?Q?AJGo5QEUJsZZkyQWTxE=3D?=
X-Forefront-Antispam-Report:
	CIP:20.208.138.155;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx3.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(35042699022)(36860700013)(1800799024)(19092799006)(14060799003)(7053199007)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 20:09:13.2508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91469476-31dc-4405-21c5-08de0cefe058
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[20.208.138.155];Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRZP278MB1895

This makes two changes to the message that is shown saying that fuse2fs
does not support the journal.  First is that it reverts the check to
what it was before 3875380 to look at the ro option not being set
instead of checking the RW flag.  That's because I don't think this
message needs to be shown when the ro option is set even when it was
opened RW; there should be nothing to corrupt when it is ro.

Second, it changes the message to say that writing is not supported
rather than using the journal is not supported.  The current message is
confusing because in fact the journal is used for recovery when needed
and possible.

Also submitted as PR https://github.com/tytso/e2fsprogs/pull/251

Signed-off-by: Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
---
 misc/fuse2fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index cb5620c7..c46cc03b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4774,10 +4774,10 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (global_fs->flags & EXT2_FLAG_RW) {
+	if (!fctx.ro) {
 		if (ext2fs_has_feature_journal(global_fs->super))
 			log_printf(&fctx, "%s",
- _("Warning: fuse2fs does not support using the journal.\n"
+ _("Warning: fuse2fs does not support writing the journal.\n"
    "There may be file system corruption or data loss if\n"
    "the file system is not gracefully unmounted.\n"));
 		err = ext2fs_read_inode_bitmap(global_fs);
-- 
2.43.5


