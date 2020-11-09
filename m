Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5FA2AC6B3
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Nov 2020 22:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgKIVMF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Nov 2020 16:12:05 -0500
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com ([40.107.237.49]:45312
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbgKIVMF (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Nov 2020 16:12:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+5YF3ZU9fDD6EDrUvwjvy866HCOvdZ2hIhbVc4lH5KuJKLUplxzPW5DXCaE95Go8nxkAcacG/xbO3rz9heFx6F9+NUMbfr/lLSxvNNiJoXVCP1TtgZy76QZwYmP7GtJXXIcyA5U2fMWJRQzYiTe5cYVbu+3AylgrVrqvPFI9DRZX0dhG6HlfEHJyjKZ4Bxxm3qowWu9EfIKEE30Zb093KLC0p85l18GzSfig/uzcfxI1mHSkPenf81BFGrydBzXIR/ctsclh+h2mhS+gJYkhnVpnNmfhD9HJNAq0PVsaVH/ZI5U7BGnfUXGZrjidffVraSABv+MD2f8UZPkKS0GlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDE3fbnPX2b0ros2/4loJxgpHJJpe1egOmkypIIMjUw=;
 b=gvtXs/DkvwYQTyp0LNITJSiz/0pqbsOYY0raocN8d6RsoOHtX4KoEKEmGFDW2BnkZdPBZiS1AYN3+FvvjP/82tjM96vS8FgPTTJ3K+VSI5sKFbQmN0GNRNOz075x4CcMoJhNPUrB6aev8qFj+J8DlpxjjyUMJlYWqX6mBfoiUsj8W3Xo+mynIbVmDgYMi5/VMIHwkw7/tywYKYeldog26SSDtaEZDu2DIcWeEaHhQqXIYHKU4N/DcvyT3ClASg511wrh8HOFlrt078seNW+hPoplVhFsPaIP6ek553T626cF7GO4Q4zMZmGrsxrGxcNcUSEzy6PIvC4zCUw40SzJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDE3fbnPX2b0ros2/4loJxgpHJJpe1egOmkypIIMjUw=;
 b=c5NyDzLIXZvFHJMDa4rmEuGwZJfUcca9DWGZjMkK/xtOhtlP1/aVb2iCnzF9aSlf79IC3yAYk6zSBzWe7r0nKlXYVQ+O9+0nCydnAdr0BAlZmLJyzbhigudVT6T0Ry8rBozjcmlMxRBYFuaGCI+CZNZE8Yxqstvn+Vapt9ku2og=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SA2PR11MB5116.namprd11.prod.outlook.com (2603:10b6:806:fa::9)
 by SN6PR11MB3197.namprd11.prod.outlook.com (2603:10b6:805:c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 21:12:01 +0000
Received: from SA2PR11MB5116.namprd11.prod.outlook.com
 ([fe80::fcc7:66a3:e4c3:6069]) by SA2PR11MB5116.namprd11.prod.outlook.com
 ([fe80::fcc7:66a3:e4c3:6069%6]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 21:12:01 +0000
To:     linux-ext4@vger.kernel.org
From:   Chris Friesen <chris.friesen@windriver.com>
Subject: looking for assistance with jbd2 (and other processes) hung trying to
 write to disk
Message-ID: <17a059de-6e95-ef97-6e0a-5e52af1b9a04@windriver.com>
Date:   Mon, 9 Nov 2020 15:11:58 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.64.76.237]
X-ClientProxiedBy: BYAPR07CA0086.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::27) To SA2PR11MB5116.namprd11.prod.outlook.com
 (2603:10b6:806:fa::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.5] (70.64.76.237) by BYAPR07CA0086.namprd07.prod.outlook.com (2603:10b6:a03:12b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend Transport; Mon, 9 Nov 2020 21:12:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99699872-53fb-4ed1-58f2-08d884f419c7
X-MS-TrafficTypeDiagnostic: SN6PR11MB3197:
X-Microsoft-Antispam-PRVS: <SN6PR11MB3197666862A06722B6E8A69BF6EA0@SN6PR11MB3197.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZXhG3esDN1TUPu3CyyChwEBBcnstN9k8dYQ7HX/u+SEY70K55pUzVOkaDsXaM5bKoIxSWtxnvATjSdFUHAEFU4du+DVRfw361HD7DKtt2X2X2ECI46Bpg8O+JtvSB+Zdn7PsmRt5ztBrEWciZni9QCLeFOzzz+HYVlO6HxSli+JRZWA7vmjNF0Tnca/kvxMo4q0+JWIQcHr6gqmQOeq5kSov+2jWBrywqPOr3HmWJ0bY5JCMTe4jWsGelStlqjk4PktZ6+9RBG4pksuWmL5+FiNvlvssVlPltX7ZvUMkt8OnJl333EGY6XS8hN+uduCEh8kMDhIYh8H2/AZ7+3Fx5/ojQpuxCuwEK0a7Gkz9FdFhK1hUu2Y4IXcEFhOGtFlU4iQdN6GxgZIdZ20meDiIbx1uEpkJ2ANMef2ITnMkWqVF05htOspHwpJj79VD+2KK+HmkREkXpqK1is4MB+4Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5116.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(186003)(44832011)(31696002)(956004)(16526019)(36756003)(2616005)(86362001)(31686004)(16576012)(966005)(66946007)(52116002)(66476007)(6486002)(5660300002)(66556008)(2906002)(8936002)(6916009)(83380400001)(8676002)(26005)(478600001)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ivCyYVZDV1DSnTHvEFa6PdL+xZmwr156UNqlpVOiWfMLLMKUE1UYW6Psgt+24xXIKrtoZEl5N6HGBh26R54l4I9/CPWP4hf1oLBKiIJZaHw31MvyIwQrcQDyKUVaLXCyto66fglHQc+r4mEsicyyr8esFrMuK20k4zSWcx1yERGUb23plMNqx4qw9FEEMj7tvVLzI7L0OeE+RcpkqS1uyOUo60hhbNkl6suUXbScHwLUuMqdpNkqTYJ2gW+0uc/g3jhfc7UqWroMiChTTgr1U/FL7qn9+P1EUdn4uAdVUCSYzA67uvv52Fm09HCvZ/RUquF1FrC56DI0IGx1NsUfueJ2X6XE0hPxVDUCeTje9fFZt4yWuIfSzELVzhUWF2sFLPmzRspVcLS+J7idQlz+3J5QP8Rcyv4NeArPCwBiu7MGr9kpc+ZR+uAC569jxsDaBVh3fsr0PnxsghkYJLQO1TFnWQz/mxPgZQhtvh4GyqpZi7WNseQqiVSU6ojsMtD/L949yJSqdKbOYKpjo+rT7zlSs0wRtuh6qLFPOofgiSti5WVE7T3Iqo0tPvfNdp5mfcZkbHQ3ZZzoemjtAjEY81o7pAcxitZiay9HEIX0S13cKP3JnShxrOM1sJHoZxD4b0hZnjMedoHkKMyCiMySHg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99699872-53fb-4ed1-58f2-08d884f419c7
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 21:12:01.6727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8m0xNbR8orgpiOVoucQ68y1XMpOwLXMzwGCGXP/wTVKuUglLJoQogRKERHsxImrB7/J5Om8H5I/eSxWFTi68DfA0Gk8xUk2P5L1kGYSSzdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3197
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

I'm running a 3.10.0-1127.rt56.1093 CentOS kernel.  I realize you don't 
support this particular kernel but I'm hoping for some general pointers.

I've got a system with four "housekeeping" CPUs, with rcu_nocbs and 
hohz_full used to reduce system overhead on the "application" CPUs, with 
four CPUs set as "isolcpus" to try and isolate them even further.  I 
have a crashdump vmcore file from a softdog expiry when the process that 
pets the softdog hung trying to write to /dev/log after the unix socket 
backlog had been reached.

I can see a "jbd2/nvme2n1p4-" process that appears to be hung for over 9 
minutes waiting to commit a transaction.  /dev/nvme2n1p4 corresponds to 
the root filesystem.  The "ps" and "bt" output from the crashdump are 
below.  syslog-ng is also blocked waiting on filesystem access, and 
there are other tasks also blocked on disk, including a few jbd2 tasks 
that are associated with device mapper.

Can anyone give some suggestions on how to track down what's causing the 
delay here?  I suspect there's a race condition somewhere similar to 
what happened with https://access.redhat.com/solutions/3226391, although 
that one was specific to device-mapper and the root filesystem here is 
directly on the nvme device.

Any suggestions would be appreciated.

Additional info below:

crash> ps -m 930
[0 00:09:11.694] [UN]  PID: 930    TASK: ffffa14b5f9032c0  CPU: 1 
COMMAND: "jbd2/nvme2n1p4-"

crash> bt 930
PID: 930    TASK: ffffa14b5f9032c0  CPU: 1   COMMAND: "jbd2/nvme2n1p4-"
  #0 [ffffa14b5ff0ba20] __schedule at ffffffffafe1b959
  #1 [ffffa14b5ff0bab0] schedule at ffffffffafe1be80
  #2 [ffffa14b5ff0bac8] schedule_timeout at ffffffffafe19d4c
  #3 [ffffa14b5ff0bb70] io_schedule_timeout at ffffffffafe1ab6d
  #4 [ffffa14b5ff0bba0] io_schedule at ffffffffafe1ac08
  #5 [ffffa14b5ff0bbb0] bit_wait_io at ffffffffafe1a561
  #6 [ffffa14b5ff0bbc8] __wait_on_bit at ffffffffafe1a087
  #7 [ffffa14b5ff0bc08] out_of_line_wait_on_bit at ffffffffafe1a1f1
  #8 [ffffa14b5ff0bc80] __wait_on_buffer at ffffffffaf85068a
  #9 [ffffa14b5ff0bc90] jbd2_journal_commit_transaction at 
ffffffffc0e543fc [jbd2]
#10 [ffffa14b5ff0be48] kjournald2 at ffffffffc0e5a6ad [jbd2]
#11 [ffffa14b5ff0bec8] kthread at ffffffffaf6ad781
#12 [ffffa14b5ff0bf50] ret_from_fork_nospec_begin at ffffffffafe1fe5d

Possibly of interest, syslog-ng is also blocked waiting on filesystem 
access:

crash> bt 1912
PID: 1912   TASK: ffffa14b62dc2610  CPU: 1   COMMAND: "syslog-ng"
  #0 [ffffa14b635b7980] __schedule at ffffffffafe1b959
  #1 [ffffa14b635b7a10] schedule at ffffffffafe1be80
  #2 [ffffa14b635b7a28] schedule_timeout at ffffffffafe19d4c
  #3 [ffffa14b635b7ad0] io_schedule_timeout at ffffffffafe1ab6d
  #4 [ffffa14b635b7b00] io_schedule at ffffffffafe1ac08
  #5 [ffffa14b635b7b10] bit_wait_io at ffffffffafe1a561
  #6 [ffffa14b635b7b28] __wait_on_bit at ffffffffafe1a087
  #7 [ffffa14b635b7b68] out_of_line_wait_on_bit at ffffffffafe1a1f1
  #8 [ffffa14b635b7be0] do_get_write_access at ffffffffc0e51e94 [jbd2]
  #9 [ffffa14b635b7c80] jbd2_journal_get_write_access at 
ffffffffc0e521b7 [jbd2]
#10 [ffffa14b635b7ca0] __ext4_journal_get_write_access at 
ffffffffc0eb8e31 [ext4]
#11 [ffffa14b635b7cd0] ext4_reserve_inode_write at ffffffffc0e87fa0 [ext4]
#12 [ffffa14b635b7d00] ext4_mark_inode_dirty at ffffffffc0e8801e [ext4]
#13 [ffffa14b635b7d58] ext4_dirty_inode at ffffffffc0e8bc40 [ext4]
#14 [ffffa14b635b7d78] __mark_inode_dirty at ffffffffaf84855d
#15 [ffffa14b635b7da8] ext4_setattr at ffffffffc0e8b558 [ext4]
#16 [ffffa14b635b7e18] notify_change at ffffffffaf8363fc
#17 [ffffa14b635b7e60] chown_common at ffffffffaf8128ac
#18 [ffffa14b635b7f08] sys_fchown at ffffffffaf813fb7
#19 [ffffa14b635b7f50] tracesys at ffffffffafe202a8 (via system_call)

One of the hung jbd2 tasks associated with device mapper:

crash> bt 1489
PID: 1489   TASK: ffffa14b641f0000  CPU: 1   COMMAND: "jbd2/dm-0-8"
  #0 [ffffa14b5fab7a20] __schedule at ffffffffafe1b959
  #1 [ffffa14b5fab7ab0] schedule at ffffffffafe1be80
  #2 [ffffa14b5fab7ac8] schedule_timeout at ffffffffafe19d4c
  #3 [ffffa14b5fab7b70] io_schedule_timeout at ffffffffafe1ab6d
  #4 [ffffa14b5fab7ba0] io_schedule at ffffffffafe1ac08
  #5 [ffffa14b5fab7bb0] bit_wait_io at ffffffffafe1a561
  #6 [ffffa14b5fab7bc8] __wait_on_bit at ffffffffafe1a087
  #7 [ffffa14b5fab7c08] out_of_line_wait_on_bit at ffffffffafe1a1f1
  #8 [ffffa14b5fab7c80] __wait_on_buffer at ffffffffaf85068a
  #9 [ffffa14b5fab7c90] jbd2_journal_commit_transaction at 
ffffffffc0e543fc [jbd2]
#10 [ffffa14b5fab7e48] kjournald2 at ffffffffc0e5a6ad [jbd2]
#11 [ffffa14b5fab7ec8] kthread at ffffffffaf6ad781
#12 [ffffa14b5fab7f50] ret_from_fork_nospec_begin at ffffffffafe1fe5d

Thanks,

Chris
