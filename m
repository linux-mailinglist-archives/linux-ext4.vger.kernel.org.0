Return-Path: <linux-ext4+bounces-10041-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34321B57C71
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 15:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAEC3A9634
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5817030EF64;
	Mon, 15 Sep 2025 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gvrweRQG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YueiVkQ+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653FF2F99B5;
	Mon, 15 Sep 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941895; cv=fail; b=CKPOGSP3PEsDIElbC4qRhyIFF+4KLyaRU1W5lcWkDOEDzZfQwUsN2N2SweFT1VsPAqa3WADKXlWYWwLYmrhNNsoBoYifkVFhSwE1pCaCa+1L7vHGVgU7geaU8WdCIJPtETXRww/CknY/PFIGZQdnxz91UJT0yO6P33B5AE+4qfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941895; c=relaxed/simple;
	bh=pK9oXFFtINRjbqVrjOQYq78BGSPeIf6wVxNrj3KnaJ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P+Dy6n/LNVgAqgkQwOqzpyqNpP4AnQ27cC6e+mmbDa3sGncOqOtUqcHzDT7d34uwAViQs8lSNzPqUi7tKXcwln9KDoRWPSeaOsgPflZfLIiFjqF4DekXxBkhBRrHet3bL96Wt+WtcahOgd3rx7rTAtgn3+2i9VqJ8cILaHQxM1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gvrweRQG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YueiVkQ+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FD2D3t026775;
	Mon, 15 Sep 2025 13:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vt9eYY1U/0zjUN9aNfjuRbkhjbzmI8ToYXP2rH3OH9s=; b=
	gvrweRQGB9XsOObuo/dTtXB0B4Eo6rcujgL6UQ4in29QRaHlM6s9sAR8pG3aZkfc
	3LxdJ1MqsA5GBY61xTlP4oVKIuiUG7lONmjrlju0TT9ai7/+Mdy4vlbku5yVQjsM
	xRe9b+RHWAy3mf1mdmbdRl6oPMiFHMj7rawDGOq1SlcK9YufeQu4pSFvsuws7P3v
	PnPtC5mJJh5EHI/uZSdFUfwY+K0+6AtYhmZoIG7wZHxc6kSPEoguwdiv+6n9QAcl
	BZmWZylaCGtoD6j1T+GeU4iCZehMf9igVEhB8qavGKCQuWybLhrAzbv4Tk/ZnIhG
	ecCYkAJDNcs14vCaQerkNw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950gbjawj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 13:11:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FC1Ni3015229;
	Mon, 15 Sep 2025 13:11:19 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2h9uus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 13:11:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMnunjRhJK18VA9v+yBcEK524DtDjHpc4T573LlXLIecj33jR/ZzCfRCM9q8NtmveyOF8jFX04onPQtJT8z6sCNNnxCF9jty/mBAD3DQPrsGTt/YCzmPLgYo+Fp3jX3mEUVOGNxpO9Fm2j9jZRXYpqYrI1C/lB/YfpMhb83kjpV7g5hXnMfGsbTtP7KblZluW7A/sHutSdsq3qYTJYFFQbfYwlh3Jy71y0Hhp8pvSpZckllI+DwrZKr/p6JxkWO8kTIY4Os9ZjDXpa/cGN4QZkm5GXsGitmIfqCNsgDv3FXnzjWj58M5Vs7+d3ZLAJpUvgVyejwAybsWHUamIesKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vt9eYY1U/0zjUN9aNfjuRbkhjbzmI8ToYXP2rH3OH9s=;
 b=wEbLJBWjZTNQEzVzzkDjoH7LD5P3iUYIBbHTJpu8H9tYT0DRSLPYtLeY/+OkLQ60K2b3RXUNskEDyBTtKcK3jlcmcm8kFfVuycIAeKtwDB4POKvdyVG/Uv15NNZCJr9LRIsh3AGBh/0RJHaWd8Y6ba1md8zN8IvkWDhNDB3oZtrx8x/xtCAFrbKUDJZuXSBDoIL2JQT9+JwTozfhAC2Rg7IcLH6gKB33PdVBxrR3uvbQsil3uqdsBLhtzYGj8DGkCRAS+lzyKkXEcZZrD0ARt1qtQf+R5baPQtQl0aOTg8nbcfQoM3EoKMWhkHTqgmOj2cdg2UffWixjQ/iLYR646w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt9eYY1U/0zjUN9aNfjuRbkhjbzmI8ToYXP2rH3OH9s=;
 b=YueiVkQ+SXVk+o/w6uZ0huljuni7q1/cD1TPbbKNqDqOli7mkgcYUKWl9MkoaxPb+UMrb6GsU7ZMXQL4q5HLGavCdaEUDFEU1YZKpt92RPQXPFNGoAFosAebRoQmi/Gn7XFuSd0k4sPRh/xGJCmGGkz663biWvaoYG5xXCH/amQ=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by PH3PPFAEC321F49.namprd10.prod.outlook.com (2603:10b6:518:1::7be) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 13:11:15 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 13:11:14 +0000
