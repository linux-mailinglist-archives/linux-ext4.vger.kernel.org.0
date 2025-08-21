Return-Path: <linux-ext4+bounces-9493-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DE8B2F3FC
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 11:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CC5566EFC
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6C42EF66E;
	Thu, 21 Aug 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mj+zSffQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VLOXLii+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125D6221FBE;
	Thu, 21 Aug 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768555; cv=fail; b=HlYlkqOICHxkp7HiZp/7LxLcMVyUK+pAkk9ZPdWO3g0As3XkKE9EPJz2m9WdvXa3DMbj+9ipi9nBfmGQmS+0MIBvbWsuE8sML6e623xGSi8zIYiVlHZu6ZJc6tZLfresUknwXB4HTMxco3yqg5XLbHxoh1RFcLEu5VAhZ1ScrGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768555; c=relaxed/simple;
	bh=xpet9CeMl5fJ/W/Sn/J784Rm0ZtNHYh6ph5nljWrxz8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p9dmf8x3SkSFEF+LtM5aOY6urILxRUYkePWWNfXQUXdzkyWQfNoe3Ls44BnaANrG39QwnLmoNCP4yWsOE1DmbwKgtm2S/TYShWOx9Qw1ljUD81XAElRIyCHqGGTqry5h625REPvBi2Wu8IZeasCOOpOIeO6u2z7wXcVsG8aF+Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mj+zSffQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VLOXLii+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9GTi2032147;
	Thu, 21 Aug 2025 09:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KTLy3PZCdChyhsGZMdolQo6SghwNb4Tvlba9VdyVBmU=; b=
	mj+zSffQ1sydv+hOgAMdYU/LxBx/iFo91AfuQ2Yr719LCoPmORaEFVusDespPabU
	EOHIqA3zq2CcIf51jp7VbtkTYHKZQRS+WSSomcxC2sJnto5YGRgqawBWBgUnwgk9
	sSYt17+oh7o3CwtwageWHX8E6wUzWStHLVkeTZUwsGMIWKiyGJ9kH0P9ejz6zmMZ
	YHpm0p6Yl3SrEKKzgPR0fDiFyt8zobkBFuJmZ4r8sygKpL3X2aPHYmp3MyRf/eiA
	c0+7TNx22/CTsQhJEMvp/pHRke3RWK2AhFymGfPROfJkZMlBBzAhQ3vUeXOj68k3
	4hAcMNYabQtMADkRRdvxHQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tr32w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 09:29:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57L8iPux007246;
	Thu, 21 Aug 2025 09:29:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3rvcj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 09:29:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJGUxFLKcF9wY4Bm+jRM8wkveFygCpElQ7sCXoIYMQ84j5DM+qTPT2UJzJc/7Ofdmm0TBPYl8CpiyBg/IDHX22TIbpLFvx4fVqD46JrCb6iXGAPvmTH/XXO6Jz1RlURdTjdt+HhC/UzWQ7WiQCZCJd10krQY1EnB3sXK2pH1/lcGRPhJDesIfFvYtFw71+7AnBjjO+8uLsp24zhC+Cz+3CS0jJNEcX6kRajjo4Y2BbLTIWBKda1B1qZWEJwQsIbhz8tnowmodT7FjsROwVPVFnY5msHQMVQqAzcl415nlv8q0qV8ZAOTh/LGmlJm+Lw9tXvw6ukAWpUGNwy/HcbviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTLy3PZCdChyhsGZMdolQo6SghwNb4Tvlba9VdyVBmU=;
 b=j94uc4MUuOGmtj2k5SqxzbWgbNiOuR8LH7HTMxYMkZfGQHFaw/sqIAhcpGs2bcdPElYbeMZyCSPPZFJa1c9bsLxZNJdZ9U3cuhxZJyzAd/frZjgKSa4mo9GhP90IuHDWMlvanXmPYPWeYjoJk5aSKBYNcrKQuRvubNPI7spM1z7YpdaLWYrIeJNFMNMneG0OFl9dO5wV9Dumfi8oT7jhCpDe53osiK+rGy1hkIKBIOW7X+gHmLZKKP5TCmDVQ67HKHLDYhNRdn7zGr0StdwotxkcJ1UNED2p2m01wcwqKtIMd18oZiKhLPuu2jYZIxvISxL0CEtIoBGXFJeVom3wNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTLy3PZCdChyhsGZMdolQo6SghwNb4Tvlba9VdyVBmU=;
 b=VLOXLii+f1du8MOSCUOLRdAZa+YazG6SGD4vNVs3i/AkclORwJ1YhdYd4HVxydhlRz14wDjh9NYVzZ6jrI8gFsdZ6mxFaK2VwL5xkyesw3NTVzLzIYj8rtx8HhDjyX4w1Ll2DVWY1Nc/snA5NIKqBsjQHcIB6o1DNUISSWWwU54=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DM4PR10MB5965.namprd10.prod.outlook.com (2603:10b6:8:a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 09:29:00 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 09:29:00 +0000
Message-ID: <8b39d392-0a10-47fd-ac3c-b73a1e341e86@oracle.com>
Date: Thu, 21 Aug 2025 10:28:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/11] ext4: Atomic writes test for bigalloc using fio
 crc verifier on multiple files
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <48873bdce79f491b8b8948680afe041831af08cd.1754833177.git.ojaswin@linux.ibm.com>
 <7c4824a6-8922-470d-915c-e783a4e0e9cc@oracle.com>
 <aKbYvubsS8xUG88d@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aKbYvubsS8xUG88d@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::15) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DM4PR10MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: fa039a98-4e6a-42ad-4506-08dde09528d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEdqVVJzZmdKdXNBUXBTNXFKaFluRGlPZ3VnMmxqOTJUZVFRVFJ6SmhaL1Bn?=
 =?utf-8?B?RVlpRW1BNDF3M3RDVFVBMGpqMzFmbXN6WFV0bzdkai8ySkJvSkxTamVJR3hJ?=
 =?utf-8?B?UkcyTHFIRWphMFdmNDdOaXh0S0JTTXQ5VWFuRGgycHpJMlJaS0Jwd3dZTG82?=
 =?utf-8?B?bjkrWnQxcDNoSk9QcmIyU2JlNnpteXdOZG9saWhCQ05yeHNLNmVPRjRzM3o3?=
 =?utf-8?B?MWxsQmVVY0dNTlJsMmtHZ3BERmw2d3NWbEkreGJJeCt3U0VXZERFQ0hsMEVv?=
 =?utf-8?B?ZmtodURpb2I0aHRqMTRTUXdzLy9rWFE5SDNPb1RhdzhGVUgxTjR1ZXQ5SlBj?=
 =?utf-8?B?Z1o4c0NWZGNqc09ObWlPTVdmU3gvcUhhV2IyQzVBQitjK2M3aUVFTnpzblpl?=
 =?utf-8?B?bDJXbGpOd1pjV0JtcVp5TW5rL1hHWHFmVzJ6YkV6NEpCVWt0RzB4QnE1UWN0?=
 =?utf-8?B?S0ZVTFFsazA3cGZCK1ZxMWpacHZrUHgzMnA5VDRaZWR2TXMzQmMzZ21yNVRm?=
 =?utf-8?B?VnA0ZjRmSUMyeTlpUEtEc09yaVd2bVVHMFdhc2t0a0hoT2t0K0JSNUt1ZlpN?=
 =?utf-8?B?NzAyVldMUEViRjBZdjNBdG5TejZjSmNZVHd6b1RDUDVpbnlyNzFpWWtPZjgw?=
 =?utf-8?B?UnQ4NEpXdHZFTk5TazFFU1FXMjNnZ1IzWGhqZ3V2a0ttczMxVEFVUGxmVDV2?=
 =?utf-8?B?czIyYityZ0VNc0tHSWZLcDZLQ1owUS9mVTdCTmk2WFFxbDBFekE3ejZrRFdr?=
 =?utf-8?B?QkZuWjRKTERxZ2oyaGZKb01OR0F2RndTdHh4cGs2dE8zQWFPSG1MMkdGMFhS?=
 =?utf-8?B?YjVQOXZWSkc2Yi84dThUVW9UQ0lnajNjQ2N1amwyaGVlbER2Z3U3cFBqcjlK?=
 =?utf-8?B?ZE82UlhEMElXN3UvelR5cldPVExiWXZUTExKS29BbjJWN1BBc2R5NnFnTWZM?=
 =?utf-8?B?KzdQalE0THcwMzVLbDltSkdPejhwNlhOZy8zaWplRkx5ZUNNYVV5OHRXT2JQ?=
 =?utf-8?B?Q3VSNEJoTCtaeTNSZzdqN25USmNiWmU0cGNubXo5NCtHaWlMdjA5NEZTNWFS?=
 =?utf-8?B?RWxhbnNXcHEwVVlqYWJ5R2lXaFpRMEpoRW9NRUVqM0tyY1NFRU1icDRRcTdt?=
 =?utf-8?B?YUtHL2dZWWVFaG9JQ2tUSjIzQVNlZ0ltclhkUHlYYkkweWVNcVhWRllZbkNV?=
 =?utf-8?B?UnBLZjVRbkFuYkMzUUdqRkt0NnFxaHE3VXJmaG03R2VRSWFrekkxQ05wSlZ4?=
 =?utf-8?B?L1o1NFJ4VCtNdjI5Zko5MjdCajU5RHpzVmc4djkwM1pQSVFUaXF0RjhwOWRn?=
 =?utf-8?B?T3hBanViekJaMnFleVZ6NE44dGJpOW1kdTdjVG83R2pEZTBWS2NVRExCS2Fl?=
 =?utf-8?B?TC9nNUxUQ0FBZG0zWkNXRUovR1Bha1VTMkhDdFVBNjg2TkN3bUxHUE9tSDZB?=
 =?utf-8?B?NEk1cW43U1FkV1RsNDNZMEZJdzJtUERGM2pFZzJ3L1M1S2dvQjc0ekFnVkhL?=
 =?utf-8?B?d0M5bzBINkYzNXZsQ0FyNFFhcmt6VERVYVVCVVpKQVErd1QxY29Jbi8rM1d4?=
 =?utf-8?B?aERYQ09tVTIwVjlwb2hKRkZQL0VEYVd5QmNtQUxYSk95b0Yrejk1OGVMT21r?=
 =?utf-8?B?Uy9XWGdvcVVDNEt6bXNBMkRDTm5CVXZiVnpYMTdyNGlOMFljelRIbEtQQlJH?=
 =?utf-8?B?YjVJUFJPb3VkWHRzamcwWG05R2lnMkpvRE1oUjZXMENvLzZ3bWd2aUhrZGtk?=
 =?utf-8?B?TjYxbnRnUlNFQ0FMME9EK3pmNEVrMGVoQzZoTSttOWRtaFNkZjllMzZaZE5z?=
 =?utf-8?B?bEN6bFk1T25EMlArZ3dyZ2t3dkp2QmtHeGJueGJtMDlWMW11NTdnandia3ND?=
 =?utf-8?B?My92Z1E1NCtmK2pPMWRXT1pkUWtQVFRkK0JGYk5pVFFGdU5RMWVVQmxjMFdH?=
 =?utf-8?Q?XTGLD4Ey2tg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU5jbjhBaUtXYUdiMUllVk1kZzFQSXhwSnpubTh6R1hVUG1ZLzN4SXQ1VEUv?=
 =?utf-8?B?QnZaMDFXcmZGdlF1cnZReHBPUEIrN0JzWnlVeHc5Unl5S0p3KzU0aWV0aW1T?=
 =?utf-8?B?Tkk2aE00MGMrUmN2KytSb2lqUGxKOEFoYktFLzl4dWU4cm4wbFVSUTFlQUJM?=
 =?utf-8?B?TklBamNFQWQ3aC90Ti9FbERGRVpubTlXK281WS9FSVRBOXZ5OHBtdkNqZmxt?=
 =?utf-8?B?VzFGS3QvcldDYlZXMWlKMENCNnFzeC9HM28rcGsvTVdEbUR6dEpCVTZKVUJX?=
 =?utf-8?B?Q0VQeEJZRnlNejVxMWpWVlhiaU00RG1kNU9DR3lUb01xTUx3eEJtMWpUbGNZ?=
 =?utf-8?B?VlpiN1NkbEtlWjNMbEUxVzdQUVNabXdMNFp5Mko5WENRRjZTOWhpRkRhcklG?=
 =?utf-8?B?ZUYvWUZUS3NZTHMyWUZjckZXM0RUQmc4L2xDVTFRMXdpSHZRRnhHK0hrNWJr?=
 =?utf-8?B?YktWMldrbkh0cTg2bnBKazhWTVduZ2xkd0R3MkVsUEphTFlWOUtSMzdaVno5?=
 =?utf-8?B?TDdoMlhvdkd5SXQ4Qkp2dzZuL2ZFSzIrbDBXdVBFakFHeWRaUkpnRTJJaVYy?=
 =?utf-8?B?NTNPRWNnQVVGblNmYkRrTTVUeFhncEc1RTRBWkpnMVphZUxvY0Rxei95VU0x?=
 =?utf-8?B?WnlWaENrTklBZUJmM3VOSFRMQm14Wnp3aytNemF3bDltelRjb1pCelNKdHl3?=
 =?utf-8?B?clJGbE9OQjNpNnZLcnY4R0hyNmtPUUpvL2xSVTNsS21mSFlQMVdYeEF1N0VD?=
 =?utf-8?B?eHYwS1l1RnpUYy9RWXhxVUlQUWRXeUkyNHBtdG4rUDduQThXQ3ZwUnA1WVpB?=
 =?utf-8?B?VllXR3JyRCtUcWtzR0ROMFpxaXc3Rk4wOG83R3JVT1BEa3hOTXFkaGV4QXFB?=
 =?utf-8?B?azJvWnczVkJBbmZUNzR0WC94U2hibFh4OFA4RzVmakpjbmh1SkhKQ0pSR0Q0?=
 =?utf-8?B?Q1VhZkJ3ZlBscVRHR2Z0dGF0MHhST0JjV3hCYVNQRXVaMFBtTStabnBxTGY4?=
 =?utf-8?B?ZnBPa0EwME9mblVrY2ZKTDBxaUFKaEFXM2gwcFlZNDlnWjNVZXF3cU1nZlFl?=
 =?utf-8?B?S3JNQXZiZ216bEpwSi9WNGViMCtsdUtLaW0zeGtiQkdybEc2TzZMeSs4aVRS?=
 =?utf-8?B?bDJTR3VNKyt2ekM4c0NUZnk0NTRmK09FNDJXOHUyZDc5ZDh3L2VnTVVuakI5?=
 =?utf-8?B?cllEblVGTUN2OEZnOHQwQ2ZYelpocGZGMDBaUFZaWE1kTXVwY1JVSjhmSkNC?=
 =?utf-8?B?M0Y3ejVUZElnOUxMVGh5QUtSSVN0UDRiZ1hQR2RVQXpLOTBrc00vbVhENGpN?=
 =?utf-8?B?a1ZMSEhTOGY0NU55dWVRZEFOMEpPaHVOcE9nSFJBOU5CUHJMajdFdjlCSnlE?=
 =?utf-8?B?cjVZQi9tY3JxSFhaVHNUOEhVWGZBL0d4TFdMWXl0c29mYnlyZ05HTnpGaHJv?=
 =?utf-8?B?dERUU1lLM2RMSS9nVmJhcW5MeFhMdFFvYitQTUFUQkN6RkRRLzd6RGgxdnl0?=
 =?utf-8?B?cHFRWnIvUUJUTDQwOWZ5QVdVL2xpNnFNK0VVQzNGQUNKeGt2YVpJc0o0OWNx?=
 =?utf-8?B?TC9YKy9pemU3Mm5yZDJ1WFR1aG9SQmdLUE5HUzMzSHlLWHNHY2NQSWRwc3lV?=
 =?utf-8?B?RmFBKyt5WElMb05oZ3BycDArZGp0RXhOb2hlaUl3TWlSSGc4M1JMVU85RHha?=
 =?utf-8?B?akY2Nm1jY1orSm83eVZyRjdQMVdCOVZ5Q2NqMU05M1o5TExZdk1yV0p1VmNQ?=
 =?utf-8?B?bXc5SWhtaFlsQmhJeFQ0Rzk1NHhLTUtxTDhvRHUrOFJJcDBaYzZvcE5TemNI?=
 =?utf-8?B?aWNHZ29LVHM2ZVNIWkxqRlIwMzAya2hZSjZSZkhqT3RlOHh6cUl0RGJNajJ2?=
 =?utf-8?B?RlZlQkp3N3MvcjE2OUdwOUpMVVl1U3g2TWdIUkQzRThNVDUramNnRXowYklO?=
 =?utf-8?B?RkVTeEFQQXBhVmV1ZTcrWVB3ZzNpSld1elNhV3Y3eE43aEhwVjVsSWg4NktJ?=
 =?utf-8?B?MEYwRkRKeG1pN3BFdTFCWDVKMnY4b0t1cm1xZXNpeEJjM0R6Y2dlaWlxSTdi?=
 =?utf-8?B?MEJrdHFFVEJaOHRKcEpyaHcva05vMDFtSXd3RzczQWE4ZldJeXpLd21nWk42?=
 =?utf-8?B?dEhUM2luYTk4Rmk2YUNLcG9JSGdpeVJpM2NxTGNKTVUxZi9nMHRSTWVrOG83?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CiUYf/hdWhReSY1HLMtTxO56j0vh3zz/IbUiDGNyEVd3Erl2UxY+oWghUy+sRDIU09xXn24vWX43qeywqdL0Q2tUK5fHrpjBGRDKekejToSOBb3neF8tb1CGISRmrmHoxhDu1eVEsNRTItxKgcsDJFZ/2vo9iO+B9LKuPBWpSJDHiYM6ibFGx1iLZyjgPxM1iB4eorLC3jNpPphgG8ng05Ij72yOheOAzMZqWo36B1PGjTX35LxlLrSJNCFrs05GQGWNveEcMHiB4wSC9C4TKfsVdYxqtWmrJeQ/WGSnKdLte4v3AJnhzgQ9dwowQ16J6JFRZxmnVUI0v80re8yMh86DuAgP9T6eQvAC51dW5RLp7+8ajOEk+wlHtf4ju0QIUALVTgs23dArMuyaspbtX/QAcv2aTDo9r+kVp6bG8gBZIO3Pqb9DXH84C+REzNkAlTGo2J2aPrnt7Ma/1mS8O7EyxB4jxxnsVmSEfrsuM662+ANOB78T5TQJww+ZNs6B0cTL75hD7AKqXKtEQy28mJdek99x36eMwgufn92g/O1VclgC0k3keatbvfMQLWgrw8IoQP1uh6lWYkn/PVFqUkvqrtv0i/YYqOduNMHYbwE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa039a98-4e6a-42ad-4506-08dde09528d9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 09:29:00.0415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2B3pthl3aX+CRykE5VKz8LBX9WfshrLPTBphNx1tGWCIIDONC0KP++5DAtWBz4QWg5Fw3eN7TpJbT/WsXZCHsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5965
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=871
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210074
X-Proofpoint-GUID: asOfbSEXua97icOZtMCAi2uUaxHoELlg
X-Authority-Analysis: v=2.4 cv=FY1uBJ+6 c=1 sm=1 tr=0 ts=68a6e6df cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=i-KcieYvAL8oQoyEmZsA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: asOfbSEXua97icOZtMCAi2uUaxHoELlg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXxyz3VBLYycxT
 g3oKCA+3c0GlmmQujopCa0F2ASGCVTJev41C8iKXT6IzcoeBmOFb+LGgKhSnL9J2BTcdwdMGmpd
 ePEVKy4JR0SI6aBFhucZuZ4/72ZpWabFoP0mnE7zlQrbxKITfe0TdhMHwjAH9EGZLpndZ/wBfiY
 gzU9z2/FWmSxGFSQ9dYL5V+XZ/RNpLiPvrEh8UYQ0KcxYXocjHIDXWkBwCzY/dHU44q6Srxm1xL
 kHF8W8sDaC7Q+GgKDel797WklECkG5uFGespoyLrGZFFBn7/cgwtFYolHOg8pL1QV/i7rJ090cT
 t42BZMv7UsuoXhOoux7bmwgg2EACexfmm4ttEn1dxwKgM0xjQ0PZ2O5OsWxz5CEnzg/vnbl13ku
 HkFiyun7LuSKx0CoQXhm+ZvW8WLWrQ==

On 21/08/2025 09:28, Ojaswin Mujoo wrote:
> Yes these 2 tests are similar however 061 uses fallocate=native +
> _scratch_mkfs_ext4 to test whether atomic writes on preallocated file
> via multiple threads works correctly.
> 
> The 062 uses fallocate=truncate + _scratch_mkfs_sized 360MB +
> 'multiple jobs each writing to a different file' to ensure we are
> extensively stressing the allocation logic in low space scenarios.

I see, please at least fully document this in the commit messages.

Thanks

