Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395575E70F3
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Sep 2022 02:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiIWAzS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Sep 2022 20:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiIWAzQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Sep 2022 20:55:16 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F3578222;
        Thu, 22 Sep 2022 17:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663894517; x=1695430517;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=YgcEuKjEWfOKVyJG17iTn15cj0QAKaMPA6iEniYStng=;
  b=Obuy8krZLvurCU9RDI8ntBhdW6dsivW3+feM8sohxwcd2gPNfPWkYDEA
   fymfY4AYjAVmfQT4GO2taFa8WJC6t850IfX7rWhMu5WddUpBwfUkB9DiJ
   HzqTPFxTWKEcP0j+LIwXT4FaPbLBbBWYjGZXRP0ogRww5oul1DVdL+dCF
   M=;
X-Amazon-filename: ftest_write.sh, allow more ext4-rsv-conversion workqueue.patch
X-IronPort-AV: E=Sophos;i="5.93,337,1654560000"; 
   d="sh'?scan'208,223";a="227962107"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-828bd003.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 00:55:02 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-828bd003.us-east-1.amazon.com (Postfix) with ESMTPS id 9CAAF80E93;
        Fri, 23 Sep 2022 00:55:00 +0000 (UTC)
Received: from EX13D23UWC002.ant.amazon.com (10.43.162.22) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Fri, 23 Sep 2022 00:55:00 +0000
Received: from EX19D017UWC003.ant.amazon.com (10.13.139.227) by
 EX13D23UWC002.ant.amazon.com (10.43.162.22) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Fri, 23 Sep 2022 00:54:59 +0000
Received: from EX19D017UWC003.ant.amazon.com ([fe80::78e9:1d67:81fd:68c5]) by
 EX19D017UWC003.ant.amazon.com ([fe80::78e9:1d67:81fd:68c5%6]) with mapi id
 15.02.1118.012; Fri, 23 Sep 2022 00:54:59 +0000
From:   "Lu, Davina" <davinalu@amazon.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Kiselev, Oleg" <okiselev@amazon.com>,
        "Liu, Frank" <franklmz@amazon.com>
Subject: significant drop  fio IOPS performance on v5.10
Thread-Topic: significant drop  fio IOPS performance on v5.10
Thread-Index: AdjO5vTzPItE0he4TsCHXHwBRGK6iA==
Date:   Fri, 23 Sep 2022 00:54:59 +0000
Message-ID: <357ace228adf4e859df5e9f3f4f18b49@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.43.160.104]
Content-Type: multipart/mixed;
        boundary="_003_357ace228adf4e859df5e9f3f4f18b49amazoncom_"
