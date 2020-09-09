Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2D926240E
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Sep 2020 02:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgIIA2m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Sep 2020 20:28:42 -0400
Received: from mail-bn8nam12on2108.outbound.protection.outlook.com ([40.107.237.108]:63713
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726560AbgIIA2j (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 8 Sep 2020 20:28:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnePfZxpalmaxcsbAaeLCM8aYU4YEw7Eh0sObnRZ6+LmEQvsmD9lNRy4/x0MpCW/cRpADGGsdpxEjgtX6kFVPFZ+FXY1ejvtGGY5O1X0repao4nAHaW5s1ytTeXz/DCFQRJZ8zuqZF2YC2L2zEtSJHjcqOAIj97ncfBca6F/qxNr//aOGXsdbypToXL9vFYSI1Wb9tHJDnsKKOn3IgckRnxxFirLkHJ1ZmjA/IncQCANeA4cXbAD8fOPangZ6n4DkAr3PdKWaihlZ9J22oL2q5MZ1dLoO9VbMYcaWl9pwXdeM5vq0avz941+uKA0S2fxVP9pAuSlZAVkIHUw83Xriw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5xKnA9bACemXKcsGwSMWFeJgsOHoLXqQW27CwOHeq8=;
 b=fD0s2seMVSRLoCmYqb5JB2SwzZqXiiND1FN85ELs2iKqfUHcMopLTG+FtUiEUXm7xOjwUrggHc15jMP7PWKEQaOgqKThlkj1WxabI+//SbpldlG3vOVutbP4u1alutPYlg/ZgTMn4GWCyNQ4knH3ep176hzXTt+gGMZ506Ja/fm+sRPb4bxed/d3WHU4wKFCmChIDJKZx+0+dzdo7NJSRpfs2x6WeMuRBGGIedLSOUbtR045LH0lOYs0wn7e8BKOoEMhdOKsNdBKjvamFKSDMAZOACKDLkA8c4kDmtWSlB4IrdyprwOhQ0HSN7wm4n3aLTtiouUES1A30KG2NneXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5xKnA9bACemXKcsGwSMWFeJgsOHoLXqQW27CwOHeq8=;
 b=S6ndjC1kf9IEzyyrSOQmTMPwsWob5FWxhsC0PfuI40xo9ptjv0P8H8Zp8v7PSe44GqTn/G73pqoNNqZWWEUCswoW0x3S0a3FX6SJF7VifWrq6R/CjU19ogYuqLb6Xk+025/so009gyHAyKNKnO/g7+glfzaYT/Z4R/UcpOz7ZfA=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB2024.namprd22.prod.outlook.com (2603:10b6:610:8e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 00:28:37 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::34a6:b9c8:5c74:f348]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::34a6:b9c8:5c74:f348%4]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 00:28:37 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "adilger@dilger.ca" <adilger@dilger.ca>
Subject: PROBLEM: another potential concurrency bug in
 swap_inode_boot_loader()
Thread-Topic: PROBLEM: another potential concurrency bug in
 swap_inode_boot_loader()
Thread-Index: AQHWhkAoX6Y3UQAe6ESHpcpCu1kaQA==
Date:   Wed, 9 Sep 2020 00:28:36 +0000
Message-ID: <CBFCE964-34D6-47ED-BB71-E8975C16F808@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=purdue.edu;
x-originating-ip: [66.253.158.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e59e3eb1-5c99-4c29-dea6-08d854574b08
x-ms-traffictypediagnostic: CH2PR22MB2024:
x-microsoft-antispam-prvs: <CH2PR22MB202404D4D072815E1BA41173DF260@CH2PR22MB2024.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +nM2HG13Ytmk7qqbNitaOJzQKv6XbciJ52gCbmWpDZybieljo8nLNcLm/2x3br4UYDSgX5QuJ5MdSX+rxACOIwM1Dstx4aWqcoL/V1nbTB8OSgfOQdFKnIP5ryjhHPEnHU1zP/hpdZGES6jY9ZQnceCGwguwJrhU+t9a+H7XZf0Qb50URYddtqBgdE/a9osR2Pj3/uzzf6avvKrHv8ZVqgL/y9ZYLM3QNSVQy0tQAIwrFHSYc4e8nPcXzgkAg9dx3V99I4tC5UsSMaY+aefiLjbyVrxfO91z8C3DcUaNCScAVGcLnNfRCn6tw+4QIxDQ9s4aYMleGWjRvoImAihxOc5BdnxJ3OLyuumjECJbC3dsU0AbYVGyJ9RnM0vdQMOsoL++hET1LxjVcglt1M2NOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(6506007)(478600001)(186003)(26005)(5660300002)(54906003)(6512007)(83380400001)(4326008)(2906002)(71200400001)(316002)(786003)(110136005)(64756008)(66476007)(66946007)(66446008)(66556008)(86362001)(76116006)(2616005)(36756003)(75432002)(8936002)(966005)(33656002)(8676002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wtC+efP6OL1Mdh9u+rjmZcMDPIaxiI2Ngnktc7LcbTSuLdfg7/vsaP3sbPwOcK6XUe1LJp9aPdX5+Xgga7OANL4rytEBbMGl3HMRG9g5QdXANb4hud+rYhV6oRVDHL7W5HarPr5te951O+BMS2cb4k2eaT9Fho4cUEeMf9CGwXDcAhiadOLffzSrr0+PV30PA5idVw92NkQKFqAbE/xlBduRj63VY4Ouq6r2qQrGDPCY13Xoa0XjNw9eY9PM9hs662Cq3rdT01roUTVQrGaJwp7Jx3qGz8IiOCTH959PgwXWguBf7IX6onvBZ46gkyG0uN6ImgJ2OQYow87TwzQhZN84Vpmp+ZFCeVomONevRlUMCEe8BOPxjZ1mHSR4iiOBD5DALeo+8jvresa6yBvJx+4tr+uJ5o+0DMLMKleO/koGAeNWWOcaH7yiiap80/EUeFuGtWUCMToSzLdEcMM2vvfyuFQltnpzPXDtL7FCopBH66xnvnupruRd9qIX/dI742GVVUPIW8HQo6BuLWYh4Mmurt6hO/Fkd/NUvEYhPLwfC904l+v/UiX83FOfu3W3iQ5i71i8DTJ4EJOovO6688j6BTsIDU+aEPhFhhSyl3eG1CMuMlL3UKbb8QyXfs732shWvXcyTK1AHrXpDy0tAg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA3DCC483AD3EC4BAF737DA3E62B703F@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59e3eb1-5c99-4c29-dea6-08d854574b08
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 00:28:36.9361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8X/dK0T/eGw17yAf90dxyFJ+PY+Oog0uJDGzeo3thp7ogB6EfsZ1PGcFHk1HZodhNGHxozdVs3tKdyBHCFXmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB2024
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

SGksDQoNCldlIGZvdW5kIGEgcG90ZW50aWFsIGNvbmN1cnJlbmN5IGJ1ZyBpbiBsaW51eCBrZXJu
ZWwgNS4zLjExLiBXZSB3ZXJlIGFibGUgdG8gcmVwcm9kdWNlIHRoaXMgYnVnIGluIHg4NiB1bmRl
ciBzcGVjaWZpYyB0aHJlYWQgaW50ZXJsZWF2aW5ncy4gVGhpcyBidWcgY2F1c2VzIGEg4oCcYmFk
IGhlYWRlci9leHRlbnTigJ0gRVhUNC1mcyBlcnJvci4gDQoNCkluIGFkZGl0aW9uLCB3ZSB0aGlu
ayB0aGlzIGJ1ZyBtYXkgYmUgcmVsYXRlZCB0byBhbm90aGVyIGJ1ZyB3ZSByZXBvcnRlZCBlYXJs
aWVyLiBTaW1pbGFyIHRvIGEgY29uY2VybiBtZW50aW9uZWQgaW4geW91ciByZXBseSwgdGhpcyB0
aW1lIHRoZSBpbm9kZSBoYWQgYSBjb3JyZWN0IGNoZWNrc3VtIGJ1dCBhIHdyb25nIGhlYWRlciBk
YXRhLg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1leHQ0LzQ1OUVFNkUzLTFDQjIt
NDg5OC04QzVGLTI4M0U4MjFCMkE3NUBkaWxnZXIuY2EvVC8jdA0KDQoNCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KS2VybmVsIGNvbnNvbGUgb3V0cHV0DQoNCkVY
VDQtZnMgZXJyb3IgKGRldmljZSBzZGExKTogZXh0NF9leHRfY2hlY2tfaW5vZGU6NDk4OiBpbm9k
ZSAjNTogY29tbSBza2ktZXhlY3V0b3I6IHBibGsgMCBiYWQgaGVhZGVyL2V4dGVudDogaW52YWxp
ZCBtYWdpYyAtIG1hZ2ljIDAsIGVudHJpZXMgMCwgbWF4IDAoMCksIGRlcHRoIDAoMCkNCg0KLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpUZXN0IGlucHV0DQoNClRo
aXMgYnVnIG9jY3VycyB3aGVuIGEga2VybmVsIHRlc3QgcHJvZ3JhbSBpcyBleGVjdXRlZCB0d2lj
ZSBpbiBkaWZmZXJlbnQgdGhyZWFkcyBhbmQgcmFuIGNvbmN1cnJlbnRseS4gT3VyIGFuYWx5c2lz
IGhhcyBsb2NhdGVkIHRoYXQgaXQgaGFwcGVucyB3aGVuIHN5c2NhbGwgaW9jdGwgd2l0aCB0aGUg
RVhUNF9JT0NfU1dBUF9CT09UIGZsYWcgaXMgY2FsbGVkIHR3aWNlIGFuZCBpbnRlcmxlYXZlcyB3
aXRoIGl0c2VsZi4gDQpUaGUgdGVzdCBwcm9ncmFtIGlzIGdlbmVyYXRlZCBieSBTeXprYWxsZXIg
YXMgZm9sbG93czoNCnIwID0gY3JlYXQoJigweDdmMDAwMDAwMDA4MCk9Jy4vZmlsZTBceDAwJywg
MHgwKQ0KaW9jdGwkRlNfSU9DX1NFVEZMQUdTKHIwLCAweDQwMDQ2NjAyLCAmKDB4N2YwMDAwMDAw
MDQwKSkgDQpyMSA9IGNyZWF0KCYoMHg3ZjAwMDAwMDAwMDApPScuL2ZpbGUwXHgwMCcsIDB4MCkN
CnB3cml0ZTY0KHIxLCAmKDB4N2YwMDAwMDAwMGMwKT0nXHgwMCcsIDB4MSwgMHgxMDEwMDAwKQ0K
cjIgPSBjcmVhdCgmKDB4N2YwMDAwMDAwMDAwKT0nLi9maWxlMFx4MDAnLCAweDApDQppb2N0bCRF
WFQ0X0lPQ19TV0FQX0JPT1QocjIsIDB4NjYxMSkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQpUaHJlYWQgaW50ZXJsZWF2aW5nDQoNCk91ciBhbmFseXNpcyBy
ZXZlYWxlZCB0aGF0IHRoZSBmb2xsb3dpbmcgaW50ZXJsZWF2aW5nIHRyaWdnZXJzIHRoaXMgYnVn
Lg0KDQpDUFUwCQkJCQkJCQkJCQkJCQkJCUNQVTENCnN3YXBfaW5vZGVfYm9vdF9sb2FkZXIoKQ0K
4oCmDQotLSBleHQ0X21hcmtfaW5vZGVfZGlydHkoKSBbZnMvZXh0NC9pb2N0bC5jOjIwN10NCltj
b250ZXh0IHN3aXRjaF0NCgkJCQkJCQkJCQkJCQkJCQkJc3dhcF9pbm9kZV9ib290X2xvYWRlcigp
DQoJCQkJCQkJCQkJCQkJCQkJCS0tIGV4dDRfaWdldCgpDQoJCQkJCQkJCQkJCQkJCQkJCS0tLS0g
ZXh0NF9pc2l6ZSgpDQoJCQkJCQkJCQkJCQkJCQkJCVtjb250ZXh0IHN3aXRjaF0JCQkNCuKApg0K
LS0gZXh0NF9tYXJrX2lub2RlX2RpcnR5KCkgW2ZzL2V4dDQvaW9jdGwuYzoyMjNdDQotLS0tIGV4
dDRfbWFya19pbG9jX2RpcnR5KCkNCi0tLS0tLSBleHQ0X2RvX3VwZGF0ZV9pbm9kZSgpDQogICAg
ICAgICAgZm9yIChibG9jayA9IDA7IGJsb2NrIDwgRVhUNF9OX0JMT0NLUzsgYmxvY2srKykgW2Zz
L2V4dDQvaW5vZGUuYzo1MzM3XQ0KICAgICAgICAgICAgcmF3X2lub2RlLT5pX2Jsb2NrW2Jsb2Nr
XSA9IGVpLT5pX2RhdGFbYmxvY2tdOw0K4oCmDQpbc3lzY2FsbCBmaW5pc2hlc10NCltjb250ZXh0
IHN3aXRjaF0NCgkJCQkJCQkJCQkJCQkJCQkJ4oCmDQoJCQkJCQkJCQkJCSAgICAgICAgCQkJCQkJ
Zm9yIChibG9jayA9IDA7IGJsb2NrIDwgRVhUNF9OX0JMT0NLUzsgYmxvY2srKykgW2ZzL2V4dDQv
aW5vZGUuYzo1MDAyXQ0KCQkJCQkJCQkJCQkJCQkJCQkgICAgICAgICAgZWktPmlfZGF0YVtibG9j
a10gPSByYXdfaW5vZGUtPmlfYmxvY2tbYmxvY2tdOw0KCQkJCQkJCQkJCQkJCQkJCQnigKYNCgkJ
CQkJCQkJCQkJCQkJCQkJLS0tLSBleHQ0X2V4dF9jaGVja19pbm9kZShpbm9kZSkNCgkJCQkJCQkJ
CQkJCQkJCQkJW0VYVDQtZnMgZXJyb3JdCQkJCQ0KDQoNClRoYW5rcywNClNpc2h1YWkNCg0K
