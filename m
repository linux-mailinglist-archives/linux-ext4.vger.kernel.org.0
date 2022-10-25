Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19A160CFD3
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Oct 2022 17:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiJYPCF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Oct 2022 11:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiJYPCE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Oct 2022 11:02:04 -0400
X-Greylist: delayed 224 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Oct 2022 08:02:03 PDT
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0FA219E910;
        Tue, 25 Oct 2022 08:02:03 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Tue, 25 Oct
 2022 22:51:35 +0800 (GMT+08:00)
X-Originating-IP: [182.148.15.254]
Date:   Tue, 25 Oct 2022 22:51:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linkinjeon@kernel.org,
        sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com
Cc:     roman.gushchin@linux.dev, akpm@linux-foundation.org,
        willy@infradead.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org
Subject:  [PATCH] ext4: replace ternary operator with min()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5036013e.4.1840fa09d42.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCnu+H491djhgQAAA--.1W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAQB2FEYxtGOgADs0
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKZnMvZXh0NC9pbmxpbmUuYzox
ODM6IFdBUk5JTkcgb3Bwb3J0dW5pdHkgZm9yIG1pbigpCmZzL2lzb2ZzL2lub2RlLmM6MTE1Mzog
V0FSTklORyBvcHBvcnR1bml0eSBmb3IgbWluKCkKZnMva3NtYmQvb3Bsb2NrLmM6ODgyOiBXQVJO
SU5HIG9wcG9ydHVuaXR5IGZvciBtaW4oKQpmcy9rc21iZC9vcGxvY2suYzo5MTY6IFdBUk5JTkcg
b3Bwb3J0dW5pdHkgZm9yIG1pbigpCmZzL2hwZnMvbmFtZS5jOjc5OiBXQVJOSU5HIG9wcG9ydHVu
aXR5IGZvciBtaW4oKQoKU2lnbmVkLW9mZi1ieTogS2FpTG9uZyBXYW5nIDx3YW5na2FpbG9uZ0Bq
YXJpLmNuPgotLS0KIGZzL2V4dDQvaW5saW5lLmMgIHwgMyArLS0KIGZzL2hwZnMvbmFtZS5jICAg
IHwgMiArLQogZnMvaXNvZnMvaW5vZGUuYyAgfCAyICstCiBmcy9rc21iZC9vcGxvY2suYyB8IDQg
KystLQogNCBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZnMvZXh0NC9pbmxpbmUuYyBiL2ZzL2V4dDQvaW5saW5lLmMKaW5kZXggYTRm
YmU4MjU2OTRiLi4xOTQ4MWYzMmRkZmMgMTAwNjQ0Ci0tLSBhL2ZzL2V4dDQvaW5saW5lLmMKKysr
IGIvZnMvZXh0NC9pbmxpbmUuYwpAQCAtMTgwLDggKzE4MCw3IEBAIHN0YXRpYyBpbnQgZXh0NF9y
ZWFkX2lubGluZV9kYXRhKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHZvaWQgKmJ1ZmZlciwKIAogCUJV
R19PTihsZW4gPiBFWFQ0X0koaW5vZGUpLT5pX2lubGluZV9zaXplKTsKIAotCWNwX2xlbiA9IGxl
biA8IEVYVDRfTUlOX0lOTElORV9EQVRBX1NJWkUgPwotCQkJbGVuIDogRVhUNF9NSU5fSU5MSU5F
X0RBVEFfU0laRTsKKwljcF9sZW4gPSBtaW4obGVuLCBFWFQ0X01JTl9JTkxJTkVfREFUQV9TSVpF
KTsKIAogCXJhd19pbm9kZSA9IGV4dDRfcmF3X2lub2RlKGlsb2MpOwogCW1lbWNweShidWZmZXIs
ICh2b2lkICopKHJhd19pbm9kZS0+aV9ibG9jayksIGNwX2xlbik7CmRpZmYgLS1naXQgYS9mcy9o
cGZzL25hbWUuYyBiL2ZzL2hwZnMvbmFtZS5jCmluZGV4IGVmN2JhNzdmMzZiOC4uY2E2MTYwYTZk
NmY5IDEwMDY0NAotLS0gYS9mcy9ocGZzL25hbWUuYworKysgYi9mcy9ocGZzL25hbWUuYwpAQCAt
NzYsNyArNzYsNyBAQCBpbnQgaHBmc19jb21wYXJlX25hbWVzKHN0cnVjdCBzdXBlcl9ibG9jayAq
cywKIAkJICAgICAgIGNvbnN0IHVuc2lnbmVkIGNoYXIgKm4xLCB1bnNpZ25lZCBsMSwKIAkJICAg
ICAgIGNvbnN0IHVuc2lnbmVkIGNoYXIgKm4yLCB1bnNpZ25lZCBsMiwgaW50IGxhc3QpCiB7Ci0J
dW5zaWduZWQgbCA9IGwxIDwgbDIgPyBsMSA6IGwyOworCXVuc2lnbmVkIGwgPSBtaW4obDEsIGwy
KTsKIAl1bnNpZ25lZCBpOwogCWlmIChsYXN0KSByZXR1cm4gLTE7CiAJZm9yIChpID0gMDsgaSA8
IGw7IGkrKykgewpkaWZmIC0tZ2l0IGEvZnMvaXNvZnMvaW5vZGUuYyBiL2ZzL2lzb2ZzL2lub2Rl
LmMKaW5kZXggZGY5ZDcwNTg4YjYwLi5lOGMxY2FkMDRiZDIgMTAwNjQ0Ci0tLSBhL2ZzL2lzb2Zz
L2lub2RlLmMKKysrIGIvZnMvaXNvZnMvaW5vZGUuYwpAQCAtMTE1MCw3ICsxMTUwLDcgQEAgc3Rh
dGljIGludCBpc29mc19nZXRfYmxvY2soc3RydWN0IGlub2RlICppbm9kZSwgc2VjdG9yX3QgaWJs
b2NrLAogCX0KIAogCXJldCA9IGlzb2ZzX2dldF9ibG9ja3MoaW5vZGUsIGlibG9jaywgJmJoX3Jl
c3VsdCwgMSk7Ci0JcmV0dXJuIHJldCA8IDAgPyByZXQgOiAwOworCXJldHVybiBtaW4ocmV0LCAw
KTsKIH0KIAogc3RhdGljIGludCBpc29mc19ibWFwKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHNlY3Rv
cl90IGJsb2NrKQpkaWZmIC0tZ2l0IGEvZnMva3NtYmQvb3Bsb2NrLmMgYi9mcy9rc21iZC9vcGxv
Y2suYwppbmRleCBkN2Q0N2I4MjQ1MWQuLjk0ZWM4ZDAyZDg3NyAxMDA2NDQKLS0tIGEvZnMva3Nt
YmQvb3Bsb2NrLmMKKysrIGIvZnMva3NtYmQvb3Bsb2NrLmMKQEAgLTg3OSw3ICs4NzksNyBAQCBz
dGF0aWMgaW50IG9wbG9ja19icmVhayhzdHJ1Y3Qgb3Bsb2NrX2luZm8gKmJya19vcGluZm8sIGlu
dCByZXFfb3BfbGV2ZWwpCiAKIAkJZXJyID0gb3Bsb2NrX2JyZWFrX3BlbmRpbmcoYnJrX29waW5m
bywgcmVxX29wX2xldmVsKTsKIAkJaWYgKGVycikKLQkJCXJldHVybiBlcnIgPCAwID8gZXJyIDog
MDsKKwkJCXJldHVybiBtaW4oZXJyLCAwKTsKIAogCQlpZiAoYnJrX29waW5mby0+b3Blbl90cnVu
YykgewogCQkJLyoKQEAgLTkxMyw3ICs5MTMsNyBAQCBzdGF0aWMgaW50IG9wbG9ja19icmVhayhz
dHJ1Y3Qgb3Bsb2NrX2luZm8gKmJya19vcGluZm8sIGludCByZXFfb3BfbGV2ZWwpCiAJfSBlbHNl
IHsKIAkJZXJyID0gb3Bsb2NrX2JyZWFrX3BlbmRpbmcoYnJrX29waW5mbywgcmVxX29wX2xldmVs
KTsKIAkJaWYgKGVycikKLQkJCXJldHVybiBlcnIgPCAwID8gZXJyIDogMDsKKwkJCXJldHVybiBt
aW4oZXJyLCAwKTsKIAogCQlpZiAoYnJrX29waW5mby0+bGV2ZWwgPT0gU01CMl9PUExPQ0tfTEVW
RUxfQkFUQ0ggfHwKIAkJICAgIGJya19vcGluZm8tPmxldmVsID09IFNNQjJfT1BMT0NLX0xFVkVM
X0VYQ0xVU0lWRSkKLS0gCjIuMjUuMQo=
