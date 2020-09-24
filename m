Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775C527688A
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 07:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgIXFrQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 01:47:16 -0400
Received: from mail-dm6nam11on2102.outbound.protection.outlook.com ([40.107.223.102]:65377
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbgIXFrP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Sep 2020 01:47:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYgvHY1WsCkhbpm+4seGsN8iFbgDbUW2adJ+mo5arQC2H78eLayKICZ64SG6nC5zq1kfd2DnjfqphiJjtbp1GJHgxsnGWEIfepcwEqAf8GyMHKo3gw7o10yDKLT6TKEzm8QGZdb+op/Lkx1Rnc0xAuhR9HxNF31RaZJ57ZucC+bfYGtbKTzQWJ/fBzU5K/vIPxT51ns+xM6kDvayP+UPt//DFRjN9pMt7i177quhtrwd3r63gp4FhXRVZ59GN5/5lbMwifDOJa5y5cysqZn2VczbWZFgn7+0GUZmuLqFy9A4ExOjubdyprBpreqoAFJozzC7NM4sVAX0WwbCEJME2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L40ltHSrdcOfoGW1/GeYwLHmr8mI/pCsFGPX16SasIo=;
 b=ANKuw5r+I1/4yiSpk/P6VRX0MSg/vR+7bfuc13Rmb2l/xvB1H3Rsl4P4/ZWnitjIvOKxOBK93gW/bI+FpVzAOn9OUUz3mFBMUo8TgwYLri8CQnhvYD05jnxu9uj86WvRy0uT4gWm9rrbU45kRN2z7OsKOqgtJ+vOvjL4nZDQRxD+/9e1H4jCAdkpUWTqDNgcMtnpDQ3nyNNOnKsU6ipGmWc8lB6aucUjA2ull+n8/RuuFocP64mDcGUbuAVCS/qfS44z0VCRQRRIGbfxrZ0fiA/RJDU/7naz/sZUHIlJK6Bkho5Ua4KQEyk0doGcChnQy+IJzRL+Umm8IOqEhJ4b1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hcdatainc.com; dmarc=pass action=none
 header.from=hcdatainc.com; dkim=pass header.d=hcdatainc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG220063.onmicrosoft.com; s=selector2-NETORG220063-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L40ltHSrdcOfoGW1/GeYwLHmr8mI/pCsFGPX16SasIo=;
 b=Ol5Jxzu45ZqeKyiHL6WxejH7BmpC8rTveXdbNHLYsXan8EO3/fUphnkFKSxKWrXDesVkdWAaO8cwG6pXHcOZKr+2Ez42HVWl4g8LUheC+38f4s0PtHYg2+RN1z5H5QAPi6ZJLBtW44UBkswWsc83LMlcRYMLSA8lwp/3l4tDTSg=
Received: from BYAPR10MB2456.namprd10.prod.outlook.com (2603:10b6:a02:b3::16)
 by BYAPR10MB3079.namprd10.prod.outlook.com (2603:10b6:a03:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 05:47:13 +0000
Received: from BYAPR10MB2456.namprd10.prod.outlook.com
 ([fe80::c430:480c:3ceb:566c]) by BYAPR10MB2456.namprd10.prod.outlook.com
 ([fe80::c430:480c:3ceb:566c%6]) with mapi id 15.20.3391.024; Thu, 24 Sep 2020
 05:47:13 +0000
From:   Meng Wang <meng@hcdatainc.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: kernel panics when hot removing U.2 nvme disk
Thread-Topic: kernel panics when hot removing U.2 nvme disk
Thread-Index: AQHWjhX83+5IHgri4062+f1Cfnen/qlvMIaAgAgV6ACAAAdtgA==
Date:   Thu, 24 Sep 2020 05:47:12 +0000
Message-ID: <BYAPR10MB245671198E40D4F44B2365C1CB390@BYAPR10MB2456.namprd10.prod.outlook.com>
References: <BYAPR10MB24561C62C45813B7092E346BCB3F0@BYAPR10MB2456.namprd10.prod.outlook.com>
 <20200919014401.GE4030837@dhcp-10-100-145-180.wdl.wdc.com>
 <20200924051230.GA16433@infradead.org>
In-Reply-To: <20200924051230.GA16433@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=hcdatainc.com;
x-originating-ip: [45.28.143.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9b5d743-1b91-42f3-fc5a-08d8604d493e
x-ms-traffictypediagnostic: BYAPR10MB3079:
x-microsoft-antispam-prvs: <BYAPR10MB3079FC5525B13A58E5C157C9CB390@BYAPR10MB3079.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 90QGAepF0RabWhr7xqc7Pmr4/tUvkHHUuvMiSKHsy45odFqqc3QiFkuEWzvia/8NrH3u+lFu4r16HPpNAlnxmC1vvlYU9Aqm+GlqSTP7DktFSB9JOGlsJOqmoiHyZHZKFh8UVHiKR+QZM753XzK5uII+0XHBxCES9e6EQd8jZNEOeQZ/SbVziSiEtR59PnkpWhmO4mZiW1ZXhCgUqiK2km+OYTQQQtZ1RmUgbK6HrcCzdYBkqPFTjDRk7QMI1xUqz1QGP9x6vSnx+tBwIXxOdxlo40LAfxDtR4VD3ZVyYDEbnyHWLOwEx8S6quLi3uYn3Ccy8IU+5LRYEHnEoKiVBZxllOMQ8JmVubV4nXe9oNwlPJjh+mSCsSgW7tzNDH2j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2456.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(346002)(136003)(366004)(376002)(54906003)(9686003)(6506007)(186003)(7696005)(86362001)(83380400001)(53546011)(478600001)(26005)(2906002)(316002)(52536014)(5660300002)(110136005)(66946007)(71200400001)(66476007)(4326008)(76116006)(55016002)(66556008)(66446008)(8936002)(8676002)(64756008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FrMPoq9y2eTeM9HB075X4ibjOA+a+CC5hOa4w+pBzWHFNt2otDL7fDfMR4ooeKQBy2HEDo0weLZKZ/JgDBHKapEyJ+rJSrkpsW7AD1JEiYBbY5uSqmSOHpWZpvj2wLkSPKbPgGaM4WO724Jsxu5WVv3s6yyC0Ntf/A75ZrWaEAdsIghr1mPH4jCpznCsw4mymjgvdGCrBknQCtazoZUR2MJ3v6SpYrbOdVZGCepdBBOaZOXJRjPR1bWTR/RU/IH0uzSn6RhGSX3vrANqfV9/EDRTPE5fb6d2DN86uQgsOfkbjv6p5FmAMl9Rxk+nwUPp5+hGXDFjwtfwr0WtR5hrFRxMCwIfFEhD3gIRNjTqVfSn/1oKQeW4p2FiNPnS+7PNw1+N76gq4LdhcY4C4BAAt/OcLzxH3oEcdP8aGi2SOPbnme7umEgxMbS1837lJ1F/Eq86O4e0cLaMTxGR1i2i3+jY48o6Fguae2MNa6vBAa5Elei1GRTqcDl6wOQ6JmW0zuo7UXOby9tbduccpXxTb9M+/jslA7+wQ0iCabmVA8uf412o8qwtDdeQBuVzFOyT0J1q1MepypudUbreu2M4TWOPpyxEjyR/GDYbphXI2PBhU7sQOzHVPfoF0pfBqlS/jsdnMVOdd+D1lrLZns0kjg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hcdatainc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2456.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b5d743-1b91-42f3-fc5a-08d8604d493e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 05:47:12.8379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8368637-8933-4f2c-a6d2-c0d726d49c7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jYu1moN8BnM6VeFOzDzW3mJ5iwGxZuMzh2wb+FSTZjJ5dSwPTYRjJlo3QqShCq4EdIiZbTajU0t1gfZY9vJrzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3079
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Wednesday, September 23, 2020 10:13 PM
> To: Keith Busch <kbusch@kernel.org>
> Cc: Meng Wang <meng@hcdatainc.com>; linux-ext4@vger.kernel.org; linux-
> nvme@lists.infradead.org
> Subject: Re: kernel panics when hot removing U.2 nvme disk
>=20
> On Fri, Sep 18, 2020 at 06:44:01PM -0700, Keith Busch wrote:
> > On Fri, Sep 18, 2020 at 11:47:27PM +0000, Meng Wang wrote:
> > > Hi,
> > > We found kernel panics today when doing test on hot remove U.2 nvme
> > > disk. After hot remove the nvme disk (formatted as ext4), the system
> > > freezes and all services stuck. Lot of kernel message flushed the
> > > syslog, including the CPU soft lockup, ext4 NULL point er dereferece
> > > and ib nic transmission timeout. The kernel panics and configuration
> > > are shown below. The used kernel is 5.4.0-050400-generic and OS is
> > > Ubuntu 16.04. Not sure whether it's a known bug or configuration
> > > error. Any advise are welcome.
> >
> > [cc'ing ext4 mailing list]
> >
> > The NULL dereference occured before the soft lockup, so I'm guessing th=
e
> > Oops'ed process is holding the same lock the removal task wants.
> >
> > Your kernel is a bit older, so it may be worth verifying if your
> > observation still occurs on the current stable or current mainline, but
> > the ext4 developers may have a better idea as this doesn't at least
> > initially appear specific to nvme.
>=20
> The problem is the crazy __invalidate_device stuff that calls into
> file system eviction from all kinds of super critical block paths.
> While I haven't debugged the root cause this kind of thing just causes
> problems without really helping anyone.  I have a half-finished series
> that kills this crap and instead allows the file system (or other
> block device user) to pass shutdown and resize callbacks when the
> exclusively open a block device.  That way the file system driver
> can just mark the file system shutdown to prevent any further damage
> without all this mess.

Thanks for the info. Is it a problem solely for ext4 + nvme combination? If=
 we change file system or use SATA drive, will the problem get workaround?
