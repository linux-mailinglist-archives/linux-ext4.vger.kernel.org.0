Return-Path: <linux-ext4+bounces-11096-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B02C0D9AB
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 13:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CB674F86F4
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 12:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B007230F929;
	Mon, 27 Oct 2025 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fQIyQZXi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vu0HrVDT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1430F809;
	Mon, 27 Oct 2025 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568197; cv=fail; b=ue/L9IUegjJiUoCzMpDtisp8vLIsGxm//gpWj//qcVWQMSbsTe0VdIDQA6Ki/TCoweEY4U5NgbsaHeKUj24O13gyj132FRdPvjAK4UU44ktSm3n1VXHpsoVX8bKp9Q3XCHDd86jiUEWmEIAdGVtnlBgn4rzNQkvJyTIbupLzWFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568197; c=relaxed/simple;
	bh=cWhBigUGi51VYxI8EG1hXn4eiBQAfq7V5NwwkpLfD0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dSVxUoKKZN9Y7OshTPUoKkXFDxdArkcina0w/QAOx5qXJLEbS7bGbLD5zUPe4ET+9XwF0ArOxcHgrt/P+lR9xZpN8FkNfguT08rbsapHiTNNZ1kZRDxwilj1K1QRzQkzOuee/cdW1oabtOPxyR8UpRH8RDDh2SE4XhQca8B/xaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fQIyQZXi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vu0HrVDT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RCCF2A025450;
	Mon, 27 Oct 2025 12:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OCnSbpueq86EyFBib8Sfh3mYyHoSwkFd/H3zAcIB+2A=; b=
	fQIyQZXiHx2pNAS0inLnOiDwjH0CIslpMCPGVwFhG4ffInGW9WeNmTTQUnU/MTPk
	WlrandUva+CHrBqmR+Aq8cwkUdsq0pdi/mnraGYZsX0FyOCUSCRhMMGa2PVQtAyN
	Nc2AhMvw6C0nxZ0fzBJ3fPvoEvc58FY6c/P5ZTkVvQ6DFM0OmHCGNmv+m/no04FV
	hUKYozjvD5mph6NiZPH9eo0UYsAAomqy9IUppLnZCxJhNzrG1lzv78Ki5iHHArIY
	kLIY7V7+ZfKlq13gsXpmxKaBwbvQfcjC4ZxtOsDwP+mc/f4wi1ciTc9sHaSxUdcV
	G02ofNllB8xMmdEZJOxHJg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a2357gqu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:29:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RAFv7S037500;
	Mon, 27 Oct 2025 12:29:31 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n06r3gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:29:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCLK/iZqJGKKcMevO3Rxl34m9A7MlS9NmivmFnN+xtNME3CheeNEmXfSoOk0hrRajOTQjm78S+ZAYjWHPhq+lNnyVnC4/XTONm0BIM0SRyjHZkjJ42BL2f1rQXXC/DIgwg3/hstNX4mEzAiVby99THOqF31qHVN6o3hExvlw86Up5FXw6HtR6/zVm7CDV2esM0CkvjtLmq+IIRWcuoga0uaSCdB/ZEbcjB5zzgxk5vcP+4U6UtG0h56TUxRy9Y+vrB04D0F9+WCsqAjKmIwQtU94B75lBlzZuJ5gmp7DORgIiAil6KGtElJDwQaKih+KfGlSsgOzlMduuDrFXmXe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCnSbpueq86EyFBib8Sfh3mYyHoSwkFd/H3zAcIB+2A=;
 b=gbFQaijTDCh+PvislYkP8axfKDR9jgbf9JLQXZ+wdX4jetabYBiWtPXdqSiHVyUqKSX1c7UDhZIIDh2tzhoSGxwzujMSPY2Hhoqu1ZsYEEa95o9YLbJoS8jOxXXwv+mOvg0uVzWxOrgyCYvkLo2TUNXmYKAiRzdSDW1yiI01XEHWmRL/DgZz8FIGVtkqVXUASL6W1KxhhB9m8HMogDjjB3J1HbXf3ZDCKJ6g06PzPhCqaiBWcb7Fl4C0sG3ef1F+Xbx4C0nbI32V0qC75YQZY38d2I5fPnv9ddTagdlnJs4cssSY7InTHdTrU0B4Q/IP9BLLczAoe/k/ynAwTqzumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCnSbpueq86EyFBib8Sfh3mYyHoSwkFd/H3zAcIB+2A=;
 b=vu0HrVDT87uGVJMj/X+oDshuUMCcrU8ii+HenP+qeggq9icjzDFcwN2VWRyyb6H/ieVG5PdbU92ia+uNdCWkpVJ79pIivYza0fYrzSSjAxGuc86qfMkrg8P5AY/90MBtpyD7V7Ay5AK4d2CUVfaFi33gd2MkY69Fon9Z44N5x5k=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB6371.namprd10.prod.outlook.com (2603:10b6:303:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 12:29:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 12:29:28 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@linux.com, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V3 7/7] mm/slab: place slabobj_ext metadata in unused space within s->size
