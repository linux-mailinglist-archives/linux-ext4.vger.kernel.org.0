Return-Path: <linux-ext4+bounces-9793-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FD5B408B0
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 17:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4005117D25B
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7FC31B126;
	Tue,  2 Sep 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RpwKRImo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WXd5ioWh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8F31DD91;
	Tue,  2 Sep 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826109; cv=fail; b=hs3Z/eiwmapWD/8JxuF7N7xToMo77GnkJFqhVxzy3Y0TiS2fevZ7xeY09MxR0Vu3Q5UdI1AM0HsVzYHvGSIhFWs45yQmyioMk59ESwMBXUJCVU3mEV4tWx6XOkrgbqKSxIRTeXv/4poqMmdiDbdf5lAqKEMzM4RWGD7tQ/Fy7+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826109; c=relaxed/simple;
	bh=WalV/lYYxBs/u3cK2FqGtp9RlKxb/2dMk7K8qG4jdeI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fJ0EpIFv38JE89sGloVrFDhJ6EMoDBK4rMPAL4YgOxuB3LHydwjk+6hV8SMzQmDKtUSdMrF7xSYlsu/ogbzPWNbx4EpdNimJHQE7rmGYiLRosuM2apC4T/eujKTvDUF9eiKVTX8EoqWc1lLfaV8hINZKSpf7Is/VxR6A2czIsTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RpwKRImo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WXd5ioWh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582DfpBE028592;
	Tue, 2 Sep 2025 15:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BPjO598yDfajrGYNjVxxO0Bv2V2j+uC6Rcj8djhtDzY=; b=
	RpwKRImowWBKk+mBjVgHqxpwXEsUpDG9eo7H2S4PqoE8NzMnVnLKGc/l1uQOcgY5
	rTrareEgbIkxC+cO6lWhxn2ikseNylBGhXtanfpkTXNSoEieGvWGqTflbxdb5hyu
	iCrJjVoR+qgc49JtV+/pfXs75hIdRuAiJluF3TINwskaMREpvVp1Ru+5zzOragkb
	uyLB5slz3mI6VXqagiL2CW/c7cXTLSrBYVW6iqVJciSVIXeD24NkxC3OS1u9WZGo
	2lqkn0FgnrjzwHQEz8doNxLqkKIrNknwu+26n3FwD9Dh1KvJQRELQ2l4FsSn3FIQ
	s7v5WtH/T/4dOipjLbNIZA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmncaa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:14:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582Ex48L015837;
	Tue, 2 Sep 2025 15:14:55 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01ngkhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 15:14:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/wa12iau7uBWXUik9drVhpHownDUOGWsmmeVq9KdAmBfPuQL2SiPmSs6lKiPamk0bJhQqbMATWGfCi9OS8i3wSP+Q2nkriStpNy81ijC2NteFfHrQ+07TJzdWHM8QmV89O1NrPkPGOlyYx3yhlbWYg8djX+AHYJpYdGtYEqSmfIdUWOimX3x0I3XlDFlv9VSWCHXEmlAO6S/0UEfRWgYbghcDfvH+14LNRQoMFl6ObGoYbKeTjGIEqj3BKNezIYtm8OVXeSmY9mv0H42eK0dMQTlzeGpmyZ38eX2Fv4iETuXIBNWQiTCq+m96VFlHIwcVwaehk6dZI4KibAU4eZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPjO598yDfajrGYNjVxxO0Bv2V2j+uC6Rcj8djhtDzY=;
 b=kZCBxI9aUaFAIUmgQkJic1YcUbfkkd5Fqns4bXlEtFoacJypictdLGKEfiwwsoaczflmTdwao5PQ7eRM3IjbnoKcqrcZqVh6vfZiofLdIXsppdQJHgLoSeAhdevbW3Y/pA0Eg6IqvZo3Vl521qm5xJ9CnDv/7xT322W3yzPgNfKn+3x1Eejt1eiw6ZkrmpXoKIRiTQKleNPXVeTp5mJDDQhvhczJw6YFP7bwIv4pZr8WKSCHToyMWbCVeRRufQhOAABmXoDQrTr3ejsprMOI5yxg778FD+cftQcJ0OytWYwnLIbjgeBb4W3dZXbKGkyTtajWYFt4IUlL2Wic7MOjtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPjO598yDfajrGYNjVxxO0Bv2V2j+uC6Rcj8djhtDzY=;
 b=WXd5ioWhTu52yY2nKpDoC0mPbS3wd/rgw4VEXHdCGjQRNd+uGpQQpRRt49U+qF1ILHqS3NGeIIHI+8CwPhP9HC7xGnq5NX6qrzBftB74/nIpo6eeVzsIEaEnKumJIGlgvb2w+Hup1U70o9ImHuZsFmp2+NAeM/NNbmCvYTWAB7k=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH0PR10MB7533.namprd10.prod.outlook.com (2603:10b6:610:183::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 15:14:50 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:14:50 +0000
Message-ID: <842675da-1927-47a6-a612-4cc9eb8db8c0@oracle.com>
Date: Tue, 2 Sep 2025 16:14:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/12] generic: Add atomic write multi-fsblock
 O_[D]SYNC tests
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org, tytso@mit.edu,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <55583acdfb6cb69bcea84a56cbc20754e1d2f4f4.1755849134.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <55583acdfb6cb69bcea84a56cbc20754e1d2f4f4.1755849134.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::15) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH0PR10MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee94220-3b09-41cc-8a6c-08ddea3375d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2ljR1NIa1UrVTUrMXBqR1J1QTVxNFJhaTgxQnJhSGZhUWRmc1p2VVhDb280?=
 =?utf-8?B?U01EaXVNNy82VWRsdG9mZUFGR0FCakFCYVk2OVlhc0tvUXVKOEhDNmVEU3Bu?=
 =?utf-8?B?OXlzWjMzWUk0RFdnTG9MSWFXTFZjT2F1Sk44WWhMbzA3RHNGaWEvN2s1aWZB?=
 =?utf-8?B?c29jSjZBd2l0anM2K3ZWL2puR0VkaEkvZGxrZlNtMEowN21PM0ozL3JTdVpZ?=
 =?utf-8?B?THVCVDF0UHRoK0RvdGR0WTZFams1d2h2R3p0alE2aTdod2pLamlaT3RLaFEz?=
 =?utf-8?B?K3dPdDdzRDdYamp1VFljRHBOZE91SnBZT21zUkhvZ0xicXdscldnSjYwYTYz?=
 =?utf-8?B?ZnNFaGIvU2g2NEdUaUxrZlF4TzhiQmt6UHNMaHd4c3B6akZ4QkxaeFdnQ3dx?=
 =?utf-8?B?UUxLL3ExUEduaGFvZGFWNjVvNGY3YVFmVTNjVEc2c2RJMHQxcWNTczdOT0hw?=
 =?utf-8?B?UStnaGg2Q05XVURWK3BBU3FpS1h3L28veEVCMFhucXBjMjNGVWVGUWdyaC9x?=
 =?utf-8?B?SFFPK3FDMnBtUXVYUXZ1MVBYMFU1TEU3UC8wb20yaXZFOEFsS0tncXhXQUpp?=
 =?utf-8?B?UU05QXNxMzhPTVRPb2psS1RTUm9NVmhaaUhDYXMrZ1k5YWxobmt1UzlBbVVt?=
 =?utf-8?B?R2JtVkoxZHZjYUdMakxqTmExaWFMUVVmSzZWZnJXb1NWWkp4bGFjalp1WWdB?=
 =?utf-8?B?YlBuRmtDcVljZGNHUHNqdVVmV25ZWndza0d2NGl2eDkxcmNUMXhBQnNJRVZh?=
 =?utf-8?B?ZGt5bnhpLzE3VFhNZUZndkxhN0JPZlpTanFBNHRZS25wbnYwTzZaOWI1NWFm?=
 =?utf-8?B?eUMwNjBHbE52anlmVWVCeTczclZqUzBYQmN4Tk1yT3RzZHNLR2QxZFBoMzcv?=
 =?utf-8?B?aUw0Z1dLeWJ5ZGRQL29GM0l3eFVRVlMxK3BCTzJ3QnA0dUVZS3crTk1XOXY0?=
 =?utf-8?B?KzNocHVsT0Nqb2NibUhWSElwbTFWSjVYOFc5cnlVOEFMVlVQZWtRYjN4Z3dk?=
 =?utf-8?B?YnA0MTk0Z1V1WWxqa2w5cVpnWDd2dHJwTlpaanlFTDJpdUUvRWRpa2llV25B?=
 =?utf-8?B?T3VNMDZid3F6bmF0cDJNZmVhYVA3WXJheFBodFFrL2w1a1R1M1ZrZHhuTHFZ?=
 =?utf-8?B?NFFRejBwa1F2Z0tDQXhiUWlZNFJRSWVYZEZlRlYrN2hBYWFMVzVTc2NTbE1N?=
 =?utf-8?B?OEVMMUtKZWlhZXpPcTlTRzJWM2ZNUWVRNnpRVHRhbEg3bFljcDFDZ0Nxa04v?=
 =?utf-8?B?SFJlMXhuWU8yZG9wOThPV1lKUTBaMVdtWUNheDByd3VjUmMxbjAxNjJvSDNa?=
 =?utf-8?B?dnZhdXZZNlhyc0tPeHc1eFZjSmxkaWRNS1gvM21hK2hIUC9EYnVhaUtMOFV6?=
 =?utf-8?B?MXBuM0h5blNGeDJxeGFiS29lZkpMbHgrQ1JxaC9iRGFUSlZuSmZ3Ym9oTCtp?=
 =?utf-8?B?ekF1TlNmN3hLMnVZUFAzbTN3UnlhYlRBUHpZeXV6cHBwMHZnTFAwZE5SM2hJ?=
 =?utf-8?B?cVc2RnhvMnFnaENTNXYrdHNLYmdEQk9Xb01IMnB5ZTBGS3RqcHRhYWNrQVlG?=
 =?utf-8?B?bmJXN0tWL1JFTm1NK2lzRFVPMUVaenZtbzVyUDFkdWkwTmRmLyt1LytwbFBJ?=
 =?utf-8?B?U2NFL0UxWU1FTWhlU2hublp2N3hoMTZJS1JMMjQ2Ykw3VEJDM0ZoZDB5OE94?=
 =?utf-8?B?T2NRaVd6YlBKZmduMGdoMmc0QWg2SUpOaSsxaHhwSlkydzM2TFozUlRHcG9L?=
 =?utf-8?B?QXY5MFpKR1cvZDBaUmdBcHh5OGxtZVNSZ1dFWmdEVys1LysvaloxL1IyM21K?=
 =?utf-8?B?SU03WWc0UUw5a05lazJMVVRqRG9uMG1GWjNlSkNrdnVMc3J1K3pFZDRoTGVM?=
 =?utf-8?B?Tk9pRjl6aDJtalNWbkg5bHh2R3ZEOHA2d2lDNit1Q1F3N0tuUGsvSVo4Ulk3?=
 =?utf-8?Q?+GM//qVsyzg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHE4bFV5Z0wvaFI3RnZjRnR0eElFaFZJeVVKZE9PSHFpYVoxeUZ2NGhIQ1Ba?=
 =?utf-8?B?c2x0OFdPY3FEZUlaaTQwUHNRbXhtak9IVHJCcVJ5akVlbFRpQTh6ZXlkV2sz?=
 =?utf-8?B?aUJVS1lHNHVIZEQwRURPUlR1QktBTDJJUTZreW1DNnNPM1RBVlExY3B1cEhj?=
 =?utf-8?B?Q0lPSUZQb29FaFg3M01iKy8zdkc5Q0NrNU9SVzJPdDJ3REE3Vnlndm05cGJp?=
 =?utf-8?B?UnpyTXREOFJ2Y1Y5NjFpTVhYYTc1MVlYSFBnQkJuNDdsdGhlY2FRRVpRS1pH?=
 =?utf-8?B?cWtsMTZJVDlLYkR0UzVudVJjei96WXFlYnhXTEFkd3BxcFFzcFBxbFZ4N3Fo?=
 =?utf-8?B?TnRQYVViclQ0Y05LanBMMmRTNyt2UTgwQkR5WTY3VDZWSVFkN2E5clNIQ0x5?=
 =?utf-8?B?eUNnVDdJTmIzbXA1eWZkYUpjKzRqZUFKQUp1R2JCV3VwdEdwSmg3bjgwOGVo?=
 =?utf-8?B?ekMrUEx0d2JKQ0V5NXdBVlh1QUtsVUJyMnZjeFkwSW14MlNxWjhKamh2SEZ3?=
 =?utf-8?B?Y1RtOXZRK25MTjBwNzVZMWN4TmZ1WWxIQkQ2VllMM2JmZ0xYbjJUMTVmdU1H?=
 =?utf-8?B?WE5hVUJJY2t5UUFzZFl5YmgwckFxRVd2dHQwTVFoOW91b3RPSlpKSC9jU2cx?=
 =?utf-8?B?WTB0RjNKb08vTVo5N2F1QTRrSU9ENDF5VzQzcy9UVnlsbkdqTnU1aTdqY1Nk?=
 =?utf-8?B?Wjl1U3dZTmhheHBab1VER0hydkZ2V2txOWpWazBhKythalgzWHgrdzR2QUdF?=
 =?utf-8?B?U3R4cmQ3YW44bmdWemg4UG1UOXU0RUJMMjlDZ2sxVjMyNE9tMEdlQUk3bTBx?=
 =?utf-8?B?RWxJbVFGM3hsZTMzTDZlQzN6RXBhd1ZJdi93K2lBSUFNWkFVeXpzNmVtV1lx?=
 =?utf-8?B?UW1mQXNtTnc1NzJQK2J2L1JjLzQvOUdZZElENTJCdDV1OHJPMi9FUWgrMFZJ?=
 =?utf-8?B?UHVVNS95YjFOU2Q2QVJGQWI0dXQ0S3JTVklMMVJYVUN4OHJ1eVl5ZVk5dm5v?=
 =?utf-8?B?ZVBXbFowTFZsTGFCSmlGY0FuMmJkdk5UVi93TTdDb1hqMDl5aUhhNGsycmRT?=
 =?utf-8?B?OWRGQXRwSTYwVkR3aVhUd3BaNGU3NXhCUkdJSm9qRjVPaGNnZ2ZQZEZra1RH?=
 =?utf-8?B?cHlyNUdFVytleVVHQmZqVGpaWU1Gak9PTEMvOEVkZTVJcTY0Y001WUVCWlhF?=
 =?utf-8?B?Y2d2VDBoU0YwTGQrZ2xWTGVXMVRiZ0FacGxrYnRJNEFLY0tBbEc3OWtNZmw4?=
 =?utf-8?B?azJ1d3VTV0Y3Mm1JZU1zMFM1dElzYlYyNVhaOVZxTms4U3lic2l4REQxQkpB?=
 =?utf-8?B?amp1OFRaL2FlMUdoSWk3UDBUbU11Vk5JL0pGeCttVWphSnpyZ1VtRmxwVjVp?=
 =?utf-8?B?d3dIVUZwamhXaFBCMHUxR205MDZISFRIRDV1ekY2aURxaDIxM3lWbE1Uakp2?=
 =?utf-8?B?Zk1xRmxCZnJlQ2treWExenRBWUtjb25yOVg3bVljcktYa1Z5L09jV3NMUnZ2?=
 =?utf-8?B?ZHV5QzQrWE5VK0h3N1pPYmx3a2E0M0NRWkdhOWFxaTBmUmRkalNEczA1S3BI?=
 =?utf-8?B?WVJNYVFCOGRQNVhsK2MzUU1Va0FzTDNUOXl2Umx0QS9ZYXhKazB0QWk0Mm1j?=
 =?utf-8?B?QWl5ZEtya3R3QUZYSVpvTmhVNTQ0c1F5Q2hRenNvcHMvb2pNMnBpbjhmRWpY?=
 =?utf-8?B?Z2FRVzRXVXIrVnZmWlI3U3VNbkFlZll1N1VVWU9OWE9YemhpcmpsYkRKZ0tO?=
 =?utf-8?B?cS9qNXBwampZZDZ5eC84K1VKOVRuZy9GMmVLNGdPK2w0ZjQwRUF4MDRlKzJh?=
 =?utf-8?B?WmVYK1E4dDBBNitvdjFsMWNvc2swK3JDUGdzR2JDVEFudlpjN2xNRkd6T1ZB?=
 =?utf-8?B?c25WV0w2YktkVzBsRU5EQWFxcDkwdUluVnZFQjdqejRmRXArWFM2UXBabFhW?=
 =?utf-8?B?cVI0TDY4bExoSEgwTGpqcWc2cVR0R0R1WjJFQkdRRG41VnNyaDVuOVE3dlhv?=
 =?utf-8?B?YjcrLzNSSWkrYW5pSTZiSml4U0k2NDlYeS9EUmZRUC8vOWtGNUtXNG80K3Vv?=
 =?utf-8?B?ZVpJaHptc1hMbGhHbFJrR3RsMVRGWVFLNzdFRVBnWXVXZmtuQUU0RTBGUzNV?=
 =?utf-8?B?QmZIcCtWZkZZckMzQVorRTI5VXVPa1ovRDVWS2dUKytaRmtON0V6cHB0SFl2?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wz1pTLM7eua8h5VNhhROoexJ6Ye6ca14AzQZXuo4XJjtYiZpBr3MUnQ5iug5gyVlKYOEGru+xQO4XF/BZqOMZc/3CK9J2zAK3qjqtiSURz3PrA+SbKcKG403KXKLhty40//qQQm/p6Aap4N8aVsVQLwgBIG29vz91BpTR2n4n3KFhxhOx9bueapYLQ+HlNupwn9PWx3ENo7joy34vEf2mFsBHOW0o7wxBB+IezWlzSIp8lbxxr6i8yhKMJql3KU2WkHHsb7zTvnXXDJZZze60WgOjhtAnIxgyTKb2G48IuTJKjnSIx3sP+TTXw7RjXcWZE/b7CJYtbBiSEDBFKtyLYIwffdnlfzCbCeUwEAHZYJUTRn6j/soN0Ta7q9HQ1Mda95ZVnq68hmJwJPsW8bXdj8C+p0rqGmCBZd96wMYUS94KLmzhgoILE3SZ3/XJR0lKs6pDs1qH3NvBtMxdAMtdk2XWKbVCR4mSYDq6KhG7F8XgSVlX9+inYngPRSFGO6gpGL8DPmhAVo7kJF5BTPzbzjRhgwo0Ldcp9RjZx2EpEKHmtdGPOHlwu8JQNC5qQ85IeOob8a7r5XSdMP7/se4mtKtnKNGD4W+T3yMVfSmeQE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee94220-3b09-41cc-8a6c-08ddea3375d7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:14:50.1863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClFgwcGi2B37PGDtJMqTrt/SEANVjCX4PMXsqkh2mSBkmKnvmmP6YXyCMpkWWUMOu5GG0GJugMH2JKtaML+ddQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020150
