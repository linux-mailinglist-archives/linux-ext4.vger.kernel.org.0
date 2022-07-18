Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006BE577F95
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Jul 2022 12:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiGRKZZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Jul 2022 06:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiGRKZY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Jul 2022 06:25:24 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2102.outbound.protection.outlook.com [40.107.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5D2B875
        for <linux-ext4@vger.kernel.org>; Mon, 18 Jul 2022 03:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVPbRJjksUHGzsPN/qdz1iV9pHDu2l8nVfYB/O7BttvJ7ZC8ttd+Ar8MrFRykUTrHWYEtvu+U18TfqG/ogTbWOS40dV8NBOvuDEI+ISyl7ew6siACk/lzCpZrP4rxCDBuCYMtMUGa1plPKSYiu5djFk5wc85mI68+TzzShsy1W5Qkv83q+wWkMEL/DkG18qpW9g4K2zW868w4+jX61SQGl3+DswVGqMPj9vLjFy44COjLMctKZa4f4h/4z0LOkvdKiOj/iTRv+MqjTZeCoDc44F4uDZNrYf6AAPFkAbzAFQQzeRdBSw37/1XTF64j9kK2aoXJxteyXvoGpRs+1jd9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE1bQJbkG3IFakqZT1VE7nSAqISCjyRRruSNUNITmvA=;
 b=DTQxdPPX8BmK6uPyeIaauS54KOzqt3ZdfqdAtINgLZ5uaWSlnwB/8uY8evs1ECYSY+rccArXxG/SWGgeTKwVxx3BX3oYkpi6/rXAYKpZqgcMzzIo/Sw3Je2girGiNvWMKTPheqkF1YqFD+rx0/NDrFZQWV5C0DAayRWbCceUTqXsTat/wIBwMzIDkBLb1j/bOJwyuNm74bXBXntJjtya1gCg8kzfwnbPiY46Yfi4kjQVpi9DHuxRBOQzk4mXOrdF4e6PZblJvxKVC7FYjKgluAbJDa8wAoKcpNBRz1Tma9AdIFzHRV2qOTtIVpkEvXJHTTqkGpz9N+fDzNQ0R6QPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qnap.com; dmarc=pass action=none header.from=qnap.com;
 dkim=pass header.d=qnap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE1bQJbkG3IFakqZT1VE7nSAqISCjyRRruSNUNITmvA=;
 b=NhIuxG1Iew4j5eRE3i0T2Nfmk2N4DgKMxr421kb82qbBql4wuPNk6gKA1+KIzVI8yFYEuk+qOUpY8CWBgkjuhBO7rATmGHE9b20YpJb1awHG7dY92EfsI0o/U77z9ImTXrok2RDzEB9pUnKvZUoqVlDK+zEVPw01a+/pCBMlI/EGX4ducl9+yMxelL7tRtOB1kZHAi3dFj6XdLwqkF5o/TgY9OjZJMM7TGACwdtITLW42HeX1O5AZ/DWxwhjqOPiCT2t6XcxCBB6c0a+XqXGjYDXEbl71bsg9j2YAfNzxriGhfO3NyloAbmaTFchmA23T/phw9UsZ5SS7MCYUr4y+Q==
Received: from PU1PR04MB2263.apcprd04.prod.outlook.com (2603:1096:803:2e::19)
 by TYZPR04MB5856.apcprd04.prod.outlook.com (2603:1096:400:1f0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Mon, 18 Jul
 2022 10:25:20 +0000
Received: from PU1PR04MB2263.apcprd04.prod.outlook.com
 ([fe80::54f1:5d84:c60a:87ed]) by PU1PR04MB2263.apcprd04.prod.outlook.com
 ([fe80::54f1:5d84:c60a:87ed%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 10:25:19 +0000
From:   =?iso-2022-jp?B?SmVycnkgTGVlIBskQk17PSQ4LRsoQg==?= 
        <jerrylee@qnap.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "tytso@mit.edu" <tytso@mit.edu>
Subject: [PATCH] ext4: continue to expand file system when the target size
 doesn't reach
Thread-Topic: [PATCH] ext4: continue to expand file system when the target
 size doesn't reach
Thread-Index: AQHYmo+nK7zL3oUZbkSW7IOOu69fPQ==
Date:   Mon, 18 Jul 2022 10:25:19 +0000
Message-ID: <PU1PR04MB22635E739BD21150DC182AC6A18C9@PU1PR04MB2263.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 79917fc1-474f-3a79-493b-780d336fa216
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qnap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8b7a74c-7afe-4625-5244-08da68a7d0c0
x-ms-traffictypediagnostic: TYZPR04MB5856:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7bnXUy6/2YMep6KyZkLLR5TVr0vhKm9Gex75iDvaYTh1lS3N6ULbs4rHqTsekuqao/WX0lDypnGaIQwlszeAuLQefAarMdSyKcQrvvHwGw6Od85KTe7LuKA60KAlsuDZ8BguKXjSfMj0d5SB3xoOFtxA0cuXKcbTYevFWrotTcKoQnBOc0onmoKcakyk3zJoy16iz48d33fREekYYOI0cCU8Tfl9kF95WYaggatqF/hpwlJTEGJqjobRGPUKbcrB6belRc001Xf1V96FXz5hFWQnwlRUreJztL0MGBtiZHXnpKG8jBbtCX+rq9+2TXSngHBsZnkjC4To0bOYFC6HkMLP87oxLW4rGHwl0MrMG7mRPIvL/eel/sIuaOXPzT+mAOeQ103AadVDz/AA0y0pD1Dy4k28F/gp2hEsGoJn643BOYQwfLRwSFuDVXJp1KdaKTqHjePFTBiSJTFdYhB4OMD6lTFpc6NXWZy/R9F/C3TqUEx9avEGCf2tg4Nb6Gn6GLvOptyw0Zv4Nhny3M0nVZI+DBP4Y+/K1wpTRWFcfNn3g1wLhCpthHg5UzQiLAbKxaizrUrWknCiZXgL6z9ea9tVkn6vYeolMW7iI0Qrwm9njbKgA4v7NQNCvKg9dtVbRf/ex2/kdgRf9wB2I29EEmKTMsWQDi4BiyHNaJWYmBqG32F0nuDNy1T+WOKybUj0wM2CuqPmtQjKS3SNGWE3uIS6rYYDmIakLjwvsp9RoE+9zbOruAQ0V5qr3Kzmq/Itbr27g7C3NSJvnH3Vr0B9Pdp49IhsuJ1rCZgox8C+TWb1lSGZi4g4n3kepv1cpg9u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU1PR04MB2263.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39850400004)(376002)(396003)(366004)(122000001)(26005)(6916009)(9686003)(186003)(85182001)(33656002)(66476007)(64756008)(478600001)(71200400001)(41300700001)(2906002)(86362001)(8936002)(91956017)(316002)(38100700002)(83380400001)(55236004)(6506007)(7696005)(38070700005)(5660300002)(55016003)(76116006)(52536014)(66446008)(8676002)(4326008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?N2ZLZ0VnVEhGSVNDZlgzbktwRzZ2bE11cDVBclhZNldMWkMweWU2OUR4?=
 =?iso-2022-jp?B?Z1dFNFZrUnZEKytWVElKZ3VmSjIyK0xyTjgwVnA1Slg3aVhLdjBLUkth?=
 =?iso-2022-jp?B?a0k4a2xQaWQwYzBqQk0zek9zWUwrTkZ6eEhCZk9HeGhTU0FyY0s4OTBU?=
 =?iso-2022-jp?B?RG00Ri9CUEhuY0RuR1Q5QUpzdVlGRzROMW9QSkdEWGpRNGhTWEsxV00w?=
 =?iso-2022-jp?B?QXQrbnNlQnRDQTBsTjNGTWFjbFViMEI0VHVMeWxJZC9LTUFaQWUzT0dV?=
 =?iso-2022-jp?B?RnI2TENYZjZYV2hyN0Y4RzU3U0xPVXozNDdDMDlUWEpjNHRiOGNqUE9M?=
 =?iso-2022-jp?B?VEEzVzJzV3pReU9ya2VvSEZ5bG5za1Vzem5CZTRlTU5OdzdzOEtMMmZt?=
 =?iso-2022-jp?B?cDUyZ2l0Y05qSE5LUklZUzJsaWRzSU1pSlFsK0M5VW9TeThpS3JaUlRo?=
 =?iso-2022-jp?B?UGlldGlCdVV5ay93aUx2REJxU2xnL1BVS21QeGErTm1YY0hZNFdhalpQ?=
 =?iso-2022-jp?B?a3oxU3dKaUhZNVp5NmZ3TldYUmk5RkoyWGF2ekZVOGR6Y3VrTW9vNmJr?=
 =?iso-2022-jp?B?U1FCU0gxblVEa1FGMG5uZWh4RHpGR1U1Ui82dW1jREdmK0N4a21hK09s?=
 =?iso-2022-jp?B?Vy92VXo5REc3REpjTkE4cGdXdVNvaW1EN0RzeDFMbyswd082cXNENkRI?=
 =?iso-2022-jp?B?Wmt4WlBiN3UrZEpGVHBQNm1MSnJ6STdWWkVDRTZpdnVzL3hUVGRuWDVS?=
 =?iso-2022-jp?B?OVR2M1djZ2ZwVUVuNTd4YW16dm5sRm5ySGdVeFZITXk5M0pDckxwZk5T?=
 =?iso-2022-jp?B?R3NEU0FHV0RoYmNST21YSzMxakJuQ0kwU1hEQ1Q5WlJnOTRKWVpMVEJF?=
 =?iso-2022-jp?B?Q1lNVVlONXlrUmU2SDJJTjRsd3psaVlhaGNndjFhek8xRG9vY0xCVDJX?=
 =?iso-2022-jp?B?SlBKQk5hYTBhWWZ5Q1lZSXZ4UkVDMy9EUHpnNnRic3JFNmlXV1dqZ0h5?=
 =?iso-2022-jp?B?a3FYYVN4QlNXdCszb0tVVzNTUEhuWVpUUGMzOWRIT1M4QTdSOVdnYlNk?=
 =?iso-2022-jp?B?KzczSXNZMTQ2aUl2Z2xFRXJjUHNja1IzMFE4UFpyZ25XSTlEQnZuQmVi?=
 =?iso-2022-jp?B?QUR4ejV0dVg2UmxjWUhGa25BTTlyb1pyU2xkSFRsWWMrcXA0UkFVUjBU?=
 =?iso-2022-jp?B?SmtwamxWM251bWxsb3Y5bDQzUXNLRno4LzFCaXQ5bEZlbzNWQ1kxRy8r?=
 =?iso-2022-jp?B?RkJLLzA3UVJibTlLN3RNYkptdmdsUnd1VmtVdnN3ditDSXk4WUp0cVZR?=
 =?iso-2022-jp?B?MlZBVDg0Z3VSUzArNEtSVWphdmYyajZpNjBZTTdFWGtzUEcvYmRyUHhL?=
 =?iso-2022-jp?B?VmdmTytSWkU2b3pSVlNtWC9ieW9ZSzlWdVdjV1V6K2l5UnJBK08zdVBs?=
 =?iso-2022-jp?B?OFdxaW5HYXpjL0dKSW9sNkl5anROZVRZZ1k2Yng5KzBMMmFIYWlsUVNa?=
 =?iso-2022-jp?B?RHVNRFV5eWN5M29STzFmN2hVa1BYZ2Y0RE9kRDlrSFM0SFg4emxaenV6?=
 =?iso-2022-jp?B?UXFjRG1wVlhTbWN4K2ExaVp2ZjVrc0I2VW1mSlRDUEJETVkvQUNON0cw?=
 =?iso-2022-jp?B?QkV1ZHJrOGJXVThnZHp6dUdNNDE2L3BITktOTFI2TElFMmZwaUZ2ellT?=
 =?iso-2022-jp?B?M3N4Uk5UcmJEOXVaNzU3NUxValQ0MllkNDZhWHArRjRQVHNQbjVrWFBx?=
 =?iso-2022-jp?B?V3FiVkYzc0VYL2tuRkFrUjNXMmZER0lBVG96eExUYmpyUDA3VktRL244?=
 =?iso-2022-jp?B?QU5GNG4xKzVxUk02S0ZOWVFCd1M4WEJ6T1lKczJoMjFTUUJKWGRIWVBv?=
 =?iso-2022-jp?B?RTduNXNaNnJMQ2ZxdUFqMjRMWHlWbVY0cDRtSnNvaHF4L256R2p5NXVj?=
 =?iso-2022-jp?B?cERPUi9IaUI2RHZnajMycDFsaGl5WSt0aWNCMTdxVTMzR25IVm8rbyt3?=
 =?iso-2022-jp?B?c2gwZDBQbjB5blFiUGlNdXo4Y00yR1Y5TktqNG1rdFIrY0pZTUNZL2V2?=
 =?iso-2022-jp?B?NlNsSDk5RkdFbkROa2kzZTB4Z0I0S0xRM2dZa1V6L0VpZmhBZ2xmZEI5?=
 =?iso-2022-jp?B?bVp3Q1BoLzFmbWVXa0s1QjJrcmRrRVFkS3VrRmFWZC9zSmtNaVoyR2tN?=
 =?iso-2022-jp?B?N0VGdlE5TlJNNERQWi9VVlJqWXIyeUIzbUNvbzI1YUNya2xySjFlR2Zy?=
 =?iso-2022-jp?B?dDJHSzQ5WjhSMlFtN1hXU2lMR3FISG5Sbz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PU1PR04MB2263.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b7a74c-7afe-4625-5244-08da68a7d0c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 10:25:19.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MmHcJSJf9s+JUV1CEmNZuPswgnZ5WH8AcYCjK7tGiaXwhLp3NfXBv88EAtWkozyjV0CGlTK4jE53+v0pmoJOJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5856
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When expanding a file system from (16TiB-2MiB) to 18TiB, the operation=0A=
exits early which leads to result inconsistency between resize2fs and=0A=
Ext4 kernel driver.=0A=
=0A=
=3D=3D=3D before =3D=3D=3D=0A=
=1B$B!{=1B(B =1B$B"*=1B(B resize2fs /dev/mapper/thin=0A=
resize2fs 1.45.5 (07-Jan-2020)=0A=
Filesystem at /dev/mapper/thin is mounted on /mnt/test; on-line resizing re=
quired=0A=
old_desc_blocks =3D 2048, new_desc_blocks =3D 2304=0A=
The filesystem on /dev/mapper/thin is now 4831837696 (4k) blocks long.=0A=
=0A=
[  865.186308] EXT4-fs (dm-5): mounted filesystem with ordered data mode. O=
pts: (null). Quota mode: none.=0A=
[  912.091502] dm-4: detected capacity change from 34359738368 to 386547056=
64=0A=
[  970.030550] dm-5: detected capacity change from 34359734272 to 386547015=
68=0A=
[ 1000.012751] EXT4-fs (dm-5): resizing filesystem from 4294966784 to 48318=
37696 blocks=0A=
[ 1000.012878] EXT4-fs (dm-5): resized filesystem to 4294967296=0A=
=0A=
=3D=3D=3D after =3D=3D=3D=0A=
[  129.104898] EXT4-fs (dm-5): mounted filesystem with ordered data mode. O=
pts: (null). Quota mode: none.=0A=
[  143.773630] dm-4: detected capacity change from 34359738368 to 386547056=
64=0A=
[  198.203246] dm-5: detected capacity change from 34359734272 to 386547015=
68=0A=
[  207.918603] EXT4-fs (dm-5): resizing filesystem from 4294966784 to 48318=
37696 blocks=0A=
[  207.918754] EXT4-fs (dm-5): resizing filesystem from 4294967296 to 48318=
37696 blocks=0A=
[  207.918758] EXT4-fs (dm-5): Converting file system to meta_bg=0A=
[  207.918790] EXT4-fs (dm-5): resizing filesystem from 4294967296 to 48318=
37696 blocks=0A=
[  221.454050] EXT4-fs (dm-5): resized to 4658298880 blocks=0A=
[  227.634613] EXT4-fs (dm-5): resized filesystem to 4831837696=0A=
=0A=
Signed-off-by: Jerry Lee <jerrylee@qnap.com>=0A=
---=0A=
 fs/ext4/resize.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c=0A=
index 56c9ef0687fc..5ab7d1c38fad 100644=0A=
--- a/fs/ext4/resize.c=0A=
+++ b/fs/ext4/resize.c=0A=
@@ -2077,7 +2077,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk=
_t n_blocks_count)=0A=
 			goto out;=0A=
 	}=0A=
 =0A=
-	if (ext4_blocks_count(es) =3D=3D n_blocks_count)=0A=
+	if (ext4_blocks_count(es) =3D=3D n_blocks_count && n_blocks_count_retry =
=3D=3D 0)=0A=
 		goto out;=0A=
 =0A=
 	err =3D ext4_alloc_flex_bg_array(sb, n_group + 1);=0A=
-- =0A=
2.17.1=0A=