Date: Mon, 27 Oct 2025 21:28:47 +0900
Message-ID: <20251027122847.320924-8-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027122847.320924-1-harry.yoo@oracle.com>
References: <20251027122847.320924-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0035.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 474b6480-dc1a-44ab-af8a-08de155478e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OCoLXcHxyqe+A/9yRDmVl2IUsdWuLGtNkOyD7ydxAIYB3JO4qznk257bUUaq?=
 =?us-ascii?Q?sQdRytB5b+R33eLbdnjc/wt2UmvC6HMG8Zv9WV4hCKq75aOBD4Y+ub5bSGJR?=
 =?us-ascii?Q?L7ImiROEPY//z8ZAkgXTU3U6IN5sVxab0D+L92QOOvAxYIDSQu8sL3ZWu9rw?=
 =?us-ascii?Q?L8tpl25Qg7LpeneyfEwRKKY4NQMMnRJZ4Svhp2RRvvo0LNrGl6yc1EJ4Ql/6?=
 =?us-ascii?Q?6eqE/VX8vzEGN546fiM3c4f1kva2Hf8uOgr80GZz2uqWXrgkaGAaDb2MBLCM?=
 =?us-ascii?Q?U5N+YihQ7IBsy66WpEAxNf8vF6o0DWFPq6Y17OtMFHYVhx0FDdnhYbbQ1jaT?=
 =?us-ascii?Q?VEl4/y+3KjtWtI4eeWXG/LiZIeXkJsd8egwbtEqAO0C4r3SSEFM9wgkfvoUt?=
 =?us-ascii?Q?U2lfROmxjyuG9IoYYSPm2kdxTeyFkZ7sXLozf9CsRtQKbljN4sLRoJM0J9EK?=
 =?us-ascii?Q?CCqkjJS2xhj3oyQAuGRgOjx3NB2LTF14unJlqw9mzRd3CBBv3f9ujzCbpUov?=
 =?us-ascii?Q?e9C2LSBO7ALgVUspbDuYmbGilLqtl7qPJ8Go/+XuOh22thKezG8Bdqj3AGgQ?=
 =?us-ascii?Q?FnXta4trKRPUz7PkH/OmSseItpJwlkiljfZI9v08KH9/mxYM2f2KDnnqJbIw?=
 =?us-ascii?Q?kPy8eOlpjC6AtzRTMwKAQglhyK16eFvNbki5GNboQ3TwpiiWf67DKyCklSVM?=
 =?us-ascii?Q?m1mg5vvKkLlU+9CnAV8cv+SSaWN6IJfgNeW+NTwaHQ+nzXJOXkyVEdqd2qJa?=
 =?us-ascii?Q?uiAz3sfK77k2upgjeHrWx3+I0G51qfyo2umqgZhMMS362nMmwRH8rbCneeqN?=
 =?us-ascii?Q?L3ti5+bs9Qo07tBjLGstrJOdUC2EG1/vOY92WMGBdIRgT00V6hrl9bNy5J4E?=
 =?us-ascii?Q?dVFIGLfZ/hX/dJAd5qhKmTlBP6reoFtUBn9ZJhv5/6dyJR//zbeBowH4LY+4?=
 =?us-ascii?Q?0Oc+FJbEbAZeiooWducheOX46j0DhgKG1BadBXnAXPI5asxaxWDCQnOw8EjJ?=
 =?us-ascii?Q?kXYoXqJDFTny5kN5s2FJ0usrieWUeOS/6yf/9/r6uofYxpWU5rkwVVgu6zEM?=
 =?us-ascii?Q?IJSM2n41eFke/bZ+346MGjbUzn2/uV2iuhklSM/qbrHv0XYjAvg/MdmZZ/o2?=
 =?us-ascii?Q?D/xaO+qsEe0GxibSJHgUv0pAEQezjK0j6dvSpboRAh8Vvz8RqSYF4cLJy6QN?=
 =?us-ascii?Q?N+SNEdHld3AkZZIRfLZcd6697fwgIO0jlvoAkU3ktBxHBledGeSNIqH08i6B?=
 =?us-ascii?Q?WiuX5+/bjJlJQbLCoykVmkHn5E7ROfpnNNuOfKvlyEkNCHxH7W+K/yy6aEsH?=
 =?us-ascii?Q?iOQIbybTCVRuZx40R09b+5OoVTXNrzSeuTT3mf8bBb9lvhdCip67K+KSC+wo?=
 =?us-ascii?Q?8nPO+MuFkI+H01xjsfvcw23Q2yqFwrrXco1nyiV5fyhyN1AOsXWJW9a1o22N?=
 =?us-ascii?Q?8K69Et+85iNYBg7NQM6DzRCGUQkzM+W7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CRQCkn29iVVWCOnasDFjW1t1MFz1eNid621ijWYBI9wF+eKQlaysBrSDFb4h?=
 =?us-ascii?Q?OITI2eeMXGQQGxwMslAdeCdIqtX4N13e/rmwSJt6BJgD58moQNKPavJwZ7zg?=
 =?us-ascii?Q?AP4X2itKud5fyx0z3ZEYnniym5qCZ7Wy/7eqiNaP1yooxH4WQopzqYo9+wHU?=
 =?us-ascii?Q?4qfsXUSv4yFnmic5vEHemfmccLNLx/IG5/zYy7M6R/PM68eax4EoHPP2nqla?=
 =?us-ascii?Q?5t6YzI4Esmo9ynOV01m0Mb+IaAfnRatFleXMr+Fn45WaAonuZTCZHfe2GK0g?=
 =?us-ascii?Q?G831BNZDokGe0gjGMZjzcMhe9mMSd3thMX7cOG7RSn2V4oAgZedJ/ByBatHz?=
 =?us-ascii?Q?3KSA7o/UmAeWHp/CHsJ/abLhjrx3rhtA6ogZLw08X0tnfvNvu02Po9XiXibV?=
 =?us-ascii?Q?JtV2HUBcihTJXIXDCycIvjgJJ/1bvtQpiYa3TlOz8CXTJgma0RqeyasygERB?=
 =?us-ascii?Q?y62GaWpl+e3TqO+jJLsuJ9OV6Jp51tiDKXPPslT+jU9XCcQYaWAb/JRSSVqv?=
 =?us-ascii?Q?rWgvXWNwDp+Ske4lS3R9M5vvM79A245WJ1YqkGd1+Lxd1R0v/T46hs6WGfyl?=
 =?us-ascii?Q?jGRkYYiz8pes8+1yHtBx6nhrinike5/NKI0bLa/thQRAiAXb/dwK2wePdFFf?=
 =?us-ascii?Q?oycG7eLlBlF59HBZpV4jls8AGdct+L3jGVDE0VIY0m5zSZE5u3eX4igAWjPF?=
 =?us-ascii?Q?m92zycmuHXIxctmD7eGZQl1LY7ckQj1ts2uuhk5lxExU8dRh3IvQg6Y3Kuh6?=
 =?us-ascii?Q?bwMXWbaaLyYbFAL9udnVpuzLfeQvRj81HRnq0nc0ZxgWghpfK7S5mm3VVLRX?=
 =?us-ascii?Q?mWyUVXGa3U8wBjiSo/o83Pz21Ooqc4IDWehIiewHTFtOHgsXwkA2HTk39Ur8?=
 =?us-ascii?Q?EH15Dx6hySPc7ykoPl4n6NZh2MyopSEiBJbCj2Df0P1j6CuP2GDK3PtfZpbe?=
 =?us-ascii?Q?CMnOL0d/s1otgnoKIklRoXZmEOi+Y54MA5cDJkFoPa+YjOeAOAZnKJWhfRCU?=
 =?us-ascii?Q?hr1u34qgl26ZyP+x8yYYnGBHPSbqWeMtgpMhsXZ50LEOoWLxDqknwaNdDHRV?=
 =?us-ascii?Q?z71v3+1u2blwQjkTI/gGGgDG06aytCj7lkKW2o5bnLvwmoP/l8FNly4AgpML?=
 =?us-ascii?Q?UOQeNUJoef2BhoSVEZNHWJY51wKrqE46sFAw4jKapXVsBhwqx9mXtBByVJG0?=
 =?us-ascii?Q?CDN2R8cGO2+OEjYcfPG/26rM7S2udPGBRQrUN7s6lZLVUe9f6rL+lgIH+hc6?=
 =?us-ascii?Q?EW6DCTtPIszG9Kms4nmCgO6XMBrCDXbFQmIKdmBAAZriSKL8m5X8CIb1qTQI?=
 =?us-ascii?Q?P5M1jglDFEa8u+zzzLtugu+BONcgXSEsFDwHwGSOu/R6Ju7VHtfIy5FIXn52?=
 =?us-ascii?Q?u9GiZYhmqWYChXiK2XOKtzag3HCYILn2VdEycGGd8B+cHYhiT9Q/7wD4SE2y?=
 =?us-ascii?Q?pD6VUCLhsi7Xhs1R7C6LA39mve/ufoLfLIlhQy81VXZFPAZdlf36DnnCeUmG?=
 =?us-ascii?Q?tRtJpYumUOSq2O4nSEbLEKx2l7XTmbRZ0a14D1EoxhIUMAwov18VJdnoTMX1?=
 =?us-ascii?Q?73xiVf660hIXwApV5UMmV273S/BkV/obDe30B4Tr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6JXCwwp1DuC+Zg8GdwfWX8+EEy3JlhrsmyudiLtGtQZ9dWnxDN+FiRG04+hgZSTUgMsl/p9PivsjXOir2twF6MCqy/6gAJT+Gk0vW7+TedynRG2ISYRw/F0Ozwsm27+xRxBGjpNGVeWCEBMZyno8RrEqtqqqOGR1H+aszKrQ0ufsDsjRVgkFQCsyoiuvRo6EO/HuxJphKSphyZtfFPrU9avNIazwDperZQACznu24kkHLciVYpJutzP5T7baK95uA27vR/54Uy72z6psU9hd4no6Yzhhh1Fh/zNnOj8fxDTtZNw/opfAG34B9UW0H/myvu33DpKG/rlaEEDRcoLTSbOZEXzL7fvY1+BfGPWnMXhIXUZ73RmuSOm8fJ4eyUV7a4leRBzf4FFRuJReYe1Pn3DcSpFa+sKwLkkpODH/Ynsb3zPfHIQvej+wcM17KGqtZc8Wcvc71EW+Qv9ec7unXLNoHByV6GmA69xfajxUqghjMRBDNbHYmitimBJt6AJFtKVd2/t/5y49M7xUlfHLk6CkhXynRB2om94EIvYJ6ijU5Jvf+Z58mylw41fP1BgPC+5ZKA4Afyt5CjWtGqNyf0O8BXC8oefk17KTaVCqhHY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474b6480-dc1a-44ab-af8a-08de155478e7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 12:29:28.4923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tl3B4zwyd/VeTkFo7l77+INZrAawOPin6gst3k3n3Dwcsri5cFwp1VZ0O9W8/BoVfIN7g3apZkCqqJlqEBxenA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270116
