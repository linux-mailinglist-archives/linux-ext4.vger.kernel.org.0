Return-Path: <linux-ext4+bounces-9276-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE529B1CF62
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Aug 2025 01:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D614720166
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Aug 2025 23:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A1E26B0B3;
	Wed,  6 Aug 2025 23:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="a1eMf0SR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D134454279
	for <linux-ext4@vger.kernel.org>; Wed,  6 Aug 2025 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522626; cv=fail; b=Y29cBdaj1NX9PBE4PY9pDDweO6KRnKYR3yCLpuQaWzf5pf6ps/gxcaDN+QLRdoT8vJNt7P1l1eo5wWC+9fpelW7k0XOn23pJrXEDB6LTHC8FnAKpUXmFGtSRrN9j0fneopifDLf2TNpwY/L0u2utqe/EyYdiCEl2+hq+8g0Tx2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522626; c=relaxed/simple;
	bh=M/fvnE+ja/a1jDVBQDfMzd1/7xc3G4xIlRt0gvkmeiQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cgw77IEuyJ89YnpGnjAYI2LLSVMNsgw9+/t2K+bsZPwXkme2d6pyTz0rHd0Ji7hLIVsgAERW8Hyfr83Bz2vA/fu/LycuxliXOlmWC79eoPG19o/kb49lbFCUZtlNeUu7U3Et2tkskhzQO+LReqgGY3ckgS/wRMKrbrcL0WM0Ycw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=a1eMf0SR; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2139.outbound.protection.outlook.com [40.107.244.139]) by mx-outbound43-210.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 06 Aug 2025 23:23:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGhFIUI/THj9age63dPEYI9rrqK5/8g5CCFedF1+DH/4oS7MB0bLUSAccaeT7l2MB3jA+R84FJtr7cp1Bxqxf4M4Unu31qkzHlWSZ78cdpEwEWqOteyFh6WMTmOIuuV0xSGabnMzWNYR93NfBzHf05hr0aV2L95Fxn8qtRI4PIuXWuX02uBuYU8xBrwXy4PEJdTLTCgU34ey0/LOjz8hCxFNVOOFvgVtFLb5xrPYUxFuvQcNflYwYAP57JB4rjv0nWXjp4vBnSk6WIcMDAyiMb6IqFmyX6d6XctkhpSiLUpRXto4QbzrGTu/KRsbxDcUJWzg4u3Itx+oV61QW+h/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/fvnE+ja/a1jDVBQDfMzd1/7xc3G4xIlRt0gvkmeiQ=;
 b=d4r3Bml4fxoF+F7OBbqbz+kQk8E3gdUsXXDCreWvPbbW1WSI1Hs1UTSYJkq6bzNc8n4gO26gfneMVndM3tSkqeOD+BBUSzA3OWcIrw2SsmSON94JkErzs82+z5u0et1wDkkjEsUAFetFlD0MMT2/m25SXfqpxbb0Fo4dAstyPPepIJiHk9c6AOI7UWDCa4U/6OLYKwAJFDjd+4UTaBUAMFu/yuflxjrnZ77xZpFEwxXqJ4M3msVOXaXhG8+hSeKgghbnBTO963+iKEm4MFASe+k4/VJWR3yDTC2sehqmrlOZ/9G8aAWbHwcD3pNN1Ro3MB5gS2+FnsXYfflRVJctaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/fvnE+ja/a1jDVBQDfMzd1/7xc3G4xIlRt0gvkmeiQ=;
 b=a1eMf0SRERJwdeknMa5Jo6PAKCpx9SzuT1X9rzd89Qhx8PN/6dXIJQ6Bkqx5y5uSaRH2B2FtOl9wGwqq24t6drKSEA676jOh0cXYuRInjRAiSsJv/VzWXXaQCE09GSSXsetbGNGDLGmYS1+QcFeKsETf4/ecgqP3JJKIM+n4YIY=
