Return-Path: <linux-ext4+bounces-10957-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB0DBEBA31
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 22:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831977452DC
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 20:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853793081B8;
	Fri, 17 Oct 2025 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="ts2tH2y1";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="ts2tH2y1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021138.outbound.protection.outlook.com [40.107.167.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4EA271449
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732414; cv=fail; b=hKZUtZQQ6JsML1H4cIfU9D/4yCyEof6PTNFxEoXAt+rfGhByN7r8xncC/QKikSbp32EPpTOIAqmxLEaHZD1nCJkONtMGf12CeXIgQY8L1qny955h2a1CJC3b24Y+0eymCwUyVae/kde9RaXs5AE5rKSOGCTuAy3A3ktHXHdj05g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732414; c=relaxed/simple;
	bh=AGi3gMv4w79CgMk1yO82XtPzFYA0y/omL1XJ/pspdKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HBMzFE6geHfVAHF7Vc1dyIz9+MyhcEkz2dQxOFI7JLvTfqigDBmhYILBDal2T2pri24189Dcq9sWpxY5wbOkax8gmk7Q+lZYmxZaVqyF1xrIRhvPlfnEn+QejJrHHNbWd8dk/GiZ+ixUUXYHRP5CTI4vYBNQEwqkJysN9yvv9ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=ts2tH2y1; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=ts2tH2y1; arc=fail smtp.client-ip=40.107.167.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUF3zn70sfDzwXTmbEONFt2F5I9lD5zCEJt6UgpuqN9apuUhdlmNV3HZwwH7eS9CE/jgHG2qPJowJUm6OVUTRPXNAS0yy9wO8RqdV7asN4R85ynqPlrT4B06KF/GpM+yoAfWovRTfRJFp744x/w2jcW/2y2V9eVt8YcWg4tEsO5UfF2EBEAkX5fJQap0svM4lHGt2YovWOhk0S8AN9dl3x/av/YvZbtnZpd2avqCM2vv/syRmWKibNO6p9qbxtN2AxyruoaJP6PJ1IR2lXUfSN3qRwJTY5emGgtQnk3puoTkLIFhFcbyj7/i0qf86DaqaBLmZXm6zRkQ+k8TnnercA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T789UCbJ/CQjVRNJpfenyzGaQ05Ba5Zh52NOWmsLR8I=;
 b=uLISDmhaGgW+S86lsiym2EpvQgAMqEogtAKbLJ3B8KqR4r0f1wxqmxoUPYzdNLXiRu7GXUAC3MFFZShcFFS+OOvyDdV5V0Jz9eFoOew5Wy9zg04WF551I5KtbGSDRb969Q+K6ufPYWHROF+pUt3vpzyfPSC7NhayKwCq1DFAtz5ckP6ELxqMqtDiL6dW//JDLck92M6WZ42WwRjt7ZAx+XO/mN90NwvzmxVdFVjs+EPel+Ob1ByiKwNe4MmV/K/guUyGA05AFQ4SHmcYjf6FcX09nJgX755NlxIesH6w8yheysNofUfz8JHrMQt6/AOeb5kpwdE/TZpN08/TQp1R4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.107.2.244) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T789UCbJ/CQjVRNJpfenyzGaQ05Ba5Zh52NOWmsLR8I=;
 b=ts2tH2y1ZF3bn1bqINm4A3nTq4RcYUjdlYxVJ3Me+vVe9pv57zyhk4rYm9s66pZZK7HRftS5eRssOJX6O9yua+sM6Hsck6Y6517cakJdGPFjDUlDt3Gzu506sXqeTQ+jWpyICobADmGgQ4c23IYv9hhh1baCtCLRbcBFzSVBYGo=
Received: from AM0PR02CA0150.eurprd02.prod.outlook.com (2603:10a6:20b:28d::17)
 by GV0P278MB1068.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 20:20:07 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::65) by AM0PR02CA0150.outlook.office365.com
 (2603:10a6:20b:28d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Fri,
 17 Oct 2025 20:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.107.2.244)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.107.2.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.107.2.244; helo=mx2.crn.activeguard.cloud; pr=C
