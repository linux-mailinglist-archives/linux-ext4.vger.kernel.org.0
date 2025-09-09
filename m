Return-Path: <linux-ext4+bounces-9857-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2895AB4A376
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 09:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF84C3B03E4
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 07:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CCB305977;
	Tue,  9 Sep 2025 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j7EQu71w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j2k4H0BM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AA61F30A4;
	Tue,  9 Sep 2025 07:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402835; cv=fail; b=Wpi/LplpeH7tFuvvYaNpgsyZAynzZqANRMajyuh6Cmjl8nxUv2Ozw/FIOiHZpFIiRrIjmLjecOyiy4UGUZiWM3m9PYwQQ+HeRt8kivIXgPZbFLuhHAyyvQhTl5KtEi00T8BjAa2p1G9ljqae35ZXJPrTu9sLsqDK7/sebl8dhrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402835; c=relaxed/simple;
	bh=RV0PY2OwinHk3YJ08hBSElRAfakbZcthlqFJ8i3/HFw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K5YVMQejUi7DOBed2iRd4u/kZP6Dmg1JDYLEpX8eD0FY/gsXnhIGm6KDgilu79NO6N7k8lZTg/E9cyp2lKuZBEtnRBUoKc1kvOS5nVxDcI9jJ85XqbvyKLtDaYfWlstaXNh+X4mrDYfazw98+WU1q0yf/26J9WWagmmmsVTA6FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j7EQu71w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j2k4H0BM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588LBl0A010589;
	Tue, 9 Sep 2025 07:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NBuDGAgW0ZQlqPuacVk/cK6NJYgLHeFBvfSnqqeIS44=; b=
	j7EQu71wAbJoSqwHXkwScx2aR4mpJLe+iMHYKERrH6XKj+LGEz0qX7ue1+mMMvNn
	tGy+RDDygUFYL7dSzRVViU5al6wbtEFF5xW34jroYq1gMgykLSKm+Opel8zDxvC3
	/gy8lwutF2IwExD+5zeB1ARbUXC/9CBY4urKj8mkRsv0yxaFWfy6npSu+yDDlA4V
	9hi1NKKoV8O91msJkPk5wors8XlJtBxTK9tSEpmX0yjWg5qZ1k1IDmjxcBVpNR97
	xrRykFL/xuDZaGqis82MeM+rVJxaF/aYNHrrYj8VOmKjXSWem4FGK/Ati+NsMpOO
	kIy1Zoq/VsrNsSeUa4d7gQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 492296182v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 07:27:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5896RGwR038722;
	Tue, 9 Sep 2025 07:27:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd981yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 07:27:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tm0meBAQUbr2bFDzAzIBzod7JjgjyOrdv8wSwjotvGohEF05U3k1mft44sp8ogFsPiAr40qisVtU1YFC40dl2wWRCnAbcmFIwkSPYUqpirc4MxTvfX2z1LaUfqBUUr6Ca6UNRd4/gi6DE9khXhydTXAXWMVvYtA66owf/JhcdP/K4phHe0UATROW64EUVRZZz4R1JvA1wjg+oMoe9gfWOPmOCN+nfwCEX5NWqOKhwsIohJWlo4dDllxocNAEoEuvdPDx4jQbRyEqgZzzKfcJy+hrOzN2BLfEpjagP49vARxMuKK2HZiA8EJaP5DuoAtE2BOhou1WKvly953uNTZSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBuDGAgW0ZQlqPuacVk/cK6NJYgLHeFBvfSnqqeIS44=;
 b=UJQamFXWCDeasyyVV91O6jKW77jkUdNlvYUCQF+9VYQjVL2zWLaA37jTl845veL9EDEDvoHe3KzgMIPtnmKdkchuAgXIQlLOe019zHTpS/boXakcBDC84jmoWEz1UlUIbEXkauHs5TcEHrTyEwJdPn8qHH68Yuwy6ajhk4OL40sqYr2udLVVSk5Vj4Vr5KOodJF8Mt9oRxP8y40Vn1b/KBTRYWfl2IFQcQNPhrCHVTeguxY3sJseOf/XOHFPlQU/h1KprVCpcdAsUBjAgRyG3hLfrL21KfBPiglQBXVgBIZiPybNK/O6rLN3A45FagbV6jAeEPKG7kzOEbbMNGbbmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBuDGAgW0ZQlqPuacVk/cK6NJYgLHeFBvfSnqqeIS44=;
 b=j2k4H0BMIQ4sn/hYxw/qodOK3LyJQIII+OUnc3cCHwVonfgLtfG7OBA1Pn9tfvFF5NwoixFSDcWq+4FVDHMCkZlYoK1bOgt8eBPQMHaEkhIvuB/lAfhCcZjyUI+MQfLFnpGbqU9aWRPB8AL7cgVMOvhNEwduSGH5ghVFNWxGXe0=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SA1PR10MB5823.namprd10.prod.outlook.com (2603:10b6:806:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 07:26:56 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 07:26:56 +0000
Message-ID: <08438a13-6be7-4be3-a102-35a1f6fec9a5@oracle.com>
Date: Tue, 9 Sep 2025 08:26:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        djwong@kernel.org, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>
 <20250907052943.4r3eod6bdb2up63p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aL_US3g7BFpRccQE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aL_US3g7BFpRccQE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0659.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::11) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SA1PR10MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: f23bee36-66a4-4709-ca5f-08ddef72414d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azNEdnM1S0FWZ2VqRUx5LzRuaWpzR1pwa2l3STlUTDBVak9YTlp0VVE4bnhU?=
 =?utf-8?B?K1lweFpoY2tWSTNLbTYySTg2VkFQYmhhZUhGMCtHd21aVEpjZGFyTFh4b2Jx?=
 =?utf-8?B?RHdtaDZOMmZjdUVycVYyNXlQSW5HRDFzS05XYnlncW9qMS90VHp5ZFJmOEs0?=
 =?utf-8?B?bnNtNkJPYXp4UU41QytIeXJZVkVTQjlXTUNNeC82V3NBR015dWFXZVMxR1p3?=
 =?utf-8?B?RldCbzhETkZNTStQdkFFdTZCSGpPMFBrWnJjbjZaaDEyajhaUXd1Y2lBK2RV?=
 =?utf-8?B?MGdjbVFhUUg2SzZBK3dFbEYwOWw5UkxmYWNFZUFDNkpZanZCdXZBQmJOUFZC?=
 =?utf-8?B?cWZ2UWp4cko2UHMveVhXTDVqRXRQWjUyeUorZFlZTTduTVIwaGdERk1STjdL?=
 =?utf-8?B?M3RWMzhpN2grUzRkbWlxM2ZFdFBHYnpNcGZFR0E1ekkrdnZzODI5UnZQYWFK?=
 =?utf-8?B?ZkpuNEp2aGJQOG9sc0tHSXVUL21TeEZGQ3ZmRkhWd1dxUXBMVkphaDNBVDVu?=
 =?utf-8?B?b0MyaXFmRUJuMXdwVlByVXZvanh5R2RMK2pHRUJqN0R4VHNjRnkrNng3UmpL?=
 =?utf-8?B?dlpScEw4OWtERVVDVVY5TkJtTkZ5WDJ0K3FXcDJFUjVtb1lwVW91OXR3RVBy?=
 =?utf-8?B?TVlXZnZWN3IwYXFkWXRvQ3lzSTZacFZHZ2luVi9uL1hxd1ZNY055RUI5aXM1?=
 =?utf-8?B?ajlVQ2NnOVpmMEJSYXZwK05OdjNpWG9oZS96SzVCMC9ITVBpNjlFait5YW5h?=
 =?utf-8?B?YmlOV0hpa0FGVmU4ZGIzeXpCc1krT1I0OW9NcldJcVpId000cGdMcjFUYWQ1?=
 =?utf-8?B?YnlTaFQvRUtvTlFzNWtnNzN0NklXdmFUczBpbEJXR3pGemdVTWw2RDUrVzhE?=
 =?utf-8?B?N1l4VkhuOUtKbDFVMTFkZE1RUUpqY2tuU3Y0KzBBSjFpRG5SelJjcHNZRGh3?=
 =?utf-8?B?RnhOL3NHTmppSktPRURMOGFLbStHZGRzTGlqYWp2cWdVK2hUaVh5VW1FcnhF?=
 =?utf-8?B?SHAyYVpJWFhzUktsM3c3OFlqcVc4RWdPMGRDczNvWCtRWDBadWVpYjNROGUz?=
 =?utf-8?B?ejV2MjZrWFNLdTJDZmFGa2tuRW5iNkJxdHZmRTU2RVYyUk9ROUtISG0xS3c0?=
 =?utf-8?B?QUlncFoza2Zsb1NtbmgxaDZFQ3Myck8rS3J4VFM1eTlLVUhlMVVJMjc2WDU5?=
 =?utf-8?B?bllCOFhFVFdYZG1jRG9ZRExWZm9nUzdCb3dwb3FDVmRiVnBXNFZsVkdNSUor?=
 =?utf-8?B?ajFkWG5ITk14Qjhtb1IzbzZscjQ2bEZCTGtXTVNJQ05XV2ppYjNrOFJ4TEZ3?=
 =?utf-8?B?Nmkza0hlY0t1ZkwvakhUOE12aWs2dXFtcHNWSkZ5VWJZMkFSRFZTWjFJQ1JF?=
 =?utf-8?B?amh2eGdaWVJXRHV1T2ZOZW15VUxhdmZvcGduamhWLzFsa2RTWGZGY2g1dDgv?=
 =?utf-8?B?OGhESFQxNlNyZUF2cHJ0eHIrL0U1bzNNRDlxZmJaY1lVb0YwUGptdDNrS0Fq?=
 =?utf-8?B?ZG5DaG1vYngxVlFYWExBYVR4VVBLM2pMdTFsV01SOHFXMFNQVVliRWhaWFFO?=
 =?utf-8?B?WmRycVpNVzZaVlB5MkdUMUp1NW55VVJhQ3FVaHRxZzd1OWc1SU9nYU9mb28z?=
 =?utf-8?B?YW9ZRGRreE0rOFIrYkdKTmRHRkFXY0Z4VlU2b2xqMGVzeHlKZGVzTVRtYm1h?=
 =?utf-8?B?RVYwL1ZFaFFyL05XWUllWjdsVWl1TU1DTXVJNlhRdnFDLzhWcURqTnQzQXZL?=
 =?utf-8?B?QkVwNjRQQm9paFQ5QnRDNndtTWh4aFA0YkNjSVppZ05sZ1BCY09pMXZ2aU1u?=
 =?utf-8?B?VDRyeGtETzYxUGM3WUZXVXdacjArYjBSa0ZOcStzNC9TUksyM0VlQnFJaGtl?=
 =?utf-8?B?ZzczS2d4dm5OSkh2MnpOQnpJQWlra2JpRlJUZ1pQVFZMRHR1WlNBcU0zeFhw?=
 =?utf-8?Q?Hl++1YDE3tA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0h2RGxwNFBsL25ZbTNjTmFlVVh2NHg2YmxhUVdpWmllZWRad0hIcnYxSVVl?=
 =?utf-8?B?dGkzYk50Wm1SSyt1RzRRTzBDK2xvTHRXTkFCMnI5bDBLWXl4d3ljRlBGRG5o?=
 =?utf-8?B?dUlQQlliQkYxRzBXYmZZelVQYU5XVmR5c0lha1JodDRkYnM2dmhUWmU3OHJ1?=
 =?utf-8?B?azV3NkMzU3dDNEYyU0JRZkxJTlhxZlQwLzJxV1RVVjV5UjVqVU9xeXRuK0px?=
 =?utf-8?B?N3B1RUJSTUQ3UnZSb1dZNGtVc0lwdWxlaEJhQ2RZZVBCKytuNTV0akdmeVRV?=
 =?utf-8?B?cU9GNW95M05NS3FDajhnNWt1ZlczTWh1Q0xMaUpEUWRCc2c5eXVSQUxEVTEy?=
 =?utf-8?B?TmE5aHBtaXBERHg1Nm5USndiSnFKazNZTWxwck9wMWVEM0Z6R0VmNlpFY08x?=
 =?utf-8?B?WElpcngrRExPVjBWU0cvUlZGbDR1T0pRYy80b1Zpc0M3ZWdId3JpYVhSYmNU?=
 =?utf-8?B?ZnBYdU9hYjREOHp4cU9hcU8yNEhnRm5uc1JwYVAxbmw5N1IxbTFCL0d4dXhH?=
 =?utf-8?B?N1lpQ2Y5VFE5UWFSYUI1QWtBTlVzNVIzYzdtWElYaDJ6eXdKVE05bDVUWlBu?=
 =?utf-8?B?ZnlOazdQNUJnbkRaeENkemxHVU5ZVzAvNUZscVJOakdCcXVHN3liNlBBbVl5?=
 =?utf-8?B?cWNieXRlcm9hRlVISWpBVmR0K2ticFNaRXgrR29NZk1xNHUxUU14ZFFvQ0VY?=
 =?utf-8?B?eWJ3eUFudVNGMi9MNFFDZlhGRmtCQU0vTFVJWkk1MFQwYXkxdVpWV0k0K0ZB?=
 =?utf-8?B?ZlB3R1BnSndTc3hzdVcrd1hzYTdaenE0NjUwNkIvcXMwYmxJOUpvTWlWYVIv?=
 =?utf-8?B?a2lCUmozV1BGVWxtVjhXaVhMdFp6T3RaR1hzM2tBeFRUNngvZHpIeW5lUUta?=
 =?utf-8?B?a3d0THU0Tm1RSEV3Ti80R3lZK1pyTnFaQ2FicDJJT0JpU2pXNE05NU1FVkhN?=
 =?utf-8?B?M1d0TXQ2QjhXWW4zMWRBMjRTTVlDQWV2Z3Rqdmluc2ZmZUZjbmlvSC95Q3M0?=
 =?utf-8?B?UGJvbllaUG5EZ3BxY0xzaWpqT1ZpZ2FPOUF1dzdRelZtazY0RUE1K0d1NDFM?=
 =?utf-8?B?Rlc2VDJkZkMzK25HeDNZblcybUh3SGRhckczOUFzZzBaR1Y4WVVaUXFKcmRt?=
 =?utf-8?B?ZGpPRTB5NkN3bWdUMGRCOXV4NnBBMEhUQUxWakZkTmxMOFNnb3Z2ek1qNUF2?=
 =?utf-8?B?VHZrdmpzWDIrb1JDcHI2SlFsdm9EcWhnY1dUTWNqb3d0Q293UUM4QmVqbjNV?=
 =?utf-8?B?QUtyYmpvS2EzSStMM3RHYmZWUmt2Y29lWDlFaUFmdWtsUFNhNjV0dDh0VmNE?=
 =?utf-8?B?NU1QT3E5ZE9rRmlKdW95ckVYb1lGbUQ2WFFSVGVFaFhTT004NkQyWEdmSTFt?=
 =?utf-8?B?K3JiQm9qUlNrR2ZiT01NWDdVS09Wb2hyazkxZ2tCZXRmTjloWU8vblNpc1dK?=
 =?utf-8?B?THJ3dUhXb0pkaDhwYi8rTG53WUVhdXNSWmdjRGJ5N2RGSDZoR21qalVkakVQ?=
 =?utf-8?B?cjBualRhSmhhUGJERzJFZ0todnV6QkljL0IzTi95UWtua2NGL0dvMXRZRkRX?=
 =?utf-8?B?UzJSbFozRDQzaWpPWXlGVFJEbm5qUzU5ZnNLUmRuV2Iwd2NCVGhWa3V0enJ3?=
 =?utf-8?B?bmFUcExZOENOc2JONEdhZmdyQ2pqeVN3dkN1Rmo5R2JnTzVwSk8zdVpBTGRT?=
 =?utf-8?B?dHcxUUZsOVRNZWN1Z0VEZGRuREVqcGZrL2lkbUUzbFlJS2lTQjJlbjdFQk1p?=
 =?utf-8?B?eURqakxpWFhDdGVQcXEwQU9Wb1V1V2xvS1lRbTlGUm9IYjFJbE1laU8zVFlm?=
 =?utf-8?B?RS92UGltRnBoekg4UjNlYjhjYitXN0dRc0hmdVJsbzZGTEltYUFxQmUybWU5?=
 =?utf-8?B?YmIzcUg3RjlHK1l5MEhxa0ExRWZ6QlQxMVNsamZ1YXhsWDllYTVUWXI1cDF3?=
 =?utf-8?B?SzI3aWx6bjN2K2RkZ2NWbkhPb3ZodnJ3WDZDMEZWcjgzYUx0cmsxZUtOVFNi?=
 =?utf-8?B?dVI3WmlnUWZjcGlIdDBMTFhRZFBXcU8rR3Z1QzNPWlF0VlZmL3pMNmwrT2p4?=
 =?utf-8?B?WGdIQVN5Ri9LYVZLNWdBaDVWWjVWQzJQTW1jaDJrdTBtVFVnNWl2Nko4WTJG?=
 =?utf-8?B?R0x2UHJwdXlra29uYWlRNWRTcVl5L0J5SEt0NHlubGNNamhGM2JxQlB5aGJ0?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nxcd7RSYisGtWcF74WKqquEGq8LAFerEdOheQCi0tdL0LRo2BxKHzcBpU7vEhBS2yowZl4fpwB+f9uSnN+vtre9sVRXVTbJq24MOvRnmUULMTg7XsxZGQ0PgArSx/gZpRcLXmm8F+OwYbQuYkgcbjc+/SYhWH0jqaZ5tF5P36A1tvhTd4rGFDnM5sYj6++ww+0iMRJO1o1B9GtX+TOA7gU9I4Q46Fvx8GJRuEVD4RQ6seNTC4163w9KClTVTNr5JGjwhe7/FdV9b9hvxPX4bBDZwmzXB5FPIDQEJrVVGN+vSoswYiGv1ZDVDfF+Y/Pgw25+rTsx0hJRtvAupORtN8vpWBwaJZc/7d/psQ1BevGi3E6GIZXJznJUmxKsrAY2hTujvYo6H/BoyfuspLeVO+WXXnPTi/V/DfHWKf51lQHr2D+iJ8uYojYVY3zscdCehxq+Df/t6lRWWqQXJlj2bS0A9MOs8x5EKTEb+zxHyI0eqjiWXSsiVyavbJvkuLx1+MS1byWd8EZ+NHanaOICwM+MskWsBCPWXlIeIp1eRJn++HhPegSDFw6Lny7iUQ/1GC/23DjvIQbni0sXAPh/XZ3iEuAE7I/Z5Zh3hSSB1pjw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23bee36-66a4-4709-ca5f-08ddef72414d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 07:26:55.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 798lA74AUQumT8x3k35c4yYZmpO7S7+fl2P7NqQt0ro5BxqwlqMMbDadaYntod2VEorD4zqc88N8HipxoUqi6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090072
