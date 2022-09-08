Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4895B12AB
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 04:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIHCuv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Sep 2022 22:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIHCut (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Sep 2022 22:50:49 -0400
X-Greylist: delayed 914 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Sep 2022 19:50:48 PDT
Received: from m139.mail.163.com (m139.mail.163.com [220.181.13.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D126BFE8E
        for <linux-ext4@vger.kernel.org>; Wed,  7 Sep 2022 19:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=BgrIE
        LwpUAWsvHqQvGgm4Skx5IjPpQjhBzJbOSJJ0dc=; b=kSICEh3qr0BlqZo0ISWbw
        rpfTNKX6niY6KMoBR6IHnRaf9wpUBogFGs97YACQnHY2kYgw+rpkm6HM8F6Ge5tZ
        QD3boixMn/KOAR6X1zJCfRCTGwVd9nAO5gJ/ccFUwUFAP9KHTIaoFwDpUG47E3Ic
        J3U1Tx0pN2KE/gHrUd0Ekc=
Received: from 13667453960$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr9 (Coremail) ; Thu, 8 Sep 2022 10:34:51 +0800 (CST)
X-Originating-IP: [116.128.244.169]
Date:   Thu, 8 Sep 2022 10:34:51 +0800 (CST)
From:   "Yi Jiangshan" <13667453960@163.com>
To:     "kernel test robot" <lkp@intel.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, kbuild-all@lists.01.org,
        lczerner@redhat.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Jiangshan Yi" <yijiangshan@kylinos.cn>
Subject: Re:Re: [PATCH v3] fs/ext4: replace ternary operator with
 min()/max() and min_t()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <202208210652.VUSXxffI-lkp@intel.com>
References: <20220816011553.2912926-1-13667453960@163.com>
 <202208210652.VUSXxffI-lkp@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <78e3a115.fe4.1831af33a72.Coremail.13667453960@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: CcGowADXp17LVBljKHgqAA--.42807W
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbiVwV2+1etoNWBAgABsS
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

CkF0IDIwMjItMDgtMjEgMDY6NTA6MjQsICJrZXJuZWwgdGVzdCByb2JvdCIgPGxrcEBpbnRlbC5j
b20+IHdyb3RlOgo+SGkgSmlhbmdzaGFuLAo+Cj5UaGFuayB5b3UgZm9yIHRoZSBwYXRjaCEgUGVy
aGFwcyBzb21ldGhpbmcgdG8gaW1wcm92ZToKPgo+W2F1dG8gYnVpbGQgdGVzdCBXQVJOSU5HIG9u
IHR5dHNvLWV4dDQvZGV2XQo+W2Fsc28gYnVpbGQgdGVzdCBXQVJOSU5HIG9uIGxpbnVzL21hc3Rl
ciB2Ni4wLXJjMSBuZXh0LTIwMjIwODE5XQo+W0lmIHlvdXIgcGF0Y2ggaXMgYXBwbGllZCB0byB0
aGUgd3JvbmcgZ2l0IHRyZWUsIGtpbmRseSBkcm9wIHVzIGEgbm90ZS4KPkFuZCB3aGVuIHN1Ym1p
dHRpbmcgcGF0Y2gsIHdlIHN1Z2dlc3QgdG8gdXNlICctLWJhc2UnIGFzIGRvY3VtZW50ZWQgaW4K
Pmh0dHBzOi8vZ2l0LXNjbS5jb20vZG9jcy9naXQtZm9ybWF0LXBhdGNoI19iYXNlX3RyZWVfaW5m
b3JtYXRpb25dCj4KPnNwYXJzZSB3YXJuaW5nczogKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KQo+
Pj4gZnMvZXh0NC9zdXBlci5jOjY5MDc6MjY6IHNwYXJzZTogc3BhcnNlOiBpbmNvbXBhdGlibGUg
dHlwZXMgaW4gY29tcGFyaXNvbiBleHByZXNzaW9uIChkaWZmZXJlbnQgdHlwZSBzaXplcyk6Cj4+
PiBmcy9leHQ0L3N1cGVyLmM6NjkwNzoyNjogc3BhcnNlOiAgICB1bnNpZ25lZCBsb25nICoKPj4+
IGZzL2V4dDQvc3VwZXIuYzo2OTA3OjI2OiBzcGFyc2U6ICAgIHVuc2lnbmVkIGludCAqCj4KClRo
aXMgYnVnIGhhcyBiZWVuIGZpeGVkIGJ5IHRoZSBsYXRlc3QgcGF0Y2ihowpbUEFUQ0ggdjRdIGZz
L2V4dDQ6IHJlcGxhY2UgdGVybmFyeSBvcGVyYXRvciB3aXRoIG1pbigpL21heCgpIGFuZCBtaW5f
dCgpClVSTKO6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDgxNzAyNTkyOC42MTI4
NTEtMS0xMzY2NzQ1Mzk2MEAxNjMuY29tLwoKdGhhbmtzo6wKCkppYW5nc2hhbiBZaQoKCg==