Received: from mx2.crn.activeguard.cloud (51.107.2.244) by
 AM3PEPF0000A798.mail.protection.outlook.com (10.167.16.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 20:20:06 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=ts2tH2y1
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazlp17010005.outbound.protection.outlook.com [40.93.86.5])
	by mx2.crn.activeguard.cloud (Postfix) with ESMTPS id CB07181200;
	Fri, 17 Oct 2025 22:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T789UCbJ/CQjVRNJpfenyzGaQ05Ba5Zh52NOWmsLR8I=;
 b=ts2tH2y1ZF3bn1bqINm4A3nTq4RcYUjdlYxVJ3Me+vVe9pv57zyhk4rYm9s66pZZK7HRftS5eRssOJX6O9yua+sM6Hsck6Y6517cakJdGPFjDUlDt3Gzu506sXqeTQ+jWpyICobADmGgQ4c23IYv9hhh1baCtCLRbcBFzSVBYGo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::15)
 by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Fri, 17 Oct
 2025 20:20:04 +0000
Received: from ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4]) by ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 ([fe80::83a8:5ea4:ff1f:acf4%3]) with mapi id 15.20.9228.014; Fri, 17 Oct 2025
 20:20:04 +0000
Date: Fri, 17 Oct 2025 15:20:00 -0500
From: Dave Dykstra <dwd@cern.ch>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] fuse2fs: mount norecovery if main block device is
 readonly
