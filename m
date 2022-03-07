Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163044CEFFE
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Mar 2022 04:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiCGDI3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Mar 2022 22:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiCGDI2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Mar 2022 22:08:28 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C501EC60;
        Sun,  6 Mar 2022 19:07:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oqw339YZFKN/O0oeqcBlxBh82xAp/T7h1IDXQPmABnFtjwppms3D/alKJ5HyNpqKiPMTgO6K00jMw+i1PIj/HyEErQuxgJ0T+VwrQkFoQx/CGRr+shE5DFuzPNaoDHho2cQB1D8OZa7rRMYE2bBHgxEXGdGUny0jbBqP7S4sE9DmvXgbHhcKgpxxiwsWqpvvoLjfW7OOnYfK1qCN9RLOIKkgIONMCPdJRCjrWYpm6tOWQJkK3paDSaKcH6soSGlKiBOBW6xG153Hp8g9Bc8fJxPX9EsB8TmVtZd4PivMpPVzNvajWwhwKZiDT1MOI/PhqnMuCLCmqExLH6LZEC+30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UNjSo6K0ixjAUs6vpajGrqAdKmv2OyjMdNojVm1JnM=;
 b=VYZY7G2rIbxuhSdDNfDsWf8Zghg/JyhhUL26g5DsNWEuhzpVBccEoPQ5xIKrpj6Ol/TTCPK5a3zEYXYh5VCTbF+kEVm9PENHpxcdWTvpmX5eWd7jNBdUZ9tImExZ2XRdRMjTXHAX8qHDSQ0OGVmsKjs64zHo3b80IncpfW3E39Xr+mFZ5JvwsEYLQkbYPHuTzdTNjX0UYDVRO0WgZmlxITijij07xP0VgkYc2FjviEA0aair1mqzqa7yVGpp2XQCu2o/jsxxWkdFc0ZCLEdaWMFdenFZ2ZdxA/+fb5hpgzkOW6mekqGSjjZIblfEJ4nzIxEylL3XFhEG0C6l235DCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UNjSo6K0ixjAUs6vpajGrqAdKmv2OyjMdNojVm1JnM=;
 b=dQIIvLX51QqA5Hrqt+jmFAhQz43GMfv/dnb0fuAMxl9EKzSiMRWqj6dqfANwSN2sGW4I3jCGtJFhacqTf899nwlllrMH+dIY6xcGTgBbRX1BR3En7AovcIDEB3d1bx7jjWmM5cmi3Hm4oniXWbuFrqKHvZB52qyvmEPRIXbPPPoWuEAk8gNsQW8fN7ylO0pzz2TkPkBTHS6LFwcByonpchZxARYS7DC6s/gxgEs/5UPrSJIlWAjzn4uOQeCqWOZee+xqh2VVEGny638DVZ2E+PEIeZqhUx/GUvXD4iAfcKvSfyu1FQ+53Z0bDfYIUhLJfTxMnXMZJ8Gaexs+Yj/mXw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1853.namprd12.prod.outlook.com (2603:10b6:300:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 03:07:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 03:07:32 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 05/10] dm-integrity: stop using bio_devname
Thread-Topic: [PATCH 05/10] dm-integrity: stop using bio_devname
Thread-Index: AQHYL/Hshqa98ikaMUeGTu4rt8c7H6yzQRSA
Date:   Mon, 7 Mar 2022 03:07:32 +0000
Message-ID: <da960eff-68c9-f7d6-20ff-526fc3a421a5@nvidia.com>
References: <20220304180105.409765-1-hch@lst.de>
 <20220304180105.409765-6-hch@lst.de>
