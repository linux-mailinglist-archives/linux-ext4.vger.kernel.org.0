Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46444CF001
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Mar 2022 04:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiCGDI4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Mar 2022 22:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiCGDIy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Mar 2022 22:08:54 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E143D1EC60;
        Sun,  6 Mar 2022 19:07:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb10UHTKoiAt9BhwVhuHaB4nu+mICx9jSVOnmlx4eGd5maIpPzcj/K5T8l+ZkmWiWfV0UmlWgsdNXY5TEF5Jvl0n9N4TOI++F1CiaCA+cZnPr2BEbY7uiPVAkDExt2kPXWq0ftI4omkSzSGEu2snHpjVz6q+5JsRDv9s7ofxOpsgVLVEhhXc0FmksZvgP0uw4iTppVy0FynXl8Z+9iIyUWmdFIBq9W1LRZsQTLAvldPvaQIRH1HjWgmBqRCAlzJ4MWUkcQPJz30JTQPEXcwPT4PqX4w36kwRv/HZ4LS0LUzdzdZitFIazC96nUpNZ9s1XziecV/IWHO2INful2gyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFJlQbkvOJkzH/Bt0Y/eXTZJrTsB6i7FCHJrlTvxAbQ=;
 b=C4Lbu5pSp0Cn2s/tlQRzXTQDrZtG6dts/PgCMj6qtL68jgGz+py+LpI7+Kd69wIytT78yQASQscvsguXZHp6BjrgNOtk5QiEZisRUBtxvhcOIw5iANGcu9zMsv8C8pf4tJOfr8onfRd7NiVKET6R1CdmqcbxvZj0tyq+wnEtBBpCu65+h07LI1mmtf8exuONBwhQoTq5+PHyGJfY3KbOFPJV2nrVjXpEQw5ROKwiEAwqE9H6EugN5wblrZAEo4sCAEvB3uLqdL4QPEgb4edCAEzKjyqXI5nOZTm85iOpYJKOCuBRMEPC8Kw9P+IJ9oGuILphlVcQkh0M9IfzzoAGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFJlQbkvOJkzH/Bt0Y/eXTZJrTsB6i7FCHJrlTvxAbQ=;
 b=ebIZzHAW+/vWSWmqjjVAOdQ6XxwJozXDzn0LknkQ/mYaX5NB9lVzBUkt8QWLsA2QUfFlOdk9by4Wp2JE75QCzM+6+zMjIQuJLGPCgl+JEOU1zbn2Bcag/vff9hswcOkjeM/mQUSVMj8Kyy90NEwi6QrzHg61DYbspYAsVbIXtkyo8QyKCtZRwvMCQju3hNZTF8Y62M2Nobme6CeWI6jwP0j49CQsq5O7sINUycLxBGohmBwbiLPnWmZ0H5lC9yRyh46+yjVd5I2XZxhyuNE0eeZ3CWIVXnONMxpeTzT/8O1tL1ywnO6dS4XxVMJlP/MMN+e1dGU923h2mfYgJ4b1Kg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1853.namprd12.prod.outlook.com (2603:10b6:300:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 03:07:58 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 03:07:58 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 06/10] md-multipath: stop using bio_devname
Thread-Topic: [PATCH 06/10] md-multipath: stop using bio_devname
Thread-Index: AQHYL/HsKgezjb6JFUqFZXzcYBfVG6yzQTOA
Date:   Mon, 7 Mar 2022 03:07:58 +0000
Message-ID: <f8ee6a70-0877-132e-9e36-8f6888d13d45@nvidia.com>
References: <20220304180105.409765-1-hch@lst.de>
 <20220304180105.409765-7-hch@lst.de>
