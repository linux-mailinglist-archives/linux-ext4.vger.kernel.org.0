Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD0114528
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Dec 2019 17:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfLEQv6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Dec 2019 11:51:58 -0500
Received: from mx2.kistler.com ([91.223.79.45]:12887 "EHLO mx2.kistler.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfLEQv6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 5 Dec 2019 11:51:58 -0500
IronPort-SDR: xb8mneiJYxtbH8O3cGNVwxqlCWAzKX1d5kBnJCJEU9178+lVvOeyfn6tqEpjrcmjzMr51IONpG
 dzzGMQjl+FeQ==
X-IronPort-AV: E=Sophos;i="5.69,282,1571695200"; 
   d="scan'208";a="3979471"
Received: from kihagsepp01.int.kistler.com (HELO sl-win-seppm-1.int.kistler.com) ([192.168.52.67])
  by mx2.kistler.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2019 17:51:55 +0100
Received: from mx2.kistler.com (kihagciip02.int.kistler.com [192.168.52.58])
        by sl-win-seppm-1.int.kistler.com (Postfix) with ESMTPS
        for <linux-ext4@vger.kernel.org>; Thu,  5 Dec 2019 17:51:55 +0100 (CET)
IronPort-SDR: FiyPpvTcw7LXuLtzIbRChL4FETKeQOBmfjqoKNqmvr72rB3i1+KBzzAUsSfwfdFBNzxQ4cVMOe
 0Oytpo/kyMwA==
X-IronPort-AV: E=Sophos;i="5.69,282,1571695200"; 
   d="scan'208";a="3979470"
Received: from sw-win-exch-2.int.kistler.com ([192.168.100.96])
  by mx2.kistler.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2019 17:51:55 +0100
Received: from SW-WIN-EXCH-2.int.kistler.com (192.168.100.96) by
 SW-WIN-EXCH-2.int.kistler.com (192.168.100.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 5 Dec 2019 17:51:55 +0100
Received: from SW-WIN-EXCH-2.int.kistler.com ([fe80::ccdb:f438:cac9:d73f]) by
 SW-WIN-EXCH-2.int.kistler.com ([fe80::ccdb:f438:cac9:d73f%9]) with mapi id
 15.01.1847.003; Thu, 5 Dec 2019 17:51:55 +0100
From:   Viliam Lejcik <Viliam.Lejcik@kistler.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: RE: e2fsprogs: setting UUID with tune2fs corrupts an ext4 fs image
Thread-Topic: e2fsprogs: setting UUID with tune2fs corrupts an ext4 fs image
Thread-Index: AdWrjDgjKFIdjLi2SZakmenb1WHIog==
Date:   Thu, 5 Dec 2019 16:51:55 +0000
Message-ID: <a7dc8a59e6be4974a800b87d633807e8@kistler.com>
Accept-Language: en-US, de-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.100.89]
x-c2processedorg: 78a97207-3cfa-406d-a777-069c09c1300a
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

SGkgVGhlb2RvcmUsDQoNClRoYW5rIHlvdSBmb3IgcXVpY2sgcmVzcG9uc2UuIFlvdSBjYW4gZG93
bmxvYWQgdGhlIHNhbXBsZSBpbWFnZSBoZXJlOg0KaHR0cHM6Ly9zbWFydGZpbGUua2lzdGxlci5j
b20vbGluay9PZ2dxN0IzM0JhSS8NCg0KSXQgd2FzIHNsaWdodGx5IG1vZGlmaWVkIChJIGRlbGV0
ZWQgc29tZSBwcm9wcmlldGFyeSBzdHVmZiksIGFzIGl0IGlzIGRpZmZpY3VsdCB0byBidWlsZCBh
IHNhbXBsZSBpbWFnZSB3aGljaCBsZWFkcyB0byB0aGlzIHByb2JsZW0uIFNvIHlvdSBtYXkgZmlu
ZCB0aGUgaXNzdWUgb24gYW5vdGhlciBpbm9kZSwgYnV0IGlmIHlvdSBydW4gdGhlIGNvbW1hbmRz
IGFzIHN0YXRlZCBpbiB0aGUgcmVwb3J0LCB5b3UnbGwgYmUgYWJsZSB0byByZXByb2R1Y2UgdGhl
IGlzc3VlLCBmb3Igc3VyZS4NCg0KQlIsDQpWaWxvDQoNCg0KQ29uZmlkZW50aWFsaXR5IE5vdGlj
ZTogVGhpcyBlLW1haWwgaXMgcHJpdmlsZWdlZCBhbmQgY29uZmlkZW50aWFsIGFuZCBmb3IgdGhl
IHVzZSBvZiB0aGUgYWRkcmVzc2VlIG9ubHkuIFNob3VsZCB5b3UgaGF2ZSByZWNlaXZlZCB0aGlz
IGUtbWFpbCBpbiBlcnJvciBwbGVhc2Ugbm90aWZ5IHVzIGJ5IHJlcGx5aW5nIGRpcmVjdGx5IHRv
IHRoZSBzZW5kZXIgb3IgYnkgc2VuZGluZyBhIG1lc3NhZ2UgdG8gaW5mb0BraXN0bGVyLmNvbS4g
VW5hdXRob3Jpc2VkIGRpc3NlbWluYXRpb24sIGRpc2Nsb3N1cmUgb3IgY29weWluZyBvZiB0aGUg
Y29udGVudHMgb2YgdGhpcyBlLW1haWwsIG9yIGFueSBzaW1pbGFyIGFjdGlvbiwgaXMgcHJvaGli
aXRlZC4NCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBUaGVvZG9yZSBZLiBUcydv
IDx0eXRzb0BtaXQuZWR1Pg0KU2VudDogVGh1cnNkYXksIDUuIERlY2VtYmVyIDIwMTkgMTY6NDgN
ClRvOiBMZWpjaWsgVmlsaWFtIDxWaWxpYW0uTGVqY2lrQGtpc3RsZXIuY29tPg0KQ2M6IGxpbnV4
LWV4dDRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogZTJmc3Byb2dzOiBzZXR0aW5nIFVV
SUQgd2l0aCB0dW5lMmZzIGNvcnJ1cHRzIGFuIGV4dDQgZnMgaW1hZ2UNCg0KT24gVGh1LCBEZWMg
MDUsIDIwMTkgYXQgMTI6MzY6MzVQTSArMDAwMCwgVmlsaWFtIExlamNpayB3cm90ZToNCj4NCj4g
VGhpcyBiZWhhdmlvciBjYW4gYmUgcmVwcm9kdWNlZCBvbiBhbiBleHQ0IGZzIGltYWdlLCBzbyB0
aGVyZSdzIG5vIG5lZWQgdG8gcnVuIGl0IG9uIHRoZSBkZXZpY2UuDQoNCldoZXJlIGNhbiB3ZSBk
b3dubG9hZCBvciBvdGhlcndpc2Ugb2J0YWluIHRoZSBpbWFnZSB3aGVyZSB5b3UgYXJlIHNlZWlu
ZyB0aGUgcHJvYmxlbT8NCg0KVGhhbmtzLA0KDQotIFRlZA0KDQo=
