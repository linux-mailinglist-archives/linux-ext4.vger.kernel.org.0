Return-Path: <linux-ext4+bounces-2285-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689C78BAC69
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 14:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F306284B46
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 12:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB3015351E;
	Fri,  3 May 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FxDeiB/e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v3XugIN2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE710152193;
	Fri,  3 May 2024 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739135; cv=fail; b=ZaugcNq3188q3QMofPCCmPMODkuMJPwLWgkoQYeqibv+U82wcDh5rKdQCysTqxl2rl2ZImBsxUw56MlWut6FT+sUlB70tx+TReh+st+ysUo7mlDOhhD3MJ2RyrVbzTu80b4x0Qp6Rl6v/Gh9Q48IzOjmiqeGHLBEEKTsNMla7r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739135; c=relaxed/simple;
	bh=kmseVUSle6HbgjJaeQg4qulyL0qgEw0qDPSJ4IYQkPs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yu/xH1vu08dfytdtaXQOIgaecxqt2S9ltfaNCSXbYQJDyYdMgcxjo76Xj1cXTxiiixsmfXqhzO9oho2lMO6l4hVdXxPkC4rh0n7jnC4YRYa76JOorcsBmnKB6e3BDsDdPeUJvPuG/YDN4+BbWRQdECoJNAkMvuiZ01rQwrx9dAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FxDeiB/e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v3XugIN2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 443C2Rrq018590;
	Fri, 3 May 2024 12:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=C3nk5tJa54xYFlQBfeWXLJ/wBHdLJ2V8cpzdGK6bxME=;
 b=FxDeiB/e72XIWuYsTCPM2tBVzin7q1DbEGYcGRrR3lsHRVf1dSblGKksIwBA3pi6M1yC
 X9n/FSQyjMeUN/yCTwvIyZ8GWGP+kZBrSgmDLZy/kjqgy1kDUP4Vv9HvOVviDJbRIzps
 5OJT51xVuji6mqvusG/Yktbk0bCFbnHyvcjtV1282/561AbKuDCFR4m7dXGF/6ApjEJv
 XGZawyAE6eqZ/q4xzsRO9MIjR+Inv7fAGjBSxYLCHh7etFTcuzo3sXdM1Hc0JRqo5vBV
 IX11kg51beY3MUcV8qIRPR7+bKUaLSCcOwwW3f0fFyF1Vcd8i4RDaNMSXRg2FMdNBWNt ag== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsww054a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 12:25:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 443BiPVM040073;
	Fri, 3 May 2024 12:25:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcfats-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 12:25:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hchjucCT9yHnQQwlfs1xFhAqEMYGEkD3YUOfsiSebBEFS0PXHIclZdxPapJbhb1+vdAQFa5mhVwuqRAH8Bx4hvucU8AOYApecd3st3ItnqbRtBs8yp0A+PmulXDWD/wVB8lYyOcX9KOS+NOeyOCV5/bav2JlfkyBg+bOfcKQpylPnDWNUVUgkOHgJsKJRVPPkGKN1YGw2/em47FlAcwP601XFpgmI2IA9za1//Ar/B+OuhATzmyFJeCkjgUQ/RiQhtndWRW1mf+VDJi9r47s26n02HighAW3k8O7A+4Sa6eCiJLT3544vIy/Gd+enKQ+pzdIfD8m9SW/wPMZ+7nQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3nk5tJa54xYFlQBfeWXLJ/wBHdLJ2V8cpzdGK6bxME=;
 b=aVMwgl8SKHCWgTSWXZcwS2sWTawAbbQyVdhTX9zRThmON9Zo//HkJxy5E1nxa+UKEdpi8QrGo3OBKMxyr7QO/QVZ54WMSfhdkdSYc/6DRCPZ2mQR3UPwfNuR97QEqzsW/8FpSEfP9AygaJPDovVKulGl18Avt/aLJjqQ2iJpa1w/8knbQp0YGKdLMNtodkuyUaupnJHtN9xC0N9qMUE61xezyYkDU12k6gqO3pYA3cPtmJFCBXvxTQ2y+cy1Hx0xILwRUnboMYysd2ZPNm1Uo4sy5a/dxO9G3BxmZdPjA8kGnMs85xbIo0YNzbYgfnIVnQ0aslGsgmEVm3kudyO/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3nk5tJa54xYFlQBfeWXLJ/wBHdLJ2V8cpzdGK6bxME=;
 b=v3XugIN212Mfnf3IjtRTE9YbwpbJWGOBu9ADK9pgke31DcaMhTv0MjZxC4U9nRSTlmf+zUXt1ajksqPfTTdCS+1sLeUjQpz/Iu+5EHFS6euKVzdz8UHwyeNlRJaLrWK6r5HVpgc5e3LwlUQ97T489TdL4Gbmi4LJeKAN8a+YOko=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6064.namprd10.prod.outlook.com (2603:10b6:8:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Fri, 3 May
 2024 12:25:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 12:25:28 +0000
Message-ID: <8b5107fa-bcce-46dd-950b-775695d872e6@oracle.com>
Date: Fri, 3 May 2024 20:25:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/4] btrfs-progs: convert: support ext2 unwritten file
 data extents
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <cover.1714722726.git.anand.jain@oracle.com>
 <6d2a19ced4551bfcf2a5d841921af7f84c4ea950.1714722726.git.anand.jain@oracle.com>
 <48787c70-1abf-433e-ad3f-9e212237f9a5@suse.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <48787c70-1abf-433e-ad3f-9e212237f9a5@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0119.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 80937e34-35dc-468c-5dbd-08dc6b6c1de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dk9zRDVKVG5hLzRoM2txaGlKZXgxeWtzS2E0MGorZEx5Mk9UVkZ4OXY0c0dU?=
 =?utf-8?B?RUk1YkR1QTcrN2dPL3RrK1F5VVNSblkwVjYxdDVCamg3MW4wTWN1TitNZDRE?=
 =?utf-8?B?ajBZYlNuMlQvQXpSbkFoQXoxNXNwKzNwOVgrK2tOY3phaldoS1dBaVJpSDNJ?=
 =?utf-8?B?VUVHWlVROStIRVN6aUsvRXFVTUJzSGEwQ0piWEYzWlBNZHl6RDZMai9jMnM3?=
 =?utf-8?B?bEpEUWFXOFVZTW9PVVQwTzFSZzZhaUllcVE1ekxUTzJicGs1VDJVbU9pUlRi?=
 =?utf-8?B?Z0xOZ1lUU2paeS80S1dqSjlqUEtJSjJwWWdxczRmTUJJbzhsLzcwVTVVclFt?=
 =?utf-8?B?NUtQY3NSWEhQMGpYMW5qSXlOUVRDNmdvNlFKYitFVHBLTXE1bTBqcnQ1d0kr?=
 =?utf-8?B?N2hsNm1uTVJySTRUd09pTHhFTzQ2K2xzQVBhK0pwaFVyU0QvK09WS1h5U25k?=
 =?utf-8?B?OVZLVjRDWkh3SFloQ0RlWnF1UlM4OUcvc1czOHAvcjRRTktxTXJEdmxkMTJZ?=
 =?utf-8?B?V2F2R0ZGVEJIYXJkU0JuWlpsZlJVTTBDYnZQa2NCRHR0emV3SzJQUDJySyt5?=
 =?utf-8?B?d2ZsYmVhUUNQczJwdUMyWjF0NURMZHI1Z2NNODhNanRCSFkyajA0L2dJWnVp?=
 =?utf-8?B?L2l4TEpRNzhnSnk1ZDBEUmpnREEwblVpTjVuNHBzbFgzQmNSclZMVEhSNnRv?=
 =?utf-8?B?QlZGL1ZPY29kSHR1MjMvQ2xxdmd1UWRHMC9lWUs3NDFueS9WejF5UU1iY01w?=
 =?utf-8?B?Mnp6VksxWi9IR05rT2x3Uko4QWIxaTZwelF6Ym9lMEx1cW9JRC95SlI4aVFT?=
 =?utf-8?B?eUtMSmRVQXpVOTVNeTF5MWU0WCtKVXkvbTRFbDUyb3BWcUNabUdFMG9uVWpB?=
 =?utf-8?B?cWE3MXBDamg3WWJDYWttZjd2UEVkdHljVTZwMnAzZ3dCc1E4Y2taTGdILys1?=
 =?utf-8?B?VEErUzFJUGx5OTlzR25DemVXWkpYUnFqL1pFQjIyTDg1N1FvYW9BcDJXNWFU?=
 =?utf-8?B?bXJnTmE2ZU1lWXo5T3dObmJLenh5QU9wM2JlcmZGYVJBN2k1bDQ0QSs1c3Za?=
 =?utf-8?B?elpwa3d0WGEvb3pxakZyRmxsTllFZmNzZGQ1ZVdndDAvVzdXMW9qclhmOFFo?=
 =?utf-8?B?K1pTZDJNWDZuUHFodkl6U2hpVjA5VHY3NXowekh4L250Zy9xTWJYL3ZWaHlY?=
 =?utf-8?B?Zzd2SUhYR3pYTXVjZWRzbjljYXIwVjRoekdxT3FlU25ZL09lakw1QjUvL1Bn?=
 =?utf-8?B?ZzRMdGlaME5YbFpKeVZNbUhaWHE2aEw5ejUyRCswQUhwVXh3ZzlvdDVqbmRr?=
 =?utf-8?B?MXNHdGU3UDV1TmNkVUVyMDl6M3JQSWRVWTdtNlZsRzR2dUwzOVJQbGpvV2pM?=
 =?utf-8?B?b0NCS3ZYdWhwNkpZbHF1S1cycUNUZmlwdjFnb1JsTTZ5cDhYUjhWSmpSdWZK?=
 =?utf-8?B?a0dBdzQzR2htTFVCZVZGemtnU2pmUnpFSnJrbDErYUF1MkZ5WkNWLzJRQ2I3?=
 =?utf-8?B?Y0FqeHBZVG1QZzZBU1I5T1JUMjk0SEt4NFQ5M1VPWlNRVnNhY1ltMG1CSXJF?=
 =?utf-8?B?a1VEaHM1bmxnWWdMVG80U1A5eHorNFR1aVBieWZNQVN5c3Z2YnBWOWZwbkYy?=
 =?utf-8?B?dE9ZTWZCV3MwZ1pLQk5XU0NPa1dEalZaRzhNa0RNL1pQNXA0TWJ5V29tZnFu?=
 =?utf-8?B?cW8yNk9VWmpoMXNJSkdBMGVFRlFHME0zNjEyRGk1blJFTVVuSUxUUzJ3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?czFtVGh6aGFFQ3VGdmdsbUNmMS90OTJFT1pLd1cxd01pb0RwU1J5YVNGNjRm?=
 =?utf-8?B?dFlTcHBjdmV3VGh2THNlZThmZWw0RDVaMHdCZk1ZNFhRdnJ6eGpkY3NGVFJo?=
 =?utf-8?B?TktoYzNEMk5sZk9WWlRxaGYyZHUvNkVESm82amwvWk9rVVlGRlJYSnJ4S29v?=
 =?utf-8?B?NkJLcEZ5QlVCeStxbGxOOWxWeUlTbEc3bmw2Qi9CWmVqOHF2bWVxVWsxVHF1?=
 =?utf-8?B?RnpZWjdEMk1IOVVzNytpcGV4dHA5empHVFF6c3YwZVYxQWlKaFFRZGlHbEto?=
 =?utf-8?B?ekVJbS9FY1VwNWJxNHlWeDBCbXBIQ3RrSEt3N2VQUWRadTBUeCtnSVhFbitJ?=
 =?utf-8?B?WE4zT0d5bWk4WDM3N0NHdXFIOGZ0NHErNGlENkwxY0I1alhZNnI5dTFHOXQ3?=
 =?utf-8?B?cG9wMEloOWFVRjBwMWZ4REExVzJaNnhKZkQ4NUxPblRlL25TSzAzY2hUQlJ3?=
 =?utf-8?B?Tms1ZWF4SUxUY3RzWUIwSUg2ZXhZbjBxZUlxeEZ0ZDZ0S2NGYXhmV2ZHNW4v?=
 =?utf-8?B?dDNhcXRQb0I5clYra0JHeG8zUWJDY1dOOEtlVVpRc2hjS1lZMkxpUkMvaVZG?=
 =?utf-8?B?V2pyMlkrU0xOa0ZMS2UvallOV3dQMVlSaE5ib3pTR0ZGaEhpWUpyOWRsYzBN?=
 =?utf-8?B?VllKZ2o2cWZ2WFlPdy8xZEZ5ekMxaytZRFAzZTgwUXkzcEpTc2xUbEFWUGlP?=
 =?utf-8?B?dUUxcjZKdUJ1eWlZNDNZeWdNSlJxdjVaK1FmYVN5L21WZlBKR3JEazNPTUlY?=
 =?utf-8?B?blRZTFAwYTdHUnNPNVVIZGh0Q1RucG1GL1kzakM2alF4c0FwdlBtRXd0UGQ0?=
 =?utf-8?B?emtpMkRRY3BUS2lONUZUUnNEbmVBT0kyYkxDL21QMWdNUUlTQnNCL20xYlhL?=
 =?utf-8?B?Lyt6Z00ya0hwRHBMaGU4djkxVGYyby8xSXJCUGE4THRnajdlbllDVDhxYlFL?=
 =?utf-8?B?aTVDNUxjSStqcEpzVmZpbmV1V2pQdmViUHd5emRmZEFiLzBjNjdVbnZHQ0Vh?=
 =?utf-8?B?R21Gajh4enk2Q3JjdURIa0IzaERtKzh1cFJCTHlyS2tkRUZpTlRmSG51bFRM?=
 =?utf-8?B?SlVYUHM0aXVMdXVOUmVyS2tsdHJiV2NCU3lKbDYxVzc5OWpQTlplS3F2UFMy?=
 =?utf-8?B?MjBMNVpaQ0dTMkwxNkwvZ2cxK0s0NGhRSUJIVEZIU2IybGp1UmpBVXBYQjFX?=
 =?utf-8?B?cnFKTkdjcmh5OStZQkw5bi9JQ3FjVEgzOElidnRYL2tZamRWd3JvTVY1K2dC?=
 =?utf-8?B?Mks1cnlYVk5zK1krQVZBamlpN0FBTkt6ZHZiOWMzV3dCUUcwMmpCYTErVXpj?=
 =?utf-8?B?T0I3SlVMMEhxSkJmdkJodUN2eE5OREZ5MWUxeFJjNFlMeVd2TlF6OE9qSHVL?=
 =?utf-8?B?M0huL0R2aVZpczUvSVMzY3JjWnV0NlVsb3djYVc4OTRkcTVNb2pBcFFIRHFz?=
 =?utf-8?B?bndzVnZ0Z0k1TzBqaUF6YmhXTElycnY2alpreFBCTzNjc3NtY3RyaXg1R2dk?=
 =?utf-8?B?OXhDSUZxRk5mUmJCQW0xcXVtZUJTdDBoNWtaaUtST2JPWk0reGZjekQ5aVNJ?=
 =?utf-8?B?d29BVG9WU2wrMjl4eUJxOE1YcndSSlRCa09vY1pGZTFOY2tHSDZqZTFCZWZw?=
 =?utf-8?B?SHNheVByR2k4NjFFalo2eTlNTHpvL210Mk5URkltMElTUjlsbkxzY0liRmE0?=
 =?utf-8?B?eDlGM001Yy80MUF4SmY1Sk9RUFVaR3NuTHJXenNPMktLaUtpNVBlY1pUTjRl?=
 =?utf-8?B?cWEzenRzd3VXUnRMR0pQRU9HbUNpcEM1SGlIVmRRSDhpWkZHaGhzdGZ5SDB3?=
 =?utf-8?B?L1dDcWJoZkRrTDVHVmhBUXFCek5ZWWJrNk9nVG55N21aWW03Z1orbzhVc1p0?=
 =?utf-8?B?YTdzMjlGeFlNeDEvYUE0RE1LcXVTdTVVL1NZUXRiR29yWHJ3alJ0eU5jdlhR?=
 =?utf-8?B?b05kRjV4QUhrSy9Rb1o5RkMvaW5Fai9sSnRHS2pZQmJENjNPZkw0T0h0Q01H?=
 =?utf-8?B?TUFCK2duSHJnUVhscnVXRkExdmsvcTVKeU95T0UzbmVrd2QvSVJJR1llSFZW?=
 =?utf-8?B?ek04VEIrcUk4UlNnM1dQYXhTNFI4dkxrckErUzIvSzZxQ0dQNGZUdjVaZHp0?=
 =?utf-8?B?U1J3MmJyQVJkWVJzUXQwbFBic3BNVEJ0U2p0UklRUUxkSGgrcjZxbVNVZkRU?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2XNHiIBAQbW1xt3QkkzogpEf44313dePo9zFzqmIgm3PkOBGf108ygJzrnysmDfeOn582m4nETTWynezkTedv2WfWwswes8g2FCoEeJLvCzJ9sYKv33lFgxc9seB+a1Ls62yACtNUzzuDgxC+urDX4QfjaIA98nWhRVKRzw0S4S/6jstNqVFj//qhzvSfliWSrivHcUfOWgWuSH8MneTs9wYO8kRLWFVxOIhZ6cUVTyJQCHlXA/Qgk9KJwt54tWPHd7W9ibfhZN0JmgZukmZwGzT8zl1acQcPbX3g83MJvnxFsHR5HcjPdyATf9ruZ/DMd6REQgoZ25i481I2hLde82fj91gFf7VmVQyxxilcWasiqDnMAocV7bOYKbOHWZddTisyCzvtncuDSEiW1DXLuL2VZ1vkoExLFXqHLmiOrd/fETmtgRoUx1ai7RCHtpSwpYgzo1+a8hySHANOSMG10j7e3VGbbylgMNLIXMNsPPa/tOpl2Z8lUTVf/Dkdh03QNFQr03MwF9aBcflHDpj6eowguo8Mo30GlTRwUPMW9jNSCxTfT5OWlTArU+djFtCUG8ivxDMI0T9smE80AOKSFI3TwnfCSp7aPLPqGshJBM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80937e34-35dc-468c-5dbd-08dc6b6c1de9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 12:25:28.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIVUrpKYkjCmXEP9H6hm8drW9VRwHqk69enlFv5wi+xHPA/+ZR5qe65lVCTKS8gb5LPAyyBPzKiHpdGxXNd/zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6064
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_08,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030089
X-Proofpoint-GUID: gMDk12nmWJSAOZjMN_0vg0lrZVppL929
X-Proofpoint-ORIG-GUID: gMDk12nmWJSAOZjMN_0vg0lrZVppL929



