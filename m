Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631E758095F
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jul 2022 04:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiGZCTQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Jul 2022 22:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiGZCTP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Jul 2022 22:19:15 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Jul 2022 19:19:13 PDT
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DA325598
        for <linux-ext4@vger.kernel.org>; Mon, 25 Jul 2022 19:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658801954; x=1690337954;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RmLky8D8qlxKd34lYLvIWRcg4VMCBGNglbZVV1hd+CI=;
  b=mGxtWCGqAnEdtQ5N0kL1AIC/lOXqjFXOmoXNDISirqz6kv+r96AOwXLP
   ViwbXo6d2UGdXQVTeCosws8trOnruEq6cN4TRSy49q0h+DgiXrQ4Lguo+
   jefU6J17x8votLOUk/vqX+jh1skOQ/8ys7fQrvdRzc9pfjkmaUvCZpxmo
   XnHIDSLWne+KvGB3h0SyhqM67QDWRr59yQWprDAvKz2PMlUyx1PZ7X3fN
   RNyWTxNfYuuOJANXbeSkq0UNKsNLczUgMm5Ysm9LsfdjHbl/dCN8/Sdu2
   N43hEncJEEQyxXBALGpOCE/kp6/HqVi4Nj33Jidq5G4FPob0VeWlFGSfe
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="61035346"
X-IronPort-AV: E=Sophos;i="5.93,193,1654527600"; 
   d="scan'208";a="61035346"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 11:18:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7BXVkVTfm/gSjxgbafHqO8S29gv+vdnnUOUDMVKugGlxBki694YJYqJ6e5mq5x17OEVAtoaxzEZmxafOkCyDiEWnxW4mApT9nwvdQJDdvozJTfjgx7piS/ERAwFePXseASizjrBm/7uAkVFGn8GlYqLOlhlnXlt2GydykhPs1t7QcAR1nLab0WoDXAPFNBI+zn+liLaWpqIJnZKvxW0tcbzZcfsEdCD/t0PFIHhSqqb+8thF90o815PlSdV2DeGlWAfHYly+Fzpl/70wJWjkaUlw740hIvvLU9chKfx/kxSTvrAeqYxfTi4CfEeHysLjRRxEZOdEKo/PPfUKXf9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmLky8D8qlxKd34lYLvIWRcg4VMCBGNglbZVV1hd+CI=;
 b=ATqd9t6RadRIWLLD1jCBwVx3LLZ+2o/xBQVLjGTqjBMp4sofWCM7lpUwNvjXdj50eRWe7iCZLVMvDCE3WMTlXfC5WdfBHRIFCWSQqNXlfcXTUCRshoxEVRK1clXVjf4DKIv7n6mtwexZCgFB/viIzyhICXJfZ7CtCPPwx5wVJwtMpu0xZFCcgYPOLB7xz5cOQoNncMAOQXoq7hqaBg7NsswT3kUn1wCJcqeIaW6ruC6NmrgT5S0BK1gfnvJIkFZyt6ktWR8oO5XPtZnrZZkjc+QbHCSakLEjn4H6O+zp9nspxzoqOqNwxvJKjHyyzmGTAJCM16lXQvgsBvL8NoHflA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSBPR01MB4053.jpnprd01.prod.outlook.com (2603:1096:604:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 02:18:02 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::5092:a34:8a79:5e78%5]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 02:18:02 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Jeff Layton <jlayton@kernel.org>
CC:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] ext4: unconditionally enable the i_version counter
Thread-Topic: [PATCH] ext4: unconditionally enable the i_version counter
Thread-Index: AQHYoFzuu6k4NYpRY0K+AXOoSkih662PoAEAgABcHgA=
Date:   Tue, 26 Jul 2022 02:18:02 +0000
Message-ID: <dd49d5f7-1575-90c7-8086-8254ce71012c@fujitsu.com>
References: <20220725192946.330619-1-jlayton@kernel.org>
 <Yt8P1HmV//iX9XWC@magnolia>
