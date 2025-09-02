Return-Path: <linux-ext4+bounces-9794-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C2AB408C0
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 17:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13173B1A74
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54830319877;
	Tue,  2 Sep 2025 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gad5tLDT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LsS3G6af"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E07247DEA;
	Tue,  2 Sep 2025 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826314; cv=fail; b=KFhrNDzts0xHfoHFIU4YbSUIgcSnV3tInvtYjRdZBKjUDsWLzoLXTU+MUR97hF6OR1K58DjXeugIcJrOg/ky4A48EzfFEwdokWLa8obXwe+G/ok4AeCUUzVWToNxtO0uBvLTFhgC9wlTudUKJtb9w+DyV1+Glj0wE9WtaupdAlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826314; c=relaxed/simple;
	bh=MXDCkDD8zsa3nSzqnOqUsLS0CyNE6FNS4RNpz6y7SHA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dzRW4uD3oR0RZ5kYSBcLrO2NNQxd5nkK25gUnlmrzSIAzNtUuzThaKuY0BHX2Fp0OktSb8Xc5PeprSddnzTTOjyZpR4SJFq/qpWURjn/bTqqNKdPiAazgYrhvD7n56V86KQBUQLPflpczNMR3BSD0U/JwtS69uLZmD21hIlmGOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gad5tLDT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LsS3G6af; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582DfotK012830;
	Tue, 2 Sep 2025 15:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eKvkilIlG27GWkZ4OiRKppgNbKHZv8vkaye4mFEo9yc=; b=
	gad5tLDTtxKpWnuLvPrsuEY6tUkOII/6f8aR2GqmcYYKHmwA2Hqy+AQ8nTurZoMX
	yyhNeOI5S8tZnGF+mIN3r4DI1dVIvMHkto/k28epE0gJ33ejHGv8AWpGDLgbsVO8
	Ai/BuJf9U8fYOO8PIYXc0VPGmLmwVZIjIl2i13QcnJfZ7x4g5XLiEmZ2cTT6wBPT
	jQVH54B8BQ8H/y+F0WiXyd0sM+TgLczdK/w9DjTpaM55Fe3Pvv1GDGAuc0BPvzCM
	QHYC0RMKJMA+rkdW1oif0bjwyHzmXgdpAeqqUZzjXN3eDUY0Ib4F+qZv2I5E612d
	hrcXAIGElF6ldg2dj8CEbA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmncbdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:18:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582FEMx7040664;
	Tue, 2 Sep 2025 15:18:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr90635-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:18:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYrhzZzPVnuu5C7bQHPpE5S39WCu6aBqmIuXPAafcUcYdXI8aTCQ4W7AmzASjINh8BtGc9GImFBOZ4SlXNTf0tbHgDkAkmI53olS/C+zVVfXE99KrlMQ3Zm7EKmtQ+/yGfQTJy0/UKfBE0WZNC6mCeXycdg2RLNAsFWp3q5BjsjX8OlOGmTG096wXKvZI7gsWMSi8braFW95hAyKEknlvOQlljxh3vCv0XpBLYCakVmPYhMhcCJWvVd3//Cq1BEv+qmKVvI5c53B5jK5fSlBn/xY3MoPZwEsF2TnWX7Oo8jonUEVF/PmRaJ0si45L1O49ezo2dVe5Q2IpzJuBx5doA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKvkilIlG27GWkZ4OiRKppgNbKHZv8vkaye4mFEo9yc=;
 b=N07JxLPNNm7JSy9mMJH4mFQYUVZxNv9zQX8VwTU1y5W0wWYjdk3yKwPbwELke3XTpZ8ImRrZJRQvDnhD7aa0Evt/meroxG82YDWht3BNV2UchZ+WSV32ExEpFA6yVAVAVEb/sNP/EcURjyO/yEH0S7llO+/5Y2nirzOMgmqYIo9rgxFCV/X0FT8aky8tx3y8wnTkrHKm4/B2ulnkn3aw1AxhjqqI++KHTUNLBj5E7FETC2QKAw8zwMXOkjT3VFkwuSXgeHB9YxvhtngckMFbYyTTJMwoW6Pj9+qUM/LzyGpyzfcXHQ4d1eMHawL9tsLfAgqiWs0nBNUw/NmT9qkW1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKvkilIlG27GWkZ4OiRKppgNbKHZv8vkaye4mFEo9yc=;
 b=LsS3G6afhq4aAJ9vdJ8CNQqrRwbpHKH+uCnG/TdoHAFqd8VfTkEkb3KNgVY09iJakALRN7dkMX84+rXfN+GrdGtEVmH7wKpj15EZsNnAycjr5ODus5N5rYiAxu1NeNuAOh3OljYJBYPDlM4EMAt4usvSOX7N26Kuiro6hx3ZWoA=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by IA1PR10MB6688.namprd10.prod.outlook.com (2603:10b6:208:418::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 15:18:04 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:18:04 +0000
Message-ID: <e1777c2f-9f49-4795-82f4-3d435d79b280@oracle.com>
Date: Tue, 2 Sep 2025 16:18:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] generic: Stress fsx with atomic writes enabled
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <6d0de75776499a6751ccf12d2c3a1f059396b631.1755849134.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <6d0de75776499a6751ccf12d2c3a1f059396b631.1755849134.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::14) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|IA1PR10MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d6db30-238c-4625-f796-08ddea33e985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGYzMG92azV1cmlDZzA1NHFCTDA3cGxOb2poRUJNL3VmdGNrb1JnNllxTWtG?=
 =?utf-8?B?R3pqZTlwSXVzWjZxS05PMDMrTTRZQTh1L2gzUStGR2NMUkdXWWE0NVYwREhz?=
 =?utf-8?B?ajhVQmlxb25uTUczL0NNT2h1RTNTSUJqcXh2NG1xZ1JCVEhUODJiT3NNVGxr?=
 =?utf-8?B?MW1mcEZycVFtejBZVGRWcXJFOFV5S0p1bVR2OEwyMWdXWjQyaGt0UDBzcHpL?=
 =?utf-8?B?SEMzMmdTU1g5bkZVN0VVL2pCYjc4cDFjem5LaEttN0I1VzdDb3lYdWxCVnZO?=
 =?utf-8?B?N0lCVTRsTkhlenQyWGpoSVV3b3JJeEkvcUNxdzdVTDlGUmplQk1QNlFXQ2JY?=
 =?utf-8?B?ME4xNlhZWENSRFNjK2FHNWYxcFlLWWtpeFF4blZKYzNDanZ5VUdUek1UQ2Vz?=
 =?utf-8?B?RUNVWVJzSmpMTzVqT3RGOGpLSXEydnFzOWRVSUd6Z1VJSmp1RGJzKytSbURB?=
 =?utf-8?B?TC9tMlZka0MwdXlrWnYvZDg5QndYWk9zeVNpT2pFbjRsRWJSQkJJMTY0cC80?=
 =?utf-8?B?YzE1dnNXaDRmL1JGMFp4SjVKSXhtSjVFZERtYzlrV0UzREY1U0FoSVhFNWJv?=
 =?utf-8?B?MjE1V0Y1MWhkcmJpYU42bUJzb2VjcE1yY1drNVUzbHQrRzdiTFdjZndWemFy?=
 =?utf-8?B?eUtib0NmYytkbTRhOUVPMUd6em80aGhzK1A3NEoycCtTalM1bTRGM2kvV3Jt?=
 =?utf-8?B?SkpEbGJLTmRPbkhqK1hPOEtqZ0trczgxQW14QUNpd1J1R0NRWTlILzlaeXVB?=
 =?utf-8?B?bzE2eldyRVlXQ1hCN1J6SndKcFUzaXVqODhLeEc2MjJIenNlQklTZHI4MGxB?=
 =?utf-8?B?YmpZWThmeUltTDIwQVhSNzZEb1Rpb0lpZ2EwZFZqdkNpRmFDWDMzcXZrdzVU?=
 =?utf-8?B?Rm5YUTZlOUg3d3V4UzhpZjQ2RUxvQjBOWldQQmNaNUJvN1hKeGZNdTk4TE5R?=
 =?utf-8?B?ZHlocVBVeGtYM0p2SDVHd0ZKSEZCelNTZWcrV1grQzBsWkxqSkt1ZjhzekxR?=
 =?utf-8?B?Z0p2NzFqVTF6WkZDOTVqSWdFMWpRSUdQYUM0N1hqOTA0SnI0MGFLVmJjZkRR?=
 =?utf-8?B?cUVvamNPMG90dTJjN1Q4dnlxTU5HTjZpcmRkS3BLYUtuK1BXMnZJYVdsZGhK?=
 =?utf-8?B?Q3lxK1FUVTliUUMxdVdCZFFrUnU4WXVmNVV5YXYvWUJzS1hCOXArbERCb0tI?=
 =?utf-8?B?b1RkUjcvMHBRSTE3VXd5aGg2T2ZsOGJLRElMeUxtL09FUWlCSkJZZVlpeUN2?=
 =?utf-8?B?NU9oakhkRmRvK0Z4K2dtRjFZc0hHdWhjeEMzS0EyekhjamF1VkdyeG9ZVWFN?=
 =?utf-8?B?U3BkbUVxRnZVcGsrUmYwV3k1bGtNZWxaWElLREtCbWphZG5kNkpJVTYrTzNY?=
 =?utf-8?B?TjZnL0hhV2h5QVBBT244TmNwWmFjZXp0MmRTc3cyMkdtYkZjbUxkSVJGVzBj?=
 =?utf-8?B?bFBSS3dBUmlvRkppeTZNckJIdmd3TlFOM1VRdTNNQlBwNHI3Ykg3RU1oTGZU?=
 =?utf-8?B?bkdLZTRFRUQvMlRNVDMyL3FTSlZKeXpJQUk2YlZ3bFRjT2J1bjdWdW1kQTZZ?=
 =?utf-8?B?MmM1R1lyaTRmRXIvajltQzZrc043c05OOXVZelAweXo2UlNMcTVycVVDZzd0?=
 =?utf-8?B?TVlqVVpYUTVCOCt5RXNSS01JN2hyK3FGeDU3bVZGUU1yWWxsZ3NleXhXSURE?=
 =?utf-8?B?Qk5iM2c3bG50TjRPYWpLdlp1T1BENThBaTZvL0wwNjR3UEU3OGF1K1lmWG04?=
 =?utf-8?B?cnZzdm9wTTUxM2R4NTN5eXVMNUlrMm4xc0w2dUFrbUsxbk9HUk55RDlXcDEy?=
 =?utf-8?B?YWlqWTRSSHFhMmt0MCszU1NLNWQ1YnhYbDB5c3Jpano2MkZDVWJjdE9oVmFn?=
 =?utf-8?B?WUw0WkRNWW0rRE5pZmp2OVUxLzFpN3pyU0FvMDU5TjZEaDFSbVdSQ2Q2MUFD?=
 =?utf-8?Q?pFAbgauUzUY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGhVbXhXalg1eWpNWTh6YU5tOHhsUW81ZCs2dFFwaHBkSCsrZUxlZVR2ZHB6?=
 =?utf-8?B?NFlBdUZNWUNGQlM5S1RtYXBBU2o3cWtpeHl5N3RwZTJVcktMRGVjdkFlTHBp?=
 =?utf-8?B?WEhFQnR2V0hJWlZseExqOU9mdFpUNU51c2U4UHhSd2JqVUpLWEZ6SGZTd21y?=
 =?utf-8?B?S2l3bStwNzh1UndHdEUxZFlPeVFYNEhkMHhDQXFoL3FGUC9qSDJsWUVKQ0xM?=
 =?utf-8?B?LzBjWENJYkVWN3FXdWxBeHNBUW1FSU54Tm4ydGxSeHBtNVg2d0RsdkI5aWtm?=
 =?utf-8?B?d21GbUFVT3YzQkhBSUNQd2VWK1JtNDgrY3VUZzE1ZEhzZVdaZzFDcS9EQy9W?=
 =?utf-8?B?Ym9ObHhnWGtuc3NJbk00Z0hsQ1Mvcmc2Mm1PamI0QnFyNkZuNVRIcEZPUmw2?=
 =?utf-8?B?SzZWcDNGZitvMDMxV2R6MnkrcUpIaDF5Nzd5V1ZLUWdNamp5blJja25YMTJ4?=
 =?utf-8?B?R3JxeG5SemJocUR1U0hQMUtHSENsOGFVVkR1ZEx2U3hwWkhGMVV1MVJmN1gw?=
 =?utf-8?B?eWQ0T2w1OXNnb2dZbytVYVZXTDZmZi9VTlZaNjdGeHlTYkV5MHgwUlUwT2Rx?=
 =?utf-8?B?Y1pUWHlsV1Z0b292MWNjM2l6NDQ2RHIwMS81T1FvOUpKU2s5ZFFWci9zVjZ2?=
 =?utf-8?B?YkVRZ0gyWXNOaFlXQjBlaDVBcDRYUDJDK3hLck9JVXNvSzJaR2ZjQ043bHBz?=
 =?utf-8?B?UmJ5MlJWemVnL3lKRkl4YTV5dzd0MHdleWhOKzhPTkhIODdaWHUrS1NVWjhm?=
 =?utf-8?B?ODhEYVdvaXg2UUlxRDczUkcyN2pZdlFoK2RkYktXSG84RHNoWHp4eWVrWGZq?=
 =?utf-8?B?RlI3UmxKYUFkRnpTNE84cXRVNjgyTS90TllHN01SaTd3SkxESmVjZ0pXeUl5?=
 =?utf-8?B?T0poU2NjcUFiRkc3UkN1cnhzZFFoQkJLOFB4ZFpVSStHSm1GOFVIVzhaZDhr?=
 =?utf-8?B?eEVNSllCYmJrbkFxVzlDYXpBVVE4L2ZxVCt1c3IxVXVPeHNBdTJUVWRKSkNT?=
 =?utf-8?B?dTFaVmxsaTF2TVJXaFpVL1BTdHN4Y0lob1l0eWp6TnVST3d2N0lTODFycXpO?=
 =?utf-8?B?WUIwQWhJVUhIRDBOTlQrclhrR2l0RTRtb2xENDBtUXdBSUJ4K25zWG9YQ1Nm?=
 =?utf-8?B?TnUrTERCYWZZVEZZVlVLY1RCN1huamxQMkpXUjdic2tvcTZNSkZsVm9EUFR6?=
 =?utf-8?B?QkhNN2lYWGJyd051RUM5RldRMlh4YnlieGNPTTNrcE1LM0VoS1J5OUhXU0Vs?=
 =?utf-8?B?VWZnUy8venJPdjhkb0s0U1NCZFdJZzFabkFLOWxTTjJ5NXJSVlBkelBFdXA1?=
 =?utf-8?B?VFYzVS94Z212VTNvTjlJQlpXaXNOT0RValgrWEp6cnRjUWJ5cC9aU1kxb2hh?=
 =?utf-8?B?aUE5aENGTWs2d2xKZGhPNmJqU0VJcnRFT0ZnaWJENER1NjZOTkkwNEFTNkZ5?=
 =?utf-8?B?SHYwZWJ2K0JwM25BUlZDMmVTUXBnOWx2OWlLVmdyU01yUnUvY3Q1SEVqWjdM?=
 =?utf-8?B?TFFQZUhkcGpYdjJTVlB6RUQ0MFM1U0gvMUpCVlpLR2I1NVVJOUtrOWRWNlVk?=
 =?utf-8?B?NThEOCtNUXhFbG54RzZ0ZTRyRm40eFBEY3l0UDRzc0UrNXNJT0hJK3VDSlRr?=
 =?utf-8?B?S2lQbXBMQytDS2NiRGVTQWQrekwvVjlKSXFZK1dsTThMazhtdm9YUEJZRjhX?=
 =?utf-8?B?aVE2MmtPcE1iamF2aVhxWjc0ZmF1WUdsZldWN3UwSWs5Q3hWeVB2cUswYnA1?=
 =?utf-8?B?WXUrcEpYeHdlRitGT0p4eEtwUnZ1WVpYczhLTmhkZWI0eU1Ec3RVSGl0ZzBs?=
 =?utf-8?B?K0hmT1N0ZUREeG1QTXpuZHJpRHFiLzRiaDlMNVBXOVBXc0dCUDVGU0VVOW9v?=
 =?utf-8?B?eVZTY0lLU1hha2VKWkNORndtdGJPRW1LK1Q3TzVKN3NJR3lCSnAvRDNmZEpL?=
 =?utf-8?B?MzlRUGt3alNnTm43Wjkxc250N1Q0TlJiMm13clQveitBWmQram5vYUxjOUhw?=
 =?utf-8?B?ZTVGMlAzMkpNeWdFcXQybit3NlpuS1UwdXhFT0lndUswQkpoTGt6VjR6L09Q?=
 =?utf-8?B?WW9sUVlVM3N3d2VFWXlhaXFuMndXNEVOTnBaRktGSGNrdnF0OTFZYkNMUGVQ?=
 =?utf-8?B?SHhzVThQRXFyZW55MTNETHE4WktGZE1xbzl2bGhZallDbU9WdE9USjZVdFo5?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+A40JxNOE1eoZ0quKQJ2hRexcU7+m0QkaDbcipyUqQHJ31xiGQKFqIEhkpWrUSRS1RNEwslNT5iX7lqoOPHpdQrQQqqMBYR9PfeciTZW+d2SuF5mDxYhtGl48wt4udBlluml8Miuha/aVCUvNs3xjQ9pMAj571XzZt5TQSlFq8w5l4uv4Me3SQL5TNOo+fesaOUv/8/ru20Ovp2QN5cWr0TjQFj01R/4/cTDaGQRdt9rm/L/DMf20A/VVta4TeyiSRuKU0d/ryEnk4SMnPi9OEw7lbZI/Y76gUji3ox7wz0boCGz0Q1LzOHwObGe3YXA6QLYWj2nkvhycQrbq/QzaW5LLzty2MNOYMI7nmP++gOvyYMHtJikT81kkiq+lvNuguSNxxMS5qBRIiTzOWW2JjVZu7ftx4Eplcx4Qj7yy0DL21bXizUtdsqYiAEB83MNfBsB9G/TUH/+4wg33c0Xr6eF9cPT+BcFEOmJXAmoW042r3oPoWtAJGE8Cnq10zYHK95ivuduGPqi9Xkmt47mWhnBepvn1aKGdxb2n/lSAkmcbl20xJzQ/GT2gqZZySUC4eKR4OrF7Dn5UKmK0IDbEN7qhC9UlH9s2P64tMSnx38=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d6db30-238c-4625-f796-08ddea33e985
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:18:04.0697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEYGbfBtYQ7Usre1yo8Dtji0CirPMUSHsoPIni8qz5YODSe5La2Td5eSy/CHQanv0j272PnIeqNKSWqzItdm4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020151
X-Proofpoint-GUID: _m_NDdGSxmfgGA4WfgtLugvD_n63qIDG
X-Proofpoint-ORIG-GUID: _m_NDdGSxmfgGA4WfgtLugvD_n63qIDG
X-Authority-Analysis: v=2.4 cv=Of2YDgTY c=1 sm=1 tr=0 ts=68b70abd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=ToPaCub0iNlAPZCLdaQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX7GkvWnU2AUSL
 Nw9DcKrcn9g1zGmZRPFAI57fEApd9qCUiFNqsbWHZWivX1DxVTRynPCZQBbht1RleWChbixeJyc
 7r1mUgy7mnqlrloQkG2I4A3xjyhfaTG+m0l+1odaiL+RFJYUywOo2A3idpgSn1Loa/TK3YOK1WT
 +NrNLVj7li9+OUW0l4HpEiF2asKk9JaOWRUfnYBBdmruzjeVk4zaWqQeSMwnkdlre56Hg9jjBgZ
 3Km/jhdDOM9t19Ej6TPf4F1CJk8hppWxZMuAj0MuIrLnAwt83IF7XwjnDEv+2oJYGoUbZUwGilj
 dgK8s+RrjmBEY+NgjP2a7OLeRRwD2CIMVrx8MtL8VNyXxk1+hdcAPLLw8y+YPFCuTfUlTANtIw7
 dbxIZTET

