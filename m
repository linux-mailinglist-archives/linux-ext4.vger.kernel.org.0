Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093274AEBDA
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 09:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiBIIKO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 03:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiBIIKN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 03:10:13 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 00:10:17 PST
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB94C0613CA;
        Wed,  9 Feb 2022 00:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644394217; x=1675930217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=66Snzh7heFuBXcDkixi365ERgCYg4r1x51qZyvUdBxE=;
  b=a3qjwNGVAZLyalcl/6hsw6riLFtFxq3geDNrpEb3uHKt91eIz5sAaKVH
   GCdZYV5yXc2c1cEnVvPvengIkfHkihYHrvb73W9UI5yvBBGVhUpc/Tfp8
   x+VsHury/7xm7tcksNYQU0E9FhQkQlLkTDWWPFGHHSCUR9F3yXMGqMI5A
   QsWJmQm5CXvoHSAjQGpisDRQBg0olOfFlJV+1V7iH4TM8Z2rcrGOQqEeu
   g/wRDiKHGhwHBbaXjyULBBmtIlUG0AG1s5AbtnKMUTUDunHPiRBuVyE9C
   PcBpFMiwaXO0vxCtmdKtcQ41qXCJbqiv8K3maU9UK8s8GACVfuaaaqj7+
   w==;
X-IronPort-AV: E=Sophos;i="5.88,355,1635177600"; 
   d="scan'208";a="304393712"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 16:09:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLfBj3fnq8q7j18sPPDFZ2mSICDXrQ0I5bGDdStnL+9z5UkeTLmN698VY2mVfioJ8bn3PAmm0+EQeV5npXffxBzZahU6NKjyiubNYpKhaqX7bm86mg6mjOCgryUBAbBcgmFynfbAL/kGgZATR7x6TEcI//+iH0npWx+ILMeYP8WVi8YdhNgrA1o/bEiBVQIxOYawqfkdC18n07UYCOlgB+BYr2SSumFC6eElJDqrSNxMgBFETf2L3+L752/ZHlswvnqmZseO9pwiffEa6gjTt34rfnF0BDP5vDPyY61FCP2GnRdNA6RC4F8voGB/BgMK1l5TKl6xTn8LEGqZNefyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iO4ur4RrUJt2uS6cyOO7WWRo73SlU2IvhKvV+KFk4BU=;
 b=dzuYFNJE6/1WB8lRSO9HpXPwtHxlirFe+OdfT+oKixszmuO6bnoano86/0TI+nRkYMfylxk7h0ZxWHUN0h9FDxTrSSxN5qNcEE1XS/XkWpcr2VVa2MZi9mjtWIDGc5+q5fc1xBnmv9jPHoZb4e+bSyJ2OAmtvivOuM/JyM9nttOQ8lvuUK8/61PQDqMqR2ca5X7zmCBcH8zBlkeavjzH729WdlC2kKI2CHLi71bDLTGsewVJXetQE2YdHfBTVTOk/jCAdgBoRLaPNIZGOB9Pnil/zF+QUuYNjXegUofjhmUOmwYs5YmThZ14LPLImQZrEaCQZwOeRIhG1zsPw6Ug1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iO4ur4RrUJt2uS6cyOO7WWRo73SlU2IvhKvV+KFk4BU=;
 b=R7GgrQJxBrw0HwBEN7/xLBKCOIE2Mvl80d097G6HXVeySnx+etbm5HjksHBByhUviUdT0hblrxUwJ1yOgZi7uVNikMGurjhs1a0R9Z2mfPOPwU6NC4TpcCo19QRa9OiYKkt5r7kwcG7gY3uMEuNzZHJKKmHskSPbelWLFI9Rx60=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB3989.namprd04.prod.outlook.com (2603:10b6:a02:ac::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Wed, 9 Feb 2022 08:09:08 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::8c78:3992:975a:f89]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::8c78:3992:975a:f89%6]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 08:09:08 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 2/7] generic/{171,172,173,174,204}: check
 _scratch_mkfs_sized return code
Thread-Topic: [PATCH 2/7] generic/{171,172,173,174,204}: check
 _scratch_mkfs_sized return code
Thread-Index: AQHYG++/fU37Bwzf9kG7eXUDEk67SKyKYhcAgAB+qIA=
Date:   Wed, 9 Feb 2022 08:09:08 +0000
Message-ID: <20220209080907.r5olnguhpdllqe77@shindev>
References: <20220207065541.232685-1-shinichiro.kawasaki@wdc.com>
 <20220207065541.232685-3-shinichiro.kawasaki@wdc.com>
 <20220209003548.GC8288@magnolia>