X-Authority-Analysis: v=2.4 cv=Bt2QAIX5 c=1 sm=1 tr=0 ts=68ff65ac cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=lMPLp5VHBhqu3uUK-QgA:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: _MpkR_wMsOCvJfOp8slzsnKAFG7w_WeT
X-Proofpoint-ORIG-GUID: _MpkR_wMsOCvJfOp8slzsnKAFG7w_WeT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1NCBTYWx0ZWRfX4smUFQ6sEgns
 6rzoSOqIjoqbIJSoC1RzRcdKQwGXXlgdV+fsWmBnhHnDsk2XP2aOyC+bva0U+wSoPTDx7/cmJEr
 elVBm7gEZ4hHldCw7Eb73W3uCNnkWAiZjXP7+W/IcSto5cJtmO2MRVsxCDs/ColjeR2YoiBZyJA
 mSYaAu4Cb+kTOPUJrEwuzEJPSiFP6lBPPIX+iSNLq7c27lMoLTEO9nDQynn+ySdbV2gB7W4Xf/2
 xu4i0QQqoSMjdNgm9OJZSPGEjng9qK247lIdTU72UxEC66ZAr4hEvWMAKJ/Qc8VAconS3mmSon1
 9+3LQQftpS4SB+yrvOjbwn/IekLcsNgXLHrQ/q/UR4RoH//IYS/aA2kVRJDczyoabM4Rc1WLw5T
 3tvGlumUtaA+gngRid57X6GJdfHsSA==

