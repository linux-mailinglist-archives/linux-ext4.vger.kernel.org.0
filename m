Return-Path: <linux-ext4+bounces-8335-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9369FAD1C34
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Jun 2025 13:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B555D188D4A9
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Jun 2025 11:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555AD255F22;
	Mon,  9 Jun 2025 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Grv0gC0o";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HkhIoJAp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599AE254AEC;
	Mon,  9 Jun 2025 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749467107; cv=fail; b=FG2xQ0moqkY7ibkotaw3R96EoTcFGthEhTXtN9Ftk9LFM9v6fjWC/MExhvfIKz3/tNXOAwFViaBby3MBjYZEtVoKIzu2hAB168ld0T2M8aZiJg/OrDkfUE/5Z0WIqeWcnyMc1Vp2md71gxL/ErXl3bcViSiUaS6uUp2WtktYUEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749467107; c=relaxed/simple;
	bh=TMJ281V535F1tUkIhNX6GHrngp72C/rIqmmPtKhapgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hfbr8RA05mxiMxJ1gFjCkkfFun1pj2M3hAlHzvL84HFw75S7BIp2yFm9qNX+9p7RszMcth3L701kIBXeMPFIpvcrOyhZsjWC+2Gkh846lai9CcbPi29Qda8Io6k89J8czFPVmoK8jr3tG7IQVEq7zrX1kx/09vPzunhxYjZJ1C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Grv0gC0o; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HkhIoJAp; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749467105; x=1781003105;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TMJ281V535F1tUkIhNX6GHrngp72C/rIqmmPtKhapgI=;
  b=Grv0gC0oOlO0IgGnz8xaJVFB4+04QJoqWRBAkDGojyQvqc8TaPz76haf
   vr4NdJSNmU374zGfQgvGNd5JAq+cbHy+9P4UG5rfojGGN/t76YaI9RH9b
   va/xfcnF68v7ZY/kTFRoQrjDMDb1d+fn4b0wUlOSD43UIwxuj5UVDEqBd
   gYObn1Dbl/kqqDZXcb9eyPqmwnPw34q1eLrv6o/zvZL1hm7gzCfZJj5RY
   ecCqLx0RrLc+9FSVNKNhI8dSXsKd2upAX2eomSRmVi2nd7Og8mHvvkCwU
   LSHVk9jYFftrkYLnx/P+xyzVtPB8UP4WmFmNUB/0djAAE8+Pa5mANeh6v
   Q==;
X-CSE-ConnectionGUID: P60Wk7QzRk6pYxR2ryAG6g==
X-CSE-MsgGUID: iFh3MHTCTj2Xv2eYefLyvQ==
X-IronPort-AV: E=Sophos;i="6.16,222,1744041600"; 
   d="scan'208";a="89171350"
