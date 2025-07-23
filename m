Return-Path: <linux-ext4+bounces-9170-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D42B0F80F
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 18:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8839547D6B
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A661F0994;
	Wed, 23 Jul 2025 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mjd4B+l1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iRKM0lfJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160B1F4CAC;
	Wed, 23 Jul 2025 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287965; cv=fail; b=gkrux2lFPuXE70pqyEl+jkZ7lWcbAtigrRXwB2vigqipMPDIhvZYrnmXd48cCLXEmrL4c7cCWFc4jtOsCsW0VrNhEpfL1nF70h1wBSdF/MMqPGE2O0uVUPmqgbxU310wTuTl6HWruP6cCXw5qFJ9Q6pSBgHpEAvLNbmbo5sETUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287965; c=relaxed/simple;
	bh=RTKahZCSTu4EIHwJkTQs1DyPzR5YxgmdBMf725O9Hls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RheHwlVsHUGY2/xyrDlezHuY68Xu4N2XYl/lVaVghopJZV0hPhyH5tsNhn9AhOgmVXo80JSC9CKuhayQmPWWMj5s3rjvkxi6YMlyIXUWL+VN5fGaVbmSkLQaV8slPxwdn/MicqSk3g+V7gMZf1nugdEZ0yeh4GaQN3hMxSO57Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mjd4B+l1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iRKM0lfJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8NKst000316;
	Wed, 23 Jul 2025 16:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=n3jPorsd60jQ1q0W3NHhKOn4JIvaubpR/wGyMhjWRvc=; b=
	Mjd4B+l1uPpRQKjf7rLzAu2bFjPYrt29exScEXn2cj0tnFAt6UzwbvebP+6tCyjz
	AUTVaCN3+3zSlo2UDH9+sAqF5iJ+JU7HED5V/fDhp8phNMFUe5RhPOwO/eOwUzPP
	Y2VnEipkVMhYmHaXHI/Uw9YMf7rNGoi1ifbCqFqd1HvK7kC7+xv2wpS6ziPGtUmw
	1X0f209u5Ze3+n3L/seQIrxZ8FXmeLEBXNRNNFJnaTOMW86FabsBC1QN8X2QZ8Ob
	YfpqDd4qXz4/WyiZSoZC3kLlDlt9z+I4EYk8nX3mTRRTRtDTS8jr6TbCR/yBUjf7
	M/VHE3WYzjfQhM+LVn4Haw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48056efw9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 16:25:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56NFrevN014387;
	Wed, 23 Jul 2025 16:25:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801th4eak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 16:25:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxxrAJatZ3BLTMPHH5Q7gt+FNLrBCTCknlcxmraUin7umBQ39iYcItNWoTYLWIO9m9L6KKDCArktaAgNM7lO1rPYIFkH+CxlaXdT5CCJJmhr1nVtqxsf8Rio5XQjwFoazSeInF6WSNyGRjO4166rrnBjoQ5ypl9apVvaYta4QOnMpotI53D2SbmsG/pagEhdv22Dw2CTvZrteHyHQiUdwMaO56yAw5isULODciX+PDbqGNij+234lBErpm6iBGlQQxP8WP4A5e8eXKpUzA0nP6Rm6jnUXNzAgjDsizJ9BZsUL6DOYGKp10CHKw3YRouRUKCeE1vnvupXqSAuHI+xBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3jPorsd60jQ1q0W3NHhKOn4JIvaubpR/wGyMhjWRvc=;
 b=Z4qcuoMX4xDaQlU0wZEOLZ8AFltrtgo1xo3tFJZLvBxUBJzLn39CHWg5Zd6/JKWai3OGp/IJXgstELRP6VwDpHmOOKpXOfJwZr3JA2KE35cKzVn7veXvJ3I5gqvv6u9JXGmG8vtnuXxXoYHH2n2Uq3S7fUJTA570lpcMjdnOF9PwhCnsK16XtRhhpFigIri8q8ICOgNbKfItAdayllXiit7mxmTS87MIUKNpwhLgg8sWUS6FwhF6UwBPxsM3AeUPdm72q0SrI4qLtnR0cT970PgcmAWfq2eVpaza48grfy+eLYWKD3JmQIB55lNCgfzYEe3RNKADpWCIb2EEd7/Pdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3jPorsd60jQ1q0W3NHhKOn4JIvaubpR/wGyMhjWRvc=;
 b=iRKM0lfJd88yPJX/nekWVjWGbNIdNEcQWcTUQZorE2dKQJiG0R7ddFXJ/oCuYNb9CwvVO3n5+AgkdUGro7jlhqJ2Hbq8FHiprzQh6o7Dez4slVL3rYAVuPSlr0SGR16TqWpF1VsHKfNEYWwhjJA+w1aSqmO7gLquwyX6hLZCSoM=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DM3PPF6AE862AC6.namprd10.prod.outlook.com (2603:10b6:f:fc00::c2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 16:25:45 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 16:25:45 +0000
Message-ID: <9b9ed959-bda5-4a92-90c7-a621ffe58240@oracle.com>
Date: Wed, 23 Jul 2025 17:25:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <1e6dad5f4bdc8107e670cc0bd3ce0fccd0c9037a.1752329098.git.ojaswin@linux.ibm.com>
 <5211dff7-579b-48ea-8180-72d8c6083400@oracle.com>
 <aHkAJJkvaWYJu7gC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <b270bb66-721e-4433-adaf-fe5ae100ca6e@oracle.com>
 <aH9PwFm06n9KQ0mE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7fc0f04e-dcec-47a4-b522-eb5a8b90637c@oracle.com>
 <aIDozETJ8aLparYV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aIDozETJ8aLparYV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P192CA0027.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::32) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DM3PPF6AE862AC6:EE_
