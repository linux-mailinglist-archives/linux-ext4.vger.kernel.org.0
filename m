Return-Path: <linux-ext4+bounces-9782-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D667B3F860
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 10:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490507A4D47
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB76C2E8B6E;
	Tue,  2 Sep 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SOhzzt2l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nAm019jO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95D33D987;
	Tue,  2 Sep 2025 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801786; cv=fail; b=Daenu01W2ogMTFQ69vwN7DI5OgPnTReMNOad7hmPDmFXxB8PB2E1Mw0EegHNl2rWGUCrmqPTa9bebtvDw3nncrRofg4Ggd3CCDTWkaiWqhvPGriB9E/0h84OQrgl1DCdBS6+8RArL8o4WW8kAH8ieLB0TSXwSjfM4KBsNPQZHQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801786; c=relaxed/simple;
	bh=UhA5JYXq3Ix0WlQH4iOTUJG7UXI0TDHdP77qJ7QBVBE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i7LeEFiG4FzHpwHJsPViQUqroe5t7jDuK0M8syBQ2byuAnZD9tJGb/vCCQRnykuJ7ChXEErgTOtKT2rdo7jAEtuu+58knKfFCh6oCbEXJvnAyppxHBpFWzw6eU8hfdWhatgViRpy39CRUoXTXWn5DDpmutrzQQGH75gOBzOfgv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SOhzzt2l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nAm019jO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5826fhgs032075;
	Tue, 2 Sep 2025 08:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=J+D3MNGuVgIszU9I34s6QTu4wyEdRPAvhRUH3dofyD8=; b=
	SOhzzt2lVBX7gH6YzSsCLjvcvnOzMOKlfyRzsXjvazTQdOvvJL+1y4lTaxgOF0Kg
	PTsks+AUKBSV9H9Jq9Qir1Xess/HWi7YWTryHaUm/Qbbmtq943ZGZSbomyh7DetJ
	l8/FU0bamCQbK7z2ikc1tN2VhAMIapweIQe+CiR84aDLcoPIyaAv0yPKVIdcDoDS
	4NySqdAfnrPF1phqsVTKsit6bU7+1KkKEEWG+ZCJXjBFjuLn5CT0BjiGUiPNEht0
	wwNst4iUPuWPTbVjpD4CaO22Rhdj4qXlLRPSTmFVHmyShMhgKrUG9Q7zBFaUsUaQ
	kRBL0Xa9jD6+VWdr2FSlEQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmbbfxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 08:29:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5827dot9011686;
	Tue, 2 Sep 2025 08:29:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrev541-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 08:29:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1LWZOxYKTdzYJ+eUdIef8ax9kgoJFPFWSuXrUzFHTGG05sWq6nNLRuk7ZZU9JAr0oBleT2RLKdP0631Ocoqb4TCZrKvFlUoN2SfgYlwm44uzHRqhkhCyjUvxpbPmqQ8e5cpLwTKT6C13kTaj7PwKVSl7o/vby3X3+dHawPG3aqIAtyMXaKaFkX2yAF7JR0Pr4B9hmF6ielbIu6eo7/WfxZqgoBMAM9EpxTCjSSLblxhuza4nhOe0P3iwDBZB+xvFQ8h4WzY3VnKmlDneXfY5x4EBCLDjx6GnvFk/MBh7F+q0ld3dnE0pEgW1Qy8cYCSiKy8NU49+7nj6i4Kr/NxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+D3MNGuVgIszU9I34s6QTu4wyEdRPAvhRUH3dofyD8=;
 b=JuzYZg6OBXQQD+8hw1JIlN9lFdd2BXxgPYfWEcSlyckQFiYYTHyOKDtqZH607Abu5SsbeNmT//7NXmkYGVKqDMC+Brp74y8k4nv5ZjbNr5OPk5WP04omugd6iJEaW9DThHLMTxpLJdmhp8zXaYfUb1WCPC6JJzsvXXarRSjP53+4ohML4daKOautIcZHz8Kaq0Fhk051ABbwAYTmXBtVchMK8xMdEvxsIkArvG4Cz7pDz6HPnbNt1JfmVV46CfOFoyk2I1AbRjHX7p6NQS+G+0oBS1wykNN4/C1rvaOhYmN0WQ1xhnkSN+9ByHtlPqBWstf3kQPcUXxQZPtjmB0r7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+D3MNGuVgIszU9I34s6QTu4wyEdRPAvhRUH3dofyD8=;
 b=nAm019jOaxL7k7diYIsLUF79OP7iqMDGF4Tha/Cfop+1KxRavLAhr0bfReaUtHm+vjybNYS5Kz6pTgHhOr/DTiSAKz+UkurAfmMHUIT7yxS49bN8PrIdmyUvJakpZYhE5i6Xa5Ge+2/g4SsoenxEWU9btdQoSEiYbv1pvezo4Vo=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CO1PR10MB4690.namprd10.prod.outlook.com (2603:10b6:303:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 08:29:34 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 08:29:34 +0000
Message-ID: <40b11ae3-a2ef-440b-9929-ecf4f8c7cdb9@oracle.com>
Date: Tue, 2 Sep 2025 09:29:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
To: Zorro Lang <zlang@redhat.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <20250825160801.ffktqauw2o6l5ql3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aK8hUqdee-JFcFHn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250828150905.GB8092@frogsfrogsfrogs>
 <aLHcgyWtwqMTX-Mz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250830170907.htlqcmafntjwkjf4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250830170907.htlqcmafntjwkjf4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0312.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::20) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CO1PR10MB4690:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e79bbb0-5336-4c71-b7f3-08dde9fad895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3YwUzhwV3ZjODlNalpYUVROS1NxYVN4OGNZWCtITlJIdzVUYjRqV1hPMElM?=
 =?utf-8?B?WDlOTTNvUHBzWVMxK09QNE56SHV3a3BoRTVMSnFoQmduMTNLZTV6bG01REln?=
 =?utf-8?B?ZmhXZTdoWnJpT21GZEkxbnNXdkY5WUp4SVcybjc5WXhYTjdiWXM1NzljT0xJ?=
 =?utf-8?B?V0Qyc0hLN3VsMGhSNGI1cm1CWlA4N29rakZVV09OMmpOT0dVbHZYUlVicTlT?=
 =?utf-8?B?MnpDYTZHWTNFeU5sTjZSU2NNT3pTMUU2VkZaOUhjc2JUaVdLZEtOa01sU0Zs?=
 =?utf-8?B?MmtjMmZYRGNqMlNncHhaYWpyZjNVSm95UHNtOHA4MEREWGlKaDMvUDBPNkNE?=
 =?utf-8?B?K0lFNkhNZWZubkp5NHk4NjIyVFlqK0wrdjZkdmhubHZFT1k5YkdEemtVT001?=
 =?utf-8?B?eWJHT2dDb21uUVpkL0FDU21hMmhZb0llMEp3bHlZRE5KVTlkaTJxM0N6N2FC?=
 =?utf-8?B?aVdEYkhJZ0RJbGR6WGNZSmo2Q1d6ZzBqV2QvTGhxeTgxQnVCb01laEVyUGRv?=
 =?utf-8?B?YWJucUlRR2hGU3N5dVBOZ21KcFk0UEo4TkxJNGJ3RWZMOEN0ZVoyOEtKTzBV?=
 =?utf-8?B?Nk1FM2J6SmMzOE1lY1VpbzlYU0hPa0dRQXk2T0FXQnlMTGVlVGdEWkxPSjRY?=
 =?utf-8?B?cFVhUVM1MHZ0R0JEc3Z6cEtIZGJ2Y1FPWjI3Z0F3MDBnQkc3QWNmU1VtVVZU?=
 =?utf-8?B?NDRXMGJBdHc3YktGbnpWR2cwWkk5eXBRbUx2eTg5NzZuN0dzcVVCb2tGMy9M?=
 =?utf-8?B?SzFWcVdwRlFCNk9raEptYkVGYUlIQzhWd2dOeURoTFQ5TnE4cFJZVFZwbjRZ?=
 =?utf-8?B?R29mVDNPVWNpSU5MeWYvMTZsZGFlS3pJYXhyNTdSTnZBQlFlVTVEbU5NTkFO?=
 =?utf-8?B?OVNabzdldEFSUTRaRGpaVnFOUWdORzJzVjlUaUJYdkI1Ny9VNU9MeHBtMWpl?=
 =?utf-8?B?ckRtTkljcitzVFFLQS9UV2NOQlFXenYzVmFuTDFzc0p1TFBaZS9NMFE3NkVs?=
 =?utf-8?B?ZWFHeVZRTnhScnNxdmFPRW1vMWROSngzWkFCYWpSb25DdDYvWmZYVUVNRHFr?=
 =?utf-8?B?cGkxeXVnLzVNZGlqUnJjUVI5RUhWY2szUDJFVTFiRGswWmJVUmlEcXl0ekNU?=
 =?utf-8?B?VEc2bzMrWFFSM0N1UW15U25Qall1V0NCdmlzT0I0L0FQdlVNSnpwS1QvSklF?=
 =?utf-8?B?V2JMVkdXL01EeHBmSzJuR2FoMVhFNEdoa0tUMzg4TDV5aTcwL0lna2RkNncw?=
 =?utf-8?B?TnRwdUpWUVVHVmdUMEVzaTA0V3BGeDZUVDZTeUZyMEJXYkpoWWRqNE84cDJR?=
 =?utf-8?B?NGNodEdkYVMyVksyeCtsTjZxMnljTjVFWC94enFPOVI3QXB2RlAySzk2Szc2?=
 =?utf-8?B?a01QVEhxZ2tOeC9MbTBneVhGaXNSV2UvajBhb0JMaHQ4ZzZMM09RNy9ieUpn?=
 =?utf-8?B?N05kNWhrQURwT1BaNklVanZKdzVYSDgrQkVEaW1OQUE3VFBTOUIwRUh5ekpO?=
 =?utf-8?B?R21GcEQ5L0l3MlhSY3piZ3dxaHFXQWxEbHZiVklOMjYrbE5Xb01KdForcVYx?=
 =?utf-8?B?ZFNML0VFWUl4TUprQk5JNDRrUk5LVnFPbXQrVzM1c2JxcHZMOS9welRNVWxh?=
 =?utf-8?B?NjBiUmpHQTQ5OHdnM1RzQTlYdVVxWmhkMVJaR3luU0dtZzRsR0p1R09iQzJF?=
 =?utf-8?B?VEdwb2dySEd3UC81Y21BTEt0bTd5VkJoSTVVYXhCdzN5SlBjUGdBQjA4SFVY?=
 =?utf-8?B?SEFZb212UDRuSGM0eEtCejJJLzJNTE94ak5YSzh5SjJvQlQ2eGNxKzJ6ck1M?=
 =?utf-8?B?QTh2YVFoYkRjdERObk5EcTlYTFJyUGQ2SkFvQjZVSGJjMVJRUndzNkRidDZj?=
 =?utf-8?B?QVl0RDBma0RrMnVQRnpXTE5sM0FVWWVJUnpJdGhkRkhmWFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmY5dkJkSUEwaVNWS0EvOTV2czQzQXZxKzY2N0NPMjdORDBNTGMxdGVHSXUw?=
 =?utf-8?B?TVVMQ01EeTQzVjh0UzJHS1pVMkcwZlI0anJVSDNLMUZPRUxhMStlV25jUDFE?=
 =?utf-8?B?dWJpbmFoQ0JORmJlNmI4V0xlT3k4bmNpcmFkZWYvUHFzTk4rTzdOSGtqbG4r?=
 =?utf-8?B?b3BlRndrc2dxaUJtVVhTNjdGTGFEMENHYm5rNUJsRWRpTzlXNGVOd2RFTmNK?=
 =?utf-8?B?QkUvUkswcTNyNU1PeWhWTGVzRUJ6WERoOWFaY2lnNnB4YU1wRU9aRTk0c3lv?=
 =?utf-8?B?UjJQd0RrUnRSdlJiNStoYTFWazRRQWVBbnEwa2YwMnhjSlhHODJKMXY0RW5s?=
 =?utf-8?B?eTlvT3diU0w5cDVTVW41SHZFemlGQmMwcGltWHBaOGRteHlzbTA4MmlrNGJS?=
 =?utf-8?B?bTRjSWxnT21tSjU3UUhWSXJwQ3BQTlMrMEswYUJXYU9XbEY1Nmhza3Z6NkhW?=
 =?utf-8?B?MnNDbVFsNllMMGl1MG5jVVBjL3BPMjlXV1J1K2tTbmlwV0FhRGdTdnpLWTZk?=
 =?utf-8?B?TXZIOHNRZXUxL2RDMXk5REp3ZWUvVzZ0d2dzWEpGUWk4dGwzeEF0QjFwNTlt?=
 =?utf-8?B?dDJ5NmVtWFN5Y0dtb2FKTG15RFVVVEJaQmJIYktmR3pvUFVnSUtRMkZsdW9a?=
 =?utf-8?B?QzFFR0ZCZVg3RkFHZHdveUJwZk1YODBpWTZ0bExVSm9xSWRIb0tWRERGc0JJ?=
 =?utf-8?B?cGxXNWkxdWpReFpTaHZ1QXFFWGprZ21IOGFoeldOalFUQnV4ZW8wQWhFYmE1?=
 =?utf-8?B?dmw5Z0NMM0NZYW92YnF0d1R1ZDdEZ2hhTmRuTGkxSlk1NVo2UFEyMHp2alRm?=
 =?utf-8?B?b1Q1ejJqUU45WmtTTkNEcHBOdVIrcDdMK2dpZlJqQ1hLbnVwQXZUQkpVMER3?=
 =?utf-8?B?VEVJM2xlTkRGQTdQMW81SkFBbEwzM2plU0pISEtWVXpSbmlMKzVTd3ozS2Q2?=
 =?utf-8?B?YVdBRHBNR2tkZHFHMWZOK3RydXpUMHpqbEtzTkF6UGJxVDMyRTBHVTV1MFFt?=
 =?utf-8?B?aElKQ1NhSnlkVTFHSXg0U2Y4RytxMjQ2bDE0N0RlL1VWR0tpZ3lxaXl6aDBn?=
 =?utf-8?B?SWZOU1k0SDd0WkpENk9aZ0w1UDdRVHBLSlMvNUUzUVZvamlLZ3k1clU5VDVl?=
 =?utf-8?B?OUQ0MmdVYkpDb0VJRFVSMjE5cHNLcUR2Uk5iSTZYS1lFWkNCTU5qWGxNMzR3?=
 =?utf-8?B?S3F6TTNOLy9uM3I3Vnl6R0htcFVWT3NlSVY5NVRod20zaGI3STVmaHJLUis0?=
 =?utf-8?B?UnM3VUpyRDFXSE5FWkZ3T2NRVGNZMEtpT0ZuU0VwM3R5dW90RFRIbUd3S3RF?=
 =?utf-8?B?N1RQOUVhRVVRY2Q5NUVLRGNQUXlCZCtlMVA3ZWowOEp0aW81UnBEL0U4NS9q?=
 =?utf-8?B?d2dqNUwvNFM4dXhjbmxaWXZFcEp2N1BxdVVOMjgreFJxYVAvRmZvSDl2NGZ5?=
 =?utf-8?B?aVdVM1E2NlBLTXErdEIrUzZ1U3NYNVlOdlgyWFMzMHlUNjZqeDFMZ0ZIRXZr?=
 =?utf-8?B?Rm1jcGI4NnlwUzRIL2xjRXVOM0NZbU9zU0dzNEZvdVErL0t6YWtaOElCSTd5?=
 =?utf-8?B?blM4OXd5VC9PQXpCZHhGZVBlRFFSV3dhUlM5cmlLY0hqTEQzME9mV1gvYXRX?=
 =?utf-8?B?M25aWXlIZ3FRVDNRSTlZVmVZZDVjZ052NmRVK0tmbWZ1ekk0OGwxcUc1VHpV?=
 =?utf-8?B?Ti9MaTdzODdPVU0yMW1aczd2UExPOTZVbTdaaWdTZy9sTFgxQVRKSkxLZ1dY?=
 =?utf-8?B?WlRPN3lvTFZQeXYxMlpacndETnZOMUE2TCtJTzNmd3B2U0VTYThkbkQ3ZXhV?=
 =?utf-8?B?V0xxYkc5ZnY2MUFoRlBjWkltMUtCWEFUS2VZU2NrOVl3RmsrV2kvc3BNeVUr?=
 =?utf-8?B?bkFwdkQ2dXVFTkRhcE1pdnlVb2l4RWN4bUxjaFArT2JPbVlKU1N6M2xEZmlD?=
 =?utf-8?B?M0tSaGtFbHVscEwzanRMaXFKUlJaNnUxRU0vb3lhZ1ZtOCtZdEh6ZXJRYTNV?=
 =?utf-8?B?NWplNk1NVkR4NTVaMGRPOU44VVRGT0p0R00zYlk4cVZYSS85dTZjYlkxTWNR?=
 =?utf-8?B?NlBCQVdoUDFlWHkzNFhDdStiQytZOEVRVmN1Ui9FV3R0SzA5eFB3dnZwYkp3?=
 =?utf-8?B?ZmJYUDVCNUh6Wm1sS1o3WUp3TURtY0dsTVVZSS9aa3c1bW8yWVd2OGxmc3pG?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xp4mlox/e/x1tkVDZ1BWaf04JvLwHiK0RR8xd97WNDeEw/7agL/i1xWg1/qBMC82MekeAgLuXFv3zRUGYQrYa/qEX/RR5m73V/nNSrlrgxGK5XZHLp21VRPkOsCc8j57+koC8gUD5LATK3+wEbb9vtZg0W7nsgqZPqGw9scGA85VrUSFgidO2L2NEm4O+o+RRAi6wZBHiCkFxyPOzEXfV5ActLYhviMoHYHltx6YdDTKXJ6kYTWtGEg4oKdnnqpbWfP08OlgIQZZDXRpP580ErjqUbkZw8lid//RYQUww318PtWrn5r7CWfVh1FG6qr2iRdTmRv78EhIgKxwgfMph2Wj1hHtLIVH3cGOYXS39h17I/MYtcOFwn2Layd3bvDnVd+jOXHK3z8zgCL62kwKDwnizBac+bQtyXN3ROiCDKRJuE5QlKjpCL165h07yW+HRMMEoR2pLTIYKuUFTzun+cyMsybMLyFQiifgY4MWt3slgUcfL3EY63KY8xFZfIHz4fAzGZDFPkzsslJz5eBoYCy2Y5pjunefmyS6/zf+ivDMoHqXTm/lLcV76mBoHO8J+8syOHQ+4BI0k6L3hiCAJdOPWJXs9nUU1cVo6pILqKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e79bbb0-5336-4c71-b7f3-08dde9fad895
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:29:34.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkkTuU3iAxathkJ214MgPkUKaYtSTljQAI8g8stCnEIFpUuSUv1rAo6sPzWKVylodVYDXCf/beCnMkePJrC7uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020084
X-Proofpoint-ORIG-GUID: NaOGS-zAXNzieSHz-crS1888Hb7RFg5C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX+nV+8Q6faTi8
 wIg1ceOjRvVGzFkfMbfcQ0JU+/EqDOFg3I0F7kXACaP9nPu/JwuSCPzOYChlMbeax6uTzpB2GIQ
 9eLp0+u87ljr46aC/jZrDdoQLfbWBF3nYqnBgvcaDb696Hsej1dD9Sc//RcDpJirU7PWBk7QnN0
 k2c/4gvMzYUYt5+Rw28ueV9qtfXiQfDV+3vIDTBUGnd8LIwRHBV5MtNWHAZXwPKuh9SGWvG5Pcb
 5gV19g4KoQAw21ZvXXOf6jElFedQ85tNM4Tn5FaCSZecAWyBQIOhpsvCU+Cn/GN6BjFjSzB2oXk
 Wk4CjnxuKlZtEOf74PTxKynPrG4Rx5VHXBCz841wrMZ79+21b9mzd/8g4GjtoFebyYCDz7AqYPG
 Lte4Nm/nD7SleH8DfT6x854a1QirCQ==
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b6aaf1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pYTFGYH-n3NBSdXluDkA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12068
X-Proofpoint-GUID: NaOGS-zAXNzieSHz-crS1888Hb7RFg5C

