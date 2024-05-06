Return-Path: <linux-ext4+bounces-2305-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384888BCB59
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 11:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8081C21CC0
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 09:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9ED1428E4;
	Mon,  6 May 2024 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ET1yaXbX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cwdp5+5J"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F5142648;
	Mon,  6 May 2024 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989421; cv=fail; b=NYtMGrj5b8mlgrPFE72HuI55vVlHErznV9ByYJzZK26COcqwmWdIgdYxCAStkEX/pwxOmZdrM7ZZrwfgZORjFjUCYHqhXFswc/ZdODo6zetfkU6mmF7v+upMOHLxFasN4eN1TfWKowKSJIvLZ7bR/iCieR9EcRgsrL/UpP2OGKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989421; c=relaxed/simple;
	bh=+fMOMvUMXgCg5kKKp7x7yi064z3ImaSj8hl00trgSn0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g/QJpgaAqH1OBv9+Ve0vel2kDAmgI39DvvpiRaZftu2Cb/UTwmRqIhG5TdNK9F42IpC5O6H/zjuggXo6tQdQSHL9i+UcyZMEMhvPSJpxoYAfE5Z5YdeikXN72NlDDlS+5BCmrmnzg7zTIlimrGyGUn+X//KsaPQ7cevZGCOM49c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ET1yaXbX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cwdp5+5J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 445NqpP6031818;
	Mon, 6 May 2024 09:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=onELP6MZG1daMfhGWNnmC+B9cSIA7onz5i6dW5p8k6A=;
 b=ET1yaXbXFef0uuQX4SUFbrp3SpkHMyzQom8Y4wUXzVjwUgtA0yARy57BTXA6wCqu8aZu
 m9DxJfJFCJWpbCUFmE2NTXbbK3nt6xGwweUmxgKSM28utAWBnT8fsqMWxBR26wiehnmz
 OEqz0cUn/7RVdtuThPLCOlgMNkdHw6aoS8OHqRnhGVDoXe8pAqES7Sow8Rin8dVoq8AN
 2YmWm3Rf4sdywkhRyPfdca+E5fJj7mmbrEm4ed9MpH98jznZHfUR3z3sHyTKNcW2J0FD
 /d1KJchks6lYobqNSek1h4XJwMG3CPj8gBLqjqQc7HtxElCNtO52Q1qB/AjIDTSwSeft gQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbm5j8xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 09:56:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4468l3kT040839;
	Mon, 6 May 2024 09:56:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf5mreq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 09:56:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOZUWTD69WiNrWR7pNSn2zuQo9jr4ixwAIcsoM6YDfpmM8IqPXlRUiMMWnbZp91ceB8/tFM9MI9z6jnjOmOHK78rE1LGXQU4iYweiR7cyTvPO92tm/gtvFIaR/8rVGBWCzTd85gVLHFrmnZ3nlCden8ynguU58yEdHSdAyB7GsgcVu7vcV0b2Z+vOoXGMz3ev9iDCaSYHEGMKmpI6YBKhBzS966r5Svs/EDSEJ9FZbJDUQCNl+BGsdgaktbDLX3+8edNWcpAUr/KbGra6goE82BEjfGSrnBAzTsf1SxIkVTH1Vd0aAQC7DSPzoZ6e2fNx8MzWMbjYDbOMSOMUYifVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onELP6MZG1daMfhGWNnmC+B9cSIA7onz5i6dW5p8k6A=;
 b=E7I6jcTmjigiUzlwvbSAnCrhKr4zcnMnOgkLbehifa9s8YNpHG0ToTrliIMqHI/WPe9F3HwZol7tK/hSWeHxVjpqt89+a0QBklKzniK7X3Aq2Z7pMVNuXe16bAFUBGrUecfSZg/1dwErA+hj9WBuHisHzA5GDSrSvl1x0troqsQD4M0jL82MjgrrVX8LLmrkdKmZhqWgi1tFDpDWHBgOfVLn2buk39TI7bEPz0LTK+2V6n3t9RNVOTwZu+OIym82xNhN79WluB6WzKgWdYvY8WCz47u8w8Q16imYxX6jpVcWre/OXwTCv0hyHDNJJpFyVznaUx5lCXCNsrIZHXuamg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onELP6MZG1daMfhGWNnmC+B9cSIA7onz5i6dW5p8k6A=;
 b=cwdp5+5Jpz9TiE5d+pO4jGGR7VAbPatsc4LInO2wllGJzZhYYd9ZLFFtjKy+7rJy9OLY4kcf6O1l4ThFSnKqAM9FF9N/XuoddBLDPBJHhiEARRCclV5Vy6f4/UOtmvV38uFirciU9NjQdTuvk48o2BqNiLmM2WdZ3k/2JHv/ijI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5043.namprd10.prod.outlook.com (2603:10b6:208:332::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 09:56:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 09:56:49 +0000
Message-ID: <a3bd9271-c010-4eb5-8814-0f9247ff4117@oracle.com>
Date: Mon, 6 May 2024 17:56:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] btrfs-progs: convert: support ext2 unwritten file
 data extents
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, y16267966@gmail.com, linux-ext4@vger.kernel.org
References: <cover.1714963428.git.anand.jain@oracle.com>
 <91f25251b1d57ee972179d707d13b453f43b5614.1714963428.git.anand.jain@oracle.com>
 <4c6ce351-e1fe-483a-8a9b-a1abb2324ea1@gmx.com>
 <fa9aa138-476d-413f-ac02-35156baacd66@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <fa9aa138-476d-413f-ac02-35156baacd66@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0136.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: 98acf4ec-55db-43d1-272f-08dc6db2d92c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WVVMUW9YWEI3NVJhc2lydHpwdEJTTGFGWkxSakJaOTFNZWdybXI3RmdvNkV1?=
 =?utf-8?B?Q3IyWGRuTG5HTjRYazIwakx3Zm1kbjQxajFWZ0JuVXNNMzRYTUdNRW9LOU9L?=
 =?utf-8?B?R2VTYVN6c2N4Vmw4alJXRDg0TGMxb1FWZjNsV0YvS3ZhYUg1aWxZSHZqR1BO?=
 =?utf-8?B?ZW40SldxMTRobVc2aVdtWVoyVXpuL1BHV1UrWjRIRDNKejN5Z3NQMnZvZ3BN?=
 =?utf-8?B?VTNRbU1td0xPRXd6QXdUNXQ2ZVRDVTM5WXZJc3dHdURYWVFaY0FLZ0owbXpw?=
 =?utf-8?B?SUo1UldtOXpZZHFYOTFBMDNMa1lsL2htWm4xQ2RrbHNIeFlHMHYvM3FyUnkv?=
 =?utf-8?B?aktiMUlFQlhtWFlaUjBCMmEzU3FESDZlek50QUdyRk5lLzBIc3FKdjFDcXg1?=
 =?utf-8?B?Q200clFtN3JPM21Gak5MYmpoYTRQNlZpQkt5WmoxUHRWajBWL3I1VUZNdFUv?=
 =?utf-8?B?NVU4YXFsWVljamdRVjAxUWtGa2J2VjIrcDY4WG83SWNNSXFGMEtUU3k1N0pq?=
 =?utf-8?B?Ump0REhRVUcvKytzdGs2TXcxeEI5QVdiS0cwdzg5eEVmSWFFVm5iWjhjTnhE?=
 =?utf-8?B?N1FuOE5Deno0TS9LL2NTZysvSVB0dDB3eDFSOFZqSFRVek16OS9JcHFGMjNq?=
 =?utf-8?B?eDFtUEcyQ3JCZm44ZlpnUnhEWVlacVMyWHBDOXgyRVZEQXAwdDBRVVdMenll?=
 =?utf-8?B?M2JTTjJVNGFtUTZoUVZFSU5LMjZHRjJieWZlWEYrZFJGNWgwbXdQUUtxT0E1?=
 =?utf-8?B?dlhQbXJnakF3RzBkOWp0bmFGUHZJL2g1REF2N3QxQzk0eVk2VEY4L25LQmJn?=
 =?utf-8?B?ekM2SWVnQlk1SFE2RXhrSXRkbm00WFRLUVFKR1pKSUV5MjUyR1pZbG5lZVcw?=
 =?utf-8?B?VnA1N3lwditmRzZHNnovUStKblhzTXZSeWZZMlY3YVFUeW16QVZud2J5WExw?=
 =?utf-8?B?ZThqb3owUHJNMEtGR04zTG50OVI4ZXRiZnBSS2JpWkZSTElhaXN6elVldzVw?=
 =?utf-8?B?OHk5N0grRFJKR0xSaEZFYUx1MDhWQVBpUzdaM2xPWGJza0tXRkduU3FFaE9T?=
 =?utf-8?B?V3lxR0Juc0Q5eU5haUhZNFVrT3FuQzEvOTV4cFlxZ0xpZ0YzUXRsWDBwWlNj?=
 =?utf-8?B?M2FvVXJRWkpOdDRyU3hLRFA4T3lENGd5U0RIQkJRSFlqSDVJSXpSaXpVWEht?=
 =?utf-8?B?eDc3Vm00T0gxN2NKNitPM1VoYnFDck5oaytPNUtDQm12eUtPR05qUDBQZXJL?=
 =?utf-8?B?QmlkTXV2b2ZXcnloa3JDcnB2Ky91N3RCNkJ6azAzQ2trRjNTbDJSc1ZsY3ow?=
 =?utf-8?B?OVNpS250cld4Uk9DYThnS3RoSU9MMVBweDhtazRsNkxheFpWTmJOK0gwaHE4?=
 =?utf-8?B?UzhxS3FVV3ZwTkpyMWg0UnN6dTJ3aEtGMkFQYXVSMEZxUHFvWUdxZEFsekMw?=
 =?utf-8?B?VVl1YnJER1pNVlBzNGRyZDd5aW9uUWk0OFVPZG8zRFk0Y3ViRncybmJnUlFU?=
 =?utf-8?B?WGtzcENJUThZdG9GVmNxeGp3WlZhWHlPUWFOU2RmanpXY3R6cm1MT0FmYXpJ?=
 =?utf-8?B?YVJ2TjRPdFQ1V3FnSnNzaUU3cWVsVkYwU1A5TCtueXBOaVBJVnV1WUpLVC9Z?=
 =?utf-8?B?TXplL3g3WUkyejBXTTZBNVBvN2hiUDJCaVVVSkN4amx5MXQzWHhzTnV1aXlN?=
 =?utf-8?B?ZFdtKy9XekZHbWE0cmpPWDFjWWhUSHNxZmNzNkpLVEx0ZGVKSFZjNklBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dERyRkRpWm5pL2NrbnZUbE1DRFlHYXFzcXh4REJteXZ1ekFlVkZua013cWxo?=
 =?utf-8?B?Q3RKdm9OdVNxTEcxL0hYdHgycmdodUgySlZjWitsLyt4VEw5YVRwb2w5dlNH?=
 =?utf-8?B?K29WZklhRi95dDcrSm5pa21qY3UzRlIvN093bkFhWkFnTGh5K21zWC9GQjVz?=
 =?utf-8?B?L01UWXhYMFZvc1QrRWpUZ1pBcUVQSjV5amxyUGh1QjllTGtteHE4NlI2RFl1?=
 =?utf-8?B?bmJMbXJsUUNORHZuWTdzL1YydXJiVXVlWnJhR2plQUtteWd4dXp6T0haRnJw?=
 =?utf-8?B?cXZYSkNXL0h1RnFuZmU1VFNGL0oyZE85RGloMVBIN1ZaZE8rZVhwVmJhWElG?=
 =?utf-8?B?eXhxaDNTLy9SUU9OSE5qSjA2MTE4dzE5cXZJdmRGcDBqazFkbWsvWUZBdlNa?=
 =?utf-8?B?eU5aREpCYngxUnAzdCtNeE12eTd5MnRvZDltRjQ3MXRqVWwrNkI5QUdKblZB?=
 =?utf-8?B?NnZnWFIwUjYrTWNZbTlUbHJEMGsza2hhelNtbWJrMkNqMHVoU1Z6UnJWcUtC?=
 =?utf-8?B?emhXbGE1VWNaK0YyUWhGdzg4dHd1SUtLMXVINWpMTitsaXVWYWhXRkJoWFV5?=
 =?utf-8?B?eWZFMFR1VUlXN2NBTkp6RXZWWlk5OGhCa2w2NG8rbXdtTUpxUk9FSTZiVHpn?=
 =?utf-8?B?d1c4SHg2VU9tNXZ4Z2ZMZ0VmUjVLM2VkdEdNeTFVTjFRV01RWWlLejg4ODJj?=
 =?utf-8?B?Q3J3ZndqVWFFUDU1VWd3ZXg1aHpLQlN5STFmNmRwaExjdjA5c0xMOXZMQVJY?=
 =?utf-8?B?c2p6RGVBeE1Bc2ZDNm5CbDJFc1VIQjFSVDRQL3V5YWI0WTNraG1mRDRjb0Ro?=
 =?utf-8?B?V2NjeWhUQ1VQbDNGMlg4OHRnR2tZNzBBaVdSUnkxMzZIdTM5WkxhbDI4akQr?=
 =?utf-8?B?RmZQeTB6S2NKNC9nclBXbHpJN3FSY2dxV3pIemVaUDZjNmt2WlFFQzhUaEh6?=
 =?utf-8?B?K2NPWHMydXd1RFdjd2RUbVlRRnhYZUZ5c29iZGc3ckxOUUhTU1czMzUrUU56?=
 =?utf-8?B?azkyckpuNVNTbUtBRERjQTZaR1dHUHhxbnYrK0lhS2h1NjhGYXFwVlpmV2dn?=
 =?utf-8?B?NFFBV241YVhxNkROM0t6VzhCUTVoaXkzdFpvOW5RN1JBTjZObUFKS0VYaGE5?=
 =?utf-8?B?Y2hwWTcrU2VwMWhLR2Q1Tm9aK0JSZ1hFKzF6NVgwL3EyaXYzdVFEQUl4RmZG?=
 =?utf-8?B?MGlLZHVlOHhOSmpJeS9KcC8wN1BnN0dmMkQ5Z2QxR1BYZGJnNk9ia0luZ1Ji?=
 =?utf-8?B?d3ZVSnJoZnNBbkgrdG8wdzAwZVVUbFFod25oWEc0YXRXWnZ5ODhYa2N6aTZ2?=
 =?utf-8?B?OGNNZTRacHVCVVpmRnBDZGJFNjNLZUpDbjZNRVhXR0tjYXlJbFViZlI0V3VV?=
 =?utf-8?B?YzdXMDZXZXFYREZmNXp5bEE3Nkl0Yko5bk9RUnhiZVRVSWQ3ZXd1UGdkeFp0?=
 =?utf-8?B?ZEFTZ0x5VmV6a1dVVFhjczE3VlhQTFJlQXcySGFWaVIxVzdocUVwWEljTE1r?=
 =?utf-8?B?bHJHNEN0Snp0NnBKQnMyNEs1bjgvSjFmYWIvQW45R2l5VUhId2JhOTN5SjF4?=
 =?utf-8?B?WFRwa1hJVEhiN1FBOHFYNk1YSytNVFJPV2RiTXpkdFZvN2JvdGRQT3VTcERB?=
 =?utf-8?B?YWltRHdkY0NlZWJZUloxc1NNWnF0SXhwanM2c3lHY1lzUFhNWjZpZ1lsZksw?=
 =?utf-8?B?VFhmc0F5d3NybzViNDVTaEtNVUJ4TWhhN0dtMVBmRnZmTjN3RUhVS3Rza25P?=
 =?utf-8?B?NDBpZG5xVTU1UTFMOWlucCtZZW5NT3J0Nnk0OWVhQ0NUZkhNQWlZQnBhM0w4?=
 =?utf-8?B?OWVWN3ZKa1JSNDA3bEQxelZZeHhiNXJzeVc5ZE5YbDk2cXFDU2t4bHJZZ2pi?=
 =?utf-8?B?Z2NEZ2xxTitZeS9MM2MyZ3Bob0NYbWxQTXF3SEcvb3Fha3NEd0JVTUUzWHVS?=
 =?utf-8?B?OWtJL2dhbkVGNW5nWisxcUVDQ2lSNVlCejN0RGEwU1ExWVlxOHNweTUzcUZR?=
 =?utf-8?B?K2laQzhoLzVNbGZhV2FLMG5GQndjSVd1Vm96Sk5XdEV3RVZVeHB1d216bDNV?=
 =?utf-8?B?QjFuTTg0ZHBDTTBwOUQ1OGNJTytuYmJCWWFUb1BKVjFjYkxZSmZDaVJkNFBn?=
 =?utf-8?B?Rnk0N0ExNWNHYWNvdzRTRVpESENNR1hWZ2dmNFlOQjVBSjZnVGRwbnV4Rk5h?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F4FTuUr27BSV17zw3wn7ojpJBBtdN9Gcr39lRN25Rf8mRy69C/Mk5AMc8yhRGqfZ84Upll5vk9sQXKwSdmghTOsz5/4ej03OBFEXWSLAG/V2OlJ3BpZeQtBkvp80Ai5RwO2ZJFCzMGf+kI4NqWdHGs8lH+GavADvmJ5pDxZLoH6/EewRJNu/AnWjy+1/GAv9GCIOUClBYXvPVnP2orDzamN3nJx30sGca+EIka49IDjo31Bnh0yzjyTJcGXZM28q6qS1G+yRfNOvRsvTEDtHTSmMukZXtiSR+qMFHpnIf/+SNM+0xkRJT5o8qnxoTrWTomPNaQb2gpXi/OonNwZRiOtdXIcmfuNhcDk6CirRKf73GdFh3YKFZupd58RFHMvKlDguE22MENxqLd68zO9k8tWh6o8iQxoLj3zgs8j7e0t2b62Qs7HBL+UTUxDtTiZn93wsU5qMjvrXS07uzTAdLo/t0aA0+kLLqit0RmV3lS4+Wpa4fnVqIO3zLR9yt7ra5dcVbE8+DFoq0SP7c4BBbWJgXN1rm28IF6U31gEEWkQXCMwMe9MxxugVTNKA4HDDdrNSDMOI5zz9bd3XKCrpFzWHCzublOh/Bg01j4k0dRI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98acf4ec-55db-43d1-272f-08dc6db2d92c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 09:56:49.6327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWH83P9EsHZWbrDiLQrutl2Gscal7flb/R+2dhxFBKO8+D+pScGtx7pk8duj2vtKaqt7Gq2NQXPd4nnbIBiUAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5043
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_06,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060067
X-Proofpoint-GUID: xrcWEbPt5F_trgi5GbwJm9aAB6oRkmYa
X-Proofpoint-ORIG-GUID: xrcWEbPt5F_trgi5GbwJm9aAB6oRkmYa


