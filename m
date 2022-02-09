Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754504AEC0D
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 09:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiBIITy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 03:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiBIITx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 03:19:53 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 00:19:56 PST
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322F8C0613CA;
        Wed,  9 Feb 2022 00:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644394797; x=1675930797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IjZwl3C/jtPiF0fEZLVP6o/fEYzXBj7cfmTzmNv5PiQ=;
  b=BSJeaNZtcP+Xh7YPHFCP2NFtiUYftHw6Z5lt6RM3HnrqQe5jI76wPYhs
   LNmfEUFle2DZ6X5Y8R83VFZmcu1OUP1zaQ5ukQkkLh1hdAOjss9vOE+VI
   kg9IMpu00KKik9FZ156S8YggStPapN5ntW0adau/Aq4vWt03GmVxm46b4
   S33nM7hGwEQim8FIulpce8VLgs1E8VEN8RnvC/Monp7ipPqP7kHQ/4Rdh
   IeTW+AIbhqjynzXh4GHOOTByvxAyrANveJfDeEUzfc/fxRPUVkPsG7QJ+
   d7JOCfR6d+6oNl5A9kYFYKZUd9xoYX26HqYzEDSy2r9FjWdaoATcbJ0hm
   w==;
X-IronPort-AV: E=Sophos;i="5.88,355,1635177600"; 
   d="scan'208";a="193471669"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 16:18:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkdtEJnCM1NYhIPTFtZODvIXnTrO5nyhoV6otMvo49v9OrqVQ0tgWs6DUrlqQmIWlGiRZwpG3mu9lm3P9takrbV5cuYu8cwPJTnS2l5klC2awr1Qd8Fv+LLCqFPP2FcGDndJsUQYMvhgMZLe8ugWHLhoxdnWXDVCEMbrWlAY2MDebwsf4wxKGtpW1O89fcPTrPr50kGLwDJHZjZRgIn/gfrFef5tcOt7QY+3ftKb7gJEY4n41ZKqa/YQ3PIbAj679HNd97mYxp2pdfz2XespJVxafUCKXZPkI/Nqj2x5pujFrN0KB4UIR/4kyZXx4+uwbdkoyo/o/Wvb9NBcY00EGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBKmyEu5mg2hA8989cPG9yfPPJxyuobwRByAiUxQCB8=;
 b=i26TaV5xbEh9LcXG4JNy9QqqN2LVJ1WEcrPhZO6VE+oK/6V8i0gQsrOsChn3QuStPQ+ufWubYBs2OWWaDn9yfkregBQmjyIA7DdPZ3EZ4VMLMhfyPocif6pUbzbm0S/YEIF0vK0oU3RuXHc7vl/RsfxnnRjxdrxDxwemHjBXhoUPUc1evp5Bdy4037uKj77uf4O+BElpdoyj7cgH9WuiJDsKjw154A9rdFrNnKfy4fRIJvZI2yFs90bA7PpdMAAd0gQx4TcB6UUj1iZrQn/XpkpymoPbO0J1izwTmdME39JKpKQFzn6Voubimu1mFp1nCtvDv1/jN417B08i7ixpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBKmyEu5mg2hA8989cPG9yfPPJxyuobwRByAiUxQCB8=;
 b=HwZvIC1io/n1lDfdTlDyxyGzE3OtwYu2qJo/+n41TcTwoHqul49hXnro4XEiuVdydfxhXMbEWtlDcul/ZzfamQX9nTA+PXX3FHhbPlhAJ1tlyGnfiSa2vadLX3jRolNwb6bAUemaKjwQ73vnRYox5LAPwgjGAUQp3ZrYzF+BDQo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB6017.namprd04.prod.outlook.com (2603:10b6:408:53::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Wed, 9 Feb 2022 08:18:50 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::8c78:3992:975a:f89]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::8c78:3992:975a:f89%6]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 08:18:50 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 5/7] common: rename _filter_mkfs to _xfs_filter_mkfs
