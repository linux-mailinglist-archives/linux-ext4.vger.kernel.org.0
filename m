Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5066A4AEF9D
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 12:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiBILD5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 06:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBILD4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 06:03:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73ACE182584;
        Wed,  9 Feb 2022 02:37:53 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2199pJdR008826;
        Wed, 9 Feb 2022 09:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=J3XPHCZHIqT70q7kPQVDpC2FjY/RM3lWg4kVQNnz0/c=;
 b=tG2VG8ipUEn2LlmLLnUSQvNlLEPKFJ0y0mTMqLezxAyu7s4mKdw8jlCHmfO4nWhZfWMc
 SYv5gDZIxj+VLAMGSupziEsDrvtTYiMh5iizRbKNcFBjadFuaz0dlBhGm4ld6yDi6rkS
 J12MEMnWCKeQolVNdoZPIr/nIe52hUzsbfvKDuyNrCRjN6LgezMKgEYrDPwhZP7RkIRS
 cQvd1rKTPdGvX1hd2RqZ8Xx3C2TndHz1Ut/deaSsBwqCbctArhDkN/13VqRXmrdrh//S
 DC/oluoqEcj83qNs9JmwLjWm3epV+o+t7RK/5SIFeR1XUOqOeXZhDdoU/sR0xoKVGYFL sg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e48c14c3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 09:56:54 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2199ojtW015979;
        Wed, 9 Feb 2022 09:56:52 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3e1gv9ngxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 09:56:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2199unqQ43057648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Feb 2022 09:56:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22C7BA406D;
        Wed,  9 Feb 2022 09:56:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC172A4076;
        Wed,  9 Feb 2022 09:56:48 +0000 (GMT)
Received: from localhost (unknown [9.43.74.163])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Feb 2022 09:56:48 +0000 (GMT)
Date:   Wed, 9 Feb 2022 15:26:47 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com>,
        jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] KASAN: use-after-free Read in jbd2_journal_wait_updates
Message-ID: <20220209095615.rhoizbwcn3kbazzq@riteshh-domain>
References: <00000000000040c94205d78125af@google.com>
 <20220208161429.6oviyrpovqpcwpz5@quack3.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208161429.6oviyrpovqpcwpz5@quack3.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bwRtskWy5D1CAKgQ7hguNkJLsZKPUnhE
X-Proofpoint-ORIG-GUID: bwRtskWy5D1CAKgQ7hguNkJLsZKPUnhE
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_04,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=906
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202090062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/02/08 05:14PM, Jan Kara wrote:
> On Tue 08-02-22 04:49:19, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    555f3d7be91a Merge tag '5.17-rc3-ksmbd-server-fixes' of gi..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17e55852700000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=88e0a6a3dbf057cf
> > dashboard link: https://syzkaller.appspot.com/bug?extid=afa2ca5171d93e44b348
> > compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b03872700000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com
>
> So the syzbot reproducer looks bogus to me but the bug is real.
> jbd2_journal_wait_updates() looks at commit_transaction after dropping
> j_state_lock and sleeping which is certainly prone to use-after-free
> issues.

Yes, thanks for taking a look at it.

>
> Funnily, Ritesh's removal of t_handle_lock should "fix" the problem by
> removing this dereference. So Ritesh, please just add some reference to
> syzbot report and maybe a backport to stable would be warranted.
>

This actually looks like a regression because of commit [1].
So I am thinking of sending a separate patch [2] as a fix for this (after my
testing).

Not sure why fstests testing didn't pick this up (given it's a common race),
or is it because of my recent removal of CONFIG_KASAN from my testing :(

I will try a full "auto" test with CONFIG_KASAN enabled and see if we could hit
this in fstests or not. If not then I will work towards adding a targetted test
to capture such race.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=origin&id=4f98186848707f530669238d90e0562d92a78aab
[2]: https://github.com/riteshharjani/linux/commit/628648810011a22dfaba38ead49716720b27a31c

-ritesh