On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> Stress file with atomic writes to ensure we excercise codepaths

exercise

> where we are mixing different FS operations with atomic writes
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   tests/generic/1229     | 68 ++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/1229.out |  2 ++
>   2 files changed, 70 insertions(+)
>   create mode 100755 tests/generic/1229
>   create mode 100644 tests/generic/1229.out
> 
> diff --git a/tests/generic/1229 b/tests/generic/1229
> new file mode 100755
> index 00000000..7fa57105
> --- /dev/null
> +++ b/tests/generic/1229
> @@ -0,0 +1,68 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 1229
> +#
> +# fuzz fsx with atomic writes
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +_begin_fstest rw auto quick atomicwrites
> +
> +_require_odirect
> +_require_scratch_write_atomic
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount  >> $seqres.full 2>&1
> +
> +testfile=$SCRATCH_MNT/testfile
> +touch $testfile
> +
> +awu_max=$(_get_atomic_write_unit_max $testfile)
> +blksz=$(_get_block_size $SCRATCH_MNT)
> +bsize=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> +
> +set_fsx_avoid() {
> +	local file=$1
> +
> +	case "$FSTYP" in
> +	"ext4")
> +		local dev=$(findmnt -n -o SOURCE --target $testfile)
> +
> +		# fsx insert/collpase range support for ext4+bigalloc is
> +		# currently broken, so disable it. Also disable incase we can't

