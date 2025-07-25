Return-Path: <linux-ext4+bounces-9187-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9869B1199E
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Jul 2025 10:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A25564810
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Jul 2025 08:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E932BEC30;
	Fri, 25 Jul 2025 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ryo2XIbF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tDGIj44b"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515D62BE7D1;
	Fri, 25 Jul 2025 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431284; cv=fail; b=HShSojw6DuSTgNqYXc6l3CCKQzS1ZdIjhkJnaXcVnrUkc1ENialwukiMMqW7sB+9x3rOK/NN9DzoTDqVtO9gGaiYxMyZ20znnvEQ5RYwvHlCenRhEGYwAdmlovkOTXKADa4s0Ri399Tr9pOcxOuKVJZ1DWe1Y3x2s5fXLCHQmjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431284; c=relaxed/simple;
	bh=PPlY+xtGb3pMOHOI3oSkwZsCtAP75ZiohwugGwEbBbU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZopMjIL4fKhvGgzatTHiGbJiG0sN5p0WlAKoGcNWYrN9NcRvfNECGs2Gfs+DEMA0I2zqD1tWqgdqMq2R3mp2JIty09189zjSzy4gjy55LqHGrwsgsTlmNhI5/IaqPrSK/we/r1oApBzMwcZIcA/YgC9bErI4NshICUgk3F3rI+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ryo2XIbF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tDGIj44b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P7gFec006596;
	Fri, 25 Jul 2025 08:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FnNNHlVux/eQ1egzskZxxOLE/bIOeykW1g1nCNa0yH0=; b=
	Ryo2XIbFQZ5Glv5DKHS7t4aG/G9yqOw49dCshnHO1maiH4c55hLU5Fyh9+kJ1axG
	X1UciFoycUlOnk2Kyqb7AbCgx2JYNbda07zayiV75qTmkmJXDFb+gw1pzjxTxMK4
	BHNYaXnObTIeVcpiFDJTnP1okP8ck3y4tTc2M7rj466YKjzoPWWIpbaXwfgu8PLh
	wrmgPhxcz8iAvcMZMUGnN5c5uz99RZLLPPqFeuhKoNBwl9Ftz9Z5GRIquZRBXAnC
	LILLM464atoVI012iKIPlVhaDgecE1yN7lqTOqfah0TQMHNNMG+f9LBOVhADMmce
	rDFzoQCPIHkT1AluDF25gg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1n0jr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 08:14:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56P6OTwX031449;
	Fri, 25 Jul 2025 08:14:32 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tk5a0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 08:14:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mh3dz/MD5gjorlNA0wAW9U46i2mQflGbsKMkljN+ca8njvmgvipC8t9tcE5ooGMl+5vu+yFW+n4UzE7vS5fuYfVRbSr9juFf/McaVgqH71qpcUdf7HXrMVJSerSHVrIfWuNLP46DEb8KfnpwmPegRVBQxPpCx0g3OCf4EH0sT/XfK15bkfEMGpOIqVXutTA/lql4yLf2tzESoGgk9d0Z8Ra+XoPEwYPE2D7R1Auui/3kJYwtEupJehbWAKR9tn+skD0/ERY09nJyRtuYw12hD8tapi0QsmxCbS6+21IucAiP/RTHQ4WE96tD7Y/LjJMKMP6twodeHJkEe/GFTTeLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnNNHlVux/eQ1egzskZxxOLE/bIOeykW1g1nCNa0yH0=;
 b=jF1s6tSpyxA4VrGjW7xCmItdEeQXZfZlIIHY+UcGMFtZEFOFoMof6XglWvkne1CpM3iJ2hAOQRZ8IzhR1CzkNeZl1EWfoZklut450vi2V6P+h7XtYT83H1ERvlw5QV4UBTj6VSwCnTOkrm/A9keNO1chrfXcpfMtSY10pWu6TVU4dQIeUj2/m94CpMBivmlFiDTftbTQ2cJhmbSeziHXwazZw6odbyu1XQDelIeJjVBWkpWz6fC0Arr38zc+n6+0WNJhIw2CaB6hJn2AlT8Y/TvaS5nMUlCeeNFYBLBNw3rMcM3aaqhKyh7vCFN8nFp/g7QLrmUe5PybKPyOwcJoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnNNHlVux/eQ1egzskZxxOLE/bIOeykW1g1nCNa0yH0=;
 b=tDGIj44b097D2VkWKdKyB9EEexdyiKTEiuD5uhC/1AMLsc6DfrbQ0OGLPT7tlmZJUwEQhMQuGCV8/dymR2fz8n530IHyZgGsHnBnKuX/FOpINavHCN/Hsliph/6HdAyMSdyL8tkse2MvRZO6tFQaH4wNQ8PyKQ4Wv7UVTf8HykU=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ5PPFA8FAAE4F4.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7c2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 08:14:29 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 08:14:29 +0000
