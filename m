Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A861369EC63
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Feb 2023 02:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjBVBfl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Feb 2023 20:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBVBfl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Feb 2023 20:35:41 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2113.outbound.protection.outlook.com [40.107.117.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C53E305EF;
        Tue, 21 Feb 2023 17:35:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsLwf/6XCqQ24QRz42E6uNFT7E8PN7QUvENCEZR0ZrPEHawWrU1+gVC4FtbJsVmsHdPSfeKfJ8euSMsCR6T5RfOpIBl6z1YbSoEZFpSjGCxJ39ehcFh1uJEsO0FwXkC9Voy1BMEBkj4JdIlyTpb+9DUjBdNewIKPTeGSEUvDU/dEaogni+sICnXk+DXCDrobYwZtrkjmZDK1QSHa3hBOAvcIrCaGiS5oRagklJIeD0UGm46Ua9Phgg6uGGKgCUAkh1U4QHPCIgn64Y9+2XOYOPpNf1iJqTS9mgWKSuT5iZtFHV9m+lAflRg7rnjN+ySZkmEQCh09r+fQpGWB1FLc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNZEcnP06XIzfTbuOOdq/jpXTznIqLDT4PzCwVLOJ+c=;
 b=T/P8Cf1n+5CA5aEpFocnPpV321PUORxtMapsvEfvqSGd/RHxxZ5Fu24tiQp7Ie1f6OHl1twR3g0TmgMZnooZUCIfS6SX1WoU5ZYlXfcpd0a4Yj4EsafKToPUh+kNngYG3/NPn4jDaADkleiBH3SrNUZuHEn7CfewJiKddQ7HLJuf4oLkwcH/XrgKkuInxAun1oRts5Rl85y4IxVy4E1dUPWzEMT3S30adYASEWN74xhz/L8V/Ls7A2jEknWGpx769Or1GI5xG7yfAGac4iIDxj/7wFRhBvejYOvzdHCLbneUnhOVg8eiVcB0cn+BBlrCVdZtpbXts7H9NtBgHhudiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNZEcnP06XIzfTbuOOdq/jpXTznIqLDT4PzCwVLOJ+c=;
 b=i5nswq0NrOhOU2wD3ycSEJePCPhFcxaEebElFVuQzXk7o4mzaYwYBSQp5AKSC8jOGLm+DrO4nM1As/s8uOPy2Kji7r7+D4STE1pI3Y1kfYs/ZINQC/aK28aLahOrdRWa7ZCCoChSh91wzDKb5/r7NtpZdX0lG/M5JztF8eM8730JsAGeT6tJJF9EteCmWI6X5jz47NzNcw4n5hFF6EVtbvyAR7XIsR2uAeK+ORYmU/KQyd+rcIirbRkTq5xJ+dUXF2qQSi25IPfFwu7SnFNB3gD7PEzMjuRcYxrnyGGZfw577CZjMKCZ9FnWrhLeEukSOqx3haO3Tfpq2uXDHijXug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
 by SI2PR06MB4044.apcprd06.prod.outlook.com (2603:1096:4:eb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.6; Wed, 22 Feb 2023 01:35:34 +0000
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::a700:8843:3175:1dd1]) by SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::a700:8843:3175:1dd1%7]) with mapi id 15.20.6134.017; Wed, 22 Feb 2023
 01:35:34 +0000
