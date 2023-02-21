Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E483C69DFCF
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Feb 2023 13:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbjBUMBl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Feb 2023 07:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjBUMBD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Feb 2023 07:01:03 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE53B29403
        for <linux-ext4@vger.kernel.org>; Tue, 21 Feb 2023 04:00:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V179PYeHxFp/6wNtTSF2mF8s0nWiLZgAAUprjz4pLuxeEryvNXBdH3/cmOJfMUoBvAvXw+mivJr4X7bQx5whmUEV16KFWshHrl8eTyrwSnQsLxyTV8cJtT8Pf9f5vh78WtEfLXeefRu4sVdiCKIaT3u2VbErZXcsK8lntwyey8TtiSd/I0HL5By7HtmwN0K1gALq2MlqftFKlJ8lIk4FixTueyz1z8il9tTbmMcNRq21lk8KIWuzU3CyMS9CE7ypdgiGVPFA5LzqjPlOmkWDpqXSWT9uhUX+ukaJZYxpYLIvPMltdtZlElgmknmoJXPFX6Sm4QCA7ct4SMsldF56bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8L8wDhVMfTA7uh7DvwJSW9UR2Vs26otduoDeUqFFus=;
 b=T9ag6zm+FJ7XHE0AzoQPYHBj1D74DSlVmVyo/rLp+AI0zJ/pozTe9SvEtjTOn//Vxxy9dYpxvlTqou360X1jqmyK59DWQ2vRcqIFxVQ3IvX4lXmaedemO7j2+p49TZXUYN+db3Wyo69BHODR8nRHRj5EXR3SGPYlW4cJ5YVFdlXwuAWDGv1Nt7lQgukK+zys42EZezRkmHQfXLdzYkyW2CAOpMAS6Ssq4x0cw/xa6zi5l4R2Qq+DKht+o3lmf1YWivTAlbx2SQP4+OkaSP38hh9J1P+l/ZxBGKW0qlWPPkIxX3lUeVy9eLH52fDbkfEWdo+c9ZoE7/j59kUuoRADjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8L8wDhVMfTA7uh7DvwJSW9UR2Vs26otduoDeUqFFus=;
 b=O6bQ+bssTB2oxQL4ME+CUVHuqxcub95+qi1oOCriglW4nm0g95mvUjP0hxkO8ZxfkSiD6XmNMZpJ1g9okZxv7q/9ziOqcGmLSq0o41dfsu98gzHaRQZWc67kL6paphjvWCFPSDjvgQm2CvsegdLwcn7XEI4UzmmK64uSGZvziy8=
