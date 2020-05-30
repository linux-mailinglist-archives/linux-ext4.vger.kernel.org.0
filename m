Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8397E1E8DEF
	for <lists+linux-ext4@lfdr.de>; Sat, 30 May 2020 07:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgE3FBn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 May 2020 01:01:43 -0400
Received: from mail-bn8nam12on2079.outbound.protection.outlook.com ([40.107.237.79]:44513
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbgE3FBn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 30 May 2020 01:01:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aafafpokit/19/cWNHreJH4wzn22TyiJULLKZgH4KB7y9uznYM2mUieJtbjTVA7CxcuZSgBYXC6Fgus8CgF9o/aGo1gnqBaG+AfbJOZxh8bUyw9ftdOp3XrNgigBLoU3SN3ou+zAC+AY8hnDKuQdpUjqDNcG4MEL1SY1YpPBD3E5mpplXtZ0rx5C9k2otsLGuaQgyxTCh5xRNWOjyTHTUb54Vgpt2AWc0PcjutL8AfqjYZlyIIs3+0R+HUqFvR6ibpvRMwnWYuUxMTFiwoSSLWobep3JeFsXDvCPCJW2N6+/yUSSyPsF1PcDqYzHw49oCylm8OAVd+IjtU/vaOwQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fbqkmXyqi0fuCaFF05ccoqVs5JdP3W73rSGRx4ay7E=;
 b=kd/z6fnNk1ZCpT9tKTWDahJTOB7VIkCjNTdye01aeLI1X7m2Q794WmZLhiWpo5QkovVyPFBsrC29M/7mrqRv/ejfVF/+mfMMEij9I0CcL43rSXtNUfK1QIXyqFEZuJH1YYi26BBmp2XOLAcjhqys0dd9lshOfDNfFjxeHLugxg2zuOo1fzA8s6ROCwdShhJlD3Qb8QOtpoBscDDw/6+5CXgvOWhUGsu9sQdUTS2+J5rHXBP1BT4uSz02NfHjJHDx9HXU6uq4aVvkK0Qcq52RE4XROVHo6gW4geT4Uh+6OxXDk3Q+CCTKyx5qdRbFCOIIKzWaJmEtfEMiU5Aj71Me8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fbqkmXyqi0fuCaFF05ccoqVs5JdP3W73rSGRx4ay7E=;
 b=xF4HVgbmZa+9Y0KMWH4eO0s+0TG3qDwedYWDn0pCyntAdiqtuBSYFmEG2hhmtVeW5rEdtrhVDQmbUfPlWvaAhQfvGEpCdDWU+A1I/Bt6IXUVcTop8K/UlF4DXR0oHG9Cbn3AAqMj0pdMqLChyLmQcmUkP/+kC44zVagHjQG2NzE=
Received: from DM6PR19MB2441.namprd19.prod.outlook.com (2603:10b6:5:18d::16)
 by DM6PR19MB4248.namprd19.prod.outlook.com (2603:10b6:5:2b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Sat, 30 May
 2020 05:01:40 +0000
Received: from DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::f1b0:78b:8c87:47c3]) by DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::f1b0:78b:8c87:47c3%4]) with mapi id 15.20.3045.018; Sat, 30 May 2020
 05:01:40 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 1/2] ext4:  mballoc - prefetching for bitmaps
Thread-Topic: [PATCH 1/2] ext4:  mballoc - prefetching for bitmaps
Thread-Index: AQHWKqCXlzEPeqf4R0Gj8cV11zoPPqi/VJEAgADU+4A=
Date:   Sat, 30 May 2020 05:01:40 +0000
Message-ID: <895DB4D0-0F00-4467-A87F-33222443615A@whamcloud.com>
References: <262A2973-9B2D-4DBE-8752-67E91D52C632@whamcloud.com>
 <90289086-E2DD-469A-86E2-3BB72CAC59E0@gmail.com>
