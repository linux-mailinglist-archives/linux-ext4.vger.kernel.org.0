Return-Path: <linux-ext4+bounces-9352-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C5FB242D9
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 09:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A83F3BEBB6
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 07:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA372D781B;
	Wed, 13 Aug 2025 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z7Gk1Lbz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m9b5F6VF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9933D2C375A;
	Wed, 13 Aug 2025 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070440; cv=fail; b=bIWXkd8Y4jgqh783ONNl7UiHx9SCF6mGMYBHCgz2KDoRphGZoJokRWi5sB7Elh7SzCV6lRUj056dVSJjxdGE8lJ02RGUebR9uJ7y0tiJc2EX+JrhCNlHk0JegkSCvpUo/unq0Acr/T8wkXUDdCwESde0zOCzaxea1tp+lvOW+jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070440; c=relaxed/simple;
	bh=69oUELaLhd2iHLaOVf2Fe54+wwF23h3KMxmvQiDlXzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uk4EI+jbA0gJqRCV2xf0dv1xZ/qmLbbj/HMJ5al/wcDdWSci8UOSiO9bgXZrwPmP6RHLXdlWDHBk+ehMXozSDoKXlGksrr2jZrsJQqlerL8ykqHW5B/Rk8XkKpU6ZS1Wj28dRoosYqoyc0XuWHg/VMGA1xfi2neuhqwWTsb3i5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z7Gk1Lbz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m9b5F6VF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6u6d8001280;
	Wed, 13 Aug 2025 07:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=N+1Y4NRPtHMkfdhTDkARkKe3/LPBZXTYCi8KwHe7YfQ=; b=
	Z7Gk1LbzAnglH5DSCOBD+QTnWV83+yV3j3NTo+n2+/99hddcLEaRKRllKkUPshwg
	Bat6c2NUI/qzMJTlS3qcjoRMSSsiGis+gy9wIIGg9ABfZLh62vcvxyxF6Vyo9klR
	LOCdIAK/TJVqaDF5Wes+hdcArex0HjzHH8bYnouWYqikQ2Bt36WoOgBA2dqKWzIn
	wngUQ5yfFDGSxWXwdRyo9C8poxYt7bCzquOW3+PX24ARe5EF4c+90tc9ZkvG6JNp
	9qMILjKwdEejvdL3yheUrayssT5ofBI8NUZll7aLxOkZ7/tfK7z2Do8Lrs0upO/c
	eRirIHrlQ5ELMc2KTfYPdA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvwxmka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 07:33:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57D717kk009671;
	Wed, 13 Aug 2025 07:33:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvshbu68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 07:33:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqRnHAhrKB1JmdUznNWN7q8c0Y0JfQNOPGqhTf6diEj8uCBOOfBVDxCtuynEW3Cbjvpha77xyVOTA4KR/DXVGgt2BpdbpPMNCKdGFOpnatP/wgpl2YJuQ057qlneH40pTlCcBXlC+IaFrc/ZuEF4ydW12gboei/tMTYq6UZx5nl66vYOsCaK7mvcPWLjFEYwiLJXw3Zoli4B2b+8xgWr1yRd2HmHYHz1vSIJJbulM6rg9DUNfqXNSAtJTw302Q9TkGtLJGkW1tq/RxhftrFHFLIDnTVAcR13Dh2ExMWxd3mMUUKkermecBYn84lPoft5bs0q3MzY0+wnbIzFhT5N7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+1Y4NRPtHMkfdhTDkARkKe3/LPBZXTYCi8KwHe7YfQ=;
 b=UOamG2yJ5rdBya0aYjjk6uQMcXkjU9/7IIVJwRKos0tG7XeJTaPqlaTH+kGDSiyLUq4brbF8NSn70uWllqm8+5WQFoorMDX5Hfl3zq/94Zpo53MIh6PZ7xoxfJA4j/L/gerG3MdreGtuvhVRSyo+68pZ/nnt2ImlHEhbazc3oHS6jdG4Sa4kkXcaOqICPY1HNyQKoxo19lk2HlS45diHSVBTcbcvg+lzrtY9aab8FN7pW7t6mN6FqgQXjKR1IIdMWfmLBX3LPjjxoi7XeNfhVtlZh2+L6hDdQP4v/+sJRUS6hbhgj7TWc29gPCWiyhZIeclTAXfxy84tS/5cyoOLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+1Y4NRPtHMkfdhTDkARkKe3/LPBZXTYCi8KwHe7YfQ=;
 b=m9b5F6VFYDl4Okj5D+DULdaIsXrHaV8PYVfiannLx1hIrx+/Yrf3U+4cA0h2Z2Eslth2GeiuvZX5yIKCAJ8k4QnN6PusGCh52OYjACL+TT/vflNtwl9ieiifTG+Wc3wfIhZl/LSG8Q7TOVcEGmDMkWiN0AreOehpWDOi4BqhIQ0=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by IA4PR10MB8541.namprd10.prod.outlook.com (2603:10b6:208:56b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 07:33:47 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 07:33:46 +0000
Message-ID: <c916cf31-26cb-4ca6-a7f5-15ec471ad0c8@oracle.com>
Date: Wed, 13 Aug 2025 08:33:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] ext4: Atomic writes stress test for bigalloc
 using fio crc verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <210979d189d43165fa792101cf2f4eb8ef02bc98.1754833177.git.ojaswin@linux.ibm.com>
 <62ae0bd7-51f2-454d-a005-9a3673059d1b@oracle.com>
 <aJw51DcgwQc3yfSj@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aJw51DcgwQc3yfSj@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::10) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|IA4PR10MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c076c8-2ef5-41b3-26f5-08ddda3bbcbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejVqaExvQ082UUpnQkdNYkxpcGYrbXhzVmZuN0MxeUdIc1lrZmVpSmRWUmFT?=
 =?utf-8?B?WW81Rjg1UURBM09kRkI2TDdiNFBWa2JaVjF5U3dkd2h0YXgyTk1IWnVhZ1Jt?=
 =?utf-8?B?dGxkaFkxY3gvVjV1TjBRU3Z3ZFR3cmFsRUs0cXo1eUJFT3dmRGZNSnN4M0ZC?=
 =?utf-8?B?ckphK1F5S2pkbTcyMEl2VDhkVFduNlRZc296S0hlV29xNWFwdTJic0ZQSU15?=
 =?utf-8?B?dDluZ1B5eUpuaHJGOU1YN3RFZDQyVkJZa1I3MUVhM1V3VmoyNVRDODJiTC9w?=
 =?utf-8?B?aU8yZTNRN3VUR1hvS1pzK002c3NqbUlreTFBUm5zWmIvWWVjdkpyMU9ycks0?=
 =?utf-8?B?dWM4RVlGY1RSWW1zN2pwd2szR3lOeUVIMFMxY3hJYUdiNkNoVTh5c2lTWGh3?=
 =?utf-8?B?UnZxaCtLZFdxeHYzS2ovY2V2T053Szhwc3FpdXRaMDRPRjh4bmFxSVU4dWVG?=
 =?utf-8?B?SnJQZHk3REplTjBJeVdBWFVBbFF6Y0xJZFA3QWROODZSWk1HbEUrUVY2SGcr?=
 =?utf-8?B?OHM2UTdrRkhPU1dkS2FPWnMwYUFwQ05hdUVTdXkxbll3M2x3U0d5QmhOZXVq?=
 =?utf-8?B?d1Q1YTdVR1huMDdNQzBBTTVIa1dueEVEU3hYdGZqUEt1QXdmTGtDSm5qakI2?=
 =?utf-8?B?MThZVnZmQ1dpRXVYWTA0QjJXSUFWSGVFdnJndk1FRktaSi9YQ1UxS05WUWtE?=
 =?utf-8?B?TVI1L0xiT3ZmOENkc1dZQ2V2cVE5UGF5WUkxekk2aVI3TkZzV0IzaW8zRWVI?=
 =?utf-8?B?bmlBUWxtc21ONS9xRkMvbTNIQXJCeXR5ZDBQVCs5SlN2N1RRbHRzSHlTRVpN?=
 =?utf-8?B?bUdQdVRzd1lmQVNxMVNzM3V2SU0yY3FqK3NRY28wWkJGZ0dteW9EajhBTFZP?=
 =?utf-8?B?TC9ISkJUTWNHb3Y5K01QMzBiN2xNYlAvcDY4S1RNcmVYcEV3alFGUE9udjV5?=
 =?utf-8?B?MnB3M2FzcG4xVDBpOWs0TjNOSjYyNUpJMFFXcVQ0SkRvK3RaTjNFUkUxM3dN?=
 =?utf-8?B?SHVvY1hEeUFrdGZKN0lzT0lUa2xQYyt1ajZaSzJmNU1yZURXdnJrcmFUdHRF?=
 =?utf-8?B?MS9wZkNSdWZZRW93VjN6RHViaDRXQVlqTXhYSVRYcnpnRkZkK2VkeXpFQ0RE?=
 =?utf-8?B?bnRkc2lIM1lWY2VickFjOFFjNThLV053UXV3ZGFCb1dMaExQc3h2dkxEemxG?=
 =?utf-8?B?eWhpanRuUXlsaFlVK1BzSi81WURwL0tCSWEwVWR3aU5qWC9oaVU1U0V1citP?=
 =?utf-8?B?V0c3QSt0YnFEUS94YTVUMHNhWmY1ZWR1Zys3QzF5dEdlenA4eUp5T24wQTB2?=
 =?utf-8?B?NlJuNDJWZnFDSE1VQW5FTlM5NEkrd05zSXNNVTRpVWdvVldqN0dwWXR4bkVx?=
 =?utf-8?B?azRKQWpOajBtYy9UekVKVmQybmMzWTdmT0d4WkZJMGcxUitmcnppT1FwZytM?=
 =?utf-8?B?cWVBOGpNblpRcnlFL1VxbTI2WHZ4enVNZVJHNVkwL293bHdEbVF2bVhGa3l3?=
 =?utf-8?B?clhlOUtwNndVQ2pMb2xJOG52eUNJS1ErLzM1cE84YkJlVlFuQVFzelh3UUZW?=
 =?utf-8?B?N05lL2FXTDk3eFRRUTQ3aWtpYTBha1FueTQ3RnJUL3pGeVhXZjdtZzhkM0VN?=
 =?utf-8?B?QjBsSExLVU5WUXRHQTYzRHhOTUs0WnBxc2pLc2doUi9taWdPbG5GZ1pBRStu?=
 =?utf-8?B?ZEl0NWRHQ3lpSmFiSHYvTGFTS2dmWmluekNNcFpjYXdVUzhyNGRMc1NVMGRy?=
 =?utf-8?B?UEhGWnVFVmFZNzZYaVNmUkl6NzYvcXN1cTR4WVN2NDNvRGk0eHk1WWRyMmo3?=
 =?utf-8?B?NEJhYUxEb3F3d21laFhycUdiU1NVR1o5eFFuaXJTV2dScFhBUFNtY25DYVlQ?=
 =?utf-8?B?MllvYytmWjBtOUJpTGpaVFE0V25CTFp1OUJ0eTVTUUZYbVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3oxQVEzLy92WG94aGNWYm5XRHZPTUZ4RkNaRDRYbkJaekM1aGJoQXA5eHho?=
 =?utf-8?B?QkJEVHJuU3p0NkwvUXdHNFYwTjJLUEJ0eEF1cy83VzVrS1pYRE1kT1NTNTlu?=
 =?utf-8?B?UXRURmFjSSsrWktxa1FER0NMUktYbHl3V216SWhEeTduRjJxL1E2R0hNYXVa?=
 =?utf-8?B?RTBzejBOOTQrNXVpUU5ZWXkxb2NQTVh3R3BtZWc0dklRQzU1UUpNclZIQ2ZV?=
 =?utf-8?B?SnZDSmpraXRSbUwvR3N1TVc2ek14dEV5TnBJbndHbldoMjBNSHBVa0ZTUWd3?=
 =?utf-8?B?UjZGbmg5eWpqSnhibloxa2lNeVhIVGd0WklXWnV5N2M2bzJsY28xYTNpL0JZ?=
 =?utf-8?B?RVpGN0l4ZDhvVlY1V2JTTUdlQnNLSUN4TGRxSWhxVVZEYjFyVlFnaUduRWEr?=
 =?utf-8?B?WUVuMUY4eWZMV3ZVZjZibWFocml6dFpEc2VrVUVrWXRuMVY5eHdCU3ViMW1q?=
 =?utf-8?B?VkdubWpUNUV5dmRUR3lpQ3ZUdUgvZnRyNzhGUlVGQ1BvVG5xT3JVSERUNEFM?=
 =?utf-8?B?aDRyNGsrdDBuTk9NWTU4cktoOHM5YUx4by9NN2h2cG1UUVgyYnhYUXdEWjho?=
 =?utf-8?B?MnUzd0tIaTI2ZjY4TTRUcUp4WTNYZWpwcnh0Z2JlcHVFakZoSnZMWEhDbnFz?=
 =?utf-8?B?UnF3YUdjS3k2VVZwMk1kcDJENXJna0tJRGVydUpqRHlBYmpORE15b3JSTFln?=
 =?utf-8?B?a2xRS25VTFZWdGc4RkpMeTBoYmxhRzBVc2lpMjFNWHhza0padlFRYllFK0JZ?=
 =?utf-8?B?MHNDcWtLVzhvS25jSi94VEg3aWF5WVpXUHgySEpsVUwwd2wxMjZFRUtXUG1M?=
 =?utf-8?B?WkFJMHRSTGRZSVdQVHNCaHlOVFVMWWhlZjRiUExmbndhRFVPY0JXUmVsUDZG?=
 =?utf-8?B?YXdQRS9LbUU3ejY0RURselQ3bHdoUUlJMjFNbmNveU5xZ3lJTEhuWGNxRDFL?=
 =?utf-8?B?NFlkYUd4azFKZVBnM2NCY0pKbVhxcG5rbUs1dUJkMjI3cEFiOWNlcVU5Tldl?=
 =?utf-8?B?WHlOQlZOR21MVHVES1lFVFBXSjNPZENXWGVZTW1JZXk1RXBWSjRVZ05icmZU?=
 =?utf-8?B?bW9jTFZhVXpRaHQ0cnJienIrSStnM1l3Vy9JRE13RGhGZzIrRytkZHM4R2hR?=
 =?utf-8?B?RWE5cWFQdlJNNnNSbk50bVNmOGtSTWJ5Q09FWUdJS0VmRW93Y3FsR0c3UExm?=
 =?utf-8?B?Y0lwTWZkQWFQdEEzNUNoUWsrSmVxbUFqcTQwdXUvTUlFcTRJa3lQcnlrWVRn?=
 =?utf-8?B?ZHp5WEppQzZUQTFaNXVzSGNwT3ZaeTlFNUpCMzFpcmVhSmZmWjhoRm1yK0hp?=
 =?utf-8?B?SzY3OXZ5ckVSK0JzYS8xYXZxQlpjRWlPdlNnUysvMHV1RGxSLzZPZ3hSRXBR?=
 =?utf-8?B?RndVZVYxSmRBMzBRdzFkVytWeFZBUnBSWkhsbUlKZXZSWFUrTTFCL2ZtTVFs?=
 =?utf-8?B?OExqVmRlVURFbjNIQUNOb2RTYm9uSWUreGlSMUZQc2IzaFh6b2VZdi9CR0E3?=
 =?utf-8?B?WWRpOFdqbGNYRSt1dkVtZXAzbHdPWjV4OGh4OFhHQjdXUi94MnlaemZkekhm?=
 =?utf-8?B?MXUrUitVa1pPdUZUVUF6RFhhNk5HVGh1YUlqRUpMTHlCZ0E5V1lMY3dmckNC?=
 =?utf-8?B?UmgyUEtOYU04QW5oUW1iV3hVdGhoQUtLSEJyWWpjVkt0NTIvM0FEcWF1ZURH?=
 =?utf-8?B?WGg5VVlFeHdqYmZwdlpKb2xkam1LMy9qOEhpbzFhT0kwdjRLamhyL2hEdXM4?=
 =?utf-8?B?bk9FYUlvNWVja0ZGcmptUkgyaDVYM3Byb01NeUdiMVZuNS9jaDI2VmZtUUlz?=
 =?utf-8?B?dk9jQmYwK3hud1djK1dodGtyNEhqRFByNmJOUFdlUjloS0N0TkErcnpOSWhU?=
 =?utf-8?B?WGV4aVErU0sxbStMZFV1UVh2aGN0Wmxla21ndlB2czhPUjhFVEZyd2FxeWlE?=
 =?utf-8?B?bzlMVllaKzVubkYzTVZ1QWFuMG1ZYUtYSmRFSWlkZTg5NTR5d1dXSmpJZG9T?=
 =?utf-8?B?RnZ3VDBqdytWdTNFaUFwUHRUbGNvUUdMaE11VnhDSUFvc0o4R2NtdkI2R3BD?=
 =?utf-8?B?M0lOZ0dmT0dtNmc2ckk0bXplbGpUR2l4MFlybTUveGpuYkIzNDU0OHV2TUky?=
 =?utf-8?B?VHM2dk1LWHY1UG9vTFZBczMzMGJldTlBMmQvbE1rV0FNbzVjUWJsRlhRYmg4?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K6N1PxzuObHvAJY90IlorIi+s7BGOuAlw/G0sTE8+wU299Xyzqo6PNgKtO84PELlSigw/YVta1QTOQvDFdzCd/746lY4Zl5j4A67Eeqzr3dCKBbwt6YIP3isVCaq8MG+Ue4obFmGoaGd8T5XWiQekc7j1k55WL8JZHcsr0y68DJfPBn3/tUAitUWN3xzxr7DgnFxvscWwCkUCVQEXNXqPep23sPNVkij96vE0oXv868A5Z7wkcxaEzYNH14QZ9fDEVW4PkmM74cU1c3OB217CgdF6nyw7iZaUzXEq2wKT4qHdx2i0K7ylXIHUZ3LAnC8GzZZwmRm3IXDCJa2OkyNyXq29wCB3N6Za/xNGnrtnbBfbMAwZ4L5uhsgXvSL1zxcF7BjSc/olw7Y0ygq8V+oYySmKxjd90X9207I7jbANBfqt7ksDgVB7uCW5FSnYguRkKafHVU6i8liP4qtHeg1uGaMxgloTp1ZKttSnZh4xpOSUzUIuDFOx/V1dTvtsrHeTQtwT6JScNIeV5h2JWGca0qpEutAamqX8VUFr9zQQSvKoJ1GwY5XAxJuWaRrfhfLQGF+rrtG0GLVdE7LBbF7cqUR2JGPscg/8ZMvEkZYrmA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c076c8-2ef5-41b3-26f5-08ddda3bbcbe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 07:33:46.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hp3CEDXwqSRgdxG+RcLUlHus4MlsZ8mVzRGoadSuu/bz25rz+dZ6eJfGIoTo4xuIAtWfmV6MTCilKt0YGID8Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=645 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130072
