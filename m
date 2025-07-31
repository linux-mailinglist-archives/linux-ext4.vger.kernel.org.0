Return-Path: <linux-ext4+bounces-9243-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 867A1B16D00
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Jul 2025 09:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915E418C0B25
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Jul 2025 07:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AA829E0EA;
	Thu, 31 Jul 2025 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BJSLFkMY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LVHa5wG5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFDF29CB5A;
	Thu, 31 Jul 2025 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948773; cv=fail; b=TpytsRdS4yv1Nagp58V8gRj8DnJZCu6GBwFNodn7rIq6iYyJPAsgKjHkCWK/6s68NDxZRKgQovZ7Ugvzxw1gIAiLCmVPS9baKmPE5APiEjNceP1wMa5CiqWgAMVXKWyOegMjoSb5kYo7mM9B/2sbRLn/3bNtD9QEO7dxBm43qAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948773; c=relaxed/simple;
	bh=tZ+oYelolgLyYSplQtjAjUwf2FDFHics9BBPk/mdBV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=au7w5XkDDLUG1vJIdflRdmyY09vAMLJzMJwH/Rzx4OcdzouD1teFkNDX3yuhD2Ln+pXfsYn+7D/3W8mFoeANf54VaJBgYzZR0vjycdUNqt3P9soYXl/5l5iOCbPllWIqvKQymEUcL5lFKu3de2NpY692WPGTkY+mKAxL9ryMJW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BJSLFkMY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LVHa5wG5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V7C2nc009234;
	Thu, 31 Jul 2025 07:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Fp7GvcIGgWGEzYz6mx4HLJIad9CXm7LNBvFsKaKvQ54=; b=
	BJSLFkMYoAlDjRbXRJHHTNLdu3s9CIeL/q5ZKEp3VTfqz6rC7eksWFQB+BiTEMUl
	0EfGdyBu2480fmRGV6RQIp2HjV6EenNRgCoRasJp3P+6dgtWSswdQiaBzSl/jJrH
	tMV0otogVVMzDJHotX4bsKI1aQVd1pLoGclvRrUEzGCejG0+hewlepX+E1eF2tXY
	jJcIezlmg/TAHD1l+s2tdEDP3hFZ9L1woJNYMO+JMeZYRuHYR79cdjC5vCCptsJx
	/LInE+0hP/RHArydVsVLfWvIA+Z5WJM1eqsbInFmNF24K28zVI+7upai+aW0qkzZ
	FCY02fgGsKL4UbBH5tkzwA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4ykhej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 07:59:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56V5xg1Q003110;
	Thu, 31 Jul 2025 07:59:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfc6e3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 07:59:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUWO/ql3Z0G5UUSswkV4lx/tPer8N0UuoX5GkKmL5YF3FSkeNjdHR77IhgPkw2PstOCuuRwdjsBAg/vlQ8cSCe9WoVwcxTLPSnk3KxWiVGMdNnQqr+78E+wsmL5km/YrWlAfB9/vh4sEh5QBgylHzRGYGnrWHL6T1OMI5OIxvD86z0P/4Xf5W5NaPL/B1Cu7kG2vtpniB4lrJuvxnecc1VwR5gS3hMiZiJP9bJZXdto0poCC9wig1+NECVSmX2XYqNKigbNq2uT0s035raCEtWBQeRSfeEcwNXA580Rcm6B79tkx6sXFgdqXa4uYPOIiDt7hZ93ciTJrZgGc4eOqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fp7GvcIGgWGEzYz6mx4HLJIad9CXm7LNBvFsKaKvQ54=;
 b=PNkuoOm8Rp6xIDTamt4NjpJCq21Ip9doCIpaQcqbmqnjlW2tNqluBzoCan/+F7yghVuuN1zMKSrTXdBd1wux53qTszOlo0H+n2zeU1RzCwr6wkL2rGilbVveEIeP93SNwklWa7eoCki+PwjMbhH3daCD2vIfeWeKf47A8mHNvjA0TIPrXC3Y2SmHtzacO2dS690vKRolDL/rlPOXR17e02gZIZQNb+P9sMj4Kzbx5PITtXWyrmZrS0l8y8jG6CFaVTNLrSWTjuM1pc4PWSRsapqcfAjLqdqATDmZeFCQL4voDquBCLsQiGNokHSWeX36UAl10AEo/raakgXE+iTckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp7GvcIGgWGEzYz6mx4HLJIad9CXm7LNBvFsKaKvQ54=;
 b=LVHa5wG5sxUM1IRGWEd968eoHxQyOJxj9E/Szog1uvgiKzrnnSxQ41OCEgZC/oAS0YGCEPUxeSN2/RyAutgueIPD7l4bz3UACKlbjwgBEXCJ2+oARRlg9aojptmx5Dlo24WWkN99ZtvC76ENUq88mNTKqEkQwh+BB01BIscmYTQ=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by BY5PR10MB4227.namprd10.prod.outlook.com (2603:10b6:a03:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 07:59:02 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 07:59:01 +0000
Message-ID: <22ccfefc-1be8-4942-ac27-c01706ef843e@oracle.com>
Date: Thu, 31 Jul 2025 08:58:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Darrick J. Wong"
 <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <aIDozETJ8aLparYV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <9b9ed959-bda5-4a92-90c7-a621ffe58240@oracle.com>
 <aIMjrunlU04jI2lF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <0af205d9-6093-4931-abe9-f236acae8d44@oracle.com>
 <aIccCgrCuQ4Wf1OH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <2ae4bb04-fbf7-4a53-b498-ea6361cdab3e@oracle.com>
 <aId8oZGXSg5DW48X@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <3a4854ac-75ad-4783-acbd-048fe7c7fdb0@oracle.com>
 <aIhmG-l4nWOAzz2I@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250729144526.GB2672049@frogsfrogsfrogs>
 <aIrun9794W0eZA8d@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aIrun9794W0eZA8d@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0044.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::10) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|BY5PR10MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9b4f6c-e867-44bf-97a1-08ddd0081cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T01sekpCenozNHladWdSSDNXSE1xRWlJd1NTNXNWMyt1V0FDUlJBV3R5RXBp?=
 =?utf-8?B?aXVuWnprdjhLUnVESGpsM1IrS2Zqek1JU3ZMb2ZRN3pmbjZmczFZRjl6RXQ4?=
 =?utf-8?B?eGVlVVhvWTBYOXF0YlV0eGJyaGxuYU9jeVgyRVVNdE02ZXBkM3J2dndYYnFQ?=
 =?utf-8?B?VldVWmtQYkpVSEdoM2lTcVgvd1BWbzhad0Jxdy9CWURMaW1CejVOWjhKcmhj?=
 =?utf-8?B?WXBKRWRqVjMzWEpocHRQZlR3VnZMRTRQa0VJbzZyTWdzNnRyTHpaLy96QzJY?=
 =?utf-8?B?aC9jdytPcDluRlFneUJsVEhVN1dwTGQzbThXK0RHa0RJQjZDUWREMWMvbXlU?=
 =?utf-8?B?THN1R3hTdDNDdjdMYUpCQjNsZFh1aHZ0MXlQak1DNEJ2eUh0U3c3WFBlemps?=
 =?utf-8?B?UWVkTVFET0tJdEE1d0VpR1ZkbnpZQllCbWRURVZGa1BlaWxXSXZEaU01QzFD?=
 =?utf-8?B?QjZid1NVZU9CSWN3OEFmNUxYdXVnOWo4S3h2QU9RYyswYmhrVkhXOVRrbUVW?=
 =?utf-8?B?STlZeFk3OXBOT2dtOTJBNmliZVE5UWIrVkt5S3Frbko3TjZrNWlTcFY0Q3Fq?=
 =?utf-8?B?RlZVdjJselNQV2dCZjJKRlpPcDNFRW9jRktIeWVmdFZ1V1k0VCtlQyszUXdz?=
 =?utf-8?B?Q2l5d29GZWJRLys2QVFEM2lLUzRkUHVLZ3NQUFhOWDFXV1R6TVRZY1lYdm5o?=
 =?utf-8?B?Y3NUYytwemdwS1NIY0xYTjJoSncvNHdUbnZjdkJKMW5rWmNsWkpXOVl6UStR?=
 =?utf-8?B?MzlIT1JvNjZiMVNhZEQrUS9UVVd4aDc3WHoyVFppczkzVzBzQ2ZybkpoOFRu?=
 =?utf-8?B?ZEFRb1Q0N3Bmei9iUHEvMUEwdlhmWkQzUU94dEhpeDRhbHpDcDJ3SjJRUnRt?=
 =?utf-8?B?Nk5sUHFVbEE1OXNFaFVFTlZabWtEdHo0Zm5XNnVValFIMTBWbVdQYk9Fckdt?=
 =?utf-8?B?b2dLRi9QU1NpS2dmdU82S2lydGF0M3VLckVpbW41dWUyQ3BHVWFuZm9VQzJu?=
 =?utf-8?B?U3IxS0k0WXJQeDlnc1V0a0ZKanZ1L2w4ZWdKZ2xtS2h1amR5L2tSdVhGelBE?=
 =?utf-8?B?aG1LL0QwNE13NDdlY29Wc0dlOENBYmRvbUc2UmdWaFZHQ2VycnBkaTJnWDVx?=
 =?utf-8?B?TmlZSTNUMFh1WFJYZ0hiaE1FQnhLWWEzMUd1cWgyVTV1aE1BQmxjK1VmbUNE?=
 =?utf-8?B?ZUZDTVVyRC9EU0dESS9NZkR4aGtSbVA0L1A3MjVpUGlTTHU5QzAwdHM1VEFB?=
 =?utf-8?B?TWUzRnFlelIvSWU2VytiY09TVVczRHMwdDVCQXpsdEs2USsrUXNQcXNmS29t?=
 =?utf-8?B?YmhZcjRVTzJmMVVQMThGbnBGZlI2dnpDOWt3N2J3bnJDMldCdmdyMVo5MnZU?=
 =?utf-8?B?am1pUkJKay9BcjViRksvVzNhTTg2cGR3TitpUFVHaFluV3hjdWdid1JBSDZm?=
 =?utf-8?B?bDlrcHVSM2Y1Q2grSHVML250M09iOWdaUnRCbW9QbTg0STBGV01IcU03dEs4?=
 =?utf-8?B?QkR5NmgzR2E3NEtJOFcyTUhvRW9xNmhUUUd4dTFidGlNUU1ZcXQzMit3Si9C?=
 =?utf-8?B?RmNCQmU1bjd4U3AzcXRBRFAxcXRINS9kUUJkUThsUXo5TFMrbnFOVUpISHRI?=
 =?utf-8?B?MkJuQjBtZHdoeDcrMWtURnlHYU5kNUU2K2FHbWxYeDkzdC9WdW9SNUhzYm1x?=
 =?utf-8?B?dGsxRnY2STZYZFN6UzA2ZVR1V21ubFRuN3dsVXRFMUJiQ2QwaUd3eDFMcWIx?=
 =?utf-8?B?TkJSYVhNUjNzOURkeHBLNUdmRzgrdFg4eFJGK0p3OC8ybzJ2OUttUWVlbWoy?=
 =?utf-8?B?c0l0MkdSRWJ4U3M0Z3JGb2ZIcUE4RG1nMDBpcWIxM0cxUFVhYzRuSlJhcVVL?=
 =?utf-8?B?d2ZRZ1NqYVd5MHBKTnR4RHlacGZZMjQ0bEVUamxiVU85RGV4SG5JWDdPK3JO?=
 =?utf-8?Q?Y7C0MDAuOgw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnh6REZBaTNhWmsrMStIUU5TWTQ4NTcwb0tyREFPWHJNUkh0Q3Q3SG5oMDFK?=
 =?utf-8?B?T0F5Z0FzZHk5ZENjeGVzMTZhMFYzY1lTbHY5d1dVS1MvRE5sUkZFQk14QU03?=
 =?utf-8?B?bDVGMndibUVuaEN3bGo0a1FkSkZnblV3aWFKZDNxbzBONWRFNFU2bWtVRGU0?=
 =?utf-8?B?bUs3azBiRW02Ky82RERzZnFJM3hsSVloQUppYkFXcTBRNUFuQjh6TnNiYWs3?=
 =?utf-8?B?L0Y4RmIyYVZnK1FuQkdYTnFzbDdBK0x6S0ZJMGxWdENWRjBDMXo0RlZxZFht?=
 =?utf-8?B?Z1B5RmQyRlA0U1p3SjdCbnprZXNZa2RTNkh0M3VSTFhGdHZLTDFUSDVRZ1ZI?=
 =?utf-8?B?aUpOcWlVdmh4TzdkT042NHpxeHVjQlc3REtjU0FTOVhueFc3eiszU2tnYVMw?=
 =?utf-8?B?M1BSSCtSRm9td0ppNk1QdGc4Wk5xUVVvYTdnSUNMRGNoWjZpcVpmVi8wa2w3?=
 =?utf-8?B?dEFTRGl2Nzl1b0V5c1R5ZmFmUG81bjJUQWlyb3NWTlA1Y3c1dmJOZ1krTG5o?=
 =?utf-8?B?MjJnZzEraGh4cWswWUs0MjFodmJlTjlaemQyeHlhOWd5RHkrOEhQZ3p4TWZ3?=
 =?utf-8?B?Z0lISXhLK2JDRCtUaDFyUjQ1dGNISWRyNG93ejYzMUJ5dHU3WUJvb2Q3RjFW?=
 =?utf-8?B?M0JJU3ZkeDVnNWpkdktlQjdxODY5SjZUbkZsMDRJMmFkN2FoZFpZdGk1VGRN?=
 =?utf-8?B?VldkNHVoQjV6Y2dDTCtSNk9LUjIwVGZGdEVRSE1jUlpTMTVQczMxRzI3TWU0?=
 =?utf-8?B?T3FHSzVWWkpWVHRldXZMMkVxb1dIaHFlT2JYcGRrMGdvNjloeEZmQzhGL2Yr?=
 =?utf-8?B?VnhoYnJuRXordDlHVmtvQytpeGh5cW5VT2dvVEhlMFNQSFZ3ZDhFWmV3c0lG?=
 =?utf-8?B?Q29JQ0ZyZzZrdk00eEI1N25SSEliekdzTTVyRGlOaThvaUovb2ZML05mTVk4?=
 =?utf-8?B?TktzVmsrbjlJOS9qeDJUWVRRdW1HV0xBUWtlU0VSdWxxa3hEc2NpWmxaZ2Zm?=
 =?utf-8?B?NW95Um1NYk5neFM5MTE4TEREc3VaMDJaZFhDMnY3REhlaXFsdUtaNzdXNnRJ?=
 =?utf-8?B?MUV6TTVQaXNsVnJNcDlveU5MOHVtRGF6UDZhK3R2YnVRUTdtNlRJYS9TOGNj?=
 =?utf-8?B?MXVURTdrMWVGUWd2TXNVRzNhdDA2WVRaaWxGb3EzUlpHRlh0dWFjeEN3YkN5?=
 =?utf-8?B?OGNISEswMmVtVUhNYVZKN0x3cU1mZ1QwZVFCRDBwNkxROVRIaE1aRlhzZkhr?=
 =?utf-8?B?OWpZYWZPMmttTkJRS2ZHQ25ndDAxcmMyaEFQeTdxaVBPUWJPOVRqQmFoYkt2?=
 =?utf-8?B?WE9MMGJQTkIzdFJVVll5TVVQSWtUd1VmL0dkS1dpOGtiaVJyeXJjazFmUEp2?=
 =?utf-8?B?dWRWZXpCQWt4R3FvZ01EczdQYkVidXUxMnU1NDdsUWVrS2IxdTljOGIwZmFu?=
 =?utf-8?B?MFRHK3QrUG94M3AydVE5RVQ4N1hYMllUdzhESWF5bnVKVU1RNG5RVCtlZnMw?=
 =?utf-8?B?QWVmZUIxbEV6QnhvYys3L0RxT0lGbU9qbDVJWE9IV1FyelFuWXBIZDlvMVow?=
 =?utf-8?B?UHc0T0RiZEhYbDFKN2VKV1FybnNxR2NnVVBOQ2QyRjJZQkw0dUxySTc4YWd2?=
 =?utf-8?B?OE1ZcHdNbHJwakZKQmpTWG1jbG5SS2Z5VUNtMjdDQ3lDYUZPOVdtNzgwc1pT?=
 =?utf-8?B?S3NWdnZKNE5NWVVUL3RzemVWY1FEYlVZVmR1Y1dJV2R2UGVQbHN1RjdYMCtN?=
 =?utf-8?B?WTBqSG5CcWZySWVReGdPbkZnZ1l3dEQxUDdlTUtuZUxYQXRYL1FVbGhuNjIz?=
 =?utf-8?B?WmZCSVNKU2E3aXBNNE5MZ0V4ZGhPMnNlQjlSaGZnQzZPQ1V2cmNOYVFMdHpa?=
 =?utf-8?B?YjNLZ2VRbDNlT1JiMEdNSWhNL0F5cXl1QlN2ZHV2VUY4ZTVUZFJkS1psZ3Q1?=
 =?utf-8?B?S3JYVy81dzVnUkdSQzgyL1hvbVhoVjlVcEtETWw2YkR5NTJxZlZIc2l1cFR4?=
 =?utf-8?B?b2NaTFJNa3Zld1kwZHV2MEhjZzV6akFyU09XckJiMExHbjE1SDU5eWJPbFVU?=
 =?utf-8?B?RGVZWGdQUWVQT1JOZXVIU282RXc4RnVMYzdMUUttL3ZOak5nZ0hPV1FScm9S?=
 =?utf-8?B?YmN1UlRqNzE3NHpwNytFeXZDOUdqS01mQjZaUTlVdExZTjNsZlhDTitFaUJu?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FQA6+t4N/5ezdQejobZnH3nVaeIG/fH9mJfANW3yJa6xdKnor0828tWOXddUHTzai7AduNA8FEi7kEWNdp9MsKBUUPtDl51ccKFj1XPU2q8gAORISauSMEFEmCpB5FDvc2AU/KWOUUXdOlVVxOxBQVpZp0uutZx59MaiHMItRhekchxD4eYgqK8aiJsgKT0jGkNsQaFrHU5H5c7XuKLs18+RACOPxlZAN6VH3Bt8Ghz1x1dzxsWL9TsHkAeb6/iGATMMgs0n7+WBY90Zi6ADncDkahaKd3fvyPdmIRr4DInCYZX42EmnsuueXQ7xypSI7zlfjncAS1cYyUkIGVb6bIRWtkhkjIVM5smoZcCY9Cmdf6GQJL+BtsKrfF+aFjhz/8NB2ozh6/aJUWbq85JOYPc5jzqWOAa5n6KCedudcjQOTN9WGn8cWMt33j9N+XpBn8qZMY3pxxtQfzFkB+qzVztnoZTDNLosprT3Isn3mBgb4GgPl5caXshbQczI3Pg+69Yn/4iSQO1ebcjDoRj2kEFubOk8cRheTGwXzwrziSEo//wzxgtbzooYDnG+ZLRBzO9wFZnn91DJv8JTNiOm3FHhyu2JJaIc8nfMqAKaKvw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9b4f6c-e867-44bf-97a1-08ddd0081cb1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 07:59:01.8258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acvO90MdgJ7JGMj8IaxnI0s8BKhy6yVt2Zt2w8pgb0gOvu5cs6Rj2HNUeeFOb9zSzxI69lZOHeQHr0btdSE9NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507310055
