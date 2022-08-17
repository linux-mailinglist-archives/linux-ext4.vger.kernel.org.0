Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7333D596757
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Aug 2022 04:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbiHQCUW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Aug 2022 22:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbiHQCUU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 Aug 2022 22:20:20 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2099.outbound.protection.outlook.com [40.107.255.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19688786E8
        for <linux-ext4@vger.kernel.org>; Tue, 16 Aug 2022 19:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwQ3cBaJocNjUQGvhJpotv8xdFKs+x8n5Aj0iaCfLqc1G6W0nQ/0sY0u9ryQa8ZubjMrSeMoni7ydH4u6p7WB4LZtFiUp2N00YOI69nz03dbAFw0fZ94FoTve8T6kOe4D46EKbabBOLFYXmG2foHjvDtFIGsaU/nS0gY8QAoBS84VNrwcIVL0EViDXwXuEkME6bIo6bJb1OgnQCNMsUz5JBsf1P9LyJsGAgCNuHV84nHb2kJ9KeHb0BDJov4IKkFCwqxI2rKHaR9HQy/sQY7GjjEqJibJt7Pcx2P74dAPv7o972mrCqeYsRsKYmqo4rVPZvS4yPS8sH4mDvbGzyEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZvFBUbz4HA8HtB9KybbTqrzpBTrwuoVzqtNdZmCbfw=;
 b=HBLq3Qoz9UucQY5BwEErA3VDeVAjZ5TLx2tSXXXRKhdF/2jvrYVgNtEvgPxcWaetbG0zq9eQsbAHNlO+HFEwPyvYWS30SggIM/uOkfX406/X3JaNKtxiKCqprrLPFLGdIfX79OqN1eahW/FtaA4rADhNpLXM2CHUr2XLyMRNeo7VQRIIqm6B1CwjLBhwN45AxeVwEYcdD3SMJBad3YEuL3SJwdsCKMwOik6nPXLOKtSTpkne9u6O2MhqcvkpJedn5ot29s/Gs/fdyiAMmoTiwyAkJN1AutBr0U8E/p6rx5F99n9a3NHe45OY0x00kk7xa8w1J6tU2tMdZzqdprg5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qnap.com; dmarc=pass action=none header.from=qnap.com;
 dkim=pass header.d=qnap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZvFBUbz4HA8HtB9KybbTqrzpBTrwuoVzqtNdZmCbfw=;
 b=TH9cARY/UP6+Vipfr7FeNWwjj5TftSSo8ZR7ZoqctDR93alwwN+Fhu40f/1x90w+apvBvFrp0ZiJTWkGpoF/nhW0BZyvU0XTcyO0nCh8ixbpJaMT9TOxw8KGyNrNRY5UBqhtpoQsuMCnxvMI+TE1/IDK8AhRJXXg4KabUI9cf4pPal3wrfPrRDaRX6oS3+WX29oKOK9jgq5oEhEjX6O8qCs1+X7paOse1V7dlFdk9XYOg/N2XbRqfoRWNVNjgFigbTgCaGKYP00ZdyhgPWk+QQa1BCj8P3QqkgvjxPx42T0JWhUQA0M1dzQGV1SjqG0SXCc51raGjT/G3WgKZxo9hw==
Received: from PU1PR04MB2263.apcprd04.prod.outlook.com (2603:1096:803:2e::19)
 by SI2PR04MB4346.apcprd04.prod.outlook.com (2603:1096:4:f3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Wed, 17 Aug 2022 02:20:15 +0000
Received: from PU1PR04MB2263.apcprd04.prod.outlook.com
 ([fe80::f01b:e0e7:ca03:1cd5]) by PU1PR04MB2263.apcprd04.prod.outlook.com
 ([fe80::f01b:e0e7:ca03:1cd5%7]) with mapi id 15.20.5504.017; Wed, 17 Aug 2022
 02:20:15 +0000
From:   =?iso-2022-jp?B?SmVycnkgTGVlIBskQk17PSQ4LRsoQg==?= 
        <jerrylee@qnap.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: [PATCH] ext4: continue to expand file system when the target size
 doesn't reach
Thread-Topic: [PATCH] ext4: continue to expand file system when the target
 size doesn't reach
Thread-Index: AQHYmo+nK7zL3oUZbkSW7IOOu69fPa2yinVL
Date:   Wed, 17 Aug 2022 02:20:15 +0000
Message-ID: <PU1PR04MB2263C18731A8A9F9A95B9293A16A9@PU1PR04MB2263.apcprd04.prod.outlook.com>
References: <PU1PR04MB22635E739BD21150DC182AC6A18C9@PU1PR04MB2263.apcprd04.prod.outlook.com>
In-Reply-To: <PU1PR04MB22635E739BD21150DC182AC6A18C9@PU1PR04MB2263.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qnap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebbee813-2c9f-4d53-25d9-08da7ff7056b
x-ms-traffictypediagnostic: SI2PR04MB4346:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YR4I46MQTJp87/lGl2iYMiY10CUZJQ2DKZDFYrg2kXPibHjotdkDoc+Abc+6bEvZsAOMW/NGlWHhZSbBn1OjYqoohoUDHBd2xlJTtCY5hVSsQUfMd6suiXecuq+vRtpY1vIZ2P7FVW7VIRDBuOQ0DBQ+tWiHTDHqHt8qKYlGTGXMKOiyxZu8l6A0FccRG8jeNjqCmDqoofU545Mp43r+e/i26pLpnkE8bsAhHuYnxDw7lKHMC1AkNKpGzDPX7TjrVEy8nkjseeq1ma0DMwxj1N8X+bujYiXm0gshetBAp9yYl9gwWJ2DGUQLRmukprXoTbGxF0mTkfN4izgmkrIy9OyjzJsqTqdeRJPPoxGpH73+IH1p+WYhsS9ItuqwXcEqMvUmB3n9QDRBmj+sCGcSjda0nqDLXsEmwlYEQOwaW+4g22MpywOOP4DDXH0a5OqXgFyoUSTdePkziJHCo4IJLCz79yWxFuvwpaixbezSjulLDMNHcnEsLVplpsvINp96wVcMBdhoe+UBZjyJdTZ4q7qZ+5bOEgp+3X08fZBSr7ow2SGsBxCux6Okd/SwNQIojo8iskacfcDEmiOs37xcBOAtTHJGbWGzPnxBMNzoahr0nswEHevTK+yySi8/qBiNIGJ5Z8KfRmfMBqdkbbVFbLqdakNodtdJ8NGiU3NrzENwuBQ/98MJcP4gh/Vig0w6NMdfc75qi//m6SL34y9XHXihEyISt5Z1QfjwMVySnZgZPQFsgjDnuwD5FIAFGwDkj+PnvrmK0bwZs99dePOGW2yrILrVq5ZfSyQZC12WVjEtBKyjPtMBeSkQOboC0aSq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU1PR04MB2263.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39850400004)(376002)(366004)(136003)(346002)(53546011)(7696005)(55236004)(9686003)(38070700005)(6506007)(52536014)(8936002)(2906002)(5660300002)(33656002)(122000001)(41300700001)(478600001)(26005)(55016003)(86362001)(38100700002)(83380400001)(6916009)(186003)(64756008)(66446008)(66476007)(66556008)(76116006)(71200400001)(91956017)(66946007)(4326008)(85182001)(316002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ak1nKzE1MTRDYU5NMExFdkhIb2pQL1RqSTd5OFhITEc0dGRUL3hxY3ZD?=
 =?iso-2022-jp?B?SHRjL3p2T1hGUjE2SVJqK09KSzdHTDRLVFlIMWYzRzBRMlNBanIrSVAw?=
 =?iso-2022-jp?B?cVZHQmNDQjFwNklUMWM2aXBYVzJsMGRvUEIvUTZrVnp2N0k2RDY1RDgv?=
 =?iso-2022-jp?B?alNYTGdaZEhnc3FJUWJnaXdKREtGQXByUytFSm5IRWw4dzVSNVhDdDFC?=
 =?iso-2022-jp?B?WitOV1ZTcWJ1ZXBMcFFmcnhVR2R5OXJDblZrbUtZM0FIYTBidmxCdWZn?=
 =?iso-2022-jp?B?ZzdWckdWYytYTHVIWHU5NEJ2OWhLNnBCbXZJbkRXbnM4U1hEV0ZXQkdt?=
 =?iso-2022-jp?B?cCtKVGU5STM3cXo4cDB1ZFdNdXJZUjcwWGxUWEZ0TUh1Z1ZJQ01wVGhR?=
 =?iso-2022-jp?B?VDJINzN5NVRITm1YblczV092UWNPY2JOd2NZZ2EzTjA1Nk1OVmh4S2Fx?=
 =?iso-2022-jp?B?clpPWHNoeG1tNkVrK1IvcEtMMEVLamNnRWl4V3lGT3E1YUFzRjRrSjQ5?=
 =?iso-2022-jp?B?SWc4RG8xZWM1KzJWWmkxeHBWaVRPelBEd3RBZFluY1hTQVVkei94VUNR?=
 =?iso-2022-jp?B?RGFYcm1xNzJ4dTVoYWdINGVrRFV2QTZvdjREWUVDN3k2Qms0ck5oQ3Zm?=
 =?iso-2022-jp?B?c0E3NEpxNGtXVW9PVFRDaHVMUHdXU1E2NDAvZzZNR21nV29maXQxZkNs?=
 =?iso-2022-jp?B?M05PSEoySlZFOFpESVBuOU1vRGg4NjNENWZXUUpQci8xRjlIMWVvYTVl?=
 =?iso-2022-jp?B?QzZDN2FDN2ZQVVpGZkF2aEx2anZ0RkZ6U3FoMjRRVEo4eXZuUmJsdDNH?=
 =?iso-2022-jp?B?d01FSHpYUG1JdHNtQkIrYndod1pHbjJ4YUpkdVlrR25WUVh6Tk1HRTdR?=
 =?iso-2022-jp?B?aHFkZnRlNXNDeFdTNkdDdXhmUzMyZW9Ra3hFOTFtbzJDOWhhU0hyRkw2?=
 =?iso-2022-jp?B?NEdoaGRadFB3b2VrQXBvVmJCN1BYOFE5ajRiSGNnbGlxcFdLaXk0UzNr?=
 =?iso-2022-jp?B?TlVxaXJZdDQwT1o0NUgrYXJVbXNiV2xVK2hORk9pMW1Nd3Vnb3JFZHp2?=
 =?iso-2022-jp?B?NXowdlN4VGtjYVU2am9NSStYcmRyTWRxYU9mWkZ2Q0FHY2YxaklaZXhV?=
 =?iso-2022-jp?B?ak9GMHFuK0xIL2wwUnlvTjZrTkQ3RlpTK25ybGxQU2FMa3l0UkFKMWVU?=
 =?iso-2022-jp?B?ZlBoUTVIMVEyaWh2Z0FFalBLdFkya0JFbmhUekRobThhMSttTkRMUWxw?=
 =?iso-2022-jp?B?U0Z0czNpTUU0SllCSjFmL1J0QmR4K0hISmxBb1JWNzB2WkhUYm9OdnVl?=
 =?iso-2022-jp?B?dlppZllrNVhyL3hySDdnNGVSelczdGtLN3JUVFZLS2R5ZDcrc3lNSEdy?=
 =?iso-2022-jp?B?eEY1RGFXRm1HV0F1TUJEMm9PNUpsT0ZWQ1o3bHZPOWtQV0tqcW1UUHlY?=
 =?iso-2022-jp?B?TG9NdDZKNVhNempKMEF4bFhiOHJHVnhRdEh0T0M3WDdLakRPSlI5RXNa?=
 =?iso-2022-jp?B?Y1NuZktVcVFLTG8wNFpHUllDd2xSV1hrc21qbnVsdFJZYlNUMlNLOW9M?=
 =?iso-2022-jp?B?QWJMM1ZnSCtRai9ZcTVPa1k2VDlNRGFVNUFrVFlVSlZiMnU5ankxV1dX?=
 =?iso-2022-jp?B?QklkMXo4cW4vV2FKR0lheUw0TDhXVjNkWTNPZzV3UjAycHowMDdpQkV5?=
 =?iso-2022-jp?B?V0I0SUk0cG5jbWllcEZxWkpYRXI3ei95VStrTHhlQlg3U01jTXE3MGQ0?=
 =?iso-2022-jp?B?dENlZHlHY0JHUTMxUkNLci9BZUEwZTBFTytsMXNPWkdmTktqQy9TUXA0?=
 =?iso-2022-jp?B?Kyt2QjZHRTk2Y2UzT0xmZ3ZCZnZleW5Od1VyMDRtaUo2VklYa2xCUVFN?=
 =?iso-2022-jp?B?bVliM2dFRTZid3prOCtyZzJWaktRUGdGWDhSOVU5QzVtc2g1U1FlZERZ?=
 =?iso-2022-jp?B?QVRpb215K1NVTDFWUDRtRS93NFpCVDYveEhNTDRqL1hVNXhoemZEeWY1?=
 =?iso-2022-jp?B?Y3dUSWVodHBJRklEbDkyNDlzMnc0cDkwYjNwcVVRS2dSelEzN2NtNDNU?=
 =?iso-2022-jp?B?bnRNUDNodnQ1c1RmQjM4dmJNL1cvMTNldmVqTmZGcW9PcWZrUnpSeGpG?=
 =?iso-2022-jp?B?VU5wcCtjSllTekJYZy9MZlZuVUZhZzZ3VGJ1djl3aGgzVlFpUU5HZERP?=
 =?iso-2022-jp?B?V1ZVSUFqM0JpVVR1V1g2ZGR5SmlpVkhhNjRtMlhRZVlNL3NkZUhaNTht?=
 =?iso-2022-jp?B?YjNKRVpNMlFtTWJ5MFVBSjB4bXFzclJycz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PU1PR04MB2263.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbee813-2c9f-4d53-25d9-08da7ff7056b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 02:20:15.0591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77hALFLYu4vcZdntvMlta93N06CZCahR/zGs1HVp5nvP+EfG3+WRkmY/xYPM/xUWYcmA4F3Ukzc/6bERaoCpaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4346
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

friendly ping, thanks.

________________________________________
From: Jerry Lee =1B$BM{=3D$8-=1B(B
Sent: Monday, July 18, 2022 6:25 PM
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu
Subject: [PATCH] ext4: continue to expand file system when the target size =
doesn't reach

When expanding a file system from (16TiB-2MiB) to 18TiB, the operation
exits early which leads to result inconsistency between resize2fs and
Ext4 kernel driver.

=3D=3D=3D before =3D=3D=3D
=1B$B!{=1B(B =1B$B"*=1B(B resize2fs /dev/mapper/thin
resize2fs 1.45.5 (07-Jan-2020)
Filesystem at /dev/mapper/thin is mounted on /mnt/test; on-line resizing re=
quired
old_desc_blocks =3D 2048, new_desc_blocks =3D 2304
The filesystem on /dev/mapper/thin is now 4831837696 (4k) blocks long.

[  865.186308] EXT4-fs (dm-5): mounted filesystem with ordered data mode. O=
pts: (null). Quota mode: none.
[  912.091502] dm-4: detected capacity change from 34359738368 to 386547056=
64
[  970.030550] dm-5: detected capacity change from 34359734272 to 386547015=
68
[ 1000.012751] EXT4-fs (dm-5): resizing filesystem from 4294966784 to 48318=
37696 blocks
[ 1000.012878] EXT4-fs (dm-5): resized filesystem to 4294967296

=3D=3D=3D after =3D=3D=3D
[  129.104898] EXT4-fs (dm-5): mounted filesystem with ordered data mode. O=
pts: (null). Quota mode: none.
[  143.773630] dm-4: detected capacity change from 34359738368 to 386547056=
64
[  198.203246] dm-5: detected capacity change from 34359734272 to 386547015=
68
[  207.918603] EXT4-fs (dm-5): resizing filesystem from 4294966784 to 48318=
37696 blocks
[  207.918754] EXT4-fs (dm-5): resizing filesystem from 4294967296 to 48318=
37696 blocks
[  207.918758] EXT4-fs (dm-5): Converting file system to meta_bg
[  207.918790] EXT4-fs (dm-5): resizing filesystem from 4294967296 to 48318=
37696 blocks
[  221.454050] EXT4-fs (dm-5): resized to 4658298880 blocks
[  227.634613] EXT4-fs (dm-5): resized filesystem to 4831837696

Signed-off-by: Jerry Lee <jerrylee@qnap.com>
---
 fs/ext4/resize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 56c9ef0687fc..5ab7d1c38fad 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -2077,7 +2077,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk=
_t n_blocks_count)
                        goto out;
        }

-       if (ext4_blocks_count(es) =3D=3D n_blocks_count)
+       if (ext4_blocks_count(es) =3D=3D n_blocks_count && n_blocks_count_r=
etry =3D=3D 0)
                goto out;

        err =3D ext4_alloc_flex_bg_array(sb, n_group + 1);
--
2.17.1
