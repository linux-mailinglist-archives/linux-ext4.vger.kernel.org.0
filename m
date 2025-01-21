Return-Path: <linux-ext4+bounces-6177-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEB9A17DCA
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 13:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A98318889FA
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 12:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2001F0E36;
	Tue, 21 Jan 2025 12:29:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mo-csw.securemx.jp (mo-csw1122.securemx.jp [210.130.202.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A61F0E25
	for <linux-ext4@vger.kernel.org>; Tue, 21 Jan 2025 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.158
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737462564; cv=fail; b=jHcvyI72rPbaUHo73DLb24sn2IZ2Lt/EkNTpbptNZKvlt6hazTYdS7wvW9n4dq5uV2qqYguPwVAYb+6TpUlVCivukuL42iTNOj9j8lKsqDBWcq9JzSdhdcXRkc15wpAKJw5K/2Zi3Q7N0PLStJrP4htQ8CzZ3urMl156TzXhofQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737462564; c=relaxed/simple;
	bh=BQ0xna8gfsnrbWf4HItnscyXgGyyoXisgyB6wIsWJN8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SoLtZ6B1X1RP0He8p5ZOCbKM/B7AP7RyPAGq/IfWJ564SDd7lfAmdHLXssAqufXZIgOdyErQA1h0OZE3lRLFPu+LqJGDY6vZdsoICHyaAUmDKApniJyGdUa1tYOlk/UeTxPP+GJKT7ocYwFsu+GBKrwxzkgaQjG7aKhLyI+d4Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com; spf=pass smtp.mailfrom=toshiba-tsip.com; arc=fail smtp.client-ip=210.130.202.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba-tsip.com
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 50LCTJUa1552128; Tue, 21 Jan 2025 21:29:19 +0900
X-Iguazu-Qid: 2rWhMjEQHmFb8fziKJ
X-Iguazu-QSIG: v=2; s=0; t=1737462558; q=2rWhMjEQHmFb8fziKJ; m=e17MXfGnd8eGmzl2qw8aCTHc0Bfn/yJuNMFuuSee4h0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 50LCTIGZ2484882
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 21:29:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGLxeFbO46ew1BCL4nLk3W+ArdVhmyY2vpU6B6FlgwmwgoOF2IRNmZSpxv/ics61bjs/NLSqCg+FBH+ySwRzZ0V5f/dkORr656KqKjCH8wINdAsPRQvDuVITI8oeB1bbJkgvdltQcFpT3ujPREY1VRnsVpSta7R4xIADJ4RfL47pegcGeqRPbgKIEWDBpuDzV14uUji1wTUhTn3n5Kz/KhRDDxvb2+TFBKlDllrL2tw7b96M5uIXa3KOpaLswvv69eM8DLdiue+4ih3qzt0HZYbFxKLCATOEkRWNQtkTIkT4UaFf+Mzd8+AoZW1cfCfJEep8t+Yply2P2Q37sTAutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQ0xna8gfsnrbWf4HItnscyXgGyyoXisgyB6wIsWJN8=;
 b=euahEaXsrlY9WddkL6oblLTv6doOpb4fMfnXrkEO1OB9nt99llemfzUiYcSCe88/mqp+YoDeULeeoBysIWdDNCR6neKwe/cPvtDHY0YseE+j0H8IkrsVN9Vz5kncnQcmrZB94bOgbxkazF1noXGj7k2EZYsSXq6wPgZ6BUFGSBvbChzRzzONPs8LhdO0pkgOeZ4KGS+dLmJqLFExCJIvw4hG6RxAS5HUR84JmzxKXgml2kxmXjaBpyOIqZwWDcySm032lF9SQ1HCZ2oyACnVBPPN5mOem13xwYNJwE0cw4lmPXKMIZ6cVanF+ZC7TbbiNyt8S+ft60MkhsREEWT8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <linux-ext4@vger.kernel.org>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>, <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Is it possible to make ext4 images reproducible even after filesystem
 operations ?
Thread-Topic: Is it possible to make ext4 images reproducible even after
 filesystem operations ?
Thread-Index: AQHbbAAVquWdDiPLDEGVbp6qNXKc6g==
Date: Tue, 21 Jan 2025 12:29:16 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB966943691EBB5DA3F5F85621C4E62@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TY3PR01MB11561:EE_
x-ms-office365-filtering-correlation-id: 1991473a-c5d2-48c1-6653-08dd3a17386a
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RzNWbjZoMmtNMzRZMWlLMmx3OXBnanFkTnpZdDJJb3lhRyt5U2ZxRGtEYXZR?=
 =?utf-8?B?NGdidHlpbFN6NlNsbStYc3p0M0pYTndEUjVjNEJvK0N1YnU0d0tObFZwaTIr?=
 =?utf-8?B?VGl0NU1EYXJheDVvRXA0ajk1bmdEcW1Va1UwQmdTNUg2K1NHajFoaXN1eW9i?=
 =?utf-8?B?K21RRm82bE1mczFmdDBNZ1lBUVQ4V2JsaGU1SGZRdi93Y2RWejRvdjJsN3hY?=
 =?utf-8?B?WW9pWVNXbGxvMVVaZk9QRFRxOXo1ejV5YjhzMzZXbzdJUUYvVWlKNHlnV2pU?=
 =?utf-8?B?N1JZZHBWUjdYVmZmTWc4em1UcXhEeERqK3JJY1pzQ2pMM3JzWjlicjVRR1Fx?=
 =?utf-8?B?Vlp1QXBzUGpTUWNYRkZxS3I4SXdBN3dXZWNUdXZtMWNYU1cwSk9sY2cveE12?=
 =?utf-8?B?cVlaNDJGSGVwNVpZRldzbTM2QmlyWHIwMmRGa0M4dXd5RFoxTmwwZG9WNXNp?=
 =?utf-8?B?N2M5NTllM1RjYkE2dWxzV1RveW1qNThYdmVhNFJNaStUU2xKQ3FPb1Q2WEhS?=
 =?utf-8?B?aGZqbFNjVkRDYUE1REsvclc3MUJLVVE2eUk1UG9BV1lnVm5iWTl5bnhlS0ZX?=
 =?utf-8?B?NUNadVhPbzIveThjOW5MZG9JL01ManlYME5GSW9GOGxyVVJ0SGV2VTJLYXlN?=
 =?utf-8?B?ZEdFS0pObVNtMi9Yd2c0Tkk2SkFQQlFpOTdnQmZrOTZZTGxrQXlubGtxL3la?=
 =?utf-8?B?bFlDN1RjS1lpVjcyWFRidkMrZmRZdW5YcCtsTld1WklGd1N2MWFvbGgrWndX?=
 =?utf-8?B?WjJ0V0cyeDJ6aWc4em45UDgrRm52N2o3TFppcEEvaGE1REtueEhvN1dYbm5Q?=
 =?utf-8?B?RC9Vd1JTTnlGd25zTC96dmdseXU5U3ZxNllSNWc1eDZqSmFWYncvcUVUY0lv?=
 =?utf-8?B?OVE5MXlqdnZtOGMxb0hkN2U1WmgrN2VGaUtlc3dZSnlIdjZGUUFVOFlKNkFz?=
 =?utf-8?B?SzI3SlFRd2tDbjgrcm9NRDNWYm51cWRXQ08rS01ycWwzTVNpZUdDVGljZnNQ?=
 =?utf-8?B?ZDNLWUI1cmFCOFVwNzRLMVhVa0ZrUnd2aVFlWHpNSEFMOHFCdURWVzcwcnlx?=
 =?utf-8?B?NVFOdEl5ODQ4Nm1ZNVIxbEU2cDI2L2d4cFJPa3FwV1hiMkJDejhDM1lIcVN6?=
 =?utf-8?B?YXpPNk42SHF6OW9SemZ2aVR2Wm51Tk03SGdtUDJ4VWh3VzV6TSt5OGo3aE8w?=
 =?utf-8?B?OE0vVDhiNTlycWZrVnZGR0h0V0liend1dGEyc2REUW4wN3E3TTkxNy94MFVj?=
 =?utf-8?B?TjdVS1B6NWI2czhrdE5GMGxZOG1qd29TRGVQLzVxTWsxSmRwUWhSMVRNZ1hp?=
 =?utf-8?B?Sk80bDRnWDduaHl4ak94bVV6VlNNMSt5UW9CemJzWW5TeHAwOWtBZVA1ZTBw?=
 =?utf-8?B?bENQNG8wZzd3K3k2VXcrbmdnNktma3FUbFpkYnhzcFp4WWRaZmZDbmJLOHZh?=
 =?utf-8?B?bWNqMkJQdVhNK2l3WXUwYVJYeFQraWxpYmJhaElzZGlXV2piQjdYME1EVW83?=
 =?utf-8?B?THlKblF4b0JZMnc4WEpMY3JHWXBXdGZCZ2lJT1VNUkg3N1NTemVrK3FEMm52?=
 =?utf-8?B?Mm1GUDdHb0QvdjM2azVKN1h3cXFLS3pCbHpNZytpeU4zZytJSkRYKzMxcTBy?=
 =?utf-8?B?WmR6a2YyMHdaSkRoaWdvZTRkT2EvRTF0bWIxSXZ6dTlxaDJtNytneXNuSTJJ?=
 =?utf-8?B?cW8yMkUrc3NyanVSd1hjbHIzd0s0UTkrRFZNOER3S0x6WkRLekxGaU5JN2Er?=
 =?utf-8?B?NVRCYkhaYm1vTGtxUGRrQWQzQUExQURMSmo5N1FPZHVCSGpFc2o1eG4zVXZk?=
 =?utf-8?B?Qnd4NUlHc245S3ZrNDBYNERkZldocUx3NlEwNVNIMStPYks4MURNVHFTRjVl?=
 =?utf-8?B?SHpYM05KWlRQakRGSkpRdWxxSlZJT0dwb3IzcTNVQmlUeENxWGhmNmFORjg4?=
 =?utf-8?Q?HtIhQKTmma0xqkdJZhXzeEhsG7i1vxEO?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aVREQjVqRFl3aS93N3I4R3lDWkdndDArMXVGNWNhSFdiQVd4ZkEzUXhqcTU1?=
 =?utf-8?B?Z0lXaVpPYkJ3T1Z1NE8vVXlGOEUrbTNzRmFwd09YQXRtZ1d4NVdnRFg1L3A4?=
 =?utf-8?B?UGh2OTA3QmpVRzQweWVBYy9lb2dMQkxMdzZsNDhKOGlxc0JqL0dVdWswN0tL?=
 =?utf-8?B?SkxBSTkvK3k1blFzUUs5MlNZaG1QY2RrK3kzU2FFMEhSU2Q0ZGNqVWJiWVVy?=
 =?utf-8?B?UTZ5Q3ozNk9EZEZQSjZ6UHBOWlU2NlduK0h3KzRxNEpJWFZwaVVBOCtOdGgx?=
 =?utf-8?B?aEUvdElmRGZRM0NzTlpaNWF5bTluc3RXS3RIL1NWUXVCSU1zblBUM2RSeTM4?=
 =?utf-8?B?ZHZsdW0xR2t6NStVM2p3UTFTWkc1dzlJMGxFRXBpcklyUGl4WnZXSE5lZklH?=
 =?utf-8?B?YmlzWDZCVDlJNFo0UUhsQXhrNUVOK0U5dHBCRUJ5SnpvVFlFOXJkV0svbmw3?=
 =?utf-8?B?dzNsNjBwNHByUGlBMGw0UEhXZE14SC8wM0J1THMwcEh3VVFmb1A4MU5wWUpI?=
 =?utf-8?B?Lzg2RVdiQzA5RE9TNVdVWUJJOEZQV25JUDhFaHZ0OFAzM2NHTVZ3VWhxa1Uv?=
 =?utf-8?B?Q3NoWk5lWlJIN3NaOTQyOEgyVko0V0ZKTHd6Y3pPbFBBcHNMYSttR0VIMHl4?=
 =?utf-8?B?OW9OU2xJZjRsb0RKTTFveDhXRFcvVWZKbjRJbkRHUVFwYmh4NzRFOHpnSXlz?=
 =?utf-8?B?UjZ5Q1pTVjF4cG4yaHlXTTZtdlRnN2cxQis2bVNlUXFtb3BHV2xUNnNTMEt1?=
 =?utf-8?B?UTlmUU1WWk9VQ0UwRmc3aWVmUjhjc1NpWnNDRjhRUDVlamlVMWNCcndwb3NG?=
 =?utf-8?B?TlVDOUFiYmNqTC9FN2JKL1ptZ0x0TERxVGk1SmNidFp3Vzg4VTRTSkFqM051?=
 =?utf-8?B?dGJtZnpLYnBibDRwUHhoeXV6ZUtrZGJlbVh4L1hCclFZM1RzYUJkb29TRVYx?=
 =?utf-8?B?UXM1RDUxeE5ySjZTNEVsV2c5Nm1yZlJ1bVgzVTEzb0xUUGFYNnhBVmZCTHVn?=
 =?utf-8?B?WHUrM3d0d3R5WGc4aGI2Q2xPTGkzZ2UxU3ZDRHExcDNvUjZRcGVJaWZqY3Ns?=
 =?utf-8?B?aEtqb1RPOFZPVDZ1WVI0YXo4MlQ1bm95Y0FhNGczeW5GUERFcnM4NnFHaE1s?=
 =?utf-8?B?MXMxMEd6cE5LRlE0cnJua1k5cHpQMTYyYm5reGhQZXhaRDJpR1FiVmd4d1l2?=
 =?utf-8?B?OU9PTWd1K3pRcFFYa0NFZWZkcWVyZHUycDRORkY2dTFxd0ZCYldic2dDNGhZ?=
 =?utf-8?B?anRldWJiL0R6RWdaTzR3RFl5cHRDd2lsbWxvSXlsbjNsVDk5QjBPbGM5Y2hT?=
 =?utf-8?B?ZDQrNVVneDhCRXJ3bkdRSWxDMVR5QXdVYmhWcncvUUFTb0Rhb2pGZGNseENP?=
 =?utf-8?B?ZDJmb1pmMmQrdWtkTFBWSEp0azJRZEpiMFY4cityQk1xYS9YcGJyZU5MUVZZ?=
 =?utf-8?B?OS9pWnFrcGxOaHJ1WEJ5cW9GYUpjQ0ZFVnNOaXR5MHF4MWFLWXdNMldDVGMw?=
 =?utf-8?B?d0dPZDFSTlZEcW5kTDNZeS9Nbnd1aUZYWkhEVG1YdTd5RjZGMDEvK2NWejJJ?=
 =?utf-8?B?eXlyZFlFbnVXSTAwRzBabkl4RHI4SDA5VUpIRjgwZjNKSVhBMlBwclJxZEpT?=
 =?utf-8?B?SmZDMnJ4eXFSTWkvQXI1ZVZUVUlFRUhZZUQ4cGFhM09NWkVDRlBid2ozSDRi?=
 =?utf-8?B?bUVFVWhMekVZUG80TFFlZHR5QTVoZlpjZHRBRE8zcStyYThHWndIOU9oM3p3?=
 =?utf-8?B?NjRJcDNtWklCd3dXOHNiVnpnRmFoQ3k4N0Fuek5EelJ1SUtHaUFkT3pBYlJF?=
 =?utf-8?B?NDY3Sk5nNW9vQllWNERPb2xNZXluUkpvK1FwczRRVmRhOHF0cmNleEsyL1Vx?=
 =?utf-8?B?Ynk0OXpEaHoxN3VTU2pzUWxMZXd0eVRVamFIaERsQWViVlpQOTVTY0x3MGhN?=
 =?utf-8?B?cjFSOXYzNjNJSUltUVFyTzV5UWYrUjcrUlIzRXdoOTlHaHVadnpKQXRGZ1pi?=
 =?utf-8?B?bW96aENKTGtlQzg2bjB3Zkp2OGN4OVdsYlpWaFNSREF0TjVSeHhjeFFaVE1m?=
 =?utf-8?B?WHg4azFwUXhUdy9KRmdhakkrV0VtaktPZWhEVVhENWtQSWpPdlpNenhmL0d6?=
 =?utf-8?B?cnRGK3Y5NzE0d2NUSHpYKzBrU1pvSjVzYmUwREVkbDZZOFZ0RS91eDlDcXhj?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1991473a-c5d2-48c1-6653-08dd3a17386a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 12:29:16.1090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZ+pB6nBQaAzNtnYU5ISCAysr2FUDqeG276M04FlNwtSlIS2Lo8nz5FNh98x9TZ3lr+2CMZXX6CBQX8yY7+FoOzs9ezQmfT4oxsSVKG/b6KPSeK4k0WNSV13PzvI3leL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11561

SGkgQWxsLAoKSSBhbSB3b3JraW5nIHRvd2FyZHMgcmVwcm9kdWNpYmxlIGJ1aWxkcyBmb3IgYSBw
cm9qZWN0IHRoYXQgSSBhbSBpbnZvbHZlZCBpbi4gV2UgdXNlIGEgZmV3IGV4dDQgcGFydGl0aW9u
cyBpbiBvdXIgZGlzayBpbWFnZXMgYW5kIEkgYW0gdHJ5aW5nIHRvIG1ha2UgdGhlIGV4dDQgZmls
ZXN5c3RlbXMgcmVwcm9kdWNpYmxlLgoKSSB1bmRlcnN0YW5kIHRoYXQgZnJvbSBlMmZzcHJvZ3Mg
djEuNDcuMSBvbndhcmRzIHdlIGNhbiBjcmVhdGUgYSByZXByb2R1Y2libGUgZXh0NCBmaWxlc3lz
dGVtIGltYWdlLiBXZSBjYW4gaW5kZWVkIGNyZWF0ZSBhIHJlcHJvZHVjaWJsZSBleHQ0IGZpbGVz
eXN0ZW0gaW1hZ2Ugd2hlbiB3ZSB1c2UgdGhlICItZCIgb3B0aW9uIGluICJta2UyZnMiIGNvbW1h
bmQgdG8gcGFzcyB0aGUgY29udGVudHMgb2YgdGhlIGZpbGVzeXN0ZW0gYXQgdGhlIHRpbWUgb2Yg
Y3JlYXRpb24gb2YgdGhlIGZpbGVzeXN0ZW0gaXRzZWxmLiBJIHVuZGVyc3RhbmQgdGhhdCB0aGVy
ZSBhcmUgYSBmZXcgb3RoZXIgcGFyYW1ldGVycyB0aGF0IG5lZWRzIHRvIHBhc3NlZCB0byB0aGUg
Im1rZTJmcyIgY29tbWFuZCBsaWtlIGEgZGV0ZXJtaW5pc3RpYyBVVUlEIGFuZCBoYXNoX3NlZWQg
dmFsdWVzIHRvIG1ha2UgdGhlIGZpbGVzeXN0ZW0gaW1hZ2UgcmVwcm9kdWNpYmxlLgoKSW4gdGhl
IHByb2plY3QgdGhhdCBJIGFtIHdvcmtpbmcgb24sIHRoZXJlIGFyZSBzb21lIG1vdW50IG9wZXJh
dGlvbnMgZG9uZSBvbiB0aGUgZmlsZXN5c3RlbSB0byBjb3B5IGNlcnRhaW4gZmlsZXMgaW50byB0
aGUgZmlsZSBzeXN0ZW0uIFRoaXMgdXBkYXRlcyB0aGUgIkxhc3QgbW91bnQiIGFuZCAiTGFzdCB3
cml0ZSIgdGltZXN0YW1wcyBpbiB0aGUgZmlsZXN5c3RlbSBtZXRhZGF0YSAoY29uZmlybWVkIHRo
aXMgd2l0aCBkdW1wZTJmcykgdGhlcmVieSBtYWtpbmcgdGhlIGltYWdlcyBnZW5lcmF0ZWQgbm90
IHJlcHJvZHVjaWJsZS4KwqAKSSB3b3VsZCBsaWtlIHRvIHVuZGVyc3RhbmQgaWYgaXRzIHBvc3Np
YmxlIHRvIG1ha2UgdGhlIGV4dDQgaW1hZ2VzIHJlcHJvZHVjaWJsZSBldmVuIGFmdGVyIGZpbGVz
eXN0ZW0gb3BlcmF0aW9ucyBsaWtlIG1vdW50aW5nIGFuZCB1bm1vdW50aW5nIHRoZSBmaWxlc3lz
dGVtID8KClRoYW5rcyBhbmQgUmVnYXJkcywKQWRpdGh5YSBCYWxha3VtYXIKCg==