Received: from mail-dm6nam11on2086.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.86])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2025 19:03:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8Rjzqn30ZfhBta6vJFmrc+Hmju1FY9OPajet/b9npgT2/6S3ksLfJoyaJmJ9uiUskC0yujLdP3N3+VPIF51maB36YBBkc1dBNjcogVMLbSLT5yrYtB8uK1oJFn1s4wknlAa+m7Y0ZXcFpUNsM7vGc9F5gE+i5PPVZxpESiDRB1B+/5LivdF9ynTfWEFac5OdU8wPjynP5TorFxgUSRi2EaeLjGVow02ZQ+DcYj997G0wmq3Pm4IeEgOIc80wkQIIKPnSy1vNA8vu2O0KLxo6Hj+HylEWN7Nu+aeqeTydiRJJ5VsiK4L4cta/fkc+Kk7fcSFH0+6FB/TVRvDFLeH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMCyVMSY7hTk9rJDoITM9v9HR52AoYC9NvhrY8L77tE=;
 b=gFxgzpsolGDT6XhMVAGegsrMvQ6xJrzYBywcn4yurZQ7zQR16Jpi+MwyaCrp3jrzUbCHItT1s5Cv48t/ofG6He60fJPlGNkGgZFU8GlgfjvN3RWoFLwCi/+lXi4dVoGpjxqH/m9AjdKydn6VsDG5EYb+ByKHgDytOtWchgboUFx1VtMXWsdmEDRdT+Jh9TLnVI9o9YWW+58mVMx0EiThxEuupJxAuoSRSGxUe+xXmUtjbjWCU3LdhFNu6zWxdNSOweUuoyPxW3i5T3TK9NlJTdUBfRB6FTjwvTnrcsrrAiD9+HeCqK0crlRZADGiE6VOHoBdmlQW9iKIOcJ3K+WHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMCyVMSY7hTk9rJDoITM9v9HR52AoYC9NvhrY8L77tE=;
 b=HkhIoJAphg/HKdVOGTaLo2QWCQM6rd0ADM5x1ZMOACJwzn1FuFPc0P+XW8JNvZt2XsQ1nE9+XkphC4UpJnYuB19i+OFQgjb/hz37yMMHVYXI/cEwFmD9RlauHhh9yv4DLIvRHdSgzIWCi18JU5qrpo1DGNw7qW4WdU+7nPMylgA=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by CH2PR04MB6661.namprd04.prod.outlook.com (2603:10b6:610:9d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Mon, 9 Jun
 2025 11:03:54 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%3]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 11:03:54 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: Zorro Lang <zlang@kernel.org>
CC: hch <hch@lst.de>, "tytso@mit.edu" <tytso@mit.edu>, "djwong@kernel.org"
	<djwong@kernel.org>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>