In-Reply-To: <20220304180105.409765-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b9ea44a-fd88-4bd3-707b-08d9ffe79f39
x-ms-traffictypediagnostic: MWHPR12MB1853:EE_
x-microsoft-antispam-prvs: <MWHPR12MB18532F3CB83FAEF8F2B0B751A3089@MWHPR12MB1853.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 82e7hwojzYbVjGPqBm/WTjVqxYXALhhjGcyKP2i2scYu21CWLv8fPhpCfgraypvza5GfQ5RWrUYJuaer1kMYbMQCPZM4NCEIIG8UnjLHun0V/IM80hu5hI4/FPNpqgQF1z/RhlmYqpOzov4Uc2+vKPia6ulFIr4K6dELgPuNzKfVV4GfeLpGJcnF/UqiWzFDEu3ld7F+SZGIIfa+cy4Aj2QWSdsBbRGqp+Z3Xqh1IzhTJvp7CUhcuu0hwlQ0qADtXz8UsMf7bkx0DYDlgqovpNsR8uQTU4GaZKwIcbgY1REeaNt5shfdvaBSP2MYOBxPkf01Jpwbj4gPvORKzR8FS3gVpqpAZbLKGdWnlp6IgQRHGiIGFRpWTCVX/tbia2iPjDmYiQuzPEWBFQ0ENogiyk4/7hyB80NiJwpt5IwP0K3GTrCAtfR4dN/cU5JZZcYEnjSKiaNTnysEW7Zlhue2CMZsXHL9Rv/eo1bo4NghBl1cRyQ7MVvdNyHKzIx0XdNIkiBbZVxjOGpGSHOCi1SJ0BxYMEFlaU5GKb1cLcT6MxNsheZfRY5aTWb/Jw0ISNV+PeJ82c4mjZ3QrOCqMhb5DwpNVEMvS+hwv/H60u0lkOwPHlTfCTEZcBdN/wkH4eBL6rzd5P++5UA4a8Nmat3p32vW70RJ8sCn8keVQRMfxSeEwjDo4chPzoGRLZJDEROk4Oatl4VSMMfN01Th6q65Fk5bjmjxP7tyjeO2kn5eoaGhK1lB2DbeQCSSv398Dkettv/FwcCerCfmhokDVaz6Zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(4326008)(8936002)(31686004)(53546011)(66476007)(66946007)(64756008)(66446008)(8676002)(54906003)(186003)(5660300002)(36756003)(110136005)(31696002)(6486002)(86362001)(122000001)(2906002)(71200400001)(2616005)(6506007)(6512007)(508600001)(558084003)(76116006)(38070700005)(316002)(91956017)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVVsT1l1NDF0VXBaY3FjWFBWaFVEYWJrZ1MyTnhqL1lKaTZxbGR0LzJveUVz?=
 =?utf-8?B?ZGNvUmVLb3UyaDRTVFNxWGZrZWhHQmFuS1BpYWk3L1h0WUdhVm1aZnpUR1gy?=
 =?utf-8?B?Y0ZOTGtqT3c1VEhrQ2d5ZnE4eTFYMjMxT0ZlbCtIMjRXWWVkakNQVlFpbVd5?=
 =?utf-8?B?a1FmOTF5YUtlbnhySm1uVjlZeHYrTUhtc2I1MStNT1RkUnd4TmhTV1kwakE5?=
 =?utf-8?B?Wjh1UTdFNHduWW9nYXdSYkR2NGU2NS9yVE9IWGFTRDRZdzE3RnJZUjlHSGpo?=
 =?utf-8?B?eFZPVmNHTEg3bU42b2pYY0dsZTQ0YmIyMDBUYVJKSEgwTW05aFFubnVmSUV6?=
 =?utf-8?B?VlFUR2lFSzRCRThtSlVQVmJlcTltSmtlYkNzVHdxZnExdlNjb1ZuU0x6RWZZ?=
 =?utf-8?B?blRhZWR6SG54SjBuc0taeTZtOERBUjM0SDUzSmJacFowdTh3K0VWM0NPemxv?=
 =?utf-8?B?aERrK1lZdGNzNWxpdnYya3B6ZUlUNkJwaEN1L0RqTTZ0ejhZMUhFQjBpUlE3?=
 =?utf-8?B?SEtyTGE1SFkyTW5yVmZZTlRrb1YvYUhTZUdkc0VVaG1MdVRXK2ZSQXdZR1lv?=
 =?utf-8?B?M1F4VjhvKy9JajVSNllMSG0yYUxFOTZrUG5xSHM5c1R3cWkxWEpWd3RZZWNz?=
 =?utf-8?B?SnUyN0VQb1M2ZEM3bDV6T0Uxa2RKM0I1Q0xmVE0yZHAzbHlSN1ZKT3Y1dFRn?=
 =?utf-8?B?cEhqbk9pMVoxV1V1Sklnb0hZMWMwSGlXT0oxeWxJSlFsaEx3ZUZmUzlKODIr?=
 =?utf-8?B?RkE3MCtYSFVtZlRDMXM5eXl4VnFIQjFoeFVRRG9Bd2RQSEs0UmNBbklCcGhN?=
 =?utf-8?B?ZTM3dnltenBkVzVscklta2YvclJIK2wrQThhVVJCZ0VzUXBycG9KTi83L1kr?=
 =?utf-8?B?UHlGRk1xa2FjWnAxazhJaGRjS0pidCtYdjhkRGhWYTZtKzRXUFloNVA1TnlS?=
 =?utf-8?B?di9OYzNZVFVGVUFoeTZGeTZwWHBhYVBjcmNYdG9kWHpqMVBPcW56TDlvSG1Q?=
 =?utf-8?B?SGduYnJVdG5yYkFtelBIZER1RU5Fa3pDbzRzY0cxYnFOdUdEQnU0L3liTmVO?=
 =?utf-8?B?bkJuaE9kaEpIMnBOc1FESDlMNjV3WHdGSmlFejhFcjBnRXp3QUtwbW00Q0xq?=
 =?utf-8?B?TjNhR01SWjJXY2pNMkhYZlNxbDFLY3k4a1pEOUFqQ1R5MDFldWRKc2FYOXhO?=
 =?utf-8?B?Z1ZCbS9OejZqT0dhelFjZnZ2dWtkMmVmMW94Uy9TNlJxTkVVOFlEZzVkZ2FS?=
 =?utf-8?B?Ny9DTTJ0VVpva1pJYWZzMjFISWorNGJtaDFobGs2S3UwdGhkZlNFYWVTK0l1?=
 =?utf-8?B?RjJkTEY3NmJGaDhoK09UMUFUMG93b3lyanc5cmRsWldCREE4M1FGbEF2OEhT?=
 =?utf-8?B?Kys5c1B2U1pFYzhYQlExOGluY0FjNTFBSms4MmVLck1Oc3FsMXgza2lBQnpz?=
 =?utf-8?B?Tk9UejRpRkpGNHkzNHFFUjlCaS8xV0syemFjdHArZzIwMk14ZTdRbUlQa0cz?=
 =?utf-8?B?bDQvNnpoTEQ0dFJmOGt3enFUdEZ4bU5JZ0EwZzVDbU1UVVFjR3NUWHZpeU15?=
 =?utf-8?B?Q3kyNlJNZWJCbkpwbWM5NDVqTFhQZzRzT09LYkNIcjRaRU9KTDJaRXkvMlpT?=
 =?utf-8?B?NlpYdE5VdGQ3dUJZeVRzcmYrSkc1TndWV1V4eGR6WmVHWW1nSk91SXdFT0Vy?=
 =?utf-8?B?Y2IwNjJiOVU0bjlRSytpSU9hNy9pNVVHckFQWklBMFVQS0tScUduMGUwWVpI?=
 =?utf-8?B?c3JJMUdsNS9MNElTZDdGWks2eDhRNGViRTVjdCtyYjBKVU00cW1PbXpqNzV4?=
 =?utf-8?B?b3pNZkE1WDJpdzhmMS9OUEUzWWZXUmg1QW9qN2JwK3dXTi81VjFwR042UVRK?=
 =?utf-8?B?Tm84NEIweEJUdGhGVkZ2NmdhcHRqcW0wQ09pbmpkTEQyeEtIM2lsTmQ3WlBJ?=
 =?utf-8?B?bUtlZ1VqY3U3WXE1Tzc1bGdIZ0pjemZpQW9WOGdqVGN4Q0IzbHQrNEVoME5V?=
 =?utf-8?B?ODFxUkVXZ3ZqRjdZNEQyR3pQU0xHcUJNS3ZVdktQdkcrbkNPUER0bXlxc2Za?=
 =?utf-8?B?YTdGUzRiWU9QYlMrRm13ZjFtYTJrakQrMUdnZk42TkYxcEFSUFRpK25Cemlp?=
 =?utf-8?B?dUtlcEx6bjBXdHNKWDJ1NU1vZmxPa1lHQXlIdzI0V3d5ZUlsZTF5V0xwaGNl?=
 =?utf-8?B?OHQzQTA3TGNQUk5aWFh4MkEyYlZMRkVPUnErcld3OFg2YkRMSnd1WlRBcjNq?=
 =?utf-8?B?dStVL3ZBNzZSVEd5M0RiRjQ4YkJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D975493CF5DCE4D89D88F25E3E676CC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9ea44a-fd88-4bd3-707b-08d9ffe79f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 03:07:32.2255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22extuXDGIizwaZYvXVVjx3OuMFydNXMWA3qc3vsA4A1eIUMn20coslEECSEtsXfVrNuVDKJPV3/tQg4zKQwww==
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
