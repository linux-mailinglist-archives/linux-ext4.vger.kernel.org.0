Return-Path: <linux-ext4+bounces-6111-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A66FA1196D
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 07:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4FD188737C
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 06:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51FA22E41E;
	Wed, 15 Jan 2025 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="mNtlQqqP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CA929A5
	for <linux-ext4@vger.kernel.org>; Wed, 15 Jan 2025 06:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736921342; cv=fail; b=hSE1oLVYlUgS0XVltXdSY1HxfHty1F+oMCeYJP4LqTQ4SaUPC7D40oh17Z5GYgISyJUNKVqotkuHbhXF+EgTPmdxSAK4hJM2g0CxF6Ab2PkbidMYK5By23vQ1QX+uiZ59xJHaSqsTRuPFdKg5THsjNVDa35ayU+Uct0KyOfNEaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736921342; c=relaxed/simple;
	bh=IMRwSPWHMEHpyyg6Qmt2Awv/yvQPIPrbGykQY0O7bbI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KNLYjuW9g+Vs9mGo5sb7IoH31XfyRVYteCOXOGJnxOmITRvIkm5WHkFO2thcJIY6+t77oQNjLbr7/DrDo8vM2NIXbAktcwJolrCieJ60F8r6faCvDOGSnFbd40UwUvPILIcwYOQdiAX0Px6lGMdmfek4ZfOlRB5oJ/cSmzoIzUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=mNtlQqqP; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42]) by mx-outbound13-145.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 15 Jan 2025 06:08:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7XHdfQrISQMDo04Vq6A6lhFi2EBJHeWrWDWBWkQWlzMn6of4hPjjNk2kYu7TaMPxuFPjE1OIH5f3t6BtW7ib5JrpAGXodZ4j1c1y66bMoXEkrb0TztnGC5pOv4Pz4V3n9p/lQ/g/BS+Vbri949N9KmVOpMniOlO/EedhjzABibW2tf+tDqo0QhbG27QdzzPxwGwkDWcdNhm0qP8oWAE4mBW33nPQgurYPgMimbByGn1HPe8GZ2JcVygHZ7PgWJ7OIHCZh0kSBjxz2A0wAOcBgK5iZysit4AYgS7uNVJSg9ZBjEGf7h2kK78aOOVVKgqsTIelxeh+MzP5lsVH4PUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfAkurxinJWvP//jeNVsgdcbELf+25fmtRSxMLBoVpc=;
 b=XvOMYcnqwpxUEdQun0nsnDMXi3UytAH6T/a4RQCiHkNQwgfyHVghhylEAjeg8JFMlQuOCxObKJR/AK9Uni2MN42xUMJp872qI89ZLtkjb7+SmIhNuUFpSYdL19BrDOUNYqW4O2kEw7sBqxzbdJAkUYIQVsoGgul2fHnVskyHu284ahz/ZTiKK+qY920VwdHKC0HtCLrOMRmQGbBzLLcj/XHyeG4buxfevxQr80iGMcT7GwVvMx4BUjRy0uAwd1iM2N3KSRq/GvYnY3D3SIar9WXTZr0NilB5/RniUzoTrdatjagWM+f2gvwGUXsenY12yUwTh+3mBOYtLdKrUBjtMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfAkurxinJWvP//jeNVsgdcbELf+25fmtRSxMLBoVpc=;
 b=mNtlQqqPl3I0PNCFTo8cOI5HLdoX7cPPp+GIRadVSG2UmWg808hvxw8tRlr4kVZAxn7PGHOvFLLLWhdwRBPHHpq3zNMHgEHvzfuXsf3ga7s8NJ4RDT/ZKYT5YqLWyNLbwuwU+eqdPpcccu1FHF/3HugWFvNCClk0nvMxWv6Q/+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 MN0PR19MB5826.namprd19.prod.outlook.com (2603:10b6:208:379::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 04:36:09 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::5e92:ca89:62d3:f4ef]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::5e92:ca89:62d3:f4ef%7]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 04:36:09 +0000
