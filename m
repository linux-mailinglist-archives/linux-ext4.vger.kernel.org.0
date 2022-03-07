Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4FE4CEFED
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Mar 2022 04:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiCGDGo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Mar 2022 22:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiCGDGn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Mar 2022 22:06:43 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC3F42EF2;
        Sun,  6 Mar 2022 19:05:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwrFP8nmqCaYXPFXzTWwxc8RFQka24+1u2xrfpQeo2xH056/JbBA3wt/rvD6R0Lde8hB6BKh+XKq8WiuK7WZxdyTc/s+FXkKGIy7jKdNkH0S9QPQDUZWkFYxs+M9V1NSvOkgU1TEoOEMntKxV3Uj8mh7aZXH+OiAWvz5KkuL3L0vaSLX38qletAn5f2wtgn3PoYEAtSLVIpXgoofnUFB24wQCFM26Lc71/mPcFMe57UpA+vazQZoOME0YfS28xNr+D+W+jMsNykXckhaCSBXpyBB4FGPyLEmz/MPe677WdWrxDlopaIosd8FUBLmSotklQBnkUSWrUY2dhZPli+W0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNfK8nzkZMid+TuCfH4y+6zYtKQIhohnjlnNqZjr6wE=;
 b=eGdh8w8eQpM51KiQHTTP5QLm9HVt5/iE/9iNBvKUMCORnPpbPk51tQ384W5bUSck/okywp9vdlgHG0EM19WHCK5OzMCOEUT5etvgp/VaVC272x0xve/sTrTmLgA/Ar8c/nY3hNM3qeAKvNov4H8SaCzTEm3QtwHzA7tKVk7X9/ouWrqz/dqbcvpWYi+HpDZb/s5uDqWWfUCCUV8rCwEaWk8UOojg/QyDzTUhIkqX6yOs7qx1ucnPAHoKl8+s6QjVRMlpVDC5siHwC9cXMdaq6STH66qAhh6yvIlZzYSJxIpKD7ocu99LLeWSv4suzp8Br5HfW9b+QE3HwiiO6QfCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNfK8nzkZMid+TuCfH4y+6zYtKQIhohnjlnNqZjr6wE=;
 b=Phv9WvTRz0VGtkN71x9Vbd4QBwKXCdZ2sayx/5tulWL2XncO4J9QJY5vEwU5mVYZv7a7pXShP7mdpwb6RGEagOCyRUocA6N4+lHd1fTXWWugRJf5D7CIxK/tL82pEULR/m1LcIpo7DATolksJDQD5XjxiFnABaTyM5XxsopOR4AzaqY1p7JUTqO49mjTLf/vmYfuwjhxmmK3eRtJMLMtOLT9BAheAzC26PCX9MG8AFe8Xpf6cat7dAbIxcWVLsYTRVng/9kbhjcwUq7Yt9OuIPA6uuqzO8jRehaBX9tSX5viOSY0NCBM2yvcy2wFcDi+zPzvLEUpA8xQXt/uN8d9oQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1853.namprd12.prod.outlook.com (2603:10b6:300:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 03:05:49 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 03:05:49 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Song Liu <song@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 02/10] block: remove handle_bad_sector
Thread-Topic: [PATCH 02/10] block: remove handle_bad_sector
Thread-Index: AQHYL/HgPlcxA3zDfkeXQzCsCptEfayzQJkA
Date:   Mon, 7 Mar 2022 03:05:49 +0000
Message-ID: <5506e564-d76a-8600-cce6-4e1ac134be5d@nvidia.com>
References: <20220304180105.409765-1-hch@lst.de>
 <20220304180105.409765-3-hch@lst.de>
