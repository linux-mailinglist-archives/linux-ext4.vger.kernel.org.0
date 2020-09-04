Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F47A25DEC0
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Sep 2020 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgIDP5X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Sep 2020 11:57:23 -0400
Received: from mail-bn8nam12on2100.outbound.protection.outlook.com ([40.107.237.100]:63584
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbgIDP5W (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 4 Sep 2020 11:57:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be9t003Wahm5EmnLSq3ARv3uUBYMk3oGYMD2ZOr8CXELIVIxKJb9Zqf0wGHZx4Cxlf6dORAusapf5pitkETkeyIaifMuuz6l3ETxjn47VAZ23kZEmGIRxkxjI5p+H4MAOOoCQZtuJA5WePqybSeCFA+MK9Dsv6Szuj+XaiU4ClWH9kGixFjbmwrREVawnJ5CoRO+qXl1ASPLb43n7qBtv6/pAAGXZN4t43TNFU1qTUyKNZnNLAfAAd9dI3qYAEH8GkSM0u0TykosDmmps3y+94QJ5qCrzkI+oB/zHVQaKhbBgvUFs/niWTAcn77RHcHFKEJj3CwYmo39eyH/8Tlhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImjE4jUCaQiGAui4YZAsRLGpmbS3qrmGXnj5g9JXqEs=;
 b=izjtuymj932D+aIIbS/2XMF4dTeAtHF7QlPZppzgL4B8gaG5WFVh7doDoFRn2Yh3+384BEH+4BGYmAAUnKm7wkbkHQXOPkrb74S+aPyN0wdr1Vn9Vut6/cPzslqno9zF8BRLGHfeSPQciwdMviLrdn6oxGPHOQaBSXAw1Zz5EgO+sZtuUofbFw4yLvliN5oPETIBsRi4A2hEncvYMQx/e50cZ0YcmqDe7svAUI9edtcCOgRvqZcGmSYX1fttNyQ+qiin2NpU2fC/nOOa22zFHJZyDiK9steUfe398ZxA1qjE/nFGTPTeNjthfXFpPIe9NGj8Jl7oGRLS49/6JQ/yqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImjE4jUCaQiGAui4YZAsRLGpmbS3qrmGXnj5g9JXqEs=;
 b=lD15huLcZCNB5xALT1UxgC3wW26mGLbcJUtbrKhHlXUsLMtl5l+23JjzalI0XvhoOliaQQ/TiTUsn9jf88LSVy7nXktTnFKF1ExFn+8Tao109jkn8HT8IJw+xX5hKGPYvhQIfQhdFjrUjF5ZlWmE9Pq1zNFpeE1G/0GYytgkxdI=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB2055.namprd22.prod.outlook.com (2603:10b6:610:8f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 15:57:19 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::34a6:b9c8:5c74:f348]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::34a6:b9c8:5c74:f348%4]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 15:57:18 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "Sousa da Fonseca, Pedro Jose" <pfonseca@purdue.edu>
Subject: PROBLEM: potential concurrency bug in swap_inode_boot_loader()
Thread-Topic: PROBLEM: potential concurrency bug in swap_inode_boot_loader()
Thread-Index: AQHWgtQRHXnnvDqkpEef0id3i+u7lg==
Date:   Fri, 4 Sep 2020 15:57:18 +0000
Message-ID: <59AE9CA8-074C-4971-A857-175CA0E86420@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=purdue.edu;
x-originating-ip: [66.253.158.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f700fd6-4744-410e-74b4-08d850eb33cb
x-ms-traffictypediagnostic: CH2PR22MB2055:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR22MB2055C96D4990BCE67BE52884DF2D0@CH2PR22MB2055.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y/owM0kk9JEtRYV3aS1rVPJyuoDMZl56KptSfPeUK8kmcEM6ln+0bYNa5HmPQNIIprHccriOdt/4i82gAy7Uha0XWUMkbeqpIVvn9XeJKOR5enV67S/q5IXidXHKi6EOqJdD9vqWQMdsWmx+SSVj88V12REHb3tPsx2pKv+B0KD3WuriI8h6Lkky/4qHXHtk9WeNAveH695YRUV9kGyBju9BsSkFKK+F0LCcMVfVWMvfN0zvthTSvSlK/XDneJPxfijwztSlGO24QVb4QOZYQro4dkULmYOKwJHO6Q8VLxxptTIqvcktXMq7d+GUpQ/aJKMXFFFp5l5Yjze06N4QsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39860400002)(366004)(346002)(107886003)(110136005)(316002)(6512007)(8936002)(71200400001)(478600001)(786003)(6486002)(66946007)(66446008)(66556008)(66476007)(64756008)(4326008)(33656002)(86362001)(54906003)(8676002)(5660300002)(186003)(6506007)(2906002)(76116006)(2616005)(36756003)(26005)(75432002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2rjFz0WOGf3KjOUAV76Z8NQ5GRkkyxu+f6NAh3n+ujAoCRQJ+gSTqcOs+/irpjPhw9mFEw1+YUPPeVtvBwdnW+85eYjTPHTYG7nxl0t9RstH0SzULXXH6SRKKpTYTeb4QpCZMHFX/MvQVm2Yw4IQEC2VuQt6Q4TM6N8A8tKbmR88Eef/3N0fqHvqu8g9meou0RD7FcSkQoboemM4+irrMJa2bewf4AUBByvRLvxpqlwQg3qx91lL/fyWJVdSEGP6a2E7SxmlwUXDa72aMpCt9V9s+A9P5LL7IClpP+P6gaxOJQzycDor1g+ziLPrtDHjJYXbjfU7YAkYQb5cuc6bwO45GM0Ciup+nwXNAmAmLnqs3JhtlnGR+GEChykLMxhbvkxJCpqg3gQ7019sxyWEn0G7t2zFGl31WGd2s1Jb6HSHeE8Zw9yeoTEmtgj1209SPwpBWJ2kNSn6yaTrT/TUJcukAR77iFAzX/XUdWdil/KRrgy/B45Wb36o+Wx4Ywnh+2E/GIo+2ktg222FVEwQZXjiF3wWDz69CXMNJKBz7ODJl2T6zNAsbm6WE/orl2jsk1dHGAG3HsWrEpd15XIgJRa77NxJwsBOsJzB5ykWm03ircDn9WchZbg2HWwia3yqBnp9CHmL1vpWQ3/lgqJ8gg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <13A99A72B6647D4DACE281AF5CEC9610@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f700fd6-4744-410e-74b4-08d850eb33cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 15:57:18.5869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abR3ElVMLvRO/UM3YcZDEXbQrk1mvDn5Kw2WQDt8ApqSlOQu8Sz72Ecj+LOJ4A8BA0zqjlEaiQ6ty+SeGScFIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB2055
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

SGksDQoNCldlIGZvdW5kIGEgcG90ZW50aWFsIGNvbmN1cnJlbmN5IGJ1ZyBpbiBsaW51eCBrZXJu
ZWwgNS4zLjExLiBXZSB3ZXJlIGFibGUgdG8gcmVwcm9kdWNlIHRoaXMgYnVnIGluIHg4NiB1bmRl
ciBzcGVjaWZpYyB0aHJlYWQgaW50ZXJsZWF2aW5ncy4gVGhpcyBidWcgY2F1c2VzIGEg4oCcY2hl
Y2tzdW0gaW52YWxpZOKAnSBFWFQ0LWZzIGVycm9yLg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCktlcm5lbCBjb25zb2xlIG91dHB1dA0KDQpFWFQ0LWZzIGVy
cm9yIChkZXZpY2Ugc2RhMSk6IHN3YXBfaW5vZGVfYm9vdF9sb2FkZXI6MTI0OiBpbm9kZSAjNTog
Y29tbSBza2ktZXhlY3V0b3I6aWdldDogY2hlY2tzdW0gaW52YWxpZA0KDQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClRlc3QgaW5wdXQNCg0KVGhpcyBidWcgb2Nj
dXJzIHdoZW4gYSBrZXJuZWwgdGVzdCBwcm9ncmFtIGlzIGV4ZWN1dGVkIHR3aWNlIGluIGRpZmZl
cmVudCB0aHJlYWRzIGFuZCByYW4gY29uY3VycmVudGx5LiBPdXIgYW5hbHlzaXMgaGFzIGxvY2F0
ZWQgdGhhdCBpdCBoYXBwZW5zIHdoZW4gc3lzY2FsbCBpb2N0bCB3aXRoIHRoZSBFWFQ0X0lPQ19T
V0FQX0JPT1QgZmxhZyBpcyBjYWxsZWQgdHdpY2UgYW5kIGludGVybGVhdmVzIHdpdGggaXRzZWxm
LiANClRoZSB0ZXN0IHByb2dyYW0gaXMgZ2VuZXJhdGVkIGJ5IFN5emthbGxlciBhcyBmb2xsb3dz
Og0KcjAgPSBjcmVhdCgmKDB4N2YwMDAwMDAwMDgwKT0nLi9maWxlMFx4MDAnLCAweDApDQppb2N0
bCRGU19JT0NfU0VURkxBR1MocjAsIDB4NDAwNDY2MDIsICYoMHg3ZjAwMDAwMDAwNDApKSANCnIx
ID0gY3JlYXQoJigweDdmMDAwMDAwMDAwMCk9Jy4vZmlsZTBceDAwJywgMHgwKQ0KcHdyaXRlNjQo
cjEsICYoMHg3ZjAwMDAwMDAwYzApPSdceDAwJywgMHgxLCAweDEwMTAwMDApDQpyMiA9IGNyZWF0
KCYoMHg3ZjAwMDAwMDAwMDApPScuL2ZpbGUwXHgwMCcsIDB4MCkNCmlvY3RsJEVYVDRfSU9DX1NX
QVBfQk9PVChyMiwgMHg2NjExKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCkludGVybGVhdmluZw0KDQpPdXIgYW5hbHlzaXMgcmV2ZWFsZWQgdGhhdCB0aGUg
Zm9sbG93aW5nIGludGVybGVhdmluZyB0cmlnZ2VycyB0aGUgYnVnLg0KQ1BVMAkJCQkJCQkJQ1BV
MQ0KCQkJCQkJCQkJc3dhcF9pbm9kZV9ib290X2xvYWRlcigpDQoJCQkJCQkJCQnigKYNCgkJCQkJ
CQkJCQlieXRlcyA9IGlub2RlX2JsLT5pX2J5dGVzOw0KICAJCQkJCQkJCQkJaW5vZGVfYmwtPmlf
YmxvY2tzID0gaW5vZGUtPmlfYmxvY2tzOw0KICAJCQkJCQkJCQkJaW5vZGVfYmwtPmlfYnl0ZXMg
PSBpbm9kZS0+aV9ieXRlczsNCgkJCQkJCQkJLS0tPiAgICAgCWVyciA9IGV4dDRfbWFya19pbm9k
ZV9kaXJ0eShoYW5kbGUsIGlub2RlX2JsKTsNCg0KCQkJCQkJCQkJCWV4dDRfbWFya19pbG9jX2Rp
cnR5KCkgKGZzL2V4dDQvaW9jdGwuYzogMjIzKQ0KCQkJCQkJCQkJCQlleHQ0X2RvX3VwZGF0ZV9p
bm9kZSgpDQoJCQkJCQkJCQkJCQlleHQ0X2lub2RlX2NzdW1fc2V0KCkNCgkJCQkJCQkJCQkJCQll
eHQ0X2hhc19tZXRhZGF0YV9zdW0oKQ0KCQkJCQkJCQkJCQkJCQlleHQ0X2lub2RlX2NzdW0oKQ0K
CQkJCQkJCQkJCQkJCQkJZXh0NF9jaGtzdW0oKQ0KCQkJCQkJCQkJCQkJCQkJCWNyeXB0b19zaGFz
aF91cGRhdGUoKQ0KCQkJCQkJCQkJCQkJCQkJCQljaGtzdW1fdXBkYXRlKCkNCgkJCQkJCQkJCVtj
b250ZXh0IHN3aXRjaF0NCnN3YXBfaW5vZGVfYm9vdF9sb2FkZXIoKQ0KCWV4dDRfaWdldCgpDQoJ
CWV4dDRfaW5vZGVfY3N1bV92ZXJpZnkoZnMvZXh0NC9pbm9kZS5jOjQ5MjcpDQpbRVhUNC1mcyBl
cnJvcl0NCg0KDQoNCg0KVGhhbmtzLA0KU2lzaHVhaQ0KDQo=
