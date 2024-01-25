Return-Path: <linux-ext4+bounces-917-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDD483CA23
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jan 2024 18:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622C71C238B1
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jan 2024 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4DF130E5D;
	Thu, 25 Jan 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=whamcloud.com header.i=@whamcloud.com header.b="RwLlC0rh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654BD22089
	for <linux-ext4@vger.kernel.org>; Thu, 25 Jan 2024 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204140; cv=fail; b=qHvSQzgDY2CpUYuVbkYvRgSfphZvycz7lqcsK3uNWV/vpZbtPpXV40QTUoUk2Iayn3ohFq/8c0s1P0s/ic/KCuj0p5UKV4iaDWt2KhN4+m11ogG/n6Iqk6ceQdf/Td6KWyZAxfJlP5u8Ii5GL03ml/LpR1ll1Nu/tNeyR5/ueM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204140; c=relaxed/simple;
	bh=SAIOXlLBb53je3QpUMw+ljB7Rv4R2+GmYfeBn10gZI4=;
	h=Date:From:To:Subject:Message-ID:Content-Type:MIME-Version; b=Gdjfa1iRJTRlCPXQ110iKlYjTMomzDHfprUHIy5eTpXQxavgC7s+FPx/6XpFUzYvGYp8TTx/Pfkbajri8F1torlmo1+vco4ln3Gwv8F7rRMJpQG+27kcmNFIgBP/s4u5HPpJAQYYywqJwxlGD28vqfL6WkiOOgZCwWN/ZRyw9QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=whamcloud.com; spf=pass smtp.mailfrom=whamcloud.com; dkim=pass (1024-bit key) header.d=whamcloud.com header.i=@whamcloud.com header.b=RwLlC0rh; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=whamcloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whamcloud.com
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168]) by mx-outbound16-180.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 25 Jan 2024 17:35:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=er9Jd8LSkCP8XRIj9knZETPSCuzSvGP6QRN43NOIDYBOZ5DFVcPBZhfUufRr/4irkzj71wwJCC3Q5Is9Umsa5xUFjMP/4Lht6JsW9dH0jK+yFEq9V3iBfjpESB4j8g2Sf5Fp5ljh64cnA8jUwJxpQj+Tp+rcE4F6R0AF5o2AradBOEtBIt7WCxhQo4U33u+csho7OVrx6YOgPQka4nF0Vd4UCURGVpvlAbsRvFvKQGhBZKPuFHnT8GS3/O/WYYjoAlFRe2WOg+d2Y4W81mD/ZBaJKc/WuAVXkXfYcevbIYLcW8RMvF5f+ICL84sK9nKtUGUQn4zgjfwA0snQvjouNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXi/3xe7xOuL8A9YoylPaJV55HbPbrFR7qFqCDFfhmc=;
 b=keNe+SAzTniXQUq3uL4f3oslRf1qQmyRd0q9aHikJw2vdsGBzhuVuCz9IRj0LQYQTxxZt5L3LHu2I3DuWDM87ex0HWxrk7FB5zh/obLDljFz4Ew5SwijzG5ruh8mTjovoS5RHbB832uw/PEwes45uwbeMT/GygWp257b99A/yo09tMKoWx0cmW71ERyXmlqN3TVBvqjuJU/kfk2Zynw61x8iqHp/xj4xzph5ROJgYVRr5B6nNkC90/+3KeSoBvdgNSgul45g5UUyqLIym1Yitldi0CLKoyMNAo7oRldPYpK6Y12tiJZVL5o5jAW41YX5C+9HgTfqO/E4gRHI3ZkA3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXi/3xe7xOuL8A9YoylPaJV55HbPbrFR7qFqCDFfhmc=;
 b=RwLlC0rhLkdtoDdOPT2rIA3S0wNBqXqziUqtClYyqu9g/g86e3UUc7uxfcYlW01DQfBcKEul/xLZ1hzO5VS6rR0mFDLceISmTV3hByYhDc+XHYExiL/SxRVrGRSMJdfqch0JWnb+4+uMIW6Jcjf2pPSZjK9yy+tLy9ce/TWfogs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=whamcloud.com;
