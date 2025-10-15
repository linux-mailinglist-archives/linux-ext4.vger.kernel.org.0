Return-Path: <linux-ext4+bounces-10885-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 956B8BDF684
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 17:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C88482694
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 15:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC44428B3E7;
	Wed, 15 Oct 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="sz1D2XAe";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="sz1D2XAe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022104.outbound.protection.outlook.com [40.107.168.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488F28725D
	for <linux-ext4@vger.kernel.org>; Wed, 15 Oct 2025 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542512; cv=fail; b=KOZCrMaNz/PG+qZiTyoy970FORbWl7TlS7A1MIF7ZoArPfkv4RrZKN1pLSsMq1EVhzxlDZahSgd+WEzEtwP60UaAgVkx6cfqjN/mL2a1+rinoQweWFGcOFr7zPdS1TqUwr2tPkNZ2q+jgMRYjG4wd13Pbq1LVcvDwmtlRjkHAdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542512; c=relaxed/simple;
	bh=+FjXYgUILQ2qurz14JczGNuNDeu5wS/0Uvfvnd/v9qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lzU2DC5m+cIAskFBAiqYv9dfaJJkhXUmEQAqaQGZpSEyicoSmIDp5eKtuVH0eRO//JTcTbpVwkejDRvFxmawYY2JWY1e72dOGNhgsM1fdD7DqyAH/K9V4xWhUg53ZzSIJakYQa/TY5CQTbXUksqIavjAyJqNHJb7+iTGrBEupJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=sz1D2XAe; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=sz1D2XAe; arc=fail smtp.client-ip=40.107.168.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RM7Rw2J507soaKhy9+STRsVfTgxWnd2MbFk/xaC++/ugMdpkz7taoPtDaPepUxtyesuoAf+c1iW4gn9DPr+xQ6deVts90o6z6d0QwBahonj8Zoifn5E4HAfiZRfS1OETOCUvnPIRRizoU3Dc7u+9fc7qA9ZYaNjr96eElX3xzVSZdBgGtIflDcDPNM1e/Q1xiMYTmJvELGjFwKXHVG5lTzvWV4ZvJUjnwmuoWHTiRW+or0au743As7Ycef37P+CnZ6Omz20I0XQy+4Vm2IO7JYPxru/oiv2Z8FBMGy39mHgweKm5bW4TKjdShiQm2Qicxy8khXnYTuoKklgNQVQQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=403aLpQG/StegNjBAE13FzNQgkU+I5fggIyNRIo7UMo=;
 b=wI+Zh2pg6oQtwYsVcMrL+k6xXnbX6IfLOLgw2nRG3T3wkLd0zJCU+rIuG2lA0GIppcl+x5b4GNKV2EWDubWgqYE+Rvme8sYL/2r7CZMJlEXg+3b4juHpHdK8ZORvn2TfxrUPX9GJgrmk3PBJ5erybzYcehQ4f8xu5SXlV/iz4L/qsKIc/uGscMJDRm9ldK5YovqGH5hGDBa7bPEg6sFePlQs1UsyfB+w0PXgjf/kSkKXzD6yDwHPNsDt+26LvFs7b73IMg0YOMPftMcMUwFNzhmRsgwljH2WzgFF2P4bweL92lTn0TSM46kZi2qwad2QvyTqHn/GZlOBq0Jn7ygrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=403aLpQG/StegNjBAE13FzNQgkU+I5fggIyNRIo7UMo=;
 b=sz1D2XAefwBxxsWY9J3vTZYdM0UB4m5QSmC9ZR+ODGny2Em0U41br0dkqFfvpi1aDYHV5K1ySkVX1k9nApVKEknNE1aZFzKTa0PuNUSxQ2pwQajcOiBRHQOTnNSEQ0JCib/IIMv4RIa2ymkTjx+jmRlqi3XsQn0c8wVlcBbBm2o=
