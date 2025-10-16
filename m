Return-Path: <linux-ext4+bounces-10913-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 15530BE5599
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 22:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DC37359D5F
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 20:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C66A23EA83;
	Thu, 16 Oct 2025 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="ZrabVuht";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="ZrabVuht"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020143.outbound.protection.outlook.com [52.101.186.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3571A9F93
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 20:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645804; cv=fail; b=Yndh35ieKn5AjdB2ha9BkBwJC9AQS7fWu7BXFSzrzROBItjAM85WZntvLjCbeirGp92bEb2STTkoy9bcqjOTRyjk0VToTqSouENHNVhm/1sMD3oO35NLhrsCOHnQzD9traEP44HiJ27VVL5BibQTqcqGx/Gyfv33Y546EDdwPMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645804; c=relaxed/simple;
	bh=zBYQU0/INjKAoGWYQ9+f50XVG64DQ0+jSfdZ/xsDCnU=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WFzyS0Jfbt55WTqwVvIWqqnSiOeCsBd6/XUFsZeb9ohFIBbI6YP6CIakHlBPNhQ226wM0Lor9Ko8pVa9AcX6FiYVpdo0Scf6eJg61lHo/P8xWiZFoNCl436WKJZzgH6342/qARaUMLOT4w6+4XIOVV8QKhiUTkEb8kQjbMNB2PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=ZrabVuht; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=ZrabVuht; arc=fail smtp.client-ip=52.101.186.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeuUwQaTvIlHuehE4Ztai3L/+MrgPiByrMjqoKefgrVV5IttGdoWhdHbaDXQOGu6xSjEkqimDDQka4F9wMEz84qVXnPEKTV2m8tof5JJEWKc1c6shNBWCArIJqQxSjBrcvtVYQpEQbHo7lV7qXtchYKQuDayFQt8NtuBZ9lhcsvBfF7V3IuNpbsRFfjbjPf6BNO6+fHF6tkEMWg5fwJ+Bkf1Di31aTfG5MfYOiMry/JanZtDresLEnBNMYBCms0dP2MBTTv/iPgrqJzZ9nZzQPOozRu6mZLUo13PWmwNfrRVzkgKnVvV2KhJgQFjyHUoEhtalAm7DR12aR/StrNg3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBYQU0/INjKAoGWYQ9+f50XVG64DQ0+jSfdZ/xsDCnU=;
 b=cUFRflmrSMDu3J+0wk2k0Gdi2cyGjKu9yKw59qCc3nFWde4/NBZEXU2qrOJy5TmY3TWN+VEQgoBxKDNn7gB8ypkMtEbQMQBQNp+KBtMxrnoAeCXLOweJCk+nJxKzYyViClKs/Rx5Xh0G+O2qYoq5h0m4OCh+/MsGxiGcdBQo3MLxk0jtBF/XzpEeu7/oCiEAugkr/VgzR1+9lSv+THeJbnuPnhexVCetWSLA5Wi2IpfDDsmnxElSa3xwBEzIPfy6fFkB1c2o46AGGQZpOtlKIAmwfcErk5w7zvJWYIJHtB0SoVyuSu//Li76+Ht+zFFN7gbOeOdyzjCdqo8JpFPXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBYQU0/INjKAoGWYQ9+f50XVG64DQ0+jSfdZ/xsDCnU=;
 b=ZrabVuht5oecBetZyMFmujujKokfHgeVl2I8rVGxCE8xEAeQFB6Mu2GTUM6FLRp9mz+XUYZSFUy3dez2syLygQqYce7+RdvObM5kPWPyVtj7KwpuuaGjz7NXf/+TgEdJ5YejNtcKdv61v0IDoUeIVO7Y/3K3FR8eQmHosk508XA=
Received: from AS4PR10CA0002.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::19)
 by GV0P278MB0114.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 20:16:39 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::97) by AS4PR10CA0002.outlook.office365.com
 (2603:10a6:20b:5dc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 20:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Thu, 16 Oct 2025 20:16:39 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=ZrabVuht
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazlp17010006.outbound.protection.outlook.com [40.93.86.6])
	by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id D5821FC88F
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 22:16:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBYQU0/INjKAoGWYQ9+f50XVG64DQ0+jSfdZ/xsDCnU=;
 b=ZrabVuht5oecBetZyMFmujujKokfHgeVl2I8rVGxCE8xEAeQFB6Mu2GTUM6FLRp9mz+XUYZSFUy3dez2syLygQqYce7+RdvObM5kPWPyVtj7KwpuuaGjz7NXf/+TgEdJ5YejNtcKdv61v0IDoUeIVO7Y/3K3FR8eQmHosk508XA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::15)
 by GV1PPF8D494F452.CHEP278.PROD.OUTLOOK.COM (2603:10a6:718::21f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Thu, 16 Oct
 2025 20:16:37 +0000
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4]) by ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4%3]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 20:16:37 +0000
Date: Thu, 16 Oct 2025 15:16:33 -0500
From: Dave Dykstra <dwd@cern.ch>
To: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fuse2fs: reopen filesystem read-write for read-only
 journal recovery
