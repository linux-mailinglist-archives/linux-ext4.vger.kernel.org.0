Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE12E69C942
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Feb 2023 12:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjBTLID (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Feb 2023 06:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjBTLHm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Feb 2023 06:07:42 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2109.outbound.protection.outlook.com [40.107.255.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A789E7EE8;
        Mon, 20 Feb 2023 03:07:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNdwSDTM/wItOyXlf02TFA+6tD6igkHbrHI7tyLqCfRmOxE5bKqryAOxHLP/j/sTKleF08hK3gVE+a+ZmgFY230mlXNjr5bdgXezFM9ZmuvVnev6sFQMJ72z+IzXKbbFkAXxJ6MXwUvUxUPdI5lh2501b1acAnSE61G6voop4DutZjw89NjRpi3EsCs+TpdM5dA5lutFwOhZGp6AvFyLM64zVeCJDgS8arPM+wIr6s4/l8/9hXJNIfqyjzLaAB3mtsvLKyq5CIkXffkDsEwWoEi179bVnAHR/oDeAmgXGERjHE1JGgjQGwZAl9PL5QGTtYqnVKbcer83rroAmCZ6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc+mo8v8tEmX1UVxuNnK+WNC2WlIeHEDqPk4EtUEh5o=;
 b=RgEzo/Ex8CFn2hSWKla6Fp7eQRtREFDifflAnothT46FazQBIn60h+pQBT7KvyqJY5e72gvJKm/L36jE9oMoBdNJ5R96/UTO+KPHZ32CHs8csjg6C+f9LU7r3fRLWSEoPt6Y+ckLAlI0jzSKtcZSDTkjZ3BUL0U3RoQoGG0K9y5FYhjz2ZH7/mHdpI9tLDlAtZZWbN3Ouu2wtS3D5BlaV+kZr0pX0kGgfWo8XPYgsTMmCWEPCm+NN6enl5/6+lJrDSiBN3+sBk6SXw9XPGp3X7aomghGl4hPingDmdaN14F2tWSjydOJq2LLP8FjQ0G77Yl0OMOK+hqV8kjQ0UISaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc+mo8v8tEmX1UVxuNnK+WNC2WlIeHEDqPk4EtUEh5o=;
 b=ijOTxMZfnTNO7tEyz/8GfTzjeOO9XhLITxFjMoBxJdKdO7089nqmrVnhfCR85BG7FXO7lrSmEjgdeBK9521IvCfO9PhMwvvmu7qixpcyVsuU9zfSYuymTxiE4jxCVzuN76oBN6rtfEZRrvnk0FIE/xPJ5QP4JAEyCXgG9sCPHSI5yGHfVO0aI3QmdjgqHtAQ7SvL5cfYNS7/XI6/Kl874MJMAVXp/VX0GKP+W5dlYbslrNjQXQd50W/3/Ix9H8r3YazYbt6/BXy1em4A6vGs5an7GfvL+goH49M1WpFZHkUO3oE9DWwu1nlh3iI4oIRKXwBiJU+lcKjX19Knn9YS6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
 by SEYPR06MB5937.apcprd06.prod.outlook.com (2603:1096:101:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Mon, 20 Feb
 2023 11:07:36 +0000
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::a700:8843:3175:1dd1]) by SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::a700:8843:3175:1dd1%6]) with mapi id 15.20.6134.006; Mon, 20 Feb 2023
 11:07:36 +0000
