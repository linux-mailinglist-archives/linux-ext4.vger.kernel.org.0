Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BA66B365F
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 07:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCJGH5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 01:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCJGH4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 01:07:56 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23868E9833;
        Thu,  9 Mar 2023 22:07:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDAXoraXxwmBKkFGjZ2r2+vG0ke36bg9/bs2aYqiw76a+3MKox7SkUx23q9xWMjMelOtgCIBqKl91hNPluRhuhOY7fyTqIOdzKbYLxcurRiWpF1+si8pSgqzZkXiT0VCV+B3Qnt9Z448Zi3Z3mY5oT+D/Vi3pjCgKNj8URs7argT5TOFnTid/oo9FASXv4/VFAdeoXlxPbAHT+lSbTx/3qqR1h79AVyOmsombtBIet4+1v5FgdS8MhdQgGleLdNrjFuBp//zvvOR/E9C6vT2q8PZLV9NiYnKMhP3BVQPtLzY0DTHsqqMAdPuB2nV7c33hzCZu35fvDfbQ++LQ5RxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eGLPo+gwK3BhKaizmVCd0S9rUlfgoSwrRoS3Fp+T4I=;
 b=gPx7p0jZc2buJUsB/CLwCV1g83OCjcW8KNjZBV63MkrmIVf1Xu4y6n3ih2ubqbnIGNiZMqga1VCxiVcTqz8IAT96z0BjwBeUqiL1HaNIn/mlv3W+0pXDr0PYgd+AMerl5dAwPYVCo/qj8nDi52MqpQte6kIjo5G3gqFQ+VTqxerdrCpvkFccpvaj27HDjLk6gS4ZUOolml8dprT/EIR+uspRfCrn2bix7ro3UqLo6WQXIR1tZE5mgDVanszi36WQqHhcSbwHeUGaAGWsJ9PJLHXvxEeGApCUBSes096x5/EuHeW3D4igvPokqpp4MehdHk0EKvxkw42up2ML4QTOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eGLPo+gwK3BhKaizmVCd0S9rUlfgoSwrRoS3Fp+T4I=;
 b=m5ISxwiaV5sbgUZkoB6UlxSNDV+RMApA1rjW5ZXRjDtse7IejRoXJd3agkEtxw9tKUJc3fQYLBj4swLxKdcZMNXzSKuM7hM0BJwqIubB0qwOwVCOY7dix1UUEnlLqm2EnsD5rwKJwtYXD6kRcWmVV2Z7l2mmYhhoZfBTvQbkccTteiX7VX3nSounH16arU5bi3RWm6yBW+F5RqOJBk8jSIlVfo8MG/8GfdVYitp14w+/98AJAY4QewdfNWibLRfmtum85V1EgqPULVL4xHg5ovy4Awpb+pjx5+4GPzmlu0kIsiqYoVdVPIiFK+woRgbGJn6cFPvfR7gFQCloVZXPaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5626.apcprd06.prod.outlook.com (2603:1096:400:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 06:07:51 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 06:07:51 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] ext4: convert to DIV_ROUND_UP() in mpage_process_page_bufs()