On 5/3/24 17:37, Qu Wenruo wrote:
> 
> 
> 在 2024/5/3 18:38, Anand Jain 写道:
>> This patch, along with the dependent patches below, adds support for
>> ext4 unwritten file extents as preallocated file extent in btrfs.
>>
>>   btrfs-progs: convert: refactor ext2_create_file_extents add argument 
>> ext2_inode
>>   btrfs-progs: convert: struct blk_iterate_data, add ext2-specific 
>> file inode pointers
>>   btrfs-progs: convert: refactor __btrfs_record_file_extent to add a 
>> prealloc flag
>>
>> The patch is developed with POV of portability with the current
>> e2fsprogs library.
>>
>> Testcase:
>>
>>       $ dd if=/dev/urandom of=/mnt/test/foo bs=4K count=1 conv=fsync 
>> status=none
>>       $ dd if=/dev/urandom of=/mnt/test/foo bs=4K count=2 conv=fsync 
>> seek=1 status=none
>>       $ xfs_io -f -c 'falloc -k 12K 12K' /mnt/test/foo
>>       $ dd if=/dev/zero of=/mnt/test/foo bs=4K count=1 conv=fsync 
>> seek=6 status=none
>>
>>       $ filefrag -v /mnt/test/foo
>>       Filesystem type is: ef53
>>       File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
>>      ext:     logical_offset:        physical_offset: length:   
>> expected: flags:
>>        0:        0..       0:      33280..     33280:      1:
>>        1:        1..       2:      33792..     33793:      2:      33281:
>>        2:        3..       5:      33281..     33283:      3:      
>> 33794: unwritten
>>        3:        6..       6:      33794..     33794:      1:      
>> 33284: last,eof
>>
>>       $ sha256sum /mnt/test/foo
>>       
>> 18619b678a5c207a971a0aa931604f48162e307c57ecdec450d5f095fe9f32c7  
>> /mnt/test/foo
>>
>>     Convert and compare the checksum
>>
>>     Before:
>>
>>       $ filefrag -v /mnt/test/foo
>>       Filesystem type is: 9123683e
>>       File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
>>        ext:     logical_offset:        physical_offset: length:   
>> expected: flags:
>>        0:        0..       0:      33280..     33280:      
>> 1:             shared
>>        1:        1..       2:      33792..     33793:      2:      
>> 33281: shared
>>        2:        3..       6:      33281..     33284:      4:      
>> 33794: last,shared,eof
>>       /mnt/test/foo: 3 extents found
>>
>>       $ sha256sum /mnt/test/foo
>>       
>> 6874a1733e5785682210d69c07f256f684cf5433c7235ed29848b4a4d52030e0  
>> /mnt/test/foo
>>
>>     After:
>>
>>       $ filefrag -v /mnt/test/foo
>>       Filesystem type is: 9123683e
>>       File size of /mnt/test/foo is 28672 (7 blocks of 4096 bytes)
>>      ext:     logical_offset:        physical_offset: length:   
>> expected: flags:
>>        0:        0..       0:      33280..     33280:      
>> 1:             shared
>>        1:        1..       2:      33792..     33793:      2:      
>> 33281: shared
>>        2:        3..       5:      33281..     33283:      3:      
>> 33794: unwritten,shared
>>        3:        6..       6:      33794..     33794:      1:      
>> 33284: last,shared,eof
>>       /mnt/test/foo: 4 extents found
>>
>>       $ sha256sum /mnt/test/foo
>>       
>> 18619b678a5c207a971a0aa931604f48162e307c57ecdec450d5f095fe9f32c7  
>> /mnt/test/foo
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> RFC: Limited tested. Is there a ready file or test case available to
>> exercise the feature?
>>
>>   convert/source-fs.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-
>>   convert/source-fs.h |  1 +
>>   2 files changed, 49 insertions(+), 1 deletion(-)
>>
>> diff --git a/convert/source-fs.c b/convert/source-fs.c
>> index 9039b0e66758..647ea1f29060 100644
>> --- a/convert/source-fs.c
>> +++ b/convert/source-fs.c
>> @@ -239,6 +239,45 @@ fail:
>>       return ret;
>>   }
>> +int find_prealloc(struct blk_iterate_data *data, int index, bool 
>> *prealloc)
> 
> This function is called for every file extent we're going to create.
> I'm not a big fan of doing so many lookup.
> 
> My question is, is this the only way to determine the flag of the data 
> extent?
> 
> My instinct says there should be a straight forward way to determine if 
> a file extent is preallocated or not, just like what we do in our file 
> extent items.