In-Reply-To: <20220304180105.409765-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8a33a6e-911a-404e-5b30-08d9ffe761c0
x-ms-traffictypediagnostic: MWHPR12MB1853:EE_
x-microsoft-antispam-prvs: <MWHPR12MB185370E74DA90C0F7EDE3B6FA3089@MWHPR12MB1853.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O5HLv9Ln20fvI90fM8nFySU90/bHnxaWYskmhZbW6topCpn7cGcw0O0lnXUqddB/1XIq+j3UFk3cy3OY86sOlyzEZi6o6JtDZ3/OzE6WNH4eFvJcWVl98/36V+mcoPCa5hVnKJXdnet2j6SJ0TN0liJYo43x9ZmTpfvF8VTx2gMksaUESqUHccHNivrZsq7EeJ0yyyt7+n+GYN/dRKm687UHaKtqkP1idZUXQ3ljWVWQJalsuWihZMGIIOhcv8aBU9exyq+5AL1wTn63E5oLfWq8VpzwphAXB6Xf+RJ4Gy4jgws4TWBDCTmGEcmveF7SGlmFqi7EiBRoRRfcKieyhVAJ/f5zrRQFIxK+TunAKw0GhrhvARR9+0mZmNwAPJQ3otURBvfbq53E8KnEefyeZYFnvzh2H8+pShqhKWv+o/+xvg6qbAca49zkRWt3dPWGXDOwwFcP1FNhkO1egKxE3/5b7IuzyWqWnUsnKdBgfwBpioYVHDpoL3qHiMkw+hBwjkggS2L183mLZKbQwtqkmKOFQbTl6FlwK9iHvCdj612ihmCSusP4iqNWpnifwZms6xc8Sdz2hSDXAjyQEA5HvFMNAPk1Aq23NwwxlC049fv678us+iYl5GFmo6vox1dSMFEZ7Lnq7vY8faUGHvJAhup17t7GGYp29qhuRDynrCqXsUzDzl0hTMndPyOvGDBVMTpaxpIKa9arxs+2VeQ5tfM/VCJwH2Pzk6wD1a/2Ph0L9uhjawFkB4WifbDkSfwx0amhKVHXbQoGmJuww/GFkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(4326008)(8936002)(31686004)(53546011)(66476007)(66946007)(64756008)(66446008)(8676002)(54906003)(6916009)(186003)(5660300002)(36756003)(31696002)(6486002)(86362001)(122000001)(2906002)(71200400001)(2616005)(6506007)(6512007)(508600001)(558084003)(76116006)(38070700005)(316002)(91956017)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWxhV0h3clRhaVMyRnJqQTVaUzV5eTlBSzhvbEZ1VkJub2hUazljY25UTWcz?=
 =?utf-8?B?MVdLR0pIUHNaMzloZkRRK0s1L1lPZU00Vm9rMDRKMW9iVlpXeFFBdDZaQUJ6?=
 =?utf-8?B?SjRtWkhuM2RtajJhN2ZzZ3QxWjlaN0FtWW9jd2tSNUQvTHkyeU5VWUNwakJK?=
 =?utf-8?B?YUI1VEVITzQ3bEJTZ0t1a2tZeEh5bDNNcFYycmhDV1hoMzFIVHpESXhmVFZs?=
 =?utf-8?B?WTFBRzZFQk1DM2pISTg1VVpWdElCT1V2d0UwRmozcEZERzhJSW9EZ09xV3lY?=
 =?utf-8?B?amhSazVEWnBhSk5nb29JSEJ1bVZ0ZFA2dCtYakpWYkN4QmI4UGJXYnZ1VGN3?=
 =?utf-8?B?TjFPOUhoYjU5M3QwMVFwdEZYOVA0eUFVVGJlNVkvTHl4aktHL3l1VDNlS1FW?=
 =?utf-8?B?TWxmTFRBMjAybk9HZFEyZ2dhSVBlU1RMQ2g2Mm9Fb0FuQXVlRkYwejc0T0dZ?=
 =?utf-8?B?UEU5dnYzTEtXTzlmOHpDampzWUs3MmJjREU1b2VhdGkwcmZnY0xUbjB4blA1?=
 =?utf-8?B?V3RjWkhuWmxSOWtrOWJNQktDNFJPRzRhdFhTNkd6NVduY0lLdFdVSUduRDRw?=
 =?utf-8?B?SzVXTnZNNjZ1M0tQNjA2RlB2QWhsWWdPZDVWNWZ2RGtRRXRIRWF2WDFnY1Bi?=
 =?utf-8?B?NnFxbDdtRWtSOTgrTWsvV3UzTGpwYk5ZTDhZVzdkSERPT3NDRFVrZnpHc24x?=
 =?utf-8?B?RkZEeVFxMlBaMDIvbHZsNlZ6OWptMDhVOVFZSDI3d2RHK1pOcTNkbUo1ZEFz?=
 =?utf-8?B?VW05Yk8reTRvT3M5WURKUy9aQThBTTA0SFYyQnprRCt5UWkwNFUvaE1FSzFV?=
 =?utf-8?B?SkNmSXE0QmJaR2Y4YlE0WE5rY2N2NjJGZURoWGZSM2xoc3dLQ0d6Ty9LNUh5?=
 =?utf-8?B?dzVtOSt0RS9pdTc3WXQvK2V3cWJ5OWcrbDN5eFl6bzRHbGtZOERJbEdGSVF0?=
 =?utf-8?B?bStLOGZiQ2JyZndUU0V6cXE1bzlsSy9GN1ZYdUowK2s0cE90M2RvRGg3YkIv?=
 =?utf-8?B?Um9aZDQ3VjI1aHhoYU0wZlNGdnFPR1ovVlcySE5vLzZhVStCNy9xQTlMWm5Q?=
 =?utf-8?B?QTBQVmNsbHdsZEpId09zZ3BLR2JPOVRwZ0t0RjI0NEY5ZWlaSHV4QmNUeDlD?=
 =?utf-8?B?b0NRNG82U1hPZHd3ZEZReCs2dzRUSEM1SVBqZ2I4czk0cFhlNDFPWW0weE5R?=
 =?utf-8?B?T1ArMk5xQ3p2OFQvdjd5NmRiM2doVE8zeHdpcEVQRTlVWG5aYlFFeGtHY3lR?=
 =?utf-8?B?dTRGRlVNVUZ2VzRqRUhBS2dRNFJDRjV3TWlZeXQ2YU12QjZuUUhhL0ZrRHNB?=
 =?utf-8?B?YjdpSkw2cS9NanBLM0cwZUZ5dVVFL2lUR3ZRZVluNXFSRDFoQjZPc3pHRVlh?=
 =?utf-8?B?aXZ6c0txNXhQWlIrZXREUVF1UXZCMThVZGpTZCtna21Xa1Y0SWt0Qnc2Q0hD?=
 =?utf-8?B?b3R5TmRFemV2UzhJK1dYM3NaclIxa041eVZKeEJ4MnVDbVVCV01MblhRZ1Rw?=
 =?utf-8?B?YXRkaGt3Y3VmMnJhaENHOWpEaFIxamtSL2x3Z1B6c1ZmYmlHSElNL2QxVGln?=
 =?utf-8?B?MUs3b1UxRjdUREgxQlpaQlBXUjdUdzZadWVCSUd4Z1FyVHpUeHNEV2hWaWF5?=
 =?utf-8?B?MzVISVB4ckVER2pRWGhNY3FpOEszS2hydWRwQUNGa090a05BNjluR3U3eTgx?=
 =?utf-8?B?Y1J2MGUwZmlYNGlNSDJZV2pWbGNLV2N5cUh6SWxFTlM2cUI5THNOdHpJUmZj?=
 =?utf-8?B?S0pYeTkvNVVyQ1NNYkx1d2x5eGhxZDBsQnptRHA5TXBpeWpDbjhDMHNZZFdw?=
 =?utf-8?B?akVpRXRJM3Y3ZWJ6MXR0aHR1MjBvTmlHdDNGeEVscnd6YVV3QWx4cE9ISmF4?=
 =?utf-8?B?emxmS0ZTSjBFdkErQWY2enU1M0NJVVJCMitoVm55clZmMHp2bmRSeTV4Y2Qr?=
 =?utf-8?B?MHp6QmFmZms2Q0NJdnQ4SEh0Wm11ZDJLWHJQeXAwK0xzdHdLVUpHZUtOdTFy?=
 =?utf-8?B?Mnl1ZmF1VUtuQTFPTHVJVnB2b3cvbVZocW9acExUVmxTNG9UcXc1ckhQODZ6?=
 =?utf-8?B?dlhscjQxb0I3cFdzTVU0VUNMWnRQSHFlWjdmNDU1bytMR3p2VnVXS2tMTDRv?=
 =?utf-8?B?L0JzRjZnbm50M09ZNVNPU2xUSkpjOGh6MlcxcXpoaTBTb3pVTmhwT2xDZ3JR?=
 =?utf-8?B?bDh5QmVmNGRCR05NbFpLNDM3UFl6TEV4U0F6ZGFjTEdFSjU5RDdabTlQaE5F?=
 =?utf-8?B?RUlWMEZwRndVM3laaTdXMDdyS2NRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57EF8EF630B9AE4E8692AC6B46C73138@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a33a6e-911a-404e-5b30-08d9ffe761c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 03:05:49.0910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUMxigpQb8tgK/iP3L+XINX0BvEtxX99fyJhz7IyZ4c9z5VvcdWdBad2egTBwILKkri9U0qzNPnaHO3uHBuXUA==
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
Zm9ybWF0IHNwZWNpZmllciBpbnN0ZWFkIG9mIHRoZSBzdGFjayBodW5ncnkgYmRldm5hbWUNCj4g
ZnVuY3Rpb24sIGFuZCByZW1vdmUgaGFuZGxlX2JhZF9zZWN0b3IgZ2l2ZW4gdGhhdCBpdCBpcyBu
b3QgcG9pbnRsZXNzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBsc3QuZGU+DQo+IC0tLQ0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQoNCg==
