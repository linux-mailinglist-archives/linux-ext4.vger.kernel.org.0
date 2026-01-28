Return-Path: <linux-ext4+bounces-13367-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLzILNR/eWmexQEAu9opvQ
	(envelope-from <linux-ext4+bounces-13367-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 04:17:40 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 777039C8C3
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 04:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A78383015887
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 03:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4389D32D0F9;
	Wed, 28 Jan 2026 03:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="U0qHotJ2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022113.outbound.protection.outlook.com [52.101.126.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EF52836A6;
	Wed, 28 Jan 2026 03:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570253; cv=fail; b=FP6bMCJg84YhZYILsuzcw3AyVIDteYFNxqjcOIkapokmNTybQl0+WkkAscVYzf5k3EB21evykfeKqWPyX025zor7L8IxZdaC0Sbb/LAmft3BWpt756kBuzlNvEf0Kvca0viqOHtZ32Ana1ZPPu5apzOlJ3cY+7qHmSuKGUtGmRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570253; c=relaxed/simple;
	bh=Ez2IM61JbbNUVYUF0YhYGSWKFKb3AGBoiQ1afW1vhJU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GtzmujMiFtql2iKpiGnPmFZInREZx7XXeQtPqqvoxy7htN7HSRJSvzNyTZrZaZNli+4sLyOzwoA5qcPvf3UoPgvI44TQytEKbEjlG+t+D/9rbeDtRpvDdNpNuqSeuW0TXuy6B0kG0a21eWvZpcGP8iA2ipS4VX0mAuaczYRHSAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=U0qHotJ2; arc=fail smtp.client-ip=52.101.126.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXXehpTFNFCLDNQoRY2dwxXQjkFNmM/d0DFle+sOWFbagXkcVJ9RvSSMJdrvc2SmZTvZP3adNsTJpgexz0JeWqpM/bSknGF8Ens7JeXZMpLqMC22Iz5PDeLGwJcm4U04O3Tz6QdUGJnWh+gppDEhxsezrHVfDFlY7QjkNRu99Nfd24qwqI5ejSQ1L+Ro0fF8ytxZK6Qt7QSLNcv1VqxmC7wgB8vrUbhFjEuTztMOoizNBSH5BkmILZjl7h0ZpryAARkS98hpLrkC8ZGkoHISkVe5K4wK1utyHkWxiV267JRYzcJC5AHGYc8LJajzbJpTDVbQF7xqPotUHF9YSfbkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iSxoqNlyLfzc6FshPqqqyfPQn4af8klPZkTE1XcvSg=;
 b=WsrobA3i0tF1NNJyuTBSHEnmvVhRdanKSJcLXZ1Nu5njktcG/epV59Gk2Bgh5Zuqepw1bewWOPTS5wAxdpe6FH0QeU0hjPRYLY3dMEGqwRiQ7x3Mj6pxVTA/uR7CbCt6wKql+U8KQTAfHC/z0ALM8g2x1/lSNxe257LvBZvAsVMJxd3Y+06zrjcvtcC3cxxjXtclgHpZQOXyX7grWl4XXjg39NpZmloPt1tIBH2conAEu2Rkyd27sC9VOne966blGSJ2pyo3Tmly3dXUUF2Rqlw53nvtgb9e2/9vdEqH54QA5un8tPcbAZiEoM8uhxgv5R/2e+w3Bhidguku4BpToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iSxoqNlyLfzc6FshPqqqyfPQn4af8klPZkTE1XcvSg=;
 b=U0qHotJ2ZEzsZZ3EXFRMqKifJtgWzd5q7rz90VaYZ/atzUxnZQ2+r/jz/ZQcE0o7I5QoYzFdohkkwfijn7saMf07bQDkpzZNBHQ220KLVAY3Ynh2ju5XP4YsrSSq40Q8qYSSgVGXzbIpeg2khUe+eTe3lqq4HzM1J7UWgKrvr+m9X6vZyx3804T0DSQB1incY4i2kLl3nLE8LwmS+RLVF2LZb25b01TxVXtpJqWSTcJXC8VWit3Ojjl7ESMtJhwlp+Z6X6doKIZCQkqHP+l6wLo7Noj6XBHWxua0CRjEsIkV/ni/yYb6A9Bb/WOvHxarVqnYD7/fuMpxwvXR2lW2ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com (2603:1096:400:354::5)
 by SEYPR03MB9587.apcprd03.prod.outlook.com (2603:1096:101:300::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 03:17:26 +0000
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::1939:7c2b:9e87:2c38]) by TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::1939:7c2b:9e87:2c38%6]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 03:17:25 +0000
Message-ID: <464a7026-075e-4420-aa37-63ff63add3c4@amlogic.com>
Date: Wed, 28 Jan 2026 11:16:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: EXT4_I(sbi->s_buddy_cache)->i_state_flags is not
 initialized
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, jianxin.pan@amlogic.com, tuan.zhang@amlogic.com
References: <20260127-origin-dev-v1-1-cafda25e307f@amlogic.com>
 <4p2tihxb3pjmuyetcxb2zuoojhiss35g3zxpkocsma27mavxax@vewd3jr4f3gu>