Received: from DM4PR19MB5835.namprd19.prod.outlook.com (2603:10b6:8:66::17) by
 MN0PR19MB6334.namprd19.prod.outlook.com (2603:10b6:208:3c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 17:02:01 +0000
Received: from DM4PR19MB5835.namprd19.prod.outlook.com
 ([fe80::64b:cc6a:d4ce:cf0b]) by DM4PR19MB5835.namprd19.prod.outlook.com
 ([fe80::64b:cc6a:d4ce:cf0b%4]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 17:02:00 +0000
Date: Thu, 25 Jan 2024 20:01:55 +0300
From: Alex Zhuravlev <bzzz@whamcloud.com>
To: linux-ext4@vger.kernel.org
Subject: [PATCH] merge extent blocks when possible
Message-ID: <20240125200032.4c38a9ae@x390.bzzz77.ru>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF00011B52.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:c) To DM4PR19MB5835.namprd19.prod.outlook.com
 (2603:10b6:8:66::17)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR19MB5835:EE_|MN0PR19MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: a12ef0b9-9312-4bb7-96db-08dc1dc758ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3RbMyDDwVwqTc3zeLiKTvNHSvHop6edMQnubOMwy6N4tqKnIpuoEky1zQHYrcUb38jsMDv7ggI9FwUkrZnvcr6am4GzuV9W4qB/AbJ8r0WVyd9m1wbuyI85ArkkEsfH37LTC4SA9dYVmDrqe+syJRH8OUhJoUhI+XemGkQnIgDs/VtYdfCMuena+w7fX1ndxjWA90hzUtv/fr9eh9amjeJuLVGVlLn4FXtLQkeC3iCZM35vYT1lrkkVRm4FEHa5i2cqoLbRRhwABqai05xX23K/ZxDxc2Mvxkapsw2vkci4lxAi0N+oAcIE410j17jlzssoiG7U0LqnANGTQ/j/rvkFo5ugisZf+Ptqp3K+/AHs894IPlkIt/ADmZ8bsmTAjtSOmQXThOWNFvYzu7QZZ0A5NbZ7PmT+pqdfWOWMj9YO7R3LdbS36wJfp5x/bBnM3jCKJtZtj2w1So8jplse8N+84Ppoznw51Swt+RvuRWTSFHl7h4AxcWdV8pUt/zcM8FMdMPhqBrtgi3Aza148pryxy2rSyzH+sCiZi1MpjRv53s8GHQGAYt7XpWpNTlHBD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR19MB5835.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39850400004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(9686003)(6512007)(6506007)(38100700002)(1076003)(6486002)(6666004)(26005)(83380400001)(478600001)(8676002)(5660300002)(8936002)(316002)(66946007)(66476007)(6916009)(66556008)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xZTQCx62aAs71Bu2ZQOC1fwSapUzIAE4knff7vsiEJf0Rb+Xo+CsDNAOX1wC?=
 =?us-ascii?Q?4S6LjtR32zG+9dhAI+z+kAJBHWQhs6S3AmzIT3XZB0GwyqMlA2FK/D0oR7AH?=
 =?us-ascii?Q?fPvt7B+a8iTpzwCilyZwxE4J1l8MYUJG+AUuz5ba5SUMXrN0m/RBN8LtySaT?=
 =?us-ascii?Q?yVHpYMwp2AQQ/BSJY9HrbNimF1bJ7Vbdh4PjC9OaiNcicmH+SN53BcqNHmir?=
 =?us-ascii?Q?1LY6sBcnbnOEThJp7XLcpFl/Cohh/pTP8ETTl935g4LWkFpi1lRE3o4MX3p1?=
 =?us-ascii?Q?ZaF0NXB8eYSe1iT6zTwJgHGmgVNsYBZeOMCIF9gda7r8u98hG7fE5/C0KlgS?=
 =?us-ascii?Q?sBqUBpgBYmi1MPmHO0/gjkWeaYdUAVDzSBWO2HIGk2z94MDxAz1EEYqhUyk2?=
 =?us-ascii?Q?iPhWumvI2Hm06u56bi5O+8fSWLYgJGTewZtIYU55xkIRWrrETDGeSmNlhomz?=
 =?us-ascii?Q?Wg/dkZfG+gsfRWy83HBboZicoW8U09yQ3D2ACfyuzAF4V1bmcflRguRXfdMo?=
 =?us-ascii?Q?DPeJy4gJQj3NPH4efi9287zJZa61DDKp6ePyP/LZ8ac2hqZ/dihn7xUmYqoG?=
 =?us-ascii?Q?6uXT84dRSJ6R5DOvraX4GARQjJukRbDP7/fItCgTnJBsU+UV7QREammTAQyt?=
 =?us-ascii?Q?769tyW79zs+AIQxp+r/0Smj+fVNmuKLSFqNC9mrOy4TFKqmnTHT0S33MvuEw?=
 =?us-ascii?Q?WLikuywl9wr5J+M5KQ+U5cilsbl6GtsABAnpydXh8TzGA/gEMRJQK67AQbJd?=
 =?us-ascii?Q?t5KYdHAohOE6ehE5vSSRBrjd2PRgpBnGhvclXcVvBhVIvh02OF+JG7ZalGEm?=
 =?us-ascii?Q?nK5P1/OwSqcJ6FlkPyp4IGpWC+NCfnlk/CSvFQIZcJfdkJ7qy1pfYtGbaPEL?=
 =?us-ascii?Q?eZmDuhCyT6NWZI6EAMwl9LGpBhkl1a24duszw05BJxYQgfKirNC/ufnxvJw1?=
 =?us-ascii?Q?qeUB5vsW/GTtBuMKQID9/Z9FFdZ1685shUZBCI/ql9KrBzU42x4XuJv4UhMy?=
 =?us-ascii?Q?WG30EbDvPrEqwxuhGQ2OFDZG9odoq1OHSvOPMhEBxnesBQ1ehTZT4J+yQm1g?=
 =?us-ascii?Q?oa+l8penhz1YrDzWHaTbJcEdsV+ISX7uRTnpyy/dC5CntTzC9ye62W0HXKA7?=
 =?us-ascii?Q?C2TNmPI6WuISC4ZM0HiOttUcFKKO7et1UvlmHKmi7G3bRLUzG0szvEoNyX/2?=
 =?us-ascii?Q?r2GLR5ZNTy9ndC6Vv0l312RjTpfMmnC7uBICsl9LidXdntRTYfm+9jQmS0cK?=
 =?us-ascii?Q?g9mONhRD2yG250uDNkoaDmVZDotabh6tqRcDoOOyfE2fe6KXwFtKcTGSRiyV?=
 =?us-ascii?Q?CNpM7dfoV7Nm8fstuXxCeq6KyR575baQwBYv8+4F8kDHjIRRKAaJLUHFpRr0?=
 =?us-ascii?Q?IqSL+HbxbwP01fNv+MnLddfq8EB84CazAzzyP0T95L2SSp4pKSMYxGAlbMHB?=
 =?us-ascii?Q?WdZj+oNgmgpkhqkZKkS8oCOPgs2TDOimfEZF8fpcRN2fh/nAU1u+ncdpxYnC?=
 =?us-ascii?Q?x1Z8lApc7WIurMyxeFrGHdSP1NvhEmF3C0dgeLaAgtXBmiDEzL8dJFdyq2B6?=
 =?us-ascii?Q?/xDLFvT+z+OhztTOSuylnlmvTZNJZ1bvAFLLh9tj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+9zx17KIcj7Das03RUWjq1lu31MzWe7FLkch/y2yfprISwpISJd8Q+LlwxH9Ypn4E7AEGNoxVflrkCnu/vjXE3W6q8u4Xgf994ZVe2+Cd2ErRimM8i3brt2tHhWOj9tJqUop6+OFw1k89doY0VDIGS+XDvPM6qZnfOPIzyDTJVA2ZJzGMWlnp+87vCTyWQUClmhJiRzIDnEpcUPz6q3dCInpTWwpqUfyPo4RHseBXNWLCaXCyxFj5JmDi4rgBooCoqucmf92HYB66dO4k2BR9QzaWj6hsOEIrXWptJnpTsNVZQznbzD/sKrIahhTQZ6n8F4oTrUUlYVUnaryzNDbTlZzy4TEG768SvBtVq6HlgeV2GUdklkdCCW08vztU1SsrI9stHEjDCoYbZhzuzu8uWJQs67nS79Rfw+bk9ZDRXPl5Yw/0UeUbLcfuqU5YO2UmfwOBDJ6S7cABn4Kpu8zY+QQZX/yLUNpkwzeBK3XNio6G8FfMNzKI4HhcjF7AZTeVv+BpqfexWIfF4CjhQ2c1dmUF/wi00cwK9y83CAUNDLjDefPRU2SXugUbBs1Z/ODt5XNCXoeLcR/K/dFKoCWPJZeR9vhHCls1+sgcvJATMCn+3Oo4gby0crV7/SJJ+gZMlDbLFQZts5pHg2gBxAqz/wAvgq/ztx8ExyBKlbw1Lg=
X-MS-Exchange-CrossTenant-Network-Message-Id: a12ef0b9-9312-4bb7-96db-08dc1dc758ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR19MB5835.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 17:02:00.8428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQ9bKbRIRo97v5pDmi9wsVtzA9iZziccjBTswb13S3dVuBQ3SHIyfWADjf5FJ1qOdw0y4GG9ZXnGH7FaQ1P//A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6334
X-OriginatorOrg: whamcloud.com
X-BESS-ID: 1706204136-104276-15311-4023-1
X-BESS-VER: 2019.1_20240125.1647
X-BESS-Apparent-Source-IP: 104.47.59.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpbmRpZAVgZQMDXRKDHV2DI51d
	TYwsgi1czCPMnI2MLYwtzC0NLCyCxZqTYWAM/plyJBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253751 [from 
	cloudscan11-163.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Hi,

Please have a look at the patch attempting to handle the problem with deep extent tree.

Thanks, Alex

In some cases when a lot of extents are created initially by sparse file writes, they
get merged over time, but there is no way to merge blocks in different indexes.

For example, if a file is written synchronously, all even blocks first, then odd blocks.
The resulting extents tree looks like the following in "debugfs stat" output, often
with only a single block in each index/leaf:

   EXTENTS:
   (ETB0):33796
   (ETB1):33795
   (0-677):2588672-2589349
   (ETB1):2590753
   (678):2589350
   (ETB1):2590720
   (679-1357):2589351-2590029
   (ETB1):2590752
   (1358):2590030
   (ETB1):2590721
   (1359-2037):2590031-2590709
   (ETB1):2590751
   (2038):2590710
   (ETB1):2590722
   :
   :

With the patch applied the index and lead blocks are properly merged (0.6% slower
under this random sync write workload, but later read IOPS are greatly reduced):

   EXTENTS:
   (ETB0):33796
   (ETB1):2590736
   (0-2047):2588672-2590719
   (2048-11999):2592768-2602719

Originally the problem was hit with a real application operating on huge datasets and with just
27371 extents "inode has invalid extent depth: 6" problem occurred.
With the patch applied the application succeeded having finally 73637 in 3-level tree.

Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
---
 fs/ext4/extents.c     | 185 ++++++++++++++++++++++++++++++++++++++++--
 fs/jbd2/transaction.c |   1 +
 2 files changed, 180 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 01299b55a567..0fd9fbd65711 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1885,7 +1885,7 @@ static void ext4_ext_try_to_merge_up(handle_t *handle,
  * This function tries to merge the @ex extent to neighbours in the tree, then
  * tries to collapse the extent tree into the inode.
  */
-static void ext4_ext_try_to_merge(handle_t *handle,
+static int ext4_ext_try_to_merge(handle_t *handle,
 				  struct inode *inode,
 				  struct ext4_ext_path *path,
 				  struct ext4_extent *ex)
@@ -1902,9 +1902,178 @@ static void ext4_ext_try_to_merge(handle_t *handle,
 		merge_done = ext4_ext_try_to_merge_right(inode, path, ex - 1);
 
 	if (!merge_done)
-		(void) ext4_ext_try_to_merge_right(inode, path, ex);
+		merge_done = ext4_ext_try_to_merge_right(inode, path, ex);
 
 	ext4_ext_try_to_merge_up(handle, inode, path);
+
+	return merge_done;
+}
+
+/*
+ * This function tries to merge blocks from @path into @npath
+ */
+static int ext4_ext_merge_blocks(handle_t *handle,
+				struct inode *inode,
+				struct ext4_ext_path *path,
+				struct ext4_ext_path *npath)
+{
+	unsigned int depth = ext_depth(inode);
+	int used, nused, free, i, k, err;
+	ext4_fsblk_t next;
+
+	if (path[depth].p_hdr == npath[depth].p_hdr)
+		return 0;
+
+	used = le16_to_cpu(path[depth].p_hdr->eh_entries);
+	free = le16_to_cpu(npath[depth].p_hdr->eh_max) -
+		le16_to_cpu(npath[depth].p_hdr->eh_entries);
+	if (free < used)
+		return 0;
+
+	err = ext4_ext_get_access(handle, inode, path + depth);
+	if (err)
+		return err;
+	err = ext4_ext_get_access(handle, inode, npath + depth);
+	if (err)
+		return err;
+
+	/* move entries from the current leave to the next one */
+	nused = le16_to_cpu(npath[depth].p_hdr->eh_entries);
+	memmove(EXT_FIRST_EXTENT(npath[depth].p_hdr) + used,
+		EXT_FIRST_EXTENT(npath[depth].p_hdr),
+		nused * sizeof(struct ext4_extent));
+	memcpy(EXT_FIRST_EXTENT(npath[depth].p_hdr),
+		EXT_FIRST_EXTENT(path[depth].p_hdr),
+		used * sizeof(struct ext4_extent));
+	le16_add_cpu(&npath[depth].p_hdr->eh_entries, used);
+	le16_add_cpu(&path[depth].p_hdr->eh_entries, -used);
+	ext4_ext_try_to_merge_right(inode, npath,
+					EXT_FIRST_EXTENT(npath[depth].p_hdr));
+
+	err = ext4_ext_dirty(handle, inode, path + depth);
+	if (err)
+		return err;
+	err = ext4_ext_dirty(handle, inode, npath + depth);
+	if (err)
+		return err;
+
+	/* otherwise the index won't get corrected */
+	npath[depth].p_ext = EXT_FIRST_EXTENT(npath[depth].p_hdr);
+	err = ext4_ext_correct_indexes(handle, inode, npath);
+	if (err)
+		return err;
+
+	for (i = depth - 1; i >= 0; i--) {
+
+		next = ext4_idx_pblock(path[i].p_idx);
+		ext4_free_blocks(handle, inode, NULL, next, 1,
+				EXT4_FREE_BLOCKS_METADATA |
+				EXT4_FREE_BLOCKS_FORGET);
+		err = ext4_ext_get_access(handle, inode, path + i);
+		if (err)
+			return err;
+		le16_add_cpu(&path[i].p_hdr->eh_entries, -1);
+		if (le16_to_cpu(path[i].p_hdr->eh_entries) == 0) {
+			/* whole index block collapsed, go up */
+			continue;
+		}
+		/* remove index pointer */
+		used = EXT_LAST_INDEX(path[i].p_hdr) - path[i].p_idx + 1;
+		memmove(path[i].p_idx, path[i].p_idx + 1,
+			used * sizeof(struct ext4_extent_idx));
+
+		err = ext4_ext_dirty(handle, inode, path + i);
+		if (err)
+			return err;
+
+		if (path[i].p_hdr == npath[i].p_hdr)
+			break;
+
+		/* try to move index pointers */
+		used = le16_to_cpu(path[i].p_hdr->eh_entries);
+		free = le16_to_cpu(npath[i].p_hdr->eh_max) -
+			le16_to_cpu(npath[i].p_hdr->eh_entries);
+		if (used > free)
+			break;
+		err = ext4_ext_get_access(handle, inode, npath + i);
+		if (err)
+			return err;
+		memmove(EXT_FIRST_INDEX(npath[i].p_hdr) + used,
+			EXT_FIRST_INDEX(npath[i].p_hdr),
+			npath[i].p_hdr->eh_entries * sizeof(struct ext4_extent_idx));
+		memcpy(EXT_FIRST_INDEX(npath[i].p_hdr), EXT_FIRST_INDEX(path[i].p_hdr),
+			used * sizeof(struct ext4_extent_idx));
+		le16_add_cpu(&path[i].p_hdr->eh_entries, -used);
+		le16_add_cpu(&npath[i].p_hdr->eh_entries, used);
+		err = ext4_ext_dirty(handle, inode, path + i);
+		if (err)
+			return err;
+		err = ext4_ext_dirty(handle, inode, npath + i);
+		if (err)
+			return err;
+
+		/* correct index above */
+		for (k = i; k > 0; k--) {
+			err = ext4_ext_get_access(handle, inode, npath + k - 1);
+			if (err)
+				return err;
+			npath[k-1].p_idx->ei_block =
+				EXT_FIRST_INDEX(npath[k].p_hdr)->ei_block;
+			err = ext4_ext_dirty(handle, inode, npath + k - 1);
+			if (err)
+				return err;
+		}
+	}
+
+	/*
+	 * TODO: given we've got two paths, it should be possible to
+	 * collapse those two blocks into the root one in some cases
+	 */
+	return 1;
+}
+
+static int ext4_ext_try_to_merge_blocks(handle_t *handle,
+		struct inode *inode,
+		struct ext4_ext_path *path)
+{
+	struct ext4_ext_path *npath = NULL;
+	unsigned int depth = ext_depth(inode);
+	ext4_lblk_t next;
+	int used, rc = 0;
+
+	if (depth == 0)
+		return 0;
+
+	used = le16_to_cpu(path[depth].p_hdr->eh_entries);
+	/* don't be too agressive as checking space in
+	 * the next block is not free */
+	if (used > ext4_ext_space_block(inode, 0) / 4)
+		return 0;
+
+	/* try to merge to the next block */
+	next = ext4_ext_next_leaf_block(path);
+	if (next == EXT_MAX_BLOCKS)
+		return 0;
+	npath = ext4_find_extent(inode, next, NULL, 0);
+	if (IS_ERR(npath))
+		return 0;
+	rc = ext4_ext_merge_blocks(handle, inode, path, npath);
+	ext4_ext_drop_refs(npath);
+	kfree(npath);
+	if (rc)
+		return rc > 0 ? 0 : rc;
+
+	/* try to merge with the previous block */
+	if (EXT_FIRST_EXTENT(path[depth].p_hdr)->ee_block == 0)
+		return 0;
+	next = EXT_FIRST_EXTENT(path[depth].p_hdr)->ee_block - 1;
+	npath = ext4_find_extent(inode, next, NULL, 0);
+	if (IS_ERR(npath))
+		return 0;
+	rc = ext4_ext_merge_blocks(handle, inode, npath, path);
+	ext4_ext_drop_refs(npath);
+	kfree(npath);
+	return rc > 0 ? 0 : rc;
 }
 
 /*
@@ -1976,6 +2145,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	int depth, len, err;
 	ext4_lblk_t next;
 	int mb_flags = 0, unwritten;
+	int merged = 0;
 
 	if (gb_flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
 		mb_flags |= EXT4_MB_DELALLOC_RESERVED;
@@ -2167,8 +2337,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 merge:
 	/* try to merge extents */
 	if (!(gb_flags & EXT4_GET_BLOCKS_PRE_IO))
-		ext4_ext_try_to_merge(handle, inode, path, nearex);
-
+		merged = ext4_ext_try_to_merge(handle, inode, path, nearex);
 
 	/* time to correct all indexes above */
 	err = ext4_ext_correct_indexes(handle, inode, path);
@@ -2176,6 +2345,8 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 		goto cleanup;
 
 	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
+	if (!err && merged)
+		err = ext4_ext_try_to_merge_blocks(handle, inode, path);
 
 cleanup:
 	ext4_free_ext_path(npath);
@@ -3765,7 +3936,8 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 	/* note: ext4_ext_correct_indexes() isn't needed here because
 	 * borders are not changed
 	 */
-	ext4_ext_try_to_merge(handle, inode, path, ex);
+	if (ext4_ext_try_to_merge(handle, inode, path, ex))
+		ext4_ext_try_to_merge_blocks(handle, inode, path);
 
 	/* Mark modified extent as dirty */
 	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
@@ -3828,7 +4000,8 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	/* note: ext4_ext_correct_indexes() isn't needed here because
 	 * borders are not changed
 	 */
-	ext4_ext_try_to_merge(handle, inode, path, ex);
+	if (ext4_ext_try_to_merge(handle, inode, path, ex))
+		ext4_ext_try_to_merge_blocks(handle, inode, path);
 
 	/* Mark modified extent as dirty */
 	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index cb0b8d6fc0c6..4cd738fa408e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -513,6 +513,7 @@ handle_t *jbd2__journal_start(journal_t *journal, int nblocks, int rsv_blocks,
 		}
 		rsv_handle->h_reserved = 1;
 		rsv_handle->h_journal = journal;
+		rsv_handle->h_revoke_credits = revoke_records;
 		handle->h_rsv_handle = rsv_handle;
 	}
 	handle->h_revoke_credits = revoke_records;
-- 
2.43.0


