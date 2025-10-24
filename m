Return-Path: <linux-ext4+bounces-11048-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA355C07EC2
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Oct 2025 21:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F9C14E9B29
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Oct 2025 19:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192D22BE647;
	Fri, 24 Oct 2025 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rg8l9i1/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pufiz7sf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F42327D77D
	for <linux-ext4@vger.kernel.org>; Fri, 24 Oct 2025 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761334542; cv=fail; b=V0VncNUEZbnqi1B3xxorK1VoFfwoyRWrJaTDmBGF0+GZa6kKl3XM1MhK0zwQMjCv3VtlBYxAfLMkNwjn3YsIfnYWEZwrN97jB9dZvOgiifQHBZzNwZ8yoA7ldJlWCSuVGsi41ioC+Y4iCk99vdOIKwLctEqfp/HfNhdV5n8cOUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761334542; c=relaxed/simple;
	bh=tW9Yc+HK6fZeyGKxrcmwx5he/0Pf665FyBbJiaWAvz8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jG7gdRFlCwGkK/QdvS7ax+cpGmVXss86eGy9MrkXqYHCAEuT8IvW4GEFu90Ro0l4b8UN4m6BBAxxAlq7OrFGApxTzYEj06dK9q2ksXY5hSLPCpuYFeeOB3PlP8TC3yZM0CyocH3PVhqTR3Psa1pg4O/LEkR2shbFZuLUwDqvHK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rg8l9i1/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pufiz7sf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OINCb8019973;
	Fri, 24 Oct 2025 19:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=ooszWJZ1fND/1ZR5
	+IUBJQiAGWTmFvMVaycwgcWCePQ=; b=rg8l9i1/SRmWZfGnKm3rw7cyNvCo/ZjO
	ywCLAcTY7L8cVZuKSOKR7xFOGheXkkisY4AcVQxUYMbJIeyfapYuoqNmNJEChz9I
	3QPzCvJ1c/nOyhEqaocSh7mOU+4nw/+kaWSYXkrVWUlRYDkWmeolVBT19FBEaqY/
	7CQ0GzD/wXhpSovdNRi5d/O5Sg/7HVZJhjjCMByVmq9kxzRCggg3788BePAJy36I
	W2Hz4wrV2zM3QQagfcU9Oy6x8Ir31amcS7gVP36n59krIBkfPlG+0VYHw6K0SmX4
	zLWj8WVt/+R4ujD8Bi9BDyfOEJcD8pfEoiAwhMLMGpPUCVA7HweEyA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ykah38fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 19:35:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59OJU6ig030562;
	Fri, 24 Oct 2025 19:35:37 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011062.outbound.protection.outlook.com [40.93.194.62])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bhcr71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 19:35:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fiuyga7lkZ653AUVkqqjhyfHL8aO78fuu9MXxb09tE6rckhaPGxFNq1E3n/NGav1UXLNm/U878bPD4/PUoV2UBYqRPSZbZcGvP3J+mGpZzKcYWWVrWy1bffuXXl5O8FBcmQ5JL9laSM22/k3IiApJ0+/UNc/ToIUOeS/+53RVK53f57Snz8pNocLt8V4qpdLJLjzs5EoFd5fB+hdIXi2lrMvd/gD04aQPEiCFOtaJmPChUpDJQfRDq+/n5EuJYZd8bD0kc7tqH0rhhXWnD9OjNZoYnDhuMyd/Mp7Pn0nQojYSHqgQZ9FnGFrSRnANUFfOpIToCxF5ogVM8F0mfv6iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooszWJZ1fND/1ZR5+IUBJQiAGWTmFvMVaycwgcWCePQ=;
 b=Umj2ivuN/AbxXkset1d8qoC6qIvM2pDDNso3mZXutNIbiB2bv5ZMWAtRWvtdvEwbFCIkrdv3PppH0art27ittO9YHw8rFT+A95Niit3sBl8dccvPNME5bA+b6iRMfAJNhZ0FQjORXa0z23u/hTX08i73hhkn7t2XXXaRhCJ9NEgTV4C0iZbZfkHOBsTJ+Tg6svogoLRe2Y96T9rXOONXIjNojThPzOI9DqUrLBzJO85hNQ/DCFw2arOpoWpGsU6eTWqNhwMLFUJrxgN0hf7d9cEGRbF7S012U/LllOno53sF+h4vETvf6eBgY7+TZTEUoPoynGrF+ucBpztvhcB1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooszWJZ1fND/1ZR5+IUBJQiAGWTmFvMVaycwgcWCePQ=;
 b=pufiz7sfaejPMLSGrrQLJDkcdjpxPzI/aZ5aBKgk+B5JD6fYbi2wVesTxdBETU05T9NKj55Ep6nZhOQzVEnsPxQSuLPFRaYn0Oq6eka3Isav8Ryy9Syf+4h7OcH3wS60cZrFqoPeIDDApZd7REUamPByX+b2vTZkyHzFnm3vlEs=
