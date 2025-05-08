Return-Path: <linux-ext4+bounces-7764-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF5AAAF997
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 14:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853181C0558C
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 12:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40FE1DF25C;
	Thu,  8 May 2025 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dNziuz/Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZGQmPKZK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8CD136A
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706616; cv=fail; b=Ca0Gg1iDm9mgcrMczf0edm8s0bUkSYrT9ax98Pa6JJ9DcJ0dO+slP+yQV78oO/d5G99e1G7QKfq4Y7dWKMWtKA0wjF2PRV39XEMdOiXDNITmM9l1xeyoUlvIlGVhNXoP0Vdo60292ziKXRxLQgZf9V67Ai+277rj9HAcBYT6dt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706616; c=relaxed/simple;
	bh=Bes7IGm852jU7Jez+tkY+V1ZdJKeXBiFMdXAewuoN3k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aHe1v/OGPlmeVVb9oJdg5y2SpOaiAJoLKTncLgQ6d619iBNQgAHkevWqIlZ6cFG3EAf0sWB2tP4vIadIlFn2evSRrxm2I3aI0bd2ik9/JUdOzloIvn8rRP5pNdGhy8yIt7kd06pKap/0WMCxTSxVv7BwNqbpQupEnhAgf1J7HOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dNziuz/Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZGQmPKZK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548Bt9tU010282;
	Thu, 8 May 2025 12:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CCC3YU0PsaMcHLTLNd/1ux2PGWtAPRhtg28xl2mGy3k=; b=
	dNziuz/QhZUWczPhQ0WW9wHXJx9pnzAqwT1dvPXGuZdEtvOaU3XFLO8vajStKsxm
	B5LBYDHxZBeMfi31PpeK6Vg1y8O+a3qoAP0ihYIS9s+soQ1oUQVgz/Qv0gpWuEaG
	PMV1rO8VSJfdHRXmKsT95v6cR5ZmKooF8GIeG2fjWbfV2Y5lGm+mwfmtNkfEhvsF
	bPp5hB5JT5xTYaDnhUD7o5u4JJAl/Y+3ljWZ2rEN9Dc9c2a5YNH6PCFLfhaZSO8P
	ClccjFuKSb9WOGgIrEBkSh5O6sLM8Kr717mxEKAHqXMgjIdju1G4DBVFFvI4yv3q
	0wX4CspjBVsMN4MYsXpF/g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gv55g19u-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 12:16:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 548AH4YR025122;
	Thu, 8 May 2025 12:01:43 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011028.outbound.protection.outlook.com [40.93.12.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9khuxk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 12:01:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8OEXHzF0JO/azlSk1yBPwxiP9ePtgP4LQeiNDE3+EHaX7chFfNzx/ykvKyibcZ7N9p89on2zT5AP4HYJQvnBg+rlfmqWrxYVsKxuT3BB9f4dqovmOvvXzjtx8lD8NdhiiQZCkvuQO/npL7L3cgT2hmSDkvGW53mFLG5wsoNQTxU2ADAWRnxexpgHiGFp/n1pQRKqMQSUlMaZcaQEBvsIg36OOwg/b8zQ2aP2pFs3m63scjzUzWP9NSZBuhEmJh+iO4waF6SDwhOiHhodBFb0u6Dzo+jCqAQOjR7p4qW2bVhhVh0iVjizBBMiS0K5pHrynks/hdJ18YLLmKH7tYQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCC3YU0PsaMcHLTLNd/1ux2PGWtAPRhtg28xl2mGy3k=;
 b=YSipRMqZyfetBPaA4cZu8Y0QYeGYvIXCdB+2wUavLkLq8k/yN5Q82n+VxaPTA4E0rObifbP6o8Kf/7r0woYZ3pTtDuKZm5dnTONYvtK+z5RRZGhXzIuhl4Yn4n/QlK4ZdnRgYnzxLL428nR30pcbQuGZ+vU2Z1NWpWdcVqX1LF5KwkC5PJ028QHerPnRJfJJte1wxspte0YwzNbJmi5KeMpy5IsSeAiYyl2trceu9QWyVbsGnftNi+UeiI+s0cOc3PN03gHdAlp5ctrOzuI1nPJg74ZUn+69SbEzm+VCiXLA4ymHh6XBvkBmgRO/b+e6OBoW7LxRdEicp/XIMWQkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCC3YU0PsaMcHLTLNd/1ux2PGWtAPRhtg28xl2mGy3k=;
 b=ZGQmPKZKP15VmSvjGA6z2ziSsuQH3AGN6rFtImL6f5T+nEWmGhexQ5Bdc/tUQzRIh+n8fmU16nT627U1ptO9T7DJO5CuikG51VwVF6BRNZmBE7uWOOlONMUxNU8HZbaTHf+MnmVSpZS3BuJNXXR9Ns+guB7SdKD2DO1ItyPr/pg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6076.namprd10.prod.outlook.com (2603:10b6:208:3ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 12:01:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 12:01:37 +0000
Message-ID: <d031d255-b528-4870-b933-475b969aabdf@oracle.com>
Date: Thu, 8 May 2025 13:01:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] ext4: Add multi-fsblock atomic write support using
 bigalloc
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc: djwong@kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        linux-ext4@vger.kernel.org
References: <cover.1745987268.git.ritesh.list@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <cover.1745987268.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 733f474d-cb74-4b50-1747-08dd8e28158b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm0rVG9YQ0l4YkV2SndpYzVrNXhVQmU0dm03cThzSjUrUXJGWnRndy9BNGk4?=
 =?utf-8?B?L0hGY0VxMjRwNHNxa0NKaGhmS0VVSHpXUU11bHRjL3I3WW12dElPUWFrYXpK?=
 =?utf-8?B?UWZzVHhFazgwdkpuYk4vc0lWU0NyaUpKVExWcjVSMkxXUnR2bjU2SVE4UkQy?=
 =?utf-8?B?andWdnhDY2lpUXBqN0FXYzNlSlFDRFh6bzMyZVRVS2luV3B1U21JQVlWQXk2?=
 =?utf-8?B?QUdHVnJXazh2MmRDNHRHZTlkYnBRYTNQQlFmUDBjaWlmUVZGeVNWRWhpb0l1?=
 =?utf-8?B?cjJGdkhETlk3Q00reTVQUUd1K1ZmUEpMRWgwY0JjUUtDMzFVTkRaakllNll4?=
 =?utf-8?B?c1BEd2F0eU96cGVTNnljTXJ5MFlSTGFkdklweWFMMkVyNXJUOWJtcTloV0pP?=
 =?utf-8?B?SFZZQnRvdmVBRElsdzRreE9Md3lFTzNZVERGNHZoNDRzem1rVmdpRWdRMUph?=
 =?utf-8?B?L1ZaQ0F5alpEc2NIekZKbE1MOUYzNEUvL3NhK3J2QTF3M3BEOWVEMWJvQ2JT?=
 =?utf-8?B?OEx1YUhaSm51bTNTVFF0bVNMYVRvWVBaYTkxTHErQ1lMbDRqK2ZYWWwwMm9P?=
 =?utf-8?B?YTdqZTVHdlIrRVBqLzFGZ2l6TTgvNGppaktOaXdhVXk2RExDWFZVWmtqdE05?=
 =?utf-8?B?MGdUcW1lK2l3VWp6UE80QmpvZG5vL0ltdUVaWWNaUUlKOWJLQ0Q1WGVyVzRa?=
 =?utf-8?B?c3FtUWN3VzBNbml5TU51Q3FKdnpPL2h1bEhmLzZLOGdhSnlSWUp6UjJjT1RB?=
 =?utf-8?B?MHZSMFNleFh6cjByZWR3dXFVTUFEakJ4Z1hGSFlkeWIrMDhiN2ZOdE9SY3l5?=
 =?utf-8?B?M0ExMlNZdDdOVlduVEE4UkFtUVZscFg4ZnRUUmREREcyNUV5WU9oUW1HN1RL?=
 =?utf-8?B?Wng5YXNiY3lFU1lpOTR1UEI1RjBSMitvMzk4b0dtZ0JwR0FpV3dJU1BOek1W?=
 =?utf-8?B?NGpHN0VTYlJ6TFUwd3RieWE2VTIvdVZUVnk2eCtyZGEzR2ZjNi8zZWkzUkRu?=
 =?utf-8?B?WmUxdGx5YWpZRmhXdXE5dXNuemVPd3JCUVpUNEFCeW5QRHExcjJuWjdONlkz?=
 =?utf-8?B?L2JtZkdGbWpiUGJaQUNaTk0yakhselhxMUd5dmdtdGF0N0lpZUJzbFFXUlZX?=
 =?utf-8?B?UVUwZUZXaWlYZERTRG9sVS9QWFFSeC84SlByNGdaMDErZG8yZEJjNHAvT2JC?=
 =?utf-8?B?bndWeTJpdEtUL0xtL2NTajVVZ0FMUldPNnJYNHRjMzdMV0djMFE0NE94UVF6?=
 =?utf-8?B?SWdsekhPcE5SN3dYQWFFS1RBTGxpU05mZWdxRUswZ0d2aUxUUUp6UTRKV2J2?=
 =?utf-8?B?RmNVYzMzaGNPNVA1aDVpU3ZqcUlhN0dpVHVsTzlKOEM3bU14Q1VGRVMwRVZz?=
 =?utf-8?B?Vm9sUzU2SmJXdUx4eCt5dkhERm9SRzZDV0RQYmgwTkQvOWhiYXl4QTQ1ZU1J?=
 =?utf-8?B?SllPTzBDZzB3cnpLaEJIQUZ4YXdxRGtRc2NOcEVtbmNCdytTeTdBb3YwQ0sv?=
 =?utf-8?B?MC9oRGtXNStWNHFSb3VHazM0ZEx3RU5DSW5WM1RadUJWWVVIUllPM1pIakFM?=
 =?utf-8?B?YmN1SVJpZXpYRU5wWnNib1FkZFM1cmJtS2xpcUtxMzJHVEg4OU0rTE1VdmxT?=
 =?utf-8?B?OFBYQ0pYQkpHakcvL1Q1RGhTK3JHL0tkNDZEZEN3eGR6OTBYdXlIckdKMENm?=
 =?utf-8?B?MmQvVjFsVXR2aW1VUXpwc21CdzI1Z20rUC9IRG1OVTRnODF0aUNQOHgyaGJP?=
 =?utf-8?B?VWJTL1J4bzBocE1FaTBnZlhXVExhOWJCbnZqM0Z1dEVRSzNYMVZhVzczajR1?=
 =?utf-8?B?b3lLVVR3OEVBWGVVcy84TDdLNmV0RlJUSFhUZVg4MnZObGdMaUpRdlEwZE9u?=
 =?utf-8?B?cHNWbHdpVnljdldGc0xUVU1MeGZWaXVjVzlLcGY0VWhmR2NpekcyMkhQNU05?=
 =?utf-8?Q?CiLjXbQgFFw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0Fia250YkFsOFNzZnVlUXJYZU1WTEoxazlRMmJWdU9zNFJqRkNCcWlrb1Y1?=
 =?utf-8?B?YU5iaS9PeHZUbnk1eEswdUdPRkhPU2ZHbmIrRGU0eldMbzlycEg1TERhQUVW?=
 =?utf-8?B?VXI4V2tDbUVyemtXVGRvRWVrOXF0WFY0YW0waFd0ZFRwdU1jYkdjOHNrVk9n?=
 =?utf-8?B?VlROa2pnQ0tzWGFGZEovbjRyMkc2bHVBK0F0OHJKV1dnZ1QvOUhnSjlHWDBQ?=
 =?utf-8?B?MitoVkIvUnJ4YXRsZjVzLzEvSC9ZdG9VQzRsTEF4VFplT01uRHRMM3lTaGt1?=
 =?utf-8?B?cUtaL3VIVTFMZmNCL1Q1STVjSE13b05BbXZxZkpKTTBLK00wYnF5VlBvd21M?=
 =?utf-8?B?T1pNSUVSRnhrNk1VMHMzS08zN3dXdmlJR0czZk41MGw0SWRDR25hSlRaazJo?=
 =?utf-8?B?WVpDK0dEN3pNUnQrbDlwWWVBY3VxU04zckJYRm5GUCtxM0N5VTEwMENlVmVG?=
 =?utf-8?B?NDVESENWR2Z6aUg1MktHM21xZ0VJZ2g2SCs0TlBKTWRSL0lEalRCbC93RTAx?=
 =?utf-8?B?NU9qZ1dHMk1POUpzZzFUV0g0R3o3NEFjM2RHeTY4Njk1UUVtR1FLUWVOclhV?=
 =?utf-8?B?NmFuMGxhZ1JQNHBDdHZoZC9oQ084bnllTGlvL1kxWWFqYXl1Z1VJL2lYbHZF?=
 =?utf-8?B?OFdQNzZiNDFSbXZGYkVIeisvUHVPWnQ0dW8wOGV3L3dPQkJqTmdFMXpBc1lN?=
 =?utf-8?B?bis0QVphRVpLQ2Y1ckhsZ05nV2xSeGhyWkVYQXUveUpRb3lpOXBNYUZCK0Z0?=
 =?utf-8?B?YzF1UkJBZFdld3lvS3hsTGxPYzRRZEpZd0JsdHpBZ0s1WHdXeGN3d05UMkg4?=
 =?utf-8?B?V1ZIcWpOZDJ5bDhuWGIrTy9CKzU3bmJUS0F4bXN4S3paQ05FazlzZVVhVzZn?=
 =?utf-8?B?UUNaM0l2MmRvbWNSQXpqK2VOSXN6TDRhS0N0SzNtcmphN0ZodU53MTQxTHpk?=
 =?utf-8?B?aWxDVkV2NWNrZkFwaFVOUm9abzVKTzEyWmFVTS9YYmZwODdldWJ4RjRrbHRp?=
 =?utf-8?B?Q09uZXYyN0FxclRUa2tJWERZNGE4OTJFMTY1V2d4YVpDVXhiMW9TRjRFeHNi?=
 =?utf-8?B?dHRDQjlKZm5MTUZlaWZ1a3dmeFVTbFcxZElIZ1JiNjJoRjd6RU5sSzYrTmJP?=
 =?utf-8?B?bHFwOWJYMGhoM2QxUEcxcW1xRUplY3F1UFVFVUJGamxZRjFwbVFnb1lTSXdJ?=
 =?utf-8?B?OFhCZHFLczZGVmoxOXd4RitGTk5EOGVKTmNScTNMb2J6S3VEYzZUOFYrYXRo?=
 =?utf-8?B?SUVWNVFGaDdjZ2dra2Q4R1hJOWNOQjhXMDZuY1BhZDZvREc3LzBnQkdNem5q?=
 =?utf-8?B?K05MaE1WbE45TDgzMWlEUUlraW9TWXEyU0tkSHZubExFclVsbC9jWUR4bEwv?=
 =?utf-8?B?TlB2c2xVQkdDQW5RV1hpT0JZeXF6Ykh6cjZLdXVqQXBMODFOSGdVdVJiaXk2?=
 =?utf-8?B?d1JzaCt3TVhrMGErYnBNUkZXWWJnMWN5U1hRRzN2TEUwR3MrZFIrSFVpaHRF?=
 =?utf-8?B?WVVPLzc4R0lHcDhranNidDNSUGxlZGRjRU94SHBIUFRsdk44REgva2oySy9Y?=
 =?utf-8?B?S2ZiUTRKN0o2ZnFseVRJMG9leDFMK3pMdys2SS9rN3B1YzBDVDdzc29LNXJP?=
 =?utf-8?B?WWtwSHdUSUVnYldPYTRvdEpSSWdEWmVjQTlESW1iWm5Yb2RXeC9CUGxpSGVy?=
 =?utf-8?B?Y3dYVmxpbEpWaWFjVnBXRm5yS0ZmR2xzdFVUdjJ5OFJ6Z3d1c2xmbWJ6eVlN?=
 =?utf-8?B?RDAvemNGcFluVFRNMWhtL2N0aEdRK3pDTFY1eVN5aEYvQ1VHUkQ5Y29Ja3gy?=
 =?utf-8?B?QmVIN2FRNGFFaEd1YjNTTytZODFrZmRBMzdNNFFJTVhNQkNhYmhJZTdtemZ3?=
 =?utf-8?B?WExGWVdsYWdlZmNrdTJlZEl3K0ZrcjVTYmZJSXFmZStiUVQwZVZzVnJockxJ?=
 =?utf-8?B?ZEt6WGJtclVtRHZGbXBpRUhmY1hOOUpVaEVROExpaWZNMmFzRS9mZnE3N3FW?=
 =?utf-8?B?MXlXT1FCUTA4dUZvelhQK0g4UEh3d1Ayc3JmbGRiQ0ZTZ29HR1RCSE1TWDlT?=
 =?utf-8?B?NVF2RWowZFNqQi9IQ2FQM1NodWpRMkVuM2RMN3REU3lSU2RVcGpHdm11amsy?=
 =?utf-8?B?VTY1WjB0VWlHT1VIMGxLRXhsZXpXY1hGUHd1ckpqbkxqL0tkQnE3QVBuNDdY?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q0DeAfeqAkvQiIInpZ8pk/3QB3W8zf2nqVYtmLpomcKqZsVAXQnHXbMAyLpQPC2ta3GqluUbFK1h73tsvBu8Hw0eh5edANSf8GUq5ySCTh6qAazp5XmQUBo4pe4dQYsAxVs/u1Lq4jbw8C92SeigPzEFFS6rQ8rlUjVn2a0Y+SUjbG//Kq7xh3nHXVnndUrKMJHc8r0smw+vQ4kKrhE3amkv3yZg1d0aDuXXFidI7U2UwVMaB6IYVLiT596uqOZilB6tzfjf1g7y9i0Cc4AhDD0s3Jc9jIFYUSPRSoTFJ0IYdFzd0wdcUuScm/HZZ2XgjtT6slJ83gbu9o23GWSIgMJFVUdHio8Ijk6SKns/Q4bpmJiXM8Z2gjq1fLd2YvA2DugyS22371Ph7gXB2w1UMgbkq+c8km/j8op+0wv0px1ZThnheGQ0bg0N2SItT+g67vlUsuE1mUf9yMiBdmVggeLzRYYpXMt9yPXT1+bHm9wyggxWzgjHxVmdVXu1wB9gfCsOtqQD6yggb5yTtbdOffH2QcdDzI4DKsDguCG7t75MF8wjdB3XaXuNbrv8gTTWCddWDunEj38fccMnvCmnqeZPd0cVpQPWr5Z4Z1y1zzw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733f474d-cb74-4b50-1747-08dd8e28158b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:01:37.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhJ0Sh+VgTd57kqX35LEuymgKNwQnhVKQEB4asT8zZ+BM7DoLA7VkMbt7/r+s9CHLB7uiMrh58In1CJYcT7XTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505080097
X-Proofpoint-ORIG-GUID: 28lfy0kHWLTbZeT2Qx2eIZf5IgqPopj5
X-Proofpoint-GUID: 28lfy0kHWLTbZeT2Qx2eIZf5IgqPopj5
X-Authority-Analysis: v=2.4 cv=PfL/hjhd c=1 sm=1 tr=0 ts=681ca0a7 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=X65uqMwQLWT8gSznfBQA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEwMCBTYWx0ZWRfX4lj/T6TTgPv+ n6W50JW4LVFw60usCzkCAX22UU8Ryo8VLY3BnN9/AVbu6kRXdGMGfE02AsvkVc4vQ6w1bQ/p0zZ GAX6fw+f0mdk1ufp5VTPqt5ARgMIqmn1NQ/b99ddDU+K9ylaLXIukPUsg3M22fdO7BCArIVhf4c
 OCyRPoGjHDlbRxpvGxffIn7uP8whmSuyweHVJHc02RvhFWqB06EfFea7p87GdG/ZZ4sxeef8/rV aDR7ssPFPTqZGDhbps1UE8VvQv8vNlNqhKXP005gYm0DFXv9XAP8ZMfeVlMckhbQ+JhkEtD6DyS QgskrTGfVV1HXUUNzWGWNIOUan77XM8JzoqpfgNFdeYxmwH0OdEFle6onO0MeFhVzrFn4SdUm6w
 uv9yugdXKxwpLd20GTfmWTNR+3OTzr1ddTQHyjeCYcp5MfR3RyOn6ptyqVEbDAk3ri8a+MKG

On 30/04/2025 06:20, Ritesh Harjani (IBM) wrote:
> This is still an early preview (RFC v2) of multi-fsblock atomic write. Since the
> core design of the feature looks ready, wanted to post this for some early
> feedback. We will break this into more smaller and meaningful patches in later
> revision. However to simplify the review of the core design changes, this
> version is limited to just two patches. Individual patches might have more
> details in the commit msg.
> 
> Note: This overall needs more careful review (other than the core design) which
> I will be doing in parallel. However it would be helpful if one can provide any
> feedback on the core design changes. Specially around ext4_iomap_alloc()
> changes, ->end_io() changes and a new get block flag
> EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS.

I gave this a try and it looks ok, specifically atomic writing mixed 
mappings.

I'll try to look closer that the implementation details. But I do note 
that you use blkdev_issue_zeroout() to pre-zero any unwritten range 
which is being atomically written.