When a cache has high s->align value and s->object_size is not aligned
to it, each object ends up with some unused space because of alignment.
If this wasted space is big enough, we can use it to store the
slabobj_ext metadata instead of wasting it.

On my system, this happens with caches like kmem_cache, mm_struct, pid,
task_struct, sighand_cache, xfs_inode, and others.

To place the slabobj_ext metadata within each object, the existing
slab_obj_ext() logic can still be used by setting:

  - slab->obj_exts = slab_address(slab) + s->red_left_zone +
                     (slabobj_ext offset)
  - stride = s->size

slab_obj_ext() doesn't need know where the metadata is stored,
so this method works without adding extra overhead to slab_obj_ext().

A good example benefiting from this optimization is xfs_inode
(object_size: 992, align: 64). To measure memory savings, 2 millions of
files were created on XFS.

[ MEMCG=y, MEM_ALLOC_PROFILING=n ]

Before patch (creating 2M directories on xfs):
  Slab:            6693844 kB
  SReclaimable:    6016332 kB
  SUnreclaim:       677512 kB

After patch (creating 2M directories on xfs):
  Slab:            6697572 kB
  SReclaimable:    6034744 kB
  SUnreclaim:       662828 kB (-14.3 MiB)

Enjoy the memory savings!

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/slab.h |  9 ++++++
 mm/slab_common.c     |  6 ++--
 mm/slub.c            | 72 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 561597dd2164..fd09674cc117 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -59,6 +59,9 @@ enum _slab_flag_bits {
 	_SLAB_CMPXCHG_DOUBLE,
 #ifdef CONFIG_SLAB_OBJ_EXT
 	_SLAB_NO_OBJ_EXT,
+#endif
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+	_SLAB_OBJ_EXT_IN_OBJ,
 #endif
 	_SLAB_FLAGS_LAST_BIT
 };
