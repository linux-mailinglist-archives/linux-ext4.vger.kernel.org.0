Return-Path: <linux-ext4+bounces-12363-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73669CBD75C
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 12:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C1433015944
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 11:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB2932FA3F;
	Mon, 15 Dec 2025 11:11:51 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D80286D5C;
	Mon, 15 Dec 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765797111; cv=none; b=pWKcymyjD5KcRjtm+bGj+5+mDJSNt/jKcKWrVSX4VGEqO/KvzF47jR+ncITTJRTjzD/s7mjxMj+QhsdpQDMdhi7BW+RnbxSBYIVUCJUOg9bH4i77GJp2bsgOqM+Qi3dUCj/6LPQ5VY4Rrn3F9SQXrsn4uOnaDtbeCU9Edn/h5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765797111; c=relaxed/simple;
	bh=I4Fz7YefZRdtaIbXbbJc5IRUvIsPd830PYMQ8xxNt2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=H+UrwszJV8LaEKZpio582a6viJyf0Z9kJt6Ivv1dxPYKvp+y76ydGfQFxSbWITGbmFGNyEF7wYfrYtGSrEXG8giqLwsZnihCpe4w+PyJfWdFT+/s5EPKR8rfS8xz4MX4ssahfLyNQgq3LkFg50mS8R6TeT/TAtOns799pqwWweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [183.157.161.216])
	by mtasvr (Coremail) with SMTP id _____wAnJlPk7D9p4Gr2AA--.5992S3;
	Mon, 15 Dec 2025 19:11:33 +0800 (CST)
Received: from 3230100410$zju.edu.cn ( [183.157.161.216] ) by
 ajax-webmail-mail-app1 (Coremail) ; Mon, 15 Dec 2025 19:11:32 +0800
 (GMT+08:00)
Date: Mon, 15 Dec 2025 19:11:32 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5L2Z5piK6ZOW?= <3230100410@zju.edu.cn>
To: "Baokun Li" <libaokun1@huawei.com>
Cc: security@kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ext4: Fix KASAN use-after-free in ext4_find_extent
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2025 www.mailtech.cn zju.edu.cn
In-Reply-To: <19b5b9b3-5243-459b-a264-257f9c8324ec@huawei.com>
References: <2edd9a0c.3e90f.19b0314cfc8.Coremail.3230100410@zju.edu.cn>
 <19b5b9b3-5243-459b-a264-257f9c8324ec@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3c54df5e.436a9.19b21b55d21.Coremail.3230100410@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:yy_KCgBn4Nnk7D9pOa3FBA--.23577W
X-CM-SenderInfo: qtstiiiqquiio62m3hxhgxhubq/1tbiBhMBDmk-EwIh2gABsn
X-CM-DELIVERINFO: =?B?gHsd4wXKKxbFmtjJiESix3B1w3vLmOfvthuvpruYXH4olOsxqjvNQxnsdAQdqspSym
	ePmqBhvzZ47BPkVDji2p3Q2yRllDbvqbCvCVIhG5pluhnYtnEzEMpyEvXVjC5kw66yQi3X
	Um6CGqpS6udobIzt6urK8aSFEm6CruvvRj4AiPR8d6SJyfm/Y0DO2Z2Oq5wh9A==
X-Coremail-Antispam: 1Uk129KBj9xXoW7GFyUAFW7Jw1Dur4DAFWUGFX_yoWfCFbEvF
	1fZwnrJw1kAr4vqa13Aw47urs8Xws7tFyrJw1rGr4Ut3sIqa4kJFZ3GFZxuw17GFW3K3s8
	AFZ7XFn3X3WIvosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbBkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24lFcxC0VAYjxAxZF0Ew4CEw7xC0wAC
	Y4xI67k04243AVC20s07MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JwCE64xvF2IEb7IF0Fy7Yx
	BIdaVFxhVjvjDU0xZFpf9x07j5l19UUUUU=

SGksCgpJIGhhdmUgZGlzYWJsZWQgQ09ORklHX0JMS19ERVZfV1JJVEVfTU9VTlRFRCBhbmQgc3Bl
bnQgc29tZSB0aW1lIHRyeWluZyB0byB0cmlnZ2VyIHRoZSByZXBvcnRlZCBLQVNBTiBpc3N1ZXMu
IEFuZCBJIGZvdW5kIG5laXRoZXIgb2YgdGhlIHR3byBidWdzIGhhcyBiZWVuIG9ic2VydmVkIHNp
bmNlLiBJcyB0aGlzIGlzc3VlIHN0aWxsIHdvcnRoIGludmVzdGlnYXRpbmc/CgpUaGFua3MsCkhh
b2NoZW5nIFl1CgoKPiBIaSwKPiAKPiBPbiAyMDI1LTEyLTA5IDIwOjI3LCDkvZnmmIrpk5Ygd3Jv
dGU6Cj4gPiBIZWxsbywKPiA+Cj4gPgo+ID4gSSB3b3VsZCBsaWtlIHRvIHJlcG9ydCBhIHBvdGVu
dGlhbCBzZWN1cml0eSBpc3N1ZSBpbiB0aGUgTGludXgga2VybmVsIGV4dDQgZmlsZXN5c3RlbSwg
d2hpY2ggSSBmb3VuZCB1c2luZyBhIG1vZGlmaWVkIHN5emthbGxlci1iYXNlZCBrZXJuZWwgZnV6
emluZyB0b29sIHRoYXQgSSBkZXZlbG9wZWQuCj4gPgo+IEkgbm90aWNlZCB0aGF0IHlvdXIgY29u
ZmlndXJhdGlvbiBoYXMgQ09ORklHX0JMS19ERVZfV1JJVEVfTU9VTlRFRCBlbmFibGVkLgo+IAo+
IFRoaXMgc2V0dGluZyBhbGxvd3MgYmFyZSB3cml0ZXMgdG8gYW4gYWxyZWFkeSBtb3VudGVkIGV4
dDQgZmlsZXN5c3RlbSwKPiBtZWFuaW5nIGNlcnRhaW4gZXh0NCBtZXRhZGF0YSAobGlrZSBleHRl
bnQgdHJlZSBibG9ja3MpIGNhbiBiZSBtb2RpZmllZAo+IHdpdGhvdXQgdGhlIGZpbGVzeXN0ZW0g
YmVpbmcgYXdhcmUgb2YgdGhlIGNoYW5nZXMuCj4gCj4gQ291bGQgeW91IHBsZWFzZSB0cnkgZGlz
YWJsaW5nIENPTkZJR19CTEtfREVWX1dSSVRFX01PVU5URUQgYW5kIHNlZQo+IGlmIHRoZSBpc3N1
ZSBpcyBzdGlsbCByZXByb2R1Y2libGU/Cj4gCj4gCj4gQ2hlZXJzLAo+IEJhb2t1bgo=


