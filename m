Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF014CEFF2
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Mar 2022 04:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbiCGDHM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Mar 2022 22:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiCGDHL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Mar 2022 22:07:11 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B89F42EF2;
        Sun,  6 Mar 2022 19:06:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEjit08BxpJBfh/W0dX1hslqNSnR5M+PnII1f6BMBPI3GPV4AZG8IpLtC9raSU36JDlKA4PPk1LSHBPSokOer2Z5I625QkC9AX8Hhl9hqTlapGG3uApCICzk6BXjofm3y1Kq/4NUiXS3A4lugmLdR13ZoQsQgQ/RspKGxjDstE2S6tN5WVVrZi1TNRBBAy7/qmYJiyz32uNAQtEOW3fqpxzKJTpqYuqrscdHThSbv0ffS2e63HAUX7jcTvNY/g1QKwXcnp050XZMWnlYvYKILMKifrc4U81tWCdb78/Dqy+Y3Oi50Dbjw6XuwB5X66TkRMUlRDfqfwvfXvThUs8viA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UNjSo6K0ixjAUs6vpajGrqAdKmv2OyjMdNojVm1JnM=;
 b=bTw/4+Qa6j4f+bW55u5Q+kgbKMiYmAVNspKrqvL5kosivwcmBSwzvrMOusWpETfkHqpgY4iOAl1euCtPWiPz1Q59+qTNCORM2fXd8fdXBn0NrNHxbmihEtx7iunVKQYg/e5Yt+iW7vipxcsbAOQIqXGPA7jn9q15e9mBePdtOKxRb9i8UFZmCa1ruarx+4HNbK6hAr8qVqzLX94N+RXaxqQLWPqprGJjuT6p8QEnn57eJjSoGOW63/e5KOyp5FIZNTm7J8hX3TzS5GNJedlYPlLXOO5PYL0zZjVZP3P0BPdoFgG3sLba0FiyXdAIoQmiuW5CUyrTSPw78khCyyE1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UNjSo6K0ixjAUs6vpajGrqAdKmv2OyjMdNojVm1JnM=;
 b=NtBu6IXlF6IFMM2Y5zt5B3umQi0KxbMQgqQM6Z5tlSugpifm+KmtllenklNcHDJf4cfixm806M0HtVVvbTrez+tWB1WzeqmNOxW04V/uPBk+XHc0EFPMJBv/M5ssTgfJNc3XYa5QrnwVfiAp5dKrHYCIT5m9mZGQ3Daj8mh6FxsQvuog1E8YxNtqYWotrZ4TqNrZRJpPFrIl18ik/D6Oh/OHSdYwiWExxcPsZk/VBW7vM7n4OWj532EHCSs8G8g/11N8RIawjtRvRztD2flckBUNgBWdW0wP/ui51MyinA5UGZFFofb9svpjj2O6oTLh7tQEFYtGlbEgN0yHVgjXHg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1853.namprd12.prod.outlook.com (2603:10b6:300:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 03:06:16 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 03:06:16 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 07/10] raid1: stop using bio_devname
Thread-Topic: [PATCH 07/10] raid1: stop using bio_devname
Thread-Index: AQHYL/HtKtbBwweIHEqS3x4/5TG2+KyzQLoA
Date:   Mon, 7 Mar 2022 03:06:16 +0000
Message-ID: <6b21fd51-632b-3026-464a-9c0fd91c2bbb@nvidia.com>
References: <20220304180105.409765-1-hch@lst.de>
 <20220304180105.409765-8-hch@lst.de>
