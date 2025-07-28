Return-Path: <linux-ext4+bounces-9205-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17443B13C9B
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jul 2025 16:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46B716DDD8
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jul 2025 14:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C594E272E75;
	Mon, 28 Jul 2025 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="loA9JERW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mhYG35Wr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657426F469;
	Mon, 28 Jul 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711276; cv=fail; b=KndDS3w6rLFAAVBS4J+WIVtq7jn4oFCltaXBPxUZ72KS3jjIrPZnS0iFuiS8SKtpVd03YeiK63rIPEpGiLtNBdei1MtTSEjyLxOeq1X3d43Xs22SqRt5etGdA/vNerRQQT3InE0+ocvxmOuGu7zA9hXIOsgP+U+R+5/cBZL5vqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711276; c=relaxed/simple;
	bh=BnEY5/jAxwNIElTGuxNeuRA/ffr8ybpHUeDJQYfRUI0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TymIUNzRIEjy3w6Vn+k+kTEK4EOdZhbdr6OBIF/NTe7NtrMSCK4+7siNvndjdF1MzL9j7U1HIE9HOqIj1K1zcsGILSks2vViqNUw7Om8nb3tCqrN4c7XxJPw4D+M5Wd+4lEhJlhaHKKzFfDRIZ2TSMFVnuJUw6ywDN+0QN5hUVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=loA9JERW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mhYG35Wr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SDC93k029777;
	Mon, 28 Jul 2025 14:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=q/X767Wo5EfNcID8a6SuOKdSLRnSx9aPs8JWmolzSKc=; b=
	loA9JERWlXiNVAxn8JhN3BR4kCKhaPEjUgfbhbiZb+ORNOV+wXlPnWb7ngZchoeM
	eJz2DtlKOXFWksHJRsA2roFj4h66+z8GCjfO71kC5krnzSzIJaXAjE1jSMxaDQQu
	AMW/c6QdVyE6e1lWoEChjOZZE1POC/jWcO5GPu7O6yGq+gKmniCFbfYGew96vUIU
	i3y9YSSiMjRTazk4DWAJENNnsJd3IBfi5o5jaInOfC7OiazeXci6HR/+uoXeKlv3
	BAtE44REKjwUFbh002O7ZFZLJs5aHS0jJaKxN/k9HHGfbbJW4UXiHWP5sYFnJiU8
	SIDWhn/3Cmah6DhYfGUySw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4yc26c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 14:01:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56SDh1Zf020545;
	Mon, 28 Jul 2025 14:00:52 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfeuwaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 14:00:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ot4XLsZ2iOZQuRFx24QjlgPnY4kFwEuAyel3NPBtXFspwd/T2I47J+cYp19NW1MYFfUMO/kEojx51sigM/WLPS/wDO3VpThpdzoRn6ynxloDac+Q7ldZnhRlhKiOCdDCwRuE2TfDcEQELY7fRXmYVEzXEW77GctFLM0eMyjNObeSumkXFrB5OGYB8lHd8PAooAIf8+byR5CUgl1Keun94oQyrs3kTF31LVUvrNY0caWa0R42Gb0b6TsWIjTxZwpoU7bcw9bJ7qjLpgJpklZclZFBacYy+Ib9jNyKB50s8e3O97WHXkMLVjEesQjzhp/uLgQYjeoEcQdR/XLXGr5ZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/X767Wo5EfNcID8a6SuOKdSLRnSx9aPs8JWmolzSKc=;
 b=uHB5Vj7O6IepKwv5FBEgHInJujQGdOIJNpOgfINdpisYPU2rZgVnMivmzNd7AR/+ZHxR4kra4lNEy1WR/snApu9t7Vm8PT+kew6Kf7iQl8ABUU5HbLo6NdIjpACnhycgdiSBbrC6OXzpXWom/794yd4A7xD22d4+WM3qj+Q7AILd+grv1XpFRWG07+N/JqY6Y4e5kdcgKYsVHGFxOeYNzKWJkOUwmsYruE+yVGiBvYwDkXYem7L6NNunQJAVr1Jzz/99W01r6h7903EfXGRkFkqm1s5hie2X+9k35iSfk/QUnAszqey6HToFZByozlP/xiFpq4ShUHYCrsL65VNrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/X767Wo5EfNcID8a6SuOKdSLRnSx9aPs8JWmolzSKc=;
 b=mhYG35Wr4Kh0DVKZr3sH7PvMmeTzCbk+SScDHUOxjr+Ks/jgP113jeFC+uVytBFj2EvyRQVMPip/RVzrXIRBAwAnlUod3NDzRyN9GqS+ruEV3+Ce+yQRp+mIzyAcTAFJta5Tvbx0mTY6WAgI3ABwnRudPeweZU6WGFdJ1Xv6gug=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CY5PR10MB6045.namprd10.prod.outlook.com (2603:10b6:930:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 14:00:46 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:00:45 +0000
Message-ID: <3a4854ac-75ad-4783-acbd-048fe7c7fdb0@oracle.com>
Date: Mon, 28 Jul 2025 15:00:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <aHkAJJkvaWYJu7gC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <b270bb66-721e-4433-adaf-fe5ae100ca6e@oracle.com>
 <aH9PwFm06n9KQ0mE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7fc0f04e-dcec-47a4-b522-eb5a8b90637c@oracle.com>
 <aIDozETJ8aLparYV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <9b9ed959-bda5-4a92-90c7-a621ffe58240@oracle.com>
 <aIMjrunlU04jI2lF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <0af205d9-6093-4931-abe9-f236acae8d44@oracle.com>
 <aIccCgrCuQ4Wf1OH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <2ae4bb04-fbf7-4a53-b498-ea6361cdab3e@oracle.com>
 <aId8oZGXSg5DW48X@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aId8oZGXSg5DW48X@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::11) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CY5PR10MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf9f73f-6567-410e-e592-08ddcddf25c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDhhM3pLbVpEcDgwdkJiZ21CY2d5MWlqRklHYkhiTUdxOCtjdzlqYUpTU0Nm?=
 =?utf-8?B?NFE0S01qYnFNa2lOZVl3aEtma3NuN0dMcFVjeFo3MXhMdjJiYzJNM2E2bmFv?=
 =?utf-8?B?WlA4OG9lQm1BRkV5UmxPUmdrajZmdXpEQ1lNN3h2TjhDQTIzQ2NIKzJtbFlh?=
 =?utf-8?B?RVpRMnZMc1ZvYzVjNmYycHBHelZuVkp0Nms5Vndxd0lBcUtqUHpHQkJGaWJz?=
 =?utf-8?B?T0I4S2NreUYxNFBNK3R1dWxhSmhEa2pGVWVjMktxUTdPVGp3M3VObjBWaVUr?=
 =?utf-8?B?bTJDdHZZS0c5TnIrZXluVG1Ca2gxTlp5UlI3UHl3a3NwNlVlYXRMTjY2ZGx5?=
 =?utf-8?B?TnpmZDFXY3c0QWwxVk1mVENGcGlPM05lMzhIZFBkcmhxYkFoTGxTZnlnU1Vv?=
 =?utf-8?B?TTBtQ0ZkUWhydVorWXI3bklJNm54cEFIUjhZa3RZdHVkRWhadzNUWUsxcUhX?=
 =?utf-8?B?aXBBZzRLU3VNY0VsSm1za3B5dXJiU3NzbGY1V2twcHdQQ2M1VHFKOG1NS3NX?=
 =?utf-8?B?eGR3VU1ZUEFFT2VYVE41c2Y1T0VPaktOYUh6MjdUaisrNFl0amN0Tkg3Nldp?=
 =?utf-8?B?M2JOWmVlekJ2ZUs4ZWl4MkYrQ3dKM2JETFJlNzJJeHBnSVdLMzFocnNTRVdx?=
 =?utf-8?B?S2JsTDhoNjhTOXZ4WkUwcDc1NVpjVHd6dkZQUVFTcmdXM0Q3TE0xczZPb21k?=
 =?utf-8?B?V2pBeXZEaGxHWlpUcTZJcFhaZitDYWJXVGxYL3FPaU1MZG1RNDNFZ1Y5ZzZl?=
 =?utf-8?B?VnM4U3FhenlRcVlMTG5jSEJZRGpxQVJOTU91Y0xUYitkVjNqOTBadVlvcXZy?=
 =?utf-8?B?VDNIdDE0ZExaMlBwR2VwK3krcnBYNXJveDlNOUlMV0ZZQXNoZkoyYkwzcTU4?=
 =?utf-8?B?dWpWNW9WK2NyenBXUWEwT3ZHUU5oWmdaRFBxVjAvTnhMa3RVWUhpVVBHZnBR?=
 =?utf-8?B?TDF2c2NRUXY3MGQyc1NXODlBdFdSTC9KYnROdUo4QThxbTVseVBtMXlhWHBH?=
 =?utf-8?B?bURnZjNqdmZnSXFpNjNKN0tscjl0M2tPV0k2L3hCaDNtSnhZNjI5Tit6Rmh3?=
 =?utf-8?B?SG4yY1E5ZXpkODArZHM0blNESDNEMGh1amtud09aVzBpR3c0cDBPWWV6bFZF?=
 =?utf-8?B?U0ZqSEVISTlRU0RjTEZ3Qm1MVVhxVHFWcXB4ZE8vRHNzdmIzVm1aN3pGdkNS?=
 =?utf-8?B?Wm16Rnk2R0k0WmNCOUloVHVZMUZVTVRkZ3Fic3pUYWVuZGc0d2YzWDRKY0hv?=
 =?utf-8?B?VXJtRndwUXdsZEFlVjV1c2RFV2VqNkk4OGhRUmdkdEVFTVBXOGdyc3pJbUhH?=
 =?utf-8?B?OWJhYkhHZ1lZRGovTjdCeWJ4ajQvQ0NBOVhtbUI0RmZhRzA5d1RuaWRzSUdM?=
 =?utf-8?B?d0pKWlVuQWZTZEQwRWJFQTdqSDVvdExMWktQMXk3M2ltZlJsMG1ndCs1cFQ4?=
 =?utf-8?B?VEJwNmFQcnF2clFoa29MNUxZV2RvY0xhVEZDK1gzS2lBd1ozUVNVaVh5c2Np?=
 =?utf-8?B?L1l5Q2oxSWUzUWU0ZEVqZllvWVFnSmY4REVhUXhiZzNXMlJDcDJaUVFVYTRj?=
 =?utf-8?B?cnZ3eW5RM2FZTWUxRUVBd3o0Q0t2bXJ4MGhjK0hoOHFzTW11NWtYQlo4NnFs?=
 =?utf-8?B?YmZYSis4NFpVSlk5eUZsakhyWlpCK3Z1a3NWV09BWnZySzJFZi9xWjZ5STBi?=
 =?utf-8?B?YVVST1NtR2psWXpvNFVDdWI1blRCTXI3bnVVd2RYMW9yaHlPZDlLT0RHeG44?=
 =?utf-8?B?WnJOemc3N05RQXNOdTRjZUlHQTg5MnVaTUxVWWlKclgwNEJqZEx2VlY1UUJ5?=
 =?utf-8?B?cGZTOWh4L2pjMzdDS3N5OE4yTHpCR2kzeGlmc0N0NlFXVm03MU9yclREQ2dW?=
 =?utf-8?B?M2dZZDM1b0dpK3QzL0EvN3MxMEdWZnpJSjVtUUYzamU2ZnhxaGF5bnJrMlBt?=
 =?utf-8?Q?xg6IuyB3Sp4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z04rOWlXZ3N5SVhIYWVFMTc4Yk95Y1YyTFR6QUxrRjV6ZENIa0pYZUNCTXNN?=
 =?utf-8?B?WmdWdjQvQ0d5eWFyUVIvb1BYUVBhVWR5QXg4azBWZ3ZRWk5HbWFtd2RPekwr?=
 =?utf-8?B?U1FVdTNjYk9EaTU5NWVTVTJybUNBTzZ6UVBnU2NFR0Z6QWVWcS9uakJ3KzBJ?=
 =?utf-8?B?Q0M5bWN3R0h0a0hZSjIwZ215QlZQa0xKSzlFeHJYbU1QNFRLZksyM3hmS05E?=
 =?utf-8?B?RHVORmY2WmdycHRRdXlQZXRXTE1QWkE3TGRBbHVEN01wdDVUZ0ZNRnp3Q0Ev?=
 =?utf-8?B?ZURxTjZ2VFpaUFEzSDcwM29oQ3hqR3A4RERkN3hrUWN1VW5EUGR6TnB5QXN5?=
 =?utf-8?B?NzJLQjQxR2VOMFdsbkdhckQxYTRpc0puNXdha3dXWGsyUGd5c1JDWjBQS3ZW?=
 =?utf-8?B?b1pFSHhrR2djN2VYeHl0YjZ5RGh5T0FkeHBsU2dDWituZW5ZVHRkeHdCRkpy?=
 =?utf-8?B?TnNNc2hiZGR6cTU1ajVySFBjQjVMcDVuYUZlYzFRbGhUMVAwVjlZc3hvSHEy?=
 =?utf-8?B?R2owQWk2N1VWZ1EvMjFnNE0rMWY1ZE5xcmp1bUdLZHV5US9Dc3RicmpQeXY1?=
 =?utf-8?B?WGpveTREdHFLYnBYQTRZNTJJSndubGJwaWcyM1Y0NHluWFdsR2hDcGNCQ1Jq?=
 =?utf-8?B?cDh1bjIyQmV1VnprRWVwUHJ0eWUvNmdSb1I1K3JUVVJRY2FMaG1ET2xDU1ZB?=
 =?utf-8?B?U1hxaWc1T1duTjN1ZDlya0tTK3NTajN2R0tHSVBxRDJoQmQ4aitSeWdwZklQ?=
 =?utf-8?B?RFpVNHM0Ni9UU0xjTXVlZzVJK1VzU0h2NWZ0RStxRWt5cm5QSnJSdnlxTjlj?=
 =?utf-8?B?Y0ZQUVF0bS9QZGx6Sy9kZGNBWFdiRkRIVnQxblFBVHNvWkhRMEcxZnZ5b01y?=
 =?utf-8?B?cEE1bUptVVdsN0V3cmNIemVtaXJIR0RMVlJ6WWdUMnBFTHQwNWxOSElJbUpP?=
 =?utf-8?B?cVk5Vmw5bWZUanRKMGRtNElMYS9QRTFwbWRqMzdtbllHVVVHQTYvem00Vjgz?=
 =?utf-8?B?UlRYd0FvWS83VjVraXNSZDZvbjQ5bk9qb0Nic0s2cmptay91QXRyYkw1b3pM?=
 =?utf-8?B?bUJZb0QxYlFwVS9jeFhKL0pSYzhaWDFIcE1KaUZEMTlZY0cySnlmZEhrczli?=
 =?utf-8?B?R2Y0b1JwSDJVQkc1dEZyb25ab3gxckpNY2VaOEpmZWF4eWlvcU5xNWNuU1NJ?=
 =?utf-8?B?UDdtcmRGeG1VTGVvRWZOY0wzRnU3ZmRUQnFTZ3VrQ2pCWms3NGVyUDE5ei9p?=
 =?utf-8?B?MmlPR09MdzhLUUhOWjVQZDgwRTJVcFV1S1E4WXAzVEFKN0NTdzZSUlk2aXF3?=
 =?utf-8?B?UnpYQkxQT0VIV3VTVGVCaDBHdXIyU2FkMmlmTUIxSjVtdnhQVUk1N1lyRmFr?=
 =?utf-8?B?dlY5M3hBL3Zoem94T0pDOVh3bjlsb0d5ZGVoZ1pXaFpzVmVqdytMczJYTVl6?=
 =?utf-8?B?R2gwc242SkVrZWdnQ0ZBVFZ3YmkrREdwb0NPQWpoRzRESy9LQTE5Q0dTTUtk?=
 =?utf-8?B?bDY1bDRvb1cwUnNLYUs0bXZYcDZHS25GUVJpT2VwbFBzSGN5SUFIN2p6Ym44?=
 =?utf-8?B?Q0lTMDVwbFFuM2V0YjlSNWhSeEkyUUl4ZGZweFIzQVV3djdIOGFLb1l2dWtN?=
 =?utf-8?B?RzRxRWdCdlNsREhYWkpHZ3M0YllmdHpCVDRYQkgyZlhTcWtzM1BPbkx5cE1R?=
 =?utf-8?B?cDRQV2EzR281c1ptWk8zSGU4UndrbDExUndrdE9pK1FtTmlIbWY0VjBTaDhU?=
 =?utf-8?B?NzUrSkpJMEpKY1ZJWmZvQ2lsS1M3TTdzYVJ0MW1NVUx5VHJvRHl2SXlXWkwr?=
 =?utf-8?B?NkdBcEd4NEtYWTlLUlV3VnVUU2s4aGpDK1FyWXB1WUVZK245UXRRblFuT2xp?=
 =?utf-8?B?RllHQzZKRmdPZFZFWWFrYWlVY2d2dzJ2WGhRRjFIVGpTeWpEWGRiVEhGcWph?=
 =?utf-8?B?M1lTTjdvWXFtaUN2MVZNVmhDTWRJanJPV3A1OTdSU0dSbXZyZEZIUGFZRzBp?=
 =?utf-8?B?eiswaTh2WFUxa2pyQWVCc1FtNEtWTVRucTdmZElwM3BNSHFPWlpmOGRXNTRZ?=
 =?utf-8?B?T1NHY0Y1TjZzWEJ0cndheGdzUklxdXltOTZIR0hxNU5tZXhWYWJqMERXRm45?=
 =?utf-8?B?T00wUlZsUlpJOVl2eHV2U015NGxpSzN5T0NIV0xyVjNHRDRrcWJsTDB6RFEw?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hz+NOe4lKUKq82QwuUje2zmZqiAVd3778Q5h+lxBDHBq11NyU+ufSuY0uW/OmtfwxI6RJqyKNLpPWZrzpwlze5Rrdc1yFbOf1dT+XXD3V3E41eaO92LopqHW1hAjTOLM7xnL/ZQ1fLLs/lgtDIr3NhFTlvNMM1sEhG4Eg8TLRJXSnniAEapvKn0bzGlUFYRvodaT/8WQ/tk06AjCZFIiFXoSN5gDcKGEsQipFBR7wDPSV839QjW0zU1fokqMCM8oUs5Jm+a7Ye+36iTl53LgfmDX7BYtKn3QxrDDQC3pewVPeH2yQy2pGznwP8LQya51NAlf+ilkqwS+r63rKht6nFn96/7qgTsAbcdXDpzMGwqEE5cAaObl7WZtsLXSYhbiwG2c/U3kk2UJctnfKfhwtjldJKYuO0oWjbaUP32zpZPfii1U8tbUr4Zzo4pi8J0OsZLfz9VHBtwuRIyGk3ZXOyFmmcQc04XH0lPMFexkVA2DrlyUThPSeBzP9Ah0DNB/i8EhNSDIl3SbBO+YuwY+pMKKg8VXy+GyQEPPAmJrGf1y8owYzLk7OUB42H2gJ/hNMTVk9Ay/DCB7qOohacV/Ru5Aw8A+PWLUByouPCcIcHo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf9f73f-6567-410e-e592-08ddcddf25c9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 14:00:45.6057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93FNOQ+QhKSAJWSHgMu3a2VTYYKzc58MFIIw8CWbr+4NXc/nxf/+bISV3UNyucsnGiYqa7Z5WPAA0HdszaCEtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507280103
