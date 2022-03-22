Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB844E3809
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Mar 2022 05:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbiCVEnK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Mar 2022 00:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiCVEnJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Mar 2022 00:43:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ADA7B10F;
        Mon, 21 Mar 2022 21:41:42 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22M3fvMp010613;
        Tue, 22 Mar 2022 04:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=wRmUV8/fx86rvKFyaQM2uaHXNLf5kK5AuEdmGQ02xRs=;
 b=gofUOKbgLUnjFLR9hqwtDC61Zss3dJS7MiffTVSHCbCpH5r15wOFjsbiglfmms7065Ye
 aL24BkJ2xyOv3o0tiq14QNcM3rIae8dEG9ojciapZH+uHbXFZ9Aj9F16lXELbj6NyGHq
 2i+AVPRI/kXY6IMo5EO50fZtFw9TfG4BjMRhICoBkR2e//skTe86YzM0Gk9e9xiYV+1p
 inu0n4/xBpMN69GfZX4+buObYte6wqoPcuP+1h+EylbgqxnoWioRN9D0sukKec1pWBxu
 MF00cQhN4r5qsYtvrZiHCYJYlJGZ5Pi0GIky9hXfYh7Cec1ObDn41aJ2YvbmMeN/gCWO /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ey6s5rvmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 04:41:29 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22M4fSel019720;
        Tue, 22 Mar 2022 04:41:28 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ey6s5rvm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 04:41:28 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22M4aoBS025945;
        Tue, 22 Mar 2022 04:41:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3ew6t8mjbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 04:41:25 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22M4fN9P25559442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 04:41:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AE4D42045;
        Tue, 22 Mar 2022 04:41:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DB1642041;
        Tue, 22 Mar 2022 04:41:23 +0000 (GMT)
Received: from localhost (unknown [9.43.96.176])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Mar 2022 04:41:22 +0000 (GMT)
Date:   Tue, 22 Mar 2022 10:11:21 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, lczerner@redhat.com,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [PATCH -next] ext4: fix bug_on in start_this_handle during
 umount filesystem
Message-ID: <20220322044121.eteluohfun4j4f4y@riteshh-domain>
References: <20220322012419.725457-1-yebin10@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322012419.725457-1-yebin10@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rIMNlnvAbnN_GZ4UCRf6DT8rlBNlNGJ2
X-Proofpoint-GUID: 0xSwtFFsEJOR_bZPJxft_cCgnsXGEmRh
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_10,2022-03-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1011 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203220024
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/03/22 09:24AM, Ye Bin wrote:
> We got issue as follows:
> ------------[ cut here ]------------
> kernel BUG at fs/jbd2/transaction.c:389!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 9 PID: 131 Comm: kworker/9:1 Not tainted 5.17.0-862.14.0.6.x86_64-00001-g23f87daf7d74-dirty #197
> Workqueue: events flush_stashed_error_work
> RIP: 0010:start_this_handle+0x41c/0x1160
> RSP: 0018:ffff888106b47c20 EFLAGS: 00010202
> RAX: ffffed10251b8400 RBX: ffff888128dc204c RCX: ffffffffb52972ac
> RDX: 0000000000000200 RSI: 0000000000000004 RDI: ffff888128dc2050
> RBP: 0000000000000039 R08: 0000000000000001 R09: ffffed10251b840a
> R10: ffff888128dc204f R11: ffffed10251b8409 R12: ffff888116d78000
> R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888128dc2000
> FS:  0000000000000000(0000) GS:ffff88839d680000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000001620068 CR3: 0000000376c0e000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  jbd2__journal_start+0x38a/0x790
>  jbd2_journal_start+0x19/0x20
>  flush_stashed_error_work+0x110/0x2b3
>  process_one_work+0x688/0x1080
>  worker_thread+0x8b/0xc50
>  kthread+0x26f/0x310
>  ret_from_fork+0x22/0x30
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
>
> Above issue may happen as follows:
>       umount            read procfs            error_work
> ext4_put_super
>   flush_work(&sbi->s_error_work);
>
>                       ext4_mb_seq_groups_show
> 	                ext4_mb_load_buddy_gfp
> 			  ext4_mb_init_group
> 			    ext4_mb_init_cache
> 	                      ext4_read_block_bitmap_nowait
> 			        ext4_validate_block_bitmap
> 				  ext4_error
					^^^^^^^ I am guessing this occurred due to some error
injection framework? or was it a bad disk?

> 			            ext4_handle_error
> 			              schedule_work(&EXT4_SB(sb)->s_error_work);
>
>   ext4_unregister_sysfs(sb);
>   jbd2_journal_destroy(sbi->s_journal);
>     journal_kill_thread
>       journal->j_flags |= JBD2_UNMOUNT;
>
>                                           flush_stashed_error_work
> 				            jbd2_journal_start
> 					      start_this_handle
> 					        BUG_ON(journal->j_flags & JBD2_UNMOUNT);
>
> To solve this issue, we call 'ext4_unregister_sysfs' in 'ext4_put_super' firstly
> like 'ext4_fill_super' error handle.

I don't see a reason why not. In fact to simulate this more reliably and to add
a fstest around this - we could do following.
(If we are adding a fstest we might also explore checking other exported sysfs options
racing with umount/mount or module load/unload).
Like in past it was journal_task at [1]


Thread-1 												Thread-2
while [ 1 ]:  							   				while [ 1 ]:
  echo 1 > /sys/fs/ext4/<dev>/trigger_fs_error            umount /dev/<dev>
  sleep random 											  sleep random
  														  mount /dev/<dev> /mnt

Currently we call flush_work(&sbi->s_error_work) and then
ext4_unregister_sysfs(). So if someone triggered an fs error before
unregistering from sysfs, it will schedule_work() which might race similar
to jbd2_journal_destroy() like what you showed above.

So calling ext4_unregister_sysfs() as the first thing in ext4_put_super(),
looks good to me.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


[1]: https://lore.kernel.org/all/20200318061301.4320-1-riteshh@linux.ibm.com/


>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/super.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 81749eaddf4c..a673012e35c8 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1199,20 +1199,25 @@ static void ext4_put_super(struct super_block *sb)
>  	int aborted = 0;
>  	int i, err;
>
> -	ext4_unregister_li_request(sb);
> -	ext4_quota_off_umount(sb);
> -
> -	flush_work(&sbi->s_error_work);
> -	destroy_workqueue(sbi->rsv_conversion_wq);
> -	ext4_release_orphan_info(sb);
> -
>  	/*
>  	 * Unregister sysfs before destroying jbd2 journal.
>  	 * Since we could still access attr_journal_task attribute via sysfs
>  	 * path which could have sbi->s_journal->j_task as NULL
> +	 * Unregister sysfs before flush sbi->s_error_work.
> +	 * Since user may read /proc/fs/ext4/xx/mb_groups during umount, If
> +	 * read metadata verify failed then will queue error work.
> +	 * flush_stashed_error_work will call start_this_handle may trigger
> +	 * BUG_ON.
>  	 */
>  	ext4_unregister_sysfs(sb);
>
> +	ext4_unregister_li_request(sb);
> +	ext4_quota_off_umount(sb);
> +
> +	flush_work(&sbi->s_error_work);
> +	destroy_workqueue(sbi->rsv_conversion_wq);
> +	ext4_release_orphan_info(sb);
> +
>  	if (sbi->s_journal) {
>  		aborted = is_journal_aborted(sbi->s_journal);
>  		err = jbd2_journal_destroy(sbi->s_journal);
> --
> 2.31.1
>
