Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3045319A470
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Apr 2020 06:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbgDAExf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 00:53:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14825 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgDAExf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Apr 2020 00:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585716814; x=1617252814;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vGCpIxA+MU+489NaFNjwrexFb5tDoNIyp3zU+Ht7q7Q=;
  b=bglWIXsPel5DE4yKmvS95ipwD6vg5wINYcGFmWD4f4YboqA2BXQURH4h
   UN/Ks6hHTLYskgAK2pg4Xi0hcuaESmfzXv38iWru/endH+lp+VXzMkGNr
   ip/Sr1k9byXkgDbCpnvnegafqNxI92InxJqxqA9/nHiaFW84GTjBHcfB0
   Fut1VW5OjDO9JfhlS/D8Onuy3MB2wZPieR4GGjapm9OChK+DGdIrSJMGn
   6Eq6pFKSmU+Q5ID+GTN761+wH4mCfVaPSuANX0qgcdB0l0F4eK3eBs0d3
   op854MM3mqKTrEU0GI8lBAJlgQXMQYq0PMjZ506QNyWYDT9zZ92ydsxsw
   Q==;
IronPort-SDR: sit8bdFCGZYglT/O74GXb1iydqEOabAUzoiSmKcFp7qwVIeJDA16CvWJBt4saTR5Yn0l3OXkfB
 sge+pYcuwDnErnXtDhzzOJ8I4stFXgxMfFkCUih4lRK1rEvVSsL7DdYzc2MpFzYBUn9fjw4Haf
 VeDRyTeboBI2y2myxbNTnQxYDcFYFAM0VgcKII0hI4G3sgEPBjjvNNua6Ry1brXpitUJRZsZ74
 lsYhKNygB/0OW7bubl724QyT0ZfdmBz7CJl7skS++HNxo5n9+W60wrEInWqEAw/8a+mA8rj6tC
 TOI=
X-IronPort-AV: E=Sophos;i="5.72,330,1580745600"; 
   d="scan'208";a="134208206"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2020 12:53:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTR88GfyQ0ov9CrNyicsH7ta2NCiejgO55HKcK+uroL1EqbO1xTnxBwdpIkpiKd74ozuHaLqeZqHe69TjiBtGYFB+AsJB/BcbQrhwAqVPeFQKnLVSH5hkcxIpRUvwNYOdf0CBQtb+nodAswseG3Y2ah+/f7Q0KteJMYDKbzlhFPPoNcVJGbM+/2TGGwbZE9QywRKmsXQapXXeOcR68vw1/qJK3bAyaQrnHuXWad0JuOTv7RuqVJfqq6WzmhCQHOapl6kArj/tOrhymbFFZ6ry4X+YUkEVBdIj+n/Lk0ZTgHwlpMiZVdyXwJwOkVdaTLr3nz9UiojxQn2uptRD6mg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGCpIxA+MU+489NaFNjwrexFb5tDoNIyp3zU+Ht7q7Q=;
 b=caaRxeTNBfOWmkFoWgUKhTNZ7YAZyC+85ibhOLjmjQvrCxoEhyLRih+jIxVyc4wvs5r20fEIU6i4anWK1L/+Ub/M4Eg537DcEkumCBs2G22m7sMlPYh6Pi/db2ZSk859F8zL4BYuTA2jc/4pdvdQQQMrAd/1IQ6atz2wDbHSs/ncG+Xfflp+j/fXqKhlmAb+qqPi7qNEJlNDkmCaoMYlvrwm4s5rhM/oa0XfdDrclOu/FphL9yWv7DXQgsxgcsA8GD2mqTJJm1sLJEdimdH6u4fQUMu/xsAvaXkzCUIdmgZJ3FSpeYALYX21mgVewFWCDmvSsz7YKD1fA/XKZjYdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGCpIxA+MU+489NaFNjwrexFb5tDoNIyp3zU+Ht7q7Q=;
 b=n9spCt6VtnqHeN955596BT6QICHcSFD87xAzS2Ww+5nXiheFs+e4BPsJ1vM/zQlYCP5igBkFQG/RmePPdGBE8yAxSelTn6/5aCbs3b3ZkZlP0UGjpuuP8PH7Xt/GI1UfGG2EkLKIHMHqEo+2I6ze6mYSIXC4ulFqjMOBOmoe3zY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3863.namprd04.prod.outlook.com (2603:10b6:a02:b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 04:53:28 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 04:53:28 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "hare@suse.com" <hare@suse.com>, "tj@kernel.org" <tj@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "khlebnikov@yandex-team.ru" <khlebnikov@yandex-team.ru>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 0/4] block: Add support for REQ_OP_ASSIGN_RANGE
