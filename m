Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40161E8DE4
	for <lists+linux-ext4@lfdr.de>; Sat, 30 May 2020 06:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgE3E5n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 May 2020 00:57:43 -0400
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:33841
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbgE3E5m (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 30 May 2020 00:57:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFcn723Ht80huTqBDlwE17NEhX/CG5ZbeJ22rop1Z00w1NfVDruXYGJjP0PQvJ6UE/QbkAdWcKPQEugRh0Xyzl7+tFp2/1Hkoz+tkwQw21KgnA65xaRlaiQdE/fbRi9EwFc/cripvBCSmoSYwiOhOVakXbyaKF+B7+T6p0KUs1/t+u8eVmtE9RNsvHNXtkzb24H0HFBJeIyuEJphR/vVsl9TtKzJ+Xyk/qN6HkqF36qLzEpARLTQFyrS74EqSQkoQZnUjnCj4hMEpnwfJ+G9770waibTiul7Lr1281SyLkJ3c3rjYT4cNYZfcJWFsxcTJsWbXiIaJs0HJKTwJ9QcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQAYQyHtgwlX++HiuYZmSDXLuC8NlYgaHFTIRbVFv7w=;
 b=hA3dyZkqLqpOE0NvHl/Phq4/jCMP6PpGEKeVuw9MQaeddl6t8KxLswbFB/sW+lY8kHmf5y00DM7vJdnN601ZHWa+Cb3bIBNuZHobGD5y12Zw0Ox3cExXdaqdDhu/ywNPZ97dMFCCT+pXfsjDvwVcdh/LXT5MGIsVU2C9Zp2ODKSONFbcLUKZQTksguzWPLn5JOo4Mh62HXyf7nz+Ru9Hc48W+DoekBQLrU7Vl83BuqrJ4eFdnqcCOvhQNdFDc2JrOM41wrO5/PFtjPwobuXK3V8ILxwH4uIVFW+7/3OU8Eymdp4KkQv7XNovxK+KPhxUQQq4ZdO/h1iIJwfXikSKSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQAYQyHtgwlX++HiuYZmSDXLuC8NlYgaHFTIRbVFv7w=;
 b=kUyhJSO+r8IHKCPsq3f8/Ko8pW/yqbU9PYImdFfywnoUz68C6xlh5QsYvhNh/BCustQ73XR1pMmsAddi2LM3Vztm7XfuTfh7PHCci7imm1OLYasczy9+hWc5jYoxe0YxwvDpQvfrLhoDq9A5my6HE0fUdpHp8dmvF4eyr5QtcIA=
Received: from DM6PR19MB2441.namprd19.prod.outlook.com (20.179.107.80) by
 DM6PR19MB2473.namprd19.prod.outlook.com (20.179.104.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.21; Sat, 30 May 2020 04:57:39 +0000
Received: from DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::f1b0:78b:8c87:47c3]) by DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::f1b0:78b:8c87:47c3%4]) with mapi id 15.20.3045.018; Sat, 30 May 2020
 04:57:39 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 1/2] ext4:  mballoc - prefetching for bitmaps
Thread-Topic: [PATCH 1/2] ext4:  mballoc - prefetching for bitmaps
Thread-Index: AQHWKqCXlzEPeqf4R0Gj8cV11zoPPqi9qKUAgAJ/yAA=
Date:   Sat, 30 May 2020 04:57:39 +0000
Message-ID: <1877745A-989A-4402-A0F5-BB5B4CA37AA5@whamcloud.com>
References: <262A2973-9B2D-4DBE-8752-67E91D52C632@whamcloud.com>
 <20200528144746.GE228632@mit.edu>
