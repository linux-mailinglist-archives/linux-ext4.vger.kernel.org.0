Return-Path: <linux-ext4+bounces-8333-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F08AD1C31
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Jun 2025 13:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5223A52E1
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Jun 2025 11:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03711254867;
	Mon,  9 Jun 2025 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LmmUZcSC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HuVEICpr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCDC1FDE01;
	Mon,  9 Jun 2025 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749467104; cv=fail; b=gmnOzZf7j6ViZ43oeSzXvecgtjc3D2aoitXrOrdXES3YUpe8ROQsl2IlsWbDZ1FnJhSv88n6Hqu1xCFMT5gXJTu3DM7qE6/pF50Uiql3COSc/hZYLBYHGZmyaG9kyqLPKdDcJqS2NjMom1M4PzForZ6tG3kjemWAMsedK/7mlEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749467104; c=relaxed/simple;
	bh=I501k28G4j21NbbqvKquQT2leKgHggVQIwi5+HxLFKM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TKfdttFvwpMjyhLUsXBkvEJGuvNTb20dPYt7knTXLy5MhYsbRGeRxtW8QvBcjxiT0Ku4fuQ46PHKDSMmJ3Fnu/tPtSzqXi5uN7grnevWpcEXc2ODBybv6yavgumiIQ2lyBcVdyXpE0Zw6vNPyE36/kTzbRW1P5LV79T3MwKInp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LmmUZcSC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HuVEICpr; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749467102; x=1781003102;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=I501k28G4j21NbbqvKquQT2leKgHggVQIwi5+HxLFKM=;
  b=LmmUZcSCQdcNyvuqs1v1Eexkk+xiGRqZfUkGvU+fhPFyO5cTycoKI6h5
   aTt321nudSQG7Xy8+bA5iZnNUqt0/FwTBipbNDh9UXeS5W+GejrB8fIhe
   jedo4nHkY4oGBUhZpzR1sI3Dn1qvM1IXgEo5I7ujoLszuFjTQI5B5nPKq
   gxe3FIi0Xy/ruMNx4JgMAlvSnTjqdnCyw5EPlzSQoijzVqLhuPIgbU1TA
   x+RF6IRIMME2+WTvR+BgnG0BkW1ygWj5HtKWsbqXBCqqBdDIDvoweVLDE
   SDZ3N0YvnYTgaCMXM3EaF54mOiUWUv9aas12NyDIuRujpLQKOCQeSsreY
   Q==;
X-CSE-ConnectionGUID: dqZd0ex2Qv6H76xS2HALfw==
X-CSE-MsgGUID: +f9ay9WERia/KzUEELs+2A==
X-IronPort-AV: E=Sophos;i="6.16,222,1744041600"; 
   d="scan'208";a="89171340"
