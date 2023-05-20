Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D2470A77D
	for <lists+linux-ext4@lfdr.de>; Sat, 20 May 2023 13:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjETLRB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 20 May 2023 07:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjETLRA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 20 May 2023 07:17:00 -0400
X-Greylist: delayed 1980 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 20 May 2023 04:16:58 PDT
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E1412C
        for <linux-ext4@vger.kernel.org>; Sat, 20 May 2023 04:16:58 -0700 (PDT)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168]) by mx-outbound-ea15-94.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 20 May 2023 11:16:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOgMuJpNnuNP7eFNa4JrYlmRqtoHkQkkL+yTr3sh/xkd/uMaIB7uZG+zsyOkHxVUwUR5cRseCJ5ECGa5zpPoULWqcl66G0swSN2Zdeb6LMEEnWbpm3VEqF4kkEENk8QP5Yif98b475QZGOqoJ5MTO3Lg+2kzgPvLkMtdWppDhzlXSB6owpqAf/A/hp55HyltQkq0vWTJJvOg9XR3/cJHUWZ7d3CufW2N1M3CG+wkV71iOd81Vp9SUiPS3cm3PMPkaH2r1A0Et+EOigu/SDrYxNLMvbK15jKnLYqG88UJ+0+u38ngNgptnKAdTji01+S6Rt8YjmVa1SGMiA778dOxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVeWJJke9fmpdRAwNinFJeuEfTbWU4vlBYsHWdEdvgk=;
 b=QtFytGcf4fSCrDIzzyDf8zL0vi+UPVa8yASFQWR+c8R94V4pJbgR4TE6iCIgYr27Zy3LvPv1gW0qxyODcYTeR7tNlln0nGpTMq5LGr4r2bScj05JpqQlg8am+/Le1+B89JsG72zQ5X1fsVbN4kSMhSuzBkubTSZM0j/qFOYVSOcNbY+1U4kwSpPMXbfC0wR+qtrysdOmz7j/vgGCbHsVdfrQA4d7M5bbyjeufBEzWZ2WkX2/lv+Ejy3eygVphLJCkbkjxOVC406ovIFzgsytwbm/cg24BWOS+risacxFGSN2zvhBRsnZw5PoKwVnt4VKEl++FngB2SuZaj6q5jrTEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVeWJJke9fmpdRAwNinFJeuEfTbWU4vlBYsHWdEdvgk=;
 b=EYDWk5TY5JroeU37sKaoOAWqDtLv/gAoq1pEt2OIkBXyBNeJW4yr0ebJ/VlhCvqs12pOSYinYzWGVBzMcDvmMNYMXSKpF4rip0vF4ut/TMyx38QhG1WXIqf00T0BdH3DH9ouia5jRzMaVEXuFHzlQBnt1xMSBlVWpPE0MQkT6Do=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from BL1PR19MB5700.namprd19.prod.outlook.com (2603:10b6:208:390::10)
 by SN7PR19MB7020.namprd19.prod.outlook.com (2603:10b6:806:2ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.8; Sat, 20 May
 2023 10:43:53 +0000
Received: from BL1PR19MB5700.namprd19.prod.outlook.com
 ([fe80::e2a1:2d6:1810:b831]) by BL1PR19MB5700.namprd19.prod.outlook.com
 ([fe80::e2a1:2d6:1810:b831%7]) with mapi id 15.20.6433.007; Sat, 20 May 2023
 10:43:52 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca, lczerner@redhat.com
Subject: [PATCH] tune2fs: fall back to old get/set fs label on error
Date:   Sat, 20 May 2023 20:43:29 +1000
Message-Id: <20230520104329.2402182-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0131.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::7) To BL1PR19MB5700.namprd19.prod.outlook.com
 (2603:10b6:208:390::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR19MB5700:EE_|SN7PR19MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b51fb1-4959-45d1-5f8b-08db591f1a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNP7Rea+Zyhih/vMBLVIaREGxwlfMR5AcZHdwbkoLiTThGaZ4/u34RcjZMLhXi4536hRwsgBRPp4usKMpFLz9elio81vlclag/KXd/KzmNSXGu21igM6lX4K7F9IN/nXFQxjPs823rhWruVSJKIJuYq1nnEVoM+/b/VLExMVMpVNdGsfguYgJB7POme55/mtFY0R7niiC/xqc72iHvKuLPOZEpXFYbavBw0ogbGaciJGUiJgD7Jqz7E4sY2bWuxIygupzxnO/Uj8N9L9T+12E7Ts4KrwA9oNk4/8D8ccTHN9ojzSYI+/GnI9e/ODypQixD1VFkQHQsyROm2koSKfuxdgjzlCRwsBe7eYY4L1XnpgTqQy9xXe1Y2s1kkYvJR2I0yCrpGWNLA4JLPTxpX6huqOxyG2uSUnNtx9uy1PVgLa0eM2Gt09uUKXaXn09ujKJNwLr246egNSP6Ni3dateTEgNz2hIt3J4W3i51X0gHTtJ2kTFlaYIEWhhIS33HtbvV89bGM1nPdvC4pdzk7z81RpJowxkNXjR9ic6Iqr8+U3NQz4A0SNvKWV3PIlK1yb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR19MB5700.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(376002)(39850400004)(346002)(451199021)(2906002)(5660300002)(38100700002)(36756003)(6916009)(4326008)(66556008)(66476007)(2616005)(66946007)(6512007)(6486002)(1076003)(26005)(6666004)(55236004)(6506007)(186003)(478600001)(83380400001)(41300700001)(8676002)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KRhRE9JoWH9AcY2g4CGdI1CpkcuUdudmVodOry+s2WaIlpckvzOfTPvHYj0x?=
 =?us-ascii?Q?STB0iud4h4YCYJb8e/v4w0Dk18zJF5BI3EDAzhIideo4mmjdQ23l6Qhddy2G?=
 =?us-ascii?Q?Y0Ct5jOW6AvVchcqG1gPsekQfVbAu+vnXp1GTEirw3WST6v6LmJW+rV7vowb?=
 =?us-ascii?Q?qubOQbZyh4aeovTqEFLpQ+Pr7KVzEI4mXiIRN7SxqqDuCSTObc7xuQPxwpOV?=
 =?us-ascii?Q?k1r/wiJmZfTa0hrbxLvjiawKM1Wwq40Rw+0v14pD2/SxR0cKPZujLxZOikQe?=
 =?us-ascii?Q?NXrlKRLdAlpIUca9yOljH94x3Fl2CG4QRacGXUaTa/YSeNu3HHtFsVECxdFs?=
 =?us-ascii?Q?WMG7wVZarsRXqU3+LgBGMXVz+NadNmwunEb5zm7XxfPtrMyfU07ca9Gn43eY?=
 =?us-ascii?Q?8BBOLplxBsaQm4hf4HyEPOK30V6NUwza+LYt7/wHb5x2ciQnAUCqQiIIklew?=
 =?us-ascii?Q?//681tjV9dZCiLvR1i6PRs9x25Mlq5BvoXDHK72KCVmF4s66bwycwI4tBJxL?=
 =?us-ascii?Q?9Sm40JGgDXFsEs0rQjjvEEtpRAvwepOXhyNaqmddnvD0uvlHaWcI8BXVBeoO?=
 =?us-ascii?Q?pzXgcBXX/MnDaqxU6k5I6wyLuDKezyCwy7UFkQG44xOqex6MaR0Ie9AQffGQ?=
 =?us-ascii?Q?WRfGc6ZDAJTbOU0NIpvirL8N5ZkpILQS2dPK6FDDBmLFJcbNxh/P1r/vy2Bi?=
 =?us-ascii?Q?qfr+YKDxqYbw0q3M7998oyV+fvQvlcnHU2U60txNxZfllE9AlBgfnAW5RAeU?=
 =?us-ascii?Q?WW2WDRY6mY21E6zgjmtRZBKGTnYumVSQTdWHLjuY45lCjvA1I+0Droc2zOLS?=
 =?us-ascii?Q?gpjURjxp9KaWbCeydRzh8U+ZEWvmYzoLoFS5ME3zq/c7lvNq/UmMNt3k5j6y?=
 =?us-ascii?Q?vFe5WIrtGbfIQ4UHandU1ws96WXl0Cn8IrbljBlWXysCW7HohkLrg+tU+4wq?=
 =?us-ascii?Q?qW9pSuimMCJ/VtHEs2H4po9v43tK+Mp8JsyY2ccIVXh0OZfmwmPU4jHNqeGC?=
 =?us-ascii?Q?pZkuMCNcBO/s8XwsN4JPNanekJX4a7xDC0JbZjSUA131l0BPmb+l+IAnzi8g?=
 =?us-ascii?Q?qr7C6prMNf+3zH9v8RNGIvdoqX4B3ekIeggTrR1UNP4nddlReMalXUJrkgJK?=
 =?us-ascii?Q?/JFZv683HsZPW7lbpEfMHK07XomRMnCHSZTsCHKfT24Rl6xgtJ67RFE+mJcA?=
 =?us-ascii?Q?y5sjLsuO71ap8S4Jztgict1X+mazKTUaCM0YzArIrU8VMl/cS55xXfxolF9V?=
 =?us-ascii?Q?aWPcFvo2einRckCPEnu3U0ItIAj5r7Mw5loQv1ytDJLfz5hMtWIiEuEStSBa?=
 =?us-ascii?Q?fx8ZxlOOkwYtnlQ8ZA7Mwo7+O3ZgZXCKaqk1tX6ONV5UwjK4mcbqtXg2+TPq?=
 =?us-ascii?Q?IxkZDbefutwO9/zTgZtwiSCLrJxwqicFNYT7uN+WpU3KQy/fQv1PegbUtJYv?=
 =?us-ascii?Q?kKgfOQmJSpok0oDFn8R/AONJPO3PI31bTPpO2TAMMpXiL5whJwQ9ptluFCbb?=
 =?us-ascii?Q?th/ZhkyvBV4kEziz6anE52kewTiWsQCLwpKAMKlGkF1o7BQEKvhqSf2IysXg?=
 =?us-ascii?Q?DJL/XGWuagvcvtPLdmI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZKGCnMInvTDO7w3HBU26KhyVX4t6sxbE7FW89DKHXBH2F2ayJzMLFJ3BpBRzZ+tmDnFF8/4/8FlHy58mXUQzMWZI9xpPgHoCSaafdVySCf8itEqPTQPPZASo0buLE9PhxtLW/cZsoVSeSEi8iH5enL1nir1B9JUqolYetMfPliuK9clKTr+sGmsDkH+hB/WNgHjOKYHHyJZ1OmlJxE6XhGdAlneuiqV7EA067u1zrUonUQQIWUypIoMDlFGVP84arhG9f80ETyxMwciLhxeiVex2tk3Rd6LjCRwlCUFor4zSQEms7FjS0wBlXa5aF658/hz9ovnc+M5qWS2uceCC0ztSkwNlyy5X5UP0BS0zdU1h26mmJDoB4ygUZVppSMxdOJcEeNbjg6F0ej72/xi1yIWrdeOm7gQL6M+s6Bk2+P/YQdiDVrpfH1eRvlPIKMU4ofVn7cqRijgDXyZADIfucPVzmXYWuh/xBLx5JBCDKMCuQ+oz38A+87q1R1dbFbgFO7lBJ2WC2mHr1y8c8Ghot7h3FlN5LPFMNogW/98PqkQ5Gsyj3oDBrZmkbT3vDKk0nO+2y6aFYSzzZBTyllssuxAspg8zyNajbtbjiw4etStuGIA2R20H+gFuHLGbF4BXqH1Y7fLYkUoppOpd9f/dKnvCZK7BcE3Bbrg3Y9OXCvfDjLW0MUGj9U4GOi70cdy6Tl5hAQ4YZ7maiDwpf5JjJFUPSg6es2u8Sjgkl08T1OWZ/sTOENRkxmp6LD5HSIV4cdMOHLtHG0uWcHbF6VSM/Wv2GXpceo4YwsNCrKnqkW1RxQBFaCp03GjVJ/DDeWgvzTmX6rbb0I8UuWC2u6CTTOzF/zJid4U2zwE3tf18yLc=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b51fb1-4959-45d1-5f8b-08db591f1a46
X-MS-Exchange-CrossTenant-AuthSource: BL1PR19MB5700.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2023 10:43:52.4620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EyFZ3P6PHUbKYgku3M7HjrehHHoyHvtjPzTMGlg6BgvLsT9GTWXKJrG1+Ro/xiv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7020
X-BESS-ID: 1684581417-103934-30571-194134-1
X-BESS-VER: 2019.3_20230516.0025
X-BESS-Apparent-Source-IP: 104.47.58.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGFpZAVgZQ0Cg11SDVLDnR0D
        DNIs3S3NjC3MTUwszIOMXSwNjYIslMqTYWALwyMGxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.248281 [from 
        cloudscan19-178.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If we fail to get/open the mount point for get/set
fs label ioctl, just fall back to old method and
silence the error messages.

Fixes: f85b4526f ("tune2fs: implement support for set/get label iocts")
Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 misc/tune2fs.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 458f7cf6a..460d81c9e 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -3096,24 +3096,19 @@ static int handle_fslabel(int setlabel)
 
 	ret = ext2fs_check_mount_point(device_name, &mnt_flags,
 					  mntpt, sizeof(mntpt));
-	if (ret) {
-		com_err(device_name, ret, _("while checking mount status"));
-		return 1;
-	}
+	if (ret)
+		return -1;
+
 	if (!(mnt_flags & EXT2_MF_MOUNTED) ||
 	    (setlabel && (mnt_flags & EXT2_MF_READONLY)))
 		return -1;
 
-	if (!mntpt[0]) {
-		fprintf(stderr,_("Unknown mount point for %s\n"), device_name);
-		return 1;
-	}
+	if (!mntpt[0])
+		return -1;
 
 	fd = open(mntpt, O_RDONLY);
-	if (fd < 0) {
-		com_err(mntpt, errno, _("while opening mount point"));
-		return 1;
-	}
+	if (fd < 0)
+		return -1;
 
 	/* Get fs label */
 	if (!setlabel) {
-- 
2.39.2