Message-ID: <4ccbd7de-29cf-4930-a781-be7a062a4385@oracle.com>
Date: Mon, 15 Sep 2025 14:11:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/12] common/rc: Add fio atomic write helpers
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1757610403.git.ojaswin@linux.ibm.com>
 <c940c2d672d963cc7775df082e9ce6894905f92d.1757610403.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c940c2d672d963cc7775df082e9ce6894905f92d.1757610403.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0276.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::24) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|PH3PPFAEC321F49:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e324ce8-218f-4062-2638-08ddf459597b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkdQUjdwVGhwSStobnJ2ZFd5K3JlZlBUSUpqQzZzZmF1REFDb2dNYXAwSGM2?=
 =?utf-8?B?REJ6M016ZWhpaTlPQjRYZ28zemRHdUlpSDcyK0xkYnd1YzlqQVF5bDR6NEN4?=
 =?utf-8?B?NkRxWG1XeEVjem1iZU1sK1k3Z2I1REJCbVEyQUVBTU5WTGs2QW1aSkU2eW01?=
 =?utf-8?B?Z2wyZlg2T0ozRnlqTk5lQkdydklvcHljaWRMN1BFZ1p6bjVYL1JUMm1IVjNv?=
 =?utf-8?B?eEt2K2M4WjlJRnR0bGVqUDFMM2VWYzV3MlFIa3RnNWJEekdvYllnU3pRdEhi?=
 =?utf-8?B?M2VVVllBdG9VaG1OY24rdm85NUZPeHpaOURDMm1WS25FSWVLWERXS1YzOENN?=
 =?utf-8?B?RDcrd2E4T3owcGtjVnNHUllDU2lYNHc0ZWk0alprSFlFVHVFQ1VMOEx2TUhy?=
 =?utf-8?B?QlhwY3RMVjdiSjUyS3FOVnZ0aHNEU0o1VDc1T0pUbGZQQXdnZXVOYnkrT3Vo?=
 =?utf-8?B?bG1xU2NyeG5kZGtiQ1RMbDhvRVdDMU5Ud1ZEbFVTQ3B0MEY3Y1FtZEptYWo3?=
 =?utf-8?B?cERmVkcyU09aWjFjM1daaW5TeFFRYW52aWdWWjJKVVd0MW1Yd3hqMExWamhq?=
 =?utf-8?B?ZGNkcFVKM3REVHIyQXRoZkFBcFBHdmtOdGloVGs1SlRTUFlPaXRUQTkvaUdM?=
 =?utf-8?B?THAwb05WRVJDWlNuS2g3UGY1Y2F5OEw0M1FCSjZ5Z3p5a0xEeEw1RVFoamgx?=
 =?utf-8?B?bWtCdGZLWkYwTkZsbzA2enMrMmJ3WTNXRVR4OUM0OFVUQWFlYlZPM3NpNjBk?=
 =?utf-8?B?UzJBa3JqbTVzNldnOVBzTytqMm42UDJVWktaTXVmdG1ySk9HaVRIK1IwWnF6?=
 =?utf-8?B?Umt3V0Q2aWhYeXREYWFoVGVoSlNXd292UEUzaVV4b2hwMDhEbFRrQ2pmaHBq?=
 =?utf-8?B?YjRBTnNwU1NhcVVZcityb2hYYjl5aVNvMElNMEJ2N05jR3d4c1NlS0xHelRo?=
 =?utf-8?B?bDdpNjJqN0RyUy9xYy95V3JySWVuN0tGV2l2YWJydUp0aEpOUlQyRVJ4SkNP?=
 =?utf-8?B?bUV6ZmY5TTVRVFZlK0pPTjRtVmtBbm1SN29YWFc2aXRRSFZsVlRsaGdFNnFG?=
 =?utf-8?B?MG9QMjlWUkk0bmlEL3VRZ3NUNnJJV0tQbllLbGZPQU5NblFvVVMzS0xJSzVi?=
 =?utf-8?B?MkNPejg2RnE4Tmp6elhVb1NYdUkzcGlnU3J2WXpkYXk3UGpvV3pWK1FXSXdZ?=
 =?utf-8?B?ZFNaeXlUTWI2MFFPdk5pZU1iTjVLVXVsTEJTa0o2SjRjWmErUzhTS2hONFVL?=
 =?utf-8?B?eWZUK1pZVHNPWmlaNHhBRjQ5SVl1RWtLSGR3cjNaSkpxS2U2elRvM25wTkhm?=
 =?utf-8?B?TlhQdTlMMTRZWTV4UEYrcHRHQ04zbDBadmI5MDhEK0ZLUlZzcGZKa240RXdL?=
 =?utf-8?B?QjJLNm85M0lyM0NLRGJLRlNBbGk5MVo1NTcwUEpabGRIUi9IUzd3djh2eG1Z?=
 =?utf-8?B?TlJzQ0xaYW1sZC9HL2J1d1BRQmh1MUlHWUx4RzhUMWVPcUlwTWVVSTdhejVs?=
 =?utf-8?B?OGRWc1pTVDVsY3RoKzQ2WlJrTk9LS1REWThDSEsyRlFrN2NRWXJxZloxZVNv?=
 =?utf-8?B?aGc3RDVMbCt4QVBwT3hyY2tUZFdzbHRkN1ZHaHA2QVhVblQwanlYb01wVDhy?=
 =?utf-8?B?TEVHOWlEWTNWZGhBWk1GNndHZEZ6SWR4NFYrM0V3NWJvQmlFZ01qRjN5YzZ3?=
 =?utf-8?B?QlJCQ1pIczBOSXJNMU9Lc054NGhaYTF5eXJBTjM1ZlA4TFl0aDNoM005amNX?=
 =?utf-8?B?NERYRU5RMjlaYmpzNEI3QTZyVStFdmhEZ1JiQVJtTzJOZUhVWE1vTVhXT0o0?=
 =?utf-8?B?cVV5WkJ4anl2NkVvbjlhN1RZRjU1K0hIaWhrK3RySHlCdmJoQ21rMDJkcUxD?=
 =?utf-8?B?dW1lS1BVQmluK2NFdnRLUTJINlZPaHlHbW16UUw5YTZpWVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHRLQTdCV3M3RldMNVhEMEVPbThUQXRyVFNlcDFmc09Kd21YZi9LSVdTVGMv?=
 =?utf-8?B?TmRCUkxqcjNITDhua1FreWhyNmxlZzY2di8wdFdCSmkrNlVOcmlheUkvUXhQ?=
 =?utf-8?B?bHcrZFlNengrS0orN0NmRVA5SzluVmxrV0h5WUdCbTlHL0M3VHppNHRXZHJi?=
 =?utf-8?B?Sy9RRFZvNmV6SHVpd2tiaGMxbG03R1VialhmTFpMbmNucVI3a3VmaTd2aDNw?=
 =?utf-8?B?QjRTWno4QTF4OXBaNDdsYnBwVGhZM01XNU1oVXNKZmttVTIrZVVCc0hwcGpF?=
 =?utf-8?B?RkxpWmZhNmoxTmdZd2t4UGZCNGlNdGxqQldOdnUzV1ZEL2xZREExRkdZajcz?=
 =?utf-8?B?b3ArK0l2UmZzUmtMVUNEdzBOYlhKUTdtaDZpRG9FTWpYbVYrMHlwSDhFbFkw?=
 =?utf-8?B?TDE1TXVZTGNWNnVFRllWYVdCcTR1RC9RczdLUUZYU0N2VDYxOGFNODdJemhQ?=
 =?utf-8?B?VUxSeHVuYkpWSEhVMGtYNjZCNnZlV1hGTnJoMlBzMTRrQzF1bFFzU01DZElC?=
 =?utf-8?B?b1dFendQbUNBN2J3c1BkTWFKL0J6VHpLYno5TXFSUGh5anp4OGMvbUtuSnB4?=
 =?utf-8?B?blZrT1BrYU42OVB5dVc5L1dGVDd2N0xtSC95aytGL01oTksza3gyc05OQlF3?=
 =?utf-8?B?eE9SbU1hZHZqYXVBQlhqL3dwbVZXTW5FM0FaMFZ1UTBQTGpZOHJlaTJHcWc2?=
 =?utf-8?B?Uk54Ykd0dFFUS2lqREVWSlc3aTY4ZDNLdXJaQmtaUXhEb0drNktQeEhBTEE5?=
 =?utf-8?B?YVFLMW1GUk9laWFYbTNxM2lHU0N2dG80V0syVmdVL2lYV3IzbVJReWxHS080?=
 =?utf-8?B?ZS9VMmNLaTVZdzROS0ZXaFc0amw5L2FMWDBGTXdZa1ZVUXJweWo5aW1oQ3Zz?=
 =?utf-8?B?SFhiWUc3akh0UkZSRUdaUDAzaVhhZFZUa0REcm40aDJpWEFtak9XTlVYN3Mw?=
 =?utf-8?B?bExrQXVTQ3ROb3p4T0p4WTRBZ1NTcXRxOHZTc1prRTlYa2NkS0t1Nm5qM0tT?=
 =?utf-8?B?OWN1aTF6MWV5OFdkMDZHWnYyV1VkdGpXcGZxaUtaTWlwUWozV0NiNlZJN0xm?=
 =?utf-8?B?a3QvRUo0K1NPZVZqZUw0S2RXdzFrNUw5UmR6aW5MdGM3MVdvZkxhR2ljWkNj?=
 =?utf-8?B?bndFSG9CSytMcEo1c2o1Tm9LNnNsV25ET1VaMFh5aDAvQmlXeVlWdExBbm9r?=
 =?utf-8?B?SGdFTVdXVjR3SGdkblQxeVYyS1dydVBjNVV5bWw0ZFlWZlRMUSt1RjJubzJw?=
 =?utf-8?B?Y2JjbmVMTFlMMkNRV1VQcmRiRTBNN2grRTZzdW5xMUtqUm4wYVc4UnRUdmJO?=
 =?utf-8?B?ejMzQm9lNXQ3UTR2ai9uN01hMGJIQlBkUFIya1U4Vk1EVUl0R3VvRCt0S25y?=
 =?utf-8?B?NFgyWVMxSlRGbnc4UVBzNHB1SmE5ZXo3cU1YZ1RVWjRJVjBSeWdIbWkyKzlK?=
 =?utf-8?B?RDZRWWcySzFicmRrZis5enRKbU8ydDhpQUpGM1B6R0thRHVXWXRERWRONHpk?=
 =?utf-8?B?Mi90TGhKSFM2WnZQL0dBdkZaei9VZnJ5dlJtaUFxNURGcE5NM2dZallKR1d3?=
 =?utf-8?B?Vmx1cjhOYmcyamRibndSNkdGSHU4Y3EwQlhvQ29kOTZJVDNGL1phTWd4c0li?=
 =?utf-8?B?OUdVdWNzV0tKR0x6cngxR0M2dGxrSkRoMktNd1MrOFFHOUw5UkR4R0tWK3c2?=
 =?utf-8?B?T0czdFE5UElUM1Zta25tdkdjN3V6citJMXRNdnYveDYzQU5DVm9IMVRxTC9D?=
 =?utf-8?B?dXhlNm5nWkJFNFJzVUpXdnh0ODFBS2pwZzd6TnB4aG9LU25nNk5kZkZjdXNk?=
 =?utf-8?B?SzBQZ0pDd3hQcTRyVjBjTEh1QVRPVUFGL2Z3MXpJR1hzUEFZclRsbWE1V29q?=
 =?utf-8?B?eGpYSnZxb2ZDZ0g4UzlXMGgzNWduZExwQlBPaVk4WkxVZGFVUmRpVGVYYXNy?=
 =?utf-8?B?ZFRXM0xPYkx1SHl5NFdZT01hb09nNllma0k4QS9Cazg1alBsTSt6WnFUYzh3?=
 =?utf-8?B?R0RwdURLcEZaZXN4YmN6dHRMSEJSSjdHODBadWp6SVFzK04wek5NMnZ5Y0N3?=
 =?utf-8?B?OWxFc1BoZkh2cFpRSUN1eGl2RzRXNjNaZ2Q0UFh6MzY4L2xvMnlzeGVXc3NZ?=
 =?utf-8?B?WUUwOGU0N01TOFZWcWd1N2IxS0h2VTYrK0FvODdrdDJ4cXJDd0NKUWNCS3E0?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8HaSEWzucDXisKIysiFODG79cr+Lsse0geDZSX5j5rsW0ZgitSV6jA9SMiF9fQHCTGm6NRFH9u26U6+0VnsrPkNxbwaw09YojZ6HKjFJd2vEhBsFzAVDbcy/KAjTBFoL73hv/mcRdHuiAkS2WugzKkxdXc1QJvhbNLAjand1iohvzU1zMiCCWyM/gS8AA/WoNL2I7O04zf5IO/QTHjlThVMuVVIMB339KBaZq5tdy4ss9dBgJKkIIJsgCpPXnaDmrc0hZPDbk5I9iAaEALkx0kNIHXK3YRzx6dwrUJe1HJgQ4xbkDSRwEyMwAlklZKCaRNRi5rnAkV1dVTfYEXUVObiKlnEmjPCzptQ47ywAAh1ccBFYHbyehAEdL8XWC9tjhjeAK41FYrqX1Nr/71gLXrwMi7ErWwjj0QBkbxyx/FrYiA1AZ+G/PyXYeri4978I6LCfw3vdEpRUrz94Cr3wOQYQZVuCe2cY1zX4zdnKhHOTJlVXYUNXb87TTvXd1Li8sVdqVuW7rX5vea7w7dmugE51ly9RMkqtGNu72myFjcra4DPjggzQ3WiI5YCdrPMZbPllf/ytU7dwieD/1hCMUpnGpZBgU1N8l8KEEnkoTdE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e324ce8-218f-4062-2638-08ddf459597b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:11:14.9515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXaJrFjz5QWB6DOtgTZ1fsutr0ik8p3Hg0e4mtzHxO2RnXwtIXeLsfOsrbDUwhj3PVp+JHRcanLRxxgUemvRhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAEC321F49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150124
