Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2E410437D
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2019 19:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfKTSdS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Nov 2019 13:33:18 -0500
Received: from mail-eopbgr720080.outbound.protection.outlook.com ([40.107.72.80]:62107
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727671AbfKTSdS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 20 Nov 2019 13:33:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGLNNNMqfzJeI0J0ICO1XIia35wcOG8mGzidGHQusZR+zOiwLsr07VxwLf26ptrgAm4S0qvtp2BscudtIiu9gvZSksXDmNMJXAA01FZg4N70N0o7VD9QIaYpMRcfKu0zcIc/Mpm79I0g88R2AIZ2X5Z1Hjacubh1JGnntFn9yPScls4UBiqxPNsh1UmrBSI/jNsGGUjydi5WAKYILzJubMrxd4661un8kUM9E2zlvPVpXhG8St6a1mvZ2ETyCqNVWdGNXWAxugbqSjk9C6gfa4Sf6MG2rRVsFh1sDrgrZvvrlAOjuv/5QQ1nUB5GZuEPyLR6pqlPYh7KzYjKzeYpgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo9fXcTI8Ohww4Sfv8Y8rs/KptPdfsueDkQw0Tcsnwo=;
 b=NWD163GbhWp0TOwc8pLN24DHu5BXV/Bq7zQ+R4k2p7Cm1YEYC88tbGdeulRXvP8XfTYJZ83uJLjd+VPBssc7GhzENeyxsS4IjMSyvwfzYrVA4XOE40H1qxcYLIkNSAw83jVs3RSq/8bVs7yiekGBwpxbk5RQZsiSQxIW2RD1pInugEY/qDoZ5p82qOCexmjr0qr1a/Am6WGp52kVF0PjzmW9U5nrq/fs6V+AAOFOWwstI2WqrdsLzWEM2t9PGWKqpoEfBwuvlI7zznD84aTq094Ar6YBQybYu1phuZW87f+jYoLnqmkszX35E6n1Gc5jhjnBIkmPTYuIR1Q+97cnxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo9fXcTI8Ohww4Sfv8Y8rs/KptPdfsueDkQw0Tcsnwo=;
 b=vcDjWXrXzwoKH8sEoDdTjOswMbMeDux5osgrd097BSb0leS2bAuvNpmRx2yFgLfoxHxNbACW0fxdn51zdpFXK0AgoMY/UY2AwgzqCAa0zSGAJtfCZgB1bSlL01q75xafskPHyGrRjlVy4B4BhIE2dIHOGGj5QxJJrY4NSZyqvxk=
Received: from MN2PR19MB2894.namprd19.prod.outlook.com (20.178.254.95) by
 MN2PR19MB2765.namprd19.prod.outlook.com (20.178.253.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Wed, 20 Nov 2019 18:33:15 +0000
Received: from MN2PR19MB2894.namprd19.prod.outlook.com
 ([fe80::a499:dae8:b1c1:b08e]) by MN2PR19MB2894.namprd19.prod.outlook.com
 ([fe80::a499:dae8:b1c1:b08e%7]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 18:33:15 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [RFC] improve malloc for large filesystems
Thread-Topic: [RFC] improve malloc for large filesystems
Thread-Index: AQHVn45AfmzanBfwskq4XYElVj+Zs6eT9BkAgABuugA=
Date:   Wed, 20 Nov 2019 18:33:14 +0000
Message-ID: <57B9C5F4-F6C1-4B19-BCA3-3A23C8F1EA8A@whamcloud.com>
References: <8738E8FF-820F-48A5-9150-7FF64219ED42@whamcloud.com>
 <AC2A955C-3E0C-4A4D-879A-38B715A86149@gmail.com>
In-Reply-To: <AC2A955C-3E0C-4A4D-879A-38B715A86149@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=azhuravlev@whamcloud.com; 
x-originating-ip: [128.72.176.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e73ed4b9-778e-40a6-455e-08d76de81b20
x-ms-traffictypediagnostic: MN2PR19MB2765:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR19MB2765ED8503BA6EB54293AFC3CB4F0@MN2PR19MB2765.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39850400004)(396003)(366004)(346002)(199004)(189003)(4744005)(76176011)(8676002)(36756003)(478600001)(86362001)(446003)(11346002)(4326008)(5660300002)(71190400001)(71200400001)(6486002)(486006)(14454004)(81156014)(81166006)(966005)(91956017)(76116006)(316002)(6436002)(26005)(186003)(6246003)(33656002)(3846002)(2616005)(6306002)(6506007)(6512007)(53546011)(476003)(102836004)(6116002)(2906002)(66476007)(99286004)(6916009)(256004)(64756008)(66446008)(66946007)(7736002)(229853002)(66066001)(66556008)(25786009)(305945005)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR19MB2765;H:MN2PR19MB2894.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: whamcloud.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FLL4pG+E2QyW3n6/l8aU8sduqj8icmsAHY/arAWuYKmkwL71aB6Vr4NeewP0kPLE/+xwbey1SQxnTwOt8IK0HIdyo6Q4T+WUarGKkC76mQNV+rOV9HbpJqgcyHkrSUNVhEvM3wFHI1WxSobtD7fDmMPKUhV11MV8NTCPu+5xONMc1U6BCyPK2fTdISvF+7L8ZtEj0jzebXVjzv34G7UxOdVAw0xqcMWmubKx4Hl+cEtTh+LOgDktZtgKJeOG+m7eH0mlD5s4iPyhH3WCY+Y5DOZ5z818SZQDAPCPdJHo1FAx5of/ApJ4+8BYEXZ+9hfNR+etOCv4jFU4MCUcpUQER7ehoWMaV3pjvwDVvldvSNP4xw+q7mCmSc1ghXPbgf9B4NiYkCM5JN6fN7vxIIu/rTJub7rDKvoO2rIB4nVDzp/2sEEmOY5GC1dVJpcV6SKiq4ldxTKRvtG5lez6QRCjRQbpmeo6uQhf5URKMDSkngw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <13BF4657D3A28E4C971F584EE8B23AC6@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73ed4b9-778e-40a6-455e-08d76de81b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 18:33:15.0035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwS/Inl7JttNZxGSpnxNQts80UIdoSH1qTyvN/rbxmyJmRK+D1OZVqj+ZsYZOBsUUXtmMtkNH6tYpkF0xmPZkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2765
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

DQoNCj4gT24gMjAgTm92IDIwMTksIGF0IDE0OjU2LCBBcnRlbSBCbGFnb2RhcmVua28gPGFydGVt
LmJsYWdvZGFyZW5rb0BnbWFpbC5jb20+IHdyb3RlOg0KPiBOb3cgSSB3YW50IHRvIHNoYXJlIG15
IHRob3VndGhzIGFib3V0IHRoaXMgdG9waWMuDQo+IEhlcmUgYXJlIHNsaWRlcyBmcm9tIExBRDIw
MTkg4oCcTGRpc2tmcyBibG9jayBhbGxvY2F0b3IgYW5kIGFnZWQgZmlsZSBzeXN0ZW0iIGh0dHBz
Oi8vd3d3LmVvZnMuZXUvX21lZGlhL2V2ZW50cy9sYWQxOS8xNF9hcnRlbV9ibGFnb2RhcmVua28t
bGRpc2tmc19ibG9ja19hbGxvY2F0b3IucGRmDQo+IFRoZXJlIGlzIGFsc28gcGF0Y2ggaHR0cHM6
Ly9saXN0cy5vcGVud2FsbC5uZXQvbGludXgtZXh0NC8yMDE5LzAzLzExLzUgdGhhdCB3YXMgc2Vu
dCBoZXJlLCBidXQgaXQgcmVxdWlyZSB0byBiZSBpbXByb3ZlZC4NCg0KVGhhbmtzLCBsZWFybmlu
ZyB0aGlzIGludGVyZXN0aW5nIHN0dWZmLi4NCg0KVGhhbmtzLCBBbGV4DQoNCg==