X-Authority-Analysis: v=2.4 cv=D8xHKuRj c=1 sm=1 tr=0 ts=68b709f0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=yoYfiFYitY3L4tHIhxsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: aZH6pN1_43DrPQmeryqZLAWMvSRQ0fYH
X-Proofpoint-ORIG-GUID: aZH6pN1_43DrPQmeryqZLAWMvSRQ0fYH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX7Epkf1N+3XcK
 4EyUX/B2He/x4vlSMpv0x+PguceIG7r+G6fjHD5SXN37d73JZkfpkNB4rQ4nEhX++sbIkeh8M2V
 l24vPdIfPr5Qu7Y95tzsht3GW9r2uCE/24sFO+AAPWhxJjHMK5Orv4g1Cvr8RtFNISF8uXO2Swf
 kY54dQhMVlJSO+qkHrVoKEI3ue+/YABJS4jIrksFRyUrAEPXl+WuSQv/NgRcA+piR0OhuH5sKZR
 mWW5S+E8XVmyEd2IqALJAvRNaW7XRJX3wxJUGUgRjQvyBRPHQZeS2tADK2YgLT6UXVie18Su7RL
 O6kxL+Js63KqZlWDYBRkPQgzwVLlfhHkqa8DalsEvx9ou1IEYm5VJxOy0Ib6hq3dAZN220ethX+
 ApQAZ1I/