Message-ID: <aPKk8N1_ssr3f6Zd@cern.ch>
References: <175798064753.350013.16579522589765092470.stgit@frogsfrogsfrogs>
 <175798064776.350013.6744611652039454651.stgit@frogsfrogsfrogs>
 <aPFIultQzQd6fk-o@cern.ch>
 <20251017193841.GH6170@frogsfrogsfrogs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017193841.GH6170@frogsfrogsfrogs>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: CH0PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:610:e6::10) To ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:12::15)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZRAP278MB0096:EE_|GV0P278MB0996:EE_|AM3PEPF0000A798:EE_|GV0P278MB1068:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed907c4-5165-4eaf-91bb-08de0dba9029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|376014|19092799006|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?3fFkvVHWDulTkfbtpiA5Ke4kLPZJlOYiXZIbu/MOZY286ZYi3kzSEAn5qoOC?=
 =?us-ascii?Q?Z23Mpp9iqxhnMdbM+UPVQebGp4ua4gh2hKjNZ+WttWxod4Pyo6H9lGr+2RvR?=
 =?us-ascii?Q?iUPkBNoAtR/A4SVGJ9t8Ak9xmgS0/H8/2wEtHX2TrqhPdtsRTLUClj+xxyZs?=
 =?us-ascii?Q?wpRCEWHf/VmHvreWRLkWK5x0yHoEvdwTE0FJ+Rmu23UUz64goa3Xt+kj8TG1?=
 =?us-ascii?Q?1iyi3qBJqBaBzUBKl5ox+IsDgzMfHrXYZcH4ZPjfWcTrdaTWEhosdROrKsKk?=
 =?us-ascii?Q?LYg9NUZ9hARy0xD+m4ESKaP9bJohrQ47DzYzlZ/uGjdsh22d1aEnAHGNPjVG?=
 =?us-ascii?Q?VMiUW+7I1o5r7DfxalHGPKxOZQfuctg6RArny625WGskvpkjGnJvYanMIk59?=
 =?us-ascii?Q?3EPJS2Hs9IADxBHXwBK3uo6Ujahje64lJwU+KImF/6UJsx+bTyGWfYHkGENq?=
 =?us-ascii?Q?3q4XijBSIpXO+bf9WgYs+GpbnZmIZbpkU0JmbGOAUkL6F+3DA6fGhvagDIbL?=
 =?us-ascii?Q?qlynqE4EsWCYEZzw4rB6332QV9IdV+1N0Z/ZXCRTL7J7FHWYwR7ZaEwJnB6f?=
 =?us-ascii?Q?maZ/RM1HDZehvbOFo3yoDyttKcyBapPVoGP2pNWUgiB7FmQD2gHqaz0X2ivy?=
 =?us-ascii?Q?jYv9LC+ZrvwCcvKdPx5LvfETv4fujlwo52j2wkewV/5vFRtmalWT7gvR1rrV?=
 =?us-ascii?Q?alhrtv6anMHRRhlzELH45ETIFN4JtV/3XOPH8+sXH6Sn77+0uI51kxou8o7h?=
 =?us-ascii?Q?BiGCFZe6Js6w2L+fjdEBuIKn/Q7hLjaPl0uF05417U6hCWguRGIZr5uc92hq?=
 =?us-ascii?Q?UdFjJzjlZma4Vz7Fcri7bqV2PyA652UofQFJH1ixqr3hJDHI/QInD7OiOXkb?=
 =?us-ascii?Q?pxC4EH6dAmmbj2WD9+BNuKqG52Vu77EncczVb7C2IqtBQ/4c2hDD4tpT21P+?=
 =?us-ascii?Q?9euUIbhPwEWf2LhPacw2xbJ9MqK15+6KyQ3gmSAHDsaLn4rATZgrCRy+L7AK?=
 =?us-ascii?Q?J97f+bUoj2uIjgfsaIl4m8LG1lBflkCK4HUknZCGa1pkbt1s8v7BA8sI+VsS?=
 =?us-ascii?Q?swjLAPYqPvJWy0ePKt8FC4AM0pmiLqJ9eB1miaIHVBIE9op3BIia7zXwJkFJ?=
 =?us-ascii?Q?LjBJQPzU2h1xQHx2GXVZkwj9zlU5DGNO2zlP5WOaZHMiXHJ8pxMsipEDqXoI?=
 =?us-ascii?Q?nPUtdQG8DReqZii4SUHnaRjUFnONWyizVLwZ3rxbAKts8LBJBqjQgOZFy2yU?=
 =?us-ascii?Q?aOd2GFeMMl2X0YXHLG/M4uYBPjI69re/EBc5/dKlUi3uU6paMRgk0UsXTwwe?=
 =?us-ascii?Q?8+qRwrlqF7nSdOR9hMOUZjPdey4/rXwtmYaxDv2DCrbUQcquAmFYIff1hUbY?=
 =?us-ascii?Q?y9HMiOOeZsy9IFV9Fn7Rjdziw5K8WRkBhwC9Jhj9Kcx1wfbR0QyXSlDofTtV?=
 =?us-ascii?Q?EQAYxgZoMzxtFrWt43JzkfNSeif8HMBq?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0096.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(19092799006)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0996
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7c089fab-b258-4a7a-56d5-08de0dba8e7f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|19092799006|14060799003|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UohmWy0yzb5ZbT3YLzRfEp7H+i0N1y1gQSzXCL809yl3gE3mGBIyQKSW0ON5?=
 =?us-ascii?Q?Y/hc4RHnBTyiWLZJqtuXz1wJD0H9DDZnIsAde3yXiYoRNDDMIe2FtcCyC3q9?=
 =?us-ascii?Q?yFb+Qiqn3PdNSTZ7HzA99CawceQdx8EP5nvjbQR4eTskF8gDqR7PPhnpugST?=
 =?us-ascii?Q?fRkrC9DujzIcLA/k3Ls7Zg++4ygtB2/DLhv7H545IT5S/kOSRSVVQFC/qOrq?=
 =?us-ascii?Q?3jpDU9JaEsDyJWDLItyb0r6fiFJ4pNRim0ek2IpZM62GNqoOHIKzrDBiYK4C?=
 =?us-ascii?Q?tpqLHnaLsbIjlbQ2E6GVOJg0lngQAyzZqTtXySjgA75NsLcOZyRiA/wOidqo?=
 =?us-ascii?Q?L0oPO6TMvWvv86UaqKIR5OakAK6EvylX8nChRHSvtuu1U0AqiPGMzd25aWvD?=
 =?us-ascii?Q?i3IKlLE4RrZgksVXsPRKRZK/2HashD/k9Bfhi2FH0y8bFvhAfhDFJdjK8WA+?=
 =?us-ascii?Q?1c136zSkOmUgPiY+hQ2wY4Y6qt63+SZ4oEi89Td9Ksg1RtRwB0PT1PsPMOaE?=
 =?us-ascii?Q?900iHtIem+uzK54iu4MqT6eqXDOWxLnx/OsCNijaJ793oHjoME3sFE5cn/mE?=
 =?us-ascii?Q?t9qWgDmW2grnSJApcKZ2wTK4jjJtUJTIEZl/4+Z9Au4wz8rMgbB9e92BCI3X?=
 =?us-ascii?Q?G4RuUDsTkfSZD5dyC6OH9dYBZR5m/Ify70nDdARtmedO69Hq748/AfsRB5TS?=
 =?us-ascii?Q?ZySByw5G6PqqwUQAmrhBB9gvD8jXPcPpOgHK+M5PdHyfmdnQMuZ7UjG7b3PP?=
 =?us-ascii?Q?AjABwOkcfL1aT0J1v6k7QlWwWejqkcxKXqCbSd/j+1e3HDTMLh2gI90A0k12?=
 =?us-ascii?Q?O0bt50EARi4MFXchdAA4lu8IcyKyWme9s+UcFMXmFtB3XWg3kwSxYrQmB/4p?=
 =?us-ascii?Q?jwFlH5FICjPcvLHuuFjKm/1NjmPs/CsZA3+yKGaN2MsrUCDyYnszY136oa3t?=
 =?us-ascii?Q?6htkgTmqQu0ctyrBurK+QPQHdK4VegKpf7pZnJ3z48Py09BkTUlOTbhzbGrB?=
 =?us-ascii?Q?L0+RQaJlDVXwKtkpTXqnJn+9ME6tbr0Xhu32/XsHuEPu2ZqY9TOP38qZQoph?=
 =?us-ascii?Q?et1X4cPQE1YmDSGvYGRqlHhriW55sLiSqYF9CGx/a2Q+hhmeOlXwtOo/RY+Y?=
 =?us-ascii?Q?vBr7cT4kw8UJgj0OZACj/bDISr3IxwSLeYUl3at43Cawk9rTr7347NONb719?=
 =?us-ascii?Q?DlZoJDVdh9/KTfDveRO6ScC3zmhk78UfCSwXW0CdWxlGCuEmt+TNR4hIxBlQ?=
 =?us-ascii?Q?oaOdo+UDxo08vyuLbOsA6WJdo5LQIFkxF0pTFbyEr9Ixg2SjwRqQQTYxjYS9?=
 =?us-ascii?Q?RhOtfn6PpIG+crM4PjKAXSirY5ANL8ollQOkqR3u9sYSr5qJ11ep7tKRv29+?=
 =?us-ascii?Q?xCLSUM4yCqZJbdw0L8x14tLszE7xTc3UobDxzthwxSmgL6NOOu00uHOZqSuJ?=
 =?us-ascii?Q?C7JYuELrVokB8pxEFNmAz8JS/rcGsm8RktWB7MZPHBXrsiarfZA2alK2aoU3?=
 =?us-ascii?Q?Canl1RVUD5AzCZXI5k62kGnyiXCz063UWaAYdpY/I5wh+9mScJ3dUInZluuM?=
 =?us-ascii?Q?sfyQ7zvb7eIU3hntmXo=3D?=
