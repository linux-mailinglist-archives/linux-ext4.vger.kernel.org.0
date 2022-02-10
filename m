Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43F24B1224
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Feb 2022 16:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbiBJP5V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Feb 2022 10:57:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbiBJP5U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Feb 2022 10:57:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34EDC2B;
        Thu, 10 Feb 2022 07:57:21 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AFGMCD005994;
        Thu, 10 Feb 2022 15:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=1pu2Y6xdqrlXEaJ0s3ajV0bIYrEcsZn2fk0EBgAjuWg=;
 b=EsYOrR6puuXJSJfQvlzxX07xMyXtp8ZVYv4Wg8bLDg/i/9MptlBdS9MCi+svmH7n7QSw
 fWL0hYP1+JcCGQe99sTq0Y+oladGgQFsLxYDF6r6KskQdgTocu5MD3QadRAUPuKEPDp0
 /T8aQo9K/hiKCiTjXG1NzODbLlF4z3KcKzj5V6Le5Rb1BYPOpEJwZMpy3gDhT5gJNPW0
 yxX6FpremEBy2oJDiqzBm5ozWP7OsPzs4yBbMWgdfQSpAZwmuXRE0M78yCbP8tyYdLOq
 QkghU6uq06vHUTDPAtgVr1Hy9PRoGpUHF/cr25UnqhcA77Mq2Xrbp2dR0JwFiIgXTLbk ZA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e4y7bjcxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 15:57:11 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21AFm6UZ008262;
        Thu, 10 Feb 2022 15:57:09 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggkhvpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 15:57:09 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21AFv6o645351408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 15:57:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C833A52057;
        Thu, 10 Feb 2022 15:57:06 +0000 (GMT)
Received: from localhost (unknown [9.43.74.163])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5A4585204E;
        Thu, 10 Feb 2022 15:57:06 +0000 (GMT)
Date:   Thu, 10 Feb 2022 21:27:05 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com>,
        jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] KASAN: use-after-free Read in jbd2_journal_wait_updates
Message-ID: <20220210155705.oknqttt7qtynjkwi@riteshh-domain>
References: <00000000000040c94205d78125af@google.com>
 <20220208161429.6oviyrpovqpcwpz5@quack3.lan>
 <20220209095615.rhoizbwcn3kbazzq@riteshh-domain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209095615.rhoizbwcn3kbazzq@riteshh-domain>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H4cq_VCad-sA1UogXl43ADc2x6syBrlQ
X-Proofpoint-GUID: H4cq_VCad-sA1UogXl43ADc2x6syBrlQ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_06,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/02/09 03:26PM, Ritesh Harjani wrote:
> On 22/02/08 05:14PM, Jan Kara wrote:
> > On Tue 08-02-22 04:49:19, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    555f3d7be91a Merge tag '5.17-rc3-ksmbd-server-fixes' of gi..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17e55852700000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=88e0a6a3dbf057cf
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=afa2ca5171d93e44b348
> > > compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b03872700000
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com
> >
> > So the syzbot reproducer looks bogus to me but the bug is real.
> > jbd2_journal_wait_updates() looks at commit_transaction after dropping
> > j_state_lock and sleeping which is certainly prone to use-after-free
> > issues.
>
> Yes, thanks for taking a look at it.
>
> >
> > Funnily, Ritesh's removal of t_handle_lock should "fix" the problem by
> > removing this dereference. So Ritesh, please just add some reference to
> > syzbot report and maybe a backport to stable would be warranted.
> >
>
> This actually looks like a regression because of commit [1].
> So I am thinking of sending a separate patch [2] as a fix for this (after my
> testing).
>
> Not sure why fstests testing didn't pick this up (given it's a common race),
> or is it because of my recent removal of CONFIG_KASAN from my testing :(
>
> I will try a full "auto" test with CONFIG_KASAN enabled and see if we could hit
> this in fstests or not. If not then I will work towards adding a targetted test
> to capture such race.

FWIW, I did try "auto" run with CONFIG_KASAN enabled (which took hell lot of
a time to complete :-|) w/o the fix. But it didn't hit this race.

Then, I also tried below combination of dirtying some data and calling
checkpoint_journal in seperate thread, but I wasn't able to hit this race.
(Using checkpoint_journal since it will call for jbd2_journal_lock_updates())

sudo mount /dev/loop2 /mnt

Terminal-1  # Tried other combination of higher D, n & S0/1/2, s0/100/4096
===========
qemu-> echo /mnt/{1..32} |sed -E 's/[[:space:]]+/ -d /g' | xargs -I {} bash -c "sudo fs_mark -L 100000 -D 4 -n 4 -s 100 -S0 -d {}"

Terminal-2
=============
qemu-> while [ 1 ]; do sudo ./src/checkpoint_journal /mnt; sleep 5; done

Also, I did made other failed attempts with some combinations of running fs_mark with freeze/unfreeze
(similar to checkpoint_journal), and also changing "commit=1" mount option to
see if we could hit the race with some such combo.

So if anyone else has any suggestions on what else can we try to hit this race,
so that we can add such test case to fstests, I will be happy to attempt it.

-ritesh


>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=origin&id=4f98186848707f530669238d90e0562d92a78aab
> [2]: https://github.com/riteshharjani/linux/commit/628648810011a22dfaba38ead49716720b27a31c
>
> -ritesh
