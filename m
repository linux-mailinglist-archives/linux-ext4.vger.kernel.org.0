Return-Path: <linux-ext4+bounces-9847-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA645B4915C
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Sep 2025 16:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A011B24ACD
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Sep 2025 14:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4970D30BF67;
	Mon,  8 Sep 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mwbz8J0H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gfC8tHmd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC23043A4;
	Mon,  8 Sep 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341722; cv=fail; b=KY44guYoTVCVHl3K4NlfpPdtpul1Chv7PKb8nS8035Wk8+vXo9L3y5RjhJuu/pp2ZsbN8KdWOo8B90KHLcrk4gtHimMr2NIys9dJJKTajMZEfLq3pN6sdb+SoGEt5sL9yhYTCV2ctWAQp3ejQ2G4I6bo/Hb6H+yuJ7Vn3f1gWLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341722; c=relaxed/simple;
	bh=HON0Bcc/SPt+cekfu1An9yskMMfqhgwfQA+JSqc/PEw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZAS5TREtetpiXhsIYDX71iRc/k0EcvsA8OX6CDrlF/04Zy314ADGRlxqJVoBHthU/rH9dwxEA/e6haaQo4l6WpVQ9xG2ICnhMnsgtexkTO9PPvwCJbbd0KmbsrF6Z6vXFXnPmEzrJQgKa9Eg/s5lmRpFOyt5FsH4b92Ic0NBDjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mwbz8J0H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gfC8tHmd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588E1r7q017683;
	Mon, 8 Sep 2025 14:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MjSXGFiEZxJMVhIGppxLHN4hn86AZ2jjZVTBkeTvFn0=; b=
	mwbz8J0HzNPtddCttp1BeA+V3DO5qZ2Q1gjuGIa7XIsSf6rtu663BA7ylyaAZ9E7
	SOXoaFt3zRyjaulTcN40Ss/IPMCBAk5u4O0XVOrbhDKr7stv4AFHhTX5w5ygg+x5
	wBICXQrHo+W8AcLTpyLZJLPX869kXvFDkfqz26maEMlNRmQLhkhoiqauoi7uGcAw
	DNR7hD9LzekRO4WqRC5PKmIgqbxv/TPjbxBDfujkcWsbthi91VO08IYGUwTbC6VB
	aTj24znydiPDrtAI3pyqtFrUseFqasJVzf6HdkQeoo1cDqOIfG+MP4Ut3MgLYrlS
	aH3GL4GPt31r2BvUIwqANQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491yx6r4tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 14:28:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588DuClK030242;
	Mon, 8 Sep 2025 14:28:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9926d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 14:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3rmO7Y7jYGTFvPcGBfFJaIaUIH5cOyGI3oVUhH8ymZFpSutPvxJna+8wHXYxkL+Mmh/244fZPwRzMpnXSsarFHfo2N4cs/xaueGrj8Dce9AzWFmxnDv0CnDAkWaRNXBWj215qAyeYEqRZbirFdJ3Bpq+d3YJOBhB1sE1CCqEQ1VQDTRoiWn88jCGFndYDEDfUHY8XSqJP+okDkyJ3lR7jM6FaOXlYHjuxZmiFxqnASbhLDlMotukiYAohLbpymQ9n6D04wHtOT+add5EQDggEXY5A2dmT6Ceh5xXU6Li2/Fndtfv0wn9mtbAxlV2bn9jyI4DyHP0XHO6FE0Tdn8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjSXGFiEZxJMVhIGppxLHN4hn86AZ2jjZVTBkeTvFn0=;
 b=vyh3BIOd/RzKsPDfqLjP6UjmtuMEx3Z44p5H1u9nqnBRVXigbrDEd/rvGHbXY7M+pvIraSlGGQMpHKkqkx4nCjlmxW1n420vrbEzF5g5waEQcX0Wq2wUYDZwVKZk6ZI2nRZhoN/enUlH5T3BxaeBqV2L/qs/4uJPeEHmSztU7fIJeVqD/zrfM4lVsK0i8Bb45btgMaw/66KNvtVwSW0H21+D/RwjpVbp+5Hkrpnd5bBFSva1XO5sw5sVwQ926Uplx4sVE7b4smUPzO+xF9kqucIHLCQ9P/c7b6FI3mfZniy3sxc4S+l21rWTIKreQPkCMzq0JWTWp2HDPc4uy2TAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjSXGFiEZxJMVhIGppxLHN4hn86AZ2jjZVTBkeTvFn0=;
 b=gfC8tHmdg1xZk8J0YoqXHYpfkfZfNKqoLXgaAqcPFU9hW2QUlkH4qYYNDgf9w3PzH0HTHnNEaMo78KFz445Bti3jfVK1QKkQ1cvFHC14tt3YlaEOSFb7FKV3Qkh1GnYXMmd2DlNinI5N2zRvoO5LLVzSZ3ENddAcgXHqxGO+cFc=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by BY5PR10MB4307.namprd10.prod.outlook.com (2603:10b6:a03:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 14:28:00 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 14:28:00 +0000
Message-ID: <674aa21b-4c47-4586-abdc-5198840fcea5@oracle.com>
Date: Mon, 8 Sep 2025 15:27:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] generic: Add sudden shutdown tests for multi
 block atomic writes
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <2b523de842ada3ac7759cedae80485ae201d7e5d.1755849134.git.ojaswin@linux.ibm.com>
 <12281f45-c42f-4d1e-bcff-f14be46483a8@oracle.com>
 <aLsYj1tqEbH5RpAu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aLsYj1tqEbH5RpAu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::11) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|BY5PR10MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: b78c4f2c-54ab-49c8-9a4a-08ddeee3e97c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3d6RjJpcjZmWThxdlFObVM5MFg3aFhmRHNsdmFGeElpZDJXaUlVeWhEaUdo?=
 =?utf-8?B?MGxkODVoYjBwMldoeUt0U29Na1hmMDlMeXJYNlBxVE1LMmZWZ0IwRVRmbHhU?=
 =?utf-8?B?ZElQcXdkcnF3Wkp2QytLZ1hybHFpQis4VkdWSG1XUWxXTnFZREdWN2NtSFhl?=
 =?utf-8?B?VGtTM0cveEZwZXdPRzJQc1d1aEJhRG9HSGFnamFGWnhDNVJ6dU1kTllBNnk3?=
 =?utf-8?B?YmlRVk1pVFVPYkZQbDFiRzRDUy9GaStNelRYQVJVS2s2RjlQOTlqSzhOTDBs?=
 =?utf-8?B?VXJjZDlqcVVlYnI1Vk1haU9hYlBRdmZDSG9SUVRKdWt5UjhjNW9sKzBjdVgz?=
 =?utf-8?B?NUVEeG4wZmxKNEhSb1V3aXNnS25ZS2p0YjZBSVA4cUJ4T1NJYlVHTG1xRjlu?=
 =?utf-8?B?SWhzK1VKaVRQdzlWNDRrWDZOSlZxZ1RzREtseUtZS3hUMnF3Vk9KOUVKWEhY?=
 =?utf-8?B?c3JjYnYrMmxWZnZyenB3UitWUjR0NjRWd2dobE9Kem1xWGl1Q1l3NXNETE9Y?=
 =?utf-8?B?Q1pUekx0dytUTGpUTE52NDhDZ2syRlBxbnJIa2tqNStLZzBkWkhTQ0luTVdp?=
 =?utf-8?B?bG9FV3lzcmRsRXV0YjFZT290QUYxSEsyeHRPUjZUeGdPQS9rdUJzY2FxK3Jz?=
 =?utf-8?B?ZkliSGhEbjdMNVhkRVBzbnRUSnRxamU0UUNYZ0Nvcks3dnFYYTBQQWtVNEVP?=
 =?utf-8?B?UElxRE1kUmJJK0FzNWFsWTlyQ3MxQThwaFFndkpLQWNveUVSaXphc0xGbUZz?=
 =?utf-8?B?RkdLZnVXTUkzTXFaQWQrdUVQUmlleERPa3FtRU0wWGpRQVZmQnZIRGFhQTV0?=
 =?utf-8?B?K2gzdER1V00xNGlWSGJkbFNXTEs2NlhiZ1puYk5xd0VBVHZmTmZlUXdNU1Nh?=
 =?utf-8?B?aW5JcnkwcTVJM3ArQm9CWVE0UlJNWlphdk1Wenp6THFubTEvYmdhNzU1T0h1?=
 =?utf-8?B?ZUt0MTNPbHZUODVMRURqOUZmMzFoc3d3dWJTVmRoRmF1c3JmVFU0d1JaMHAy?=
 =?utf-8?B?Y1EzMUp3b2ZGdWowd2dvWVNRTkhyd1VQS2lqTTlscFpTNmZtU3dOKzhDa3o5?=
 =?utf-8?B?b2VkMm04elFyK2ZPZkQyb0NGUjRBc3RLL1B3N21zUGFJWHBVTDBoZEpTTmVJ?=
 =?utf-8?B?QXdKV3J4cEpDWENmNG5BYTJMK0JHbkc2K0ZLS3pMQks3NDNyWWhDUVdsejdx?=
 =?utf-8?B?Y3Mxc0FUTm1RYVZ2VHI2MFhaQUZFSEZnZzZuWmxSQVBrRlI4c1hQdjBsTzJX?=
 =?utf-8?B?VnRqNHRIQmFLMFlzbVZCMjhCaEtaeDRBQW9oOFBLRXZ3SHBid3cxbWlodkRB?=
 =?utf-8?B?M1RxWjR5RnBsOG4yVmdjRXhscDdVcEtKWkc2Z2FFS09YajNyN2VwNE9BaGZq?=
 =?utf-8?B?UE5xYitxcVczUGdOZkFPSERoeUpGNDNpZTJuQVBEbjdkWlk0dG8zcTVNaDdY?=
 =?utf-8?B?SDBXblhKYjBZckNMSXJ4YjFUUS90ejdJVWs2aVJ1aENkVHNOL1Rnb2d0cHRH?=
 =?utf-8?B?ek90bnhSbGVJSmpWUkJVR1BSdTlkRjdsNER6dmh5Q3gzMDJqM1ZLSFdDcFli?=
 =?utf-8?B?cXZ6TE1WRGs4ZGRqSFJHSG40SXNFMGxtVnhVR3R3T2ZFaDc5eEpWUjVGSnNq?=
 =?utf-8?B?Z09aZjdrcTNZVWVMdEpDZStGN2x1K1Flbmp2WkxlVm1JMFhiNnVkaUtYZGZS?=
 =?utf-8?B?NXZGaG9GQmFrdTNtTnZvNmM3c201c0h4dFl6OWJoVmtoL0s3ZVpXNkpPc3Rv?=
 =?utf-8?B?UURGbFlHUUhYcHhwR0FzYm5QL2E0d3lyT2VsckFrdmdQSXUyVi9EQU40VkZZ?=
 =?utf-8?B?R255aDJ0MnBFZnpXVUdhVFUxU2U0QWp0bjZWUUtWdzN2Mmp2WXpSVERKTjRU?=
 =?utf-8?B?Y2JRUEFTUjM5cm5zQWtweEdsU0JIV2VxOVNpYmptZEdCczFGYU1GMDJRTEtz?=
 =?utf-8?Q?+SM24j6VRkY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wmw4MFd5MmFyL0F1UlVIK3hHYnlsTU9QV1FGNm93cEpyZ3JCQmFPMmJkbU93?=
 =?utf-8?B?OVB5RmNaYnZYMTVBZUpKbFNERkYycStwWnU0eWNmOFptOFFDYTdxWVdWK1FZ?=
 =?utf-8?B?NEVrcGtGZ0tUSzRFbTJiRDFwam9HQk1ldWlUaTFLTUFmMzRrMUc3UkVmVVFr?=
 =?utf-8?B?OTE5V1ZoMUpvdlhNcW5nYUpmQ3JTMUdmazcxa2o4YURScDlEWjdncEVQanZW?=
 =?utf-8?B?L3BkWnd1V1JhTUNmK3NrNWpQU1ZpN2QxY1FsUGRXd2V3R1laMnVjbUJuRU1R?=
 =?utf-8?B?TnNqZmhaMlMzRjVBWlFQWVRYTzZkWi9oWjlLb29lRTlHYlV0endKb3I4Nzdw?=
 =?utf-8?B?WEhqTkI4RllEM0t2N1ZWV0o5S2FTSytiVlNFQk1IK3orM2tkZDhpMnhWeFk4?=
 =?utf-8?B?ZGM3ZE1mZmJMTGVENWRZdzJUNmpHMWZGeVBiZURxYVZhWG1FNmJJUExaR0NO?=
 =?utf-8?B?Zjh5RWtqQmxiYm5EQnh2bS92Y0h5Z3hPTDlEVFhVa3dIZHhOOCszdXdQUWw0?=
 =?utf-8?B?eWtwWnZjZVZQUU9VenBVK2xEWHJuQzRmc1JBelhCamtSVy9rUEltSHdSdHRw?=
 =?utf-8?B?dTVhNzFCOEx0amQ4dVU4aURJY3RGb3QwOWRNVnlqeGVtZmprNlYvcStvcVNH?=
 =?utf-8?B?cGxqUytUc3RhNTVZWW1YSzlIUi8zbjVnMk53RThaa0xEZlNEREdIcXYxWnJE?=
 =?utf-8?B?byt0YnJtNmpGTEp5OVMvSENNOFQ5MUJWYnp2bHp3SDNONjB1cFlweU1nWS9n?=
 =?utf-8?B?dXEyZDJCQTI4WEp2OHdEYU40KzlKUjFRc092cWI1bnVhZGhHQkx5RDNvWHB4?=
 =?utf-8?B?eTVYdklCWDhMRUN1ZU83d2tkOGtXWFA0QVROQVkvL0QyQUpIdWV2a2pVZDRS?=
 =?utf-8?B?TzcvZExWRWNnTnRhN3phZmR6Vjc5ckFtWUxyNmRPNzUvRFlpZ0RlUkMzZzZr?=
 =?utf-8?B?dkc3enY1Ym5oM21xSGVtMTJGcVJyUHA4SW5RYjZDa096ME9weFJCS0grZlhR?=
 =?utf-8?B?ZlhiSGQvcGhHZlZMY3FNR0pMd0JWd01RTHFFK2pXZW4xRW11R3BiV0pmRk9Z?=
 =?utf-8?B?UzROWTAvcTRrUUd1cnN5Q1JGZFM2UUozOGVNdzdVRnVRTGhtVkVtSG1sR2Fl?=
 =?utf-8?B?RDJrVi95dGhXRkl1ZVdkVE1kTy9GNjYybUdiYUNVbGRnOEZYZEFVR3BnalVS?=
 =?utf-8?B?bDk3d3ZJZ2Z2bFA1MlR5aGhIaFhoOUhOY2tWQVVyWnA2YkNvRFpPUkV0b1cx?=
 =?utf-8?B?Z2poUE14Y2laT2puWUJ5VkFxY1JWNG5XT2YwNkJFWEluNkJ4MUJmMnA4N3I5?=
 =?utf-8?B?T2UyUlRaYkZyUW5wdDJwZUZsY1dib2tHNC92NlpidUtOSlhhUmxrdFVSYmhW?=
 =?utf-8?B?UDlzYWoyYmk4cVBOaE11VHdaVUFheTBmUFZybHRZRUR2T3JDUStMRHk3Y1Zz?=
 =?utf-8?B?YWp2cjI4WHBhM0RFK29TdDV2TWQyaWQ3VGhCRjhQWllueHA3ell0bitKbFk0?=
 =?utf-8?B?eUk4cXFFNVByaUhBbVE5dGp2Q0RNWE9BNzZmSGVjSFBEcXZTU2M5Ui9TS2Zo?=
 =?utf-8?B?M3I5SWUrUUxxNW44eGpzM2dRdURONFFtTmlSRG5QN29HTGNEdldJMlQwZ3Rv?=
 =?utf-8?B?UzJ3aW5JZU5ERzh6c3ZxS2lOcExKNGpuazByVlM5QUlmQ0RoSHEvd2F1bTZL?=
 =?utf-8?B?MW5zM2x2amh4RXRSYWZteWtCZnJGVnVvckFhSjRCa3lwcTZuTWRrbUxqbkNR?=
 =?utf-8?B?QWtYYUVaNXRjQ1BWNTVNeUtwaGVNblU1eWl6cENnZUhwNCtyS0dnN3ZRYjM1?=
 =?utf-8?B?V2ZSVkc1SkRQYXpVSGxoQk5WMmN0dFc2ZVQvN1plMG5HZHBwV3hKYlRjNzh4?=
 =?utf-8?B?Q2tOeSs0SFVSZDNjcXFDVitibzNtMFE1NHdGNmNkWFdaWGkrSExpekVVMVVS?=
 =?utf-8?B?Mjc1ODlYamtwOVRIRXp2eGN0Z0pNc3lybmJvNUJPTmlnOFhlcUhMeVo0bENq?=
 =?utf-8?B?YkhZOHBwV3A4V0VUMzV0Wnl5TlNZem1KclFLK21Walk1ajFWYWUxWk1JZ25Y?=
 =?utf-8?B?RFFrb3BDTTdYTDRNTGNoSDRIcmZna2lMMjNBSkhNNVFuZWtRZFVINlc0anF3?=
 =?utf-8?Q?ZhhguhNyr99V6ZG0PX/3tEtQu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EFkNJHYdovzEDLehsPYUTOEpLGpr3bESYwpb+UJgCuDXo6FSlBnlgxBHWpdJwsgLmkmY0S9uX15wsgfb+A+93oIelm/MXIYo3tgkkTL1iBEtNkhTkC6eGkxSjVqME3Kp3r4JSKHqs+ydsER+7lLzvAO3m1TF8jFkEN6u3NF0IPi+QIkbrFdnsga0N1NJ3fKZ7NwbKEJ5ygRs5loIjbX6w+E8UxiStdHt2qT2J4kt20ty+2Ef5Jf+jvoxeMEITcEPYx1nTfOKdruyoQk/AcT29nSaxpeFv1x9xklU9jghuxBPuTStiGLbvqT5w437jXa7fv+eNv1x1ZwyF/WCpT5hro75EVlr6CtUTnwg9pL10KQOnF4js4x9Nw2V7m/IYPgEOwT71sA2QDCSGjfrmj6QTHHK4Y7P1xyeV7NgI9mK6E5A44KjBRsCNd7OGGmJERw2myxT/NwJgaaA7+XOiOOOg/xOJAmVaznSqhpPB5DJnBnAsxnlerjrlWELHAc1kvWZk9gxVKdV2XscFoVCemI3Wf93ph68yc8fGag9VHGCAi3/DZGeMn0R256gyMjLEBME5PT3jAY9CetdQ67iSPKGTmQDA8WzKkU7An2fEYu7f4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78c4f2c-54ab-49c8-9a4a-08ddeee3e97c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:28:00.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6DpD+dm9a8j1GSSc1pvL3EFy1pUEKcDzZHkXQWy3EFjfE4KR2qMuGUiygtcGAFyzg/nYcD+T9GqwoWT8hSTwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080145
