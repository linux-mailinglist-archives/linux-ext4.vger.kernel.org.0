Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311DE60E996
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Oct 2022 21:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiJZTuE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Oct 2022 15:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiJZTuA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Oct 2022 15:50:00 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20073.outbound.protection.outlook.com [40.107.2.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5FB240A1;
        Wed, 26 Oct 2022 12:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LueD6ryp4Q0V3UJSM5tpJOa/W+ulK7p6Gq0Hnz0ExNMirxVBtq0kCS0EiqU0R4R7WIAT4ipMzpI9bMx0Ye/HOApg9RuGUY/ZboOmGOrIkw8g+CVxhxkavm+s9vrZFNBN2I8wOgWOx8zwTPLF4qH43GMEmdDeZk1yqdU8igEHmBhsUPc7ygCmAJAX7cSzQG5pE72PVWt5i3eixgn+/pZEpey+XCiHT2hIWU2Et0YLkjN0tR46lFDkgrJMvSuBVdgpklJ4m31FsXZuvlFo+pjp8uXmfDqNsJq/+zKki6uCz6XjWsaAufUpvXb58F6BNHeWVeNfOf//px0dc3+h96SAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iKph41/l6KCWQScmcBNPUwmZyw5tg+xlsgn3bsPIlo=;
 b=M7oJWfldp8Y7oTKDX+n8UN1ZCjU5CCXqEe+x0UboyhtkPEJDA28OXmGZE2opFwMAxObPGk6KDk2mw13M/o8sedsFp9V7ZLRboZDer9qq9kN3Y6iFcokeVNKfMsDlf9KjSnAXlJuZ5/5n37LWtFUfN5lLouowodkokR5iIQxSTfrf8q46ppQJ4dsd9Go5xh1hZ7Jgzb6G+1PQqHk4tiDKz6wrf3/de+7Hxg5xwDGfSdGIcIx5seSwCRrAvMOZBYBue5VO7DERgCcm+ryODWWpzzzKiW/6rCAhRMFF1HefKzewtdq6IRbt1A2D6C+f/oBmwRj+lYxA1+j0eb08ehFKfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iKph41/l6KCWQScmcBNPUwmZyw5tg+xlsgn3bsPIlo=;
 b=hEqaP/lPWqZh01/hCGJoixyrDTDDO3u+2CBOSWrWZzfvYT3FvrOHVfv9eEymlnN+WVzqXyUKtOO4yKph96EOX4QPGgKi5iV/eZsjyLdDliIFG3exfLFrTee3Bse+38fHJwjglRBowkg0DpDjaKckP5/YygxVk23EJiSVgclsVxH8nScW+XyTWivBmB7YbZLWKxdFtGGQmxz+f1CVw3V7qNsSH/aJf2ramklvjKlbQefn0gAD+k2GTzxFlrH34/jUWVLt6e91x4+7pNgfF+WbBL16kY+qYxAQ5psps7wHwnS3xZ7mdraHQ1Ok8YBeyUeLoSbbdL5wtSEHG9oEwOpnKA==
Received: from AM6PR04MB6311.eurprd04.prod.outlook.com (2603:10a6:20b:b7::20)
 by AS8PR04MB8835.eurprd04.prod.outlook.com (2603:10a6:20b:42e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 19:49:56 +0000
Received: from AM6PR04MB6311.eurprd04.prod.outlook.com
 ([fe80::2b0d:be6b:edaa:62e7]) by AM6PR04MB6311.eurprd04.prod.outlook.com
 ([fe80::2b0d:be6b:edaa:62e7%4]) with mapi id 15.20.5746.023; Wed, 26 Oct 2022
 19:49:56 +0000
From:   "Unterwurzacher, Jakob" <jakob.unterwurzacher@theobroma-systems.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Schulz, Quentin" <quentin.schulz@theobroma-systems.com>
Subject: ext4 online resize -> EXT4-fs error (device loop0) in
 ext4_update_backup_sb:174: Filesystem failed CRC
Thread-Topic: ext4 online resize -> EXT4-fs error (device loop0) in
 ext4_update_backup_sb:174: Filesystem failed CRC
Thread-Index: AQHY6Vh07NWAYfAnJEaRlnjG+OPkxA==
Date:   Wed, 26 Oct 2022 19:49:56 +0000
Message-ID: <AM6PR04MB63111922B96138C374A39C68C7309@AM6PR04MB6311.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6311:EE_|AS8PR04MB8835:EE_
x-ms-office365-filtering-correlation-id: f1cad19b-9dcd-4627-2d1a-08dab78b420f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LaptJn2HpAKHYJA3Z4Mjp/Z6o1+TdCTlp+WXzihPIn4sYMcFBJSWUHKj6Hma0eUC9wI4l+sAD6UN20oF+iwXaf77Zz5qDJdtyyB7jWE2OouN5A1GchmoHVxzOf/wEXUayviVhAkAgWnNR6I+xTlS4tJHOWdrB5eZGuQaZ/Hbxyld59rEYugoIwh5O5nSbcQ9vF7kjvLyX0NaHcHckaymhECjZfbWpnHuEswhnO4VIl24mfkzAwh76OvWxEJ0vNstmr/OElGFp+Qhk9kT69adSqe76W4j6ArROsDjf7y2YmcuN/kEgdlCa+ZqDnkaRWFJthiyDGFwDatk3b7RLf50O5wRiojhcruB7jG1QhboTDhjmgWb2jxVGLhk3Kl9c6OYbBIB0UPpQbGqSU4cMH7/YUlh9KP5zQR+Y4+K6sFgFiS/6n7eY3a1ElMQL7uSN3PhibxWS2Xl4qxjM45pba0xyUGaM2wQa6v3LYdBIgXNT0J2zF+Ng0+ccc8zttZyMqs5nBYiT82xFXFiTkfwTVFj2sIxqs3q3d8FfaB69ctcDpjotvBhvU0YwWGRdvqHzFLkhIBRkFVqY12oqqA9+XWgiO+IlkE4Naukn2O5Q9vi33MvmYNdM5zs4YEaSwBvQ6Ohj5dNFF0uX8r0c0qN2tJxY9HUV/LSZZUg1PkqFMwYFw/aE13XtLY4KZx8lN2M+GV3abnL/573R2/yLzf9/aSv9qJ2ONm5TiyN0FLuOm3mvBhDSB+1W6tIy32I8pToFgB0VOsN2c3DK6modH8PmnYTYPEJnRsMDxGC8Pg25HbEq1o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6311.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(39850400004)(376002)(366004)(451199015)(83380400001)(33656002)(6916009)(54906003)(38070700005)(38100700002)(966005)(316002)(8676002)(66476007)(66946007)(52536014)(5660300002)(76116006)(55016003)(2906002)(66446008)(91956017)(64756008)(66556008)(450100002)(71200400001)(4326008)(41300700001)(9686003)(8936002)(107886003)(7696005)(86362001)(122000001)(478600001)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+pqUytnNBsyIXtBruBc2mY83w0YsCHNJdSb/sLoV0MFdhMtSDUic9MpSP3?=
 =?iso-8859-1?Q?YS5/HePhFSwXramkeKkvuHi0mibFPGkpT62Ixuui/RqmO/SNUqq5DmgyP4?=
 =?iso-8859-1?Q?rN7sLls99EgVwD3TjLseymgkUh/245eg+KP65fFK/mY1lCfR5AjzMs+aZ0?=
 =?iso-8859-1?Q?m+HznxXdVM+J1F0ATKv67nBT1XqUwCg2fU39ksY3ouUWkY410B3PKNXv5a?=
 =?iso-8859-1?Q?vaFzISCm7Q7KJdQNL5nY22Q3AqxhbaPoQsV//Xrbcm5RtrhlBtrZWw9OVH?=
 =?iso-8859-1?Q?piPahfS4yVAF0RdQNNv6qIy7x/LaWw8rKFjO4PdQkRzdFddpdAJvu7Kkdg?=
 =?iso-8859-1?Q?suEtwndvIAHPukUK013yUf1WmwJO22E09yzMHm/kxvpFLaDZoo9ZfJxgKq?=
 =?iso-8859-1?Q?u0CkESFPtuD6BE9MCMwQIWF7ct5DHvPnQ4HAV4VG1ZllkcO5C+WbcZ6t8t?=
 =?iso-8859-1?Q?Pj1ciso80KWTBZmAXlVPMwCLHGca1W+nH5cC79RGuY0ghB7g4VuUmCT9d/?=
 =?iso-8859-1?Q?6F7pH4L5Nk3X7fxx0ezwauhEzb3VHNSsVXIXXfOdXiT2cY4Uu+AhMEDEMV?=
 =?iso-8859-1?Q?7o81XnuXHftbuS0B6ubItoWvCLMgefdqLSOYmSIE9sBolU4ndCpwC1My9f?=
 =?iso-8859-1?Q?qKTnWPOMpGNORUYBmMkJ+bz57jY7eATjeRdjrnJNdKWXgtXpp0EkT+AQ0w?=
 =?iso-8859-1?Q?z/w/tmY6KUUQw5aVpyvTCCXeF9ttPhiB4rd15BnMZQd247vCN8katGPBYO?=
 =?iso-8859-1?Q?Y/SpKurvH2ri+mstWmLTFocwwpP+csQo1OWaZ6J7Edo7grR7p/4KCCmsmN?=
 =?iso-8859-1?Q?6beNBxyCDNoXve/kVQiAZc+Lv2l55KHCw84MNfE+/f8U8BldKBHcF4OCL+?=
 =?iso-8859-1?Q?Ie1Bv5Tvn08xeeAmJ/vHj8q2+yD04v/5R2DZMv2Kmtc73UVsraIeoyUKuS?=
 =?iso-8859-1?Q?wwgDc5BNMcc4iumlagQ6JdPN239XQam2SvL1ao16yLZfpMq6FZHJAfT9NN?=
 =?iso-8859-1?Q?eBJb0md9T3oKBMsS0Pr0w75Ks15eyVGXCQs5u34j1Cgitc9HrzL5oV7oQn?=
 =?iso-8859-1?Q?K7dUIa9u0GtZAprF15u1nx2lCnSj97N2CoZsh2F3aKYrpEtE1iE6BTZyYt?=
 =?iso-8859-1?Q?V5Wd0MLQAgqx8v/iurZvuF9rCC2jgpa0nUHXRlPSyRvLK93mXbPPmTopda?=
 =?iso-8859-1?Q?IdG/nXeCn5qIQ5ulmWjt5EAIhWR8ZRbZP31Ir3BNc/7G4OIN8wsRNDot7W?=
 =?iso-8859-1?Q?y6vFwgCQdu0SgDCKakUyp1C2pG7QxKoraxRNkgCIWLOgZojFwWCVDeQLsE?=
 =?iso-8859-1?Q?QQr+iHBz1pcR3+JB2w5AdJ9bRECpnEBVNzRW5WTluIxiCiobq/zM+U1kZ1?=
 =?iso-8859-1?Q?UVEWL90eRPSbOsnsp1aUmu6xnmCsmgO/S7lA0SX9ibR1Pe+a+NO3z7ZMe6?=
 =?iso-8859-1?Q?2KVISnMYgGySbQzVFUxhdVlms4Pi2FtGK04fnkeRRjYEoHUImTqGUJH+ph?=
 =?iso-8859-1?Q?QzLL3j2JHQaaYagW2uLgP0bzt4rNyE6NUmEQe1juzEHBHUqzcGKCPPfoWy?=
 =?iso-8859-1?Q?Cc0CkS9Kjp0IgKua7giTA6bWR8bboR7U+IP7WMtrm8td+EISpmJGk4jJZM?=
 =?iso-8859-1?Q?BadE4m/WsTwWHnXZXzzpZ4FW4DjGZJUMA76ciFFqmt6KYfPooLhlzD+owP?=
 =?iso-8859-1?Q?vvXZ2lac4lztA/PPOicry1A880TGAuXzfFsPg2ysiUNdCzW9AT9RdgCGHG?=
 =?iso-8859-1?Q?E5U3aLqTus3Y97C72RLeK4dCY7qp8pixhV4WKj+kYazyFN?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6311.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cad19b-9dcd-4627-2d1a-08dab78b420f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 19:49:56.2818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EG0RXX6/1/Ed8I/b0R+ONJneu+EY5cmH9wnAQdmiAU0+mNu2A2RlixHJgXRyzkwRBIys07d2s4IJixh9xZpdNHbgIpF7/wF4sYEykdUqlREGKqblm3STv1Yqz9fTQWngZqbkg3TAzmNHivwZzbwZkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8835
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,=0A=
=0A=
it looks like I am hitting a similar issue as reported by Borislav Petkov=
=0A=
in April 2022 ( https://lore.kernel.org/lkml/YmqOqGKajOOx90ZY@zn.tnic/ ).=
=0A=
=0A=
I'm on kernel 6.0.5 and see this on arm64 as well as x86_64.=0A=
I have a 100% reproducer using a loop mount, here it is:=0A=
=0A=
	truncate -s 16g ext4.img=0A=
	mkfs.ext4 ext4.img 500m=0A=
	mkdir ext4.mnt=0A=
	mount ext4.img ext4.mnt=0A=
	resize2fs ext4.img=0A=
=0A=
And these are the kernel messages it generates:=0A=
=0A=
	[   33.774267] loop0: detected capacity change from 0 to 33554432=0A=
	[   33.796319] EXT4-fs (loop0): mounted filesystem with ordered data mode.=
 Quota mode: none.=0A=
	[   33.796518] ext4 filesystem being mounted at /root/ext4.mnt supports ti=
mestamps until 2038 (0x7fffffff)=0A=
	[   33.799324] EXT4-fs (loop0): resizing filesystem from 512000 to 1677721=
6 blocks=0A=
	[   33.933110] EXT4-fs (loop0): resized filesystem to 16777216=0A=
	[   33.965633] EXT4-fs (loop0): Invalid checksum for backup superblock 819=
3=0A=
=0A=
	[   33.965675] EXT4-fs error (device loop0) in ext4_update_backup_sb:174: =
Filesystem failed CRC=0A=
	[   33.965884] EXT4-fs (loop0): Invalid checksum for backup superblock 245=
77=0A=
=0A=
	[   33.965902] EXT4-fs error (device loop0) in ext4_update_backup_sb:174: =
Filesystem failed CRC=0A=
	[   33.966058] EXT4-fs (loop0): Invalid checksum for backup superblock 409=
61=0A=
=0A=
	[   33.966075] EXT4-fs error (device loop0) in ext4_update_backup_sb:174: =
Filesystem failed CRC=0A=
	[   33.966225] EXT4-fs (loop0): Invalid checksum for backup superblock 573=
45=0A=
=0A=
	[   33.966242] EXT4-fs error (device loop0) in ext4_update_backup_sb:174: =
Filesystem failed CRC=0A=
	[   33.966398] EXT4-fs (loop0): Invalid checksum for backup superblock 737=
29=0A=
=0A=
	[   33.966415] EXT4-fs error (device loop0) in ext4_update_backup_sb:174: =
Filesystem failed CRC=0A=
	[   33.966557] EXT4-fs (loop0): Invalid checksum for backup superblock 204=
801=0A=
=0A=
	[   33.966574] EXT4-fs error (device loop0) in ext4_update_backup_sb:174: =
Filesystem failed CRC=0A=
	[   33.966765] EXT4-fs (loop0): Invalid checksum for backup superblock 221=
185=0A=
=0A=
	[   33.966784] EXT4-fs error (device loop0) in ext4_update_backup_sb:174: =
Filesystem failed CRC=0A=
	[   33.966946] EXT4-fs error (device loop0) in ext4_update_backup_sb:174: =
Filesystem failed CRC=0A=
	[   33.967074] EXT4-fs error (device loop0) in ext4_update_backup_sb:174: =
Filesystem failed CRC=0A=
	[   33.967237] EXT4-fs error (device loop0) in ext4_update_backup_sb:174: =
Filesystem failed CRC=0A=
=0A=
e2fsck seems mostly happy, should I be concerned?=0A=
=0A=
	e2fsck ext4.img =0A=
=0A=
	e2fsck 1.46.2 (28-Feb-2021)=0A=
	ext4.img contains a file system with errors, check forced.=0A=
	Pass 1: Checking inodes, blocks, and sizes=0A=
	Pass 2: Checking directory structure=0A=
	Pass 3: Checking directory connectivity=0A=
	Pass 4: Checking reference counts=0A=
	Pass 5: Checking group summary information=0A=
	ext4.img: 11/4161536 files (0.0% non-contiguous), 536410/16777216 blocks=
=0A=
=0A=
Thank you,=0A=
Jakob=
