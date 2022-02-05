Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D134AA82E
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Feb 2022 11:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiBEKkm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Feb 2022 05:40:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15264 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229662AbiBEKkl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Feb 2022 05:40:41 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2154xJnT037406;
        Sat, 5 Feb 2022 10:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=f1WYbGVwEqai84r155RmLNhHHOjV6VxFSgKbWU3642A=;
 b=TLVWoP3RcVAS1UNBRmZXKgAPIuy6sirmOL216faQOZXNnDNX82FRmaxPPyYbmgz4Q+9y
 RgWbFH9mxhMD8Te48hBeLfypsJ1QSkZJQvun4gswSmpRuaQRQ9+V1PCPqMrQ+CkrZ3Ri
 ubZflZv6c6YnC4b0DpXrk4lvLp1CAYm3m5iNByEbT95T//74GMnpyjp6dQGsYuG4gGvK
 QDmaeMi1sdUjFWz/E9JvW9T6pJZNvKc6Rd6kquIrd6QxCbWTGLTaCeiTWBGxun3I9Bwy
 d/mTtT4PoII7sae6xB600R0JiiB+vzgbY3mnXb5HRsp8vuKO18jut+4VZCBBUED+prBf YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1ghqdfhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 10:40:37 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 215AeaZf010517;
        Sat, 5 Feb 2022 10:40:36 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1ghqdfha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 10:40:36 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215AWr55026466;
        Sat, 5 Feb 2022 10:40:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3e1gv8sd5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 10:40:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215AeWnM30802344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 10:40:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50D0F52054;
        Sat,  5 Feb 2022 10:40:32 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D2DA75204F;
        Sat,  5 Feb 2022 10:40:30 +0000 (GMT)
Date:   Sat, 5 Feb 2022 16:10:29 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Xin Yin <yinxin.x@bytedance.com>, harshadshirwadkar@gmail.com,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH 1/2] ext4: use ext4_ext_remove_space() for
 fast commit replay delete range
Message-ID: <20220205104029.dytcn4bhx2qyllbi@riteshh-domain>
References: <20211223032337.5198-1-yinxin.x@bytedance.com>
 <20211223032337.5198-2-yinxin.x@bytedance.com>
 <20220201203359.owrnrfqydjloy7oq@riteshh-domain>
 <CAK896s4=o9cFFnh0KzhbXSSjWiDFoTqNx0ATzGNH8rxj19+1aw@mail.gmail.com>
 <20220203211416.5jjdkk7pdaahignw@riteshh-domain>
 <20220204113639.gxz2giovjegnf62g@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204113639.gxz2giovjegnf62g@quack3.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7ItB-HQTBY_FYxy5EFRWNwUwCBSZwYV3
X-Proofpoint-ORIG-GUID: BUraN56K7HYrWhUfLRMVwt8xkzKUG_nI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_02,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202050070
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/02/04 12:36PM, Jan Kara wrote:
> On Fri 04-02-22 02:44:16, Ritesh Harjani wrote:
> > Ok, so I now know why the inode->i_size is 0 during replay phase (for file foo).
> > This is because inode->i_disksize is not really updated until after the
> > ext4_writepages() kicks in, which in this case, won't happen (for file foo)
> > when we are doing fsync on file bar. And hence fsync on file bar won't also
> > not ensure the delalloc blocks for file foo get's written out.
> >
> > In fact this above information was something that I was assuming it all
> > wrong.  Earlier I was of the opinion that fast_commit still pushes _all_
> > the dirty pagecache data of other files to disk too (which is incorrect)
> > and the only performance gains happens via less writes to disk (since we
> > write less metadata on disk).
> >
> > But I think what really happens is - In case of fast_commit when fsync is
> > called on any file (say bar), apart from that file's (bar) dirty data, it
> > only writes the necessary required metadata information of the blocks of
> > others files (in this case file foo) which are already allocated.  (which
> > in this case was due to fzero operation).  It does not actually allocate
> > the delalloc blocks due to buffered writes of any other file (other than
> > for file on which fsync is called).
>
> Yes, but that is exactly what also happens for normal commit. I.e. even
> without fastcommits, if we fsync(2), we will flush out data for that file
> but for all the other files, buffered data still stays in delalloc state in
> the page cache. Following journal commit will thus write all metadata (and
> wait for data) of the fsynced files but not for any other file that has
> only delalloc blocks. If writeback of some other file also happened before
> we commit, then yes, we include all the changes to the commit as well.
>
> > This happens in
> > ext4_fc_perform_commit() -> ext4_fc_submit_inode_data_all() ->
> > jbd2_submit_inode_data -> jbd2_journal_submit_inode_data_buffers() ->
> > generic_writepages() -> using writepage() which won't do block allocation for
> > delalloc blocks.
> >
> > So that above is what should give the major performance boost with fast_commit
> > in case of multiple file writes doing fsync. :)
> >
> > @Jan/Harshad - could you please confirm if above is correct?
>
> What you describe is correct but not special to fastcommit. As I mentioned
> on the call yesterday, fastcommit is currently beneficial only because the
> logical logging it does ends up writing much less blocks to the journal.
>

Yes, thanks for taking time to explain it again.
I got this now.

Thanks!
-ritesh


> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
