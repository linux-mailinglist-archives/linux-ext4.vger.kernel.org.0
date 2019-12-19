Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B82127043
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2019 23:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfLSWEF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Dec 2019 17:04:05 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16541 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfLSWEE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Dec 2019 17:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576793044; x=1608329044;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G6j0NZex2wKZkHpCO1mFJPQyOG5DKDha1fUaV/or1eg=;
  b=n6pGPJP53aYVV57u2+dGFSYAcRI9LvTqVkNcDXseDnW8u1O5P6peEaon
   XnfStXTrwzWXeulOaL4OeF4wV1/1vA83mc/qmTXtBlunpJ7sc32NkXRXQ
   Xj+p7Xbs0kLz1qC/cPXbAoUBxnFBHVpH/gIwzcv75PLssHozlSFL8igow
   YAMXqur//q1YA49tTFkj//tTfrdk2SAiIFiPP5Ud7WZuzMJN/dFbNkv08
   yLM3W3HbVDFU1lUWPHarP8ihIXNk6vrgYqnAtKYsoYUukii9Duun0cDDc
   4U2zxefDZrGYBza0UYxGYTkBlt6W1GM0RnsgwJQuLSxCR0GLZVGsoqBwH
   A==;
IronPort-SDR: GUvqScJ971RfFbOkUoFdpf95qf/nhjtoj5bpPRJMv0EohxiaTs3G7cqw3u3po74q9wVX+2MIBq
 ZnDwXmJnAYgrU5oIN2q9e0cxuKx4iDBhAUF5QuhiQFn/wigB2ib3fbZnr2UaxfN6vNGBa9MI04
 uxJmKq0ccVsw6szzlvSXnse+4Oorch0NkC9rtcp2Xpyr0+3Hu5nD/ahTdSX56nlY6NGsS95Y/Q
 kqPlzeuxSHNhMm54wG9ZAamhQNC6Fx+nodycsAqA4tOy6iUm3ji9Z/PL0idiOkoVwxUei+3GG+
 CMM=