X-Proofpoint-GUID: Y3wjtQOIoZEZTJ7FGbMnOT0h_CWEoAOH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEwMyBTYWx0ZWRfX/B0fbOKI2Hv8
 aaQ5ffzi0z8sSaZQPwrdIt/IiK/z7F+iJ6QgBWB9D6FEcT8JjeS2kI6R9u2oq9T6ToUmNhqonRm
 yGTmBBZEpoYCwa8mYw+PEmxK5HiUcfp8/PMW7CTul6o3JZtFCIAbe+0AtSpCwDMkQiO+Xu909MJ
 gma1fjLehmUgnjORvAIWdNl6MeKIr9dwwDryTzrjIOLoHE2pwpL2HdzpQH6es/DmyYHCNk6BiGf
 HvU2emgEATS3XiyTpKhHp8NHm5t+rkWHxGd1HhhvSK7EE0qEifgEQ5V17fKREU3GqbIq83dp/5e
 hPyGhIqhXYUqT+x1akwvUuxYZypjUSUlYH6gupBJKvyuaQ8hd3ecoMauzrxw3tALnTzQnKehXSW
 +8HsyNEcri+Hs2xCyROuDWLnSNGRcfiTsMzvXMHEYbXnBpNOJrB5Bwvk0w9PtwlAy084OEr1