In-Reply-To: <20220304180105.409765-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cf33e3f-00b9-426f-e2a9-08d9ffe77240
x-ms-traffictypediagnostic: MWHPR12MB1853:EE_
x-microsoft-antispam-prvs: <MWHPR12MB18531256C15CBAE6B4EFFF5FA3089@MWHPR12MB1853.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TC+EMY6znUDU0omDhvUt7cdqBB5+bvSQH52jLGUwEp2HpAnA5GphtBJs08PWGc23HT4SDpowYEJtoKepuwRt7z39c5I9mBThsqwlos24LVd2ksFzQDNR0sxCBlIGyijLWZXFzMSAmbK0n8HwdTJ04sL6lTOLqAaaDMHbrX9R5aIlHwg0oxgOt+SVoKodTcEejCUyYFbYt64Tmvy2Q31Xj9384dBvYsQ5pny3Y/YOARsp4f9AUkEsLNTQ692EZc2WYcQWJyVCKME8eoWk/ze3Gau0Nv0f9Lajp+0wL4XspBUuIMyjIkzq+IL4wrFwT6JKNX15t9hHR5lsFx3CYJ4wSOMirCC0ppdi0dAK3/xBMro7OqBtc7IwSqId+9kaXMC/ZSPdXRRRoj3nfOleUMcX7gk6880xwmBTKlD9cKJm/0sPjTdVLOP5bCV9uRuo09tD+IPlCVKkz/7W7Qy4/TWrcQrgmEVDDuTvsvKc8KKm+MK9Mh+kHSqb0o5Ka8fPhkMqwmmTAu+DMnSVFn3CA4ScX2xjV2aPdd3WjfxkyeiGrGNafvEJ78ROxLl3gW3daZZS+p2UIm9i/J6eCTGTvqvXrrp919+u9b+iNjlZDAsEWi88ykD3/cS6CbYM3S7ZKOAtnRWUyQrBBi4G3PJyAKmeFdkb25/rOI6DAx71F6szDXlBJE9ImGE+/re5dd6lwxrAyOLV/fKbGjXO8em4G2UdqNNujCGkronEqRA7MmbJkE4kxGj4ZCNIunh6x3D+Gvk8LJlVhXCgJP6CQlF01fybDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(4326008)(8936002)(31686004)(53546011)(66476007)(66946007)(64756008)(66446008)(8676002)(54906003)(186003)(5660300002)(36756003)(110136005)(31696002)(6486002)(86362001)(122000001)(2906002)(71200400001)(2616005)(6506007)(6512007)(508600001)(558084003)(76116006)(38070700005)(316002)(91956017)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFRvbUtzR0VMdnNZZDdaNG5kNWRmempzTU45d2g4cDZTazFSOWZPdEZrbEgr?=
 =?utf-8?B?YUwvdlhpQm4wWHF2aFhTYVVJYVEyaHdWME1JQVdJVUxpYnM1Q0Q0ajBCcEta?=
 =?utf-8?B?QTRHUjlFL2VaUFRYTEN0ZEVhVmQ3RHRpWWlqRlpvUDVzS2x6ZWhaSDh6czBC?=
 =?utf-8?B?ZXdvdElxaGJyRFhYa2d1Y01pOXdXeFhMTS9qSUNTc3MzUmdXa2EwMDArTFFl?=
 =?utf-8?B?aHdsMkxoN2pCbHBQOTBqVmdKeDZGTllvZktCM0dPei9kUk5vbFIxaUdZL21a?=
 =?utf-8?B?SHcxaGtvZFJoMmowUlRQWEV0S21yZCt2TGphMlVxb043QkhWbHZvY1FjdU9o?=
 =?utf-8?B?NDJzaXE3MVltL215Tjl6VDBWNnhRRWpUZVd3RjllWGp5QU5Bakg2ZHJ0NkV4?=
 =?utf-8?B?aGJtUFJrKzNiQ0ZicVYyQUMxUzJURHJEajlZc2g4ZWhNa1BvRU5HeHBvT2xp?=
 =?utf-8?B?OTlSSHlnaTlObzVjOEp3Q0RDZTJPOWRrMmZrVjhLNTNtRGl6aWQ1MUVUR2Vy?=
 =?utf-8?B?c2lZNTFNd2w0K2lGZlI0UmcwbEZ1QmVjNVpxdUZJdFVhdk5zVi9YQmdhT28w?=
 =?utf-8?B?YmhaRDZvdjRrN016Y1RxSE8wdjlDSHNKUlYrd0JkQ2JQSHd6Wit0cVBJNWtK?=
 =?utf-8?B?bGpaa2M5YTlRWFZLUVkzK3VDZytNajBhRElhd2l6ZDZsejFSMUcxS3hMYy9y?=
 =?utf-8?B?cmplOTNHT2c3b0ZQWW04SFFmMzdpOURRb3JnRC9tVHI2UGNydndKc0U4QStY?=
 =?utf-8?B?R3ZySGNVTkt5TDFqMlRUNy9DRmFlNUxYNUxCTEdVeURRMmN1cmFzUE1SMGdw?=
 =?utf-8?B?OFhETksyRGloVUdwTmk4eWI3cTlaa0c1YkhWelNYMDJlbXV3NzRxUzBjUUl6?=
 =?utf-8?B?SHU5a1gzZTI1cUE5QWd0SnpENnpyeWZwM1FVdGlmN1p5UWVybUJnYWtDOWdG?=
 =?utf-8?B?WDByS1pyUHd4ZFI1R21JcHFJS05Vc0krd2Y0dHcyV0VUSTBoeGdWN1paS215?=
 =?utf-8?B?bFRYNnloVzU5R0xrdkFpZ3NZMzdObXQybE9SWWxYbHVwekN5VXBrMXFwa0k2?=
 =?utf-8?B?SjVaeThJT2c1RWx3UE9yYSs4M3dmSHJSVlBHeEFBUk15ZCt1YWd5WmRZNTFu?=
 =?utf-8?B?dy8vUnhQZ1lURHRSdGhoZzRLQ3hMKzUra1VjWGRLK2tnOCtTdVU1SVQzLzFV?=
 =?utf-8?B?YjRMLzBvVXU1ZVM3WjQxU3FFT0Z2RkFOc3llbmhDOHR1MWJHbXY3MEFWMEZ0?=
 =?utf-8?B?MjU4dlpOMzhyVzhXdkN6Y3NBcHlCUkE2bHY0MHNBM21vaUo4bGRpdStzdWMr?=
 =?utf-8?B?T2J2VHliTFlnbVc3MVErKzFuMEdrWE8rdklFQTlkdXNRZjQzbzRNMGE0b0w5?=
 =?utf-8?B?ODY0N3U3VlRsS0o4NGNoc3J6aDJQbjIzVHVBQ1JTMTc3cm9NK2J2VGNLMTY5?=
 =?utf-8?B?eVFYa0lpbGNIRHRBY1FGbzZmcnBSaThzL2Fhd0ViTU8xZHRLaCthdUg5Yklm?=
 =?utf-8?B?b01DdmVZenBoMHpUR3dCMFFiS1Z3V29WRHRYRGZQNE4yOXg2ZC9ZUllLdjBJ?=
 =?utf-8?B?eHVtMmJOTksvb3kwMFd1SVZ6R2cvREFPekk3cUh4U1lNRzEzQ3k4ODcrZjJF?=
 =?utf-8?B?Yy8xdlJtTmR6U2VESjU4R3o2UDVNVDZ2VWVDY0t1a1djYnAwV2FiMllTV00r?=
 =?utf-8?B?TzBkd2dQelVicDdUenppaG1aTTVrbmF0VUpLQ1E5WXk1R2dRRklPWVlmSHBl?=
 =?utf-8?B?eXU5QlZacmZJRnN3eDNtQkU1V0Q2alc4MzJoVVA5UXE5UVBxQ3RZSjB1WDRX?=
 =?utf-8?B?NFFVejZFTnRiUEIvK1hqbjhMTGxUSHp6RU5GbnFDMXZEQytOYnB5UEc0S1NK?=
 =?utf-8?B?V0d6dVNvdEw2Tnk5QmxuMDN5L2xpZ1dyVkdaRVpjaUp5blV4Z2ZNRTRLTURh?=
 =?utf-8?B?ZTRiWUFYMFhXWjQ5NjErRmFvNU1wQS9sQzhkeHFMZXkvMWNjTUwrVStwaXNj?=
 =?utf-8?B?RWNIT0Z4UDJiQXpCWlJwNlBSYWFVSGMzSEh1SmFDV1NzZDZXL2p1RTZNVEpV?=
 =?utf-8?B?VHp5amhNVmZuNXlTdWZ0SEZtNk9kSGJ6T0NYY20xU0xmbkRtZDZSZjd6Mmg2?=
 =?utf-8?B?VldVbGk3SjVsS0c2akl0YUxSbUpUenY5U0FGTDdXSmdzMmh0cC9GdTNWWEEz?=
 =?utf-8?B?ekRheGFpM1J3QS9rbUNJUlJ1OXF5elUvMnZublJjVU5RS05Hek1nRms3Mjg5?=
 =?utf-8?B?NkVzMVJ5eHlVTEVKMnBxbk9mc1h3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB0457C095F05A41961B52361F4EB1D1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf33e3f-00b9-426f-e2a9-08d9ffe77240
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 03:06:16.7769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aBZN4LMp+GaEovagHOKEAu9yFu/i7HIdBWGKBZXtJLt2VV6WVeIEnFYz0vCeCL8uiQbixCe+zI8uf9b4b5lcdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1853
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

T24gMy80LzIyIDEwOjAxLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gVXNlIHRoZSAlcGcg
Zm9ybWF0IHNwZWNpZmllciB0byBzYXZlIG9uIHN0YWNrIGNvbnN1cHRpb24gYW5kIGNvZGUgc2l6
ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0K
PiAtLS0NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=
