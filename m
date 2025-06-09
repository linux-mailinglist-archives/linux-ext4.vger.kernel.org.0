Return-Path: <linux-ext4+bounces-8334-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 944E4AD1C33
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Jun 2025 13:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2A9188CCF0
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Jun 2025 11:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D179E25522D;
	Mon,  9 Jun 2025 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ogMHdm8V";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UqG2tP1V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7F253956;
	Mon,  9 Jun 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749467106; cv=fail; b=gnqCdcDCF/HXjh070z9S8+JxhBW2HkYoVBtrIPY4OyzNm+34MOxi/eWpQyx2uNMWOfaUCI+NNp22HeCkRnmcxwE8/DiqCMmATKl46LqX+oMUT42VbL2Hp6znxKYT2USq8sE0k+atHWiX/34RvdpaTz9yL3zDrIpj2OypTFDiujQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749467106; c=relaxed/simple;
	bh=kQJqz+ySA2Nh7Ylb3E3PZgQUqiSWXOu1Kkhjw+jaLmo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a8BDHzChSt/FZly30EQMIs5jqny+31fvMWO1383KpkFDHBM2/XDkD2y9QBaWtRVqOdSsCYp4A7luQ5Cx+xBrd1Fm0pW4BsUP8TcIYZGFF4/KPpcSANpOLxnatSNiYwDFKmZmu9h/nJ8u5BxOQSmqsHNxQPby6RqPruH8g/E005A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ogMHdm8V; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UqG2tP1V; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749467104; x=1781003104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kQJqz+ySA2Nh7Ylb3E3PZgQUqiSWXOu1Kkhjw+jaLmo=;
  b=ogMHdm8V97oUAMNRGA9aZX/hp4yYR9reTBqigglGTNAs+OKS/br2WkbC
   LGR02oKB0syXos2OGmV+dQITqwrZSesu+iDZz2baONrj5gamoLKKdo0Xl
   gCwtTv8FLlgsu0MC/GZ5PhRAuyghjN+b08XFG9StwWGB/emWXb3G/sZ/Z
   ONH0hBx1b4XGllunu46wwF9ICtuIATN+ZxLijWUJLnXL/BGAE8bDEistA
   xg/i3uyEQH3IuTFTV2qVYLA5U9yxmKxXdoFZ6ALWpmJWsYq6Dz9XP6NK/
   8PSO00pr6VR/Ql4bQ6VZ7RAd0E7SriU9kYXmZofm27ntYLZjqU+VQUlT1
   w==;
X-CSE-ConnectionGUID: 1cVWh7ouSz67CvDyn6v7/A==
X-CSE-MsgGUID: Ag9Ue+D0RoG74b+D3nLx9Q==
X-IronPort-AV: E=Sophos;i="6.16,222,1744041600"; 
   d="scan'208";a="89171346"
Received: from mail-dm6nam11on2086.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.86])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2025 19:03:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQBg4MSmd+x4k+r4iOtr70gEXoudYOiQ+rJYWz0Fm80wWYfHH4YJ8Fm5Zzvpm2eWJitm/POfRHNOy+qJaNE4cpNTmYHADrek5U7pWmkAVQSgLVgvjwpy4uLxslzSM9eBDoITdWl4rdFhmRvb0i8hY0p+VTkHK3gQ3ud7aseygmqiMjeK4mgTaqFjQjKDnys0EqPqw7HxmiZ4E8OiNHWknk6Pw+PvBDeCeb1yBSmtbx1X+HX7Ksr1Th8sbzaiiGm3kU9y6J/ItE5urygzBpuv+6i4RoEZxaKtBWIzq34MFivR7hpm0MHIfnzLZS9a8gS4O/vJfOfEAk+2rVLbr2tsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8Xuep4kzQfQSE4MVVee/jyUaVu4CjzRg7yQ5lI4n4g=;
 b=yskA4rMsy051+kmN2oXMO4lb3hDKzDhmewmQ2bLj6qr7IgR5xXQVTzDp+YKq9JRoPohrZXdFhDio7tgb4riyOAGw/bPtL4TPl1nygUf8FgJtigmOL4Oewz95oTMAmxsvNWrvc9lD6gdgxk8ERGgdXD3oU3hop/C7ehl9LIshwVyV9l5hVnxHoyDX2NVMN1plJxubnS+sImYQdNj+YorNhnW2zlD+zQpLXdyflHwuxZCVnScI/SlxeEX+spBsdLFMyHRN9HRisVNCMceK8gmuHFnlJAUnhu8X6VIPbc/+sNhKydbtMEZic2HbDpHSnI50+tWGaKrHTw3KsG4EV32lOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8Xuep4kzQfQSE4MVVee/jyUaVu4CjzRg7yQ5lI4n4g=;
 b=UqG2tP1VRyfCXH4fmfB36UH3wIHqd7+jdfEU2agurlWgz5OEZrjDmjOmv+LiS7XCInskc3QEsRzDFqn5PNu+LcDA1PbvbRw/7aXhjjvCqChtqrQplAp1Xf4YCT/l99hP0IyIZpzG2HyFIqQj4tztXR61GWxZ9XeBE8xFWjQJn1M=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by CH2PR04MB6661.namprd04.prod.outlook.com (2603:10b6:610:9d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Mon, 9 Jun
 2025 11:03:53 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%3]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 11:03:53 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: Zorro Lang <zlang@kernel.org>
