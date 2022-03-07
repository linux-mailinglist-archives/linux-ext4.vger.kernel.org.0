Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBC34CF004
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Mar 2022 04:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiCGDJM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Mar 2022 22:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiCGDJL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Mar 2022 22:09:11 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7D41EC60;
        Sun,  6 Mar 2022 19:08:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+IZV6Mfl46WaKaBrawPZyIWrmDh3doj0B2x4nYV6+HLwyWbCgkyMTnALfMEmICR2QtfZTpZ4/RNWEU75d3UarEySCFapnw8WhZffjSKVrYy4iWIRwyXpqRK4whfku+ITBqot4mi2+44uZFAIqgjyGm088Z47b+jJKasylMnoMai1+O5QuWPy/+oTpe8OIM6PJ8OqykI0qVqiRXhUG0eOEDQTSe6ym1uOM79m8z2+MyscvRIn5moOwmbdkdkmTasxJwZzFhMJDylxevzeTpaDw+4e0UDiUrUNzSbtJItu29XQuDZxyDeMeFB0STZWkZG8NPcIJWi2nsDmVq4PawLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UNjSo6K0ixjAUs6vpajGrqAdKmv2OyjMdNojVm1JnM=;
 b=Quqo9EQp2rMQ3yYjyIu1m5SKLlaw0+6QfqkS+y9Rm+RJELOe9hhqYjKiTYG+nxlcsgpVLqGfl7aVR+vDobUvgl2jYr4OoSqx9WWH7ccqYlowrP12hnEM/xNhMBAGST2N6XPoo3Qj+3qJ7ru+suJXA779wBqbbe3gMcYKmgGrLGknmlk3hk1cAnZbjqaqFnK5dK2VdIwe3dQK5Xo/skHHEhW/yfdhjSHgYXv/4FriDJKTabJcHm7oAGWHi67L9w/P/f6BjI7YMarsdafsFYwRmKQCbO6n6AYZbpvI6wozITQo001EdJDtCnV+u2WiBVLcIGV6T0C3/ut5uI4ASQLWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UNjSo6K0ixjAUs6vpajGrqAdKmv2OyjMdNojVm1JnM=;
 b=E/6nSny0hlcF0WjlTb1Nm/An+jvay4ghsuD3rzKRr1MAbE1mXCuWXmquyRRZt+I0Tjp7l6pm/U26HyPOkbt5gdH05UBN0L2+XKPjSHVI0k5yIkOTl2GAnkIoWG/CHb18/AGf9Wi/M1Gbzdp+H13vdMy9JjRXnbrcZgpl2GzwAifnu0HUUZiG8H8VE4royulXNRh3cg3c6ftpQWe6XJnuMIKQrOGm9cUQjBVsL1i++pftvSYi6SlWdsF+YYnddFTZBwgEoM/4ZypsggIFzWm/ihm3jroKDuqiB/EqT5c41t6h7j5KKwXjmyR37LBfHbWYitwvnKsFODRJ03cgsVMH9Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1853.namprd12.prod.outlook.com (2603:10b6:300:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 03:08:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 03:08:17 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 09/10] ext4: stop using bio_devname
Thread-Topic: [PATCH 09/10] ext4: stop using bio_devname
Thread-Index: AQHYL/HuUDXzwrzyXUuMHFGoQlnyHayzQUqA
Date:   Mon, 7 Mar 2022 03:08:17 +0000
Message-ID: <59a8cd9e-2b65-d318-27eb-c1b28bf576c6@nvidia.com>
References: <20220304180105.409765-1-hch@lst.de>
 <20220304180105.409765-10-hch@lst.de>
