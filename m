Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E9B4BD717
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Feb 2022 08:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbiBUHC5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Feb 2022 02:02:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345757AbiBUHC4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Feb 2022 02:02:56 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F1B2180;
        Sun, 20 Feb 2022 23:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645426953; x=1676962953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0Oxcs+yebJGfAse4aP2bc1EmL5gV/Wu/hJ8JO3TZCfQ=;
  b=FYsIFLiTzn52Lg8Horm9Pc2Dpp6FfCeeEB6T/F+8f1wbp2L4hyR+w/oU
   6fLfR1splM+3nX5Az6vlbEb/bcgWy3ECiJefHilbZxyOIfAabS48wXvHO
   e3iDtw1iBjEb6f6u6VGGwI3TbqhJMPefi5UqBiCa5ckyxBge5cgK7W4z9
   kvoxomFA5jdIcpAMyHQtlOjdXSnxLE5IgiGJzMv8S5+cekKG4iKYN2Y9V
   J4E34xk9V5I+5b6lnXEdzlPC5QniNejq9kGTiCxk585EA40Mf2WG3tZRn
   4vbW0bhzjAb/hgxTjmEFE+59ulkOBLIE5iaMWpnQCQ1xdxSKmvT9dtuE1
   g==;
X-IronPort-AV: E=Sophos;i="5.88,385,1635177600"; 
   d="scan'208";a="192426483"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2022 15:02:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg8HhI11jgdYJaV54PVBBpS3jSH7kDLjeEibcr4nqjMMJDbnEDhS1MAXlzgkN8oPkkS8aUg/jsUkQa4xgCeRk5unKeUIugk85G3l26jxyFG7U9fxTGtPPNxm9jmd0pyhc6MREa+oTGFELVZLeOyjHehSPqdXf56/ZVgxjm/FFl8vA+8/R+DjQaJQTdx+jMfbugEqfrtcBq6i428wH33V9aBtpO3rr2zp9jrfCZlmfN40j7nP4G4sRZWFkwu5drWj6bHb5AFfNdIBDE/RefMPVPT8nHuFGUV0P2+E+/CDSajKA9AuGtu7usvpxy7EkjQkq+fh32wtltgObvM+LVe+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+8vSv0P2n3eEL20OS1x/ei/4k+Ud6ol2VAXejvjjG0=;
 b=cIE3hhDElF3kCozp8u6e8SLLHN20KQ6u94C45rSaHPcc1R/3r5Z1T5vCq3VVuBDjqY5ToB3pG+V9kOfwTMVDnmWYfpWamJ8VNSFWIpHYfI/f1acJNre8itl6aBD7CdUtpXDPMMgv++5wh4pWcNWQHqlOarFuYqD/pH7SdwFpZV4thXseLI+A91B78MeouB44UE+AOjDSHwPpbeMt+8r0P3LhOsCqYqfSN0lsoyjrzqOv/M4+c2oYOtCpGjO5z4l4MQ3u1uzqhIZBvSG2vJKSZ6IxeQ8DOlsEZ+5bS1hKOAOV6BcexEi4plHoatpte8IDvC9HLmf62W7klG2AEZx/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+8vSv0P2n3eEL20OS1x/ei/4k+Ud6ol2VAXejvjjG0=;
 b=SjinosgZcJkJrZ62Qq7AfzhmaWHZ+0z8iHGR57SqPs/34V8RPVYOMOVv7d6G7yMiMvJjupQVk4KT3S3F9cIbAqoZIMy9YqnCbyOKzxEJMx4acUls1mxZqvN+DY0S9dXZgLe6+UR11NZYs/u0g9gkyvpeLQROe9eAiGhJaP63nnc=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN7PR04MB4289.namprd04.prod.outlook.com (2603:10b6:406:f2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 07:02:30 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::d179:1a80:af1d:e8ee]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::d179:1a80:af1d:e8ee%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 07:02:30 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Eryu Guan <guan@eryu.me>
CC:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v3 1/6] common/rc: fix btrfs mixed mode usage in
 _scratch_mkfs_sized
