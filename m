Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F774B1BEE
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Feb 2022 03:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347163AbiBKCId (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Feb 2022 21:08:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347159AbiBKCIb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Feb 2022 21:08:31 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109EC5FAE;
        Thu, 10 Feb 2022 18:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644545309; x=1676081309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C3mu6J3djkptvJzVveOhtTc0DuU4l5kV9/5Ov+folzs=;
  b=diT+bd5aBKneSiWU5yHQOHJskriy63F+QoDCiEnqHVbIcobZL18VSeZz
   FzpyO8jXXUrp6WM4UYW3GFBSKgz1a2UYfVuo42hmW7092KSdVtGxvyLyn
   nWmO00DVa5ZxMmGGTtMKx5p5nXftYEyd2tbWkxYWxhqDMFUimSNV914SZ
   ibQt8JdQOHPrsaiEt9aN/ynHqhgFHzUB8TXZDuB6vkMvxsCH6LyL9a1sA
   nE5PK8sz95cJa82VWOfcbW8+fg5zp3mP6GxFHUP62QIviQxEvwNGIpa1/
   psnV78N2da2mwyUW6znDjnAycoobyOPP0GLH2uGb0Vadb+/sU4Icrlr2N
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,359,1635177600"; 
   d="scan'208";a="197479426"
Received: from mail-sn1anam02lp2042.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.42])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2022 10:08:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j91ys+F/ZzNsVLWJ+1kGotS5w9+MvS865E8C+VJ4aQJoVWbUNElBy46006uRGRQs4Vu55iSZ/9BlMN2PtudtsUDz0CiS25MzJT2+p3Y1hLSw5eQ1FZgZ4D5M7HYGVll9wC46Lxl7KaoJQyCyioZhDAykQOc5t4kRT9yQmrVp7Tq0nRMWBkE3SnTDV5O56R1EI2Q9d/VChkaLJQgKVFFW61L2ZZjrgmtXvzN5Qforkp5lD1c2qnZZEmSnc8Xut48gLvdhSDTkw92FiM/ZHTl/RlIZzkpZo6U+TJNBCxyluV/Nhrp2XfQU3rT14SvcgQWiQlqjA23Xk45+18ioC6rmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3mu6J3djkptvJzVveOhtTc0DuU4l5kV9/5Ov+folzs=;
 b=oSvqC6ERra/zvE20lGojOzDMdpPgaK9jcHqMl0OpRC/FxyfrNiBxSpJnYj1vE22r2R+vSFI6sY0lHoFVkZSc1rGkHS24NAg81bv2Wr1XiZA4taETa9Z0HhKrr0HtRkxQ95tJ2gR3MYgN67kK5IXACS/IKw5vnevd6zycOEk2xdNNJqNS5EHWd4XoeZUawkNVT9h/ceAgqTTvMV5g+0FdWFnip+CgyQc+TvkB1+mMrghMzN8iydNP0KmvhEp4Ovowru2SL+bFlnXnGaiNw/YZMaZ7Ob6KNMQECNr/klwAy5C5XwsygmpqQfahL+8vhMogUBQliujldoXgC2B4b1OAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3mu6J3djkptvJzVveOhtTc0DuU4l5kV9/5Ov+folzs=;
 b=AXZS7rlrprbmfCBUNOlkFohBXubFC5a962W47prAcmMpKm59Q7FUbQqRNJB1SV3+xKZTOLFtM/iHKOWaW1c+yoN8XfuxLPAXorrMRQ2jbZCk36zmxyb/MtFWIO55EGAA9EWbnFA9SdpsR3/jr+Mq2agYEDCHJzgH+uDA05Rf/B0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN6PR04MB0932.namprd04.prod.outlook.com (2603:10b6:405:43::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.18; Fri, 11 Feb 2022 02:07:36 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::8c78:3992:975a:f89]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::8c78:3992:975a:f89%6]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 02:07:36 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2 2/6] generic/204: remove unnecessary _scratch_mkfs call
Thread-Topic: [PATCH v2 2/6] generic/204: remove unnecessary _scratch_mkfs
 call
Thread-Index: AQHYHbE2IBcn5+zDo0iR6hGUaqqMrKyLzicAgAHOugA=
Date:   Fri, 11 Feb 2022 02:07:35 +0000
Message-ID: <20220211020734.x7nxgvdl4ltesjb2@shindev>
References: <20220209123305.253038-1-shinichiro.kawasaki@wdc.com>
 <20220209123305.253038-3-shinichiro.kawasaki@wdc.com>
 <20220209223124.GE8313@magnolia>
