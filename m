Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822DF4DA91B
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Mar 2022 04:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244317AbiCPD5P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Mar 2022 23:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiCPD5O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Mar 2022 23:57:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5557253E04
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 20:56:01 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22G1eLXm005924;
        Wed, 16 Mar 2022 03:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=EwNPO30Jnk6GdUjZL8sQuZtpK5PGm0tk8zIT22CNn20=;
 b=ZQxxy355qDA+MabzpoJAVa6H7x5Ms3oq5pfCDbcoC3hdy0hIQwFcQ0tKqpGgwpjwljvD
 jMPlGk5HvZSdCnUcYRDa+rkCOIm9yI4/Cb9aTvZ128qh6f9XGMMyAXDnJsjWSgVqynmA
 DKgoUv9dgPKNiJot31c1PAODdiJQrrlScV2LpID4sh+i7sx9hQD3i1iiaS3tsKfnLE6s
 L4+CHeXgvzhdIpcdMh6X2HeqOKcUbdEFfxYFbScqpAJNlK9gsFZldxtWBmv/vUWKisRt
 y/16n8HIf92Gqqz/0n/i9deWkJtWJIa5HGJ29/vT1uQoSt3R1dJ4MeAXTVCzWAiI1kQ0 mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eu0a47yjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 03:55:56 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22G3tu6A017311;
        Wed, 16 Mar 2022 03:55:56 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eu0a47yjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 03:55:56 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22G3lNKV026051;
        Wed, 16 Mar 2022 03:55:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3erk58pryd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 03:55:54 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22G3tqe321168560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 03:55:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB9284C058;
        Wed, 16 Mar 2022 03:55:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69E224C046;
        Wed, 16 Mar 2022 03:55:51 +0000 (GMT)
Received: from localhost (unknown [9.43.36.69])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Mar 2022 03:55:51 +0000 (GMT)
Date:   Wed, 16 Mar 2022 09:25:49 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCHv3 05/10] ext4: Return early for non-eligible fast_commit
 track events
Message-ID: <20220316035549.y2z73orqxio4nor4@riteshh-domain>
References: <cover.1647057583.git.riteshh@linux.ibm.com>
 <3cd025d9c490218a92e6d8fb30b6123e693373e3.1647057583.git.riteshh@linux.ibm.com>
 <YjEIj/elOQ4f9qq2@mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjEIj/elOQ4f9qq2@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KxVOQXuntJpdV2uevcfF9IWKQnou7ypF
X-Proofpoint-GUID: y_0nE-ESd4VNSwKqHHNhqGmjNAfB8CaW
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_01,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=953
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160021
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/03/15 05:43PM, Theodore Ts'o wrote:
> On Sat, Mar 12, 2022 at 11:09:50AM +0530, Ritesh Harjani wrote:
> > Currently ext4_fc_track_template() checks, whether the trace event
> > path belongs to replay or does sb has ineligible set, if yes it simply
> > returns. This patch pulls those checks before calling
> > ext4_fc_track_template() in the callers of ext4_fc_track_template().
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
> I had to add the following patch to this commit in order to prevent a
> BUG when using ext4 to mount a file system without a journal.  This is
> because ext4_rename() calls the __ext4_fc_track_* functions directly,
> and moving the checks from __ext4_fc_track_* to ext4_fc_track_* would
> result in a NULL pointer dereference.

Ohk, yes. I had missed to see the callers of __ext4_fc_track_* functions.
Thanks for catching that. I just verified all other call sites too.
It seems only with ext4_fc_track_create/link/unlink we have __ext4_fc_track_*
family of functions and ext4_rename() is the only call site of __ext4_fc_track_*.

>
> 						- Ted
>
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 39e223f7bf64..e37da8d5cd0c 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3891,12 +3891,19 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  		ext4_fc_mark_ineligible(old.inode->i_sb,
>  			EXT4_FC_REASON_RENAME_DIR, handle);
>  	} else {
> +		struct super_block *sb = old.inode->i_sb;
> +
>  		if (new.inode)
>  			ext4_fc_track_unlink(handle, new.dentry);
> -		__ext4_fc_track_link(handle, old.inode, new.dentry);
> -		__ext4_fc_track_unlink(handle, old.inode, old.dentry);
> -		if (whiteout)
> -			__ext4_fc_track_create(handle, whiteout, old.dentry);
> +		if (test_opt2(sb, JOURNAL_FAST_COMMIT) &&
> +		    !(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY) &&
> +		    !(ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE))) {
> +			__ext4_fc_track_link(handle, old.inode, new.dentry);
> +			__ext4_fc_track_unlink(handle, old.inode, old.dentry);
> +			if (whiteout)
> +				__ext4_fc_track_create(handle, whiteout,
> +						       old.dentry);
> +		}
>  	}
>
>  	if (new.inode) {
>

Maybe since I pulled these checks out of ext4_fc_track_template(), so the right
call site for these checks are __ext4_fc_track_* family of functions, if they
are present, otherwise ext4_fc_track_* functions.

But that I can consolidate in later change series when I will start working on
improving error handling for fast commit. It seems at some places we don't
properly return the errors in case of fast commit to the callers.
And I guess in past this was discussed too [1]

So in order to fix the current BUG, this change looks good to me.

[1]: https://lore.kernel.org/linux-ext4/YdYotAyQqQgI+Oo+@mit.edu/

Thanks again for catching and fixing that.
-ritesh


