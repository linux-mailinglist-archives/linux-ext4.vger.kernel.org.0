Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC12504D35
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Apr 2022 09:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiDRHhk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Apr 2022 03:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiDRHhi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Apr 2022 03:37:38 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A8C38AB;
        Mon, 18 Apr 2022 00:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhK2JhXJDR/R22t+R9xYWSHGcR1mic8jJQZzIiRnwyC9BJm+7gR0YYs/fx3N09t/h41sDQDZxDQSMFF6KSwIMDSCQPkopA0i+TUVgRpQlh3zE6VyJ6aDWDIJb399w55hf6VJ0iQ5Tkyg/e0G5uEennW6oEMSKTTwIXWi0oxvK/2SfPRSeYptdbJPlOmgm5zN1ZFNUFYr+tDbPGupXIJMMSlr8ZV4yNmsZJeoZWL0nlrpczQ7yofn/ctXfBA0ZD6ELjfRmpoOLu3Ql2ToC3pUDHJPPBLJHY2Ic3yLBIT3hMYCesGmivJ/cMzgXuypd2NHodcy2mQUdmMRe+9dKm3JeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Nt9aVquNVmsPTtbD/3E4RNI1+P1NH6YIYQj3/EGpqM=;
 b=A1rA/r02ndoCGR1ZB+sEXldkmJMn5Ins3WAMwQMjlDQWu5umcqh/DjVcK3qXfqi47YLV+UduDKkGYVJTP5DbxhdQsZzam/t666IKXlZQWxXqeVeLpPBBlkZ4lQtyKg5fM8o0ZTIBuqnXxVa+5AkoLjAbkKvEem1XXmjqYA1x/NlNKe3VelzwjLUkIZmU2DEnKhe7TB2l5vZQpu8LBdSzjPjtqsxAAflWzzCiuxERkisFDs289OZDlG7zLMgCXYqFhgzON61ALD3Pww/Gf3yaSklWY0Wwhk18K5J9JANin9ezj4Ro/9PkUA/Ndq/MEUHLCJyfn4UAob8kyReQolB4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Nt9aVquNVmsPTtbD/3E4RNI1+P1NH6YIYQj3/EGpqM=;
 b=IMWGvuTITNHkOt/rSzaOV3k9eV5p4vHtPkcbnFzB+x137JRDgH/4jZTk1elr9sAzvd4syVte4s+QrIMtZppiuwN9Yu/31z/fIg1Xx0z4vSxD03yq+B2fjKXEf4qEfmrVqLx+FnVvXbi+uU8QY8ZGkYyKx8mmyjlJvIhZ8zP9cjo=
