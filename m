Return-Path: <linux-ext4+bounces-9201-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F063BB13747
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jul 2025 11:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9BA3B7DB3
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jul 2025 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC66223311;
	Mon, 28 Jul 2025 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dRhfqXNC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rD8QwCSp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D61581EE;
	Mon, 28 Jul 2025 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693801; cv=fail; b=dbQJvEbFB7xRPZtAcI95Lidb0Frcx29qM14iUML9GwVnGrfH84JyFFjkXiMzvAf5MLICEQQNp678Xj9xiTlLBTqEPXlnB/HYdHbGyxXgJBXn1XjdU+m6jsTNsXbxGozJVAEgBhJDT0WdREESfSBnjqSSDO9R2ZVtbQ2yyVZZMwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693801; c=relaxed/simple;
	bh=4xGIEf9JNrAeeYhxeFhyrRHwO7rvN189G66zBhlmRmI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r68Zrqro4wExiaIA2J/EGYc2yIqeAJDlQmpuO9HGMeLZ3tXwMo/buELqgCK4X38SiJ2T/fHcnlF7nBf2SEp7Z9EbrjhI3A/xPmwkd8bfuObQeZhRWueUlhJkw6nifHTB45C+Vm+UmSmVbRlzTpdEuEQAFtuZWQo2KxxyKLhu4bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dRhfqXNC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rD8QwCSp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S7g2U5025446;
	Mon, 28 Jul 2025 09:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5GJE4UG39RBG1XdpeUfnl/RteaDCXSTB8TpOC29qIrk=; b=
	dRhfqXNC5ZC8wrvQ0KKxu6AH/eW59zXBxQrjxFSDj6xx8I986gjsm570yKvO9Pg2
	9t+ASzQqRsMk19wW4PMmSQMb7hOGZHLBC5ZvOQ6OwZsloZ6StJqFix0kNIwgtk7r
	m/Q5NCPHPjSfoHLbtGuJfGpw7Kfdqkczn3qdufMfVaJjgNCKl7xlof8AiMS6GzDb
	WQXmeHnTSlMVyNMAR9DLNg+UX8Jd/MLoEoyCNl73XJHf3j4/9ggI0yPHZY5ZrceN
	YtvLeV02fEh+x0wLRqrAT8IOaDqeji9qbxknEoxgdGUZRlVBXdkxo0H/dTIA/wp+
	HnG2b352T5uWtK7ln6bjuw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q2dttq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 09:09:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56S8Z9Vv002473;
	Mon, 28 Jul 2025 09:09:51 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf89rdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 09:09:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyXjWLny0FXZerqwNI1EfT7HLNYKLqAtMN8Yq8Uzxvp9EtM40IWix2u9aySO/GaXKYY7lrNZwQzZHidflRZIXBHMi77eh4D2E6r32DNrue/EELyI5ECm01n5URqcaLoViIL0m0DDh2vYD1mKOBQ6xc9eUr7qX8TNY8SfnrNe7Uqze4uLTPTOxWYptNLPOzKSOJYsIHzec7Hld+OuoeWO95eFW62V4lna6aq302pTx+O5pv0lvaOMojBJAisfT4xk1bG4WIiv8o1xH3TIk/MVHrOsp/O4mt3t97J/HvXAtnNS6JHVfo68FjQSvXgquc0Xu6cuk1tIVpWAXuGSrLmjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GJE4UG39RBG1XdpeUfnl/RteaDCXSTB8TpOC29qIrk=;
 b=mytXrCo/JgMTA7hvzAsf/VCOV4kU/x/VNG6rz9Awmb4Altqi93AEEKpdUHMt6Ax/i0c20ptQyJHXeqYsCdENzOZJ29KmKlE5Z6+KcOCDYDLL71F2QJ2Uf7qrHfiZZrJ3agSQlWBJTNSUJ9lHjyI2MzC3Vwo1/tWFVEn3C2HG3ucH2daNoSbtGkX61sMmFwRT9b1i2YXUxNhLtNFeY2N3mcvkFqg7w7vJmc0HpSE8xueXVwMHxLtvK3f7zUDJWMtvDweIMJh950sRPPRJG723rdTdYE6glYh4MD4P8QMwIUlIiUaF5vugtc1Bw3J/FjQZYokHV8RKlmSnksC/4Fx70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GJE4UG39RBG1XdpeUfnl/RteaDCXSTB8TpOC29qIrk=;
 b=rD8QwCSpnrixsiKgg2uVtn6MOcIh3OOjxn5+EY+4wD/+75N+B4d0mhXR4ZAJ8MEbK8TbkgUfJlnBA08Z3KnPKTnQaHOAWQxrBI33NLT3cm6lA54IafFeEuK8WuMrl83fzYcZF492BUi74R4PdqDl1d/TVx+UoPgtXyrr4T5Jg08=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by DS4PPF072D269AC.namprd10.prod.outlook.com (2603:10b6:f:fc00::d05) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Mon, 28 Jul
 2025 09:09:49 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 09:09:49 +0000