MIME-Version: 1.0
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--_003_357ace228adf4e859df5e9f3f4f18b49amazoncom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkkgd2FzIHByb2ZpbGluZyB0aGUgNS4xMCBrZXJuZWwgYW5kIGNvbXBhcmluZyBp
dCB0byA0LjE0LiAgT24gYSBzeXN0ZW0gd2l0aCA2NCB2aXJ0dWFsIENQVXMgYW5kIDI1NiBHaUIg
b2YgUkFNLCBJIGFtIG9ic2VydmluZyBhIHNpZ25pZmljYW50IGRyb3AgaW4gSU8gcGVyZm9ybWFu
Y2UuIFVzaW5nIHRoZSBmb2xsb3dpbmcgRklPIHdpdGggdGhlIHNjcmlwdCAic3VkbyBmdGVzdF93
cml0ZS5zaCA8ZGV2X25hbWU+IiBpbiBhdHRhY2htZW50LCBJIHNhdyBGSU8gaW9wcyByZXN1bHQg
ZHJvcCBmcm9tIDIySyB0byBsZXNzIHRoYW4gMUsuIA0KVGhlIHNjcmlwdCBzaW1wbHkgZG9lczog
bW91bnQgYSB0aGUgRVhUNCAxNkdpQiB2b2x1bWUgd2l0aCBtYXggSU9QUyA2NDAwMEssIG1vdW50
aW5nIG9wdGlvbiBpcyAiIC1vIG5vYXRpbWUsbm9kaXJhdGltZSxkYXRhPW9yZGVyZWQiLCB0aGVu
IHJ1biBmaW8gd2l0aCAyMDQ4IGZpbyB3cmluZyB0aHJlYWQgd2l0aCAyODgwMDAwMCBmaWxlIHNp
emUgd2l0aCB7IC0tbmFtZT0xNmtiX3JhbmRfd3JpdGVfb25seV8yMDQ4X2pvYnMgLS1kaXJlY3Rv
cnk9L3Jkc2RiZGF0YTEgLS1ydz1yYW5kd3JpdGUgLS1pb2VuZ2luZT1zeW5jIC0tYnVmZmVyZWQ9
MSAtLWJzPTE2ayAtLW1heC1qb2JzPTIwNDggLS1udW1qb2JzPTIwNDggLS1ydW50aW1lPTYwIC0t
dGltZV9iYXNlZCAtLXRocmVhZCAtLWZpbGVzaXplPTI4ODAwMDAwIC0tZnN5bmM9MSAtLWdyb3Vw
X3JlcG9ydGluZyB9Lg0KDQpNeSBhbmFseXppbmcgaXMgdGhhdCB0aGUgZGVncmFkYXRpb24gaXMg
aW50cm9kdWNlIGJ5IGNvbW1pdCB7MjQ0YWRmNjQyNmVlMzFhODNmMzk3YjcwMGQ5NjRjZmYxMmEy
NDdkM30gYW5kIHRoZSBpc3N1ZSBpcyB0aGUgY29udGVudGlvbiBvbiByc3ZfY29udmVyc2lvbl93
cS4gIFRoZSBzaW1wbGVzdCBvcHRpb24gaXMgdG8gaW5jcmVhc2UgdGhlIGpvdXJuYWwgc2l6ZSwg
YnV0IHRoYXQgaW50cm9kdWNlcyBtb3JlIG9wZXJhdGlvbmFsIGNvbXBsZXhpdHkuICBBbm90aGVy
IG9wdGlvbiBpcyB0byBhZGQgdGhlIGZvbGxvd2luZyBjaGFuZ2UgaW4gYXR0YWNobWVudCAiYWxs
b3cgbW9yZSBleHQ0LXJzdi1jb252ZXJzaW9uIHdvcmtxdWV1ZS5wYXRjaCINCg0KRnJvbSAyN2Ux
YjBlMTQyNzVhMjgxYjM1MjlmNmE2MGM3YjIzYTgxMzU2NzUxIE1vbiBTZXAgMTcgMDA6MDA6MDAg
MjAwMQ0KRnJvbTogZGF2aW5hbHUgPGRhdmluYWx1QGFtYXpvbi5jb20+DQpEYXRlOiBGcmksIDIz
IFNlcCAyMDIyIDAwOjQzOjUzICswMDAwDQpTdWJqZWN0OiBbUEFUQ0hdIGFsbG93IG1vcmUgZXh0
NC1yc3YtY29udmVyc2lvbiB3b3JrcXVldWUgdG8gc3BlZWR1cCBmaW8gIHdyaXRpbmcNCi0tLQ0K
IGZzL2V4dDQvc3VwZXIuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4dDQvc3VwZXIuYyBiL2ZzL2V4dDQv
c3VwZXIuYw0KaW5kZXggYTBhZjgzM2Y3ZGE3Li42YjM0Mjk4Y2RjM2IgMTAwNjQ0DQotLS0gYS9m
cy9leHQ0L3N1cGVyLmMNCisrKyBiL2ZzL2V4dDQvc3VwZXIuYw0KQEAgLTQ5NjMsNyArNDk2Myw3
IEBAIHN0YXRpYyBpbnQgZXh0NF9maWxsX3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHZv
aWQgKmRhdGEsIGludCBzaWxlbnQpDQogICAgICAgICAqIGNvbmN1cnJlbmN5IGlzbid0IHJlYWxs
eSBuZWNlc3NhcnkuICBMaW1pdCBpdCB0byAxLg0KICAgICAgICAgKi8NCiAgICAgICAgRVhUNF9T
QihzYiktPnJzdl9jb252ZXJzaW9uX3dxID0NCi0gICAgICAgICAgICAgICBhbGxvY193b3JrcXVl
dWUoImV4dDQtcnN2LWNvbnZlcnNpb24iLCBXUV9NRU1fUkVDTEFJTSB8IFdRX1VOQk9VTkQsIDEp
Ow0KKyAgICAgICAgICAgICAgIGFsbG9jX3dvcmtxdWV1ZSgiZXh0NC1yc3YtY29udmVyc2lvbiIs
IFdRX01FTV9SRUNMQUlNIHwgV1FfVU5CT1VORCB8IF9fV1FfT1JERVJFRCwgMCk7DQogICAgICAg
IGlmICghRVhUNF9TQihzYiktPnJzdl9jb252ZXJzaW9uX3dxKSB7DQogICAgICAgICAgICAgICAg
cHJpbnRrKEtFUk5fRVJSICJFWFQ0LWZzOiBmYWlsZWQgdG8gY3JlYXRlIHdvcmtxdWV1ZVxuIik7
DQogICAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsNCg0KTXkgdGhvdWdodCBpczogSWYgdGhl
IG1heF9hY3RpdmUgaXMgMSwgaXQgbWVhbnMgdGhlICJfX1dRX09SREVSRUQiIGNvbWJpbmVkIHdp
dGggV1FfVU5CT1VORCBzZXR0aW5nLCBiYXNlZCBvbiBhbGxvY193b3JrcXVldWUoKS4gU28gSSBh
ZGRlZCBpdCAuDQpJIGFtIG5vdCBzdXJlIHNob3VsZCB3ZSBuZWVkICJfX1dRX09SREVSRUQiIG9y
IG5vdD8gd2l0aG91dCAiX19XUV9PUkRFUkVEIiBpdCBsb29rcyBhbHNvIHdvcmsgYXQgbXkgdGVz
dGJlZCwgYnV0IEkgYWRkZWQgc2luY2Ugbm90IG11Y2ggZmlvIFRQIGRpZmZlcmVuY2Ugb24gbXkg
dGVzdGJlZCByZXN1bHQgd2l0aC9vdXQgIl9fV1FfT1JERVJFRCIuDQoNCkZyb20gTXkgdW5kZXJz
dGFuZGluZyBhbmQgb2JzZXJ2YXRpb246IHdpdGggZGlvcmVhZF91bmxvY2sgYW5kIGRlbGF5X2Fs
bG9jIGJvdGggZW5hYmxlZCwgIHRoZSAgYmlvX2VuZGlvKCkgYW5kIGV4dDRfd3JpdGVwYWdlcygp
IHdpbGwgdHJpZ2dlciB0aGlzIHdvcmsgcXVldWUgdG8gZXh0NF9kb19mbHVzaF9jb21wbGV0ZWRf
SU8oKS4gTG9va3MgbGlrZSB0aGUgd29yayBxdWV1ZSBpcyBhbiBvbmUtYnktb25lIHVwZGF0aW5n
OiBhdCBFWFQ0IGV4dGVuZC5jIGlvX2VuZC0+bGlzdF92ZWMgIGxpc3Qgb25seSBoYXZlIG9uZSBp
b19lbmRfdmVjIGVhY2ggdGltZS4gU28gaWYgdGhlIEJJTyBoYXMgaGlnaCBwZXJmb3JtYW5jZSwg
YW5kIHdlIGhhdmUgb25seSBvbmUgdGhyZWFkIHRvIGRvIEVYVDQgZmx1c2ggd2lsbCBiZSBhbiBi
b3R0bGVuZWNrIGhlcmUuIFRoZSAiZXh0NC1yc3YtY29udmVyc2lvbiIgdGhpcyB3b3JrcXVldWUg
aXMgbWFpbmx5IGZvciB1cGRhdGUgdGhlIEVYVDRfSU9fRU5EX1VOV1JJVFRFTiBleHRlbmQgYmxv
Y2sob25seSBleGlzdCBvbiBkaW9yZWFkX3VubG9jayBhbmQgZGVsYXlfYWxsb2Mgb3B0aW9ucyBh
cmUgc2V0KSBhbmQgZXh0ZW5kIHN0YXR1cyAgaWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSBoZXJl
LiBBbSAgSSBjb3JyZWN0Pw0KDQpUaGlzIHdvcmtzIG9uIG15IHRlc3Qgc3lzdGVtIGFuZCBwYXNz
ZXMgeGZzdGVzdHMsIGJ1dCAgd2lsbCB0aGlzIGNhdXNlIGFueSBjb3JydXB0aW9uIG9uIGV4dDQg
ZXh0ZW5kcyBibG9ja3MgdXBkYXRlcywgbm90IGV2ZW4gc3VyZSBhYm91dCB0aGUgam91cm5hbCB0
cmFuc2FjdGlvbiB1cGRhdGVzIGVpdGhlcj8NCkNhbiB5b3UgdGVsbCBtZSB3aGF0IEkgd2lsbCBi
cmVhayBpZiB0aGlzIGNoYW5nZSBpcyBtYWRlPw0KDQpUaGFua3MNCkRhdmluYQ0KDQo=

