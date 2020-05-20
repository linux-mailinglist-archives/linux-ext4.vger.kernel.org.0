Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5511DADC0
	for <lists+linux-ext4@lfdr.de>; Wed, 20 May 2020 10:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgETIko (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 May 2020 04:40:44 -0400
Received: from mail-eopbgr680055.outbound.protection.outlook.com ([40.107.68.55]:21836
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbgETIkm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 20 May 2020 04:40:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6KRB+E6EIJat8JQ93v7ybzTurUk3Zpynis7iG/t1Tx2FAsfX89HfXRUSoidxxf0d2Qe7GaeSxU1V9Rg/NKppiIgSabUryhuqBsCBZvVNWDR/tYs7mVOesXfmWc1ryu24UtkKCSMzsaG939Av4vlQJuki7kxsJfwuUooEl7nnWLZCqlAeBScHPsZihJyZZOtSWHeIeYjohZwALXEGLuv04UnXbwTijfe0h+Q9F/hE9pydq+PQjXT588r4zl0HoC+eDO3YgZgyqh9NyCVsxVDUhXusdzQlvrLQ8QGEraW/OcQTMojAQKTS2B8RtXWhnc3BOWfewjZn2Q8PXyXh5Fjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu4KTLVfzrpY4P8KaKGZE7fLzqAfQxmdc4+nLoWgnps=;
 b=QehHpA43T4WxDClPSQNrbRK/9s/FQi5963tC5ifYfedHM5Ak152vUBWNtOhEXbroXNN1sWpDNavjIk/pUXDf2vki7/YNt/suPeRCA+D2Z2TlfqVbZMIaIUDa6Sz1qzvcTpSuZI9aGntiVP1bhNuffjr8L/l4UI3u7vwdaEfj1DiJHz89LwSmlHoDkXvP/mdz0McZcz2d2p7OBoJ00efu78uIzTS5FDDsXP9cbii5acEvoKtKaZ+NwRnltKTH0Od4RRDO1G4vN3mRo+iycstUyjJv8PzP8eOLnRwKHR2aTB6jdAufg2VxNMZEZmVQed/tq0hSTKbFNlL/2HB+neCORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu4KTLVfzrpY4P8KaKGZE7fLzqAfQxmdc4+nLoWgnps=;
 b=q15bxHrQU/ua9LFXZAK+zEPsntou/Se7RmbGeIgpzSsFGBpfPJgP/0AfItbbad1d+oyAZRcOtPzG6swqsXnQcEtkZxDbxbe2SMM/dTU06pkoRIUqimHyTFWo9ciV1p3YIL6ZSWAn/8XwCnMomZ9mPmovXCve466PHSGfTFa0v5M=
Received: from DM6PR19MB2441.namprd19.prod.outlook.com (2603:10b6:5:18d::16)
 by DM6PR19MB2875.namprd19.prod.outlook.com (2603:10b6:5:137::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Wed, 20 May
 2020 08:40:39 +0000
Received: from DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4]) by DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 08:40:39 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     Andreas Dilger <adilger@dilger.ca>
CC:     Alex Zhuravlev <azhuravlev@whamcloud.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4: skip non-loaded groups at cr=0/1
Thread-Topic: [PATCH 2/2] ext4: skip non-loaded groups at cr=0/1
Thread-Index: AQHWHEjMGVpmuPlRl0Kqrw5gTNRAkaindXQAgAF/eoCAAxN2gIAEw7YA
Date:   Wed, 20 May 2020 08:40:39 +0000
Message-ID: <3158FFEB-D9F7-450B-85C5-38B1C218321F@whamcloud.com>
References: <0B6BF408-EDF7-4363-80CD-BDA0136BF62C@whamcloud.com>
 <20200514100411.D1A15A405C@b06wcsmtp001.portsmouth.uk.ibm.com>
 <914597DA-395A-47A5-A8D6-DFCE2D674289@whamcloud.com>
 <3BA1CBB1-77DB-43C8-A9CD-A3B85223F86F@dilger.ca>
In-Reply-To: <3BA1CBB1-77DB-43C8-A9CD-A3B85223F86F@dilger.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dilger.ca; dkim=none (message not signed)
 header.d=none;dilger.ca; dmarc=none action=none header.from=whamcloud.com;
x-originating-ip: [95.73.208.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5160878c-4458-47f7-3fad-08d7fc997964
x-ms-traffictypediagnostic: DM6PR19MB2875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB287539336379D0872F20A149CBB60@DM6PR19MB2875.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMZwZQTdJMAyYjUrKW9fNJ121aKIFvlSH20v0vA8NvnlTp9wXGAhvEHDAWfnnpYeDOOcOea8959z6PGwPyEqpxiwEjWYcqxb50J/eDSiTaORMoDbao08hU1H8djeHVe2kKIS9k9KhD06g1MG1ecfdxRuGw3PpK3SjdbQ9DRw3PpoRw7GAHa/qg0lHH/8zJQ/+RzbNl60b8sgmnrXONfp4TjUQMh6Wrf2FOcx3AEP/yaRwAon7irnA3KA/9os4vIrZJlHkdhOvQ2N29CXL3uV4hIcjm+INOCgVy6PbiTVcBWh4tOchOQcYzH59ELiMudi/iBb2MyG1Xl2ZC51K1a4GKq4DkIioR7hxKKASMVIluaW1uqCQhcUbRUf2ZSg+a3EDKddX9PBsJj4SvxZ8tO/75qohBcOqUpxUMASYvPgDcPuh7qMz2NFgl5a2Zc9k6F5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2441.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(396003)(136003)(39850400004)(346002)(66946007)(2906002)(5660300002)(66446008)(91956017)(6512007)(64756008)(316002)(478600001)(66556008)(76116006)(6486002)(86362001)(66476007)(53546011)(36756003)(6506007)(6916009)(54906003)(186003)(33656002)(2616005)(71200400001)(4326008)(8936002)(8676002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: T5IRzr5fMexL5UNaF1kqvDO7xCFsMunN/ASSR0woy/XVEYUkNc97cCU3vgBkKz7nh0hgJNTrWB+ENP58P6EGgy96WNHue6wDu5bqZpwTWvNNNQ9MjVTQYjGyVblpte4bj/lUyDY0vF1wGpVe0IWlnjbb0MTMAoBwDKjfTmMvMBsOgVWeHuTSX82ufZO2nzOy2ACopyPuF7hqF1rtfy7tTGpC2YaL59DPdhFPA+KaiCVJJVL017ObhwnUNw0odspdcy2aD3TZiJ44UTPA77RUdv/NbTfUhrsdRXMgXodxkWhZqIuL56zXiE6jYwfb+TBB4O0ujUivGdiObJhD3P8d2vC6F3jYE9v+Ea3d3GO2qqcfb9uoUUVV3QiPhcCvboFtAu9jhaAKBwEWQjnNnh5EKTNpd6OOwXVZsU8ocsXY4wRVfUehEhJ+v3Ic1VLX8VeDfbOHhzohvL+psfVRNmSg0mMHsnKzDOErvMLaJ4QpMLs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F5CA66686A6934D8EA390BD32108704@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5160878c-4458-47f7-3fad-08d7fc997964
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 08:40:39.1034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqR1WSkyQqy3BA21hRgD1DkO6sQTMWdLe07apvByXg+oGDmeriscV0JzBttMOLdx5+Smi1wvFB76b0QwgsVzow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2875
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

DQoNCj4gT24gMTcgTWF5IDIwMjAsIGF0IDEwOjU1LCBBbmRyZWFzIERpbGdlciA8YWRpbGdlckBk
aWxnZXIuY2E+IHdyb3RlOg0KPiANCj4gVGhlIHF1ZXN0aW9uIGlzIHdoZXRoZXIgdGhpcyBpcyBz
aXR1YXRpb24gaXMgYWZmZWN0aW5nIG9ubHkgYSBmZXcgaW5vZGUNCj4gYWxsb2NhdGlvbnMgZm9y
IGEgc2hvcnQgdGltZSBhZnRlciBtb3VudCwgb3IgZG9lcyB0aGlzIHBlcnNpc3QgZm9yIGEgbG9u
Zw0KPiB0aW1lPyAgSSB0aGluayB0aGF0IGl0IF9zaG91bGRfIGJlIG9ubHkgYSBzaG9ydCB0aW1l
LCBiZWNhdXNlIHRoZXNlIG90aGVyDQo+IHRocmVhZHMgc2hvdWxkIGFsbCBzdGFydCBwcmVmZXRj
aCBvbiB0aGVpciBwcmVmZXJyZWQgZ3JvdXBzLCBzbyBldmVuIGlmIGENCj4gZmV3IGlub2RlcyBo
YXZlIHRoZWlyIGJsb2NrcyBhbGxvY2F0ZWQgaW4gdGhlICJ3cm9uZyIgZ3JvdXAsIGl0IHNob3Vs
ZG4ndA0KPiBiZSBhIGxvbmcgdGVybSBwcm9ibGVtIHNpbmNlIHRoZSBwcmVmZXRjaGVkIGJpdG1h
cHMgd2lsbCBmaW5pc2ggbG9hZGluZw0KPiBhbmQgYWxsb3cgdGhlIGJsb2NrcyB0byBiZSBhbGxv
Y2F0ZWQsIG9yIHNraXBwZWQgaWYgZ3JvdXAgaXMgZnJhZ21lbnRlZC4NCg0KWWVzLCB0aGF04oCZ
cyB0aGUgaWRlYSAtIHRoZXJlIGlzIGEgc2hvcnQgd2luZG93IHdoZW4gYnVkZHkgZGF0YSBpcyBi
ZWluZw0KcG9wdWxhdGVkLiBBbmQgZm9yIGVhY2gg4oCcY2x1c3RlcuKAnSAobm90IGp1c3QgYSBz
aW5nbGUgZ3JvdXApIHByZWZldGNoaW5nDQp3aWxsIGJlIGluaXRpYXRlZCBieSBhbGxvY2F0aW9u
Lg0KSXTigJlzIHBvc3NpYmxlIHRoYXQgc29tZSBudW1iZXIgb2YgaW5vZGVzIHdpbGwgZ2V0IOKA
nGJhZOKAnSBibG9ja3MgcmlnaHQgYWZ0ZXINCmFmdGVyIG1vdW50Lg0KSWYgeW91IHRoaW5rIHRo
aXMgaXMgYSBiYWQgc2NlbmFyaW8gSSBjYW4gaW50cm9kdWNlIGNvdXBsZSBtb3JlIHRoaW5nczoN
CjEpIGZldyB0aW1lcyBkaXNjdXNzZWQgcHJlZmV0Y2hpbmcgdGhyZWFkDQoyKSBsZXQgbWJhbGxv
YyB3YWl0IGZvciB0aGUgZ29hbCBncm91cCB0byBnZXQgcmVhZHkgLSB0aGlzIGVzc2VudGlhbHMg
b25lDQogICAgbW9yZSBjaGVjayBpbiBleHQ0X21iX2dvb2RfZ3JvdXAoKQ0KIA0KDQpUaGFua3Ms
IEFsZXgNCg0K