In-Reply-To: <Yt8P1HmV//iX9XWC@magnolia>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43ad3ffe-7e43-4933-2ca0-08da6ead115f
x-ms-traffictypediagnostic: OSBPR01MB4053:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zQr/+6IV6HL4epta1Em8jUYY/zf8JAzNzy9R3UH43syNJDYYul4DCrzQPuQ692Ov5czTErxoiiQ/8bXm9x2JaKZ8nxsqh3fDgAPd0cxRIHTm7VWw+dpjBtHhg7IgokXxwqo3hdvWU7fpLcEWglcfdklmHEUc3JUmxs3IQfJWBQ7/mZH/EZKtlq806YOCt6zcLWMOovpTiqEUcUoSXrk3/6KlNxChlLN56iSTPT9OjcfcM5d22MHduspGkVYbOY1t0qnsNrvef7QHi4Q/I3jKRaxWaJyl3xYFggsyuVUy3xrWJZGnTTIN2PjwXf9dGCaO8mfh8s1vIyQ46HV+v8sp8EDMDjzqHQ5gAw7f4T4RsG4EgK+vFUVB9FeSBuldTFFMIucAB37e6dtRrw26/ZLEIHINm5gNx+VG+DzaUT+aV7hdyPdKyPlWmA9gSkXh3lNYRn3HU8F8eyChXAksU5GvlQhLPrPZC61suc/knnaavMKa9Q0olT+ns7fMpTanJpzgtvXFDRuT/KLQ0F5F2FrDMjLgvJNptiIFatEDGmIFZxCXA0k8GrhuYgVEZf/Bg+7nxmwoZOZRZiB62MNkVvHhVAD23KWClnswxRE1BjKV6DC1NZXZs801HYf8CJlDXbNgNvAteHQ/CUX+v/oLjcOTTtGEzJ6xZeRm6I7lViPgQhyzA8xCqIgqLBfUJT4WuywnFkbubxHkame+gPd9Pgg+EJL4jVZmh+QO9sAHNdETuwDLQbWtE3+JQOBq/iJXZPEB6oKyiQDs6BPw6bE640wWDJdeoCaXc3sR/FgE3g9YaE2mqp8cQsya3ylP/ScT74LuyIqlHol8o5PtqcC1eg3W/8hEqgv2hdX6YBMelqvULotwEpJ5Q4Uet7/B2KvGcY/YAaB8/8zpVhHiK5+DK3b2Zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(38070700005)(31696002)(86362001)(85182001)(36756003)(82960400001)(122000001)(31686004)(38100700002)(186003)(83380400001)(2616005)(6512007)(478600001)(316002)(2906002)(54906003)(71200400001)(6506007)(110136005)(8936002)(41300700001)(66446008)(91956017)(66476007)(76116006)(66946007)(4326008)(66556008)(64756008)(5660300002)(8676002)(26005)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHZnUTZUUG1Hem1JUXE1SGwwWWN2NDdFQlF1ZDlDWXNOdGJTVjY5Mk1YVWtQ?=
 =?utf-8?B?R0VTc1ZVM2pPMytaUXM1YkwzN0xQS29aWkM0UTNLdWl3NEk4eWo3RXB5TFBr?=
 =?utf-8?B?b3h0VHJRb09WMXR4WDZYbTNMZkNMR1FQeEQrZGZWQlUzK0hUTmtWNFYzWWxT?=
 =?utf-8?B?cUFMR2VXQmxEODZUNnhNQXB1RTRNWWYxWWJFRm1xM0ZZbjVGTkdDUnYxUkov?=
 =?utf-8?B?dHV4TUpQRHJNQmZoUXArY1ovYnV3cjFPLzdnT1oweUxkMFJWZ1ZRM1lOT3dl?=
 =?utf-8?B?LzMxUTFRYjF6bmNrUkFnUCtSelVXWVZ6bXJQWExFRVcyZ1dBcXBOYWRQZVhU?=
 =?utf-8?B?dFZ4bG9uVWxrR2JUWXFqV0Y5N1EyWEVxWVBvMnpVZGVaWHFZT2pwUnI4Mkt0?=
 =?utf-8?B?dmNBRU5kelZMKzUyM2ZjaXMxaVptTEM3MWwydmVzSGE1azlua01sSy82TCtU?=
 =?utf-8?B?dGVlN08veCswQU9zazVZQU4wLzZJeHFENDhneXNGUm85ZWlqWkhTcWg4aHNr?=
 =?utf-8?B?bjBoVWdDTmxGVVh2TWJQY3NiQXA5YzkwMjRVblQ1N3JmL0RNUWt6Ykg3M3Zk?=
 =?utf-8?B?d1JHcTdYZkV3em0yZGkzbXRLLy9WcVozV29wL3ZMVlJ5ckNZUnVmQWtrRlkr?=
 =?utf-8?B?SFEzR0pOYkFId3A2dDN5OFYyRFRLT2U2VUVlRFZZSnhuVkRmNDNzVlJJcks5?=
 =?utf-8?B?ZVVvTjBYOUF3eVRGVlQ2aGVjSUxaRG84YjJOLzRVSHdYeUw2N1JRTmpIbFBB?=
 =?utf-8?B?djAyaEk1dDY4R2pRVDg5bllxYis3K0dZQ3RJdHhMbTZqZHIxb3RQWEpWdFpN?=
 =?utf-8?B?eDNINDJrZnlPWnJVck9RNFN3Y1Y4d0tac1JRcDNYWnV0OHFPdEVFRTAzV1hY?=
 =?utf-8?B?NloyZG5kUDZXY1FiTUxWVHU0a3QxN2VITFJHTVNvVHhvZjR1SmNJUXlCc05B?=
 =?utf-8?B?SS9hNDdmcUVhRlhBQjF1UW9UemRGMnZNVmdYK3AyaUNMZmcvek1TTHBkeXR0?=
 =?utf-8?B?Tk1aQmhjSkRDazFhMzMyTjFPVWI2MEh2NHZHbzYwUm5MR1J0N0dEd2lzUklO?=
 =?utf-8?B?ZTduMk9oVmYyUWdOOEw3bUJURkNEdmtkUGVibHpDTlMvbjdSRFI5YmhGam5M?=
 =?utf-8?B?M1ZVUnZZUm9zRFVjREFOR3pRSUxkYmNVVWNpcHNXZzZyTDhzOU9pWEZkMXla?=
 =?utf-8?B?TW5TQjFNakhvY0o5dDQzdTlyRXlHUU5yemhBOVVCZElVQUlBaSthNkJVSisv?=
 =?utf-8?B?czBaS2Q2OVJWRjkrTlZTbzZwMURpdXBGZ3R0eUhCejkrZGhuRkZWUlNXc2Rh?=
 =?utf-8?B?LzY4WkMyZk50Nk1GaUJ3VlRLWTcyWjFHcnpVaFlKQzJyb1NqSmFsR0dYUzFS?=
 =?utf-8?B?R0N5QzVGeFRJR0syS2cwUWZpNTBJMm44VEVTWWUzWVc5N1A5S2VQeU9iWG9t?=
 =?utf-8?B?TVZEWXZLMWc3VXdKQ1REYUE5Rm9ZMkFJRFM3YWhicDhwV2J1MUQ0NXgxWVVH?=
 =?utf-8?B?QUZYbTI5WEFpdTEzZkRBZmtZR1FqYlN5M3FhVnJwMldtelZSb20waWdnN0xu?=
 =?utf-8?B?QzY4WFAyM1UvWWdQLys4MVJHeG9BRDRsMVBZbVVoLzFaWGE1blhXdjgwZW5V?=
 =?utf-8?B?Zk14NHprMWRqT3RwRmRVUkJSVTRwaGhxYWQyajNXbHZiUEd6bTJoOS8wQW00?=
 =?utf-8?B?NUlrYzNOWmhxYWZKQStxSTRtQlBVY2IrRnAzTXg2UWZiUmxoUkp0WFM4R0xO?=
 =?utf-8?B?bGkxaHI2SmMvdGJKNGhVekFZNXpkRUw5cHU0OXgwRUtkay9iU0VKVkVYNXBW?=
 =?utf-8?B?NzhDMnZvaUpERURzWUk5RndQL0pWRGFjOXBoMVZzNFlUOFphMW5QRmlWTVdC?=
 =?utf-8?B?SUIvM2JjdUkvZnBZcWVyd1FWaUtzcEk3MU1uSVdKT2UxVTRaUXlHUnJjcDZS?=
 =?utf-8?B?TzBXK1p1angrQkFmb2plaUMyeWF6MEY3bEV5YnRhK2l2eTFtOGp3VzhnL0Nv?=
 =?utf-8?B?Z0I4VDFPVGVWRG9aeE1ZdWljeER0eHBETFJVbmxoT3k5VlgzQlhaYnMxZ3Fm?=
 =?utf-8?B?T2ZIclpsa0lGNXNXdUwxb01KU0U1Qi9kVHdSMW5Mam03UUdpT3k4NjJucE9z?=
 =?utf-8?B?R2RXUDJnZlptTzdGMW5yb2M1VjZGR01aZ09nNmhDYzRCYURnOWRYdHJJNkpi?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73EFEFA41D3DCF429EDFDA0E03AD9B48@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ad3ffe-7e43-4933-2ca0-08da6ead115f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 02:18:02.5881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pnp4Y0OYAiC7FIGBZQapVQFF7zDyVcBW3Xm9i9Q1lqFh2A20PoPbTN1kokvbZkOvuRntTvDvEIIIbz36rHRNRJNy27ij9z/4agdwlbB3StY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4053
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

