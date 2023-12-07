Return-Path: <linux-ext4+bounces-335-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA018085C4
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Dec 2023 11:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE662835A6
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Dec 2023 10:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D4834186;
	Thu,  7 Dec 2023 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="hQX55CCs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Xuw6XUBK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtpout149.security-mail.net (smtpout149.security-mail.net [85.31.212.149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4E4D54
	for <linux-ext4@vger.kernel.org>; Thu,  7 Dec 2023 02:50:57 -0800 (PST)
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id 3453734970F
	for <linux-ext4@vger.kernel.org>; Thu,  7 Dec 2023 11:50:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1701946256;
	bh=NxUpJ9eVM/oVnmIiBiJeTEX8/8d0wfgbHcvhf13WF50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hQX55CCsc9wUZaQzOWuR8h8CigK6SRnr4o0lfY6sjKZ9HY1TslunNi3sKNT2D8voU
	 YpFn5e1/fAWfGE7S+qwuiI3oZlfgWwNdj5n7/Jv36JVXC7Up2Vl+/emU8Vh9F7xzZZ
	 IT3qnGrA3PW3SR3/knc+g2BUjHO54GLpJbKAbF2Q=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id D75DF349745; Thu,  7 Dec
 2023 11:50:55 +0100 (CET)
Received: from FRA01-PR2-obe.outbound.protection.outlook.com
 (mail-pr2fra01lp0100.outbound.protection.outlook.com [104.47.24.100]) by
 fx409.security-mail.net (Postfix) with ESMTPS id 5AA6134968D; Thu,  7 Dec
 2023 11:50:55 +0100 (CET)
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::5)
 by MR1P264MB1668.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 10:50:54 +0000
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a]) by MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a%6]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 10:50:54 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <3d64.6571a38f.5904d.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPZhohA6cxwbAj/ALWLbqEsPbUeMet8tOme4XpywpAxqwLDLvKfOKYpHhOLsr08pMoo1BwXEY3m04ZNEorpTq9y+uiGy8c9VmJJ7L+F537emeYGbBPsB1WpJwEQSR97s0fJYn12LiXuBegW9Oes0vPyyu7VjWBYBGvzNuWfLmdSGUds/M7BGK3HMGTM64hC+QJ4P3ndNbu0wiL/w29NmRZh5OBjblsBVyStOTIeFa05CGvu76cJF2+F4kKP2/USmEO+x2IC8tGTyU5a0Z0ZhpH8dlFzjC7o1cx+MuxjcxbrmVq/tO4PwCM7p0Vf/+VhroMWF2a122HXyOQDxl1o2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRk7A9Aw4m0CI9Rl7Sf3fo1zqtzMG6DL6YikOgf2UlA=;
 b=KmlE0jbfqsCnc5ioSgeggCqH6JeYCrGEv5vclN45Jbn/8MsyTSKQmSKsWAmTUHRqncH+nrIGrug8wyVK4sneuAII5C4IcJ9lx/LVz0hbO23ZHmqDpwmd1VUIyrTaPm7l/kbPhGdeFFCIbmYj1fKfABQvz6PnLBLXHYLvFv5hKfaIZl8tNiCqqzSMXXRWRUHjZic7PPAY3v4zyUovnOQmdaUPnxBkMn5B09Oakv4T0sdC62SU/T83sLbORYLtVz97eCvm/08lD17KTATTXO9iaLUmFMQE28K5Br3oeetUbGFtEBZkFCrf6jKkbR9N4Lyj4hK/5B/C91KOKqItMDIFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRk7A9Aw4m0CI9Rl7Sf3fo1zqtzMG6DL6YikOgf2UlA=;
 b=Xuw6XUBK9xpakwXQqgMgbubx5uLBtaNpkzHjj1aLvRfJRzPxg2Kyfy6PLVpNYGOo5TZB561prgnR8WV9g0I5vFoIVe+QhcxjbUph0+OW4BWCdvuAMOY9HseSxO1OdzklviyM5JM4BZ3420DQMMQEntgclArD125RhutyM8/35zVI4QZnb6U5YodPr6NwOKNAFe4MyOCInNVWLeBrlMJ4eWBn0teo7rv93aw6+30nLeb2QCkOHdOUIBD1AWms9nG+8Ho70uRDiuQH0cK+PFNjqq5nEsEYVOWafY8IAqx/2hOvC7x7JR2iGv9C908hIENEGSu1E0rA/m3j64gZXIbYmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <77d9ad6b-726f-f296-8a91-c93d5791b4cb@kalrayinc.com>