X-Proofpoint-GUID: lNCLFPVdj1C_g3Sa2uZL0UQby7l57qO8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA1NCBTYWx0ZWRfX7JVXBeGqx8Y1
 b0IRhpakncQSBd8qU47VfUZAOCcV6/EHjtZHS9YN+0XD6q4GuR5gwZe4th7C5cCWKgX3C2x7lXl
 tUrOGRQ0K8eV1rFwoS1jtmG6T2TCXX5zn8B8M82Ry4JDxNo7mHVNlS3SREzFjlFD/YGbqt3/pOB
 SbjKgFtIs1qrxhM5Z305Cak7jm8aq0ac+xazSKTks6aWp1IbvYup5eAMFekCynOa9HXqvCSq2pH
 JczXrvm5jKExltzN1QPoC6GAE3BKNUZaYybOHFXzEUX6axls8tnovCgkbZs3wrbulqAALeR9Y8X
 FDpBQTolS35nERp36Wc8AC5pz2T1bPRJ12Qi+6/dGojKk9LbBoFbpzlp/2HqYW20h5sTlTpR48r
 mIIrh7d/4jlWGOkDVFscbrp0vXTGGhNPXLXxHrxeHMejShaahFhojurOTln0yQXqkL0asAMx
X-Authority-Analysis: v=2.4 cv=ZMjXmW7b c=1 sm=1 tr=0 ts=688b225b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=tj35BbGQ_NQ07-KO3UgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lNCLFPVdj1C_g3Sa2uZL0UQby7l57qO8

