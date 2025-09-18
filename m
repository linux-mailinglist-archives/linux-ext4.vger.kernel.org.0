Return-Path: <linux-ext4+bounces-10238-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E6BB83512
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Sep 2025 09:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53881C2466E
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Sep 2025 07:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0993E2EB875;
	Thu, 18 Sep 2025 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZP1zwo0F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DH0pA1HL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E212EB851;
	Thu, 18 Sep 2025 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180577; cv=fail; b=l4C1t5qvGWoKsOxxJM2rWeoXhgrNkQTmhGI3MdtJADmvhAcFegmXaykzMHnxMnoUFo8RNOrr5ka3Kbhu0u4C35OFjvWG6H7C5l9q8o6ZNkkS65i/uUOtPcOoLeWjePevjzUzciczziUSozo9pqCeKY5fZm531B6/9sfzDT4OC4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180577; c=relaxed/simple;
	bh=tGPmXcrts3e/MVG0zqpisb9NyDJxuG0rA4cuixTJCSI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kl99QSIbRau18+55Avb/OHi55BFUnFSz8+nl8SIFDZGDAj+DX0VGCN/1JHzhZMVsiQnATYIi3SChihOUqOBgGh0bYCZaiD0hX7oF6aDy9C1VzIzZJbdj8ZoNO2/SSvPcE0J1ycwOspjpC0WtREZW9vMmNAFgXI7nA++4PiN7Rgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZP1zwo0F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DH0pA1HL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HMHBmM014271;
	Thu, 18 Sep 2025 07:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iJDxXKRty4YZ3GLHx/WgYUD0Jc5boRwLu0ObK92Xwv4=; b=
	ZP1zwo0FGuE769ktSIZ4bp9eQR2NKN8cB2jcITcmb+rwGih4EbHPSKt3Orqjo1Fv
	ONosllpJ84yRebhbzXP/RPiYLL/KQTHadOZnURNHCY+5VyWnz99HsjDU05E6FU0A
	CAB//C3N3XYd9o0DeA+bz9ZBNOFW6++A59udwV6ERPZ++OlMjb0sCiAwkvdM4uTP
	iRqJBNaE56+ryKirJ1MGM7C/FZRNItxoO5p/Ou/c0lVV2zXt/m2oZruGcq5QFl4U
	BALxj0UnbHDm1Zr3C4G5XkMPHkE4XbKg6IMF2I10jdZXc0RpGpoIs5R2E1OIneLn
	jcm8CJ48OJe65sw5qaAf4w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0kawcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 07:29:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58I6aSaB035162;
	Thu, 18 Sep 2025 07:29:27 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2n2gmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 07:29:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlVqFbHBZx6DPDPhX3whUisbq7/XpTiYiieLWui4nPxGW6mKPgR+ZpZHzp9lwWvyFo/JrIpuGkaSv2pbHlbY8QJI4LGXr8yy4eGV0e61E3p5QIU2bNhCYvXh21xD7QF2nDWSQxxdF5CyBdL/MqNuTnCcClGnZRHYMrvi6DV5t1kTWDFMHxKzxlK4v2Q0lYK6UDi2Dg8CqwKuUDhIXaOaGMFwvK28E44v540ZvDfolx8UUo7K/ZupSIpqL3lldojO2r6AT0c1tLhzL+iVBW5g6z2+gE8Q0dtI4PfkX1bEnu0qgoYktgl0gG+DI2Daxmjjkd6d3uhnVA9fNN4i1S6XYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJDxXKRty4YZ3GLHx/WgYUD0Jc5boRwLu0ObK92Xwv4=;
 b=oZmJTKQgSdfaYTY8ycrnSW8/wh44ERgR5fbg+jJ70exyMr9yZPnyJ0LQiIiAutLwYvVb7psqySZrWhxh2w8D43ePw+Q2KvW9l1YGjbGLhj9hfL9iJ58lXWOzq55rWB0iIt5FcASnWEp28v6Scy0rymS+9NPKibQ/HS3D/xpB9FK1mnH0Dja9JGEVanVx9CVxYSIHy9hqW9y9t1tVakGtLfLdQPu1mFN9sz1Hqxddkazkg1IRkPAkZNK7AgPzHQA1e6BtJoPQ9vg1n+a56JhTeAUNYKDU2epOa2sUa5IRnhSGbPUg/DNY4zcAxaJMYHwylzMICj8ioQdCuq1dOdlLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJDxXKRty4YZ3GLHx/WgYUD0Jc5boRwLu0ObK92Xwv4=;
 b=DH0pA1HLFWhIAIIn6qPl3qWZwxgwMkxq05XWEGMoZKx2Lv7694oX1zkP89oPvqxQ7kWPJDx2MlzyId/qaB+us8svKTrGTzZXrWOmqtgyXXjoDCUMECI9OW4uz8C+XoNfWaPRQ4uLaUNNNniDaO/afpb800Vra+SYG5QN2kBbk8c=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by PH7PR10MB7720.namprd10.prod.outlook.com (2603:10b6:510:2fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 07:29:19 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:29:19 +0000
Message-ID: <7d4d6e9a-2eff-4558-bfd0-4ef3b0f818f0@oracle.com>
Date: Thu, 18 Sep 2025 08:29:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/12] generic: Add sudden shutdown tests for multi
 block atomic writes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1757610403.git.ojaswin@linux.ibm.com>
 <25f77aa7ac816e48b5921601e3cf10445db1f36b.1757610403.git.ojaswin@linux.ibm.com>
 <58214139-2e42-4480-a7c3-443dd931fd09@oracle.com>
 <aMpsnQEYagLvPOw2@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aMpsnQEYagLvPOw2@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0175.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::19) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|PH7PR10MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: fba01f11-63b3-4ebd-4ad5-08ddf6851432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUZDd1QwVXBJMW5KNVVoZmJFTlF4WnlqUDRyeTFpOTVJS2Y0RVpnOGNycmsy?=
 =?utf-8?B?TFBnOVZHdll0Zm5XOERYaEFQVEdiMDlPc3dQNFpOVFZ2dk5FWFowTzFOM1Aw?=
 =?utf-8?B?QnJzemNhbGZNbnNOY0RPZUovK08xV3JSZHIvRGZmaFNIb0MrT1BUNUp1NUVk?=
 =?utf-8?B?Sy93L3JBNW04QVM3Ynd3aldPci8wKzdiTmdLenBaSUsrek5lUUZBR2paV0M3?=
 =?utf-8?B?Vnk4cThoVktLQ1pQck1VZnV6Nzk3YkJqc3d3U29HbGRZcDdzbm9meS8xR1c1?=
 =?utf-8?B?bnNjOGk3eDBCclR6YmN2ZzkzSXFIWmdtamRaaVZHNXh1c2w2eDJYWDZyZkw5?=
 =?utf-8?B?cU05bmRlSjZLL0hWdm90cUJoNlJwRXFJSG1OZjhtcUNDZHFhYjNaUzJ5VmRk?=
 =?utf-8?B?VFdyMXRrWnRXRU5yWEFLcTVTemdEOHdhT2crTUcvRG9EYTJLazJWU1k1YitX?=
 =?utf-8?B?TS9LUHFIS0ovV2pMMU1TN05RZlRwbEdtOVNRSFF5dVhvVUNqSDRtM3hsdE1v?=
 =?utf-8?B?WkpJSnkxYlFlbGsyZXV0K3pseG5pNnIvS2RXK0F4eWJqRW5zVmFCeldTRjVL?=
 =?utf-8?B?YjBsblZjYjVsSUJrc3pxalFTaWEzeFdDVC9ZRVFkQW5WN3VWOFRkekJIT04w?=
 =?utf-8?B?Q1lwWkEyL1dZY0doZ1JaVEMrRWFsNXlLeThaMFAra0x0NE5HblR5c0V0Ri9B?=
 =?utf-8?B?OFZyS0lXNlNFS0FQcnlRNEpyTmxTcmI3TjBEaHlFQnYwbWdWQ2N0MzY4a1hZ?=
 =?utf-8?B?SHFLNGRBNGh4U2l1L1FBdTM3a2FnZDdWeC94eWFKWEp4OFNaS3dydXQ2V21v?=
 =?utf-8?B?NzJ2c2xzbmQwaU9YWVRPd3VQVUhzcUM5dHN3SHR4Ym5talF2SlF6RWpWTFVS?=
 =?utf-8?B?Snpya0tyemJrVkxYaWVxVnhnanZreXI4MXNzQWJkVUVhQjA5cUJ1Nkl3MHVL?=
 =?utf-8?B?UGtRcmh2ZmxJanlqd3p4R1RXRHJNMiswdWg1eVRQTTRDVzN4T3NIWGJXTTR0?=
 =?utf-8?B?U3A4YUt2eFd2bGwyZml0MnRnSUNTSXZVYTBvbCtXYXpvR3NUcHpCNXBRaWhX?=
 =?utf-8?B?azltZi9uQlFrN2J3YW9oNWdNcGtDN3lNaytPVGpVREk3ZjZ2TTBLNXhjZTEv?=
 =?utf-8?B?VFROZ1hHU0hzUlhXNlY0SUNqK3pXRXBZWHBkQnpjaEVSVGFnK1Z2azhxb3dF?=
 =?utf-8?B?NkM3cmVwSnA1OE5CempRVkF6WE96WTRNdmJZV3VvWnV5Tjh4cXAzQWxYVlJl?=
 =?utf-8?B?TERNd0toaWZSTjI3VEVUVVdqRENMTytjZ0pVZk5vbVcwdGVtSFFYSitYUitY?=
 =?utf-8?B?RDArT3Zod3NWbnFJVkk0WWRzOVFlVWRhQ1NkcFN5VHYyS1RQb2ZGZjZyZzU2?=
 =?utf-8?B?TklSTzN4aCtiakJCSzRXRTRMa3lwTHNSbTA3ZHpLNUxlR2k1bkV0bzg2TWZU?=
 =?utf-8?B?eXlRa2JjTUVvaWZmRXlIWU40RDZsQUNyV3FqbEk0QVFvTnRsZzdENFhtdkgw?=
 =?utf-8?B?OXFWMGw5SUtPQkZvT2hMWjk4a2g5eVB6YVdoOW9mdUFhcDJFZTV0TDI5cXN1?=
 =?utf-8?B?R3FKNUNJSzdIQlQrSGJJTjJ2dHJhdDljSGN4VkxYQXhEd05RWWhsazJZRjAz?=
 =?utf-8?B?TWsxNWRoTnZTWHR4R2IxdjBYOWNKQkZlaHVTOVBOZW14ZUQzWFE1T0pHWmJt?=
 =?utf-8?B?dEZ4cFlSYjFzR1dlVmZiUFdCSXU1Z2xrYXIyNFVudzI1WEt0TWVBbCsyVlFS?=
 =?utf-8?B?U0dZNjdGKy9zY25wNXFOMlR3eDNlTGN5TVFrd2dxZEdHa1FmTFN4S0V6Y3VR?=
 =?utf-8?B?TVJ1M0U5aG1aOUplSkljOVNleTBiUGxqeEFMZ2Vlc2FBMGxZai9zck5qMEwr?=
 =?utf-8?B?TnpQcFlzLzZXWUh3VTk2UWVWYUkydGhwTFJkOFpuSnNDbEwwK2orYW8yYklF?=
 =?utf-8?Q?tk2ZKC0Jehs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUFtalpSTjlBa3ZxcU0yRFhyTG5sZHMyeGNYMjYza3VFQ25qRlZENHl3VDNa?=
 =?utf-8?B?UjkxMVZmcWo0bkpOUnlpYXA5ZUVLbUVLbytNelQyQTZGRW1yc1R2dlo1V3JT?=
 =?utf-8?B?amlMQmN1SmpHaE04ditCQzE2bmpaNllKdXdwVDFTTDZ5TzJla0VoWU5kM1Q5?=
 =?utf-8?B?L1FlbENFeDArdnpEbmdxZTdWNGdtUWcrU2dkejd3Y1BiamJEYzh2djM1U012?=
 =?utf-8?B?OUUrUkl3RWQyVFpiZkZsaE1UaTk4UVpBb0wvZk01TkFyZ1pNek9uV1pzWXFj?=
 =?utf-8?B?WElNd1VsbS9TaWpkRkVEUjZGZ3RXdWg0a2U4dXFEKzRHeWtucFZLZ2xyL2R5?=
 =?utf-8?B?ZHJzclNXaUcxL2dZZnpvUkR6OFFBMU5yQmJkZUZKRVZQWDFYUmo3aWZxK0Ja?=
 =?utf-8?B?L1VpNkpjaXNTWVgwZkR5UHZ5WWJsY2k1d09YYUYzcU1rUlVsSWpnRklxZTJI?=
 =?utf-8?B?cUhnQUQ5cnE2N29uejZwLzc3WWdZb2k5SU5HVlpxckZCZWltanljajcxVHRv?=
 =?utf-8?B?MXNpcGhuYXVoL2NGQWE4NWFMMmZHZUpCTHJMdUQzbGgvUlpoU2VUTU5uNVpo?=
 =?utf-8?B?NnZZVXNBb1RReVo0MnlYSFh2cFpVdnZEYnl2R1UzZnhza2kzUDR6b2Z5TWh6?=
 =?utf-8?B?cHZHVXA1QjBMQ2pBUXZhaXduNVJGMVE3d1hLVlhTSVBmQ0t0eHpSVUVBWkkw?=
 =?utf-8?B?UGJkdWlzQzAreS83MTZkMDU1ZE41T3UwYTRrS3h3azhuL1hSdDlEUlNuWDgy?=
 =?utf-8?B?dWgydGtrNFp6dG1EdkdMcW1RRXErd1MwWS9ma0MzN0tRN3BNV1RjaTJpaXZF?=
 =?utf-8?B?MHhpWEtvcnkrdE9ZNXBpWWYvMGY5MTl2QUVYajU3YXNOTFlaZmhwT0Z1UDNa?=
 =?utf-8?B?WGxiTXJKZ1R5ZEU5TktZVk1MUzNHY3NTYk83ajU4cDVLREJCQzRySXFUbnE3?=
 =?utf-8?B?clhyUlVIMmkwV2kwM05LQ000RzZ2MTRLaTQ4YWgwTWZqRGhoSTE4S2dpYW10?=
 =?utf-8?B?cTg2Q0svZlB1L0FjYitVYnp1SmN0TTBxL2hPc29IZkpUMjNOYit6MlhLOTVU?=
 =?utf-8?B?Q0pmT05LVkx1WURmMUlNVVpnL3cwYlVLYUxDaDdGemIwdDFsTytqNGFrdC9r?=
 =?utf-8?B?WVUvS3JpekNZb1YwWTEzbFNuVjVPMW5VSkVBZ3h0QVI2UzgvN013VzlYUytC?=
 =?utf-8?B?Lyt1dG05bkJzZGlYcFdLd2dvTzlCM2p6TEZnR24va3kxaEF4eGc1UjI2ZG1E?=
 =?utf-8?B?TWY0UXZaWE16Wk1wT2pqN1hMU1h4cHIzQW5rVGZFWFVQNWJPVlR5a2hxaVFT?=
 =?utf-8?B?UVVoRnBLWjdQUGFuMTN3YzJXWXZUVkhVRGFtUVJ3czdFSCtKcjRNTzZicURP?=
 =?utf-8?B?UVhKQWt0cDlIZUloTzJUSUJSYUJqb05CYkg1TndXemExYTZhNEdCRzVlYlQw?=
 =?utf-8?B?RWNQNU5tMWZsWGh2UzVYMWo1SnYrc2NDaHN1Y0xrWStmMHBpVkhxeHlyTFhU?=
 =?utf-8?B?ZnJTMzkwa2c4NmNNTlluRG9aUFJMN2hJV1l4eFFzY1JCMnFQN3NmZWMzRllU?=
 =?utf-8?B?MDdBWDBLSUJlZmpkdVZOS0lrdEpCdVZ3WENaSW5NQXphMUFSNlpjUkJlTm4w?=
 =?utf-8?B?UTRQTEJRT3B3a0FvU0oydVZNUDA4ekJLbXliVllJL0lFQ0k3VkUwbXo0U1Rs?=
 =?utf-8?B?Yis5c0EyVDlEaTArWmE2MkdBaUJPcG5VczdWRUJPa2h6Ui9aN0YyaGlIUW5N?=
 =?utf-8?B?N21CKyt0dXJnZ3M4YS96MzRZNVdFVm5TdVFhS0xSa1NOK2ZuOE1kTEh3SUZS?=
 =?utf-8?B?Y3RWK1EyRkRBNGEzUFgvUDJDcHN4TTBtOTVMU01nc2pFRWdFcURFYnZrN1ZF?=
 =?utf-8?B?bHVEZW5qWUJZcFp5aEpwRnl5WUNxTnpib3BEaHJtT05NRlpnaTl6MTR0RWdR?=
 =?utf-8?B?cUVWOTNTNHlnYytsd3NRZGNlb3AvaGk1MjJScjJFOFJIYXhRWXRGc1E5dk02?=
 =?utf-8?B?Q2pGeXI1NHNSQ0ZvM0RQbitCOXhTb3BjRngzZUdVbmZlUGZ5anlsR1JVVk1l?=
 =?utf-8?B?WEdBbTZLalNaaDFjTW5henkvU2hNRU9Cd0s3WE1oUEkvRk9DL3RSQmRZS1dq?=
 =?utf-8?Q?v+R2TjJRPIL1Sk8JblYEbkUyO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z0t0W0p1OM4v0P781kcZ3OXPQ34FjLQOJGai41mxvc1XQoy5DUV5lPZv/nOJut5M5aUftpk4dM1o079dw3J+PwrNb4tQn+LcR1ilWOU/TeQ49IAZEisK2KdvGdVv3AEAXhATVkvxK0KE+BHyplKmElAw1hmi2A9pHMp7ZrEDOFVk6ePPt2MDEC7hGJjkeusNFsW9taHhWj3GMmi5vaAIfphyhWj9ArfmEDWpHZDEvyJwkcwTZdDCI1HBeKP7bCqC+iqfGcow4ytwBmKDBsu/hfkjotpevap+IrZRRtAZReTDOzpPm7ttfncf1LE8Yvqsjm8sigLzxpFD4ydoJW6Ye2S81k12XaDIn0bZviy1poenTsgLH+1Gx1DlCjAMnqIO8MoHPjoyTgeFpnu4TfvsevbQt130WKS+0zS5dyzcsWH55851puemSIMFt3XtdJN3LS7M7i+cI1Mes8rOPlcw8/V0nguR7PIqL8HN5tD3JdedItqIIwe0rYWd6EcggPzS/abJ2q5XQXhC0JaT+qsxi6j9bKrGhJggWQbU3BZ0yE20TE5+3T2jxx8ry9oXoRCGop4xHDe7MEmqy2LrQFpOFGA9KoyvxRjFQGZQ+/qfFAo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba01f11-63b3-4ebd-4ad5-08ddf6851432
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:29:19.4892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxWUBp9ggofR+M3rlWwUnkP2SHJdaUlGTuqpMUOy/0ePbZMRNfJPVZ/9SGr+ThE/OUPlwcJnRDZeg77stOJYTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180067
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cbb4d8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=RzHKArpYG1uQ2ywYbwYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13614
X-Proofpoint-GUID: YlszwtA0Cv2v1pNSM0ak5xmpZJyu7bUR
X-Proofpoint-ORIG-GUID: YlszwtA0Cv2v1pNSM0ak5xmpZJyu7bUR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX3dKSle2vg1UX
 QXS4EbwLIMBwAaCNiAkAh9t/6rJsZBycmhkiq9bNjwQbBsvnwFVGWJbUBGV4/L16tlTeSYqMWE0
 VeB+GMXcg+fR0+sOsTAjCgCtEaR3b6a+QU7CdgPY6Hn0Q8pNqb6Z+/Xxe3GAeFIMMRx6FoxB6iH
 bY2+63OUOD1qDOwtEPASWeQxVnVP11KWHNYCIS3DASpyie/G0BPx1Qz/uANUqFiVJ2Cm1c13zhC
 McMDsf1qYxU2UVHa3jkOuLuizOIJPZM8E4DfYnsii0BSEVC12ypZMTwuQoYoYDI7yx47jbZ7WBj
 uhMzh5L5Aa1CiKceJj+2TgstpguWWo47Sh6L9cqRKCIRIcH0mMK/gRSS7kLiKgzy/Zlpf4ktrfi
 pd773GWiwtdg9w7e2JGK3GsTDmrVvw==