X-Proofpoint-GUID: zHDVPLTaKlsR4P4ulw7rG7jrhm0YAJZS
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68bfd6c9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=sVk2sLmpIDiVa-hVQF8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfXxUC/8+eX+eMG
 GGQyfZECpNVSeUsTDaW1UsM54eDrAaym0pAEE30kV3yE+VTMQdOq51Yc++ubQsdwE/oQ6XFtkAp
 FTfP3yJmEP1/eulOnNPjFvpEXjYQxkFcmSBW4leTKQxx+KJSiNBexkhhDxDVQBN+HcLETU9D5bl
 hXXXgc65bOnFQ6eYy5ZvkfAhLjABbU1Kf37OFifXOkpbla04oQvC8Q6eARK0Iemb7w/LixiNqiH
 KFu7vvv/aU/OnspwrkgG7bbmmP3iuyRN00GDd8RAwrbJeRZl6C7qMuZq6zuFK+ACQsSU1krPkCU
 5Pj54t9SKXtckfPmf1ZBq5bwMhxfZeAuB9JOKfm0i6EqzbPRYHO1GJapheLDMMmFPayuaOj4uHS
 hy8G/o7oZXujlqFIM/R0axctFVB7Vw==
X-Proofpoint-ORIG-GUID: zHDVPLTaKlsR4P4ulw7rG7jrhm0YAJZS

