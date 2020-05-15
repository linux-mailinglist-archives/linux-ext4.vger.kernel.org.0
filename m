Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140211D4AA9
	for <lists+linux-ext4@lfdr.de>; Fri, 15 May 2020 12:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgEOKOn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 May 2020 06:14:43 -0400
Received: from mail-eopbgr700081.outbound.protection.outlook.com ([40.107.70.81]:43104
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727999AbgEOKOk (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 15 May 2020 06:14:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmv8jCdfQovxf9f09Nu1ayW9dMRjl7AYO8a17LI1k6ct6j5PP9HThEgEBw15O4rhvsp0SaIRRKPF5X5R2PjWA7Zlr7jJpQNLl1fSFzvrsZAa9itk19v1u6UKeJyCnnVx5yFz7y/ypFksPmgxqfFJLy4mcOUy/QcHgeKJULyYC4GxlHErFl+/y0il7GrSJxMQ+Oq1ITjEnvdEq2CUkkL+SxJxtyihYvMBJg1SPzG1qTwwNneT6ccZtqdWh4Ad1uQ0fvbbPgs5QYj0XOWRjA6X6p6/YC0bzJ0W7TefjdCJsNQycCZyKgWz8+r3e2wlD1Dxo+Bz9X0bplVStFr0hQU5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sBykKiacna8DIwQIC2N0581tRK3nc8M/L0llZggvFo=;
 b=NrfoejGrkBo7oC2JgnpS873uU9PlHwGtSGtjYKofTV98rMsYEWL6cg4ztmG78m+dB1RZWVy9XLVmcVEDp5pTHXdKpVHHGGZrA5d4siaKmqns6uwULbRiD6diwIuQlLJ2fqDA85DJZX2AIfeW8hnlhSYRBbMMfFOrhav3lbNIpSthwuBa33HnO/WHQPUB4JmfptK1UX7eNmzxQAuh/bzoi5NlWJefq3dQTVNaOBYpitw+tHl6XvJck1reT8opMbbZdNHuI++VRBIUljKErqNVbbVMVaR6Y5txZDh1AwyyiynzUHj+f759iVuwGWfX9WboG0CLkzqPL+QTjFpO/gyqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sBykKiacna8DIwQIC2N0581tRK3nc8M/L0llZggvFo=;
 b=Wl1Svl6qaFoh10obuOXJ8LlBtncp3Pb5Eh85fyVIT+Q6A0uDmxI6AsgcOQ1gKFsjPu3zhMqGTaNhOtZDHCFzwm6OOM5q6tz3+GZYqv/SlOkvYz7GRWQUveUqEfoTCiFMOEbCvVy8LdyNuY4H0LsrKBjWnTeVTOpXP0Cg1OfwzQY=
Received: from DM6PR19MB2441.namprd19.prod.outlook.com (2603:10b6:5:18d::16)
 by DM6PR19MB4060.namprd19.prod.outlook.com (2603:10b6:5:249::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Fri, 15 May
 2020 10:14:38 +0000
Received: from DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4]) by DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4%7]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 10:14:38 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: [PATCH 2/2] ext4: mballoc - limit scanning of uninitialized groups
Thread-Topic: [PATCH 2/2] ext4: mballoc - limit scanning of uninitialized
 groups