> Thus during the ext2fs_block_iterate2(), there should be some way to 
> tell if a block is preallocated or not.

Unfortunately, the callback doesn't provide the extent flags. Unless,  I 
miss something?

Thx,  Anand


> 
> Thus adding ext4 ML to get some feedback.
> 
> Thanks,
> Qu
> 
>> +{
>> +    ext2_extent_handle_t handle;
>> +    struct ext2fs_extent extent;
>> +
>> +    if (ext2fs_extent_open2(data->ext2_fs, data->ext2_ino,
>> +                data->ext2_inode, &handle)) {
>> +        error("ext2fs_extent_open2 failed, inode %d", data->ext2_ino);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (ext2fs_extent_goto2(handle, 0, index)) {
>> +        error("ext2fs_extent_goto2 failed, inode %d num_blocks %llu",
>> +               data->ext2_ino, data->num_blocks);
>> +        ext2fs_extent_free(handle);
>> +        return -EINVAL;
>> +    }
>> +
>> +    memset(&extent, 0, sizeof(struct ext2fs_extent));
>> +    if (ext2fs_extent_get(handle, EXT2_EXTENT_CURRENT, &extent)) {
>> +        error("ext2fs_extent_get EXT2_EXTENT_CURRENT failed inode %d",
>> +               data->ext2_ino);
>> +        ext2fs_extent_free(handle);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (extent.e_pblk != data->disk_block) {
>> +    error("inode %d index %d found wrong extent e_pblk %llu wanted 
>> disk_block %llu",
>> +               data->ext2_ino, index, extent.e_pblk, data->disk_block);
>> +        ext2fs_extent_free(handle);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (extent.e_flags & EXT2_EXTENT_FLAGS_UNINIT)
>> +        *prealloc = true;
>> +
>> +    return 0;
>> +}
>> +
>>   /*
>>    * Record a file extent in original filesystem into btrfs one.
>>    * The special point is, old disk_block can point to a reserved range.
>> @@ -257,6 +296,7 @@ int record_file_blocks(struct blk_iterate_data *data,
>>       u64 old_disk_bytenr = disk_block * sectorsize;
>>       u64 num_bytes = num_blocks * sectorsize;
>>       u64 cur_off = old_disk_bytenr;
>> +    int index = data->first_block;
>>       /* Hole, pass it to record_file_extent directly */
>>       if (old_disk_bytenr == 0)
>> @@ -276,6 +316,12 @@ int record_file_blocks(struct blk_iterate_data 
>> *data,
>>           u64 extent_num_bytes;
>>           u64 real_disk_bytenr;
>>           u64 cur_len;
>> +        bool prealloc = false;
>> +
>> +        if (find_prealloc(data, index, &prealloc)) {
>> +            data->errcode = -1;
>> +            return -EINVAL;
>> +        }
>>           key.objectid = data->convert_ino;
>>           key.type = BTRFS_EXTENT_DATA_KEY;
>> @@ -317,11 +363,12 @@ int record_file_blocks(struct blk_iterate_data 
>> *data,
>>           ret = btrfs_record_file_extent(data->trans, data->root,
>>                       data->objectid, data->inode, file_pos,
>>                       real_disk_bytenr, cur_len,
>> -                    false);
>> +                    prealloc);
>>           if (ret < 0)
>>               break;
>>           cur_off += cur_len;
>>           file_pos += cur_len;
>> +        index++;
>>           /*
>>            * No need to care about csum
>> diff --git a/convert/source-fs.h b/convert/source-fs.h
>> index 0e71e79eddcc..3922c444de10 100644
>> --- a/convert/source-fs.h
>> +++ b/convert/source-fs.h
>> @@ -156,5 +156,6 @@ int read_disk_extent(struct btrfs_root *root, u64 
>> bytenr,
>>                       u32 num_bytes, char *buffer);
>>   int record_file_blocks(struct blk_iterate_data *data,
>>                     u64 file_block, u64 disk_block, u64 num_blocks);
>> +int find_prealloc(struct blk_iterate_data *data, int index, bool 
>> *prealloc);
>>   #endif