On 31/07/2025 05:18, Ojaswin Mujoo wrote:
>> Heh, here comes that feature naming confusing again.  This is my
>> definition:
>>
>> RWF_ATOMIC means the system won't introduce new tearing when persisting
>> file writes.  The application is allowed to introduce tearing by writing
>> to overlapping ranges at the same time.  The system does not isolate
>> overlapping reads from writes.
>>
>> --D
> Hey Darrick, John,
> 
> So seems like my expectations of RWF_ATOMIC were a bit misplaced. I
> understand now that we don't really guarantee much when there are
> overlapping parallel writes going on. Even 2 overlapping RWF_ATOMIC
> writes can get torn. Seems like there are some edge cases where this
> might happen with hardware atomic writes as well.
> 
> In that sense, if this fio test is doing overlapped atomic io and
> expecting them to be untorn, I don't think that's the correct way to
> test it since that is beyond what RWF_ATOMIC guarantees.

I think that this test has value, but can only be used for ext4 or any 
FS which only relies on HW atomics only.

The value is that we prove that we don't get any bios being split in the 
storage stack, which is essential for HW atomics support.

Both NVMe and SCSI guarantee serialization of atomic writes.

> 
> I'll try to check if we can modify the tests to write on non-overlapping
> ranges in a file.

JFYI, for testing SW-based atomic writes on XFS, I do something like 
this. I have multiple threads each writing to separate regions of a file 
or writing to separate files. I use this for power-fail testing with my 
RPI. Indeed, I have also being using this sort of test in qemu for 
shutting down the VM when fio is running - I would like to automate 
this, but I am not sure how yet.

Please let me know if you want further info on the fio script.

Thanks,
John


