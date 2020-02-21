Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D70E4166B51
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 01:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgBUAIP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Feb 2020 19:08:15 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:22000 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbgBUAIO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Feb 2020 19:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582243694; x=1613779694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gBW3hnqLHheZm+4DpwAVGcBMVKRwBJbABCPT2v/IRWU=;
  b=igW08uNzhK9CxooedcXaYoDCgN/z9ApRu2uxzq2JL1b2redBQHT72hWk
   4jByUKOtjrdPKyeQ6oBUkxJrl9/kfqLeeAWmkWQfGzLmRIQrkooVFsRYC
   Rg2tieufJjkJvufvNVfmQXZGRH+aLko1AxcbHNVtdVcD5U9I8OLvbN9lo
   0=;
IronPort-SDR: 53/ktQIrHY9fEaDxAbVULl4ArQrleI9IGBsPHWqvjEH7OEkYToeMYPAB/Whq+QgE/2xcGnCC1D
 ZWOlqhcCizxw==
X-IronPort-AV: E=Sophos;i="5.70,466,1574121600"; 
   d="scan'208";a="18886593"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 21 Feb 2020 00:08:02 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id CC740A2253;
        Fri, 21 Feb 2020 00:08:00 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 21 Feb 2020 00:08:00 +0000
Received: from EX13D30UWC001.ant.amazon.com (10.43.162.128) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 21 Feb 2020 00:07:59 +0000
Received: from EX13D30UWC001.ant.amazon.com ([10.43.162.128]) by
 EX13D30UWC001.ant.amazon.com ([10.43.162.128]) with mapi id 15.00.1367.000;
 Fri, 21 Feb 2020 00:07:59 +0000
From:   "Jitindar SIngh, Suraj" <surajjs@amazon.com>
To:     "tytso@mit.edu" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "Singh, Balbir" <sblbir@amazon.com>
Subject: Re: [PATCH 0/3] ext4: Fix potential races when performing online
 resizing
Thread-Topic: [PATCH 0/3] ext4: Fix potential races when performing online
 resizing
Thread-Index: AQHV5tIfEnQegGj8iE6YGurpkbQukagjnF8AgAEr74A=
Date:   Fri, 21 Feb 2020 00:07:59 +0000
Message-ID: <5f2ac4c72788b6f453a476227f54ef85a7e309e9.camel@amazon.com>
References: <20200219030851.2678-1-surajjs@amazon.com>
         <20200220061428.GG476845@mit.edu>
In-Reply-To: <20200220061428.GG476845@mit.edu>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAF01EC8718171458220223B009C51E7@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

T24gVGh1LCAyMDIwLTAyLTIwIGF0IDAxOjE0IC0wNTAwLCBUaGVvZG9yZSBZLiBUcydvIHdyb3Rl
Og0KPiBIaSBTdXJhaiwNCj4gDQo+IEFsbCBvZiB0aGUgcGF0Y2hlcyB0byBmaXggQlogMjA2NDQz
IGFyZSBub3cgb24gdGhlIGV4dDQgZ2l0IHRyZWU6DQo+IA0KPiANCmh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3R5dHNvL2V4dDQuZ2l0L2xvZy8/aD1kZXYN
Cj4gDQo+IEknbSBjdXJyZW50bHkgZ2l2aW5nIHRoZW0gYSBmdWxsIHJlZ3Jlc3Npb24gdGVzdCBz
ZXQgdXNpbmcgeGZzdGVzdHMuDQo+IENvdWxkIHlvdSBydW4geW91ciB0ZXN0cyB0byBtYWtlIHN1
cmUgaXQgbG9va3MgZ29vZCBmb3IgeW91Pw0KDQpIaSwNCg0KSGF2ZSBydW4gbXkgcmVwbyBjYXNl
IGZvciA2IGhvdXJzIHdpdGhvdXQgaXNzdWUuDQpQcmV2aW91c2x5IHRoaXMgcmVwcm9kdWNlZCAx
MDAlIG9mIHRoZSB0aW1lIHdpdGhpbiA8MzAgbWlucy4NCg0KPiANCj4gSSdtIGhvcGluZyB0byBp
c3N1ZSBhIHB1bGwgcmVxdWVzdCB0byBMaW51cyBpbiB0aW1lIGZvciA1LjYtcmMzIGJ5DQo+IHRo
aXMgd2Vla2VuZC4NCj4gDQo+IEFsc28sIGlmIHlvdSBjYW4gZmlndXJlIG91dCBhIHdheSB0byBw
YWNrYWdlIHVwIHRoZSByZXBybyBhcyBhbg0KPiB4ZnN0ZXN0cyB0ZXN0IGNhc2UsIHRoYXQgd291
bGQgYmUgcmVhbGx5IGV4Y2VsbGVudC4gIEkgdGhpbmsgdGhlDQo+IGNoYWxsZW5nZSBpcyB0aGF0
IHNvbWUgb2YgdGhlbSB0b29rIGEgKmh1Z2UqIGFtb3VudCBvZiBwb3VuZGluZw0KPiBiZWZvcmUN
Cj4gdGhleSByZXBybydlZCwgY29ycmVjdD8gIEkgd2Fzbid0IGFjdHVhbGx5IGFibGUgdG8gdHJp
Z2dlciB0aGUgcmVwcm8NCj4gdXNpbmcga3ZtLCBidXQgSSB3YXMgb25seSB1c2luZyBhIDIgQ1BV
IGNvbmZpZ3VyYXRpb24uDQoNCkkgd2lsbCBsb29rIGludG8gdGhpcy4NCg0KVGhhbmtzLA0KU3Vy
YWoNCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gCQkJCQkJLSBUZWQNCj4gDQo=