X-Forefront-Antispam-Report:
	CIP:51.107.2.244;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx2.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(19092799006)(14060799003)(36860700013)(35042699022);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 20:20:06.6040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed907c4-5165-4eaf-91bb-08de0dba9029
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[51.107.2.244];Helo=[mx2.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1068

On Fri, Oct 17, 2025 at 12:38:41PM -0700, Darrick J. Wong wrote:
> On Thu, Oct 16, 2025 at 02:34:18PM -0500, Dave Dykstra wrote:
...
> > > +		err_printf(ff, "%s.\n",
> > > +			   _("read-only device, trying to mount norecovery"));
> > > +		flags &= ~EXT2_FLAG_RW;
> > > +		ff->ro = 1;
> > > +		ff->norecovery = 1;
> > 
> > I don't think it's good to switch to read-only+norecovery even when a
> > read-write mode was requested.  That goes too far.
> 
> The block device cannot be opened for write, so the mount cannot allow
> user programs to write to files, and the fs driver cannot recover the
> journal and it cannot write to the disk.  The only other choice would
> be to fail the mount.

Yes, I think it's better to fail the mount if recovery is needed and it
can't be done.

> norecovery is wrong though.  The kernel fails the mount if the journal
> needs recovery, the block device is ro, and the user didn't specify
> norecovery.

That makes more sense.

> > It also doesn't catch when recovery is needed.
> 
> What specifically do you mean "catch when recovery is needed"?  68 lines
> down from the ext2fs_open2 call is a check for the needsrecovery state,
> followed by recovering the journal.

I meant that it should fail in that case because it can't recover.

> > My proposed patch only reopens read-only
> > when ro was requested and then later checks to see if recovery is needed
> > and if so, errors out.
> 
> Your patch also didn't re-check the feature support after reopening the
> block device, which you dismissed even though that can lead to
> catastrophic behavior.

In this version of the patch there is no reopening, there is only a
switch to open without RW if the RW open fails.  So all feature checks
happen after it.

Dave

