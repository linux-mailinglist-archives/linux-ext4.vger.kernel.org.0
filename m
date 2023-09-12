Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE8479DC5F
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Sep 2023 01:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjILXCn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Sep 2023 19:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbjILXCm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Sep 2023 19:02:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2115.outbound.protection.outlook.com [40.107.237.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200A910FD;
        Tue, 12 Sep 2023 16:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgkvPt/aA5YZ2d4iS0UIWdTJ9BDFYCBTGk1sK7i+dhnpBg71DVA3sboSN9xJXk2DgSm4zFjDraTmrEEqCfwL+uWo8SycIxUWW7JZb2Kfq0GbrLxVFYsgsTmP/qX9R+xSA7o0Fzwy6re3rer0/qpvVyUh43KgWbCwzwDiHeYpPglplUeIop8b9Uh/SMFEoLvxFH1rXL2BzexBEZRBFSu6YwxZWNtzgnTNtFnnv8KoQuMeUy2M/Rf7iPOgz+fE+8s8HEFzFBy/g02SBQ7JnFQkzqFSFckWFtXbiSUVOEmPea95yJsCY+k93pNn+FaGeybynx8LGCwZkHm2jGGihC6McA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1fPpaaFcnqQZP/y6E2gvVwmCyr0els4A3ISiTiD4K0=;
 b=kgd81K8Qx8mUHKKLVnrs+3yWCmVLc9Ob4NU9fS2gnwR63wJNog2zybLwAJVT3b2OuQ2X69zdHwRVcUiGz0lvfKdm0hPSh88m13un7DJe47G1D0259LATcMn2KQXV1Ev0M2iVTeqE7dSZasMYA1dwv3yyP73A+rDrLHo5VP89s1spoML+K3Sbwo15OaboWKvRybqzPhUYgiHJK0BZ5MZoG3BHvtjt6NFHTaKfjcOENiu5iPfkKTYkcdOjBZKQrht/M8s4lyf5TINVdfGLm0z2peeRYLXXfqb/is6egXc03eG6x9Ijh6k+N9B12MfYiEA7TUkc+Aj1Qas6gxjQdKt/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucf.edu; dmarc=pass action=none header.from=ucf.edu; dkim=pass
 header.d=ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucf.onmicrosoft.com;
 s=selector2-ucf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1fPpaaFcnqQZP/y6E2gvVwmCyr0els4A3ISiTiD4K0=;
 b=qiaxgx2X0qr2NoTTNZy5CPGncI86vCzvcxZbe0fOBuNq/Cagquh3c+klxb/XSMG/dSyHqIb9eNuZnwj2LfYrTw8g3Cntj0gfrBQIqcXslLdv7e+nOqukfd+fNaf9YwiRsRtObYcGFczs82q+Pw8o3BvxKP7UU4sQb3MIxB/6U+s=
Received: from BL0PR11MB3106.namprd11.prod.outlook.com (2603:10b6:208:7a::11)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 23:02:36 +0000
Received: from BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce]) by BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 23:02:36 +0000
From:   Sanan Hasanov <Sanan.Hasanov@ucf.edu>
To:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: general protection fault in ext4_update_overhead
Thread-Topic: general protection fault in ext4_update_overhead
Thread-Index: AQHZ4czcE0xX37Y4KUiLiSw6AbAruw==
Date:   Tue, 12 Sep 2023 23:02:35 +0000
Message-ID: <BL0PR11MB31066DF3F30927A7F82F22FEE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3106:EE_|DS0PR11MB7531:EE_
x-ms-office365-filtering-correlation-id: 9c8439c9-24cc-4257-1c41-08dbb3e45ac6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FS/d6pXxTamRoRuo0ZmoULaR4cFLTdHPczhghx3Iyn+kh4VNIVsYZ3xYMDHf2xVTRJSMBmc93ofkS5J97+vdtTJRbS+HRrkRRYtwizzNsrjDtQVqyezRcbIYmvOny6ttpgpwMVHNnfn7NWj7zQqja7sbgMKzHOkisUP7uHLqZy1o+fBNb97dJ8h0LCmGFJHEb6HX8HBps4L/FjraCYShHXScLa6E9gJUdIRMrH1vF3qt9Mi10X73hMFdtqyD3re72kqmmbWg/DuKQur/+MtyAG+c1birFkWsdS9uWfgFC2phkFq+m6wFevjHXJRsyc5YAXeuJUon6U3OtwBxwBdWFbKtnDjGBh+uFUm9GHTmvW/h+bImD00oeA/sxaj8uvb1uwHMvxJzi3OWRyvfaeje9Z1L/8cHJEoPcFdmtL0iybZBawbOkdINweot36qRohtJvqcuCv08exbwMagACVxCo5pLydtl5mjXjFeDuhnYnrhG7Ywb3nUd729zUgmRAU2X0HAnAzp454snEcS7Twvxzjka4Xx7ruzhVzh8bTKypu3/1Tg2RBgmcctrNogg+/FckIhPs0q+poM0Va4GedigRFUtdcw5SJwhFXAyq/O4BOAkLARQKhFCS1Lc7o4tGirYJ05ByNdrQhL91z2yLQ/DqumSgkrMI7wQM/MYVKi7h7k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(346002)(366004)(376002)(1800799009)(451199024)(186009)(122000001)(5930299018)(6506007)(7696005)(71200400001)(33656002)(75432002)(38070700005)(55016003)(38100700002)(478600001)(45954011)(83380400001)(26005)(45080400002)(52536014)(86362001)(2906002)(9686003)(41300700001)(64756008)(966005)(76116006)(8936002)(8676002)(5660300002)(4326008)(110136005)(54906003)(786003)(66946007)(66446008)(316002)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nKb8uaPUeN9NkpTWru3q/rdVYIFbikvCysEAPWmbfwRBkU1CZNFbWS+p4v?=
 =?iso-8859-1?Q?Oia6/9zuOHGcX4j+OxOZIq5vjHbYXtwvNwfxyybqjbmpW5wevxbgiNtFCC?=
 =?iso-8859-1?Q?metNNqJc9NaA/ZNnfDk63zO9yOTRr9mOTm2HKWPfgfnzrhXYbzqa45jOt/?=
 =?iso-8859-1?Q?stggWBhJH83s1Ee2m1pP+L8+cTrS/KlOEBCkscdQWZcN6YScK1ZsPs5Aeu?=
 =?iso-8859-1?Q?MJDKEKknSqbw75dsMcZWza9trKASxFDeJ8SQpaEHnx5ftpwSWyiElLksbm?=
 =?iso-8859-1?Q?JsoVMU4vZ7JdadBP/XuQfKtufUp1gNt7GI0W+t6DoYhDUCPs9ySKxSjnWI?=
 =?iso-8859-1?Q?F31jeSzrxBqEnAnbFe5LBIbQbI1ZEFYHFf7rWMncbUXvfFHugsPZ+59Y1V?=
 =?iso-8859-1?Q?1uPaI+GmyBLmMLUQ2BRrskRe0rggvbrLzvZxYCZLTaRirF5oXaDZHw+8vs?=
 =?iso-8859-1?Q?6rRgiZ+3uXyAWhxHIOGOKL/t1IbKf+kq5JY6bpndAtOXX/dAAtbDOXdu1G?=
 =?iso-8859-1?Q?2cZu1cgQFJX28o3m6nwLF7dJRbQT4rU+kUL1GpaoxjualYQkwssgrooFWK?=
 =?iso-8859-1?Q?hBneuk5BdDt7Hgyj7rD5fJ7uFzm+NW4W78raR9qCA6/I1zlZVaq5alkdlH?=
 =?iso-8859-1?Q?Y8Okr2CHJmRSNK/CS+OvM7PvLA1XCSaZUlB9igdMGMWQQYPvx+cnTyYevp?=
 =?iso-8859-1?Q?TkNJa8DUZHYL9tSi36iwei46G/63op60Z905rf/vS5ynSkbsEqVQDBojdX?=
 =?iso-8859-1?Q?Zcw8zVCRAP1APHHJblgIQIa+Eac8CeMSAm9JVL1zieqgF2yQDbIcHvYY8N?=
 =?iso-8859-1?Q?j1B1dFG5YwQahGDYD1YeAdJU4Ih5XxKkasDCJ8XuLHcJ2SpOUs8MmbhTcY?=
 =?iso-8859-1?Q?OIC/RLm+1SfTYO5yxef2sdaTnBPD6qnK1Kt/yQr1juvx5mBon8OCVZrvHW?=
 =?iso-8859-1?Q?A6kCMYsfI//skCmfVeetCf9tX4YuDBJpawJGRhkfx450sbUmGkOchYcl1c?=
 =?iso-8859-1?Q?Z+IpIdLA78gYUc3+lyUlFaIaAu9Ud0qus9P/yj5aBnCyxzU+HKwmjW2/ei?=
 =?iso-8859-1?Q?nyi8spwCMc4nAJi+fuOqYyKt/IMgV1ZsNGlF975GiDbUW+T3tKt+LM6VjK?=
 =?iso-8859-1?Q?717K+V2Mvx9F9HAModHmbEk29ngN/e2HQ1oz6eiz36vx2WFTFIAv43qG4I?=
 =?iso-8859-1?Q?y/kgtZ1fjb+If3aegfcNMbCfOitotzr1QLznVSTUqel5+nuqEbtKx0xLFE?=
 =?iso-8859-1?Q?OCte3d47qji3ARO/CfPcknI0xxNXgbwOM1MwchMu+y7+zUCOIxUveLVZXh?=
 =?iso-8859-1?Q?abagM052eFnqEPdYlii3PJV1+HSaAy4oCxft9dsK8PSkQ2sDi5efMfYJWR?=
 =?iso-8859-1?Q?KcXuZd05bz8CY5vWB9NwGA7C9oecTCE0pAiCHKPV+du/QyK0o/5/3uOHpX?=
 =?iso-8859-1?Q?Pi5HhJVfvMAY44mBDKr+o1M1fmMxKtUgwKP129IlwcYCQ7EZtXdKZA6au3?=
 =?iso-8859-1?Q?V2FyyAf/6y3JedmxNBMIwFqGfZq1SlXKEldttK8voFEEaPXCnUnBZLEB4b?=
 =?iso-8859-1?Q?dNPvMTlwcxbvIKQ5w/24R5/LPHyT7sKNye++VVH/F5PzClMdfX04O4xKBy?=
 =?iso-8859-1?Q?eNdplW73psAyI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8439c9-24cc-4257-1c41-08dbb3e45ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 23:02:35.9891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb932f15-ef38-42ba-91fc-f3c59d5dd1f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GST3Z9aNjaCOI0G7yYS+AKha5PGNZ3vPJxHeLkGe5Uq1Xyxdt4fAG9s+GdcExuh4XADARjOqIgLYe24NQWd7Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Good day, dear maintainers,=0A=