Received: from DU7P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::34)
 by ZR5P278MB1999.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 15:35:05 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::d8) by DU7P191CA0006.outlook.office365.com
 (2603:10a6:10:54e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Wed,
 15 Oct 2025 15:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7 via
 Frontend Transport; Wed, 15 Oct 2025 15:35:04 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=sz1D2XAe
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011030.outbound.protection.outlook.com [40.93.85.30])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id EB2297F63B;
	Wed, 15 Oct 2025 17:35:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=403aLpQG/StegNjBAE13FzNQgkU+I5fggIyNRIo7UMo=;
 b=sz1D2XAefwBxxsWY9J3vTZYdM0UB4m5QSmC9ZR+ODGny2Em0U41br0dkqFfvpi1aDYHV5K1ySkVX1k9nApVKEknNE1aZFzKTa0PuNUSxQ2pwQajcOiBRHQOTnNSEQ0JCib/IIMv4RIa2ymkTjx+jmRlqi3XsQn0c8wVlcBbBm2o=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::15)
 by ZRH2PF1C5EE90E8.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::209) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 15:35:01 +0000
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4]) by ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4%3]) with mapi id 15.20.9228.005; Wed, 15 Oct 2025
 15:35:01 +0000
Date: Wed, 15 Oct 2025 10:33:40 -0500
From: Dave Dykstra <dwd@cern.ch>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fuse2fs: reopen filesystem read-write for read-only
 journal recovery