On 17/09/2025 09:09, Ojaswin Mujoo wrote:
>> nit: I think that I mentioned this the last time - I would not use the word
>> "expected". We have old data, new data, and actual data. The only thing
>> which we expect is that actual data will be either all old or all new.
>   
> Hey John so I mentioned here [1] that the wording "expected new",
> "expected old", "actual" looked more clear to me than "new", "old" and
> "actual" and you replied with sure so I though we were good there 🙂
> 
> But no worries I can make this change. I'll keep the wording as
> new, old and actual.

great, thanks

> 
>>> +			echo "$expected_data_old"
>>> +			echo
>>> +			echo "Expected new: "
>>> +			echo "$expected_data_new"
>>> +			echo
>>> +			echo "Actual contents: "
>>> +			echo "$actual_data"
>>> +
>>> +			_fail
>>> +		fi
>>> +		echo -n "Check at offset $off succeeded! " >> $seqres.full
>>> +		if [[ "$actual_data" == "$expected_data_new" ]]
>>> +		then
>>> +			echo "matched new" >> $seqres.full
>>> +		elif [[ "$actual_data" == "$expected_data_old" ]]
>>> +		then
>>> +			echo "matched old" >> $seqres.full
>>> +		fi
>>> +		off=$(( off + awu_max ))
>>> +	done
>>> +}
>>> +
>>> +# test data integrity for file by shutting down in between atomic writes
>>> +test_data_integrity() {
>>> +	echo >> $seqres.full
>>> +	echo "# Writing atomically to file in background" >> $seqres.full
>>> +
>>> +	start_atomic_write_and_shutdown
>>> +
>>> +	last_offset=$(tail -n 1 $tmp.aw | cut -d" " -f4)
>>> +	if [[ -z $last_offset ]]
>>> +	then
>>> +		last_offset=0
>>> +	fi
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Last offset of atomic write: $last_offset" >> $seqres.full
>>> +
>>> +	rm $tmp.aw
>>> +	sleep 0.5
>>> +
>>> +	_scratch_cycle_mount
>>> +
>>> +	# we want to verify all blocks around which the shutdown happened
>>> +	verify_start=$(( last_offset - (awu_max * 5)))
>>> +	if [[ $verify_start < 0 ]]
>>> +	then
>>> +		verify_start=0
>>> +	fi
>>> +
>>> +	verify_end=$(( last_offset + (awu_max * 5)))
>>> +	if [[ "$verify_end" -gt "$filesize" ]]
>>> +	then
>>> +		verify_end=$filesize
>>> +	fi
>>> +}
>>> +
>>> +# test data integrity for file with written and unwritten mappings
>>> +test_data_integrity_mixed() {
>>> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Creating testfile with mixed mappings" >> $seqres.full
>>> +	create_mixed_mappings $testfile $filesize
>>> +
>>> +	test_data_integrity
>>> +
>>> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_mixed" "$expected_data_new"
>>> +}
>>> +
>>> +# test data integrity for file with completely written mappings
>>> +test_data_integrity_written() {
>> nit: again, I am not so keen on using the word "integrity" at all.
>> "integrity" in storage world relates to T10 PI support in Linux. I know that
>> last time I mentioned it's ok to use "integrity" when close to words "atomic
>> write", but I still fear some doubt on whether we are talking about T10 PI
>> when we mention integrity.
> Okay got it, fine then how about using phrases like "test for torn
> data for file with completely written mapping" and such?

sure, it's ok

Thanks very much



