Return-Path: <linux-ext4+bounces-12385-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAEFCC8800
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 16:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F220830DE56E
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 15:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC4533C528;
	Wed, 17 Dec 2025 15:22:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B54E32E6BE;
	Wed, 17 Dec 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984954; cv=none; b=nM5//GUknSZN8RFaBBVI7PKMjPRzpFyGh15Ez1OA9Uv68KoRvgjDrM59WGqJPJhrO5THJWt0/GC5MMZstRid6f6YTCX9S74uM+nLaY5Ay/G+lF9462pnfsGyZt0J2aRlm+t247cN9ZHenw6CtMPNeF8IFtsqOcG7mO3axBo73Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984954; c=relaxed/simple;
	bh=VK+f0c/XS7BDrTG0jEC8e109fwondeXx3y9Ev0ChPvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=CvPxDWoifolWJpAEJ+RwfeCmIlSW4FE4CBgv4it2P7xj2evr79HEyme8nymvYgXnARixS7gnmhfUfqZo7+oLTTMmVYyvTXXWUuUEdvE9iwQqBiZ3fiVyX6OF4bR21uCaoKD5+YmD1r0BKDtUvsnA87RA+dCWGg8d/bnrDEs00Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [183.157.161.216])
	by mtasvr (Coremail) with SMTP id _____wDX1VKuykJpMRANAQ--.4S3;
	Wed, 17 Dec 2025 23:22:23 +0800 (CST)
Received: from 3230100410$zju.edu.cn ( [183.157.161.216] ) by
 ajax-webmail-mail-app1 (Coremail) ; Wed, 17 Dec 2025 23:22:21 +0800
 (GMT+08:00)
Date: Wed, 17 Dec 2025 23:22:21 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5L2Z5piK6ZOW?= <3230100410@zju.edu.cn>
To: "Baokun Li" <libaokun1@huawei.com>
Cc: security@kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ext4: Fix KASAN use-after-free in ext4_find_extent
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2025 www.mailtech.cn zju.edu.cn
In-Reply-To: <3f5ec6d7-d291-4b37-8914-3b4347564e98@huawei.com>
References: <2edd9a0c.3e90f.19b0314cfc8.Coremail.3230100410@zju.edu.cn>
 <19b5b9b3-5243-459b-a264-257f9c8324ec@huawei.com>
 <3c54df5e.436a9.19b21b55d21.Coremail.3230100410@zju.edu.cn>
 <3f5ec6d7-d291-4b37-8914-3b4347564e98@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2ef68a02.45e3e.19b2ce7b7a0.Coremail.3230100410@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:yy_KCgBn4NmuykJpU0vSBA--.26410W
X-CM-SenderInfo: qtstiiiqquiio62m3hxhgxhubq/1tbiAhEDDmlBtgNEFAAAsT
X-CM-DELIVERINFO: =?B?M+hsuQXKKxbFmtjJiESix3B1w3vLmOfvthuvpruYXH4olOsxqjvNQxnsdAQdqspSym
	ePmjUMbGDqeLbVYhX+DAlPD4aWNG2dsVAq9YtxXMa3+cQViV9ce404d3RLut1dFYcpZMiE
	5QXXVibnmanvPRfrXRbxmaXo7Op9yK1zj4Y9npCziBz9OGCbJLKe/8jE9fSfOg==
X-Coremail-Antispam: 1Uk129KBj9xXoW7JFWUJw43ZrWDGrWrJry8Xrc_yoWfKrg_Za
	4Fkry7Jrs5Xws29a1xAw4xGan8Gw4kZF1kXw4fX3Zxt34jqan7JFZ5KrsI9w1rGw1fG3s8
	Aa93ZFn7uw12vosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
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

SGksCgpTb3JyeSBidXQgSSBhbSBhIGJpdCBjb25mdXNlZCBieSB5b3VyIHdvcmRzLiBNeSBvcmln
aW5hbCBmdXp6IHRlc2luZyBhbHJlYWR5IGVuYWJsZWQgQ09ORklHX0JMS19ERVZfV1JJVEVfTU9V
TlRFRCBhcyBpbiBtb3N0IG1ham9yIExpbnV4IGRpc3RyaWJ1dGlvbnMuIAoKU28gZG9lcyBhIGJ1
ZyBmb3VuZCB3aGVuIENPTkZJR19CTEtfREVWX1dSSVRFX01PVU5URUQgaXMgZW5hYmxlZCBzdGls
bCBob2xkIHZhbHVlIGZvciByZXBvcnRpbmc/IFNob3VsZCBJIGVuYWJsZSBvciBkaXNhYmxlIHRo
aXMgY29uZmlndXJhdGlvbiBpbiBteSBmdXR1cmUgZnV6emluZyB3b3JrPwoKVGhhbmtzLApIYW9j
aGVuZyBZdQoKPiA+IEhpLAo+ID4KPiA+IEkgaGF2ZSBkaXNhYmxlZCBDT05GSUdfQkxLX0RFVl9X
UklURV9NT1VOVEVEIGFuZCBzcGVudCBzb21lIHRpbWUgdHJ5aW5nIHRvIHRyaWdnZXIgdGhlIHJl
cG9ydGVkIEtBU0FOIGlzc3Vlcy4gQW5kIEkgZm91bmQgbmVpdGhlciBvZiB0aGUgdHdvIGJ1Z3Mg
aGFzIGJlZW4gb2JzZXJ2ZWQgc2luY2UuIElzIHRoaXMgaXNzdWUgc3RpbGwgd29ydGggaW52ZXN0
aWdhdGluZz8KPiAKPiBUaGF0IGVzc2VudGlhbGx5IGNvbmZpcm1zIHRoZSBpc3N1ZSBpcyBjYXVz
ZWQgYnkgYnlwYXNzaW5nIHRoZQo+IGZpbGVzeXN0ZW0gdG8gd3JpdGUgZGlyZWN0bHkgdG8gdGhl
IHJhdyBkaXNrLiBUaGlzIGlzIGEga25vd24KPiBpc3N1ZSBhbmQgaXMgcXVpdGUgdHJpY2t5IHRv
IHNvbHZlLgo+IAo+IFlvdSBjYW4gd29yayBhcm91bmQgdGhpcyBzcGVjaWZpYyBjbGFzcyBvZiBp
c3N1ZXMgaW4geW91ciBmdXp6Cj4gdGVzdGluZyBieSBlbmFibGluZyBDT05GSUdfQkxLX0RFVl9X
UklURV9NT1VOVEVELiBTeXpib3QgcnVucwo+IHdpdGggdGhpcyBjb25maWd1cmF0aW9uIGVuYWJs
ZWQgYnkgZGVmYXVsdC4KPiAKPiAKPiBDaGVlcnMsCj4gQmFva3VuCg==


