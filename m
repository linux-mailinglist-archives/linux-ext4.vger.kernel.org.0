Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5603D4BE3A5
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Feb 2022 18:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355956AbiBULUD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Feb 2022 06:20:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355730AbiBULTT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Feb 2022 06:19:19 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1049ECD3;
        Mon, 21 Feb 2022 03:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645441379; x=1676977379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K07BQinyK4h4kN5Wy7nU7zszHDmJGhsxeQdujuYSmgs=;
  b=cERxjiLPD3XjV92Mp0BokvZdJZqf/ntSuelyCu19NGB8SwQqZcdcXQ+k
   cEucTUydCzK8paT/lw/YikSVb2uEXsj1vhUPkzTV5GputBB/U6gPtSgW6
   RF3ZF91dZEx3qEskLBSwRD8Kcs/Gu8W6fpOGCg+LYLfnNA3/gWVfgnByK
   19WwHHWrDQcjl/0gZuvndDzQq0jdWqDS7gOhrFwO8tz2o2t+rO9K7wK1D
   7tCmuG/1CDoq2mAVxiLqq7WGnNe0Hny7eHxkISwxlfjRrVa0v9gbSfT++
   3OlilCB7vA7XgZEdRpMK/vr5tX+cVzTgTdoYIty5PG/3HtRvk3zrwj5zt
   A==;
X-IronPort-AV: E=Sophos;i="5.88,385,1635177600"; 
   d="scan'208";a="305417467"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2022 19:02:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2XChqyAelr+M18S+MGxNDGOiK1gQmjOeLQ7pEitZ04WZ7hBULNM0Gajef9Sz6AJ/O6MsyB9TT8niDjcDe03MP3X41+wwQDtcbbqtHKTrlVeLMmYjegVk8pI0/29yDp/Rwd2t3WsTgXoQIQnp8rj4+F7O2TNx4wlfJ9hmxz1SGt3l+H0nC+5aA1ZMxwvBXhpKe+wciZttDXp1hAIJaQMHVgXVsJaRb8WthCKH1YTHWOujNqOt9l2wc8lm80Ncs4DA7jBmL9Z2rS49ix2CeC3kCYc0VnL9dRjvCQRLtQe788LChlYKIdWgUmQZb4Qp+LGjvbr+GN5F8fJvKft9YliLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z49nIhtKrq/zeLYPdtiE3+niV9qZeOxJIALWT08fq70=;
 b=BzRJKNF0lcXmEEVz8iMYlWCcp3uXA+6aykVOLSwooPDQpbGcY2IIYHhS46UdWRMAq8nG0ZfylcMwaW0ldopCqg7XfdTxbfDpsJvZvPnxGtKOXdYQYoHG5plOdcHGYwCI0M0dA50Ci5VScl+yLIvtpaMcpD/IChFuDp0OBlHEBO2vt9gLzY05YNSkJBiIsiluvfMhrUJDBoLnJ1m9EiZ2VLcH/K4OwCUcQGTHXcVapX5OqIeaS9BGhpyz+vv9Ze0tukolM5ZnFRcwWyS4d9Q9sHGIqVRn47ZQ19HK2EcY9RRUCFpsP6O9tVdPNEXweBuIyrdQ3Y81bxd4nJa6MidUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z49nIhtKrq/zeLYPdtiE3+niV9qZeOxJIALWT08fq70=;
 b=KWJH9zmCKJRKE6937+EMaY4hik1cBD3YqJJJO8xdr1bkNW/Iu1/+azDzSpON4PaI9MVHalzakk26GBLKE7AmM6O7BMspkYwqaobE6CAxPO+ZIy+cwtlKoj8uGCTq926UvwKNaYgRUcgqrN/p9AzOjOk1Upc0iskL7r8dbR8J/8E=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN3PR04MB2354.namprd04.prod.outlook.com (2603:10b6:400:1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Mon, 21 Feb 2022 11:02:55 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b13a:2b9b:b0a2:d17]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b13a:2b9b:b0a2:d17%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 11:02:55 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     Eryu Guan <guan@eryu.me>,
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
Thread-Index: AQHYJJmku29ruJf1Uk6KIJBch9qCEaycrX+AgADrSQCAAEMrAA==
Date:   Mon, 21 Feb 2022 11:02:55 +0000
Message-ID: <20220221110254.y2yb7xdlf22ahh7k@shindev>
References: <20220218073156.2179803-1-shinichiro.kawasaki@wdc.com>
 <20220218073156.2179803-2-shinichiro.kawasaki@wdc.com>
 <YhJzp/dnfixk/nMn@desktop> <20220221070229.2hs45fqk7fbfbgpk@naota-xeon>