X-Authority-Analysis: v=2.4 cv=SaP3duRu c=1 sm=1 tr=0 ts=68bee80f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=L6dLE3yhhPwVN8ulp-sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LLbjTPaQoysPdqs0_r6-H5rXhXgHSnt8
X-Proofpoint-GUID: LLbjTPaQoysPdqs0_r6-H5rXhXgHSnt8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEzMyBTYWx0ZWRfX5YfqzGlUWU17
 j90ccMj0otLOf6A8JKHd2O9YNOCjd1myAKMGv3HwNzY0Qkc6gIhRebN0JLA2azf7CbRNrXygUBM
 Ony3ij+HCRIj7gYx7lIqwa+egbmcsvwVknOibXiS3QysVWQBgqGrrqvJaZoCAOYogN1rLdPlWVz
 GQ0AzUBIO65vVBxEK7dB3mTWGebo6iXYvB2W187A3GrUyKIzel3GnmCull8MzU92OGKjou7CRRE
 IUBR+lFvRklD2s+gfjxh8X2YysilrsyaaXgZm1u1BG1RiEIXPy561FvvVNTNmlDAHHCj3gynMcz
 jfM45YxbrrOzEURPTuhx2tAq74+eC0gSjI1JbXFWfY9Jaz8EAkFTmbf8iyF/JRJg94q8zf3fiP7
 0uTUx1Di