In-Reply-To: <20220304180105.409765-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af74e447-da39-42af-b694-08d9ffe7ba25
x-ms-traffictypediagnostic: MWHPR12MB1853:EE_
x-microsoft-antispam-prvs: <MWHPR12MB185318DFAE1BE35857EAF36FA3089@MWHPR12MB1853.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Vj0C/RpDb0ULFgU4tT34TG+U0XOQPzoT5KZR4yX+lEfp7enkmq6uC1HmEEoSlG1GXmyY70QHSpBPzjtn3nRwyR1y30veaS2OXOSSId3djFiNVjGZXbuyy7dPJMJwjxtatKCa3xVrLYLDUG/O4bbsZ/L1GyRJg/H6J/t7Lk2yDuc3qhYg9Wj7z+0P8yM/m0X7cSLV6LAAyeSlQdSER0YSR0seIptyZ71HdryBFLpcEVItofPoUg1Oie2K8Neuupi9AL8uiRlpo+iqR7GjHvKFqlW2w5nj1mpJGJvQGY8FYqp91yG3G7hQd8Tr21MVqs7BBiLMPbA+0CDziaqfZ5AYOOMLxnOOHpjOcFRigD3vgZsJmK5L/Ah/b6kQnVSzUd3PNtTnPB4Snzt18i21c01U5fPslSXD4kih/xGLxD8e188fmq9QbfJMwwZZpWYkXw7ec/arvn42YxmeetxQ8kh2R+5X49oqXb8qyauieNlvkkeOMMKzcE7K7bIw5V+ml4uwa1sM7wwFHL8YaH3jV7cHEw5m/H0GQd90dj/10ZpN31naliCSqlKjsDA0r4VdF7wftKUAARU7s3PcOyWdvPmvV/emOTot8Xq2TipkqgLbUSqeEIrZoyjLQEC2D829lhVdtCBVOGM3i+TzV8hZ5WZb2SFOKuKNEJ97JR1YmEf0bq54ePt9NpYoHUyTWDOci2Js0Cuqnvd9LPTezJ+spmmynqwJebBu4qK/WWGLo5V3mlB3l3HuyugendbxAAgTbW1EkpMWLteSdFfw6efLdwRdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(4326008)(8936002)(31686004)(53546011)(66476007)(66946007)(64756008)(66446008)(8676002)(54906003)(186003)(5660300002)(36756003)(110136005)(31696002)(6486002)(86362001)(122000001)(2906002)(71200400001)(2616005)(6506007)(6512007)(508600001)(558084003)(76116006)(38070700005)(316002)(91956017)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K29vUW8vQ3lNYkxITVNEUFlML2ZoZ2pPd0IyNzhsRW42MXBWcUdJOTc0cmRV?=
 =?utf-8?B?YTc3dGw2R2V3NDhxNjUyUUgwTjdVbi9YVjBxdWxrRjM0QkY1QldsZGFldGhF?=
 =?utf-8?B?TGJnSjE1czl1UjNHR3hvNXpCUDBEdlpSdUdKVUF1czJHcUdXU1NXK2xyVjRh?=
 =?utf-8?B?V0sySmR0RmZoQVNPNTdJTXRZUUlxQUVka0lmTG40aGM2c0UyVDdDTXJQOXo0?=
 =?utf-8?B?YkNGRURkOU9RL29zbXd0MTA4akV1SWZwVnNmNEFzMlNqalVEN2tOaXFNVk9w?=
 =?utf-8?B?L3NZaGZFQWpCNmU3YWdvM3p4V0JHNTJkcTNIV3IvMm1rZzJYQWRCY2xjayt4?=
 =?utf-8?B?RXFLMlBod2RHV1o5NzltSFp3MXlwVkJsazhyU3hjYWJXZHQ1VzRuTE8wU0VR?=
 =?utf-8?B?dHNMSE0zL1IxeTVXUEozUmV0aUlHL1NyVytnMUsrVnhUemtHMFd3RDJQSnor?=
 =?utf-8?B?b09JZHFKcFQvejFNNk9Fak43VC94TlRMcGI3RjVhOERnZ3VVbzVySExWWUpk?=
 =?utf-8?B?OUJvSGtLYWVQbFNDeml1SzgyL3pVRGt4R0svSUcrd2hwLzZwQ0tOS1lTWjk5?=
 =?utf-8?B?aUVKVVhFV3F5eFF2N3FCWmkxUFRGYVVwbWpxQWs3VnJlRkVWZ0hWL3dvRWFN?=
 =?utf-8?B?ZVdqNHpoSUszY25vZllpZmRldjJXWUhJSk9NbU1wNVhQM1FKa1dUVnFCMzdL?=
 =?utf-8?B?NUxJcGlzdzV5YnlVL2lBNlZBMGM2NW5NOUdQdHFpa2dLamVjWWtEVit6WW1S?=
 =?utf-8?B?SWR6Z01yUW5aMWZodjl2UlE5U2owdWZMSmpYdFFxR3NHc2U2RFdqWlpFSU4z?=
 =?utf-8?B?MkxtZ2ZsSmZYQTRydWtXa0d6ODY1NUltZmdFMFhXWkFQSWdUbXJYR3Iyc3R2?=
 =?utf-8?B?MVNlZWNxM3JCK3VxTVdBSnB1MDBBNFA2eEROcExwa2JvTHhPcjJ5QkMwMi91?=
 =?utf-8?B?b3lMc3Bpenk5L29SSmo0RHV1L1lRRDE4b1JMZzNGMHh3dFhCbzhGOHdLVVd2?=
 =?utf-8?B?a09XWEdCbXZ0NVFZQW1VL1pZMlc2SDFoZjJvdnd0MVhhSGhkdnJiVDhEVEU5?=
 =?utf-8?B?aGx4Z2xxY1dQclJOUFBtYlFBeFlZamRCcXNsUCtYc2ZSc2xQSWM1YkRRS2tz?=
 =?utf-8?B?OHY2Qk5zdXh1ZHBmVjdtRmN4UkhuRXA0ZzQ5Rm95VVVHNXJNQi9TWkdWMTUv?=
 =?utf-8?B?M2cvK2J4eVR6WlRxK2hzOTV2KzczNmIzZXBwakpLVTBIbHdRT1FDMHdBcnpN?=
 =?utf-8?B?NVpxSi9Da0pMY1cwQzNPbDUvZ2J5aXhRQ3l1YnM4R2ZjcnQ0dUVQOWZhQUNa?=
 =?utf-8?B?d0ZGSWN4V0FJSVlOdm9VU1VOcTFEMDFlVWZLNWZ4UnFyT2ZKcjJRT1FjSXVl?=
 =?utf-8?B?aFVYdWJvdUlJc01yL2hFc1I5SlJTK0VtbFZCdnBTTkZ4YXoxNlBWaGZqUWNK?=
 =?utf-8?B?dFM2bzl5eVQ2WmxDMCttcU8vc08rSVprTW0vZnRoZXBCVTcvOHFNV0RGbk41?=
 =?utf-8?B?TUY2K2NZUGVYT2g3emJ4UzRhcFBIbVdTVHRvUE1FcG15bEhIS0N4MlYxcE9N?=
 =?utf-8?B?R1JUcmkxQTNUQWlzMUxHSmNRaGFVZWlUMnNKV2dTVThhUzBEYzdJL3VvNVhM?=
 =?utf-8?B?R3VuTUhnWENSZWJlaHRGMXd2K1JOREYreHU3Y25yYUR2Uk1xMkFhZGowVHhK?=
 =?utf-8?B?M0tlSUduOHllNjJ6NlczNW5vVGliN1BpRjJteGlaamdBSU02MVhWR0xKTVhs?=
 =?utf-8?B?ak1jUkNnV1p0Zk9tZFlmQzVEZHYwVitjL21JcnpBeFFRUmRsL1BVWDJ4ZVZG?=
 =?utf-8?B?V1lNTjlpOFM5WjNBU0F3alJWNUhRQzlvOFRnYTg4RVlRNFRSVDliV2F5djdU?=
 =?utf-8?B?Nk9wLzZudk5tSTJ5bnFWWFIvVVIyRitqWm95bzBkc0RQYlFtYmxaVzU5a1V0?=
 =?utf-8?B?Z2RHc28xRzdCM1ZIcm5Dc2FXZU1yRmE3SThURDlBdHdSSHFXQVUwaHBMTEw5?=
 =?utf-8?B?cHBTRS8xNVV4a3NVWTB6STMzT1hDSDY0T2tQb0kxeUt1NDBqQ2dRMVgvN2gv?=
 =?utf-8?B?T0N6WExWSGZkaTJBbDBONEJ0c2JBSVpiQlVaQ2dNZ2lUeVJieXptZDFhTEFC?=
 =?utf-8?B?NlVHS2FvMkdabTNHUEs5NHdPNUZvWnl3VFVCRUZpcC9TQTFZcHZQSllnNXhN?=
 =?utf-8?B?eUF5ZW5LVnJMbE5EQnY1VjdGWGJjZGVpU0V6Z0FlK1R4SERFVU1jK0pSSkRp?=
 =?utf-8?B?QkNra1JRNml4VVY2cVg2L25iZHRnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75DE906AC86E314FBD6CB6729966FF3C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af74e447-da39-42af-b694-08d9ffe7ba25
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 03:08:17.3947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VVsUfYMbpDamF9q4rdiY/dxE3SlLifbBSTF5Cyo4zlHOOr/ucdgIdaDMvTzLvjtLvZ2eSwOri5c9UopVyFgOw==
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
