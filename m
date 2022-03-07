Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4E44CEFEC
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Mar 2022 04:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiCGDGG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Mar 2022 22:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiCGDGF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Mar 2022 22:06:05 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A043D42EF2;
        Sun,  6 Mar 2022 19:05:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KS3Ph1QpDeELGBLRtuSie1VS11fguKJcPFY356136Iu5zTrCoX0Df15xIhWEugqfw5geA3u+dk+TpQzLK7pY7SSzJMdkPplvqb+gmMLxwqt4KrL5p+GBJAug8sc7aLUw3X+3LkFhDc86ba3KN24Mw/dyYio5Asm/zQv+9jpEpiJJGedtFG4Bv8llrl7ILr2J9X61rlyuII0sNzAjdRGfQ8q1+nBl4RJmNbSNSMICHSIX3qywEET/+GDxVhTX3mpEOPLSiYFI7k6KTKRH/uNWPecXQWYJ2nAZf1w8IaudXF5SqTO85DSwVh/ApAeaBRvXDy2RqobjOSe7MPTPFZZoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YbJwqahU02xGhlR4YaQpX6yTNa9EvB7QxmP5pbsmis=;
 b=QKlfixxy3x/e+iW0yrGwH26zRna+Dm95F3M+vCpE6Ddsbk53rMlz0GWzaudY5bifFd8sxMOTEe2cIVzWNCXR9zM1zvqL7kcrpGAHt0N99jS/hU9rtdlHP2LFOV04Ou6NHTrN40dNExUfOyvggEWfpg8pQBBZUrBRKF3uNs6D3plTuNMdojtGTFeXQgUA4IG0DlcBhbVNfHp42lNP3rOtlvlcERJE1gxioeuOueElP7yzMmadv8Hx9U9bA9n6YPwmMYHEoBkniqA3rpVsqXP7JExtxlgJtwW9J+xKLwYhJvEh7eZ8QIyTSvdb7DSNN34BespArtDGirGnW0+opzgLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YbJwqahU02xGhlR4YaQpX6yTNa9EvB7QxmP5pbsmis=;
 b=WuODQrNwUpgBZ205bBXtWGUO23/HlQqXyV7gkwNFTQpJnwyA66pl3kF+8Wd3D3q6MrHLxpmzXfqyYgeVMSBjEBIF8IrBJNgBGa1FF+u3z1Un6Ndn1uFlSIjMtQ6B0hUqtu0A1XdrSP0Zw7cXa0mBgfEqE2u/180OLoDFy5+F9LXMnhtH+o3OAj9twOzshM41NBXkumbR9XsurVKhdc/kfvJKHHXZI47UR8SBZDE4LdrNt7mzIhjI5CITv4uS+AVU40lycEkICzMxPnoCcly0tKaWJUtfOyptgf4DggAxzwGW7/p/EvsuDOcvjrSTMhPsBpM88Vf2AQ5yw+UbBEliXA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1853.namprd12.prod.outlook.com (2603:10b6:300:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 03:05:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 03:05:05 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Song Liu <song@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 01/10] block: fix and cleanup bio_check_ro
Thread-Topic: [PATCH 01/10] block: fix and cleanup bio_check_ro
Thread-Index: AQHYL/Hgn+83FMhmdkmqFwvtuNQY1ayzQGQA
Date:   Mon, 7 Mar 2022 03:05:05 +0000
Message-ID: <390e34aa-9338-df44-baa2-54777911c2c4@nvidia.com>
References: <20220304180105.409765-1-hch@lst.de>
 <20220304180105.409765-2-hch@lst.de>
