Return-Path: <linux-ext4+bounces-3225-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C06692F35C
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2024 03:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA781C219EB
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2024 01:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CBD522F;
	Fri, 12 Jul 2024 01:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solidigm.com header.i=@solidigm.com header.b="SVNx4Qj/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1A4A33
	for <linux-ext4@vger.kernel.org>; Fri, 12 Jul 2024 01:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720747081; cv=fail; b=BTz9U3u+AIqgCgSPbNmL7lpgtyOS5HmkomEMmDyIpz60R7xy2ex0o6Dnuf//dmrFCAv1drBn51dEdqazuZ31X6fycgLP85i4Odt7lmzcjTzirJsBQOJAP1M02yjwcJU8Yv1LkM8mVLFykfYbtky+074Rn1YvWiyF7vsZ1mx/+Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720747081; c=relaxed/simple;
	bh=BwZ5TC7c6YrxXe/3Q4sBwP+YlO9bXzgoI3CoMKu82Ic=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E87nriL5fUTxbT1zQcbf8Wv002OyqanyKQtgfI8jrwi/J94XIUmvYvu+j5ITUQDP8AEOphFxr2NZOz7cds76nvR85+3yqG+5IHEg+VXQFc0THtvPkJI6/YIyfhkPB8/wTwmrgLDPS1ZZHL/HHjVQvCwow7zk9QPKw3lkHEFFd3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solidigm.com; spf=fail smtp.mailfrom=solidigm.com; dkim=pass (2048-bit key) header.d=solidigm.com header.i=@solidigm.com header.b=SVNx4Qj/; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solidigm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=solidigm.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbOJfAuYB1ZOKR16hdHlVLe87y9gmpiPpL3bDTRlZw766ultcYHjJdKZ+ipfmxQooncf4WxoNQ4z0NJ/w/TF60Rh5L890t54PXL6CR80v1+vwPa2ooYpQGcJpXqLlxzM32R9MU9KpqA0y0Sz9EIWKrSTxA+B73OlmwUa+qKWj1kRwdqeEO63w3M/Rax0km37n0D3WOMcNATg+5pr2uDkUZ4K6QrIMN+JYbRH9XEZslTub9vk6svRTTENEfd/DPdS9nmIbRP62Av7ou6W7ZdY1BOFthRmJMsSJ/9FHBVLZvdW30hT3vdnLz5IpPJqtprnPPy0MmfcLoi3hfml402ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjP6Qw1cw8FAjj2xbp8IFUSU+1F9cRpf4fy3bvcwE1A=;
 b=rnkqp5O1i1Oppc5oTXizKtVVu+tIeEwUq8Kb6ISuVv9UmQKbJlCl2ZHFnj8Koi3fLILHaHilCm1Ro8jzKl+XXoPZ6D0si0wdcrt8owFQbb3KqQcWLoXAcIg/TEKf8Qo7ogWdkeRa9bkqihXFO+IN9BHQLJz0y7YwxzHLx4my/emyTAVfjLaZDAhUT6g1hViJuH5WEgoLYDabL11LCP1n5yr9Bi6cTgJ6seCHUIXEtgrWcymVPDxYNr1hFoEfhKaUZk9Gs7axrzSMP7nCoazZZPQ83U4zhPH2B7byBPOTktbHBYEqmc51lyUop2UWEHhc7zV27NBoxrbWHZHwSqbOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solidigm.com; dmarc=pass action=none header.from=solidigm.com;
 dkim=pass header.d=solidigm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solidigm.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjP6Qw1cw8FAjj2xbp8IFUSU+1F9cRpf4fy3bvcwE1A=;
 b=SVNx4Qj/39clO6A0dehUMKkk2rKKCOThp8IcPGJRfvZLF8v7+U2s69Hag19AHEYdEsiDrXwkBkwy/a3dSKH7sOjF6nkkHXugfkzTEXghjacknKYV+CiybRA8m9axoS4oti4AjwqIu1F5JAm6rfWIJhk9Jnafloh+LByrsfTlZ6VMKCwkttRzdMUhxzajVBiyKpIjpQE9+6PZTleCHJxKvnhDbKymsMT0w/IVqIPOiNszuhU8A5B5CrowXeo3IakU3QiAOpjTKAwtA9ECGSW/p79/cJqVVhWc+DIhO92W2GRW145OnFQdCWgTW84K14zqXacWBN4GhbtuGDTVjIZ3Ug==