Message-ID: <0af205d9-6093-4931-abe9-f236acae8d44@oracle.com>
Date: Fri, 25 Jul 2025 09:14:25 +0100
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
 <9b9ed959-bda5-4a92-90c7-a621ffe58240@oracle.com>
 <aIMjrunlU04jI2lF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aIMjrunlU04jI2lF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0087.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::20) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ5PPFA8FAAE4F4:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b5e53f-64b0-41bd-9de9-08ddcb5346f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wkg2V2R2VGZBOG5EVVpXOWk3V0xlQnJncm9WTUZ0dmZNdDYrQXllMjh5eERy?=
 =?utf-8?B?ZTNGTGtVbm0vdFNWK0JZVFl5a3VuUG9oZVRianpSckNxdmZyR0hna1ZsalR4?=
 =?utf-8?B?OCsxSFFHR2RMQTFmcGxwQ0doWnVRT3hQdzVBWngvcDV2N3FxK2RQQWZGdlNZ?=
 =?utf-8?B?U3VPUVZZcjNOWWZKNXFkVzd0anZzMklPNWNHRGFpaER0d1E1cGZWeHl3VWNa?=
 =?utf-8?B?R0R2MUE3dlB1RmhRbG9KU1lOZzgxa3NBb3Y0ZkVXWXM1bHNFNDRNRnk1WVRm?=
 =?utf-8?B?aXhDZEdXN0dOazdNVE1BelVSZTJjZ2lhTE5hUnZWNVNFemFsRHZaY2QzVzFQ?=
 =?utf-8?B?N0wvK2IrYXFwaGkxSmJsRXFMV1FPT1lEUUczWXJSaGJsU0FmMEp4dU9pZ0Yv?=
 =?utf-8?B?b0E1ODI2UlArU3ZaUXBjbE42SEJGS2JseDdseXhzeW5EMDQ3S0xnbEJtSU1D?=
 =?utf-8?B?aXdiZnVmQ05TOEFYWjBwMnJYcXQwcjlNdzIycFc5bU5PZm8zNDhzNzBVOGc1?=
 =?utf-8?B?UElhYjNaT0xwOG95VTRRN2drMGtJV0gzSXNlWXpVdmJqb2c2S0pQcmZwbS9T?=
 =?utf-8?B?cUs1SUJCZ2lRMU5leWYzRU9Mc1ZKcjFaTlZGMm9oWUZtdEcweko4alRqSmtR?=
 =?utf-8?B?a2JGSCtna3NoT0NRbG4yZUt1SDhsMGtPNkVYMlJXTm5LU1BvTjloMzRVc3Fy?=
 =?utf-8?B?eDdBSWo3S2UwSVd3U1hCNGhjdTNOTTFEN21hVnB2UTdhdnhJV3ZsYWtDZUp1?=
 =?utf-8?B?V0hqT3oxVXdJVWd1ZXZSc2FiaVI1dCt6cElPODJ4dU5CYWxGa3liYUR3WDdz?=
 =?utf-8?B?U0xuaFA4NXJEZzJkaDIvSHl5Vk43eHd6SEUzUFRTMjhOQ0JoM3duQ3JIcFZt?=
 =?utf-8?B?VHc0ditzcnIyb0pXM25lZFJFTTJCRlg2ZWVlOUI4aXZVUXloR1J6N3VsVk1X?=
 =?utf-8?B?TXZTdjZkM1Vhb0RKQWVCQkY1RnBxY2VBRnRDVTRmOXAxOVZxdVZwbHJlRzQ5?=
 =?utf-8?B?S2ZSMjZERWt1NGRxRDdZR2g2NThtVk11amlxVzRmZFVocllzV0JBUm56bnFS?=
 =?utf-8?B?dldrSXVtclNzd3hyOUJiZ0V1SGVqTStjbjF1Umt2cG5tYmowTlJ4S2tpUGZT?=
 =?utf-8?B?M0xCeC83SHhVYTZnUjBGeEQxWmFjUEVMUWdWTWQyM0dadFdhcE1VbjJSUkhY?=
 =?utf-8?B?SlVZOXVhUlVtUURPRnFYOENScHBpckNHcFRxbGRtNWVwT2lmakp3dElHd2g4?=
 =?utf-8?B?NHFBOXhFTkZwVGhLZDlpOG5TVndkZVlXdlFYU1VJMEdqeWtaclgxYnhQL3dV?=
 =?utf-8?B?UENBT1hQUXZkT1VWakFyclFseC9aNDJNdjAyYUxZUFNUOEwxUkVjQjFLTnNO?=
 =?utf-8?B?Ny9MandwUWZPZUdLSTRGMmV5Q29NUnBuSkZ4WC8xOW5HQ0lmRUh1OEpBSHhv?=
 =?utf-8?B?S3JPUk81VFV1WnRPNGluUzVpQTdZclUzQTNUY09OMHdjcTloUzY4MmlHTjZ1?=
 =?utf-8?B?SENnTGw3RkhBZFNmVExkeENHVDB6dlVTbjlBT3lDUzlnUnRaNThZLzFuaDZE?=
 =?utf-8?B?Qmd2dGF6RjlPR25rUnVIRnFTTFExcm5wVWFDQmVjbEd1Z3BFMWllZWVQTlZ5?=
 =?utf-8?B?OU5vaEN6VG41UlZWTU8vdE5WbGZqZGtnNkc3QVdELy8xWnpMbG40c0pDVFBO?=
 =?utf-8?B?encrenRkNUZRNU9uU1cySnIrTWFpVUZ2VzZZaDhvY05qL3cxRDdheGxpYy9R?=
 =?utf-8?B?dUxYMThVR25uZ242a0dnMjZYOTV2S0pjWnZSUVh0OFFFQS81VXREenI3YjFx?=
 =?utf-8?B?aGdlVm9VZXloM1h6bU5oNXVMQ01wK3dFbnhxaHFuR1FIeCtOTTZ6T1VteGdR?=
 =?utf-8?B?TVE5T3pmL0lOVjJ4djhULy9UeFdvSW12R1k4U1RodkdqclE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGZVSlpxYWp5N3hOWWx4RmdLT3k1WmY2NE9tRmpLMGJqVENERHJIbHFRMDRx?=
 =?utf-8?B?ZlN4ZWhzWlFwSTlVZEduS3NzOWlFUDNBSkZSbWFtdWFVZFEwN3ZSUG5iVTUx?=
 =?utf-8?B?L29pS09QaG8zWmwzT3Z2YzZuSmtHUHVvWTFOMWgza2x2QTBBeDFoMk5FTjN6?=
 =?utf-8?B?eVN0aG1uWEtGUEpWajdacEdyR1Uycm10d1VaVzJ4VHM3ZzJnVkd6amRMMUZ3?=
 =?utf-8?B?aXVZdGVHNVNjYzJsam9RM1FqT1hFMitnZDcwOWd3T0JQZkpKcDhxUjZnSlkx?=
 =?utf-8?B?MXBUdmFkU2FIZU5VRGRqSWh1MTM5cTFOQ0tIRHIzclpzSldNbXo1aU9Za1c2?=
 =?utf-8?B?eThDcHF0S1Y1S0Mvc0V4MDNuMVB2cjhwT3pwRFYyYXQxTDlyU2F6eXl2VWxz?=
 =?utf-8?B?bUhmNmxka29jL3RtQmlZWG5XaXg5YjFKUlBkejFzcHNGM2JLRHhPREg5c0hY?=
 =?utf-8?B?ekRmSlA5MFRaOWx6bldRVlFmaXMxYkNvSFFKeW9NWU9XWFRnUjZrUytQZWF1?=
 =?utf-8?B?OXE5bytTRzRUZThnRzE1dU8zQ2UvZHVXaW1SL29lZVNLRFNxR1Z6dEdOc01p?=
 =?utf-8?B?TDYrVkxKcWhsVmRCOEtPdHRUeDlwRWhmcHR1QmlxTDdobXkyeklmZGhaVTRP?=
 =?utf-8?B?UUFoa3dFVUpZRDQ3eStyUGk5emVPeWozdjRWTlp5WFYyUHY5bzFlOXR6M1I5?=
 =?utf-8?B?dWdUcFZiUUNtczVGblZyOG9wMlY1bDd3RnFBUmljbnJXd3QvRjh0aFJEazQx?=
 =?utf-8?B?enI2bXA1WitJNlFzRXNyRXI3M3JHRnQ0U041THM4SXhDWlVrTXNsVUEyRFVJ?=
 =?utf-8?B?VEp5Yng3T1lWd0VFZXZBSnByVytSbEYySHF0aWRuWForeGsrTm52am1tb2JJ?=
 =?utf-8?B?K21lSkxsUGRlbisrSnlUbjRnSWNtTFBsTW1WQnhFUzRJaEx4akhFTW1sRmFp?=
 =?utf-8?B?b0VHQitYZFU3MDdOSFkxSWt4ZTYzeFI5WS83bFNFcXJGTjhwTVFJZkYxV1N6?=
 =?utf-8?B?cHBWOUt3MDM0d21WS2NvclU4RGc3dVlVZ09TZ1VzaEVVQ0VlTm5RNGZZU3ZD?=
 =?utf-8?B?bUd2VWd3Z3BLd0NnYnlBUEJkbHZrc3p4eVdtQUVRNUJ3L0kwVy9pb0RqVmhq?=
 =?utf-8?B?TTZRWkVaYy9KWTNsQ0NPUVpKMStMa2V2YnVPR1M4ZmJiNFhYWGw1Zk5VTS9w?=
 =?utf-8?B?U3B4d2c1ZzJXUWlWRzlVSGRxNEx1VGpta1g2b09NcS9XdGNlZG9ib1lYcEE1?=
 =?utf-8?B?clI0WEtScVIrdERKVjN6R1JYbUtXNVdscUVHb2hyZFVObWdZMHFOeFRjZXFF?=
 =?utf-8?B?eTNiQXB2TkdnejdJOEFIZ2ZpK0ZPVmxSbjhjVW9memRLUEdRWUgvdExreSs1?=
 =?utf-8?B?YlJKWHlwYzN6WjlLdDBxSGNEWW42ci8yZmJKVUJEaHRoRXRHZm16NE8zWG5a?=
 =?utf-8?B?NEt1WTFlUjZmSGxHS3VnYUZkeE9MQ0oxbWNDUVVLMWhFdzMwL284Q0ZiTE91?=
 =?utf-8?B?Q0IzckhSOUo3QXNqQXVhNWV2N1FWZldtYXRPbEZEK2pUbDE3dlhMNkxrdENY?=
 =?utf-8?B?cjl5ZEFkbHBJYmF6R0YzL2RZOFpZcVVIY1JGSTJKdVlFTTRjMXM5YW56TWRJ?=
 =?utf-8?B?dUIzU0s3VEhhZWV4Ym9ucDd1RWZtR01IUmExUmp3eHI5QUJwczEwZEZJaE95?=
 =?utf-8?B?R0FEeElxNDRQUVd0WnJJOXoya1hUNnVTTjMwTndLWitVeURmbmdmMStiSGR0?=
 =?utf-8?B?Wmtnby9NcndYVzVIZ01LLzVXbi85ZWdid1FkUXU4U1lVVkdOZlpvM0dWelF3?=
 =?utf-8?B?M0o1R0hzblB5cnF6dXo2RnE5UUtNOU1Ja3N4MmFveUZRRjRyNGFyUlk2bDVJ?=
 =?utf-8?B?TUV6dEdpbnRLeER2T3hGTm5aaTdId0R1cEEwY3daM0N5TjZaWjEwbWZ1SjRS?=
 =?utf-8?B?azZYc1hUZmJlVkpyWG1IYWtPdlY2Ujk0emFwcFJpSjVpU3oyS1JoVWVmS1RN?=
 =?utf-8?B?NG4rTTRWVW91eWZId0NKcUJ4dXVvN1FqMHBzZ0h4MWlGM2pKdHErTmpjdDhz?=
 =?utf-8?B?TFUxK0c3bndrbTNPR0VlYjJnS3dyQWhuYnNYK2J5MnZUMW5iWWl3SldHVE5m?=
 =?utf-8?Q?VaPCyv3HmHQMo4ul+rTdHBEgI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xnmdgVg1CLcfOIsfGevpRDKkvTAKbT0pclx6ax+aA3TfLT/4+knvJ5T/NIHoVcVOYNOb79A2mOsigY100FzBfoFJUtwLKH0jwgJ5mKCSk79inMn5oB9Z9MSy1bC83wWaIVSD9VVoM9eALRuBHYGiYy/9HQiOEv9tzVaudhsCHpy6ccFQHLgW11CEV2et0XO6WiM79Ec02IiGP/pUfG0QeK7xIf2zYC+np9BfuQprmNXHEKEm8My3SKNoFhX5d5+HPf/ViRooAt91ES0UJdMnKOodH+NXxQ0cm/+LagVtw3YZFUZ8J9JBf6RGGw7weJRladI43Z/ptde3cizV4HIkkOrqL3I41s0VPvrZxB1iRoYgChQQhRPerUIshWPOnF9KiIGmEcJdvC++TGiYUOJIn4NFTeX+4cG2hgo/B9M1VfS/WzdR0ynq8iJGbg48hq3VVRAvG8jgWYAsrBnlDp17VK8XQAMjbDYwq1Iwwv1oZRa+zEuf2BFF+Hj5IX7bS+vF4ob6WOMIonsozoaemSdDTvuR2LLh3hSLbgIAoJIBDokbPnUlstmTeM7PO8yNpHbD3nYoIwcliEbsUXdMX2dCGRXrUP7jGsbS5GuTKGJ4WZs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b5e53f-64b0-41bd-9de9-08ddcb5346f0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 08:14:29.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPJDUdom28nczya54mmkuusG5hGOIWYTDgi9FcW232vrR4J+R/KP1QphC8MVTt3K4Gsxg16+1LbrMxZcbp1VBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA8FAAE4F4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250069