Message-ID: <2ae4bb04-fbf7-4a53-b498-ea6361cdab3e@oracle.com>
Date: Mon, 28 Jul 2025 10:09:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <1e6dad5f4bdc8107e670cc0bd3ce0fccd0c9037a.1752329098.git.ojaswin@linux.ibm.com>
 <5211dff7-579b-48ea-8180-72d8c6083400@oracle.com>
 <aHkAJJkvaWYJu7gC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <b270bb66-721e-4433-adaf-fe5ae100ca6e@oracle.com>
 <aH9PwFm06n9KQ0mE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7fc0f04e-dcec-47a4-b522-eb5a8b90637c@oracle.com>
 <aIDozETJ8aLparYV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <9b9ed959-bda5-4a92-90c7-a621ffe58240@oracle.com>
 <aIMjrunlU04jI2lF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <0af205d9-6093-4931-abe9-f236acae8d44@oracle.com>
 <aIccCgrCuQ4Wf1OH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aIccCgrCuQ4Wf1OH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0006.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::12) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|DS4PPF072D269AC:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b0c0ec-3e83-43ee-5fb4-08ddcdb680cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnJVeDFQZDdtaWRBMGZzL2xqc0s5dnNCSWYvMVMwYVFudDRHMkFLaWFjSVBG?=
 =?utf-8?B?bG5nOVg2b1J6Z0U0NWR6QjNvaVZJWjlhQ051OWtFZ09wZ0x4d3d6UG55QndP?=
 =?utf-8?B?MmRVMTFIR29ZcGZPdzh4YUR6dFBhRGVkV050OENwWEIxZWh0TXJmSGVLU2NG?=
 =?utf-8?B?cnBrRGRHU056NVd3SkUyMkJVUkY1L0dHMWkyajVJeGZmUHpla3VablozTVVB?=
 =?utf-8?B?UzdTWjlHWkFSeEpIR0Z6dS9jUk8wZG5zeTdIYkplU0Rsa2VFTDdHNTNPcWU3?=
 =?utf-8?B?RkR4VnM1b0dzSnArNVp0TzlUeXlwUWUwSDVwaHNRTTRwemRhU1A3aXp3NjBU?=
 =?utf-8?B?aWRTQjIxQ1grRDF5ZEJoanRENjN2QWtNVDNLQlVndVFPRU1ydHlEdHBDKytu?=
 =?utf-8?B?em1RNDZ3UkRNVzVRQ3BGZkdrM3VONUkyNlU0T20ycWNkUmZRRzZoSEt0VDJn?=
 =?utf-8?B?dGhPcUgrTUxTc1NVWjBBSWVWaXcwcjVMWnhmUTYweHBDcmVFOWl3RWlkVHJu?=
 =?utf-8?B?bnJpaWZmbm5pTGc3ZlZHbS8yNU5BYTJPV2YvWThtY3BqeFBkeUUvMTRiSHVT?=
 =?utf-8?B?VUllWVZTQkFoTGZKQVY5RWw2TW5UeGg3aHFFeEJUMmp0THBRd0NNNmF1MG1h?=
 =?utf-8?B?VURzaTUzTTFQcUdORGJGLy9HMGYydDZsVHlISUdVNlRraHpsZ0dFZHRIcWhV?=
 =?utf-8?B?eStqcFhRLy9DL3ZzQmtORE9Ec0RYY2YzenY3VDdRVEs5c0kxVUdqbnE1RmdD?=
 =?utf-8?B?RU5mNnlLdEFaUFc1YUlTVVBYVzFKVXhqMHY1eDNKL1RmQXVsdDJhTkJYWU5R?=
 =?utf-8?B?WGRzZkl0RmRlSDFrWFo4c0NyUlhjaWl6QWoxOEZmZWsxdXZVWGJ2NWZPN2pR?=
 =?utf-8?B?dXVhcEx2TW8vVmF0bk1iSDBXeHBycXJGSEpoS3lpTUg0NmxSeGdnMGlZVHlR?=
 =?utf-8?B?VW03OGtDSzJPbW1uK2ZpYWNiSk1JelgydkloUEZDdElyNFRjakQvdVJ2MXNx?=
 =?utf-8?B?YW5Ed2grZmN4UnZwVDhjWFVPUi96d3JJdkJVckI1cUdveGxMZkl1YkNJQllk?=
 =?utf-8?B?SktSSC9NbXg2WnJueERMSGVMdjA0NG5IMUUxdkY0alBIdG04UW9VejZXOFJP?=
 =?utf-8?B?VWhDY1ZqS0VHTzFsVnVZQ094UjZzQXNMMVM2YlkrZHNhMEZiSHVYVDVXSUkr?=
 =?utf-8?B?eWEwbERzZnE5SndwTllCNnFCK3hyYXBaK0ZDQjVDankrZHdjM1lJeWVNNVhS?=
 =?utf-8?B?S2V4N0cwS0FyUnZnemhTL29yRGJadnlZdnhJWTNhQUw2ZHAvbUpoYnVZSmkw?=
 =?utf-8?B?dWJZeXR0ZEM5b3d1NjcxVTYvMSs5TVYxakxWMlh3RXVoNmZ5MGFKcUo0WVhs?=
 =?utf-8?B?MHEzdHVxVEJQYUl1bUV5RzB0VnQ5dVZScFY1TG1NalBIS1poenlRMVZJS0JJ?=
 =?utf-8?B?TmR2M3JGbzFpQUNHd2FpU2JoSklZcGsrdDBGUGZrNUdsTkkvTWE4UStCN0hk?=
 =?utf-8?B?d0pTNDUzYzV1d0lQZmJqeHV5a0RLalF5RjNORlpMR3FkNkVhMGI4Y21RN0RD?=
 =?utf-8?B?ZHM4dGZEaWRIelpYRFFKSFVDdzhmSURJZGxJcDlaTloxa0NXcHQyZlBsN1dL?=
 =?utf-8?B?akZ0RW9EMlFaTnlSb1pWMHI1bVJGVDJhQndxUVVJM1FpYkMrd3RwcmV4aUhS?=
 =?utf-8?B?VkpMblNhZUo3NkFZWW16K2tpa0lyaEsvOGFKM2ZOSXRRdys5VElmZzhsbSs0?=
 =?utf-8?B?Z2IzMkdpOXIzamxURGNWS21RY2twekczYjJ5TkovZ2FHcFR3TnNTelp4TTgw?=
 =?utf-8?B?NlBlYmlCSFZVS1drbk9IMy9MWW11Rk5sVlZkdFFJd1hDNVlWbHYrbXY4RWEr?=
 =?utf-8?B?c085ck9jc2FkdGZFRG93eEtic1hBdUZEV0orbW15WlJ3QS9uTnRlSVJGVXlV?=
 =?utf-8?Q?K8lB//uRYn8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW5odUlIaXArU2tVb0pndTNuRXhoQ0ZzYmFZODFIVERuY3FDcVNPRnphRVdm?=
 =?utf-8?B?UklYNEtiRjlTNWtyWnJDZEVKNVM2aG1tK1ZsWG8xZDRobGVSajBmd2o1SWQ3?=
 =?utf-8?B?ZTFCTUFPTWZwY3MybUdpOW51bDN6WTQrNEFWRGVzY1R3YlV2MU5rdFZnbFJ4?=
 =?utf-8?B?OU9IRmo1b1ZwQkxQLy9KcjdvRXR5RFVWTjVmdjVWSy9RTVRieXlzREtOcFk1?=
 =?utf-8?B?K01Ga0o0YTRWc2dYZ2Z6SU9YQlRJeVE0Mmt1NDRBSW5oalhWODdoTG5FS1lz?=
 =?utf-8?B?RnJkOWpJWG54ckxRQTlsUVN5V2F5ZjlncVBWVytsYzJCRGlYSm5NRWdBTFF0?=
 =?utf-8?B?Qk1FUVRvb0Y5MmV5UlByVnZraDVhd1hnVFFwK1J6NjdleVdmVUQxVzVhRFUv?=
 =?utf-8?B?YUtxYmVORklSUUhQNEFDM2pDeC9nUDJLUDlxR05kRUViWnlzb0R3a2gvVlZ3?=
 =?utf-8?B?TVNwNzM3emZYWUllK2NqRW1Pb0w2M0w5UmtIK3FnL054SEJ3SkNBNTh2c0Jj?=
 =?utf-8?B?VWhCT2h2SUtYUVZNd3MzL09Kd1dRSDhpdUc0U093VGhBYklBRUlteU1PODc3?=
 =?utf-8?B?THBPUU1nQ0xBaEdFY0lxc3loeSsydndJbVRsN3RJakVYR2ZLem40enZzV0h2?=
 =?utf-8?B?bDNFUlcxdi9sN1AwOVFnVnhjbG1JUDZDUGVzMGxhNXlBN2ZFQnBGRStzZjRz?=
 =?utf-8?B?ZndPU0NmZVhBOWZYMzUrMCs0M2VteUw2SHVKQ2NJdm9wNXNPQUdKbHRzMkhW?=
 =?utf-8?B?Y3o0STZLS2dLVHRtSmF4bTE2WHh1THA3ai9XRm5QYmtST2lUbFpZYzl5V1Rh?=
 =?utf-8?B?OVZlN2RFZG1ZdXZKVFVQeGxKdkhvRWd6cGpVWlVJYjN2Zmt3bVljc3lzdnhS?=
 =?utf-8?B?VjlsR3dQRUtsQTBxdUJMSE9EbXdocXdlSnZra1h6RzdMVEJ0bGpRd3NPM3BP?=
 =?utf-8?B?RE9KY1VvT1NBVUQ5cDNGdG1JWTl4VlcvOENKU2dMMFh1VWdrY1RObkNnMlZV?=
 =?utf-8?B?Nm9OMWltb0pzZ0ZveG5MSXByc3RsMlY5Qm4xYUMrTGpKbGFEMldzL0swcGtX?=
 =?utf-8?B?ZmtYQjAxSmo1dDNYblFrQVZ6ait6Rk5uQ284TmJ4Vmcwblo3amRmRGRYQmJU?=
 =?utf-8?B?MGhSaHR4MHFpaUl0aS94aTB0SCtUQWlsTU1nQ1J3UVRiU1BqRWtycVptV0Vx?=
 =?utf-8?B?VlJJclZ2S08xbVg5RC90Snl3Q0tkdFB3dWtJUkJsMXhodnp3WXU4YmRTUytY?=
 =?utf-8?B?Q3dOVDZhdUhsdU1rblJpekdNSTJHOVhUYXB5dkdVZVV2cFFldFAvRjdaWDVB?=
 =?utf-8?B?eHpObUozYzJ4UjhJVVNsdVh4ekt4enhrR3dYWGhQUGJjdW1UMjd6cDZXbnhw?=
 =?utf-8?B?SXJEQndoUVF0T2graUcweDM5ZHJEdE80MkRpaVpLbTM2c0xXb29LbnZmV0pY?=
 =?utf-8?B?aVlQdXNRN0RMeU43NGh6YkVVTmp0Nk03bEdtdElMMnNyWmhRaFc3RkJGcjR4?=
 =?utf-8?B?blgyVmdKcnFDOUlmT01hT2VNK09vVE53M1VwM256WFZFZVUrQ3dlWDhXOHdx?=
 =?utf-8?B?cXJiSGlORm1SM09NYXNXdUVoNDZ3ajlGNDJtQ2NBZnVzNDhRZ08wS0NBVXBY?=
 =?utf-8?B?R1Fhb2MyNWd2ZnN3REMvWnY3cklyL0NhckJwMklOcUdYaU82WmlmTU1pR3RO?=
 =?utf-8?B?am1UK2tDNkRuSUNpRElQWTVNSjU1Q1FFS2Y4bzJpd2UyWEpRd0szbVl5dWcx?=
 =?utf-8?B?MnNTWlVKblFEYU5wNGE5REg1eXB1a3FMcS84KzV1TG5jM3BGUFpNWENNeGlX?=
 =?utf-8?B?Vk4yWEJnUUlmRWVEQWRmc0pTY0RHeDhYTzVlS3lzdDZIN2xQZk51MVFGOG4v?=
 =?utf-8?B?QjNxazNKMkJGbUpVRExaN0JYSUFnbTFpc054WDlrc1RRNm9TVjQwbnhEaElx?=
 =?utf-8?B?NitSQ052WFR2eHExeWVqT2IydHE4cGZrZUIzNm8xeDY4NFQ1QXp1cWRMQzZG?=
 =?utf-8?B?UVpVaXdRZVNqVnJ5aEQzUzdRU000V2k5MUVSc2c0dVlwK0JHRkxVOEZ1anFJ?=
 =?utf-8?B?Uk51amQyNkNCanR6eDV5SWw3ZktpcitzNWpZeXl2ZENoTjF3K1VLVk9ubkh5?=
 =?utf-8?B?bXd3WlhiYm5WM3JJd1pML2xXYjU4dC84dHRkSHRLcitYeDNEWC9IWHRaVURx?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HTffxQ+SF4uHHS5pUQOnn8SFwL6pINxIeTUkRHcC9DpajBy3HmxmHC/yWrmJQVu/dy4avX6DhXdAvRMaI4eB5NZycGFhqjmx5asTboGrHDHHNZiFP5iyodsN6vkjYncOKZEFnxMwpYVGFWWLpMEM6lgHQr/DQHNY30JSnSCb1Du3rILetDpfhvqhTmA6mV1ZWNrfQoR6Oy1ZuuFkURAxnDANCifeIDgFz7ca8za5sZVIPUh0Jx8V3ShGALZy2M9YeI1eoqR8WI++pBF4I/tJsMMvC68vkbxc+1RmCmZNHJo4L1uLemS1mVxsIuofpMmp9mcaf9gQo8/9yA2b0e7hlnOdZ3RGFgkB/ONkm8awwpuS0Xzc7qWSfW7S24fhGAfQEUaAAFn8DLFEnR24kmcwtI0aUqdwdOrwy+3MPrzxW4InYZhKIwHfbo5LFXn2nmkki4hFHaOxr2zJ4Ey960WfDhL6TuO29uJKJ83YBqDuflC+MykfrqvajYP40UObivNfoJyBbJDMt+y0fPZHF+0PtlaJrG4VTF3Ii0QpZDgfg5VeU+bMSM7sPuP3pQSWyKfiN/GZfT/0iHBS4a8tHStk9KECjPK0ZruPaEtVCW0vYQ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b0c0ec-3e83-43ee-5fb4-08ddcdb680cb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 09:09:49.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6yEZu1TARsE4XXn9H6VUbYPAqXAzuPGVQiBpkGFw3Od4g5bl6wSXkDx0XwNztIsgyjzRyL2q3x97xGpoKov3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF072D269AC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507280067
