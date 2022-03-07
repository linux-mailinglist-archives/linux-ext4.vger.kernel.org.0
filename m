Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E2D4CEFF5
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Mar 2022 04:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiCGDHf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Mar 2022 22:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiCGDHf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Mar 2022 22:07:35 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51FE42EF2;
        Sun,  6 Mar 2022 19:06:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwsdTt8b5LCxzqnqgjb+FC4nqIcPiZTUTEVxrZDe33FIdwAfu7dP2NYHmSyLNBZJL0Cy9bl2PcOMco+PMpJl8wQPMOl794+Mkt2x/ZrEBNULYtvfJIRy5q5MWNa56WtuZ9pr4hVcXaY+TXz/USdk4CcJT6WlSGjQaRnRvZGzdoY8wp7W/8KymBvIwY7LkrDJ46PsoDb8gAsylht0DPET9uJIRlgKbEAWWZvS7ZIBlhsKlFpXxPTbK1GKqGMQIvgVDNDK8SCB3TKdJNjeaoGd+5oE9NZnTJxnhTAZ1OJ1CBYmAZcD4IizCX23BB4n8gIxv63lXDX409638xAO2ILEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1ngMPnLdSAxpAL18hq3GNS7pdcJOhP5U4p76Kn6C/k=;
 b=dL0pPs5OvEB7jgHFYTe80B8Vj2ZG6MX5DAIQaTveyzSv8GIBn+nOIOb+bI76cs4wTK76zKpe0tmOBdOarY882nnnKeeu6Ay7McaUDb8O0XvpF/DX0uMnca9mHTc/PVbVBRLtfMRnfGrntIOlxuKuSLDJWwoRtnFvW5JwxeVbQPYzp3UQgrtB0zEjBV+nuXrB/nj22hKLOUtUh6vE/S9NR0cmO8j3j+kcUxynvfdZ9rXzKqBbB69mWC37EltqR8FrRGTlIqnDGcfis6RQOpk9fSrToW+KEEZsFzh52DkYWA73gX2JKfX83swYJlKPi4bcFiYsXTb5HMA15g2YYWhTZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1ngMPnLdSAxpAL18hq3GNS7pdcJOhP5U4p76Kn6C/k=;
 b=N9Mtv9452nc9XnXoxxCfY1EpViED0XVaOCTODgvVLR+RBJgHLfKTdfDhWYegvy9YJyOdekogcY/+TNway/9K234BeW7jrzpc7gGZ6LIqxwxoibz54m8f2gufDKqRCqp6U2gMfD1fCJ8bNr5tl4BquEfWyXsYeyMhoJL3cwbTv79dqfu5nLWoB+k/WGIdLu2k9lIJehQDRGNABudk/q9PU63xRyCyAIFIQkgXAU/kuyTHhXmnHpVch9RnnC+/HCnTiMCyRB4/n4jfjOXHraUaLWCmQ9QJ1tf9w8Tbj13dDsad7m1iN9vJbum20CHQuo3Q1x23CmX3xxXTTFg1S+C4mg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1853.namprd12.prod.outlook.com (2603:10b6:300:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 03:06:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 03:06:40 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 10/10] block: remove bio_devname
Thread-Topic: [PATCH 10/10] block: remove bio_devname
Thread-Index: AQHYL/Ha4HPZ3y8yxUiDBfSUyy/AWayvg76AgAO9GQA=
Date:   Mon, 7 Mar 2022 03:06:40 +0000
Message-ID: <044fed10-52ad-1409-b73a-2062f4b93771@nvidia.com>
References: <20220304180105.409765-1-hch@lst.de>
 <20220304180105.409765-11-hch@lst.de>