Received: from mail-dm6nam11on2086.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.86])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2025 19:03:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGyRasfzlGO3Eu75D1OgFWkFa/nKeuFVgP8kAZQniMyRfnWBqA00EXpxi8fKa8zB14thUkh+9lgc6Ptf0wN5ZK9X6Hnf5t0ymZcrdBlPh3xtJSnbiHIYhPm90QV9/HXlnoJi3/VqsSIkQkBMav5tYK/0bOf4PUws8U0GigDfaHC45yXSvVf5JU/4VNI4SqjZoB6/6HWWOVjN75rqONHpmw6P6DDHqnn8mCfFAg9StuOW+tHDAIXnDHdm5J/Kx9MdU9OLoSH15NUwIiNBF9/I9aWWtDrXxHEGiyGxwdN4/Aj3Zvi/t8CCBqhrc4C2KYtZjW/rjimOqmU4bp6yaZhrEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0gzIS3UYyAiZZYsgcklG5GrhQ2ERaAF8VGIA+/7uOU=;
 b=dxz4hfKpnZ9yP3CzfAzxwW0oT7CdbHE0M3oKOZVBVftTTCMZDTrrzRTzNfvFlxCWviCM88HqBH21sZzRl/2OQPopWxNjLPqURSfGamoAzysr1KOMdOBWHxQj7CFK2O101ivtIV/uW82RMYnu1+ACwWPXbjisOZAjXKGjfwDhe7lks0Uuk3BJAU7mx+9FBcQuWe6OlTcMtGeoASRZlxplUt2CktHf10YqkjPidsHgL3eLuBmHhJepiZ+yrDVcOGC/wJ2wF4+vvtqAcH6zNe8ynTBCMkfouC/4XTvGPiMiWpssH86P+sXLp0XNZ0EjJX0TbI71SSNJP8ZVQRw58SHf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0gzIS3UYyAiZZYsgcklG5GrhQ2ERaAF8VGIA+/7uOU=;
 b=HuVEICpr7DSm2aAnA5Nh1tTIspWC0h+3hDMclj1ErG/9QiGT1yby0q62w60Pb5U8P2hUYf/R1ZkOeciyo4Ts+5Eu1t29qgy2OK26OPh6uQsusUu7rA8ZRkvokwF7zLQROYDkMqR3tgTWtT1Mnp71v+jMnvqYvaG/v+YO+N5uy8U=
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
Subject: [PATCH 0/2] Add xfs test coverage for ro external dev mounts
Thread-Topic: [PATCH 0/2] Add xfs test coverage for ro external dev mounts
Thread-Index: AQHb2S4vQ8MAjKKR7Ua1ke3t/7Mang==
Date: Mon, 9 Jun 2025 11:03:53 +0000
Message-ID: <20250609110307.17455-1-hans.holmberg@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|CH2PR04MB6661:EE_
x-ms-office365-filtering-correlation-id: b697ff63-447a-4747-3005-08dda745524b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?znW+Q+NiDkLQTkfiB7wi/sfgEqzU4dG20qh2G+Ts0SVuk6D5BZWNhZYNzJ?=
 =?iso-8859-1?Q?cAb8eklEIRnq0DA99SctCMW+BU+ae1vx1pg6LRJMLaTshoyF3JIx+KnsR4?=
 =?iso-8859-1?Q?R9oqpdHYLozCWwfrEdHO5564ehucXF2DWHNP4JwZe0U+ATFxnbTqrzosX7?=
 =?iso-8859-1?Q?NLfvtXpGFFlLbUIgGrCd58ls4wNA/EBSvRngUzQ+XjCMFaV0s99Aa3vyax?=
 =?iso-8859-1?Q?9OKVjjhyW260wZgo33Mi4ZMncpTE//TjdXcgo3LsQouaCG5Xg4QaAlgwYu?=
 =?iso-8859-1?Q?pVlW3hd4I9dK/a3Wvz3GNDuPDl8neoKprJZ0DHF+fCc5nVfBeqfGA3FmIh?=
 =?iso-8859-1?Q?ACGnxpYLiqxFvMWO8qRKppifB+EF60KQJ4Tn8SP6RXNACrBU1Y+4YMK3P+?=
 =?iso-8859-1?Q?aYdqTHosq0LBOKgVNDk6r2gGb/01dUMUGaTRDarr9JGvZiNaCy8G6Wv9bP?=
 =?iso-8859-1?Q?QdEaraI5Q8yyl0qhy/vM+IJsIm+u0yLdU5oIFqZPQluyypE6Of9I2C7hvA?=
 =?iso-8859-1?Q?ERAVpQrAiGr+4s8eSZ5+uJesuLgNzCDBLkT7K/jkCtFNtGq9QVGMl5FKNs?=
 =?iso-8859-1?Q?fLC79cio4aB1UykYKGhsp3gLEY7ewtKShmoNQwY1BBFd0lSdY+qRyuEmKr?=
 =?iso-8859-1?Q?H20naZrqnyFeLELc0CAljZY2HyxQXLjHXYSMEIVpmihgAfg0DC3aUMxwF6?=
 =?iso-8859-1?Q?GB/CJuT50n+ZEjn+rxpMP3s3MiTa4mHMLtrqDBOLwTdWSiOXspwVK3h/jE?=
 =?iso-8859-1?Q?eCSQR+otAtMdxU8pLibYu8NCEJHK6KC7axpZoBm+ikDaMaG7G0/NJXfw04?=
 =?iso-8859-1?Q?OXQZUBGDWjeohiADCtFl5ldQtksDbX9kPqWlWNF4FKYQMhWvW7B2THsVky?=
 =?iso-8859-1?Q?cvvJCgG4ChZZBOqp/NWnzPGIsxCnSXShI28FlvEpMv2MOyX/LaMz010JDN?=
 =?iso-8859-1?Q?A18uVQ/12Qdp+ZLKw08NMFWaljZ9j6e+dkCxlnCo/TzHPESWXLam/QGyET?=
 =?iso-8859-1?Q?/DbdyexxgOzsmuZSknmv23dO4pfEI/Av4jaOQ4+Z3Un7XEwfZjA7GUyI3i?=
 =?iso-8859-1?Q?0KKZATsX93sEmTiFswb7KuW2oSjrpMwNIdbe3BswnIniRRcA3jkeMIQCqk?=
 =?iso-8859-1?Q?BtLUs4Opo9rwjNnPrsNwLvSACvK9wS6la/D3fETXAfz00FKKTuoq2a8xeL?=
 =?iso-8859-1?Q?0NY/t4YC7+c0VVfwDtmXla06hfrYkhzU/KErE+b+iSOZj8thC1wiKGucmg?=
 =?iso-8859-1?Q?oWAH3gbB3N4Q8uf+ILhZ+Za99dMeeElUBtsnIfg0vVC+vpeg6QqOr9Qy4q?=
 =?iso-8859-1?Q?MUXu8QEupx/M4mAOWBjZUhzMS6tjFfgBLU628BKI4oTUDnnLQZRxIcqtoo?=
 =?iso-8859-1?Q?CCtViDca2hDiLqrbuVYwJkC8AKS+I3EHes0GUW7EMySD/Y6dkySLuhQk64?=
 =?iso-8859-1?Q?tU5CrAu9J/AkHZbobsgqK4YWIWr+ilNniNyPCAtjtHdnVTfFhuukcapsxX?=
 =?iso-8859-1?Q?Rpz1ecROvx2EvNaHACdxT0aapQdmFTkIUM9zASQSZ6mA05WhMrbnrybnRS?=
 =?iso-8859-1?Q?chA7se0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?JbqQHDkK+4NG4yjgtvN2etHqs+kbEd2nplkMYKTeE6us7BaTdBXJfLM0gP?=
 =?iso-8859-1?Q?VqVdGmOSjAe9QBGKsHkqvh0pIVEI6+BfOG23TPDF7NaMQuicyPJQbb/aDA?=
 =?iso-8859-1?Q?rM7NgsybFM2+qraLB7heNizor4kbYwXq/hGU8l+V/PVx7pcIAnGlgYlgDc?=
 =?iso-8859-1?Q?XVkTnhLKGCG4jRvUkNtgUagU8UicYxP1mgv0mp+R2cQIO9yD/I+aUugDzr?=
 =?iso-8859-1?Q?JnEPb3tUV29+8YIRJxIuNLotCt5mMRvrMSMbpivSYcXZW2mx5S+4GevdYI?=
 =?iso-8859-1?Q?v1DvhzSlNFY2pK5+fB9oBb4h7B6ODY+M7MXPD4n12cntVwpHHmx32axPPy?=
 =?iso-8859-1?Q?6+MC88QZn+enhzax6DBOK0uBAA2tz4QypJj/wPCBVDitWBIG/iVtnGHMUB?=
 =?iso-8859-1?Q?0SB1/m7Uj2RPlu8uLzNvIAXah8euYZY9+KewpWKhNL2vZmmQRs23h9mGms?=
 =?iso-8859-1?Q?aPReewlChGGURaS7IW+xFYl4CniIBq3Kv0SqXGXLTll4SpB9IW2wccaxdq?=
 =?iso-8859-1?Q?uosjEevGEkgQJS2abjgxeXiTu3uXwG692RhJYH1uUO7wMzNxchHoUW55ct?=
 =?iso-8859-1?Q?L7rDoINlsI9SCwq7jnM27FAa+2b1nslcIbbHA5kkP5nDOA7Z5qaDAEFGdN?=
 =?iso-8859-1?Q?Z2Lm4uljb1Qi2ya1ZxJ6HX8TR7e1kA+jjPihNq6v3AILoa/QruRT0QqeYH?=
 =?iso-8859-1?Q?iH7xGzvQY7R+IRxkLS/AGmoMqfm3/xwH/rQ3/NOj8dtn74N8aZZFHI5ecu?=
 =?iso-8859-1?Q?FGuqgGDeNicILQSfCyyNaUNHtnMsIFJk7CcclobKnZ3hZU+bYbxoZi6tFH?=
 =?iso-8859-1?Q?UOufHYWpRSvQIK3fap1JuH8TEo3yQeP6gtumrUFSv05uWnrwc0MEdOY4f5?=
 =?iso-8859-1?Q?CHt/fD7FfqfO4zA/IVreN1xj+fqB+VkDNtAUPcahjRhKHEX0QSNzdPzOR+?=
 =?iso-8859-1?Q?DvHKJ0UTo/dk9CCINJVPahpyTKQtjdKcQxWO6d8ivlaEfUcMZIx1d8zxU+?=
 =?iso-8859-1?Q?veEK1W/5Nh4tX60GZpWwewB80lwpOwWIJ7zu54P7xyDkd8lGNqUUQMmKFk?=
 =?iso-8859-1?Q?ZZEaPFMyEUj/d4nlaop2cLzRJ2TX21g3B5VfLLpf6FXbpxu7dm+0fCteLl?=
 =?iso-8859-1?Q?zpxQR6745h9EJaQ4mAEpmGs243m7pGQLAlOtea8et/RO7zyuawaRgiACh4?=
 =?iso-8859-1?Q?X8rqJGHfAOP2Ig8wRXrQ2VVWrQ8h5NCAx7HxPZ7sRhuj0ML4PZi79QiLB+?=
 =?iso-8859-1?Q?BhgCZUSLrqJTSzVYWLkQB/3jnOTtXW6U66HGSbmhcGQutSR67E+vfRCFm/?=
 =?iso-8859-1?Q?s46HoAnShFl2afXkjb4ci4ReVNJdbUOA2hYbqz2pvH1fCpRzhwKF0lO/tZ?=
 =?iso-8859-1?Q?fViCFiSSUuxm4aUJXv3xqIdtmmZzKOXP6LvjrCIBskPSJADR2MZzwlHQao?=
 =?iso-8859-1?Q?RLUp30Yhmjk8iQh/l4fiwlkcQ2IvNXRtLv3pt58uullqBo/zjjDqS/Pb2R?=
 =?iso-8859-1?Q?sO9ZeaXxGjZTyWw7eb1xNyEAyQvRp+aq/pfgb/yM3giZt+4T16croMUUBa?=
 =?iso-8859-1?Q?bRNXKk2dTFW3vuuiPdrduhVGLhLwSY2XwXsaj1Ev/h/frZzhLrZZhIIG9/?=
 =?iso-8859-1?Q?Rl0CdSckGcuevIurUKOXE3fTbBrTkqj4Ac3JbO4iVd+h2N1ypyMU/QYw?=
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
	p4pRVOHw5l6ogOSreVoP2tR/fGve3Pcp3U+pA1ShiPndBCtkVgVkIuadYrXGdaXQJCqSXgFQ5Vab9RHNWP5qp6RAmKZ/QYhqZoPsESxPfa1AkZqRhaF94VCFo9lB7z2rW4hcXCUcp7mrcozCUZOh+oTNDQDJzIsrC2oyFRYk87elp7ADM/2WypNj4c7LIarwuzhS3MYgQULGTlcnbi0oaC9Arx1u7aMS2YX239oZMY90wnnKbGjGzUcy4fg+MCwxD233h9F5oeX+Q6qxHg+SE3uLH24FY1wZJ6Um8fW9eLL5PijrT6Ve5flgfOGflok/KxAN9K09Uf/aalWwBAm9ltkJ2LG0aAd2I+3eZsNzSt3T6ETBitvF8l5YJci0t7GYtBohjVvQ1qTamLzeraiou5dzVV+U6SDGRLfkJeXC3fWaHF58ee54KZWGMqXm/Za31DTv1slzxF1c22S3ufTOBWhQuLTzgdFBhf/aOp1pIaOkPfQ+iiHxF+1tflBFjlhExkuA56+7Qt9rtFMHzt2hsNR2voCbD1rO+ygRgpmaq1me7ikpSl4FTZA8iuxIITmltes/407sU4VBOhk8OnY8G5pFcIDEdGD7z5B+FNGaEwGfqbsZuMAgG+pnmnrVxUPF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b697ff63-447a-4747-3005-08dda745524b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 11:03:53.1383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J5e4yS4j2jmS/hqyF0Lgy8vwH33YCar0yljxtTuZDXT9+aJqDAKnl2lRzMNBKt4fQh9MNZU6vFuK4XP7udePeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6661