Message-ID: <aO--1J4bOVMYgbBt@cern.ch>
References: <20251010214735.22683-1-dave.dykstra@cern.ch>
 <20251015011505.GD6170@frogsfrogsfrogs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015011505.GD6170@frogsfrogsfrogs>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: CH2PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:610:57::28) To ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:12::15)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZRAP278MB0096:EE_|ZRH2PF1C5EE90E8:EE_|DU6PEPF00009524:EE_|ZR5P278MB1999:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f136ad-a9da-4261-24ec-08de0c0069d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?y580n2oo6dbg4JdoHjjrzVnL6pNRm9q5/t7nwHK+FApv1q/S5jcAM5fuCKbK?=
 =?us-ascii?Q?RkUGueXyurpbhgk5/cRJAwsSj4bjcoBcKLwRmKvb4Kh/OnEufh4N4wO3eF+y?=
 =?us-ascii?Q?uQ1+f1BiWudz3s8e78VKh0xXqikOSLhBBoIGGZIjXWmEQHYO9T4JbLgsGAo8?=
 =?us-ascii?Q?wq/7XI2Ln6OaNuZ7szCbpf0ylFLcRjUn7S/JRR2gENkTFk7Q8cS1Sx6VA4NT?=
 =?us-ascii?Q?VrJoWzFUHW33nmc5Fg1Q0BnkgerMVlIKWKFRMGW6FKMyvFmfp3UVkvwbRkQp?=
 =?us-ascii?Q?vCDTBrghUTfrYp9Dw105D5izasz4/lT1Ig+M2F5bYszuJ+dIgdTkWdkbD0Qc?=
 =?us-ascii?Q?DwOqrRSZvpwXlKNODpr+INjb6rax3UNkRw+wmAeMFr3/sWukvMCLryBZWyww?=
 =?us-ascii?Q?t0wws/rNcwnljIhx0cl0uwqdaZIeiSxerZqVtNO3C26stzUkcLR/UmiMa7RN?=
 =?us-ascii?Q?s8h1H2AcH2+xFt//JGlzxsw/anuBfl+210jvzOecA51VvvvCbrjenNMtBosv?=
 =?us-ascii?Q?tbi4npoeQwwGfc1U7+f4fr7cX4ul9xSAqNZKYqCpTnf5/g8XPZszoj1h4VSU?=
 =?us-ascii?Q?/w2yD+AWswOCRI9D+gTtzdKe1D8jdUTLIRYUVMZM6H9XLyBMHQmxLn01yQyS?=
 =?us-ascii?Q?D6uld8eHUo+BfoxTFQpGl87xglWDNokmRc99OdV1cmz1VKwh61OBrWt8cFFn?=
 =?us-ascii?Q?bGVPMOZ9OpnigSKanNLIidJNuAPLNCpOX2q4NvYJtyNS379qKUX4/r3mrYCR?=
 =?us-ascii?Q?VtmIyLvh4bH6FRNT8+bzRjVHs7eRA2IMvN3i21T1EheAWBS6MVsxtxMpYgXo?=
 =?us-ascii?Q?Ikzve1Y5qIpn7Nd7HZzBGzjaE8ng6MJzMS28VMiMmlJHg11bILcaSWT5AlzO?=
 =?us-ascii?Q?fi7rjog90lPZbZ7HZ1xbsnJzRys+yBZUOrjSqxYAdKohQE+3AccqdOHbDX4T?=
 =?us-ascii?Q?xDYPcRHtoylIIKYwphFipF/oh4R/FCqb6eEIzSndxWgEN+D2l9e8XM6iytau?=
 =?us-ascii?Q?M+ROKHtmcWh4wcxn5qXsCeQXrr5M8gOD5/cQ/hSH5cAfz4gc1Hnx2swatKOZ?=
 =?us-ascii?Q?OTqfKJjKp18eA1S8Jl5lSXTCeodNr1/K4xIG14S6XOa7OT8Zkgifiin3NadW?=
 =?us-ascii?Q?4ObEI9ozkJngZwHmgZ2bOZFeTvtchyN47Q4GIH1jMpqMbLArapl48Kf/6Cwe?=
 =?us-ascii?Q?JmR/NqsERlQejLUESjCxQ2aAN5WncHqUa3RFq2s7rFbwmZdMl68pIkrm0YUG?=
 =?us-ascii?Q?Gkj7MKYXln7xmuGbhubXjGSP4ZIOGqJTIKL8bn2BcbAM8c9E7Y8GLvha49iQ?=
 =?us-ascii?Q?0EfGxYU/bNJaEyqx4HKUrMHqJ++WDSWyBqZgQYPuG/njaG6vVntCcCxa94LF?=
 =?us-ascii?Q?w2YB4ErdW5YyESuSN7/hMe6S7pPZsl1Y3JLPmLxUN4qTV0ZK/kP+EjziLg2q?=
 =?us-ascii?Q?ErK4Yo9HPTZ8n3ca6Wz7GvEP38C1JzqCsPwfaTfOgM5SZaZfWx0FnQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRH2PF1C5EE90E8
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5b880b91-0305-4676-75ad-08de0c00678c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|36860700013|1800799024|376014|14060799003|19092799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MvvzZZmyYe9UyVh87sDq6e0Nmjf4zgApAW1afVs8Hg16MqUcBQQPDpUVP61W?=
 =?us-ascii?Q?DPKE+NdPEdhVhdEEmWbptwcAgr2wxpO9oXLmKFRXX+BiHfXe+S5nto0Dbjsu?=
 =?us-ascii?Q?pHmpLt4LPWRbHZ1/JMA1NQq2bbRzybi2F5J6CcGdxdxS9hE790APIdyGxr9Y?=
 =?us-ascii?Q?eD1b14DKa0l1GJZ1z9L7zzqo2kdK05vMaG0LaROhzHU9oFGRzlkBDhvU1qNX?=
 =?us-ascii?Q?mxv3m8xK8U+kiGfrFIzG24SVG4nW3CzEfKwCPPUWHFT2g1/lNoRmCEj3DcsE?=
 =?us-ascii?Q?WNldqp7Ej0hPZla0E0ki3xpJbNxmJGVN5yylpkgKjR0TFaRThDKUgCL35Iun?=
 =?us-ascii?Q?pyumpa2u7HVtfID7jcd/X2/Pdsh6G82D9VuVtoQz4Hnw9o306kVKWDN6YAIS?=
 =?us-ascii?Q?I/yYxMMaiwPTviipp9YuYSMHyWh2esqFHem7I44MBTtUiokFHS5S82mS9Fba?=
 =?us-ascii?Q?0YQjQYuYB2T0O3BoKy6vpX3iFRS8ZsZqG3cu/n8MdOJag6g70u+3rJSe7WkJ?=
 =?us-ascii?Q?B9SQmvZ+0HqCNfp13oooPP+sAkPSjF6dVjSUWLR+DaXg/Mh258nJ4bh30IrL?=
 =?us-ascii?Q?o4DwtEuLeURqwdtoQO4jRRAIf5WQd2qcqip3N7wLndwTUQBwTvvPhovp1GAi?=
 =?us-ascii?Q?mEkkS3tkOhI0u5tgO9JlQELQPSK4ijodyckFWPdpTT7xxCixsoEQMG9htqLS?=
 =?us-ascii?Q?a+FGHMbrUMclP5HJPgqLHHNlNr6M0/bjLFYLVVSsADdroCCJqjyebPo0lcXv?=
 =?us-ascii?Q?vYY3Mb5/AaRWYyKqKceu6p5IPk3bdjjXKXiPiws+rSVeZnhS3GjJiLd0RlXC?=
 =?us-ascii?Q?aVV0gyeIOcA/VGGrnEfkkphidJfAFNkjD3l0CsJqLzCAWdsp82Hl9lHyxXFI?=
 =?us-ascii?Q?utiHV9baSvaIL2iPEyBbO2WXCxHKOEHNj2D0cy2AqVa23co+EhUeSE4n42gJ?=
 =?us-ascii?Q?2rci9cP7BziiDlA7PyNsySGVa1dBegTMvGeCD2y0P3swMZVbBLwh9Y1Xsaqk?=
 =?us-ascii?Q?y+UScqtNgT0azLlS88vVDs5nfSC5hIs924SmXxaITAgpD1yy6YNIEHF8YS9p?=
 =?us-ascii?Q?9E4bOKnirWo5A8dvpRqLAINF763Vy9hz5Ppv03FAAtcUMVTqlmv+BuF9dcSY?=
 =?us-ascii?Q?m9+kcdQGm61yDBDvfDHSXwtyno2EMEN2CxL8g1uynPkklfNRW+Gjei4apK7o?=
 =?us-ascii?Q?59xVS4nViCJ7tC9aGF0kV++72uGR5GCrM5wrAnONKcgGM4qLFNv+N/+DDgF8?=
 =?us-ascii?Q?7pE+sxUWUhDt46HlC13QnFjwj19oOpmxLBaZ53BZrrWsufgd+MFxoE+lrvrA?=
 =?us-ascii?Q?ga6VIH/HfvDvW/Wh/sTMC2szji26HUWCrsDRSUkQjfpHrTv9qN+cpyW8Nw2k?=
 =?us-ascii?Q?EO8tzVcgnHT+kL1Wf4kDGcnIJI2RRxn9ebJuaa7XhH4IDct+lSwChmkVVRR/?=
 =?us-ascii?Q?k1fWL36JjzAxD4EnQof3kbHHt6TM0r9Ea90OvFww7U14GN5eGW3Eo4dutsP+?=
 =?us-ascii?Q?0NLbKaHHpnmkg06abVzPnJ5rAAPCOwTxEs2BuL5UM11sqwbq8tKvFBjj7TAM?=
 =?us-ascii?Q?XyYjd+JPJ2BXqLpb9/8=3D?=
