Return-Path: <linux-ext4+bounces-2220-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663358B448B
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Apr 2024 08:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C521C2277D
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Apr 2024 06:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2F23399B;
	Sat, 27 Apr 2024 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=whamcloud.com header.i=@whamcloud.com header.b="oSOq8Q0K"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82F28BFA
	for <linux-ext4@vger.kernel.org>; Sat, 27 Apr 2024 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714199764; cv=fail; b=oNBalLI+q5WUf5FQfGcWU/uW9oH/CzMVb5k4rdej1SUjBAlR9nNCBIJXIUoxD3N9lOuJe7Nj+uA3lW9PU+n+mmWBeVuENbcCuhc/i7c99NQZI+wpmw+EaJ/mGix6GC6iZICCu69oOsVYgAE78Oofb27dbXKnjkWEx/AJTbCWhjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714199764; c=relaxed/simple;
	bh=OHlIk8fmzeg78d17HsFnz2ZvfK0Bmu0W6Bit0ofOIW0=;
	h=Date:From:To:Subject:Message-ID:Content-Type:MIME-Version; b=FPD94FsjhRXokQW3o2f26lmKnJkkiCg0n3rHRXMjLwzab5f8cUUBpdw80yQLdDmG+sNxjQPDf5zUouaQH+TWvq+URlAjerbOoD67q0ZIOkFAjyqmWCPSefKWYbtczsKKgAZqyaw9Y5L1cQtgvq8I5dz7JQBm+VOSEql60tvXNk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=whamcloud.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=whamcloud.com header.i=@whamcloud.com header.b=oSOq8Q0K; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=whamcloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101]) by mx-outbound10-6.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 27 Apr 2024 06:35:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eI2nZZB48SWbmRCl/QEqu11tyH0dXzQfJuQFjRU0vK2PwDl+6b7DGkMxJaxc+GiGk8WwinQavUCnn4syhwLiV2ViQBawEc3nXS8hoSxpkLcJ3a/E5Ie6S2LwLlM40oZkAtr4mz9yj0blNoyxBWS7qIbpMEwE0pmf28DdJEqZKjYKNgt8s1LWloh70TuwrmiBWkPPuvyasFeJN7o+8uf3L2en70VVddQJJ+2+WXPbfiqjDcIY838nM6uZ5oll/gKX9ZDPyD5quZdAq53vadwh1p3rxQ3INWFwd+27iVn1BxuQ7FPjl9SeoKJwkJl7P5OCeg9t9LEc7Pc3aQU+vKe+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYQJ9kUsuaTS7H4B3ZkUj47DfzONrgYrSa0k7rbLv64=;
 b=HIbv4BFdn2Hs5qYhaIYcUoKl1NNJWKV+VFq4/Q8QUfsYyrWJMXrW4B7Uzf80Rj/Cb99D2Tgc1lARyExTx5JzXYnDgsca+tUbLzNnSjg7/9gMZ31XpK/gk1PC+bogVEawmOjRhkPWJhJHwhv603b0sx71lPcvzx04VO1BZqH4vMGY7wDH16bNQgQPywxjp9GIKkVDYPWPyjte5bsN/KEf3z22O8QZcemM/L6iaMRiz0QEyDzR/RTuLU/qwIb4wiZlfV7CERZcC22juqdz6TAZVtrcDW2tQadXaid4Q72CHPnWXGJcJY5V+dTN1hWT6Li1oHD/jLpu5iWaWnbevWGJ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=whamcloud.com;
 dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYQJ9kUsuaTS7H4B3ZkUj47DfzONrgYrSa0k7rbLv64=;
 b=oSOq8Q0KESjaLVAdlBNYY81XxHtrQ9HXXR5xdK/7JWGuZ+7B1cDZTN0KxWac/GOY0SOsGEAI4gkvObOYu+cSxEev7GgDGYkUGTaBkJxBF/Mm8mblsqp4E4Me2l5nov0O6Kv0EmmExo2fI/Su3hL34ssIYtHjptRaw0it812YGCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=whamcloud.com;
