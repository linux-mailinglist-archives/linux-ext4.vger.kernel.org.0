Return-Path: <linux-ext4+bounces-7584-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4695EAA500F
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 17:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6394C39E9
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7767124728A;
	Wed, 30 Apr 2025 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=viavisolutions.com header.i=@viavisolutions.com header.b="tQGhXMro"
X-Original-To: linux-ext4@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2111.outbound.protection.outlook.com [40.107.101.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A571411DE
	for <linux-ext4@vger.kernel.org>; Wed, 30 Apr 2025 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026499; cv=fail; b=WG/As68rAjj5z3qNj13AAAmCuD/ACGtOj3TK+TSSyN0LECSpzi0pf2b7tJnguAoYtfXnPcSzL9r64BQwYkbN4uOfOe8g+HrNXLhTl+ZnL3ujy9URImUJf/kwcbLsog+xGhA8l6HoDzFzVsa0ulv8V2XgqOV14y+e1D7ZrWykY9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026499; c=relaxed/simple;
	bh=qByeNYRydjfi0yiW54AV+t7uDBbwMnGmbqQzo4jKhRM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ph+bv9rLPGlzzsu12HVeowdASESorYFMWU8WPUqJRjNsR50vVlfI9f8TZYrPAjlAFXL/NaNqdGSAFzabKPsmVOV0qJ4HWlree/XvE6ykv3nsEV78V5Fsl2s3R/8ejTSbxWNDD2/2+glJHlpb5PvUtXa1Uh40iQNTms0p9jPEE7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=viavisolutions.com; spf=pass smtp.mailfrom=viavisolutions.com; dkim=pass (1024-bit key) header.d=viavisolutions.com header.i=@viavisolutions.com header.b=tQGhXMro; arc=fail smtp.client-ip=40.107.101.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=viavisolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=viavisolutions.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5ulvMJVkeXP08CmHQuOeLl/i6UyK0x0Pgbulu3E4+juKz6dz/GTox3udoZo1G8AlSytQfHdqPJ6iSaN/0j7VxG8Bpf+hcvlW83VTOvAtisS0uDAU6TT6R7KUR64go+Tfj4+uOMFnOGXEUYp0L7cpvDK4lZfru6WCntvxmNoZBE+PE9Ffcs4I9NCiyO5I2gSFuKixR9JBHLf8tgpKfRq4gB922aOgZBqnnFK7zWludbvMfJmazaxAhcuPxL69Gyc7pOY8fa6NlJaM6Vd5znAHf6FPywZZsRfz9vwrzrXjQngozNTR2CEFi6vndk1jfrcznkdfSdR/uNH2eEndFX/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qByeNYRydjfi0yiW54AV+t7uDBbwMnGmbqQzo4jKhRM=;
 b=dRqvttXGrSTHHTrJYxLtI6D+kX4X2wrFKZRZyM1lwz5h3FTVxpHJpBeIuYcgNaqa+nrp8s2GWbu3GGGOprGjhD1A/VCujn59msmOb9K0lC7CLLLGa84BjO/uRZGgOYFK5lOJTe4ApMm/T8feiM0lg40kaE/JAOhgTBxsDMck4e7m/wka4aMHv7sAkVU5WyEV3+BmL88/e9x7aHY398lP4VEoLmUojD3UI+L+q6r3paYO5M/esfHCgnggaOaE3OCEGdZHz92zSlqDF9r6kuD0avLtyv3LXbGURGYh8PYwt/dl5EjyqV6dguqv7jK9dSoaw8wUw2720Y2edlQhsC1Zdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viavisolutions.com; dmarc=pass action=none
 header.from=viavisolutions.com; dkim=pass header.d=viavisolutions.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=viavisolutions.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qByeNYRydjfi0yiW54AV+t7uDBbwMnGmbqQzo4jKhRM=;
 b=tQGhXMroJ2OXWrSIji51lSgHCOm+d66IVYwLOgtkfTLwyvRyAUE7pTefRNKathd5FnGcstr537cF1jhDSrrZKX4MOhtFpviJWVARboNz2p3n02WN/ay+2ZbG6wZahDp+LrcAk10n9lzCwdI2SrWgIkfRF+NQzdqqV6AHV7MzPwo=
Received: from BN9PR18MB4219.namprd18.prod.outlook.com (2603:10b6:408:118::21)
 by SJ0PR18MB3913.namprd18.prod.outlook.com (2603:10b6:a03:2ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 15:21:33 +0000
Received: from BN9PR18MB4219.namprd18.prod.outlook.com
 ([fe80::1594:8bd0:f209:8f4d]) by BN9PR18MB4219.namprd18.prod.outlook.com
 ([fe80::1594:8bd0:f209:8f4d%7]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 15:21:30 +0000
From: Andrea Biardi <Andrea.Biardi@viavisolutions.com>
To: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: ext4 filesystem corruption (resize2fs bug)
Thread-Topic: ext4 filesystem corruption (resize2fs bug)
Thread-Index: Adu541DGrU4P26y7Tq6PZgPzMNfsJg==
Date: Wed, 30 Apr 2025 15:21:30 +0000
Message-ID:
 <BN9PR18MB42196A214D588B1F60D1B03398832@BN9PR18MB4219.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=viavisolutions.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4219:EE_|SJ0PR18MB3913:EE_
x-ms-office365-filtering-correlation-id: a8d81a1e-a980-4b5f-fb17-08dd87faaf50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?p79nZaMxNwleeH4zm5U24Wv098eX6REN7AaRhtis8Cwa2HdekH6nXuOXtPAQ?=
 =?us-ascii?Q?wqU+it9fpDLpHC7hyATal9QA8XRtpsA2q+pwtFaQxoH1M8dDtqeyhAe1QWBS?=
 =?us-ascii?Q?Vr0nx48yToZogyZZt6c9anqOEM1ao76Dr9nAYQgIq9rfTmlzcpokUDeTIcBs?=
 =?us-ascii?Q?T+C8OwvZQ++mKGyPgUfK5Sj9VIRB85QZutkoI5hgF5mhxU1jR1NK4biJBlqe?=
 =?us-ascii?Q?XAdmivwoAyI5Af+GmVTI4y/LD+m3zZj5iGGaVj+bR9rs1RDAEfe3xIfbKvY6?=
 =?us-ascii?Q?UpcVxrXPEEva4VB9AJPn38h2ecgNQmZrSqwI9oo2jrS+zgJczZWzItN55Jz5?=
 =?us-ascii?Q?5LA7AHpqUoZAuLK2yMSvuXgtMoxZVIMSzHZ2/Mb6HsPQx20oQBQqc8qCZWjg?=
 =?us-ascii?Q?Wftz56umnpNIgx5Fn9pYFaBNTL4k9A0rqlrK3yanldQ0dPZDm+9af5NsmAeY?=
 =?us-ascii?Q?H4w8qhHLRe++sWyq2sLsvb+F1q9BcuJ4ScYG0sTGjQx3WM92iniylyN+K2R7?=
 =?us-ascii?Q?Iujc86mPSlz7af7PbE69cntbesaX37wvYNWYIRo6R3mNYNHBTpwDhZpAaCoe?=
 =?us-ascii?Q?gUqm9e1wFZNEbFdecrHxpIpwSSohQhi+4N6Wkbfl5/dRW3+DLsNzTeKN5ZbQ?=
 =?us-ascii?Q?BReZFYq4e/OcruZV4lI8GIxfRzzvtYnJQDlJd0Cg8MzqSlh/KbXTejfQYWEM?=
 =?us-ascii?Q?g6qm8pH93Rh6SYvUr4DO76UzTlCNi/Vx8UMTfXo17X1fwX9+km5yYvepfCX7?=
 =?us-ascii?Q?hx5BMjW1/ri0LiANxW68ewRrN34xofmvWgnvI3s0+79JDy1MOdYxwqsGcJ6z?=
 =?us-ascii?Q?3ky0bXF9VloFaBvh8fa1ze4po/+vWtYIfxD6uNbWxXZfbnASzfoKEed+E4ic?=
 =?us-ascii?Q?1eAuEvvmbmsyE+FgMePBsq7bwC9KENGzTLXT5ZRM/T6TSi8rV5mQbKDJ6N2K?=
 =?us-ascii?Q?mz2110M9RwYdhfNT0h2qgc3dQnbRZSiS+FJ7HrDrS+l9wpI7d0Fin+pidxqB?=
 =?us-ascii?Q?UEeYSb6Sr3GcKzbZ5yAK02lNKFe194cl22HL0nzT3gWdn8i9CAg5lxuiJVU3?=
 =?us-ascii?Q?VibgfLAj0gr0B0OluIP6W5QzbAYbvXD6j7p84ZqRKUw0Xk8eLprZWhafy27J?=
 =?us-ascii?Q?A8F/TP/0Fop7rWzNuSv1vBWZsxSvhNlHAKAGp4BJ3pBSz4Dx4AcHDVJNkUPM?=
 =?us-ascii?Q?4QGmGTtmARq+nKEJToKDIy2hLYNf6PIxpemvmuC8A5JoKYcjT3Bc0d8n72sI?=
 =?us-ascii?Q?xoH1ar864U8ipmAQyKnONc8/HiM9AUzF0aeZM1z5OmGjL7UY1Id+NtKlK/W9?=
 =?us-ascii?Q?stmCaiMGpTg6GjGjlyXBM7rvkPRORhbd4mZpWMW+q+kn+iErRM7uR1nQeoCu?=
 =?us-ascii?Q?3A/0DHJ/rsQh2Ke1fjDXQAyNnIhtJ+fBB4BkwsKMdaU4vZ4bElix9+HIDw43?=
 =?us-ascii?Q?0O+bWZUy/G1fLx0EWgXOQ/Xk2ngJw2DIj35q4XLRsUwYfz5FiBcY3pagGWYt?=
 =?us-ascii?Q?HkcVLyepzUXnV18=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4219.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oda5p0RcBWQR+Jo05+2jAYCPTmYbQTnsHFsGEYg/1nrUh0mKtd/Uo/PFiYih?=
 =?us-ascii?Q?WcPblgQbFwUUCAwFZiPvj2M2v407RytVyoaBmOUqfNfMLnXSETFfcobW2OyT?=
 =?us-ascii?Q?zzlaIkFKYrCN/PoEZl2/MJDlRwc3OJ00Od5XgTUrVHZtr8iCEwndW+e63Bs3?=
 =?us-ascii?Q?5fhDY4QKNmox5T7vCfzHfWRDRbYMUmKJVNqu/iwt05j4JxPX+Ksr88P0IQn6?=
 =?us-ascii?Q?LSkqG0FQXo3Dc6JGXwgickGc35hSUKfasEbKASn4Ze8aEPKVYTwqgWlX7PT3?=
 =?us-ascii?Q?dbF1082kjmmetHUTvOoNWGhKRf4WyFZ+Q1mpiYsyzklQjnKlzfkxSJPQ2dHt?=
 =?us-ascii?Q?AgzpHs1UK1qQHQn7HGVPx/oNvCFYWrxzhkwhb6TTrh3+AsQeyoyqSRQyxCy0?=
 =?us-ascii?Q?09jcI0XAf6W0z3N5ENtnHnCW5P4TUTRqCnVV6Wxp0L6+3lsKREO+PrarvL9N?=
 =?us-ascii?Q?z6NACAFMEHHgPJlJ1cWPBXHfA5r97B3D1tRAv6QMB0/NzwgGmakd7yPLRUnx?=
 =?us-ascii?Q?gTfHULs3qKLAe7nO13+ay6W/SZY/7Qrq3ZsCz3Csov9TjCi10eSQMJERSIQh?=
 =?us-ascii?Q?3UPqFr3HxF9RSPOklzECTQAgDlFePziuyKNRBw6O7HYaeeTudl4cWqIioCRr?=
 =?us-ascii?Q?rjpEXmi7YRf3weAe2aBTAkXmZ97bd8SblkUt3BIL6Jj8ROLh40J6J7e20hIz?=
 =?us-ascii?Q?ynGBiHZVsgod8KvulTLDwBpD8tOmCp/IMPqhSvkx1GGlvpwlTE0ofn6meJSi?=
 =?us-ascii?Q?a2/GgxB/zCNoeYOhEo0Y2J8UGydSpsf+XxrJr+lQTXfeM8o1qmHRjleK09Y7?=
 =?us-ascii?Q?3wNsjgeqedKSxjecwoYIskphMrKyEiWCj4AiEfO+d8ppGveRKwLW5LPnmY5D?=
 =?us-ascii?Q?UoTNTAiZOPnCLhvs64emrmloWZp2ttLv0xzqtuAB1Rk6cLMLxN9+sN5embVt?=
 =?us-ascii?Q?8N3R9mxWOdy5Z/a5zS7qQPqr7944yfgf4a9G2Al0KxrOwvGUlKbqcotQzCkF?=
 =?us-ascii?Q?QBB8/As3Bxgh+8LpekODFUCY+SMUYZsE+XTI/5ICz8JEo+TmR03Ut78Ystn8?=
 =?us-ascii?Q?a2+PLP4zv6rPJJkQrdsqdWouRqeb40yZmIG5GF/j2PFkSzZQe8QYSY4oQAEB?=
 =?us-ascii?Q?HFONYOID8M/a6yHZ/oJvGd0GJjYnfN9YFyAxlDv7S3pt7E7ycapNb6gmdq6n?=
 =?us-ascii?Q?1p4QIAV/rP5DnMozKsskoVvxAEmkMBqepveTYOQeLtaO/G//IRwryEVyklCL?=
 =?us-ascii?Q?iwaMeKVbgdCemYWx8qhaWlTjaEN/+fuJuEfoHgLUc12Q4TRWo8ElY34WVnZf?=
 =?us-ascii?Q?ggfxRybwYArRBwLyhJKwMU9vobgYugHMGETrIYKjC/iCRbjDngIiY16JtKpG?=
 =?us-ascii?Q?hXEvyaSdb5jtyUfbE1xDANqcqqqv5v5te9icHZJhqadCutETlRdrJcVLJiIN?=
 =?us-ascii?Q?WD/BFc9reX8LC6D16VqkL6vxzQKL/1D1L7wf2W6nsfg1Y3cmTVO83WEPcBh0?=
 =?us-ascii?Q?WtSlrzEw9rlJ5I14nXnf2+T+ZqjfRhrVUtK0EebSWql9CZ6wL+vOKaYvvaXp?=
 =?us-ascii?Q?X3SvOrJO38sClpEx9+b2G/B6DSTu9OIUPzHotkUgCiAJ6UYTone0hDLvnlQR?=
 =?us-ascii?Q?qA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d81a1e-a980-4b5f-fb17-08dd87faaf50
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 15:21:30.9073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c44ec86f-d007-4b6c-8795-8ea75e4a6f9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GdHei2hvNj/DOoJrvvZv0FyDx030H6X693VzpUM4ieV40Z3tZ5WkayK1kwhcOSIxoXwtvhCrczeUMMow62cK4a9u8Sjz/ecn4TDoWLRQKXoGgxo3hfCIQdQ7FJhP5pDw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3913

Hi,

Apologies for posting to the kernel mailing list, I'm trying to get the att=
ention of the maintainer of e2fsprogs (tried emailing him directly a few ti=
mes but never received a reply).

Almost 2 years ago I filed a bug against resize2fs that causes massive file=
system corruption (https://github.com/tytso/e2fsprogs/issues/146).
An e2image causing the bug was attached. Analysis and patch was also attach=
ed.

Other users seem to hit the same problem from time to time, but the bug is =
still there, untouched.
Considering the nature of the issue, I was wondering if there's anything th=
at can be done to get somebody to look at it at some point?

Thanks
Andrea Biardi


