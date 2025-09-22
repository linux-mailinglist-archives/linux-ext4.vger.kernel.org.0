Return-Path: <linux-ext4+bounces-10340-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2514B918D3
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 16:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AC318964E1
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4428025771;
	Mon, 22 Sep 2025 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=viavisolutions.com header.i=@viavisolutions.com header.b="kPTI1VMV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021120.outbound.protection.outlook.com [40.107.208.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A08F8F5B
	for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549624; cv=fail; b=qpzYOMgxXBGegCv5lgOPDti21wDXnu371p5z8N/i/bHvsGtjH107qWe3MhwADZFWiHD8POm7o7oFviHfKpEU6DcEb8ZOuXfaZd/dYqr3fmu7nufoA439GvBZRvV0+33GFw0qAnZY98Ztq9Pv7TzWAnK6i0y04KiWHawnkIvz8I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549624; c=relaxed/simple;
	bh=IC6X/GlC85HK0OCxRLop29C17aEMQC3HnRnYbpito+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FyIbjxZ2fMvpPKvdY+UwxOxAGcQH/aoPr0siDJYDAm9uvuDPFJGoAi1RPwIwdtsIrZQ3wzl2T7BaeJ0eRWkXrW6xBNA69ATjRa6eneLmVTY/hc9HQhxYJp2T+cglXWP7axcEZVzaFgyRYunm3HVw9A8+rSRhkFlL5HolbPHBpuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=viavisolutions.com; spf=pass smtp.mailfrom=viavisolutions.com; dkim=pass (1024-bit key) header.d=viavisolutions.com header.i=@viavisolutions.com header.b=kPTI1VMV; arc=fail smtp.client-ip=40.107.208.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=viavisolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=viavisolutions.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wT3raZXsixRMYBnS565G/O4o2/EljFjHRUyA8mUHvkX7N5sjM9GVSEtXJn1m4kl+wMH4QYv7n3Q6ub7C9ALSXuagvUREVsabTCTXgPAfJXV4N62/5smgO4MN1SyH0/7YefB2DOGkI+ckXRWmAp6XNaqaqenPp0hqYPoW+Jrz8nSHIe1zxkenDvETeSfYnnEqxdIzjzbqWx6WmccWE3vGIkx4vU2PP8/g5k9QPwSrYEHPjwCJtTcrCBcrb3JG7YQ3H5U9KgS0D3+buIUAVFwjwDXsqFem7Hogu/PsWMd9n1xXfyYCAG44GYfBMrqIsXSk4B02iJFe5kJ2hA2uTe6nmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6GbXiDGeHjGyoOy9l9enOgNyL7b7Q6K66yxYxof+GA=;
 b=P9WPvoviutboi1KSKTTnx4xoLs0Lrm01LOmVUFHz+k6O6gyUctREB+8TbGBvaNwQd8XdFlFEr8oBSPDm8VxBBufevBsCO9/FsoKWNNJIJsgmFWonFKM7hViq3lkNU3ZcmWg87RnatiWPA9afV7dPCdwlVxgjO933MIyAE8tRPOYbbB37EhihrKordMjuOdaKatbyU1SjwNeIY9ehVVgDXu3OPVMXLs0wAkCkj/9RGLyloudUUPKfjXv+P6BlL/wcABPiD4/PwJwua15zoxhGghGfN3sm5CA2hJo9lNcoAkuYFcsUeCkarfEB1HRxZ/qXGoukyUGKGyhRjbsD9ih+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viavisolutions.com; dmarc=pass action=none
 header.from=viavisolutions.com; dkim=pass header.d=viavisolutions.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=viavisolutions.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6GbXiDGeHjGyoOy9l9enOgNyL7b7Q6K66yxYxof+GA=;
 b=kPTI1VMVrKx4A+pT8umXGm0melA0y4vRMxalFkoZ5J5bf5E+P0og/SvhZH7s4X+UYHLSU+76nVXcx2debIK0pJzG/X2d3NPrGF3iY2lWD6t6XNt2ugr5PwWrtZM8LZIjneRrWx1s0Hom6iCTj99w8lK8wolO1+xQQ672z0WgVDY=
