Return-Path: <linux-ext4+bounces-10237-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4A2B833CD
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Sep 2025 08:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB62625DB5
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Sep 2025 06:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BB32E371F;
	Thu, 18 Sep 2025 06:58:59 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from good-out-07.clustermail.de (good-out-07.clustermail.de [212.223.35.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60B32E2296
	for <linux-ext4@vger.kernel.org>; Thu, 18 Sep 2025 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.223.35.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758178739; cv=none; b=BR8dt4d3lw/syBNtnZJqzHXf+kAa9PPNv72lfq6wKuD2amnsTL9ii7vtH+f8YGNkWftzNiyQ7H3iwpPKAFoJ2HqLROZEC0J4Pl9k4CjCrxzUWfhjvR3gsVjWg1mFPpXbVSYDN4H/Q2MP1FG9RL6JSBL1NjmA1vPH4b2+pKtBIPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758178739; c=relaxed/simple;
	bh=pHAoGJlyh9lmJu+IhLLed0wcIOF1z+6yGYCa2YKwzgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mvqZRyT4iuScXdOBThh2QpjwTQdeQ3mKXTjsffP7eSCoYbKt8w7K1zZ0aQKWfh9+K5/dxr8lguDPZTk5fzcJ0VqUAltuEpklHzcx9WA4VpOQYhWTjbbfNCxZPpFEzIdhOHhj6lWIND9T/9EkUHtW622EOGm48gHeu74D36M9+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gin.de; spf=pass smtp.mailfrom=gin.de; arc=none smtp.client-ip=212.223.35.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gin.de
Received: from [10.0.0.7] (helo=frontend.clustermail.de)
	by smtpout-02.clustermail.de with esmtp (Exim 4.96)
	(envelope-from <rafael.richter.extern@gin.de>)
	id 1uz7cN-00EHgD-0B;
	Thu, 18 Sep 2025 07:55:44 +0200
Received: from [62.157.191.2] (helo=GIN-GR-EXCH01.gin-domain.local)
	by frontend.clustermail.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rafael.richter.extern@gin.de>)
	id 1uz7cO-005i1U-0W;
	Thu, 18 Sep 2025 07:55:44 +0200
Received: from GIN-GR-EXCH01.gin-domain.local (10.160.128.6) by
 GIN-GR-EXCH01.gin-domain.local (10.160.128.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Sep 2025 07:55:45 +0200
Received: from GIN-GR-EXCH01.gin-domain.local ([fe80::e5fc:2fc4:ac69:9303]) by
 GIN-GR-EXCH01.gin-domain.local ([fe80::e5fc:2fc4:ac69:9303%10]) with mapi id
 15.02.1748.010; Thu, 18 Sep 2025 07:55:45 +0200
From: "Richter, Rafael" <rafael.richter.extern@gin.de>
To: Jan Kara <jack@suse.cz>
CC: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: =?utf-8?B?QVc6IGV4dDQ6IHNsb3cgdW5tb3VudCB3aXRoIGxhcmdlIGNsZWFuIHBhZ2Ug?=
 =?utf-8?B?Y2FjaGU7IGlzIGZzZnJlZXpl4oaSdW1vdW50IHJlY29tbWVuZGVkPw==?=
Thread-Topic: =?utf-8?B?ZXh0NDogc2xvdyB1bm1vdW50IHdpdGggbGFyZ2UgY2xlYW4gcGFnZSBjYWNo?=
 =?utf-8?B?ZTsgaXMgZnNmcmVlemXihpJ1bW91bnQgcmVjb21tZW5kZWQ/?=
Thread-Index: AQHcI/BK6ZMeAt0WPEaCLFkCkm5WYbSXbnqAgAEKuio=
Date: Thu, 18 Sep 2025 05:55:45 +0000
Message-ID: <b76d3334a0b14a709ef3c3c197f5ddf5@gin.de>
References: <5008ea1dfc7a49babd670e94ce5dbda7@gin.de>,<db7ikfrvqkz6ovmpsaahkwozdizeq34ev6nhnxaldwlhbklx7x@vxl5e6hu2c6e>
In-Reply-To: <db7ikfrvqkz6ovmpsaahkwozdizeq34ev6nhnxaldwlhbklx7x@vxl5e6hu2c6e>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2952B005506D7462
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkhDQoNCj4gWWVzLiBUaGlzIGlzIGJlY2F1c2Ugd2l0aCB0aGlzIGtlcm5lbCB2ZXJzaW9uIFhG
UyB1c2VzIGxhcmdlIGZvbGlvcyAodXB0bw0KPiAyTUIgaW4gc2l6ZSkgd2hpbGUgZXh0NCB1c2Vz
IG9ubHkgNGsgZm9saW9zIGZvciB0aGUgcGFnZSBjYWNoZS4gQW5kDQo+IGV2aWN0aW5nIHRoYXQg
bWFueSBmb2xpb3MgaW4gZXh0NCB0YWtlcyB0aW1lLiBMYXJnZSBmb2xpbyBzdXBwb3J0IGhhcyBi
ZWVuDQo+IGFkZGVkIHRvIGV4dDQgcmVjZW50bHkgKDYuMTY/KSBzbyB3aXRoIHRoYXQgeW91IHNo
b3VsZCBzZWUgc2ltaWxhciB1bW91bnQNCj4gdGltZXMgYWdhaW4uDQpUaGFuayB5b3UgZm9yIHRo
aXMgdmFsdWFibGUgaW5mb3JtYXRpb24uIEkgd2lsbCBnaXZlIGl0IGEgdHJ5Lg0KDQoNClZvbjog
SmFuIEthcmEgPGphY2tAc3VzZS5jej4NCkdlc2VuZGV0OiBNaXR0d29jaCwgMTcuIFNlcHRlbWJl
ciAyMDI1IDE3OjU4DQpBbjogUmljaHRlciwgUmFmYWVsDQpDYzogbGludXgtZXh0NEB2Z2VyLmtl
cm5lbC5vcmcNCkJldHJlZmY6IFJlOiBleHQ0OiBzbG93IHVubW91bnQgd2l0aCBsYXJnZSBjbGVh
biBwYWdlIGNhY2hlOyBpcyBmc2ZyZWV6ZeKGknVtb3VudCByZWNvbW1lbmRlZD8NCsKgICAgDQpD
QVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6
YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
cmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0KSGkh
DQoNCk9uIEZyaSAxMi0wOS0yNSAxNDoyMDoxMywgUmljaHRlciwgUmFmYWVsIHdyb3RlOg0KPiB3
ZSBjb25zaXN0ZW50bHkgc2VlIHNsb3cgdW5tb3VudHMgKH424oCTOHMpIG9uIGV4dDQgYWZ0ZXIg
aGVhdnkgYnVmZmVyZWQgd3JpdGVzDQo+IChlLmcuLCBkZCB+MzAgR2lCKSB0aGF0IGdyb3cgdGhl
IHBhZ2UgY2FjaGUuIFNhbWUgdGVzdCBvbiBYRlMgdW5tb3VudHMgPDFzIG9uDQo+IHRoZSBzYW1l
IGhhcmR3YXJlLCBidXQgd2UgbXVzdCBzdGF5IG9uIGV4dDQuDQo+DQo+IEVudjoNCj7CoMKgIC0g
S2VybmVsOiA2LjYuMzYgKFlvY3RvLWJhc2VkKQ0KPsKgwqAgLSBEZXZpY2U6IFNTRCB2aWEgbWRy
YWlkICgvZGV2L21kMHAxKQ0KPsKgwqAgLSBNb3VudDogZXh0NCBvbiAvbW50L2Rpc2sgKGRlZmF1
bHRzKQ0KPg0KPiBSZXBybzoNCj7CoMKgIGRkIGlmPS9kZXYvemVybyBvZj0vbW50L2Rpc2svYmln
LmJpbiBicz0xTSBjb3VudD0zMDcyMCBzdGF0dXM9cHJvZ3Jlc3MNCj7CoMKgIHN5bmMgLWYgL21u
dC9kaXNrDQo+wqDCoCB0aW1lIHVtb3VudCAvbW50L2Rpc2vCoMKgwqDCoMKgICMgZXh0NDogfjbi
gJM4cw0KDQpZZXMuIFRoaXMgaXMgYmVjYXVzZSB3aXRoIHRoaXMga2VybmVsIHZlcnNpb24gWEZT
IHVzZXMgbGFyZ2UgZm9saW9zICh1cHRvDQoyTUIgaW4gc2l6ZSkgd2hpbGUgZXh0NCB1c2VzIG9u
bHkgNGsgZm9saW9zIGZvciB0aGUgcGFnZSBjYWNoZS4gQW5kDQpldmljdGluZyB0aGF0IG1hbnkg
Zm9saW9zIGluIGV4dDQgdGFrZXMgdGltZS4gTGFyZ2UgZm9saW8gc3VwcG9ydCBoYXMgYmVlbg0K
YWRkZWQgdG8gZXh0NCByZWNlbnRseSAoNi4xNj8pIHNvIHdpdGggdGhhdCB5b3Ugc2hvdWxkIHNl
ZSBzaW1pbGFyIHVtb3VudA0KdGltZXMgYWdhaW4uDQoNCj4gT2JzZXJ2YXRpb25zOg0KPsKgwqAg
LSBEaXJ0eS9Xcml0ZWJhY2sgYXJlIH4wIGJlZm9yZSB1bm1vdW50Lg0KPsKgwqAgLSBgZnNmcmVl
emUgLWYgL21udC9kaXNrYCBpbW1lZGlhdGVseSBiZWZvcmUgYHVtb3VudGAgbWFrZXMgdW5tb3Vu
dCB2ZXJ5IGZhc3QuDQo+wqDCoCAtIGBtb3VudCAtbyByZW1vdW50LHJvYCBiZWZvcmUgYHVtb3Vu
dGAgZG9lcyBOT1QgaW1wcm92ZSB1bm1vdW50IHRpbWUuDQoNCldlbGwsIHRoaXMgaXMgZGVmaW5p
dGVseSBub3QgcmVjb21tZW5kZWQuIGZzZnJlZXplIC1mIHdpbGwgYWNxdWlyZQ0Kc3VwZXJibG9j
ayByZWZlcmVuY2Ugd2hpY2ggbWVhbnMgdGhhdCB0aGUgZmlsZXN5c3RlbSBhY3R1YWxseSBzdGF5
cyBtb3VudGVkDQppbiB0aGUgYmFja2dyb3VuZCBhZnRlciB1bW91bnQgdW50aWwgeW91IHVuZnJl
ZXplIGl0IChmb3Igd2hpY2ggeW91IG5lZWQgdG8NCm1vdW50IGl0IGFnYWluIDspKS4gVGhhdCdz
IGEgYml0IG9mIGEgY2F0Y2ggd2l0aCBmc2ZyZWV6ZS4NCg0KwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEhvbnphDQoN
Ci0tDQpKYW4gS2FyYSA8amFja0BzdXNlLmNvbT4NClNVU0UgTGFicywgQ1INCg0KDQogICAg