Received: from PH0PR10MB5795.namprd10.prod.outlook.com (2603:10b6:510:ff::15)
 by CH0PR10MB5179.namprd10.prod.outlook.com (2603:10b6:610:c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 19:35:34 +0000
Received: from PH0PR10MB5795.namprd10.prod.outlook.com
 ([fe80::69c5:1e7c:5ad:7a27]) by PH0PR10MB5795.namprd10.prod.outlook.com
 ([fe80::69c5:1e7c:5ad:7a27%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 19:35:34 +0000
From: Wengang Wang <wen.gang.wang@oracle.com>
To: linux-ext4@vger.kernel.org
Cc: wen.gang.wang@oracle.com, tytso@mit.edu, adilger.kernel@dilger.ca
Subject: [PATCH] jbd2: store more accurate errno in superblock when possible
Date: Fri, 24 Oct 2025 12:35:32 -0700
Message-ID: <20251024193532.45525-1-wen.gang.wang@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:a03:80::25) To PH0PR10MB5795.namprd10.prod.outlook.com
 (2603:10b6:510:ff::15)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5795:EE_|CH0PR10MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb7dba7-e039-440c-5b82-08de13348036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DMtCNAJ8pIMq5MkvkVi3JC1qQE1klW1daA/r+P7wT0ewh+HndoDhxebkdU0D?=
 =?us-ascii?Q?E4j7jtkD8QATbYo4S7LA3Abf1ngdEPMoc5I0KROqY18Iw7xIOLDEASzvetyG?=
 =?us-ascii?Q?BgSabiGQObFH2mQ6t0u6w69lYtlo0YNecq6qSCpEUkjhWrhA28zSIfpqWULF?=
 =?us-ascii?Q?PThnyif7jRWydF0cbReoj4Si3SVwSdmj7JYuCXSb7HC692bWjX6+wer3YEoA?=
 =?us-ascii?Q?4GNh7fV3eoccS5+gr9pt4dBasQ6hGkUAoD6nW8fvH+GGBQANKuELyIy7wnmX?=
 =?us-ascii?Q?10Lw+1mmiHkL7I9N20m/HtvSkg2RrO1UwlBWeVIGp83EliR8yL8LuucP6Pk4?=
 =?us-ascii?Q?IS0pkzaUDeaiehCtwoOAnQt8EcsGC9N7VMqoUSvp68DB1+1BD69uuzurlHdE?=
 =?us-ascii?Q?I2kaxzl/6JaAwRHh7w93x9weL7+buJ9T9MH2kOcHxN3SZzv5NaP3smNBA35a?=
 =?us-ascii?Q?292LM3B8Xd3BRdaEUo2w+6a3faG5HsMzHmXM5cciTa1PX9QUOXyHHRN0Qkzb?=
 =?us-ascii?Q?7jF9XN5UZFNaUP8EwFP8kuSWUwDXs0Wxjjf09JQnFyEtFU7GDptb9orhax/F?=
 =?us-ascii?Q?Xkv5rs0yR2dl1MHzoD0anag0BFw1uCpVtpRPq5i4SpEH4q4LrNhXqMEzD/fP?=
 =?us-ascii?Q?3nKmFZREHEjt8n5M+smxjjVHuu05zeZvXl7phKJbwwhZtD5709z5K5q//qaB?=
 =?us-ascii?Q?+xzgV1I34hr/01SJUthpMJkbtCWSamE05pMh1qgxSsSjH4UbKtAj7gyMFIla?=
 =?us-ascii?Q?kPXCqhB5QEPpAbKYTdabrXyKNmybUBq728ELK3cy1qAO3m/4onZzAvJ77iZP?=
 =?us-ascii?Q?wyHslWw/1SMUJnYzZNh/FaTa6QcsWitVcxQY1snAuHhvCPjgiMj0sUazNY0O?=
 =?us-ascii?Q?Lflt/3TYW6bVfA7A+tUeTjFN1ew/AfWneYf5uAhM0U1xxRdeh6xMrW+yZXo2?=
 =?us-ascii?Q?LPyw+erALn0fPDNJgm8GMBRShlKSD2I6ErVmTyItN7uPkp/NIRr4ghgWHxC+?=
 =?us-ascii?Q?6BzOvrE68ULjLvKVnJ2C+yBRvget3X0hyb/qxwWSrO9qQ/XU1H6kWWgG+AJj?=
 =?us-ascii?Q?QSP5DTuEGNtYAM6cqPeKfU5QmdVzFN0OJvlS1kYNJ4u0GtvhnzWfrP5NWYXF?=
 =?us-ascii?Q?YEUe0nl7GHWeHlBHYtQd2P9/ZtGH78JhFyY/hJ6UUt7sfV8UakIuUbuFnAoR?=
 =?us-ascii?Q?Xyy6IWf1DK9w4bJeMRm39KbrqO01aYz4xFhPyE+q9LbSjkV2p9PAzUYA3RBP?=
 =?us-ascii?Q?x8gxa2H+rOkiJGWL2pN8i9R5elkCE7sw99UwigKs6WEfRcRCQsclpwwh/33k?=
 =?us-ascii?Q?Nhy5lg2qlUtJwF9y/sLC+XGsfR5W/IqRq4A17kSkr4xWusegIUHpe/lmaEjJ?=
 =?us-ascii?Q?44YCcMYl2uInb98XwDLmYXy2cvkCs50KduqTKqqFnrrZXYQ1pLlL248FCfUk?=
 =?us-ascii?Q?r1eGKn+jetJsPtC1Qjmd1N48pNasJ5FM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5795.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bBDSsQVUUlHEfuEe3stBtk3auUJ6i0eTv/SmJZdN5dre2CLL3YIY2YiS9cCR?=
 =?us-ascii?Q?kjb1eloRsPvhUJiAT4plc32sNEBxw2Dd0dnUgXYVn3FwAKnO0BZdd9aqfRqO?=
 =?us-ascii?Q?rVpdd0XoqxyknVqUE2PLry7cyxoY38U6nq8Oe/lulXk3f79nRFgxnV5IvEzq?=
 =?us-ascii?Q?IRnvZiW0VJnTF1jaVT4zHQkQYp7YmpIOUTG1OsImADAgbnsV5vhkDF0Cp/dS?=
 =?us-ascii?Q?iOKpVyNmwFN0QgsDZuPbBBFZ9p8Kstg2B3axhLRT33qCx7Nw+zdBMt5wM5gS?=
 =?us-ascii?Q?K4rdOBUcKdmnquQJ+CYsjM9YP/cu2w7d6gv9X2gAGtDWCGtA/i4NKaUV2dLZ?=
 =?us-ascii?Q?uRg+sJHN9VianiyKmbY/SVazI/qJoPDpmSvTRPwndzzfr9duibbr3OQPPo42?=
 =?us-ascii?Q?7DydYPmWXJsFhDgkF9O/Y0IuHc4HLsK9Gsqc4gSDxzNShGwwha9roEk1i1xM?=
 =?us-ascii?Q?KQXVwlyu/AzBlDES0PTfv2phl3s10h/n6WaT27M2ccmdW1RYdK6IBLaENt5Q?=
 =?us-ascii?Q?9N11G5w8QiJCaQWQFn6ad3u07pf3jJnK3gu3NiuwmMkulTL41jF6dPmEbDya?=
 =?us-ascii?Q?INL+8Sv8RNEGsGA08+RYf/bUy1or1GwYvJV4Hw68u/9ByWk07010WTJ4FxQ+?=
 =?us-ascii?Q?dV2MAxya5LWqR4abjnwXmlj69ihrjECG0Y2ke59Ek5m2iPQA+KrLv498SvXV?=
 =?us-ascii?Q?I0qMsjcO3KGiOIQkXXqg02P74mYMND8PGtU0fy1JYWKSo39TtwNGOjleFg5p?=
 =?us-ascii?Q?4FkaR6R8dpQrnjUzswahvAa9OyGxr7tjdnq2WPvXp293nZ3UlgRapC1FVKHl?=
 =?us-ascii?Q?1y5lPv5yIYkydS3b59GnO/LUy3kRfyw1ZDjqLcuBJtQp39eFWzGD1h1C6fH+?=
 =?us-ascii?Q?XZmmlUinabDbO3yYClwLw0PcXhcpNhYYGMZXtc3bGxlHp/wDrUW3XS3m1gmO?=
 =?us-ascii?Q?tAdVDh0BNXTzU+C8J4q4XBxLNMZ/rvdPvr5tOn01D4MzF/HZNiFrZYwTiXhT?=
 =?us-ascii?Q?CQxGSEYxDlAfzER17dKKQPFXggM6KYCpXf54C98OxYeJQjNiOUaWD9RXgV5t?=
 =?us-ascii?Q?8ZDxTxFhVCPSgV2Zjls776nfaZsLPeQKRppplKrXgMB5YojH57ZibJY9CVcK?=
 =?us-ascii?Q?0oabFaiUxAteQ4luZSkR4I0YU6+nPT/GybYoeBdvQUURgra5uFi5NHBfqJnu?=
 =?us-ascii?Q?2ME/5aQEYfRLKmn0YDejrseedcO41UdwTYtBPzCxdKw8xBi4apxi1vbeXgfi?=
 =?us-ascii?Q?uQXdodcuqsqvdkuZR97cymO0mrnhs6RCTf+ul8g8x6xOveTgxAFy1rqKckqw?=
 =?us-ascii?Q?I3GL/wmN4fSj3rtCcTDo2Cj0+EMVtxO42O5qot/QA0CBwHIiD3HTNWth86nE?=
 =?us-ascii?Q?EOzh96TZp5S/GZNy8y8d0jWlykgMEGBL1QQIzmTUG64hgS/vd/r9ZB8PpkdL?=
 =?us-ascii?Q?qV0lKun4/leK3XCRp64L/0nFyKREwqH3Re3XYQ5hIhQ5qx5Q/3NmapL+RZAK?=
 =?us-ascii?Q?9S3SHFeefVdcr7hSMc61933bsoRxAUcDdX+QRyle6i0Wgf8iMXW0e1NdzTt3?=
 =?us-ascii?Q?S/YIDx369R/MmJkHoVz9rmuCD/DwoE6bM4jvJ5HBKSKAZ3p18LqFxL1L+ET2?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xnKIhXGfLIqEp78DTS9haAK4IWVxav4qCzYL6urzk3iQcJiVdJaPTgl/9sWZ1HbEHJ6EAQiOA/nAZNvYSiHc+KN+SDyZ6akCo+VzImuRJxJQLMqG1buCf/juMnEG2ZwM6LeStsRMuoT+5PW1Q4rEh23EkY7nwhiQJJ86tSEQ2WKNSE4zScTSNRi5RVrWh9UC5wlL4lkGvlGI2Sd5EeHfwwAk/8cTUWlkRpTnEu6WTR0ORRFw7jdwDnjagCToN75leZF3LJCaPg2bM4IftD45SGzD94c+WB4nlG01UzcU9Q3w/kz0POc55koBPTP+DcVrffJRQcdwHEw09d2tGqzhYz+RwOjB2Ao+NtF210RN6rkU7Q18B5ptwSU/63+dy7PTeNXI60r6lx+sLeJo1sb3SpXmLGuXcG1CSXqQpLZj4kzmU5Zfan8fXgLK2NN2bP6/AFeG2S2C7xOwKfJA+zkzIwb/ungPWdpWVFt4Huqqm9mRGMSpH/0bOFAxDE2wK5UnKZiF/jy/p0XEBuvxoSQVnnjs0/sKrtppstjojCANgi/70DWqZMbOvc84815MpjDwCxJzPuzAnj9yaa21w95E/9KB+6ywHd0L0tdUf3PATWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb7dba7-e039-440c-5b82-08de13348036
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5795.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 19:35:34.4680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vC2gFW/sOGGM3f5yqYW6mFQbikXqZKB8BgS4NCCti6KpSsukiBYMoNFnQKS+ePBKugOifPsGR7rgTfKjVBLoX2t4MbjYzrmjexeltMDIH/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240177
X-Proofpoint-ORIG-GUID: QcldgvU4JmxXhiTdQCFbNGJ9_jF3uF77
X-Authority-Analysis: v=2.4 cv=XJc9iAhE c=1 sm=1 tr=0 ts=68fbd50a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=MSlY4O-fIuqjGdFgB1EA:9 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEwMiBTYWx0ZWRfX9v1qC04UM3vx
 NzCv0jykg2Xl/sJltVGdUJZ6pcyb1nHrHE/3oXYU4VQnrIj8eMeVit9DVMG9O3YJnXItwDym1ET
 rZZ2OSeo5uEo97YJhg5djpokseSftOWIUEkR1Mq1/HgLyBdto6kPqWVB+KIvbcewE79M8cQ+Gbn
 uRk4c6SOGK1GYq8LB0BAm7iNfGDuZzEnbZLuGsIiXlqwkQWS8hdTJ8Sf81Cohf8nF0/iWiL9TvV
 Lr2osoQwoMMaBrXZ/3eTQ+O0WM4vJJw0+uCftUrhrEbp7t48pgIvzrqAjjcdLEAeZ7nF0od5nwM
 dMvRi4ulkOy/GPu1FfP13ZFkEw1BcB2OTZ9/m7IOlHMXlnYpspVlyYMb3dhy4a5uWFEN5B520XC
 k5SDoV6/4zqoa+l3sA3XJOupsaEIgueA3d/30ebA0Q8Q7Vd7HDs=
X-Proofpoint-GUID: QcldgvU4JmxXhiTdQCFbNGJ9_jF3uF77

When jbd2_journal_abort() is called, the provided error code is stored
in the journal superblock. Some existing calls hard-code -EIO even when
the actual failure is not I/O related.

This patch updates those calls to pass more accurate error codes,
allowing the superblock to record the true cause of failure. This helps
improve diagnostics and debugging clarity when analyzing journal aborts.

Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>
---
 fs/ext4/super.c       |  4 ++--
 fs/jbd2/checkpoint.c  |  2 +-
 fs/jbd2/journal.c     | 15 +++++++++------
 fs/jbd2/transaction.c |  5 +++--
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 33e7c08c9529..baf1098cac63 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -698,7 +698,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 		WARN_ON_ONCE(1);
 
 	if (!continue_fs && !ext4_emergency_ro(sb) && journal)
-		jbd2_journal_abort(journal, -EIO);
+		jbd2_journal_abort(journal, error);
 
 	if (!bdev_read_only(sb->s_bdev)) {
 		save_error_info(sb, error, ino, block, func, line);
@@ -5842,7 +5842,7 @@ static int ext4_journal_bmap(journal_t *journal, sector_t *block)
 		ext4_msg(journal->j_inode->i_sb, KERN_CRIT,
 			 "journal bmap failed: block %llu ret %d\n",
 			 *block, ret);
-		jbd2_journal_abort(journal, ret ? ret : -EIO);
+		jbd2_journal_abort(journal, ret ? ret : -EFSCORRUPTED);
 		return ret;
 	}
 	*block = map.m_pblk;
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 2d0719bf6d87..de89c5bef607 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -113,7 +113,7 @@ __releases(&journal->j_state_lock)
 				       "journal space in %s\n", __func__,
 				       journal->j_devname);
 				WARN_ON(1);
-				jbd2_journal_abort(journal, -EIO);
+				jbd2_journal_abort(journal, -ENOSPC);
 			}
 			write_lock(&journal->j_state_lock);
 		} else {
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d480b94117cd..d965dc0b9a59 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -937,8 +937,8 @@ int jbd2_journal_bmap(journal_t *journal, unsigned long blocknr,
 			printk(KERN_ALERT "%s: journal block not found "
 					"at offset %lu on %s\n",
 			       __func__, blocknr, journal->j_devname);
+			jbd2_journal_abort(journal, ret ? ret : -EFSCORRUPTED);
 			err = -EIO;
-			jbd2_journal_abort(journal, err);
 		} else {
 			*retp = block;
 		}
@@ -1858,8 +1858,9 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 
 	if (is_journal_aborted(journal))
 		return -EIO;
-	if (jbd2_check_fs_dev_write_error(journal)) {
-		jbd2_journal_abort(journal, -EIO);
+	ret = jbd2_check_fs_dev_write_error(journal);
+	if (ret) {
+		jbd2_journal_abort(journal, ret);
 		return -EIO;
 	}
 
@@ -2156,9 +2157,11 @@ int jbd2_journal_destroy(journal_t *journal)
 	 * failed to write back to the original location, otherwise the
 	 * filesystem may become inconsistent.
 	 */
-	if (!is_journal_aborted(journal) &&
-	    jbd2_check_fs_dev_write_error(journal))
-		jbd2_journal_abort(journal, -EIO);
+	if (!is_journal_aborted(journal)) {
+		int ret = jbd2_check_fs_dev_write_error(journal);
+		if (ret)
+			jbd2_journal_abort(journal, ret);
+	}
 
 	if (journal->j_sb_buffer) {
 		if (!is_journal_aborted(journal)) {
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 3e510564de6e..44dfaa9e7839 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1219,7 +1219,8 @@ int jbd2_journal_get_write_access(handle_t *handle, struct buffer_head *bh)
 		return -EROFS;
 
 	journal = handle->h_transaction->t_journal;
-	if (jbd2_check_fs_dev_write_error(journal)) {
+	rc = jbd2_check_fs_dev_write_error(journal);
+	if (rc) {
 		/*
 		 * If the fs dev has writeback errors, it may have failed
 		 * to async write out metadata buffers in the background.
@@ -1227,7 +1228,7 @@ int jbd2_journal_get_write_access(handle_t *handle, struct buffer_head *bh)
 		 * it out again, which may lead to on-disk filesystem
 		 * inconsistency. Aborting journal can avoid it happen.
 		 */
-		jbd2_journal_abort(journal, -EIO);
+		jbd2_journal_abort(journal, rc);
 		return -EIO;
 	}
 
-- 
2.50.1 (Apple Git-155)