On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> This adds various atomic write multi-fsblock stresst tests

stress

> with mixed mappings and O_SYNC, to ensure the data and metadata
> is atomically persisted even if there is a shutdown.
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regardless of any comments made (which are minor):

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   tests/generic/1228     | 137 +++++++++++++++++++++++++++++++++++++++++
>   tests/generic/1228.out |   2 +
>   2 files changed, 139 insertions(+)
>   create mode 100755 tests/generic/1228
>   create mode 100644 tests/generic/1228.out
> 
> diff --git a/tests/generic/1228 b/tests/generic/1228
> new file mode 100755
> index 00000000..888599ce
> --- /dev/null
> +++ b/tests/generic/1228
> @@ -0,0 +1,137 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 1228
> +#
> +# Atomic write multi-fsblock data integrity tests with mixed mappings
> +# and O_SYNC
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +_begin_fstest auto quick rw atomicwrites
> +
> +_require_scratch_write_atomic_multi_fsblock
> +_require_atomic_write_test_commands
> +_require_scratch_shutdown
> +_require_xfs_io_command "truncate"
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +check_data_integrity() {
> +	actual=$(_hexdump $testfile)
> +	if [[ "$expected" != "$actual" ]]
> +	then
> +		echo "Integrity check failed"
> +		echo "Integrity check failed" >> $seqres.full
> +		echo "# Expected file contents:" >> $seqres.full
> +		echo "$expected" >> $seqres.full
> +		echo "# Actual file contents:" >> $seqres.full
> +		echo "$actual" >> $seqres.full
> +
> +		_fail "Data integrity check failed. The atomic write was torn."
> +	fi
> +}
> +
> +prep_mixed_mapping() {
> +	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
> +	local off=0
> +	local mapping=""
> +
> +	local operations=("W" "H" "U")
> +	local num_blocks=$((awu_max / blksz))
> +	for ((i=0; i<num_blocks; i++)); do
> +		local index=$((RANDOM % ${#operations[@]}))
> +		local map="${operations[$index]}"
> +		local mapping="${mapping}${map}"
> +
> +		case "$map" in
> +			"W")
> +				$XFS_IO_PROG -dc "pwrite -S 0x61 -b $blksz $off $blksz" $testfile > /dev/null
> +				;;
> +			"H")
> +				# No operation needed for hole
> +				;;
> +			"U")
> +				$XFS_IO_PROG -c "falloc $off $blksz" $testfile >> /dev/null
> +				;;
> +		esac
> +		off=$((off + blksz))
> +	done
> +
> +	echo "+ + Mixed mapping prep done. Full mapping pattern: $mapping" >> $seqres.full
> +
> +	sync $testfile
> +}
> +
> +verify_atomic_write() {
> +	test $bytes_written -eq $awu_max || _fail "atomic write len=$awu_max assertion failed"
> +	check_data_integrity
> +}
> +
> +mixed_mapping_test() {
> +	prep_mixed_mapping
> +
> +	echo -"+ + Performing O_DSYNC atomic write from 0 to $awu_max" >> $seqres.full
> +	if [[ "$1" == "shutdown" ]]
> +	then
> +		bytes_written=$($XFS_IO_PROG -x -dc \
> +				"pwrite -DA -V1 -b $awu_max 0 $awu_max" \
> +				-c "shutdown" $testfile | grep wrote | \
> +				awk -F'[/ ]' '{print $2}')
> +		_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed"
> +	else
> +		bytes_written=$($XFS_IO_PROG -dc \
> +				"pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
> +				grep wrote | awk -F'[/ ]' '{print $2}')
> +	fi
> +
> +	verify_atomic_write
> +}
> +
> +testfile=$SCRATCH_MNT/testfile
> +touch $testfile
> +
> +awu_max=$(_get_atomic_write_unit_max $testfile)
> +blksz=$(_get_block_size $SCRATCH_MNT)
> +
> +# Create an expected pattern to compare with
> +$XFS_IO_PROG -tc "pwrite -b $awu_max 0 $awu_max" $testfile >> $seqres.full
> +expected=$(_hexdump $testfile)
> +echo "# Expected file contents:" >> $seqres.full
> +echo "$expected" >> $seqres.full
> +echo >> $seqres.full
> +
> +echo "# Test 1: Do O_DSYNC atomic write on random mixed mapping:" >> $seqres.full
> +echo >> $seqres.full
> +for ((iteration=1; iteration<=10; iteration++)); do
> +	echo "=== Mixed Mapping Test Iteration $iteration ===" >> $seqres.full
> +
> +	echo "+ Testing without shutdown..." >> $seqres.full
> +	mixed_mapping_test
> +	echo "Passed!" >> $seqres.full
> +
> +	echo "+ Testing with sudden shutdown..." >> $seqres.full
> +	mixed_mapping_test "shutdown"
> +	echo "Passed!" >> $seqres.full
> +
> +	echo "Iteration $iteration completed: OK" >> $seqres.full
> +	echo >> $seqres.full
> +done
> +echo "# Test 1: Do O_SYNC atomic write on random mixed mapping (10 iterations): OK" >> $seqres.full

big nit: you should keep the loop count in a global variable


> +
> +
> +echo >> $seqres.full
> +echo "# Test 2: Do extending O_SYNC atomic writes: " >> $seqres.full
> +bytes_written=$($XFS_IO_PROG -x -dstc "pwrite -A -V1 -b $awu_max 0 $awu_max" \
> +		-c "shutdown" $testfile | grep wrote | awk -F'[/ ]' '{print $2}')
> +_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed"
> +verify_atomic_write
> +echo "# Test 2: Do extending O_SYNC atomic writes: OK" >> $seqres.full
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> +
> diff --git a/tests/generic/1228.out b/tests/generic/1228.out
> new file mode 100644
> index 00000000..1baffa91
> --- /dev/null
> +++ b/tests/generic/1228.out
> @@ -0,0 +1,2 @@
> +QA output created by 1228
> +Silence is golden


