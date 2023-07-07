Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8918074AF26
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jul 2023 12:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjGGKzi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jul 2023 06:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjGGKze (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jul 2023 06:55:34 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7421BEE;
        Fri,  7 Jul 2023 03:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAL0oFWbZHXAMKGjOy0MnTx3z3wQKBCFyfG4ZuwHESeUDglSbYzUzGdb91wNHm3JKckoNdEEKEp8lwdoDwsEHWrDvjN4XfQ4TNBIGxYFqzlqZhkHVNLGfzJmuKu5d4ZEKJzGYot/ABWaJyQM/tu2KcaOzhMHa7+rvW+Zn1cZlaAsf8Gq5l15TeBrYl+NQx72smgoCncdip5TOexWXn3yBtowRCtABKavaM0DjeSMAdfBatVr4+NW1zNl8RjsKVW+V7NwdLpp1XaBwMmvK7qwkNZafdOkhg/WB/w1+kziyOhbkVH9ngYHffr2Tb7vGLep+YEm/aQZg2Zypjxr3tQYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMokTIZ3+imezFtmHG2FPlIKEbwriDrIwY6rcIpYihw=;
 b=D4QfQe5nQo0kNi0UDGYY+a8ctH/c+iPvkTG7tjOz69Owf0tNsCq2B4Yr8Q/QYFtVylpZvHX7iPV3qopZm/i1ng2fOCYbIR0g8FCwbrjv7nnwKHJ0GoRI/EEhiy/z9Pe6Fmh8BHSw7eOCY4HTyQuktdWOiJcX/WR/DO3ZgCWXzR3mzEJIYJeSP5mVhbmbMKDulE8/3Q2avNiJBd/n9qkTZ8glzZ5uR2qbb+5UgI0+PdzGpW6G/VZf2uiq5Pawozv3xyjjd76L2dGq1R/NarVpwvXoaVDaTL/bWnN269zPslhX8xAZqdPqKtQQiwwimemNDeApjVyJYIBsfJTIHJon5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMokTIZ3+imezFtmHG2FPlIKEbwriDrIwY6rcIpYihw=;
 b=EO/0LrpdAORQQkKUAlzh46ulEnRQtNtiWSVKP9tqtayZ+plaQljuUgcG2NS94Ikjtl2L7Sz1ytmZCQozWpInRcJvuujrsWrEZ5K+tiqztEl6YkXINHo8rttSMaTQVaON/QPlHnFsQITGCIhpVstjyUJJIlP6Wwhi4hEKPx4BesjuY6VocYZPMpj+HxB5pjpcuqKU0I92w4H58eqVbVwSuwa12rPGAVhlU4//4u66LK1F/X68dLqgcp0Weijk8pryc3yT4KFnKr24jtDMmgISiyP6qIbeVBmBMxH0NULk6kmo+TdtM0Nd2daB6ar0HBUhttivyju50HcH2aaZPXEJjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SEYPR06MB6456.apcprd06.prod.outlook.com (2603:1096:101:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 10:55:27 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 10:55:26 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] fs/ext4: Change the type of blocksize from 'int' to 'unsigned int' in ext4_mb_init_cache
Date:   Fri,  7 Jul 2023 18:55:16 +0800
Message-Id: <20230707105516.9156-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SEYPR06MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 44220646-14a2-4c70-c9d8-08db7ed8abf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ifQOvWTT/7di21/8iCuwVUO1tNfQXQW7mjuS6QMPUZwO98ft9HQKHtpM8S9d6Fe4bL+yz/4uKxvK31UCHUHqU8FMcUPn5wgGK+MKU4iXxiaXgN5KVXFshqQ7R95jWb2iNYM3drgPWDnpb9W+ZBoRcYSCmNVUmYq/a0MNlkPUrbHhFiIp815yJi+cttb5CRL9V09TbWWWS/qxBC4jWCCj7ltpReC4JqWtsladqJ/FPqY+gFOvpkEW7hBqGx96OtrLrql/yeCQsbNkFfLokkwYvYGjjsUsMbahGVceO+zg9sT/RfOYQRCmN1+3k97C5s6bcvrPTeob/2II6nzGUgGgMcIPmiI49F4rA29Ze3UWD6Gcdm5X+gFZ7B2Qup5SNsPSK9Q6tfDXca/t/oz0bOCUmTSF0WBttIdHKyjn/Wy8qAbBe2VZ0ecOJ+cdc2RZtXef07LmWbQAQ4wJ5hOyaNkyFcCDQxXxNRgsB+m32XeBWIxFs2Gw+NN3pWQq3UEVlt3RYaK5+9i3R0vBovxoRCP37aZnIGrr1ybN2QNkE4ssK8lRHQDXNP18Zs3c2/F8Q64ECsLoX/FoYgHuRhnv33espajzhc1hBogypWh76TryYoQaiz7cMNlf82wo6rL6KUhx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36756003)(6512007)(38350700002)(4744005)(38100700002)(5660300002)(66476007)(86362001)(8936002)(41300700001)(8676002)(66556008)(316002)(66946007)(6666004)(26005)(2906002)(6486002)(4326008)(6506007)(1076003)(186003)(107886003)(52116002)(478600001)(83380400001)(110136005)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nGWuf5WvUn7/kbztyYSGya7/qgzXnleQsOwLbww2CvJFU7YCM47rtVL4OdQc?=
 =?us-ascii?Q?rK9WXvt0AUe5Za0WXKMQ3SLVWk1P7Ajp42WbpRmCg/iHVgZ4aZGmMObwgySd?=
 =?us-ascii?Q?HvNQmFbOPEK76D90NUpxvw9cEGXmmSWWRxrfJEEIgD+66WHKO2Zzc1XHH9eR?=
 =?us-ascii?Q?cOccoYuQJEdeEgKwciyD0GiHuGiIRFgvHCe2/ur5PME2DdNTEXyyh59kj63W?=
 =?us-ascii?Q?KxSiZz3bN1zXmGf45OLh5Y10dNbBUXMJocg5U/asVtYpTKgUqzbMqNdrbX0F?=
 =?us-ascii?Q?5MU9WPHiZ5jYEePriHxOu0lJ20FX/y4KBOiiGwnx9M9Sw9VOdDzQ1yEpMrVl?=
 =?us-ascii?Q?4XRg6fAdJ885AMDYNJQxblRyNoYIDWTtWlgXi/yeT9Alufp0HuthmVXo+kzd?=
 =?us-ascii?Q?37iVPo2oisxwkaGKlgTbKDQGTEL8+c/96iXMy1nxy4+Je3zFrJ5M6+kIz/VT?=
 =?us-ascii?Q?iR86FsN1rXF1MpHYxVJHbH8WLewFlLLj5ewJ4UM6mrDjXQvRL9zTmOQ7byYA?=
 =?us-ascii?Q?Gvd9PO2St7XD86ofxa9cmbyZ01oIZUZHHe2xO9h6fSCvmaKhVuW5a/Zx7Wrg?=
 =?us-ascii?Q?w5PfWDUYKISYrPEaaXDUXLMy9A6cm0sLGQlrYwdhBQSCWLnM8naxpXnw8GRj?=
 =?us-ascii?Q?f06zfQjiSp7kMp+P1abjmQmghknSrSB7wyOz4GH3OBJuG5MzTTHMafBABjOD?=
 =?us-ascii?Q?RQ+BcKe+8CPT4GPEOasRjV1av5pMD4J6agq0XajzEW5Z6TtZDR7J71pscEGs?=
 =?us-ascii?Q?WQJuhMe7nLL35OHxYKUbsi9x686kzHSP1x/omywGQ16GLRGf0GGoQ1i9Kxqe?=
 =?us-ascii?Q?vIXnOSRSxWEIYEDVKTyPHr/ZquoIAhHm5SR4KxNRGRKnYwSmq/1r+T50Ang3?=
 =?us-ascii?Q?+LgKFhpJrv9w9ROQwv7jZ39M1XywBfbeB/CUx1EqAVAUx+MM1Q5m27aBF1Tu?=
 =?us-ascii?Q?IyRdKfARMEQBESVfwulYQy86V8kiEUlJuH8EiiDqlF8nLGdIQNQ/kCwejY8n?=
 =?us-ascii?Q?bwIsqSnUPOdlEreS4zA0lvyOAghMeI7jB4AKGz8u20ElWTMFrwPo5nWUNCxb?=
 =?us-ascii?Q?jz5dPiu+thQmS8YeHves2L68guo7tYy/JW6FjIzAFTzQwZlJHrtTSH5AbO3t?=
 =?us-ascii?Q?5lEDhAyCDIjI7+xecIouT/Z2672wcaiWycxS1dcy08ZdSE0WrR/jJFbqjZUe?=
 =?us-ascii?Q?6Q6jS3zfPpH0RrxmzQpm3nvFMk890FurI8zU6N+h0GuW1gYYwkjAbJZfN967?=
 =?us-ascii?Q?9irW1PzBJAMqyEvqn7B3LXyYXRBtWlgqb/J5/vLhB+px3Shm9b+s36uiJ2Tq?=
 =?us-ascii?Q?mg0bwR+yneIvC0ThceWFg6WPaAkZ2wzZ4wowgzRLpQG+mYybUMGV3nCt63h7?=
 =?us-ascii?Q?iFXjbCqHOYWlHHZwB0/B/0to2zglZnIeWALzXC+YFDzdUtSMoWozRtM2VBG1?=
 =?us-ascii?Q?KY7eM62zwIj/NctgVYRXiHkaOZ07OHAwyV25XVJFvf2fZO1lT2cjX7IT4aIu?=
 =?us-ascii?Q?C9Z87p6TyXjENjCxjW3xvVMU5xRp8wyGmxaIjIg/aSN0Ay4ZENaT+6Ds+xPC?=
 =?us-ascii?Q?fFneppiONzyXeYl3Pcu9cl16hhbRqfagR53xIDRf?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44220646-14a2-4c70-c9d8-08db7ed8abf2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 10:55:26.8057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEseJFgRj+a63CGzC/mLLH8pp4Up45ZyNAAFXH0YxdVKU+oXb3vUU7sjSfIckt8GkneDF8knVAsNlDi6DSI9mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6456
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The return value type of i_blocksize() is 'unsigned int', so the
type of blocksize has been modified from 'int' to 'unsigned int'
to ensure data type consistency.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a2475b8c9fb5..f087e1435e52 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1251,7 +1251,7 @@ void ext4_mb_generate_buddy(struct super_block *sb,
 static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 {
 	ext4_group_t ngroups;
-	int blocksize;
+	unsigned int blocksize;
 	int blocks_per_page;
 	int groups_per_page;
 	int err = 0;
-- 
2.39.0

