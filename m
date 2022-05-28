Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEEE536BA6
	for <lists+linux-ext4@lfdr.de>; Sat, 28 May 2022 10:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiE1IaT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 May 2022 04:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiE1IaS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 May 2022 04:30:18 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B207183B1
        for <linux-ext4@vger.kernel.org>; Sat, 28 May 2022 01:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1653726617; x=1685262617;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=A9oipOqADR7c2gmzZ/1kerIzPdgwaC6KfXgdP3Gffvo=;
  b=G4zztdbk/2pDrCTyIyNOwGbBr3QRkv9aihmPRy2sHdaja06Wh/kJEd+7
   tYcdRK1iIKj/B8OF6G3dRCgSapJCauuPV4UaPcsU8OoSOolqoarDV/bKG
   QUu7NK0jN2NlSKfZF8Ctub2l+tlEpfTWOEH33ATx13sSwYaMWo99cELV+
   0=;
X-IronPort-AV: E=Sophos;i="5.91,258,1647302400"; 
   d="scan'208";a="223335647"
Subject: Re: Does `-O bigalloc` still conflict with `delalloc`?
Thread-Topic: Does `-O bigalloc` still conflict with `delalloc`?
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-5c4a15b1.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 28 May 2022 08:30:16 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-5c4a15b1.us-west-2.amazon.com (Postfix) with ESMTPS id E1FE942638;
        Sat, 28 May 2022 08:30:15 +0000 (UTC)
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Sat, 28 May 2022 08:30:13 +0000
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13D23UWA003.ant.amazon.com (10.43.160.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Sat, 28 May 2022 08:30:13 +0000
Received: from EX13D23UWA003.ant.amazon.com ([10.43.160.194]) by
 EX13D23UWA003.ant.amazon.com ([10.43.160.194]) with mapi id 15.00.1497.036;
 Sat, 28 May 2022 08:30:13 +0000
From:   "Kiselev, Oleg" <okiselev@amazon.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Thread-Index: AQHYbLvtEANX2mjL60Khy2lzFq3rc60znICA///u+wA=
Date:   Sat, 28 May 2022 08:30:12 +0000
Message-ID: <D0FBF5B8-EC8B-4DA7-9610-6FE779485636@amazon.com>
References: <923065C9-2EFB-4F59-895E-139B4B9F9E98@amazon.com>
 <YpGJa/f3dSh2XZwb@mit.edu>
In-Reply-To: <YpGJa/f3dSh2XZwb@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.236]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E364838F7897D4194AD7987EC256B9A@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-15.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

VGhhbmsgeW91LCBUZWQhDQoNCu+7v09uIDUvMjcvMjIsIDc6MzIgUE0sICJUaGVvZG9yZSBUcydv
IiA8dHl0c29AbWl0LmVkdT4gd3JvdGU6DQoNCiAgICBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdp
bmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgY2FuIGNvbmZpcm0gdGhlIHNlbmRlciBh
bmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCg0KICAgIE9uIFNhdCwgTWF5IDIxLCAy
MDIyIGF0IDAyOjM5OjAwQU0gKzAwMDAsIEtpc2VsZXYsIE9sZWcgd3JvdGU6DQogICAgPiBUaGUg
YGV4dDQoNSlgIG1hbiBwYWdlLCBjb250YWluZWQgaW4gdGhlIG1vc3QgcmVjZW50IGUyZnNwcm9n
cyBzdGlsbCBzYXlzOg0KICAgID4NCiAgICA+ICAgICAgIFdhcm5pbmc6IFRoZSBiaWdhbGxvYyBm
ZWF0dXJlIGlzIHN0aWxsIHVuZGVyIGRldmVsb3BtZW50LCBhbmQgbWF5IG5vdCBiZSBmdWxseSAg
c3VwcG9ydGVkDQogICAgPiAgICAgICAgICAgICAgIHdpdGggeW91ciBrZXJuZWwgb3IgbWF5IGhh
dmUgdmFyaW91cyBidWdzLiAgUGxlYXNlIHNlZSB0aGUgd2ViIHBhZ2UgaHR0cDovL2V4dDQud2lr
aS5rZXLigJANCiAgICA+ICAgICAgICAgICAgICAgbmVsLm9yZy9pbmRleC5waHAvQmlnYWxsb2Mg
Zm9yIGRldGFpbHMuICBNYXkgY2xhc2ggd2l0aCBkZWxheWVkIGFsbG9jYXRpb24gKHNlZSAgbm9k
ZWxhbOKAkA0KICAgID4gICAgICAgICAgICAgICBsb2MgbW91bnQgb3B0aW9uKS4NCiAgICA+DQog
ICAgPiBJcyBhIGJhZCBpbnRlcmFjdGlvbiB3aXRoIGBkZWxhbGxvY2Agc3RpbGwgYW4gaXNzdWUg
YW5kIHNob3VsZCB3ZSBiZSB1c2luZyB0aGUgYG5vZGVsYWxsb2NgIG9wdGlvbj8NCg0KICAgIEFw
b2xvZ2llcyBmb3Igbm90IGdldHRpbmcgYmFjayB0byB5b3UgcmlnaHQgYXdheS4gIEkgd2FudGVk
IHRvIGNoZWNrDQogICAgd2l0aCBzb21lIGZvbGtzIG9uIHRoZSBleHQ0IHRlYW0sIGFuZCBpbiBm
YWN0IHdlIHRhbGtlZCBhYm91dCBpdCBhdA0KICAgIHRoaXMgd2VlaydzIGV4dDQgdmlkZW8gY2hh
dC4gIEVyaWMgV2hpdG5leSB3b3JrZWQgb24gZml4aW5nIGJpZ2FsbG9jDQogICAgYW5kIGRlbGFs
bG9jLCBhbmQgaXQgbG9va3MgbGlrZSB0aGUgbGFzdCBvZiB0aGUgZml4ZXMgbGFuZGVkIGluIExp
bnV4DQogICAgdmVyc2lvbiA1LjQgaW4gMjAxOS4gIFNvIHRoYXQgd2FybmluZyBpbiB0aGUgZXh0
NCg1KSBtYW4gcGFnZSBpcw0KICAgIGRlZmluaXRlbHkgb3V0IG9mIGRhdGUuDQoNCiAgICBJJ2xs
IHJlbW92ZSBpdCBpbiB0aGUgbmV4dCByZWxlYXNlIG9mIGUyZnNwcm9ncy4NCg0KICAgIENoZWVy
cywNCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtIFRlZA0K
DQo=