Received: from SJ0PR10MB5765.namprd10.prod.outlook.com (2603:10b6:a03:3ed::21)
 by DM4PR10MB7525.namprd10.prod.outlook.com (2603:10b6:8:188::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 01:17:56 +0000
Received: from SJ0PR10MB5765.namprd10.prod.outlook.com
 ([fe80::135f:857b:6366:ab68]) by SJ0PR10MB5765.namprd10.prod.outlook.com
 ([fe80::135f:857b:6366:ab68%6]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 01:17:56 +0000
From: Wayne Gao <Wayne.Gao1@solidigm.com>
To: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: RE: ask help to shed light on ext4 high CPU usage in kworker when
 handling bufferIO while xfs is fine
Thread-Topic: ask help to shed light on ext4 high CPU usage in kworker when
 handling bufferIO while xfs is fine
Thread-Index: AdrT88wmFCAzCoV6T1GZKUSFZXS0DAAA4QyQAABDXHAAADWq8A==
Date: Fri, 12 Jul 2024 01:17:56 +0000
Message-ID:
 <SJ0PR10MB57658B01BF03025D0ED44CE6B9A62@SJ0PR10MB5765.namprd10.prod.outlook.com>
References:
 <SJ0PR10MB576573CCDF9A708B6BF4478FB9A62@SJ0PR10MB5765.namprd10.prod.outlook.com>
 <SJ0PR10MB576507AB57222530E2528724B9A62@SJ0PR10MB5765.namprd10.prod.outlook.com>
 <SJ0PR10MB576503826A4363D87C76A439B9A62@SJ0PR10MB5765.namprd10.prod.outlook.com>
In-Reply-To:
 <SJ0PR10MB576503826A4363D87C76A439B9A62@SJ0PR10MB5765.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solidigm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB5765:EE_|DM4PR10MB7525:EE_
x-ms-office365-filtering-correlation-id: 24befea1-3f08-49ea-24a2-08dca2107622
x-etr-sdm: Outbound Disclaimer
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?TWSeUHOPLHCuHWzAM4jnDdoqyxgqPPD5my7GGx9EnFHF6ReBzUIiwpw4SX?=
 =?iso-8859-1?Q?xFnWiP82gpLHKt4OkdPZVj+588YJL3L3IeroIdMHVTmVfZQFFtcS6/Efcu?=
 =?iso-8859-1?Q?F0Sop6wtNFFF73u30ZzmCkT0h2ALUKquvIl8WQooyzWb76d9fI2PnlVjqu?=
 =?iso-8859-1?Q?BZC5/tdCjNl4g7FMaWxzs36mmurD4YY4XMt4fqvxODE29MQHLxlFCO83WP?=
 =?iso-8859-1?Q?6CGR+H3DmD71dct2i5Eef5NKuqF92jUqDFgDj8Ls3S6R0m97zd2dZa8ZHB?=
 =?iso-8859-1?Q?ZWLwm3dL02+ag7R3oGwZtKLDgotglo1I4l8uh4Cvv4/Lg4Blx10ung1AMr?=
 =?iso-8859-1?Q?CJQUq1cAQCW30gvHXQUQHljuAQvWo27iwYIW6VJHkc7UQtpQoORnS1zVMw?=
 =?iso-8859-1?Q?/RkqdPQLPIpfxJ/IbF1NisLI383Sn/rtCIJaLKHtusIO/QD85aeBAtsWTp?=
 =?iso-8859-1?Q?CmoFXOp9+AoKtS4aPiyeD+iF5YT5cKKPnn6bG7j/EmRJ+Xsn6r+oHJnpLM?=
 =?iso-8859-1?Q?iSvJT/eVw4mak+Ic+8f282ZrqUygM3o2aqJZzCEGRZwSqMjDM41aj5qHct?=
 =?iso-8859-1?Q?Xh1JsquJ3/1LueG0COC82DD3DWGB02T7KgYepK2M+X/sUHeBCyBOX2PKxr?=
 =?iso-8859-1?Q?afyjfcT97KOQPTIGbbNkr1/AmHTTS8NnErR++FAF1Uac71NDAV6kon0GF5?=
 =?iso-8859-1?Q?lrmgQhOG/gwMYbSIwvegHJAoduLJF1QCywzB4tnAmRE1n9+dFdFORlEM/L?=
 =?iso-8859-1?Q?ehnlHKBfZrhgrMM/sNboRN8XOCVFbujTbe6A3y8qEjr//lGzMAyf0EEwtU?=
 =?iso-8859-1?Q?HPFSi0tpDS75IaPiC/FyBdMBilzPRmEtmKm8/OE5WIaiOaGwomuF/Dtadh?=
 =?iso-8859-1?Q?Yb/0RDd27Td5mLIwcxb2XJfz1ZBlmAOgSGGo0hx5T3oRQFyU58DHMIg7jq?=
 =?iso-8859-1?Q?OAIcihv9qpnZ3SUmiz7ReEm0/OhTqOFdaPSqisU0GFiCZBMVhAtS16BFNQ?=
 =?iso-8859-1?Q?polu9tnShTkUj8I/l4vj6KWzgyMnc/j/4Mjc6sAVw84g8ya0hLGdu9S/Ph?=
 =?iso-8859-1?Q?TjLsmLXOpc+++1gisnJnsWAxt6bnWxmRlfGsW4fukBnmAvz0L/5vHZtyh8?=
 =?iso-8859-1?Q?o1GpSN9GaaJBMWq0Zc8tsiz3X84aTOLu9lIZb0Xx6mJGCUt5QCNZzK+Q/y?=
 =?iso-8859-1?Q?sGn0UdXuzs4mBngxBB7RxL991p/01AjG5nP18+oHBTy3gG6SALQycW6XrU?=
 =?iso-8859-1?Q?H3C3YsBF7Kxcs+AymxaE1Z/kQQOJke8z6dqS5zM/elIW306938d89Qqyez?=
 =?iso-8859-1?Q?FYiEuB03v++WgmXh1g2ijUPuacjht25R7uUpht5coxWedpLg8XpE3900FL?=
 =?iso-8859-1?Q?epqwlGkIjdSd/0XiDuqbquC1yJewzPnA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5765.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sTrNu+Bqt+LCql908SdZWvNOjTtAskW6GsZ0o4HfCDdOThtwVma/dWTvzj?=
 =?iso-8859-1?Q?OEreHx1ToOny06D2bdDlfExgKTKW5/GyldV5g83LMjTQVJFVBYMbRu6dUK?=
 =?iso-8859-1?Q?4u5i39ymLwbgXyWsW1lP85U63iCZrBClEL8ygDD5G1K0+zFf6aNFic9HZQ?=
 =?iso-8859-1?Q?lcuRyVstWSgRIkeXEJxlMg+M8pIp18T32XTq1XgglCPhOMt6LoFVgTC2ax?=
 =?iso-8859-1?Q?cemOoa8I7nI/q6GvNhNRNGxYrYXGeR+O3uHrNPnqfSz5eAtYz4GGYw9pzk?=
 =?iso-8859-1?Q?GcGh2+YF9o4DorJCXLeTg+H7GPgi98gjZZs1hDIDGTCR/sRmSODkubo6iA?=
 =?iso-8859-1?Q?a6dDJE5AnwiiYLvG7TFMASOzGmWrI7ym73/6RbJ0rukHvBr2RXFoZviUcN?=
 =?iso-8859-1?Q?FQhqrkEuRtKBSXfavrikXoMVZvUU5cJxMepklSYdMk+cMZTPu1ReKB1PsM?=
 =?iso-8859-1?Q?I7GBA1u3DiVJdQ5aGkApHj/tn4a2ONimKModQnIqE1m+Ma390XBAYOr/3r?=
 =?iso-8859-1?Q?zmYJdOXWDRiqe8z3jHnWLcaS0PnmksE94y/0Vk0h19J4a6dqvwvqsVb0pS?=
 =?iso-8859-1?Q?iwfLlRE1hbAItGJFy+3tzIejfJ2ufrKamgDaYT2XpqsBk8jsfhWBUW1Elh?=
 =?iso-8859-1?Q?5qnuww1cZ49keUgwmzutmfWnhyKw2ykbscwY3l1YoD7kLjonu36/sYYzv4?=
 =?iso-8859-1?Q?YIjm5XDnbVEcEozBeRcLKQ2upmuvlXnQnuOZcq/K1Ob7k3+gjPM4KLGWCd?=
 =?iso-8859-1?Q?XKs6viTqBbOBDf5LlN2NEztpGbVsDhCoImtzl2sCvqvdWVscmE3YA4c8Bg?=
 =?iso-8859-1?Q?bOL5+c8mBj2O4RpLQhrgdN0TOJsifn5m8gu1t2jE7Lki/EhLcy3mwWvnqQ?=
 =?iso-8859-1?Q?J3z1Jo3kjW+Vu4AQZKQvdp1TuT4n5P0Sa3eLjnwXcFwIKiEqJMApDCuB9A?=
 =?iso-8859-1?Q?X5UoBFUGkJr3Q3e99H3xDx+BlArpCKow0EFQkl7b4voO1M93zCY7Czn0Gb?=
 =?iso-8859-1?Q?4hVhn8wHAw85BzWqVjUvu2A7RPo96yEI/REIuwrY/JTBYOG+Kid2wYS/RQ?=
 =?iso-8859-1?Q?deP26tMBHfB9VOwenfsiJJd9gXJPlwNYLnBU+83bb9GtbSZ58yoCeE6i96?=
 =?iso-8859-1?Q?rZdhUc8STgNGIvBgpYI/pHRJudxW4KaNCfkO3lCbuKogg79SKcJjq3XB/1?=
 =?iso-8859-1?Q?5ISLpZtXMpwuj4/nYUx/7il/CTY8LMRAlWjAChCVt9nDnFmI0aSizYFneC?=
 =?iso-8859-1?Q?R4LqbjTuC/BnXDh7HJl/DXeTwUyy/BsOjMcVq+rphw5fvBjYOS0zDPYYtC?=
 =?iso-8859-1?Q?f0frA+YP9wQuSiwAxdFrinX1rjDekZR1gvBMuz7r6dV4b74ZyXG/wge7FY?=
 =?iso-8859-1?Q?LTnaS+XBl7jbAT+sEG8alY/iOvwLN6GHraZii6dxRqIUBkI+ghSEBV3zFa?=
 =?iso-8859-1?Q?WQHuz3T4OFvkGk5Bnxey8fJ7txFYsUSWqPtyygzT+iyRmqsXultO3Pcf6Y?=
 =?iso-8859-1?Q?bzBDjfsh7xeM1hom9Kxlyfo/zvNNoUuJcrxfy3KvrPn7EpWsaVGrgO4Xmq?=
 =?iso-8859-1?Q?t7mGbY53UCjdkutdCfeRgBS9LuxMWzxJ9xaU0mBaWfeD0f/U3kSmy4T7rK?=
 =?iso-8859-1?Q?vjzU4RV/tZAth93LrDOAdsTeir4/NAj2AMuzwOiiVZJh2c+bVJOo23z2dI?=
 =?iso-8859-1?Q?URm+BMVd5wJJ66onQvM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solidigm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5765.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24befea1-3f08-49ea-24a2-08dca2107622
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 01:17:56.4761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4bb44aac-867a-4be0-aa34-30794e8470dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIP7+QUM/ueB7EL9QIKh2DdhZx4GpVUWUUDJmSrgQve4SuwR9nj7iHbpcpGyGIHZo9GE4hlnwz9kLCOlKpC1RevWcoQwr1mtc46siso1sZI/rWXBwiTa51a5npTfg0NJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7525


Hello dear Linux FS developer,

I have one test result would like to ask the root cause

In the 2024 June, Linux kernel file system and Memory management summit, th=
ere is one interesting topic discussed. It basically mentioned that Linux k=
ernel bound on 7GB/s when write using buffered IO. The root cause is that t=
here is only one kworker thread to get the buffer IO job done. Since high B=
W gen5 NVMe will be adopted more and more. We did some experiment following=
 the LWN discussion thread. https://lwn.net/Articles/976856/

Test Configuration
Kernel is Linux salab-bncbeta02 6.8.5-301.fc40.x86_64 #1 SMP PREEMPT_DYNAMI=
C Thu Apr 11 20:00:10 UTC 2024 x86_64 GNU/Linux
CPU is intel gen5 CPU
Fio is 3.37 above and latest


Test Result summary:
Test       File system          Buffer IO             File write BW
1             XFS                        True                      14.6 GB/=
s
2             XFS                        False                     14.3 GB/=
s
3             Ext4                      True                      5383 MB/s
4             Ext4                      False                     14.5 GB/s

We can see with latest intel BNC gen5 platform and gen5 NVMe raid0 and kern=
el 6.8, we can only see the 7GB/s one kworker bound problem with Ext4 file =
system. XFS file system looks well, kworker CPU usage is only 20%. Please c=
heck Figure 1 and Figure 2

Figure 1. Ext4 shows 100% CPU on flush kworker thread

Figure 2. XFS shows 20% CPU on flush kworker thread

Enflame chart analysis.
Figure 3 depicts XFS most hot spot is on iomap_do_writepage and underlying =
implemented the latest Linux kernel memory framework folio that is better m=
emory multipage framework. Figure 4 depicts Ext4 is truly CPU bound on the =
kwoker finally call into __folio_start_writeback. This is highly possible t=
hat XFS is 1st File system to implement iomap and folio, maybe ext4 still n=
eed some improvement.
But LWN article conclusion is right, one file system per volume so far have=
 only one kworker thread even with kernel 6.8. different file system have d=
ifferent design, some leverage this one kworker more efficiently to get hig=
her BW, others does not. But for high end NVMe like gen5 with raid0, raid5,=
 direct IO will make more sense, you can get better BW than buffer IO and a=
lso save the DRAM for other cloud native tasks.

Figure 3. XFS hot spot on iomap_do_writepage

Figure 4. ext4 flush worker is 100% hotspot kswapd is relative high too



Wayne Gao
Principle Storage Solution Architect
wechat: 13636331364
solidigm.com



CONFIDENTIALITY NOTICE: This email and any files attached may contain confi=
dential information and may be restricted from disclosure by corporate conf=
identiality guidelines, or applicable state and federal law. It is intended=
 solely for the use of the person or entity to whom the email was addressed=
. If you are not the intended recipient of this message, be advised that an=
y dissemination, distribution, or use of the contents of this message is st=
rictly prohibited. Please delete this email from your system if you are not=
 the intended recipient.

