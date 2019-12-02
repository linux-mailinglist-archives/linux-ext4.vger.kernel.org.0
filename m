Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1167410E703
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Dec 2019 09:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLBIqv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Dec 2019 03:46:51 -0500
Received: from mail-eopbgr730070.outbound.protection.outlook.com ([40.107.73.70]:13312
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfLBIqv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 2 Dec 2019 03:46:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DV9Ua7uGDjQLrPt/Ix/CtBMUozeOWhB5ba5Yq01w9d9N8wiEil7q0J3LPS0ApgVobEjphSGcsN+ab3vTxYJT1NaLoO0fb9i1EEIxKfFKzyxYOxJpDI/mw6uLe7o0eW90qX174FZRTI+gmRSuIFcXPxy0zB1O+XeHz8v208PM7jITOHH2KYvsxKL7wik6P6bPnp7uqW8WiuZjpzqGlgb6HGzlDgIHg2ZSsBdruDlkQpO9vh9rgOyIoVVpFqTxb3f0b2FG6EEUA/kKK+tfLNH+hpM2ePzN1zq2qWtTaB4PLFYUNqehZNaWPvi85p1iBd3pvrifyXSEqYZJIjS/zqJU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S73SrrV4ml/iFdYstP6labvxSjw9MJNNdi7ic7L1N7Q=;
 b=LBNCsAv9mNZQtDW9a72zkjKbbUS8GOw6+0qb8f1gCWj8PERbr46ulV4A5jvNgKSJrLEYJ9JBSqUD3h0hCP4FLYAsgaFJXXSM/Zql5sA5SaPKm7OuFymKFnbix+GcUP80BSrSrhAhEpHQBWSRHDW6Zuu4fLBxxPRHWiY42OfQ6lsygNUqmEmJrWv4kBHALufZdXFMRzpNtxBfA7gbXQjCkdGHWH3hAYFLo4UHRk7OwLYe+n5uAawJ5smPlFP96+z+it28FuuoBT5vGHCXL0yekfd2i8eME8PowfTYdyCUHKIZ6pzd4EBFMcVARIwzGx51m6F43hT/3udMfLtnB0trxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S73SrrV4ml/iFdYstP6labvxSjw9MJNNdi7ic7L1N7Q=;
 b=jYedvnXp2RP/tycYOEXptsgQ9Af3NMs0IwydUExQFtFYZ2prjeEJvSlRU4SSyY0YtFC6PSaIf8eMrSfbM4G3hn9U97/iftwi2L9GgrVcATYyHaguWuhfXD5X6SemAU/uyuLe1WyuuDsgm23Fo8DwP8/Eom7ENUu3KZzhtMtwsvw=
Received: from MN2PR19MB2894.namprd19.prod.outlook.com (20.178.254.95) by
 MN2PR19MB2701.namprd19.prod.outlook.com (20.178.252.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Mon, 2 Dec 2019 08:46:47 +0000
Received: from MN2PR19MB2894.namprd19.prod.outlook.com
 ([fe80::a499:dae8:b1c1:b08e]) by MN2PR19MB2894.namprd19.prod.outlook.com
 ([fe80::a499:dae8:b1c1:b08e%7]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 08:46:47 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     Andreas Dilger <adilger@dilger.ca>
CC:     Alex Zhuravlev <azhuravlev@whamcloud.com>,
        =?koi8-r?B?4szBx8/EwdLFzsvPIOHS1KPN?= 
        <artem.blagodarenko@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [RFC] improve malloc for large filesystems
Thread-Topic: [RFC] improve malloc for large filesystems
Thread-Index: AQHVn45AfmzanBfwskq4XYElVj+Zs6eUXWuAgADXAYCAABhfAIAABgOAgAAHawCAAFpFAIAGviuAgAooSQA=
Date:   Mon, 2 Dec 2019 08:46:47 +0000
Message-ID: <432DE9DD-34E2-442C-8399-345ECA4B534A@whamcloud.com>
References: <8738E8FF-820F-48A5-9150-7FF64219ED42@whamcloud.com>
 <20191120181353.GG4262@mit.edu>
 <9E04C147-D878-45CE-8473-EF8C67FE4E86@whamcloud.com>
 <4EB2303A-01A3-49AC-B713-195126DB621B@gmail.com>
 <9114E776-B44E-4CA5-BD49-C432A688C24E@whamcloud.com>
 <43DA6456-AAF9-4225-A79F-CF632AC5241B@gmail.com>
 <BCFC8274-0A4E-42E7-9D11-647D47316BD2@whamcloud.com>
 <E02E44A9-6206-4B73-B52F-C3A1BC4C7D1E@dilger.ca>
In-Reply-To: <E02E44A9-6206-4B73-B52F-C3A1BC4C7D1E@dilger.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=azhuravlev@whamcloud.com; 
x-originating-ip: [128.72.176.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3489bb2f-2d97-433f-11fd-08d777042a84
x-ms-traffictypediagnostic: MN2PR19MB2701:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR19MB270170BCAC6D75950AFFFA26CB430@MN2PR19MB2701.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(366004)(39850400004)(396003)(189003)(199004)(26005)(91956017)(76116006)(8936002)(2906002)(71200400001)(71190400001)(33656002)(6116002)(3846002)(478600001)(2616005)(6512007)(5660300002)(36756003)(99286004)(14454004)(305945005)(446003)(76176011)(6506007)(81156014)(66066001)(81166006)(7736002)(6916009)(14444005)(66556008)(66476007)(86362001)(64756008)(66446008)(66946007)(102836004)(11346002)(8676002)(53546011)(256004)(229853002)(186003)(6436002)(25786009)(6486002)(4326008)(316002)(4744005)(54906003)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR19MB2701;H:MN2PR19MB2894.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: whamcloud.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E6Dop2+5l1esJlJI9CvOnhgk0zB8jboXCODV9pSH7z5A/gEC0UtVpZkUGo/vHtz2hRwiVm0NfwcEy+wQFMDFAfRcltfYxgQTdCP/ZJEPS1K+1u4yF2qFYSrL7yk2UG6/llA0gech0Gyfwf3iUIZ2se9RtueJ02v3UAlySdOFMbhLqRS6ztWK31nHihvWzozIkalotx+YYv/gMftwMpbTWm+855mevn+3E+xDLmdYkPVH6z+linmu1Qp+HNks4SoGqXZySCkY4SuSxpgbvkRP7gvx5UAn5Z+8uOgSmsfuSFFuud1Ub7XZmRU8lFOnaq379xemutwOTJCbAejyt51qG/8GWM37RLU70qY0zkN8RXFZwsm3LTMPHHNojOGuaIvtr/onBw5SYS2BoBYHG/CbBOf8YALyrT4zEeLk2gldVKGm7mu+BDQKbus/ZFSOOKf3
Content-Type: text/plain; charset="koi8-r"
Content-ID: <BD2EC37B120187468099601902296C00@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3489bb2f-2d97-433f-11fd-08d777042a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 08:46:47.1738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fP603y+lTtk1HN7DQeC7d39NwQ/UV5G9IGl3HDg7iSaRbLkiD8cNRh/vrdIY7vFNdaaTmQ5YAF6iZ1b4pEDS6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2701
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On 26 Nov 2019, at 00:39, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> I think it is important to understand what the actual goal size is at thi=
s
> point.  The filesystems where we are seeing problems are _huge_ (650TiB a=
nd
> larger) and are relatively full (70% or more) but take tens of minutes to
> finish mounting.  Lustre does some small writes at mount time, but it sho=
uldn't
> take so long to find some small allocations for the config log update.
>=20
> The filesystems are automatically getting "s_stripe_size =3D 512" from mk=
e2fs
> (presumably from the underlying RAID), and I _think_ this is causing mbal=
loc
> to inflate the IO request to 8-16MB prealloc chunks, which would be much
> harder to find, and unnecessary for a small allocation.
>=20
Yes, I agree. It makes sense to limit group preallocation in cases like thi=
s.

Thanks, Alex

