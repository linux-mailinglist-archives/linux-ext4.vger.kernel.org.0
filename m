Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B89327624A
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Sep 2020 22:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIWUlK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Sep 2020 16:41:10 -0400
Received: from mail-dm6nam12on2100.outbound.protection.outlook.com ([40.107.243.100]:9697
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbgIWUlJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Sep 2020 16:41:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8v3nDM9krN2YJV+dPE4WnRAeWeVOViY595AQ5kOfS7dEpWy87N29S60Bdi/Mn/QsUxb/CY65PR5xbPqE07MnaWyCLKX5Rew1nCAm3gH+AE3bmdKsxe/ixHXZ0j1Y+XrgMWdY3RCqfm8Vuv4cxljqi3YyTtur9Y4lT6YDrqf5wTSBZI7t9zpj9azz3G59fLq9j2ZxqcxCBtPdqC+B33lgUlcBGj4NvCLF62XshCz3F4qrXfZImjzFdHaDAf3tt4dlGX1PmV4ec5cwRi75/kHZpJ7aGkmmUIgU1akRmOVVAfGuOqPsJvXIyFMhzGUSElg3Yp2pC5gZEc2sJNnQaXkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLODnnuUBWrzEO2gRGRJyXVuftlRMKpuRIInbNwsVbU=;
 b=kr+zk4eY2BggZYcLYmOT6cF/bVQ+syPXruvF6nuBAyjcWeXhBAPqwEtqn10AdVeQdIES5GdLIYOouXoEp+HHVB6nS17ScdDAq9IMmHsuXYCht0t/WXzepY06UjGX38s4fXXBK+xlR7i3EDIY8z0PrQq07OtoTR4p7WiOYWfadYBfX/avWofqxDcvnTDMHkNvis7q57Lsc4PQ9fjvouzXlIkYYcxPZAy3YKsCdCKiwof9pdAxy+o3wReHZLPB74AdsrVwSaGlAxx++XHrwhiLsz0Msm3vlONov4wNHJHgO5aXU3ysw9WLecdtj5kMHtm/wnokuXv7Rbdv4Zfx8BjTgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hcdatainc.com; dmarc=pass action=none
 header.from=hcdatainc.com; dkim=pass header.d=hcdatainc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG220063.onmicrosoft.com; s=selector2-NETORG220063-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLODnnuUBWrzEO2gRGRJyXVuftlRMKpuRIInbNwsVbU=;
 b=WCgrU0KbiQc5UDn17Ru/wrAEGLAiXFwgYFnV1yUT0hkdtrkSH/9C5tduFQ/o0/nLYahcvRRsW7oO1eB9sWGILkWNYOEjBFdcSfygvpdAthYbzD5FiXFvyfsYvCE7j6T2sCXuJiBSAUOkPpUZt3NYI8TG5l58xbmZAYsZLAepPIw=
Received: from BYAPR10MB2456.namprd10.prod.outlook.com (2603:10b6:a02:b3::16)
 by BY5PR10MB4068.namprd10.prod.outlook.com (2603:10b6:a03:1b2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 23 Sep
 2020 20:40:59 +0000
Received: from BYAPR10MB2456.namprd10.prod.outlook.com
 ([fe80::c430:480c:3ceb:566c]) by BYAPR10MB2456.namprd10.prod.outlook.com
 ([fe80::c430:480c:3ceb:566c%6]) with mapi id 15.20.3391.024; Wed, 23 Sep 2020
 20:40:59 +0000
From:   Meng Wang <meng@hcdatainc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: RE: kernel panics when hot removing U.2 nvme disk
Thread-Topic: kernel panics when hot removing U.2 nvme disk
Thread-Index: AQHWjhX83+5IHgri4062+f1Cfnen/qlvMIaAgAeCnjA=
Date:   Wed, 23 Sep 2020 20:40:59 +0000
Message-ID: <BYAPR10MB2456FEEB2DA329E2A75908FFCB380@BYAPR10MB2456.namprd10.prod.outlook.com>
References: <BYAPR10MB24561C62C45813B7092E346BCB3F0@BYAPR10MB2456.namprd10.prod.outlook.com>
 <20200919014401.GE4030837@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200919014401.GE4030837@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=hcdatainc.com;
x-originating-ip: [45.28.143.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9529c6e-72c9-49a3-e6ec-08d86000faed
x-ms-traffictypediagnostic: BY5PR10MB4068:
x-microsoft-antispam-prvs: <BY5PR10MB40682B496A673BCC9F3DDFDBCB380@BY5PR10MB4068.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6877SojOxnW9LuVylVazCzyMtc64wCAJkpJ4VEdTCOlNtAPC9czklDW0OPZC1QqEwFtzynCrUtCzWDCJGtCaWF9wEQyMHUHaIf6/dryGwTszKmn3q/KYws5DC3MS0xaYBAh9B8R0yZfh7SgoWhuB3/SMTmUU7YTsZ15Q2Rhj6qYU1Liuh1unVeSz3NBwMN6/EwWDicns/klNE5s10WBMgCTtVVjSMoGxCPPak8lgcMrAsOPW/Pr51Lbq1LSLJ89FsGlhXd76vU2ezIPSJ/vhiDrTn6cdA4WlncrdUZRAW3PEV4Ss8FHLtgmeDmJXMePFuTzb2NT0mGibrjwHBmypeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2456.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(376002)(396003)(136003)(366004)(7696005)(45080400002)(6916009)(2906002)(478600001)(54906003)(55016002)(9686003)(8676002)(26005)(53546011)(8936002)(316002)(33656002)(66946007)(5660300002)(6506007)(52536014)(86362001)(71200400001)(66556008)(66476007)(64756008)(30864003)(76116006)(186003)(66446008)(4326008)(83380400001)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YidHDVtkYDfkCR0Q5dDA5eNnocDrJGtJivJWHZNmzbys8k9sHwHzhtaB3mJbwW3q+s6nHdHg+8BbK/hmO5LsAQF8INxVqaRiBcoIV44K6biTVmnZklI7gzb4xqh16e/FfH/W0dWELMN/JikyA7I8MZKUmscj5xpcUKKzTckmCkxzbRTDUTS+OxS9BaPLqTbzga5d8MCgT9PZFBTU2xgmYqKEd1Nb0o2jhCwzDtmocgcw/pwMfk4U7eOoJAXbJTko+q0uo43dlMdQPsT80m6o5z7U/nEuvgVwPIrlDSKzdHLnVHJChNsrF4P5UkhxX7LljSsxQ1eth5TmB3NZipe4EGv4HepxuKawS7UNi9ltX7BY+XqNyrY1m7Vj1ElGsGiF8opp9r0CRnnKw1bjNaMRWPEAKGF8XGqgS9YHEal1/rAcmPee3ywrhPiuuCSCEGhQsQ5BEpSjLANSV8HPcm0kOBOknmW3l9O2pqI4HKh9FXXrXUZpHFHHDw+vwA29UurpNk0LzS0itfPN5Y/DTEQKbpsHxK4xoxyoFjnIyPpzv2QgrxsrOKL/Kb02YJMK9IRuk6WtPBC1z8Nt25qjzxY5/dAHkbHHwHYLjvfOrTmAbvo+BV8Lkq8MZk3YJR3THj+A81gm1G1nV7sawiZnZzN/LQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hcdatainc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2456.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9529c6e-72c9-49a3-e6ec-08d86000faed
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 20:40:59.7667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8368637-8933-4f2c-a6d2-c0d726d49c7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Q73PGKBTonDvwi+IeGyCLfWTDGmGjyUprg0sBwnw4ln7KYvIt1JnYKxXetfNh7LgLncwXtaOEb2dvVEYVFnvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4068
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: Friday, September 18, 2020 6:44 PM
> To: Meng Wang <meng@hcdatainc.com>
> Cc: linux-nvme@lists.infradead.org; linux-ext4@vger.kernel.org
> Subject: Re: kernel panics when hot removing U.2 nvme disk
>=20
> On Fri, Sep 18, 2020 at 11:47:27PM +0000, Meng Wang wrote:
> > Hi,
> > We found kernel panics today when doing test on hot remove U.2 nvme
> > disk. After hot remove the nvme disk (formatted as ext4), the system
> > freezes and all services stuck. Lot of kernel message flushed the
> > syslog, including the CPU soft lockup, ext4 NULL point er dereferece
> > and ib nic transmission timeout. The kernel panics and configuration
> > are shown below. The used kernel is 5.4.0-050400-generic and OS is
> > Ubuntu 16.04. Not sure whether it's a known bug or configuration
> > error. Any advise are welcome.
>=20
> [cc'ing ext4 mailing list]
>=20
> The NULL dereference occured before the soft lockup, so I'm guessing the
> Oops'ed process is holding the same lock the removal task wants.
>=20
> Your kernel is a bit older, so it may be worth verifying if your observat=
ion still
> occurs on the current stable or current mainline, but the ext4 developers
> may have a better idea as this doesn't at least initially appear specific=
 to nvme.
>=20

Hi,
I firstly reported this issue on linux-nvme mailing list and redirected to =
here. The issue is kernel oops on NULL pointer dereference after disk remov=
al (Oops shown below). We firstly tested on kernel v5.4 and reproduced the =
same issue on the latest stable kernel v5.8.10. Due to this kernel dump, io=
 from applications hang and cannot return with EIO. Is this a ext4 bug or c=
ompatibility issue with nvme disk? Thanks.

--------------------------------------------------------------------------
kernel v5.8.10 Oops on ext4 NULL pointer dereference
--------------------------------------------------------------------------
Sep 23 19:05:33 hcd56 kernel: [ 8050.166243] pcieport 0000:00:03.0: pciehp:=
 Slot(7): Link Down
Sep 23 19:05:33 hcd56 kernel: [ 8050.166246] pcieport 0000:00:03.0: pciehp:=
 Slot(7): Card not present
Sep 23 19:05:34 hcd56 kernel: [ 8050.249728] print_req_error: 312 callbacks=
 suppressed
Sep 23 19:05:34 hcd56 kernel: [ 8050.249731] blk_update_request: I/O error,=
 dev nvme2n2, sector 706037912 op 0x0:(READ) flags 0x80700 phys_seg 4 prio =
class 0
Sep 23 19:05:34 hcd56 kernel: [ 8050.458068] VFS: busy inodes on changed me=
dia or resized disk nvme2n2
Sep 23 19:05:34 hcd56 kernel: [ 8050.467262] EXT4-fs error (device nvme2n2)=
: ext4_wait_block_bitmap:519: comm w6_8_-1: Cannot read block bitmap - bloc=
k_group =3D 87, block_bitmap =3D 2621447
Sep 23 19:05:34 hcd56 kernel: [ 8050.467320] EXT4-fs error (device nvme2n2)=
: ext4_wait_block_bitmap:519: comm w6_10_-1: Cannot read block bitmap - blo=
ck_group =3D 81, block_bitmap =3D 2621441
Sep 23 19:05:34 hcd56 kernel: [ 8050.467398] EXT4-fs error (device nvme2n2)=
: ext4_wait_block_bitmap:519: comm w6_26_-1: Cannot read block bitmap - blo=
ck_group =3D 90, block_bitmap =3D 2621450
Sep 23 19:05:34 hcd56 kernel: [ 8050.467416] EXT4-fs error (device nvme2n2)=
: ext4_wait_block_bitmap:519: comm w6_42_-1: Cannot read block bitmap - blo=
ck_group =3D 79, block_bitmap =3D 2097167
Sep 23 19:05:34 hcd56 kernel: [ 8050.467418] Buffer I/O error on dev nvme2n=
2, logical block 0, lost sync page write
Sep 23 19:05:34 hcd56 kernel: [ 8050.467421] EXT4-fs (nvme2n2): I/O error w=
hile writing superblock
Sep 23 19:05:34 hcd56 kernel: [ 8050.467423] EXT4-fs error (device nvme2n2)=
 in ext4_free_blocks:5217: IO failure
Sep 23 19:05:34 hcd56 kernel: [ 8050.467424] Buffer I/O error on dev nvme2n=
2, logical block 0, lost sync page write
Sep 23 19:05:34 hcd56 kernel: [ 8050.467426] EXT4-fs (nvme2n2): I/O error w=
hile writing superblock
Sep 23 19:05:34 hcd56 kernel: [ 8050.467427] EXT4-fs (nvme2n2): previous I/=
O error to superblock detected
Sep 23 19:05:34 hcd56 kernel: [ 8050.467428] EXT4-fs error (device nvme2n2)=
 in ext4_free_blocks:5217: IO failure
Sep 23 19:05:34 hcd56 kernel: [ 8050.467429] Buffer I/O error on dev nvme2n=
2, logical block 0, lost sync page write
Sep 23 19:05:34 hcd56 kernel: [ 8050.467430] EXT4-fs (nvme2n2): I/O error w=
hile writing superblock
Sep 23 19:05:34 hcd56 kernel: [ 8050.467433] EXT4-fs error (device nvme2n2)=
: ext4_check_bdev_write_error:215: comm w6_26_-1: Error while async write b=
ack metadata
Sep 23 19:05:34 hcd56 kernel: [ 8050.467434] Buffer I/O error on dev nvme2n=
2, logical block 0, lost sync page write
Sep 23 19:05:34 hcd56 kernel: [ 8050.467435] EXT4-fs (nvme2n2): I/O error w=
hile writing superblock
Sep 23 19:05:34 hcd56 kernel: [ 8050.467438] EXT4-fs error (device nvme2n2)=
: ext4_check_bdev_write_error:215: comm w6_42_-1: Error while async write b=
ack metadata
Sep 23 19:05:34 hcd56 kernel: [ 8050.467441] Buffer I/O error on dev nvme2n=
2, logical block 0, lost sync page write
Sep 23 19:05:34 hcd56 kernel: [ 8050.467444] EXT4-fs (nvme2n2): I/O error w=
hile writing superblock
Sep 23 19:05:34 hcd56 kernel: [ 8050.467447] EXT4-fs error (device nvme2n2)=
: ext4_check_bdev_write_error:215: comm w6_26_-1: Error while async write b=
ack metadata
Sep 23 19:05:34 hcd56 kernel: [ 8050.467449] Buffer I/O error on dev nvme2n=
2, logical block 0, lost sync page write
Sep 23 19:05:34 hcd56 kernel: [ 8050.467450] EXT4-fs (nvme2n2): previous I/=
O error to superblock detected
Sep 23 19:05:34 hcd56 kernel: [ 8050.467455] Buffer I/O error on dev nvme2n=
2, logical block 0, lost sync page write
Sep 23 19:05:34 hcd56 kernel: [ 8050.467456] EXT4-fs (nvme2n2): I/O error w=
hile writing superblock
Sep 23 19:05:34 hcd56 kernel: [ 8050.467456] EXT4-fs (nvme2n2): I/O error w=
hile writing superblock
Sep 23 19:05:34 hcd56 kernel: [ 8050.467458] EXT4-fs error (device nvme2n2)=
: ext4_check_bdev_write_error:215: comm w6_26_-1: Error while async write b=
ack metadata
Sep 23 19:05:34 hcd56 kernel: [ 8050.467461] Buffer I/O error on dev nvme2n=
2, logical block 0, lost sync page write
Sep 23 19:05:34 hcd56 kernel: [ 8050.467462] EXT4-fs (nvme2n2): I/O error w=
hile writing superblock
Sep 23 19:05:34 hcd56 kernel: [ 8050.467468] Buffer I/O error on dev nvme2n=
2, logical block 0, lost sync page write
Sep 23 19:05:34 hcd56 kernel: [ 8050.467473] Buffer I/O error on dev nvme2n=
2, logical block 0, lost sync page write
Sep 23 19:05:34 hcd56 kernel: [ 8050.467863] JBD2: Spotted dirty metadata b=
uffer (dev =3D nvme2n2, blocknr =3D 0). There's a risk of filesystem corrup=
tion in case of system crash.
Sep 23 19:05:35 hcd56 kernel: [ 8050.481231] BUG: kernel NULL pointer deref=
erence, address: 000000000000000c
Sep 23 19:05:35 hcd56 kernel: [ 8050.740865] #PF: supervisor write access i=
n kernel mode
Sep 23 19:05:35 hcd56 kernel: [ 8050.746080] #PF: error_code(0x0002) - not-=
present page
Sep 23 19:05:35 hcd56 kernel: [ 8050.751211] PGD 800000223fe5d067 P4D 80000=
0223fe5d067 PUD 15cdaff067 PMD 0
Sep 23 19:05:35 hcd56 kernel: [ 8050.758164] Oops: 0002 [#1] SMP PTI
Sep 23 19:05:35 hcd56 kernel: [ 8050.761647] CPU: 36 PID: 4561 Comm: w6_8_-=
1 Tainted: G        W         5.8.10-050810-generic #202009171232
Sep 23 19:05:35 hcd56 kernel: [ 8050.771370] Hardware name: Supermicro SYS-=
1028U-TN10RT+/X10DRU-i+, BIOS 3.1 06/08/2018
Sep 23 19:05:35 hcd56 kernel: [ 8050.779280] RIP: 0010:jbd2_journal_add_jou=
rnal_head+0x93/0x120
Sep 23 19:05:35 hcd56 kernel: [ 8050.785106] Code: af f3 90 48 8b 13 f7 c2 =
00 00 40 00 75 f3 eb a0 48 8b 53 10 48 85 d2 74 07 48 83 7a 18 00 75 aa 0f =
0b 48 8b 4b 40 48 8d 53 02 <83> 41 0c 01 f0 80 22 bf 48 85 c0 74 0f 48 8b 3=
d 19 a8 d2 01 48 89
Sep 23 19:05:35 hcd56 kernel: [ 8050.803844] RSP: 0018:ffffaf98e55479f8 EFL=
AGS: 00010206
Sep 23 19:05:35 hcd56 kernel: [ 8050.809060] RAX: 0000000000000000 RBX: fff=
f91744c78ed68 RCX: 0000000000000000
Sep 23 19:05:35 hcd56 kernel: [ 8050.816187] RDX: ffff91744c78ed6a RSI: fff=
f91744c78ed68 RDI: ffff91744c78ed68
Sep 23 19:05:35 hcd56 kernel: [ 8050.823310] RBP: ffffaf98e5547a00 R08: fff=
fffff9ac05ee8 R09: 0000000000000028
Sep 23 19:05:35 hcd56 kernel: [ 8050.830433] R10: ffff916b3f01c714 R11: 000=
0000000000297 R12: ffff917484cad620
Sep 23 19:05:35 hcd56 kernel: [ 8050.837558] R13: 0000000000000000 R14: fff=
f91744c78ed68 R15: ffff91744c78ed68
Sep 23 19:05:35 hcd56 kernel: [ 8050.844681] FS:  00007fd3ebbff700(0000) GS=
:ffff917f3fc00000(0000) knlGS:0000000000000000
Sep 23 19:05:35 hcd56 kernel: [ 8050.852759] CS:  0010 DS: 0000 ES: 0000 CR=
0: 0000000080050033
Sep 23 19:05:35 hcd56 kernel: [ 8050.858496] CR2: 000000000000000c CR3: 000=
0002433d88005 CR4: 00000000003606e0
Sep 23 19:05:35 hcd56 kernel: [ 8050.865621] DR0: 0000000000000000 DR1: 000=
0000000000000 DR2: 0000000000000000
Sep 23 19:05:35 hcd56 kernel: [ 8050.872745] DR3: 0000000000000000 DR6: 000=
00000fffe0ff0 DR7: 0000000000000400
Sep 23 19:05:35 hcd56 kernel: [ 8050.879868] Call Trace:
Sep 23 19:05:35 hcd56 kernel: [ 8050.882321]  jbd2_journal_get_write_access=
+0x53/0x90
Sep 23 19:05:35 hcd56 kernel: [ 8050.887283]  __ext4_journal_get_write_acce=
ss+0x4e/0x90
Sep 23 19:05:35 hcd56 kernel: [ 8050.892422]  ext4_reserve_inode_write+0x97=
/0xc0
Sep 23 19:05:35 hcd56 kernel: [ 8050.896953]  ? __ext4_ext_dirty+0x76/0x90
Sep 23 19:05:35 hcd56 kernel: [ 8050.900956]  __ext4_mark_inode_dirty+0x58/=
0x140
Sep 23 19:05:35 hcd56 kernel: [ 8050.905482]  __ext4_ext_dirty+0x76/0x90
Sep 23 19:05:35 hcd56 kernel: [ 8050.909318]  ext4_ext_rm_leaf+0x237/0x6a0
Sep 23 19:05:35 hcd56 kernel: [ 8050.913326]  ext4_ext_remove_space+0x44c/0=
x8e0
Sep 23 19:05:35 hcd56 kernel: [ 8050.917769]  ext4_ext_truncate+0xa0/0xb0
Sep 23 19:05:35 hcd56 kernel: [ 8050.921687]  ext4_truncate+0x2ed/0x450
Sep 23 19:05:35 hcd56 kernel: [ 8050.925432]  ext4_da_write_begin+0x2ae/0x4=
b0
Sep 23 19:05:35 hcd56 kernel: [ 8050.929697]  generic_perform_write+0xc2/0x=
1c0
Sep 23 19:05:35 hcd56 kernel: [ 8050.934055]  ext4_buffered_write_iter+0xa4=
/0x160
Sep 23 19:05:35 hcd56 kernel: [ 8050.938664]  ext4_file_write_iter+0x38/0x5=
0
Sep 23 19:05:35 hcd56 kernel: [ 8050.942843]  new_sync_write+0x111/0x1a0
Sep 23 19:05:35 hcd56 kernel: [ 8050.946674]  vfs_write+0x1c5/0x200
Sep 23 19:05:35 hcd56 kernel: [ 8050.950070]  ksys_write+0x67/0xe0
Sep 23 19:05:35 hcd56 kernel: [ 8050.953380]  __x64_sys_write+0x1a/0x20
Sep 23 19:05:35 hcd56 kernel: [ 8050.957128]  do_syscall_64+0x49/0xc0
Sep 23 19:05:35 hcd56 kernel: [ 8050.960704]  entry_SYSCALL_64_after_hwfram=
e+0x44/0xa9
Sep 23 19:05:35 hcd56 kernel: [ 8050.965749] RIP: 0033:0x7fd52bcc32dd
Sep 23 19:05:35 hcd56 kernel: [ 8050.969319] Code: 24 2d 00 00 75 10 b8 01 =
00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 fe dd 01 00 48 89 =
04 24 b8 01 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 47 de 01 00 48 89 d0 4=
8 83 c4 08 48 3d 01
Sep 23 19:05:35 hcd56 kernel: [ 8050.988055] RSP: 002b:00007fd3ebbf30d0 EFL=
AGS: 00000293 ORIG_RAX: 0000000000000001
Sep 23 19:05:35 hcd56 kernel: [ 8050.995613] RAX: ffffffffffffffda RBX: 000=
0000000000064 RCX: 00007fd52bcc32dd
Sep 23 19:05:35 hcd56 kernel: [ 8051.002738] RDX: 0000000000000064 RSI: 000=
07fd2c715a000 RDI: 00000000000001ad
Sep 23 19:05:35 hcd56 kernel: [ 8051.009860] RBP: 00007fd2c715a000 R08: 000=
07fd40c916d60 R09: 00007fd3ebbff700
Sep 23 19:05:35 hcd56 kernel: [ 8051.016985] R10: 7720646e756f7267 R11: 000=
0000000000293 R12: 0000000000000064
Sep 23 19:05:35 hcd56 kernel: [ 8051.024110] R13: 0000000000000001 R14: 000=
07fd40c916c80 R15: 00007fce49bd4fb0
Sep 23 19:05:35 hcd56 kernel: [ 8051.031234] Modules linked in: rpcsec_gss_=
krb5 auth_rpcgss nfsv4 nfs lockd grace fscache ipmi_ssif intel_rapl_msr dax=
_pmem_compat device_dax nd_pmem dax_pmem_core nd_btt intel_rapl_common sb_e=
dac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm crct10dif_=
pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue=
_helper rapl intel_cstate input_leds joydev mei_me lpc_ich mei ioatdma acpi=
_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter nfit acpi_pad m=
ac_hid iscsi_tcp libiscsi_tcp rdma_ucm sunrpc mlx4_ib ib_uverbs ib_umad ib_=
iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_ipoib ib_cm ib_core par=
port_pc ppdev lp parport autofs4 btrfs blake2b_generic xor raid6_pq libcrc3=
2c mlx4_en hid_generic usbhid hid ast drm_vram_helper drm_ttm_helper i2c_al=
go_bit ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec=
 rc_core sfc mlx4_core mtd ixgbe ahci drm xhci_pci xfrm_algo libahci nvme x=
hci_pci_renesas dca nvme_core mdio wmi
Sep 23 19:05:35 hcd56 kernel: [ 8051.116665] CR2: 000000000000000c
Sep 23 19:05:35 hcd56 kernel: [ 8051.119984] ---[ end trace 13b327955bd11f5=
f ]---
Sep 23 19:05:35 hcd56 kernel: [ 8051.119986] BUG: kernel NULL pointer deref=
erence, address: 000000000000000c
Sep 23 19:05:35 hcd56 kernel: [ 8051.119987] #PF: supervisor write access i=
n kernel mode
Sep 23 19:05:35 hcd56 kernel: [ 8051.129900] RIP: 0010:jbd2_journal_add_jou=
rnal_head+0x93/0x120
Sep 23 19:05:35 hcd56 kernel: [ 8051.131898] #PF: error_code(0x0002) - not-=
present page
Sep 23 19:05:35 hcd56 kernel: [ 8051.137116] Code: af f3 90 48 8b 13 f7 c2 =
00 00 40 00 75 f3 eb a0 48 8b 53 10 48 85 d2 74 07 48 83 7a 18 00 75 aa 0f =
0b 48 8b 4b 40 48 8d 53 02 <83> 41 0c 01 f0 80 22 bf 48 85 c0 74 0f 48 8b 3=
d 19 a8 d2 01 48 89
Sep 23 19:05:35 hcd56 kernel: [ 8051.142940] PGD 800000223fe5d067 P4D 80000=
0223fe5d067 PUD 15cdaff067 PMD 0
Sep 23 19:05:35 hcd56 kernel: [ 8051.148070] RSP: 0018:ffffaf98e55479f8 EFL=
AGS: 00010206
Sep 23 19:05:35 hcd56 kernel: [ 8051.166808] Oops: 0002 [#2] SMP PTI
Sep 23 19:05:35 hcd56 kernel: [ 8051.173765] RAX: 0000000000000000 RBX: fff=
f91744c78ed68 RCX: 0000000000000000
Sep 23 19:05:35 hcd56 kernel: [ 8051.178988] CPU: 19 PID: 4563 Comm: w6_10_=
-1 Tainted: G      D W         5.8.10-050810-generic #202009171232
Sep 23 19:05:35 hcd56 kernel: [ 8051.182468] RDX: ffff91744c78ed6a RSI: fff=
f91744c78ed68 RDI: ffff91744c78ed68
Sep 23 19:05:35 hcd56 kernel: [ 8051.182469] RBP: ffffaf98e5547a00 R08: fff=
fffff9ac05ee8 R09: 0000000000000028
Sep 23 19:05:35 hcd56 kernel: [ 8051.189591] Hardware name: Supermicro SYS-=
1028U-TN10RT+/X10DRU-i+, BIOS 3.1 06/08/2018
Sep 23 19:05:35 hcd56 kernel: [ 8051.199403] R10: ffff916b3f01c714 R11: 000=
0000000000297 R12: ffff917484cad620
Sep 23 19:05:35 hcd56 kernel: [ 8051.206533] RIP: 0010:jbd2_journal_add_jou=
rnal_head+0x93/0x120
Sep 23 19:05:35 hcd56 kernel: [ 8051.213652] R13: 0000000000000000 R14: fff=
f91744c78ed68 R15: ffff91744c78ed68
Sep 23 19:05:35 hcd56 kernel: [ 8051.221557] Code: af f3 90 48 8b 13 f7 c2 =
00 00 40 00 75 f3 eb a0 48 8b 53 10 48 85 d2 74 07 48 83 7a 18 00 75 aa 0f =
0b 48 8b 4b 40 48 8d 53 02 <83> 41 0c 01 f0 80 22 bf 48 85 c0 74 0f 48 8b 3=
d 19 a8 d2 01 48 89
Sep 23 19:05:35 hcd56 kernel: [ 8051.228680] FS:  00007fd3ebbff700(0000) GS=
:ffff917f3fc00000(0000) knlGS:0000000000000000
Sep 23 19:05:35 hcd56 kernel: [ 8051.234504] RSP: 0018:ffffaf98e55579f8 EFL=
AGS: 00010206
Sep 23 19:05:35 hcd56 kernel: [ 8051.241628] CS:  0010 DS: 0000 ES: 0000 CR=
0: 0000000080050033
Sep 23 19:05:35 hcd56 kernel: [ 8051.260364] RAX: 0000000000000000 RBX: fff=
f91744c78e0d0 RCX: 0000000000000000
Sep 23 19:05:35 hcd56 kernel: [ 8051.260366] RDX: ffff91744c78e0d2 RSI: fff=
f91744c78e0d0 RDI: ffff91744c78e0d0
Sep 23 19:05:35 hcd56 kernel: [ 8051.268442] CR2: 000000000000000c CR3: 000=
0002433d88005 CR4: 00000000003606e0
Sep 23 19:05:35 hcd56 kernel: [ 8051.273660] RBP: ffffaf98e5557a00 R08: fff=
f91744c78e0d0 R09: 0000000000001000
Sep 23 19:05:35 hcd56 kernel: [ 8051.279397] DR0: 0000000000000000 DR1: 000=
0000000000000 DR2: 0000000000000000
Sep 23 19:05:35 hcd56 kernel: [ 8051.279399] DR3: 0000000000000000 DR6: 000=
00000fffe0ff0 DR7: 0000000000000400
Sep 23 19:05:35 hcd56 kernel: [ 8051.286521] R10: ffff916b3f01c714 R11: 000=
0000000000157 R12: ffff9174d8d26508
Sep 23 19:05:35 hcd56 kernel: [ 8051.286523] R13: 0000000000000000 R14: fff=
f91744c78e0d0 R15: ffff91744c78e0d0
Sep 23 19:05:35 hcd56 kernel: [ 8051.336392] FS:  00007fd3e6fff700(0000) GS=
:ffff917f3fa40000(0000) knlGS:0000000000000000
Sep 23 19:05:35 hcd56 kernel: [ 8051.344468] CS:  0010 DS: 0000 ES: 0000 CR=
0: 0000000080050033
Sep 23 19:05:35 hcd56 kernel: [ 8051.350203] CR2: 000000000000000c CR3: 000=
0002433d88001 CR4: 00000000003606e0
Sep 23 19:05:35 hcd56 kernel: [ 8051.357328] DR0: 0000000000000000 DR1: 000=
0000000000000 DR2: 0000000000000000
Sep 23 19:05:35 hcd56 kernel: [ 8051.364452] DR3: 0000000000000000 DR6: 000=
00000fffe0ff0 DR7: 0000000000000400
Sep 23 19:05:35 hcd56 kernel: [ 8051.371578] Call Trace:
Sep 23 19:05:35 hcd56 kernel: [ 8051.374031]  jbd2_journal_get_write_access=
+0x53/0x90
Sep 23 19:05:35 hcd56 kernel: [ 8051.378989]  __ext4_journal_get_write_acce=
ss+0x4e/0x90
Sep 23 19:05:35 hcd56 kernel: [ 8051.384120]  ext4_reserve_inode_write+0x97=
/0xc0
Sep 23 19:05:35 hcd56 kernel: [ 8051.388641]  ? __ext4_ext_dirty+0x76/0x90
Sep 23 19:05:35 hcd56 kernel: [ 8051.392654]  __ext4_mark_inode_dirty+0x58/=
0x140
Sep 23 19:05:35 hcd56 kernel: [ 8051.397187]  __ext4_ext_dirty+0x76/0x90
Sep 23 19:05:35 hcd56 kernel: [ 8051.401025]  ext4_ext_rm_leaf+0x237/0x6a0
Sep 23 19:05:35 hcd56 kernel: [ 8051.405043]  ext4_ext_remove_space+0x44c/0=
x8e0
Sep 23 19:05:35 hcd56 kernel: [ 8051.409494]  ext4_ext_truncate+0xa0/0xb0
Sep 23 19:05:35 hcd56 kernel: [ 8051.413420]  ext4_truncate+0x2ed/0x450
Sep 23 19:05:35 hcd56 kernel: [ 8051.417173]  ext4_da_write_begin+0x2ae/0x4=
b0
Sep 23 19:05:35 hcd56 kernel: [ 8051.421447]  generic_perform_write+0xc2/0x=
1c0
Sep 23 19:05:35 hcd56 kernel: [ 8051.425819]  ext4_buffered_write_iter+0xa4=
/0x160
Sep 23 19:05:35 hcd56 kernel: [ 8051.430445]  ext4_file_write_iter+0x38/0x5=
0
Sep 23 19:05:35 hcd56 kernel: [ 8051.434637]  new_sync_write+0x111/0x1a0
Sep 23 19:05:35 hcd56 kernel: [ 8051.438485]  vfs_write+0x1c5/0x200
Sep 23 19:05:35 hcd56 kernel: [ 8051.441886]  ksys_write+0x67/0xe0
Sep 23 19:05:35 hcd56 kernel: [ 8051.445206]  __x64_sys_write+0x1a/0x20
Sep 23 19:05:35 hcd56 kernel: [ 8051.448961]  do_syscall_64+0x49/0xc0
Sep 23 19:05:35 hcd56 kernel: [ 8051.452543]  entry_SYSCALL_64_after_hwfram=
e+0x44/0xa9
Sep 23 19:05:35 hcd56 kernel: [ 8051.457602] RIP: 0033:0x7fd52bcc32dd
Sep 23 19:05:35 hcd56 kernel: [ 8051.461180] Code: 24 2d 00 00 75 10 b8 01 =
00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 fe dd 01 00 48 89 =
04 24 b8 01 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 47 de 01 00 48 89 d0 4=
8 83 c4 08 48 3d 01
Sep 23 19:05:35 hcd56 kernel: [ 8051.479923] RSP: 002b:00007fd3e6ff30d0 EFL=
AGS: 00000293 ORIG_RAX: 0000000000000001
Sep 23 19:05:35 hcd56 kernel: [ 8051.487488] RAX: ffffffffffffffda RBX: 000=
0000000000064 RCX: 00007fd52bcc32dd
Sep 23 19:05:35 hcd56 kernel: [ 8051.494620] RDX: 0000000000000064 RSI: 000=
07fcf3dbff000 RDI: 0000000000000216
Sep 23 19:05:35 hcd56 kernel: [ 8051.501747] RBP: 00007fcf3dbff000 R08: 000=
07fd416d18160 R09: 00007fd3e6fff700
Sep 23 19:05:35 hcd56 kernel: [ 8051.508877] R10: 7720646e756f7267 R11: 000=
0000000000293 R12: 0000000000000064
Sep 23 19:05:35 hcd56 kernel: [ 8051.516011] R13: 0000000000000001 R14: 000=
07fd416d18080 R15: 00007fd2da165e70
Sep 23 19:05:35 hcd56 kernel: [ 8051.523147] Modules linked in: rpcsec_gss_=
krb5 auth_rpcgss nfsv4 nfs lockd grace fscache ipmi_ssif intel_rapl_msr dax=
_pmem_compat device_dax nd_pmem dax_pmem_core nd_btt intel_rapl_common sb_e=
dac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm crct10dif_=
pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue=
_helper rapl intel_cstate input_leds joydev mei_me lpc_ich mei ioatdma acpi=
_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter nfit acpi_pad m=
ac_hid iscsi_tcp libiscsi_tcp rdma_ucm sunrpc mlx4_ib ib_uverbs ib_umad ib_=
iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_ipoib ib_cm ib_core par=
port_pc ppdev lp parport autofs4 btrfs blake2b_generic xor raid6_pq libcrc3=
2c mlx4_en hid_generic usbhid hid ast drm_vram_helper drm_ttm_helper i2c_al=
go_bit ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec=
 rc_core sfc mlx4_core mtd ixgbe ahci drm xhci_pci xfrm_algo libahci nvme x=
hci_pci_renesas dca nvme_core mdio wmi
Sep 23 19:05:35 hcd56 kernel: [ 8051.608601] CR2: 000000000000000c
Sep 23 19:05:35 hcd56 kernel: [ 8051.611915] ---[ end trace 13b327955bd11f6=
0 ]---
Sep 23 19:05:35 hcd56 kernel: [ 8051.621848] RIP: 0010:jbd2_journal_add_jou=
rnal_head+0x93/0x120
Sep 23 19:05:35 hcd56 kernel: [ 8051.627672] Code: af f3 90 48 8b 13 f7 c2 =
00 00 40 00 75 f3 eb a0 48 8b 53 10 48 85 d2 74 07 48 83 7a 18 00 75 aa 0f =
0b 48 8b 4b 40 48 8d 53 02 <83> 41 0c 01 f0 80 22 bf 48 85 c0 74 0f 48 8b 3=
d 19 a8 d2 01 48 89
Sep 23 19:05:35 hcd56 kernel: [ 8051.646406] RSP: 0018:ffffaf98e55479f8 EFL=
AGS: 00010206
Sep 23 19:05:35 hcd56 kernel: [ 8051.651623] RAX: 0000000000000000 RBX: fff=
f91744c78ed68 RCX: 0000000000000000
Sep 23 19:05:35 hcd56 kernel: [ 8051.658749] RDX: ffff91744c78ed6a RSI: fff=
f91744c78ed68 RDI: ffff91744c78ed68
Sep 23 19:05:35 hcd56 kernel: [ 8051.665872] RBP: ffffaf98e5547a00 R08: fff=
fffff9ac05ee8 R09: 0000000000000028
Sep 23 19:05:35 hcd56 kernel: [ 8051.672996] R10: ffff916b3f01c714 R11: 000=
0000000000297 R12: ffff917484cad620
Sep 23 19:05:35 hcd56 kernel: [ 8051.680120] R13: 0000000000000000 R14: fff=
f91744c78ed68 R15: ffff91744c78ed68
Sep 23 19:05:35 hcd56 kernel: [ 8051.687246] FS:  00007fd3e6fff700(0000) GS=
:ffff917f3fa40000(0000) knlGS:0000000000000000
Sep 23 19:05:35 hcd56 kernel: [ 8051.695322] CS:  0010 DS: 0000 ES: 0000 CR=
0: 0000000080050033
Sep 23 19:05:35 hcd56 kernel: [ 8051.701060] CR2: 000000000000000c CR3: 000=
0002433d88001 CR4: 00000000003606e0
Sep 23 19:05:35 hcd56 kernel: [ 8051.708183] DR0: 0000000000000000 DR1: 000=
0000000000000 DR2: 0000000000000000
Sep 23 19:05:35 hcd56 kernel: [ 8051.715308] DR3: 0000000000000000 DR6: 000=
00000fffe0ff0 DR7: 0000000000000400

>=20
> > ------------------------------------------------------
> > kernel panic snippet on cpu soft lockup
> > ------------------------------------------------------
> > Sep 18 21:27:27 hcd56 kernel: [88463.800033] watchdog: BUG: soft
> > lockup - CPU#38 stuck for 23s! [irq/27-pciehp:416] Sep 18 21:27:27
> > hcd56 kernel: [88463.804076] ib0: transmit timeout: latency 20428
> > msecs Sep 18 21:27:27 hcd56 kernel: [88463.807609] Modules linked in:
> rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace fscache ipmi_ssif
> intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal
> intel_powerclamp coretemp kvm_intel kvm irqbypass dax_pmem_compat
> device_dax nd_pmem dax_pmem_core nd_btt crct10dif_pclmul
> crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd
> glue_helper intel_cstate input_leds intel_rapl_perf joydev mei_me mei
> lpc_ich ioatdma ipmi_si ipmi_devintf ipmi_msghandler nfit
> acpi_power_meter acpi_pad mac_hid iscsi_tcp libiscsi_tcp rdma_ucm
> mlx4_ib sunrpc ib_uverbs ib_umad ib_iser rdma_cm iw_cm libiscsi
> scsi_transport_iscsi ib_ipoib ib_cm ib_core parport_pc ppdev lp parport
> autofs4 btrfs xor zstd_compress raid6_pq libcrc32c mlx4_en hid_generic
> usbhid hid ast drm_vram_helper i2c_algo_bit ttm drm_kms_helper
> syscopyarea sysfillrect sysimgblt fb_sys_fops sfc mlx4_core mtd ixgbe drm
> ahci nvme xfrm_algo libahci nvme_core dca mdio wmi Sep 18 21:27:27 hcd56
> kernel: [88463.812748] ib0: queue stopped 1, tx_head 7638106, tx_tail
> 7637978
> > Sep 18 21:27:27 hcd56 kernel: [88463.894312] CPU: 38 PID: 416 Comm:
> irq/27-pciehp Tainted: G      D W         5.4.0-050400-generic #201911242=
031
> > Sep 18 21:27:27 hcd56 kernel: [88463.894313] Hardware name: Supermicro
> > SYS-1028U-TN10RT+/X10DRU-i+, BIOS 3.1 06/08/2018 Sep 18 21:27:27 hcd56
> > kernel: [88463.894329] RIP:
> > 0010:native_queued_spin_lock_slowpath+0x62/0x1d0
> > Sep 18 21:27:27 hcd56 kernel: [88463.894331] Code: 0f ba 2f 08 0f 92
> > c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 48 85
> > c0 74 0e 8b 07 84 c0 74 08 f3 90 8b 07 <84> c0 75 f8 b8 01 00 00 00 5d
> > 66 89 07 c3 8b 37 81 fe 00 01 00 00 Sep 18 21:27:27 hcd56 kernel:
> > [88463.894332] RSP: 0000:ffffb1da46eefa40 EFLAGS: 00000202 ORIG_RAX:
> > ffffffffffffff13 Sep 18 21:27:27 hcd56 kernel: [88463.894334] RAX:
> > 0000000000000101 RBX: ffff9717c9abe380 RCX: ffffb1da46eefa9c Sep 18
> > 21:27:27 hcd56 kernel: [88463.894334] RDX: 0000000000000000 RSI:
> > 0000000000000000 RDI: ffff9701e12d7b88 Sep 18 21:27:27 hcd56 kernel:
> > [88463.894335] RBP: ffffb1da46eefa40 R08: ffffb1da46eef918 R09:
> > 0000000000000000 Sep 18 21:27:27 hcd56 kernel: [88463.894336] R10:
> > 0000000000000001 R11: ffff97183ffd4000 R12: ffff9717f9da0528 Sep 18
> > 21:27:27 hcd56 kernel: [88463.894336] R13: ffff9701e12d7b88 R14:
> ffff9703fa860000 R15: ffff9717f9da0630 Sep 18 21:27:27 hcd56 kernel:
> [88463.894337] FS:  0000000000000000(0000) GS:ffff9717ffa80000(0000)
> knlGS:0000000000000000 Sep 18 21:27:27 hcd56 kernel: [88463.894338] CS:
> 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 Sep 18 21:27:27 hcd56 kernel=
:
> [88463.894339] CR2: 00007fdd7bb3c000 CR3: 000000103564c002 CR4:
> 00000000003606e0 Sep 18 21:27:27 hcd56 kernel: [88463.894340] DR0:
> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 Sep 18
> 21:27:27 hcd56 kernel: [88463.894340] DR3: 0000000000000000 DR6:
> 00000000fffe0ff0 DR7: 0000000000000400 Sep 18 21:27:27 hcd56 kernel:
> [88463.894341] Call Trace:
> > Sep 18 21:27:27 hcd56 kernel: [88463.894359]  _raw_spin_lock+0x1e/0x30
> > Sep 18 21:27:27 hcd56 kernel: [88463.894376]
> > jbd2_journal_release_jbd_inode+0xb7/0x120
> > Sep 18 21:27:27 hcd56 kernel: [88464.032946]  ?
> > ext4_es_remove_extent+0x82/0x100 Sep 18 21:27:27 hcd56 kernel:
> > [88464.037480]  ext4_clear_inode+0x5f/0xa0 Sep 18 21:27:27 hcd56
> > kernel: [88464.041318]  ext4_evict_inode+0x60/0x5b0 Sep 18 21:27:27
> > hcd56 kernel: [88464.045234]  evict+0xd2/0x1b0 Sep 18 21:27:27 hcd56
> > kernel: [88464.048196]  dispose_list+0x39/0x50 Sep 18 21:27:27 hcd56
> > kernel: [88464.051680]  invalidate_inodes+0x160/0x190 Sep 18 21:27:27
> > hcd56 kernel: [88464.055773]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
> > Sep 18 21:27:27 hcd56 kernel: [88464.060730]
> > __invalidate_device+0x38/0x60 Sep 18 21:27:27 hcd56 kernel:
> > [88464.064822]  invalidate_partition+0x32/0x50 Sep 18 21:27:27 hcd56
> > kernel: [88464.069006]  del_gendisk+0x117/0x2f0 Sep 18 21:27:27 hcd56
> > kernel: [88464.072582]  nvme_ns_remove+0xf6/0x140 [nvme_core] Sep 18
> > 21:27:27 hcd56 kernel: [88464.077371]
> > nvme_remove_namespaces+0x9f/0xe0 [nvme_core] Sep 18 21:27:27
> hcd56
> > kernel: [88464.082760]  nvme_remove+0x66/0x170 [nvme] Sep 18 21:27:27
> > hcd56 kernel: [88464.086853]  pci_device_remove+0x3e/0xb0 Sep 18
> > 21:27:27 hcd56 kernel: [88464.090770]
> > device_release_driver_internal+0xf0/0x1c0
> > Sep 18 21:27:27 hcd56 kernel: [88464.095898]
> > device_release_driver+0x12/0x20 Sep 18 21:27:27 hcd56 kernel:
> > [88464.100165]  pci_stop_bus_device+0x70/0xa0 Sep 18 21:27:27 hcd56
> > kernel: [88464.104253]  pci_stop_and_remove_bus_device+0x13/0x20
> > Sep 18 21:27:27 hcd56 kernel: [88464.109301]
> > pciehp_unconfigure_device+0x80/0x12f
> > Sep 18 21:27:27 hcd56 kernel: [88464.114004]
> > pciehp_disable_slot+0x6e/0x100 Sep 18 21:27:27 hcd56 kernel:
> > [88464.118182]  pciehp_handle_presence_or_link_change+0xe1/0x150
> > Sep 18 21:27:27 hcd56 kernel: [88464.123919]  pciehp_ist+0x122/0x130
> > Sep 18 21:27:27 hcd56 kernel: [88464.127401]  irq_thread_fn+0x28/0x60
> > Sep 18 21:27:27 hcd56 kernel: [88464.130973]  irq_thread+0xda/0x170
> > Sep 18 21:27:27 hcd56 kernel: [88464.134369]  ?
> > irq_forced_thread_fn+0x80/0x80 Sep 18 21:27:27 hcd56 kernel:
> > [88464.138724]  kthread+0x104/0x140 Sep 18 21:27:27 hcd56 kernel:
> > [88464.141953]  ? irq_thread_check_affinity+0xf0/0xf0
> > Sep 18 21:27:27 hcd56 kernel: [88464.146736]  ? kthread_park+0x90/0x90
> > Sep 18 21:27:27 hcd56 kernel: [88464.150397]  ret_from_fork+0x35/0x40
> >
> > ---------------------------------------------------------------
> > kernel panic on ext4 NULL pointer dereference
> > ---------------------------------------------------------------
> > Sep 18 21:27:00 hcd56 kernel: [88437.232231] VFS: busy inodes on
> > changed media or resized disk nvme0n2 Sep 18 21:27:01 hcd56 kernel:
> [88437.577487] Aborting journal on device nvme0n2-8.
> > Sep 18 21:27:01 hcd56 kernel: [88437.582192] JBD2: Error -5 detected wh=
en
> updating journal superblock for nvme0n2-8.
> > Sep 18 21:27:01 hcd56 kernel: [88437.589853] BUG: kernel NULL pointer
> > dereference, address: 0000000000000008 Sep 18 21:27:01 hcd56 kernel:
> > [88437.596808] #PF: supervisor write access in kernel mode Sep 18
> > 21:27:01 hcd56 kernel: [88437.602026] #PF: error_code(0x0002) -
> > not-present page Sep 18 21:27:01 hcd56 kernel: [88437.607157] PGD
> 8000000b59cba067 P4D 8000000b59cba067 PUD fa8d3d067 PMD 0 Sep 18
> 21:27:01 hcd56 kernel: [88437.614021] Oops: 0002 [#1] SMP PTI
> > Sep 18 21:27:01 hcd56 kernel: [88437.617505] CPU: 31 PID: 3660 Comm:
> jbd2/nvme0n2-8 Tainted: G        W         5.4.0-050400-generic #20191124=
2031
> > Sep 18 21:27:01 hcd56 kernel: [88437.627781] Hardware name: Supermicro
> > SYS-1028U-TN10RT+/X10DRU-i+, BIOS 3.1 06/08/2018 Sep 18 21:27:01 hcd56
> > kernel: [88437.635694] RIP:
> > 0010:jbd2_journal_grab_journal_head+0x22/0x40
> > Sep 18 21:27:01 hcd56 kernel: [88437.641522] Code: eb e7 66 0f 1f 44
> > 00 00 0f 1f 44 00 00 55 48 89 e5 f0 48 0f ba 2f 18 72 1c 48 8b 17 31
> > c0 f7 c2 00 00 02 00 74 08 48 8b 47 40 <83> 40 08 01 f0 80 67 03 fe 5d
> > c3 f3 90 48 8b
> > 07 a9 00 00 00 01 75
> > Sep 18 21:27:01 hcd56 kernel: [88437.660259] RSP:
> > 0018:ffffb1da4a17fce0 EFLAGS: 00010206 Sep 18 21:27:01 hcd56 kernel:
> > [88437.665475] RAX: 0000000000000000 RBX: ffff9717a5c274b0 RCX:
> > 000000008020001c Sep 18 21:27:01 hcd56 kernel: [88437.672599] RDX:
> > 0000000001e2c021 RSI: ffff9710e77ea900 RDI: ffff97120026fa90 Sep 18
> > 21:27:01 hcd56 kernel: [88437.679722] RBP: ffffb1da4a17fce0 R08:
> > 0000000000000000 R09: ffffffffa67e2700 Sep 18 21:27:01 hcd56 kernel:
> > [88437.686848] R10: ffff971017b71400 R11: 0000000000000001 R12:
> > ffff9710e77ea900 Sep 18 21:27:01 hcd56 kernel: [88437.693973] R13:
> > ffff9701e12d7b88 R14: ffff97120026fa92 R15: ffff9710e77ea900 Sep 18
> > 21:27:01 hcd56 kernel: [88437.701095] FS:  0000000000000000(0000)
> > GS:ffff9717ff8c0000(0000) knlGS:0000000000000000 Sep 18 21:27:01 hcd56
> kernel: [88437.709174] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 =
Sep
> 18 21:27:01 hcd56 kernel: [88437.714909] CR2: 0000000000000008 CR3:
> 000000103564c005 CR4: 00000000003606e0 Sep 18 21:27:01 hcd56 kernel:
> [88437.722035] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000 Sep 18 21:27:01 hcd56 kernel: [88437.729160] DR3:
> 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 Sep 18
> 21:27:01 hcd56 kernel: [88437.736284] Call Trace:
> > Sep 18 21:27:01 hcd56 kernel: [88437.738733]
> > __jbd2_journal_insert_checkpoint+0x28/0x80
> > Sep 18 21:27:01 hcd56 kernel: [88437.743954]
> > jbd2_journal_commit_transaction+0x124f/0x178d
> > Sep 18 21:27:01 hcd56 kernel: [88437.749434]  ?
> > try_to_del_timer_sync+0x54/0x80 Sep 18 21:27:01 hcd56 kernel:
> > [88437.753881]  kjournald2+0xb6/0x280 Sep 18 21:27:01 hcd56 kernel:
> > [88437.757286]  ? wait_woken+0x80/0x80 Sep 18 21:27:01 hcd56 kernel:
> > [88437.760778]  kthread+0x104/0x140 Sep 18 21:27:01 hcd56 kernel:
> > [88437.763231] EXT4-fs error (device nvme0n2):
> > ext4_journal_check_start:61: Detected aborted journal Sep 18 21:27:01
> > hcd56 kernel: [88437.763293] EXT4-fs error (device nvme0n2):
> > ext4_journal_check_start:61: Detected aborted journal Sep 18 21:27:01
> > hcd56 kernel: [88437.764002]  ? commit_timeout+0x20/0x20 Sep 18
> > 21:27:01 hcd56 kernel: [88437.764004]  ? kthread_park+0x90/0x90 Sep 18
> > 21:27:01 hcd56 kernel: [88437.764009]  ret_from_fork+0x35/0x40 Sep 18
> > 21:27:01 hcd56 kernel: [88437.764011] Modules linked in:
> > rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace fscache ipmi_ssif
> > intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal
> > intel_powerclamp coretemp kvm_intel kvm irqbypass dax_pmem_compat
> > device_dax nd_pmem dax_pmem_core nd_btt crct10dif_pclmul
> crc32_pclmul
> > ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper
> > intel_cstate input_leds intel_rapl_perf joydev mei_me mei lpc_ich
> > ioatdma ipmi_si ipmi_devintf ipmi_msghandler nfit acpi_power_meter
> > acpi_pad mac_hid iscsi_tcp libiscsi_tcp rdma_ucm mlx4_ib sunrpc
> > ib_uverbs ib_umad ib_iser rdma_cm iw_cm libiscsi scsi_transport_iscsi
> > ib_ipoib ib_cm ib_core parport_pc ppdev lp parport autofs4 btrfs xor
> > zstd_compress raid6_pq libcrc32c mlx4_en hid_generic usbhid hid ast
> > drm_vram_helper i2c_algo_bit ttm drm_kms_helper syscopyarea
> > sysfillrect sysimgblt fb_sys_fops sfc mlx4_core mtd ixgbe drm ahci
> > nvme xfrm_algo libahci nvme_core dca mdio wmi Sep 18 21:27:01 hcd56
> > kernel: [88437.874368] CR2: 0000000000000008 Sep 18 21:27:01 hcd56
> > kernel: [88437.877683] ---[ end trace 5a47dfdfd127baf6 ]---