Date: Thu, 7 Dec 2023 11:50:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: regression in 6.1.yy branch: LTP test preadv03 fails
Content-Language: en-us
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c1f93c13-4865-b5a8-8969-4c2f5cb8f776@kalrayinc.com>
 <2023120747-domain-angled-d633@gregkh>
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <2023120747-domain-angled-d633@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0396.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::24) To MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:13::5)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB1890:EE_|MR1P264MB1668:EE_
X-MS-Office365-Filtering-Correlation-Id: c07e6ee7-6653-4206-89af-08dbf71262c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgkDIRvt0Hpsj02D1BWfxUOcZqliNIL4K4xMDmEiZ5zEhBMHv9H0ix9n4JqvX7hjZQHaeq3jjFiWusi2ZxnmzvaiZWk2qbhNHEhr/koFGc5Lgzs2gX7ksfPWHXkGY/369nanqN9LmShTq8tkPPibYjFkMfKchVk88p5R/dOEcUyZwolqzmATNDfdP4c6XbT64TenWhmsBQX7+3XTqsYWvUUYCb9gKrKNTKnkVzKEWjY+r4mwnYod6VgpNIswWIwLLRqhjcKSXsN6k0ItINPebdtZt4nIa98WDvMhtIA/ti3D7Lel9HyC+drpyxI0oISWK1vr6zCdQi+FyceJUlNL+D+2XTXmrjVzS+5uRRvaC4UDDi3XCT63R4EALjF7s0kAxWYANxPszf4CMCsDiPt2Ky1APBYytHFeftdwwSGKsmGEtYAKhjRWhVHrK7TtTW9JNkNxUkaAuQgPvtLB1UTP0+xMVY5W2iC+p70z57qrw/pUu/qhHo28E6lzrEgKFlpW0+CayV+9f21kIaYotkunrAs283mESc9/+e7tNaET/RoZoTAGHuKL3pj3lQ/z/ynJQbzPeqNakebC5tLlJv9WH/Uc0y6iS7LCyFFDVoA7fp2JDFu0Eaj+RKif6++QfKSKrgr1aok/87MvYUmHGpQZMppwMnhCN2AuxjENUxS07e6RytEXm06LsEVsBS8NrR1p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(396003)(136003)(346002)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66899024)(316002)(66556008)(66946007)(6916009)(66476007)(54906003)(6512007)(53546011)(83380400001)(26005)(2616005)(41300700001)(6486002)(478600001)(86362001)(31696002)(6506007)(36756003)(38100700002)(19627235002)(5660300002)(31686004)(2906002)(8936002)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zXMspApttShnc3UDHQwwKCsPmDPNmhLTyP6tg0/8RYRXMHrozNYd+JI93ejbBiRRjoIuxUD7vNRaYeC4Ds0Lp4ePkoxH33lsHix7rimcPUa2CI9AwpK4ZV9X8ELi5ELzf41XE1W0FJojXtvidr69PK+JO0GTtT8QvkaHXsew9xu1e1tfy9OluKEniKimt3430p2hzpoEAmHuXFIyiQJuyvIC9AcrC4PV0KM4Lh1j0Lae/4oMCOk7cXEE3yhfODIPVO20dMnvNcQMHag/Bnq35ZZtk2R237Toup1B8h9F/1Hh1PuJfVVUzuZfTde6s1nxodmf5wHwv3cNTyF1IewWroICO6zq3z/TM3Rd0TjTM8jdN5zvxx6tcdpIYkjtTfcBZuDkShNqIVtZnd7Qeoe4QLztd+qXMdObAP1zFkai47h/Li43H9zFojxIDWAICsb7f6V+INA+iInc8t6Rw2+5TpNTRwAHIA6ztTmyon8EAGHl2I3iqJzApRHLaGvRGFBAQYEAl6633Ff/khJo0aB5vKaU/HySCzRUtF/qjWKVvk0LXHYkRLRILzaJIsxb4UwR0ipIxrk4pA+6knj3sI1XRxhcoIhpcVF2obAfPTfVfTHonKN6ppHrJp3FSlPTuSjiJiTlpjAMmv3tHRCpXlY+AStAUW2kPY4LmSmpUiIE16PQiPB4sY5LbzyYHFKspr2sZJlPEvySMK+bvR+UYdFMBa3eeCrSnKXqcUB6x6iJ9NyOibzrIY1d7r1EjH0svcVz1wKQBieZ383t8imJuUVGMXoIVYlylpnthRkuti6m/QWlQD7cGya1rHkQcCg6cUJp2f3hV4SJqt+fpD06+QypHkY/fO2OyRzSPo8l7VgX/KQ3WcO5R7KtFXMtqeVdFaYfcCIoSX2nmc93AFT47j3r36O+Yxxxscg9870G0fRY+VLfOaoEAeUQNroDJhAaDd+A
 Ifc5H/zrNaQDoqdFQD8E1bagmHFr6eSgY5dwbdJNRYHKbMoNaRYLG4pSSNOzzhGoox6dL1taD/DAH3ERPCId+QvbQZi+mUGZlZnjJZDf8GtNlmxMj+/DrBWWaSnyIHx2enm2lbxVAJs6KMX6wEX/4I8RFpLSzSeSkg28nxL2vdZkr3DNxYRwNs61Sz6leKSWW1cHnuTMByoygT09vvcZDZp+RgQ2aWrlWGdRRO93TuLGua3JAuXykWQfhCxnMG65hpQRhYxbxdIPzB/jkvRBDhTWIU2D/DinVybKQucq2wJtU8xqqE0B0mmptzgxf+2dg3zUtSFGCA8svEFibH1YIeud7IQ3bmn8MNG6HOxSQPC/wnQuEIj0COhMSs9dmjW9iOwkQRPsHszWbCZeWRvzGIU8PQeRFeOeNDB54LZ4Ibj8aXHzZxIj9RLGQ5u/dMHvZ0Xp2Vj8BFdjXoHpJRAHoz7sRQ4sJ4L6ItFKtGaTUwiLa+Y2J/N0lcXkELlEq4wpVhCqjnHA40gKuS/e9tUrYQ9HpAk+5xWJNcgQt4860Gk4JXr1QFGfL06Lmo3ZIUDXIwhdAax8LUAShRzsre/6GtnZMtFE+w1REmfwtfF7sYZPSkzN1h3vMs+cOpOFZx1A1qheq9AwskHsVs7GAQMoSA==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07e6ee7-6653-4206-89af-08dbf71262c1
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 10:50:54.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRQ3iiXg21JcuIs3g60pqQGIiwNBYGdcCa9TsN2xLK7Ps2rNmzKBoZMsSrQZuyTEsosF0wgFeysTBzRYMXEyjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1668
X-ALTERMIMEV2_out: done

