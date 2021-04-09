Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2C13594F2
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Apr 2021 07:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhDIFsG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 01:48:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229613AbhDIFsC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 01:48:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1395XYKP061441;
        Fri, 9 Apr 2021 01:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=m8k8JqU5GcKtPlR1dzQ/5tJECYdaRdUSpLxKkpfx3DM=;
 b=hih5TJKgovOSRJVJRzvJmiDTANlR8zQTiAAVe5R14xXKtcnOMc1G/kAxm/kWxLIiytO8
 uUNatpG5v0GavpKYmFEkPN6qWji5m6At3JshzDCh1Y4YFUP/8/seHm59f4r79e9y8rhV
 PrUzmj4TOzfTKEstWj2vOUpn32fITxtNZIiTf/jExojh+rBKTgLgkHXClwCMRcIGrxt8
 177AIb7Zy2UciaI9rxoWnJKYS6lsEs4W0wzHOyq6zR0+buz0lm1AqwQ6CY94qKpSk4cW
 2ml+KULI1a2jxflGKmnH4dL2JRK24VsH6uOQn3EQtqDPsDnu+BNcohXBuzfBsnjuG8C+ xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37rwf2431m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 01:47:39 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1395ldt1105098;
        Fri, 9 Apr 2021 01:47:39 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37rwf24319-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 01:47:39 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1395lbWl013460;
        Fri, 9 Apr 2021 05:47:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 37rvbwa66q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 05:47:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1395lZ9a38207772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Apr 2021 05:47:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E64EA42042;
        Fri,  9 Apr 2021 05:47:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 855584203F;
        Fri,  9 Apr 2021 05:47:34 +0000 (GMT)
Received: from localhost (unknown [9.85.70.102])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Apr 2021 05:47:34 +0000 (GMT)
Date:   Fri, 9 Apr 2021 11:17:33 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     adilger@dilger.ca, tytso@mit.edu, linux-ext4@vger.kernel.org,
        jack@suse.cz, linux-kernel@vger.kernel.org,
        baoyou.xie@alibaba-inc.com
Subject: Re: [PATCH] ext4: add a configurable parameter to prevent endless
 loop in ext4_mb_discard_group_p
Message-ID: <20210409054733.avv3ofqpka4m6xe5@riteshh-domain>
References: <f16d7afa-3799-f523-3c19-9ceb9427ff6e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f16d7afa-3799-f523-3c19-9ceb9427ff6e@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y6sTmaWE4PXyMNh8R1A4LaGiUiMZdRqa
X-Proofpoint-ORIG-GUID: J59IlW6J9eVYVfe5xDi8men53wquNAI3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_03:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090041
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/04/09 02:50AM, Wen Yang wrote:
> > On Apr 7, 2021, at 5:16 AM, riteshh <riteshh@linux.ibm.com> wrote:
> >>
> >> On 21/04/07 03:01PM, Wen Yang wrote:
> >>> From: Wen Yang <simon.wy@alibaba-inc.com>
> >>>
> >>> The kworker has occupied 100% of the CPU for several days:
> >>> PID USER  PR  NI VIRT RES SHR S  %CPU  %MEM TIME+  COMMAND
> >>> 68086 root 20 0  0    0   0   R  100.0 0.0  9718:18 kworker/u64:11
> >>>
> >>> And the stack obtained through sysrq is as follows:
> >>> [20613144.850426] task: ffff8800b5e08000 task.stack: ffffc9001342c000
> >>> [20613144.850438] Call Trace:
> >>> [20613144.850439] [<ffffffffa0244209>]ext4_mb_new_blocks+0x429/0x550
> [ext4]
> >>> [20613144.850439]  [<ffffffffa02389ae>] ext4_ext_map_blocks+0xb5e/0xf30
> [ext4]
> >>> [20613144.850441]  [<ffffffffa0204b52>] ext4_map_blocks+0x172/0x620
> [ext4]
> >>> [20613144.850442]  [<ffffffffa0208675>] ext4_writepages+0x7e5/0xf00
> [ext4]
> >>> [20613144.850443]  [<ffffffff811c487e>] do_writepages+0x1e/0x30
> >>> [20613144.850444]  [<ffffffff81280265>]
> __writeback_single_inode+0x45/0x320
> >>> [20613144.850444]  [<ffffffff81280ab2>] writeback_sb_inodes+0x272/0x600
> >>> [20613144.850445]  [<ffffffff81280ed2>] __writeback_inodes_wb+0x92/0xc0
> >>> [20613144.850445]  [<ffffffff81281238>] wb_writeback+0x268/0x300
> >>> [20613144.850446]  [<ffffffff812819f4>] wb_workfn+0xb4/0x380
> >>> [20613144.850447]  [<ffffffff810a5dc9>] process_one_work+0x189/0x420
> >>> [20613144.850447]  [<ffffffff810a60ae>] worker_thread+0x4e/0x4b0
> >>>
> >>> The cpu resources of the cloud server are precious, and the server
> >>> cannot be restarted after running for a long time, so a configuration
> >>> parameter is added to prevent this endless loop.
> >>
> >> Strange, if there is a endless loop here. Then I would definitely see
> >> if there is any accounting problem in pa->pa_count. Otherwise busy=1
> >> should not be set everytime. ext4_mb_show_pa() function may help debug
> this.
> >>
> >> If yes, then that means there always exists either a file preallocation
> >> or a group preallocation. Maybe it is possible, in some use case.
> >> Others may know of such use case, if any.
>
> > If this code is broken, then it doesn't make sense to me that we would
> > leave it in the "run forever" state after the patch, and require a sysfs
> > tunable to be set to have a properly working system?
>
> > Is there anything particularly strange about the workload/system that
> > might cause this?  Filesystem is very full, memory is very low, etc?
>
> Hi Ritesh and Andreas,
>
> Thank you for your reply. Since there is still a faulty machine, we have
> analyzed it again and found it is indeed a very special case:
>
>
> crash> struct ext4_group_info ffff8813bb5f72d0
> struct ext4_group_info {
>   bb_state = 0,
>   bb_free_root = {
>     rb_node = 0x0
>   },
>   bb_first_free = 1681,
>   bb_free = 0,

Not related to this issue, but above two variables values doesn't looks
consistent.

>   bb_fragments = 0,
>   bb_largest_free_order = -1,
>   bb_prealloc_list = {
>     next = 0xffff880268291d78,
>     prev = 0xffff880268291d78     ---> *** The list is empty
>   },

Ok. So when you collected the dump this list was empty.

>   alloc_sem = {
>     count = {
>       counter = 0
>     },
>     wait_list = {
>       next = 0xffff8813bb5f7308,
>       prev = 0xffff8813bb5f7308
>     },
>     wait_lock = {
>       raw_lock = {
>         {
>           val = {
>             counter = 0
>           },
>           {
>             locked = 0 '\000',
>             pending = 0 '\000'
>           },
>           {
>             locked_pending = 0,
>             tail = 0
>           }
>         }
>       }
>     },
>     osq = {
>       tail = {
>         counter = 0
>       }
>     },
>     owner = 0x0
>   },
>   bb_counters = 0xffff8813bb5f7328
> }
> crash>
>
>
> crash> list 0xffff880268291d78  -l ext4_prealloc_space.pa_group_list -s

