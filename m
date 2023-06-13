Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917B072EDD7
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 23:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjFMVZz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jun 2023 17:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFMVZy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jun 2023 17:25:54 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2094.outbound.protection.outlook.com [40.107.100.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5B0173C;
        Tue, 13 Jun 2023 14:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfbZg24JscD4ZHOBn0gtRqoky6E5c0UoHLS4hlQtGO4oFUspxn3z3TWMP3X3WvcAUg3bkX85K1JqMyz4p+JZSfWlfVNTiqC1VqaFt96kD+yRfERUeo9KjMB2JVwjJHFJ5a11YtzPhM39ipBGq2b9G/zu+2ceOF/rWpKEWGPnQ+irTvkbaxDkuxfSn8jwhK/AWHABZEXVVunbFs9vWgPc6HNReETQ6XFJbSkwR85lKyMUYuCqbj3qj3pFG++mOZEBUQ4q9+ZYMyf8Gm1vHr+8ABINEpTG9HxjQ8tHXEULshxnLgzjmdszsuHHiOG3/Xvi/p/WHXGinL3XwXYVWBes5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1vgDHwf7ZNYI6j1vnf8GA5uEO/X1DezAsQOkol8p44=;
 b=AM8W/OHpUGZmFKrFCXmAUwiy9I8kyNf8cwKBEXcAyjHgzoaBRGCcweGZnQjmD7ZCe/bQF7EhN3MdsjzstYjj9oYqS08aHYrw+z+i/4XRZEAZd93L6vWGIKbP7dm5yunBWusqj3iuoS7fowGjOR0x/OP69dslCK+Rprpr7Q+USo+3/2kf1SPEWwSxcqakN008zWbx4GdZU18c8kHjGowTa+xhhRlqZTmRYzxNttj/XaeJkbvhsXVvt4yDQVqyEHbR112L4ffb9bmXSWazvGwVPeVdGi+9clcuPY82rhk1u/J1T76xYUpMT5V92c/kesR0/SHdz/Im5+SbUjEGMIvcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1vgDHwf7ZNYI6j1vnf8GA5uEO/X1DezAsQOkol8p44=;
 b=lom+QpoKuCIq7bjaFRAxtNQxDPpACftKEYA+0kkyzbxqgHM0FWefRYRiBw4tMPC4UmR9HUP7fWdyr0tzrMSpV2RaEenVNDWmQA5DcdGEIKDRecTFtd4aqp4n0noZTl4HVc/nBqhIzTltM9gMj+H2hEWj9cSJImdWspuL6hVtxns=
Received: from SA1PR22MB3124.namprd22.prod.outlook.com (2603:10b6:806:23c::12)
 by SA1PR22MB4256.namprd22.prod.outlook.com (2603:10b6:806:38c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.21; Tue, 13 Jun
 2023 21:25:50 +0000
Received: from SA1PR22MB3124.namprd22.prod.outlook.com
 ([fe80::1191:d2ad:b13a:d501]) by SA1PR22MB3124.namprd22.prod.outlook.com
 ([fe80::1191:d2ad:b13a:d501%6]) with mapi id 15.20.6500.019; Tue, 13 Jun 2023
 21:25:50 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ext4: fix a data race on EXT4_I(inode)->i_disksize
Thread-Topic: [PATCH] ext4: fix a data race on EXT4_I(inode)->i_disksize
Thread-Index: AQHZnj2gI6zWGsnu9k2YmOZj8y6hEQ==
Date:   Tue, 13 Jun 2023 21:25:50 +0000
Message-ID: <7460B276-0768-48B2-9862-529B74705E29@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR22MB3124:EE_|SA1PR22MB4256:EE_
x-ms-office365-filtering-correlation-id: a9f39268-29ab-43bf-981b-08db6c54c304
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hc34o+lFuDxacnwCOMxACpNdEv042orDlrslergqwoX6UzLj5lsumyy+o2PUiKDI5Idk2l8XlMKQssaoepfAVMLrGLF89cKo2pdvGXNB5wz0fWphSg3WMW7WHrWCp8L4pitL6Z3pGpJ30h2p4t1mb9q8mM8dDkbqtx4Fx9sViALvd3hg8Vm/W3oq/L3xVZjkBb4TnDUXE0oRv9VgJabjypt4ylZa0jVrNHGzkIR5OD5tgMIYYhf2IYB+vE+1S1Ju/SJBX35smiIRh2DO+piSKz3Xb2SjUwc/sliihVyKjgYTYY6iwSFw4pLpIbxaoDqvAUbhSoCJkHxGxD9UkESocdnwzR2gM23ZjrabLpQOB7QVzos3Nk9g7Qsl8VlnZ09O0jSQWQCoTIlXxKe2lWEAYXGYPyN+p9jxRIeUa0Df02NCmfQhhj6Qxx3o65bnYMjzpPNBAHRPhOgXf2vo1hD7TqiiiDflVWEFuTuI30zrzN8JWv8PiK1lBUvpwP63R0UrP2oLAPZ8Zd7ifPis0ISLt86kjq98eXyDG+dahP4EFxTcp64QoCjSz/2X5L0Pkyrqka4EhrLFBpRZNy3LwPPOahqCml7nRS54BtJorsN07l+g7CyrvGEmFzBCYpPugTFS+c9GDXfc462Mmgi8HHg+iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB3124.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(6486002)(83380400001)(36756003)(2616005)(38070700005)(38100700002)(86362001)(122000001)(33656002)(6512007)(26005)(6506007)(75432002)(186003)(66446008)(2906002)(5660300002)(54906003)(110136005)(8936002)(786003)(316002)(41300700001)(66946007)(8676002)(4326008)(66556008)(76116006)(91956017)(66476007)(71200400001)(478600001)(64756008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8vtgQfuJYSt5bRoleLO8GmYhCiriuJRkZfLxCy34oBjkLymWeFxvrTsitKLX?=
 =?us-ascii?Q?DKgVY0CGBC+tsjV0hjK76iuVMuy85HS9W7h9ekSsaWe3LJtQ5Vqkc4s8MD4e?=
 =?us-ascii?Q?1rJaEMA0U8JVYez9499bJLmdCQwBDMjhE9Olbg/oz0jpzNFpJkVpm3M1nL+w?=
 =?us-ascii?Q?iz4LxAtxKmusNgxQF7hE6c3U9IsZEsLHLJyowaJnvGU5uOb5ajcHi1fc0t3H?=
 =?us-ascii?Q?nFW/bq87YPaz9w4cKFkdQ0Hu/fc9RblNNChQTWoocyFAYMaLDhMn48TXW2pk?=
 =?us-ascii?Q?R9sxbz425BubR64LkVnN9EIy4csTRomgvabFcMDZ9ciUUxJqg66b2043Nh7E?=
 =?us-ascii?Q?sXoqeMnrntknxk1VpmtXkDYGHaHdGcAUEreg185gWlCfPPh3fC0GhMdhvn7k?=
 =?us-ascii?Q?Tnen7Nm+Phe4QkmyjClJxf4Lf8NBqXWVL8J8P+cyEr6tuSpEqwg2IYLDnESX?=
 =?us-ascii?Q?osU/15tnU1H/aVXaBS4aiIiOTxlVfMfUBpdUWabs0eCS64FGMTviDWu6s6Kh?=
 =?us-ascii?Q?Mkj4OvMnkpzIDXaiIHSUIaXFWg9IuJYrwRa1NeaMh8c+6cE03A/Oq2CpSy3Z?=
 =?us-ascii?Q?n/gu5B40Ir/hpWz5ln2eSaXvRkWjNYcTvLLsXWc1RkNFXW/UGA3SPbzc9rWp?=
 =?us-ascii?Q?94v1O+88ll1E5nNSFZwPIr74X+PuARVeEzQFuKtSWpto+JZfqgjJkApeikG4?=
 =?us-ascii?Q?m+6u9abkI8nPQnOwj99wDzGGr8jcpQMFgAcL87NjYKj/LZT2pygzHewlza37?=
 =?us-ascii?Q?uVi0EY24nd701JL3LB/px1/YIF8Y1fJZlW3WzHVLKbXPQcL39AwQpy/fokdc?=
 =?us-ascii?Q?9+MXBDzzJc29ETLHTUF1LCKmO3gZyJJDF58ha+JkuuqYjwGNeSjPizQ7sJwn?=
 =?us-ascii?Q?Vz30N32OshRQI1Qwk+JYjJfvQd6w4UorC92mAFUxCsRuVrJuB/v8DPm9x1EV?=
 =?us-ascii?Q?mYsYlEMgKmQcliHKJmiMvGtkW5uv2zvLn8bnJNyT+R7M6xMcLXdCNMX4UdzS?=
 =?us-ascii?Q?bxX+/VmjRW2GtH0hQodh87OVt/JLKTrU+qGsb30ZN6RswJo2fx778PGCf3FH?=
 =?us-ascii?Q?kIJ+JM+4sb9saGzYnSg1bnT15Jl/u3OIIeoFQGGDJU3qIWGVCbukdGND6coM?=
 =?us-ascii?Q?a/+MT/awcXDKszWpIX8h8qWua1pHQITl/pUa5jZLnkG7X66BPAs2FV0nYA2b?=
 =?us-ascii?Q?aGvd3pQHHIA7ZPuNEB0gqg3Stgj0ee7k3zo0BPC1ZWwK+BZfUOtnce+1YEfA?=
 =?us-ascii?Q?klsGDYe0a7sUufUYTra7uev6AIlNM4U8HboNlRnNPYmm0XzlCW7h26LfPDnJ?=
 =?us-ascii?Q?ZfMAC2UmTyqV2a/dLYHqC9T/7CnBJsGw6QuEio853m8Ys+X9la5XDxRqsjj9?=
 =?us-ascii?Q?9KNRXkMQ9WBDK/CQ8Vm8mSe256cQFcMLEtQW+W9JslcFKirfo87SfrMG8e/J?=
 =?us-ascii?Q?f1yXY0pNK6RZycXzM7GgCvrQJNvgf66gQCoF4tVHIzghc+NjMmVN/cozFPgW?=
 =?us-ascii?Q?sovPldJoV5H95pZUgaoXA++NfQ51bOopurHa3r4vgeSnQelIO/yDP1vzBMBC?=
 =?us-ascii?Q?NBNTWp5c2qqFu/63L8hLoFvneOn8HDEYSkCmXAJ0?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2C33CE8815383E46A68ECD8A9A27161D@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB3124.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f39268-29ab-43bf-981b-08db6c54c304
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 21:25:50.7545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wfzxaw1xfftAxhqvxt8vK1snFYRLfvIZqWKsTCAXcAhD4WbGcV8ibCoVeNOsRAAb+cW8FmK5m00ZJehlytWrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB4256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_ext_truncate() might writing to the i_disksize while
ext4_fill_raw_inode() is reading the i_disksize.

The concurrent access can be reported by sanitizers
such as KCSAN but we can mask it using WRITE/READ_ONCE(). The same
fix is used in commit dce8e237100f60c ("ext4: fix a data race at
inode->i_disksize").

Signed-off-by: Sishuai Gong <sishuai@purdue.edu>
---
 fs/ext4/extents.c | 2 +-
 fs/ext4/inode.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 35703dce23a3..367f338f60ee 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4396,7 +4396,7 @@ int ext4_ext_truncate(handle_t *handle, struct inode =
*inode)
 	 */
=20
 	/* we have to know where to truncate from in crash case */
-	EXT4_I(inode)->i_disksize =3D inode->i_size;
+	WRITE_ONCE(EXT4_I(inode)->i_disksize, inode->i_size);
 	err =3D ext4_mark_inode_dirty(handle, inode);
 	if (err)
 		return err;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 02de439bf1f0..99b48ee26f1c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4286,7 +4286,7 @@ static int ext4_fill_raw_inode(struct inode *inode, s=
truct ext4_inode *raw_inode
 		raw_inode->i_file_acl_high =3D
 			cpu_to_le16(ei->i_file_acl >> 32);
 	raw_inode->i_file_acl_lo =3D cpu_to_le32(ei->i_file_acl);
-	ext4_isize_set(raw_inode, ei->i_disksize);
+	ext4_isize_set(raw_inode, READ_ONCE(ei->i_disksize));
=20
 	raw_inode->i_generation =3D cpu_to_le32(inode->i_generation);
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
--=20
2.25.1


