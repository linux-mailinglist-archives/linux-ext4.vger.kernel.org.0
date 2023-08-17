Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753BC77EE5C
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 02:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347306AbjHQAgt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 20:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347528AbjHQAgs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 20:36:48 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719E12D56
        for <linux-ext4@vger.kernel.org>; Wed, 16 Aug 2023 17:36:14 -0700 (PDT)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172]) by mx-outbound21-84.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 17 Aug 2023 00:35:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2ET5BkEezZZem/d7AEpGkfSR/QzN+HdLmcfu4i92TwCfvBWjO/HUij0412YIco6Vpu/X0EmSVSvsvsexsY+gP4Epcqfaw+BOcIJTF7fkJYF0CPfCyVbxy3v+ADl+ZG3whwS7Xpxvmx0NI5vXdUWTHxYw1BS/eexfqwCRdWx4JrQMUVxLmhb/NNUOJYPgqO18Rv1uLGSLUjLSWoNrjrDNDyBBjOercKP7LvoCeXAu12WOOOiG/zcGnZRcN+BqguIouz6/u+HHpJm9RdPaK7Ac22tUqQmosdtMYJAfVk71lGXDt55HlZ7g8p7EEPtTGNnBVcLeD5QttjLh2rSHXQIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XMSjIZKwlzdqjVuZS1x8xJfaq/Vaspt6PF7MA3lJvo=;
 b=RilBkUVe+IQC2nAT3yaGl5moSvOyyWEwCleCNY44zdn6WKtJwB/2DOwPLb6eercz8v5kAy4vu+QltrbeGTylliJOjsGYVJtNdmz4g2AHZToluFGYDVn0tBPOPPOcf9nbP22EUIz59IHaL6EaFE7tu/c61jrcSp2hKp+spKgBq7bbjiF0PYZ7iF4I/3rguOF1xlxzTJxhr8aiIwnltn4aEh6Vibknl6KUCjac6LkgexklpD+Bi9mK9SQylnW3vbGgJU1639HEgw+8sP/afqVVzoTeNdZ9OpmyqpHwIVT9qe7huhjAQHcbbdmtLPejLpXE0JiRA0S2CerMYUHNhGcB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XMSjIZKwlzdqjVuZS1x8xJfaq/Vaspt6PF7MA3lJvo=;
 b=g6xUfv75nVtIAummCdqY6jL3KJEPORm8uqatJnFH4HSQE8JWkztSixiITHvs49SjofW9gMi8OvLEpLT0qj1sJmxT5N37WoG4X28LGjSkiJJ0EsHUP4dryhwxvg9T4FImEARVSfJxLfdMhw0aVuaCLLS78vAUJovDKY9YQleuH8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 DS0PR19MB7648.namprd19.prod.outlook.com (2603:10b6:8:f7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.30; Thu, 17 Aug 2023 00:35:18 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44%7]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 00:35:18 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca, sihara@ddn.com, wangshilong1991@gmail.com
