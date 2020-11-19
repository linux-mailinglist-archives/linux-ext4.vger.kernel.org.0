Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131A92B928B
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Nov 2020 13:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgKSM0o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Nov 2020 07:26:44 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:17156 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726845AbgKSM0o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 19 Nov 2020 07:26:44 -0500
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJCGvcX008112;
        Thu, 19 Nov 2020 12:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=0emI7px4z+u63UZ0ZSvPQgOhuYq/8G1D4bwuFWOwA8s=;
 b=PoJIsyPRl08AF6yfil9sHJBwQ18DYVlfIyfdbI57l3YUbZNAGoQz0XQabVFoAByjIHBQ
 D5dYqykD3nW78aZm5pPa82SCYkRlxu900KESl9zOs6mST2RD/Nu/zhoxfzQYyWiz0OB4
 gwp6DMQUKP7SmlfxZ3XOMJZ0rGv+FbmXnt+hyDZcBlwNgt0/QSU098iMBSMVOZ3I4DHh
 UU4bH2rBi9lDNNFU+S7u7qdbGSJPD4wR3f8dUbcKQojFHjRP+9XZi/c8eZxkK7Swb6V2
 9Rlvgu7JpJMN06XDQi63ehgj7WRCsaoVfr5MjwoH30tkjcHUnJ3arsiPd7E9a+Fw7vHH jw== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 34vgcbk0wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 12:26:38 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id 6985C59;
        Thu, 19 Nov 2020 12:26:37 +0000 (UTC)
Received: from G9W9209.americas.hpqcorp.net (16.220.66.156) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 19 Nov 2020 12:26:35 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (15.241.52.11) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 19 Nov 2020 12:26:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI51BC+cta0F6cIEsGbeyI8KmlURVEYKH/W4KUPWfQFGvAosPVO80rPw/G3zt7lS01HCI8XOYx8Zt24Yrba8DuALxuaVvLI9lnSitc2S84MJKzlnjpoQpOYMbMS5JmT+jFEnstI3md5R/nC3Qq5ElPzEAJRSJyplv681F1yd9FbpIAkxhDDfRGyV/pgC52+1d+TNcWDoGIaeVbz7z7mutBROilJ3a/1499qwdmAhd+4HdC63IIjg0RslDBg9p3hXYYIr9yGds8OGhBEUqkBBnBhzuhN+r4ljyZbsOsSpbvZIRC/bZs4naMLMCielyeYRUYtnkiKnHf9KyXw50KMZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0emI7px4z+u63UZ0ZSvPQgOhuYq/8G1D4bwuFWOwA8s=;
 b=lAxPHn7Pq4SfKflbfrLXdAmsXkhFdTxdc4ECys+DjNROwpVEkk/7rOtNfYPeI/ML8qVWIle48EpqSWVrCMgx+pwGNdf0f4nt/GLFDGGj+DVU0YzW8eOAdXIPnwLD4HXiHnCXZ8KyGYz2FlAo11RtZ/nkwRyI+VwWpO54HkYABCszxzCJ0jfS0Rdu5WGSjP/8YYtUfwa+TWAMfiIy7tFbhX5O1RwmzjF8wyAeseACHT7vPXQ0yxAGMX4dsuehKl56kjuiuQySLIPegolKYlYdPKyWVjZQE7J3/2zHrxv/uqFokauphA1howc1ssYvyvCax57Uytut8xDoJwv1OV+Ozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB1181.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7716::10) by TU4PR8401MB1135.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7714::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Thu, 19 Nov
 2020 12:26:34 +0000
Received: from TU4PR8401MB1181.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fdc8:7994:39c9:b159]) by TU4PR8401MB1181.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fdc8:7994:39c9:b159%7]) with mapi id 15.20.3589.024; Thu, 19 Nov 2020
 12:26:34 +0000
From:   "Lyashkov, Alexey" <alexey.lyashkov@hpe.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        Theodore Tso <tytso@google.com>
Subject: Re: [PATCH] libfs: Fix DIO mode aligment
Thread-Topic: [PATCH] libfs: Fix DIO mode aligment
Thread-Index: AQHWqS98Ux7JmHKkRkWLHTDBEn/6w6nMmrSAgABAAwCAAuOigA==
Date:   Thu, 19 Nov 2020 12:26:34 +0000
Message-ID: <B8DE3834-1B3F-4E1E-B342-51E04E4FD278@hpe.com>
References: <20201023112659.1559-1-artem.blagodarenko@gmail.com>
 <19A3D721-93C0-42F3-ACBA-DE15B4685F9F@gmail.com>
 <20201117191918.GB529216@mit.edu>