Received: from DM4PR19MB5835.namprd19.prod.outlook.com (2603:10b6:8:66::17) by
 DM4PR19MB5980.namprd19.prod.outlook.com (2603:10b6:8:6c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Sat, 27 Apr 2024 06:35:49 +0000
Received: from DM4PR19MB5835.namprd19.prod.outlook.com
 ([fe80::bbd1:7a5b:d8c3:4a8]) by DM4PR19MB5835.namprd19.prod.outlook.com
 ([fe80::bbd1:7a5b:d8c3:4a8%4]) with mapi id 15.20.7472.045; Sat, 27 Apr 2024
 06:35:49 +0000
Date: Sat, 27 Apr 2024 09:35:41 +0300
From: Alexey Zhuravlev <bzzz@whamcloud.com>
To: linux-ext4@vger.kernel.org
Subject: merge extent blocks when possible
Message-ID: <20240427093541.77f14d8b@x390.bzzz77.ru>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: GVYP280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::16) To DM4PR19MB5835.namprd19.prod.outlook.com
 (2603:10b6:8:66::17)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR19MB5835:EE_|DM4PR19MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3bbd35-1f35-421a-c134-08dc668446d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzBzeEN5a2FQejI4NGlaRUp2ZnF1OFgydGMzMFhQa0Fjb2NVVE8zNXh1UEYr?=
 =?utf-8?B?c0JsVVV3RDdPZUNtTFhZa24yTHNqMUo4U3Q2UktienhSRWFoWXRSdGJUZWJO?=
 =?utf-8?B?WWdKeThkc3FsZ3Z0ekVaejlyRHFZQ2ZTa3RmdmpDSnJTc2FaWDNoQmd6enly?=
 =?utf-8?B?WEZTSEZCOE83MGZSdCtIMHBJb0RveUNFQXdXNnNNTzVaMHhXQ3d4akVteUhh?=
 =?utf-8?B?UEJvL1IycWdTQXJmM3lsVmpKcGRlLzNxaWFTSzRXeXNobzVaU1dpcDZHVGx2?=
 =?utf-8?B?V2k4bC9VRGsyT2s5M0JPNjNWZUJzZmdobXV6TDVKRERTQkRaczI1YktPRTRy?=
 =?utf-8?B?c1BFNDRRMkF0Q0RJZm5PdHJacEZQVCs4Vy9sZkpGcEw1VFA1OU1vUlQ4Y1hr?=
 =?utf-8?B?QkU4bVMweUFQTXAveFpreXdybTB3N3pDeWl0MlVpbXVkcDRkZGQxZGZnZ1hR?=
 =?utf-8?B?MnF5ejM3eTNKVlhKMVhJQjRjc2RreC8zZmVYVEFXTmZpaGl1eFMydjBtbHVX?=
 =?utf-8?B?UFU3Y3JKemxwMFJHNDR3Qmp4TktvRVBFK1VucWNFMXlLQ05sWXNZejUvaU9P?=
 =?utf-8?B?RHlySzFhTGd2MVBXT1RLZEtWM1NhOUFsQWcxZlZ3MDlOMnR0TXpoY0s5MFVQ?=
 =?utf-8?B?RHRYVlVURWYwZ0o1UWhOcytaMFNIbFBsbkV0ZmRscnRLaVhkdTlDRzRITG93?=
 =?utf-8?B?bEFvTGt4WTFnaFpOL2lFWklQbXk1dHdpbDE0ZTAyN3F1TFpTYnF2ZUg2VUdR?=
 =?utf-8?B?akxEZ0N3UElERzd6aWFmUTZlL09EVnZhZTNtSVJ2Y29hUjNUSTVnWEpwMy94?=
 =?utf-8?B?R1Y3cUdGT1RSdEZhVFpwSW90MFk1bkJGcHFnb3BFN0dCcVJCZ1ErNGRZZk9L?=
 =?utf-8?B?UWtWVGxlK1BDTjE4TFREOTZscitRTTJWRi9YSE5PM1ZzZUE0YTV4M01vaFRk?=
 =?utf-8?B?a2xIQjk2SXUwYmtEcmczaXIvY0xRbHBQYTFlcWRzWGFiKzZNOHlpeGNGUlpF?=
 =?utf-8?B?RWdvM3p6aU92Tk5pL1NzVmhPVXE5QWxpQURDQ2VjWG1oY2NlZldxT1lyOGZ1?=
 =?utf-8?B?Rjk0eThpYXJ1SHhxZzRoaVVmS21iUDVidWFDazZYSlg1aFZ1a0Z5L3p2VDdW?=
 =?utf-8?B?amJSL3AwZCtsSWUwd1JzbG5hZU5mM09VOXgxSzMrN3RiSHgrZmFQR2xwcjc2?=
 =?utf-8?B?NlFWMlVQL2prNlMzeUJ0VWFxcWwrYy9hNE9aaUdrNzRLVi9yNlRaVm90QUs2?=
 =?utf-8?B?WWcyMFpRZWVKZyt0eDNQa1F6QzBkeVY1eGllZ0dwOUROcUgzS1Z4YU9LYTdY?=
 =?utf-8?B?ZmY2bjRwYkJOYkphS2IxMmx3ZWxYK1Q2bVJzOG9ya2NIQUZSYU4zaTNmNEFB?=
 =?utf-8?B?OVFGRjNJeVlIN3l4ZUE4ZDJ4L2hQdks1STFhS2RWUUlLeUNQanJzd2xXNnJW?=
 =?utf-8?B?aGZTMkhFeGpXS3BFUC9zTXZobVg3N0FnMVExUWdsNHdlaTc0RkE3Z1l1bXls?=
 =?utf-8?B?TmFHR0RHWlNiTFlKT20vWGFlUjIya2pKOVpaSHpKRm5Cejdobm43d3d1S2lG?=
 =?utf-8?B?ak9KK0xHYzBoUW1hcmo5dERUQUlRcFBiMXkzeWFSSkNnMjdIVi83TDcvWTlx?=
 =?utf-8?B?VmNXa3dOdmxDZmhiU1JuNm1UTVlONDlVc1lkcWppMWg0MGVKQ3dQQmhnVVp6?=
 =?utf-8?B?V2FnY3dnci9Dc3h1YjFBdEdyYnlQT04vNys4anh4Um1IbjNMUGU1Z1d3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR19MB5835.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUkzZGRHeFRSRStSSkt5UGQydjd3dFVaZzFrVVlGanMyVEMySFA1UHVFQzJW?=
 =?utf-8?B?OWJZWEVtelErcjcxcTl5SlVvZGVlcUFTY0Z0SDJ5Z0pRdVF1MTFHUzRnM05E?=
 =?utf-8?B?eUlUQ080SDVpVEVuc2NFK0p1ZmZVOXUrTENBeEhDemc5RWpXMEhvY1A0ZVZz?=
 =?utf-8?B?Z0NldEQwdE43elhJa1JabE8vRURKNnB6OGZ6S09PWG5PblVZaGpuOUgwSlZQ?=
 =?utf-8?B?SXRFU1F6L1IxRHEwWmxsbkNsdS9WWndiZXdobWVWbWIvcVptQ0llQStBT0NY?=
 =?utf-8?B?OERweVB2TnowT292ZEFiWWVhUUV4QUZ0RkpFZ09YajAvNTNPYWFwUHEyaS9H?=
 =?utf-8?B?NGxmcE15STRMeURaekM4dVJhakJ6UURuRzUwemMyQ3BiN2FWVnFRL0l2RlVi?=
 =?utf-8?B?d2RtTnVDK3VVNzVIMVFXeTlUUEx5aHNCSEYybklETUZhdGdOWUV0QnNzajRV?=
 =?utf-8?B?c0tpRWtkc0xHWi9QSjJtV3U1d2RoZXg3cjQrNFpIcktvSVBtbnh0ZFhBU0hu?=
 =?utf-8?B?cThmMmRiSHJpNnhSOVgyRENWc2p4WVd4T2Z3OTNoWGpUb2lySXNrZVEySEtK?=
 =?utf-8?B?bWZNSVNOd0pYNlF5enhrYnF0ejZLMXU4OFFkOU90bzBSajU0ayswNS9XTmhq?=
 =?utf-8?B?Njk4U1ZIU20zUGM1WVhCNVNDTUJJVSs4TVRhTnNWQlkrOVVGSG82M2lJOGFy?=
 =?utf-8?B?Qk5VelB5VklnYWRhQWYyNmVlckczMURTVStCQ0tNWDRlRVh5SGpLcnE5cFNi?=
 =?utf-8?B?dXhha21FcVBBZktBTVpIVEJQcnREVFlIQmFCM014WmVtdk5kLzRYU2d3aExI?=
 =?utf-8?B?azN2RGhCVjRIQnEvdncybzZsVjk0cGtNZmJjWUJ4bkZTTWRjallXQ1VMUjZt?=
 =?utf-8?B?Nmc1ZFpnNU0zSno0cU9CQlQ2SUJuOFhwSENIL3dFODdPWmNOMWg5ZXh6UXd6?=
 =?utf-8?B?RlpQdlFmSGhRRmdpT3VqV3JXQW5QMXlPTEUyQzZzdEMraFduNkhzS0crUk9I?=
 =?utf-8?B?aUx3cUw4amdZbjlWL3U5TkowOUlGd014bHdndTN6b2VuMnNsaWNUK3R1b240?=
 =?utf-8?B?QzRKTU0yZitVUER1R05MZGhTTEFtSEcvZFpqZzk1NDlVOVNlemw5UVZFY1Jz?=
 =?utf-8?B?Zk9ONHIrdGlSR2s3RFQzb1NaNW1vWEt0WittNG1iQVk0b3ZKYkFBQ1VxTGhB?=
 =?utf-8?B?N3NEZTY4eHAzc09JRll1NkM1YjRkbDJockV2d1c4MEN1VHBvVFNPZ1JWRTc1?=
 =?utf-8?B?a2lydnBYYTVXUXZKbkNvRTZLQ3IvUG1JbW9wMU1BcmZzSm9xdUZ4OXBVSzhF?=
 =?utf-8?B?ajFJRjY4TjBQaUFmbVpwZmhQQVZEcmhpV3lxVU1DWE1DYUtvTzF3ZFh1TFM4?=
 =?utf-8?B?V0pMamRmM1JGOHRnYWZjTTVqOHoya01VSEZRcUVNcmlNeXZ4TmlCRWJUV0Np?=
 =?utf-8?B?amY4aitBNTBGRlZLUTdaTnBaN0ZYM2R5UGpaVWxXWENSYXdWVUowbWdDVnV1?=
 =?utf-8?B?bFRRQ0tWMEJBcDFCODk2Ni9jK0xkSWJNck5FSFFEQTdiY2NtN0RyN3ZNUzBZ?=
 =?utf-8?B?WlRtd0ptb05LTkY1S2hqMVQvVks1RTk0R0dKMVBvQ3Q4SDVtQ3hLRnBhM1RH?=
 =?utf-8?B?MTVaS1FnNjhHQUhNZzhYVkZCRDNFVHBzbHhIaE93aDE1ZXNORXlTU1poeEFu?=
 =?utf-8?B?Mm5BOTdBUko3YWF0N2ZrTkgweS90cHkvM0EwRmpCK0RTd1V5WGorWGJNV2ZV?=
 =?utf-8?B?NDdxdHNPR2Zlc295NnVBay9VdHBIbUtYVlZWWFZVemlRMUthWklZQ3dMeEpL?=
 =?utf-8?B?cFh3aVpZTzJ6RXZqSDlrZG9XZWdRRWJRRnpIWmJEN242Q3NrR1AzYnJXSDI2?=
 =?utf-8?B?cXJzVVVvSDJjUzg3emlnbFVKdXdrTTE4UHl5Ylh4VisyTkxqMGpia2ZjTEdz?=
 =?utf-8?B?OFBUM01JbkZ4QjV0dGpDakp6ZElRMWNsOVROdzMvRlQzWldkU3ZGM3NQcnVs?=
 =?utf-8?B?cVhDUTlrNmFoK1FvRW9TYTFCeU44NWNSZXNFWnpJN0FNeWhGKzd3UzFwSHZZ?=
 =?utf-8?B?eGdhNVNEeUkxbjhBbTg0a0xVQ0ZLR3o2RVJzdzl0TitaUVdVZkJVRVpmNmZo?=
 =?utf-8?Q?w/3T6ymCXeZIbveaQYtOojIQW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eG/c7CifCiDGZ/d/1Glmj4x+pbytjXOWSpLHleNIJwClhPYDdbbw2AOzTgQcSCQ6CNTler1l4rMxV+5cjSuik27w6BtriJb1gRPtWhCkQxnz3yi4IlKWdBsyRvpYCTEjKkw1GflBCq5gFfsb48hRbcrtXBFUwiZCunlQH+QDzDIhym0ocZwSpC9cffd0r2iKES3Fb4d2llG1UpIHupimvtbE6/WLj1mPX4N5L+oOSiYFs+EazrKvq6YBnnxNXIE0aBbG1jbB8B2JwbCZjt0YuaEeetCtI9YtPyM1jCbO35PbAwhzzPZS7yKg5UjY23KELhlZH6j8Mfhp18HSdCiNn+RsijnjswW0pJHjQAxhRAoSeArXhKRcAbBS2fKqo2fPNCfyNOjdAjXZVj8oBtYfhTOSdoyKEtedBerawRdXEGB2rRFqQhCP5n1voW5bcOqhYHBpZEyo+jf0wAfXCxIoIcz2hKoOZVbaJNmaWq5+rvT1yTS5MnwjKQZ6NOg+9YRwR2IM/3Px/3iDXUtYErPiEO5lIkT6Ks5mc+qD1JqRkNYCvx6bR5Swu8q49a2415J+MjSbgciIfFCuocGyVh9B2FEs0OSsKpRVJg8spHDfbjCan3p+ST93kHRlxwepXu1D0Aiij9JDQhQvMoRzMBNlGWh2FZhqkwG0UDOSZiTWyy8=
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3bbd35-1f35-421a-c134-08dc668446d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR19MB5835.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 06:35:49.1409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQUnMkFA5ZOR+9CJbTU+tNWJ+Q3UZZMPE+6lUq8VTzMLsqQuVfAn1m0La6qJ9+BUVheEjuSQ5MflSkUHUZO6Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB5980
X-BESS-ID: 1714199753-102566-12631-81649-1
X-BESS-VER: 2019.1_20240424.2033
X-BESS-Apparent-Source-IP: 104.47.70.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGBgamQGYGUNTMMMXQNC05LT
	Ep0TAxyTLZ2Cw5KS3F3MjC0tLALNkoVak2FgCe9wU1QgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.255853 [from 
	cloudscan11-205.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1


Hi,

Please, consider for inclusion the patch attempting to handle the problem w=
ith deep extent tree.

Thanks, Alex

From 0dd791c266e2d00c3217d0f1b836abdbfd4f146f Mon Sep 17 00:00:00 2001
From: Alex Zhuravlev <bzzz@whamcloud.com>
Date: Wed, 19 Jul 2023 21:22:20 +0300
Subject: [PATCH 1/2] In some cases when a lot of extents are created initia=
lly
 by sparse file writes, they get merged over time, but there is no way to
 merge blocks in different indexes.
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

For example, if a file is written synchronously, all even blocks first, the=
n odd blocks.
The resulting extents tree looks like the following in "debugfs stat" outpu=
t, often
with only a single block in each index/leaf:

   EXTENTS:
   (ETB0):33796
   (ETB1):33795
   (0-677):2588672-2589349
   (ETB1):2590753
   (678):2589350
   (ETB1):2590720
   (679-1357):2589351-2590029
   (ETB1):2590752
   (1358):2590030
   (ETB1):2590721
   (1359-2037):2590031-2590709
   (ETB1):2590751
   (2038):2590710
   (ETB1):2590722
   :
   :

With the patch applied the index and lead blocks are properly merged (0.6% =
slower
under this random sync write workload, but later read IOPS are greatly redu=
ced):

   EXTENTS:
   (ETB0):33796
   (ETB1):2590736
   (0-2047):2588672-2590719
   (2048-11999):2592768-2602719

Originally the problem was hit with a real application operating on huge da=
tasets and with just
27371 extents "inode has invalid extent depth: 6=E2=80=9D problem occurred.
With the patch applied the application succeeded having finally 73637 in 3-=
level tree.

Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
---
 fs/ext4/extents.c     | 185 ++++++++++++++++++++++++++++++++++++++++--
 fs/jbd2/transaction.c |   1 +
 2 files changed, 180 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e57054bdc5fd..a2de6b863df1 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1885,7 +1885,7 @@ static void ext4_ext_try_to_merge_up(handle_t *handle=
,
  * This function tries to merge the @ex extent to neighbours in the tree, =
then
  * tries to collapse the extent tree into the inode.
  */
-static void ext4_ext_try_to_merge(handle_t *handle,
+static int ext4_ext_try_to_merge(handle_t *handle,
 				  struct inode *inode,
 				  struct ext4_ext_path *path,
 				  struct ext4_extent *ex)
@@ -1902,9 +1902,178 @@ static void ext4_ext_try_to_merge(handle_t *handle,
 		merge_done =3D ext4_ext_try_to_merge_right(inode, path, ex - 1);
=20
 	if (!merge_done)
-		(void) ext4_ext_try_to_merge_right(inode, path, ex);
+		merge_done =3D ext4_ext_try_to_merge_right(inode, path, ex);
=20
 	ext4_ext_try_to_merge_up(handle, inode, path);
+
+	return merge_done;
+}
+
+/*
+ * This function tries to merge blocks from @path into @npath
+ */
+static int ext4_ext_merge_blocks(handle_t *handle,
+				struct inode *inode,
+				struct ext4_ext_path *path,
+				struct ext4_ext_path *npath)
+{
+	unsigned int depth =3D ext_depth(inode);
+	int used, nused, free, i, k, err;
+	ext4_fsblk_t next;
+
+	if (path[depth].p_hdr =3D=3D npath[depth].p_hdr)
+		return 0;
+
+	used =3D le16_to_cpu(path[depth].p_hdr->eh_entries);
+	free =3D le16_to_cpu(npath[depth].p_hdr->eh_max) -
+		le16_to_cpu(npath[depth].p_hdr->eh_entries);
+	if (free < used)
+		return 0;
+
+	err =3D ext4_ext_get_access(handle, inode, path + depth);
+	if (err)
+		return err;
+	err =3D ext4_ext_get_access(handle, inode, npath + depth);
+	if (err)
+		return err;
+
+	/* move entries from the current leave to the next one */
+	nused =3D le16_to_cpu(npath[depth].p_hdr->eh_entries);
+	memmove(EXT_FIRST_EXTENT(npath[depth].p_hdr) + used,
+		EXT_FIRST_EXTENT(npath[depth].p_hdr),
+		nused * sizeof(struct ext4_extent));
+	memcpy(EXT_FIRST_EXTENT(npath[depth].p_hdr),
+		EXT_FIRST_EXTENT(path[depth].p_hdr),
+		used * sizeof(struct ext4_extent));
+	le16_add_cpu(&npath[depth].p_hdr->eh_entries, used);
+	le16_add_cpu(&path[depth].p_hdr->eh_entries, -used);
+	ext4_ext_try_to_merge_right(inode, npath,
+					EXT_FIRST_EXTENT(npath[depth].p_hdr));
+
+	err =3D ext4_ext_dirty(handle, inode, path + depth);
+	if (err)
+		return err;
+	err =3D ext4_ext_dirty(handle, inode, npath + depth);
+	if (err)
+		return err;
+
+	/* otherwise the index won't get corrected */
+	npath[depth].p_ext =3D EXT_FIRST_EXTENT(npath[depth].p_hdr);
+	err =3D ext4_ext_correct_indexes(handle, inode, npath);
+	if (err)
+		return err;
+
+	for (i =3D depth - 1; i >=3D 0; i--) {
+
+		next =3D ext4_idx_pblock(path[i].p_idx);
+		ext4_free_blocks(handle, inode, NULL, next, 1,
+				EXT4_FREE_BLOCKS_METADATA |
+				EXT4_FREE_BLOCKS_FORGET);
+		err =3D ext4_ext_get_access(handle, inode, path + i);
+		if (err)
+			return err;
+		le16_add_cpu(&path[i].p_hdr->eh_entries, -1);
+		if (le16_to_cpu(path[i].p_hdr->eh_entries) =3D=3D 0) {
+			/* whole index block collapsed, go up */
+			continue;
+		}
+		/* remove index pointer */
+		used =3D EXT_LAST_INDEX(path[i].p_hdr) - path[i].p_idx + 1;
+		memmove(path[i].p_idx, path[i].p_idx + 1,
+			used * sizeof(struct ext4_extent_idx));
+
+		err =3D ext4_ext_dirty(handle, inode, path + i);
+		if (err)
+			return err;
+
+		if (path[i].p_hdr =3D=3D npath[i].p_hdr)
+			break;
+
+		/* try to move index pointers */
+		used =3D le16_to_cpu(path[i].p_hdr->eh_entries);
+		free =3D le16_to_cpu(npath[i].p_hdr->eh_max) -
+			le16_to_cpu(npath[i].p_hdr->eh_entries);
+		if (used > free)
+			break;
+		err =3D ext4_ext_get_access(handle, inode, npath + i);
+		if (err)
+			return err;
+		memmove(EXT_FIRST_INDEX(npath[i].p_hdr) + used,
+			EXT_FIRST_INDEX(npath[i].p_hdr),
+			npath[i].p_hdr->eh_entries * sizeof(struct ext4_extent_idx));
+		memcpy(EXT_FIRST_INDEX(npath[i].p_hdr), EXT_FIRST_INDEX(path[i].p_hdr),
+			used * sizeof(struct ext4_extent_idx));
+		le16_add_cpu(&path[i].p_hdr->eh_entries, -used);
+		le16_add_cpu(&npath[i].p_hdr->eh_entries, used);
+		err =3D ext4_ext_dirty(handle, inode, path + i);
+		if (err)
+			return err;
+		err =3D ext4_ext_dirty(handle, inode, npath + i);
+		if (err)
+			return err;
+
+		/* correct index above */
+		for (k =3D i; k > 0; k--) {
+			err =3D ext4_ext_get_access(handle, inode, npath + k - 1);
+			if (err)
+				return err;
+			npath[k-1].p_idx->ei_block =3D
+				EXT_FIRST_INDEX(npath[k].p_hdr)->ei_block;
+			err =3D ext4_ext_dirty(handle, inode, npath + k - 1);
+			if (err)
+				return err;
+		}
+	}
+
+	/*
+	 * TODO: given we've got two paths, it should be possible to
+	 * collapse those two blocks into the root one in some cases
+	 */
+	return 1;
+}
+
+static int ext4_ext_try_to_merge_blocks(handle_t *handle,
+		struct inode *inode,
+		struct ext4_ext_path *path)
+{
+	struct ext4_ext_path *npath =3D NULL;
+	unsigned int depth =3D ext_depth(inode);
+	ext4_lblk_t next;
+	int used, rc =3D 0;
+
+	if (depth =3D=3D 0)
+		return 0;
+
+	used =3D le16_to_cpu(path[depth].p_hdr->eh_entries);
+	/* don't be too agressive as checking space in
+	 * the next block is not free */
+	if (used > ext4_ext_space_block(inode, 0) / 4)
+		return 0;
+
+	/* try to merge to the next block */
+	next =3D ext4_ext_next_leaf_block(path);
+	if (next =3D=3D EXT_MAX_BLOCKS)
+		return 0;
+	npath =3D ext4_find_extent(inode, next, NULL, 0);
+	if (IS_ERR(npath))
+		return 0;
+	rc =3D ext4_ext_merge_blocks(handle, inode, path, npath);
+	ext4_ext_drop_refs(npath);
+	kfree(npath);
+	if (rc)
+		return rc > 0 ? 0 : rc;
+
+	/* try to merge with the previous block */
+	if (EXT_FIRST_EXTENT(path[depth].p_hdr)->ee_block =3D=3D 0)
+		return 0;
+	next =3D EXT_FIRST_EXTENT(path[depth].p_hdr)->ee_block - 1;
+	npath =3D ext4_find_extent(inode, next, NULL, 0);
+	if (IS_ERR(npath))
+		return 0;
+	rc =3D ext4_ext_merge_blocks(handle, inode, npath, path);
+	ext4_ext_drop_refs(npath);
+	kfree(npath);
+	return rc > 0 ? 0 : rc;
 }
=20
 /*
@@ -1976,6 +2145,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct i=
node *inode,
 	int depth, len, err;
 	ext4_lblk_t next;
 	int mb_flags =3D 0, unwritten;
+	int merged =3D 0;
=20
 	if (gb_flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
 		mb_flags |=3D EXT4_MB_DELALLOC_RESERVED;
@@ -2167,8 +2337,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct i=
node *inode,
 merge:
 	/* try to merge extents */
 	if (!(gb_flags & EXT4_GET_BLOCKS_PRE_IO))
-		ext4_ext_try_to_merge(handle, inode, path, nearex);
-
+		merged =3D ext4_ext_try_to_merge(handle, inode, path, nearex);
=20
 	/* time to correct all indexes above */
 	err =3D ext4_ext_correct_indexes(handle, inode, path);
@@ -2176,6 +2345,8 @@ int ext4_ext_insert_extent(handle_t *handle, struct i=
node *inode,
 		goto cleanup;
=20
 	err =3D ext4_ext_dirty(handle, inode, path + path->p_depth);
+	if (!err && merged)
+		err =3D ext4_ext_try_to_merge_blocks(handle, inode, path);
=20
 cleanup:
 	ext4_free_ext_path(npath);
@@ -3741,7 +3912,8 @@ static int ext4_convert_unwritten_extents_endio(handl=
e_t *handle,
 	/* note: ext4_ext_correct_indexes() isn't needed here because
 	 * borders are not changed
 	 */
-	ext4_ext_try_to_merge(handle, inode, path, ex);
+	if (ext4_ext_try_to_merge(handle, inode, path, ex))
+		ext4_ext_try_to_merge_blocks(handle, inode, path);
=20
 	/* Mark modified extent as dirty */
 	err =3D ext4_ext_dirty(handle, inode, path + path->p_depth);
@@ -3804,7 +3976,8 @@ convert_initialized_extent(handle_t *handle, struct i=
node *inode,
 	/* note: ext4_ext_correct_indexes() isn't needed here because
 	 * borders are not changed
 	 */
-	ext4_ext_try_to_merge(handle, inode, path, ex);
+	if (ext4_ext_try_to_merge(handle, inode, path, ex))
+		ext4_ext_try_to_merge_blocks(handle, inode, path);
=20
 	/* Mark modified extent as dirty */
 	err =3D ext4_ext_dirty(handle, inode, path + path->p_depth);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index cb0b8d6fc0c6..4cd738fa408e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -513,6 +513,7 @@ handle_t *jbd2__journal_start(journal_t *journal, int n=
blocks, int rsv_blocks,
 		}
 		rsv_handle->h_reserved =3D 1;
 		rsv_handle->h_journal =3D journal;
+		rsv_handle->h_revoke_credits =3D revoke_records;
 		handle->h_rsv_handle =3D rsv_handle;
 	}
 	handle->h_revoke_credits =3D revoke_records;
--=20
2.44.0


