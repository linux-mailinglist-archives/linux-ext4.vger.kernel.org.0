Return-Path: <linux-ext4+bounces-12471-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E91F8CD5C58
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Dec 2025 12:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9BE330191AD
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Dec 2025 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B21A3148B9;
	Mon, 22 Dec 2025 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fXoOh5Ds";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="apc5W272"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC3F4C92;
	Mon, 22 Dec 2025 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766402093; cv=fail; b=GklNruR9YF4nd08AwoukCbRwYqbRmN1YDVHHcZfHj0f9oG/Wc3OfAM+DkiZ/sCIwWiPlWJqLRYdUlkLXT/QQUaOQLyVnDue3Avhr6/Z8iitpe/XhXxUs4dHBxUjCRr3klCppB/eCbQPAUk/ywdu+Q4xS/T+GQZ0TEfT/rvD8XHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766402093; c=relaxed/simple;
	bh=DzIMHy2SOdub/CEoKj7Cy7NwUoLIRDD1YM17Fh/eQvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gVsE0Ef6yW+UigQzI39cIRpFLhOD39g+PNw+D+ig2VkqL8/TlsOiE2hkhBRjwhti8cBC4UgirZqml7qyzkht5tF4RSwVeArBvZbP+/KF1IG1Kxn/jzo3debt+WA2vBswO9PzikAidxow8j6/i3ELX7B3gl+qxWIQwwQFJ7eznNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fXoOh5Ds; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=apc5W272; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMBBkHb2130708;
	Mon, 22 Dec 2025 11:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=B0Lc1Bi2XhST3pQ1OP1OSVQzloYEVrkm2JIZKzyUNr8=; b=
	fXoOh5DsurV1fM9SXNXdfbXeX5dPgFpYHDUwBtmdYvhp9x4ZSBECfW9IdfrW6d6m
	PETSdBS9ZH0W8RYJCd5vxsRywF9RnaFb6q90PAItSrP6QjVgEhjCdqvysFffXyBl
	25l/UiK/CcXOXPUsh9J0LuabRItFvZZfvva8WNsTASP9exHLUEYP7mK0/nW9wLLg
	WJ1oEF7ND8zk/Dvxg6CMZrzRVFkf19na+KquttvgaNDlo1g0W8fDDKHKNlZ5M7XV
	r00dvMblNJTrNFzG0whS5BTDvUpRm1pCRi41ixczKwlETob3Dm51v5LM/b0Gm5l+
	FnzUKMkGcoFe3eU9VcWpLw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b74w8002q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:14:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMAJjoW032680;
	Mon, 22 Dec 2025 11:14:24 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j876p0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:14:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pg9BcXcyG1ADXDt0BX9TQQgETNJHh9kWEIqUdDgNCEV5hSLIep4kzPJMvx3vS0hPgWdyg54soyNI6gux/WUYDCfmX+tCk4CED+I6BC4ebutUfNF8aQS7pU+kvfl7Ogs77hZGrmUnkuD5hvs1qlGfkYhnpQsTmiln3mvyDbLCPHhzay5f8Bks3wyeMj6QFcgMUKN/VourhMCCn+dyol2FXdBMUYZmALWRo3rMw0fQJr6OCN/q254B7izbm/1QgkBbZpxDg2ySjnYZqL0IDsVXYoAqZ0ZM3dEIbUlTJauZvOuq7tSAJJtV0hSwerJGvT491swhrvbZZq5CDAEGDWlIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0Lc1Bi2XhST3pQ1OP1OSVQzloYEVrkm2JIZKzyUNr8=;
 b=T5dyvKHo/jWbJ7egsBqFzf3TnYUOyzbX81pb6jQcqRlf/2BaXawk8/kSc0Dq9LEFlr+g0GSnrRHlniUSqS4ZfOXNq833q/dDoiQfm1OfPZRHJZqDqZ7M0m9alTITIsFmmrs449GG4HTJxUT3i3hpJCFnoEVFU4f+0HZ+wmAXhqTSm1J4jSzNni5DJjUrriqGFFPXxdXazvHpcCHdDbb9Krr5EhWqDOtBDOtNDytzaS/G+Y/xM7EydmJd68NlIOIcXwsw7gW99GDTrTJEosC1jgdnDxHheQqVRLdJAWFjqrAYkWPt3Qno2/YdlM2LRS0wJ7W/VZ3L304IYu1t4qw1Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0Lc1Bi2XhST3pQ1OP1OSVQzloYEVrkm2JIZKzyUNr8=;
 b=apc5W272xbDPOTKsoA1yWUYRl4cp9fDgCipJTwHydoNo8diKW2Ta5na2EaLnL0T1RflQGqVyFnw1xp+hq9tC28jwudhOi6e6YAfkwsEnffWrpcq142k+2STUY2JU/yg06DOGBlcxx4X88CvogFZb7Q9wy2FFk7xhOYdYXysNz1s=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4741.namprd10.prod.outlook.com (2603:10b6:510:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Mon, 22 Dec
 2025 11:14:09 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 11:14:09 +0000
Date: Mon, 22 Dec 2025 20:14:01 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com,
        cl@linux.com, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V3 7/7] mm/slab: place slabobj_ext metadata in unused
 space within s->size
