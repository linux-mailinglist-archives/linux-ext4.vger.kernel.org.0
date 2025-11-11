Return-Path: <linux-ext4+bounces-11752-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA069C4C97C
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 10:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B2A1889F7B
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1801E2BE7CD;
	Tue, 11 Nov 2025 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A5fb7PKd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T/8zghS1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC8225B2F4;
	Tue, 11 Nov 2025 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852420; cv=fail; b=N+CX/p7huC5iPhYZkFr/qc1z4SKstqHj2EErjxoacaMw3s/OPuOZ1qwqRaoDiUdadlqv9s1tfpDoIAiwEVQF8NxsfyFjM8vH9vO6zKJFnwo9JZQJRS1GH7yvrbegvxRpuhmyrnsPao2O9o+Ji9KhTV95JRQx2odQz1EsjkYiFv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852420; c=relaxed/simple;
	bh=z30+OJLViAxv4HEfVdN4JsBDgWvGygriCSliJa2JeJo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bZ8ZjHccY5+Rdp6tRZ40fpvDNw82tmpvaH9OKtthPApjuiOC73wAS1SPiMIQHvGs4tkFRWapL4+UxHcrwWhBd+MIBFEWxQsTg/gcG4e3zEiY3h9Hu3t94guJjN9GSp9puQfmdKjFrOEr1sukexCgUIxRKtS2JKGciUn5B4zz0xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A5fb7PKd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T/8zghS1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB8bfP5009753;
	Tue, 11 Nov 2025 09:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zzt5cDqEeQGnqtDvNLTCGEW3vFCPknn2wVQgG3mAFG4=; b=
	A5fb7PKdHl+FE1KfPMHCOD+7GZ6Bb8lcc7OMryULW5QXRNk8kdd3+LV6tT3bh+yQ
	ErAGtGGOWfZReWG01uWUa+G5V1OAKgxo29Ho5YXscNnk0V+TOlkWBY+zdDgOMS6d
	oeozjwrms7zQiELdpQsDyoooSSvaz6A8WBVIlGjU94zFqCSGjYTk4VAr2Bzh8BJF
	gl3qAWdfJV6ZzheD5/Of9x5yDaps0RQDFYT5rcUZpHqwJIxOJrbCyDcT4Vyd04pb
	OcHaiOrqU2TcsPnLAxlte3FxS553rQ5vYSkAjaIb+klg/J+JB5i8/R36jkG5A7hq
	SoPgMkAkfyfsdZ89Hmn2Ww==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ac164g4bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 09:13:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB7FsUo000889;
	Tue, 11 Nov 2025 09:13:33 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vad9kp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 09:13:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKyOoATgy/RRAsF5PsDxDvH/2G7LTSIB4+jwcTT03YlK6ZAEtkXxCV+0C3fJoPd9H2j4h1KOx4MP3Hy8ghVjbcHdBetHsViSWcA5gPybEs8bYSSiT3ekC8QflJQSY59ukKvYCeZSjAwfC3kQfwm6brXyQ2vzqnNr9FNxC7l4q9xxtKry0W9MULufzw3y7T/5U/7DaQYndTNsjMPiTJHjYy0KirVqXXRFWDsd5pCAAQOKl1/WAloqBgqD1YFBk+8SCG2wyYfFTX+UWwGdvMvyHBmhHZuO6T22u+3yNRZOnYx+ba8Nu+/3DfELr8YEs88QK3qF2SLL3yG1pQcMDQ+7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzt5cDqEeQGnqtDvNLTCGEW3vFCPknn2wVQgG3mAFG4=;
 b=dQvRfNA1OunyFALy0TI4dHqEzfIsubgGr5g0aXcxIHUCEIIZuiI+joj8IFf32uYvMg97FnPsmmYtmRxtVIqWwbnlUtYMbL1gi3I6piX8hcEBmeh5rDBayGeA9/D49mlIqGIL+yFbQqKL+Z3cauOIJ9V04Bzy+pPhfrYHo93Q2gkL+Xnls+vIVJpo6IHhsG1QEMOmY8TFnpo+XCfs8eU00Uk+3vFbUvmVBJmW0+R8yYAJDoZRP8EVaJuvaq4GZeoMbq8hoFpm11BEJ9IGnOE6bDimcWmtpLMBIR6hTxX6bLVbOvP5VDzKR7MIYyU7L9VYI58Tm1m6Em/kShrK/scnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzt5cDqEeQGnqtDvNLTCGEW3vFCPknn2wVQgG3mAFG4=;
 b=T/8zghS1f+7PfKUdBnFctA1Rr6RSBVAUyFJs9Xj8TQr0ivaW04RkxpvpWqZtvyAjD4iJVvujbGcPUnyZ+PBQ1nwlcX3IX9xW6CC8Fta0jDhULdNqE6nwE75A6rU79Hnhut40rFobV/0d07Ixjx26O3fx3LEc/mQU7Gom7ZacgTY=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by PH3PPFBE2296547.namprd10.prod.outlook.com (2603:10b6:518:1::7c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 09:13:29 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 09:13:29 +0000
Message-ID: <fce01b4e-928a-48c8-afe2-265e5893c6cf@oracle.com>
Date: Tue, 11 Nov 2025 09:13:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] generic/774: reduce file size
To: "Darrick J. Wong" <djwong@kernel.org>, zlang@redhat.com
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909116.605950.12144124358096086284.stgit@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <176279909116.605950.12144124358096086284.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0661.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::15) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|PH3PPFBE2296547:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5309e0-5823-442e-3e3e-08de210293e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXI5ZXEwVS93ZUx1dXp0cUlvUmdCT3NYTzE4TUh4endBNTkraU9vT0NHbmhY?=
 =?utf-8?B?cTRUaEh1ZjVmK21LYlRIRTBIV1h1c0ViU3VTZlQrdzVMWUZVWHpYK0lJcnNu?=
 =?utf-8?B?ZVN6RUFRYXl4dUVMTjd6Mk5PUzJzUmQ1ZDgxRFJhc2ZWaU13ZUw4cnFMTWFL?=
 =?utf-8?B?VXhyU2o4YkREbXBwM2tsV2pqcHdwb1ZLWTIzaWdNVEt0VWNxYkVBVWtVa2k3?=
 =?utf-8?B?NnYya3lJUHZpTDJaOUVrVm1EbE5SN3JSa01FLy9xYjRPczcyNk5yQXl5RHox?=
 =?utf-8?B?aFZsYnRKR2g1dWp4eitDcm9lYmc3MTlDK1FDc3dsalNnczB0N0hUTzVoM3Qz?=
 =?utf-8?B?SUUxdE9pRy9jcEEzWVcxRUROQU1HY2N4c3prUjdyK0tJemVEY3hBc28vYitt?=
 =?utf-8?B?YUZ3MkZxV3hpR2NuUDRMZW8vU0ZobFlDMGxNV1RScFFBcVJpcDA0V0hicktZ?=
 =?utf-8?B?RGM1bWhaWEhKVE0vMGRCT0Z2MWdYTzROQVpSVHBqb1VGVVRzclNVRUtkRjdW?=
 =?utf-8?B?ZGk3SzlUUk5VVnFadGROaXhrczVYYzA3SjlSZU5zRHQxRGlNdEo2THlZL3Nn?=
 =?utf-8?B?V1N5NEhPUURTWlYxdjdLZTNabDV0aEtnRjduYU9QbkxIbmNITk90ZDNDbk9q?=
 =?utf-8?B?dENMQkpFTXhRK1dFZjRNcE90dGZIL0lUWE1QYkxoclRRU0Y4MVRydWxkdk9w?=
 =?utf-8?B?RndhQzdjZ00valYzV2V1R2ZRQVQyYmlvTzVjditUcUs4WWgxZDJkWmpaRzZB?=
 =?utf-8?B?cmdiWmFZcEdORTRaV3cxYkFlN1dmYXdyNWhFOW1JcWxhOWZqbXRhM2ZwYWlV?=
 =?utf-8?B?dC9Eb1R6cXRrT0hoVjZ1NmdPM0MyV0VUNWc2RlhTK2FqUk5MSFNYOGljbnVq?=
 =?utf-8?B?ZHY5S2FzeWlmK2ZIWGZoa2R4VUxweFNCdkxtLzFQc0YydTRybHcyY2lwUGhu?=
 =?utf-8?B?bHB1bkdtVzA1YnpFenhJc0pwRU53eGswRUY3TnBDOWtpWlFOa3JRcXhQL0J1?=
 =?utf-8?B?SER1bnlvRGhIR3ZtS3YwUTB1THRUZUMrbEZ6RDA4UnpTZDdvRmRrMXBrUnhq?=
 =?utf-8?B?WWpCb3dtTTBIeTA2NmdZT3RBV1hNKzdqS1ltZGExZ3c5UnhVNWU0M2NTOWs2?=
 =?utf-8?B?SDFlNEtpN0dncytiNXVieFJ0TFluOGhQc1hyaXlzNS9nbTNBQTQvL2QzSzBB?=
 =?utf-8?B?L24yU3JUeVdhdVQvTXF1L01lNFd2eUIzb1JJOHVvbU9wTUsrVjFaOWNLZW9Q?=
 =?utf-8?B?ODNVMmt0S2lkTk5CMDJEdFdsZHZSbS9oN09YUUY0U1B0RXkyZ3hnVHBsZFBT?=
 =?utf-8?B?aTZtZndmaGkwbWs5cHlUWFJTYkI2Ri9wb282RWJmOHRaVWRhc3RuVWVQNmdE?=
 =?utf-8?B?NjBNU0VsVVJGMUpBb2diSllsOVJNSFYwcmVIUFFDbGNxSHVWMVJ6OXJlWDRD?=
 =?utf-8?B?ajhZaS9BQTUrKzR5R3RvZTJRd2IybHp4V0VJMW83L2lJYzBSUVhzeGtFNG1L?=
 =?utf-8?B?c0l1UU5FZkM1ZW5yc0FTdFBYWWR0dm16cWgxTVkvazlRaEQ0UGFUeEEvYlJ2?=
 =?utf-8?B?VWMzbE1VbFlhbndlWGhwUW9CQ2xwbDRKb0xrY2JVRFVpb3libnlHM2NHZzRF?=
 =?utf-8?B?bjMyREowcFdqQ3drS3VwUTFPR3FQMU0yaXY2clE5OTZoc2N3cXdjNDMvQUpQ?=
 =?utf-8?B?UjdSenJwK1hEaFBWM2R2bzRkMmV6MGVFR09ENmd4cWFZc1Y3NzZ2cEJERkts?=
 =?utf-8?B?UkRVRHNUT2tZSEsxQ0tHU090Q1FJWktKYW1Wd1gvSWZmQ3lrcUcxMjVGNUZv?=
 =?utf-8?B?NFBHVVZzUnFtdjdQV0lhVmdTblh6MVNMQ0pWRzAxWkVEOWRLQzE1dyt4VEox?=
 =?utf-8?B?aGgyaTJDVnFvRGVKVVBMQkwxUTV5VUU5UkM4czl5cmF5bFN3ditOZGNsd20x?=
 =?utf-8?Q?yaQUZW1/m8S6seHphUbGVHTKjUUNWtFc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amMrVnlqSEU4Yzl2RTZUYTEwb2lHaWlMZC92bkRjUmlKTXJ1c2JDcXIwWXlj?=
 =?utf-8?B?Q2JrbWw2RHhmRnEyMThxd0xMR2Q4K0ZJTTBsR3RadmlvaC9xTnc0bUh4NzJ3?=
 =?utf-8?B?OGpNbnM2Q2xZcjRRcjZVdVpIWG5ONi92V28wNUdvVjAyRGFNRmVhMk9PdjV5?=
 =?utf-8?B?d1BNK3NlNGgxZFpBZk83dzlhOEI0aWJnUmxjZm1IQnBSUHllekt4THRkMnI3?=
 =?utf-8?B?SStjQmdxYkI5VFg0dFg1TzdTQ2tjWE0yVnI2WHZQWlN4RHNIbTZpK0JFYk9r?=
 =?utf-8?B?VlV0M0xwRFNzbzZZa09DcHZIb3kvREhPZ1lQZkZjUUdQS2xwQ1k2VWZobEFm?=
 =?utf-8?B?RGNaVUEvaUFaaDdWaVI2QWU0VE1DaEI2M2tsSzZ6SDR5UmR0TEloMkxEenVk?=
 =?utf-8?B?bkNqTFFXTWNjTkJwSklvaEdLc2NUcnZiMVZRSFVxMHNQS1VQUmMwNlpVS2Fh?=
 =?utf-8?B?dXVSY01tSjFnL2dDWG9BUk5zQVZVcFRiNDhKODBOU2JSUjRCOTFvYTJtNjd0?=
 =?utf-8?B?YXpjRzV1ZFd1ZHFmYU1HV1RMK2x3UGI5V1hkSURRRWtwbVZYOEdTVHBuWG5Q?=
 =?utf-8?B?c0psQUIyZG9Va0NjSnhwdmF5YlRuNElKT3I1Zm1LM2ZVbFZBaVc1Y1UreUpT?=
 =?utf-8?B?aTJTaDJZbUFvTHhWRzFNTXJReE1CWjJYU2wwZ21PNitUZDV1TUdaTlFOMjNu?=
 =?utf-8?B?QmJ5WURGNVdoSVNJSHg4RjVFbzJQRDQra0VOZjVPSGNkdlo5TmIxb0MvOVF6?=
 =?utf-8?B?Q0pralJIY2lkTkdPb1dEcUc0VFljK2tPbVpHV0hxWnFTZllyRW1iTXV2a0hy?=
 =?utf-8?B?cmZkOHlKY3NJWDM3RzN6d3BjN0NYK1VvRVFWOFlIQlluNkhvQng3TmJHUmx0?=
 =?utf-8?B?RnJpMElySmZETnc4Q3c0eUExNW94dTVpb1VTaitydGg3ayswMjBMKy9BWDRE?=
 =?utf-8?B?ZzZYd1NUZEdId0NYS2Y3QlZoYklpQVN5bE83bTNKZjRhd2Q5QXFIRmwrT1RD?=
 =?utf-8?B?eE1DM2JZOE9wYUdpYXM3VHNoTWd1LzViRzZRMzNNSjJtdzQxcFJROHMwNGRG?=
 =?utf-8?B?UjlteTRXWEhXa0N0Q0c5Vk5mWVJWN29VbDFnM3BkbVBUVXNMaXVCVzFoMGxh?=
 =?utf-8?B?WlM1NzRNSVYzeXVQMnBJbkczOVF0WVNKNUp2MXBtZ0FFUWxFMVNCYXl6Yk4y?=
 =?utf-8?B?Z3NISGxUeCthT3Jha2VYdHpoQ1BpdThwY3NjRXhhaElUWUkwelRtd2FUeTFu?=
 =?utf-8?B?NTgydTJzWk9tT0E5ZXhLbUptaThNN3JFVzBTZmhlRWhVRzd3VS9ZeHRISmxF?=
 =?utf-8?B?WFcwU3RSZ1hxQkNDTVFXNnJSNmhMVUgzajVTdE1ydFVHVG9jakU3Qkloa1Yv?=
 =?utf-8?B?MnlVcFIvN29YK2h6aXdQbXcwcW5lUFNxaCs0Yk8rSTVIYVFMbFZ4ZkxZYXNL?=
 =?utf-8?B?WVM4U25neWZSNDNsYWVYc0pFUVpYalE3cEJnUmtvYkdUbUYzTnJESE5BdW1r?=
 =?utf-8?B?QUN3VDVXSUlCWXZOQmFGTjh2L29QVTNQb00wenRTS3BlRmxPMTlWVnNId3ds?=
 =?utf-8?B?N1JjUHBLNHd0M3lvdFhaZ0U5ekNlN3orYzVIODRpZVpSVktmMS9WNXlybTVS?=
 =?utf-8?B?MDNiZEQ2YnNpMFduNXNBWTN6Yk9peXZRTmhLdG9DVHBmdlMwMDFRVjdzVjVT?=
 =?utf-8?B?Qk5NdkJCN044VjNFS0dVb3hOdmhyODRTU0NrN2FEWERLSGxHQ3NsMHAxejFk?=
 =?utf-8?B?c0t3QlNnNFRRUVByYjd6WEhjaldYWDgrTW5yUHNON21Tb2hFZE5vQlc0VW83?=
 =?utf-8?B?Nm1YSEtDSTJwQURYSmloRHFCdkNJSktGUEFLMmlNZ1ZaR0pMVnhhQi9CZzBm?=
 =?utf-8?B?Q0tSWFZXUG1LNnhTUVJWRFI1d0ZGeEFIdW1tRnFiWXRYK1ZzcVlQMG9ydSt4?=
 =?utf-8?B?a1JLQzNiYXhwbDFwMjlSVGJUV2g3NEY2ZUpZZXV3YVhMZHU5d0xlZHdYdkRY?=
 =?utf-8?B?bjB3c1F4SkJnTGp1ZzFaYXVzc2NXeG9vQUZxb2J4ZCtReU10WDduYVFIblpU?=
 =?utf-8?B?RjRzenFTUWRhVnN4L1QvWU5oMVFjSU5qdTZLaS9QQ1ZSSHJhL21IN0tIbmhi?=
 =?utf-8?B?dmtGdlVRNzY1WDErNWtieC9LKzNaQnVRLzNpaHQxSDFtcHc5U0J1a1J4N1FR?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JTcuXNI8X40qyNF4FQh4H+tjlBit3yLhoC4RKwtp+mok0KzAin7ynpl678ljX4xdI3ARfL6Ekadjiik+jX+afpDIBCcqk7OvPaS6I8Ds0OCOYk/E5OyqVBivMsfSZjUe+ID5gricC0sFf0TukYG30LYKU/whW05AvjgakDHWDnktdbmPg7ZBG7F4CU2qkRtNqf/P3syR4qh4bPs7NCwnPSktPX3y02YKrSPpttcTzaS/thyDVneYJQtwhLrKIu89PCmxysdwU5jGY6GGMMJ5ZS+21xxARkfona/cMzgzhXULvQyjDifTCGtr1dnM8sdL8FzwQINsPG3G5b8cyji/y5jcp0sbzt5Tm7xI1H+8RZaR8iT9ZiL9GnMO/4VDmfpcbHqGqHbihJbKgKUrFlDfcvqb6X90JlGaXMlVUo+V6kar33LXhegYaBs2dUOXb87XdEONk+A5eVwNQciXhd4H/hiKsSLIJAuCsufu5RXoLUymIBd5QUTSknLXQCre/Xs4IN6GvT5tgJwOoFpo2Q3hEgauXq8rMWwKHZxcqGUyKoPWrru50M84fCCwDIfV5ePqXDw9zaAYxgamsQZ3QkiMjEOjL/sR8UxlVyer5jQsNfA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5309e0-5823-442e-3e3e-08de210293e1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 09:13:28.9955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7V/RZSgHHRAvlk3mHBYfSzw4tm+sZ0TKb43dj3OQVrUOiwhAReL+Fo83hTHvoM3s231SSMtAWzATPrvNlRCEHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFBE2296547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=729 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511110072
