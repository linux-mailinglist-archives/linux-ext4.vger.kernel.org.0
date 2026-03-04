Return-Path: <linux-ext4+bounces-14597-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH56FATgp2lnkgAAu9opvQ
	(envelope-from <linux-ext4+bounces-14597-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 08:32:20 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB531FB9DB
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 08:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D42F302C6FF
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Mar 2026 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA41369999;
	Wed,  4 Mar 2026 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pY0RdbIW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012058.outbound.protection.outlook.com [52.103.43.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B171930649C;
	Wed,  4 Mar 2026 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609533; cv=fail; b=T8hXhNVqc03wKuGini9TISrjYy9j15z3lAiXIhyxtDlossMmf6SGjHHREkCjSJFdFaYcYWPKy0fK3SzUbgfho+OZfFVCCbYX6MkbgZw5Atlz9z0xbNP0MfoBS1db8itHLVnUU/8iSeemgVhDM1UZ01r9NJhVh0O5YrC2z9E+P+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609533; c=relaxed/simple;
	bh=5+DjjIBAgQ10EbCnEJClqQiwK3684BaDwR5CJLbuKAE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZU8P2dHdwOFSJg+sUwPPgIogwtusPCSd3GjBeK0DMIorne/5GniCYArj8KJGnGSOyxgIa4OGZgYU4kCXVFtKrEEEkkrnh0MGdNTgpk3+27wGkwtHofNqN6V3pLzJHRgl0kMpVt3ymwrYGV0UBZ5aQ1L2CmoPVrE5RT1h0wxNsNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pY0RdbIW; arc=fail smtp.client-ip=52.103.43.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMcyJ/VBJnVZ56cp0J2/fSlXqSduEaJHlejJHrrDtdmvtNCCVeDAWZ76Y9VXBlasO2MYFkjanYRdrfyV/q6DqhKcD6n9FqO/JoRyPIG9bKMDHcn3fWFe0RKHyM78CSMfXiYo1rc5bxdv9UajUtORrdkZahXRQlJt1EcTSjbYbLXmCySh3rMl08o7Mw8w8Y15cxgDjTjN3Vx84W0LRXXc0CPyhZWhpfE4A53ejzn9ebEc5+gLLR45R/Uv2sLh7+6u4lTHzs/aztMWgZcpbUa74cpma8d8PGr0CUgL1i464ckTTduXfJ4FWAcyPNnRS6bbEakHG82PT/vuok/H+ucsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvMT7Zjs1IfY8t1aOTwpByCncSscZIcU5zvXwprY5eE=;
 b=kknMSp5aZ3Eiq6ffIDri0cOl/3rhd9CnI1yKaY5GUJ8V7qeSntaLg3o2+YkvwcDAua45K80m9s+eEZSUv/gPK2r5+MQA2SR2wME3C+nXYmB2r3Zny8JkWYlbPzXl0DeF0mHbCYqD3Yn1aJm18+j/rEE+HfkXjAYqhmE8sAp4r5OHTH2l6d6Sj76cOGaeBFw44MTArRvxO7UVCfxinRhMqr+7Su/9QF/B9WNxjdS9bwBr6ks0tkTp2SZqrG51HAg5mSshXSWqXT9Y9shYoYeQgq9yXFL4QFsuYFc77Ji5rnrm5qhEgAMte4Ip2Jnt4sY12ESnd/sK1ET3xy480AmVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvMT7Zjs1IfY8t1aOTwpByCncSscZIcU5zvXwprY5eE=;
 b=pY0RdbIW6X63ZZ2APaW88t29Ri6mk4X61b8Nt9qMnaUN4mBlNsVGeI71Qc+un1lftc7ppkoI9POEyqML1fS9MTi5oiyVxGCtFKPoGjIt8zLjz/htIKq2fWknI4V7VCA18YilicsPcREJcSJLsuAWy0BDfChRj6qzSyFc5sbiIt7+lZPa0/jY+SI2zJ6be8LcfvvLXKiluix8kuPCQ6tS71F4Js+T4+fEE7sNexjiWco6qDaoTAqwB9bcQCSHIoyaoeCxkKm160LqJub3tSY6OLNbYfKRcZrP627414ZK/JUSpYQOc3idxSjMskFAs9HX98jiLKcNKwNk70LCp+AVUA==
Received: from JH0PR06MB6632.apcprd06.prod.outlook.com (2603:1096:990:3f::11)
 by TY0PR06MB5626.apcprd06.prod.outlook.com (2603:1096:400:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 07:32:08 +0000
Received: from JH0PR06MB6632.apcprd06.prod.outlook.com
 ([fe80::4fa1:706f:f4e0:6bad]) by JH0PR06MB6632.apcprd06.prod.outlook.com
 ([fe80::4fa1:706f:f4e0:6bad%5]) with mapi id 15.20.9654.020; Wed, 4 Mar 2026
 07:32:08 +0000
From: tejas bharambe <tejas.bharambe@outlook.com>
To: "tytso@mit.edu" <tytso@mit.edu>, "adilger.kernel@dilger.ca"
	<adilger.kernel@dilger.ca>
CC: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ext4: validate p_idx bounds in ext4_ext_correct_indexes
Thread-Topic: [PATCH] ext4: validate p_idx bounds in ext4_ext_correct_indexes
Thread-Index: AQHcq6d7R3cc5YXVYE2X6U/f6mdq8w==
Date: Wed, 4 Mar 2026 07:32:08 +0000
Message-ID:
 <JH0PR06MB66326016F9B6AD24097D232B897CA@JH0PR06MB6632.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR06MB6632:EE_|TY0PR06MB5626:EE_
x-ms-office365-filtering-correlation-id: aa271d0d-ba52-4a03-1511-08de79c02457
x-microsoft-antispam:
 BCL:0;ARA:14566002|5062599005|39105399006|19110799012|461199028|8062599012|8060799015|41001999006|31061999003|15080799012|15030799006|10035399007|440099028|3412199025|4302099013|102099032|1602099012|40105399003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SAFt7p3wfpSOHEGtChqhqlD+X6FEI7NAud4pJSg7D1UpKj68bOypoTYY34?=
 =?iso-8859-1?Q?qgfCfky5hWaBFtNlf0k+Dpr8vBgPt01BEMl2Ls4Lg4MlBKNtztN3SBWR/x?=
 =?iso-8859-1?Q?qgUROpGVWMUVSllTS19OZI6jUwBKR6iKM3ZDYGoWuMiXl1lTGrm5MH+U0m?=
 =?iso-8859-1?Q?lwwHVc5YEkPf5hREuOT5AuOGWuWRtoEmGDtWnah3wf+vhXY81MmODCnWEC?=
 =?iso-8859-1?Q?5j0jl1O2QAAiT8ZAlZD5lRPuAFKC1KZ7gP6Iv1WNq7lPywy8uYse5xQKSe?=
 =?iso-8859-1?Q?MPNEBAd4ho1uYELP+NdQ8+VocVc1VbbcvO6me6rPzjkP0rf/3XX+VQ+iQn?=
 =?iso-8859-1?Q?kNBRL1DYLIU3puT8G8tqLKWcUaPQ2MaaTbdkF5HJhXdbSRWiUw9cAsNL4X?=
 =?iso-8859-1?Q?dq6lwBSyKLbvVg+qxHPhpkvG1Rd4iCulwAZ1RMi4r1ZynXmnm30PzlYvq2?=
 =?iso-8859-1?Q?tmxRFiE6Si1TxQcY9CZmBTkW39AQ9WNpL7Vzjf5NJbwkfTh2NQ3fFkI0m0?=
 =?iso-8859-1?Q?jo95TIWqO/XOKnI3ySlhnSj8dHUd5GAXV/3exofeMenzBwBrrM+9fOwPCW?=
 =?iso-8859-1?Q?0IEs1BS2VT0LE5Lq+zDK7XUfbSzgwKQraFWoVWQ05hIpPIb1B33qbJzYDL?=
 =?iso-8859-1?Q?TawEpdG1je5t+kTxCm+/vxlZ/QYteSWP4Ks2IM+RA+O/3HLPzfruIUAFSE?=
 =?iso-8859-1?Q?yIN4zQYYutryZsEhBdcA12sjChg/17Q3c8BjY5vC/DQAeVNX/r/CBlVjl8?=
 =?iso-8859-1?Q?k7JSmm3b6VIY5dvSUhIMBKQUIbMDZueiHk4K9M98J3xdOhd5bT+T8Ck4E5?=
 =?iso-8859-1?Q?DLCmsj3kigvJDymxTpwdC+ABpe+kPU1Zyf4yRYUv6LdKLIV6NRppuTSdFV?=
 =?iso-8859-1?Q?NvuUFEgB2ZQQy6ORUojRG5lPLa0HPX2CVqgOXZIROeBgSiuMFUOH1bIY/1?=
 =?iso-8859-1?Q?dagPrYt4kRToNFSMQGZmPgnTSJLRVoToPYqz7T7rintVAi7F00v2PD90+L?=
 =?iso-8859-1?Q?sz5/Z37GKqmQFhIEqOVTmbVcCjZHwPS7ROS+IG+d6x5EekS8BZ6Rc8MfmP?=
 =?iso-8859-1?Q?TjSrVNoOaqpr2f5nSJYDB/WgNlUVm7VrPj7FlVaoTbTo?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zvmyUQgSgTnSIK6a5qEaB4R0wy7P6LwsOY8svMwcKouhLXNNXt7VLXg/4J?=
 =?iso-8859-1?Q?Uz+KE/sUzcCWvcd/PGL8RaAJRrwHN48SqbXPpXN7Vd0hnV/GFTy6BRIXvF?=
 =?iso-8859-1?Q?KunHId4I079/gocYTNMFwViYJeLNTdpnp/awhsOK8pdX/psiXWf1IvOvjL?=
 =?iso-8859-1?Q?Ye89OzZpqWt1d8XKi9iGOEALxxU8bWorKomP2eKJrX5KJHFGvzvTatq+Py?=
 =?iso-8859-1?Q?UpUbw3aqhU34J8H7MOX1mwN66CP2ShrOHqE//5iVPyvW6iNS+A7yR1e0HJ?=
 =?iso-8859-1?Q?+KII45Q+Rkzs1blMh1vk8CsgnkzJYllwlKypGZmqWKPHz+0pVe1zipgjTQ?=
 =?iso-8859-1?Q?J7j+4nX4ITLcO3JAnusQwQ2iqPB8+bF4qaL7URTkT4kZo+0YDhZ34MveJj?=
 =?iso-8859-1?Q?XHEUW6kIBSZ9EK2oJDWDr0IPQlV6Yr/wpOyIek0jDJ/Fb1pD8gLxD2cDIk?=
 =?iso-8859-1?Q?FjSfZTBXc2PE0liIeTh+ObR29mZJ4I9uyq9qzc63VgsviLByGrAwbmRuit?=
 =?iso-8859-1?Q?Embm+XCQ9p73Z4T6vJs8IRwcASWtf47kpav/E3qFxXmr2Kmk4QEW+j8sml?=
 =?iso-8859-1?Q?LNTKfzrE7r7m13V75LhEsHsSANLjk2XAmWtBvQB3S2ndgWmHc9U8BCrH0h?=
 =?iso-8859-1?Q?WJx8l9d9ab+Zezt0U+Voq+wWvOQtMTrDlqS5iFIeYGoRFhVNsdLA0p5ETX?=
 =?iso-8859-1?Q?Ztf/TstPFg3kIK2e7LSnHNr0B+W1Db4YLhIXVrucUVtIL/2/BMqltDryB6?=
 =?iso-8859-1?Q?5xMLK7qwbvWkh7edR687pnbA2OTRwCWPlv4xF3hjkjQnZzc5bE5fSPr7AM?=
 =?iso-8859-1?Q?D6r30gU0rLEVUXzxYTGV0ihkJKGZ/QI2v+SQMatdEnJKjUs5essxROgR7K?=
 =?iso-8859-1?Q?SnAWA7vfljWVCu7765l3+4LCe8XGUPgRSDjWEDKKE01x7w7sNhKffQFznc?=
 =?iso-8859-1?Q?9xdwUGFLIaDoAPADKzRm+C3BIdd/z4tsF5m2FOVPlqnEkrjUkeVKYiHHUO?=
 =?iso-8859-1?Q?nR1jtEKU9HjBWWGiF3Br+cGosx/IbENQ9ot8VvHq1eF7R1Kg9wZJ7SDYck?=
 =?iso-8859-1?Q?JXejcr2GCWJfAQukK3ZknPyyz96U6E8dezuWinVTHN6Ty7l/ti2nOClo5w?=
 =?iso-8859-1?Q?WhiHLtrteamFMt37hSZ9D8K/Gm8Q4o+xIuktHtQoQGUh5TzlkZUovhcXit?=
 =?iso-8859-1?Q?dNjaLricV6R2wsoS5DFuP94O7jGg+awrFtaZffePhqCI4jSgaZ1BVxhPds?=
 =?iso-8859-1?Q?lUCuZHZH98p4D1bPX4pC+1bQopNQAwi0D/qdjo5C7lS4oiPkW1RRXebLx4?=
 =?iso-8859-1?Q?OBayg3Yk6Y1J3E/oShnZfFKKIAYCFjRYeiqVmYaqiWLJGKG/exo68ycSia?=
 =?iso-8859-1?Q?r/deJf3fqrsvSaU9hp+qfyy9w2gi9VdM+L4nSagwXT0jdE8nbe1GglpRkv?=
 =?iso-8859-1?Q?Jb5pH4+AdzPPTH7GRH/5Xbu8cpCDxJC+K3MGuA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6632.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: aa271d0d-ba52-4a03-1511-08de79c02457
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 07:32:08.3422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5626
X-Rspamd-Queue-Id: 9EB531FB9DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14597-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tejas.bharambe@outlook.com,linux-ext4@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:dkim,outlook.com:email,JH0PR06MB6632.apcprd06.prod.outlook.com:mid]
X-Rspamd-Action: no action

From 980406b391b29715589842a4ae4391a87afaaef9 Mon Sep 17 00:00:00 2001=0A=
From: Tejas Bharambe <tejas.bharambe@outlook.com>=0A=
Date: Tue, 3 Mar 2026 23:14:34 -0800=0A=
Subject: [PATCH] ext4: validate p_idx bounds in ext4_ext_correct_indexes=0A=
=0A=
ext4_ext_correct_indexes() walks up the extent tree correcting=0A=
index entries when the first extent in a leaf is modified. Before=0A=
accessing path[k].p_idx->ei_block, there is no validation that=0A=
p_idx falls within the valid range of index entries for that=0A=
level.=0A=
=0A=
If the on-disk extent header contains a corrupted or crafted=0A=
eh_entries value, p_idx can point past the end of the allocated=0A=
buffer, causing a slab-out-of-bounds read.=0A=
=0A=
Fix this by validating path[k].p_idx against EXT_LAST_INDEX() at=0A=
both access sites: before the while loop and inside it. Return=0A=
-EFSCORRUPTED if the index pointer is out of range, consistent=0A=
with how other bounds violations are handled in the ext4 extent=0A=
tree code.=0A=
=0A=
Reported-by: syzbot+04c4e65cab786a2e5b7e@syzkaller.appspotmail.com=0A=
Closes: https://syzkaller.appspot.com/bug?extid=3D04c4e65cab786a2e5b7e=0A=
Signed-off-by: Tejas Bharambe <tejas.bharambe@outlook.com>=0A=
---=0A=
 fs/ext4/extents.c | 15 +++++++++++++++=0A=
 1 file changed, 15 insertions(+)=0A=
=0A=
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c=0A=
index ae3804f365..f204285c71 100644=0A=
--- a/fs/ext4/extents.c=0A=
+++ b/fs/ext4/extents.c=0A=
@@ -1736,6 +1736,13 @@ static int ext4_ext_correct_indexes(handle_t *handle=
, struct inode *inode,=0A=
        err =3D ext4_ext_get_access(handle, inode, path + k);=0A=
        if (err)=0A=
                return err;=0A=
+       if (unlikely(path[k].p_idx > EXT_LAST_INDEX(path[k].p_hdr))) {=0A=
+               EXT4_ERROR_INODE(inode,=0A=
+                       "path[%d].p_idx %p > EXT_LAST_INDEX %p",=0A=
+                       k, path[k].p_idx,=0A=
+                       EXT_LAST_INDEX(path[k].p_hdr));=0A=
+               return -EFSCORRUPTED;=0A=
+       }=0A=
        path[k].p_idx->ei_block =3D border;=0A=
        err =3D ext4_ext_dirty(handle, inode, path + k);=0A=
        if (err)=0A=
@@ -1748,6 +1755,14 @@ static int ext4_ext_correct_indexes(handle_t *handle=
, struct inode *inode,=0A=
                err =3D ext4_ext_get_access(handle, inode, path + k);=0A=
                if (err)=0A=
                        goto clean;=0A=
+               if (unlikely(path[k].p_idx > EXT_LAST_INDEX(path[k].p_hdr))=
) {=0A=
+                       EXT4_ERROR_INODE(inode,=0A=
+                               "path[%d].p_idx %p > EXT_LAST_INDEX %p",=0A=
+                               k, path[k].p_idx,=0A=
+                               EXT_LAST_INDEX(path[k].p_hdr));=0A=
+                       err =3D -EFSCORRUPTED;=0A=
+                       goto clean;=0A=
+               }=0A=
                path[k].p_idx->ei_block =3D border;=0A=
                err =3D ext4_ext_dirty(handle, inode, path + k);=0A=
                if (err)=0A=
-- =0A=
2.53.0=0A=

