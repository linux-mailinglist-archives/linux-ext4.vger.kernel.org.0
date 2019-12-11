Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25DCB11A53D
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Dec 2019 08:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfLKHnB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Dec 2019 02:43:01 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:40966 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLKHnB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Dec 2019 02:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576050181; x=1607586181;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dD0acaqYEb3GzKBeMGth4CR7qb/h1Jc6cFnLM3pirf4=;
  b=kSMVBnYTbyuxPqnBWrHpOB+B/mAOu4IBxOxh8dycrHIM6Hr45oKaCpjd
   v2nNWvkg1Xbq2kDsT/e50iEGAvb+iDcRo/4OiQL5svgldbc/GmTa4cPCV
   Gu/xmiOJyn8Tcw54kuQluPNdMgdtP3L3F2wwIbN83gGCo4l7RRnA5XoK7
   sKdOMnGRkvgyfDSwcCwZrdpF2jrJvzDpchJDjwQqAvvmBBvQfIaYkqbQ2
   qNW+v87l9VbBH25O/Z9UuwQDcjfzndAcuyPf7QItFauyEH1VZ0nbbr1Ra
   2Pt5WTYKgqaXypj4ntNO0opWqytlM5FtMZQV+v2G71cCKfRT6Q13xF3m7
   Q==;
IronPort-SDR: pTBfrnvTWvafQbtSacl0piEU22vAvYgAtOR47NLhRxAfl0OUUMyM15BvLPVb0fSFJKRkcBuiIc
 2xrXvwaL9lXVjeLNkwv0iub2ezbych7gNp+CgYljFQYZsONVH1TfLT4x1ZQoIJ69x0ZCbNC8/R
 PXlt63zZnufFxY6wYd0C+qesjJz5lF6j5yHTl4zB+DyMt+FZ1/DV3mNF/OS1q8f+IKLyx7gQb3
 X7PwuqAaVipo9uLNEfoWgXRI+LNj3fLThNJMcyJBViikXUXgP3mipWUgqBclKpguhdkc4AK2zz
 BwM=
X-IronPort-AV: E=Sophos;i="5.69,301,1571673600"; 
   d="scan'208";a="126692017"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2019 15:42:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD5ddZz0V+ysQ/DkzqofAtCSwkwgq7mavIFJfhxCeiZCJ/p41FkOaZbP8cqwJttD3WR1oj1Db4W/391xDoe47xrOLI1yBjA7xfqWOuhneXWClboLAKsQQQKFFWw++lTrj43jjtyzYg3HnD2bbZQPMcqyuNJwDSmqhuvaP0O8AUos8ttYDWKkruQBf9Mb+FY+ArjZSp0UZGICXwgt9qgrNA+8d4jy2UYT7WsEG65Pw1n82G2UhtJL8Aqo+v+nJhL9ejQu6LqxnXidXyTn1nQNGgciNVxSZTrRYJVHqTX0KXs4610O/Fs7l+mwJ0xJvVcMTXuXLsd0ArxzjN5FjE/ZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dD0acaqYEb3GzKBeMGth4CR7qb/h1Jc6cFnLM3pirf4=;
 b=gVKLKrR4gtZY3RWna92O3A0RK3mbS/HHXpxG9xd+aiEijWs9oLNMUvfdHl4N4g1z9ybP5cyMS9bl724hmsNiMKbZFv/YtAM00fPKR8NZJAHndECkP6EkXmjFudWFpZdshOSFIKUhLj3b37H38ziAOgi3mzHiockJTpS9aLrGRV9g8OdOVMpzMg0WxmD6vDZlAQNW2T9vz80Twrtp+aYGX2owxdFQwBAZEBfp6+nyWIoNsRk7vd4kYTEbsiu/TWjh5w72bQr5A35/O2JD8o1PlfLboqaE1SLsSd0S/9fBigGc/poEvWKK5eA1lrpttsMan/5cnjTB5UHaRYl6nHaHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dD0acaqYEb3GzKBeMGth4CR7qb/h1Jc6cFnLM3pirf4=;
 b=j8iC+etk8uw/tJWk0E47rVwRU9+pqN0E8P3g4gV3gPLXzbxi+7JENsBnAFyfdEfQFegl0uOl7yhKEDozlkXDBIQiI9y0/dyIuwakIr4xHig7tUhuhQZ09lOhwVwC0/y8ymc3wTdoiZ/y6w0jugIvevdomXqjn6uj0E8XKvJEUBE=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4231.namprd04.prod.outlook.com (20.176.248.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Wed, 11 Dec 2019 07:42:56 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::c3e:e0b4:872:e851]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::c3e:e0b4:872:e851%7]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 07:42:56 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "hare@suse.com" <hare@suse.com>, "tj@kernel.org" <tj@kernel.org>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>
