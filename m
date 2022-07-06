Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152865684A3
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Jul 2022 12:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiGFKG0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Jul 2022 06:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiGFKGX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Jul 2022 06:06:23 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Jul 2022 03:06:22 PDT
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B01B25284
        for <linux-ext4@vger.kernel.org>; Wed,  6 Jul 2022 03:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657101982; x=1688637982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tP6Up5PEmmOIyVAnCyedJ3lBrOq55WDnqEnuqCDY0BA=;
  b=nk3dhZDskxRvCmlHfxJW6d09x+rSxMkh+ngMBQjSwSq3kz08wKaHaiWV
   enfnj3S9Oc52AkfsLkltg6cBRyyvO7WsoGFKpIvNnMnjL6xX9VBx8Byz1
   icbI8UlSa39nGAEP5e+tfUBIK8yIoYDe+qBBNDYXMOnBIgc1WHp47POpm
   nE3tyEVuynyN0b0ZVFadkyIRsiaK33GkTuQp7qpFYrbqV4iit7oOwMybo
   Y7XDl58AqxCWP/1NL7cCvdnTXCRy9rM8rNyEo0cqP0fmXC/iqGeDzfluL
   XHXJKVtayUP7Wz/D3SFcAjZ4+MlOrgbiIbF/tYaI6pgBsE6GZgh9+uiQ4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="59919436"
X-IronPort-AV: E=Sophos;i="5.92,249,1650898800"; 
   d="scan'208";a="59919436"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 19:05:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDKhzjWuxtj/jgseRy48qIspL3t29S4DSZaI9Kx38H1bQMMPioUBIdlBu4S5Eo8aYgg4Iy4+e/3+bebt3B1ib3PKPzgzqqOcXoZhVSiW9kaoeMS9K7TEA334zpC/1Plt+uPBgfdQA+lAUB42V5t63mzhC1vXux259fFtntTrTYd2/libKKHNu/L2S4BvM/OFfJa2xMVLCX40//Oqg/NhLH9Nm7DGhuBXVV4IN2QTX3FmDMEIV4annDmVrH4xil/iPp5Tj96EufSzasIPkcEnWKdKWII3MK2xZBzzgFElpAt8mJlt6WcjKyCG7cNTrhC3iLK9ow5AvasUD/AdkpZY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP6Up5PEmmOIyVAnCyedJ3lBrOq55WDnqEnuqCDY0BA=;
 b=cfSHmtNS7yJBXaSWAiAbMUROWPnvTWwT207Cj++K9X2IYzShFBXtdQr2Yn1e4r1Uu0FeYOjMaVxXhIQaKwYapE87O3PQ5VvO2dg7zNPxUOEXt8Oer+35d50mIdFFqrf48d6bQvTNf8Cm5VjbgqC+LKBGbpM6/GXAXRRODLg3MazPyPccvplD+qp7Ul8oUJOHZ1qnpNP/PDjtSSKWnP2EYPYITEgG/1qA7lxGskjRjlVYSoFk1uiK3GySDyxjv7wm96XvC1fnE3edYB+ble+/RI8e2uMbJQTn60vKWMaal71CG0HCBfu/nbVxPoPcHFJ2Bzah9AFOaJh/pDT1mfGQMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP6Up5PEmmOIyVAnCyedJ3lBrOq55WDnqEnuqCDY0BA=;
 b=Pl6JP7fl2y6xvCubPx2kFNqN6/grkUQZ7NdhChWMn8wzkNlxDp4Q7qUOihIqEd/KocM9eCLlCnYx5A9S+k896DrxwTgNAv7nZ+F8hAZZo8iYG1Phu4Diq21/N+sKFrxX6XG2DQh0HgW+onTcR4rgEVsoy0Q8TwjgBJkqE6RM+xI=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 10:05:14 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fd30:6d2d:85fb:8160%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 10:05:14 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Lukas Czerner <lczerner@redhat.com>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: Remove deprecated flag for noacl and noxattr_user
 mount options