Message-ID: <aUkn-SV9QjicEudm@hyeyoo>
References: <20251027122847.320924-1-harry.yoo@oracle.com>
 <20251027122847.320924-8-harry.yoo@oracle.com>
 <CAJuCfpHNhes_csqvm9-Z2f-C6XWuyRuXpchNtXwTSXxTpARZSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHNhes_csqvm9-Z2f-C6XWuyRuXpchNtXwTSXxTpARZSg@mail.gmail.com>
X-ClientProxiedBy: SEWP216CA0111.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bb::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: 085a7dae-4edf-4059-400a-08de414b3a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVAzZEZkcklDVUUrOFN6K21UMWJDdC9tVy91TEhRQnVzV0xtbW9RcHFjUHFm?=
 =?utf-8?B?dVRrVUpBNTFLaDdKQWcxUnR3aU0zTmRqMDd2SURDdnBOeEN6WXdNWHJlZDcy?=
 =?utf-8?B?ekpqODErR3d4UjhtRFhqRFdYN0U2bGNVMG40UXhVZ2dSUEZnWE13OGdMcXRO?=
 =?utf-8?B?MU42M2ttL1NrZzF5dVEvdVZWM0VDenMxMEM2TlczTzlPeTZOSmxlUFMwRVRq?=
 =?utf-8?B?Ui8vWjhLT1Y0WDl1dHVRT2cySVNkbVUyTlNoZmhSZ3BxWUg4Wlh1N2ZiUkY3?=
 =?utf-8?B?TElDbzJ4OGxibjVNM0owOHNiaEN4U0h3Q05Jc1U3UzVHQ0ZySmgyeXUwUVpj?=
 =?utf-8?B?RVZmSTZ0SExEZ1Z0TGZkMjRESjNjemJnWFhjTURhTFlQaHZGNHpSMk1WbVEr?=
 =?utf-8?B?MmpJcGNxRzF1REJxN1FBWmt1Rk9OK1ZnUGhsK1pkSTBkbXFBcnFMdm5jOWpW?=
 =?utf-8?B?cDgwMU4yT1hxRnk0QVFML21ZZWZNTHJaMnpxQUxqRlFCQUl3enBWWk9mSExD?=
 =?utf-8?B?ZmowNHJKWEZHdm9iMWtaQmZNVS93anB3SjNGSm1GbG1EK2UyL2gyc2lJeCtp?=
 =?utf-8?B?UFRCZ3VzS1FwY2MrR25meUlpNjJTcGNrWU1qR0s3S0tIMUlJc2dYMFJsckRL?=
 =?utf-8?B?SmRmN0tiY3V6a3Y5U0lGbnlMbG4vZTJwK3hBRDZ1b2gwUnBtUnNhSHNXYUJv?=
 =?utf-8?B?d3dmMWg0WXlqZ0k1bWRYa2RhTC9lbEZwc3phT2d0b0FYVmc0U0gxQXNTQzRs?=
 =?utf-8?B?WGdIM1NVQlFOZE1uMG5aSUpiT0FZYmNpRXROV21nNGQ4QVlrdndrY0svcW9E?=
 =?utf-8?B?anltL3dEbG5Ra1FTMnRZZWdRTldjWUpYcVVNSDN6cW8zTXJBR2k5ZTRQZlBm?=
 =?utf-8?B?WnZqN3hCd05FOFljUzlDNG5PMFhDRUJvZFliNUxhZ3RaRG5IK21LMDEyRHd1?=
 =?utf-8?B?YUZxcUFGV2RYcEhibUlYYVMxdTQvNjZvekJGa2FrZ0cwbTMxL0J2cEFsREw2?=
 =?utf-8?B?ZEZ5WDFBTXFYZ1pyODZIMGpXQUVzZnZKVEFzZnBYUEM5MGxvTFhONXRBeG4r?=
 =?utf-8?B?RFBmaW1NbjVBc1NxY1h2VnErOUhWYndzL0k1OWJRVFE4QkJicVpvbUJ4c2wr?=
 =?utf-8?B?SXlkSlRMc0NiRitOVmJtTHhoeTc1ZVk0eXgrRCtmSC9wc3FiQzB6UVpRRDIv?=
 =?utf-8?B?U0JVMTc0c0Z5RURUd1JJWTF2a2xkcENBQlZNQXVwVm4wRHZyejlSeExGWVU2?=
 =?utf-8?B?dHlSQ3JtelBSWnBhaTVNK2dqa21iQnVUTVUrOVRwYjZWUjh6TWFJVnNPZUYr?=
 =?utf-8?B?TG5CSldJVXRaWTFIZXdJdjNaVkFBSlRHRFhERitFbnFPelhMaW9TdnZWTW83?=
 =?utf-8?B?bjVrdW45L2x3aUlMSXFocVpJMlUzVUV6WXdNdzEwYjRCUmc5R0JybHphZlF5?=
 =?utf-8?B?UmJpYnZnd2JYampkRmlSTWNuNFkzSGp6OFd4eVNnR2FzV201MHRMQ1N1bUR5?=
 =?utf-8?B?NWZ5Yy9nRTc0L0xkWmdDY0xRbVFSM3pnTmRnWjMxYXVRUytaVmNMTDFvN1pj?=
 =?utf-8?B?VzZQWG9WcjB1Q3A1WGM1ZkR3ay9XcVAxRUE2Tnp6eVphSjR1aG5HRGovUkdY?=
 =?utf-8?B?R0FSOE85VDF6YUIyMVVkaE1LaGdScHpqYitGRHRxazN3OUtjaEFMNmNrVmF4?=
 =?utf-8?B?elFIS296UGU0dGJockZSUXJPQ3FROXM0N013ZHpETWhZQUNIMFFQWlBTbnZ3?=
 =?utf-8?B?OUQ4M3V3dm90ekNwdGI1U2NmU0U0SDYrSTVPSlpIQWszYkg3bVMwc2FNT3hh?=
 =?utf-8?B?VjJWOTlJUnc0ZGRpRTFKS3hMUnRSOUN5cVNLdjJzckgwN0phbXlneVJNT0Yw?=
 =?utf-8?B?b3NMTW4vU0xNZHhSQi91SDJvVzFzUG9GRHkvU1AwVVZqWjc2VlA3eVhmajlS?=
 =?utf-8?Q?6nrbsZG9BwBSREa0EaE96a5mfueb9sFV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzZPbVFwSENvaEZaYXlaeVc2ZnRHZXQyZWhKOVdvNXhwNFh4ckRYWm01MHAw?=
 =?utf-8?B?TGNSUUJMZjVINWR4bmY5SEVFUWVZVzFHNjAvUndPb01uODRQeWcrNmFJSmZI?=
 =?utf-8?B?STFRbTlTSHJSTXh3TEhWN1BOQThrRXA5ZDdDUmRSNGZUVXBDL3F4dGFmVC9H?=
 =?utf-8?B?WXdqLzNvaC9IMTZzN2pOWmlzbG92SFE5cHp5U1hTUmlEZ0lFcnd0UVFXVURz?=
 =?utf-8?B?RklwUFI4eDhsN0c3eHc1bmUySDFzUGkyZkdqL3BvMGVock42MkFCM2xMUlRT?=
 =?utf-8?B?RGp5R0cvcTBaTml1OE43RlptbldsNURDQjBNNWtZN01tNk8xV3ZvYmVGUnV4?=
 =?utf-8?B?WVFnMisxeGRUOGxuTS9qb28wQytrdi9Rb3ExV204cEZ2VzZ3Szd2eDdwaEFu?=
 =?utf-8?B?YVg0d2pZSlExVERmcWJ2MkZ1RlcybGJqdFBha0ZlS2Zxc1EvQUdXYlhBQzkv?=
 =?utf-8?B?aHBPL2YzdDdYTmxZZDRlMWFlQnBnUG1BV0xlZzNQY2dFaGo5dmIrWUJnMGNG?=
 =?utf-8?B?ZWFvRXR2OWpRdjNSN1FCRHZKNDFucGlzQUppbG11MnVlZ25zNW5IaVFpVW1F?=
 =?utf-8?B?alpQRktNVkFtMFYxRHB6RVVsa2QrWnpHVVZiWWIyY3hPc2hRS29kSFhISi9h?=
 =?utf-8?B?QXJISjUyUXByenNna0RRNm9FbndvYzNVOWlBc1JOcVNYRGduZlEwc2dHZlQv?=
 =?utf-8?B?Wjc5Q3FnTThiLzJxK2FLeDBKbmR2ZEliZWNvRHNYMVB3OVdNM3V6eXhESWJu?=
 =?utf-8?B?czN6MmgwclV0V05OdWxSbUJDeG5ya1NZT3Y1VEwxTWFmWEJWSU5jUGZRREtE?=
 =?utf-8?B?dVE3dDAreVpmcUdPdjZVOFZzOE4rQTBmdGZ5QlhVeDE4ZEtoWjBnVEpWTkRM?=
 =?utf-8?B?WFhYblpUMlY3aHg0SjJNVm1ZTW52dUVHb3NhL012c1NzWkVieWhpd2xpeEFs?=
 =?utf-8?B?M3NZSWRaYnpoNVVGYjZhdTB3WlcyZ1lhZjJSWTczYnF5MHk2Y09NRnJMUGpn?=
 =?utf-8?B?aEFoMkVwQ3EvUkRydis5SHpUV1JvbTMzNjdHbEF1dU8zaDRwenR0bEEybE4y?=
 =?utf-8?B?TDN3ZzBLL2VRc1M5ZWZZNWVjL1ZJdytuVWxZNEcyODVYUkVobmhYcTNXQldv?=
 =?utf-8?B?eDBrcGZxVnF1NnFjTXRMQ1FjV1YzdThMaXVKWDdQQkZhWHVtc1N4bHJ3Tm8r?=
 =?utf-8?B?enFlMlFkcjQ5RUJqRzIxR2dzUDhnTW1KdDhrVWQrUUZ0b2plaUw5Y29FcGpT?=
 =?utf-8?B?RWQ1djIySzczRTQzZlptVDF6dk5QNHprV2VFTjlBTHJmeWhqUldVUUJDWEdM?=
 =?utf-8?B?WlJiejZhTzBaUUpTbkxSWmd0aGpjdE1sMmJyU1Z0SVFZRXBGb1FZL1kxeUh1?=
 =?utf-8?B?cDBIQ09YV2ZqU1l0VDk0dU5aWGhBUlRVb2ZVNy91ZDhvWHZtdkJIcTh2YUhh?=
 =?utf-8?B?WWxvbndYbDNGS1BYajNWbGM2anlFK1c4Z0pDRnlHekJveHc5N2huYmRST0wy?=
 =?utf-8?B?MCtVc2ZZTFRDVlZmNVV1bXhsYXlZOG9rNFZxUmNZdkZIYnhxNDlwbjhpL3Nq?=
 =?utf-8?B?c0NyK09pYzJudy9VVk9JbkNEQ0RsMy9uakUyblhVUFF2ODJ3VXQ1RHBodklC?=
 =?utf-8?B?MGVWL25ybXBFYmdWUW8yTUFMRlhXYnNldmptSVd0WkEvdzlKWmV2MDhES1Yy?=
 =?utf-8?B?aE9UN05GMzZSSnhabCtiUW9OcXA3SGpmd0RGd1dnQm43dzRDR2J3OUxTckJY?=
 =?utf-8?B?T2cwbW16bmtxQm9YUXJVdzMxOHVDbmVUQ24zYjBFbklHcHRJK2FacCtNWTVZ?=
 =?utf-8?B?cTRSSlpJaGU0djFoQktwQkVhTThDc2FSMXU4TmhXZWthZjIyRUErMk9LelFQ?=
 =?utf-8?B?SUVVTU55b080YmwvUmVtcTkzd2dSQXBEclluZTRDOTVWWGxtZ2tMSGcwOGZJ?=
 =?utf-8?B?R1dOWEJvbjU2bjdpYStHanZnL2VNcVpIVloyNWJIaXhSaTRJYm0rZ0lxK29K?=
 =?utf-8?B?KzJaaG9iT3V0dTVIb3U1NEpJc1JkaWl6SUVGR2d6RE15eHRHM3l3eTd5ai9x?=
 =?utf-8?B?R2Vta1o5MnpRMjU4QzFuS3ZXdmFwSTYwVm55VW11UUpxamlITzZPZ1ZDQ1NW?=
 =?utf-8?B?Mm8ybWhJU2sraVhsdU10WHVUUmsvK01MNURJR1NzTFlQc1g0czB2Qm5Kd0V5?=
 =?utf-8?B?TXV3MWhPNitoVU1FcS91ZnNwOHVNTFhxZ0VRMjQ3Q3hmSWpPMC9qTzRsQ2c4?=
 =?utf-8?B?WGJyeGNlZVh6ajVCZG5Ha2orRXIzZDdKbVZPMVJXQXNYbTE4MmhueTFOeUdp?=
 =?utf-8?B?Ym4xMDNYQlRpSncrdXkvUnZyWE9CNXJpVTAxSVM5K3k2aFZqTERDZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7WFzdpBA92zHIRFBpQegTvfxSoHNMfe/UBpB96aCf/h7t6ilx7eDVD1eNlkvVweH7nsruR9l30BdW3G/Z9YWz/1miHtTAPRtdJdcJtwK8+ozi5PXbs44jxrKCz4nqiKtdkpShxAHFemm85VmA3wVaJrHY9oxbfLSj7n2VoZre4l+E22SRA6fhonIh2yghRjt3ppTSgh9y8fGZPCGlcixtd5Wu5avfxtelWrx00pU9as7BtQXWVqil5L3pKvjO+abDVxZ1iFm7c5Fj3OrINZC91/fOzfKikgsNcEIPMkvGQV4Kii6Bq91zC+qJcNRx41+cvwHLUT4eCCF92wCGcK4pIUFUpUmO0dDCnn9rp6XcjRA0bgj688sxF1Dpzr1jIwu1awWxM5fYZ9LxKXdUfONZ21X5eoNHj8/pG2im+56/mCn568vqD4Z1dhbinV2JVs5FkaLzeeLpdy1rj+Czay19UufFQLdvKhIE57v/lDRqh9Eq7OLuftV6zLf/wliRlmIithbgPvP2xCUw8W2msB3vpcedISQZiQYxtM7KDmyjV35AJg5hEE4GmjLe9BPmfh1JP8sAXUrovrZrad6BfbYgLc5oBiqF3yuB5CGQNSBUt0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085a7dae-4edf-4059-400a-08de414b3a8c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 11:14:09.5436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1bznQlPMfvLcMjMhnR6ubjVABuv/e4TVubgnNuLI2X5c8M/198xwd9cFYb5F8slG8y8Ch9jyHU1H0KPu18d5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512220102
