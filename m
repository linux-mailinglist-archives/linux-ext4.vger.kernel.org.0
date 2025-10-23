Return-Path: <linux-ext4+bounces-11027-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEC9C0237D
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Oct 2025 17:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0525B3A425B
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Oct 2025 15:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F62033CEBB;
	Thu, 23 Oct 2025 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oranqtUY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PbuHd9S9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5999D1494C2;
	Thu, 23 Oct 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234293; cv=fail; b=TJwp/FAjc1VRQQgnoz9A0hs63w3Ny9xycMnkmvIm8Id7b1WI4HCZNF6qrwAmjolLWfl7HqBnSKQJtNzhBlbP2bg8OZ3ZJwgk+sOYqMe/3swXsr2ON25/6H7GdZjTIjnHAx03qvERK+yLqYB72U9zBxGgVX26f48WpMWEosv8nAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234293; c=relaxed/simple;
	bh=pG/oQt08xj9GQnpOoNoz9jvvxIDIEylJwE4LoWh5nYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uudodRkvaEAeMBOdwHoMeu2PPWJQa3VkwkuNO3TZVrZC3xd2qJ+8b7MRFIoX99j5ERrWYfrgyn00MWHy+vEHRFgnmgur1HcVXHEtpphtrxhpQXq+jLQpv2MgeWZZGY2EvC7/KwIZ1LgB6GL7eI+tERj7q1hdln3FTe98Yn/crac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oranqtUY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PbuHd9S9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAI7Eh016450;
	Thu, 23 Oct 2025 15:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zNpH0MSvWBJ4cxAdfz+rNAOosCkxkDuYrWZnLA7WkRM=; b=
	oranqtUY8BdO9EpLWOtyzd31jPTsJkFXAU+sco0CfZHqyEQpYZ1e7MxVG8+OVKpP
	lOKlGus29BXda7DZw73cj3FiJYK4kp99yYaA2NtVoRsyH6UdnPXvqkwg0NdPQR10
	NBRLsJVqdwV7iW5OCHhUskXeFkP53tmdoPtjJwStkvkVBycoxoIBMdqQsZCvl3co
	uJE5fBhlp52S1BnOm+yrI2Lhn44qnEdKJlzVpXvk3G6H10QyTVMF8JNzkqOtWosH
	bRD3FQEjupSss0NgMzQdNL3jwTMgVe4v9ekr7NFtJS/dGu9HA0X4wHUf9Nl8r270
	LWaERwavRVe2H+Z3Kueemg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xstyk3dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 15:44:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEOBtt012191;
	Thu, 23 Oct 2025 15:44:43 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1beyh0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 15:44:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6ZcjwmBnn2i/YUys6MOe3XfvKJKfPzVkkgpKw+zqIJsaZ+MirE8DcIZeW2cHk2d3eIgGu7IYT+j1C/Or3dzgAJ40Kgu0DNmKx+JTDzHGypbSq0OAI3HlRAZ5VEclglcgPWgQu+Xc0pipD2KBIlCni4jPu3SIghGfWvVViT7lmr4MGAtF0aoIOCgALSI8d8qF+uFVPD+9RzDq5+2enevaEakxh7jICtBNxVkWgR+xZTJOZqY6QtdwWTnBCIPLHSq8GrcFWM2eotpRURlX74FBvgF0Q3xBXUw5YgZzpjOPTiZHFLCpCNm/4138sJhDTt7zPYufJ/BWHTqc2k+gxoaSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNpH0MSvWBJ4cxAdfz+rNAOosCkxkDuYrWZnLA7WkRM=;
 b=AxP3S2cDpHxrhp1gwY36w5MhFO822R0vuCSDJI7VleasiFwO0Jj+u55hyFelcQ3jTKa8tTj1TwVje7slcVlDdoZ/eieD2+uT7jJ+w3OQe0Wof+18TokMMfgd0VgaN3syriV7X2CPQPqqpjLrKDWq8uCKNhb9sLuvNMe8cgHxFepO8MWHip+9S/XmfEkyQuM7LumFsjaLZx01yTeib1R9GhXYSyJahXvoDmaTMyc0Wb6q/DTgZxbn83EbHWGWxEd4O90agD0MddOZ0ox/NxhqoQnrpSv5NbHikCan4bOm2dHy05OYNgSjzXyZZ6Pc80RLSubMZiLE+rUb87TW9Hv1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNpH0MSvWBJ4cxAdfz+rNAOosCkxkDuYrWZnLA7WkRM=;
 b=PbuHd9S9yAPxuiozk9nJwsEJYvBfR6oiaY0fo5e6K6wmmxofNgaFC/0P0V0BM3JAtz4fUW+TKKNcFNkUc+oQJ9d3inf9ZIn97HSY8QOchxKPz1gFZ1WROhEI6WGxNeRoY2YV21NEglH82ulSd5hchTtJLgclS6nBQ7YDC2N+vp0=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS4PPFD91C619EF.namprd10.prod.outlook.com (2603:10b6:f:fc00::d4e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 15:44:40 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:44:40 +0000
Message-ID: <3b201807-439f-4dc9-af20-7e2cdad112f3@oracle.com>
Date: Thu, 23 Oct 2025 16:44:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/12] ltp/fsx.c: Add atomic writes support to fsx
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Darrick J. Wong"
 <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <aN683ZHUzA5qPVaJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251003171932.pxzaotlafhwqsg5v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOJrNHcQPD7bgnfB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251005153956.zofernclbbva3xt6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOPCAzx0diQy7lFN@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <66470caf-ec35-4f7d-adac-4a1c22a40a3e@oracle.com>
 <aPdgR5gdA3l3oTLQ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aPdu2DtLSNrI7gfp@bfoster>
 <aPd1aKVFImgXpULn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251021174406.GR6178@frogsfrogsfrogs>
 <aPiKYvb2C-VECybc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aPiKYvb2C-VECybc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::7) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS4PPFD91C619EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb5b08e-59a6-435e-51b5-08de124b13c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGlVbW5HZWJvYnJyd3EvRFh4Y1hXNW5kRklmY2lUQTNpbGozMzJxcnNYS3kv?=
 =?utf-8?B?RHVMODZWTEpFanFQcDR1MHdLQ3FTM1d2TUJ2RjZ0ci9iWXh4VG9jMUhtclZM?=
 =?utf-8?B?RERoZDFGTHA1RENrK0QyT29QRGZCcGxtMGIxOEFIRmlUNERvMWxkTGk4Uys1?=
 =?utf-8?B?alJaaVBuS2xxaE9ZSzlKVlI5aTNRbEkzWXMxeXdnTTM2NmlGUGFQdTdPcTQ1?=
 =?utf-8?B?OHY2R3d0eXp2R1FJNitiOE1MZVdraUZLbVRqa2JZQVJsRUlGT3I5M05WSVRM?=
 =?utf-8?B?c05aQ3pIeFJJSjNUNmJnTUxpYk5Ebk9PLzFBcXNpWGR3ZnF0TG1MQS84dE83?=
 =?utf-8?B?cmNoNGtiWHBJK1Nxb0ZMekhBa2I4cFZuLzZleU9XUW1sZmNDUVZBM2I0VC9r?=
 =?utf-8?B?NXdVTFMwWTkzTE1NN0hIS1lwVXBnVFZwSFAyNzVJQ1FlRU9PWDlmTVprekxV?=
 =?utf-8?B?T0NZbkVXbUF2WmxYSktKRFFIR1ZtVFM2amx3N3lJYVY2SzZvLzR2dFZ1dmtR?=
 =?utf-8?B?YkVEYXFVTFZWNG92TEhQTlltQWlQcDBtT2FVck02aytVbmhXNWRJT3ZyU1dr?=
 =?utf-8?B?Vm15emkxbHNsRk1KQXRnV0lvRHRwdmpMT1hVcWpMS3A1UFNqckQ1NHdUOXYy?=
 =?utf-8?B?bVlWdGpicDdKSitDM1FWQktlZ2lKSDVXbER4TXoyZDNHRmdsVmFqdjkwRXlH?=
 =?utf-8?B?V2xVb1dReFl1YnVqRHNpUnpQTjE1UGhGTXMyYkNDS3R1TjFkOGwyYnZKcDJq?=
 =?utf-8?B?VVV2eEsvUmZoaG9xdk5pODZmR0hOU3JlSnVLaVdjMmtnVnh2Y1NMSjBkS0pm?=
 =?utf-8?B?MkVrMm1ES2lLVks5Q2lvYzBhSVU4T2FPYTNldVRnWDF4UHg1YkE2TUZGNVlp?=
 =?utf-8?B?eWM5bHlwNXRDZzhuQlRLckJyYmdnblA1MFFvT2wyaGJtV2NPelkyT0NPRGhm?=
 =?utf-8?B?dWVzM2hCNy9hTUowMTBCWnlYS0xPNW13a1IwSUN2OC92RDFzMVdMWVRQOE8x?=
 =?utf-8?B?Vk9od1ZvdHpXN3hnMjVCckl3WHFpcExXakF6dExJeTZkcEZYTFlHR0RYbEI5?=
 =?utf-8?B?Q3c1STV4ZFRaWFlGa2orSm5TNURPaUhyenV1OXFDUWpYelIzQVl1NGZtK1Ar?=
 =?utf-8?B?d2V2K2ZNOWlsT3lkVng0eVJrNU9ubnFLYXRsdEJCaEJuWGtMS1hBRTZFM0hl?=
 =?utf-8?B?RVh3T3BTdWxNdy83WDU4MnFkUksxL1VIUWRwNFI1dFVhaUZrL1Z0TGV0Vm5O?=
 =?utf-8?B?SitpT1FUeGlLWVJIaUVrc0VvNWxZeEl3amtEYzJheE9HeWFYdEQwQmkvQ29B?=
 =?utf-8?B?aWtmVzVTYU5PamNLWE56WHNDNWlBRk1nZmhpVUxtdTZOdHI1T1ZNdVl0Qy9y?=
 =?utf-8?B?YnViVWpEWDIrRVJKbzEyWW1vSkQ2MWtVZjZobnE4clp0cjdvOUhlZFdJRXRx?=
 =?utf-8?B?bEo5N29UdGZiNi94dC9sWSsrVDF4bU5YdHJiNWVSVUxDWEJwVk9qeFhUakJW?=
 =?utf-8?B?Yk9PVlRqeERTZGRuZGZtMTJQOW9RL09pLzVoSE1BL1U5b09zSXREcElNWmpy?=
 =?utf-8?B?WHJPekJzVk9KaC9nb0IxeUg1alY1Vkc1QUtXTVdYYkw2RVA2ckN4L0VZdGph?=
 =?utf-8?B?NGV2QnNRSDJFczdLYUhMYW9lVmNMeDBKWm95NmhPTG9ZZ2UwS0oxNkxENW5P?=
 =?utf-8?B?QlVsZUpuQTVJYXJhYkIyRWJEbEF5SkdhbDArUHlhU1gzN2ZrQk9memtudmFE?=
 =?utf-8?B?c3JIRUZMZ0FhSWNxMnFxY0NpYTROWHcyUVJMeTE0bkVxdUFkcG15UDBtemJX?=
 =?utf-8?B?NEdmeUgrRjI2RWJTSjlZRFZvZCtuL0lCdGNWbXJUZ0xEZVlkUlY4a00vNlZV?=
 =?utf-8?B?U1FESkdFRkhLMHNSQjRPWE9SL2g0d05RRURrYlVqZUhmTE1JRGZQNHFjdkYr?=
 =?utf-8?Q?O1g9jKOUTB5OfznMXCkzm0Gjk2kDTxF2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d05JaUVSM01sd3hMdzZ3TWQvRm03KzhPU1FJUldab0I4L2dEU1M2SEtNZ1Rh?=
 =?utf-8?B?UkVtdkpjTDdTQkVvNVpPdXBUMjhMVnlyZVNISlhzeWxPN0E5M0liTjJzckRT?=
 =?utf-8?B?U1ZXd0phSWU3K2NhM01XMUxSU1ZJTzgyNXBPNDI5K29ibHNnWlc4Yk01Ykl5?=
 =?utf-8?B?RFVJbmhoWjVxOEhXVHV0YlRVYnF0dkNXRDNnVnQzRUZpNjEzT21BQmhrRFlm?=
 =?utf-8?B?TTA4T3ovdmd2VXg1NVBOK0J3SWVqKy92MjQ5RGs0MWo1MzNmS1NJUzhzRE5j?=
 =?utf-8?B?NHN2UGc5WEFxUVNLYUkxWGM3SG16TDloQitKUXUwNjlIQkhJOEdUNXpiZ2hF?=
 =?utf-8?B?bkZXZXlFZmMwR2R3aTJoTFExY2R1RGF4ekFhSURRL2pQYUoyS0licTluOUVw?=
 =?utf-8?B?NlV4WEYwQ2FkV2JqTTJrK3pETzJkMWVkeU1DdFZUTzBTV1NlVjlDV2lPRmx1?=
 =?utf-8?B?dDlMYThWUkZzakRlQ0dWU214SVJyb3N4MlZReVdBOEV4Z2tJT0Z5ZVo4MktB?=
 =?utf-8?B?RGlJVUZ0WW9OL3AzWGxWRi8ybDQ0M2pMSWZTVnFvSDBoK1N0b1p4S29hbHFa?=
 =?utf-8?B?cXBmbVVFZklQL3F0V0VvdUFDZEJUWXZwYi9XL0hpeXdsUUZXZjVaY21vcFZ5?=
 =?utf-8?B?MVJLWWtubDA3aW41dTIvOWg5QUhnY0I1REg0WGZCZ0szQ2pqcFRXOFBEcWJn?=
 =?utf-8?B?WlFlRVBJY0QyYnk2ZEJYTDRrS0F4S2p1dVVDdU5ub25JS2lYN2NjQzQ1UlYv?=
 =?utf-8?B?eWZxZFMrVEtiVHJtUVRpNFYwSFBSeUNraEwyOWRadVZIWVBqVGpxVHVvWDZM?=
 =?utf-8?B?WG91MUlqY05MMTVBK3lRQ3VmamJkbGFjUW1iMWx6RmJTOVNTWExuS2trd2JP?=
 =?utf-8?B?VDRIdkVCbHRSUVVFMCthbEk0REpUOVYzaDEwVHovNUltSFNuVDNnWmFxbThQ?=
 =?utf-8?B?ZmJodXdoN3ZVK0lqWlZoV2NSMHJOOWhtYWFycjRidUVsWFRYb29sTml4MXJk?=
 =?utf-8?B?NE1YSk5mUnJnQ1BjUFhWdzJQK1d5Z29iaGJ3R0VEVVpPVjZ1N0VVMVJxNlBr?=
 =?utf-8?B?V3lKWEN6VnFwTldnYXF4QUwweUxWWjVkT1kyYUdDTTVHZlZvTUM4dnBuRXRE?=
 =?utf-8?B?a3VqTXNJejVWbFduc253T242N283UlhFazNFaG51bjZYcEduOGQxWWszNjdH?=
 =?utf-8?B?ZFk4S1pUVUwxcTA2czUyd3VYZFl2N1RCVVJzZlY5L0NJVVcyZnN5c1ovS1Vo?=
 =?utf-8?B?UUFtZlh0OVNKZ095c3h0UDIzR2NQeWVqSmRwaHRiT2FDUEdUcW5zVGl4czht?=
 =?utf-8?B?VEtib2lZZm1hb01HMWNFV3F5ajZJcU14L3RUWjNSRkczdUdFWGUyWEQ0cGxF?=
 =?utf-8?B?bUp0VUZ5bGpOSzhhNDErUlh2MU5id0NLS1BjME9tN2VKaTR5RGtXNHZyMjZP?=
 =?utf-8?B?THVlbnNOSk4wQ0xyT2hpKzRmd1NxN0VuWDRyY25IcitKUitpZFhBaUU4NUdv?=
 =?utf-8?B?STFZUG5qSW5JMitJNXdvZXdaM2hTL3o2bVRkV1ZBTFVyVFdSZnMxamtQV1gy?=
 =?utf-8?B?MklKUGNuYVFkY3lBTFZObjFxbG0xQk1NSDlYa090SlVONDBvUGxtaVlaNFNr?=
 =?utf-8?B?QkRIOU12dHBKc1dOTGxPU1pYZUtTalN2Y2dnOUxxbm5GbUxKdWFnczN2VWJF?=
 =?utf-8?B?cXA0cVNwL3RHU1B4VnllbW5PeUVhNGNldnpoamZ6Nmxya3pQa2ZpT1FnQ2tv?=
 =?utf-8?B?LzFLOEFGZmhKUEpwQjc0R3oxaWJsNmYrZHpzQm82UHhZd1l2ejdEbHBFV2Ex?=
 =?utf-8?B?cU5DVjA2SGdlR1Jsb3dYbWZSZlNqekEwVHVmRzJETitpTHlicWIwUGNaYlUv?=
 =?utf-8?B?NStEbU9NTVY1bE5TdXNPakkwa0xtQVozQStOeTdQcGFwR3BwU0VpWUplRWZT?=
 =?utf-8?B?Y3NNZURlSzdWTlUwdGVBVmM3dG9ncnpkOFpjbVNBc2FJaC83eHM1L2o0M08v?=
 =?utf-8?B?c29RbUFSRmlwMVlkWnJVYTh1eC9Fc2VXV3VWZnlvamhDSklmckl2SDV2eFZP?=
 =?utf-8?B?K2FONFZ4cGd0ZWQ1Uzl2ZVRiODJ4dlR1bHM4ZTJyQUtraStmZEhkV3lsSndC?=
 =?utf-8?B?YnFDeXZEcEEyM2s3RC8wanloUEhoOUVqVW83TWVIMEcxbkF3YWxVWThzbWZN?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1tYsaw5sOEQ01NYRXU/vu08QsPJopAf3y4Ug2e8qkQj6V3cSeeqxgbnzjw59Unr8ZlQKeX3Xd6I7BuihpomHTX+Kuv9duo3MnKsLXuA2rN5Rjp276B+iyEpusJog4YKpahY6Z2BFtXlAnUkfr2CX1z1AsHYowOMFBdlEpAEvU+e9fpM5GMaolKJDHOYtKyU/lvxYX2JanWA/xRSlfwu3Sp5VHTNjas4/cR2mzCRGCAgTR0pkE0wwvn8ErI15u1L4/YzcBz+7NRbvqHrlYJE+hvgPSsHRB6q70tAiHub4yC2FTwsZqaZA0RxlUCsJMP8gL4wjlW/zP7Ll2S5NqmEAq4u/3+ygFM5ohtVst4NOOCHtlstux56ssju5uaH0rjfIwhjUXo+LfGvPCi5Uhb/5NJl3Am5KFMNGOX+wlrlG3tMugwgiLmnSAzh076jUJ9OWaknyurKVHiuPtwZB0LKAcDFCdV7Q9Z0G499JsRkCC307GPb2nvf72UmSM49nbxJCATsEAZdJsKP2tJvq+9lKKg9GIaFdDx0X/gY/qroGH7GwufI8yFf7NwccMvchGdAeuiWwLUFffROedvn3nrzeye/27b12x8hOesDLmUI1DH4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb5b08e-59a6-435e-51b5-08de124b13c5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:44:39.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsgoQHD9A2xhq5gPXmDRWunjxNyfzlMaxhDWxIrkNZ7lxkK8pIDlVLVnC5RDhADscsibLAR+RNFca0oAObCHxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD91C619EF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510230143
