Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCE813283D
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2020 14:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgAGN7V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jan 2020 08:59:21 -0500
Received: from mail-eopbgr30113.outbound.protection.outlook.com ([40.107.3.113]:28046
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727658AbgAGN7V (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 7 Jan 2020 08:59:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNnWOZDAkWLPauGdl3ZnuYC9uSRj6cRaOWMGV5cg5nPCcwJ5gfyn0aZD0JI4iJsFO9KT1i+P8b51xNK5xlcNuZ5TfHN4B8vfyK8UEOh9fxML98da5ZC3M/ZR9BNULO1et/JTQzwFlBCrC63zJSyitaOGt6osHBicMirtP/ZVFzB8Ul7UM1D7WDCV7oYZEswJ9kTfojT5G5Y1yHkFUrq7M48jfsv1OO6IIRsFcSoBL0HLnKWuPON7D+5kFWk4QmyXRL0T+DfPpShg3v61axaQSBni6fB+Tt5vXCZR9AU9L58myyBua1hGgOEZOmmEiLukt+wWdxZ/fj2fa0S4HKmiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3/4Xs1pG0TjL6X04ZgaS05Oce7MQuhhqRGUcg8BTaI=;
 b=KasuDySoZxdTY9Ddo/ThVqnQy4OwQ0361m/Oe5osjQXl5QGkScaRWEJBkSc2zLv45I5ZXWNkj9aBQ2LraAKNQaYrev+Vce+id7WUbwY8b/HjrvbEVREx2FETCUO5q3AR6FvbbgT4b/44RJllUAKVm5LUYIREVW6GbvaUtttKAL13Waq9E63u4UfhkhXM1AmeY6lwwqtpisPhNhPqwgabY0La2LdOV2nKjMjUMaOiGmuXVd+AlTvQYSsGMkLfPA+AAuBSMH0UJNlsMsP45VFhhMAmJeyzkrLeqNaWU1FmUbYIjThEPU9Gt41TUIMgHEMfNXzgZ5YTIbNGsDqmTyj2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3/4Xs1pG0TjL6X04ZgaS05Oce7MQuhhqRGUcg8BTaI=;
 b=Qq/lPopnWJGLfWI7TMyWNPwnHla3JF44us0cnx/8r2YgP4NIQ5NsCb5Znaps1VErS2ubwmyqz6NE1X6NHtAl/GgLeHsrj1apnLhGjaC7+WYzKxnfUaC+IGmDIWmBbSA9uyfu8SeOjvZhdRVln/JfikTosjWu3EjmsZcfv3Xufmw=
Received: from HE1PR0801MB1642.eurprd08.prod.outlook.com (10.168.149.14) by
 HE1PR0801MB1691.eurprd08.prod.outlook.com (10.168.143.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Tue, 7 Jan 2020 13:59:11 +0000
Received: from HE1PR0801MB1642.eurprd08.prod.outlook.com
 ([fe80::e0a6:400a:87bd:a0ea]) by HE1PR0801MB1642.eurprd08.prod.outlook.com
 ([fe80::e0a6:400a:87bd:a0ea%9]) with mapi id 15.20.2602.016; Tue, 7 Jan 2020
 13:59:10 +0000
Received: from localhost.localdomain (176.14.212.145) by HE1PR0902CA0014.eurprd09.prod.outlook.com (2603:10a6:3:e5::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend Transport; Tue, 7 Jan 2020 13:59:07 +0000
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "hare@suse.com" <hare@suse.com>, "tj@kernel.org" <tj@kernel.org>,
        "ajay.joshi@wdc.com" <ajay.joshi@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>
Subject: Re: [PATCH RFC 1/3] block: Add support for REQ_OP_ASSIGN_RANGE
 operation
Thread-Topic: [PATCH RFC 1/3] block: Add support for REQ_OP_ASSIGN_RANGE
 operation
Thread-Index: AQHVr3rX4iW85fKObUKa4s6TmNDgMafA0xKsgAC5NACAAI8Z14ABEJ2AgAHWI4qAAq2RAIAXBX7egACw64A=
Date:   Tue, 7 Jan 2020 13:59:10 +0000
Message-ID: <d2835bd2-9579-74b5-4339-b576df79a9d5@virtuozzo.com>
References: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
 <157599696813.12112.14140818972910110796.stgit@localhost.localdomain>
 <yq1woatc8zd.fsf@oracle.com>
 <3f2e341b-dea4-c5d0-8eb0-568b6ad2f17b@virtuozzo.com>
 <yq1a77oc56s.fsf@oracle.com>
 <625c9ee4-bedb-ff60-845e-2d440c4f58aa@virtuozzo.com>
 <yq1pngh7blx.fsf@oracle.com>
 <405b9106-0a97-0821-c41d-58ab8d0e2d09@virtuozzo.com>
 <yq1o8vg2bl2.fsf@oracle.com>
In-Reply-To: <yq1o8vg2bl2.fsf@oracle.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0014.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::24) To HE1PR0801MB1642.eurprd08.prod.outlook.com
 (2603:10a6:3:86::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [176.14.212.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7afc40c0-71e5-4c6e-2cc0-08d79379c4ed
x-ms-traffictypediagnostic: HE1PR0801MB1691:
x-microsoft-antispam-prvs: <HE1PR0801MB1691B856CB0D0C21AB2A4BAACD3F0@HE1PR0801MB1691.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 027578BB13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39840400004)(346002)(376002)(189003)(199004)(8676002)(7416002)(86362001)(71200400001)(8936002)(81156014)(6916009)(81166006)(6666004)(6486002)(36756003)(69590400006)(6512007)(31696002)(4326008)(6506007)(53546011)(52116002)(54906003)(26005)(316002)(186003)(16526019)(478600001)(5660300002)(2616005)(66946007)(31686004)(66446008)(66556008)(64756008)(66476007)(2906002)(956004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1691;H:HE1PR0801MB1642.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RAn0K2DdouzqBNq0CvuqaGq6N2LXDZheH1fD5gzpXTG/H0K5kFFMOzHHmDsy4xKeyo4i7mYgt+VAVWMbxGel0WB/0Wrx2Tg7hU2LSobMtxHVW55dtNr3uPD3tMwyJxjqhU2wSa9AvaLa/ouVEHzsfhJC0+D82FlPk9ZKRGEhD+Da6GqxGEw6ri44lkchIiCmpZybBv7VESHAKDS+az/aiiqtELVS80rBPoLfxDLs2w912/DBwS2ECWy6jIRebvsJxNyxNBsYzxt+r1IbH1D2p9hnng4OAdPbcXGQ241PU5M98vENwjpreyrouNbLxpScqwfIFM8ijh3ljYTDsXbva0n/LKF/BN7N9/CVVVkoU7BX99uNWyqB49LMTUBJSCv01JYWnvEol1HRN3G8FbOfzDRpurJRZY23N8Yv8THHyAD0OSBWkHWgki7aTUWi6KYQBVWQD1dBYgQZQMLSxqug0vDi0+nxiuB4kt5V6/m/keVhlbAc9kIG9kqUYXt+CfvV
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0787738F6E292B429157CEE19E8ECB18@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afc40c0-71e5-4c6e-2cc0-08d79379c4ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2020 13:59:10.6215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IapPGsvG8lYk7WAe1fVyGytPmEY/Flfs02rjjkjeQvSpDqspf7hzTdPSHhna4A8kvBay8vLF0vVFIV7IUyY7zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1691
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

T24gMDcuMDEuMjAyMCAwNjoyNCwgTWFydGluIEsuIFBldGVyc2VuIHdyb3RlOg0KPiANCj4gS2ly
aWxsLA0KPiANCj4gU29ycnksIHRoZSBob2xpZGF5IGJyZWFrIGdvdCBpbiB0aGUgd2F5Lg0KPiAN
Cj4+IEJ1dCBJIGFsc28gd29ycnkgYWJvdXQgTk9GQUxMQkFDSyBjYXNlLiBUaGVyZSBhcmUgcG9z
c2libGUgYmxvY2sNCj4+IGRldmljZXMsIHdoaWNoIHN1cHBvcnQgd3JpdGUgemVyb2VzLCBidXQg
dGhleSBjYW4ndCBhbGxvY2F0ZSBibG9ja3MNCj4+IChibG9jayBhbGxvY2F0aW9uIGFyZSBqdXN0
IG5vdCBhcHBsaWFibGUgZm9yIHRoZW0sIHNheSwgdGhlc2UgYXJlIGFsbA0KPj4gb3JkaW5hcnkg
aGRkKS4NCj4gDQo+IENvcnJlY3QuIFdlIHNob3VsZG4ndCBnbyBkb3duIHRoaXMgcGF0aCB1bmxl
c3MgYSBkZXZpY2UgaXMgdGhpbmx5DQo+IHByb3Zpc2lvbmVkIChpLmUuIG1heF9kaXNjYXJkX3Nl
Y3RvcnMgPiAwKS4NCg0KKEkgYXNzdW1lZCBpdCBpcyBhIHR5cG8sIGFuZCB5b3UgbWVhbiBtYXhf
YWxsb2NhdGVfc2VjdG9ycyBsaWtlIGJlbGxvdykuDQogDQo+PiBCdXQgd29uJ3QgaXQgYmUgYSBn
b29kIHRoaW5nIHRvIHJldHVybiBFT1BOT1RTVVBQIHJpZ2h0IGZyb20NCj4+IF9fYmxrZGV2X2lz
c3VlX3dyaXRlX3plcm9lcygpIGluIGNhc2Ugb2YgYmxvY2sgZGV2aWNlIGNhbid0IGFsbG9jYXRl
DQo+PiBibG9ja3MgKHEtPmxpbWl0cy53cml0ZV96ZXJvZXNfY2FuX2FsbG9jYXRlIGluIHRoZSBw
YXRjaCBiZWxvdyk/IEhlcmUNCj4+IGlzIGp1c3QgYSB3YXkgdG8gdW5kZXJsaW5lIGJsb2NrIGRl
dmljZXMsIHdoaWNoIHN1cHBvcnQgd3JpdGUgemVyb2VzLA0KPj4gYnV0IGFsbG9jYXRpb24gb2Yg
YmxvY2tzIGlzIG1lYW50IG5vdGhpbmcgZm9yIHRoZW0gKHdhc3Rpbmcgb2YgdGltZSkuDQo+IA0K
PiBJIGRvbid0IGxpa2UgIndyaXRlX3plcm9lc19jYW5fYWxsb2NhdGUiIGJlY2F1c2UgdGhhdCBt
YWtlcyBhc3N1bXB0aW9ucw0KPiBhYm91dCBXUklURSBaRVJPRVMgYmVpbmcgdGhlIGNvbW1hbmQg
b2YgY2hvaWNlLiBJIHN1Z2dlc3Qgd2UgY2FsbCBpdA0KPiAibWF4X2FsbG9jYXRlX3NlY3RvcnMi
IHRvIG1pcnJvciAibWF4X2Rpc2NhcmRfc2VjdG9ycyIuIEkuZS4gcHV0DQo+IGVtcGhhc2lzIG9u
IHRoZSBzZW1hbnRpYyBvcGVyYXRpb24gYW5kIG5vdCB0aGUgcGx1bWJpbmcuDQogDQpIbS4gRG8g
eW91IG1lYW4gImJvb2wgbWF4X2FsbG9jYXRlX3NlY3RvcnMiIG9yICJ1bnNpZ25lZCBpbnQgbWF4
X2FsbG9jYXRlX3NlY3RvcnMiPw0KSW4gdGhlIHNlY29uZCBjYXNlIHdlIHNob3VsZCBtYWtlIGFs
bCB0aGUgcS0+bGltaXRzLm1heF93cml0ZV96ZXJvZXNfc2VjdG9ycw0KZGVyZWZlcmVuY2luZyBh
cyBzd2l0Y2hlcyBsaWtlIHRoZSBiZWxvdyAodGhpcyBpcyBhIHBhcnRpYWwgcGF0Y2ggYW5kIG9u
bHkgc2V2ZXJhbA0Kb2YgcGxhY2VzIGFyZSBjb252ZXJ0ZWQgdG8gc3dpdGNoZXMgYXMgZXhhbXBs
ZXMpOg0KDQpkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLWNvcmUuYyBiL2Jsb2NrL2Jsay1jb3JlLmMN
CmluZGV4IDUwYTVkZTAyNWQ1ZS4uNGM0NTQxNzgzOGY3IDEwMDY0NA0KLS0tIGEvYmxvY2svYmxr
LWNvcmUuYw0KKysrIGIvYmxvY2svYmxrLWNvcmUuYw0KQEAgLTk3OCw3ICs5NzgsOCBAQCBnZW5l
cmljX21ha2VfcmVxdWVzdF9jaGVja3Moc3RydWN0IGJpbyAqYmlvKQ0KIAkJCWdvdG8gbm90X3N1
cHBvcnRlZDsNCiAJCWJyZWFrOw0KIAljYXNlIFJFUV9PUF9XUklURV9aRVJPRVM6DQotCQlpZiAo
IXEtPmxpbWl0cy5tYXhfd3JpdGVfemVyb2VzX3NlY3RvcnMpDQorCQlpZiAoIWJsa19xdWV1ZV9n
ZXRfbWF4X3dyaXRlX3plcm9lc19zZWN0b3JzKHEsDQorCQkJCSAgICBiaW8tPmJpX29wZiAmIFJF
UV9OT1pFUk8pKQ0KIAkJCWdvdG8gbm90X3N1cHBvcnRlZDsNCiAJCWJyZWFrOw0KIAlkZWZhdWx0
Og0KQEAgLTEyNTAsMTAgKzEyNTEsMTAgQEAgRVhQT1JUX1NZTUJPTChzdWJtaXRfYmlvKTsNCiBz
dGF0aWMgaW50IGJsa19jbG9uZWRfcnFfY2hlY2tfbGltaXRzKHN0cnVjdCByZXF1ZXN0X3F1ZXVl
ICpxLA0KIAkJCQkgICAgICBzdHJ1Y3QgcmVxdWVzdCAqcnEpDQogew0KLQlpZiAoYmxrX3JxX3Nl
Y3RvcnMocnEpID4gYmxrX3F1ZXVlX2dldF9tYXhfc2VjdG9ycyhxLCByZXFfb3AocnEpKSkgew0K
KwlpZiAoYmxrX3JxX3NlY3RvcnMocnEpID4gYmxrX3F1ZXVlX2dldF9tYXhfc2VjdG9ycyhxLCBy
cS0+Y21kX2ZsYWdzKSkgew0KIAkJcHJpbnRrKEtFUk5fRVJSICIlczogb3ZlciBtYXggc2l6ZSBs
aW1pdC4gKCV1ID4gJXUpXG4iLA0KIAkJCV9fZnVuY19fLCBibGtfcnFfc2VjdG9ycyhycSksDQot
CQkJYmxrX3F1ZXVlX2dldF9tYXhfc2VjdG9ycyhxLCByZXFfb3AocnEpKSk7DQorCQkJYmxrX3F1
ZXVlX2dldF9tYXhfc2VjdG9ycyhxLCBycS0+Y21kX2ZsYWdzKSk7DQogCQlyZXR1cm4gLUVJTzsN
CiAJfQ0KIA0KZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1tZXJnZS5jIGIvYmxvY2svYmxrLW1lcmdl
LmMNCmluZGV4IDM0Nzc4MmEyNGEzNS4uMGNkZjdkMDM4NmM4IDEwMDY0NA0KLS0tIGEvYmxvY2sv
YmxrLW1lcmdlLmMNCisrKyBiL2Jsb2NrL2Jsay1tZXJnZS5jDQpAQCAtMTA1LDE1ICsxMDUsMjIg
QEAgc3RhdGljIHN0cnVjdCBiaW8gKmJsa19iaW9fZGlzY2FyZF9zcGxpdChzdHJ1Y3QgcmVxdWVz
dF9xdWV1ZSAqcSwNCiBzdGF0aWMgc3RydWN0IGJpbyAqYmxrX2Jpb193cml0ZV96ZXJvZXNfc3Bs
aXQoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsDQogCQlzdHJ1Y3QgYmlvICpiaW8sIHN0cnVjdCBi
aW9fc2V0ICpicywgdW5zaWduZWQgKm5zZWdzKQ0KIHsNCisJdW5zaWduZWQgaW50IG1heF9zZWN0
b3JzOw0KKw0KKwlpZiAoYmlvLT5iaV9vcGYgJiBSRVFfTk9aRVJPKQ0KKwkJbWF4X3NlY3RvcnMg
PSBxLT5saW1pdHMubWF4X2FsbG9jYXRlX3NlY3RvcnM7DQorCWVsc2UNCisJCW1heF9zZWN0b3Jz
ID0gcS0+bGltaXRzLm1heF93cml0ZV96ZXJvZXNfc2VjdG9yczsNCisNCiAJKm5zZWdzID0gMDsN
CiANCi0JaWYgKCFxLT5saW1pdHMubWF4X3dyaXRlX3plcm9lc19zZWN0b3JzKQ0KKwlpZiAoIW1h
eF9zZWN0b3JzKQ0KIAkJcmV0dXJuIE5VTEw7DQogDQotCWlmIChiaW9fc2VjdG9ycyhiaW8pIDw9
IHEtPmxpbWl0cy5tYXhfd3JpdGVfemVyb2VzX3NlY3RvcnMpDQorCWlmIChiaW9fc2VjdG9ycyhi
aW8pIDw9IG1heF9zZWN0b3JzKQ0KIAkJcmV0dXJuIE5VTEw7DQogDQotCXJldHVybiBiaW9fc3Bs
aXQoYmlvLCBxLT5saW1pdHMubWF4X3dyaXRlX3plcm9lc19zZWN0b3JzLCBHRlBfTk9JTywgYnMp
Ow0KKwlyZXR1cm4gYmlvX3NwbGl0KGJpbywgbWF4X3NlY3RvcnMsIEdGUF9OT0lPLCBicyk7DQog
fQ0KIA0KIHN0YXRpYyBzdHJ1Y3QgYmlvICpibGtfYmlvX3dyaXRlX3NhbWVfc3BsaXQoc3RydWN0
IHJlcXVlc3RfcXVldWUgKnEsDQpkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLXNldHRpbmdzLmMgYi9i
bG9jay9ibGstc2V0dGluZ3MuYw0KaW5kZXggNWY2ZGNjN2E0N2JkLi4zZjY4YTYwY2IxOTYgMTAw
NjQ0DQotLS0gYS9ibG9jay9ibGstc2V0dGluZ3MuYw0KKysrIGIvYmxvY2svYmxrLXNldHRpbmdz
LmMNCkBAIC01MDYsNiArNTA2LDggQEAgaW50IGJsa19zdGFja19saW1pdHMoc3RydWN0IHF1ZXVl
X2xpbWl0cyAqdCwgc3RydWN0IHF1ZXVlX2xpbWl0cyAqYiwNCiAJCQkJCWItPm1heF93cml0ZV9z
YW1lX3NlY3RvcnMpOw0KIAl0LT5tYXhfd3JpdGVfemVyb2VzX3NlY3RvcnMgPSBtaW4odC0+bWF4
X3dyaXRlX3plcm9lc19zZWN0b3JzLA0KIAkJCQkJYi0+bWF4X3dyaXRlX3plcm9lc19zZWN0b3Jz
KTsNCisJdC0+bWF4X2FsbG9jYXRlX3NlY3RvcnMgPSBtaW4odC0+bWF4X2FsbG9jYXRlX3NlY3Rv
cnMsDQorCQkJCQliLT5tYXhfYWxsb2NhdGVfc2VjdG9ycyk7DQogCXQtPmJvdW5jZV9wZm4gPSBt
aW5fbm90X3plcm8odC0+Ym91bmNlX3BmbiwgYi0+Ym91bmNlX3Bmbik7DQogDQogCXQtPnNlZ19i
b3VuZGFyeV9tYXNrID0gbWluX25vdF96ZXJvKHQtPnNlZ19ib3VuZGFyeV9tYXNrLA0KZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvYmxrZGV2LmggYi9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oDQpp
bmRleCA5ZTNjZDMzOTRkZDYuLjYyMTk2MDRhMGMxMiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGlu
dXgvYmxrZGV2LmgNCisrKyBiL2luY2x1ZGUvbGludXgvYmxrZGV2LmgNCkBAIC0zMzYsNiArMzM2
LDcgQEAgc3RydWN0IHF1ZXVlX2xpbWl0cyB7DQogCXVuc2lnbmVkIGludAkJbWF4X2h3X2Rpc2Nh
cmRfc2VjdG9yczsNCiAJdW5zaWduZWQgaW50CQltYXhfd3JpdGVfc2FtZV9zZWN0b3JzOw0KIAl1
bnNpZ25lZCBpbnQJCW1heF93cml0ZV96ZXJvZXNfc2VjdG9yczsNCisJdW5zaWduZWQgaW50CQlt
YXhfYWxsb2NhdGVfc2VjdG9yczsNCiAJdW5zaWduZWQgaW50CQlkaXNjYXJkX2dyYW51bGFyaXR5
Ow0KIAl1bnNpZ25lZCBpbnQJCWRpc2NhcmRfYWxpZ25tZW50Ow0KIA0KQEAgLTk4OSw5ICs5ODks
MTkgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgYmlvX3ZlYyByZXFfYnZlYyhzdHJ1Y3QgcmVxdWVz
dCAqcnEpDQogCXJldHVybiBtcF9idmVjX2l0ZXJfYnZlYyhycS0+YmlvLT5iaV9pb192ZWMsIHJx
LT5iaW8tPmJpX2l0ZXIpOw0KIH0NCiANCitzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBibGtf
cXVldWVfZ2V0X21heF93cml0ZV96ZXJvZXNfc2VjdG9ycygNCisJCQlzdHJ1Y3QgcmVxdWVzdF9x
dWV1ZSAqcSwgYm9vbCBhbGxvY2F0ZSkNCit7DQorCWlmIChhbGxvY2F0ZSkNCisJCXJldHVybiBx
LT5saW1pdHMubWF4X2FsbG9jYXRlX3NlY3RvcnM7DQorCXJldHVybiBxLT5saW1pdHMubWF4X3dy
aXRlX3plcm9lc19zZWN0b3JzOw0KK30NCisNCiBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBi
bGtfcXVldWVfZ2V0X21heF9zZWN0b3JzKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLA0KLQkJCQkJ
CSAgICAgaW50IG9wKQ0KKwkJCQkJCSAgICAgdW5zaWduZWQgaW50IG9wX2ZsYWdzKQ0KIHsNCisJ
aW50IG9wID0gb3BfZmxhZ3MgJiBSRVFfT1BfTUFTSzsNCisNCiAJaWYgKHVubGlrZWx5KG9wID09
IFJFUV9PUF9ESVNDQVJEIHx8IG9wID09IFJFUV9PUF9TRUNVUkVfRVJBU0UpKQ0KIAkJcmV0dXJu
IG1pbihxLT5saW1pdHMubWF4X2Rpc2NhcmRfc2VjdG9ycywNCiAJCQkgICBVSU5UX01BWCA+PiBT
RUNUT1JfU0hJRlQpOw0KQEAgLTEwMDAsNyArMTAxMCw4IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWdu
ZWQgaW50IGJsa19xdWV1ZV9nZXRfbWF4X3NlY3RvcnMoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEs
DQogCQlyZXR1cm4gcS0+bGltaXRzLm1heF93cml0ZV9zYW1lX3NlY3RvcnM7DQogDQogCWlmICh1
bmxpa2VseShvcCA9PSBSRVFfT1BfV1JJVEVfWkVST0VTKSkNCi0JCXJldHVybiBxLT5saW1pdHMu
bWF4X3dyaXRlX3plcm9lc19zZWN0b3JzOw0KKwkJcmV0dXJuIGJsa19xdWV1ZV9nZXRfbWF4X3dy
aXRlX3plcm9lc19zZWN0b3JzKHEsDQorCQkJCQlvcF9mbGFncyAmIFJFUV9OT1pFUk8pOw0KIA0K
IAlyZXR1cm4gcS0+bGltaXRzLm1heF9zZWN0b3JzOw0KIH0NCg==
