Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CA2256425
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Aug 2020 04:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgH2Ccz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Aug 2020 22:32:55 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:18890 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbgH2Ccy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 28 Aug 2020 22:32:54 -0400
Received: by ajax-webmail-mail-app3 (Coremail) ; Sat, 29 Aug 2020 10:32:42
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Sat, 29 Aug 2020 10:32:42 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Jan Kara" <jack@suse.cz>
Cc:     kjlu@umn.edu, "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ext4: Fix memleak in add_new_gdb
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.12 build 20200616(0f5d8152)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <20200828092119.GE7072@quack2.suse.cz>
References: <20200827062843.10188-1-dinghao.liu@zju.edu.cn>
 <20200828092119.GE7072@quack2.suse.cz>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7a9ab18.fd42.174380f51de.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgAH0t5KvklfqjxkAw--.50524W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0EBlZdtPrBDAAvsq
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUblCS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIAIbVA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DMIAIbVA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lV2xY62AIxVAIcxkEcVAq
        07x20xvEncxIr21lV2xY6c02F40EFcxC0VAKzVAqx4xG6I80ewCS07vEYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lV2xY6cIj6I8E87Iv67AKxVWUJVW8JwCS07vEOx8S6xCaFVCjc4AY6r1j
        6r4UMIAIbVCjxxvEw4WlV2xY6xkI7II2jI8vz4vEwIxGrwCS07vE42xK82IY6x8ErcxFaV
        Av8VW8uw4UJr1UMIAIbVCF72vE77IF4wCS07vE4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lV2xY
        6I8I3I0E5I8CrVAFwI0_Jr0_Jr4lV2xY6I8I3I0E7480Y4vE14v26r106r1rMIAIbVC2zV
        AF1VAY17CE14v26r126r1DMIAIbVCI42IY6xIIjxv20xvE14v26r1j6r1xMIAIbVCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lV2xY6IIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIAIbVCI42IY6I8E87Iv67AKxVWUJVW8JwCS07vEIxAIcVC2z280aVCY1x0267AKxVWU
        JVW8JbIYCTnIWIevJa73U
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

PiBPbiBUaHUgMjctMDgtMjAgMTQ6Mjg6NDMsIERpbmdoYW8gTGl1IHdyb3RlOgo+ID4gV2hlbiBl
eHQ0X2pvdXJuYWxfZ2V0X3dyaXRlX2FjY2VzcygpIGZhaWxzLCB3ZSBzaG91bGQgcmVsZWFzZQo+
ID4gbl9ncm91cF9kZXNjLCBpbG9jLmJoLCBkaW5kIGFuZCBnZGJfYmggdG8gcHJldmVudCBtZW1s
ZWFrLgo+ID4gSXQncyB0aGUgc2FtZSB3aGVuIGV4dDRfaGFuZGxlX2RpcnR5X3N1cGVyKCkgZmFp
bHMsIGJ1dCB3ZQo+ID4gZG9uJ3QgbmVlZCB0byByZWxlYXNlIGRpbmQgaGVyZSBiZWNhdXNlIGl0
IGhhcyBiZWVuIHJlbGVhc2VkCj4gPiBiZWZvcmUuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IERp
bmdoYW8gTGl1IDxkaW5naGFvLmxpdUB6anUuZWR1LmNuPgo+IAo+IFRoYW5rcyBmb3IgdGhlIHBh
dGNoISBTb21lIGNvbW1lbnRzIGJlbG93Ogo+IAo+ID4gZGlmZiAtLWdpdCBhL2ZzL2V4dDQvcmVz
aXplLmMgYi9mcy9leHQ0L3Jlc2l6ZS5jCj4gPiBpbmRleCBhNTBiNTEyNzBlYTkuLmVmYzBhMDIy
Y2E4ZSAxMDA2NDQKPiA+IC0tLSBhL2ZzL2V4dDQvcmVzaXplLmMKPiA+ICsrKyBiL2ZzL2V4dDQv
cmVzaXplLmMKPiA+IEBAIC04NDMsOCArODQzLDEwIEBAIHN0YXRpYyBpbnQgYWRkX25ld19nZGIo
aGFuZGxlX3QgKmhhbmRsZSwgc3RydWN0IGlub2RlICppbm9kZSwKPiA+ICAKPiA+ICAJQlVGRkVS
X1RSQUNFKGRpbmQsICJnZXRfd3JpdGVfYWNjZXNzIik7Cj4gPiAgCWVyciA9IGV4dDRfam91cm5h
bF9nZXRfd3JpdGVfYWNjZXNzKGhhbmRsZSwgZGluZCk7Cj4gPiAtCWlmICh1bmxpa2VseShlcnIp
KQo+ID4gKwlpZiAodW5saWtlbHkoZXJyKSkgewo+ID4gIAkJZXh0NF9zdGRfZXJyb3Ioc2IsIGVy
cik7Cj4gPiArCQlnb3RvIGVycm91dDsKPiA+ICsJfQo+IAo+IFRoaXMgaHVuayBsb29rcyBnb29k
Lgo+IAo+ID4gQEAgLTg5OSwxMyArOTAxLDE3IEBAIHN0YXRpYyBpbnQgYWRkX25ld19nZGIoaGFu
ZGxlX3QgKmhhbmRsZSwgc3RydWN0IGlub2RlICppbm9kZSwKPiA+ICAKPiA+ICAJbGUxNl9hZGRf
Y3B1KCZlcy0+c19yZXNlcnZlZF9nZHRfYmxvY2tzLCAtMSk7Cj4gPiAgCWVyciA9IGV4dDRfaGFu
ZGxlX2RpcnR5X3N1cGVyKGhhbmRsZSwgc2IpOwo+ID4gLQlpZiAoZXJyKQo+ID4gKwlpZiAoZXJy
KSB7Cj4gPiAgCQlleHQ0X3N0ZF9lcnJvcihzYiwgZXJyKTsKPiA+ICsJCWdvdG8gZXJyc3VwZXI7
Cj4gPiArCX0KPiA+ICsKPiA+ICAJcmV0dXJuIGVycjsKPiA+ICBlcnJvdXQ6Cj4gPiArCWJyZWxz
ZShkaW5kKTsKPiA+ICtlcnJzdXBlcjoKPiAKPiBCdXQgdGhpcyBpcyBkZWZpbml0ZWx5IHdyb25n
LiBMb29rLCBuX2dyb3VwX2Rlc2MgYW5kIGdkYl9iaCBhcmUgYWxyZWFkeQo+IHJlZmVyZW5jZWQg
ZnJvbSB0aGUgc3VwZXJibG9jayBzbyB5b3UgY2Fubm90IGZyZWUgdGhlbSwgaWxvYy5iaCBoYXMg
YmVlbgo+IHJlbGVhc2VkIGluIGV4dDRfbWFya19pbG9jX2RpcnR5KCkuCj4gCgpUaGFuayB5b3Ug
Zm9yIHlvdXIgYWR2aWNlISBJdCdzIGNsZWFyIHRvIG1lIGFuZCBJIHdpbGwgZml4IHRoaXMgc29v
bi4KClJlZ2FyZHMsCkRpbmdoYW8K