X-Authority-Analysis: v=2.4 cv=Sar6t/Ru c=1 sm=1 tr=0 ts=6912fe3e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=FzDxYMQOQF-4DHx3sykA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13634
X-Proofpoint-GUID: tGprvGMGy7IL0MfKLyLVkuyZ6hh1162b
X-Proofpoint-ORIG-GUID: tGprvGMGy7IL0MfKLyLVkuyZ6hh1162b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA2MSBTYWx0ZWRfX66d3UHwkzove
 4zbXRoR4JWEyN4dvJU+hftieLolqvki0txftB+8TcuqaXDfZfO6S6vqXap35UT8KHkjjOKUuNrE
 ojNcgW8Cxy2Lem+e5oo11edjVSRZPU20b5yvNizW2b5wUJerPWVyaAcVSOgeVc+ofSzw1/2s+Vh
 QXeZqHZ8qJ/XOEXOVxU4jF3M9/jRnlfCj1moj4Dl6Q6+/w7ccNfkIz3BAxCFOgFK6biPzEIH9V8
 rQGAgVCYkieMWUPhSr+9yRL9jDSBQjH20qL0bd2P1EZ4PS1/NmVgzWhKAkvH6Dv1AJFsbslJIG7
 T4rTqbJE3eeCJWriROR74hgwGgqFTNC5uUJWQzENi0KZ4+d6R0aBK+K5zGfNe4QbV2eV9dfN/LX
 5kepUoXoc6KxkiQhF+wfUG0iHgSyauXIpeyV1kTazcANbc/ue/I=