From:   Wu Bo <bo.wu@vivo.com>
Cc:     Wu Bo <bo.wu@vivo.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-ext4@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: ext4: modify the group desc size to 64
Date:   Mon, 20 Feb 2023 19:06:37 +0800
Message-Id: <20230220110637.42678-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To SL2PR06MB3017.apcprd06.prod.outlook.com
 (2603:1096:100:3a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR06MB3017:EE_|SEYPR06MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: e12727e6-c679-40b1-e488-08db1332ac74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADY6OZARFaFS4L5jitbmqpDERpbQnS6kFFmytWtU89o5HqJHRJ3dT4U6YbuozdUGe1n0BfLRIpVH04uZAG8XaTywbZBq1mca6bxozPYRolWEDrUKq11/BdpB3BVYTA0yN+bYxec10tfbZXQtkrYO5aoPe0wFgI4lqqsL9r60Uk4/iWnGA5Y5EKZta54SxGx/bxpHNzI7rIb3Uz8DgokMryXSrDV4TrhEEdx0ag3KfT8UpNzC7q1nn6J9a64H2MAR5sSNvQJadUafunLOIj2n9TuqoP6kW7LPs7i1/ETCRWNk1OZ/LnyfGbxai1+Lz/o0pgFBOAnxeJ8qFbFBodyQyGxgSm972OrUgR4fNiF8RcVSH1A2UHnI9Xd4/Qg7KNoz6xd9mpW/bR3sMvtCNbIQc99vK9xIh046lGMPIniNiqqKlcwYVxY0DmB1XM/c74t50bvtBDX7/I9oDtSf+L/BPtjGrAWBz6nEcfynTJJWukcpId2LAFk9c3D8z1pu76oSREPVLAvLQZSHI9+rmd1MzA+ufXuB8S9gtzXbdfJ13w3d7SoS+Gr5U0pidwMygkzym5LvKVhhS1ubF8rpPFPzk8fdMXh94t3o/42jQeEBS8F0rz6U3OsCOkkFT2J1L0JByYz3n/TvCwIEhAO47pVv15/mqZcT5Zjb7zHMR95/1THoEzDhE2z6pqdu81vusNeForO1hWceq/MtEoG7X2zHNoK0vCZZXN64i3xnMbj0SpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3017.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(109986016)(451199018)(66946007)(316002)(41300700001)(83380400001)(8676002)(86362001)(66476007)(4326008)(2616005)(36756003)(5660300002)(8936002)(186003)(6512007)(26005)(66556008)(6506007)(6486002)(1076003)(52116002)(2906002)(54906003)(478600001)(38100700002)(38350700002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HD+Plzr1hQCraJQlfagjTVkxny21OZcLz1OpHU/wujummGoH6aSh9+SFOYqt?=
 =?us-ascii?Q?UUrp0omCOt06Ow1Rf0Hsar7yemuTKhBXd1ToxO5y0FQ47iKBr1otlqaK8bMi?=
 =?us-ascii?Q?dVUm++9bzoy109twnYwDPbKMU5lzhkIGODP6qGLYwvEX2RAssb/Wcd6lXlPP?=
 =?us-ascii?Q?FlSbfD4VOc7D5QCKB/IXmkMxoOtBaqFui8MAWBFmJrB1qX78dDDRs5NxwZ2L?=
 =?us-ascii?Q?ZMPFEyMr8j4JszKdPha7U4cdnItjX5M7wZM5Kl0kGDa6rdEFJg2nlvaxrux9?=
 =?us-ascii?Q?RbjdrEc/TDuVH0eF0HDM126b39i5K7xf8VLMd5TbPY0PGDsZOz7ag5JQZLqn?=
 =?us-ascii?Q?2JRKhpNQzBpjF3ZJ5GQQRFL7woEWY1kysQMfGEXZmk+FAH+kogz64iorR2no?=
 =?us-ascii?Q?+65/nLLIMchIgE6VRQNio7KQUqDtjCmif4w1wluGr+dLv+UBIAQCdY+3Q2fK?=
 =?us-ascii?Q?WupwYziTO6E4edRmvxTh60PTpIjhR4oGkPY/J3NIrXlhjRzJXt3WfcQuVXMt?=
 =?us-ascii?Q?x3X/Iz6xJQb3Wa2cEKVxyhLvxnz1I5xyuZuZcic0Wnhq1Ll8pbO9YiN6pvC4?=
 =?us-ascii?Q?vLdlBzy1v072OhiQGJQ+leAKMcLsvSd0B9VlONn9FC9IuSWdH6lAeHBdZnOi?=
 =?us-ascii?Q?qCOlXCNnOKvC2TNLLydXg9PKBvp2n6rhwPbzElxiVOyNy8LqCNpUQ1n3yTiC?=
 =?us-ascii?Q?pOUccUOYBEMTAX09ZDLBtsNxLnzEka5fMxfXLC5XfBMgHCS5Uo5DH/D5LTfB?=
 =?us-ascii?Q?dm2OwvXiafzh45N9gbbRLLJvEq/f90MfdDlHKTzhSx72M22dbVY/vliesWbJ?=
 =?us-ascii?Q?040Ey5KPAEscPxmXdODRhdFmQSZUMBzFZQPdKx78nDAzFe0GLthTgCUV5cAI?=
 =?us-ascii?Q?C7pWiG5FbqclgcDcVsiF0BjuUSD53fLg9GMRjcC3LyTaGvOHJT3tlt/xUPtm?=
 =?us-ascii?Q?GsCzwWtw5Z78AD5Lc9fP+9zfTjmpMivlMIHWqRxVPcbMfcFruRz8ykYcDX5g?=
 =?us-ascii?Q?UbVlIXw+S2MhtUXF0rMVZmmHw8Yw32a5PLWy9ygR7lN3Ctic2ALhm/1nmJd8?=
 =?us-ascii?Q?ILO40UALRe5XrcXQRzV8OSJtGHiI1wT0GAibwDROTwQigAGVfwpgoOYRzfWn?=
 =?us-ascii?Q?gc/EZodACQauzGIp4lIfRCR4UJ+n4ER/tEP0ytdgwTKaftt1ubbrvDMFDvFj?=
 =?us-ascii?Q?PrbpMlMVTkaQVGgudBho8OG2ophJeSvHNW1OKEv7Kr9rTUiwmX0/oirUYyYe?=
 =?us-ascii?Q?ZkkfzO76LH34Ysvl8V49f6iXn5XRC9csL7zOSSICFelHxuFwfCFgOVytmwsD?=
 =?us-ascii?Q?uxxlYo9UuSpxnMiPZN8rc7maqefUqogSgwg/mewZ5pPOHDCUqPJ6Rc9mNKKB?=
 =?us-ascii?Q?cFW8pmEv9yzEYd5ESX8AWwmg/C4JXbCVxhaDY0dMzRCsWO1S+p933h4pn2PN?=
 =?us-ascii?Q?KkRVR9xwTAtJvZ2ELbu4p9phEbLghbci07RnaOuKX1/QrPlgext0g0sbUqIj?=
 =?us-ascii?Q?sBaAyfIbI0MvCe+ZK/Zjpjdfy/CPeJ+ydb/iyOc2PnO1NjcijHaLGxfNhmLD?=
 =?us-ascii?Q?ogsPe8X8ko/9pinEMPB2pXOBBPI8QP49tLKpOufn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12727e6-c679-40b1-e488-08db1332ac74
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3017.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 11:07:36.7253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kf3NarGz2Of4u5PLIOytJWFBdJdbk71Vc1zKQkXbH3IuHynkKVqfdJUw7WcGX0OdaUjpt7BNsdP2mrKbRZpe+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5937
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since the default ext4 group desc size is 64 now and the size mentioned
in this doc is 64 too. Change it to 64.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 Documentation/filesystems/ext4/blockgroup.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/ext4/blockgroup.rst b/Documentation/filesystems/ext4/blockgroup.rst
index 46d78f860623..ed5a5cac6d40 100644
--- a/Documentation/filesystems/ext4/blockgroup.rst
+++ b/Documentation/filesystems/ext4/blockgroup.rst
@@ -105,9 +105,9 @@ descriptors. Instead, the superblock and a single block group descriptor
 block is placed at the beginning of the first, second, and last block
 groups in a meta-block group. A meta-block group is a collection of
 block groups which can be described by a single block group descriptor
-block. Since the size of the block group descriptor structure is 32
-bytes, a meta-block group contains 32 block groups for filesystems with
-a 1KB block size, and 128 block groups for filesystems with a 4KB
+block. Since the size of the block group descriptor structure is 64
+bytes, a meta-block group contains 16 block groups for filesystems with
+a 1KB block size, and 64 block groups for filesystems with a 4KB
 blocksize. Filesystems can either be created using this new block group
 descriptor layout, or existing filesystems can be resized on-line, and
 the field s_first_meta_bg in the superblock will indicate the first
-- 
2.35.3