X-IronPort-AV: E=Sophos;i="5.69,333,1571673600"; 
   d="scan'208";a="125755462"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 20 Dec 2019 06:04:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8uydUOdIYKaa8pozqhs0UQJqxcbr4BC3ocjmRKh0+M44Gb9NhQ4deGY3PhiTpioeMqllgsCbQvEKO/12Bs1pSFs2Hz3klaJL+J4LO7KJ2xbt63lB1PmQdbtM1dKTiIuFAsjP02Zu2i+aY7aBoK6tZV4gueG4msy3/XmvH++HuWeLcVJ2VTaOa75wTTzsPrZBrIvvcG56KV3qIrnjzYuwHi+QWWLVyoW+4mNmvYANtoiNE2lLf47PHh5AYhEw23z8lB1wZxSX03dqKDmDjPPtBrCs+TrcSnbGD1XCfIsVr5HUJYMQOrFmgcaq8b2obZ8BaQjAjGIhyCfQDonIBLirg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6j0NZex2wKZkHpCO1mFJPQyOG5DKDha1fUaV/or1eg=;
 b=CtC8qFEkk/NUfrP2jnmy00/PLnv+2RdHR/8ssVHcOv+r3RFHf6jbx7kIwxCnNGhE9b0GkjTKiemst2n2D+quAAQ7fo98oR8qz+sYI6q48IP8QXDwmwkbKsuT3PWIkCcZLq0NHDbXozVCNW0frTmrA718mJMOicfdG9osvLnyPBYTG8fJyH35FSh7kmbe0WIpBD3pPRfir7QVGmvnVPuEZviNcOLSuaPVwFhrFajmjbnqdsksz3bydixbMAXd4bUieWhZcNkvKrGMbIKTXm0OslEbLTsoC9JpWlwXeg1mKp1Tp9K3VY9uw4JtVMo1VqYlZvrgG8mdGGAhl6/4ENNlhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6j0NZex2wKZkHpCO1mFJPQyOG5DKDha1fUaV/or1eg=;
 b=0OJfLNQZoIpBNyBNvvn7YGGnp7nlaPBqObFSX1QI1OWZ3bfACWpuFInM9ZALlXRQsO6epOXRSW01Qd/bptysmsV2d6dp03xe5q8tyUaRDCQB4rGfkxWzJDy8jIUP5InFbexnR6FUYy/IB7VTBmgRJoznzCLkseUCnZHlzbtYufY=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4168.namprd04.prod.outlook.com (20.176.250.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 19 Dec 2019 22:04:00 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2559.015; Thu, 19 Dec 2019
 22:04:00 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
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
Subject: Re: [PATCH RFC 1/3] block: Add support for REQ_OP_ASSIGN_RANGE
 operation
Thread-Topic: [PATCH RFC 1/3] block: Add support for REQ_OP_ASSIGN_RANGE
 operation
Thread-Index: AQHVr3rcmq0PW8AkT0aAu5npJnFL/w==
Date:   Thu, 19 Dec 2019 22:03:59 +0000
Message-ID: <BYAPR04MB5749F02CB2B0CF3541D9C89A86520@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
 <157599696813.12112.14140818972910110796.stgit@localhost.localdomain>
 <yq1woatc8zd.fsf@oracle.com>
 <3f2e341b-dea4-c5d0-8eb0-568b6ad2f17b@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9306db7c-ae08-403b-1708-08d784cf5a1e
x-ms-traffictypediagnostic: BYAPR04MB4168:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4168331862A295914C700E7A86520@BYAPR04MB4168.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(199004)(189003)(52536014)(4326008)(8936002)(66946007)(81156014)(55016002)(81166006)(2906002)(33656002)(8676002)(54906003)(5660300002)(478600001)(71200400001)(86362001)(316002)(4744005)(110136005)(7696005)(7416002)(66476007)(6506007)(26005)(76116006)(66556008)(9686003)(66446008)(64756008)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4168;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rUiPqjjGyGednX7Suv4G1vekSCyT3Ep3vWs3Cy2GdcZhnIgYNIf+P6ryp1v8u66Lc3pqHnlI52CF2koxUt0H4zgP2Aw4hsOuqndh9vtycqI1n6PbuYEDZYcMKqBPNJAlpNH2oaytSw03g9bnw3SCKhzVFHaKOb5P3ctMCvwCl6TYJWAhtx6V+4AKyD6BUdZSRDtQcgmREDjzyAYV1UGSssVcX0fdQEWtCfgosfRzOqwQuHLPgmf6pXg9abbGyExwORxD0QroVh8gaT6my6n6rzOjvTGOfvxV2ZyMWcTYHO/CmIfVWBT1XiDVS+wPh+4knY1aCLz942Pkla7CWtD+wlrxwGdOk5KjjUHBwPGQp7pI1o0VFBrf/zolxMyiMpZHRpBLoAAJeq7+8kngbM5ygVxykYPczc50gBQemKBrwUq8c64H/HQKN3FbDtHhml0i
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9306db7c-ae08-403b-1708-08d784cf5a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 22:03:59.9463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSaL2LiAt3BEpPAOZB5BU2tyf2GuEe4y6XYO0GKJ2oaV2t7vImGhwd9gJyN5bRaUz1mUUEnMY4MwxIKNehNTi38lmESwfDDgFTUaMuGdCdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4168
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> 1)Introduce a new flag BLKDEV_ZERO_ALLOCATE for blkdev_issue_write_zeroes=
().=0A=
> 2)Introduce a new flag REQ_NOZERO in enum req_opf.=0A=
>=0A=
> Won't this confuse a reader that we have blkdev_issue_write_zeroes(),=0A=
> which does not write zeroes sometimes? Maybe we should rename=0A=
> blkdev_issue_write_zeroes() in some more generic name?=0A=
=0A=
Yes it will be confusing, I can see that the code for =0A=
__blkdev_issue_write_zeroes() & __blkdev_issue_assign_range()=0A=
is very similar except op =3D REQ_OP_WRITE_ZEROES and=0A=
op =3D REQ_OP_ASSIGN_RANGE (and some minor details).=0A=
=0A=
What we need is a prep patch which moves the payload less bio=0A=
code into the helper function which can accept op as an argument=0A=
based on that it will branch out and execute right code path.=0A=
=0A=
If we decide to get this in then I'll be happy to create required=0A=
prep patch.=0A=
>=0A=
> Thanks,=0A=
> Kirill=0A=
>=0A=
>=0A=
=0A=