In-Reply-To: <90289086-E2DD-469A-86E2-3BB72CAC59E0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=whamcloud.com;
x-originating-ip: [95.73.67.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42bc3988-7539-418c-5bd0-08d8045689fa
x-ms-traffictypediagnostic: DM6PR19MB4248:
x-microsoft-antispam-prvs: <DM6PR19MB4248ED1C182FD46C30A27AC6CB8C0@DM6PR19MB4248.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 041963B986
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ixZIDETOR1pILSkV8zQZcqQuKV+jPyrvPue4FwNJcg5Sd8gp3kpN7iQsrG9alfdsJeUWytuUq5gkpv3ENaImeBGev7TVyWX1uBGSIcOKWyuhjwbetjyj+Atvm0lmn8qENl46X9bZyU5ejinmmE64W476g6aKd/RYaLsF4kFVzDeAEw3i05lE6yFMV0kvPHOq3rUiP21V0BVAe15Wpj8oERUTSms+PqnkUZEqyPDHS4KoHjT1PP7HX8DkRD9XzBRk00ZNmNax7RdyUxnc1mcTtDFCM97PtMjwM2XrCvxkSEXAu7+6tOuomhpAuLrxJ99TVeolU50o7/OD1kj8EdHsXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2441.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39850400004)(366004)(136003)(346002)(376002)(6916009)(6506007)(8936002)(36756003)(8676002)(33656002)(2616005)(53546011)(86362001)(91956017)(66556008)(6486002)(478600001)(5660300002)(64756008)(71200400001)(66446008)(83380400001)(66946007)(316002)(2906002)(66476007)(76116006)(4326008)(6512007)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: pH93jWFwuQmODZ85zbOTGPRnfR53x4ZlDMKxLYK3IKG8VoKv1TiLGmpI9uc6LQ7ERY4vqi5cjzhBp28Oa8Wn5wNMffZkJJVPPOVjvNoW3pSOOOY6ag5oosyei6rWCp1cK41a8kVb0pXhkvAm66knMZqstZqtSUNTaf6gR2C+gxWZ2/gElfOHiVpHttTlQSSGLScGtidv9usV5SblHeJ7qHU2nMRsbF8pHY2ep3i3xQSS/ZkCdnnOSMx8vQEwoJInkalhItCWJradTMn3Uq57TsuaDAerMUeTApknPGXzdXhW4TzXuIo/wnr6Ra2sfj0tfYJEkqdorTYTZWT+qj465uq+MdU5Q5bbybBnzW8F1wLGfBHtqOGcBSZcXKe1h0+FGBzXoWz/RIraAsPzfrZSxOvEg1/Im5QuPjAWzl0Na3niRBnnfHx08YpvwcRL8SQgODFNmW0yJ2/3N9OcB/JaBIwAI0dCGVSAJjhCyvOKLO0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0798EB8C5D245B41B6A583C49DC0D582@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bc3988-7539-418c-5bd0-08d8045689fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2020 05:01:40.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DrmpKPaqNP5+o5LOKMgCV07qpr6vYwFMVy933HdH0Ebc/FiFcwwCovEbIlB699gHDCD3WEYgbT80omIBuRCaXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4248
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

