Return-Path: <linux-ext4+bounces-9162-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEF2B0F142
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 13:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A56AC75C4
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4702E11B0;
	Wed, 23 Jul 2025 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bYA/4/5s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FSk9R0nH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68042212D83;
	Wed, 23 Jul 2025 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270426; cv=fail; b=PMPfk5jNt132EkVetYHD6ETyIlT3+lhrxSS1esusfDYE2xDmQgmwUWlqXFp56tp6eaekF032HPvh0O2rqNIyRCtHBNBBTMvERtvZtEehi/iZR8YXuDkOEGT/cRbFChy5VJRUkdliQ7sLk+DtPCItqAPsaSSPiFURiIOZei+Dlyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270426; c=relaxed/simple;
	bh=j/IjkhGu+7S19xzvTmu6zPxksn6Tq1R7f0qhMFzAbJM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pNIr+e+bP41nMaXHIxWS6Flexh22mh1l7HaI+J2UeRzeRkWtaS/SKbTZZrCYWjlebJ55r7Vm0I3ktvLBoVY5YfBc/agkHhB2bTHDPDNGaUpCYieBbA+jhy481ITZgzCVMsxO6KaW2GlDzfK3srGtnwl0KJF52EinBrGT8/bYGNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bYA/4/5s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FSk9R0nH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8NHpG023490;
	Wed, 23 Jul 2025 11:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0GuDvcwNQmVjFjGtzU3BTslYQ5BNL0D2Lo3wAqZYVv4=; b=
	bYA/4/5s8VjjYul2Zxz1XL+kwVTui/zt7Czp4vRzP9q/iUsdZSziAPxl48gh9ns2
	Rhd4Emr9pWRYnL0XPlgLIMU5i2l0yVi2rtYqT4dKYBkSbOXpw9M3eE1wrhHV6Lop
	jzaGQRAgETkbLhM1phrIEeIG5dwx9CkARGvzLklpA/VnwI9OPqOAwlR7nYDWidXq
	EaufqP2T6NiqKtdQAMXF3FzLmwVdqqtZ8JRfu0NHgU8FLFMDa/hRvqfEemauXqTH
	6u4L7FcaUjWZf0yYL8ZB7wgjRS//zYZfCpJhO5EgFvQbsxI/nYUgBHeUGyiy12QR
	y/mxwyXRDPgZjO1z6NOgAA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9qcnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 11:33:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56NBPZh2010263;
	Wed, 23 Jul 2025 11:33:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tafxt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 11:33:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2rKWJ4qJGguJoQUU5TT/YWFAcYEoN074/fYJrdqQYCm+4oIFpl/VbRx57AcH5UXTSnw91PxUR/QDnEvNmKUa9X4O9o91Vh7zvfDhUpLd38z8KT6PCzXRGCEYYEM+92QQ3M/rYeUITUdZbmIxlyBVNJSHRmCCgt74+D7vaz2UnfsQ6z9g+uH+CcvV77/qT3PPsYMLUgYVYnY8WX2Jn2eNffXaLg84Jz6yLSQkSbYdhMCV94irG/L5mfWZdt+qxxfpQdudTLm4AmdbiPXbPQxN8oauzxE743Dm6WFTfRMu/tcoMtllwlOHIQpeby3aOfpDh8ZnKthZbRCl6YHQmmY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GuDvcwNQmVjFjGtzU3BTslYQ5BNL0D2Lo3wAqZYVv4=;
 b=Sf15EAF6eEGIh6tLBN2lkYF21cs8yZR6qQhO4HevVyMeFqRsXZYrRu/M8HxY/prJIHD+yUM/ZYPc+ya9XBY8AW+AII+uDUUeuNEhEMNdN2JMFAgZa5BQ9SOHn09+/xSCgn6Zk0gczT8A0aAMVImbmDGUa1mME0mumUrghiaEP2P1H1QvC7QdbXzdYjAXtJFhwKDQNpkRIPXqJ/vIL6YfXVhl05CbHzDVKwba27l+bdyPMZK0y2ELlmccjlX46sEeTC3Rio5tVkE7GXi2BpJTFXOVPHTPgSXm9XbI0bTy8G+/g+/t4FdMTR6gLt+3QuXgtWvr0ZSbXGSoQMOW7tbT+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GuDvcwNQmVjFjGtzU3BTslYQ5BNL0D2Lo3wAqZYVv4=;
 b=FSk9R0nH/vJBfSHguxO1SkYEMr/G/zY46Sz0eW4S4El1u7caElG3aP6yhXis6wxu+6mbqYbD2Jshv9bKrJFeU/FGvZzyTF08lCA71W3N799s2xVzfmzf91c97wnQ7SMJ9lMVP/JGNwYmBdu/TSzqh5N+Lohg8lIYazKvCeFsKVM=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by MW4PR10MB6345.namprd10.prod.outlook.com (2603:10b6:303:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Wed, 23 Jul
 2025 11:33:30 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 11:33:30 +0000
Message-ID: <7fc0f04e-dcec-47a4-b522-eb5a8b90637c@oracle.com>
Date: Wed, 23 Jul 2025 12:33:27 +0100
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
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aH9PwFm06n9KQ0mE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0075.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::8) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|MW4PR10MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3deae6-0a56-4988-96ee-08ddc9dcbf95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OE9nV3Q3SU96TVpjd1o2YklkMEhUSWdsV3F6QnNycUlRNnlNOWVIQ3JNWFlq?=
 =?utf-8?B?aXdQc0NZdjF1OWt3TE5EQ0dERVk3NXJQSDVSbnJJc0hGTy9xdVdsRDhHbGtZ?=
 =?utf-8?B?SFhUcFV4cVNWWnZtUlF1N0NnRmlpUlVxcTRxME1MbThOT2V5bWJFQm96MXFu?=
 =?utf-8?B?NnZsYzBPTmJCNXBHYzNDRU1OTTNjc2t0RnhQWVh3UW1sblVGM0w4Q2NoallG?=
 =?utf-8?B?THJ6ZGFyUXZsakl6aEN1bEpyc2hXTjFYeTBadmF4SzBQTWRsTTRwQlk1bSs0?=
 =?utf-8?B?eWxmclBFT3ErdzhRUFZVNDhPSVdXWlBpWWZ2MkphZkdpeWVBQ0dBUVNJSXd5?=
 =?utf-8?B?UDNxMnB6blFiSld5OVFQb29maVFoS2doVTFFK2ptU0RidWFBaEtWZkVzRWtz?=
 =?utf-8?B?Q1htdEd5dmh6VHBjSUxvNVpPa2FvUG0wR2YyTVBNamJ3M2dtU28wSkxRNklQ?=
 =?utf-8?B?ajRBd3dLUjVlWWZvcCtxV3dMcCt5aTZHYXA3ZVd3bWZONkZXSG1rVmRWektD?=
 =?utf-8?B?UzkzNDcxU1dxd2d4WVNlSjRLREl4MUd4OEU0WUw2d2NrZlYreTRaMlZreWZP?=
 =?utf-8?B?REtsYlo0Tnk5VHdkZ0hWZVluVHR2akh2TEJqNFVQOEZVNjVDZ1A1b1QrRlFR?=
 =?utf-8?B?bGE0RE5XbjFQZldJNjJWTGd0eVcvUzVpQnorVm9UUjl1YkZrcm9kUkZkcEdm?=
 =?utf-8?B?SEhxSEJzeDBJdjV6VnZCQXU3QXpOU1o4U3oxWlJYeFpJdWdHLzlIVlR6S2c0?=
 =?utf-8?B?NzM4QldiUkRjc3lCWEtONGRsUGExZWVVdjJZU2ZaOGJOa29DRzdoZDBCbjNl?=
 =?utf-8?B?SGI0aHJkb1Z5OE9FdklyNXhqdVVvZ3dDS1F1K2ovZ0d3R1Ezbms1T094TVV1?=
 =?utf-8?B?bmpIMG11bE51cmYzYjE5TGg5MGtVby9kL0dqVTY4WkEzSzlxcEMva2pORXdJ?=
 =?utf-8?B?ODNxclRSN3FGQXcyZmZ1Wm5kVE4xbW41dU1UUVdyMTM5cFEzVVlIejN5MDkv?=
 =?utf-8?B?QXI5TE8vcXZ6dFFuVWFMa1FTSTkwMWN0SStCTVNwMVVVQUxJOUVvR1JDSGla?=
 =?utf-8?B?WWJjS09ldzVVRVY5U3MzcFVSamdmck5RV2JTNHo5T2pIZzlxUytiY0xWSlBi?=
 =?utf-8?B?d1ZJTkZiQkxkY283ajRQQVNqSjlTaG9VUlUvSVBveWtsRWdpdHdtT2ZtMVBH?=
 =?utf-8?B?LzFLVE1pcUlUR0pBU25SZzcvaUNtcFJ1eEpYZmsybUtlMWxsYS9zeU5CY2wy?=
 =?utf-8?B?YTIyVlRRVFpGQlJYQlZjbnJ1M25uUlY4TVJZMDlmZEc4VE9KQ1NTQjZTd09k?=
 =?utf-8?B?RTJvS0doUFhJd0xlTE9TODNsRURxOXl2RkZ0YjMwN3FpUkNKemNyYXY0OWp6?=
 =?utf-8?B?VDgxVWQ0UnZKMVRtcDJ2cXY3a25EejNXVjFINXBXd2NMeGpoT2VyOUtWdzJ3?=
 =?utf-8?B?bFNnZFdBMCswd0hFYzVKRTFtUWVpT1lpL09NdVBBN2ViNTRhZUNkdElRRlVw?=
 =?utf-8?B?UUpzSGsraXAvWU5RR1FwZStWRFJaUXBSNU1rUDNzOS9rTnJDbE56YVVHQzRu?=
 =?utf-8?B?K3Jwd0JjNUQyMXphSDljNVl2eUM5NFM1OTkwWFUrQ3NNUjdycmlJUUFCL3NG?=
 =?utf-8?B?M2t6RFdSa20wUFVlNUNOWnRUY2JDalhoRysreThmMnN6MGx5UWd0WVNBTXR1?=
 =?utf-8?B?Syt5cEpWZFNteTZGbnY4TkpKbkNWN1c4UmlXc1Z0QnZuUjRxVGU0RTFKREZ0?=
 =?utf-8?B?M2JTanI5Vm5KbjFiM3lUZ0tMeGN3TGJpVnE5MStCc0ViSHhvb0wramtTL2Uw?=
 =?utf-8?B?VlVUWkovaEdleFhLT2dpK0dLNjlNUUQ5RldWanFtVlJjdG53a21JSHFsSHd2?=
 =?utf-8?B?VkQ5OWZRNjczY0lGYnhEOXNTM21BWGRVQUh2eE1qeHVRTXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVdQQ1ZxRlJTQ2lKM1NSSkdTemRXdGl1QmpYeDVFa2UvNUswWXVHYWE1WjVk?=
 =?utf-8?B?MzM3TXFLczNwVzhxclhNcEd5RmJ3Q1lFaDJ3cHdqVU9JOVJDc1JGQ0ZUZmI1?=
 =?utf-8?B?cm43YzNwN3pYYlZnQVBkejQzdDJGaTIvL3BnWVlteTFmK0ExdTErQkR5T25Z?=
 =?utf-8?B?aWk5S043MURzemlrakxOZXdOZUg4L0tLVU9CVWsxNDk0TzZkbDRuSmUzVEhy?=
 =?utf-8?B?RTluVkdUMGovMndGc3lVdmp6Z0dNa2dxMDRPQ3E0cHhIa2RiMmgwT0NBcE5w?=
 =?utf-8?B?NkZwZFNMTGF5bHpoWmhFeVBDeWtQWFBJZ1pOWHlkRDQyS3ZlakF1T0xQdGxS?=
 =?utf-8?B?N0YrR1NWaDczODlOUVlkclBDZWlpbE1mM0FDMUM4RXZFWGVRQk5neVllMGpP?=
 =?utf-8?B?K2UvRTJsb2xjSEJHa204cUxsc3lQTXVBT29PaGUwMjR4dFBZM2NTN3VIMW9x?=
 =?utf-8?B?UEMvRG1HdDdMQk9RYkxBQS9ZRm9wUmQ0SkFzUzlJNFVGY2JRRHY5NDhRc2xZ?=
 =?utf-8?B?VzRYVVA5cXU3TExLT0pTZVd5SWFWWTI5VnNZVWw0OUJTc0Q0cGZ5N0tMRW5u?=
 =?utf-8?B?R1ZTLzliaFZTQTFXZ0dIUVo3WSt0ei9tam5uMzVmemdvL3ZSMHBxY3ZBS3h2?=
 =?utf-8?B?STloYkkzRGZKY0VrM1pQOGdrL25tQXJQcnA5OFBQRDVzMldkdTZQRzNkMXVG?=
 =?utf-8?B?Yk94Qmc2cVR6YUlLamhZUGxFSFZtRzZYZ0k3ZEN1SkR6UHlsVW54ZXVBTEhT?=
 =?utf-8?B?VFZkRWJFaHc2YlVRRnpDZEljK3dYeEJpeDNTY1dFOHVnV1BQdTBHNUFpN3Bu?=
 =?utf-8?B?dFh2bXE4RjBFL3QzV2lHdHZacGtqbmhiMGVUdEJqa1BLVVd3SUlMYWVacHRy?=
 =?utf-8?B?YXV6SEJMdTZkVjF2d1VWd2YybERzUkxIeENCSmttUEFkN3JrV2V5MkliNTdH?=
 =?utf-8?B?bU81MFFybkFNRVpFVm5sNlNsV0xhUmJGcUhhK1Iwa3U5RW5PWU8zSjBmTEl5?=
 =?utf-8?B?czV6aCtOMW0zVGpubW1mNW5PaFNJeXh2Y1JEQXE4cWJ0c2tWYmNNeisrTnE0?=
 =?utf-8?B?bU05b2xjd1EyS2NjUTdGbG14ZmFCb3I5V3dDd2hYa2VzL0NQTm5MdTJSdkdT?=
 =?utf-8?B?TW8xdzIwb0dXdGZLV2hGMi9wWEhJODAxSXFzS0lzRGV2RktnbHZ0Tk9SZjZG?=
 =?utf-8?B?NUVTVFlGSmxoZTdmekRQZlB5Um9lVllrVVNKZmpjdTZ3VEJiSzBEc1UvZFFk?=
 =?utf-8?B?QzVUWHMvdXFpYnVpMW5sNEx5VnhEeHJJaEN1TWRvUTR4YmJCMzBrZlZDV1dQ?=
 =?utf-8?B?Ump3V0lMbUV3d1dIWnhPMVhTU3lLM0dYRHJYa0pSVVY2eS9aSGllNWhudnMw?=
 =?utf-8?B?S21uc0dMMFlCYWNNcUY3eE11bkJWUTVhQk5FZGdPMjVXS1VEL2l0WlJhUXE1?=
 =?utf-8?B?dXZnRzFqWlBGSFJydE9WUU1uSHpOcHFrcEVtUms5WnFLVWFKWTVmU0dXaGli?=
 =?utf-8?B?d1QwaGJaUW9lRVMwbTZYc0lBVWd0Z0hxYVZaUGQweFhhQ01PRzlocFRCQnQ4?=
 =?utf-8?B?MTBnZWVpa1FkRjc0TlFJVGtMd0FhREc3VlBvK2xhaGZuelF6aFZVVGlZYTJh?=
 =?utf-8?B?YmY2TnNpT1hucExqRmhTTHZrek9YaXJLb09JWll1VFhpUHduZHd3WngxZm1L?=
 =?utf-8?B?dUI4RXZBWUlRWkltZXk0L2JhWlhXejVVeU5FWGJkV2xGZWlvZ09SZUR1T2o2?=
 =?utf-8?B?YkkvWTg1SGEvQURORzBLYlk2WXlBeUlZMnJrY2RwaGV3ZXFrbmEyaEVBVUJV?=
 =?utf-8?B?YVZiaHlnRURnVTl2b01lbHROTXdyVllubnJLZzZXN2ErejBWUnVQUytLR09W?=
 =?utf-8?B?b3NaMkVpUGxmNmJBRVpIeHdQZ1ZVdWkyR1E1WHFITHZ4Wk1LSk5Iemc3QXJ2?=
 =?utf-8?B?bTFveEY5QU5Uai9ILy92YUJXcEM5UjZDUTJ0M2owTmxSdW5qZ05ZTjdhNkc1?=
 =?utf-8?B?VmpzRVZXZlEzeXZHMEtpWjRsK2Y1K3o1OXVBMkl0bVZtRGQwbDlsRXhxM3py?=
 =?utf-8?B?T3JrcXkyVlZKYTJ1c3BQM0xFQlk3UERESFFqbzJPeUNpT2NldEprT3VaV1Jn?=
 =?utf-8?B?cTlWeEYwczM0cGx3czUzVWZKWjJaRk5RU1QrN2wvUjgwV3crUXdKdlhmNWRS?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G0mzp6CLJvvyihpsgEdpG+/6lyMB8f/9/YEjcB/8A/mFE09HdyjiohmswdUmm32UFwh04sIwxNRvoG1Nd2kkaKanfxi6lp4LiZRXaYiImp49HLEwWeSMQi+nGiLq/6q89sH0q8isAy40gEK7yNpBiKdRTOZHIL9Ta6w24PU1xYwFrhZKbd1ff9E2u9Xy+9TL8Fdn69tqe3FJP7qAkj8umpEv+UMC1k2+yxtseckYRWCWmqWzikTrgB13VYs7m1eOZU83u/l+NQfXLdR4hjhcp12puriY4IXwTGgEBElx4fw2LSYvoaVQrvwWU8Feq3yUuyz0z9q3v3YR2g71hkmDhuJS8WeOXLVzR/kcseVlu8u6XLCxXosVif5kRR/sBC6ViZgGZk7LEuCH46X5eWyYLprCkTLc/vHTnnB88aCccQzPV7d0no+Ein7k9ipWznY/ZOYVro8p4mM2S+g1NDS7h8ECSK98QUOt5g3ulCzYlV/lppQ0Z7H/ha1OWwmAGgb0kpxT+RQHS+Rrkm58hVshwM4166wErS2ykbICr9Hb87eAi2o49wusV+HJWXT7mZrDezwyKYoeR4GVdW2jN2HTqcEufppez4BMiVlABxYA3kA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3deae6-0a56-4988-96ee-08ddc9dcbf95
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 11:33:30.2807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BKJPHPZ7nMCxhiKFrYBkeRHf6ozkpOX9kAfxwEVyDhluiqVUdRJo6v/8Ivb6CapA402B/gUBYytXNBHayc6rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=750 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230098
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=6880c890 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=XYRBDDl4DR-qrbHa_0oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FLXHuFLwixhCV4fgwhvqwt4OQ1ND_iit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NSBTYWx0ZWRfXzVEfiafYUanj
 i+3EhvCPQwoV/8p9vuCosRSOdA0JCd5wIjnCUC2a1LNmgxYHJQX+PmCcRDzvydeVxKcAz50nxPv
 5Q5OJwFranhtBng2dRzalAli9l9Mppx+/CFUOGJgpf/Q0ugHnaU0dvT93S6L6WLuczUXI8vpZqY
 HwpK0k+oCiAtqjzdPrk+/3hkYqc6VLrM5ov2dtJcN5+eKmO/smVdQrx46LQFz3GT8NHQCYCR5vf
 wzctn1M2LwJL1Q9IZ72eglgMFWo0MfUQL8WzaoiljHpfKfI1+1fgsJtZ1OQDkkJoyEjioKLxYKI
 jPrZYvcjX9P7emCnqvz/1O2vkzK3oJcjvfc2+rZQnoud7n/g4eneBx6UvLyMHP+tSObybnjgiWy
 n8P0YyWF0NZQXqpRVVuGbxgtPA3NyjZ8g5Fg6w44Iq05TzPc9N61/0riVb5lVpm9cTpmoq8n
X-Proofpoint-ORIG-GUID: FLXHuFLwixhCV4fgwhvqwt4OQ1ND_iit

On 22/07/2025 09:47, Ojaswin Mujoo wrote:
>>> Yes, I've tested with XFS with software fallback as well. Also, tested
>>> xfs while keeping io size as 16kb so we stress the hw paths too.
>> so is that requirement implemented with the _require_scratch_write_atomic
>> check?
> No, its just something i hardcoded for that particular run. This patch
> doesn't enforce hardware only atomic writes

If we are to test this for XFS then we need to ensure that HW atomics 
are available.

Thanks,
John

