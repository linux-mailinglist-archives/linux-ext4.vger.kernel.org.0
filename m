Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1E21D48E9
	for <lists+linux-ext4@lfdr.de>; Fri, 15 May 2020 10:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgEOI4p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 May 2020 04:56:45 -0400
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:6116
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726922AbgEOI4o (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 15 May 2020 04:56:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ9O6bJnxn2fN9tRxZUuVgsguxZb/6kTEUkyvNzBzef9EUc8faM3mZpoNPN+R8RNk2HEtR+t0pogWXG3HT3cRQFXl+CsPbfMeD/jE6/wJ5w3SG4JylCyKmQGh3DIVswZExlngHBkX+Voecu8dkkpppCiQy8ZJ78/jEkkvUR6Xu7z4bs/fd8LB/GNjjfLIG0uf/Gzs4JaUqA6mH/0nNSx34z4QCuuTZ1N8ic48SO2tMCYDSa9LUcvRKkY7Xt4ddJd5H6g553b3UDg9s77edMcn+ND58zpbxZMncGHQaIXfO1NaMtmXMrFUVDLIgztr/QQUPpTooszAUV5FNo6AiLpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGhglOqnCZK/6DtzRT7RGQvfOfcrCM251qzcBRmplPE=;
 b=R/g3tGm0pYyZ/xnSQi0Gzh7q8fyyiif6VPfl50omSVskWs3OhyEFbnDS/6E2x3gKsiEXwMn93x34eVjoHIwHX14gMvT9q/JUyT6hlszSYe9ubwMylYGMZ55Ae+md8PoBBB2md5bJ/GXZUA8tgQBYSxvauFofzdLkhRW//K21KmRvemlu/o3qeSuBjO0AQbDzagBykF866TzvWVpQn7SGaoEVc69SXDsmXQXLTy6rjYVprrVlMwOX8yk6rb/JLaZ8lMHTFCGGDxKTrQVFFojHfc7RmnipRefKCjmG7ks11V8lU9nkydMeWAQ50rSO0M3qdQeylGZkO9kSSJ2PQLhzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGhglOqnCZK/6DtzRT7RGQvfOfcrCM251qzcBRmplPE=;
 b=iaW6BQDkQ1tmxtXzWXCYf3qcm29b+iJ+RfbMB45fGToa5iTWB5SZHjv1MT+MBOexzh9ThHTFmwMfxpqhBKlTPk+jKMh8i01vDBMyjeghx2v51wPh28ziHTBRYBeWa7OXcLeEBKeeMNiDTYgN1JweQYLcMiaNORE/PP2qxXAaBQM=
Received: from DM6PR19MB2441.namprd19.prod.outlook.com (2603:10b6:5:18d::16)
 by DM6PR19MB4344.namprd19.prod.outlook.com (2603:10b6:5:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Fri, 15 May
 2020 08:56:42 +0000
Received: from DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4]) by DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4%7]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 08:56:42 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
CC:     Alex Zhuravlev <azhuravlev@whamcloud.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4: skip non-loaded groups at cr=0/1
Thread-Topic: [PATCH 2/2] ext4: skip non-loaded groups at cr=0/1
Thread-Index: AQHWHEjMGVpmuPlRl0Kqrw5gTNRAkaindXQAgAF/eoA=
Date:   Fri, 15 May 2020 08:56:42 +0000
Message-ID: <914597DA-395A-47A5-A8D6-DFCE2D674289@whamcloud.com>
References: <0B6BF408-EDF7-4363-80CD-BDA0136BF62C@whamcloud.com>
 <20200514100411.D1A15A405C@b06wcsmtp001.portsmouth.uk.ibm.com>
In-Reply-To: <20200514100411.D1A15A405C@b06wcsmtp001.portsmouth.uk.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none
 header.from=whamcloud.com;
