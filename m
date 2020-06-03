Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205A31ECD29
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jun 2020 12:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgFCKHI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Jun 2020 06:07:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgFCKHH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Jun 2020 06:07:07 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 053A3CKf015509;
        Wed, 3 Jun 2020 06:06:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31e3w5t93y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 06:06:56 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 053A4WIX021346;
        Wed, 3 Jun 2020 06:06:56 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31e3w5t93f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 06:06:56 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 053A02EZ018295;
        Wed, 3 Jun 2020 10:06:54 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 31bf47ysjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 10:06:54 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 053A6qVo45350920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jun 2020 10:06:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43E3552059;
        Wed,  3 Jun 2020 10:06:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.36.151])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BE4A452054;
        Wed,  3 Jun 2020 10:06:49 +0000 (GMT)
Subject: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible [ADDR] code: syz-fuzzer/6792
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
References: <20200602145256.9236-1-hdanton@sina.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 3 Jun 2020 15:36:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200602145256.9236-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200603100649.BE4A452054@d06av21.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_06:2020-06-02,2020-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1015 adultscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030074
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 6/2/20 8:22 PM, Hillf Danton wrote:
> 
> Tue, 02 Jun 2020 04:20:16 -0700
>> syzbot found the following crash on:
>>
>> HEAD commit:    0e21d462 Add linux-next specific files for 20200602
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=127233ee100000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ecc1aef35f550ee3
>> dashboard link: https://syzkaller.appspot.com/bug?extid=82f324bb69744c5f6969
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com
>>
>> BUG: using smp_processor_id() in preemptible [00000000] code: syz-fuzzer/6792
>> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> 
> Fix 42f56b7a4a7d ("ext4: mballoc: introduce pcpu seqcnt for freeing PA
> to improve ENOSPC handling") by redefining discard_pa_seq to be a simple
> regular sequence counter to axe the need of percpu operation.

Why remove percpu seqcnt? IIUC, percpu are much better in case of a 
multi-threaded use case which could run and allocate blocks in parallel.
Whereas a updating a simple variable across different cpus may lead to 
cacheline bouncing problem.
Since in this case we can very well have a use case of multiple threads 
trying to allocate blocks at the same time, so why change this to a 
simple seqcnt from percpu seqcnt?

-ritesh
