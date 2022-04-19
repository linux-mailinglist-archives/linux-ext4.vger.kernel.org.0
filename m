Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22A650628F
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Apr 2022 05:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346395AbiDSDZR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Apr 2022 23:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiDSDZQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Apr 2022 23:25:16 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2108.outbound.protection.outlook.com [40.107.117.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DDF24974;
        Mon, 18 Apr 2022 20:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVTJ0OSNSGHBGIgTTT0FJvCGLG1HkpoMmEnxvfVSpqzHHEye2lQMFeXjzBEztDqg4veEhi2nDzNbzGnxkXrDZQlnStIvGLu3d6ecBdzCLjlFstPmSLJy4kLhwu0zwZhDleIMX6bd2TdQwJ9EXWHDFjq5J3qm26Pm49Qao3UMXycuogHt90ndInNtCHO1NjHKYPfe06cHfmsdhiNSc+//3VnWn057uNGGzFcQ6S3UTdXmPAkJKNcmPmh64tp2octBkg9+euU6SNcQ8GDrR1vpS/42KWcwZi7zcimXWPU0++z5MtophxwecEjjP/cpQGOkYJnH3/vN/x8dZQ+F+apLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPufU/3c3D4WIa2W8KmD6j5ogA94uvlga5imJyah4wM=;
 b=Vj2kOxfuM7Dols/PUh72IVE8/bhikYHfO9p2HK0fAu/jcgwXiEKQusgU0rygfgcdC1t4UrYL6/vKjsnJXoybj853xoJao7p3zUM9ZRJ6f9haEz0qxWOZ8QrUwiw2+7gOXrSk4gJcikejNy+0F8tA6kI/KvK/rSdVXIN8lkl97HfT5ljfeVKVLL4PYWPtga4PtvW+wLY7cvE8qTEouGzuJxNbq2SvpFuG4v4MYTlbaWbd1HY7600efr+Yw4k5yeYnsazLoow3/PhS6Q3i2O68V2cC7pOzeZIffXw87EECWEdgq8pDfkDgFaEwPLe50fA3I0wDbyHKmtDgGkn/JLsd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPufU/3c3D4WIa2W8KmD6j5ogA94uvlga5imJyah4wM=;
 b=pENgm9P+TV+IF6enQJvAus4tmFULuSQOHnHUBg+umxHNFVPjJsStz2+RfFLz+F+FVlZBGg3JDbH5FxQ5kzjGZusRmvVPPbzn+W30e+xei39BCpdHfbgf617Yh8oNb/hkKH/w39xASL+frwQvd1V83oRLpIPYgUle9IX+bDtokL4=
Received: from KL1PR0601MB4003.apcprd06.prod.outlook.com (2603:1096:820:26::6)
 by SEYPR06MB5254.apcprd06.prod.outlook.com (2603:1096:101:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.19; Tue, 19 Apr
 2022 03:22:32 +0000
Received: from KL1PR0601MB4003.apcprd06.prod.outlook.com
 ([fe80::f0c7:9081:8b5a:7e7e]) by KL1PR0601MB4003.apcprd06.prod.outlook.com
 ([fe80::f0c7:9081:8b5a:7e7e%8]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 03:22:31 +0000
From:   =?utf-8?B?5bi45Yek5qWg?= <changfengnan@vivo.com>
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
Thread-Index: AQHYUu45GoDAOd0+BUSILnKkLO2jc6z1RCGAgAABOZCAAPuzAIAATRAwgAAEZwCAAACpwA==
Date:   Tue, 19 Apr 2022 03:22:31 +0000
Message-ID: <KL1PR0601MB4003E83BD65B8381C030FAC3BBF29@KL1PR0601MB4003.apcprd06.prod.outlook.com>
References: <20220418063312.63181-1-changfengnan@vivo.com>
 <20220418063312.63181-2-changfengnan@vivo.com>
 <Yl0RmUoZypbVmayj@sol.localdomain>
 <KL1PR0601MB400369725474F2A2DE647057BBF39@KL1PR0601MB4003.apcprd06.prod.outlook.com>
 <Yl3lxMnZ5teL+bkU@sol.localdomain>
 <KL1PR0601MB4003A659B51814320E156C35BBF29@KL1PR0601MB4003.apcprd06.prod.outlook.com>
 <Yl4qGkrfMT7FqbJj@sol.localdomain>
In-Reply-To: <Yl4qGkrfMT7FqbJj@sol.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5deaf085-5f65-455c-ee19-08da21b3d71d
x-ms-traffictypediagnostic: SEYPR06MB5254:EE_
x-microsoft-antispam-prvs: <SEYPR06MB5254633CF5A38C2BF12C1919BBF29@SEYPR06MB5254.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IC5XtlboOySQlnDAtfEUo2wXqpwOechquHDWaz23vvkgkgazAbUGITJXnSCUdWAfsnQu/ps2v624PZf+NU6YiD/twwpgB0JQUhLT2RcJ2Cd1LOO7w3yh2tqKv996fH8SrLZnSNea2z6rS9Ttp5U+rFcONWLSuPMxNQl2uswgMO5EUrrDP06El6bDK8IHULUEqPOSKobaESXviMuDOeZ6SXxddtO2G9FWa8Yl74NI/weFitIbsGj9OzYkzregT6HKlpE1biAFlG6At3cUJO9D5Qcu2GMjjTW28CD9rBQq0eQ/1OONuzAlGcbugQfDekWr/EelDcas9nKwiWGL0q8PP+NBghxptC19JyXv6nadKFN6fwlmSgN1HL4sO2NUQM8C1hujUoQ/nyew6pK5bRpGSX2kY66NvJEL0pMp1vYR9J99eiD8sZkPJOcxZ9uq44Y7+H1YOlZOghcsCWN8zKqgwX0mVQIMnQdmN3Bkejo0cupOnHGYnkSyczSCbKA//W13BiRfqvM+IKJpp/kdbs5/spklvA00rK9ZzV4jPuRLny2Ky8C/mSzQMXjcRxd/Iezr0L/LdMc41VBcHMnYsJwE65ajjdJjqc/WgwQLWvuPGxWfLByPwK+fcUNIgNE7Hzw/qlmwIJeVYfT0bRaOG73r+40vYBxByTzx/I81NHW8AoEz63YqXB08FWTfI+A3xP7Ded5mDzynH0/XLPK/LJjMMHq3Kbly1RRWRlMCblaXaI1bZvFMc4vQgJjNLYiT5W4OrefWQjTK2QmJDaZ4HjTrdgAJLLejPofpFsSoAGuzXgM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4003.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66446008)(966005)(52536014)(33656002)(64756008)(38070700005)(8936002)(66476007)(4326008)(26005)(186003)(55016003)(53546011)(86362001)(8676002)(71200400001)(6916009)(2906002)(508600001)(9686003)(4744005)(66946007)(85182001)(122000001)(76116006)(316002)(54906003)(83380400001)(38100700002)(5660300002)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vm8xUUlEVmo2T2FXSlJieTBqelBOZGVRWElPUmpIdm5TdnhFWVh0NTdJN0VP?=
 =?utf-8?B?N2x1RnVMK0EvRU1lbkxOZDNNMFdqTFRVQVF6dEpCN3JncjQzZ3AyQmIzbzV5?=
 =?utf-8?B?OEZPWkZxdXBvQkw0blR1Q3VuUCsrQW9odkRkRXl1cEVuR25NWEZLeWcrY2pB?=
 =?utf-8?B?VUxrb0VsaG94YTZac2w2SXlOMzNURkdWOFd5MXgwRGxYSlhlRVlpckNTNmR1?=
 =?utf-8?B?S2Q1emVhd1ZQODN5L2ZiMy84TDh6KzJGQnNvdHQwZk1CK1FDbUp3d21oMHJs?=
 =?utf-8?B?amJ0Mnc1V3pibm1DZTJsQ1JuUmJZSlZROVpoWFNwdVRwUDRTVlNUK3dLU2ho?=
 =?utf-8?B?eDM3eGxNSWFDYnZWKzJLOVVISW1HSHErQkhRby9DN2ZZNEdSRHQ1WGVzeGxC?=
 =?utf-8?B?MzRUU3lYWXdCWFdKa0YzYllrbmdYUFJBaDNOb0czemV4WHRKaXNrSEVGOEdF?=
 =?utf-8?B?bXJ3YjcrK0VJZW1RQUZZVzE3V3JwOTVCZ0VFR1BOZEY3N0Q0SkJVTmRiTW9k?=
 =?utf-8?B?M0hhZ3JwcDhMLzB3bFovZzFtMEdQZm01bEtDb3c5bXhFcDVtUk9JcFdiaE16?=
 =?utf-8?B?VVhiQ1NHY1cxTlJ5SWNFU0I4VktzR3ZIQTdqckJuYXQzVXhXMHZ0cElSQXZB?=
 =?utf-8?B?TFdHV2dNdXJpV2Z0LzBIekU2TEo5bHkyemRBWDJqN3lXRkx1RThDaDdST0g3?=
 =?utf-8?B?RG9WbStFZVBHTDJEV3ZQRkNOdURldnRuMzJZVnBZUS95RkNSYmN4UHB0QlRm?=
 =?utf-8?B?b0NRa00xVE9hcnh3RTJZblMwTGpWVWVhOGw4cFd4anljcWNIMHgvUk1tazEz?=
 =?utf-8?B?ckhqZXlCY29yUE5vcVZNaElpdDF5aEVjd3o1VW5VaE9Gc0hYZW9NK1R5TXZN?=
 =?utf-8?B?SnNTK1o5UGt1WGlaeHZiMUVNUTNiS3hvSk1UZVhBeFJubE9icFV0NzRqQXY4?=
 =?utf-8?B?ZGIrN0FvV0JqeDVEWVE4MFNNRGQvdW5KdW1LSzNpbEpDOTNBTlZ2MVFzUEdh?=
 =?utf-8?B?MXlDWEs2eEtUWUMvL1QvZ2dZRVdKdXpDUko5anpBNmJOdmxITXV5cWVDa0dM?=
 =?utf-8?B?OVlyeFdqTXhESDFicVovUTlYbUJWRHBXZ0xSOE9QM2xWeFRuRHRacFFqMSti?=
 =?utf-8?B?SkhqUXJhK2dEVkpKbjROVkg1bHFYU1JJeVNMeThxazdJRXNRUU51RlYwZnk5?=
 =?utf-8?B?UWhRRGo4b1RuWkI0Mk1CMDczZ1M2QlZHUnRCWGtZR04rb01QcHpBdGV6QVQ1?=
 =?utf-8?B?TEVpWFdxc050cHdzZ0YxbTBGZVJvUWt0c2JoSEdqcys1aXltT1I0NW5FTWNm?=
 =?utf-8?B?WlVDMkRMb0JsZEdTdE1sRGxFQ3FjV21Dek1LY2ZLcDV5MUtNL1VLWjRic1lk?=
 =?utf-8?B?ZFlidms2N3UwVUFBK1dOODd0dmcyOXZGa0lzUDR3amY3K0xVUDRvdTBzUFpi?=
 =?utf-8?B?eE9UN0lSTGwvU3doQ0Q2NVY5WjZ6OUMwbndkV1BQTDNSSnE4NUhGWmtiUnJx?=
 =?utf-8?B?TENBTEJYYW9IcUhVNzNFS1JwamtyRnBkOEZqdWhYOFh5MGYxZ1F3NnpnaUYv?=
 =?utf-8?B?ZzdMTmdjMW1EWHVpMTZoaTdxVjd4aUU1am5hUHZtMlZWY2tqd2pBUTlmWldZ?=
 =?utf-8?B?VU9nV3F0b1VEY0YwRk1BQXV3UkZ5T0M1NmRSUmYzMmdMclJvZlNOditjN0RC?=
 =?utf-8?B?dWVVN1FDTEV0U21FMG1VUmdLcjNxWEdsL1A4WndsU3NkRGdXbVBJZ3B1ei9x?=
 =?utf-8?B?dkVuTWFPNVdkSUZOM1k2cWlvSmxOQnpTTVV1MlBSSitSOHN5Z2lqSUI1K0JR?=
 =?utf-8?B?aEoxUVdvL29nbGQvKyt6bHRaV3BubXFKVlpNbEpCb05JSHhQRW90UG55NUJW?=
 =?utf-8?B?UTkzREZ2YUR6UUFjaVpuSmIzemlsZWt0QUFQclFWM3NRUDRlQWs5VWxLd3Jj?=
 =?utf-8?B?ZitrT2tjb0lnQWRlRmc3QmdpY1dSMVZjLzBtRk52RGZEYmJodUNsOWtreHJP?=
 =?utf-8?B?VnZWSFFKTDhidHdJcVdPL3BBenNYbUl1blZkdEdjMFJDYW16YUlNQ1RMOFQ5?=
 =?utf-8?B?ekI1WkFZdHZ2cWhiZ1ArWllnZGh3eVdJUnczdEJZQzNLTHlhWU5QaUREaDQr?=
 =?utf-8?B?dGZjT2NJMklJZFloY1RiZGRyZEhiV0NyWjNLUlRwVDBaT2Q0YnJNSFFJRFlo?=
 =?utf-8?B?b1AzQXorUnhPRzl3aDJOS0NEU0YrOXNLSTF5Y3hjRVJRQjNTelQwS0I2dWlK?=
 =?utf-8?B?WFc0TFI5U1ducERkbjJwUkZ0b2xZZXRsRmxLeTZ0SndsQjZXRnJ1VG85VXFh?=
 =?utf-8?B?TTFkUTFXNk5yUUlmdG1TRWlUbEliN1BSakcwV3Fsd1dVMkNjRXJPdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4003.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5deaf085-5f65-455c-ee19-08da21b3d71d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 03:22:31.2503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJNdVwB7GmKRpLtPqdvhMDJD+O5SUgzUreaHyZAYcR4K1K1EWtog+xVrkBmcQFpWWZfTyb0zz5w7SODIrvINVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5254
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEJpZ2dlcnMgPGViaWdn
ZXJzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDE5LCAyMDIyIDExOjE5IEFN
DQo+IFRvOiDluLjlh6TmpaAgPGNoYW5nZmVuZ25hbkB2aXZvLmNvbT4NCj4gQ2M6IGphZWdldWtA
a2VybmVsLm9yZzsgY2hhb0BrZXJuZWwub3JnOyB0eXRzb0BtaXQuZWR1Ow0KPiBhZGlsZ2VyLmtl
cm5lbEBkaWxnZXIuY2E7IGF4Ym9lQGtlcm5lbC5kazsgbGludXgtYmxvY2tAdmdlci5rZXJuZWwu
b3JnOw0KPiBsaW51eC1leHQ0QHZnZXIua2VybmVsLm9yZzsgbGludXgtZjJmcy1kZXZlbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIGYyZnM6IG5vdGlm
eSB3aGVuIGRldmljZSBub3Qgc3VwcHJ0IGlubGluZWNyeXB0DQo+IA0KPiBPbiBUdWUsIEFwciAx
OSwgMjAyMiBhdCAwMzoxNDo1MUFNICswMDAwLCDluLjlh6TmpaAgd3JvdGU6DQo+ID4NCj4gPiBU
aGFua3MgZm9yIHlvdXIgZXhwbGFuYXRpb24sIHRoaXMgcGF0Y2hzZXQgaGFzIHRvbyBtYW55IGNh
c2UgdG8gZm9yZ2V0IHRvDQo+IGhhbmRsZS4uLg0KPiA+IEJhY2sgdG8gbXkgZmlyc3QgdGhvdWdo
dCwgbWF5YmUgdGhlcmUgc2hvdWxkIGhhdmUgb25lIHN5c2ZzIG5vZGUgdG8NCj4gPiBpbmRpY2F0
ZSB0aGUgZGV2aWNlIHN1cHBvcnQgaW5saW5lY3J5cHQgb3Igbm90ID8gU28gdXNlciBjYW4ga25v
dyBpdCdzDQo+ID4gZGV2aWNlIG5vdCBzdXBwb3J0IGlubGluZWNyeXB0IGFuZCBub3QgZm9yIG90
aGVyIHJlYXNvbnMuDQo+ID4NCj4gDQo+IExpbnV4IHY1LjE4IGhhcyB0aGF0LiAgU2VlIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvbGludXMvMjBmMDFmMTYzMjAzNjY2MA0KPiAoImJsay1jcnlwdG86
IHNob3cgY3J5cHRvIGNhcGFiaWxpdGllcyBpbiBzeXNmcyIpLg0KT2gsIEkgc2VlLCB0aGFua3Mg
YSBsb3QuIA0KDQo+IA0KPiAtIEVyaWMNCg==
