Return-Path: <linux-ext4+bounces-6515-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD1DA3D587
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2025 10:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E1C16A4D4
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2025 09:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE9E1EFFA7;
	Thu, 20 Feb 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ESIRxnqR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nRe1aQLy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D84101DE;
	Thu, 20 Feb 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045433; cv=fail; b=ateTwfoFRqiiUiHhEj7VXPsZKQl4GBh6wBma9gs1qNNcsdk1vC3xpkmJyLC4Y3Oi/mssFGD7WgjKRf27VyFZf1yjfQimI3blbwIauS8BcJvmbyn0Uz70fRtToptySFJOEwq1ATbB6sWAHGjcFZp4wIeVRIMV20qO5CvIrw2YZYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045433; c=relaxed/simple;
	bh=zAkCpWDafu6nv29nrCV0EuqtTdcvhZcRiKr4HBK4AB4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eaYdx/ZiAS/mRsImhlQPzICyr6Gjf7JSavwvjR6UesaLAg7bEn5rLZvYZ4d8r4Zer9oXL/RHTKspHz0w6wibTpSpqnPE2PtwHHK9oMpg6qEX3+8D33Un3t+oXRl4F9/6xqx+a2fnS4ndFu2mzwsfB8MrKny1jdqf/JlSon/NA6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ESIRxnqR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nRe1aQLy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K9fapL028032;
	Thu, 20 Feb 2025 09:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vZa7ebNJ7GalmUda1bTzdYw1aguEFFU/9kCs4GIZNXk=; b=
	ESIRxnqR/dnSgy9Vppq2eqWLwCgY6IJUCBgcm0wHWRNHi7lwUpWs9gJCohvvDeku
	kz79nPz8tN2uGq0ky6iuZXbmZpJ5STk5f1PwA/nwbLL2G/tIryjCwi2V/EulYqE8
	yx6r5CeocJLj6amgHVfQcCdbFs2JOlD0foD692xcOPqPyxV+qeJls/q0c13Ku43y
	K+lGlNb65PVRXtyisJZJt93KO3xAthbyF50SHOtgQL8qdRxpxXiQEYcyPYQtikg4
	43tZowcCs3ekUiOeQfq5CUcFHNK/nQ9DNKG8jwp9V8hDIaH+QCe9l33o5J4QEzOa
	S8AwkJDrvmUiQpdP4sZB0Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00m3vmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 09:56:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51K94CZt010682;
	Thu, 20 Feb 2025 09:56:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07eqg19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 09:56:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K84dbJ689yy4IMqIn10iF83f0bz5d/kgZP9bdkRCfAO22SaFaFRr7CwNE7+9omWEv0s5SIHpykP5YdEig2mIRYo6XIV9j1G9mwPlXDzRvvZ1kIg/FcKVa3GwnXzUnCMKhj13MCI78gR7DWRpEjj+uZ3+NdL7nSkIzeoD+WecWoWc8tLYMoIq2X/6DyclNfYqnC3DgzaRKykEpeKTXdBNY7U73eyAERBIYLbHfl82ijEZalSMFMbhGBz6LqWmXlbIX1sk17McVwL9uzyvEOoE2SZ2sZON55ER18ORf1J2rgNqcgIL1j2jx7oMj0tHo9ApCvZIoCA8veIBVP2AeUx/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZa7ebNJ7GalmUda1bTzdYw1aguEFFU/9kCs4GIZNXk=;
 b=gaO81ZXYYUSvt1Ej+8ANz5OVvm6wN3REHXHj8BRcNIsudqB7NX7grYvdLe+extu2kDssxU0FDJHHyMr1GL/deIxAiM79xqs7o7QeXyZqygi8sw8fNv2CjcW4LpAmh8NdFKiByLEePVQ4e7njExxetNVGVSekYfMgl3L2VHFQ0WsthH1P3h/d9jUs28qNdoGWC2Eyko75qjl0QtUShPRERbIdyW4zvmLUkpQqe4bIt2t5Ed+guhjZck3Q9m8DL8UCOI7iEzFYw7oSx5Jph3igh9C4sszcC/8/+m7PjoS19PM31x/lV5MinD3O18IbjJ2wLob25+Ogp3C4Uato9oMGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZa7ebNJ7GalmUda1bTzdYw1aguEFFU/9kCs4GIZNXk=;
 b=nRe1aQLy4sDnAYOTpSWg6zUlhLNhtAFMVyNG3DOtNMKi87CWrkkwXWVHGKTDidoounlmeZj1+JdmWgrkeJNicKPIn/rM0N1DKaP4WVhLM0DdiEnPa5I9v8N+uH22+kETJgxbuiC+bMj6ZCwZV305/vPwE5BAy6F7mdxmVeIlBu4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7258.namprd10.prod.outlook.com (2603:10b6:610:124::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 09:56:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8445.020; Thu, 20 Feb 2025
 09:56:27 +0000
Message-ID: <4c951390-400a-48ce-824c-f075a37496a9@oracle.com>
Date: Thu, 20 Feb 2025 17:56:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/5] check,common/config: Add support for central fsconfig
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org
References: <cover.1736496620.git.nirjhar.roy.lists@gmail.com>
 <9a6764237b900f40e563d8dee2853f1430245b74.1736496620.git.nirjhar.roy.lists@gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9a6764237b900f40e563d8dee2853f1430245b74.1736496620.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1af8b8-30d2-450f-35e7-08dd5194d7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFIrcjA5R3ZKazFNbVowNVhwVzdiWi9wcmxaNHRaVGdhUGRNSWxleTlJSjZL?=
 =?utf-8?B?c2JFajNKM0hnMUFVNUxXRWJTYVpSUjJ5K2t6RktiY1R0NUNkeWZxdjh6ckJt?=
 =?utf-8?B?aStnUktQdXQ4aldGOHJnT1grUm5YcHZMVUduNWFaeFh3UmxZMXhja1hWVWxP?=
 =?utf-8?B?Q3hKZHNJV21rcGFmd1IwWTZFVzJWL2w5Ym9MUm5ERmRBemdhMWhBamhMcGxa?=
 =?utf-8?B?UHV5SXRFVGpiTkkzWEpWY3ZXcjV3c2l3c3hMVW9wcmEzUDZFbmNwdVFoYStC?=
 =?utf-8?B?VzcvYkgzYm9uZEJ3S1FzZG9FMjJMMTFFb0NrTThjTC92aU1sME94NCtxcGRo?=
 =?utf-8?B?RGRYSjhFb1QzcHpCTWxuaWxCa1duUC9WM0xzL1NtdExRUzFNSERGNFI2c3Ux?=
 =?utf-8?B?K1VpbDg0blB3aGJFWWkzemtxalp1WWxlcElSZlhBMnY1eThVd2dmUzlGNkxH?=
 =?utf-8?B?c1c1RFpJcjFSUzEyNGFuN1dudzE0V0xOMU9kYjE5a1J5RlY3a3RqczNjcnR0?=
 =?utf-8?B?SHhWRVR5SzVCOG9mMjZtdHlLekZkMGpRSFlkWkwzZ2h6L0hHbnc5aEg1emZ0?=
 =?utf-8?B?OVhnQ2FTckJsSzlZRThLSWU2N2w4NE82c0RXYjVJNUhjdDBQWEZiZHcranZR?=
 =?utf-8?B?Z2ZTa2tQcFM3bTlEM3d6ajNBUWpNNnFJTkd0VUtqM2N1bnZFVTBZbmRYeHZ2?=
 =?utf-8?B?NFIrRUdDbmZlYTRhZjZ0VEV1MCtGYkl1RUhvQVF5SHZsdnpUYldQZlpwTFE0?=
 =?utf-8?B?MnE4VVZscVQwaTNHd3lLYmtsSHpKY2dPbWpKbmdaYWY1OWlFVy9COGlPOWNC?=
 =?utf-8?B?RmduQ2hxUHdXeXhQN2djaENJSmVMMEZaajAzUWZ5NXU3eDA3SFdWVVVmVGJa?=
 =?utf-8?B?Q0kvZE8xdTBGbDlsSHZFZ3hka2J4WjZvN2ZKdXp6WTA1YVFiV3RFdlRBYzRu?=
 =?utf-8?B?S0oxTDFRWjdybXVmZC9PelRSVFVQNkE3cDA0NnArZnhBMXk3Y0xmNE13S2JE?=
 =?utf-8?B?SkJ0UnFQbFpRSy8wSlJwYlFoSWVTY3pmV1NyTzVzNklPeHBmK3pBcTFteGFJ?=
 =?utf-8?B?UFJrdGpjcWZ4UVdPNUNTRGZ1QjZyNnpTY1FJR0NDTmZlU2pVVGlHTTdIc3Nt?=
 =?utf-8?B?dnRydFhwa3FDVXBFbjBJMWd2SzB3SG1vdUZJWXJxYjRKMG5TRzkxODRYdUdW?=
 =?utf-8?B?QUo2bWxNZG5DWlQwbmF4YzFoRE9uSlVla3Z5MElQV2RmSWp6RlhVU2VzQzJE?=
 =?utf-8?B?OXpxUkY2YlhRY3ZNenhNQWZidnB0bi9nUXk0VDlqN1VHaTM2SlFRUjdFWm5T?=
 =?utf-8?B?bE5PelNDNlByMzVQdVhLcnFyd0gydE9LeWlyL3U3anRFZ1FRU0VzbDhvYzJu?=
 =?utf-8?B?eU9MOFhxQis0YnIrRk5PODM5dDM0cWE1S2tJbFZIY2l6bGI3T3hRZE1TSzY2?=
 =?utf-8?B?N1BVKy9kNWhIaXBMTTNVdEtudGJIZlpZV2h1d1lYVTQvVjJOVWJ3Zk5zaE56?=
 =?utf-8?B?Ky9HTUJBcFM2UStjWjVteHEvRE1LMnpwQ3h6eDVDeWowRWxGaFpIMHkvd1F2?=
 =?utf-8?B?QjZOSXlXWDJxM0RvcWxycWJqOTBHdmptbURTdnNCcDZIT3g4NkVqdTVQUTBG?=
 =?utf-8?B?amZkSEs0U0dqekZUUmNZK00vZjBoalVFOUR2emM5bUNYcUdiNjhEa2M0aEJI?=
 =?utf-8?B?WDVjSGI0cDUwQjF6VkcvdHlFWVRqTVhwY0VDZE5CTVdYL0lCVXpYY2NEMHh1?=
 =?utf-8?B?Q3VQZG5oY3haeHBUdi9uZlQxKzNOaXFZNXVDWDNLVDNWdTdoT21ldnlxTnRP?=
 =?utf-8?B?bUMyWWhnaUw4NHlhYyt2SlFnVVFHNkI0YS9QYXdUYlRET0w5OC9aY1gzL2gw?=
 =?utf-8?Q?X2oa+ltxzUZ6g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnU4NlRHdjB4Ung1M2M4cjBQdW5PWGxCMndQRmYxSnZDYVZ3Mlg2SDZtWS81?=
 =?utf-8?B?NFpuM3ZGalJDcnlJQ3JBWENJeWhPUGhHMXJVWWlYVWZDVTR3RFgxNWZ0eWk4?=
 =?utf-8?B?cUZEVUllOTNjYkhuQzljREU0TVM3aGQySHllZ2JGNUxLTGwyQlp6ZWE1bmwv?=
 =?utf-8?B?cXhRSWhwdjE2T1h4QWloMHA4WUh4cHdyMU0xTUNNRGNGTWdubW1HL1UrVk5w?=
 =?utf-8?B?SDF1S05yYmV1VEJtdGRRMml1NnBoZDE5WUkxY29nN1FvR3l2ejZJQ0s1bXd5?=
 =?utf-8?B?Rlo0QkZ6dVZHSnNPWlMwL1NUVFQ5TjdMNWdVN1MzY3BGVlVYa2NUcWViVVRw?=
 =?utf-8?B?Q3pwS2F0VEZ0a3ZQUWFhQzFWenFTK1ZwbGdiYUJmeXlBeEd2UlJpQytCYThq?=
 =?utf-8?B?UG02K2lFUC9lV0lxaTNHOUpINVEwMmFwRFNIYW5CSUkxeExXSVBOM01YR3Bn?=
 =?utf-8?B?MTRkeFpseHloVXhpN1FlejdTUTBvVzRraHd5c0dCQ3RlY0NlSXRML09xbFNF?=
 =?utf-8?B?VmI3dDRWV3I0ZVhJR0h6Sm5GMEFjU2hEVlhIYjVtblF3YnNMa0R4Y2YrS3JQ?=
 =?utf-8?B?d2twZFlmcUhnSXdVMEdJalU4WXB6bTNVVDFWaGVRYjdPSkdZYnhxb3kzL2NE?=
 =?utf-8?B?NkMxRjlSWjJoSS9uSG5rOXU1ZHpld2E2b2hlV1hwL0MzTnlwcy9nTTV3SnVs?=
 =?utf-8?B?K3pjSWlxMlRxQVNNMDJlVTlYcWh4SXdMSDlTVHZtQUwyWXZIN1hKeWdaL1N0?=
 =?utf-8?B?YXFpaUtzbU1adk5KRnJtUHRCemVGd1NSbEVRZWVFdnJJMjZYSXV4UW1na1BF?=
 =?utf-8?B?VDBDTFZuMXQ5TWV3VC9NaVZiQUZmYTFkaXArZmFzdXJ1REhRa2FzQjNmcjVN?=
 =?utf-8?B?KzR5VC9vREZyalZodVowSFlwY1BjdFQ1THFwcTlEaTdHbktvNDhyU3dNV0Z0?=
 =?utf-8?B?UVBVNENjL0xLaktXelFQRDdGNUQ1S2JFK0REZmFsbFJadmJnblEyTlo2R1gw?=
 =?utf-8?B?K3JNb3g2YU1Wd1JiZWR1Tk53RGkyZ29nYkxiM2dlZUtsSldTVExWQWtCYlRm?=
 =?utf-8?B?SDNtRkJiS25MUE1OWWttSEV3bWpNdkZSSCt3bnFhcWN1cUdpbkN6d0xZbmxv?=
 =?utf-8?B?OVMrcFVFQm1ITkJtOFVXMFhaazRBcEY4MGplUUxwL1ZsdDBheXFYN2QySktL?=
 =?utf-8?B?dGh6NFczZG44WlVrNHVNMnBqNEZNbVg5ckw2RjQyZnViNDM2RTVSQ1ZoaTVy?=
 =?utf-8?B?MmRQZ0YrS09vK3dEUkhhWTYwdmZkUnBnMnduUHRZQ01YenhvNnhoSm9OYlBw?=
 =?utf-8?B?RUQrczl2RStLK1JtbXlPU0Q4ckVsNlh3OWFuSkNNMWpWNEJIOWVrKytqMWY0?=
 =?utf-8?B?YkQzVW9xUG1aSGNOcllMMy8rWmpTeU9iZ25mOXhGbm1DWGhjeXdmU3JDUjl2?=
 =?utf-8?B?QWJQTjkwNW5ZSWlwWHcwR1dqbGIya2FlanlYbDRqNmFVTGd1amZ0cGd4NUFY?=
 =?utf-8?B?dHZhY0c2STVLZHFuRVVUdU1HdDBUUGwxcWFOc1FwcGZPMUE5czdnVjdpbnQ0?=
 =?utf-8?B?ZnA2V1QwclF5WUIxQVpLdWlQVmZPTzdjRm9ZV3NuMkNVV1BEd1ZJUVltOW9L?=
 =?utf-8?B?RkZKMmE1V01FK1JuL3AyRzVMVENOMWlpREpndXkwTDRRSWMvOE8zNjZ3R3Vm?=
 =?utf-8?B?RnJ5Sm92eFhZdnk4S0xBY3BnN0VPaGNpY21sYmZMM3gvR3E3eFJ5UU43bVlX?=
 =?utf-8?B?cEY1SUZveDJic1JKMmdXT0xYNFVWQXk4OERreU1iRzMraWtVWncxY05LclYy?=
 =?utf-8?B?TlhuN3o4eC9yTmhRYmgvSVN0N2xFakNmQmtIdm5ubys1dld1ZThqSHpNeGpi?=
 =?utf-8?B?Nlh5K2VOT0RiTXp1SmpyWFhGTWlaSXBIL2lDUkJ4OEhXSVRybk1YQkc3dzhs?=
 =?utf-8?B?RTNTZ1FXeXNvN3lqNmVUdG5zaXpBQ21xdTVnM0k2NG1raU1qSnZyMjkzeGZE?=
 =?utf-8?B?dTFQR3o3UitROXlaang3aWw1TWliQ25SQWVXenRpTlpyamwzaVZVZ2dFdnpm?=
 =?utf-8?B?aXhDYUY5WG1DcUFuODFueTl3UXpoOTBUYUIvc2FXTThDYUt0cE54Tjd0bzFk?=
 =?utf-8?Q?K215qmAUarN/SuNqd5y3HMfz0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IpN77n1mUAUQSiQoK5lxALaVukX+KHgRP63D1JnpcP9V4vrr1j1i5aJxWvC+wpIXYtrzp6rbqRulWfE68og4iRv2+RQ9E3nRXUxbEXPA3C6ONEnKQEmur92j8XPN6bKmJyehyF0sPoN5/PgSFXyz3p9JbV9xco3eaBjgNqD1O4pkTLCjZf+zCxaxk4x6V4OohLnxMuq8PkzUYpvtDLNl2AK13b0n7XmK7ityXSCYHfnWJscMlULXHrVYNyWRG9CZKO3ZCUAgnN2E3hmxaep1tCvpbrjth0kUARpBlvQsiASBMt0D9iR8M3SpC1Ny5AUS1mobb58QeJuegKzVPo9h9qosZymaoaWNwq2hW4TuuuMrSO1QKtljoL27LRk8lS1VmaD2fovioy32aH2oxPE+9+e3E1noIG5IxDWldFt7I2u/SklJ03OwreOhWg6UVOu3UbINLMK6lxAhWBJeeIfZEnOtlLsCE+BPWZB6vVnl5coW2r3CxYpbGGLzYZzFuZiqRLL1zFUKnkXu/I8XQwg7fwDYOtkWILUcxEhaijPyY3nQZKf/qbFi/IbfU54/aWnm7Rs9DtRFroD5rNWB+KxXNxT5Cga5bnzhnOx8Y6GUShY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1af8b8-30d2-450f-35e7-08dd5194d7c7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:56:27.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FK7X9fDpiqNOBaBEpzeA4uXMGPNQU1EJbE/uzot8L8CQAoRZaM4vcda4xg+/tpuM76ky/9nX85P7LxmyAGt0Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7258
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200073
X-Proofpoint-ORIG-GUID: 2KE6EgU-9U4CMBesHfOlVMYKl814qUmi
X-Proofpoint-GUID: 2KE6EgU-9U4CMBesHfOlVMYKl814qUmi

On 10/1/25 17:10, Nirjhar Roy (IBM) wrote:
> This adds support to pick and use any existing FS config from
> configs/<fstype>/<config>. e.g.
> 
> configs/xfs/1k
> configs/xfs/4k
> configs/ext4/4k
> configs/ext4/64k
> 
> This should help us maintain and test different fs test
> configurations from a central place. We also hope that
> this will be useful for both developers and testers to
> look into what is being actively maintained and tested
> by FS Maintainers.
> 
> When we will have fsconfigs set, then will be another subdirectory created
> in results/<section>. For example let's look at the following:
> 
> The directory tree structure on running
> sudo ./check -q 2 -R xunit-quiet -c xfs/4k,configs/xfs/1k selftest/001 selftest/007
> 


The -c option check makes sense to me. Is it possible to get this
feature implemented first while the -q option is still under discussion?

That said, I have a suggestion for the -c option—
  Global config variables should be overridden by file system-specific 
config files.

For example, if configs/localhost.config contains:

MKFS_OPTIONS="--sectorsize 64K"

but configs/<fstype>/some_config sets:

MKFS_OPTIONS=""

then the value from configs/<fstype>/some_config should take priority.

I ran some tests with btrfs, and I don’t see this behavior happening yet.

Thanks, Anand


