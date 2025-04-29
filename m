Return-Path: <linux-ext4+bounces-7538-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1212AAA0D6E
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 15:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E695F3B288F
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E697442C;
	Tue, 29 Apr 2025 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="W1gAcpyU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021140.outbound.protection.outlook.com [52.101.62.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591F2C374B
	for <linux-ext4@vger.kernel.org>; Tue, 29 Apr 2025 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745933140; cv=fail; b=KMVo5z6fC6lix8aPvEoaweWMa3xvHL/rRgSckp94YfONpBoOjpBFYn1TA5qQzOe9RNCWPsOsNyIsGE9/BLzkqBckutLyyOkAThpTyFOzdbM2ZyjUQ2VIvVpbF+tMjsWVaDVp5DrWlUJkLxSBTadz4c3CzDXIH2906C+2nl6JybU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745933140; c=relaxed/simple;
	bh=amluUC/Fs5MjqiPBhzIXaKjewSXk8T018F9XlAnW/8c=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HEzlaHsxNcGuRjqyI1/vQLhBSku2fHFKHR8N4riKPZZ/Ir2odcRiHIN4WCXIvy8S3HyyWwttA7mbDIbvvnYR4QvExKfusMcOVKL3MyzH9yqJWuSnS1cKODBLyRNRoGtrHD7f+9x0FQ8LUdagINTwpI/g573CpJ86cukToszJcu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=W1gAcpyU; arc=fail smtp.client-ip=52.101.62.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kh+FW4b9ZWMckbGhlOVlJKbt8hX0+kK5Xl3700BAMt5eANoGgp9RlMgyOXiYjogA2Wh6/fUkndncFJZYhh9GsovfDA/DdRYeG/yWNGNYuO3o6FV595T8sYTV+LEzoduKUA20a4Uf8LQVH+vQYylMksDgBR2QTpPzvlFBwKiPplwAvSUj33MPmHS76uXI5jIg98wOO5DcxeKAoQyr9FvVfg6HFAO+eybeav9MNx0E3hjmSNKcrhS1z4md5T8s4yHDDwIH/fTXsSxsvAlkN722mjHavWT/6j4Ll9zlZEqJgvg0VHJBVBPotha85iiRZswW+jr5O7MhfaB6uenSrTIuww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNjusT6U6crw3Us5HOZ7ux+VPfyOFa/K9Xd5BzxlwE8=;
 b=jlns4cn6zHs27nNxhGGcE+onksm37H+p6bOcXy764c2cETIZH034PISHiRq/ETCLvTbY5j3Ff5d2JTwfYEFEDZ08Rdr0MCrc+73SssGVs7e3Rf6NJzQjlUNDvL/W6u+s+HhAIFMtzUdMUZtUuE4PqyUX3MojTvknQR8tVFbJ9r2kL9EIzX/s/uTpGRnflIvIlcjCOzeWrnhe2EwR+JmD2rl93iNlGtgDy96WJMaG6r++YH/KtLOBHgkzwImCbyvDWiKvdpFSmME8U1bP41/T36iWDRgKWIE9vig85LwgINmwyXMvNg0nfCErZOV1PPaqFPx+cVc4IDerQpZw/fnv0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNjusT6U6crw3Us5HOZ7ux+VPfyOFa/K9Xd5BzxlwE8=;
 b=W1gAcpyUU9RDlasc1fAD3LhE5+Z9EVXpdYzpIXjH+yI7/0gxC8ADRHXMX14SDKc8MIbd9ijnogYr0mnSAxxbZV5AM6DQ4TjsHG7wkhbXuZV+es0ESgMz3JsjWIR0vraNQJW05rPPQEwjdxarniWW1QTUXeS2hgl7E60Z5qvWnGY=