CC: hch <hch@lst.de>, "tytso@mit.edu" <tytso@mit.edu>, "djwong@kernel.org"
	<djwong@kernel.org>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>
Subject: [PATCH 1/2] xfs: add mount test for read only rt devices
Thread-Topic: [PATCH 1/2] xfs: add mount test for read only rt devices
Thread-Index: AQHb2S4wUMcdsWCwFkGqFCkFsDXs+w==
Date: Mon, 9 Jun 2025 11:03:53 +0000
Message-ID: <20250609110307.17455-2-hans.holmberg@wdc.com>
References: <20250609110307.17455-1-hans.holmberg@wdc.com>
In-Reply-To: <20250609110307.17455-1-hans.holmberg@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|CH2PR04MB6661:EE_
x-ms-office365-filtering-correlation-id: ca708476-be4c-4405-463d-08dda74552ac
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?qkPpyjYRCjW5T1WxCt8U7bj4c10ewl82680xBpaQy8K5xCl+/pXZsYcz8G?=
 =?iso-8859-1?Q?Vc6YZ+tvqHONi+2sZHpwI4lEzCUSFS6dRoYsLwNRmCLB4atC64xFOPyCmx?=
 =?iso-8859-1?Q?/Z1HJugXaqZIbnoh3f+LHVReTfTFEE210dm95dWXe3UgJdt6hL4N/JeE12?=
 =?iso-8859-1?Q?kJCpLXudYq2aJ1kiuCj+ZDpFUpRPYO4g8MmWX2RzTgfND8QQkcwKvmD1z8?=
 =?iso-8859-1?Q?DfhTyYZJSSGGirqTJ5BFUX9GK74T2fTng2bWFssgQgNuOwijjPof9AiWmr?=
 =?iso-8859-1?Q?3GPTMDznxJ6gMbtuZCsIzXZ10dBsQiiaVFGeGnsVoe5YKrnMZAxonxxlPL?=
 =?iso-8859-1?Q?P0QQH7IUqoyPeUGKebrLhsDp2bWlth9/z1TX1sSpk6Ya01ptIZr/YVy7P5?=
 =?iso-8859-1?Q?D1iHqNRKzUOSgxWX69O5O+9W/k/m3zI9hCa4UkIe52++L2z3FTAiOL+RBD?=
 =?iso-8859-1?Q?1EqWYo5pb1SbKfMP7v7azZYyO5fS5jnlvVVV8D0Z22OmWgiDf2T8zgmBfp?=
 =?iso-8859-1?Q?10HY2liCrDRw4XWNkJJT+UTXD/M5HiF8uzB0DpNiE6zsk01AvgZ2NSjcWx?=
 =?iso-8859-1?Q?UtKQBSIOJixuDRbDbhsMe/l8WUsetx4a2sA/dFF1ptzDX+QMrc2UakPxtx?=
 =?iso-8859-1?Q?Zvkesay1JP63P3+tAjA3TMKbExgc/kiDiU5FI7XfxT36tu0hESa+kvFyA4?=
 =?iso-8859-1?Q?bGVUAuzyVX5Q+Djc0NGtiL0rsWoGsgvn2CurR86OknqjC0faftAqzg8qjB?=
 =?iso-8859-1?Q?Wd/99z9Te/tKQznFSMohm+999SlFT7OmP0o3WdiiOClxdA3uYdXuQu7hTO?=
 =?iso-8859-1?Q?i+xAGiqaHEhrnLis4r/mLUk9u9U21E+uo3Vjzw7WpZV2TO0+hTQlFp5eGQ?=
 =?iso-8859-1?Q?RLPqgjcBEosvENFLzRgNRHSpJNkpfu+WqsFCwuMdsKv3ZIfaa0gzUNPw+T?=
 =?iso-8859-1?Q?waDWvCyCe4S0TQ6mIoX+al8nwavtBuquFsKHi2Z+nIBvx5g2hj94j1Awwc?=
 =?iso-8859-1?Q?506RuTAbZLkgz3nBz1+WbtbPc+pxxsy44IwCRL6XOgMfc2oMZX4Df2+U+r?=
 =?iso-8859-1?Q?yRPkiu2HnhVlCtFUZc7792RgXHN6Bk2ha6A7CBJ4s0VfkitEJikOUrxIVB?=
 =?iso-8859-1?Q?SOmZUxifIB1d3NeA9G4SM1WcReUDFYYJ2TnlN+r61vqaFth6eIYQnuKlII?=
 =?iso-8859-1?Q?uW1NoChT29mhCVcDuHyYXgbcESsmg6OqGl1rHxcSCD9HZRAx5MFcaazWzp?=
 =?iso-8859-1?Q?PDhfbpjyc/YraXfH5aAqkR7ShPOOCpDC1iSEihL4QSAXeXcYtRxvRN8Yi4?=
 =?iso-8859-1?Q?8mD44N6ngKaMtKoxT8M4OHoKi+sgcS8jMRFbePoOK3GsupEqC75uotHV3U?=
 =?iso-8859-1?Q?zEjbN6j9lTNCdy3G+0FargJguclU9krNK7bn6NxlDeeHjlvNT64wVRR0S5?=
 =?iso-8859-1?Q?SBjE4zew9mYwTX+kyGsXkumtCF3Jrp6h22Lx7aI8aTHpGyhzVfB0R7kcOd?=
 =?iso-8859-1?Q?XB6FMDEwdpiPdUYm6lA1+Rwa3PXPAAC88T6b7dEaZ2zb7MDEe355oVvY8Z?=
 =?iso-8859-1?Q?ujWHSfk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DSyjaMCW/9LKlyaYGQeisqQ+W+ay2CoLfxjhtCFOr5ucHxlJXwUhSfB8z7?=
 =?iso-8859-1?Q?U0ifL3DPXCxXqVKCMv3GZjqWgQAS0HF/WYvypatAtyB3eE1aB1ebEk4SNc?=
 =?iso-8859-1?Q?8Wdb/5WyUSVMh66SBrToX3ll+o/vVfXNiIU80P0d4eaKlIypjBazyNupnD?=
 =?iso-8859-1?Q?MqDpyVor3UnJPnF6Opp6UVt15eZvU0Ve5cTAb8gJbR9nyGIHKd8jBx4F2G?=
 =?iso-8859-1?Q?g/NOhZk5st7RPr7Ko14O8mK8megQXxE/AiAuF5kL5+e/r7UHON1NOIobq/?=
 =?iso-8859-1?Q?Y0se1wALO/kXlXLUpWZDiZoYinEQm/JvhUud2c3ZmosMrE64AJmIM98BDW?=
 =?iso-8859-1?Q?XCZYZ4bIbxow9jtttO1jxpN5fqph6siFGEjuFGsK4Pd1UNJ+CKkggBgxxx?=
 =?iso-8859-1?Q?ZEgsj2mDtjc2mcGX6ujYVDGdJhWSatpl9czueLqH74teKeY1uRl8sZtxv7?=
 =?iso-8859-1?Q?4OHluB8sCo2UXkwfbem/W68hk1xH6acKzUV7gOSCq9J/8VauPJbxWoB7bM?=
 =?iso-8859-1?Q?rjJo6Q7FO9Rhj5ZthB3Hx8ztQJlMe6mUkAbLUgpI9tlZfvZMggSfw1GcOj?=
 =?iso-8859-1?Q?aOaKkXRKrnSjmgjzn4bKs4NM0zVc0r7tzOWqXWV5ciES45dclygRdfX3mZ?=
 =?iso-8859-1?Q?IPafNaGjb7df2v89PbPEuW5DNSkm9v9w4Z+LSdoUbDq8/gEH+Q6sDrjpGg?=
 =?iso-8859-1?Q?aCczsNkrsYywI06y5pzOaX4tA1OLbgLLdiCp6Sg/StUnLtiWNVdprUOkkI?=
 =?iso-8859-1?Q?R/yRe8anvKyDimgcCeT1B8LsMfLS7U7Q2bEk8SDCHW4JS+5DiuDWKSHN4F?=
 =?iso-8859-1?Q?0owJRP2r/9vBOgZEtYc/lBYEL94w7nNigmsn7+a9ZhCwxjcocOTosBB3eO?=
 =?iso-8859-1?Q?N2yFbwi2HoXXYHRZ+2BgQPj6mKFkVR4LnntN0rFbYJUh4iv7wbAKSnvSlB?=
 =?iso-8859-1?Q?r/3CU40xLbRJjroOQCgtqeEl+5fVeP+NCtu05pivAi3zPjmUphlcoxPx5d?=
 =?iso-8859-1?Q?Y/KK/HQqZta+jS4tieYehi+vHEfrk+N62GgL0ikqmEy5DW3N0Um0ChmL82?=
 =?iso-8859-1?Q?xCsF1zTxuWCcyFSLFrU+PTbf8sLdIC8KWzas/FrD26l6a2q7S9doyOoxb8?=
 =?iso-8859-1?Q?vignTTxa9D21ZMrX2X/3pK2zbvuasy3S9gPr0oND/TT1pqiHcub5/SqsL8?=
 =?iso-8859-1?Q?o/3/T1xjAkRqtoNOAZQ8azxAz3QLsPS1Efmx8d2pAh52T7On/4IXkfrhyL?=
 =?iso-8859-1?Q?hVklKpEY3Bifbv83yCgsPTvIyTDA5TXJRqrdR3oaisVB8nbCsM5VJJar1F?=
 =?iso-8859-1?Q?EDpRMgAELwbxwHykm3hqSwksb1xjJchnKu2nhkgJALXSc0XETftI7mufrR?=
 =?iso-8859-1?Q?7aADXtMro6AnG3gkSCtyr4bMuqCTvtMSgE8V48a5VGstdP8xSwjpL26Sgx?=
 =?iso-8859-1?Q?TMND+8MNa7ibto7bWCWxOyej5RXbpIgHQsPpsMXjTLjD/ZzoNNchejXdea?=
 =?iso-8859-1?Q?qcVEuHcqwRy6ebiKkD3Xecky9PX1DQgfOCncLu387fqDArg8uhpwosOih6?=
 =?iso-8859-1?Q?GoX8wGNZmQjdIK2wUIrIe3D4LjeQJ6DtsDrUptusdUeGx6PpKN6eSzi/Dn?=
 =?iso-8859-1?Q?QdadZoSUWhuUf8191lS/woZhppIxoTnNXMUoJ7TQKbUgSLSAE8IucSMg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QWYzBscgiTXTqb90wy4w0NaoUX6jgJ/zaXDnypFqrCj75IWWfBpHJG8ZV3oQsL7AoLLcpu2UjXnSYPAy+tj2fHHZP5B7XNCfMcdwVrywBFWk2Q5HlG0bZMCaGQ2s/psWKzyBbw1XAoURVikpojAEU5ThjXjGF1W3l2pKERDoNSSbv5snge6KruTNKdW8PFaf4EwqwZEGECBhpX5wRIEDIhH0QvOjQWsAQT3LmeIQX6mOSjki4jgN3mTG4EjtvNvOjdMfQDPFojgM8DR6tGqflc72ODEEbm0nBEV0XaOEnJTy77eX5RG28DKhAKkE693VjNlXFmt9diWkNHBcXLI0JCwGthyFt9XbKthYROfxADCpyspJqP2vhmzIcQvrb+ykgBpr9rgYAUjqp21Yib45LXfIuoIsQT6O72zK18SPbbWyFFJrMYWqMkc1MTIa02jjMvH+wNgJurnUnJc5L0NDosMvV5hZ4iE+7xAMp6Hk8nUVFPBEQYSumwow5OKvvhuEz90TysW8dhBHwjhgOfbp+nNaTcmR+t+67Li812yIiP8RK8pfKS7IR0+YWtimLryWg+sSH0LjZomgNQNn17PzEKIcGYDWQvvxloqP0CvBOFCYeJUjYCJX5guiEu0wCmav
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca708476-be4c-4405-463d-08dda74552ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 11:03:53.6296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QqmdmNUbgdeU+XUuERTsJZl1AKzhI3RzjoQ/+ihC2iEDKTmyDtpqy+ZOo/SVZ2Ow8dvbRrICO4X7XJKzJ6+FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6661

