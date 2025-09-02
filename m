Return-Path: <linux-ext4+bounces-9792-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E47B40899
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 17:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABA316AE9D
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08975314B6C;
	Tue,  2 Sep 2025 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bhs4RCkc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nmhFFcLf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D0A313E04;
	Tue,  2 Sep 2025 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825846; cv=fail; b=eVdpDdrFXjxi6nbM9x3vnNlPth5ijW2f6DyIGADeTzx5SH18OIYgZ0GoeEd+qack+vjsv7/wccW53XgkZG/xXyJCpmX8i8Wy0VWzQcReJeILm+gE+daGP+wvmZigB0tzY8EUegvtdO1kBn8Q9aN13yFaraK2fOaHC2bTqzUkwk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825846; c=relaxed/simple;
	bh=9drGXn5jMJVes594Vdy8SLPJ5RODks4Zav/D7RhgLY4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z0wqxTho11DbQsyhNA3o9D4VGiRw2soVYJqjyWmkUvuXOlzWrDeAlpmXhU37aO/WE0PykyDk01UZ0iiAH2Xn2EtCjK6LObkhJ24nZS3gqPh1EvymJtscfdtkBmeprJYCDCFXBd5izDxOI4e0459Q1FfwynIsF/WFEoqTW3fkpyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bhs4RCkc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nmhFFcLf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582DfwIb022472;
	Tue, 2 Sep 2025 15:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AmFMRT83ra00SAEyeAz8ETeAuXufuFBK8tgN1LHXQ5w=; b=
	bhs4RCkcVMr3zAUyb1unLJFbNnlDUhuEPUO+Grq0XdkRHvHN/HE31Zzm6IVLHA+k
	kwPMPfz8ktGE3SmqDBvZTwAiKZAgunjBIXw99p28puNXJRgGw7usCRq0x8O+Rx9m
	tzyN79/VvwY/NBHVp3Y1pL+61/Sg0eo7ZIsX5Tqb8aCv2LlBx4gbtEKkcuLh6Gkl
	VVp5YNDkuYK0FllRB0qq9zTX0lmX0ACI2kjmZjX7gAZIXXnAYzC8kdm/HvP+wZaL
	Of0+FICVIVK7e2bpXDAK5d4FewnsAkDF0Lg65HaJXfB6y7WvDAwT78q6FTxqTd7R
	2U7BVQ5lxljDAec3MT4c9Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmbc96d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:10:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582Eutkc036207;
	Tue, 2 Sep 2025 15:10:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr97t48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:10:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqKpKub6p+ozcGQ8ckWCYdPqk12EORjSqQrUOEAQ655v/wHxAizEkRtZpmFWzBbAsRn2381eBDj1Cagn8buyd5lgFAVM6pkN4DUox33wAl/wr/AgAv+QC2Nwq4KQn1VutwLkBKT3XgM0Bk63vTpqT17yMkg8yxjkSbow8I2h1TPsCit9UdafHEoAJqd3zabI2z6wSc14BF/Jbd72BQ9ftl0e47EfCWt9GltdANkwfEXB4iJCwS/emvfieHE6b5T1zoKcvaTIPFhPglXLtVrO/BZge/7svQZwjeEM9IuiagziwbQqS+YWPjO7NENX0CAqPGYjEu1/gs93jnUtwr3/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmFMRT83ra00SAEyeAz8ETeAuXufuFBK8tgN1LHXQ5w=;
 b=ppzmMP2PTV5Z/r4AgDtzwvqJ+GCF7g8CGK6IUU5RKD2/fZzl/RZKfKCpG20R/eqZ/pnchopqa0haNRbY5nlT/haJcTHxC+CugtyhOJcJ2DXPoOsgfXsSHvGK19ejF+bFtOw1b+UXjQqs8o8b9Wrt4GWPcwHkbYCvJ9OzGVbEOEdfyIyyWEVODTJ3ba9vsnakGTx0iV39rTarRt8ULkZ7wwv3AeDdHhdppiTT7BmZfMnwoPC90CbKzrPYccr3MW0eXGJ8vf/5p9xqcKnO+KrIPt6U+38co8kJKslLs3MQSG0FI7o/Vj9UldMfbB3XgrCn/GS6Wn3eeBlOtKbhmO0tOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmFMRT83ra00SAEyeAz8ETeAuXufuFBK8tgN1LHXQ5w=;
 b=nmhFFcLfnxOAmtgTNLhoJbn6bd9RRekyjXA5lh4qQ85B2LZwq20hTMs9o5bFs9vC6kHWZz0JROnfqY399bsbO4bKsKx6zfSmmZ54DQUW2H66DRzyLRhFMmU9+2OCD/8Wr1GquV727USVgpmyTgWR0mOHoNvVDFft3NvWBl2Zq/o=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SA6PR10MB8159.namprd10.prod.outlook.com (2603:10b6:806:43d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 2 Sep
 2025 15:10:32 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:10:32 +0000
Message-ID: <321f5de3-fbdf-4590-818f-9a88009746dd@oracle.com>
Date: Tue, 2 Sep 2025 16:10:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] generic: Add atomic write test using fio verify
 on file mixed mappings
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <7c508d4ecfa8ff1be5c031d1675e0b378c581028.1755849134.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <7c508d4ecfa8ff1be5c031d1675e0b378c581028.1755849134.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SA6PR10MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a10955-4eb7-4dc2-0f7d-08ddea32dbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1hQRTJ0TUJGWXhEVkhuek54ZVBQUWsxODRKZEs4NVo5RitpQmFlbG4xVFNK?=
 =?utf-8?B?dm55Q1dmQkZVYmI2dDBraXZOUEtQdEFjQUI4c0liR014RTJWaEJWc3JwMzB4?=
 =?utf-8?B?UmRtODZnTVZOcG5KYTdOcVZwZlVNODloZmhQa2YvajRpRmFrYWhaY1J6NmZi?=
 =?utf-8?B?akpOSmU0QXU2RzF4RWNiNWxBK1dITnY3U2RiamlXeGVFdkhWeHNVTHlvSWd0?=
 =?utf-8?B?YU13blJQZjVsbWdsZXMxWFFFbTZodFVEUlZId0RBN2NDY3NITEo5REc1WDFC?=
 =?utf-8?B?RGtxVVE0andBMFNHUU5LNWUxb3hkdEFSUDhWaUFOenNFeDNFQ0MvVFQ2VkJI?=
 =?utf-8?B?dTFielp5Wlo3WTU0ZmttK0Q5T1E2YmVpOEhRYnh0THhWajFXWUN0R3lrNFl1?=
 =?utf-8?B?YnpPbkFMMkNyMXk5V2x5emJKQkxaWHM1b0c4cUVpZG9rQnk4V2RUWTdTUVRp?=
 =?utf-8?B?bjBFRW9qZDVpanpvVi9uR3VTSWhVMVpQTHN3TXdkblB6aVphVEYxY2lkM2JY?=
 =?utf-8?B?ZGpVVUo0SWRvL2VrNy9oSG93K0h4NEV3V0ZZMkRKMXk5WHBpbHg5cjhhdEFx?=
 =?utf-8?B?aUdZVFpIWlh5QXNRamtWR2taL3o5OURzTVNYYXc5OUhDcm42bkxoamJ4WXAw?=
 =?utf-8?B?ZzdpZm9uNk9jUTh3T3dSNzJyMU50Rzd6eGxibW1MWFRScldtTEE3VzF6R2Yx?=
 =?utf-8?B?enUvaGlTQ2R6c0ZkZFFsT2duQm5QL0pNTG4rUGJzRXI4d2RROWpjamdPWU82?=
 =?utf-8?B?ekxaVytaN2ExSUdlak9JRUxTUEk2VEJhMnJkREx1YkNxbWRMdnRGWWFwNVp2?=
 =?utf-8?B?ZDJyM1BKYytzNzFoQmFLWmE1ZUxpTFdXUWNmbDlTYTBOa0RZYm12aTllRnlw?=
 =?utf-8?B?SlFxYTE4dk9hQjlqSTdnS1M0aFZ4bzdGTnVJa2RrdUxiQ3BjTzJCTDRmY3RH?=
 =?utf-8?B?NnUwbU4xZEFQSmF6V2hIa2ZvZ3lUWUZSbzBsd2pjbUYvYTlMVlpvVnhMV1Br?=
 =?utf-8?B?NWJ2NjhqMlhpSGloWWYrSFV1T0JvcHZBMHNCYUkrUjRoT1RITmRWOVhsdGVU?=
 =?utf-8?B?Y3RsVDQ2ZHVUaG9TUXhaU2dId0ZIbHlaNHNGV25ERm1EbXNQVVp5NXNZVHRM?=
 =?utf-8?B?S0tGN0N0TTIrRmlZdVZLbU1lL3l4dGFXRWFDTHRjMW5OclFzME5nOGV4NFVZ?=
 =?utf-8?B?eWFaY2VyUmFQTnQ3UXY0Z3B1c25CRkJVWVZiaXZncENaalNHcTZzN1B4dGE4?=
 =?utf-8?B?RUtXWnFXeFBvMDg0a3llZGEvR21iMHNOS0J1Ty8wdERFWW5Ra1haZmhQeHA1?=
 =?utf-8?B?QVVYNUdGUS9iNjVnenBnT3ZLUzNIajlURjlTdWx6MDNUd1ZZbW1tUW9ZTkpr?=
 =?utf-8?B?R2d4REw1b2N6V1V3bzZpaWwrbUMxd29aV1FEalAvS0VKbkhYdTNyNG5iSm0w?=
 =?utf-8?B?QXdWSEd4ZmE0Wjc0OHgzNEhEK2YvQjdSZ0lHY2VRWjBZRGRjWVY0UGErQzFW?=
 =?utf-8?B?a3Uxa1E4L2g3RHJrRWNqeExrVnVQREVqaTk2ayt0YnJmWFFNbHNJNGw3alJx?=
 =?utf-8?B?azdTUnNjTElES2VFb2RxNzY3K3R0OHliOWdobTZXWGEzUUdvanpyMVpQVkg3?=
 =?utf-8?B?MlhGZFVPSzIwSFBZQXhZY0ZIazhjNG8xU0ZrTnQzSkpDOXN0aEpuc0x1T0Fq?=
 =?utf-8?B?a053WVJqVnhSQzlCSFM1NG1hdnQrRDlNektwMURqZHY5R1BXWitjRlllTjZQ?=
 =?utf-8?B?UDZsdmd4QUloc2NYSkxEZVZqQVJlNXZkMXJYQXFFWXRvR0FmYU5KL2dvKzlR?=
 =?utf-8?B?cU54czVpNTk3dEFPRGNKTW14NkhJNU5FRzkwRUtENWJkUkJBZjVNYVdHYTVJ?=
 =?utf-8?B?bGJIVmVBRXB5enVWNjcwb00xT1EvNGg0dVRYNWoxd0s1MjBlOWZUZVVnckM5?=
 =?utf-8?Q?WJ/6T/VwHDs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFhEK2haOVBoM0kwbGVHODRxWWhCTC9hZkdxMWtYWDkxWHYxVnFVbkloVS9U?=
 =?utf-8?B?NTJoZjNaeDZJVVpXRWNOVXRwZ2ZsdnRmNVBITTg4UzZUaTcrVm9FS1J0OWFK?=
 =?utf-8?B?bUhMMnRTZmZXRE5NNlVVVlJpY2wvWTJOMVJ1UVVUSzMvWlpSeEs3K0V1Q2ht?=
 =?utf-8?B?T0xDSVlrWGVnZk1iTXE5WkdkYlBpQ3dYaGZ4L051TUtrQU1JUmQyWXNvbzFz?=
 =?utf-8?B?NnArM0hSZUFNN2RORDhYYXhtM3l4U1VmdUVINkhTaU1CQjViSnhMalpNRXpj?=
 =?utf-8?B?VkpmOFVGWTBjaVlFdDE5dnFwamtIZkxkTlZwZmQyd3hmelJsekxjUzBiSCtv?=
 =?utf-8?B?d0RYbG52VmZRT1ZHSVo0ZXFmZjdLK0l2ZExUS1l4VWZLV3BBNG9DSWpHeWk3?=
 =?utf-8?B?Z0hoNE1RSGdoSHdlZktlUnlQNWRZV0IxRDlNSzRSTFFQemVTL090WXZWMWRR?=
 =?utf-8?B?NWxQMFZPRXRmdGI2eFN0QUFaeGgxMzJDZUZ2K3hkZkZDRnlHbVRBeTlXd3dr?=
 =?utf-8?B?MlFsVmRLWHBUZHdpSHN4NkNqNzJkeVhBMWtPaFpMbFAyVnplZWxDbTFKMENR?=
 =?utf-8?B?TjhNbkFQbk9GVForZU5XMEtQemtpNmVYeStoT3hoY1dlM2dJRGkzNTYvSjVH?=
 =?utf-8?B?NU1TZmxFM0ZIUHVocjJKZnFsL09YdlRnWndSNy9waE5uQ0xwejlRYVpEdVhk?=
 =?utf-8?B?b29VckJub3REd2habUJQc3RIYTkwN1dIalNtMk9TS0dNcm5Xa1pvNTVzTjhq?=
 =?utf-8?B?T1BncTJqZC9FMXVKemloM0lLOEdsRGJaZm5zOHhaVmtCcTdLLzhFdFJETTI5?=
 =?utf-8?B?ZzlWOGZ0UTlydHN1WUhJSXZTMThpb1lnZmRKQzVOYlFjZXNFYTFCK1M5NWVn?=
 =?utf-8?B?cFhhVDhOMTBhR2FuaUJVV1BPOEpFVzQvNURqMUJnUTZWaXB1VXk1V0NscFRE?=
 =?utf-8?B?SG5ReGVLeGw1T0JsMlBBanhoU2xrY1Zhd1VQUHNLL3hyS0FrV1RWNmNJV1Ri?=
 =?utf-8?B?aHF2NGlkeW9BZXJJUkUrRGpvR3RXVGdENXRpVnEzTko3QS82b1RMN2xQZzd5?=
 =?utf-8?B?WnVsVkQ3U3EzYjcvTUl2eDRzWjdmVGVWUlo1eldmbkl6RHhCR09ac25Cc2Mw?=
 =?utf-8?B?aXZnSG1neWdraWtCMWFMT3U2T0FjWm1yakJYWGNSVE42cFMzWFlIS011dFp6?=
 =?utf-8?B?cE9yRVNNTEQ0VlgrSnlKREFlK0xxR0lLSk53dWhPa2RSOHR3cU1rM29ZRHB2?=
 =?utf-8?B?c05KQ3lVa1VaZk90eHZMOTZEdU9XbWptaG9HUDJnZ0NXTEpXdE44eHAwYjZO?=
 =?utf-8?B?SG41REtxeVcyT3pSTE92ZjZ2VWZMbWNONnhjVUVDa1hOSkxpZGgzbmpRRTdY?=
 =?utf-8?B?R2gxUWQrcnlKTkZYcGVucThnR1ZoZGw2Wmhlc0pNczQ3SHkxNHd1T0lOdkor?=
 =?utf-8?B?aWQxUG1jZnJ3T3RJS2p0WXl6Q0Y0OTVZK1ZtZDl2MlV6WEd1bGR4Wk85b3VR?=
 =?utf-8?B?VlpoN3V3SDRuMnVaOGdhS2hmMmdRVTVJdFRvTGE3eFRTUDdibXllVmJleXht?=
 =?utf-8?B?SFRQdHhQZlZhNm9XUzRlMTVNc0Z1R3RFOWJhTkROVklVQXptOE5jWThMdkpE?=
 =?utf-8?B?ZGRmcldkR0lSek9vbUR3WDVjanl3VkFqZzdFZldsN3BRa1EwOUI1MDlhUDZW?=
 =?utf-8?B?ejltQTlOR1ZvK0VBSEprNE82TWxnd2dXYXNZaFAwVWxsYU9BT2RYTUpNSWxh?=
 =?utf-8?B?dVgzSk11MnlwblczaFpWTjQ0Y1JkVXQ5ZDRUbDRnOEF6ODRicGE2UFl1cTJU?=
 =?utf-8?B?cHEvRm00TXk3QUsvMmJqVVdqQzVma2UwUnJiVzFBY3M2UFRNQlVKUTVoMWFB?=
 =?utf-8?B?ZTBtYjdjN2ZoTmIxR1o3di9yZnZ4SmFLVVV0dGM2aVpJT2lzV1Yzb3lQZ3Np?=
 =?utf-8?B?YjhtcDRlUlZyVXByUUNIQTlsVFNqWUlBSU1XTlA5cThkbkRscDJjMktWTXRU?=
 =?utf-8?B?Vnhrb0Z3MmR4VWd1VEtQM1dWblB0NnhYeldnZm5tcjBpVzFlZysxUjBsYTNB?=
 =?utf-8?B?RWplcC83cjRzNi9wazMzdTEwRGtjbDdWV3lRUndjc1I5Tzd0ekpxS3Y5cTRh?=
 =?utf-8?B?dWxIUTZUUHViVEMrckxSRndXdU9aWENxN2VFckcrNllJNjk1WTJJMkNPVHdr?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K+MtmknFTw33FQSB1KKx7j0+bGPO/Vmk1LEY5jg6C3xU/l3qGTJYXU0lodVRwmyT1GqoPkVlAamfbjPhtcNRdHEMMwPBIG3E3uQcPMdFiVZjV/z11drx5zED8os4C7slfe1K31LsNZ0YrBQXsxU2BphPTUcV52ayazPezs5SYpXduQT3vbMngJ+7XUKwiTfkVhqYX/gg6P5px0yFeOAJhIFBa42KiL/BNs/8o0HEoQTCbaxny9TosMowAFRrFa+KerOUXsqRcXQil3PnndNY2BoOuPbSCjoNgtcV5bU+uiA2maAIPzvtnAuzBWjZ0oRC3EiF6OdNmMzgtv4ERjztUWKssBcCRIuRur0XAARQGEfWEYrPWX9Zl1USAQsq4eb50rQZdZ2s+fsjDadnLxniQrx1GlxnZJjCv3lhaZsoU2CCzJnuavdfZskweSLN45ankwJW/Na2YZIb3BhKs80Ycate0u9AcN/qVU/gPdeJkwedXvIbjXwbgSMqsa13adxIlvoZhdzECdF6PrXvojp2Wcp3yevK4mxM0sgKE+MtieMsUvwd6ti47vt4ZEtah+SQt7WD8HuWVpNrcP6J/4MFgEDbQxgvVnLlvAod7Ty16/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a10955-4eb7-4dc2-0f7d-08ddea32dbd2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:10:31.9282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTpsI3wqbcS2dJZrk74+lGsbbTdTVnnaVRZY9ekatVstMN0oOgylsAkRCYAZS6bG7i/DrKiUrloGLjc3cQuBdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020150
