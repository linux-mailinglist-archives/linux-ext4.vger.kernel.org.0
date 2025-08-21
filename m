Return-Path: <linux-ext4+bounces-9491-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99938B2F3BE
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 11:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3CF7B625E8
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ECB2EF655;
	Thu, 21 Aug 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m30YpkSk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vHDvhljU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCD52D375D;
	Thu, 21 Aug 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768201; cv=fail; b=pPV/FPyKtdFcAUbtCzTGPHOoNKuWLS46lacSFdcurIOTdmNUAfmw1cnzbMXtrPhCWB5Hq+KGm/0+EUGsV1lOjIQJE43RlC69QPwUeAz3ic3otDhMXLnYB4WVRwDSkpcI7ektvmeYIhy7hIhR6ctTftc0PUD5IF0SOwaIbQRYhiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768201; c=relaxed/simple;
	bh=R08HDuaSb7ralggEwxfhq4d6Y9jb31kF9b2zPdHkd+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fEmBZ4BBEQjyyW2VAR4Be6OGL+u7e2L59qGncQHWQDwFXxb/2Cbvycydnw17iZPrsvU1NKGYg/iG83Cgnz7IdIYUcqHejKlwpDKshR9NREfeGzwkCIOrQuN5Z554bjghBifdsulBkNWIAptI9FPJrE/iP7rmvZ9Nd630r7lFipc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m30YpkSk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vHDvhljU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L8VlEA031457;
	Thu, 21 Aug 2025 09:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Eo/p9IgeSqVGhjooJRaAIQp/g0lqDAhHj9keVTwFesI=; b=
	m30YpkSk9QJfT8hFz0tf0PbqwM+p1VYn6Vsn26lg7T14PBlJn8lt/7JjKAuI5FsX
	bfG671weMJm5mKhKyuzYeFJRbvqtuyBEx9AXt822kVfqp18l/mAWhAp/GHfpolhT
	/Qt4rapaDmm6HaGJe17qopvTq8SU6iEUuHQ7C+tfErVpjE4bfqR4Am0OWGmp3a8V
	fXqJETnBNlSoOzabxHwlOwgH97NzsOMbdUG4mXVBIkx1vAbBMCLsBg66wHNtK4pb
	l9iK98EE04155ArPcyRgM3BvgFyLhU6E1oA2fuQ1+lwmRe3rP7/vRhrzMj6LMnX/
	9fHom9Y5g2FZXEDeyRcIxg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tru3ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 09:23:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9DUKK020719;
	Thu, 21 Aug 2025 09:23:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48nj6fu26m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 09:23:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOTyYDKOKD1bxZ+n/ydkhO9xEK3jEqlgJgnUwvZza23iXyasTW+uZK1URD+pUXf2xxz7tK1V2aAnxSHyNO3/BYvX4KDXg+vInSRsdv1DGBhgWcr9xeFosvLeQ6oOBQE57Ty4iQvIwUI3ZYgcSrDfAGsG/zbXSH84gnS8WZnm+/T3UC2dMj9o8uA9UWwbTuPqUO4YKqmhdcgP1cublW7UOyr4XU4oyzSr1R+Pl3pvABKbU+L7yleRYk9aBUVTTFhe5p9RXc1W4TwrowJxZWJ8t+WfvxknnzSxI3GKeiJ+c5PNDj2zjANXoyZJ9nAn795hQiSoKK8rwADvQ166y3kJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo/p9IgeSqVGhjooJRaAIQp/g0lqDAhHj9keVTwFesI=;
 b=OyeNz112d/jPfxn6UbXNuVKu91WHiIT09pHTVqXdbPoqsuVgD2OWbuRkH+leZdLQH6+YJ7G9C7tU70KUYaDbTGNSuLe/xG8T5/34zr4gCPWRjDEL69Kllh3206QbxYXcd1AeuK0Cy1ztDElnD4pSnD8vY471xFeP92FsC9e+DN1ixTrtMwb+7Qa5GaOJIFJTAj6uco+qJJ6Hl1wH1NnCgpmM2gTFJR9hj3+f4mpsnzoMlZ+PxOV/qvENxORGfdTnLBJNK+3+tBia0WZOO+R0KcJsukgqsuzW7R9zsFEAflFmCpMkinepaYCcGlqjrXVo2MrhOoWWvV9uzVcId8ersw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo/p9IgeSqVGhjooJRaAIQp/g0lqDAhHj9keVTwFesI=;
 b=vHDvhljUpE7u9oSKnBdTIGLuZYXiKBdJVSglBLnH+EQK6rw//Fvs7ZJIekQKeP2QuomCJK3XqnZhu6swSrmKjLgjRNnSMIVvp4W/h9YFQIwlckJoj8lcALZvAIM+gnzlj4v5waVtE8T0gtJvQs24S0zxY5yTrvhKtW9IvFEXWH4=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CO1PR10MB4737.namprd10.prod.outlook.com (2603:10b6:303:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 09:23:06 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 09:23:06 +0000