In-Reply-To: <20220304180105.409765-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f345977b-4a84-45e4-2d79-08d9ffe78053
x-ms-traffictypediagnostic: MWHPR12MB1853:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1853D0F7A1124201245AE166A3089@MWHPR12MB1853.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMUaTTvcCiaLlJYf+x3xRBken034PEOPBEBvMJYECNuiDR7ML6DaOuwOyZCgMcTYFLF+o1Wb0kRicowfv3+gGcAfZyLuMS+/tGZW7ShXH3/gc9FujAtRMG+FAYVGGFOUPmCxjQB4H32h5GYm4pHVNBvY3h8f/6xkn9f8Ar33aJqWnrK2mdpoD5XpUOYM4D7ovxaqWgIRuL2uXTLqt99oSR88rhJo6yiUsSxPxf/J2Qzj85irBc9AxpFotacK5hQp8d5ta3mGvwHx4F1FQD9TRQYHNe0FUV1WZtX/XSFacJa6aZjSxyirBY+wQSXOfEiMLVRyO1GCIyunCH6iZ4gOsHBihtlNu+6B2gPIjbZi/Uyvew8Oe+m/GKikzcgwjCarFqeY6F685i0DukJlGGt9/rTJNuPf2te5npDon9jbp7C1D3Le0RnPKZsGnHh0/rzdnh+1lSsIKU69sSZriaNLeRd4ov8HxlpJEtFrS6WUEU+2wnujdYKHNe0bJXxHtyqpiyjuLJUQFoq4UL5i6su8x7r8RB+3cAy3TMgnAm6aS1Jr9w42fdDiicVqSCIo+pIe0e84743nr6dZpZCOtl3U4wIPeXFLHNndu5ez6V03wpwkOvgB1rZ4qjuMelECwqyo1+SHv3D8hGrh8CrO/3H3cdAQTTDmOl66DfLXTey5R9X0LiJMIxDTEMjkChra7NYGdbN1CkkDJqI4ttd3JEi8207dcV/fClygA2iVeYhiADtskIfAXsjU7vu5w4m0SxkqBzVHYA2M5fWJTqLdohxoUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(4326008)(8936002)(31686004)(53546011)(66476007)(66946007)(64756008)(66446008)(8676002)(54906003)(186003)(5660300002)(36756003)(110136005)(31696002)(6486002)(86362001)(122000001)(2906002)(71200400001)(2616005)(6506007)(6512007)(508600001)(558084003)(76116006)(38070700005)(316002)(91956017)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUlhV0JrVEZ5YW5GeW8rSXZPbWY4WGtWQlgxSCsxb21oYUM0UHF3NGdiWmp1?=
 =?utf-8?B?WnpBSUxxMkVXQ1FRM1MrK1QzMDIwekt0VlFsNUNQTmtBOVJxOXd6S1pYTWN5?=
 =?utf-8?B?NDVtRDBUTXR0RnBGV1NQTk5NdzVQVExyWlBwOGdVV3QwYzI3dllkK0RVVnNx?=
 =?utf-8?B?V2RiMldBNm1hUVhtZFJiY0ZyUHdQN2NwV0VUdUFEVk9SRHdWRjB3T2pTV256?=
 =?utf-8?B?OG1CdW1YT2xUODNRWklsQ1NtVFl4SFVNTW9BMW1hcE1VRnE4Yzl3M1lPYm1H?=
 =?utf-8?B?RjdIZDVZaUgyeFIrRjQ1Mk9NblNIWFl1RTltc1RQUDBjRndNZSs0eVUwdXBI?=
 =?utf-8?B?RzU5Q3JGY29ZUGl0YlZkaEUvcHIzQlJjelNydGordDJrMlNiL3VLK1V4MGNn?=
 =?utf-8?B?d1F2M0JmaEtVLzZqYnNVcm5GckxHUGh2dnFacitRSTF2cmpCd2dINUdlTVhB?=
 =?utf-8?B?SHVvbE5zUGpJL1dqRWo5WG9BWDlWa25QNWRzUXlNOFJ6YTRIOVpSdlhDYTF4?=
 =?utf-8?B?TjFLNDJ6Z0FIVHlvWGs3d0N3UGRNVVl3a1hTUGxhb2diSyt5TUtoSTMzYWlH?=
 =?utf-8?B?NjhxR2s0alMrRFl5eHk3S1hjKyt3Ry9SYzRSTTRsVG8wbGxuSGJ5djdUdVVM?=
 =?utf-8?B?MEJWMjEycGR1Y1NxanlwNzVyU3RoUnhuSXRLbXE3SmpCOExBb2RyWmVOU081?=
 =?utf-8?B?Zkc3KzZ2TW9peXhDazBTTldaV2ZHZjRKNFBLV0g5T1NVaERGSlpqYTFuSnJP?=
 =?utf-8?B?TEZKd2F0V2RVU3ZmWFUzYzZQVDh5SzRLY291RHBjdFpTT2RZR3l4OWoraVox?=
 =?utf-8?B?WW4rQ09XaG9ZT1oyRWdjMVcvS2M2WmlPVE0vV1lDUnQrait5UjBYYk1aU09F?=
 =?utf-8?B?TW5IYWU4VndDQTJtcW0zSXp4cHFPQVJqa0VNSkl4Tm9ScVhZNUJZa2YvL1d2?=
 =?utf-8?B?dEh6b3FLOExNdkY5NTdtNUpFWmhjUzF1NEtCSDFTeDA5QTFWUUZicEJNOUs3?=
 =?utf-8?B?WHBQOHhHTTRJbThkZnBpOEltbjZpSWRMNHdoSXBIZ1laRFFYYlZoajJ3UDFp?=
 =?utf-8?B?NytPMDdwaUpFcnFzeWlRYXV2YWxmTnoydVc2bnpKYUZ5OXViYkhMZko1QXZw?=
 =?utf-8?B?VE5rOGNJWE54NHZwWTVBaWRkZlhkbi9aSXRhYm9CT2dMY0tmdXgvUkErL1dS?=
 =?utf-8?B?ejJ5QUtDcTc2d3k4RGhGdFlsSjlLUHdVNXZOWndrQUJXc2h5N0VVL0JJU2dQ?=
 =?utf-8?B?RVh6Zy9XUStnOTFwUzc2dWo0S3MzeTB0bTlBWGgwV3pteWZwM0R2UzFCN3Rk?=
 =?utf-8?B?WkRkdHZRdGM2aWhLdStKMXpwSEh5U0hib0U0ckF3L2hVR3dYOU1mdmpGSWpp?=
 =?utf-8?B?YlJiUGdyR3E0Q0ZldnlhQ2IzM012Nk5kTEw2c3RsN1A0WU5kSitrdGh3eER5?=
 =?utf-8?B?aW1iY3VTbVppNHVsdnNoRGVmU1Y2dHo5YjNvUm5pU3JZR3VGZVUva3hGUHJP?=
 =?utf-8?B?VWVpVWtRd3FlQjZTUFBmUUVIbXNFb1RxTXRWbS8xUFFFNU5pRTlBNmczZXMx?=
 =?utf-8?B?YXdaNUxFNFZvK2NJTWlZOUdBZ3VySUk5MFBzYTUrQ2RTazBOZ0prT0hVbjFP?=
 =?utf-8?B?Zitlc29GZXo4QXNyT3dhVVZ4SHlSZWRPM1lQQnFWeGQ4UHFsVzJSalFPRHNu?=
 =?utf-8?B?NFE2N05NVU5CL2hGWlgwRVUwSVd5ek1VOWhyQ0NVRFJVdFFZRGVUVU15RHBr?=
 =?utf-8?B?TVU0dkNic0JuYm0vbmsyRUpvVkNQZHo0OHRRWWFwclo5RUllam0rL0toWXd5?=
 =?utf-8?B?QnpZeXpWakNWWHRwZThuNkx2MllJKytnelU0bjFQUS8ybGRRK3lnRG9kZStT?=
 =?utf-8?B?R202Z0hWV1h0Vnd3bFM2ckFoNEpycnN4SUR0VTlhMmxjQlhWamE3WW5aVXRE?=
 =?utf-8?B?SFFXVnBsWDFCeWdxSlV5cmh4ZlZpZ2V5VjVVRWJOT1dKLy9aalVzei9PcUth?=
 =?utf-8?B?cmMvSkM5SldOSm9lYkE0QU5HNVMxeWwxbG1TMjlVRVVjbGs1NW11Vk5PVjBV?=
 =?utf-8?B?NWxZSDNTYW1hMGVJQ0VyRENxN1JoQlRDckRLak9Jazh4d1Z5MFlRZzdQNEYz?=
 =?utf-8?B?Z2ZiTWg4QVkvams5dGNnUkdxQWt4Z29uR0ZSemYxNnREWGhVdFROa1lYNkIw?=
 =?utf-8?B?ZElLWGZLckVwMnNjN1hveVlRZGVNTW9lcHUzeU9PZ2dabFd4SXRyMHlSRVds?=
 =?utf-8?B?VGRES1ZtVnVBT1FsUjlTQVcwYnNBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D20E32A337E3944E87F992B79236EEF6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f345977b-4a84-45e4-2d79-08d9ffe78053
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 03:06:40.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wOxLnm9YYBGwVE+/72wE32kF1sMVtlCp5JEzDD8h8NQqOOIyGlhKwvuJNhE5rbk1v/vuyWaKvGLAOnczDtXyBA==
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

T24gMy80LzIyIDEwOjAxLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gQWxsIGNhbGxlcnMg
YXJlIGdvbmUsIHNvIHJlbW92ZSB0aGlzIHdyYXBwZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQoNCg0KTG9va3MgZ29vZC4NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K