Thread-Index: AQHWKqGjC/tPhF2lAEWso3gCPPPysQ==
Date:   Fri, 15 May 2020 10:14:38 +0000
Message-ID: <D17C7F7B-D0C3-4483-A949-036F3A4BAC33@whamcloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=whamcloud.com;
x-originating-ip: [95.73.85.160]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dca91191-d4fa-48f3-7dea-08d7f8b8c676
x-ms-traffictypediagnostic: DM6PR19MB4060:
x-microsoft-antispam-prvs: <DM6PR19MB4060A49CE75291A0D4D139EECBBD0@DM6PR19MB4060.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rLHWmnkh+L9JnAMCrI9KHd6wfikOTZe2svf20j0fBZ7GgqxAMSz+sXLSv6OqK8muBeNhTQM14Vi97e0NMTL1B6Pcckyty9VH8JLMplUH/hVT6rKOQ9zT2fhKYNbrJ60SY/BbPbKx+CUbUeWAk31xmnb46aXS4NaSHCt3vUA5WakqorFvAub98PZtY3EY6i8OH26/Fgr/XNZrCWlwrh1W8r8Lywen1JNQIsbljiOxk/UDI/AynYlSi0Wec3XuWyvy1VnSGwy6BighiOrIElrO3aWY/4Me8+Fah7TgDUxd3nXoTELg2EJKt2zL/ebi8gf1ES8bCn0pGm1yJW3Rvu1ZlHLYBwEJRidK3j0jHm/N5jWgPlsJWSnKlygRvBNhfi/xv6/181L2/1IBA908Ky7o4QZBzPqjtG/MnfYd3TfA+aKqd75cfv7i03tIZAd9O+6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2441.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39850400004)(136003)(346002)(376002)(396003)(36756003)(186003)(6916009)(66446008)(8676002)(6486002)(64756008)(91956017)(76116006)(5660300002)(8936002)(71200400001)(66556008)(26005)(66946007)(2906002)(6506007)(33656002)(2616005)(6512007)(316002)(86362001)(478600001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: t5SlzPs0pAyLX1Za/xb+DrQBXhCbUM5ILkhSiGFX/dCcNmCJEwSVlIh1gT9A7E1hgl4wzDYkqrPCSU73kG+3EV6IRLAoGJnVXtJ69SUcHqgOaK2xhB8HMtKfTKlQ/Ghkz4/CHqmdWSGLgNobuWwM1p4YhenOuGJ737lPbltLhMPtz1spZnl1t7vmesWxRV43XIxMlGHAhZLFahHS/VAqpjslGO5MOSolPVKkDtO+XILPlRL/078QOQu4APnZYyhfz9QbVQ+MQqoFPf+ySlYdkYClRkdyJCo4jGIabNs6ge5fV5hYqPpUN3xGPuzqaP2ChX4hltaIrlFMn1/m8y12ozVD/VQM6ntLOw+xHH1FWudD0XmCJGF8y16oBPOCkbb/sU3WH9SMqdsxnyQilt6IXW1nF5mjGDPU76irn3LCkUFblkADnYBOWDWVSxMaCOGacr9N7dcqHfLtM8rAqT0WhlmEIGwKozRsmfsfV7030oE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <012088DF443C674F8416725D89A9BB92@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca91191-d4fa-48f3-7dea-08d7f8b8c676
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 10:14:38.2440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fu0qeOVqzBADRthZ9fWBUZgzgx+TtzyRUNMBXCk5tRX5wVggemcF7Bm8pXNtNRmIFM9Jm2Kpbq5Ie4rF/3wknQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4060
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

cr=3D0 is supposed to be an optimization to save CPU cycles, but if
buddy data (in memory) is not initialized then all this makes no
sense as we have to do sync IO taking a lot of cycles.
also, at cr=3D0 mballoc doesn't store any available chunk. cr=3D1 also
skips groups using heuristic based on avg. fragment size. it's more
useful to skip such groups and switch to cr=3D2 where groups will be
scanned for available chunks.

using sparse image and dm-slow virtual device of 120TB was simulated.
then the image was formatted and filled using debugfs to mark ~85% of
available space as busy. the very first allocation w/o the patch could
not complete in half an hour (according to vmstat it would take ~10-1
hours). with the patch applied the allocation took ~20 seconds.

Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
---
 fs/ext4/mballoc.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 30d5d97548c4..afb8bd9a10e9 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1877,6 +1877,21 @@ int ext4_mb_find_by_goal(struct ext4_allocation_cont=
ext *ac,
 	return 0;
 }
=20
+static inline int ext4_mb_uninit_on_disk(struct super_block *sb,
+				    ext4_group_t group)
+{
+	struct ext4_group_desc *desc;
+
+	if (!ext4_has_group_desc_csum(sb))
+		return 0;
+
+	desc =3D ext4_get_group_desc(sb, group, NULL);
+	if (desc->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))
+		return 1;
+
+	return 0;
+}
+
 /*
  * The routine scans buddy structures (not bitmap!) from given order
  * to max order and tries to find big enough chunk to satisfy the req
@@ -2060,7 +2075,15 @@ static int ext4_mb_good_group(struct ext4_allocation=
_context *ac,
=20
 	/* We only do this if the grp has never been initialized */
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
-		int ret =3D ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
+		int ret;
+
+		/* cr=3D0/1 is a very optimistic search to find large
+		 * good chunks almost for free. if buddy data is
+		 * not ready, then this optimization makes no sense */
+
+		if (cr < 2 && !ext4_mb_uninit_on_disk(ac->ac_sb, group))
+			return 0;
+		ret =3D ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
 		if (ret)
 			return ret;
 	}
--=20
2.21.3

