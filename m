Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C5677D93E
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 05:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbjHPDsG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 23:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbjHPDru (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 23:47:50 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD892698
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 20:47:46 -0700 (PDT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100]) by mx-outbound8-109.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 16 Aug 2023 03:47:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/6BdT+vmuTLqrhL+wjgO7RBNSkJUaBfqTDBXr7kkewUzzUn3SFQrCId4LZe5nw85gSqQn8NBO36Fcu6Yv0BKZIOw9h9nVLjbOmLxoxpEzm8ON4al2H3JU21wm77lIiq9dfKaf+vGZlo/s9nxj3eg/djLfm1Z7dzOH7LXU6u8Eo2dJ2IlqCi7bvxenGa9g8vkyY1iW1PKKlFWia0nXE11uLokj0ui7/rHgX8WMyzNVO8La9I8GSAtAGZGHgv/wWKuODcdNbZe+Kfm1SBzs+6KXaUW6eiAqdUafFZX8EdrrbhJSiZW2CmvVmApK/92QfTMvMjFmT/Tq95/1I2HtL3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bv2uV0YeewOVgylEN7n1Uoz/jkyjUK6Dob/GSkTpYK8=;
 b=OhPo6+O67QYjHGXurtfJe7lu49ECas8gs30og+qBC9FFz3Xrz+7InML8VYxzidbSr+S2cPGT9lodSwgLSQbzu+r2LZ9y8WPEcH/mnOqifG9mVuhVFZm0Eri6GdkZsGYGQT97kZosfWFV55t+yeMRKAGWbp9Mrqpx6JF9FSaQv+Eg19Yx8jcqzyojP8J2A7j+kMHGbD8StXxuSAX9z0WR3AO7lhHZYN7b4EBZgJAWXBRWn6ARVmuYWSFSn0VuDVXKDEEV1Qg2xlcBKOzzIVZphdiq+zAT9FsXvxPGhRopIIRKVSJMIR7jPZ6NTEPcSbQ2uya3BEPF9B7K5EwSV9e/AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bv2uV0YeewOVgylEN7n1Uoz/jkyjUK6Dob/GSkTpYK8=;
 b=y7njcX4TEkLank6ABvfk8BeaPTFrjLaL/o2JIiYknVKJbQROzm2SVnibiR0VN41nEaQtDn4E1jtiiCeThgVnLsVxedu6zpN2Y7Osc3pGhlnDMJgJqE3CCEl/0CD4P2JWXgjGmVVmofpuSmkBUgMo3MAAPKXWgaWdE2D1NyMsj90=
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 BLAPR19MB4290.namprd19.prod.outlook.com (2603:10b6:208:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 03:47:40 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 03:47:40 +0000
From:   Dongyang Li <dli@ddn.com>
To:     "adilger@dilger.ca" <adilger@dilger.ca>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Shuichi Ihara <sihara@ddn.com>,
        "wangshilong1991@gmail.com" <wangshilong1991@gmail.com>
Subject: Re: [PATCH 1/2] ext4: introduce EXT4_BG_TRIMMED to optimize fstrim
Thread-Topic: [PATCH 1/2] ext4: introduce EXT4_BG_TRIMMED to optimize fstrim
Thread-Index: AQHZzBu/wR+H/i4Aj0+Ve9R6i+Yfzq/q06cAgAF874A=
Date:   Wed, 16 Aug 2023 03:47:40 +0000
Message-ID: <b0669f96efa729cdfb43e6f8ee94939b62c0575e.camel@ddn.com>
References: <20230811061905.301124-1-dongyangli@ddn.com>
         <EA9B393E-D7BF-4D47-96EA-661EB96E9F14@dilger.ca>
In-Reply-To: <EA9B393E-D7BF-4D47-96EA-661EB96E9F14@dilger.ca>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR19MB5711:EE_|BLAPR19MB4290:EE_
x-ms-office365-filtering-correlation-id: 93510fa8-913c-4997-4eb1-08db9e0b8a12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yh3AsXTmX7Aa9m1MkxEDWDrNm/5uZf+/u9OizGcwSIwmRYkPO9MK8Ua9Gri33xpajzQ3rKm3ClCIrc4D0yp2HYUQXme2G8GKrtSXVjT34JfEDUD6jX07L5i/r68cqCYHOwE9wHkCxhV6ie96EIJp5SuwmCXoop5QbS7/US/CPb5f+JeUNldJ6GetZn3WdHLu20/3zQwOXdXR8j4HA60gl38QSs2l62cLOBlsry+bT7uqyXw5LjRRO4ai7eR+sh3sE9QzBRGjod4UtOKlnzRIHj681AKLmHoTpJLYnzI8I92eM5Q+pnrbsjA0qKcx+Cqf2p7doRqdvmvTUS3qvz1sLcD8HiHRC5Ep4d5rYUV2mJlJVfz4n/Vz3LLj+dymAa8KMffA2drxW0erBCk/D7U+SWR8KBP07RK+wu8SDQ1O5dljDhk1ZPlUBLI5sCKd3uaQ3RI7t6ybb2NFbDTMNrXogeYWrWHtka/QN9DiChVhaYZDyTnB5qTFpZMHAwSl1cgJNdPVnbjb3ytMJJ0Fg6pIxLe+iHQ8NwkH89CZzA2+6jjAfTJeQMwQTHj0v06OW+QxM8wEwUeEn0Ilv1AzD6QAoDgvIZB0UfeRqAr4dH5+peJbnAjyXUAvxDgGggPcPmnE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39850400004)(346002)(136003)(1800799009)(451199024)(186009)(71200400001)(64756008)(54906003)(66446008)(76116006)(66476007)(66556008)(66946007)(6512007)(6486002)(6506007)(2906002)(478600001)(26005)(91956017)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(53546011)(55236004)(8936002)(4326008)(8676002)(122000001)(38100700002)(38070700005)(36756003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVVuWE9EUW1LeGk0SHhZeHBPQ2NSWHpxektudDJJOVRza1VQLy94ZklkelZU?=
 =?utf-8?B?bDU3aGRKY3A2ek1lN21XT3ZmV3JUY2J4VVVDN0d4ZlNtaUdrbXlXOEg0VEF2?=
 =?utf-8?B?cHpZZjRMb3c2aStCaE1CeTVMVmN5UERWb1VlOUdXVGVXOTB3QzRHL2g4TVJh?=
 =?utf-8?B?clBsZ2FsSVo4TTFOdSs5N0NZMU1CUzdvUm00NUJsRkIwaVhDNStGV2E1S0RS?=
 =?utf-8?B?L3pFTUt6WExqRytRQkJER0pWeDhiempoNllwZ0NXMFJRMzI5eSs1U0VxeTVj?=
 =?utf-8?B?enJTbmQrOWpRZTVObWJXNU1HdXJqajlUdGlrQitFbU5YS3BFbkZuS0NVOE1G?=
 =?utf-8?B?QWpKWU02bU5jRzhSSUFxZEJuemdYSnRCdXhseHVHeHMySENnSnhZbEYvZElr?=
 =?utf-8?B?aTJudUloVVhIQUdJTk1XTUx4MFBqTmhDVmkyOC9qMEM4bDhZVmRJUjNaYmJa?=
 =?utf-8?B?UU5tUzI4OXRseDdTMy9zZnVxZmlWYXAzdTdFTkV0aG5SSkNCNUpuWUp4RFA3?=
 =?utf-8?B?T3F4WjRMdDh5YmtidFVQM1Q5ZlB3UWozb1RKVkhuWDQ0VURYaDJJOFB0ZjRX?=
 =?utf-8?B?clZycGdZZHZZb1dkbWV1NkIvMjR5WmprcXpYS1ZpalVaMWR3a0RPeVpOUVRM?=
 =?utf-8?B?aDY1aVVNNDIva3RhRmZNY0ZuSU1nckV6UnkrZFcwek40Z2pyQnVvTFhrS0E2?=
 =?utf-8?B?eVFObVFiSWU3WEtMUkpFQlViYjR1N0NyUksyenl3UnQ4QVhwVkVDZkRqMlZH?=
 =?utf-8?B?QUFPRlZLZVIxN0U0Um0ybUdVazNTb0YvYUNpMzVSVHhlbmR5b0ExZ1BsK05a?=
 =?utf-8?B?OUVDTHM4cGpkRVhsS1Qzb2ZSYWp6akNNYjdubTZBOUVhOWVOa0JFUXpiUDBK?=
 =?utf-8?B?SVp3L2Z3U1JkNkl1T0p3T2NidmVaZ2NFS3BNeDVsbktBVGI2NmdVeStkcGFK?=
 =?utf-8?B?akU5ZmlONldFdmlDT1JVckdlY3E0ZUpUcEVaem5MNUNqS1cxeDlrREVzSHMx?=
 =?utf-8?B?WjV0c1YySEJEQWZmZitnZFZUSmZBQi9CUWwrSGxOZVIzSXZnODg0ZEQwanBR?=
 =?utf-8?B?L1RRdStFY0JYbUltelh1NlJtM3dIWFZZbW9GVG5SUEE3VVlQYWVkNlJGcDky?=
 =?utf-8?B?Sm5NTEJOQXR4c3hRU3RrK2JtU0R1cmFCcTNYWTBIV2tOVW84TUR5bWpVSkdx?=
 =?utf-8?B?dVpaQmhLS0cwWk1vMDdMelBLWEN4Q1ZYUkw0aVJkaS9WV2JNVXRYVjN6NUJx?=
 =?utf-8?B?UlJkRHg1eGlVaEp0MXpWZHorMyt5RjdyYlQ4N010TXArMGorWTNOd1VyUnAr?=
 =?utf-8?B?QkJiMEFzakl3RXg0ZzZhNEdSSnNQK2FYZDlpSHZnaWMzNFF3ZkZhK2hHRTUw?=
 =?utf-8?B?OTNyU2FweDdzYzhKRnV2cWl2L0wvUWlCcnRiY3E4N1BnZHBPLzFnaU9KUTA0?=
 =?utf-8?B?TENhMVpha2R1dFdETTU3WVpkeEFlb2ZaUGZLdjlUSm1DMTNOZ3NZQ3U4MXJi?=
 =?utf-8?B?Z0tVcjdDczhHc25vQW0wVStGeWZVK201MTJDSFBHOVQzTytyNzNXeDlvR1ly?=
 =?utf-8?B?VE55VWxQOENnVW9iZGJYbXBkNmI3SGkvYnk5RmNMSS9HYUo3eUN2TGthRU8z?=
 =?utf-8?B?VTN4QlNhdEovcHJxNXNmMTE2UlQrdmpsWGRXOTB6SWRzLzh5Ry9TRnJKTGhB?=
 =?utf-8?B?dnJUVGY5QklGUG1Hc0xaRFZHVjVTNE5WSVRjVXFXVlMzdjdLSW5Ta2x4QmVC?=
 =?utf-8?B?VHNhSU5LejRSSWxhSGpGaGx4RW5Ya3hnWUtxMlBXbjJubGlyd3BPRktlZmcy?=
 =?utf-8?B?M3V0NnZSaDVLcTlrZXgwZllrWUpuOXU3NDVpaFQxMWhIamMzMTZtQ3duYm4z?=
 =?utf-8?B?dVNXb0lhN1lPbVYyTmgwdmdxaWY3UFQ2VHVkQ25BRFNqNFF2V2hrQUFRR0hV?=
 =?utf-8?B?a2RJa2dMMGplN2dlSzVQcUVxZCs2c0xtZnF6WnBqc1RZVUNreUw2Nm5ZMmJH?=
 =?utf-8?B?cEtZYVozT3QvRm5HcFUreElRWHdaZk5HanFVR0pRd2owQXJTdXRJQ0JZTC81?=
 =?utf-8?B?U0tER1FrdDFHYTdGS3hISHRobGdRSDdhZUlOQXFyb0t0Vkd4VlFMWll3Mjg5?=
 =?utf-8?Q?KeU0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE9156075500EB4599448C65B139F868@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kb1ZMMPKcQqiaDB0Ypi2K8s0kTWJbJW8Cpk5+3xMXR+qDTKqCPJyH1zFuvG5FTnMyFqbrHE3mcblRb1J/dyKgtYMzk0Z9FW2+sDtTCvna6N1Lvu0HXrIQ9Y60mk5rN/LsTuVka50Z2pxb/HxaAgPvJmSb0Iw43FU/NO6hLGAnp3XpScRy221g+kOjgW1h7AcYRMKFgxcos/h20ABvSVWVxr+bQOLZDqecrgiik2Afq0ZDXjT3Bq58ZKOKRugX2lECL/zpQUO5ljTcxNSu/YVe0+ITO5RyjBqO27eDDWFl+O8ycNxzslEX//DGgLiDCybSHgx1C1PoZuZ0PJIBXeB2rYJbIT6CS+FIUM11EyjyJm4QNNmshsrUrL8lItPlHcfV6pSAq44Gbjmg1MUUfQM7QJwOuawRoA21r8OAepBV695iD+qLbz1GtqMAImiC8jBYAWdGpJQh3NdgoxI3wEeNes6Ug296ntRci1VnitvsIC/CLX89C4RbWQNk4iYUJnS5X0VLTvtvj7qVDWnYPMAZWudtxjZBW4Z4BD0uNEV3TGxrvtXAqyhdnv1E7OzKleYWXnYIndQrIS8FchDAabcgIsRCbv0r13uJdp3pegaQi9cIPJhmvhpaSiiEcCrwu7yHyZDw919w/v4iZunXOTHZxOK+OPDKbyNyJjYk8s0XH0ZSigOPJwMrRB3J/sS+s3hGndWbTujHOKAn9JTTNDuUBeLBHimiTla8FMPj4deoBCcliV3fmcjIAz7XcDletyd4d2fL3F3fPTsN/Rn+vo/groQ1zNfA2n0G0a7dv4Dty5ZcbPu8TTCUWjcZMrM4kZPh6HKcrj9t4ce7glP839XfIQfbVi7A8IRb4c2Tp3Hr4E=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93510fa8-913c-4997-4eb1-08db9e0b8a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 03:47:40.1058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4KmcK7Kb+iw9GsTX9+89yUyNIwju5beKW4oB466kPq2jGhmEvl4LDTMsSw9fCyQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4290
X-BESS-ID: 1692157663-102157-21921-35828-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.58.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmamliZAVgZQ0MjELNUkOSnJ2M
        A02dA0xcgizcDYwjzJ0NAwycjU0NhEqTYWAPPR3JhBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250174 [from 
        cloudscan21-193.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

T24gTW9uLCAyMDIzLTA4LTE0IGF0IDIzOjA0IC0wNjAwLCBBbmRyZWFzIERpbGdlciB3cm90ZToK
PiBPbiBBdWcgMTEsIDIwMjMsIGF0IDEyOjE5IEFNLCBMaSBEb25neWFuZyA8ZG9uZ3lhbmdsaUBk
ZG4uY29tPiB3cm90ZToKPiA+IAo+ID4gQ3VycmVudGx5IHRoZSBmbGFnIGluZGljYXRpbmcgYmxv
Y2sgZ3JvdXAgaGFzIGRvbmUgZnN0cmltIGlzIG5vdAo+ID4gcGVyc2lzdGVudCwgYW5kIHRyaW0g
c3RhdHVzIHdpbGwgYmUgbG9zdCBhZnRlciByZW1vdW50LCBhcwo+ID4gYSByZXN1bHQgZnN0cmlt
IGNhbiBub3Qgc2tpcCB0aGUgYWxyZWFkeSB0cmltbWVkIGdyb3Vwcywgd2hpY2gKPiA+IGNvdWxk
IGJlIHNsb3cgb24gdmVyeSBsYXJnZSBkZXZpY2VzLgo+ID4gCj4gPiBUaGlzIHBhdGNoIGludHJv
ZHVjZXMgYSBuZXcgYmxvY2sgZ3JvdXAgZmxhZyBFWFQ0X0JHX1RSSU1NRUQsCj4gPiB3ZSBuZWVk
IDEgZXh0cmEgYmxvY2sgZ3JvdXAgZGVzY3JpcHRvciB3cml0ZSBhZnRlciB0cmltbWluZyBlYWNo
Cj4gPiBibG9jayBncm91cC4KPiA+IFdoZW4gY2xlYXJpbmcgdGhlIGZsYWcsIHRoZSBibG9jayBn
cm91cCBkZXNjcmlwdG9yIGlzIGpvdXJuYWxsZWQKPiA+IGFscmVhZHkgc28gbm8gZXh0cmEgb3Zl
cmhlYWQuCj4gPiAKPiA+IEFkZCBhIG5ldyBzdXBlciBibG9jayBmbGFnIEVYVDJfRkxBR1NfVFJB
Q0tfVFJJTSwgdG8gaW5kaWNhdGUgaWYKPiA+IHdlIHNob3VsZCBob25vdXIgRVhUNF9CR19UUklN
TUVEIHdoZW4gZG9pbmcgZnN0cmltLgo+ID4gVGhlIG5ldyBzdXBlciBibG9jayBmbGFnIGNhbiBi
ZSB0dXJuZWQgb24vb2ZmIHZpYSB0dW5lMmZzLgo+IAo+IERvbmd5YW5nLAo+IEkgdGhpbmsgdGhp
cyBpcyBub3QgKnF1aXRlKiBjb3JyZWN0IGluIHRoZSBjYXNlIHdoZXJlIHRoZSBUUkFDS19UUklN
Cj4gZmxhZwo+IGlzIG5vdCBzZXQuwqAgSSBhZ3JlZSB3ZSB3YW50IHRoZSBCR19UUklNTUVEIGZs
YWcgdG8gYWx3YXlzIGJlIGNsZWFyZWQKPiBpbgo+IHRoYXQgY2FzZSB3aGVuIGJsb2NrcyBhcmUg
ZnJlZWQgaW4gYSBncm91cCAodGhpcyBoYXMgbm8gYWRkZWQgY29zdCwKPiBhbmQKPiB3aWxsIG1h
aW50YWluIGNvcnJlY3RuZXNzIGV2ZW4gaWYgdGhlIGZlYXR1cmUgaXMgZGlzYWJsZWQpLgo+IAo+
IEhvd2V2ZXIsIGl0IGRvZXNuJ3QgbG9vayBsaWtlIHRoZSBwYXRjaCB3aWxsIHNraXAgKndyaXRp
bmcqIHRoZSBmbGFnCj4gaWYKPiB0aGUgVFJBQ0tfVFJJTSBmbGFnIGlzIHVuc2V0LCB3aGljaCB3
b3VsZCBhbHNvIGFkZCBuZWVkbGVzcyBvdmVyaGVhZAo+IGluCj4gdGhhdCBjYXNlLsKgIEkgdGhp
bmsgaXQgaXMgT0sgdG8gc2V0IHRoZSBmbGFnIGluIG1lbW9yeSB0byBtYWludGFpbgo+IHRoZQo+
IHNhbWUgYmVoYXZpb3IgYXMgdG9kYXksIGFuZCB3cml0aW5nIGl0IHRvIGRpc2sgaXMgZmluZSAo
aXQgd2lsbCBiZQo+IGlnbm9yZWQKPiBhbnl3YXkpLCBidXQgaXQgc2hvdWxkbid0IHRyaWdnZXIg
YW4gZXh0cmEgdHJhbnNhY3Rpb24uCkkgYWdyZWUgd2l0aCB0aGUgc2tpcCB3cml0aW5nIGZsYWcg
d2hlbiBUUkFDS19UUklNIGlzIG5vdCBzZXQuCklNSE8gSSBkb24ndCB0aGluayB3ZSBzaG91bGQg
bWFpbnRhaW4gZXNzZW50aWFsbHkgdGhlIHNhbWUgZmxhZ3MgaW4KbWVtb3J5IGlmIHdlIGFyZSBt
YWtpbmcgdGhlIEJHX1RSSU1NRUQgZmxhZyBwZXJzaXN0ZW50Lgo+IAo+ID4gZGlmZiAtLWdpdCBh
L2ZzL2V4dDQvbWJhbGxvYy5jIGIvZnMvZXh0NC9tYmFsbG9jLmMKPiA+IGluZGV4IDIxYjkwM2Zl
NTQ2ZS4uODAyODNiZTAxMzYzIDEwMDY0NAo+ID4gLS0tIGEvZnMvZXh0NC9tYmFsbG9jLmMKPiA+
ICsrKyBiL2ZzL2V4dDQvbWJhbGxvYy5jCj4gPiBAQCAtNjk5NSwxMCArNjk5MywxOSBAQCBleHQ0
X3RyaW1fYWxsX2ZyZWUoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwKPiA+IGV4dDRfZ3JvdXBfdCBn
cm91cCwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBleHQ0X2dycGJs
a190IG1pbmJsb2NrcywgYm9vbCBzZXRfdHJpbW1lZCkKPiA+IHsKPiA+IMKgwqDCoMKgwqDCoMKg
wqBzdHJ1Y3QgZXh0NF9idWRkeSBlNGI7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZXh0NF9z
dXBlcl9ibG9jayAqZXMgPSBFWFQ0X1NCKHNiKS0+c19lczsKPiA+ICvCoMKgwqDCoMKgwqDCoHN0
cnVjdCBleHQ0X2dyb3VwX2Rlc2MgKmdkcDsKPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBidWZm
ZXJfaGVhZCAqZ2RfYmg7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgaW50IHJldDsKPiA+IAo+ID4gwqDC
oMKgwqDCoMKgwqDCoHRyYWNlX2V4dDRfdHJpbV9hbGxfZnJlZShzYiwgZ3JvdXAsIHN0YXJ0LCBt
YXgpOwo+ID4gCj4gPiArwqDCoMKgwqDCoMKgwqBnZHAgPSBleHQ0X2dldF9ncm91cF9kZXNjKHNi
LCBncm91cCwgJmdkX2JoKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmICghZ2RwKSB7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gLUVJTzsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4gKwo+
ID4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IGV4dDRfbWJfbG9hZF9idWRkeShzYiwgZ3JvdXAsICZl
NGIpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZXh0NF93YXJuaW5nKHNiLCAiRXJyb3IgJWQgbG9hZGluZyBidWRkeQo+
ID4gaW5mb3JtYXRpb24gZm9yICV1IiwKPiA+IEBAIC03MDA4LDExICs3MDE1LDEwIEBAIGV4dDRf
dHJpbV9hbGxfZnJlZShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLAo+ID4gZXh0NF9ncm91cF90IGdy
b3VwLAo+ID4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgZXh0NF9sb2NrX2dyb3VwKHNiLCBncm91cCk7
Cj4gPiAKPiA+IC3CoMKgwqDCoMKgwqDCoGlmICghRVhUNF9NQl9HUlBfV0FTX1RSSU1NRUQoZTRi
LmJkX2luZm8pIHx8Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIShlcy0+c19mbGFncyAmIGNwdV90
b19sZTE2KEVYVDJfRkxBR1NfVFJBQ0tfVFJJTSkgJiYKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ2RwLT5iZ19mbGFncyAmIGNwdV90b19sZTE2KEVYVDRfQkdfVFJJTU1FRCkpIHx8Cj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1pbmJsb2NrcyA8IEVYVDRfU0Ioc2IpLT5zX2xhc3Rf
dHJpbV9taW5ibGtzKSB7Cj4gCj4gSSB0aGluayB0aGlzIHNob3VsZCBzdGlsbCAqc2VuZCogdGhl
IFRSSU0gcmVxdWVzdCBpZiBCR19UUklNTUVEIGlzCj4gbm90Cj4gc2V0LCByZWdhcmRsZXNzIG9m
IHdoZXRoZXIgVFJBQ0tfVFJJTSBpcyBzZXQgb3Igbm90LCBpdCBzaG91bGQganVzdAo+IG5vdCBz
YXZlIHRoZSBmbGFnIHRvIGRpc2sgYmVsb3cuCklmIEJHX1RSSU1NRUQgaXMgbm90IHNldCwgdGhl
biBUUklNIHJlcXVlc3Qgd2lsbCBiZSBzZW50IHJlZ2FyZGxlc3MKYWxyZWFkeS4KQ2hlY2tpbmcg
VFJBQ0tfVFJJTSBoZXJlIGFsc28gZ2l2ZXMgdXMgdGhlIG9wdGlvbiB0byB1c2UgaXQgYXMgYQpz
d2l0Y2g6IGZvcmNlIGZzdHJpbSBldmVyeXRoaW5nIHJlZ2FyZGxlc3MgaWYgdGhlIGdyb3VwIGhh
cyBCR19UUklNTUVECm9yIG5vdC4KPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0ID0gZXh0NF90cnlfdG9fdHJpbV9yYW5nZShzYiwgJmU0Yiwgc3RhcnQsIG1heCwKPiA+
IG1pbmJsb2Nrcyk7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCA+
PSAwICYmIHNldF90cmltbWVkKQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBFWFQ0X01CX0dSUF9TRVRfVFJJTU1FRChlNGIuYmRfaW5mbyk7Cj4gCj4g
VGhpcyBzaG91bGQgY2xlYXIgdGhlICJzZXRfdHJpbW1lZCIgZmxhZyBpZiB0aGVyZSB3YXMgYW4g
ZXJyb3IsIHNvCj4gdGhlCj4gZmxhZyBpcyBub3Qgc2V0IGJlbG93LgpXZSBjaGVjayBpZiByZXQg
PiAwIGJlbG93LCBzaG91bGQgYmUgZmluZSBoZXJlLgo+IAo+ID4gwqDCoMKgwqDCoMKgwqDCoH0g
ZWxzZSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IDA7Cj4gPiDC
oMKgwqDCoMKgwqDCoMKgfQo+ID4gQEAgLTcwMjAsNiArNzAyNiwzNCBAQCBleHQ0X3RyaW1fYWxs
X2ZyZWUoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwKPiA+IGV4dDRfZ3JvdXBfdCBncm91cCwKPiA+
IMKgwqDCoMKgwqDCoMKgwqBleHQ0X3VubG9ja19ncm91cChzYiwgZ3JvdXApOwo+ID4gwqDCoMKg
wqDCoMKgwqDCoGV4dDRfbWJfdW5sb2FkX2J1ZGR5KCZlNGIpOwo+ID4gCj4gPiArwqDCoMKgwqDC
oMKgwqBpZiAocmV0ID4gMCAmJiBzZXRfdHJpbW1lZCkgewo+IAo+IEhlcmUsIHRoaXMgc2hvdWxk
IGNoZWNrIHRoZSBUUkFDS19UUklNIGZsYWcgYW5kIG5vdCBmb3JjZSB0aGUgR0RUCj4gd3JpdGUK
PiBpZiB0aGUgZmVhdHVyZSBpcyBkaXNhYmxlZC7CoCAqTm90KiB3cml0aW5nIHRoZSBmbGFnIHRv
IGRpc2sgaXMgZmluZSwKPiBhdAo+IHdvcnN0IGl0IG1lYW5zIHRoYXQgYW5vdGhlciBUUklNIHdv
dWxkIGJlIHNlbnQgaW4gY2FzZSBvZiBhIGNyYXNoLAo+IHdoaWNoCj4gaXMgd2hhdCBoYXBwZW5l
ZCBiZWZvcmUgdGhpcyBwYXRjaC7CoCBPbmx5IHRoZSBCR19UUklNTUVEIGZsYWcgc2hvdWxkCj4g
YmUKPiBzZXQgaW4gdGhlIGdyb3VwIGRlc2NyaXB0b3IgaW4gdGhhdCBjYXNlLCBiYXNlZCBvbiB0
aGUgZmxhZyBzYXZlZAo+IGFib3ZlLgpHb3QgaXQsIHdpbGwgdXBkYXRlIHRoZSBwYXRjaC4KClRo
YW5rcwpEb25neWFuZwo+IAo+IENoZWVycywgQW5kcmVhcwo+IAo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGludCBlcnI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgaGFuZGxlX3QgKmhhbmRsZTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBoYW5kbGUgPSBleHQ0X2pvdXJuYWxfc3RhcnRfc2Ioc2IsIEVYVDRfSFRfRlNfVFJJTSwK
PiA+IDEpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChJU19FUlIoaGFu
ZGxlKSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXQgPSBQVFJfRVJSKGhhbmRsZSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X3JldHVybjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB9Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0g
ZXh0NF9qb3VybmFsX2dldF93cml0ZV9hY2Nlc3MoaGFuZGxlLCBzYiwKPiA+IGdkX2JoLAo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRVhUNF9KVFJfTk9O
RSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGVycikgewo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBlcnI7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0
X2pvdXJuYWw7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGV4dDRfbG9ja19ncm91cChzYiwgZ3JvdXApOwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdkcC0+YmdfZmxhZ3MgfD0gY3B1X3RvX2xl
MTYoRVhUNF9CR19UUklNTUVEKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBl
eHQ0X2dyb3VwX2Rlc2NfY3N1bV9zZXQoc2IsIGdyb3VwLCBnZHApOwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGV4dDRfdW5sb2NrX2dyb3VwKHNiLCBncm91cCk7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0gZXh0NF9oYW5kbGVfZGlydHlfbWV0YWRh
dGEoaGFuZGxlLCBOVUxMLAo+ID4gZ2RfYmgpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGlmIChlcnIpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldCA9IGVycjsKPiA+ICtvdXRfam91cm5hbDoKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBlcnIgPSBleHQ0X2pvdXJuYWxfc3RvcChoYW5kbGUpOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChlcnIpCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IGVycjsKPiA+ICvCoMKgwqDCoMKg
wqDCoH0KPiA+ICtvdXRfcmV0dXJuOgo+ID4gwqDCoMKgwqDCoMKgwqDCoGV4dDRfZGVidWcoInRy
aW1tZWQgJWQgYmxvY2tzIGluIHRoZSBncm91cCAlZFxuIiwKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0LCBncm91cCk7Cj4gPiAKPiA+IC0tCj4gPiAyLjQxLjAKPiA+IAo+
IAo+IAo+IENoZWVycywgQW5kcmVhcwo+IAo+IAo+IAo+IAo+IAoK
