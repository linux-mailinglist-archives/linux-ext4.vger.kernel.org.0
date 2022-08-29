Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09BC5A408C
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Aug 2022 03:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiH2BIi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Aug 2022 21:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2BIh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 Aug 2022 21:08:37 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 28 Aug 2022 18:08:35 PDT
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985D821261;
        Sun, 28 Aug 2022 18:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661735317; x=1693271317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KKJvQZb3DG1CKE8J8RP9MC9PstZPBoV/lrWK8JyQR5A=;
  b=We7mxkdRekw8Xdn93L8yxm0QJ41XvCVxlIaRv9/rarFblWbhFJn0WKM1
   dE0sKaSdLKdqUSMopVnMAAuLOcqVYXHJ6Eoa29nbbJ+FqnI0lpnn/Vwpy
   jDrpewWYl9go5TZJOcsTrAWzxtPcc6rFlX/7jdRsWmo8sbE1nUOjaoI/2
   b+RGw0psmwJcot5+DQ0BmLQSLtyj+SIu7PVSBMWnbtVPpuaV/qILorfXH
   0/GsgEVhnqhIlsnjDvUeHrrfedQ163dmX4Q7GH8TVHgki8CLWPJgK0ewn
   EWAewC+zFQG+2JYEAMEb3d8lsqdSbOEkiRbjbofnMkLSgHMcMnZKmTRIx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="63905164"