X-Forefront-Antispam-Report:
	CIP:20.208.138.155;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx3.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(36860700013)(1800799024)(376014)(14060799003)(19092799006)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 15:35:04.7028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f136ad-a9da-4261-24ec-08de0c0069d5
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[20.208.138.155];Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR5P278MB1999

On Tue, Oct 14, 2025 at 06:15:05PM -0700, Darrick J. Wong wrote:
> On Fri, Oct 10, 2025 at 04:47:35PM -0500, Dave Dykstra wrote:
> > This changes the strategy added in c7f2688540d95e7f2cbcd178f8ff62ebe079faf7
> > for recovery of journals when read-only is requested.
...
> ro and EXT2_FLAG_RW are not the same thing!

I understand that.

...
> I don't like this, because we should open the filesystem with
> EXT2_FLAG_RW set by default and only downgrade to !EXT2_FLAG_RW if we
> can't open it...

I was following the suggestion of tytso at
    https://github.com/tytso/e2fsprogs/issues/244#issuecomment-3390084495

However, I think your suggestion might be better.  I will try that.

...

> ...if the close fails, you just leaked the old global_fs context.
> ext2fs_close_free is what you want (and yes that's a bug in fuse2fs).

Ok, thanks, I'll use that.

...
> ...and also, if you re-do ext2fs_open2(), you then have to re-check all
> the feature support bits above because we unlocked the filesystem
> device, which means its contents could have been replaced completely
> in the interim.

I'm not convinced that's something to worry about, but in any case
your suggestion of only opening ro if rw fails should avoid it.

> Also note that I have a /very large/ pile of fuse2fs improvements and
> rewrites and cleanups that are out for review on the list; you might
> want to look at those first.

I do appreciate your efforts.  Unfortunately I have too many other
priorities to have enough bandwidth to take on general responsibility
for reviewing fuse2fs patches.  I also don't have much experience with
filesystems.  I'm only trying to help here because it is impacting a
case that I support.  I was very happy when I found that the fuse2fs in
v1.47.3 of e2fsprogs fixed another user-reported problem, but the new
version ended up causing a couple of new problems.

Having said that, if there are particular patches that you think are
important bug fixes that you would like to call my attention to, please
send me a direct message. I could test them and respond.

Dave

