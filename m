Return-Path: <linux-ext4+bounces-6189-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F241A188D5
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 01:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D377A36D5
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 00:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5B4A18;
	Wed, 22 Jan 2025 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IFWQHDHx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14184182BD
	for <linux-ext4@vger.kernel.org>; Wed, 22 Jan 2025 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737505210; cv=none; b=fgSTGjLuLQgzFIOzCPsnwc4sjDVROhGarjL+OPlaP+MlFU6WwRr0qfZdUL1o6/J5IHpjKLWt6f/EjCTlj9B6BHWq/ox3OSB8wHz+XPT3/3J33rwfR+lxO14X+lkgErnYKl/cm+QmI/wS2/CkOgs4UlVdTliPgBWZFECBmAdmuzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737505210; c=relaxed/simple;
	bh=veYEcTOlFJX9FqvV+EgIww7XOKbbiDQIfGKaEpypEdw=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hfo8YzwlhK83KOSd7YmKmHEgPtzanYu/rT4D3Iw45Hb7bgUDW++XP6beMqBqT1eakFgmgDXXTh/Q0terGPnqUaMrKt/AotOjwKp/YLyrhQWgluh4EoCsnHLipP0IggIZNW92yC/Swd3UYpSXBswFaLukQrs6kCD1mIbHIFAaaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IFWQHDHx; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737505210; x=1769041210;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=veYEcTOlFJX9FqvV+EgIww7XOKbbiDQIfGKaEpypEdw=;
  b=IFWQHDHx7DMxzD5XwqvbyQhul2+UA3HMNYZwFuX0QOahBOvImbo9Xb57
   PB3ZJoH9jvw3PW3s0EyR08odjjZ0Jr9FkY9o0+6NtAdVeF2uNrR+z+JUd
   lkVY1rtyossjI0az8K/H+uF+vmQGUswtusKMmkygKATw0KTjX/5ekt07m
   c=;
X-IronPort-AV: E=Sophos;i="6.13,223,1732579200"; 
   d="scan'208";a="460554927"
Subject: Re: Transparent compression with ext4 - especially with zstd
Thread-Topic: Transparent compression with ext4 - especially with zstd
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 00:20:08 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:8697]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.205:2525] with esmtp (Farcaster)
 id 7e82f7f0-6f58-423f-be21-3fa9192b56c3; Wed, 22 Jan 2025 00:20:07 +0000 (UTC)