X-IronPort-AV: E=Sophos;i="5.93,271,1654527600"; 
   d="scan'208";a="63905164"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 10:07:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dazoob/cg0lKcBf1GtItCE32xqFbgmKPjo+iU3x9cUqytoTgmYrI+jivaiByBQJ1xy6JUzJlqlRc6oviYpClnEAxMAWmZ1C7oN6FdcU5fnlnpTKV9x/TggUWySSv2r0ZDt+8tIWrf24cC/z5wkR19sVZV0E/odrmVHMXENC3gt10GYbanKSw6qP58gYP5KZVbZRTgWRp2ddr/6ENh5oXX7YzkUM5PLLi/brXR4FfHduWkVo+qrcYKXBN9hWVEadYBzPMF4Ke7l1FwfkN4Vp8kpwYkBEKfgg5hVt0DJctZUrXGU+lQcylT2XrOV0LuC+53cVrGzVRvTo9cod1VLlXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKJvQZb3DG1CKE8J8RP9MC9PstZPBoV/lrWK8JyQR5A=;
 b=a6/oT0snGzXHNLAVCaKK8rrwKQUhs3j+2iHOPIzqHsHVpFFLRRWJSYzzU/r0W6efIccZWgSAHQA6v9aeWzqsvCeDD1lKVFsieL7r86QdnmGYWxq3cQ7EdGp1x/pYKEUOc09Tw4wry16zflCDfRem5htLsKCtQHQ9ylkeSYIjCv3bNsl30dL0emfVrJ9gTP8dkeSMB/3UmvIzf7syu4KoCD5qL3QUBcoKqMhVQneYEJuPr7SggOCTOnnprdDYZrkQ9h1o/WEeUtvsF56rRrZxeau6jK+6MeXzC+e2eusOz2rvsM8n6EMYbq03o8iNcRO6zcPq1Wl+C1zfjKUjYC3tJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB7477.jpnprd01.prod.outlook.com (2603:1096:604:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 01:07:24 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::a9fe:6054:eadc:7ef8%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 01:07:24 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "oliver.sang@intel.com" <oliver.sang@intel.com>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "lczerner@redhat.com" <lczerner@redhat.com>
Subject: Re: [PATCH] ext4/053: Remove nouser_xattr test
Thread-Topic: [PATCH] ext4/053: Remove nouser_xattr test
Thread-Index: AQHYsd5uGnPleGLBwU+djnQMMK1uxq3DrbQAgAGG9IA=
Date:   Mon, 29 Aug 2022 01:07:24 +0000
Message-ID: <1ac7f566-5880-7060-bd24-0637ccc1258c@fujitsu.com>
References: <1660705823-2172-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220828024858.cf5awn2uksbpchb3@zlang-mailbox>
In-Reply-To: <20220828024858.cf5awn2uksbpchb3@zlang-mailbox>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75d1fe6e-1dae-4dd4-93b6-08da895ad543
x-ms-traffictypediagnostic: OS3PR01MB7477:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OhMiv/BF4R3+imJ7o1wYvzs1gFj5GN2rUXpLLdveD7sNcZXQ9Hhuhz455eEKtQIRQ6k1007wagDd+S9iJ9gG8j85t1lmlIf7spSCB7qtEzgFismcFWUq2lrko7YUa8pt7uJFu3nw/405XTqpYLZhVmpN1IY+eZSFXYqAtOc1fNr+uhu61r2tDtz3/9FkuWKBkEVvv+iaukV6L/dIBj9Gqzqym0MV+MG/+f1I59KTJg2v4eBPFpT+8FJVocBASpR5Bo2/x3a8Zgjqwwor4GqBgg3XHonv4GjT7HsuXj6nDY+9ywzuA5MaQIkzjqSD/oE1F1FULxdgxaXvP5X3xHZbYYhcZFawvALftdxkKUCACy3VCoIh4lwE+zVcQnbGSErjcpGuC+ZxIo+LDvyLehR1UhCLf0xUhTgIlyDjoDvnoRXQfsAEI0UtIaeCrDrQL6SFkM6lOsEYFGTJX1EjkGQghHfGOeGX2YADTcc+u8XQ3cFMO316JjfTUrKkNN3kLPC8nPVE5EUAB0W1EM+yEl1XL7tFwTNaFO7Xwil8BEmdiotT4DZGRAy6v65gsRKn1BW/Izj16TNzZMrSAvrCfc2swsytdeFC80sDg+paK8FAx/L4OHHJ+RpAJOSXMuE4nelWr6ZyUqWUvQ2IDJamb+GDTpR23UMX4NyUVU29Pektbuvygyauc61F1BsjXIuh8Gf7rUnzAaJzc5QGZsiOGtQheCt7ygcL/0tz13jpptOfv4syxprxaKqakFGA3csiJdmFtT+UwO3EKA+snwirZG/Q882qhG3bUEijLiSNAqZ4KgureYxN6B35P9K5cbv6zz+PiabzooIqb+VD0G0k3cez6F7XrwoSHSLJYIoD29revWc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(1590799006)(6506007)(54906003)(38070700005)(2906002)(6916009)(31696002)(478600001)(86362001)(76116006)(6486002)(83380400001)(8676002)(5660300002)(66476007)(316002)(71200400001)(4326008)(66556008)(66946007)(64756008)(66446008)(41300700001)(91956017)(82960400001)(31686004)(8936002)(1580799003)(2616005)(85182001)(186003)(6512007)(36756003)(122000001)(26005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHVWaEtJeTgrb3FWUWcxM0VGZVdMN1pFK2crRkhOZEV3NysxOHhSSnJudDUx?=
 =?utf-8?B?YVdhOFRIS24wTERMQ0V2bHpQY2RTTEhFMzJpOGYxaGc3VlUrZ3pkd0N1UjRl?=
 =?utf-8?B?azI2bUZsSW9QSXVkbHZuRHlMa1c3M3RLQnEydFNqZFFFTFdjeEdubXlXck1V?=
 =?utf-8?B?bWdvZDJLMGQvcTAzcmpMM3U4QitWMi81VXJLVnBtZHFOdjFpeEczcSt4T1lt?=
 =?utf-8?B?enVXblVqcWIrSVRKbkwra0l3cnpKWFhVY0NVemNTNStNM3BoM0JPUkJGclZ6?=
 =?utf-8?B?VStCQU5YR1k2N1k2ZTc1N0lrbjZvbDN5YW4vODk5UkV5NTRyczU3T0huY1k1?=
 =?utf-8?B?VnZoVE9zYWFJYjVldW9GdUtGRFNVNFBkVjl5TzlhcTE3WlBJMTNKcHRCTTRB?=
 =?utf-8?B?cnZsTnJTRE1KOUlyNGh2UGFyekIweUtia1pPZHU2QWwxdEoyQXFTWDk1eTBt?=
 =?utf-8?B?cDdHc1JaeDJPZ1ZPdWxWSXZlZXZGeTBpQi9KcUpxS0psbFpHck8vM1JLWDJ0?=
 =?utf-8?B?ZDRzWWxzWFNYOG5US2Q4d2orRE1sd1hiS3A5UFJFeHQ3ZVBQSlYveEtyRk8r?=
 =?utf-8?B?UENWMG5YRE4yUTRaMk5QYXNaUGdlTDNKaWxJb1NWSXp1WktCb3lFVUkwUm5n?=
 =?utf-8?B?c081V0E4cjBZNmFWdUpXakVQWVkyalNmVllnWk03NlBvcFgzNnQ3WWh0VGhP?=
 =?utf-8?B?SUdLNDhHODlpcWhCL3duYlVUNkVrQXhCM0hLT3pVS2pQR3lzRGtBSXZYKy81?=
 =?utf-8?B?MittdGEzZXZkQVE5ZnoxblRrMkN4ODlHbU5TSUo3S3l3cjl6RXFXN2g4dGh1?=
 =?utf-8?B?Zkdod1MwckJPV1hWbjY3cXpoc1dLdm9OamRWZ0ZGekJrRXJGYlpJc21IVk91?=
 =?utf-8?B?NUFYZmUyd3Y5U2FnQTNwdUpaODFmMms4WGxXQ0EzWVRyWG1ia0lyVW4yOU9q?=
 =?utf-8?B?ZE95ODVmRWE3TVVmc0htYW5pcFQ3V3Rqdkozemkyc1pwQ2RmTjNGelNIUzBU?=
 =?utf-8?B?cmxYRW43N05oejlKTk1GMWhtUGQwMkFETGxZWG5qd3dFRmV5MmFUUnRJWjl5?=
 =?utf-8?B?MksxMVFxNFg4K3ltOG5VaTQrL0F2N3g3TVp3Y25rcUtzQng4cWx0TXY1M2ZZ?=
 =?utf-8?B?eGhzaEhnRVVVM2xrYXJtZ0xUcGw5RmFHQlV4b291TzlvZ0dCc0Jna0NiVXN5?=
 =?utf-8?B?Y2xpZ1B1RGVuWi9HS1NUVElVZERyWm1BRVhpZ3J0WktVL3R0Qi8ycXVQbysv?=
 =?utf-8?B?NE0zU3dPY2JhWjE4dnFzaUVSZnZCTlpIU0prblYzcm5OUUZ0QTc1dE9YRGVB?=
 =?utf-8?B?VTc5YkF1NGJWcC9maVpZdzRTWmduUEJpZHJBc3Nsc0NFNGNVV2JCaloybm9Z?=
 =?utf-8?B?Qmk5SDAzVkZGSjNXWCtGa25GR3kzMmNGK3Arb3lKYnZlRXVFZkd4Q0gzMW9W?=
 =?utf-8?B?YURwWEJzSlR4M29JVHl6Sk5ROHNDTFBpNVd6SXBvNlRDaFRLM3NJbERBa1F4?=
 =?utf-8?B?U3M5UCtqUHZUVm5BZXFuWDdkcmhxSGx5QlQyb1Qray8xWGxsSkFFQVVpc0Z1?=
 =?utf-8?B?bTBHRytndWQ0Wm5hU3ptSEh3NXFiNDg0S210dzVTK2dRalNCd2VvSzlybWg1?=
 =?utf-8?B?ZytKSjRNSzFUM3d5SER6Ym5nRDkxVWM2bG1WOG1MdklGMEw0RHNEWDUwUzg0?=
 =?utf-8?B?Zi9xa2hLSzBhWk10anZiRDZQaThDRTVXNEtCRlpTWU9IeGhhdnlRY0wwa3hJ?=
 =?utf-8?B?L1NMMFRNTnUrTThnS0tyZEN5SVRKRktpaE1GaUJmd1pNOGlvWHNsN1hCL0NY?=
 =?utf-8?B?U3lITkd2K1FTZ282dFlqVzZFN01VOVcwV3V5dWdraWFvWWtueFJqdlh2Ujd1?=
 =?utf-8?B?SlpMOU1TeWVJUlZwK1dLSnczVWZacUpVQXNYNDRyMkJOcHBYZFhQTXYzdnlI?=
 =?utf-8?B?TXl0dDZXM2JlNDNWRFJPVGNWYmk5Q2N0YVk2ek1mN0praVV3MmU4ZSt5ZUtN?=
 =?utf-8?B?MUQveGJMUWxjeEk4dXRwSi8zTHNHNVkrZ1liMElTU0lrS0VtdlJ1eVNSMEUv?=
 =?utf-8?B?cStqZkdjVW9PQTlpb3J0ZHhScE9WQm43dTBNNmNlTm5SYkFTTEg4RGpZcjZt?=
 =?utf-8?B?MWN5RkYvZG53MnIrRFd2U0RQQkx0RFBqK0YrWTNBbWpzOHlvcml4SE0vRVdL?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B96E443C18315C4DA25E7E6AF150AFA8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d1fe6e-1dae-4dd4-93b6-08da895ad543
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 01:07:24.4071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+fwgKA9mhOgeqeclz8AWXPpo2+FO1gSMFi/hN8Ap+LKUCixa0g8H+766Ek+8JS2zmhfiiyO5klrJgyH+ORsSZg+KvUqvGcWSvudRTxI0/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7477
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

DQpvbiAyMDIyLzA4LzI4IDEwOjQ4LCBab3JybyBMYW5nIHdyb3RlOg0KPiBPbiBXZWQsIEF1ZyAx
NywgMjAyMiBhdCAxMToxMDoyM0FNICswODAwLCBZYW5nIFh1IHdyb3RlOg0KPj4gUGxhbiB0byBy
ZW1vdmUgbm9hY2wgYW5kIG5vdXNlcl94YXR0ciBtb3VudCBvcHRpb24gaW4ga2VybmVsIGJlY2F1
c2UgdGhleQ0KPj4gYXJlIGRlcHJlY2F0ZWRbMV0uIFNvIHJlbW92ZSBub3VzZXJfeGF0dHIgdGVz
dCBpbiBoZXJlLg0KPiANCj4gV2hhdCdzIHRoZSBbMV0/DQo+IA0KPiBXZSdkIGJldHRlciB0byBi
ZSBjYXJlZnVsIHdoZW4gd2Ugd2FudCB0byByZW1vdmUgYSB0ZXN0aW5nIGNvdmVyYWdlLiBJJ20g
bm90DQo+IHN1cmUgaWYgdGhleSd2ZSBkZWNpZGVkIHRvIHJlbW92ZWQgdGhpcyBtb3VudCBvcHRp
b24sIHRoZSBleHQ0LzA1MyBpcyBhbg0KPiBpbXBvcnRhbnQgdGVzdCBjYXNlIGZvciBleHQ0LCBz
byBJJ2QgbGlrZSB0byBoZWFyIHRoZWlyIG9waW5pb24uDQoNClNvcnJ5IGZvciB0aGlzIG1pc3Mu
DQoNClsxXWh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWV4dDQvMTY1ODk3NzM2OS0yNDc4
LTEtZ2l0LXNlbmQtZW1haWwteHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbS9ULyN0DQoNCkJlc3Qg
UmVnYXJkcw0KWWFuZyBYdQ0KPiANCj4gVGhhbmtzLA0KPiBab3Jybw0KPiANCj4+DQo+PiBSZXBv
cnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPG9saXZlci5zYW5nQGludGVsLmNvbT4NCj4+IFNp
Z25lZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+PiAtLS0N
Cj4+ICAgdGVzdHMvZXh0NC8wNTMgfCAxIC0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRp
b24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvZXh0NC8wNTMgYi90ZXN0cy9leHQ0LzA1
Mw0KPj4gaW5kZXggNTU1ZTQ3NGUuLjVkMmM0NzhhIDEwMDc1NQ0KPj4gLS0tIGEvdGVzdHMvZXh0
NC8wNTMNCj4+ICsrKyBiL3Rlc3RzL2V4dDQvMDUzDQo+PiBAQCAtNDM5LDcgKzQzOSw2IEBAIGZv
ciBmc3R5cGUgaW4gZXh0MiBleHQzIGV4dDQ7IGRvDQo+PiAgIAltbnQgb2xkYWxsb2MgcmVtb3Zl
ZA0KPj4gICAJbW50IG9ybG92IHJlbW92ZWQNCj4+ICAgCW1udCAtdCB1c2VyX3hhdHRyDQo+PiAt
CW1udCBub3VzZXJfeGF0dHINCj4+ICAgDQo+PiAgIAlpZiBfaGFzX2tlcm5lbF9jb25maWcgQ09O
RklHX0VYVDRfRlNfUE9TSVhfQUNMOyB0aGVuDQo+PiAgIAkJbW50IC10IGFjbA0KPj4gLS0gDQo+
PiAyLjI3LjANCj4+DQo+IA==