=0A=
We found a bug using a modified kernel configuration file used by syzbot.=
=0A=
=0A=
We enhanced the coverage of the configuration file using our tool, klocaliz=
er.=0A=
=0A=
Kernel Branch: 6.3.0-next-20230426=0A=
Kernel Config: https://drive.google.com/file/d/1xpe7qMUUYvHQFzqZGUzcco9jF97=
EwTqQ/view?usp=3Dsharing=0A=
Reproducer: https://drive.google.com/file/d/1Q8ix6EiWrzx0bWLyoGTHP721KE4Ei3=
qf/view?usp=3Dsharing=0A=
Thank you!=0A=
=0A=
Best regards,=0A=
Sanan Hasanov=0A=
=0A=
general protection fault, probably for non-canonical address 0xdffffc000000=
0009: 0000 [#1] PREEMPT SMP KASAN=0A=
KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]=0A=
kobject: 'loop6' (00000000df72f20a): kobject_uevent_env=0A=
CPU: 2 PID: 20787 Comm: syz-executor.4 Not tainted 6.3.0-next-20230426 #1=
=0A=
kobject: 'loop6' (00000000df72f20a): fill_kobj_path: path =3D '/devices/vir=
tual/block/loop6'=0A=
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014=0A=
RIP: 0010:ext4_update_overhead+0xb3/0x1a0=0A=
Code: 00 00 e8 20 cd 57 ff 45 84 ed 0f 85 b1 00 00 00 e8 62 d2 57 ff 4c 8d =
73 48 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 8=
5 c8 00 00 00 4c 8b 6b 48 31 ff 4c 89 ee e8 95 cd=0A=
RSP: 0018:ffff88801d51fac8 EFLAGS: 00010216=0A=
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000=0A=
RDX: 0000000000000009 RSI: ffffffff823198fe RDI: ffffffff823198f0=0A=
RBP: ffff88801d51fae8 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000001 R12: ffff8880516be000=0A=
R13: 0000000000000000 R14: 0000000000000048 R15: ffff8880516be000=0A=
FS:  00007f442e80f700(0000) GS:ffff88811a300000(0000) knlGS:000000000000000=
0=0A=
kobject: 'loop1' (00000000f3e7cad3): kobject_uevent_env=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
kobject: 'loop1' (00000000f3e7cad3): fill_kobj_path: path =3D '/devices/vir=
tual/block/loop1'=0A=
CR2: 0000555555bfdc88 CR3: 0000000050354000 CR4: 0000000000350ee0=0A=
Call Trace:=0A=
 <TASK>=0A=
 ext4_fill_super+0x30c8/0xb8d0=0A=
 get_tree_bdev+0x447/0x770=0A=
 ext4_get_tree+0x21/0x30=0A=
 vfs_get_tree+0x97/0x370=0A=
 path_mount+0x6d3/0x1fb0=0A=
 __x64_sys_mount+0x2b2/0x340=0A=
 do_syscall_64+0x3f/0x90=0A=
 entry_SYSCALL_64_after_hwframe+0x72/0xdc=0A=
