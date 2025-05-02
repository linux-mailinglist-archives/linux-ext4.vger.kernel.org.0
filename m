Return-Path: <linux-ext4+bounces-7626-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A031EAA70AE
	for <lists+linux-ext4@lfdr.de>; Fri,  2 May 2025 13:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07560177C2C
	for <lists+linux-ext4@lfdr.de>; Fri,  2 May 2025 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EEA23C4EF;
	Fri,  2 May 2025 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GJ0GbqFW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nI673ejS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4591BEF77;
	Fri,  2 May 2025 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746185712; cv=fail; b=nz6gVDgOcOHZCrirZ1188r3TcVjsHnTYMMu3lvjNDpdSzl+pojUF4yqSArFVrYZkwoYkaPlYQzmH/wUhwaypwO+iwIBdIApFHVgp/4Y6ZdhNzIM81IOVawOUD1CDoqr+Mw+hn/AxSz7wxuoyfV6IRu+9SnViVxWfND+4TU8aKNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746185712; c=relaxed/simple;
	bh=NMDQR/eqwp1ptOzxQfI5e3ToeTF8zz9Y63h2qPS8qIg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZnAcFrlFkjWNO8ZC0+QR+JogTFF2UEvlRSbrc7sxIGmZ7WyU1WeuCLlg1S2dh/nZf0FZjjAkT/CcsQMWFEfkVAREoeOEiYanvjeISgNJYCLm0vhxh5ZoB5BigRjcxzYZWrPMNc3Ag/tokKveN2PHhNMLk/JnK8XmI6WjvioGpA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GJ0GbqFW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nI673ejS; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746185706; x=1777721706;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=NMDQR/eqwp1ptOzxQfI5e3ToeTF8zz9Y63h2qPS8qIg=;
  b=GJ0GbqFWlPSkmvOH5UFYu9wjtRNe9cHiVf/vZnEZYilny7hkeIIk2wf2
   w8z1LgAkUTE2KZ/WRKZZriBRNh8ntkhvikzSR0vW3Gs/DLHUmICuuyx86
   C8YsXi9XMdoYm/F8G9ptvn4B0MTbNrzyCNTD9ThxdJjTmLToRtkfxoNyO
   s1Rjm6Fk6ff/AP3PV91uJ24F2AI6TQ3nS7DIuyh1SU4aCZBQYq2L7TO5y
   +qyODArJIlrNZebblX0wK5vlbWOzElnXI7/TEcGpvCrhjjrdUE0yxO1cO
   o+Di186WPMtHBuSIZuHAPQqJvdBex3ZCNeROqH/gDJOrX7P1HNm/VivzD
   w==;
X-CSE-ConnectionGUID: 3M/WP21GQyOgLSYLjB8dJQ==
X-CSE-MsgGUID: 1Q8Y0hZcRv6aQP0mCu0Ggw==
X-IronPort-AV: E=Sophos;i="6.15,256,1739808000"; 
   d="scan'208";a="83164993"
Received: from mail-southcentralusazlp17012015.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2025 19:35:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1ERRK9KBr1dgkel/FU1Q1ExTRQ3GqY4L+5pbIvr1YhjAecUNfZPWT8zMTGyD0CXo0E7ISYYQ2jElux1F/q7tXOzpkquBvaRsq948UPXl1ZhyVW98Ejp6cOiR1/UVYOPPWIYLBMdYrd+1nzu1NHLhjX40iC7g2sESP/v5axwmzIQ11JSIWYGqvEXIIekaRSOgAfs/qVBeQ25MGz6kunt1h4Z1H0XmCuuaRA8SLdStWta1dLY9TCcZjlaeZTt7rnzPvFLke1lINpQ5BBSMfiyFu1oiQPBjIErifamVQ7DO6HCxFIhBP3WBPYJ093XBcuqxfrUYHybl8rv4XOw5lONug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kSYM6cSvQRRmX+crRneSWgwfHBzfvYXbYkpVBjqtS0=;
 b=TAiAoaOq9GskfNUw6M7BPtXaUYZNPQ6g9EPUL0NUCMrn+OZzkjKPUeysb9SPy9RXVGbF+U4kC2/txyV/+MpXHBN3jqkgNgR6Q74IDaLwPR926F2jx3VEGstqNp0b1HEHmCobuqtr2wfPEF67c769QxxsQZ2hAOes3ZxrWpRBlooDdOxd8oqkH5TUHl3C0QYpj4xEV4fJWoqZkTvgwqo3J255TB/3s/qM21rTaGMrUYj3x3Ai84Gr45Nu3DZWci7TSWfoFDibx9O2lCtzbdJg0i1dlK/pWoV7Qp8VgOS6QNYPFmcmYfSWXjpB1iMlA1OsNYlAWpptfgjjzj4XSYkoaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kSYM6cSvQRRmX+crRneSWgwfHBzfvYXbYkpVBjqtS0=;
 b=nI673ejS3nI6exbCletK6t2nqPF1ps7AL+VEIjOmozg3AFj9GdvAdpRDHnVBCCTcYGS4LkmSwPq7xbkZ9FqSDNSO656ZKP1/mgIyNFezlbxh4pHMgPBApqoWvh9YDud2ke8n3QoyrpXDwIpVYE2XrLXdIDHwVTqj1nHI+3RxT4I=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by LV3PR04MB9013.namprd04.prod.outlook.com (2603:10b6:408:194::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 11:35:02 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::4372:e8cb:5341:9a9b%5]) with mapi id 15.20.8699.021; Fri, 2 May 2025
 11:35:01 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC: "zlang@kernel.org" <zlang@kernel.org>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"djwong@kernel.org" <djwong@kernel.org>, hch <hch@lst.de>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, "tytso@mit.edu"
	<tytso@mit.edu>, "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>, Hans
 Holmberg <Hans.Holmberg@wdc.com>