In-Reply-To: <20220209003548.GC8288@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2283fb71-c5e0-449b-f549-08d9eba3729b
x-ms-traffictypediagnostic: BYAPR04MB3989:EE_
x-microsoft-antispam-prvs: <BYAPR04MB398905C92633139E1B81BF88ED2E9@BYAPR04MB3989.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 22UjfCaT5h7Eoy8xk/T2/tnyquQBSWAZyfc4dRa0lsKwBpfVTh6sE146xpWFsTzsY4ravFd8MzkVspXos+K1xWzeZ3Kyj0pAe94n0NfRS0oCq4ymj1DOx+As2/Gylf+0R5bvo+0wLM4Ec//x2hgduIFXLKi18nxdd7ga+C69AFhKayDgSUd46D1whwcUX4X1lvrPyjwCNv6prjyAo91bCeKulKj0x9i2txV/bSSwvK4/gys9Pp3cssJldjctSFCa1NAz2QrfP+WcXK6MwN50+PfHsrU3xdUxh6MaBS62NtIfXpGVJA9LLm7x4sOeQEE2NAtxtueW8YppF4nAMZI9iezqFOagaUqL1kWuGi2c6Oj/BlvCqBOMqvTlKTTGCBGQ1DEaOjzrv7GzN2c4H1eCucYybEfG15uGdfoVk9KjnRSt8nlwz0D0mjnPftPsiSsSZNRv6xJWtFE+y9BFUqXf3UwOYa95B6YyYpAdGAgXgvqFW9254lEolMs3s24BIrfVYFH+a8HSJaoHoXcDTor8jxVkJki5NlUVw1dhqzg4e30Vdqtuq9KQdoj2JyPsHjitJN2szQKjpn6/nlMybHgcnktO0npdLf39179Ii/VPp/UY0B4b5ItNdzSY83doIEHGNzMnsN7/nURtLb1B+Da/LbW7CyOjVMa3PPe9/9AZtFlvYAtwyw9p8n0yD6TJUUcqbKcKOgsanZvLQe8Ss8F+prWksGHQpin1IFPf96Apj1Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(5660300002)(64756008)(66476007)(9686003)(66946007)(66446008)(4326008)(66556008)(44832011)(26005)(186003)(1076003)(6512007)(6506007)(122000001)(83380400001)(91956017)(38100700002)(76116006)(54906003)(6916009)(2906002)(316002)(86362001)(71200400001)(6486002)(8936002)(508600001)(8676002)(33716001)(82960400001)(38070700005)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2CFeMWvAth0Qj1lIGlj8IzeqBKZhe3QfWxq7moGL4R/k789qeA+4QHqCBuof?=
 =?us-ascii?Q?8nOGo5kmLOcjwpeVnYiKPgkPDvouOsLbcjaB+h8GxtXyNcm3PQpPCl+1jmAO?=
 =?us-ascii?Q?9g1Dz0HneU/27gG7MAy9sDensOZHcYce3JSkH5TUzmG7hAAyDzjX8JXR9n5b?=
 =?us-ascii?Q?hjacEUkWu6Wir6BHfchd76eWh4cW99T95zNXkB8micTLfSCmYQJ159ok4SDn?=
 =?us-ascii?Q?hha9A0dtgNBGGlIiWsqBTzTbs/J20zOxe5gTJ81ul5PeHIkE8uRYLKUNVPOm?=
 =?us-ascii?Q?hki8I6/lP06bO9fRgpYBKsTZNWVLonA4mKAqACdizgKGkwN+6uZy4Td0Zh65?=
 =?us-ascii?Q?hu3bHDZKWB9Zf30MS6OtpP1RBbL3HaJQX5NPmZ5k145+AMKWftrBEnECa5fC?=
 =?us-ascii?Q?tu5s/sH/151nd44vXKBwh6eX6V/5Z6G9buYFgcEVHPZ5QkFK8ezFohDUcgaF?=
 =?us-ascii?Q?aZl/yI5w4UyqmDC5pdjFsL+VoXgwRhfXwdPj6FuWPw34OeQmxyOl7motU5Ax?=
 =?us-ascii?Q?Sy4/T57DDF3rYpUGCMJtpISj4iKjOoCE2eV2mVYVfWty/Z6ALRT1iHYxaQJB?=
 =?us-ascii?Q?klPFLGgWptn9PFZMjJGpAZWYvDeKByw7J2+VzLcE1HPTd+yHQ7cyJ5Q/SQ83?=
 =?us-ascii?Q?icJR5HlZzTr1d8RtuYTz/i++387C2vW+zru+XhZmq1ytCzTya2xoeFjER8MJ?=
 =?us-ascii?Q?Gldimvrah8ysZhJ79rknb4whJEB/2Bl36YnTf0obPsLyGRESPx/r53yYPIZL?=
 =?us-ascii?Q?+JquUizQeSGwrqFSYzXL7cCAgOAryXjeafl1YpSk/Tf4aedJqFM2+6dce9XP?=
 =?us-ascii?Q?BN0kGKGYgrLNctY/A1T6MSOjtUPQTZ0VA7wBlxx5dqrSShJrt73z181Y8y1m?=
 =?us-ascii?Q?oOaLnj0X0EyF6qz/4DrO+BdhNv/Vxeg2GMjbuTEvafF44lSUd7UrNNl8hM8y?=
 =?us-ascii?Q?+VjvolDFmwCcGT+4V3F0UEb1onKMrXI1cBX/7cmEfuGAJTEfYapvtlZZQImv?=
 =?us-ascii?Q?xcOH38eA+xdQxWKxz3HiV1u1nMs62O2IvVqMPCB6+2ukOKMiscyzSl4h5Xwm?=
 =?us-ascii?Q?YCGXjc6ZQUOloVG0baF5dGoVMTKOLFQU2DHV8SbgB2EoCDY4/JjfVRSob0hr?=
 =?us-ascii?Q?0fUsXukaubyoS+MTJ1rRnNpCyi1zm8DX7NlC03JaBBq83Hl9PRzUNne2+cbA?=
 =?us-ascii?Q?q0Rgsum9L50rfqyizrctCxTBFN0o1q1jMBYixVMSJNqRTlArTwEb/Gnq7LlC?=
 =?us-ascii?Q?5fz/ZyGJ9GEN3LhCQtGGLuU17EWy5S3xPKWcfHm9LdkjzFr8iWXHfBbhN0Xv?=
 =?us-ascii?Q?u7wgg+z6ZegqpvpkQvmsefHHqFG3XWIAxGeBKwHSkBGKSwOpLWxeiHdsoLKr?=
 =?us-ascii?Q?uLlePx3B61iWDmjF5CIYecPDD2FQQi0UMUdsoWhtNgVIOgApeRkpdUAAgh1U?=
 =?us-ascii?Q?vQi3RDj5tZqLozjuSIer7oIRKYmXF9MnCqh3o23iBXfymtuWTONFTsrk+zPB?=
 =?us-ascii?Q?vcBZBMJUs0QTXfezZYuB4AFLNhEQsqA6NQP3BYo1mqWl/rjRWK3tIGvDM6Yq?=
 =?us-ascii?Q?qjOaL94aDZ5I5b7szBPK7YV6jfVR7rhK0cdobM9B3CmC27S4RAOiAab1iTy0?=
 =?us-ascii?Q?cvWtTmnE8N09BqK/VWeo2GlTPZMjFG1qPHh4q9oLavcLwxpdKn2EgE3uJT7y?=
 =?us-ascii?Q?XXy8EvPP+jcKOAsdh54IAjUE5bg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9934DA6C7266AB4E920CC0EB4990EDAA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2283fb71-c5e0-449b-f549-08d9eba3729b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 08:09:08.3874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qm6/e2t6p8sJqTxIOTlMOk8HZeyZfIr0yJegZ831dCjOCqg78HlL6Rityml9gaNDboVKi8pXONKpAQ2W8H31kW8Et2yu6EumEmoJM+ubu+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3989
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Feb 08, 2022 / 16:35, Darrick J. Wong wrote:
> On Mon, Feb 07, 2022 at 03:55:36PM +0900, Shin'ichiro Kawasaki wrote:
> > The test cases generic/{171,172,173,174,204} call _scratch_mkfs before
> > _scratch_mkfs_sized, and they do not check return code of
> > _scratch_mkfs_sized. Even if _scratch_mkfs_sized failed, _scratch_mount
> > after it cannot detect the sized mkfs failure because _scratch_mkfs
> > already created a file system on the device. This results in unexpected
> > test condition of the test cases.
> >=20
> > To avoid the unexpected test condition, check return code of
> > _scratch_mkfs_sized in the test cases.
> >=20
> > Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>=20
> Hm.  I wonder, are there other tests that employ this _scratch_mkfs ->
> scratch_mkfs_sized sequence and need patching?
>=20
> $ git grep -l _scratch_mkfs_sized | while read f; do grep -q
> '_scratch_mkfs[[:space:]]' $f && echo $f; done
> common/encrypt
> common/rc
> tests/ext4/021
> tests/generic/171
> tests/generic/172
> tests/generic/173
> tests/generic/174
> tests/generic/204
> tests/generic/520
> tests/generic/525
> tests/xfs/015
>=20
> generic/520 is a false positive, and you patched the rest.  OK, good.
>=20
> I wonder if the maintainer will ask for the _scratch_mkfs_sized in the
> failure output, but as far as I'm concerned:
>=20
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thank you for reviewing. As for g/204, I will remove _scratch_mkfs call as =
you
suggested in other e-mail. So, I think this error check addition is no long=
er
required for g/204, and will drop the g/204 hunk from this patch. I wonder =
if
I can add your Reviewed-by tag with this change, but to be strict, I plan n=
ot
to add the tag for v2 post.

--=20
Best Regards,
Shin'ichiro Kawasaki=