X-MS-Office365-Filtering-Correlation-Id: 659ec73c-215e-48b1-617b-08ddca05932e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnQ1MisrNURSM04xQjJzUm5FZEtOZ21lTEFJYVdYdVg3QXgza3gxOEpzNW9M?=
 =?utf-8?B?TG1NRk05bUZUM2lhOUwvbDVIbHVRSnFtd3E1ZGJsQzhjaDNOcDhxVkU4TnZL?=
 =?utf-8?B?UXpOWHFoTlk1TnhsS3lJOVJabWRVSkJuQzFpelVKL1JLOUxzUFVDc2FxMUhr?=
 =?utf-8?B?d1VQQTU3QVVXdmhlZktPbkkvdlhRSzNRdlJONkp5TXI5aVFrbVF0RkZnWFJY?=
 =?utf-8?B?Z2F4UDRzYkVLVGFPUUIwZnJ2YVM1aTFlWjdpNnlWTjh0OUs0Y25qOUVJa1pB?=
 =?utf-8?B?ZFBObVVIUWljTVU4UVYvYTg0cDdWdnBrakQ3NnpCcFhCSmJ5SlppZ3JRQUdV?=
 =?utf-8?B?UEZBSkg1Y0dIQ0ZBbTlIOGFKVVZ6dnNzR2RlSlNlaDFpL2U2N3F5VkRDbEsx?=
 =?utf-8?B?SHZJQzE2eFlsc25yRDNNejg3QUFLamxxWUlsN2FmY2wrUWhtMmJVL2U3eUM1?=
 =?utf-8?B?aElHL3RiUFEvVDAvVUNGTElmMUF4N2RROHZhaFNrb1FvKzc5b0VBc20wM1lN?=
 =?utf-8?B?VVNrY3NOZ084UForaFZVRzhvd3EyZlEwcmFRQ1hEMkJCcnBRdittMDZiQUxW?=
 =?utf-8?B?bEl1RWVWdHVhck1BdS9JeXp6RlpIWk9pRERGTWR0SE1lL3VzVjIvWk0zRCtU?=
 =?utf-8?B?Kzh5VmlTZVRqTDY2c0VZeHVZRHdETjlmM2drWVRsR0Zrajd5UmJIc2hkbi9W?=
 =?utf-8?B?TFQ1SUo4WXpCS2hhdENScEdHQXphY3BiNm13Z0dxR2Y2MnpJOGQvSlhQb0V5?=
 =?utf-8?B?RjY3cFdTcDM4a2crYzMxVFVveTVmdWhTWW8wajlKUUo4TTRDdUxTWk40TXZn?=
 =?utf-8?B?aVJxdHRxaVFqUG0vUU4yZm9GM0w5RVJlcjBlZ3UvZzk5MWdCUVpxdW4xNWpO?=
 =?utf-8?B?VWU3WHl1Y0xvakl1d3ZMUzZmQkhqZ2Q5VzUzaUlvd2FBd1k5Q1ZWY3JzNE9P?=
 =?utf-8?B?TmM1dGRaaU5lNDN3eVJrRUYwaUk2dkdPbThmckVqanIyaktKTmVmMHBvKzYr?=
 =?utf-8?B?MGxrYTlYQlFYWVFVMTlPNHZOQ3lycExpVDFuVjQ3S1RoYVJCWkd5VU1IMWtL?=
 =?utf-8?B?OVI1RFJVd3drY2lGODBsdGVwR2p4OExQSjFPZDIvTThxQnNqeHY2MTlQa2NR?=
 =?utf-8?B?c1MrWktuVjNLYzBiSXcwaXRsWEhjdkZEdmJPNnFXUTlLQURPSWxNbER0RTRC?=
 =?utf-8?B?REJ5RG9pWC9XUlBjOUVnU2hTdUdaUXdvaTUrQjVyRUk2cWFqd0Y4bGZOVThu?=
 =?utf-8?B?YzdDam1ldnJITXAyZFhXNjB2YUp1Zy9uZDBKMnV5eE9xYTQySVdGSGpjRUd6?=
 =?utf-8?B?eDZQR0NrbExxM0VQRTJla2hBUWV0WTNQOVJhUmozaGxGU0k5WmNBR0ZMMy9x?=
 =?utf-8?B?aEQ1YkNWb3BXUGVQS3g1TEFnYmR2SG5iUzI2Wm8xUW1kMmtQbFQ3T3RYMWR0?=
 =?utf-8?B?NDlrYW15RE1WMjczLys1NlQwa2tRMkhGRk9EU1MyeklUZ2cxM094UkdrMlha?=
 =?utf-8?B?cXp1cm5LeHBZWDZ4UjQyNjU1UWpoWWJrT0dydUZ2cGhpZHB5ckRDT0lrOTZD?=
 =?utf-8?B?bGNBUlJWOXZHd1ZiUEhrL0lPc241M283RzdIbWgwZ21WVGxUUWlTaTFNRENZ?=
 =?utf-8?B?YjV4amtCa01PU29GZXlpUlRydXZSR0YwRko3ZWdMRWdwdG1ZSTZnT08wanZu?=
 =?utf-8?B?UkJPOENrVHZ1dnhKS0lnQWlFUDh0NDA1S0UwVU1XVmFSREJRTU0wVVg3MUJK?=
 =?utf-8?B?VlNlWWY2cGFtaStBUGR1QTd3ak9WVTBOQ0tNbEdUR2s1UlBqcGF1OVgza0Fl?=
 =?utf-8?B?R2RydFlxR3ZpTlRUSDhMZmlDa25IQitrK0V3K3p3aER0QWdSNXR2dEdnRFdh?=
 =?utf-8?B?emhoTTlJaU9yZENkUU5EeHNuMVp4bWkrLzZ4RmJmcnRKQVZBZlJ3dVNSb3NS?=
 =?utf-8?Q?70EjFTOb3RM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkZSWnk3Z1ZmZkx6YkIyQUZVTU1md2d4T2k3Y0IyRk9aVWFiMVdiSHdqM2VO?=
 =?utf-8?B?d3pFZU52SHlGL0YvOW9IdlU4ZXBndW56V3ROZE1hQllXMzhjRXQ0ZVdmOEJz?=
 =?utf-8?B?VWYzQUFWUUFpUFhENzVNeks5N2VYMDcybThoYzZaYUxyWGUwRmZpV3FUS2xQ?=
 =?utf-8?B?RHg1cGRYNFNDdGZvS3dHdWpQN016M00zekFzNXAzZGNXcURxOHE2THdNdDVJ?=
 =?utf-8?B?SzRZRG5HR0RkdFRHTy9JbDIwYUFvRmdnaUhVek1XR3BGcXc1RkJvVGVXN1I0?=
 =?utf-8?B?emFrZFQ3NGQ5TmQ3cW00OU81M3Z1Q2twUkFEbSt0alVEZHFudm5OMThFWXZu?=
 =?utf-8?B?bjZMM1RlV2hCRFBJQTBIREhQRStHM1dlWjUzUWV4RzJOSDgraXM2bUNoci9K?=
 =?utf-8?B?N29JUUFXRFQxLzJCcE1nQ0ZZV1BEZnliZ0lHQTFsd05FNjg1RXdsMUl2OUhS?=
 =?utf-8?B?OXRHenVTRFN3RTV4WmY4dDZTUTRLcmJ6bjRFZ2NQaUhWaVZuaFVENjBPUU1O?=
 =?utf-8?B?bGlxaTRYUjVvNmFrOXVtL0dGSHIxcmlBcTZhZ3NvbTdzNGFRWHplU0NsSk8v?=
 =?utf-8?B?R250M1pJL2RicTVrQVlPZk12aHErZmNHaWdOZnJCUzZJZEZlQ2k0SkxCeTNW?=
 =?utf-8?B?YVRPVUR2akhaMEVRMHJ1OHlhSVB4dlNmRGhKTXdaYXZ2QzhKR1VabnNkUGQ3?=
 =?utf-8?B?QjRKSFVxUFAxQTVSaDUzd2NYSjdjc3R0cU1nR2wvTWliRU1zQUY1aVluVHdH?=
 =?utf-8?B?T3pnY0RWc1pVNE0vZnIrQnRLQ2VlT0hmcEIrMzZPb1Azb0d3eWxEYmxXM3VD?=
 =?utf-8?B?VGdYaTB2UmxiMTZqb1FSTElkYXIvUTY5QUVITnNLaDNYNXltNWxzN2NjM250?=
 =?utf-8?B?OUl4eHB6UWh0YS9JN3B6QUhuY2dxUkREZk4zMXVmTkhDOGEzTGZ4S1BlVnUv?=
 =?utf-8?B?Z2JSRnVDUGZFOFZURFJPNVd3YjdPb3FrZzBhZFVvTEpYM1pEdzVHTUJSaEND?=
 =?utf-8?B?Z1hzU3BLZGlsSlVjNFVvNWs3Qk9LMUU3MjJzOXFBaEl1QkRpYkRMZm92R1F6?=
 =?utf-8?B?NCtONnoxVW9tQ2NPRm1zNXM5QXBBUSs5eVdIQWVBY1I1VGZqU2ZUaFN6c3kz?=
 =?utf-8?B?N0xHdm9ERHd3QVVkTmJlUk56QU82dzBiMnQwQVcrY1ArOWhVSFRQeFp0SHhQ?=
 =?utf-8?B?YzdaYzV3cm5Pa3MvWXVVc0QvSFQxWWhwd0FrU2E5dXVlOCsvSG84L0xTYm8z?=
 =?utf-8?B?Z3VZaWNWMEo4ZjdGenFhdTRrVnFMZW5xcDN4TjYwd1M4bGM2VWptRy9paWh0?=
 =?utf-8?B?bVh1ZVB0eXpCQnYxdHJqd29Vc1R2ZXhiY01CTjd1SThTcU95dVk3ME9hcklk?=
 =?utf-8?B?cGI4eGl5RkdncU83VXlKWDM3WWxPQXlkNzdBa0htc1FpaDVXZVUzQ2IvUkwz?=
 =?utf-8?B?TUwxQUF3R0ZLcUtXalpmc2U3UTlsWExHMllNOGcwcUp2cmRLZEVhelN2RGts?=
 =?utf-8?B?Rjk5bW9sRFVRZHY2UysxdzR0Vk9OZ1EzZVgzTlg3NUNkbDRlL2doOU93L3l6?=
 =?utf-8?B?L3JISXpqV2lXR2ZiRVpXQ3l2UWdsMXk3Z08xOHNldWJaeStCbGRTRXBmWGQv?=
 =?utf-8?B?QXZMd0N6NXJ3STlubGVPUFhEZkR1c0F3alYxRmxXV2hKTStGSllTb2cxT3lY?=
 =?utf-8?B?WFcxc2NCR2VjOHlpbUlyUGpMSHhlU3B0Qnp3NjdjTGlicnY4RnROU094UExq?=
 =?utf-8?B?aGdFM2d4cjROQ2padEJ1R3ozWEtMbGMxS3lMY1djanVzZDFYRW5yeUJjNmZ2?=
 =?utf-8?B?UFBEUzZxMVJIZHJGa2RRQ203WHBwRFdHZ2Q4ekxnTGdRd1RxNW9CdkM3d1pp?=
 =?utf-8?B?MWt0OEFBNEN4U1dwdFgvaGpMUHRqVkNzbnVFVnRMQytRRHZScVRCSmMyS0Ir?=
 =?utf-8?B?MTljNDJqM1B0SnNBWVlCQTlva0xhbmg4Mno5RTVCdUs3cDRDS1haWFZjbmdo?=
 =?utf-8?B?ZjQ4TTFYU1JRKzl0cTVQaWE4Rm9CTTAveW80TDgxaXdHUFBFYWt0SGJIY01h?=
 =?utf-8?B?V1NBNk1uT0pFYmFSdUZOa1BpMUtrb2Nmd2RPL21MQmU5WGErOHhQaDJhZjN1?=
 =?utf-8?B?ZTUyMzZENDEyRzZwN3dld0x3SGN2UDl1dnRqNmtzK2lOWGFJV3BNeDRYcVVx?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OD+OvLZWlX+Le8NcdKZ7KzVCA4iy1wl2JCBcIHnKzPgirCbZKlqBS6RGs0JteDOzRaBsMv/HVoAD3vFhMjW1LG/4CzfWau/f4TQG+5q+dzH6nCx3chqagyh76WvnA+WbR6ckh7dlxAZEhEbBWJNqJLc/iBwysjpVWxo1s8S58RvG8/70r+w5TdWWwlb5vyLPiBlSNSVOLSYTeYuX/jLsGPPgRd+gQYnwft9sB9AQVWgIyOe+V8+iG7W8xAxVelCvZKfAhsps/ftvXPd1JzXDz9O0595gs7s+Q4YGv16sG+Z1n8lszDGbmv2PfEiyTXWDWxMRzMF1zRoDTXHKqVlIobvLysoxu71nhW5aUTwN5Y7ETCfSxn6DkzqaI0y+orFdCEpc+vx+uM/WWTshu+iR3hzupyS1aLrTYpWeHBO+f9pjtbQjOkKvBySREa9+Z8g5CrJ5y0XX2YY27XrYxPIGCuFWwIpxeF/1XnZR5S5hcZrPw1pihdRE7jG7W27WstgsJD2Nqyu6H8M804kGFbCJ03T1GcoZ88GNJ1Cwqeil//jU2eO0VZPP2NQHazmkFe4Qt4exijtUtHP3jXt953i4lZyLhTz1ckNJ/C+DoU3Knto=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659ec73c-215e-48b1-617b-08ddca05932e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 16:25:45.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXvmCbphVhk/BgLirU4+PwTZAMwgy42vAddm99tHBO2AS5VtJeRVHgE1aJGkW05J0I2D/hdsLhFGAvZF0GuKTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF6AE862AC6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=945 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230141