X-Proofpoint-GUID: cI9iR_wc_aMzujlQeFXXulebJciByheG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNyBTYWx0ZWRfX7mIE0TuogtCT
 gAkDub6xxOgkiXttG4eIaqZB6K8v+6l8aC+pbXghQHr1hwVY8VjgZQTJXmoKuqv8Xn/xo1vyRep
 KI4dXEOrR6oMjcbmLw166PBoaYZ27mAupks9ZPXTLGkhEr2fk/p9sglvZ6bAnkJoW2JCrJ8I2vi
 8GLDoidenJKLVVRyKDHJbzgK2SMF12yJEW0fYoYCXaKHp2Jq7rnShzwH6HISEZ5LuFIBY97SQdQ
 0tJ1F8n4SNCoQ3YMNzX2755hoY9uV9r6t/7AzAXx7fOIa7vsrDneb4a6HWjKB8LViDG5cuTw7dP
 oQ7r0Cko6hWby+yiyZjYjWjufrMkPywN4TnaGwAmAeO8junjwRSKlVG3N+U2vSmO4e72krPcW7A
 CqxPqL/tIh7FEeKyQe4ATNIr7sQhjg==
X-Authority-Analysis: v=2.4 cv=QIloRhLL c=1 sm=1 tr=0 ts=68c81078 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=yPCof4ZbAAAA:8 a=-RqSWuy7D_zMS038y6EA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13614
X-Proofpoint-ORIG-GUID: cI9iR_wc_aMzujlQeFXXulebJciByheG