Thread-Topic: [PATCH v3 1/6] common/rc: fix btrfs mixed mode usage in
 _scratch_mkfs_sized
Thread-Index: AQHYJJmjoO7DDZp/HUO2SfmtKtOnLKycrX+AgADrSIA=
Date:   Mon, 21 Feb 2022 07:02:30 +0000
Message-ID: <20220221070229.2hs45fqk7fbfbgpk@naota-xeon>
References: <20220218073156.2179803-1-shinichiro.kawasaki@wdc.com>
 <20220218073156.2179803-2-shinichiro.kawasaki@wdc.com>
 <YhJzp/dnfixk/nMn@desktop>
In-Reply-To: <YhJzp/dnfixk/nMn@desktop>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3816d5c8-4c33-43f5-be1c-08d9f508207e
x-ms-traffictypediagnostic: BN7PR04MB4289:EE_
x-microsoft-antispam-prvs: <BN7PR04MB4289019FCB7F8DE8FFE687228C3A9@BN7PR04MB4289.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HVjqzI/N17/g7qCoPOLb7rgOVA9B683YXN2FRPq0rykubDqYVnCJ+qm/EombXXxfrKcSGiHV9Ff7kaMnAz6NevXhLpsmHHYDFWgFvOBB9+Fmnhh7kr3f6ZBvWelbwXM+tkDNYtI9OOoegTUBhRAldhzfJ4QZTMMEQiEWl7fHkcGSeiT2yCzfR5C8WRBxqXik3cuFcnKhamoQ/L5ObVEbyNjv3i906g1JHxqwY0wtiPZWKqkugjirNjKy+BheN66ntd6ImDpdWUmrAY6A9skLwYqlqaIFYxD8hCu1+9Y68JEVGJ0DXln50Skz/Z7gFdCa+mn4yX5ZcnV1+CE0eOu5odNvq3LWgsuX1zYLh3XZCrjtsKeqNlseEmrZYXfqK0NO+O8nwPuCBSGJJMoB0Pma4YfKEYPSl9zFynh0C/CKwS4enToRaQO1U2JPNTCxxmRaWO8YfhKkAq5MgJjFRC3Hc4HLLp0TfiX9+l8uKZsGxE2TmNKoXH4uiVZIlvKOmfZFyGNX/hVSJ5lwPFKpZBdDx8JZZ7Cn+X6qaBHRjxUJjBZqCVpaoLu6gIAKwYhMK4+ulckmrxeRqFwp746xRumUAYriW1uMlTb9qqB19yLkBs8lyhpXs/YGEb6eoKrZ0XBCitLuo6+FcnPQajcldfYbSqLo/c+0bjDVAfbqLIZdDBquQCiGpPZlfLPBh7z3FtK0yBDlfFxH8dSHc19IUBpnad3eTp4DoQaE/8aP+nJP85ma4zn6CvBBWjtsahMJcFUJfd8CFuCUY4PYANyuH+nltjhlz/M+pwSfUoISEFNMBm0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(33716001)(316002)(66446008)(66476007)(66556008)(66946007)(966005)(76116006)(64756008)(4326008)(8676002)(91956017)(508600001)(6486002)(5660300002)(6506007)(9686003)(6512007)(2906002)(38070700005)(1076003)(82960400001)(71200400001)(26005)(186003)(38100700002)(86362001)(122000001)(8936002)(54906003)(6916009)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aumfUXhjLr8HWRKXdOatpnnFcPkp4CXXy6/24G38+BmjlEY/G9/wLaQfP9lx?=
 =?us-ascii?Q?oA/sWxWntL3ZyYikq2qwwXsbYB87/3PHA6hAEmAbXpPQiShddwjxyuRo6S9f?=
 =?us-ascii?Q?CqlN0sGfhTSXiyPm6JGz2cnWG0Y28TpSzYt0N2stsLfa+/eknD2vMQTRcyET?=
 =?us-ascii?Q?Pjyq4Y4O3CxS0nGv9JNJ8ig+3VAKbmxlj+BUoTfdWKTKuu22QO5wEHRvG9qF?=
 =?us-ascii?Q?KWR9jOXuSDKMNG8JUZnXRA8dMWY2gmQAwQ+xvjmvrLbVHaUE8KIbZc7vZKlY?=
 =?us-ascii?Q?hFv4WDHE8ArQRJCjhqqXjRxf1U0/i/PCmK1vyeVcDxl7+Wm92PLBGvJv9QxL?=
 =?us-ascii?Q?gMBYAeA5/NJ+2pUt+ixQm2Mhx/jEJ8WCRLhl7oeSZLh/h1GgPhVzrMpo836F?=
 =?us-ascii?Q?lE95aEsU+tkyB4jRcuhgOwGiQxeY7+l3A3m9xBBzfP5lSndk1aere1ztcB81?=
 =?us-ascii?Q?EI7qqk/MVTM+krO9rTsoKRJa9GMF091AmHxY8q++oa5zqE6Es3AQEgvhGg+/?=
 =?us-ascii?Q?smMDiEIY2QiZZrhIk2rwXoKdTuWDBEMXguQIDYWuiVYRtg8BtLN5EvwOk7Sd?=
 =?us-ascii?Q?vRUWEWIwAwjkxw5Z5IyH7BjT2/OC4cFzK+BhO2Uj7pem9PRXSDLwGMSioDvT?=
 =?us-ascii?Q?yonSuktmzJcwN/z6UMofDV5saWzw6oqFc8cNEJ97pI6SVz81Po3a8LAF0F06?=
 =?us-ascii?Q?ggunAw6mHs3Xs7zCI5Qp8PDJ7xdbp0ufq4BDaOXvpH79J8f4xGRt6qz1RdEf?=
 =?us-ascii?Q?6WAifzCkzWiindsuGEmwObS9ZSEXUPCOfbUbOgxkXqdPDMyMGjD3mJ99k3oF?=
 =?us-ascii?Q?bEFZeeaU6Fa0bSGDqwg7M5eMzSOmmAGP9FiXG2bod1v6Juxw+JDSvmF26n9V?=
 =?us-ascii?Q?r4vgF6gqHQsR117pkEX5EclEbwHkjdqC30blXdmFs9RljR3YpUaF/zBVE6u+?=
 =?us-ascii?Q?nZZJpXz0JlRHnJNRLNf134Shm8fSSYwEG87nSwytT+PYyDYuzaZw36OF+ZyJ?=
 =?us-ascii?Q?H7BSYm+dwzDDT/toPQd+u+LHEbKvJsDzdl2RTsKMST6cQ5gIqBvTO9YwU0Wg?=
 =?us-ascii?Q?Rv69JuY3k8lUPqXFU/t2mzAxhPrd2JQjf4tx+j/ppOYrUd6nxZdkp2FbV25o?=
 =?us-ascii?Q?zkEGc8pwiZ3pO/ca1SyWe23t0ZREKWnsaRCcuAUpeIASxNoGtGGr6iZCQj+v?=
 =?us-ascii?Q?gFesZQ0CgmkBfMATY+VDZJj9l0DiUEj1o1BfMiAq4N7BoloLJfAFYIEamIQk?=
 =?us-ascii?Q?OdtXplTDq8CtpzTeJ/n9iQemmicztSjZ+r/D+VZofaxbDh5fjsCR+X1LBI+p?=
 =?us-ascii?Q?+H92pkhJVAFfo2Jvk2dnDJ/2JJem5AH2xr2XP+JjqdR6F3vqoAovGk+O1Y7X?=
 =?us-ascii?Q?nNZVnAo6rP/WwJj1I7Cz8L8aruDPxC+zlWaEtHM2ORVyTqJvqXRJY1cvEhaM?=
 =?us-ascii?Q?HPiR9wQ/XSCfHr83VC8xPJsnBh5JehxRHzkYmkvql9ArteBUHhY5yzXhYbbp?=
 =?us-ascii?Q?nROjaELQubUqRaFNYmpbXVfha5vaLiwO4fhdA6Q+Xd7VgObgcp7vhO4B8JEQ?=
 =?us-ascii?Q?P4PQNY1LjpRKYLiIuce9WwavkRD+QrdZqlREeeLiK9xOK2kVCGL9X6164zm4?=
 =?us-ascii?Q?Er+QV/zl7uEyBubHFPtcg7M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7656ADB8E9EE0C4D8F675248B50FEA5B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3816d5c8-4c33-43f5-be1c-08d9f508207e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 07:02:30.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZY9zD6CHvgtENOuaqyisWGDYoyU5km0kVabQnZYNPjDiw9uguKib9YWGEIn1qCtL8UCTXIlqpHM2iojOFRQVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4289
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 21, 2022 at 01:00:23AM +0800, Eryu Guan wrote:
> On Fri, Feb 18, 2022 at 04:31:51PM +0900, Shin'ichiro Kawasaki wrote:
> > The helper function _scratch_mkfs_sized needs a couple of improvements
> > for btrfs. At first, the function adds --mixed option to mkfs.btrfs whe=
n
> > the filesystem size is smaller then 256MiB, but this threshold is no
> > longer correct and it should be 109MiB. Secondly, the --mixed option
>=20
> I'm wondering if this 256M -> 109M change was made just recently or was
> made on old kernel.