--_003_357ace228adf4e859df5e9f3f4f18b49amazoncom_
Content-Type: application/octet-stream; name="ftest_write.sh"
Content-Description: ftest_write.sh
Content-Disposition: attachment; filename="ftest_write.sh"; size=1068;
	creation-date="Fri, 23 Sep 2022 00:11:42 GMT";
	modification-date="Fri, 23 Sep 2022 00:11:36 GMT"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gNCg0KIyBzZXR1cCwgbWFrZSBzdXJlIGluc3RhbGwgZmlvIGFuZCBlMmZzcHJv
ZyB0b29scyBmaXJzdA0KaWYgWyAteiAiJDEiIF07dGhlbg0KICAgICAgICBlY2hvICdVc2FnZTpm
dGVzdCA8ZGV2X25hbWU+Jw0KICAgICAgICBleGl0IDANCmZpDQplY2hvICJDcmVhdGUgL3Jkc2Ri
ZGF0YTEvIg0KbWtkaXIgL3Jkc2RiZGF0YTEvDQpta2UyZnMgLW0gMSAtdCBleHQ0IC1iIDQwOTYg
LUwgL3Jkc2RiZGF0YSAvZGV2LyQxIC1KIHNpemU9MTI4DQpzbGVlcCAxDQptb3VudCAtdCBleHQ0
IC1vIG5vYXRpbWUsbm9kaXJhdGltZSxkYXRhPW9yZGVyZWQgL2Rldi8kMSAvcmRzZGJkYXRhMQ0K
DQojIHRlc3QNCiNmb3IgaSBpbiBgc2VxIDEgMTBgOyBkbw0KICAgICAgICBybSAtcmYgL3Jkc2Ri
ZGF0YTEvKg0KICAgICAgICAvdXNyL2Jpbi9maW8gLS1uYW1lPTE2a2JfcmFuZF93cml0ZV9vbmx5
XzIwNDhfam9icyAtLWRpcmVjdG9yeT0vcmRzZGJkYXRhMSAtLXJ3PXJhbmR3cml0ZSAtLWlvZW5n
aW5lPXN5bmMgLS1idWZmZXJlZD0xIC0tYnM9MTZrIC0tbWF4LWpvYnM9MjA0OCAtLW51bWpvYnM9
MjA0OCAtLXJ1bnRpbWU9MzAgLS10aHJlYWQgLS1maWxlc2l6ZT0yODgwMDAwMCAtLWZzeW5jPTEg
LS1ncm91cF9yZXBvcnRpbmcgLS1jcmVhdGVfb25seT0xID4gL2Rldi9udWxsDQogICAgICAgIHN1
ZG8gZWNobyAxID4gL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzDQogICAgICAgIGVjaG8gInN0YXJ0
IHRlc3QgJHtpfSINCiAgICAgICAgL3Vzci9iaW4vZmlvIC0tbmFtZT0xNmtiX3JhbmRfd3JpdGVf
b25seV8yMDQ4X2pvYnMgLS1kaXJlY3Rvcnk9L3Jkc2RiZGF0YTEgLS1ydz1yYW5kd3JpdGUgLS1p
b2VuZ2luZT1zeW5jIC0tYnVmZmVyZWQ9MSAtLWJzPTE2ayAtLW1heC1qb2JzPTIwNDggLS1udW1q
b2JzPTIwNDggLS1ydW50aW1lPTYwIC0tdGltZV9iYXNlZCAtLXRocmVhZCAtLWZpbGVzaXplPTI4
ODAwMDAwIC0tZnN5bmM9MSAtLWdyb3VwX3JlcG9ydGluZw0KI2RvbmUNCg0KIyBjbGVhbnVwDQp1
bW91bnQgL3Jkc2RiZGF0YTENCnJtIC9yZHNkYmRhdGExLyAtcmYNCg0K