Subject: [PATCH V2] ext4: introduce EXT4_BG_TRIMMED to optimize fstrim
Date:   Thu, 17 Aug 2023 10:35:04 +1000
Message-ID: <20230817003504.458920-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0063.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::15) To DS7PR19MB5711.namprd19.prod.outlook.com
 (2603:10b6:8:72::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|DS0PR19MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a177bc6-2d61-49f7-604b-08db9eb9d4e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LsTWaLdtUJw4eQUib4NgnVVjPCg6M9x1FiW9SGylinBDE9iXoubrtTEQPZyZeY10rcDs4oP08UVb8krJ2QGjYFOJIf9fehzZ53Y44o1RQhMUmZYyDNOdq+hwgNWBRleja7fYIdfecrWTZwrHGQWmaW7EHWz7DJkl8i9Lv+5gKZs3x7NWQo4b8QPFa5aVMkbzTl6xfC2qX3sobDVf/Pst1qXm+y1lJXaBsGhF+8rbjnhgunkKco9DT6up5yQB/MGlFkQRo+zyNUZxsrDFzywHpblzpUF8iISOSg209qawHEBKHp23ncJnqyag8nJTUTIE5e4ijNK0wPwhJaGphkehcZ2o+PjvIRSLcxOXnhh+asZ4FVHcaCMoAOe+HnzaY3gNJIZSVPt2zr4i+i3qKGBM5inGvU777cqys4anED5km/VMgZhbGeCv9rVYLgA8md7cVemWx2V/b+f9oUWSgFTFcuxABeeRUZmOV0/zzTuy1g93sibz351yt4ltayMwN3BpBt9+lzTb/Ti+zCNwGqdvRQRAFKrJ2FU/v2b5Q+sLY+XrM37lPd8sFrQIc0kaxxNn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39850400004)(376002)(366004)(346002)(1800799009)(186009)(451199024)(2906002)(2616005)(1076003)(26005)(55236004)(6512007)(36756003)(6486002)(6666004)(6506007)(38100700002)(83380400001)(478600001)(66556008)(66476007)(66946007)(6916009)(8676002)(316002)(8936002)(4326008)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hV3MhR/RKFAJztoieaHL5WnoGuiQbFE8iL8/pJB89xZJmHhXk3N20e0FuvmH?=
 =?us-ascii?Q?CTlDg3+regFm+cQ3EdN3a3+3JBRyt7jb3Jjo8VXV+9OxnWzdt3kq4rwOd31G?=
 =?us-ascii?Q?CC7mWptcl10fxQ3KrQGmX3WURzE7c2icFuGVOnCIIWrXnjgP1G3JoAV3G/kR?=
 =?us-ascii?Q?iGqelKAURYBEw3SMHcs20ydQJ3WjZHEDQA85WzOmmH5h9XIGfHuGQCYMKdWA?=
 =?us-ascii?Q?CStxJ7kNrsV5IZ/wKeuDzd3YKXleDW/35J7oWaRTloLsJ5rOvW/EZdBxj3Zs?=
 =?us-ascii?Q?kr+5WVHRxzGGOjUMl0xg6kC9mMhRa6acN4eurm6K4IApbokexXWKxVlAm1rx?=
 =?us-ascii?Q?3PcJkLhmIINRV8i7oSexye5WLRSVpj1e1mSYLh3+qLaa54CGqGbdADfnsdqm?=
 =?us-ascii?Q?RZz6giwQ3GrpBYJJHA4hEys7erNN6SFOy3Lmx3BWllDOxQdEVSpjT1STYMew?=
 =?us-ascii?Q?RPsSxOjj/fpd2z1otEJWr410NchCq5YbV1JxRYAi48XitAhBhUvRPGKICYsX?=
 =?us-ascii?Q?sahgxmqNFSDk3A510PlepGO8HdbEUNJIZSR7+7d9ARj4Lu8QZ7k6NuG+UvDi?=
 =?us-ascii?Q?K0bqdG1fQWhhHBusPQucD2sWOBH45mOSp3le1aN2vKaaDnhXeMU5w3zxeYHg?=
 =?us-ascii?Q?LGq9i3e8Os52CH3tjR28TPnBehnwuob2BmUeXalO80obBBD/jVfkrkDbHXgV?=
 =?us-ascii?Q?vqgs5DwpYedz9TPkfisJjd9BuwPUC+HfM+pT+ul+qtyCoOmEPMlyW+jkFaH6?=
 =?us-ascii?Q?GIxVXUBm7Yuo0eTMYRa0G/dYkrcWcj8Yd5RCfrjdtES8Vbrsd2jcbN4Raa0Z?=
 =?us-ascii?Q?eLHIwqxQDy2jScAab86IBFFb5pJJVyCZ+DW282PYW0VBGZhh5F/+zz0EZaBz?=
 =?us-ascii?Q?xFD1+t7/Dtxo8RQ8kvBJQ/g1WxcOrQuvzJGBL0N6AHy8BMZqrtJyFY8dpfve?=
 =?us-ascii?Q?1ifrtwHvq2lPwwAs2ClkGjtYcWliN5/gYB3fs5uhm9ubSUVa+4tvXsPy8bSn?=
 =?us-ascii?Q?HNLyUhTFFEruDuoLEB4rOVaVLYoAOTFw3bhLxma01Ijomwq6JT4So2ZeHPiC?=
 =?us-ascii?Q?BltiePYPaQMcTVrtLefWWVBo0zVRQaxa6bXgOCSkeX3hGVTDDgOG8yckb5Mm?=
 =?us-ascii?Q?d4sBPJkx9FKcpN2O6Mb7zrnNB5/wum9Rxceg0kfUqfBJ43u923pd7d8l6KpM?=
 =?us-ascii?Q?PY6PIgw6cFcxFhb5JX84oGZABvzDhadiWldkzUDYRxOXqp7RAh68UOIPZENu?=
 =?us-ascii?Q?w6hZi486gI0Ri6OpdZvWbgSZ3NVLtQ7JPWIaAWHXykblRvhotuaeJPjNqKCW?=
 =?us-ascii?Q?+Ak/KJbZbzpGreClOdew+K8iopv0HHYLbm96z1Ct9Wb1xKQrS9qeNF1YaPim?=
 =?us-ascii?Q?VCEzi5ugm7qVr4LXFXE4P3JF5sM4cstcqH2qQl4PaUGOy6O8fWnSlGtMibqh?=
 =?us-ascii?Q?3Df22vLZlHpToP999f4MlRjQKyTAapb+5HqQY6tmPXNctBU0UH74E+yV6UgK?=
 =?us-ascii?Q?u1Xvum71XG03lQZh0RBPlazCFn7RHu0aMpSXcX1HeZEgtk7XF17hBp5kJLO5?=
 =?us-ascii?Q?WksBLOPtOvxUWKeveIM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6OdJ4HfyTcfK7YHi4PI18S5Y61S7ht1adDdhnS/Niptni1gtJBT9Jr68PfcEBADSo95O7UQPfRNLPz6+9kX9fVPP48jqIyrF8qT9blwyT4sGebpqjyMiCSYrwLyqx3/8OqLoprllpW6NrXYm4g5s/uUF2U4LDDfYiaUvMrF8ECJTBsQUNQGcUvD3itESKgAF3ob7w7IPHHCwGcclhhf9mF2JA17GCg6IIK0A7U2iGG47EzGX7CGWX505zAD5k8GgdD44hvq1HrG/8r29VRfenaV5YPLonq3CPYHbH/dOdKcQEDuW8miANfya9rhOFJjtUsCinmGIB7+jM0fyfLhr7pbSRZemkVC+3gUrrzA/JO8u8gkoVr7csOsDPf2gVuYyvgOuWTAon1arEIDlso5Qcy/lXh5JnV+LvW/9v/3z6jcEJ7E6niafmzgr+JOg0CsjhblT1JBaaLWXbDOXRmO8x1dR9LfopP4hodKKwT8jBB0KHOEF+edyJekg/ywVyeCQ4uZKF7lPJLHZg3UmJmR4kbcTrcBcxDYrGlyhkKii5vDoJ12F/8H5HCrb8dEFaVgfMGijRjl9eMXBHfd1uNrA5vsLicMLfqrEcZcn0jI0gMPiJU+hkyIgKggfY9D4D5KbfZnqXPuqT7FNM4y/j8qtSCSeBMMRL/mjNID3yOuqOfdr/zjg+HutGC/NrfLpxY6BfqIwAr5JpZnTeQkpcO7OOmuE856pWIDKpum0fwQD1Qf0qbFznvs2tXxCJEMr4l+whB2ZvQfnzxyaCu/maprdx1ScZaq4ygGvhBNIv9PDZl5LvTkXW95xt/LD+hbTwnJw05BvHmf4KdYgP5QO9q0a7Hi0BBsJxZioEd/eepf+Yk4=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a177bc6-2d61-49f7-604b-08db9eb9d4e2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 00:35:18.4542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wg7LfLEQLiQ8ZvCpCHALfveLhp56AT3yD82xWslZjRakhDLz+vPqwVkw7zxnHEwL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7648
