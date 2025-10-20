Return-Path: <linux-ext4+bounces-10982-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5385BF0915
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 12:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63253E8783
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 10:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2876B2FB0AD;
	Mon, 20 Oct 2025 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RXkEiRqM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p0vbpbFX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DA2FB08C;
	Mon, 20 Oct 2025 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956437; cv=fail; b=pe3HXRY3PW6swgO+o86wP0Ip9Do52gLR0CdCs8BniLZOm/gOVX+H6OzTVPbMuRx11iZmGbyNXLqYqIhCwR9PFk8qpYzePwDlI+ABA+6HuwhJ5S+yyWpiGX7w+LoYRkTVnBNAqqfojEI/+f4cCal06ROtch1iiW6oA5DspN3QTeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956437; c=relaxed/simple;
	bh=XCdOADg75A9svfxFMBYcKdbxp2Q7WEXhLdyiKwVSyII=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XMFYFu/9WGgsboJlhevwwsH1uFn5gQ6s8XQRmHUSaaoLzcqYqtvF2ccF5bYyzrCfHaTbKmOtSwdg/I91WFR6CqDbqIYBZ63+LSi7bcnTdBQS+6x3dZC5PgosymK6sYrQBa9ii5CQAJoU2QEAgeiIjj8wu28wTJO2v5D0krk1i1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RXkEiRqM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p0vbpbFX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8SCJo006208;
	Mon, 20 Oct 2025 10:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MjJnsCOyHIJgEs+FOZX/PFH67lXSU68I0PzQ01Oqhdw=; b=
	RXkEiRqMUynWICKF4ISgYiBIvNx1NBmvOU5A5t/WT2T7ndyG9t90JTRnMz8zu6X4
	WEztpAK2LrXHjrMt0G1+ZwzScWwD8xtWEBG4ki8YHA6vcC58BqsBN+PsZeN+E1VY
	yuHl7DIJbCLNlVLaNW6gzXkT8UthS5rF9RKw0RAcd9huiwhqhY43GLl4VYmjVamN
	81oosLUg4DLq5jMYXCpWfxQfnZdgv/WBI0C/3Kljuk7bfP8Gaqmw3T7CsET/I4sP
	ydZZhnOf8q5r3w4leku91zc2omL7OWuxZkZe1FkAihB8UyzVQWvAQ5L2/yvwca9o
	kOdI4atUgUY5sb5R3DOgkw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vvt0nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 10:33:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59K9x6GG009512;
	Mon, 20 Oct 2025 10:33:47 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbt1kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 10:33:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yodp5olH2tLLNUB2jLxLBjPgCLgRYiHd+WQYFjRz7DUdkj27cEXUrcoE76wBssAR8wWZdtAh56trqLAyljEEfUk0Di86tEexUsgvGE7S83qYAUCX8xMnyQ+bB97kECVtARLgQbGkWsqqruqveJ5IbuObwEOgaOU7hxJS9lsoj+L32KFoYznG42+G6qICXfOobHhEhkePvl1qIYHgGS805dAxR8f16SZHugXT3eJNToNYeGrafbda2F1uEQi1rFaq/ZtehKpNlvSvx+dTTsxDFbtXig9QIGu45FXLS1M5Hvk8GTk5YGFEXqZm/tRexTCJhIui4z8VuufdmOgA08mClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjJnsCOyHIJgEs+FOZX/PFH67lXSU68I0PzQ01Oqhdw=;
 b=Sitlw+wL9tFhmFyTw6uw20hYtem2ZAH4hppyz6MdubeHx3hEoXe1O94WmVk9Jy8jQhEKp5jZk82ff0e6bvzw8DNSM7Jblw5CG1PNq4ISuDBGN3OeIpmDinbzTDX7O/6A1qf+oZkLdWgJ9kaVW+mM4wdHyOu+rjJr+ge8QLn29VM1dSMNRcniZi98ANdEApFX8UQOCxOAaZMQtFaIlO7tYZ8GQtx35BoygaVog54rnk4rVSfrM8UJBbhjFE5mphj6gLN62+L8s41O3hpteTDXE/3jwxMQ1+vlyJjLmTGb41wHegTB/ENZWTIkzQVPsJO2CNX2bN8wHEzfSHFcDBEdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjJnsCOyHIJgEs+FOZX/PFH67lXSU68I0PzQ01Oqhdw=;
 b=p0vbpbFXRS1Oyl4wm3J51XJSaCpU9fBkF+wdW3RGv/NRiYelMt6LS1SoekQEZZGBnRrv+iNMt6GaonKijJ6CwAkp3b1ZyYlX6v6zzIV/FztjMTkJ2M5acOFg8+FAzYQaY8Xc1AMXXqgKKlpHTgihDcaeiIj9/P28KdkSn7/hX9A=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS0PR10MB6871.namprd10.prod.outlook.com (2603:10b6:8:134::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 10:33:45 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 10:33:45 +0000
Message-ID: <66470caf-ec35-4f7d-adac-4a1c22a40a3e@oracle.com>
Date: Mon, 20 Oct 2025 11:33:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/12] ltp/fsx.c: Add atomic writes support to fsx
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
 <c3a040b249485b02b569b9269b649d02d721d995.1758264169.git.ojaswin@linux.ibm.com>
 <20250928131924.b472fjxwir7vphsr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aN683ZHUzA5qPVaJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251003171932.pxzaotlafhwqsg5v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOJrNHcQPD7bgnfB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251005153956.zofernclbbva3xt6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOPCAzx0diQy7lFN@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aOPCAzx0diQy7lFN@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::20) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS0PR10MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0f48f5-1ba6-4d02-4be8-08de0fc42506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlVvdlBJSnBSUkJaNkgxSWdLZ3BCOW0wWHBCUm8vay96UDBaNFRzeVdQNDZN?=
 =?utf-8?B?ZFAycUkwM1hiVkIvTFlDM0JVN1BsYjJSR3ErV04xRG8ra3ZaTFFxZXZvbUl0?=
 =?utf-8?B?ZXAyL01qL3NhY2t0RkRGcmYrcVNsakpPemdFMHpHRUhGN3I0eXExQ1JBZ1V6?=
 =?utf-8?B?U0NBcXlEcndlaEVKSjRYV3p6bEVmVnZtTWVZQXZHeER0WTcwQTJKdG45SFJr?=
 =?utf-8?B?K0xvdjBVNCtIclJtYWkwWm9pV25hc21rcFVoNXNaYlFZbHN5WWZCNnRqbGRu?=
 =?utf-8?B?QUtsN1dFeGJFRGJwOUlkZFl1NzRCK2pwOS9RQlQ3OGFkdERLRXFMRU9WUGZT?=
 =?utf-8?B?TlI4NCtqSnZ3RHd5VFpuYUlOeWQySFdCMEY3aE1NYVFGK0ZJWTBKalE4b0Q3?=
 =?utf-8?B?cThQQTFndVRDS1ZhUUlaNGJUZU95WUp4VktVQ2NzMVlKZjl2eUVTTnQ3YkRK?=
 =?utf-8?B?dUtWUTB3ci8vN1o0S2VPdFpabnJqQUltSGJtUVBCdWFxbUN3YmhQcy81aUJn?=
 =?utf-8?B?VWJaTmpGTThqWGM3SHNVcDFlMlNxZEZrTHlxWUkrTkdXcWs3ZW1HejhyZHhW?=
 =?utf-8?B?cVRzcmNVSkhQTDdidzM4U2ZmckhxdFVkbndVUjNvSTJpc2RkcFhwdmtFSVhs?=
 =?utf-8?B?azJ0b1lqN0ltSHh3d0lSdDdHNW1lNkYwbGg2OW1vTUQyVStNVjBuQ2JROXBI?=
 =?utf-8?B?WXlnK0dIZWx4TnNEZkJhenNxRC9JYnZLd0l0b0tKbktRUS80elRlUUpYTlBl?=
 =?utf-8?B?UkxFRFFLNFlHTWhJUndJV0s3RU1jQkpTK0p0OGpvbGU3UkFFb0lzM2tSTzJF?=
 =?utf-8?B?Y29HZzFGT3AwdGFKNEMzMDlDeVhGTDlEUlBNZGMrRHEzTWdHcEpsZmZKMjJH?=
 =?utf-8?B?bTk2WHBXb3ZvdlV3NS9QZS9QWFFzRkRxaGNuenFPbWk5alRtV0hQWUJRdVRE?=
 =?utf-8?B?SDdOcmc3RFlXN1NyclFwcTI4WmJQeUJwVFlKb085cTRaNmFMRDRTSzRjbDRH?=
 =?utf-8?B?Z2V1RjZxQVNranF5eVY4NVVNcUFkZDUyaGxBd2pSL2RDcWNPNndJakJ2NTF4?=
 =?utf-8?B?cHFsdGVwMWlDNitOcURJWG1YSW16ZktXa2JEN2w4QWFuTDVacnpqN1hRN1dz?=
 =?utf-8?B?VDBuQWRnaGNudlBrMEIveWNza0xYMmNDS1FhbVZDRGo1K2tJd1JsMC9LQ3pX?=
 =?utf-8?B?c0JmVHo5L0IvNWQ5cFdwdjJUWEtMTEVMd2QwWUxTQnJDWStmRGR3Q0hoSWht?=
 =?utf-8?B?S2V3bDRqZC8vcStSK0E0alVCWS9rUFR6aVZScENuc29URlRFT3JGeERvL1gr?=
 =?utf-8?B?eThqanpzUCs4M3RxSGFTcktKZXgraTlhTlVvOExtd1dwbEJPRFdTUkJYaStQ?=
 =?utf-8?B?SHFlVHpUeTdya2NiN05VRTRlWDJ3RE1kYW1HampqLzI4N2JoVXdpejZNZXJJ?=
 =?utf-8?B?UVluQXZrcmlhNmMrTk14c1lKeW9IZm1iVDc0TEJRVWw3ZU5qeGc0ekVQLytH?=
 =?utf-8?B?Y3lJMFE0NHI1blJoWDlRK0JuUEt6UUlRU2dYZUdLTDZnMzFFZVV1R0trY3B5?=
 =?utf-8?B?MGdBWjRrL3FNYk1vaWF6Sm9jSXJJYzdwcUpHREJYNUppck0rRzhxNWxiOHp2?=
 =?utf-8?B?T3ZsVkx0QmpFemR6T2JtbzZsMEx6RkJxbFBDd0ZmSGJPVytHOW5URkZZZ2t3?=
 =?utf-8?B?bG5IT05BWU5Ga3g1K2w4cy96RXZkUE5nL0xjc1pBcTNiZ0FKVFduR3JKNVpT?=
 =?utf-8?B?eUFIVTU1SVNISlJOTG9jNlFpUXo2cFlnTCsrVHhEVkg1eXg0d3N5clc5UzRt?=
 =?utf-8?B?SW92cFZRZEMrWERFazg1OVpqL1ZCSEUyeDhZbnlZMW5hMENnZ1ppeEwyOU9L?=
 =?utf-8?B?Z0huZGRyNG1ZTDFQYjRwUURxZHlML21KWFpmbmVoT3pCMkRPdVl5aXY3Nnhj?=
 =?utf-8?Q?5QfYU9ZyZ1cq3jUnnkDut1t5EgZTK0kT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1BCREtabUpReDBFa3NIcnEvQXJUSk5ZNi82SFl2K3Q4RzhQUGFPZEdGblN5?=
 =?utf-8?B?QTB0RkkvMklLNnErRVJXRDdIR3F4RSsyNlIyUWJadEJobHZJczRzWWlsQzFX?=
 =?utf-8?B?a0VoczdqNGZNUE44VDRibHhpbzZJaUc5Y3h4SXYxdHZHL2xZakpLRzZUb3FU?=
 =?utf-8?B?NGdCWXlGRldxWEZaQm5MYW0rdVpWRkZJdGM5OEhmbGw1Nm5LdzVjckxPNVNP?=
 =?utf-8?B?c0NtOElVVXUyUEk3cmZQZ2hKeXdjTXVOa0tyTW5yOGpzRGJzYk4vTHQ2cDNN?=
 =?utf-8?B?T0wvSXg4RUxBb1Nhem9BRzZCV1ZpdDdJUU8zcTRsSjB6UUhjbXRCUmNxQUNN?=
 =?utf-8?B?dXJsZnFtVVl1VlFSQ1MxY0ZhVHBoTXljUGlJZklxMWdSL3NabUpGWWo3ZnJU?=
 =?utf-8?B?dnRVZjZzeWJMYlNlNy9yRk9QT3dJc1JqUytUNXBORmd5NkJSenFnQVMyRGx2?=
 =?utf-8?B?aTVKb0l6NkpEaWVTUFRCOVFrYTQ0Qzl5cXhVZ3M4MmhQME5LZmUvZjJSSk8w?=
 =?utf-8?B?WCtuTFFTQ2RRcXpFQnoyd2EwSFRMUU40NGdiY0VPSWdIS2NuRUFuR2xTRDMv?=
 =?utf-8?B?cCttNG9LOU9KckE5RU40bkpKM2tLVlVsd2EwSndmTGpqWmw4b0ZYd3oybDhD?=
 =?utf-8?B?Z3FEVG1LRHE0dGdRL29WUFFhb3ZpQ3hLRERjRExiMGRwU1UrNVZkcFdSV0Rm?=
 =?utf-8?B?RUZyWE5LMEMvRFlEK3R2N2w5aTgxd3ZkRlkwNDBKQlBOZFR3U0JCUWpaY2w4?=
 =?utf-8?B?OTJYcUxXR0xCeld6WmFINWhyNkVWSzI3bjJPTEJGaVZ6bEsrUGgxVGtmNnBO?=
 =?utf-8?B?TU9IU29ZZWV1N3JJNGhURU5sb3k4bjQydXVLOVZsWGpjbEV0TWVZaGxtUE1E?=
 =?utf-8?B?bllLZkVsV0xwckNVYWlZWHVnYjFBS3Ayd2pWNUVla21HUzh2WUNqbW56WjYv?=
 =?utf-8?B?bk01eTNPTThlRk5HbVRpby9wZlgrWllXU282TExuM3FHZytlUzV3Skd6d2Q3?=
 =?utf-8?B?cCtpUHhHbTdZOHpadWdrb2VSNDJ1SnI5SXNzWWx4RXJPbVZ2QW8rYXZwQVdK?=
 =?utf-8?B?UVI5ekJnSzFlQStjbHVZVlhrSE9jT3NvZmV1THV1NTk4MEx0V1NLMTU1Nmo1?=
 =?utf-8?B?VUdYbUtBZExQd3dhcDhCaUI4VmQyamx6SWlMdWxWTTdXMmdlL3p6VjF5S2cv?=
 =?utf-8?B?TWZmd1ltVFQzSysxWVczWlVpdDlUSVBXZUZTZmNLUGNoRmpYVXhDQ3JiWUtE?=
 =?utf-8?B?QlA2dnVhN2pZWjhIL1RKZnkva1hqVC9kOU9QTkloa1pScE5UMFhJb1ozUU9H?=
 =?utf-8?B?dWQway9EN2JxVDlZV3RRejlXQk9WYlJZZlpqR3piTG5yUDUxdU9aTitGY0x5?=
 =?utf-8?B?ZTcyY2RvYzhCTnN3QUtPWFdHZEdJV3E3Ylk1dGo4VlhLM1p5c25SWGJCSXVv?=
 =?utf-8?B?ZVd3amp4RDdhL0E0SDcxcCtBck0zOHdJUlFnU1d2Q0V4MUNlQjlvbXBNNjNs?=
 =?utf-8?B?NDRxOUlUK1dvUkU0Q0QxU2NpT0c5S3RURW5GNGc4bUxTeUJWV1BzUFVDcEth?=
 =?utf-8?B?cHhWeCtRNUxLeHdMOHl4Znl5YmViTllaeXZjeHhQNmRCeE44Ums4cXFTYTJk?=
 =?utf-8?B?UEgvZ0pOSThEVGx6N1ZNV0JzcXN5dC9mTExHejl5YXhhTmRFNE55ckFQUDJz?=
 =?utf-8?B?ekw1d2pqT1BXYXJCbzBEelpyUDdYaW9GRU5IMzNuRGFYZW80QWxhbC9pK3lL?=
 =?utf-8?B?MXhBRWlyK3paS2p4YkZOVWhhWlo0cEhVbWpabi81d1QyMlpiaW5tU3FMSE51?=
 =?utf-8?B?T2p1RXJSZkxYZGJOOWx5V04vQ0JiZlJQRUJ1cnRHdVlQdG11N3JjdlN4RXJS?=
 =?utf-8?B?TEFXOVZhMkpWN2lKMGtiY1NQOGFXNEV0WmExV3VYSlloT2pReVlkRkdZOTZz?=
 =?utf-8?B?dUhLTzh3TU5HS1YrRkdEVHU3VHBEOWUzczA5MUtINnNPeTAzU1BOVXc0RWpD?=
 =?utf-8?B?UDN5SmY5VW9DRkp0bWxaMlVHU2o5TzkveTVGZkxXelBLWWxvOWtrSlRhRmQ4?=
 =?utf-8?B?MEhyY3JMV25qd3h6NjNnMUx0QVBNWU8xNTJydUxDZE1mZ0l4SmZkTDA3a2da?=
 =?utf-8?B?cW95ZUZGM29XTS9xaDMxOVExL1FVNXR1OXl1VTNLOStXTFNNVWRGZ1c0clBu?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dJurTz+Ziiu46qzyuJCIvijJXMyrn7+RCIM92lkIdv55d/zQJt0LOoz7ATo874pwAjC7DbZ2nNUucFoIMtXdnXd/2ltZyhBGpIW+qjZRNc/3QMt2eLU2Sbkjd2Zv/cznRu/Lr6+GRqQpbeH3rekfzwNOZ7h2TdHgInuTpE5dsQ3YnyfR2y7jmHGC2EBK4Co9O1GLv0Y/Sa1yyMqp13G5Xl7XZcXTYSfOct+LvfoVS3z7MUKzCwdNLYvPz3ZYLHhZYbQwnwLJS5LYkyJVCSiHFeMOrJaNOmg/JLl4amR6Mn4Vpwj687nNw4fkCmhv/mYotpAkPNwuRSDCq/RPw0N5Zieqq3B1+knkYtArQTWBVZUfSgK9pfDBUhHrjxpAjsEY4rI1JCvctnipunoUXkpA7t34UPiHM74nT80+uM+EIVUuvbUDqRYXp/j6S5E4qzxeZu0LSbBII4DWbooKsqckTaQQuqmqY4VYSbSCZSYRD/2sFTk3bQcwBmDNt5aZmtIY97vXcTDeAAxeoIkrbnzCO4CMjh329mDQPFC9MiSUNqRxfqGuRtLCQPhoxeSZYpH41wAwW9u0371EGm3LZOYeuAWjos45KeTbqZA9HbvWpdQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0f48f5-1ba6-4d02-4be8-08de0fc42506
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 10:33:45.2093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INyRusSJahByLGnxTGduf5xXDIVkpshab93cTlrK4dkhDns1h77pP9a1eQPA13Jsz2ZzMnERBn/4qZJiqyAizA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200087
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7hg+HAF50eKn
 zcawK+QO4NafcOe8XF2YSB7O3KjtQffu7emHrjXFg+J00Phs69dP571AcsgHvwMlfPeT1ebwPES
 yhjSG9uySmGKoJUA7JEeEv9OivFtkhccs/HHvWMZgs8jplYsVrfUvBJJuU1ZF6ltFDmLFZD3pAg
 5mNVds5FApJWjR/h1+x4DMh2bUe6kG1Sq3ZtTWpslUHr/dINGqb7Qu7bcLyO2G754MD56APyg9J
 IgiqJiRNcLj14CvAQLtg++aHZ/XCIqDclVJHkDi16AhW30giS8aitQlFLrppEsdRhb/mdLu1DPu
 V10pSgVS8T92nGyseQAFtPMk6tlL09CIcUXsfTuwnnaNb2Z+Z6mr6mZQX4pm9QZuYNnBue8JHZe
 wSCF8tWAhSBslyoPh5E7XJjK6osT+SgVH2hoYMHbrN0VJkaMUUs=