Make sure that we can mount rt devices read-only if them themselves
are marked as read-only.

Also make sure that rw re-mounts are not allowed if the device is
marked as read-only.

Based on generic/050.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 tests/xfs/837     | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/837.out | 10 ++++++++
 2 files changed, 75 insertions(+)
 create mode 100755 tests/xfs/837
 create mode 100644 tests/xfs/837.out

diff --git a/tests/xfs/837 b/tests/xfs/837
new file mode 100755
index 000000000000..61e51d3a7d0e
--- /dev/null
+++ b/tests/xfs/837
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2009 Christoph Hellwig.
+# Copyright (c) 2025 Western Digital Corporation
+#
+# FS QA Test No. 837
+#
+# Check out various mount/remount/unmount scenarious on a read-only rtdev
+# Based on generic/050
+#
+. ./common/preamble
+_begin_fstest mount auto quick
+
+_cleanup_setrw()
+{
+	cd /
+	blockdev --setrw $SCRATCH_RTDEV
+}
+
+# Import common functions.
+. ./common/filter
+
+_fixed_by_kernel_commit bfecc4091e07 \
+	"xfs: allow ro mounts if rtdev or logdev are read-only"
+
+_require_realtime
+_require_scratch
+
+if [ -z "$SCRATCH_RTDEV" ]; then
+	_notrun "requires external scratch rt device"
+else
+	_require_local_device $SCRATCH_RTDEV
+fi
+
+_register_cleanup "_cleanup_setrw"
+
+_scratch_mkfs "-d rtinherit" > /dev/null 2>&1
+
+#
+# Mark the rt device read-only.
+#
+echo "setting device read-only"
+blockdev --setro $SCRATCH_RTDEV
+
+#
+# Mount it and make sure it can't be written to.
+#
+echo "mounting read-only rt block device:"
+_scratch_mount 2>&1 | _filter_ro_mount | _filter_scratch
+if [ "${PIPESTATUS[0]}" -eq 0 ]; then
+	echo "writing to file on read-only filesystem:"
+	dd if=3D/dev/zero of=3D$SCRATCH_MNT/foo bs=3D1M count=3D1 oflag=3Ddirect =
2>&1 | _filter_scratch
+else
+	_fail "failed to mount"
+fi
+
+echo "remounting read-write:"
+_scratch_remount rw 2>&1 | _filter_scratch | _filter_ro_mount
+
+echo "unmounting read-only filesystem"
+_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
+
+# success, all done
+echo "*** done"
+status=3D0
diff --git a/tests/xfs/837.out b/tests/xfs/837.out
new file mode 100644
index 000000000000..0a843a0ba398
--- /dev/null
+++ b/tests/xfs/837.out
@@ -0,0 +1,10 @@
+QA output created by 837
+setting device read-only
+mounting read-only rt block device:
+mount: device write-protected, mounting read-only
+writing to file on read-only filesystem:
+dd: failed to open 'SCRATCH_MNT/foo': Read-only file system
+remounting read-write:
+mount: cannot remount device read-write, is write-protected
+unmounting read-only filesystem
+*** done
--=20
2.34.1

