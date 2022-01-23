Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EA3497005
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jan 2022 06:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiAWFbS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Jan 2022 00:31:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24082 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229776AbiAWFbR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 23 Jan 2022 00:31:17 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20N2cqo8026846;
        Sun, 23 Jan 2022 05:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UujmKVy4jwgACE188AGR/u+GGf79Te2Rl4MenZ1raB8=;
 b=yILmqvl8LsKzZ82u+yC3KsexNf3dOdtqwEMQKtP4j6KJcNtn0PARR5jchv+7hg34ZWXj
 mJfXDvj65L+qHVijgJXyeb+17TJ67YQHkWRSAysJGSE2hpfuzmEiSHG/JLDDS1PvM31d
 YoI8BaziXC8HdM5XcOhWyXCOvLNCUj+NAbhUHtOZIHd2121zhUSyo9M5v81AYjRC7XD2
 BgrVgs/OwIw93c+8LpWrmmfLFNPTsWtnTx5x4GANcnXtmyjYLrc5xuyGjNgibo1nphNW
 4olIxOxjjI+RIgq5YazDlapmdGqdgwt7oL+4l+SZ2rMGjrDDPQP7OlceUTO95MbHOjhC gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dr9tb1qtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jan 2022 05:31:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20N5V8kG015114;
        Sun, 23 Jan 2022 05:31:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3030.oracle.com with ESMTP id 3dr7yc7hue-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jan 2022 05:31:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGBfBs86Qrz55n+ySkoSTPwyeTY8gTLQcjksYk6sg7iUw0gNDoguQQKibmBwKzfwzGRDHTn15rfGHO6R+b2MAJYaU0xobVnBzbpf4yCWoPCeEvONYGvKX9sDpwyo0PUx48ijOfs+UnbGYfkrLecnxbr5b1rxYHy+B52ujiujDU+FtetfybO/+LPXHdNsDh3+hWDc4gOlQRiesx06OkkQ0OPC1mK5td8K0yMM4FDsHlxao63D5Vt4FrWWfjrZDErif3vRiyJhuT8rONVgeFawPVONxajRIpm6sAaTx6+GjXalEp0QxQkLHig1u6XXFJeDsuy4yHbqMZnCVMJmZKQM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UujmKVy4jwgACE188AGR/u+GGf79Te2Rl4MenZ1raB8=;
 b=bUrRZOWeBh8ylXaC0GnU2rFxvev9JYYAlAblKpJBXE1b7dWAzuGOw3+gHSVXWP+I3masdyh3A4vk7X5jtghz6UBkTpzEa3Y82vPhh0pDJ+ehyuBU+21oEKDurZg/bml2rG098rEtEeqogstDPnBOrvfHc8XW7CPGUTEppqI0MmCX9qv3rLaELUm8l+bgdatUk/Ou/ERm4JUohw1FGrLtlAtdPVH5A4XFcDTmyyauO0tCOYSpMzZLVwd7+lCsX2i9XCiV8JfjMLCwcjuo4bp5a+EXItAMRnKDeKfW2nvJk4mfaNnq+TWMs/wiQkd7qKKRfVowF/O4aTIqOvX20SlZeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UujmKVy4jwgACE188AGR/u+GGf79Te2Rl4MenZ1raB8=;
 b=fhNnnAuzONQAAmpYNv5t7OfM9e+Ti8KA9w5RHKhoWIVzy2lD1Ah/yaN8feqrQsLxZkQgXaLnQ0ykTnb7lXOZ2xnTmAIWh3lJMjhFbkW8na88j6loY4WQ7QGiuIAq0etkTYn5TDPGKA5xfhL0caQaOOlBT1VDhvn6CXsY03qHVxI=