x-originating-ip: [95.73.85.160]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9500f853-b008-462a-2a7e-08d7f8ade357
x-ms-traffictypediagnostic: DM6PR19MB4344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB43440CD254D908C355F787D7CBBD0@DM6PR19MB4344.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /e6hLS+d5cqPvnsTTaDBHvqFOK2frW56K2gG9e8uvf0NY442IGpNV08nxmnbXtjJtqAGpNRU3e+/zDR4s0y/iCcnvhNSaL+QiIzPlpQMKfUj492X4jl6PuO8EYPLQXYVDvka6b80EVr+TuT1lrE2Po+++02FELWaBo/tWK+xgzbaJV8uyFFS1Agll0maZwJ4sYO9iLQTIA78o0ftTksqvlb7BD6yopZSWk8iu5Ib+2vfzfsaIDUnWmNyixgORI/wIA9WipB3RQ+iz57YmTCwAQMGQtxnDYeBhBPdJaHHr6oLbV9l+c264mlFI+29WnOCF615yP4g+ARVhHd0VMAmbdEzc/OZ7o5M7l6us9C1+Rb9tRIxvC8yISSqB3930FcgSW25b/iY5frhRdDF1kenK+s+Dzld2Jhb2NtHNn4zK1ScabKP1Kyxpd+k4ZH3BZcR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2441.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39850400004)(33656002)(6486002)(316002)(2616005)(186003)(6506007)(6512007)(26005)(36756003)(4326008)(2906002)(86362001)(8936002)(54906003)(91956017)(478600001)(8676002)(5660300002)(66556008)(53546011)(66946007)(66446008)(76116006)(6916009)(66476007)(64756008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: v3KrhHFyS5t+ptKxYg09bl2oNR9Cu3IBK40txbYzuYbhDzbOReU/FzaN5NK7+Fv+KfT+z6F5Z4pNMtS1zP4DaNtwqe48NT1+RETnBSXtFd5ulG81uckFjbTGpbko3tSv2uG+WA8/edfzhv3tLGRv5TzPInnqDrrY2qge23/bbr/BjHqAzaHxze8Bfrfavv2xx3ujiSzOQpmW8OqUc+t23tC6SYeeP9NIM654HVL6NSX3QKjRAMg7UPaad8ze1bvwC+OR5Am9jbw9PMJ/8Y7hP7LOgaC+NaRHGhz+kvoYV1txj3Xsguus4FuNIci1RcOR4Zf7OFl9StALGenot9QrGx9zhQSBOKuDIPB0bhjvizXXYDGdgDfuK9IxalekF5JuuGulIS2mBhg2eWb2cOfa/14Q/0PGvYDsdRG3LepjBBhF0YxY7a5rl6mQMoyS2v8occr9GSbpaBclXJkGvXpf/Lh9Jg2IeXMxwgGqRaICnBs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB2C887153CEB0499E8B32D176325088@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9500f853-b008-462a-2a7e-08d7f8ade357
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 08:56:42.2346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOuTno0gQcwyiQVjzMGdvZAQj4Sgm/QZKfg3pY+9Y8osv63xG0oPJeGVCRp7zxU8sF4pRdFxXvhHCOJ+P+AATw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4344
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the review, answers inline..


> On 14 May 2020, at 13:04, Ritesh Harjani <riteshh@linux.ibm.com> wrote:
> Not needed in a commit msg.

OK

>=20
>> cr=3D0 is supposed to be an optimization to save CPU cycles, but if budd=
y data (in memory)
>> is not initialized then all this makes no sense as we have to do sync IO=
 taking a lot of cycles.
>> also, at cr=3D0 mballoc doesn't store any avaibale chunk. cr=3D1 also sk=
ips groups using heuristic
> /s/avaibale/available/

OK

>=20
>> based on avg. fragment size. it's more useful to skip such groups and sw=
itch to cr=3D2 where
>> groups will be scanned for available chunks.
>> using sparse image and dm-slow virtual device of 120TB was simulated. th=
en the image was
>> formatted and filled using debugfs to mark ~85% of available space as bu=
sy. mount process w/o
>> the patch couldn't complete in half an hour (according to vmstat it woul=
d take ~10-11 hours).
>> with the patch applied mount took ~20 seconds.
>=20
> I guess what we should edit the commit msg to explain that it is not the
> mount process but the very first write whose performance is improved via
> this patch.

Correct

>> +		/* cr=3D0/1 is a very optimistic search to find large
>> +		 * good chunks almost for free. if buddy data is
>> +		 * not ready, then this optimization makes no sense */
>=20
> I guess it will be also helpful to mention a comment related to the
> discussion that we had on why this should be ok to skip those groups.
> Because this could result into we skipping the group which is closer to
> our inode. I somehow couldn't recollect it completely.

Please remind where the discussion took place? I must be missing that.

