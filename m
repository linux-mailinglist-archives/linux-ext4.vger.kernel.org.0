Return-Path: <linux-ext4+bounces-9042-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B94CB08ED3
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 16:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7831638FD
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 14:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812722F6FA7;
	Thu, 17 Jul 2025 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bpQveVrx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OcxhGvTS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B121DE4E1;
	Thu, 17 Jul 2025 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761182; cv=fail; b=g18x7c+65BLen/Lh+KRz8Ha5goUNhOXtUYOzoxRBE82sIp8oo/CfG4mHDoFqMghauLmI6kFpqR5Gi9p6a4wFZCtYIKutlWSHmY7I/Ge9+SZguH+5scG9/phjOIdwL1KcnjDp/hbVkjoLupoS+mL2cY9ix2MqfWIqQLp7q7hX0yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761182; c=relaxed/simple;
	bh=TzNrAk+r+cetnoo4aYAOO3xg0pclXg+w4xG8SuZjP4M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OsqwmxIgU0DCXkacQTS5Fk5644hq1NSZhv/VQgoa2y76ykqDQ03H4euLPoPPdjSZUd5M+zK5iFLafKKWrAo3DDKuCZIfuAVl9M+RG185+ARYDaaUz28DbXxvQ9ctfv5/06rxd7SRAJ1j5VPacZPLXvkPohD9ZtT2CCsiKLZ2gxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bpQveVrx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OcxhGvTS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7fo3c003339;
	Thu, 17 Jul 2025 14:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rognC16WY+eBPg0nsRtknKj0JH/yzc3k+mXDC33Lg70=; b=
	bpQveVrx9w1IoVgNmmerOJmonVtyg7vFoHIKqWCcR/MhUBsjHwBiw4NRWM8CpbcE
	uTSYnKFHnLpFQYXIVTg50zs4ExrTFB7eDECvh+/Gecq5G6pjCqREPkT6IH84wBuj
	rO6cD7g/g1I7BuWaxh/4enk/4PfUXLJqR0E7X82TD7jJuiVaxYjHrwr5BATCP1U+
	+oNchynxu+QOulsuyemuomhoCSz1FAkM9lMl27NIuTuUM5MmbkrsRrVXRwntfsMc
	6Igv9BnMfeT/3cv7lVNFzvYq62wBMMJ50QEa9rkI83x7p4WueDPxNkJvOkyzALme
	J6GS6wMiJIgHXAwwDUt2gQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr12yra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 14:06:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HE0naJ039704;
	Thu, 17 Jul 2025 14:06:09 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5ctck1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 14:06:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTuTblPUYJ+a3byILZUEHj0rmOZE7pVZfw0cfGVmDsjKSiYYykHAvaeW1pfIkl4aMgquUe7m5xjWgA0EUo3MPu/oCHdrBbtEPiHzVyB5JbacrW87XXzWy9aFle+zt2aRIlfzPj67vJ4uUjO47BYPBKtNsG+KxWPRirptlK0cHTF01Ywyw2G/QPlMVCOCZOSLx4GHM/9/Jf8PNLeNlT+o9nJOIO80NJhf6J8PRkD5/zsCIMzA6CyctAoq1Q8cAgeGX8s6mVru4KEzI6dusHVlG22/0qZd9+hRLzGRYbD0a6Feka6p3dZA0xQ6ZJS8HWg8B5I69Fe6xjakKVWTb/Mksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rognC16WY+eBPg0nsRtknKj0JH/yzc3k+mXDC33Lg70=;
 b=xudeAMvjOEPd9O+vWZF1+Wp/96aQGkIyxZ95Ijk6v090gb9tI1lUv/WN+hOlWOYZxn/Lk53ByzAW2KucDpI32cS15UFo7Ldn14ROzPR/nscCo3975CcXQe7beco3+ySlxLSBz9AiUju8t0SyUQYcfVFSvnvevXe7StL9ZKChImvLDbwujej0He4hnZME0SjpXfAeyKdyBW054u8aVMwNcm8GpyiejImyXyCW3Ur1zFFIcp7CN+kfNm/AXZ8gqWtKwlcytM4lgfwyVCeTBcMFDZ2YOfSNpKu7nYIUHaDOsHk0o+N2qahTN7OahqPRbqmibbvc6p8zevWa0orrtrsehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rognC16WY+eBPg0nsRtknKj0JH/yzc3k+mXDC33Lg70=;
 b=OcxhGvTSVpnKFx0H/q5NlmPmC2SLIVhOr4rNB2jsMO63boBPb++y7Gew+AhePcgSX7PDFGSFPnQuToXQU2+cXlLRQlqOLbmUeOcUjaj3fM3UnFzl8NUeZn5qUYz3lRxnRISD25Ysx11ZbSSQarJAL9ipOZgIPR0Wr/sUBfvMqBo=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CY8PR10MB7380.namprd10.prod.outlook.com (2603:10b6:930:97::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 14:06:04 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 14:06:04 +0000
Message-ID: <b270bb66-721e-4433-adaf-fe5ae100ca6e@oracle.com>
Date: Thu, 17 Jul 2025 15:06:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <1e6dad5f4bdc8107e670cc0bd3ce0fccd0c9037a.1752329098.git.ojaswin@linux.ibm.com>
 <5211dff7-579b-48ea-8180-72d8c6083400@oracle.com>
 <aHkAJJkvaWYJu7gC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aHkAJJkvaWYJu7gC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0003.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::13) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CY8PR10MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7e38ea-5541-4427-f78d-08ddc53b1122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THo3VFRjVHBFNkdwU3F4UFROWExjSUROcUFxUDN2UWhlZm8xRTNBeFNkcjM1?=
 =?utf-8?B?V1QxZ0tGYUVZZStNNUJSRWRtcTNRZGtMT2ZUdjhTMlV3RWNIQkpKdzVnVk1Q?=
 =?utf-8?B?TVowbHJDWUtXS3l4YXdHWERZdG4xa0E5MkZiZmlGenZtZFVJYmg5VkVKLytq?=
 =?utf-8?B?ZCthMEhqV0VnZ0RYL04vUnhLNkMxM0s2ckVWRStuNkkwSkhVV0dvejRHL2lK?=
 =?utf-8?B?NTdQSUJQYUpoVE0vQlBoZ3gxVFZXcjNUNnQ5YUFmVmtLUDBLYnVKUGtSMWxt?=
 =?utf-8?B?RElrSVVoNThOV3IvbFF0TFloZEEwYjNjYis1ZnQxRHFMcDNNZUpRVnpDSkZF?=
 =?utf-8?B?MGdNMXBCTXRwRXpPZ1NYUXNLRjZhM0lTN2VRZmxZQncvZGRmbllOMkpMcU93?=
 =?utf-8?B?YmdaeERzQ1pNUzlLaWYzVnprMGgzWGNzMzVYMkdqSmZML1R1UGQ3L3Z0amNJ?=
 =?utf-8?B?cUNWUDVIZGU0cEVwQWNnQ1NGRDdrRTBEUHVWbDFucHArR29aZjNTakRRWUFk?=
 =?utf-8?B?a25Fblk0QTE2eHZMbE05c09XZ3RIeEtBc3BaZmt3VDA0dFZxTWUyNEJuaVhW?=
 =?utf-8?B?VGxsai9MMDdIa2d0dCtaay9kWVNCbk5qaFdURXJHY1V3T3krQXdYV2haY0pa?=
 =?utf-8?B?UzVnb0d6UXo2cElCdjRRYXFEekxTYlREeFB6WTJKdkQ2Ly9CZEdRcVFTdWZN?=
 =?utf-8?B?Y3RaOVlMSDJNejB0UjZuaXdyc2xuV2g2MWkzQnUzTE9GVGdJVmZYZjZCbDJC?=
 =?utf-8?B?UW15dzZ4ZWc5bm5xZ2premRVb1d4dVc0ZEZjckpVM20vUGxjcFExWVI2OWw4?=
 =?utf-8?B?U2kyNHFjM0plbC9lZ2kyS0prYklNVHVpQ0JQTUNRclQ2MnlSN3ZSK2Z2bzEv?=
 =?utf-8?B?WEdpWXp4T3d6c21WQTlEMWJuU3FFVGFZZFcvc200RytqK0haeVoveWNtRFp0?=
 =?utf-8?B?ZW5ocFI4cStyc0dSVWtZWnpDeTRzRkRvZE9vWVc2Ry82T0RNMUZUa210MWta?=
 =?utf-8?B?REt3Tnl6YWUybnlFTXRQbnZOUWRnVGs1UjF1RldFN2M5SVlGSmRVUTMydktS?=
 =?utf-8?B?QmRoK0RoamViOUVtMUFJTU9GYlRzU3NBYjgzQm9ZU2cvTnZYRVZLNHdwL3FG?=
 =?utf-8?B?T1dkejFDV2hLNzlRNEN1UlNtQlMvZ3F6Vk13d1V3bWVBOGRQckF6QmVGck8v?=
 =?utf-8?B?VGoxbW8yQVk5Rm5HM0g2TUxvWFZhY2VHY1Npakl6RTl6UEVoSDVmMjRSbENy?=
 =?utf-8?B?d3QwanJTUGZSYmt1MHYrOVBYZC85ZlVGenpvQ20xcFVvL0xxdFBlR3NJclda?=
 =?utf-8?B?V0tmRWd1OFRzWFRSVEVUOXk2VXVXMWgrREVLTTlqWHNmZ25waFdJbE1zSmJR?=
 =?utf-8?B?a2M3K0JUcVdYU3RQZzdUS2tYSkJhWGV4VW1ONGtzUW05ZlhONHEwNmlzWjZn?=
 =?utf-8?B?dnBIbEJrODVVMzlVVVQ0eHhDYSs4NlJRT21yNGxQMFhQQVNtZm5DWnVaeUVm?=
 =?utf-8?B?Qytnb1BFaFAwdEJDZEc4UVNjTTd2UnNudnBMMGtYbUNIY0NUSUxtam5MVmZy?=
 =?utf-8?B?REFqVVZUUVQ3U3JWTW5XTzZDZ1FQT3E4dE0wdi9xdDVMcjFzcFlWUnFRVkVX?=
 =?utf-8?B?NVNiamVWaGNuWGVFTStqdlgxUEVuRkJjS2UwU25xN0VVT2NSdGhXVlBSK25r?=
 =?utf-8?B?UDFYUjVPbTBtQ2cybFVscFAwVW5HUnR4UlNKU2Q5TEpHcDJlNTFRK3ZacW8v?=
 =?utf-8?B?SXMwbmp4bW9JWXRMTWpha3hNNTVDbDVjdjJkUDR0WlRTWGFlWGgrdjRFR3Z1?=
 =?utf-8?B?UG9Td1dNL3Q4UFJBZnY0SUkyYWZnenVvSW5wazFiQ1dnSEZqU3oyZVJQUmRV?=
 =?utf-8?B?RmZhK1dHcWY3U3Q5YlpTdWVRZndTVGlsNHpMOWt0WEJETlZFUXFKeXdSaDZq?=
 =?utf-8?Q?ararQdDfFTE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk5xVU14blhVMy9lOTY5R1hzd1h2MjE1TFhZSzFqS09jTHpCT3VYbk51dlNM?=
 =?utf-8?B?cUIyLy9STndGUzluQXVlVmNHb01sYmdoTGVOVlEvYTIycmwxOGR3TXA4UC9t?=
 =?utf-8?B?dXg5TGJhM2dmSHlXbVVmcjMrcmVOVlNua0IyZ2x2TTQvaGoxQ0JFSzlrRGg5?=
 =?utf-8?B?THJvbGZmWW1YWHhVN0NoSXYwZ3VaY01YZ0ZUZkJuUFdySGZ1djVTMmM0c1h2?=
 =?utf-8?B?d1p4dFdsOU1ybEJpWUJSQk5HRGY1QWlraTk3QVlucHVEbWtKRVRuTWRORmRF?=
 =?utf-8?B?RVg1RDFXVmZGSFFMNDQwY2NsdERkSXVlbHN4bFF6MmlGOHFOT1MyMmova1ZJ?=
 =?utf-8?B?am1BcUZYaENkQkZvcDB1c21QWEZRcjdyM1l0VVNhWVNzcHZ2bVZjSHBtUWdm?=
 =?utf-8?B?Y2kySCtSQjdkUWxjTEVFNEtvWmZGZmFpdXRldGhzQVJXaG5uUXl2b1BsNlM1?=
 =?utf-8?B?MW5mc3RLOTBJeVkyNFZDMWJ4dXpBdUtZNXFRbno0eDdXM1FZaDlhRlNaZUlo?=
 =?utf-8?B?L0hHb20waUNDdG1JRmorcEQwRU5KRFpEemU2aVdhZmJvMzlCR2kxSWNxclI3?=
 =?utf-8?B?djA4VDFXUHZqQk1GUEVJK1NVa0tQL1J5TlJQbFkzajBQOXRFSXhGK2ZCV0FB?=
 =?utf-8?B?b0dEYUcxU29veTVUMTVURHl6eVJFa1hReVZaaU5MNmpmREN0Yi9oTmhTc21v?=
 =?utf-8?B?TTVKaTJoc01mU2ZiUXRqV3NwckwzaDFRM1pndExQS2RrUDkzNFpGamxjZ3Ax?=
 =?utf-8?B?UndSSnptMURsUzNSY1h2ZGwwenFVdDZyTi9IWEJzZFBSbVUzMlJyUVdCN3RU?=
 =?utf-8?B?eEU4czBhZVlpaytGcnVabklMWk1FTzdkNHVsK2dVd0JXcDdHWU40aWRsWHB4?=
 =?utf-8?B?Q1Q0UjhpZDlTdnR1Ymc0dWNDWlFQMXF6SVFXUE9ySVRRNnlGUnM4a3dFaXJJ?=
 =?utf-8?B?OXkwdWN5RXRWMTJtVmI1REorbTFIZ05PTXNIaVhuQkFIY0lwVS90WUFRdDM1?=
 =?utf-8?B?Z3JzN3hUVTVOc1NYWlZwVHlxeU8wSDJxdVJVMUlhdUNtVHhTWFZ0V09BZjBw?=
 =?utf-8?B?bm1seEF2aHF1VHNZTXZGenk4aVdCUVBGQkt0dTJIT0pGajREbVVXcGExRUpB?=
 =?utf-8?B?eldLSkpPV2tldHkyazFMSFpKMG5HeThWUlJLTHZ2NXlidktYRldyODhHMlFV?=
 =?utf-8?B?eVRVdUZ3NkxuWWZpLy94aGErMXQ0blhldWlVZ2NuVWVtUG4waFVpbG9nQ0li?=
 =?utf-8?B?ei9mdmZ3a09XVGNoNEFhdFdRRm9QYUhaOGh2TURuVXE3aUFIcTdaa04xMU9S?=
 =?utf-8?B?VDJEUU9hb2EreEhBWkh1ZGtpK0xscTVERmtjd1BrSGVyZldpVmpUbTQxRE1i?=
 =?utf-8?B?VTZuemZJVHJ4OVp3NFVlNzdZeWFtdVJqYzMrZVlrRGlIN0F5WXNtNFZ3ZVRQ?=
 =?utf-8?B?Zlh3WlRlK2Vtb1VQdTRkMzdWTG8ybHYwSmJzMTNoT2JRSlpuRksrZDM3Y0or?=
 =?utf-8?B?SFBIaW8vR1RCYzlsY3JtTVh4ODU5TSsrY2FnNFJyaTRtK3Rkd0U0d2ViTWhi?=
 =?utf-8?B?Q05TdzczOXNDc0lPY2F5ZTBKMGhuczF5enFpRDJLS2dCY1l1TFVYSlFXOGNa?=
 =?utf-8?B?Q3JjVTVveU1aU1hTL2owYWE0a0RNTE5pUzd1ZjhjcXdrTFNoTUxHaEEwMk11?=
 =?utf-8?B?cCtBTldCY2IzT2U4eUlMelordTltS3pRKzBMVEdYZCtFVmVqL2ZKbnVZRC92?=
 =?utf-8?B?U3ZPWm93S0x2UUVXeHZkSFBGNUdFMk9JYzJIem5IREljbjh2OUJTUFdaakpM?=
 =?utf-8?B?VDAwNHcvOHV1blpYcFU3VU1NK3UrRlJsZndSdFFzQ2tsUnQzeEVlRW1VZXRF?=
 =?utf-8?B?cWE3QkJNVVlqVEdOSVZWQjlWYUs1ZFRSdWcrUFR1ZW9Sbzc2TlBWemp3L3d0?=
 =?utf-8?B?cFBtZ2NTVERLSGMrYVJoRVZLUHhlbHoveWlIWGJncndNTWhBc3M1VTQrNFda?=
 =?utf-8?B?WmVjVGtkU1JkL25nTG9wN29weWtQL05TQkJjZnZEZnlpSUovZHM3c1RzT1pj?=
 =?utf-8?B?ei9QK2tXS0N2V0VHdXE1cERFb3BiYWNyMC9QQ1IyRC9UbnkwZ2ZpczVPTis1?=
 =?utf-8?Q?fr82sROUKm9O7Av8HXQTLovgG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pGp1ICWC65J25xrMy8Ogygp86IesYYUhFEvQ7/LfwZ4Mbh/n9qeZ4+S0Kha/k0V0CmPLZ4w3nWJf+guwLarPhmKMgiowm6Xa3CdDEg2jJrhjBbKQpi38GnVsgUN9DqBvDNl/WrHXmqjjy+AREAP1yLCwjxtlSMl/iCyd9c0zUcinyHmqvLx6xkMQLpiOAPvnnq8FrA4+uq/Cj43WDo/6m25WBjjqC7x6sybczXqZG34uXz05inbQK6KJ78M3nAW8gt8zdt8nWJkte+dcJSHgooBaM4gmxKrA/ia05YjfTiH1w+IxUdqIEDYBuNvG8gcH7Vsh/D+/8lwKkDsdUnOs0SpUBonME3g1WOSUD1MmyCoA8sFkpXoytzNcOxIGnF9KokISVG7BfTSAefE4DqQklAiLq41rV66Kvzpr6dvs9lRdfYcjfh4LUXBBNxIyUT/6P/lTf0RXIqlVNjx1wVTak93+w47yM3MMi5koSVZ59f1RTOP4kS2JwPaEJggx4z/WngGcqcRzTJX28SG1ifgoqH9+lAbSH+6pcxbIQoW3ATesCRXqVprAJxpVnEmPjEwJaT55EMFu+eW0lF4mmHJbdOp0FbSWyYkX1vGRtWL38/o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7e38ea-5541-4427-f78d-08ddc53b1122
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 14:06:03.9995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9H1fHZAN0xdhk+SPv6hxpsBT4xbyTKoh+FJkZ2B/PLzMX66dK9Q9CsXHaPearv+fZ8qNFJIkDjVgONueD3Bq4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7380
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170124
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=68790352 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=BrpYuzCUiOYkZT3XY5wA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: Eu63XM35GtBi5rDZhi3_eDjKLAjdclKr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMyBTYWx0ZWRfX3pEXSs4oHFla J6t57SwL+YMGug9Cxho6EglwO3J8eI5NIVvXBR31uQKcKnPGiSI9vTnbOvYA+xwnyG4SdqOUti5 4q/8K2HZcL5AOdMMqO3+G26BF8w/PmMrl/3NmHH0rhs5m784ReZ0BqRqQRVQO+bO9fVWPq1FsNC
 sxX4kzUkO7+JMO6gCjJolbLQkyp022OUiQ2UXWrfvgCyLv+W22zipt+5P1Djj7ccuWStlXA9pAG 3yrJjrWClk7smAPE4hmt6Ou5c7sV8W2VphfL/xFk12EtIKrIticRibRguJa2pXRR4P8/TIGh19x Qw4kAR/7nWuSaOA0e95XYDFuewmQwPaACwnZct0gD75AtA+Muzk9hATRI6OWHzHZO7xAR2toEbV
 Wv4Slaqza4Ah4y0U9zfuFxiPrPdn/iYUOJcE39i0JjT64tGVIELU8vUdBJhD2vIwdH4TD27y
