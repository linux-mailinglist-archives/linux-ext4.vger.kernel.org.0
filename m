Return-Path: <linux-ext4+bounces-10333-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69841B90507
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 13:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431791898EE6
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 11:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338D9302743;
	Mon, 22 Sep 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=viavisolutions.com header.i=@viavisolutions.com header.b="sFzefzow"
X-Original-To: linux-ext4@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020073.outbound.protection.outlook.com [52.101.201.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C262FBDF5
	for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539480; cv=fail; b=bZvxBE/IrjzabtpZU4VgCeBEO48ZPh5osvp5vzzEmEPzTIKzOhkbgrAHKJOSXHk5Ts7/lDOwIssjlX+b+NbSygfkpwbPupi0CBnBvLOzEWiwswxejo1g8ty97wPBlYOrmktRDgzG7ArLbT6hA3NL932zPcGHR2w9WWF0b9rNrnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539480; c=relaxed/simple;
	bh=fm/VrkvxJE72KMhwhHwLyjqX/1s8YOWs2lw6WWJzDUw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KpeAGyR/LoGfNSsMwr0vSfMyzVxDiv1XYQ8RJTMAH3NuWl9+SzOLOvGHpgBVkjbf/UgiTTicAv5QrVEk1Cf7YM0Hwb9GrwgxA8LDxKBg6ukqAOVjvDB5fAdmo6/VGDUZgM4P/ON6lNOJdcqy8WWSem8fFKH5dm4LPdVo9l58HC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=viavisolutions.com; spf=pass smtp.mailfrom=viavisolutions.com; dkim=pass (1024-bit key) header.d=viavisolutions.com header.i=@viavisolutions.com header.b=sFzefzow; arc=fail smtp.client-ip=52.101.201.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=viavisolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=viavisolutions.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFXFHwWQpRkcb2Mgvji7vRqUAN7wjVEO9w2rsou03p4anK8e3S9Ib1O5NLfN+6pFe1ZJVDQAiiF98tvc7CIlMf8KpAb2BUVAz0oDfcSLMED1EeXkCUiIwd3B+6127p1x2i9cQ+bKkZmS/p253pIsKdO3/yLj55RngUAplzHfZ8sNqg79pF8QJzl0C4WYouswMDRmZ5GOezOOaVUkaYxAq/8sWD+Vs+HF7MlzgrMV6wOgxV5tnoHBz56MhpJtCb7ZqtoRrkvfd+LlRu65YR+uFfjJlxfQTQ2UjvDSlRo59M17CSwzrYT3WevWrhjkB+t0ANPUjU9G0N5K42OHKHD8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fm/VrkvxJE72KMhwhHwLyjqX/1s8YOWs2lw6WWJzDUw=;
 b=cBXwAbs7mUwHISIJ89Laow+QBOFPRKS0wfOXZJQUNwlGA5MIEZGNbyFybhAcAAFqkYDBoaFY6UHtNqYEVy1+M1Tsxsib7eNpRlf1dheJb1dYLSQIrpCgJrmZdtVHsqBn4Loqds8CKTdsMRcl+BoIIJ+3u5kLCWmpdhnvmNwdm8iAaqUt773DKmnbIyXz7pLWTD2egQBypoAQfUe9593Z3XOFjPRwa8AIXTg5YHwti7W0fA95EkdsN1A46vAe4S/ZNvNmugnyFHzp4hYVoy3VMCiOv/4qwozP728+trrkZhUXrH27uXGGYZzyBPrnXoVH53x+pBMW0vnZJUitEucleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viavisolutions.com; dmarc=pass action=none
 header.from=viavisolutions.com; dkim=pass header.d=viavisolutions.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=viavisolutions.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fm/VrkvxJE72KMhwhHwLyjqX/1s8YOWs2lw6WWJzDUw=;
 b=sFzefzowWZDD/77Bm/N6xcD4qW5+bq3dyTPMKXBw7KOvI57h52+CPfBUzTCB1YGBU3YxYgMHbTwvCz7yYA8z3pGMktFeWymNL6EVwf085gMVcNC0Nl6RwF0/F+FPPh0bJXnm4danVQJY9f5bb0DEOh//cEGdH8eozuXm04G6Lbo=
Received: from BN9PR18MB4219.namprd18.prod.outlook.com (2603:10b6:408:118::21)
 by LV8PR18MB5605.namprd18.prod.outlook.com (2603:10b6:408:18f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 11:11:15 +0000
Received: from BN9PR18MB4219.namprd18.prod.outlook.com
 ([fe80::1594:8bd0:f209:8f4d]) by BN9PR18MB4219.namprd18.prod.outlook.com
 ([fe80::1594:8bd0:f209:8f4d%3]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 11:11:15 +0000
From: Andrea Biardi <Andrea.Biardi@viavisolutions.com>
To: linux-ext4 <linux-ext4@vger.kernel.org>
Subject: ext4: failed to convert unwritten extents (6.12.31 regression)
Thread-Topic: ext4: failed to convert unwritten extents (6.12.31 regression)
Thread-Index: AQHcK6iCPuGMPLxpBkiY14A/LyLZgw==
Date: Mon, 22 Sep 2025 11:11:15 +0000
Message-ID:
 <BN9PR18MB4219FBD6D79413965DDEFA6D9812A@BN9PR18MB4219.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=viavisolutions.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4219:EE_|LV8PR18MB5605:EE_
x-ms-office365-filtering-correlation-id: 76b55cb8-8beb-448d-12ea-08ddf9c8bf40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?nBDDoeeudSX62waL3KPFZm5do5bpUiIXVGK2akZOcwjgjuxvlunYxPEwnd?=
 =?iso-8859-1?Q?wVhIHE2mVLptsU9sNUWCsMpDI6fWjNpTcpxSmCzdIbnqRhfkLZU/acVk2d?=
 =?iso-8859-1?Q?wvuQcwGawqNvEdF80ccI3c86CLsXicpdPjDij0eNqV5469dD/hyj891VBd?=
 =?iso-8859-1?Q?21yzG1Ebf4KSkGTD8tm687lb4QMICqWOQqKdezyQW2ATPU90ErfSJtu43f?=
 =?iso-8859-1?Q?t8nh1Z2UJnPyGgA0U9oGPGUihyBaw+Xa1k9XS7kFEYXde+77U9s6kzPNrz?=
 =?iso-8859-1?Q?FkaMf/jHxiUbB89KieQAd56KEHZuKiq0FC7uPb63u6/A8ZyuXJ98G4Lrug?=
 =?iso-8859-1?Q?qn3k1xTGvwuCORIND6JMQJHNne6pqYb6YTUAOP6BVjT0nJFatlHByFalm7?=
 =?iso-8859-1?Q?pmMCiaJeK/EE7mIYQ7iqyH8m27IMVua0cgDxt87AriqMkVkKHYelLG5oBK?=
 =?iso-8859-1?Q?GROxWvXI1566HyUgYJI3345j2jdGoQl1GJ893UwNg7t+FtnRgbnOgQ5hAR?=
 =?iso-8859-1?Q?yk6v+sEDbwxMjaWNgTM1FxSR67R9/+IOII6aw08x437iPSw8FKPc5Uqf8y?=
 =?iso-8859-1?Q?BWI74q2a5wYDyoDR/aMT2Fcr0km21xlGsFQa7x4kqKqCz1rlOAeQDX1a40?=
 =?iso-8859-1?Q?Z3vEjV9rIKanOevFvFqe8c3utj8xcBke0wASy5L/yYPdtjN+cCuIodDu1M?=
 =?iso-8859-1?Q?hkwjAQlGOCf/ANT+vEh0ugPzdwknlLKpbythKTkYJWSEhLxFJq6hIyWJVM?=
 =?iso-8859-1?Q?6Gozeadt6KGm4t1kdVfqlCyJ7qZGKo9/7IEzkvz/rrG0I6cmUr/IKrMvyw?=
 =?iso-8859-1?Q?sVjvpkJqtDvgZsde/uqjwmDrp1/Ow+17HdGZ2L2zLQ4QEy/cucLWxNb1V9?=
 =?iso-8859-1?Q?zPjHoN7wMqjfdn5nmi4puQUDCuNn0r53c/lAurvH10oVKmauCLm55z+Uud?=
 =?iso-8859-1?Q?BIyWeKqEmdDlNXPhE6tpg6/WBEewp2ZMeLAGNSlj8bmja5uADEW+/FiIjQ?=
 =?iso-8859-1?Q?7Xe3VBVELe8kWiw0bm7qLuCN8ymJSgBC7hAFN+w2S/2HHComIFjF+s/aqd?=
 =?iso-8859-1?Q?fMs5v3vOslZDPOF750M1Q2Zza9J+irAvw0SIpra9TXM2zR3zmVC+IgCXHx?=
 =?iso-8859-1?Q?8nO06AfaIg7hEZ0/6WEEsenshOSlRDDp9uRJfryIE6WFRVZyKDwSftB9wF?=
 =?iso-8859-1?Q?N1tdXrTI9b8L6jNIeM0tWPDQCCJVnX2v8b9U8p4xhuJfdYWb5kMSiw0E0f?=
 =?iso-8859-1?Q?/aM3arpOdLN7ziZZ/GO1Ys1OPB307zCgLtog7ImQmq+0xwaRGgRUNMu+p7?=
 =?iso-8859-1?Q?vPtz1gQnGl4W6JTSoN4e3JszOTXao418L1oXb51OZeBjEBn3GLQPf0lJBz?=
 =?iso-8859-1?Q?vCOHWTBulk3sl1Nkpw7+uPNRlkK+1yhLwbyTdL9hxenNv/6mM7Rmco6mH8?=
 =?iso-8859-1?Q?3ive0EpLaF1YdG+Wb5RrlDHZKE/FOF4NwVZ4h8DCDdZLc6AB6SF4ZG6yCb?=
 =?iso-8859-1?Q?zx5pLTzXtxq0iEYHGOoOy6wZYU3fuuy6jZGbW5MMipaQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4219.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LaxoeSr7vsWrR7jZmRkrx9zBVWCoGul0gMLmfYqE8RRKDdcEryAB2R/nEd?=
 =?iso-8859-1?Q?jaGQ57NPeSzfemiNedou6rpNra0wgJ7AgU7RJu4hga11qkJPH+5B2fmCS2?=
 =?iso-8859-1?Q?Ke2dQpe6QS08Bmw51AXSo9YFUfYUHksC/Oc0sF9by332v6U6run4EM2bwX?=
 =?iso-8859-1?Q?QqWAqzZpG+gSApRBRWdwpl1JL3In6/6YTBsbrcdg/syyQrqvriEDb5Dru+?=
 =?iso-8859-1?Q?Hwsqw+Qo/lbj5F+CHq3Jx7FLgZCm+ZIXKTWPz0SwX5TBEiZSF9PdCt1jAf?=
 =?iso-8859-1?Q?NS/UArg21ji5vsK7B95cTFuA0Bjw8ibYH1lVavCWNj02gd3WIt2jtd7m9h?=
 =?iso-8859-1?Q?d9cVyoKIk7oLw0snAmzdGwByYJVJCarpn/wrv5y2N6+HfulOD9bDKQbaZ4?=
 =?iso-8859-1?Q?GvZuKR3IRyMmnprbRk5H+VXB6HTl93Hx2DrIG4ADzLX8EaXm0dmSdtQqqP?=
 =?iso-8859-1?Q?yVf48MeIoLxroag2/6koFdxpFiJgcNXOeTe6ZsSCMP7/kkhXPW2ql2XGBA?=
 =?iso-8859-1?Q?4BqOBg0zTdFXCFUPPIcgR/QdQ1GlhRdcntXYVW2PxYj3EcrVPgwmQuq4vR?=
 =?iso-8859-1?Q?a/g8NWooZ84dMv6A5Q7BAdz3RNebfLZ+5R5GWbQhdBuLo4h37pt2WrjgOh?=
 =?iso-8859-1?Q?9F+qn9ocyE7riNa6UGPc5U7ktdckXMdbTz5MRLGZU7hC50sjUn1a3/YSNQ?=
 =?iso-8859-1?Q?fH8I1h6nAgrwI7WVJbIoMuRg55KPDgMe39kWGOxbup4NKgDjHpKSUypnIl?=
 =?iso-8859-1?Q?M6IQb+wQeXN/1IbA0UTqqLXCYakoj42miG+RpFFY2vCkTJn/kZlElqds+y?=
 =?iso-8859-1?Q?nIvxHN9AUTV8NFaEbJWC7/dIySxrelnUtPZ5HLVJ1hfxfQJjpxyiT60zkw?=
 =?iso-8859-1?Q?ymNBtXKo8J2LFPZs3xP3FFce2AqCxA9FGzEYHFiBqCvWPuyHo45crvKvYj?=
 =?iso-8859-1?Q?AjrWI4Zh/Bk52/zgWnfiSqM9v2IHpXc0DCmvxnB2TILIGDGlyG15xmkUal?=
 =?iso-8859-1?Q?QY9eY2DrXjKEjYOMSoHjCQv0tHEhPDvEPaHRW4aZ9a+snzLlpEzFD/ZcEe?=
 =?iso-8859-1?Q?vQLj6CTc1L9uOpPkv62NW+Eik/UIEiinV13GJfI/+OUjoN1zL2kNUE1Q6g?=
 =?iso-8859-1?Q?CcKzg9eOSnxDcf2A82jsCsKT9Ddk/TNPKFMmsxBkOvSLF3MDOdWu1vp+lk?=
 =?iso-8859-1?Q?wWygz0q5AJ90F+VYHi5D8waRgnSqyoEMdNgGDeG8WKZnSXjcPnDnRtj7mM?=
 =?iso-8859-1?Q?wRI2PodrJM51F7HsNgs/HncMhXUUsxAiVQpwIJHm06veMuKN246m5jJOB5?=
 =?iso-8859-1?Q?6+S0TK1leiYs1px4t8kioLEZoWXeaYLBahcLyrNbmrVeVDk2uvnzzhpxLN?=
 =?iso-8859-1?Q?xd8NoL+C0Tefs107mmDBehmVYn1xLtQ+hwIA8vv5PAdRsVe2Lh8TTttFMI?=
 =?iso-8859-1?Q?jod3RpIb03ymt56OHPEhM6YaSXTLUY6HDHnX1tR0aOvv1Vj3nWL1zgZ900?=
 =?iso-8859-1?Q?evsVwiUC76bmL1ZHuyPMdEZG08YRLT1cMGO22iN/ZyD82FDOkNOi4ENHq8?=
 =?iso-8859-1?Q?R49tX2QS+/qIM5H68n3ZK57BcY3leHPxduyP5qU62Ve3gna16xsL/gZYj5?=
 =?iso-8859-1?Q?6DD3MuyNGQIxbGq5Gn+CxcX2wKIaan0uL8TDRota1BuH1ZuglzRvqqQQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b55cb8-8beb-448d-12ea-08ddf9c8bf40
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 11:11:15.3560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c44ec86f-d007-4b6c-8795-8ea75e4a6f9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qYvOgBcmIHiMq5zc0JhXBSnbCHo0hMEqs6omn66UgUq/cWBAsSJAqTY3TDBh10oD/9u0n69NyruCgui8bqu0iz8xaJNK/dCuJeb7PzSxrJeFt741qJrtAeVVFpvYIQY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5605

Hi All,=0A=
=0A=
The CI process of a product that I'm working on involves the creation of a =
temporary KVM VM which boots a cdrom image containing a custom kernel + bus=
ybox in order to flash a filesystem image to /dev/vda, then shuts it down a=
nd exports the VM (that's my "deliverable" for the next stage).=0A=
=0A=
For this custom kernel, I have used 6.6.x for a long time; after upgrading =
to 6.12, I started observing filesystem corruption in the deliverable image=
 and these messages in dmesg (these are produced by the imaging kernel duri=
ng flashing):=0A=
=0A=
[ =A0 10.188754] EXT4-fs (vda2): mounted filesystem 42e94213-17de-4a91-9c58=
-c39852446bf2 r/w with ordered data mode. Quota mode: none.=0A=
[ =A0 11.612142] EXT4-fs (vda1): mounted filesystem e32da11b-d5d4-4621-a7d4=
-8b9bc5034c83 r/w with ordered data mode. Quota mode: none.=0A=
[ =A0174.903010] I/O error, dev vda, sector 167922 op 0x1:(WRITE) flags 0x0=
 phys_seg 2 prio class 0=0A=
[ =A0174.903023] I/O error, dev vda, sector 167938 op 0x1:(WRITE) flags 0x4=
000 phys_seg 254 prio class 0=0A=
[ =A0174.903027] I/O error, dev vda, sector 169970 op 0x1:(WRITE) flags 0x0=
 phys_seg 2 prio class 0=0A=
[ =A0174.903031] EXT4-fs warning (device vda1): ext4_end_bio:353: I/O error=
 10 writing to inode 16 starting block 84985)=0A=
[ =A0174.903106] I/O error, dev vda, sector 169986 op 0x1:(WRITE) flags 0x4=
000 phys_seg 254 prio class 0=0A=
[ =A0174.903172] I/O error, dev vda, sector 172018 op 0x1:(WRITE) flags 0x0=
 phys_seg 2 prio class 0=0A=
[ =A0174.903176] EXT4-fs warning (device vda1): ext4_end_bio:353: I/O error=
 10 writing to inode 16 starting block 86009)=0A=
[ =A0174.903239] I/O error, dev vda, sector 172034 op 0x1:(WRITE) flags 0x4=
000 phys_seg 254 prio class 0=0A=
[ =A0174.903297] I/O error, dev vda, sector 174066 op 0x1:(WRITE) flags 0x0=
 phys_seg 2 prio class 0=0A=
[ =A0174.903300] EXT4-fs warning (device vda1): ext4_end_bio:353: I/O error=
 10 writing to inode 16 starting block 87033)=0A=
[ =A0174.903371] I/O error, dev vda, sector 174082 op 0x1:(WRITE) flags 0x4=
000 phys_seg 254 prio class 0=0A=
[ =A0174.903401] EXT4-fs (vda1): failed to convert unwritten extents to wri=
tten extents -- potential data loss! =A0(inode 16, error -5)=0A=
[ =A0174.906697] Buffer I/O error on device vda1, logical block 84993=0A=
[ =A0174.906708] Buffer I/O error on device vda1, logical block 84994=0A=
[ =A0174.906710] Buffer I/O error on device vda1, logical block 84995=0A=
[ =A0174.906712] Buffer I/O error on device vda1, logical block 84996=0A=
[ =A0174.906716] Buffer I/O error on device vda1, logical block 84997=0A=
[ =A0174.906718] Buffer I/O error on device vda1, logical block 84998=0A=
[ =A0174.906719] Buffer I/O error on device vda1, logical block 84999=0A=
[ =A0174.906721] Buffer I/O error on device vda1, logical block 85000=0A=
[ =A0174.906723] Buffer I/O error on device vda1, logical block 85001=0A=
[ =A0174.906724] Buffer I/O error on device vda1, logical block 85002=0A=
[ =A0174.928451] EXT4-fs warning (device vda1): ext4_end_bio:353: I/O error=
 10 writing to inode 16 starting block 83961)=0A=