Subject: [PATCH] ext4/002: make generic to support xfs
Thread-Topic: [PATCH] ext4/002: make generic to support xfs
Thread-Index: AQHbu1Y9RHbR2RLnUEW7imjMDZRs0A==
Date: Fri, 2 May 2025 11:35:01 +0000
Message-ID: <20250502113415.14882-1-hans.holmberg@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.47.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|LV3PR04MB9013:EE_
x-ms-office365-filtering-correlation-id: 84096582-1823-47b3-a920-08dd896d6048
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?dJpLj4DqVtDx47ocrUeA1VsYwtTouyeU8lgBN9KwqfHr46ly8W8AjN2Jj6?=
 =?iso-8859-1?Q?Yr/ZLFohtE20UVtelvPYKfG4Yz2gzxHGtmgyCq9yj1EQTtnBXVDrTBGedB?=
 =?iso-8859-1?Q?PPFeKSUDleczYkeis9KgL1tCklwfGmbG/TjfdPfgWtJR7sAPNOsUO4bsEP?=
 =?iso-8859-1?Q?Vs967IViQq2Sr70Mi+k2na5zWpPZTasmHMuarqVAY/V9SjM2ZFlEUR/1rR?=
 =?iso-8859-1?Q?LFm9syA6WBghFLUW8egvQxUv9IgCDOHtOwsd8T8ibongpRsK01aYEKC1z1?=
 =?iso-8859-1?Q?IjR7DptMTzNpRhT5s+Jf5bvw0b9cJo3pHaGGc7ShyOTCMbYWM0Yn9A7M9Z?=
 =?iso-8859-1?Q?h1+sPgh2KbJsEl9jdg0zWX81N66cjoY+EREA/K+kbAMwiRYnLOVYhHu0MM?=
 =?iso-8859-1?Q?VKjYId/fhJJJdEBDDPe9JIHVfgERduz+ttk52Vz9rIHuG/6fklRhIiNSRJ?=
 =?iso-8859-1?Q?pIMMgki9FTE/bM5spw4n2bE85tsk3dTCg9Mkay8HDhYYtCxGFHT41LUfem?=
 =?iso-8859-1?Q?ngBv/hjjhpfEaErfGqzfnkfyGLMwewXD3YpHw0qHgnm6YEk495mii5zCY4?=
 =?iso-8859-1?Q?cgfRQZ52BHK93cSMWWd/NFhJE+IU4F155OojABPUsLKn4Vw8eZoHtXfq1x?=
 =?iso-8859-1?Q?+wZ2BrRXjRWwpByCB7NUPV5CmKrz3idtKHKxsjn6Ft6o0SuVmO029c/nLe?=
 =?iso-8859-1?Q?MnZeLNfYGL736n3ucnG5jqMlAx+ek8n+qucjrYitDCljSij6KV+nVFWBpe?=
 =?iso-8859-1?Q?fMexhryhswaPxoqQYi/Apo5aCOq4jxOtUWb0VEKv+9e7IO2gqz//jZ2raf?=
 =?iso-8859-1?Q?N+59dMT5M/Dsay59Odxt6tFhFDgSi7ALAeBhnHEojP2W78KhELHZpH7ApO?=
 =?iso-8859-1?Q?ouUblxygAsdTf9ErKrNlzjd8Wt1kKd7SlluxmrtClN00dtkGOj+CxCkZk/?=
 =?iso-8859-1?Q?Ud1U57H5UDkpM/Zt5NlOrk/9BNQd1Vq2STOfFskbbvZIaE+4I7e89HQTMr?=
 =?iso-8859-1?Q?RDxEQgSUjzjLdxv5wzxV9pwgKpQdlbiD++RNoszJtPZ6GWIFgb3HnbLnV1?=
 =?iso-8859-1?Q?BMYvXbqcQA8TeLhLxy96z215+DE3B9S3xHqvnlP6Hkw3/PxHO1jNo6D8P0?=
 =?iso-8859-1?Q?BgvCgLAz4kYDnqto0MdALrEMGVwTftaCPNekhcs1aqSz+ObBHLVhIXjzLL?=
 =?iso-8859-1?Q?mFE0ihkpN1M2Raxvy+d8nzBpfr/puuKw3iPHICqV2WYfKYTr0a2cII4H9Q?=
 =?iso-8859-1?Q?TtnWg7pqtzXxKUm9ggV5DDP/GwApDFtnJqb8wlsxkkLD/KYFw/VNlxJ2a7?=
 =?iso-8859-1?Q?XVbrkh4NhtEsYtc5jZeLhBlwdp4tI3cv84IvjlKcgRS/PEyrvvDsG6sSDW?=
 =?iso-8859-1?Q?IvbZY8E/2SgBV8whsz3oqno8q468qPM4KcNLMfDwDzR/AVEg5Ja7VQKqf2?=
 =?iso-8859-1?Q?6CzQTTdz+d7cfntCxU7giHwByJ4Pac1DndxBbxUysboA4lXDfhv4JlL0oU?=
 =?iso-8859-1?Q?w78ELRKEZ6u250YzMV4yRp6q2pxCP5FHoWrsgZCIT0ex1ZI8U4HYJy09zj?=
 =?iso-8859-1?Q?sfp3i6I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GuSw3Y8ONkeGQFcW0s2Az4gQpd18Fcj/QlrdB8XEfHYGFTV1g0zWVy9gOu?=
 =?iso-8859-1?Q?uUv/GJAZ5m1qRb7g91NUcy9IbgtZjyV4YxWETaeDC9oq2xZmBlwPKCSe87?=
 =?iso-8859-1?Q?H+Q9Afgfqjlxx3YCQUfNDPz++hWTvLIdqFq9J0gKrnnmvBsM/D6haRawZx?=
 =?iso-8859-1?Q?lNY+zm8JdufrX9JNh4S1wyodCDEKk+TD4l6Wkhor7OFACGS+AZv8+dhaTl?=
 =?iso-8859-1?Q?Ywl7tkcqM5wqsbWbPdul8usX4j7HZwYpd4hfY5msuFISCJbeg+uP2DHsLX?=
 =?iso-8859-1?Q?c55mv2IxbRx/QUZ93OKgGChcOHYtdrFanVcfkG/fR/KBcKZuWedZNDwVOb?=
 =?iso-8859-1?Q?Q1Sx4/Ju1XTFhnAiFbbgIFAxeoPSY4N/aGv1mRO7aP8uI0VMJUQxQVQKdZ?=
 =?iso-8859-1?Q?YoeKplQzKcUXDaFZeCE1TCThd5CKX7bR+XsTD6o/1B2hQ3E41n6H1v/3u7?=
 =?iso-8859-1?Q?/mNAuEna5QLNspu4/X6xx+BHTjFEb4NcscF9qKt8hAovJLrowtcSh9UO/B?=
 =?iso-8859-1?Q?nVd2YaR3mgdRZ3L4wQfoPIw4H9DhCbdgtmA9h5L6sFqGO+heYria7ZAIpq?=
 =?iso-8859-1?Q?kiMfbhIp+r3dRmWQdT/suViQ/NomNm5s+144Oenyn7JTq4IRoQ0teTBUSr?=
 =?iso-8859-1?Q?/vYCisNkYgrBgUf5NCkmao11MLJauXu4YXQJXSvLOlGSX+N6Eb7MyKmhC1?=
 =?iso-8859-1?Q?aPwpTIdffjJDDhunXsULVTMSwCOeRIsBTA++Gvf1hwnOoPVm+B79BshM3t?=
 =?iso-8859-1?Q?UD7Ql0q4VlKCUKVynGz0ALOcIY8NGxV2bzBUt+slSTT9yZb1ctOchWb7pJ?=
 =?iso-8859-1?Q?z4oS+L9iapU7fN7rNwU65OiC94KIW75zOesvZMMILqEmIkFSqP0H9kFxMX?=
 =?iso-8859-1?Q?xaxIivZFi8NWKqxd9T4MkrAQUENY5xr/vcCRyZ/9YfP9H2/DTbvwMmrmMT?=
 =?iso-8859-1?Q?HAlVB82oPavmHHpqt0NdlGSosPABx7DB+XVhs/LWY4LpcRlpqBLmlU6hAD?=
 =?iso-8859-1?Q?66NSvyzmnwTm/C5WQDZV3DpvkTrf0dv35uu94mll7pksSiVkXEcGY5tHG2?=
 =?iso-8859-1?Q?YaODeoONT413osM8X7ym1L4oK2CrWoozFssWCNVst2iRJRn4L2m+PMIZD6?=
 =?iso-8859-1?Q?ssvXaIHcEFrCy+Mtsq0b1YUI6FQ1j7oBMuLdAEkSwtgGM34EClEF/9mPYc?=
 =?iso-8859-1?Q?2fEVPmXYp9qo1YUN8GyjrOCmnC0sKKwYspAbtxpNYUlQu49PJjbvlmxLqt?=
 =?iso-8859-1?Q?XBThXs7iapYO7G4hJa1eKemLdhR8aryNA+0GpIB7YwT1yZrCvRL2NzLNip?=
 =?iso-8859-1?Q?ACN2e2I85WhY7LFRDa0yoqy+s+4gjqElhAyyGbbi/gEz57gMIuiMpJFvjt?=
 =?iso-8859-1?Q?hlejZtgzIIpC5+Og1qqoqli/jQptaCHe2XgOQZVWamE0oVQpmoq8lY+CCg?=
 =?iso-8859-1?Q?cPQ5q0t/YCRuwj2dI0VuAL6fDmpFmRKqnrDKDnrQpPluFxV1aGc2Y/DtBe?=
 =?iso-8859-1?Q?I7X+62zdcRJAifiATUKVp2zmXTO5+9W88toM/3C1wZqDEiEIxMOX+CXomV?=
 =?iso-8859-1?Q?JWqWVIBNeIbqesI0s2uGJHZamG/nBDwNFCmTejuWVKDp2Nl5FdIBA3cOrP?=
 =?iso-8859-1?Q?mXo1bvtd49Bguj6FUSU2P4gGhNUifsjYyKV8oMoQwWIbXfcJxwc0mEeg?=
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
	JXG8RL07GgPZlflWHNeBwxYj2LTwObWZ5XuPY2NitL8iGn2f7AT76AwxZZm9h0jcujbFiBC5glsda7PxuzcbfZLllyr56egVatpA70JdtKBFhn9h+IxCf4zO6+wP+lme+Gyl49+EjqeExXuThWXNohIyKyk6xu3Hx6e7xp7EYAAxyMPQCm1RB2wSzf+/LrcqKN9+colwfZgzG0aUB1UVZ5kH3Cd31NA+XRd/bLNl68k5bbVOU3braqAnkpRj1b+EwqztRjjzzNC9T9wv7PVsc0pNIcPapy1ewb5Q/kbUFNYoCQGx9ihk4+jp5Va1SjKsh2kwdIhC991osfuTuZqIFDDeJsL510pw036q+f7W7/X1mixRTW7h4XA401mZDtYif26hGeq21oJETx3WI1pFLCj2oX8d1ckkj/gZUAml9jCupLUzRdQGpKKB3ByAjTxgC1ZtAW9eTBjdjYF1C99FCAKU6FmugaNznUOALSjKpqFYxjsh+xNEkopAvnoYXIEg/iPxnAcuRApWvdEp3Y+moU0oIU3W2Ql7Cyz9yHfYw6nj0KvObTz1amx5f82tJQVclyyDpzQ+j6jmgFcnRfMT5/5Eoz+I/2A6rcaCFVmRSBZXAW2X3/V/hA7F85FDdlmA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84096582-1823-47b3-a920-08dd896d6048
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2025 11:35:01.5683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7n8rKDaD+tQlkGQYUV8aqaHnY1mQTZLtw5ZvcCtNzc98+mTYcglykIJ1bj6PFeZTZa8kV+GfcP1FzThDDEkLMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9013

xfs supports separate log devices and as this test now passes, share
it by turning it into a generic test.

This should not result in a new failure for other file systems as only
ext2/ext3/ext4 and xfs support mkfs with SCRATCH_LOGDEVs.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 tests/{ext4/002 =3D> generic/766}         | 3 ++-
 tests/{ext4/002.out =3D> generic/766.out} | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)
 rename tests/{ext4/002 =3D> generic/766} (98%)
 rename tests/{ext4/002.out =3D> generic/766.out} (98%)

diff --git a/tests/ext4/002 b/tests/generic/766
similarity index 98%
rename from tests/ext4/002
rename to tests/generic/766
index 6c1e1d926973..dbdb8e9266c0 100755
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