--_003_357ace228adf4e859df5e9f3f4f18b49amazoncom_
Content-Type: application/octet-stream;
	name="allow more ext4-rsv-conversion workqueue.patch"
Content-Description: allow more ext4-rsv-conversion workqueue.patch
Content-Disposition: attachment;
	filename="allow more ext4-rsv-conversion workqueue.patch"; size=1027;
	creation-date="Fri, 23 Sep 2022 00:47:51 GMT";
	modification-date="Fri, 23 Sep 2022 00:47:42 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyN2UxYjBlMTQyNzVhMjgxYjM1MjlmNmE2MGM3YjIzYTgxMzU2NzUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogZGF2aW5hbHUgPGRhdmluYWx1QGFtYXpvbi5jb20+DQpEYXRl
OiBGcmksIDIzIFNlcCAyMDIyIDAwOjQzOjUzICswMDAwDQpTdWJqZWN0OiBbUEFUQ0hdIGFsbG93
IG1vcmUgZXh0NC1yc3YtY29udmVyc2lvbiB3b3JrcXVldWUgdG8gc3BlZWR1cCBmaW8NCiB3cml0
aW5nDQoNCi0tLQ0KIGZzL2V4dDQvc3VwZXIuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4dDQvc3VwZXIu
YyBiL2ZzL2V4dDQvc3VwZXIuYw0KaW5kZXggYTBhZjgzM2Y3ZGE3Li42YjM0Mjk4Y2RjM2IgMTAw
NjQ0DQotLS0gYS9mcy9leHQ0L3N1cGVyLmMNCisrKyBiL2ZzL2V4dDQvc3VwZXIuYw0KQEAgLTQ5
NjMsNyArNDk2Myw3IEBAIHN0YXRpYyBpbnQgZXh0NF9maWxsX3N1cGVyKHN0cnVjdCBzdXBlcl9i
bG9jayAqc2IsIHZvaWQgKmRhdGEsIGludCBzaWxlbnQpDQogICAgICAgICAqIGNvbmN1cnJlbmN5
IGlzbid0IHJlYWxseSBuZWNlc3NhcnkuICBMaW1pdCBpdCB0byAxLg0KICAgICAgICAgKi8NCiAg
ICAgICAgRVhUNF9TQihzYiktPnJzdl9jb252ZXJzaW9uX3dxID0NCi0gICAgICAgICAgICAgICBh
bGxvY193b3JrcXVldWUoImV4dDQtcnN2LWNvbnZlcnNpb24iLCBXUV9NRU1fUkVDTEFJTSB8IFdR
X1VOQk9VTkQsIDEpOw0KKyAgICAgICAgICAgICAgIGFsbG9jX3dvcmtxdWV1ZSgiZXh0NC1yc3Yt
Y29udmVyc2lvbiIsIFdRX01FTV9SRUNMQUlNIHwgV1FfVU5CT1VORCB8IF9fV1FfT1JERVJFRCwg
MCk7DQogICAgICAgIGlmICghRVhUNF9TQihzYiktPnJzdl9jb252ZXJzaW9uX3dxKSB7DQogICAg
ICAgICAgICAgICAgcHJpbnRrKEtFUk5fRVJSICJFWFQ0LWZzOiBmYWlsZWQgdG8gY3JlYXRlIHdv
cmtxdWV1ZVxuIik7DQogICAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsNCi0tDQoyLjM3LjEN
Cg==

--_003_357ace228adf4e859df5e9f3f4f18b49amazoncom_--