X-Proofpoint-GUID: D8gGi0kPCm9751OL93Drx3-uFZ6pUAvN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA2NyBTYWx0ZWRfX4iyxwsyUNwF7
 VLO8aeEnHX110SDgS6Dc1OaRXiOryN2S+ezndaEf6+Ss+Awh0dRvJuFiAfjHS0gjiWN+l4YBmcT
 TgZDOe927HfMYSyuA2m5mkn7sZ1iL7LAZ1CZdABdGu1k5WzIgk+drQhMpcnrEtDC9Ov/AWJI/rH
 5yHlmq/6sWlAjw2e9/IYpTJIigkUe+Sg9jj16Hni1+TCEOKaug6WpXnJVxfuftnD4Nc68el1gM4
 3Vz7zauUl2EIUkZXEjuQknU13SZkle2kKgWVRRPUAr1xMd0eE0VCscjXEevIzCL2yneiPTqvF6C
 eC/hY6YJR11bz8Cga7go4Fj1uyjKBnko81eaj6mBJgaHW61OcB6lpdZZ2Zl/Vdnl6s02iouD0aC
 PJ6Z5xFuzI0wyfwCQ/noGAiepomyESw8K8rTvJgCGZK6jhAOy/j0UpqcAJEjsETVp8kP1kMe
