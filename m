Return-Path: <linux-ext4+bounces-12419-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA238CCA5A4
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 06:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9A11301F3D8
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 05:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472A7311C0C;
	Thu, 18 Dec 2025 05:43:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDFA31158A;
	Thu, 18 Dec 2025 05:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766036593; cv=none; b=ozRXsL8O9Qzg1d3aFdn274DRSsepJG2xnEYiNgHXzgzXxO5oLmQKcrDA1MKGp1WMH83LL1VbyOFRdm9t3L7+588DzaTAp17qHcbZx8GoMAg6nG6eKQ3JZfM+UNcCwctX1lCdyVamzjnMbwURQ734Rh7y/UH3zxfs2/T4Rif+NXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766036593; c=relaxed/simple;
	bh=meOCG6tIjeZMEyEPNRrcwPwXgI4gWB9KwEzLR2s8tIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=IGXt53iwuRJAHFmNwue1qXdGZxuJqQEanIJQ8f0UyVnAiEoTFQunbY8WnR7weBwTMaz8QK+1bSXPPGBJErd+7lKrcbEE8y6JgzTDIYLArTm1vkPsPQylz/sNzy7KqfvkMhMPN7lHwUTUK26oKUTnZLNVYkqBp5AnUKE2qkWeu7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [183.157.163.27])
	by mtasvr (Coremail) with SMTP id _____wD3_1dblENpkNESAQ--.66S3;
	Thu, 18 Dec 2025 13:42:52 +0800 (CST)
Received: from 3230100410$zju.edu.cn ( [183.157.163.27] ) by
 ajax-webmail-mail-app2 (Coremail) ; Thu, 18 Dec 2025 13:42:47 +0800
 (GMT+08:00)
Date: Thu, 18 Dec 2025 13:42:47 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5L2Z5piK6ZOW?= <3230100410@zju.edu.cn>
To: "Baokun Li" <libaokun1@huawei.com>
Cc: security@kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ext4: Fix KASAN use-after-free in ext4_find_extent
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2025 www.mailtech.cn zju.edu.cn
In-Reply-To: <7e3278d0-032c-447a-a4f4-0a34a09541f1@huawei.com>
References: <2edd9a0c.3e90f.19b0314cfc8.Coremail.3230100410@zju.edu.cn>
 <19b5b9b3-5243-459b-a264-257f9c8324ec@huawei.com>
 <3c54df5e.436a9.19b21b55d21.Coremail.3230100410@zju.edu.cn>
 <3f5ec6d7-d291-4b37-8914-3b4347564e98@huawei.com>
 <2ef68a02.45e3e.19b2ce7b7a0.Coremail.3230100410@zju.edu.cn>
 <7e3278d0-032c-447a-a4f4-0a34a09541f1@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4f6e165f.46d7f.19b2ffb746d.Coremail.3230100410@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:zC_KCgD3xDZXlENpWI+NBA--.14107W
X-CM-SenderInfo: qtstiiiqquiio62m3hxhgxhubq/1tbiAg8EDmlDB4Mj-QAAs3
X-CM-DELIVERINFO: =?B?FFraFQXKKxbFmtjJiESix3B1w3vLmOfvthuvpruYXH4olOsxqjvNQxnsdAQdqspSym
	ePmgJ6H52++N3BScuP4gdd0nZizMGCc65ME0/UIZAxW2/g2uoBygr1+5V/qWbJQKTt6Fnr
	xjhhNPN/1z4P1kL2vUSQERiGn7JkM7KgGDVmugiGnOABombCnAjYv83pwZhwrw==
X-Coremail-Antispam: 1Uk129KBj9xXoW7GrWxZF1fCw1DCrWxAw43urX_yoWfJrg_u3
	ySyr1DKr15uF92ga1akF4FqFsY93yDKa1UA3yft3W3GryxA3Z3Janakrna9w17Ga4rKFZ8
	G3sxAFZav342vosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
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

PiBPaCwgbXkgYXBvbG9naWVz4oCUSSBtaXN0YWtlbmx5IHdyb3RlICJlbmFibGUiIGluc3RlYWQg
b2YgImRpc2FibGUiIHdoaWNoCj4gbXVzdCBoYXZlIGJlZW4gY29uZnVzaW5nLgo+IAo+IERpc3Ry
aWJ1dGlvbnMgdHlwaWNhbGx5IGVuYWJsZSB0aGlzIGNvbmZpZyBiZWNhdXNlIHNvbWUgdXNlcnNw
YWNlIHRvb2xzCj4gc3RpbGwgcmVseSBvbiB3cml0aW5nIGRpcmVjdGx5IHRvIHRoZSByYXcgZGlz
ay4gT25jZSBhbGwgdXNlcnNwYWNlIHRvb2xzCj4gdHJhbnNpdGlvbiB0byB1c2luZyBpb2N0bHMs
IHdlIHdpbGwgYmUgYWJsZSB0byBkaXNhYmxlIGl0IGdsb2JhbGx5IG9yCj4gc3BlY2lmaWNhbGx5
IGZvciBjZXJ0YWluIGZpbGVzeXN0ZW1zIGluIGRpc3RyaWJ1dGlvbnMuCj4gCj4gSG93ZXZlciwg
ZHVyaW5nIHRlc3RpbmcsIHRoaXMgZmVhdHVyZSBpcyBvZnRlbiBkaXNhYmxlZCB0byBhdm9pZCBm
YWxzZQo+IHBvc2l0aXZlcyBieSBwcm9oaWJpdGluZyByYXcgd3JpdGVzIHRoYXQgYnlwYXNzIHRo
ZSBmaWxlc3lzdGVtLgo+IAo+IFlvdSBjYW4gZmluZCBtb3JlIGRldGFpbHMgaW4gdGhlIG9yaWdp
bmFsIHBhdGNoc2V0IGlmIHlvdSdyZSBpbnRlcmVzdGVkOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDIzMTEwMTE3MzU0Mi4yMzU5Ny0xLWphY2tAc3VzZS5jegoKClRoYW5rcyBmb3Ig
dGhlIGNsYXJpZmljYXRpb24hIFRoYXQgbWFrZXMgYSBsb3Qgb2Ygc2Vuc2UuCgpJIHdpbGwgZGlz
YWJsZSBDT05GSUdfQkxLX0RFVl9XUklURV9NT1VOVEVEIGZvciBmdXR1cmUgdGVzdGluZy4KCkJl
c3QgcmVnYXJkcywKSGFvY2hlbmcgWXUK