On 12/7/23 11:13, Greg KH wrote:

> On Thu, Dec 07, 2023 at 11:05:15AM +0100, Yann Sionneau wrote:
>> Hello,
>>
>> I noticed yesterday that LTP test preadv03 now fails since 6.1.64 (it also
>> fails on 6.1.65).
>>
>> 6.6.4, 6.6.3, 6.5.0 and 6.2.0 seem to be unaffected.
>>
>> I tested this on x86_64 and kvx arch (the latter is not upstream).
>>
>> I can see some ext4 related commits on 6.1.64 and 6.1.65 changes, maybe it's
>> related, therefore I add ext4 mailing list as CC.
>>
>> I didn't run git bisect on this so far because I noticed building an x86_64
>> ubuntu kernel on my laptop was taking ages. Maybe someone is more used to
>> dealing with this and can bisect this way faster than me.
> Should be fixed in the latest 6.1.y-rc release, right?  If not, please
> let me know.

Thanks for the quick reply, indeed it seems way better on 6.1.66-rc2.

I tested on kvx arch, all preadv* LTP tests are passing:

```

# ./preadv03
tst_device.c:88: TINFO: Found free device 0 '/dev/loop0'
[  346.920257] loop0: detected capacity change from 0 to 524288
[  346.970126] /dev/zero: Can't open blockdev
tst_supported_fs_types.c:89: TINFO: Kernel supports ext2
tst_supported_fs_types.c:51: TINFO: mkfs.ext2 does exist
[  346.993817] /dev/zero: Can't open blockdev
tst_supported_fs_types.c:89: TINFO: Kernel supports ext3
tst_supported_fs_types.c:51: TINFO: mkfs.ext3 does exist
[  347.021140] /dev/zero: Can't open blockdev
tst_supported_fs_types.c:89: TINFO: Kernel supports ext4
tst_supported_fs_types.c:51: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:89: TINFO: Kernel supports vfat
tst_supported_fs_types.c:47: TINFO: mkfs.vfat does not exist
tst_supported_fs_types.c:156: TINFO: Skipping tmpfs as requested by the test
tst_test.c:1500: TINFO: Testing on ext2
tst_test.c:996: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.46.2 (28-Feb-2021)
[  347.283637] blk_print_req_error: 96 callbacks suppressed
[  347.283662] operation not supported error, dev loop0, sector 524160 
op 0x9:(WRITE_ZEROES) flags 0x800
0800 phys_seg 0 prio class 2
[  347.301367] operation not supported error, dev loop0, sector 522 op 
0x9:(WRITE_ZEROES) flags 0x800080
0 phys_seg 0 prio class 2
[  347.313610] operation not supported error, dev loop0, sector 16906 op 
0x9:(WRITE_ZEROES) flags 0x8000
800 phys_seg 0 prio class 2
[  347.325948] operation not supported error, dev loop0, sector 32774 op 
0x9:(WRITE_ZEROES) flags 0x8000
800 phys_seg 0 prio class 2
[  347.338311] operation not supported error, dev loop0, sector 49674 op 
0x9:(WRITE_ZEROES) flags 0x8000
800 phys_seg 0 prio class 2
[  347.350667] operation not supported error, dev loop0, sector 65542 op 
0x9:(WRITE_ZEROES) flags 0x8000
800 phys_seg 0 prio class 2
[  347.363027] operation not supported error, dev loop0, sector 82442 op 
0x9:(WRITE_ZEROES) flags 0x8000
800 phys_seg 0 prio class 2
[  347.375367] operation not supported error, dev loop0, sector 98310 op 
0x9:(WRITE_ZEROES) flags 0x8000
800 phys_seg 0 prio class 2
[  347.387733] operation not supported error, dev loop0, sector 115210 
op 0x9:(WRITE_ZEROES) flags 0x800
0800 phys_seg 0 prio class 2
[  347.400156] operation not supported error, dev loop0, sector 131078 
op 0x9:(WRITE_ZEROES) flags 0x800
0800 phys_seg 0 prio class 2
[  347.445283] EXT4-fs (loop0): mounting ext2 file system using the ext4 
subsystem
[  347.453761] EXT4-fs (loop0): mounted filesystem without journal. 
Quota mode: disabled.
[  347.461716] ext2 filesystem being mounted at /tmp/preB0llUr/mntpoint 
supports timestamps until 2038 (
0x7fffffff)
tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
[  347.475662] EXT4-fs (loop0): unmounting filesystem.
preadv03.c:102: TINFO: Using block size 512
preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with 
content 'a' expectedly
preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with 
content 'a' expectedly
preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with 
content 'b' expectedly
tst_test.c:1500: TINFO: Testing on ext3
tst_test.c:996: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
mke2fs 1.46.2 (28-Feb-2021)
[  347.780931] EXT4-fs (loop0): mounting ext3 file system using the ext4 
subsystem
[  347.791652] EXT4-fs (loop0): mounted filesystem with ordered data 
mode. Quota mode: disabled.
[  347.800197] ext3 filesystem being mounted at /tmp/preB0llUr/mntpoint 
supports timestamps until 2038 (
0x7fffffff)
tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
[  347.814544] EXT4-fs (loop0): unmounting filesystem.
preadv03.c:102: TINFO: Using block size 512
preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with 
content 'a' expectedly
preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with 
content 'a' expectedly
preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with 
content 'b' expectedly
tst_test.c:1500: TINFO: Testing on ext4
tst_test.c:996: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.46.2 (28-Feb-2021)
[  347.888885] EXT4-fs (loop0): mounted filesystem with ordered data 
mode. Quota mode: disabled.
[  347.897455] ext4 filesystem being mounted at /tmp/preB0llUr/mntpoint 
supports timestamps until 2038 (
0x7fffffff)
tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
[  347.911462] EXT4-fs (loop0): unmounting filesystem.
preadv03.c:102: TINFO: Using block size 512
preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with 
content 'a' expectedly
preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with 
content 'a' expectedly
preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with 
content 'b' expectedly

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0

```

The errors during mkfs are weird but maybe it's an issue in kvx port... 
at least the test is passing now.

Thanks!

-- 

Yann