Received: from AM0PR08MB3857.eurprd08.prod.outlook.com (2603:10a6:208:104::15)
 by AS8PR08MB6280.eurprd08.prod.outlook.com (2603:10a6:20b:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 11:57:37 +0000
Received: from AM0PR08MB3857.eurprd08.prod.outlook.com
 ([fe80::fb08:2d74:ddf8:f021]) by AM0PR08MB3857.eurprd08.prod.outlook.com
 ([fe80::fb08:2d74:ddf8:f021%7]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 11:57:36 +0000
From:   Etienne Schmidt OSS <Etienne.Schmidt-oss@weidmueller.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Bug: Buffer I/O error with an ext4 filesystem inside a file
Thread-Topic: Bug: Buffer I/O error with an ext4 filesystem inside a file
Thread-Index: AdlF64qBQYm0utMdTLiyiFI2WE3/fg==
Date:   Tue, 21 Feb 2023 11:57:36 +0000
Message-ID: <AM0PR08MB38573D4128D2EB770D79604AFAA59@AM0PR08MB3857.eurprd08.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR08MB3857:EE_|AS8PR08MB6280:EE_
x-ms-office365-filtering-correlation-id: a3133876-7c5f-4214-5a01-08db1402d32f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3c3e4oc6Bwmu1dav+azCT8bkdlacClTX0iexoeo5IIqxE9qG0a10is0bEFkl//URgLs5azqUlYr7UYmTCVME/gzVZd2y/jFXPAuyBKurt0YXVbG05S3bXAiUd2oTOwQ06ZzO0+rXPAB5K5SzgG0wozOXUUKmW//t4W0Vnvicj8BXaMUAM3hXcG+qh0J/QpSYiexqxutrBizCTR6C7QlGA47ddhpgeyw1OIPRIPWY2cUTaUIu9Soa0zJD+Bui396cQgBNRIv9jSQcpRvXb6HBN9azFxutJXEGHgLvj7JPrOPlkknRJtsEKkyvux12PtQ7WwYE5Gr9laM6QW8wK73396Ypa6DIVkaKDwJ7B+Vqbha14JxnuwinTaDHvTm4waCnr+dN47hcVIXwuERzEh5/IX6RQW2r58Fcjtjc8FZMdFFTXmMvQikMDMYPO68wdmFRJ4RoDWPDEglg0tCY3nMoIv8raK9Jzo8gdoRIBpd/1Qb+x8FnAZSJDfj0Bi8MYD6ADK3anglA0/5Pn7O3k3NYGRrpXC/KXQXsYXks0oVJlA4jThA3RutJsVN8cl5r/heN1B038w1uPRSly1j+delqA/CD8JbilHRak+pDTV9l4jX5xSBawD3v5qxJr0jsral6A8HVUpLhLcON8WYN5lB1WEonBzKc790E0+HvvOSDFVchFNFmb9SiK0ciXm6rDWaUYx3v82aEecV0QttyWZHFyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3857.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199018)(33656002)(38100700002)(86362001)(38070700005)(41300700001)(52536014)(5660300002)(2906002)(8936002)(122000001)(83380400001)(478600001)(66946007)(66446008)(66476007)(6916009)(8676002)(66556008)(76116006)(7696005)(64756008)(71200400001)(186003)(9686003)(26005)(316002)(55016003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/ZbAlAbZb8FiVyAzzsrIP7t6z+zJhGvIoqhiD8NbF+Evh1Mn3nfcdey1EnDw?=
 =?us-ascii?Q?fVfl559/bPhhj5NfXc0C8IDkCLjQJLgd2n0gxMMtUU4GUnA9Kq8riCU34n0D?=
 =?us-ascii?Q?wRriDrZcu4qakmXsZsdDij6polBoq6VkTrqSHHn1WMIawmQyCfK/GqJCmiUZ?=
 =?us-ascii?Q?+HuZ+aSZJ52aa0G5tklULr5h0ho3w/DjlM+50fCp/Ab93Gj5AhWnoxww1WKK?=
 =?us-ascii?Q?XEaFIqIseZ20lXnmtMnsmKCKvyqJC5kArC+mgL6GlZea08eEAjumFWYyDqOw?=
 =?us-ascii?Q?m+Ye4ZdasJk0BJm+EaLuAI0TUaBSvcrH0JzPiR560ZV/M4Am5Iv88Libj9CJ?=
 =?us-ascii?Q?DmGz+g7E3O/7CtoKk7H9iXRacZ/qgYbhmrKUlcZlSTf7OjXpZd6k5MF+AErb?=
 =?us-ascii?Q?TEx/7a6s3r4OnkwGqk4roZ9FZmyVMzi3l6inoX9uuZXpyclM1Knl/f4pjvvQ?=
 =?us-ascii?Q?UnBtQbokvfD9DE6Af5LrxhB3Leqhfglkz4AX/SxUnXqd594i+2138d61bxtt?=
 =?us-ascii?Q?vqy/kwixqegfTpir547icNir/H8XctDZs+i8e6fVnbFUD+VGIcfCj/E7Kipi?=
 =?us-ascii?Q?B/0shT8UlDOKHqoST/xXwcpouDJHND7nILdBRt3mh2pgIT1ceeVu00TMRqyR?=
 =?us-ascii?Q?d50W8QaJh4aAvKkqc9+QFQ5J3veYf7AeCvfksnK+NdD4iQKBx1aoj4yPLEwc?=
 =?us-ascii?Q?GbWXYkPMTwncddGSVqBqifUf+xwObMtAlHLTct3leeQlRc/cCi6BWlfRzGX9?=
 =?us-ascii?Q?V31KuuoNVWftu+LpdkA85e/L5lJt8K64Oj/wsxwok3STikYP7YOS9SSmT1wp?=
 =?us-ascii?Q?hbVN/sXkDFN7ZMlFpgDNyc1v0gipVrEfLA7ETvBWYVL21Lt4ANUe1NZ6o3na?=
 =?us-ascii?Q?MwyuSORaOzyU842A4V3tQpXu3fpknCehhcwlVMO6rXeMTDNQeR+1v/MeA9qh?=
 =?us-ascii?Q?kaOTwXyVhEKUIM7UF3vqKNRen9PH0OBhTiLSjDqIG6BcHSDnMDyczWduRp2R?=
 =?us-ascii?Q?rYS7p/IxY5RN+skyiVoHyv30N9wFhr3sAbCSbsgqOc5QH0CmWWJ8/mTq7u4/?=
 =?us-ascii?Q?j7t6vqfo1DkuD23hRu51VOSzBl3A2KWwohIbNrmhZJ3J7ROabrB9oU6/hpSO?=
 =?us-ascii?Q?hAGCC/oxS39xIwY2TrtmFY12D3csYNpR0OcLBhd4r66H2SGC81dqSWvI/p1Z?=
 =?us-ascii?Q?FflSd6HS7ItrDQnV14BA5bFhWQmDAkqqpjj+G7SyL/IA9sMtomkrTlTGrt8C?=
 =?us-ascii?Q?NTyfjJgeqLHGj9ZHRRkz/bi40Cdiq1iS28MzVfW38Mump30PSk1J+rdKk9oW?=
 =?us-ascii?Q?/oSgoNvCycft+4HvRy5VsDJd5s3iiqG8k15Hkf/8AY5whExxy5pcJnFe0Ade?=
 =?us-ascii?Q?5hMHSb42rICEL+fPloqAUa1/1PeSLqpLyOOupw5fS7aB7/B12S0rN3TBZP7s?=
 =?us-ascii?Q?xtFTBc6fh+FESG+5jRXHXm+5wgx8xFTEXndtoecomO0pnOSSPU287OXPLqaD?=
 =?us-ascii?Q?YMFNVHCcRlvxRLz63MlB3x3zvLPqbawmX04v7niVDNd6tzEV8BngepE7HPBT?=
 =?us-ascii?Q?+OpiC1AbTUOPh8msbnSpJ6SwjsbOOrefR6xWrbMjl8r5QtoNhY11bSjrByj5?=
 =?us-ascii?Q?SP0sL4JFG6WRfAZ1RrLHxoo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3857.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3133876-7c5f-4214-5a01-08db1402d32f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 11:57:36.8330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NyqPZsEdAwnB17hRsaCxdA1P1eh5Bqmqf94zzcFPIyVdThIoABZ4lLQCrLpL8q9XlU1vyaxNVLIbZtDP4XBEDPPepXyyME1ByuyjqelaWbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6280
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


Is this a bug or is my usage wrong?

Best regards

Etienne Schmidt