DQoNCm9uIDIwMjIvMDcvMjYgNTo0OSwgRGFycmljayBKLiBXb25nIHdyb3RlOg0KPiBPbiBNb24s
IEp1bCAyNSwgMjAyMiBhdCAwMzoyOTo0NlBNIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4+
IFRoZSBvcmlnaW5hbCBpX3ZlcnNpb24gaW1wbGVtZW50YXRpb24gd2FzIHByZXR0eSBleHBlbnNp
dmUsIHJlcXVpcmluZyBhDQo+PiBsb2cgZmx1c2ggb24gZXZlcnkgY2hhbmdlLiBCZWNhdXNlIG9m
IHRoaXMsIGl0IHdhcyBnYXRlZCBiZWhpbmQgYSBtb3VudA0KPj4gb3B0aW9uIChpbXBsZW1lbnRl
ZCB2aWEgdGhlIE1TX0lfVkVSU0lPTiBtb3VudG9wdGlvbiBmbGFnKS4NCj4+DQo+PiBDb21taXQg
YWU1ZTE2NWQ4NTVkIChmczogbmV3IEFQSSBmb3IgaGFuZGxpbmcgaW5vZGUtPmlfdmVyc2lvbikg
bWFkZSB0aGUNCj4+IGlfdmVyc2lvbiBmbGFnIG11Y2ggbGVzcyBleHBlbnNpdmUsIHNvIHRoZXJl
IGlzIG5vIGxvbmdlciBhIHBlcmZvcm1hbmNlDQo+PiBwZW5hbHR5IGZyb20gZW5hYmxpbmcgaXQu
DQo+Pg0KPj4gSGF2ZSBleHQ0IGlnbm9yZSB0aGUgU0JfSV9WRVJTSU9OIGZsYWcsIGFuZCBqdXN0
IGVuYWJsZSBpdA0KPj4gdW5jb25kaXRpb25hbGx5Lg0KPj4NCj4+IENjOiBEYXZlIENoaW5uZXIg
PGRhdmlkQGZyb21vcmJpdC5jb20+DQo+PiBDYzogTHVrYXMgQ3plcm5lciA8bGN6ZXJuZXJAcmVk
aGF0LmNvbT4NCj4+IENjOiBCZW5qYW1pbiBDb2RkaW5ndG9uIDxiY29kZGluZ0ByZWRoYXQuY29t
Pg0KPj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4NCj4+IFNpZ25l
ZC1vZmYtYnk6IEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+DQo+PiAtLS0NCj4+ICAg
ZnMvZXh0NC9pbm9kZS5jIHwgNSArKy0tLQ0KPj4gICBmcy9leHQ0L3N1cGVyLmMgfCA4ICsrKyst
LS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9leHQ0L2lub2RlLmMgYi9mcy9leHQ0L2lub2RlLmMN
Cj4+IGluZGV4IDg0YzBlYjU1MDcxZC4uYzc4NWMwYjcyMTE2IDEwMDY0NA0KPj4gLS0tIGEvZnMv
ZXh0NC9pbm9kZS5jDQo+PiArKysgYi9mcy9leHQ0L2lub2RlLmMNCj4+IEBAIC01NDExLDcgKzU0
MTEsNyBAQCBpbnQgZXh0NF9zZXRhdHRyKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJu
cywgc3RydWN0IGRlbnRyeSAqZGVudHJ5LA0KPj4gICAJCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICAg
CQl9DQo+PiAgIA0KPj4gLQkJaWYgKElTX0lfVkVSU0lPTihpbm9kZSkgJiYgYXR0ci0+aWFfc2l6
ZSAhPSBpbm9kZS0+aV9zaXplKQ0KPj4gKwkJaWYgKGF0dHItPmlhX3NpemUgIT0gaW5vZGUtPmlf
c2l6ZSkNCj4+ICAgCQkJaW5vZGVfaW5jX2l2ZXJzaW9uKGlub2RlKTsNCj4+ICAgDQo+PiAgIAkJ
aWYgKHNocmluaykgew0KPj4gQEAgLTU3MTcsOCArNTcxNyw3IEBAIGludCBleHQ0X21hcmtfaWxv
Y19kaXJ0eShoYW5kbGVfdCAqaGFuZGxlLA0KPj4gICAJfQ0KPj4gICAJZXh0NF9mY190cmFja19p
bm9kZShoYW5kbGUsIGlub2RlKTsNCj4+ICAgDQo+PiAtCWlmIChJU19JX1ZFUlNJT04oaW5vZGUp
KQ0KPj4gLQkJaW5vZGVfaW5jX2l2ZXJzaW9uKGlub2RlKTsNCj4+ICsJaW5vZGVfaW5jX2l2ZXJz
aW9uKGlub2RlKTsNCj4+ICAgDQo+PiAgIAkvKiB0aGUgZG9fdXBkYXRlX2lub2RlIGNvbnN1bWVz
IG9uZSBiaC0+Yl9jb3VudCAqLw0KPj4gICAJZ2V0X2JoKGlsb2MtPmJoKTsNCj4+IGRpZmYgLS1n
aXQgYS9mcy9leHQ0L3N1cGVyLmMgYi9mcy9leHQ0L3N1cGVyLmMNCj4+IGluZGV4IDg0NWYyZjhh
ZWU1Zi4uMzA2NDVkNDM0M2I2IDEwMDY0NA0KPj4gLS0tIGEvZnMvZXh0NC9zdXBlci5jDQo+PiAr
KysgYi9mcy9leHQ0L3N1cGVyLmMNCj4+IEBAIC0yMTQyLDggKzIxNDIsNyBAQCBzdGF0aWMgaW50
IGV4dDRfcGFyc2VfcGFyYW0oc3RydWN0IGZzX2NvbnRleHQgKmZjLCBzdHJ1Y3QgZnNfcGFyYW1l
dGVyICpwYXJhbSkNCj4+ICAgCQlyZXR1cm4gMDsNCj4+ICAgCWNhc2UgT3B0X2lfdmVyc2lvbjoN
Cj4+ICAgCQlleHQ0X21zZyhOVUxMLCBLRVJOX1dBUk5JTkcsIGRlcHJlY2F0ZWRfbXNnLCBwYXJh
bS0+a2V5LCAiNS4yMCIpOw0KPiANCj4gUGVyaGFwcyBpdCdzIHRpbWUgdG8ga2lsbCBvZmYgT3B0
X2lfdmVyc2lvbiwgc2luY2Ugd2UncmUgbm93IGF0IDUuMjA/DQo+IA0KPiAoRm9yIHRoYXQgbWF0
dGVyLCBub2FjbC9ub3VzZXJfeGF0dHIgd2VyZSBzdXBwb3NlZCB0byBiZSBnb25lIGJ5IDMuNSBh
bmQNCj4gdGhleSdyZSBjbGVhcmx5IHN0aWxsIHRoZXJlLCBzbyBlaXRoZXIgdGhleSBvdWdodCB0
byBnbyBhcyB3ZWxsPykNCg0KRm9yIG5vYWNsL25vdXNlcl94YXR0ciwgaGF2ZSBzb21lIGRpc3Nj
dXNzaW9uIGluIGhlcmVbMV0uDQoNCkFsc28sIEkgd2FudCB0byByZW1vdmUgZGVwcmVjYXRlZCBm
bGFnWzJdIGJ1dCBzZWVtcyByZW1vdmluZyB0aGVzZSANCmRlcHJlY2F0ZWQgb3B0aW9ucyBpcyBi
ZXR0ZXIuDQoNCkkganVzdCB1c2Ugbm9hY2wgbW91bnQgb3B0aW9uIGluIGx0cC94ZnN0ZXN0cyB0
ZXN0IGNhc2VbM11bNF0sIGJ1dCBzZWVtcyANCm5vbmUgdXNlIHRoZW0gaW4gYXBwbGljYXRpb24g
YmVjYXVzZSBub25lIGNvbWxhaW4gYWJvdXQgdGhlc2UgZGVwcmVjYXRlZCANCmZsYWdzIG92ZXIg
dGhlIHllYXJzLg0KDQpbMV1odHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1leHQ0
L21zZzgyNTA3Lmh0bWwNClsyXWh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9s
aW51eC1leHQ0L3BhdGNoLzE2NTQxNjQwOTktMjE2NC0xLWdpdC1zZW5kLWVtYWlsLXh1eWFuZzIw
MTguanlAZnVqaXRzdS5jb20vDQpbM11odHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2pl
Y3QvbHRwL3BhdGNoLzE2NTg0ODU2NDAtMjE4OC0yLWdpdC1zZW5kLWVtYWlsLXh1eWFuZzIwMTgu
anlAZnVqaXRzdS5jb20vDQpbNF1odHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9mc3Rlc3Rz
L21zZzE5NTU0Lmh0bWwNCg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1DQo+IA0KPiAtLUQNCj4gDQo+
PiAtCQlleHQ0X21zZyhOVUxMLCBLRVJOX1dBUk5JTkcsICJVc2UgaXZlcnNpb24gaW5zdGVhZFxu
Iik7DQo+PiAtCQljdHhfc2V0X2ZsYWdzKGN0eCwgU0JfSV9WRVJTSU9OKTsNCj4+ICsJCWV4dDRf
bXNnKE5VTEwsIEtFUk5fV0FSTklORywgImlfdmVyc2lvbiBjb3VudGVyIGlzIGFsd2F5cyBlbmFi
bGVkLlxuIik7DQo+PiAgIAkJcmV0dXJuIDA7DQo+PiAgIAljYXNlIE9wdF9pbmxpbmVjcnlwdDoN
Cj4+ICAgI2lmZGVmIENPTkZJR19GU19FTkNSWVBUSU9OX0lOTElORV9DUllQVA0KPj4gQEAgLTI5
NzAsOCArMjk2OSw2IEBAIHN0YXRpYyBpbnQgX2V4dDRfc2hvd19vcHRpb25zKHN0cnVjdCBzZXFf
ZmlsZSAqc2VxLCBzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KPj4gICAJCVNFUV9PUFRTX1BSSU5U
KCJtaW5fYmF0Y2hfdGltZT0ldSIsIHNiaS0+c19taW5fYmF0Y2hfdGltZSk7DQo+PiAgIAlpZiAo
bm9kZWZzIHx8IHNiaS0+c19tYXhfYmF0Y2hfdGltZSAhPSBFWFQ0X0RFRl9NQVhfQkFUQ0hfVElN
RSkNCj4+ICAgCQlTRVFfT1BUU19QUklOVCgibWF4X2JhdGNoX3RpbWU9JXUiLCBzYmktPnNfbWF4
X2JhdGNoX3RpbWUpOw0KPj4gLQlpZiAoc2ItPnNfZmxhZ3MgJiBTQl9JX1ZFUlNJT04pDQo+PiAt
CQlTRVFfT1BUU19QVVRTKCJpX3ZlcnNpb24iKTsNCj4+ICAgCWlmIChub2RlZnMgfHwgc2JpLT5z
X3N0cmlwZSkNCj4+ICAgCQlTRVFfT1BUU19QUklOVCgic3RyaXBlPSVsdSIsIHNiaS0+c19zdHJp
cGUpOw0KPj4gICAJaWYgKG5vZGVmcyB8fCBFWFQ0X01PVU5UX0RBVEFfRkxBR1MgJg0KPj4gQEAg
LTQ2MzAsNiArNDYyNyw5IEBAIHN0YXRpYyBpbnQgX19leHQ0X2ZpbGxfc3VwZXIoc3RydWN0IGZz
X2NvbnRleHQgKmZjLCBzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQ0KPj4gICAJc2ItPnNfZmxhZ3Mg
PSAoc2ItPnNfZmxhZ3MgJiB+U0JfUE9TSVhBQ0wpIHwNCj4+ICAgCQkodGVzdF9vcHQoc2IsIFBP
U0lYX0FDTCkgPyBTQl9QT1NJWEFDTCA6IDApOw0KPj4gICANCj4+ICsJLyogaV92ZXJzaW9uIGlz
IGFsd2F5cyBlbmFibGVkIG5vdyAqLw0KPj4gKwlzYi0+c19mbGFncyB8PSBTQl9JX1ZFUlNJT047
DQo+PiArDQo+PiAgIAlpZiAobGUzMl90b19jcHUoZXMtPnNfcmV2X2xldmVsKSA9PSBFWFQ0X0dP
T0RfT0xEX1JFViAmJg0KPj4gICAJICAgIChleHQ0X2hhc19jb21wYXRfZmVhdHVyZXMoc2IpIHx8
DQo+PiAgIAkgICAgIGV4dDRfaGFzX3JvX2NvbXBhdF9mZWF0dXJlcyhzYikgfHwNCj4+IC0tIA0K
Pj4gMi4zNy4xDQo+Pg==
