Return-Path: <linux-ext4+bounces-9262-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA15B19BFC
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Aug 2025 09:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBBD17ABA3F
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Aug 2025 07:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F55233D88;
	Mon,  4 Aug 2025 07:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tc3PoHQN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g9KeXm9o"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F58F4A;
	Mon,  4 Aug 2025 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291536; cv=fail; b=pOGX9WT1+eX3UOkFez+159gu0gmb95L+1lv2uReaDVm20pVA62aPb9fZuCiUpYL0mt6klkLV5M/SWHSx1XLM39SgPu4DUP2pn5LsTOGje7M1P6V9BYyYLH0trafxhMiN5cyTI7lA40AbyUSD+WcUFPcgu+tQaZYMcLc5FyrewMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291536; c=relaxed/simple;
	bh=lNtE68UBHUa6ZWpftTt4g1zIXaNljEBSbsYr0SlheJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gxgd/xEoxAS8CnRAhOi9WaQrzNP0xb9nioRFuNplUeyzbvGxct1GWCaDBjc9wFgiiuFkkJn2rA8HW8rdHg02Xiyikp6JB12NbmLgZMkS6+NB9O0MEsoYBB1rskTPw1G6ppb8NguMkvpTrfqG+PalwOuuzwxMBuhAn9GDm+42Q+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tc3PoHQN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g9KeXm9o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573NY1EH019815;
	Mon, 4 Aug 2025 07:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=b4m789c58Z2Rh7UaBZtAK+TL90G6JM//IPuRwcocGbE=; b=
	Tc3PoHQNm0gv5VoqvOnAJwHdjC/DN1xKx4ntTCdqrm+vKwn8xUXwXY1IUhLtLhWc
	7yx2Q3UeLab2QtYz2i3FLQowpsBmM/sn8ZcEfmRkfpUskazcVrSam0uFlXCIbyn2
	ynZkKkGphOZQ1PRNBGVqkNmqDvsKe5lncIZDNehm00ASmHrVS8AT8k04A21fk5LE
	mjc6kjuWp7y7vB1hufPq5fEGnxhkV8VMchyI1sch4VhyEybFvv2qB5gG9Jy0JSQO
	6OQbVukCAu8PlNE8jvjvfbfHsN9lLenTDMIK+mx7DYVuw9qNdtXlak9nN7N3Hqoe
	2lmozX+E0zIaqOCaNxYszg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489b7xj130-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 07:12:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5746j935017850;
	Mon, 4 Aug 2025 07:12:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7jvjk7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Aug 2025 07:12:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHF9yLpmX9vd+mq7O1OOK9IAqFZFXuDOysuMAzn7piLHFCsjhwXfLWrkhttZ+saMqwmQqwIJgbno+92a2xd2j8d2XGt0ffsPh12wQH/8Ov81lNkSUNfiYsQVEeHupVNPe57hHLcoPl+tYaShmcWNlJNMeO7FXYZVEi372cqVHmenBbE3Dpx9Q17HQN4e2TiVS95dhQayRPArGg76qNemKJq0N6tPmjd/T3B2Uq+2vIHzIiyzTWWrEFd8HsyGIufBasHJ17/e/hteYRJKL0rTNaRiFX7CnSKpMkseJYm7d4AA9Tk/eGpVbvTJMIHSFn0c03sMcsqhDR1xP6qu2YYIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4m789c58Z2Rh7UaBZtAK+TL90G6JM//IPuRwcocGbE=;
 b=J79GTJSNuE/8AifvB7cOsvcslQy9yN0jku37LTaSGWi+dqaUcs38dPu6HRMMJOFcRQmBmMLJICYuFdIu3Axr2YIk5353G0BGRnjtOkUaZ2rn6ttJ10wEsxAu+5nwm1hcx+0DGhYlFm09Vx7ESkhipWa3ZdEf5/32KmP/9WvUxx3L6w0/T6hywQsLxIcue4ZMpP/KQhr31Ebwsek2hBdgqphLn57EteZ17/nM7UtrFBw1rgJkvPF9trzgy+lvDCyCxhdGuRr3HIX+bo0moDUbkxRvQer+AU+eL+d9OzrQPC3WOT0GnXoDUi7FZ+68d3fd0c+2p4+X4wKlMe7Lw1WMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4m789c58Z2Rh7UaBZtAK+TL90G6JM//IPuRwcocGbE=;
 b=g9KeXm9of5585MQfsjq9P7LWsJY4x+yMk2/MYGDueV41zbC+4hkqSvN+Pl7/SWon5+1bjx1n2QGm+rrmTurAwayA42W0K2T4JKTJcHJ5+sknTr6wddelC+CEKV8DGYXrNPBj49VIPLskXU/Es0rnkTWqdBU8slJ+ciOpJW+UqvA=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SA3PR10MB7022.namprd10.prod.outlook.com (2603:10b6:806:317::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Mon, 4 Aug
 2025 07:12:01 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 07:12:01 +0000
Message-ID: <83e05a05-e517-4d41-96ff-da4d49482471@oracle.com>
Date: Mon, 4 Aug 2025 08:12:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <aIccCgrCuQ4Wf1OH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <2ae4bb04-fbf7-4a53-b498-ea6361cdab3e@oracle.com>
 <aId8oZGXSg5DW48X@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <3a4854ac-75ad-4783-acbd-048fe7c7fdb0@oracle.com>
 <aIhmG-l4nWOAzz2I@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250729144526.GB2672049@frogsfrogsfrogs>
 <aIrun9794W0eZA8d@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <22ccfefc-1be8-4942-ac27-c01706ef843e@oracle.com>
 <aIxhsV8heTrSH537@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <76974111-88f6-4de8-96bc-9806c6317d19@oracle.com>
 <aI205U8Afi7tALyr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aI205U8Afi7tALyr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::6) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SA3PR10MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: eee3855d-38a2-4bc8-f63a-08ddd3263542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVhNSkJPYlFFanFXV2VDdDBTZXFwbE54eTdNaHR6aU9YSmZhVllnNnpnVDh0?=
 =?utf-8?B?bGh3Ni8vTndaRmk1UkdQc3BjRjM4ekFrS0VwMXlVbU1CZ2lkNUtvTnlQWFAw?=
 =?utf-8?B?WDRlRnZLUUR6MGk0WmNvMVlUaS8ya3hHR1N4cGw3cnJUOVVwc0JraXJTTnNO?=
 =?utf-8?B?aDNaVUh1TWNVVEZhbXNqZnQxaWMwM054cFY1NUIxd2krQWFFMjRJVk9ZdVd0?=
 =?utf-8?B?VnBSTDNRNFZBRy9WTHlHQkQxcnRBWlorMExJUUpKd3dHaWNROTBCYXVuVUNC?=
 =?utf-8?B?cVZJa1ZwTVMvQlJXU1Z4UkdYNGFUWU1WTk02RFJhQzJtakROMTM0dnNia0Iw?=
 =?utf-8?B?OU8wV014Ui9iR1RKNFdtaDA1U1dYVnpzZHRsRUhzWU9CZXlUMjhPTXhFdjdq?=
 =?utf-8?B?U0htck1CY3kxY1FpNlZ3WkgvZ0ZzeE9jTUdKbDd2cVdNK3dzZVlrKzBMUjhU?=
 =?utf-8?B?OFlHYkZkSHExWHVibll4WnhDbVFzcWs1aDBrc2s0OFh5bnVML1hKL01jL1R5?=
 =?utf-8?B?bDY0YWRnMDNQcExiNWZsUmFObWNnMlB0bWZDdXFVbThSR3hDRzlCRU8wWFZD?=
 =?utf-8?B?RnJmOWU0dE9ENU1tRVpUU09jS3BkZ1VPY1RKUDhUZUM5ZHpvYS9ySS92UkZ4?=
 =?utf-8?B?ZjlLTGpWR2RrWHpjeDJhSEFIaDRvUnlLdlllQTljNk8yMzlUb1RrRWdxbnZS?=
 =?utf-8?B?dGdwNmdPMEtDOU90ekozZkd2dXFmbWFka3gzZW44dHQ0THNackpYNGFZRS9j?=
 =?utf-8?B?bnJFS0hqSUhyVWwrd0VLb3l6aGJvOXhCK1o2RU04djIyTE5PQWU3WkUxYTlS?=
 =?utf-8?B?OEx6dnlZOXNMUGNLbU9JUHpSeGNNeTB3bXdHUEc5TjhyYUdkT2N4MVJUQ2tR?=
 =?utf-8?B?dVYwSEJLeFdINjZwNVg5alRISHNoRU9zYVp1cGRobVlJM1FkRnhFYjdUR3lW?=
 =?utf-8?B?Zks2K3pmbDdJWEI1Tm1yOFZXUjdKTDhBOWtQb3paSXNNVndIcW1SQ0REVTFy?=
 =?utf-8?B?Ynl6Sjk5WHA4eVFCSG94bklvcktDTkVNQ0xhLzlBMlZYQmNHS2pReWZBTHhT?=
 =?utf-8?B?d053eW9nV0NENkg5RWtTa3BZWi91enNVRlRTdzNWeVplZVBYSkNsN00yQXd0?=
 =?utf-8?B?L1Z2dm8wNTRJQ2lwSjRWSFFJUHlBSEpoYmRTVm95c0RxR3F2aWRNT2F5eUo1?=
 =?utf-8?B?K3BTSFBtYVYxWUlxRW4rUWphZmhHNnk4VUhaMzR2ZHdvUndGaWJLZUZQMjBx?=
 =?utf-8?B?aElUVVQ3QUJzMFlkd0VNRTF4TDZZanFoaG0zZEJ5cGxTUE1lVm9FdVVucE5R?=
 =?utf-8?B?UThjVklTUit4K01ENFprSVVKSlcrZWYraGtDM3lnWkFyODJXb25SUnI1RnNY?=
 =?utf-8?B?SFIxOGgyd0RJRHY2QmJNdDR1MHllaFZzNTFwYVNCODQxcFRlWDhVMzVTcGZ6?=
 =?utf-8?B?c1ZLN2dIOHgyVjAyODN4K3IyU2o1cGx0eVNqM1B4TkxxWGVzUDJZWUJUWXZQ?=
 =?utf-8?B?a2grdmVUa0p6KzQzcjNKTkZjd0c3cHZpaHFac0RNWk9ZMndrTFBRdjFnS1N2?=
 =?utf-8?B?T1dvTUxSR2NDWkpJN2lxT3ZKZVV1SC9KNDRVak14NTFJVUIyUHkwb2FGS0tV?=
 =?utf-8?B?Qmo5MXFlRVFzN0FpSmNZdHF1WjRNUTNxbmxXRUVCRnFodjRObWYyclA4OWpw?=
 =?utf-8?B?bjRMSUhURGJXcmdyVldSWldaZnEwa3NGaTlNb1ZXZE15WmNWM0psbjBjUHh0?=
 =?utf-8?B?T09VRC8yTENaTjJJMEhSM241RkhPNTdNSTg4Sm5Fc0NXdWgzcmI0czlYTXpF?=
 =?utf-8?B?ZnZPZThBeUxnRkVaeHhpOS9ybklGVFYwWWozSTZnZGhqeTVrV1dySGhGaWtU?=
 =?utf-8?B?Q3RhZ05FS0xlazBoaStiSWg0dDlEUEhPUHdXdHo4aVg2UzRORStCOGRYajlE?=
 =?utf-8?Q?UIyQJgdWC7E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REtIeUpjNGVDQ25uTGwxanN6QmVSN3NQY3RDQUtCVnRlWDBwVys3UXh5YTFT?=
 =?utf-8?B?UnRqSzhLRkkwdzIxNEp5eUdpRGpqaURzRHMzek5YbEcwSXlzYXM1bHd0MmNa?=
 =?utf-8?B?dTZpbFhVbCttNFRCb2RhN0Z3VEZ6OFBrZ1FXRTg3R3pVQWp6THNxbEJ6OW9I?=
 =?utf-8?B?RDFBdXJEZ0o1NUZHTWRiSzRzR1luMmQ5SGtSNWlFMmdHQ3hYVU5JcHAvM2pj?=
 =?utf-8?B?dkd5bXBJUnYwUkZxcEJEclh4UVhvaDFGcUxlRXpaa3RnTVdoc1FTM0liRkpH?=
 =?utf-8?B?dEZxUTI0cTRvbTBXeitoR2tSRzN2dnBONTh6TlZDVHpnU1UxNWpLR0x6UjJF?=
 =?utf-8?B?alZ3aUdGUFpTckJJL2ZzYUFMM1ptbERCNWpOT3lxZXIrQU4zdS9DNWx4aVds?=
 =?utf-8?B?eU53VVpoREMzeEJDZE5xVnNIcTFjaExwdDdEYXdEZnRtTG1EZkdRbFVBOEJB?=
 =?utf-8?B?VDZoMmtqS0hjU2FZbGVnOTNHeEYvVzc1SGwxU3NHRXplOVdxcHBRTTFkcFQ2?=
 =?utf-8?B?T2E5eVh1MG9RY2FvY3BCalJ0Nkx4QTF2MWMwaVNuaXBRMk5nZlV2Zlp0N3pm?=
 =?utf-8?B?U0UzQ3F1UkJEaEx0eTN0MFBlSlNqYzEweTliZ09sUHBMenZKSnV3Ui9XNitj?=
 =?utf-8?B?Yi8xR0g5a21ORnNVNFYyMC9zL0crWElYdlBrZlNqRk42V2ZTWGxmNU5iOVVw?=
 =?utf-8?B?RlByd05iRDlZekNnUWZVd1RTSE15aWQzbEoxSk5rOW1rcXBzRUM1cXQ4dTdV?=
 =?utf-8?B?bVVGNHhOVjNzbjJXVUNsR214aEFhLzBvRUc4U2pZUlJ3aVpQSHBuUHhnK2w4?=
 =?utf-8?B?QU1obXdMZFpWc3pPYmZ2M3dMQ0U0bVFGRW1SU3R5Vy9NNmpLM29oNWlrNkwx?=
 =?utf-8?B?OEJNNzlwSkl6cm5wUkZkamxQbVNnVTl3YkpiZUpqMDhhU2YzRStGWEtQZGFL?=
 =?utf-8?B?VWI4RjQ3ZlRtTDhnS056TTcrNFVvWUVmcHpveDBIYWwzTG9tQnNYbmozczZW?=
 =?utf-8?B?SXNoYVorU2p0NHJ5VVEvK3A5ako5RWQ1ODBqaEdEZ3ZobDJjM3BoWk1ZZDVH?=
 =?utf-8?B?dWo3Z1JqaDBaenlSWjJGV0Z3bmVyVjRGNHN4RFZZeXFISDlHaVZjckpmc2p0?=
 =?utf-8?B?YkZnWml1MGdJWGxFOVJORFc4TlRBZVp0S0ZrdTYzdURqUXlpWWZId0NGYUdu?=
 =?utf-8?B?Ly9ETVBlNkt3ODYxU29KQnh0RVVray9CNmR5NUgrMDV2eGFHRXphb1l2VVEy?=
 =?utf-8?B?bWUrL2l6S1VXNzNPeGl1dnZmL1lFWU9oSThacnlHUGpJSUZuMjlJb29udVgy?=
 =?utf-8?B?cmVISUlzRGFCNSs2YTViLzE2dFdBbnhRUlpEeVRvS2hrRTd0NnBuUFdmbUpz?=
 =?utf-8?B?L2F3amhCUFZBaTRZSkVuMHJLTnEwZTlQYTIzc3FXeFQrbDVOSGZLa0dFaUdL?=
 =?utf-8?B?Q0tLcmU0MzMxMC9PR0dqRlFCM0xBcmVZYy9RTTVUQm5aeHRwbldsc3huVTli?=
 =?utf-8?B?VVUrY1VpL2J6N1dLUVRKdTZPd2JzWVpJRUYzQ0xNTjRlTXNPdnpCQWQrMUcz?=
 =?utf-8?B?VDJLeE8vZUJwRHBWOXdwZnd3RHZWbjV0NEFRa2tLZEZWVU5SeXRUeDl1cXVj?=
 =?utf-8?B?YnpSWklOeUVDYVUwQ3h6dnRlcTA3dWV5ZXI3c1U4V0FaczhCU2FUd2ZUWnEv?=
 =?utf-8?B?OVgvRktEL0JraGM1bXZVK0QxU3plZ3ppLzNxOFRxNitJZFFWVnYzbDAyWnVE?=
 =?utf-8?B?N05IOHJ2VWVUU3VxZzNXUGlNZ3hpYUNTdDFIclU5bnpjaStIcUl0cTJQMmE3?=
 =?utf-8?B?QlYzd2hyZlZJK1dXc2R6QnBiMC9Ib3A4dFNsMURXR2NFeTBvWGprQWNZVWNF?=
 =?utf-8?B?RUV5UEdHN2dKYzd5WnZwYmlaRFJsMXpJeWlvTlpoczRBS0FWMU9FSmg4a2pY?=
 =?utf-8?B?NVRidXRITHVvclRZUlViZ1AzNHlEalhHSksxOWx3d3RwWEFLYXBLNktPNDRK?=
 =?utf-8?B?M0lYQ0dKVUc1KzJNREx2UDFhaHkzdDR2ait0YVU5TW1QQ21Xd3lWYUkvS0xK?=
 =?utf-8?B?Qnlwa0kvN1RwUk81TTh2NTBMYUtFQzNlWGphNmFqTGFCQkVTZmZ4Q3pmOFkx?=
 =?utf-8?B?VUQ4b0JHOGRNandUaFcySnBXVUhOMVlVamduelAxQW1ERDROQ3Z3ZktxQmlH?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZujPFcDs/AZVpWuNsdpcdTDsBxZTjXl4m10SV2fk5hbNW+BoueO69XbNpTiP2SFckYR3+prNg1UrI61jYDlIi1X1M0mipiw5GSxet55MW4xnNiSG7F4HJIXr5rC059CYofXkqBrkXdU9PzKO//VuH8/JZIsnMXzInzVqI/BBgcpxdIWrEfa5qkzfSRo59XTqo4Al+xFwEdDMv7xS4roXyheSR8Zjue112C55/TYi2bI+muC+vuXvZIadoSyyaub/AErVyFO2M0SbZj52hv4mymmGPnuKv1vUB7dxEuqeuFLfeSmEwoashRodi3ct5zE/3eIHcqyP4ZnrvMJZvje7FyOtKxfcLgBtHxR08oduXR7cN/Ujnwgq62pUUpppTzjcwoPwCeXTO2aYil0OaL+hW/n5HlgbCieI/+TZX6b1GEvcUWrcIaC4v+jzxA6236akmgvHTUOYtYD8HBgJlPOpRGYqhAkZ4/exyOq2NXTrt8oH2mvJaPV5J+6E6UTmqKCC9gVV5bCF3ZqXOJDyvD12rg8OXzQMEWqB7w+tXJit98XlxbUPSDmlBhdGXMLMzjMpm+unnv3spksi34R717gLiRmoymis+o4qZRAjOideiiE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee3855d-38a2-4bc8-f63a-08ddd3263542
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 07:12:01.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5COW3dKVGNZ2mCYEzP//lE/iTl2MItAwAPG7k/gtuZRzQ5gMoITn8jFHUNCK6Bw7nux+wIv6G4a2KscUOtODQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508040037
X-Authority-Analysis: v=2.4 cv=MdNsu4/f c=1 sm=1 tr=0 ts=68905d45 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=4ebpu32KbenZ9d9MrdUA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12065
X-Proofpoint-ORIG-GUID: S8sLCb11AW8Qktcvqjd2C-nhksnzZjbl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAzNyBTYWx0ZWRfX7DOA1/0R+v92
 mYPOQqVSGv0Tt8cTe/wH8J3hPnUot477hJemx8j2G0Vox8ZBuuSYQ7b9/zRoEBvFLWpAEqF2ywG
 Slsr2aL0DcNd2sEC9dc9arArH/GFYJ72XysTx9x08Hm21+Dmi2iVXbAXor9Cbf9r4FyQkBZj1CK
 EskT2FPgZNbQ8Mzl3Vtw1FMbw609lIGB1uxK0Toa5Bkc1rEwj5HhtfPLSLs4rB5RWkjIO4FKInF
 FdW/YFR6lD5fjXQvKSIuS41bOzIOpj+HtDfx+5TTDA6OAb+plmZsi7Mv+uO6UJz2qO3mqGHhLLb
 Y1fugSIvC/D7WU7DB5RVcQ2Ust/y3FEXpKdLplfW03n3c4SOdToNLyOr3hkNtEeZRnqRsQcJEXI
 bHy6Rt2aQP3BPcqPq9P8ZjIsga3ddXxiU0K/D9H/X+TsVdLsvABQTt1GUtwDj/+ddOSjJ2OU
