Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E73401005
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Sep 2021 15:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhIENiu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Sep 2021 09:38:50 -0400
Received: from azure-sdnproxy.icoremail.net ([207.46.229.174]:60296 "HELO
        azure-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S229759AbhIENiu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Sep 2021 09:38:50 -0400
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Sep 2021 09:38:49 EDT
Received: by ajax-webmail-sr0414.icoremail.net (Coremail) ; Sun, 5 Sep 2021
 21:29:45 +0800 (GMT+08:00)
X-Originating-IP: [154.207.66.65]
Date:   Sun, 5 Sep 2021 21:29:45 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6IKW5p2w6Z+s?= <20151213521@stu.xidian.edu.cn>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, security@kernel.org
Subject: Report bug to Linux ext4 file system about inode
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210401(fdb522e2)
 Copyright (c) 2002-2021 www.mailtech.cn icmhosting
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <52000f5c.6b0.17bb6268e72.Coremail.20151213521@stu.xidian.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwB3PXFKxjRhl4MJAA--.641W
X-CM-SenderInfo: xmlh3t5r0lt0o6vw3h50lgxtvqohv3gofq/1tbiAQIBClwR-kZQVw
        AAs6
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

SGksIG91ciB0ZWFtIGhhcyBmb3VuZCBhIHByb2JsZW0gaW4gZXh0NCBzeXN0ZW0gb24gTGludXgg
a2VybmVsIHY1LjEwLCBsZWFkaW5nIHRvIERvUyBhdHRhY2tzLgoKVGhlIHN0cnVjdCBpbm9kZSBj
YW4gYmUgZXhoYXVzdGVkIGJ5IG5vcm1hbCB1c2VycyBieSBjYWxsaW5nIHN5c2NhbGwgc3VjaCBh
cyBjcmVhdC4gQSBub3JtYWwgdXNlciBjYW4gcmVwZWF0ZWRseSBtYWtlIHRoZSBjcmVhdCBzeXNj
YWxscyB0byBjcmVhdCBmaWxlcyBhbmQgZXhoYXVzdCBhbGwgc3RydWN0IGlub2RlLiBBcyBhIHJl
c3VsdO+8jGFsdGhvdWdoIHRoZXJlIGlzIHN0aWxsIGEgbG90IG9mIHNwYWNlIGluIHRoZSBkaXNr
LCB0aGVyZSBhcmUgbm8gYXZhaWxhYmxlIGlub2RlcyBhbmQgYWxsIGV4dDQgZmlsZXMvZGlyZWN0
b3JpZXMgY3JlYXRpb24gb2YgYWxsIG90aGVyIHVzZXJzIHdpbGwgZmFpbC4KCkluIGZhY3QsIHdl
IHRyeSB0aGlzIGF0dGFjayBpbnNpZGUgYSBkZXByaXZpbGVnZWQgZG9ja2VyIGNvbnRhaW5lciB3
aXRob3V0IGFueSBjYXBhYmlsaXRpZXMuIFRoZSBwcm9jZXNzZXMgaW4gdGhlIGRvY2tlciBjYW4g
ZXhoYXVzdCBhbGwgc3RydWN0IGlub2RlIG9uIHRoZSBob3N0IGtlcm5lbC4gV2UgdXNlIGEgbWFj
aGluZSB3aXRoIDUwMEcgU1NEIGRpc2suIFdlIHN0YXJ0IG9uZSBwcm9jZXNzIHRvIGV4aGF1c3Qg
YWxsIHN0cnVjdCBpbm9kZS4gSW4gdG90YWwsIGFyb3VuZCAzMDQ5ODgxNiBudW1iZXIgb2Ygc3Ry
dWN0IGlub2RlIGFyZSBjb25zdW1lZCBhbmQgdGhlcmUgYXJlIG5vIGF2YWlsYWJsZSBzdHJ1Y3Qg
aW5vZGUgaW4gdGhlIGtlcm5lbC4gVGhlIGJsa2lvIGNvbnRyb2wgZ3JvdXAgY2FuIG9ubHkgbGlt
aXQgdGhlIElPUFMgb3IgSU8gYmFuZHdpZHRoLCBzbyBibGtpbyBjb250cm9sIGdyb3VwIGNhbiBu
b3QgaGVscC4gCgoKVGhlIGZvbGxvd2luZyBjb2RlIHNob3dzIGEgUG9DIHRoYXQgdGFrZXMgMzA0
OTg4MTYgbnVtYmVyIG9mIHN0cnVjdCBpbm9kZSwgd2hpbGUgdGFrZSBhbGwgc3RydWN0IGlub2Rl
IG9uIGhvc3QuIFdlIGV2YWx1YXRlIHRoZSBQb0Mgb24gaW50ZWwgaTUgQ1BVIHBoeXNpY2FsIG1h
Y2hpbmUgKyBMaW51eCBrZXJuZWwgdjUuMTAuMCArIFVidW50dSAxOC4wNCBMVFMuCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiNpbmNsdWRlPHN0ZGlvLmg+
CiNpbmNsdWRlPHN0ZGxpYi5oPgojaW5jbHVkZTx1bmlzdGQuaD4KI2luY2x1ZGU8ZmNudGwuaD4K
CgppbnQgbWFpbigpCnsKICAgIGNoYXIgbmFtZW91dFs2NF07IAogICAgaW50IGZkOyAKICAgIGZv
ciAoaW50IGkgPSAxOyA7IGkrKykgeyAKICAgICAgICAgc3ByaW50ZihuYW1lb3V0LCAidGVzdCVk
LnR4dCIsIGkpOyAKICAgICAgICAgZmQgPSBjcmVhdCgmYW1wO25hbWVvdXRbMF0sIE9fQ1JFQVQp
OyAKICAgICAgICAgY2xvc2UoZmQpOyAKICAgIH0gCiAgICBnZXRjaGFyKCk7CiAgICByZXR1cm4g
MDsKfSAKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIAog
Ckxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHJlcGx5ISAKCgoKCi0tCgoK