In-Reply-To: <20200528144746.GE228632@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=whamcloud.com;
x-originating-ip: [95.73.67.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0727a43e-62ef-440f-1edf-08d80455fa8d
x-ms-traffictypediagnostic: DM6PR19MB2473:
x-microsoft-antispam-prvs: <DM6PR19MB24736170D494ABC7FF1073E9CB8C0@DM6PR19MB2473.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 041963B986
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AUSIBw3hKLwtudKQmJl0ik6s+cniDYeyzbZPIvDXQWAneRhKkCOiHSG+le+ub4y4QEDnnVpsLkWz6aZ8TY2h3sxEh+HXSCFcs+LKa/u7Ds9oEebLKYul1wuldsuXBkNXO6LzwTTWVV51ktih8aYmbI0O0NmMTcmra7k3FDei/TqwCf1b4JIBF3r61mlhTiI8BOoGognz46X34pbk8leiwGhi3wBwRhNqZ/cJ+dZqoOoRJIGhRWpyjYUnVdA+xTaWjfvTY6/Es2W4YDcECZw7765hhgJoPBU155wzLR8tXjbj6LU+wWVD/OcguQV5F0dU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2441.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(396003)(136003)(346002)(376002)(366004)(66446008)(478600001)(86362001)(64756008)(76116006)(186003)(66946007)(91956017)(71200400001)(6486002)(4326008)(2616005)(6916009)(66476007)(5660300002)(66556008)(8936002)(316002)(53546011)(6506007)(83380400001)(33656002)(8676002)(26005)(4744005)(2906002)(6512007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xAfiR7Vr7i+/3h/UEdaZysMoiObpG9xps929wsEB8OsEzCCQZpHYvry9iF6+OieOxBg1BJtauY6LF8cqwDwJycHuDHnlOykewIKNL9rYQtOVHE3+9chAr/BSRcjEwz6UQ8N0E3EHpmYjMcJjlUETRXd0N8jxU3ZZny/QZt2smQbSzmvg9zBXo5BpBbc3tRdz1bj3Uuc5vonekCGAMIZ6veH4qLd97K+dLvYPyRMxYV4VBANr2INcbrYwKWO7FEUDQSuxmskHkMlv1j6KPYhvOCwzlcdS31tnDzT1Tu7AD09JYnX1z5iKnzN2plSmSpeSHFJa/aK+eU4NuRlNy9MQrTPput/IHWES/j3Puw1/8/SY2ve1DPteFTp+XCS7xvM3p3e6vkeg5lzgfMswclp3GJbWcnHL1kRrpZcWJyasObWBPFhqcyfUR1OAIHMNPspex5X+YDgGDhWCIZMRPCxgBYThtrgleibHGN2RyOMb6tA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D566EAA943E28D45B1553BFF8A13F0BC@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0727a43e-62ef-440f-1edf-08d80455fa8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2020 04:57:39.3569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfDcjCjINg/vFdd8RUbxiJsiJ60B2ihlAqLYoNy+rjAnFLabgYMzvrjTWjXAQCzjHNxf0+bCNMlPoG8TKE/lpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2473
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

DQoNCj4gT24gMjggTWF5IDIwMjAsIGF0IDE3OjQ3LCBUaGVvZG9yZSBZLiBUcydvIDx0eXRzb0Bt
aXQuZWR1PiB3cm90ZToNCj4gDQo+IFdoYXQgYXJlIHlvdSB0cnlpbmcgdG8gZG8gaGVyZT8gIElm
IG5yID4gMCwgd2UgcmV0dXJuOyBpZiBuciA8IDAsIHdlDQo+IEJVRygpIC0tLSBidXQgbnIgaXMg
YW4gdW5zaWduZWQgaW50LCBzbyB3ZSBuZXZlciBjYW4gdHJpZ2dlciAtLS0gd2hpY2gNCj4gd2Fz
IHRoZSB3YXJuaW5nIHJlcG9ydGVkIGJ5IHRoZSBrYnVpbGQgdGVzdCBib3QuICBTbyB3ZSB3aWxs
IG9ubHkgZ2V0DQo+IHBhc3QgdGhpcyBwb2ludCBpZiBhY19wcmVmZXRjaCA9PSBncm91cC4gIEJ1
dCBhY19wcmVmZXRjaCBhcHBlYXJzIHRvDQo+IGJlIHRoZSBsYXN0IGdyb3VwIHRoYXQgd2UgcHJl
ZmV0Y2hlZCwgc28gaXQncyBub3QgY2xlYXIgdGhhdCB0aGUgbG9naWMNCj4gaXMgY29ycmVjdCBo
ZXJlLg0KDQpZb3XigJlyZSByaWdodCwgdGhpcyBwYXJ0IOKAnGV2b2x2ZWTigJ0gc2luY2UgdGhl
IGluaXRpYWwgdmVyc2lvbiwgYnV0IEkgZm9yZ290IHRvIG1ha2UgaXQgY2xlYXIuDQpCYXNpY2Fs
bHkgdGhpcyBzaG91bGQgYmUgcmVwbGFjZWQgd2l0aDoNCg0KSWYgKGFjLT5hY19wcmVmZXRjaCAh
PSBncm91cCkNCglyZXR1cm47DQoNCmFjLT5hY19wcmVmZXRjaCBpcyBqdXN0IGEgY3Vyc29yIGZv
ciB0aGUgY3VycmVudCBwcm9jZXNzLg0KDQpUaGFua3MsIEFsZXgNCg0K