X-Authority-Analysis: v=2.4 cv=ZMjXmW7b c=1 sm=1 tr=0 ts=688782a1 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=FcRoc57bcyZfW0-MSdwA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: Y3wjtQOIoZEZTJ7FGbMnOT0h_CWEoAOH

On 28/07/2025 14:35, Ojaswin Mujoo wrote:
>> We guarantee that the write is committed all-or-nothing, but do rely on
>> userspace not issuing racing atomic writes or racing regular writes.
>>
>> I can easily change this, as I mentioned, but I am not convinced that it is
>> a must.
> Purely from a design point of view, I feel we are breaking atomicity and
> hence we should serialize or just stop userspace from doing this (which
> is a bit extreme).

If you check the man page description of RWF_ATOMIC, it does not mention 
serialization. The user should conclude that usual direct IO rules 
apply, i.e. userspace is responsible for serializing.

> 
> I know userspace should ideally not do overwriting atomic writes but if
> it is something we are allowing (which we do) then it is
> kernel's responsibility to ensure atomicity. Sure we can penalize them
> by serializing the writes but not by tearing it.
> 
> With that reasoning, I don't think the test should accomodate for this
> particular scenario.

I can send a patch to the community for xfs (to provide serialization), 
like I showed earlier, to get opinion.

Thanks,
John