On 30/08/2025 18:09, Zorro Lang wrote:
>> I think John has a bit more background but afaict, RWF_ATOMIC support
>> was added (fio commit: d01612f3ae25) but then removed (commit:
>> a25ba6c64fe1) since the feature didn't make it to kernel in time.
>> However the option seemed to be kept in place. Later, commit 40f1fc11d
>> added the support back in a later version of fio.
>>
>> So yes, I think there are some version where fio will accept atomic=1
>> but not act upon it and the tests may start failing with no apparent
>> reason.
> The concern from Darrick might be a problem. May I ask which fio commit
> brought in this issue, and which fio commit fixed it? If this issue be
> brought in and fixed within a fio release, it might be better. But if it
> crosses fio release, that might be bad, then we might be better to have
> this helper.

The history is that fio atomic write support was originally added some 
time ago for out-of-kernel atomic write support, which was O_ATOMIC 
flag. Since O_ATOMIC never made it into the kernel, the feature was 
removed, but the plumbing for atomic writes stayed in fio - specifically 
the "atomic=" option. So I just reused that plumbing in d01612f3ae25 to 
support RWF_ATOMIC.

The point is that we should check the fio version, as different versions 
can give different behaviour for "atomic" option, those being:
a. O_ATOMIC (we definitely don't want this)
b. no nothing (bad)
c. use RWF_ATOMIC

Thanks,
John

