Return-Path: <linux-ext4+bounces-333-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EE380853B
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Dec 2023 11:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574CD1C20E86
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Dec 2023 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925035880;
	Thu,  7 Dec 2023 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="erD902DT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="EVBdJtSb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtpout145.security-mail.net (smtpout145.security-mail.net [85.31.212.145])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BCAA8
	for <linux-ext4@vger.kernel.org>; Thu,  7 Dec 2023 02:11:32 -0800 (PST)
Received: from localhost (fx405.security-mail.net [127.0.0.1])
	by fx405.security-mail.net (Postfix) with ESMTP id A6EB9335FF3
	for <linux-ext4@vger.kernel.org>; Thu,  7 Dec 2023 11:11:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1701943890;
	bh=z9ghVrXA8A1jBl49QU4oZsQ3aqKrNNYhgXz8yqDlYXg=;
	h=Date:From:Subject:To:Cc;
	b=erD902DT7Dp2OCGXMMWT/sH/1DuQbnrwXZAWa2vQBrXBJXqy8JwlswjoEDDwmf/4G
	 8Zo9ceby1TOPfEfXqRRFIiyNKA7WCeo67HI3raotGlOqZYk3V0QSjJkvwU2bbPC2Lb
	 WZer1EqkgUwm9OJdKVYE37NEaWJW5p/FSPCqWTN8=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id 4213B336175; Thu,  7 Dec
 2023 11:11:30 +0100 (CET)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on0101.outbound.protection.outlook.com [104.47.25.101]) by
 fx405.security-mail.net (Postfix) with ESMTPS id 9C125335FDC; Thu,  7 Dec
 2023 11:11:29 +0100 (CET)
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::5)
 by MR1P264MB3153.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 10:11:28 +0000
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a]) by MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a%6]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 10:11:28 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <28dd.65719a51.99b7e.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjcpadVgoi0Bv5RmORgxRyH0SvNn84jivlI8jknje4RlHon2AhwsMgUNd6eYChsq3qWmFkb+Tv0Z0V7ZQ3rXLM+FmFv1ChQn2UvZeP3sFUqtAhVqNCtdK3BQuuT+hUjBiSaupKSQxR6FW8Ih6mBmD4U02guTxsxsH8pHvygQQzmEHPemfbgOg8+1hTaWXRU4miw+XPKZ9+bjxFAKFpqLDgV+DHbX7xQWsG2mI4JDcK8esticpANGgKHj2PiX3REsK2nlDKy2qWLvz9+mFvZukJkpzLFcJRCKiCXqgQLIqrgejhsRv2guw2jI+rlrS2ylQqjqsjiHAVraCSpJ5kr4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmHCMUrWlpIciWUuvLLfdxZ7Sk2UkoGp0z31DPg+37M=;
 b=VBCLc8NwLzeGwEByHVffKwtHJy8TECNbynqTPAgQgEDFWQl5vLHMB/jpxEBxJDZu0+G8/JdINR/dMMFmXbbuSgzggo/zWRIF4ejIQgMI3uVYx4XbskCYIkl6WBqYFnUpHRzPVe8xQWb1DzPoVkfqVSJajlWV8YeWURVn7Uj3sPOFE4QMF64DCKfyf74MrvODpxNFdHeYB5465jUDm4tY1uAbOA3zrCmyGsgAhB9aCQTPWEYf1ytzNMx8LOmHTZXm+8TJWoA4sn3TxoEKokyXUUB9oCu2WB1iRNSRHxkTMpxFOxmpMqIwoVMzVtfjjoajUm1sY7t6NlJ7KlWc9Uuarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmHCMUrWlpIciWUuvLLfdxZ7Sk2UkoGp0z31DPg+37M=;
 b=EVBdJtSblRiV0mvgjXCQKdEvCYQN5dEevqRNKMaqPhCicAeJBI/Z1H331mHgDp0fzvklmm/b+wkzoFH169RTdj7x8a2GqjtrGtKihyz2WOeLZuytHs+iZ0KSQFytYm/XTDHTmA7HQSEnyFq/SBVJdCqVF7HS3f2mlxuxZKw5BMn+UO2CSemSWEbWkBlrc4Jqnx514P+JaqE1dd+sPPTnHqe9Vvhg3r6LASVvDr9/McCITwfeCBDSNZAoYHwqCdcJnbmT/OzszrddA5f7FX8wbXe1VyjS2A0g2CP+L2pFoVaG+rXHaC43STzHdh5EjE3dzi2LgRuvW+/NvDksrhe8rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <3c81cc33-9263-c958-243d-c0acbc476959@kalrayinc.com>
