Return-Path: <linux-ext4+bounces-9874-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEDEB4AAFC
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 12:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694681C61BF8
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 10:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD8831815E;
	Tue,  9 Sep 2025 10:57:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from good-out-32.clustermail.de (good-out-32.clustermail.de [212.223.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9533B256C7E
	for <linux-ext4@vger.kernel.org>; Tue,  9 Sep 2025 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.223.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415439; cv=none; b=C4LVl/0NoeCfB4quTb0EGbkj++/STZXf9LfdvNj4ocuXOZ7TrymH+uHEdZiMHS357gy9uiFRtEIFqijs4KdiOctzuvsdUuophzUxrmO4EimAEWzq+71+MyaNC7po3T5a/0VTfRZ53Ewl8pRyn8H7c+rUA3QYXRt90202SPMEBIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415439; c=relaxed/simple;
	bh=DwAwc107x5R1LYLlmGGl24FRuibhDmJRuFDkgj4m1kg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HzETcHglUsbdD8GTXGnHC54luk888FmBGbbfZo7vq5h3YYXDECX26xKB46MExFEp4jSRQoBglNeYeS5OMGj0iEP2RJgNv+4MvnFLJ/P/fVknwEnOMfM1moMpfC6zAVUxyu6DTkYwnciiLboz8X4Qqw/rAdiKVC8Kh70y1UYpfl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gin.de; spf=pass smtp.mailfrom=gin.de; arc=none smtp.client-ip=212.223.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gin.de
Received: from [10.0.0.12] (helo=frontend.clustermail.de)
	by smtpout-03.clustermail.de with esmtp (Exim 4.96)
	(envelope-from <rafael.richter.extern@gin.de>)
	id 1uvvRO-006iJC-09
	for linux-ext4@vger.kernel.org;
	Tue, 09 Sep 2025 12:19:11 +0200
Received: from [62.157.191.2] (helo=GIN-GR-EXCH01.gin-domain.local)
	by frontend.clustermail.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rafael.richter.extern@gin.de>)
	id 1uvvRP-008mdP-1F
	for linux-ext4@vger.kernel.org;
	Tue, 09 Sep 2025 12:19:11 +0200
Received: from GIN-GR-EXCH01.gin-domain.local (10.160.128.6) by
 GIN-GR-EXCH01.gin-domain.local (10.160.128.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 9 Sep 2025 12:19:11 +0200
Received: from GIN-GR-EXCH01.gin-domain.local ([fe80::e5fc:2fc4:ac69:9303]) by
 GIN-GR-EXCH01.gin-domain.local ([fe80::e5fc:2fc4:ac69:9303%10]) with mapi id
 15.02.1748.010; Tue, 9 Sep 2025 12:19:11 +0200
From: "Richter, Rafael" <rafael.richter.extern@gin.de>
To: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: =?big5?B?ZXh0NDogc2xvdyB1bm1vdW50IHdpdGggbGFyZ2UgY2xlYW4gcGFnZSBjYWNoZTsg?=
 =?big5?B?aXMgZnNmcmVlemWh93Vtb3VudCByZWNvbW1lbmRlZD8=?=
Thread-Topic: =?big5?B?ZXh0NDogc2xvdyB1bm1vdW50IHdpdGggbGFyZ2UgY2xlYW4gcGFnZSBjYWNoZTsg?=
 =?big5?B?aXMgZnNmcmVlemWh93Vtb3VudCByZWNvbW1lbmRlZD8=?=
Thread-Index: AQHcIXMaATQyhq+31kmeONlB4cUaRw==
Date: Tue, 9 Sep 2025 10:19:11 +0000
Message-ID: <af4791ab9e5e42fc929ce05e4f313a99@gin.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2952B00550627460
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksDQoNCndlIGNvbnNpc3RlbnRseSBzZWUgc2xvdyB1bm1vdW50cyAofjahVjhzKSBvbiBleHQ0
IGFmdGVyIGhlYXZ5IGJ1ZmZlcmVkIHdyaXRlcw0KKGUuZy4sIGRkIH4zMCBHaUIpIHRoYXQgZ3Jv
dyB0aGUgcGFnZSBjYWNoZS4gU2FtZSB0ZXN0IG9uIFhGUyB1bm1vdW50cyA8MXMgb24NCnRoZSBz
YW1lIGhhcmR3YXJlLCBidXQgd2UgbXVzdCBzdGF5IG9uIGV4dDQuDQoNCkVudjoNCiAgLSBLZXJu
ZWw6IDYuNi4zNiAoWW9jdG8tYmFzZWQpDQogIC0gRGV2aWNlOiBTU0QgdmlhIG1kcmFpZCAoL2Rl
di9tZDBwMSkNCiAgLSBNb3VudDogZXh0NCBvbiAvbW50L2Rpc2sgKGRlZmF1bHRzKQ0KDQpSZXBy
bzoNCiAgZGQgaWY9L2Rldi96ZXJvIG9mPS9tbnQvZGlzay9iaWcuYmluIGJzPTFNIGNvdW50PTMw
NzIwIHN0YXR1cz1wcm9ncmVzcw0KICBzeW5jIC1mIC9tbnQvZGlzaw0KICB0aW1lIHVtb3VudCAv
bW50L2Rpc2sgICAgICAjIGV4dDQ6IH42oVY4cw0KDQpPYnNlcnZhdGlvbnM6DQogIC0gRGlydHkv
V3JpdGViYWNrIGFyZSB+MCBiZWZvcmUgdW5tb3VudC4NCiAgLSBgZnNmcmVlemUgLWYgL21udC9k
aXNrYCBpbW1lZGlhdGVseSBiZWZvcmUgYHVtb3VudGAgbWFrZXMgdW5tb3VudCB2ZXJ5IGZhc3Qu
DQogIC0gYG1vdW50IC1vIHJlbW91bnQscm9gIGJlZm9yZSBgdW1vdW50YCBkb2VzIE5PVCBpbXBy
b3ZlIHVubW91bnQgdGltZS4NCg0KUXVlc3Rpb25zOg0KICAxKSBJcyB0aGlzIHVubW91bnQgdGlt
ZSBleHBlY3RlZCBvbiBleHQ0IHdpdGggYSBsYXJnZSAqY2xlYW4qIHBhZ2UgY2FjaGU/DQogIDIp
IFdoeSBpcyBYRlMgdW5tb3VudCBtdWNoIGZhc3RlciBoZXJloVhhbnkgZXh0NC1zaWRlIHJlYXNv
bnMgb3IgcmVncmVzc2lvbnM/DQogIDMpIElzIGBmc2ZyZWV6ZSAtZmAgofcgYHVtb3VudGAgYWNj
ZXB0YWJsZS9yZWNvbW1lbmRlZCBmb3Igc2h1dGRvd24gb24gZXh0ND8NCiAgICAgQW55IGV4dDQv
VkZTIG9wdGlvbnMgb3IgcGVyLWZpbGVzeXN0ZW0gbWV0aG9kcyB0byByZWR1Y2UgdW5tb3VudCB0
aW1lPw0KDQoNCkxvb2tpbmcgZm9yd2FyZCBmb3IgYW4gYW5zd2VyIQ0KDQpUaHgsDQoNClJhZmFl
bA0K