>>> . Remove RFC
>>> . Identify the block with a merged preallocated extent and call 
>>> fail-safe
>>> . Qu has an idea that it could be marked as a hole, which may be 
>>> based on
>>>    top of this patch.
>>
>> Well, my idea of going holes other than preallocated extents is mostly
>> to avoid the extra @prealloc flag parameter.
>>
>> But that's not a big deal for now, as I found the following way to
>> easily crack your v2 patchset:


This patch and the below test case are working as designed it is not
a bug/crack, with the current limitation that it should fail (safer
than silent corruption) (as shown below) when there is a merged 
unwritten data extent.


   ERROR: inode 13 index 0: identified unsupported merged block length 1 
wanted 4


This is an intermediary stage while the full support is being added.


Given this option, the user will have a choice to work on the identified
inode and make it a non-unwritten extent so that btrfs-convert shall be
successful.


>>
>>   # fallocate -l 1G test.img
>>   # mkfs.ext4 -F test.img
>>   # mount test.img $mnt
>>   # xfs_io -f -c "falloc 0 16K" $mnt/file
>>   # sync
>>   # xfs_io -f -c "pwrite 0 4k" -c "pwrite 12k 4k" $mnt/file
>>   # umount $mnt
>>   # ./btrfs-convert test.img
>> btrfs-convert from btrfs-progs v6.8
>>
>> Source filesystem:
>>    Type:           ext2
>>    Label:
>>    Blocksize:      4096
>>    UUID:           0f98aa2a-b1ee-4e91-8815-9b9a7b4af00a
>> Target filesystem:
>>    Label:
>>    Blocksize:      4096
>>    Nodesize:       16384
>>    UUID:           3b8db399-8e25-495b-a41c-47afcb672020
>>    Checksum:       crc32c
>>    Features:       extref, skinny-metadata, no-holes, free-space-tree
>> (default)
>>      Data csum:    yes
>>      Inline data:  yes
>>      Copy xattr:   yes
>> Reported stats:
>>    Total space:      1073741824
>>    Free space:        872349696 (81.24%)
>>    Inode count:           65536
>>    Free inodes:           65523
>>    Block count:          262144
>> Create initial btrfs filesystem
>> Create ext2 image file
>> Create btrfs metadata
>> ERROR: inode 13 index 0: identified unsupported merged block length 1
>> wanted 4
>> ERROR: failed to copy ext2 inode 13: -22
>> ERROR: error during copy_inodes -22
>> WARNING: error during conversion, the original filesystem is not modified
>>