In-Reply-To: <20201117191918.GB529216@mit.edu>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [31.28.251.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df58aa70-9c54-45cf-3d91-08d88c865a9a
x-ms-traffictypediagnostic: TU4PR8401MB1135:
x-microsoft-antispam-prvs: <TU4PR8401MB1135D866D14EED9384035310F7E00@TU4PR8401MB1135.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PYuEuKg+Y5d9Rgjh/RryiZcxAxgw2GgHdxGl4iBDRkEko5c+JcecEwgNjpLHl0TidyYdFHO1SshW3b0aayKBIO/4zBH75dUSGcEhXLN8tlU7j7+Or9glGV0U+pwGKTEynTwpjOWujz8oVCgZNMjM3g5QHmjRvDlnmEurDTwffj/X3q3lPZhEvzw7/xkYBHJcQtmSXQZW6QuxlAXdBk64fwMqHfJu3uCWyTemq0gZQxODIbT7Z5DsLofpUodCEEmVdNkOg+q6RKHYrD2CcOdIBGC9cMjBmnK0oijPXU903Tkhzw1wKX4cV4PzNBbe6iTLyLoYIKw76Nh0nRqUiMDMZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TU4PR8401MB1181.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(39860400002)(136003)(71200400001)(6486002)(64756008)(83380400001)(186003)(54906003)(36756003)(4326008)(6512007)(478600001)(2906002)(66946007)(66556008)(33656002)(66446008)(5660300002)(2616005)(110136005)(26005)(76116006)(6506007)(316002)(8676002)(86362001)(8936002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Xe6x3xterXu0OngsskNZrjikJy3R/pJw+7R2gDb2EtsMEgHE/8LGH5SXuVvqznb4VHI9btkqcrEbwmC3Oo068sMFkrb17h8EwQv4YYhg5MiB57FAQzPwBKYl2OJhGgMmiifoD53rNAQLQwXqq+o+NIcGQv8PsnFtmVoRbFgo7BA68p0SPcUHMMZEQvL6yR6z50tQMUO9anYIER//yfTuo1I4drWiHdJUNwMeam4w1TSFdaCKzlYlFyX5FJ74G7qGVeY0u1MtvA/RPtfbmbN5begjzLPYf9GspYeOOcgLaCNkwiLCZQES7qolllvqBvknghOanNt+bUCIgMQEwST9KZQ4ILzO+sWMbpriwK/2XD+FjRdh8uqEAtwCVAmQrFtCCrv8u6M3+mk3fjjapt9YKnE7QsLtd7pdaxBxYSy3QUk3P5T1+Ry/UH4NSNSoK5nxQI62qeeI1nXzxQqCkFhAl4DNKXYoEIf2vQTCF1Q8v6e7mHLbsszOWaPSp7HNz4WG7hRKZuhETD4nXrVbjFQCu+Bxu5uC8dbE5NNYEveF7EmXzr2xiH2JvKwLZ59hOAxCTefJq7Tf0LgBaDohr8xcYMY65KvJpfkrFG7g65e7PGbcP/Ijm08yzEiigb+jmtRtSNzrxZ3XvL8GEeKnVt/nExbZcWdutA6veO5ruCfF5nCKnFgdBsJGMd0WIf1UioFHWjUwXBSOEsjFEvx0ezhEyEfrD0wr5/rvTAuax92mtfwpzHcYdmEPLCdiuj77jC+kSFX33nFwWhyF1RHvepgq3rhDEX51HcCXQ/P60DGmmSpBKuHB2TZo1dniddgyHdXSujntyXyMsv2DdtHomF0hL+tg3QE4UfJy4LB7qSwkvkAkNbKgQFGnWZ1KB8o5z+VuybchvEZU/kgy3dLLYd4IRw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F140CFFA110CE448D6F816B553B0791@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TU4PR8401MB1181.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: df58aa70-9c54-45cf-3d91-08d88c865a9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 12:26:34.5619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lb/nS8O7rpRx8/K59CeRF2PEqV3UaOO9MMaC1XN+i3t8jwMcbHUxbL/MoBwI6/i8t/KaY0aISRhd7vwhirGe4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB1135
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_08:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190093
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

VHNvLA0KDQpUaGlzIHNpdHVhdGlvbiBoaXQgd2l0aCBtb2Rlcm4gaGRkIHdpdGggNGsgYmxvY2sg
c2l6ZSBhbmQgZTJpbWFnZSBjaGFuZ2VkIHRvIHVzZSBESVJFQ1QgSU8gaW5zdGVhZCBvZiBidWZm
ZXJlZC4NCmUyZnNwcm9ncyB0cmllcyB0byByZWFkIGEgc3VwZXIgbG9jayBvbiBvZmZzZXQgMWsg
YW5kIGl0IGNhdXNlZCB0byBzZXQgRlMgYmxvY2sgc2l6ZSB0byAxayBhbmQgc2Vjb25kIGJsb2Nr
IHJlYWRpbmcuDQoobWFueSBvdGhlciBwbGFjZXMgZXhpc3QsIGJ1dCBpdCBzaW1wbGVzdCkuDQo+
Pg0KICAgICAgICBpZiAoc3VwZXJibG9jaykgew0KICAgICAgICAgICAgICAgIGlmICghYmxvY2tf
c2l6ZSkgew0KICAgICAgICAgICAgICAgICAgICAgICAgcmV0dmFsID0gRVhUMl9FVF9JTlZBTElE
X0FSR1VNRU5UOw0KICAgICAgICAgICAgICAgICAgICAgICAgZ290byBjbGVhbnVwOw0KICAgICAg
ICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICBpb19jaGFubmVsX3NldF9ibGtzaXplKGZzLT5p
bywgYmxvY2tfc2l6ZSk7DQogICAgICAgICAgICAgICAgZ3JvdXBfYmxvY2sgPSBzdXBlcmJsb2Nr
Ow0KICAgICAgICAgICAgICAgIGZzLT5vcmlnX3N1cGVyID0gMDsNCiAgICAgICAgfSBlbHNlIHsN
CiAgICAgICAgICAgICAgICBpb19jaGFubmVsX3NldF9ibGtzaXplKGZzLT5pbywgU1VQRVJCTE9D
S19PRkZTRVQpOyA8PDw8PCB0aGlzIGlzIHByb2JsZW0NCiAgICAgICAgICAgICAgICBzdXBlcmJs
b2NrID0gMTsNCiAgICAgICAgICAgICAgICBncm91cF9ibG9jayA9IDA7DQogICAgICAgICAgICAg
ICAgcmV0dmFsID0gZXh0MmZzX2dldF9tZW0oU1VQRVJCTE9DS19TSVpFLCAmZnMtPm9yaWdfc3Vw
ZXIpOw0KICAgICAgICAgICAgICAgIGlmIChyZXR2YWwpDQogICAgICAgICAgICAgICAgICAgICAg
ICBnb3RvIGNsZWFudXA7DQogICAgICAgIH0NCiAgICAgICAgcmV0dmFsID0gaW9fY2hhbm5lbF9y
ZWFkX2Jsayhmcy0+aW8sIHN1cGVyYmxvY2ssIC1TVVBFUkJMT0NLX1NJWkUsDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZnMtPnN1cGVyKTsNCj4+DQpJdCBjYXVzZWQgZXJy
b3JzIGxpa2UNCiMgZTJpbWFnZSAtUSAvZGV2L21kNjUgL3RtcC9ub2RlMDVfaW1hZ2Vfb3V0DQpl
MmltYWdlIDEuNDUuNi5jcjEgKDE0LUF1Zy0yMDIwKQ0KZTJpbWFnZTogQXR0ZW1wdCB0byByZWFk
IGJsb2NrIGZyb20gZmlsZXN5c3RlbSByZXN1bHRlZCBpbiBzaG9ydCByZWFkIHdoaWxlIHRyeWlu
ZyB0byBvcGVuIC9kZXYvbWQ2NQ0KQ291bGRu4oCZdCBmaW5kIHZhbGlkIGZpbGVzeXN0ZW0gc3Vw
ZXJibG9jay4NCg0KSXQgbG9va3MgbGlrZSBJIGRvbid0IGZpcnN0IHBlcnNvbiB0byBmb3VuZCBh
IGJ1ZywgYXMgc29tZW9uZSB3YXMgYWRkIA0KDQpBbGV4DQoNCu+7v09uIDE3LzExLzIwMjAsIDIy
OjE5LCAiVGhlb2RvcmUgWS4gVHMnbyIgPHR5dHNvQG1pdC5lZHU+IHdyb3RlOg0KDQogICAgT24g
VHVlLCBOb3YgMTcsIDIwMjAgYXQgMDY6MzA6MTFQTSArMDMwMCwg0JHQu9Cw0LPQvtC00LDRgNC1
0L3QutC+INCQ0YDRgtGR0Lwgd3JvdGU6DQogICAgPiBIZWxsbywNCiAgICA+IA0KICAgID4gQW55
IHRob3VnaHRzIGFib3V0IHRoaXMgY2hhbmdlPyBUaGFua3MuDQoNCiAgICBJJ20gdHJ5aW5nIHRv
IHRoaW5rIG9mIHNpdHVhdGlvbnMgd2hlcmUgdGhpcyBjb3VsZCBhY3R1YWxseSB0cmlnZ2VyIGlu
DQogICAgcmVhbCBsaWZlLiAgVGhlIG9ubHkgb25lIEkgY2FuIHRoaW5rIG9mIGlzIGlmIGEgZmls
ZSBzeXN0ZW0gd2l0aCBhIDFrDQogICAgYmxvY2sgZmlsZSBzeXN0ZW0gaXMgbG9jYXRlZCBvbiBh
biBhbiBBZHZhbmNlZCBGb3JtYXREcml2ZSB3aXRoIGEgNGsNCiAgICBzZWN0b3Igc2l6ZS4NCg0K
ICAgIFdoYXQgd2FzIHRoZSB1c2UgY2FzZSB3aGVyZSB0aGlzIHdhcyBhY3R1YWxseSBhbiBpc3N1
ZT8NCg0KICAgICAgICAgCSAgICAgCSAgICAgIAkgICAgCSAgICAgLSBUZWQNCg0K