X-Proofpoint-ORIG-GUID: MNvancO-k51kKgIJKOrb6GcJs9x-mHsE
X-Proofpoint-GUID: MNvancO-k51kKgIJKOrb6GcJs9x-mHsE
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68f6100c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3TbbdcnBVfMN12lHCloA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12092

On 06/10/2025 14:20, Ojaswin Mujoo wrote:
> Hi Zorro, thanks for checking this. So correct me if im wrong but I
> understand that you have run this test on an atomic writes enabled
> kernel where the stack also supports atomic writes.
> 
> Looking at the bad data log:
> 
> 	+READ BAD DATA: offset = 0x1c000, size = 0x1803, fname = /mnt/xfstests/test/junk
> 	+OFFSET      GOOD    BAD     RANGE
> 	+0x1c000     0x0000  0xcdcd  0x0
> 	+operation# (mod 256) for the bad data may be 205
> 
> We see that 0x0000 was expected but we got 0xcdcd. Now the operation
> that caused this is indicated to be 205, but looking at that operation:
> 
> +205(205 mod 256): ZERO     0x6dbe6 thru 0x6e6aa	(0xac5 bytes)
> 
> This doesn't even overlap the range that is bad. (0x1c000 to 0x1c00f).
> Infact, it does seem like an unlikely coincidence that the actual data
> in the bad range is 0xcdcd which is something xfs_io -c "pwrite" writes
> to default (fsx writes random data in even offsets and operation num in
> odd).
> 
> I am able to replicate this but only on XFS but not on ext4 (atleast not
> in 20 runs).  I'm trying to better understand if this is a test issue or
> not. Will keep you update.


Hi Ojaswin,

Sorry for the very slow response.

Are you still checking this issue?

To replicate, should I just take latest xfs kernel and run this series 
on top of latest xfstests? Is it 100% reproducible?

Thanks,
John