On 05/09/2025 18:06, Ojaswin Mujoo wrote:
> On Tue, Sep 02, 2025 at 04:49:26PM +0100, John Garry wrote:
>> On 22/08/2025 09:02, Ojaswin Mujoo wrote:
>>> This test is intended to ensure that multi blocks atomic writes
>>> maintain atomic guarantees across sudden FS shutdowns.
>>>
>>> The way we work is that we lay out a file with random mix of written,
>>> unwritten and hole extents. Then we start performing atomic writes
>>> sequentially on the file while we parallely shutdown the FS. Then we
>>> note the last offset where the atomic write happened just before shut
>>> down and then make sure blocks around it either have completely old
>>> data or completely new data, ie the write was not torn during shutdown.
>>>
>>> We repeat the same with completely written, completely unwritten and completely
>>> empty file to ensure these cases are not torn either.  Finally, we have a
>>> similar test for append atomic writes
>>>
>>> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>
>> Please check comments, below, thanks!
>>
>>> ---
>>>    tests/generic/1230     | 397 +++++++++++++++++++++++++++++++++++++++++
>>>    tests/generic/1230.out |   2 +
>>>    2 files changed, 399 insertions(+)
>>>    create mode 100755 tests/generic/1230
>>>    create mode 100644 tests/generic/1230.out
>>>
>>> diff --git a/tests/generic/1230 b/tests/generic/1230
>>> new file mode 100755
>>> index 00000000..cff5adc0
>>> --- /dev/null
>>> +++ b/tests/generic/1230
>>> @@ -0,0 +1,397 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
>>> +#
>>> +# FS QA Test No. 1230
>>> +#
>>> +# Test multi block atomic writes with sudden FS shutdowns to ensure
>>> +# the FS is not tearing the write operation
>>> +. ./common/preamble
>>> +. ./common/atomicwrites
>>> +_begin_fstest auto atomicwrites
>>> +
>>> +_require_scratch_write_atomic_multi_fsblock
>>> +_require_atomic_write_test_commands
>>> +_require_scratch_shutdown
>>> +_require_xfs_io_command "truncate"
>>
>> is a similar fallocate test needed?
> 
> Hey John, we run the test for the following cases:
> 
> - file has mixed mapping
> - file has only hole (trucate case)
> - file has only unwritten blocks (falloc case)
> - file has only written blocks
> 
> So we already do that. It's just that we don't need the
> _require_xfs_io_command "falloc" since it is already included in
> _require_atomic_write_test_commnads.

