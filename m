Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DD622F5A8
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 18:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgG0Qqa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 12:46:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbgG0Qqa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 12:46:30 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RGVRQR160869;
        Mon, 27 Jul 2020 12:46:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32j0a4w9p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 12:46:27 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06RGVbjw162055;
        Mon, 27 Jul 2020 12:46:27 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32j0a4w9n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 12:46:27 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06RGjBtu026077;
        Mon, 27 Jul 2020 16:46:25 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 32gcy4jf4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 16:46:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06RGkNVV31457606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 16:46:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B0624C058;
        Mon, 27 Jul 2020 16:46:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B88874C044;
        Mon, 27 Jul 2020 16:46:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.112])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jul 2020 16:46:22 +0000 (GMT)
Subject: Re: [PATCH] ext4: handle option set by mount flags correctly
To:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
References: <20200723150526.19931-1-lczerner@redhat.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 27 Jul 2020 22:16:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200723150526.19931-1-lczerner@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200727164622.B88874C044@d06av22.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_11:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270111
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 7/23/20 8:35 PM, Lukas Czerner wrote:
> Currently there is a problem with mount options that can be both set by
> vfs using mount flags or by a string parsing in ext4.
> 
> i_version/iversion options gets lost after remount, for example
> 
> $ mount -o i_version /dev/pmem0 /mnt
> $ grep pmem0 /proc/self/mountinfo | grep i_version
> 310 95 259:0 / /mnt rw,relatime shared:163 - ext4 /dev/pmem0 rw,seclabel,i_version
> $ mount -o remount,ro /mnt
> $ grep pmem0 /proc/self/mountinfo | grep i_version
> 
> nolazytime gets ignored by ext4 on remount, for example
> 
> $ mount -o lazytime /dev/pmem0 /mnt
> $ grep pmem0 /proc/self/mountinfo | grep lazytime
> 310 95 259:0 / /mnt rw,relatime shared:163 - ext4 /dev/pmem0 rw,lazytime,seclabel
> $ mount -o remount,nolazytime /mnt
> $ grep pmem0 /proc/self/mountinfo | grep lazytime
> 310 95 259:0 / /mnt rw,relatime shared:163 - ext4 /dev/pmem0 rw,lazytime,seclabel
> 
> Fix it by applying the SB_LAZYTIME and SB_I_VERSION flags from *flags to
> s_flags before we parse the option and use the resulting state of the
> same flags in *flags at the end of successful remount.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Looks good to me. I did some small unit testing to observe the
behavior. Below logs are *with your patch applied* for nolazytime e.g.
which you referred above. But without your patch, as you mentioned
nolazytime was not taking into effect.

           mount  8635 [007]  5477.595642:      probe:ext4_remount: 
(ffffffff813bd270) s_flags=0x72810000 flags=0x0 data_string="i_version"
            mount  8635 [007]  5477.595672:  probe:ext4_remount_L55: 
(ffffffff813bd3d1) s_flags=0x70010000 flags=0x0 data_string="i_version"
            mount  8635 [007]  5477.595758: probe:ext4_remount_L217: 
(ffffffff813bd787) s_flags=0x70810000 flags=0x0
            mount  8635 [007]  5477.595772: probe:ext4_remount_L246: 
(ffffffff813bd820) s_flags=0x70810000 flags=0x800000



Please feel free to add.
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/super.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 330957ed1f05..caab4c57f909 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5445,7 +5445,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>   {
>   	struct ext4_super_block *es;
>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
> -	unsigned long old_sb_flags;
> +	unsigned long old_sb_flags, vfs_flags;
>   	struct ext4_mount_options old_opts;
>   	int enable_quota = 0;
>   	ext4_group_t g;
> @@ -5488,6 +5488,14 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>   	if (sbi->s_journal && sbi->s_journal->j_task->io_context)
>   		journal_ioprio = sbi->s_journal->j_task->io_context->ioprio;
> 
> +	/*
> +	 * Some options can be enabled by ext4 and/or by VFS mount flag
> +	 * either way we need to make sure it matches in both *flags and
> +	 * s_flags. Copy those selected flags from *flags to s_flags
> +	 */
> +	vfs_flags = SB_LAZYTIME | SB_I_VERSION;
> +	sb->s_flags = (sb->s_flags & ~vfs_flags) | (*flags & vfs_flags);
> +
>   	if (!parse_options(data, sb, NULL, &journal_ioprio, 1)) {
>   		err = -EINVAL;
>   		goto restore_opts;
> @@ -5541,9 +5549,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>   		set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
>   	}
> 
> -	if (*flags & SB_LAZYTIME)
> -		sb->s_flags |= SB_LAZYTIME;
> -
>   	if ((bool)(*flags & SB_RDONLY) != sb_rdonly(sb)) {
>   		if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED) {
>   			err = -EROFS;
> @@ -5675,7 +5680,13 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>   	}
>   #endif
> 
> -	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
> +	/*
> +	 * Some options can be enabled by ext4 and/or by VFS mount flag
> +	 * either way we need to make sure it matches in both *flags and
> +	 * s_flags. Copy those selected flags from s_flags to *flags
> +	 */
> +	*flags = (*flags & ~vfs_flags) | (sb->s_flags & vfs_flags);
> +
>   	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s", orig_data);
>   	kfree(orig_data);
>   	return 0;
> 