X-Authority-Analysis: v=2.4 cv=ObmYDgTY c=1 sm=1 tr=0 ts=68833ce8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=i-RkcS5r7ubKPWYquHAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: X2f2cX9etCXWB1-X1ojkJ5muYysdYzYz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA2OSBTYWx0ZWRfX+POiJdI62BTQ
 4XoB4XzSG6G7xbpi/t+YNRP7SvBJ1/WyADJXhl6POOAXhiA+aD11lsOYFquMS4He74/NJ8szFVF
 nwTlglTQySlNZgvDB4hZ4pZD6fYK6lZKpmrkIL2gOmJV86/dktEtUhHher7n+e3SHMMo0YwCmc+
 T4jMpKbm6828ydo5yjgvfld/jcJmCB/IqjuQ4Mb/Pz3b94WO0BQuJqhUO21I1ZWMaBTa7LoGnZS
 q8scCE+B8Tcq22ahjjEH6Ay7jEIhgFEqhHPZv29+L6ywtNuqXI5Bb+zgxD6knpkrKyzC77E9szs
 E/8PQvxdxFYsRi4zngVirMC9Da5aaIupW9D595mqFpIt7Zv8HWAYw/Go/bPEv7Uccdr7ENHZrsT
 q82Tc2/XzdCDZl/3yFP5NEiQtwkhTnwJ8qPQq0zdews4BnvbCaa4bYOsiBCUkKOjIEaL5QL4
