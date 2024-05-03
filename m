Return-Path: <linux-ext4+bounces-2290-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C2C8BB83F
	for <lists+linux-ext4@lfdr.de>; Sat,  4 May 2024 01:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025F21F21CF3
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 23:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C6784A52;
	Fri,  3 May 2024 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OVCjYQdb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E73aeOO7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD42B290F;
	Fri,  3 May 2024 23:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714778888; cv=fail; b=b2zAGW4vRpK1Fo8FaFX8yt1grxa2Jt06bDjiPG5h11iVBrfW42Q1B3flxxf1l55d01ryNlPwRmthUbu8EZ49u+pjilT0CjW30hoIA/W4VoRkelDQ6TA0QCWKoXfWxZRp2GanBkpJcoOTTZw6FrTY599ZVscNDEGc1a1W3V2firs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714778888; c=relaxed/simple;
	bh=32KnhJVcXnQIcY7+Gm1X4KS+a8p2xB0LxJkXM5vtEGo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PbWCW8TXKAbfMTW35QwsRJeHDtt89F5zVHyDKMrKNd2ZpqbmhIO1slXbcWwCMCyasKHi142YHwhokfLIygQ/qc1SHpHjhHLcyLPrWk7P9aiTCCSX4gGPeSkc/Le1Z2BOt2WKMkMSxptTi4bWd5mlC6lJVGPkaPjFAkNoPWn7DN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OVCjYQdb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E73aeOO7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 443GXDnO018650;
	Fri, 3 May 2024 23:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dT1UcUUnJx3lgI6pHvnQFlWdGZ7L/7jbQcLR3SUciwU=;
 b=OVCjYQdbWFKj76CodngBkLdm724+9o1ttZT2KtMjA9yskjLhTz6k9Ma3agDOmzzvGp7a
 O17uLL6SstaAgJNcSRod2PQWIJ86NgbYrxPF6aLrLMuAEFGmdGsCHbXLwiSVLYfg+8fG
 kTq5tbhNJpz+OQ5KC1oNjpZDCB+jDGqd3cJpMyc8UGsbcm0lLIJCHsyL9q2qXqJHDqut
 QvHBDpFMEhVcUh2yPwkvGAJersRUQ0t1NUi7YtOySORhTuhdqhgCrlyBBWHdDzIxKFNu
 dSBJZUQerMdofrVoyJLTiev/55XrEjoZK+CakKcHCYpermiVCCTAp94qpBVvGSC/7Irn GA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsww1hs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 23:27:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 443L6tPm034699;
	Fri, 3 May 2024 23:27:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcrk5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 23:27:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNrKEG+hLN35D7CZV76sCbLTUPrnV/U/DuC6fvGBhI1o/8jnwkbt/XN5HuowISN27lViKV4+IrOCeyRa3zNtWFxY+uuz/j55lGzkV8BCS8ePSSh1bKIZpPM2ojA8wfGVlDxMucdYbI42WMJor1SKueSk8CRFR/zukFrIm7j5J1qQXpXjiBXqvGuEUhfUyzDMqBMxu6tG7Tek4rDlT8xqPTDYKhLT37a2Xvru0nrIMXne9P624aAyeR2LmVQL8dJCHAQgwuj9JwM6i5oe4kC0nBertdIklHaM8D19Y5/GG9by1u1rCbzXlHqLbu0OCC2nJT8c3ICYs8Nk5Rj1ocDmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT1UcUUnJx3lgI6pHvnQFlWdGZ7L/7jbQcLR3SUciwU=;
 b=bEAWvmDUtWesLtRPHvqZdr8mKwXO7L6jck8FEPXWXceMcbNyzUrLURyICwsM+yYzwkPzyRfy58UjlaR2MYDkCePMdTCIrbt1nohwtygsr5GZivChEVy/0FofDb1X/s8GzNU9EolAZn8s1TbKQ/WAJdtq6Z90dwFOsC35bDn4UgibvB0d1m4cpV5ZgTRiL44mr64E9vJspNXzan+QXwJo3zznLxx7mmZdx9q9vlBKdk7m8bQsSXztXTtVQWbiNEGnqgpPXQy4GNr9R939WUl3la5YXLLDM5LbQP6S7ttWNQYFI7idIbJyDfEaz74FrptaDWF9hOkCw2ypM2ik+SGA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT1UcUUnJx3lgI6pHvnQFlWdGZ7L/7jbQcLR3SUciwU=;
 b=E73aeOO7OO07orPZQkL1BztAKEjAnP1P43MC4KvHwL6ra26jzJyO+GOUalQWCXLgDNyqNDSORJ5e43yY7Mjn+yHwWUNncqchiXkq2soCe6yt6owzMt9/LFGCydIqcu+hIG5avDgKDIHi/1IPpYXhyE9G8GNEZnyTHoYsjJ/rRv4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6919.namprd10.prod.outlook.com (2603:10b6:8:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 23:27:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 23:27:54 +0000
Message-ID: <7a33ff31-e570-4775-b82f-1c6413656699@oracle.com>
Date: Sat, 4 May 2024 07:27:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] btrfs-progs: convert: support ext2 unwritten file
 data extents
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1714722726.git.anand.jain@oracle.com>
 <6d2a19ced4551bfcf2a5d841921af7f84c4ea950.1714722726.git.anand.jain@oracle.com>
 <48787c70-1abf-433e-ad3f-9e212237f9a5@suse.com>
 <8b5107fa-bcce-46dd-950b-775695d872e6@oracle.com>
 <459ec128-eddd-4575-ab28-788f340a6a7c@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <459ec128-eddd-4575-ab28-788f340a6a7c@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0212.apcprd06.prod.outlook.com
 (2603:1096:4:68::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 620dd3d1-369c-48e8-ffb0-08dc6bc8a814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M0YzdDVJUFBLblU1SHJ0UGMwbGpRVjN3YjUrMklUUlRrUTdWMm1sd0p0bEt5?=
 =?utf-8?B?cXpRcGhUayszeCtZdlU2b0pFUW5oYzUzcHFVTVNZZTl3OEQ0ZjJaYnMrWDV5?=
 =?utf-8?B?c1U2VmVjcmREZkJ4VXJmMG5RdnZoZVpocjBzaFk2TVFzWVc4U1lRVC9zSTc5?=
 =?utf-8?B?c0Y5T3MxWEdwVEpqNmkvOXBDaVFhN3pYNVFWaG5nZ2ZyTWhqeHpZdFR2bVJW?=
 =?utf-8?B?WWhnaUNLM1Qrdkdjd0dMZGJMSkFGNjJ5L2VxYlMyRnJCaDduWFVNUmljR1NO?=
 =?utf-8?B?TlpoclVYcmtkODlVM3B3cVROMWcrZExtQVBWbWt5TGtWVDZiQ3kybGUxL1Jp?=
 =?utf-8?B?ejFRYml4UEpjdDR3aHphWERBSllNZkE2VUxwMk1BUFJCWUkwQU42R2FDWmtK?=
 =?utf-8?B?ck43Wm1QYmVzTVR2UU9jaXJlYVVzQnBwb3lISyt2aDlWdFpWS21UaGRWUUZy?=
 =?utf-8?B?ekdZMWpMKzZxZUJpVjJ2Z1FWQ3N0MW1ZWU53cGZUVFJaa0hCR2lKWmNVMUdr?=
 =?utf-8?B?T0ExM0JMMmxyalBna1pUeGNXU2xZd2Nwa21xYS9LNDRFcVFqWUNBS2krc0pj?=
 =?utf-8?B?YmZjTFFOR2pLd2NwTnhDS0pwd1JOQ1FwTVA0RWNEcXNBckhZWlBQZHVlVGJX?=
 =?utf-8?B?MFo0RncrRG94ZnBjNkZ3Y2Z5cnNPNEN6UllhWmEwYVZnTy9sMmxzQ1BsVzJX?=
 =?utf-8?B?NVgzSkE4czhkeUlHOUZJSS90MEtodjlvSGdGS0MwUnVRYXF1QUpMZFB1Y2Fy?=
 =?utf-8?B?MU5vTmtuRkNlZDBGZzIxSHRRVjM4SXpEZ29rYWc5WjUwYWJDVW9Bckx0cE85?=
 =?utf-8?B?ZC9aMHd5NUVwQWNOakp0UG5EL2dDeXNzanJ2c1lxR3JVdTNPREFOZUg2WjNk?=
 =?utf-8?B?ZUd6eEdBenYxd3d2K25YOWt1d1AyQWVEckpFWTVBQjNndTZ3NXFEN25RazFy?=
 =?utf-8?B?bkZWWG1md3JhVjhBdjU2MGFJdlM1SDZ4bDVjdlBKOVVXRlA0cHFqbnd4WXhl?=
 =?utf-8?B?R3lLSHM3TlhvUmhteGlndE9XemJkY2RVanJYTFFhMEI1TkVWbVlOK0lzdFMx?=
 =?utf-8?B?bmRkbHhaU3dzaXdqSzVpNTYrbERVWVlNRStodzI1R0ZuVk03T2xVWkhJSWYx?=
 =?utf-8?B?cGxCZS9adWRnaW1YYlIwaHM1UUlnZnhNUC9PcjZUVyt2Nlp6bVZCeVpVZnNx?=
 =?utf-8?B?MEl2cnBsWUpIb2Y2WUFrMm9PMzMvL0gxYjVWeFdnQnpZcjJvS29kcnVld0FF?=
 =?utf-8?B?cTk2MS82Y3diUUNOMytZY0NZb3hvQ2tIcWZiRHJZVDNNUGhCR2M4aTFaQXY3?=
 =?utf-8?B?OFdtdUE5emYzQUYxcldQQVp5NWRxeUoyWmFRdERYNnN4c0wwM3ppZGFWdHlm?=
 =?utf-8?B?MzZoYkp0bjRaM0xHRUZhT3lGL21HUU9XeDFaMkQrNVU2OXJ4TGkvWFhwemJZ?=
 =?utf-8?B?OFhyTTlIdURVMUczcXBZNjB6K2w2eVZOeEF3VWthcmZZN1c1WnpsU1hOZTJG?=
 =?utf-8?B?SDdpNWhCTzJQOVk5MTk3ZGdyR01NYXRVN2YwTk11UVljRzEzMDVyWXVSNUJv?=
 =?utf-8?B?V3N6bE05R2JXVVd1bFJjaU5YMXdRN05yeFdQN0NIVEMvKy9WdXlUNC9XQzJ6?=
 =?utf-8?B?N25iTERTb3NGemR0bml2K1JpK2gzUlZ3dEszYnV5bnBnNkJndVF0RFBGeDVm?=
 =?utf-8?B?R2V2SDl5dS9CUTBXdXhZY3dKZXNoTkh1R3VWd2xUSy9tOE5UdVZ6YWtnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WXBId25MOCt2cXFFdEVuK3lDU1cyR1RheTJCUXJ6aDhJTXJzVjVUUld6ZGpz?=
 =?utf-8?B?ZllUdlZQMncyeEpFL0U2QU9QYjgzZ3N1aXpZUGFWRzc2V0taV1gvcnlTYzk4?=
 =?utf-8?B?RVdTYVNMTGhFUmNpKzZPMUE3amE2UTVzMDJsZzhjQXdPR2pzNGxxUzQ5Qm1n?=
 =?utf-8?B?YnEyc2lidVRleGlEdEJoTFJpa3UwTjRvdkhOU09LZ0Rod0d0MHBtdi9uSnhr?=
 =?utf-8?B?dzBPZ09PZWVYOHpDdlRnRXlPOE1DTTNrU1doRmZlbi9pQk9CR1VYTjduMW9V?=
 =?utf-8?B?Mm9EVU5zcjFRRk0xM053YzUvQUdmc3VOTG1uQXVnWmlQVUZPZ3ZIQnFQWEk0?=
 =?utf-8?B?N3RRM3JBOHlLelVCcVZNOXc0aHpnRzcxZEJZOWhYK1A1SjM3ZFBqeHRSNW0w?=
 =?utf-8?B?aElpY0I2UGFVSG5ML09wdExPOCtickdBZU1wUndRUVVKYW9JNVlYMEwvZlJt?=
 =?utf-8?B?S0FjaDAzMkIrTjhTdEQxMGxJeWhwS2lLT3ZicHd0NUdBNDE0N21xMk5PRUZi?=
 =?utf-8?B?T0U5TXEyRTRHVGtQdEpRRkx6aDJidkxJTlU1ZUhLdVRxSEY1MEV5bTE5cVBJ?=
 =?utf-8?B?Zm81V0xXK2k1ZjBTKzl3Rk4wRXYrVzlwT0h4azBRcnpVcldYSm8xSlZ2UmJB?=
 =?utf-8?B?SHZVM3VwUFJwbWd4MER6TU9rYXpvbVdLK1kvbnNNNDc5WmtkcDIrTmhCUGxK?=
 =?utf-8?B?Ny82NzNyMWdKSzVTNzAzREZhWFhTcHFVbHpJeDBjdlhCV1dqc0ZmQkNkOVUz?=
 =?utf-8?B?U3NKNWdpZFczQTRVSnd2S3ROMGdFekErNklUdkE1VzV5bVBKRUdPMEd6ak13?=
 =?utf-8?B?K0ovanBIVTR0Q0VEL0Zubm5SZ3dZN0psYjJpTkFqd3kra2s4Zy9Lb2R6clMv?=
 =?utf-8?B?cmUyN0hBV2F6NE9RYWNpdUd6TUlMQWM2Q01vSEFXdDcyeGJybWthaEZsYXhG?=
 =?utf-8?B?ckgraStqdFp4aTZYNHduK0c3aVVhTENVTXUyZCt4YW8rajNHcktEbEpOdVo5?=
 =?utf-8?B?ays4TVEyTWVmMVZuR2ljRTkvQk03S3p3alNRdnBabGRxTUJJRlhCUXBYTWY2?=
 =?utf-8?B?bXVDWEtTajNRTWFKY3ZySmFtSlRPbXhLSVBKTTVxUDBGbVJSK3VzSXE1MUZJ?=
 =?utf-8?B?WDVNWmFGSDZlU2E5UXJLOWcvNkhJOGUrenRwQWF0L2J3TzFiZHp2b1NYU1BG?=
 =?utf-8?B?TFBEaTRYT2hSMGo5MDZqTStON1hxMjNkTVBxUGJnQ2ZuUmE1SHRUcW9Ga3pE?=
 =?utf-8?B?SzV1U2d6RmpEZVIzdDhmY21NaDNNRyswNDFwNG14LzJjbXNScXpUYklIU1Na?=
 =?utf-8?B?eDVPZzlMaHJDa0UyMHhkVzlQU3YxQXhMYnJqSlA2aUo2N1JwcnFBU3h4U0s5?=
 =?utf-8?B?b2pMMkZzR3RTQzF0KzZ4MXlhTC9rR29sYzVnZkNlV05UT1U4MDFEZHdvcncr?=
 =?utf-8?B?SnJIZXNwb004b01qZ3FKVW4zT0dFYWxhSGNJZlBYc0I1azRRWDhFSTVYa1Q1?=
 =?utf-8?B?OW4vUUo2dmZnV3VYQUZzWk1CT3NOT1ZEZ2Y0emt1cXc5R0VuUVhJRVduU1FM?=
 =?utf-8?B?K2dUaEpPbGoyWnp1c0VHa0NqWllDbUd6UmdyK2pjUmdoZTgrNFE1Qjdxbmhs?=
 =?utf-8?B?WmJ6NURUT0VoamF2ZmYzQlBXZTVKblJCYTIyZlJUSURDSVFPdDRPRHN0aTB4?=
 =?utf-8?B?ZDQwNWpxQk5OakcvMEF4MEdEYUhqSXp3SnQxTFAwa2pEblpacnpPblVOR0VY?=
 =?utf-8?B?QXNTbnhBUld1U3FHZHVHWUdmUTNKZUhXQ3o2T0ZTNEpab1NOVG1iUy9ONmhm?=
 =?utf-8?B?eVF6RGYzWWRuT2kzKzVIM1BXTGxOWUovaWZ3ek5HL0hDTy9hVFZPZHdNVTI4?=
 =?utf-8?B?NmUrMDduM1l5bUNTaUFlb28yQmtEVXk5MlMwckMvVkYyMVllVWRnM0YxVjlu?=
 =?utf-8?B?aks4dS9mS1BTeDJTeTRVc0Z4UURnckRmNWFlYkpZYUQvaFh1NjZETU44QTFi?=
 =?utf-8?B?TmhNUmhpVTJBOExZb3pMM3pxa1hNTVR6OElOWUxBQ1ZMandSc1VxZ0I3MjZD?=
 =?utf-8?B?RCtNK1JWMXZ6cWQ4S29IemRUYjJzN2xEdEh0MHB1Y29qMnFQRmpHcWZld0NU?=
 =?utf-8?B?OUJnTEFPSUxzRXN5Tmh3NDEvT2h2RklTa284T3NVNWNOQjZyUUo3dmdRd1VW?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	T6fMppYxxDAu6Xvc62ZqzT9MMbxL/MGLUlSH8H8+TYTklbh+6rPfZNmToPBJvuVQxCp7gil1l+pqCDwlS0vlYZWSn9EjwDa6q4gkJIpLtgYxInJZWf4awloFUYQkNLWtkbge7gCxyJEayTYUiPoVFnj16SGDyNbZpNxfOvDRMRbz4gcCQ77x396xE7cXiuW1dX8aS2/VdxMfTMW2v8E58xqIPfdsk1jstD01rgEM5RAbSPHWhm0t1X1wtyCXsVEbypbmZowYpXHSP23h8gqlPbJtwLSaGdYhFDDbuxORdZrqlnOteCnt1nK2JPpfdFXp7h/7hEbeUHT97j6NKd8m1xBmK4RNCa0rRmjSmX0n4N2AZC9mtKz/LxBvZbzvAMSBo1mDUzr/lX6HPcYndHW+bNwUO/N3RWrlSflak1qK3EtLuqVCPDEa3ONR0rpy6C4moTL/64D3gYhatt+INEn5DdWR9+jPiK7g+hGnMBcYC1Eghu1vys/bfhDGp5G6wZYR+3yRH7HDnU9EOnbK6rJ9+PIKV3vdDPFBCDBBc95/EgLygblc47gX9U1TCS1y+l6V3ZZHeH1ZQyI3zvveuIN103Kwp1WaPemldl/Pi/U9TzI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620dd3d1-369c-48e8-ffb0-08dc6bc8a814
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 23:27:54.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V0QNfg36Ono5WYQYXfa3gBF5UxvEc5i8PUNEcculgRA9/D5/D3FZELTNPXcQRs5mhOklRHsNa9ee0nGq+WAfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_16,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405030166
X-Proofpoint-GUID: ojRcPrdbYnieYgtGqr4WCFtxsY8ue9PT
X-Proofpoint-ORIG-GUID: ojRcPrdbYnieYgtGqr4WCFtxsY8ue9PT



On 5/4/24 06:23, Qu Wenruo wrote:
> 
> 
> 在 2024/5/3 21:55, Anand Jain 写道:
> [...]
>>>> +int find_prealloc(struct blk_iterate_data *data, int index, bool 
>>>> *prealloc)
>>>
>>> This function is called for every file extent we're going to create.
>>> I'm not a big fan of doing so many lookup.
>>>
>>> My question is, is this the only way to determine the flag of the 
>>> data extent?
>>>
>>> My instinct says there should be a straight forward way to determine 
>>> if a file extent is preallocated or not, just like what we do in our 
>>> file extent items.
>>
>>
>>> Thus during the ext2fs_block_iterate2(), there should be some way to 
>>> tell if a block is preallocated or not.
>>
>> Unfortunately, the callback doesn't provide the extent flags. Unless,  
>> I miss something?
> 
> You're right, the iterator interface does not provide any extra info.
> 
> And I also checked the kernel implementation, they have extra 
> ext4_map_blocks() to do the resolve, and then ext4_es_lookup_extent() to 
> determine if it's unwritten.
> 
> So I'm afraid we have to go this solution.
> 
> 
> Meanwhile related to the implementation, can we put the prealloc flat 
> into blk_iterate_data?
> So that we can handle different fses' preallocated extents in a more 
> common way.
> 

I initially thought so, but is blk_iterate_data::num_blocks always
equal to extent::e_len in all file data extent situations mixed
with hole and unwritten combinations? If not, then the flag might
not be appropriate there, as it doesn't apply to the entirety of
blk_iterate_data::num_blocks.

Thanks, Anand

> Thanks,
> Qu