X-Proofpoint-GUID: hfNZPo39wQuXq7WBaGE82864BbhgGvVZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA1MCBTYWx0ZWRfX3BZIokwl5ERV
 OuuluIYilsFQ9edZI9vb18SAO+zxeF/XyU5h3zz4X1dxgTipQBVPqCk/yuch6juMXLkFoRTqyGa
 1julTuO/XXCQHaWYVm0QcnJqHT4qf7eFEckLXp11Gx67e5VMYJusAHHby34ImEdjb2OT+IV9zwv
 ORM0vS1IElrFU58oTIejKUcIBD/P6rAqlPbjswJuNuKTwJO3qu76DRNg+LZ8sLAJTKAjG5aMMT7
 EpMerrLqBWluFOZsiRL/VH3JbrDi1wZwmDeQzRF4vy5u8Z85axIlW3/6YEBXNNKqGyG0Ja1pkXT
 ON99RnoCnedYoQSMCY74uExWTwMFM5EkpaW49wsZLfVgc7n4vaU4zPuFlkMi89oKaMcIova7mFG
 jvcCxwOOZ/0M9OXWDFxaMydObiGx/g==
X-Authority-Analysis: v=2.4 cv=OdeVzxTY c=1 sm=1 tr=0 ts=68fa4d6c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zR-EsiJ5-FQ0TdBmWrIA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: hfNZPo39wQuXq7WBaGE82864BbhgGvVZ

On 22/10/2025 08:40, Ojaswin Mujoo wrote:
>> FWIW I see a somewhat different failure -- not data corruption, but
>> pwrite returning failure:
>> --- /run/fstests/bin/tests/generic/521.out      2025-07-15 14:45:15.100315255 -0700
>> +++ /var/tmp/fstests/generic/521.out.bad        2025-10-21 10:33:39.032263811 -0700
>> @@ -1,2 +1,668 @@
>>   QA output created by 521
>> +dowrite: write: Input/output error
> Hmm that's strange. Can you try running the above command with
> prep.fsxops that I've shared. You'll need to pull the fsx atomic write
> changes in this patch for it to work. I've been running on non atomic
> write device btw.

JFYI, I can see this issue with v6.18-rc2 and generic/760

I'll investigate...