DQpIaQ0KDQo+IE9uIDI5IE1heSAyMDIwLCBhdCAxOToxOSwg0JHQu9Cw0LPQvtC00LDRgNC10L3Q
utC+INCQ0YDRgtGR0LwgPGFydGVtLmJsYWdvZGFyZW5rb0BnbWFpbC5jb20+IHdyb3RlOg0KPiAN
Cj4gQWxzbywgd2UgaGF2ZSBlbmNvdW50ZXJlZCBkaXJlY3RvcnkgY3JlYXRpbmcgcmF0ZSBkcm9w
IHdpdGggdGhpcyAobm90IGV4YWN0IHRoaXMsIGJ1dCBMdXN0cmUgRlMgdmVyc2lvbikgcGF0Y2gu
IEZyb20gNzAtODBLIHRvIDMwLTQwSy4NCj4gRXhjbHVkaW5nIHRoaXMgcGF0Y2ggcmVzdG9yZSBy
YXRlcyB0byB0aGUgb3JpZ2luYWwgdmFsdWVzLg0KPiBJIGFtIGludmVzdGlnYXRpbmcgaXQgbm93
LiBBbGV4LCBkbyB5b3UgZXhwZWN0IHRoaXMgb3B0aW1pc2F0aW9uIGhhcyBpbXBhY3QgdG8gbmFt
ZXMgY3JlYXRpb24/DQo+IElzIHBsZW50eSBvZiBmaWxlcyBhbmQgZGlyZWN0b3JpZXMgY3JlYXRp
b24gY29ybmVyIGNhc2UgZm9yIHRoaXMgb3B0aW1pc2F0aW9uPw0KDQpOb3RpY2VkIGFzIHdlbGws
IHRoZSBsYXN0IHZlcnNpb24gcG9zdGVkIHRvIHRoZSBsaXN0IHNob3VsZCBoYXZlIHRoaXMgcHJv
YmxlbSBmaXhlZC4NCg0KPiANCj4gQ2FuIGJlIHVzZWZ1bCBnaXZpbmcgYW4gYWJpbGl0eSB0byBk
aXNhYmxlIHRoaXMgb3B0aW1pc2F0aW9uPyBBcyBvcHRpb24sIGJ5IHNldHRpbmcgc19tYl9wcmVm
ZXRjaCB0byB6ZXJvLg0KPiBOb3cgMCBhdCBzX21iX3ByZWZldGNoIGFsbG93cyB0byBza2lwIHRo
ZSBvcHRpbWlzYXRpb24gZm9yIGNyPTAgYW5kIGNyPTEuIA0KDQpzX21iX3ByZWZldGNoX2xpbWl0
PTAgY2FuIGJlIHVzZWQgdG8gZGlzYWJsZSBwcmVmZXRjaGluZz8NCg0KPj4gKwkvKiBsaW1pdCBw
cmVmZXRjaGluZyBhdCBjcj0wLCBvdGhlcndpc2UgbWJhbGxvYyBjYW4NCj4+ICsJICogc3BlbmQg
YSBsb3Qgb2YgdGltZSBsb2FkaW5nIGltcGVyZmVjdCBncm91cHMgKi8NCj4+ICsJaWYgKGFjLT5h
Y19jcml0ZXJpYSA8IDIgJiYgYWMtPmFjX3ByZWZldGNoX2lvcyA+PSBzYmktPnNfbWJfcHJlZmV0
Y2hfbGltaXQpDQo+PiArCQlyZXR1cm47DQo+IA0KPiBBIGNvbW1lbnQgYWJvdmUgc2F5cyBwcmVm
ZXRjaGluZyBpcyBsaW1pdGVkIGZvciBjcj0wIGJ1dCBjb2RlIGxpbWl0IGl0IGZvciBjcj0wIGFu
ZCBjcj0xLg0KPiBEbyB5b3UgbmVlZCBjaGFuZ2UgdGhlIGNvbW1lbnQgb3IgY29kZT8NCg0KT0sN
Cg0KPj4gKwlpZiAoc2JpLT5zX21iX3ByZWZldGNoID4gZXh0NF9nZXRfZ3JvdXBzX2NvdW50KHNi
KSkNCj4+ICsJCXNiaS0+c19tYl9wcmVmZXRjaCA9IGV4dDRfZ2V0X2dyb3Vwc19jb3VudChzYik7
DQo+PiArCS8qIG5vdyBtYW55IHJlYWwgSU9zIHRvIHByZWZldGNoIHdpdGhpbiBhIHNpbmdsZSBh
bGxvY2F0aW9uIGF0IGNyPTANCj4gDQo+IERvIHlvdSBtZWFuIOKAnGhvdyBtYW554oCdIGhlcmU/
IEF0IGNyPTAgYW5kIGNyPTE/DQoNClllcywgb2YgY291cnNlDQoNCg0KVGhhbmtzLCBBbGV4DQoN
Cg==
