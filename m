Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5E21F7BD1
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jun 2020 18:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgFLQus (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Jun 2020 12:50:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgFLQus (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 12 Jun 2020 12:50:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CGY8tQ020097;
        Fri, 12 Jun 2020 12:50:42 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31mce2t80h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 12:50:42 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05CGjIA1009834;
        Fri, 12 Jun 2020 16:50:40 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 31g2s83nxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 16:50:40 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05CGnLAa590470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 16:49:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1DD25204F;
        Fri, 12 Jun 2020 16:50:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.93.125])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 415A752052;
        Fri, 12 Jun 2020 16:50:36 +0000 (GMT)
Subject: Re: upstream test error: BUG: using smp_processor_id() in preemptible
 code in ext4_mb_new_blocks
To:     Greg KH <gregkh@linuxfoundation.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Cc:     syzbot <syzbot+0113b9be6667b5b50840@syzkaller.appspotmail.com>
References: <0000000000007a16f705a7b1096d@google.com>
 <20200612121549.GA2603@kroah.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 12 Jun 2020 22:20:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612121549.GA2603@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200612165036.415A752052@d06av21.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_12:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 cotscore=-2147483648 suspectscore=0 priorityscore=1501 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120121
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> I am seeing this all over the place on Linus's tree right now:
> 
> [  +0.008563] BUG: using smp_processor_id() in preemptible [00000000] code: systemd/1
> [  +0.000011] caller is ext4_mb_new_blocks+0x2ac/0xc10
> [  +0.000002] CPU: 31 PID: 1 Comm: systemd Not tainted 5.7.0-14371-g25ae6195a4c7 #66
> [  +0.000002] Hardware name: Micro-Star International Co., Ltd. MS-7C59/Creator TRX40 (MS-7C59), BIOS 1.50 05/13/2020
> [  +0.000001] Call Trace:
> [  +0.000008]  dump_stack+0x57/0x70
> [  +0.000004]  debug_smp_processor_id.cold+0x4e/0x53
> [  +0.000001]  ext4_mb_new_blocks+0x2ac/0xc10
> [  +0.000004]  ? ext4_find_extent+0x3e8/0x450
> [  +0.000002]  ext4_ext_map_blocks+0x9f6/0x1b10
> [  +0.000003]  ? ext4_mark_iloc_dirty+0x60f/0xa50
> [  +0.000003]  ? __ext4_journal_get_write_access+0x2d/0x70
> [  +0.000004]  ext4_map_blocks+0x119/0x5a0
> [  +0.000004]  ext4_getblk+0x66/0x1c0
> [  +0.000003]  ext4_bread+0x26/0xc0
> [  +0.000002]  ext4_append+0x49/0xe0
> [  +0.000002]  ext4_mkdir+0x233/0x450
> [  +0.000005]  vfs_mkdir+0x11d/0x1b0
> [  +0.000003]  do_mkdirat+0x92/0x130
> [  +0.000004]  do_syscall_64+0x43/0x80
> [  +0.000004]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  +0.000003] RIP: 0033:0x7fef3df7a72b
> [  +0.000001] Code: Bad RIP value.
> [  +0.000001] RSP: 002b:00007ffdb4eba0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
> [  +0.000003] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fef3df7a72b
> [  +0.000001] RDX: 0000000000000000 RSI: 00000000000001c0 RDI: 0000563b11cf26e0
> [  +0.000001] RBP: 0000563b11cf2731 R08: 000000000000000d R09: 0000000000000002
> [  +0.000000] R10: 11175e4331068ed5 R11: 0000000000000246 R12: 0000563b11cf26e0
> [  +0.000002] R13: 00007fef3e019c20 R14: 00007ffdb4eba0f0 R15: 8421084210842109
> 
> Just a constant stream of them.
> 
> There's a few other fun:
> 
> [  +0.453222] BUG: unable to handle page fault for address: ffffb59cc2719000
> [  +0.000004] #PF: supervisor write access in kernel mode
> [  +0.000001] #PF: error_code(0x000b) - reserved bit violation
> 
> messages at times, but I don't think that's an ext4 issue, but rather
> something in the sound stack...
> 
> EXT4 developers, any hints/patches to try?
> 

Below patch should fix the ext4 issue coming from ext4_mb_new_blocks().

https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=811985365378df01386c3cfb7ff716e74ca376d5

Not sure about the second one though.

-ritesh