ok

> 
>>
>>> +
>>> +_scratch_mkfs >> $seqres.full 2>&1
>>> +_scratch_mount >> $seqres.full
>>> +
>>> +testfile=$SCRATCH_MNT/testfile
>>> +touch $testfile
>>> +
>>> +awu_max=$(_get_atomic_write_unit_max $testfile)
>>> +blksz=$(_get_block_size $SCRATCH_MNT)
>>> +echo "Awu max: $awu_max" >> $seqres.full
>>> +
>>> +num_blocks=$((awu_max / blksz))
>>> +# keep initial value high for dry run. This will be
>>> +# tweaked in dry_run() based on device write speed.
>>> +filesize=$(( 10 * 1024 * 1024 * 1024 ))
>>
>> could this cause some out-of-space issue? That's 10GB, right?
> 
> Hey John, yes this is just a dummy value. We tune the filesize later
> based on how fast the device is. That will usually be around 3 * (bytes
> written in 0.2s) (check dry_run function).
> 
> Generally this will be a smaller size. ( 3GB on a 5GB/s SSD.) But yes
> I should probably add a _notrun if our ssd fast enough to fill up the
> full FS in 0.2s.

ok, good

> 
>>
>>> +
>>> +_cleanup() {
>>> +	[ -n "$awloop_pid" ] && kill $awloop_pid &> /dev/null
>>> +	wait
>>> +}
>>> +
>>> +atomic_write_loop() {
>>> +	local off=0
>>> +	local size=$awu_max
>>> +	for ((i=0; i<$((filesize / $size )); i++)); do
>>> +		# Due to sudden shutdown this can produce errors so just
>>> +		# redirect them to seqres.full
>>> +		$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $size $off $size" >> /dev/null 2>>$seqres.full
>>> +		echo "Written to offset: $off" >> $tmp.aw
>>> +		off=$((off + $size))
>>> +	done
>>> +}
>>> +
>>> +# This test has the following flow:
>>> +# 1. Start doing sequential atomic writes in bg, upto $filesize
>>
>> bg?
> 
> background*. I'll change it.
>>
>>> +# 2. Sleep for 0.2s and shutdown the FS
>>> +# 3. kill the atomic write process
>>> +# 4. verify the writes were not torn
>>> +#
>>> +# We ideally want the shutdown to happen while an atomic write is ongoing
>>> +# but this gets tricky since faster devices can actually finish the whole
>>> +# atomic write loop before sleep 0.2s completes, resulting in the shutdown
>>> +# happening after the write loop which is not what we want. A simple solution
>>> +# to this is to increase $filesize so step 1 takes long enough but a big
>>> +# $filesize leads to create_mixed_mappings() taking very long, which is not
>>> +# ideal.
>>> +#
>>> +# Hence, use the dry_run function to figure out the rough device speed and set
>>> +# $filesize accordingly.
>>> +dry_run() {
>>> +	echo >> $seqres.full
>>> +	echo "# Estimating ideal filesize..." >> $seqres.full
>>> +	atomic_write_loop &
>>> +	awloop_pid=$!
>>> +
>>> +	local i=0
>>> +	# Wait for atleast first write to be recorded or 10s
>>> +	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
>>> +
>>> +	if [[ $i -gt 50 ]]
>>> +	then
>>> +		_fail "atomic write process took too long to start"
>>> +	fi
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Shutting down filesystem while write is running" >> $seqres.full
>>> +	_scratch_shutdown
>>> +
>>> +	kill $awloop_pid 2>/dev/null  # the process might have finished already
>>> +	wait $awloop_pid
>>> +	unset $awloop_pid
>>> +
>>> +	bytes_written=$(tail -n 1 $tmp.aw | cut -d" " -f4)
>>> +	echo "# Bytes written in 0.2s: $bytes_written" >> $seqres.full
>>> +
>>> +	filesize=$((bytes_written * 3))
>>> +	echo "# Setting \$filesize=$filesize" >> $seqres.full
>>> +
>>> +	rm $tmp.aw
>>> +	sleep 0.5
>>> +
>>> +	_scratch_cycle_mount
>>> +
>>> +}
>>> +
>>> +create_mixed_mappings() {
>>
>> Is this same as patch 08/12?
> 
> I believe you mean the [D]SYNC tests, yes it is the same.

then maybe factor out the test, if possible. I assume that this sort of 
approach is taken for xfstests.

> 
>>
>>> +	local file=$1
>>> +	local size_bytes=$2
>>> +
>>> +	echo "# Filling file $file with alternate mappings till size $size_bytes" >> $seqres.full
>>> +	#Fill the file with alternate written and unwritten blocks
>>> +	local off=0
>>> +	local operations=("W" "U")
>>> +
>>> +	for ((i=0; i<$((size_bytes / blksz )); i++)); do
>>> +		index=$(($i % ${#operations[@]}))
>>> +		map="${operations[$index]}"
>>> +
>>> +		case "$map" in
>>> +		    "W")
>>> +			$XFS_IO_PROG -fc "pwrite -b $blksz $off $blksz" $file  >> /dev/null
>>
>> does this just write random data? I don't see any pattern being set.
> 
> By default pwrite writes 0xcd if no patterns is specified. This helps us
> reliably check the data back.

ok, understood

> 
>>
>>> +			;;
>>> +		    "U")
>>> +			$XFS_IO_PROG -fc "falloc $off $blksz" $file >> /dev/null
>>> +			;;
>>> +		esac
>>> +		off=$((off + blksz))
>>> +	done
>>> +
>>> +	sync $file
>>> +}
>>> +
>>> +populate_expected_data() {
>>> +	# create a dummy file with expected old data for different cases
>>> +	create_mixed_mappings $testfile.exp_old_mixed $awu_max
>>> +	expected_data_old_mixed=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_mixed)
>>> +
>>> +	$XFS_IO_PROG -fc "falloc 0 $awu_max" $testfile.exp_old_zeroes >> $seqres.full
>>> +	expected_data_old_zeroes=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_zeroes)
>>> +
>>> +	$XFS_IO_PROG -fc "pwrite -b $awu_max 0 $awu_max" $testfile.exp_old_mapped >> $seqres.full
>>> +	expected_data_old_mapped=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_mapped)
>>> +
>>> +	# create a dummy file with expected new data
>>> +	$XFS_IO_PROG -fc "pwrite -S 0x61 -b $awu_max 0 $awu_max" $testfile.exp_new >> $seqres.full
>>> +	expected_data_new=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_new)
>>> +}
>>> +
>>> +verify_data_blocks() {
>>> +	local verify_start=$1
>>> +	local verify_end=$2
>>> +	local expected_data_old="$3"
>>> +	local expected_data_new="$4"
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Checking data integrity from $verify_start to $verify_end" >> $seqres.full
>>> +
>>> +	# After an atomic write, for every chunk we ensure that the underlying
>>> +	# data is either the old data or new data as writes shouldn't get torn.
>>> +	local off=$verify_start
>>> +	while [[ "$off" -lt "$verify_end" ]]
>>> +	do
>>> +		#actual_data=$(xxd -s $off -l $awu_max -p $testfile)
>>> +		actual_data=$(od -An -t x1 -j $off -N $awu_max $testfile)
>>> +		if [[ "$actual_data" != "$expected_data_new" ]] && [[ "$actual_data" != "$expected_data_old" ]]
>>> +		then
>>> +			echo "Checksum match failed at off: $off size: $awu_max"
>>> +			echo "Expected contents: (Either of the 2 below):"
>>> +			echo
>>> +			echo "Expected old: "
>>> +			echo "$expected_data_old"
>>
>>
>> it would be nice if this was deterministic - see comment in
>> create_mixed_mappings
> 
> Yes, it is. It will be 0xcdcdcdcd
>>
>>> +			echo
>>> +			echo "Expected new: "
>>> +			echo "$expected_data_new"
>>
>> nit: I am not sure what is meant by "expected". I would just have "new
>> data". We don't know what to expect, as it could be old or new, right?
> 
> Yes, so the I was thinking of it this way:
> 
> We either expect the data to be the full new (named expected_new) or
> fully old (named expected_old). Else renaming it to new vs old vs actual
> makese it a bit more confusing imo

ok, good

> 
>>
>>> +			echo
>>> +			echo "Actual contents: "
>>> +			echo "$actual_data"
>>> +
>>> +			_fail
>>> +		fi
>>> +		echo -n "Check at offset $off suceeded! " >> $seqres.full
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
>>> +	atomic_write_loop &
>>> +	awloop_pid=$!
>>> +
>>
>> from here ...
>>
>>> +	local i=0
>>> +	# Wait for atleast first write to be recorded or 10s
>>> +	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
>>> +
>>> +	if [[ $i -gt 50 ]]
>>> +	then
>>> +		_fail "atomic write process took too long to start"
>>> +	fi
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Shutting down filesystem while write is running" >> $seqres.full
>>> +	_scratch_shutdown
>>> +
>>> +	kill $awloop_pid 2>/dev/null  # the process might have finished already
>>> +	wait $awloop_pid
>>> +	unset $awloop_pid
>>
>> ... to here looks similar in many functions. Can we factor it out?
> 
> Right thats true, I'll factor this out. Thanks for pointing it out.

ok

>>
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
>>> +	# we want to verify all blocks around which the shutdown happended
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
>>> +# test data integrity for file wiht written and unwritten mappings
>>
>> with
>>
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
>>> +test_data_integrity_writ() {
>>
>> please spell "writ" out fully, which I think should be "written"
> 
> Yes, will do.
> 
>>
>>> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Creating testfile with fully written mapping" >> $seqres.full
>>> +	$XFS_IO_PROG -c "pwrite -b $filesize 0 $filesize" $testfile >> $seqres.full
>>> +	sync $testfile
>>> +
>>> +	test_data_integrity
>>> +
>>> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_mapped" "$expected_data_new"
>>> +}
>>> +
>>> +# test data integrity for file with completely unwritten mappings
>>> +test_data_integrity_unwrit() {
>>
>> same as above
>>
>>> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Creating testfile with fully unwritten mappings" >> $seqres.full
>>> +	$XFS_IO_PROG -c "falloc 0 $filesize" $testfile >> $seqres.full
>>> +	sync $testfile
>>> +
>>> +	test_data_integrity
>>> +
>>> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
>>> +}
>>> +
>>> +# test data integrity for file with no mappings
>>> +test_data_integrity_hole() {
>>> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Creating testfile with no mappings" >> $seqres.full
>>> +	$XFS_IO_PROG -c "truncate $filesize" $testfile >> $seqres.full
>>> +	sync $testfile
>>> +
>>> +	test_data_integrity
>>> +
>>> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
>>> +}
>>> +
>>> +test_filesize_integrity() {
>>> +	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Performing extending atomic writes over file in background" >> $seqres.full
>>> +	atomic_write_loop &
>>> +	awloop_pid=$!
>>> +
>>> +	local i=0
>>> +	# Wait for atleast first write to be recorded or 10s
>>> +	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
>>> +
>>> +	if [[ $i -gt 50 ]]
>>> +	then
>>> +		_fail "atomic write process took too long to start"
>>> +	fi
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Shutting down filesystem while write is running" >> $seqres.full
>>> +	_scratch_shutdown
>>> +
>>> +	kill $awloop_pid 2>/dev/null  # the process might have finished already
>>> +	wait $awloop_pid
>>> +	unset $awloop_pid
>>> +
>>> +	local last_offset=$(tail -n 1 $tmp.aw | cut -d" " -f4)
>>> +	if [[ -z $last_offset ]]
>>> +	then
>>> +		last_offset=0
>>> +	fi
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Last offset of atomic write: $last_offset" >> $seqres.full
>>> +	rm $tmp.aw
>>> +	sleep 0.5
>>> +
>>> +	_scratch_cycle_mount
>>> +	local filesize=$(_get_filesize $testfile)
>>> +	echo >> $seqres.full
>>> +	echo "# Filesize after shutdown: $filesize" >> $seqres.full
>>> +
>>> +	# To confirm that the write went atomically, we check:
>>> +	# 1. The last block should be a multiple of awu_max
>>> +	# 2. The last block should be the completely new data
>>> +
>>> +	if (( $filesize % $awu_max ))
>>> +	then
>>> +		echo "Filesize after shutdown ($filesize) not a multiple of atomic write unit ($awu_max)"
>>> +	fi
>>> +
>>> +	verify_start=$(( filesize - (awu_max * 5)))
>>> +	if [[ $verify_start < 0 ]]
>>> +	then
>>> +		verify_start=0
>>> +	fi
>>> +
>>> +	local verify_end=$filesize
>>> +
>>> +	# Here the blocks should always match new data hence, for simplicity of
>>> +	# code, just corrupt the $expected_data_old buffer so it never matches
>>> +	local expected_data_old="POISON"
>>> +	verify_data_blocks $verify_start $verify_end "$expected_data_old" "$expected_data_new"
>>> +}
>>> +
>>> +$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
>>> +
>>> +dry_run
>>> +
>>> +echo >> $seqres.full
>>> +echo "# Populating expected data buffers" >> $seqres.full
>>> +populate_expected_data
>>> +
>>> +# Loop 20 times to shake out any races due to shutdown
>>> +for ((iter=0; iter<20; iter++))
>>> +do
>>> +	echo >> $seqres.full
>>> +	echo "------ Iteration $iter ------" >> $seqres.full
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Starting data integrity test for atomic writes over mixed mapping" >> $seqres.full
>>> +	test_data_integrity_mixed
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Starting data integrity test for atomic writes over fully written mapping" >> $seqres.full
>>> +	test_data_integrity_writ
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Starting data integrity test for atomic writes over fully unwritten mapping" >> $seqres.full
>>> +	test_data_integrity_unwrit
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Starting data integrity test for atomic writes over holes" >> $seqres.full
>>> +	test_data_integrity_hole
>>> +
>>> +	echo >> $seqres.full
>>> +	echo "# Starting filesize integrity test for atomic writes" >> $seqres.full
>>
>> what does "Starting filesize integrity test" mean?
> 
> Basically other tests already truncate the file to a higher value and
> then perform the shut down test. Here we actually do append atomic
> writes since we want to also stress the i_size update paths during
> shutdown to ensure that doesn't cause any tearing with atomic writes.
> 
> I can maybe rename it to:
> 
> 
> echo "# Starting data integrity test for atomic append writes" >> $seqres.full
> 
> Thanks for the review!
> 

It's just the name "integrity" that throws me a bit..