In-Reply-To: <20220221070229.2hs45fqk7fbfbgpk@naota-xeon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b54bfb6-9731-48ef-ade7-08d9f529b667
x-ms-traffictypediagnostic: BN3PR04MB2354:EE_
x-microsoft-antispam-prvs: <BN3PR04MB2354D0FF9BE6444600287B6DED3A9@BN3PR04MB2354.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TJOSRq9O+VCgLxa2njSgpjMYi/zsvw5oMIkeNJ9EsHarR0RFBlQqhKWXbsS9WaRO2j6N1Z8EKh0WsvQ9PwhR3/YQTg04sMDZhJbs5P+5WU4Hz8AAOrUTXdrOP70wfps2JBWEgzujLEW50FI0DzAJlJPLKdAV17X+gbWR3riEnrNuLIoydCkY6Dwv8XWV6spnuT75x7nIbIzf3aYUOmps44+KOxr27BwTwNe0F2+VebOY8MLk5YSknnJee3nVISWN/VUEZBZYFnT2yhVFrnVeHNoBzk/8qgOiX02WBd0j428Zlvf6NQqREMVVO86iwWLzYbL2zwOmKS9oi2X1Gxvfu25daCS4BoiD/LcTb1woWaS543DnwN3JFFiLdRqXNYVuAJf9ejgnC6c1iOxpg9uPtBp6ROz5F/h2u3w6T0Lq/A+aI8Q9C8xC6FqQVrcInQ1y7yq8ZNUsa6v8qvpDEC4Z1YEWGguH2xtL1qCBXLgpRiRPj9aEHInapsMpmN6sfTq+ZnhVtqoWB6iy/G1yihMkqyOWaMg4KQQroGcnJGJo3Xec3k6nUM2pnrGTleMe1Z4HhLH2SHcMM+WKMKcaYm9S9cJ5n9EaRDHYW6b+SamVSxQ1GBMz5TgnkUugfG+sYBtFaskdhT3/LitziEm1qJsn/L7D/sm+Isa007nPZBTU4ADV5FqHIPuEbAdnuMLJRFo5YGvx6X2cRaNFA7IyozBxXG6mlReSzG54mGEOBY7KM53Ldv3U3tgaBsDixkI4cOYaGSfOgOlaRtFj4vGO995EGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(66476007)(6506007)(2906002)(66556008)(82960400001)(66446008)(4326008)(44832011)(6512007)(9686003)(66946007)(1076003)(86362001)(26005)(186003)(122000001)(71200400001)(8676002)(6486002)(966005)(508600001)(38100700002)(5660300002)(8936002)(64756008)(6636002)(83380400001)(91956017)(6862004)(33716001)(38070700005)(316002)(76116006)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UEPS2sCL2ZqoLZU910zDjjliw8GNabw3JoAXaBtCt7TMdUq6zx1TMT2v7iBi?=
 =?us-ascii?Q?MNIx05wqM0UNYFHEEiOo2DfqjLhV5MMCnRvm/t0FzcahN2IK5BQE0N0otJPU?=
 =?us-ascii?Q?dOdWg+VmjQfTyUrrbR0gld09WaBoZ6G6g+P9XjoJYRIS+PHTzusf8KWc53Qj?=
 =?us-ascii?Q?iKAoCr8Jj6c2zOKsEqqVoYmo8KMKoWg8wLZIgoxDsvwyi0UbBKbMR9kurK8F?=
 =?us-ascii?Q?gzYNbxb1+9QHskHZZQ1a9sxN3mQCYxXVQ+Ef8zHynpCRGGczkPiHwcK6XkTM?=
 =?us-ascii?Q?o5Zc1t0Nm4aKR6Ki5Z5UoLgPVjCo7cD/UPbDn6wC8LPTu4WF5j0SKR2leYhR?=
 =?us-ascii?Q?uGkvn1c8/PUF9t6Y1QLTO6zrnWYiZcTb2P1HonYdZwqOYjUjdil/eu8AHfr3?=
 =?us-ascii?Q?DZOPO7WUvMpWGSWVyC7m1+Vk3y5mEV+bI4xucnjsnm4FS4kcEDId+JU1/XtD?=
 =?us-ascii?Q?q1C8hNzNIhhWz8oNP3LzakDyOiFO/Hg9ngoe/BLWg7hMhIJa0pot6+M98s8h?=
 =?us-ascii?Q?pI5PhBNI3DnrkYQq1b0jQR1bjSN/PDCFwD2ea9wkFsvKbaUKkBvL37n08ywk?=
 =?us-ascii?Q?7V7kOMztPTLYeyQX5wgQ4gCF/xB8RYalgKVkxcJcE23WNEC3Yt88HI4/p5a2?=
 =?us-ascii?Q?ay3x0sHeXpHrPb5V+C7iNcwGZOWK5bIAUpZub2qAyhh5V1O2N7m1nsMcNJ57?=
 =?us-ascii?Q?ipDz9S+U6Nr0OWDiadNlbIvBiW3g4CUhqoQFmRnxlYz4BKPWTLM/I6keQTP3?=
 =?us-ascii?Q?5Om9oflsk9dvrYBvx0ZL99ntOOHN+QcxwXLHrmwiwq63OzqEtE1kN9iKnS5W?=
 =?us-ascii?Q?xGBHnt02h9bKoPtMeUNZIFgTHPkCN4MRsuuI6wcltpMI6VjreN0XYT/jU59u?=
 =?us-ascii?Q?gSDOE76ozIvoJ3tVBUYSwMAKCbsSo2RiDzAiIRJabNpxDd1G2AYG4yQDZtHE?=
 =?us-ascii?Q?npOcCwgw8wXe+9tDL8QQbF2HmpeOk1TutM02+9CZmQnNNKeCbdUHSTzrtNgb?=
 =?us-ascii?Q?vukTEYs6Dhg+uWr7pglaCVRGoybwAX6rbGnkDVnnkjoICWbVZaUziY9RdOaA?=
 =?us-ascii?Q?YybWSLnQU7QQnQkyS9uLQE0gKMvQNjNpLepQdbiSfeNN1OqZgkWv/UwvzGrI?=
 =?us-ascii?Q?dtQs+6B0h4omEA+adu4NpZ7tL17LQY5rq5QcnGbbuO9E8UgD0fYLy/q9BGJP?=
 =?us-ascii?Q?+KV98dgMlukT0FWSVzSx4r66olNfyewrxD8kcJjnzE1e36gsWaqkalW9FR8y?=
 =?us-ascii?Q?wepjnpIxwRIdcK9KhVBhPjGq3VbYpt7100+B3v+y8s9I15WbWKCSGIW2DQUn?=
 =?us-ascii?Q?qWQ3xGf9GnyEzaLIRpfxLt7EPQOXYdqIcC9xbKQFhMCwIwYSB+B0id+vMeOV?=
 =?us-ascii?Q?cvSLBX0C5ptG42nU78oShXka78W1BlR9MfMQVD4H0+lW9JmJ4c3QX/BAuk2f?=
 =?us-ascii?Q?BX4CyY3zWcdF2eeoFvF8m0SZQBRHDfAuMZ/F32Eze/gIFicic5S4JoQpJpXl?=
 =?us-ascii?Q?0V2eZjguLhtW6PtZ81seuoW4Usxs327aUoHOrARWBJM5rhRSgumxtsMpJ4E1?=
 =?us-ascii?Q?8U7ys25Z/zOKJUZm5NQlY2bW0fqLLyswIlesnnUq/6dbd8sVo9RWPSMAwjM/?=
 =?us-ascii?Q?Z368rZsVIo4FVg08w+0upsti2j7EGGxnnz5driruwN+bjjl5IK8T4UdCSrta?=
 =?us-ascii?Q?IfYtpj7asQT+dMNcRvkryXQkV0s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB7B9428D9250048B8B372F51265DDE0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b54bfb6-9731-48ef-ade7-08d9f529b667
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 11:02:55.1097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8mKjyAOna3plLaCyDI+MPwp0NX4R1n9eZ9xwqcGCeCknedEqj3Mni0x+lDcpRJwbW4eye2G8Rb8yvkDc0Cnqa5+pPNsR5OpFnP/xp0OSHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2354
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Feb 21, 2022 / 07:02, Naohiro Aota wrote:
> On Mon, Feb 21, 2022 at 01:00:23AM +0800, Eryu Guan wrote:
> > On Fri, Feb 18, 2022 at 04:31:51PM +0900, Shin'ichiro Kawasaki wrote:
> > > The helper function _scratch_mkfs_sized needs a couple of improvement=
s
> > > for btrfs. At first, the function adds --mixed option to mkfs.btrfs w=
hen
> > > the filesystem size is smaller then 256MiB, but this threshold is no
> > > longer correct and it should be 109MiB. Secondly, the --mixed option
> >=20
> > I'm wondering if this 256M -> 109M change was made just recently or was
> > made on old kernel.
>=20
> The check is imposed from the userland tool btrfs-progs. The value is
> calculated from a code in 31d228a2eb98 ("btrfs-progs: mkfs: Enhance
> minimal device size calculation to fix mkfs failure on small file"),
> which is released around v4.14.
>=20
> But, after rechecking the code, the size part of the patch looks
> invalid to me. My bad.
>=20
> https://github.com/kdave/btrfs-progs/blob/master/mkfs/common.c#L651
>=20
> As said in 50c1905c2795 ("btrfs: _scratch_mkfs_sized fix min size
> without mixed option"), we need to consider every possible profile to
> decide the minimal value.
>=20
> That gives me:
>=20
> - reserved +=3D BTRFS_BLOCK_RESERVED_1M_FOR_SUPER +
> 	    BTRFS_MKFS_SYSTEM_GROUP_SIZE + SZ_8M * 2;
>   --> reserved =3D 1M + 4M + 8M * 2 =3D 21M
>=20
> - meta_size =3D SZ_8M + SZ_32M;
> - meta_size *=3D 2;
> - reserved +=3D meta_size;
>   --> reserved =3D 21M + (8M + 32M) * 2 =3D 101M
>=20
> - data_size =3D 64M;
> - data_size *=3D 2;
> - reserved +=3D data_size;
>   --> reserved =3D 101M + 64M * 2 =3D 229M
>=20
> We can also confirm the calculation with a zero size file:
>=20
>    $ mkfs.btrfs -f -d DUP -m DUP btrfs.img
>    btrfs-progs v5.16=20
>    See http://btrfs.wiki.kernel.org for more information.
>   =20
>    ERROR: 'btrfs.img' is too small to make a usable filesystem
>    ERROR: minimum size for each btrfs device is 240123904
>=20
> So, the original 256MB is roughly correct.

Naohiro, thank you for checking the detail. I agree that we should keep the
number 256MB. I will drop that part and repost the patch.

--=20
Best Regards,
Shin'ichiro Kawasaki=
