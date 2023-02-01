Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72718686474
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Feb 2023 11:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjBAKib (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Feb 2023 05:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjBAKiE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Feb 2023 05:38:04 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2950262793
        for <linux-ext4@vger.kernel.org>; Wed,  1 Feb 2023 02:37:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tdp5ZSRhgeyHxcm1cU4A3skMrIoE/vYLdhEkvY+s1hEjosdh5v+gws/ye3u+hqLYPjYWuRRzF0M7wTLx2pdt8druo0/Nx4kLD/6qGPoGCxvaPD9mj67JTBX5wlW/SNCmcNpFeL78o1pQYz1psD0RQVsLNUVHcSEuJ78/tyqhamDE+GQ3w/1vFfuCi3GVnPHEwVC8MuwSM3l9p73pFsdFTqZB94p2GflPzRf015+yRmp/zKjfNMIVEQWQOZSt5G1dSdvAbhQzm2KSl9UoZgKZhtvzBArZO+nQQX49FmjYcv1XOBjSUqVDrS7wn8M7NUVjusur4/0uFYSKIl7ZlueF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2VzwxPOkmZ7TXnpMY6XYXvsU+YudrrrI7+fy7Zq0vM=;
 b=DI8O8LkgCSpMgyhAd43U6c0WWuB/nOIZd0PX6OAFIywxCTay9hKF7nfNY/SbJDJMvwyXc4q7IMyaM3H4PcYez3dKABswqYeMmmNMkkDH85cuCj/uzVx/tcfqVkc1IHIwT/FOv1SrtChwNWJtPntyJLiT5PcPzEg3srSF7PON/VQA2ag5Qg/8KRCV/P71JQPqAffNV31Xkt1GxXBmaOQaAHA9ahT2S1thsIKq3lWW1+7YdX7ZQO9TwCANOmBFb6bQgKYkGtprFvK5ZKhPtkFdHgyMPXQMw8TqvKGQirx9y1avlwuMkNgyAgPqPvycScmln2Fsl817bTMcZMQwTUUrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2VzwxPOkmZ7TXnpMY6XYXvsU+YudrrrI7+fy7Zq0vM=;
 b=roJWnQi5yo9YLKzN4MhUHG/iEmrozg4RcGxPHg7xIqihLkMAv1F7ZjqfuLGu7r6YDZl5SDbEC2uDqHcoL/VD2waB5zBD2nFQ+ocHiU75Tx3gaQm4Fuvz+Xr8LcMbNmAoYWfQYuNhLSBkXNmspNQ9R64Lyt8GWNgRjkmdbx1hlJc=
Received: from AM0PR08MB3857.eurprd08.prod.outlook.com (2603:10a6:208:104::15)
 by DB9PR08MB6649.eurprd08.prod.outlook.com (2603:10a6:10:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 10:37:48 +0000
Received: from AM0PR08MB3857.eurprd08.prod.outlook.com
 ([fe80::ba71:58d3:88ae:f911]) by AM0PR08MB3857.eurprd08.prod.outlook.com
 ([fe80::ba71:58d3:88ae:f911%7]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 10:37:48 +0000
From:   Etienne Schmidt OSS <Etienne.Schmidt-oss@weidmueller.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Bug: Buffer I/O error with an ext4 filesystem inside a file
Thread-Topic: Bug: Buffer I/O error with an ext4 filesystem inside a file
Thread-Index: Adk2KRXxIDTSYXxwQfyMkstz55FuRQ==
Date:   Wed, 1 Feb 2023 10:37:47 +0000
Message-ID: <AM0PR08MB3857738B22DB09CAEA25E431FAD19@AM0PR08MB3857.eurprd08.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR08MB3857:EE_|DB9PR08MB6649:EE_
x-ms-office365-filtering-correlation-id: 80634b50-29e9-44f4-9a2b-08db04405c83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xs3TG4eR3Ir3if24q3itTAiloEFR2WNUlAox8V4V52Z96WK5ltwIIXhuSOzQZQjF7s6+c2o4/lBUI0lxx3asnaei5ncUGxuvxLeqtGcPdQl3iW83mkxogToI2Ti1vXVNCU51ycrAoSgGCk5ctKzDjyDupmJa3egOXOGu1prMR/tYZOjeu4l245S9vCqJsBPOY+I597597fBDDgBU8y6OWtsgR7sDGh6zzkVxgp8DOWLhT40/9ZFIwnuofHyYX5JETLEWmeBaNe/0yKoMtGEYl/U+R/p1THR1OJeSYZh79rObvtm0QK+Yr9RKcqA1Wpvpt5a6cdOOX+PD+SEjocuHYkHmihRU/sx2WSIXzTkWS4rTnyAUGLIWsWWOMoDQPgfk1m6Hzxp6Ato+hTPDuplDTcBs1sbnRaOU3QPUZNZf5ArRG03wy4nLyO/JTwq6nvf5gmzlnGS30UpfFPrUiaXhFRGJDzNbzn2gJL6zW7XLkR5DJMIS7T/3nSuXLBcfe6/BkWABs7b0zexMFhNcPcxRuhifeFoCzSqtkovwylMCM4TyQXJ7VeS5Aj+JyArsNHn6u5TVNHwkBBmDZkE9R2lLvuCFS+Y6wtiqUKjjvWxKJiqtrgp3R5mBVpmFH0292ZGD4sGYnwi7wlC8Dy3+uqIRZCklzYdJODtMPZHHTW9Ipp5faRm0IYg+amZr7Qg2wyjqPwNz6OedRHc5MKHJOciJqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199018)(478600001)(9686003)(6916009)(38070700005)(186003)(8676002)(26005)(66556008)(66446008)(66476007)(66946007)(64756008)(76116006)(122000001)(7696005)(2906002)(41300700001)(8936002)(86362001)(55016003)(6506007)(5660300002)(71200400001)(33656002)(83380400001)(316002)(52536014)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U/td4gK7VltF01F9GFs5GgfmLYorzpRe62xupPDAs6kqwTSXMVB5a6XFqck2?=
 =?us-ascii?Q?y3ZFhXq/R4rsh6zz8M3MNdSW/GMt1IbU9LE/J2iOz+eJG3vSN883jP8m6xF1?=
 =?us-ascii?Q?5D7egB1U0sqes7GfMCfoAP2Hu15/9BkYTrCDgtf5LrUMdRXrM/SE6GBZ2XOE?=
 =?us-ascii?Q?8J37hgM4dfKLKLblAWse5tqLgFzTP1TsgCHQeNJNH+MVl2Ju9s1VBRnYOpm6?=
 =?us-ascii?Q?+iZathRrJufkTUdDAvB1dApAkQGRfEGqMkZpcl5IvQe2v6+6W3J63Ja4Xz/P?=
 =?us-ascii?Q?N8NbFIO7XrdXm/gq8ZA3Qf0IgB3PQ3dh4C/E6mKDRBjZjN+LK9nhDjqDxecp?=
 =?us-ascii?Q?tfM2PBsZnm7g4HbQ/qHPGc5tSDMP8UyFvsMKqYsgV0zQR2g7tMcAsbYzoDDw?=
 =?us-ascii?Q?WVBsRAcFB+6+bZbTNDzlffPALwk8dByNOMinTbMra5KiryLB/QcH8BHlEcHD?=
 =?us-ascii?Q?Wj85SQ1wr7Y4D9i+90U37+abqTSAEbtTrY5XuGNEAPTyG4u0XtTznbEBERwQ?=
 =?us-ascii?Q?xiHgh/syrmDblEZyZMBRDXn2XJc4iVICJSDU3iH563vurTPz2IY3G0m5V7I+?=
 =?us-ascii?Q?AzklCSrrFgZnYB198MB4Fih2tHPTwCqckLAXxSp3hGl9JpPxWrSTp5omGUFO?=
 =?us-ascii?Q?/U4F/LqOaxxw8ODvdn79ufY+jciYgmCSkCiAAIifoq6lbg7FDA47lmG9K4J1?=
 =?us-ascii?Q?V32Wc9T5jnwrrREmjaM4l1Lv/mQ3o4ByjiCCwFLs6BW2y2lbXWWzZ8lrxSrb?=
 =?us-ascii?Q?JWpYssHM6mPpXG5rxgNozE3k9aUcxsKvZcnR5kUlUdlVeJkKUGudtzTg3ncc?=
 =?us-ascii?Q?7OygAoP+4mvKJuSq4Vc32gGW2GOK6WKsRHkafZCDaoKII0J8DAdSXJdIk9vx?=
 =?us-ascii?Q?iJe32ip99n3y9VOv+DehdxD14lwF4x4k3TxHrwe36W56tWk4Mh0EO6WPUQ2k?=
 =?us-ascii?Q?SfoOx9Xvgowt+jQqfxO6JLykwuAni3F4ZbXujoBhsvmagYD80jWoOg0z1L33?=
 =?us-ascii?Q?SbZYLy4CYA481sMWFutbPVdqNDs61jGZcxtL4qycTM2oXh3jurXoClpZtEKm?=
 =?us-ascii?Q?Heji74ku5yed0XJcMq9TDQthVHnJV6XvrBJX9kDWItsbJvfrzZ/WNRsIsWao?=
 =?us-ascii?Q?MT/ilo2Wvl0CdMImODZ5XxolCG+2595GjKBWC/Rt3LxjEXA+YfngKWFzR1m2?=
 =?us-ascii?Q?Wvq+U7LaF/NmoBoZEZbDN04kyrT/iwKmKcBYX2HDBAa+aFTddeHCTw05lYK+?=
 =?us-ascii?Q?xmvG3MrqjA2bvUT8lVFMDtyB33e7cBreL/pGPiBNhkht5YW+9jNpmPtbzKqc?=
 =?us-ascii?Q?Bs/WDTq4W/Q44PuKgQzFZN1B75yzsbBGZWDVIdnhnGDkv7qqVK4WHulSXWsX?=
 =?us-ascii?Q?vkwT1s7fyaAAP8OgLQmf12LVyCTLdsQ1xDct7feDf4OXB9FbN8otkAowc7Ne?=
 =?us-ascii?Q?1NQHN9HW8gnj3IQ3bUQJnS+zpMo+dnN7PRyI4Cs9bOPk9j4iu1lhxoJ/rscv?=
 =?us-ascii?Q?s41FHq/yZL2L9RESXevI8a/iv2ZpQzTT0QsHE8WWL9nzi+NOvfE7JhVtCfaO?=
 =?us-ascii?Q?qiZjPepP7HHrBRv9Bl0fT5to7TXjITJXd597Zvv7J31+/yKkuem2sYgkIISw?=
 =?us-ascii?Q?wJGw2vvQQUGrOtXASd0El6c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80634b50-29e9-44f4-9a2b-08db04405c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 10:37:47.9447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUlvU3QVvIjvT63L5bBD+vdfdkqLNujIrN0q3IPRsM5j9bzNjA6ArZdTkBpet4hXOTWBE7Ifqx4wYd3menPZNb4zGs8fKFgXE9Cfrd3MHC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6649
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello everyone!

I have tried to allocate disk space for a service. To do this I created a f=
ile with fixed disk usage and created an ext4 file system in it. When I mou=
nt this file the mount point should be reserved space but something went wr=
ong. With full memory I get a buffer I/O error.

Observation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I created an ext4 filesystem inside a file (ext4 partition below) and mount=
ed it (e.g. in /var/persistent/reserved). Then I fill up the underlying fil=
e system. There is enough space inside the file but when I write a file to =
it the journal gives a "buffer I/O error". =20

Steps to Reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The following steps reproduce these bug. I execute them as root user.

Preparation:
1.	Create a file with fix disk usage:
	`fallocate -l 32M /var/reserved.ext4`
2.	Create a ext4 filesystem inside it:
	`mkfs.ext4 /var/reserved.ext4`
3.	Create the mountpoint:
	`mkdir /var/reserved/`
4.	Mount the file:
	`mount /var/reserved.ext4 /var/reserved/`
5.	(Optional) Check the filesystem with fsck.

Now the reserved storage works fine!

The Bug:
1.	Fill up the underlying filesystem:
	`fallocate -l 100G /var/very_big_file`
2.	Write into the reserved storage:
	`echo "Test" > /var/reserved/test_file_1`
	or anything else.
3.	The file is written but the journal shows the following error:

	```
	May 03 08:31:42 ucm kernel: loop: Write error at byte offset 8913920, leng=
th 1024.
	May 03 08:31:42 ucm kernel: blk_update_request: I/O error, dev loop0, sect=
or 17410 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
	May 03 08:31:42 ucm kernel: EXT4-fs warning (device loop0): ext4_end_bio:3=
44: I/O error 10 writing to inode 12 starting block 8706)
	May 03 08:31:42 ucm kernel: Buffer I/O error on device loop0, logical bloc=
k 8705
	May 03 08:31:42 ucm kernel: JBD2: Detected IO errors while flushing file d=
ata on loop0-8
	```

Quick fix
=3D=3D=3D=3D=3D=3D=3D

Allocate a larger space to the file AFTER creating the ext4 file system.
E.g after step 2. within the reserved space preparation: `fallocate -l 33M =
/var/reserved.ext4`


Is this a bug or is my use wrong?

Best regards

Etienne Schmidt