Received: from DS7PR10MB4878.namprd10.prod.outlook.com (2603:10b6:5:3a8::6) by
 DM5PR10MB1948.namprd10.prod.outlook.com (2603:10b6:3:108::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.10; Sun, 23 Jan 2022 05:31:02 +0000
Received: from DS7PR10MB4878.namprd10.prod.outlook.com
 ([fe80::8d35:833d:3048:1e7]) by DS7PR10MB4878.namprd10.prod.outlook.com
 ([fe80::8d35:833d:3048:1e7%8]) with mapi id 15.20.4909.017; Sun, 23 Jan 2022
 05:31:01 +0000
From:   Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>
CC:     "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Subject: RE: [PATCH 2/2] ocfs2: fix a deadlock when commit trans
Thread-Topic: [PATCH 2/2] ocfs2: fix a deadlock when commit trans
Thread-Index: AQHYDpY4QxT3B/KhD0KLG3FGeJTJ0KxwFvKQ
Date:   Sun, 23 Jan 2022 05:31:01 +0000
Message-ID: <DS7PR10MB487883FE7025BE9FD4623C39F75D9@DS7PR10MB4878.namprd10.prod.outlook.com>
References: <20220121071205.100648-1-joseph.qi@linux.alibaba.com>
 <20220121071205.100648-3-joseph.qi@linux.alibaba.com>
In-Reply-To: <20220121071205.100648-3-joseph.qi@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce0d548f-8520-4782-3488-08d9de318b28
x-ms-traffictypediagnostic: DM5PR10MB1948:EE_
x-microsoft-antispam-prvs: <DM5PR10MB19488FE7127B03899F7B58C0F75D9@DM5PR10MB1948.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6a0ub0EReh+TN7v6OhtoMgxJ+L7cb0HPsQR+ou0r6DR6GXtAh0/qXDzv8Q1U9pavndDDULqe5dAzVdeYI0wrRxVUZSCq1kgJn8CqYhFsv1w6Fmbv6MOWSXFXyRQd9WBHlMJa3YFR4oZ/KJMcxHiRhzqokVHZc3lvbg4gA5HHJc1E++vpGwf+gwl5vl1bLsgf5GTOpA/dZK8Rh6BfcLclTk7SmHaJZ2qChwsojJ1vJuNL+BVAeaONrXG93pQOBpKruPsn+bx2TmtoTkUKnKfmRF78ltJM3X7gUtqc8KjCQoPU7jZPNAcIYV61XNInMyUDTYQMjdnhqRv3rI4agw5wz/y+WFaRss6Qe7+shKfJSyovrCEU3sGkg8lxM9sN9YNMWYbRxuE6atETr46pEJdhDF46Mb8Y2ZYQzW3AdnMd4ZQ9jMsBrCy9kHt5/bX1zE+tY0mM2QSoNwIGFY75kAzJ8NxiLfX7R6j5i9U8sxezun6/6IdE6DyhQH6AXHzjQ3dBtumSFimXGN5MxFzSLmd3vPRGwRtVPqOwzdW1aVqROuCT/wJAk+nPRTgND5CJFxV4GBt78+x3t/qMYzDxE2asuPBwvA1G2adxp8VVPosSDmbWlCrUEJJcs13pRLb9NJWAuGc+FeaI2H8r1IwoO/fhqeZTLTjJt+CVd71UwI/Nn9nubT1pdNQC2Hu9tU9AobTWBlaWXFFoBiiCjFzD5Lh+7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4878.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(38070700005)(53546011)(8676002)(4326008)(6506007)(26005)(2906002)(316002)(86362001)(71200400001)(38100700002)(7696005)(122000001)(508600001)(33656002)(66446008)(186003)(66946007)(44832011)(52536014)(55016003)(5660300002)(76116006)(110136005)(64756008)(54906003)(83380400001)(66476007)(8936002)(9686003)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1OnduKhV/PePeXGzTsVY17A9G8lguwWoMqJ/4sHHvbbJ95l5GPkbYT9k07L9?=
 =?us-ascii?Q?Xu/pGqsZY1qI/BIDYo0K6TH+OWFH9bzothdl8hsu7KBR9ineJw2YGL712TsR?=
 =?us-ascii?Q?LdD9at47WIyehPG+fzIDzGIBa/9M6hwmVvwHRHHq8DYz1vFaO9Yw43bgIGDu?=
 =?us-ascii?Q?Do983qmtb1wjR1ZQ+PYXiuNUG2qt9HOIoBtnseViXA/aRyzD6+QsGKiOsBLC?=
 =?us-ascii?Q?doniOfllESJyEPzgAFNhdkIxUVVwWp27E2hDFhfWNxTRdjXFtr040DXbHsba?=
 =?us-ascii?Q?UFM8GaAZQzXiBmF7hJ696fvAxZXFC5IWGfzu5XvY3Pc4iOdhsPXZ5rFl5s3J?=
 =?us-ascii?Q?uAckRKFugrNVEF/gJ4GlXVTJFEM/wqHleDd8goRiMmq+viwyi6gk+/Kaw/Wj?=
 =?us-ascii?Q?TmT1lIlL/KjjdgWkQS1KEJXFKaUhNm25/tgCg1UBoaGe47vvvzsxL7l2wJ07?=
 =?us-ascii?Q?O+43Pn8k3D2JZuBpCkmnJlkLYFtTgJc/dMi0xlmaJD9mvDXCakn+q2uWJOPr?=
 =?us-ascii?Q?GMprLCxRyYQ4YIkhtJ173lLsdRSC4/eTJkTYh97uT49F7aZPg4Oh1jNf19m7?=
 =?us-ascii?Q?fzHBy6p/vQ6Od/1qkjGcPbzyYvrjimIOWNp/qD8IE/WQkKdq5lqICJJXeX+D?=
 =?us-ascii?Q?nY7+pfTooWJtuuAfD7Q1D1NUvbnlHoqaLdtgfGyRt+d7LLH/f0IqwLnoBmwZ?=
 =?us-ascii?Q?X9r9pGgLkK/ZKytbrry5G13tfJDlJOvQVWdIdHy3BjQ9uoATlhMApb8oY+U5?=
 =?us-ascii?Q?8u9Wp8XniMtWnO8/hr+q2qRts4btBodJ4DwjnL0hz/QGHScq/WPGWWAjcxKk?=
 =?us-ascii?Q?0FA7P1VZdQnZZ2sIbDIpb341AlY8ubefAUVl1NJMhcOTAlI2HVgI9PQWM0Mk?=
 =?us-ascii?Q?vRMdCg27HKwapfYrsWuMdvGlYCOLOYj0poel+unRKPtJatwrGZ/8k1ZpQ3ZC?=
 =?us-ascii?Q?7Tz53JR+U0eR1MH10PwsegvAE4HXBiXUNWVG+RDHatJlRdboT17zSw44i/BZ?=
 =?us-ascii?Q?xlC1mAa6OF822GPSvxrbhAN5v+jnbIBX7J9kYfCcfhz/C6p4NVbkSwEDpN/6?=
 =?us-ascii?Q?I+5Uidzu9xUjAOLfAC36Fse3sF47g8U2Npr4B0IPYlZ09nQOELttcE9cMTUE?=
 =?us-ascii?Q?64b7mRZ2j1aVPBpQHLZfE+VOYG9++8cnm4Cm614u4A6KXhaPYlg72wrKdifI?=
 =?us-ascii?Q?4vTqHBIdQzYKKV06yiDeOCePZ5nxIhrkwJU/2DcrCaXk5YenAJG+4d9yYusb?=
 =?us-ascii?Q?Bc++2nRoURV4zG7XDcxzwpP2dWBB2S5bdGVarmNOcK9EF/9eZK6AT+kAhlvX?=
 =?us-ascii?Q?r7LIPeikZq1zk54DjQZd7wJfM665FXtW6kIcF50jN1bidPtq+4RAPAtP6ozP?=
 =?us-ascii?Q?Zgz29Y30VUF6dNHfE1QMVGec4FisYbC0P4D7gAX+l6sDuObGW2lJdeek/Hoo?=
 =?us-ascii?Q?U0Qpwejt2hTfcwDhkbVdVGWijhxH7GGcPpuFsz6+kypkpqAKxDCEZGEldDxJ?=
 =?us-ascii?Q?GRtwAyQ1BDxi30FgMVsVwl8t9qXdyOGPzK5kyItbRcbzEkcIIy24Gw6qiSHo?=
 =?us-ascii?Q?R7nhn91qAUfZ5AkKlqmK16EjlCqGw/sYMgY2SHChT6gV3OiXcZBNltWIzgDf?=
 =?us-ascii?Q?mWl0lKpxkMp9cg5VJwo0dsLf2iInPviIjnpK4acWT4siK8YHjA7iGWWED17f?=
 =?us-ascii?Q?Ds+nvIxDvzHa4Zw9WvRr907TvjvOeUX0MXwApyow9BL5BWFj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4878.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0d548f-8520-4782-3488-08d9de318b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2022 05:31:01.4756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WD0kpoGJj19J0Hy/E0XEgGgYDU0yu8heNbU0LYIMARUiB58yGi2/Dm9poJKhqR8JdrURKF5mhBbVouPbqvuIliAU7vMaBEX8Okn7/47QufwFmXKzBU0P27UCmGJjQiCh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1948
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10235 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201230042
X-Proofpoint-GUID: tkO1G1SY0ZqCbqPuvEU6ImZCEoXHECCw
X-Proofpoint-ORIG-GUID: tkO1G1SY0ZqCbqPuvEU6ImZCEoXHECCw
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,
This deadlock was originally reported by saeed.mirzamohammadi@oracle.com  C=
ould you please add Saeed as the reportedby.

Thanks,
Gautham.

-----Original Message-----
From: Joseph Qi <joseph.qi@linux.alibaba.com>=20
Sent: Friday, January 21, 2022 12:42 PM
To: akpm@linux-foundation.org; tytso@mit.edu; adilger.kernel@dilger.ca
Cc: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>; ocfs2-devel=
@oss.oracle.com; linux-ext4@vger.kernel.org
Subject: [PATCH 2/2] ocfs2: fix a deadlock when commit trans

commit 6f1b228529ae introduces a regression which can deadlock as
follows:

Task1:                              Task2:
jbd2_journal_commit_transaction     ocfs2_test_bg_bit_allocatable
spin_lock(&jh->b_state_lock)        jbd_lock_bh_journal_head
__jbd2_journal_remove_checkpoint    spin_lock(&jh->b_state_lock)
jbd2_journal_put_journal_head
jbd_lock_bh_journal_head

Task1 and Task2 lock bh->b_state and jh->b_state_lock in different order, w=
hich finally result in a deadlock.

So use jbd2_journal_[grab|put]_journal_head instead in
ocfs2_test_bg_bit_allocatable() to fix it.

Reported-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Fixes: 6f1b228529ae ("ocfs2: fix race between searching chunks and release =
journal_head from buffer_head")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ocfs2/suballoc.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c index 481017e1dac5..=
166c8918c825 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -1251,26 +1251,23 @@ static int ocfs2_test_bg_bit_allocatable(struct buf=
fer_head *bg_bh,  {
 	struct ocfs2_group_desc *bg =3D (struct ocfs2_group_desc *) bg_bh->b_data=
;
 	struct journal_head *jh;
-	int ret =3D 1;
+	int ret;
=20
 	if (ocfs2_test_bit(nr, (unsigned long *)bg->bg_bitmap))
 		return 0;
=20
-	if (!buffer_jbd(bg_bh))
+	jh =3D jbd2_journal_grab_journal_head(bg_bh);
+	if (!jh)
 		return 1;
=20
-	jbd_lock_bh_journal_head(bg_bh);
-	if (buffer_jbd(bg_bh)) {
-		jh =3D bh2jh(bg_bh);
-		spin_lock(&jh->b_state_lock);
-		bg =3D (struct ocfs2_group_desc *) jh->b_committed_data;
-		if (bg)
-			ret =3D !ocfs2_test_bit(nr, (unsigned long *)bg->bg_bitmap);
-		else
-			ret =3D 1;
-		spin_unlock(&jh->b_state_lock);
-	}
-	jbd_unlock_bh_journal_head(bg_bh);
+	spin_lock(&jh->b_state_lock);
+	bg =3D (struct ocfs2_group_desc *) jh->b_committed_data;
+	if (bg)
+		ret =3D !ocfs2_test_bit(nr, (unsigned long *)bg->bg_bitmap);
+	else
+		ret =3D 1;
+	spin_unlock(&jh->b_state_lock);
+	jbd2_journal_put_journal_head(jh);
=20
 	return ret;
 }
--
2.19.1.6.gb485710b