Content-Language: en-US
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <4p2tihxb3pjmuyetcxb2zuoojhiss35g3zxpkocsma27mavxax@vewd3jr4f3gu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0021.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::18) To TYUPR03MB7232.apcprd03.prod.outlook.com
 (2603:1096:400:354::5)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYUPR03MB7232:EE_|SEYPR03MB9587:EE_
X-MS-Office365-Filtering-Correlation-Id: dd69c63a-3e53-46c9-375c-08de5e1bc27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGp5dzBka0JBbE5vWUM0V1pjRlgrQVN0T29KM1hVeEpUNExDMElPekttcG1s?=
 =?utf-8?B?UzNzTWVhVGU3U0ZSdnl0WUswd1ZHWEhmMXhsaFVvQmRPejE4QUx6MXdTOVVk?=
 =?utf-8?B?eTVGZGlqenZYdHlMSkpNaUJYRUVPQXRLZGhYM0VWU29rSUk3T1Z1NnpYYVVH?=
 =?utf-8?B?cEQ3Mmtlc2dkOTJQUGdCSmNlSDhNeEo5WVVXcExTSVg2U0hyajZTRHl0bEJU?=
 =?utf-8?B?enN5ZzA2enNTL0I0RkJyaDBuZFJNZjVUSEV4VmU0Z0orcmkzK0F4cHBDWDI3?=
 =?utf-8?B?R0xSU2FOSFF2OEtraTBPMTl0V1ZTSGtrTklIeEZOQms4dmRSeThYVXdnVE5Z?=
 =?utf-8?B?TUNHUHA1R081RkFJdVV1b2VmeHJKa1N3dmhKSG1NeDMwRXAwaDZwV0lvVFo2?=
 =?utf-8?B?QXdweExWdncrcmwwbnY3elNnTkRzQlZDOXpxTW4xcjdzK3RqQlpleEVJVnBT?=
 =?utf-8?B?U0krRnVvcXBRQWkxaGQvYmtRUmg0Rk9OSDBRMC9KVVpPUWp0Z0s5SHRFZDdN?=
 =?utf-8?B?bWVHNXZNcXRxaThOVzJtdkR6c3lHSU1pc0pLMk1mazNxTkpPSklUcWhBZ0Vr?=
 =?utf-8?B?QWFlVUlpVTYvNnh6YnFaZ1NTVTljei9CcUNGTGR1QlBQTCtjbmEweTV3VDdX?=
 =?utf-8?B?WUhFZmg5ZHlsYlRvNlgyMEdTTnF3ZENzbUxpMS8vN1ovQmFUQXRnRGNBWUhq?=
 =?utf-8?B?RXF2UXYrTmU0Z2hzMWw4NDU4bWdQb1hmcmJyN3o1eVFaL1lndHlMYzdkODc1?=
 =?utf-8?B?aHBFMlpzOUlkYnFaOUt3TThlN05jSnB0eGdrVWdkYVFVL01tVVNZanpTVUQ1?=
 =?utf-8?B?VlEvWVM1OHNNem9sVnRGUitiQWtNQkZsWlJLRGJpVU8yT0lzK2V2eDUvOFdS?=
 =?utf-8?B?dlZNOEN6NklTWWYvbStGVVd2akVpVzljYy9nMUdrbjFmS2h2WFVYQzN0cWNq?=
 =?utf-8?B?QjRNN2V5dGNXMlpyeTdHOTlGRy9sbjdaWWJLM1ZlTzJiL3g4OVloU3QrMjIv?=
 =?utf-8?B?eUpLdVdHSGhrRjhpTTQ4VkY3bzhSSjFwN0JsQXRmbk4yNXNtdENyUktUMS92?=
 =?utf-8?B?VFNOMkdDNnE4SHp2SDAwVHFLUnNPKytqanFYc1R4Q0hFWnBJWHIxSDUzNmNz?=
 =?utf-8?B?eU1qdy9CWXRyUld0b2Z0SURPMDVLRHRYWFJ3WVlEMzRSWWVGNmdDMEJVTEpH?=
 =?utf-8?B?N2tHaThRSEFsdE12VjBhcjFpWnMrR2pIekx1M3VDZkRzazNRYzhwbEpNV2tw?=
 =?utf-8?B?ZUVhSkVabVFNdjRkcVE1aXdtRTExMGIrZGJCN0VNMy9Uck1kOGt5cGk2YWxy?=
 =?utf-8?B?K1VUL1pzSnkwOEpVbk5wek5LR0NRVWtPY0FDRzU2S0Q4ejlCZ09qZHExR3Bs?=
 =?utf-8?B?b2RYYXFnN05MdTBJYzBuMG9NdC81TUpKNUY1ekZEckY2WDBHaHliSEo4akJM?=
 =?utf-8?B?Um9OVWhsdGRjdkJaeWVsY25uMTVoU3AwTHVDY29hQjIxYXM5VFIzcHN5NHVz?=
 =?utf-8?B?Yk5CSHY4UHNOdCtEMklXVldsZjdqc01wOGxXYktXeEU2ZDRiR2JCeG9pV1Ux?=
 =?utf-8?B?OE85MVpXdlhSZFFjSFQzRnVZMXVmSkYxcVRqaE1rWEVvZEt1enBHOWxZUHRa?=
 =?utf-8?B?aE81bWI0bGU0SngrMW1ML2plalpsUXBBZ1ovZmp2dWVVbnp0Vmt2R3NzWTlC?=
 =?utf-8?B?RW5yRFBLSFNTU0V3MjhvU1JLcklvTGI2eUJpVk1sTnY5enJjUTJNN0VKOGtV?=
 =?utf-8?B?bzVoK1RpcUJwWjNYNXBXTUk5Rzh6YnRCTURHN0ZkUlNWTlhpcmZlQVlzRnhS?=
 =?utf-8?B?UEpPaDdCcUQ0dDJWTHQ4UnpXckpVdjF3SHRoOGVtWkVyQkVnZU5sZVlWSlVE?=
 =?utf-8?B?SDFFK292bVZkbzB1SG9YRjQ4T1hCMUgzbEwvUHFIWkxWaDAyaERpQVpEZUJw?=
 =?utf-8?B?VUpOeEJ4akJIN01zRUM5SVFJRmFVdkYyU2g2QVlndjNzMWpUbE1GUmprb2F0?=
 =?utf-8?B?b1dOUjRyZThVVkx3N2ZJbU00Z29ZWEo2aTBYNTM2RXltd3lzNmdESFpocm5K?=
 =?utf-8?B?SEFBZy9Td2VTcTF3TmFWbU8xR05NZlhHYXkxR1RNYUxHOWNqQWZSTmEwMy93?=
 =?utf-8?Q?GMPg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR03MB7232.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGtZYzVVTnNWWEh5dmNnR2RmV1JNNHUxbGZNandnelZ2Wm8xTkE4SVFwNTNm?=
 =?utf-8?B?d1B1STRDbTFhL2E5WHRObFl0MHNuTXVSTDFxOWt3bmZVR3JuR2RUWkJkTVh3?=
 =?utf-8?B?dXVLUU5pbW9LVkFMTExLZCtaV3Y5V2tsRXF0SURGckM5cmsxV3hCK1doRDNz?=
 =?utf-8?B?SDJ4clcwZkxLaGlCWkEybFdYVVdlQ3pnZHhKZkpOWGNuMzFTYTZpSVRtbC9V?=
 =?utf-8?B?UDI3SVI4OFpyQ3lTMGp0NDVrYXAyVlU5R2xYRDN2MHppU3NBNDExNitQM0E1?=
 =?utf-8?B?eVpVSHRGQlYyTHJsQVh6WGxRTnFEbnZpV0NwVXFGZjc1QjJqY28ycmZKUFdR?=
 =?utf-8?B?NWE0QnhvRkFSdm9Xa0xkSDRINnpCWXFDTEhEaWlvWEZlOTIwOFhUaGlacWxM?=
 =?utf-8?B?bkpBaUxnWFk0SG5EWGZhRGxydDl4THNocnNXREY4YXFWcXRHK29vSm9jZzNC?=
 =?utf-8?B?Vnp2UUIwZmcxb21BYUxqSWkzdmZpZndqZG1hYyttWXFqZnZDUVlHaDZRM3RW?=
 =?utf-8?B?eHo3eHpheUJ6bWdTVkVTRTdJbnZqSkZXMmVYWnk3TVRyNTBSOEVDUDNad1hk?=
 =?utf-8?B?L0RuV2FCVmxJZVJ2NklPekdvQ3NyVE1CK2hLRzI1ODBaZW5KUlJUbmszRXZE?=
 =?utf-8?B?QVdrTzNrekFUNDk0eGduWGdzbGt0OTB1bm8wM0NyVjJ0UUVSWHVnK1pxem5T?=
 =?utf-8?B?MnZZd2RwSTRlTDN3NDl1S1BFVCtvVjkwN0IxTElSZVdTTkhSb1BBRzhmcHFn?=
 =?utf-8?B?cGZUSm1mNG5xUDRjQ0dVSEwwdzZxazl1VXZSeVJYTi81Nnd5dFRqQWMrdllB?=
 =?utf-8?B?WElPMzBvRkV4b1BWNUpaRWtPSFY1d1BCV0xPVVFpVVZJblpqbllIdWdyT2N1?=
 =?utf-8?B?aCthcDV6eXpZakhORGFEN3RvRUJvUTRjNUhTS1lwajJQRHRwb0RIOWNxbHM4?=
 =?utf-8?B?U01yYlJTdHZKeVIzUnFaeWJTUzNkVlpzMzRaT0cycURXWjJJaGU3ZHVwN2Vl?=
 =?utf-8?B?KzYxT093N3RNcWszNUlZKzc0a1ByVmE5VC8rVFZ4NXVyeURXTnVOYi9hdm1G?=
 =?utf-8?B?U3o3OE5WcFdCNE1pS0NxdzFsa1FWa29WeHc2ODRhTUV1amwyamVDQnZpTW43?=
 =?utf-8?B?ZDAxQnh1NFFBV3hmQzNvWWw1QXhJL2pVL2N0eGZBcldIRU01MlVIV21tODFN?=
 =?utf-8?B?YW1OUnVtK1g3d0pkWTdZcWNoa1FidVBITGV3dlJnKzA0ZXlsQTM4NHlMNWsz?=
 =?utf-8?B?N2ZZam8vTTZMNEVRbjh0ZlhtNmxxYmQxV000MGJNcG16ZHhKbUpGSUxIOXIz?=
 =?utf-8?B?aGpRc1NSQ2R2R3FSSzRPNGVvTTN1OGp1NXVDRnJjNmJ6b0RaTFhkd2RuZXhV?=
 =?utf-8?B?R0ZIWnE3ZHJlS3hiTjVhS1hoR2h1cGVzRTdDQnhtL0hvbVJ2NlpYb0RoelQw?=
 =?utf-8?B?emd1K0dJY3lETG82amNpeEttTmhiU1liTkdUNDFSczlMUTZaU3RRL05aL3ZG?=
 =?utf-8?B?QkYxMU5pYytFOG4vK3FZRHRLdWpJcWUrVXRNbnNCbERTZ2VuWlZ0N1dXZG9U?=
 =?utf-8?B?QUErZHpxaDQ0VjNtcHdDTE1LazJtTTFOZzcybVl5RDVoampPSUU5Yys5VldF?=
 =?utf-8?B?UUxuaGJjMW1ERWQ0Ui9PbW1vbFpxdXdzZU50YWRCVkJBU3EvN3ZWRnBDc3gz?=
 =?utf-8?B?S0d3a2lFN3BKTmthaVFYWE9LdzVUZHVFZjQwQTlpVm0zQU51UEJ2M1c5SUpL?=
 =?utf-8?B?U0cra3Q5UWZycWsweDJJbmYwbTlEbDRyb2hIcGM3dS9GYVJtSnk1QXhvemZ0?=
 =?utf-8?B?bHZiazNNQlJJMVRJd3ljN2JRQlBrdXl6WVpHbkR2RFVmZmREUTk0MWY2Mkwx?=
 =?utf-8?B?V2pIZmtiL281cFBhTUZIVGk4bUUyckFPNE11dzdyZW5TZ2RiL3NzWTFmSlpq?=
 =?utf-8?B?WG1Ra0MyZWlEMWx0akM1Y2VZQVo5b1NMZ05uOVhoOEFwZFZTenE1cGdSaHVH?=
 =?utf-8?B?cEhudnBWeDJrK1REeDQxL0FZdE1GVTc0aDQrVHlQb0FxYTI3UmhLdE1XVnNy?=
 =?utf-8?B?bzlUOHFhVS84QlJ6ak1NbU16RUM1TW8yZ0N1czFyem00ZEY2bmpwK0w0ck9s?=
 =?utf-8?B?dkYrOXJFeDUvWjlUdFBSOEd6RUlubTZvRGNYN3BTc2xxWkZ6SkJWOTJUbkUz?=
 =?utf-8?B?bDV3UlVtKzJic3lNSG43SmsvWk9xMUl4RkJJWHlJN3BGNHBOa2lLWE0yVDB3?=
 =?utf-8?B?dTFqRUtCdXVPUFVQdkN3amVGYTgrbUhCWGM2TE5DUnM0cVlVWkw5V05uS1VR?=
 =?utf-8?B?ZGVJM2tmMS9Db1ZzQXR3QS9ueE5HTXhwOFhNdnZGYThjTk90WVIwUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd69c63a-3e53-46c9-375c-08de5e1bc27f
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7232.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 03:17:25.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxmoaMVy49G5KFsnW4imVQwTOcp54hcXS5finyOKMKiVHphii2ZD9wVvkwN1baDeiC+Buyk37GF7EVwbKkADpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB9587
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amlogic.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13367-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiucheng.xu@amlogic.com,linux-ext4@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amlogic.com:email,amlogic.com:dkim,amlogic.com:mid,suse.cz:email]
X-Rspamd-Queue-Id: 777039C8C3
X-Rspamd-Action: no action