@@ -244,6 +247,12 @@ enum _slab_flag_bits {
 #define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
 #endif
 
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+#define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_BIT(_SLAB_OBJ_EXT_IN_OBJ)
+#else
+#define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_UNUSED
+#endif
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 2c2ed2452271..bfe2f498e622 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -43,11 +43,13 @@ DEFINE_MUTEX(slab_mutex);
 struct kmem_cache *kmem_cache;
 
 /*
- * Set of flags that will prevent slab merging
+ * Set of flags that will prevent slab merging.
+ * Any flag that adds per-object metadata should be included,
+ * since slab merging can update s->inuse that affects the metadata layout.
  */
 #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
 		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
-		SLAB_FAILSLAB | SLAB_NO_MERGE)
+		SLAB_FAILSLAB | SLAB_NO_MERGE | SLAB_OBJ_EXT_IN_OBJ)
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
diff --git a/mm/slub.c b/mm/slub.c
index 8101df5fdccf..7de6e8f8f8c2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -970,6 +970,40 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
 {
 	return false;
 }
+
+#endif
+
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+static bool obj_exts_in_object(struct kmem_cache *s)
+{
+	return s->flags & SLAB_OBJ_EXT_IN_OBJ;
+}
+
+static unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
+{
+	unsigned int offset = get_info_end(s);
+
+	if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
+		offset += sizeof(struct track) * 2;
+
+	if (slub_debug_orig_size(s))
+		offset += ALIGN(sizeof(unsigned int),
+				__alignof__(unsigned long));
+
+	offset += kasan_metadata_size(s, false);
+
+	return offset;
+}
+#else
+static inline bool obj_exts_in_object(struct kmem_cache *s)
+{
+	return false;
+}
+
+static inline unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_SLUB_DEBUG
@@ -1270,6 +1304,9 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 
 	off += kasan_metadata_size(s, false);
 
