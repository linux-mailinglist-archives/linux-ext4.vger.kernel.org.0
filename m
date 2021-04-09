Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D59359D53
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Apr 2021 13:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhDIL2j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 07:28:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233637AbhDIL2i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 07:28:38 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 139B2wOr136552;
        Fri, 9 Apr 2021 07:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=M/X1HLUVPC662H2WuDNli3rRjLixND6jpXMQ3SGmGp8=;
 b=BXc7y9ZVoZHAmor1znE3WgDW0bMu9cE21EI0bNH8n4fcQprrAPQ8e4kE3RYzP7wUrozL
 6vYgpfSSgXVcbPLxlorv07djcg3cvYfVQuKBf+4OyNaFAuXhD4Ktl1PKXR7dD5Rt0yfG
 XTu5yfQE3H964drTHT5nuWcqZMmLkQ/IM6M8+SQS8jAodlhjlHA+laiwA4AIL0XXyMWl
 beTY7s34A38TJ5flG9TrGE4m9ObPs4rKlyvaqN1IisxX9ur1tsc+2DGQCVK497QL846v
 pcpcQfbVdpyUKRBxCq8KcyIPSuY3vmL1PNprG+kHpK6C5+5rk54djGP0z2b6tg5iNDiy XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvpw9j4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 07:28:15 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 139B3G3B137592;
        Fri, 9 Apr 2021 07:28:15 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvpw9j42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 07:28:14 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 139BRuxu001975;
        Fri, 9 Apr 2021 11:28:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 37rvc1h9qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 11:28:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 139BRnJR33620438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Apr 2021 11:27:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 493A8A4054;
        Fri,  9 Apr 2021 11:28:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5531A405C;
        Fri,  9 Apr 2021 11:28:09 +0000 (GMT)
Received: from localhost (unknown [9.85.70.102])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Apr 2021 11:28:09 +0000 (GMT)
Date:   Fri, 9 Apr 2021 16:58:09 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Wen Yang <wenyang@linux.alibaba.com>, adilger@dilger.ca,
        tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, baoyou.xie@alibaba-inc.com
Subject: Re: [PATCH] ext4: add a configurable parameter to prevent endless
 loop in ext4_mb_discard_group_p
Message-ID: <20210409112809.n4d6kar62zwzr6af@riteshh-domain>
References: <f16d7afa-3799-f523-3c19-9ceb9427ff6e@linux.alibaba.com>
 <20210409054733.avv3ofqpka4m6xe5@riteshh-domain>
 <20210409101811.GB20833@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409101811.GB20833@quack2.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w-WGFj3QsyYxPskAxtbyvTE61KTHvx3Q
X-Proofpoint-GUID: Iu6q2NcVvLi76SvglBLqgskT11yqGUxo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_05:2021-04-09,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090081
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/04/09 12:18PM, Jan Kara wrote:
> On Fri 09-04-21 11:17:33, riteshh wrote:
> > On 21/04/09 02:50AM, Wen Yang wrote:
> > > > On Apr 7, 2021, at 5:16 AM, riteshh <riteshh@linux.ibm.com> wrote:
> > > >>
> > > >> On 21/04/07 03:01PM, Wen Yang wrote:
> > > >>> From: Wen Yang <simon.wy@alibaba-inc.com>
> > > >>>
> > > >>> The kworker has occupied 100% of the CPU for several days:
> > > >>> PID USER  PR  NI VIRT RES SHR S  %CPU  %MEM TIME+  COMMAND
> > > >>> 68086 root 20 0  0    0   0   R  100.0 0.0  9718:18 kworker/u64:11
> > > >>>
> > > >>> And the stack obtained through sysrq is as follows:
> > > >>> [20613144.850426] task: ffff8800b5e08000 task.stack: ffffc9001342c000
> > > >>> [20613144.850438] Call Trace:
> > > >>> [20613144.850439] [<ffffffffa0244209>]ext4_mb_new_blocks+0x429/0x550
> > > [ext4]
> > > >>> [20613144.850439]  [<ffffffffa02389ae>] ext4_ext_map_blocks+0xb5e/0xf30
> > > [ext4]
> > > >>> [20613144.850441]  [<ffffffffa0204b52>] ext4_map_blocks+0x172/0x620
> > > [ext4]
> > > >>> [20613144.850442]  [<ffffffffa0208675>] ext4_writepages+0x7e5/0xf00
> > > [ext4]
> > > >>> [20613144.850443]  [<ffffffff811c487e>] do_writepages+0x1e/0x30
> > > >>> [20613144.850444]  [<ffffffff81280265>]
> > > __writeback_single_inode+0x45/0x320
> > > >>> [20613144.850444]  [<ffffffff81280ab2>] writeback_sb_inodes+0x272/0x600
> > > >>> [20613144.850445]  [<ffffffff81280ed2>] __writeback_inodes_wb+0x92/0xc0
> > > >>> [20613144.850445]  [<ffffffff81281238>] wb_writeback+0x268/0x300
> > > >>> [20613144.850446]  [<ffffffff812819f4>] wb_workfn+0xb4/0x380
> > > >>> [20613144.850447]  [<ffffffff810a5dc9>] process_one_work+0x189/0x420
> > > >>> [20613144.850447]  [<ffffffff810a60ae>] worker_thread+0x4e/0x4b0
> > > >>>
> > > >>> The cpu resources of the cloud server are precious, and the server
> > > >>> cannot be restarted after running for a long time, so a configuration
> > > >>> parameter is added to prevent this endless loop.
> > > >>
> > > >> Strange, if there is a endless loop here. Then I would definitely see
> > > >> if there is any accounting problem in pa->pa_count. Otherwise busy=1
> > > >> should not be set everytime. ext4_mb_show_pa() function may help debug
> > > this.
> > > >>
> > > >> If yes, then that means there always exists either a file preallocation
> > > >> or a group preallocation. Maybe it is possible, in some use case.
> > > >> Others may know of such use case, if any.
> > >
> > > > If this code is broken, then it doesn't make sense to me that we would
> > > > leave it in the "run forever" state after the patch, and require a sysfs
> > > > tunable to be set to have a properly working system?
> > >
> > > > Is there anything particularly strange about the workload/system that
> > > > might cause this?  Filesystem is very full, memory is very low, etc?
> > >
> > > Hi Ritesh and Andreas,
> > >
> > > Thank you for your reply. Since there is still a faulty machine, we have
> > > analyzed it again and found it is indeed a very special case:
> > >
> > >
> > > crash> struct ext4_group_info ffff8813bb5f72d0
> > > struct ext4_group_info {
> > >   bb_state = 0,
> > >   bb_free_root = {
> > >     rb_node = 0x0
> > >   },
> > >   bb_first_free = 1681,
> > >   bb_free = 0,
> >
> > Not related to this issue, but above two variables values doesn't looks
> > consistent.
> >
> > >   bb_fragments = 0,
> > >   bb_largest_free_order = -1,
> > >   bb_prealloc_list = {
> > >     next = 0xffff880268291d78,
> > >     prev = 0xffff880268291d78     ---> *** The list is empty
> > >   },
> >
> > Ok. So when you collected the dump this list was empty.
>
> No, it is not empty. It has a single element. Note that the structure is at
> ffff8813bb5f72d0 so the pointers would have to be like ffff8813bb5f7xxx.

Errr, yes right. So the list is not empty.
But I guess the other arguments discussed in that mail should still be valid.

-ritesh

