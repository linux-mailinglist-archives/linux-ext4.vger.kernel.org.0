Return-Path: <linux-ext4+bounces-9948-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7698B5525B
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Sep 2025 16:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987491640C9
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Sep 2025 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2960030E0D8;
	Fri, 12 Sep 2025 14:52:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from good-out-29.clustermail.de (good-out-29.clustermail.de [212.223.161.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA95230DEDA
	for <linux-ext4@vger.kernel.org>; Fri, 12 Sep 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.223.161.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688765; cv=none; b=myMkSQTPurbXcU8lhs6Wo6BpLzcmc0HMUFj14OYNnTtJeor8dKiZaKOYPADzFP5K4BU1LR6DG/A40i0WA3i9Lw9o1tO6fByQoeV5F1xRHjn4+0ILxO1R1ejV9eXq8znnc/HLNs69KZb4kxQPkaQmAsj6ZItpCjRYY84Fl+sxJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688765; c=relaxed/simple;
	bh=q0vIjj5D0zdAbFcfxS0p9y4I5FAvWWhKFG5KQOnjzYE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hrd3+m6N63aPKWVIgo6/tEyKO6p0o6mMs9ycUqEeNlGksvzdcZJBxa1mCDTV73p5mVVcRpsvHvRlv1oiSE3e+ngVpb6slPA12pkixfnrW/FXFWHjt4YUAy4q6JbEY+gHEnPOxOPtvIRvUPk4LMp4uqbQ/Q7UrtQOdJoeAFDyaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gin.de; spf=pass smtp.mailfrom=gin.de; arc=none smtp.client-ip=212.223.161.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gin.de
Received: from [10.0.0.10] (helo=frontend.clustermail.de)
	by smtpout-02.clustermail.de with esmtp (Exim 4.96)
	(envelope-from <rafael.richter.extern@gin.de>)
	id 1ux4dH-009V4X-23
	for linux-ext4@vger.kernel.org;
	Fri, 12 Sep 2025 16:20:12 +0200
Received: from [62.157.191.2] (helo=GIN-GR-EXCH01.gin-domain.local)
	by frontend.clustermail.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rafael.richter.extern@gin.de>)
	id 1ux4dI-008yyo-2N
	for linux-ext4@vger.kernel.org;
	Fri, 12 Sep 2025 16:20:12 +0200
Received: from GIN-GR-EXCH01.gin-domain.local (10.160.128.6) by
 GIN-GR-EXCH01.gin-domain.local (10.160.128.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 12 Sep 2025 16:20:13 +0200
Received: from GIN-GR-EXCH01.gin-domain.local ([fe80::e5fc:2fc4:ac69:9303]) by
 GIN-GR-EXCH01.gin-domain.local ([fe80::e5fc:2fc4:ac69:9303%10]) with mapi id
 15.02.1748.010; Fri, 12 Sep 2025 16:20:13 +0200
From: "Richter, Rafael" <rafael.richter.extern@gin.de>
To: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: =?utf-8?B?ZXh0NDogc2xvdyB1bm1vdW50IHdpdGggbGFyZ2UgY2xlYW4gcGFnZSBjYWNo?=
 =?utf-8?B?ZTsgaXMgZnNmcmVlemXihpJ1bW91bnQgcmVjb21tZW5kZWQ/?=
Thread-Topic: =?utf-8?B?ZXh0NDogc2xvdyB1bm1vdW50IHdpdGggbGFyZ2UgY2xlYW4gcGFnZSBjYWNo?=
 =?utf-8?B?ZTsgaXMgZnNmcmVlemXihpJ1bW91bnQgcmVjb21tZW5kZWQ/?=
Thread-Index: AQHcI/BK6ZMeAt0WPEaCLFkCkm5WYQ==
Date: Fri, 12 Sep 2025 14:20:13 +0000
Message-ID: <5008ea1dfc7a49babd670e94ce5dbda7@gin.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2952B00550627062
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksDQoNCndlIGNvbnNpc3RlbnRseSBzZWUgc2xvdyB1bm1vdW50cyAofjbigJM4cykgb24gZXh0
NCBhZnRlciBoZWF2eSBidWZmZXJlZCB3cml0ZXMNCihlLmcuLCBkZCB+MzAgR2lCKSB0aGF0IGdy
b3cgdGhlIHBhZ2UgY2FjaGUuIFNhbWUgdGVzdCBvbiBYRlMgdW5tb3VudHMgPDFzIG9uDQp0aGUg
c2FtZSBoYXJkd2FyZSwgYnV0IHdlIG11c3Qgc3RheSBvbiBleHQ0Lg0KDQpFbnY6DQrCoCAtIEtl
cm5lbDogNi42LjM2IChZb2N0by1iYXNlZCkNCsKgIC0gRGV2aWNlOiBTU0QgdmlhIG1kcmFpZCAo
L2Rldi9tZDBwMSkNCsKgIC0gTW91bnQ6IGV4dDQgb24gL21udC9kaXNrIChkZWZhdWx0cykNCg0K
UmVwcm86DQrCoCBkZCBpZj0vZGV2L3plcm8gb2Y9L21udC9kaXNrL2JpZy5iaW4gYnM9MU0gY291
bnQ9MzA3MjAgc3RhdHVzPXByb2dyZXNzDQrCoCBzeW5jIC1mIC9tbnQvZGlzaw0KwqAgdGltZSB1
bW91bnQgL21udC9kaXNrwqDCoMKgwqDCoCAjIGV4dDQ6IH424oCTOHMNCg0KT2JzZXJ2YXRpb25z
Og0KwqAgLSBEaXJ0eS9Xcml0ZWJhY2sgYXJlIH4wIGJlZm9yZSB1bm1vdW50Lg0KwqAgLSBgZnNm
cmVlemUgLWYgL21udC9kaXNrYCBpbW1lZGlhdGVseSBiZWZvcmUgYHVtb3VudGAgbWFrZXMgdW5t
b3VudCB2ZXJ5IGZhc3QuDQrCoCAtIGBtb3VudCAtbyByZW1vdW50LHJvYCBiZWZvcmUgYHVtb3Vu
dGAgZG9lcyBOT1QgaW1wcm92ZSB1bm1vdW50IHRpbWUuDQoNClF1ZXN0aW9uczoNCsKgIDEpIElz
IHRoaXMgdW5tb3VudCB0aW1lIGV4cGVjdGVkIG9uIGV4dDQgd2l0aCBhIGxhcmdlICpjbGVhbiog
cGFnZSBjYWNoZT8NCsKgIDIpIFdoeSBpcyBYRlMgdW5tb3VudCBtdWNoIGZhc3RlciBoZXJl4oCU
YW55IGV4dDQtc2lkZSByZWFzb25zIG9yIHJlZ3Jlc3Npb25zPw0KwqAgMykgSXMgYGZzZnJlZXpl
IC1mYCDihpIgYHVtb3VudGAgYWNjZXB0YWJsZS9yZWNvbW1lbmRlZCBmb3Igc2h1dGRvd24gb24g
ZXh0ND8NCsKgwqDCoMKgIEFueSBleHQ0L1ZGUyBvcHRpb25zIG9yIHBlci1maWxlc3lzdGVtIG1l
dGhvZHMgdG8gcmVkdWNlIHVubW91bnQgdGltZT8NCg0KDQpMb29raW5nIGZvcndhcmQgZm9yIGFu
IGFuc3dlciENCg0KVGh4LA0KDQpSYWZhZWwNCg==