X-Proofpoint-ORIG-GUID: X2f2cX9etCXWB1-X1ojkJ5muYysdYzYz

On 25/07/2025 07:27, Ojaswin Mujoo wrote:
> On Wed, Jul 23, 2025 at 05:25:41PM +0100, John Garry wrote:
>> On 23/07/2025 14:51, Ojaswin Mujoo wrote:
>>>>> No, its just something i hardcoded for that particular run. This patch
>>>>> doesn't enforce hardware only atomic writes
>>>> If we are to test this for XFS then we need to ensure that HW atomics are
>>>> available.
>>> Why is that? Now with the verification step happening after writes,
>>> software atomic writes should also pass this test since there are no
>>> racing writes to the verify reads.
>> Sure, but racing software atomic writes against other software atomic writes
>> is not safe.
>>
>> Thanks,
>> John
> What do you mean by not safe?

Multiple threads issuing atomic writes may trample over one another.

It is due to the steps used to issue an atomic write in xfs by software 
method. Here we do 3x steps:
a. allocate blocks for out-of-place write
b. do write in those blocks
c. atomically update extent mapping.

In this, threads wanting to atomic write to the same address will use 
the new blocks and can trample over one another before we atomically 
update the mapping.

So we do not guarantee serialization of atomic writes vs atomic writes. 
And this is why I said that this test is never totally safe for xfs.