>> [...]
>>> +
>>> +    memset(&extent, 0, sizeof(struct ext2fs_extent));
>>> +    if (ext2fs_extent_get(handle, EXT2_EXTENT_CURRENT, &extent)) {
>>> +        error("ext2fs_extent_get EXT2_EXTENT_CURRENT failed inode %d",
>>> +               src->ext2_ino);
>>> +        ext2fs_extent_free(handle);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (extent.e_pblk != data->disk_block) {
>>> +    error("inode %d index %d found wrong extent e_pblk %llu wanted 
>>> disk_block %llu",
>>> +               src->ext2_ino, index, extent.e_pblk, data->disk_block);
>>> +        ext2fs_extent_free(handle);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (extent.e_len != data->num_blocks) {
>>> +    error("inode %d index %d: identified unsupported merged block 
>>> length %u wanted %llu",
>>> +            src->ext2_ino, index, extent.e_len, data->num_blocks);
>>> +        ext2fs_extent_free(handle);
>>> +        return -EINVAL;
>>> +    }
>>
>> You have to split the extent in this case. As the example I gave, part
>> of the extent can have been written.
>> (And I'm not sure if the e_pblk check is also correct)
>>
>> I believe the example I gave could be a pretty good test case.
>> (Or you can go one step further to interleave every 4K)
> 
> Furthermore, I have to consider what is the best way to iterate all data 
> extents of an ext2 inode.
> 
> Instead of ext2fs_block_iterate2(), I'm wondering if 
> ext2fs_extent_goto() would be a better solution. (As long as if it can 
> handle holes).
> 
> Another thing is, please Cc this series to ext4 mailing list if possible.
> I hope to get some feedback from the ext4 exports as they may have a 
> much better idea than us.
> 

I've tried fixes without success. Empirically, I found
that the main issue is extent optimization and merging,
which ignores the unwritten flag, idk where is this
happening. I think it is during writing the ext4 image
at the inode BTRFS_FIRST_FREE_OBJECTID + 1.

If avoiding this optimization possible, the extent boundary
will align with ext4 and thus its flags.

Thanks, Anand