Date: Thu, 7 Dec 2023 11:11:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Yann Sionneau <ysionneau@kalrayinc.com>
Subject: regression in 6.1.yy branch: LTP test preadv03 fails
To: gregkh@linuxfoundation.org, Theodore Ts'o <tytso@mit.edu>, Andreas
 Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-us
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::15) To MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:13::5)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB1890:EE_|MR1P264MB3153:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e6b3a8-ad05-45e6-4f58-08dbf70ce0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqaeltN1rfhQWQfYhoTtuxMUh+vPm71VnfTDxC2k1M5UajqSFnSBbQXrWsJ70mqleFJ0z6ppRRn1loi9FcpXMpgXyKb1de4dTe1hr3IaG2D3AlE8zfljtlRdwaKIH0kbO8FyJng0bpYVBDmaGaRUYjnkQGro+AWiCHvCwYETl4hK6iAT6z9oQY0u4nId5S6kHnuEXxffz+GfeA8i93lvfY9ZVckrhDAKYVRl9b/INrobnRkUJFu0Y7nJj0XzXMphz90PTUWVCx2JT7c0DQBab2DaH/MaOaTrDk8llNwHyaZ+7eyv3TsKEHShzVRgySrHZmHR1OLJDVMKDoz8JTwfF7FuGFGu96yzEyvL3F3OQauYx3Sa7s6+94q2Y66g2TKBNzcBi+Em0Ac7etLa3GeCazsRwStn4Hoj7CikEjgVdY8H3UQ0idIWiTcJRdEmp1DgOf/VvuFB53u0uZEuMlN72eO73H3EVRjieFvvr10XglMyjVxEClWboyW62LQ+h28bSeXcG59IMFzxAlmN8VXME1rlh/QKj6fTToopHALyPE1ksNBXbWjn34g3Lrd5fpA9jKXkaPEgYg34rShW1knj3cFi5tiYnoCol3UoAVQSnCnhKaEucEcQQl6xDOdA3/T6QTs4goX9gUKMWHFS+Er680EpDtkcOruFC5N6uSrNCNwynoyL5bFRo7jkDwxEsgrc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39850400004)(136003)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(66899024)(83380400001)(41300700001)(36756003)(26005)(110136005)(19627235002)(316002)(86362001)(966005)(31696002)(8676002)(8936002)(4326008)(6486002)(66946007)(66556008)(66476007)(478600001)(6512007)(2906002)(5660300002)(2616005)(6506007)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VRzyu70fmsCmRZ+pTS8G1bEAbP3S0ObaU/3RdzScjvY1o3Emlkc0gUGBU99kolnosAP9LUb+AjYIUpRE8pIPZQ0GFK99ikqMSzNcOPNJ2NVmsUCdVDWNVx7Oeg0rneP2Z7VWhXIV8uDtFqZSZSEmEF52//b6mn7yEAJSEEbqOwlSjete0qji2hiuXn+SFuym+eMowvfca1xo0kBE2EWmVhCZCLOYV6XJxrQzfrnDtouSV2wJTwuyGID5nQX8kV/SQJDKC4yHg2rqXS6okwt7L2WEIfI+AtUZQ8I+Lf+LatJfRJMdax9GBFNBqG0rj2HX0CZtNJIzhn9PJkLBVU6SWEsHf/uAGS337kyV1QTHwVxLf/XkvabNp8AWunf+w8JPNsk/NBX823wTFH5t2DW4djle0pR2eAZGo8NmO9Y+aSqyzRyqhqLIinfOh52uCtm7G8ov5AMlcPCSvRqvD4zKWn7jxlxnNjpvUk0aoH+nKQWmKma6lH4JLPYp7QGhbIbOolvYQQO21gU2NVKCJYIzt4loHXtRNaJZFcLmp1n/NGZqgVNOg8FTsgmSrs7JJGYxom87YrEg/mD9P3gNp6zKe4o0KkLENJDcqD5IJ3zWm3EFjJod6RsCrmMOOAs5tOWlFhAhi0rG6RrxNzrqVAtZg2avvAWbUygiwdcy9Dx4aYrGGXAmqBtHAyQS+rckDJAapBE33FTrcFr64Ylc814yJTPtHieOXKuwsyfD4RT7OOQnJeopGO5Ns0VnFSBxmZ8JRN7OHlJC8BiFkD5PO/FJpzjbcZKNA2qSqGua8Sgy/r3fUg7iaxM1kBU7FMB3dgEfPfzZuMSWWIsGBcwhHsVNWx3Hm5BxXmWv2A+v+V+IKeOP7ugUq63uEtPbKWpc7XpBXvBgqo1l0FRQHNC7jz4/+PB/VvRWFEHGBEolXK1DdOC+c17Jg13y0aQczC1hAd+3
 lHrEYjMLNS/Rycyl/Q82XKHeYmO8mAhH88UItNl0JKNOokxllfVI5dwq5aQ0N9MfQPyN8/rzgUduo/R1b/cuhji+CGg8dZXtkirU8J5glcIhU5TplCDVws4pWwsuNt6V4DVHgcrXCr0d26Oi20jL/jRkTNVDAl2+XHFJId+8obRZRwO9NaS2JnBsMn8IfsJwcbbQGDkTZlVSVqaaDzYOF5QmPfUu40pWXM7GfxKQYaR6Q1qVZYnW/ehcXFf/tCuCo5tuT+o63lYGW2G1uYmalEmo6AckZVXI2yL+GOoqRGTz/dmfswUq+s29tN6aDAQYcy2xNjNcXA9q3IlRaJC+XElSthAzB67qXd/ULfizJJfuk64sWVkCcIjWgz0dNSjR2hPNYVIYo5qmsLD2MpFJP7nbogkDEYO3jGXQHCeXNqX3VjscaVSgYDfq67xSG7a3xvbX5t+vV8U7OFyIgGKOnfhXBS3IXiarPmWjNrWCEIQ6k0YyqZBlRVHXrZdN153wuOPzvHFpSj1FEnItPo+V+e1ex7cGlEO0gblF+kbhM9q3WZu5bkzQ4KG1ODXJ7sxnzpIRKDx4T71Lu7wXSW+80ZaAdRK03VghrJ0jv4VllHnCPf56yUW8RWqZt3Wh3hkDA/loxoRSmIThQinfz7yPxA==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e6b3a8-ad05-45e6-4f58-08dbf70ce0a5
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 10:11:28.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqWBWFvxNG4m1X0FgFqk8BO7Uts5IzyMX4SrOso11XRgr2qBaxB93xexDJOQUyo+QgZhvKVCE7b4uPf5tOxFJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3153
X-ALTERMIMEV2_out: done