In-Reply-To: <20220304180105.409765-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6ede960-b9ae-4cbd-43fb-08d9ffe7ae9e
x-ms-traffictypediagnostic: MWHPR12MB1853:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1853F2501E6C2C5B7756AEBCA3089@MWHPR12MB1853.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1edpQP/U2EZGFEmQKLQcirDKnrilErMZyXNP3cfVdH2DAU9J9hyoqMbxTcj0kLaKEvMZZty1yKxim3Q7lF75Q8B7qmjaMTslVF8ncYzT9f+383Iw0uprH+OWW59jMMoL8stI5Am+RCxUfPRuvaR0WQ9fyHXwAbH/JB2QcEEUDRKS8BvVj0S4IlDZ52cZaeIvkYOdbzqEV11PGeA54esEfi9b4eMbMkyl13xsefSeivvrEf6uCKUHwezUyhBsKfoXLZAm6vzn+7dXBU/6CNyBTLqjK5eCuNjqtU2LXGkiWm5Y+qrzxHdy2B6an8dda0aD8TfPhouBHrasBKVk+T/sp9nrdmjKG6ZcYyjkBKUNWD+cG/zoB59X2JjPgrM84zLniwZhdvFsDEXNYwUqRapy6Ueo+evJg7sTnt2VxyUdBbEE4NCGwFgCPxWgp60oDq0+j2JExe6URDkRcO+ZlZsDVZsikFRKNlF3kvhmywuk1571XbDuFJqstMDlkulF0h8/3WiHG/bLOBdeTzcQLX+p7Ekf6LKpaGl7F/s7d+fmlfWQpdvz5PV4/iI3dWEdaSCu00BgyH9h3apoBDHdeVpYmiWjnYs6lOFEIy/fRnTNojxN8ERsurwunDgNvogQcEKlDnJIBiezWzdx+X548VyXmj9A9EzJ1OtWNeuaHqIdn1YY+xnlCU12vWvHn4t7v0MgpSvsRYAv2go2wvlkQyHsWRsXaaoK5tZxklM2EIH9DaASA7PXU6IanYTtf/zdj82z1nBNZqX8ZhBkYBAY5HW1Lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(4326008)(8936002)(31686004)(53546011)(66476007)(66946007)(64756008)(66446008)(8676002)(54906003)(186003)(5660300002)(36756003)(110136005)(31696002)(6486002)(86362001)(122000001)(2906002)(71200400001)(2616005)(6506007)(6512007)(508600001)(558084003)(76116006)(38070700005)(316002)(91956017)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWR0T3hWTk13YmRKUUM4NDEyL1JhTFg3QkR5di9GWkk5ZEYyZzFBNERXZnc2?=
 =?utf-8?B?MDViUHV5dHBEdzBNMk5JU244N08xOHMxRy9PRE95MXhBa0tZcUgwTFpZd1VI?=
 =?utf-8?B?b3g2djN6SUhPR0lFV2g2cDJybisrREk2Zmg5SDlCSngveW9CWng2a3ExeUdC?=
 =?utf-8?B?R0Z4Q0xocndBNlgvdld3dnJHU0puOE5ZWFEvMEJDcXZWM0hjRWw4b2J2K2Yy?=
 =?utf-8?B?T1FhcVczRWJlRGZHQzRiNTVXTFZ5dUcvUis5MG1FTTRRNmg0eG5nbFFCbzVC?=
 =?utf-8?B?TkhJbG4rdzhQdEtOV1FmWXBCbTh0REZUc2ZzZ2VFa1VnUjIrWHlYL1VBdnRD?=
 =?utf-8?B?UWw4YXBCRkVTTEo4NWp3WFZPbitrVXRqVmJNVFFhZXpxekhNYTJhUHFHWENa?=
 =?utf-8?B?QWNHU3RkRS85M0ZncVJLaE9HZkh4djdVbWRMNERwTm43UDFwanZTU1ZYKzdX?=
 =?utf-8?B?U0syR2w1ZFFhOG8wSURsU3lCcnFra2R6ZEtQaWtuSmltMmJkNE1UUmR0Y1Fw?=
 =?utf-8?B?YjBIUEhxdzM1bkhhbXBtRVpjS0loTjV6V2Z0MDBzMCtSTWRUTzl2SHFudDB5?=
 =?utf-8?B?Y2NTSUVFUlhBZXowM0tRSGJqUDA4bUxPVUV4UnpqL3ZObDFyYWh4OHA1UmI1?=
 =?utf-8?B?dHhJYmliR2o1akdjdWkrOGRrL05HdGtQQzhBcm5kVGdoQ2Iwbm5NbVVGL3l6?=
 =?utf-8?B?MGZaSmxrQnZrMXFyaXowZS9GTGRXMWE3OStpOHRQZE1IRlpDaWx5dXUzRTJx?=
 =?utf-8?B?Sm0xSlY2RmZMMWdYNTJsSDNDWi9WWG9PWVZuVzM5ZzhxbEJoVDdSemhBWnF0?=
 =?utf-8?B?WVJMcHluUDNod09DaVV0V092YisralhTODNUdjZDWUpKeDhJQTI5KzRJTCtD?=
 =?utf-8?B?VFN4M1V1OWhITWxKMml5RkFrN0ZvUk9iaE1VNndNbU90NW1pbStlVE9lYldz?=
 =?utf-8?B?amZUMUp5YllWNng3blhRUnB2VENIazgveHRYSndLby8vMWpBOGtSb05ZVkpr?=
 =?utf-8?B?QnlZMEoxQWRjWXRrdVlTY2s1N3VVQkFkUGxyQysyYWIrS0RzVkp3QUtzRnhn?=
 =?utf-8?B?NVBQK1Qwa1doNWRvdTZhY2hoZVBxYS9mRWk4SzJ6RW1zT2ZDV1B0TnN0YXRU?=
 =?utf-8?B?RzI2MTNjdERPaXI0WjMvbDJTOG5NQTRac0pvNWNuUSs4NDhicjE4d283dkoy?=
 =?utf-8?B?SHBpY3NpdGs1dmtaVFpUOUhYQ0d3bVJ2Mmd5YjhIdmFYUG56dFZUeWRNbUhB?=
 =?utf-8?B?MlNRZjhFR2x3RjJ1NEplN3lvVUVuWUw4aVdtR3lSNDBxbFZ0dTE5ZVF2djVT?=
 =?utf-8?B?aUwydnJNNmU0T01uVnFoMWtwZFJPVXB4RjBZY2NFanBPOVIxV0tjNTYreStp?=
 =?utf-8?B?VGVUb01hVEZoRmxCUktIVWVyTGJIaHg2NWRUZjEvYXNwNnZnbU9MZnlCVWhQ?=
 =?utf-8?B?eDNSNmk0WUJoUk5YMEtXN0w2YzZXQ2d6aHBjdzYxcFN6UVlDUVdxMUZrTWRD?=
 =?utf-8?B?ZlBwNGpmNUQxRkFwSmdtb3pRYkpqWEZNb1RrVnlydkRHcDNpQWlieE55eUxD?=
 =?utf-8?B?c1ArWWNtUlFrdTRYOERkZzZyTlZ6SVV5VUt4QWd4cXZ4NUhHcE1NQ0p4MkR6?=
 =?utf-8?B?Y09JclZONG9VOUZXK2k1VFo1VCs3WW9hT1U1SDFwSTdqcGZJc3FQaStQMkJ4?=
 =?utf-8?B?RHE3MUNuZzEwUWY0cnFDUE40UGFJODJhRTNNMy9JMTd2dFJpVzZyR21lVUpC?=
 =?utf-8?B?RVpjYTBVRURZVzAyYVIvc3RTcG85RVR5OXJHUksvemFHc1J5OUlsNnpNUHlj?=
 =?utf-8?B?ckE0dU9rMUZudmgwZWlybXNkTUVoTnd1blJZUDNSZHhXbWJ3QjZpM2MyZXBH?=
 =?utf-8?B?THBGSnhZU1NUcENYQmhsQW5ib0ZBdnEvK1lQUGRvQ0hjYlpQY3ZNWGtIdjdz?=
 =?utf-8?B?MTl3WGJXMlN2aXFyVUVZOFZwZmV0cFBaMVdOajJOSXpWd3ZQbnpRdlAweEFi?=
 =?utf-8?B?aGkrRW1TVGxqRFEySzliMmp5bjVMOVd3REs4N0p3T1lhM3IxZGJXc2hSaTJq?=
 =?utf-8?B?d0sydlVlMUlvcjlaYUlwbU83WmNTOURPOVFEZTNMZkVMUlVIK0xFaGxhbUZQ?=
 =?utf-8?B?U2JMVUdmNk1paEV5NUtwaWNWaTR4M1ZJcDBvYm9uR01nYmFTWHRQTkhYMFpT?=
 =?utf-8?B?ZHdscW90NnV6M3Q1MnVzUklDdXlXaEt3ZE1ETXFUNUoxZE55Z1dmK1VXQjgz?=
 =?utf-8?B?a1BRNmpLOVlkQW9iSUk3alN2YXlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <235725F709D72C43A75F40A82EF47047@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ede960-b9ae-4cbd-43fb-08d9ffe7ae9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 03:07:58.0678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SoMJRVPfn+j8TGEGn6QQ6LwPiKmebQbYkConEk+x8xh3YzfA3jGWOyyGtH5GJuzmXvwD7U9L76DATT7ASqX8TA==
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
PiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8
a2NoQG52aWRpYS5jb20+DQoNCg0K
