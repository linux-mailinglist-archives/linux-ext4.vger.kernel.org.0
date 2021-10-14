Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC20442D98E
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Oct 2021 14:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhJNM4Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Oct 2021 08:56:24 -0400
Received: from mail-db8eur05on2130.outbound.protection.outlook.com ([40.107.20.130]:61725
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229994AbhJNM4Y (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 14 Oct 2021 08:56:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhyFcK97WsRzuQMVfGzT1KRyUSrX4mZX3HHCgocFsAh5M5Uq/i8Dq0AMxnHG81WdmV+D/qPV3Qiu6i4aY+KJG5Wf2nQCKayTe6bgtcvkQ0tUFXZ0mK9KZNrXfOyPOUXzyrUGxSEwNomKmhGEfP5Jy6qO+5C1xDQaTcfbLIFoDW+7GcdA+vfFUSyQQkY3fDoKCURYQPVLOLBigPF9U5FZLR77DxOsCjQ8my2HYN5XZuYZ8iF3y6u0/8Ha63Ej/TWVJmLlVTycRBpEr5E7fjG2rYEkfXHAC25RAeSUrTFfc/Ouw9lTSYhpaOu3DUT03tDUTRqLV/Em3UbEcMXvPfKDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bJ2xsd8rcePxygDiqwGb/696eckzrc3nLAvI5Sxc2k=;
 b=WgE2ix+b2lVlTh8H8YAtJXx1Ysue29ymPY0VnlJR7I6aGA8035RsQtWiCvq1PN26gn33nnxcD5WfDNhwoGiAOVgqGMtYmQ+xRB67kXisv7zqBTvjmvFIwqklTnNL+n5y9iVnCuRrcTZeHKyP/aKGLQDA4F5ina6Sxdz7oO/CvI2Lyc7FbOjy7bSes5GWqgcliZMRmhgIddK9nK5J+8K68+3P0mW/vv0/4TGtfKMNxyA9b0DI5IEdf+qoBoovlYCp6RscqkyRcGDTrFuP34kruvxivNlEbgsKaeTcUx8Ko3uyF3LgHF6TlAWrXgOiYtVHvNgAGnegbEaxwzULR6jo6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bJ2xsd8rcePxygDiqwGb/696eckzrc3nLAvI5Sxc2k=;
 b=cqoTpVqeTpskYPxgWGatBnIEdv/tPo0C5bN4IQG2bXnDrGsMbsDmVzVbX/FXqaPoCmslI1iEu2jIo2dLj9k79SMyuYUUtQxgPDEkwx3MiE22RL1/P5j9yij6lopMF6mUYYtXh9iJZlmHjmdlZgcoOCJN7WKwuDZiwy9OCiw9hvI=
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com (2603:10a6:7:2c::17) by
 HE1PR0701MB2268.eurprd07.prod.outlook.com (2603:10a6:3:2b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.8; Thu, 14 Oct 2021 12:54:14 +0000
Received: from HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::adf7:98c4:6be0:cf44]) by HE1PR07MB3450.eurprd07.prod.outlook.com
 ([fe80::adf7:98c4:6be0:cf44%7]) with mapi id 15.20.4608.004; Thu, 14 Oct 2021
 12:54:14 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "enwlinux@gmail.com" <enwlinux@gmail.com>,
        "hsiangkao@linux.alibaba.com" <hsiangkao@linux.alibaba.com>,
        "tytso@mit.edu" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Inode 2885482 (000000008e814f64): i_reserved_data_blocks (2) not
 cleared!
Thread-Topic: Inode 2885482 (000000008e814f64): i_reserved_data_blocks (2) not
 cleared!
Thread-Index: AQHXwPqXAzHCV0LQd0ejAP5woQtVGg==
Date:   Thu, 14 Oct 2021 12:54:14 +0000
Message-ID: <767ea5bb27e31cc58bea15cd2aec492946679bde.camel@nokia.com>
Accept-Language: en-US, en-150, fi-FI
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-2.fc34) 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d68dbb1-e987-4278-9fcd-08d98f11b9f9
x-ms-traffictypediagnostic: HE1PR0701MB2268:
x-microsoft-antispam-prvs: <HE1PR0701MB226847FA6FD75A9CD8AA3BA7B4B89@HE1PR0701MB2268.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:302;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LRVtVlQKxSwdT/bYwjyO1ozyhyP6k0isx9NGUQ68xBGIfofzMLwUqMqder/6lQA7NsSavhfGRH642woVpqmd9pX4PPBFSylxbDNF6l1svGsz0huGF91I6EX7rIfUtU6UflLEYiTnlGhrlpHP3o0hy+O2/w7DAKzslKhKs1sYQzxWDtfzzHF7Tg48psPxS0mwtu2TN0EHkmLxSe6U0q4FqDJVn8+Hrju7SwcXesVquLqi+NnQQOkl05rRjfRBW+V4NrJTTaydA/UBwfGz8H0AFPsfR8GAaVdXi59zc8HIMffs7ik7TYR4Vx3BE91iy/JUbA2oQgI1DVmvAnoO+9LRDbXokhBvouN3nCIyJ8VCbKS35eudChK1m86+FSMDM54cPLCroXPDcXy7ViwfWES6dIZgUk/vHwcjXJqrWuOA39bIkCjUFRxJDPQoD4ciMptvA/joPIQEHzMCnfinj3tsBCOGiN8gAND/uroS3wQlBU8fS+Rf1G5wcfUBfWn8aQo5lg9/kT/E4ehP9OzfqRIBQngEkCDWFDo3hPSGPnVnnW1nX3YyhKZUl6qldw5DCqjarXmERLiPBpsnSVpf1n7z0I3bMaykP/jS+Yf/b5+UJD5zVYb6QgawBajjQLoY9vSpvDiVQaa2XaBqbqdjMLOPCUVRwh6/xEc0W6PhMkj3eX7sYVWtzFqoJV74UHUoUthh8qAovUlWLw/hdC5UBGZRWS8hsIb9UIhfK/tjpWNL/kQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR07MB3450.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(83380400001)(508600001)(66446008)(54906003)(110136005)(8936002)(71200400001)(6512007)(64756008)(66946007)(82960400001)(26005)(186003)(76116006)(6506007)(38070700005)(6486002)(2616005)(316002)(5660300002)(36756003)(4326008)(86362001)(38100700002)(122000001)(2906002)(8676002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bCt5SWF2S0VEcSt1QUp1ZGZLa3A3M0R6NGpKRXNySkJ5WWVrZUI1UzVWd05J?=
 =?utf-8?B?bVA2VXJOMjA2dXE4UUJBbUhWcUJVMTV3U1RIamR2T2F6ZklxNEQ2MGd1Tysv?=
 =?utf-8?B?Vi9iWUdkOWFYSnJPdlV2cXozYUFQQzJiZzJwR0QxZFFGdElvcDlPdENtSGFM?=
 =?utf-8?B?UnFsSkw1UXVyWkZMVS8zYkNldEFxVFExbjZjM2w2bDBJK2hCTVliL2NUTklw?=
 =?utf-8?B?UU5vZlRrQjFDQ0c0alRCK3kwU0gwSVQ3d0oySS9lRlBvVURQdHg2T1F2Zll4?=
 =?utf-8?B?U1pEY3dZUXNwRzVTNzNEWlRubjQ4R2trOWE0M3VjL1ZKcU10QjB3VFAvQTlp?=
 =?utf-8?B?U0lGblpsdUlzcFkvNzBVVmg4bU4wSDJFaWpCTmtiYWxMMWxrTkJ4bHNQeTUr?=
 =?utf-8?B?UG5PS3gwYUVoUVhtMUM3MktSQzRTcGwwSUFOKzljMnlRbFVFR1ptbUF1Y0lw?=
 =?utf-8?B?OEE1UDhJVHNiUnVBdjc1eFdHaWFLWXN6VC9Ya1BYVzhiZEpGdXU5ZXQ1TENP?=
 =?utf-8?B?NGVPMFhkWXBXdy9sQjd5Zlh3ajVYZW9wOVFMR0pHUHhHcCs3NjRLdHNtUVk5?=
 =?utf-8?B?aFptNk4xa0dwazQxZmZjeEloVTE1bW1ycWtMRmZ4Tm1kcE04QmNxRkp2cktT?=
 =?utf-8?B?WEszYi94R2wzdlZHN1VwU2ZwOFZScGxmNEprd0Y4c3JzS3gvekx4bnlMdEo2?=
 =?utf-8?B?N05ITmo3WWRpbUdPZWl4bVA1WG8zZ0lJTTd5TDF4cFdYVU82TTZTQ2JLOGZ6?=
 =?utf-8?B?Q2srZi9qTlFXU1NUSStoaUhqaUNDK21DM3lkcFNNSGFmZTQ0dDRXamtON3Vz?=
 =?utf-8?B?ZlkwakNKVm1hdmpaK1ZsVDBPRG4zNlJIcUJtNGpJTDFhQzBRYlhKVnA1Q0VK?=
 =?utf-8?B?THUvTkk0R3BqQ3JiZjQ3M1N6Smk0TjVsQXN3aUtNT04vam5leGFobEFVcUZM?=
 =?utf-8?B?bllRQUp0elpzUGV6OE5keDgzeEtPQ09pa2VtU3RuZ1hRYmozWWd1M3Fwc3lq?=
 =?utf-8?B?dXl0Qkl1MzU5cW93ZXBmMUNta2wzMkEyQTFVY280ZUk2UzFhRFc2ajcxc0ZK?=
 =?utf-8?B?UE10K0w1T1BNR00vaitaTml4aW9TUDFlcCtndUo1Q2NMVFdmZmpMdnlINW01?=
 =?utf-8?B?MWpld3oxMjRkR0JCMmVIQ1JjVC9zemFNVUwrSzdobWtvY0JpZXdWbzM5Z2E0?=
 =?utf-8?B?YzBXVEpaeUk5bHVzZHljamdDeThJUHBrZWFXdHhSQmI4K3ZnNXZqS3I3MG9n?=
 =?utf-8?B?NWxva21La1crK0l4NFFNTWFldDBTUjRQL0ttaGkrT1FmVXB3enhmYVJXS0J0?=
 =?utf-8?B?MkJNYS9ISFRxTWZibmtEU0FWMFJtUlBKR3E4N0lqL29nV1UzQTVkZzFmRUNR?=
 =?utf-8?B?dEhhUHJrSlRkZ1VyZzIrMjZ4SlJHdGJ5MUdSV0N5ZndvNnJNZUtwV2xKK3Nt?=
 =?utf-8?B?V1hkYnFDT2xoSno4Rm1JekdkRzM0RlUxdGhwN3ZVVlZKNTZqZFhqVHk0WTVJ?=
 =?utf-8?B?RDFXZGNKbVMrbVdkbDh3Z21TY1Fibm9rdGNwWngrYm5sR0Vsd0RaMlJMTFBy?=
 =?utf-8?B?Y21EaDF3TTlKa29XTi9lYzdUL0Jza3VORGdsaUIzWmZjK2o5RGxmcjJqaWVw?=
 =?utf-8?B?Mzl1K0o4aStNV1d5T08rSEdsVjh1SUlMWmE0Zy9JLzUrYWJLSkhXeUdMN3FH?=
 =?utf-8?B?c0JNSHY4NFlqd3cyVmxuUG01UEdiTW5OOVBiM1c1Q1B2TDYxR3g4NVh5eHM4?=
 =?utf-8?Q?sQuvKjDUdOIzO+jIOuT5/MksT9anP5x56A2E00y?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <72D707EF001B344997D6F392CD4CA03C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR07MB3450.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d68dbb1-e987-4278-9fcd-08d98f11b9f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2021 12:54:14.5317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3woQtDWrg06tVw8wyjoJcODv4SUIf/y74tHG7X6ZHhBZMqsGaIymzwQ+neLsB1aITVn4tlKwjyoUaV+BBmGZu12bJIuzCzlUt+HpqW6HvgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2268
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

SGksDQoNCkknbSBzZWVpbmcgdGhlc2UgaV9yZXNlcnZlZF9kYXRhX2Jsb2NrcyBub3QgY2xlYXJl
ZCEgbWVzc2FnZXMgd2hlbiB1c2luZyBleHQ0DQp3aXRoIG5vZGVsYWxsb2MsIG1lc3NhZ2UgYWRk
ZWQgaW46DQoNCiAgY29tbWl0IDZmZWQ4Mzk1N2YyMWVmZjExYzg0OTZlOWYyNDI1M2IwM2QyYmMx
ZGMNCiAgQXV0aG9yOiBKZWZmbGUgWHUgPGplZmZsZXh1QGxpbnV4LmFsaWJhYmEuY29tPg0KICBE
YXRlOiAgIE1vbiBBdWcgMjMgMTQ6MTM6NTggMjAyMSArMDgwMA0KDQogICAgICBleHQ0OiBmaXgg
cmVzZXJ2ZWQgc3BhY2UgY291bnRlciBsZWFrYWdlDQoNCkkgY2FuIHF1aWNrbHkgcmVwcm9kdWNl
IGluIDUuMTUuMC1yYzUtMDAwNDEtZzM0ODk0OWQ5YTQ0NCBieSBkb2luZyBzb21lDQpmaWxlc3lz
dGVtIEkvTyB3aGlsZSB0b2dnbGluZyBkZWxhbGxvYzoNCg0KDQp3aGlsZSB0cnVlOyBkbyBtb3Vu
dCAtbyByZW1vdW50LG5vZGVsYWxsb2MgLzsgc2xlZXAgMTsgbW91bnQgLW8gcmVtb3VudCxkZWxh
bGxvYyAvOyBzbGVlcCAxOyBkb25lICYNCmdpdCBjbG9uZSBsaW51eCB4eHg7IHJtIC1yZiB4eHgN
Cg0KWyAgMjIyLjkyODM0MV0gRVhUNC1mcyAodmRiMSk6IHJlLW1vdW50ZWQuIE9wdHM6IGRlbGFs
bG9jLiBRdW90YSBtb2RlOiBkaXNhYmxlZC4NClsgIDIyMy45MzI1MTZdIEVYVDQtZnMgKHZkYjEp
OiByZS1tb3VudGVkLiBPcHRzOiBub2RlbGFsbG9jLiBRdW90YSBtb2RlOiBkaXNhYmxlZC4NClsg
IDIyNC4xODM3NDFdIEVYVDQtZnMgKHZkYjEpOiBJbm9kZSAyODg1NDgyICgwMDAwMDAwMDhlODE0
ZjY0KTogaV9yZXNlcnZlZF9kYXRhX2Jsb2NrcyAoMikgbm90IGNsZWFyZWQhDQpbICAyMjQuMTg1
MDY0XSBFWFQ0LWZzICh2ZGIxKTogSW5vZGUgMjg4NTQ3OCAoMDAwMDAwMDA4NjJiNDhhZCk6IGlf
cmVzZXJ2ZWRfZGF0YV9ibG9ja3MgKDIpIG5vdCBjbGVhcmVkIQ0KWyAgMjI0LjE4NjQzNF0gRVhU
NC1mcyAodmRiMSk6IElub2RlIDI4ODU0NzQgKDAwMDAwMDAwYTIwYmRkOTUpOiBpX3Jlc2VydmVk
X2RhdGFfYmxvY2tzICg3KSBub3QgY2xlYXJlZCENClsgIDIyNC4xODc2NDldIEVYVDQtZnMgKHZk
YjEpOiBJbm9kZSAyODg1NDc2ICgwMDAwMDAwMDAyODAwNWUxKTogaV9yZXNlcnZlZF9kYXRhX2Js
b2NrcyAoMikgbm90IGNsZWFyZWQhDQpbICAyMjQuMTg5MDE2XSBFWFQ0LWZzICh2ZGIxKTogSW5v
ZGUgMjg4NTQ3NSAoMDAwMDAwMDAyNWQ5NjE3ZCk6IGlfcmVzZXJ2ZWRfZGF0YV9ibG9ja3MgKDIp
IG5vdCBjbGVhcmVkIQ0KWyAgMjI0LjE5MDM3MF0gRVhUNC1mcyAodmRiMSk6IElub2RlIDI4ODU0
ODAgKDAwMDAwMDAwZDA3MjJkOTApOiBpX3Jlc2VydmVkX2RhdGFfYmxvY2tzICg3KSBub3QgY2xl
YXJlZCENClsgIDIyNC4xOTE3MzJdIEVYVDQtZnMgKHZkYjEpOiBJbm9kZSAyODg1NDgxICgwMDAw
MDAwMDliNTBkNmNiKTogaV9yZXNlcnZlZF9kYXRhX2Jsb2NrcyAoMSkgbm90IGNsZWFyZWQhDQpb
ICAyMjQuMTkzMDkzXSBFWFQ0LWZzICh2ZGIxKTogSW5vZGUgMjg4NTQ3MiAoMDAwMDAwMDBmZTkw
N2Y1NCk6IGlfcmVzZXJ2ZWRfZGF0YV9ibG9ja3MgKDEpIG5vdCBjbGVhcmVkIQ0KWyAgMjI3Ljk0
Njk4NF0gRVhUNC1mczogOTIxMyBjYWxsYmFja3Mgc3VwcHJlc3NlZA0KWyAgMjI3Ljk0Njk4OV0g
RVhUNC1mcyAodmRiMSk6IHJlLW1vdW50ZWQuIE9wdHM6IG5vZGVsYWxsb2MuIFF1b3RhIG1vZGU6
IGRpc2FibGVkLg0KDQoNCi1Ub21taQ0KDQo=
