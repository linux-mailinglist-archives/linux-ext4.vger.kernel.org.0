Return-Path: <linux-ext4+bounces-5673-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158AB9F343A
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Dec 2024 16:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F94167685
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Dec 2024 15:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C3B143C7E;
	Mon, 16 Dec 2024 15:17:09 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAAF7A13A
	for <linux-ext4@vger.kernel.org>; Mon, 16 Dec 2024 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362229; cv=none; b=DTEX422i4ubJ9l+2Z4tgWNoRjAr6q461gc3zpHKuBHU6kZZRm1QU5JPNZbcgjUMHU3rl34Gu0Dn+3vzZNQTl1vXBMRk/3YX/W8jlImo4E4PnXO3AfyUjFU6jFhrQw/sum2mztQ4T3mar7RgCtAWl0qgXW4CfbYPh+gCkvtkIBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362229; c=relaxed/simple;
	bh=HMNrIxpzZ6eupdx0cVG31N3Nvm7VX26GA8y3Pj6j084=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=rcCm0akr6fd2Wq2EMNp6DQFc3jCA3GrtE4ntAk5FIVWIc2LVasw9SNbB5jCH+HgNNur8cGfx+ezDK4ZpKXuckn2ES9EyfUVuGvITvk0eFvLSu/xt2++P+IRBLjvEizmzPWgAWEpy++Jhcbeu6KVExrn5DNiiax8jskYMq9J/9CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-46-Sxu_wXowNmae5u19f0aMuw-1; Mon, 16 Dec 2024 15:17:05 +0000
X-MC-Unique: Sxu_wXowNmae5u19f0aMuw-1
X-Mimecast-MFC-AGG-ID: Sxu_wXowNmae5u19f0aMuw
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 16 Dec
 2024 15:16:00 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 16 Dec 2024 15:16:00 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nikolai Zhubr' <zhubr.2@gmail.com>, Theodore Ts'o <tytso@mit.edu>
CC: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jack@suse.cz"
	<jack@suse.cz>
Subject: RE: ext4 damage suspected in between 5.15.167 - 5.15.170
Thread-Topic: ext4 damage suspected in between 5.15.167 - 5.15.170
Thread-Index: AQHbTmIhPGt59L71DEGKLTcgkLT5MLLo/RPQ
Date: Mon, 16 Dec 2024 15:16:00 +0000
Message-ID: <229641a5c7f046b282c151cb1c6b9110@AcuMS.aculab.com>
References: <CALQo8TpjoV8JtuYDH_nBU5i4e-iuCQ1-NORAE8uobpDD_yYBTA@mail.gmail.com>
 <20241212191603.GA2158320@mit.edu>
 <79af4b93-63a1-da4c-2793-8843c60068f5@gmail.com>
 <20241213161230.GF1265540@mit.edu>
 <ce9055d7-7301-0abe-3609-3a4e2e7b1e5e@gmail.com>
In-Reply-To: <ce9055d7-7301-0abe-3609-3a4e2e7b1e5e@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jJPDLcBvhpsbkW6g--3U_GNQw7ZFu6ZTzOk15P_uLJU_1734362224
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

Li4uLg0KPiA+IFRoZSBsb2NhdGlvbiBvZiBibG9jayBhbGxvY2F0aW9uIGJpdG1hcHMgbmV2ZXIg
Z2V0cyBjaGFuZ2VkLCBzbyB0aGlzDQo+ID4gc29ydCBvZiB0aGluZyBvbmx5IGhhcHBlbnMgZHVl
IHRvIGhhcmR3YXJlLWluZHVjZWQgY29ycnVwdGlvbi4NCj4gDQo+IFdlbGwsIHVubGVzcyBlLmcu
IHNvbWUgbW9kaWZpZWQgc2VjdG9ycyBzdGFydCBiZWluZyBmbHVzaGVkIHRvIHJhbmRvbQ0KPiB3
cm9uZyBvZmZzZXRzLCBsaWtlIGluIFsxXSBhYm92ZSwgb3Igc29tZXRoaW5nIHNpbWlsYXIuDQoN
Ck9yIGN1dHRpbmcgdGhlIHBvd2VyIGluIHRoZSBtaWRkbGUgb2YgU1NEICd3ZWFyIGxldmVsbGlu
ZycuDQoNCkkndmUgc2VlbiBhIGNvbXBsZXRlbHkgdHJhc2hlZCBkaXNrIChzZWN0b3JzIGluIGNv
bXBsZXRlbHkgdGhlDQp3cm9uZyBwbGFjZXMpIGFmdGVyIGFuIHVuZXhwZWN0ZWQgcG93ZXIgY3V0
Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K


