Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F9A1DBF46
	for <lists+linux-ext4@lfdr.de>; Wed, 20 May 2020 21:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgETT7N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 May 2020 15:59:13 -0400
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com ([40.107.92.42]:6019
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728641AbgETT7M (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 20 May 2020 15:59:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DL2IKYBz+WnIJfMLVnJRbN32oX35nB5jxAnpcPPjqt7Lng/L9Uw3Ph3U6+22kaG5/UjzZr7fLIo1plCC6sFURV4hS4J4B8O/f5RqzOJTPjPSXhDfKQ/AAL5Afu/tFrYmqYn6fBoLWFH3TX1rC9/G99yv/ObWYrEv+HzdGV1baHuE7y8FStbEjvEyLOFrvdBOfiv3nlDRa/bkvq9fE4X10UruwFKB0AcfonAFr/fkSS4W6hADZf58apoau3KUW9DL0VT6EdtreXL4hzPNSrbmXSCIAn8aPAvmi8kZ+NQSanw5c6pUwdPHZcD8oB0hMAEpy0/sh8i15dtAPxW3peE6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmpHXGIYQ3DhZ1CXnyDvURVQK38sJJfUA8gcNBMzytE=;
 b=W+s4Kv7qeHi1XSi7wIo7d0sV8IEDbVUIkXJOYutYvzOCsW0rRoMTnjlQ0p+O062g6iatC7kUKJdZp6ux5EFSNkAXCIBmrXE4BXNY7CWMC5ZE5k0qSf+SG8VCcSI4usrAwJttHB4ieL35FPoOXlABsFvWCS3yJFDDAIgrNnnF94xP/Ig3MKWdfd52aIJbmnfnT7tsdIhQ+bx8MVeVx9kU+zqnpT1yaaXElUqMG9A5lLPMPtDTxcDZk331WMLT/4+OEmuDXKuRSW92bO7eHA18dkEEBkwzDzjtGWnUKb8GfB+hCDdfNpDA2mww+O/F2ju7ZV/W675zuQ2gyWzm0vXvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmpHXGIYQ3DhZ1CXnyDvURVQK38sJJfUA8gcNBMzytE=;
 b=ly4dqXLDsIyLFHw8PcXaiYFWgH4rz3gEAdksZitpncjqjywaETyDWcY9pE9BU6ec1pWS9lhUKveFNkHr8a8E/8Z/srCW1Yv+RDASqbz2RwluETrYap/gGfUr37ed8XVauk3JmERI4qWZ2ahZ3FOdmVpFSYnjhfUGOGWCpkphQSY=
Received: from DM6PR19MB2441.namprd19.prod.outlook.com (2603:10b6:5:18d::16)
 by DM6PR19MB2426.namprd19.prod.outlook.com (2603:10b6:5:15e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Wed, 20 May
 2020 19:59:09 +0000
Received: from DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4]) by DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 19:59:09 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     Andreas Dilger <adilger@dilger.ca>
CC:     Alex Zhuravlev <azhuravlev@whamcloud.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4: skip non-loaded groups at cr=0/1
Thread-Topic: [PATCH 2/2] ext4: skip non-loaded groups at cr=0/1
Thread-Index: AQHWHEjMGVpmuPlRl0Kqrw5gTNRAkaindXQAgAF/eoCAAxN2gIAEw7YAgAC2kICAAAcCAA==
Date:   Wed, 20 May 2020 19:59:09 +0000
Message-ID: <7F6AF0FC-2E52-4FC5-9663-C8874BA7B98E@whamcloud.com>
References: <0B6BF408-EDF7-4363-80CD-BDA0136BF62C@whamcloud.com>
 <20200514100411.D1A15A405C@b06wcsmtp001.portsmouth.uk.ibm.com>
 <914597DA-395A-47A5-A8D6-DFCE2D674289@whamcloud.com>
 <3BA1CBB1-77DB-43C8-A9CD-A3B85223F86F@dilger.ca>
 <3158FFEB-D9F7-450B-85C5-38B1C218321F@whamcloud.com>
 <DDB9F79B-55A9-4667-AE03-60D575CAD77A@dilger.ca>
In-Reply-To: <DDB9F79B-55A9-4667-AE03-60D575CAD77A@dilger.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dilger.ca; dkim=none (message not signed)
 header.d=none;dilger.ca; dmarc=none action=none header.from=whamcloud.com;
x-originating-ip: [95.73.208.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 941f3c98-2b9f-4e83-e500-08d7fcf842a1
x-ms-traffictypediagnostic: DM6PR19MB2426:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB242679B4F23B4C3C69193A4ACBB60@DM6PR19MB2426.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Kux1hMACmshMhPL0rZVseZcxWJ03xd6iyCd2c77zAU7aaUgUabuBkvuMjPNqIkxFu4sW1Zfjwh4MgrsWY+rStEWcGRd9graJ7h62/n+cpRUaiogaY+KAujHiwrtqf5xMIigu7xYI0152/4+3cH5OEvUDn42FhSjmm3C42o3REulNda+X81L8xwLXVViELIfzoyr/kCDtZ5Y70HQYHiIrvaSO1AWTxGQ1FPLpQmhWdqBLN8caQU4gGogkhPO9vj7HgJno+tp9WDrQxzVy7UrZrvZaLgusqT6s++9lRVrRSb8KVpmQnq2PWeEBFuSxUBCUsBgdK/65HsRNnQwgmEIOw0DgJdcy+JLSLZtj3TdrlM1GiNAglMGHK1Wjrp/2g2U+Y2yeMR+wCW7tXoW9ZhJh2b6ZYsCgsxwlvbzTDnJSEW7zuVeVFLelUdc26T5o3hy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2441.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39850400004)(346002)(136003)(376002)(76116006)(36756003)(66946007)(33656002)(91956017)(66556008)(66446008)(26005)(66476007)(64756008)(8676002)(2616005)(5660300002)(8936002)(6506007)(53546011)(6512007)(54906003)(86362001)(2906002)(478600001)(6916009)(316002)(71200400001)(186003)(6486002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Nx/3vtSBuyQgp9Ozgaw/Am5t5fsquUeWVnxH2ioCH8HxGybiOTrWCfcq7U1kR8DpoB+EX7RFH1eTJTxrOiG8zZnQsrqcCICFqSht8AExcu5gocaE0oKriEwgSe7UE0W634p6r/jnxrOv9udC3drMx09htBEGa/Jov1d4zSDxNon2qWCIgsuKa3kqHjal9stAu7TcQivjpFXrMwsRupu/ztI9BqrpxkoB630drndpcUX9DDEzARXg1b8bmNxWiNcysgikc9+UrEiVAXUqAu50v5HuHNf3Rv+PL/3f7/UOAmx5Ktuo+sfGdqvqJLEgYvT1yXX1s27cwvY1UuVyk/GaUlSLyXTxV+D/MilodBVUj23bpqPTSnV036sH2kYYvg2PaIK4J4ysHP9v5xZS2IF8yk3cEEZv1i2ljT47aahP+oUCMWJxx5rZsaGT/27yWdV8RUwKB43MwcVV3P9WHvzuGervLhydIENop6JloPyB/T0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <334A751B2ECB284D96C161B79FB9D3A6@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941f3c98-2b9f-4e83-e500-08d7fcf842a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 19:59:09.4980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ae1yDVEwvi/Hcal9wBfyforkClBHuFHGa29Z+CB4q9Of5OyUKGf/cwkwrsVye/7R4x89veHtR6edN3Sg0psVbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2426
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

DQoNCj4gT24gMjAgTWF5IDIwMjAsIGF0IDIyOjM0LCBBbmRyZWFzIERpbGdlciA8YWRpbGdlckBk
aWxnZXIuY2E+IHdyb3RlOg0KPiANCj4gT24gTWF5IDIwLCAyMDIwLCBhdCAyOjQwIEFNLCBBbGV4
IFpodXJhdmxldiA8YXpodXJhdmxldkB3aGFtY2xvdWQuY29tPiB3cm90ZToNCj4+IA0KPj4+IE9u
IDE3IE1heSAyMDIwLCBhdCAxMDo1NSwgQW5kcmVhcyBEaWxnZXIgPGFkaWxnZXJAZGlsZ2VyLmNh
PiB3cm90ZToNCj4+PiANCj4+PiBUaGUgcXVlc3Rpb24gaXMgd2hldGhlciB0aGlzIGlzIHNpdHVh
dGlvbiBpcyBhZmZlY3Rpbmcgb25seSBhIGZldyBpbm9kZQ0KPj4+IGFsbG9jYXRpb25zIGZvciBh
IHNob3J0IHRpbWUgYWZ0ZXIgbW91bnQsIG9yIGRvZXMgdGhpcyBwZXJzaXN0IGZvciBhIGxvbmcN
Cj4+PiB0aW1lPyAgSSB0aGluayB0aGF0IGl0IF9zaG91bGRfIGJlIG9ubHkgYSBzaG9ydCB0aW1l
LCBiZWNhdXNlIHRoZXNlIG90aGVyDQo+Pj4gdGhyZWFkcyBzaG91bGQgYWxsIHN0YXJ0IHByZWZl
dGNoIG9uIHRoZWlyIHByZWZlcnJlZCBncm91cHMsIHNvIGV2ZW4gaWYgYQ0KPj4+IGZldyBpbm9k
ZXMgaGF2ZSB0aGVpciBibG9ja3MgYWxsb2NhdGVkIGluIHRoZSAid3JvbmciIGdyb3VwLCBpdCBz
aG91bGRuJ3QNCj4+PiBiZSBhIGxvbmcgdGVybSBwcm9ibGVtIHNpbmNlIHRoZSBwcmVmZXRjaGVk
IGJpdG1hcHMgd2lsbCBmaW5pc2ggbG9hZGluZw0KPj4+IGFuZCBhbGxvdyB0aGUgYmxvY2tzIHRv
IGJlIGFsbG9jYXRlZCwgb3Igc2tpcHBlZCBpZiBncm91cCBpcyBmcmFnbWVudGVkLg0KPj4gDQo+
PiBZZXMsIHRoYXTigJlzIHRoZSBpZGVhIC0gdGhlcmUgaXMgYSBzaG9ydCB3aW5kb3cgd2hlbiBi
dWRkeSBkYXRhIGlzIGJlaW5nDQo+PiBwb3B1bGF0ZWQuIEFuZCBmb3IgZWFjaCDigJxjbHVzdGVy
4oCdIChub3QganVzdCBhIHNpbmdsZSBncm91cCkgcHJlZmV0Y2hpbmcNCj4+IHdpbGwgYmUgaW5p
dGlhdGVkIGJ5IGFsbG9jYXRpb24uDQo+PiBJdOKAmXMgcG9zc2libGUgdGhhdCBzb21lIG51bWJl
ciBvZiBpbm9kZXMgd2lsbCBnZXQg4oCcYmFk4oCdIGJsb2NrcyByaWdodCBhZnRlcg0KPj4gYWZ0
ZXIgbW91bnQuDQo+PiBJZiB5b3UgdGhpbmsgdGhpcyBpcyBhIGJhZCBzY2VuYXJpbyBJIGNhbiBp
bnRyb2R1Y2UgY291cGxlIG1vcmUgdGhpbmdzOg0KPj4gMSkgZmV3IHRpbWVzIGRpc2N1c3NlZCBw
cmVmZXRjaGluZyB0aHJlYWQNCj4+IDIpIGxldCBtYmFsbG9jIHdhaXQgZm9yIHRoZSBnb2FsIGdy
b3VwIHRvIGdldCByZWFkeSAtIHRoaXMgZXNzZW50aWFscyBvbmUNCj4+ICAgbW9yZSBjaGVjayBp
biBleHQ0X21iX2dvb2RfZ3JvdXAoKQ0KPiANCj4gSU1ITywgdGhpcyBpcyBhbiBhY2NlcHRhYmxl
ICJjYWNoZSB3YXJtdXAiIGJlaGF2aW9yLCBub3QgcmVhbGx5IGRpZmZlcmVudA0KPiB0aGFuIG1i
YWxsb2MgZG9pbmcgbGltaXRlZCBzY2FubmluZyB3aGVuIGxvb2tpbmcgZm9yIGFueSBvdGhlciBh
bGxvY2F0aW9uLg0KPiBTaW5jZSB3ZSBhbHJlYWR5IHNlcGFyYXRlIGlub2RlIHRhYmxlIGJsb2Nr
cyBhbmQgZGF0YSBibG9ja3MgaW50byBzZXBhcmF0ZQ0KPiBncm91cHMgZHVlIHRvIGZsZXhfYmcs
IEkgZG9uJ3QgdGhpbmsgYW55IGdyb3VwIGlzICJiZXR0ZXIiIHRoYW4gYW5vdGhlciwNCj4gc28g
bG9uZyBhcyB0aGUgYWxsb2NhdGlvbnMgYXJlIGF2b2lkaW5nIHdvcnN0LWNhc2UgZnJhZ21lbnRh
dGlvbiAoaS5lLiBhDQo+IHNlcmllcyBvZiBvbmUtYmxvY2sgYWxsb2NhdGlvbnMpLg0KDQpJIHRl
bmQgdG8gYWdyZWUsIGJ1dCByZWZyZXNoZWQgdGhlIHBhdGNoIHRvIGVuYWJsZSB3YWl0aW5nIGZv
ciB0aGUgZ29hbCBncm91cA0KKG9uZSBtb3JlIGNoZWNrKS4gRXh0cmEgd2FpdGluZyBmb3Igb25l
IGdyb3VwIGR1cmluZyB3YXJtdXAgc2hvdWxkIGJlIGZpbmUsIElNTy4NCg0KVGhhbmtzLCBBbGV4