Date:   Fri, 10 Mar 2023 14:07:34 +0800
Message-Id: <20230310060734.8780-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 464afa8c-926a-4758-2ac8-08db212dc77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XiKwmYCuqzcQ0Oq28gGfyJmAbYvdZJNZaysfFJcMOoI2/I9Dv/i7UFO1HRSE2iBeNyWFzfHC+12p7ocDazumpcsW9MVxhTTpFl5TrQAv8ag+lIHAmmToxxlsbfKUESuEe6MZaC6XtHkctCbS0EAj3h2BDFor/bQHIvhgTwUrmPEC47NX0hEftuCWjO5hHMdmURvj4Vpxg7/ix3nemCF6vJ8UXrBQTgfGcaa2NVCzm6I9KJb4eRvvkEMkKRKQlsHZJ9bxdkz33Y0mA/wYLZB9PTbjfC/kcdvjUiXyoxeq1V3kXUjGWfd+gAb3dm/VXxu2ZmS87gQFFpL0OYL/MfNIIcKfry/zZnO/6iLVgMmQdBqs0DhdF3bSJ9TawCkIM8wM35H1+mEJmbN0rjTjO5sMTQgPLJ86ijOx6kQ6JRN1QJVVqgj8J2ue4djrNyErIKn5mVmoDE/Lx3qoWDi4MOguuy7iJoxwRiGqobPZh6my9SwLds8xfz6L0AMXCrBkB361rHtqKAcFgDu6LASrLk4jz037AMRtAEr7pwo2SPJyEiPv9Dgt01Bk1aWnZjEgdf/cjb7nKtr9AXSpjziwCwMxlIELiD+sCo9ytgqqCaD7oz2DasxnvX5ZQlHe9Avg+vlCZZ/I4C8WFLqQlvPajEIsukbUzSJkQIU+io6x9wBtD+YihZU/sO5mFBendZFeY4UxdwVVaZPCWHJH1P5fvtKGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199018)(36756003)(83380400001)(38100700002)(38350700002)(316002)(478600001)(6486002)(2616005)(107886003)(6506007)(186003)(6512007)(1076003)(26005)(6666004)(5660300002)(4744005)(66556008)(52116002)(66476007)(8936002)(41300700001)(66946007)(4326008)(2906002)(86362001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c7eFvsk47V0yB1J+8pu77pTm/7FlPLrT5jlv7tDNeOSmKLUfjiXjgNcSPeXt?=
 =?us-ascii?Q?uq2aDJQIIJ2Q90McgJeAMG3VUIcxczNYhg6KUndekADm3hj5Vz1b9XS37lVs?=
 =?us-ascii?Q?7TJ2/KEM5YfyxN9MiRlHxLfJqPxjI3dKMFpQ5pKd/W73B3J+opDJsE6CajAG?=
 =?us-ascii?Q?XzBLEGBdlSuBSuDqkvY0BtCr97ZSpYM9gA2HttnX+qX48NYMW8QhyZcJtdUP?=
 =?us-ascii?Q?I/HshSkZyIK5gp+AukeQP2smnBxqLat7ZX6e3ikwRIE0ltnGekytk+doHdiQ?=
 =?us-ascii?Q?H09X/aOCCbB/bQrRD5nwb3Nka9EvA7Y5c33WxnZgZjZ8Qvzw5mSpeQQJAhJJ?=
 =?us-ascii?Q?+E3gpAJ30XYEabMvyxI7z+S/R5LDwkufuseDazdQu6ANLgAJvD2mK/5GVqpY?=
 =?us-ascii?Q?uXV8Z3dYosGwXGUCfBiQpY/hl15p7t6ROPV0QNU58WlFz/+xY/K2DP8FZ1Ve?=
 =?us-ascii?Q?7v8iu16YvX4cwxeEX3UnnA7hM3L0imwEI6trKIfYAbEJsGGnXb7cmS+R0yBg?=
 =?us-ascii?Q?K1K6X926+hY1uhwjPi8oO0qVi4ZoGErAEL9xCjBa95P8+As282gIbmGFiwG0?=
 =?us-ascii?Q?Sj8Ho+jBKrk5zmwwMVVZc3HtlIkFg8X/NtHOfluhoB8Ro9Dh2CcihZZQd1RO?=
 =?us-ascii?Q?7Ho+o1ayZRDOWZuNAq0J6FZwnpWqOvqOzBMuIqiyo00IJUpUohKHDRPKqgPt?=
 =?us-ascii?Q?px84OV1hBnc7vezLcmXs0RM2hDuHIh219W8FcmuCTIqsoZ6xv2e8V6l3JB9B?=
 =?us-ascii?Q?rH+nkxDeT3Ys4RFWCX04uAnt0YlXrUUCMO1BYhenkEdK/+FLgYFsdVLITOtv?=
 =?us-ascii?Q?SWIAD43wIx4+OxPj6imPSJtloHT50mFyt6i2XvFCrVug0oMp004xWAxT20tA?=
 =?us-ascii?Q?va8ay87LN0WwY/mYrA2QoEbLsZBxFbK+Hg/4ae80ixvno3M+3OyKoIuWh+f3?=
 =?us-ascii?Q?LRlH/n9dKvV+5MqHFit5JDgHMlx5bfIsZ5oe1Q037ZeSekTMxg6AKauE7476?=
 =?us-ascii?Q?q3rZurK8I35TzR1yu9fE+ORVWxjaueBLGoofVXinAwvCbiAS+l76oP6x2Pie?=
 =?us-ascii?Q?LWzEzjP+ayS2CqXOw3RJ1sHEUIeeRjbvvMjOdFTESYlnrrrkxrrxEWtXdM1D?=
 =?us-ascii?Q?7Sa8NSyJWJxfJ+eGKx8sam4w8AGpnVfbbSyWLgR8j6fuzIZhNPEJm0W0geyi?=
 =?us-ascii?Q?A22QDcFUdo7zDPwQ5+MuIQ9E80g40IYJQ1G6jrGs4HLVaV3WVhkfycgN2zS8?=
 =?us-ascii?Q?lzzw8atGCdMPA7Cw5K5/5dsJmxDdtDidJiLpZ69tBTFQvSkMwTJSZ4RFAKnn?=
 =?us-ascii?Q?hq5zMVNOJosCtetbObp0n6RuoBp8Z+uLXajOWS9lo0CzuuvmcAZ9b1o+xtqD?=
 =?us-ascii?Q?LtXL9kbpyHDd6l4CGPMr4YHeUDAhmqKOIrL2WLXXmW2D6kz0e7ClZ06PVX4e?=
 =?us-ascii?Q?uxXWlDn4eKa6o3w3Gw7OwFEz7nOjUp5Rm2+7uxjv35lUdhMQoKyvCOLagc65?=
 =?us-ascii?Q?qbUhmcVh+DA8AqgAf6jFbzGxJb0i0gzUIfTTQvK3P01/Itfu98RT9K1vc1gF?=
 =?us-ascii?Q?BZ2EraapQqAx5bppmDlTLhrRMMQ0Or4aoQqiiEET?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464afa8c-926a-4758-2ac8-08db212dc77a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 06:07:50.9161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ezy5yvX3+Nws4iu/brKLoI1lHV2K1yRe9Sq53Jnrb/d5gmd+dlYrlpt3LFycGd8NcI8M7hXag1RiW7H9u4u4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5626
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Just for better readability, no code logic change.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/ext4/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d251d705c276..d121cde74522 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2218,8 +2218,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 {
 	struct inode *inode = mpd->inode;
 	int err;
-	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
-							>> inode->i_blkbits;
+	ext4_lblk_t blocks = DIV_ROUND_UP(i_size_read(inode), i_blocksize(inode));
 
 	if (ext4_verity_in_progress(inode))
 		blocks = EXT_MAX_BLOCKS;
-- 
2.25.1

