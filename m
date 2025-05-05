Return-Path: <linux-ext4+bounces-7664-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BE2AA8F52
	for <lists+linux-ext4@lfdr.de>; Mon,  5 May 2025 11:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684EA188086F
	for <lists+linux-ext4@lfdr.de>; Mon,  5 May 2025 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2B91F8743;
	Mon,  5 May 2025 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b/jbzpp1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vHf72IsT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B51F5842;
	Mon,  5 May 2025 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436834; cv=fail; b=PB+t8/o1E7G6qA63PB0FbOi8jLYQbER2sdrHUk3FFUw7J/om+UXCryBCvSPjYo89mNWvMcCbjhGNMVkAzMLkAykQkP+ZleWZPiVTMMv9f1CsTFEhnBriBw3J1tg03UjDgTUzkyIPwHwW1Dz86ummuMBNva3AuOBGJ/9OQ555DDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436834; c=relaxed/simple;
	bh=oQTr3tKOa7aiHVy8hDJdi9MrIGHW9SA7MHbOnNL1E2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HKfAXmRYnMB/OT/Uar/Ntb0EPtYEP8HLC8yruJChCcItazrZcumSEpzgOF1T4Z5G50luJBoYbOJbo5RwIO4Y2x0LNW7+IUpDmLkq78ZQyWSe2QxSaqaPVbbeX6gaGMov2aqQMjPg2N00Fvue7MPz4uWkmJ7WLsdCKOD7xfkRXNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=b/jbzpp1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vHf72IsT; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746436832; x=1777972832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oQTr3tKOa7aiHVy8hDJdi9MrIGHW9SA7MHbOnNL1E2U=;
  b=b/jbzpp1y8xTFxzILjHzOg/Zmbh6vEHFFr3rO9pRTdsuvbOIP1zUXxi5
   YON42WYN1y4xwsx1Z/G0zU1DDwxNFRhXwwJNjjLb1xrJeVV/9Fp+vKPQb
   x351jMHLaNR8pC25RzQXNTLQ0mA2ZkS8HWIjpavOCdsrlIaIoeu+lUH6O
   dJUhBc/DNt5OMXxiC3iypPrqVbJwCwtJW0BenH0fi3Ww3I80HoIFCIin5
   JBAcHe8RkavYRg6g5h7TqKwWbk0kCodL48YG16nFmGSpzu9VDP94w25ns
   yTtzdY1TofBVEfhAiJuS4hy9gkdmwoWv37vaYgax+OKKDZgU+KE4l8noU
   A==;
X-CSE-ConnectionGUID: WVrQjhJQRR+k2rVi5tqyjg==
X-CSE-MsgGUID: 2MsJcvAuT42vcHhjzLCEpQ==
X-IronPort-AV: E=Sophos;i="6.15,262,1739808000"; 
   d="scan'208";a="80000105"