From:   Wu Bo <bo.wu@vivo.com>
Cc:     Wu Bo <bo.wu@vivo.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-ext4@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: ext4: modify the group desc size to 64
Date:   Wed, 22 Feb 2023 09:35:24 +0800
Message-Id: <20230222013525.14748-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0201.jpnprd01.prod.outlook.com (2603:1096:403::31)
 To SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR06MB3017:EE_|SI2PR06MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6269ad-743d-444f-c27d-08db14751792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSOuKHsiSna/AO/5PyFoqrbzaD8P187NKY+gMnWJV+4JDUHJSx9xz0MzWBhpk2Nd1gnAPI4YTHAlQNuVKGwDaHkGPrj5USYUe85dLiOJAglqHvjhyFE4MPSWBETcXz0NI1EZmWyNLnjaCPYyxZplTvjmTPfn14HB7xrkdZuhczBJEMLwQg9e+LcXhqEXBgC6vcaXwA3Y5DMDJifKExSPe/gie6yAb2XT9lRrY6VkljrVsA0QeWgV3FdtzhlJj68tKkWr2KwW4/9WdC3fDREzLwpPl+kA4TJsjunk6D9YLnYxvER1HgIj+/qjShoyRIJcmAL70ZW/hhqwyWvkuw7wqGTKIJyO9ew9T0kYCSmDdujxl1SwcJyGQqYtRLUdzpL2JeZBC+EmkkN6rkF1Bng6MLLqLGG/2l9jm+CztpUgTv6xeSJMLxfww5yLRZddTTYTRwM6dQHHaf1WjuIQLXC9aCgi4QibFdbouBZjAirlOKXwQXNyXwoWgc8OdWc7IU/r8fmcX7WF4zoUy5xeSAhUvzTYZaphco4IGEkLVhMBgD+JIJfsXzfiz6rpYqDl0XJJHhDVhWeU291tsh4UQYvkjjFy/0r+vNRM6UpK2UayIev48vpKVHHSUTeLSSRRgu2gx0S656vK6pKIvn8QIVDJkVaExkMVZeoleux4aMz5puNpbmxLxfA8mcGyccQQxQwBIC+XPP0+UHAb3KCaxrrid8O+0t0HSYbl2kHYqJNXuU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3017.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(109986016)(451199018)(6486002)(6666004)(186003)(26005)(83380400001)(1076003)(86362001)(6506007)(2616005)(6512007)(2906002)(36756003)(38100700002)(52116002)(38350700002)(316002)(41300700001)(8936002)(66946007)(478600001)(66476007)(5660300002)(4326008)(8676002)(54906003)(66556008)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mepzAc/Tks0Ufd8RxanfyOtzKjpadTF3AYLOswwp6HBKLF6D6pPVOTWTC3co?=
 =?us-ascii?Q?WSxGTP2o4fKQYCltxENF+FDZJycUuUz+avf2infKAlcaGp9nlhaDCYfd3ON/?=
 =?us-ascii?Q?HsG4vkNmd/tIKAhxUcKZPjGoMpGNfdyREGaN5wUONbAm50LwwULKk3U8SS/N?=
 =?us-ascii?Q?f/QZEo4YpEeuPNNq8o5k9XJreedNKM0vHKVyctvgQRMxyNp5nUzHMZg56CgX?=
 =?us-ascii?Q?mzS6No3uCSd6ukhUuleOGhcUC/sHIrAGGMN3RXoU9aJMdkFfRRcziy5sgRqo?=
 =?us-ascii?Q?nhFIKNV+bMJcjunLj6f3SAb85c1G78uXnmP53V7CTF+kyp79Oua1iIFYir/Q?=
 =?us-ascii?Q?ZmFM96YHxjYc6IExcwKhYXcQkZkV54/VTTjs2tthnabEjyQzcMTWnPes9qw+?=
 =?us-ascii?Q?fgz1zNpd6npaYFO2TOVoacIivaopsBo+m5AE9lwY2QGEp+OKHWeFNnwXneBM?=
 =?us-ascii?Q?5iuNH6kIzqKdhODvLOZtLxR6ddt3wzQjlfSyO/fhawplns0VATHVHVnaT2Zd?=
 =?us-ascii?Q?Li0G3QKks9gnpmcpbnqDJIbRsIb5DB21gbkq7f4ftd6CmdCBfOK4WSMTZZC8?=
 =?us-ascii?Q?ALPimW6vClVdJfBnobpGveA6nPOZZhlyuQRdIvEa8M04YYE3WHJ1yIg8jMqv?=
 =?us-ascii?Q?osv3oaynLBiV992fuHRfG1EV49an5YIU792AOA+/MN7u/Jl1tC1ya57OgUSf?=
 =?us-ascii?Q?iaIbysMO5l/GdLo6vAk9sHkhtIPnKXxaQiOw5sfVm1LgqP4S/uoTR+xQmXrv?=
 =?us-ascii?Q?nteE7k1hMrbVDcgAeY7O+pOy3ve08+MlmI49L36kT6RzZL7ftT3vyItXym0c?=
 =?us-ascii?Q?Ya9iM+1ufMImeeF+TrHHHBQpwZrc+K9AzsLRPQtoHrmOdh56pNNTFy9zs2Zz?=
 =?us-ascii?Q?+x0YcH9PouQo2NI65G+OrLQNiHFfZB4tkoB+pacbMesvo5EwW3tDwjvimJ/G?=
 =?us-ascii?Q?Nh9NxpVJMk5pUdYrLizWGFdXJMXNj90VvyiEfYGi35Fu7NbAfPcFd9K+QayU?=
 =?us-ascii?Q?o+/CjGleF1aZf5lbnzjl4gjM55vWMygpBXyoDRDB2KqIVbp6CUAVekmBCK9i?=
 =?us-ascii?Q?pT6u0oWs6xHSrRU9fll8EjIBzF4PuxBOsoOiZbi5LGgFb+nGSvNF0izoQnXp?=
 =?us-ascii?Q?/L3GiYmQ28aoCzryLmlWhOrgQDWk3Aj7eztfFaWfzW20OTkQqqVm7U05y6VT?=
 =?us-ascii?Q?DRg9OIgKkNCc4DO7Rcl8Cl4+I2xtF+Md0bp2LDeXiwgRM37vPnYeLGCGpVOX?=
 =?us-ascii?Q?qJ137EeU7k7cijwneP3d2qPWM/PPFkttm4o4veiPQ9gkto/Nr1DNS7UOBFyh?=
 =?us-ascii?Q?JCIlBsCBXf0zpOrK/vZ9Ees42ZyPudwe+0g20/5/8JbuTqB8wkaNOpgE/4SR?=
 =?us-ascii?Q?niO2vutHuGPY9kFfz1xaTNqIbS/xbIaJFBdGCpI2OB4GBWE0JutEanRG7uml?=
 =?us-ascii?Q?rGXT8vAyLyVJMnihlV3vEhGmv/3ADkBb1W/6XvuE8vi8A6bPq+4EmWbXese4?=
 =?us-ascii?Q?MTRRJeeZ3gD9C8wRio2BWxBtvbpafBfPFHNgAnHcrsTOd+XMjW8st9Rj+g5X?=
 =?us-ascii?Q?CDGvvzBErlsVGr0e4EmdAAgbnEGLe72C/uboe2s7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6269ad-743d-444f-c27d-08db14751792
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3017.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 01:35:34.5248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDR4SFB4Sg9f2gSt/ifAle1OT6N4No9YCqYndod8x1PMJn3OO+RBR+TfQJt9BbBi/FEijQAbxNz3C+AwndMHyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4044
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

Since the default ext4 group desc size is 64 now (assuming that the
64-bit feature is enbled). And the size mentioned in this doc is 64 too.
Change it to 64.

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