On 09/09/2025 08:16, Ojaswin Mujoo wrote:
>>> This requires the user to know the version which corresponds to the feature.
>>> Is that how things are done for other such utilities and their versions vs
>>> features?
>>>
>>> I was going to suggest exporting something like
>>> _require_fio_atomic_writes(), and _require_fio_atomic_writes() calls
>>> _require_fio_version() to check the version.
>> (Sorry, I made a half reply in my last email)
>>
>> This looks better than only using _require_fio_version. But the nature is still
>> checking fio version. If we don't have a better idea to check if fio really
>> support atomic writes, the _require_fio_version is still needed.
>> Or we rename it to "__require_fio_version" (one more "_"), to mark it's
>> not recommended using directly. But that looks a bit like a trick 😂
>>
>> Thanks,
>> Zorro
> Hey Zorro, I agree with your points that version might not be the best
> indicator esp for downstream software, but at this point I'm unsure
> what's the workaround.
> 
> One thing that comes to mind is to let fio do the atomic write and use
> the tracepoints to confirm if RWF_ATOMIC was passed, but that adds a lot
> of dependency on tracing framework being present (im unsure if something
> like this is used somewhere in xfstests before). Further it's messy to
> figure out that out of all the IO fio command will do, which one to
> check for RWF_ATOMIC.
> 
> It can be done I suppose but is this sort of complexity something we
> want to add is the question. Or do we just go ahead with the version
> check.

I think that just checking the version is fine for this specific 
feature. But I still also think that versioning should be hidden from 
the end user, i.e. we should provide a helper like 
_require_fio_atomic_writes

thanks,
John