Received: from mail-westusazlp17010006.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.6])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2025 17:20:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6NAp+qRWCzqvAEIwm3+hAf04uTsOJv1n3P8vMH88VCbV8ZJkbEYFwd49CnRxmCilX8m4pBHlTtKVBEl/hmM/zqpJV361neukRFTZ7hitqA0hzTpdDlo5xh871huAh2YR95Z+AMlYPl5t81vb+8XS/9FZG68x1Zim8O5tpiLjHtcOcAmDemEC+7qqGBFJtZvYlTS8dmDZZTxPPk6by149/RuFfCGXiWonCwgjbIMgBn12s20lq9OomvVQueyFbY6CLaMaKgW3pWI90zBjrkinPKDEA4Qu6CbKSM+BDwcF6HGbQZa0gHi/o4YnQhjXVr8d2tbPRu2hmBk/1lK0IE1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQTr3tKOa7aiHVy8hDJdi9MrIGHW9SA7MHbOnNL1E2U=;
 b=MnB739T2CuCHJlv5pd2PATEEU/EH2SOHkMNWabgl/kV72GU5n/0c+axmRAK6RpUDnqZgTR/jrBxFK8GASbT9HIGeBz0EQBRKEaZ16SEvN7xlNcMlvXwDvlLKIw3gTdA5g26dVL8nr5PH3b/ofVyRHlWp3KljFdaiG5va2YSD5lJlohp61XFXd/QWX5PrcpDiJUmljjDCzFOPAyTXEopQrBGMsSuMg/Uqq4d0NAMvPSG7A+S/O8RhlKcvVu8EhoMEZ8G1rM4rJEZ4VvyYabImAkzR7KWVFnUANmDHy//MAq7vFqtaptywJ7zlrP+AW7N4dcdTWVMP0NM/zHvvs7M2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQTr3tKOa7aiHVy8hDJdi9MrIGHW9SA7MHbOnNL1E2U=;
 b=vHf72IsTSJ0RefuZbrVAYtsm/MKRuia7/zSoOxdDb4q3bJo8bDzSkLBHGWdKSC//l4WUqtI2xR6bFgNQdmO2ZKyF6UxQzz9QBnW921D96j65IMiZp9dKk6q/pU3RNvwg+x7cGBktYSP5K6mxHUBM9e9AYWEDOftKOdJxxW8CDZc=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by BL3PR04MB8187.namprd04.prod.outlook.com (2603:10b6:208:34a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 09:20:29 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%5]) with mapi id 15.20.8699.021; Mon, 5 May 2025
 09:20:28 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: Theodore Ts'o <tytso@mit.edu>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, "zlang@kernel.org"
	<zlang@kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>, "djwong@kernel.org" <djwong@kernel.org>,
	hch <hch@lst.de>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>
Subject: Re: [PATCH] ext4/002: make generic to support xfs
Thread-Topic: [PATCH] ext4/002: make generic to support xfs
Thread-Index: AQHbu1Y9RHbR2RLnUEW7imjMDZRs0LO/Vs+AgARwZgA=
Date: Mon, 5 May 2025 09:20:28 +0000
Message-ID: <8ea4ef50-cfda-46f1-a78e-eaff411de6f2@wdc.com>
References: <20250502113415.14882-1-hans.holmberg@wdc.com>
 <20250502133309.GB29583@mit.edu>