+	if (obj_exts_in_object(s))
+		off += sizeof(struct slabobj_ext);
+
 	if (off != size_from_object(s))
 		/* Beginning of the filler is the free pointer */
 		print_section(KERN_ERR, "Padding  ", p + off,
@@ -1439,7 +1476,10 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
  * 	A. Free pointer (if we cannot overwrite object on free)
  * 	B. Tracking data for SLAB_STORE_USER
  *	C. Original request size for kmalloc object (SLAB_STORE_USER enabled)
- *	D. Padding to reach required alignment boundary or at minimum
+ *	D. KASAN alloc metadata (KASAN enabled)
+ *	E. struct slabobj_ext to store accounting metadata
+ *	   (SLAB_OBJ_EXT_IN_OBJ enabled)
+ *	F. Padding to reach required alignment boundary or at minimum
  * 		one word if debugging is on to be able to detect writes
  * 		before the word boundary.
  *
@@ -1468,6 +1508,9 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 
 	off += kasan_metadata_size(s, false);
 
+	if (obj_exts_in_object(s))
+		off += sizeof(struct slabobj_ext);
+
 	if (size_from_object(s) == off)
 		return 1;
 
@@ -2250,7 +2293,8 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	if (!obj_exts)
 		return;
 
-	if (obj_exts_in_slab(slab->slab_cache, slab)) {
+	if (obj_exts_in_slab(slab->slab_cache, slab) ||
+			obj_exts_in_object(slab->slab_cache)) {
 		slab->obj_exts = 0;
 		return;
 	}
@@ -2291,6 +2335,21 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
 		if (IS_ENABLED(CONFIG_MEMCG))
 			slab->obj_exts |= MEMCG_DATA_OBJEXTS;
 		slab_set_stride(slab, sizeof(struct slabobj_ext));
+	} else if (obj_exts_in_object(s)) {
+		unsigned int offset = obj_exts_offset_in_object(s);
+
+		slab->obj_exts = (unsigned long)slab_address(slab);
+		slab->obj_exts += s->red_left_pad;
+		slab->obj_exts += obj_exts_offset_in_object(s);
+		if (IS_ENABLED(CONFIG_MEMCG))
+			slab->obj_exts |= MEMCG_DATA_OBJEXTS;
+		slab_set_stride(slab, s->size);
+
+		for_each_object(addr, s, slab_address(slab), slab->objects) {
+			kasan_unpoison_range(addr + offset,
+					     sizeof(struct slabobj_ext));
+			memset(addr + offset, 0, sizeof(struct slabobj_ext));
+		}
 	}
 	metadata_access_disable();
 }
@@ -7883,6 +7942,7 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 {
 	slab_flags_t flags = s->flags;
 	unsigned int size = s->object_size;
+	unsigned int aligned_size;
 	unsigned int order;
 
 	/*
@@ -7997,7 +8057,13 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	 * offset 0. In order to align the objects we have to simply size
 	 * each object to conform to the alignment.
 	 */
-	size = ALIGN(size, s->align);
+	aligned_size = ALIGN(size, s->align);
+#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
+	if (aligned_size - size >= sizeof(struct slabobj_ext))
+		s->flags |= SLAB_OBJ_EXT_IN_OBJ;
+#endif
+	size = aligned_size;
+
 	s->size = size;
 	s->reciprocal_size = reciprocal_value(size);
 	order = calculate_order(size);
-- 
2.43.0