Received: from BN9PR18MB4219.namprd18.prod.outlook.com (2603:10b6:408:118::21)
 by SA1PR18MB4711.namprd18.prod.outlook.com (2603:10b6:806:1da::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 14:00:21 +0000
Received: from BN9PR18MB4219.namprd18.prod.outlook.com
 ([fe80::1594:8bd0:f209:8f4d]) by BN9PR18MB4219.namprd18.prod.outlook.com
 ([fe80::1594:8bd0:f209:8f4d%3]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 14:00:20 +0000
From: Andrea Biardi <Andrea.Biardi@viavisolutions.com>
To: Theodore Ts'o <tytso@mit.edu>
CC: linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: ext4: failed to convert unwritten extents (6.12.31 regression)
Thread-Topic: ext4: failed to convert unwritten extents (6.12.31 regression)
Thread-Index: AQHcK6iCPuGMPLxpBkiY14A/LyLZg7SfJRwAgAASVvk=
Date: Mon, 22 Sep 2025 14:00:20 +0000
Message-ID:
 <BN9PR18MB4219710FC26F8A610F53AF569812A@BN9PR18MB4219.namprd18.prod.outlook.com>
References:
 <BN9PR18MB4219FBD6D79413965DDEFA6D9812A@BN9PR18MB4219.namprd18.prod.outlook.com>
 <20250922124128.GD481137@mit.edu>
In-Reply-To: <20250922124128.GD481137@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=viavisolutions.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4219:EE_|SA1PR18MB4711:EE_
x-ms-office365-filtering-correlation-id: b05cf639-f7bd-4910-7421-08ddf9e05e4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Hkw+pHER9oCoOGEtKbo3qIHizdj0l99W9jnrMH74TFukfNwTnINPKVnKI9?=
 =?iso-8859-1?Q?ljLtUOtMceCm4vp5e4+K1a4qB+wdImbGMpOGHNKlZMWLXXhpDGmAdQWx/D?=
 =?iso-8859-1?Q?jTNIWljqmPGDgoAlJ+ey9PgYCuFI6z+noOCoMwk2TsFuAlq9YQ29Qn1j8y?=
 =?iso-8859-1?Q?F9ado6wtrJN+w+TMLvci0pSIVoNkZZQaSDoBI/j9JvFrUkBUpnLFw5JnEn?=
 =?iso-8859-1?Q?cgrWLfqOpVCPkaoeWVbIwvOBp088rqW7U88IuuDAZWbMNHhv2+a+e0O+S3?=
 =?iso-8859-1?Q?2TrRfN38rqTEWTFu7u05s6yo7Tw0YpR6J88W9MVOB89szWb+OVRdXUh1lS?=
 =?iso-8859-1?Q?OBfvaBU2RwhsDQEaEDpZOJ2ZKlyKP5hD6MyvbHA7cqhcybIteyHOP9E3P8?=
 =?iso-8859-1?Q?5Cv9N06S3kOkL/BIQdrbGtROHjsRrZAWvNJDTRN4SNvItTpMjvGy1oZB3t?=
 =?iso-8859-1?Q?/3zL9ltOt3iKDB0ySh4UYkErjvLUVCB+lkX1tAXRcG2m9wrPpD6tNwGo7j?=
 =?iso-8859-1?Q?lXfY4OD+xNBXeRgjzko63GC5/a4VvqdcHDVmggrXJ+2JuO8IWmKMCV2u6h?=
 =?iso-8859-1?Q?GQpDwt2Lq1p2pzhigS/h3sPyUHp7mjnHQQkblPBVFrIZ2lqOJgv3Oqg2UX?=
 =?iso-8859-1?Q?XmJ5jUXQus7EDWpTcJdJoNw0PtjPfOUcEOLZlgc4+1rEYfZYKC7BgIhYqT?=
 =?iso-8859-1?Q?bFIG8BqyB/kyFV3WUF0lghd3A3H9HCxWSnvmY69ZIvdjhAhEt3nb7fnQPn?=
 =?iso-8859-1?Q?ewGWnJJJqnGp2hMHEPLtg0gHwsirEpLp+aArriWOhxGUnYjLHql8ZzrJne?=
 =?iso-8859-1?Q?yN8WS5IUB7/aQcsHsXw5qdwMBcwojMfRmUezB4gp1bue7vm5Of0OTuJpen?=
 =?iso-8859-1?Q?fgNxBRu6X/M0X0UsPHPPCfWU1J2bnPcamM2Uajk9vaYlNwBOW8d/EgX1zu?=
 =?iso-8859-1?Q?vzurLsgqOL5TrfC+aySt7dKbqx4oTgW82+NAVI9efeiA5MwU7Vrl3QiEoV?=
 =?iso-8859-1?Q?+D6IEhOF4Rd4DFwmF/UUm5XoMjihJXOJSTh6shuIP7FkUcBhvq6RCDnbDK?=
 =?iso-8859-1?Q?qH/uzUHEy7tmMYU4zfrDVosSNwmqfT2XPn7+m7CcImH83RrggkAVXqRe6n?=
 =?iso-8859-1?Q?eGZzs17RUmemvy8+SBC94B4w/LS1xVJSzaPyY6p5mpfEX0S54H8x0i2L1D?=
 =?iso-8859-1?Q?cHLmYmWkYPdaaN5lGhBNL1M46nw/3pwWhxRHDPsKE0XML1aC55+dIv6WKx?=
 =?iso-8859-1?Q?sTkpSzdmfcQ1M2p+yvHVbi3dqPmdKRcUBwMUIKOSy/8hR99bM0+OoIR4h/?=
 =?iso-8859-1?Q?qXbNjeoXhr5xJmuJwXrTtoSuEYkZdc/t2AsGiFTFnl7u6C6MBllbbfUPpR?=
 =?iso-8859-1?Q?BeJnNOy5PGJJEB9kglvkt3Ho9NgxytvxmFJH4buvg+Z3PdgQIx0G7mbVCQ?=
 =?iso-8859-1?Q?57xodhP2e57nrwp5Si7xy5HLItqnJUbFGnvT/cq/xVWgMWWRw/mL9U7eFG?=
 =?iso-8859-1?Q?3/pCGOkMgbTEvENwmf2jhrhFxYCpvOD0vgCmlD+pTyoCceGGtV9MGD6N7m?=
 =?iso-8859-1?Q?/6j/1sU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4219.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vJRcbOr2u8+balu3+qRZ27sblF480Wf2bK2XpFTTm9EzPu66bhDMJDqbd5?=
 =?iso-8859-1?Q?1OL/QGcFBLmyowSo1n9s75sIng/nCNRgBx8dR7K3XZU5TFQr3mY/uPZTer?=
 =?iso-8859-1?Q?Cy5Ma4aka39FaSHVGqkmNrhabPkC8mRaWf+e6bFu8dfcuVKmI+SiQlcvor?=
 =?iso-8859-1?Q?04DiAaPqpo4pXSA2Q7GVA3k9UwZVgaAnyYVWAvS2aKhiGlaBib6vix4lTa?=
 =?iso-8859-1?Q?pWLtTPNfTxo0q5h0+FnqdcqkiKO98eVT5cZLGyJQjFrBpdd9oq0MolIFCI?=
 =?iso-8859-1?Q?JwUPhMdC5cnhdLpkD04h923CJ0YXnsFD3FncBgwFBjC1QR38toISZKziIW?=
 =?iso-8859-1?Q?83Ohy+jvYxbXXXK4C8P/236tpc1M0yBp2QGLZgsuLl4UYVQgQXLCiP8mKu?=
 =?iso-8859-1?Q?NqiCP1nm8oGvtE5Hsjb7fia+LkvvFMOsXQqYNvYTbsD+Wd+dfw683OSV98?=
 =?iso-8859-1?Q?UUFqL8zMcJR1ey6YhfMC4IAI+AjPGpbr/Y44T0yv3oYOpU1+hhb0B9LWAR?=
 =?iso-8859-1?Q?PXg8vo6kIYKTORgpC9YVKpolNH0H/XvI2/2XVTrBrn2g46fbz5KK4E8OeU?=
 =?iso-8859-1?Q?cCi9I7G53NlUU4hZE9gGpYTVmbsdnW7skeKdd14ZaTa/stIJa9RmrbUyPZ?=
 =?iso-8859-1?Q?IgynfP4nxCvuCK4YJgK/ldM3K7DaWMEJhKFcfU3+cm+nJ/b2XDplxjtxrY?=
 =?iso-8859-1?Q?ZLV5cOwOhhZaoDEDfLZ3v/892qYnHH+H54Vdrq4vtFjAxfvAA8aMHowtp6?=
 =?iso-8859-1?Q?gNx2af2sbWhTSJ6tw+1cD/nwLdeIdF9cjeQoW7DtXEMyZEsbx/xhFC7Ae4?=
 =?iso-8859-1?Q?VSp/8zVTERhELrROBb6x1HkaRbNfiDWe9Q3fSKQT/ORYYzVAJOwanfAwQ6?=
 =?iso-8859-1?Q?xTPN2Uu1ZfhNpfNMMyetYxPqRK0eANggrAqKdhTbLwz91niNW52JEmvhho?=
 =?iso-8859-1?Q?c/AJUi9XU9fwoj9yq8TMYTwSS9579mHhA4v0d8WCo7ABGz2Y9FMKhFkBu0?=
 =?iso-8859-1?Q?X9wwHjqwMDayn8KxsKU9/SCi+UmwxpCvDzzV6w9MVxj3QctFfgSjpkVmIe?=
 =?iso-8859-1?Q?uzqCjYGnoofzPu/emgBapkBQ3YwDxHLPh2s9KIpyewDbH4NycrL3+q9Tgm?=
 =?iso-8859-1?Q?ydRSGzNv/FsKjQzeBiYSPeUiSN/4lkxUkChrUsfTZDSE1eTlMJZRbkYzzl?=
 =?iso-8859-1?Q?YedoM05w+mP6dHDVSR1iSGu5f0wXfucu8Vo3hloGbxSNeNC3rfhwxjJHaC?=
 =?iso-8859-1?Q?Z3CpCU/ZlAAuPDq+W87+yiP2Tcc+xODAV+O22ztBprZK0RwyzsBmCAe8Rk?=
 =?iso-8859-1?Q?aNkYvlEqmQRaXnAYoyj0ZZ3moqXvry3jOOdTTnoOek8kS+7tny+tpPWzZZ?=
 =?iso-8859-1?Q?PlJMQbtyEFfsxNjZroKJcxO+POY0+UHqqb/WFnVKZpWfHThgI5whRSCDEO?=
 =?iso-8859-1?Q?H5jfZcUHBVTwdNN5ahGmvl0kRkekJg+FnHOO4N4Bk1IZzWsr3CaDr2LDhC?=
 =?iso-8859-1?Q?S74fIESrhW7ey/aBGJpoHoCwCAnEKm9NSb9p7H69E7wz3/DkP7fDxzVLDq?=
 =?iso-8859-1?Q?6r8OkzjgWzJAFUMvbdJvWKK4ZGeixeSeRHY6zdr3mr85/W3BbV5DRHXUKa?=
 =?iso-8859-1?Q?Un5A4l3EqKKBWx60JnlrZ1tPTYLhFhcdSce5M9lbxZSNh4372y52I2IA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: viavisolutions.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4219.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05cf639-f7bd-4910-7421-08ddf9e05e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 14:00:20.6217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c44ec86f-d007-4b6c-8795-8ea75e4a6f9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BN7eZK6nRDobuQkAdwPBx64PSi+PF8RVsokUZ/qft/Th2J2nYU5bQwvoeh2/vQhfY4AqEgWkqaOY//iCKroQK4uXUC1UqdcjIrsnlBQ1H1JfF4gbNHUxNOcy6pqDv7Om
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4711

On 22-Sep-2025,  "Theodore Ts'o" <tytso@mit.edu> wrote:=0A=
=0A=
> > [=A0 174.903010] I/O error, dev vda, sector 167922 op 0x1:(WRITE) flags=
 0x0 phys_seg 2 prio class 0=0A=
> > [=A0 174.903023] I/O error, dev vda, sector 167938 op 0x1:(WRITE) flags=
 0x4000 phys_seg 254 prio class 0=0A=
> > [=A0 174.903027] I/O error, dev vda, sector 169970 op 0x1:(WRITE) flags=
 0x0 phys_seg 2 prio class 0=0A=
> > [=A0 174.903031] EXT4-fs warning (device vda1): ext4_end_bio:353: I/O e=
rror 10 writing to inode 16 starting block 84985)=0A=
>=0A=
> The failure is coming from the block device, which in your case, is=0A=
> the virtio device.=A0 The only causes for this are:=0A=
> 1)=A0 An underlying hardware failure=0A=
> 2)=A0 A bug in the block virtio device=0A=
> 3)=A0 A bug in the VMM (I assume qemu in your case).=0A=
=0A=
Thank you for the quick response!=0A=
=0A=
You do have a point there, the first reported problem is effectively a writ=
e failure on vda.=0A=
I tried with virtio-scsi, and can't reproduce the bug. I will try with a ne=
wer version of qemu first, and then look into virtio-blk.=0A=
=0A=
Cheers,=0A=
Andrea.=0A=

