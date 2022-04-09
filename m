Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ED94FA1F2
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Apr 2022 05:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbiDID0l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Apr 2022 23:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiDID0k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Apr 2022 23:26:40 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA414146B63
        for <linux-ext4@vger.kernel.org>; Fri,  8 Apr 2022 20:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1649474674; x=1681010674;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=//FScuMBnecX8RWK2SYHuECoSA+X3A/nGLRgijuLUYU=;
  b=UXkIiqw0IK20RB6Pkgr1h8tTFlUbLtrBU+9/q8oIezAZ5eNiLoM2iRBN
   C+FCGtKTuOSk09aGwRWQZ4H/7wAEydkA9hY/FFpDzZUB52uL40Uo2SOJz
   8uzs8fh+o8lulp+fOBwL+HLTliUUHhLhVBCkeOSMMWc5awIYdyeRQgNvj
   s=;
X-IronPort-AV: E=Sophos;i="5.90,246,1643673600"; 
   d="scan'208";a="188579175"
Subject: Re: e2fsprogs builds and installs obsolete version of blkid
Thread-Topic: e2fsprogs builds and installs obsolete version of blkid
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 09 Apr 2022 03:24:32 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-2dbf0206.us-west-2.amazon.com (Postfix) with ESMTPS id DC7FAA2735;
        Sat,  9 Apr 2022 03:24:31 +0000 (UTC)
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sat, 9 Apr 2022 03:24:31 +0000
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13D23UWA003.ant.amazon.com (10.43.160.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sat, 9 Apr 2022 03:24:31 +0000
Received: from EX13D23UWA003.ant.amazon.com ([10.43.160.194]) by
 EX13D23UWA003.ant.amazon.com ([10.43.160.194]) with mapi id 15.00.1497.033;
 Sat, 9 Apr 2022 03:24:31 +0000
From:   "Kiselev, Oleg" <okiselev@amazon.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     linux-ext4 <linux-ext4@vger.kernel.org>
Thread-Index: AQHYSUMGB1x25g21i0KlSX4qire5eKzi1ruAgAOkCQA=
Date:   Sat, 9 Apr 2022 03:24:31 +0000
Message-ID: <4053942A-F51B-4AAA-A44F-3DD5B3E8402A@amazon.com>
References: <4EF2E5CC-E4E7-4463-893C-274EA9535EC1@amazon.com>
 <Yk2MI/UNYWDNFVx+@mit.edu>
In-Reply-To: <Yk2MI/UNYWDNFVx+@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.98]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B019BC507E781B4A9CF8128D495DF7F7@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