Subject: [PATCH 2/2] ext4/002: make generic to support xfs
Thread-Topic: [PATCH 2/2] ext4/002: make generic to support xfs
Thread-Index: AQHb2S4wUjfODxsgnkaW7bndClwJ1Q==
Date: Mon, 9 Jun 2025 11:03:54 +0000
Message-ID: <20250609110307.17455-3-hans.holmberg@wdc.com>
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
x-ms-office365-filtering-correlation-id: 1b07ca42-d0dc-4ea5-075a-08dda74552e3
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?7uWkXpYfrrbJlpoQyM2vXRxF4tBCHZQJibSggTj/XaiSVTs4X6skiHZUSM?=
 =?iso-8859-1?Q?fYcjNggR0SFur+WtLwVtff0/ey9ButJbcah/gbdtPVyMEyz0vdxkfdM7yl?=
 =?iso-8859-1?Q?hEBuKAZ4mnF6oQ/5Y2IVuAg5hiVR0bt0cgloGE4zu+LPKGk2oC77c3AQpC?=
 =?iso-8859-1?Q?GNQJQXQi2GIxQqAmUHlpeHECvetIFlIMaRDyMkhbLzxtAcLKTcSeHc2R2p?=
 =?iso-8859-1?Q?L5iZZFl+DaMVJ3o2k0rOaItjOhgLMmXXSdCvVh2EuapiFVkhaiIxEWnKyo?=
 =?iso-8859-1?Q?nZBVMyzO+p3qahfRfdfLad8Hc7Z8ydrLjtz/DyzFTu8x4Q5EmiYWkjRoxe?=
 =?iso-8859-1?Q?lV7DFgs6xvGavyo6AnLgticJmI3XgIPZoF2rMT8scT+Vgzj/u1NFGnAiJh?=
 =?iso-8859-1?Q?mNF0GcXOesDNTo1a1tQzRE6Z/lmdM9KDNBXvhLodzEmCUQZWcyHG9E0Y0v?=
 =?iso-8859-1?Q?mAUCKUo4FL9CP/kh+WkZfoaqx7uoHdZ7oZ/opfKzVT3ev1e0gHUnMeJ3eB?=
 =?iso-8859-1?Q?vvyScE+twe6ABp4vao3i3BbK2RQ3+hKmYVUtZCI5ZsjTc6RUKNYD9lw7Cf?=
 =?iso-8859-1?Q?fEggCawEX/K1KmpJcD6LGW/2TsRxgP/iYwCvCtHoN4j2Y7ZAVrL3oxzD5d?=
 =?iso-8859-1?Q?kU9xKtuxhoKe1JphhDozEZbSdmU6tohssJJjAa3ygdC2AxO9osbq/st6Rh?=
 =?iso-8859-1?Q?JyxNY8xZfhR9MdW2DUlCU5KA9RnuaFdaebcKjzZK51P1ePEUhR3vdpZRxE?=
 =?iso-8859-1?Q?b6ylhZ/14bddZXXvskv1K8JfD9HfLUtskv7qHDD2bAQxbPusCOKhDsTdTT?=
 =?iso-8859-1?Q?VJsxD1EJ+pOYVj4GE9A6Tj/b6BmRAkN+yuKsPyh4co/5NUVRXdqOZF4XdX?=
 =?iso-8859-1?Q?FofS06BnxN4tSlHJp3Q8Hnpan2DQZjYMsSTiKOlctFygmk9Hw7uFRz3fxt?=
 =?iso-8859-1?Q?T6bWFwu1U1jmv6GmzVRBLigaV6v9fU8IiJEjhaN0jrPrALeuqsnXilBY6I?=
 =?iso-8859-1?Q?cRcprViN8bDV6gyIH7mB/FwcQ8Fom9nTzxerJggp1QGN7G31w00kNk5GP/?=
 =?iso-8859-1?Q?FKDiwod9liFlqqZ/0Q+t9Co63w5bZNECsPNqizzgbPoyumDphSyQVf0avP?=
 =?iso-8859-1?Q?hAtXPK4s+MPa+91U6FTHgi1xTTk+4R8C6XgZJUSHjLaucjBRQYH/L88fLD?=
 =?iso-8859-1?Q?Xb8g8OaO0+p5feIpWL8wbVXv04Lgow5FA4ydyapsJy8djjo1/+nvOITNGb?=
 =?iso-8859-1?Q?UqHkfTcwn4jOkR+VVK6fjpayGzoCCMuk4hUKvdWnLB1BK8GPNeqfhsL7uj?=
 =?iso-8859-1?Q?eEpsRFZRsY/6nSiRTNd3ExcWJyAxNFC+rxClgmAKepJVKcYRUHBx7TRw0f?=
 =?iso-8859-1?Q?Y7eP5Sx1J1aAglzse8tGPFLfX7NB1+VVX8sm23o692H28icsSYD/PidObq?=
 =?iso-8859-1?Q?Gy7KIAxPU563uJtDct3IuQPE9zIMlfoSjqY3dFlbTPhdgwEV4eAosROjl1?=
 =?iso-8859-1?Q?JnTQ6ZRxeu9EVQ0Qn5hDLrhlh/+IUqv35YI/lxSpRUp18KN4xMk4HEJiW9?=
 =?iso-8859-1?Q?nJVRMGM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KKVGJ50SsCrcCxq/tjua4oEB3Neb5FROyDIhlet9We5HC6wEgSlSOsIFK3?=
 =?iso-8859-1?Q?Yp7tmJ6xF/sER22F10lNxJSX3mdnPXY0DMEyTvbp8CbviY/CRhmGqs5D9h?=
 =?iso-8859-1?Q?BGPNKiHKsS2EJywPlLYWNcYyOnZg1CQp20ktM8EbGc2dKQi421eW5mSqv3?=
 =?iso-8859-1?Q?V0B5glZdns6CrDQYKgs1dbbiKyil+0RjytXBRN6r26Qz2H1wZmnobPzVsF?=
 =?iso-8859-1?Q?QWvy5/1c/6O3TQJPsWK7bj0QmsZgJV9JIoUU1bekTVDv8wMadoVvBGb2XF?=
 =?iso-8859-1?Q?RtrwNwAcMPPClzGruelKo0GZdaXPZP5lRyxXDOTSchyBEKQ7kHR5I40IH6?=
 =?iso-8859-1?Q?XHUOFFKizTxiZVHw7PNHYehV4Oy4uzQkJObiQmugDh6myHvKfaGrZktHPy?=
 =?iso-8859-1?Q?5g5+WcGTWJbHG+/Bfc7E1WC+Q8SPwcFPx78SUvwJg1QuXFj/DS3EFWwPdo?=
 =?iso-8859-1?Q?2s+Ekm3MB8rnxRfyoqiupbUjm1jRwzOMXmcCo+47sm25ksI8F7NfcZoWli?=
 =?iso-8859-1?Q?tgshC4q9+ArC5gewtPyOX6A3ynR0DHCinSGyPLk4h55+vQhTSSe+ZqD3KW?=
 =?iso-8859-1?Q?eE6HKcht14f1Doo4Dd///lWvHTfYKwYfeCCv2q6lZgLucDBpTeKNYShXRx?=
 =?iso-8859-1?Q?SKFEo7Duz+EAD/HtQZwO/FFa6GXZjSKbybHViFTsNm0XJJFPGXK3lNy57T?=
 =?iso-8859-1?Q?DylOZOH0EWL87uCS1AJV9oXBO2y3VswvZ6vVMilKyAYOteuDrgiqDhm9PJ?=
 =?iso-8859-1?Q?gfpCylSjoaqUsiF+MEVMI9iZOxfT/rOdfjNxjuN2MhSYlfrWTqbuSwH+Hp?=
 =?iso-8859-1?Q?Q4Dg3pRblPzQP6Ebw95Y+DNQkKwXfqkFIRBQrP4WQDGymQrdAOAitSf0pu?=
 =?iso-8859-1?Q?IOCCiuatYj+IOVEzRbtp9xK+/DnIBQt4SoGjqWIfGhyuxrntFyxBJWAYeN?=
 =?iso-8859-1?Q?OZ3yOxBHNhmgQZlQJiWtO5YiNNzzIq13BkkYl3DDVW01IG7sB0xZgOjeZ1?=
 =?iso-8859-1?Q?6XoEIQ+atx56Wv7tRUNTyKUz6XAjxX2yVvBe9JFZvi+v6gSIXUcCdQg4Cw?=
 =?iso-8859-1?Q?vO2rhlCzoETtv1Ti2MiwVzfsoY8WRCzLCa1uOxeRTsT2Bpb0RmgvkYKctg?=
 =?iso-8859-1?Q?SO4QqYCI5SLz0MmoFDXykxoXmRrYYNK4Nv/mo4GZqUfbeHPaEU1PHeWu8s?=
 =?iso-8859-1?Q?QQYqCcsvl7dUXfvA8CR2Sss58ZcXQQV8bzr4eEg4lYVVePmRD5cE8iroHS?=
 =?iso-8859-1?Q?wpixpERToJ0PgTT91f+Vmn8OLzxgYTyHkO9550Wxxly2xeTREbC1BhLhJ4?=
 =?iso-8859-1?Q?Hkoc4R3k92LYERmMdXnock+t+fvd676Dw/QBi+AajcpUR99eWUyWkkZVg9?=
 =?iso-8859-1?Q?ARKENgNaaenkunLNYNzkkdlajxjzAmG2JjZfxS/2UNw2lStax2PP/g2xte?=
 =?iso-8859-1?Q?zAJnq1FBZVHVLx9DGcCiQg9vbWmcdxzbl60WV12myCYbzxPxByn+TZfe3y?=
 =?iso-8859-1?Q?i9Bf8kbeaoZO+TbRR1Dy9dMRMS0ReIMh5GnK5/Zzo5BhBpC/kh7ttrom5e?=
 =?iso-8859-1?Q?3I5YtmUNI9oSixkfcNMXFKMT9dqyX5BDIrBiPopk+UeD9WXwdu1D8sM2uF?=
 =?iso-8859-1?Q?cHx7EFylcxGMO/vPJUn/ruR1eU2p6/NF3kSU9FkalgLbOrOD9NEj/HdA?=
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
	otX7c3EVhrIYLp4FbQMw0eNlnW7k9vqBPetWU+koiQCPeGctVdcuydknbPNI8wQzJj+w6c/19ZFwU3Z+kCFnUYGYqL3Jd1KVSoVTdw/e+JZTkrSBnOk945S1PKAH20LeBNc3zoYerOALDb4a9ZODjS1lg/xuf7amosM8WE7m8ShDzIh1BT3Dfsba8DbS164UT1O4rWaWLljPXNf2trcJCN5ipDDfb3fxgcZLtQjv/pw5PJ94kKXbGiSuro/i78nbwnadXUCoa8ZY1M47pfBqpb2EdKgQFBioHGeya63rwbK1y78/7AmkfmUqNqC7ifWLIR2JYm2TqBafhhvnMUtRmnAt1lGdF2eRR/by4dQ7c9Aw2k+0Xj2XoUshWXeXqCX7KFrJ3MX2MSrC9M/k1uzGkgLnjlEUguY/sOpL9hkGE30bNjMvTftK/DW4AHxj2J6OvttYyxAIif+MV72X1cB9K5vxjnuB0IxZ2/+csFnoieN7hq42NrIxUb+us8zPYAjT5/onFpeHCr+VEa+q3RnwTPBiEF4GTOQMVl9N/fVfwO4L1+GgrmRvLQ6KjjBnbUu5yAxeFx0FujLRTKD/PcU5vn0aMZjl0LoCsFWDTVzxtE+/9ekF9l3mdRsHyZ3fZF5r
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b07ca42-d0dc-4ea5-075a-08dda74552e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 11:03:54.0657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+b6kQXZZtuRXoRcU7pI9NkMNE2d/Se/bSz715uJJAmGwfo5x/zbyWXZclrIjM3qz6yCg07TErzEOk7cckgSUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6661

