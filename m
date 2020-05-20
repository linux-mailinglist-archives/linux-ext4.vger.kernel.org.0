Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE581DAF21
	for <lists+linux-ext4@lfdr.de>; Wed, 20 May 2020 11:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgETJpk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 May 2020 05:45:40 -0400
Received: from mail-dm6nam11on2058.outbound.protection.outlook.com ([40.107.223.58]:19842
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbgETJpk (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 20 May 2020 05:45:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND3+lbRZPXvz7oDlti2GmdLxFcXSTkJQ5oAJZFEfNKD5X+ZBzNCSBUA/oj/ayCIvvCKN8xN76RImM9QTKwql2vD9mmG1TIAQVGVbqSc6b5tX25MCOiaDhAyHcLAqPE109PY0XbQECnuMMwapH2sxiDZoZQyFA1qrFqhjFqXeg53ql42mFMIWzO4WtTp5TOF0PzL2tFU7C5AePZobGxLHCOINQAQGlphm/cSX6ckVknilumrGvzhHWYCZsdXMqRbs8Ecm8ZrUwtufTe76NelgJ+qx4mXP35kwKW3ERL7A036MdkpC2NgQ9fa3gumkurn/Vryb0C74nVF3ek8uIGGx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMR5bRlkfLSFVLWhLRLlPQ7n/yAvEIxsrsHdZ67ZU5k=;
 b=he0C1jSFaL6CWYO3JwJGWbqyJUvMeqhI3nX9um6rp6LXkTt5m+mIuCgDOx0rgv6XbPM72JPAMRP9NB51h+kfNiDx08tmFQu5WxLL+PSCH8OBmh/np/cCiXX5wlqxo4ObqqHlMd4AZM1zio+LgSVhkikYD1+MhZla5n5akfZtUv+EzsYrRnEl2aqWlfoOwlxijLZ1o/kjkuO77iqTZ8QDXQNCa9JD0kUni8dYrUn+ygppM3+tC2awb9kAdpguOlhSQR29lYDzmPvUHbhOaIX43MG6zAzlxBCW1slUam5yqZ9R2Y14Nv82w4vTgOHY5L/RLYeFfPqbk+SvvrLJMCqgzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMR5bRlkfLSFVLWhLRLlPQ7n/yAvEIxsrsHdZ67ZU5k=;
 b=wG3K0eti5MBsZP1ghDdCfZQc05KgFEJv4Qe1Deeihax85MgGnAX4f9AKDHDbOpgWBgR2PqaL6aBiyBYVVQ+y3X61BDk57p2QP8F1Y9nIvX40gtYb+24eZXJDlv6Ms9w8TP4j+wJ2HMPdgkjWfuEojSW4i4ZmtGV2yoZn2RTQ6UE=
Received: from DM6PR19MB2441.namprd19.prod.outlook.com (2603:10b6:5:18d::16)
 by DM6PR19MB2378.namprd19.prod.outlook.com (2603:10b6:5:c8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 20 May
 2020 09:45:37 +0000
Received: from DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4]) by DM6PR19MB2441.namprd19.prod.outlook.com
 ([fe80::b111:c44a:87ea:4bf4%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 09:45:36 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: [PATCH 2/2] ext4: mballoc - limit scanning of uninitialized groups
Thread-Topic: [PATCH 2/2] ext4: mballoc - limit scanning of uninitialized
 groups
Thread-Index: AQHWLotqWUPyoTh+2Ui1cgAgxU2TBA==
Date:   Wed, 20 May 2020 09:45:36 +0000
Message-ID: <48DC3E7A-AA4E-494D-A520-3D301FBC573B@whamcloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=whamcloud.com;
x-originating-ip: [95.73.208.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f4a8972-0b39-4fb1-ff0e-08d7fca28c92
x-ms-traffictypediagnostic: DM6PR19MB2378:
x-microsoft-antispam-prvs: <DM6PR19MB237826D0AE239022EE3D6528CBB60@DM6PR19MB2378.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b8iJgu4+eJuSkZM0B/mW4JfAS7qR/8Cf8eUSohVoTkKDK6bgTe70nRuS8U6KQxrcN/gVD7yIBN+UFJj4aTEDEzopXKbJlqpd0iGwGM7wa9avdVWVVaZgD/c70/MDLypHLRZucwCeE6qJcxmeVC3WyNmZxizG27tRHltvnXHDogVxgkSV6DTvSwjTfdTGccYrh04TwkZ3H8nEhx4z35JwSYq2ksdg/DcjmYbMHkia3gxpKbN638Q35qRsm5jkiyMYoKy6rCb6Dvt4msVzMGphjXwMTuv0bZsJN9xp4EoE+tbpxvFnVsc1nsNsuiZZFhnKNi5H5AkZp0y4/hN25VwezA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2441.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39850400004)(8676002)(6512007)(186003)(26005)(6916009)(36756003)(8936002)(6486002)(2906002)(316002)(6506007)(76116006)(66446008)(91956017)(86362001)(66946007)(64756008)(66556008)(66476007)(5660300002)(2616005)(71200400001)(478600001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ht1n7NoPf5R8Ow4kM6tD3Sh4mHdyE5ND2EbeT/arp6S3n4hrZmQ6kAUkAFsVVdflbpvohRNqP8gPlpTz4RBKd4XbL8I/WcJrF6pj8zugtJr14iDRrjKp3T+V0G8NnCoacfOuKW9eT2Jdel0yeh8zgRyTPKWlSDWvdW38qjnyQQA01rTrr+jbWc7sNYCxjbetCtHNZ+ljDPd/onddo1fR6+j1oYmrEJkAAusMCTWnCsgGIIwnUpl0qGYgMWns0mrhV/G2jsQPe0T21Hyd7sUNljMZJQ8+xbue2iMefaCj3fHQs6MrOF/4HIUJ2pn9H7vQnKM6Fi6/4z/u4bpDKdUMSuQNxDxelaIX5niwRC6Sdu19ubbw0Y3GpiFrRmPd1kWFnq3DddGSt6ZgpuLJEB1noKjTUwXvRlubmJGHVKTHg0eaxjkaqE3Bv4wJkKnoJKDifZkOzNg97OIxVFRXsG1k51jBOlv1LmGvs+t6YRyLZjE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECE18DECD0229E4B991270C1AC1096CE@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4a8972-0b39-4fb1-ff0e-08d7fca28c92
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 09:45:36.8330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPVZME4rvvokm99srf+6wSVYi8hrnZ+ZzW1ETJMOirWueZYijuY9it4sbV1+R+puyi0M4ZctA4uAj9baveEBHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2378
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

The goal group is not skipped to prevent allocations in foreign groups,
which can happen after mount while buddy data is still being populated.

using sparse image and dm-slow virtual device of 120TB was simulated.
then the image was formatted and filled using debugfs to mark ~85% of
available space as busy. the very first allocation w/o the patch could
not complete in half an hour (according to vmstat it would take ~10-1
hours). with the patch applied the allocation took ~20 seconds.

Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
Reviewed-by: Andreas Dilger <adilger@whamcloud.com>

 fs/ext4/mballoc.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 30d5d97548c4..f719714862b5 100644
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
@@ -2060,7 +2075,20 @@ static int ext4_mb_good_group(struct ext4_allocation=
_context *ac,
=20
 	/* We only do this if the grp has never been initialized */
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
-		int ret =3D ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
+		int ret;
+
+		/* cr=3D0/1 is a very optimistic search to find large
+		 * good chunks almost for free. if buddy data is
+		 * not ready, then this optimization makes no sense.
+		 * instead it leads to loading (synchronously) lots
+		 * of groups and very slow allocations.
+		 * but don't skip the goal group to keep blocks in
+		 * the inode's group. */
+
+		if (cr < 2 && !ext4_mb_uninit_on_disk(ac->ac_sb, group) &&
+		    ac->ac_g_ex.fe_group !=3D group)
+			return 0;
+		ret =3D ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
 		if (ret)
 			return ret;
 	}
--=20
2.21.3