X-BESS-ID: 1692232520-105460-12299-13445-1
X-BESS-VER: 2019.1_20230816.1637
X-BESS-Apparent-Source-IP: 104.47.55.172
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuZGlmZAVgZQMDXV0CjFwDLJ3C
        LZMNnU2CIxNdHIwNTC0sDU2MAyOdFSqTYWAABORHNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250193 [from 
        cloudscan17-178.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 MAILTO_TO_SPAM_ADDR    META: Includes a link to a likely spammer email 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=MAILTO_TO_SPAM_ADDR, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently the flag indicating block group has done fstrim is not
persistent, and trim status will be lost after remount, as
a result fstrim can not skip the already trimmed groups, which
could be slow on very large devices.

This patch introduces a new block group flag EXT4_BG_TRIMMED,
we need 1 extra block group descriptor write after trimming each
block group.
When clearing the flag, the block group descriptor is journalled
already so no extra overhead.

Add a new super block flag EXT2_FLAGS_TRACK_TRIM, to indicate if
we should honour and set EXT4_BG_TRIMMED when doing fstrim.
The new super block flag can be turned on/off via tune2fs.

Cc: Shuichi Ihara <sihara@ddn.com>
Cc: Andreas Dilger <adilger@dilger.ca>
Cc: Wang Shilong <wangshilong1991@gmail.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
v1->v2:
use cpu_to_le32() with the new super flag.
do not record BG_TRIMMED if TRACK_TRIM is not set in super block.
---
 fs/ext4/ext4.h      | 10 ++-----
 fs/ext4/ext4_jbd2.h |  3 ++-
 fs/ext4/mballoc.c   | 63 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0a2d55faa095..a990fb49b24f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -437,6 +437,7 @@ struct flex_groups {
 #define EXT4_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not in use */
 #define EXT4_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not in use */
 #define EXT4_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to zero */
+#define EXT4_BG_TRIMMED		0x0008 /* block group was trimmed */
 
 /*
  * Macro-instructions used to manage group descriptors
@@ -1166,6 +1167,7 @@ struct ext4_inode_info {
 #define EXT2_FLAGS_SIGNED_HASH		0x0001  /* Signed dirhash in use */
 #define EXT2_FLAGS_UNSIGNED_HASH	0x0002  /* Unsigned dirhash in use */
 #define EXT2_FLAGS_TEST_FILESYS		0x0004	/* to test development code */
+#define EXT2_FLAGS_TRACK_TRIM		0x0008  /* Track trim status in each bg */
 
 /*
  * Mount flags set via mount options or defaults
@@ -3412,7 +3414,6 @@ struct ext4_group_info {
 };
 
 #define EXT4_GROUP_INFO_NEED_INIT_BIT		0
-#define EXT4_GROUP_INFO_WAS_TRIMMED_BIT		1
 #define EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT	2
 #define EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT	3
 #define EXT4_GROUP_INFO_BBITMAP_CORRUPT		\
@@ -3427,13 +3428,6 @@ struct ext4_group_info {
 	(test_bit(EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT, &((grp)->bb_state)))
 #define EXT4_MB_GRP_IBITMAP_CORRUPT(grp)	\
 	(test_bit(EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT, &((grp)->bb_state)))
-
-#define EXT4_MB_GRP_WAS_TRIMMED(grp)	\
-	(test_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
-#define EXT4_MB_GRP_SET_TRIMMED(grp)	\
-	(set_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
-#define EXT4_MB_GRP_CLEAR_TRIMMED(grp)	\
-	(clear_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
 #define EXT4_MB_GRP_TEST_AND_SET_READ(grp)	\
 	(test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_READ_BIT, &((grp)->bb_state)))
 
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 0c77697d5e90..ce529a454b2a 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -120,7 +120,8 @@
 #define EXT4_HT_MOVE_EXTENTS     9
 #define EXT4_HT_XATTR           10
 #define EXT4_HT_EXT_CONVERT     11
-#define EXT4_HT_MAX             12
+#define EXT4_HT_FS_TRIM		12
+#define EXT4_HT_MAX             13
 
 /**
  *   struct ext4_journal_cb_entry - Base structure for callback information.
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 21b903fe546e..d537bcdf121d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3849,15 +3849,6 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	rb_erase(&entry->efd_node, &(db->bb_free_root));
 	mb_free_blocks(NULL, &e4b, entry->efd_start_cluster, entry->efd_count);
 
-	/*
-	 * Clear the trimmed flag for the group so that the next
-	 * ext4_trim_fs can trim it.
-	 * If the volume is mounted with -o discard, online discard
-	 * is supported and the free blocks will be trimmed online.
-	 */
-	if (!test_opt(sb, DISCARD))
-		EXT4_MB_GRP_CLEAR_TRIMMED(db);
-
 	if (!db->bb_free_root.rb_node) {
 		/* No more items in the per group rb tree
 		 * balance refcounts from ext4_mb_free_metadata()
@@ -6587,8 +6578,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 					 " group:%u block:%d count:%lu failed"
 					 " with %d", block_group, bit, count,
 					 err);
-		} else
-			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
+		}
 
 		ext4_lock_group(sb, block_group);
 		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
@@ -6598,6 +6588,14 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
 	ext4_free_group_clusters_set(sb, gdp, ret);
 	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
+	/*
+	 * Clear the trimmed flag for the group so that the next
+	 * ext4_trim_fs can trim it.
+	 * If the volume is mounted with -o discard, online discard
+	 * is supported and the free blocks will be trimmed online.
+	 */
+	if (!test_opt(sb, DISCARD))
+		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_TRIMMED);
 	ext4_group_desc_csum_set(sb, block_group, gdp);
 	ext4_unlock_group(sb, block_group);
 
@@ -6995,10 +6993,19 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		   ext4_grpblk_t minblocks, bool set_trimmed)
 {
 	struct ext4_buddy e4b;
+	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
+	struct ext4_group_desc *gdp;
+	struct buffer_head *gd_bh;
 	int ret;
 
 	trace_ext4_trim_all_free(sb, group, start, max);
 
+	gdp = ext4_get_group_desc(sb, group, &gd_bh);
+	if (!gdp) {
+		ret = -EIO;
+		return ret;
+	}
+
 	ret = ext4_mb_load_buddy(sb, group, &e4b);
 	if (ret) {
 		ext4_warning(sb, "Error %d loading buddy information for %u",
@@ -7008,11 +7015,10 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 
 	ext4_lock_group(sb, group);
 
-	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
+	if (!(es->s_flags & cpu_to_le32(EXT2_FLAGS_TRACK_TRIM) &&
+	      gdp->bg_flags & cpu_to_le16(EXT4_BG_TRIMMED)) ||
 	    minblocks < EXT4_SB(sb)->s_last_trim_minblks) {
 		ret = ext4_try_to_trim_range(sb, &e4b, start, max, minblocks);
-		if (ret >= 0 && set_trimmed)
-			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
 	} else {
 		ret = 0;
 	}
@@ -7020,6 +7026,35 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 
+	if (ret > 0 && set_trimmed &&
+	    es->s_flags & cpu_to_le32(EXT2_FLAGS_TRACK_TRIM)) {
+		int err;
+		handle_t *handle;
+
+		handle = ext4_journal_start_sb(sb, EXT4_HT_FS_TRIM, 1);
+		if (IS_ERR(handle)) {
+			ret = PTR_ERR(handle);
+			goto out_return;
+		}
+		err = ext4_journal_get_write_access(handle, sb, gd_bh,
+						    EXT4_JTR_NONE);
+		if (err) {
+			ret = err;
+			goto out_journal;
+		}
+		ext4_lock_group(sb, group);
+		gdp->bg_flags |= cpu_to_le16(EXT4_BG_TRIMMED);
+		ext4_group_desc_csum_set(sb, group, gdp);
+		ext4_unlock_group(sb, group);
+		err = ext4_handle_dirty_metadata(handle, NULL, gd_bh);
+		if (err)
+			ret = err;
+out_journal:
+		err = ext4_journal_stop(handle);
+		if (err)
+			ret = err;
+	}
+out_return:
 	ext4_debug("trimmed %d blocks in the group %d\n",
 		ret, group);
 
-- 
2.41.0