X-Proofpoint-ORIG-GUID: _zAdYQmUP7nFlh4JawmM5k5kBZ1cOW7i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXwC/Ji9hqtgj0
 e/JILPrVY0V8osij4OeX5BDpkRCbnVauql5v49eeABWwKUkGxlBikvL5AkHEe/0pqJtJVqS9vmi
 6ozPRz07OHBbMWY0X8sgq2NE/0bVl/k2SWqj44VXmEVBjQxjMrCPifZ60mKuvb86DFMdlIrqOEW
 U3WthD1LlOXz0W6Igp6o3IicmYkgBHvYcx9qFVvFvLoytQeipFKkFd6aeULw7k2g2HYOxoLo3Jd
 9jQf9YFmpEZasBh+Umi8APpsP0cXURKvhDdVDB2BMlc3mSBtElCbsV5sb1e8cvvxtxzuCN0px3u
 MCMvz0p70suHklQexjWH5rb7WUsyx+ZH+IE03CSJjxUSaGDPqHPbSKSLiS6Y8cDIyCfiCEOdWAT
 cHiM4Q/m
X-Authority-Analysis: v=2.4 cv=KORaDEFo c=1 sm=1 tr=0 ts=68b708eb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=02ceCqPSNGhYbtkhk0oA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: _zAdYQmUP7nFlh4JawmM5k5kBZ1cOW7i

On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> This test uses fio to first create a file with mixed mappings. Then it
> does atomic writes using aio dio with parallel jobs to the same file
> with mixed mappings. Finally, we perform a fio verify step to ensure
> there is no data corruption or torn write.
> 
> The aim is to stress the FS block allocation and extent handling logic
> to ensure it handles mixed mappings with RWF_ATOMIC correctly without
> tearing or losing data.
> 
> Avoid doing overlapping parallel atomic writes because it might give
> unexpected results. Use offset_increment=, size= fio options to achieve
> this behavior.
> 
> Co-developed-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM)<ritesh.list@gmail.com>
> Reviewed-by: Darrick J. Wong<djwong@kernel.org>
> Signed-off-by: Ojaswin Mujoo<ojaswin@linux.ibm.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