We could change this simply to have serialization of software-based 
atomic writes against all other dio, like follows:

--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -747,6 +747,7 @@ xfs_file_dio_write_atomic(
        unsigned int            iolock = XFS_IOLOCK_SHARED;
        ssize_t                 ret, ocount = iov_iter_count(from);
        const struct iomap_ops  *dops;
+       unsigned int            dio_flags = 0;

        /*
         * HW offload should be faster, so try that first if it is already
@@ -766,15 +767,12 @@ xfs_file_dio_write_atomic(
        if (ret)
                goto out_unlock;

-       /* Demote similar to xfs_file_dio_write_aligned() */
-       if (iolock == XFS_IOLOCK_EXCL) {
-               xfs_ilock_demote(ip, XFS_IOLOCK_EXCL);
-               iolock = XFS_IOLOCK_SHARED;
-       }
+       if (dio_flags & IOMAP_DIO_FORCE_WAIT)
+               inode_dio_wait(VFS_I(ip));

        trace_xfs_file_direct_write(iocb, from);
        ret = iomap_dio_rw(iocb, from, dops, &xfs_dio_write_ops,
-                       0, NULL, 0);
+                       dio_flags, NULL, 0);

        /*
         * The retry mechanism is based on the ->iomap_begin method 
returning
@@ -785,6 +783,8 @@ xfs_file_dio_write_atomic(
        if (ret == -ENOPROTOOPT && dops == &xfs_direct_write_iomap_ops) {
                xfs_iunlock(ip, iolock);
                dops = &xfs_atomic_write_cow_iomap_ops;
+               iolock = XFS_IOLOCK_EXCL;
+               dio_flags = IOMAP_DIO_FORCE_WAIT;
                goto retry;
        }


But it may affect performance.

> Does it mean the test can fail?

Yes, but it is unlikely if we have HW atomics available. That is because 
we will rarely be using software-based atomic method, as HW method 
should often be possible.


