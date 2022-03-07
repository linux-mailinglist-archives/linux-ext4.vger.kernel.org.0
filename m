Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DFE4CEFFA
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Mar 2022 04:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbiCGDIH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Mar 2022 22:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiCGDIG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Mar 2022 22:08:06 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC15F42EF2;
        Sun,  6 Mar 2022 19:07:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cByfbSv6d8sU3+9K4i1Ic91KQkTGyByXYdEtDp7i4hAaSAqNRUYOLmWBVifHHiXY8DtunHGzajtFyQ/sSQA8z3CKult+RMTq0zTEn8/RTRfHBnXzpJzPyDmfM6gDnCfuADAlfpkes9AMESy6lhf8xPnW7e+pq8CVimbly16ZRXa2CJ6cdQu+G4483tOM/jBfI/FBY/fYpQTN7BFmondoeDJ39Q6YnY8S8lNTqX0t2Op4wGzbOUCB/B4qAFdtyqBcpwGo4ErIWHe13GasuoaMofMEQ7fMksCfTwQ9ENdv7SfNA3lBmtUFNrWcAOjnP/8EhtsLPG8xxGo1CQdmwfFXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9Lq2TD3FApVHXPs0CyAc8+2p+/2v9aCx7WYEZNbjHk=;
 b=dRPgk2HNNTG5HjqV3oqR81yU34EjUXX68wtAqlLhita7QMBNmR2gZbKCA830gRG8LiJr0DBp9Wn9ny+iFwAobQ/H9+JY32sm1bfk6QrNnQJZ1K8A8qmSvjrYyFX2vEB8PH5gn6rXKoMFHRI98E8Cv/GOmsVgWKPlwXJR++RsyDLniqz8WZT2lXwclNZ0fEOS4tdhq8BcpkTYMjQdt9BDGIup/nE8Mku00YoYW8w3PuUfoH20qbtFAUWFm4vp+JCJo5L2t1UcYLyRRuGSLwcgABaVBfVZN6aBs1CBTgdg7KfuKY/jyvZb4lsX4AqAZPlSxM1bMgX+KB6sWkqSmWpSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9Lq2TD3FApVHXPs0CyAc8+2p+/2v9aCx7WYEZNbjHk=;
 b=PH6Mnz2AqgvyfGJRheqJ7TUlIgxtMOM3qN3EFEd0CSvWeVQyU4CMsXvfolIscIpjOMm4RMVhZBxYS3rxw7SCcoAKIvwi4VMmMY20oBT3UF8wVDhJ5rvI6dj+PT0HphfQej7ViTcDOsyo6DDO+7qdWK8APJHP/DvKL/B2KA8pZvb0D3gvwg5AoWZYC3nz2S56h4/rYvWoLL+5CuQ+RLd5Nt58onsrG/LdwvWNSPlkTHeNFd0HuHoHLlvnaMgb0df+QswQNBcYRrqMbWKfLKQuZFwh3Sy3zZlMgasC/TzjBDzNFs6xRvTK3GVcDMuOypP8R1M1DlsvV7/3fY5YOJxIRg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1853.namprd12.prod.outlook.com (2603:10b6:300:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 03:07:12 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 03:07:12 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 04/10] dm-crypt: stop using bio_devname
Thread-Topic: [PATCH 04/10] dm-crypt: stop using bio_devname
Thread-Index: AQHYL/Hg7vmeF37UxkSFxnATAL00G6yzQP0A
Date:   Mon, 7 Mar 2022 03:07:12 +0000
Message-ID: <34c280c3-6597-721c-5e12-a1f55cab121d@nvidia.com>
References: <20220304180105.409765-1-hch@lst.de>
 <20220304180105.409765-5-hch@lst.de>