These two patches adds test coverage for verifying that xfs file
systems with external log and rt devices marked as read only will be
mounted and remounted correctly.=20

The first patch adds test coverage for xfs external rt devs.

ext4 already has a test for log devices that can be shared, so the
second patch turns that test generic.

This is an updated resend of these two patches:

https://lore.kernel.org/fstests/20250425090259.10154-2-hans.holmberg@wdc.co=
m/
https://lore.kernel.org/fstests/20250502113415.14882-1-hans.holmberg@wdc.co=
m/

Updates:
 - Added _fixed_by_kernel_commit(s) as suggested by Ted
 - Made sure the the new xfs test is skipped on internal rt file systems

Hans Holmberg (2):
  xfs: add mount test for read only rt devices
  ext4/002: make generic to support xfs

 tests/{ext4/002 =3D> generic/766}         | 11 ++++-
 tests/{ext4/002.out =3D> generic/766.out} |  2 +-
 tests/xfs/837                           | 65 +++++++++++++++++++++++++
 tests/xfs/837.out                       | 10 ++++
 4 files changed, 86 insertions(+), 2 deletions(-)
 rename tests/{ext4/002 =3D> generic/766} (91%)
 rename tests/{ext4/002.out =3D> generic/766.out} (98%)
 create mode 100755 tests/xfs/837
 create mode 100644 tests/xfs/837.out

--=20
2.34.1