On 10/11/2025 18:27, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> We've gotten complaints about this test taking hours to run and
> producing stall warning on test VMs with a large number of cpu cores.  I
> think this is due to the maximum atomic write unit being very large on
> XFS where we can fall back to a software-based out of place write
> implementation.
> 
> On the victim machine, the atomic write max is 4MB and there are 24
> CPUs.  As a result, aw_bsize to be 1MB, so the file size is
> 1MB * 24 * 2 * 100 == 4.8GB.  I set up a test machine with fast storage
> and 24 CPUs, and the atomic writes poked along at 25MB/s and the total
> runtime was 300s.  On spinning rust those stats will be much worse.
> 
> Let's try backing the file size off by 10x and see if that eases the
> complaints.
> 

The awu max for xfs is still unbounded (so the file size could still be 
huge). For ext4, it is limited by HW constraints - the largest HW awu 
max I heard about is 256KB. How about also limiting awu max to something 
sane, like 1MB?

> Cc: <fstests@vger.kernel.org> # v2025.10.20
> Fixes: 9117fb93b41c38 ("generic: Add atomic write test using fio verify on file mixed mappings")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>   tests/generic/774 |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/tests/generic/774 b/tests/generic/774
> index 7a4d70167f9959..28886ed5b09ff7 100755
> --- a/tests/generic/774
> +++ b/tests/generic/774
> @@ -29,7 +29,7 @@ aw_bsize=$(_max "$awu_min_write" "$((awu_max_write/4))")
>   fsbsize=$(_get_block_size $SCRATCH_MNT)
>   
>   threads=$(_min "$(($(nproc) * 2 * LOAD_FACTOR))" "100")
> -filesize=$((aw_bsize * threads * 100))
> +filesize=$((aw_bsize * threads * 10))
>   depth=$threads
>   aw_io_size=$((filesize / threads))
>   aw_io_inc=$aw_io_size
> 