The check is imposed from the userland tool btrfs-progs. The value is
calculated from a code in 31d228a2eb98 ("btrfs-progs: mkfs: Enhance
minimal device size calculation to fix mkfs failure on small file"),
which is released around v4.14.

But, after rechecking the code, the size part of the patch looks
invalid to me. My bad.

https://github.com/kdave/btrfs-progs/blob/master/mkfs/common.c#L651

As said in 50c1905c2795 ("btrfs: _scratch_mkfs_sized fix min size
without mixed option"), we need to consider every possible profile to
decide the minimal value.

That gives me:

- reserved +=3D BTRFS_BLOCK_RESERVED_1M_FOR_SUPER +
	    BTRFS_MKFS_SYSTEM_GROUP_SIZE + SZ_8M * 2;
  --> reserved =3D 1M + 4M + 8M * 2 =3D 21M

- meta_size =3D SZ_8M + SZ_32M;
- meta_size *=3D 2;
- reserved +=3D meta_size;
  --> reserved =3D 21M + (8M + 32M) * 2 =3D 101M

- data_size =3D 64M;
- data_size *=3D 2;
- reserved +=3D data_size;
  --> reserved =3D 101M + 64M * 2 =3D 229M

We can also confirm the calculation with a zero size file:

   $ mkfs.btrfs -f -d DUP -m DUP btrfs.img
   btrfs-progs v5.16=20
   See http://btrfs.wiki.kernel.org for more information.
  =20
   ERROR: 'btrfs.img' is too small to make a usable filesystem
   ERROR: minimum size for each btrfs device is 240123904

So, the original 256MB is roughly correct.

> If it was changed just recently, say 5.14 kernel, I suspect that tests
> will fail on kernels prior to that change.
>=20
> But if this change was made on some acient kernels, say 4.10, then I
> think we're fine with this patch.
>=20
> Thanks,
> Eryu
>=20
> > shall not be specified to mkfs.btrfs for zoned devices, since zoned
> > devices does not allow mixing metadata blocks and data blocks.
> >=20
> > Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> >  common/rc | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/common/rc b/common/rc
> > index de60fb7b..74d2d8bd 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1075,10 +1075,10 @@ _scratch_mkfs_sized()
> >  		;;
> >  	btrfs)
> >  		local mixed_opt=3D
> > -		# minimum size that's needed without the mixed option.
> > -		# Ref: btrfs-prog: btrfs_min_dev_size()
> > -		# Non mixed mode is also the default option.
> > -		(( fssize < $((256 * 1024 *1024)) )) && mixed_opt=3D'--mixed'
> > +		# Mixed option is required when the filesystem size is small and
> > +		# the device is not zoned. Ref: btrfs-progs: btrfs_min_dev_size()
> > +		(( fssize < $((109 * 1024 * 1024)) )) &&
> > +			! _scratch_btrfs_is_zoned && mixed_opt=3D'--mixed'
> >  		$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
> >  		;;
> >  	jfs)
> > --=20
> > 2.34.1=
