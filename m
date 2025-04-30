Return-Path: <linux-ext4+bounces-7586-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1368FAA539D
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 20:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB861BA4D06
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 18:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88D92609C4;
	Wed, 30 Apr 2025 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=viavisolutions.com header.i=@viavisolutions.com header.b="kMC/qb7Y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2123.outbound.protection.outlook.com [40.107.236.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789AB190676
	for <linux-ext4@vger.kernel.org>; Wed, 30 Apr 2025 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746037474; cv=fail; b=CvT74OUalJcsa2KutSXtDiP8g2ke0Fh63prz12W344ClvUNXiIbaHB0vrrb585TB2PeEzXKUd8+33ErddADvZWQfiMaJ4ZxN67biOnYmL6CdWlnty4NxPxwVvzZgT3VH7ADKI8oItl1BKfXhatNOxRSMC3ZkSao+XzMuEgEtbZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746037474; c=relaxed/simple;
	bh=M8k/D+rhLIXj2rPry1FvF9VivNfQ7hnCfx1HYlH56zM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d/CDnCA57QgLGYDEbkjXHz851yv/nhX/2LamirdDn8uJ6r6Nc5VMzJMZooYL4D+H/OUh2/kh7BjyyuRPXHUTvw9CfGKtrGjkvI71/0Cj+HpPjLqbS3d1MmvV9+T+rvAGYlRaKg3dwvsC8dNBMuslS6SugPBFHmjavI+PSrUWeFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=viavisolutions.com; spf=pass smtp.mailfrom=viavisolutions.com; dkim=pass (1024-bit key) header.d=viavisolutions.com header.i=@viavisolutions.com header.b=kMC/qb7Y; arc=fail smtp.client-ip=40.107.236.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=viavisolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=viavisolutions.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTPHMPJBuxso3fOcfWNzFOc0/790QQkXXLfkOtszDNFzQxkrZYR5kooFw+cBLzEggZxz0A1fpsy9NB9dtEZWpi/AmO/AB863AowGJ/7m3Il0GBoU6CpgFTIphie9WtjZPKc78NepHN/XrmBuXAbOaWWzzaYQcNwX8IewS3qmJq8u3ILYyegBG6OSr0Q5/uDgE/z8h/2TayluWqd3nr0hafHI1pOCwY2+mmZp95INLEwvJKopxoPa0aokLtE6tnwOIwutRS+VpLDnHxcqH2187R1r2Exl7FQ0/Oc47A9NJAvU90cWSV2THkj4k2xoVemOZlA+VDAoxkm4ZE3mcc5C5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcOdBX48tzcgqRkXhootJRH3sjjnTisK0S+PP5VT/Xs=;
 b=LHkSdOepckkd7ABWCNiDNUYIlmTms6gJHjqqoflV+V95QXN7KJia6DmNh+6iNAPf47DYhBeUzhHxsH/FalCpon4otvgAlBzDrWxMk16bFAz3xXTot1cnvq9H2sNSPqKyl3zqjUPyksWi2w6WLhZ6HIme70LZgkWEaIVU8ab7zwQlPS+zv7b3WEAdUsu8hZxDueq+35dXwSukRMhHaHngtaI0+mwLbSUtKGsTKf43d68oOd3e5/jFZnLEDTQcdZ+H7lZvDJlPdol86oJoM1RT7sfb5Hd2Xs9g0j+6yy0SpqetTrej4ep0Lv25Gf4Bg1ouC1gvVDo942jNtM/+tfjiFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viavisolutions.com; dmarc=pass action=none
 header.from=viavisolutions.com; dkim=pass header.d=viavisolutions.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=viavisolutions.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcOdBX48tzcgqRkXhootJRH3sjjnTisK0S+PP5VT/Xs=;
 b=kMC/qb7YBlqzPyfvUIs0UpSDONX9KVrj4CmqfvkAOZN259QOE0he1hf6PCaRGIZ9HRTZLmndzcrVgUhMXbx/R1SzpXHkkM8/w7Kc5EGwlD9Bi5KWb5ZhnzVqmSUiYC9iM8TkRcc0uZWS8NNiM1OPH4U61qt7XN2wgqXC3WLlPAA=