Message-ID: <aPFSoWjlmi4njIj5@cern.ch>
References: <20251010214735.22683-1-dave.dykstra@cern.ch>
 <20251015011505.GD6170@frogsfrogsfrogs>
 <aO--1J4bOVMYgbBt@cern.ch>
 <20251015214028.GE6170@frogsfrogsfrogs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015214028.GE6170@frogsfrogsfrogs>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: CH5PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::16) To ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:12::15)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZRAP278MB0096:EE_|GV1PPF8D494F452:EE_|AM2PEPF0001C714:EE_|GV0P278MB0114:EE_
X-MS-Office365-Filtering-Correlation-Id: b358247b-0983-4bd4-f1b8-08de0cf0ea2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?3U09B6APMEiNR1eNx2uOvvDPs6++7xueiGPMxgL3b9KcoEviUrDgBlFTto33?=
 =?us-ascii?Q?484Tw+Va7tLgqefaONQyY5Z8Qz7EJebAljwGNsxsvDjTQxry1HzI/c+0eo9q?=
 =?us-ascii?Q?iyzFYVRMD51X58YeC1oF2ZuylWXAQdLiYnr/JKAW+feZCf1UIML5644oLKnt?=
 =?us-ascii?Q?M5cDijJYQA245MkJSl6sjD0VFc9Sng6JXmMf5wGCJkB0kBupMwjX2WNY+d0i?=
 =?us-ascii?Q?imkQIx/OIdkuSoELfFeZqXXdbqidlPBxw64PnOZVjS/FOLApiWVKG/jMb6NM?=
 =?us-ascii?Q?dH937LIz7p3/NP70mvOqMU1b+EkYf63bC5hjtLS4W5FPP0uObiJL1G4qAqoq?=
 =?us-ascii?Q?v2HhUoie+C/AuxLfblxyzJIJ0lKXNK2fvzjw5TG50cUeVms8bwa1wqN0o1WH?=
 =?us-ascii?Q?981x3j+7IKBPFkyo9/H2LcrWuJu5JuT/Z+gsWyHk0Jv6nh+BJDgfEDSsSgED?=
 =?us-ascii?Q?fWWIHhrMz1ORWVcnkCZuuA2P59lrwZ+D5q10joCiZR7T0qI3rl95fV/WdT/4?=
 =?us-ascii?Q?myco5zdE+JTAhniybDBLc73pCKOEr7utNwAknSENXiG36H2M+cPp6Wx+pMaG?=
 =?us-ascii?Q?n1nBc8BXN7dKbqnQv6StoQYudg+sQ4m6NlaYsf2HVha356amYcEQhUhMt7wy?=
 =?us-ascii?Q?9ez+b1RGQF9HmnFs70va199aBgxAJqmgF0wf07LyD022hOow2KysTOZ47Uc9?=
 =?us-ascii?Q?/xEnB7f/SWa5U2I8hrN3IbRnrGFNn7jlMg03cHrKCso+rDLfLVyZ7ImaGotS?=
 =?us-ascii?Q?XZP21ePRxDoegJC32GaQZyfLZJTqgW2fhHcYt04tyKE+tz4GqHGPntWtv51t?=
 =?us-ascii?Q?CKdZ6hUbc7ipIy8gMfeZ8YzmavhK8ZFtfIuxBchdbWEoAbd0kC2izNs9m7oG?=
 =?us-ascii?Q?gmj2L24pX+7IbLGJeSR9bp4YSibxsalvHOWQb57X0h+9dfc0EN9y9q+P2PXu?=
 =?us-ascii?Q?HgqOHvtfv9A+GoGqEY5nFzKW/9TSw40qyBcHR3kyO4FX6oRLcXEFtSWqZm+z?=
 =?us-ascii?Q?Ks9T3eIgu4Z0PtfK+M2RLPliTxId9rJxTziuyWPPFXvTMO7Be7GP/vfu54AZ?=
 =?us-ascii?Q?yky26KLULh2v4ZNvHI8jPhKtqgxELmw9evQqqs+R+QiiCoNRFFjXHAeiiR8n?=
 =?us-ascii?Q?G9zjjRg5RNpT3aArs3BCTW/sWixAjGV3eJfdq8dQnaSa2BrfCWyqFBdgYyxZ?=
 =?us-ascii?Q?HyMC1bYq1Pj2jtrIsxMUUShbpVKNpkF2MZYc784xRbF5CabeTFt+xEQSe+FV?=
 =?us-ascii?Q?kludFKVZv1XRHHu8Nknvtqx6EQgHK3RHpWnLW8xxIButyu5JoZf095jp0/BN?=
 =?us-ascii?Q?kr+5nm3q/1NLWXv/vK4m3jMJdnQp0f33o3P9QJfRwd+aH+ly3s5QYhDsM2by?=
 =?us-ascii?Q?8IDDXZCZVK19WNMAEWwUeKnERI4KyyquBKlnTzgmrWeBfIR79qQ+cCWfP6Sj?=
 =?us-ascii?Q?4FhFVzx2JrYEQGzziARUtgBYXfQ4pLCk?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PPF8D494F452
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	79dbcfb3-299c-42dd-5568-08de0cf0e8c1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|36860700013|14060799003|376014|1800799024|19092799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LJBr1laUF0t0UXIEFdJGJWms/O9KUCpuIzhipBbEgi64eENmBAAj8wSPGcVG?=
 =?us-ascii?Q?3LLlKxEHZa/lCGsWSkp+DuwtS24xqf2NSmgKw2ky1CC5wiSM8TQanteBuwN8?=
 =?us-ascii?Q?BbpSWO2nnzapKDdMSXqeVtLdOHcpM/HBxtZ0AKy+yVgiLbCZxngrlap7Q4gh?=
 =?us-ascii?Q?LDdP9Gn14cPAPqiblorJe3gwyKKih8IE6mIViy3xk1TCrO/A3xyKtfYRVJL6?=
 =?us-ascii?Q?zVoYHEPpj7xWxSq58OSaiFY+96oe54VPXfEd1LbfQRgkwl80tvqgNKUaFQeX?=
 =?us-ascii?Q?vhPQLvLuLl6XxWdc9uYW8Ln7Og1AYBvwfCXLuEtpMZbiKicFoQvyQVZAYaZ4?=
 =?us-ascii?Q?NLxrtbz1vnhnB8W1gt7A5YF+8kwbdAi7r3lST5kL0sJOVTJfkJfChqc69Hn7?=
 =?us-ascii?Q?kCPsVroAv64NP3+tZPtsD0bgFp9uY2RWZNBenlqlaqj0fsue98/KDHGipdED?=
 =?us-ascii?Q?HRt56TBYQO+yVgukyPBQmhGgBebLRMR1txW3beKieakvvAHH8NQhuGLTbFQW?=
 =?us-ascii?Q?/5z86OF4SFB134v8zvppacGNP/CxnOjRWVceW9y8g7ENaq4umyN3hKP0D/A3?=
 =?us-ascii?Q?DVAU53w06Nqcn5UtyPiMm8wzHAF3ws77mGysencDGgVcE2uh7dsDYRyfO4JE?=
 =?us-ascii?Q?/3gA7gZ/dFtrOgKBPKS6QoMNunEW2YPBs5scCaMi/7UadBe08CIrRhGUSWge?=
 =?us-ascii?Q?hfN2WAh0DZ01GOoOqHDravCPpx76a6brSWo53HskRZt6kJRoUIw7ikIwaCih?=
 =?us-ascii?Q?/wGST0HcOZBanXANrvukurBrqcWdElSKwemY3ewd9Qh5YD4dbuwWpyLSOljy?=
 =?us-ascii?Q?BScU3IEVPWkDzLwcQEXzsMAUMQkHDyxhh+FL+C+Ndgx7DbI1am8irS5yK6wu?=
 =?us-ascii?Q?N2XChX4Y9YhUu57qcYHA8IF96DoGpcpI0lXrcS83iQX/BvROS7kPFEOGFa4F?=
 =?us-ascii?Q?OU6SlpqNA0Fyqs0wqpZRnsikoX080zE+DM8d7nuRPmmQJ/F59A+DyZrI8epE?=
 =?us-ascii?Q?3A2ioFHNiwYStJHvCbymBzsIlWPNJfxNIldO035QYonpJpy23Zyl/QSo3idO?=
 =?us-ascii?Q?s/+ioUTPHHMn2ihnZCAFCXZ1WX+qVB/oqYelivv4Ofn4lcgP5I2UaB/9qCGs?=
 =?us-ascii?Q?R73FC1KYGF9TKjySaYYbNM4OGtbernh59jqMKp18jQHqeSU4vtXINMotWpg5?=
 =?us-ascii?Q?uy5QgVxlPmlY+a6CqCMIoBHQZBk1FYRID7GfoLYruDsc9OsussJOOM2u1jFg?=
 =?us-ascii?Q?TJvq4E8wpNjuB6OJUFpPsCq5nalhhOjEr2DPlxXK6ahI1eXQCm/CsfdcmmNY?=
 =?us-ascii?Q?cfiStLadpYf2uWtH6UPzeDxEH9pU/02Q6/QuN1W/upAGyoh6QMjvES/a8Y5B?=
 =?us-ascii?Q?MvjDQTJTGbZJ7a7LdCpyr1vZpuUIl9EUPRxypPyuMISXi9BsUxN/Lek/hjg1?=
 =?us-ascii?Q?N2Y0jPWp/uuysJ0z28kEG9SkegE7cnomHvv/iAcnEMROvxZmGlfTT0ohdXDC?=
 =?us-ascii?Q?+p4J2590iudieLKKtbkrox91FOyed6sBfI/DMN0Ps+Wgdaoa7iFx1E6LpKYx?=
 =?us-ascii?Q?t/rtUlmYUeFLQ+SvsRM=3D?=
X-Forefront-Antispam-Report:
	CIP:51.103.219.121;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx1.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(36860700013)(14060799003)(376014)(1800799024)(19092799006)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 20:16:39.2930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b358247b-0983-4bd4-f1b8-08de0cf0ea2d
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.103.219.121];Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0114

This patch is replaced by
https://lore.kernel.org/linux-ext4/20251016200206.3035-1-dave.dykstra@cern.ch/

Dave