X-Proofpoint-GUID: Eu63XM35GtBi5rDZhi3_eDjKLAjdclKr

On 17/07/2025 14:52, Ojaswin Mujoo wrote:
> On Thu, Jul 17, 2025 at 02:00:18PM +0100, John Garry wrote:
>> On 12/07/2025 15:12, Ojaswin Mujoo wrote:
>>> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
>>>
>>> This adds atomic write test using fio based on it's crc check verifier.
>>> fio adds a crc for each data block. If the underlying device supports atomic
>>> write then it is guaranteed that we will never have a mix data from two
>>> threads writing on the same physical block.
>>
>> I think that you should mention that 2-phase approach.
> 
> Sure I can add a comment and update the commit message with this.
> 
>>
>> Is there something which ensures that we have fio which supports RWF_ATOMIC?
>> fio for some time supported the "atomic" cmdline param, but did not do
>> anything until recently
> 
> We do have _require_fio which ensures the options passed are supported
> by the current fio. If you are saying some versions of fio have --atomic
> valid but dont do an RWF_ATOMIC then I'm not really sure if that can be
> caught though.

Can you check the fio version?

> 
>>
>>>
>>> Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>> ---
>>>    tests/generic/1226     | 101 +++++++++++++++++++++++++++++++++++++++++
>>>    tests/generic/1226.out |   2 +
>>
>> Was this tested with xfs?
> 
> Yes, I've tested with XFS with software fallback as well. Also, tested
> xfs while keeping io size as 16kb so we stress the hw paths too.

so is that requirement implemented with the 
_require_scratch_write_atomic check?

> Both
> seem to be passing as expected.
>>



