Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131874E9F68
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Mar 2022 21:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245450AbiC1TIF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Mar 2022 15:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245497AbiC1TIB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Mar 2022 15:08:01 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B18D6661D
        for <linux-ext4@vger.kernel.org>; Mon, 28 Mar 2022 12:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1648494380; x=1680030380;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=rCbjTFMpcRj13qtucn7hA6OOvks+8DuwU+qIHhyS7vY=;
  b=SdnxVgrA/EHhxURu27Fux5dnjzC9M1v81L6/7cNo3LMuuajDvLlJY1fB
   w27Va/fBkeoEAWz9M1bSfF/Ubo5libDXFQ62PJglcKRxb4Ca2NouAQ/wb
   NuKWfZ40smE9uJUYKM+ZXcja+FpA1b5XKQ+izICUWDNcSojP5crlrQka/
   4=;
X-IronPort-AV: E=Sophos;i="5.90,218,1643673600"; 
   d="scan'208";a="74646140"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1box-d-74e80b3c.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 28 Mar 2022 19:06:19 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1box-d-74e80b3c.us-east-1.amazon.com (Postfix) with ESMTPS id 78EF6982C8
        for <linux-ext4@vger.kernel.org>; Mon, 28 Mar 2022 19:06:18 +0000 (UTC)
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Mon, 28 Mar 2022 19:06:17 +0000
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13D23UWA003.ant.amazon.com (10.43.160.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Mon, 28 Mar 2022 19:06:17 +0000
Received: from EX13D23UWA003.ant.amazon.com ([10.43.160.194]) by
 EX13D23UWA003.ant.amazon.com ([10.43.160.194]) with mapi id 15.00.1497.033;
 Mon, 28 Mar 2022 19:06:17 +0000
From:   "Kiselev, Oleg" <okiselev@amazon.com>
To:     linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Resize of `-O bigalloc` filesystem uses a computation with O(n**2)
 complexity
Thread-Topic: Resize of `-O bigalloc` filesystem uses a computation with
 O(n**2) complexity
Thread-Index: AQHYQtbmSQUL74mXVEyq2+7VER15tw==
Date:   Mon, 28 Mar 2022 19:06:17 +0000
Message-ID: <AD880EB4-C72D-43BA-B06A-FB82764700BB@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.203]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C29C8BAA18CC3F49A8B351F67FE28FDB@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-12.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