in case

> +		# detect bigalloc to be on safer side.
> +		if [ -z "$DUMPE2FS_PROG" ]; then
> +			echo "dumpe2fs not found, disabling insert/collapse range" >> $seqres.full
> +			FSX_AVOID+=" -I -C"
> +			return
> +		fi
> +
> +		$DUMPE2FS_PROG -h $dev 2>&1 | grep -q bigalloc && {
> +			echo "fsx insert/collapse range not supported with bigalloc. Disabling.." >> $seqres.full
> +			FSX_AVOID+=" -I -C"
> +		}
> +		;;
> +	*)
> +		;;
> +	esac
> +}
> +
> +# fsx usage:
> +#
> +# -N numops: total # operations to do
> +# -l flen: the upper bound on file size
> +# -o oplen: the upper bound on operation size (64k default)
> +# -Z: O_DIRECT ()
> +
> +set_fsx_avoid
> +_run_fsx_on_file $testfile -N 10000 -o $awu_max -A -l 500000 -r $bsize -w $bsize -Z $FSX_AVOID  >> $seqres.full
> +if [[ "$?" != "0" ]]
> +then
> +	_fail "fsx returned error: $?"
> +fi
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/1229.out b/tests/generic/1229.out
> new file mode 100644
> index 00000000..737d61c6
> --- /dev/null
> +++ b/tests/generic/1229.out
> @@ -0,0 +1,2 @@
> +QA output created by 1229
> +Silence is golden