Thread-Topic: [PATCH] ext4: Remove deprecated flag for noacl and noxattr_user
 mount options
Thread-Index: AQHYdl9bBuEdaxES60uswzp9NYFZ0a079EaAgDVvxgA=
Date:   Wed, 6 Jul 2022 10:05:14 +0000
Message-ID: <62C56CA2.2050701@fujitsu.com>
References: <1654164099-2164-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220602110421.ymoug3rwfspmryqg@fedora>
In-Reply-To: <20220602110421.ymoug3rwfspmryqg@fedora>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 437d42aa-79ae-40e2-33e9-08da5f370566
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CIhJVGkci9jXDwPvxpAj3tsDC+3PM7+x4V8UwdQ4zKxgYbob7HNOYazDTJwSu7LB/httlFzrWPW2nKJasRh+lV9cl0RS6M7s7uNYpmSpkoKhxmH9QXHImY7GkWHOolE3UVUU7arIqkxXQicXJJm+bp+lS1IuDB009kZ3pfztjpVTbLsuo+PYKbDBeWrNQb8MvrPDHkWtRhzPNZ7xX/0iHgkzrac5Fu0lT5hnHo1IRIEpB+a6l89+03q7J9yDJoP5FK3YAiPKYJ2FzRZNDEAU0nUlMpi5apqkBxoiReBmhD4aHgdMd7KkpR1pDNKKgbAr8OMI/ZHrPy1s3/5C7c6emhty3SdMz/lv3WHvID0JSHNg5MK5jyJ/6AgAZzGBPwTtGMc/Fz8tYtcrKWqndCMdUzZ7+r99pqa4SfdX4z0zfUFEZXyB9cQv4sder3I+4Z4aOwgNyCg5Aoz6T6biWf1eIVAOyo+vfWlgA2uEEQ1KPXLTPQgmMjwVqJLgFWtfA+/Rt8E8u4VmkdfC+URr2gO+2NCJb66bUwRlzK7EI5L71PPfeCxqy4xucY+jAs6Lu21Bu9k22oE/AnQTI62GH3c9YvmnhC4LktKsHDb0zCloObxxLbHTZMBB/2g/siASHKlP5bXYRkpDYYhJGwiyzRmWTYf3ZY4ZpA0WuDlbsAoZ58tHK8uRlRkaJgf9ITkmvUjY24Ig5eJQWZYH+2EKMYqvhepxxw8MdZ2mCnhYrvWgh7iC+4gUhzQSgjjtCs7ZLEmWxfgaCIpbAbxuKTwRz+mS/uTfiU2gMGt60uAlItHachRk/CcGP/IDm3G3UzOBuchv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(85182001)(36756003)(26005)(6506007)(6486002)(2616005)(6512007)(186003)(38070700005)(83380400001)(478600001)(122000001)(38100700002)(2906002)(82960400001)(87266011)(33656002)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(86362001)(41300700001)(8936002)(5660300002)(91956017)(6916009)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?OVd0UTFkMTV2UmVHbENJNEE3VStyalFPamhEMFJkUHdhL3hYVTVQeHdGVlha?=
 =?gb2312?B?c3d5ODBrdE51blM4WXEvY09UWjJyRnMrcEx5cjlRNk9VNWFobm5makp4NmdX?=
 =?gb2312?B?SDlnekJMOEhSb0Rhb25zSjBubUwzUExOMWh0Mi9BNUQvZDFlUnBjMlhxWDJn?=
 =?gb2312?B?VDNDOG1MOXhsZkJZdHFJTTR3czljRUt4NlRLcFM3M2xtV2RoQ0hnQVQwZlgw?=
 =?gb2312?B?VUpncyt1VGFCNnlOdHFuRGhwZ21jL0dGT2puaHl5SXpNSFVqV2tGMFBicWFF?=
 =?gb2312?B?Vk1zeW11WDYwemlXUkVwNGd5UEEyaVJROFpqVGxDOERWanM0c3lDak9zNUFP?=
 =?gb2312?B?ZHFyOGRPbk9zNEtTVUxEenhERXJPcUM0Z050bDROZEhEY2wyV3BQNitpOXhD?=
 =?gb2312?B?aDUydGRQRUFDQmE0Y0sxcklsTFpoN1JLbXJFOFk3ekRNVi9rZDFKRGFyV3Jt?=
 =?gb2312?B?ZFhrQVNaZVM1ajdIU1JSaW02UVpxSU1EQ095aUdiYWI5MmxlZFYzMzROanZw?=
 =?gb2312?B?Y01aajMzQ3piNmJOWTJSd3RXYzgzK2pFbWE3aGMvcVU4dGFjakt2WGdqWkNX?=
 =?gb2312?B?aVlxTXlid0phVHZ1VFFVc1BrTjJOOG5YM29NR2hYOHREWG1KeTdGT09Ja2Jt?=
 =?gb2312?B?S1ZMblk3SjZXZFJPVjNtYlgxc24xTVF5NEJ5d01SWmlpRGNZL3FBTEFncTlP?=
 =?gb2312?B?UDZyWTBLQjRyRlg0TEdDUDlvdEc0azFucDZkekZobmdBOFZIdk5qbkF4ZnMy?=
 =?gb2312?B?UTkyZFlrSG93OWpmcnlZaWloTFF1N3NXVHJBbUQ2bExkYmZZUG8xMXdCdUxP?=
 =?gb2312?B?ek92RGhqVzYxeDgrZmpoNHdmWW1ESzY0SXFrQlE4T1ZOMFpscDJkZEp2U2lN?=
 =?gb2312?B?VVhOR0EvbEdDd1lJcDR6VzhKbWNGcTRvVWdmL3c5citKaDlqM21MMEQ1QmJu?=
 =?gb2312?B?YURKMzB3UE1Sbnk1ZnpnZWJpZ0x1RTFrUDJCaTUySHp6NFZCSE5waVNKVEtE?=
 =?gb2312?B?VnpMcmd4U1N1R2RpVTQ0ckJta3FobzhzK0VWR2grK2NuYkVkeWphdVZYcFc3?=
 =?gb2312?B?dWJnNmJHMGZMT3Z0b0RRL3A3T2xyOHQ2N3hySW5HOGxQdWM5SGVJTlZ5Z3o2?=
 =?gb2312?B?dGhGemZPSW4xVTZ0bGlNa2lmSWlOOVliTnczRWpvTUlpV1B5Q28vejlqaWJn?=
 =?gb2312?B?WmIyTy85RVBON0toWitPQ2d3Y1ByRjd6MlR0My9OMzhKR2JRYTFxWnFqdnBs?=
 =?gb2312?B?NTlVZ3BmUTVtVCtGL0xUQlY0Y08yVzY5UkM0cnpFZXBjMFVsVjVweTlOQXJW?=
 =?gb2312?B?eldCMkttQk95QldFamVsd1l1WnhIait3NUJoRk52V3czNlArYnIweHI4dHNj?=
 =?gb2312?B?cUtYVlUzVnlLMUl3NVFqNmN5ZWRTUFZRUEdhMDVzTTh3NTRjaG1MNEJKSmsr?=
 =?gb2312?B?QmlFUjJJaTI3UlJoN1lFVmJOUGI3cG42NHJGUFRXUnFBOWR0YVFWeDdlMXpW?=
 =?gb2312?B?aG96ajBBbU5JbEV4UzVRbHR2SU5aa3l1c0dUNzQ1L05pcTVlOEFPWHI5WXJw?=
 =?gb2312?B?RlJxMW9UUGdUYVcwY0tuVmo1NzZIcnA1cFhKeWphZzhwbzVUOFlUNlJTV21S?=
 =?gb2312?B?UWp1dEtwNlphQkhLNW5IR2tRYk9ueUxhTkdKNXBNOHgxcFI2djJmVmZpSjdx?=
 =?gb2312?B?aVRCTWNPY0NEcGhqdGFUVTdTZVB6UWdZdnRTNm1ZRFNlczBtU0hlYWNDQzRV?=
 =?gb2312?B?eWlVSDltdE44QTNQeW4zSk9EcmErWVlmKzlRYWFHYW1BdVZtdFJzbFArTEdk?=
 =?gb2312?B?YmttWTF2QVpHa3JMcVB1VTFoV3FERFZMQUNsZkkxZFVDQlJsUWh3bXdhRUpJ?=
 =?gb2312?B?VWZZWW50ZE5QSHJaTlYyTDQ4Q2VKZ3JYUEc2c1NENkZNNkwxVU5BL2RsMHp2?=
 =?gb2312?B?ZGJYUHdiaVQrSnVqRlFaQ2NYRmVJM3MxbHJTRXdocEJQWXFWL1ArS0FMa2xR?=
 =?gb2312?B?bFFCVUk1UTNwSXV2cXh3UkZKcnZoNlNpUjFFZDVaK3BKQkl2bWhpS0owUkIr?=
 =?gb2312?B?L2ZIL21IN2xJbDl2UGZhZHg3VW5EZ2hBNzdENVhick9PTUJ1VFZmS2cyZExa?=
 =?gb2312?B?T21JRVZkWFc4cXY4K3B5S2RvTVFlN29sVktaejRQeVU2OWFPaHVKcXFQbkdk?=
 =?gb2312?B?VVE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <5E02A41CABF43046A5120B6953A9A009@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437d42aa-79ae-40e2-33e9-08da5f370566
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 10:05:14.4458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KMVicmo5ijlK3gMpAymtMghCsrFI1/kp/4j5dDDrQovNVoDiAVx4jZFzji72cFiACU/CtdzqYdEIujzh/gFSba7x+N+ZSPhNJaCPTGxmnN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6453
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