V2UgYXJlIHZhbGlkYXRpbmcgdGhlIHVzZSBvZiBgLU8gYmlnYWxsb2NgIGZ1bmN0aW9uYWxpdHkg
YW5kIGhhdmUgcnVuIGludG8gcHJvYmxlbXMgd2l0aCBpdC4NCg0KVGhpcyBpc3N1ZSByZXF1aXJl
cyBhIGxhcmdlIGRldmljZSB0byByZXByb2R1Y2UuICBPbiB2ZXJ5IGxhcmdlIGZpbGVzeXN0ZW1z
IGNyZWF0ZWQgd2l0aCBgLU8gYmlnYWxsb2MgLUMgMTZrYCB3ZSBzZWUgcmVzaXplIHRha2UgcHJv
Z3Jlc3NpdmVseSBtb3JlIHRpbWUgYXMgdGhlIGZzIHNpemUgZ3Jvd3MuICBIZXJl4oCZcyB0aGUg
dGltZSBpdCB0YWtlcyB0byByZXNpemUgYSBmaWxlc3lzdGVtIGNyZWF0ZWQgd2l0aCB0aGUgZGVm
YXVsdCA0SyBibG9ja3M6DQo9PT09PT09PT09PQ0KU2l6ZSBvZiBsb2dpY2FsIHZvbHVtZSBkYmRh
dGEwMS9sdmRiZGF0YTAxIGNoYW5nZWQgZnJvbSAzNy43OSBUaUIgKDk5MDY0NzYgZXh0ZW50cykg
dG8gMzguODAgVGlCICgxMDE3MTQ5MyBleHRlbnRzKQ0KIA0KcmVhbCAgICAgMG0xMy42MDRzDQp1
c2VyICAgICAwbTAuMDEzcw0Kc3lzICAgICAgMG05LjU0OXMNCj09PT09PT09PT09PSANCnZzLiB0
aGUgdGltZSBpdCB0YWtlcyB3aXRoIDE2SyBjbHVzdGVyczoNCj09PT09PT09PT09PQ0KU2l6ZSBv
ZiBsb2dpY2FsIHZvbHVtZSBkYmRhdGEwMS9sdmRiZGF0YTAxIGNoYW5nZWQgZnJvbSAzNi45OCBU
aUIgKDk2OTQyNDUgZXh0ZW50cykgdG8gPDM4LjcxIFRpQiAoMTAxNDc0NzcgZXh0ZW50cykuDQog
DQpyZWFsICAgIDE3OG0yMi41OTBzDQp1c2VyICAgIDBtMC4wMDVzDQpzeXMgICAgIDE3OG00LjAy
N3MNCj09PT09PT09PT09PSANCldlIGhhdmUgdHJhY2tlZCB0aGlzIGRvd24gdG8gdGhlIGNvZGUg
aW4gZnMvZXh0NC9zdXBlci5jIHdoaWNoIGRvZXMgTyhudW1iZXJfb2ZfYmxvY2tfZ3JvdXBzICoq
IDIpIGl0ZXJhdGlvbnMgdGhyb3VnaCB0aGUgYWxsb2NhdGlvbiBncm91cHMgd2hpbGUgY29tcHV0
aW5nIG1ldGFkYXRhIG92ZXJoZWFkLiAgVGhlIGV4dHJhY3Rpb24gb2YgdGhlIGNvZGUgdGhhdCBz
aG93cyB0aGlzDQpgYGANCjM5MjYgaW50IGV4dDRfY2FsY3VsYXRlX292ZXJoZWFkKHN0cnVjdCBz
dXBlcl9ibG9jayAqc2IpDQozOTI3IHsNCiAgICAgICAgIFsuLi5dDQozOTUzICAgICBmb3IgKGkg
PSAwOyBpIDwgbmdyb3VwczsgaSsrKSB7DQogICAgICAgICAgICAgWy4uLl0NCjM5NTYgICAgICAg
ICBibGtzID0gY291bnRfb3ZlcmhlYWQoc2IsIGksIGJ1Zik7ICAgICAgPDw8PDwNCiAgICAgICAg
ICAgICBbLi4uXQ0KMzk2MSAgICAgfQ0KICAgICAgICAgWy4uLl0NCjM5ODQgfSANClsuLi5dDQoz
ODY1IHN0YXRpYyBpbnQgY291bnRfb3ZlcmhlYWQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgZXh0
NF9ncm91cF90IGdycCwNCjM4NTYgICAgICAgICAgY2hhciAqYnVmKQ0KMzg1NyB7DQogICAgICAg
ICBbLi4uXQ0KMzg3NCAgICAgaWYgKCFleHQ0X2hhc19mZWF0dXJlX2JpZ2FsbG9jKHNiKSkgICAg
ICAgICA8PDw8PCBub24tYmlnYWxsb2MgZXhpdHMgaGVyZSENCjM4NzUgICAgICAgICByZXR1cm4g
KGV4dDRfYmdfaGFzX3N1cGVyKHNiLCBncnApICsgZXh0NF9iZ19udW1fZ2RiKHNiLCBncnApICsN
CjM4NzYgICAgICAgICAgICAgc2JpLT5zX2l0Yl9wZXJfZ3JvdXAgKyAyKTsNCiAgICAgICAgIFsu
Li5dDQozODgxICAgICBmb3IgKGkgPSAwOyBpIDwgbmdyb3VwczsgaSsrKSB7ICAgICAgICAgICAg
IDw8PDw8DQogICAgICAgICAgICAgWy4uLl0NCjM5MTYgICAgIH0NCiAgICAgICAgWy4uLl0NCjM5
MjEgfQ0KYGBgIA0KVGhlIGNvbW1lbnQgb24gYGNvdW50X292ZXJoZWFkKClgIGNsZWFybHkgc3Rh
dGVzIHRoYXQgdGhlIGNvbW1pdHRlcnMgd2hvIHdyb3RlIHRoaXMgY29kZSBrbmV3IHRoYXQgdGhp
cyB3aWxsIGJlIGFuIG4qKjIgY29tcGxleGl0eSBjb21wdXRhdGlvbi4NCiANCldlIGFyZSBsb29r
aW5nIGZvciB3YXlzIHRvIHJlZHVjZSB0aGUgY29tcHV0YXRpb24gdGltZSwgcGVyaGFwcyBieSBz
a2lwcGluZyB0aGUgYWxyZWFkeSBleGlzdGluZyBncm91cHMsIHdob3NlIG92ZXJoZWFkIGlzIGFs
cmVhZHkgY29tcHV0ZWQsIGFuZCB3aGljaCBhcmUgdW5saWtlbHkgdG8gaGF2ZSBhbnkgb2YgdGhl
aXIgbWV0YWRhdGEgYWxsb2NhdGlvbnMgaW4gdGhlIGdyb3VwcyB3ZSBhcmUgYWRkaW5nLg0KDQo=