X-Farcaster-Flow-ID: 7e82f7f0-6f58-423f-be21-3fa9192b56c3
Received: from EX19D023UWA003.ant.amazon.com (10.13.139.33) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 00:19:58 +0000
Received: from EX19D023UWA003.ant.amazon.com (10.13.139.33) by
 EX19D023UWA003.ant.amazon.com (10.13.139.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 22 Jan 2025 00:19:57 +0000
Received: from EX19D023UWA003.ant.amazon.com ([fe80::2d45:e73:b7a8:15de]) by
 EX19D023UWA003.ant.amazon.com ([fe80::2d45:e73:b7a8:15de%6]) with mapi id
 15.02.1258.039; Wed, 22 Jan 2025 00:19:57 +0000
From: "Kiselev, Oleg" <okiselev@amazon.com>
To: Theodore Ts'o <tytso@mit.edu>, Gerhard Wiesinger <lists@wiesinger.com>
CC: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Thread-Index: AQHban/SEIn+CLUFT0+cR1perlRakrMgnUeAgAD3iwCAAAz6gP//ydOA
Date: Wed, 22 Jan 2025 00:19:57 +0000
Message-ID: <F2121024-62F6-493E-988B-FEAD8E4A33C2@amazon.com>
References: <8cb4d855-6bd8-427f-ac8f-8cf7b91547fb@wiesinger.com>
 <20250121040125.GC3761769@mit.edu>
 <213343dc-3911-45de-8195-469da9dd1a91@wiesinger.com>
 <20250121193351.GA3820043@mit.edu>
In-Reply-To: <20250121193351.GA3820043@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <12724361A15E7246A54286E57C6195A4@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

TXlTUUwsIE1hcmlhREIgYW5kIFBvc3RncmVTUUwgZG8gdGhlaXIgb3duLCBzY2hlbWEgYW5kIHBh
Z2Utc2l6ZSBhd2FyZSBjb21wcmVzc2lvbi4gIFdoeSBub3QgbGV0IHRoZSBkYXRhYmFzZXMgZG8g
dGhpcz8gIFRoZXkgYXJlIGluIGEgYmV0dGVyIHBvc2l0aW9uIHRvIGRvIGl0IGFuZCB0cmFkZSBv
ZmYgdGhlIGNvc3RzIHdoZXJlIGFuZCB3aGVuIGl0IG1hdHRlcnMgdG8gdGhlbS4NCi0tIA0KT2xl
ZyBLaXNlbGV2IA0KDQoNCg0KDQrvu79PbiAxLzIxLzI1LCAxMTozNSwgIlRoZW9kb3JlIFRzJ28i
IDx0eXRzb0BtaXQuZWR1IDxtYWlsdG86dHl0c29AbWl0LmVkdT4+IHdyb3RlOg0KDQoNCkNBVVRJ
T046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlv
bi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBjYW4g
Y29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQoNCg0KDQoN
Cg0KDQpPbiBUdWUsIEphbiAyMSwgMjAyNSBhdCAwNzo0NzoyNFBNICswMTAwLCBHZXJoYXJkIFdp
ZXNpbmdlciB3cm90ZToNCj4gV2UgYXJlIHRhbGtpbmcgaW4gc29tZSBzY2VuYXJpb3MgYWJvdXQg
c29tZSBmYWN0b3JzIG9mIGRpc2tzcGFjZS4gRS5nLiBpbg0KPiBteSBkYXRhYmFzZSBzY2VuYXJp
byB3aXRoIFBvc3RncmVTUUwgYXJvdW5kIDg1JSBvZiBkaXNrIHNwYWNlIGNhbiBiZSBzYXZlZA0K
PiAoZS5nLiBhcm91bmQgZmFjdG9yIDcpLg0KDQoNClNvIHRoZSBwcm9ibGVtIHdpdGggdXNpbmcg
Y29tcHJlc3Npb24gd2l0aCBkYXRhYmFzZXMgaXMgdGhhdCB0aGV5IG5lZWQNCnRvIGJlIGFibGUg
dG8gZG8gcmFuZG9tIHdyaXRlcyBpbnRvIHRoZSBtaWRkbGUgb2YgYSBmaWxlLiBTbyB0aGF0DQpt
ZWFucyB5b3UgbmVlZCB0byB1c2UgdHJpY2tzIHN1Y2ggYXMgd3JpdGluZyBpbnRvIGNsdXN0ZXJz
LCB0eXBpY2FsbHkNCjMyayBvciA2NGsuIFdoYXQgdGhpcyBtZWFucyBpcyB0aGF0IGEgc2luZ2xl
IDRrIHJhbmRvbSB3cml0ZSBnZXRzDQphbXBsaWZpZWQgaW50byBhIDMyayBvciA2NGsgd3JpdGUu
DQoNCg0KPiBJbiBjbG91ZCB1c2FnZSBzY2VuYXJpb3MgeW91IGNhbiBlYXNpbHkgcmVkdWNlIHRo
YXQgYW1vdW50IG9mIGFsbG9jYXRlZA0KPiBkaXNrc3BhY2UgYnkgYXJvdW5kIGEgZmFjdG9yIDcg
YW5kIHJlZHVjZSBjb3N0IHRoZXJlZm9yZS4NCg0KDQpJZiB5b3UgYXJlIHJ1bm5pbmcgdGhpcyBv
biBhIGNsb3VkIHBsYXRmb3JtLCB3aGVyZSB5b3UgYXJlIGxpbWl0ZWQgKG9uDQpHQ0UpIG9yIGNo
YXJnZWQgKG9uIEFXUykgYnkgSU9QUyBhbmQgdGhyb3VnaHB1dCwgdGhpcyBjYW4gYmUgYQ0KcGVy
Zm9ybWFuY2UgYm90dGxlbmVjayAob3IgY29zdCB5b3UgZXh0cmEpLiBBdCB0aGUgbWluaW11bSB0
aGUgZXh0cmENCkkvTyB0aHJvdWdocHV0IHdpbGwgdmVyeSBsaWtlbHkgc2hvdyB1cCBvbiB2YXJp
b3VzIHBlcmZvcm1hbmNlDQpiZW5jaG1hcmtzLg0KDQoNCldvcnNlLCB1c2luZyBhIHRyYW5zcGFy
ZW50IGNvbXByZXNzaW9uIGJyZWFrcyB0aGUgQUNJRCBwcm9wZXJ0aWVzIG9mDQp0aGUgZGF0YWJh
c2UuIElmIHlvdSBjcmFzaCBvciBoYXZlIGEgcG93ZXIgZmFpbHVyZSB3aGlsZSByZXdyaXRpbmcN
CnRoZSA2NGsgY29tcHJlc3Npb24gY2x1c3RlciwgYWxsIG9yIHBhcnQgb2YgdGhhdCA2NGsgY29t
cHJlc3Npb24NCmNsdXN0ZXIgY2FuIGJlIGNvcnJ1cHRlZC4gQW5kIGlmIHlvdXIgY3VzdG9tZXJz
IGNhcmUgYWJvdXQgKHRoZWlyKQ0KZGF0YSBpbnRlZ3JpdHksIHRoZSBmYWN0IHRoYXQgeW91IGNo
ZWFwZWQgb3V0IG9uIGRpc2sgc3BhY2UgbWlnaHQgbm90DQpiZSBzb21ldGhpbmcgdGhhdCB3b3Vs
ZCBpbXByZXNzIHRoZW0gdGVycmlibHkuDQoNCg0KVGhlIHNob3J0IHZlcnNpb24gaXMgdGhhdCB0
cmFuc3BhcmVudCBjb21wcmVzc2lvbiBpcyBub3QgZnJlZSwgZXZlbiBpZg0KeW91IGlnbm9yZSB0
aGUgU1dFIGRldmVsb3BtZW50IGNvc3RzIG9mIGltcGxlbWVudGluZyBzdWNoIGEgZmVhdHVyZSwN
CmFuZCB0aGVuIGdldHRpbmcgdGhhdCBmZWF0dXJlIHRvIGJlIGZpdCBmb3IgdXNlIGluIGFuIGVu
dGVycHJpc2UgdXNlDQpjYXNlLiBObyBtYXR0ZXIgd2hhdCBmaWxlIHN5c3RlbSB5b3UgbWlnaHQg
d2FudCB0byB1c2UsIEkgKnN0cm9uZ2x5Kg0Kc3VnZ2VzdCB0aGF0IHlvdSBnZXQgYSBwb3dlciBm
YWlsIHJhY2sgYW5kIHRyeSBwdXR0aW5nIHRoZSB3aG9sZSBzdGFjaw0Kb24gc2FpZCBwb3dlciBm
YWlsIHJhY2ssIGFuZCB0cnkgZHJvcHBpbmcgcG93ZXIgd2hpbGUgcnVubmluZyBhIHN0cmVzcw0K
dGVzdCAtLS0gb3ZlciwgYW5kIG92ZXIsIGFuZCBvdmVyIGFnYWluLiBXaGF0IHlvdSBtaWdodCBm
aW5kIHdvdWxkDQpzdXJwcmlzZSB5b3UuDQoNCg0KPiBUaGUgdGVjaG5pY2FsIHRvcGljIGlzIHRo
YXQgSU1ITyBubyBzdGFibGUgYW5kIHByYWN0aWNhbCB1c2FibGUgTGludXgNCj4gZmlsZXN5c3Rl
bSB3aGljaCBpcyBpbmNsdWRlZCBpbiB0aGUgZGVmYXVsdCBrZXJuZWwgZXhpc3RzLg0KPiAtIFpG
UyB3b3JrcyBidXQgaXMgbm90IGluY2x1ZGVkIGluIHRoZSBkZWZhdWx0IGtlcm5lbA0KPiAtIEJU
UkZTIGhhcyBzdGFiaWxpdHkgYW5kIHJlcGFpciBpc3N1ZXMgKHNlZSBtYWlsaW5nIGxpc3RzKSBh
bmQgYnVncyB3aXRoDQo+IGNvbXByZXNzaW9uIChkb2VzIG5vdCBjb21wcmVzcyBvbiB0aGUgZmx5
IGluIHNvbWUgc2NlbmFyaW9zKQ0KPiAtIGJjYWNoZWZzIGlzIGV4cGVyaW1lbnRhbA0KDQoNCldo
ZW4gSSBzdGFydGVkIHdvcmsgYXQgR29vZ2xlIDE1IHllYXJzIGFnbyB0byBkZXBsb3kgZXh0NCBp
bnRvDQpwcm9kdWN0aW9uLCB3ZSBkaWQgcHJlY2lzZWx5IHRoaXMsIGFuZCBhcyB3ZWxsIGFzIGRl
cGxveWluZyB0byBhIHNtYWxsDQpwZXJjZW50YWdlIG9mIEdvb2dsZSdzIHRlc3QgZmxlZXQgdG8g
ZG8gQTpCIGNvbXBhcmlzb25zIGJlZm9yZSB3ZQ0KZGVwbG95ZWQgdG8gdGhlIGVudGlyZSBwcm9k
dWN0aW9uIGZsZWV0Lg0KDQoNCldoZXRoZXIgb3Igbm90IGl0IGlzICJwcmFjdGljYWwiIGFuZCAi
dXNhYmxlIiBkZXBlbmRzIG9uIHlvdXINCmRlZmluaXRpb24sIEkgZ3Vlc3MsIGJ1dCBmcm9tIG15
IHBlcnNwZWN0aXZlICJzdGFibGUiIGFuZCAibm90IGxvc2luZw0KdXNlcnMnIGRhdGEiIGlzIGpv
YiAjMS4NCg0KDQpCdXQgaGV5LCBpZiBpdCdzIHdvcnRoIHNvIG11Y2ggdG8geW91LCBJIHN1Z2dl
c3QgeW91IGNvc3Qgb3V0IHdoYXQgaXQNCndvdWxkIGNvc3QgdG8gYWN0dWFsbHkgaW1wbGVtZW50
IHRoZSBmZWF0dXJlcyB0aGF0IHlvdSBzbyBtdWNoIHdhbnQsDQpvciBob3cgbXVjaCBpdCB3b3Vs
ZCBjb3N0IHRvIG1ha2UgdGhlIG1vcmUgY29tcGxleCBmaWxlIHN5c3RlbXMgdG8gYmUNCnN0YWJs
ZSBmb3IgcHJvZHVjdGlvbiB1c2UuIFlvdSBtaWdodCBkZWNpZGUgdGhhdCBwYXlpbmcgdGhlIGV4
dHJhDQpzdG9yYWdlIGNvc3RzIGlzIHdheSBjaGVhcGVyIHRoYW4gc29mdHdhcmUgZW5naW5lZXJp
bmcgaW52ZXN0bWVudA0KY29zdHMgaW52b2x2ZWQuIEF0IEdvb2dsZSwgYW5kIHdoZW4gSSB3YXMg
YXQgSUJNIGJlZm9yZSB0aGF0LCB3ZSB3ZXJlDQphbHdheXMgc3VwZXIgZGlzY2lwbGluZWQgYWJv
dXQgdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgdGhlIFJPSSBjb3N0cyBvZg0Kc29tZSBwYXJ0aWN1bGFy
IHByb2plY3QgYW5kIG5vdCBqdXN0IGRvaW5nIGl0IGJlY2F1c2UgaXQgd2FzICJjb29sIi4NCg0K
DQpUaGVyZSdzIGEgZmFtb3VzIHN0b3J5IGFib3V0IGhvdyB0aGUgZW5naW5lZXJzIHdvcmtpbmcg
b24gWkZTIGRpZG4ndA0KYXNrIGZvciBtYW5hZ2VtZW50J3MgcGVybWlzc2lvbiBvciBpbnB1dCBm
cm9tIHRoZSBzYWxlcyB0ZWFtIGJlZm9yZQ0KdGhleSBzdGFydGVkLiBTb3VuZHMgZ3JlYXQsIGFu
ZCB0aGVyZSB3YXMgc29tZSBjb29sIHRlY2hub2xvZ3kgdGhlcmUNCmluIFpGUyAtLS0gYnV0IG5v
dGUgdGhhdCBTdW4gaGFkIHRvIHB1dCB0aGUgY29tcGFueSB1cCBmb3Igc2FsZQ0KYmVjYXVzZSB0
aGV5IHdlcmUgbG9zaW5nIG1vbmV5Li4uDQoNCg0KQ2hlZXJzLA0KDQoNCi0gVGVkDQoNCg0KUC5T
LiBOb3RlOiB1c2luZyBhIGNvbXByZXNzaW9uIGNsdXN0ZXIgaXMgdGhlIG9ubHkgcmVhbCB3YXkg
dG8NCnN1cHBvcnQgdHJhbnNwYXJlbnQgY29tcHJlc3Npb24gaWYgeW91IGFyZSB1c2luZyBhbiB1
cGRhdGUtaW4tcGxhY2UNCmZpbGUgc3lzdGVtIGxpa2UgZXh0NCBvciB4ZnMuIChBbmQgdGhhdCBp
cyB3aGF0IHdhcyBjb3ZlcmQgYnkgdGhlDQpTdGFjIHBhdGVudHMgdGhhdCBJIG1lbnRpb25lZC4p
DQoNCg0KSWYgeW91IGFyZSB1c2luZyBhIGxvZy1zdHJ1Y3RlZCBmaWxlIHN5c3RlbSwgc3VjaCBh
cyBaRlMsIHRoZW4geW91IGNhbg0Kc2ltcGx5IHJld3JpdGUgdGhlIGNvbXByZXNzaW9uIGNsdXN0
ZXIgKmFuZCogdXBkYXRlIHRoZSBmaWxlIHN5c3RlbQ0KbWV0YWRhdGEgdG8gcG9pbnQgYXQgdGhl
IG5ldyBjb21wcmVzc2lvbiBjbHVzdGVyIC0tLSBidXQgdGhlbiB0aGUNCmdhcmJhZ2UgY29sbGVj
dGlvbiBjb3N0cywgYW5kIHRoZSBmaWxlIHN5c3RlbSBtZXRhZGF0YSB1cGRhdGUgY29zdHMNCmZv
ciBlYWNoIGRhdGFiYXNlIGNvbW1pdCBhcmUgKmh1Z2UqLCBhbmQgdGhlIEkvTyB0aHJvdWdocHV0
IGhpdCBpcw0KZXZlbiBoaWdoZXIuIFNvIG11Y2ggc28gdGhhdCBaRlMgcmVjb21tZW5kcyB0aGF0
IHlvdSB0dXJuIG9mZiB0aGUNCmxvZy1zdHJ1Y3R1cmVkIHdyaXRlIGFuZCBkbyB1cGRhdGUtaW4t
cGxhY2UgaWYgeW91IHdhbnQgdG8gdXNlIGENCmRhdGFiYXNlIG9uIFpGUy4gQnV0IEknbSBwcmV0
dHkgc3VyZSB0aGF0IHRoaXMgZGlzYWJsZXMgdHJhbnNwYXJlbnQNCmNvbXByZXNzaW9uIGlmIHlv
dSBhcmUgdXNpbmcgdXBkYXRlLWluLXBsYWNlLiBUTlNUQUFGTC4NCg0KDQoNCg0KDQo=