[ =A0174.928787] EXT4-fs (vda1): failed to convert unwritten extents to wri=
tten extents -- potential data loss! =A0(inode 16, error -5)=0A=
[ =A0175.019677] EXT4-fs warning (device vda1): ext4_end_bio:353: I/O error=
 10 writing to inode 16 starting block 88169)=0A=
[ =A0175.019752] EXT4-fs (vda1): failed to convert unwritten extents to wri=
tten extents -- potential data loss! =A0(inode 16, error -5)=0A=
[ =A0183.121276] EXT4-fs (vda1): unmounting filesystem e32da11b-d5d4-4621-a=
7d4-8b9bc5034c83.=0A=
[ =A0183.711275] EXT4-fs (vda2): unmounting filesystem 42e94213-17de-4a91-9=
c58-c39852446bf2.=0A=
=0A=
The relevant sequence of events inside the imaging VM is:=0A=
1) sfdisk /dev/vda (creates: vda1 for /boot, vda2 for the root filesystem)=
=0A=
2) mke2fs -t ext4 on both=0A=
3) mount at /mnt and /mnt/boot and rsync the source image (~100k files)=0A=
4) chroot to make a couple modifications, install grub and rebuild the init=
rd=0A=
5) shutdown=0A=
=0A=
The error I'm now seeing always occurs as a result of rebuilding the initrd=
 (although I'm not sure why, certainly the rsync sees a lot more I/O over t=
he 3 preceding minutes). As the sole purpose of this VM is to flash a files=
ystem image, nothing else is happening in the background.=0A=
=0A=
I've done a rough bisection based on kernel releases and this problem occur=
s on 6.12.31 (212 out of 365 runs) and later, including 6.16.7 (6.12.30 is =
fine, just as 6.6.106 was).=0A=
=0A=
Looking at the changelog for 6.12.31, commit 785ac699113320e3c3968754ca0c78=
d40a013107 "ext4: do not convert the unwritten extents if data writeback fa=
ils" stands out.=0A=
=0A=
The configuration of the custom kernel used in the VM is fairly generic -- =
mostly a default x86_64 config with stuff that I don't need turned off: IPv=
6, sound, wireless, a few other bits.=0A=
=0A=
I can rule out issues with the underlying hardware (tried on 3 different KV=
M hosts and nothing in host's dmesg either).=0A=
=0A=
Also, I have a similar procedure (same custom kernel, same imagaging script=
s) that runs against ESXi and Hyper-V hypervisors (to create ESXi or Hyper-=
V VM images, respectively) and neither exhibits this problem (the notable d=
ifference, I suppose, is the block device being sda, i.e. not virtio).=0A=
=0A=
For reasons that I don't understand, the regression occurs only if the imag=
ing involves 2 distinct partitions / filesystems (boot and root). If I make=
 a single partition/filesystem and mount that at /mnt, the error doesn't tr=
igger. This may be a coincidence, however it's hard to ignore the fact the =
the file corruption always happens on the mounted /boot (that's where dracu=
t writes the initrd), and in the single-partition case there's a single ext=
4 filesystem (disclaimer: haven't done hundreds of runs for this case).=0A=
=0A=
Any ideas?=0A=
=0A=
Thanks=0A=
Andrea.=0A=