Received: from DS1PR21MB4166.namprd21.prod.outlook.com (2603:10b6:8:1e3::20)
 by DS1PR21MB4179.namprd21.prod.outlook.com (2603:10b6:8:1e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 13:25:35 +0000
Received: from DS1PR21MB4166.namprd21.prod.outlook.com
 ([fe80::3942:d87b:c8b8:1173]) by DS1PR21MB4166.namprd21.prod.outlook.com
 ([fe80::3942:d87b:c8b8:1173%5]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 13:25:35 +0000
From: John Zakrzewski <jozakrzewski@microsoft.com>
To: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Question about fsck for ext4
Thread-Topic: Question about fsck for ext4
Thread-Index: AQHbuQnU+NbFMbA8dkuxAJJX/rlQ4g==
Date: Tue, 29 Apr 2025 13:25:35 +0000
Message-ID:
 <DS1PR21MB4166208B2E5F4D23F547E349DF802@DS1PR21MB4166.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-29T13:25:36.082Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR21MB4166:EE_|DS1PR21MB4179:EE_
x-ms-office365-filtering-correlation-id: 0e233b16-ae55-4c65-15f3-08dd87215305
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?qbVVWf7UWd/IxMIRW6kGrnWfAYbJ7gZF6SBxOemitWh42NmnWwah4OnqVD?=
 =?iso-8859-1?Q?rBABM88BtKaaaAqIRLBxAt4SiStQ1oPOAJt6H5Nr7lwoDoRpyaPX5gM3Jk?=
 =?iso-8859-1?Q?UGEeFNtCzzD3acqQfCl9hNkrPiKf9quQEsAYqbvOcRMX1hKevPSLevtTHK?=
 =?iso-8859-1?Q?6KQgCKFaI4YwPWB7I3hVHm5YYAG/5D47PE7drA26vhgB64qPUThPewWgaY?=
 =?iso-8859-1?Q?Mb5oLcULBNnSdM3FBCXHDN2FbT5YQiv88dMmRVSTpQ0rNV9TpqcKLqi2MK?=
 =?iso-8859-1?Q?O7eDNQAdTjNnxvNruT18DYs1WwPggVbG+Z7AGxKsQU2tqW1MeV/YZuKTs6?=
 =?iso-8859-1?Q?J1dtZheyjp0yDVzJHecupnfBSB4q1V7DGTkOkdh93JSgXskMp5jIba2HlQ?=
 =?iso-8859-1?Q?7q90Lz3XAm3wqEUui97IZNpvi5vna/zIB9l/nxtpTZuKb6MuaMCSXR0O+k?=
 =?iso-8859-1?Q?VZUgb59SE6lJ2FDU458lADR4Jf4JvZ44ifi1ma1ue3Yewo+x94YKV+D3zz?=
 =?iso-8859-1?Q?7f1aXSf+AIL/c7U+9k5PXanyI+MLJz5eGPQUVTKmWVq5zkYNzdL2ac7sEa?=
 =?iso-8859-1?Q?GymKYPHsS16CHZk+S1cEx8VTDxB5nGWL+hbPXhhjwDXnojFOaTGmyJ+DgV?=
 =?iso-8859-1?Q?h13+047tpvbXe9MQpQaelvmMFqwJEw+GtL4T/4QOYveErkUsWvvJl09Oy3?=
 =?iso-8859-1?Q?pSWjO4qRPgx1olYYuf791PgArcGusGIW3ILlP0UZBdLciZ8WBGhDQycNti?=
 =?iso-8859-1?Q?9LBwormFuuS2d0WBbmhuzqCDTYwhCSrfy9ZbYbOK9oVmmI0xi729vgw/rD?=
 =?iso-8859-1?Q?zOwsG9dl5qW2v1wR+LlJHABM1VIC8JMLjObgOzMzJN3yfceTewM6D54F1u?=
 =?iso-8859-1?Q?XRenwkHdtWSG+IwB7GmdHX0dA3pIZIqKjHTFX/q31ddZT6xfW+JAeS8/Ul?=
 =?iso-8859-1?Q?V2vd741lEkNEfMkc1Acb9tTwga2SZmamRnTPO8GQxaGTwXnoyCXvjFtMJd?=
 =?iso-8859-1?Q?tJLZJFi0rhxofyGT8JPLwyhQ3w4fEyAYScNoiNxsrDhYWehrz6NXhgifQ2?=
 =?iso-8859-1?Q?nSF/XNgDBpghHHvu64+w3zypRBkP51dAuFBbKtn5XKVKhLX+1X8/UL3YSF?=
 =?iso-8859-1?Q?nw0RXjx5Q/Gx42oTbiuVC9gZWnr2zLcaGBSXW6hQRGTf+jgHrG8+HVFKVC?=
 =?iso-8859-1?Q?V1oOj9v5nMg1uF3l5vdEq0eWRpWCu5NzZDurho2A5Fculxy3/Hp4mj2KVK?=
 =?iso-8859-1?Q?IGfqs2wXU2hsDmLNIhctpybISBGJZxm+OzQSc21681HloMvje/MR2xurEN?=
 =?iso-8859-1?Q?eVPp93nec1J3EMIawRWbhAqcmQmBgMjD6ancE8fFQri36xlz5XwzDX5gFk?=
 =?iso-8859-1?Q?OfCp8RlegAvt7JBxNiUOLvO5mDH/H3+8hcmQtve5pAnxlJgDymhZOhFyU1?=
 =?iso-8859-1?Q?ureaAxfYKfdBZmOqTiuNDqgQHB9DeH/dYtyLD5drXm4aXGrysZP9YOEf5+?=
 =?iso-8859-1?Q?5MmoT0ol3cgg33CdlcVzrn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR21MB4166.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Wl+/2Bv1DZDDoBvR0oz8Cv4v1N8cbR2O7LYFUTn49IMkytL0bFi+Yxmy/i?=
 =?iso-8859-1?Q?5aVIbbPOsbj/edS8Ak9l0gzqCV6FcQwZwyTUn/dgVbmbXdG9QK7PJVFhry?=
 =?iso-8859-1?Q?R6imzPa08MgGm4tPeiT4nnqFRc8PTAgd9RPv2uzv4f4nPpLFykTiyyl0aY?=
 =?iso-8859-1?Q?VCi+rTWCtO7/pdC2RMXZ4nRexM4pSQBKbDRZVVcNoWCpusGWIo8i+GNMZ0?=
 =?iso-8859-1?Q?b3Tj168v4Om3ak8/MLXD7Mtp9w0l/AlX73MMAcmfoYFJEFMZ36V7c6N9Kr?=
 =?iso-8859-1?Q?P+79SlLPahpLOMFVpN0RjNx6Yq9Xmk+pb8k4EpIBG/y0GsMrDU9oL0qNe/?=
 =?iso-8859-1?Q?ioF9PNyCfYTWxXqYQhFAZPiOnynnVYnFP0oz+46EwokUtLIALNFY3maSIP?=
 =?iso-8859-1?Q?SmnbeDnrenGl8fUWr5e1jsXyAlXg7VyRXeXI346ZpPScmuQ6140KJWpvE2?=
 =?iso-8859-1?Q?UzY4w2wedXCEHaEpQt3aJkau0XeV83KsN5/ai18sYU1PTh0o4Wm7ppYDMA?=
 =?iso-8859-1?Q?DDtXo1CGg9D5cDPkFSIwyhzKAWVcgjh7zxa2VfG0kxr19ZXZdNA/ONEwq4?=
 =?iso-8859-1?Q?7m7uLLje5Phj7BdIO4Jr0opVGCXDcbjZj4kZUPCHJSlkRVZAl9V6X2rIrQ?=
 =?iso-8859-1?Q?Wj/lhCT4aljVF5ab0NVohaup75H7JBU17H4S9AQyTt7nK7kpWev1ob4dxN?=
 =?iso-8859-1?Q?+gIjW8Z25A0PfV6N8KQrPK64qbbEY1V9iXA0VX31MnhJfTGSTgjS+UaKq+?=
 =?iso-8859-1?Q?W7EnwZUNaYFQn6xXK7cKCQbtIW+f6s6RBzwZzFwBnRmQAJPuS9xuWdLCFG?=
 =?iso-8859-1?Q?eJ27WyZBECRzitic4aaBTQDtKGTUXCYSQwS1XLuk3SltE6bXK63slU4MUj?=
 =?iso-8859-1?Q?Lkn9EB+BsNFsM26jJ3MRthiY1mDfwEEckWE+O2RvF7bdV56yoR4RBc1jMq?=
 =?iso-8859-1?Q?3GO1mEe3cw6ufZz0xANej+ZMlLeayVrNyYZNmJEAhEYz63c+nQPAdfSydx?=
 =?iso-8859-1?Q?71CuNmKWs8v3uqphS5jzvhE650YVBnYyvs1NqFhfm430lOp5/KHszGUsHX?=
 =?iso-8859-1?Q?/nqi0D4pKwEyMRt1HOgZPCImqoy6YTuw7xwdWcezAW/UIeYXXziISw6lju?=
 =?iso-8859-1?Q?5l0RVAg89Jubk8NEs4RHl+wn+UhDHT+eP8dxvFWAPjIsE+HQWFeWMh/L1+?=
 =?iso-8859-1?Q?mEpTYk5XNlX5gw1EbyzqE0daBUBbpOScuPm85ltNk+j5F43hrA/uH0Ez5v?=
 =?iso-8859-1?Q?Uu60HikYpDdDeDALfjI4lsjYapCZl8ExP0tSqNPvelXR4Oeslz4199t7MR?=
 =?iso-8859-1?Q?NIHzqSiTHSdgShVgPfEN7Y4Gnn2FkT1848DqbCvFdhECGQIg3/+IZHrqSx?=
 =?iso-8859-1?Q?9tirPRZ1z6N2fafCO3oKshgTjFaQ2I2vTwoaJEu7Bk0Yj10cwlwZpNE4KR?=
 =?iso-8859-1?Q?uUVJ3aRDc9qd7fo72089WuQTRmj0wQkXc2EMehjFpvD14rZDKlzGA1LbPB?=
 =?iso-8859-1?Q?wnqW8TFrKYW9tgXoE/pfUCuxvrZsXNP6FBeOFfzziqEuXCylA/q+uCyi2i?=
 =?iso-8859-1?Q?QpGOh9V6V9zF6xFvtwoUWP6w522A9V/jCLqEHXhPm0Fp938J4+UMuz4PQy?=
 =?iso-8859-1?Q?yQtPRPgZoQLXpEJfGQV8gPFnVZikPGVD8e?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR21MB4166.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e233b16-ae55-4c65-15f3-08dd87215305
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 13:25:35.2731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxKK8Zih4tTlLoXpvw1EzAlsfruAR3hzpWCCsd4vSU/J7io9cKPkuTy+D1GR+k52EPsePixOj635t6gpFMrYoKduTqrI8rsqxbqW7+p5a/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR21MB4179

Hi! We are using the k8 utils opensource project(https://github.com/kuberne=
tes/utils) and looking for your thoughts on an issue where fsck is being ru=
n on every remount and if this is necessary for journaling filesystems.  Er=
ic Sandeen's comments here(https://github.com/kubernetes/utils/pull/132#iss=
uecomment-605492335) indicate it is not but wanted to verify with you that =
his statements apply to ext4 as well.  Ultimately I am looking for reassura=
nce to relax the need for fsck on mounts for ext4.  I look forward to heari=
ng your thoughts and please don't hesitate to ask clarifying questions. Tha=
nk you!=0A=
=0A=
John Zakrzewski=0A=
Software Engineer=0A=
Azure Core=0A=
jozakrzewski@microsoft.com=0A=