Thread-Topic: [PATCH 5/7] common: rename _filter_mkfs to _xfs_filter_mkfs
Thread-Index: AQHYG+/CBPelkf6NS0GNBGeElFDeDqyKZC0AgAACzICAAHx7gA==
Date:   Wed, 9 Feb 2022 08:18:50 +0000
Message-ID: <20220209081849.32avg2g6x6bc7juj@shindev>
References: <20220207065541.232685-1-shinichiro.kawasaki@wdc.com>
 <20220207065541.232685-6-shinichiro.kawasaki@wdc.com>
 <20220209004316.GE8288@magnolia> <20220209005317.GE8338@magnolia>
In-Reply-To: <20220209005317.GE8338@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 208515c7-7138-47e9-b6a7-08d9eba4cdaf
x-ms-traffictypediagnostic: BN8PR04MB6017:EE_
x-microsoft-antispam-prvs: <BN8PR04MB60175D662BDCA7860BAF1E5AED2E9@BN8PR04MB6017.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HbE16zG6jW0mNKtTLC8KLDIWaMBAh31iwOnzKPkag46cOUyDMy2hI/yqda4pyHTM3t+x5+CfrH/Cd3G75lx6kqRf6gTeNM2h3LIoZ95uTLnJEcq5tyRj/aErAHxSEcri/ZbRrJWDCbpWlSs1md2OW9xnsk0gPqs1Carnx2srE6kCsjRcGi++i3ezE+BXPiT/z+lZxppeLkyixABfHs0J7h+nWtqWiMJtUm6qAI+n24RE6hJbVPbAwNqymmNkQRcMUs+w4u4ox//H7pFvk7N3+vwpVRdAzASa3DWyrdi1nrAxRT5PdEiQ+I8Fyb1R2K3I9x70IoOI25UxXda8qgC0RqFGJUVrg2Vh1f17eXCJTGS8GisDhzIq+Gg/uKfqSsqmqJKdYChK88GnQna+HfL1uqsGmGVP7wwyluXBIYzgc+ESm/YIGyu8ijpBUD2CQwHjczJo1QRjCJmdZb57znp3WOSMSqhTjy9LyxJu7EVNlMaxbwDwnWDqqlaVNuMaMK8mR4dSy/BpsH7XwW8ZfkeBuOTqwJpXXvcNwxbV/QVm7Di6JrqSk0FlTUET1/kpGSjMwyZ1W+RabPBZpoCIPBwVQ1wWqVAWaiAaZa23TroTjpR5jYnBnlNwjeJ5jh+jH+aEZvwKPMmMJ3irofTXRJcpinnEDMwJkaE5u8YH/KyZF+GSe9Uryj2N56QQVOzsVF028r+4pTdMPNRNI62rJpktpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(86362001)(38100700002)(38070700005)(122000001)(33716001)(71200400001)(8936002)(44832011)(5660300002)(66946007)(508600001)(6506007)(91956017)(54906003)(316002)(6916009)(64756008)(4326008)(6512007)(66446008)(66476007)(66556008)(8676002)(76116006)(6486002)(82960400001)(1076003)(83380400001)(26005)(186003)(2906002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GxeJO/fcNjlAQCtGvuVKdq8NPpqCyCelBoFjBSvUdqK2iY+p1Gu7mFVAexRv?=
 =?us-ascii?Q?BVBtWlQs/y5yOnAjnwg5FOGY7YYhROpWpNKHP6KQUpHmX1QWok81OMxNXrbR?=
 =?us-ascii?Q?y4+GGvKov0NbqOIdRIbydYQ/aFWuR04ZIbg8cs/DdsVNwYnsbRre7+xNHXKM?=
 =?us-ascii?Q?tjzgZQlOgpZO04E6GZ3bxjtlhbxHcRkwk9iIDlYCKBw6R2LnnPpGqKPVThv+?=
 =?us-ascii?Q?ERuu9ScJkP1M20Pgxs1r8pBL45Av7ppouw6a00VyaxLZmMVbXE90YNnETjf0?=
 =?us-ascii?Q?qHKcGgII2FcyyQcgUL0zn6pylJNMIiY5jboT9wZ4qag2UXm05YbCjOEJX/SH?=
 =?us-ascii?Q?XbCJKrFnwN1t8lmrvOF+XDdCO2VOPZbuHNU3H4fCY7rKo8M87zNFg08t+L7X?=
 =?us-ascii?Q?mh7q54BeZwbjJMe1SELhIt1z7ikTQWH1vKpHHWpgDSD5YaSwhsTRc9FJTddj?=
 =?us-ascii?Q?1Ajt5SUG6JB5ni3xQFpZOasSHnmGjCVp8PnCIdH/VQyBG4tM/RpmkeAbpqmj?=
 =?us-ascii?Q?4iraRzsEbUWp41r1gB+UtFNfu7NVcfREWBuFn169oAjtds4qWEbLAeC/KVqr?=
 =?us-ascii?Q?kJ2gyWczDgy0cFK8w31tr9UhOJmtZ+e6R4xfsS69M1VriFdRekDD1igh4sUm?=
 =?us-ascii?Q?lkXxGxfsUK61HadornLkHX0zilNFcQeTwzguwI3lmGM8AS2IiuiwHHDbEFoe?=
 =?us-ascii?Q?OEnfcz6urHFwa2yFpmSJK1u12SUv/UhTqpwLTEBhUw1goLvtT3TOJZPbVVov?=
 =?us-ascii?Q?qv9jmd9dbAk0t0uoTVKRjStHwOwCycBg7NDlxflmY8QA9tuHqMELAI4B47ei?=
 =?us-ascii?Q?Q7+4rb3M2SXtnoJVyhTMPeNvWxUnLw8wWXCa2B6PGaao0CWCPlfDyLCBhE9b?=
 =?us-ascii?Q?KVQRdVsAKjmYfVVwnd8tLv7wcbMmjPsIfcgkS3rgsr3YJOOl6b1b5mwFvyvo?=
 =?us-ascii?Q?csf66THcITgeukR34CsqkgiunBvtZ9yT5KdhDXQXhd3O9EBirJnYws1CUvM0?=
 =?us-ascii?Q?p48OA5OXiGVO3dmx/icAWZbLEXuc4+ZS3TucEw/3UUi7etsV4wbboZcchD63?=
 =?us-ascii?Q?5CPXRvqw+0dSuXYbteHRlExpb++yUtNY7nB2RH/i78SfnGml516zqmJIrCVy?=
 =?us-ascii?Q?qyakPfr5bpygxQWgO2mrbRuuaeYkoWkgDnUPaBYhrSsm9ABX+DAoRReWsxlj?=
 =?us-ascii?Q?3ybBFH5mFe3HIX8LMPH1rAfJZQ7CxeZcvEkwL1o+Iwbhn8kYe5nSTYdzaQU+?=
 =?us-ascii?Q?ufsq8Fi8gkXYQ7pmEQ6aN/tKreyZoikiTVMMF1WpiaqdjbFZ+uuLzcwcqxRQ?=
 =?us-ascii?Q?VxcFplHTTlqHAYpoCzi30xK12jcsgTk15XBVQvghip2Hv3nxWA7YKGbqycQi?=
 =?us-ascii?Q?DhTnp1rkrCRUFRhPcRH5uZKLivVlARD3R9GmoqRMKwFHQGugR/YSZebwf5wf?=
 =?us-ascii?Q?MhAiVFQmZuvLNNTce1QYCZwdF0lLhBpzUmk4PGYVH9bv1KRn8XKhd5iLvyor?=
 =?us-ascii?Q?zwYsq9zY/+0A8DWd1Vjm8Q2pgeXrd9TqV1DgoJAM2pInwXYpcv9XnzQCRDMq?=
 =?us-ascii?Q?g+P1PRaJemeKp7Fs5+7fHoGavoYQZxwz1XLyHEYh8EpMF6dXdlxKovBVLCfD?=
 =?us-ascii?Q?N/65zjVAib8fsqwAcWCkX7vGkF2UJlzZHTvSq0bJheVTxDVvX3kTwq4yA8C9?=
 =?us-ascii?Q?xesVisM4J+7wlCsgdjDoYx2n+k0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2472D23298DD754A9C5984E92A7EAF85@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208515c7-7138-47e9-b6a7-08d9eba4cdaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 08:18:50.6707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AV7d3naGLdfW29S66NTYZnR1WktizzxLaJaD0refmR8mSikAxZ8VnmUSNvspF7Hw1AvR8g8DYEKGKk+i6g0fSkemgTlooNK3sFldKI58dso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6017
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Feb 08, 2022 / 16:53, Darrick J. Wong wrote:
> On Tue, Feb 08, 2022 at 04:43:16PM -0800, Darrick J. Wong wrote:
> > On Mon, Feb 07, 2022 at 03:55:39PM +0900, Shin'ichiro Kawasaki wrote:
> > > The helper function works only for xfs and used only for xfs except
> > > generic/204. Rename the function to clearly indicate that the functio=
n
> > > is only for xfs.
> > >=20
> > > Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >=20
> > <snip the diffstat>
> >=20
> > > diff --git a/common/attr b/common/attr
> > > index 35682d7c..964c790a 100644
> > > --- a/common/attr
> > > +++ b/common/attr
> > > @@ -13,7 +13,7 @@ _acl_get_max()
> > >  		# CRC format filesystems have much larger ACL counts. The actual
> > >  		# number is into the thousands, but testing that meany takes too
> > >  		# long, so just test well past the old limit of 25.
> > > -		$XFS_INFO_PROG $TEST_DIR | _filter_mkfs > /dev/null 2> $tmp.info
> > > +		$XFS_INFO_PROG $TEST_DIR | _xfs_filter_mkfs > /dev/null 2> $tmp.in=
fo
> > >  		. $tmp.info
> > >  		rm $tmp.info
> > >  		if [ $_fs_has_crcs -eq 0 ]; then
> > > diff --git a/common/filter b/common/filter
> > > index c3db7a56..24fd0650 100644
> > > --- a/common/filter
> > > +++ b/common/filter
> > > @@ -117,7 +117,7 @@ _filter_date()
> > > =20
> > >  # prints filtered output on stdout, values (use eval) on stderr
> > >  # Non XFS filesystems always return a 4k block size and a 256 byte i=
node.
> > > -_filter_mkfs()
> > > +_xfs_filter_mkfs()
> > >  {
> > >      case $FSTYP in
> > >      xfs)
> > > diff --git a/common/xfs b/common/xfs
> >=20
> > This renames the generic function to be "only for xfs" but it leaves th=
e
> > non-XFS bits.  Those bits are /really/ problematic (hardcoded
> > isize=3D256 and dbsize=3D4096?  Seriously??) and themselves were introd=
uced
> > in commit a4d5b247 ("xfstests: Make 204 work with different block and
> > inode sizes.") oh wow.
> >=20
> > I'm sorry that someone left this a mess, but let's try to make it easy
> > to clean up all the other filesystems, please.  Specifically, could you
> > please:
> >=20
> > 1. Hoist the XFS-specific code from _filter_mkfs into a new
> >    helper _xfs_filter_mkfs() in common/xfs?
>=20
> UGH.  I pressed <Send>, not <Save>.  Picking up from where I left off:
>=20
> 2. Make the generic _filter_mkfs function call the XFS-specific one,
> ala:
>=20
> _filter_mkfs()
> {
>     case $FSTYP in
>     xfs)
> 	_xfs_filter_mkfs "$@"
> 	;;
>     *)
> 	cat - >/dev/null
> 	perl -e 'print STDERR "dbsize=3D4096\nisize=3D256\n"'
> 	return ;;
>     esac
> }
>=20
> This way you don't have to make a gigantic treewide change, and we can
> start to make this function work properly for filesystems that have the
> ability to do an offline geometry dump (aka dumpe2fs for ext*).

Thank you for the comment. My thought was a rather negative one: I assumed =
that
_filter_mkfs would not support other filesystems than xfs. I will add a pat=
ch
in v2 series based on your suggestion above, expecting that _filter_mkfs wi=
ll
support other filesystems in the future.

--=20
Best Regards,
Shin'ichiro Kawasaki=