Thread-Topic: [PATCH 0/4] block: Add support for REQ_OP_ASSIGN_RANGE
Thread-Index: AQHWBfs2xrvn192370GLlrzktUGYXA==
Date:   Wed, 1 Apr 2020 04:53:28 +0000
Message-ID: <BYAPR04MB49658D24374293AEE6D43C2E86C90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
 <yq1mu7w546h.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e40:3000:2c9f:112f:76b7:3770]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05daf340-39cc-4485-43d1-08d7d5f89eb3
x-ms-traffictypediagnostic: BYAPR04MB3863:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB3863B480E03AA1E43EBED92586C90@BYAPR04MB3863.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(55016002)(66946007)(6916009)(7416002)(71200400001)(478600001)(558084003)(33656002)(7696005)(76116006)(53546011)(186003)(5660300002)(4326008)(6506007)(316002)(9686003)(66556008)(2906002)(54906003)(64756008)(81166006)(8936002)(86362001)(81156014)(66446008)(8676002)(52536014)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Ctbo+5vXCWMxOLnbT3l/j+CW0W4jXjFO9uMcwpKxwrBicEQSrwii+UcH5u/5w14HZaisKcGwSqJSrUrYmAqnrX4UyAnn0xb4U/fBZrDWKpJx4QOaICVC64p0bDwr2KMof21dP9JG5zXw9wTE3Ix5HDCMAZj77XETZ1Bh3b3lxUqtK2l00aL7j5ewL2NgocodLR1YyJjPMII6byjxzwL2e6v69ulfHbCrkl2uXzPPa1cmK7QuwO85fVKCcZZVoeXUJZR92IXg3VJ5MIISfpPPtqMCzezhQksYYMQxo+mSArDFoP8qJ93Z6LKuF3s5rek5I6wrV3CPwZf3T2Hu+kCjaFfPtwuRb747bqycb488yLuNhO0HVca56gQZLQi6QFPM+uJlTPIxHkTTuSvft9h3uWr0/jPduPvJX4Jlu7qFs2hkGlinbFYD2lsmdcgo/jg
x-ms-exchange-antispam-messagedata: 7pgyLvkdT7Xu+ukAR7fAguDLhWcJo1uKNaS7HZzzzSR75qhoZwZCHLs1Gc57rXrgWAkcc/eTch93suRsjUL+LKsprW9bNs8g6Hi38AIMxpelodCMI9A76hpgeo7Iumi6KQn1PMi05h7ovwy6A1rG7fC1DTiPRGMZ4kjGv2/hni9grPVOfoikvDG1xH3IT1nAdo1dY9iaZgQlhpB1fgRrWw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05daf340-39cc-4485-43d1-08d7d5f89eb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 04:53:28.5209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1LvrvKwbWyWahJYNGl3iS5SIWVmRfRZ71duSlsNR3xWR56kFfVQc0EcFTdP/YyLn3dA0ujSPjCm1o0GcFugc8aMNC1LtfRT2mJnDZpgz74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3863
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 3/31/20 7:31 PM, Martin K. Petersen wrote:=0A=
> Chaitanya,=0A=
>=0A=
>> This patchset introduces REQ_OP_ASSIGN_RANGE, which is going=0A=
>> to be used for forwarding user's fallocate(0) requests into=0A=
>> block device internals.=0A=
> s/assign_range/allocate/g=0A=
>=0A=
Okay, will send out the V2.=0A=
=0A=