Received: from BN9PR18MB4219.namprd18.prod.outlook.com (2603:10b6:408:118::21)
 by BY1PR18MB5837.namprd18.prod.outlook.com (2603:10b6:a03:4a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Wed, 30 Apr
 2025 18:24:27 +0000
Received: from BN9PR18MB4219.namprd18.prod.outlook.com
 ([fe80::1594:8bd0:f209:8f4d]) by BN9PR18MB4219.namprd18.prod.outlook.com
 ([fe80::1594:8bd0:f209:8f4d%7]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 18:24:25 +0000
From: Andrea Biardi <Andrea.Biardi@viavisolutions.com>
To: Theodore Ts'o <tytso@mit.edu>
CC: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: RE: ext4 filesystem corruption (resize2fs bug)
Thread-Topic: ext4 filesystem corruption (resize2fs bug)
Thread-Index: Adu541DGrU4P26y7Tq6PZgPzMNfsJgADf/yAAAK4aUA=
Date: Wed, 30 Apr 2025 18:24:25 +0000
Message-ID:
 <BN9PR18MB4219716B2A4C6CE5ACB7F46798832@BN9PR18MB4219.namprd18.prod.outlook.com>
References:
 <BN9PR18MB42196A214D588B1F60D1B03398832@BN9PR18MB4219.namprd18.prod.outlook.com>
 <20250430170003.GA29583@mit.edu>
In-Reply-To: <20250430170003.GA29583@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=viavisolutions.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4219:EE_|BY1PR18MB5837:EE_
x-ms-office365-filtering-correlation-id: 26ecbc3b-46a5-4c41-cefb-08dd88143cee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HihWm4es7e1ObjsvbzAvRUne+57nty5TZa576a1mE6AEzmxyPTuHA6ywJUEH?=
 =?us-ascii?Q?Uy5FN5WOuiAbBYmD7EnJfGX44GO6hQs9uTNpJuBWRQZgBEusxFFBBBbB4d7Q?=
 =?us-ascii?Q?TCMv8nLYp+W06xvWYGyfTcYP5FscQp3xaAXbGg9gHinLC2PPC4xAA61NAEeW?=
 =?us-ascii?Q?DCKWpC38cnG9ZGGZf86JaP+8Yw6k2DkhUn8SQV0mko717T2bhXkj714bVENy?=
 =?us-ascii?Q?FqQNyqFf5dbJMAuEWLdgjvn6fMsXtRHiFbjQD1WH769tLXNqwWftTSQWku40?=
 =?us-ascii?Q?PYnwYgcyYINBiOQF3IjfWc21wB6L8afKbAmzksRvvGwJJx/H7P6ObxzAykmk?=
 =?us-ascii?Q?VZUp588HB5yL79PWVAVolGpmMtKXcs0q8p2IBSLwabgBTDDjb53WHPSZWP3j?=
 =?us-ascii?Q?mei+dBsNiZ6gPccRVr5W2GS7Xldcz/1CLGRTiHQieX/vDC+vMiED/jfbUOCp?=
 =?us-ascii?Q?H6r8N0PlXw3z3YPhJ0rPL4B7zHPZLOzsX6+obTl83EKsGB1OnsA3HmCOli66?=
 =?us-ascii?Q?QewBvvWRuB2qGzwe3lpP6SFkLN1DiZucQV2iWoLcRGtibcad6IyKBsVBpQJi?=
 =?us-ascii?Q?M39VemEpwZC6sWyfnsK4tOpkYieDCGkbOaXPUuQX56UicxW5RQaUJqlclDvv?=
 =?us-ascii?Q?SqPl6uY59mmbk8YSmXvKrZZvjqY9Tc2tMKYyYwnYcupDcTWKoYtonkOuO+LA?=
 =?us-ascii?Q?S0nX9A5hUfC8JjWR17mL8ggmKHXkLO08y5sDkdpssWZ+wHPHZ++VDbv3eDll?=
 =?us-ascii?Q?nxgUwavXTLVlTrvCvnq2sIC5+Cnjc7+uukkD40BuGTmofH3F6u9r3d2la1RD?=
 =?us-ascii?Q?Fvs1Vs+cwoyO1HcYUFnKsRdtlvhUpGFL1PrpPesUVsBByDRZZsy7mbece2Lh?=
 =?us-ascii?Q?v3f8HtXpytLLLj937VTHAgm9pIOS3leMh+kYoYM2bVF7Kd/yDg4zevoe25RL?=
 =?us-ascii?Q?l58hM97Op47OnMi9LG36+CeSI6f7SiXHZkr/xVfyI8+hUP9rxP+g2foKLOue?=
 =?us-ascii?Q?qr3gesfV+DW3CRdPV9Z/SA2aCH+BmdC4Yxwptwi5CkAfPsSvWpf2byLLF4Ui?=
 =?us-ascii?Q?IagTjZSY18CYbG5e6IRyH938OBBO73L/fmmSuW+ZKmppUZtmxcUKGMnT++zE?=
 =?us-ascii?Q?rbBdoUo4ZuSH6xIJwxTzL0JLeIn56FK7PsA1CCdXjJtZF96/FBy3lGscwQFQ?=
 =?us-ascii?Q?L99VSCEfSP2UUxl5XAVur5Hlq+wn7m00ocStIpo20QGQQ4OWltewAp8DLga5?=
 =?us-ascii?Q?b2H5etfgDAWdx6xqHfcx2uf+h0R0vGxH1iTv6nUFkmxIciaTSSxPCkCNQut8?=
 =?us-ascii?Q?0UvO8Xev+7xcopuwsNa9FIiuy5wtZYtpu9j6+VW1VyIuy2PC06LX0wvrAGNz?=
 =?us-ascii?Q?KqX7j+rlbQ/4vUUcmcYEgMq8olwyaWLvriTa/ZMhV1voOzCiQIKSrIj1bF1U?=
 =?us-ascii?Q?/VOD093dCcy7rMMKhCBFS4wGdicoEaQjlhWGf+twhINj9MlR81bklNBErUYn?=
 =?us-ascii?Q?o6sJy4ALpNZgdQg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4219.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yHvXF1b9PzIPuw12xPTY3TlE8/Fvy16UlmI3w1OSpaIjW+MKiEKpPiZak/kF?=
 =?us-ascii?Q?wml5v3maMkxlHcU17uODUfRlnDgGz4y7s7cwz6PI5ZYc7mG3QNQSwFQlk2QP?=
 =?us-ascii?Q?hfms73sLSzVpcjXHsvPeA37jzWS9xkFylLqDpLxijn8G3fmjFpJ9OKJorpIU?=
 =?us-ascii?Q?V83Tkyqq4OJTBmiTXwBA5A8M2ODdbhZ+9WcV/j1TguG6dmOYARVOars4VxcX?=
 =?us-ascii?Q?GGDi6U0skIm8J99Dp/Lukzg4ASoukmHCPDYznoHtxLuJZbaZrhvEqcDC5z+I?=
 =?us-ascii?Q?Gzh6KtKmIIb+rcsjirs2FEMcfmaK0Lf1HpbO977vNEKLOLi4fTlmtFE8hiUs?=
 =?us-ascii?Q?LwiIqMgUiOpsITEo5C5OxdDIklvcs2z///gXWGAHD9ZTRQLN+pCzECfX1OcG?=
 =?us-ascii?Q?gbBgr0dS6NVq+gmuWZJfnlIoXiTqodAEhPdRiE1Y0VfdEA/8P4pdpUnW2cXC?=
 =?us-ascii?Q?oIgDdIKEbpIvxuSjh6jU3VRpOeZIIMTr3H5uDqTF+F4zIVEedpnoj/UjLfYO?=
 =?us-ascii?Q?NIsC3X7rBh+g1h1e5EpWaanhYyGlO10mMfN/aHg0NlIrZUm7Bq5cxd0HQi5v?=
 =?us-ascii?Q?ka6f6PUstT1ghdJ+xuSkM0/oGEzwVi1mlpZlvMKx5enbpVrFf8rU9Fuv6969?=
 =?us-ascii?Q?k8taFkrLnuwT4WOxh85fTvFyTqKgXD4GEvVP2dGDIh4Ai6adq0UmtWegnRSw?=
 =?us-ascii?Q?KdzucVF2jyUMKHjfJvCByFGbUnkl0M2qykMdzOGPU/886OmRz7IvlqtMYx1l?=
 =?us-ascii?Q?yqZ0qmdYOBgBmvnEzJHvscN2vV6A4EmdZIp/Ni96Cq/s+oknupuvgzUi1XaS?=
 =?us-ascii?Q?/CB9vo7WVm2O1chLn6bijV7plQsDHkKvRjC+izFWJ+BIQAkUTpV5m40Sr/SS?=
 =?us-ascii?Q?fFhjzBZu87dKK4ppBj7AegkmJ06q9sc/bjlFiSi20HPGvPm3ma7EWE1MNBXU?=
 =?us-ascii?Q?msWYNadPC+tAq1oB8+njT1eUmLcz7wtNejHkHPAi6d/iRDkwPhbh46lg4YCD?=
 =?us-ascii?Q?IVSXvOzq3sK/M+BRmWBgKECqVgVH5/BVZOlW/UxMbmkFSWbtUguIllQZirxd?=
 =?us-ascii?Q?b0kUIfiEOMWsxccDLbzTw+lfExdFC3RzCeg+Ky+3Tw2itvf21TAOdbwxmA6G?=
 =?us-ascii?Q?slIL2XQY5IVnaqq1HL7AO3B+zqeR2V/e1Gw8akzW2JI0/BkfD+6yc1SAreeN?=
 =?us-ascii?Q?+vhUCWS0K9/Zyf2VVEZkcPl734C6VhpedqTj59b2xDbLzmSZ4YR/LUbuACth?=
 =?us-ascii?Q?+ZM0sFvuTlGwoAhKlzRHyqmoexDOgaIepWj+YUBYjZB5FmWDG2d7LlV0kpkB?=
 =?us-ascii?Q?B6rBBtOFYCjKqxwYdNFU9+e+2ealjhS/Sdn5o1kOnbwBVXMXZkJWbjJT9UxJ?=
 =?us-ascii?Q?c16ZhoFi4+ftXleHDZ9ZoL/mSR5UvYbyvmo6MCzWZPX62JIJ8rZTktg7vXbs?=
 =?us-ascii?Q?c0dOW6yyIzftTGlcWToSPwMpFvcJ2g+zwZccOLXEuCI1e1d8GyIFVSiYQ+fQ?=
 =?us-ascii?Q?7zVo8RoXNkt8vBkxUWwOl5dpGXqIObzIC1rmVABJ9vuieQ8rJl+xN/iRrWP7?=
 =?us-ascii?Q?OkhpGn9KhSaxXuE4NulfzZNORmu1k4SJQlFi7/RO6K7zJJ/fC3T+Wyih2pvF?=
 =?us-ascii?Q?JQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ecbc3b-46a5-4c41-cefb-08dd88143cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 18:24:25.9078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c44ec86f-d007-4b6c-8795-8ea75e4a6f9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tp5nSEZC/8sTtFdCC6pmQHCc4Ek1CMom0s1A+p2yUAklhfV/XB+RBaIBr8AaE93tlzzy7up9+vtVpCfyp0RmdaiY16l1+zu0ISBF1D75z+3lStDP4LDqrG+DqOX5uTTW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5837

On Wednesday 30 April 2025 18:00, Theodore Ts'o <tytso@mit.edu> wrote:

> I've checked my e-mail backlog and I don't seem to see any e-mails
> from you.  What e-mail address did you use?

I might have used a different one, I don't recall myself!

> I saw the ping of the github issue #146 so it's been on my to do list.
> I've noted the patch at https://github.com/viavi-ab/e2fsprogs and I'll
> try to take look at it this week.

Much appreciated (and I'm no C developer, so take the patch with a grain
of salt!)

> In general, though, the best place to send patches or bug reports is
> to send them to linux-ext4@vger.kernel.org mailing list.  [..]

Understood, thanks. I wasn't aware and I thought creating a bug in github
was the right way to go about it. Perhaps it would be useful to explain the
process on github, e.g. in case somebody else finds critical bugs in
e2fsprogs that might need attention.

Cheers,
Andrea.