Hello,

I noticed yesterday that LTP test preadv03 now fails since 6.1.64 (it 
also fails on 6.1.65).

6.6.4, 6.6.3, 6.5.0 and 6.2.0 seem to be unaffected.

I tested this on x86_64 and kvx arch (the latter is not upstream).

I can see some ext4 related commits on 6.1.64 and 6.1.65 changes, maybe 
it's related, therefore I add ext4 mailing list as CC.

I didn't run git bisect on this so far because I noticed building an 
x86_64 ubuntu kernel on my laptop was taking ages. Maybe someone is more 
used to dealing with this and can bisect this way faster than me.

How to reproduce:

```

git clone https://github.com/linux-test-project/ltp.git

cd ltp && make autotools && ./configure

make -j4

cd testcases/kernel/syscalls/preadv

sudo ./preadv03

```

On 6.1.64 x86_64 kernel for instance it gives:

```

ysionneau@KALRAY-LP238:~/dev/ltp/testcases/kernel/syscalls/preadv$ uname -a
Linux KALRAY-LP238 6.1.64-060164-generic #202311281737 SMP 
PREEMPT_DYNAMIC Tue Nov 28 18:22:03 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
ysionneau@KALRAY-LP238:~/dev/ltp/testcases/kernel/syscalls/preadv$ sudo 
./preadv03
tst_device.c:96: TINFO: Found free device 43 '/dev/loop43'
tst_test.c:1690: TINFO: LTP version: 20230929-193-g9de9ac6c1
tst_test.c:1574: TINFO: Timeout per run is 0h 00m 30s
tst_supported_fs_types.c:90: TINFO: Kernel supports ext2
tst_supported_fs_types.c:55: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports ext3
tst_supported_fs_types.c:55: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports ext4
tst_supported_fs_types.c:55: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports xfs
tst_supported_fs_types.c:51: TINFO: mkfs.xfs does not exist
tst_supported_fs_types.c:90: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:51: TINFO: mkfs.btrfs does not exist
tst_supported_fs_types.c:90: TINFO: Kernel supports vfat
tst_supported_fs_types.c:55: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports exfat
tst_supported_fs_types.c:51: TINFO: mkfs.exfat does not exist
tst_supported_fs_types.c:90: TINFO: Kernel supports ntfs
tst_supported_fs_types.c:55: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:157: TINFO: Skipping tmpfs as requested by the 
test
tst_test.c:1650: TINFO: === Testing on ext2 ===
tst_test.c:1105: TINFO: Formatting /dev/loop43 with ext2 opts='' extra 
opts=''
mke2fs 1.46.5 (30-Dec-2021)
tst_test.c:1119: TINFO: Mounting /dev/loop43 to 
/tmp/LTP_pretsQ0lS/mntpoint fstyp=ext2 flags=0
preadv03.c:102: TINFO: Using block size 512
preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
tst_test.c:1650: TINFO: === Testing on ext3 ===
tst_test.c:1105: TINFO: Formatting /dev/loop43 with ext3 opts='' extra 
opts=''
mke2fs 1.46.5 (30-Dec-2021)
tst_test.c:1119: TINFO: Mounting /dev/loop43 to 
/tmp/LTP_pretsQ0lS/mntpoint fstyp=ext3 flags=0
preadv03.c:102: TINFO: Using block size 512
preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
tst_test.c:1650: TINFO: === Testing on ext4 ===
tst_test.c:1105: TINFO: Formatting /dev/loop43 with ext4 opts='' extra 
opts=''
mke2fs 1.46.5 (30-Dec-2021)
tst_test.c:1119: TINFO: Mounting /dev/loop43 to 
/tmp/LTP_pretsQ0lS/mntpoint fstyp=ext4 flags=0
preadv03.c:102: TINFO: Using block size 512
preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
tst_test.c:1650: TINFO: === Testing on vfat ===
tst_test.c:1105: TINFO: Formatting /dev/loop43 with vfat opts='' extra 
opts=''
tst_test.c:1119: TINFO: Mounting /dev/loop43 to 
/tmp/LTP_pretsQ0lS/mntpoint fstyp=vfat flags=0
preadv03.c:102: TINFO: Using block size 512
preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with 
content 'a' expectedly
preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with 
content 'a' expectedly
preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with 
content 'b' expectedly
tst_test.c:1650: TINFO: === Testing on ntfs ===
tst_test.c:1105: TINFO: Formatting /dev/loop43 with ntfs opts='' extra 
opts=''
The partition start sector was not specified for /dev/loop43 and it 
could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop43 and it 
could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop43 and it could not 
be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 
'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
tst_test.c:1119: TINFO: Mounting /dev/loop43 to 
/tmp/LTP_pretsQ0lS/mntpoint fstyp=ntfs flags=0
tst_test.c:1119: TINFO: Trying FUSE...
preadv03.c:102: TINFO: Using block size 512
preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with 
content 'a' expectedly
preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with 
content 'a' expectedly
preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with 
content 'b' expectedly

Summary:
passed   6
failed   9
broken   0
skipped  0
warnings 0

```

Cheers,

-- 

Yann