X-Proofpoint-GUID: PlQjwdpnuz-U1EdBqG5bxEEzVgjy-2LV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwMiBTYWx0ZWRfXy5YdAIio9aDG
 BDrhz6mxxV+ora1JeS9AMDOl1OY83aNPJ6dff3elqPNhZLBeKPnlS8SCkdKv430hNdU3XXmNnvp
 oEhv5MdzF+jUpsXJGG9kx/RgJIvqRqSqLSZAw/iOZVxbWhHUuCOuHvGhDxLYS98c006TA3r7A8t
 1LJbCgHgm3/MGfJghbPFWv5HwKP/vEWK6g0925B2u35YhSr4Cs0NZOnTzbTYqXV0IVAKMwxTnob
 uLnUyknFz7IeRXjrZpoB3sWVARSKpUI6OKIOuSeP7q+5SAkhj40A6lun3n5Du736+6gKuPvsMEf
 0aH7xTWX+YjPzveRu2/DUWsjPHV0iki4pWQ8PB4Ip/zLDR6LbNG2z9zt2kjKilvLmPlDq943EUP
 N6qm6DPlzJAjtPepBIzlp3aV++TtoziEAhuHAlIf2YKzH8ojnbHJIbfxRMT9aPKYnp/Ug7BWRmc
 PaJfCTOgX4atoEwoTGg==