In-Reply-To: <20250502133309.GB29583@mit.edu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|BL3PR04MB8187:EE_
x-ms-office365-filtering-correlation-id: 70161d7f-7d3c-4b00-5ba3-08dd8bb613cd
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUlYaERQWGxEZ3p5UmVQVE9vMHFKYTFveUI4a1h2YUlMdTlhSDNWNG5lNm90?=
 =?utf-8?B?c0Y3c2d1Q0JBRjZ0Q1NYSW9jbEF0aU9ROXBOeEJ4a1BjREpzc29FN0NieHdB?=
 =?utf-8?B?T3UrM1hFQTBESE5kaVdXaDRNcEFxTXB5WEtIRG41dlB6U2tmbFNibFp1VFRh?=
 =?utf-8?B?a083QTJZYkVnck1yV2hyY0dEUW93dHBReWo3dTc2L3J3TEVtRkNlRzNzdUla?=
 =?utf-8?B?blJJNDdpaHMvV08wOG0xaHhKeVM0OFFCQnlYNC94TXl5Q3FZUTRkTTNTRjZJ?=
 =?utf-8?B?eGdSU01iNUplSjl5RzJPWGJRYWNST0p5SWF2ajUvWXBlTG9IZHlkMWp3UGlN?=
 =?utf-8?B?VjVSODdHNThkdGk2bWlZL1BhYkRMMXNQNmhDNjFtd1ZRM1BqS21qeHg2YjZL?=
 =?utf-8?B?dTNPVEpSUmROWFJFN2M1Z2dZT1R2NFNkQ25kMHV1UkFxRnNLb2JPbmlZUkVC?=
 =?utf-8?B?TTdJNjBrb21RNytwdVJSbzJickhpZ1QwNlptOE5vam5OVFJ4aFRxYlQ0UEhH?=
 =?utf-8?B?bDFLN085azd1eUNRZnd5ZzhXSVljenNjV3V1YlVib2wzd2U3S0EvMzdvM0Fh?=
 =?utf-8?B?RVovNWJpWXh2bWs5dFc3R3ZNeitnS1A5R2NCak5ZWldsc1oyRkRyeHlaYTFL?=
 =?utf-8?B?c0xNd0ZmZk11NjFBdmhKeXNhOVNQRGF3VWRySzhpazNwYWpPVWxucDVVSTB2?=
 =?utf-8?B?ZUFjLzhUcVpjKzlBbnVIVGdpMnVDQkhxeHNLL1VlMWRFTHQ0aHgvT2RiVDBq?=
 =?utf-8?B?VUs0ZFM3aUlLR1lhZmN2WGZyQUdXb1g3Y21hanRHTGhFbzlUQ1A3Uit0MVFs?=
 =?utf-8?B?NUFNZUgvSFQxUkdsZzdqRE9mbDZyL3dzZDM1ZWNLeU1ZSS9rcTZSbHlHbTkv?=
 =?utf-8?B?aTRmWGowRGNOZm1yejBlZnQxTU5VbCt2YjM3dEw3aEp4ZjNvWFNUNzFsUmZn?=
 =?utf-8?B?S1F4Y3k1WEYrK21odUY2Um9XYmtJVHBaVmQzbW9lUlh4WFNMYThvV1pJdGR2?=
 =?utf-8?B?Nm1IQkRpeEh6YkE0TlB6ZHY4ZmJiQldzWVlVNDlUZFBXaW5yUGNuYllaZ3da?=
 =?utf-8?B?eXN0eVVGaHdEeWV3bnNKYzJ5Y1BBd3A0OXpzN0tBajJCcCs4bGlTTE5XUkpr?=
 =?utf-8?B?ajNGcjJPWWExTVgvaGZUbkVIZzRwdUc2WWtOTEJobHJDbjJJVVI0UWplWE15?=
 =?utf-8?B?UjFxVE9HalJZN3RudGUzMmZhZU9mcjBnTVpVbGhPTTBxRlN0ekczQy9nVU5T?=
 =?utf-8?B?Wjg1RFNaNjJDbUJpZ2xxZUdQMis5R3hKYTBXTFlxbWJONzZhL3JKSnppWER5?=
 =?utf-8?B?Rk10WitCUGtoeUtEcUM1UGV1TG91MWxVclNFdXZBY3l4UWorbU1vY0RXbnBq?=
 =?utf-8?B?UG0zdUNLV0VhazM4cnZtRWM2Y0tXbkJuZjU5K0dkbStJQ28xUDUyN3lBQ0la?=
 =?utf-8?B?V0tmQTdBZFltMkg0WkgxV2NidGxJTlJrb0FCWGowR3pPODdNN0ozQmtFMHpx?=
 =?utf-8?B?Z1FYaDZQOFJBd3ZEdVhCQzFpRG1rYUw3TmRDRDRFbFZsY1NvQzdvRjBKbk5B?=
 =?utf-8?B?cVl4eFdtcFlpZ05BY0paSXd3eVJFRjlEZW9TM0tUNzNHNk51TEZTbVBkNndO?=
 =?utf-8?B?Um9zbHpZQjBMaWdaWEZUYVRod2JIa2VJZG5PMENlaXp1dzNTclVEVEhkemFm?=
 =?utf-8?B?VVZVV0JyMDRBK3VudkdPRVI2b0lOTTh4dVh1Z1hFY0w1L0g0SU9xY0xpTXU4?=
 =?utf-8?B?NVNCSWo3alIvclF4Tmp5aC9OWVFmL2JSVmE5dkN2WGIwMTNkUlM3eGRFRjVZ?=
 =?utf-8?B?eDlHYmU1RjRJVDdXMkczOHBqVTJOSlVDSkV1ZXkrWGFGajUzaGlSYzBKRk1p?=
 =?utf-8?B?Yk1rOFUxcjZTeVh2T0RSU3ZIci85eFNCR2pxS290Vkg3RGd3UTdMbEJCSEls?=
 =?utf-8?B?aDI5aFhKZ1ZjZkg1V3BkNGZkY1JBK085TFZCN1p0MVgyclFmMmlPR0dacjF0?=
 =?utf-8?Q?uHmRITULzm6BwlOMx0BrFXJR4Zcxb8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MlB5N0x0RitiaGx4SVFsTzI5WHBpeDdiNkVSYTB6YVV5a0dmcjdDVUMrenN4?=
 =?utf-8?B?V3hDKysrVDZaWUNKR2ZVYXRDblJJQ1JHRmpDczMrZ25DNTYwYko3Q0ZhalM1?=
 =?utf-8?B?bnZYNEx3dCtDb0toNG03OHF3WVZsc1hHN3ZrcTF4QW1wdFBZUndJcXdUSUdW?=
 =?utf-8?B?REJTTGxGelVzRldFTENvaHV6MEV0Kzlvb1crQVhqN0NTVXh5bnNhd0hFSm13?=
 =?utf-8?B?cHBtZ09paDdwRnZWenl4OFVlYTFLRnZTeWxkR0VYa1psTFNCaUx3MzBtVEZF?=
 =?utf-8?B?K1BOandTZUVRM1BqMmlFdXZLQWQ3YlowMjluZlBjZW0ydHVodUtrdkR5cEZ5?=
 =?utf-8?B?MXFDM2lUMzh4clgrYXo1VjZNOElZWDgxV1lXQy84eGpqSWpKZ0NlVFUxMTkx?=
 =?utf-8?B?aUQ1ZlRCempHYXduUStCdHcwb1RZMjdTUElVMDI1VGpjMTJnV3A0NEhjdkpU?=
 =?utf-8?B?S2RoYm90NGdUUWJZUHM2R0RSTlVaTmlLaStrVlRPVVhUeDVCQ1FSR0RmZkdx?=
 =?utf-8?B?angyWVZGeElMTVFHNkFhVE5XZTF1clNxZEliTTA2UlkrYWNRb0oyaDBaRG5Y?=
 =?utf-8?B?SER1WHlBTFZRVWNMZEwyajNESGJ1SmwzbXlWWVJ2eEt6dEpZZUw1QnlFUHJF?=
 =?utf-8?B?V2xadmt3Y0QzNUVOdUppWU9aUklaREM2WXJtV3p2Zk5nZDJvVzUxUFUrSzkw?=
 =?utf-8?B?cDBsdmVQQS9xWkloY1U0YU0vUHV0T2lhUDhqcUc5NldOVVhvMEt2bzZEcCtX?=
 =?utf-8?B?S0lGU1JPVlBQT05iVlFKeTdFblczandCZVJQTUE5U1F5THpvRi84NHgzUStU?=
 =?utf-8?B?aWFrRDNtK2RTcXVqSGlzNXN6dit1dGtqRGs5ek44QmRraFR3cnVIRUVIV1Bj?=
 =?utf-8?B?REVMOHRlcTVKT1prQjFXZHpYNHNBcWliTDAyTS9VdW9mdXlzV25ZTlFyRlE1?=
 =?utf-8?B?bE5RWC9pOVk5L2w0M0R5L0pjcnFuODBDQnp2YjR6QTJDdGYyUGQrM1YzNUY3?=
 =?utf-8?B?WTlscVdvUk14TUhJblljclFSV09oaWZhWFJOYVN0TlUxMWZPZWJwblhTTEEv?=
 =?utf-8?B?NG50QjRrR0RBUGVMaXN2OFlOZS9TVXBPT1IyRytYdTlaUm5xb1VlWjlSa0ww?=
 =?utf-8?B?eXFkV0k0ZVV3SGZ2M2Z6aFdUa0syeW03Q0dRSXNpcDhIaFBlRHphU2FQTXg4?=
 =?utf-8?B?Zm1FK2s2WUNHZHFDMFd6Rithc0tGN1I3SEZGQUxQYklObjNwWHNZWXFTNHNK?=
 =?utf-8?B?eFo3dXhkU1pEaHJ0QllubHVpbzNDSzZRZ2V0M1hVUWVNcDhmbjhZNnovc0Ra?=
 =?utf-8?B?eTNQYlRjbGlyMGY2L1c0QkxtTnN2S1Y0TFE4dkVwYzZWV21BMnlWdFFBTkpi?=
 =?utf-8?B?UjF1cDM3SHg4YS9GMUN6aG1SM21UK09TdkFvYXgvQ0pKNmYxQVo0M01wUUV2?=
 =?utf-8?B?dEdYeE42TmVvV2IwZ05aQWM1Mm96TGZMd3ZBMUNjR1F5cDdzYVpoT01IenNh?=
 =?utf-8?B?eVlGa05VRjZpTEljekdrVE1nY1VNRVVHTit0NDRFaU1wc2c3MDJIdjlTVjdp?=
 =?utf-8?B?Wm9mc1dYSGZyYXBLSFNHc3NIaXpYdEZnSWdVMC9kR0tyWFRUblRreGpyUk16?=
 =?utf-8?B?NUt1eVhKaDJMSUFyZnVIYStZQkdnVUd2RytkU1BMbjdCNm1hQndkWDZ1ZGZw?=
 =?utf-8?B?MHpqT1pTYndXQnVnNjg2S3VoajFvcnVCT3BOcU4rdTR2ZnRXWjRmU1lINmdj?=
 =?utf-8?B?bi90cFNPdStKRUppWXBSMStQR0NUcmovN0I0dmlnWDVMem9UMVcxcWU1OVlI?=
 =?utf-8?B?RWllVEZOYnMxaG81aTFONGxJZTZ5eXNoWEZCWWlHZjdYOXhBQmFzZ2R5b2xt?=
 =?utf-8?B?V0FaQVJ0L2M4YmgvbGxoZlF3UktXc01lc1FkRWh1a1FkdHM5OThKeWFjbXox?=
 =?utf-8?B?MGhKNy8xNjJ3REJQZDVIa0dhNVRYK1VwZ1ZRdmI5WmR4ZTVTb3Jvd1FKMHU4?=
 =?utf-8?B?YlduSGFldDNPcDZqem92b1RHSUd3emJKYkJTKzBodzg1MngyZFJ6dmh1SFZv?=
 =?utf-8?B?RUNSYWN3UFQxenZ5VXdYdFZ0WEFBd0d5V1BaUXllNkdvU0pmNW9XdVlUeHhn?=
 =?utf-8?B?Y1NqVHA4V0ZnWVQ2TUIrSW9BK2x0M0NZZXAySlc5NndydFo2UG40OGs2a29V?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBDB1AB9B33DE54EA11735113F9DA74E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sUpB1fsFhlMEdi6CEaRIRZ51bC9Bzm5rYKiq27xWc93ExD2QDF8SVW7qupzxvURnhgIBJmvasoAgTwwfx3i9OSO562UxCPjowpzSqI9HzCP7kJvI+TMtiV/p8NEuk3paMDDE90cyMuWgtaMC9ca1fSGmgMg3JF9DWqG5A79BUlNYTDzYSVTKHDoqfEzAMkcRsGBY8QXxJGgasrEQ/njlRdgOTmAbEgvJzQeAcJk4SG9kHWyTAopv4qDg11A38MMfLpqmQ2S1DOhkdVyHOFGxS/Bomjf5dc5cKtvjPmZtpwRuDqnEA48+ESmZ6FTtL4JNwemD2CgIhRijDJJww26EA68lkUmdZLMh25Ah5lKo47SNko3Dx+jOSzv7EfmRVAh+yTCbWIlmbdGIGtRt0OxcYvLPTU3F2VmRm/ja8Z5u6keELBEpkgh5Q7Ievn/EC183nMY5WK4SJJIJBjf6v3oieBrtxtRhWv7GD7LAXJpqu/4CI3s5FpMGJF0FWNmQdqWca6cGv4DJ+ylWby8VThver4ntezskikkSkEh4arUpWOv0ANN+NJnXlfkqfF9BTlVEI1Hp9e2KMIabe0WEAH6EPLocA1J32N5r9f4UI2VqnfnwvNE1Q47VkbMs0F6H++eA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70161d7f-7d3c-4b00-5ba3-08dd8bb613cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 09:20:28.8966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8B47X7RqACAmasrCD1LdZDPAO3ln7TEHNrdEXDkUvyOaE3dHOVrK+LEX4r7YdiMy0qq+XcuUbcXWXCiJxP9zag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8187