RIP: 0033:0x7f442d69176e=0A=
Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 =
00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48=0A=
RSP: 002b:00007f442e80ea08 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5=0A=
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f442d69176e=0A=
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f442e80ea60=0A=
RBP: 00007f442e80eaa0 R08: 00007f442e80eaa0 R09: 0000000020000000=0A=
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000=0A=
R13: 0000000020000100 R14: 00007f442e80ea60 R15: 00000000200008c0=0A=
 </TASK>=0A=
Modules linked in:=0A=
kobject: 'loop2' (0000000027c67f3b): kobject_uevent_env=0A=
kobject: 'loop2' (0000000027c67f3b): fill_kobj_path: path =3D '/devices/vir=
tual/block/loop2'=0A=
---[ end trace 0000000000000000 ]---=0A=
kobject: 'loop2' (0000000027c67f3b): kobject_uevent_env=0A=
RIP: 0010:ext4_update_overhead+0xb3/0x1a0=0A=
kobject: 'loop2' (0000000027c67f3b): fill_kobj_path: path =3D '/devices/vir=
tual/block/loop2'=0A=
Code: 00 00 e8 20 cd 57 ff 45 84 ed 0f 85 b1 00 00 00 e8 62 d2 57 ff 4c 8d =
73 48 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 8=
5 c8 00 00 00 4c 8b 6b 48 31 ff 4c 89 ee e8 95 cd=0A=
RSP: 0018:ffff88801d51fac8 EFLAGS: 00010216=0A=
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000=0A=
RDX: 0000000000000009 RSI: ffffffff823198fe RDI: ffffffff823198f0=0A=
RBP: ffff88801d51fae8 R08: 0000000000000001 R09: 0000000000000000=0A=
R10: 0000000000000000 R11: 0000000000000001 R12: ffff8880516be000=0A=
R13: 0000000000000000 R14: 0000000000000048 R15: ffff8880516be000=0A=
kobject: 'loop2' (0000000027c67f3b): kobject_uevent_env=0A=
FS:  00007f442e80f700(0000) GS:ffff88811a300000(0000) knlGS:000000000000000=
0=0A=
kobject: 'loop2' (0000000027c67f3b): kobject_uevent_env: uevent_suppress ca=
used the event to drop!=0A=
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
kobject: 'loop2' (0000000027c67f3b): kobject_uevent_env=0A=
kobject: 'loop2' (0000000027c67f3b): kobject_uevent_env: uevent_suppress ca=
used the event to drop!=0A=
loop2: detected capacity change from 0 to 64=0A=
CR2: 00007f42967bd0b0 CR3: 0000000050354000 CR4: 0000000000350ee0=0A=
kobject: 'loop2' (0000000027c67f3b): kobject_uevent_env=0A=
----------------=0A=
Code disassembly (best guess):=0A=
   0:   00 00                   add    %al,(%rax)=0A=
   2:   e8 20 cd 57 ff          call   0xff57cd27=0A=
   7:   45 84 ed                test   %r13b,%r13b=0A=
   a:   0f 85 b1 00 00 00       jne    0xc1=0A=
  10:   e8 62 d2 57 ff          call   0xff57d277=0A=
  15:   4c 8d 73 48             lea    0x48(%rbx),%r14=0A=
  19:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax=0A=
  20:   fc ff df=0A=
  23:   4c 89 f2                mov    %r14,%rdx=0A=
  26:   48 c1 ea 03             shr    $0x3,%rdx=0A=
* 2a:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1) <-- trapping inst=
ruction=0A=
  2e:   0f 85 c8 00 00 00       jne    0xfc=0A=
  34:   4c 8b 6b 48             mov    0x48(%rbx),%r13=0A=
  38:   31 ff                   xor    %edi,%edi=0A=
  3a:   4c 89 ee                mov    %r13,%rsi=0A=
  3d:   e8                      .byte 0xe8=0A=
  3e:   95                      xchg   %eax,%ebp=0A=
  3f:   cd                      .byte 0xcd=0A=