X-Proofpoint-ORIG-GUID: PlQjwdpnuz-U1EdBqG5bxEEzVgjy-2LV
X-Authority-Analysis: v=2.4 cv=YLSSCBGx c=1 sm=1 tr=0 ts=69492811 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=C5My4TV7-s9L-27-N7wA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On Tue, Oct 28, 2025 at 08:19:59PM -0700, Suren Baghdasaryan wrote:
> On Mon, Oct 27, 2025 at 5:29 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > When a cache has high s->align value and s->object_size is not aligned
> > to it, each object ends up with some unused space because of alignment.
> > If this wasted space is big enough, we can use it to store the
> > slabobj_ext metadata instead of wasting it.
> >
> > On my system, this happens with caches like kmem_cache, mm_struct, pid,
> > task_struct, sighand_cache, xfs_inode, and others.
> >
> > To place the slabobj_ext metadata within each object, the existing
> > slab_obj_ext() logic can still be used by setting:
> >
> >   - slab->obj_exts = slab_address(slab) + s->red_left_zone +
> >                      (slabobj_ext offset)
> >   - stride = s->size
> >
> > slab_obj_ext() doesn't need know where the metadata is stored,
> > so this method works without adding extra overhead to slab_obj_ext().
> >
> > A good example benefiting from this optimization is xfs_inode
> > (object_size: 992, align: 64). To measure memory savings, 2 millions of
> > files were created on XFS.
> >
> > [ MEMCG=y, MEM_ALLOC_PROFILING=n ]
> >
> > Before patch (creating 2M directories on xfs):
> >   Slab:            6693844 kB
> >   SReclaimable:    6016332 kB
> >   SUnreclaim:       677512 kB
> >
> > After patch (creating 2M directories on xfs):
> >   Slab:            6697572 kB
> >   SReclaimable:    6034744 kB
> >   SUnreclaim:       662828 kB (-14.3 MiB)
> >
> > Enjoy the memory savings!
> >
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> > @@ -2250,7 +2293,8 @@ static inline void free_slab_obj_exts(struct slab *slab)
> >         if (!obj_exts)
> >                 return;
> >
> > -       if (obj_exts_in_slab(slab->slab_cache, slab)) {
> > +       if (obj_exts_in_slab(slab->slab_cache, slab) ||
> > +                       obj_exts_in_object(slab->slab_cache)) {
> 

Hi Suren, thanks for the comment.
I should have replied earlier, sorry.
 
> I think you need a check for obj_exts_in_object() inside
> alloc_slab_obj_exts() to avoid allocating the vector.

But slab_obj_exts() check before alloc_slab_obj_exts() should have
returned nonzero if obj_exts_in_object() returns true?

> >                 slab->obj_exts = 0;
> >                 return;
> >         }

-- 
Cheers,
Harry / Hyeonggon