R290IGl0LiAgVGhlcmUgd2FzIG5vIG1lbnRpb24gb2YgaW5zdGFsbGluZyBsaWJibGtpZC1kZXZl
bCBhbmQgbGlidXVpZC1kZXZlbCBpbiB0aGUgSU5TVEFMTCBmaWxlLiAgTm93IHRoYXQgSSBrbm93
IHdoYXQgdG8gbG9vayBmb3IsIHRoZSAuL2NvbmZpZ3VyZSBhY3Rpb25zIHdpdGggYmxraWQgbWFr
ZSBzZW5zZS4NCg0K77u/T24gNC82LzIyLCA1OjQ5IEFNLCAiVGhlb2RvcmUgVHMnbyIgPHR5dHNv
QG1pdC5lZHU+IHdyb3RlOg0KDQogICAgQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZy
b20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91IGNhbiBjb25maXJtIHRoZSBzZW5kZXIgYW5kIGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0KDQoNCiAgICBPbiBUdWUsIEFwciAwNSwgMjAyMiBhdCAx
MToxNToyMlBNICswMDAwLCBLaXNlbGV2LCBPbGVnIHdyb3RlOg0KICAgID4gVGhlIGUyZnNwcm9n
cyBjb250YWlucyBhIHZlcnNpb24gMS4wLjAgb2YgYGJsa2lkYC4gIFRoaXMgdmVyc2lvbg0KICAg
ID4gZG9lcyBub3Qgc3VwcG9ydCBmbGFncyB0aGF0IHRoZSBjdXJyZW50IGtlcm5lbCBpbnN0YWxs
IHNjcmlwdHMgcGFzcw0KICAgID4gdG8gYGJsa2lkYC4gIEJ5IGJ1aWxkaW5nIGFuZCBpbnN0YWxs
aW5nIGUyZnNwcm9ncyBJIGVuZGVkIHVwDQogICAgPiByZXBsYWNpbmcgYmxraWQgMi4zMC4yIHdp
dGggMS4wLjAsIHdoaWNoIGJyb2tlIGtlcm5lbCBwYWNrYWdpbmcuDQogICAgPiBUaGlzIGlzIGVh
c2lseSBmaXhlZCBieSBkb2luZyBgeXVtIHJlaW5zdGFsbCB1dGlsLWxpbnV4YCwgd2hpY2gNCiAg
ICA+IHJlaW5zdGFsbHMgdGhlIGNvcnJlY3QgdmVyc2lvbiBibGtpZC4NCiAgICA+DQogICAgPiBU
aGlzIG1lc3MgY291bGQgYmUgYXZvaWRlZCBpZiBlMmZzcHJvZ3MgZWl0aGVyIGluY2x1ZGVkIGEg
bW9yZQ0KICAgID4gbW9kZXJuIHZlcnNpb24gb2YgYmxraWQsIG9yIHBlcmhhcHMgZGlkIG5vdCBp
bmNsdWRlIGJsa2lkIGF0IGFsbCwNCiAgICA+IHNpbmNlIGEgbW9yZSBjdXJyZW50IHZlcnNpb24g
b2YgdGhpcyB1dGlsaXR5IGlzIG1haW50YWluZWQgYW5kDQogICAgPiBpbnN0YWxsZWQgdGhyb3Vn
aCBvdGhlciBwYWNrYWdlcy4NCiAgICA+DQogICAgPiAoRmluZGluZyBodHRwczovL2ZvcnVtcy5j
ZW50b3Mub3JnL3ZpZXd0b3BpYy5waHA/dD02OTY1NSBoZWxwZWQgYSBsb3QgaW4gZmlndXJpbmcg
b3V0IHdoeSBteSBrZXJuZWwgYnVpbGQgc3RhcnRlZCBmYWlsaW5nIGFsbCBvZiBhIHN1ZGRlbikN
Cg0KICAgIFRoZSBibGtpZCBhbmQgdXVpZCBsaWJyYXJpZXMgd2VyZSBtb3ZlZCBmcm9tIGUyZnNw
cm9ncyBmcm9tIHV0aWwtbGludXgNCiAgICBvbiBtb3N0IExpbnV4IGRpc3RyaWJ1dGlvbnMuICBI
b3dldmVyLCB0aGVzZSBsaWJyYXJpZXMgYXJlIHN0aWxsDQogICAgbmVlZGVkIHRvIGNvbXBpbGUg
ZTJmc3Byb2dzLCBhbmQgdGhleSBhcmUgbmVlZGVkIGZvciBub24tTGludXgNCiAgICBvcGVyYXRp
bmcgc3lzdGVtcywgaW5jbHVkaW5nIEZyZWVCU0QsIElsbHVtb3MsIGV0Yy4sIGFuZCBzb21lIExp
bnV4DQogICAgc3lzdGVtcywgc3VjaCBhcyBBbmRyb2lkLiAgVGhhdCdzIHdoeSB0aGV5IGhhdmVu
J3QgYmVlbiByZW1vdmVkLg0KDQogICAgSWYgeW91IGluc3RhbGwgdGhlIFJIRUwvRmVkb3JhIHBh
Y2thZ2VzIGxpYmJsa2lkLWRldmVsIGFuZA0KICAgIGxpYnV1aWQtZGV2ZWwgYmVmb3JlIHlvdSBy
dW4gcnVuIGUyZnNwcm9ncydzIGNvbmZpZ3VyZSBzY3JpcHQsIHRoZW4gaXQNCiAgICB3aWxsIHVz
ZSB0aGUgc3lzdGVtIHZlcnNpb25zIG9mIGxpYmJsa2lkIGFuZCBsaWJ1dWlkLCB3aGljaCB3aWxs
IGRvDQogICAgdGhlIHJpZ2h0IHRoaW5nLg0KDQogICAgKEZvciBEZWJpYW4gLyBVYnVudHUgdGhl
IHBhY2thZ2VzIG5hbWVzIGFyZSBsaWJibGtpZC1kZXYgYW5kIHV1aWQtZGV2LA0KICAgIGJ1dCBm
b3IgdGhlc2UgZGlzdHJpYnV0aW9ucyBpdCdzIGJldHRlciB0byBqdXN0IHJ1bg0KICAgICJkcGtn
LWJ1aWxkcGFja2FnZSIgc2luY2UgdGhhdCB3aWxsIGF1dG9tYXRpY2FsbHkgYnVpbGQgdGhlIERl
Ymlhbg0KICAgIHBhY2thZ2VzIHdpdGggYWxsIG9mIHRoZSBjb3JyZWN0IGNvbmZpZ3VyZSBvcHRp
b25zIHZpYSB0aGUNCiAgICBkZWJpYW4vcnVsZXMgZmlsZSwgYW5kIHRoZSBCdWlsZC1EZXBlbmRz
OiBkZWNsYXJhdGlvbiBpbg0KICAgIGRlYmlhbi9jb250cm9sIHdpbGwgYXV0b21hdGljYWxseSBl
bmZvcmNlIHRoYXQgeW91IGhhdmUgYWxsIG9mIHRoZQ0KICAgIGNvcnJlY3QgYnVpbGQgcHJlcmVx
dWl0ZXMgaW5zdGFsbGVkLikNCg0KICAgIElmIHlvdSBoYW5kIGRvbmUgdGhlIHNpbXBsZSB0aGlu
ZyB0aGF0IG1vc3Qgbm92aWNlIHVzZXJzIGRvLCB3aGljaCBpcw0KICAgIHRvIGp1c3QgcnVuICIu
L2NvbmZpZ3VyZSA7IG1ha2UiLCB0aGVuIHRoZSBiaW5hcmllcyB3aWxsIHN0YXRpY2FsbHkNCiAg
ICBsaW5rIHRoZSBvbGQgdmVyc2lvbnMgb2YgYmxraWQgYW5kIHV1aWQgYW5kIHRoYXQgd2lsbCB3
b3JrIGFzIHdlbGwuDQogICAgWW91IGp1c3QgcmFuIGludG8gdGhlIGNhc2Ugd2hlcmUgKGEpIHlv
dSBrbmV3IGVub3VnaCB0byBlbmFibGUgRUxGDQogICAgc2hhcmUgbGlicmFyaWVzLCBidXQgKGIp
IGRpZG4ndCBrbm93IGVub3VnaCB0byBpbnN0YWxsIHRoZSBzeXN0ZW0NCiAgICBsaWJyYXJpZXMg
aW5zdGVhZCwgYW5kIChjKSB0aGVuIGRpZCBhICJtYWtlIGluc3RhbGwiIGluc3RlYWQgb2YgdXNp
bmcNCiAgICBhIHBhY2thZ2UgbWFuYWdlciB0byBtZWRpYXRlIGluc3RhbGxhdGlvbiBvZiB0aGUg
cHJvZ3JhbXMuDQoNCiAgICBJJ20gc29ycnkgdGhhdCBoYXBwZW5lZCB0byB5b3UsIGJ1dCBpdCdz
IGEgcmVsYXRpdmVseSByYXJlDQogICAgY29tYmluYXRpb24sIGFuZCB0aGUgZmFjdCByZW1haW5z
IHRoYXQgdGhlcmUgYXJlIG90aGVyIHVzZXJzIG9mDQogICAgZTJmc3Byb2dzIGJlc2lkZXMgTGlu
dXgsIGFuZCB1bmZvcnR1bmF0ZWx5LCBtYW55IG9wZW4gc291cmNlIHBhY2thZ2VzLA0KICAgIGlu
Y2x1ZGluZyB1dGlsLWxpbnV4IGFuZCBzeXN0ZW1kLCBzdWZmZXIgZnJvbSB0aGUgIkFsbCBUaGUg
V29ybGQgUnVucw0KICAgIExpbnV4IiBkaXNlYXNlLCB3aGljaCBzZWVtcyB0byBiZSBhbiB1cGRh
dGVkIGZvcm0gb2YgdGhlIGRpc2Vhc2UsICJBbGwNCiAgICB0aGUgV29ybGQncyBhIFZheCJbMV0u
ICAoVGhpcyBpcyBhbHNvIHdoeSBpdCB3b3VsZCB0YWtlIG1vcmUgd29yayB0aGFuDQogICAgaXQn
cyB3b3J0aCB0byB0cnkgdG8gYmFja3BvcnQgbmV3ZXIgdmVyc2lvbnMgb2YgYmxraWQgaW50byBl
MmZzcHJvZ3MuKQ0KDQogICAgQ2hlZXJzLA0KDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtIFRlZA0KDQogICAgWzFdIEZyb206IGh0dHBzOi8vd3d3Lmx5c2F0b3Iu
bGl1LnNlL2MvdGVuLWNvbW1hbmRtZW50cy5odG1sDQoNCiAgICAgICAgQ29tbWFuZG1lbnQgIzEw
Og0KICAgICAgICAgICBUaG91IHNoYWx0IGZvcmVzd2VhciwgcmVub3VuY2UsIGFuZCBhYmp1cmUg
dGhlIHZpbGUgaGVyZXN5IHdoaWNoDQogICAgICAgICAgIGNsYWltZXRoIHRoYXQgYGBBbGwgdGhl
IHdvcmxkJ3MgYSBWQVgnJywgYW5kIGhhdmUgbm8gY29tbWVyY2Ugd2l0aA0KICAgICAgICAgICB0
aGUgYmVuaWdodGVkIGhlYXRoZW5zIHdobyBjbGluZyB0byB0aGlzIGJhcmJhcm91cyBiZWxpZWYs
IHRoYXQNCiAgICAgICAgICAgdGhlIGRheXMgb2YgdGh5IHByb2dyYW0gbWF5IGJlIGxvbmcgZXZl
biB0aG91Z2ggdGhlIGRheXMgb2YgdGh5DQogICAgICAgICAgIGN1cnJlbnQgbWFjaGluZSBiZSBz
aG9ydC4NCg0KICAgICAgICBUaGlzIHBhcnRpY3VsYXIgaGVyZXN5IGJpZHMgZmFpciB0byBiZSBy
ZXBsYWNlZCBieSBgYEFsbCB0aGUNCiAgICAgICAgd29ybGQncyBhIFN1bicnIG9yIGBgQWxsIHRo
ZSB3b3JsZCdzIGEgMzg2JycgKHRoaXMgbGF0dGVyIGJlaW5nIGENCiAgICAgICAgcGFydGljdWxh
cmx5IHJldm9sdGluZyBpbnZlbnRpb24gb2YgU2F0YW4pLCBidXQgdGhlIHdvcmRzIGFwcGx5IHRv
DQogICAgICAgIGFsbCBzdWNoIHdpdGhvdXQgbGltaXRhdGlvbi4gQmV3YXJlLCBpbiBwYXJ0aWN1
bGFyLCBvZiB0aGUgc3VidGxlDQogICAgICAgIGFuZCB0ZXJyaWJsZSBgYEFsbCB0aGUgd29ybGQn
cyBhIDMyLWJpdCBtYWNoaW5lJycsIHdoaWNoIGlzIGFsbW9zdA0KICAgICAgICB0cnVlIHRvZGF5
IGJ1dCBzaGFsbCBjZWFzZSB0byBiZSBzbyBiZWZvcmUgdGh5IHJlc3VtZSBncm93cyB0b28NCiAg
ICAgICAgbXVjaCBsb25nZXIuDQoNCg0K