X-Proofpoint-GUID: ewz51EYD0wLrOUdl0t--UD9e9Bsb9yRx
X-Proofpoint-ORIG-GUID: ewz51EYD0wLrOUdl0t--UD9e9Bsb9yRx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA3MiBTYWx0ZWRfX67pdv+wZZspN
 NF/PjPab68a6nNuosyJ2od1KJcTMVYFKxkOWzx3U5XGJRpPllskZAgL5d/cmBs1TN8lEgrzNs2y
 QrXZeMcq/1XiTEiaWUI0yRy4d5s3jaHILr5QvIiiBT3eJcGFQV5t3mH8lgAFxEEBqrSfhf3X2hz
 ZB19OvnfITLT4NCsqMWlkd3+tXB/mdHgnGt9kb+ZsLkSqOT8VLIwLITtzJChDqbWrLrtOdHvUQN
 6g4x0lMfAjN9kLU8IRTS8on8z/344hunHtMdnYTQugNx+xbt2Um+0/0LTDuyDDaajlomzcQTu9+
 dT7GMwdaCREPeswGtIrlKgON/6FKfuNmiMiWVQ/sNRKvXE7StRcNfsvR8mLA6JjEIH1//jB3KDJ
 igtfc+lmEeaagt6lYu/cHDPTej/aHCB65zvM3bvfe9fdajijDrSjA4VX/viFBIERNm9kOJ8M
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689c3fdf b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pB0CfZdFucFKIcf5u7YA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069

On 13/08/2025 08:08, Ojaswin Mujoo wrote:
>>> +_begin_fstest auto rw stress atomicwrites
>>> +
>>> +_require_scratch_write_atomic
>>> +_require_aiodio
>> do you require fio with a certain version somewhere?
> Oh right you mentioned that atomic=1 was broken on some older fios.

It was not broken - it just did nothing. I suppose that they are the 
same thing.

> Would you happen to know which version fixed it?

fio 3.38

thanks,
John