In-Reply-To: <20220304180105.409765-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9974429e-a261-439a-dabc-08d9ffe7936c
x-ms-traffictypediagnostic: MWHPR12MB1853:EE_
x-microsoft-antispam-prvs: <MWHPR12MB18536C072C094E7BC8BDF9ACA3089@MWHPR12MB1853.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RistBQz4QDikRY5anYkn/Wmuxyjx9SPg1mN+WSXqzsKswApcUmhsux9VS7zpenhBCJvM0jVSsSHSQKP2qnzVMmpLOFU4aDKiGg1qC93EfnGh0MlkogGu3hVUFVrfFD+lgdr1k0MddeXqdMtOx0zhG3kmdyAUnOrEVPAjRZTEwumTOlN6wuKhsa3d9Rt/vNRfpOSj7mlrLGzUB5gebsAMN3IoJWzNJKzOWr/+beUeIWtP8SDXIupEieKyadXV3Uc0o2QF7aJKsohqIrBK4vb5FdBmZcU5OWi1W0x21dt3KdAnjD7HiFhMa06NnHyka34/UQ6391a3PcVc7dpPzjcaKY3za4asZJPnkiBDjp/ct8F2sIM6rFOZKdyV7S5gMJJ8T1710ibpjR48Zla56XTeLLAeO5rEghlknR/4z1O37XoVWahx/iNj0JZkt7vXCocgcRS5CnQAHcpmv9pYDvTjUVwJGtuNC9EEQRzMgLId7pGNd8We48413RbcaXPzfgwyGmCGTQ4z6nPdDxgSQh3/8EtVS125DFmVMSOQE6CE2w8aixANbE0GBmnrRvpOsIPNb5mFGsHSTPI+YLi0nZbbQdkjQ2LWlR/CHYWmpD9mFVyp88JPRT7RM1dyzVX8wIxvwvD5njgwE946dPPeapHrn6Mla5L7rOFr1drV2JD5Khs2xoeP6GHsJtvFy2G111uJzDIc6oJ0gvJVcz/qq4hpcwhTOwY3Xk0/XYfgp3e/dc1mnxaJeH/wHXDB7HhW/1tq6cHdF76coZTnNMx46b7OSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(4326008)(8936002)(31686004)(53546011)(66476007)(66946007)(64756008)(66446008)(8676002)(54906003)(186003)(5660300002)(36756003)(110136005)(31696002)(6486002)(86362001)(122000001)(2906002)(71200400001)(2616005)(6506007)(6512007)(508600001)(558084003)(76116006)(38070700005)(316002)(91956017)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjNlUVFKaTVQbkJrOWdHK1NDVmJFSDNOc0JHK1c1T2dZZXJNZnliNGQ4OFVJ?=
 =?utf-8?B?b1RtNitGTGlWZXJJZkFWYVdvOG5wVTF2WktoYlJBMEN4aUl3YWV5NUlZdFZD?=
 =?utf-8?B?eUc0M29tdWUwdlp5QU9uQTgxVDk1UXV1TzJURmdkLzRqUUxXWUk3Y1R0NnQr?=
 =?utf-8?B?blVsU2xBZ1NBTG1BNDAyVVFBelV3WGF1Z0xrVk0rMVdxdlB1b2JLOXR3Wmc3?=
 =?utf-8?B?R3c4SHRuS2JUbDBod1BBM3dsb3NOTFAwZGVHcmR5UXVNaC93eVltaDQrVE9n?=
 =?utf-8?B?UjUzUTlmMUc0ZUNnZndXRC8vUWVHVkdQNnhqTnlSWHExZGtzR3VTWUFsZ1FZ?=
 =?utf-8?B?aW4vN2J0Sk1RbDZwVGsyVEIwOEJ0ODFEVXJXVFJIcE92R2xodDB0OGtEL2Yy?=
 =?utf-8?B?R1NqTUhkMlA4TEJ1M0ZhMTBFaS82TU4rSFpjM3lpcCtwNzM0cFVGWFcrWDdU?=
 =?utf-8?B?Zmo1VEpGR0JGMS9QckJnaE84N0ttTzRLL3krcytCbk5qTU15cmd0VmllV29T?=
 =?utf-8?B?MnJvTTNNM3dPTTlRTXBLQ01PUzVUNk53TjRPbk5RRUwrVGtWSFhxV3dVZzFO?=
 =?utf-8?B?SUVXcUNoSytURlNwVlFWYVh5ZFFnVXpuc0U2ZzVqMjhGdzQ2bmN0Z080dUdZ?=
 =?utf-8?B?SGQvYlRIY1BsbnZmYlVHWEF6NERUTVpELzF1QTc4aGE5cWNiUjREREVYYkxM?=
 =?utf-8?B?RHdLK2E2Z25WSHBDbURQaXdBVUpLK3F6aU1DcEgzZmZZWmNpNGsreDNsa0Nu?=
 =?utf-8?B?TDY0ajhTTWR6SUFtQkxvV1RKQllVVGtLUVZaQS8yZmRQazZwN05oNWdmSy91?=
 =?utf-8?B?Q0F2SFNKb0puQW50K0M1aHoyMTgrV1VYcllRZWpybTd1WGZkeXp0MTF2Nk5R?=
 =?utf-8?B?Um9xN2MrbzNveGd0WncyK2MydTVrSTU4bWNld0YzSHJ2U01TcnNocWQ3OW9h?=
 =?utf-8?B?UnVGZkRjN0FSbE1NbmlLV3lPTFQ1c2dnYjRtTlJvTG82VUVZQlJGbjZGdGpD?=
 =?utf-8?B?OWJVenFueGk4TlIzTEhHVGtHY2UrZXlCY3owYWdVTm11YWtOVmNnOEx6MTdY?=
 =?utf-8?B?TWxPUXN5dmJ5UExYdXh4USsyRkNxVE9XUFJYQklaQWI2YjNZM3NrZERMM0Fv?=
 =?utf-8?B?d2NhS2N3L1A2ZGhScWZzNk9GMmx0S1JrZ2lHdXd6YjZBTTRyUHN2OC9Kall6?=
 =?utf-8?B?RjByY05aazd3bWlLeDl5WDdQNkF3VmhYZFRnc1I4bDZnQ3R1aEg1Nzg3bHFN?=
 =?utf-8?B?eWVLUjBva0x6WU5zWkNRMEtIRG4wQnBIU2k5ZGJKQ283cy9DaHljdzRCNURL?=
 =?utf-8?B?SGQxTlZMMzI2dkRHN0dKM0xKQmY1QlF5MnI1V3cvczREVWFsOHg1SFNERXBN?=
 =?utf-8?B?RThpekZxcEtwamNjRWkxcE9ERXpNTkQvSGpuMy92RUhDRFpRWldXcGtSLytQ?=
 =?utf-8?B?MVBDZS9KbnNhR3FpSE5OaHpOL0VsZTd0bXVMdUY3dWJwMFE2WGhmRUdYcVNh?=
 =?utf-8?B?TU91Q0VoVnZhNTZxRkd6QlZHOWVZMVE0cXYzMDlMcTl6NjhrVXRuVHh3WkV2?=
 =?utf-8?B?NnRsS01KZlA0OGdjK0ZwdDlBRXFnd2VjeVdmeTFFT2pYQ2w1QXpXaWFOdXNh?=
 =?utf-8?B?K0FCZE9WYnk0Y0JHMm9DMWFibkwyd29YVnlqSldmSERmUUsyR3lwM2NOU3Zx?=
 =?utf-8?B?MEtNWis3SWVHMFFXbDFEcjRiTk1YMjJpWXV4dXJUNG9ORU94VFovcUN6b3BB?=
 =?utf-8?B?TUF0a0JsVnZ2N1ljRXJrRnpHT2ZueFN5QlFEbVovZ1p1UEtmVXp0Wk1oY3No?=
 =?utf-8?B?eG9DSStDaUtlT3ZvcFV5b2lMQWI2Rm9SaDh5R1MxbW5jSkNXbE1Nbk9JUDVj?=
 =?utf-8?B?ZXU3MFpVWXNGcnJuMjgwSkJaTVZPbEpMUGN0ZzNGR3BTM29yOHlXUjlSWnQ3?=
 =?utf-8?B?YndnUWJsU3JPbW56WFZYMG5IaFZQZzdWWDhWUVN0clRHT1dUT1lkMDBKWTdl?=
 =?utf-8?B?ZGp6SllMTzNZL0hvMFZGRHZSQ3k5UXRrNndtK0h4QzVDWVVTS2w4cjh0am5z?=
 =?utf-8?B?eGF0aUFXT1dMUFc5a0poenorQXhhMWNQZHJyVHBvWnZWTG14aVh0WXBvUm1t?=
 =?utf-8?B?OEJQMnA2MERJUGVIL28rMnIwYUpEUkdGaTU3dDVFUWZLL1NCWVE1bmsyRVFr?=
 =?utf-8?B?TnJzYWpjRTkrd3RXdjBaUG0xYmNGSUl3Q0pCUFNaUHNZZU5qN3ZMRUJsdWV2?=
 =?utf-8?B?bU12K1U0VlFsaUR6Q0hYUXFVOE5RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B724D51AB11E94B985D3DC338073B51@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9974429e-a261-439a-dabc-08d9ffe7936c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 03:07:12.4142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZfXPpKpkAVbsgmI03HAMQgQcsdUrkWtL084egDW/HmIx/FshVtqF+r6mpfUy8aBc1kPAbsJc2yca/R24GtgeQw==
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

T24gMy80LzIyIDEwOjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gVXNlIHRoZSAlcGcg
Zm9ybWF0IHNwZWNpZmllciB0byBzYXZlIG9uIHN0YWNrIGNvbnN1cHRpb24gYW5kIGNvZGUgc2l6
ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0K
PiAtLS0NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KDQo=