No point of doing this I guess, since the list anyway is empty.
What you may be seeing below is some garbage data.

> ext4_prealloc_space.pa_count
> ffff880268291d78
>   pa_count = {
>     counter = 1      ---> ****pa->pa_count
>   }
> ffff8813bb5f72f0
>   pa_count = {
>     counter = -30701
>   }

I guess, since list is empty and you are seeing garbage hence counter value
of above node looks weird.

>
>
> crash> struct -xo  ext4_prealloc_space
> struct ext4_prealloc_space {
>    [0x0] struct list_head pa_inode_list;
>   [0x10] struct list_head pa_group_list;
>          union {
>              struct list_head pa_tmp_list;
>              struct callback_head pa_rcu;
>   [0x20] } u;
>   [0x30] spinlock_t pa_lock;
>   [0x34] atomic_t pa_count;
>   [0x38] unsigned int pa_deleted;
>   [0x40] ext4_fsblk_t pa_pstart;
>   [0x48] ext4_lblk_t pa_lstart;
>   [0x4c] ext4_grpblk_t pa_len;
>   [0x50] ext4_grpblk_t pa_free;
>   [0x54] unsigned short pa_type;
>   [0x58] spinlock_t *pa_obj_lock;
>   [0x60] struct inode *pa_inode;
> }
> SIZE: 0x68
>
>
> crash> rd 0xffff880268291d68 20
> ffff880268291d68:  ffff881822f8a4c8 ffff881822f8a4c8   ..."......."....
> ffff880268291d78:  ffff8813bb5f72f0 ffff8813bb5f72f0   .r_......r_.....
> ffff880268291d88:  0000000000001000 ffff880db2371000   ..........7.....
> ffff880268291d98:  0000000100000001 0000000000000000   ................
> ffff880268291da8:  0000000000029c39 0000001700000c41   9.......A.......
> ffff880268291db8:  ffff000000000016 ffff881822f8a4d8   ..........."....
> ffff880268291dc8:  ffff881822f8a268 ffff880268291af8   h.."......)h....
> ffff880268291dd8:  ffff880268291dd0 ffffea00069a07c0   ..)h............
> ffff880268291de8:  00000000004d5bb7 0000000000001000   .[M.............
> ffff880268291df8:  ffff8801a681f000 0000000000000000   ................

I am not sure what was intention behind above data.

>
>
>
> Before "goto repeat", it is necessary to check whether grp->bb_prealloc_list
> is empty.
> This patch may fix it.
> Please kindly give us your comments and suggestions.
> Thanks.
>
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 99bf091..8082e2d 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4290,7 +4290,7 @@ static void ext4_mb_new_preallocation(struct
> ext4_allocation_context *ac)
>         free_total += free;
>
>         /* if we still need more blocks and some PAs were used, try again */
> -       if (free_total < needed && busy) {
> +       if (free_total < needed && busy &&
> !list_empty(&grp->bb_prealloc_list)) {
>                 ext4_unlock_group(sb, group);
>                 cond_resched();
>                 busy = 0;
>
>

Not really. Since we anyway check busy variable too. Which is only set when the
bb_prealloc_list is actually not empty and have some busy pa's in it.

What may explain this scenario is.
1. That this writeback thread which is trying to write the dirty data, tries to
   free up some blocks but since the free_total < needed and busy == 1,
   -> so it released the group lock (ext4_unlock_group()) and make busy = 0.
   -> at this point there could be something running in parallel which may take
   the group lock and allocate those PAs which were released by this process.

2. writeback thread again comes and tries to check if the bb_prealloc_list is
   empty and it is not since some other thread again allocated something which
   this guys freed for itself.


Tell me -
1. How low was free space when you hit this issue.
2. How big was your FS? How many groups?
3. Is there some backgroud worker constantly running who is doing some
   allocations. Do you have a single cpu system?
   On this as soon writeback thread release the group lock, the other process
   gets schedule in, takes the lock and does some group preallocations from the
   same group from which wb thread freed some blocks.
   And so wb thread keeps looping.
4. Is this a real workload or is it some sort of simulated tests?

Maybe if you explain your above setup/environment better, that will help in
debugging on why this writeback thread was constantly running/enlessly-looping
for days

-ritesh

