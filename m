Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1A61B95A9
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Apr 2020 06:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgD0EDa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Apr 2020 00:03:30 -0400
Received: from mail-dm6nam11on2058.outbound.protection.outlook.com ([40.107.223.58]:32193
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbgD0EDa (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Apr 2020 00:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZ4g3fZWJsOdsFkOC8183vMNSVDhBPfZf+SSydBCFvk8WvNIMGvptSfdTDURzVmwEl9mvVJYGRGmW0itI0QRUMISgSEKP7ioL1DKJxanJsKkhkfnMacHCcZHUJLgc/mSA3r5QoG1TUDn1NZPjCigbtp5X0tag07tncwcmlGxucyzgUobIctWxFj6cKp4u+jV/TxhIDXFaSVrTLwWpXc8KwG3klh0MPAkIPHxF5uC4I83BgV/4guzZE+MHTWUWpU9gG7RSCU+RGew4Kt86y3wuApp10t66EK08cm3M0351AqsE/yqgRCgxQzzGkCOy+0zuqZSmVCRePYpbIURTHlcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G1ibupKuT+5J7v99gHoMub6DCn9U+lkAbTSXaRR2Nw=;
 b=gkDXLmnTzK5ugrILrlNBVlkDyG/JU7tq4bE2SSM6OwjBUt7duCoRdPw+b/ZdqN8P7Srzs88SwxW7TSZTD72u6n6i9/uhaTLZ3ZTQs4TjmaLcmU8X4JfPWpdkVNvOAEG42r+IghuiOEj6eG/Ha+wL/roiSflFqHPSFD1eLBaLbNmJpvBBLEi2MvubHRu9338MEos69ckVEpGM7cHeaihfSmbKUDdYyaBWsh11rtB64DRzf6jUaBOzknf9tRa0AftLavges7GphM7ceht9GomAam0Y7rLsNxcEA6aTXpxJLBLlP5tMgUZ/cJhoh0HRUMcZrGZPP8TU3dRM1KVfPIW17A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G1ibupKuT+5J7v99gHoMub6DCn9U+lkAbTSXaRR2Nw=;
 b=EhYCkJ+MESfD8+y7GUj+2lX6Ma1tbkJ4JKv+g2ixPQHR9z0ftqmXgVvnWqOcMDplSp/mrVwOw/p6Vf55o7yVE2/ej9FbEEGkNNoEnroCbV0H630ZZO2/usFzLBJhOyWLzCM4zsuPMpC36kDYT5pNWAwsDJLHY1SHwoYfrjMaFi8=
Received: from DM6PR19MB2441.namprd19.prod.outlook.com (2603:10b6:5:18d::16)
 by DM6PR19MB2363.namprd19.prod.outlook.com (2603:10b6:5:c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 04:03:25 +0000
Received: from DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4]) by DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4%7]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 04:03:24 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: [PATCH 2/2] ext4: skip non-loaded groups at cr=0/1
Thread-Topic: [PATCH 2/2] ext4: skip non-loaded groups at cr=0/1
Thread-Index: AQHWHEjMB7oRIPFrfU+3AQZmsRdo/g==
Date:   Mon, 27 Apr 2020 04:03:24 +0000
Message-ID: <0B6BF408-EDF7-4363-80CD-BDA0136BF62C@whamcloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=azhuravlev@whamcloud.com; 
x-originating-ip: [95.73.42.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5331e79-b4e9-4f23-dc1f-08d7ea5feefa
x-ms-traffictypediagnostic: DM6PR19MB2363:
x-microsoft-antispam-prvs: <DM6PR19MB23638B1791BC9971D838C292CBAF0@DM6PR19MB2363.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2441.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39840400004)(6486002)(478600001)(64756008)(66556008)(316002)(66446008)(66946007)(71200400001)(91956017)(66476007)(5660300002)(36756003)(186003)(966005)(8936002)(81156014)(26005)(8676002)(76116006)(33656002)(2906002)(86362001)(6512007)(2616005)(6916009)(6506007);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: whamcloud.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FQR+Th1UkeRiCd/Zmm7vIGEeVGVtBbkb4VwbD9AJyVBAru5nZ9flj2Yv2mENH3pZHA/1aIyi9lDOXEUhu+bTI806YvhL3xAzW5Gl99XAkGKR7kCgBS9a3mO0SA3iNYssZZbq8kTG8uMQRe/2Cs//G/236EmkTUw8WAGIeROpsNwNOU9gP97yeZpJVtiSx9PmXHUlMstXL4QwXgvGtuZbW9BEgyLIlEd2TiGH65PtW7bdgRfA2byJ4nbHCtmWUhcwBdLry0tOcG8cvJ37QFtOJb3cH3yoIvNCaUlAejIzUxwCfJVkVZsmg+2ulBzoVqjpuvPbHbq1QhqGq5Mywo646UUuWKXYnBx7nKg2aSPlsw3s6oCu0gRg7fakQ+1Hr1Al7SKodg9TZ6VgFE/yDGIjo41MYRsAmIRbdiV0VHYr1VlqFFjyHXIp/OQPVlwRCQvSCAsQNW1kfo1eAzP5JKxyqIIWnrZi6i7fkT1i0Z4FyJWnHcpe0966BqkpIS3dTuh6nf2X/tWhVGEek89JRC4KWw==
x-ms-exchange-antispam-messagedata: fIlORyohG9mr0SbR6JhXQDTmfVmWNXHs2YQ5kNF80FAD6utqqhCOMgHDlWJK7VlAMIJKx/CsZqzbbd0SYUR1RoP47P8bG1UOq5uwZ9c46ahWajXyS5Tcs73ky2ovGfTJBimeWAoE6TpuTnqqkivtciwFBneJtQDbOnYDZxRsEjTsA+QPd+SK03o0wU4PPnQp77EoaWLRxsjYEmDfi/CBbapSeSHL4GILs6jXJk00wgJsYDUlXc/B/jgnKecBsv53YqmAzg/YlslZZxeUsxIcDq5SN4qpgt5bDRMflkEQya9HL9rs0FWWQmtUEo47wnemlg+pVRwz88Va4DsgU+BXVuVfGtOl6Id6z8IFjq4ImwswqsKglxBzkpGBQMSUkI1E03fEcZo9BkPAJwsZ1ezZFxbWLasCI/PonsoiWVyWkamLdl6fYRxAD5b9PveSQE51D3v/FHQDUs4MiJd8K+alW2MXg9fsxzlQxqlnvuaYiVeu/vwBz3n/DoWD20giQt8Hh4C6v02QR1FUky7CNRMcVtVGkSIwdNbCNB87e2GwHegknb7HtOzt3grDpzK+f9Jp+md6ArzrCHX8ZJonWL+1iFl3gAcNnd0XriuSDqcGCdP82ftPFaPEz0gY+Od3Mf6nVaiikodmakN7PI421ztcMuNe9APq9HYAtaxAaKNks7tXulRq+ZSCjQTzP5c9mS6ALjodUBGt8T+sdKKtpwDU6sTL+pxd7XmGqvz9h85hOOOLjT03sunO5Jlpp0k32zPkM9B8ZNqZr08yGE2+ogMDSjVRrhCijGXlP2n+lu7PrvY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2803DC2CCF1EE42A899F99553D06E06@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5331e79-b4e9-4f23-dc1f-08d7ea5feefa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 04:03:24.7095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9rTrQ6n4q+yNA2NRTq/e5OTXS55yBsVcWOkBl86HYxn3L7BtE1962dzDP+1rBOp/W0Z3fSUqGW6Nqufa3hHW5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2363
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, yet another patch.

cr=3D0 is supposed to be an optimization to save CPU cycles, but if buddy d=
ata (in memory)
is not initialized then all this makes no sense as we have to do sync IO ta=
king a lot of cycles.
also, at cr=3D0 mballoc doesn't store any avaibale chunk. cr=3D1 also skips=
 groups using heuristic
based on avg. fragment size. it's more useful to skip such groups and switc=
h to cr=3D2 where
groups will be scanned for available chunks.

using sparse image and dm-slow virtual device of 120TB was simulated. then =
the image was
formatted and filled using debugfs to mark ~85% of available space as busy.=
 mount process w/o
the patch couldn't complete in half an hour (according to vmstat it would t=
ake ~10-11 hours).
with the patch applied mount took ~20 seconds.

Lustre-bug-id: https://jira.whamcloud.com/browse/LU-12988
Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
---
 fs/ext4/mballoc.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e84c298e739b..83e3e6ab1240 100644
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