b24gMjAyMi8wNi8wMiAxOTowNCwgTHVrYXMgQ3plcm5lciB3cm90ZToNCj4gT24gVGh1LCBKdW4g
MDIsIDIwMjIgYXQgMDY6MDE6MzlQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IFNpbmNlIGtl
cm5lbCBjb21taXQgZjcwNDg2MDU1ZWUzICgiZXh0NDogdHJ5IHRvIGRlcHJlY2F0ZSBub2FjbCBh
bmQNCj4+IG5veGF0dHJfdXNlciBtb3VudCBvcHRpb25zIiksIHdlIGRlcHJlY2F0ZWQgdGhlc2Ug
dHdvIG1vdW50IG9wdGlvbnMNCj4+IGJlY2F1c2Ugbm8gb3RoZXIgZmlsZXN5c3RlbSB1c2VkIHRo
ZQ0KPj4NCj4+IEJ1dCBub3csIGFjbCBoYXMgYmVlbiB1c2VkIGJ5IGV4dDQgZXh0MiBidHJmcyBm
MmZzIG9jZnMyIGFuZCBub3hhdHRyX3VzZXINCj4+IGhhcyBiZWVuIHVzZWQgYnkgZXh0NCBleHQy
IGYyZnMgb2NmczIuDQo+DQoNCkZpcnN0bHksIHNvcnJ5IGZvciB0aGlzIGxhdGUgcmVwbHkuIEkg
YW0gYnVzeSB3aXRoIG90aGVyIGltcG9ydGFudCB0aGluZyANCmxhc3QgbW9udGguDQoNCj4gQW5k
IG1hbnkgb3RoZXIgZnMgZG9uJ3QgaGF2ZSBpdC4gSXMgdGhhdCB5b3VyIG9ubHkgcmVhc29uIGZv
ciBkcm9wcGluZw0KPiB0aGUgZGVwcmVjYXRpb24/DQoNCllFUy4NCg0KPiBJIGNhbiBlYXNpbHkg
aW1hZ2luZSB0aGF0IHRob3NlIGZzIGdvdCBpdCBiZWNhdXNlIGV4dDQNCj4gaGFkIGl0IGF0IHRo
ZSB0aW1lLg0KDQpNYXliZS4NCg0KPg0KPiBNb3Jlb3ZlciB0aGUgZGVwcmVjYXRpb24gbWVzc2Fn
ZSBoYXMgYmVlbiB0aGVyZSBmb3IgMTAgeWVhcnMsIGhhdmUgd2UNCj4gc2VlbiBhbnlvbmUgYWN0
dWFsbHkgY29tcGxhaW5pbmcgdGhhdCB0aGV5IHdhbnQgdG8ga2VlcCBpdD8NCg0KSSBkb24ndCBz
ZWUgYW55IGNvbXBsYWlucyBzaW5jZSAyMDE4IGJlY2F1c2UgSSBzdGFydCB0byB0ZXN0IHhmcy9l
eHQ0IA0Kc2luY2UgdGhhdCB0aW1lDQoNCj4NCj4gV2h5IG5vdCB0byBqdXN0IHJlbW92ZSB0aGUg
b3B0aW9uLiBJIGRvbid0IGhhdmUgYSBzdHJvbmcgb3BpbmlvbiBlaXRoZXINCj4gd2F5LCBidXQg
aXQgd291bGQgYmUgbmljZSB0byByZW1vdmUgc3R1ZmYgd2UgZG9uJ3QgbmVlZC4gRG8geW91IGhh
dmUgYQ0KPiB1c2UgY2FzZSBmb3IgaXQ/IElmIG5vdCwgY2FuIHdlIG1ha2UgaXQgT3B0X3JlbW92
ZWQ/DQoNCkkgZG9uJ3QgaGF2ZSB1c2UgY2FzZSBmb3IgaXQuIE9LLCB3aWxsIHNlbmQgYSByZW1v
dmUgcGF0Y2ggdG9tb3Jyb3cuDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KPg0KPiAtTHVrYXMN
Cj4NCj4+DQo+PiBJIHRoaW5rIGl0IGlzIHRpbWUgdG8gcmVtb3ZlIGRlcHJlY2F0ZWQgZmxhZyBm
b3IgdGhlbS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1PHh1eWFuZzIwMTguanlAZnVq
aXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgZnMvZXh0NC9zdXBlci5jIHwgNCAtLS0tDQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9leHQ0
L3N1cGVyLmMgYi9mcy9leHQ0L3N1cGVyLmMNCj4+IGluZGV4IDQ1MGM5MThkNjhmYy4uOGEwY2M4
ODE1ZWU3IDEwMDY0NA0KPj4gLS0tIGEvZnMvZXh0NC9zdXBlci5jDQo+PiArKysgYi9mcy9leHQ0
L3N1cGVyLmMNCj4+IEBAIC0yMTE2LDEwICsyMTE2LDYgQEAgc3RhdGljIGludCBleHQ0X3BhcnNl
X3BhcmFtKHN0cnVjdCBmc19jb250ZXh0ICpmYywgc3RydWN0IGZzX3BhcmFtZXRlciAqcGFyYW0p
DQo+PiAgIAkJZWxzZQ0KPj4gICAJCQlyZXR1cm4gbm90ZV9xZl9uYW1lKGZjLCBHUlBRVU9UQSwg
cGFyYW0pOw0KPj4gICAjZW5kaWYNCj4+IC0JY2FzZSBPcHRfbm9hY2w6DQo+PiAtCWNhc2UgT3B0
X25vdXNlcl94YXR0cjoNCj4+IC0JCWV4dDRfbXNnKE5VTEwsIEtFUk5fV0FSTklORywgZGVwcmVj
YXRlZF9tc2csIHBhcmFtLT5rZXksICIzLjUiKTsNCj4+IC0JCWJyZWFrOw0KPj4gICAJY2FzZSBP
cHRfc2I6DQo+PiAgIAkJaWYgKGZjLT5wdXJwb3NlID09IEZTX0NPTlRFWFRfRk9SX1JFQ09ORklH
VVJFKSB7DQo+PiAgIAkJCWV4dDRfbXNnKE5VTEwsIEtFUk5fV0FSTklORywNCj4+IC0tDQo+PiAy
LjIzLjANCj4+DQo+DQo=