X-Proofpoint-GUID: S8sLCb11AW8Qktcvqjd2C-nhksnzZjbl

On 02/08/2025 07:49, Ojaswin Mujoo wrote:
> On Fri, Aug 01, 2025 at 09:23:46AM +0100, John Garry wrote:
>> On 01/08/2025 07:41, Ojaswin Mujoo wrote:
>>> Got it, I think I can make this test work for ext4 only but then it might
>>> be more appropriate to run the fio tests directly on atomic blkdev and
>>> skip the FS, since we anyways want to focus on the storage stack.
>>>
>> testing on ext4 will prove also that the FS and iomap behave correctly in
>> that they generate a single bio per atomic write (as well as testing the
>> block stack and below).
> Okay, I think we are already testing those in the ext4/061 ext4/062
> tests of this patchset. Just thought blkdev test might be useful to keep
> in generic. Do you see a value in that or shall I just drop the generic
> overlapping write tests?

If you want to just test fio on the blkdev, then I think that is fine. 
Indeed, maybe such tests are useful in blktests also.

> 
> Also, just for the records, ext4 passes the fio tests ONLY because we use
> the same io size for all threads. If we happen to start overlapping
> RWF_ATOMIC writes with different sizes that can get torn due to racing
> unwritten conversion.

I'd keep the same io size for all threads in the tests.

Thanks,
John