Received: from KL1PR0601MB4003.apcprd06.prod.outlook.com (2603:1096:820:26::6)
 by SEYPR06MB5158.apcprd06.prod.outlook.com (2603:1096:101:5a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 07:34:52 +0000
Received: from KL1PR0601MB4003.apcprd06.prod.outlook.com
 ([fe80::f0c7:9081:8b5a:7e7e]) by KL1PR0601MB4003.apcprd06.prod.outlook.com
 ([fe80::f0c7:9081:8b5a:7e7e%8]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 07:34:52 +0000
From:   =?gb2312?B?s6O37+mq?= <changfengnan@vivo.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: RE: [PATCH 2/3] f2fs: notify when device not supprt inlinecrypt
Thread-Topic: [PATCH 2/3] f2fs: notify when device not supprt inlinecrypt
Thread-Index: AQHYUu45GoDAOd0+BUSILnKkLO2jc6z1RCGAgAABOZA=
Date:   Mon, 18 Apr 2022 07:34:52 +0000
Message-ID: <KL1PR0601MB400369725474F2A2DE647057BBF39@KL1PR0601MB4003.apcprd06.prod.outlook.com>
References: <20220418063312.63181-1-changfengnan@vivo.com>
 <20220418063312.63181-2-changfengnan@vivo.com>
 <Yl0RmUoZypbVmayj@sol.localdomain>
In-Reply-To: <Yl0RmUoZypbVmayj@sol.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1459ad5-ea63-4305-97f6-08da210ded25
x-ms-traffictypediagnostic: SEYPR06MB5158:EE_
x-microsoft-antispam-prvs: <SEYPR06MB5158C0805EB72918535626EEBBF39@SEYPR06MB5158.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bFikLeW5ltHtYwYP74DlOcT0krCM5wsAYC0A1PSmHOjzGea0Q+aWzVn8YK1yS3WMO2LpuvZ/AiA0U0QIrRO6RzZ6aoXzVtmguLWF4IKV54Hqn1mjms3bEwRB+DFicbySbOoGWKadNFmUOJ6XUMaxT8Ha2S3/+TiHERjozxxasRvDeUjAmnQCOZEJQZm7O3N+fKEVEebrXRVO3Jk003LWJVB1TwDm2ueZpxriez2MaTUqAUE4fEET4Hrmu77pRbRBlUmuSulnq9br+oFtg6OMPocqFMLxFg7GUMwFzEI0F2F8iBg+zNtdItjEpLbgWOhpdV2boQ/tZDfyRGZFQ4vDdBV3nxixpLqL8ZtjddyM58o1gNfr7BnqWb6NNJW0Pi6+ES30r8SMYuIqYTQXW4Ii64fUPMlAg90Mr2cACOrzsA2NGGPJhnykT/vQw2YbFS/W8QN6h3+naenTiqGtGi+9xI10EK7NDztyeu7gH9CC8wnTm0z5L5296oU04nPNz3I08o19DFWV2HqtemKVf1N2Hp2vgOQGqICISk78ccg8GY1DnkY7f9oE/N74ClKJezzkPN0ljiO7X2yv/loMxwiuOXhDLH7xazRA6Xg25Mmc2RSDpNDHkYi/bwqe02WhLL1dypISq/f1ZNUSB2zTaPuc4T4TymyoEAhkcGzGeuS4d6dQ4zupZPcyFXRTcdysDbzEPE22kjJWgHPW658E3pSiEAmveD3SJNSOsfUBMGYj85malOG6Egq30AdrwbDljsJHVkkkRM7Q/pEu2uTfigGk3JENWVL13wNtUtjP6s+ZMHk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4003.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(186003)(66476007)(83380400001)(76116006)(66556008)(52536014)(8936002)(33656002)(55016003)(85182001)(86362001)(2906002)(5660300002)(66446008)(66946007)(6916009)(38070700005)(316002)(64756008)(122000001)(38100700002)(6506007)(26005)(53546011)(7696005)(9686003)(54906003)(8676002)(4326008)(508600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?b3ExRVRlelBPanhma1dkYWdQeFp1MDhPUnI0S01qZTRNQnplMnZzYXlTM3RS?=
 =?gb2312?B?YlV3V1lKd3hFNG5WUS8zeVI3QnpHSmdvTUtXbVJWOEVPbDJuQWZ3c3lqQXlx?=
 =?gb2312?B?L2thWTd1K3ByWkl6NUJTR0oyRGlKYlEzeTZJbVErNXBnYW9iT2x3eG44RUtL?=
 =?gb2312?B?YXhXZnFFeU9lZUwycW1ueHd5dmtRSnlRU2lieHRYTUxmdFhWbURVZWFzY0p0?=
 =?gb2312?B?OGZOLzVRQ3BQTmhEOVFsV29VcUtUV2VtWU9LcmFmbERWRzhEYVFRL0VFQVYv?=
 =?gb2312?B?anJ5M0hQTnNWbWdqZ1dPOTEyU3dUWG9UN0xOQzlSSmJuTWdyd05nZFpydFY3?=
 =?gb2312?B?RXBtVHN5Tm5OZEJIeEtGcVhJYXhCYVJDVnJ1em02VjVjaWI0NTEvelhDRjBR?=
 =?gb2312?B?b0x2dDB5NTFmQW1SZFBkczhENHkySkhsM1ROc0o2M1hsZi9Eaml0OWJzRTR6?=
 =?gb2312?B?V1hvQmx4T3VyMDFoUlQrd2pSR0NzM2pMUnpjT2pJcVFITThDcnhyV1NuNWUz?=
 =?gb2312?B?M2NvOGRoN1VvWVhaRktwclgydEFVWlI3N0xYUUlWMmJPc2NrMnhBUm9GeWpQ?=
 =?gb2312?B?bEp4MVRvVWVmT1RiczlTWUw3U04ydTdKVGxkd3NpTnR2RVFiSnE3YXFaY2JR?=
 =?gb2312?B?K0t2T2twVC9DQk1HSTJDenUxL1FpNm5mZWU5YWFpSGJkUitBNkEyMnZzVkgy?=
 =?gb2312?B?V0E4WTltL1A5b2orM2FDZDI0VCtUTWtGdVNXMnVPcXRLU0hTTVpZT1ZpWk5x?=
 =?gb2312?B?VTB5S2dIb3BtZnNvbDJBOHpzMjBMd3RsSzZoWlpQUnBqZGhZU09LWXZ4Y3RW?=
 =?gb2312?B?VGtiaWRlT2x6YVlsNDN4YlA0SWNZVnFYSkxXUmtkbzl3bDAvdFg1TEVlR3dx?=
 =?gb2312?B?NTlqaFV4WExwR3JNUHdVdTlqUXJIQ0p0R0xrUkliQlFYUVhDL1RuYXFpR2d4?=
 =?gb2312?B?QVhBWUFhMkZPUzhNdWVYT1hJdDI1bVBjUzJHT2ZxR1VLSllaeHk2ZE5xTUp2?=
 =?gb2312?B?Ynl3eit0Rkk1d3FYd0JVcjg1MVRPRlRlekZERzdaU09zTTRTZmsyRm4vRndQ?=
 =?gb2312?B?a1VlWnBaWFVPa25sbitGbXptVWlJRlgxekMvUHRJcVhIMkxJM2RuL2ZISFJP?=
 =?gb2312?B?RGZVQzF0Y3BEV3BhU1BHNHFvK1NXRjZrQnN1QURyc2VabHgyU3IyS1Q1RW12?=
 =?gb2312?B?eS9rUDdRc0ovdWN1WDZTVlpIaGFMS1hFK29uZm1KSVg5QktCQkErRkVEeGY0?=
 =?gb2312?B?M0VlbnhTTGh5aDV1RDhMSGl4MlgzVGVZYWRVWnV5ZzFiMmsvK0Z2NnJIQ2Fm?=
 =?gb2312?B?VDQ5WmQzcHhFdW5pRTk3dWtXWFJlKzhVYmQ1N2NvWVZjeEVWbHNtYXVDRWFX?=
 =?gb2312?B?S0tqTThJckt2cldvNUowMGN5aVZuL29mUTZQakkxeUpQNnl3R05HcUVXakFS?=
 =?gb2312?B?Qi8xQWdCd0IvZlp3VkxqVlBhNE5OMHp5WW44bUx6UWVXaU5lNmRhUWY0emlt?=
 =?gb2312?B?VDg3K1VudXVJUktJSGxreEo4RVQvZ3Y2MC9SV3hvOGJOYXoyQVBpSFJhQWlw?=
 =?gb2312?B?dDlMQXYwRGExZ1I2RXkrNmlXcmN1MTR5SGQrT3RjOWZKWjMwTFJkVlZsVCtF?=
 =?gb2312?B?SEY1K1JyeWEvS0dTa3pSaVJtMW56VzduSmRhY1R5QWFyWGROQkRWZWVGeHov?=
 =?gb2312?B?SmRhcGtkRERnais0QWxzYmhHUFM2L25UR0tMcEtjL1hNMHJCTHBsLzVGY0hD?=
 =?gb2312?B?ZXA2ZXczNTJJdWpjQ09NVXdJUDUyazlzVk5Cd0xMYXM1VXR5alBpcTNEOGNJ?=
 =?gb2312?B?b0VXTjEwR3dZeG9yZVI3UDY1cm03QTVTb1E5Z3ZwRDRNTHh0Ym1MQVJIbEVt?=
 =?gb2312?B?ZHR2dWQ4YTZBR1VoTUFFbG5WUEJxa3VzUWlQczQ2VGJKT09nREEvTjk4WlhI?=
 =?gb2312?B?clE4TElWR25FTFhtNDltZGdjYjMzNTZLMVBkTzZjb2ZHd1dNdTc3NURiQVJo?=
 =?gb2312?B?RXIrSWlIR0JiUEtYV0g0SE5RTnE3RU9GTjBzd044S3dRbWdFVmJBRnlRQ0RV?=
 =?gb2312?B?NWdQMXN3L05aOEttMkQrTkUyemRYVDVBbnJDcElyR2hlL054RThzcm92dk1R?=
 =?gb2312?B?cW82K2lOaE0wVnVGRVE3c1FuY1NBSkdvdHIzbDRkSG1xOHNVT1RvVUs2bnpE?=
 =?gb2312?B?ZTFockIrdWhldUZ6WGFYS3dUV2wvb3ZPU3NiSDM5bjhrWjFYRTZYdXlDMlha?=
 =?gb2312?B?RDhoRW5yM0ZiMlEvMkIyK0NBWTVaL1kyQ2RvWDNDYXBHSVAwemVBMjJFSDQ1?=
 =?gb2312?B?UUxmMS9EZ09TQTRuVVIySHhEZkNxWCszOUxmRzRQMThZS2NJbGpmdz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4003.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1459ad5-ea63-4305-97f6-08da210ded25
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 07:34:52.1427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5msEqdfSabRsMeSP+ZL5WJibIuUzs+5xM+92bYV73/4BgF8fysNBtsIwZ8QBim0MAn0qKxXeTqLh2sE0TyMkFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5158
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEJpZ2dlcnMgPGViaWdn
ZXJzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgMTgsIDIwMjIgMzoyMiBQTQ0K
PiBUbzogs6O37+mqIDxjaGFuZ2ZlbmduYW5Adml2by5jb20+DQo+IENjOiBqYWVnZXVrQGtlcm5l
bC5vcmc7IGNoYW9Aa2VybmVsLm9yZzsgdHl0c29AbWl0LmVkdTsNCj4gYWRpbGdlci5rZXJuZWxA
ZGlsZ2VyLmNhOyBheGJvZUBrZXJuZWwuZGs7IGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtZXh0NEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBmMmZzOiBub3RpZnkgd2hl
biBkZXZpY2Ugbm90IHN1cHBydCBpbmxpbmVjcnlwdA0KPiANCj4gT24gTW9uLCBBcHIgMTgsIDIw
MjIgYXQgMDI6MzM6MTFQTSArMDgwMCwgRmVuZ25hbiBDaGFuZyB2aWENCj4gTGludXgtZjJmcy1k
ZXZlbCB3cm90ZToNCj4gPiBOb3RpZnkgd2hlbiBtb3VudCBmaWxlc3lzdGVtIHdpdGggLW8gaW5s
aW5lY3J5cHQgb3B0aW9uLCBidXQgdGhlDQo+ID4gZGV2aWNlIG5vdCBzdXBwb3J0IGlubGluZWNy
eXB0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRmVuZ25hbiBDaGFuZyA8Y2hhbmdmZW5nbmFu
QHZpdm8uY29tPg0KPiANCj4gWW91IGRpZG4ndCBpbmNsdWRlIGEgY292ZXIgbGV0dGVyIGluIHRo
aXMgcGF0Y2hzZXQuICBDYW4geW91IGV4cGxhaW4gd2hhdA0KPiBwcm9ibGVtIHRoaXMgcGF0Y2hz
ZXQgaXMgbWVhbnQgdG8gc29sdmU/DQoNCldoYXQgSSdtIHRyeSB0byBtYWtlIGlzIHdoZW4gZGV2
aWNlcyBub3Qgc3VwcG9ydCBpbmxpbmVjcnlwdCwgZG8gbm90IHNob3cgaW5saW5lY3J5cHQgaW4g
bW91bnQgb3B0aW9uLiANCldoZW4gSSB0ZXN0IGZzY3J5cHQgZmlyc3QsIGl0IG1ha2UgbWUgY29u
ZnVzZWQuIE5vdCBhIHJlYWwgcHJvYmxlbSwganVzdCBtYWtlIHRoaXMgbG9naWNhbCBtb3JlIHJl
YXNvbmFibGUuDQpEbyB5b3UgdGhpbmsgdGhpcyBuZWVkcyB0byBiZSByZXZpc2VkPw0KDQo+IA0K
PiBOb3RlIHRoYXQgdGhlcmUgYXJlIG11bHRpcGxlIGZhY3RvcnMgdGhhdCBhZmZlY3Qgd2hldGhl
ciBpbmxpbmUgZW5jcnlwdGlvbiBjYW4NCj4gYmUgdXNlZCB3aXRoIGEgcGFydGljdWxhciBmaWxl
LCBzdWNoIGFzIHdoZXRoZXIgdGhlIGRldmljZSBzdXBwb3J0cyB0aGUNCj4gcmVxdWlyZWQgZW5j
cnlwdGlvbiBtb2RlLCBkYXRhIHVuaXQgc2l6ZSwgYW5kIGRhdGEgdW5pdCBudW1iZXIgc2l6ZS4g
IFNvDQo+IHlvdXIgd2FybmluZyBtaWdodCBub3QgdHJpZ2dlciBldmVuIGlmIGlubGluZSBlbmNy
eXB0aW9uIGNhbid0IGJlIHVzZWQuICBBbHNvLA0KPiB5b3VyIHdhcm5pbmcgd2lsbCBuZXZlciB0
cmlnZ2VyIGlmIHRoZSBrZXJuZWwgaGFzDQo+IENPTkZJR19CTEtfSU5MSU5FX0VOQ1JZUFRJT05f
RkFMTEJBQ0s9eS4NCg0KSSBnZXQgaXQuDQoNCj4gDQo+IEkgcmVjZW50bHkgc2VudCBvdXQgYSBw
YXRjaCB0aGF0IG1ha2VzIGZzL2NyeXB0by8gY29uc2lzdGVudGx5IGxvZyBhIG1lc3NhZ2UNCj4g
d2hlbiBzdGFydGluZyB0byB1c2UgYW4gZW5jcnlwdGlvbiBpbXBsZW1lbnRhdGlvbiBmb3IgdGhl
IGZpcnN0IHRpbWU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMjA0MTQwNTM0MTUu
MTU4OTg2LTEtZWJpZ2dlcnNAa2VybmVsLm9yZy4NCj4gSXQgYWxyZWFkeSBkaWQgdGhpcyBmb3Ig
dGhlIGNyeXB0byBBUEksIGJ1dCBub3QgYmxrLWNyeXB0by4gIEJlaW5nIHNpbGVudCBmb3INCj4g
YmxrLWNyeXB0byB3YXMgc29tZXdoYXQgb2YgYW4gb3ZlcnNpZ2h0LiAgVGhlc2UgbG9nIG1lc3Nh
Z2VzIG1ha2UgaXQgY2xlYXINCj4gd2hpY2ggZW5jcnlwdGlvbiBpbXBsZW1lbnRhdGlvbnMgYXJl
IGluIHVzZS4NCj4gDQo+IERvZXMgdGhhdCBwYXRjaCBzb2x2ZSB0aGUgcHJvYmxlbSB5b3UgYXJl
IHRyeWluZyB0byBzb2x2ZT8NCg0KSSB0aGluayBpdCdzIGEgZGlmZmVyZW50IHBvaW50Lg0KDQpU
aGFua3MuDQoNCj4gDQo+IC0gRXJpYw0K