Message-ID: <eebb6771-a668-430b-939a-ef0d5d966905@oracle.com>
Date: Thu, 21 Aug 2025 10:23:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] ext4: Atomic write test for extent split across
 leaf nodes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <2c241ea2ede39914d29aa59cd06acfc951aed160.1754833177.git.ojaswin@linux.ibm.com>
 <0eb2703b-a862-4a40-b271-6b8bb27b4ad4@oracle.com>
 <aKbX-dBzSC1pmPuh@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aKbX-dBzSC1pmPuh@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0363.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::19) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CO1PR10MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: bfcb1634-252b-4c7d-4e04-08dde09455a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2pxcmJKQitGOGUveDZ0a0xtUC9OYTFPUml6UHQxT2RCWm4rV29HaGVyaEhj?=
 =?utf-8?B?M25NYk9QeTdyOGFOYWJGOEVZNkZqVXZ4TG8zdTdtQTQ1d1hyOVM3YWFzcXJE?=
 =?utf-8?B?M1Yzcjg2SmtoNzBMWUhNZTZsVTBzVFFyVnZwOXhtZXRzYVRCV1RnR1l1WWJW?=
 =?utf-8?B?Rkt1WkdoRnY3a0k1ekxRMFh5QzN1a3BENFd6bml4cGNCRFNoRnIzZy9uYXZl?=
 =?utf-8?B?VVRBNndRRUZGUG5mRnA4RUdvblRVSnprejZOY0pDZCtLL3pyUW5MZS9ueDNU?=
 =?utf-8?B?OW5nRlFtcW9TU01aY0dTZkpnaVg3aHBNWWtiem15NkhaQm9PY1B4WlhWeWtV?=
 =?utf-8?B?ZE5KS3FYd3A4eXBPVE1ySGxuOHBWMmVFUGlZd0hwNWVRdnVOazcwWndyTVln?=
 =?utf-8?B?U0F2T0w1OG4yVFJZKzlMZTdURDJVUHo2bngyc3pDVHp0RmdvYlo1UE1EV1Fp?=
 =?utf-8?B?aEo4a1ZReE1ZaUlBOVluRXlhMTlQRG1IbVF0MUd3Nk1pOC9lb2VZMk82cmg5?=
 =?utf-8?B?OTN5TVloeTVSMkRURGgxbUFITXhRT0EwNXAwVmgxaDFIeUdsNmdKOHZvaUhM?=
 =?utf-8?B?Y2hMVVRTYmpWa2QyWGFuSDNKM2Iyd3VKS2RadytIVWp0bFB3bTZoL2F2S2s4?=
 =?utf-8?B?NjBDYWVVeUxPcEpxdDh3M1JRT3U5NHN0RVgwNjhwOUdYa0FDdkd3YXozN2cy?=
 =?utf-8?B?TUpwY3J1dU11ZEZYMEZlcHo2Qk1MWGlBOS83S3BuZUtmd3MxQkZQN29lQ0NP?=
 =?utf-8?B?bk41eXJpbVZjWTY0dWxBdEd1U0h5a0pUQ3BrMDIyT1JpWTFYaXdZV1kwYzlX?=
 =?utf-8?B?SU1QSElYd09oSHpvWVRPNGZyT20vM2dGY1Y0YWVPMGJwT3dNRGJkS0YwS0Nv?=
 =?utf-8?B?UU0zdTg4UWNBMm1MMGVBVnUwM3ZoeDJlcU4rRXc4TDNtWldlTWk1NWpJbGI5?=
 =?utf-8?B?WElhQVZoQm5pRXgybjkydDFQYWw4WnVxeGF5SnY2ZFVicTZ3dXN3Z2JkMjJv?=
 =?utf-8?B?KzlHa0FUTDNKTGxDVytjSGVvdk82MFR2Tk9pS3N1OEhJQ0g0STJRTzh5Ukdy?=
 =?utf-8?B?dnF5VUpTbnpkalh3U2dMaHBXTFBLT1pQUEovRWZxRXY0dVgvdzZIQUswL3dl?=
 =?utf-8?B?YngxWHBQYXBOcHRuN0ZLYzkrOWpYWlBvRmI3K3JGdllLdFdiN2hpSGlQL2k2?=
 =?utf-8?B?OFVMVW1aSWFOYVhjdUFrdUZNV1c1a1JuRnVHdTJRWE9ob3ZSNXp2MEtSdFg2?=
 =?utf-8?B?a0s0SEt6cFczaWh5RzRGb0gvam9lVWxHcHI5OUFQWEo0OFV1OHhyQm82ZytH?=
 =?utf-8?B?b2YyNi9ScTlYdktPTjY0QVVKVjNIbHFEZXJXajg4K1lmNE1acFdCS08rQ0FG?=
 =?utf-8?B?VDEzOVpkRVk1ZlFtN1duOHpUeFdsU1UyQ0hkalF5TjJzbXFWc0pZd0VjMkxM?=
 =?utf-8?B?SnZHanlMZk05Tzd1a0NTb1J2cVZLdGZyYlNtc1dMdW90cEVVNHFVYlRoeDB0?=
 =?utf-8?B?TmdGYlZkTVZucXFhaUU4a1BCVXNXUmNpTkdEdVpSTG1qeUxqS2pqUEl4c2Nr?=
 =?utf-8?B?bVBTMmo4UXJvUDhSdmRWSE83UXFwcklSVWNQVnM2Vk4wOTB5TkFvVDUrU3ZP?=
 =?utf-8?B?bm0zRFdBaXB2TkVmMFRpa25HOTRsZTNJYm9vbGdWTXVGQ2UzZml1dGJvc21k?=
 =?utf-8?B?czF4NUdBcUxiaUNYQXc3dC93MVFMNFN0OUhGMm9nbFRNM09qRzE0RTBCMDJu?=
 =?utf-8?B?cjlSekxVNi82bkdnTm42SjQzZjh5SDZYa2hpNG83Q0FheU0vcHRHWkgrdUpY?=
 =?utf-8?B?UUZkL3hlOFdqOG9NTnRqekZWdzJGNE9zOWVJM25VUUdsQndoWnhMOWJNclND?=
 =?utf-8?B?L052OUx3ZXRCUFpvaS9lU3VjQk1KaVJiZkJseUtCSnk2VGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RURZWHI1TVViSkVXdmo1N0F3NGxDY2VOMjFqdkpzYmYrU3UweDFIQUovRlJy?=
 =?utf-8?B?dEhNTlFBY05lYzNoMVBwcUJKMjBiYnVoUUszTWp4amJNMllBeFlHYTRadHhI?=
 =?utf-8?B?UzdyMEZFUnRYV2NVd2RWbjg1U292dE9rYWZNZC9qalEyYStmd1h3aUdNdFoy?=
 =?utf-8?B?Q1JNNXR1Yy9TanBTcVZhTS9SSS8veVZicEdEU1ROd1poYWFPUFMzMjJrVEla?=
 =?utf-8?B?SkxZaHRyekhqUGxKcldwRXRZZ1J1R212dFJyTnJTWFV1RkRxcnFCaU5uUmVE?=
 =?utf-8?B?Tm0vQUE5R0hBZW4wU2dHTVMwbHRVcm11dDVONDg1dUpUQjVoU2N0OTh6WXFX?=
 =?utf-8?B?RkNySEVpbkl1bWFlUWhKVnFJR3hhcG9ZYmh5NEhUMFVNSWF3MXhlTnhqc1F0?=
 =?utf-8?B?U2xkWDlid3BkY3lQRkhaTHUzY3Bucmt3RzhndTBjMDZtUFI3SlFLM3NSQ1N6?=
 =?utf-8?B?TXNSYTl5MXpMd2I1bUJUY1NZZGVEQmwxWlprWjVaaGdZaG5lUVRzd1cwZ1Nm?=
 =?utf-8?B?YUZsYi9EYS9yWEh2NC9UREZvSFh0NnRVa3k3VmdNV2lleXpjQ28wUEtMSVFN?=
 =?utf-8?B?SkU4ZGhQRXJ1ZVN6QXF4SFJuVy9LVHJXSnFhd082dGUydmJ3RnFKb3ZoaVpx?=
 =?utf-8?B?dTR6emswanpOay9tbjYzd2ZVMVY1S2E2aGxueUxvYkozaDNDU0ZmR1VsRjYx?=
 =?utf-8?B?MldHbGtJbWk5MnNKOWU5dk5hMW9jQ05idXlBMjZPQWZGaWwvc0c1OXFLSGJV?=
 =?utf-8?B?UXV4RHdtbWV1OVV5MWltSXFJZkVsdnNIY25FSWg2ZmVBZVU3WW5BMGloOE1z?=
 =?utf-8?B?R0JhMDJVdjVjajhDL3R2OHc3L016WC9BWHdFSUlJUUlMUS9vWUJUVGhMdDRC?=
 =?utf-8?B?Q3BTZlN6Q2FSckg1alQ4VEtycXREYUJpQ3BrWTd2Y0o5OEtTZVpiOThEdzBW?=
 =?utf-8?B?dUVDTmd1cUtkc1p4T0l6QjBNWGtOaExITEQ1eEc2ZUF1RTlxTGlZWlRpd2E4?=
 =?utf-8?B?SUNJZTRqeE5LOWYydFZLVy9LM3RmcVY0ajdlU0FFcWdWaWtzOE1lbHBpTlBI?=
 =?utf-8?B?aGNzRGVteXZvQy9ReGl4T3VRaEt3azVRVkRvdlVrM3BIamZZeUFXT2JscWF4?=
 =?utf-8?B?Z1Ixc2hRNlZCMjVhYmZzN2lmMkZLbFdOaE9LMDFudVJpZ21oZDVRUHdEcFgv?=
 =?utf-8?B?NmVHaEtwdlRjekh0c1NLYkhHNG0yWmp0TE9kcVVQSmdBN01MbytDMUtiTU82?=
 =?utf-8?B?NWEzeTlIMkhUb2J2a0tCeUk2ZWZxdmNUZ1grdTRLMm5JTUk4YWJTSi9NL09p?=
 =?utf-8?B?dytjQ0dXU2U3bG1RaFZ6TWhaQjZ1NktIZDRDdVhKVFBiSWhhRiszdG5hMTBq?=
 =?utf-8?B?VTh0Vy9KOUhxZzYwc3pmbW5nOTdiZW9iK3RYZE91MmJxWmlPMEg5bDQrOGNI?=
 =?utf-8?B?RTdkd1NhYjZnU1J5c2FYclZUYmRNM2tZR2VnellvcUdsNURuOG9jUzEvc1gz?=
 =?utf-8?B?MFlpcjdRN1UvRFBJN1cyOHlHRm1qUWNtL1phd2c4WVdMM1lkVExHY3NOQWEv?=
 =?utf-8?B?aldsck5meHFTNjV6M0xtMG1IUkQ5akZuZmNOdDh2cnBEWWdTMWxWckFwSFdK?=
 =?utf-8?B?SUo3QktNdjdhZHNHUkFhZUI4L1lvMTQzT2VCZmJ0Tk92MUc1UFpBcmF0ZDZG?=
 =?utf-8?B?Tm45bjdob2RJR2JET1l3WW1hUVF1Nk55dWtPVkQ1VDJ5WjZTUnFxUFJENzFh?=
 =?utf-8?B?clBhRW9pazcrLytNTTRBTDhyY3FYOWdhSnpVTmpOc05EbTdiWVlBcHU0VjU5?=
 =?utf-8?B?SmJndm93OXFPRnEyZkxnMk9yN3dSUU1tUzdUUlZQVmFJQngzbzFzc0tpcFJh?=
 =?utf-8?B?WTBkT09hZnc5Q0k2YnF2enN2bCt5NFJONDl3M1NHMnJDbzhVUWRKZlIrY1Bv?=
 =?utf-8?B?d2dNL1lGNWlzRVp1RWdyL3ZWVk9rWTZtV2ZSRE9RRm9kZ1NWcDlHUkF1cmE2?=
 =?utf-8?B?WHdHNWp6SFRFNDRpem5VSkFwODdLTHNuU3RNWXlWM3BjNERhY1JDd0ZZR2Rv?=
 =?utf-8?B?NTY5R0dEdHFiUmgwRFB2MnF4QXRqSHVHNHZoS1lTM1NXeEhYMGtvTmhBK050?=
 =?utf-8?B?T09JQlU4Z2hDUVp2UEIyNThSZGd3WjBBV1RIdUtOR1M5dE4xTUFSR1psTjF5?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WihiGLH4ng6Co0Gf+bVf8G9/0HeootSTvKfcjABAzOaJEgaLOSAsJ7yV9+AQCComMObs/72Ixpa2r7YG+E0Xb3tibAUb2Ou+vkmCBN+NjbsA4BVSoyHTjhyTBJycWPi2IukY916E4jDO01ZNcGus7yq9i4yQB2r++W4JzWW/BdIOgxarj4spFTS+AzxdW5tPDrNHq+h0x1gydQiCzTU7jBE54fBHzVw9xnJ/CLMIltMQ/94m9CMQB2RyY59TQiW+jDbEvxLIdQzlDQcMp1ZVkE8qcssVhz2nkPA5SkVS9wvloxjCuGaEd51MVeRfIwxdCz5oMoIlG7TF9CNVU0bGEtoCLvDSNjYIMQtrAgidnqbsp8ZvONMQwsieQpgiOEyqQ8d/YmCwXEGH9+rM1W0FM3IwUKg2dx8MJulY8kXNcl/mGIO4JMicma0Xaxu4kuoKC68Z+B0vpTadqRQpXGdhCsesq78ZaeZYY/yM461VmoLmgaVX1FX1NX+ib3S/MLYZNeZFeE+zXVWGlsF7ZtjcIGqe/cGqvzzPr1wAHzfXfxQnI7gMDwlg1pOffVG/KsyIckjfD5lHF8jYmztCh/rs78H4OWT5OP3HL7gHRMA1ra8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcb1634-252b-4c7d-4e04-08dde09455a8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 09:23:06.0450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzLgIcKvtrGSjk2Ow4I2/JcTh+Y5PDID8+yvIA6uKwfuHARRpZSIrlIhHMbve+r8HNhnYkl/O0gRJW5iCr/RNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=976
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210073
X-Proofpoint-ORIG-GUID: IqfPFKyBvwOQp76Q0bHAwVfLL6xYTkZg
X-Proofpoint-GUID: IqfPFKyBvwOQp76Q0bHAwVfLL6xYTkZg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX5yq/cKg3SIQ8
 s7KmZRFTnF0sV0QEcIE6aFqA8taxpjjrsqodsgUJ3BbYkmBh0sQc/A/4kN6vlcfEZAPDQz9UGhc
 YCHFDX+r0TGnOPoOLeg5cKyEWG1Fk3ir6rZ0wEcXlgWzMaa9EWdnESkUcuC1QIgBcWy5pTIYRp3
 0BAClwJKA4wDq/DtgatmecE/I+BN8Y5wsYWwPgiCEkStSqQ1RlZK91JGttlgd32wcRlyyU3k6W1
 Tr+UCVw20rsOttZP1o/a3IUUpfHdF0hjhMCQPXAEbEDngYmpRV0vaHYwfnAfE+B5v5lozP5AKLp
 CKMFIWCvoEwKEORPKqxRn+Oy2o52ocCd+1s3BoPbWuXLLWWZd/rgF1UJ9EtV+Nxgcv7FNZ6TIe8
 9JHkES8qFqma7iSSsyKC9aFTL/PnfKQcUzWFcJQPun4c6XV1hmU=
X-Authority-Analysis: v=2.4 cv=Qp4HHVyd c=1 sm=1 tr=0 ts=68a6e57d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=thhFOW4h-gHW970KnecA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069

On 21/08/2025 09:25, Ojaswin Mujoo wrote:
> Anyways, yes I've added the $DEBUGFS command so we can observe the
> extent structure, but the filefrag would look something like this (last
> few extents):
> 
>   ...
>   337:      674..     674:      10130..     10130:      1:
>   338:      676..     676:      10132..     10132:      1:
>   339:      678..     678:      10134..     10134:      1:
>   340:      679..     680:      10135..     10136:      2:             last,eof
> 
> Notice that the last 2 extents are logically and physically continuous
> but not merged.

I see, thanks for the example!