xfs supports separate log devices and as this test now passes, share
it by turning it into a generic test.

This should not result in a new failure for other file systems as only
ext2/ext3/ext4 and xfs supports mkfs with SCRATCH_LOGDEVs.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 tests/{ext4/002 =3D> generic/766}         | 11 ++++++++++-
 tests/{ext4/002.out =3D> generic/766.out} |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)
 rename tests/{ext4/002 =3D> generic/766} (91%)
 rename tests/{ext4/002.out =3D> generic/766.out} (98%)

diff --git a/tests/ext4/002 b/tests/generic/766
similarity index 91%
rename from tests/ext4/002
rename to tests/generic/766
index 6c1e1d926973..3b6911f0bdb9 100755
--- a/tests/ext4/002
+++ b/tests/generic/766
@@ -3,10 +3,11 @@
 # Copyright (c) 2009 Christoph Hellwig.
 # Copyright (c) 2020 Lukas Czerner.
 #
-# FS QA Test No. 002
+# FS QA Test No. 766
 #
 # Copied from tests generic/050 and adjusted to support testing
 # read-only external journal device on ext4.
+# Moved to generic from ext4/002 to support xfs as well
 #
 # Check out various mount/remount/unmount scenarious on a read-only
 # logdev blockdev.
@@ -31,6 +32,14 @@ _cleanup()
=20
 _exclude_fs ext2
=20
+[ $FSTYP =3D=3D "ext4" ] && \
+        _fixed_by_kernel_commit 273108fa5015 \
+        "ext4: handle read only external journal device"
+
+[ $FSTYP =3D=3D "xfs" ] && \
+        _fixed_by_kernel_commit bfecc4091e07 \
+        "xfs: allow ro mounts if rtdev or logdev are read-only"
+
 _require_scratch_nocheck
 _require_scratch_shutdown
 _require_logdev
diff --git a/tests/ext4/002.out b/tests/generic/766.out
similarity index 98%
rename from tests/ext4/002.out
rename to tests/generic/766.out
index 579bc7e0cd78..975751751749 100644
--- a/tests/ext4/002.out
+++ b/tests/generic/766.out
@@ -1,4 +1,4 @@
-QA output created by 002
+QA output created by 766
 setting log device read-only
 mounting with read-only log device:
 mount: device write-protected, mounting read-only
--=20
2.34.1