T24gMDIvMDUvMjAyNSAxNTozMywgVGhlb2RvcmUgVHMnbyB3cm90ZToNCj4gT24gRnJpLCBNYXkg
MDIsIDIwMjUgYXQgMTE6MzU6MDFBTSArMDAwMCwgSGFucyBIb2xtYmVyZyB3cm90ZToNCj4+IHhm
cyBzdXBwb3J0cyBzZXBhcmF0ZSBsb2cgZGV2aWNlcyBhbmQgYXMgdGhpcyB0ZXN0IG5vdyBwYXNz
ZXMsIHNoYXJlDQo+PiBpdCBieSB0dXJuaW5nIGl0IGludG8gYSBnZW5lcmljIHRlc3QuDQo+IA0K
PiBXYXMgdGhpcyBmaXhlZCBieSBhIGtlcm5lbCBjb21taXQgdG8gdGhlIFhGUyB0cmVlPyAgSWYg
c28sIGNvdWxkIHlvdQ0KPiBhZGQgYSBfZml4ZWRfYnlfa2VybmVsX2NvbW1pdCBwb2ludGluZyBh
dCB0aGUgZml4PyAgQW5kIHdoaWxlIHlvdSdyZQ0KPiBhdCBpdCwgY291bGQgeW91IGFkZDoNCj4g
DQo+IA0KPiBbICRGU1RZUCA9PSAiZXh0NCIgXSAmJiBcDQo+IAlfZml4ZWRfYnlfa2VybmVsX2Nv
bW1pdCAyNzMxMDhmYTUwMTUgXA0KPiAJImV4dDQ6IGhhbmRsZSByZWFkIG9ubHkgZXh0ZXJuYWwg
am91cm5hbCBkZXZpY2UiDQo+IA0KPiB0byB0aGUgdGVzdD8gIFRoaXMgd2lsbCBtYWtlIGl0IGVh
c2llciBmb3IgcGVvcGxlIHVzaW5nIExUUyBrZXJuZWxzIHRvDQo+IGtub3cgd2hpY2ggY29tbWl0
cyB0aGV5IG5lZWQgdG8gYmFja3BvcnQuDQo+IA0KPiBNYW55IHRoYW5rcyENCj4gDQo+IAkJCQkJ
CS0gVGVkDQoNClRoZSBwYXRjaCBoYXMgYmVlbiBwaWNrZWQgdXAgaW4geGZzIGZvci1uZXh0IGJy
YW5jaCBidXQgaXQncyBub3QgaW4NCmxpbnVzIHRyZWUgeWV0LCBzbyBubyBzdGFibGUgY29tbWl0
IGhhc2ggZm9yIHRoYXQgeWV0Lg0KDQpJIGNhbiBhZGQgaXQgaW4gYSB2MiwgYWxvbmcgd2l0aCB0
aGUgZXh0NCBmaXhlZC1jb21taXQgb25jZSB0aGUgeGZzZml4DQppcyBtZXJnZWQgdXBzdHJlYW0u
DQoNClRoYW5rcyENCg==