X-Proofpoint-ORIG-GUID: D8gGi0kPCm9751OL93Drx3-uFZ6pUAvN
X-Authority-Analysis: v=2.4 cv=A+5sP7WG c=1 sm=1 tr=0 ts=68873e60 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=YvYiyYeEQQXuG7C7p0cA:9 a=QEXdDO2ut3YA:10

On 28/07/2025 07:43, Ojaswin Mujoo wrote:
>>> What do you mean by not safe?
>> Multiple threads issuing atomic writes may trample over one another.
>>
>> It is due to the steps used to issue an atomic write in xfs by software
>> method. Here we do 3x steps:
>> a. allocate blocks for out-of-place write
>> b. do write in those blocks
>> c. atomically update extent mapping.
>>
>> In this, threads wanting to atomic write to the same address will use the
>> new blocks and can trample over one another before we atomically update the
>> mapping.
> So iiuc, w/ software fallback, a thread atomically writing to a range
> will use a new block A. Another parallel thread trying to atomically
> write to the same range will also use A, and there is no serialization
> b/w the 2 so A could end up with a mix of data from both threads.

right

> 
> If this is true, aren't we violating the atomic guarantees. Nothing
> prevents the userspace from doing overlapping parallel atomic writes and
> it is kernels duty to error out if the write could get torn.

Correct, but simply userspace should not do this. Direct I/O 
applications are responsible for ordering.

We guarantee that the write is committed all-or-nothing, but do rely on 
userspace not issuing racing atomic writes or racing regular writes.

I can easily change this, as I mentioned, but I am not convinced that it 
is a must.

Thanks,
John