On 11/09/2025 18:13, Ojaswin Mujoo wrote:
> The main motivation of adding this function on top of _require_fio is
> that there has been a case in fio where atomic= option was added but
> later it was changed to noop since kernel didn't yet have support for
> atomic writes. It was then again utilized to do atomic writes in a later
> version, once kernel got the support. Due to this there is a point in
> fio where _require_fio w/ atomic=1 will succeed even though it would
> not be doing atomic writes.
> 
> Hence, add an internal helper __require_fio_version to require specific
> versions of fio to work past such issues. Further, add the high level
> _require_fio_atomic_writes helper which tests can use to ensure fio
> has the right version for atomic writes.
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks for doing this.

Reviewed-by: John Garry <john.g.garry@oracle.com>


> ---
>   common/rc | 43 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 28fbbcbb..8a023b9d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6000,6 +6000,49 @@ _max() {
>   	echo $ret
>   }
>   
> +# Due to reasons explained in fio commit 40f1fc11d, fio version between
> +# v3.33 and v3.38 have atomic= feature but it is a no-op and doesn't do
> +# RWF_ATOMIC write. Hence, use this helper to ensure fio has the
> +# required support. Currently, the simplest way we have is to ensure
> +# the version.
> +_require_fio_atomic_writes() {
> +	__require_fio_version "3.38+"
> +}
> +
> +# Check the required fio version. Examples:
> +#   __require_fio_version 3.38 (matches 3.38 only)
> +#   __require_fio_version 3.38+ (matches 3.38 and above)
> +#   __require_fio_version 3.38- (matches 3.38 and below)
> +#
> +# Internal helper, avoid using directly in tests.
> +__require_fio_version() {
> +	local req_ver="$1"
> +	local fio_ver
> +
> +	_require_fio
> +	_require_math
> +
> +	fio_ver=$(fio -v | cut -d"-" -f2)
> +
> +	case "$req_ver" in
> +	*+)
> +		req_ver=${req_ver%+}
> +		test $(_math "$fio_ver >= $req_ver") -eq 1 || \
> +			_notrun "need fio >= $req_ver (found $fio_ver)"
> +		;;
> +	*-)
> +		req_ver=${req_ver%-}
> +		test $(_math "$fio_ver <= $req_ver") -eq 1 || \
> +			_notrun "need fio <= $req_ver (found $fio_ver)"
> +		;;
> +	*)
> +		req_ver=${req_ver%-}
> +		test $(_math "$fio_ver == $req_ver") -eq 1 || \
> +			_notrun "need fio = $req_ver (found $fio_ver)"
> +		;;
> +	esac
> +}
> +
>   ################################################################################
>   # make sure this script returns success
>   /bin/true