X-Proofpoint-ORIG-GUID: HChQDB2FQT_eNZAQgkuBHPsQaIhNWz-F
X-Proofpoint-GUID: HChQDB2FQT_eNZAQgkuBHPsQaIhNWz-F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE0MiBTYWx0ZWRfXwidVaEgofw+A
 xk5NDUan0GHp79DIXQAueBIwwg19Im88JIZ71/Wxo91wBRPQtcqFymOdgnpuSB9mcxDBxAH37AU
 ixtYDgWh9LsQsWLSGWhnjL4JB4OO37aVCgItumuIOJ4EaC1Ly1Y6AHvfcHHJ+6Uy7VHHBw11bkd
 8BV6F85oafqbbHB4Jo1rl78Kb/cnfHLSnw6TRck2sQ3zf3J4LlKmcEGYOgvTtL5FCXQJ/m0LTbQ
 LO1FDF5YtjokEDcjha+s3gLhrDzV/yZE4NJV4vBcqH5cdeax7XznvWK33DqiUyv3rKPnTOgOik0
 RNRO+Al9jJnpLn7hX2KAA047dZVrf1/BGrhup816FmjbM1d5c1MzK2Vx8nqMmC4WXy6LMbxtqfm
 UcKbPx4OTjNxMX/FN7QIPnK+87pJQyEp5s9i4Fg3mnX5ewnvMoBVV1QUz9ZAYOruIF00+gpd
X-Authority-Analysis: v=2.4 cv=Ef3IQOmC c=1 sm=1 tr=0 ts=68810d0e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=nN-CmwRzYsKT069ujoAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 cc=ntf
 awl=host:12061

On 23/07/2025 14:51, Ojaswin Mujoo wrote:
>>> No, its just something i hardcoded for that particular run. This patch
>>> doesn't enforce hardware only atomic writes
>> If we are to test this for XFS then we need to ensure that HW atomics are
>> available.
> Why is that? Now with the verification step happening after writes,
> software atomic writes should also pass this test since there are no
> racing writes to the verify reads.

Sure, but racing software atomic writes against other software atomic 
writes is not safe.

Thanks,
John