On 1/27/2026 9:28 PM, Jan Kara wrote:
> [You don't often get email from jack@suse.cz. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> [ EXTERNAL EMAIL ]
> 
> On Tue 27-01-26 17:34:10, Jiucheng Xu via B4 Relay wrote:
>> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
>>
>> The i_state_flags originates from an inode that was previously
>> destroyed and then allocated to s_buddy_cache; it requires
>> reinitialization.
>>
>> The relevant log during umount is shown below:
>>
>> EXT4-fs (mmcblk0p28): unmounting filesystem xxx-xxx
>> EXT4-fs (mmcblk0p28): Inode 1 (39878178): inode tracked as orphan!
>> 39878178: 1411f3c7 e0182705 78cc454d ac11f000  .....'..ME.x....
>> da10433b: 1a2e0146 792e03d0 9c2a04d1 0c788ad3  F......y..*...x.
>> a91573cf: 44270388 4f4202ea 721a12ea 340cbce0  ..'D..BO...r...4
>> 89cb2f37: 0d13f000 4f270414 1a0b01f0 4f880fe0  ......'O.......O
>> 810e3bc2: 3f0c02f0 482b0009 02e048d0 83f43f2a  ...?..+H.H..*?..
>> 3f37c9f7: 02880aaf 00000000 00000000 00000000  ................
>>
>> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> Thanks for the patch but this should be fixed since commit 4091c8206cfd
> ("ext4: clear i_state_flags when alloc inode"). Can you confirm you cannot
> reproduce the issue with the latest upstream kernel?
> 
>                                                                  Honza
> 
Thanks a lot, Honza! My Android device does not support booting with the 
latest upstream kernel. It runs 6.12.58, which doesn't include commit 
4091c8206cfd. I'm certain this patch will resolve my issue.. Thanks again!

>> ---
>>   fs/ext4/mballoc.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index dbc82b65f810fed89da7fa7149d3a05de6f107d6..20b07b2bea31ea81ffbd0b4ace3a7b218c8f4dd5 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -3521,6 +3521,9 @@ static int ext4_mb_init_backend(struct super_block *sb)
>>        sbi->s_buddy_cache->i_ino = EXT4_BAD_INO;
>>        EXT4_I(sbi->s_buddy_cache)->i_disksize = 0;
>>        ext4_set_inode_mapping_order(sbi->s_buddy_cache);
>> +#if (BITS_PER_LONG < 64)
>> +     ext4_clear_state_flags(EXT4_I(sbi->s_buddy_cache));
>> +#endif
>>
>>        for (i = 0; i < ngroups; i++) {
>>                cond_resched();
>>
>> ---
>> base-commit: 4f5e8e6f012349a107531b02eed5b5ace6181449
>> change-id: 20260126-origin-dev-9f84135b9555
>>
>> Best regards,
>> --
>> Jiucheng Xu <jiucheng.xu@amlogic.com>
>>
>>
>>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


