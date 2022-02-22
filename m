Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1764C0343
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Feb 2022 21:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiBVUrA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Feb 2022 15:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiBVUq7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Feb 2022 15:46:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A688B624E;
        Tue, 22 Feb 2022 12:46:33 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MIfjDV020712;
        Tue, 22 Feb 2022 20:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=35C+yewWMlC4Z/cwVL3/lfNPO1iEc5w3khMa9qU8uI4=;
 b=VtWV6tvXFV3yMSn9zzgM+KNV5ZbhiLCXsvJHqb3rJs7/qnrO3Z/g2Xv9t3pcpygC4xPJ
 3QX3dolWMI3/3OhmEWOsZ9wW3MO7US2J74ek6uzwaSFG+4vhDschkm8JMSQo83sq+ETL
 MU5KdCSrTCLfSFgJLr8oahAd8uM46z0kfrJUrD6prmpsjowe8RXYS3U2AIKYrAjwqc+V
 t7+wAAhuECRXHMFcllpaeVM2xEg7dGa2x6S1ca2UKaqRBku6TWIt0qGwdzRi5f99iJdk
 iPZ43OKtSSUIeWsgVQzPt2wtE0hbP9JszIn3vdppAZSEKMdA1QXt9Y/eig11ICFBCE6H 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed5b5tt3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:46:14 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21MKe6Bw001643;
        Tue, 22 Feb 2022 20:46:13 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed5b5tt23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:46:13 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MKblDa023459;
        Tue, 22 Feb 2022 20:46:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3eaqtjmey0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 20:46:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MKk63o53281278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 20:46:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48B6142047;
        Tue, 22 Feb 2022 20:46:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BC7B42041;
        Tue, 22 Feb 2022 20:46:04 +0000 (GMT)
Received: from localhost (unknown [9.43.75.136])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 20:46:03 +0000 (GMT)
Date:   Wed, 23 Feb 2022 02:16:00 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [BUG] NEVER dereference pointers from the tracing ring buffer!
Message-ID: <20220222204600.mgtt3ihtvlptjh2l@riteshh-domain>
References: <20220221160916.333e6491@rorschach.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221160916.333e6491@rorschach.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rFtQjqEPrjDweGJ9f8F5O8wXU2OqoHVh
X-Proofpoint-ORIG-GUID: PL_mEdTkCSj-YOv9mJxir30XBSKhSpTR
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_07,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/02/21 04:09PM, Steven Rostedt wrote:
> While working on libtraceevent, it stumbled over a "->" in the print
> formats that wasn't parsing properly. Well, the reason it does not
> handle this particular case is because it is A MAJOR BUG IN THE KERNEL!
>
> DO NOT DEREFERENCE ANYTHING FROM THE RING BUFFER.
>
> Sorry, for yelling, but I really want to stress this is not something
> to do. The ring buffer is referenced seconds, minutes, hours, days,
> months after the data has been loaded. This is the same as using
> something after it is freed. Just don't do it.
>
> The culprit is:
>
>   ext4_fc_stats
>
> Introduced by: aa75f4d3daaeb ("ext4: main fast-commit commit path")
>
> That has in its print fmt in include/trace/events/ext4.h:
>
>
>             TP_printk("dev %d:%d fc ineligible reasons:\n"
>                       "%s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d; "
>                       "num_commits:%ld, ineligible: %ld, numblks: %ld",
>                       MAJOR(__entry->dev), MINOR(__entry->dev),
>                       FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
>                       FC_REASON_NAME_STAT(EXT4_FC_REASON_CROSS_RENAME),
>                       FC_REASON_NAME_STAT(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE),
>                       FC_REASON_NAME_STAT(EXT4_FC_REASON_NOMEM),
>                       FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
>                       FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
>                       FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
>                       FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
>                       FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
>                       __entry->sbi->s_fc_stats.fc_num_commits,
>                       __entry->sbi->s_fc_stats.fc_ineligible_commits,
>                       __entry->sbi->s_fc_stats.fc_numblks)
>
> That __entry->sbi can be LONG GONE by the time it is read. You have no
> idea what it is pointing to. And even if it is still around, there's no
> way that any of those numbers are accurate from the time the event
> triggered. Might as well just expose them by some other interface.

Thanks Steven for spotting this and providing details of the problem.
I have submitted a patch to fix this problem at [1].
But I am facing a small challenge w.r.t __array field type w.r.t perf record
which I have explained in the cover letter.
Would it be possible for you to take a look at it [2] and also at the patch [1].

Thanks a lot for your help!!

[1]: https://lore.kernel.org/all/9a8c359270a6330ed384ea0a75441e367ecde924.1645558375.git.riteshh@linux.ibm.com/
[2]: https://lore.kernel.org/all/cover.1645558375.git.riteshh@linux.ibm.com/


-ritesh

>
> This event must be modified or removed from the current release and all
> stable kernels that have it.
>
> In the mean time, I need to update my event verifier to detect this and
> fail to register the event if it has such cases.
>
> -- Steve