In-Reply-To: <20220304180105.409765-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 394fdd8f-b4a3-47e7-6b66-08d9ffe74790
x-ms-traffictypediagnostic: MWHPR12MB1853:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1853D00290C3F81D550E6F4CA3089@MWHPR12MB1853.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vph5/CA+7Y2/tDcK8UttjxfJpK/Eid+BuJWWwROlaosAB58tvU3qAXi3MR+gfb+fEslMpOianIVwwlBjsCoxeuVWkUgZXJgY59VpWXPSAqK3tjK95siSwVqSXZK+Vv6fsU8i1lrBvbBJmZSOi8beOSKuhcFOm78D8TDGaesCvFnyoh1hgiucdwGyZjqIlZ5Fz5QWW2eWb9BzRKarc4GZRgEd1rPswwNTEvcrZTKf/rzfySg9lh9FJhFqSpxuWSB13l7MIMgsWAXjfrDMmjYEYri7s2xsLz1t3iXXOh+Soc2Ti12fKGn7j3u44WVHc0bl0G2Bu3/ucdf67RhqRQ3dUTX+xvPGQ5AGWifLyTPMFTOgvA2uSHodBl/BEZbPf8cL82+1RirhRuvZRNRtmc3L7zD+Li/Q1OHrqzLC39aiOejvpeUTvCQy0YaV0XfvPV1o7SaAz4kZK0zrTCvOGaQO4c+MEejLw2WIpTaqVOHAN31fz2KZ5EyP/A0rlOUBOYjSQZkzgc6o7Qw65OEMawLK4Di3S2h+5y+6WCfz6nYXcNH7mfY3VA2Coc2RoiP1cMmO6uhia/nn+Xb0hHrJuEvrInGkfvQoAF+Dc8rF5OYFYI1rOTq74+Daxkz6eNel636HVf7+3esxCcaXKDoLQ1Dkbu6AuwP0ASJjzJr1N1Sdtw61tS0N6C1u4FovxCZ1+z9sNUqm2xLsy9MbNKYW3+Js99fqaBwNCGCToXT+7TTHI8DqqxxgMgcBaSy6P844hYmiFdrZ0VFbRkXItqQjfDzFug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(4326008)(8936002)(31686004)(53546011)(66476007)(66946007)(64756008)(66446008)(8676002)(54906003)(4744005)(6916009)(186003)(5660300002)(83380400001)(36756003)(31696002)(6486002)(86362001)(122000001)(2906002)(71200400001)(2616005)(6506007)(6512007)(508600001)(76116006)(38070700005)(316002)(91956017)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFdhWi9jNElManI4aUJ3VHpPVERkSHJnc0RScG5SRUJDeVRPd0dXYjNGT2Fv?=
 =?utf-8?B?R2lQTXdHOEZsNFVDc3ZzaTZWc1hOYS9LVzFITUd4K3lzRFZhcHFtbjBtNzV0?=
 =?utf-8?B?LzlyeXYwanpoNXI4NHYwWC9QZU15WkpnclhJT0ZzQ2FBWTMxOEJjYjUxTVRK?=
 =?utf-8?B?M1FTa0ZBUVFpRXN4MEZMd2NqWHJNckY2WmJscUl3Qk1UaWoycGxrZ1dna0Rj?=
 =?utf-8?B?NG5MUndMVFJnSWlVTldPV0EwSVhWTDhTU2wwRnZKdkxNdW1jTlRBc3M1clpL?=
 =?utf-8?B?VTd5ZHgrY3dvdGhLZGwyMmFlQmJMVFJRdzRFdzdOWHpDVi9xSFhUeDhsbXIv?=
 =?utf-8?B?REZ2NHJjenBlOW1xQUZ0MTB4WjA0aTc2dnJDQmhUay81d2crUUUxYks2OFNq?=
 =?utf-8?B?ajdWcVpPc2oxcThuRlAxS2locGloMVN1dnZHN0RyYnRvWEhkNVl0SlBCVGhp?=
 =?utf-8?B?dGcydFptS0J0RlFpVHVjVVFJQlFENy9wSmZtOTFaMzNBRlJLY0t2S1JBbHRt?=
 =?utf-8?B?RSttWFdDNVVNN3lraU1LWGVRd3pMcG9ZQVAzd3ZodnVTRklnclRyNFRIdzU0?=
 =?utf-8?B?WUFYQjlqWWdOMlRXdGV5UzVBcjNETittZHc2OXpJemZmSU92Nzd6ck1lYmJX?=
 =?utf-8?B?RlBUeW1nQ1ozRUttaGFxQmcrYVJWMkJBVERBNDdoZTh4blp6N0FFaWRaZDF1?=
 =?utf-8?B?Y2gzTzR1dnJHZlg0MkRLakZGd2RqRnVWbUNIL1grZUJZcjkrSEpIbUF3MnpV?=
 =?utf-8?B?S3lmcHFvZTF3UkRUZkJrQnpLMmxjRXhwa1pqTEdjNmVMUXFxeXR6RzBDdnpD?=
 =?utf-8?B?RW9SaWN1WkFNZlE2bVNIZVJ6VXdoZjJaNjZ2bnIrQ0FQTzk3YWNwbitaanQr?=
 =?utf-8?B?cTE4Zm0wNjJZbDc0a04vSkM5Qy9XWWwrVW1vV0lkYnZOTFc1U2NHc0FPOFQ1?=
 =?utf-8?B?c2lsQ3FEMHJVMzlyNEI1ZVBraGdBbmExdkxpeUtpVVc0a1pRRkNrcmxORS9H?=
 =?utf-8?B?M1hOUXlmUmk1bkw3OHpuL2hGVWh2b3hodHhiS0FPL3lwZVJuVENvOXlUbm1G?=
 =?utf-8?B?UU56Zlp5VVNLTm43Y04wMWd3UzBhRjdwRDZOTmpaeWo2YWNEK1ZLNGcrYUIv?=
 =?utf-8?B?am13QUhRZ25pcTlsOFNuaWptRFJKaW9MNzlBUG4vRXduazlYTWJQMWZURkpU?=
 =?utf-8?B?akhsTm5vM3hKRTBVbEFLWXVqQ2ZEVFgwSHN5WUE3T2FlYWErUmVaTnFzRWZM?=
 =?utf-8?B?Vno2ZWg5WHZad0ZFRnIvaDNEeG5YeXNub1p0ZWRaZDlIRVQwTEVML0hYSlEy?=
 =?utf-8?B?RjFBWTNQejBDYXZIUy9Xb09Ybzdqamkyc3FOZEFiblhPeDBGVlFWUmw3U1hl?=
 =?utf-8?B?Zm94WXlwMVlRbFk3U3RDaHZRWWh1TStwOUxGZU1CeTVFenRLK2s2TzhJdDZl?=
 =?utf-8?B?dFNaWUNWUVZrcGtLWkJhUG42TVlWem15SFpvdDd0L1pxdk1SQ2xuZ2g2eEc1?=
 =?utf-8?B?TjVxYklsUk5tZ2RpUHFucS9LWmFEcDdDRXFTd3dYZ2ZpeE1QS2ZJaVRPQXdu?=
 =?utf-8?B?dTY1RTB2ZDV3ZUxuYUxmMFpFWnZhYzMwdGJSUlBDRklXRHNGOHFhOS9VK29P?=
 =?utf-8?B?TVZhaDI0MmY4RmRMRnRZaWFvcTF0N1I1M1ljWnZSZm9qL0hzNGZQZ2pyd2dV?=
 =?utf-8?B?R09BcXQzWEVqTXphZXJWdjE4eUROeUhuYUYvTjF1RU1ON0E4bE9QdHB5MDhE?=
 =?utf-8?B?cFZNMW0zemJTRlNoM0k4dVVYb1dzUEs4N1d0S05FRE9pbjNZRU5xVUVNa0E2?=
 =?utf-8?B?cC92R01VNFdxZzZrODIrVHYzcHBlTkx4VU1XTkRGTTk2czh0eStMdEpkYkVW?=
 =?utf-8?B?cFU0b3lvWDJwV0NJWURhckwxR1hwN3ZlODE0TkxVT3poRzk5dUhscm00TU94?=
 =?utf-8?B?c0p2TWhjYURqN25zREJ4eEVKdUtubWl5MHRmdlhpcDQ3Z1lhTk83Vy9XWHdz?=
 =?utf-8?B?VnloM2hjQVRKbEgwU3NzMXhORTVoMUJQbnQrWS8zVzhsRVFpbWVFaHVXSUN0?=
 =?utf-8?B?SndBeTBpRWhIc3F4OFZsWFdmOXhSNk1IRnNYYmhDNVptL21EdG1OY1A3ZVM1?=
 =?utf-8?B?ZnFnbVcwbzQ1KzlwWDI5M1BFWHVnV243VmNqOTlySDNMWXE1emJ6TXRpNTZV?=
 =?utf-8?B?aWFIOFQ0S0cxQnl1Uk8yY2RzSUpNN2dkamtyZm94bzVWMEpmM1krK09OTmpQ?=
 =?utf-8?B?cUtjRUlQMkdSUFdacktNTU56djVBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04B6A932C26F33498E7925D880426469@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394fdd8f-b4a3-47e7-6b66-08d9ffe74790
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 03:05:05.1717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgRY2GIjHSN+MEW1EX+EbxRQvTf9Gv8Wvivct0n7ZIZsKlorUs+ASqeTfePmHSevU6CCjab4l7jzG/4Bel04ZQ==
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

T24gMy80LzIyIDEwOjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gRG9uJ3QgdXNlIGEg
V0FSTl9PTiB3aGVuIHByaW50aW5nIGEgcG90ZW50aWFsbHkgdXNlciB0cmlnZ2VyZWQNCj4gY29u
ZGl0aW9uLiAgQWxzbyBkb24ndCBwcmludCB0aGUgcGFydG5vIHdoZW4gdGhlIGJsb2NrIGRldmlj
ZSBuYW1lDQo+IGFscmVhZHkgaW5jbHVkZXMgaXQsIGFuZCB1c2UgdGhlICVwZyBzcGVjaWZpZXIg
dG8gc2ltcGxpZnkgcHJpbnRpbmcNCj4gdGhlIGJsb2NrIGRldmljZSBuYW1lLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQoNCkxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQoNCg==