Subject: Re: [PATCH RFC 0/3] block,ext4: Introduce REQ_OP_ASSIGN_RANGE to
 reflect extents allocation in block device internals
Thread-Topic: [PATCH RFC 0/3] block,ext4: Introduce REQ_OP_ASSIGN_RANGE to
 reflect extents allocation in block device internals
Thread-Index: AQHVr3reBavjsn3tmUKK1Acu/NUNxA==
Date:   Wed, 11 Dec 2019 07:42:56 +0000
Message-ID: <BYAPR04MB574961FE921EB3FEA03CAF77865A0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c482896e-5b18-43ed-9b5c-08d77e0dbcf2
x-ms-traffictypediagnostic: BYAPR04MB4231:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4231B31878F2E57F004C7550865A0@BYAPR04MB4231.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(110136005)(186003)(558084003)(4326008)(2906002)(478600001)(64756008)(66446008)(66946007)(316002)(66556008)(76116006)(54906003)(66476007)(5660300002)(966005)(52536014)(33656002)(26005)(7416002)(81156014)(81166006)(55016002)(6506007)(71200400001)(7696005)(86362001)(8936002)(8676002)(9686003)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4231;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IllgFZyPjmS4PNp/bruzJiihX9vG+Wt1/WY9G8aRbHsUBdiXf4wndC7JIPiAkpWt0BE+12GhssjseLsWxZ0GjCWxsQfofaK9MIG+zp6eBQ8UZ5PWbTD7Z6wydUI3nPTB17wUMzp/XtQPpTI4Ci3VzshlCXFVWDBWP4OkRfYF+Fov5xE1+3G/XcrK55mBRZQ1nsoXwnQz3fse7sJLbmrvhE0NZ71tXC04eSNou5Fx5lAuIb+qk91kKSXXios3JbgjZM8KxNaSai0KSCtdNw3FbcReXrRBKNJD6b49J0LwvT7HU0vVKILdMhRfms7w4gMnw9VLvFKVsEcMuSMPygsFtxZAcEj07m/hP5UP8Df+8VDW5lYJGsk3AxQUQR/NIR070pYG3fbs31m/VH/uodd28t4Lf3W3sTbZi6I9O/cRkB+GzSbIoFeB6rIZTyWSync2iLZaSSmTzt+XOyGt+EXMyMFDYCYZFlrYZ1/ipAiMFuTljoIkkfLMlDVIjYIv5Q5l+ZU06ch/tTJaNo13gM5nGgU/c5wThFAK8TbQ8Di6wwk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c482896e-5b18-43ed-9b5c-08d77e0dbcf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 07:42:56.4506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 503CHFVUGXbxM6O9c7UN7Tps6WlyHhq6T62h1hmwUzvAFunyUNvJ2o6qfLhYOTcBHeuJsYj/HCazYNky6Btc3e2J+tF16bWWnMquAJe5QFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4231
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> Here is a simple test I did:=0A=
> https://gist.github.com/tkhai/5b788651cdb74c1dbff3500745878856=0A=
>=0A=
=0A=
Somehow I'm not able to open this link, can you please share results=0A=
in plain text on the email ?=0A=
=0A=
=0A=
