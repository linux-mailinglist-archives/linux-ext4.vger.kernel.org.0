Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E6E65B865
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jan 2023 01:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjACAfG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Jan 2023 19:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjACAfF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Jan 2023 19:35:05 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2112.outbound.protection.outlook.com [40.107.7.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C7C6378
        for <linux-ext4@vger.kernel.org>; Mon,  2 Jan 2023 16:35:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQsYmepQfKZN/O0Af6LREIGacFLvVnd0wQuDZvCSXQ45UlczyYEvQHP8tR/OEcs/V+Y25jnoeBKhh3ncFdFIAzbphn+oHTBG//1k01MtVkGzLkZqi3FlSRf7Y7x67TesNVPtQzOKqSBZmkHlA1UqfM7IEMflJmLyqTakscl3tBTtiVmr6ZmdpXWRAcI7FrnwFOzHhEr05gOV9kGfOhzo5wOc92B5J+tZIGJfZiGYdPPA5avvXa8YBZabGQwURhfLKxD2Jx2RX8oz65VbVuCLsr1VdP+MsXNdDy5Ocjc0j29W6c4/8P3bUpepaQsdd8tm2BseOgGL9P3rD/Ei2vZuiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuGP5+63WQwbc24T0+ObbW9glruJNID+UGjPR+UeFYA=;
 b=ROi8JLY4R6g/ucveNGC2wpkAQwQOpj8a0uZ+9ZbID0O2VSpKEcXFanF3HYFxvG2Orpj9995t92W8/J9zA69N55ykAmq4us0enLs2ROnVgUwceilSsua93/K59a0UdfBC6mT+ZytHJOBKdSVnPEBmX1RP5K166hG+5fha7wXCdjprMmLeln7zLSPZSW683aGOUCMv4MH7blE+7BVmKLcY2SOYR9+YZehQGs3piCVIcwzhU+dQTY3A1w6UM9Fl7ZxzPNTAD6GH8M9P/OB8ezrELjhvmzrevCBfeYPEyUOWkQyYU4USiDh865NcfnSUfFIdWzVDMTIuRBZCZEHwsVpndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=thxer.hu; dmarc=pass action=none header.from=thxer.hu;
 dkim=pass header.d=thxer.hu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thxer.hu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuGP5+63WQwbc24T0+ObbW9glruJNID+UGjPR+UeFYA=;
 b=qmTmqeUINzYFOseh+ij8VKCF5BsfdDC9yA/5RCVsQym8rh4B1M2BD+DhxkoCLSEQdIYbEJByweuQckn7DIjr8xMRIRILYpKY8IbSQpMt7E3HJ6FiXYcbmu0TX936vfL0soZLIsF9gOh/ri+PWLXnPg9iu3vUerj8fgZAW3frE04=
Received: from VI1PR0302MB2685.eurprd03.prod.outlook.com
 (2603:10a6:800:e3::16) by AM9PR03MB6865.eurprd03.prod.outlook.com
 (2603:10a6:20b:2db::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 00:35:02 +0000
Received: from VI1PR0302MB2685.eurprd03.prod.outlook.com
 ([fe80::ab53:6852:cfe4:558b]) by VI1PR0302MB2685.eurprd03.prod.outlook.com
 ([fe80::ab53:6852:cfe4:558b%11]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 00:35:02 +0000
From:   Zsolt Murzsa <thxer@thxer.hu>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: ext4 superblock checksum invalid after running resize2fs
Thread-Topic: ext4 superblock checksum invalid after running resize2fs
Thread-Index: AdkfCzF0Pqw02wRtSyy1bceOyTYuFg==
Date:   Tue, 3 Jan 2023 00:35:02 +0000
Message-ID: <VI1PR0302MB2685C0378F00C4CC413B85E6C9F49@VI1PR0302MB2685.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=thxer.hu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR0302MB2685:EE_|AM9PR03MB6865:EE_
x-ms-office365-filtering-correlation-id: d38ea004-c9a9-4a74-48d5-08daed225a10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHmojaNqFgPPe1wg0nzatgdR0NuS+zelhvuYKkSgUUz3m+eq4cXk9SERDxkyAhBXchz+vwgPlOnlzQ4tBJzhUiPclDW3jGtiyhLfSY89qbZ21RlN/VmnRCnuv31uk3SxU3klrrhJrOD76v+fhvtr61N2uCZCWym9sk7RQqm7lKvUn5nXQcBT9h5N8LkfAffZ5hBEoSgPdP+IZihymUZa5yrCdNPu9ISMCKi3JvhechGlwiGyy753SUhg9AaBsr1jzK//RLH74GD6+2Xr4u/ZK7nacpSE/OfKiNRq7vNYyZJY+C7ULtb+D89iHVIZ2SAC+B7A70I93eLlogqh1cBjtQ7iN6uAIUMZ86cfsMXRRix77G5c3E7HXkfFio37DU6/ipxuQqtE3ZJabcjyaEoVJ1SI2uU0t66py8YFK6ikcFfI5+KIpg60nFwVY591ADIuN8u5bicfREzi2yR9aHrpBr+c7C9mABjsFvRW3UJ7e0uw0FlqlQAaAXdwMqs9ZwJrigH+mjbqJ7m8BD2FxwuEaphwNL0wTAaI+UuPvK1UcH5SlHp7HVLQ0TWhOcQEV2wW7XvI4sMXDcDWVML07M86hjJ4huAR6IPpYOAgPEPcf07b1/DkH4C/tFMdi5RIRdOcheR2QsZHERaAe3ZaTqu/BlCRhLMpNuv9f3iNsMGQ0L811kC7JVVyJJ+wXq9AsSdS0/+PJ7idV2sAcu47urMR5uj+QIwic1Ay0TEYTd3TbxE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0302MB2685.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(366004)(396003)(39830400003)(451199015)(26005)(186003)(83380400001)(9686003)(86362001)(55016003)(33656002)(38070700005)(122000001)(38100700002)(76116006)(316002)(2906002)(6916009)(52536014)(66946007)(41300700001)(8936002)(5660300002)(8676002)(66556008)(66446008)(66476007)(64756008)(478600001)(71200400001)(6506007)(7696005)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J//ryCY5AgxBM6bfe4qaW7adWh+nFljrPVnJvfYrGFWU0sRWd53F6TMC4XGj?=
 =?us-ascii?Q?hWlxxzwyHeijhWvCxZCwlhcM+kbWp8ADCA6vyY9FoYWNBEDrDIXw1z+1dTys?=
 =?us-ascii?Q?K7CUdwQfoRGO+Btx1Y90El3y9c4BBVgDRqbYSixGh4v/Q3OzKIlXxo0lM7CA?=
 =?us-ascii?Q?ZIeidjbQOjE7lnQwT2kGNWV1B5T18Z4D4+oNidFm5QsaNwfo9UuOMm54sNuX?=
 =?us-ascii?Q?vTKCIHW+Jm/3bwDaBf6tUc9sp1ykkLC8bHn448akF6jTR5bPDA6zWTJwyGCJ?=
 =?us-ascii?Q?YXKB1Ix62v/mNVBuoj4IVRUJ/Uessq4qkM5XWddrUQ89EyeaP1jgLsVSLvR3?=
 =?us-ascii?Q?EYYgtiR1RwT8h6ri8Gs1SI5TyT5mjSISHoAZzA+EgIP0a4kuDb30pPxndFse?=
 =?us-ascii?Q?3e6qZbsa+fzis+/fo+043SqCjO2ZIFa75gHeyvDNjghEGBswu+vs7zHiBME5?=
 =?us-ascii?Q?LBXiQDngvGhS00ymQbGOXugGGcR/0I6AseSIrXHpaBeavBEdZDlstK/WImKJ?=
 =?us-ascii?Q?r2GiLcd2SktfgrsqHiv9sdPAMtf9F9LFK7/CZHu5vpjhKhmCMed6lENudVTM?=
 =?us-ascii?Q?6g2dYkZRRVsY6CzyIEwmKr4mhWaD12lsbkC5gqkrK/r42H1LZIQf4SR4zl54?=
 =?us-ascii?Q?EZEm2FUu0xqeAEjTzQpgTNmL5NG56n+BybZmZWAjohM+Dy5SVI4yQhnXQ0Mk?=
 =?us-ascii?Q?BjEL9i6ZgRF4Qn25iLfrlKcgq+v7WXiJFecY8G+FPf63qltTRMgO4jyx0TgP?=
 =?us-ascii?Q?dxRvT6PJ3wOKM8a73z06/PgHmH1LiKgIcb23lnWcuohZejVuUcqg0FAnqYK3?=
 =?us-ascii?Q?OQHnf5Mv9jQp50N5aWZsCDNQI2SfMqeoyLAEkS7vj5StG84HhRkaOrH0y2oe?=
 =?us-ascii?Q?JaPD1tEbF6qs8AXzkblsCMuEBYpDYW4/mVx5+woK1vBSVU2bCb60/WBG7tyM?=
 =?us-ascii?Q?zAPsSQIUkRFQTlgi0XQmeZXO3eCdQz9tlOGIqOEgbq1c6JtgHLyuqZNRscxr?=
 =?us-ascii?Q?5BpDw7wPhviPXC6RsrH08qBhTd5RT73s1KCZ+xu5JMAf4TC7B7Tj8ZDVCkbA?=
 =?us-ascii?Q?6Xe0RnZFspuEPTw1obCoByhli65A50F9tyi+T43Yqy7aXE8MI8HY+trA3Ui1?=
 =?us-ascii?Q?TgjtwT497oI4riNh3GGBgcNFUW52EKcAOhChxKv4g6FOy5xuGbLVy6IbG/i+?=
 =?us-ascii?Q?8kBGGrSqx78eH3EN7rO43iilhiwLmffVw3Gc8QHdMcr6c5o5bkuEROqorASn?=
 =?us-ascii?Q?3vhEkcgLmj+WIbt7m8r5QCgrXW1r6c8Ka4b+5nmMjx1qiWLPKzuTxFrzJHvE?=
 =?us-ascii?Q?kWOB6B3dlq/a2JrNKJn6f+SlVyqdJBmn2HSthvKMX9PP/HH1cP6R7R3B6nc+?=
 =?us-ascii?Q?Sst/B3ySjQ0PtoHcv0Tu1Od6c4DmoGV+sTj5/G54KVK7J2Riglg0vMpF4+iW?=
 =?us-ascii?Q?t4+5Fh0TaZhqOyhWKA+1tiOY8A0vtE4aSK/WeR03nIDtrDL8gHyyGSUqiuuz?=
 =?us-ascii?Q?yqCC9spqSzP9QfUKAH8k3+ZAmNOyUtESlDvz8+bcJk9PPHHXhnVXlPJBxM2p?=
 =?us-ascii?Q?st9BBRqyWGXPoDP/weE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: thxer.hu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0302MB2685.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38ea004-c9a9-4a74-48d5-08daed225a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 00:35:02.1565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66454c68-3d66-459b-b814-daede4e20a50
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBwgpC2NnqtPEUaqmxVAXdAUDEX+dAxVgiXqPm5e2ccj8c6mTz3oGyGdOUDqSp37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6865
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

I've had the same issue with twice in the last couple of days with the resi=
ze2fs online expand function.=20
I have a md raid 1, with an LVM volume, which is formatted with ext4. I res=
ized the volume (from 4T to 5T), then I ran resize2fs, which ran without er=
ror, the file system got bigger.=20

After a few hours, I reset the machine (unsafely), due to some zombie proce=
sses, but after restarting, the system could not mount the filesystem.
I checked the disks, and ran some hardware checks, but I didn't find anythi=
ng wrong. I thought the hard reset caused some problem.

That was the problem: "Superblock checksum does not match superblock". I tr=
ied several superblocks, e2fsck, testdisk, but nothing helped, dumpe2fs sho=
wed all the data about the superblock.=20
I started to restore from a backup.=20

In the meantime, I found the debugfs tool, with which I could skip the chec=
ksum check and thus see all the folders and files that I restored to a sepa=
rate disk.
I replaced the two drives, recreated md RAID 1, LVM, then reformatted with =
ext4, started copying the data back.

I ran out of space so expanded the LV and ran resize2fs again (from 3T to 5=
T). It ran successfully again, the attached file system is 5T.=20
Then I ran an e2fsck.

"e2fsck -n /dev/vg1/data
e2fsck 1.46.5 (30-Dec-2021)
Warning!  /dev/vg1/data is mounted.
ext2fs_open2: Superblock checksum does not match superblock
e2fsck: Superblock invalid, trying backup blocks...
e2fsck: Superblock checksum does not match superblock while trying to open =
/dev/vg1/data

The superblock could not be read or does not describe a valid ext2/ext3/ext=
4
filesystem.  If the device is valid and it really contains an ext2/ext3/ext=
4
filesystem (and not swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate superblock:
    e2fsck -b 8193 <device>
or
    e2fsck -b 32768 <device>"

I'm shocked it happened again.
I can currently write / read the files, but it is suspicious that I will no=
t be able to mount the filesystem again.
In the first case, I couldn't find a simple solution, but is it possible to=
 fix the checksum somehow?
It takes a lot of time to use debugfs to copy everything to another drive a=
nd back again.

My current kernel version: 5.19.17-1-pve.
I can attach all the superblocks (Both the first and second case), or any o=
ther information, if needed.=20

Best Regards,
Zsolt Murzsa