In-Reply-To: <20220209223124.GE8313@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09bcc3c5-9540-4640-f436-08d9ed0345c8
x-ms-traffictypediagnostic: BN6PR04MB0932:EE_
x-microsoft-antispam-prvs: <BN6PR04MB0932B257CC69B14F4530CB5BED309@BN6PR04MB0932.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: llyJeYmLx4sPKOW4Bt0GjsBCs5MZQZIAQf6qPfLhSMzz8cFdM5rNdp6b3bF9AzNE6AWlC3p5WSax9uI6E0GYBktZjX14wJ7HQNB8u8X7ypSyQWaDr3arPTGfi2eXTf68Fl4IewPRGzTVidnfIoz35cjwRUT2pH1D+SoODH71gYvyrL+m+cHyVc4J4oGgtBWmcNU4PystLoHbzirkjjp7O1xpPCoVKsDKRllCR3u9mGxCBQTyG/+4ZwjVjBRwtt1wGTf3MW1d33Z5bn0wG6YJNxiHYdZXrKN0+o15gLx+Y1+GNmjY6h7u3Tp0xwBzg75gult9zVUd+PIrEdMHCCwp0DwhnkHy4WxXP6kIOKVs3Y4IRYOLyjez8vtabuXpNdPlznJbDZnF3hHRPwMGsux/MgATNz9vgEmLLo6Xk0LNXsi5w7rkQ1gI4rGsE4AfUWQX/xirMfaiDKs84I/qNLt6D8z88L8Hk2CPTSNanLci9K+a8MdahNYTGE3BYCHfnUvPxs3LFyzn8iMWFdojkZQwM+AoJTo0R5B6/awHI+n40SE7ZpoYn7TpprXcbQ/KKkm2vRFuSFyHGdz8jui8UpJcL/MTY63yNsHFoSs8MDP5WlqwyLSsexcJIPGsUrE2Wqs+FLY54Rlfsv0tqllH30RzthGSVB/AhxcTXTFMMem6PpCi98HY91HzFGXxj7yRVJoq5RSyRBcORlGT3VRX1EhKfCHslcsNjCKXFZVHVNo5rnc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(38100700002)(1076003)(6506007)(71200400001)(186003)(508600001)(26005)(5660300002)(44832011)(38070700005)(2906002)(6486002)(82960400001)(9686003)(86362001)(66556008)(8936002)(91956017)(54906003)(66476007)(83380400001)(6916009)(316002)(6512007)(33716001)(8676002)(4326008)(66446008)(76116006)(64756008)(66946007)(122000001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N1bcNoI9vVQCaU57VSZEGEfbOmpzCTUt0Q7tTjFSVM41XtRnBhjWkKYEI+zV?=
 =?us-ascii?Q?3NatasYPVkV7uGYWHbfnLYXtsZaJG4AYAwHCKXKZ60QG486HtHuT+wd98f6j?=
 =?us-ascii?Q?j6ItbCh64TQ6JoOKHiM1AJaMBtNPmpin59R30u/pxUC7DpIajOt6gpBava89?=
 =?us-ascii?Q?2o0zVDBt1LASLwepAq4Xulk/eMR5Hm6ny4KLMSM49/di+Nb8PCNOSeAEhNYi?=
 =?us-ascii?Q?MMbbs9RNdvrEFlT9fIde/eqGHYkTvWrVEgUE9Zjsj0nYKdQju54cCDGQ+UZs?=
 =?us-ascii?Q?pnXweap9kGf+S8pnO0FhRvPtQAQ8m0W6jwZkKg3gxnPWH2i+NDVy7Sg8oavZ?=
 =?us-ascii?Q?Zjx1i36s+0FS6+myjnyg38iqxQRWqWNcxfsr9d+BMO8OYW4+4gkyi/VR86l2?=
 =?us-ascii?Q?sn7SlUodeMr+2WoM5X5VuUn91nrPE2EtH1jRdX9vJ5iDkqhMlYoeAznJ4Lna?=
 =?us-ascii?Q?msW/SNM9wUm7ekOllRwKSB3RD7RwRysbTDdZdbgj48Vs2SgOHJXCz70JVq9M?=
 =?us-ascii?Q?h8ovoXNxSDT1FFkMquHJitN8lpB6i7MSzANxUOnaOpLlbl4Q0u8RQzoLlr70?=
 =?us-ascii?Q?w8FR4PqdXPMdb2WZLQzE1u62fXLXv7kR52HUYfpYxSlSLS/q7fkz9xi8QSZp?=
 =?us-ascii?Q?S0lkP2Hz7krqgoPk7hOnKP87HHOOBckgrofL8xP/CwHmKRS9C7BKdUZcRfx+?=
 =?us-ascii?Q?rukxGLXN4sHQH/e1Dqy++Apk0OydNVnn9Gc7TIy5uUqL6ZSvshr2RMZG775y?=
 =?us-ascii?Q?Hc9vHCsKT9dYTqNrt9BhRqHjS12aldG/LZcP0WCkwBnKv9b3R/URdGUD0SRS?=
 =?us-ascii?Q?H+iCSSVnR6IJwPfUIJbk+SbIQ2/c5GG4sy0x13J3m+miyRL0G9x2epRKWNX4?=
 =?us-ascii?Q?WnZlts0C1S1hXzNYJIYCssJy/cZ4sRBEEedwDgzvfikdwB7LDvLELJC/dTXM?=
 =?us-ascii?Q?hBgAhqOE9fqs3JK6ZXyVN5HHvfMh9M4+VoOhQlbcO9ZrjJ9kw1rv7H0v3jSc?=
 =?us-ascii?Q?oA3MZQVAcGQ8NdFLDRAQhDluW/zN6uY/bLmHAmoJ6p2A18ilgFduwA4H+YSW?=
 =?us-ascii?Q?nRrND8y3l8sIj/odJHButGWxxPEyUyUd8jbTsq5zrPQQvnEJ7qwUUOhc5Oop?=
 =?us-ascii?Q?MDdbzAWz/4EIbqKvcpPzOOP8ROlnRFMyOZrTjnshEWGVRzthM3HtrTHX3ZPp?=
 =?us-ascii?Q?ebvKcjbC/AOm37PIdoF0ss/qQsf6Al4aK52uUgkItMlkwjsF3MF+TMREM/mR?=
 =?us-ascii?Q?tvcSWdRimW10f1Bs97qXLUOyZlyclUkSwaJ+HeNevJ+6/sUIToGqG7re1Ksz?=
 =?us-ascii?Q?aOYScIwYfsHtMqtRu/uqk4xWzPuksoFsMcla3h1LUjZGtvwn7sBNjCabwpC7?=
 =?us-ascii?Q?elrqjtUqBx568yGFWD9TrgrQyCmlIth3sncfY9OPI6x9SqFvsru6ZHf/sfEN?=
 =?us-ascii?Q?a+ymPj0WxU//SOI4F1ynsbaJFaC0tTE3VmuA/lVN9ygLPH4xmqNEDQVwEOHQ?=
 =?us-ascii?Q?CvJCQmUDqOl7HbhZgjEuUbG2TCcFvvvtIYduXfzOJsTxxsExHW3sdY4wK22j?=
 =?us-ascii?Q?eCNsTFKWtjysd17x8gYIGaROe1zjUCrmGWKJU8cp+glZt0biBNVw42zbGZMK?=
 =?us-ascii?Q?hePFXYP+s/qOYLgbZ93BOlBmDF8ilZnN9Uag3PqPM//QE1u2Itbiq142Dp+T?=
 =?us-ascii?Q?Ph2R/hZkT8WEZpG7K7rR4YcruKc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99C1B80739909948936F0C1225B27B08@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bcc3c5-9540-4640-f436-08d9ed0345c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 02:07:35.9399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KzuzP6NwMaUszVjwmKtjsqYmmTYlOoUHej5sqs3e9mDVZTEMGnZFJtXkcb0SoA7FL4Z92bu6j9LNXJLIFpyqH4fo+7Q1i+BhqtKksjNJlQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0932
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Feb 09, 2022 / 14:31, Darrick J. Wong wrote:
> On Wed, Feb 09, 2022 at 09:33:01PM +0900, Shin'ichiro Kawasaki wrote:
> > The test case generic/204 calls _scratch_mkfs to get data block size an=
d
> > i-node size of the filesystem and obtained data block size is passed to
> > the following _scratch_mfks_sized call as an option. However, the
> > _scratch_mkfs call is unnecessary since the sizes can be obtained by
> > _scratch_mkfs_sized call without the data block size option.
> >=20
> > Also the _scratch_mkfs call is harmful when the _scratch_mkfs succeeds
> > and the _scratch_mkfs_sized fails. In this case, the _scratch_mkfs
> > leaves valid working filesystem on scratch device then following mount
> > and IO operations can not detect the failure of _scratch_mkfs_sized.
> > This results in the test case run with unexpected test condition.
> >=20
> > Hence, remove the _scratch_mkfs call and the data block size option for
> > _scratch_mkfs_sized call.
> >=20
> > Suggested-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>=20
> Looks ok, assuming you've verified that fstests with FSTYP=3Dxfs doesn't
> regress...
>=20
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks for reviewing. I tested the test case with FSTYP=3Dxfs on a few devi=
ces and
3 variety of MKFS_OPTIONS (no option, "-b size=3D1024 -i size=3D512" and
"-b size=3D4096 -i size=3D2048") and all passed. Also I ran whole fstests w=
ith
FSTYP=3Dxfs, and confirmed that this change does not cause additional failu=
re.

--=20
Best Regards,
Shin'ichiro Kawasaki=