From: Li Dongyang <dongyangli@ddn.com>
To: linux-ext4@vger.kernel.org
Cc: adilger@dilger.ca
Subject: [PATCH] misc: fix --without-libarchive build failure
Date: Wed, 15 Jan 2025 15:36:05 +1100
Message-ID: <20250115043605.230247-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.48.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P300CA0008.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fb::10) To DS7PR19MB5711.namprd19.prod.outlook.com
 (2603:10b6:8:72::19)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|MN0PR19MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a22318e-e488-4bbc-1ff0-08dd351e21d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3FMMENiSHZ3WEE5K082b252cytGK2pjYlFuY21UcThYRFN1K1NsRy9kMDBI?=
 =?utf-8?B?dGY4dnhpT1M5cnQwUy9Lc3Q2bVlxbTA3TUNJYWpWR0dncGhBWDg2dnExWC8y?=
 =?utf-8?B?c3A1TFRBTkk4UVFsTk12UjYrY1AvN1dtSy94NStyeEc5cisvQ29NZUoza1Nh?=
 =?utf-8?B?akZuWnl0WXV4UjYreHgydWM3NUtmeXl0SThLRDJ5cFphY1VtMnZhTmZTa0dU?=
 =?utf-8?B?WnFvbGpNZ0FCNFFQb25vQ1JKd2Y0eDZFUmFUUkEwbW9Ra1p6NTZBSFluTTIy?=
 =?utf-8?B?UTNGeloySmpUT3pTVHk2OGZVSnE2RE5mM2FzaEZUM3hQYWJPZXpKbzE2Rk5K?=
 =?utf-8?B?TWRkUWllb3lYcHBPNDJTb0FYWlk3MlNhcmM0cVVOSW9ESDVuSXRpWVc0VldD?=
 =?utf-8?B?VElEdk5TV1pvcVdkMlRkS3p3L1ZmdTZVRWQ1dmdrMDMvMml5OVBYc2tPS2RB?=
 =?utf-8?B?VEFNYnZhVDkvWldzZU1TRWFuK0xyaDYyY0VsR2pBT1BOZFBGV0ZKZzFONHJJ?=
 =?utf-8?B?VGZQV2VpL1pLRDBxZXNBZFdmRFlqQnROT2hEUGpNMDFkeVdMWUhodFgxRXo5?=
 =?utf-8?B?aXVpL21wM0puUjZNRndLOHo4STBkU2U3dzJzNE5Nek9XNlZ4dzR1K2ZDdmp0?=
 =?utf-8?B?ZzJVTUh3VmFaNzZHTUxpS29nMVViK3dWREM2YjNDeCs0NGxMVkZYNXpQMHAy?=
 =?utf-8?B?bDlkbmFYOXpPK3FwaDhHQTZHMlUyNmZmcndITjcwd2JxWXQzeW9FaGQvWWlX?=
 =?utf-8?B?amkxTEdRMlh4US9HQmpxbFJreGlaYVlFTHovWlBzK05KM3BHK2RydHBLTzBK?=
 =?utf-8?B?MVo2Y3JGalZnU3doSWgvV1FSdW9TcGlCaFB3MkY1bVNod3QrWnUza1ovSXIy?=
 =?utf-8?B?NkRxSHpERUhmZUdML0N3MXhzTUVkUFNWVllQcFcrMXpnWHJ3OURINGlpNDNy?=
 =?utf-8?B?cFVSaVVpdEFTMytPYjl4TzRXQWUyMkxEV0Y5cENGY3AwV1FKZldNU3JLYnYy?=
 =?utf-8?B?c2YxTmRwbERsSXRzanE4WkpsaDhGWTdDOU8vTG0wNStncDF0Y0Y0SlBLSXR6?=
 =?utf-8?B?RXZwbVRVQUtsT1pQaFFvWGZINDV3dkJkVllYM2NuME1RWkp0YjJTZ0g2RmYz?=
 =?utf-8?B?cVo1bDMybGpkVUtFS25tdkF4dWQ1bWowcDZtZnNVZEpraE5YSXJBVCs0ZE9v?=
 =?utf-8?B?VW82QWRua3g5bWUwenJhRlhKdHQ0YkUvTlhvUGFZcWZFdXFSVXN6UDg1Z09s?=
 =?utf-8?B?NkFrWmJRTWdiYXFuaVlhU1BuSklBSDlyUUhvZ0pGVURWcHlWcUVVdi9oZFRp?=
 =?utf-8?B?VVgwb3dRU2puQ2VXZlRZUjNXMk9lc09iaXpXQ1lwb0xxSmtFRW1YaEt5dUFu?=
 =?utf-8?B?bmlCcmwrZkxTMy94ZlpST1g1RU9rL3FCM3JLRVJTcTJpa3dqQVQvVmpzV3VS?=
 =?utf-8?B?MzdEaHVNOGk0UEFSdXJ5bWZKcVAxTU9aa2p2SSs1d3BLZ2Z0Ly94R2RhUWMw?=
 =?utf-8?B?bDhwaFNmWVRHUTY2Ylc3NDExTUVPUmNLZ2prSHV3MHZBMjFlQ0JTd0hwTlV6?=
 =?utf-8?B?VzhlUERPZklnSTBUcTgrZUhyZzdMR0NDb1UxQ0FnL2RRZ2lVUE9TOVIyODAy?=
 =?utf-8?B?MWpvbFZnWDdzM0t1K0hxNlF6NDF3TkJybDJRcmV1M0gvWjFMVVpTd0ZkQ1ox?=
 =?utf-8?B?V1JkSTdiK2g4dURGTW95TTJnRmVmRWM2SWx6eng2V1dSQnlqTWVUMUU4YnJ0?=
 =?utf-8?B?N1o0WkFXcStJa0JEOGNqakxydVJmWFJTQjNUeHowVDdMT3VrQjlRd0IrRTZP?=
 =?utf-8?B?ZVpwT0Vvc01iRTlIZG5icS9LSmRrODhwN1ZLOXhwY3lmNXlvZkt2KzZDN0ZT?=
 =?utf-8?Q?/7Q3A6I8ylGo4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmp0amVUQ2oyOTJpZlJKa05mVnNYTEJDZ2VpYVBiQnlYdDdnbnM0dS85YS9O?=
 =?utf-8?B?Z2RVS1VxZmlBbEdzWWF0ZCtmNnh3bURIWHY4VGFEMmtJWDVpdFNralQrMEJS?=
 =?utf-8?B?ZEdCTmw1ZEN2cjk4SjZRM1MxMit4bUdMK1cwN3NDdFJEMEkyR3BndFAyVWtF?=
 =?utf-8?B?MWtJSjhxUVdtVnIxdXg3YWFCYTFpVm82aFZxY3ZLRGlSYjE5ZkRsZHE1NXBQ?=
 =?utf-8?B?V2FEOXZUbWl1endWK3I3VzExWWVDcWlQdmc5WGllRzVnbWxkUFdaa09qa0hG?=
 =?utf-8?B?ZjdnK1hjOTRERVpDN1MxbUJzV2hJd0VGcERHVHdoK2xTSVlYbGUxUFpGUWhM?=
 =?utf-8?B?dkxDQjVYT3VkZVhrV1YwQkZ5MkRlREw1MkNVNW1xS1pjaWZZOWZud2J5SEtV?=
 =?utf-8?B?bkxVeU85bk1SWVVtYW1yY2RkTXcvelc0SlZqQ2RPanh3RGZGeFRtc3JTcTJF?=
 =?utf-8?B?cHk4aEFZWG9NTXlFRjRHTmpVQ21DbnJNaDBYNEJIMkNpNHlSZXkwOHMxODNZ?=
 =?utf-8?B?UVlockVSTzdUY1c1eCtic2RsT3g5SjQ1bnFrNlBPZXpEQTRIblhVNEpxZEpT?=
 =?utf-8?B?V0hmcGtmRkc0bFlsdGxCTnhGbW1ETklBbFRrT2RWcjFXTVQrbkg2TG9iSG4r?=
 =?utf-8?B?TXhLUVc1VlEzU2FGWVJ6ZVplSHV3TkNSMWxZT2JIKzc0Nm4xMGFqQkZIYXB3?=
 =?utf-8?B?aVl1UE9VQ2V5Q0NHTmxESkFJSjc5WVFaZ2RPOVRRVmlVQlN1UExzVFB6cTNU?=
 =?utf-8?B?S1ZZKzI0cG5wbzBtRDhndlIxcGhiMy81dWNYZDhoaDZnV2hVeElyNEgyTndn?=
 =?utf-8?B?eWtDZHZBalFZTGhsN0JPQWZqQnR4SUduNU5vdTYwdTlRbi8zZk1Ma1RwNnRk?=
 =?utf-8?B?VFlDUnRNdzAvSXVGQTVwb2pQMVEwVlRjVkxOTFRqOUdHdHRKMmIxVTVYaDRk?=
 =?utf-8?B?VGtkdGtWckd1U0RPSjlKeG5CcFBEYnlQc1hxT1Z4dGJpY1M0dnU3a1RBRnRy?=
 =?utf-8?B?SWtDSWRPLzBtWThmZUZDUnQrZU1oL0J5cEEzbyt3cnBObVByVGZqdWZYMmkx?=
 =?utf-8?B?b1o3b0NSc0ZlWmZaeU1iK2VrVzdGcmc3ekJpSVRlMDZ0OVF4RkpTWXFkZXF6?=
 =?utf-8?B?eDRZM3FhWWlkNkQ3ODQzd3pDeHdUclUzZ3l0aVdTekhmQmsxQ0xiTENxK3d1?=
 =?utf-8?B?UXdZUndRMElCVXI1YlVoUnJaZVJHb2FNVlpmZDZFaXZ0MnhyeHFDMUZIdVBh?=
 =?utf-8?B?SnNzcG5BSDh6U2RTNm9CTkoydGU4ZFAxV0hBZkNOSE5vRnJmVDJJZ3ZFOERD?=
 =?utf-8?B?KytlRWpkRjNidGRNM0pjUWZaVlc5K29OSDV3K3hoK2ZuR2F4T1c3RHJpY2I1?=
 =?utf-8?B?MUtZZWsreTVwQWpXNWdzNXJqV1M5Z3V4ZzV0U3hLZHJJRWlTMmZrNU5FL1Vi?=
 =?utf-8?B?WDZCazIxL1VuSXZnMXJmWWRlSjRsTkdCdGl1dk5GSHFWcWgrSUtTNVV2RHpV?=
 =?utf-8?B?ZnpIdFlHTUhKa1EyMm5NM25wMFZhMEt6ektWR3BHYkdaRjBaYnczYXR4OG5E?=
 =?utf-8?B?V0Y0SUlYZnFWNCtyMm41WE5hVTlpRnRaZVpucnZrOXhzYTRKUGRjQ3dQR2lG?=
 =?utf-8?B?cTVyVldsZU02N0FtMVZHaG8veWtiVUZaUHJGcURtMlBKNXk4ZHlJY0dsYlNv?=
 =?utf-8?B?N3hnSEZmandKSnp6ZUZOQVo5YStQUlgrK1FDV1BibFU5bk9rRVB0UjFDOUpR?=
 =?utf-8?B?K3JpcXJGbDR6UFRCc0ptNlpNZkd2T3NjTHFLMStJdy9hTVNHOHZQZStwK2Fj?=
 =?utf-8?B?cEdYZlNpMnhXcnBnVy9DbTBGSElNUXBQTURsZTJrUmJ0TW5kd3lDTHJqZzhL?=
 =?utf-8?B?TUphWnV3dE41Nm95YnZSWkpEbDZmR280KzN1N1VQaFVESnBxZVlSYUFxcDE3?=
 =?utf-8?B?dWVMTC9pY2c1VEFTbSsrM2dLTEtybXBZL1IxRk8xV0daSERQaUJNKzh4QUZw?=
 =?utf-8?B?MktLSkNxN0ZrTmkzUmJFUGRhOXQ0NDZpTlVMK2N6bkZtSDQzYmI0bkVOaEk0?=
 =?utf-8?B?blJ5R2xadTdCK294enE0NVdpamYyc0VLV3V5Z0ltZ0FWT2VMMGxOQ2hYQnQw?=
 =?utf-8?Q?xKiA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v6C6bKvwtivl0sTuzzC2+wXpEXEkQWrpxbDMy1g7eT7fbqgiU6yGpkRI9ewL5EzFs1iCS2bMj48tHec0AWQtjNscA/kiO1E+C9W6LUowxVFd3EL6asXDGRh0nzzcpxndGgzLXLFH9kIDLoASvkkJ1ch06ECgol6s8rMf89P3iE0D/W2/vLJvJeHlorogblahkPqpZk5WBgF39OU2RaGAb5GW6jAVrbVqWzhnEEj+T1wnVok0hSjr0nm1HVrNr8quEh7IDa8NPC2iO1nTl70mN2rgBYPWwjsS9t9hz3c5HVNJi5n6F9Kcl0kpUj3KVpy52a+f1Tpvxu9nuWVgmPPrW+xKxRak6W+FFvXaTyvbr7RDYD2JJgZNOzgwG3LyKlK+jC7bLkvZyfB3+pP9hQfbfWtWAYzUmGuA2X9Ato07N2KAABJSvzR6G/T1HtBrHLharFdBQM3E2QiVXrxsXicvt6uoeNWBSqWfh6244bT6OqMk8n/O92cNu+O102UxlBaHOei07KgvXmM+GYEbwPoko9x21qbsp3oEOarsi4reqR8JnWElCuUdX7PvJXn4GS1U1k5Bj6/kH3ixYbeFm/DUOu/PkmU/HqUCP+NVJWYMzTn9d5vcZ0Fdg+ncPm1FvjwloLLr0FPZQik1tOCI2XuqZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a22318e-e488-4bbc-1ff0-08dd351e21d0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 04:36:09.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WJ66nHl2H4Qe15YvxFVoJvA1qnfg7omOIMTGMUhDJ8vQWynnQNvWYKH1krBbRww
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5826
X-OriginatorOrg: ddn.com
X-BESS-ID: 1736921332-103473-5102-219-1
X-BESS-VER: 2019.1_20250113.2139
X-BESS-Apparent-Source-IP: 104.47.56.42
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbmRiZAVgZQ0NIoySLV1DTNwC
	AtNdnMwCjN0MDQMMXQxMQy2TTRyDhVqTYWAP7KrVBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261819 [from 
	cloudscan14-139.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

configure --without-libarchive triggers the error:

./../misc/create_inode_libarchive.c: In function ‘__populate_fs_from_tar’:
./../misc/create_inode_libarchive.c:25:34: error: parameter name omitted
 errcode_t __populate_fs_from_tar(ext2_filsys, ext2_ino_t, const char *,
                                  ^~~~~~~~~~~
./../misc/create_inode_libarchive.c:25:47: error: parameter name omitted
 errcode_t __populate_fs_from_tar(ext2_filsys, ext2_ino_t, const char *,
                                               ^~~~~~~~~~
./../misc/create_inode_libarchive.c:25:59: error: parameter name omitted
 errcode_t __populate_fs_from_tar(ext2_filsys, ext2_ino_t, const char *,
                                                           ^~~~~~~~~~~~
./../misc/create_inode_libarchive.c:26:34: error: parameter name omitted
                                  ext2_ino_t, struct hdlinks_s *,
                                  ^~~~~~~~~~
./../misc/create_inode_libarchive.c:26:46: error: parameter name omitted
                                  ext2_ino_t, struct hdlinks_s *,
                                              ^~~~~~~~~~~~~~~~~~
./../misc/create_inode_libarchive.c:27:34: error: parameter name omitted
                                  struct file_info *,
                                  ^~~~~~~~~~~~~~~~~~
./../misc/create_inode_libarchive.c:28:34: error: parameter name omitted
                                  struct fs_ops_callbacks *) {
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: ecfd4dd1217a ("Decouple --without-libarchive and HAVE_ARCHIVE_H")

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 misc/create_inode_libarchive.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/misc/create_inode_libarchive.c b/misc/create_inode_libarchive.c
index 9c8e53e46..f89ac1e4c 100644
--- a/misc/create_inode_libarchive.c
+++ b/misc/create_inode_libarchive.c
@@ -22,10 +22,11 @@
 
 /* If ./configure was run with --without-libarchive, then only
  * __populate_fs_from_tar() remains in this file and will return an error. */
-errcode_t __populate_fs_from_tar(ext2_filsys, ext2_ino_t, const char *,
-                                 ext2_ino_t, struct hdlinks_s *,
-                                 struct file_info *,
-                                 struct fs_ops_callbacks *) {
+errcode_t __populate_fs_from_tar(ext2_filsys fs, ext2_ino_t root_ino,
+				 const char *source_tar, ext2_ino_t root,
+				 struct hdlinks_s *hdlinks,
+				 struct file_info *target,
+				 struct fs_ops_callbacks *fs_callbacks) {
   com_err(__func__, 0,
           _("you need to compile e2fsprogs without --without-libarchive"
             "be able to process tarballs"));
-- 
2.48.0