Received: from IA0PPF371656EDC.namprd19.prod.outlook.com
 (2603:10b6:20f:fc04::c9b) by SA1PR19MB5055.namprd19.prod.outlook.com
 (2603:10b6:806:1a6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 23:23:37 +0000
Received: from IA0PPF371656EDC.namprd19.prod.outlook.com
 ([fe80::7911:a5f1:dea5:50f5]) by IA0PPF371656EDC.namprd19.prod.outlook.com
 ([fe80::7911:a5f1:dea5:50f5%7]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 23:23:35 +0000
From: Dongyang Li <dli@ddn.com>
To: Andreas Dilger <adilger@dilger.ca>, "tytso@mit.edu" <tytso@mit.edu>
CC: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Andreas Dilger
	<adilger@ddn.com>
Subject: Re: [PATCH] ext2fs: fix fast symlink blocks check
Thread-Topic: [PATCH] ext2fs: fix fast symlink blocks check
Thread-Index: AQHb9uczWt/c2Zhhx0m/fnQtw4OBt7RWZHSA
Date: Wed, 6 Aug 2025 23:23:35 +0000
Message-ID: <914474acec3e1c69be620b840099c6c4ba71ceff.camel@ddn.com>
References: <20250717065111.828535-1-adilger@dilger.ca>
In-Reply-To: <20250717065111.828535-1-adilger@dilger.ca>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF371656EDC:EE_|SA1PR19MB5055:EE_
x-ms-office365-filtering-correlation-id: fa6e700c-4a3a-419f-cc45-08ddd5404468
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2lwUlVMYXl5aEN3bDFXNU1oNzhpdEVXVEdLV1B6VS96eGZWcTJYdTFMOVFj?=
 =?utf-8?B?aFJCYUVIeitoU1B2My9Eb3JEaG1TR1lyUkc3Q1Z6MDhtSkxtTTNEazZFOG80?=
 =?utf-8?B?TUdlUGNFWm02VDdrY0N2TnlNOXVyQjNmZ2o2cWF5SEtWa3dQdkE4SmEyLzgr?=
 =?utf-8?B?U3lJSFJSVlF5REJRSzh4L2Y4aEM5SC9oMEQzclFjWk0vWmtSRFJrWTBOZFUx?=
 =?utf-8?B?ZUdZUzlmRnppYUhkbitiNjAyREZ1Y0E0WTlnTitFWkJablBoQVRGWjlpMHVN?=
 =?utf-8?B?U0N4VXJEOGRGNVBvb2NFR0FxL01tRVBacHJvMFh2SUJkV3pMR1JuSnVGZStp?=
 =?utf-8?B?UGgwaXViUFNPUnpGdmJQYk04S2pXYWNmb3dGVEFKYi9YVlRCSStjdUVtL1E2?=
 =?utf-8?B?bkN1clZDQ0FHNUFxZVNxVU9iTjlZbWF3N3krcU1heTBIa0N5ZFFHRE9KQ3VQ?=
 =?utf-8?B?Tk9Td1ZMd3BhRkdOakJkYVMxZFhqdGxHMEsrNURVSkZvTmxZV1JVQXpZV2R6?=
 =?utf-8?B?WjcrcWhOT1g5QnhzQnQ5VVlzOWJNMmtpMXpQdnVlanJjMk5zeWtiMXBCbUYy?=
 =?utf-8?B?cnRpOHlUQVpRS1NUQ0xqZENEK2RTT212dEQxTkF4ck44UUw0QXNDYk05eUR4?=
 =?utf-8?B?OFdUVzVRTVRLTk50L0VPZ1FLVksxN3BRY2orTXZTYjJiUk9rUHlPSVlDbTgr?=
 =?utf-8?B?MXpXQWszU2JaL0RGTFFHalp6TEtGQnlid3p6MFh5cncvMmEzTXFOdHMvZTl3?=
 =?utf-8?B?c1pFeDlLdWFXcXo2QnRseUViL2N6WWZJOWxPelJOZFZPKzNkQ0ZJSVZsbmJF?=
 =?utf-8?B?QmwrRXdIdDNmd0RPcUI5S25kLzh0b254RnN1cDB3UTVPY2VFdGd4TERpRUNV?=
 =?utf-8?B?dUlVMDFtcHVlMWthZ0FBaEhpRjdxaEtYMzJhOXBGVW9JMFMzQlRiL0l6UXBC?=
 =?utf-8?B?TjNUTHR2bDV3ZHBBa1p0a014Zm1ya3RibWNDaTY5STJyeXRyODRteDBqeWRj?=
 =?utf-8?B?RTIvT3h2WVl0eS9uVXhjTTdURm1JSmJveUUwVnhSTmEyYld5VGlPbWE1SzEv?=
 =?utf-8?B?c0tPQXBkM0hGUVE0N0graUNMMGNsbmJnVmZ3VHQzeEJPejhNL0paYXhDSStL?=
 =?utf-8?B?ZTFXMFVkQXc5UVdxUHN3VmJyRDRxMkFkUjFTK1VYYnJTbW12bThlZG1tVUtr?=
 =?utf-8?B?Lzl0QlZ5N3VTOVR4QTFhanRnMjN1SVcrRUcrSHR3ZjVMU1lYbDRzQU1qNE5z?=
 =?utf-8?B?NUNCdGlPUXBJN2ZUSG5lOGo4eXl1RS9vNFhXRG96bHY3WUJwY2Y3V2MrUUs3?=
 =?utf-8?B?Ni9lMUYrZTVZMkUxbUFPOGJHUmtOUzlGZTl2MnJzUE5URmx3dW43SHJ2bGl1?=
 =?utf-8?B?dlM5TGMvWCttTGdQaDY2djFrOW4zQm5Jb2FURSt1RnhVS3M0Y3orQmJpMHdN?=
 =?utf-8?B?QmRYTEJxYlRySkRPSHIzR240OHJFbVJrYm82dEh4ZGVNdENScWY3RXZISXhw?=
 =?utf-8?B?OUQ0L1htVFhEL0tUSXVsNXVVOTI3NnliVTFOaEhhMCtQbVNyNjNTUEU4Y3Nt?=
 =?utf-8?B?RmdMU3BLQzhOUk9GM211eU9Ya2diWk16TnoxZVVQUFBIZWpxUmtLeDVyb0xB?=
 =?utf-8?B?N2FNaGYrUm9YSU1tNE40WXBCOXNLVExNNFFndlZJdVNKb1VqS1VVR2hHcG5S?=
 =?utf-8?B?VVlVOEh5QW1rVlk2UEVFVS9lYk9FWGFSZEpqdlF6QWRETWpkTTBWNlhtNjhR?=
 =?utf-8?B?ZFVMUEljZklzWlRXRG9HZE5DNU9sei84Qkp4OWhkaDlUSUhoOHlLeDRvV1Ev?=
 =?utf-8?B?L3Q5aElEMDBmTXpOZFFWSlpuNmhnbmlGSFl0Ukc3QnpYYU1XcWpZbDhzcHhn?=
 =?utf-8?B?U0g2VTlqTDFFaDBFQmhvMnZwOURCRldKUG9ieUVuTzRjZU13c2trU1doZHhE?=
 =?utf-8?Q?bRat+V92OUk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF371656EDC.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TERDNy9TYWdUZURLQ2M0U3lWaEFNbnprdzdNaDROclFFTEEydDNUOGFHcFFK?=
 =?utf-8?B?NXJHOVNabEY1bUh2T0taaThNZ2FzclNBNHZDNmMvbFZkUlhmVXNlcDkyY2dk?=
 =?utf-8?B?VndRT29NYW9ZZFNKRDVMUkFSclAzbk5TMGo0VDhWSHhxMms2YTdVakUrZkRJ?=
 =?utf-8?B?MjhHVWNsdzNLMUFUTnJnWE5yZzg1UEVLZDdweDd2R2RCbC93aXR1TEJWNmxt?=
 =?utf-8?B?K011cnMxYWZkRzc0eENsU0t6aFVtR0dtbU9CbkFSNTVzblFTYUl2ZzBmT1VD?=
 =?utf-8?B?Y3JCOXNiU3l2UGw0eTRzUTJEb1BIRkUyYUpqZzFlcWNLUDQvSDhLa2FFdjFW?=
 =?utf-8?B?Z05nc2d2VUY4Rzg1bEtvSnJLQlByNzljUnZERloyUUFLNEtqNlBieGxxSFBz?=
 =?utf-8?B?alVGQldVQUpka0hXcjFqY3dDc1A2TkNQeWtsN0hjbFNqcHFvYWlyMnlaNHkv?=
 =?utf-8?B?eVdsSm5pdENXMDU0MHF0T1pmZFczb3pKbk9LWmdNb0hPY1o4VzByWGpiNGpv?=
 =?utf-8?B?YkxsY2dWZlZDL29YTWtnSVl2QXpUTmgydyswUHQ1bm9YZ2w0NExSYXQvRXZ1?=
 =?utf-8?B?MkRJVzhsd051Qkgrek1RWkMzUStpTi9xWUs0UVp3Uk5SOU9PQlZhK0xMYzNI?=
 =?utf-8?B?YmtWbVowR0ZjWHU5Y2ZQUUR2QzR4SGV5QklvOWJMRkJkeGJnK3FuNDVCZ0dI?=
 =?utf-8?B?WjRvWmMvT2hOWXFYcE1wK3FjVUpIZjVRVTFveXFheVB1OTZkQkxTVEZETTlO?=
 =?utf-8?B?bkdhTXhjSG14djRSb1gxVm1ZTkZTWTAxb3JoWmU4UUVxQVlVbVIrME1IVFZH?=
 =?utf-8?B?MXh0NG1ORlNyRFd0Y1BYLzVERU03ODN6Z3FRS3pRYXB5WjhkVnpId2lhNi9l?=
 =?utf-8?B?R2wvbnhOTWpDeEhuY3JoRGFMRjNVeklVNHJSdDdmcllNcmdOcGhJT1ptUi9l?=
 =?utf-8?B?ZFN4T1RmUUhITXpvT3ZzcHgwRDduSXFNWmk5V1FuT1IwK0JuL2dhK0dUVFR0?=
 =?utf-8?B?UWhRWXV3SDZVblVvL0JicWZJczhjekdGM295NlVxRUpyeWhhZ2hhckpqMi8z?=
 =?utf-8?B?MElSWGpLbjZkUFZoTk5rWEU4dEZjMkR3M3VYZkVFL2FjaXp3Qnl1T2w2Ykt3?=
 =?utf-8?B?TFpMNy9Oam1SZTZmbzJVbjdQUVlyOXVsTDJ0K3RWcWJaT1Q4TmQzVzByWXd3?=
 =?utf-8?B?TUcyNjExS045eXZIa1QyVldOcG1XQ2R1Y1JDNmtFYTlUZ0pvUzRYdHVBQ04z?=
 =?utf-8?B?L25mSXZCb201Z3RhdXhwNHhOSDM2VWZ0cE52YWgvdFd6MEthZ1ppTzNKWTM4?=
 =?utf-8?B?N2Q5T085a2NyWUs3OFFNTkxaNCtVZUxaaXZ4RXJQQ3VvUE9JTFJEZWhhY3dZ?=
 =?utf-8?B?Y0ljMmd3aGtvMVhEQVliRCsxdWtOM2VicWlBTXJMaHZUMCtKcU1ycW1zZUlF?=
 =?utf-8?B?SUtDR2MrMXJDVDYrdWNRdGl2RnBralAwN2wvQlFaWVZDYzRzVWVCL0xRUlRh?=
 =?utf-8?B?TG4zN3pxd2tFWTVxQVZxa0tNZGc3emwrOXBxN2xzWC9JUDVVQVdiZXFhK2lI?=
 =?utf-8?B?c3pEcHNQVkd5djBCeTc3cmp4NFM4RHJCai81ZjJuem9NdGd4eVFNM3IweVdS?=
 =?utf-8?B?bm9Vd09yMFhzMHlJUDNDR0k0R2NuVGttamNCWVUwYVMrUmllMW1hUyt1SmRi?=
 =?utf-8?B?SzZXTG55UHQzaTJuckdkcE55eklualZ5bnhBendkOTYrZGxkRmlLcThoSUtB?=
 =?utf-8?B?alhSd2xsR3h6TVExdUlYSUVkWVFXYVZPd2ZpRjFZZERWcWFpa1o1Q0xZSTBU?=
 =?utf-8?B?ZkFTNkhCK2pJeVZ4cG9FaldybUh5MHd4TGYrZTF6R2ppRStTTlB0WUgzT09l?=
 =?utf-8?B?WkFjL1NtRXEydFVUUGI3Wk9IZXlveU9HS3dzdGpoS0xLU0VRMUlyMEFsbGt1?=
 =?utf-8?B?MDdXZFF3VWdBekVSc0hMRjFvTVlRWXU2SnR3bG81V2hCNlRmbUtwc3pKbDcy?=
 =?utf-8?B?a2M1K1E3TnB6bVJ3cGxqRDZMN0M3LzBsc1lySnNvS1AxSkpBbHNtcytjUFd2?=
 =?utf-8?B?UlRxT1JZcVlQVnUySFdCeEdpeG9ibEswU0p6Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <335F7AEADA905443B444F3AE7EFFD388@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	II8wCG7mGGz890oEB0vE6XRuWt6ALyFbebutJW1Mcs33SAoWRm1mVJMpmcobe88RnwgjwjvOlU6XypYFk14V0JPoQ99WMth4ExyYK9A0IDbf/73M/tg7UcRvs2M/ZzSaZ5qI007Jls50phEBSJnBba7mT6R+XHqOqRFP8LoryFeBg79O4XHGMfbY2I+hZ03OX9DkbFpZQ7ajFqFyDXXBNHPtFsExA/AWCc514q0+J3JmS45ZSVeaUeQhqoG8RMniIGgCyZPJOyNPuXhwn62YnwQO+/N9vASqt+sERDl3lpQ3yWnQxOyThtiqO8LTyzhgp6xJpbOE0Id8863YsDTi/REfvDFawbxd2eD2Ylsslm/PjoaISzLxy072YJT0GRMqWTEJT2Ft1zNZmw6jLt2UNt8xMnsr19VvDnI4SubtdChhyHY8ElPjH1Fo2kJyz4YU7bXVVLyQcF8UpjR1IWvcq/q6ITEJQ/kgbLzyrWAQjigxWV1wimctFvp7U3dO+V4LDpohf/Wi4FgQINsg2VqyDhSALRsQVOQUClIjpaf4h/U9NjoVQdn4mBCvNUgb55IKeZnn/zAyWA/3lLX/Znxyf1MEtlfqTGeOv8Qksgd1hic4k5ILm/L5kiEWLfhCTh7GEy0gX1+kqpvW+C0ZfWTa5A==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF371656EDC.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6e700c-4a3a-419f-cc45-08ddd5404468
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 23:23:35.8664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4HGDldfdLrCIupvpbP4ucf29Iwwd7zTtCx15BA3MN8ujdQxohc25EqYFisb0IQ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB5055
X-BESS-ID: 1754522619-111218-15019-11932-1
X-BESS-VER: 2019.1_20250806.2144
X-BESS-Apparent-Source-IP: 40.107.244.139
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmJhZAVgZQ0MTIyMTCNC3VMN
	Ey0dAkKTnZyCjJxNjYwiTJwsTQ0NRIqTYWAHwDBjVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.266595 [from 
	cloudscan21-153.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

QW5kcmVhcywKV2UgYWN0dWFsbHkgZ290IGEgdGVzdCBjYXNlIGZfZWFfaW5vZGVfZmFzdF9zeW1s
aW5rIGZvciB0aGlzLApDb3VsZCB5b3Ugc2hhcmUgdGhlIHZlcnNpb24gd2l0aCB0aGUgdGVzdCBj
YXNlPwoKVGhhbmtzCkRvbmd5YW5nCk9uIFRodSwgMjAyNS0wNy0xNyBhdCAwMDo1MSAtMDYwMCwg
QW5kcmVhcyBEaWxnZXIgd3JvdGU6Cj4gVXNlIGV4dDRfaW5vZGVfaXNfZmFzdF9zeW1saW5rKCkg
aW4gZXh0MmZzX2lub2RlX2hhc192YWxpZF9ibG9ja3MyKCkKPiBpbnN0ZWFkIG9mIGRlcGVuZGlu
ZyBleGNsdXNpdmVseSBvbiBpX2Jsb2NrcyA9PSAwIHRvIGRldGVybWluZQo+IGlmIGFuIGlub2Rl
IGlzIGEgZmFzdCBzeW1saW5rLiBPdGhlcndpc2UsIGlmIGEgZmFzdCBzeW1saW5rIGhhcyBhCj4g
bGFyZ2UgZXh0ZXJuYWwgeGF0dHIgaW5vZGUgdGhhdCBpbmNyZWFzZXMgaV9ibG9ja3MsIGl0IHdp
bGwgYmUKPiBpbmNvcnJlY3RseSByZXBvcnRlZCBhcyBoYXZpbmcgaW52YWxpZCBibG9ja3MuCj4g
Cj4gQ2hhbmdlLUlkOiBJYmRlMjM0OGRhMzk0MDE2MDFhYmVkZDYwM2JkN2U0ZWY5NzA5MWFiZQo+
IEZpeGVzOiAwNjg0YTRmMzMgKCJPdmVyaGF1bCBleHRlbmRlZCBhdHRyaWJ1dGUgaGFuZGxpbmci
KQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgRGlsZ2VyIDxhZGlsZ2VyQHdoYW1jbG91ZC5jb20+
Cj4gUmV2aWV3ZWQtYnk6IExpIERvbmd5YW5nIDxkb25neWFuZ2xpQGRkbi5jb20+Cj4gUmV2aWV3
ZWQtb246IGh0dHBzOi8vcmV2aWV3LndoYW1jbG91ZC5jb20vNTk4NzEKPiBMdXN0cmUtYnVnLWlk
OiBodHRwczovL2ppcmEud2hhbWNsb3VkLmNvbS9icm93c2UvTFUtMTkxMjEKPiAtLS0KPiDCoGxp
Yi9leHQyZnMvdmFsaWRfYmxrLmMgfCAxICsKPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQo+IAo+IGRpZmYgLS1naXQgYS9saWIvZXh0MmZzL3ZhbGlkX2Jsay5jIGIvbGliL2V4dDJm
cy92YWxpZF9ibGsuYwo+IGluZGV4IGRiNWQ5MGFlNC4uMzMyZTljNjZhIDEwMDY0NAo+IC0tLSBh
L2xpYi9leHQyZnMvdmFsaWRfYmxrLmMKPiArKysgYi9saWIvZXh0MmZzL3ZhbGlkX2Jsay5jCj4g
QEAgLTQzLDYgKzQzLDcgQEAgaW50IGV4dDJmc19pbm9kZV9oYXNfdmFsaWRfYmxvY2tzMihleHQy
X2ZpbHN5cyBmcywKPiBzdHJ1Y3QgZXh0Ml9pbm9kZSAqaW5vZGUpCj4gwqAJCQkvKiBXaXRoIG5v
IEVBIGJsb2NrLCB3ZSBjYW4gcmVseSBvbiBpX2Jsb2Nrcwo+ICovCj4gwqAJCQlpZiAoaW5vZGUt
PmlfYmxvY2tzID09IDApCj4gwqAJCQkJcmV0dXJuIDA7Cj4gKwkJCXJldHVybiAhZXh0MmZzX2lz
X2Zhc3Rfc3ltbGluayhpbm9kZSk7Cj4gwqAJCX0gZWxzZSB7Cj4gwqAJCQkvKiBXaXRoIGFuIEVB
IGJsb2NrLCBsaWZlIGdldHMgbW9yZSB0cmlja3kKPiAqLwo+IMKgCQkJaWYgKGlub2RlLT5pX3Np
emUgPj0gRVhUMl9OX0JMT0NLUyo0KQo=

